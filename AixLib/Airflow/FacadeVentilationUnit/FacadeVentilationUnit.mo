within AixLib.Airflow.FacadeVentilationUnit;
model FacadeVentilationUnit
  "Facade Ventilation Unit (FVU) equipped with a recuperator"

  parameter AixLib.Airflow.FacadeVentilationUnit.BaseClasses.FVUBaseRecord
    FVUParam=BaseClasses.FVUBaseRecord();

  parameter Modelica.SIunits.ThermodynamicTemperature T_start=273.15 + 20
    "Initial temperature in unit";

  replaceable package Water = Modelica.Media.Water.ConstantPropertyLiquidWater
    "Water Model in the system";
  replaceable package Air = AixLib.Media.Air "Air Model in the system";

protected
  parameter Real valveRiseTime=200;

public
  BaseClasses.SetPower fanExhaustAir(
    redeclare package Medium = Air,
    allowFlowReversal=true,
    noUnits=FVUParam.noUnits,
    m_flow_nominal=FVUParam.m2_flow_nominal_heater,
    T_start=T_start,
    p_start=FVUParam.p_default + res.dp_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-118,26})));
  BaseClasses.SetPower fanSupplyAir(
    redeclare package Medium = Air,
    noUnits=FVUParam.noUnits,
    m_flow_nominal=FVUParam.m2_flow_nominal_heater,
    p_start=FVUParam.p_default + FVUParam.dp2_nominal_heater + FVUParam.dp2_nominal_cooler)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={62,26})));
  Modelica.Fluid.Sensors.Temperature T_ExhaustAir(redeclare package Medium =
        Air)
    annotation (Placement(transformation(extent={{174,-58},{190,-46}})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness heater(
    redeclare package Medium2 = Air,
    redeclare package Medium1 = Water,
    m1_flow_nominal=FVUParam.m1_flow_nominal_heater,
    m2_flow_nominal=FVUParam.m2_flow_nominal_heater,
    dp1_nominal(displayUnit="Pa") = FVUParam.dp1_nominal_heater,
    dp2_nominal(displayUnit="Pa") = FVUParam.dp2_nominal_heater)
    annotation (Placement(transformation(extent={{116,22},{96,42}})));
  Modelica.Fluid.Interfaces.FluidPort_b OutgoingExhaustAir(redeclare package
      Medium = Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-170,16},{-150,36}})));
  Modelica.Fluid.Interfaces.FluidPort_a FreshAir(redeclare package Medium = Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-168,-78},{-148,-58}})));
  Modelica.Fluid.Interfaces.FluidPort_a ExhaustAir(redeclare package Medium =
        Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{192,-78},{212,-58}})));
  Modelica.Fluid.Interfaces.FluidPort_b SupplyAir(redeclare package Medium =
        Air)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{192,16},{212,36}})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness cooler(
    redeclare package Medium2 = Air,
    redeclare package Medium1 = Water,
    dp1_nominal(displayUnit="Pa") = FVUParam.dp1_nominal_cooler,
    dp2_nominal(displayUnit="Pa") = FVUParam.dp2_nominal_cooler,
    m1_flow_nominal=FVUParam.m1_flow_nominal_cooler,
    m2_flow_nominal=FVUParam.m2_flow_nominal_cooler)
    annotation (Placement(transformation(extent={{182,22},{162,42}})));
  Modelica.Fluid.Interfaces.FluidPort_b Heater_Return(redeclare package Medium
      = Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{82,90},{102,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Heater_Flow(redeclare package Medium =
        Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{112,90},{132,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Cooler_Return(redeclare package Medium
      = Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{152,90},{172,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Cooler_Flow(redeclare package Medium =
        Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{182,90},{202,110}})));
  Modelica.Fluid.Sensors.Temperature T_FreshAir(redeclare package Medium = Air)
    annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=180,
        origin={-140,-82})));
  Modelica.Fluid.Sensors.Temperature T_OutgoingExhaustAir(redeclare package
      Medium = Air) annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=0,
        origin={-134,44})));
  Modelica.Fluid.Sensors.Temperature T_SupplyAir(redeclare package Medium = Air)
    annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=180,
        origin={188,2})));
  Modelica.Fluid.Sensors.Temperature T_AfterHeatRecovery(redeclare package
      Medium = Air)
    annotation (Placement(transformation(extent={{-28,-10},{-12,2}})));

  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{-65,47},{-55,57}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=1) annotation (
      Placement(transformation(
        extent={{-6.5,-8},{6.5,8}},
        rotation=180,
        origin={-59.5,30})));
  Modelica.Fluid.Sensors.Temperature T_Mix(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{32,42},{48,54}})));
  Modelica.Fluid.Sensors.Temperature T_AfterFan(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{70,42},{86,54}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{180,-100},{200,-80}})));
  Fluid.FixedResistances.PressureDrop              res(
    m_flow_nominal=FVUParam.m2_flow_nominal_heater,
    dp_nominal=100,
    redeclare package Medium = Air) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-141,26})));
  Modelica.Blocks.Interfaces.RealOutput SupplyTemperature annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={22,-106}), iconTransformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={19,-105})));
  Modelica.Blocks.Interfaces.RealOutput MixTemperature annotation (Placement(
        transformation(
        extent={{-15,-15},{15,15}},
        rotation=270,
        origin={-10,-107}), iconTransformation(
        extent={{-14,-13.5},{14,13.5}},
        rotation=270,
        origin={-11.5,-106})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening damperCirculationAir(
    m_flow_nominal=0.05,
    dpValve_nominal=500,
    redeclare package Medium = Air,
    riseTime=20) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-16})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening damperBypass(
    m_flow_nominal=0.05,
    dpValve_nominal=500,
    redeclare package Medium = Air,
    riseTime=90) annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-27,36})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening damperHeatRecovery(
    m_flow_nominal=0.05,
    dpValve_nominal=500,
    redeclare package Medium = Air,
    riseTime=90) annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-82,-68})));
  Modelica.Fluid.Sensors.Temperature T_beforeCooler(redeclare package Medium =
        Air) annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=180,
        origin={129,0})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening damperFreshAir(
    m_flow_nominal=0.05,
    dpValve_nominal=500,
    redeclare package Medium = Air,
    riseTime=20) annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-112,-68})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness recuperator(
    redeclare package Medium1 = Air,
    redeclare package Medium2 = Air,
    eps=0.6,
    m1_flow_nominal=FVUParam.m2_flow_nominal_heater,
    m2_flow_nominal=FVUParam.m2_flow_nominal_heater,
    dp1_nominal=FVUParam.dp2_nominal_heater,
    dp2_nominal=FVUParam.dp2_nominal_heater)
    annotation (Placement(transformation(extent={{-44,-42},{-24,-22}})));
  Modelica.Fluid.Vessels.ClosedVolume volume(
    nPorts=4,
    use_portsData=false,
    V=0.01,
    redeclare package Medium = Air,
    T_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={18,14})));
  Fluid.FixedResistances.PressureDrop              res1(
    m_flow_nominal=FVUParam.m2_flow_nominal_heater,
    dp_nominal=100,
    redeclare package Medium = Air) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-61,-68})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening heatingValve(
    m_flow_nominal=0.05,
    redeclare package Medium = Water,
    dpValve_nominal=200) annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=90,
        origin={122,60})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening coolingValve(
    m_flow_nominal=0.05,
    redeclare package Medium = Water,
    dpValve_nominal=200) annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=90,
        origin={192,58})));
  Controls.Interfaces.FVUControlBus fVUControlBus
    annotation (Placement(transformation(extent={{-29,72},{29,130}})));
equation

  connect(cooler.port_b2, SupplyAir) annotation (Line(
      points={{182,26},{202,26}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(T_ExhaustAir.port, ExhaustAir) annotation (Line(
      points={{182,-58},{182,-68},{202,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_FreshAir.port, FreshAir) annotation (Line(
      points={{-140,-76},{-140,-68},{-158,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_OutgoingExhaustAir.port, fanExhaustAir.port_b) annotation (Line(
      points={{-134,38},{-134,26},{-128,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cooler.port_b2, T_SupplyAir.port) annotation (Line(
      points={{182,26},{188,26},{188,8}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(add1.u2, realExpression1.y) annotation (Line(
      points={{-66,49},{-70,49},{-70,30},{-66.65,30}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(T_Mix.port, fanSupplyAir.port_a)
    annotation (Line(points={{40,42},{40,26},{52,26}}, color={0,127,255}));
  connect(OutgoingExhaustAir, res.port_b) annotation (Line(
      points={{-160,26},{-146,26}},
      color={0,127,255},
      thickness=1));
  connect(fanExhaustAir.port_b, res.port_a) annotation (Line(
      points={{-128,26},{-136,26}},
      color={0,127,255},
      thickness=1));
  connect(FreshAir, FreshAir) annotation (Line(
      points={{-158,-68},{-158,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_SupplyAir.T, SupplyTemperature);
  connect(T_Mix.T, MixTemperature);
  connect(T_AfterFan.port, fanSupplyAir.port_b) annotation (Line(
      points={{78,42},{78,26},{72,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(add1.y, damperBypass.y) annotation (Line(
      points={{-54.5,52},{-27,52},{-27,46.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ExhaustAir, ExhaustAir) annotation (Line(
      points={{202,-68},{202,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_beforeCooler.port, heater.port_b2) annotation (Line(
      points={{129,6},{130,6},{130,26},{116,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(damperFreshAir.port_b, damperHeatRecovery.port_a)
    annotation (Line(points={{-103,-68},{-91,-68}}, color={0,127,255}));
  connect(FreshAir, damperFreshAir.port_a)
    annotation (Line(points={{-158,-68},{-121,-68}}, color={0,127,255}));
  connect(damperFreshAir.port_b, damperBypass.port_a) annotation (Line(points={
          {-103,-68},{-100,-68},{-100,36},{-36,36}}, color={0,127,255}));
  connect(fanSupplyAir.port_b, heater.port_a2)
    annotation (Line(points={{72,26},{84,26},{96,26}}, color={0,127,255}));
  connect(ExhaustAir, recuperator.port_a2) annotation (Line(points={{202,-68},{
          104,-68},{-4,-68},{-4,-38},{-24,-38}}, color={0,127,255}));
  connect(recuperator.port_b2, fanExhaustAir.port_a) annotation (Line(points={{
          -44,-38},{-44,-38},{-90,-38},{-90,26},{-108,26}}, color={0,127,255}));
  connect(recuperator.port_b1, volume.ports[1]) annotation (Line(points={{-24,-26},
          {-6,-26},{-6,24},{21,24}}, color={0,127,255}));
  connect(damperBypass.port_b, volume.ports[2])
    annotation (Line(points={{-18,36},{19,36},{19,24}}, color={0,127,255}));
  connect(damperCirculationAir.port_b, volume.ports[3]) annotation (Line(points=
         {{30,-6},{30,-6},{30,24},{17,24}}, color={0,127,255}));
  connect(fanSupplyAir.port_a, volume.ports[4])
    annotation (Line(points={{52,26},{15,26},{15,24}}, color={0,127,255}));
  connect(T_AfterHeatRecovery.port, recuperator.port_b1) annotation (Line(
        points={{-20,-10},{-20,-26},{-24,-26}}, color={0,127,255}));
  connect(heater.port_b2, cooler.port_a2)
    annotation (Line(points={{116,26},{140,26},{162,26}}, color={0,127,255}));
  connect(heater.port_a1, heatingValve.port_a)
    annotation (Line(points={{116,38},{122,38},{122,51}}, color={0,127,255}));
  connect(heatingValve.port_b, Heater_Flow) annotation (Line(points={{122,69},{
          122,84.5},{122,100}}, color={0,127,255}));
  connect(Cooler_Return, cooler.port_b1)
    annotation (Line(points={{162,100},{162,38},{162,38}}, color={0,127,255}));
  connect(cooler.port_a1, coolingValve.port_a)
    annotation (Line(points={{182,38},{192,38},{192,49}}, color={0,127,255}));
  connect(coolingValve.port_b, Cooler_Flow)
    annotation (Line(points={{192,67},{192,74},{192,100}}, color={0,127,255}));
  connect(Heater_Return, heater.port_b1) annotation (Line(points={{92,100},{94,
          100},{94,38},{96,38}}, color={0,127,255}));
  connect(ExhaustAir, damperCirculationAir.port_a) annotation (Line(points={{
          202,-68},{114,-68},{30,-68},{30,-26}}, color={0,127,255}));
  connect(damperHeatRecovery.port_b, res1.port_a) annotation (Line(points={{-73,
          -68},{-69.5,-68},{-66,-68}}, color={0,127,255}));
  connect(res1.port_b, recuperator.port_a1) annotation (Line(points={{-56,-68},
          {-50,-68},{-50,-26},{-44,-26}}, color={0,127,255}));
  connect(damperCirculationAir.y, fVUControlBus.circulationDamperOpening)
    annotation (Line(points={{18,-16},{12,-16},{0.145,-16},{0.145,101.145}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fanSupplyAir.powerShare, fVUControlBus.fanSupplyAirPower) annotation
    (Line(points={{62,36},{62,62},{0.145,62},{0.145,101.145}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fanExhaustAir.powerShare, fVUControlBus.fanExhaustAirPower)
    annotation (Line(points={{-118,36},{-118,62},{0.145,62},{0.145,101.145}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(damperFreshAir.y, fVUControlBus.freshAirDamperOpening) annotation (
      Line(points={{-112,-57.2},{-112,-57.2},{-112,66},{0.145,66},{0.145,
          101.145}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(damperHeatRecovery.y, fVUControlBus.hRCDamperOpening) annotation (
      Line(points={{-82,-57.2},{-82,-57.2},{-82,72},{0.145,72},{0.145,101.145}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(add1.u1, fVUControlBus.hRCDamperOpening) annotation (Line(points={{
          -66,55},{-68,55},{-68,72},{0.145,72},{0.145,101.145}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatingValve.y, fVUControlBus.heatingValveOpening) annotation (Line(
        points={{132.8,60},{140,60},{140,76},{0.145,76},{0.145,101.145}}, color
        ={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(coolingValve.y, fVUControlBus.coolingValveOpening) annotation (Line(
        points={{202.8,58},{210,58},{210,76},{0.145,76},{0.145,101.145}}, color
        ={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{
            200,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{200,100}}, preserveAspectRatio=
            false), graphics={Rectangle(
          extent={{-160,100},{200,-100}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}), Text(
          extent={{-120,56},{168,-52}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="FVU",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=86400, Interval=1),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>This is a model for Facade Ventilation Unit (FVU), which can be used for heating, cooling and ventilation purposes. It is equipped with two speed-controlled fans, a recuperator and two air-water heat exchangers. </p>
<p><br><b><span style=\"color: #008000;\">Operation Modes</b> </span></p>
<p>The portion of fresh air flowing through the recuperator is controlled by means of a bypass damper. The portion of extract air that is recirculated and mixed with the fresh air stream is controlled by means of a circulation damper. The mixed air stream is either heated or cooled in the air-water heat exchangers. The water flow in these heat exchangers is controlled by two-way-valves. </p>
<h4><span style=\"color: #008000\">Actuators</span></h4>
<p>All actuators receive normailized signals (0-1). The supply- and exhaust air fans are table-based. An input signal in &percnt; is transformed into a mass-flow set point for a flow-controlled mover. If the exhaust air fan is not in operation, the entire air flow should be recirculated. Thus, the circulation damper should be fully opened. In that case, the fresh air flap should be closed so that no fresh air can enter the unit. The exhaust air fan has a minimum mass flow rate of 1 m&sup3;/h to make the model more stable. </p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>Baranski, M., Sangi, R., F&uuml;tterer, J., M&uuml;ller, D. (2016). An Algorithm for Stepwise Exergy-based Model Predictive Control of Building HVAC Supply Chains. <i>29th international conference on Efficiency, Cost, Optimisation, Simulation and Environmental Impact of Energy Systems</i>. </p>
</html>", revisions="<html>
<ul>
  <li><i>Septmeber, 2014&nbsp;</i>
    by by Roozbeh Sangi and Marc Baranski:<br/>
    Model implemented</li>
</ul>
</html>"));
end FacadeVentilationUnit;
