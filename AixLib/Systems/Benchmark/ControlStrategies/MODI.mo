within AixLib.Systems.Benchmark.ControlStrategies;

package MODI
  model ManagementEbene "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten für die Temperature und relative Luftfeuchtigkeit im Raum"
    PNlib.Components.T disableHeating[5](each nIn = 1, each nOut = 1, firingCon = {bus_measure.RoomTemp_Workshop > 273.15 + 15, bus_measure.RoomTemp_Canteen > 273.15 + 20, bus_measure.RoomTemp_Conferenceroom > 273.15 + 20, bus_measure.RoomTemp_Multipersonoffice > 273.15 + 20, bus_measure.RoomTemp_Openplanoffice > 273.15 + 20}) annotation(
      Placement(visible = true, transformation(origin = {-56, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T enableHeating[5](each nIn = 1, each nOut = 1, firingCon = {bus_measure.RoomTemp_Workshop < 273.15 + 15, bus_measure.RoomTemp_Canteen < 273.15 + 20, bus_measure.RoomTemp_Conferenceroom < 273.15 + 20, bus_measure.RoomTemp_Multipersonoffice < 273.15 + 20, bus_measure.RoomTemp_Openplanoffice < 273.15 + 20}) annotation(
      Placement(visible = true, transformation(extent = {{-66, 20}, {-46, 40}}, rotation = 0)));
    PNlib.Components.PD Heating[5](each nIn = 1, each nOut = 1, each startTokens = 0, each minTokens = 0, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD Off_Temperature[5](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1, each reStart = true, each reStartTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Cooling[5](each nIn = 1, each nOut = 1, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-182, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T enableCooling[5](each nIn = 1, each nOut = 1, firingCon = {bus_measure.RoomTemp_Workshop > 273.15 + 17, bus_measure.RoomTemp_Canteen > 273.15 + 22, bus_measure.RoomTemp_Conferenceroom > 273.15 + 22, bus_measure.RoomTemp_Multipersonoffice > 273.15 + 22, bus_measure.RoomTemp_Openplanoffice > 273.15 + 22}) annotation(
      Placement(visible = true, transformation(origin = {-144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T disableCooling[5](each nIn = 1, each nOut = 1, firingCon = {bus_measure.RoomTemp_Workshop < 273.15 + 17, bus_measure.RoomTemp_Canteen < 273.15 + 22, bus_measure.RoomTemp_Conferenceroom < 273.15 + 22, bus_measure.RoomTemp_Multipersonoffice < 273.15 + 22, bus_measure.RoomTemp_Openplanoffice < 273.15 + 22}) annotation(
      Placement(visible = true, transformation(extent = {{-154, 20}, {-134, 40}}, rotation = 0)));
    Modelica.Blocks.Interfaces.IntegerOutput MODI_Temperature[15] annotation(
      Placement(visible = true, transformation(origin = {-100, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 270), iconTransformation(origin = {-100, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Model.BusSystems.Bus_measure bus_measure annotation(
      Placement(transformation(extent = {{-18, 60}, {22, 100}})));
  PNlib.Components.PD Dehumidifying[5](nIn = 1, nOut = 1)  annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD Off_Humidity[5](nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1)  annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Humidifying[5](nIn = 1, nOut = 1, reStartTokens = 1, startTokens = 1)  annotation(
      Placement(visible = true, transformation(origin = {184, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T enableHumidifying[5](nIn = 1, nOut = 1)  annotation(
      Placement(visible = true, transformation(origin = {146, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T enableDehumidifying[5](nIn = 1, nOut = 1)  annotation(
      Placement(visible = true, transformation(origin = {58, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T disableDehumidifying[5](nIn = 1, nOut = 1)  annotation(
      Placement(visible = true, transformation(origin = {56, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T disableHumidifying[5](nIn = 1, nOut = 1)  annotation(
      Placement(visible = true, transformation(origin = {144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.IntegerOutput MODI_Humidity[15] annotation(
      Placement(visible = true, transformation(origin = {100, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {100, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(Dehumidifying[5].pd_t, MODI_Humidity[15]) annotation(
      Line(points = {{10, 0}, {4, 0}, {4, -80}, {100, -80}, {100, -102}, {100, -102}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Dehumidifying[4].pd_t, MODI_Humidity[14]) annotation(
      Line(points = {{10, 0}, {4, 0}, {4, -80}, {100, -80}, {100, -102}, {100, -102}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Dehumidifying[3].pd_t, MODI_Humidity[13]) annotation(
      Line(points = {{10, 0}, {4, 0}, {4, -80}, {100, -80}, {100, -100}, {100, -100}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Dehumidifying[2].pd_t, MODI_Humidity[12]) annotation(
      Line(points = {{10, 0}, {4, 0}, {4, -80}, {100, -80}, {100, -102}, {100, -102}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Dehumidifying[1].pd_t, MODI_Humidity[11]) annotation(
      Line(points = {{10, 0}, {4, 0}, {4, -80}, {100, -80}, {100, -102}, {100, -102}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Humidifying[5].pd_t, MODI_Humidity[10]) annotation(
      Line(points = {{194, 0}, {198, 0}, {198, -80}, {100, -80}, {100, -104}, {100, -104}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Humidifying[4].pd_t, MODI_Humidity[9]) annotation(
      Line(points = {{194, 0}, {198, 0}, {198, -80}, {100, -80}, {100, -102}, {100, -102}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Humidifying[3].pd_t, MODI_Humidity[8]) annotation(
      Line(points = {{194, 0}, {198, 0}, {198, -80}, {100, -80}, {100, -102}, {100, -102}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Humidifying[2].pd_t, MODI_Humidity[7]) annotation(
      Line(points = {{194, 0}, {198, 0}, {198, -80}, {100, -80}, {100, -102}, {100, -102}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Humidifying[1].pd_t, MODI_Humidity[6]) annotation(
      Line(points = {{194, 0}, {198, 0}, {198, -80}, {100, -80}, {100, -104}, {100, -104}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Off_Humidity[5].pd_t, MODI_Humidity[5]) annotation(
      Line(points = {{100, -10}, {100, -10}, {100, -110}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Off_Humidity[4].pd_t, MODI_Humidity[4]) annotation(
      Line(points = {{100, -10}, {100, -10}, {100, -110}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Off_Humidity[3].pd_t, MODI_Humidity[3]) annotation(
      Line(points = {{100, -10}, {100, -10}, {100, -110}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Off_Humidity[2].pd_t, MODI_Humidity[2]) annotation(
      Line(points = {{100, -10}, {100, -10}, {100, -110}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Off_Humidity[1].pd_t, MODI_Humidity[1]) annotation(
      Line(points = {{100, -10}, {100, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(disableDehumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[2]) annotation(
      Line(points = {{60, 30}, {112, 30}, {112, 0}, {110, 0}}, thickness = 0.5));
    connect(disableDehumidifying[5].outPlaces[1], Off_Humidity[5].inTransition[2]) annotation(
      Line(points = {{60, 30}, {112, 30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(disableDehumidifying[4].outPlaces[1], Off_Humidity[4].inTransition[2]) annotation(
      Line(points = {{60, 30}, {112, 30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(disableDehumidifying[3].outPlaces[1], Off_Humidity[3].inTransition[2]) annotation(
      Line(points = {{60, 30}, {112, 30}, {112, 0}, {112, 0}, {112, 0}, {110, 0}}, thickness = 0.5));
    connect(disableDehumidifying[2].outPlaces[1], Off_Humidity[2].inTransition[2]) annotation(
      Line(points = {{60, 30}, {112, 30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(Off_Humidity[5].outTransition[1], enableHumidifying[5].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, 30}, {141, 30}}, thickness = 0.5));
    connect(Off_Humidity[4].outTransition[1], enableHumidifying[4].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, 30}, {141, 30}}, thickness = 0.5));
    connect(Off_Humidity[3].outTransition[1], enableHumidifying[3].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, 30}, {141, 30}}, thickness = 0.5));
    connect(Off_Humidity[2].outTransition[1], enableHumidifying[2].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, 30}, {141, 30}}, thickness = 0.5));
    connect(Off_Humidity[1].outTransition[1], enableHumidifying[1].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, 30}, {141, 30}}, thickness = 0.5));
    connect(enableHumidifying[5].outPlaces[1], Humidifying[5].inTransition[1]) annotation(
      Line(points = {{151, 30}, {184, 30}, {184, 10}}, thickness = 0.5));
    connect(enableHumidifying[4].outPlaces[1], Humidifying[4].inTransition[1]) annotation(
      Line(points = {{151, 30}, {184, 30}, {184, 10}}, thickness = 0.5));
    connect(enableHumidifying[3].outPlaces[1], Humidifying[3].inTransition[1]) annotation(
      Line(points = {{151, 30}, {184, 30}, {184, 10}}, thickness = 0.5));
    connect(enableHumidifying[2].outPlaces[1], Humidifying[2].inTransition[1]) annotation(
      Line(points = {{151, 30}, {184, 30}, {184, 10}}, thickness = 0.5));
    connect(enableHumidifying[1].outPlaces[1], Humidifying[1].inTransition[1]) annotation(
      Line(points = {{151, 30}, {184, 30}, {184, 10}}, thickness = 0.5));
    connect(disableDehumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[2]) annotation(
      Line(points = {{60, 30}, {112, 30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(disableHumidifying[5].outPlaces[1], Off_Humidity[5].inTransition[1]) annotation(
      Line(points = {{140, -30}, {112, -30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(disableHumidifying[4].outPlaces[1], Off_Humidity[4].inTransition[1]) annotation(
      Line(points = {{140, -30}, {112, -30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(disableHumidifying[3].outPlaces[1], Off_Humidity[3].inTransition[1]) annotation(
      Line(points = {{140, -30}, {112, -30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(disableHumidifying[2].outPlaces[1], Off_Humidity[2].inTransition[1]) annotation(
      Line(points = {{140, -30}, {112, -30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(disableHumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[1]) annotation(
      Line(points = {{140, -30}, {112, -30}, {112, 0}, {110, 0}, {110, 0}}, thickness = 0.5));
    connect(Off_Humidity[5].outTransition[2], enableDehumidifying[5].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, -30}, {62, -30}, {62, -30}}, thickness = 0.5));
    connect(Off_Humidity[4].outTransition[2], enableDehumidifying[4].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, -30}, {64, -30}, {64, -30}, {62, -30}}, thickness = 0.5));
    connect(Off_Humidity[3].outTransition[2], enableDehumidifying[3].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, -30}, {62, -30}, {62, -30}}, thickness = 0.5));
    connect(Off_Humidity[2].outTransition[2], enableDehumidifying[2].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, -30}, {62, -30}, {62, -30}}, thickness = 0.5));
    connect(Off_Humidity[1].outTransition[2], enableDehumidifying[1].inPlaces[1]) annotation(
      Line(points = {{90, 0}, {88, 0}, {88, -30}, {64, -30}, {64, -30}, {62, -30}}, thickness = 0.5));
    connect(Dehumidifying[5].outTransition[1], disableDehumidifying[5].inPlaces[1]) annotation(
      Line(points = {{20, 10}, {20, 10}, {20, 30}, {52, 30}, {52, 30}}, thickness = 0.5));
    connect(Dehumidifying[4].outTransition[1], disableDehumidifying[4].inPlaces[1]) annotation(
      Line(points = {{20, 10}, {20, 10}, {20, 30}, {52, 30}, {52, 30}}, thickness = 0.5));
    connect(Dehumidifying[3].outTransition[1], disableDehumidifying[3].inPlaces[1]) annotation(
      Line(points = {{20, 10}, {20, 10}, {20, 30}, {52, 30}, {52, 30}}, thickness = 0.5));
    connect(Dehumidifying[2].outTransition[1], disableDehumidifying[2].inPlaces[1]) annotation(
      Line(points = {{20, 10}, {20, 10}, {20, 30}, {52, 30}, {52, 30}}, thickness = 0.5));
    connect(Dehumidifying[1].outTransition[1], disableDehumidifying[1].inPlaces[1]) annotation(
      Line(points = {{20, 10}, {20, 10}, {20, 30}, {52, 30}, {52, 30}}, thickness = 0.5));
    connect(enableDehumidifying[5].outPlaces[1], Dehumidifying[5].inTransition[1]) annotation(
      Line(points = {{54, -30}, {20, -30}, {20, -12}, {20, -12}, {20, -10}}, thickness = 0.5));
    connect(enableDehumidifying[4].outPlaces[1], Dehumidifying[4].inTransition[1]) annotation(
      Line(points = {{54, -30}, {20, -30}, {20, -12}, {20, -12}, {20, -10}}, thickness = 0.5));
    connect(enableDehumidifying[3].outPlaces[1], Dehumidifying[3].inTransition[1]) annotation(
      Line(points = {{54, -30}, {20, -30}, {20, -12}, {20, -12}, {20, -10}}, thickness = 0.5));
  connect(enableDehumidifying[2].outPlaces[1], Dehumidifying[2].inTransition[1]) annotation(
      Line(points = {{54, -30}, {20, -30}, {20, -12}, {20, -12}, {20, -10}}, thickness = 0.5));
  connect(enableDehumidifying[1].outPlaces[1], Dehumidifying[1].inTransition[1]) annotation(
      Line(points = {{54, -30}, {20, -30}, {20, -12}, {20, -12}, {20, -10}}, thickness = 0.5));
    connect(Humidifying[4].outTransition[1], disableHumidifying[4].inPlaces[1]) annotation(
      Line(points = {{184, -10}, {184, -10}, {184, -30}, {148, -30}, {148, -30}}, thickness = 0.5));
    connect(Humidifying[3].outTransition[1], disableHumidifying[3].inPlaces[1]) annotation(
      Line(points = {{184, -10}, {184, -10}, {184, -30}, {148, -30}, {148, -30}}, thickness = 0.5));
    connect(Humidifying[2].outTransition[1], disableHumidifying[2].inPlaces[1]) annotation(
      Line(points = {{184, -10}, {184, -10}, {184, -30}, {148, -30}, {148, -30}}, thickness = 0.5));
    connect(Humidifying[1].outTransition[1], disableHumidifying[1].inPlaces[1]) annotation(
      Line(points = {{184, -10}, {184, -30}, {148, -30}}, thickness = 0.5));
    connect(enableHeating[5].outPlaces[1], Heating[5].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 11}}));
  connect(disableCooling[5].outPlaces[1], Off_Temperature[5].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, 0}}, thickness = 0.5));
  connect(disableCooling[4].outPlaces[1], Off_Temperature[4].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, 0}}, thickness = 0.5));
  connect(disableCooling[3].outPlaces[1], Off_Temperature[3].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, 0}}, thickness = 0.5));
  connect(disableCooling[2].outPlaces[1], Off_Temperature[2].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, 0}}, thickness = 0.5));
  connect(disableCooling[1].outPlaces[1], Off_Temperature[1].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, 0}}, thickness = 0.5));
    connect(Cooling[5].outTransition[1], disableCooling[5].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 29.8}, {-149, 29.8}}));
    connect(Cooling[4].outTransition[1], disableCooling[4].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 29.8}, {-149, 29.8}}));
    connect(Cooling[3].outTransition[1], disableCooling[3].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 29.8}, {-149, 29.8}}));
    connect(Cooling[2].outTransition[1], disableCooling[2].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 29.8}, {-149, 29.8}}));
    connect(Cooling[1].outTransition[1], disableCooling[1].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 29.8}, {-149, 29.8}}));
  connect(Off_Temperature[5].outTransition[2], enableCooling[5].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-111.8, 0}, {-111.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}}, thickness = 0.5));
  connect(Off_Temperature[4].outTransition[2], enableCooling[4].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}}, thickness = 0.5));
  connect(Off_Temperature[3].outTransition[2], enableCooling[3].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-111.8, 0}, {-111.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}}, thickness = 0.5));
  connect(Off_Temperature[2].outTransition[2], enableCooling[2].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}}, thickness = 0.5));
  connect(Off_Temperature[1].outTransition[2], enableCooling[1].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}}, thickness = 0.5));
    connect(enableCooling[5].outPlaces[1], Cooling[5].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -20.5}, {-181.8, -11}}));
    connect(enableCooling[4].outPlaces[1], Cooling[4].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -20.5}, {-181.8, -11}}));
    connect(enableCooling[3].outPlaces[1], Cooling[3].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -20.5}, {-181.8, -11}}));
    connect(enableCooling[2].outPlaces[1], Cooling[2].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -20.5}, {-181.8, -11}}));
    connect(enableCooling[1].outPlaces[1], Cooling[1].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -20.5}, {-181.8, -11}}));
  connect(Cooling[5].pd_t, MODI_Temperature[15]) annotation(
      Line(points = {{-192.6, 0}, {-196.6, 0}, {-196.6, -80}, {-100.6, -80}, {-100.6, -100}, {-100.6, -100}, {-100.6, -105}, {-100.6, -105}, {-100.6, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Cooling[4].pd_t, MODI_Temperature[14]) annotation(
      Line(points = {{-192.6, 0}, {-196.6, 0}, {-196.6, -80}, {-100.6, -80}, {-100.6, -106}, {-100.6, -106}, {-100.6, -108}, {-100.6, -108}, {-100.6, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Cooling[3].pd_t, MODI_Temperature[13]) annotation(
      Line(points = {{-192.6, 0}, {-196.6, 0}, {-196.6, -80}, {-100.6, -80}, {-100.6, -100}, {-100.6, -100}, {-100.6, -105}, {-100.6, -105}, {-100.6, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Cooling[2].pd_t, MODI_Temperature[12]) annotation(
      Line(points = {{-192.6, 0}, {-196.6, 0}, {-196.6, -80}, {-100.6, -80}, {-100.6, -102}, {-100.6, -102}, {-100.6, -106}, {-100.6, -106}, {-100.6, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Cooling[1].pd_t, MODI_Temperature[11]) annotation(
      Line(points = {{-192.6, 0}, {-196.6, 0}, {-196.6, -80}, {-100.6, -80}, {-100.6, -104}, {-100.6, -104}, {-100.6, -107}, {-100.6, -107}, {-100.6, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(disableHeating[5].outPlaces[1], Off_Temperature[5].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}}, thickness = 0.5));
  connect(disableHeating[4].outPlaces[1], Off_Temperature[4].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}}, thickness = 0.5));
  connect(disableHeating[3].outPlaces[1], Off_Temperature[3].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}}, thickness = 0.5));
  connect(disableHeating[2].outPlaces[1], Off_Temperature[2].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}}, thickness = 0.5));
  connect(disableHeating[1].outPlaces[1], Off_Temperature[1].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0}}, thickness = 0.5));
  connect(Off_Temperature[5].outTransition[1], enableHeating[5].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-112.8, 0}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
  connect(Off_Temperature[4].outTransition[1], enableHeating[4].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-112.8, 0}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
  connect(Off_Temperature[3].outTransition[1], enableHeating[3].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-112.8, 0}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
  connect(Off_Temperature[2].outTransition[1], enableHeating[2].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-112.8, 0}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
  connect(Off_Temperature[1].outTransition[1], enableHeating[1].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0}, {-112.8, 0}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
  connect(Off_Temperature[5].pd_t, MODI_Temperature[5]) annotation(
      Line(points = {{-100, -10.6}, {-100, -109.6}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Off_Temperature[4].pd_t, MODI_Temperature[4]) annotation(
      Line(points = {{-100, -10.6}, {-100, -109.6}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Off_Temperature[3].pd_t, MODI_Temperature[3]) annotation(
      Line(points = {{-100, -10.6}, {-100, -109.6}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Off_Temperature[2].pd_t, MODI_Temperature[2]) annotation(
      Line(points = {{-100, -10.6}, {-100, -109.6}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Off_Temperature[1].pd_t, MODI_Temperature[1]) annotation(
      Line(points = {{-100, -10.6}, {-100, -109.6}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Heating[5].pd_t, MODI_Temperature[10]) annotation(
      Line(points = {{-5.4, 0}, {-4.4, 0}, {-4.4, 0}, {-1.4, 0}, {-1.4, -80}, {-99.4, -80}, {-99.4, -104}, {-99.4, -104}, {-99.4, -107}, {-99.4, -107}, {-99.4, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Heating[4].pd_t, MODI_Temperature[9]) annotation(
      Line(points = {{-5.4, 0}, {-4.4, 0}, {-4.4, 0}, {-1.4, 0}, {-1.4, -80}, {-99.4, -80}, {-99.4, -104}, {-99.4, -104}, {-99.4, -107}, {-99.4, -107}, {-99.4, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Heating[3].pd_t, MODI_Temperature[8]) annotation(
      Line(points = {{-5.4, 0}, {-3.4, 0}, {-3.4, 0}, {-1.4, 0}, {-1.4, -80}, {-99.4, -80}, {-99.4, -102}, {-99.4, -102}, {-99.4, -106}, {-99.4, -106}, {-99.4, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Heating[2].pd_t, MODI_Temperature[7]) annotation(
      Line(points = {{-5.4, 0}, {-1.4, 0}, {-1.4, -80}, {-99.4, -80}, {-99.4, -104}, {-99.4, -104}, {-99.4, -107}, {-99.4, -107}, {-99.4, -110}}, color = {255, 127, 0}, thickness = 0.5));
  connect(Heating[1].pd_t, MODI_Temperature[6]) annotation(
      Line(points = {{-5.4, 0}, {-4.4, 0}, {-4.4, 0}, {-1.4, 0}, {-1.4, -80}, {-99.4, -80}, {-99.4, -104}, {-99.4, -104}, {-99.4, -107}, {-99.4, -107}, {-99.4, -110}}, color = {255, 127, 0}, thickness = 0.5));
    connect(Heating[5].outTransition[1], disableHeating[5].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -29.8}, {-51, -29.8}}));
    connect(Heating[4].outTransition[1], disableHeating[4].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -29.8}, {-51, -29.8}}));
    connect(Heating[3].outTransition[1], disableHeating[3].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -29.8}, {-51, -29.8}}));
    connect(Heating[2].outTransition[1], disableHeating[2].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -29.8}, {-51, -29.8}}));
    connect(Heating[1].outTransition[1], disableHeating[1].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -29.8}, {-51, -29.8}}));
    connect(enableHeating[4].outPlaces[1], Heating[4].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-33.7, 30}, {-33.7, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 20.5}, {-16.2, 11}}));
    connect(enableHeating[3].outPlaces[1], Heating[3].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 20.5}, {-16.2, 11}}));
    connect(enableHeating[2].outPlaces[1], Heating[2].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 20.5}, {-16.2, 11}}));
    connect(enableHeating[1].outPlaces[1], Heating[1].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-33.7, 30}, {-33.7, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 20.5}, {-16.2, 11}}));
    annotation(
      Line(points = {{-60, -106}, {-60, -106}}, color = {255, 127, 0}),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}})),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}})),
      Documentation(info = "<html><head></head><body>Struktur des MODI_Temperature-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Canteen_Off</div><div>ConferenceRoom_Off</div><div>MultipersonOffice_Off</div><div>OpenplanOffice_Off</div><div><div>Workshop_Heating</div><div>Canteen_Heating</div><div>ConferenceRoom_Heating</div><div>MultipersonOffice_Heating</div><div>OpenplanOffice_Heating</div></div><div><div>Workshop_Cooling</div><div>Canteen_Cooling</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Cooling</div></div><div><br></div><div>Struktur des MODI_Humidity-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Canteen_Off</div><div>ConferenceRoom_Off</div><div>MultipersonOffice_Off</div><div>OpenplanOffice_Off</div><div><div>Workshop_Humidifying</div><div>Canteen_Humidifying</div><div>ConferenceRoom_Humidifying</div><div>MultipersonOffice_Humidifying</div><div>OpenplanOffice_Humidifying</div></div><div><div>Workshop_Dehumidifying</div><div>Canteen_Dehumidifying</div><div>ConferenceRoom_Dehumidifying</div><div>MultipersonOffice_Dehumidifying</div><div>OpenplanOffice_Dehumidifying</div></div></div></body></html>"),
  __OpenModelica_commandLineOptions = "");
  end ManagementEbene;

  model Automatisierungsebene "Zuordnung der Betriebsmodi zu den entsprechenden Aktorsätzen"
    Modelica.Blocks.Interfaces.IntegerInput MODI_Temperature[15] annotation(
      Placement(visible = true, transformation(origin = {-30, 440}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-30, 440}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.IntegerOutput y[75] annotation(
      Placement(visible = true, transformation(origin = {364, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {364, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD Workshop_RLT_Heating_I_M00 annotation(
      Placement(visible = true, transformation(origin = {98, 382}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T11 annotation(
      Placement(visible = true, transformation(origin = {62, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Workshop_RLT_Cooling_I_M00 annotation(
      Placement(visible = true, transformation(origin = {-70, 384}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T16 annotation(
      Placement(visible = true, transformation(origin = {-32, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Workshop_RLT_Heating_Off_M01 annotation(
      Placement(visible = true, transformation(extent = {{22, 350}, {42, 370}}, rotation = 0)));
  PNlib.Components.PD Workshop_RLT_Heating_II_M00 annotation(
      Placement(visible = true, transformation(origin = {98, 338}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1 annotation(
      Placement(visible = true, transformation(origin = {62, 370}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T12 annotation(
      Placement(visible = true, transformation(origin = {62, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T13 annotation(
      Placement(visible = true, transformation(origin = {62, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T15 annotation(
      Placement(visible = true, transformation(origin = {108, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T14 annotation(
      Placement(visible = true, transformation(origin = {88, 360}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD Workshop_RLT_Cooling_Off_M00 annotation(
      Placement(visible = true, transformation(origin = {-4, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Workshop_RLT_Cooling_II_M00 annotation(
      Placement(visible = true, transformation(origin = {-70, 338}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T17 annotation(
      Placement(visible = true, transformation(origin = {-32, 370}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T18 annotation(
      Placement(visible = true, transformation(origin = {-32, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T19 annotation(
      Placement(visible = true, transformation(origin = {-32, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T110 annotation(
      Placement(visible = true, transformation(origin = {-80, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T111 annotation(
      Placement(visible = true, transformation(origin = {-60, 360}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T113 annotation(
      Placement(visible = true, transformation(origin = {-32, 250}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T114 annotation(
      Placement(visible = true, transformation(origin = {-32, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T115 annotation(
      Placement(visible = true, transformation(origin = {62, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Workshop_BKT_Cooling_II_M00 annotation(
      Placement(visible = true, transformation(origin = {-70, 258}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T116 annotation(
      Placement(visible = true, transformation(origin = {-60, 280}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T117 annotation(
      Placement(visible = true, transformation(origin = {-80, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD Workshop_BKT_Cooling_Off_M00 annotation(
      Placement(visible = true, transformation(origin = {-4, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T118 annotation(
      Placement(visible = true, transformation(origin = {88, 280}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T119 annotation(
      Placement(visible = true, transformation(origin = {108, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD Workshop_BKT_Heatin_Off_M00 annotation(
      Placement(visible = true, transformation(extent = {{22, 270}, {42, 290}}, rotation = 0)));
  PNlib.Components.T T120 annotation(
      Placement(visible = true, transformation(origin = {-32, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T121 annotation(
      Placement(visible = true, transformation(origin = {62, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Workshop_BKT_Cooling_I_M00 annotation(
      Placement(visible = true, transformation(origin = {-70, 302}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Workshop_BKT_Heating_I_M00 annotation(
      Placement(visible = true, transformation(origin = {98, 302}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T122 annotation(
      Placement(visible = true, transformation(origin = {-32, 310}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T123 annotation(
      Placement(visible = true, transformation(origin = {62, 310}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T112 annotation(
      Placement(visible = true, transformation(origin = {62, 250}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Workshop_BKT_Heating_II_M00 annotation(
      Placement(visible = true, transformation(origin = {98, 258}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Canteen_BKT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T124(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T125(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T126(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Canteen_BKT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{22, 102}, {42, 122}}, rotation = 0)));
  PNlib.Components.T T127(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {108, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T128(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {88, 112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD Canteen_BKT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {0, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T129(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-60, 112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T130(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T131(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T132(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T133(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T134(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Canteen_BKT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Canteen_BKT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T135(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-80, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD Canteen_BKT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T136(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 162}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Canteen_RLT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T137(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 162}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Canteen_RLT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T138(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 182}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T139(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 182}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T140(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-60, 192}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T141(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-80, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T142(arcWeightIn = 1, nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 202}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Canteen_RLT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-4, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T143(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {88, 192}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T144(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {108, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T145(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 202}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Canteen_RLT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{22, 182}, {42, 202}}, rotation = 0)));
  PNlib.Components.T T146(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 222}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Canteen_RLT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, 214}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Canteen_RLT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, 214}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T147(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 222}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T148(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T149(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T150(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T151(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T152(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-58, -56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD ConferenceRoom_BKT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {0, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T153(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {88, -56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T154(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {108, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD ConferenceRoom_BKT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{22, -66}, {42, -46}}, rotation = 0)));
  PNlib.Components.T T155(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T156(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD ConferenceRoom_BKT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD ConferenceRoom_RLT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T157(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD ConferenceRoom_RLT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T158(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD ConferenceRoom_BKT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-68, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T159(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-78, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD ConferenceRoom_BKT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-68, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD ConferenceRoom_BKT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T160(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T161(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD ConferenceRoom_RLT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{22, 14}, {42, 34}}, rotation = 0)));
  PNlib.Components.T T162(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T163(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {108, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T164(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {88, 24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD ConferenceRoom_RLT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {0, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T165(arcWeightIn = 1, nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T166(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-78, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T167(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-60, 24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T168(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T169(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD ConferenceRoom_RLT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD ConferenceRoom_RLT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T170(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T171(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD OpenplanOffice_BKT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T172 annotation(
      Placement(visible = true, transformation(origin = {300, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T173 annotation(
      Placement(visible = true, transformation(origin = {300, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T174 annotation(
      Placement(visible = true, transformation(origin = {206, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD OpenplanOffice_BKT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD OpenplanOffice_BKT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T175 annotation(
      Placement(visible = true, transformation(origin = {160, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD OpenplanOffice_BKT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T176 annotation(
      Placement(visible = true, transformation(origin = {300, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T177 annotation(
      Placement(visible = true, transformation(origin = {206, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD OpenplanOffice_BKT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 102}, {280, 122}}, rotation = 0)));
  PNlib.Components.T T178 annotation(
      Placement(visible = true, transformation(origin = {346, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T179 annotation(
      Placement(visible = true, transformation(origin = {326, 112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD OpenplanOffice_BKT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T180 annotation(
      Placement(visible = true, transformation(origin = {180, 112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T181 annotation(
      Placement(visible = true, transformation(origin = {300, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T182 annotation(
      Placement(visible = true, transformation(origin = {206, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T183 annotation(
      Placement(visible = true, transformation(origin = {206, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T184 annotation(
      Placement(visible = true, transformation(origin = {206, 162}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD OpenplanOffice_RLT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {168, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T185 annotation(
      Placement(visible = true, transformation(origin = {300, 162}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD OpenplanOffice_RLT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T186 annotation(
      Placement(visible = true, transformation(origin = {206, 182}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T187 annotation(
      Placement(visible = true, transformation(origin = {300, 182}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T188 annotation(
      Placement(visible = true, transformation(origin = {178, 192}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T189 annotation(
      Placement(visible = true, transformation(origin = {160, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD OpenplanOffice_RLT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T190 annotation(
      Placement(visible = true, transformation(origin = {326, 192}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T191 annotation(
      Placement(visible = true, transformation(origin = {346, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD OpenplanOffice_RLT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 182}, {280, 202}}, rotation = 0)));
  PNlib.Components.PD OpenplanOffice_RLT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {168, 214}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD OpenplanOffice_RLT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 214}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T192 annotation(
      Placement(visible = true, transformation(origin = {206, 202}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T193 annotation(
      Placement(visible = true, transformation(origin = {300, 202}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T194 annotation(
      Placement(visible = true, transformation(origin = {300, 222}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T195 annotation(
      Placement(visible = true, transformation(origin = {206, 222}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T196 annotation(
      Placement(visible = true, transformation(origin = {206, 250}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T197 annotation(
      Placement(visible = true, transformation(origin = {300, 250}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD MultipersonOffice_BKT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 258}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T198 annotation(
      Placement(visible = true, transformation(origin = {206, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T199 annotation(
      Placement(visible = true, transformation(origin = {300, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1100 annotation(
      Placement(visible = true, transformation(origin = {180, 280}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD MultipersonOffice_BKT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1101 annotation(
      Placement(visible = true, transformation(origin = {326, 280}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T1102 annotation(
      Placement(visible = true, transformation(origin = {346, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD MultipersonOffice_BKT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 270}, {280, 290}}, rotation = 0)));
  PNlib.Components.PD MultipersonOffice_BKT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 258}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1103 annotation(
      Placement(visible = true, transformation(origin = {160, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T1104 annotation(
      Placement(visible = true, transformation(origin = {206, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1105 annotation(
      Placement(visible = true, transformation(origin = {300, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD MultipersonOffice_BKT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 302}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD MultipersonOffice_BKT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 302}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1106 annotation(
      Placement(visible = true, transformation(origin = {206, 310}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1107 annotation(
      Placement(visible = true, transformation(origin = {300, 310}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD MultipersonOffice_RLT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 338}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1108 annotation(
      Placement(visible = true, transformation(origin = {300, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD MultipersonOffice_RLT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {168, 338}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1109 annotation(
      Placement(visible = true, transformation(origin = {206, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD MultipersonOffice_RLT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 350}, {280, 370}}, rotation = 0)));
  PNlib.Components.T T1110 annotation(
      Placement(visible = true, transformation(origin = {346, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T1111 annotation(
      Placement(visible = true, transformation(origin = {326, 360}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD MultipersonOffice_RLT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1112 annotation(
      Placement(visible = true, transformation(origin = {160, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T1113 annotation(
      Placement(visible = true, transformation(origin = {178, 360}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T1114 annotation(
      Placement(visible = true, transformation(origin = {300, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1115 annotation(
      Placement(visible = true, transformation(origin = {206, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1116 annotation(
      Placement(visible = true, transformation(origin = { 300, 370}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1117 annotation(
      Placement(visible = true, transformation(origin = {206, 370}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD MultipersonOffice_RLT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 382}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD MultipersonOffice_RLT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {168, 382}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1118 annotation(
      Placement(visible = true, transformation(origin = {206, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1119 annotation(
      Placement(visible = true, transformation(origin = {300, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1120 annotation(
      Placement(visible = true, transformation(origin = {300, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1121 annotation(
      Placement(visible = true, transformation(origin = {206, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD RLT_Central_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1122 annotation(
      Placement(visible = true, transformation(origin = {300, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1123 annotation(
      Placement(visible = true, transformation(origin = {206, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD RLT_Central_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1124 annotation(
      Placement(visible = true, transformation(origin = {160, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD RLT_Central_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 6}, {280, 26}}, rotation = 0)));
  PNlib.Components.T T1125 annotation(
      Placement(visible = true, transformation(origin = {346, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.T T1126 annotation(
      Placement(visible = true, transformation(origin = {326, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.PD RLT_Central_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1127 annotation(
      Placement(visible = true, transformation(origin = {180, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T1128 annotation(
      Placement(visible = true, transformation(origin = {300, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1129 annotation(
      Placement(visible = true, transformation(origin = {206, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD RLT_Central_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD RLT_Central_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1130 annotation(
      Placement(visible = true, transformation(origin = {300, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1131 annotation(
      Placement(visible = true, transformation(origin = {206, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1133 annotation(
      Placement(visible = true, transformation(origin = {422, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1135 annotation(
      Placement(visible = true, transformation(origin = {448, 200}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T1136 annotation(
      Placement(visible = true, transformation(origin = {468, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD Generation_Hot_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{382, 190}, {402, 210}}, rotation = 0)));
  PNlib.Components.PD Generation_Hot_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 178}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1139 annotation(
      Placement(visible = true, transformation(origin = {422, 190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1141 annotation(
      Placement(visible = true, transformation(origin = {422, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1143 annotation(
      Placement(visible = true, transformation(origin = {422, 230}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Generation_Hot_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 222}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1144 annotation(
      Placement(visible = true, transformation(origin = {422, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1146 annotation(
      Placement(visible = true, transformation(origin = {422, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Generation_Warm_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Generation_Warm_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{382, 98}, {402, 118}}, rotation = 0)));
  PNlib.Components.T T1148 annotation(
      Placement(visible = true, transformation(origin = {471, 107}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
  PNlib.Components.T T1149 annotation(
      Placement(visible = true, transformation(origin = {449, 107}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
  PNlib.Components.T T1151 annotation(
      Placement(visible = true, transformation(origin = {422, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.PD Generation_Warm_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1153 annotation(
      Placement(visible = true, transformation(origin = {422, 138}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.PD Generation_Cold_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1132 annotation(
      Placement(visible = true, transformation(origin = {422, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1134 annotation(
      Placement(visible = true, transformation(origin = {448, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.Components.T T1137 annotation(
      Placement(visible = true, transformation(origin = {468, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.Components.PD Generation_Cold_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{382, 8}, {402, 28}}, rotation = 0)));
  PNlib.Components.PD Generation_Cold_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1138 annotation(
      Placement(visible = true, transformation(origin = {422, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.Components.T T1140 annotation(
      Placement(visible = true, transformation(origin = {422, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PNlib.Components.T T1142 annotation(
      Placement(visible = true, transformation(origin = {422, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.IntegerInput MODI_Humidity annotation(
      Placement(visible = true, transformation(origin = {30, 440}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {30, 440}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  equation
    connect(T1126.outPlaces[1], RLT_Central_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 12}, {326, 12}, {326, 6}, {320, 6}, {320, -6}, {326, -6}, {326, -6}}, thickness = 0.5));
    connect(T1122.outPlaces[1], RLT_Central_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304, 6}, {320, 6}, {320, -6}, {324, -6}, {324, -6}, {326, -6}}, thickness = 0.5));
    connect(RLT_Central_Heating_II_M00.outTransition[2], T1125.inPlaces[1]) annotation(
      Line(points = {{346, -6}, {350, -6}, {350, 6}, {346, 6}, {346, 10}, {346, 10}, {346, 12}}, thickness = 0.5));
    connect(RLT_Central_Heating_II_M00.outTransition[1], T1120.inPlaces[1]) annotation(
      Line(points = {{346, -6}, {350, -6}, {350, -18}, {316, -18}, {316, -14}, {304, -14}, {304, -14}, {304, -14}}, thickness = 0.5));
    connect(RLT_Central_Heating_I_M00.outTransition[2], T1126.inPlaces[1]) annotation(
      Line(points = {{326, 38}, {320, 38}, {320, 26}, {326, 26}, {326, 22}, {326, 22}, {326, 20}}, thickness = 0.5));
    connect(RLT_Central_Heating_I_M00.outTransition[1], T1130.inPlaces[1]) annotation(
      Line(points = {{326, 38}, {320, 38}, {320, 46}, {306, 46}, {306, 46}, {304, 46}}, thickness = 0.5));
    connect(T1125.outPlaces[1], RLT_Central_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 20}, {346, 20}, {346, 26}, {350, 26}, {350, 38}, {346, 38}, {346, 38}}, thickness = 0.5));
    connect(T1128.outPlaces[1], RLT_Central_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304, 26}, {350, 26}, {350, 38}, {346, 38}, {346, 38}, {346, 38}}, thickness = 0.5));
    connect(T179.outPlaces[1], OpenplanOffice_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 108}, {326, 108}, {326, 102}, {320, 102}, {320, 90}, {326, 90}, {326, 90}}, thickness = 0.5));
    connect(T181.outPlaces[1], OpenplanOffice_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304, 102}, {320, 102}, {320, 90}, {324, 90}, {324, 90}, {326, 90}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_II_M00.outTransition[2], T178.inPlaces[1]) annotation(
      Line(points = {{346, 90}, {350, 90}, {350, 102}, {346, 102}, {346, 106}, {346, 106}, {346, 108}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_II_M00.outTransition[1], T172.inPlaces[1]) annotation(
      Line(points = {{346, 90}, {350, 90}, {350, 78}, {318, 78}, {318, 82}, {304, 82}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_I_M00.outTransition[2], T179.inPlaces[1]) annotation(
      Line(points = {{326, 134}, {320, 134}, {320, 122}, {326, 122}, {326, 118}, {326, 118}, {326, 116}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_I_M00.outTransition[1], T173.inPlaces[1]) annotation(
      Line(points = {{326, 134}, {320, 134}, {320, 142}, {304, 142}, {304, 142}, {304, 142}}, thickness = 0.5));
    connect(T178.outPlaces[1], OpenplanOffice_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 116}, {346, 116}, {346, 122}, {350, 122}, {350, 134}, {346, 134}, {346, 134}}, thickness = 0.5));
    connect(T176.outPlaces[1], OpenplanOffice_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304, 122}, {350, 122}, {350, 134}, {346, 134}, {346, 134}, {346, 134}, {346, 134}}, thickness = 0.5));
    connect(T190.outPlaces[1], OpenplanOffice_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 188}, {326, 188}, {326, 182}, {320, 182}, {320, 170}, {326, 170}, {326, 170}}, thickness = 0.5));
    connect(T187.outPlaces[1], OpenplanOffice_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304, 182}, {320, 182}, {320, 170}, {324, 170}, {324, 170}, {326, 170}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_II_M00.outTransition[2], T191.inPlaces[1]) annotation(
      Line(points = {{346, 170}, {350, 170}, {350, 182}, {344, 182}, {344, 186}, {346, 186}, {346, 188}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_II_M00.outTransition[1], T185.inPlaces[1]) annotation(
      Line(points = {{346, 170}, {350, 170}, {350, 158}, {320, 158}, {320, 162}, {306, 162}, {306, 162}, {304, 162}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_I_M00.outTransition[2], T190.inPlaces[1]) annotation(
      Line(points = {{326, 214}, {320, 214}, {320, 202}, {320, 202}, {320, 202}, {326, 202}, {326, 196}, {326, 196}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_I_M00.outTransition[1], T194.inPlaces[1]) annotation(
      Line(points = {{326, 214}, {320, 214}, {320, 222}, {304, 222}, {304, 222}, {304, 222}}, thickness = 0.5));
    connect(T191.outPlaces[1], OpenplanOffice_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 196}, {346, 196}, {346, 202}, {350, 202}, {350, 214}, {348, 214}, {348, 214}, {346, 214}}, thickness = 0.5));
    connect(T193.outPlaces[1], OpenplanOffice_RLT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304, 202}, {350, 202}, {350, 214}, {348, 214}, {348, 214}, {346, 214}}, thickness = 0.5));
    connect(T1101.outPlaces[1], MultipersonOffice_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 276}, {326, 276}, {326, 270}, {322, 270}, {322, 258}, {326, 258}, {326, 258}}, thickness = 0.5));
    connect(T199.outPlaces[1], MultipersonOffice_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304, 270}, {322, 270}, {322, 258}, {326, 258}, {326, 258}, {326, 258}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_II_M00.outTransition[2], T1102.inPlaces[1]) annotation(
      Line(points = {{346, 258}, {350, 258}, {350, 270}, {346, 270}, {346, 274}, {346, 274}, {346, 276}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_II_M00.outTransition[1], T197.inPlaces[1]) annotation(
      Line(points = {{346, 258}, {350, 258}, {350, 246}, {318, 246}, {318, 250}, {306, 250}, {306, 250}, {304, 250}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_I_M00.outTransition[2], T1101.inPlaces[1]) annotation(
      Line(points = {{326, 302}, {322, 302}, {322, 290}, {326, 290}, {326, 286}, {326, 286}, {326, 284}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_I_M00.outTransition[1], T1107.inPlaces[1]) annotation(
      Line(points = {{326, 302}, {322, 302}, {322, 310}, {306, 310}, {306, 310}, {304, 310}}, thickness = 0.5));
    connect(T1102.outPlaces[1], MultipersonOffice_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 284}, {346, 284}, {346, 290}, {350, 290}, {350, 302}, {346, 302}, {346, 302}}, thickness = 0.5));
    connect(T1105.outPlaces[1], MultipersonOffice_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304, 290}, {350, 290}, {350, 302}, {348, 302}, {348, 302}, {346, 302}}, thickness = 0.5));
    connect(T1127.outPlaces[1], RLT_Central_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{180, 12}, {180, 12}, {180, 6}, {184, 6}, {184, -6}, {180, -6}, {180, -6}, {180, -6}}, thickness = 0.5));
    connect(T1123.outPlaces[1], RLT_Central_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{202, 6}, {184, 6}, {184, -6}, {180, -6}, {180, -6}, {180, -6}}, thickness = 0.5));
    connect(RLT_Central_Cooling_II_M00.outTransition[2], T1124.inPlaces[1]) annotation(
      Line(points = {{160, -6}, {154, -6}, {154, 6}, {160, 6}, {160, 12}, {160, 12}, {160, 12}}, thickness = 0.5));
    connect(RLT_Central_Cooling_II_M00.outTransition[1], T1121.inPlaces[1]) annotation(
      Line(points = {{160, -6}, {154, -6}, {154, -20}, {190, -20}, {190, -14}, {202, -14}, {202, -14}, {202, -14}}, thickness = 0.5));
    connect(RLT_Central_Cooling_I_M00.outTransition[2], T1127.inPlaces[1]) annotation(
      Line(points = {{180, 38}, {184, 38}, {184, 26}, {180, 26}, {180, 22}, {180, 22}, {180, 20}}, thickness = 0.5));
    connect(RLT_Central_Cooling_I_M00.outTransition[1], T1131.inPlaces[1]) annotation(
      Line(points = {{180, 38}, {184, 38}, {184, 46}, {202, 46}}, thickness = 0.5));
    connect(T1124.outPlaces[1], RLT_Central_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 20}, {160, 20}, {160, 26}, {154, 26}, {154, 38}, {160, 38}, {160, 38}}, thickness = 0.5));
    connect(T1129.outPlaces[1], RLT_Central_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{202, 26}, {154, 26}, {154, 38}, {158, 38}, {158, 38}, {160, 38}}, thickness = 0.5));
    connect(T180.outPlaces[1], OpenplanOffice_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{180, 108}, {184, 108}, {184, 90}, {182, 90}, {182, 90}, {180, 90}}, thickness = 0.5));
    connect(T182.outPlaces[1], OpenplanOffice_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{202, 102}, {184, 102}, {184, 90}, {182, 90}, {182, 90}, {180, 90}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_II_M00.outTransition[2], T175.inPlaces[1]) annotation(
      Line(points = {{160, 90}, {156, 90}, {156, 102}, {160, 102}, {160, 106}, {160, 106}, {160, 108}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_II_M00.outTransition[1], T183.inPlaces[1]) annotation(
      Line(points = {{160, 90}, {156, 90}, {156, 76}, {190, 76}, {190, 82}, {200, 82}, {200, 82}, {202, 82}, {202, 82}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_I_M00.outTransition[2], T180.inPlaces[1]) annotation(
      Line(points = {{180, 134}, {184, 134}, {184, 122}, {180, 122}, {180, 118}, {180, 118}, {180, 116}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_I_M00.outTransition[1], T174.inPlaces[1]) annotation(
      Line(points = {{180, 134}, {184, 134}, {184, 142}, {200, 142}, {200, 142}, {202, 142}}, thickness = 0.5));
    connect(T175.outPlaces[1], OpenplanOffice_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 116}, {160, 116}, {160, 122}, {154, 122}, {154, 134}, {160, 134}, {160, 134}}, thickness = 0.5));
    connect(T177.outPlaces[1], OpenplanOffice_BKT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{202, 122}, {154, 122}, {154, 134}, {158, 134}, {158, 134}, {160, 134}}, thickness = 0.5));
    connect(T188.outPlaces[1], OpenplanOffice_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{178, 188}, {178, 188}, {178, 182}, {184, 182}, {184, 170}, {178, 170}, {178, 170}}, thickness = 0.5));
    connect(T186.outPlaces[1], OpenplanOffice_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{202, 182}, {184, 182}, {184, 170}, {180, 170}, {180, 170}, {178, 170}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_II_M00.outTransition[2], T189.inPlaces[1]) annotation(
      Line(points = {{158, 170}, {154, 170}, {154, 182}, {160, 182}, {160, 186}, {160, 186}, {160, 188}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_II_M00.outTransition[1], T184.inPlaces[1]) annotation(
      Line(points = {{158, 170}, {154, 170}, {154, 156}, {190, 156}, {190, 162}, {202, 162}, {202, 162}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_I_M00.outTransition[2], T188.inPlaces[1]) annotation(
      Line(points = {{178, 214}, {182, 214}, {182, 202}, {176, 202}, {176, 196}, {178, 196}, {178, 196}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_I_M00.outTransition[1], T195.inPlaces[1]) annotation(
      Line(points = {{178, 214}, {182, 214}, {182, 222}, {202, 222}}, thickness = 0.5));
    connect(T189.outPlaces[1], OpenplanOffice_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 196}, {160, 196}, {160, 202}, {152, 202}, {152, 214}, {158, 214}, {158, 214}}, thickness = 0.5));
    connect(T192.outPlaces[1], OpenplanOffice_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{202, 202}, {152, 202}, {152, 214}, {158, 214}, {158, 214}, {158, 214}}, thickness = 0.5));
    connect(T1100.outPlaces[1], MultipersonOffice_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{180, 276}, {180, 276}, {180, 270}, {184, 270}, {184, 258}, {180, 258}, {180, 258}}, thickness = 0.5));
    connect(T198.outPlaces[1], MultipersonOffice_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{202, 270}, {184, 270}, {184, 258}, {182, 258}, {182, 258}, {180, 258}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_II_M00.outTransition[2], T1103.inPlaces[1]) annotation(
      Line(points = {{160, 258}, {154, 258}, {154, 270}, {160, 270}, {160, 274}, {160, 274}, {160, 276}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_II_M00.outTransition[1], T196.inPlaces[1]) annotation(
      Line(points = {{160, 258}, {154, 258}, {154, 244}, {192, 244}, {192, 250}, {202, 250}, {202, 250}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_I_M00.outTransition[2], T1100.inPlaces[1]) annotation(
      Line(points = {{180, 302}, {186, 302}, {186, 290}, {180, 290}, {180, 284}, {180, 284}, {180, 284}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_I_M00.outTransition[1], T1106.inPlaces[1]) annotation(
      Line(points = {{180, 302}, {186, 302}, {186, 310}, {200, 310}, {200, 310}, {202, 310}}, thickness = 0.5));
    connect(T1103.outPlaces[1], MultipersonOffice_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 284}, {160, 284}, {160, 290}, {154, 290}, {154, 302}, {160, 302}, {160, 302}}, thickness = 0.5));
    connect(T1104.outPlaces[1], MultipersonOffice_BKT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{202, 290}, {154, 290}, {154, 302}, {160, 302}}, thickness = 0.5));
    connect(T1113.outPlaces[1], MultipersonOffice_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{178, 356}, {178, 356}, {178, 350}, {184, 350}, {184, 338}, {178, 338}, {178, 338}}, thickness = 0.5));
    connect(T1115.outPlaces[1], MultipersonOffice_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{202, 350}, {184, 350}, {184, 338}, {180, 338}, {180, 338}, {178, 338}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_Off_M00.outTransition[2], T1115.inPlaces[1]) annotation(
      Line(points = {{228, 360}, {222, 360}, {222, 350}, {212, 350}, {212, 350}, {210, 350}, {210, 350}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_II_M00.outTransition[2], T1112.inPlaces[1]) annotation(
      Line(points = {{158, 338}, {154, 338}, {154, 352}, {160, 352}, {160, 356}, {160, 356}, {160, 356}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_II_M00.outTransition[1], T1109.inPlaces[1]) annotation(
      Line(points = {{158, 338}, {154, 338}, {154, 322}, {188, 322}, {188, 332}, {200, 332}, {200, 330}, {202, 330}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_I_M00.outTransition[2], T1113.inPlaces[1]) annotation(
      Line(points = {{178, 382}, {184, 382}, {184, 370}, {178, 370}, {178, 366}, {178, 366}, {178, 364}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_I_M00.outTransition[1], T1118.inPlaces[1]) annotation(
      Line(points = {{178, 382}, {184, 382}, {184, 390}, {202, 390}, {202, 390}, {202, 390}}, thickness = 0.5));
    connect(T1112.outPlaces[1], MultipersonOffice_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 364}, {160, 364}, {160, 370}, {150, 370}, {150, 382}, {158, 382}, {158, 382}}, thickness = 0.5));
    connect(T1117.outPlaces[1], MultipersonOffice_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{202, 370}, {150, 370}, {150, 382}, {156, 382}, {156, 382}, {158, 382}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_I_M00.pd_t, y[11]) annotation(
      Line(points = {{-70, 312}, {-96, 312}, {-96, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Cooling_II_M00.pd_t, y[12]) annotation(
      Line(points = {{-70, 248}, {-96, 248}, {-96, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Cooling_Off_M00.pd_t, y[10]) annotation(
      Line(points = {{-4, 270}, {-4, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Heating_II_M00.pd_t, y[9]) annotation(
      Line(points = {{98, 268}, {140, 268}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Heating_I_M00.pd_t, y[8]) annotation(
      Line(points = {{98, 292}, {140, 292}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Heatin_Off_M00.pd_t, y[7]) annotation(
      Line(points = {{32, 290}, {32, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Cooling_II_M00.pd_t, y[6]) annotation(
      Line(points = {{-70, 328}, {-96, 328}, {-96, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Cooling_Off_M00.pd_t, y[4]) annotation(
      Line(points = {{-4, 350}, {-6, 350}, {-6, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Cooling_I_M00.pd_t, y[5]) annotation(
      Line(points = {{-70, 394}, {-96, 394}, {-96, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Heating_II_M00.pd_t, y[3]) annotation(
      Line(points = {{98, 348}, {140, 348}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Cooling_Off_M00.pd_t, y[40]) annotation(
      Line(points = {{238, 350}, {238, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Cooling_I_M00.pd_t, y[41]) annotation(
      Line(points = {{168, 392}, {140, 392}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Cooling_II_M00.pd_t, y[42]) annotation(
      Line(points = {{168, 328}, {140, 328}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Cooling_II_M00.pd_t, y[48]) annotation(
      Line(points = {{170, 248}, {140, 248}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Cooling_I_M00.pd_t, y[47]) annotation(
      Line(points = {{170, 312}, {140, 312}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Cooling_Off_M00.pd_t, y[46]) annotation(
      Line(points = {{238, 270}, {238, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Heating_II_M00.pd_t, y[39]) annotation(
      Line(points = {{336, 348}, {364, 348}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Heating_I_M00.pd_t, y[38]) annotation(
      Line(points = {{336, 372}, {364, 372}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Heating_Off_M00.pd_t, y[37]) annotation(
      Line(points = {{270, 370}, {272, 370}, {272, 412}, {364, 412}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Heating_II_M00.pd_t, y[45]) annotation(
      Line(points = {{336, 268}, {364, 268}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Heating_I_M00.pd_t, y[44]) annotation(
      Line(points = {{336, 292}, {364, 292}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Heating_Off_M00.pd_t, y[43]) annotation(
      Line(points = {{270, 290}, {270, 236}, {364, 236}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Cooling_Off_M00.pd_t, y[52]) annotation(
      Line(points = {{238, 182}, {238, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Heating_Off_M00.pd_t, y[49]) annotation(
      Line(points = {{270, 202}, {270, 236}, {364, 236}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Cooling_I_M00.pd_t, y[53]) annotation(
      Line(points = {{168, 224}, {140, 224}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Cooling_II_M00.pd_t, y[54]) annotation(
      Line(points = {{168, 160}, {140, 160}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Heating_II_M00.pd_t, y[51]) annotation(
      Line(points = {{336, 180}, {364, 180}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Heating_Off_M01.pd_t, y[1]) annotation(
      Line(points = {{32, 370}, {32, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Heating_I_M00.pd_t, y[2]) annotation(
      Line(points = {{98, 372}, {140, 372}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Cold_Off_M00.pd_t, y[73]) annotation(
      Line(points = {{392, 28}, {364, 28}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Cold_I_M00.pd_t, y[74]) annotation(
      Line(points = {{458, 30}, {486, 30}, {486, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Cold_II_M00.pd_t, y[75]) annotation(
      Line(points = {{458, 6}, {486, 6}, {486, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Warm_II_M00.pd_t, y[72]) annotation(
      Line(points = {{458, 96}, {486, 96}, {486, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Warm_I_M00.pd_t, y[71]) annotation(
      Line(points = {{458, 120}, {486, 120}, {486, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Warm_Off_M00.pd_t, y[70]) annotation(
      Line(points = {{392, 118}, {364, 118}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Hot_Off_M00.pd_t, y[67]) annotation(
      Line(points = {{392, 210}, {364, 210}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Hot_II_M00.pd_t, y[69]) annotation(
      Line(points = {{458, 188}, {486, 188}, {486, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Generation_Hot_I_M00.pd_t, y[68]) annotation(
      Line(points = {{458, 212}, {486, 212}, {486, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(RLT_Central_Heating_Off_M00.pd_t, y[61]) annotation(
      Line(points = {{270, 26}, {270, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(RLT_Central_Cooling_Off_M00.pd_t, y[64]) annotation(
      Line(points = {{238, 6}, {238, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(RLT_Central_Cooling_I_M00.pd_t, y[65]) annotation(
      Line(points = {{170, 48}, {140, 48}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(RLT_Central_Cooling_II_M00.pd_t, y[66]) annotation(
      Line(points = {{170, -16}, {140, -16}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(RLT_Central_Heating_II_M00.pd_t, y[63]) annotation(
      Line(points = {{336, 4}, {364, 4}, {364, -94}}, color = {255, 127, 0}));
    connect(RLT_Central_Heating_I_M00.pd_t, y[62]) annotation(
      Line(points = {{336, 28}, {364, 28}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Heating_Off_M00.pd_t, y[55]) annotation(
      Line(points = {{270, 122}, {270, 66}, {364, 66}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Cooling_Off_M00.pd_t, y[58]) annotation(
      Line(points = {{238, 102}, {238, 66}, {140, 66}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Heating_I_M00.pd_t, y[56]) annotation(
      Line(points = {{336, 124}, {364, 124}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Heating_II_M00.pd_t, y[57]) annotation(
      Line(points = {{336, 100}, {364, 100}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Cooling_I_M00.pd_t, y[59]) annotation(
      Line(points = {{170, 144}, {140, 144}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Cooling_II_M00.pd_t, y[60]) annotation(
      Line(points = {{170, 80}, {140, 80}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Heating_Off_M00.pd_t, y[31]) annotation(
      Line(points = {{32, -46}, {32, -106}, {140, -106}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Heating_I_M00.pd_t, y[32]) annotation(
      Line(points = {{98, -44}, {140, -44}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Heating_II_M00.pd_t, y[33]) annotation(
      Line(points = {{98, -68}, {140, -68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Cooling_Off_M00.pd_t, y[34]) annotation(
      Line(points = {{0, -66}, {0, -106}, {140, -106}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Cooling_I_M00.pd_t, y[35]) annotation(
      Line(points = {{-68, -24}, {-96, -24}, {-96, -106}, {140, -106}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Cooling_II_M00.pd_t, y[36]) annotation(
      Line(points = {{-68, -88}, {-96, -88}, {-96, -106}, {140, -106}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Heating_Off_M00.pd_t, y[25]) annotation(
      Line(points = {{32, 34}, {32, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Heating_I_M00.pd_t, y[26]) annotation(
      Line(points = {{98, 36}, {140, 36}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Heating_II_M00.pd_t, y[27]) annotation(
      Line(points = {{98, 12}, {140, 12}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Cooling_Off_M00.pd_t, y[28]) annotation(
      Line(points = {{0, 14}, {0, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Cooling_I_M00.pd_t, y[29]) annotation(
      Line(points = {{-70, 56}, {-94, 56}, {-94, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Cooling_II_M00.pd_t, y[30]) annotation(
      Line(points = {{-70, -8}, {-94, -8}, {-94, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Heating_Off_M00.pd_t, y[19]) annotation(
      Line(points = {{32, 122}, {32, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Heating_I_M00.pd_t, y[20]) annotation(
      Line(points = {{98, 124}, {140, 124}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Heating_II_M00.pd_t, y[21]) annotation(
      Line(points = {{98, 100}, {140, 100}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Cooling_Off_M00.pd_t, y[22]) annotation(
      Line(points = {{0, 102}, {0, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Cooling_II_M00.pd_t, y[24]) annotation(
      Line(points = {{-70, 80}, {-94, 80}, {-94, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Cooling_I_M00.pd_t, y[23]) annotation(
      Line(points = {{-70, 144}, {-94, 144}, {-94, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Heating_I_M00.pd_t, y[14]) annotation(
      Line(points = {{98, 204}, {140, 204}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Heating_II_M00.pd_t, y[15]) annotation(
      Line(points = {{98, 180}, {140, 180}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Heating_Off_M00.pd_t, y[13]) annotation(
      Line(points = {{32, 202}, {32, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Cooling_Off_M00.pd_t, y[16]) annotation(
      Line(points = {{-4, 182}, {-4, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Cooling_I_M00.pd_t, y[17]) annotation(
      Line(points = {{-70, 224}, {-96, 224}, {-96, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Cooling_II_M00.pd_t, y[18]) annotation(
      Line(points = {{-70, 160}, {-96, 160}, {-96, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -94}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Heating_I_M00.pd_t, y[50]) annotation(
      Line(points = {{336, 204}, {364, 204}, {364, -94}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Heating_II_M00.outTransition[2], T119.inPlaces[1]) annotation(
      Line(points = {{108, 258}, {112, 258}, {112, 258}, {112, 258}, {112, 270}, {108, 270}, {108, 275}, {108, 275}}, thickness = 0.5));
    connect(T119.outPlaces[1], Workshop_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 285}, {108, 290}, {112, 290}, {112, 302}, {108, 302}}, thickness = 0.5));
    connect(T14.outPlaces[1], Workshop_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 355}, {86, 355}, {86, 338}, {88, 338}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_I_M00.outTransition[2], T14.inPlaces[1]) annotation(
      Line(points = {{88, 382}, {88, 382}, {88, 365}, {88, 365}}, thickness = 0.5));
    connect(T143.outPlaces[1], Canteen_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 188}, {88, 188}, {88, 182}, {82, 182}, {82, 170}, {88, 170}, {88, 170}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_I_M00.outTransition[2], T143.inPlaces[1]) annotation(
      Line(points = {{88, 214}, {82, 214}, {82, 202}, {88, 202}, {88, 198}, {88, 198}, {88, 196}, {88, 196}}, thickness = 0.5));
    connect(T1120.outPlaces[1], RLT_Central_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{296, -14}, {256, -14}, {256, 16}, {260, 16}}, thickness = 0.5));
    connect(T194.outPlaces[1], OpenplanOffice_RLT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{296, 222}, {256, 222}, {256, 192}, {260, 192}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_II_M00.outTransition[2], T144.inPlaces[1]) annotation(
      Line(points = {{108, 170}, {114, 170}, {114, 182}, {108, 182}, {108, 186}, {108, 186}, {108, 188}, {108, 188}}, thickness = 0.5));
    connect(T144.outPlaces[1], Canteen_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 196}, {108, 196}, {108, 202}, {114, 202}, {114, 214}, {108, 214}, {108, 214}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_II_M00.outTransition[2], T163.inPlaces[1]) annotation(
      Line(points = {{108, 2}, {112, 2}, {112, 14}, {108, 14}, {108, 18}, {108, 18}, {108, 20}}, thickness = 0.5));
    connect(T163.outPlaces[1], ConferenceRoom_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 28}, {108, 28}, {108, 34}, {112, 34}, {112, 46}, {108, 46}, {108, 46}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_I_M00.outTransition[2], T164.inPlaces[1]) annotation(
      Line(points = {{88, 46}, {84, 46}, {84, 34}, {88, 34}, {88, 29}}, thickness = 0.5));
    connect(T164.outPlaces[1], ConferenceRoom_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 19}, {88, 14}, {82, 14}, {82, 2}, {88, 2}}, thickness = 0.5));
    connect(T1135.outPlaces[1], Generation_Hot_II_M00.inTransition[2]) annotation(
      Line(points = {{448, 196}, {448, 196}, {448, 190}, {442, 190}, {442, 178}, {448, 178}, {448, 178}}, thickness = 0.5));
    connect(Generation_Hot_I_M00.outTransition[2], T1135.inPlaces[1]) annotation(
      Line(points = {{448, 222}, {442, 222}, {442, 210}, {448, 210}, {448, 206}, {448, 206}, {448, 204}}, thickness = 0.5));
    connect(T1136.outPlaces[1], Generation_Hot_I_M00.inTransition[2]) annotation(
      Line(points = {{468, 205}, {468, 210}, {474, 210}, {474, 222}, {468, 222}}, thickness = 0.5));
    connect(Generation_Hot_II_M00.outTransition[2], T1136.inPlaces[1]) annotation(
      Line(points = {{468, 178}, {472, 178}, {472, 192}, {468, 192}, {468, 194}, {468, 194}, {468, 195}}, thickness = 0.5));
    connect(T1110.outPlaces[1], MultipersonOffice_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 365}, {346, 370}, {354, 370}, {354, 382}, {346, 382}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_II_M00.outTransition[2], T1110.inPlaces[1]) annotation(
      Line(points = {{346, 338}, {350, 338}, {350, 350}, {346, 350}, {346, 355}}, thickness = 0.5));
    connect(T1148.outPlaces[1], Generation_Warm_I_M00.inTransition[2]) annotation(
      Line(points = {{471, 112}, {471, 118}, {472, 118}, {472, 130}, {468, 130}}, thickness = 0.5));
    connect(Generation_Warm_II_M00.outTransition[2], T1148.inPlaces[1]) annotation(
      Line(points = {{468, 86}, {474, 86}, {474, 98}, {468, 98}, {468, 102}, {471, 102}}, thickness = 0.5));
    connect(Generation_Warm_I_M00.outTransition[2], T1149.inPlaces[1]) annotation(
      Line(points = {{448, 130}, {442, 130}, {442, 118}, {450, 118}, {450, 114}, {449, 114}, {449, 112}}, thickness = 0.5));
    connect(T1149.outPlaces[1], Generation_Warm_II_M00.inTransition[2]) annotation(
      Line(points = {{449, 102}, {449, 98}, {444, 98}, {444, 86}, {448, 86}}, thickness = 0.5));
    connect(T1137.outPlaces[1], Generation_Cold_I_M00.inTransition[2]) annotation(
      Line(points = {{468, 23}, {468, 28}, {472, 28}, {472, 40}, {468, 40}}, thickness = 0.5));
    connect(Generation_Cold_II_M00.outTransition[2], T1137.inPlaces[1]) annotation(
      Line(points = {{468, -4}, {472, -4}, {472, 8}, {468, 8}, {468, 13}}, thickness = 0.5));
    connect(T1131.outPlaces[1], RLT_Central_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210, 46}, {252, 46}, {252, 16}, {250, 16}, {250, 16}, {248, 16}}, thickness = 0.5));
    connect(T1121.outPlaces[1], RLT_Central_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210, -14}, {252, -14}, {252, 16}, {250, 16}, {250, 16}, {248, 16}}, thickness = 0.5));
    connect(RLT_Central_Cooling_Off_M00.outTransition[2], T1123.inPlaces[1]) annotation(
      Line(points = {{228, 16}, {220, 16}, {220, 6}, {212, 6}, {212, 6}, {210, 6}}, thickness = 0.5));
    connect(RLT_Central_Cooling_Off_M00.outTransition[1], T1129.inPlaces[1]) annotation(
      Line(points = {{228, 16}, {220, 16}, {220, 26}, {212, 26}, {212, 26}, {210, 26}}, thickness = 0.5));
    connect(T1130.outPlaces[1], RLT_Central_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{296, 46}, {256, 46}, {256, 16}, {258, 16}, {258, 16}, {260, 16}}, thickness = 0.5));
    connect(RLT_Central_Heating_Off_M00.outTransition[2], T1122.inPlaces[1]) annotation(
      Line(points = {{280, 16}, {286, 16}, {286, 6}, {294, 6}, {294, 6}, {296, 6}}, thickness = 0.5));
    connect(RLT_Central_Heating_Off_M00.outTransition[1], T1128.inPlaces[1]) annotation(
      Line(points = {{280, 16}, {286, 16}, {286, 26}, {294, 26}, {294, 26}, {296, 26}}, thickness = 0.5));
    connect(T183.outPlaces[1], OpenplanOffice_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210, 82}, {252, 82}, {252, 112}, {250, 112}, {250, 112}, {248, 112}}, thickness = 0.5));
    connect(T174.outPlaces[1], OpenplanOffice_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210, 142}, {252, 142}, {252, 112}, {248, 112}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_Off_M00.outTransition[2], T182.inPlaces[1]) annotation(
      Line(points = {{228, 112}, {220, 112}, {220, 102}, {210, 102}, {210, 102}, {210, 102}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_Off_M00.outTransition[1], T177.inPlaces[1]) annotation(
      Line(points = {{228, 112}, {220, 112}, {220, 122}, {210, 122}, {210, 122}, {210, 122}}, thickness = 0.5));
    connect(T172.outPlaces[1], OpenplanOffice_BKT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{296, 82}, {254, 82}, {254, 112}, {260, 112}}, thickness = 0.5));
    connect(T173.outPlaces[1], OpenplanOffice_BKT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{296, 142}, {254, 142}, {254, 112}, {260, 112}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_Off_M00.outTransition[2], T181.inPlaces[1]) annotation(
      Line(points = {{280, 112}, {286, 112}, {286, 102}, {294, 102}, {294, 102}, {296, 102}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_Off_M00.outTransition[1], T176.inPlaces[1]) annotation(
      Line(points = {{280, 112}, {286, 112}, {286, 122}, {294, 122}, {294, 122}, {296, 122}}, thickness = 0.5));
    connect(T184.outPlaces[1], OpenplanOffice_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210, 162}, {252, 162}, {252, 192}, {250, 192}, {250, 192}, {248, 192}, {248, 192}}, thickness = 0.5));
    connect(T195.outPlaces[1], OpenplanOffice_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210, 222}, {252, 222}, {252, 192}, {250, 192}, {250, 192}, {248, 192}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_Off_M00.outTransition[2], T186.inPlaces[1]) annotation(
      Line(points = {{228, 192}, {222, 192}, {222, 182}, {210, 182}, {210, 182}, {210, 182}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_Off_M00.outTransition[1], T192.inPlaces[1]) annotation(
      Line(points = {{228, 192}, {222, 192}, {222, 202}, {210, 202}}, thickness = 0.5));
    connect(T185.outPlaces[1], OpenplanOffice_RLT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{296, 162}, {256, 162}, {256, 192}, {258, 192}, {258, 192}, {260, 192}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_Off_M00.outTransition[2], T187.inPlaces[1]) annotation(
      Line(points = {{280, 192}, {286, 192}, {286, 182}, {296, 182}, {296, 182}, {296, 182}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_Off_M00.outTransition[1], T193.inPlaces[1]) annotation(
      Line(points = {{280, 192}, {286, 192}, {286, 202}, {296, 202}, {296, 202}, {296, 202}}, thickness = 0.5));
    connect(T1139.outPlaces[1], Generation_Hot_II_M00.inTransition[1]) annotation(
      Line(points = {{426, 190}, {442, 190}, {442, 178}, {446, 178}, {446, 178}, {448, 178}}, thickness = 0.5));
    connect(Generation_Hot_II_M00.outTransition[1], T1141.inPlaces[1]) annotation(
      Line(points = {{468, 178}, {472, 178}, {472, 164}, {440, 164}, {440, 170}, {426, 170}}, thickness = 0.5));
    connect(T1133.outPlaces[1], Generation_Hot_I_M00.inTransition[1]) annotation(
      Line(points = {{426, 210}, {474, 210}, {474, 222}, {470, 222}, {470, 222}, {468, 222}}, thickness = 0.5));
    connect(Generation_Hot_I_M00.outTransition[1], T1143.inPlaces[1]) annotation(
      Line(points = {{448, 222}, {442, 222}, {442, 230}, {428, 230}, {428, 230}, {426, 230}}, thickness = 0.5));
    connect(T1141.outPlaces[1], Generation_Hot_Off_M00.inTransition[2]) annotation(
      Line(points = {{418, 170}, {378, 170}, {378, 200}, {380, 200}, {380, 200}, {382, 200}}, thickness = 0.5));
    connect(T1143.outPlaces[1], Generation_Hot_Off_M00.inTransition[1]) annotation(
      Line(points = {{418, 230}, {378, 230}, {378, 200}, {380, 200}, {380, 200}, {382, 200}}, thickness = 0.5));
    connect(Generation_Hot_Off_M00.outTransition[2], T1139.inPlaces[1]) annotation(
      Line(points = {{402, 200}, {408, 200}, {408, 190}, {416, 190}, {416, 190}, {418, 190}}, thickness = 0.5));
    connect(Generation_Hot_Off_M00.outTransition[1], T1133.inPlaces[1]) annotation(
      Line(points = {{402, 200}, {408, 200}, {408, 210}, {418, 210}, {418, 210}, {418, 210}}, thickness = 0.5));
    connect(T1146.outPlaces[1], Generation_Warm_II_M00.inTransition[1]) annotation(
      Line(points = {{426, 98}, {444, 98}, {444, 86}, {448, 86}, {448, 86}, {448, 86}}, thickness = 0.5));
    connect(Generation_Warm_II_M00.outTransition[1], T1144.inPlaces[1]) annotation(
      Line(points = {{468, 86}, {474, 86}, {474, 74}, {434, 74}, {434, 78}, {428, 78}, {428, 78}, {426, 78}}, thickness = 0.5));
    connect(Generation_Warm_I_M00.outTransition[1], T1153.inPlaces[1]) annotation(
      Line(points = {{448, 130}, {442, 130}, {442, 138}, {428, 138}, {428, 138}, {426, 138}}, thickness = 0.5));
    connect(T1151.outPlaces[1], Generation_Warm_I_M00.inTransition[1]) annotation(
      Line(points = {{426, 118}, {472, 118}, {472, 130}, {470, 130}, {470, 130}, {468, 130}}, thickness = 0.5));
    connect(T1144.outPlaces[1], Generation_Warm_Off_M00.inTransition[2]) annotation(
      Line(points = {{418, 78}, {378, 78}, {378, 108}, {380, 108}, {380, 108}, {382, 108}}, thickness = 0.5));
    connect(T1153.outPlaces[1], Generation_Warm_Off_M00.inTransition[1]) annotation(
      Line(points = {{418, 138}, {378, 138}, {378, 108}, {380, 108}, {380, 108}, {382, 108}}, thickness = 0.5));
    connect(Generation_Warm_Off_M00.outTransition[2], T1146.inPlaces[1]) annotation(
      Line(points = {{402, 108}, {406, 108}, {406, 98}, {416, 98}, {416, 98}, {418, 98}}, thickness = 0.5));
    connect(Generation_Warm_Off_M00.outTransition[1], T1151.inPlaces[1]) annotation(
      Line(points = {{402, 108}, {406, 108}, {406, 118}, {416, 118}, {416, 118}, {418, 118}}, thickness = 0.5));
    connect(T1134.outPlaces[1], Generation_Cold_II_M00.inTransition[2]) annotation(
      Line(points = {{448, 14}, {448, 14}, {448, 8}, {444, 8}, {444, -4}, {448, -4}, {448, -4}}, thickness = 0.5));
    connect(T1138.outPlaces[1], Generation_Cold_II_M00.inTransition[1]) annotation(
      Line(points = {{426, 8}, {444, 8}, {444, -4}, {448, -4}}, thickness = 0.5));
    connect(Generation_Cold_II_M00.outTransition[1], T1140.inPlaces[1]) annotation(
      Line(points = {{468, -4}, {472, -4}, {472, -16}, {438, -16}, {438, -12}, {428, -12}, {428, -12}, {426, -12}}, thickness = 0.5));
    connect(Generation_Cold_I_M00.outTransition[2], T1134.inPlaces[1]) annotation(
      Line(points = {{448, 40}, {444, 40}, {444, 28}, {448, 28}, {448, 22}, {448, 22}, {448, 22}}, thickness = 0.5));
    connect(Generation_Cold_I_M00.outTransition[1], T1142.inPlaces[1]) annotation(
      Line(points = {{448, 40}, {444, 40}, {444, 48}, {428, 48}, {428, 48}, {426, 48}}, thickness = 0.5));
    connect(T1132.outPlaces[1], Generation_Cold_I_M00.inTransition[1]) annotation(
      Line(points = {{426, 28}, {472, 28}, {472, 40}, {468, 40}, {468, 40}, {468, 40}}, thickness = 0.5));
    connect(T1140.outPlaces[1], Generation_Cold_Off_M00.inTransition[2]) annotation(
      Line(points = {{418, -12}, {376, -12}, {376, 18}, {380, 18}, {380, 18}, {382, 18}}, thickness = 0.5));
    connect(T1142.outPlaces[1], Generation_Cold_Off_M00.inTransition[1]) annotation(
      Line(points = {{418, 48}, {376, 48}, {376, 18}, {380, 18}, {380, 18}, {382, 18}}, thickness = 0.5));
    connect(Generation_Cold_Off_M00.outTransition[2], T1138.inPlaces[1]) annotation(
      Line(points = {{402, 18}, {408, 18}, {408, 8}, {416, 8}, {416, 8}, {418, 8}}, thickness = 0.5));
    connect(Generation_Cold_Off_M00.outTransition[1], T1132.inPlaces[1]) annotation(
      Line(points = {{402, 18}, {408, 18}, {408, 28}, {416, 28}, {416, 28}, {418, 28}}, thickness = 0.5));
    connect(T196.outPlaces[1], MultipersonOffice_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210, 250}, {252, 250}, {252, 280}, {250, 280}, {250, 280}, {248, 280}}, thickness = 0.5));
    connect(T1106.outPlaces[1], MultipersonOffice_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210, 310}, {252, 310}, {252, 280}, {250, 280}, {250, 280}, {248, 280}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_Off_M00.outTransition[2], T198.inPlaces[1]) annotation(
      Line(points = {{228, 280}, {222, 280}, {222, 270}, {210, 270}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_Off_M00.outTransition[1], T1104.inPlaces[1]) annotation(
      Line(points = {{228, 280}, {222, 280}, {222, 290}, {210, 290}, {210, 290}}, thickness = 0.5));
    connect(T197.outPlaces[1], MultipersonOffice_BKT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{296, 250}, {256, 250}, {256, 280}, {258, 280}, {258, 280}, {260, 280}}, thickness = 0.5));
    connect(T1107.outPlaces[1], MultipersonOffice_BKT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{296, 310}, {256, 310}, {256, 280}, {260, 280}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_Off_M00.outTransition[2], T199.inPlaces[1]) annotation(
      Line(points = {{280, 280}, {286, 280}, {286, 270}, {294, 270}, {294, 270}, {296, 270}, {296, 270}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_Off_M00.outTransition[1], T1105.inPlaces[1]) annotation(
      Line(points = {{280, 280}, {286, 280}, {286, 290}, {294, 290}, {294, 290}, {296, 290}}, thickness = 0.5));
    connect(T1111.outPlaces[1], MultipersonOffice_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 356}, {326, 356}, {326, 350}, {320, 350}, {320, 338}, {326, 338}, {326, 338}, {326, 338}}, thickness = 0.5));
    connect(T1114.outPlaces[1], MultipersonOffice_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304, 350}, {320, 350}, {320, 338}, {326, 338}, {326, 338}, {326, 338}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_II_M00.outTransition[1], T1108.inPlaces[1]) annotation(
      Line(points = {{346, 338}, {350, 338}, {350, 326}, {314, 326}, {314, 330}, {304, 330}, {304, 330}, {304, 330}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_I_M00.outTransition[2], T1111.inPlaces[1]) annotation(
      Line(points = {{326, 382}, {320, 382}, {320, 370}, {326, 370}, {326, 366}, {326, 366}, {326, 364}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_I_M00.outTransition[1], T1119.inPlaces[1]) annotation(
      Line(points = {{326, 382}, {320, 382}, {320, 390}, {306, 390}, {306, 390}, {304, 390}}, thickness = 0.5));
    connect(T1116.outPlaces[1], MultipersonOffice_RLT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304, 370}, {354, 370}, {354, 382}, {348, 382}, {348, 382}, {346, 382}, {346, 382}}, thickness = 0.5));
    connect(T1109.outPlaces[1], MultipersonOffice_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210, 330}, {252, 330}, {252, 360}, {250, 360}, {250, 360}, {248, 360}}, thickness = 0.5));
    connect(T1118.outPlaces[1], MultipersonOffice_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210, 390}, {252, 390}, {252, 360}, {250, 360}, {250, 360}, {248, 360}, {248, 360}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_Off_M00.outTransition[1], T1117.inPlaces[1]) annotation(
      Line(points = {{228, 360}, {222, 360}, {222, 370}, {210, 370}}, thickness = 0.5));
    connect(T1108.outPlaces[1], MultipersonOffice_RLT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{296, 330}, {256, 330}, {256, 360}, {260, 360}}, thickness = 0.5));
    connect(T1119.outPlaces[1], MultipersonOffice_RLT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{296, 390}, {256, 390}, {256, 360}, {260, 360}, {260, 360}, {260, 360}, {260, 360}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_Off_M00.outTransition[2], T1114.inPlaces[1]) annotation(
      Line(points = {{280, 360}, {286, 360}, {286, 350}, {294, 350}, {294, 350}, {296, 350}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_Off_M00.outTransition[1], T1116.inPlaces[1]) annotation(
      Line(points = {{280, 360}, {286, 360}, {286, 370}, {296, 370}, {296, 370}, {296, 370}}, thickness = 0.5));
    connect(T152.outPlaces[1], ConferenceRoom_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-58, -60}, {-58, -60}, {-58, -66}, {-54, -66}, {-54, -66}, {-54, -66}, {-54, -78}, {-58, -78}, {-58, -78}}, thickness = 0.5));
    connect(T150.outPlaces[1], ConferenceRoom_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36, -66}, {-54, -66}, {-54, -78}, {-56, -78}, {-56, -78}, {-58, -78}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_II_M00.outTransition[2], T159.inPlaces[1]) annotation(
      Line(points = {{-78, -78}, {-82, -78}, {-82, -66}, {-78, -66}, {-78, -62}, {-78, -62}, {-78, -60}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_II_M00.outTransition[1], T149.inPlaces[1]) annotation(
      Line(points = {{-78, -78}, {-82, -78}, {-82, -90}, {-44, -90}, {-44, -86}, {-36, -86}, {-36, -86}}, thickness = 0.5));
    connect(T152.inPlaces[1], ConferenceRoom_BKT_Cooling_I_M00.outTransition[2]) annotation(
      Line(points = {{-58, -52}, {-58, -52}, {-58, -46}, {-54, -46}, {-54, -34}, {-58, -34}, {-58, -34}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_I_M00.outTransition[1], T160.inPlaces[1]) annotation(
      Line(points = {{-58, -34}, {-54, -34}, {-54, -26}, {-38, -26}, {-38, -26}, {-36, -26}}, thickness = 0.5));
    connect(T159.outPlaces[1], ConferenceRoom_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-78, -52}, {-78, -52}, {-78, -46}, {-84, -46}, {-84, -34}, {-78, -34}, {-78, -34}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_I_M00.inTransition[1], T155.outPlaces[1]) annotation(
      Line(points = {{-78, -34}, {-84, -34}, {-84, -46}, {-36, -46}, {-36, -46}, {-36, -46}}, thickness = 0.5));
    connect(T153.outPlaces[1], ConferenceRoom_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, -60}, {88, -60}, {88, -66}, {84, -66}, {84, -78}, {88, -78}, {88, -78}}, thickness = 0.5));
    connect(T151.outPlaces[1], ConferenceRoom_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66, -66}, {84, -66}, {84, -78}, {86, -78}, {86, -78}, {88, -78}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_II_M00.outTransition[2], T154.inPlaces[1]) annotation(
      Line(points = {{108, -78}, {114, -78}, {114, -66}, {108, -66}, {108, -62}, {108, -62}, {108, -60}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_II_M00.outTransition[1], T148.inPlaces[1]) annotation(
      Line(points = {{108, -78}, {114, -78}, {114, -90}, {78, -90}, {78, -86}, {66, -86}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_I_M00.outTransition[2], T153.inPlaces[1]) annotation(
      Line(points = {{88, -34}, {84, -34}, {84, -46}, {88, -46}, {88, -50}, {88, -50}, {88, -52}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_I_M00.outTransition[1], T161.inPlaces[1]) annotation(
      Line(points = {{88, -34}, {84, -34}, {84, -26}, {68, -26}, {68, -26}, {66, -26}}, thickness = 0.5));
    connect(T154.outPlaces[1], ConferenceRoom_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, -52}, {108, -52}, {108, -46}, {112, -46}, {112, -34}, {108, -34}, {108, -34}}, thickness = 0.5));
    connect(T156.outPlaces[1], ConferenceRoom_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66, -46}, {112, -46}, {112, -34}, {110, -34}, {110, -34}, {108, -34}}, thickness = 0.5));
    connect(T160.outPlaces[1], ConferenceRoom_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-28, -26}, {14, -26}, {14, -56}, {10, -56}, {10, -56}, {10, -56}}, thickness = 0.5));
    connect(T149.outPlaces[1], ConferenceRoom_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-28, -86}, {14, -86}, {14, -56}, {12, -56}, {12, -56}, {10, -56}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_Off_M00.outTransition[2], T150.inPlaces[1]) annotation(
      Line(points = {{-10, -56}, {-16, -56}, {-16, -66}, {-28, -66}, {-28, -66}, {-28, -66}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_Off_M00.outTransition[1], T155.inPlaces[1]) annotation(
      Line(points = {{-10, -56}, {-16, -56}, {-16, -46}, {-28, -46}, {-28, -46}, {-28, -46}}, thickness = 0.5));
    connect(T161.outPlaces[1], ConferenceRoom_BKT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{58, -26}, {18, -26}, {18, -56}, {20, -56}, {20, -56}, {22, -56}}, thickness = 0.5));
    connect(T148.outPlaces[1], ConferenceRoom_BKT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{58, -86}, {18, -86}, {18, -56}, {22, -56}, {22, -56}, {22, -56}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_Off_M00.outTransition[2], T151.inPlaces[1]) annotation(
      Line(points = {{42, -56}, {48, -56}, {48, -66}, {58, -66}, {58, -66}, {58, -66}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_Off_M00.outTransition[2], T156.inPlaces[1]) annotation(
      Line(points = {{42, -56}, {48, -56}, {48, -46}, {56, -46}, {56, -46}, {58, -46}}, thickness = 0.5));
    connect(T167.outPlaces[1], ConferenceRoom_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 20}, {-60, 20}, {-60, 14}, {-56, 14}, {-56, 2}, {-60, 2}, {-60, 2}}, thickness = 0.5));
    connect(T169.outPlaces[1], ConferenceRoom_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36, 14}, {-56, 14}, {-56, 2}, {-58, 2}, {-58, 2}, {-60, 2}, {-60, 2}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_II_M00.outTransition[2], T166.inPlaces[1]) annotation(
      Line(points = {{-80, 2}, {-84, 2}, {-84, 14}, {-78, 14}, {-78, 20}, {-78, 20}, {-78, 20}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_II_M00.outTransition[1], T158.inPlaces[1]) annotation(
      Line(points = {{-80, 2}, {-84, 2}, {-84, -12}, {-44, -12}, {-44, -6}, {-38, -6}, {-38, -6}, {-36, -6}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_I_M00.outTransition[2], T167.inPlaces[1]) annotation(
      Line(points = {{-60, 46}, {-56, 46}, {-56, 34}, {-60, 34}, {-60, 30}, {-60, 30}, {-60, 28}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_I_M00.outTransition[1], T170.inPlaces[1]) annotation(
      Line(points = {{-60, 46}, {-56, 46}, {-56, 54}, {-36, 54}, {-36, 54}, {-36, 54}, {-36, 54}}, thickness = 0.5));
    connect(T166.outPlaces[1], ConferenceRoom_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-78, 28}, {-76, 28}, {-76, 34}, {-86, 34}, {-86, 46}, {-82, 46}, {-82, 46}, {-80, 46}}, thickness = 0.5));
    connect(T165.outPlaces[1], ConferenceRoom_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36, 34}, {-86, 34}, {-86, 46}, {-80, 46}}, thickness = 0.5));
    connect(T158.outPlaces[1], ConferenceRoom_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-28, -6}, {14, -6}, {14, 24}, {10, 24}}, thickness = 0.5));
    connect(T170.outPlaces[1], ConferenceRoom_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-28, 54}, {14, 54}, {14, 24}, {12, 24}, {12, 24}, {10, 24}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_Off_M00.outTransition[1], T165.inPlaces[1]) annotation(
      Line(points = {{-10, 24}, {-18, 24}, {-18, 34}, {-26, 34}, {-26, 34}, {-28, 34}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_Off_M00.outTransition[2], T169.inPlaces[1]) annotation(
      Line(points = {{-10, 24}, {-18, 24}, {-18, 14}, {-26, 14}, {-26, 14}, {-28, 14}}, thickness = 0.5));
    connect(T168.outPlaces[1], ConferenceRoom_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66, 14}, {82, 14}, {82, 2}, {86, 2}, {86, 2}, {88, 2}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_II_M00.outTransition[1], T157.inPlaces[1]) annotation(
      Line(points = {{108, 2}, {112, 2}, {112, -12}, {76, -12}, {76, -6}, {66, -6}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_I_M00.outTransition[1], T171.inPlaces[1]) annotation(
      Line(points = {{88, 46}, {84, 46}, {84, 54}, {68, 54}, {68, 54}, {66, 54}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_I_M00.inTransition[1], T162.outPlaces[1]) annotation(
      Line(points = {{108, 46}, {112, 46}, {112, 34}, {66, 34}, {66, 34}, {66, 34}}, thickness = 0.5));
    connect(T171.outPlaces[1], ConferenceRoom_RLT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{58, 54}, {16, 54}, {16, 24}, {20, 24}, {20, 24}, {22, 24}}, thickness = 0.5));
    connect(T157.outPlaces[1], ConferenceRoom_RLT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{58, -6}, {16, -6}, {16, 24}, {22, 24}, {22, 24}, {22, 24}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_Off_M00.outTransition[2], T168.inPlaces[1]) annotation(
      Line(points = {{42, 24}, {48, 24}, {48, 14}, {56, 14}, {56, 14}, {58, 14}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_Off_M00.outTransition[1], T162.inPlaces[1]) annotation(
      Line(points = {{42, 24}, {48, 24}, {48, 34}, {56, 34}, {56, 34}, {58, 34}}, thickness = 0.5));
    connect(T15.outPlaces[1], Workshop_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 364}, {108, 364}, {108, 370}, {112, 370}, {112, 382}, {108, 382}, {108, 382}}, thickness = 0.5));
    connect(T1.outPlaces[1], Workshop_RLT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66, 370}, {112, 370}, {112, 382}, {108, 382}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_I_M00.outTransition[1], T11.inPlaces[1]) annotation(
      Line(points = {{88, 382}, {78, 382}, {78, 390}, {68, 390}, {68, 390}, {66, 390}}, thickness = 0.5));
    connect(T11.outPlaces[1], Workshop_RLT_Heating_Off_M01.inTransition[1]) annotation(
      Line(points = {{58, 390}, {18, 390}, {18, 360}, {22, 360}}, thickness = 0.5));
    connect(T110.outPlaces[1], Workshop_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-80, 364}, {-80, 370}, {-84, 370}, {-84, 384}, {-81, 384}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_I_M00.outTransition[1], T16.inPlaces[1]) annotation(
      Line(points = {{-59, 384}, {-48, 384}, {-48, 390}, {-36, 390}}, thickness = 0.5));
    connect(T17.outPlaces[1], Workshop_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36, 370}, {-84, 370}, {-84, 384}, {-81, 384}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_I_M00.outTransition[2], T111.inPlaces[1]) annotation(
      Line(points = {{-60, 384}, {-54, 384}, {-54, 370}, {-60, 370}, {-60, 366}, {-60, 366}, {-60, 364}}, thickness = 0.5));
    connect(T16.outPlaces[1], Workshop_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-28, 390}, {12, 390}, {12, 360}, {7, 360}}, thickness = 0.5));
    connect(T13.outPlaces[1], Workshop_RLT_Heating_Off_M01.inTransition[2]) annotation(
      Line(points = {{58, 330}, {18, 330}, {18, 360}, {22, 360}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_Off_M01.outTransition[2], T12.inPlaces[1]) annotation(
      Line(points = {{42, 360}, {50, 360}, {50, 350}, {56, 350}, {56, 350}, {58, 350}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_Off_M01.outTransition[1], T1.inPlaces[1]) annotation(
      Line(points = {{42, 360}, {50, 360}, {50, 370}, {58, 370}, {58, 370}}, thickness = 0.5));
    connect(T12.outPlaces[1], Workshop_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66, 350}, {86, 350}, {86, 338}, {88, 338}, {88, 338}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_II_M00.outTransition[1], T13.inPlaces[1]) annotation(
      Line(points = {{108, 338}, {108, 338}, {108, 324}, {70, 324}, {70, 330}, {66, 330}, {66, 330}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_II_M00.outTransition[2], T15.inPlaces[1]) annotation(
      Line(points = {{108, 338}, {108, 338}, {108, 356}, {108, 356}}, thickness = 0.5));
    connect(T19.outPlaces[1], Workshop_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-28, 330}, {12, 330}, {12, 360}, {7, 360}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_Off_M00.outTransition[2], T18.inPlaces[1]) annotation(
      Line(points = {{-15, 360}, {-18, 360}, {-18, 350}, {-27, 350}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_Off_M00.outTransition[1], T17.inPlaces[1]) annotation(
      Line(points = {{-15, 360}, {-18, 360}, {-18, 370}, {-27, 370}}, thickness = 0.5));
    connect(T18.outPlaces[1], Workshop_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36, 350}, {-54, 350}, {-54, 338}, {-58, 338}, {-58, 338}, {-60, 338}}, thickness = 0.5));
    connect(T111.outPlaces[1], Workshop_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 356}, {-60, 356}, {-60, 350}, {-54, 350}, {-54, 338}, {-60, 338}, {-60, 338}, {-60, 338}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_II_M00.outTransition[1], T19.inPlaces[1]) annotation(
      Line(points = {{-80, 338}, {-86, 338}, {-86, 326}, {-46, 326}, {-46, 330}, {-38, 330}, {-38, 330}, {-36, 330}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_II_M00.outTransition[2], T110.inPlaces[1]) annotation(
      Line(points = {{-80, 338}, {-86, 338}, {-86, 350}, {-80, 350}, {-80, 354}, {-80, 354}, {-80, 356}}, thickness = 0.5));
    connect(T113.outPlaces[1], Workshop_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-28, 250}, {10, 250}, {10, 280}, {8, 280}, {8, 280}, {6, 280}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_II_M00.outTransition[1], T113.inPlaces[1]) annotation(
      Line(points = {{-80, 258}, {-84, 258}, {-84, 244}, {-48, 244}, {-48, 250}, {-38, 250}, {-38, 250}, {-36, 250}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_Off_M00.outTransition[2], T114.inPlaces[1]) annotation(
      Line(points = {{-14, 280}, {-20, 280}, {-20, 270}, {-26, 270}, {-26, 270}, {-28, 270}, {-28, 270}}, thickness = 0.5));
    connect(T114.outPlaces[1], Workshop_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36, 270}, {-54, 270}, {-54, 258}, {-58, 258}, {-58, 258}, {-60, 258}}, thickness = 0.5));
    connect(Workshop_BKT_Heatin_Off_M00.outTransition[2], T115.inPlaces[1]) annotation(
      Line(points = {{42, 280}, {48, 280}, {48, 270}, {58, 270}, {58, 270}, {58, 270}}, thickness = 0.5));
    connect(T115.outPlaces[1], Workshop_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66, 270}, {84, 270}, {84, 258}, {86, 258}, {86, 258}, {88, 258}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_II_M00.outTransition[2], T117.inPlaces[1]) annotation(
      Line(points = {{-80, 258}, {-84, 258}, {-84, 272}, {-80, 272}, {-80, 274}, {-80, 274}, {-80, 276}}, thickness = 0.5));
    connect(T116.outPlaces[1], Workshop_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 276}, {-60, 276}, {-60, 270}, {-54, 270}, {-54, 258}, {-60, 258}, {-60, 258}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_I_M00.outTransition[2], T116.inPlaces[1]) annotation(
      Line(points = {{-60, 302}, {-54, 302}, {-54, 290}, {-60, 290}, {-60, 286}, {-60, 286}, {-60, 284}}, thickness = 0.5));
    connect(T117.outPlaces[1], Workshop_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-80, 284}, {-80, 284}, {-80, 290}, {-88, 290}, {-88, 302}, {-80, 302}, {-80, 302}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_Off_M00.outTransition[1], T120.inPlaces[1]) annotation(
      Line(points = {{-14, 280}, {-20, 280}, {-20, 290}, {-26, 290}, {-26, 290}, {-28, 290}}, thickness = 0.5));
    connect(T122.outPlaces[1], Workshop_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-28, 310}, {10, 310}, {10, 280}, {8, 280}, {8, 280}, {6, 280}}, thickness = 0.5));
    connect(Workshop_BKT_Heating_I_M00.outTransition[2], T118.inPlaces[1]) annotation(
      Line(points = {{88, 302}, {82, 302}, {82, 290}, {88, 290}, {88, 286}, {88, 286}, {88, 284}, {88, 284}}, thickness = 0.5));
    connect(T118.outPlaces[1], Workshop_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 276}, {88, 276}, {88, 270}, {84, 270}, {84, 258}, {88, 258}, {88, 258}}, thickness = 0.5));
    connect(Workshop_BKT_Heatin_Off_M00.outTransition[1], T121.inPlaces[1]) annotation(
      Line(points = {{42, 280}, {48, 280}, {48, 290}, {56, 290}, {56, 290}, {58, 290}}, thickness = 0.5));
    connect(T123.outPlaces[1], Workshop_BKT_Heatin_Off_M00.inTransition[1]) annotation(
      Line(points = {{58, 310}, {18, 310}, {18, 280}, {22, 280}, {22, 280}, {22, 280}}, thickness = 0.5));
    connect(T112.outPlaces[1], Workshop_BKT_Heatin_Off_M00.inTransition[2]) annotation(
      Line(points = {{58, 250}, {18, 250}, {18, 280}, {22, 280}}, thickness = 0.5));
    connect(T120.outPlaces[1], Workshop_BKT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36, 290}, {-88, 290}, {-88, 302}, {-80, 302}, {-80, 302}}, thickness = 0.5));
    connect(T121.outPlaces[1], Workshop_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66, 290}, {112, 290}, {112, 302}, {108, 302}, {108, 302}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_I_M00.outTransition[1], T122.inPlaces[1]) annotation(
      Line(points = {{-60, 302}, {-54, 302}, {-54, 310}, {-38, 310}, {-38, 310}, {-36, 310}}, thickness = 0.5));
    connect(Workshop_BKT_Heating_I_M00.outTransition[1], T123.inPlaces[1]) annotation(
      Line(points = {{88, 302}, {82, 302}, {82, 310}, {66, 310}, {66, 310}, {66, 310}}, thickness = 0.5));
    connect(Workshop_BKT_Heating_II_M00.outTransition[1], T112.inPlaces[1]) annotation(
      Line(points = {{108, 258}, {112, 258}, {112, 246}, {70, 246}, {70, 250}, {66, 250}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_I_M00.outTransition[1], T134.inPlaces[1]) annotation(
      Line(points = {{-60, 134}, {-54, 134}, {-54, 142}, {-36, 142}, {-36, 142}, {-36, 142}}, thickness = 0.5));
    connect(T129.inPlaces[1], Canteen_BKT_Cooling_I_M00.outTransition[2]) annotation(
      Line(points = {{-60, 116}, {-60, 116}, {-60, 122}, {-54, 122}, {-54, 134}, {-60, 134}, {-60, 134}, {-60, 134}}, thickness = 0.5));
    connect(T135.outPlaces[1], Canteen_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-80, 116}, {-80, 116}, {-80, 122}, {-88, 122}, {-88, 134}, {-80, 134}, {-80, 134}}, thickness = 0.5));
    connect(T126.outPlaces[1], Canteen_BKT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36, 122}, {-88, 122}, {-88, 134}, {-80, 134}, {-80, 134}, {-80, 134}}, thickness = 0.5));
    connect(T129.outPlaces[1], Canteen_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 108}, {-60, 108}, {-60, 102}, {-54, 102}, {-54, 90}, {-60, 90}, {-60, 90}}, thickness = 0.5));
    connect(T131.outPlaces[1], Canteen_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36, 102}, {-54, 102}, {-54, 90}, {-58, 90}, {-58, 90}, {-60, 90}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_II_M00.outTransition[2], T135.inPlaces[1]) annotation(
      Line(points = {{-80, 90}, {-86, 90}, {-86, 102}, {-80, 102}, {-80, 106}, {-80, 106}, {-80, 108}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_II_M00.outTransition[1], T132.inPlaces[1]) annotation(
      Line(points = {{-80, 90}, {-86, 90}, {-86, 76}, {-46, 76}, {-46, 82}, {-38, 82}, {-38, 82}, {-36, 82}}, thickness = 0.5));
    connect(T134.outPlaces[1], Canteen_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-28, 142}, {14, 142}, {14, 112}, {12, 112}, {12, 112}, {10, 112}}, thickness = 0.5));
    connect(T132.outPlaces[1], Canteen_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-28, 82}, {14, 82}, {14, 112}, {12, 112}, {12, 112}, {10, 112}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_Off_M00.outTransition[2], T131.inPlaces[1]) annotation(
      Line(points = {{-10, 112}, {-20, 112}, {-20, 102}, {-26, 102}, {-26, 102}, {-28, 102}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_Off_M00.outTransition[1], T126.inPlaces[1]) annotation(
      Line(points = {{-10, 112}, {-20, 112}, {-20, 122}, {-26, 122}, {-26, 122}, {-28, 122}}, thickness = 0.5));
    connect(T128.outPlaces[1], Canteen_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 108}, {88, 108}, {88, 102}, {80, 102}, {80, 90}, {88, 90}, {88, 90}}, thickness = 0.5));
    connect(T130.outPlaces[1], Canteen_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66, 102}, {80, 102}, {80, 90}, {86, 90}, {86, 90}, {88, 90}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_II_M00.outTransition[2], T127.inPlaces[1]) annotation(
      Line(points = {{108, 90}, {114, 90}, {114, 102}, {108, 102}, {108, 108}, {108, 108}, {108, 108}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_II_M00.outTransition[1], T124.inPlaces[1]) annotation(
      Line(points = {{108, 90}, {114, 90}, {114, 76}, {76, 76}, {76, 82}, {68, 82}, {68, 82}, {66, 82}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_I_M00.outTransition[1], T133.inPlaces[1]) annotation(
      Line(points = {{88, 134}, {82, 134}, {82, 142}, {68, 142}, {68, 142}, {66, 142}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_I_M00.outTransition[2], T128.inPlaces[1]) annotation(
      Line(points = {{88, 134}, {82, 134}, {82, 122}, {88, 122}, {88, 118}, {88, 118}, {88, 116}}, thickness = 0.5));
    connect(T127.outPlaces[1], Canteen_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 116}, {108, 116}, {108, 122}, {114, 122}, {114, 134}, {108, 134}, {108, 134}}, thickness = 0.5));
    connect(T125.outPlaces[1], Canteen_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66, 122}, {114, 122}, {114, 134}, {108, 134}, {108, 134}, {108, 134}}, thickness = 0.5));
    connect(T124.outPlaces[1], Canteen_BKT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{58, 82}, {18, 82}, {18, 112}, {20, 112}, {20, 112}, {22, 112}}, thickness = 0.5));
    connect(T133.outPlaces[1], Canteen_BKT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{58, 142}, {18, 142}, {18, 112}, {20, 112}, {20, 112}, {22, 112}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_Off_M00.outTransition[2], T130.inPlaces[1]) annotation(
      Line(points = {{42, 112}, {48, 112}, {48, 102}, {56, 102}, {56, 102}, {58, 102}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_Off_M00.outTransition[1], T125.inPlaces[1]) annotation(
      Line(points = {{42, 112}, {48, 112}, {48, 122}, {58, 122}, {58, 122}, {58, 122}}, thickness = 0.5));
    connect(T138.outPlaces[1], Canteen_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36, 182}, {-54, 182}, {-54, 170}, {-58, 170}, {-58, 170}, {-60, 170}}, thickness = 0.5));
    connect(T140.outPlaces[1], Canteen_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 188}, {-60, 188}, {-60, 182}, {-54, 182}, {-54, 170}, {-60, 170}, {-60, 170}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_II_M00.outTransition[2], T141.inPlaces[1]) annotation(
      Line(points = {{-80, 170}, {-86, 170}, {-86, 182}, {-80, 182}, {-80, 186}, {-80, 186}, {-80, 188}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_II_M00.outTransition[1], T136.inPlaces[1]) annotation(
      Line(points = {{-80, 170}, {-86, 170}, {-86, 156}, {-46, 156}, {-46, 162}, {-38, 162}, {-38, 162}, {-36, 162}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_I_M00.outTransition[1], T146.inPlaces[1]) annotation(
      Line(points = {{-60, 214}, {-54, 214}, {-54, 222}, {-38, 222}, {-38, 222}, {-36, 222}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_I_M00.outTransition[2], T140.inPlaces[1]) annotation(
      Line(points = {{-60, 214}, {-54, 214}, {-54, 202}, {-60, 202}, {-60, 198}, {-60, 198}, {-60, 196}}, thickness = 0.5));
    connect(T142.outPlaces[1], Canteen_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36, 202}, {-88, 202}, {-88, 214}, {-80, 214}, {-80, 214}, {-80, 214}}, thickness = 0.5));
    connect(T141.outPlaces[1], Canteen_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-80, 196}, {-80, 202}, {-88, 202}, {-88, 214}, {-81, 214}}, thickness = 0.5));
    connect(T136.outPlaces[1], Canteen_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-28, 162}, {8, 162}, {8, 192}, {6, 192}, {6, 192}, {6, 192}}, thickness = 0.5));
    connect(T146.outPlaces[1], Canteen_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-28, 222}, {10, 222}, {10, 192}, {8, 192}, {8, 192}, {6, 192}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_Off_M00.outTransition[2], T138.inPlaces[1]) annotation(
      Line(points = {{-14, 192}, {-20, 192}, {-20, 182}, {-28, 182}, {-28, 182}, {-28, 182}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_Off_M00.outTransition[1], T142.inPlaces[1]) annotation(
      Line(points = {{-14, 192}, {-20, 192}, {-20, 202}, {-26, 202}, {-26, 202}, {-28, 202}}, thickness = 0.5));
    connect(T139.outPlaces[1], Canteen_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66, 182}, {82, 182}, {82, 170}, {88, 170}, {88, 170}, {88, 170}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_II_M00.outTransition[1], T137.inPlaces[1]) annotation(
      Line(points = {{108, 170}, {114, 170}, {114, 158}, {78, 158}, {78, 162}, {68, 162}, {68, 162}, {66, 162}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_I_M00.outTransition[1], T147.inPlaces[1]) annotation(
      Line(points = {{88, 214}, {82, 214}, {82, 222}, {66, 222}, {66, 222}, {66, 222}}, thickness = 0.5));
    connect(T145.outPlaces[1], Canteen_RLT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66, 202}, {114, 202}, {114, 214}, {110, 214}, {110, 214}, {108, 214}}, thickness = 0.5));
    connect(T137.outPlaces[1], Canteen_RLT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{58, 162}, {16, 162}, {16, 192}, {20, 192}, {20, 192}, {22, 192}}, thickness = 0.5));
    connect(T147.outPlaces[1], Canteen_RLT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{58, 222}, {16, 222}, {16, 192}, {22, 192}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_Off_M00.outTransition[2], T139.inPlaces[1]) annotation(
      Line(points = {{42, 192}, {46, 192}, {46, 182}, {56, 182}, {56, 182}, {58, 182}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_Off_M00.outTransition[1], T145.inPlaces[1]) annotation(
      Line(points = {{42, 192}, {46, 192}, {46, 202}, {56, 202}, {56, 202}, {58, 202}}, thickness = 0.5));
    annotation(
      Icon( 
      coordinateSystem(preserveAspectRatio = false, extent = {{-100, -150}, {500, 450}})),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -150}, {500, 450}})),
      __OpenModelica_commandLineOptions = "",
  Documentation(info = "<html><head></head><body>Struktur des Output-Vektors:<div><br></div><div>1<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_RLT_Heating_Off_M00</div><div>2<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_RLT_Heating_I_M00</div><div>3<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_RLT_Heating_II_M00</div><div>4<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_RLT_Cooling_Off_M00</div><div>5<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_RLT_Cooling_I_M00</div><div>6<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_RLT_Cooling_II_M00</div><div><div>7<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_BKT_Heating_Off_M00</div><div>8<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_BKT_Heating_I_M00</div><div>9<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_BKT_Heating_II_M00</div><div>10<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_BKT_Cooling_Off_M00</div><div>11<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_BKT_Cooling_I_M00</div><div>12<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Workshop_BKT_Cooling_II_M00</div></div><div><br></div><div><div>13<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_RLT_Heating_Off_M00</div><div>14<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_RLT_Heating_I_M00</div><div>15<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_RLT_Heating_II_M00</div><div>16<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_RLT_Cooling_Off_M00</div><div>17<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_RLT_Cooling_I_M00</div><div>18<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_RLT_Cooling_II_M00</div><div><div>19<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_BKT_Heating_Off_M00</div><div>20<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_BKT_Heating_I_M00</div><div>21<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_BKT_Heating_II_M00</div><div>22<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_BKT_Cooling_Off_M00</div><div>23<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_BKT_Cooling_I_M00</div><div>24<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Canteen_BKT_Cooling_II_M00</div></div></div><div><br></div><div><div>25<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_RLT_Heating_Off_M00</div><div>26<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_RLT_Heating_I_M00</div><div>27<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_RLT_Heating_II_M00</div><div>28<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_RLT_Cooling_Off_M00</div><div>29<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_RLT_Cooling_I_M00</div><div>30<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_RLT_Cooling_II_M00</div><div><div>31<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_BKT_Heating_Off_M00</div><div>32<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_BKT_Heating_I_M00</div><div>33<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_BKT_Heating_II_M00</div><div>34<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_BKT_Cooling_Off_M00</div><div>35<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_BKT_Cooling_I_M00</div><div>36<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>ConferenceRoom_BKT_Cooling_II_M00</div></div></div><div><br></div><div><div>37<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_RLT_Heating_Off_M00</div><div>38<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_RLT_Heating_I_M00</div><div>39<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_RLT_Heating_II_M00</div><div>40<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_RLT_Cooling_Off_M00</div><div>41<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_RLT_Cooling_I_M00</div><div>42<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_RLT_Cooling_II_M00</div><div><div>43<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_BKT_Heating_Off_M00</div><div>44<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_BKT_Heating_I_M00</div><div>45<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_BKT_Heating_II_M00</div><div>46<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_BKT_Cooling_Off_M00</div><div>47<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_BKT_Cooling_I_M00</div><div>48<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>MultipersonOffice_BKT_Cooling_II_M00</div></div></div><div><br></div><div><div>49<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_RLT_Heating_Off_M00</div><div>50<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_RLT_Heating_I_M00</div><div>51<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_RLT_Heating_II_M00</div><div>52<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_RLT_Cooling_Off_M00</div><div>53<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_RLT_Cooling_I_M00</div><div>54<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_RLT_Cooling_II_M00</div><div><div>55<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_BKT_Heating_Off_M00</div><div>56<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_BKT_Heating_I_M00</div><div>57<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_BKT_Heating_II_M00</div><div>58<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_BKT_Cooling_Off_M00</div><div>59<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_BKT_Cooling_I_M00</div><div>60<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OpenplanOffice_BKT_Cooling_II_M00</div></div></div><div><br></div><div><div>61<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>RLT_Central_Heating_Off_M00</div><div>62<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>RLT_Central_Heating_I_M00</div><div>63<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>RLT_Central_Heating_II_M00</div><div>64<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>RLT_Central_Cooling_Off_M00</div><div>65<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>RLT_Central_Cooling_I_M00</div><div>66<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>RLT_Central_Cooling_II_M00</div><div><br></div><div>67<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Hot_Off_M00</div><div>68<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Hot_I_M00</div><div>69<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Hot_II_M00</div><div><br></div><div>70<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Warm_Off_M00</div><div>71<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Warm_I_M00</div><div>72<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Warm_II_M00</div><div><br></div><div>73<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Cold_Off_M00</div><div>74<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Cold_I_M00</div><div>75<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Generation_Cold_II_M00</div><div><div><br></div></div></div><div><br></div><div><br></div></body></html>"));
  end Automatisierungsebene;

  model Feldebene "Auswahl der Aktoren basierend auf den ausgewählten Aktorsätzen"
    Model.BusSystems.Bus_Control bus_Control annotation(
      Placement(transformation(extent = {{-20, -114}, {20, -74}})));
    Modelica.Blocks.Interfaces.IntegerInput u annotation(
      Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 100})));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false)),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end Feldebene;

  model Controlling_MODI
    Feldebene feldebene annotation(
      Placement(transformation(extent = {{-40, -40}, {-20, -20}})));
    Model.BusSystems.Bus_measure bus_measure annotation(
      Placement(transformation(extent = {{50, 50}, {90, 90}})));
    Model.BusSystems.Bus_Control bus_Control annotation(
      Placement(transformation(extent = {{52, -92}, {92, -52}})));
  ManagementEbene managementEbene1 annotation(
      Placement(visible = true, transformation(origin = {-22, 60}, extent = {{-20, -10}, {20, 10}}, rotation = 0)));
  equation
    connect(feldebene.bus_Control, bus_Control) annotation(
      Line(points = {{-30, -39.4}, {-30, -72}, {72, -72}}, color = {255, 204, 51}, thickness = 0.5),
      Text(string = "%second", index = 1, extent = {{-3, -6}, {-3, -6}}, horizontalAlignment = TextAlignment.Right));
  protected
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false)),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end Controlling_MODI;
end MODI;
