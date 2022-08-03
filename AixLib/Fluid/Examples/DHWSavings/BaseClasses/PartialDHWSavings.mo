within AixLib.Fluid.Examples.DHWSavings.BaseClasses;
model PartialDHWSavings "Partial model for all cases"
  import DHWSavings;
  extends Modelica.Icons.Example;
  parameter BESMod.Systems.Demand.DHW.RecordsCollection.PartialDHWTap
    DHWProfile annotation (choicesAllMatching=true);

  parameter AixLib.Fluid.Examples.DHWSavings.Types.Schedule tempSchedule;
  parameter AixLib.Fluid.Examples.DHWSavings.Types.Schedule pumpSchedule;

  DHWSystem totalModel(
    p_start=300000,
    factorInsWall=0.1,
    factorInsAir=factorInsAir,
    TAmbWall=290.15,
    TAmbAir=290.15,
    final mDHW_flow_nominal=userProfiles.mDHW_flow_nominal,
    VolDHWDay(displayUnit="l") = 0.3,
    TSetDHW_nominal=TSetDHW_nominal,
    QBui_flow_nominal=15000,
    TSet_DHW(percentageDeath=0.9),
    QLosPerDay=QLosPerDay,
    DHWProfile=DHWProfile)
    annotation (Placement(transformation(extent={{-18,-40},{82,40}})));
  BESMod.Systems.Interfaces.SystemOutputs outputs
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));

  Modelica.Blocks.Sources.Constant constT(k=totalModel.TSetDHW_nominal)
 if tempSchedule == AixLib.Fluid.Examples.DHWSavings.Types.Schedule.Constant
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,90})));
  Modelica.Blocks.Sources.Constant constPump(k=1) if pumpSchedule == AixLib.Fluid.Examples.DHWSavings.Types.Schedule.Constant
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-10})));
  Modelica.Blocks.Sources.Pulse pulsePump(
    amplitude=1,
    width=50/6,
    period=86400,
    nperiod=-1,
    offset=0,
    startTime=7*3600) if pumpSchedule == AixLib.Fluid.Examples.DHWSavings.Types.Schedule.TwoHours
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-50})));
  Modelica.Blocks.Sources.Pulse pulseT(
    amplitude=totalModel.TSetDHW_nominal - totalModel.TDHWWaterCold,
    width=50/6,
    period=86400,
    nperiod=-1,
    offset=totalModel.TDHWWaterCold,
    startTime=7*3600) if tempSchedule == AixLib.Fluid.Examples.DHWSavings.Types.Schedule.TwoHours
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,50})));
  Modelica.Blocks.Sources.Pulse pulseT2(
    amplitude=totalModel.TSetDHW_nominal - totalModel.TDHWWaterCold,
    width=50/3,
    period=86400/2,
    nperiod=-1,
    offset=totalModel.TDHWWaterCold,
    startTime=7*3600) if tempSchedule == AixLib.Fluid.Examples.DHWSavings.Types.Schedule.TwoTimesTwoHours
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,10})));
  Modelica.Blocks.Sources.Pulse pulsePump2(
    amplitude=1,
    width=50/3,
    period=86400/2,
    nperiod=-1,
    offset=0,
    startTime=7*3600) if pumpSchedule == AixLib.Fluid.Examples.DHWSavings.Types.Schedule.TwoTimesTwoHours
                                                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-90})));
  parameter Modelica.Units.SI.Temperature TSetDHW_nominal
    "Nominal DHW temperature";
  parameter Real QLosPerDay=1 "Heat loss per day. MUST BE IN kWh/d";
  parameter Real factorInsAir=0.001
    "Insulation factor for pipe in basement connected to air";
  Modelica.Blocks.Sources.Pulse pulsePumpNight(
    amplitude=1,
    width=200/3,
    period=86400,
    nperiod=-1,
    offset=0,
    startTime=6*3600)
    if pumpSchedule == AixLib.Fluid.Examples.DHWSavings.Types.Schedule.Night
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-150,-50})));
  Modelica.Blocks.Sources.Pulse pulseTNight(
    amplitude=totalModel.TSetDHW_nominal - totalModel.TDHWWaterCold,
    width=200/3,
    period=86400,
    nperiod=-1,
    offset=totalModel.TDHWWaterCold,
    startTime=6*3600)
    if tempSchedule == AixLib.Fluid.Examples.DHWSavings.Types.Schedule.Night
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-150,50})));
equation
  connect(totalModel.outBusGen, outputs) annotation (Line(
      points={{82.8571,-0.363636},{102,-0.363636},{102,0}},
      color={255,204,51},
      thickness=0.5));
  connect(constT.y, totalModel.TSetDHW) annotation (Line(points={{-79,90},{-30,
          90},{-30,19.2727},{-20.8571,19.2727}},
                                             color={0,0,127}));
  connect(pulseT.y, totalModel.TSetDHW) annotation (Line(points={{-79,50},{-30,
          50},{-30,19.2727},{-20.8571,19.2727}},
                                             color={0,0,127}));
  connect(pulseT2.y, totalModel.TSetDHW) annotation (Line(points={{-79,10},{-30,
          10},{-30,19.2727},{-20.8571,19.2727}}, color={0,0,127}));
  connect(constPump.y, totalModel.circulatorPump) annotation (Line(points={{-79,-10},
          {-30,-10},{-30,-19.2727},{-20.8571,-19.2727}},      color={0,0,127}));
  connect(pulsePump.y, totalModel.circulatorPump) annotation (Line(points={{-79,-50},
          {-30,-50},{-30,-19.2727},{-20.8571,-19.2727}},      color={0,0,127}));
  connect(pulsePump2.y, totalModel.circulatorPump) annotation (Line(points={{-79,-90},
          {-30,-90},{-30,-19.2727},{-20.8571,-19.2727}},      color={0,0,127}));
  connect(pulsePumpNight.y, totalModel.circulatorPump) annotation (Line(points={{-139,
          -50},{-106,-50},{-106,-24},{-30,-24},{-30,-19.2727},{-20.8571,
          -19.2727}}, color={0,0,127}));
  connect(pulseTNight.y, totalModel.TSetDHW) annotation (Line(points={{-139,50},
          {-106,50},{-106,24},{-30,24},{-30,19.2727},{-20.8571,19.2727}}, color=
         {0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end PartialDHWSavings;
