within AixLib.Controls.Interfaces;
model BasicControllerShell
  "Base model for controller with bus connectors"

  Modelica.Icons.SignalBus ExternalBus "Bus to higher level"
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  Modelica.Icons.SignalBus InternalBus "Bus to physical level"
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,50},{76,-8}},
          lineColor={0,0,0},
          fillColor={134,176,68},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-72,38},{62,8}},
          lineColor={54,86,37},
          fillColor={0,216,108},
          fillPattern=FillPattern.Solid,
          textString="Controller"),
        Rectangle(
          extent={{-10,11},{10,-11}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={1,-64},
          rotation=270),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={2,-63},
          rotation=180),
        Rectangle(
          extent={{22,-38},{42,-58}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={32,-47},
          rotation=270),
        Rectangle(
          extent={{-10,10},{10,-10}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={-30,-48},
          rotation=180),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={-30,-49},
          rotation=90),
        Rectangle(
          extent={{-10,11},{10,-11}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={1,-32},
          rotation=90),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={0,-33},
          rotation=360)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BasicControllerShell;
