{Una zapatería cuenta con 20 locales de ventas. Cada local de ventas envía un listado
con los calzados vendidos indicando: código de calzado, número y cantidad vendida
del mismo.
El archivo maestro almacena la información de cada uno de los calzados que se
venden, para ello se registra el código de calzado, número, descripción, precio unitario,
color, el stock de cada producto y el stock mínimo.
Escriba el programa principal con la declaración de tipos necesaria y realice un
proceso que reciba los 20 detalles y actualice el archivo maestro con la información
proveniente de los archivos detalle. Tanto el maestro como los detalles se encuentran
ordenados por el código de calzado y el número.
Además, se deberá informar qué calzados no tuvieron ventas y cuáles quedaron por
debajo del stock mínimo. Los calzados sin ventas se informan por pantalla, mientras
que los calzados que quedaron por debajo del stock mínimo se deben informar en un
archivo de texto llamado calzadosinstock.txt.
Nota: tenga en cuenta que no se realizan ventas si no se posee stock.}
program p2.ejercicio3;

const
   valor_alto = 9999;

type
  str20 = string[20];
  str10 = string[10];

  zapato_vendido = record
    codigo: int;
    numero: int;
    descripcion: str20;
    cantVendida: int;
    end;

  zapato_info = record
    codigo: int;
    numero: int;
    descripcion: str20;
    precioUnitario: double;
    color: str10;
    stock: int;
    stockMinimo: int;
    end;

  arc_detalle = file of zapato_vendido;
  arc_maestro = file of zapato_info;
  rDetalles = Array[1..20] of zapato_vendido; //se va a utilizar para buscar el minimo
  arcDetalles = Array[1..20] of arc_detalle; //arreglo de 20 archivos detalle --> de las 20 sucursales


procedure minimo(var det: arcDetalles; var rdet:rDetalles ;var min:zapato_vendido);
Var
  posMin :int ;
begin
  posMin:=1;
  min := rdet[1]; //inicializo min con algun registro del vector
  for i:=2 to 20 do
  begin
    if ((rdet[i].codigo < min.codigo) && (rdet[i].numero < min.numero)) then   //comparo por nro de codigo y por nro de talle
    begin
      min:= rdet[i];
      posMin:=i;
    end;
  end;
  leer(det[posMin],rdet[posMin]);
end;

procedure leer (var archivo: arc_detalle; var dato: zapato_vendido);
begin
  if (not(EOF(archivo))) then
    read (archivo, dato)
  else
     dato.codigo := valor_alto;
end;

var
  maestro: arc_maestro;
  detalles : arcDetalles;  //arreglo de 20 archivos detalles
  calzadosSinStock : Text;
  vector_registroDetalle: rDetalles;
  i: int;
  min: zapato_vendido;
  regM: zapato_info; //registro de arc maestro


begin

   //abro archivo maestro
   Assing(maestro, 'maestro');
   reset(maestro);

   //abro archivo de texto
   Assign(calzadosSinStock, 'calzadosinstock.txt');
   reset(calzadosSinStock);

   //abro archivos detalle
   for i:= 1 to 20 do begin
   Assign(detalles[i] , 'detalle'i);
   reset(detalles[i]);
   leer(detalles[i], vector_registroDetalle[i]); //leo los primeros registros de CADA archivo detalle, y lo almaceno en el vector de registros vector_registroDetalle
   end;
   minimo(detalles, vector_registroDetalle, min); //calculo el minimo entre los registros del vector

   regM.codigo = valor_alto; //inicializo nomas el codigo para que entre al segundo while la primera vez
   while (min.codigo <> valor_alto) do begin

       while (min.codigo <>  regM.codigo) do begin     //itero en el archivo maestro hasta encontrar el zapato con mismo codigo que min
             read(maestro, regM);
       end;                                         // cuando de este while es porque encontre en el maestro al zapato con codigo que tengo en min
       while(min.codigo = regM.codigo) do          //mientras se mantenga el codigo de zapato que estoy procesando (en min)...
       begin
         while(min.numero = regM.numero) do     //mientras se mantenga el nro de zapato

            if(regM.stock > min.cantVendida) then  //en este caso hay stock suficiente, se realiza la venta (se modifica el maestro)
            begin
               //disminuyo stock:
               regM.stock := regM.stock - min.cantVendida;

               //se modifica el maestro con el calzado :
               seek(maestro, filepos(maestro) - 1);
               write(maestro, regM);

               //busco al proximo minimo:
               minimo(detalles, vector_registroDetalle, min);
            end
            else begin
                //se debe informar por pantalla que el calzado queda sin venta (no hay stock):
                writeln('Se anula la venta de ',min.cantVendida,' calzados con codigo ',min.codigo,' por falta de stock');
            end;
         end;

       end;

       //cuandos se cambia de calzado, se verifica si el calzado anterior quedo con stock minimo, en tal caso se informa en el txt:
       if(regM.stock < regM.stockMinimo) then
          write(calzadosSinStock, regM.codigo);
   end;

   //cierro archivo maestro:
   close(maestro);

   //cierro archivos detalle:
   for i:=1 to 20 do
      close(detalles[i]);





end.

