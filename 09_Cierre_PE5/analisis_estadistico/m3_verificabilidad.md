# M3 — Verificabilidad

> **Ola 2 (2026-08-24, `ERS_SRS_2A_v2.0.tex`, 57 requisitos):** M3 = 57/57 × 100
> = **100 %**; las 15 fichas de IA nacieron con umbral, unidad y método. El
> cuerpo de este documento conserva la medición de la ola 1 (42/42).

**Fórmula:** M3 = (# requisitos con criterio comprobable) / (# requisitos totales) × 100

**Referencia:** ≥ 90 %, con 100 % en RF críticos.

## Prueba de las cuatro preguntas aplicada a los 42 requisitos

| Pregunta | Resultado |
|---|---|
| (a) ¿Umbral numérico u observable? | 42/42 |
| (b) ¿Unidad o estado esperado definido? | 42/42 |
| (c) ¿Método o escenario de comprobación? | 42/42 |
| (d) ¿Veredicto reproducible por dos evaluadores? | Sí; el conteo es mecánico sobre fichas con plantilla fija |

**Aritmética:** M3 = 42/42 × 100 = **100 %** → referencia ≥ 90 % → **Cumple**
(los 27 RF alcanzan el 100 % exigido a los críticos).

Detalle por requisito: `salidas/m3_evaluacion_verificabilidad.csv`.

## Evidencias que sustentan el resultado

1. **Cero términos no medibles.** El escaneo de vocabulario vago
   («rápido», «amigable», «fácil», «eficiente», «adecuado», «intuitivo»,
   «simple», «flexible», «moderno», «óptimo», «suficiente», «bueno») sobre los
   campos de criterio y valor objetivo arrojó **0 coincidencias en 42
   requisitos**. Los umbrales se expresan en segundos, minutos, porcentajes,
   razones n de m, percentiles o conteos acotados.
2. **Escenario BDD asociado.** Los 16 RF «Debe tener» cuentan con historia de
   usuario y escenario de aceptación Gherkin (Dado/Cuando/Entonces) en la
   sección de historias del propio documento; los RNF se verifican mediante su
   tríada métrica + valor objetivo + método de medición.

## Observación menor de redacción (acción registrada)

Los objetivos de RNF-07, RNF-09 y RNF-11 expresan el umbral como un
«100 %» desnudo cuya unidad completa se define en la descripción y el método
de la misma ficha (cobertura de unidades de medida, recuperación de registros
tras interrupción, credenciales cifradas). El requisito sigue siendo verificable,
pero se recomienda a futuro incorporar el objeto del porcentaje dentro del
campo `Valor objetivo`. No impide el veredicto ni activa acción correctiva
obligatoria.
