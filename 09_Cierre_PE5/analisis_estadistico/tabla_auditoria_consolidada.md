# Tabla de auditoría consolidada de calidad del ERS

**Documento auditado:** `01_ERS/ERS_SRS_2A_v2.0.tex` (57 requisitos, tras la fusión de los componentes de IA IA-01 e IA-02)
**Fecha:** 2026-08-24
**Auditoría estadística M1–M4:** jean200525 (Componente empírico + Analista estadístico)
**Medición previa M5–M6:** auditoría de la entrega (`calculo_M5_modificabilidad.csv`, `registro_reinspeccion_PE5.csv`)

La auditoría se midió en dos olas. La **ola 1** midió la línea base corregida
(`ERS_SRS_2A_v1.0.tex`, 42 requisitos) el 2026-08-23; la **ola 2** re-mide sobre
la versión 2.0 fusionada (31 RF + 26 RNF = 57). Los valores finales reportados
son los de la ola 2; cuando hubo corrección intermedia se muestra el par
antes/después.

| Métrica | Valor obtenido | Valor de referencia | Referencia normativa | Cumple | Acción de mejora |
|---|---|---|---|---|---|
| M1a Completitud de atributos | **54/57 = 94,7 % → 57/57 = 100 %** | ≥ 95 % | ISO 25010; ISO 29148 | **Sí (tras corrección)** | Primera medición detectó Origen sin fuente trazable en RNF-20, RNF-24 y RNF-25; se añadió la referencia al requisito de origen (RF-15/RF-26 y RF-29) en `ERS_SRS_2A_v2.0.tex` y se re-midió |
| M1b CU especificados | No medible desde este repositorio | = 100 % | ISO 29148 | N/D | Verificación cruzada contra catálogo de CU del equipo antes de la defensa |
| M1c Actores con ≥1 RF (operativos) | 2/2 = 100 % | = 100 % | ISO 29148 | **Sí** | Lectura alternativa 2/4 documentada en `m1_completitud.md`; RF-28 a RF-31 no introducen actor nuevo |
| M2 Consistencia | 1 − 0/191 = 1,00 (ola 1: 1 − 0/116 = 1,00) | ≥ 0,98, cero conflictos abiertos | ISO 25010 | **Sí** | Nueve ámbitos funcionales en ola 2; observaciones de solapamiento registradas, sin conflicto |
| M3 Verificabilidad | 57/57 = 100 % (ola 1: 42/42) | ≥ 90 % (100 % RF críticos) | ISO 29148 | **Sí** | Las 15 fichas nuevas de IA nacieron con umbral, unidad y método de medición |
| M4ade Trazabilidad adelante | 16/16 = 100 % (alcance Debe-tener) | ≥ 90 % | ISO 29148 | **Sí** | RF-28 a RF-31 son Debería-tener y quedan fuera del alcance Debe-tener; tramo CU→clase→CP pendiente de verificación cruzada (perímetro) |
| M4atr Trazabilidad atrás | 57/57 = 100 % (ola 1: 42/42) | = 100 % | ISO 29148 | **Sí** | Corregido en esta auditoría junto con M1a (mismo atributo Origen) |
| M5 Modificabilidad (referencia) | 3,50 → 3,00 | ≤ 3,0 | ISO 25010 | **Sí** | Medida por auditoría previa; se cita sin alterar |
| M6 Corrección (referencia) | 0,119 → 0,024 | ≤ 0,05 | ISO 25010 | **Sí** | Medida por auditoría previa; se cita sin alterar |

## Par antes/después documentado por esta auditoría

- **M1a/M4atr (ola 2):** la primera medición sobre `ERS_SRS_2A_v2.0.tex`
  arrojó 54/57 requisitos con atributos completos (94,7 %), bajo la
  referencia de 95 %. Causa: las fichas de equidad RNF-20, RNF-24 y RNF-25
  citaban como origen únicamente el análisis de sesgos del equipo
  (`fichas_IA_datos_y_monitoreo.md`) sin enlace a un requisito o evidencia
  trazable. Acción aplicada: se añadió el requisito de origen correspondiente
  (RF-15 y RF-26 para RNF-20; RF-29 para RNF-24 y RNF-25) conservando la nota
  de sesgo documental. Re-medición: 57/57 = 100 %. El diff entre v1.0 y v2.0
  queda limitado a esas tres líneas de `Origen`.
- **M2 (ola 2):** la población creció de 42 a 57 requisitos y el análisis de
  pares pasó de 8 ámbitos/116 pares a 9 ámbitos/191 pares, sin conflictos
  directos ni indirectos en ninguna de las dos olas.

## Lectura ejecutiva

- Las ocho componentes medibles desde este repositorio alcanzan su valor de
  referencia al cierre de la ola 2.
- Esta auditoría demuestra el ciclo completo de mejora: la medición detectó
  una caída real de completitud al incorporar 15 requisitos nuevos, la causa
  fue localizada en tres fichas, la corrección quedó aplicada en la versión
  2.0 y la re-medición confirmó el cierre.
- Los elementos abiertos siguen siendo de **perímetro**, no de calidad: el
  catálogo de casos de uso (CU para RF-28 a RF-31, pendiente de Danela) y los
  modelos posteriores (CU→clase→CP) viven en el repositorio del equipo, con
  causa y acción registradas conforme al formato exigido.

## Conteos que respaldan esta tabla

Todos los numeradores y denominadores están publicados y son reproducibles:

```powershell
powershell -ExecutionPolicy Bypass -File .\conteo_requisitos.ps1 -ErsPath ..\..\01_ERS\ERS_SRS_2A_v2.0.tex
powershell -ExecutionPolicy Bypass -File .\generar_pares_m2.ps1
```

Sin parámetro, `conteo_requisitos.ps1` mide la línea base v1.0. La aritmética
completa, métrica por métrica y con ambas olas, está en
`salidas/aritmetica_metricas.csv`.
