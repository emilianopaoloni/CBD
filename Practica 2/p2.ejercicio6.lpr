program p2.ejercicio6;
const
  valor_alto = 9999999;
type
  str10 = string[10];
  reg_entrada=record
     codMozo: integer;
     fecha: str10;
     montoServicio: double;
  end;
  reg_salida = record
     codMozo: integer;
     montoTotal: double;
  end;
  arc_entrada: file of reg_entrada;
  arc_salida: file of reg_salida;

procedure leer ( var arc: arc_entrada, var dato: reg_entrada )
begin
  if not(EOF(arc)) then
    read(arc,dato);
  else
    dato.codMozo := valor_alto;
end;
procedure generarInforme ( var entrada: arc_entrada )
var
  salida: arc_salida;
  mozoActual: integer;
  regE: reg_entrada;
  regS: reg_salida;
  montoTotal: double;
begin
  //creo archivo de salida
  Assign(salida, 'informe_restaurante');
  reset(salida);

  leer(entrada, regE);
  while(regE.codMozo <> valor_alto) do
  begin
      mozoActual:= reg.codMozo;
      montoTotal:= 0;
      while(regE.codMozo = mozoActual) do
      begin
         montoTotal:= montoTotal + regE.montoServicio;
         leer(entrada, reg);
      end;
      //se cambia de mozo, escribo en el archivo
      regS.codMozo:=mozoActual;
      regS.montoTotal:=montoTotal;
      write(salida,regS);
  end;

  //cierro archivo de salida
  close(salida);
end;

var
  entrada: arc_entrada;
begin
  //abro archivo de entrada:
  Assign(entrada, 'mozos');
  reset(entrada);

  generarInforme(entrada);

  //cierro archivo entrada:
  close(entrada);


end.

