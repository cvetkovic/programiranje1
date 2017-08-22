program jun_2016_zadatak_2;

type
  ptr=^elem;
  elem=record
    otvaranje:record
      sat:integer;
      minut:integer;
    end;
    zatvaranje:record
      sat:integer;
      minut:integer;
    end;
    cena:real;
    naziv:string[255];
    sledeci:ptr;
  end;
  vreme=string[5];

procedure procitajDatoteku(var lista:ptr);
var
  fajl:text;
  vremeOtvaranja, vremeZatvaranja:string[5];
  cena:real;
  naziv:string[255];
  i:integer;
  temp:ptr;
  t:char;

begin
     assign(fajl, 'muzeji.txt');
     reset(fajl);

     i := 1;

     while not eof(fajl) do
     begin
          readln(fajl, vremeOtvaranja, t, vremeZatvaranja, t, cena, t, naziv);

          new(temp);

          temp^.otvaranje.sat := (ord(vremeOtvaranja[1]) - 48) * 10;
          temp^.otvaranje.sat := temp^.otvaranje.sat + (ord(vremeOtvaranja[2]) - 48);
          temp^.otvaranje.minut := (ord(vremeOtvaranja[4]) - 48) * 10;
          temp^.otvaranje.minut := temp^.otvaranje.minut + (ord(vremeOtvaranja[5]) - 48);

          temp^.zatvaranje.sat := (ord(vremeZatvaranja[1]) - 48) * 10;
          temp^.zatvaranje.sat := temp^.zatvaranje.sat + (ord(vremeZatvaranja[2]) - 48);
          temp^.zatvaranje.minut := (ord(vremeZatvaranja[4]) - 48) * 10;
          temp^.zatvaranje.minut := temp^.zatvaranje.minut + (ord(vremeZatvaranja[5]) - 48);

          temp^.cena := cena;
          temp^.naziv := naziv;

          temp^.sledeci := nil;

          if lista = nil then
               lista := temp
          else
          begin
               temp^.sledeci := lista;
               lista := temp;
          end;
     end;

     close(fajl);
end;

procedure sortirajListu(lista:ptr);
var
  t1, t2 : ptr;
  temp : real;
  broj:integer;
  tekst:string[255];
begin
     t1 := lista;

     while t1 <> nil do
     begin
          t2 := t1;

          while t2 <> nil do
          begin
               if t1^.cena < t2^.cena then
               begin
                    broj := t1^.otvaranje.sat;
                    t1^.otvaranje.sat := t2^.otvaranje.sat;
                    t2^.otvaranje.sat := broj;

                    broj := t1^.otvaranje.minut;
                    t1^.otvaranje.minut := t2^.otvaranje.minut;
                    t2^.otvaranje.minut := broj;

                    broj := t1^.zatvaranje.sat;
                    t1^.zatvaranje.sat := t2^.zatvaranje.sat;
                    t2^.zatvaranje.sat := broj;

                    broj := t1^.zatvaranje.minut;
                    t1^.zatvaranje.minut := t2^.zatvaranje.minut;
                    t2^.zatvaranje.minut := broj;

                    temp := t1^.cena;
                    t1^.cena := t2^.cena;
                    t2^.cena := temp;

                    tekst := t1^.naziv;
                    t1^.naziv := t2^.naziv;
                    t2^.naziv := tekst;
               end;

               t2 := t2^.sledeci;
          end;

          t1 := t1^.sledeci;
     end;
end;

procedure oslobodiMemoriju(lista:ptr);
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

procedure ispisiRezultat(lista:ptr; vo:vreme; vz:vreme);
var
  otvaranjeSat,otvaranjeMinut,zatvaranjeSat,zatvaranjeMinut:integer;
begin
       otvaranjeSat := (ord(vo[1]) - 48) * 10;
       otvaranjeSat := otvaranjeSat + (ord(vo[2]) - 48);
       otvaranjeMinut := (ord(vo[4]) - 48) * 10;
       otvaranjeMinut := otvaranjeMinut + (ord(vo[5]) - 48);

       zatvaranjeSat := (ord(vz[1]) - 48) * 10;
       zatvaranjeSat := zatvaranjeSat + (ord(vz[2]) - 48);
       zatvaranjeMinut := (ord(vz[4]) - 48) * 10;
       zatvaranjeMinut := zatvaranjeMinut + (ord(vz[5]) - 48);

       while lista <> nil do
       begin
            if (lista^.otvaranje.sat <= otvaranjeSat) and (lista^.zatvaranje.sat >= zatvaranjeSat) then
            begin
                 if lista^.otvaranje.sat = otvaranjeSat then
                 begin
                      if lista^.otvaranje.minut <= otvaranjeMinut then
                           writeln(lista^.otvaranje.sat, ':', lista^.otvaranje.minut, ' ', lista^.zatvaranje.sat, ':', lista^.zatvaranje.minut, ' ',
                                   lista^.cena:2:2, ' ', lista^.naziv);
                 end
                 else if lista^.zatvaranje.sat = zatvaranjeSat then
                 begin
                      if lista^.zatvaranje.minut >= zatvaranjeMinut then
                           writeln(lista^.otvaranje.sat, ':', lista^.otvaranje.minut, ' ', lista^.zatvaranje.sat, ':', lista^.zatvaranje.minut, ' ',
                                   lista^.cena:2:2, ' ', lista^.naziv);
                 end
                 else
                     writeln(lista^.otvaranje.sat, ':', lista^.otvaranje.minut, ' ', lista^.zatvaranje.sat, ':', lista^.zatvaranje.minut, ' ',
                             lista^.cena:2:2, ' ', lista^.naziv);
            end;

            lista := lista^.sledeci;
       end;
end;

var
  lista:ptr;
  vo, vz:string[5];
  t:char;

begin
  procitajDatoteku(lista);
  sortirajListu(lista);

  readln(vo, t, vz);

  ispisiRezultat(lista, vo, vz);
  oslobodiMemoriju(lista);

  readln(t);
end.