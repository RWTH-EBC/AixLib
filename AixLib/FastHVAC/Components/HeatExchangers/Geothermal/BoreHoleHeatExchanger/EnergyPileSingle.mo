within AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger;
model EnergyPileSingle
  parameter Boolean withTemperatureInputs = false
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

  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (
      Placement(transformation(extent={{-86,90},{-66,110}}), iconTransformation(
          extent={{-78,90},{-58,110}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (
      Placement(transformation(extent={{68,92},{88,112}}),
        iconTransformation(extent={{68,90},{88,110}})));
public
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature groundTopTemp
    "top temperature of the ground at the surface" annotation (Placement(transformation(extent={{-82,46},
            {-62,66}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    groundUndisturbedSurrounding if                       not
    withTemperatureInputs
    "Fixed temperature which is uneffected from the pipe itself"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
                                                         groundBottomTemp if
                          not withTemperatureInputs
    annotation (Placement(transformation(extent={{-82,-70},{-62,-50}})));

  AixLib.Fluid.HeatExchangers.Geothermal.Ground.RadialGround
                                                      radialGround(
    lambda=2,
    rho=1850,
    n=n,
    d_out=groundVolumeDiamter,
    c=838,
    nRad=nRad,
    T0=T0,
    length=uPipe.boreholeDepth,
    d_in=uPipe.boreholeDiameter)
    annotation (Placement(transformation(extent={{-42,-50},{20,14}})));

  AixLib.FastHVAC.Components.Sensors.TemperatureSensor
                                            ReturnTemperature
    annotation(Placement(transformation(extent={{100,64},{80,84}})));

  AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.UPipe
                                                              uPipe(
    T_start=T0[:, 1],
    n=n,
    medium=medium,
    boreholeDepth=boreholeDepth,
    boreholeDiameter=boreholeDiameter,
    boreholeFilling=AixLib.DataBase.Materials.FillingMaterials.Bentonite(),
    pipeType=pipeType,
    nParallel=nParallel,
    pipeCentreReferenceCircle=pipeCentreReferenceCircle)
    annotation (Placement(transformation(extent={{38,-56},{100,6}})));

  Modelica.Blocks.Interfaces.RealOutput
  temperatureArrayGround[radialGround.n, radialGround.nRad](unit="K",
      displayUnit="degC")
    "array with the ground temperatures, [length, width]- of the ground volume"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-100},{120,-80}})));

  Modelica.Blocks.Interfaces.RealInput groundTopTemp_input if
    withTemperatureInputs "Input for the top ground temperature" annotation (
      Placement(transformation(extent={{-140,34},{-100,74}}),
        iconTransformation(extent={{-140,2},{-100,42}})));

  Modelica.Blocks.Interfaces.RealInput groundUndisturbedTemp_input if
    withTemperatureInputs
    "Input for undisturbed ground temperature in a sufficient distance to the borhole"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-98},{-100,-58}})));

  Modelica.Blocks.Interfaces.RealInput groundBottomTemp_input if
    withTemperatureInputs
    "Input for the bottom ground temperature of the borehole" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-12,-120})));
  // internal inputs
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor FlowTemperature
    annotation (Placement(transformation(extent={{10,74},{30,94}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor[n]
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={32,-18})));
  parameter Integer n=4 "Number of axial discretizations, 
    n = 1 is the top one";
  Modelica.Blocks.Interfaces.RealOutput heatFlowSingleBorehole(unit="W",
      displayUnit="W") "The absorbed heat flow from a single borehole"
    annotation (Placement(transformation(extent={{100,34},{120,54}}),
        iconTransformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Math.Sum sumHeatFlowRate(nin=n)
    "Sums up the heatflow rate from the discretized pipe" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={38,26})));
  parameter Modelica.SIunits.Length boreholeDepth=108.45
    "Total depth of the borehole";
  parameter Modelica.SIunits.Diameter boreholeDiameter=0.2
    "Total diameter of the borehole";
  parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeType=
      AixLib.DataBase.Pipes.PE_X.DIN_16893_SDR11_d40() "Type of pipe"
      annotation (Dialog(group="Pipes"), choicesAllMatching=true);
  parameter Integer nParallel(min=1, max=2)=2 "1: U-Pipe, 2: Double-U-Pipe" annotation (Dialog(group="Pipes"));
  parameter Modelica.SIunits.Temperature T0[n, nRad] = fill(283.15, n, nRad)
    "Initial temperature of ground for the different ground layers";
  parameter Modelica.SIunits.Diameter pipeCentreReferenceCircle=sqrt(0.07*0.07
       + 0.07*0.07)
    "Diameter of the reference circle on which the centres of all the pipes are arranged";
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium=
      AixLib.FastHVAC.Media.WaterSimple()
    "Standard  charastics for water (heat capacity, density, thermal conductivity)"  annotation (choicesAllMatching);
  parameter Modelica.SIunits.Length groundVolumeDiamter=10
    "Outer diameter of volume of surrounding ground";
  parameter Integer nRad=5 "Number of radial discretizations, 
    nRad=1 is the most inner one";
protected
  Modelica.Blocks.Interfaces.RealInput TGroundTop_in_internal(
  final quantity="Temperature",
  final unit="K",
  displayUnit="degC") "Needed to connect to conditional connector";

  Modelica.Blocks.Interfaces.RealInput TGroundUndisturbed_in_internal(
  final quantity="Temperature",
  final unit="K",
  displayUnit="degC") "Needed to connect to conditional connector";

  Modelica.Blocks.Interfaces.RealInput TGroundBottom_in_internal(
  final quantity="Temperature",
  final unit="K",
  displayUnit="degC") "Needed to connect to conditional connector";

equation
  //---------------------------------------------------------------------------
  // Select temperature connectors
  if not withTemperatureInputs then
    TGroundTop_in_internal = TGroundTop;
    TGroundUndisturbed_in_internal = TGroundUndisturbed;
    TGroundBottom_in_internal = TGroundBottom;
  else
    connect(groundTopTemp_input, TGroundTop_in_internal);
    connect(groundUndisturbedTemp_input, TGroundUndisturbed_in_internal);
    connect(groundBottomTemp_input, TGroundBottom_in_internal);
  end if;
  connect(TGroundTop_in_internal, groundTopTemp.T);
  connect(TGroundUndisturbed_in_internal, groundUndisturbedSurrounding.T);
  connect(TGroundBottom_in_internal, groundBottomTemp.T);

//TGroundUndisturbed

  for i in 1:radialGround.nRad loop
    for j in 1:radialGround.n loop
      temperatureArrayGround[j, i] = radialGround.cylindricAxialHeatTransfer[j,
        i].innerTherm.T;
    end for;
  end for;

  connect(groundUndisturbedSurrounding.port,radialGround. outerThermalBoundary)
    annotation (Line(
      points={{-60,0},{-58,0},{-58,-18},{-38.9,-18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(groundBottomTemp.port,radialGround. bottomBoundary) annotation (
      Line(
      points={{-62,-60},{-10,-60},{-10,-46.8},{-10.38,-46.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(groundTopTemp.port,radialGround. topBoundary) annotation (Line(
      points={{-62,56},{4,56},{4,20},{3.88,20},{3.88,6.96}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(uPipe.enthalpyPort_b1, ReturnTemperature.enthalpyPort_a) annotation (
      Line(points={{76.75,6},{76.75,43},{98.8,43},{98.8,73.9}},  color={176,0,0}));
  connect(ReturnTemperature.enthalpyPort_b, enthalpyPort_b1) annotation (Line(
        points={{81,73.9},{79.5,73.9},{79.5,102},{78,102}},       color={176,0,0}));
  connect(FlowTemperature.enthalpyPort_b, uPipe.enthalpyPort_a1) annotation (
      Line(points={{29,83.9},{61.25,83.9},{61.25,6}}, color={176,0,0}));
  connect(FlowTemperature.enthalpyPort_a, enthalpyPort_a1) annotation (Line(
        points={{11.2,83.9},{-75.4,83.9},{-75.4,100},{-76,100}},color={176,0,0}));
  connect(sumHeatFlowRate.y, heatFlowSingleBorehole)
    annotation (Line(points={{38,37},{38,44},{110,44}}, color={0,0,127}));
  connect(heatFlowSensor.port_b, uPipe.thermalConnectors2Ground) annotation (
      Line(points={{42,-18},{48,-18},{48,-17.25},{53.5,-17.25}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, radialGround.innerConnectors) annotation (Line(
        points={{22,-18},{2,-18},{2,1.2},{-22.16,1.2}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, sumHeatFlowRate.u) annotation (Line(points={{32,
          -8},{36,-8},{36,14},{38,14}}, color={0,0,127}));
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
          thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end EnergyPileSingle;
