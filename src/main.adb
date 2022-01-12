with Text_IO;
use Text_IO;

with def_monitornordsud;
use def_monitorNordSud;

with ada.numerics.Discrete_Random;

procedure Main is
   type randRange is range 1..3; -- rang per a la generació de nums aleatoris
   BABUINS : constant integer := 10; --N/2 babuins a cada costat
   MAX_COUNT : constant integer := 3; --Nombre de vegades que cada babui creua
   monitor : NSMonitor; -- Monitor que utilitzam
   package Rand_Int is new ada.Numerics.Discrete_Random(randRange); -- definim el gen de nums aleatoris
   use Rand_Int;
   gen: Generator;
   task type Babui is -- declaram els babuins com a processos.
      entry Start(Idx: in integer);
   end Babui;

   task body Babui is
      -- atributs dels babuins
      Id: integer;
      tipus : Character; -- N: Nord, S: Sud.
      nVegades : integer := 0; -- num de vegades que ha creuat

      aleatori: randRange;
      dur : Duration; -- duracio de l'espera
   begin
      accept Start(Idx : in integer) do -- execució d'un babui
         Id := Idx;
         if Id <= 5 then -- asignam una direccio depenent del ID
            tipus := 'N';
         else
            tipus := 'S';
         end if;

      end Start;
      aleatori := random(gen);
      dur := duration(aleatori);
      Delay dur; -- esperam un temps aleatori.
      Put_Line("BON DIA som el babuí" & Id'img & " i vaig cap al " & tipus);
      for i in 1..MAX_COUNT loop -- per a cada vegada que ha de creuar
         if tipus = 'N' then -- si ve del nord
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur; -- esperam per veure l'intercalat
            monitor.nordLock; -- bloqueam el monitor
            nVegades := nVegades + 1; -- incrementam les vegades
            Put_Line("***** A la corda n'hi ha" & monitor.getNord'Img & " direcció Sud *****");
            Put_Line(tipus & Id'img & ": és a la corda i travessa cap al sud"); -- printeam per veure l'execuccio
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur; -- esperam per veure l'intercalat
            monitor.nordUnlock; -- desbloqueam el monitor
            Put_Line("***** A la corda n'hi ha"& monitor.getNord'Img & " direcció Sud *****");
            Put_Line(tipus & Id'img & ": és a la corda i travessa cap al sud"); -- printeam per veure l'execuccio
            aleatori := random(gen);
            dur := duration(aleatori);
            Delay dur; -- esperam per veure l'intercalat
            Put_Line(tipus & Id'img & " ha arribat a la vorera");
         else
            -- si ve del sud, feim el mateix que al cas anterior pero usant l'altre monitor.
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

   -- declaram l'array de babuins
   type arraybabuins is array (1..BABUINS) of Babui;
   arrBabuins : arraybabuins;
begin
   reset(gen); -- inicialitzam el generador.
   for Idx in 1..BABUINS loop
      arrBabuins(Idx).Start(Idx); -- iniciam tots els babuins
   end loop;

end Main;
