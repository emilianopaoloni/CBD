program p1.ejercicio2;
{Desarrollar un programa que permita la apertura de un archivo de números enteros
no ordenados. La información del archivo corresponde a la cantidad de votantes
de cada ciudad de la Provincia de Buenos Aires en una elección presidencial.
Recorriendo el archivo una única vez, informe por pantalla la cantidad mínima y
máxima de votantes. Además durante el recorrido, el programa deberá listar el
contenido del archivo en pantalla. El nombre del archivo a procesar debe ser
proporcionado por el usuario. }

const
  CANT_CIUDADES = 135 ;

{ type
  registroVotos = Record
    nombreCiudad = String;
    cantVotos = integer;
  end;                          }  //estaria mal asi? porque dice archivo de nros enteros
  archivoVotos = File of integer;

var
  nomArchivo = String;
  a = archivoVotos;
  cant = integer;
  cantMinimo = integer;
  cantMaximo = integer;


begin
  cantMinimo := 9999;
  cantMaximo := 0;
  Write( 'escriba el nombre del archivo a procesar' );
  ReadLn(nomArchivo);  //nombre del archivo proporcionado por el usuario
  Assing(a, nomArchivo);   //asigno archivo
  Reset(a); //abro archivo para lectura
  while (not eof (a) )do begin
    Read(a, cant); //leo la cantidad de votos
    writeLn(cant);
    if( cant > cantMaximo ) then
        cantMaximo := cant;
    else if (cant <  cantMinimo ) then
        cantMinimo := cant;
  end
  writeln('la cantidad maxima de votos es: ', cantMaximo);
  writeln('la cantidad minima de votos es: ', cantMinimo);

  //cerrar archivo
  close(a);



  end.

