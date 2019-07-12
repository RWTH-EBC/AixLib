within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.StaticHeatPump;
model RefrigerantR410aScrollCompressor
  "Static boundaries of a scroll-compressor using R410a"
  extends BaseModelStaticHeatPump(
    nCom = 25,
    replaceable package Medium =
      ExternalMedia.Examples.R410aCoolProp,
    modCom(
      redeclare model EngineEfficiency =
          Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll),
    inpDat(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
  extends Modelica.Icons.Example;

  annotation (experiment(StopTime=16.9999));
end RefrigerantR410aScrollCompressor;
