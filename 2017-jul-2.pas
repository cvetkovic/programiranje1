program jul_2017_zadatak_2;

type
  ptr=^elem;
  elem=record
    broj:integer;
    osnova:1..17;
    sledeci:ptr;
  end;

  konvertovatno=array[1..10] of char;

procedure dodajElement(var lst:ptr; br:integer; os:integer);
var
  temp:ptr;
begin
  new(temp);
  temp^.broj:=br;
  temp^.osnova:=os;
  temp^.sledeci:=nil;

  if lst=nil then
       lst:=temp
  else
  begin
       temp^.sledeci:=lst;
       lst:=temp;
  end;
end;

function konvertuj(broj:integer; osnova:integer):konvertovatno;
var
  rezultat:array[1..10] of char;
  i, j:integer;
  tmp:integer;
begin
     i:=10;

     for j:=1 to 10 do
         rezultat[j]:='0';

     while ((broj > 0) and (i > 0)) do
     begin
          tmp:= broj mod osnova;

          if broj < 10 then
               rezultat[i]:=chr(tmp + 48)
          else if broj = 10 then
               rezultat[i]:='A'
          else if broj = 11 then
               rezultat[i]:='B'
          else if broj = 12 then
               rezultat[i]:='C'
          else if broj = 13 then
               rezultat[i]:='D'
          else if broj = 14 then
               rezultat[i]:='E'
          else if broj = 15 then
               rezultat[i]:='F';

          broj := broj div osnova;
          i:=i-1;
     end;

     konvertuj:=rezultat;
end;

function charToInt(c:char):integer;
begin
  if ((c >= '0') and (c <= '9')) then
       charToInt:=ord(c)-48
  else if c = 'A' then
       charToInt:=10
  else if c = 'B' then
       charToInt:=11
  else if c = 'C' then
       charToInt:=12
  else if c = 'D' then
       charToInt:=13
  else if c = 'E' then
       charToInt:=14
  else if c = 'F' then
       charToInt:=15
end;

function odrediRazliku(kod:konvertovatno):integer;
var
  i, j:integer;
  max:integer;
  prvi, drugi:integer;
begin
     max:=0;

     for i:=1 to 10 do
     begin
          prvi:=charToInt(kod[i]);

          for j:=1 to 10 do
          begin
               drugi:=charToInt(kod[j]);

               if (prvi - drugi > max) then
                    max:=prvi - drugi;
          end;
     end;

     odrediRazliku:=max;
end;

procedure obradi(lista:ptr);
var
  kod:konvertovatno;
  maxRazlika:integer;
begin
     while lista <> nil do
     begin
          kod:=konvertuj(lista^.broj, lista^.osnova);

          maxRazlika:=odrediRazliku(kod);

          writeln(lista^.broj, ' [', lista^.osnova, '] -> ', maxRazlika);

          lista:=lista^.sledeci;
     end;
end;

procedure oslobiMemoriju(lista:ptr);
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
  b,o:integer;
  lista:ptr;

begin
     lista:=nil;

     while 1=1 do begin
           read(b, o);

           if (o<1) or (o>17) then
              break;

           dodajElement(lista, b, o);
     end;

     obradi(lista);
     oslobiMemoriju(lista);

     read();
end.