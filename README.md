# scriptsMySQL
Archivos para un modelo de base de datos propia. 

# Descripción
Servicio de streaming similar a Spotify, YouTube Music, etc. Donde la base de la plataforma consiste en distintas bandas o artistas, las cuales poseen discos y canciones. Los discos o EPs deben contener canciones. Además, los usuarios que se registren pueden crear playlists para tener sus propias colecciones de canciones. Los artistas además pueden promocionarse en la plataforma ofreciendo información sobre sus próximos conciertos y vender su merchandising.

#Documentación
https://drive.google.com/file/d/1as_av9xFZgoMcS0HfDlnPbl4_SoUvJcR/view?usp=share_link

# Tablas
- `Artista_Banda`
- `Discos/EPs` 
- `Canciones`
- `Playlists`
- `Usuario`
- `Conciertos` 
- `Locación`
- `Tickets`
- `Merchandising`
- `Videoclips` 
- `Letras`
- `Podcasts`
- `Presentadores`

# Vistas
- `canciones_conciertos`
- `conciertos_artistas`
- `discos_artistas`
- `playlists_usuarios`
- `playlists_artistas`

# Funciones
- `artista_hace_rock`
- `get_dias_faltantes_conciertos`
- `get_duracion_disco`
- `get_genero_artista`

# Procedimientos almacenados
- `buscar_productos`
- `eliminar_conciertos_pasados`
