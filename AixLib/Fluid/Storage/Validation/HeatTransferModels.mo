within AixLib.Fluid.Storage.Validation;
model HeatTransferModels
  "Comparison of Heat Transfer models for StorageDetailed"

  extends Modelica.Icons.Example;
  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;
  AixLib.Fluid.Storage.StorageDetailed storageLambdaFall(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    m1_flow_nominal=boundaryHC1In.m_flow,
    m2_flow_nominal=boundaryBottom1.m_flow,
    mHC1_flow_nominal=boundaryHC1In.m_flow,
    n=50,
    redeclare package Medium = Medium,
    data=AixLib.DataBase.Storage.Generic_New_2000l(),
    useHeatingCoil1=true,
    useHeatingCoil2=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferLambdaEffSmooth,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart={333.15,332.15,331.15,330.15,329.15,328.15,327.15,326.15,325.15,
        324.15,323.15,322.15,321.15,320.15,319.15,318.15,317.15,316.15,315.15,
        314.15,313.15,312.15,311.15,310.15,309.15,308.15,307.15,306.15,305.15,
        304.15,303.15,302.15,301.15,300.15,299.15,298.15,297.15,296.15,295.15,
        294.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,
        293.15})
    annotation (Placement(transformation(extent={{-10,-12},{10,12}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{42,-6},
            {22,14}})));
  AixLib.Fluid.Sources.Boundary_pT boundaryTop2(redeclare package Medium =
        Medium, nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={32,34})));
  AixLib.Fluid.Sources.MassFlowSource_T boundaryBottom2(
    use_m_flow_in=true,
    m_flow=0,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-30})));
  AixLib.Fluid.Sources.MassFlowSource_T boundaryHC1In(
    use_m_flow_in=true,
    m_flow=0.5*THex_in.k,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-34,18})));
  AixLib.Fluid.Sources.Boundary_pT boundaryHC1Out(redeclare package Medium =
        Medium, nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-35,-1})));
  StorageDetailed storageBuoyancyWetter(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    m1_flow_nominal=boundaryHC1In.m_flow,
    m2_flow_nominal=boundaryBottom1.m_flow,
    mHC1_flow_nominal=boundaryHC1In.m_flow,
    n=50,
    redeclare package Medium = Medium,
    data=AixLib.DataBase.Storage.Generic_New_2000l(),
    useHeatingCoil1=true,
    useHeatingCoil2=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart={333.15,332.15,331.15,330.15,329.15,328.15,327.15,326.15,325.15,
        324.15,323.15,322.15,321.15,320.15,319.15,318.15,317.15,316.15,315.15,
        314.15,313.15,312.15,311.15,310.15,309.15,308.15,307.15,306.15,305.15,
        304.15,303.15,302.15,301.15,300.15,299.15,298.15,297.15,296.15,295.15,
        294.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,
        293.15})
    annotation (Placement(transformation(extent={{-10,88},{10,112}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=283.15)  annotation(Placement(transformation(extent={{42,94},
            {22,114}})));
  Sources.Boundary_pT boundaryTop1(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={32,134})));
  Sources.MassFlowSource_T              boundaryBottom1(
    use_m_flow_in=true,
    m_flow=0,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,70})));
  Sources.MassFlowSource_T boundaryHC1In1(
    use_m_flow_in=true,
    m_flow=0.5*THex_in.k,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-34,118})));
  Sources.Boundary_pT              boundaryHC1Out1(redeclare package Medium =
        Medium, nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-35,99})));
  StorageDetailed storageLambdaDetailed(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    m1_flow_nominal=boundaryHC1In.m_flow,
    m2_flow_nominal=boundaryBottom1.m_flow,
    mHC1_flow_nominal=boundaryHC1In.m_flow,
    n=50,
    redeclare package Medium = Medium,
    data=AixLib.DataBase.Storage.Generic_New_2000l(),
    useHeatingCoil1=true,
    useHeatingCoil2=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferLambdaDetailed,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart={333.15,332.15,331.15,330.15,329.15,328.15,327.15,326.15,325.15,
        324.15,323.15,322.15,321.15,320.15,319.15,318.15,317.15,316.15,315.15,
        314.15,313.15,312.15,311.15,310.15,309.15,308.15,307.15,306.15,305.15,
        304.15,303.15,302.15,301.15,300.15,299.15,298.15,297.15,296.15,295.15,
        294.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,
        293.15})
    annotation (Placement(transformation(extent={{-10,-110},{10,-86}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T=283.15)  annotation(Placement(transformation(extent={{42,-104},
            {22,-84}})));
  Sources.Boundary_pT boundaryTop3(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={32,-64})));
  Sources.MassFlowSource_T              boundaryBottom3(
    use_m_flow_in=true,
    m_flow=0,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-128})));
  Sources.MassFlowSource_T boundaryHC1In2(
    use_m_flow_in=true,
    m_flow=0.5*THex_in.k,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-34,-80})));
  Sources.Boundary_pT              boundaryHC1Out2(redeclare package Medium =
        Medium, nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-35,-99})));
  Modelica.Blocks.Sources.Trapezoid mHex_flow_in(
    period=7200,
    amplitude=1,
    nperiod=2,
    offset=0,
    rising=1800,
    width=1800,
    falling=1800,
    startTime=3600) "Control signal for mass flow rate in heat exchanger"
    annotation (Placement(transformation(extent={{-100,18},{-80,38}})));
  Modelica.Blocks.Sources.Constant THex_in(k=273.15 + 70) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-10})));
  Modelica.Blocks.Sources.Constant Tbottom_in(k=273.15 + 10) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,-10})));
  Modelica.Blocks.Sources.Trapezoid mbottom_flow_in(
    period=3720,
    amplitude=0.5,
    nperiod=1,
    offset=0,
    rising=60,
    width=3600,
    falling=60,
    startTime=6*3600) "Control signal for mass flow rate in heat exchanger"
    annotation (Placement(transformation(extent={{100,18},{80,38}})));
equation
  connect(boundaryBottom2.ports[1], storageLambdaFall.fluidportBottom2)
    annotation (Line(points={{20,-30},{2.875,-30},{2.875,-12.12}}, color={0,127,
          255}));
  connect(fixedTemperature.port, storageLambdaFall.heatportOutside) annotation (
     Line(points={{22,4},{16,4},{16,0.72},{9.75,0.72}}, color={191,0,0}));
  connect(boundaryHC1In.ports[1], storageLambdaFall.portHC1In) annotation (Line(
        points={{-28,18},{-14,18},{-14,6.84},{-10.25,6.84}}, color={0,127,255}));
  connect(boundaryHC1Out.ports[1], storageLambdaFall.portHC1Out) annotation (
      Line(points={{-30,-1},{-30,-2},{-16,-2},{-16,3.12},{-10.125,3.12}}, color
        ={0,127,255}));
  connect(boundaryTop2.ports[1], storageLambdaFall.fluidportTop2) annotation (
      Line(points={{22,34},{3.125,34},{3.125,12.12}}, color={0,127,255}));
  connect(boundaryBottom1.ports[1], storageBuoyancyWetter.fluidportBottom2)
    annotation (Line(points={{20,70},{2.875,70},{2.875,87.88}}, color={0,127,
          255}));
  connect(fixedTemperature1.port, storageBuoyancyWetter.heatportOutside)
    annotation (Line(points={{22,104},{16,104},{16,100.72},{9.75,100.72}},
        color={191,0,0}));
  connect(boundaryHC1In1.ports[1], storageBuoyancyWetter.portHC1In) annotation (
     Line(points={{-28,118},{-14,118},{-14,106.84},{-10.25,106.84}}, color={0,
          127,255}));
  connect(boundaryHC1Out1.ports[1], storageBuoyancyWetter.portHC1Out)
    annotation (Line(points={{-30,99},{-16,99},{-16,103.12},{-10.125,103.12}},
        color={0,127,255}));
  connect(boundaryTop1.ports[1], storageBuoyancyWetter.fluidportTop2)
    annotation (Line(points={{22,134},{3.125,134},{3.125,112.12}}, color={0,127,
          255}));
  connect(boundaryBottom3.ports[1], storageLambdaDetailed.fluidportBottom2)
    annotation (Line(points={{20,-128},{2.875,-128},{2.875,-110.12}}, color={0,
          127,255}));
  connect(fixedTemperature2.port, storageLambdaDetailed.heatportOutside)
    annotation (Line(points={{22,-94},{16,-94},{16,-97.28},{9.75,-97.28}},
        color={191,0,0}));
  connect(boundaryHC1In2.ports[1], storageLambdaDetailed.portHC1In) annotation (
     Line(points={{-28,-80},{-14,-80},{-14,-91.16},{-10.25,-91.16}}, color={0,
          127,255}));
  connect(boundaryHC1Out2.ports[1], storageLambdaDetailed.portHC1Out)
    annotation (Line(points={{-30,-99},{-30,-100},{-16,-100},{-16,-94.88},{
          -10.125,-94.88}}, color={0,127,255}));
  connect(boundaryTop3.ports[1], storageLambdaDetailed.fluidportTop2)
    annotation (Line(points={{22,-64},{3.125,-64},{3.125,-85.88}}, color={0,127,
          255}));
  connect(mHex_flow_in.y, boundaryHC1In1.m_flow_in) annotation (Line(points={{
          -79,28},{-52,28},{-52,122.8},{-41.2,122.8}}, color={0,0,127}));
  connect(mHex_flow_in.y, boundaryHC1In.m_flow_in) annotation (Line(points={{
          -79,28},{-41.2,28},{-41.2,22.8}}, color={0,0,127}));
  connect(mHex_flow_in.y, boundaryHC1In2.m_flow_in) annotation (Line(points={{
          -79,28},{-52,28},{-52,-75.2},{-41.2,-75.2}}, color={0,0,127}));
  connect(THex_in.y, boundaryHC1In1.T_in) annotation (Line(points={{-79,-10},{
          -66,-10},{-66,120},{-41.2,120},{-41.2,120.4}}, color={0,0,127}));
  connect(THex_in.y, boundaryHC1In.T_in) annotation (Line(points={{-79,-10},{
          -66,-10},{-66,20.4},{-41.2,20.4}}, color={0,0,127}));
  connect(THex_in.y, boundaryHC1In2.T_in) annotation (Line(points={{-79,-10},{
          -66,-10},{-66,-77.6},{-41.2,-77.6}}, color={0,0,127}));
  connect(Tbottom_in.y, boundaryBottom1.T_in) annotation (Line(points={{79,-10},
          {52,-10},{52,74},{42,74}}, color={0,0,127}));
  connect(Tbottom_in.y, boundaryBottom2.T_in) annotation (Line(points={{79,-10},
          {52,-10},{52,-26},{42,-26}}, color={0,0,127}));
  connect(Tbottom_in.y, boundaryBottom3.T_in) annotation (Line(points={{79,-10},
          {52,-10},{52,-124},{42,-124}}, color={0,0,127}));
  connect(mbottom_flow_in.y, boundaryBottom1.m_flow_in) annotation (Line(points
        ={{79,28},{66,28},{66,78},{42,78}}, color={0,0,127}));
  connect(mbottom_flow_in.y, boundaryBottom2.m_flow_in) annotation (Line(points
        ={{79,28},{66,28},{66,-22},{42,-22}}, color={0,0,127}));
  connect(mbottom_flow_in.y, boundaryBottom3.m_flow_in) annotation (Line(points
        ={{79,28},{66,28},{66,-120},{42,-120}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,
            160}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{
            100,160}})),
    experiment(
      StopTime=36000,
      Interval=30,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Storage/Examples/StorageDetailedExample.mos" "Simulate and plot"),
    Documentation(info="<html>
<p><span style=\"font-family: Arial;\">This test model compares three heat transfer models. See each model for further details.</span></p>
<p><br><span style=\"font-family: Arial;\">1. HeatTransferBuoyancyWetter</span></p>
<p><span style=\"font-family: Arial;\">2. HeatTransferLambdaEffSmooth</span></p>
<p><span style=\"font-family: Arial;\">3. HeatTransferLambdaDetailed</span></p>
</html>", revisions="<html>
<p>September 1, 2025 by Ben Kadereit:</p>
<p>Implemented validation model for comparison. This is for #1600. </p>
</html>"));
end HeatTransferModels;
