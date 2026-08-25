# Verificación de reproducibilidad del conteo

**Fecha:** 2026-08-23
**Procedimiento:** segunda ejecución de `conteo_requisitos.ps1` sobre el mismo
`ERS_SRS_2A_v1.0.tex`, con comparación de hash SHA-256 de las cuatro salidas
principales.

## Resultado

| Archivo | SHA-256 (primeros 16 hex) | Idéntico a 1.ª pasada |
|---|---|---|
| inventario_rf.csv | `11093BDB5F8596AA`… | n/a (referencia) |
| inventario_rnf.csv | `8CFA7818BA023E7C`… | Sí |
| historias_usuario.csv | `85C7228CDBFF3841`… | Sí |
| resumen_conteos.csv | `4B96ECE8B791698D`… | Sí |

El conteo es determinista: dos ejecuciones sobre la misma versión del ERS
producen salidas bit a bit idénticas, lo que satisface la pregunta (d) de la
prueba de verificabilidad (veredicto reproducible por evaluadores
independientes).

## Observación de clasificación detectada durante el contraste

La ficha de RNF-15 declara como característica ISO/IEC 25010:2023 «Interacción
de usuario», mientras que la tabla de cobertura del propio ERS
(`tab:cobertura-rnf`) lo lista bajo la fila «Explicabilidad» y deja la fila de
Interacción de usuario con RNF-04 y RNF-12. La cobertura de mínimos se cumple
en ambas lecturas (ninguna característica queda bajo su mínimo), pero se
recomienda unificar la clasificación del RNF-15 en una próxima revisión menor
del documento. No altera ninguna métrica M1–M4 reportada.

## Ola 2 — verificación sobre `ERS_SRS_2A_v2.0.tex` (2026-08-24)

**Procedimiento:** doble ejecución de `conteo_requisitos.ps1 -ErsPath
..\..\01_ERS\ERS_SRS_2A_v2.0.tex` más `generar_pares_m2.ps1`, con comparación
de hash SHA-256 de todas las salidas CSV: **idénticas bit a bit**.

| Archivo | SHA-256 (primeros 16 hex) |
|---|---|
| aritmetica_metricas.csv | `1B57A5A92E75607F`… |
| historias_usuario.csv | `11093BDB5F8596AA`… (sin cambio respecto a la ola 1) |
| inventario_rf.csv | `487235EFC9BCFECC`… (31 RF) |
| inventario_rnf.csv | `53F91907240E92CA`… (26 RNF) |
| m2_pares_analizados.csv | `CAA546F073B18EF3`… (191 pares, 0 conflictos) |
| resumen_conteos.csv | `D43A7D39AD98FF8D`… |

El conteo sobre la versión 2.0 es igualmente determinista; los hashes de
inventarios y resumen difieren de la ola 1 por diseño (población de 42 a 57
requisitos y corrección de Origen en tres fichas).
