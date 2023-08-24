within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model TWWAdd_on

 parameter Modelica.Units.SI.TemperatureDifference dT_w_nom=20 "nom,inal temperature difference of flow and return"
   annotation (Dialog(group="Nominal condition"));
 parameter Modelica.Units.SI.Temperature T_cold_nom=273.15 + 35
                                                             "nominal return temperature"
   annotation (Dialog(group="Nominal condition"));


 parameter Modelica.Units.SI.Temperature T_w_hot=273.15 + 60 "Set point temperature drinking water outlet";
 parameter Modelica.Units.SI.Temperature T_w_cold=283.15 "Default temperature drinking water inlet";
 parameter Modelica.Units.SI.HeatFlowRate Q_nom=50000 "Thermal dimension power"
   annotation (Dialog(group="Nominal condition"));

  parameter Modelica.Units.SI.TemperatureDifference dT_w_set=15 "Temperature difference setpoint"
   annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));


  parameter Real PLR_min=0.15 "Minimal Part Load Ratio";

  parameter Modelica.Units.SI.Temperature T_start=273.15 + 20
                                                           "starting temperature"
   annotation (Dialog(tab="Advanced"));

   package Medium = AixLib.Media.Water;





  Fluid.Sensors.TemperatureTwoPort senTColdTWW(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=Q_nom/(Medium.cp_const*(T_w_hot - T_w_cold)),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,-40})));
  Fluid.Sensors.MassFlowRate senMasFloTWW(redeclare final package Medium =
        AixLib.Media.Water)
    "Sensor for mass flow rate"
    annotation (Placement(transformation(extent={{-44,-30},{-24,-50}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom2(y=T_w_hot)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{38,8},{86,32}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = AixLib.Media.Water,
    redeclare package Medium2 = AixLib.Media.Water,
    m1_flow_nominal=Q_nom/(Medium.cp_const*dT_w_nom),
    m2_flow_nominal=Q_nom/(Medium.cp_const*(T_w_hot - T_w_cold)),
    dp1_nominal=6000,
    dp2_nominal=6000,
    eps=1) "Heat exchanger" annotation (Placement(transformation(extent={{12,44},{-10,64}})));
  Fluid.Sensors.TemperatureTwoPort senTHotTWW(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=Q_nom/(Medium.cp_const*(T_w_hot - T_w_cold)),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={48,-40})));
  Fluid.Sensors.TemperatureTwoPort senTColdFeedback(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=Q_nom/(Medium.cp_const*dT_w_nom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{9,-10},{-9,10}},
        rotation=0,
        origin={-51,60})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom4(y=1)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{90,-90},{110,-68}})));
  Fluid.Sensors.MassFlowRate senMasFloBypass(redeclare final package Medium =
        AixLib.Media.Water)
    "Sensor for mass flow rate"
    annotation (Placement(transformation(extent={{68,50},{48,70}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{90,-18},{98,-10}})));
  Modelica.Blocks.Logical.Switch positionBypass annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={178,-60})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_nominal=Q_nom/(Medium.cp_const*(T_w_hot - T_w_cold)),
    dpValve_nominal=6000,
    R=100) "flow limiter"
    annotation (Placement(transformation(extent={{-10,10},{12,-12}},
        rotation=90,
        origin={-16,0})));
  AixLib.Controls.Continuous.LimPID conPID2(controllerType=Modelica.Blocks.Types.SimpleController.PI)
    "ControlUnit_Durchflussbegrenzer"
    annotation (Placement(transformation(extent={{-64,-80},{-46,-98}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom3(y=Q_nom/(Medium.cp_const*(
        T_w_hot - T_w_cold)))
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{-254,-106},{-100,-72}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    p(start=Medium.p_default),
    redeclare final package Medium =
        AixLib.Media.Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  AixLib.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PI)
    annotation (Placement(transformation(extent={{122,10},{142,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    p(start=Medium.p_default),
    redeclare final package Medium =
       AixLib.Media.Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-50},{90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
    p(start=Medium.p_default),
    redeclare final package Medium =
        AixLib.Media.Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{70,90},{90,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
    p(start=Medium.p_default),
    redeclare final package Medium =
       AixLib.Media.Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,90},{-90,110}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{102,16},{110,24}})));
  Modelica.Blocks.Interfaces.RealOutput TWW_Valve
    "Position of TWW Three-Way-Valve" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={164,70}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-70})));
equation
  connect(port_a1,senTColdTWW. port_a)
    annotation (Line(points={{-100,-40},{-82,-40}}, color={0,127,255}));
  connect(senTColdTWW.port_b,senMasFloTWW. port_a)
    annotation (Line(points={{-62,-40},{-44,-40}}, color={0,127,255}));
  connect(senTHotTWW.port_b,port_b1)
    annotation (Line(points={{58,-40},{100,-40}}, color={0,127,255}));
  connect(hex.port_b2,senTHotTWW. port_a) annotation (Line(points={{12,48},{32,48},
          {32,-40},{38,-40}},      color={0,127,255}));
  connect(hex.port_b1,senTColdFeedback. port_a)
    annotation (Line(points={{-10,60},{-42,60}},   color={0,127,255}));
  connect(senMasFloBypass.port_b,hex. port_a1) annotation (Line(points={{48,60},
          {12,60}},                                      color={0,127,255}));
  connect(dTWaterNom2.y, gain.u) annotation (Line(points={{88.4,20},{101.2,20}},
                             color={0,0,127}));
  connect(senTHotTWW.T,gain1. u)
    annotation (Line(points={{48,-29},{48,-14},{89.2,-14}}, color={0,0,127}));
  connect(gain1.y,conPID. u_m) annotation (Line(points={{98.4,-14},{132,-14},{132,
          8}},       color={0,0,127}));
  connect(conPID.y,positionBypass. u1) annotation (Line(points={{143,20},{154,20},
          {154,-6},{148,-6},{148,-36},{156,-36},{156,-52},{166,-52}},
                                        color={0,0,127}));
  connect(dTWaterNom4.y,positionBypass. u3) annotation (Line(points={{111,-79},{
          118,-79},{118,-68},{166,-68}},             color={0,0,127}));
  connect(senMasFloTWW.m_flow,greaterThreshold. u) annotation (Line(points={{-34,-51},
          {-34,-90},{-2,-90}},                          color={0,0,127}));
  connect(greaterThreshold.y,positionBypass. u2) annotation (Line(points={{21,-90},
          {84,-90},{84,-60},{166,-60}},            color={255,0,255}));
  connect(senMasFloTWW.port_b,val. port_a) annotation (Line(points={{-24,-40},{-15,
          -40},{-15,-10}},
                 color={0,127,255}));
  connect(val.port_b,hex. port_a2) annotation (Line(points={{-15,12},{-15,48},{-10,
          48}},                                           color={0,127,255}));
  connect(conPID2.y,val. y) annotation (Line(points={{-45.1,-89},{-4,-89},{-4,-38},
          {8,-38},{8,2},{-1.8,2},{-1.8,1}},
                      color={0,0,127}));
  connect(senMasFloTWW.m_flow,conPID2. u_m) annotation (Line(points={{-34,-51},{
          -34,-72},{-55,-72},{-55,-78.2}},            color={0,0,127}));
  connect(conPID2.u_s,dTWaterNom3. y)
    annotation (Line(points={{-65.8,-89},{-92.3,-89}}, color={0,0,127}));
  connect(senTColdFeedback.port_b, port_b2)
    annotation (Line(points={{-60,60},{-80,60},{-80,100}}, color={0,127,255}));
  connect(senMasFloBypass.port_a, port_a2)
    annotation (Line(points={{68,60},{80,60},{80,100}}, color={0,127,255}));
  connect(gain.y, conPID.u_s)
    annotation (Line(points={{110.4,20},{120,20}}, color={0,0,127}));
  connect(positionBypass.y, TWW_Valve) annotation (Line(points={{189,-60},{200,-60},
          {200,-58},{214,-58},{214,40},{142,40},{142,70},{164,70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TWWAdd_on;
