# Notas metodológicas de la auditoría estadística (M1–M4)

**Responsable:** jean200525 — Componente empírico + Analista estadístico
**Documento auditado:** `01_ERS/ERS_SRS_2A_v1.0.tex` (copia con correcciones de la re-inspección)
**Fecha de medición:** 2026-08-23
**Herramienta:** `conteo_requisitos.ps1` (PowerShell 5.1, sin dependencias externas)

## Principio de autenticidad

Toda métrica se calcula por conteo directo sobre el archivo `.tex` auditado.
Ningún valor es estimación cualitativa. Los conteos base se publicaron en
`salidas/resumen_conteos.csv` **antes** de calcular las métricas, conforme al
paso 1.b de la guía.

## Método de extracción

El script divide el documento en fichas mediante el patrón de encabezado
`\noindent\textbf{RF-XX.` / `\noindent\textbf{RNF-XX.`, y extrae cada fila de
atributo con el separador `& ... \\` de las tablas `longtable`. La salida se
vuelca a CSV para que cualquier integrante pueda auditar fila por fila.

## Reglas de conteo aplicadas

| Atributo M1a | RF | RNF |
|---|---|---|
| Identificador | Fila `Identificador` | Fila `Identificador` |
| Prioridad | Fila `Prioridad (MoSCoW)` | Fila `Prioridad` |
| Fuente | `Actor / origen` con EV-xx o R-xx | `Origen` con EV-xx, R-xx, RD-xx, UC-xx, ISO o RF asociado |
| Criterio | `Criterio de verificación` no vacío y con umbral (`≤`, `≥`, máximo, mínimo, percentil, unidad numérica o razón n de m) | `Valor objetivo` con umbral **y** `Método de medición` no vacío |

## Decisiones documentadas

1. **Detector de umbrales calibrado dos veces.** La primera pasada marcó
   RNF-05, RNF-06 y RNF-10 como sin umbral. La revisión manual mostró que sí
   lo tienen («18 de 18 ejecuciones», «como máximo 3 módulos», «5 intentos;
   bloqueo mínimo de 15 minutos») y el patrón se amplificó en consecuencia.
   El detector no se relajó más allá de esos casos verificados.
2. **M1b no se mide desde este repositorio.** El catálogo de casos de uso del
   PFC reside en el repositorio del equipo. Reportar un número aquí sería una
   métrica sin respaldo contable. Queda como pendiente de verificación cruzada
   con causa y acción registradas.
3. **M4ade se reporta sobre el alcance con historia declarado.** El propio ERS
   declara (sección Historias de usuario) que solo los RF «Debe tener»
   reciben HU. Medir los otros 11 RF como cadena rota sería ignorar una
   decisión de alcance documentada, no un defecto de trazabilidad.
4. **M5 y M6 no se re-miden.** Fueron medidas por la auditoría previa
   (`calculo_M5_modificabilidad.csv`, `registro_reinspeccion_PE5.csv`) y se
   citan en la tabla consolidada únicamente como referencia, sin alterarlas.

## Veredictos aplicados a criterios (prueba de las cuatro preguntas)

Para cada requisito se verificó: (a) umbral numérico u observable, (b) unidad
o estado esperado definido, (c) método o escenario de comprobación indicado,
(d) reproducibilidad del veredicto por evaluador independiente. El detalle por
requisito está en `salidas/m3_evaluacion_verificabilidad.csv`.
