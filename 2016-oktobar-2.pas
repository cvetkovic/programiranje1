program oktobar_2016_zadatak_2;

uses Math;

type
  ptr=^elem;
  elem=record
      poluprecnik:real;
      koordinate:record
          x:real;
          y:real;
      end;
      boja:0..15;
      sledeci:ptr;
  end;


procedure ucitajKrugove(var lista:ptr);
var
  poluprecnik, x, y:real;
  boja:0..15;
  temp:ptr;
begin
     while 1=1 do
     begin
          readln(poluprecnik, x, y, boja);

          if poluprecnik < 0 then
             break
          else
          begin
               new(temp);

               temp^.poluprecnik := poluprecnik;
               temp^.koordinate.x := x;
               temp^.koordinate.y := y;
               temp^.boja := boja;
               temp^.sledeci := nil;

               if lista = nil then
                  lista := temp
               else
               begin
                    temp^.sledeci := lista;
                    lista := temp;
               end;
          end;
     end;
end;

function odrediBoju(listaKrugova:ptr; x:real; y:real):integer;
begin
     odrediBoju := -1;

     while listaKrugova <> nil do
     begin
          if sqrt(power(x - listaKrugova^.koordinate.x, 2) + power(y - listaKrugova^.koordinate.y, 2)) <= listaKrugova^.poluprecnik then
          begin
               odrediBoju := listaKrugova^.boja;
               break;
          end;

          listaKrugova := listaKrugova^.sledeci;
     end;
end;

procedure obradiTacke(listaKrugova: ptr);
var
  x, y:real;
  boja:integer;
begin
     while 1=1 do
     begin
          readln(x, y);

          if (x = 0) and (y = 0) then
               break
          else
          begin
               boja := odrediBoju(listaKrugova, x, y);

               if boja = -1 then
                    writeln('bela')
               else
                    writeln(boja);
          end;
     end;
end;

procedure oslobodiMemoriju(k:ptr);
var
  tk:ptr;
begin
     while k <> nil do
     begin
          tk := k^.sledeci;
          dispose(k);
          k := tk;
     end;
end;

var
  listaKrugova:ptr;

begin
     ucitajKrugove(listaKrugova);

     obradiTacke(listaKrugova);

     oslobodiMemoriju(listaKrugova);
end.