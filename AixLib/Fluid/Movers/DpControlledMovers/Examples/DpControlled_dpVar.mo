within AixLib.Fluid.Movers.DpControlledMovers.Examples;
model DpControlled_dpVar
  extends DpControlled_dpConst(dpControlled_dp(ctrlType=AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpVar));
  annotation (
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Movers/DpControlledMovers/Examples/DpControlled_dpVar.mos"
        "Simulate and plot"),
    experiment(
      StopTime=3600,
      Tolerance=1e-06));
end DpControlled_dpVar;
