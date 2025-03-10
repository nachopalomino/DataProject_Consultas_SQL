# DataProject: Lógica de Consultas SQL

## 📖 1. Descripción

Este proyecto consiste en la creación de una base de datos y la realización de diversas consultas SQL para extraer información relevante. A través de este ejercicio, se aplican **conocimientos fundamentales de SQL**, incluyendo:

- Filtros y condiciones (WHERE, HAVING)

- Agrupaciones y funciones agregadas (GROUP BY, COUNT, SUM, etc.)

- Combinaciones de tablas (JOIN, INNER JOIN, LEFT JOIN, etc.)

- Análisis de datos y patrones en la información obtenida

## 📂 2. Contenido del Proyecto

El proyecto está estructurado en los siguientes **componentes**:

1. Creación del esquema de la base de datos

2. Ejecución de consultas SQL para analizar información clave

3. Obtención de estadísticas y patrones en los datos disponibles

## ⚙️ 3. Tecnologías Utilizadas

Este proyecto puede ejecutarse en distintos **sistemas de gestión de bases de datos (SGBD)**:

- SQL (lenguaje principal para consultas)

- PostgreSQL

### **Herramientas de administración**:

- DBeaver

- pgAdmin

- MySQL Workbench

##  🗄️ 4. Estructura de la Base de Datos

La base de datos contiene las siguientes tablas principales:

- 🎭 **actor**: Información sobre los actores

- 🏷️ **category**: Categorías de las películas

- 🎬 **film**:Detalles de las películas

- 🔗 **film_actor**: Relación entre actores y películas

- 🔗 **film_category**: Relación entre películas y categorías

- 📍 **address**: Direcciones de clientes o tiendas

- 🌆 **city**: Ciudades asociadas a direcciones

- 🌍 **country**: Países asociados a direcciones

- 🧑‍💼 **customer**: Información sobre los clientes

- 📦 **inventory**: Inventario de películas en las tiendas

## 🚀 5. Pasos del Proyecto

1. Creación del esquema de la BBDD

2. Consultas básicas

3. Consultas de filtrado y agregación

4. Análisis de clientes y alquileres

5. Análisis avanzado

## 📊 6. Informe de Análisis

Durante la ejecución del proyecto se identificaron los siguientes hallazgos clave:

- Clasificaciones de películas: La mayoría se encuentran en las categorías PG-13 y R.

- Duraciones promedio: Las películas tienen una duración promedio de aproximadamente 120 minutos, con algunas superando las 3 horas.

- Patrones de alquiler: Se detectó que los meses con más alquileres coinciden con temporadas de vacaciones.

- Clientes frecuentes: Un grupo reducido de clientes genera la mayor parte de los ingresos, sugiriendo la implementación de programas de fidelización.

- Actores más recurrentes: Algunos actores han participado en más de 40 películas, lo que los convierte en figuras clave del catálogo.

## 🛠 7. Instalación y Uso

Para **ejecutar este proyecto**, sigue estos pasos:

1. Clona el repositorio: git clone https://github.com/tuusuario/DataProject-SQL.git

2. Importa el esquema de la base de datos en tu gestor de bases de datos preferido.

3. Ejecuta las consultas proporcionadas en el directorio queries/.

4. Analiza los resultados y explora posibles mejoras.

## 📝 8. Contribuciones

**¡Las contribuciones son bienvenidas!** Si deseas colaborar, sigue estos pasos:

1. Haz un **fork del repositorio**.

2. **Crea una rama** para tu nueva funcionalidad o corrección de errores: git checkout -b feature/nueva-funcionalidad

3. Realiza tus cambios y confirma los **commits**: git commit -m "Agregada nueva consulta para análisis de clientes frecuentes"

4. Envía un **Pull Request** con tus modificaciones.

## 📜 9. Licencia

Este proyecto está bajo la **licencia MIT**. Puedes usarlo, modificarlo y distribuirlo libremente.


#### 📌 Autor: nachopalomino
#### 📧 Contacto: nachopalominotoledano@gmail.com
#### 🌐 Repositorio: GitHub - DataProject_Consultas_SQL

