within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model TWWAdd_on

 parameter Modelica.Units.SI.TemperatureDifference dT_w_nom=20 "nom,inal temperature difference of flow and return"
   annotation (Dialog(group="Nominal condition"),Evaluate=false);
  parameter Modelica.Units.SI.Temperature DesRetT=308.15
    "nominal return temperature"
   annotation (Dialog(group="Nominal condition"),Evaluate=false);


 parameter Modelica.Units.SI.Temperature T_w_hot=333.15      "Set point temperature drinking water outlet";
 parameter Modelica.Units.SI.Temperature T_w_cold=283.15 "Default temperature drinking water inlet";
 parameter Modelica.Units.SI.HeatFlowRate Q_nom=50000 "Thermal dimension power"
   annotation (Dialog(group="Nominal condition"),Evaluate=false);

  parameter Modelica.Units.SI.TemperatureDifference dT_w_set=15 "Temperature difference setpoint"
   annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));


  parameter Real PLR_min=0.15 "Minimal Part Load Ratio";

  parameter Modelica.Units.SI.Temperature T_start=273.15 + 20
                                                           "starting temperature"
   annotation (Dialog(tab="Advanced"));

   package Medium = AixLib.Media.Water;





  Fluid.Sensors.TemperatureTwoPort senT_DW_in(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=Q_nom/(Medium.cp_const*(T_w_hot - T_w_cold)),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001) "Temperature sensor drinking water inlet"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,-40})));
  Fluid.Sensors.MassFlowRate senMasFloDhw(redeclare final package Medium =
        AixLib.Media.Water) "Sensor for mass flow rate domestic hot water"
    annotation (Placement(transformation(extent={{-44,-30},{-24,-50}})));
  Modelica.Blocks.Sources.RealExpression hotDWTem(y=T_w_hot)
    "hot drinking water temperature"
    annotation (Placement(transformation(extent={{20,14},{46,40}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = AixLib.Media.Water,
    redeclare package Medium2 = AixLib.Media.Water,
    m1_flow_nominal=Q_nom/(Medium.cp_const*dT_w_nom),
    m2_flow_nominal=Q_nom/(Medium.cp_const*(T_w_hot - T_w_cold)),
    dp1_nominal=0,
    dp2_nominal=0,
    eps=1) "Heat exchanger" annotation (Placement(transformation(extent={{12,44},{-10,64}})));
  Fluid.Sensors.TemperatureTwoPort senT_DW_out(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=Q_nom/(Medium.cp_const*(T_w_hot - T_w_cold)),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001) "Temperature sensor drinking water outlet"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={32,-40})));
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
  Modelica.Blocks.Sources.RealExpression valDWposClosed(y=1)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{50,-106},{70,-84}})));
  Fluid.Sensors.MassFlowRate senMasFloBypass(redeclare final package Medium =
        AixLib.Media.Water)
    "Sensor for mass flow rate"
    annotation (Placement(transformation(extent={{68,50},{48,70}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{40,-28},{48,-20}})));
  Modelica.Blocks.Logical.Switch positionBypass annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={86,-12})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
    annotation (Placement(transformation(extent={{28,-82},{48,-62}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=true,
    m_flow_nominal=Q_nom/(Medium.cp_const*(T_w_hot - T_w_cold)),
    dpValve_nominal=6000,
    use_inputFilter=false,
    R=100) "flow limiter limiting water massflow "
    annotation (Placement(transformation(extent={{-10,10},{12,-12}},
        rotation=90,
        origin={-16,0})));
  AixLib.Controls.Continuous.LimPID conPID2(controllerType=Modelica.Blocks.Types.SimpleController.PI)
    "ControlUnit_Durchflussbegrenzer"
    annotation (Placement(transformation(extent={{-28,-90},{-8,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_DW(p(start=Medium.p_default),
      redeclare final package Medium = AixLib.Media.Water)
    "drinking water inlet"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  AixLib.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PI)
    annotation (Placement(transformation(extent={{44,-14},{64,6}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_DW(p(start=Medium.p_default),
      redeclare final package Medium = AixLib.Media.Water)
    "drinking water outlet"
    annotation (Placement(transformation(extent={{110,-50},{90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_feedback(p(start=Medium.p_default),
      redeclare final package Medium = AixLib.Media.Water)
    "heat supply from the boiler"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_feedback(p(start=Medium.p_default),
      redeclare final package Medium = AixLib.Media.Water)
    "flow feedback to the boiler"
    annotation (Placement(transformation(extent={{-90,50},{-110,70}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{52,22},{62,32}})));
  Modelica.Blocks.Interfaces.RealOutput valDWpos
    "Position of DW-Three-Way-Valve" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  Modelica.Blocks.Sources.RealExpression desRetT(y=DesRetT)
    "design return temperature"
    annotation (Placement(transformation(extent={{-92,-92},{-66,-66}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-54,-84},{-44,-74}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
    annotation (Placement(transformation(extent={{-56,-104},{-44,-92}})));
  Modelica.Blocks.Interfaces.BooleanOutput dhwOnOff
    "On-Off Signal domestic hot water" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,110})));
equation
  connect(port_a_DW, senT_DW_in.port_a)
    annotation (Line(points={{-100,-40},{-82,-40}}, color={0,127,255}));
  connect(senT_DW_in.port_b,senMasFloDhw. port_a)
    annotation (Line(points={{-62,-40},{-44,-40}}, color={0,127,255}));
  connect(senT_DW_out.port_b, port_b_DW)
    annotation (Line(points={{42,-40},{100,-40}}, color={0,127,255}));
  connect(hex.port_b2, senT_DW_out.port_a) annotation (Line(points={{12,48},{18,
          48},{18,-40},{22,-40}}, color={0,127,255}));
  connect(hex.port_b1,senTColdFeedback. port_a)
    annotation (Line(points={{-10,60},{-42,60}},   color={0,127,255}));
  connect(senMasFloBypass.port_b,hex. port_a1) annotation (Line(points={{48,60},
          {12,60}},                                      color={0,127,255}));
  connect(hotDWTem.y, gain.u)
    annotation (Line(points={{47.3,27},{51,27}}, color={0,0,127}));
  connect(senT_DW_out.T, gain1.u)
    annotation (Line(points={{32,-29},{32,-24},{39.2,-24}}, color={0,0,127}));
  connect(gain1.y,conPID. u_m) annotation (Line(points={{48.4,-24},{54,-24},{54,
          -16}},     color={0,0,127}));
  connect(conPID.y,positionBypass. u1) annotation (Line(points={{65,-4},{74,-4}},
                                        color={0,0,127}));
  connect(valDWposClosed.y, positionBypass.u3) annotation (Line(points={{71,-95},
          {78,-95},{78,-36},{68,-36},{68,-20},{74,-20}}, color={0,0,127}));
  connect(senMasFloDhw.m_flow,greaterThreshold. u) annotation (Line(points={{-34,-51},
          {-34,-62},{20,-62},{20,-72},{26,-72}},        color={0,0,127}));
  connect(greaterThreshold.y,positionBypass. u2) annotation (Line(points={{49,-72},
          {66,-72},{66,-12},{74,-12}},             color={255,0,255}));
  connect(senMasFloDhw.port_b,val. port_a) annotation (Line(points={{-24,-40},{-15,
          -40},{-15,-10}},
                 color={0,127,255}));
  connect(val.port_b,hex. port_a2) annotation (Line(points={{-15,12},{-15,48},{-10,
          48}},                                           color={0,127,255}));
  connect(conPID2.y,val. y) annotation (Line(points={{-7,-80},{8,-80},{8,1},{
          -1.8,1}},   color={0,0,127}));
  connect(senTColdFeedback.port_b, port_b_feedback)
    annotation (Line(points={{-60,60},{-100,60}}, color={0,127,255}));
  connect(senMasFloBypass.port_a, port_a_feedback)
    annotation (Line(points={{68,60},{100,60}}, color={0,127,255}));
  connect(gain.y, conPID.u_s)
    annotation (Line(points={{62.5,27},{70,27},{70,16},{24,16},{24,-4},{42,-4}},
                                                   color={0,0,127}));
  connect(positionBypass.y, valDWpos) annotation (Line(points={{97,-12},{100,
          -12},{100,110},{0,110}}, color={0,0,127}));
  connect(conPID2.u_s, gain2.y) annotation (Line(points={{-30,-80},{-32,-80},{
          -32,-79},{-43.5,-79}}, color={0,0,127}));
  connect(gain2.u, desRetT.y)
    annotation (Line(points={{-55,-79},{-64.7,-79}}, color={0,0,127}));
  connect(conPID2.u_m, gain3.y) annotation (Line(points={{-18,-92},{-18,-98},{
          -43.4,-98}}, color={0,0,127}));
  connect(gain3.u, senTColdFeedback.T) annotation (Line(points={{-57.2,-98},{
          -132,-98},{-132,94},{-51,94},{-51,71}}, color={0,0,127}));
  connect(greaterThreshold.y, dhwOnOff) annotation (Line(points={{49,-72},{138,
          -72},{138,82},{-40,82},{-40,110}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TWWAdd_on;
