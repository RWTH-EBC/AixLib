within AixLib.Fluid.BoilerCHP;
model CHPNotManufacturer
   extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    redeclare package Medium = Media.Water,
              vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(
          0.8265*switch2.y/1000 + 7.8516)/1000), a=0);

parameter Modelica.Units.SI.Power NomPower=100000;
parameter Boolean ElDriven=true;
constant Real Brennwert=46753;
//parameter Real deltaTWater;
// parameter Real deltaTCoolingWater;

 parameter Real PLRMin=0.5;

//Real HeatEngine;


  Modelica.Blocks.Sources.RealExpression nomPower(y=NomPower) "Nominal Power"
    annotation (Placement(transformation(extent={{-264,34},{-224,56}})));
  SDF.NDTable pTHR(
    nin=2,
    readFromFile=true,
    filename=Filename_PTHR,
    dataset="/PTHR",
    dataUnit="[-]",
    scaleUnits={"W","-"}) "Power to Heat Ratio"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-56,38},{-42,52}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{36,34},{50,48}})));
  Modelica.Blocks.Interfaces.RealOutput Pel "Electrical power"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=
        500*(20.207*switch2.y/1000 + 634.19),
                                      T(start=T_start)) "Engine dry weight"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-2,-54})));
  Modelica.Blocks.Sources.RealExpression internalDemand(y=0.9819)
    "Percentage of usable electrical power"
    annotation (Placement(transformation(extent={{20,86},{40,106}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{48,82},{60,94}})));

  Modelica.Blocks.Routing.Multiplex2 multiplex2_2
    annotation (Placement(transformation(extent={{-52,96},{-36,80}})));
  Modelica.Blocks.Interfaces.RealInput PLR
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-88,84},{-76,96}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        PLRMin)
    annotation (Placement(transformation(extent={{18,14},{30,26}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={62,-4})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) "Real"
    annotation (Placement(transformation(extent={{74,18},{94,38}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={86,80})));
  Modelica.Blocks.Interfaces.RealOutput powerDemand "Power Demand"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(final G=
        switch2.y/(2.7088*log(switch2.y) + 23.074)/100*0.0568/(85 - 20))
                 "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-40,-32})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{30,-38},{18,-26}})));
  SDF.NDTable etaEl(
    nin=2,
    readFromFile=true,
    filename=Filename_EtaEL,
    dataset="/EtaEL",
    dataUnit="-",
    scaleUnits={"W","-"}) "Electric Efficiency"
    annotation (Placement(transformation(extent={{-20,-12},{0,8}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-16,-26},{-4,-38}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{62,-48},{78,-32}})));
  Modelica.Blocks.Interfaces.RealOutput THotEngine "THot Engine" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));


parameter String Filename_PowerEl_heat="modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/PowerEL_heat.sdf";
parameter String Filename_PTHR="modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/Stromkennzahl.sdf";
parameter String Filename_EtaEL="modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/EtaEL.sdf";


  Modelica.Blocks.Interfaces.RealOutput maxThermalPower "maximal thermal Power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-114,142})));
  BaseClasses.Controllers.CHPNomBehaviour cHPNomBehaviour(
    NomPower=NomPower,
    ElDriven=ElDriven,                                                   PLRMin=
       PLRMin)
    annotation (Placement(transformation(extent={{-188,132},{-168,152}})));
  Modelica.Blocks.Interfaces.RealOutput minThermalPower "minimal thermal Power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,142})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=0,
        origin={-141,31})));
  SDF.NDTable electricNomPower(
    nin=1,
    readFromFile=true,
    filename=Filename_PowerEl_heat,
    dataset="/Power_el",
    dataUnit="W",
    scaleUnits={"W"})     "Electric nominal power"
    annotation (Placement(transformation(extent={{-202,-4},{-182,16}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=ElDriven)
    annotation (Placement(transformation(extent={{-268,6},{-248,26}})));
equation

THotEngine=vol.T;
  connect(pTHR.y, division.u2) annotation (Line(points={{1,90},{8,90},{8,36.8},{
          34.6,36.8}}, color={0,0,127}));
  connect(internalDemand.y, product1.u1) annotation (Line(points={{41,96},{46.8,
          96},{46.8,91.6}},       color={0,0,127}));
  connect(product.y, product1.u2) annotation (Line(points={{-41.3,45},{28,45},{
          28,84.4},{46.8,84.4}},
                              color={0,0,127}));
  connect(multiplex2_2.y, pTHR.u) annotation (Line(points={{-35.2,88},{-28,88},{
          -28,90},{-22,90}}, color={0,0,127}));
  connect(division.y, switch3.u3) annotation (Line(points={{50.7,41},{54,41},{
          54,8}},             color={0,0,127}));
  connect(switch3.y, heater.Q_flow) annotation (Line(points={{62,-15},{62,-22},
          {-60,-22},{-60,-40}}, color={0,0,127}));
  connect(PLR, limiter.u)
    annotation (Line(points={{-120,90},{-89.2,90}},          color={0,0,127}));
  connect(limiter.y, multiplex2_2.u2[1])
    annotation (Line(points={{-75.4,90},{-58,90},{-58,92.8},{-53.6,92.8}},
                                                             color={0,0,127}));
  connect(lessEqualThreshold.y, switch3.u2) annotation (Line(points={{30.6,20},
          {62,20},{62,8}},                color={255,0,255}));
  connect(zero.y, switch3.u1) annotation (Line(points={{95,28},{100,28},{100,20},
          {70,20},{70,8}}, color={0,0,127}));
  connect(zero.y, switch1.u1) annotation (Line(points={{95,28},{100,28},{100,40},
          {66,40},{66,72},{74,72}}, color={0,0,127}));
  connect(product1.y, switch1.u3) annotation (Line(points={{60.6,88},{74,88}},
                                        color={0,0,127}));
  connect(switch1.y, Pel) annotation (Line(points={{97,80},{110,80}},
                            color={0,0,127}));
  connect(vol.heatPort, internalCapacity.port)
    annotation (Line(points={{-50,-70},{-50,-54},{-12,-54}}, color={191,0,0}));
  connect(vol.heatPort, ConductanceToEnv.port_a)
    annotation (Line(points={{-50,-70},{-50,-32},{-46,-32}}, color={191,0,0}));
  connect(multiplex2_2.y, etaEl.u) annotation (Line(points={{-35.2,88},{-28,88},
          {-28,-2},{-22,-2}}, color={0,0,127}));
  connect(port_b, port_b) annotation (Line(points={{100,0},{93,0},{93,0},{100,0}},
        color={0,127,255}));
  connect(PLR, lessEqualThreshold.u) annotation (Line(points={{-120,90},{-94,90},
          {-94,24},{8,24},{8,20},{16.8,20}},
                               color={0,0,127}));
  connect(lessEqualThreshold.y, switch1.u2) annotation (Line(points={{30.6,20},
          {62,20},{62,80},{74,80}},   color={255,0,255}));
  connect(ConductanceToEnv.port_b, heatFlowSensor.port_a)
    annotation (Line(points={{-34,-32},{-16,-32}}, color={191,0,0}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{-4,-32},{18,-32}}, color={191,0,0}));
  connect(etaEl.y, division1.u2) annotation (Line(points={{1,-2},{36,-2},{36,-44.8},
          {60.4,-44.8}}, color={0,0,127}));
  connect(division1.y,powerDemand)
    annotation (Line(points={{78.8,-40},{110,-40}}, color={0,0,127}));
  connect(product.y, division1.u1) annotation (Line(points={{-41.3,45},{-34,45},
          {-34,-18},{44,-18},{44,-35.2},{60.4,-35.2}}, color={0,0,127}));
  connect(product.y, division.u1) annotation (Line(points={{-41.3,45},{34,45},{
          34,46},{34.6,46},{34.6,45.2}}, color={0,0,127}));
  connect(cHPNomBehaviour.MinThermalPower, minThermalPower) annotation (Line(
        points={{-167,143.6},{-152,143.6},{-152,122},{-76,122},{-76,142}},
                                                                         color={
          0,0,127}));
  connect(cHPNomBehaviour.MaxThermalPower, maxThermalPower) annotation (Line(
        points={{-167,135},{-140,135},{-140,124},{-114,124},{-114,142}},
                                                                     color={0,0,
          127}));
  connect(PLR, product.u1) annotation (Line(points={{-120,90},{-94,90},{-94,49.2},
          {-57.4,49.2}}, color={0,0,127}));
  connect(switch2.y, product.u2) annotation (Line(points={{-128.9,31},{-114,31},
          {-114,40.8},{-57.4,40.8}}, color={0,0,127}));
  connect(nomPower.y, switch2.u1) annotation (Line(points={{-222,45},{-180,45},{
          -180,40},{-168,40},{-168,39.8},{-154.2,39.8}},
                                     color={0,0,127}));
  connect(electricNomPower.y, switch2.u3) annotation (Line(points={{-181,6},{-168,
          6},{-168,22.2},{-154.2,22.2}},                      color={0,0,127}));
  connect(switch2.y, multiplex2_2.u1[1]) annotation (Line(points={{-128.9,31},{-70,
          31},{-70,83.2},{-53.6,83.2}},  color={0,0,127}));
  connect(nomPower.y, electricNomPower.u[1]) annotation (Line(points={{-222,45},
          {-206,45},{-206,34},{-302,34},{-302,6},{-204,6}}, color={0,0,127}));
  connect(booleanExpression.y, switch2.u2) annotation (Line(points={{-247,16},{-226,
          16},{-226,31},{-154.2,31}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Model of a CHP which is based on
  AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator. The model
  describes an adiabtaic heatflow which is brought to the volume.
</p>
<p>
  The adiabsatic heat flow is calculated with the adiabatic power to
  heat ratio which is based on table data for different relative
  electric power:
</p>
<p>
  <img src=
  \"modelica://AixLib/../../../Diagramme%20AixLib/BHKW/Stromkennzahl.png\">
</p>
</html>"));
end CHPNotManufacturer;
