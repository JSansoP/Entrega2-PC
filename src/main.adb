with Text_IO;
use Text_IO;

with def_monitornordsud;
use def_monitorNordSud;

with ada.numerics.Discrete_Random;

procedure Main is
   type randRange is range 1..3;
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
      aleatori := random(gen);
      dur := duration(aleatori);
      Delay dur;
      Put_Line("BON DIA som el babuí" & Id'img & " i vaig cap al " & tipus);
      for i in 1..MAX_COUNT loop
         if tipus = 'N' then
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            monitor.nordLock;
            nVegades := nVegades + 1;
            Put_Line("***** A la corda n'hi ha" & monitor.getNord'Img & " direcció Sud *****");
            Put_Line(tipus & Id'img & ": és a la corda i travessa cap al sud");
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            monitor.nordUnlock;
            Put_Line("***** A la corda n'hi ha"& monitor.getNord'Img & " direcció Sud *****");
            Put_Line(tipus & Id'img & ": és a la corda i travessa cap al sud");
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            Put_Line(tipus & Id'img & " ha arribat a la vorera");
         else
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            monitor.sudLock;
            nVegades := nVegades + 1;
            Put_Line("+++++ A la corda n'hi ha"& monitor.getNord'Img & " direcció Nord +++++");
            Put_Line(tipus & Id'img & ": és a la corda i travessa cap al nord");
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            monitor.sudUnlock;
            Put_Line("+++++ A la corda n'hi ha"& monitor.getNord'Img & " direcció Nord +++++");
            Put_Line(tipus & Id'img & ": és a la corda i travessa cap al nord");
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur;
            Put_Line(tipus & Id'img & " ha arribat a la vorera");
         end if;

         Put_Line(tipus & Id'img & " : Ha fet la volta" &i'Img &" de " &MAX_COUNT'Img);
      end loop;
      end Babui;

   type arraybabuins is array (1..BABUINS) of Babui;
   arrBabuins : arraybabuins;
begin
   --  Insert code here.
   reset(gen);

   for Idx in 1..BABUINS loop
      arrBabuins(Idx).Start(Idx);
   end loop;

end Main;
