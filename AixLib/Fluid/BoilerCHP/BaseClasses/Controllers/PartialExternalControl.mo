within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
partial model PartialExternalControl
  "With measurement of primary and secondary energy consumption"

  Modelica.Blocks.Interfaces.RealInput TOutside(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Outside temperature [K]"
    annotation (Placement(transformation(
        extent={{-13.5,-13.5},{13.5,13.5}},
        rotation=0,
        origin={-100,-39}), iconTransformation(extent={{-10.75,-10.5},{10.75,10.5}},
          origin={-97.25,-36})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    "On/Off switch for the boiler"
    annotation (Placement(transformation(extent={{-115.5,6},{-90,31.5}}),
        iconTransformation(extent={{-108,13.5},{-90,31.5}})));
  Modelica.Blocks.Interfaces.BooleanInput switchToNightMode
    "Connector of boolean input signal"
    annotation (Placement(transformation(extent={{-13.75,-13.75},{13.75,13.75}},
        rotation=0,
        origin={-101.75,49.75}), iconTransformation(
        extent={{-8.25,-8.5},{8.25,8.5}},
        rotation=0,
        origin={-99.5,56.25})));
  Modelica.Blocks.Interfaces.BooleanOutput isOn_final
    "On/Off output"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-15,-99}), iconTransformation(extent={{92,8},{112,28}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput TFlowSet(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Target temperature of the controller"
    annotation (Placement(
        transformation(extent={{92,38},{112,58}}), iconTransformation(extent={{
            92,38},{112,58}})));
  Modelica.Blocks.Interfaces.RealInput TFlowIs(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Actual outgoing temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={75,-100.5}), iconTransformation(
        extent={{11.5,-11.5},{-11.5,11.5}},
        rotation=-90,
        origin={65,-92})));

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
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This is a controller model, modelled after the <a href=
  \"DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10\">
  Vitotronic 200</a>.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following control decisions are implemented:
</p>
<ul>
  <li>Switch on/off when the fluid temperature is under/over the set
  fluid temperature
  </li>
  <li>Heating curve: fluid temperature depending on the outside
  temperature
  </li>
  <li>Average outside temperature
  </li>
  <li>Increase the set fluid temperature when going to day mode in
  order to shorten the heating up period
  </li>
</ul>
</html>",
revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Pooyan Jahangiri:<br/>
    Merged with AixLib
  </li>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>October 12, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"));
end PartialExternalControl;
