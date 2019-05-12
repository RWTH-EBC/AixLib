within AixLib.PlugNHarvest.Components.Controls;
model Heater "Controller heat generation"
  extends PlugNHarvest.Components.Controls.BaseClasses.PartialExternalControl;
  parameter Modelica.SIunits.Temperature Toutside_Threshold=16 + 273.15 "Heating limit";
    parameter Modelica.SIunits.Temperature Tset=19 + 273.15 "Threshold of the room temperature";

  Modelica.Blocks.Logical.And Checker
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Logical.LessThreshold    cooling(threshold=Toutside_Threshold)
    annotation (Placement(transformation(extent={{-52,-38},{-32,-18}})));
  Modelica.Blocks.Sources.Constant const_setpoint(k=Tset)
    annotation (Placement(transformation(extent={{26,26},{46,46}})));
equation

  connect(cooling.y, Checker.u2) annotation (Line(points={{-31,-28},{-28,-28},{-28,
          -10},{-12,-10}}, color={255,0,255}));
  connect(isOn, Checker.u1) annotation (Line(points={{-99.75,83.25},{-76,83.25},
          {-76,-2},{-12,-2},{-12,-2}}, color={255,0,255}));
  connect(Toutside, cooling.u) annotation (Line(points={{-100,-7.5},{-76,-7.5},{
          -76,-28},{-54,-28}}, color={0,0,127}));
  connect(const_setpoint.y, ControlBus.setT_room) annotation (Line(points={{47,36},
          {99.8213,36},{99.8213,22.5675}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Checker.y, ControlBus.isOn) annotation (Line(points={{11,-2},{99.8213,
          -2},{99.8213,22.5675}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid), Text(
          extent={{64,102},{-78,60}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.None,
          fontSize=72,
          textString="Heater"),
        Rectangle(
          extent={{-100,64},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{98,98},{-98,-52}},
          lineColor={28,108,200},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{74,102},{30,84}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          fontSize=18,
          textString="Controller")}),
    Documentation(revisions="<html>
<ul>
<li><i>November 26, 2017&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>", info="<html>
<p>Theperameter for set temperature is set only if the outside temperature goes under a temperature threshhold.</p>
<p>The switch to night mode input is present, but not used.</p>
</html>"));
end Heater;
