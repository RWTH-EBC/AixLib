within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses;
model ConvToN "Model to convert relative compressor speed to actual r/min"
  extends Modelica.Blocks.Interfaces.SISO;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Converter Block to calculate actual compressor speed used in ND-Tables.</p>
</html>"));
end ConvToN;
