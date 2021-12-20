package def_monitorNordSud is

   protected type NSMonitor is
      entry nordLock;
      procedure nordUnlock;
      entry sudLock;
      procedure sudUnlock;
      function getNord return integer;
      function getSud return integer;
    private
      nord : integer := 0;
      sud : integer := 0;
    end NSMonitor;

end def_monitorNordSud;
