# Proyecto: Apple Music – Gestión de Base de Datos

**Administradora de datos:** Ximena

Como administradora de datos del proyecto **Apple Music**, estas son las entidades principales necesarias para gestionar correctamente la plataforma de música, usuarios, playlists y suscripciones.

---

# Entidades principales del sistema Apple Music

## Dominio del usuario

* `USUARIO` — datos principales de los usuarios registrados.
* `PERFIL` — información pública del perfil musical del usuario.
* `SUSCRIPCION` — planes de pago del usuario.
* `METODO_PAGO` — tarjetas o métodos registrados.

---

## Dominio musical

* `ARTISTA` — cantantes o grupos musicales.
* `ALBUM` — álbumes publicados.
* `CANCION` — canciones disponibles en la plataforma.
* `GENERO` — clasificación musical.

---

## Dominio de interacción

* `PLAYLIST` — listas creadas por usuarios.
* `PLAYLIST_CANCION` — relación entre playlists y canciones.
* `FAVORITO` — canciones favoritas del usuario.
* `REPRODUCCION` — historial de canciones escuchadas.

---

# Decisiones de diseño importantes

* `duracion` se guarda en `CANCION` para conocer el tiempo exacto de reproducción.
* `PLAYLIST_CANCION` funciona como tabla intermedia para permitir muchas canciones en muchas playlists.
* `REPRODUCCION` almacena fecha y hora para estadísticas musicales.
* `SUSCRIPCION` se separa de `USUARIO` para permitir cambios de plan sin afectar los datos personales.

---

# Script SQL — bdamazon.sql adaptado a Apple Music

```sql
CREATE DATABASE apple_music_ximena;
USE apple_music_ximena;

-- =========================================
-- TABLA: USUARIO
-- =========================================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    fecha_registro DATE NOT NULL,
    pais VARCHAR(50),
    estado_cuenta VARCHAR(30) NOT NULL
);

-- =========================================
-- TABLA: PERFIL
-- =========================================
CREATE TABLE perfil (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    foto VARCHAR(255),
    biografia TEXT,
    genero_favorito VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABLA: SUSCRIPCION
-- =========================================
CREATE TABLE suscripcion (
    id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo_plan VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABLA: METODO_PAGO
-- =========================================
CREATE TABLE metodo_pago (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo_tarjeta VARCHAR(50),
    numero_tarjeta VARCHAR(20),
    fecha_expiracion DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABLA: ARTISTA
-- =========================================
CREATE TABLE artista (
    id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nombre_artistico VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    fecha_debut DATE
);

-- =========================================
-- TABLA: GENERO
-- =========================================
CREATE TABLE genero (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nombre_genero VARCHAR(50) NOT NULL
);

-- =========================================
-- TABLA: ALBUM
-- =========================================
CREATE TABLE album (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    id_artista INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    fecha_lanzamiento DATE,
    portada VARCHAR(255),
    FOREIGN KEY (id_artista) REFERENCES artista(id_artista)
);

-- =========================================
-- TABLA: CANCION
-- =========================================
CREATE TABLE cancion (
    id_cancion INT AUTO_INCREMENT PRIMARY KEY,
    id_album INT NOT NULL,
    id_genero INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    duracion TIME NOT NULL,
    reproducciones INT DEFAULT 0,
    FOREIGN KEY (id_album) REFERENCES album(id_album),
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);

-- =========================================
-- TABLA: PLAYLIST
-- =========================================
CREATE TABLE playlist (
    id_playlist INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABLA: PLAYLIST_CANCION
-- =========================================
CREATE TABLE playlist_cancion (
    id_playlist INT NOT NULL,
    id_cancion INT NOT NULL,
    PRIMARY KEY (id_playlist, id_cancion),
    FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion)
);

-- =========================================
-- TABLA: FAVORITO
-- =========================================
CREATE TABLE favorito (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    fecha_agregado DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion)
);

-- =========================================
-- TABLA: REPRODUCCION
-- =========================================
CREATE TABLE reproduccion (
    id_reproduccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_cancion INT NOT NULL,
    fecha_reproduccion DATETIME NOT NULL,
    dispositivo VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion)
);
```

Con estas 12 entidades ya tienes una base de datos bastante completa para un proyecto tipo Apple Music, incluyendo usuarios, canciones, playlists, favoritos y suscripciones.
