program p1.ejercicio3;

{Realizar un programa que permita crear un archivo de texto. El archivo se debe
cargar con la información ingresada mediante teclado. La información a cargar
representa los tipos de dinosaurios que habitaron en Sudamérica. La carga finaliza
al procesar el nombre ‘zzz’ que no debe incorporarse al archivo.}

uses
  SysUtils;

const
  FIN = 'ZZZ' ;

type
  archivoDeTexto = text;

var
  archivo : archivoDeTexto;
  tipoDinosaurio : string;

begin
  //crear archivo de texto "dinosaurios.txt"
  Assign(archivo, 'C:\Users\W10\dinosaurios.txt');
  rewrite(archivo);
  writeln( 'escriba un tipo de dinosaruio (ZZZ para finalizar)' );
  readln(tipoDinosaurio);
  while( tipoDinosaurio <> FIN )do begin
       writeLn(archivo, tipoDinosaurio);
       writeln( 'escriba un tipo de dinosaruio (ZZZ para finalizar)' );
       readln(tipoDinosaurio);
  end;

  //cierro archivo de texto
  close(archivo);

end.

