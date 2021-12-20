with Text_IO;
use Text_IO;

with def_monitornordsud;
use def_monitorNordSud;

procedure Main is
BABUINS : constant integer := 10; --N/2 babuins a cada costat
   MAX_COUNT : constant integer := 3; --Nombre de vegades que cada babui crusa

   monitor : NSMonitor;

   task type Babui is
      entry Start(Idx: in integer);
   end Babui;

   task body Babui is
      Id: integer;
      tipus : Character;
      nVegades : integer := 0;
   begin
      accept Start(Idx : in integer) do
         Id := Idx;
         if Id <= 5 then
            tipus := 'N';
         else
               tipus := 'S';
         end if;

      end Start;
      Put_Line("Babui" & Id'img & " s'aixeca. Vol anar cap al "&tipus);
      for i in 0..MAX_COUNT loop
         if tipus = 'N' then
            delay 1.0;
            monitor.nordLock;
            nVegades := nVegades + 1;
            Put_Line("Babui "& Id'img & " esta cruçant cap al " & tipus);
            Put_Line("Hi ha "& monitor.getNord'Img & " babuins a la corda direcció " & tipus);
            delay 2.0;
            monitor.nordUnlock;
            Put_Line("Babui "& Id'img & " baixa de la corda");
            Put_Line("Hi ha "& monitor.getNord'Img & " babuins a la corda direcció " & tipus);
            delay 2.0;
            Put_Line("Babui "& Id'img & " fa la volta.");
         else
            delay 1.0;
            monitor.sudLock;
            nVegades := nVegades + 1;
            Put_Line("Babui "& Id'img & " esta cruçant cap al " & tipus);
            Put_Line("Hi ha "& monitor.getSud'Img & " babuins a la corda direcció " & tipus);
            delay 2.0;
            monitor.sudUnlock;
            Put_Line("Babui "& Id'img & " baixa de la corda");
            Put_Line("Hi ha "& monitor.getSud'Img & " babuins a la corda direcció " & tipus);
            delay 2.0;
            Put_Line("Babui "& Id'img & " fa la volta.");
         end if;

      end loop;
      end Babui;

type arraybabuins is array (1..BABUINS) of Babui;
arrBabuins : arraybabuins;

begin
   --  Insert code here.



   for Idx in 1..BABUINS loop
      arrBabuins(Idx).Start(Idx);
   end loop;

end Main;
