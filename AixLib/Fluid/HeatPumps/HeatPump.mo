within AixLib.Fluid.HeatPumps;
model HeatPump "Base model of realistic heat pump"
  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    redeclare final package Medium1 = Medium_con,
    final m1_flow_nominal=mFlow_conNominal,
    final m2_flow_nominal=mFlow_evaNominal,
    redeclare package Medium2 = Medium_eva);
  MixingVolumes.MixingVolume Condenser(
    nPorts=2,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final V=VCon,
    final m_flow_nominal=mFlow_conNominal) "Volume of Condenser"
    annotation (Placement(transformation(extent={{-6,86},{14,66}})));
  MixingVolumes.MixingVolume Evaporator(
    nPorts=2,
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final V=VEva) "Volume of Evaporator"
    annotation (Placement(transformation(extent={{-8,-84},{12,-64}})));
  Sensors.MassFlowRate mFlow_a1(redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon)
    "mass flow rate at source inlet"
    annotation (Placement(transformation(extent={{-72,90},{-52,70}})));
  Sensors.TemperatureTwoPort senT_b2(
    final transferHeat=true,
    final tauHeaTra=1200,
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final TAmb=546.3)                      "Temperature at sink outlet"
    annotation (Placement(transformation(extent={{-26,-92},{-46,-72}})));
  Sensors.TemperatureTwoPort senT_b1(
    final transferHeat=true,
    final tauHeaTra=1200,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final TAmb=564.3)                      "Temperature at source outlet"
    annotation (Placement(transformation(extent={{26,90},{46,70}})));
  Sensors.TemperatureTwoPort senT_a2(
    final transferHeat=true,
    final tauHeaTra=1200,
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final TAmb=546.3)                      "Temperature at sink inlet"
    annotation (Placement(transformation(extent={{32,-92},{12,-72}})));
  Sensors.TemperatureTwoPort senT_a1(
    final transferHeat=true,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    tauHeaTra=1200,
    final TAmb=564.3)
                    "Temperature at source inlet"
    annotation (Placement(transformation(extent={{-44,90},{-24,70}})));
  Sensors.MassFlowRate mFlow_a2(redeclare package Medium = Medium_eva, final
      allowFlowReversal=allowFlowReversalEva) "mass flow rate at sink inlet"
    annotation (Placement(transformation(extent={{76,-84},{56,-64}})));
  FixedResistances.PressureDrop preDro_2(
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final dp_nominal=dpEva_nominal) "pressure drop at sink side"
    annotation (Placement(transformation(extent={{-60,-84},{-80,-64}})));
  FixedResistances.PressureDrop preDro_1(
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final dp_nominal=dpCon_nominal) "pressure drop at sink side"
    annotation (Placement(transformation(extent={{66,70},{86,90}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    "input signal speed for compressor relative between 0 and 1" annotation (Placement(
        transformation(extent={{-136,-16},{-104,16}})));
  Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-132,-48},{-102,-14}}),
        iconTransformation(extent={{-120,-40},{-102,-14}})));
  BaseClasses.InnerCycle innerCycle(redeclare final PerformanceData
      PerformanceData)                                     annotation (
      Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={-10,8})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateEva
    "Heat flow rate of the evaporator" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-46})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon
    "Heat flow rate of the condenser" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={-16,54})));
  replaceable package Medium_con = Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
    annotation (__Dymola_choicesAllMatching=true);
  replaceable package Medium_eva = Modelica.Media.Interfaces.PartialMedium "Medium at source side"
    annotation (__Dymola_choicesAllMatching=true);
  parameter Boolean allowFlowReversalEva=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(group="Evaporator"));
  parameter Boolean allowFlowReversalCon=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(group="Condenser"));
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate, used for regularization near zero flow"
    annotation (Dialog(group="Condenser"));
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
    "Nominal mass flow rate" annotation (Dialog(group="Evaporator"));
  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Dialog(group="Condenser"));
  parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
    annotation (Dialog(group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpEva_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(group="Condenser"));

  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    y_start=0,
    initType=Modelica.Blocks.Types.Init.NoInit,
    final k=1,
    T=comIneTime_constant) if useComIne
    "As all changes in a compressor have certain inertia, no nSet is directly obtained. This first order block represents the inertia of the compressor."
    annotation (Placement(transformation(extent={{-92,-6},{-80,6}})));
  constant Modelica.SIunits.Time comIneTime_constant
    "Time constant representing inertia of compressor";
  parameter Boolean useComIne=true
                              "Consider the inertia of the compressor";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapCon(final C=
        CCon) "heat Capacity of Condenser"
    annotation (Placement(transformation(extent={{-50,114},{-32,132}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductorCon(
      final G=GCon) "Heat losses through thermal conductivness of condenser"
    annotation (Placement(transformation(extent={{-78,104},{-58,124}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionConInn
    "Convection between fluid and solid"
    annotation (Placement(transformation(extent={{-24,106},{-8,122}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempCon
    "Foreces heat losses according to ambient temperature"
    annotation (Placement(transformation(extent={{-120,106},{-104,122}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapEva(final C=
        CEva) "heat Capacity of Evaporator"
    annotation (Placement(transformation(extent={{-46,-106},{-28,-124}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductorEva(
      final G=GEva) "Heat losses through thermal conductivness of condenser"
    annotation (Placement(transformation(extent={{-76,-116},{-56,-96}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionEvaInn
    "Convection between fluid and solid"
    annotation (Placement(transformation(extent={{-22,-98},{-6,-114}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempEva
    "Foreces heat losses according to ambient temperature"
    annotation (Placement(transformation(extent={{-132,-114},{-116,-98}})));
  parameter Modelica.SIunits.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m)";
  parameter Modelica.SIunits.ThermalConductance GEva
    "Constant thermal conductance of Evaporator material";
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)";
  parameter Modelica.SIunits.ThermalConductance GCon
    "Constant thermal conductance of condenser material";
  Modelica.Blocks.Interfaces.RealInput T_amb_eva
    "Ambient temperature on the evaporator side"
    annotation (Placement(transformation(extent={{132,-56},{100,-24}})));
  replaceable model PerformanceData = BaseClasses.PerformanceData.LookUpTable2D
      (dataTable=AixLib.DataBase.HeatPump.EN14511.Vaillant_VWL_101())
  constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Replaceable model for performance data of HP"
    annotation (choicesAllMatching=true);

  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.1)
    "To generate the on off signal" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-140,-16})));
  Modelica.Blocks.Routing.RealPassThrough realPassThroughnSet if not useComIne
    "Use default nSet value" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-97,-17})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionConOut
    "Convection between fluid and solid"
    annotation (Placement(transformation(extent={{-84,106},{-100,122}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionEvaOut
    "Convection between fluid and solid"
    annotation (Placement(transformation(extent={{-88,-98},{-104,-114}})));
  Modelica.Blocks.Sources.Constant const(k=4) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,-156})));
  Modelica.Blocks.Sources.Constant const1(k=4) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-54,168})));
  Modelica.Blocks.Interfaces.RealInput T_amb_con
    "Ambient temperature on the condenser side"
    annotation (Placement(transformation(extent={{132,24},{100,56}})));
equation
  connect(port_a1, mFlow_a1.port_a) annotation (Line(points={{-100,60},{-100,80},
          {-72,80}},          color={0,127,255}));
  connect(mFlow_a1.port_b, senT_a1.port_a) annotation (Line(points={{-52,80},{
          -44,80}},               color={0,127,255}));
  connect(senT_a1.port_b, Condenser.ports[1]) annotation (Line(points={{-24,80},
          {-14,80},{-14,86},{2,86}},   color={0,127,255}));
  connect(Condenser.ports[2], senT_b1.port_a) annotation (Line(points={{6,86},{
          18,86},{18,80},{26,80}},   color={0,127,255}));
  connect(preDro_1.port_b, port_b1)
    annotation (Line(points={{86,80},{92,80},{92,60},{100,60}},
                                                color={0,127,255}));
  connect(preDro_1.port_a, senT_b1.port_b) annotation (Line(points={{66,80},{46,
          80}},                 color={0,127,255}));
  connect(mFlow_a2.port_a, port_a2)
    annotation (Line(points={{76,-74},{90,-74},{90,-60},{100,-60}},
                                                  color={0,127,255}));
  connect(senT_a2.port_a, mFlow_a2.port_b) annotation (Line(points={{32,-82},{
          46,-82},{46,-74},{56,-74}}, color={0,127,255}));
  connect(senT_a2.port_b, Evaporator.ports[1])
    annotation (Line(points={{12,-82},{12,-84},{0,-84}}, color={0,127,255}));
  connect(senT_b2.port_a, Evaporator.ports[2]) annotation (Line(points={{-26,-82},
          {-16,-82},{-16,-84},{4,-84}}, color={0,127,255}));
  connect(preDro_2.port_b, port_b2)
    annotation (Line(points={{-80,-74},{-90,-74},{-90,-60},{-100,-60}},
                                                    color={0,127,255}));
  connect(preDro_2.port_a, senT_b2.port_b) annotation (Line(points={{-60,-74},{
          -54,-74},{-54,-82},{-46,-82}}, color={0,127,255}));
  connect(mFlow_a1.m_flow, sigBusHP.m_flow_co) annotation (Line(points={{-62,69},
          {-62,62},{-70,62},{-70,-30},{-116.925,-30},{-116.925,-30.915}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_a2.m_flow, sigBusHP.m_flow_ev) annotation (Line(points={{66,-63},
          {66,-44},{-70,-44},{-70,-30.915},{-116.925,-30.915}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b2.T, sigBusHP.T_ret_ev) annotation (Line(points={{-36,-71},{-36,
          -44},{-70,-44},{-70,-30.915},{-116.925,-30.915}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a2.T, sigBusHP.T_flow_ev) annotation (Line(points={{22,-71},{22,-44},
          {-70,-44},{-70,-30.915},{-116.925,-30.915}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a1.T, sigBusHP.T_ret_co) annotation (Line(points={{-34,69},{-34,62},
          {-70,62},{-70,-30.915},{-116.925,-30.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b1.T, sigBusHP.T_flow_co) annotation (Line(points={{36,69},{36,62},
          {-70,62},{-70,-30.915},{-116.925,-30.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatFlowRateEva.port, Evaporator.heatPort) annotation (Line(points={{-10,-56},
          {-10,-74},{-8,-74}},                        color={191,0,0}));
  connect(innerCycle.QEva, heatFlowRateEva.Q_flow)
    annotation (Line(points={{-10,-25},{-10,-36}},         color={0,0,127}));
  connect(Condenser.heatPort, heatFlowRateCon.port)
    annotation (Line(points={{-6,76},{-16,76},{-16,60}},color={191,0,0}));
  connect(innerCycle.Pel, sigBusHP.Pel) annotation (Line(points={{23.15,8.15},{30,
          8.15},{30,-44},{-70,-44},{-70,-30.915},{-116.925,-30.915}},
                                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
    connect(nSet, firstOrder.u)
                               annotation (Line(points={{-120,0},{-93.2,0}}, color={0,0,127},
        pattern=LinePattern.Dash));

    connect(firstOrder.y, sigBusHP.N) annotation (Line(points={{-79.4,0},{-70,0},
            {-70,-30.915},{-116.925,-30.915}},
                                            color={0,0,127},
        pattern=LinePattern.Dash),                            Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(innerCycle.QCon, heatFlowRateCon.Q_flow) annotation (Line(points={{
          -10,41},{-10,43.5},{-16,43.5},{-16,48}}, color={0,0,127}));
  connect(Condenser.heatPort, convectionConInn.fluid) annotation (Line(points={
          {-6,76},{-4,76},{-4,114},{-8,114}}, color={191,0,0}));
  connect(convectionConInn.solid, heatCapCon.port)
    annotation (Line(points={{-24,114},{-41,114}}, color={191,0,0}));
  connect(heatCapCon.port, thermalConductorCon.port_b)
    annotation (Line(points={{-41,114},{-58,114}}, color={191,0,0}));
  connect(convectionEvaInn.solid, heatCapEva.port)
    annotation (Line(points={{-22,-106},{-37,-106}}, color={191,0,0}));
  connect(heatCapEva.port, thermalConductorEva.port_b)
    annotation (Line(points={{-37,-106},{-56,-106}}, color={191,0,0}));
  connect(convectionEvaInn.fluid, Evaporator.heatPort) annotation (Line(points=
          {{-6,-106},{-6,-90},{-8,-90},{-8,-74}}, color={191,0,0}));
  connect(T_amb_eva, sigBusHP.T_amb_eva) annotation (Line(points={{116,-40},{54,
          -40},{54,-44},{-70,-44},{-70,-30},{-94,-30},{-94,-30.915},{-116.925,-30.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_oda, varTempEva.T) annotation (Line(
      points={{-116.925,-30.915},{-116.925,-68.5},{-133.6,-68.5},{-133.6,-106}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_amb_eva, varTempCon.T) annotation (Line(
      points={{-116.925,-30.915},{-116.925,41.5},{-121.6,41.5},{-121.6,114}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, innerCycle.sigBusHP) annotation (Line(
      points={{-117,-31},{-77.5,-31},{-77.5,8.3},{-40.9,8.3}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realToBoolean.y, sigBusHP.onOff) annotation (Line(points={{-140,-22.6},
          {-140,-30.915},{-116.925,-30.915}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(nSet, realToBoolean.u) annotation (Line(points={{-120,0},{-140,0},{
          -140,-8.8}},          color={0,0,127}));
  connect(realPassThroughnSet.y, sigBusHP.N) annotation (Line(
      points={{-97,-22.5},{-97.5,-22.5},{-97.5,-30.915},{-116.925,-30.915}},
      color={0,0,127},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(nSet, realPassThroughnSet.u) annotation (Line(
      points={{-120,0},{-104,0},{-104,-11},{-97,-11}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(varTempCon.port, convectionConOut.fluid)
    annotation (Line(points={{-104,114},{-100,114}}, color={191,0,0}));
  connect(thermalConductorCon.port_a, convectionConOut.solid)
    annotation (Line(points={{-78,114},{-84,114}}, color={191,0,0}));
  connect(thermalConductorEva.port_a, convectionEvaOut.solid)
    annotation (Line(points={{-76,-106},{-88,-106}}, color={191,0,0}));
  connect(varTempEva.port, convectionEvaOut.fluid)
    annotation (Line(points={{-116,-106},{-104,-106}}, color={191,0,0}));
  connect(const.y, convectionEvaOut.Gc) annotation (Line(points={{-54,-145},{
          -76,-145},{-76,-114},{-96,-114}}, color={0,0,127}));
  connect(const.y, convectionEvaInn.Gc) annotation (Line(points={{-54,-145},{
          -34,-145},{-34,-114},{-14,-114}}, color={0,0,127}));
  connect(convectionConOut.Gc, const1.y) annotation (Line(points={{-92,122},{
          -74,122},{-74,157},{-54,157}}, color={0,0,127}));
  connect(convectionConInn.Gc, const1.y) annotation (Line(points={{-16,122},{
          -36,122},{-36,157},{-54,157}}, color={0,0,127}));
  connect(T_amb_con, sigBusHP.T_amb_con) annotation (Line(points={{116,40},{36,40},
          {36,62},{-70,62},{-70,-30.915},{-116.925,-30.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
        Rectangle(
          extent={{-16,83},{16,-83}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,-64},
          rotation=90),
        Rectangle(
          extent={{-17,83},{17,-83}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,61},
          rotation=90),
        Text(
          extent={{-76,6},{74,-36}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="%name
"),     Line(
          points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-3,-60},
          rotation=-90),
        Line(
          points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-5,56},
          rotation=-90),
        Rectangle(
          extent={{-82,42},{84,-46}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-88,60},{88,60}}, color={28,108,200}),
        Line(points={{-88,-60},{88,-60}}, color={28,108,200})}),
                                            Diagram(coordinateSystem(extent={{-100,
            -120},{100,120}})));
end HeatPump;
