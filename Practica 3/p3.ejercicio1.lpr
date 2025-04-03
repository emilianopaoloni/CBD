{ Se cuenta con un archivo que almacena información sobre especies de plantas originarias de
Europa, de cada especie se almacena: código especie, nombre vulgar, nombre científico, altura
promedio, descripción y zona geográfica. El archivo no está ordenado por ningún criterio.
Realice un programa que elimine especies de plantas trepadoras. Para ello se recibe por
teclado los códigos de especies a eliminar.
a. Implemente una alternativa para borrar especies, que inicialmente marque los
registros a borrar y posteriormente compacte el archivo, creando un nuevo archivo
sin los registros eliminados.
b. Implemente otra alternativa donde para quitar los registros se deberá copiar el
último registro del archivo en la posición del registro a borrar y luego eliminar del
archivo el último registro de forma tal de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el código 100000 }
program p3.ejercicio1;
const
  codigo_fin=1000;
type
  str10 = string[10];
  especie = record
    codigo: integer;
    nombreV: str10;
    nombreC: str10;
    altura: double;
    promedio: double;
    descripcion: str10;
    zona: str10;
  end;

archivoEspecie = file of especie;

Procedure  bajaLogicaA(var a: archivoEspecie);
Var
   posBorrar:integer;
   re:especie;
   cod: integer;
begin
  reset(a);  //abro archivo
  writeln('escriba codigo de especie a eliminar');
  readln(cod);
  while(cod <> codigo_fin) do begin
    re.codigo:=0; //inicializo
    while (not eof(a) and (re.codigo <> cod))  //buscar el registro a eliminar en el archivo
    do begin
       read(a,re);
    end;
    if(re.codigo = cod) then begin //este if se hace por si se llego a EOF en el while anterior
         posBorrar:= (filepos(a)-1);
         re.codigo := -1;
         seek(a, posBorrar);
         write(a,re); //sobreescribo el registro con codigo de especie -1
    end;
  writeln('escriba codigo de especie a eliminar');
  readln(cod);
  end;

  close(a);
end;

Procedure  bajaLogicaB(var a: archivoEspecie);
Var
   posBorrar:integer;
   posUltimo: integer;
   cod: integer;
   re:especie;
   ru:especie; //almaceno el ultimo registro del archivo

begin
  reset(a);  //abro archivo
  writeln('escriba codigo de especie a eliminar');
  readln(cod);
  while(cod <> codigo_fin) do begin
    re.codigo:=0; //inicializo

    while (not eof(a) and (re.codigo <> cod))do   //buscar el registro a eliminar en el archivo
       read(a,re);
    if(re.codigo = cod) then begin //este if se hace por si se llego a EOF en el while anterior
         posBorrar:= filepos(a)-1;    //se copia la posicion a borrar
         seek(a, (fileSize(a)-1) ); //me posiciono al final del archivo
         read(a,ru);       //leo el ULTIMO registro del archivo
         seek(a, posBorrar);    //me posiciono en la posBorrar
         write(a,ru); //sobreescribo en la posicion a borrar, el ultimo registro del archivo "ru"

         seek(a, fileSize(a)); //me posiciono en la ultima posicion del archivo
         truncate(a);            //elimino ultimo registro del archivo
    end;
  writeln('escriba codigo de especie a eliminar');
  readln(cod);
  end;

  close(a);
end;


var
   a: archivoEspecie;
   nom, ape: string;
begin
  Assign(a, 'archivo_especies');
  bajaLogicaA(a);
  bajaLogicaB(a)

end.

