{ Se cuenta con un archivo de artículos deportivos a la venta. De cada artículo se almacena: nro de
artículo, descripción, color, talle, stock disponible y precio del producto. Se reciben por teclado los
nros de artículos a eliminar, ya que no se fabricarán más. Se deberá realizar la baja lógica de los
artículos correspondientes. Además, se requiere listar en un archivo de texto todos los artículos
eliminados, para ello debe almacenar toda la información del artículo eliminado en el archivo de
texto. (No debe recorrer nuevamente el archivo maestro, deberá hacerlo en simultáneo).
Escriba el programa principal con la declaración de tipos necesaria y realice un proceso que
reciba el archivo maestro y actualice el archivo maestro a partir de los códigos de artículos a
borrar. El archivo maestro se encuentra ordenado por el código de artículo.}
program p3.ejercicio5;

type
  str10 = string[10];
  articulo = record
    nro: integer;
    descripcion: str10;
    color: str10;
    talle: integer;
    stock: integer;
    precio: double;
  end;
  arc = file of articulo;

procedure eliminarArticulo( var a: arc; var t: Text; nro: integer);
var
  reg: articulo;
begin
  reset(a); //abro archivo
  reset(t); //abro txt

  reg.nro:= -1; //inicializo
  while(not((reg.nro = nro) or eof(a) )) do
    read(a, reg);

  if(reg.nro = nro) then begin  //verifico que se encontro el registro en ela archivo y no EOF
     reg.descripcion:= '***'; //marca de borrado
     seek(a, filepos(a) - 1);
     write(a, reg);       //actualizo el registro

     //escribo datos de articulo eliminado en el txt:
     write(t, reg.nro, reg.descripcion);
     write(t, reg.talle, reg.color);
     write(t, reg.stock, reg.precio);
  end;

  close(a);
end;
var
  nro: integer;
   a: arc;
   t: Text; //archivo de texto
 begin
   Assign(a, 'archivo_articulos');
   Assign(t, 'bajas.txt');

   //creo archivo de texto:
   rewrite(t);
   write(t, 'articulos eliminados:');
   close(t);


   writeln( 'escriba codigos de discos a eliminar (-1 para finalizar)');
   readln(nro);
   while( nro <> -1 )do begin
     eliminarArticulo(a, t, nro);
     writeln( 'escriba codigos de discos a eliminar (-1 para finalizar)');
     readln(nro);
   end;

 end.

