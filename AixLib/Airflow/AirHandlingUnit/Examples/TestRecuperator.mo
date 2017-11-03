within AixLib.Airflow.AirHandlingUnit.Examples;
model TestRecuperator "Example model to test the MenergaModular model"

    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  extends Modelica.Icons.Example;
  Fluid.Sources.Boundary_pT supplyAir(
    redeclare package Medium = MediumAir,
    X={0.02,0.98},
    nPorts=1,
    use_p_in=true,
    p=101500,
    T=294.15) "Sink for supply air"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-46})));
  Fluid.Sources.Boundary_pT outsideAir(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    use_T_in=true,
    use_X_in=true,
    nPorts=1,
    use_p_in=false,
    T=290.15) "Source for outside air"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={90,-36})));
  Fluid.Sources.Boundary_pT exhaustAir(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    use_T_in=true,
    use_X_in=true,
    use_p_in=true,
    nPorts=1,
    p=116500,
    T=296.15) "Source for exhaust air"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,38})));
  Fluid.Sources.Boundary_pT exitAir(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    nPorts=1,
    T=303.15) "Sink für exit air" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={82,38})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{54,-10},{34,10}})));
  Modelica.Blocks.Sources.RealExpression openingValueY01(y=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={18,70})));
  Modelica.Blocks.Sources.RealExpression openingValueY02(y=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,70})));
  Modelica.Blocks.Sources.RealExpression openingValueY03(y=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={4,70})));
  Fluid.Movers.FlowControlled_m_flow outsideAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    redeclare Fluid.Movers.Data.Generic per,
    m_flow_start=5.1,
    m_flow_nominal=5)
    "Fan to provide mass flow in main supply air vent, mass flow needs to be initialized"
    annotation (Placement(transformation(extent={{42,-16},{22,-36}})));
  Fluid.Movers.FlowControlled_m_flow exhaustAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    redeclare Fluid.Movers.Data.Generic per,
    m_flow_start=3.1,
    m_flow_nominal=5) "Fan to provide mass flow in main supply air vent"
    annotation (Placement(transformation(extent={{-40,18},{-20,38}})));
  Modelica.Blocks.Sources.RealExpression Zu_Volumen(y=11973/3600) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-86})));
  Fluid.Sensors.RelativeHumidityTwoPort sen_rh_Fort(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1) "Relative Humidity of exit air"
    annotation (Placement(transformation(extent={{30,22},{42,34}})));
  Fluid.Sensors.RelativeHumidityTwoPort sen_rh_Zu(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1) "Relative Humidity of supply air"
    annotation (Placement(transformation(extent={{-44,-30},{-56,-42}})));
  Fluid.Sensors.RelativeHumidityTwoPort sen_rh_Cool_In(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1) "Relative Humidity of Inlet air"
    annotation (Placement(transformation(extent={{78,-32},{66,-20}})));
  Fluid.Sensors.RelativeHumidityTwoPort sen_rh_exhaust(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1) "Relative Humidity of Exhaust Air"
    annotation (Placement(transformation(extent={{-76,34},{-64,22}})));
  Fluid.Sensors.TemperatureTwoPort sen_T_exhaust(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of exhaust air before recuperator"
    annotation (Placement(transformation(extent={{-52,24},{-46,32}})));
  Fluid.Sensors.TemperatureTwoPort sen_T_Zu(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air after recuperator"
    annotation (Placement(transformation(extent={{-20,-32},{-26,-40}})));
  Fluid.Sensors.TemperatureTwoPort sen_T_Fort(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of exit air after recuperator"
    annotation (Placement(transformation(extent={{54,24},{60,32}})));
  Fluid.Sensors.TemperatureTwoPort sen_T_Outside(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of inlet air before recuperator"
    annotation (Placement(transformation(extent={{56,-22},{50,-30}})));
  ComponentsAHU.Recuperator recuperator(
    redeclare package Medium1 = MediumAir,
    m1_flow_nominal=5.1,
    m2_flow_nominal=5.1,
    redeclare package Medium2 = MediumAir)
    annotation (Placement(transformation(extent={{-8,-12},{12,8}})));
  Modelica.Blocks.Sources.RealExpression Ab_Volumen(y=12142/3600) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-24,92})));
  Modelica.Blocks.Sources.RealExpression p_Zu(y=168 + 101325) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-98,-80})));
  Utilities.Psychrometrics.X_pTphi x_pTphi annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-104,74})));
  Modelica.Blocks.Sources.RealExpression p_exhaust(y=101325 - 170)
                                                              annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-132,120})));
  Modelica.Blocks.Sources.RealExpression T_In1(y=21.8 + 273.15) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-132,110})));
  Modelica.Blocks.Sources.RealExpression rh_exhaust(y=0.36)  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-132,100})));
  Modelica.Blocks.Sources.RealExpression T_outside(y=12.74 + 273.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={102,-98})));
  Modelica.Blocks.Sources.RealExpression rh_outside(y=0.7199) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={80,-98})));
  Utilities.Psychrometrics.X_pTphi x_pTphi1(use_p_in=false) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={86,-68})));
  Utilities.Psychrometrics.Density_pTX den annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={38,-86})));
  Modelica.Blocks.Sources.RealExpression p_outside(y=101325) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={118,-98})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,-56})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,62})));
  Utilities.Psychrometrics.Density_pTX den1 annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-42,92})));
equation
  connect(sen_rh_Zu.port_b, supplyAir.ports[1])
    annotation (Line(points={{-56,-36},{-90,-36}}, color={0,127,255}));
  connect(sen_T_Zu.port_b, sen_rh_Zu.port_a)
    annotation (Line(points={{-26,-36},{-44,-36}}, color={0,127,255}));
  connect(recuperator.port_b1, sen_rh_Fort.port_a) annotation (Line(points={{12,4},{
          22,4},{22,28},{30,28}},     color={0,127,255}));
  connect(recuperator.port_b2, sen_T_Zu.port_a) annotation (Line(points={{-8,-8},
          {-14,-8},{-14,-36},{-20,-36}}, color={0,127,255}));
  connect(sen_rh_Fort.port_b, sen_T_Fort.port_a)
    annotation (Line(points={{42,28},{54,28}}, color={0,127,255}));
  connect(sen_T_Fort.port_b, exitAir.ports[1])
    annotation (Line(points={{60,28},{82,28}}, color={0,127,255}));
  connect(booleanExpression.y, recuperator.adiCoo) annotation (Line(points={{33,
          0},{22,0},{22,-0.4},{12.6,-0.4}}, color={255,0,255}));
  connect(openingValueY02.y, recuperator.Y02_opening) annotation (Line(points={
          {-10,59},{-10,40},{0,40},{0,8.6},{-1,8.6}}, color={0,0,127}));
  connect(openingValueY03.y, recuperator.Y03_opening)
    annotation (Line(points={{4,59},{4,40},{5,40},{5,8.6}}, color={0,0,127}));
  connect(openingValueY01.y, recuperator.Y01_opening) annotation (Line(points={
          {18,59},{18,40},{10,40},{10,8.6}}, color={0,0,127}));
  connect(exhaustAir.ports[1], sen_rh_exhaust.port_a)
    annotation (Line(points={{-100,28},{-76,28}}, color={0,127,255}));
  connect(outsideAir.ports[1], sen_rh_Cool_In.port_a)
    annotation (Line(points={{90,-26},{78,-26}}, color={0,127,255}));
  connect(sen_rh_Cool_In.port_b, sen_T_Outside.port_a)
    annotation (Line(points={{66,-26},{56,-26}}, color={0,127,255}));
  connect(sen_T_Outside.port_b, outsideAirFan.port_a)
    annotation (Line(points={{50,-26},{42,-26}}, color={0,127,255}));
  connect(outsideAirFan.port_b, recuperator.port_a2) annotation (Line(points={{
          22,-26},{18,-26},{18,-8},{12,-8}}, color={0,127,255}));
  connect(sen_rh_exhaust.port_b, sen_T_exhaust.port_a)
    annotation (Line(points={{-64,28},{-52,28}}, color={0,127,255}));
  connect(sen_T_exhaust.port_b, exhaustAirFan.port_a)
    annotation (Line(points={{-46,28},{-40,28}}, color={0,127,255}));
  connect(exhaustAirFan.port_b, recuperator.port_a1) annotation (Line(points={{
          -20,28},{-14,28},{-14,4},{-8,4}}, color={0,127,255}));
  connect(p_Zu.y, supplyAir.p_in)
    annotation (Line(points={{-98,-69},{-98,-58}}, color={0,0,127}));
  connect(p_exhaust.y, x_pTphi.p_in)
    annotation (Line(points={{-121,120},{-98,120},{-98,86}}, color={0,0,127}));
  connect(T_In1.y, x_pTphi.T) annotation (Line(points={{-121,110},{-104,110},{
          -104,86}}, color={0,0,127}));
  connect(rh_exhaust.y, x_pTphi.phi) annotation (Line(points={{-121,100},{-110,
          100},{-110,86}}, color={0,0,127}));
  connect(p_exhaust.y, exhaustAir.p_in) annotation (Line(points={{-121,120},{
          -86,120},{-86,54},{-92,54},{-92,50}}, color={0,0,127}));
  connect(T_In1.y, exhaustAir.T_in) annotation (Line(points={{-121,110},{-88,
          110},{-88,56},{-96,56},{-96,50}}, color={0,0,127}));
  connect(x_pTphi1.X, outsideAir.X_in)
    annotation (Line(points={{86,-57},{86,-48}}, color={0,0,127}));
  connect(x_pTphi.X, exhaustAir.X_in)
    annotation (Line(points={{-104,63},{-104,50}}, color={0,0,127}));
  connect(rh_outside.y, x_pTphi1.phi)
    annotation (Line(points={{80,-87},{80,-80}}, color={0,0,127}));
  connect(T_outside.y, x_pTphi1.T)
    annotation (Line(points={{102,-87},{102,-80},{86,-80}}, color={0,0,127}));
  connect(T_outside.y, outsideAir.T_in)
    annotation (Line(points={{102,-87},{102,-48},{94,-48}}, color={0,0,127}));
  connect(Zu_Volumen.y, product.u1) annotation (Line(points={{22,-75},{22,-72},
          {26,-72},{26,-68}}, color={0,0,127}));
  connect(den.d, product.u2) annotation (Line(points={{38,-75},{38,-68}},
                     color={0,0,127}));
  connect(p_outside.y, den.p) annotation (Line(points={{118,-87},{128,-87},{128,
          -114},{30,-114},{30,-97}},  color={0,0,127}));
  connect(x_pTphi1.X[1], den.X_w) annotation (Line(points={{86,-57},{86,-54},{
          54,-54},{54,-112},{38,-112},{38,-97}},  color={0,0,127}));
  connect(T_outside.y, den.T) annotation (Line(points={{102,-87},{102,-76},{112,
          -76},{112,-110},{46,-110},{46,-97}},  color={0,0,127}));
  connect(den1.d, product1.u1)
    annotation (Line(points={{-42,81},{-42,74},{-36,74}}, color={0,0,127}));
  connect(p_exhaust.y, den1.p) annotation (Line(points={{-121,120},{-34,120},{
          -34,103}}, color={0,0,127}));
  connect(x_pTphi.X[1], den1.X_w) annotation (Line(points={{-104,63},{-104,58},
          {-68,58},{-68,116},{-42,116},{-42,103}}, color={0,0,127}));
  connect(T_In1.y, den1.T) annotation (Line(points={{-121,110},{-50,110},{-50,
          103}}, color={0,0,127}));
  connect(product.y, outsideAirFan.m_flow_in)
    annotation (Line(points={{32,-45},{32,-38}}, color={0,0,127}));
  connect(product1.y, exhaustAirFan.m_flow_in)
    annotation (Line(points={{-30,51},{-30,40}}, color={0,0,127}));
  connect(Ab_Volumen.y, product1.u2)
    annotation (Line(points={{-24,81},{-24,74}}, color={0,0,127}));
  annotation (experiment(StopTime=1800, __Dymola_NumberOfIntervals=1800));
end TestRecuperator;
