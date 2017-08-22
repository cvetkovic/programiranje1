program jul_2016_zadatak_2;

type
  ptr=^elem;
  elem=record
    broj:integer;
    sledeci:ptr;
  end;

function postoji(lista:ptr; broj:integer):boolean;
begin
     postoji := false;

     while lista <> nil do
     begin
          if lista^.broj = broj then
          begin
               postoji := true;
               break;
          end;

          lista := lista^.sledeci;
     end;
end;

procedure ucitaj(var lista:ptr; var n:integer);
var
  temp:ptr;
  broj:integer;
begin
     n := 0;

     while 1=1 do
     begin
          readln(broj);

          if broj < 0 then
              break
          else
          begin
               if postoji(lista, broj) = false then
               begin
                    new(temp);

                    temp^.broj := broj;
                    temp^.sledeci := nil;

                    if lista = nil then
                        lista := temp
                    else
                    begin
                         temp^.sledeci := lista;
                         lista := temp;
                    end;

                    n := n + 1;
               end;
          end;
     end;
end;

function izracunajSredinu(lista:ptr; n:integer):real;
var
  rezultat:real;
begin
     rezultat := 0;

     while lista <> nil do
     begin
          rezultat := rezultat + lista^.broj;

          lista := lista^.sledeci;
     end;

     izracunajSredinu := rezultat / n;
end;

procedure minAbs(lista:ptr; sredina:real);
var
   najvecaRazlika:real;
   toJeBroj:integer;
begin
     najvecaRazlika := 0;

     while lista <> nil do
     begin
          if abs(sredina - lista^.broj) > najvecaRazlika then
          begin
               najvecaRazlika := abs(sredina - lista^.broj);
               toJeBroj := lista^.broj;
          end;

          lista := lista^.sledeci;
     end;

     writeln('Broj sa najvecom razlikom je: ', toJeBroj);
end;

procedure oslobodi(lista:ptr);
var
  temp:ptr;
begin
     while lista <> nil do
     begin
          temp := lista^.sledeci;
          dispose(lista);
          lista := temp;
     end;
end;

var
  lista:ptr;
  n:integer;
  sredina:real;
begin
  ucitaj(lista, n);

  if n < 3 then
      writeln('Lista ima manje od tri elemenata')
  else
  begin
      sredina := izracunajSredinu(lista, n);

      minAbs(lista, sredina);
  end;

  oslobodi(lista);

  readln(n)
end.