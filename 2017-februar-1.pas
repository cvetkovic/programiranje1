program februar_2017_zadatak_1;

type
  tmap=array[1..100, 1..100] of boolean;
  dim=1..100;

procedure ucitajMapu(var m:dim; var n:dim; var mapa:tmap);
var
  fajl:text;
  i,j:integer;
  tmp:integer;
begin
     assign(fajl, 'maps.txt');
     reset(fajl);

     // ucitavanje dimenzija
     read(fajl, m, n);

     for i:=1 to m do
     begin
         for j:=1 to n do
         begin
             read(fajl, tmp);

             if tmp=1 then
                  mapa[i,j]:=true
             else
                  mapa[i,j]:=false;
         end;
     end;

     close(fajl);
end;

function obradiMapu(var m:dim; var n:dim; mapa:tmap):tmap;
var
  fajl:text;
  i,j:integer;
  tmp:integer;
  novaMapa:tmap;
begin
     for i:=1 to m do
     begin
         for j:=1 to n do
         begin
             if mapa[i,j]=true then
             begin
                  if i-1>=1 then
                  begin
                       if j-1>=1 then
                          novaMapa[i-1,j-1]:=true;

                       novaMapa[i-1,j]:=true;

                       if j<=n then
                          novaMapa[i-1,j+1]:=true;
                  end;

                  if i+1<=m then
                  begin
                       if j-1>=1 then
                          novaMapa[i+1,j-1]:=true;

                       novaMapa[i+1,j]:=true;

                       if j<=n then
                          novaMapa[i+1,j+1]:=true;
                  end;

                  if j-1>=1 then
                     novaMapa[i,j-1]:=true;
                  if j<=n then
                     novaMapa[i,j+1]:=true;
             end;
         end;
     end;

     obradiMapu:=novaMapa;
end;

procedure ispisiMapu(m:dim; n:dim; mapa:tmap);
var
  fajl:text;
  i,j:integer;
begin
     assign(fajl, 'bombs.txt');
     rewrite(fajl);

     writeln(fajl, m, ' ', n);

     for i:=1 to m do
     begin
         for j:=1 to n do
         begin
              if mapa[i,j]=true then
                  write(fajl, 1, ' ')
              else
                  write(fajl, 0, ' ');
         end;

         writeln(fajl);
     end;

     close(fajl);
end;

procedure ispisiNajveciBrojMinaOkoPolja(m:dim; n:dim; mapa:tmap);
var
  i,j:integer;
  max,temp:integer;
begin
     max:=0;

     for i:=1 to m do
     begin
         for j:=1 to n do
         begin
             if mapa[i,j]=false then
             begin
                  if i-1>=1 then
                  begin
                     if j-1>=1 then
                        if mapa[i-1,j-1]=true then
                           temp:=temp+1;

                     if mapa[i-1,j]=true then
                        temp:=temp+1;

                     if j<=n then
                        if mapa[i-1,j+1]=true then
                           temp:=temp+1;
                  end;



                  if j-1>=1 then
                     if mapa[i,j-1]=true then
                        temp:=temp+1;
                  if mapa[i,j]=true then
                     temp:=temp+1;
                  if j<=n then
                     if mapa[i,j+1]=true then
                        temp:=temp+1;

                  if i+1<=m then
                  begin
                     if j-1>=1 then
                        if mapa[i+1,j-1]=true then
                           temp:=temp+1;
                     if mapa[i+1,j]=true then
                        temp:=temp+1;
                     if j<=n then
                        if mapa[i+1,j+1]=true then
                           temp:=temp+1;
                  end;

                  if temp>max then
                     max:=temp;
             end;
         end;

         temp:=0;
     end;

     writeln(max);
end;

var
  novaMapa:tmap;
  mapa:tmap;
  m,n:dim;

begin
     ucitajMapu(m, n, mapa);
     novaMapa := obradiMapu(m, n, mapa);
     ispisiMapu(m, n, novaMapa);

     ispisiNajveciBrojMinaOkoPolja(m, n, mapa);
end.