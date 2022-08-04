within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.SpecifiedModels;
model RefrigerantR410aScrollCompressorController
  "Static boundaries of a scroll-compressor using R410a"
  extends BaseModelStaticHeatPumpController(
    nCom = 1,
    replaceable package Medium =
      Modelica.Media.R134a.R134a_ph,
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

  annotation (experiment(StopTime=16.9999), Documentation(revisions="<html><ul>
  <li>December 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model specifies the base model <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.BaseModelStaticHeatPumpController\">
  BaseModelStaticHeatPumpController</a>. Therefore, a fictious data set
  is used.
</p>
</html>"));
end RefrigerantR410aScrollCompressorController;
