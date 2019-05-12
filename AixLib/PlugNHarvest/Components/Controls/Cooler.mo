within AixLib.PlugNHarvest.Components.Controls;
model Cooler "Controller cooling generation "
  extends PlugNHarvest.Components.Controls.BaseClasses.PartialExternalControl;

    parameter Modelica.SIunits.Temperature T_room_Threshold=23 + 273.15 "Threshold of the room temperature";

  Modelica.Blocks.Sources.Constant const_setpoint(k=T_room_Threshold)
    annotation (Placement(transformation(extent={{26,26},{46,46}})));
equation

  connect(const_setpoint.y, ControlBus.setT_room) annotation (Line(points={{47,36},
          {99.8213,36},{99.8213,22.5675}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(isOn, ControlBus.isOn) annotation (Line(points={{-99.75,83.25},{-60,
          83.25},{-60,-10},{99.8213,-10},{99.8213,22.5675}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid), Text(
          extent={{30,102},{-36,62}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.None,
          fontSize=72,
          textString="Chiller"),
        Rectangle(
          extent={{-100,64},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={85,170,255},
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
<p>Sets a set temperatuzre. The temperature is given as a parameter.</p>
<p>The inputs for switching to night mode and for outside temperature are there but not used in this version of the control. </p>
</html>"));
end Cooler;
