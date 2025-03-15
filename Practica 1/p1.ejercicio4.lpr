program p1.ejercicio4;

type
  TarchivoBinario = File of <Integer>;


procedure ConvertirArchivo(var a1: TarchivoBinario);


begin
end.

ConvertirArchivo(var a1: TarchivoBinario)
         var
          archTexto: Text;
          votos: integer;
         begin
           Reset(a1);  //abro archivo para leer
           Assign(archTexto,'C:\Usuarios\W10\archivosCBD');
           Rewrite(archTexto);
           While (not eof(a1)) do begin
              Read(a1, votos);
              WriteLn(archTexto, votos);
           end;
           close(a1);
           close(archTexto);
         end;
}

