program p3.ejercicio4;

type
  str10 = string[10];
  r_cd = record
    codigo: integer;
    nombreAlbum: str10;
    genero: str10;
    artista: str10;
    descripcion: str10;
    anioEdicion: integer;
    stock: integer; //cantidad de copias en stock
  end;
  arc_cd = file of r_cd;

procedure modificarStock ( var a: arc_cd; cod: integer);
var
  reg: r_cd;
begin
  reset(a); //abro archivo

  reg.codigo:= -1; //inicializo
  while(not((reg.codigo = cod) or eof(a) )) do
    read(a, reg);

  if(reg.codigo = cod) then begin  //verifico que se encontro el registro en ela archivo y no EOF
     reg.stock:= 0; //actualizo stock a 0
     seek(a, filepos(a) - 1);
     write(a, reg);       //actualizo el registro
     writeln('album sin stock: ',reg.nombreAlbum);
  end;

  close(a);
end;

procedure eliminarDisco (var a: arc_cd; cod: integer);
var
  reg, aux: r_cd;
  posBorrar: int;
begin
  reset(a); //abro archivo

  reg.codigo:= -1; //inicializo
  while(not((reg.codigo = cod) or eof(a) )) do
    read(a, reg);

  if(reg.codigo = cod) then begin  //verifico que se encontro el registro en ela archivo y no EOF
     posBorrar:= filepos(a) - 1;
     seek(a, filesize(a) - 1); //me posiciono al final del archivo
     read(a, aux); //leo el ultimo registro del archivo
     seek(a, posBorrar);
     write(a, aux); //sobreescribo la posicion a borrar con el ultimo registro del archivo
     seek(a, filesize(a) - 1); //me vuelvo a posicionar al final del archivo
     truncate(a); //reduce el tamaño del archivo hasta la posición actual del puntero
                  //el archivo se corta justo antes del ultimo registro, eliminandolo
  end;

  close(a);

end;

var
  cod: integer;
  a: arc_cd;
begin
  Assign(a, 'archivo_cds');

  writeln( 'escriba codigos de discos a eliminar (-1 para finalizar)');
  readln(cod);
  while( cod <> -1 )do begin
    modificarStock(a, cod);
    eliminarDisco(a, cod);
    writeln( 'escriba codigos de discos a eliminar (-1 para finalizar)');
    readln(cod);
  end;
end.

