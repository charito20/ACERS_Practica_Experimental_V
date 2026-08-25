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
  RF-27 como vistas derivadas de RF-07), consolidadas en la versión 2.0:
  agrega RF-28 a RF-31 y RNF-16 a RNF-26 (componentes de IA IA-01 e IA-02,
  Paso 3 de la PE5), con ficha de componente y clasificación de riesgo
  conforme al Reglamento (UE) 2024/1689.
- `01_ERS/ERS_SRS_2A_v2.0.tex` — versión auditada al cierre: igual a v1.0 más
  la corrección de la auditoría estadística (Origen trazable en RNF-20,
  RNF-24 y RNF-25); el diff queda limitado a esas tres líneas.
- `09_Cierre_PE5/` — artefactos de la auditoría:
  - `conteos_base_auditoria.csv` — conteos publicados antes de calcular.
  - `conteos_base_auditoria_actualizado.csv` — conteos recalculados tras la
    fusión del componente IA-02 (57 requisitos: 31 RF + 26 RNF).
  - `calculo_M5_modificabilidad.csv` — dependencias auditadas con línea del
    documento que respalda cada enlace.
  - `registro_defectos_lineabase_1B_2A.csv` — observaciones corregidas entre la
    Entrega 2 (1B) y la Entrega 3 (2A), con commit de evidencia.
  - `registro_reinspeccion_PE5.csv` — hallazgos DR-01 a DR-05 con estado.
  - `fichas_IA_datos_y_monitoreo.md` — datos de entrenamiento, métricas de
    éxito y plan de monitoreo de los dos componentes de IA.
  - `informe/sec5_validacion.tex`, `informe/sec8_metricas.tex`,
    `informe/anexo_b_respuestas.tex`, `informe/sec3_ers_final.tex`,
    `informe/sec7_requisitos_ia.tex`, `informe/anexoE_declaracion_ia.tex` y
    `informe/anexo_b_ia_etica_kamila.tex` — secciones para integrar al informe
    final.
  - `presentacion_defensa/` — presentación de defensa en LaTeX Beamer
    (18 diapositivas, secuencia del Paso 4.a de la guía).
  - `analisis_estadistico/` — auditoría estadística de las métricas M1 a M4
    (responsable: jean200525, componente empírico y análisis estadístico):
    script reproducible de conteo (parámetro `-ErsPath` para elegir versión),
    inventarios de la línea base (42 requisitos) y de la versión 2.0 (57),
    matriz de pares para consistencia (116 pares en ocho ámbitos sobre la
    línea base; 191 en nueve ámbitos sobre la v2.0), cadena de trazabilidad
    por requisito, aritmética visible de cada métrica con ambas olas y tabla
    consolidada.

## Resultados de la auditoría

| Métrica | Antes | Después | Referencia |
|---|---|---|---|
| M5 Modificabilidad | 3,50 | 3,00 | <= 3,0 |
| M6 Corrección | 0,119 | 0,024 | <= 0,05 |

Resultados de la auditoría estadística (M1–M4), medida sobre
`01_ERS/ERS_SRS_2A_v1.0.tex`:

| Métrica | Valor obtenido | Referencia | Cumple |
|---|---|---|---|
| M1a Completitud de atributos | 42/42 = 100 % | >= 95 % | Sí |
| M1b CU especificados | pendiente de verificación cruzada | = 100 % | N/D con causa y acción |
| M1c Actores operativos con >= 1 RF | 2/2 = 100 % | = 100 % | Sí |
| M2 Consistencia | 1 − 0/116 = 1,00 | >= 0,98 | Sí |
| M3 Verificabilidad | 42/42 = 100 % | >= 90 % | Sí |
| M4ade Trazabilidad adelante (Debe tener) | 16/16 = 100 % | >= 90 % | Sí |
| M4atr Trazabilidad atrás | 42/42 = 100 % | = 100 % | Sí |

Segunda ola de la auditoría estadística, medida sobre
`01_ERS/ERS_SRS_2A_v2.0.tex` (57 requisitos, con los componentes de IA):

| Métrica | Valor obtenido | Referencia | Cumple |
|---|---|---|---|
| M1a Completitud de atributos | 54/57 = 94,7 % → 57/57 = 100 % (tras corrección de origen en RNF-20, RNF-24 y RNF-25) | >= 95 % | Sí |
| M1c Actores operativos con >= 1 RF | 2/2 = 100 % | = 100 % | Sí |
| M2 Consistencia | 1 − 0/191 = 1,00 (nueve ámbitos; línea base: 1 − 0/116) | >= 0,98 | Sí |
| M3 Verificabilidad | 57/57 = 100 % | >= 90 % | Sí |
| M4ade Trazabilidad adelante (Debe tener) | 16/16 = 100 % (RF-28 a RF-31 son Debería tener) | >= 90 % | Sí |
| M4atr Trazabilidad atrás | 57/57 = 100 % | = 100 % | Sí |

El detalle completo está en `09_Cierre_PE5/analisis_estadistico/`.

## Cómo reproducir la auditoría estadística

Requisitos: PowerShell 5.1 o superior (Windows nativo; en Linux/macOS, PowerShell
Core). No requiere dependencias adicionales.

```powershell
# desde la raiz del repositorio
# linea base v1.0 (42 requisitos, valor por omision):
powershell -ExecutionPolicy Bypass -File .\09_Cierre_PE5\analisis_estadistico\conteo_requisitos.ps1
# version 2.0 auditada al cierre (57 requisitos):
powershell -ExecutionPolicy Bypass -File .\09_Cierre_PE5\analisis_estadistico\conteo_requisitos.ps1 -ErsPath .\01_ERS\ERS_SRS_2A_v2.0.tex
powershell -ExecutionPolicy Bypass -File .\09_Cierre_PE5\analisis_estadistico\generar_pares_m2.ps1
```

Las salidas se regeneran en `09_Cierre_PE5/analisis_estadistico/salidas/` y son
deterministas para una misma versión del ERS (verificado por hash SHA-256,
ver `verificacion_reproducibilidad.md`).

## Informe final y presentación (criterio G2)

El informe final se genera desde LaTeX. **Archivo principal:**
`09_Cierre_PE5/informe/main.tex`.

**Compilador:** pdfLaTeX (TeX Live 2023+ o MiKTeX actualizado).

**Dependencias:** paquetes estándar incluidos en cualquier distribución
completa de TeX — `babel` (español), `inputenc`, `fontenc`, `lmodern`,
`geometry`, `longtable`, `array`, `graphicx`, `url`, `hyperref`, `enumitem`.
El estilo bibliográfico `IEEEtran.bst` **ya viene incluido en este repositorio**
(`09_Cierre_PE5/informe/IEEEtran.bst`), porque no forma parte de una instalación
mínima de TeX Live y `bibtex` lo busca primero en la carpeta actual. No requiere
instalar nada aparte ni depender de qué tenga la máquina de quien compile.

**Orden exacto de comandos** (desde la raíz del repositorio):

```bash
cd 09_Cierre_PE5/informe
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

La salida es `main.pdf`. El nombre para la subida al SGA es:
`PE5_U5_PFC_Final_Espinoza_Calle_Arteaga_Escudero_Sanchez.pdf`
(confirmar con el docente el manejo del quinto apellido).

**Secciones pendientes de integración:** `sec1_introduccion.tex`,
`sec2_metodologia_ir.tex` y `anexo_a_instrumento.tex` (`sec4_modelos_uml.tex` y
`sec6_gestion_trazabilidad.tex`, de Danela, ya fueron integradas). El documento
compila sin las pendientes dejando un marcador visible; basta con que cada responsable
agregue su archivo en `09_Cierre_PE5/informe/` con ese nombre.

**Presentación de defensa:**

```bash
cd 09_Cierre_PE5/presentacion_defensa
pdflatex main.tex
pdflatex main.tex
```
