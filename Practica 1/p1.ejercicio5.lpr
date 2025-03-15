program p1.ejercicio5;



type
   tRegistroFlores = record
     nroEspecie: integer;
     alturaMaxima: double;
     nombreC: String[10];  //nombre cientifico
     nombreV: String[10]; //nombre vulgar
     color: String[10];
   end;

   tArchivoFlores = File of tRegistroFlores;

procedure reportarCantidades( var a: tArchivoFlores);
var
  reg: tRegistroFlores ;
  cantTotal: integer;
  mayorAltura: double;
  especieMayor: String[10];
  menorAltura: double;
  especieMenor: String[10];
begin
   cantTotal:=0;
   mayorAltura:=0;
   menorAltura:=999;
   reset(a); //abro archivo para leer
   while(not eof(a) ) do begin
      //leo registro:
      read(a,reg);
      cantTotal := cantTotal + 1;
      if(reg.alturaMaxima > mayorAltura)then begin
          mayorAltura := reg.alturaMaxima;
          especieMayor := reg.nombreC;
          end;
      if(reg.alturaMaxima < menorAltura)then begin
          menorAltura := reg.alturaMaxima;
          especieMenor := reg.nombreC;
          end;
      end;
      writeln('la especie de mayor altura es ', especieMayor);
      writeln('la especie de menor altura es ', especieMenor);
      writeln('cantidad total de flores ', cantTotal);

      //cierro archivo:
      close(a);



end;

procedure listarContenidoPorLinea(var a: tArchivoFlores)  ;
var
reg: tRegistroFlores ;
begin
   reset(a); //abro archivo para leer
   while(not eof(a) ) do begin
          read(a, reg); //leo un registro entero del archivo
          //imprimir:
          writeln('nro de especie: ', reg.nroEspecie);
   end;

   close(a);

end;

procedure agregarEspecie( var a: tArchivoFlores)     ;

var
  flor : tRegistroFlores;
begin
  reset(a);
  writeln('ingrese nombre cientifico');
  readln(flor.nombreC);
  while (flor.nombreC <> 'ZZZ') do begin
    writeln('ingrese nombre vulgar');
    readln(flor.nombreV);
    writeln('ingrese numero de especie');
    readln(flor.nroEspecie);
    writeln('ingrese altura maxima');
    readln(flor.alturaMaxima);
    writeln('ingrese color');
    readln(flor.color);
    //cargo datos al archivo:
    write(a, flor);
    writeln('ingrese nombre cientifico');
    readln(flor.nombreC);
    end;
  close(a);
end;

procedure listarEnTxt ( var a: tArchivoFlores )   ;
var
  archTexto: Text;
  reg: tRegistroFlores ;
begin
  reset(a);
  //creo archivo de texto
  Assign( archTexto, 'C:\Users\W10\archivos CBD\flores.txt');
  reset(archTexto);
  while (not eof(a) )do begin
    read(a, reg)  ;       //leo un registro entero del archivo
    write(a, reg);
  end;

end;

var

  archivoFlores : tArchivoFlores;
  flor : tRegistroFlores;
  opc : integer;


begin
  Assign(archivoFlores, 'C:\Users\W10\archivos CBD\ flores.bin');
  Rewrite(archivoFlores); //creo el archivo

  writeln('carga incial de datos al archivo');

  writeln('ingrese nombre cientifico');
  readln(flor.nombreC);
  while (flor.nombreC <> 'ZZZ') do begin
    writeln('ingrese nombre vulgar');
    readln(flor.nombreV);
    writeln('ingrese numero de especie');
    readln(flor.nroEspecie);
    writeln('ingrese altura maxima');
    readln(flor.alturaMaxima);
    writeln('ingrese color');
    readln(flor.color);
    //cargo datos al archivo:
    write(archivoFlores, flor);
    writeln('ingrese nombre cientifico');
    readln(flor.nombreC);
    end;
    close(archivoFlores);


    writeln('Menu de opciones: ');
    writeln('1: Reportar en pantalla la cantidad total de especies y la especie de menor y de mayor altura a alcanzar');
    writeln('2: Listar todo el contenido del archivo de a una especie por línea.');
    writeln('3: Modificar el nombre científico de la especie flores cargada');
    writeln('4: Añadir una o más especies al final del archivo con sus datos obtenidos por teclado');
    writeln('5: Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”');
    writeln('6: Terminar programa');
    readln(opc);

    while(opc <> 6) do begin

      case opc of

      1: begin
             reportarCantidades(archivoFlores);
      end;

      2: begin
             listarContenidoPorLinea(archivoFlores);

      end;

      3: begin
           // ni idea che
      end;

      4: begin
        agregarEspecie(archivoFlores);

      end;

      5: begin
        listarEnTxt(  archivoFlores);

      end;

    end;

    writeln('Menu de opciones: ');
    writeln('1: Reportar en pantalla la cantidad total de especies y la especie de menor y de mayor altura a alcanzar');
    writeln('2: Listar todo el contenido del archivo de a una especie por línea.');
    writeln('3: Modificar el nombre científico de la especie flores cargada');
    writeln('4: Añadir una o más especies al final del archivo con sus datos obtenidos por teclado');
    writeln('5: Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”');
    writeln('6: Terminar programa');
    readln(opc);





  end;


      //termina programa
      close(archivoFlores);

End.
