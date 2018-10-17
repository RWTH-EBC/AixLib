within PhysicalCompressors.BaseClasses;
model CompressionProcess
  Modelica.Fluid.Interfaces.FluidPort_a port_a annotation (Placement(
        transformation(extent={{-116,-16},{-84,14}}), iconTransformation(extent=
           {{-108,-10},{-88,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b annotation (Placement(
        transformation(extent={{82,-18},{116,16}}), iconTransformation(extent={{
            88,-12},{114,12}})));
  Modelica.Blocks.Interfaces.RealInput v1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-20,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-40,80})));
  Modelica.Blocks.Interfaces.RealInput v2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={20,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,80})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-40,42},{40,-38}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,32},{40,-28}},
          lineColor={0,0,0},
          fillColor={182,182,182},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-6,10},{6,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,50},{2,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));

end CompressionProcess;
