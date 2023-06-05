within AixLib.Fluid.BoilerCHP;
model BoilerNotManufacturer "Simple heat generator without control"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    redeclare package Medium = AixLib.Media.Water,
        a=coeffPresLoss, vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(
          1.1615*Q_nom/1000)/1000));

/*Parameters*/
  parameter Modelica.Units.SI.TemperatureDifference dT_w_nom=15 "Nominal temperature difference of flow and return";
  parameter Modelica.Units.SI.Temperature T_cold_nom=273.15 + 35 "Nominal Return Temperature";
  parameter Modelica.Units.SI.HeatFlowRate Q_nom=50000 "Nominal heat flow rate";


  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=C,
      T(start=T_start))            "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-18,-50})));
  BaseClasses.Controllers.OperatingEfficiency operatingEfficiency(
    T_cold_nom=T_cold_nom,
    Q_nom=Q_nom,
    dT_w_nom=dT_w_nom) "Model for calculating operating efficiency"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(final G=
        Q_nom*0.003/50)
                 "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-38,-34})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 283.15) "Temperature of environment around the boiler to account for heat losses"
    annotation (Placement(transformation(extent={{14,-40},{2,-28}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-26,-28},{-14,-40}})));
  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-38,86},{-18,106}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-50,-26},{-30,-6}})));
  BaseClasses.Controllers.NominalPowerDemand nominalPowerDemand(
    T_cold_nom=T_cold_nom,                                        Q_nom=Q_nom,
      dT_w_nom=dT_w_nom) "Model for calculating nominal power demand"
    annotation (Placement(transformation(extent={{-60,32},{-40,52}})));
  Modelica.Blocks.Math.Product powerDemand
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Math.Product thermalPower
    annotation (Placement(transformation(extent={{58,24},{78,44}})));
protected
    parameter Real coeffPresLoss=7.143*10^8*exp(-0.007078*Q_nom/1000)
    "Pressure loss coefficient of the heat generator";
  parameter Modelica.Units.SI.HeatCapacity C=1.5*Q_nom
    "Heat capacity of metal (J/K)";

equation


  connect(vol.heatPort, internalCapacity.port) annotation (Line(points={{-50,-70},
          {-50,-50},{-28,-50}},           color={191,0,0}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{-14,-34},{2,-34}}, color={191,0,0}));
  connect(ConductanceToEnv.port_b, heatFlowSensor.port_a)
    annotation (Line(points={{-32,-34},{-26,-34}}, color={191,0,0}));
  connect(ConductanceToEnv.port_a, vol.heatPort)
    annotation (Line(points={{-44,-34},{-50,-34},{-50,-70}}, color={191,0,0}));
  connect(vol.heatPort, temperatureSensor.port)
    annotation (Line(points={{-50,-70},{-50,-16}}, color={191,0,0}));
  connect(temperatureSensor.T, boilerControlBus.TSupplyMea) annotation (Line(
        points={{-29,-16},{-28,-16},{-28,40},{-27.95,40},{-27.95,96.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(nominalPowerDemand.nominalPowerDemand, powerDemand.u2) annotation (
      Line(points={{-39,35},{-39,34},{18,34}},          color={0,0,127}));
  connect(powerDemand.y, thermalPower.u1)
    annotation (Line(points={{41,40},{56,40}}, color={0,0,127}));
  connect(boilerControlBus.Efficiency, thermalPower.u2) annotation (Line(
      points={{-27.95,96.05},{-27.95,28},{56,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalPower.y, heater.Q_flow) annotation (Line(points={{79,34},{90,
          34},{90,12},{-60,12},{-60,-40}}, color={0,0,127}));
  connect(operatingEfficiency.boilerControlBus, boilerControlBus) annotation (
      Line(
      points={{30.2,80},{30.2,86},{-32,86},{-32,96},{-28,96}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(powerDemand.y, boilerControlBus.PowerDemand) annotation (Line(points=
          {{41,40},{50,40},{50,56},{-27.95,56},{-27.95,96.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.PRatioSet, powerDemand.u1) annotation (Line(
      points={{-27.95,96.05},{-27.95,46},{18,46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalPower.y, boilerControlBus.ThermalPower) annotation (Line(
        points={{79,34},{90,34},{90,96},{-27.95,96},{-27.95,96.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senTCold.T, boilerControlBus.TColdMea) annotation (Line(points={{-70,
          -69},{-70,96.05},{-27.95,96.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>A boiler model consisting of physical components.The efficiency is based on the part load rate and the inflow water temperature.</p>
<p><br>Assumptions for predefined parameter values (based on Vissmann data cheat) as given by BoilerNoControl:</p>
<p>G: a heat loss of 0.3 &percnt; of nominal power at a temperature difference of 50 K to ambient is assumed.</p>
<p>C: factor C/Q_nom is in range of 1.2 to 2 for boilers with nominal power between 460 kW and 80 kW (with c of 500J/kgK for steel). Thus, a value of 1.5 is used as default.</p>
<p><br>Further informations are described in the submodels &quot;Set&quot; and &quot;ReturnInfluence&quot;. </p>
</html>",
        revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>First
implementation</li>
</ul>
</html>"));
end BoilerNotManufacturer;
