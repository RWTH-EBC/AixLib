within AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.Example;
model EnergyPileGroupExample
  extends Modelica.Icons.Example;
  AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.EnergyPileGroup
    energyPileGroup(
    withTemperatureInputs=true,
    TGroundTop=284.15,
    TGroundUndisturbed=286.15,
    TGroundBottom=287.15,
    noOfBoreholes=3,
    n=10,
    boreholeDiameter=0.15,
    pipeType=AixLib.DataBase.Pipes.Copper.Copper_54x1(
        d_i=0.032,
        d_o=0.035,
        d=983,
        lambda=0.8,
        c=1500),
    nParallel=2,
    T0=[305.15,305.15,305.15,305.15,305.15,305.15,305.15,305.15,305.15,305.15;
        289.15,289.15,289.15,289.15,289.15,289.15,289.15,289.15,289.15,289.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15],
    pipeCentreReferenceCircle=energyPileGroup.boreholeDiameter/2,
    nRad=10,
    medium=AixLib.FastHVAC.Media.DC20(),
    groundVolumeDiamter=100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-18})));

  AixLib.FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{-7.5,-5.5},{7.5,5.5}},
        rotation=0,
        origin={65.5,80.5})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureGeoSup
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={30,20})));
  AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-58,70},{-40,88}})));
Modelica.Blocks.Sources.Constant MassflowHeating(k=2.349)
    annotation (Placement(transformation(extent={{-96,66},{-88,74}})));
Modelica.Blocks.Sources.Pulse FlowTemperature(
    amplitude=-11,
    width=20.55,
    period(displayUnit="d") = 31536000,
    offset=11)
    annotation (Placement(transformation(extent={{-96,82},{-88,90}})));
Modelica.Blocks.Sources.Constant TUndisturbedGround_input1(k=11)
    annotation (Placement(transformation(extent={{-80,-26},{-70,-16}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluidHeating
    annotation (Placement(transformation(extent={{-10,80},{10,60}})));
  Sensors.TemperatureSensor temperatureIn1 annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-20,70})));
  Sensors.TemperatureSensor temperatureOut1 annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={20,70})));
  Sensors.TemperatureSensor temperatureGeoRet annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-30,10})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluidGeothermal(
   medium=AixLib.FastHVAC.Media.DC20())
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowGeoIn
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={0,48})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowGeoOut
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={60,42})));
  Modelica.Blocks.Sources.RealExpression geothermalHeatFlow(y=energyPileGroup.Q_flowTotal)
    annotation (Placement(transformation(extent={{-56,20},{-20,40}})));
  Modelica.Blocks.Sources.RealExpression geothermalHeatToHeating(
   y=-energyPileGroup.Q_flowTotal)
    annotation (Placement(transformation(extent={{116,50},{80,70}})));
  Pumps.Pump pump(
   medium=AixLib.FastHVAC.Media.DC20())
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
Modelica.Blocks.Sources.Constant MassflowGeothermal(k=2.349)
    annotation (Placement(transformation(extent={{20,-44},{12,-36}})));
protected
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{-76,78},{-66,88}})));
protected
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
    annotation (Placement(transformation(extent={{-60,-26},{-50,-16}})));
equation
  connect(temperatureGeoSup.enthalpyPort_a, energyPileGroup.enthalpyPort_b1)
    annotation (Line(points={{26.48,20.04},{20,20.04},{20,-8},{8.2,-8}}, color={
          176,0,0}));
  connect(TUndisturbedGround_input1.y, toKelvin2.Celsius) annotation (Line(
        points={{-69.5,-21},{-61,-21}},             color={0,0,127}));
  connect(toKelvin2.Kelvin, energyPileGroup.groundUndisturbedTemp_input)
    annotation (Line(points={{-49.5,-21},{-34,-21},{-34,-25.8},{-12,-25.8}},
                                                                     color={0,0,
          127}));
  connect(toKelvin2.Kelvin, energyPileGroup.groundBottomTemp_input) annotation (
     Line(points={{-49.5,-21},{-49.5,-30},{-1.2,-30}},      color={0,0,127}));
  connect(temperatureIn1.enthalpyPort_b, workingFluidHeating.enthalpyPort_a)
    annotation (Line(points={{-16.4,70.04},{-14.2,70.04},{-14.2,70},{-9,70}},
        color={176,0,0}));
  connect(temperatureIn1.enthalpyPort_a, fluidSource.enthalpyPort_b)
    annotation (Line(points={{-23.52,70.04},{-40,70.04},{-40,79.9}},
        color={176,0,0}));
  connect(workingFluidHeating.enthalpyPort_b, temperatureOut1.enthalpyPort_a)
    annotation (Line(points={{9,70},{14,70},{14,70.04},{16.48,70.04}}, color={176,
          0,0}));
  connect(temperatureOut1.enthalpyPort_b, vessel.enthalpyPort_a) annotation (
      Line(points={{23.6,70.04},{40,70.04},{40,80.5},{60.25,80.5}}, color={176,0,
          0}));
  connect(temperatureGeoRet.enthalpyPort_b, energyPileGroup.enthalpyPort_a1)
    annotation (Line(points={{-26.4,10.04},{-20,10.04},{-20,-8},{-7.8,-8}},
        color={176,0,0}));
  connect(toKelvin2.Kelvin, energyPileGroup.groundTopTemp_input) annotation (
      Line(points={{-49.5,-21},{-49.5,-15.8},{-12,-15.8}}, color={0,0,127}));
  connect(workingFluidGeothermal.enthalpyPort_a, temperatureGeoSup.enthalpyPort_b)
    annotation (Line(points={{51,20},{38,20},{38,20.04},{33.6,20.04}}, color={176,
          0,0}));
  connect(heatFlowGeoIn.port, workingFluidHeating.heatPort)
    annotation (Line(points={{0,56},{0,60.6}}, color={191,0,0}));
  connect(heatFlowGeoOut.port, workingFluidGeothermal.heatPort)
    annotation (Line(points={{60,34},{60,29.4}}, color={191,0,0}));
  connect(geothermalHeatFlow.y, heatFlowGeoIn.Q_flow)
    annotation (Line(points={{-18.2,30},{0,30},{0,40}}, color={0,0,127}));
  connect(geothermalHeatToHeating.y, heatFlowGeoOut.Q_flow)
    annotation (Line(points={{78.2,60},{60,60},{60,50}}, color={0,0,127}));
  connect(workingFluidGeothermal.enthalpyPort_b, pump.enthalpyPort_a)
    annotation (Line(points={{69,20},{80,20},{80,-60},{9.6,-60}}, color={176,0,0}));
  connect(pump.enthalpyPort_b, temperatureGeoRet.enthalpyPort_a) annotation (
      Line(points={{-9.6,-60},{-100,-60},{-100,10.04},{-33.52,10.04}}, color={176,
          0,0}));
  connect(MassflowGeothermal.y, pump.dotm_setValue)
    annotation (Line(points={{11.6,-40},{0,-40},{0,-52}}, color={0,0,127}));
  connect(MassflowHeating.y, fluidSource.dotm) annotation (Line(points={{-87.6,
          70},{-82,70},{-82,76.66},{-56.2,76.66}}, color={0,0,127}));
  connect(fluidSource.T_fluid, toKelvin.Kelvin) annotation (Line(points={{-56.2,
          82.78},{-60,82.78},{-60,83},{-65.5,83}}, color={0,0,127}));
  connect(FlowTemperature.y, toKelvin.Celsius) annotation (Line(points={{-87.6,
          86},{-82,86},{-82,83},{-77,83}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, Interval=86400), Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>Simple test set-up for the EnergyPileGroup model: <a href=\"modelica://AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.EnergyPileGroup\">AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.EnergyPileGroup</a></p>
<p>This model of a group of geothermal probes was validated using VDI 4640. The selected setup includes the geothermal probes and the forward and backward flow of the system.</p>
<p><b><span style=\"color: #008000;\">Exceptions</span> </b></p>
<p>The model does not take into account the interactions of the geothermal probes in the ground, so that the specific heat flow does not change with increasing number of probes at the same mass flow per probe.</p>
</html>"));
end EnergyPileGroupExample;
