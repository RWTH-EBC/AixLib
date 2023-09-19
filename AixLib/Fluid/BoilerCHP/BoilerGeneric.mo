within AixLib.Fluid.BoilerCHP;
model BoilerGeneric "Generic performance map based boiler"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    T_start=TRetDes +dTDes,
    redeclare final package Medium = AixLib.Media.Water,
    a=coeffPresLoss,
    vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(1.1615*QDes
              /1000)/1000),
    final m_flow_nominal=QDes/(Medium.cp_const*dTDes),
    final dp_nominal= m_flow_nominal^2*a/(Medium.d_const^2));

  parameter Modelica.Units.SI.TemperatureDifference dTDes=20
    "Design temperature difference of supply and return"
    annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.Temperature TRetDes=273.15 + 60
    "Nominal return temperature" annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.HeatFlowRate QDes=50000 "Design thermal capacity"
    annotation (Dialog(group="Design"));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=C,
      T(start=T_start))            "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-18,-50})));
  BaseClasses.Controllers.OffDesignOperation offDesignOperation(
    DelTDes=dTDes,
    TRetDes=TRetDes,
    QDes=QDes) "off design operation"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conductanceToEnv(
      final G=QDes*0.003/50) "Thermal resistance of the boiler casing"
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-38,-34})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 293.15) "Temperature of environment around the boiler to account for heat losses"
    annotation (Placement(transformation(extent={{14,-40},{2,-28}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-26,-28},{-14,-40}})));
  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-38,90},{-18,110}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-50,-26},{-30,-6}})));
  BaseClasses.Controllers.DesignOperation designOperation(
    DelTDes=dTDes,
    TRetDes=TRetDes,
    QDes=QDes) "designOperation for design fuel power"
    annotation (Placement(transformation(extent={{-56,24},{-36,44}})));
  Modelica.Blocks.Math.Product powerDemand "Set power demand"
    annotation (Placement(transformation(extent={{-2,30},{18,50}})));
  Modelica.Blocks.Math.Product thermalPower "Thermal power during operation"
    annotation (Placement(transformation(extent={{34,24},{54,44}})));
protected
  parameter Real coeffPresLoss=7.143*10^8*exp(-0.007078*QDes/1000)
    "Pressure loss coefficient of the heat generator";
  parameter Modelica.Units.SI.HeatCapacity C=1.5*QDes
    "Heat capacity of metal (J/K)";

equation

  connect(vol.heatPort, internalCapacity.port) annotation (Line(points={{-50,-70},
          {-50,-50},{-28,-50}},           color={191,0,0}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{-14,-34},{2,-34}}, color={191,0,0}));
  connect(conductanceToEnv.port_b, heatFlowSensor.port_a)
    annotation (Line(points={{-32,-34},{-26,-34}}, color={191,0,0}));
  connect(conductanceToEnv.port_a, vol.heatPort)
    annotation (Line(points={{-44,-34},{-50,-34},{-50,-70}}, color={191,0,0}));
  connect(vol.heatPort, temperatureSensor.port)
    annotation (Line(points={{-50,-70},{-50,-16}}, color={191,0,0}));
  connect(temperatureSensor.T, boilerControlBus.TSupplyMea) annotation (Line(
        points={{-29,-16},{-28,-16},{-28,100}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(designOperation.designPowerDemand, powerDemand.u2)
    annotation (Line(points={{-35,34},{-4,34}}, color={0,0,127}));
  connect(powerDemand.y, thermalPower.u1)
    annotation (Line(points={{19,40},{32,40}}, color={0,0,127}));
  connect(boilerControlBus.Efficiency, thermalPower.u2) annotation (Line(
      points={{-28,100},{-28,28},{32,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalPower.y, heater.Q_flow) annotation (Line(points={{55,34},{60,34},
          {60,0},{-60,0},{-60,-40}},       color={0,0,127}));
  connect(offDesignOperation.boilerControlBus, boilerControlBus) annotation (
      Line(
      points={{30.2,80},{30.2,86},{-28,86},{-28,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(powerDemand.y, boilerControlBus.PowerDemand) annotation (Line(points={
          {19,40},{24,40},{24,56},{-28,56},{-28,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.FirRatSet, powerDemand.u1) annotation (Line(
      points={{-28,100},{-28,46},{-4,46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalPower.y, boilerControlBus.ThermalPower) annotation (Line(
        points={{55,34},{60,34},{60,100},{-28,100}},                 color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senTCold.T, boilerControlBus.TColdMea) annotation (Line(points={{-70,-69},
          {-70,100},{-28,100}},             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senMasFlo.m_flow, boilerControlBus.m_flowMea) annotation (Line(points
        ={{70,-69},{70,100},{-28,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>A boiler model consisting of physical components. The efficiency is presented via a performance map in dependency on:</p>
<ul>
<li><span style=\"font-family: Arial;\">Return temperature</span></li>
<li><span style=\"font-family: Arial;\">Nominale temperature difference</span></li>
<li><span style=\"font-family: Arial;\">Relative water mass flow</span></li>
<li><span style=\"font-family: Arial;\">Realtive temperature difference</span></li>
</ul>
<p>The model differs between <u>design</u> operating <u>off-design</u> operating.</p>
<p>For design conditions (parametrization) the model estimates max. fuel consumption [W]. The <u>off-design</u> fuel consumption [W] is estimated via FirRatSet [-]. </p>
<p>During operation, the transferred heat flow [W] is estimated with respect to actual efficiency within a performance map.</p>
<p>The quadratic coefficient <span style=\"font-family: Courier New;\">coeffPresLoss </span>bases on a fit-function of manufacturer data.</p>
<p>The volume <span style=\"font-family: Courier New;\">vol.V</span> bases on a fit-function of manufacturer data.</p>
<p><br>Further assumptions are taken into account for losses (see AixLib.Fluid.BoilerCHP.BoilerNoControl):</p>
<ul>
<li>G: a heat loss of 0.3 &percnt; of nominal power at a temperature difference of 50 K to ambient is assumed.</li>
<li>C: factor C/Q_nom is in range of 1.2 to 2 for boilers with nominal power between 460 kW and 80 kW (with c of 500J/kgK for steel). Thus, a value of 1.5 is used as default.</li>
</ul>
</html>",
        revisions="<html>
<ul>
<li><i>June, 2023&nbsp;</i> by Moritz Zuschlag &amp; David Jansen</li>
</ul>
</html>"));
end BoilerGeneric;
