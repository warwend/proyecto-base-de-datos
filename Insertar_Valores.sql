INSERT INTO ROL VALUES (DEFAULT, 'Permisos Jefe tienda', 'Jefe Tienda');
INSERT INTO ROL VALUES (DEFAULT, 'Permisos Usuario', 'Usuario');
INSERT INTO ROL VALUES (DEFAULT, 'Permisos Administrador', 'Administrador');
INSERT INTO USUARIO VALUES (DEFAULT, '123513', 'pedro@mail.com', 'Peñalolen', 'Pedro02', 1);
INSERT INTO USUARIO VALUES (DEFAULT, '21341', 'samuel@mail.com', 'La Calera', 'Samuel10', 2);
INSERT INTO USUARIO VALUES (DEFAULT, '54113', 'eduardo@mail.com', 'Puente alto', 'Eduardo00', 3);
INSERT INTO USUARIO VALUES (DEFAULT, '8765346', 'darwin@mail.com', 'Paine', 'Darwin123', 2);
INSERT INTO USUARIO VALUES (DEFAULT, '6412913', 'benjamin@mail.com', 'Pucon', 'Benja1', 2);
INSERT INTO ranking VALUES (DEFAULT, 'Mas ventas');
INSERT INTO ranking VALUES (DEFAULT, 'Mas deseados');
INSERT INTO proceso_de_compra VALUES ('BOL001', 'Debito');
INSERT INTO proceso_de_compra VALUES ('BOL002', 'Credito');
INSERT INTO proceso_de_compra VALUES ('BOL003', 'Mercado Pago');
INSERT INTO CARRITO VALUES (DEFAULT, 10, 'BOL001', 2);
INSERT INTO CARRITO VALUES (DEFAULT, 8, 'BOL002', 2);
INSERT INTO CARRITO VALUES (DEFAULT, 4, 'BOL003', 3);
INSERT INTO categoria_permitida (nombre_videojuego, categoria_correcta)
VALUES
    ('Mortal Kombat', 'Lucha'),
    ('Overcooked', 'Comida'),
    ('Spiderman', 'Aventura');
INSERT INTO videojuego (
  url_imagen, tipo, stock, nombre_videojuego, url_videojuego, precio, id_carrito
)
VALUES
('urlimg1', 'Lucha', 11, 'Mortal Kombat', 'urlgame1', 30000, 2),
('urlimg2', 'Comida', 10, 'Overcooked', 'urlgame2', 18000, 2),
('urlimg3', 'Aventura', 20, 'Spiderman', 'urlgame3', 35000, 2);
INSERT INTO deseados VALUES (DEFAULT, 'Lista Deseados1', 2);
INSERT INTO deseados VALUES (DEFAULT, 'Lista Deseados2', 2);
INSERT INTO deseados VALUES (DEFAULT, 'Lista Deseados5', 2);
INSERT INTO VALORACION VALUES (DEFAULT, 'GOTY', 2);
INSERT INTO VALORACION VALUES (DEFAULT, 'Mas o menos el juego', 1);
INSERT INTO VALORACION VALUES (DEFAULT, 'Me gusto mucho', 2);
INSERT INTO VALORACION VALUES (DEFAULT, 'Buenísimo', 1);
INSERT INTO DESEADOSxVIDEOJUEGOS VALUES (2, 2);
INSERT INTO DESEADOSxVIDEOJUEGOS VALUES (1, 3);
INSERT INTO DESEADOSxVIDEOJUEGOS VALUES (3, 2);
INSERT INTO VALORACIONxVIDEOJUEGO VALUES (1, 1);
INSERT INTO VALORACIONxVIDEOJUEGO VALUES (2, 3);
INSERT INTO VALORACIONxVIDEOJUEGO VALUES (1, 2);
INSERT INTO VALORACIONxVIDEOJUEGO VALUES (4, 1);
INSERT INTO USUARIOxVALORACION VALUES (2, 2);
INSERT INTO USUARIOxVALORACION VALUES (1, 1);
INSERT INTO USUARIOxVALORACION VALUES (3, 1);
INSERT INTO DESEADOSxUSUARIO VALUES (1, 2);
INSERT INTO DESEADOSxUSUARIO VALUES (2, 1);
INSERT INTO DESEADOSxUSUARIO VALUES (3, 2);
