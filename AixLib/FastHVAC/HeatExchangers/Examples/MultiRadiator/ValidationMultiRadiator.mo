within AixLib.FastHVAC.HeatExchangers.Examples.MultiRadiator;
model ValidationMultiRadiator

  extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedConvHeatFlow(Q_flow=-4500)
    annotation (Placement(transformation(extent={{-36,80},{-16,100}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedConvHeatFlow1(Q_flow=-1500)
    annotation (Placement(transformation(extent={{-42,-40},{-22,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedConvHeatFlow2(Q_flow=-1500)
             annotation (Placement(transformation(extent={{-42,-20},{-22,0}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedConvHeatFlow3(Q_flow=-1500)
             annotation (Placement(transformation(extent={{-42,0},{-22,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedRadHeatFlow(Q_flow=-150)
    annotation (Placement(transformation(extent={{36,82},{16,102}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedRadHeatFlow1(Q_flow=-50)
    annotation (Placement(transformation(extent={{66,-40},{46,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedRadHeatFlow2(Q_flow=-50)
    annotation (Placement(transformation(extent={{66,-22},{46,-2}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedRadHeatFlow3(Q_flow=-50)
    annotation (Placement(transformation(extent={{66,-2},{46,18}})));
  AixLib.FastHVAC.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{70,58},{90,78}})));
  AixLib.FastHVAC.Sinks.Vessel vessel1
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  AixLib.FastHVAC.Pumps.FluidSource fluidSource(medium=
        Media.FastHvac.WaterSimple())
    annotation (Placement(transformation(extent={{-42,56},{-22,76}})));
  AixLib.FastHVAC.Pumps.FluidSource fluidSource1(medium=
        Media.FastHvac.WaterSimple())
    annotation (Placement(transformation(extent={{-52,-76},{-32,-56}})));
  AixLib.FastHVAC.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{34,74},{52,56}})));
  AixLib.FastHVAC.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{56,-46},{76,-66}})));
  AixLib.FastHVAC.HeatExchangers.RadiatorMultiLayer radiator_ML(
    selectable=true,
    medium=Media.FastHvac.WaterSimple(),
    radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom())
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  AixLib.FastHVAC.HeatExchangers.RadiatorMultiLayer radiator_ML1(
    selectable=true,
    medium=Media.FastHvac.WaterSimple(),
    radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom())
    annotation (Placement(transformation(extent={{0,-36},{20,-16}})));
  AixLib.FastHVAC.HeatExchangers.RadiatorMultiLayer radiator_ML2(
    selectable=true,
    medium=Media.FastHvac.WaterSimple(),
    radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom())
    annotation (Placement(transformation(extent={{0,-84},{20,-64}})));
  Modelica.Blocks.Sources.Constant Tset(k=273.15 + 75)
    annotation (Placement(transformation(extent={{-114,10},{-94,30}})));
  AixLib.FastHVAC.HeatExchangers.MultiRadiator multiRadiator(
    n=3,
    selectable=true,
    medium=Media.FastHvac.WaterSimple(),
    radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom())
    annotation (Placement(transformation(extent={{-10,52},{12,78}})));
  Modelica.Blocks.Sources.Constant dotMSet(k=0.111)
    annotation (Placement(transformation(extent={{-114,-20},{-94,0}})));
  Valves.Splitter splitter(nOut=3, nIn=1)
    annotation (Placement(transformation(extent={{-32,-60},{-12,-40}})));
equation
  connect(temperatureSensor1.enthalpyPort_b, vessel1.enthalpyPort_a)
    annotation (Line(
      points={{75,-55.9},{78.5,-55.9},{78.5,-50},{83,-50}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor.enthalpyPort_b, vessel.enthalpyPort_a) annotation (
      Line(
      points={{51.1,65.09},{73.5,65.09},{73.5,68},{73,68}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(splitter.enthalpyPort_b[2], radiator_ML.enthalpyPort_a1) annotation (
      Line(
      points={{-12,-50},{-4,-50},{-4,-50.2},{2,-50.2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(splitter.enthalpyPort_b[1], radiator_ML2.enthalpyPort_a1) annotation (
     Line(
      points={{-12,-50.6667},{-4,-50.6667},{-4,-74.2},{2,-74.2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(splitter.enthalpyPort_b[3], radiator_ML1.enthalpyPort_a1) annotation (
     Line(
      points={{-12,-49.3333},{-4,-49.3333},{-4,-26.2},{2,-26.2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(fixedConvHeatFlow1.port, radiator_ML2.ConvectiveHeat) annotation (
      Line(
      points={{-22,-30},{0,-30},{0,-68.2},{4.6,-68.2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedConvHeatFlow2.port, radiator_ML.ConvectiveHeat) annotation (Line(
      points={{-22,-10},{0,-10},{0,-44},{4,-44},{4,-44.2},{4.6,-44.2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedConvHeatFlow3.port, radiator_ML1.ConvectiveHeat) annotation (
      Line(
      points={{-22,10},{0,10},{0,-20},{4,-20},{4,-20.2},{4.6,-20.2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedRadHeatFlow3.port, radiator_ML1.RadiativeHeat) annotation (Line(
      points={{46,8},{18,8},{18,-20},{15.6,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedRadHeatFlow2.port, radiator_ML.RadiativeHeat) annotation (Line(
      points={{46,-12},{20,-12},{20,-44},{15.6,-44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedRadHeatFlow1.port, radiator_ML2.RadiativeHeat) annotation (Line(
      points={{46,-30},{20,-30},{20,-68},{15.6,-68}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Tset.y, fluidSource.T_fluid) annotation (Line(
      points={{-93,20},{-93,80},{-40,80},{-40,70.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tset.y, fluidSource1.T_fluid) annotation (Line(
      points={{-93,20},{-54,20},{-54,-62},{-50,-62},{-50,-61.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiRadiator.enthalpyPort_b, temperatureSensor.enthalpyPort_a)
    annotation (Line(
      points={{12,65},{32,65},{32,65.09},{35.08,65.09}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(fluidSource.enthalpyPort_b, multiRadiator.enthalpyPort_a) annotation
    (Line(
      points={{-23,68},{-16,68},{-16,65},{-10,65}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(multiRadiator.ConvectiveHeat, fixedConvHeatFlow.port) annotation (
      Line(
      points={{-3.4,75.4},{-9.7,75.4},{-9.7,90},{-16,90}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(fixedRadHeatFlow.port, multiRadiator.RadiativeHeat)
    annotation (Line(points={{16,92},{5.4,92},{5.4,75.4}}, color={191,0,0}));
  connect(dotMSet.y, fluidSource.m_flow) annotation (Line(points={{-93,-10},{-68,
          -10},{-68,63.4},{-40,63.4}}, color={0,0,127}));
  connect(dotMSet.y, fluidSource1.m_flow) annotation (Line(points={{-93,-10},{-70,
          -10},{-70,-68.6},{-50,-68.6}}, color={0,0,127}));
  connect(fluidSource1.enthalpyPort_b, splitter.enthalpyPort_a[1])
    annotation (Line(points={{-33,-64},{-32,-64},{-32,-50}}, color={176,0,0}));
  connect(radiator_ML.enthalpyPort_b1, temperatureSensor1.enthalpyPort_a)
    annotation (Line(points={{18,-50.2},{28,-50.2},{28,-50},{38,-50},{38,-55.9},
          {57.2,-55.9}}, color={176,0,0}));
  connect(radiator_ML2.enthalpyPort_b1, temperatureSensor1.enthalpyPort_a)
    annotation (Line(points={{18,-74.2},{38,-74.2},{38,-55.9},{57.2,-55.9}},
        color={176,0,0}));
  connect(radiator_ML1.enthalpyPort_b1, temperatureSensor1.enthalpyPort_a)
    annotation (Line(points={{18,-26.2},{38,-26.2},{38,-55.9},{57.2,-55.9}},
        color={176,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), experiment(StopTime=86400));
end ValidationMultiRadiator;
