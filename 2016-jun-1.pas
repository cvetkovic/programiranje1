program jun_2016_zadatak_1;

var
  n:integer;
  matrica:array[1..100, 1..100] of word;
  i,j:integer;
  temp:word;

function proveriParnost (broj:word):boolean;
var
  bin:array[1..16] of boolean;
  i:integer;
  brojJedinica:integer;
begin
     brojJedinica := 0;

     for i := 1 to 16 do
     begin
          bin[i] := false;
     end;

     while broj > 0 do
     begin
          if broj mod 2 = 0 then
               bin[i] := false
          else
               bin[i] := true;

          broj := broj div 2;

          i := i - 1;
     end;

     for i := 1 to 16 do
     begin
          if bin[i] = true then
               brojJedinica := brojJedinica + 1;
     end;

     if brojJedinica mod 2 = 0 then
          proveriParnost := true
     else
          proveriParnost := false;
end;

begin
     readln(n);

     for i := 1 to n do
     begin
          for j := 1 to n do
          begin
               readln(matrica[i, j]);
          end;
     end;

     for i := 1 to n - 1 do
     begin
          for j := 1 to n - 1 do
          begin
               if i = j then
               begin
                    if proveriParnost(matrica[i + 1, j]) = false then
                    begin
                         { zamena }
                         temp := matrica[i, j + 1];
                         matrica[i, j + 1] := matrica[i + 1, j];
                         matrica[i + 1, j] := temp;
                    end
               end;
          end;
     end;

     { ispis matrice }
     for i := 1 to n do
     begin
          for j := 1 to n do
          begin
               write(matrica[i, j], ' ');
          end;

          writeln();
     end;

     readln(i);
end.