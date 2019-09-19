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
    annotation (Placement(transformation(extent={{28,56},{52,80}})));

  Fluid.BoilerCHP.CHP cHP(
    electricityDriven=true,
    TSetIn=true,
    redeclare package Medium = Medium,
    minCapacity=24,
    transferHeat=true,
    param=DataBase.CHP.CHPDataSimple.CHP_FMB_31_GSK(),
    final m_flow_nominal=m_flow_nominal,
    TAmb=298.15)
    annotation (Placement(transformation(extent={{-52,56},{-28,80}})));

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
        origin={-40,20})));
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
        origin={40,20})));
  BaseClasses.HighTempSysBus highTempSysBus annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={
            {-136,24},{-116,44}})));
equation
  connect(port_a, pumpCHP.port_a1) annotation (Line(points={{-100,0},{-100,-20},
          {-52,-20},{-52,0}}, color={0,127,255}));
  connect(pumpCHP.port_b1, cHP.port_a)
    annotation (Line(points={{-52,40},{-52,68}}, color={0,127,255}));
  connect(pumpCHP.port_a2, cHP.port_b)
    annotation (Line(points={{-28,40},{-28,68}}, color={0,127,255}));
  connect(pumpBoiler.port_b1, boiler.port_a)
    annotation (Line(points={{28,40},{28,68}}, color={0,127,255}));
  connect(pumpBoiler.port_a2, boiler.port_b)
    annotation (Line(points={{52,40},{52,68}}, color={0,127,255}));
  connect(pumpBoiler.port_a1, pumpCHP.port_a1) annotation (Line(points={{28,0},
          {28,-20},{-52,-20},{-52,0}}, color={0,127,255}));
  connect(pumpCHP.port_b2, port_b) annotation (Line(points={{-28,0},{-28,-10},{
          100,-10},{100,0}}, color={0,127,255}));
  connect(pumpBoiler.port_b2, port_b) annotation (Line(points={{52,0},{52,-10},
          {100,-10},{100,0}}, color={0,127,255}));
  connect(pumpCHP.hydraulicBus, highTempSysBus.pumpCHPBus) annotation (Line(
      points={{-60,20},{-74,20},{-74,100.05},{0.05,100.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pumpBoiler.hydraulicBus, highTempSysBus.pumpBoilerBus) annotation (
      Line(
      points={{20,20},{10,20},{10,24},{0.05,24},{0.05,100.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.TSet, highTempSysBus.Tset_chp) annotation (Line(points={{-48.4,
          60.8},{-64,60.8},{-64,100.05},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boiler.TSet, highTempSysBus.Tset_boiler) annotation (Line(points={{
          31.6,76.4},{0.05,76.4},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighTemperatureSystem;
