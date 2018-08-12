within AixLib.Fluid.HeatPumps.BaseClasses;
model PortTToRealT
  "Converts port temperature to real parameter temperature"
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                        port annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput T(unit="K") annotation (Placement(
        transformation(extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Sources.RealExpression T_internal(y=port.T)
    "Don't understand why this is necessary" annotation (Placement(
        transformation(
        extent={{22,-10},{-22,10}},
        rotation=0,
        origin={-42,0})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={159,159,223},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{0,0},{-100,-100}},
          lineColor={0,0,0},
          textString="K"),
        Line(
          points={{-72,0},{94,0}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{-62,-20},{-62,20},{-100,0},{-62,-20}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-64,136},{64,72}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={159,159,223},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{0,0},{-100,-100}},
          lineColor={0,0,0},
          textString="K"),
        Line(
          points={{-72,0},{94,0}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{-62,-20},{-62,20},{-100,0},{-62,-20}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}));
equation
  port.T = T;
  connect(T_internal.y, T)
    annotation (Line(points={{-66.2,0},{-120,0}}, color={0,0,127}));
end PortTToRealT;
