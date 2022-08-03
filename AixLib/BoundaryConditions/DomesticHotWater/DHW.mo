within AixLib.BoundaryConditions.DomesticHotWater;
model DHW "Model to extract the mass flow rate from the ports and feed back cold water"
    extends IBPSA.Fluid.Interfaces.LumpedVolumeDeclarations;
  replaceable parameter DHWDesignParameters parameters;

  replaceable parameter AixLib.DataBase.DomesticHotWater.PartialDHWTap
    DHWProfile annotation (choicesAllMatching=true, Dialog(
      group="DHW",
      enable=not use_dhwCalc and use_dhw));

  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Assumptions"));
  parameter Boolean show_T=false
    "= true, if actual temperature at port is computed"
    annotation (Dialog(tab="Advanced", group="Diagnostics"));
  parameter Modelica.Units.SI.Density rho=Medium.density(sta_nominal)
    "Density of medium / fluid in heat distribution system"
    annotation (Dialog(tab="Assumptions", group="General"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cp=
      Medium.specificHeatCapacityCp(sta_nominal)
    "Specific heat capacaity of medium / fluid in heat distribution system"
    annotation (Dialog(tab="Assumptions", group="General"));
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal;
  replaceable parameter
    BESMod.Systems.RecordsCollection.Movers.MoverBaseDataDefinition
    pumpData
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-96,-96},{-84,-84}})));

  replaceable AixLib.BoundaryConditions.DomesticHotWater.TappingProfiles.BaseClasses.PartialDHW
                                                                               calcmFlow
    constrainedby
    BESMod.Systems.Demand.DHW.TappingProfiles.BaseClasses.PartialDHW(
    final TCold=parameters.TDHWCold_nominal,
    final dWater=rho,
    final c_p_water=cp,
    final TSetDHW=parameters.TDHW_nominal) annotation (choicesAllMatching=true,
      Placement(transformation(
        extent={{-17,18},{17,-18}},
        rotation=180,
        origin={-21,-2})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort senT(
    final transferHeat=false,
    redeclare final package Medium = Medium,
    final m_flow_nominal=0.1) "Temperature of DHW" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,60})));
Modelica.Blocks.Math.UnitConversions.From_degC fromDegC
    "Profiles for internal gains" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-30})));
  IBPSA.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final p_start=p_start,
    final T_start=parameters.TDHWCold_nominal,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=parameters.mDHW_flow_nominal,
    final m_flow_small=1E-4*abs(parameters.mDHW_flow_nominal),
    final show_T=show_T,
    redeclare
      BESMod.Systems.RecordsCollection.Movers.AutomaticConfigurationData
      per(
      final speed_rpm_nominal=pumpData.speed_rpm_nominal,
      final m_flow_nominal=parameters.mDHW_flow_nominal,
      final dp_nominal(displayUnit="Pa") = 100,
      final rho=rho,
      final V_flowCurve=pumpData.V_flowCurve,
      final dpCurve=pumpData.dpCurve),
    final inputType=IBPSA.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=pumpData.addPowerToMedium,
    final nominalValuesDefineDefaultPressureCurve=false,
    final tau=pumpData.tau,
    final use_inputFilter=pumpData.use_inputFilter,
    final riseTime=pumpData.riseTimeInpFilter,
    final dp_nominal=100) annotation (Placement(transformation(
        extent={{-9.5,10.5},{9.5,-10.5}},
        rotation=180,
        origin={-69.5,-59.5})));
  IBPSA.Fluid.Sources.Boundary_ph bou_sink(
    redeclare package Medium = Medium,
    final p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={10,60})));
  IBPSA.Fluid.Sources.Boundary_pT bouSou(
    final T=parameters.TDHWCold_nominal,
    final nPorts=1,
    redeclare final package Medium = Medium,
    final p=p_start)
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  IBPSA.Fluid.Movers.FlowControlled_m_flow pump1(
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final p_start=p_start,
    final T_start=parameters.TDHWCold_nominal,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=parameters.mDHW_flow_nominal,
    final m_flow_small=1E-4*abs(parameters.mDHW_flow_nominal),
    final show_T=show_T,
    redeclare
      BESMod.Systems.RecordsCollection.Movers.AutomaticConfigurationData per(
      final speed_rpm_nominal=pumpData.speed_rpm_nominal,
      final m_flow_nominal=parameters.mDHW_flow_nominal,
      final dp_nominal(displayUnit="Pa") = 100,
      final rho=rho,
      final V_flowCurve=pumpData.V_flowCurve,
      final dpCurve=pumpData.dpCurve),
    final inputType=IBPSA.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=pumpData.addPowerToMedium,
    final nominalValuesDefineDefaultPressureCurve=false,
    final tau=pumpData.tau,
    final use_inputFilter=pumpData.use_inputFilter,
    final riseTime=pumpData.riseTimeInpFilter,
    final dp_nominal=100) annotation (Placement(transformation(
        extent={{-8.5,9.5},{8.5,-9.5}},
        rotation=0,
        origin={-70.5,59.5})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTableDHWInput(
    final tableOnFile=false,
    final table=DHWProfile.table,
    final columns=2:5,
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    final extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Read the input data from the given file. " annotation (Placement(visible=true,
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,0})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare final package Medium
      = Medium) "Inlet for the demand of DHW" annotation (Placement(
        transformation(extent={{-110,50},{-90,70}}),  iconTransformation(extent={{-110,50},
            {-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare final package Medium
      = Medium) "Outlet of the demand of DHW" annotation (Placement(
        transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
          extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    final k=1,
    use_reset=false,
    y(unit="J"))
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Sources.RealExpression internal_u(y=-port_b.m_flow*cp*(senT.T -
        parameters.TDHWCold_nominal))                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,-70})));
  Modelica.Blocks.Interfaces.RealOutput Q "Energy demand of DHW"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));

protected
  parameter Medium.ThermodynamicState sta_nominal=Medium.setState_pTX(
      T=Medium.T_default, p=Medium.p_default, X=Medium.X_default) "Nominal / default state of medium";
equation
  connect(senT.T,calcmFlow. TIs) annotation (Line(points={{-30,71},{-30,78},{28,
          78},{28,-2},{-0.6,-2}},
                            color={0,0,127}));
  connect(fromDegC.y, calcmFlow.TSet) annotation (Line(points={{19,-30},{14,-30},
          {14,-12.8},{-0.6,-12.8}},
                               color={0,0,127}));
  connect(pump.port_a, bouSou.ports[1]) annotation (Line(
      points={{-60,-59.5},{-51,-59.5},{-51,-60},{-40,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(pump.port_b, port_b) annotation (Line(
      points={{-79,-59.5},{-89.5,-59.5},{-89.5,-60},{-100,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(calcmFlow.m_flow_out, pump.m_flow_in) annotation (Line(points={{-39.7,
          -2},{-70,-2},{-70,-26},{-69.5,-26},{-69.5,-46.9}}, color={0,0,127}));
  connect(port_a, pump1.port_a) annotation (Line(points={{-100,60},{-89.5,60},{-89.5,
          59.5},{-79,59.5}},       color={0,127,255}));
  connect(senT.port_a, pump1.port_b) annotation (Line(points={{-40,60},{-52,60},
          {-52,59.5},{-62,59.5}},
                       color={0,127,255}));
  connect(pump1.m_flow_in, calcmFlow.m_flow_out) annotation (Line(points={{-70.5,
          48.1},{-70,48.1},{-70,-2},{-39.7,-2}},       color={0,0,127}));
  connect(senT.port_b, bou_sink.ports[1])
    annotation (Line(points={{-20,60},{0,60}},            color={0,127,255}));
  connect(combiTimeTableDHWInput.y[4], fromDegC.u) annotation (Line(points={{59,
          8.88178e-16},{48,8.88178e-16},{48,-30},{42,-30}},
                                          color={0,0,127}));
  connect(combiTimeTableDHWInput.y[2], calcmFlow.m_flow_in) annotation (Line(
        points={{59,8.88178e-16},{8,8.88178e-16},{8,8.8},{-0.6,8.8}},
                                                      color={0,0,127}));
  connect(internal_u.y, integrator.u)
    annotation (Line(points={{41,-70},{58,-70}}, color={0,0,127}));
  connect(integrator.y, Q)
    annotation (Line(points={{81,-70},{110,-70}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                              Text(
          extent={{-100,-72},{104,-168}},
          lineColor={0,0,0},
          textString="%name%"),
          Bitmap(
          extent={{-74,-74},{86,80}},
          imageSource=
              "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",
          fileName="modelica://AixLib/Resources/Images/BoundaryConditions/DHW.png")}),
                                 Diagram(graphics,
                                         coordinateSystem(preserveAspectRatio=false)));
end DHW;
