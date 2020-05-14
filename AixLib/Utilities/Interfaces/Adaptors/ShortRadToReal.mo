within AixLib.Utilities.Interfaces.Adaptors;
model ShortRadToReal "Convert short radiation to real output"
  ShortRad_in  shortRad_in  annotation (Placement(transformation(
        extent={{-17,-16},{17,16}},
        rotation=0,
        origin={-117,0})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-18},{140,22}})));

equation
  y = shortRad_in.Q_flow_rad;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ShortRadToReal;
