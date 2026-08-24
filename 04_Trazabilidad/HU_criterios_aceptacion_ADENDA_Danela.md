# Adenda — Historias de Usuario HU-13 a HU-16

**Aporte de Danela al Paso 2 (Trazabilidad), en respuesta al hallazgo DR-01 de la
re-inspección PE5 (`09_Cierre_PE5/registro_reinspeccion_PE5.csv`).**

Este contenido debe fusionarse al final del archivo `04_Trazabilidad/HU_criterios_aceptacion.md`
existente (que hoy documenta HU-01 a HU-12). Cierra las cuatro historias que faltaban para los RF
de prioridad *Debe tener* añadidos en la Entrega 3 (2A): RF-19, RF-24, RF-25 y RF-26. Con esto,
las Historias de Usuario en el backlog pasan de 12/16 a 16/16 frente a los RF *Debe tener* del ERS.

---

### HU-13 — Generar reporte de pérdidas por plagas (RF-19 / UC-19)
**Historia:** Como Administrador, quiero generar un reporte de pérdidas de producción asociadas
a plagas y enfermedades por cultivo y parcela, para dimensionar el impacto económico de las
incidencias fitosanitarias y priorizar el manejo.

**INVEST:** Independiente (consume registros ya existentes de RF-16) · Negociable · Valiosa
(RF-19 respalda la evidencia de mayor peso del dominio, EV-01 [08:17]-[08:29]) · Estimable ·
Pequeña · Verificable (criterios abajo).

**CA-13:**
```gherkin
Escenario: Generación exitosa del reporte de pérdidas
  Dado que existen registros de enfermedad cargados para un periodo y, opcionalmente, un cultivo o parcela
  Cuando el Administrador genera el reporte de pérdidas
  Entonces el sistema presenta la pérdida estimada por plaga, cultivo y parcela en <= 3,0 s con 500 registros cargados (percentil 95, 30 ejecuciones)

Escenario: Periodo sin incidencias registradas
  Dado que no existen registros de enfermedad en el periodo consultado
  Cuando el Administrador genera el reporte
  Entonces el sistema informa que no hay pérdidas registradas en ese periodo
```

---

### HU-14 — Consultar historial de registros por trabajador y fecha (RF-24 / UC-24)
**Historia:** Como Administrador, quiero consultar el historial de labores y cosechas filtrado
por trabajador y rango de fechas, para reconciliar la información de campo sin depender del
registro en papel que hoy se pierde o se duplica.

**INVEST:** Independiente · Negociable (filtros adicionales quedan abiertos a iteración futura) ·
Valiosa · Estimable · Pequeña · Verificable (criterios abajo).

**CA-14:**
```gherkin
Escenario: Consulta filtrada con resultados
  Dado que existen labores y cosechas registradas para uno o más trabajadores
  Cuando el Administrador filtra por trabajador (opcional) y rango de fechas (obligatorio)
  Entonces el sistema presenta el listado filtrado en <= 2,0 s con 500 registros (percentil 95, 30 ejecuciones)

Escenario: Filtro sin coincidencias
  Dado que no existen registros para el trabajador y rango de fechas seleccionados
  Cuando el Administrador realiza la consulta
  Entonces el sistema informa que no hay registros para ese filtro
```

---

### HU-15 — Recibir alertas automáticas de atención inmediata (RF-25 / UC-25)
**Historia:** Como Administrador, quiero recibir alertas automáticas cuando se registre una
enfermedad de gravedad alta o un insumo con disponibilidad crítica, para poder actuar de
inmediato sin revisar manualmente cada registro.

**INVEST:** Independiente (consume eventos de RF-06 y RF-16) · Negociable · Valiosa · Estimable ·
Pequeña · Verificable — nota: el criterio de RF-25 ya fue corregido por el equipo el 22-08-2026
(hallazgo DR-02) para verificar ambas fuentes por separado; este CA sigue esa misma corrección.

**CA-15:**
```gherkin
Escenario: Alerta automática por enfermedad de gravedad alta
  Dado que se registra una enfermedad con nivel de gravedad alto (RF-16)
  Cuando el sistema procesa el registro
  Entonces genera una alerta visible al Administrador en <= 5,0 s desde el registro, verificado sobre una muestra de 30 casos de este tipo

Escenario: Alerta por insumo con disponibilidad crítica
  Dado que un insumo cae por debajo de su umbral mínimo (RF-06)
  Cuando el sistema recalcula el stock
  Entonces genera una alerta con tipo, origen y momento de generación, verificado sobre una muestra de 30 casos de este tipo
```

---

### HU-16 — Recibir detección temprana de enfermedad por IA (RF-26 / UC-26)
**Historia:** Como Administrador, quiero que el sistema analice el historial de una parcela y me
alerte tempranamente ante posibles señales de enfermedad, para poder intervenir antes de que el
daño sea visible a simple vista.

**INVEST:** Independiente · Negociable (umbral de exactitud ajustable con más datos) · Valiosa ·
Estimable · Pequeña — **nota de coordinación:** esta historia pertenece al componente IA-01
(alertas y recomendaciones), no al segundo componente de IA (IA-02, detector de enfermedades por
imagen) que Kamila debe formalizar aparte con sus propios RF/RNF de equidad y explicabilidad.

**CA-16:**
```gherkin
Escenario: Detección temprana con exactitud mínima aceptada
  Dado un conjunto de validación de al menos 30 casos etiquetados con datos históricos de una parcela (labores, cosechas, enfermedades previas)
  Cuando el módulo de IA analiza los patrones de la parcela
  Entonces genera una alerta temprana de posible enfermedad con una exactitud (accuracy) mínima del 70% sobre ese conjunto

Escenario: Explicabilidad de la alerta temprana (enlaza RNF-15, decisión D-01)
  Dado que el módulo de IA genera una alerta temprana
  Cuando la muestra al Administrador
  Entonces incluye los datos históricos y el patrón que la motivaron, junto con el nivel de incertidumbre, de forma simultánea a la alerta, no posterior
```
