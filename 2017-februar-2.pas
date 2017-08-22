program februar_2017_zadatak_2;

type
  ptr=^elem;
  elem=record
    stepen:integer;
    koeficijent:integer;
    sledeci:ptr;
  end;

procedure ucitajPolinom(stepen:integer; var lista:ptr);
var
  temp:ptr;
  i:integer;
begin
     for i := 0 to stepen do
     begin
          if stepen <> 0 then
          begin
               new(temp);
               temp^.stepen:=i;
               read(temp^.koeficijent);
               temp^.sledeci:=nil;

               if lista = nil then
                    lista:=temp
               else
               begin
                    temp^.sledeci:=lista;
                    lista:=temp;
               end;
          end;
     end;
end;

function uredeni():boolean;
begin
     uredeni:=true;
end;

function nadiKoeficijent(lista:ptr; stepenClana:integer):integer;
begin
     nadiKoeficijent:=0;

     while lista <> nil do
     begin
          if lista^.stepen = stepenClana then
          begin
               nadiKoeficijent:=lista^.koeficijent;
               break;
          end;

          lista:=lista^.sledeci;
     end;
end;

function saberi(prvi:ptr; drugi:ptr):ptr;
var
  veci, i:integer;
  temp, rezultat:ptr;
  kp, kd:integer;
begin
     if prvi^.stepen > drugi^.stepen then
         veci:=prvi^.stepen
     else
         veci:=drugi^.stepen;

     rezultat:=nil;

     for i := 0 to veci do
     begin
          kp:=nadiKoeficijent(prvi, i);
          kd:=nadiKoeficijent(drugi, i);

          if kp + kd <> 0 then
          begin
               new(temp);
               temp^.koeficijent:=kp + kd;
               temp^.stepen:=i;
               temp^.sledeci:=nil;

               if rezultat = nil then
                    rezultat:=temp
               else
               begin
                    temp^.sledeci:=rezultat;
                    rezultat:=temp;
               end;
          end;
     end;

     saberi:=rezultat;
end;

procedure oslobodi(lista:ptr);
var
  temp:ptr;
begin
     while lista <> nil do
     begin
          temp:=lista^.sledeci;
          dispose(temp);
          lista:=temp;
     end;
end;

procedure ispisi(lista:ptr);
begin
     while lista <> nil do
     begin
          writeln(lista^.koeficijent, 'x^', lista^.stepen);

          lista:=lista^.sledeci;
     end;
end;

var
  prvi,drugi,rezultat:ptr;
  t:integer;
begin
  read(t);
  ucitajPolinom(t, prvi);
  read(t);
  ucitajPolinom(t, drugi);

  rezultat:=nil;

  if uredeni = true then
  begin
       rezultat := saberi(prvi, drugi);
       ispisi(rezultat);
  end;

  oslobodi(prvi);
  oslobodi(drugi);
  oslobodi(rezultat);

  readln(t);
end.