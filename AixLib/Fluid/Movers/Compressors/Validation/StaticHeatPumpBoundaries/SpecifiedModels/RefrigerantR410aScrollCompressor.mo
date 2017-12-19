within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.SpecifiedModels;
model RefrigerantR410aScrollCompressor
  "Static boundaries of a scroll-compressor using R410a"
  extends BaseModelStaticHeatPump(
    nCom = 1,
    replaceable package Medium =
      Modelica.Media.R134a.R134a_ph,
    modCom(
      redeclare model EngineEfficiency =
          Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll),
    inpDat(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments));
  extends Modelica.Icons.Example;

  annotation (experiment(StopTime=16.9999), Documentation(revisions="<html>
<ul>
  <li>
  December 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end RefrigerantR410aScrollCompressor;
