program oktobar_2016_zadatak_1;

type
  ptr=^zapis;
  zapis=record
      ime:array[1..10] of char;
      prezime:array[1..15] of char;
      godinaRodenja:integer;

      sledeci:ptr;
  end;

var
  ulaz, izlaz : string;
  fUlaz : file of zapis;
  fIzlaz : text;

  temp : zapis;

begin
  readln(ulaz);
  readln(izlaz);

  assign(fUlaz, ulaz);
  assign(fIzlaz, izlaz);

  reset(ulaz);
  rewrite(izlaz);

  while not eof(ulaz) do
  begin
       read(fUlaz, temp);

       if temp.ime[0] >= 'a' and temp.ime[0] >= 'z' then
            temp.ime[0] := chr(ord(temp.ime[0]) - 32);

       if temp.prezime[0] >= 'a' and temp.prezime[0] >= 'z' then
            temp.prezime[0] := chr(ord(temp.prezime[0]) - 32);

       writeln(fIzlaz, temp.ime, ' ', temp.prezime, ' ', (2016 - temp.godinaRodenja));
  end;

  close(fUlaz);
  close(fIzlaz);
end.