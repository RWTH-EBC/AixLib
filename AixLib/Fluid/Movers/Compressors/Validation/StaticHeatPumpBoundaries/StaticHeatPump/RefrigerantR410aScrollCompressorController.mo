within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.StaticHeatPump;
model RefrigerantR410aScrollCompressorController
  "Static boundaries of a scroll-compressor using R410a"
  extends BaseModelStaticHeatPumpController(
    nCom = 1,
    replaceable package Medium =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner,
    modCom(
      redeclare model EngineEfficiency =
          Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      useInpFil={true},
      risTim={0.1}),
    inpDat(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative),
    PID(
      yMax=120,
      yMin=10,
      k=1));

  extends Modelica.Icons.Example;

  annotation (experiment(StopTime=16.9999));
end RefrigerantR410aScrollCompressorController;
