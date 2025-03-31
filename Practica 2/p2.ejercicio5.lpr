{La Dirección de Población Vulnerable del Ministerio de Salud y Desarrollo Social
solicita información a cada municipio indicando cantidad de niños y de adultos mayores
que están en situación de riesgo debido a la situación socioeconómica del país. Para
ello se recibe un archivo indicando: partido, localidad, barrio, cantidad de niños y
cantidad de adultos mayores.
Se sabe que el archivo se encuentra ordenado por partido y localidad. Se pide imprimir
por pantalla con el siguiente formato:
Partido:
Localidad 1:
Cantidad niños: ____
Cantidad adultos: ____
Total niños localidad 1:-----------  Total adultos localidad 1:----------
Localidad 2:
Cantidad niños: ____
Cantidad adultos: ____
Total niños localidad 2:-----------  Total adultos localidad 2:----------
TOTAL NIÑOS PARTIDO:-----------  TOTAL ADULTOS PARTIDO:------------ }
program p2.ejercicio5 ;

const
   valor_alto = 9999;
type
  str15 = string[15];
  reg_info = record
      codPartido: integer;
      codLocalidad:integer;
      barrio: str15;
      cantNinos: integer;
      cantAdultos: integer;
  end;
  arc_entrada: file of reg_info;

procedure leer(var arc: arc_entrada, var dato: reg_info);
begin
  if not(EOF(arc)) then
    write(arc, dato);
  else
    dato.codPartido = valor_alto;
end;
var
  arc: arc_entrada;
  reg: reg_info
  locActual: integer;
  partActual: integer;
  totalNinosLocalidad: integer;
  totalAdultosLocalidad: integer;
  totalNinosPartido: integer;
  totalAdultosLocalidad: integer;
  contadorLocalidades: integer;


begin
  Assign(arc, 'info_municipios');
  reset(arc); //abro archivo

  leer(arc, reg);
  while( reg <> valor_alto) do begin
      partActual:=reg.codPartido;
      //inicializo contadores por partido:
      totalNinosPartido:=0;
      totalAdultosPartido:=0;

    while( reg.codPartido = partActual ) do begin
        locActual:=reg.codLocalidad;

        //inicializo contadores por localidad:
        totalNinosLocalidad:=0;
        totalAdultosLocalidad:=0;
        contadorLocalidades:=1;

        writeln('Localidad '+contadorLocalidades);
        while( reg.codLocalidad = locActual ) do begin
            writeln('Cantidad niños: '+reg.cantNinos+' Cantidad adultos: '+reg.cantAdultos );
            //contabilizo:
            contadorLocalidades:= contadorLocalidades + 1;
            totalNinosLocalidad:= totalNinosLocalidad + reg.cantNinos;
            totalAdultosLocalidad:=  totalAdultosLocalidad + reg.cantAdultos;
            leer(arc, reg);
        end;

        //cuando sale de este bucle es porque cambio de localidad:
        writeln('Total niños localidad '+contadorLocalidades+':'+totalNinosLocalidad+'   '+'Total adultos localidad '+contadorLocalidades+':'+totalAdultosLocalidad);

        //contabilizo personas por partido:
        totalNinosPartido:= totalNinosPartido + totalNinosLocalidad ;
        totalAdultosPartido:= totalAdultosPartido + totalAdultosLocalidad ;
    end;

    //cuando sale de este bucle es porque cambio de partido:
    writeln('TOTAL NIÑOS PARTIDO:'+totalNinosPartido+'   '+'TOTAL ADULTOS PARTIDO:'+totalAdultosPartido);
  end;

end.

