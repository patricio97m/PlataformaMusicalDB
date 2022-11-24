-- -----------------------------------------------------------------------
-- Creacion de vistas
-- -----------------------------------------------------------------------

CREATE VIEW canciones_discos AS
select coalesce(T1.`idDiscos_EPs`, T2.`idDiscos_EPs`) id,
T1.nombreDisco, T2.numCancion, coalesce (T2.Nombre) nombre_cancion, T2.Duracion
from `discos_eps` T1 left join (select * from canciones) T2
on T1.`idDiscos_EPs` = T2.`idDiscos_EPs`
where T2.Nombre IS NOT NULL;

CREATE VIEW playlist_usuarios AS
select coalesce(T1.`idUsuario`, T2.`idUsuario`) id,
coalesce (T1.Nombre) usuario, coalesce (T2.Nombre) nombre_playlist
from `usuario` T1 left join (select * from playlists) T2
on T1.`idUsuario` = T2.`idUsuario`
where T2.Nombre IS NOT NULL;

CREATE VIEW playlists_artistas AS
select coalesce (T1.`idArtista_Banda`, T2.`idArtista_Banda`) id,
coalesce (T1.Nombre) artista, coalesce (T2.Nombre) nombre_playlist
from `artista_banda` T1 left join (select * from playlists) T2
on T1.`idArtista_Banda` = T2.`idArtista_Banda`
where T2.Nombre IS NOT NULL;

CREATE VIEW discos_artistas AS
select coalesce (T1.`idArtista_Banda`, T2.`idArtista_Banda`) id,
coalesce (T1.Nombre) nombre_artista, T2.nombreDisco, T2.`Año`
from `artista_banda` T1 left join (select * from `discos_eps`) T2
on T1.`idArtista_Banda` = T2.`idArtista_Banda`
where T2.nombreDisco IS NOT NULL;

CREATE VIEW conciertos_artistas AS
select coalesce (T1.`idArtista_Banda`, T2.`idArtista_Banda`) id,
T1.nombre, T2.nombreConcierto, T2.Fecha
from `artista_banda` T1 left join (select * from conciertos) T2
on T1.`idArtista_Banda` = T2.`idArtista_Banda`
where T2.nombreConcierto IS NOT NULL;

