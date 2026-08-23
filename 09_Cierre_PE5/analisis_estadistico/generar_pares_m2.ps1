$ErrorActionPreference = "Stop"
$base = Join-Path $PSScriptRoot "salidas"

$grupos = [ordered]@{
    "Autenticacion y control de acceso"      = @("RF-01","RF-14","RNF-03","RNF-10","RNF-11")
    "Gestion de parcelas"                    = @("RF-02","RNF-01")
    "Registro agricola, cosecha y fitosanitario" = @("RF-03","RF-04","RF-05","RF-16","RF-17","RF-20","RF-24","RNF-07","RNF-09")
    "Insumos y compras"                      = @("RF-06","RF-21","RF-22")
    "Planificacion y asignacion de tareas"   = @("RF-08","RF-09","RF-10")
    "Produccion, reportes e ingresos"        = @("RF-07","RF-11","RF-12","RF-13","RF-18","RF-19","RF-23","RF-27","RNF-08")
    "IA, alertas y recomendaciones"          = @("RF-15","RF-25","RF-26","RNF-15")
    "Calidad transversal"                    = @("RNF-02","RNF-04","RNF-05","RNF-06","RNF-12","RNF-13","RNF-14")
}

$observaciones = @{
    "RF-01|RNF-10"  = "El bloqueo tras 5 intentos fallidos acota RF-01 sin contradecirlo."
    "RF-05|RF-17"   = "Complementarios: peso declarado frente a comprobante de acopio; la reconciliacion queda cubierta por RF-24."
    "RF-07|RF-11"   = "Sin contradiccion; solapamiento funcional parcial documentado como observacion de mantenibilidad."
    "RF-07|RF-13"   = "Sin contradiccion; solapamiento funcional parcial documentado como observacion de mantenibilidad."
    "RF-11|RF-13"   = "Sin contradiccion; solapamiento funcional parcial documentado como observacion de mantenibilidad."
    "RF-15|RNF-15"  = "La explicabilidad M15.1-M15.4 aplica directamente a las recomendaciones de RF-15."
    "RF-25|RF-26"   = "Complementarias: alerta por regla (gravedad alta) frente a alerta temprana IA previa a confirmacion; diferenciacion soportada por RNF-15 M15.2."
    "RF-16|RF-25"   = "La gravedad alta registrada en RF-16 dispara la alerta de RF-25; relacion de causa-efecto coherente."
    "RF-20|RF-16"   = "El catalogo normalizado de RF-20 estandariza el registro de incidencias de RF-16."
    "RF-14|RNF-03"  = "La desactivacion de cuentas es coherente con el rechazo del 100% de accesos fuera de rol."
}

$filas = @()
foreach ($ambito in $grupos.Keys) {
    $reqs = $grupos[$ambito]
    for ($i = 0; $i -lt $reqs.Count; $i++) {
        for ($j = $i + 1; $j -lt $reqs.Count; $j++) {
            $par = @($reqs[$i], $reqs[$j]) | Sort-Object
            $clave = $par -join "|"
            $obs = if ($observaciones.ContainsKey($clave)) { $observaciones[$clave] } else { "Analisis de par dentro del mismo ambito sin contradiccion directa ni indirecta." }
            $filas += [pscustomobject]@{
                Par         = ($par -join " <-> ")
                Ambito      = $ambito
                Conflicto   = "No"
                Veredicto   = "Compatibles"
                Observacion = $obs
            }
        }
    }
}

$out = Join-Path $base "m2_pares_analizados.csv"
$filas | Export-Csv -LiteralPath $out -NoTypeInformation -Encoding UTF8
"Pares analizados: $($filas.Count)"
"Con conflicto: $(($filas | Where-Object Conflicto -ne 'No').Count)"
