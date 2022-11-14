within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model InternalControl "Internal control model for boiler"

  parameter AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
    paramBoiler
    "Parameters for boiler"
    annotation (Dialog(tab = "General", group = "Boiler type"),
    choicesAllMatching = true);
  parameter Real KR
    "Gain of boiler heater";
  parameter Modelica.Units.SI.Time TN
    "Time constant of boiler heater (T>0 required)";
  parameter Modelica.Units.SI.Time riseTime
    "Rise/fall time for step input(T>0 required)";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));
  Real outputPower
    "Output power";
  Modelica.Blocks.Interfaces.BooleanInput isOn
    "On/Off switch for the boiler"
    annotation (Placement(transformation(extent={{-112.5,27},{-87,52.5}}),
        iconTransformation(
        extent={{-12.75,-12.75},{12.75,12.75}},
        rotation=-90,
        origin={-24.75,102.75})));
  Modelica.Blocks.Interfaces.RealInput Tflow_set(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Target temperature of the controller"
    annotation (Placement(
        transformation(
        extent={{-15.25,-15.25},{15.25,15.25}},
        rotation=0,
        origin={-100.75,81.25}), iconTransformation(
        extent={{-12.875,-12.875},{12.875,12.875}},
        rotation=-90,
        origin={20.375,101.125})));
  Modelica.Blocks.Interfaces.RealInput TFlowHot(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Outgoing temperature"
    annotation (Placement(transformation(extent={{-126.5,-20},{-86.5,20}}),
        iconTransformation(extent={{113,3},{87,29}})));
  Modelica.Blocks.Interfaces.RealOutput QflowHeater(
    final unit="W")
    "Connector of real output signal"
    annotation (Placement(transformation(extent={{66.5,18.5},{86.5,38.5}}),
        iconTransformation(extent={{-90.5,29},{-110.5,49}})));
  Modelica.Blocks.Interfaces.RealInput mFlow(
    quantity="MassFlowRate",
    final unit="kg/s")
    "Mass flow through the boiler"
    annotation (Placement(transformation(extent={{-125,-84.5},{-85,-44.5}}),
        iconTransformation(extent={{114.5,-63},{87,-35.5}})));
  Modelica.Blocks.Interfaces.RealInput TFlowCold(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Temperature of the cold water"
    annotation (Placement(transformation(
          extent={{-125,-51.5},{-85,-11.5}}), iconTransformation(extent={{114.5,
            -30},{87,-2.5}})));
  Controls.Continuous.PITemp  ControlerHeater(
    final KR=KR,
    final TN=TN,
    final h=paramBoiler.Q_nom,
    final l=paramBoiler.Q_min,
    triggeredTrapezoid(final rising=riseTime, final falling=riseTime),
    final rangeSwitch=false)
    "PI temperature controller"
    annotation (Placement(transformation(extent={{-40.5,36},{-24,52.5}})));
  Utilities.Sensors.EnergyMeter eEnergyMeter_P(final energyDynamics=
        energyDynamics)
    "For primary energy consumption"
    annotation (Placement(transformation(extent={{30,63},{49.5,84}})));
  Utilities.Sensors.EnergyMeter eEnergyMeter_S(final energyDynamics=
        energyDynamics)
    "For secondary energy consumption"
    annotation (Placement(transformation(extent={{30,82.5},{49.5,103.5}})));
  Modelica.Blocks.Tables.CombiTable1Dv efficiencyTable(
    final tableOnFile=false,
    final table=paramBoiler.eta,
    final columns={2},
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "Table with efficiency parameters"
    annotation (Placement(transformation(extent={{4.5,4.5},{15,15}})));
  Modelica.Blocks.Math.Gain QNormated(
    final k=1/paramBoiler.Q_nom)
    annotation (Placement(transformation(extent={{-13.5,6},{-4.5,15}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{21,24},{30,33}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    "Converts Tflow_hot real input to temperature"
    annotation (Placement(transformation(extent={{-69,-7.5},{-54,7.5}})));


equation

  if cardinality(isOn) < 2 then
    isOn = true;
  end if;

  outputPower =mFlow*4184*(TFlowHot - TFlowCold);
  eEnergyMeter_S.p=outputPower;

  connect(ControlerHeater.y, eEnergyMeter_P.p)
                                    annotation (Line(
      points={{-24.825,44.25},{4.5,44.25},{4.5,73.5},{30.65,73.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControlerHeater.y, QNormated.u) annotation (Line(
      points={{-24.825,44.25},{-18,44.25},{-18,10.5},{-14.4,10.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QNormated.y,efficiencyTable. u[1]) annotation (Line(
      points={{-4.05,10.5},{-0.3,10.5},{-0.3,9.75},{3.45,9.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControlerHeater.y, product.u1) annotation (Line(
      points={{-24.825,44.25},{4.5,44.25},{4.5,31.5},{12,31.5},{20.1,31.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(efficiencyTable.y[1], product.u2) annotation (Line(
      points={{15.525,9.75},{19.5,9.75},{19.5,25.8},{20.1,25.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, QflowHeater) annotation (Line(
      points={{30.45,28.5},{76.5,28.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControlerHeater.setPoint, Tflow_set) annotation (Line(points={{-38.85,
          51.675},{-38.85,81.25},{-100.75,81.25}}, color={0,0,127}));
  connect(ControlerHeater.onOff, isOn) annotation (Line(points={{-39.675,40.125},
          {-66.3375,40.125},{-66.3375,39.75},{-99.75,39.75}}, color={255,0,255}));
  connect(TFlowHot, prescribedTemperature.T) annotation (Line(points={{-106.5,0},
          {-88.5,0},{-70.5,0}}, color={0,0,127}));
  connect(prescribedTemperature.port, ControlerHeater.heatPort) annotation (
      Line(points={{-54,0},{-37.2,0},{-37.2,36.825}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5})),           Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5}), graphics={Rectangle(
          extent={{-82.5,87},{88.5,-73.5}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-79.5,27},{87,-3}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Internal control of the boiler
</p>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  This model is a derivation of BoilerTaktTable.
</p>
<p>
  There is a differentiation made between primary and secondary energy
  consumption.
</p>
<p>
  The primary power output can be read at the output of
  <b>ControlerHeater.</b> It is then multiplied with an efficienca
  factor to calculate the the effective heat flow that heats up the
  fluid in the boiler<b>.</b>
</p>
<p>
  There are two energy meters: one for the primary energy and one for
  the secondary.
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>May 5, 2021</i> by Fabian Wüllhorst:<br/>
    Add energyDynamics as parameter (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1093\">#1093</a>)
  </li>
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
    <i>July 12, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"));
end InternalControl;
