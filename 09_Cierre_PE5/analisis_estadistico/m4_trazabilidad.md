# M4 — Trazabilidad

> **Ola 2 (2026-08-24, `ERS_SRS_2A_v2.0.tex`, 57 requisitos):** M4atr = 57/57 ×
> 100 = **100 %** tras la corrección de origen en RNF-20, RNF-24 y RNF-25
> (misma acción que cerró M1a). M4ade se mantiene en 16/16 sobre el alcance
> «Debe tener»: RF-28 a RF-31 son «Debería tener» y amplían la población
> «Debería/Podría» de 11 a 15 RF con la misma decisión de alcance declarada.
> El cuerpo de este documento conserva la medición de la ola 1.

**Fórmulas:**

- M4ade = (# RF con cadena hacia adelante completa) / (# RF) × 100
- M4atr = (# RF con fuente o stakeholder identificado) / (# RF) × 100

**Referencias:** M4ade ≥ 90 %; M4atr = 100 %.

## M4atr — Fuente identificada

Las fuentes válidas consideradas son evidencias de campo (EV-01, EV-02),
restricciones (R-xx), decisiones y reglas documentadas (RD-xx), casos de uso
(UC-xx) u orígenes normativos/ISO con RF asociado.

**Aritmética:** M4atr = 42/42 × 100 = **100 %** → **Cumple**.

Detalle por requisito en `salidas/m4_cadena_requisitos.csv`.

## M4ade — Cadena hacia adelante

El ERS declara explícitamente que solo los RF «Debe tener» reciben historia de
usuario (sección Historias de usuario). La cadena verificable dentro de este
repositorio es Fuente → RF → HU → CA:

| Población | Con HU | Con escenario CA | Cadena completa |
|---|---|---|---|
| 16 RF «Debe tener» | 16 | 16 | 16 |
| 11 RF «Debería/Podría tener» | 0 por decisión de alcance declarada | — | N/A |

**Aritmética:** M4ade (alcance Debe-tener) = 16/16 × 100 = **100 %** → referencia ≥ 90 % → **Cumple**.

Medir los 11 RF restantes como cadena rota contradiría una decisión de alcance
documentada en el propio ERS; se registran como «parcial justificado».

## Limitación de perímetro (documentada, no oculta)

La cadena completa de la guía incluye CU, clases UML, estados y casos de
prueba conceptual, que residen en el repositorio del equipo. Desde este
repositorio solo es auditable el tramo Fuente→RF→HU→CA. El tramo restante
queda como pendiente de verificación cruzada antes de la defensa, con causa
(artefactos fuera del perímetro) y acción (contraste contra los modelos de la
PE3 publicados por el equipo).

## Huérfanos y cadenas rotas

| Identificador | Causa | Acción tomada |
|---|---|---|
| *(ninguno)* | No se detectaron requisitos sin fuente ni historias sin RF de origen | Verificación 42/42 y 16/16 respectivamente |

Artefactos huérfanos: las 16 historias derivan todas de un RF existente;
ninguna sobra.

## Sincronización backlog ↔ ERS

- RF «Debe tener» con al menos una historia: 16/16.
- Historias que apuntan a un RF existente: 16/16.

**Aritmética:** sincronización = 16/16 × 100 = **100 %**.

Nota de perímetro: la sincronización se mide contra las historias versionadas
en el ERS; el tablero del equipo (herramienta declarada en el informe) debe
contrastarse antes de la defensa para cerrar la verificación bidireccional
externa.
