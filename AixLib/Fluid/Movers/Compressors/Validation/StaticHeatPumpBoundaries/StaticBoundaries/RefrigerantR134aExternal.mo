within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.StaticBoundaries;
model RefrigerantR134aExternal
  "Static boundaries of a scroll-compressor using R134a"
  extends BaseModelStaticBoundaries(
    replaceable package Medium =
      HelmholtzMedia.HelmholtzFluids.R134a,
    modCom(
    redeclare model EngineEfficiency =
        EngineEfficiency,
    redeclare model IsentropicEfficiency =
       IsentropicEfficiency,
    redeclare model VolumetricEfficiency =
        VolumetricEfficiency),
    inpDat(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative));
  extends Modelica.Icons.Example;

  annotation (experiment(StopTime=47));
end RefrigerantR134aExternal;
