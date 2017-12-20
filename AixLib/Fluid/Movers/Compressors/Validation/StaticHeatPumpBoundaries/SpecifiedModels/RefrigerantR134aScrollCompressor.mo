within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.SpecifiedModels;
model RefrigerantR134aScrollCompressor
  "Static boundaries of a scroll-compressor using R134a"
  extends BaseModelStaticBoundaries(
    replaceable package Medium =
      WorkingVersion.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
    modCom(
      redeclare model EngineEfficiency =
        EngineEfficiency,
      redeclare model VolumetricEfficiency =
        VolumetricEfficiency,
      redeclare model IsentropicEfficiency =
        IsentropicEfficiency));
  extends Modelica.Icons.Example;

protected
  model EngineEfficiency
  extends Utilities.EngineEfficiency.PartialEngineEfficiency(
    useIseWor = false);
  equation
     etaEng = 0.8704+0.001295*rotSpe+0.05194*piPre-8.006e-06*rotSpe^2-
       0.0001272*rotSpe*piPre-0.01146*piPre^2+1.059e-06*rotSpe^2*piPre-
       2.265e-06*rotSpe*piPre^2+0.0008853*piPre^3;
  end EngineEfficiency;

  model VolumetricEfficiency
    "Fitted volumetric efficiency"
    extends Utilities.VolumetricEfficiency.PartialVolumetricEfficiency;
  equation
    lamH = 0.5828+0.0303*rotSpe-0.1727*piPre-0.000588*rotSpe^2+
      0.003072*rotSpe*piPre+0.01238*piPre^2+3.434e-06*rotSpe^3-
      1.496e-05*rotSpe^2*piPre -0.0001785*rotSpe*piPre^2;
  end VolumetricEfficiency;

  model IsentropicEfficiency
    extends Utilities.IsentropicEfficiency.PartialIsentropicEfficiency;
  equation
    etaIse = (-3.565 + 0.2464*rotSpe + 1.227*piPre - 0.007986*rotSpe^2+
    0.03947*rotSpe*piPre-0.9075*piPre^2+0.0001086*rotSpe^3-
     0.0006588*rotSpe^2*piPre +0.0001482*rotSpe*piPre^2 +
      0.1721*piPre^3-5.291e-07*rotSpe^4+3.353e-06*rotSpe^3*piPre+
      1.037e-05*rotSpe^2*piPre^2 - 0.0001854*rotSpe*piPre^3-0.01102*piPre^4)*1.05;
  end IsentropicEfficiency;

  annotation (experiment(StopTime=46.9999), Documentation(revisions="<html>
<ul>
  <li>
  December 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end RefrigerantR134aScrollCompressor;
