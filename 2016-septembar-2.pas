program septembar_2016_zadatak_2;

type
  ptr=^elem;
  elem=record { intervali su zatvoreni }
     levi:real;
     desni:real;

     sledeci:ptr;
  end;

function preklapanje(lista:ptr; levi:real; desni:real):ptr;
begin
     preklapanje := nil;

     while lista <> nil do
     begin
          if ((levi >= lista^.levi) and (levi <= lista^.desni)) or ((desni >= lista^.levi) and (desni <= lista^.desni)) then
          begin
               preklapanje := lista;
               break;
          end;

          lista:=lista^.sledeci;
     end;
end;

procedure spojiInterval(element:ptr; levi:real; desni:real);
begin
     if (levi >= element^.levi) and (levi <= element^.desni) then
     begin
          if element^.desni < desni then
              element^.desni := desni;
     end
     else
          if element^.levi > levi then
              element^.levi := levi
end;

function ucitajListu(n:integer):ptr;
var
     temp, p, rezultat:ptr;
     levi, desni:real;
     i:integer;
begin
     rezultat:=nil;
     p:=nil;

     for i:=1 to n do
     begin
          readln(levi, desni);

          p:=preklapanje(rezultat, levi, desni);

          if p = nil then
          begin
               new(temp);

               temp^.levi:=levi;
               temp^.desni:=desni;
               temp^.sledeci := nil;

               if rezultat = nil then
                    rezultat := temp
               else
               begin
                    temp^.sledeci := rezultat;
                    rezultat := temp;
               end;
          end
          else
          begin
               { preklapaju se }
               spojiInterval(p, levi, desni);
          end;
     end;

     ucitajListu:=rezultat;
end;

procedure ispisiIntervale(lista:ptr);
begin
     while lista <> nil do
     begin
          writeln('[',lista^.levi:2:3,', ', lista^.desni:2:3, ']');

          lista:=lista^.sledeci;
     end;
end;

procedure oslobodi(lista:ptr);
var
     temp:ptr;
begin
     while lista <> nil do
     begin
          temp:=lista^.sledeci;
          dispose(lista);
          lista:=temp;
     end;
end;

var
  n:integer;
  lista:ptr;

begin
     readln(n);

     lista := ucitajListu(n);

     ispisiIntervale(lista);

     oslobodi(lista);
end.