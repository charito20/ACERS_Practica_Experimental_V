param(
    [string]$ErsPath = (Join-Path $PSScriptRoot "..\..\01_ERS\ERS_SRS_2A_v1.0.tex"),
    [string]$OutDir = (Join-Path $PSScriptRoot "salidas")
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $ErsPath)) { throw "No se encontro el ERS en: $ErsPath" }
if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }

$tex = Get-Content -LiteralPath $ErsPath -Raw -Encoding UTF8

function Get-Cards {
    param([string]$Text, [string]$Prefix)

    $headerRegex = [regex]('(?m)^\\noindent\\textbf\{' + $Prefix + '-(\d{2})\.\s*(.*?)\}\s*$')
    $headers = $headerRegex.Matches($Text)
    $cards = @()

    for ($i = 0; $i -lt $headers.Count; $i++) {
        $start = $headers[$i].Index + $headers[$i].Length
        $end = if ($i -lt $headers.Count - 1) { $headers[$i + 1].Index } else { $Text.Length }
        $body = $Text.Substring($start, $end - $start)
        $cards += [pscustomobject]@{
            Id       = ($Prefix + '-' + $headers[$i].Groups[1].Value)
            Titulo   = $headers[$i].Groups[2].Value.Trim()
            Cuerpo   = $body
        }
    }
    return ,$cards
}

function Get-Fila {
    param([string]$Body, [string]$Label)
    $pattern = '(?m)^\s*' + [regex]::Escape($Label) + '[^&\r\n]*&\s*(.*?)\s*\\\\'
    $m = [regex]::Match($Body, $pattern)
    if ($m.Success) { return $m.Groups[1].Value.Trim() }
    return ""
}

function Convert-ToCsvRow {
    param([string]$Value)
    return '"' + ($Value -replace '"', '""') + '"'
}

$rfs = Get-Cards -Text $tex -Prefix "RF"
$rnfs = Get-Cards -Text $tex -Prefix "RNF"

$filasRF = @()
foreach ($card in $rfs) {
    $origen = Get-Fila -Body $card.Cuerpo -Label "Actor / origen"
    $criterio = Get-Fila -Body $card.Cuerpo -Label "Criterio de verificaci"
    $filasRF += [pscustomobject]@{
        Id              = $card.Id
        Nombre          = $card.Titulo
        Descripcion     = Get-Fila -Body $card.Cuerpo -Label "Descripci"
        ActorOrigen     = $origen
        Entradas        = Get-Fila -Body $card.Cuerpo -Label "Entradas"
        Salidas         = Get-Fila -Body $card.Cuerpo -Label "Salidas"
        Prioridad       = Get-Fila -Body $card.Cuerpo -Label "Prioridad (MoSCoW)"
        CriterioVerif   = $criterio
        TieneFuente     = [bool]([regex]::IsMatch($origen, 'EV-\d{2}|R-\d{2}|RD-\d{2}|UC-\d{2}'))
        TienePrioridad  = [bool]($card.Cuerpo -match 'Prioridad \(MoSCoW\)')
        TieneCriterio   = [bool]$criterio
        CriterioConUmbral = [bool]([regex]::IsMatch($criterio, '\\leq|\\geq|m.axim|m.nim|\d+([.,]\d+)?\s*(s|ms|%|~\\%|min)|percentil|\d+\s*de\s*\d+'))
    }
}

$filasRNF = @()
foreach ($card in $rnfs) {
    $origen = Get-Fila -Body $card.Cuerpo -Label "Origen"
    $valorObj = Get-Fila -Body $card.Cuerpo -Label "Valor objetivo"
    $metodo = Get-Fila -Body $card.Cuerpo -Label "M" + [char]0x00E9 + "todo de medici"
    $filasRNF += [pscustomobject]@{
        Id                = $card.Id
        Nombre            = $card.Titulo
        CaracteristicaISO = Get-Fila -Body $card.Cuerpo -Label "Caracter"
        Subcaracteristica = Get-Fila -Body $card.Cuerpo -Label "Subcaracter"
        Metrica           = Get-Fila -Body $card.Cuerpo -Label "M" + [char]0x00E9 + "trica"
        ValorObjetivo     = $valorObj
        MetodoMedicion    = $metodo
        Origen            = $origen
        Prioridad         = Get-Fila -Body $card.Cuerpo -Label "Prioridad"
        TieneFuente       = [bool]([regex]::IsMatch($origen, 'EV-\d{2}|R-\d{2}|RD-\d{2}|UC-\d{2}|ISO|RF-\d{2}'))
        TieneValorObjetivo= [bool]([regex]::IsMatch($valorObj, '\\leq|\\geq|m.axim|m.nim|\d+([.,]\d+)?\s*(s|ms|%|~\\%)|\d+\s*de\s*\d+|\d+\s*intentos|\d+\s*m.dulos'))
        TieneMetodo       = [bool]$metodo
    }
}

$hus = [regex]::Matches($tex, 'HU-(\d{2})\s*\\textperiodcentered\s*\\?\s*deriva de RF-(\d{2})') |
    ForEach-Object { [pscustomobject]@{ Hu = "HU-" + $_.Groups[1].Value; DerivaDe = "RF-" + $_.Groups[2].Value } } |
    Sort-Object Hu -Unique

$caTotal = ([regex]::Matches($tex, '\bCA-\d{2}\.\d{1}') | ForEach-Object Value | Sort-Object -Unique).Count

$outInvRF = Join-Path $OutDir "inventario_rf.csv"
$outInvRNF = Join-Path $OutDir "inventario_rnf.csv"
$outHU = Join-Path $OutDir "historias_usuario.csv"

$filasRF | Export-Csv -LiteralPath $outInvRF -NoTypeInformation -Encoding UTF8
$filasRNF | Export-Csv -LiteralPath $outInvRNF -NoTypeInformation -Encoding UTF8
$hus | Export-Csv -LiteralPath $outHU -NoTypeInformation -Encoding UTF8

$totalRF = $filasRF.Count
$totalRNF = $filasRNF.Count
$m1aNum = ($filasRF | Where-Object { $_.TieneFuente -and $_.TienePrioridad -and $_.TieneCriterio }).Count +
          (($filasRNF | Where-Object { $_.TieneFuente -and $_.TieneValorObjetivo -and $_.TieneMetodo }).Count)
$m1aDen = $totalRF + $totalRNF

$resumen = [ordered]@{
    total_RF = $totalRF
    total_RNF = $totalRNF
    total_requisitos = $m1aDen
    RF_con_fuente = ($filasRF | Where-Object TieneFuente).Count
    RNF_con_origen = ($filasRNF | Where-Object TieneFuente).Count
    RF_con_prioridad = ($filasRF | Where-Object TienePrioridad).Count
    RF_con_criterio = ($filasRF | Where-Object TieneCriterio).Count
    RF_criterio_con_umbral = ($filasRF | Where-Object CriterioConUmbral).Count
    RNF_con_valor_objetivo = ($filasRNF | Where-Object TieneValorObjetivo).Count
    RNF_con_metodo_medicion = ($filasRNF | Where-Object TieneMetodo).Count
    historias_usuario = $hus.Count
    escenarios_CA_unicos = $caTotal
    M1a_numerador_atributos_completos = $m1aNum
    M1a_denominador_total_requisitos = $m1aDen
}

$resumen.GetEnumerator() | ForEach-Object { "{0};{1}" -f $_.Key, $_.Value } |
    Set-Content -LiteralPath (Join-Path $OutDir "resumen_conteos.csv") -Encoding UTF8

$resumen.GetEnumerator() | ForEach-Object { "{0,-36} {1}" -f $_.Key, $_.Value }
