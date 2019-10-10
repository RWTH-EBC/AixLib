within AixLib.Systems.Benchmark.Model.Generation;
model HighTemperatureSystem
  "Boiler and chp system for high temperature generation"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;


  Boiler_Benchmark boiler(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    transferHeat=true,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_60kW(),
    TAmb=298.15)
    annotation (Placement(transformation(extent={{28,116},{52,140}})));

  Fluid.BoilerCHP.CHP cHP(
    electricityDriven=true,
    TSetIn=true,
    redeclare package Medium = Medium,
    minCapacity=24,
    transferHeat=true,
    param=DataBase.CHP.CHPDataSimple.CHP_FMB_31_GSK(),
    final m_flow_nominal=m_flow_nominal,
    TAmb=298.15)
    annotation (Placement(transformation(extent={{-52,116},{-28,140}})));

  HydraulicModules.Pump pumpCHP(
    redeclare package Medium = Medium,
    T_amb=298.15,
    final m_flow_nominal=m_flow_nominal,
    dIns=0.01,
    kIns=0.028,
    d=0.32,
    length=1,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per)),
    pipe3(length=2)) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,80})));

  HydraulicModules.Pump pumpBoiler(
    redeclare package Medium = Medium,
    T_amb=298.15,
    final m_flow_nominal=m_flow_nominal,
    dIns=0.01,
    kIns=0.028,
    d=0.32,
    length=1,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per)),
    pipe3(length=2)) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,80})));
  BaseClasses.HighTempSysBus highTempSysBus annotation (Placement(
        transformation(extent={{-14,146},{14,174}}),iconTransformation(extent={{-14,128},
            {12,154}})));
  Fluid.Storage.BufferStorage HotWater(
    useHeatingCoil1=false,
    useHeatingRod=false,
    n=5,
    useHeatingCoil2=false,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    data=DataBase.Storage.Generic_22000l(),
    TStart=343.15)
    annotation (Placement(transformation(extent={{-16,0},{16,40}})));
equation
  connect(pumpCHP.port_b1, cHP.port_a)
    annotation (Line(points={{-52,100},{-52,128}},
                                                 color={0,127,255}));
  connect(pumpCHP.port_a2, cHP.port_b)
    annotation (Line(points={{-28,100},{-28,128}},
                                                 color={0,127,255}));
  connect(pumpBoiler.port_b1, boiler.port_a)
    annotation (Line(points={{28,100},{28,128}},
                                               color={0,127,255}));
  connect(pumpBoiler.port_a2, boiler.port_b)
    annotation (Line(points={{52,100},{52,128}},
                                               color={0,127,255}));
  connect(pumpCHP.hydraulicBus, highTempSysBus.pumpCHPBus) annotation (Line(
      points={{-60,80},{-74,80},{-74,160.07},{0.07,160.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pumpBoiler.hydraulicBus, highTempSysBus.pumpBoilerBus) annotation (
      Line(
      points={{20,80},{10,80},{10,84},{0.07,84},{0.07,160.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.TSet, highTempSysBus.Tset_chp) annotation (Line(points={{-48.4,
          120.8},{-64,120.8},{-64,160.07},{0.07,160.07}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boiler.TSet, highTempSysBus.Tset_boiler) annotation (Line(points={{31.6,
          136.4},{0.07,136.4},{0.07,160.07}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(HotWater.fluidportTop2, port_b) annotation (Line(points={{5,40.2},{5,
          46},{30,46},{30,0},{100,0}}, color={0,127,255}));
  connect(HotWater.fluidportBottom2, port_a) annotation (Line(points={{4.6,-0.2},
          {4.6,-20},{-80,-20},{-80,0},{-100,0}}, color={0,127,255}));
  connect(pumpBoiler.port_a1, pumpCHP.port_a1) annotation (Line(points={{28,60},
          {28,50},{-52,50},{-52,60}}, color={0,127,255}));
  connect(pumpCHP.port_a1, HotWater.fluidportBottom1) annotation (Line(points={
          {-52,60},{-52,-0.4},{-5.4,-0.4}}, color={0,127,255}));
  connect(pumpCHP.port_b2, pumpBoiler.port_b2) annotation (Line(points={{-28,60},
          {-28,54},{52,54},{52,60}}, color={0,127,255}));
  connect(pumpCHP.port_b2, HotWater.fluidportTop1) annotation (Line(points={{
          -28,60},{-28,54},{-5.6,54},{-5.6,40.2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -60},{100,140}}), graphics={
        Rectangle(
          extent={{-100,140},{100,-60}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Rectangle(extent={{-80,100},{-20,60}}, lineColor={0,0,0}),
        Rectangle(extent={{20,120},{64,60}}, lineColor={0,0,0}),
        Text(
          extent={{-68,90},{-34,64}},
          lineColor={0,0,0},
          textString="CHP"),
        Text(
          extent={{26,98},{60,72}},
          lineColor={0,0,0},
          textString="Boiler"),
        Line(points={{-56,60},{-56,36},{30,36},{30,60}}, color={28,108,200}),
        Line(points={{-34,60},{-34,28},{60,28},{60,52},{60,60}}, color={35,138,
              255}),
        Rectangle(
          extent={{-18,22},{22,-40}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=0.5),
        Rectangle(
          extent={{-18,22},{22,-40}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(points={{-56,44},{-56,-32},{-18,-32}}, color={28,108,200}),
        Line(points={{-34,34},{-34,14},{-18,14}}, color={35,138,255}),
        Line(points={{90,0},{60,0},{60,12},{22,12}}, color={35,138,255}),
        Line(points={{22,-30},{40,-30},{40,-52},{-80,-52},{-80,0},{-94,0}},
            color={28,108,200}),
        Ellipse(
          extent={{-64,56},{-48,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-56,56},{-64,48}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-48,48},{-56,56}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{22,56},{38,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{30,56},{22,48}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{38,48},{30,56}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},{100,140}})));
end HighTemperatureSystem;
