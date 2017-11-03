within AixLib.Airflow.AirHandlingUnit;
package Validation
  extends Modelica.Icons.ExamplesPackage;
  model ValidationRecuperator
    "model to validate a time series of data in the recuperator"

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
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
      annotation (Placement(transformation(extent={{54,-10},{34,10}})));
    Modelica.Blocks.Sources.RealExpression openingValueY01(y=1) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={18,52})));
    Modelica.Blocks.Sources.RealExpression openingValueY02(y=0) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,52})));
    Modelica.Blocks.Sources.RealExpression openingValueY03(y=0) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={4,52})));
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
    Modelica.Blocks.Sources.RealExpression Zu_Volumen(y=3600)       annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-44,-98})));
    Fluid.Sensors.RelativeHumidityTwoPort sen_rh_Fort(redeclare package Medium =
          MediumAir, m_flow_nominal=5.1) "Relative Humidity of exit air"
      annotation (Placement(transformation(extent={{30,22},{42,34}})));
    Fluid.Sensors.RelativeHumidityTwoPort sen_rh_Zu(redeclare package Medium =
          MediumAir, m_flow_nominal=5.1) "Relative Humidity of supply air"
      annotation (Placement(transformation(extent={{-44,-30},{-56,-42}})));
    Fluid.Sensors.RelativeHumidityTwoPort sen_rh_Cool_In(redeclare package
        Medium =
          MediumAir, m_flow_nominal=5.1) "Relative Humidity of Inlet air"
      annotation (Placement(transformation(extent={{78,-32},{66,-20}})));
    Fluid.Sensors.RelativeHumidityTwoPort sen_rh_exhaust(redeclare package
        Medium =
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
    Modelica.Blocks.Sources.RealExpression Ab_Volumen(y=3600)       annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={26,80})));
    Utilities.Psychrometrics.X_pTphi x_pTphi annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-104,74})));
    Modelica.Blocks.Sources.RealExpression p_default(y=101325)  annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-162,146})));
    Modelica.Blocks.Sources.RealExpression T_default(y=273.15) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-162,122})));
    Modelica.Blocks.Sources.RealExpression rh_default(y=100)   annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-162,84})));
    Utilities.Psychrometrics.X_pTphi x_pTphi1(use_p_in=false) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={86,-68})));
    Utilities.Psychrometrics.Density_pTX den annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={38,-96})));
    Modelica.Blocks.Math.Product product annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={32,-58})));
    Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-30,60})));
    Utilities.Psychrometrics.Density_pTX den1 annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-36,94})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{-142,130},{-122,150}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-142,106},{-122,126}})));
    Modelica.Blocks.Math.Division division
      annotation (Placement(transformation(extent={{-142,80},{-122,100}})));
    Modelica.Blocks.Sources.RealExpression T_default1(y=273.15) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={148,-106})));
    Modelica.Blocks.Sources.RealExpression rh_default1(y=100)  annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={148,-92})));
    Modelica.Blocks.Math.Add add3 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={116,-112})));
    Modelica.Blocks.Math.Division division1 annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={116,-86})));
    Modelica.Blocks.Sources.RealExpression p_default1(y=101325) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={70,-122})));
    Modelica.Blocks.Math.Add add2 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-98,-78})));
    Modelica.Blocks.Sources.RealExpression p_default2(y=101325) annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={-92,-108})));
    Modelica.Blocks.Math.Division division2
      annotation (Placement(transformation(extent={{-14,-94},{6,-74}})));
    Modelica.Blocks.Math.Division division3
      annotation (Placement(transformation(extent={{4,76},{-16,96}})));
    Modelica.Blocks.Continuous.Filter filter(f_cut=0.01)
      annotation (Placement(transformation(extent={{-138,-102},{-118,-82}})));
    BaseClasses.DataBase.BouConRecAdiaOn_07Jul17 bouCon
      "Boundary Conditions for the recuperator for different time series"
      annotation (Placement(transformation(extent={{-156,8},{-136,28}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(table=bouCon.Profile,
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
      annotation (Placement(transformation(extent={{-136,38},{-156,58}})));
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
    connect(openingValueY02.y, recuperator.Y02_opening) annotation (Line(points={{-10,41},
            {-10,40},{0,40},{0,8.6},{-1,8.6}},          color={0,0,127}));
    connect(openingValueY03.y, recuperator.Y03_opening)
      annotation (Line(points={{4,41},{4,40},{5,40},{5,8.6}}, color={0,0,127}));
    connect(openingValueY01.y, recuperator.Y01_opening) annotation (Line(points={{18,41},
            {18,40},{10,40},{10,8.6}},         color={0,0,127}));
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
    connect(x_pTphi1.X, outsideAir.X_in)
      annotation (Line(points={{86,-57},{86,-48}}, color={0,0,127}));
    connect(x_pTphi.X, exhaustAir.X_in)
      annotation (Line(points={{-104,63},{-104,50}}, color={0,0,127}));
    connect(product.y, outsideAirFan.m_flow_in)
      annotation (Line(points={{32,-47},{32,-38}}, color={0,0,127}));
    connect(den.d, product.u2) annotation (Line(points={{38,-85},{38,-70}},
                       color={0,0,127}));
    connect(x_pTphi1.X[1], den.X_w) annotation (Line(points={{86,-57},{86,-54},
            {54,-54},{54,-118},{38,-118},{38,-107}},color={0,0,127}));
    connect(product1.y, exhaustAirFan.m_flow_in)
      annotation (Line(points={{-30,49},{-30,40}}, color={0,0,127}));
    connect(den1.d, product1.u1)
      annotation (Line(points={{-36,83},{-36,72}},          color={0,0,127}));
    connect(x_pTphi.X[1], den1.X_w) annotation (Line(points={{-104,63},{-104,60},
            {-68,60},{-68,110},{-36,110},{-36,105}}, color={0,0,127}));
    connect(p_default.y, add.u1)
      annotation (Line(points={{-151,146},{-144,146}}, color={0,0,127}));
    connect(T_default.y, add1.u1)
      annotation (Line(points={{-151,122},{-144,122}}, color={0,0,127}));
    connect(rh_default.y, division.u2)
      annotation (Line(points={{-151,84},{-144,84}}, color={0,0,127}));
    connect(add.y, x_pTphi.p_in) annotation (Line(points={{-121,140},{-98,140},
            {-98,86}}, color={0,0,127}));
    connect(add.y, den1.p) annotation (Line(points={{-121,140},{-28,140},{-28,
            105}}, color={0,0,127}));
    connect(add.y, exhaustAir.p_in) annotation (Line(points={{-121,140},{-82,
            140},{-82,56},{-92,56},{-92,50}}, color={0,0,127}));
    connect(add1.y, den1.T) annotation (Line(points={{-121,116},{-44,116},{-44,
            105}}, color={0,0,127}));
    connect(add1.y, x_pTphi.T) annotation (Line(points={{-121,116},{-104,116},{
            -104,86}}, color={0,0,127}));
    connect(add1.y, exhaustAir.T_in) annotation (Line(points={{-121,116},{-88,
            116},{-88,58},{-96,58},{-96,50}}, color={0,0,127}));
    connect(division.y, x_pTphi.phi) annotation (Line(points={{-121,90},{-110,
            90},{-110,86}}, color={0,0,127}));
    connect(T_default1.y, add3.u1)
      annotation (Line(points={{137,-106},{128,-106}}, color={0,0,127}));
    connect(rh_default1.y, division1.u2)
      annotation (Line(points={{137,-92},{128,-92}}, color={0,0,127}));
    connect(add3.y, x_pTphi1.T) annotation (Line(points={{105,-112},{86,-112},{
            86,-80}}, color={0,0,127}));
    connect(add3.y, den.T) annotation (Line(points={{105,-112},{46,-112},{46,
            -107}}, color={0,0,127}));
    connect(add3.y, outsideAir.T_in) annotation (Line(points={{105,-112},{100,
            -112},{100,-54},{94,-54},{94,-48}}, color={0,0,127}));
    connect(division1.y, x_pTphi1.phi)
      annotation (Line(points={{105,-86},{92,-86},{92,-80}}, color={0,0,127}));
    connect(p_default1.y, den.p) annotation (Line(points={{59,-122},{30,-122},{
            30,-107}}, color={0,0,127}));
    connect(p_default2.y, add2.u2)
      annotation (Line(points={{-92,-97},{-92,-90}}, color={0,0,127}));
    connect(add2.y, supplyAir.p_in)
      annotation (Line(points={{-98,-67},{-98,-58}}, color={0,0,127}));
    connect(Zu_Volumen.y, division2.u2) annotation (Line(points={{-33,-98},{-26,
            -98},{-26,-90},{-16,-90}}, color={0,0,127}));
    connect(division2.y, product.u1)
      annotation (Line(points={{7,-84},{26,-84},{26,-70}}, color={0,0,127}));
    connect(Ab_Volumen.y, division3.u2)
      annotation (Line(points={{15,80},{6,80}}, color={0,0,127}));
    connect(division3.y, product1.u2)
      annotation (Line(points={{-17,86},{-24,86},{-24,72}}, color={0,0,127}));
    connect(filter.y, add2.u1) annotation (Line(points={{-117,-92},{-110,-92},{
            -110,-90},{-104,-90}}, color={0,0,127}));
    connect(combiTimeTable2.y[3], division.u1) annotation (Line(points={{-157,48},
            {-178,48},{-178,96},{-144,96}},     color={0,0,127}));
    connect(combiTimeTable2.y[7], division3.u1) annotation (Line(points={{-157,48},
            {-178,48},{-178,158},{12,158},{12,92},{6,92}},     color={0,0,127}));
    connect(combiTimeTable2.y[8], division2.u1) annotation (Line(points={{-157,48},
            {-178,48},{-178,-128},{-62,-128},{-62,-78},{-16,-78}},     color={0,
            0,127}));
    connect(combiTimeTable2.y[6], filter.u) annotation (Line(points={{-157,48},
            {-178,48},{-178,-92},{-140,-92}}, color={0,0,127}));
    connect(combiTimeTable2.y[1], add.u2) annotation (Line(points={{-157,48},{
            -178,48},{-178,134},{-144,134}}, color={0,0,127}));
    connect(combiTimeTable2.y[2], add1.u2) annotation (Line(points={{-157,48},{
            -178,48},{-178,110},{-144,110}}, color={0,0,127}));
    connect(combiTimeTable2.y[4], add3.u2) annotation (Line(points={{-157,48},{
            -178,48},{-178,-128},{164,-128},{164,-118},{128,-118}}, color={0,0,
            127}));
    connect(combiTimeTable2.y[5], division1.u1) annotation (Line(points={{-157,48},
            {-178,48},{-178,-128},{164,-128},{164,-80},{128,-80}},     color={0,
            0,127}));
    annotation (experiment(StopTime=604800, Interval=600));
  end ValidationRecuperator;

  model ValidationAbsorber "Validation model for absorber"
    extends Modelica.Icons.Example;

        //Medium models
    replaceable package MediumAir = AixLib.Media.Air;
    replaceable package MediumWater = AixLib.Media.Water;

    ComponentsAHU.AbsorberSimple absorberSimple(
      redeclare package Medium1 = MediumAir,
      m1_flow_nominal=5,
      m2_flow_nominal=1,
      m3_flow_nominal=11.5*1000/3600,
      redeclare package Medium2 = MediumWater,
      dp_abs=0,
      dp_wat=0)
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
    Fluid.Sources.MassFlowSource_T
                              bou(
      redeclare package Medium = MediumAir,
      X={0.01,0.99},
      nPorts=1,
      m_flow=5,
      T=305.15)                             annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={30,10})));
    Fluid.Sources.Boundary_pT bou1(nPorts=1,
      redeclare package Medium = MediumAir,
      T=301.75)                              annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-30,10})));
    Fluid.Sources.Boundary_pT bou3(nPorts=1,
      redeclare package Medium = MediumAir,
      T=327.95)                              annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,70})));
    Fluid.Sources.Boundary_pT bou5(nPorts=1,
      redeclare package Medium = MediumWater,
      T=299.15)
      annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
    Fluid.Sources.MassFlowSource_T
                              bou2(
      redeclare package Medium = MediumAir,
      X={0.01,0.99},
      nPorts=1,
      m_flow=1,
      T=305.15)                             annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={30,70})));
    Fluid.Sources.MassFlowSource_T
                              bou6(
      nPorts=1,
      m_flow=15,
      redeclare package Medium = MediumWater,
      T=305.15)                             annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-70,60})));
  equation
    connect(absorberSimple.port_b1, bou1.ports[1])
      annotation (Line(points={{-10,34},{-30,34},{-30,20}}, color={0,127,255}));
    connect(bou.ports[1], absorberSimple.port_a1)
      annotation (Line(points={{30,20},{30,34},{10,34}}, color={0,127,255}));
    connect(bou2.ports[1], absorberSimple.port_a2)
      annotation (Line(points={{30,60},{30,46},{10,46}}, color={0,127,255}));
    connect(bou3.ports[1], absorberSimple.port_b2) annotation (Line(points={{
            -30,60},{-30,46},{-10,46}}, color={0,127,255}));
    connect(bou5.ports[1], absorberSimple.port_b3) annotation (Line(points={{
            -60,20},{-40,20},{-40,39},{-10,39}}, color={0,127,255}));
    connect(bou6.ports[1], absorberSimple.port_a3) annotation (Line(points={{
            -60,60},{-40,60},{-40,41},{-10,41}}, color={0,127,255}));
  end ValidationAbsorber;

end Validation;
