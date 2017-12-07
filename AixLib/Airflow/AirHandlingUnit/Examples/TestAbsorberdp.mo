within AixLib.Airflow.AirHandlingUnit.Examples;
model TestAbsorberdp "testing model for absorber using partial pressure"
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
        origin={74,-74})));
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
  Modelica.Blocks.Sources.RealExpression Zu_Volumen(y=12510) annotation (
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
  ComponentsAHU.Absorber absorber_dp_plot(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5,
    x_sol=0.33)
               annotation (Placement(transformation(extent={{26,30},{46,50}})));
  ComponentsAHU.solutionTank solutionTank(m(start=1000),
    m_start=1000,
    x_sol=0.4)
    annotation (Placement(transformation(extent={{46,-18},{26,2}})));
  Modelica.Blocks.Sources.RealExpression mreg(y=0) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={68,-40})));
  Modelica.Blocks.Sources.RealExpression T_reg(y=45 + 273.15) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={68,-16})));
  Modelica.Blocks.Sources.RealExpression x_reg(y=0.4) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={68,-28})));
  Modelica.Blocks.Sources.BooleanExpression Pump1(y=true)
                                               "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{60,6},{40,26}})));
  Modelica.Blocks.Sources.RealExpression T_reg1(y=26 + 273.15)
                                                              annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,60})));
  Modelica.Blocks.Sources.RealExpression no_bypass(y=0.99)
    "the desorber has no bypass valve, i.e. the bypass is closed" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={14,22})));
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
  connect(bou.ports[1], absorber_dp_plot.port_a)
    annotation (Line(points={{-20,12},{-20,40},{26,40}}, color={0,127,255}));
  connect(absorber_dp_plot.port_b, bou1.ports[1])
    annotation (Line(points={{46,40},{90,40},{90,10}}, color={0,127,255}));
  connect(absorber_dp_plot.Ts_out, solutionTank.T_in) annotation (Line(points={{46.2,47},
          {72,47},{72,0},{46.6,0}},             color={0,0,127}));
  connect(absorber_dp_plot.x_out, solutionTank.x_in) annotation (Line(points={{46.2,43},
          {72,43},{72,-3},{46.6,-3}},            color={0,0,127}));
  connect(absorber_dp_plot.L_out, solutionTank.L) annotation (Line(points={{46.2,33},
          {72,33},{72,-6},{46.6,-6}},          color={0,0,127}));
  connect(solutionTank.x_out, absorber_dp_plot.x_in) annotation (Line(points={{25.6,-8},
          {-2,-8},{-2,44},{25.4,44}},            color={0,0,127}));
  connect(mreg.y, solutionTank.m_reg)
    annotation (Line(points={{57,-40},{50,-40},{50,-16},{46.6,-16}},
                                                   color={0,0,127}));
  connect(T_reg.y, solutionTank.T_reg) annotation (Line(points={{57,-16},{54,
          -16},{54,-10},{46.6,-10}}, color={0,0,127}));
  connect(x_reg.y, solutionTank.x_reg) annotation (Line(points={{57,-28},{52,
          -28},{52,-13},{46.6,-13}}, color={0,0,127}));
  connect(Pump1.y, solutionTank.Pump)
    annotation (Line(points={{39,16},{36,16},{36,2}}, color={255,0,255}));
  connect(solutionTank.L_out, absorber_dp_plot.L_i) annotation (Line(points={{
          25.6,-14},{-2,-14},{-2,35},{25.4,35}}, color={0,0,127}));
  connect(Pump1.y, absorber_dp_plot.Pump)
    annotation (Line(points={{39,16},{36,16},{36,30}}, color={255,0,255}));
  connect(T_reg1.y, absorber_dp_plot.Ts_in) annotation (Line(points={{1,60},{14,
          60},{14,48},{25.4,48}}, color={0,0,127}));
  connect(no_bypass.y, absorber_dp_plot.Y06)
    annotation (Line(points={{25,22},{30.4,22},{30.4,31.2}}, color={0,0,127}));
  annotation (experiment(StopTime=18000, Interval=10));
end TestAbsorberdp;
