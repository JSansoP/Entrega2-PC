with Text_IO;
use Text_IO;

with def_monitornordsud;
use def_monitorNordSud;

with ada.numerics.discrete_random;

procedure Main is
   type randRange is range 1..10;

BABUINS : constant integer := 10; --N/2 babuins a cada costat
   MAX_COUNT : constant integer := 3; --Nombre de vegades que cada babui crusa
   monitor : NSMonitor;
package Rand_Int is new ada.Numerics.Discrete_Random(randRange);
   use Rand_Int;
      gen: Generator;
   task type Babui is
      entry Start(Idx: in integer);
   end Babui;

   task body Babui is
      Id: integer;
      tipus : Character;
      nVegades : integer := 0;
      rand : Generator;
      aleatori: randRange;
      dur : Duration;
   begin
      accept Start(Idx : in integer) do
         Id := Idx;
         if Id <= 5 then
            tipus := 'N';
         else
               tipus := 'S';
         end if;

      end Start;
      reset(rand);
      Put_Line("Babui" & Id'img & " s'aixeca. Vol anar cap al "&tipus);
      for i in 0..MAX_COUNT loop
         if tipus = 'N' then
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            monitor.nordLock;
            nVegades := nVegades + 1;
            Put_Line("Babui "& Id'img & " esta cruçant cap al " & tipus);
            Put_Line("Hi ha "& monitor.getNord'Img & " babuins a la corda direcció " & tipus);
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            monitor.nordUnlock;
            Put_Line("Babui "& Id'img & " baixa de la corda");
            Put_Line("Hi ha "& monitor.getNord'Img & " babuins a la corda direcció " & tipus);
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            Put_Line("Babui "& Id'img & " fa la volta.");
         else
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            monitor.sudLock;
            nVegades := nVegades + 1;
            Put_Line("Babui "& Id'img & " esta cruçant cap al " & tipus);
            Put_Line("Hi ha "& monitor.getSud'Img & " babuins a la corda direcció " & tipus);
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            monitor.sudUnlock;
            Put_Line("Babui "& Id'img & " baixa de la corda");
            Put_Line("Hi ha "& monitor.getSud'Img & " babuins a la corda direcció " & tipus);
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
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
