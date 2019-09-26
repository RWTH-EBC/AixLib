within AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger;
model EnergyPileGroup
  parameter Boolean withTemperatureInputs = true
    "Get the boundary temperatures from the input connectors";
  parameter Modelica.SIunits.Temperature TGroundTop=284.15
    "temperature of the ground at the surface"
    annotation (Dialog(enable = not withTemperatureInputs));

  parameter Modelica.SIunits.Temperature TGroundUndisturbed=285.15
    "temperature of the undisturbed ground in a sufficient distance
      from the borehole"
    annotation (Dialog(enable = not withTemperatureInputs));
  parameter Modelica.SIunits.Temperature TGroundBottom=286.15
    "temperature of the ground at the bottom of the borehole"
    annotation (Dialog(enable = not withTemperatureInputs));

  parameter Integer noOfBoreholes=3 "number of piles";
  AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.EnergyPileSingle
    energyPileSingle(
    each withTemperatureInputs=withTemperatureInputs,
    TGroundTop=TGroundTop,
    TGroundUndisturbed=TGroundUndisturbed,
    TGroundBottom=TGroundBottom,
    n=n,
    boreholeDepth=boreholeDepth,
    boreholeDiameter=boreholeDiameter,
    pipeType=pipeType,
    nParallel=nParallel,
    T0=T0,
    pipeCentreReferenceCircle=pipeCentreReferenceCircle,
    medium=medium,
    groundVolumeDiamter=groundVolumeDiamter,
    nRad=nRad)
    annotation (Placement(transformation(extent={{-16,-16},{30,30}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (
      Placement(transformation(extent={{-98,90},{-78,110}}), iconTransformation(
          extent={{-88,90},{-68,110}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (
      Placement(transformation(extent={{84,90},{104,110}}),
        iconTransformation(extent={{72,90},{92,110}})));
  Modelica.Blocks.Interfaces.RealInput groundTopTemp_input if
    withTemperatureInputs "Input for the top ground temperature" annotation (
      Placement(transformation(extent={{-140,10},{-100,50}}),
        iconTransformation(extent={{-140,2},{-100,42}})));
  Modelica.Blocks.Interfaces.RealInput groundUndisturbedTemp_input if
    withTemperatureInputs
    "Input for undisturbed ground temperature in a sufficient distance to the borhole"
    annotation (Placement(transformation(extent={{-140,-26},{-100,14}}),
        iconTransformation(extent={{-140,-98},{-100,-58}})));
  Modelica.Blocks.Interfaces.RealInput groundBottomTemp_input if
    withTemperatureInputs
    "Input for the bottom ground temperature of the borehole" annotation (
      Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-110}),
        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-12,-120})));
  parameter Integer n=4 "Number of axial discretizations, 
    n = 1 is the top one";
  Modelica.Blocks.Math.Gain gain(k=noOfBoreholes - 1)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={66,82})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{48,72},{28,92}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(T0=T0[1, 1], m_fluid=1)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={10,82})));
  parameter Modelica.SIunits.Length boreholeDepth = 100
    "Total depth of the borehole";
  parameter Modelica.SIunits.Diameter boreholeDiameter=0.2
    "Total diameter of the borehole";
  parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeType=
      AixLib.DataBase.Pipes.PE_X.DIN_16893_SDR11_d40() "Type of pipe"
    annotation (Dialog(group="Pipes"), choicesAllMatching=true);
  parameter Integer nParallel(min=1, max=2)=2 "1: U-Pipe, 2: Double-U-Pipe" annotation (Dialog(group="Pipes"));
  parameter Modelica.SIunits.Temperature T0[n, nRad] = fill(12, n, nRad)
    "Initial temperature of ground for the different ground layers";
  parameter Modelica.SIunits.Diameter pipeCentreReferenceCircle=sqrt(0.07*0.07
       + 0.07*0.07)
    "Diameter of the reference circle on which the centres of all the pipes are arranged";
  parameter Integer nRad=5 "Number of radial discretizations, 
    nRad=1 is the most inner one";
  type specificHeat = Real(final unit = "W/m");
  specificHeat q_flowSpecific=Q_flowTotal/(boreholeDepth*noOfBoreholes)
    "Specific heat extraction of the EnergyPileGroup in [W/m]";
  Real Re=energyPileSingle.uPipe.uPipeElement[1].dynamicPipeAggregated.pipeBase.heatConvPipeInside[1].Re
    "Reynolds number of the flow inside the heat exchanger pipes";
  Modelica.Blocks.Interfaces.RealOutput Q_flowTotal
    "Total heat flow gained from bore hole field"
    annotation (Placement(
        transformation(extent={{98,-20},{118,0}}), iconTransformation(extent={{100,
            -36},{120,-16}})));
  Modelica.Blocks.Math.Gain gain1(k=noOfBoreholes)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={82,-10})));
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium=
      AixLib.FastHVAC.Media.WaterSimple()
    "Standard  charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);
  AixLib.FastHVAC.Components.Valves.Splitter splitter(n=noOfBoreholes)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-8,58})));
  AixLib.FastHVAC.Components.Valves.Manifold manifold(n=noOfBoreholes)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={24,58})));
  parameter Modelica.SIunits.Length groundVolumeDiamter=10
    "Outer diameter of volume of surrounding ground";
equation
  connect(groundTopTemp_input, energyPileSingle.groundTopTemp_input)
    annotation (Line(points={{-120,30},{-44,30},{-44,12.06},{-20.6,12.06}},
        color={0,0,127}));
  connect(groundUndisturbedTemp_input, energyPileSingle.groundUndisturbedTemp_input)
    annotation (Line(points={{-120,-6},{-72,-6},{-72,-10.94},{-20.6,-10.94}},
        color={0,0,127}));
  connect(groundBottomTemp_input, energyPileSingle.groundBottomTemp_input)
    annotation (Line(points={{0,-110},{4.24,-110},{4.24,-20.6}}, color={0,0,127}));
  connect(energyPileSingle.heatFlowSingleBorehole, gain.u) annotation (Line(
        points={{32.3,16.2},{86,16.2},{86,82},{78,82}}, color={0,0,127}));
  connect(gain.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{55,82},{48,82}}, color={0,0,127}));
  connect(workingFluid.enthalpyPort_b, enthalpyPort_b1)
    annotation (Line(points={{10,91},{10,100},{94,100}}, color={176,0,0}));
  connect(workingFluid.heatPort, prescribedHeatFlow.port)
    annotation (Line(points={{19.4,82},{28,82}}, color={191,0,0}));
  connect(gain1.y, Q_flowTotal)
    annotation (Line(points={{93,-10},{108,-10}}, color={0,0,127}));
  connect(energyPileSingle.heatFlowSingleBorehole, gain1.u) annotation (Line(
        points={{32.3,16.2},{44,16.2},{44,-10},{70,-10}}, color={0,0,127}));
  connect(enthalpyPort_a1, splitter.enthalpyPort_a)
    annotation (Line(points={{-88,100},{-8,100},{-8,68}}, color={176,0,0}));
  connect(splitter.enthalpyPort_b[1], energyPileSingle.enthalpyPort_a1)
    annotation (Line(points={{-8,48},{-8,40},{-8,30},{-8.64,30}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_a, manifold.enthalpyPort_b) annotation (
      Line(points={{10,73},{18,73},{18,68},{24,68}}, color={176,0,0}));
  connect(energyPileSingle.enthalpyPort_b1, manifold.enthalpyPort_a[1])
    annotation (Line(points={{24.94,30},{24.94,39},{24,39},{24,48}}, color={176,
          0,0}));
  for i in 2:noOfBoreholes loop
    connect(splitter.enthalpyPort_b[i], manifold.enthalpyPort_a[i]) annotation (Line(points={{-8,48},
            {24,48}},                                                                                          color={176,0,0}));
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,20},{100,-100}},
          pattern=LinePattern.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,26},{100,20}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,26},{10,-100}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-6,26},{-2,-100}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{4,26},{8,-100}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-4,0},{-4,-16},{-18,56},{-2,40}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-4,44},{-48,36}},
          color={0,0,0},
          pattern=LinePattern.None),
        Rectangle(
          extent={{-100,100},{100,26}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={27,183,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-96,0},{-44,50},{-138,30},{-130,0},{-132,56},{-140,34},{-126,
              48},{-124,62},{-118,32},{-114,40}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-6,60},{-6,28},{-14,36},{2,36},{-6,28}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{8,28},{8,60},{0,52},{16,52},{8,60}},
          color={0,0,0},
          thickness=1),
        Rectangle(
          extent={{-46,26},{-28,-100}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-34,26},{-30,-100}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-44,26},{-40,-100}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{68,26},{86,-100}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{80,26},{84,-100}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{70,26},{74,-100}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-82,26},{-64,-100}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-70,26},{-66,-100}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-80,26},{-76,-100}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{28,26},{32,-100}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{26,26},{44,-100}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{38,26},{42,-100}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{28,26},{32,-100}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EnergyPileGroup;
