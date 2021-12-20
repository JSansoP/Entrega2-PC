package body def_monitorNordSud is

   protected body NSMonitor is
   entry nordLock when (sud=0) and (nord < 3) is
   begin
      nord := nord +1;
   end nordLock;
   
   procedure nordUnlock is
   begin
      nord := nord -1;
   end nordUnlock;
   
   entry sudLock when(nord=0) and (sud<3) is
   begin
      sud := sud +1;
   end sudLock;
   
   procedure sudUnlock is
   begin
      sud := sud -1;
   end sudUnlock;
   
   function getNord return integer is
   begin
      return nord;
   end getNord;
   
   function getSud return integer is
   begin
      return sud;
   end getSud;
   
      end NSMonitor;

end def_monitorNordSud;
