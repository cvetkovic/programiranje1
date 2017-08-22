program jul_2016_zadatak_1;
type
  m = array[1..20, 1..20] of string[1];
var
  matrica:m;
  n:integer;
  fajl:text;
  i,j:integer;
  t:char;
  svi:boolean;

function proveraHorizontalno(matrica:m):boolean;
var
  i,j:integer;
begin
     proveraHorizontalno:=false;

     svi := true;

     for i := 1 to n do
     begin
          t := matrica[i, 1][1];

          for j := 1 to n do
          begin
               if t = matrica[i, j] then
               begin
                    if (j = n) and svi = true then
                    begin
                       writeln(matrica[i, 1], ' je pobednik');
                       proveraHorizontalno := true;
                       break;
                    end;
               end
               else
                   svi := false;
          end;

          svi := true;
     end;
end;

function proveraVertikalno(matrica:m):boolean;
var
  i,j:integer;
begin
     proveraVertikalno := false;

     svi := true;

     for i := 1 to n do
     begin
          t := matrica[1, i][1];

          for j := 1 to n do
          begin
               if t = matrica[j, i] then
               begin
                    if (j = n) and svi = true then
                    begin
                       writeln(matrica[j, i], ' je pobednik');
                       proveraVertikalno := true;
                       break;
                    end;
               end
               else
                   svi := false;
          end;

          svi := true;
     end;
end;

function proveraDijagonala(matrica:m):boolean;
var
  i,j:integer;
begin
     proveraDijagonala := false;

     svi := true;
     t := matrica[1, 1][1];

     // glavna dijagonala
     for i := 1 to n do
     begin
          if t = matrica[i, i] then
          begin
               if (i = n) and svi = true then
               begin
                    writeln(t, ' je pobednik');
                    proveraDijagonala := true;
                    break;
               end
          end
          else
              svi := false;
     end;

     svi := true;
     t := matrica[1, n][1];

     // sporedna dijagonala
     for i:=1 to n do
     begin
          if t = matrica[i, n + 1 - i] then
          begin
               if (i = n) and svi = true then
               begin
                    writeln(t, ' je pobednik');
                    proveraDijagonala := true;
                    break;
               end
          end
          else
              svi := false;
     end;
end;

begin
     assign(fajl, 'iks-oks.txt');
     reset(fajl);

     readln(fajl, n);

     for i := 1 to n do
     begin
          for j := 1 to n do
          begin
               read(fajl, matrica[i, j]);
               write(matrica[i, j]);
          end;

          readln(fajl);
          writeln();
     end;

     if (proveraHorizontalno(matrica) = false) and (proveraVertikalno(matrica) = false) and (proveraDijagonala(matrica) = false) then
          writeln('Igra nije zavrsena');

     readln(n)

end.