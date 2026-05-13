-- =========================================
-- BASE DE DATOS APPLE MUSIC XIMENA
-- =========================================

CREATE DATABASE IF NOT EXISTS apple_music_ximena;
USE apple_music_ximena;

-- =========================================
-- DOMINIO USUARIO
-- =========================================

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(100) NOT NULL,
    fecha_registro DATE NOT NULL,
    estado_cuenta VARCHAR(50) NOT NULL
);

CREATE TABLE PERFIL (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    foto VARCHAR(255),
    biografia TEXT,
    genero_favorito VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE SUSCRIPCION (
    id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo_plan VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE METODO_PAGO (
    id_metodo_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    numero_tarjeta VARCHAR(20),
    fecha_expiracion DATE,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- =========================================
-- DOMINIO MUSICAL
-- =========================================

CREATE TABLE ARTISTA (
    id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nombre_artistico VARCHAR(100) NOT NULL,
    pais VARCHAR(100),
    fecha_debut DATE
);

CREATE TABLE GENERO (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE ALBUM (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    id_artista INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    fecha_lanzamiento DATE,
    portada VARCHAR(255),
    FOREIGN KEY (id_artista) REFERENCES ARTISTA(id_artista)
);

CREATE TABLE CANCION (
    id_cancion INT AUTO_INCREMENT PRIMARY KEY,
    id_album INT NOT NULL,
    id_genero INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    duracion TIME NOT NULL,
    reproducciones INT DEFAULT 0,
    FOREIGN KEY (id_album) REFERENCES ALBUM(id_album),
    FOREIGN KEY (id_genero) REFERENCES GENERO(id_genero)
);

-- =========================================
-- PLAYLISTS Y FAVORITOS
-- =========================================

CREATE TABLE PLAYLIST (
    id_playlist INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_creacion DATE,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE PLAYLIST_CANCION (
    id_playlist INT NOT NULL,
    id_cancion INT NOT NULL,
    PRIMARY KEY (id_playlist, id_cancion),
    FOREIGN KEY (id_playlist) REFERENCES PLAYLIST(id_playlist),
    FOREIGN KEY (id_cancion) REFERENCES CANCION(id_cancion)
);

CREATE TABLE FAVORITO (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    fecha_agregado DATETIME NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES CANCION(id_cancion)
);

-- =========================================
-- REPRODUCCIONES
-- =========================================

CREATE TABLE REPRODUCCION (
    id_reproduccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    fecha_reproduccion DATETIME NOT NULL,
    dispositivo VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES CANCION(id_cancion)
);
