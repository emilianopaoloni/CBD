{Se necesita contabilizar los CD vendidos por una discográfica. Para ello se dispone de
un archivo con la siguiente información: código de autor, nombre del autor, nombre
disco, género y la cantidad vendida de ese CD. Realizar un programa que muestre un
listado como el que se detalla a continuación. Dicho listado debe ser mostrado en
pantalla y además listado en un archivo de texto. En el archivo de texto se debe listar
nombre del disco, nombre del autor y cantidad vendida. El archivo origen está
ordenado por código de autor, género y nombre disco.
Autor: _____
Género: ----------
Nombre Disco: ---------- cantidad vendida: ------------
Nombre Disco: ---------- cantidad vendida: ------------
Total Género:
Género:----------
Nombre Disco: ---------- cantidad vendida: ------------
…….
Total Autor:
Total Discográfica}


program p2.ejercicio2;
const
  valorAlto = 10000;

type

  str20 = string[20];

  dato_entrada = record
    codAutor: int;
    nombreAutor: str20;
    nombreDisco: str20;
    genero: str20;
    cantVendida: int;
  end;

  arc_entrada = file of dato;
  arc_salida = Text;

procedure leer (var archivo: arc_entrada ; var dato: dato_entrada);
begin

    //Leo un dato del archivo
    if (not (EOF(archivo))) then
        read (archivo, dato) // guardo un registro del archivo en variable dato
    else begin
        dato.codAutor := valorAlto;
    end;

end;

var
  entrada: arc_entrada;
  salida: arc_salida;
  dato: dato_entrada;
  autorActual: str20;
  generoActual: str20;
  totalGeneros: int;
  totalDiscografia: int; //cantidad de discos hechos?
  totalAutores:int; //cantidad de autores?


begin
  // El archivo origen (entrada) esta ordenado por código de autor, género y nombre disco.

  assign(entrada, 'archivoDeEntrada');
  reset(entrada);

  assign(salida, 'autores.txt');
  reset(salida);

  totalAutores := 0; //se inicializa en cero

  leer(entrada, dato); //leo un registro del archivo de entrada

  while (dato.codAutor <> valorAlto) do begin  //mientras no se termine el archivo de entrada

      writeLn(salida, 'Autor: ',dato.nombreAutor);
      autorActual := dato.codAutor;    //leo codigo de autor actual
      totalAutores := totalAutores +1; //contabilizo cantidad de autores

      totalGeneros := 0;
      totalDiscografias := 0;

      while (dato.codAutor == autorActual) do begin    //bucle para procesar autores

           generoActual := dato.genero;        //leo genero de autor actual
           totalGeneros := totalGeneros + 1;   //contabilizo el genero
           writeLn(salida, 'Genero: ', dato.genero);


           while ( (dato.codAutor == autorActual) && (dato.genero == generoActual) ) do begin  //bucle para procesar los discos de un mismo genero (de un mismo autor)


              totalDiscografias := totalDiscografias + 1;  //contanilizo discos
              writeLn(salida, 'Nombre disco: ', dato.nombreDisco,' cantidad vendida: ',dato.cantVendida);


             //leo otro registro:
             leer(entrada, dato);

           end;

      end;
      //antes de cambiar de autor, escribo total discografias y total generos:
       writeLn(salida, 'Total discografias: ', totalDiscografias);
       writeLn(salida, 'Total generos: ', totalGeneros);
  end;

  //por ultimo, antes de cerrar archivo, escribo total de autores:
  writeLn(salida, 'Total autores: ', totalAutores);

  //cierro archivos:
  close(salida);
  close(entrada);


end.

