within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler2

  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

  parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TColdNom=273.15 + 35
                                                             "Return temperature TCold"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Thermal dimension power"
   annotation (Dialog(group="Nominal condition"));
  parameter Boolean m_flowVar=false "Use variable water massflow"
  annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Boolean Pump=true "Model includes a pump"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));


  parameter Boolean Advanced=false "dTWater is constant for different PLR"
  annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
   annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.Units.SI.Temperature THotMax=273.15 + 90
                                                            "Maximal temperature to force shutdown";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  parameter Modelica.Units.SI.Temperature TStart=273.15 + 20
                                                           "T start"
   annotation (Dialog(tab="Advanced"));



   parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0
     "Guess value of dp = port_a.p - port_b.p"
     annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
     "Guess value of m_flow = port_a.m_flow"
     annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
     "Start value of pressure"
     annotation (Dialog(tab="Advanced", group="Initialization"));


  Fluid.BoilerCHP.BoilerNotManufacturer
                        heatGeneratorNoControl(
    allowFlowReversal=true,
    T_start=TStart,
    dTWaterSet=dTWaterSet,
    QNom=QNom,
    PLRMin=PLRMin,
    redeclare package Medium = Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    dTWaterNom=dTWaterNom,
    TColdNom=TColdNom,
    m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=true,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCold(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=true,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-84,0})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{46,36},{58,48}})));

  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Blocks.Sources.RealExpression one1(y=QNom/Medium.cp_const/dTWaterNom)
    annotation (Placement(transformation(extent={{-216,126},{-106,150}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom1(y=dTWaterNom)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{-78,42},{-52,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    p(start=Medium.p_default),
    redeclare final package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  Fluid.Sensors.TemperatureTwoPort senTColdTWW(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,-90})));
  Fluid.Sensors.MassFlowRate senMasFloTWW(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{-64,-100},{-46,-80}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom2(y=TColdNom)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{32,-128},{58,-112}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = AixLib.Media.Water,
    redeclare package Medium2 = AixLib.Media.Water,
    m1_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    m2_flow_nominal=QNom/(Medium.cp_const*50),
    dp1_nominal=6000,
    dp2_nominal=6000,
    eps=1) annotation (Placement(transformation(extent={{-6,-60},{-28,-40}})));
  AixLib.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PID)
    annotation (Placement(transformation(extent={{122,-32},{142,-12}})));
  Fluid.Sensors.TemperatureTwoPort senTHotTWW(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={48,-92})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    p(start=Medium.p_default),
    redeclare final package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-102},{90,-82}})));
  Fluid.Sensors.TemperatureTwoPort senTColdFeedback(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{9,-10},{-9,10}},
        rotation=0,
        origin={-69,-44})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom4(y=1)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{90,-132},{110,-110}})));
  Fluid.Sensors.MassFlowRate senMasFloBypass(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{50,-54},{30,-34}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{102,-26},{110,-18}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{90,-60},{98,-52}})));
  Modelica.Blocks.Logical.Switch positionBypass annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={178,-102})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
    annotation (Placement(transformation(extent={{-10,-118},{10,-98}})));
  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val1(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    verifyFlowReversal=true,
    use_inputFilter=false,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    dpValve_nominal=6000,
    fraK=1,
    R=100) annotation (Placement(transformation(extent={{66,-6},{50,6}})));
  Fluid.Movers.SpeedControlled_y fan(redeclare package Medium =
        AixLib.Media.Water, redeclare
      AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per)
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  AixLib.Controls.Continuous.LimPID conPID1(controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=1,
    Ti=5,
    Td=1,
    yMin=0.01)
    annotation (Placement(transformation(extent={{-66,128},{-46,148}})));
  Fluid.Sensors.MassFlowRate senMasFloHeizkreis(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{-36,-10},{-20,10}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=QNom/(Medium.cp_const*50),
    dpValve_nominal=6000,
    R=100) "Durchflussbegrenzer"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-36,-70})));
  AixLib.Controls.Continuous.LimPID conPID2(controllerType=Modelica.Blocks.Types.SimpleController.PID)
    "ControlUnit_Durchflussbegrenzer"
    annotation (Placement(transformation(extent={{-182,-54},{-162,-34}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom3(y=QNom/(Medium.cp_const*50))
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{-352,-68},{-214,-34}})));
  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val2(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    verifyFlowReversal=true,
    use_inputFilter=false,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    dpValve_nominal=6000,
    fraK=1,
    R=100) annotation (Placement(transformation(extent={{88,-6},{74,6}})));
  AixLib.Controls.Continuous.LimPID conPID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=1138.2,
    yMin=0.1)
    annotation (Placement(transformation(extent={{44,86},{64,106}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom6(y=333.15)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{14,124},{34,138}})));
  Fluid.Sensors.MassFlowRate senMasFloBypass1(redeclare final package Medium =
        Media.Water, final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{-6,-38},{-26,-18}})));
protected
   parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.Units.SI.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
   replaceable package MediumBoiler =Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));



equation


  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));

  if Pump==false then
  else
  end if;

  connect(senTHot.port_a, heatGeneratorNoControl.port_b)
    annotation (Line(points={{20,0},{10,0}}, color={0,127,255}));
  connect(port_a, senTCold.port_a)
    annotation (Line(points={{-100,0},{-94,0}}, color={0,127,255}));
  connect(heatGeneratorNoControl.PowerDemand, integrator1.u) annotation (Line(
        points={{11,-7},{11,42},{44.8,42}},        color={0,0,127}));

  connect(integrator1.y, boilerControlBus.EnergyDemand) annotation (Line(points={{58.6,42},
          {62,42},{62,54},{0.05,54},{0.05,100.05}},                   color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senTHot.T, boilerControlBus.THot) annotation (Line(points={{30,11},{
          30,62},{0.05,62},{0.05,100.05}},                  color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dTWaterNom1.y, heatGeneratorNoControl.dTWater) annotation (Line(
        points={{-50.7,51},{-20,51},{-20,14},{-12,14},{-12,9}},
                                                       color={0,0,127}));
  connect(heatGeneratorNoControl.PowerDemand, boilerControlBus.PowerDemand)
    annotation (Line(points={{11,-7},{16,-7},{16,-18},{0.05,-18},{0.05,100.05}},
                                                                          color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_a1, senTColdTWW.port_a)
    annotation (Line(points={{-100,-90},{-92,-90}}, color={0,127,255}));
  connect(senTColdTWW.port_b, senMasFloTWW.port_a)
    annotation (Line(points={{-72,-90},{-64,-90}}, color={0,127,255}));
  connect(senTHotTWW.port_b, port_b1)
    annotation (Line(points={{58,-92},{100,-92}}, color={0,127,255}));
  connect(hex.port_b2, senTHotTWW.port_a) annotation (Line(points={{-6,-56},{28,
          -56},{28,-92},{38,-92}}, color={0,127,255}));
  connect(hex.port_b1, senTColdFeedback.port_a)
    annotation (Line(points={{-28,-44},{-60,-44}}, color={0,127,255}));
  connect(senMasFloBypass.port_b, hex.port_a1) annotation (Line(points={{30,-44},
          {-6,-44}},                                     color={0,127,255}));
  connect(dTWaterNom2.y, gain.u) annotation (Line(points={{59.3,-120},{64,-120},
          {64,-66},{76,-66},{76,-30},{100,-30},{100,-26},{101.2,-26},{101.2,-22}},
                             color={0,0,127}));
  connect(gain.y, conPID.u_s)
    annotation (Line(points={{110.4,-22},{120,-22}}, color={0,0,127}));
  connect(senTHotTWW.T, gain1.u)
    annotation (Line(points={{48,-81},{48,-74},{84,-74},{84,-56},{89.2,-56}},
                                                            color={0,0,127}));
  connect(gain1.y, conPID.u_m) annotation (Line(points={{98.4,-56},{118,-56},{
          118,-34},{132,-34}},
                     color={0,0,127}));
  connect(conPID.y, positionBypass.u1) annotation (Line(points={{143,-22},{154,
          -22},{154,-48},{148,-48},{148,-78},{156,-78},{156,-94},{166,-94}},
                                        color={0,0,127}));
  connect(dTWaterNom4.y, positionBypass.u3) annotation (Line(points={{111,-121},
          {112,-121},{118,-121},{118,-110},{166,-110}},
                                                     color={0,0,127}));
  connect(senMasFloTWW.m_flow, greaterThreshold.u) annotation (Line(points={{-55,-79},
          {-68,-79},{-68,-108},{-12,-108}},             color={0,0,127}));
  connect(greaterThreshold.y, positionBypass.u2) annotation (Line(points={{11,-108},
          {68,-108},{68,-102},{86,-102},{86,-106},{116,-106},{116,-102},{166,
          -102}},                                  color={255,0,255}));
  connect(senTHot.port_b, val1.port_2)
    annotation (Line(points={{40,0},{50,0}}, color={0,127,255}));
  connect(val1.port_3, senMasFloBypass.port_a)
    annotation (Line(points={{58,-6},{62,-6},{62,-44},{50,-44}},
                                                          color={0,127,255}));
  connect(senTCold.port_b, fan.port_a)
    annotation (Line(points={{-74,0},{-68,0}}, color={0,127,255}));
  connect(positionBypass.y, val1.y) annotation (Line(points={{189,-102},{118,
          -102},{118,-108},{70,-108},{70,-102},{190,-102},{190,-38},{172,-38},{
          172,14},{58,14},{58,7.2}}, color={0,0,127}));
  connect(boilerControlBus.PLR, heatGeneratorNoControl.PLR) annotation (Line(
      points={{0.05,100.05},{0.05,28},{-12,28},{-12,5.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senMasFloTWW.port_b, val.port_a) annotation (Line(points={{-46,-90},{
          -36,-90},{-36,-80}},
                 color={0,127,255}));
  connect(val.port_b, hex.port_a2) annotation (Line(points={{-36,-60},{-36,-56},
          {-28,-56}},                                     color={0,127,255}));
  connect(conPID2.y, val.y) annotation (Line(points={{-161,-44},{-96,-44},{-96,
          -70},{-48,-70}},
                      color={0,0,127}));
  connect(senMasFloTWW.m_flow, conPID2.u_m) annotation (Line(points={{-55,-79},
          {-114,-79},{-114,-68},{-172,-68},{-172,-56}},
                                                      color={0,0,127}));
  connect(conPID2.u_s, dTWaterNom3.y)
    annotation (Line(points={{-184,-44},{-120,-44},{-120,-51},{-207.1,-51}},
                                                       color={0,0,127}));
  connect(senMasFloHeizkreis.port_b, heatGeneratorNoControl.port_a)
    annotation (Line(points={{-20,0},{-10,0}},color={0,127,255}));
  connect(senMasFloHeizkreis.m_flow, conPID1.u_m) annotation (Line(points={{-28,11},
          {-28,114},{-56,114},{-56,126}},          color={0,0,127}));
  connect(one1.y, conPID1.u_s)
    annotation (Line(points={{-100.5,138},{-68,138}}, color={0,0,127}));
  connect(fan.port_b, senMasFloHeizkreis.port_a)
    annotation (Line(points={{-48,0},{-36,0}},          color={0,127,255}));
  connect(conPID1.y, fan.y) annotation (Line(points={{-45,138},{-32,138},{-32,
          24},{-58,24},{-58,12}}, color={0,0,127}));
  connect(boilerControlBus.OnOff, heatGeneratorNoControl.OnOff) annotation (
      Line(
      points={{0.05,100.05},{0.05,38},{-24,38},{-24,8},{-21.6,8},{-21.6,7.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(port_b, val2.port_1)
    annotation (Line(points={{100,0},{88,0}}, color={0,127,255}));
  connect(val1.port_1, val2.port_2)
    annotation (Line(points={{66,0},{74,0}}, color={0,127,255}));
  connect(senTCold.T, conPID3.u_m) annotation (Line(points={{-84,11},{-84,74},{
          54,74},{54,84}}, color={0,0,127}));
  connect(dTWaterNom6.y, conPID3.u_s) annotation (Line(points={{35,131},{44,131},
          {44,114},{30,114},{30,96},{42,96}}, color={0,0,127}));
  connect(val2.port_3, senMasFloBypass1.port_a)
    annotation (Line(points={{81,-6},{81,-28},{-6,-28}}, color={0,127,255}));
  connect(senMasFloBypass1.port_b, fan.port_a)
    annotation (Line(points={{-26,-28},{-68,-28},{-68,0}}, color={0,127,255}));
  connect(senTCold.T, boilerControlBus.TCold) annotation (Line(points={{-84,11},
          {-84,86},{0.05,86},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatGeneratorNoControl.TColdBoiler, boilerControlBus.TColdCC)
    annotation (Line(points={{11,-7},{14,-7},{14,100.05},{0.05,100.05}}, color=
          {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID3.y, val2.y) annotation (Line(points={{65,96},{124,96},{124,32},
          {81,32},{81,7.2}}, color={0,0,127}));
  connect(senTColdFeedback.port_b, senTCold.port_a)
    annotation (Line(points={{-78,-44},{-94,-44},{-94,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),
        Polygon(
          points={{-18.5,-23.5},{-26.5,-7.5},{-4.5,36.5},{3.5,10.5},{25.5,14.5},
              {15.5,-27.5},{-2.5,-23.5},{-8.5,-23.5},{-18.5,-23.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-16.5,-21.5},{-6.5,-1.5},{19.5,-21.5},{-6.5,-21.5},{-16.5,-21.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26.5,-21.5},{27.5,-29.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>A boiler model consisting of physical components. The user has the choice to run the model for three different setpoint options:</p>
<ol>
<li>Setpoint depends on part load ratio (water mass flow=dimension water mass flow; advanced=false &amp; m_flowVar=false)</li>
<li>Setpoint depends on part load ratio and a constant water temperature difference which is idependent from part load ratio (water mass flow is variable; advanced=false &amp; m_flowVar=true)</li>
<li>Setpoint depends on part load ratio an a variable water temperature difference (water mass flow is variable; advanced=true)</li>
</ol>
</html>"),
    experiment(StopTime=10));
end ModularBoiler2;
