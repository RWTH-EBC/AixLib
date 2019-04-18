within AixLib.PlugNHarvest.Components.Controls.BaseClasses;
partial model PartialExternalControl "With inputs and control bus"

  Modelica.Blocks.Interfaces.RealInput Toutside(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Outside temperature [K]"
    annotation (Placement(transformation(
        extent={{-13.5,-13.5},{13.5,13.5}},
        rotation=0,
        origin={-100,-7.5}),iconTransformation(extent={{-10.75,-10.5},{10.75,10.5}},
          origin={-97.25,-4.5})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    "On/Off switch for the boiler"
    annotation (Placement(transformation(extent={{-112.5,70.5},{-87,96}}),
        iconTransformation(extent={{-105,78},{-87,96}})));
  Modelica.Blocks.Interfaces.BooleanInput switchToNightMode
    "Connector of boolean input signal"
    annotation (Placement(transformation(extent={{-13.75,-13.75},{13.75,13.75}},
        rotation=0,
        origin={-100.25,37.75}), iconTransformation(
        extent={{-8.25,-8.5},{8.25,8.5}},
        rotation=0,
        origin={-99.5,56.25})));

  Bus.GenEnegGenControlBus ControlBus "control bus for a heater"
    annotation (Placement(transformation(extent={{85.5,9},{114,36}})));
equation
  if cardinality(isOn) < 2 then
    isOn = true;
  end if;

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5})),           Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5}), graphics={
                            Rectangle(
          extent={{-84,85.5},{91.5,-82.5}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}),
        Text(
          extent={{-79.5,19.5},{82.5,-4.5}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(info="<html>
</html>",
revisions="<html>
<ul>
<li><i>November 26, 2017</i> by Ana Constantin:<br/>Implemented</li>
</ul>
</html>"));
end PartialExternalControl;
