within PhysicalCompressors.RotaryCompressor.Geometry;
model Compression
  "Model that describes the thermodynamic compression"

  package Medium = AixLib.Media.Refrigerants.R32.R32_IIR_P1_70_T233_373_Horner
      "Internal medium model";

  Modelica.SIunits.Volume V_gas = V1;
  constant Modelica.SIunits.Mass m = 0.01;


  Modelica.Blocks.Interfaces.RealInput V1
    annotation (Placement(transformation(extent={{-120,-22},{-80,18}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

end Compression;
