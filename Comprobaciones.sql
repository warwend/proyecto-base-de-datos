-- TC01
SELECT u.*, r.nombre_rol FROM usuario u JOIN rol r ON u.id_rol = r.id_rol;
-- TC02
SELECT * FROM usuario WHERE email_usuario IS NULL;
-- TC03
SELECT * FROM usuario WHERE id_rol NOT IN (SELECT id_rol FROM rol);
-- TC04
SELECT u.* FROM usuario u JOIN rol r ON u.id_rol = r.id_rol WHERE r.nombre_rol = 'Usuario';
-- TC05
SELECT * FROM videojuego WHERE stock < 0;
-- TC06
UPDATE videojuego SET tipo = 'Carrera' WHERE nombre_videojuego = 'Mortal Kombat';
-- TC07
SELECT * FROM videojuego;
-- TC08
UPDATE videojuego SET precio = 42000 WHERE nombre_videojuego = 'Spiderman';
-- TC09
SELECT v.nombre_videojuego FROM deseadosxusuario dxu JOIN deseados d ON dxu.id_deseados = d.id_deseados JOIN deseadosxvideojuegos dxv ON d.id_deseados = dxv.id_deseados JOIN videojuego v ON dxv.id_videojuego = v.id_videojuego WHERE dxu.id_usuario = 2;
-- TC10
SELECT id_deseados, id_videojuego, COUNT(*) FROM deseadosxvideojuegos GROUP BY id_deseados, id_videojuego HAVING COUNT(*) > 1;
-- TC11
SELECT u.nombre_usuario, v.nombre_videojuego FROM deseadosxusuario dxu JOIN usuario u ON dxu.id_usuario = u.id_usuario JOIN deseados d ON dxu.id_deseados = d.id_deseados JOIN deseadosxvideojuegos dxv ON d.id_deseados = dxv.id_deseados JOIN videojuego v ON dxv.id_videojuego = v.id_videojuego;
-- TC12
--Comprobar antes y despues: SELECT * FROM carrito;
SELECT * FROM carrito;
UPDATE carrito SET cantidad_videojuegos = cantidad_videojuegos + 1 WHERE id_carrito = 1;
SELECT * FROM carrito;
-- TC13
SELECT u.nombre_usuario, v.nombre_videojuego FROM carrito c JOIN usuario u ON c.id_usuario = u.id_usuario JOIN videojuego v ON c.id_carrito = v.id_carrito;
-- TC14
SELECT u.nombre_usuario, SUM(v.precio * c.cantidad_videojuegos) AS total FROM carrito c JOIN usuario u ON c.id_usuario = u.id_usuario JOIN videojuego v ON v.id_carrito = c.id_carrito GROUP BY u.nombre_usuario;
-- TC15
UPDATE carrito
SET cantidad_videojuegos = 
    CASE 
        WHEN cantidad_videojuegos > 0 THEN cantidad_videojuegos - 1
        ELSE 0
    END
WHERE id_carrito = 1;
-- TC16
SELECT * FROM videojuego WHERE stock > 0;
-- TC17
SELECT * FROM videojuego WHERE stock < 5;
-- TC18
SELECT * FROM videojuego WHERE stock = 0;
-- TC19
SELECT p.boleta, u.nombre_usuario, v.nombre_videojuego FROM proceso_de_compra p JOIN usuario u ON p.id_usuario = u.id_usuario JOIN carrito c ON p.boleta = c.boleta JOIN videojuego v ON c.id_carrito = v.id_carrito;
-- TC20
SELECT DISTINCT metodo_pago FROM proceso_de_compra;
-- TC21
SELECT u.nombre_usuario, v.nombre_videojuego, val.valoracion FROM usuarioxvaloracion uv JOIN usuario u ON uv.id_usuario = u.id_usuario JOIN valoracion val ON uv.id_valoracion = val.id_valoracion JOIN valoracionxvideojuego vxv ON val.id_valoracion = vxv.id_valoracion JOIN videojuego v ON vxv.id_videojuego = v.id_videojuego;
-- TC22
SELECT id_usuario, id_valoracion, COUNT(*) FROM usuarioxvaloracion GROUP BY id_usuario, id_valoracion HAVING COUNT(*) > 1;
-- TC23
SELECT v.nombre_videojuego, COUNT(*) AS valoraciones FROM valoracionxvideojuego vxv JOIN videojuego v ON vxv.id_videojuego = v.id_videojuego GROUP BY v.nombre_videojuego ORDER BY valoraciones DESC;
-- TC24
SELECT v.nombre_videojuego, COUNT(*) AS deseos FROM deseadosxvideojuegos dxv JOIN videojuego v ON dxv.id_videojuego = v.id_videojuego GROUP BY v.nombre_videojuego ORDER BY deseos DESC;
-- TC25
SELECT u.ubicación_usuario, v.nombre_videojuego FROM usuario u JOIN proceso_de_compra p ON u.id_usuario = p.id_usuario JOIN carrito c ON p.boleta = c.boleta JOIN videojuego v ON c.id_carrito = v.id_carrito;
-- TC26
SELECT v.nombre_videojuego, COUNT(*) AS veces FROM videojuego v GROUP BY v.nombre_videojuego ORDER BY veces DESC;
-- TC27
SELECT DISTINCT u.ubicación_usuario, v.nombre_videojuego FROM usuario u JOIN proceso_de_compra p ON u.id_usuario = p.id_usuario JOIN carrito c ON p.boleta = c.boleta JOIN videojuego v ON c.id_carrito = v.id_carrito;
-- TC28
INSERT INTO videojuego (url_imagen, tipo, stock, nombre_videojuego, url_videojuego, precio, id_carrito) VALUES ('imgx', 'RPG', 5, 'TriggerTest', 'urlx', 9999, 2);
-- TC29
UPDATE videojuego SET stock = stock + 1 WHERE nombre_videojuego = 'TriggerTest';
-- TC30
DELETE FROM videojuego WHERE nombre_videojuego = 'TriggerTest';
-- TC31
CALL actualizar_precio_tipo('Lucha', 15);
--TC32
SELECT * FROM obtener_ventas();
