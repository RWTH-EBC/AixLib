within AixLib.Airflow.AirHandlingUnit.Examples;
model TestDesorber "testing model for desorber using partial pressure"
  extends Modelica.Icons.Example;

      //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  Fluid.Sources.MassFlowSource_T
                            bou(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    m_flow=5,
    use_T_in=true,
    use_X_in=true,
    use_m_flow_in=true,
    T=305.15,
    nPorts=1)                             annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-20,2})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumAir,
    T=301.75,
    nPorts=1)                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,0})));
  Utilities.Psychrometrics.X_pTphi x_pTphi2(use_p_in=false) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-16,-34})));
  Modelica.Blocks.Sources.RealExpression T_air_inlet(y=32 + 273.15) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={66,-74})));
  Modelica.Blocks.Sources.RealExpression phi_air_inlet(y=0.4) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-74})));
  Utilities.Psychrometrics.Density_pTX den1 annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,-16})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{-78,32},{-58,52}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-48,12})));
  Modelica.Blocks.Sources.RealExpression Umrechnung_sek(y=3600) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-96,36})));
  Modelica.Blocks.Sources.RealExpression Zu_Volumen(y=3000)  annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-96,48})));
  Modelica.Blocks.Sources.RealExpression p_air(y=101325) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-58})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,1,1,
        305.15,0.4; 18000,1,1,305.15,0.4])
    annotation (Placement(transformation(extent={{-76,-94},{-56,-74}})));
  BaseClasses.DataBase.BouConRecAdiaOff_nominal bouCon(Profile=[0,293,0.33,
        305.15,0.4; 500,298,0.33,305.15,0.4; 1000,303,0.33,305.15,0.4; 1500,308,
        0.33,305.15,0.4; 2000,299.15,0.3,305.15,0.4; 2500,299.15,0.32,305.15,
        0.4; 3000,299.15,0.34,305.15,0.4; 3500,299.15,0.36,305.15,0.4; 4000,
        299.15,0.38,305.15,0.4; 4500,299.15,0.4,305.15,0.4; 5000,299.15,0.33,
        273.15,0.4; 5500,299.15,0.33,283.15,0.4; 6000,299.15,0.33,293.15,0.4;
        6500,299.15,0.33,303.15,0.4; 7000,299.15,0.33,305.15,0.4; 7500,299.15,
        0.33,305.15,0.2; 8000,299.15,0.33,305.15,0.3; 8500,299.15,0.33,305.15,
        0.4; 9000,299.15,0.33,305.15,0.5; 9500,299.15,0.33,305.15,0.6; 10000,
        299.15,0.33,305.15,0.7; 10500,299.15,0.33,305.15,0.8; 11000,299.15,0.33,
        305.15,0.4; 18000,299.15,0.33,305.15,0.4])
    "Boundary Conditions for the recuperator for different time series"
    annotation (Placement(transformation(extent={{-18,80},{2,100}})));
  ComponentsAHU.Absorber desorber(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5,
    V=0.285075,
    eps=0.85,
    x_sol=0.4,
    beta=8.41355*10^(-8),
    dp_abs=250,
    t_sol=337.15)
    annotation (Placement(transformation(extent={{26,30},{46,50}})));
  Modelica.Blocks.Sources.BooleanExpression Pump1(y=true)
                                               "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{64,8},{44,28}})));
  Modelica.Blocks.Sources.RealExpression Ts_in(y=64 + 273.15) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-22,70})));
  Modelica.Blocks.Sources.RealExpression x_in(y=0.4) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-22,58})));
  Modelica.Blocks.Sources.RealExpression L_in(y=5.19) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-22,46})));
  ComponentsAHU.solutionTank desorberTank(
    t_sol=64 + 273.15,
    m_start=900,
    x_sol=0.4) annotation (Placement(transformation(extent={{46,-10},{26,10}})));
  Modelica.Blocks.Sources.RealExpression Ts_in1(y=29 + 273.15) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={64,-6})));
  Modelica.Blocks.Sources.RealExpression x_in1(y=0.3) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={64,-18})));
  Modelica.Blocks.Sources.RealExpression L_in1(y=0) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={64,-32})));
  Modelica.Blocks.Sources.RealExpression no_bypass(y=0)
    "the desorber has no bypass valve, i.e. the bypass is closed" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={8,10})));
equation
  connect(x_pTphi2.X, bou.X_in)
    annotation (Line(points={{-16,-23},{-16,-10}}, color={0,0,127}));
  connect(Zu_Volumen.y, division3.u1)
    annotation (Line(points={{-85,48},{-80,48}}, color={0,0,127}));
  connect(Umrechnung_sek.y, division3.u2)
    annotation (Line(points={{-85,36},{-80,36}}, color={0,0,127}));
  connect(product1.y, bou.m_flow_in) annotation (Line(points={{-37,12},{-34,12},
          {-34,-8},{-28,-8}}, color={0,0,127}));
  connect(division3.y, product1.u2) annotation (Line(points={{-57,42},{-54,42},
          {-54,24},{-64,24},{-64,18},{-60,18}}, color={0,0,127}));
  connect(den1.d, product1.u1) annotation (Line(points={{-80,-5},{-80,12},{-60,
          12},{-60,6}}, color={0,0,127}));
  connect(p_air.y, den1.p)
    annotation (Line(points={{-90,-47},{-90,-27},{-88,-27}}, color={0,0,127}));
  connect(x_pTphi2.X[1], den1.X_w) annotation (Line(points={{-16,-23},{-16,-22},
          {-66,-22},{-66,-36},{-80,-36},{-80,-27}}, color={0,0,127}));
  connect(combiTimeTable2.y[3], x_pTphi2.T)
    annotation (Line(points={{-55,-84},{-16,-84},{-16,-46}}, color={0,0,127}));
  connect(combiTimeTable2.y[3], den1.T) annotation (Line(points={{-55,-84},{-46,
          -84},{-46,-46},{-72,-46},{-72,-27}}, color={0,0,127}));
  connect(combiTimeTable2.y[3], bou.T_in) annotation (Line(points={{-55,-84},{
          -46,-84},{-46,-16},{-24,-16},{-24,-10}}, color={0,0,127}));
  connect(combiTimeTable2.y[4], x_pTphi2.phi)
    annotation (Line(points={{-55,-84},{-10,-84},{-10,-46}}, color={0,0,127}));
  connect(bou.ports[1], desorber.port_a)
    annotation (Line(points={{-20,12},{-20,40},{26,40}}, color={0,127,255}));
  connect(desorber.port_b, bou1.ports[1])
    annotation (Line(points={{46,40},{90,40},{90,10}}, color={0,127,255}));
  connect(Pump1.y, desorber.Pump)
    annotation (Line(points={{43,18},{36,18},{36,30}}, color={255,0,255}));
  connect(Pump1.y, desorberTank.Pump)
    annotation (Line(points={{43,18},{36,18},{36,10}}, color={255,0,255}));
  connect(desorber.Ts_out, desorberTank.T_in) annotation (Line(points={{46.2,47},
          {66,47},{66,8},{46.6,8}}, color={0,0,127}));
  connect(desorber.x_out, desorberTank.x_in) annotation (Line(points={{46.2,43},
          {64,43},{64,5},{46.6,5}}, color={0,0,127}));
  connect(desorber.L_out, desorberTank.L) annotation (Line(points={{46.2,33},{
          68,33},{68,2},{46.6,2}}, color={0,0,127}));
  connect(desorberTank.x_out, desorber.x_in) annotation (Line(points={{25.6,0},
          {20,0},{20,44},{25.4,44}}, color={0,0,127}));
  connect(desorberTank.L_out, desorber.L_i) annotation (Line(points={{25.6,-6},
          {22,-6},{22,35},{25.4,35}}, color={0,0,127}));
  connect(Ts_in1.y, desorberTank.T_reg) annotation (Line(points={{53,-6},{52,-6},
          {52,-2},{46.6,-2}}, color={0,0,127}));
  connect(x_in1.y, desorberTank.x_reg) annotation (Line(points={{53,-18},{50,
          -18},{50,-5},{46.6,-5}}, color={0,0,127}));
  connect(L_in1.y, desorberTank.m_reg) annotation (Line(points={{53,-32},{50,
          -32},{50,-8},{46.6,-8}}, color={0,0,127}));
  connect(Ts_in.y, desorber.Ts_in) annotation (Line(points={{-11,70},{6,70},{6,
          48},{25.4,48}}, color={0,0,127}));
  connect(no_bypass.y, desorber.Y06) annotation (Line(points={{8,21},{8,26},{
          30.4,26},{30.4,31.2}}, color={0,0,127}));
  annotation (experiment(StopTime=18000, Interval=10));
end TestDesorber;
