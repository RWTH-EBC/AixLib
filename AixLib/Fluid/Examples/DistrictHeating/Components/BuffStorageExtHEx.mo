within AixLib.Fluid.Examples.DistrictHeating.Components;
model BuffStorageExtHEx
  "Buffer storage model with external heat exchanger for solar collectors"

  replaceable package Medium = AixLib.Media.Water;

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness hex(
  redeclare package Medium2 = Medium,
    dp1_nominal=600,
    dp2_nominal=600,
    eps=0.8,
    m1_flow_nominal=10,
    m2_flow_nominal=10,
    redeclare package Medium1 = Medium)
   annotation (Placement(
        transformation(
        extent={{-13,-12},{13,12}},
        rotation=90,
        origin={-29,0})));
  AixLib.Fluid.Storage.BufferStorage bufferStorage(
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    useHeatingRod=false,
    upToDownHC1=false,
    upToDownHC2=false,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    n=10,
    TStart=303.15,
    data=AixLib.DataBase.Storage.Generic_New_2000l(
        hTank=4.5,
        hUpperPorts=4.4,
        dTank=6,
        hTS2=1),
    TStartWall=303.15,
    TStartIns=303.15)
    annotation (Placement(transformation(extent={{-19,-24},{19,24}},
        rotation=0,
        origin={51,-2})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a( redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b( redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-56},{110,-36}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort SolarCollFlowTemp(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-72,-50},{-52,-30}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort SolarCollRetTemp(redeclare package
      Medium = Medium)
   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-62,40})));
  Modelica.Fluid.Sensors.TemperatureTwoPort StorageSideRetTemp(redeclare
      package Medium =                                                                    Medium)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=180,
        origin={76,-46})));
  AixLib.Fluid.Movers.FlowControlled_m_flow StgLoopPump(redeclare package
      Medium = Medium, m_flow_nominal=10)  annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=180,
        origin={3,-50})));
  Modelica.Fluid.Sensors.TemperatureTwoPort StorageSideFlowTemp(
                                                               redeclare
      package Medium =                                                                    Medium)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={74,40})));
  Modelica.Fluid.Sensors.TemperatureTwoPort StorageLoopOutTemp(redeclare
      package Medium = Medium) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={32,-50})));
  Modelica.Fluid.Sensors.TemperatureTwoPort StorageLoopInTemp(redeclare package
      Medium = Medium) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={30,40})));
  Modelica.Blocks.Interfaces.RealOutput StgTempTop
    annotation (Placement(transformation(extent={{94,72},{114,92}}),
        iconTransformation(extent={{94,72},{114,92}})));
  Modelica.Blocks.Interfaces.RealOutput StgTempBott
    annotation (Placement(transformation(extent={{96,-88},{116,-68}}),
        iconTransformation(extent={{96,-88},{116,-68}})));
  Modelica.Blocks.Interfaces.RealOutput TempSolColRet
    "Return temperature of solar collector " annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-106,76}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-104,80})));
  Modelica.Blocks.Interfaces.RealOutput TempSolCollFlow
    "Flow temperature of solar collector" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-106,-74}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-106,-80})));
  Modelica.Blocks.Interfaces.RealInput MassFlowStgLoop annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=90,
        origin={-16,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-96})));
equation
  connect(port_a, SolarCollFlowTemp.port_a)
    annotation (Line(points={{-100,-40},{-72,-40}}, color={0,127,255}));
  connect(SolarCollFlowTemp.port_b, hex.port_a1) annotation (Line(points={{-52,-40},
          {-36.2,-40},{-36.2,-13}}, color={0,127,255}));
  connect(hex.port_b1, SolarCollRetTemp.port_a) annotation (Line(points={{-36.2,
          13},{-36.2,40},{-52,40}}, color={0,127,255}));
  connect(SolarCollRetTemp.port_b, port_b)
    annotation (Line(points={{-72,40},{-100,40}}, color={0,127,255}));
  connect(port_a1, StorageSideRetTemp.port_a)
    annotation (Line(points={{100,-46},{84,-46}}, color={0,127,255}));
  connect(StorageSideRetTemp.port_b, bufferStorage.fluidportBottom2)
    annotation (Line(points={{68,-46},{56.4625,-46},{56.4625,-26.24}}, color={0,
          127,255}));
  connect(bufferStorage.fluidportTop2, StorageSideFlowTemp.port_a) annotation (
      Line(points={{56.9375,22.24},{56.9375,40},{66,40}}, color={0,127,255}));
  connect(StorageSideFlowTemp.port_b, port_b1)
    annotation (Line(points={{82,40},{100,40}}, color={0,127,255}));
  connect(bufferStorage.fluidportBottom1, StorageLoopOutTemp.port_a)
    annotation (Line(points={{44.5875,-26.48},{44.5875,-50},{40,-50}}, color={0,
          127,255}));
  connect(StorageLoopInTemp.port_b, bufferStorage.fluidportTop1) annotation (
      Line(points={{38,40},{44.35,40},{44.35,22.24}}, color={0,127,255}));
  connect(StorageLoopOutTemp.port_b, StgLoopPump.port_a)
    annotation (Line(points={{24,-50},{12,-50}}, color={0,127,255}));
  connect(StgLoopPump.port_b, hex.port_a2) annotation (Line(points={{-6,-50},{-12,
          -50},{-12,40},{-21.8,40},{-21.8,13}}, color={0,127,255}));
  connect(hex.port_b2, StorageLoopInTemp.port_a) annotation (Line(points={{
          -21.8,-13},{-21.8,-18},{8,-18},{8,40},{22,40}}, color={0,127,255}));
  connect(SolarCollRetTemp.T, TempSolColRet) annotation (Line(
      points={{-62,29},{-62,22},{-86,22},{-86,76},{-106,76}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(SolarCollFlowTemp.T, TempSolCollFlow) annotation (Line(
      points={{-62,-29},{-62,-20},{-84,-20},{-84,-74},{-106,-74}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(bufferStorage.TTop, StgTempTop) annotation (Line(
      points={{32,19.12},{30,19.12},{30,20},{14,20},{14,82},{104,82}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(bufferStorage.TBottom, StgTempBott) annotation (Line(
      points={{32,-21.2},{22,-21.2},{22,-34},{52,-34},{52,-78},{106,-78}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(MassFlowStgLoop, StgLoopPump.m_flow_in) annotation (Line(points={{-16,
          -100},{-16,-80},{3.18,-80},{3.18,-60.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{100,-100},{-100,100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={215,215,215}), Text(
          extent={{-76,86},{78,-76}},
          lineColor={28,108,200},
          textString="Seasonal 
heat storage")}),                                                Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{-30,-100}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-88,104},{-46,80}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="Solar collector side
"),     Rectangle(
          extent={{100,-100},{-30,100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={215,215,215}),       Text(
          extent={{14,100},{50,84}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="Heat storage side
")}));
end BuffStorageExtHEx;
