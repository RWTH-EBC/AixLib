within AixLib.Airflow.AirHandlingUnit.Examples;
model TestSorptionBlock "testing sorption module"
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
        origin={202,-124})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumAir,
    T=301.75,
    nPorts=1)                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-186,-180})));
  Utilities.Psychrometrics.X_pTphi x_pTphi2(use_p_in=false) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={206,-160})));
  Modelica.Blocks.Sources.RealExpression T_air_inlet(y=32 + 273.15) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-208,-204})));
  Modelica.Blocks.Sources.RealExpression phi_air_inlet(y=0.4) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-184,-204})));
  Utilities.Psychrometrics.Density_pTX den1 annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={142,-142})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{144,-94},{164,-74}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={174,-114})));
  Modelica.Blocks.Sources.RealExpression Umrechnung_sek(y=3600) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={126,-90})));
  Modelica.Blocks.Sources.RealExpression Zu_Volumen(y=12510) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={126,-76})));
  Modelica.Blocks.Sources.RealExpression p_air(y=101325) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={132,-184})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,1,1,
        305.15,0.9; 18000,1,1,305.15,0.9])
    annotation (Placement(transformation(extent={{146,-220},{166,-200}})));
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
        origin={138,118})));
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
        rotation=180,
        origin={-82,18})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=22)
    annotation (Placement(transformation(extent={{-212,160},{-192,180}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.sorptionControl
    valve_Y15(
    Y_ConAbsDes(n=3, modes={7,22,23}),
    Y_ConSingle(n=8, modes={5,6,16,17,18,19,20,21}),
    Y_Close(n=12, modes={1,2,3,4,8,9,10,11,12,13,14,15}))
    annotation (Placement(transformation(extent={{-112,144},{-92,164}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.sorptionControl
    valve_Y16(
    Y_ConAbsDes(n=3, modes={7,22,23}),
    Y_ConSingle(n=3, modes={4,14,15}),
    Y_Close(n=17, modes={1,2,3,5,6,8,9,10,11,12,13,16,17,18,19,20,21}))
    annotation (Placement(transformation(extent={{-112,122},{-92,142}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.Y15_evaluationAdvanced
    eva_Y15 annotation (Placement(transformation(extent={{-80,142},{-60,162}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.Y16_evaluationAdvanced
    evaY16 annotation (Placement(transformation(extent={{-80,120},{-60,140}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.controlvalve2
                                     valve_Y10(Y_Close(n=12, modes={1,2,3,4,8,9,
          10,11,12,13,14,15}), Y_Control(n=11, modes={5,6,7,16,17,18,19,20,21,22,
          23})) "controlValve"
    annotation (Placement(transformation(extent={{-112,172},{-92,192}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.heaCoiEva
                                        y10_evaluation(
    k=0.04,
    Ti=240,
    Setpoint=64 + 273.15)
    annotation (Placement(transformation(extent={{-80,172},{-60,192}})));
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
  ComponentsAHU.sorptionPartialPressure sorptionPartialPressure(redeclare
      package Medium1 = MediumAir, redeclare package Medium2 = MediumAir)
    annotation (Placement(transformation(extent={{-14,-50},{26,34}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.bypassValve
                                valve_Y1(Y_Open(n=17, modes={1,2,3,5,6,8,9,10,
          11,12,13,16,17,18,19,20,21}), Y_Control(n=6, modes={4,7,14,15,22,23}))
    annotation (Placement(transformation(extent={{-112,196},{-92,216}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.bypassEva
    bypassEva
    annotation (Placement(transformation(extent={{-80,196},{-60,216}})));
  Fluid.Sensors.RelativeHumidityTwoPort phi_after(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of air after dehumidification"
    annotation (Placement(transformation(extent={{-150,-48},{-170,-28}})));
  Fluid.Sensors.RelativeHumidityTwoPort phi_before(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of air before dehumidification"
    annotation (Placement(transformation(extent={{110,-48},{90,-28}})));
  Fluid.Sensors.RelativeHumidityTwoPort phi_des_before(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    "Relative Humidity of air before humidification"
    annotation (Placement(transformation(extent={{88,8},{68,28}})));
  Fluid.Sensors.RelativeHumidityTwoPort phi_des_after(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    "Relative Humidity of air after humidification"
    annotation (Placement(transformation(extent={{-32,8},{-52,28}})));
equation
  connect(x_pTphi2.X, bou.X_in)
    annotation (Line(points={{206,-149},{206,-136}},
                                                   color={0,0,127}));
  connect(Zu_Volumen.y, division3.u1)
    annotation (Line(points={{137,-76},{140,-76},{140,-78},{142,-78}},
                                                 color={0,0,127}));
  connect(Umrechnung_sek.y, division3.u2)
    annotation (Line(points={{137,-90},{142,-90}},
                                                 color={0,0,127}));
  connect(product1.y, bou.m_flow_in) annotation (Line(points={{185,-114},{188,
          -114},{188,-134},{194,-134}},
                              color={0,0,127}));
  connect(division3.y, product1.u2) annotation (Line(points={{165,-84},{168,-84},
          {168,-102},{158,-102},{158,-108},{162,-108}},
                                                color={0,0,127}));
  connect(den1.d, product1.u1) annotation (Line(points={{142,-131},{142,-114},{
          162,-114},{162,-120}},
                        color={0,0,127}));
  connect(p_air.y, den1.p)
    annotation (Line(points={{132,-173},{132,-153},{134,-153}},
                                                             color={0,0,127}));
  connect(x_pTphi2.X[1], den1.X_w) annotation (Line(points={{206,-149},{206,
          -148},{156,-148},{156,-162},{142,-162},{142,-153}},
                                                    color={0,0,127}));
  connect(combiTimeTable2.y[3], x_pTphi2.T)
    annotation (Line(points={{167,-210},{206,-210},{206,-172}},
                                                             color={0,0,127}));
  connect(combiTimeTable2.y[3], den1.T) annotation (Line(points={{167,-210},{
          176,-210},{176,-172},{150,-172},{150,-153}},
                                               color={0,0,127}));
  connect(combiTimeTable2.y[3], bou.T_in) annotation (Line(points={{167,-210},{
          176,-210},{176,-142},{198,-142},{198,-136}},
                                                   color={0,0,127}));
  connect(combiTimeTable2.y[4], x_pTphi2.phi)
    annotation (Line(points={{167,-210},{212,-210},{212,-172}},
                                                             color={0,0,127}));
  connect(x_pTphi1.X, bou2.X_in)
    annotation (Line(points={{178,119},{178,130},{134,130}},
                                                         color={0,0,127}));
  connect(Zu_Volumen1.y, division1.u1)
    annotation (Line(points={{145,210},{162,210}}, color={0,0,127}));
  connect(Umrechnung_sek1.y, division1.u2)
    annotation (Line(points={{145,198},{162,198}}, color={0,0,127}));
  connect(product2.y, bou2.m_flow_in) annotation (Line(points={{167,170},{155,
          170},{155,128},{146,128}},
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
    annotation (Line(points={{195,88},{156,88},{156,136},{142,136},{142,130}},
                                                            color={0,0,127}));
  connect(combiTimeTable1.y[4],x_pTphi1. phi)
    annotation (Line(points={{195,88},{172,88},{172,96}},    color={0,0,127}));
  connect(integerExpression.y, valve_Y15.M_in) annotation (Line(points={{-191,
          170},{-130,170},{-130,154},{-112.8,154}},
                                               color={255,127,0}));
  connect(integerExpression.y, valve_Y16.M_in) annotation (Line(points={{-191,
          170},{-130,170},{-130,132},{-112.8,132}},
                                               color={255,127,0}));
  connect(valve_Y10.Close, y10_evaluation.Y_closed)
    annotation (Line(points={{-91.2,188},{-80.6,188}}, color={255,0,255}));
  connect(valve_Y10.Control, y10_evaluation.Y_control)
    annotation (Line(points={{-91.4,182},{-80.6,182}}, color={255,0,255}));
  connect(integerExpression.y, pumpN07.M_in) annotation (Line(points={{-191,170},
          {-130,170},{-130,66},{-110.8,66}}, color={255,127,0}));
  connect(integerExpression.y, pumpN08.M_in) annotation (Line(points={{-191,170},
          {-130,170},{-130,46},{-110.8,46}}, color={255,127,0}));
  connect(integerExpression.y, pumpN05.M_in) annotation (Line(points={{-191,170},
          {-130,170},{-130,100},{-110.8,100}}, color={255,127,0}));
  connect(integerExpression.y, valve_Y10.M_in) annotation (Line(points={{-191,
          170},{-130,170},{-130,182},{-112.8,182}},
                                               color={255,127,0}));
  connect(valve_Y15.valve_closed, eva_Y15.Y_closed) annotation (Line(points={{-91.4,
          159},{-80.6,159}},                         color={255,0,255}));
  connect(valve_Y15.valve_Single, eva_Y15.Y_DesControl)
    annotation (Line(points={{-91.4,154},{-80.6,154}}, color={255,0,255}));
  connect(valve_Y15.valve_AbsDes, eva_Y15.Y_AbsDesControl)
    annotation (Line(points={{-91.4,149},{-80.6,149}}, color={255,0,255}));
  connect(valve_Y16.valve_closed, evaY16.Y_closed) annotation (Line(points={{-91.4,
          137},{-86,137},{-86,139},{-80.6,139}},     color={255,0,255}));
  connect(valve_Y16.valve_Single, evaY16.Y_AbsControl) annotation (Line(points=
          {{-91.4,132},{-86,132},{-86,135},{-80.6,135}}, color={255,0,255}));
  connect(valve_Y16.valve_AbsDes, evaY16.Y_DesControl) annotation (Line(points=
          {{-91.4,127},{-86,127},{-86,131},{-80.6,131}}, color={255,0,255}));
  connect(integerExpression.y, valve_Y1.M_in) annotation (Line(points={{-191,
          170},{-130,170},{-130,206},{-112.8,206}}, color={255,127,0}));
  connect(valve_Y1.Open, bypassEva.Y_open)
    annotation (Line(points={{-91.4,212},{-80.6,212}}, color={255,0,255}));
  connect(valve_Y1.Control, bypassEva.Y_control)
    annotation (Line(points={{-91.4,206},{-80.6,206}}, color={255,0,255}));
  connect(sorptionPartialPressure.port_b2, phi_after.port_a)
    annotation (Line(points={{-14,-36},{-82,-36},{-82,-38},{-150,-38}},
                                                    color={0,127,255}));
  connect(phi_after.port_b, bou1.ports[1]) annotation (Line(points={{-170,-38},
          {-186,-38},{-186,-170}}, color={0,127,255}));
  connect(bypassEva.y, sorptionPartialPressure.Y06_opening) annotation (Line(
        points={{-59.4,206},{-12,206},{-12,34.8}}, color={0,0,127}));
  connect(eva_Y15.y, sorptionPartialPressure.Y15_opening) annotation (Line(
        points={{-59.4,152},{-1.6,152},{-1.6,34.8}}, color={0,0,127}));
  connect(y10_evaluation.y, sorptionPartialPressure.Y10_opening) annotation (
      Line(points={{-59.4,182},{-6.8,182},{-6.8,34.8}}, color={0,0,127}));
  connect(evaY16.y, sorptionPartialPressure.Y16_opening)
    annotation (Line(points={{-59.4,130},{4,130},{4,34.8}}, color={0,0,127}));
  connect(pumpN05.signal_pump, sorptionPartialPressure.P05) annotation (Line(
        points={{-89.2,100},{10,100},{10,34.8}}, color={255,0,255}));
  connect(pumpN07.signal_pump, sorptionPartialPressure.P07) annotation (Line(
        points={{-89.2,66},{17,66},{17,34.8}}, color={255,0,255}));
  connect(pumpN08.signal_pump, sorptionPartialPressure.P08) annotation (Line(
        points={{-89.2,46},{24,46},{24,34.8}}, color={255,0,255}));
  connect(phi_after.phi, bypassEva.phi_zu) annotation (Line(points={{-160.1,-27},
          {-160.1,28},{-156,28},{-156,199},{-80.6,199}}, color={0,0,127}));
  connect(sorptionPartialPressure.TDes, y10_evaluation.MeasuredValue)
    annotation (Line(points={{26.8,16},{34,16},{34,82},{-156,82},{-156,175},{
          -80.6,175}}, color={0,0,127}));
  connect(sorptionPartialPressure.massDesorberTank,eva_Y15.tankMassAbs)
    annotation (Line(points={{26.8,1.2},{34,1.2},{34,82},{-156,82},{-156,145},{
          -80.6,145}},  color={0,0,127}));
  connect(sorptionPartialPressure.massAbsorberTank, evaY16.tankMassAbs)
    annotation (Line(points={{26.8,-3},{34,-3},{34,82},{-156,82},{-156,127},{
          -80.6,127}}, color={0,0,127}));
  connect(sorptionPartialPressure.xDes,evaY16.xAbs)  annotation (Line(points={{26.8,
          11.2},{34,11.2},{34,82},{-156,82},{-156,124},{-80.6,124}},    color={
          0,0,127}));
  connect(bou.ports[1], phi_before.port_a) annotation (Line(points={{202,-114},
          {202,-38},{110,-38}}, color={0,127,255}));
  connect(phi_before.port_b, sorptionPartialPressure.port_a2)
    annotation (Line(points={{90,-38},{58,-38},{58,-36},{26,-36}},
                                                 color={0,127,255}));
  connect(bou2.ports[1], phi_des_before.port_a) annotation (Line(points={{138,
          108},{136,108},{136,18},{88,18}}, color={0,127,255}));
  connect(phi_des_before.port_b, sorptionPartialPressure.port_a1)
    annotation (Line(points={{68,18},{48,18},{48,20},{26,20}},
                                               color={0,127,255}));
  connect(sorptionPartialPressure.port_b1, phi_des_after.port_a)
    annotation (Line(points={{-14,20},{-24,20},{-24,18},{-32,18}},
                                                 color={0,127,255}));
  connect(phi_des_after.port_b, bou3.ports[1])
    annotation (Line(points={{-52,18},{-72,18}}, color={0,127,255}));
  annotation (experiment(StopTime=18000, Interval=10),
    Diagram(coordinateSystem(extent={{-220,-220},{220,220}})),
    Icon(coordinateSystem(extent={{-220,-220},{220,220}})));
end TestSorptionBlock;
