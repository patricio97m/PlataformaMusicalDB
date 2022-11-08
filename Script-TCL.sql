use streaming_music_database;

/*Primera transaccion*/
start transaction;
delete from playlists where idPlaylists = 13;
delete from playlists where idPlaylists = 14;
delete from playlists where idPlaylists = 15;

/*Se comenta la sentencia rollback*/
/*rollback;*/
commit;

/*Se vuelven a insertar los datos eliminados*/
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (13,'Musica de Argentina',12,10,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (14,'Pop',4,11,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (15,'Mejores Canciones de Soda Stereo',14,NULL,12);

/*Segunda transaccion*/
start transaction;
insert into usuario (Nombre) values ('Leonardo');
insert into usuario (Nombre) values ('Uriel');
insert into usuario (Nombre) values ('Francisco');
insert into usuario (Nombre) values ('Sofia');
savepoint usuarios1al4;
insert into usuario (Nombre) values ('Mateo');
insert into usuario (Nombre) values ('Leandro');
insert into usuario (Nombre) values ('Amadeo');
insert into usuario (Nombre) values ('Martina');
savepoint usuarios5al8;

/*Se comenta la eliminacion del primer savepoint*/
/*release savepoint usuarios1al4;*/
commit;