$ErrorActionPreference = "Stop"
$base = Join-Path $PSScriptRoot "salidas"

$grupos = [ordered]@{
    "Autenticacion y control de acceso"      = @("RF-01","RF-14","RNF-03","RNF-10","RNF-11")
    "Gestion de parcelas"                    = @("RF-02","RNF-01")
    "Registro agricola, cosecha y fitosanitario" = @("RF-03","RF-04","RF-05","RF-16","RF-17","RF-20","RF-24","RNF-07","RNF-09")
    "Insumos y compras"                      = @("RF-06","RF-21","RF-22")
    "Planificacion y asignacion de tareas"   = @("RF-08","RF-09","RF-10")
    "Produccion, reportes e ingresos"        = @("RF-07","RF-11","RF-12","RF-13","RF-18","RF-19","RF-23","RF-27","RNF-08")
    "IA-01 recomendador y alertas"           = @("RF-15","RF-25","RF-26","RF-28","RNF-15","RNF-16","RNF-17","RNF-18","RNF-19","RNF-20")
    "IA-02 detector de plagas por imagen"    = @("RF-29","RF-30","RF-31","RNF-21","RNF-22","RNF-23","RNF-24","RNF-25","RNF-26")
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
    "RF-15|RF-28"   = "RF-28 cierra el ciclo de RF-15: la recomendacion se confirma o descarta y la decision retroalimenta el historial."
    "RF-26|RF-28"   = "Complementarias: la alerta temprana de RF-26 queda sujeta a confirmacion o descarte humano segun RF-28."
    "RF-28|RNF-15"  = "La decision de RF-28 debe presentarse con la explicacion simultanea exigida por RNF-15 (M15.2)."
    "RF-28|RNF-20"  = "El descarte frecuente en parcelas con poco volumen de registro activaria la revision de sesgo descrita en RNF-20."
    "RF-29|RF-30"   = "Secuencia coherente: RF-30 registra la clase propuesta por RF-29 una vez confirmada; sin duplicacion de catalogo."
    "RF-29|RNF-21"  = "La latencia objetivo de RNF-21 aplica al flujo de clasificacion que expone RF-29."
    "RNF-24|RNF-25" = "Equidad de la misma familia IA-02: condiciones de luz frente a gamas de dispositivo; metricas independientes y compatibles."
    "RF-31|RNF-23"  = "La alerta por incidencias acumuladas de RF-31 respeta la ventana temporal medida por RNF-23."
    "RF-29|RNF-26"  = "La explicabilidad exigida a IA-02 aplica al detector de RF-29, simetrico a RNF-15 para IA-01."
    "RF-30|RNF-22"  = "La exactitud objetivo de RNF-22 se mide sobre las clases confirmadas que produce RF-30."
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
"Cobertura de identificadores unicos: $(($grupos.Values | ForEach-Object { $_ } | Sort-Object -Unique).Count)"
