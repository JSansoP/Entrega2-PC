package def_monitorNordSud is

   -- Especificam el Monitor
   protected type NSMonitor is
      -- Metode per bloquear el monitor en direcció nord.
      entry nordLock;

      -- Metode per desbloquear el monitor en direcció nord.
      procedure nordUnlock;

      -- Metode per bloquear el monitor en direcció sud.
      entry sudLock;

      -- Metode per desbloquear el monitor en direcció sud.
      procedure sudUnlock;

      -- Metode per sebre quants de babuins hi ha desde el nord.
      function getNord return integer;

      -- Metode per sebre quants de babuins hi ha desde el sud.
      function getSud return integer;

   private
      -- numero de babuins en cada direccio.
      nord : integer := 0;
      sud : integer := 0;
    end NSMonitor;

end def_monitorNordSud;
