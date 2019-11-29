within AixLib.Systems.Benchmark.ControlStrategies;
package MODI
  model ManagementEbene "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten für die Temperature und relative Luftfeuchtigkeit im Raum"
    PNlib.Components.T disableHeating[5](
      each nIn=1,
      each nOut=1,
      firingCon={bus_measure.RoomTemp_Workshop > 273.15 + 15,
      bus_measure.RoomTemp_Canteen > 273.15 + 20,
      bus_measure.RoomTemp_Conferenceroom > 273.15 + 20,
           bus_measure.RoomTemp_Multipersonoffice> 273.15 + 20,
           bus_measure.RoomTemp_Openplanoffice > 273.15 + 20})
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={50,30})));
    PNlib.Components.T enableHeating[5](
      each nIn=1,
      each nOut=1,
      firingCon={bus_measure.RoomTemp_Workshop < 273.15 + 15,
      bus_measure.RoomTemp_Canteen < 273.15 + 20,
      bus_measure.RoomTemp_Conferenceroom < 273.15 + 20,
           bus_measure.RoomTemp_Multipersonoffice< 273.15 + 20,
           bus_measure.RoomTemp_Openplanoffice < 273.15 + 20})
      annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
    PNlib.Components.PD Heating[5](
      each nIn=1,
      each nOut=1,
      each startTokens=0,
      each minTokens=0,
      each maxTokens=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={90,0})));
    PNlib.Components.PD Off[5](
      each nIn=2,
      each nOut=2,
      each startTokens=1,
      each maxTokens=1,
      each reStart=true,
      each reStartTokens=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    PNlib.Components.PD Cooling[5](
      each nIn=1,
      each nOut=1,
      each maxTokens=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-90,0})));
    PNlib.Components.T enableCooling[5](
      each nIn=1,
      each nOut=1,
      firingCon={bus_measure.RoomTemp_Workshop > 273.15 + 17,
      bus_measure.RoomTemp_Canteen > 273.15 + 22,
      bus_measure.RoomTemp_Conferenceroom > 273.15 + 22,
           bus_measure.RoomTemp_Multipersonoffice> 273.15 + 22,
           bus_measure.RoomTemp_Openplanoffice > 273.15 + 22}) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-50,30})));
    PNlib.Components.T disableCooling[5](
      each nIn=1,
      each nOut=1,
      firingCon={bus_measure.RoomTemp_Workshop < 273.15 + 17,
      bus_measure.RoomTemp_Canteen < 273.15 + 22,
      bus_measure.RoomTemp_Conferenceroom < 273.15 + 22,
           bus_measure.RoomTemp_Multipersonoffice< 273.15 + 22,
           bus_measure.RoomTemp_Openplanoffice < 273.15 + 22})
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    Modelica.Blocks.Interfaces.IntegerOutput y[5] annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-110})));
    Model.BusSystems.Bus_measure bus_measure
      annotation (Placement(transformation(extent={{-18,60},{22,100}})));
    Modelica.Blocks.Interfaces.IntegerOutput y1[5] annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-110})));
    Modelica.Blocks.Interfaces.IntegerOutput y2[5] annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,-112})));
  equation

    connect(Off[1].pd_t, y[1])
      annotation (Line(points={{0,10.6},{0,-102}},color={255,127,0}));
    connect(Off[2].pd_t, y[2])
      annotation (Line(points={{0,10.6},{0,-106}}, color={255,127,0}));
    connect(Off[3].pd_t, y[3])
      annotation (Line(points={{0,10.6},{0,-110}}, color={255,127,0}));
    connect(Off[4].pd_t, y[4])
      annotation (Line(points={{0,10.6},{0,-114}},          color={255,127,0}));
    connect(Off[5].pd_t, y[5])
      annotation (Line(points={{0,10.6},{0,-118}}, color={255,127,0}));
    connect(Cooling[1].pd_t, y1[1]) annotation (Line(points={{-79.4,0},{-80,0},
            {-80,-102}},               color={255,127,0}));
    connect(Cooling[2].pd_t, y1[2]) annotation (Line(points={{-79.4,0},{-80,0},
            {-80,-106}},                color={255,127,0}));
    connect(Cooling[3].pd_t, y1[3]) annotation (Line(points={{-79.4,0},{-80,0},
            {-80,-110}},                color={255,127,0}));
    connect(Cooling[4].pd_t, y1[4]) annotation (Line(points={{-79.4,0},{-80,0},
            {-80,-114}},                color={255,127,0}));
    connect(Cooling[5].pd_t, y1[5]) annotation (Line(points={{-79.4,0},{-80,0},
            {-80,-118}},                color={255,127,0}));
    connect(Heating[1].pd_t, y2[1]) annotation (Line(points={{79.4,0},{80,0},{
            80,-104}},          color={255,127,0}));
    connect(Heating[2].pd_t, y2[2]) annotation (Line(points={{79.4,0},{80,0},{
            80,-108}},           color={255,127,0}));
    connect(Heating[3].pd_t, y2[3]) annotation (Line(points={{79.4,0},{80,0},{
            80,-112}},           color={255,127,0}));
    connect(Heating[4].pd_t, y2[4]) annotation (Line(points={{79.4,0},{80,0},{
            80,-116}},           color={255,127,0}));
    connect(Heating[5].pd_t, y2[5]) annotation (Line(points={{79.4,0},{80,0},{
            80,-120}},           color={255,127,0}));
    connect(Off[1].outTransition[1], enableHeating[1].inPlaces[1]) annotation (
        Line(points={{10.8,-0.5},{10,-0.5},{10,-30},{45.2,-30}}, color={0,0,0}));
    connect(Off[2].outTransition[1], enableHeating[2].inPlaces[1]) annotation (
        Line(points={{10.8,-0.5},{10,-0.5},{10,-30},{45.2,-30}}, color={0,0,0}));
    connect(Off[3].outTransition[1], enableHeating[3].inPlaces[1]) annotation (
        Line(points={{10.8,-0.5},{10,-0.5},{10,-30},{45.2,-30}}, color={0,0,0}));
    connect(Off[4].outTransition[1], enableHeating[4].inPlaces[1]) annotation (
        Line(points={{10.8,-0.5},{10,-0.5},{10,-30},{45.2,-30}}, color={0,0,0}));
    connect(Off[5].outTransition[1], enableHeating[5].inPlaces[1]) annotation (
        Line(points={{10.8,-0.5},{10,-0.5},{10,-30},{45.2,-30}}, color={0,0,0}));
    connect(enableHeating[1].outPlaces[1], Heating[1].inTransition[1])
      annotation (Line(points={{54.8,-30},{90,-30},{90,-10.8}}, color={0,0,0}));
    connect(enableHeating[2].outPlaces[1], Heating[2].inTransition[1])
      annotation (Line(points={{54.8,-30},{90,-30},{90,-10.8}}, color={0,0,0}));
    connect(enableHeating[3].outPlaces[1], Heating[3].inTransition[1])
      annotation (Line(points={{54.8,-30},{90,-30},{90,-10.8}}, color={0,0,0}));
    connect(enableHeating[4].outPlaces[1], Heating[4].inTransition[1])
      annotation (Line(points={{54.8,-30},{90,-30},{90,-10.8}}, color={0,0,0}));
    connect(enableHeating[5].outPlaces[1], Heating[5].inTransition[1])
      annotation (Line(points={{54.8,-30},{90,-30},{90,-10.8}}, color={0,0,0}));
    connect(Heating[1].outTransition[1], disableHeating[1].inPlaces[1])
      annotation (Line(points={{90,10.8},{90,30},{54.8,30}}, color={0,0,0}));
    connect(Heating[2].outTransition[1], disableHeating[2].inPlaces[1])
      annotation (Line(points={{90,10.8},{90,30},{54.8,30}}, color={0,0,0}));
    connect(Heating[3].outTransition[1], disableHeating[3].inPlaces[1])
      annotation (Line(points={{90,10.8},{90,30},{54.8,30}}, color={0,0,0}));
    connect(Heating[4].outTransition[1], disableHeating[4].inPlaces[1])
      annotation (Line(points={{90,10.8},{90,30},{54.8,30}}, color={0,0,0}));
    connect(Heating[5].outTransition[1], disableHeating[5].inPlaces[1])
      annotation (Line(points={{90,10.8},{90,30},{54.8,30}}, color={0,0,0}));
    connect(disableHeating[1].outPlaces[1], Off[1].inTransition[1]) annotation (
        Line(points={{45.2,30},{-12,30},{-12,-0.5},{-10.8,-0.5}}, color={0,0,0}));
    connect(disableHeating[2].outPlaces[1], Off[2].inTransition[1]) annotation (
        Line(points={{45.2,30},{-12,30},{-12,-0.5},{-10.8,-0.5}}, color={0,0,0}));
    connect(disableHeating[3].outPlaces[1], Off[3].inTransition[1]) annotation (
        Line(points={{45.2,30},{-12,30},{-12,-0.5},{-10.8,-0.5}}, color={0,0,0}));
    connect(disableHeating[4].outPlaces[1], Off[4].inTransition[1]) annotation (
        Line(points={{45.2,30},{-12,30},{-12,-0.5},{-10.8,-0.5}}, color={0,0,0}));
    connect(disableHeating[5].outPlaces[1], Off[5].inTransition[1]) annotation (
        Line(points={{45.2,30},{-12,30},{-12,-0.5},{-10.8,-0.5}}, color={0,0,0}));
    connect(enableCooling[1].outPlaces[1], Cooling[1].inTransition[1])
      annotation (Line(points={{-54.8,30},{-90,30},{-90,10.8}}, color={0,0,0}));
    connect(enableCooling[2].outPlaces[1], Cooling[2].inTransition[1])
      annotation (Line(points={{-54.8,30},{-90,30},{-90,10.8}}, color={0,0,0}));
    connect(enableCooling[3].outPlaces[1], Cooling[3].inTransition[1])
      annotation (Line(points={{-54.8,30},{-90,30},{-90,10.8}}, color={0,0,0}));
    connect(enableCooling[4].outPlaces[1], Cooling[4].inTransition[1])
      annotation (Line(points={{-54.8,30},{-90,30},{-90,10.8}}, color={0,0,0}));
    connect(enableCooling[5].outPlaces[1], Cooling[5].inTransition[1])
      annotation (Line(points={{-54.8,30},{-90,30},{-90,10.8}}, color={0,0,0}));
    connect(Cooling[1].outTransition[1], disableCooling[1].inPlaces[1])
      annotation (Line(points={{-90,-10.8},{-90,-30},{-54.8,-30}}, color={0,0,0}));
    connect(Cooling[2].outTransition[1], disableCooling[2].inPlaces[1])
      annotation (Line(points={{-90,-10.8},{-90,-30},{-54.8,-30}}, color={0,0,0}));
    connect(Cooling[3].outTransition[1], disableCooling[3].inPlaces[1])
      annotation (Line(points={{-90,-10.8},{-90,-30},{-54.8,-30}}, color={0,0,0}));
    connect(Cooling[4].outTransition[1], disableCooling[4].inPlaces[1])
      annotation (Line(points={{-90,-10.8},{-90,-30},{-54.8,-30}}, color={0,0,0}));
    connect(Cooling[5].outTransition[1], disableCooling[5].inPlaces[1])
      annotation (Line(points={{-90,-10.8},{-90,-30},{-54.8,-30}}, color={0,0,0}));
    connect(Off[1].outTransition[2], enableCooling[1].inPlaces[1]) annotation (
        Line(points={{10.8,0.5},{10,0.5},{10,30},{-45.2,30}}, color={0,0,0}));
    connect(Off[2].outTransition[2], enableCooling[2].inPlaces[1]) annotation (
        Line(points={{10.8,0.5},{10,0.5},{10,30},{-45.2,30}}, color={0,0,0}));
    connect(Off[3].outTransition[2], enableCooling[3].inPlaces[1]) annotation (
        Line(points={{10.8,0.5},{10,0.5},{10,30},{-45.2,30}}, color={0,0,0}));
    connect(Off[4].outTransition[2], enableCooling[4].inPlaces[1]) annotation (
        Line(points={{10.8,0.5},{10,0.5},{10,30},{-45.2,30}}, color={0,0,0}));
    connect(Off[5].outTransition[2], enableCooling[5].inPlaces[1]) annotation (
        Line(points={{10.8,0.5},{10,0.5},{10,30},{-45.2,30}}, color={0,0,0}));
    connect(disableCooling[1].outPlaces[1], Off[1].inTransition[2]) annotation (
        Line(points={{-45.2,-30},{-12,-30},{-12,0.5},{-10.8,0.5}}, color={0,0,0}));
    connect(disableCooling[2].outPlaces[1], Off[2].inTransition[2]) annotation (
        Line(points={{-45.2,-30},{-12,-30},{-12,0.5},{-10.8,0.5}}, color={0,0,0}));
    connect(disableCooling[3].outPlaces[1], Off[3].inTransition[2]) annotation (
        Line(points={{-45.2,-30},{-12,-30},{-12,0.5},{-10.8,0.5}}, color={0,0,0}));
    connect(disableCooling[4].outPlaces[1], Off[4].inTransition[2]) annotation (
        Line(points={{-45.2,-30},{-12,-30},{-12,0},{-10,0},{-10,0.5},{-10.8,0.5}},
          color={0,0,0}));
    connect(disableCooling[5].outPlaces[1], Off[5].inTransition[2]) annotation (
        Line(points={{-45.2,-30},{-12,-30},{-12,0.5},{-10.8,0.5}}, color={0,0,0}));
      annotation (Line(points={{-60,-106},{-60,-106}}, color={255,127,0}),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ManagementEbene;

  model Automatisierungsebene "Zuordnung der Betriebsmodi zu den entsprechenden Aktorsätzen"
    Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,120})));
    Modelica.Blocks.Interfaces.IntegerOutput y annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-110})));
    Modelica.Blocks.Interfaces.IntegerInput u1 annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={92,120})));
    Modelica.Blocks.Interfaces.IntegerInput u2 annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-90,120})));
    PNlib.Components.PD Workshop_Off_MXXX(
      nIn=2,
      nOut=2,
      startTokens=1,
      reStart=true,
      reStartTokens=1)
      annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
    PNlib.Components.T T1(nIn=1, nOut=4)
      annotation (Placement(transformation(extent={{34,60},{54,80}})));
    PNlib.Components.T T2(nIn=2, nOut=2) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={44,50})));
    PNlib.Components.PD Workshop_Heating_MXXX(nIn=2, nOut=2) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={90,60})));
    PNlib.Components.PD Workshop_Heating_MXXX1(nIn=1, nOut=1) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={90,2})));
    PNlib.Components.PD Generation_Hot_MXXX(nIn=2, nOut=2) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={90,-56})));
    PNlib.Components.PD Generation_Warm_MXXX(nIn=2, nOut=2) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={92,-88})));
    PNlib.Components.PD Generation_Cold_MXXX(nIn=2, nOut=2) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-88,-82})));
    PNlib.Components.PD Workshop_Cooling_MXXX(nIn=2, nOut=2) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-88,-14})));
    PNlib.Components.PD Workshop_Cooling_MXXX1(nIn=2, nOut=2) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-86,58})));
  equation
    connect(Workshop_Off_MXXX.outTransition[1], T1.inPlaces[1]) annotation (
        Line(points={{8.8,-0.5},{8,-0.5},{8,70},{39.2,70}}, color={0,0,0}));
    connect(T1.outPlaces[1], Workshop_Heating_MXXX.inTransition[1]) annotation
      (Line(points={{48.8,69.25},{80,69.25},{80,59.5},{79.2,59.5}}, color={0,0,
            0}));
    connect(Workshop_Heating_MXXX.outTransition[1], T2.inPlaces[1]) annotation
      (Line(points={{100.8,59.5},{100,59.5},{100,50},{32,50},{32,50.5},{48.8,
            50.5}}, color={0,0,0}));
    connect(T2.outPlaces[1], Workshop_Off_MXXX.inTransition[1]) annotation (
        Line(points={{39.2,50.5},{-14,50.5},{-14,-0.5},{-12.8,-0.5}}, color={0,
            0,0}));
    connect(T1.outPlaces[2], Generation_Hot_MXXX.inTransition[1]) annotation (
        Line(points={{48.8,69.75},{58,69.75},{58,-56},{68,-56},{68,-56.5},{79.2,
            -56.5}}, color={0,0,0}));
    connect(T1.outPlaces[3], Generation_Warm_MXXX.inTransition[1]) annotation (
        Line(points={{48.8,70.25},{58,70.25},{58,-88.5},{81.2,-88.5}}, color={0,
            0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Automatisierungsebene;

  model Feldebene "Auswahl der Aktoren basierend auf den ausgewählten Aktorsätzen"
    Model.BusSystems.Bus_Control bus_Control
      annotation (Placement(transformation(extent={{-20,-114},{20,-74}})));
    Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,100})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Feldebene;

  model Gesamtsystem
    ManagementEbene managementEbene
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Automatisierungsebene automatisierungsebene
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Feldebene feldebene
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Model.BusSystems.Bus_measure bus_measure
      annotation (Placement(transformation(extent={{50,50},{90,90}})));
    Model.BusSystems.Bus_Control bus_Control
      annotation (Placement(transformation(extent={{52,-92},{92,-52}})));
  equation
    connect(bus_measure, managementEbene.bus_measure) annotation (Line(
        points={{70,70},{-28,70},{-28,58},{-29.8,58}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(feldebene.bus_Control, bus_Control) annotation (Line(
        points={{-30,-39.4},{-30,-72},{72,-72}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(managementEbene.y1, automatisierungsebene.u2) annotation (Line(
          points={{-38,39},{-38,22},{-39,22}}, color={255,127,0}));
    connect(managementEbene.y, automatisierungsebene.u)
      annotation (Line(points={{-30,39},{-30,22}}, color={255,127,0}));
    connect(managementEbene.y2, automatisierungsebene.u1) annotation (Line(
          points={{-22,38.8},{-22,30},{-22,22},{-20.8,22}}, color={255,127,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Gesamtsystem;
end MODI;
