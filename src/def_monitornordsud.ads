package def_monitorNordSud is

   protected type NSMonitor is
      entry nordLock;
      procedure nordUnlock;
      entry sudLock;
      procedure sudUnlock;
    private
      babuinsNord : integer := 0;
      babuinsSud : integer := 0;
    end NSMonitor;

end def_monitorNordSud;
