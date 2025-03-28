{Una cadena de cines de renombre desea administrar la asistencia del público a las
diferentes películas que se exhiben actualmente. Para ello cada cine genera
semanalmente un archivo indicando: código de película, nombre de la película, género,
director, duración, fecha y cantidad de asistentes a la función. Se sabe que la cadena
tiene 20 cines. Escriba las declaraciones necesarias y un procedimiento que reciba los
20 archivos y un String indicando la ruta del archivo maestro y genere el archivo
maestro de la semana a partir de los 20 detalles (cada película deberá aparecer una
vez en el maestro con los datos propios de la película y el total de asistentes que tuvo
durante la semana). Todos los archivos detalles vienen ordenados por código de
película. Tenga en cuenta que en cada detalle la misma película aparecerá tantas
veces como funciones haya dentro de esa semana.}

program p2.ejercicio4;

const
  valor_alto = 9999;

type
  str10 = string[10];
  reg_detalle = record
    codigo_peli: integer;
    nombre_peli: str10;
    genero: string;
    director: string;
    duracion: double;
    fecha: str10;
    cant_asistentes: integer;
  end;

  reg_maestro = record
    codigo_peli: integer;
    nombre_peli: str10;
    genero: string;
    director: string;
    duracion: double;
    asistentes_en_una_semana: integer;
  end;

  arc_maestro = file of reg_maestro;
  arc_detalle = file of reg_detalle;
  TArregloDetalle = array[1..20] of arc_detalle;   //arreglo de archivos detalle
  TArregloRegDetalle = array[1..20] of reg_detalle;


procedure leer (var archivo: arc_detalle, var dato: reg_detalle);
begin
    if not(EOF(archivo)) then
       read(archivo, dato);
    else
      dato.codigo = valor_alto;
end;

procedure minimo (var arregloDetalle: TArregloDetalle, var arregloRegistros: TArregloRegDetalle, var min: reg_detalle)
  varMin: integer;
  i: integer;
begin
    posMin := 1;
    min := arregloRegistros[1];
    for i:= 1 to 20 do begin
      if(arregloRegistros[i].codigo_peli < min.codigo_peli) then
      begin
        min:= arregloRegistros[i];
        posMin:=i;
      end;
    end;
    leer(arregloDetalle[posMin], rdet[posMin]);
end;

procedure crearMaestro(string ruta, var adet: TArregloDetalle);   //es necesario pasar por referencia al arreglo?
var
    arregloRegistros: TArregloRegDetalle; //arreglo que contiene los registros leidos de "x" posicion
    mae: arc_maestro
    i: integer;
    min: reg_detalle;
    peliActual: reG_maestro
    totalAsistentes: integer;


begin
    //preparo archivos detalle
    for i:= 1 to 20 do begin
      Assign(detalles[i], 'funcion'+i);
      reset(detalles[i]);  //abro archivo
      leer (adet[i] , arregloRegistros[i]) //guardo una pelicula de cada archivo detalle en el vector
    end;

    //creo archivo maestro
    Assign(mae, 'maestro');
    reset(mae);

    minimo(adet , arregloRegistros, min);   //se elige la pelicula con menor codigo

    while(min.codigo_peli <> valor_alto) do begin
        peliActual.totalAsistentes:=0;     //inicializo
        peliActual.codigo_peli := min.codigo_peli;
        peliActual.nombre_peli := min.nombre_peli;
        peliActual.genero := min.genero;
        peliActual.director := min.director;
        peliActual.duracion := min.duracion;
        peliActual.fecha := min.fecha;


        while(min.codigo_peli = peliActual.codigo_peli) do begin    //se porcesa una misma pelicula (mismo codigo)
           peliActual.totalAsistentes:= peliActual.totalAsistentes + min.cant_asistentes;
           minimo(adet , arregloRegistros, min);
        end;
        //se cambio de pelicula, escribo sobre archivo:
        write(maestro, peliActual);
    end;

    //cerrar archivo maestro
    close(mae);

    //cerrar archivos detalle:
     for i:= 1 to 20 do begin
      close(detalles[i]);
     end;

end;

var
    detalles: TArregloDetalle;
    rutaMaestro: string;
begin

   ruta='../archMaestro'
   crearMaestro(rutaMaestro, detalles);



end.

