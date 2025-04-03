{Se dispone de un archivo que contiene información de autos en alquiler de una rentadora. Se
sabe que el archivo utiliza la técnica de lista invertida para aprovechamiento de espacio. Es
decir las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro en la posición 0 del archivo se usa como cabecera de la pila de registros
borrados.}

{ El valor ‘0’ en el campo descripción significa que no existen registros borrados, y ‘N’
indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro
válido.  }
program p3.ejercicio2;

Type
tVehiculo= Record
  codigoVehiculo:integer;
  patente: String[10];
  motor:String[10];
  cantidadPuertas: integer;
  precio:real;
  descripcion:String[10];
  end;

tArchivo = File of tVehiculo;

{Abre el archivo y agrega un vehículo para alquiler, el mismo se recibe como parámetro  y
debe utilizar la política descripta anteriormente para recuperación de espacio (reutilizando registros
borrados)}
Procedure agregar (var arch: tArchivo; vehiculo: tVehiculo);
var
   sLibre: tVehiculo; {variable que contiene al próximo registro libre para usar}
   nLibre: integer; {numero del próximo registro libre para usar}
   cod: integer; {código de error al transformar datos}
Begin
  reset(arch); //abro archivo
  Read(arch, sLibre); //leo la cabacera del archivo
  Val(sLibre.descripcion, nLibre, cod); //convierte la descripcion del registro (string) a entero (guarda en nLibre)
  if( nLibre = 0 ) then begin
     seek(arch, fileSize(arch)); //si no hay registros libres, escribo al final del archivo
  end
  else begin
    seek(arch, nLibre); //posiciono al archivo en la proxima posicion libre
    read(arch, sLibre); //antes de sobreescribir, me guardo lo que hay en la posicion a reutilizar --> que es la lista de registros libres
    seek(arch, 0); // me posiciono al inicio del archivo (cabecera)
    write(arch, sLibre); //actualizo la cabecera --> con los registros libres, menos el que voy a ocupar (porque lo saque de la lista)
    seek(arch, nLibre); //me posiciono en la posicion libre (donde voy a escribir)
  end;
  write(arch, vehiculo); //escribo el registro vehiculo para alquiler, pasado como parametro
  close(arch);
End;

{Abre el archivo y elimina el vehículo que posea el código recibido como parámetro
manteniendo la política descripta anteriormente}
Procedure eliminar (var arch: tArchivo; codigoVehiculo: integer);
var
   sLibre, regEliminar: tVehiculo;
   nLibre, cod: integer;
   posBorrarEnString: string;
   posBorrar: integer;
Begin
  reset(arch);
  read(arch, sLibre); //leo la cabecera

  regEliminar.codigoVehiculo:=0;
  while(not((regEliminar.codigoVehiculo=codigoVehiculo) or EOF(arch) ) ) do  //se busca en el archivo el registro a eliminar
     read(arch, regEliminar);

  if( regEliminar.codigoVehiculo=codigoVehiculo ) then begin //se encontro el registro a eliminar
       posBorrar:= filepos(arch) - 1; //guardo la posicion de ese registro
       seek(arch, posBorrar);
       write(arch, sLibre); //escribo el registro cabecera en la pos a eliminar

       Str(posBorrar, posBorrarEnString); //convierto la posicion a borrar en string
       regEliminar.descripcion := posBorrarEnString; //escribo la posicion proxima donde guarde la lista de eliminados
       seek(arch, 0); //me posiciono en la cabecera
       write(arch, regEliminar);
   end
   else begin   //no se encontro el registro a eliminar (no existe en el archivo)
     writeln('el codigo no existe');
   end;


End;

var
  arch: tArchivo;
  vehiculo: tVehiculo;
  codEliminar: integer;
begin
  Assign(arch, 'archiv_vehiculos');

  //lectura de vehiculo a agregar:
  writeln('Ingrese el código del vehículo:');
  readln(vehiculo.codigoVehiculo);

  writeln('Ingrese la patente del vehículo:');
  readln(vehiculo.patente);

  writeln('Ingrese el motor del vehículo:');
  readln(vehiculo.motor);

  writeln('Ingrese la cantidad de puertas del vehículo:');
  readln(vehiculo.cantidadPuertas);

  writeln('Ingrese el precio del vehículo:');
  readln(vehiculo.precio);

  writeln('Ingrese la descripción del vehículo:');
  readln(vehiculo.descripcion);

  agregar(arch, vehiculo);

  //lectura de codigo de vehiculo a eliminar
   writeln('Ingrese el código del vehículo a eliminar:');
   readln(codEliminar);

   eliminar(arch, codEliminar);


end.

