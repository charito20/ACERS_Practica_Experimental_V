# M2 — Consistencia

> **Ola 2 (2026-08-24, `ERS_SRS_2A_v2.0.tex`, 57 requisitos):** nueve ámbitos y
> **191 pares**, cero conflictos → M2 = 1 − 0/191 = **1,00**. Ver tabla al
> final; el cuerpo de este documento conserva la medición de la ola 1.

**Fórmula:** M2 = 1 − (# conflictos detectados) / (# pares de requisitos analizados)

**Referencia:** ≥ 0,98 con cero conflictos abiertos al cierre.

## Población analizada

Los 42 requisitos se agruparon en 8 ámbitos funcionales y se analizaron todos
los pares intra-ámbito (un conflicto directo solo puede surgir entre
requisitos que gobiernan el mismo aspecto del sistema):

| Ámbito | Requisitos | Pares |
|---|---|---|
| Autenticación y control de acceso | RF-01, RF-14, RNF-03, RNF-10, RNF-11 | 10 |
| Gestión de parcelas | RF-02, RNF-01 | 1 |
| Registro agrícola, cosecha y fitosanitario | RF-03, RF-04, RF-05, RF-16, RF-17, RF-20, RF-24, RNF-07, RNF-09 | 36 |
| Insumos y compras | RF-06, RF-21, RF-22 | 3 |
| Planificación y asignación de tareas | RF-08, RF-09, RF-10 | 3 |
| Producción, reportes e ingresos | RF-07, RF-11, RF-12, RF-13, RF-18, RF-19, RF-23, RF-27, RNF-08 | 36 |
| IA, alertas y recomendaciones | RF-15, RF-25, RF-26, RNF-15 | 6 |
| Calidad transversal | RNF-02, RNF-04, RNF-05, RNF-06, RNF-12, RNF-13, RNF-14 | 21 |
| **Total** | | **116** |

La matriz completa con veredicto por par está en
`salidas/m2_pares_analizados.csv`; su generación es reproducible con
`generar_pares_m2.ps1`.

## Resultado

Conflictos directos: **0**. Conflictos indirectos abiertos: **0**.

**Aritmética:** M2 = 1 − 0/116 = **1,00** → referencia ≥ 0,98 → **Cumple**.

## Observaciones registradas (no son conflictos)

1. **Solapamiento funcional parcial RF-07 / RF-11 / RF-13.** Consulta de
   producción, reportes y estadísticas comparten datos subyacentes sin
   contradecirse. Se registra como observación de mantenibilidad; la
   modularidad exigida por RNF-06 (≤3 módulos por cambio) mitiga el riesgo de
   duplicación de implementación.
2. **Convivencia RF-25 / RF-26.** Las alertas por regla (gravedad alta,
   insumos críticos) y las alertas tempranas del componente de IA operan sobre
   condiciones distintas (confirmada frente a predicha) y la diferenciación de
   presentación queda soportada por RNF-15 (M15.2: ≤1,0 s adicional).
3. **Reconciliación RF-05 ↔ RF-17.** El peso declarado en cosecha y el
   comprobante de acopio pueden divergir; RF-24 existe precisamente para esa
   reconciliación, por lo que la tensión potencial está tratada dentro del
   propio catálogo.

Ninguna observación exige reescritura de requisitos al cierre.

## Ola 2 — población y resultado (v2.0, 57 requisitos)

Los 15 requisitos de IA nuevos se incorporaron a dos ámbitos dedicados; el
resto se mantuvo sin cambios:

| Ámbito | Requisitos | Pares |
|---|---|---|
| Autenticación y control de acceso | RF-01, RF-14, RNF-03, RNF-10, RNF-11 | 10 |
| Gestión de parcelas | RF-02, RNF-01 | 1 |
| Registro agrícola, cosecha y fitosanitario | RF-03, RF-04, RF-05, RF-16, RF-17, RF-20, RF-24, RNF-07, RNF-09 | 36 |
| Insumos y compras | RF-06, RF-21, RF-22 | 3 |
| Planificación y asignación de tareas | RF-08, RF-09, RF-10 | 3 |
| Producción, reportes e ingresos | RF-07, RF-11, RF-12, RF-13, RF-18, RF-19, RF-23, RF-27, RNF-08 | 36 |
| IA-01 recomendador y alertas | RF-15, RF-25, RF-26, RF-28, RNF-15, RNF-16, RNF-17, RNF-18, RNF-19, RNF-20 | 45 |
| IA-02 detector de plagas por imagen | RF-29, RF-30, RF-31, RNF-21, RNF-22, RNF-23, RNF-24, RNF-25, RNF-26 | 36 |
| Calidad transversal | RNF-02, RNF-04, RNF-05, RNF-06, RNF-12, RNF-13, RNF-14 | 21 |
| **Total** | | **191** |

Conflictos directos: **0**. Conflictos indirectos abiertos: **0**.

**Aritmética:** M2 = 1 − 0/191 = **1,00** → referencia ≥ 0,98 → **Cumple**
(ola 1: 1 − 0/116 = 1,00).
