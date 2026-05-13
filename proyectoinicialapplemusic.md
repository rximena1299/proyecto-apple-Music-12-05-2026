Primero te presento las entidades con sus atributos, luego genero el script SQL.

---

## 🎵 Proyecto: Base de Datos Apple Music

### Entidades y Atributos

---

**1. USUARIO**

| Atributo | Tipo | Restricción |
|---|---|---|
| usuario_id | INT | PK, AUTO_INCREMENT |
| nombre | VARCHAR(100) | NOT NULL |
| apellido | VARCHAR(100) | NOT NULL |
| email | VARCHAR(150) | UNIQUE, NOT NULL |
| fecha_nacimiento | DATE | NOT NULL |
| pais | VARCHAR(60) | NOT NULL |
| fecha_registro | DATETIME | DEFAULT NOW() |

---

**2. SUSCRIPCION**

| Atributo | Tipo | Restricción |
|---|---|---|
| suscripcion_id | INT | PK, AUTO_INCREMENT |
| usuario_id | INT | FK → USUARIO |
| tipo_plan | ENUM('Individual','Familiar','Estudiante','Apple One') | NOT NULL |
| precio_mensual | DECIMAL(6,2) | NOT NULL |
| fecha_inicio | DATE | NOT NULL |
| fecha_fin | DATE | NULL |
| estado | ENUM('Activa','Cancelada','Suspendida') | DEFAULT 'Activa' |

---

**3. ARTISTA**

| Atributo | Tipo | Restricción |
|---|---|---|
| artista_id | INT | PK, AUTO_INCREMENT |
| nombre_artistico | VARCHAR(150) | NOT NULL |
| nombre_real | VARCHAR(150) | NULL |
| pais_origen | VARCHAR(60) | NOT NULL |
| fecha_debut | DATE | NULL |
| biografia | TEXT | NULL |
| imagen_url | VARCHAR(255) | NULL |

---

**4. ALBUM**

| Atributo | Tipo | Restricción |
|---|---|---|
| album_id | INT | PK, AUTO_INCREMENT |
| artista_id | INT | FK → ARTISTA |
| titulo | VARCHAR(200) | NOT NULL |
| fecha_lanzamiento | DATE | NOT NULL |
| genero | VARCHAR(80) | NOT NULL |
| sello_discografico | VARCHAR(100) | NULL |
| portada_url | VARCHAR(255) | NULL |
| total_pistas | INT | DEFAULT 0 |

---

**5. CANCION**

| Atributo | Tipo | Restricción |
|---|---|---|
| cancion_id | INT | PK, AUTO_INCREMENT |
| album_id | INT | FK → ALBUM |
| artista_id | INT | FK → ARTISTA |
| titulo | VARCHAR(200) | NOT NULL |
| duracion_seg | INT | NOT NULL |
| numero_pista | INT | NOT NULL |
| letra | LONGTEXT | NULL |
| explicit | TINYINT(1) | DEFAULT 0 |
| reproducciones | BIGINT | DEFAULT 0 |

---

**6. PLAYLIST**

| Atributo | Tipo | Restricción |
|---|---|---|
| playlist_id | INT | PK, AUTO_INCREMENT |
| usuario_id | INT | FK → USUARIO |
| nombre | VARCHAR(150) | NOT NULL |
| descripcion | TEXT | NULL |
| es_publica | TINYINT(1) | DEFAULT 0 |
| fecha_creacion | DATETIME | DEFAULT NOW() |
| portada_url | VARCHAR(255) | NULL |

---

**7. PLAYLIST_CANCION** *(tabla intermedia)*

| Atributo | Tipo | Restricción |
|---|---|---|
| playlist_id | INT | PK, FK → PLAYLIST |
| cancion_id | INT | PK, FK → CANCION |
| posicion | INT | NOT NULL |
| fecha_agregada | DATETIME | DEFAULT NOW() |

---

**8. REPRODUCCION**

| Atributo | Tipo | Restricción |
|---|---|---|
| reproduccion_id | BIGINT | PK, AUTO_INCREMENT |
| usuario_id | INT | FK → USUARIO |
| cancion_id | INT | FK → CANCION |
| fecha_hora | DATETIME | DEFAULT NOW() |
| duracion_escuchada_seg | INT | NOT NULL |
| dispositivo | VARCHAR(80) | NULL |
| completada | TINYINT(1) | DEFAULT 0 |

---

**9. GENERO_MUSICAL**

| Atributo | Tipo | Restricción |
|---|---|---|
| genero_id | INT | PK, AUTO_INCREMENT |
| nombre | VARCHAR(80) | UNIQUE, NOT NULL |
| descripcion | TEXT | NULL |
| genero_padre_id | INT | FK → GENERO_MUSICAL (autorreferencia) |

---

**10. DISPOSITIVO**

| Atributo | Tipo | Restricción |
|---|---|---|
| dispositivo_id | INT | PK, AUTO_INCREMENT |
| usuario_id | INT | FK → USUARIO |
| tipo | ENUM('iPhone','iPad','Mac','Apple TV','HomePod','Windows','Android') | NOT NULL |
| nombre_dispositivo | VARCHAR(100) | NOT NULL |
| sistema_operativo | VARCHAR(80) | NULL |
| ultimo_acceso | DATETIME | NULL |
| activo | TINYINT(1) | DEFAULT 1 |

---

Ahora genero el script SQL:---

## ✅ Script generado: `bdapplemusic.sql`

El script incluye las **10 entidades** con todas sus relaciones, más extras de valor:

### 📦 Contenido del script

| Sección | Detalle |
|---|---|
| **Base de datos** | `CREATE DATABASE bdapplemusic` con charset `utf8mb4` |
| **10 tablas** | Con PK, FK, tipos correctos y comentarios |
| **Relaciones** | `ON DELETE CASCADE / RESTRICT / SET NULL` según la lógica del negocio |
| **Índices** | 9 índices adicionales para optimizar consultas frecuentes |
| **Datos de ejemplo** | Géneros, artistas, álbumes, canciones, usuarios, suscripciones, dispositivos, playlists y reproducciones |
| **2 vistas** | `v_top_canciones` y `v_historial_usuario` para consultas rápidas |

### 🔗 Diagrama de relaciones principales

```
GENERO_MUSICAL ←── ALBUM ──→ ARTISTA
                     │
                  CANCION ──────────────────┐
                     │                      │
              PLAYLIST_CANCION         REPRODUCCION
                     │                      │
                 PLAYLIST ──→ USUARIO ←── DISPOSITIVO
                               │
                           SUSCRIPCION
```Aquí tienes el **Diagrama ERD completo** de las 10 entidades de Apple Music. Las relaciones representadas son:

| Relación | Cardinalidad | Descripción |
|---|---|---|
| USUARIO → SUSCRIPCION | 1 a muchos | Un usuario puede tener varias suscripciones históricas |
| USUARIO → DISPOSITIVO | 1 a muchos | Un usuario vincula varios dispositivos |
| USUARIO → PLAYLIST | 1 a muchos | Un usuario crea varias playlists |
| USUARIO → REPRODUCCION | 1 a muchos | El historial de escucha por usuario |
| ARTISTA → ALBUM | 1 a muchos | Un artista publica varios álbumes |
| ARTISTA → CANCION | 1 a muchos | Un artista interpreta varias canciones |
| ALBUM → CANCION | 1 a muchos | Un álbum contiene varias canciones |
| GENERO_MUSICAL → ALBUM | 1 a muchos | Un género clasifica varios álbumes |
| GENERO_MUSICAL → GENERO_MUSICAL | autorreferencia | Sub-géneros dentro de géneros padre |
| PLAYLIST ↔ CANCION | muchos a muchos | A través de PLAYLIST_CANCION |
| CANCION → REPRODUCCION | 1 a muchos | Registro de cada vez que se escucha |
| DISPOSITIVO → REPRODUCCION | 1 a muchos | Desde qué dispositivo se reprodujo |
