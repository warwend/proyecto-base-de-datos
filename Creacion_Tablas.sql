CREATE TABLE ranking (
  id_ranking SERIAL PRIMARY KEY,
  tipo_ranking VARCHAR(20)
);

CREATE TABLE ROL (
    id_rol SERIAL PRIMARY KEY,
    permisos VARCHAR(100) NOT NULL,
    nombre_rol VARCHAR(100) NOT NULL
);

CREATE TABLE USUARIO (
    id_usuario SERIAL PRIMARY KEY,
    contraseña_usuario VARCHAR(20) NOT NULL,
    email_usuario VARCHAR(20) NOT NULL,
    ubicación_usuario VARCHAR(20) NOT NULL,
    nombre_usuario VARCHAR(15) NOT NULL,
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

CREATE TABLE proceso_de_compra ( 
  boleta VARCHAR(1000) PRIMARY KEY, 
  metodo_pago VARCHAR(20) NOT NULL,
  fecha_compra DATE DEFAULT CURRENT_DATE,
  id_usuario INT,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE CARRITO(
    id_carrito SERIAL PRIMARY KEY,
    cantidad_videojuegos INT NOT NULL,
    boleta VARCHAR(1000) NOT NULL,
    id_usuario INT,
    FOREIGN KEY(boleta) REFERENCES PROCESO_DE_COMPRA(boleta),
    FOREIGN KEY(id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE VIDEOJUEGO(
    id_videojuego SERIAL PRIMARY KEY,
    url_imagen VARCHAR(20) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    stock INT,
    nombre_videojuego VARCHAR(20) NOT NULL,
    url_videojuego VARCHAR(20) NOT NULL,
    precio INT NOT NULL,
    id_carrito INT,
    FOREIGN KEY(id_carrito) REFERENCES CARRITO(id_carrito)
);

CREATE TABLE deseados (
  id_deseados SERIAL PRIMARY KEY,
  lista_de_deseados VARCHAR(200) NOT NULL,
  id_ranking INT,
  FOREIGN KEY (id_ranking) REFERENCES ranking(id_ranking)
);

CREATE TABLE VALORACION (
    id_valoracion SERIAL PRIMARY KEY,
    valoracion VARCHAR(500),
    id_ranking INT,
    FOREIGN KEY (id_ranking) REFERENCES ranking(id_ranking)
);

CREATE TABLE DESEADOSxVIDEOJUEGOS (
    id_deseados INT,
    id_videojuego INT,
    FOREIGN KEY (id_deseados) REFERENCES deseados(id_deseados),
    FOREIGN KEY (id_videojuego) REFERENCES videojuego(id_videojuego),
    UNIQUE (id_deseados, id_videojuego)
);

CREATE TABLE categoria_permitida (
    nombre_videojuego VARCHAR(20) PRIMARY KEY,
    categoria_correcta VARCHAR(20) NOT NULL
);

CREATE TABLE VALORACIONxVIDEOJUEGO (
    id_valoracion INT,
    id_videojuego INT,
    FOREIGN KEY (id_valoracion) REFERENCES valoracion(id_valoracion),
    FOREIGN KEY (id_videojuego) REFERENCES videojuego(id_videojuego)
);

CREATE TABLE USUARIOxVALORACION (
    id_usuario INT,
    id_valoracion INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_valoracion) REFERENCES valoracion(id_valoracion),
    UNIQUE (id_usuario, id_valoracion)
);

CREATE TABLE DESEADOSxUSUARIO (
    id_deseados INT,
    id_usuario INT,
    FOREIGN KEY (id_deseados) REFERENCES deseados(id_deseados),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);
CREATE OR REPLACE FUNCTION log_videojuego_modificaciones()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        RAISE NOTICE 'INSERT sobre videojuego: %', NEW.nombre_videojuego;
    ELSIF TG_OP = 'UPDATE' THEN
        RAISE NOTICE 'UPDATE sobre videojuego: %', NEW.nombre_videojuego;
    ELSIF TG_OP = 'DELETE' THEN
        RAISE NOTICE 'DELETE sobre videojuego: %', OLD.nombre_videojuego;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_auditoria_videojuego ON videojuego;

CREATE TRIGGER trg_auditoria_videojuego
AFTER INSERT OR UPDATE OR DELETE ON videojuego
FOR EACH ROW
EXECUTE FUNCTION log_videojuego_modificaciones();

CREATE OR REPLACE PROCEDURE actualizar_precio_tipo(tipo_juego VARCHAR, nuevo_precio INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE videojuego
    SET precio = nuevo_precio
    WHERE tipo = tipo_juego;
END;
$$;

CREATE OR REPLACE PROCEDURE reporte_ventas_usuario(id_usuario INT)
LANGUAGE plpgsql
AS $$
DECLARE
    nombre_juego TEXT;
BEGIN
    RAISE NOTICE 'Videojuegos comprados por el usuario %:', id_usuario;

    FOR nombre_juego IN
        SELECT v.nombre_videojuego
        FROM videojuego v
        JOIN carrito c ON v.id_carrito = c.id_carrito
        WHERE c.id_usuario = id_usuario
    LOOP
        RAISE NOTICE '- %', nombre_juego;
    END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION obtener_ventas()
RETURNS TABLE (
    nombre_usuario VARCHAR,
    nombre_videojuego VARCHAR,
    fecha_compra DATE,
    monto INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        u.nombre_usuario,
        v.nombre_videojuego,
        p.fecha_compra,
        v.precio
    FROM 
        usuario u
    JOIN 
        proceso_de_compra p ON u.id_usuario = p.id_usuario
    JOIN 
        carrito c ON p.boleta = c.boleta
    JOIN 
        videojuego v ON c.id_carrito = v.id_carrito;
END;
$$;
--comprobacion 6
CREATE OR REPLACE FUNCTION validar_categoria_videojuego()
RETURNS TRIGGER AS $$
DECLARE
    tipo_valido TEXT;
BEGIN
    SELECT categoria_correcta INTO tipo_valido
    FROM categoria_permitida
    WHERE nombre_videojuego = NEW.nombre_videojuego;

    IF tipo_valido IS NOT NULL AND tipo_valido <> NEW.tipo THEN
        RAISE EXCEPTION 'Categoría incorrecta para el videojuego %: se esperaba "%", pero se ingresó "%".',
        NEW.nombre_videojuego, tipo_valido, NEW.tipo;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_categoria
BEFORE INSERT OR UPDATE ON videojuego
FOR EACH ROW
EXECUTE FUNCTION validar_categoria_videojuego();
