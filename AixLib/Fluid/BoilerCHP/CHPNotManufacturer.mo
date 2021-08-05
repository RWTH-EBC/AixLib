within AixLib.Fluid.BoilerCHP;
model CHPNotManufacturer
   extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    redeclare package Medium = Media.Water,
              vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(
          0.8265*PelNom/1000 + 7.8516)/1000), a=0);

parameter Modelica.SIunits.Power PelNom=100000;
constant Real Brennwert=46753;
//parameter Real deltaTWater;
// parameter Real deltaTCoolingWater;

 parameter Real PLRMin=0.5;

//Real HeatEngine;


  Modelica.Blocks.Sources.RealExpression pelNom(y=PelNom)
    "Nominal electric Power"
    annotation (Placement(transformation(extent={{-90,30},{-74,50}})));
  SDF.NDTable SDF1(
    nin=2,
    readFromFile=true,
    filename=Filename_PTHR,
    dataset="/PTHR",
    dataUnit="[-]",
    scaleUnits={"W","-"})
      "Power to Heat Ratio"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-56,38},{-42,52}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{36,34},{50,48}})));
  Modelica.Blocks.Interfaces.RealOutput Pel "Electrical power"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=
        500*(20.207*PelNom/1000 + 634.19),
                                      T(start=T_start)) "Engine dry weight"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-2,-54})));
  Modelica.Blocks.Sources.RealExpression InternalDemand(y=0.9819)
    "Percentage of usable electrical power"
    annotation (Placement(transformation(extent={{20,86},{40,106}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{48,82},{60,94}})));

  Modelica.Blocks.Routing.Multiplex2 multiplex2_2
    annotation (Placement(transformation(extent={{-50,76},{-34,60}})));
  Modelica.Blocks.Interfaces.RealInput PLR
    annotation (Placement(transformation(extent={{-140,46},{-100,86}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-88,60},{-76,72}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        PLRMin)
    annotation (Placement(transformation(extent={{18,14},{30,26}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={62,-4})));
  Modelica.Blocks.Sources.RealExpression RealZero(y=0) "RealZero"
    annotation (Placement(transformation(extent={{74,18},{94,38}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={86,80})));
  Modelica.Blocks.Interfaces.RealOutput PowerDemand "Energy demand"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(final G=
        PelNom/(2.7088*log(PelNom) + 23.074)/100*0.0568/(85 - 20))
                 "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-40,-32})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{30,-38},{18,-26}})));
  SDF.NDTable SDF2(
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

  parameter String Filename_PTHR= "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/Stromkennzahl.sdf";
  parameter String Filename_EtaEL= "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/EtaEL.sdf";


equation

THotEngine=vol.T;
  connect(pelNom.y, product.u2) annotation (Line(points={{-73.2,40},{-57.4,40},
          {-57.4,40.8}},color={0,0,127}));
  connect(SDF1.y, division.u2) annotation (Line(points={{1,90},{8,90},{8,36.8},
          {34.6,36.8}}, color={0,0,127}));
  connect(InternalDemand.y, product1.u1) annotation (Line(points={{41,96},{46.8,
          96},{46.8,91.6}},       color={0,0,127}));
  connect(product.y, product1.u2) annotation (Line(points={{-41.3,45},{28,45},{
          28,84.4},{46.8,84.4}},
                              color={0,0,127}));
  connect(pelNom.y, multiplex2_2.u1[1]) annotation (Line(points={{-73.2,40},{
          -66,40},{-66,63.2},{-51.6,63.2}},
                                        color={0,0,127}));
  connect(multiplex2_2.y, SDF1.u) annotation (Line(points={{-33.2,68},{-28,68},
          {-28,90},{-22,90}}, color={0,0,127}));
  connect(division.y, switch3.u3) annotation (Line(points={{50.7,41},{54,41},{
          54,8}},             color={0,0,127}));
  connect(switch3.y, heater.Q_flow) annotation (Line(points={{62,-15},{62,-22},
          {-60,-22},{-60,-40}}, color={0,0,127}));
  connect(PLR, limiter.u)
    annotation (Line(points={{-120,66},{-89.2,66}},          color={0,0,127}));
  connect(limiter.y, multiplex2_2.u2[1])
    annotation (Line(points={{-75.4,66},{-58,66},{-58,72.8},{-51.6,72.8}},
                                                             color={0,0,127}));
  connect(limiter.y, product.u1) annotation (Line(points={{-75.4,66},{-70,66},{
          -70,49.2},{-57.4,49.2}}, color={0,0,127}));
  connect(lessEqualThreshold.y, switch3.u2) annotation (Line(points={{30.6,20},
          {62,20},{62,8}},                color={255,0,255}));
  connect(RealZero.y, switch3.u1) annotation (Line(points={{95,28},{100,28},{
          100,20},{70,20},{70,8}},        color={0,0,127}));
  connect(RealZero.y, switch1.u1) annotation (Line(points={{95,28},{100,28},{
          100,40},{66,40},{66,72},{74,72}},
                                      color={0,0,127}));
  connect(product1.y, switch1.u3) annotation (Line(points={{60.6,88},{74,88}},
                                        color={0,0,127}));
  connect(switch1.y, Pel) annotation (Line(points={{97,80},{110,80}},
                            color={0,0,127}));
  connect(vol.heatPort, internalCapacity.port)
    annotation (Line(points={{-50,-70},{-50,-54},{-12,-54}}, color={191,0,0}));
  connect(vol.heatPort, ConductanceToEnv.port_a)
    annotation (Line(points={{-50,-70},{-50,-32},{-46,-32}}, color={191,0,0}));
  connect(multiplex2_2.y, SDF2.u) annotation (Line(points={{-33.2,68},{-28,68},
          {-28,-2},{-22,-2}}, color={0,0,127}));
  connect(port_b, port_b) annotation (Line(points={{100,0},{93,0},{93,0},{100,0}},
        color={0,127,255}));
  connect(PLR, lessEqualThreshold.u) annotation (Line(points={{-120,66},{-94,66},
          {-94,20},{16.8,20}}, color={0,0,127}));
  connect(lessEqualThreshold.y, switch1.u2) annotation (Line(points={{30.6,20},
          {62,20},{62,80},{74,80}},   color={255,0,255}));
  connect(ConductanceToEnv.port_b, heatFlowSensor.port_a)
    annotation (Line(points={{-34,-32},{-16,-32}}, color={191,0,0}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{-4,-32},{18,-32}}, color={191,0,0}));
  connect(SDF2.y, division1.u2) annotation (Line(points={{1,-2},{36,-2},{36,-44.8},
          {60.4,-44.8}}, color={0,0,127}));
  connect(division1.y, PowerDemand)
    annotation (Line(points={{78.8,-40},{110,-40}}, color={0,0,127}));
  connect(product.y, division1.u1) annotation (Line(points={{-41.3,45},{-34,45},
          {-34,-18},{44,-18},{44,-35.2},{60.4,-35.2}}, color={0,0,127}));
  connect(product.y, division.u1) annotation (Line(points={{-41.3,45},{34,45},{
          34,46},{34.6,46},{34.6,45.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model of a CHP which is based on AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator. The model describes an adiabtaic heatflow which is brought to the volume. </p>
<p>The adiabsatic heat flow is calculated with the adiabatic power to heat ratio which is based on table data for different relative electric power:</p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/BHKW/Stromkennzahl.png\"/></p>
</html>"));
end CHPNotManufacturer;
