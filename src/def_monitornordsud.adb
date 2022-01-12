-- Joan Sansó Pericàs
-- Jonathan Salisbury Vega
-- Video: https://youtu.be/R2SpQ6-nVPU

package body def_monitorNordSud is

   -- Definim el Cos del monitor
   protected body NSMonitor is
      
   -- implementan el bloqueig desde el nord.
   entry nordLock when (sud=0) and (nord < 3) is
   begin
      nord := nord +1;
   end nordLock;
   
   -- desbloqueig del monitor nord.   
   procedure nordUnlock is
   begin
      nord := nord -1;
   end nordUnlock;
   
   -- implementan el bloqueig desde el sud.
   entry sudLock when(nord=0) and (sud<3) is
   begin
      sud := sud +1;
   end sudLock;
   
   -- desbloqueig del monitor nord.  
   procedure sudUnlock is
   begin
      sud := sud -1;
   end sudUnlock;
   
   -- Metode per sebre quants de babuins hi ha desde el nord.
   function getNord return integer is
   begin
      return nord;
   end getNord;
   
   -- Metode per sebre quants de babuins hi ha desde el sud.
   function getSud return integer is
   begin
      return sud;
   end getSud;
   
      end NSMonitor;

end def_monitorNordSud;
