{La municipalidad de la Plata, en pos de minimizar los efectos de posibles inundaciones,
construye acueductos que permitan canalizar rápidamente el agua de la ciudad hacia
diferentes arroyos que circundan la misma. La construcción está dividida por zonas.
Los arquitectos encargados de las obras realizan recorridos diariamente y guardan
información de la zona, fecha y cantidad de metros construidos. Cada arquitecto envía
mensualmente un archivo que contiene la siguiente información: cod_zona, nombre de
la zona, descripción de ubicación geográfica, fecha, cantidad de metros construidos
ese día. Se sabe que en la obra trabajan 15 arquitectos y que durante el mes van
rotando de zona.
Escriba un procedimiento que reciba los 15 archivos correspondiente y genere un
archivo maestro indicando para cada zona: cod_zona, nombre de zona y cantidad de
metros construidos. Además se deberá informar en un archivo de texto, para cada
zona, la cantidad de metros construidos indicando: cod_zona, nombre, ubicación y
metros construidos. Nota: todos los archivos están ordenados por cod_zona. }
program p2.ejercicio8;

const
  valor_alto= 99999;
  X = 15; //indica cantidad de arquitectos

type
  str15= string[15];
  reg_detalle = record
    codZona: integer;
    nombreZona: str15;
    descripcionUbicacion: str15;
    fecha: str15;
    metrosConstruidosPorDia: double;
  end;


  reg_maestro = record
    codZona: integer;
    nombreZona: str15;
    metrosConstruidos: double
  end;

  arc_maestro = file of reg_maestro;
  arc_detalle = file of reg_detalle;

  TarregloDetalle = array[1..X] of arc_detalle;
  TarregloRegDetalle = array[1..X] of reg_detalle;






procedure leer (var archivo: arc_detalle; var dato: reg_detalle);
begin
    if not(EOF(archivo)) then begin
       read(archivo, dato);
    end
    else
      dato.codZona := valor_alto;
end;

procedure minimo (var arregloDetalle: TArregloDetalle; var arregloRegistros: TarregloRegDetalle; var min: reg_detalle);
var
   posMin: integer;
  i: integer;
begin
    posMin := 1;
    min := arregloRegistros[1];
    for i:= 1 to X do begin
      if(arregloRegistros[i].codZona < min.codZona) then
      begin
        min:= arregloRegistros[i];
        posMin:=i;
      end;
    end;
    leer(arregloDetalle[posMin], arregloRegistros[posMin]);
end;

procedure crearMaestro (var detalles: TarregloDetalle; var mae:arc_maestro);
var
  vectorRegDetalles: TarregloRegDetalle; //arreglo de reg_detalle
   min: reg_detalle;
   regM: reg_maestro;
   zonaActual: integer;
   i: integer;
   ubiActual: str15;
   txt: Text;


begin
    //creo maestro
    Assign(mae, 'archivo_maestro');
    reset(mae);

    //creo archivo de texto
    Assign(txt, 'info.txt');
    reset(mae);

   ////leo los primeros 15 registros de cada arch detalle en su respectiva posicion del vector
   for i:= 1 to X do begin
      leer(detalles[i], vectorRegDetalles[i]);
   end;


   minimo(detalles, vectorRegDetalles, min);  //busco el minimo entre los primeros 15 registros de los 10 archivos detalles

   while(min.codZona <> valor_alto) do begin
      zonaActual:= min.codZona;
      ubiActual:= min.descripcionUbicacion;
      regM.codZona:= zonaActual;
      regM.nombreZona:= min.nombreZona;
      regM.metrosConstruidos:=0 ; //inicializo en 0

      while(min.codZona = zonaActual) do begin  //mientras sea mismo codigo de zona
        //modifico el stock del registro en el maestro:
        regM.metrosConstruidos := regM.metrosConstruidos + min.metrosConstruidosPorDia;
        minimo(detalles, vectorRegDetalles, min);
      end;

      //escribo en el maestro:
      seek(mae, filepos(mae) -1 ); //me posiciono en pos anterior
      write(mae, regM); //escribo el registro con la zona correspondiente

      //escribo en el .txt :
      write(txt, 'codigo de zona: 'zonaActual,', nombre zona: ',regM.nombreZona,', ubicacion: ',ubiActual,', metros construidos: ',regM.metrosConstruidos);
   end;


   //cierro archivos detalles:
   for i:= 1 to X do begin
     close(detalles[i]);
   end;

   //cierro archivo maestro:
   close(mae);

   //cierro archivo txt
   close(txt);
end;

var
   mae: arc_maestro;
   detalles: TarregloDetalle; //arreglo de archivos detalles
   i: integer;
begin
   //abro archivos detalle:
   for i:= 1 to X do begin
     Assign(detalles[i], 'detalle'+i);
     reset(detalles[i]);
   end;
   crearMaestro(detalles);

end.

