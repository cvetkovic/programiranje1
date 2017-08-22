program septembar_2016_zadatak_1;

var
  ulaz, izlaz:string;
  fUlaz, fIzlaz:text;
  k:char;
  temp:integer;

begin
  readln(ulaz);
  readln(izlaz);

  assign(fUlaz, ulaz);
  assign(fIzlaz, izlaz);

  reset(fUlaz);
  rewrite(fIzlaz);

  while not eof(fUlaz) do
  begin
       read(fUlaz, k);

       if (k >= '0') and (k <= '9') then
       begin
           if temp = 0 then
               temp:=ord(k)-48
           else
               temp:= temp * 10 + ord(k)-48;
       end
       else
       begin
           if temp<>0 then
           begin
               if (temp >= 20) and (temp <= 39) then
               begin
                    if temp div 10 = 2 then
                         write(fIzlaz, 'dvadeset')
                    else
                        write(fIzlaz, 'trideset');

                    case temp mod 10 of
                         0:write(fIzlaz, '');
                         1:write(fIzlaz, ' jedan');
                         2:write(fIzlaz, ' dva');
                         3:write(fIzlaz, ' tri');
                         4:write(fIzlaz, ' četiri');
                         5:write(fIzlaz, ' pet');
                         6:write(fIzlaz, ' šest');
                         7:write(fIzlaz, ' sedam');
                         8:write(fIzlaz, ' osam');
                         9:write(fIzlaz, ' devet');
                    end;
               end
               else
                   write(fIzlaz, temp);

               temp:=0;
           end;

           write(fIzlaz, k);
       end;
  end;

  close(fUlaz);
  close(fIzlaz);
end.