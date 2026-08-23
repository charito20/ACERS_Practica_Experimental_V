# ACERS_Practica_Experimental_V

Actividad con grupo de PFC.

Repositorio de la Práctica Experimental V (Unidad V: Integración, Métricas y
Defensa) sobre el ERS del SGA del PFC AgroMoreira. El documento auditado y su
historial completo viven en el repositorio del equipo:
https://github.com/Roselyn15/Proyecto-IR---AgroMoreira---Sistema-de-Gestion-Agricola-con-IA-para-cultivos-de-verde-y-cacao-

## Contenido

- `01_ERS/ERS_SRS_2A_v1.0.tex` — copia del ERS con las correcciones de la
  re-inspección aplicadas (criterio de RF-25, referencias a casos de uso UC en
  RNF-05 y RNF-10, métricas M15.1 a M15.4 de RNF-15, entradas de RF-12, RF-18 y
  RF-27 como vistas derivadas de RF-07). Los mismos cambios están aplicados en
  el repositorio del equipo (commits 554ea3b y siguientes).
- `09_Cierre_PE5/` — artefactos de la auditoría:
  - `conteos_base_auditoria.csv` — conteos publicados antes de calcular.
  - `calculo_M5_modificabilidad.csv` — dependencias auditadas con línea del
    documento que respalda cada enlace.
  - `registro_defectos_lineabase_1B_2A.csv` — observaciones corregidas entre la
    Entrega 2 (1B) y la Entrega 3 (2A), con commit de evidencia.
  - `registro_reinspeccion_PE5.csv` — hallazgos DR-01 a DR-05 con estado.
  - `fichas_IA_datos_y_monitoreo.md` — datos de entrenamiento, métricas de
    éxito y plan de monitoreo de los dos componentes de IA.
  - `informe/sec5_validacion.tex`, `informe/sec8_metricas.tex` y
    `informe/anexo_b_respuestas.tex` — secciones para integrar al informe final.

## Resultados de la auditoría

| Métrica | Antes | Después | Referencia |
|---|---|---|---|
| M5 Modificabilidad | 3,50 | 3,00 | <= 3,0 |
| M6 Corrección | 0,119 | 0,024 | <= 0,05 |
