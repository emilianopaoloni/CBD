{Se desea administrar el stock de los productos de un supermercado. Para ello se
cuenta con un archivo maestro donde figuran todos los productos que comercializa. De
cada producto se almacena la siguiente información: código de producto, nombre
comercial, descripción, precio de venta, stock actual y stock mínimo. Diariamente se
generan 10 archivos detalle que registran todas las ventas de productos registradas
por las cajas del supermercado. De cada venta se almacena: código de producto y
cantidad de unidades vendidas. Se pide realizar un programa con opciones para:
a) Crear el archivo maestro a partir de un archivo de texto llamado “productos.txt”.
b) Actualizar el archivo maestro con los archivos detalle, sabiendo que: - Todos los archivos están ordenados por código de producto. - Cada registro del maestro puede ser actualizado por 0, 1 ó más registros
de los archivos detalle. - Los archivos detalle sólo contienen ventas de productos que están en el
archivo maestro. Además, siempre hay stock suficiente para realizar las ventas
de productos que aparecen en los archivos de detalle.
Nota: deberá implementar programa principal, todos los procedimientos y los tipos
de datos necesarios.}
program p2.ejercicio7;

const
  valor_alto= 99999;
  X = 10;

type
  str15= string[15];
  reg_detalle = record
    codProducto: integer;
    unidadesVendidas: integer;
  end;

  reg_maestro = record
    codProducto: integer;
    nombreComercial: str15;
    descripcion: str15;
    precioVenta: double;
    stockActual: integer;
    stockMinimo: integer;
  end;

  arc_maestro = file of reg_maestro;
  arc_detalle = file of reg_detalle;

  TarregloDetalle = array[1..X] of arc_detalle;
  TarregloRegDetalle = array[1..X] of reg_detalle;




procedure leerTexto(var atxt: text; var dato: reg_maestro);     //considero que la informacion en el .txt esta organizado en lineas
begin
    if not(EOF(atxt)) then
    begin
      readln(atxt, dato.nombreComercial, dato.codProducto);  //linea1: nombre y codigo de producto
      readln(atxt, dato.descripcion);                        //linea2: descripcion de producto
      readln(atxt, dato.precioVenta);                        //linea3:precio de venta
      readln(atxt, dato.stockActual, dato.stockMinimo);      //linea4: stock actual y stock minimo
    end
    else begin
      dato.codProducto:= valor_alto;
    end;
end;
procedure crearMaestro(var mae: arc_maestro);
var
   atxt: Text;
   reg: reg_maestro;
   i: integer;
begin
    //abrir arhcivo de texto:
    Assign(atxt, 'archivo.txt');
    reset(atxt);  //se usa reset porque se abre solo para lectura

    //crear archivo maestro:
    Assign(mae, 'archivo_maestro');
    rewrite(mae);                     //se usa rewrite porque hay que crearlo

    //carga del archivo maestro:
    leerTexto(atxt,reg);
    while(reg.codProducto <> valor_alto) do begin
        write(mae, reg);
        leerTexto(atxt,reg);
    end;

    //cierro archivos:
    close(atxt);
    close(mae);

end;
procedure leer (var archivo: arc_detalle; var dato: reg_detalle);
begin
    if not(EOF(archivo)) then begin
       read(archivo, dato);
    end
    else
      dato.codProducto := valor_alto;
end;

procedure minimo (var arregloDetalle: TArregloDetalle; var arregloRegistros: TarregloRegDetalle; var min: reg_detalle);
var
   posMin: integer;
  i: integer;
begin
    posMin := 1;
    min := arregloRegistros[1];
    for i:= 1 to X do begin
      if(arregloRegistros[i].codProducto < min.codProducto) then
      begin
        min:= arregloRegistros[i];
        posMin:=i;
      end;
    end;
    leer(arregloDetalle[posMin], arregloRegistros[posMin]);
end;

procedure actualizarMaestro (var detalles: TarregloDetalle; var mae:arc_maestro);
var
  vectorRegDetalles: TarregloRegDetalle; //arreglo de reg_detalle
   min: reg_detalle;
   regM: reg_maestro;
   prodActual: integer;
   i: integer;

begin
    //abro maestro
    Assign(mae, 'archivo_maestro');

   //abro archivos detalle:
   for i:= 1 to X do begin
      Assign(detalles[i], 'detalle'+i);
      reset(detalles[i]);
      leer(detalles[i], vectorRegDetalles[i]); //leo los primeros 10 registros de cada arch detalle en su respectiva posicion del vector
   end;

   //leo el primer registro de archivo maestro (lo uso een el while de mas adelante)
   if not (EOF(mae)) then begin
     read(mae, regM);
   end;


   minimo(detalles, vectorRegDetalles, min);  //busco el minimo entre los primeros 10 registros de los 10 archivos detalles

   while(min.codProducto <> valor_alto) do begin
      prodActual:= min.codProducto;


      //busco al registro minimo en el maestro:
      while (min.codProducto <> regM.codProducto) do begin
        if not (EOF(mae)) then begin         //itero sobre el arch maestro hasta encontrar el mismo registro que se esta procesando en detalle
          read(mae, regM);
        end;
      end;


      while(min.codProducto = prodActual) do begin  //mientras sea mismo codigo de producto
        //modifico el stock del registro en el maestro:
        regM.stockActual := regM.stockActual - min.unidadesVendidas;
        minimo(detalles, vectorRegDetalles, min);
      end;

      //escribo en el maestro:
      seek(mae, filepos(mae) -1 ); //me posiciono en pos anterior
      write(mae, regM);
   end;


   //cierro archivos detalles:
   for i:= 1 to X do begin
     close(detalles[i]);
   end;

   //cierro archivo maestro:
   close(mae);
end;

var
   mae: arc_maestro;
   regDetalles: TarregloRegDetalle; //arreglo de reg_detalle
   detalles: TarregloDetalle; //arreglo de archivos detalles
   i: integer;
begin
   crearMaestro(mae);
   actualizarMaestro(detalles, mae);
end.

