# 🏛️ Reto #5 Y 6



## 📌 Objetivo del proyecto
El objetivo principal de este repositorio es cumplir con el reto propuesto, el cual consiste en diseñar un esquema relacional normalizado, cargar datos en **SQL Server** y analizar el desempeño de diferentes tipos de consultas SQL, específicamente comparando el impacto de un $CROSS \ JOIN$ frente a un $INNER \ JOIN$.

---

## 🛑 El Problema: El Desastre del Flat File
Para este reto, se analizó un escenario crítico basado en una empresa que durante 10 años registró sus ventas en una sola "hoja de cálculo infinita". Al intentar migrar esto a SQL Server sin un diseño previo, surgieron dos problemas graves:

1.  **Inconsistencia de Datos (Anomalías de Actualización):** La falta de normalización permitió que un mismo cliente (ej. "Juan Pérez") estuviera registrado de múltiples formas, impidiendo la integridad de la información.
2.  **Colapso del Sistema por Desempeño:** El uso incorrecto de un `CROSS JOIN` para reportes de productos provocó un crecimiento exponencial de registros, consumiendo el $100\%$ de la CPU y deteniendo el servicio de facturación.

---

## 🛠️ Desarrollo del reto

Para solucionar estos problemas, se realizaron las siguientes etapas:

1. **Diseño del esquema relacional**
   Se crearon las entidades **Cliente, Producto, Sucursal y Venta**, aplicando normalización en **Tercera Forma Normal (3NF)** y definiendo correctamente las claves primarias ($PK$) y foráneas ($FK$).

2. **Creación de tablas en SQL Server**
   Las tablas fueron creadas mediante sentencias `CREATE TABLE`, garantizando la integridad referencial.

3. **Laboratorio de desempeño**
   Se compararon consultas activando estadísticas de **IO** y tiempo para analizar el impacto real de la estructura sobre el motor de base de datos.



---

## 🧠 Conclusiones Generales

### Análisis Técnico de Joins
El uso de `CROSS JOIN` genera un **producto cartesiano** entre las tablas, combinando todos los registros independientemente de su relación lógica. Esto provoca un crecimiento innecesario del conjunto de resultados:

$$R = |Tabla_{A}| \times |Tabla_{B}|$$

Este fenómeno conlleva un aumento significativo en las **Lecturas Lógicas** ($Logical \ Reads$), afectando negativamente el rendimiento. Por el contrario, el `INNER JOIN` optimiza la consulta procesando solo la información relevante:

$$\text{INNER JOIN} \implies \downarrow \text{Lecturas Lógicas} \ + \ \uparrow \text{Velocidad}$$

---

## 🗂️ Estructura del repositorio

* **/sql**: Scripts de creación de tablas, consultas y pruebas de desempeño.
* **/docs**: PDF con el diagrama entidad-relación (DER) y análisis de resultados.
* **/data**: los datos para el ejercicio.
---
