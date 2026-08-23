# Tabla de auditoría consolidada de calidad del ERS

**Documento auditado:** `01_ERS/ERS_SRS_2A_v1.0.tex` (post re-inspección PE4)
**Fecha:** 2026-08-23
**Auditoría estadística M1–M4:** jean200525 (Componente empírico + Analista estadístico)
**Medición previa M5–M6:** auditoría de la entrega (`calculo_M5_modificabilidad.csv`, `registro_reinspeccion_PE5.csv`)

| Métrica | Valor obtenido | Valor de referencia | Referencia normativa | Cumple | Acción de mejora |
|---|---|---|---|---|---|
| M1a Completitud de atributos | 42/42 = 100 % | ≥ 95 % | ISO 25010; ISO 29148 | **Sí** | Ninguna |
| M1b CU especificados | No medible desde este repositorio | = 100 % | ISO 29148 | N/D | Verificación cruzada contra catálogo de CU del equipo antes de la defensa |
| M1c Actores con ≥1 RF (operativos) | 2/2 = 100 % | = 100 % | ISO 29148 | **Sí** | Lectura alternativa 2/4 documentada en `m1_completitud.md` |
| M2 Consistencia | 1 − 0/116 = 1,00 | ≥ 0,98, cero conflictos abiertos | ISO 25010 | **Sí** | Dos observaciones de solapamiento registradas, sin conflicto |
| M3 Verificabilidad | 42/42 = 100 % | ≥ 90 % (100 % RF críticos) | ISO 29148 | **Sí** | Recomendación menor de redacción en RNF-07/09/11 |
| M4ade Trazabilidad adelante | 16/16 = 100 % (alcance Debe-tener) | ≥ 90 % | ISO 29148 | **Sí** | Tramo CU→clase→CP pendiente de verificación cruzada (perímetro) |
| M4atr Trazabilidad atrás | 42/42 = 100 % | = 100 % | ISO 29148 | **Sí** | Ninguna |
| M5 Modificabilidad (referencia) | 3,50 → 3,00 | ≤ 3,0 | ISO 25010 | **Sí** | Medida por auditoría previa; se cita sin alterar |
| M6 Corrección (referencia) | 0,119 → 0,024 | ≤ 0,05 | ISO 25010 | **Sí** | Medida por auditoría previa; se cita sin alterar |

## Lectura ejecutiva

- Las ocho componentes medibles desde este repositorio alcanzan su valor de
  referencia al cierre.
- Los dos únicos elementos abiertos son de **perímetro**, no de calidad: el
  catálogo de casos de uso y los modelos posteriores (CU→clase→CP) viven en el
  repositorio del equipo. Ambos tienen causa y acción registradas conforme al
  formato exigido para huérfanos y cadenas.
- El par antes/después de M5 y M6 proviene de las correcciones ya aplicadas
  entre la línea base 1B y la versión 2A del ERS.

## Conteos que respaldan esta tabla

Todos los numeradores y denominadores están publicados y son reproducibles:

```powershell
powershell -ExecutionPolicy Bypass -File .\conteo_requisitos.ps1
powershell -ExecutionPolicy Bypass -File .\generar_pares_m2.ps1
```

La aritmética completa, métrica por métrica, está en
`salidas/aritmetica_metricas.csv`.
