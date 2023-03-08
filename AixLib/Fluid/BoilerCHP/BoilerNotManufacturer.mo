within AixLib.Fluid.BoilerCHP;
model BoilerNotManufacturer "Simple heat generator without control"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    redeclare package Medium = Media.Water,
        a=coeffPresLoss, vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(1.1615*QNom/1000)/1000));

  parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=15 "Nominal temperature difference heat circuit";
  parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Setpoint temperature difference heat circuit";
  parameter Modelica.Units.SI.Temperature TColdNom=273.15+35 "Nominal TCold";
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Nominal thermal power";
  parameter Boolean m_flowVar=false "Boolean for use of variable water massflow";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";



  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=C,
      T(start=T_start))            "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-18,-50})));
  BaseClasses.Controllers.OperatingEfficiency operatingEfficiency(
    TColdNom=TColdNom,
    QNom=QNom,
    dTWaterNom=dTWaterNom)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(final G=
        QNom*0.003/50)
                 "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-38,-34})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 283.15)
    annotation (Placement(transformation(extent={{14,-40},{2,-28}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-26,-28},{-14,-40}})));
  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-38,86},{-18,106}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-50,-26},{-30,-6}})));
  BaseClasses.Controllers.NominalEfficiency nominalEfficiency(QNom=QNom,
      dTWaterNom=dTWaterNom)
    annotation (Placement(transformation(extent={{-64,44},{-44,64}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{58,-2},{78,18}})));
protected
    parameter Real coeffPresLoss=7.143*10^8*exp(-0.007078*QNom/1000)
    "Pressure loss coefficient of the heat generator";
  parameter Modelica.Units.SI.HeatCapacity C=1.5*QNom
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
  connect(senTCold.T, boilerControlBus.TReturnMea) annotation (Line(points={{-70,
          -69},{-70,96.05},{-27.95,96.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(vol.heatPort, temperatureSensor.port)
    annotation (Line(points={{-50,-70},{-50,-16}}, color={191,0,0}));
  connect(temperatureSensor.T, boilerControlBus.TSupplyMea) annotation (Line(
        points={{-29,-16},{-26,-16},{-26,-12},{-27.95,-12},{-27.95,96.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(nominalEfficiency.nominalPowerDemand, product1.u2) annotation (Line(
        points={{-43,47},{-10,47},{-10,34},{18,34}}, color={0,0,127}));
  connect(product1.y, product2.u1) annotation (Line(points={{41,40},{50,40},{50,
          14},{56,14}}, color={0,0,127}));
  connect(boilerControlBus.Efficiency, product2.u2) annotation (Line(
      points={{-27.95,96.05},{-27.95,2},{56,2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product2.y, heater.Q_flow) annotation (Line(points={{79,8},{82,8},{82,
          -14},{-60,-14},{-60,-40}}, color={0,0,127}));
  connect(nominalEfficiency.boilerControlBus, boilerControlBus) annotation (
      Line(
      points={{-54,64},{-54,86},{-32,86},{-32,96},{-28,96}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(operatingEfficiency.boilerControlBus, boilerControlBus) annotation (
      Line(
      points={{30.2,80},{30.2,86},{-32,86},{-32,96},{-28,96}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product1.y, boilerControlBus.PowerDemand) annotation (Line(points={{41,
          40},{50,40},{50,56},{-27.95,56},{-27.95,96.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.Qrel, product1.u1) annotation (Line(
      points={{-27.95,96.05},{-27.95,46},{18,46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product2.y, boilerControlBus.ThermalPower) annotation (Line(points={{
          79,8},{106,8},{106,18},{122,18},{122,96.05},{-27.95,96.05}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
