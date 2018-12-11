within AixLib.Airflow.FacadeVentilationUnit;
model FacadeVentilationUnit
  "Facade Ventilation Unit (FVU) equipped with a recuperator"

  replaceable package Water = AixLib.Media.Water
    "Water Model in the system";
  replaceable package Air = AixLib.Media.Air
    "Air Model in the system";

  parameter AixLib.Airflow.FacadeVentilationUnit.DataBase.FVUBaseRecord
    fVUParam=AixLib.Airflow.FacadeVentilationUnit.DataBase.FVUBaseRecord()
    "Record containing the characteristic parameters of the unit";

  parameter Modelica.SIunits.ThermodynamicTemperature T_start=273.15 + 20
    "Initial temperature in unit";

  AixLib.Airflow.FacadeVentilationUnit.BaseClasses.SetPower fanExhaustAir(
    redeclare package Medium = Air,
    noUnits=fVUParam.noUnits,
    m_flow_nominal=fVUParam.m2_flow_nominal_heater,
    T_start=T_start,
    p_start=fVUParam.dp2_nominal_heater)
    "The fan on the exhaust air side" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-118,26})));
  AixLib.Airflow.FacadeVentilationUnit.BaseClasses.SetPower fanSupplyAir(
    redeclare package Medium = Air,
    noUnits=fVUParam.noUnits,
    m_flow_nominal=fVUParam.m2_flow_nominal_heater,
    p_start=5*fVUParam.dp2_nominal_heater,
    dp_nominal=5*fVUParam.dp2_nominal_heater)
    "The fan on the supply air side"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={62,26})));
  Modelica.Fluid.Sensors.Temperature extractAirTemperature(redeclare package
      Medium = Air) "Temperature of the extract air"
    annotation (Placement(transformation(extent={{174,-58},{190,-46}})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness heater(
    redeclare package Medium2 = Air,
    redeclare package Medium1 = Water,
    m1_flow_nominal=fVUParam.m1_flow_nominal_heater,
    m2_flow_nominal=fVUParam.m2_flow_nominal_heater,
    dp1_nominal(displayUnit="Pa") = fVUParam.dp1_nominal_heater,
    dp2_nominal(displayUnit="Pa") = fVUParam.dp2_nominal_heater)
    "The heat exchanger used for heating"
    annotation (Placement(transformation(extent={{116,22},{96,42}})));
  Modelica.Fluid.Interfaces.FluidPort_b exhaustAirConnector(redeclare package
      Medium = Air) "Connector to the exhaust air sink"
    annotation (Placement(transformation(extent={{-170,16},{-150,36}})));
  Modelica.Fluid.Interfaces.FluidPort_a freshAirConnector(redeclare package
      Medium = Air) "Connector to the fresh air source"
    annotation (Placement(transformation(extent={{-168,-78},{-148,-58}})));
  Modelica.Fluid.Interfaces.FluidPort_a extractAirConnector(redeclare package
      Medium = Air) "Connector to the extract air source"
    annotation (Placement(transformation(extent={{192,-78},{212,-58}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAirConnector(redeclare package
      Medium = Air) "Connector to the supply air sink"
    annotation (Placement(transformation(extent={{192,16},{212,36}})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness cooler(
    redeclare package Medium2 = Air,
    redeclare package Medium1 = Water,
    dp1_nominal(displayUnit="Pa") = fVUParam.dp1_nominal_cooler,
    dp2_nominal(displayUnit="Pa") = fVUParam.dp2_nominal_cooler,
    m1_flow_nominal=fVUParam.m1_flow_nominal_cooler,
    m2_flow_nominal=fVUParam.m2_flow_nominal_cooler)
    "The heat exchanger used for cooling"
    annotation (Placement(transformation(extent={{182,22},{162,42}})));
  Modelica.Fluid.Interfaces.FluidPort_b heaterReturnConnector(redeclare package
      Medium = Water) "Connector to the heating water sink"
    annotation (Placement(transformation(extent={{82,90},{102,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a heaterFlowConnector(redeclare package
      Medium = Water) "Connector to the heating water source"
    annotation (Placement(transformation(extent={{112,90},{132,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b coolerReturnConnector(redeclare package
      Medium = Water) "Connector to the cooling water source"
    annotation (Placement(transformation(extent={{152,90},{172,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a coolerFlowConnector(redeclare package
      Medium = Water) "Connector to the cooling water source"
    annotation (Placement(transformation(extent={{182,90},{202,110}})));
  Modelica.Fluid.Sensors.Temperature freshAirTemperature(redeclare package
      Medium = Air) "Temperature of the fresh air" annotation (Placement(
        transformation(
        extent={{-8,-6},{8,6}},
        rotation=180,
        origin={-140,-82})));
  Modelica.Fluid.Sensors.Temperature exhaustAirTemperature(redeclare package
      Medium = Air) "Temperature of the exhaust air" annotation (Placement(
        transformation(
        extent={{-8,-6},{8,6}},
        rotation=0,
        origin={-134,44})));
  Modelica.Fluid.Sensors.Temperature coolerTemperature(redeclare package Medium =
           Air) "Temperature of the supply air stream behind the cooler"
    annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=180,
        origin={188,2})));
  Modelica.Fluid.Sensors.Temperature heatRecoveryTemperature(redeclare package
      Medium = Air) "Temperature behind the recuperator"
    annotation (Placement(transformation(extent={{-28,-10},{-12,2}})));

  Modelica.Blocks.Math.Add oppositeOpening(k1=-1)
    "Provides the relative opening of the complementary damper of the 
    recuperator" annotation (Placement(transformation(extent={{-65,47},{-55,57}})));
  Modelica.Blocks.Sources.Constant one(k=1) "Output the Real value 1 "
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-61,27})));
  Modelica.Fluid.Sensors.Temperature mixAirTemperature(redeclare package Medium =
           Air) "Temperature of the mixed circulation and fresh air streams"
    annotation (Placement(transformation(extent={{32,42},{48,54}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{180,-100},{200,-80}})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening damperCirculationAir(
    redeclare package Medium = Air,
    riseTime=fVUParam.damperRiseTimeLong,
    m_flow_nominal=fVUParam.m_flow_nominal_damper,
    dpValve_nominal=fVUParam.dp_nominal_damper)
                 "Damper that controls the air stream that is recirculated"
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-16})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening damperBypass(
    redeclare package Medium = Air,
    riseTime=fVUParam.damperRiseTimeLong,
    m_flow_nominal=fVUParam.m_flow_nominal_damper,
    dpValve_nominal=fVUParam.dp_nominal_damper)
    "The second of two dampers that control the air flow through the 
    recuperator"             annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-27,36})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening damperHeatRecovery(
    redeclare package Medium = Air,
    riseTime=fVUParam.damperRiseTimeLong,
    m_flow_nominal=fVUParam.m_flow_nominal_damper,
    dpValve_nominal=fVUParam.dp_nominal_damper)
    "The first of two dampers that control the air flow through the recuperator"
                 annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-82,-68})));
  Modelica.Fluid.Sensors.Temperature heaterTemperature(redeclare package Medium =
                Air) "Temperature of the supply air stream behind the heater"
    annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=180,
        origin={129,4})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening damperFreshAir(
    redeclare package Medium = Air,
    riseTime=fVUParam.damperRiseTimeShort,
    m_flow_nominal=fVUParam.m_flow_nominal_damper,
    dpValve_nominal=fVUParam.dp_nominal_damper)
                 "Can be used to disconnect the unit from fresh air source"
                 annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-112,-68})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness recuperator(
    redeclare package Medium1 = Air,
    redeclare package Medium2 = Air,
    eps=0.6,
    m1_flow_nominal=fVUParam.m2_flow_nominal_heater,
    m2_flow_nominal=fVUParam.m2_flow_nominal_heater,
    dp1_nominal=fVUParam.dp2_nominal_heater,
    dp2_nominal=fVUParam.dp2_nominal_heater)
    "The heat exchanger used for recovering heat or cold from extract air 
    stream" annotation (Placement(transformation(extent={{-44,-42},{-24,-22}})));
  Modelica.Fluid.Vessels.ClosedVolume volume(
    nPorts=4,
    use_portsData=false,
    V=0.01,
    redeclare package Medium = Air,
    T_start=T_start)
    "Volume where the circulation air and the fresh air stream mix"
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={18,14})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening heatingValve(
    redeclare package Medium = Water,
    riseTime=fVUParam.damperRiseTimeLong,
    dpValve_nominal=fVUParam.dp1_nominal_heater,
    m_flow_nominal=fVUParam.m1_flow_nominal_heater)
    "Valve controlling the heating water flow into the unit"
                         annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=90,
        origin={122,60})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening coolingValve(
    redeclare package Medium = Water,
    riseTime=fVUParam.damperRiseTimeLong,
    dpValve_nominal=fVUParam.dp1_nominal_heater,
    m_flow_nominal=fVUParam.m1_flow_nominal_heater)
    "Valve controlling the cooling water flow into the unit"
                         annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=90,
        origin={192,58})));
  AixLib.Controls.Interfaces.FVUControlBus fVUControlBus
    "Bus with controller signals"
    annotation (Placement(transformation(extent={{-29,72},{29,130}})));
equation

  connect(cooler.port_b2, supplyAirConnector) annotation (Line(
      points={{182,26},{202,26}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(extractAirTemperature.port, extractAirConnector) annotation (Line(
      points={{182,-58},{182,-68},{202,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(freshAirTemperature.port, freshAirConnector) annotation (Line(
      points={{-140,-76},{-140,-68},{-158,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(exhaustAirTemperature.port, fanExhaustAir.port_b) annotation (Line(
      points={{-134,38},{-134,26},{-128,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cooler.port_b2, coolerTemperature.port) annotation (Line(
      points={{182,26},{188,26},{188,8}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(oppositeOpening.u2, one.y) annotation (Line(
      points={{-66,49},{-70,49},{-70,27},{-66.5,27}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(mixAirTemperature.port, fanSupplyAir.port_a)
    annotation (Line(points={{40,42},{40,26},{52,26}}, color={0,127,255}));
  connect(freshAirConnector, freshAirConnector) annotation (Line(
      points={{-158,-68},{-158,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(oppositeOpening.y, damperBypass.y) annotation (Line(
      points={{-54.5,52},{-27,52},{-27,46.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(extractAirConnector, extractAirConnector) annotation (Line(
      points={{202,-68},{202,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heaterTemperature.port, heater.port_b2) annotation (Line(
      points={{129,10},{130,10},{130,26},{116,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(damperFreshAir.port_b, damperHeatRecovery.port_a)
    annotation (Line(points={{-103,-68},{-91,-68}}, color={0,127,255}));
  connect(freshAirConnector, damperFreshAir.port_a)
    annotation (Line(points={{-158,-68},{-121,-68}}, color={0,127,255}));
  connect(damperFreshAir.port_b, damperBypass.port_a) annotation (Line(points={
          {-103,-68},{-100,-68},{-100,36},{-36,36}}, color={0,127,255}));
  connect(fanSupplyAir.port_b, heater.port_a2)
    annotation (Line(points={{72,26},{84,26},{96,26}}, color={0,127,255}));
  connect(extractAirConnector, recuperator.port_a2) annotation (Line(points={{202,
          -68},{104,-68},{-4,-68},{-4,-38},{-24,-38}}, color={0,127,255}));
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
  connect(heatRecoveryTemperature.port, recuperator.port_b1) annotation (Line(
        points={{-20,-10},{-20,-26},{-24,-26}}, color={0,127,255}));
  connect(heater.port_b2, cooler.port_a2)
    annotation (Line(points={{116,26},{140,26},{162,26}}, color={0,127,255}));
  connect(heater.port_a1, heatingValve.port_a)
    annotation (Line(points={{116,38},{122,38},{122,51}}, color={0,127,255}));
  connect(heatingValve.port_b, heaterFlowConnector) annotation (Line(points={{122,
          69},{122,84.5},{122,100}}, color={0,127,255}));
  connect(coolerReturnConnector, cooler.port_b1)
    annotation (Line(points={{162,100},{162,38}}, color={0,127,255}));
  connect(cooler.port_a1, coolingValve.port_a)
    annotation (Line(points={{182,38},{192,38},{192,49}}, color={0,127,255}));
  connect(coolingValve.port_b, coolerFlowConnector)
    annotation (Line(points={{192,67},{192,67},{192,100}}, color={0,127,255}));
  connect(heaterReturnConnector, heater.port_b1) annotation (Line(points={{92,100},
          {94,100},{94,38},{96,38}}, color={0,127,255}));
  connect(extractAirConnector, damperCirculationAir.port_a) annotation (Line(
        points={{202,-68},{114,-68},{30,-68},{30,-26}}, color={0,127,255}));
  connect(damperCirculationAir.y, fVUControlBus.circulationDamperOpening)
    annotation (Line(points={{18,-16},{12,-16},{0.145,-16},{0.145,101.145}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fanSupplyAir.powerShare, fVUControlBus.fanSupplyAirPower) annotation (
     Line(points={{62,36},{62,62},{0.145,62},{0.145,101.145}}, color={0,0,127}),
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
  connect(oppositeOpening.u1, fVUControlBus.hRCDamperOpening) annotation (Line(
        points={{-66,55},{-68,55},{-68,72},{0.145,72},{0.145,101.145}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatingValve.y, fVUControlBus.heatingValveOpening) annotation (Line(
        points={{132.8,60},{140,60},{140,76},{0.145,76},{0.145,101.145}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(coolingValve.y, fVUControlBus.coolingValveOpening) annotation (Line(
        points={{202.8,58},{210,58},{210,76},{0.145,76},{0.145,101.145}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(damperHeatRecovery.port_b, recuperator.port_a1) annotation (Line(
        points={{-73,-68},{-58,-68},{-58,-26},{-44,-26}}, color={0,127,255}));
  connect(fanExhaustAir.port_b, exhaustAirConnector) annotation (Line(points={{
          -128,26},{-144,26},{-160,26}}, color={0,127,255}));
  connect(coolerTemperature.T, fVUControlBus.supplyTemperature) annotation (
      Line(points={{182.4,2},{172,2},{160,2},{160,-20},{80,-20},{80,84},{0.145,
          84},{0.145,101.145}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(mixAirTemperature.T, fVUControlBus.mixTemperature) annotation (Line(
        points={{45.6,48},{52,48},{52,84},{0.145,84},{0.145,101.145}}, color={0,
          0,127}), Text(
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
<p>This is a model for Facade Ventilation Unit (FVU), which can be used for heating, cooling and ventilation purposes. It is equipped with two speed-controlled fans, a recuperator and two air-water heat exchangers. The figure below shows a scheme of the unit. </p>
<h4><span style=\"color: #008000\">Operation Modes</span></h4>
<p>The portion of fresh air flowing through the recuperator is controlled by means of a bypass damper. The portion of extract air that is recirculated and mixed with the fresh air stream is controlled by means of a circulation damper. The mixed air stream is either heated or cooled in the air-water heat exchangers. The water flow in these heat exchangers is controlled by two-way-valves. </p>
<h4><span style=\"color: #008000\">Actuators</span></h4>
<p>All actuators receive normailized signals (0-1). The supply and exhaust air fans are table-based. A relative input signal is transformed into a mass-flow set point for a flow-controlled mover. If the exhaust air fan is not in operation, the entire air flow should be recirculated. Thus, the circulation damper should be fully opened. In that case, the fresh air flap should be closed so that no fresh air can enter the unit. The exhaust air fan has a minimum mass flow rate of 1 m&sup3;/h to make the model more stable. </p>
<p><img src=\"modelica://AixLib/Resources/Images/Airflow/FacadeVentilationUnit/FacadeVentilationUnitScheme.PNG\" 
alt=\"Scheme of the facade ventilation unit\"/></p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>Baranski, M., Sangi, R., Fuetterer, J., Mueller, D. (2016). An Algorithm for Stepwise Exergy-based Model Predictive Control of Building HVAC Supply Chains. <i>29th international conference on Efficiency, Cost, Optimisation, Simulation and Environmental Impact of Energy Systems</i>. </p>
</html>", revisions="<html>
<ul>
<li>
July, 2017 by Marc Baranski and Roozbeh Sangi:<br/>
First implementation.
</li>
</ul>
</html>"));
end FacadeVentilationUnit;
