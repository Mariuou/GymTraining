# GymTraining
Sistema de gimnasio , desarrollo de módulos de training

## Organigrama de equipo

<p align="center">
  <img src="Img/ORGANIGRAMA.png?raw=true" alt="Organigrama de equipo">
</p>

| Nombre Completo              | Cargo                   | 
|------------------------------|-------------------------|
| Mario Gutierrez Rosales      | Lider/DB Manager        |                     
| Marco Antonio Morales Rivera | Documentador            |                        
| Jorge Cruz Cazarez           | Desarrollador Backend   |                            
| Suri Jazmin Peña Lira        | Desarrollador Frontend  |
                      

## Objetivo General
Desarrollar un módulo de entrenamiento dentro del sistema web de un gimnasio. Este módulo estará destinado a optimizar la gestión integral de la institución, brindando una plataforma digital que mejore la experiencia tanto de los empleados como de los miembros. Además, se buscará proporcionar herramientas que faciliten la creación, seguimiento y personalización de programas de entrenamiento, rutinas de ejercicios y sesiones específicas para los clientes del gimnasio todo esto con el apoyo de instructores y el uso de una dieta adecuada, promoviendo así la adopción de hábitos saludables y una mejor interacción entre el personal y los usuarios.

## Objetivos Específicos
1. **Inicio de Sesión:** Diseñar una interfaz de inicio de sesión intuitiva y atractiva, segura que permita a los usuarios acceder al sistema web del gimnasio.siguiendo el diseño presentado en el mockup.

2. **Módulo de Creación de Rutinas:** Desarrollar un formulario de creación de rutinas que permita a los instructores agregar nuevos ejercicios, establecer repeticiones, series y descansos, validando los datos ingresados para evitar errores y garantizar la coherencia de las rutinas creadas.
  

3. **Módulo de Lectura de Rutinas:** Diseñar una interfaz limpia y fácil de entender que muestre las rutinas existentes de forma clara y ordenada, permitiendo a los usuarios ver detalles específicos de cada rutina, como ejercicios incluidos, series y repeticiones.
   
4. **Módulo de Actualización de Rutinas:** Habilitar la edición de rutinas existentes, permitiendo a los instructores realizar cambios en los ejercicios, repeticiones y otros detalles según sea necesario.

5. **Módulo de Eliminación de Rutinas:** Integrar una función de eliminación que permita a los instructores eliminar rutinas obsoletas o incorrectas de manera segura y eficiente.
   
6. **Módulo de Programas Saludables:** Diseñar una página que muestre información detallada sobre los programas saludables ofrecidos por el gimnasio, siguiendo el diseño presentado en el mockup. Mostrar tablas con datos relevantes, como nombres de programas, descripciones y beneficios.
  
7. **Dashboard de Seguimiento:** Desarrollar un dashboard interactivo que proporcione a los usuarios una visión general de su progreso en el gimnasio. Incluir gráficos y estadísticas que muestren datos clave, como el rendimiento en las rutinas, la frecuencia de entrenamiento y el cumplimiento de los programas saludables.


## Requerimientos Funcionales
* El sistema debe de asignar permisos y accesos específicos a cada rol de usuario.                                  
* El sistema debe de realizar las siguientes operaciones en el apartado de rutinas: creación, edición, eliminación y actualización.      
* El sistema debe de contener un apartado que muestre la información de los programas saludables disponibles en el gimnasio.                                                                                         
* El sistema debe de mostrar un monitoreo de los programas de los miembros.
* El sistema debe realizar operaciones de lectura a tablas externas del departamento de training (Dietas).
* El sistema debe permitir operaciones CRUD a miembros en el apartado de rutinas.
* El sistema debe permitir visualización y filtro de programas saludables disponibles para los miembros.
* El sistema debe reflejar el seguimiento del programa saludable por medio de una gráfica.
* El sistema debe reflejar el seguimiento del programa saludable al que el usuario este inscrito.
* El sistema debe mostrar únicamente las vistas que le correspondan al departamento.
* El sistema tiene que incluir 4 dashboard de monitoreo.
* El sistema tiene que incluir 2 dashboard con una base de datos SQL.
* El sistema tiene que incluir 2 dashboard con una base de datos NoSQL.
* El sistema debe de contener datos dinámicos.
* El sistema debe de contener un archivo técnico de documentación.

## Requerimientos No Funcionales
* El sistema web debe ser capaz de soportar una gran cantidad de usuarios simultáneos sin afectar el rendimiento. 
* El tiempo de respuesta del sistema debe ser rápido y fluido, además las páginas web deben cargarse rápidamente.
* El sistema debe ser escalable para poder adaptarse al crecimiento del gimnasio.
* Se deben implementar medidas de seguridad para evitar el acceso no autorizado a la información, como cifrado de datos.
* El sistema debe de cumplir con las leyes de protección de datos.
* El sistema web debe ser fácil de usar para todos los usuarios, la interfaz de usuario tiene que ser intuitiva y sencilla.
* El sistema web debe proteger la información confidencial de los clientes y del personal.
* Se debe proporcionar una documentación completa del sistema web.
* El sistema tiene que incluir un archivo documentación con información sobre uso del sistema web.
* La documentación debe incluir un organigrama de trabajo.

## Reglas de Negocio 
* Los entrenadores deben comunicarse claramente con los clientes y estar disponibles para discutir su progreso y cualquier inquietud que puedan tener.
* Cada cliente debe recibir un plan de entrenamiento personalizado según sus objetivos y necesidades específicas.
* Los entrenadores deben mantenerse actualizados en las últimas tendencias de fitness y técnicas de entrenamiento a través de la capacitación continua.
* Los entrenadores deben ser conscientes de la diversidad de los clientes y adaptar sus enfoques de entrenamiento según las necesidades individuales.
* Los entrenadores deben colaborar con otros departamentos del gimnasio, como nutrición, para ofrecer un enfoque integral para el bienestar de los clientes.
* Se espera que los entrenadores mantengan los estándares de calidad del gimnasio y representen a la marca de manera positiva en todo momento.
* Los entrenadores deben proporcionar retroalimentación constructiva a los clientes para ayudarles a mejorar su técnica y alcanzar sus objetivos.
* Los entrenadores deben seguir un código ético que prohíba cualquier tipo de comportamiento inapropiado o abusivo hacia los clientes.
* Se espera que los entrenadores motiven y alienten a los clientes para que alcancen sus objetivos.
* Los entrenadores deben ser flexibles para adaptarse a las necesidades cambiantes de los clientes y reprogramar sesiones según sea necesario.
* Los entrenadores deben mantener registros precisos del progreso de cada cliente y ajustar sus programas según sea necesario.
* Los entrenadores deben respetar la privacidad y confidencialidad de la información personal de los clientes.
* Se espera que los entrenadores traten a los clientes con respeto y consideración en todo momento, independientemente de su nivel de condición física.
* Se prohíbe a los miembros del gimnasio participar en discusiones agresivas, peleas o cualquier actividad que perturbe el ambiente de entrenamiento.
* Se prohíbe a los miembros llevar comida o bebida no autorizada en las áreas de entrenamiento, excepto aquellas permitidas por el gimnasio para su consumo durante el ejercicio.
* Se prohíbe a los miembros participar en cualquier conducta inapropiada, incluyendo acoso, discriminación, o cualquier comportamiento que haga sentir incómodos a otros usuarios del gimnasio.
* Los instructores pueden crear y gestionar las clases. 
* Se puede registrar y gestionar las rutinas del gimnasio en el sistema web. 
* Los miembros no pueden tener un dashboard de seguimiento hasta que estén inscritos en un programa saludable.
* No se pueden realizar operaciones CRUD si nos son instructores verificados.

## MOCKUPS
<p align="center">
**Inicio de Sesión:**
  <img src="Img/MKPS1.png?raw=true" alt="Diseño"> <br>
  **Rutinas (Create):**
  <img src="Img/MKPS2.png?raw=true" alt="Diseño"><br>
  **Rutinas (Read):**
  <img src="Img/MKPS3.png?raw=true" alt="Diseño"><br>
  **Rutinas (Update):**
  <img src="Img/MKPS4.png?raw=true" alt="Diseño"><br>
  **Rutinas (Delete):**
  <img src="Img/MKPS5.png?raw=true" alt="Diseño"><br>
  **Programa Saludable (Tablas):**
  <img src="Img/MKPS6.png?raw=true" alt="Diseño"><br>
  **Dashboard de seguimiento:**
  <img src="Img/MKPS7.png?raw=true" alt="Diseño"><br>
</p>


 
