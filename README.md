# Auction

Trabajo de fin de grado - Josué García Asensi

No voy a pararme a explicar todo el código que hay escrito claramente, en este apartado simplemente me voy a ceñir a explicar la estructura, los ficheros y carpetas que hay para que tengamos una pequeña idea de cómo está hecho y para que podamos navegar por él.

![image](https://user-images.githubusercontent.com/72017676/235891718-93e196b2-146c-404c-b1e3-1e8f27c5b2c7.png)

<p align="center">
Figura 1 - Carpeta principal del proyecto
</p>

Esta es la apariencia de cualquier proyecto de Flutter, de forma muy breve (ya que aquí no están los archivos con el código fuente) voy a explicar las carpetas y archivos más importantes de un proyecto Flutter.

- Carpetas ```android```, ```ios```, ```linux```, ```macos```, ```web``` y ```windows```: Contienen código en lenguaje nativo de cada sistema para compilar y construir el proyecto de Flutter en cada uno de estos lenguajes. Estas carpetas son creadas por defecto por Flutter.

- Carpeta ```build```: Contiene las compilaciones para cada sistema, es volátil, se actualiza cada vez que ejecutamos o compilamos el proyecto. Borrarla no daña ni afecta al proyecto.

- Carpeta ```assets```: Esta carpeta ha sido creada por mí, contiene imágenes que uso de forma continua, para no tener que descargarlas cada vez que se cargan, por ejemplo, el logo de la aplicación.
- Carpeta lib: Contiene todo el código fuente programado. La explicaremos a continuación.

- Archivo ```pubspec.yaml```: Contiene todos los metadatos del proyecto como el nombre, la descripción y en este archivo se incluyen también las librerías externas que he mencionado en el punto anterior.

![image](https://user-images.githubusercontent.com/72017676/235891744-61a82246-78cd-4998-86dd-18b4f1fddaa2.png)

<p align="center">
Figura 2 - Carpeta lib Proyecto
</p>

Entrando en la carpeta lib, ya nos encontramos con todo el código fuente. La carpeta lib viene únicamente con el fichero main.dart, el resto ha sido creado por mí durante el desarrollo del proyecto. De nuevo, haré una breve explicación de cada elemento:

- Archivo main.dart: Como podemos imaginar, es el archivo principal, donde se define la aplicación y el punto de partida a la hora de ejecutarla.

- Carpeta ```screens```: Contiene las pantallas que se muestran en la aplicación, la pantalla principal, la pantalla de inicio de sesión, la de registro, etc.

- Carpeta ```widgets```: Son elementos pequeños que se utilizan dentro de las pantallas, por ejemplo, un botón específico, la tarjeta de los productos, la barra de búsqueda y más.

- Carpeta ```models```: Contiene los archivos con la representación de cada objeto de la base de datos en Dart.

- Carpeta ```db```: Archivos con las funciones que realizan acciones sobre la base de datos, para leer, crear, borrar o eliminar objetos.

- Carpeta ```controllers```: En las pantallas más complejas a nivel de lógica, me gusta hacer una separación para que el código no sea complejo de leer. La lógica de esas pantallas pasa a estar escrita en los archivos esta carpeta.

- Archivos restantes: Quedan dos archivos en la carpeta lib que son simplemente archivos que usa Firebase para controlar los datos de la aplicación y la autenticación de usuarios.

Todos los archivos y carpetas tienen nombres bastante descriptivos para facilitar la programación y para facilitar la lectura.
