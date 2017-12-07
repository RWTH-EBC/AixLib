within AixLib.Airflow.AirHandlingUnit.Examples;
model TestSorption "testing model for sorption system"
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
        origin={-140,-120})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumAir,
    T=301.75,
    nPorts=1)                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={208,-184})));
  Utilities.Psychrometrics.X_pTphi x_pTphi2(use_p_in=false) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-136,-156})));
  Modelica.Blocks.Sources.RealExpression T_air_inlet(y=32 + 273.15) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={186,-208})));
  Modelica.Blocks.Sources.RealExpression phi_air_inlet(y=0.4) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={210,-208})));
  Utilities.Psychrometrics.Density_pTX den1 annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-200,-138})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{-198,-90},{-178,-70}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-168,-110})));
  Modelica.Blocks.Sources.RealExpression Umrechnung_sek(y=3600) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-216,-86})));
  Modelica.Blocks.Sources.RealExpression Zu_Volumen(y=12510) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-216,-72})));
  Modelica.Blocks.Sources.RealExpression p_air(y=101325) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-210,-180})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,1,1,
        305.15,0.4; 18000,1,1,305.15,0.4])
    annotation (Placement(transformation(extent={{-196,-216},{-176,-196}})));
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
    annotation (Placement(transformation(extent={{-220,202},{-200,222}})));
  ComponentsAHU.Absorber absorber_dp_plot(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5,
    x_sol=0.3)
    annotation (Placement(transformation(extent={{56,-104},{76,-84}})));
  ComponentsAHU.solutionTank absorberTank(
    m_start=900,
    m(start=900),
    x_sol=0.3)
    annotation (Placement(transformation(extent={{76,-138},{56,-118}})));
  Fluid.Sources.MassFlowSource_T
                            bou2(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    m_flow=5,
    use_T_in=true,
    use_X_in=true,
    use_m_flow_in=true,
    T=305.15,
    nPorts=1)                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={140,116})));
  Utilities.Psychrometrics.X_pTphi x_pTphi1(use_p_in=false) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={178,108})));
  Utilities.Psychrometrics.Density_pTX den2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={202,148})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{164,194},{184,214}})));
  Modelica.Blocks.Math.Product product2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={178,170})));
  Modelica.Blocks.Sources.RealExpression Umrechnung_sek1(
                                                        y=3600) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={134,198})));
  Modelica.Blocks.Sources.RealExpression Zu_Volumen1(
                                                    y=3000)  annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={134,210})));
  Modelica.Blocks.Sources.RealExpression p_air1(
                                               y=101325) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={210,116})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,1,1,
        305.15,0.4; 18000,1,1,305.15,0.4])
    annotation (Placement(transformation(extent={{216,78},{196,98}})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = MediumAir,
    T=301.75,
    nPorts=1)                              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-42,204})));
  ComponentsAHU.Absorber desorber(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5,
    V=0.285075,
    beta=4.6*10^(-8),
    eps=0.85,
    x_sol=0.4,
    dp_abs=250,
    t_sol=337.15)
    annotation (Placement(transformation(extent={{54,6},{34,26}})));
  ComponentsAHU.solutionTank desorberTank(
    t_sol=64 + 273.15,
    m_start=100,
    m(start=100),
    x_sol=0.3) annotation (Placement(transformation(extent={{54,-26},{34,-6}})));
  ComponentsAHU.sorptionExchange sorptionExchange
    annotation (Placement(transformation(extent={{-4,-64},{22,-38}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=22)
    annotation (Placement(transformation(extent={{-170,160},{-150,180}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.sorptionControl
    valve_Y15(
    Y_ConAbsDes(n=3, modes={7,22,23}),
    Y_ConSingle(n=8, modes={5,6,16,17,18,19,20,21}),
    Y_Close(n=12, modes={1,2,3,4,8,9,10,11,12,13,14,15}))
    annotation (Placement(transformation(extent={{-110,172},{-90,192}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.sorptionControl
    valve_Y16(
    Y_ConAbsDes(n=3, modes={7,22,23}),
    Y_ConSingle(n=3, modes={4,14,15}),
    Y_Close(n=17, modes={1,2,3,5,6,8,9,10,11,12,13,16,17,18,19,20,21}))
    annotation (Placement(transformation(extent={{-110,144},{-90,164}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.Y15_evaluationAdvanced
    eva_Y15 annotation (Placement(transformation(extent={{-80,172},{-60,192}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.Y16_evaluationAdvanced
    evaY16 annotation (Placement(transformation(extent={{-78,144},{-58,164}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.controlvalve2
                                     valve_Y10(Y_Close(n=12, modes={1,2,3,4,8,9,
          10,11,12,13,14,15}), Y_Control(n=11, modes={5,6,7,16,17,18,19,20,21,22,
          23})) "controlValve"
    annotation (Placement(transformation(extent={{-110,120},{-90,140}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.heaCoiEva
                                        y10_evaluation(
    k=0.04,
    Ti=240,
    Setpoint=64 + 273.15)
    annotation (Placement(transformation(extent={{-78,120},{-58,140}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.Pump_Bool
                                 pumpN07(Pump_Off(n=17, modes={1,2,3,5,6,8,9,10,
          11,12,13,16,17,18,19,20,21}), Pump_On(n=6, modes={4,7,14,15,22,23}))
    "absorber pump signal"
    annotation (Placement(transformation(extent={{-110,56},{-90,76}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.Pump_Bool
                                 pumpN08(Pump_Off(n=12, modes={1,2,3,4,8,9,10,11,
          12,13,14,15}), Pump_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}))
    "on off signal for pump N08, regeneration pump for desiccant solution"
    annotation (Placement(transformation(extent={{-110,36},{-90,56}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.Pump_Bool pumpN05(Pump_Off(
        n=12, modes={1,2,3,4,8,9,10,11,12,13,14,15}), Pump_On(n=11, modes={5,6,7,
          16,17,18,19,20,21,22,23}))
    "on off signal for pump N05, regeneration heating coil"
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
equation
  connect(x_pTphi2.X, bou.X_in)
    annotation (Line(points={{-136,-145},{-136,-132}},
                                                   color={0,0,127}));
  connect(Zu_Volumen.y, division3.u1)
    annotation (Line(points={{-205,-72},{-202,-72},{-202,-74},{-200,-74}},
                                                 color={0,0,127}));
  connect(Umrechnung_sek.y, division3.u2)
    annotation (Line(points={{-205,-86},{-200,-86}},
                                                 color={0,0,127}));
  connect(product1.y, bou.m_flow_in) annotation (Line(points={{-157,-110},{-154,
          -110},{-154,-130},{-148,-130}},
                              color={0,0,127}));
  connect(division3.y, product1.u2) annotation (Line(points={{-177,-80},{-174,-80},
          {-174,-98},{-184,-98},{-184,-104},{-180,-104}},
                                                color={0,0,127}));
  connect(den1.d, product1.u1) annotation (Line(points={{-200,-127},{-200,-110},
          {-180,-110},{-180,-116}},
                        color={0,0,127}));
  connect(p_air.y, den1.p)
    annotation (Line(points={{-210,-169},{-210,-149},{-208,-149}},
                                                             color={0,0,127}));
  connect(x_pTphi2.X[1], den1.X_w) annotation (Line(points={{-136,-145},{-136,-144},
          {-186,-144},{-186,-158},{-200,-158},{-200,-149}},
                                                    color={0,0,127}));
  connect(combiTimeTable2.y[3], x_pTphi2.T)
    annotation (Line(points={{-175,-206},{-136,-206},{-136,-168}},
                                                             color={0,0,127}));
  connect(combiTimeTable2.y[3], den1.T) annotation (Line(points={{-175,-206},{-166,
          -206},{-166,-168},{-192,-168},{-192,-149}},
                                               color={0,0,127}));
  connect(combiTimeTable2.y[3], bou.T_in) annotation (Line(points={{-175,-206},{
          -166,-206},{-166,-138},{-144,-138},{-144,-132}},
                                                   color={0,0,127}));
  connect(combiTimeTable2.y[4], x_pTphi2.phi)
    annotation (Line(points={{-175,-206},{-130,-206},{-130,-168}},
                                                             color={0,0,127}));
  connect(bou.ports[1], absorber_dp_plot.port_a)
    annotation (Line(points={{-140,-110},{-140,-94},{56,-94}},
                                                         color={0,127,255}));
  connect(absorber_dp_plot.port_b, bou1.ports[1])
    annotation (Line(points={{76,-94},{208,-94},{208,-174}},
                                                       color={0,127,255}));
  connect(absorber_dp_plot.Ts_out,absorberTank. T_in) annotation (Line(points={{76.2,
          -87},{86,-87},{86,-120},{76.6,-120}}, color={0,0,127}));
  connect(absorber_dp_plot.x_out,absorberTank. x_in) annotation (Line(points={{76.2,
          -91},{84,-91},{84,-123},{76.6,-123}},  color={0,0,127}));
  connect(absorber_dp_plot.L_out,absorberTank. L) annotation (Line(points={{76.2,
          -101},{82,-101},{82,-126},{76.6,-126}},
                                               color={0,0,127}));
  connect(x_pTphi1.X, bou2.X_in)
    annotation (Line(points={{178,119},{178,128},{136,128}},
                                                         color={0,0,127}));
  connect(Zu_Volumen1.y, division1.u1)
    annotation (Line(points={{145,210},{162,210}}, color={0,0,127}));
  connect(Umrechnung_sek1.y, division1.u2)
    annotation (Line(points={{145,198},{162,198}}, color={0,0,127}));
  connect(product2.y, bou2.m_flow_in) annotation (Line(points={{167,170},{155,170},
          {155,126},{148,126}},
                              color={0,0,127}));
  connect(division1.y,product2. u2) annotation (Line(points={{185,204},{206,204},
          {206,176},{190,176}},                 color={0,0,127}));
  connect(den2.d,product2. u1) annotation (Line(points={{202,159},{198,159},{198,
          164},{190,164}},
                        color={0,0,127}));
  connect(p_air1.y, den2.p)
    annotation (Line(points={{210,127},{210,137}},
                                                 color={0,0,127}));
  connect(x_pTphi1.X[1],den2. X_w) annotation (Line(points={{178,119},{178,129},
          {202,129},{202,137}},                     color={0,0,127}));
  connect(combiTimeTable1.y[3],x_pTphi1. T)
    annotation (Line(points={{195,88},{178,88},{178,96}},    color={0,0,127}));
  connect(combiTimeTable1.y[3],den2. T) annotation (Line(points={{195,88},{194,88},
          {194,137}},                          color={0,0,127}));
  connect(combiTimeTable1.y[3], bou2.T_in)
    annotation (Line(points={{195,88},{156,88},{156,136},{144,136},{144,128}},
                                                            color={0,0,127}));
  connect(combiTimeTable1.y[4],x_pTphi1. phi)
    annotation (Line(points={{195,88},{172,88},{172,96}},    color={0,0,127}));
  connect(desorber.port_b,bou3. ports[1])
    annotation (Line(points={{34,16},{-42,16},{-42,194}},
                                                       color={0,127,255}));
  connect(bou2.ports[1], desorber.port_a)
    annotation (Line(points={{140,106},{140,16},{54,16}},color={0,127,255}));
  connect(sorptionExchange.mAbs_reg, desorberTank.m_reg) annotation (Line(
        points={{22.2476,-45.15},{58,-45.15},{58,-24},{54.6,-24}},
                                                                color={0,0,127}));
  connect(absorberTank.T_out, sorptionExchange.TAbs_in) annotation (Line(points={{55.6,
          -122},{-24,-122},{-24,-41.9},{-4,-41.9}},    color={0,0,127}));
  connect(absorberTank.x_out, sorptionExchange.xAbs_in) annotation (Line(points={{55.6,
          -128},{-22,-128},{-22,-45.8},{-4,-45.8}},  color={0,0,127}));
  connect(absorberTank.L_out, sorptionExchange.LAbs_in) annotation (Line(points={{55.6,
          -134},{-20,-134},{-20,-49.7},{-4,-49.7}},
                                           color={0,0,127}));
  connect(sorptionExchange.TAbs, absorber_dp_plot.Ts_in) annotation (Line(
        points={{22.1238,-54.25},{34,-54.25},{34,-86},{55.4,-86}},
                                                                color={0,0,127}));
  connect(sorptionExchange.xAbs, absorber_dp_plot.x_in) annotation (Line(points={{22.1238,
          -60.75},{32,-60.75},{32,-90},{55.4,-90}},       color={0,0,127}));
  connect(sorptionExchange.LAbs, absorber_dp_plot.L_i) annotation (Line(points={{22.1238,
          -57.5},{30,-57.5},{30,-99},{55.4,-99}},        color={0,0,127}));
  connect(sorptionExchange.mReg,absorberTank. m_reg) annotation (Line(points={{14.0762,
          -64.13},{14.0762,-140},{88,-140},{88,-136},{76.6,-136}},       color=
          {0,0,127}));
  connect(sorptionExchange.TReg,absorberTank. T_reg) annotation (Line(points={{10.2381,
          -64.13},{10.2381,-144},{92,-144},{92,-130},{76.6,-130}},       color=
          {0,0,127}));
  connect(sorptionExchange.TAbs_reg, desorberTank.T_reg) annotation (Line(
        points={{22.2476,-42.55},{62,-42.55},{62,-18},{54.6,-18}},
                                                                color={0,0,127}));
  connect(sorptionExchange.xDes,absorberTank. x_reg) annotation (Line(points={{5.40952,
          -64.26},{5.40952,-142},{90,-142},{90,-133},{76.6,-133}},       color=
          {0,0,127}));
  connect(sorptionExchange.xAbs, desorberTank.x_reg) annotation (Line(points={{22.1238,
          -60.75},{60,-60.75},{60,-21},{54.6,-21}},
                                              color={0,0,127}));
  connect(desorber.Ts_out, desorberTank.T_in) annotation (Line(points={{33.8,23},
          {26,23},{26,0},{58,0},{58,-8},{54.6,-8}}, color={0,0,127}));
  connect(desorber.x_out, desorberTank.x_in) annotation (Line(points={{33.8,19},
          {28,19},{28,-2},{60,-2},{60,-11},{54.6,-11}},
                                                   color={0,0,127}));
  connect(desorber.L_out, desorberTank.L) annotation (Line(points={{33.8,9},{30,
          9},{30,-4},{62,-4},{62,-14},{54.6,-14}},
                                             color={0,0,127}));
  connect(desorberTank.T_out, sorptionExchange.TDes_in) annotation (Line(points={{33.6,
          -10},{4.66667,-10},{4.66667,-38}},     color={0,0,127}));
  connect(desorberTank.x_out, sorptionExchange.xDes_in) annotation (Line(points={{33.6,
          -16},{8.38095,-16},{8.38095,-38}},   color={0,0,127}));
  connect(desorberTank.L_out, sorptionExchange.LDes_in) annotation (Line(points={{33.6,
          -22},{12.0952,-22},{12.0952,-38}},     color={0,0,127}));
  connect(sorptionExchange.TDes, desorber.Ts_in) annotation (Line(points={{-2.14286,
          -64.13},{-2.14286,-78},{84,-78},{84,24},{54.6,24}},color={0,0,127}));
  connect(sorptionExchange.LDes, desorber.L_i) annotation (Line(points={{1.57143,
          -64.26},{1.57143,-76},{76,-76},{76,11},{54.6,11}}, color={0,0,127}));
  connect(sorptionExchange.xDes, desorber.x_in) annotation (Line(points={{5.40952,
          -64.26},{5.40952,-74},{80,-74},{80,20},{54.6,20}}, color={0,0,127}));
  connect(integerExpression.y, valve_Y15.M_in) annotation (Line(points={{-149,170},
          {-130,170},{-130,182},{-110.8,182}}, color={255,127,0}));
  connect(integerExpression.y, valve_Y16.M_in) annotation (Line(points={{-149,170},
          {-130,170},{-130,154},{-110.8,154}}, color={255,127,0}));
  connect(evaY16.y, sorptionExchange.Y16) annotation (Line(points={{-57.4,154},
          {15.8095,154},{15.8095,-38}},color={0,0,127}));
  connect(valve_Y10.Close, y10_evaluation.Y_closed)
    annotation (Line(points={{-89.2,136},{-78.6,136}}, color={255,0,255}));
  connect(valve_Y10.Control, y10_evaluation.Y_control)
    annotation (Line(points={{-89.4,130},{-78.6,130}}, color={255,0,255}));
  connect(sorptionExchange.TDes, y10_evaluation.MeasuredValue) annotation (Line(
        points={{-2.14286,-64.13},{-2.14286,-72},{-86,-72},{-86,123},{-78.6,123}},
        color={0,0,127}));
  connect(y10_evaluation.y, sorptionExchange.Y10) annotation (Line(points={{-57.4,
          130},{0.952381,130},{0.952381,-38}}, color={0,0,127}));
  connect(integerExpression.y, pumpN07.M_in) annotation (Line(points={{-149,170},
          {-130,170},{-130,66},{-110.8,66}}, color={255,127,0}));
  connect(integerExpression.y, pumpN08.M_in) annotation (Line(points={{-149,170},
          {-130,170},{-130,46},{-110.8,46}}, color={255,127,0}));
  connect(integerExpression.y, pumpN05.M_in) annotation (Line(points={{-149,170},
          {-130,170},{-130,100},{-110.8,100}}, color={255,127,0}));
  connect(pumpN05.signal_pump, sorptionExchange.P05) annotation (Line(points={{-89.2,
          100},{-2.7619,100},{-2.7619,-38}}, color={255,0,255}));
  connect(pumpN07.signal_pump, sorptionExchange.P07) annotation (Line(points={{-89.2,
          66},{-54,66},{-54,-60.1},{-4,-60.1}}, color={255,0,255}));
  connect(pumpN07.signal_pump, absorber_dp_plot.Pump) annotation (Line(points={{
          -89.2,66},{-54,66},{-54,-112},{66,-112},{66,-104}}, color={255,0,255}));
  connect(pumpN07.signal_pump, absorberTank.Pump) annotation (Line(points={{-89.2,
          66},{-54,66},{-54,-112},{66,-112},{66,-118}}, color={255,0,255}));
  connect(pumpN08.signal_pump, sorptionExchange.P08) annotation (Line(points={{-89.2,
          46},{20,46},{20,0},{19.5238,0},{19.5238,-38}}, color={255,0,255}));
  connect(pumpN08.signal_pump, desorber.Pump) annotation (Line(points={{-89.2,46},
          {20,46},{20,0},{44,0},{44,6}}, color={255,0,255}));
  connect(pumpN08.signal_pump, desorberTank.Pump) annotation (Line(points={{-89.2,
          46},{20,46},{20,0},{44,0},{44,-6}}, color={255,0,255}));
  connect(integerExpression.y, valve_Y10.M_in) annotation (Line(points={{-149,170},
          {-130,170},{-130,130},{-110.8,130}}, color={255,127,0}));
  connect(eva_Y15.y, sorptionExchange.Y15) annotation (Line(points={{-59.4,182},
          {-12,182},{-12,-53.6},{-4,-53.6}}, color={0,0,127}));
  connect(valve_Y15.valve_closed, eva_Y15.Y_closed) annotation (Line(points={{-89.4,
          187},{-84.7,187},{-84.7,189},{-80.6,189}}, color={255,0,255}));
  connect(valve_Y15.valve_Single, eva_Y15.Y_DesControl) annotation (Line(points=
         {{-89.4,182},{-84,182},{-84,184},{-80.6,184}}, color={255,0,255}));
  connect(valve_Y15.valve_AbsDes, eva_Y15.Y_AbsDesControl) annotation (Line(
        points={{-89.4,177},{-83.7,177},{-83.7,179},{-80.6,179}}, color={255,0,
          255}));
  connect(valve_Y16.valve_closed, evaY16.Y_closed) annotation (Line(points={{-89.4,
          159},{-84,159},{-84,161},{-78.6,161}},     color={255,0,255}));
  connect(valve_Y16.valve_Single, evaY16.Y_AbsControl) annotation (Line(points=
          {{-89.4,154},{-84,154},{-84,156},{-78.6,156}}, color={255,0,255}));
  connect(valve_Y16.valve_AbsDes, evaY16.Y_DesControl) annotation (Line(points=
          {{-89.4,149},{-84,149},{-84,151},{-78.6,151}}, color={255,0,255}));
  connect(absorberTank.m_storage, evaY16.tankMassAbs) annotation (Line(points={
          {55.6,-137},{-134,-137},{-134,148},{-78.6,148}}, color={0,0,127}));
  connect(desorberTank.m_storage,eva_Y15.tankMassAbs)  annotation (Line(points=
          {{33.6,-25},{-134,-25},{-134,175},{-80.6,175}}, color={0,0,127}));
  connect(desorberTank.x_out,evaY16.xAbs)  annotation (Line(points={{33.6,-16},{
          -84,-16},{-84,145},{-78.6,145}}, color={0,0,127}));
  annotation (experiment(StopTime=18000, Interval=10),
    Diagram(coordinateSystem(extent={{-220,-220},{220,220}})),
    Icon(coordinateSystem(extent={{-220,-220},{220,220}})));
end TestSorption;
