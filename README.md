# Cocina a Tiempo

Cocina a Tiempo es una aplicación móvil diseñada para facilitar la preparación de alimentos en el hogar. Su propósito es ofrecerle a los usuarios una plataforma organizada donde pueden crear una serie de temporizadores referentes a los tiempos de cocción de diferentes alimentos, además pueden ver los tiempos de cocción de diferentes ingredientes y recetas, con el objetivo de poder cocinar una de estas sabiendo el tiempo de cocción, siendo esto conveniente para personas que no tengan tanta experiencia cocinando y manejando tiempos a la vez.

## Público objetivo
- Personas que cocinan en casa.
- Usuarios que desean mejorar su organización al cocinar múltiples ingredientes a la vez.
- Usuarios que buscan eficiencia y control de tiempo a la hora de cocinar.

## Funcionalidades principales
- El usuario puede crear varios temporizadores personalizados para llevar un control preciso de la cocción.
- El usuario puede consultar una lista precargada de ingredientes comunes con sus tiempos de cocción sugeridos.
- El usuario puede explorar un recetario con preparaciones paso a paso y tiempos de cocción por componente.
- El usuario puede modificar el tiempo de cocción sugerido para ajustarlo a su experiencia personal.
- El usuario puede añadir, editar y eliminar la lista de alimentos de la aplicación.
- El usuario puede gestionar preferencias de usuario como sonido, unidad de medida, color del tema, etc.
- El usuario recibe una alerta visual y sonora al finalizar un temporizador.

## Características principales
- **Navegación Intuitiva:** Uso de un menú lateral (drawer) para acceder a las diferentes secciones, como ingredientes, recetas, temporizadores y perfil del usuario.
- **Splash Screen Personalizado:** Pantalla de inicio con logotipo o isotipo de la aplicación para mejorar la experiencia del usuario y reforzar la identidad del proyecto.
- **Gestión de Ingredientes:**
  - Lista de ingredientes precargados con tiempos de cocción.
  - Posibilidad de añadir, editar y eliminar ingredientes personalizados.
  - Visualización de ingredientes en formato de lista, con nombres y tiempos de cocción claramente presentados.
  - A futuro, va a tener una función de búsqueda por voz de ingredientes.
- **Temporizadores Personalizables:**
  - Creación de múltiples temporizadores con etiquetas personalizables.
  - Opciones para pausar, reanudar, reiniciar y eliminar temporizadores.
  - Notificaciones sonoras y visuales al finalizar cada temporizador.
- **Base de Datos de Recetas:**
  - Recetario integrado con instrucciones paso a paso y tiempos específicos para cada componente de la receta.
  - Posibilidad de personalizar los tiempos de cocción según la experiencia del usuario.
- **Estructura Modular del Código:** El proyecto está organizado para facilitar la adición de nuevas funcionalidades y componentes en el futuro.
- **Compatibilidad con Múltiples Dispositivos:** Diseño responsive para asegurar que la aplicación funcione correctamente en diferentes tamaños de pantalla.
- **Preferencias con SharedPreferences:** Configuraciones del usuario guardadas entre sesiones.
- **Pantalla "Acerca de":** Información de autoría, propósito y contacto.

## Estructura del Proyecto
- **lib/pages/**: Código principal de la aplicación, divido en las diferentes pantallas.
- **lib/widgets/**: Código de widgets presentes en varias pantallas, como el widget drawer.
- **lib/database/:** Modelos y DBHelper con SQLite.
- **lib/json/:** Archivo feedback_questions.json.
- **assets/**: Recursos como imágenes e íconos.
- **README.md**: Archivo de documentación del proyecto.

## Diagrama de clases
[Ver diagrama en Google Drive](https://drive.google.com/file/d/1RSONdG0V_OCtlroQR_jQ-wnltirTIOce/view?usp=sharing)

## Diagrama de jerarquía de acceso a las pantallas
[Ver diagrama en Google Drive](https://drive.google.com/file/d/1GyLTvnq8bUlbRLqmx6iCgsL4IB2SM60e/view?usp=sharing)

## Diagrama de caso de uso
[Ver diagrama en Google Drive](https://drive.google.com/drive/u/1/folders/1ist2j3TkekbMUupbaqhE3cWFctfNjqot)

## Tecnologías Utilizadas
- Flutter : Framework de trabajo
- Dart : Lenguaje de programación
- Visual Studio Code
- GitHub : Control de versiones

## Próximos Pasos
- Añadir funciones avanzadas como ajuste de notificaciones y perfiles de usuario.
- Añadir más ingredientes y recetas para crear una experiencia más útil.
- Implementar ajustes de preferencias.
- Implementar las funcionalidades pendientes.

## Link video explicativo
- https://drive.google.com/file/d/19hqIYPRnD1thqt12M6hr4sfqEAw3VN6M/view?usp=sharing
