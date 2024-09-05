within AixLib.Fluid.Movers.DpControlledMovers.Examples;
model DpVar
  extends DpConst(dpControlled_dp(ctrlType=AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpVar));
  annotation (
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Movers/DpControlledMovers/Examples/DpVar.mos"
        "Simulate and plot"),
    experiment(
      StopTime=3600,
      Tolerance=1e-06));
end DpVar;
