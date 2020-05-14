within AixLib.Utilities.Interfaces.Adaptors;
model RealToShortRad "Convert a real input to short radiation"
  ShortRad_out shortRad_out annotation (Placement(transformation(
        extent={{-17,-16},{17,16}},
        rotation=0,
        origin={117,0})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

equation
  shortRad_out.Q_flow_rad = u;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RealToShortRad;
