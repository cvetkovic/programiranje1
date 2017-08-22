program jul_2017_zadatak_1;

type
  ptr=^elem;
  elem=record
    v:char;
    rr:integer;
    next:ptr;
  end;

function ubacenKarakter(lista:ptr; k:char):boolean;
begin
     ubacenKarakter:=false;

     while lista <> nil do
     begin
          if lista^.v = k then
          begin
               ubacenKarakter:=true;
               break;
          end;

          lista:=lista^.next;
     end;
end;

procedure dodajKarakter(var lista:ptr; k:char);
var
  temp:ptr;
begin
     new(temp);
     temp^.v:=k;
     temp^.rr:=1;
     temp^.next:=nil;

     if lista = nil then
         lista:=temp
     else
     begin
          temp^.next:=lista;
          lista:=temp;
     end;
end;

procedure inkrementiraj(lista:ptr; k:char);
begin
     while lista <> nil do
     begin
          if lista^.v = k then
          begin
               lista^.rr:=lista^.rr+1;

               break;
          end;

          lista:=lista^.next;
     end;
end;

function obradiTekst():ptr;
var
  fajl:text;
  k:char;
  rezultat:ptr;
begin
     assign(fajl, 'tekst.txt');
     reset(fajl);

     rezultat := nil;

     while not eof(fajl) do
     begin
          read(fajl, k);

          // provereravanja da budu samo slova
          if not (((k >= 'A') and (k <= 'Z')) or ((k >= 'a') and (k <= 'z'))) then
              continue;

          // toLower()
          if (k >= 'A') and (k <= 'Z') then
              k := chr(ord(k) + 32);

          if (ubacenKarakter(rezultat, k) = false) then
              dodajKarakter(rezultat, k)
          else
              inkrementiraj(rezultat, k);
     end;

     obradiTekst:=rezultat;
     close(fajl);
end;

procedure ispisi(lista:ptr);
begin
     while lista <> nil do
     begin
          writeln(lista^.v, ' -> ', lista^.rr);

          lista:=lista^.next;
     end;
end;

procedure oslobodi(lista:ptr);
var
  temp:ptr;
begin
     while lista <> nil do
     begin
          temp:=lista^.next;
          dispose(lista);
          lista:=temp;
     end;
end;

var
  lista:ptr;

begin
     lista:=obradiTekst();

     ispisi(lista);
     oslobodi(lista);
     readln();
end.