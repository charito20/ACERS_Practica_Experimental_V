# M1 — Completitud

> **Ola 2 (2026-08-24, `ERS_SRS_2A_v2.0.tex`, 57 requisitos):** la primera
> medición dio M1a = 54/57 × 100 = **94,7 %**, por Origen sin fuente trazable
> en RNF-20, RNF-24 y RNF-25; aplicada la corrección (referencia al requisito
> de origen en las tres fichas) y re-medida: **57/57 = 100 %**. El cuerpo de
> este documento conserva la medición de la ola 1 (42/42).

**Fórmulas (guía PE5, sección 4.2):**

- M1a = (# requisitos con los 4 atributos completos) / (# requisitos totales) × 100
- M1b = (# CU especificados) / (# CU identificados) × 100
- M1c = (# actores con ≥1 RF) / (# actores) × 100

## M1a — Atributos obligatorios por requisito

Conteos base (ver `salidas/resumen_conteos.csv`):

| Población | Con fuente | Con prioridad | Con criterio/valor objetivo | Completos |
|---|---|---|---|---|
| 27 RF | 27 | 27 | 27 | 27 |
| 15 RNF | 15 | 15* | 15 (valor objetivo + método) | 15 |

\* La prioridad del RNF se toma de la fila `Prioridad` (escala Alta/Media/Baja),
equivalente funcional al atributo exigido.

**Aritmética:** M1a = 42/42 × 100 = **100 %** → referencia ≥ 95 % → **Cumple**.

Detalle fila por fila en `salidas/inventario_rf.csv` y
`salidas/inventario_rnf.csv`.

## M1b — Casos de uso especificados

**No medible desde este repositorio.** El documento auditado referencia
únicamente UC-01 y UC-06 como orígenes de RNF-10 y afines; el catálogo
completo de casos de uso reside en el repositorio del equipo.

- Causa: artefacto fuera del perímetro de este repositorio.
- Acción: verificación cruzada contra el catálogo de CU del equipo antes de la
  defensa; el resultado se incorporará a la tabla consolidada cuando exista.

## M1c — Cobertura de actores

De los 4 stakeholders del mapa poder/interés, los actores operativos son
Administrador de la finca (PI-01) y Jornalero (PI-02). Equipo de desarrollo
(PI-03) y Docente (PI-04) no consumen funcionalidades del sistema y el modelo
i* los representa sin dependencias hacia el dominio operativo.

**Aritmética:**
- Lectura operativa: M1c = 2/2 × 100 = **100 %** → **Cumple**.
- Lectura sobre todos los stakeholders: 2/4 = 50 %. Se documenta como lectura
  alternativa justificada: ningún requisito operativo corresponde a PI-03 o
  PI-04 y el propio ERS declara esa ausencia de dependencias (sección i*).

Detalle en `salidas/m1c_cobertura_actores.csv`.

## Veredicto del criterio

M1 cumple su valor de referencia en las componentes medibles desde este
repositorio (M1a = 100 %, M1c-operativa = 100 %), con M1b pendiente de
verificación cruzada documentada con causa y acción.
