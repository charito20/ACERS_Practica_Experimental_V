# Bloques de datos de entrenamiento, métricas de éxito y plan de monitoreo

Aporte al Paso 3 (fichas 7.3 del informe) para los dos componentes de IA del SGA.
Este documento cubre los bloques (b), (c) y (e) descritos en la guía: datos de
entrenamiento, métricas de éxito y plan de monitoreo. La redacción de los RF y RNF,
la justificación del segundo componente y la clasificación de riesgo corresponde a
Kamila; si el componente IA-02 se especifica con otro alcance, solo hay que ajustar
el volumen de datos y los umbrales de la ficha correspondiente.

Los bloques se derivan de requisitos y evidencias ya trazadas en el ERS:
EV-01 [09:02] y [09:10] (confianza condicionada a verificación), EV-01 [08:17]
(reporte de pérdidas por plagas como el más importante), EV-02 [02:33] (perfil del
jornalero sin apps), RF-15, RF-16, RF-20, RF-25, RF-26 y RNF-15.

---

## IA-01 — Alertas tempranas y recomendaciones de manejo

Componente ya presente en el ERS: genera recomendaciones de manejo (RF-15),
alertas automáticas por reglas (RF-25) y alerta temprana de posible enfermedad a
partir de patrones en los registros históricos de la parcela (RF-26), todas sujetas
a confirmación humana (R-05) y con explicabilidad obligatoria (RNF-15).

### Datos de entrenamiento requeridos

| Aspecto | Especificación |
|---|---|
| Origen | Registros propios del sistema: producciones (RF-05), labores (RF-04), enfermedades (RF-16), inventario (RF-06) y entregas (RF-22). Para la puesta en marcha, digitalización controlada de la bitácora en papel que hoy lleva el administrador (EV-01 [02:04], [02:17]). No se usan datos de terceros. |
| Volumen estimado | Mínimo operativo de 500 registros productivos por ciclo anual de evaluación (umbral ya usado en los criterios de verificación de las consultas). Por debajo de ese volumen el componente opera en modo solo reglas (RF-25) sin capa predictiva. |
| Variables | Parcela, cultivo, variedad, fecha, tipo de labor, cantidad cosechada con unidad (RNF-07), enfermedad registrada con gravedad, inventario disponible. Sin datos biométricos ni de localización de personas. |
| Etiquetado | Las etiquetas surgen del uso: cada alerta temprana (RF-26) es confirmada o descartada por el administrador antes de actuar (R-05, EV-01 [09:02]), y esa decisión queda registrada como etiqueta positiva o negativa. Etiquetado sin costo adicional de anotación manual. |
| Calidad mínima | Completitud del 100 % en los campos obligatorios de los formularios de origen; registros de cosecha con unidad correcta según cultivo (RNF-07); fecha válida dentro del ciclo productivo. |
| Sesgos conocidos | Subregistro de enfermedades leves: el jornalero reporta lo visible en su parcela asignada (EV-02 [01:34]), por lo que las parcelas revisadas con más frecuencia acumulan más incidencias. Desbalance entre parcelas pequeñas y grandes. Estacionalidad climática de Quevedo (pico de presión fitosanitaria en invierno). Mitigación: ponderar la tasa de alertas por frecuencia de revisión de la parcela y evaluar siempre sobre un conjunto estratificado por mes. |
| Base legal (LOPDP) | Los registros de labores contienen datos personales del jornalero (identificador, actividad, parcela). Tratamiento amparado en la ejecución de la relación laboral y el interés legítimo de gestión agrícola (Art. 8 LOPDP), con finalidad declarada de planificación productiva; no se usan para evaluación individual del trabajador. Conservación de 5 años, coherente con el historial que exige RF-24. |
| Política de conservación | Los agregados productivos se conservan indefinidamente; los registros con dato personal identificable se anonimizan tras 5 años manteniendo los agregados por parcela. |

### Métricas de éxito del modelo

| Métrica | Umbral | Conjunto de evaluación | Método |
|---|---|---|---|
| Exactitud de la alerta temprana | ≥ 70 % | Al menos 30 casos etiquetados por confirmación en campo | El ya fijado en RF-26; medición mensual acumulada |
| Precisión de recomendaciones (aceptación) | ≥ 80 % de recomendaciones aceptadas o aceptadas con ajuste menor | 20 solicitudes de recomendación (muestra del criterio de RF-15) | Registro de la decisión del administrador sobre cada recomendación presentada |
| Tasa de falsos positivos de alerta | ≤ 30 % de las alertas descartadas | Registro trimestral de alertas confirmadas vs descartadas | Conteo directo del registro de decisiones |
| Latencia de inferencia | ≤ 5,0 s (ya fijado en RF-15) | Percentil 95 sobre 20 solicitudes | Medición del tiempo de respuesta del módulo |

### Plan de monitoreo

| Elemento | Especificación |
|---|---|
| Indicadores en producción | Tasa de aceptación de recomendaciones; proporción de alertas descartadas; porcentaje de parcelas con volumen de datos suficiente para la capa predictiva |
| Frecuencia de medición | Mensual, sobre el registro de decisiones del administrador |
| Umbral de alerta por deriva | Caída de más de 10 puntos porcentuales en la exactitud de alerta respecto del mes anterior, o tasa de aceptación inferior al 60 % durante dos meses consecutivos |
| Criterio de reentrenamiento | Al cumplirse cualquier umbral de deriva, reentrenamiento con el histórico actualizado y nueva validación sobre el mismo conjunto estratificado antes de reemplazar el modelo |
| Retirada del modelo | Si tras un ciclo de reentrenamiento la exactitud no recupera el umbral de RF-26, el componente vuelve al modo solo reglas (RF-25) y la alerta temprana (RF-26) queda desactivada hasta corregir la calidad de datos |

---

## IA-02 — Detector de enfermedades por imagen (segundo componente, candidato)

Complementa la detección por patrones (RF-26): cuando el administrador o el jornalero
registra una incidencia fitosanitaria (RF-16), puede fotografiar la planta y el modelo
propone la plaga o enfermedad del catálogo normalizado (RF-20) con nivel de confianza.
Se justifica en la evidencia de mayor peso del dominio: el reporte de pérdidas por
plagas es, en palabras del administrador, el más importante de analizar (EV-01
[08:17]-[08:29]) y hoy depende del reconocimiento visual de una sola persona.

### Datos de entrenamiento requeridos

| Aspecto | Especificación |
|---|---|
| Origen | Capturas fotográficas tomadas en campo con la cámara del teléfono durante el registro de la incidencia (RF-16), complementadas con repositorios públicos etiquetados de cacao y plátano como semilla inicial de las clases. Las fotos del entorno de la finca ya levantadas como evidencia (carpeta 02_Evidencias/Fotos_Entorno) sirven de calibración de condiciones reales de captura. |
| Volumen estimado | Entre 800 y 1200 imágenes etiquetadas para el arranque, con mínimo de 150 imágenes por clase objetivo (monilia, escoba de bruja, sigatoka y planta sana para verde; monilia y sana para cacao). |
| Etiquetado | Doble etiquetado: identificación preliminar automática desde la semilla pública y confirmación agronómica local sobre cada imagen; desacuerdo resuelto por tercera revisión. Se exige concordancia mínima kappa de 0,80 entre etiquetadores antes de aceptar el conjunto. |
| Calidad mínima | Resolución suficiente para identificar síntomas (mínimo definido en el protocolo de captura), una clase por imagen, metadatos de parcela, fecha y condición de luz. |
| Sesgos conocidos | Iluminación y etapa fenológica concentradas en pocas jornadas de captura; predominio de un dispositivo móvil; síntomas avanzados sobrerrepresentados frente a etapas iniciales. Mitigación: muestreo estratificado por parcela, mes y etapa, y aumentación de datos controlada. |
| Base legal (LOPDP) | Las imágenes de plantas no constituyen datos personales. Protocolo de captura con exclusión de personas, documentos o placas en el encuadre; si una captura incluye a una persona, se recorta antes de almacenarla. Sin tratamiento de datos personales asociado a este componente. |
| Política de conservación | Imágenes de entrenamiento versionadas por lote con checksum; capturas de operación se conservan 12 meses vinculadas al registro de enfermedad (RF-16) y luego se eliminan conservando la etiqueta de validación anonimizada. |

### Métricas de éxito del modelo

| Métrica | Umbral | Conjunto de evaluación | Método |
|---|---|---|---|
| F1 macro promediado por clase | ≥ 0,85 | Conjunto de prueba local retenido, mínimo 200 imágenes no vistas, estratificado por clase y condición de luz | Evaluación antes de cada despliegue |
| Exhaustividad (recall) por clase crítica | ≥ 0,90 en monilia y escoba de bruja | Mismo conjunto de prueba | Un caso crítico no detectado obliga a revisión del modelo aunque el F1 global cumpla |
| Latencia de inferencia | ≤ 2,0 s por imagen | Percentil 95 sobre 50 inferencias | Medición en el dispositivo de gama baja de referencia usado en campo |
| Degradación aceptable fuera de distribución | F1 ≥ 0,75 sobre imágenes con condiciones no vistas | Lote de prueba con variación estacional | Evaluación semestral previa a temporada de lluvias |

Fallback declarado: sin conectividad o con confianza insuficiente, la propuesta del
modelo se presenta como sugerencia editable y el registro continúa por selección
manual desde el catálogo (RF-20), igual que el flujo actual; nunca bloquea el registro
de la incidencia.

### Plan de monitoreo

| Elemento | Especificación |
|---|---|
| Indicadores en producción | Concordancia entre clase propuesta y clase finalmente registrada en RF-16; proporción de capturas descartadas por baja confianza; distribución de condiciones de captura (luz, dispositivo) |
| Frecuencia de medición | Mensual sobre los registros confirmados en campo |
| Umbral de alerta por deriva | Concordancia mensual inferior al 80 %, o caída del F1 de evaluación por debajo de 0,80 |
| Criterio de reentrenamiento | Reentrenamiento programado trimestral con las etiquetas confirmadas del trimestre, más reentrenamiento disparado al incumplirse el umbral de deriva |
| Equidad operativa | Revisión mensual del F1 separado por condición de captura (luz plena/sombra) y gama de dispositivo, con brecha máxima tolerada de 5 puntos porcentuales; insumo directo para los RNF de equidad que especifique Kamila |
| Retirada del modelo | Si dos ciclos de reentrenamiento consecutivos no recuperan el umbral, retiro de la propuesta automática y retorno del flujo RF-16 a selección manual pura |
