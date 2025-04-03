program p3.ejercicio3;

type
  str10= string[10];
  producto=record
    codProducto: integer;
    nombre: str10;
    descripcion: str10;
    stock: integer;
  end;

 arcBin = file of producto;


 { a) Deberá realizar un procedimiento que tomando como entrada el archivo de texto,
      genere el correspondiente archivo binario de datos. }

procedure generarArchivoBinario(var txt: Text ; var a: arcBin);
var
  reg: producto;
begin
  //abro archivo de texto:
  Reset(txt);

  //creo archivo binario:
  Rewrite(a);

  //leo lineas del txt y voy cargando el binario:
  while(not EOF(a)) do begin
      read(a, reg.codProducto);  //doy por hecho que la informacion de cada producto esta organizada en el txt de a una linea
      read(a, reg.nombre);
      read(a, reg.descripcion);
      read(a, reg.stock);
      write(a, reg); //escribo registro en archivo
  end;

  close(a);
  close(txt);

end;

{ b) Se reciben por pantalla códigos de indumentaria obsoletos, los cuales deben
    eliminarse del archivo de datos, utilizando una marca de borrado. La marca de
    borrado consiste en poner valor negativo al stock. Realice el procedimiento
    correspondiente }
procedure borradoLogico(var a: arcBin; cod: integer);
var
  reg: producto;
begin

  reset(a); //abro archivo

  reg.codProducto:= -1; //inicializo
  while((not EOF(a)) and (reg.codProducto <> cod) ) do begin     //busco el registro a marcar en el archivo
      read(a, reg);
  end;

  if(reg.codProducto = cod) then //significa que se encontro el registro con el codigo (no se llego a eof)
  begin
      reg.stock=-1; //marca de borrado: -1 al stock
      seek(a, filepos(a) - 1); //vuelvo a la posicion anterior
      write(a, reg);  //escribo el registro con la marca de borrado
  end
  else
    writeln('no existe codigo dado en el archivo');

  close(a);

end;

{c) realizar un procedimiento que permita realizar el alta de
una nueva indumentaria con los valores obtenidos por teclado.  }
procedure realizarAlta(var a: arcBin; prod: producto);
begin
  reset(a); //abro archivo
  seek(a, filepos(a) ); //me posiciono al final del archivo para agregar producto
  write(a, prod);
  close(a); //cierro archivo

end;

{d) Realice un nuevo procedimiento de baja, suponiendo que la creación del archivo
supuso la utilización de la técnica de lista invertida para reutilización de espacio
(dejó un registro obsoleto al comienzo del archivo como cabecera de lista).  }
prodcedure eliminar_lista_invertida(var a: arcBin; cod: integer);
var
  sLibre, r: producto;
  nLibre: integer
begin
    reset(a); //abro archivo

    read(a, sLibre); //leo cabecera de archivo
    r.codProducto= -1; //inicializo

    while( not( (r.codProducto = cod) or (eof(a)) ) do
    begin
        read(a, r); //recorre archivo hasta encontrar el registro a eliminar
    end;

    if( r.codProducto = cod ) then begin   //se asegura que se haya encontrado y no EOF
       nLibre:= filepos(a) - 1; //guardo la posicion a eliminar
       seek(a, nLibre);
       write(a, sLibre);
       str(nLibre, sLibre); //convierto en string la posicion del nuevo reg libre
       seek(a, 0);
       write(a, sLibre); //escribo en la cabecera
       //DUDA: NOSE SI ESTA BIEN CONVERTIR ASI EN STRING, PORQUE EL ARCHIVO ALMACENA
       //REGISTROS DE TIPO "producto" ENTONCES NO SE SI SE DEBRIA ESCRIBIR UN STRING EN
       //LA CABECERA, O UN REGISTRO producto, QUE TENGA LA POSICION nLibre EN UNO DE SUS
       //CAMPOS
    end
    else
      writeln('no se encuentra codigo a eliminar');

    close(a);

end;

{e) Re implemente c, sabiendo que se utiliza la técnica de lista en invertida. }
procedure agregar_lista_invertida(var a: arcBin; p: producto);
  sLibre: producto;
  nLibre: integer;
  cod: integer
begin
   Reset(a);  //abro archivo
   Read(a, sLibre); {lee la cabecera}
   Val(sLibre, nLibre,cod);  {convierte de string a number}
       If (nLibre= -1) then //significa que no hay registros para REUTILIZAR, escribo al final del archivo
           Seek(a, FileSize(a))
       else begin
            Seek(a, nLibre); //me posiciono en la primera poscion de registro libre
            Read(a, sLibre); {lee la posición a reutilizar}
            Seek(a, 0);
            Write(a, sLibre); {Actualiza la cabecera}
            Seek(a, nLibre);
            end;

        Write(a, p); {escribo nuevo producto}
        Close(a)
        end;

end;

var
  txt: Text; //archivo de texto donde tiene almacenada la siguiente información:
            //código de producto, nombre, descripción y stock
  a: arcBin;
  cod: integer;

  reg: producto;

begin
    Assign(txt, 'archivo_tienda.txt');
    Assign(a, 'D:\Users\W10\Documents\Ingenieria UNLP\BASE DE DATOS 1\archivo_productos');

    //punto a)
    generarArchivBinario(txt);

    //punto b)
    writeln('escriba codigos para eliminar (-1 para terminar)'
    readln(cod);
    while(cod <> -1) do begin
        borradoLogico(a, cod);
        writeln('escriba codigos para eliminar (-1 para terminar)'
        readln(cod);
    end;

    //punto c)
    readln(reg.codProducto);
    readln(reg.stock);
    readln(reg.descripcion);
    readln(reg.nombre);
    realizarAlta(a,reg);

    //punto d)
    writeln('escriba codigo de producto a eliminar'
    readln(cod);
    eliminar_lista_invertida(a, cod);

    //punto e)
    readln(reg.codProducto);
    readln(reg.stock);
    readln(reg.descripcion);
    readln(reg.nombre);
    agregar_lista_invertida(a,reg);


end.

