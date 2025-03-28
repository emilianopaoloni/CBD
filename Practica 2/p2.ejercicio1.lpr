{El área de recursos humanos de un ministerio administra el personal del mismo
distribuido en 10 direcciones generales.
Entre otras funciones, recibe periódicamente un archivo detalle de cada una de las
direcciones conteniendo información de las licencias solicitadas por el personal.
Cada archivo detalle contiene información que indica: código de empleado, la fecha y
la cantidad de días de licencia solicitadas. El archivo maestro tiene información de
cada empleado: código de empleado, nombre y apellido, fecha de nacimiento,
dirección, cantidad de hijos, teléfono, cantidad de días que le corresponden de
vacaciones en ese periodo. Tanto el maestro como los detalles están ordenados por
código de empleado. Escriba el programa principal con la declaración de tipos
necesaria y realice un proceso que reciba los detalles y actualice el archivo maestro
con la información proveniente de los archivos detalles. Se debe actualizar la cantidad
de días que le restan de vacaciones. Si el empleado tiene menos días de los que
solicita deberá informarse en un archivo de texto indicando: código de empleado,
nombre y apellido, cantidad de días que tiene y cantidad de días que solicita. }

program p2.ejercicio1;
const
  valorAlto= 1000000;
type
str25 = string[25];
str10 = string[10];

solicitudEmpleado = record
    codigoEmp : int ;  //codigo de empleado
    fecha : str10;
    diasSolicitados: int;
    end;

empleado = record
    codigoEmp : int ;  //codigo de empleado
    nomYape : str25;
    fechaNacimiento : str10;
    direccion : str10;
    cantHijos: int;
    tel: int;
    diasCorrespondidos: int;

detalle = file of solicitudEmpleado;
maestro = file of empleado;

//procesos:
procedure leer(var archivo: maestro; var dato: solicitudEmpleado);
begin

   //Leo un dato del archivo detalle y verifico que no se haya terminado el archivo
   if (not(EOF(archivo))) then
      read (archivo, dato)
    else
      dato.codigoEmp := valoralto;
end;

procedure actualizarMaestro(var mae: maestro; var aTexto: Text; codEmpleado: int; diasSolicitados: int )
// proceso que recibe los detalles y actualiza el archivo maestro con la información proveniente de los archivos detalles
var
  regm: empleado;
  nomYape: str25;
begin
read(mae,regm);
while(regm.codEmp <> codEmpleado) do begin   //busco la posicion del codigo de empleado
    read(mae,regm);
end;
//encontre la posicion:
{Si el empleado tiene menos días de los que
solicita deberá informarse en un archivo de texto indicando: código de empleado,
nombre y apellido, cantidad de días que tiene y cantidad de días que solicita}
if (regm.diasCorrespondidos < diasSolicitados) then
begin
    //informo en el archivo de texto:
    reset(aTexto);
    nomYape:= regm.nomYape;
    reset(aTexto); //abro archivo de texto;
    writeLn( 'empleado: '+nomYape+', codigo:'+codEmpleado+', dias que tiene: '+regm.diasCorrespondidos+', dias solicitados: '+diasSolicitados);
    close(aTexto);
end;
  else
  begin
    //actualizo en archivo maestro:
    regm.diasCorrespondidos:= regm.diasCorrespondidos - diasSolicitados;
    regm.diasCorrespondidos:= regm.diasCorrespondidos - diasSolicitados; //se restan dias que le quedand e vacaciones al empleado
    seek(mae, filepos(mae)-1); //se reubica el puntero en el maestro
    write(mae, regm); //se actualiza el maestro
  end;

end;




var

 vectorDetalles = detalle[10];   // archivo detalle de cada una de las 10 direcciones generales
 i = int;
 det : detalle;
 mae : maestro;
 aTexto : Text;
 regd: solicitudEmpleado; //registro detalle
 regm: empleado; //registro maestro
 codActual: int;
 totalDias: int;


//Tanto el maestro como los detalles están ordenados por código de empleado

begin {programa principal}

  assign(aTexto, 'informacion.txt');//creo archivo de texto


  assign(mae, 'maestro');      //abro archivo maestro
  reset(mae);
  for i := 0 to 9 do            // para los 10 archivos detalle
  begin
    det = vectorDetalles[i];
    assign(det, 'detalle');     //abro archivo detalle
    reset(det);
    leer(det, regd);

    while (regd.codigoEmp <> valorAlto) do    //bucle para leer todo el archivo detalle
    begin
        codActual:= regd.codigoEmp;
        totalDias:=0;

        while(regd.codEmp == codActual ) do   //procesar a un empleado
        begin
            total := total + regd.diasSolicitados;
            leer(det, regd);
        end;

        //cuando sale del while es porque cambio el empleado, pero antes hay que actualizar el archivo maestro:
        actualizarMaestro(mae, aTexto, codActual, totalDias);
    end;

  end;

   //cierro archivos maestro, detalle y txt:
    close (mae);
    for i:= 1 to 10 do begin
        close (vectorDetaller[i]);
    end;





end.

