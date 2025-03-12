program p1.ejercicio1;

Type
  archivoMateriales = Text; //archivo de nombres de materiales de construccion --> tipo Text

Var
  nomArch: String;
  material: String;
  arch: archivoMateriales;
  fin: String;

begin
   fin := 'cemento';
   Write('Escriba el nombre del archivo que contiene materiales de construcción');
   ReadLn(nomArch);
   Assign(arch,'D:\Users\W10\Documents\Ingenieria UNLP\BASE DE DATOS 1\Ejercicios Pascal\'+nomArch); //asigno nombre al archivo
   Rewrite(arch);    //creo el archivo y lo abro en modo escritura
   Write('Escriba material de construccion ("cemento" para finalizar)');
   ReadLn(material);
   if (material <> fin )     //aseguro que el primer material escrito no sea cemento
   then begin
     Repeat
       WriteLn(arch, material);
       Write('Escriba material de construccion ("cemento" para finalizar)');
       ReadLn(material);
     until ( material = fin )
   end;
   Close(arch); //cierro archivo
end.
