Primero te presento las entidades con sus atributos, luego genero el script SQL.

🎵 Proyecto: Base de Datos Apple Music
Entidades y Atributos

1. USUARIO
AtributoTipoRestricciónusuario_idINTPK, AUTO_INCREMENTnombreVARCHAR(100)NOT NULLapellidoVARCHAR(100)NOT NULLemailVARCHAR(150)UNIQUE, NOT NULLfecha_nacimientoDATENOT NULLpaisVARCHAR(60)NOT NULLfecha_registroDATETIMEDEFAULT NOW()

2. SUSCRIPCION
AtributoTipoRestricciónsuscripcion_idINTPK, AUTO_INCREMENTusuario_idINTFK → USUARIOtipo_planENUM('Individual','Familiar','Estudiante','Apple One')NOT NULLprecio_mensualDECIMAL(6,2)NOT NULLfecha_inicioDATENOT NULLfecha_finDATENULLestadoENUM('Activa','Cancelada','Suspendida')DEFAULT 'Activa'

3. ARTISTA
AtributoTipoRestricciónartista_idINTPK, AUTO_INCREMENTnombre_artisticoVARCHAR(150)NOT NULLnombre_realVARCHAR(150)NULLpais_origenVARCHAR(60)NOT NULLfecha_debutDATENULLbiografiaTEXTNULLimagen_urlVARCHAR(255)NULL

4. ALBUM
AtributoTipoRestricciónalbum_idINTPK, AUTO_INCREMENTartista_idINTFK → ARTISTAtituloVARCHAR(200)NOT NULLfecha_lanzamientoDATENOT NULLgeneroVARCHAR(80)NOT NULLsello_discograficoVARCHAR(100)NULLportada_urlVARCHAR(255)NULLtotal_pistasINTDEFAULT 0

5. CANCION
AtributoTipoRestriccióncancion_idINTPK, AUTO_INCREMENTalbum_idINTFK → ALBUMartista_idINTFK → ARTISTAtituloVARCHAR(200)NOT NULLduracion_segINTNOT NULLnumero_pistaINTNOT NULLletraLONGTEXTNULLexplicitTINYINT(1)DEFAULT 0reproduccionesBIGINTDEFAULT 0

6. PLAYLIST
AtributoTipoRestricciónplaylist_idINTPK, AUTO_INCREMENTusuario_idINTFK → USUARIOnombreVARCHAR(150)NOT NULLdescripcionTEXTNULLes_publicaTINYINT(1)DEFAULT 0fecha_creacionDATETIMEDEFAULT NOW()portada_urlVARCHAR(255)NULL

7. PLAYLIST_CANCION (tabla intermedia)
AtributoTipoRestricciónplaylist_idINTPK, FK → PLAYLISTcancion_idINTPK, FK → CANCIONposicionINTNOT NULLfecha_agregadaDATETIMEDEFAULT NOW()

8. REPRODUCCION
AtributoTipoRestricciónreproduccion_idBIGINTPK, AUTO_INCREMENTusuario_idINTFK → USUARIOcancion_idINTFK → CANCIONfecha_horaDATETIMEDEFAULT NOW()duracion_escuchada_segINTNOT NULLdispositivoVARCHAR(80)NULLcompletadaTINYINT(1)DEFAULT 0

9. GENERO_MUSICAL
AtributoTipoRestriccióngenero_idINTPK, AUTO_INCREMENTnombreVARCHAR(80)UNIQUE, NOT NULLdescripcionTEXTNULLgenero_padre_idINTFK → GENERO_MUSICAL (autorreferencia)

10. DISPOSITIVO
AtributoTipoRestriccióndispositivo_idINTPK, AUTO_INCREMENTusuario_idINTFK → USUARIOtipoENUM('iPhone','iPad','Mac','Apple TV','HomePod','Windows','Android')NOT NULLnombre_dispositivoVARCHAR(100)NOT NULLsistema_operativoVARCHAR(80)NULLultimo_accesoDATETIMENULLactivoTINYINT(1)DEFAULT 1

Ahora genero el script SQL:Archivo creado, leyó un archivoArchivo creado, leyó un archivo
✅ Script generado: bdapplemusic.sql
El script incluye las 10 entidades con todas sus relaciones, más extras de valor:
📦 Contenido del script
SecciónDetalleBase de datosCREATE DATABASE bdapplemusic con charset utf8mb410 tablasCon PK, FK, tipos correctos y comentariosRelacionesON DELETE CASCADE / RESTRICT / SET NULL según la lógica del negocioÍndices9 índices adicionales para optimizar consultas frecuentesDatos de ejemploGéneros, artistas, álbumes, canciones, usuarios, suscripciones, dispositivos, playlists y reproducciones2 vistasv_top_canciones y v_historial_usuario para consultas rápidas


Aquí tienes el **Diagrama ERD completo** de las 10 entidades de Apple Music. Las relaciones representadas son:

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
