PROYECTO BASE DE DATOS  - PLATAFORMA DE VIDEOJUEGOS 

Este proyecto implementa una base de datos relacional para gestionar una plataforma de venta, valoración y administración de videojuegos, usuarios y carritos de compra. Permite realizar operaciones como seguimiento de compras, rankings, listas de deseados y valoraciones.

EQUIPO DE DESARROLLO

-Darwin Gutierrez
-Benjamin Monardez
-Eduardo Velasquez
-Pedro Rodriguez Campos
-Jordan Ibarra 

APORTES AL PROYECTO

Todos los integrantes aportaron de forma equitativa al proyecto, la mayoria de cambios se realizaron en persona o atravez de otras plataformas.
El integrante Jordan Ibarra no pudo aparecer en el video del proyecto debido a problemas personales, pero como se dijo con anterioridad si trabajo
durante toda la realizacion del proyecto como todos los integrantes.

CARACTERISTICAS 

Gestión de usuarios y roles: Control de acceso mediante roles con distintos permisos.

Inventario de videojuegos: Registro detallado de videojuegos, incluyendo tipo, stock, precio, imágenes y enlaces.

Proceso de compra: Seguimiento completo de la compra desde el carrito hasta la boleta.

Ranking y valoraciones: Registro de rankings, valoraciones por usuario y vínculos con los videojuegos.

Listas de deseados: Asociación entre usuarios, listas deseadas y videojuegos.

Auditoría y validaciones: Uso de triggers para registrar operaciones sobre videojuegos y verificar integridad de datos.

Procedimientos almacenados: Reportes automáticos por usuario y actualizaciones masivas de precios.

ESTRUCTURA DE LA BASE DE DATOS 

Tablas principales:
USUARIO, ROL: Información personal y control de acceso.
VIDEOJUEGO, CARRITO, PROCESO_DE_COMPRA: Gestión de productos y ventas.
DESEADOS, VALORACION, RANKING: Funcionalidades sociales y de interacción,
Tablas intermedias (relaciones N:M):
DESEADOSxVIDEOJUEGOS, VALORACIONxVIDEOJUEGO, USUARIOxVALORACION, DESEADOSxUSUARIO

TRIGGERS:

trg_auditoria_videojuego: Muestra mensajes al insertar, modificar o eliminar videojuegos.
Procedimientos:
actualizar_precio_tipo(tipo, precio): Cambia el precio de todos los juegos de un tipo específico.
reporte_ventas_usuario(id_usuario): Muestra los videojuegos comprados por un usuario.

USO

Ejecuta los scripts de creación e inserción para inicializar la base de datos.
Utiliza consultas como:
Mostrar valoraciones por usuario y videojuego.
Listar videojuegos más deseados o mejor valorados.
Actualizar precios por categoría.
Generar reportes de compra por usuario.
Usa los triggers y procedimientos para mantener control y automatización del sistema.

Ejemplo de Consulta
```sql
SELECT u.nombre_usuario, v.nombre_videojuego
FROM deseadosxusuario dxu
JOIN usuario u ON dxu.id_usuario = u.id_usuario
JOIN deseados d ON dxu.id_deseados = d.id_deseados
JOIN deseadosxvideojuegos dxv ON d.id_deseados = dxv.id_deseados
JOIN videojuego v ON dxv.id_videojuego = v.id_videojuego;
