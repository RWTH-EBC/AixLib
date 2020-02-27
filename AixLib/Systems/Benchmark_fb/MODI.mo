within AixLib.Systems.Benchmark_fb;

package MODI
  model ManagementEbene_Temp_Hum "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten für die Temperatur und relative Luftfeuchtigkeit im Raum"
    PNlib.Components.T disableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 15, TRoomMea[2] > 273.15 + 20, TRoomMea[3] > 273.15 + 20, TRoomMea[4] > 273.15 + 20, TRoomMea[5] > 273.15 + 20}) annotation(
      Placement(visible = true, transformation(origin = {-56, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T enableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] < 273.15 + 13, TRoomMea[2] < 273.15 + 18, TRoomMea[3] < 273.15 + 18, TRoomMea[4] < 273.15 + 18, TRoomMea[5] < 273.15 + 18}) annotation(
      Placement(visible = true, transformation(extent = {{-66, 20}, {-46, 40}}, rotation = 0)));
    PNlib.Components.PD Heating[5](each nIn = 1, each nOut = 1, each startTokens = 0, each minTokens = 0, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD Off_Temperature[5](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1, each reStart = true, each reStartTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Cooling[5](each nIn = 1, each nOut = 1, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-182, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T enableCooling[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 17, TRoomMea[2] > 273.15 + 22, TRoomMea[3] > 273.15 + 22, TRoomMea[4] > 273.15 + 22, TRoomMea[5] > 273.15 + 22}) annotation(
      Placement(visible = true, transformation(origin = {-144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T disableCooling[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] < 273.15 + 15, TRoomMea[2] < 273.15 + 20, TRoomMea[3]< 273.15 + 20, TRoomMea[4] < 273.15 + 20, TRoomMea[5] < 273.15 + 20}) annotation(
      Placement(visible = true, transformation(extent = {{-154, 20}, {-134, 40}}, rotation = 0)));
    PNlib.Components.PD Dehumidifying[5](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD Off_Humidity[5](each nIn = 2, each nOut = 2, each reStartTokens = 1, each startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Humidifying[5](each nIn = 1, each nOut = 1, each reStartTokens = 1, each startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {184, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T enableHumidifying[5](each nIn = 1, each nOut = 1, firingCon={HumRoomMea[1]<=0.4,HumRoomMea[2]<=0.4,HumRoomMea[3]<=0.4,HumRoomMea[4]<=0.4,HumRoomMea[5]<=0.4}) annotation(
      Placement(visible = true, transformation(origin = {146, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T enableDehumidifying[5](each nIn = 1, each nOut = 1, firingCon={HumRoomMea[1]>0.6,HumRoomMea[2]>0.6,HumRoomMea[3]>0.6,HumRoomMea[4]>0.6,HumRoomMea[5]>0.6}) annotation(
      Placement(visible = true, transformation(origin = {58, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T disableDehumidifying[5](each nIn = 1, each nOut = 1, firingCon={HumRoomMea[1]<=0.6,HumRoomMea[2]<=0.6,HumRoomMea[3]<=0.6,HumRoomMea[4]<=0.6,HumRoomMea[5]<=0.6}) annotation(
      Placement(visible = true, transformation(origin = {56, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T disableHumidifying[5](each nIn = 1, each nOut = 1, firingCon={HumRoomMea[1]>0.4,HumRoomMea[2]>0.4,HumRoomMea[3]>0.4,HumRoomMea[4]>0.4,HumRoomMea[5]>0.4}) annotation(
      Placement(visible = true, transformation(origin = {144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1[30](each threshold = 0.5)  annotation(
      Placement(visible = true, transformation(origin = {0, -72}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput y[30] annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation(
      Placement(visible = true, transformation(origin = {-100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {-100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput HumRoomMea[5] annotation(
      Placement(visible = true, transformation(origin = {100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  equation
    connect(realToBoolean1[1].y, y[1]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[2].y, y[2]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[3].y, y[3]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[4].y, y[4]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[5].y, y[5]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[6].y, y[6]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[7].y, y[7]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[8].y, y[8]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[9].y, y[9]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[10].y, y[10]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[11].y, y[11]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[12].y, y[12]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[13].y, y[13]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[14].y, y[14]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[15].y, y[15]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[16].y, y[16]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[17].y, y[17]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[18].y, y[18]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[19].y, y[19]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[20].y, y[20]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[21].y, y[21]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[22].y, y[22]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[23].y, y[23]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[24].y, y[24]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[25].y, y[25]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[26].y, y[26]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[27].y, y[27]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[28].y, y[28]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[29].y, y[29]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[30].y, y[30]) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  
  
  
  realToBoolean1[1].u=Off_Temperature[1].t;
  realToBoolean1[2].u=Heating[1].t;
  realToBoolean1[3].u=Cooling[1].t;
  realToBoolean1[4].u=Off_Temperature[2].t;
  realToBoolean1[5].u=Heating[2].t;
  realToBoolean1[6].u=Cooling[2].t;
  realToBoolean1[7].u=Off_Temperature[3].t;
  realToBoolean1[8].u=Heating[3].t;
  realToBoolean1[9].u=Cooling[3].t;
  realToBoolean1[10].u=Off_Temperature[4].t;
  realToBoolean1[11].u=Heating[4].t;
  realToBoolean1[12].u=Cooling[4].t;
  realToBoolean1[13].u=Off_Temperature[5].t;
  realToBoolean1[14].u=Heating[5].t;
  realToBoolean1[15].u=Cooling[5].t;
  
  realToBoolean1[16].u=Off_Humidity[1].t;
  realToBoolean1[17].u=Humidifying[1].t;
  realToBoolean1[18].u=Dehumidifying[1].t;
  realToBoolean1[19].u=Off_Humidity[2].t;
  realToBoolean1[20].u=Humidifying[2].t;
  realToBoolean1[21].u=Dehumidifying[2].t;
  realToBoolean1[22].u=Off_Humidity[3].t;
  realToBoolean1[23].u=Humidifying[3].t;
  realToBoolean1[24].u=Dehumidifying[3].t;
  realToBoolean1[25].u=Off_Humidity[4].t;
  realToBoolean1[26].u=Humidifying[4].t;
  realToBoolean1[27].u=Dehumidifying[4].t;
  realToBoolean1[28].u=Off_Humidity[5].t;
  realToBoolean1[29].u=Humidifying[5].t;
  realToBoolean1[30].u=Dehumidifying[5].t;
  
  
    connect(Cooling[1].outTransition[1], disableCooling[1].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
    connect(disableDehumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[2]) annotation(
      Line(points = {{60.8, 30}, {112, 30}, {112, -0.5}, {110.8, -0.5}}, thickness = 0.5));
    connect(disableDehumidifying[5].outPlaces[1], Off_Humidity[5].inTransition[2]) annotation(
      Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
    connect(disableDehumidifying[4].outPlaces[1], Off_Humidity[4].inTransition[2]) annotation(
      Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
    connect(disableDehumidifying[3].outPlaces[1], Off_Humidity[3].inTransition[2]) annotation(
      Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {112, 0}, {112, -0.5}, {110.8, -0.5}}, thickness = 0.5));
    connect(disableDehumidifying[2].outPlaces[1], Off_Humidity[2].inTransition[2]) annotation(
      Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
    connect(Off_Humidity[5].outTransition[1], enableHumidifying[5].inPlaces[1]) annotation(
      Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
    connect(Off_Humidity[4].outTransition[1], enableHumidifying[4].inPlaces[1]) annotation(
      Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
    connect(Off_Humidity[3].outTransition[1], enableHumidifying[3].inPlaces[1]) annotation(
      Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
    connect(Off_Humidity[2].outTransition[1], enableHumidifying[2].inPlaces[1]) annotation(
      Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
    connect(Off_Humidity[1].outTransition[1], enableHumidifying[1].inPlaces[1]) annotation(
      Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
    connect(enableHumidifying[5].outPlaces[1], Humidifying[5].inTransition[1]) annotation(
      Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
    connect(enableHumidifying[4].outPlaces[1], Humidifying[4].inTransition[1]) annotation(
      Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
    connect(enableHumidifying[3].outPlaces[1], Humidifying[3].inTransition[1]) annotation(
      Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
    connect(enableHumidifying[2].outPlaces[1], Humidifying[2].inTransition[1]) annotation(
      Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
    connect(enableHumidifying[1].outPlaces[1], Humidifying[1].inTransition[1]) annotation(
      Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
    connect(disableDehumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[2]) annotation(
      Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
    connect(disableHumidifying[5].outPlaces[1], Off_Humidity[5].inTransition[1]) annotation(
      Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
    connect(disableHumidifying[4].outPlaces[1], Off_Humidity[4].inTransition[1]) annotation(
      Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
    connect(disableHumidifying[3].outPlaces[1], Off_Humidity[3].inTransition[1]) annotation(
      Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
    connect(disableHumidifying[2].outPlaces[1], Off_Humidity[2].inTransition[1]) annotation(
      Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
    connect(disableHumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[1]) annotation(
      Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
    connect(Off_Humidity[5].outTransition[2], enableDehumidifying[5].inPlaces[1]) annotation(
      Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
    connect(Off_Humidity[4].outTransition[2], enableDehumidifying[4].inPlaces[1]) annotation(
      Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {64, -30}, {64, -30}, {62.8, -30}}, thickness = 0.5));
    connect(Off_Humidity[3].outTransition[2], enableDehumidifying[3].inPlaces[1]) annotation(
      Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
    connect(Off_Humidity[2].outTransition[2], enableDehumidifying[2].inPlaces[1]) annotation(
      Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
    connect(Off_Humidity[1].outTransition[2], enableDehumidifying[1].inPlaces[1]) annotation(
      Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {64, -30}, {64, -30}, {62.8, -30}}, thickness = 0.5));
    connect(Dehumidifying[5].outTransition[1], disableDehumidifying[5].inPlaces[1]) annotation(
      Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
    connect(Dehumidifying[4].outTransition[1], disableDehumidifying[4].inPlaces[1]) annotation(
      Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
    connect(Dehumidifying[3].outTransition[1], disableDehumidifying[3].inPlaces[1]) annotation(
      Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
    connect(Dehumidifying[2].outTransition[1], disableDehumidifying[2].inPlaces[1]) annotation(
      Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
    connect(Dehumidifying[1].outTransition[1], disableDehumidifying[1].inPlaces[1]) annotation(
      Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
    connect(enableDehumidifying[5].outPlaces[1], Dehumidifying[5].inTransition[1]) annotation(
      Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
    connect(enableDehumidifying[4].outPlaces[1], Dehumidifying[4].inTransition[1]) annotation(
      Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
    connect(enableDehumidifying[3].outPlaces[1], Dehumidifying[3].inTransition[1]) annotation(
      Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
    connect(enableDehumidifying[2].outPlaces[1], Dehumidifying[2].inTransition[1]) annotation(
      Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
    connect(enableDehumidifying[1].outPlaces[1], Dehumidifying[1].inTransition[1]) annotation(
      Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
    connect(Humidifying[4].outTransition[1], disableHumidifying[4].inPlaces[1]) annotation(
      Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
    connect(Humidifying[3].outTransition[1], disableHumidifying[3].inPlaces[1]) annotation(
      Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
    connect(Humidifying[2].outTransition[1], disableHumidifying[2].inPlaces[1]) annotation(
      Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
    connect(Humidifying[1].outTransition[1], disableHumidifying[1].inPlaces[1]) annotation(
      Line(points = {{184, -10.8}, {184, -30}, {148.8, -30}}, thickness = 0.5));
    connect(enableHeating[5].outPlaces[1], Heating[5].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-16, 30}, {-16, 10.8}}));
    connect(disableCooling[5].outPlaces[1], Off_Temperature[5].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
    connect(disableCooling[4].outPlaces[1], Off_Temperature[4].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
    connect(disableCooling[3].outPlaces[1], Off_Temperature[3].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
    connect(disableCooling[2].outPlaces[1], Off_Temperature[2].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
    connect(disableCooling[1].outPlaces[1], Off_Temperature[1].inTransition[2]) annotation(
      Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
    connect(Cooling[5].outTransition[1], disableCooling[5].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
    connect(Cooling[4].outTransition[1], disableCooling[4].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
    connect(Cooling[3].outTransition[1], disableCooling[3].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
    connect(Cooling[2].outTransition[1], disableCooling[2].inPlaces[1]) annotation(
      Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
    connect(Off_Temperature[5].outTransition[2], enableCooling[5].inPlaces[1]) annotation(
      Line(points = {{-110.8, -0.5}, {-111.8, -0.5}, {-111.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
    connect(Off_Temperature[4].outTransition[2], enableCooling[4].inPlaces[1]) annotation(
      Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
    connect(Off_Temperature[3].outTransition[2], enableCooling[3].inPlaces[1]) annotation(
      Line(points = {{-110.8, -0.5}, {-111.8, -0.5}, {-111.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
    connect(Off_Temperature[2].outTransition[2], enableCooling[2].inPlaces[1]) annotation(
      Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
    connect(Off_Temperature[1].outTransition[2], enableCooling[1].inPlaces[1]) annotation(
      Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
    connect(enableCooling[5].outPlaces[1], Cooling[5].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
    connect(enableCooling[4].outPlaces[1], Cooling[4].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
    connect(enableCooling[3].outPlaces[1], Cooling[3].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
    connect(enableCooling[2].outPlaces[1], Cooling[2].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
    connect(enableCooling[1].outPlaces[1], Cooling[1].inTransition[1]) annotation(
      Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
    connect(disableHeating[5].outPlaces[1], Off_Temperature[5].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
    connect(disableHeating[4].outPlaces[1], Off_Temperature[4].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
    connect(disableHeating[3].outPlaces[1], Off_Temperature[3].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
    connect(disableHeating[2].outPlaces[1], Off_Temperature[2].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
    connect(disableHeating[1].outPlaces[1], Off_Temperature[1].inTransition[1]) annotation(
      Line(points = {{-60.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
    connect(Off_Temperature[5].outTransition[1], enableHeating[5].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
    connect(Off_Temperature[4].outTransition[1], enableHeating[4].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
    connect(Off_Temperature[3].outTransition[1], enableHeating[3].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
    connect(Off_Temperature[2].outTransition[1], enableHeating[2].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
    connect(Off_Temperature[1].outTransition[1], enableHeating[1].inPlaces[1]) annotation(
      Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
    connect(Heating[5].outTransition[1], disableHeating[5].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
    connect(Heating[4].outTransition[1], disableHeating[4].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
    connect(Heating[3].outTransition[1], disableHeating[3].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
    connect(Heating[2].outTransition[1], disableHeating[2].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
    connect(Heating[1].outTransition[1], disableHeating[1].inPlaces[1]) annotation(
      Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
    connect(enableHeating[4].outPlaces[1], Heating[4].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-33.7, 30}, {-33.7, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
    connect(enableHeating[3].outPlaces[1], Heating[3].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
    connect(enableHeating[2].outPlaces[1], Heating[2].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
    connect(enableHeating[1].outPlaces[1], Heating[1].inTransition[1]) annotation(
      Line(points = {{-51.2, 30}, {-33.7, 30}, {-33.7, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
    connect(Humidifying[5].outTransition[1], disableHumidifying[5].inPlaces[1]) annotation(
      Line(points = {{184, -10.8}, {184, -30}, {148.8, -30}}, color = {0, 0, 0}));
    annotation(
      Line(points = {{-60, -106}, {-60, -106}}, color = {255, 127, 0}),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}}), graphics = {Rectangle(extent = {{-200, 100}, {200, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Text(extent = {{-162, 34}, {152, -28}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, textString = "Management-Ebene")}),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}})),
      Documentation(info = "<html><head></head><body><div>Struktur des Output-Vektors (oben nach unten)</div><div><br></div><div>Workshop_Off</div><div>Workshop_Heating</div><div>Workshop_Cooling</div><div>Canteen_Off</div><div>Canteen_Heating</div><div>Canteen_Cooling</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Heating</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Heating</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Off</div><div><div style=\"font-size: 12px;\"><div>OpenplanOffice_Heating</div><div></div></div><div style=\"font-size: 12px;\">OpenplanOffice_Cooling</div></div><div><div>Workshop_Off</div><div>Workshop_Humidifying</div><div>Workshop_Dehumidifying</div><div>Canteen_Off</div><div>Canteen_Humidifying</div><div>Canteen_Dehumidifying</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Humidifying</div><div>ConferenceRoom_Dehumidifying</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Humidifying</div><div>MultipersonOffice_Dehumidifying</div><div>OpenplanOffice_Off</div><div><div style=\"font-size: 12px;\"><div>OpenplanOffice_<span style=\"font-size: medium;\">Humidifying</span></div><div></div></div><div style=\"font-size: 12px;\">OpenplanOffice_Dehumidifying</div></div></div></body></html>"),
      __OpenModelica_commandLineOptions = "");
  end ManagementEbene_Temp_Hum;

  model Feldebene "Auswahl der Aktoren basierend auf den ausgewählten Aktorsätzen"
    import Benchmark_fb;
  AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus1 annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {198, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.EONERC_MainBuilding.Controller.CtrGTFSimple ctrGTFSimple1 annotation(
      Placement(visible = true, transformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.EONERC_MainBuilding.Controller.CtrSWU ctrSWU1 annotation(
      Placement(visible = true, transformation(origin = {-110, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl.CtrHP ctrHP1 annotation(
      Placement(visible = true, transformation(origin = {-108, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.ModularAHU.Controller.CtrVentilationUnitTsetRoom ctrVentilationUnitTsetRoom1 annotation(
      Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput u[29] annotation(
      Placement(visible = true, transformation(origin = {2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
  AixLib.Systems.Benchmark.Controller.CtrTabs2 ctrTabs21 annotation(
      Placement(visible = true, transformation(origin = {-110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark_fb.MODI.Controller_HTSSystem controller_HTSSystem1(T_boi_set = 273.15 + 80, T_chp_set = 333.15)  annotation(
      Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark.Controller.CtrHTSSystem ctrHTSSystem1 annotation(
      Placement(visible = true, transformation(origin = {-110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark_fb.MODI.Controller.Controller_GTFSystem controller_GTFSystem1 annotation(
      Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(gtfBus, mainBus1.gtfBus) annotation(
      Line(points = {{-60, 44}, {100, 44}, {100, 0}}, color = {255, 204, 51}, thickness = 0.5));
    connect(mainBus1.htsBus, highTempSystemBus1) annotation(
      Line(points = {{100, 0}, {100, 0}, {100, 70}, {-60, 70}, {-60, 70}}, color = {255, 204, 51}, thickness = 0.5));
    connect(u[3], controller_HTSSystem1.HTS_Heating_II) annotation(
      Line(points = {{0, 114}, {0, 114}, {0, 64}, {-58, 64}, {-58, 64}}, color = {255, 0, 255}));
    connect(u[2], controller_HTSSystem1.HTS_Heating_I) annotation(
      Line(points = {{0, 114}, {0, 114}, {0, 76}, {-58, 76}, {-58, 76}}, color = {255, 0, 255}));
    connect(or1.y, htsBus.onOffChpSet) annotation(
      Line(points = {{-72, 70}, {-80, 70}, {-80, 70}, {-80, 70}}, color = {255, 0, 255}));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-200, 100}, {200, -100}}), Text(origin = {-34, 16},fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-74, 24}, {150, -48}}, textString = "Feldebene")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end Feldebene;

model Controlling_MODI
  import Benchmark_fb;
  AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus annotation(
    Placement(visible = true, transformation(extent = {{90, 48}, {110, 68}}, rotation = 0), iconTransformation(extent = {{90, 48}, {110, 68}}, rotation = 0)));
AixLib.Systems.Benchmark_fb.MODI.ManagementEbene_Temp managementEbene_Temp1 annotation(
    Placement(visible = true, transformation(origin = {-40, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
AixLib.Systems.Benchmark_fb.MODI.Feldebene feldebene1 annotation(
    Placement(visible = true, transformation(origin = {-40, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput TAirOutside annotation(
      Placement(visible = true, transformation(origin = {104, 0}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {104, 0}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
  AixLib.Systems.Benchmark_fb.MODI.AutomationLevel_MODImethod automationLevel_MODImethod2 annotation(
      Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-20, -10}, {20, 10}}, rotation = 0)));

equation
    connect(automationLevel_MODImethod2.y[1], feldebene1.u[1]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
     connect(automationLevel_MODImethod2.y[2], feldebene1.u[2]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[3], feldebene1.u[3]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[4], feldebene1.u[4]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[5], feldebene1.u[5]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[6], feldebene1.u[6]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[7], feldebene1.u[7]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[8], feldebene1.u[8]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[9], feldebene1.u[9]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[10], feldebene1.u[10]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[11], feldebene1.u[11]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));      connect(automationLevel_MODImethod2.y[12], feldebene1.u[12]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));      connect(automationLevel_MODImethod2.y[13], feldebene1.u[13]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[14], feldebene1.u[14]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[15], feldebene1.u[15]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[16], feldebene1.u[16]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[17], feldebene1.u[17]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[18], feldebene1.u[18]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[19], feldebene1.u[19]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[20], feldebene1.u[20]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[21], feldebene1.u[21]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[22], feldebene1.u[22]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[23], feldebene1.u[23]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[24], feldebene1.u[24]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[25], feldebene1.u[25]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[26], feldebene1.u[26]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[27], feldebene1.u[27]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[28], feldebene1.u[28]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
      connect(automationLevel_MODImethod2.y[29], feldebene1.u[29]) annotation(
      Line(points = {{-40, -10}, {-40, -10}, {-40, -58}, {-40, -58}}, color = {255, 0, 255}, thickness = 0.5));
       
      
      
      
      
      
    connect(managementEbene_Temp1.y[1], automationLevel_MODImethod2.u[1]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[2], automationLevel_MODImethod2.u[2]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[3], automationLevel_MODImethod2.u[3]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[4], automationLevel_MODImethod2.u[4]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[5], automationLevel_MODImethod2.u[5]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));      
      connect(managementEbene_Temp1.y[6], automationLevel_MODImethod2.u[6]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));      
      connect(managementEbene_Temp1.y[7], automationLevel_MODImethod2.u[7]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[8], automationLevel_MODImethod2.u[8]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[9], automationLevel_MODImethod2.u[9]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[10], automationLevel_MODImethod2.u[10]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[11], automationLevel_MODImethod2.u[11]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[12], automationLevel_MODImethod2.u[12]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[13], automationLevel_MODImethod2.u[13]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[14], automationLevel_MODImethod2.u[14]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[15], automationLevel_MODImethod2.u[15]) annotation(
      Line(points = {{-40, 60}, {-40, 60}, {-40, 12}, {-40, 12}}, color = {255, 0, 255}, thickness = 0.5));
      
      
    connect(automationLevel_MODImethod2.TAirOutside, TAirOutside) annotation(
      Line(points = {{-18, 0}, {96, 0}, {96, 0}, {104, 0}}, color = {0, 0, 127}));
    connect(mainBus.TRoom5Mea, managementEbene_Temp1.TRoomMea[5]) annotation(
      Line(points = {{100, 58}, {100, 58}, {100, 100}, {-40, 100}, {-40, 82}, {-40, 82}}, color = {255, 204, 51}, thickness = 0.5));
    connect(mainBus.TRoom4Mea, managementEbene_Temp1.TRoomMea[4]) annotation(
      Line(points = {{100, 58}, {100, 58}, {100, 100}, {-40, 100}, {-40, 82}, {-40, 82}}, color = {255, 204, 51}, thickness = 0.5));
    connect(mainBus.TRoom3Mea, managementEbene_Temp1.TRoomMea[3]) annotation(
      Line(points = {{100, 58}, {100, 58}, {100, 100}, {-40, 100}, {-40, 82}, {-40, 82}}, color = {255, 204, 51}, thickness = 0.5));
    connect(mainBus.TRoom2Mea, managementEbene_Temp1.TRoomMea[2]) annotation(
      Line(points = {{100, 58}, {100, 58}, {100, 100}, {-40, 100}, {-40, 82}, {-40, 82}}, color = {255, 204, 51}, thickness = 0.5));
    connect(mainBus.TRoom1Mea, managementEbene_Temp1.TRoomMea[1]) annotation(
      Line(points = {{100, 58}, {100, 58}, {100, 100}, {-40, 100}, {-40, 82}, {-40, 82}}, color = {255, 204, 51}, thickness = 0.5));  
    annotation(
    Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Text(extent = {{-66, 28}, {58, -30}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, textString = "MODI")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end Controlling_MODI;

  model AutomatisierungsebeneV2
    PNlib.Components.PD RLT_Heating_I[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-44, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T11[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-80, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD RLT_Cooling_I[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-212, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T16[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-174, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD RLT_Heating_Off[6](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{-120, 78}, {-100, 98}}, rotation = 0)));
    PNlib.Components.PD RLT_Heating_II[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-44, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-80, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T12[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-80, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T13[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-80, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T15[6](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-34, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T14[6](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-54, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD RLT_Cooling_Off[6](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-146, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD RLT_Cooling_II[6](each nIn = 2, each nOut = 2, each startTokens = 0, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-212, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T17[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-174, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T18[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-174, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T19[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-174, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T110[6](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-222, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T111[6](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-202, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T113[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-172,-42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T114[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-172, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T115[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-78, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD BKT_Cooling_II[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-210, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T116[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-200, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T117[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-220, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T118[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-52, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T119[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-30, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD BKT_Off[5](each nIn = 4, each nOut = 4, each startTokens = 1, each maxTokens = 1) annotation(
      Placement(visible = true, transformation( origin = {-126, -12},extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T120[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-172, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T121[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-78, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD BKT_Cooling_I[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-210, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD BKT_Heating_I[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-42, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T122[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-172, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T123[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-78, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T112[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {-78, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD BKT_Heating_II[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-42, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1133(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {68, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1135(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {94, 74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T1136(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {114, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD Generation_Hot_Off(nIn = 2, nOut = 2, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{28, 64}, {48, 84}}, rotation = 0)));
    PNlib.Components.PD Generation_Hot_II(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {104, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1139(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {68, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1141(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {68, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1143(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {68, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Generation_Hot_I(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {104, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Generation_Warm_Off(nIn = 1, nOut = 1, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation( origin = {166, 70},extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    PNlib.Components.T T1151(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {196, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Generation_Warm_On(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {226, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T1153(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {196, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Generation_Cold_Off(nIn = 3, nOut = 3, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation( origin = {44, -76},extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T2(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {74, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Generation_Cold_II(nIn = 3, nOut = 3, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {106, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T3(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {74, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T6(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {74, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Generation_Cold_I(nIn = 3, nOut = 3, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {108, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T7(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {74, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T9(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {74, -132}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Generation_Cold_III(nIn = 3, nOut = 3, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {104, -126}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    PNlib.Components.T T10(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {74, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T4(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {98, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T5(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {118, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    PNlib.Components.T T8(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {94, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T20(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {114, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    PNlib.Components.T T23(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {148, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T24(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
      Placement(visible = true, transformation(origin = {168, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput u[15] annotation(
      Placement(visible = true, transformation(origin = {-2.22045e-16, 164}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {-2.22045e-16, 164}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput y[70] annotation(
      Placement(visible = true, transformation(origin = {0, -160}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
  y[1]=RLT_Heating_Off[1].t;
  y[2]=RLT_Heating_I[1].t;
  y[3]=RLT_Heating_II[1].t;
  y[4]=RLT_Cooling_Off[1].t;
  y[5]=RLT_Cooling_I[1].t;
  y[6]=RLT_Cooling_II[1].t;
  y[7]=BKT_Heating_Off[1].t;
  y[8]=BKT_Heating_I[1].t;
  y[9]=BKT_Heating_II[1].t;
  y[10]=BKT_Cooling_I[1].t;
  y[11]=BKT_Cooling_II[1].t;
  
  y[12]=RLT_Heating_Off[2].t;
  y[13]=RLT_Heating_I[2].t;
  y[14]=RLT_Heating_II[2].t;
  y[15]=RLT_Cooling_Off[2].t;
  y[16]=RLT_Cooling_I[2].t;
  y[17]=RLT_Cooling_II[2].t;
  y[18]=BKT_Heating_Off[2].t;
  y[18]=BKT_Heating_I[2].t;
  y[20]=BKT_Heating_II[2].t;
  y[21]=BKT_Cooling_I[2].t;
  y[22]=BKT_Cooling_II[2].t;
  
  y[23]=RLT_Heating_Off[3].t;
  y[24]=RLT_Heating_I[3].t;
  y[25]=RLT_Heating_II[3].t;
  y[26]=RLT_Cooling_Off[3].t;
  y[27]=RLT_Cooling_I[3].t;
  y[28]=RLT_Cooling_II[3].t;
  y[29]=BKT_Heating_Off[3].t;
  y[30]=BKT_Heating_I[3].t;
  y[31]=BKT_Heating_II[3].t;
  y[32]=BKT_Cooling_I[3].t;
  y[33]=BKT_Cooling_II[3].t;
  
  y[34]=RLT_Heating_Off[4].t;
  y[35]=RLT_Heating_I[4].t;
  y[36]=RLT_Heating_II[4].t;
  y[37]=RLT_Cooling_Off[4].t;
  y[38]=RLT_Cooling_I[4].t;
  y[39]=RLT_Cooling_II[4].t;
  y[40]=BKT_Heating_Off[4].t;
  y[41]=BKT_Heating_I[4].t;
  y[42]=BKT_Heating_II[4].t;
  y[43]=BKT_Cooling_I[4].t;
  y[44]=BKT_Cooling_II[4].t;
  
  y[45]=RLT_Heating_Off[5].t;
  y[46]=RLT_Heating_I[5].t;
  y[47]=RLT_Heating_II[5].t;
  y[48]=RLT_Cooling_Off[5].t;
  y[49]=RLT_Cooling_I[5].t;
  y[50]=RLT_Cooling_II[5].t;
  y[51]=BKT_Heating_Off[5].t;
  y[52]=BKT_Heating_I[5].t;
  y[53]=BKT_Heating_II[5].t;
  y[54]=BKT_Cooling_I[5].t;
  y[55]=BKT_Cooling_II[5].t;
  
  y[56]=RLT_Heating_Off[6].t;
  y[57]=RLT_Heating_I[6].t;
  y[58]=RLT_Heating_II[6].t;
  y[59]=RLT_Cooling_Off[6].t;
  y[60]=RLT_Cooling_I[6].t;
  y[61]=RLT_Cooling_II[6].t;
  
  y[62]=Generation_Hot_Off.t;
  y[63]=Generation_Hot_I.t;
  y[64]=Generation_Hot_II.t;
  
  y[65]=Generation_Warm_Off.t;
  y[66]=Generation_Warm_I.t;
  y[67]=Generation_Warm_II.t;
  
  y[68]=Generation_Cold_Off.t;
  y[69]=Generation_Cold_I.t;
  y[70]=Generation_Cold_II.t;
  
    connect(T1153.outPlaces[1], Generation_Warm_Off.inTransition[1]) annotation(
      Line(points = {{191.2, 84}, {184.9, 84}, {184.9, 82}, {178.6, 82}, {178.6, 82}, {166, 82}, {166, 78.8}, {166, 78.8}, {166, 80.8}, {166, 80.8}}, thickness = 0.5));
    connect(Generation_Warm_On.outTransition[1], T1153.inPlaces[1]) annotation(
      Line(points = {{226, 80.8}, {221, 80.8}, {221, 80.8}, {216, 80.8}, {216, 84}, {200.8, 84}}, thickness = 0.5));
    connect(T1151.outPlaces[1], Generation_Warm_On.inTransition[1]) annotation(
      Line(points = {{200.8, 64}, {203.4, 64}, {203.4, 64}, {206, 64}, {206, 60}, {218, 60}, {218, 59.2}, {226, 59.2}}, thickness = 0.5));
    connect(Generation_Warm_Off.outTransition[1], T1151.inPlaces[1]) annotation(
      Line(points = {{166, 59.2}, {177, 59.2}, {177, 57.2}, {188, 57.2}, {188, 62}, {190, 62}, {190, 64}, {190.6, 64}, {190.6, 64}, {191.2, 64}}, thickness = 0.5));
    connect(Generation_Hot_I.outTransition[1], T1143.inPlaces[1]) annotation(
      Line(points = {{93.2, 96}, {89.6, 96}, {89.6, 98}, {88, 98}, {88, 103.5}, {80.4, 103.5}, {80.4, 103.5}, {72.8, 103.5}}, thickness = 0.5));
    connect(T1133.outPlaces[1], Generation_Hot_I.inTransition[1]) annotation(
      Line(points = {{72.8, 84}, {120, 84}, {120, 96}, {116, 96}, {116, 94.5}, {114.4, 94.5}, {114.4, 96.5}, {114.8, 96.5}}, thickness = 0.5));
    connect(T1136.outPlaces[1], Generation_Hot_I.inTransition[2]) annotation(
      Line(points = {{114, 78.8}, {114, 84}, {120, 84}, {120, 95.5}, {114.8, 95.5}}, thickness = 0.5));
    connect(Generation_Hot_I.outTransition[2], T1135.inPlaces[1]) annotation(
      Line(points = {{93.2, 96}, {91.4, 96}, {91.4, 92}, {89.6, 92}, {89.6, 90}, {88, 90}, {88, 78.5}, {94, 78.5}, {94, 77.9}, {94, 77.9}, {94, 79.3}}, thickness = 0.5));
    connect(T1143.outPlaces[1], Generation_Hot_Off.inTransition[1]) annotation(
      Line(points = {{63.2, 104}, {24, 104}, {24, 74}, {26, 74}, {26, 73.5}, {27.2, 73.5}}, thickness = 0.5));
    connect(T1141.outPlaces[1], Generation_Hot_Off.inTransition[2]) annotation(
      Line(points = {{63.2, 44}, {24, 44}, {24, 74}, {26, 74}, {26, 74.5}, {27.2, 74.5}}, thickness = 0.5));
    connect(Generation_Hot_II.outTransition[1], T1141.inPlaces[1]) annotation(
      Line(points = {{114.8, 52}, {115.4, 52}, {115.4, 46}, {118, 46}, {118, 32.5}, {86, 32.5}, {86, 44.5}, {79.4, 44.5}, {79.4, 40.5}, {76.1, 40.5}, {76.1, 44.5}, {72.8, 44.5}}, thickness = 0.5));
    connect(Generation_Hot_Off.outTransition[2], T1139.inPlaces[1]) annotation(
      Line(points = {{48.8, 74}, {51.4, 74}, {51.4, 72}, {54, 72}, {54, 65.5}, {58.6, 65.5}, {58.6, 59.5}, {60.9, 59.5}, {60.9, 63.5}, {63.2, 63.5}}, thickness = 0.5));
    connect(T1139.outPlaces[1], Generation_Hot_II.inTransition[1]) annotation(
      Line(points = {{72.8, 64}, {88, 64}, {88, 52}, {92, 52}, {92, 49.5}, {92.6, 49.5}, {92.6, 47.5}, {92.9, 47.5}, {92.9, 51.5}, {93.2, 51.5}}, thickness = 0.5));
    connect(Generation_Hot_II.outTransition[2], T1136.inPlaces[1]) annotation(
      Line(points = {{114.8, 52}, {115.6, 52}, {115.6, 48}, {116.4, 48}, {116.4, 52}, {118, 52}, {118, 61.5}, {114, 61.5}, {114, 67.1}, {114, 67.1}, {114, 68.7}}, thickness = 0.5));
    connect(T1135.outPlaces[1], Generation_Hot_II.inTransition[2]) annotation(
      Line(points = {{94, 69.2}, {94, 64}, {88, 64}, {88, 52}, {93.2, 52}, {93.2, 52.25}, {93.2, 52.25}, {93.2, 52.5}}, thickness = 0.5));
    connect(Generation_Hot_Off.outTransition[1], T1133.inPlaces[1]) annotation(
      Line(points = {{48.8, 74}, {51.4, 74}, {51.4, 72}, {54, 72}, {54, 84.5}, {58.6, 84.5}, {58.6, 84.5}, {63.2, 84.5}}, thickness = 0.5));
    connect(T24.outPlaces[1], Generation_Cold_III.inTransition[1]) annotation(
      Line(points = {{168, -80.8}, {168, -115.2}, {103.333, -115.2}}));
    connect(Generation_Cold_I.outTransition[3], T24.inPlaces[1]) annotation(
      Line(points = {{108, -3.2}, {110.334, -3.2}, {110.334, -3.2}, {110.667, -3.2}, {110.667, -4}, {176.667, -4}, {176.667, -71.2}, {172.667, -71.2}, {172.667, -71.2}, {168.667, -71.2}}));
    connect(T23.outPlaces[1], Generation_Cold_I.inTransition[3]) annotation(
      Line(points = {{148, -71.2}, {148, -47}, {146, -47}, {146, -24.8}, {127.666, -24.8}, {127.666, -24.8}, {107.333, -24.8}}));
    connect(Generation_Cold_III.outTransition[1], T23.inPlaces[1]) annotation(
      Line(points = {{104, -136.8}, {116.667, -136.8}, {116.667, -138}, {148.667, -138}, {148.667, -109.4}, {148.667, -109.4}, {148.667, -80.8}}));
    connect(T20.outPlaces[1], Generation_Cold_III.inTransition[2]) annotation(
      Line(points = {{114, -106.8}, {114, -104.4}, {112, -104.4}, {112, -110}, {102, -110}, {102, -111.6}, {104, -111.6}, {104, -115.2}}));
    connect(Generation_Cold_II.outTransition[3], T20.inPlaces[1]) annotation(
      Line(points = {{106, -65.2}, {108.334, -65.2}, {108.334, -65.2}, {108.667, -65.2}, {108.667, -64}, {116.667, -64}, {116.667, -97.2}, {116.667, -97.2}, {116.667, -97.2}, {114.667, -97.2}}));
    connect(T8.outPlaces[1], Generation_Cold_II.inTransition[3]) annotation(
      Line(points = {{94, -97.2}, {96, -97.2}, {96, -86.8}, {105.333, -86.8}}));
    connect(Generation_Cold_III.outTransition[2], T8.inPlaces[1]) annotation(
      Line(points = {{104, -136.8}, {102, -136.8}, {102, -136}, {92, -136}, {92, -121.4}, {94, -121.4}, {94, -106.8}}));
    connect(T5.outPlaces[1], Generation_Cold_II.inTransition[1]) annotation(
      Line(points = {{118, -50.8}, {118, -86.8}, {106.667, -86.8}}));
    connect(Generation_Cold_I.outTransition[2], T5.inPlaces[1]) annotation(
      Line(points = {{108, -3.2}, {109, -3.2}, {109, -3.2}, {108, -3.2}, {108, -4}, {126, -4}, {126, -41.2}, {118, -41.2}}));
    connect(T4.outPlaces[1], Generation_Cold_I.inTransition[2]) annotation(
      Line(points = {{98, -41.2}, {98, -24.8}, {108, -24.8}}));
    connect(Generation_Cold_II.outTransition[1], T4.inPlaces[1]) annotation(
      Line(points = {{106, -65.2}, {103.666, -65.2}, {103.666, -65.2}, {101.333, -65.2}, {101.333, -62}, {97.333, -62}, {97.333, -55.4}, {97.333, -55.4}, {97.333, -50.8}}));
    connect(T10.outPlaces[1], Generation_Cold_III.inTransition[3]) annotation(
      Line(points = {{78.8, -112}, {91.7335, -112}, {91.7335, -112}, {102.667, -112}, {102.667, -112.6}, {104.667, -112.6}, {104.667, -115.2}}));
    connect(Generation_Cold_Off.outTransition[3], T10.inPlaces[1]) annotation(
      Line(points = {{54.8, -76}, {54.4, -76}, {54.4, -76}, {54, -76}, {54, -112.667}, {61.6, -112.667}, {61.6, -112.667}, {69.2, -112.667}}));
    connect(Generation_Cold_III.outTransition[3], T9.inPlaces[1]) annotation(
      Line(points = {{104, -136.8}, {99.333, -136.8}, {99.333, -136}, {78.133, -136}, {78.133, -134}, {78.133, -134}, {78.133, -132}}));
    connect(T9.outPlaces[1], Generation_Cold_Off.inTransition[3]) annotation(
      Line(points = {{69.2, -132}, {47.6, -132}, {47.6, -132}, {24, -132}, {24, -75.333}, {29.6, -75.333}, {29.6, -75.333}, {33.2, -75.333}}));
    connect(T7.outPlaces[1], Generation_Cold_Off.inTransition[1]) annotation(
      Line(points = {{69.2, -4}, {47.6, -4}, {47.6, -4}, {26, -4}, {26, -76.667}, {33.2, -76.667}}));
    connect(Generation_Cold_I.outTransition[1], T7.inPlaces[1]) annotation(
      Line(points = {{108, -3.2}, {107.333, -3.2}, {107.333, -2}, {78.133, -2}, {78.133, -3}, {78.133, -3}, {78.133, -4}}));
    connect(T6.outPlaces[1], Generation_Cold_I.inTransition[1]) annotation(
      Line(points = {{78.8, -24}, {93.7335, -24}, {93.7335, -24}, {106.667, -24}, {106.667, -23.4}, {108.667, -23.4}, {108.667, -24.8}}));
    connect(Generation_Cold_Off.outTransition[1], T6.inPlaces[1]) annotation(
      Line(points = {{54.8, -76}, {54.4, -76}, {54.4, -78}, {54, -78}, {54, -25.333}, {61.6, -25.333}, {61.6, -23.333}, {69.2, -23.333}}));
    connect(T3.outPlaces[1], Generation_Cold_Off.inTransition[2]) annotation(
      Line(points = {{69.2, -62}, {47.6, -62}, {47.6, -62}, {24, -62}, {24, -76}, {29.6, -76}, {29.6, -76}, {33.2, -76}}));
    connect(Generation_Cold_II.outTransition[2], T3.inPlaces[1]) annotation(
      Line(points = {{106, -65.2}, {104, -65.2}, {104, -62}, {91.4, -62}, {91.4, -62}, {78.8, -62}}));
    connect(T2.outPlaces[1], Generation_Cold_II.inTransition[2]) annotation(
      Line(points = {{78.8, -82}, {80.4, -82}, {80.4, -82}, {80, -82}, {80, -84}, {106, -84}, {106, -86.8}}));
    connect(Generation_Cold_Off.outTransition[2], T2.inPlaces[1]) annotation(
      Line(points = {{54.8, -76}, {58, -76}, {58, -80}, {69.2, -80}, {69.2, -82}}));
    connect(BKT_Heating_II[5].outTransition[1], T112[5].inPlaces[1]) annotation(
      Line(points = {{-31.2, -34}, {-29.9, -34}, {-29.9, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-69.4, -41.5}, {-69.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
    connect(T118[5].outPlaces[1], BKT_Heating_II[5].inTransition[2]) annotation(
      Line(points = {{-52, -16.8}, {-52, -19.4}, {-52, -19.4}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
    connect(T115[5].outPlaces[1], BKT_Heating_II[5].inTransition[1]) annotation(
      Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-50.4, -34.5}, {-50.4, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
    connect(BKT_Heating_II[5].outTransition[2], T119[5].inPlaces[1]) annotation(
      Line(points = {{-31.2, -34}, {-31.05, -34}, {-31.05, -34}, {-30.9, -34}, {-30.9, -34}, {-30.6, -34}, {-30.6, -34}, {-30, -34}, {-30, -25.75}, {-30, -25.75}, {-30, -22.625}, {-30, -22.625}, {-30, -19.5}}, thickness = 0.5));
    connect(BKT_Heating_II[4].outTransition[1], T112[4].inPlaces[1]) annotation(
      Line(points = {{-31.2, -34}, {-29.4, -34}, {-29.4, -34}, {-29.6, -34}, {-29.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-71.4, -41.5}, {-71.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
    connect(T118[4].outPlaces[1], BKT_Heating_II[4].inTransition[2]) annotation(
      Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.5}}, thickness = 0.5));
    connect(T115[4].outPlaces[1], BKT_Heating_II[4].inTransition[1]) annotation(
      Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
    connect(BKT_Heating_II[3].outTransition[1], T112[3].inPlaces[1]) annotation(
      Line(points = {{-31.2, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-71.4, -41.5}, {-71.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
    connect(T118[3].outPlaces[1], BKT_Heating_II[3].inTransition[2]) annotation(
      Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
    connect(T115[3].outPlaces[1], BKT_Heating_II[3].inTransition[1]) annotation(
      Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
    connect(BKT_Heating_II[2].outTransition[1], T112[2].inPlaces[1]) annotation(
      Line(points = {{-31.2, -34}, {-27.9, -34}, {-27.9, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
    connect(T118[2].outPlaces[1], BKT_Heating_II[2].inTransition[2]) annotation(
      Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
    connect(T115[2].outPlaces[1], BKT_Heating_II[2].inTransition[1]) annotation(
      Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-53.4, -34.5}, {-53.4, -34.5}, {-53.1, -34.5}, {-53.1, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
    connect(BKT_Heating_II[1].outTransition[1], T112[1].inPlaces[1]) annotation(
      Line(points = {{-31.2, -34}, {-27.4, -34}, {-27.4, -34}, {-29.6, -34}, {-29.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
    connect(T118[1].outPlaces[1], BKT_Heating_II[1].inTransition[2]) annotation(
      Line(points = {{-52, -16.8}, {-52, -19.4}, {-52, -19.4}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
    connect(T115[1].outPlaces[1], BKT_Heating_II[1].inTransition[1]) annotation(
      Line(points = {{-73.2, -22}, {-61.6, -22}, {-61.6, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-53.4, -34.5}, {-53.4, -34.5}, {-53.1, -34.5}, {-53.1, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
    connect(T112[5].outPlaces[1], BKT_Off[5].inTransition[2]) annotation(
      Line(points = {{-82.8, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
    connect(T112[4].outPlaces[1], BKT_Off[4].inTransition[2]) annotation(
      Line(points = {{-82.8, -42}, {-114.4, -42}, {-114.4, -42}, {-144, -42}, {-144, -22.8}, {-134.875, -22.8}, {-134.875, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
    connect(T112[3].outPlaces[1], BKT_Off[3].inTransition[2]) annotation(
      Line(points = {{-82.8, -42}, {-113.4, -42}, {-113.4, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
    connect(T112[2].outPlaces[1], BKT_Off[2].inTransition[2]) annotation(
      Line(points = {{-82.8, -42}, {-113.4, -42}, {-113.4, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
    connect(T112[1].outPlaces[1], BKT_Off[1].inTransition[2]) annotation(
      Line(points = {{-82.8, -42}, {-144, -42}, {-144, -22.8}, {-134.875, -22.8}, {-134.875, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
    connect(BKT_Heating_I[5].outTransition[1], T123[5].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-54.1, 10}, {-54.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
    connect(T123[5].outPlaces[1], BKT_Off[5].inTransition[1]) annotation(
      Line(points = {{-82.8, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
    connect(BKT_Heating_I[4].outTransition[1], T123[4].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-69.4, 17.5}, {-69.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
    connect(T123[4].outPlaces[1], BKT_Off[4].inTransition[1]) annotation(
      Line(points = {{-82.8, 18}, {-90.45, 18}, {-90.45, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
    connect(BKT_Heating_I[3].outTransition[1], T123[3].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-70.4, 17.5}, {-70.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
    connect(T123[3].outPlaces[1], BKT_Off[3].inTransition[1]) annotation(
      Line(points = {{-82.8, 18}, {-97.1, 18}, {-97.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-129.938, -22.8}, {-129.938, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
    connect(BKT_Heating_I[2].outTransition[1], T123[2].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-66.6, 17.5}, {-66.6, 17.5}, {-70.9, 17.5}, {-70.9, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
    connect(T123[2].outPlaces[1], BKT_Off[2].inTransition[1]) annotation(
      Line(points = {{-82.8, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-129.938, -22.8}, {-129.938, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
    connect(BKT_Heating_I[1].outTransition[1], T123[1].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-70.4, 17.5}, {-70.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
    connect(T123[1].outPlaces[1], BKT_Off[1].inTransition[1]) annotation(
      Line(points = {{-82.8, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
    connect(T122[5].outPlaces[1], BKT_Off[5].inTransition[4]) annotation(
      Line(points = {{-167.2, 18}, {-144, 18}, {-144, -22.8}, {-126.75, -22.8}}));
    connect(BKT_Cooling_I[5].outTransition[1], T122[5].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-198.05, 10}, {-198.05, 10}, {-196.9, 10}, {-196.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
    connect(T122[4].outPlaces[1], BKT_Off[4].inTransition[4]) annotation(
      Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-135.375, -22.8}, {-135.375, -22.8}, {-131.062, -22.8}, {-131.062, -22.8}, {-126.75, -22.8}}));
    connect(BKT_Cooling_I[4].outTransition[1], T122[4].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-197.9, 10}, {-197.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-178.95, 18.5}, {-178.95, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
    connect(T122[3].outPlaces[1], BKT_Off[3].inTransition[4]) annotation(
      Line(points = {{-167.2, 18}, {-160.9, 18}, {-160.9, 18}, {-154.6, 18}, {-154.6, 18}, {-144, 18}, {-144, -22.8}, {-132.375, -22.8}, {-132.375, -22.8}, {-126.75, -22.8}}));
    connect(BKT_Cooling_I[3].outTransition[1], T122[3].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-198.9, 10}, {-198.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
    connect(T122[2].outPlaces[1], BKT_Off[2].inTransition[4]) annotation(
      Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-135.375, -22.8}, {-135.375, -22.8}, {-130.062, -22.8}, {-130.062, -22.8}, {-128.406, -22.8}, {-128.406, -22.8}, {-126.75, -22.8}}));
    connect(BKT_Cooling_I[2].outTransition[1], T122[2].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-194.9, 10}, {-194.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
    connect(T122[1].outPlaces[1], BKT_Off[1].inTransition[4]) annotation(
      Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-126.75, -22.8}}));
    connect(BKT_Cooling_I[1].outTransition[1], T122[1].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-198.05, 10}, {-198.05, 10}, {-196.9, 10}, {-196.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-178.1, 18.5}, {-178.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
    connect(T121[5].outPlaces[1], BKT_Heating_I[5].inTransition[1]) annotation(
      Line(points = {{-73.2, -2}, {-50.6, -2}, {-50.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 11.25}, {-31.2, 11.25}, {-31.2, 10.875}, {-31.2, 10.875}, {-31.2, 10.5}}, thickness = 0.5));
    connect(BKT_Heating_I[5].outTransition[2], T118[5].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
    connect(T119[5].outPlaces[1], BKT_Heating_I[5].inTransition[2]) annotation(
      Line(points = {{-30, -9.2}, {-30, 0.0499998}, {-30, 0.0499998}, {-30, 9.3}, {-30.6, 9.3}, {-30.6, 9.3}, {-30.9, 9.3}, {-30.9, 9.3}, {-31.2, 9.3}}, thickness = 0.5));
    connect(T121[4].outPlaces[1], BKT_Heating_I[4].inTransition[1]) annotation(
      Line(points = {{-73.2, -2}, {-47.6, -2}, {-47.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.25}, {-31.2, 10.25}, {-31.2, 10.5}}, thickness = 0.5));
    connect(BKT_Heating_I[4].outTransition[2], T118[4].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-54.1, 10}, {-54.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
    connect(T121[3].outPlaces[1], BKT_Heating_I[3].inTransition[1]) annotation(
      Line(points = {{-73.2, -2}, {-49.6, -2}, {-49.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 11.25}, {-31.2, 11.25}, {-31.2, 10.5}}, thickness = 0.5));
    connect(BKT_Heating_I[3].outTransition[2], T118[3].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -4.1}, {-52, -4.1}, {-52, -6.7}}, thickness = 0.5));
    connect(T121[2].outPlaces[1], BKT_Heating_I[2].inTransition[1]) annotation(
      Line(points = {{-73.2, -2}, {-58.9, -2}, {-58.9, -2}, {-50.6, -2}, {-50.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.5}}, thickness = 0.5));
    connect(BKT_Heating_I[2].outTransition[2], T118[2].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -4.1}, {-52, -4.1}, {-52, -6.7}}, thickness = 0.5));
    connect(T121[1].outPlaces[1], BKT_Heating_I[1].inTransition[1]) annotation(
      Line(points = {{-73.2, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.25}, {-31.2, 10.25}, {-31.2, 10.5}}, thickness = 0.5));
    connect(BKT_Heating_I[1].outTransition[2], T118[1].inPlaces[1]) annotation(
      Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
    connect(T120[5].outPlaces[1], BKT_Cooling_I[5].inTransition[1]) annotation(
      Line(points = {{-176.8, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.75}, {-220.8, 9.75}, {-220.8, 9.625}, {-220.8, 9.625}, {-220.8, 9.5}}, thickness = 0.5));
    connect(T117[5].outPlaces[1], BKT_Cooling_I[5].inTransition[2]) annotation(
      Line(points = {{-220, -7.2}, {-220, -4.6}, {-220, -4.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
    connect(BKT_Cooling_I[5].outTransition[2], T116[5].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-197.9, 10}, {-197.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -5.1}, {-200, -5.1}, {-200, -6.4}, {-200, -6.4}, {-200, -7.7}}, thickness = 0.5));
    connect(T120[4].outPlaces[1], BKT_Cooling_I[4].inTransition[1]) annotation(
      Line(points = {{-176.8, -2}, {-203.4, -2}, {-203.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.75}, {-220.8, 9.75}, {-220.8, 10.625}, {-220.8, 10.625}, {-220.8, 9.5}}, thickness = 0.5));
    connect(T117[4].outPlaces[1], BKT_Cooling_I[4].inTransition[2]) annotation(
      Line(points = {{-220, -7.2}, {-220, -5.4}, {-220, -5.4}, {-220, -3.6}, {-220, -3.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 11.25}, {-220.8, 11.25}, {-220.8, 10.5}}, thickness = 0.5));
    connect(BKT_Cooling_I[4].outTransition[2], T116[4].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-198.4, 10}, {-198.4, 10}, {-197.6, 10}, {-197.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, 5.9}, {-200, 5.9}, {-200, -0.900002}, {-200, -0.900002}, {-200, -7.7}}, thickness = 0.5));
    connect(T120[3].outPlaces[1], BKT_Cooling_I[3].inTransition[1]) annotation(
      Line(points = {{-176.8, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.5}}, thickness = 0.5));
    connect(T117[3].outPlaces[1], BKT_Cooling_I[3].inTransition[2]) annotation(
      Line(points = {{-220, -7.2}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
    connect(BKT_Cooling_I[3].outTransition[2], T116[3].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-198.4, 10}, {-198.4, 10}, {-197.6, 10}, {-197.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -4.1}, {-200, -4.1}, {-200, -5.9}, {-200, -5.9}, {-200, -7.7}}, thickness = 0.5));
    connect(T120[2].outPlaces[1], BKT_Cooling_I[2].inTransition[1]) annotation(
      Line(points = {{-176.8, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.5}}, thickness = 0.5));
    connect(T117[2].outPlaces[1], BKT_Cooling_I[2].inTransition[2]) annotation(
      Line(points = {{-220, -7.2}, {-220, -3.6}, {-220, -3.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
    connect(BKT_Cooling_I[2].outTransition[2], T116[2].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-198.9, 10}, {-198.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -5.1}, {-200, -5.1}, {-200, -6.4}, {-200, -6.4}, {-200, -7.05}, {-200, -7.05}, {-200, -7.7}}, thickness = 0.5));
    connect(T120[1].outPlaces[1], BKT_Cooling_I[1].inTransition[1]) annotation(
      Line(points = {{-176.8, -2}, {-189.6, -2}, {-189.6, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.75}, {-220.8, 10.75}, {-220.8, 10.125}, {-220.8, 10.125}, {-220.8, 9.5}}, thickness = 0.5));
    connect(T117[1].outPlaces[1], BKT_Cooling_I[1].inTransition[2]) annotation(
      Line(points = {{-220, -7.2}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 11.25}, {-220.8, 11.25}, {-220.8, 10.5}}, thickness = 0.5));
    connect(BKT_Cooling_I[1].outTransition[2], T116[1].inPlaces[1]) annotation(
      Line(points = {{-199.2, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -4.1}, {-200, -4.1}, {-200, -7.7}}, thickness = 0.5));
    connect(BKT_Off[5].outTransition[1], T121[5].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-87.15, -2}, {-87.15, -2}, {-85.35, -2}, {-85.35, -2}, {-83.55, -2}}, thickness = 0.5));
    connect(BKT_Off[4].outTransition[1], T121[4].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-85.85, -2}, {-85.85, -2}, {-83.55, -2}}, thickness = 0.5));
    connect(BKT_Off[3].outTransition[1], T121[3].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-109.375, -1.2}, {-109.375, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-82.85, -2}, {-82.85, -2}, {-83.55, -2}}, thickness = 0.5));
    connect(BKT_Off[2].outTransition[1], T121[2].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-84.85, -2}, {-84.85, -2}, {-83.55, -2}}, thickness = 0.5));
    connect(BKT_Off[1].outTransition[1], T121[1].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-83.55, -2}}, thickness = 0.5));
    connect(BKT_Off[5].outTransition[3], T120[5].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
    connect(BKT_Off[4].outTransition[3], T120[4].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-126.875, -1.2}, {-126.875, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -1.5}, {-166.95, -1.5}, {-166.95, -2}}));
    connect(BKT_Off[3].outTransition[3], T120[3].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
    connect(BKT_Off[2].outTransition[3], T120[2].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
    connect(BKT_Off[1].outTransition[3], T120[1].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-125.938, -1.2}, {-125.938, -1.2}, {-125.875, -1.2}, {-125.875, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
    connect(T113[5].outPlaces[1], BKT_Off[5].inTransition[3]) annotation(
      Line(points = {{-167.2, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
    connect(BKT_Off[5].outTransition[4], T114[5].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-166.45, -22}}));
    connect(BKT_Off[5].outTransition[2], T115[5].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-109.125, -1.2}, {-109.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-85.35, -22}, {-85.35, -22}, {-85.2, -22}, {-85.2, -22}, {-83.05, -22}}, thickness = 0.5));
    connect(T113[4].outPlaces[1], BKT_Off[4].inTransition[3]) annotation(
      Line(points = {{-167.2, -42}, {-161.4, -42}, {-161.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-134.125, -22.8}, {-134.125, -22.8}, {-126.25, -22.8}}));
    connect(BKT_Off[4].outTransition[4], T114[4].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-129.812, -1.2}, {-129.812, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-166.45, -22}}));
    connect(BKT_Off[4].outTransition[2], T115[4].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-85.35, -22}, {-85.35, -22}, {-83.05, -22}}, thickness = 0.5));
    connect(T113[3].outPlaces[1], BKT_Off[3].inTransition[3]) annotation(
      Line(points = {{-167.2, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
    connect(BKT_Off[3].outTransition[4], T114[3].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-164.15, -22}, {-164.15, -22}, {-166.45, -22}}));
    connect(BKT_Off[3].outTransition[2], T115[3].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-110.125, -1.2}, {-110.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-83.05, -22}}, thickness = 0.5));
    connect(T113[2].outPlaces[1], BKT_Off[2].inTransition[3]) annotation(
      Line(points = {{-167.2, -42}, {-162.8, -42}, {-162.8, -42}, {-158.4, -42}, {-158.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-127.687, -22.8}, {-127.687, -22.8}, {-126.25, -22.8}}));
    connect(BKT_Off[2].outTransition[4], T114[2].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-129.812, -1.2}, {-129.812, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-166.45, -22}}));
    connect(BKT_Off[2].outTransition[2], T115[2].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-109.125, -1.2}, {-109.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-84.35, -22}, {-84.35, -22}, {-83.05, -22}}, thickness = 0.5));
    connect(T113[1].outPlaces[1], BKT_Off[1].inTransition[3]) annotation(
      Line(points = {{-167.2, -42}, {-161.4, -42}, {-161.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
    connect(BKT_Off[1].outTransition[4], T114[1].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-166.45, -22}}));
    connect(BKT_Off[1].outTransition[2], T115[1].inPlaces[1]) annotation(
      Line(points = {{-126, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-83.05, -22}}, thickness = 0.5));
    connect(BKT_Cooling_II[5].outTransition[2], T117[5].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -16.3}}, thickness = 0.5));
    connect(BKT_Cooling_II[4].outTransition[2], T117[4].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -16.3}}, thickness = 0.5));
    connect(BKT_Cooling_II[3].outTransition[2], T117[3].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -17.1}, {-220, -17.1}, {-220, -16.3}}, thickness = 0.5));
    connect(BKT_Cooling_II[2].outTransition[2], T117[2].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -16.3}}, thickness = 0.5));
    connect(BKT_Cooling_II[1].outTransition[2], T117[1].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -16.3}}, thickness = 0.5));
    connect(T116[5].outPlaces[1], BKT_Cooling_II[5].inTransition[2]) annotation(
      Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
    connect(T116[4].outPlaces[1], BKT_Cooling_II[4].inTransition[2]) annotation(
      Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
    connect(T116[3].outPlaces[1], BKT_Cooling_II[3].inTransition[2]) annotation(
      Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
    connect(T116[2].outPlaces[1], BKT_Cooling_II[2].inTransition[2]) annotation(
      Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.25}, {-199.2, -34.25}, {-199.2, -34.5}}, thickness = 0.5));
    connect(T116[1].outPlaces[1], BKT_Cooling_II[1].inTransition[2]) annotation(
      Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
    connect(T114[5].outPlaces[1], BKT_Cooling_II[5].inTransition[1]) annotation(
      Line(points = {{-176.8, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
    connect(BKT_Cooling_II[5].outTransition[1], T113[5].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
    connect(T114[4].outPlaces[1], BKT_Cooling_II[4].inTransition[1]) annotation(
      Line(points = {{-176.8, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-199.9, -33.5}, {-199.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
    connect(BKT_Cooling_II[4].outTransition[1], T113[4].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-221.6, -34}, {-221.6, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
    connect(T114[3].outPlaces[1], BKT_Cooling_II[3].inTransition[1]) annotation(
      Line(points = {{-176.8, -22}, {-181.1, -22}, {-181.1, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
    connect(BKT_Cooling_II[3].outTransition[1], T113[3].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-221.6, -34}, {-221.6, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
    connect(T114[2].outPlaces[1], BKT_Cooling_II[2].inTransition[1]) annotation(
      Line(points = {{-176.8, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-199.9, -33.5}, {-199.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
    connect(BKT_Cooling_II[2].outTransition[1], T113[2].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-223.4, -34}, {-223.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-180.6, -42.5}, {-180.6, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
    connect(T114[1].outPlaces[1], BKT_Cooling_II[1].inTransition[1]) annotation(
      Line(points = {{-176.8, -22}, {-177.45, -22}, {-177.45, -22}, {-178.1, -22}, {-178.1, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.05, -33.5}, {-199.05, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
    connect(BKT_Cooling_II[1].outTransition[1], T113[1].inPlaces[1]) annotation(
      Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-179.6, -42.5}, {-179.6, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
    connect(T111[6].outPlaces[1], RLT_Cooling_II[6].inTransition[2]) annotation(
      Line(points = {{-202, 83.2}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[6].outTransition[2], T111[6].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-200.9, 112}, {-200.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 97.1}, {-202, 97.1}, {-202, 92.3}}, thickness = 0.5));
    connect(T111[5].outPlaces[1], RLT_Cooling_II[5].inTransition[2]) annotation(
      Line(points = {{-202, 83.2}, {-202, 81.9}, {-202, 81.9}, {-202, 80.6}, {-202, 80.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[5].outTransition[2], T111[5].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-199.9, 112}, {-199.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 98.1}, {-202, 98.1}, {-202, 92.3}}, thickness = 0.5));
    connect(T111[4].outPlaces[1], RLT_Cooling_II[4].inTransition[2]) annotation(
      Line(points = {{-202, 83.2}, {-202, 83.4}, {-202, 83.4}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-202.4, 65.5}, {-202.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[4].outTransition[2], T111[4].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-200.9, 112}, {-200.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 94.9}, {-202, 94.9}, {-202, 93.6}, {-202, 93.6}, {-202, 92.3}}, thickness = 0.5));
    connect(T111[3].outPlaces[1], RLT_Cooling_II[3].inTransition[2]) annotation(
      Line(points = {{-202, 83.2}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.4, 65.5}, {-201.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[3].outTransition[2], T111[3].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 97.1}, {-202, 97.1}, {-202, 92.3}}, thickness = 0.5));
    connect(T111[2].outPlaces[1], RLT_Cooling_II[2].inTransition[2]) annotation(
      Line(points = {{-202, 83.2}, {-202, 83.4}, {-202, 83.4}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[2].outTransition[2], T111[2].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-199.4, 112}, {-199.4, 112}, {-197.6, 112}, {-197.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 95.9}, {-202, 95.9}, {-202, 95.1}, {-202, 95.1}, {-202, 92.3}}, thickness = 0.5));
    connect(T111[1].outPlaces[1], RLT_Cooling_II[1].inTransition[2]) annotation(
      Line(points = {{-202, 83.2}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.4, 65.5}, {-201.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[1].outTransition[2], T111[1].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-197.6, 112}, {-197.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 95.9}, {-202, 95.9}, {-202, 92.3}}, thickness = 0.5));
    connect(RLT_Cooling_II[6].outTransition[2], T110[6].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 81.9}, {-222, 81.9}, {-222, 83.7}}, thickness = 0.5));
    connect(T110[6].outPlaces[1], RLT_Cooling_I[6].inTransition[2]) annotation(
      Line(points = {{-222, 92.8}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[5].outTransition[2], T110[5].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 83.7}}, thickness = 0.5));
    connect(T110[5].outPlaces[1], RLT_Cooling_I[5].inTransition[2]) annotation(
      Line(points = {{-222, 92.8}, {-222, 95.4}, {-222, 95.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[4].outTransition[2], T110[4].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.9}, {-222, 83.9}, {-222, 83.7}}, thickness = 0.5));
    connect(T110[4].outPlaces[1], RLT_Cooling_I[4].inTransition[2]) annotation(
      Line(points = {{-222, 92.8}, {-222, 96.4}, {-222, 96.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-223.6, 112.5}, {-223.6, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[3].outTransition[2], T110[3].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.7}}, thickness = 0.5));
    connect(T110[3].outPlaces[1], RLT_Cooling_I[3].inTransition[2]) annotation(
      Line(points = {{-222, 92.8}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[2].outTransition[2], T110[2].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.9}, {-222, 83.9}, {-222, 83.7}}, thickness = 0.5));
    connect(T110[2].outPlaces[1], RLT_Cooling_I[2].inTransition[2]) annotation(
      Line(points = {{-222, 92.8}, {-222, 95.4}, {-222, 95.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[1].outTransition[2], T110[1].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 81.9}, {-222, 81.9}, {-222, 83.7}}, thickness = 0.5));
    connect(T110[1].outPlaces[1], RLT_Cooling_I[1].inTransition[2]) annotation(
      Line(points = {{-222, 92.8}, {-222, 96.4}, {-222, 96.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-223.6, 112.5}, {-223.6, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[6].outTransition[1], T19[6].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-182.4, 57.5}, {-182.4, 57.5}, {-181.6, 57.5}, {-181.6, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
    connect(T19[6].outPlaces[1], RLT_Cooling_Off[6].inTransition[2]) annotation(
      Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[5].outTransition[1], T19[5].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
    connect(T19[5].outPlaces[1], RLT_Cooling_Off[5].inTransition[2]) annotation(
      Line(points = {{-169.2, 58}, {-159.4, 58}, {-159.4, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[4].outTransition[1], T19[4].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-224.4, 66}, {-224.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-182.4, 57.5}, {-182.4, 57.5}, {-180.6, 57.5}, {-180.6, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
    connect(T19[4].outPlaces[1], RLT_Cooling_Off[4].inTransition[2]) annotation(
      Line(points = {{-169.2, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[3].outTransition[1], T19[3].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-181.1, 57.5}, {-181.1, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
    connect(T19[3].outPlaces[1], RLT_Cooling_Off[3].inTransition[2]) annotation(
      Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[2].outTransition[1], T19[2].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
    connect(T19[2].outPlaces[1], RLT_Cooling_Off[2].inTransition[2]) annotation(
      Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
    connect(RLT_Cooling_II[1].outTransition[1], T19[1].inPlaces[1]) annotation(
      Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
    connect(T19[1].outPlaces[1], RLT_Cooling_Off[1].inTransition[2]) annotation(
      Line(points = {{-169.2, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
    connect(T18[6].outPlaces[1], RLT_Cooling_II[6].inTransition[1]) annotation(
      Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[6].outTransition[2], T18[6].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-167.9, 78.5}, {-167.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
    connect(T18[5].outPlaces[1], RLT_Cooling_II[5].inTransition[1]) annotation(
      Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[5].outTransition[2], T18[5].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-167.9, 78.5}, {-167.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
    connect(T18[4].outPlaces[1], RLT_Cooling_II[4].inTransition[1]) annotation(
      Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.9, 66.5}, {-201.9, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[4].outTransition[2], T18[4].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-158.6, 88}, {-158.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
    connect(T18[3].outPlaces[1], RLT_Cooling_II[3].inTransition[1]) annotation(
      Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[3].outTransition[2], T18[3].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-158.6, 88}, {-158.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-166.9, 78.5}, {-166.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
    connect(T18[2].outPlaces[1], RLT_Cooling_II[2].inTransition[1]) annotation(
      Line(points = {{-178.8, 78}, {-184.1, 78}, {-184.1, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[2].outTransition[2], T18[2].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
    connect(T18[1].outPlaces[1], RLT_Cooling_II[1].inTransition[1]) annotation(
      Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[1].outTransition[2], T18[1].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[6].outTransition[1], T17[6].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-157.6, 88}, {-157.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-163.6, 97.5}, {-163.6, 97.5}, {-167.4, 97.5}, {-167.4, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
    connect(T17[6].outPlaces[1], RLT_Cooling_I[6].inTransition[1]) annotation(
      Line(points = {{-178.8, 98}, {-190.6, 98}, {-190.6, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[5].outTransition[1], T17[5].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-167.9, 97.5}, {-167.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
    connect(T17[5].outPlaces[1], RLT_Cooling_I[5].inTransition[1]) annotation(
      Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[4].outTransition[1], T17[4].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-157.6, 88}, {-157.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
    connect(T17[4].outPlaces[1], RLT_Cooling_I[4].inTransition[1]) annotation(
      Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[3].outTransition[1], T17[3].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
    connect(T17[3].outPlaces[1], RLT_Cooling_I[3].inTransition[1]) annotation(
      Line(points = {{-178.8, 98}, {-190.6, 98}, {-190.6, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[2].outTransition[1], T17[2].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
    connect(T17[2].outPlaces[1], RLT_Cooling_I[2].inTransition[1]) annotation(
      Line(points = {{-178.8, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
    connect(RLT_Cooling_Off[1].outTransition[1], T17[1].inPlaces[1]) annotation(
      Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
    connect(T17[1].outPlaces[1], RLT_Cooling_I[1].inTransition[1]) annotation(
      Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-223.6, 111.5}, {-223.6, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
    connect(T16[6].outPlaces[1], RLT_Cooling_Off[6].inTransition[1]) annotation(
      Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
    connect(T16[5].outPlaces[1], RLT_Cooling_Off[5].inTransition[1]) annotation(
      Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
    connect(T16[4].outPlaces[1], RLT_Cooling_Off[4].inTransition[1]) annotation(
      Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
    connect(T16[3].outPlaces[1], RLT_Cooling_Off[3].inTransition[1]) annotation(
      Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
    connect(T16[2].outPlaces[1], RLT_Cooling_Off[2].inTransition[1]) annotation(
      Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-133.9, 88.5}, {-133.9, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
    connect(T16[1].outPlaces[1], RLT_Cooling_Off[1].inTransition[1]) annotation(
      Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
    connect(RLT_Heating_I[6].outTransition[2], T14[6].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
    connect(T14[6].outPlaces[1], RLT_Heating_II[6].inTransition[2]) annotation(
      Line(points = {{-54, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
    connect(RLT_Heating_I[5].outTransition[2], T14[5].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
    connect(T14[5].outPlaces[1], RLT_Heating_II[5].inTransition[2]) annotation(
      Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
    connect(RLT_Heating_I[4].outTransition[2], T14[4].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
    connect(T14[4].outPlaces[1], RLT_Heating_II[4].inTransition[2]) annotation(
      Line(points = {{-54, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-55.1, 66.5}, {-55.1, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
    connect(RLT_Heating_I[3].outTransition[2], T14[3].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
    connect(T14[3].outPlaces[1], RLT_Heating_II[3].inTransition[2]) annotation(
      Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
    connect(RLT_Heating_I[2].outTransition[2], T14[2].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
    connect(T14[2].outPlaces[1], RLT_Heating_II[2].inTransition[2]) annotation(
      Line(points = {{-54, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
    connect(RLT_Heating_I[1].outTransition[2], T14[1].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
    connect(T14[1].outPlaces[1], RLT_Heating_II[1].inTransition[2]) annotation(
      Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
    connect(RLT_Heating_II[6].outTransition[2], T15[6].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
    connect(T15[6].outPlaces[1], RLT_Heating_I[6].inTransition[2]) annotation(
      Line(points = {{-34, 92.8}, {-34, 95.3}, {-34, 95.3}, {-34, 97.8}, {-33.2, 97.8}, {-33.2, 104.55}, {-33.2, 104.55}, {-33.2, 109.3}}, thickness = 0.5));
    connect(RLT_Heating_II[5].outTransition[2], T15[5].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
    connect(T15[5].outPlaces[1], RLT_Heating_I[5].inTransition[2]) annotation(
      Line(points = {{-34, 92.8}, {-34, 97.3}, {-34, 97.3}, {-34, 101.8}, {-33.2, 101.8}, {-33.2, 109.3}}, thickness = 0.5));
    connect(RLT_Heating_II[4].outTransition[2], T15[4].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
    connect(T15[4].outPlaces[1], RLT_Heating_I[4].inTransition[2]) annotation(
      Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
    connect(RLT_Heating_II[3].outTransition[2], T15[3].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
    connect(T15[3].outPlaces[1], RLT_Heating_I[3].inTransition[2]) annotation(
      Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
    connect(RLT_Heating_II[2].outTransition[2], T15[2].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
    connect(T15[2].outPlaces[1], RLT_Heating_I[2].inTransition[2]) annotation(
      Line(points = {{-34, 92.8}, {-34, 101.05}, {-34, 101.05}, {-34, 109.3}, {-33.6, 109.3}, {-33.6, 109.3}, {-33.2, 109.3}}, thickness = 0.5));
    connect(RLT_Heating_II[1].outTransition[2], T15[1].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
    connect(T15[1].outPlaces[1], RLT_Heating_I[1].inTransition[2]) annotation(
      Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
    connect(RLT_Heating_II[6].outTransition[1], T13[6].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.4, 66}, {-33.4, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
    connect(T13[6].outPlaces[1], RLT_Heating_Off[6].inTransition[2]) annotation(
      Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
    connect(RLT_Heating_II[5].outTransition[1], T13[5].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
    connect(T13[5].outPlaces[1], RLT_Heating_Off[5].inTransition[2]) annotation(
      Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
    connect(RLT_Heating_II[4].outTransition[1], T13[4].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
    connect(T13[4].outPlaces[1], RLT_Heating_Off[4].inTransition[2]) annotation(
      Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
    connect(RLT_Heating_II[3].outTransition[1], T13[3].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
    connect(T13[3].outPlaces[1], RLT_Heating_Off[3].inTransition[2]) annotation(
      Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-122.4, 88.5}, {-122.4, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
    connect(RLT_Heating_II[2].outTransition[1], T13[2].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-74.4, 58.5}, {-74.4, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
    connect(T13[2].outPlaces[1], RLT_Heating_Off[2].inTransition[2]) annotation(
      Line(points = {{-84.8, 58}, {-104.4, 58}, {-104.4, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
    connect(RLT_Heating_II[1].outTransition[1], T13[1].inPlaces[1]) annotation(
      Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-74.4, 58.5}, {-74.4, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
    connect(T13[1].outPlaces[1], RLT_Heating_Off[1].inTransition[2]) annotation(
      Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
    connect(T12[6].outPlaces[1], RLT_Heating_II[6].inTransition[1]) annotation(
      Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 66.75}, {-54.8, 66.75}, {-54.8, 65.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[6].outTransition[2], T12[6].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
    connect(T12[5].outPlaces[1], RLT_Heating_II[5].inTransition[1]) annotation(
      Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 65.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[5].outTransition[2], T12[5].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
    connect(T12[4].outPlaces[1], RLT_Heating_II[4].inTransition[1]) annotation(
      Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 65.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[4].outTransition[2], T12[4].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-98.4, 88}, {-98.4, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
    connect(T12[3].outPlaces[1], RLT_Heating_II[3].inTransition[1]) annotation(
      Line(points = {{-75.2, 78}, {-66.6, 78}, {-66.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 65.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[3].outTransition[2], T12[3].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
    connect(T12[2].outPlaces[1], RLT_Heating_II[2].inTransition[1]) annotation(
      Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 66.625}, {-54.8, 66.625}, {-54.8, 65.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[2].outTransition[2], T12[2].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
    connect(T12[1].outPlaces[1], RLT_Heating_II[1].inTransition[1]) annotation(
      Line(points = {{-75.2, 78}, {-70.4, 78}, {-70.4, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 67.625}, {-54.8, 67.625}, {-54.8, 65.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[1].outTransition[2], T12[1].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[6].outTransition[1], T1[6].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
    connect(T1[6].outPlaces[1], RLT_Heating_I[6].inTransition[1]) annotation(
      Line(points = {{-75.2, 98}, {-52.6, 98}, {-52.6, 98}, {-30, 98}, {-30, 110.5}, {-32.6, 110.5}, {-32.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[5].outTransition[1], T1[5].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
    connect(T1[5].outPlaces[1], RLT_Heating_I[5].inTransition[1]) annotation(
      Line(points = {{-75.2, 98}, {-63.9, 98}, {-63.9, 98}, {-52.6, 98}, {-52.6, 98}, {-30, 98}, {-30, 110.5}, {-32.6, 110.5}, {-32.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[4].outTransition[1], T1[4].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
    connect(T1[4].outPlaces[1], RLT_Heating_I[4].inTransition[1]) annotation(
      Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[3].outTransition[1], T1[3].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
    connect(T1[3].outPlaces[1], RLT_Heating_I[3].inTransition[1]) annotation(
      Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[2].outTransition[1], T1[2].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-86.6, 98.5}, {-86.6, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
    connect(T1[2].outPlaces[1], RLT_Heating_I[2].inTransition[1]) annotation(
      Line(points = {{-75.2, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
    connect(RLT_Heating_Off[1].outTransition[1], T1[1].inPlaces[1]) annotation(
      Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-86.6, 98.5}, {-86.6, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
    connect(T1[1].outPlaces[1], RLT_Heating_I[1].inTransition[1]) annotation(
      Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
    connect(T11[6].outPlaces[1], RLT_Heating_Off[6].inTransition[1]) annotation(
      Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
    connect(T11[5].outPlaces[1], RLT_Heating_Off[5].inTransition[1]) annotation(
      Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
    connect(T11[4].outPlaces[1], RLT_Heating_Off[4].inTransition[1]) annotation(
      Line(points = {{-84.8, 118}, {-105.4, 118}, {-105.4, 118}, {-124, 118}, {-124, 87.5}, {-122.4, 87.5}, {-122.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
    connect(T11[3].outPlaces[1], RLT_Heating_Off[3].inTransition[1]) annotation(
      Line(points = {{-84.8, 118}, {-95.6, 118}, {-95.6, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
    connect(T11[2].outPlaces[1], RLT_Heating_Off[2].inTransition[1]) annotation(
      Line(points = {{-84.8, 118}, {-105.4, 118}, {-105.4, 118}, {-124, 118}, {-124, 87.5}, {-122.4, 87.5}, {-122.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
    connect(T11[1].outPlaces[1], RLT_Heating_Off[1].inTransition[1]) annotation(
      Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[6].outTransition[1], T16[6].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[5].outTransition[1], T16[5].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-184.4, 118.5}, {-184.4, 118.5}, {-181.6, 118.5}, {-181.6, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[4].outTransition[1], T16[4].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[3].outTransition[1], T16[3].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-184.4, 118.5}, {-184.4, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[2].outTransition[1], T16[2].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
    connect(RLT_Cooling_I[1].outTransition[1], T16[1].inPlaces[1]) annotation(
      Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
    connect(RLT_Heating_I[6].outTransition[1], T11[6].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-60.4, 110}, {-60.4, 110}, {-64, 110}, {-64, 117.5}, {-69.6, 117.5}, {-69.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
    connect(RLT_Heating_I[5].outTransition[1], T11[5].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
    connect(RLT_Heating_I[4].outTransition[1], T11[4].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
    connect(RLT_Heating_I[3].outTransition[1], T11[3].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
    connect(RLT_Heating_I[2].outTransition[1], T11[2].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-60.4, 110}, {-60.4, 110}, {-64, 110}, {-64, 117.5}, {-69.6, 117.5}, {-69.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
    connect(RLT_Heating_I[1].outTransition[1], T11[1].inPlaces[1]) annotation(
      Line(points = {{-54.8, 110}, {-64, 110}, {-64, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
    annotation(
      Icon(graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-250, 150}, {250, -150}}), Text(origin = {-52, 6},fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-68, 30}, {170, -46}}, textString = "Automatisierungs-
Ebene")}, coordinateSystem(extent = {{-250, -150}, {250, 150}})),
      Diagram(graphics = {Text(origin = {-177, 139}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_RLT_cooling"), Text(origin = {-77, 139}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_RLT_heating"), Text(origin = {-131, 31}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_BKT"), Text(origin = {69, 133}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_HTSsystem"), Text(origin = {195, 129}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_HPsystem_warm")}, coordinateSystem(extent = {{-250, -150}, {250, 150}})),
      __OpenModelica_commandLineOptions = "");
  end AutomatisierungsebeneV2;

  model ManagementEbene_Temp "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten der Raumtemperatur"
    PNlib.Components.T disableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 15, TRoomMea[2] > 273.15 + 20, TRoomMea[3] > 273.15 + 20, TRoomMea[4] > 273.15 + 20, TRoomMea[5] > 273.15 + 20}) annotation(
      Placement(visible = true, transformation(origin = {44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T enableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] < 273.15 + 13, TRoomMea[2] < 273.15 + 18, TRoomMea[3] < 273.15 + 18, TRoomMea[4] < 273.15 + 18, TRoomMea[5] < 273.15 + 18}) annotation(
      Placement(visible = true, transformation(extent = {{34, 20}, {54, 40}}, rotation = 0)));
    PNlib.Components.PD Heating[5](each maxTokens = 1, each minTokens = 0, each nIn = 1, each nOut = 1, each startTokens = 0) annotation(
      Placement(visible = true, transformation(origin = {84, -2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD Off_Temperature[5](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1, each reStart = true, each reStartTokens = 1) annotation(
      Placement(visible = true, transformation(origin = { 0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Cooling[5](each nIn = 1, each nOut = 1, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-82, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T enableCooling[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 17, TRoomMea[2] > 273.15 + 22, TRoomMea[3] > 273.15 + 22, TRoomMea[4] > 273.15 + 22, TRoomMea[5] > 273.15 + 22}) annotation(
      Placement(visible = true, transformation(origin = {-44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T disableCooling[5]( firingCon = {TRoomMea[1] < 273.15 + 15, TRoomMea[2] < 273.15 + 20, TRoomMea[3] < 273.15 + 20, TRoomMea[4] < 273.15 + 20, TRoomMea[5] < 273.15 + 20}, each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(extent = {{-54, 20}, {-34, 40}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput y[15] annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1[15](each threshold = 0.5)  annotation(
      Placement(visible = true, transformation(origin = {0, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation(
      Placement(visible = true, transformation(origin = {-2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {-2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
  equation
    connect(realToBoolean1[1].y, y[1]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[2].y, y[2]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[3].y, y[3]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[4].y, y[4]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[5].y, y[5]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[6].y, y[6]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[7].y, y[7]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[8].y, y[8]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[9].y, y[9]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[10].y, y[10]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[11].y, y[11]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[12].y, y[12]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[13].y, y[13]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[14].y, y[14]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  connect(realToBoolean1[15].y, y[15]) annotation(
      Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
  
  realToBoolean1[1].u=Off_Temperature[1].t;
  realToBoolean1[2].u=Heating[1].t;
  realToBoolean1[3].u=Cooling[1].t;
  realToBoolean1[4].u=Off_Temperature[2].t;
  realToBoolean1[5].u=Heating[2].t;
  realToBoolean1[6].u=Cooling[2].t;
  realToBoolean1[7].u=Off_Temperature[3].t;
  realToBoolean1[8].u=Heating[3].t;
  realToBoolean1[9].u=Cooling[3].t;
  realToBoolean1[10].u=Off_Temperature[4].t;
  realToBoolean1[11].u=Heating[4].t;
  realToBoolean1[12].u=Cooling[4].t;
  realToBoolean1[13].u=Off_Temperature[5].t;
  realToBoolean1[14].u=Heating[5].t;
  realToBoolean1[15].u=Cooling[5].t;
  
  
    connect(enableCooling[1].outPlaces[1], Cooling[1].inTransition[1]) annotation(
      Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
    connect(enableCooling[2].outPlaces[1], Cooling[2].inTransition[1]) annotation(
      Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
    connect(enableCooling[3].outPlaces[1], Cooling[3].inTransition[1]) annotation(
      Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
    connect(enableCooling[4].outPlaces[1], Cooling[4].inTransition[1]) annotation(
      Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
    connect(enableCooling[5].outPlaces[1], Cooling[5].inTransition[1]) annotation(
      Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
    connect(Off_Temperature[1].outTransition[2], enableCooling[1].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-12.8, -2}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
    connect(Off_Temperature[2].outTransition[2], enableCooling[2].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-12.8, -2}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
    connect(Off_Temperature[3].outTransition[2], enableCooling[3].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, -1.5}, {-12.8, -1.5}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
    connect(Off_Temperature[4].outTransition[2], enableCooling[4].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-12.8, -2}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
    connect(Off_Temperature[5].outTransition[2], enableCooling[5].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, -1.5}, {-12.8, -1.5}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
    connect(Heating[1].outTransition[1], disableHeating[1].inPlaces[1]) annotation(
      Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
    connect(Heating[2].outTransition[1], disableHeating[2].inPlaces[1]) annotation(
      Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
    connect(Heating[3].outTransition[1], disableHeating[3].inPlaces[1]) annotation(
      Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
    connect(Heating[4].outTransition[1], disableHeating[4].inPlaces[1]) annotation(
      Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
    connect(Heating[5].outTransition[1], disableHeating[5].inPlaces[1]) annotation(
      Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
    connect(disableHeating[1].outPlaces[1], Off_Temperature[1].inTransition[1]) annotation(
      Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
    connect(disableHeating[2].outPlaces[1], Off_Temperature[2].inTransition[1]) annotation(
      Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
    connect(disableHeating[3].outPlaces[1], Off_Temperature[3].inTransition[1]) annotation(
      Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
    connect(disableHeating[4].outPlaces[1], Off_Temperature[4].inTransition[1]) annotation(
      Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
    connect(disableHeating[5].outPlaces[1], Off_Temperature[5].inTransition[1]) annotation(
      Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
    connect(enableHeating[1].outPlaces[1], Heating[1].inTransition[1]) annotation(
      Line(points = {{49, 30}, {83.8, 30}, {83.8, 8.8}, {84, 8.8}}));
    connect(enableHeating[2].outPlaces[1], Heating[2].inTransition[1]) annotation(
      Line(points = {{49, 30}, {83.8, 30}, {83.8, 8.8}, {84, 8.8}}));
    connect(enableHeating[3].outPlaces[1], Heating[3].inTransition[1]) annotation(
      Line(points = {{49, 30}, {83.8, 30}, {83.8, 8.8}, {84, 8.8}}));
    connect(enableHeating[4].outPlaces[1], Heating[4].inTransition[1]) annotation(
      Line(points = {{49, 30}, {83.8, 30}, {83.8, 8.8}, {84, 8.8}}));
    connect(Off_Temperature[1].outTransition[1], enableHeating[1].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
    connect(Off_Temperature[2].outTransition[1], enableHeating[2].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
    connect(Off_Temperature[3].outTransition[1], enableHeating[3].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
    connect(Off_Temperature[4].outTransition[1], enableHeating[4].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
    connect(Off_Temperature[5].outTransition[1], enableHeating[5].inPlaces[1]) annotation(
      Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
    connect(enableHeating[5].outPlaces[1], Heating[5].inTransition[1]) annotation(
      Line(points = {{49, 30}, {84, 30}, {84, 8.8}}));
    connect(Cooling[2].outTransition[1], disableCooling[2].inPlaces[1]) annotation(
      Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
    connect(Cooling[3].outTransition[1], disableCooling[3].inPlaces[1]) annotation(
      Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
    connect(Cooling[4].outTransition[1], disableCooling[4].inPlaces[1]) annotation(
      Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
    connect(Cooling[5].outTransition[1], disableCooling[5].inPlaces[1]) annotation(
      Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
    connect(disableCooling[1].outPlaces[1], Off_Temperature[1].inTransition[2]) annotation(
      Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
    connect(disableCooling[2].outPlaces[1], Off_Temperature[2].inTransition[2]) annotation(
      Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
    connect(disableCooling[3].outPlaces[1], Off_Temperature[3].inTransition[2]) annotation(
      Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
    connect(disableCooling[4].outPlaces[1], Off_Temperature[4].inTransition[2]) annotation(
      Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
    connect(disableCooling[5].outPlaces[1], Off_Temperature[5].inTransition[2]) annotation(
      Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
    connect(Cooling[1].outTransition[1], disableCooling[1].inPlaces[1]) annotation(
      Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
    annotation(
      Line(points = {{-60, -106}, {-60, -106}}, color = {255, 127, 0}),
      Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-200, 100}, {200, -100}}), Text(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-162, 34}, {152, -28}}, textString = "Managementebene")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)),
      Documentation(info = "<html><head></head><body>Struktur des MODI_Temperature-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Workshop_Heating</div><div>Workshop_Cooling</div><div>Canteen_Off</div><div>Canteen_Heating</div><div>Canteen_Cooling</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Heating</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Heating</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Off</div><div><div><div>OpenplanOffice_Heating</div><div></div></div><div>OpenplanOffice_Cooling</div><div><br></div><div><br></div><div><br></div></div><div><div><br></div><div><br></div><div><br></div><div><br></div></div><div><br></div></body></html>"),
      __OpenModelica_commandLineOptions = "");
  end ManagementEbene_Temp;

  model AutomationLevel_MODImethod
    PNlib.Components.PD HTS_Heating_II(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-54, 44}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    PNlib.Components.T T1(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
      Placement(visible = true, transformation(origin = {-73, 79}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
    PNlib.Components.PD HTS_Heating_I(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-54, 72}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
    PNlib.Components.PD HTS_Off(nIn = 2, nOut = 2, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-88, 58}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    PNlib.Components.T T11(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] and TAirOutside>283.15 "and weaBus.DryBulbTemp>283.15") annotation(
      Placement(visible = true, transformation(origin = {-73, 65}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    PNlib.Components.T T12(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] and TAirOutside<=283.15  "and weaBus.DryBulbTemp<=283.15") annotation(
      Placement(visible = true, transformation(origin = {-73, 51}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    PNlib.Components.T T13(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
      Placement(visible = true, transformation(origin = {-73, 37}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
    PNlib.Components.T T14(nIn = 1, nOut = 1, firingCon=TAirOutside<=283.15", firingCon= weaBus.DryBulbTemp<=283.15") annotation(
      Placement(visible = true, transformation(origin = {-47, 57}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    PNlib.Components.T T15(nIn = 1, nOut = 1 ,firingCon=TAirOutside>283.15", firingCon=weaBus.DryBulbTemp>283.15") annotation(
      Placement(visible = true, transformation(origin = {-61, 57}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
    PNlib.Components.T T16(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
      Placement(visible = true, transformation(origin = {59, 39}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
    PNlib.Components.PD HP_Heating_II(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {78, 46}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    PNlib.Components.T T17(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] "and weaBus.DryBulbTemp>283.15") annotation(
      Placement(visible = true, transformation(origin = {59, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    PNlib.Components.T T18(nIn = 1, nOut = 1, firingCon=TAirOutside<=283.15 ", firingCon=weaBus.DryBulbTemp<=283.15") annotation(
      Placement(visible = true, transformation(origin = {71, 59}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
    PNlib.Components.T T19(nIn = 1, nOut = 1 ,firingCon=TAirOutside>283.15 ", firingCon=weaBus.DryBulbTemp>283.15") annotation(
      Placement(visible = true, transformation(origin = {85, 59}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    PNlib.Components.PD HP_Off(nIn = 3, nOut = 3, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {44, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    PNlib.Components.T T110(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] "and weaBus.DryBulbTemp<=283.15") annotation(
      Placement(visible = true, transformation(origin = {59, 67}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    PNlib.Components.PD HP_Heating_I(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {78, 74}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
    PNlib.Components.T T111(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
      Placement(visible = true, transformation(origin = {59, 81}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
    PNlib.Components.T T112(nIn = 1, nOut = 1,  firingCon = u[3] or u[6] or u[9] or u[12] or u[15]) annotation(
      Placement(visible = true, transformation(origin = {29, 67}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
    PNlib.Components.T T113(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
      Placement(visible = true, transformation(origin = {29, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    PNlib.Components.PD HP_Cooling(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {14, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    PNlib.Components.PD GTF_On(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-82, -32}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
    PNlib.Components.T T114(nIn = 1, nOut = 1, firingCon = u[3] or u[6] or u[9] or u[12] or u[15] or HP_Heating_II.t>0.5 or HP_Heating_I.t>0.5) annotation(
      Placement(visible = true, transformation(origin = {-75, -15}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    PNlib.Components.T T115(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
      Placement(visible = true, transformation(origin = {-89, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
    PNlib.Components.PD GTF_Off(nIn = 1, nOut = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    PNlib.Components.PD HX_On(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-42, -32}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
    PNlib.Components.T T116(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
      Placement(visible = true, transformation(origin = {-49, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
    PNlib.Components.T T117(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-35, -15}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    PNlib.Components.PD HX_Off(nIn = 1, nOut = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-42, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    PNlib.Components.PD Off[6](each nIn = 2, each nOut = 2, each startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {38, -8}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
    PNlib.Components.PD Cooling[6](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {4, -8}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    PNlib.Components.T T118[6](each nIn = 1, each nOut = 1, firingCon = {u[3], u[6], u[9], u[12], u[15], u[3] or u[6] or u[9] or u[12] or u[15]}) annotation(
      Placement(visible = true, transformation(origin = {21, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
    PNlib.Components.T T119[6](each nIn = 1, each nOut = 1, firingCon = {u[1], u[4], u[7], u[10], u[13], u[1] and u[4] and u[7] and u[10] and u[13]}) annotation(
      Placement(visible = true, transformation(origin = {21, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    PNlib.Components.T T120[6](each nIn = 1, each nOut = 1, firingCon = {u[1], u[4], u[7], u[10], u[13], u[1] and u[4] and u[7] and u[10] and u[13]}) annotation(
      Placement(visible = true, transformation(origin = {55, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
    PNlib.Components.T T121[6](each nIn = 1, each nOut = 1, firingCon = {u[2], u[5], u[8], u[11], u[14], u[2] or u[5] or u[8] or u[11] or u[14]}) annotation(
      Placement(visible = true, transformation(origin = {55, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    PNlib.Components.PD Heating[6](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {72, -8}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    Modelica.Blocks.Interfaces.BooleanInput u[15] annotation(
      Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.BooleanOutput y[29] annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.RealToBoolean realToBoolean[29](each threshold = 0.5) annotation(
      Placement(visible = true, transformation(origin = {-1, -85}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput TAirOutside "Outside Air Temperature" annotation(
      Placement(visible = true, transformation(origin = {214, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 180), iconTransformation(origin = {214, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 180)));
  equation
    connect(realToBoolean[29].y, y[29]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[28].y, y[28]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[27].y, y[27]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[26].y, y[26]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[25].y, y[25]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[24].y, y[24]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[23].y, y[23]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[22].y, y[22]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[21].y, y[21]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[20].y, y[20]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[19].y, y[19]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[18].y, y[18]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[17].y, y[17]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[16].y, y[16]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[15].y, y[15]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[14].y, y[14]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[13].y, y[13]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[12].y, y[12]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[11].y, y[11]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[10].y, y[10]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[9].y, y[9]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[8].y, y[8]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[7].y, y[7]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[6].y, y[6]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[5].y, y[5]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[4].y, y[4]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[3].y, y[3]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[2].y, y[2]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    connect(realToBoolean[1].y, y[1]) annotation(
      Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
    realToBoolean[1].u = HTS_Off.t;
  realToBoolean[2].u = HTS_Heating_I.t;
  realToBoolean[3].u = HTS_Heating_II.t;
    realToBoolean[4].u = HP_Off.t;
    realToBoolean[5].u = HP_Heating_I.t;
    realToBoolean[6].u = HP_Heating_II.t;
    realToBoolean[7].u = HP_Cooling.t;
    realToBoolean[8].u = GTF_Off.t;
    realToBoolean[9].u = GTF_On.t;
    realToBoolean[10].u = HX_Off.t;
    realToBoolean[11].u = HX_On.t;
    realToBoolean[12].u = Off[1].t;
    realToBoolean[13].u = Heating[1].t;
    realToBoolean[14].u = Cooling[1].t;
    realToBoolean[15].u = Off[2].t;
    realToBoolean[16].u = Heating[2].t;
    realToBoolean[17].u = Cooling[2].t;
    realToBoolean[18].u = Off[3].t;
    realToBoolean[19].u = Heating[3].t;
    realToBoolean[20].u = Cooling[3].t;
    realToBoolean[21].u = Off[4].t;
    realToBoolean[22].u = Heating[4].t;
    realToBoolean[23].u = Cooling[4].t;
    realToBoolean[24].u = Off[5].t;
    realToBoolean[25].u = Heating[5].t;
    realToBoolean[26].u = Cooling[5].t;
    realToBoolean[27].u = Off[6].t;
    realToBoolean[28].u = Heating[6].t;
    realToBoolean[29].u = Cooling[6].t;
    connect(T121[6].outPlaces[1], Heating[6].inTransition[1]) annotation(
      Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
    connect(T120[6].inPlaces[1], Heating[6].outTransition[1]) annotation(
      Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
    connect(Cooling[6].outTransition[1], T119[6].inPlaces[1]) annotation(
      Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
    connect(T118[6].outPlaces[1], Cooling[6].inTransition[1]) annotation(
      Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
    connect(T119[6].outPlaces[1], Off[6].inTransition[2]) annotation(
      Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[6].outTransition[2], T118[6].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
    connect(T120[6].outPlaces[1], Off[6].inTransition[1]) annotation(
      Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[6].outTransition[1], T121[6].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
    connect(T121[5].outPlaces[1], Heating[5].inTransition[1]) annotation(
      Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
    connect(T120[5].inPlaces[1], Heating[5].outTransition[1]) annotation(
      Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
    connect(Cooling[5].outTransition[1], T119[5].inPlaces[1]) annotation(
      Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
    connect(T118[5].outPlaces[1], Cooling[5].inTransition[1]) annotation(
      Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
    connect(T119[5].outPlaces[1], Off[5].inTransition[2]) annotation(
      Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[5].outTransition[2], T118[5].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
    connect(T120[5].outPlaces[1], Off[5].inTransition[1]) annotation(
      Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[5].outTransition[1], T121[5].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
    connect(T121[4].outPlaces[1], Heating[4].inTransition[1]) annotation(
      Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
    connect(T120[4].inPlaces[1], Heating[4].outTransition[1]) annotation(
      Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
    connect(Cooling[4].outTransition[1], T119[4].inPlaces[1]) annotation(
      Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
    connect(T118[4].outPlaces[1], Cooling[4].inTransition[1]) annotation(
      Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
    connect(T119[4].outPlaces[1], Off[4].inTransition[2]) annotation(
      Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[4].outTransition[2], T118[4].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
    connect(T120[4].outPlaces[1], Off[4].inTransition[1]) annotation(
      Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[4].outTransition[1], T121[4].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
    connect(T121[3].outPlaces[1], Heating[3].inTransition[1]) annotation(
      Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
    connect(T120[3].inPlaces[1], Heating[3].outTransition[1]) annotation(
      Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
    connect(Cooling[3].outTransition[1], T119[3].inPlaces[1]) annotation(
      Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
    connect(T118[3].outPlaces[1], Cooling[3].inTransition[1]) annotation(
      Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
    connect(T119[3].outPlaces[1], Off[3].inTransition[2]) annotation(
      Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[3].outTransition[2], T118[3].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
    connect(T120[3].outPlaces[1], Off[3].inTransition[1]) annotation(
      Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[3].outTransition[1], T121[3].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
    connect(T121[2].outPlaces[1], Heating[2].inTransition[1]) annotation(
      Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
    connect(T120[2].inPlaces[1], Heating[2].outTransition[1]) annotation(
      Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
    connect(Cooling[2].outTransition[1], T119[2].inPlaces[1]) annotation(
      Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
    connect(T118[2].outPlaces[1], Cooling[2].inTransition[1]) annotation(
      Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
    connect(T119[2].outPlaces[1], Off[2].inTransition[2]) annotation(
      Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[2].outTransition[2], T118[2].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
    connect(T120[2].outPlaces[1], Off[2].inTransition[1]) annotation(
      Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[2].outTransition[1], T121[2].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
    connect(T121[1].outPlaces[1], Heating[1].inTransition[1]) annotation(
      Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
    connect(T120[1].inPlaces[1], Heating[1].outTransition[1]) annotation(
      Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
    connect(Cooling[1].outTransition[1], T119[1].inPlaces[1]) annotation(
      Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
    connect(T118[1].outPlaces[1], Cooling[1].inTransition[1]) annotation(
      Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
    connect(T119[1].outPlaces[1], Off[1].inTransition[2]) annotation(
      Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[1].outTransition[2], T118[1].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
    connect(T120[1].outPlaces[1], Off[1].inTransition[1]) annotation(
      Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
    connect(Off[1].outTransition[1], T121[1].inPlaces[1]) annotation(
      Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
  connect(HTS_Heating_I.outTransition[2], T14.inPlaces[1]) annotation(
      Line(points = {{-54, 78}, {-46, 78}, {-46, 60}, {-46, 60}, {-46, 60}}, thickness = 0.5));
  connect(T15.outPlaces[1], HTS_Heating_I.inTransition[2]) annotation(
      Line(points = {{-60, 60}, {-62, 60}, {-62, 66}, {-54, 66}, {-54, 66}}, thickness = 0.5));
  connect(HTS_Heating_I.outTransition[1], T1.inPlaces[1]) annotation(
      Line(points = {{-54, 78}, {-70, 78}, {-70, 80}, {-70, 80}}, thickness = 0.5));
  connect(T11.outPlaces[1], HTS_Heating_I.inTransition[2]) annotation(
      Line(points = {{-70, 66}, {-54, 66}, {-54, 66}, {-54, 66}}, thickness = 0.5));
  connect(T15.inPlaces[1], HTS_Heating_II.outTransition[2]) annotation(
      Line(points = {{-60, 54}, {-62, 54}, {-62, 38}, {-54, 38}, {-54, 38}}, thickness = 0.5));
  connect(T14.outPlaces[1], HTS_Heating_II.inTransition[2]) annotation(
      Line(points = {{-46, 54}, {-48, 54}, {-48, 52}, {-54, 52}, {-54, 52}, {-54, 52}, {-54, 50}}, thickness = 0.5));
  connect(T13.inPlaces[1], HTS_Heating_II.outTransition[1]) annotation(
      Line(points = {{-70, 38}, {-54, 38}, {-54, 38}, {-54, 38}}, thickness = 0.5));
  connect(T12.outPlaces[1], HTS_Heating_II.inTransition[1]) annotation(
      Line(points = {{-70, 52}, {-54, 52}, {-54, 50}, {-54, 50}}, thickness = 0.5));
    connect(HTS_Off.inTransition[2], T13.outPlaces[1]) annotation(
      Line(points = {{-94, 58}, {-94, 58}, {-94, 36}, {-76, 36}, {-76, 38}}, thickness = 0.5));
    connect(HTS_Off.inTransition[1], T1.outPlaces[1]) annotation(
      Line(points = {{-94, 58}, {-94, 58}, {-94, 80}, {-76, 80}, {-76, 80}}, thickness = 0.5));
    connect(GTF_On.inTransition[1], T114.outPlaces[1]) annotation(
      Line(points = {{-76, -32}, {-74, -32}, {-74, -18}, {-74, -18}}, thickness = 0.5));
    connect(GTF_On.outTransition[1], T115.inPlaces[1]) annotation(
      Line(points = {{-88, -32}, {-90, -32}, {-90, -18}, {-88, -18}}, thickness = 0.5));
    connect(GTF_Off.outTransition[1], T114.inPlaces[1]) annotation(
      Line(points = {{-76, 0}, {-76, 0}, {-76, -12}, {-74, -12}}, thickness = 0.5));
    connect(T115.outPlaces[1], GTF_Off.inTransition[1]) annotation(
      Line(points = {{-88, -12}, {-88, -12}, {-88, 0}, {-88, 0}}, thickness = 0.5));
    connect(HX_On.outTransition[1], T116.inPlaces[1]) annotation(
      Line(points = {{-48, -32}, {-50, -32}, {-50, -18}, {-50, -18}, {-50, -18}, {-48, -18}}, thickness = 0.5));
    connect(T117.outPlaces[1], HX_On.inTransition[1]) annotation(
      Line(points = {{-34, -18}, {-34, -18}, {-34, -32}, {-36, -32}, {-36, -32}, {-36, -32}}, thickness = 0.5));
    connect(HX_Off.outTransition[1], T117.inPlaces[1]) annotation(
      Line(points = {{-36, 0}, {-34, 0}, {-34, -12}, {-34, -12}, {-34, -12}}, thickness = 0.5));
    connect(T116.outPlaces[1], HX_Off.inTransition[1]) annotation(
      Line(points = {{-48, -12}, {-48, -12}, {-48, 0}, {-48, 0}}, thickness = 0.5));
    connect(HP_Heating_I.outTransition[2], T19.inPlaces[1]) annotation(
      Line(points = {{78, 80}, {86, 80}, {86, 62}, {86, 62}, {86, 62}}, thickness = 0.5));
    connect(T18.outPlaces[1], HP_Heating_I.inTransition[2]) annotation(
      Line(points = {{72, 62}, {70, 62}, {70, 68}, {78, 68}, {78, 68}, {78, 68}}, thickness = 0.5));
    connect(T18.inPlaces[1], HP_Heating_II.outTransition[2]) annotation(
      Line(points = {{72, 56}, {70, 56}, {70, 40}, {78, 40}, {78, 40}}, thickness = 0.5));
    connect(T19.outPlaces[1], HP_Heating_II.inTransition[2]) annotation(
      Line(points = {{86, 56}, {86, 56}, {86, 54}, {78, 54}, {78, 52}, {78, 52}}, thickness = 0.5));
    connect(T17.outPlaces[1], HP_Heating_II.inTransition[1]) annotation(
      Line(points = {{62, 54}, {78, 54}, {78, 52}, {78, 52}}, thickness = 0.5));
    connect(T16.inPlaces[1], HP_Heating_II.outTransition[1]) annotation(
      Line(points = {{62, 40}, {78, 40}, {78, 40}, {78, 40}}, thickness = 0.5));
    connect(T110.outPlaces[1], HP_Heating_I.inTransition[1]) annotation(
      Line(points = {{62, 68}, {78, 68}, {78, 68}, {78, 68}}, thickness = 0.5));
    connect(HP_Heating_I.outTransition[1], T111.inPlaces[1]) annotation(
      Line(points = {{78, 80}, {62, 80}, {62, 82}, {62, 82}}, thickness = 0.5));
    connect(T113.outPlaces[1], HP_Off.inTransition[3]) annotation(
      Line(points = {{32, 54}, {36, 54}, {36, 60}, {36, 60}, {36, 60}, {38, 60}}, thickness = 0.5));
    connect(T16.outPlaces[1], HP_Off.inTransition[2]) annotation(
      Line(points = {{56, 40}, {36, 40}, {36, 60}, {36, 60}, {36, 60}, {38, 60}}, thickness = 0.5));
    connect(HP_Off.inTransition[1], T111.outPlaces[1]) annotation(
      Line(points = {{38, 60}, {36, 60}, {36, 80}, {56, 80}, {56, 82}, {56, 82}}, thickness = 0.5));
    connect(HP_Off.outTransition[3], T112.inPlaces[1]) annotation(
      Line(points = {{50, 60}, {52, 60}, {52, 68}, {32, 68}, {32, 68}, {32, 68}}, thickness = 0.5));
    connect(HP_Off.outTransition[2], T17.inPlaces[1]) annotation(
      Line(points = {{50, 60}, {52, 60}, {52, 52}, {56, 52}, {56, 54}, {56, 54}}, thickness = 0.5));
    connect(HP_Off.outTransition[1], T110.inPlaces[1]) annotation(
      Line(points = {{50, 60}, {52, 60}, {52, 68}, {56, 68}, {56, 68}}, thickness = 0.5));
    connect(HP_Cooling.outTransition[1], T113.inPlaces[1]) annotation(
      Line(points = {{14, 54}, {26, 54}}, thickness = 0.5));
    connect(T112.outPlaces[1], HP_Cooling.inTransition[1]) annotation(
      Line(points = {{26, 68}, {20, 68}, {20, 66}, {14, 66}}, thickness = 0.5));
    connect(HTS_Off.outTransition[2], T12.inPlaces[1]) annotation(
      Line(points = {{-82, 58}, {-80, 58}, {-80, 50}, {-76, 50}, {-76, 52}, {-76, 52}}, thickness = 0.5));
    connect(HTS_Off.outTransition[1], T11.inPlaces[1]) annotation(
      Line(points = {{-82, 58}, {-80, 58}, {-80, 66}, {-76, 66}, {-76, 66}, {-76, 66}}, thickness = 0.5));
    annotation(
      uses(PNlib(version = "2.2"), Modelica(version = "3.2.3")),
      Diagram(graphics = {Text(origin = {-69, 93}, extent = {{-21, 5}, {13, -3}}, textString = "HTS_System"), Text(origin = {59, 93}, extent = {{-21, 5}, {13, -3}}, textString = "HP_System"), Text(origin = {-75, 15}, extent = {{-21, 5}, {13, -3}}, textString = "GTF_System"), Text(origin = {-39, 15}, extent = {{-21, 5}, {13, -3}}, textString = "HX"), Text(origin = {45, 17}, extent = {{-21, 5}, {13, -3}}, textString = "Senken")}, coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  Icon(graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-200, 100}, {200, -100}}), Text(origin = {-110, 34}, extent = {{-42, 12}, {250, -78}}, textString = "Automatisierungsebene")}, coordinateSystem(extent = {{-200, -100}, {200, 100}}, initialScale = 0.1)),
      __OpenModelica_commandLineOptions = "",
  Documentation(info = "<html><head></head><body>Struktur Output-Vektor<div><br></div><div>HTS_Off</div><div>HTS_Heating_I</div><div>HTS_Heating_II</div><div><br></div><div>HP_Off</div><div>HP_Heating_I</div><div>HP_Heating_II</div><div>HP_Cooling</div><div><br></div><div>GTF_Off</div><div>GTF_On</div><div><br></div><div>HX_Off</div><div>HX_On</div><div><br></div><div>Off[1]</div><div>Heating[1]</div><div>Cooling[1]</div><div><br></div><div><div>Off[2]</div><div>Heating[2]</div><div>Cooling[2]</div></div><div><br></div><div><div>Off[3]</div><div>Heating[3]</div><div>Cooling[3]</div></div><div><br></div><div><div>Off[4]</div><div>Heating[4]</div><div>Cooling[4]</div></div><div><br></div><div><div>Off[5]</div><div>Heating[5]</div><div>Cooling[5]</div></div><div><br></div><div><div>Off[6]</div><div>Heating[6]</div><div>Cooling[6]</div></div><div><br></div><div>(Off/Heating/Cooling 1-5 bestimmen den Betriebsmodus der VU/Tabs Module der Räume</div><div>Off/Heating/Cooling 6 bestimmt den Betriebsmodus der zentralen AHU unit)</div></body></html>"));
  end AutomationLevel_MODImethod;

  model Test
  AixLib.Systems.Benchmark_fb.MODI.ManagementEbene_Temp managementEbene_Temp1 annotation(
      Placement(visible = true, transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 5, freqHz = 1 / 86400, offset = 293.15, startTime = 21600)  annotation(
      Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  AixLib.Systems.Benchmark_fb.MODI.AutomationLevel_MODImethod automationLevel_MODImethod1 annotation(
      Placement(visible = true, transformation(origin = {-20,-10}, extent = {{-20, -10}, {20, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine2(amplitude = 10, freqHz = 1 / 86400, offset = 288.15, startTime = 21600) annotation(
      Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation
    connect(managementEbene_Temp1.y[1], automationLevel_MODImethod1.u[1]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[2], automationLevel_MODImethod1.u[2]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[3], automationLevel_MODImethod1.u[3]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[4], automationLevel_MODImethod1.u[4]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[5], automationLevel_MODImethod1.u[5]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[6], automationLevel_MODImethod1.u[6]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[7], automationLevel_MODImethod1.u[7]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[8], automationLevel_MODImethod1.u[8]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[9], automationLevel_MODImethod1.u[9]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[10], automationLevel_MODImethod1.u[10]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[11], automationLevel_MODImethod1.u[12]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[12], automationLevel_MODImethod1.u[12]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[13], automationLevel_MODImethod1.u[13]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[14], automationLevel_MODImethod1.u[14]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
      connect(managementEbene_Temp1.y[15], automationLevel_MODImethod1.u[15]) annotation(
      Line(points = {{-20, 20}, {-20, 20}, {-20, 2}, {-20, 2}}, color = {255, 0, 255}, thickness = 0.5));
     
      
      
    connect(sine2.y, automationLevel_MODImethod1.TAirOutside) annotation(
      Line(points = {{20, -10}, {2, -10}, {2, -10}, {2, -10}}, color = {0, 0, 127}));
  connect(sine1.y, managementEbene_Temp1.TRoomMea[5]) annotation(
      Line(points = {{19, 50}, {-20, 50}, {-20, 42}}, color = {0, 0, 127}));
  connect(sine1.y, managementEbene_Temp1.TRoomMea[4]) annotation(
      Line(points = {{19, 50}, {-20, 50}, {-20, 42}}, color = {0, 0, 127}));
  connect(sine1.y, managementEbene_Temp1.TRoomMea[3]) annotation(
      Line(points = {{19, 50}, {-20, 50}, {-20, 42}}, color = {0, 0, 127}));
  connect(sine1.y, managementEbene_Temp1.TRoomMea[2]) annotation(
      Line(points = {{19, 50}, {-20, 50}, {-20, 42}}, color = {0, 0, 127}));
  connect(sine1.y, managementEbene_Temp1.TRoomMea[1]) annotation(
      Line(points = {{19, 50}, {-20, 50}, {-20, 42}}, color = {0, 0, 127}));
  end Test;

  model Controller_HTSSystem
    Modelica.Blocks.Sources.Constant rpmPumps(k=3000)
      annotation (Placement(visible = true, transformation(extent = {{20, 30}, {40, 50}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant TChpSet(final k=T_chp_set)
      annotation (Placement(visible = true, transformation(extent = {{18, -50}, {38, -30}}, rotation = 0)));
    AixLib.Controls.Continuous.LimPID PIDBoiler(
      final yMax=1,
      final yMin=0,
      final controllerType=Modelica.Blocks.Types.SimpleController.PID,
      k=0.01,
      Ti=60,
      Td=0,
      final reverseAction=false) annotation (Placement(visible = true, transformation(extent = {{20, -10}, {40, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant TBoilerSet_out(final k=T_boi_set)
      annotation (Placement(visible = true, transformation(extent = {{-20, -10}, {0, 10}}, rotation = 0)));
    parameter Real T_boi_set=273.15 + 80 "Set point temperature of boiler";
    parameter Real T_chp_set=333.15 "Set point temperature of chp";
  AixLib.Systems.Benchmark.BaseClasses.HighTempSystemBus highTempSystemBus1 annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput HTS_Heating_I annotation(
      Placement(visible = true, transformation(origin = {114, 60}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {114, 60}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanInput HTS_Heating_II annotation(
      Placement(visible = true, transformation(origin = {114, -60}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {114, -60}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
  Modelica.Blocks.Logical.Or or1 annotation(
      Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(HTS_Heating_II, highTempSystemBus1.pumpBoilerBus.pumpBus.onSet) annotation(
      Line(points = {{114, -60}, {-40, -60}, {-40, 20}, {100, 20}, {100, 0}, {100, 0}, {100, 0}}, color = {255, 0, 255}));
    connect(or1.y, highTempSystemBus1.pumpChpBus.pumpBus.onSet) annotation(
      Line(points = {{-58, 20}, {100, 20}, {100, 0}, {100, 0}, {100, 0}}, color = {255, 0, 255}));
    connect(or1.y, highTempSystemBus1.onOffChpSet) annotation(
      Line(points = {{-58, 20}, {100, 20}, {100, 0}, {100, 0}, {100, 0}}, color = {255, 0, 255}));
    connect(highTempSystemBus1.pumpBoilerBus.TRtrnInMea, PIDBoiler.u_m) annotation(
      Line(points = {{100, 0}, {60, 0}, {60, -20}, {30, -20}, {30, -12}, {30, -12}, {30, -12}}, color = {0, 0, 127}));
    connect(PIDBoiler.y, highTempSystemBus1.uRelBoilerSet) annotation(
      Line(points = {{42, 0}, {100, 0}, {100, 0}, {100, 0}}, color = {0, 0, 127}));
    connect(HTS_Heating_II, or1.u2) annotation(
      Line(points = {{114, -60}, {-100, -60}, {-100, 12}, {-84, 12}, {-84, 12}, {-82, 12}}, color = {255, 0, 255}));
    connect(HTS_Heating_I, or1.u1) annotation(
      Line(points = {{114, 60}, {-100, 60}, {-100, 20}, {-84, 20}, {-84, 20}, {-82, 20}}, color = {255, 0, 255}));
    connect(TBoilerSet_out.y, PIDBoiler.u_s) annotation(
      Line(points = {{1, 0}, {18, 0}}, color = {0, 0, 127}));
    connect(TChpSet.y, highTempSystemBus1.TChpSet) annotation(
      Line(points = {{39, -40}, {100, -40}, {100, 0}}, color = {0, 0, 127}));
    connect(rpmPumps.y, highTempSystemBus1.pumpChpBus.pumpBus.rpmSet) annotation(
      Line(points = {{41, 40}, {100, 40}, {100, 0}}, color = {0, 0, 127}));
    connect(rpmPumps.y, highTempSystemBus1.pumpBoilerBus.pumpBus.rpmSet) annotation(
      Line(points = {{41, 40}, {100, 40}, {100, 0}}, color = {0, 0, 127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={
                                           Line(
            points={{20,80},{80,0},{40,-80}},
            color={95,95,95},
            thickness=0.5),
Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-80, 20}, {66, -20}}, textString = "Control"), Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-30, 0},lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-48, 24}, {98, -16}}, textString = "Controller HTS_System")}),
                              Diagram(coordinateSystem(preserveAspectRatio=false)));

  end Controller_HTSSystem;

  package Ebenen
    model AutomationLevel_MODImethod
      PNlib.Components.PD HTS_Heating_II(nIn = 2, nOut = 2) annotation(
        Placement(visible = true, transformation(origin = {-54, 44}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      PNlib.Components.T T1(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
        Placement(visible = true, transformation(origin = {-73, 79}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.PD HTS_Heating_I(nIn = 2, nOut = 2) annotation(
        Placement(visible = true, transformation(origin = {-54, 72}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
      PNlib.Components.PD HTS_Off(nIn = 2, nOut = 2, startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-88, 58}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      PNlib.Components.T T11(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] and TAirOutside > 283.15 "and weaBus.DryBulbTemp>283.15") annotation(
        Placement(visible = true, transformation(origin = {-73, 65}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.T T12(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] and TAirOutside <= 283.15 "and weaBus.DryBulbTemp<=283.15") annotation(
        Placement(visible = true, transformation(origin = {-73, 51}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.T T13(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
        Placement(visible = true, transformation(origin = {-73, 37}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.T T14(nIn = 1, nOut = 1, firingCon = TAirOutside <= 283.15 ", firingCon= weaBus.DryBulbTemp<=283.15") annotation(
        Placement(visible = true, transformation(origin = {-47, 57}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.T T15(nIn = 1, nOut = 1, firingCon = TAirOutside > 283.15 ", firingCon=weaBus.DryBulbTemp>283.15") annotation(
        Placement(visible = true, transformation(origin = {-61, 57}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.T T16(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
        Placement(visible = true, transformation(origin = {59, 39}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.PD HP_Heating_II(nIn = 2, nOut = 2) annotation(
        Placement(visible = true, transformation(origin = {78, 46}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      PNlib.Components.T T17(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] "and weaBus.DryBulbTemp>283.15") annotation(
        Placement(visible = true, transformation(origin = {59, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.T T18(nIn = 1, nOut = 1, firingCon = TAirOutside <= 283.15 ", firingCon=weaBus.DryBulbTemp<=283.15") annotation(
        Placement(visible = true, transformation(origin = {71, 59}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.T T19(nIn = 1, nOut = 1, firingCon = TAirOutside > 283.15 ", firingCon=weaBus.DryBulbTemp>283.15") annotation(
        Placement(visible = true, transformation(origin = {85, 59}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.PD HP_Off(nIn = 3, nOut = 3, startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {44, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      PNlib.Components.T T110(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] "and weaBus.DryBulbTemp<=283.15") annotation(
        Placement(visible = true, transformation(origin = {59, 67}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.PD HP_Heating_I(nIn = 2, nOut = 2) annotation(
        Placement(visible = true, transformation(origin = {78, 74}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
      PNlib.Components.T T111(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
        Placement(visible = true, transformation(origin = {59, 81}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.T T112(nIn = 1, nOut = 1, firingCon = u[3] or u[6] or u[9] or u[12] or u[15]) annotation(
        Placement(visible = true, transformation(origin = {29, 67}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.T T113(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
        Placement(visible = true, transformation(origin = {29, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.PD HP_Cooling(nIn = 1, nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {14, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      PNlib.Components.PD GTF_On(nIn = 1, nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {-82, -32}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
      PNlib.Components.T T114(nIn = 1, nOut = 1, firingCon = u[3] or u[6] or u[9] or u[12] or u[15] or HP_Heating_II.t > 0.5 or HP_Heating_I.t > 0.5) annotation(
        Placement(visible = true, transformation(origin = {-75, -15}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.T T115(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
        Placement(visible = true, transformation(origin = {-89, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.PD GTF_Off(nIn = 1, nOut = 1, startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      PNlib.Components.PD HX_On(nIn = 1, nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {-42, -32}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
      PNlib.Components.T T116(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation(
        Placement(visible = true, transformation(origin = {-49, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.T T117(nIn = 1, nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {-35, -15}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.PD HX_Off(nIn = 1, nOut = 1, startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-42, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      PNlib.Components.PD Off[6](each nIn = 2, each nOut = 2, each startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {38, -8}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
      PNlib.Components.PD Cooling[6](each nIn = 1, each nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {4, -8}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      PNlib.Components.T T118[6](each nIn = 1, each nOut = 1, firingCon = {u[3], u[6], u[9], u[12], u[15], u[3] or u[6] or u[9] or u[12] or u[15]}) annotation(
        Placement(visible = true, transformation(origin = {21, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.T T119[6](each nIn = 1, each nOut = 1, firingCon = {u[1], u[4], u[7], u[10], u[13], u[1] and u[4] and u[7] and u[10] and u[13]}) annotation(
        Placement(visible = true, transformation(origin = {21, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.T T120[6](each nIn = 1, each nOut = 1, firingCon = {u[1], u[4], u[7], u[10], u[13], u[1] and u[4] and u[7] and u[10] and u[13]}) annotation(
        Placement(visible = true, transformation(origin = {55, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.T T121[6](each nIn = 1, each nOut = 1, firingCon = {u[2], u[5], u[8], u[11], u[14], u[2] or u[5] or u[8] or u[11] or u[14]}) annotation(
        Placement(visible = true, transformation(origin = {55, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.PD Heating[6](each nIn = 1, each nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {72, -8}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanInput u[15] annotation(
        Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanOutput y[29] annotation(
        Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.RealToBoolean realToBoolean[29](each threshold = 0.5) annotation(
        Placement(visible = true, transformation(origin = {-1, -85}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput TAirOutside "Outside Air Temperature" annotation(
        Placement(visible = true, transformation(origin = {214, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 180), iconTransformation(origin = {214, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 180)));
    equation
      connect(realToBoolean[29].y, y[29]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[28].y, y[28]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[27].y, y[27]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[26].y, y[26]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[25].y, y[25]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[24].y, y[24]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[23].y, y[23]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[22].y, y[22]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[21].y, y[21]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[20].y, y[20]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[19].y, y[19]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[18].y, y[18]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[17].y, y[17]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[16].y, y[16]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[15].y, y[15]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[14].y, y[14]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[13].y, y[13]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[12].y, y[12]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[11].y, y[11]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[10].y, y[10]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[9].y, y[9]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[8].y, y[8]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[7].y, y[7]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[6].y, y[6]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[5].y, y[5]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[4].y, y[4]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[3].y, y[3]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[2].y, y[2]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean[1].y, y[1]) annotation(
        Line(points = {{-1, -93}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      realToBoolean[1].u = HTS_Off.t;
      realToBoolean[2].u = HTS_Heating_I.t;
      realToBoolean[3].u = HTS_Heating_II.t;
      realToBoolean[4].u = HP_Off.t;
      realToBoolean[5].u = HP_Heating_I.t;
      realToBoolean[6].u = HP_Heating_II.t;
      realToBoolean[7].u = HP_Cooling.t;
      realToBoolean[8].u = GTF_Off.t;
      realToBoolean[9].u = GTF_On.t;
      realToBoolean[10].u = HX_Off.t;
      realToBoolean[11].u = HX_On.t;
      realToBoolean[12].u = Off[1].t;
      realToBoolean[13].u = Heating[1].t;
      realToBoolean[14].u = Cooling[1].t;
      realToBoolean[15].u = Off[2].t;
      realToBoolean[16].u = Heating[2].t;
      realToBoolean[17].u = Cooling[2].t;
      realToBoolean[18].u = Off[3].t;
      realToBoolean[19].u = Heating[3].t;
      realToBoolean[20].u = Cooling[3].t;
      realToBoolean[21].u = Off[4].t;
      realToBoolean[22].u = Heating[4].t;
      realToBoolean[23].u = Cooling[4].t;
      realToBoolean[24].u = Off[5].t;
      realToBoolean[25].u = Heating[5].t;
      realToBoolean[26].u = Cooling[5].t;
      realToBoolean[27].u = Off[6].t;
      realToBoolean[28].u = Heating[6].t;
      realToBoolean[29].u = Cooling[6].t;
      connect(T121[6].outPlaces[1], Heating[6].inTransition[1]) annotation(
        Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
      connect(T120[6].inPlaces[1], Heating[6].outTransition[1]) annotation(
        Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
      connect(Cooling[6].outTransition[1], T119[6].inPlaces[1]) annotation(
        Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
      connect(T118[6].outPlaces[1], Cooling[6].inTransition[1]) annotation(
        Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
      connect(T119[6].outPlaces[1], Off[6].inTransition[2]) annotation(
        Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[6].outTransition[2], T118[6].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
      connect(T120[6].outPlaces[1], Off[6].inTransition[1]) annotation(
        Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[6].outTransition[1], T121[6].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
      connect(T121[5].outPlaces[1], Heating[5].inTransition[1]) annotation(
        Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
      connect(T120[5].inPlaces[1], Heating[5].outTransition[1]) annotation(
        Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
      connect(Cooling[5].outTransition[1], T119[5].inPlaces[1]) annotation(
        Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
      connect(T118[5].outPlaces[1], Cooling[5].inTransition[1]) annotation(
        Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
      connect(T119[5].outPlaces[1], Off[5].inTransition[2]) annotation(
        Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[5].outTransition[2], T118[5].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
      connect(T120[5].outPlaces[1], Off[5].inTransition[1]) annotation(
        Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[5].outTransition[1], T121[5].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
      connect(T121[4].outPlaces[1], Heating[4].inTransition[1]) annotation(
        Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
      connect(T120[4].inPlaces[1], Heating[4].outTransition[1]) annotation(
        Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
      connect(Cooling[4].outTransition[1], T119[4].inPlaces[1]) annotation(
        Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
      connect(T118[4].outPlaces[1], Cooling[4].inTransition[1]) annotation(
        Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
      connect(T119[4].outPlaces[1], Off[4].inTransition[2]) annotation(
        Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[4].outTransition[2], T118[4].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
      connect(T120[4].outPlaces[1], Off[4].inTransition[1]) annotation(
        Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[4].outTransition[1], T121[4].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
      connect(T121[3].outPlaces[1], Heating[3].inTransition[1]) annotation(
        Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
      connect(T120[3].inPlaces[1], Heating[3].outTransition[1]) annotation(
        Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
      connect(Cooling[3].outTransition[1], T119[3].inPlaces[1]) annotation(
        Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
      connect(T118[3].outPlaces[1], Cooling[3].inTransition[1]) annotation(
        Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
      connect(T119[3].outPlaces[1], Off[3].inTransition[2]) annotation(
        Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[3].outTransition[2], T118[3].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
      connect(T120[3].outPlaces[1], Off[3].inTransition[1]) annotation(
        Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[3].outTransition[1], T121[3].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
      connect(T121[2].outPlaces[1], Heating[2].inTransition[1]) annotation(
        Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
      connect(T120[2].inPlaces[1], Heating[2].outTransition[1]) annotation(
        Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
      connect(Cooling[2].outTransition[1], T119[2].inPlaces[1]) annotation(
        Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
      connect(T118[2].outPlaces[1], Cooling[2].inTransition[1]) annotation(
        Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
      connect(T119[2].outPlaces[1], Off[2].inTransition[2]) annotation(
        Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[2].outTransition[2], T118[2].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
      connect(T120[2].outPlaces[1], Off[2].inTransition[1]) annotation(
        Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[2].outTransition[1], T121[2].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
      connect(T121[1].outPlaces[1], Heating[1].inTransition[1]) annotation(
        Line(points = {{58, 0}, {72, 0}, {72, -2}, {72, -2}}, thickness = 0.5));
      connect(T120[1].inPlaces[1], Heating[1].outTransition[1]) annotation(
        Line(points = {{58, -14}, {72, -14}, {72, -14}, {72, -14}}, thickness = 0.5));
      connect(Cooling[1].outTransition[1], T119[1].inPlaces[1]) annotation(
        Line(points = {{4, -14}, {18, -14}, {18, -14}, {18, -14}}, thickness = 0.5));
      connect(T118[1].outPlaces[1], Cooling[1].inTransition[1]) annotation(
        Line(points = {{18, 0}, {4, 0}, {4, -2}, {4, -2}}, thickness = 0.5));
      connect(T119[1].outPlaces[1], Off[1].inTransition[2]) annotation(
        Line(points = {{24, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[1].outTransition[2], T118[1].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {24, -2}, {24, 0}, {24, 0}}, thickness = 0.5));
      connect(T120[1].outPlaces[1], Off[1].inTransition[1]) annotation(
        Line(points = {{52, -14}, {38, -14}, {38, -14}, {38, -14}}, thickness = 0.5));
      connect(Off[1].outTransition[1], T121[1].inPlaces[1]) annotation(
        Line(points = {{38, -2}, {52, -2}, {52, 0}, {52, 0}}, thickness = 0.5));
      connect(HTS_Heating_I.outTransition[2], T14.inPlaces[1]) annotation(
        Line(points = {{-54, 78}, {-46, 78}, {-46, 60}, {-46, 60}, {-46, 60}}, thickness = 0.5));
      connect(T15.outPlaces[1], HTS_Heating_I.inTransition[2]) annotation(
        Line(points = {{-60, 60}, {-62, 60}, {-62, 66}, {-54, 66}, {-54, 66}}, thickness = 0.5));
      connect(HTS_Heating_I.outTransition[1], T1.inPlaces[1]) annotation(
        Line(points = {{-54, 78}, {-70, 78}, {-70, 80}, {-70, 80}}, thickness = 0.5));
      connect(T11.outPlaces[1], HTS_Heating_I.inTransition[2]) annotation(
        Line(points = {{-70, 66}, {-54, 66}, {-54, 66}, {-54, 66}}, thickness = 0.5));
      connect(T15.inPlaces[1], HTS_Heating_II.outTransition[2]) annotation(
        Line(points = {{-60, 54}, {-62, 54}, {-62, 38}, {-54, 38}, {-54, 38}}, thickness = 0.5));
      connect(T14.outPlaces[1], HTS_Heating_II.inTransition[2]) annotation(
        Line(points = {{-46, 54}, {-48, 54}, {-48, 52}, {-54, 52}, {-54, 52}, {-54, 52}, {-54, 50}}, thickness = 0.5));
      connect(T13.inPlaces[1], HTS_Heating_II.outTransition[1]) annotation(
        Line(points = {{-70, 38}, {-54, 38}, {-54, 38}, {-54, 38}}, thickness = 0.5));
      connect(T12.outPlaces[1], HTS_Heating_II.inTransition[1]) annotation(
        Line(points = {{-70, 52}, {-54, 52}, {-54, 50}, {-54, 50}}, thickness = 0.5));
      connect(HTS_Off.inTransition[2], T13.outPlaces[1]) annotation(
        Line(points = {{-94, 58}, {-94, 58}, {-94, 36}, {-76, 36}, {-76, 38}}, thickness = 0.5));
      connect(HTS_Off.inTransition[1], T1.outPlaces[1]) annotation(
        Line(points = {{-94, 58}, {-94, 58}, {-94, 80}, {-76, 80}, {-76, 80}}, thickness = 0.5));
      connect(GTF_On.inTransition[1], T114.outPlaces[1]) annotation(
        Line(points = {{-76, -32}, {-74, -32}, {-74, -18}, {-74, -18}}, thickness = 0.5));
      connect(GTF_On.outTransition[1], T115.inPlaces[1]) annotation(
        Line(points = {{-88, -32}, {-90, -32}, {-90, -18}, {-88, -18}}, thickness = 0.5));
      connect(GTF_Off.outTransition[1], T114.inPlaces[1]) annotation(
        Line(points = {{-76, 0}, {-76, 0}, {-76, -12}, {-74, -12}}, thickness = 0.5));
      connect(T115.outPlaces[1], GTF_Off.inTransition[1]) annotation(
        Line(points = {{-88, -12}, {-88, -12}, {-88, 0}, {-88, 0}}, thickness = 0.5));
      connect(HX_On.outTransition[1], T116.inPlaces[1]) annotation(
        Line(points = {{-48, -32}, {-50, -32}, {-50, -18}, {-50, -18}, {-50, -18}, {-48, -18}}, thickness = 0.5));
      connect(T117.outPlaces[1], HX_On.inTransition[1]) annotation(
        Line(points = {{-34, -18}, {-34, -18}, {-34, -32}, {-36, -32}, {-36, -32}, {-36, -32}}, thickness = 0.5));
      connect(HX_Off.outTransition[1], T117.inPlaces[1]) annotation(
        Line(points = {{-36, 0}, {-34, 0}, {-34, -12}, {-34, -12}, {-34, -12}}, thickness = 0.5));
      connect(T116.outPlaces[1], HX_Off.inTransition[1]) annotation(
        Line(points = {{-48, -12}, {-48, -12}, {-48, 0}, {-48, 0}}, thickness = 0.5));
      connect(HP_Heating_I.outTransition[2], T19.inPlaces[1]) annotation(
        Line(points = {{78, 80}, {86, 80}, {86, 62}, {86, 62}, {86, 62}}, thickness = 0.5));
      connect(T18.outPlaces[1], HP_Heating_I.inTransition[2]) annotation(
        Line(points = {{72, 62}, {70, 62}, {70, 68}, {78, 68}, {78, 68}, {78, 68}}, thickness = 0.5));
      connect(T18.inPlaces[1], HP_Heating_II.outTransition[2]) annotation(
        Line(points = {{72, 56}, {70, 56}, {70, 40}, {78, 40}, {78, 40}}, thickness = 0.5));
      connect(T19.outPlaces[1], HP_Heating_II.inTransition[2]) annotation(
        Line(points = {{86, 56}, {86, 56}, {86, 54}, {78, 54}, {78, 52}, {78, 52}}, thickness = 0.5));
      connect(T17.outPlaces[1], HP_Heating_II.inTransition[1]) annotation(
        Line(points = {{62, 54}, {78, 54}, {78, 52}, {78, 52}}, thickness = 0.5));
      connect(T16.inPlaces[1], HP_Heating_II.outTransition[1]) annotation(
        Line(points = {{62, 40}, {78, 40}, {78, 40}, {78, 40}}, thickness = 0.5));
      connect(T110.outPlaces[1], HP_Heating_I.inTransition[1]) annotation(
        Line(points = {{62, 68}, {78, 68}, {78, 68}, {78, 68}}, thickness = 0.5));
      connect(HP_Heating_I.outTransition[1], T111.inPlaces[1]) annotation(
        Line(points = {{78, 80}, {62, 80}, {62, 82}, {62, 82}}, thickness = 0.5));
      connect(T113.outPlaces[1], HP_Off.inTransition[3]) annotation(
        Line(points = {{32, 54}, {36, 54}, {36, 60}, {36, 60}, {36, 60}, {38, 60}}, thickness = 0.5));
      connect(T16.outPlaces[1], HP_Off.inTransition[2]) annotation(
        Line(points = {{56, 40}, {36, 40}, {36, 60}, {36, 60}, {36, 60}, {38, 60}}, thickness = 0.5));
      connect(HP_Off.inTransition[1], T111.outPlaces[1]) annotation(
        Line(points = {{38, 60}, {36, 60}, {36, 80}, {56, 80}, {56, 82}, {56, 82}}, thickness = 0.5));
      connect(HP_Off.outTransition[3], T112.inPlaces[1]) annotation(
        Line(points = {{50, 60}, {52, 60}, {52, 68}, {32, 68}, {32, 68}, {32, 68}}, thickness = 0.5));
      connect(HP_Off.outTransition[2], T17.inPlaces[1]) annotation(
        Line(points = {{50, 60}, {52, 60}, {52, 52}, {56, 52}, {56, 54}, {56, 54}}, thickness = 0.5));
      connect(HP_Off.outTransition[1], T110.inPlaces[1]) annotation(
        Line(points = {{50, 60}, {52, 60}, {52, 68}, {56, 68}, {56, 68}}, thickness = 0.5));
      connect(HP_Cooling.outTransition[1], T113.inPlaces[1]) annotation(
        Line(points = {{14, 54}, {26, 54}}, thickness = 0.5));
      connect(T112.outPlaces[1], HP_Cooling.inTransition[1]) annotation(
        Line(points = {{26, 68}, {20, 68}, {20, 66}, {14, 66}}, thickness = 0.5));
      connect(HTS_Off.outTransition[2], T12.inPlaces[1]) annotation(
        Line(points = {{-82, 58}, {-80, 58}, {-80, 50}, {-76, 50}, {-76, 52}, {-76, 52}}, thickness = 0.5));
      connect(HTS_Off.outTransition[1], T11.inPlaces[1]) annotation(
        Line(points = {{-82, 58}, {-80, 58}, {-80, 66}, {-76, 66}, {-76, 66}, {-76, 66}}, thickness = 0.5));
      annotation(
        uses(PNlib(version = "2.2"), Modelica(version = "3.2.3")),
        Diagram(graphics = {Text(origin = {-69, 93}, extent = {{-21, 5}, {13, -3}}, textString = "HTS_System"), Text(origin = {59, 93}, extent = {{-21, 5}, {13, -3}}, textString = "HP_System"), Text(origin = {-75, 15}, extent = {{-21, 5}, {13, -3}}, textString = "GTF_System"), Text(origin = {-39, 15}, extent = {{-21, 5}, {13, -3}}, textString = "HX"), Text(origin = {45, 17}, extent = {{-21, 5}, {13, -3}}, textString = "Senken")}, coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        Icon(graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-200, 100}, {200, -100}}), Text(origin = {-110, 34}, extent = {{-42, 12}, {250, -78}}, textString = "Automatisierungsebene")}, coordinateSystem(extent = {{-200, -100}, {200, 100}}, initialScale = 0.1)),
        __OpenModelica_commandLineOptions = "",
        Documentation(info = "<html><head></head><body>Struktur Output-Vektor<div><br></div><div>HTS_Off</div><div>HTS_Heating_I</div><div>HTS_Heating_II</div><div><br></div><div>HP_Off</div><div>HP_Heating_I</div><div>HP_Heating_II</div><div>HP_Cooling</div><div><br></div><div>GTF_Off</div><div>GTF_On</div><div><br></div><div>HX_Off</div><div>HX_On</div><div><br></div><div>Off[1]</div><div>Heating[1]</div><div>Cooling[1]</div><div><br></div><div><div>Off[2]</div><div>Heating[2]</div><div>Cooling[2]</div></div><div><br></div><div><div>Off[3]</div><div>Heating[3]</div><div>Cooling[3]</div></div><div><br></div><div><div>Off[4]</div><div>Heating[4]</div><div>Cooling[4]</div></div><div><br></div><div><div>Off[5]</div><div>Heating[5]</div><div>Cooling[5]</div></div><div><br></div><div><div>Off[6]</div><div>Heating[6]</div><div>Cooling[6]</div></div><div><br></div><div>(Off/Heating/Cooling 1-5 bestimmen den Betriebsmodus der VU/Tabs Module der Räume</div><div>Off/Heating/Cooling 6 bestimmt den Betriebsmodus der zentralen AHU unit)</div></body></html>"));
    end AutomationLevel_MODImethod;

    model AutomatisierungsebeneV2
      PNlib.Components.PD RLT_Heating_I[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-44, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T11[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-80, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD RLT_Cooling_I[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-212, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T16[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-174, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.PD RLT_Heating_Off[6](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(extent = {{-120, 78}, {-100, 98}}, rotation = 0)));
      PNlib.Components.PD RLT_Heating_II[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-44, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T1[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-80, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T12[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-80, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T13[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-80, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T15[6](each nIn = 1, each nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {-34, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T14[6](each nIn = 1, each nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {-54, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PNlib.Components.PD RLT_Cooling_Off[6](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-146, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD RLT_Cooling_II[6](each nIn = 2, each nOut = 2, each startTokens = 0, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-212, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T17[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-174, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T18[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-174, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T19[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-174, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T110[6](each nIn = 1, each nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {-222, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T111[6](each nIn = 1, each nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {-202, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PNlib.Components.T T113[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-172, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T114[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-172, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T115[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-78, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.PD BKT_Cooling_II[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-210, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T116[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-200, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PNlib.Components.T T117[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-220, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T118[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-52, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PNlib.Components.T T119[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-30, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.PD BKT_Off[5](each nIn = 4, each nOut = 4, each startTokens = 1, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-126, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T120[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-172, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T121[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-78, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.PD BKT_Cooling_I[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-210, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.PD BKT_Heating_I[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-42, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T122[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-172, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T123[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-78, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T112[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {-78, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD BKT_Heating_II[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-42, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T1133(nIn = 1, nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {68, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T1135(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {94, 74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PNlib.Components.T T1136(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {114, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.PD Generation_Hot_Off(nIn = 2, nOut = 2, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
        Placement(visible = true, transformation(extent = {{28, 64}, {48, 84}}, rotation = 0)));
      PNlib.Components.PD Generation_Hot_II(nIn = 2, nOut = 2, maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {104, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T1139(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {68, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T1141(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {68, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T1143(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {68, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD Generation_Hot_I(nIn = 2, nOut = 2, maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {104, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD Generation_Warm_Off(nIn = 1, nOut = 1, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {166, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      PNlib.Components.T T1151(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {196, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.PD Generation_Warm_On(nIn = 1, nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {226, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T1153(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {196, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD Generation_Cold_Off(nIn = 3, nOut = 3, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {44, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T2(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {74, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.PD Generation_Cold_II(nIn = 3, nOut = 3, maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {106, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T3(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {74, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T6(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {74, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.PD Generation_Cold_I(nIn = 3, nOut = 3, maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {108, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T7(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {74, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T T9(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {74, -132}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD Generation_Cold_III(nIn = 3, nOut = 3, maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {104, -126}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      PNlib.Components.T T10(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {74, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T T4(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {98, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T5(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {118, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      PNlib.Components.T T8(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {94, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T20(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {114, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      PNlib.Components.T T23(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {148, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T T24(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation(
        Placement(visible = true, transformation(origin = {168, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealInput u[15] annotation(
        Placement(visible = true, transformation(origin = {-2.22045e-16, 164}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {-2.22045e-16, 164}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y[70] annotation(
        Placement(visible = true, transformation(origin = {0, -160}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      y[1] = RLT_Heating_Off[1].t;
      y[2] = RLT_Heating_I[1].t;
      y[3] = RLT_Heating_II[1].t;
      y[4] = RLT_Cooling_Off[1].t;
      y[5] = RLT_Cooling_I[1].t;
      y[6] = RLT_Cooling_II[1].t;
      y[7] = BKT_Heating_Off[1].t;
      y[8] = BKT_Heating_I[1].t;
      y[9] = BKT_Heating_II[1].t;
      y[10] = BKT_Cooling_I[1].t;
      y[11] = BKT_Cooling_II[1].t;
      y[12] = RLT_Heating_Off[2].t;
      y[13] = RLT_Heating_I[2].t;
      y[14] = RLT_Heating_II[2].t;
      y[15] = RLT_Cooling_Off[2].t;
      y[16] = RLT_Cooling_I[2].t;
      y[17] = RLT_Cooling_II[2].t;
      y[18] = BKT_Heating_Off[2].t;
      y[18] = BKT_Heating_I[2].t;
      y[20] = BKT_Heating_II[2].t;
      y[21] = BKT_Cooling_I[2].t;
      y[22] = BKT_Cooling_II[2].t;
      y[23] = RLT_Heating_Off[3].t;
      y[24] = RLT_Heating_I[3].t;
      y[25] = RLT_Heating_II[3].t;
      y[26] = RLT_Cooling_Off[3].t;
      y[27] = RLT_Cooling_I[3].t;
      y[28] = RLT_Cooling_II[3].t;
      y[29] = BKT_Heating_Off[3].t;
      y[30] = BKT_Heating_I[3].t;
      y[31] = BKT_Heating_II[3].t;
      y[32] = BKT_Cooling_I[3].t;
      y[33] = BKT_Cooling_II[3].t;
      y[34] = RLT_Heating_Off[4].t;
      y[35] = RLT_Heating_I[4].t;
      y[36] = RLT_Heating_II[4].t;
      y[37] = RLT_Cooling_Off[4].t;
      y[38] = RLT_Cooling_I[4].t;
      y[39] = RLT_Cooling_II[4].t;
      y[40] = BKT_Heating_Off[4].t;
      y[41] = BKT_Heating_I[4].t;
      y[42] = BKT_Heating_II[4].t;
      y[43] = BKT_Cooling_I[4].t;
      y[44] = BKT_Cooling_II[4].t;
      y[45] = RLT_Heating_Off[5].t;
      y[46] = RLT_Heating_I[5].t;
      y[47] = RLT_Heating_II[5].t;
      y[48] = RLT_Cooling_Off[5].t;
      y[49] = RLT_Cooling_I[5].t;
      y[50] = RLT_Cooling_II[5].t;
      y[51] = BKT_Heating_Off[5].t;
      y[52] = BKT_Heating_I[5].t;
      y[53] = BKT_Heating_II[5].t;
      y[54] = BKT_Cooling_I[5].t;
      y[55] = BKT_Cooling_II[5].t;
      y[56] = RLT_Heating_Off[6].t;
      y[57] = RLT_Heating_I[6].t;
      y[58] = RLT_Heating_II[6].t;
      y[59] = RLT_Cooling_Off[6].t;
      y[60] = RLT_Cooling_I[6].t;
      y[61] = RLT_Cooling_II[6].t;
      y[62] = Generation_Hot_Off.t;
      y[63] = Generation_Hot_I.t;
      y[64] = Generation_Hot_II.t;
      y[65] = Generation_Warm_Off.t;
      y[66] = Generation_Warm_I.t;
      y[67] = Generation_Warm_II.t;
      y[68] = Generation_Cold_Off.t;
      y[69] = Generation_Cold_I.t;
      y[70] = Generation_Cold_II.t;
      connect(T1153.outPlaces[1], Generation_Warm_Off.inTransition[1]) annotation(
        Line(points = {{191.2, 84}, {184.9, 84}, {184.9, 82}, {178.6, 82}, {178.6, 82}, {166, 82}, {166, 78.8}, {166, 78.8}, {166, 80.8}, {166, 80.8}}, thickness = 0.5));
      connect(Generation_Warm_On.outTransition[1], T1153.inPlaces[1]) annotation(
        Line(points = {{226, 80.8}, {221, 80.8}, {221, 80.8}, {216, 80.8}, {216, 84}, {200.8, 84}}, thickness = 0.5));
      connect(T1151.outPlaces[1], Generation_Warm_On.inTransition[1]) annotation(
        Line(points = {{200.8, 64}, {203.4, 64}, {203.4, 64}, {206, 64}, {206, 60}, {218, 60}, {218, 59.2}, {226, 59.2}}, thickness = 0.5));
      connect(Generation_Warm_Off.outTransition[1], T1151.inPlaces[1]) annotation(
        Line(points = {{166, 59.2}, {177, 59.2}, {177, 57.2}, {188, 57.2}, {188, 62}, {190, 62}, {190, 64}, {190.6, 64}, {190.6, 64}, {191.2, 64}}, thickness = 0.5));
      connect(Generation_Hot_I.outTransition[1], T1143.inPlaces[1]) annotation(
        Line(points = {{93.2, 96}, {89.6, 96}, {89.6, 98}, {88, 98}, {88, 103.5}, {80.4, 103.5}, {80.4, 103.5}, {72.8, 103.5}}, thickness = 0.5));
      connect(T1133.outPlaces[1], Generation_Hot_I.inTransition[1]) annotation(
        Line(points = {{72.8, 84}, {120, 84}, {120, 96}, {116, 96}, {116, 94.5}, {114.4, 94.5}, {114.4, 96.5}, {114.8, 96.5}}, thickness = 0.5));
      connect(T1136.outPlaces[1], Generation_Hot_I.inTransition[2]) annotation(
        Line(points = {{114, 78.8}, {114, 84}, {120, 84}, {120, 95.5}, {114.8, 95.5}}, thickness = 0.5));
      connect(Generation_Hot_I.outTransition[2], T1135.inPlaces[1]) annotation(
        Line(points = {{93.2, 96}, {91.4, 96}, {91.4, 92}, {89.6, 92}, {89.6, 90}, {88, 90}, {88, 78.5}, {94, 78.5}, {94, 77.9}, {94, 77.9}, {94, 79.3}}, thickness = 0.5));
      connect(T1143.outPlaces[1], Generation_Hot_Off.inTransition[1]) annotation(
        Line(points = {{63.2, 104}, {24, 104}, {24, 74}, {26, 74}, {26, 73.5}, {27.2, 73.5}}, thickness = 0.5));
      connect(T1141.outPlaces[1], Generation_Hot_Off.inTransition[2]) annotation(
        Line(points = {{63.2, 44}, {24, 44}, {24, 74}, {26, 74}, {26, 74.5}, {27.2, 74.5}}, thickness = 0.5));
      connect(Generation_Hot_II.outTransition[1], T1141.inPlaces[1]) annotation(
        Line(points = {{114.8, 52}, {115.4, 52}, {115.4, 46}, {118, 46}, {118, 32.5}, {86, 32.5}, {86, 44.5}, {79.4, 44.5}, {79.4, 40.5}, {76.1, 40.5}, {76.1, 44.5}, {72.8, 44.5}}, thickness = 0.5));
      connect(Generation_Hot_Off.outTransition[2], T1139.inPlaces[1]) annotation(
        Line(points = {{48.8, 74}, {51.4, 74}, {51.4, 72}, {54, 72}, {54, 65.5}, {58.6, 65.5}, {58.6, 59.5}, {60.9, 59.5}, {60.9, 63.5}, {63.2, 63.5}}, thickness = 0.5));
      connect(T1139.outPlaces[1], Generation_Hot_II.inTransition[1]) annotation(
        Line(points = {{72.8, 64}, {88, 64}, {88, 52}, {92, 52}, {92, 49.5}, {92.6, 49.5}, {92.6, 47.5}, {92.9, 47.5}, {92.9, 51.5}, {93.2, 51.5}}, thickness = 0.5));
      connect(Generation_Hot_II.outTransition[2], T1136.inPlaces[1]) annotation(
        Line(points = {{114.8, 52}, {115.6, 52}, {115.6, 48}, {116.4, 48}, {116.4, 52}, {118, 52}, {118, 61.5}, {114, 61.5}, {114, 67.1}, {114, 67.1}, {114, 68.7}}, thickness = 0.5));
      connect(T1135.outPlaces[1], Generation_Hot_II.inTransition[2]) annotation(
        Line(points = {{94, 69.2}, {94, 64}, {88, 64}, {88, 52}, {93.2, 52}, {93.2, 52.25}, {93.2, 52.25}, {93.2, 52.5}}, thickness = 0.5));
      connect(Generation_Hot_Off.outTransition[1], T1133.inPlaces[1]) annotation(
        Line(points = {{48.8, 74}, {51.4, 74}, {51.4, 72}, {54, 72}, {54, 84.5}, {58.6, 84.5}, {58.6, 84.5}, {63.2, 84.5}}, thickness = 0.5));
      connect(T24.outPlaces[1], Generation_Cold_III.inTransition[1]) annotation(
        Line(points = {{168, -80.8}, {168, -115.2}, {103.333, -115.2}}));
      connect(Generation_Cold_I.outTransition[3], T24.inPlaces[1]) annotation(
        Line(points = {{108, -3.2}, {110.334, -3.2}, {110.334, -3.2}, {110.667, -3.2}, {110.667, -4}, {176.667, -4}, {176.667, -71.2}, {172.667, -71.2}, {172.667, -71.2}, {168.667, -71.2}}));
      connect(T23.outPlaces[1], Generation_Cold_I.inTransition[3]) annotation(
        Line(points = {{148, -71.2}, {148, -47}, {146, -47}, {146, -24.8}, {127.666, -24.8}, {127.666, -24.8}, {107.333, -24.8}}));
      connect(Generation_Cold_III.outTransition[1], T23.inPlaces[1]) annotation(
        Line(points = {{104, -136.8}, {116.667, -136.8}, {116.667, -138}, {148.667, -138}, {148.667, -109.4}, {148.667, -109.4}, {148.667, -80.8}}));
      connect(T20.outPlaces[1], Generation_Cold_III.inTransition[2]) annotation(
        Line(points = {{114, -106.8}, {114, -104.4}, {112, -104.4}, {112, -110}, {102, -110}, {102, -111.6}, {104, -111.6}, {104, -115.2}}));
      connect(Generation_Cold_II.outTransition[3], T20.inPlaces[1]) annotation(
        Line(points = {{106, -65.2}, {108.334, -65.2}, {108.334, -65.2}, {108.667, -65.2}, {108.667, -64}, {116.667, -64}, {116.667, -97.2}, {116.667, -97.2}, {116.667, -97.2}, {114.667, -97.2}}));
      connect(T8.outPlaces[1], Generation_Cold_II.inTransition[3]) annotation(
        Line(points = {{94, -97.2}, {96, -97.2}, {96, -86.8}, {105.333, -86.8}}));
      connect(Generation_Cold_III.outTransition[2], T8.inPlaces[1]) annotation(
        Line(points = {{104, -136.8}, {102, -136.8}, {102, -136}, {92, -136}, {92, -121.4}, {94, -121.4}, {94, -106.8}}));
      connect(T5.outPlaces[1], Generation_Cold_II.inTransition[1]) annotation(
        Line(points = {{118, -50.8}, {118, -86.8}, {106.667, -86.8}}));
      connect(Generation_Cold_I.outTransition[2], T5.inPlaces[1]) annotation(
        Line(points = {{108, -3.2}, {109, -3.2}, {109, -3.2}, {108, -3.2}, {108, -4}, {126, -4}, {126, -41.2}, {118, -41.2}}));
      connect(T4.outPlaces[1], Generation_Cold_I.inTransition[2]) annotation(
        Line(points = {{98, -41.2}, {98, -24.8}, {108, -24.8}}));
      connect(Generation_Cold_II.outTransition[1], T4.inPlaces[1]) annotation(
        Line(points = {{106, -65.2}, {103.666, -65.2}, {103.666, -65.2}, {101.333, -65.2}, {101.333, -62}, {97.333, -62}, {97.333, -55.4}, {97.333, -55.4}, {97.333, -50.8}}));
      connect(T10.outPlaces[1], Generation_Cold_III.inTransition[3]) annotation(
        Line(points = {{78.8, -112}, {91.7335, -112}, {91.7335, -112}, {102.667, -112}, {102.667, -112.6}, {104.667, -112.6}, {104.667, -115.2}}));
      connect(Generation_Cold_Off.outTransition[3], T10.inPlaces[1]) annotation(
        Line(points = {{54.8, -76}, {54.4, -76}, {54.4, -76}, {54, -76}, {54, -112.667}, {61.6, -112.667}, {61.6, -112.667}, {69.2, -112.667}}));
      connect(Generation_Cold_III.outTransition[3], T9.inPlaces[1]) annotation(
        Line(points = {{104, -136.8}, {99.333, -136.8}, {99.333, -136}, {78.133, -136}, {78.133, -134}, {78.133, -134}, {78.133, -132}}));
      connect(T9.outPlaces[1], Generation_Cold_Off.inTransition[3]) annotation(
        Line(points = {{69.2, -132}, {47.6, -132}, {47.6, -132}, {24, -132}, {24, -75.333}, {29.6, -75.333}, {29.6, -75.333}, {33.2, -75.333}}));
      connect(T7.outPlaces[1], Generation_Cold_Off.inTransition[1]) annotation(
        Line(points = {{69.2, -4}, {47.6, -4}, {47.6, -4}, {26, -4}, {26, -76.667}, {33.2, -76.667}}));
      connect(Generation_Cold_I.outTransition[1], T7.inPlaces[1]) annotation(
        Line(points = {{108, -3.2}, {107.333, -3.2}, {107.333, -2}, {78.133, -2}, {78.133, -3}, {78.133, -3}, {78.133, -4}}));
      connect(T6.outPlaces[1], Generation_Cold_I.inTransition[1]) annotation(
        Line(points = {{78.8, -24}, {93.7335, -24}, {93.7335, -24}, {106.667, -24}, {106.667, -23.4}, {108.667, -23.4}, {108.667, -24.8}}));
      connect(Generation_Cold_Off.outTransition[1], T6.inPlaces[1]) annotation(
        Line(points = {{54.8, -76}, {54.4, -76}, {54.4, -78}, {54, -78}, {54, -25.333}, {61.6, -25.333}, {61.6, -23.333}, {69.2, -23.333}}));
      connect(T3.outPlaces[1], Generation_Cold_Off.inTransition[2]) annotation(
        Line(points = {{69.2, -62}, {47.6, -62}, {47.6, -62}, {24, -62}, {24, -76}, {29.6, -76}, {29.6, -76}, {33.2, -76}}));
      connect(Generation_Cold_II.outTransition[2], T3.inPlaces[1]) annotation(
        Line(points = {{106, -65.2}, {104, -65.2}, {104, -62}, {91.4, -62}, {91.4, -62}, {78.8, -62}}));
      connect(T2.outPlaces[1], Generation_Cold_II.inTransition[2]) annotation(
        Line(points = {{78.8, -82}, {80.4, -82}, {80.4, -82}, {80, -82}, {80, -84}, {106, -84}, {106, -86.8}}));
      connect(Generation_Cold_Off.outTransition[2], T2.inPlaces[1]) annotation(
        Line(points = {{54.8, -76}, {58, -76}, {58, -80}, {69.2, -80}, {69.2, -82}}));
      connect(BKT_Heating_II[5].outTransition[1], T112[5].inPlaces[1]) annotation(
        Line(points = {{-31.2, -34}, {-29.9, -34}, {-29.9, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-69.4, -41.5}, {-69.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
      connect(T118[5].outPlaces[1], BKT_Heating_II[5].inTransition[2]) annotation(
        Line(points = {{-52, -16.8}, {-52, -19.4}, {-52, -19.4}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
      connect(T115[5].outPlaces[1], BKT_Heating_II[5].inTransition[1]) annotation(
        Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-50.4, -34.5}, {-50.4, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
      connect(BKT_Heating_II[5].outTransition[2], T119[5].inPlaces[1]) annotation(
        Line(points = {{-31.2, -34}, {-31.05, -34}, {-31.05, -34}, {-30.9, -34}, {-30.9, -34}, {-30.6, -34}, {-30.6, -34}, {-30, -34}, {-30, -25.75}, {-30, -25.75}, {-30, -22.625}, {-30, -22.625}, {-30, -19.5}}, thickness = 0.5));
      connect(BKT_Heating_II[4].outTransition[1], T112[4].inPlaces[1]) annotation(
        Line(points = {{-31.2, -34}, {-29.4, -34}, {-29.4, -34}, {-29.6, -34}, {-29.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-71.4, -41.5}, {-71.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
      connect(T118[4].outPlaces[1], BKT_Heating_II[4].inTransition[2]) annotation(
        Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.5}}, thickness = 0.5));
      connect(T115[4].outPlaces[1], BKT_Heating_II[4].inTransition[1]) annotation(
        Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
      connect(BKT_Heating_II[3].outTransition[1], T112[3].inPlaces[1]) annotation(
        Line(points = {{-31.2, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-71.4, -41.5}, {-71.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
      connect(T118[3].outPlaces[1], BKT_Heating_II[3].inTransition[2]) annotation(
        Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
      connect(T115[3].outPlaces[1], BKT_Heating_II[3].inTransition[1]) annotation(
        Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
      connect(BKT_Heating_II[2].outTransition[1], T112[2].inPlaces[1]) annotation(
        Line(points = {{-31.2, -34}, {-27.9, -34}, {-27.9, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
      connect(T118[2].outPlaces[1], BKT_Heating_II[2].inTransition[2]) annotation(
        Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
      connect(T115[2].outPlaces[1], BKT_Heating_II[2].inTransition[1]) annotation(
        Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-53.4, -34.5}, {-53.4, -34.5}, {-53.1, -34.5}, {-53.1, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
      connect(BKT_Heating_II[1].outTransition[1], T112[1].inPlaces[1]) annotation(
        Line(points = {{-31.2, -34}, {-27.4, -34}, {-27.4, -34}, {-29.6, -34}, {-29.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
      connect(T118[1].outPlaces[1], BKT_Heating_II[1].inTransition[2]) annotation(
        Line(points = {{-52, -16.8}, {-52, -19.4}, {-52, -19.4}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
      connect(T115[1].outPlaces[1], BKT_Heating_II[1].inTransition[1]) annotation(
        Line(points = {{-73.2, -22}, {-61.6, -22}, {-61.6, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-53.4, -34.5}, {-53.4, -34.5}, {-53.1, -34.5}, {-53.1, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
      connect(T112[5].outPlaces[1], BKT_Off[5].inTransition[2]) annotation(
        Line(points = {{-82.8, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
      connect(T112[4].outPlaces[1], BKT_Off[4].inTransition[2]) annotation(
        Line(points = {{-82.8, -42}, {-114.4, -42}, {-114.4, -42}, {-144, -42}, {-144, -22.8}, {-134.875, -22.8}, {-134.875, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
      connect(T112[3].outPlaces[1], BKT_Off[3].inTransition[2]) annotation(
        Line(points = {{-82.8, -42}, {-113.4, -42}, {-113.4, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
      connect(T112[2].outPlaces[1], BKT_Off[2].inTransition[2]) annotation(
        Line(points = {{-82.8, -42}, {-113.4, -42}, {-113.4, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
      connect(T112[1].outPlaces[1], BKT_Off[1].inTransition[2]) annotation(
        Line(points = {{-82.8, -42}, {-144, -42}, {-144, -22.8}, {-134.875, -22.8}, {-134.875, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
      connect(BKT_Heating_I[5].outTransition[1], T123[5].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-54.1, 10}, {-54.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
      connect(T123[5].outPlaces[1], BKT_Off[5].inTransition[1]) annotation(
        Line(points = {{-82.8, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
      connect(BKT_Heating_I[4].outTransition[1], T123[4].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-69.4, 17.5}, {-69.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
      connect(T123[4].outPlaces[1], BKT_Off[4].inTransition[1]) annotation(
        Line(points = {{-82.8, 18}, {-90.45, 18}, {-90.45, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
      connect(BKT_Heating_I[3].outTransition[1], T123[3].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-70.4, 17.5}, {-70.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
      connect(T123[3].outPlaces[1], BKT_Off[3].inTransition[1]) annotation(
        Line(points = {{-82.8, 18}, {-97.1, 18}, {-97.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-129.938, -22.8}, {-129.938, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
      connect(BKT_Heating_I[2].outTransition[1], T123[2].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-66.6, 17.5}, {-66.6, 17.5}, {-70.9, 17.5}, {-70.9, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
      connect(T123[2].outPlaces[1], BKT_Off[2].inTransition[1]) annotation(
        Line(points = {{-82.8, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-129.938, -22.8}, {-129.938, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
      connect(BKT_Heating_I[1].outTransition[1], T123[1].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-70.4, 17.5}, {-70.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
      connect(T123[1].outPlaces[1], BKT_Off[1].inTransition[1]) annotation(
        Line(points = {{-82.8, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
      connect(T122[5].outPlaces[1], BKT_Off[5].inTransition[4]) annotation(
        Line(points = {{-167.2, 18}, {-144, 18}, {-144, -22.8}, {-126.75, -22.8}}));
      connect(BKT_Cooling_I[5].outTransition[1], T122[5].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-198.05, 10}, {-198.05, 10}, {-196.9, 10}, {-196.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
      connect(T122[4].outPlaces[1], BKT_Off[4].inTransition[4]) annotation(
        Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-135.375, -22.8}, {-135.375, -22.8}, {-131.062, -22.8}, {-131.062, -22.8}, {-126.75, -22.8}}));
      connect(BKT_Cooling_I[4].outTransition[1], T122[4].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-197.9, 10}, {-197.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-178.95, 18.5}, {-178.95, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
      connect(T122[3].outPlaces[1], BKT_Off[3].inTransition[4]) annotation(
        Line(points = {{-167.2, 18}, {-160.9, 18}, {-160.9, 18}, {-154.6, 18}, {-154.6, 18}, {-144, 18}, {-144, -22.8}, {-132.375, -22.8}, {-132.375, -22.8}, {-126.75, -22.8}}));
      connect(BKT_Cooling_I[3].outTransition[1], T122[3].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-198.9, 10}, {-198.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
      connect(T122[2].outPlaces[1], BKT_Off[2].inTransition[4]) annotation(
        Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-135.375, -22.8}, {-135.375, -22.8}, {-130.062, -22.8}, {-130.062, -22.8}, {-128.406, -22.8}, {-128.406, -22.8}, {-126.75, -22.8}}));
      connect(BKT_Cooling_I[2].outTransition[1], T122[2].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-194.9, 10}, {-194.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
      connect(T122[1].outPlaces[1], BKT_Off[1].inTransition[4]) annotation(
        Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-126.75, -22.8}}));
      connect(BKT_Cooling_I[1].outTransition[1], T122[1].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-198.05, 10}, {-198.05, 10}, {-196.9, 10}, {-196.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-178.1, 18.5}, {-178.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
      connect(T121[5].outPlaces[1], BKT_Heating_I[5].inTransition[1]) annotation(
        Line(points = {{-73.2, -2}, {-50.6, -2}, {-50.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 11.25}, {-31.2, 11.25}, {-31.2, 10.875}, {-31.2, 10.875}, {-31.2, 10.5}}, thickness = 0.5));
      connect(BKT_Heating_I[5].outTransition[2], T118[5].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
      connect(T119[5].outPlaces[1], BKT_Heating_I[5].inTransition[2]) annotation(
        Line(points = {{-30, -9.2}, {-30, 0.0499998}, {-30, 0.0499998}, {-30, 9.3}, {-30.6, 9.3}, {-30.6, 9.3}, {-30.9, 9.3}, {-30.9, 9.3}, {-31.2, 9.3}}, thickness = 0.5));
      connect(T121[4].outPlaces[1], BKT_Heating_I[4].inTransition[1]) annotation(
        Line(points = {{-73.2, -2}, {-47.6, -2}, {-47.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.25}, {-31.2, 10.25}, {-31.2, 10.5}}, thickness = 0.5));
      connect(BKT_Heating_I[4].outTransition[2], T118[4].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-54.1, 10}, {-54.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
      connect(T121[3].outPlaces[1], BKT_Heating_I[3].inTransition[1]) annotation(
        Line(points = {{-73.2, -2}, {-49.6, -2}, {-49.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 11.25}, {-31.2, 11.25}, {-31.2, 10.5}}, thickness = 0.5));
      connect(BKT_Heating_I[3].outTransition[2], T118[3].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -4.1}, {-52, -4.1}, {-52, -6.7}}, thickness = 0.5));
      connect(T121[2].outPlaces[1], BKT_Heating_I[2].inTransition[1]) annotation(
        Line(points = {{-73.2, -2}, {-58.9, -2}, {-58.9, -2}, {-50.6, -2}, {-50.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.5}}, thickness = 0.5));
      connect(BKT_Heating_I[2].outTransition[2], T118[2].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -4.1}, {-52, -4.1}, {-52, -6.7}}, thickness = 0.5));
      connect(T121[1].outPlaces[1], BKT_Heating_I[1].inTransition[1]) annotation(
        Line(points = {{-73.2, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.25}, {-31.2, 10.25}, {-31.2, 10.5}}, thickness = 0.5));
      connect(BKT_Heating_I[1].outTransition[2], T118[1].inPlaces[1]) annotation(
        Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
      connect(T120[5].outPlaces[1], BKT_Cooling_I[5].inTransition[1]) annotation(
        Line(points = {{-176.8, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.75}, {-220.8, 9.75}, {-220.8, 9.625}, {-220.8, 9.625}, {-220.8, 9.5}}, thickness = 0.5));
      connect(T117[5].outPlaces[1], BKT_Cooling_I[5].inTransition[2]) annotation(
        Line(points = {{-220, -7.2}, {-220, -4.6}, {-220, -4.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
      connect(BKT_Cooling_I[5].outTransition[2], T116[5].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-197.9, 10}, {-197.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -5.1}, {-200, -5.1}, {-200, -6.4}, {-200, -6.4}, {-200, -7.7}}, thickness = 0.5));
      connect(T120[4].outPlaces[1], BKT_Cooling_I[4].inTransition[1]) annotation(
        Line(points = {{-176.8, -2}, {-203.4, -2}, {-203.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.75}, {-220.8, 9.75}, {-220.8, 10.625}, {-220.8, 10.625}, {-220.8, 9.5}}, thickness = 0.5));
      connect(T117[4].outPlaces[1], BKT_Cooling_I[4].inTransition[2]) annotation(
        Line(points = {{-220, -7.2}, {-220, -5.4}, {-220, -5.4}, {-220, -3.6}, {-220, -3.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 11.25}, {-220.8, 11.25}, {-220.8, 10.5}}, thickness = 0.5));
      connect(BKT_Cooling_I[4].outTransition[2], T116[4].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-198.4, 10}, {-198.4, 10}, {-197.6, 10}, {-197.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, 5.9}, {-200, 5.9}, {-200, -0.900002}, {-200, -0.900002}, {-200, -7.7}}, thickness = 0.5));
      connect(T120[3].outPlaces[1], BKT_Cooling_I[3].inTransition[1]) annotation(
        Line(points = {{-176.8, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.5}}, thickness = 0.5));
      connect(T117[3].outPlaces[1], BKT_Cooling_I[3].inTransition[2]) annotation(
        Line(points = {{-220, -7.2}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
      connect(BKT_Cooling_I[3].outTransition[2], T116[3].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-198.4, 10}, {-198.4, 10}, {-197.6, 10}, {-197.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -4.1}, {-200, -4.1}, {-200, -5.9}, {-200, -5.9}, {-200, -7.7}}, thickness = 0.5));
      connect(T120[2].outPlaces[1], BKT_Cooling_I[2].inTransition[1]) annotation(
        Line(points = {{-176.8, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.5}}, thickness = 0.5));
      connect(T117[2].outPlaces[1], BKT_Cooling_I[2].inTransition[2]) annotation(
        Line(points = {{-220, -7.2}, {-220, -3.6}, {-220, -3.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
      connect(BKT_Cooling_I[2].outTransition[2], T116[2].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-198.9, 10}, {-198.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -5.1}, {-200, -5.1}, {-200, -6.4}, {-200, -6.4}, {-200, -7.05}, {-200, -7.05}, {-200, -7.7}}, thickness = 0.5));
      connect(T120[1].outPlaces[1], BKT_Cooling_I[1].inTransition[1]) annotation(
        Line(points = {{-176.8, -2}, {-189.6, -2}, {-189.6, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.75}, {-220.8, 10.75}, {-220.8, 10.125}, {-220.8, 10.125}, {-220.8, 9.5}}, thickness = 0.5));
      connect(T117[1].outPlaces[1], BKT_Cooling_I[1].inTransition[2]) annotation(
        Line(points = {{-220, -7.2}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 11.25}, {-220.8, 11.25}, {-220.8, 10.5}}, thickness = 0.5));
      connect(BKT_Cooling_I[1].outTransition[2], T116[1].inPlaces[1]) annotation(
        Line(points = {{-199.2, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -4.1}, {-200, -4.1}, {-200, -7.7}}, thickness = 0.5));
      connect(BKT_Off[5].outTransition[1], T121[5].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-87.15, -2}, {-87.15, -2}, {-85.35, -2}, {-85.35, -2}, {-83.55, -2}}, thickness = 0.5));
      connect(BKT_Off[4].outTransition[1], T121[4].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-85.85, -2}, {-85.85, -2}, {-83.55, -2}}, thickness = 0.5));
      connect(BKT_Off[3].outTransition[1], T121[3].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-109.375, -1.2}, {-109.375, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-82.85, -2}, {-82.85, -2}, {-83.55, -2}}, thickness = 0.5));
      connect(BKT_Off[2].outTransition[1], T121[2].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-84.85, -2}, {-84.85, -2}, {-83.55, -2}}, thickness = 0.5));
      connect(BKT_Off[1].outTransition[1], T121[1].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-83.55, -2}}, thickness = 0.5));
      connect(BKT_Off[5].outTransition[3], T120[5].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
      connect(BKT_Off[4].outTransition[3], T120[4].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-126.875, -1.2}, {-126.875, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -1.5}, {-166.95, -1.5}, {-166.95, -2}}));
      connect(BKT_Off[3].outTransition[3], T120[3].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
      connect(BKT_Off[2].outTransition[3], T120[2].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
      connect(BKT_Off[1].outTransition[3], T120[1].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-125.938, -1.2}, {-125.938, -1.2}, {-125.875, -1.2}, {-125.875, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
      connect(T113[5].outPlaces[1], BKT_Off[5].inTransition[3]) annotation(
        Line(points = {{-167.2, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
      connect(BKT_Off[5].outTransition[4], T114[5].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-166.45, -22}}));
      connect(BKT_Off[5].outTransition[2], T115[5].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-109.125, -1.2}, {-109.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-85.35, -22}, {-85.35, -22}, {-85.2, -22}, {-85.2, -22}, {-83.05, -22}}, thickness = 0.5));
      connect(T113[4].outPlaces[1], BKT_Off[4].inTransition[3]) annotation(
        Line(points = {{-167.2, -42}, {-161.4, -42}, {-161.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-134.125, -22.8}, {-134.125, -22.8}, {-126.25, -22.8}}));
      connect(BKT_Off[4].outTransition[4], T114[4].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-129.812, -1.2}, {-129.812, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-166.45, -22}}));
      connect(BKT_Off[4].outTransition[2], T115[4].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-85.35, -22}, {-85.35, -22}, {-83.05, -22}}, thickness = 0.5));
      connect(T113[3].outPlaces[1], BKT_Off[3].inTransition[3]) annotation(
        Line(points = {{-167.2, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
      connect(BKT_Off[3].outTransition[4], T114[3].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-164.15, -22}, {-164.15, -22}, {-166.45, -22}}));
      connect(BKT_Off[3].outTransition[2], T115[3].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-110.125, -1.2}, {-110.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-83.05, -22}}, thickness = 0.5));
      connect(T113[2].outPlaces[1], BKT_Off[2].inTransition[3]) annotation(
        Line(points = {{-167.2, -42}, {-162.8, -42}, {-162.8, -42}, {-158.4, -42}, {-158.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-127.687, -22.8}, {-127.687, -22.8}, {-126.25, -22.8}}));
      connect(BKT_Off[2].outTransition[4], T114[2].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-129.812, -1.2}, {-129.812, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-166.45, -22}}));
      connect(BKT_Off[2].outTransition[2], T115[2].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-109.125, -1.2}, {-109.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-84.35, -22}, {-84.35, -22}, {-83.05, -22}}, thickness = 0.5));
      connect(T113[1].outPlaces[1], BKT_Off[1].inTransition[3]) annotation(
        Line(points = {{-167.2, -42}, {-161.4, -42}, {-161.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
      connect(BKT_Off[1].outTransition[4], T114[1].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-166.45, -22}}));
      connect(BKT_Off[1].outTransition[2], T115[1].inPlaces[1]) annotation(
        Line(points = {{-126, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-83.05, -22}}, thickness = 0.5));
      connect(BKT_Cooling_II[5].outTransition[2], T117[5].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -16.3}}, thickness = 0.5));
      connect(BKT_Cooling_II[4].outTransition[2], T117[4].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -16.3}}, thickness = 0.5));
      connect(BKT_Cooling_II[3].outTransition[2], T117[3].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -17.1}, {-220, -17.1}, {-220, -16.3}}, thickness = 0.5));
      connect(BKT_Cooling_II[2].outTransition[2], T117[2].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -16.3}}, thickness = 0.5));
      connect(BKT_Cooling_II[1].outTransition[2], T117[1].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -16.3}}, thickness = 0.5));
      connect(T116[5].outPlaces[1], BKT_Cooling_II[5].inTransition[2]) annotation(
        Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
      connect(T116[4].outPlaces[1], BKT_Cooling_II[4].inTransition[2]) annotation(
        Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
      connect(T116[3].outPlaces[1], BKT_Cooling_II[3].inTransition[2]) annotation(
        Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
      connect(T116[2].outPlaces[1], BKT_Cooling_II[2].inTransition[2]) annotation(
        Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.25}, {-199.2, -34.25}, {-199.2, -34.5}}, thickness = 0.5));
      connect(T116[1].outPlaces[1], BKT_Cooling_II[1].inTransition[2]) annotation(
        Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
      connect(T114[5].outPlaces[1], BKT_Cooling_II[5].inTransition[1]) annotation(
        Line(points = {{-176.8, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
      connect(BKT_Cooling_II[5].outTransition[1], T113[5].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
      connect(T114[4].outPlaces[1], BKT_Cooling_II[4].inTransition[1]) annotation(
        Line(points = {{-176.8, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-199.9, -33.5}, {-199.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
      connect(BKT_Cooling_II[4].outTransition[1], T113[4].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-221.6, -34}, {-221.6, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
      connect(T114[3].outPlaces[1], BKT_Cooling_II[3].inTransition[1]) annotation(
        Line(points = {{-176.8, -22}, {-181.1, -22}, {-181.1, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
      connect(BKT_Cooling_II[3].outTransition[1], T113[3].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-221.6, -34}, {-221.6, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
      connect(T114[2].outPlaces[1], BKT_Cooling_II[2].inTransition[1]) annotation(
        Line(points = {{-176.8, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-199.9, -33.5}, {-199.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
      connect(BKT_Cooling_II[2].outTransition[1], T113[2].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-223.4, -34}, {-223.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-180.6, -42.5}, {-180.6, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
      connect(T114[1].outPlaces[1], BKT_Cooling_II[1].inTransition[1]) annotation(
        Line(points = {{-176.8, -22}, {-177.45, -22}, {-177.45, -22}, {-178.1, -22}, {-178.1, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.05, -33.5}, {-199.05, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
      connect(BKT_Cooling_II[1].outTransition[1], T113[1].inPlaces[1]) annotation(
        Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-179.6, -42.5}, {-179.6, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
      connect(T111[6].outPlaces[1], RLT_Cooling_II[6].inTransition[2]) annotation(
        Line(points = {{-202, 83.2}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[6].outTransition[2], T111[6].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-200.9, 112}, {-200.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 97.1}, {-202, 97.1}, {-202, 92.3}}, thickness = 0.5));
      connect(T111[5].outPlaces[1], RLT_Cooling_II[5].inTransition[2]) annotation(
        Line(points = {{-202, 83.2}, {-202, 81.9}, {-202, 81.9}, {-202, 80.6}, {-202, 80.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[5].outTransition[2], T111[5].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-199.9, 112}, {-199.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 98.1}, {-202, 98.1}, {-202, 92.3}}, thickness = 0.5));
      connect(T111[4].outPlaces[1], RLT_Cooling_II[4].inTransition[2]) annotation(
        Line(points = {{-202, 83.2}, {-202, 83.4}, {-202, 83.4}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-202.4, 65.5}, {-202.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[4].outTransition[2], T111[4].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-200.9, 112}, {-200.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 94.9}, {-202, 94.9}, {-202, 93.6}, {-202, 93.6}, {-202, 92.3}}, thickness = 0.5));
      connect(T111[3].outPlaces[1], RLT_Cooling_II[3].inTransition[2]) annotation(
        Line(points = {{-202, 83.2}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.4, 65.5}, {-201.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[3].outTransition[2], T111[3].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 97.1}, {-202, 97.1}, {-202, 92.3}}, thickness = 0.5));
      connect(T111[2].outPlaces[1], RLT_Cooling_II[2].inTransition[2]) annotation(
        Line(points = {{-202, 83.2}, {-202, 83.4}, {-202, 83.4}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[2].outTransition[2], T111[2].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-199.4, 112}, {-199.4, 112}, {-197.6, 112}, {-197.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 95.9}, {-202, 95.9}, {-202, 95.1}, {-202, 95.1}, {-202, 92.3}}, thickness = 0.5));
      connect(T111[1].outPlaces[1], RLT_Cooling_II[1].inTransition[2]) annotation(
        Line(points = {{-202, 83.2}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.4, 65.5}, {-201.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[1].outTransition[2], T111[1].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-197.6, 112}, {-197.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 95.9}, {-202, 95.9}, {-202, 92.3}}, thickness = 0.5));
      connect(RLT_Cooling_II[6].outTransition[2], T110[6].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 81.9}, {-222, 81.9}, {-222, 83.7}}, thickness = 0.5));
      connect(T110[6].outPlaces[1], RLT_Cooling_I[6].inTransition[2]) annotation(
        Line(points = {{-222, 92.8}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[5].outTransition[2], T110[5].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 83.7}}, thickness = 0.5));
      connect(T110[5].outPlaces[1], RLT_Cooling_I[5].inTransition[2]) annotation(
        Line(points = {{-222, 92.8}, {-222, 95.4}, {-222, 95.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[4].outTransition[2], T110[4].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.9}, {-222, 83.9}, {-222, 83.7}}, thickness = 0.5));
      connect(T110[4].outPlaces[1], RLT_Cooling_I[4].inTransition[2]) annotation(
        Line(points = {{-222, 92.8}, {-222, 96.4}, {-222, 96.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-223.6, 112.5}, {-223.6, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[3].outTransition[2], T110[3].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.7}}, thickness = 0.5));
      connect(T110[3].outPlaces[1], RLT_Cooling_I[3].inTransition[2]) annotation(
        Line(points = {{-222, 92.8}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[2].outTransition[2], T110[2].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.9}, {-222, 83.9}, {-222, 83.7}}, thickness = 0.5));
      connect(T110[2].outPlaces[1], RLT_Cooling_I[2].inTransition[2]) annotation(
        Line(points = {{-222, 92.8}, {-222, 95.4}, {-222, 95.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[1].outTransition[2], T110[1].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 81.9}, {-222, 81.9}, {-222, 83.7}}, thickness = 0.5));
      connect(T110[1].outPlaces[1], RLT_Cooling_I[1].inTransition[2]) annotation(
        Line(points = {{-222, 92.8}, {-222, 96.4}, {-222, 96.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-223.6, 112.5}, {-223.6, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[6].outTransition[1], T19[6].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-182.4, 57.5}, {-182.4, 57.5}, {-181.6, 57.5}, {-181.6, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
      connect(T19[6].outPlaces[1], RLT_Cooling_Off[6].inTransition[2]) annotation(
        Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[5].outTransition[1], T19[5].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
      connect(T19[5].outPlaces[1], RLT_Cooling_Off[5].inTransition[2]) annotation(
        Line(points = {{-169.2, 58}, {-159.4, 58}, {-159.4, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[4].outTransition[1], T19[4].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-224.4, 66}, {-224.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-182.4, 57.5}, {-182.4, 57.5}, {-180.6, 57.5}, {-180.6, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
      connect(T19[4].outPlaces[1], RLT_Cooling_Off[4].inTransition[2]) annotation(
        Line(points = {{-169.2, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[3].outTransition[1], T19[3].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-181.1, 57.5}, {-181.1, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
      connect(T19[3].outPlaces[1], RLT_Cooling_Off[3].inTransition[2]) annotation(
        Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[2].outTransition[1], T19[2].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
      connect(T19[2].outPlaces[1], RLT_Cooling_Off[2].inTransition[2]) annotation(
        Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
      connect(RLT_Cooling_II[1].outTransition[1], T19[1].inPlaces[1]) annotation(
        Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
      connect(T19[1].outPlaces[1], RLT_Cooling_Off[1].inTransition[2]) annotation(
        Line(points = {{-169.2, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
      connect(T18[6].outPlaces[1], RLT_Cooling_II[6].inTransition[1]) annotation(
        Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[6].outTransition[2], T18[6].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-167.9, 78.5}, {-167.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
      connect(T18[5].outPlaces[1], RLT_Cooling_II[5].inTransition[1]) annotation(
        Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[5].outTransition[2], T18[5].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-167.9, 78.5}, {-167.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
      connect(T18[4].outPlaces[1], RLT_Cooling_II[4].inTransition[1]) annotation(
        Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.9, 66.5}, {-201.9, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[4].outTransition[2], T18[4].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-158.6, 88}, {-158.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
      connect(T18[3].outPlaces[1], RLT_Cooling_II[3].inTransition[1]) annotation(
        Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[3].outTransition[2], T18[3].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-158.6, 88}, {-158.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-166.9, 78.5}, {-166.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
      connect(T18[2].outPlaces[1], RLT_Cooling_II[2].inTransition[1]) annotation(
        Line(points = {{-178.8, 78}, {-184.1, 78}, {-184.1, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[2].outTransition[2], T18[2].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
      connect(T18[1].outPlaces[1], RLT_Cooling_II[1].inTransition[1]) annotation(
        Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[1].outTransition[2], T18[1].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[6].outTransition[1], T17[6].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-157.6, 88}, {-157.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-163.6, 97.5}, {-163.6, 97.5}, {-167.4, 97.5}, {-167.4, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
      connect(T17[6].outPlaces[1], RLT_Cooling_I[6].inTransition[1]) annotation(
        Line(points = {{-178.8, 98}, {-190.6, 98}, {-190.6, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[5].outTransition[1], T17[5].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-167.9, 97.5}, {-167.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
      connect(T17[5].outPlaces[1], RLT_Cooling_I[5].inTransition[1]) annotation(
        Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[4].outTransition[1], T17[4].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-157.6, 88}, {-157.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
      connect(T17[4].outPlaces[1], RLT_Cooling_I[4].inTransition[1]) annotation(
        Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[3].outTransition[1], T17[3].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
      connect(T17[3].outPlaces[1], RLT_Cooling_I[3].inTransition[1]) annotation(
        Line(points = {{-178.8, 98}, {-190.6, 98}, {-190.6, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[2].outTransition[1], T17[2].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
      connect(T17[2].outPlaces[1], RLT_Cooling_I[2].inTransition[1]) annotation(
        Line(points = {{-178.8, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
      connect(RLT_Cooling_Off[1].outTransition[1], T17[1].inPlaces[1]) annotation(
        Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
      connect(T17[1].outPlaces[1], RLT_Cooling_I[1].inTransition[1]) annotation(
        Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-223.6, 111.5}, {-223.6, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
      connect(T16[6].outPlaces[1], RLT_Cooling_Off[6].inTransition[1]) annotation(
        Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
      connect(T16[5].outPlaces[1], RLT_Cooling_Off[5].inTransition[1]) annotation(
        Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
      connect(T16[4].outPlaces[1], RLT_Cooling_Off[4].inTransition[1]) annotation(
        Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
      connect(T16[3].outPlaces[1], RLT_Cooling_Off[3].inTransition[1]) annotation(
        Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
      connect(T16[2].outPlaces[1], RLT_Cooling_Off[2].inTransition[1]) annotation(
        Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-133.9, 88.5}, {-133.9, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
      connect(T16[1].outPlaces[1], RLT_Cooling_Off[1].inTransition[1]) annotation(
        Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
      connect(RLT_Heating_I[6].outTransition[2], T14[6].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
      connect(T14[6].outPlaces[1], RLT_Heating_II[6].inTransition[2]) annotation(
        Line(points = {{-54, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
      connect(RLT_Heating_I[5].outTransition[2], T14[5].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
      connect(T14[5].outPlaces[1], RLT_Heating_II[5].inTransition[2]) annotation(
        Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
      connect(RLT_Heating_I[4].outTransition[2], T14[4].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
      connect(T14[4].outPlaces[1], RLT_Heating_II[4].inTransition[2]) annotation(
        Line(points = {{-54, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-55.1, 66.5}, {-55.1, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
      connect(RLT_Heating_I[3].outTransition[2], T14[3].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
      connect(T14[3].outPlaces[1], RLT_Heating_II[3].inTransition[2]) annotation(
        Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
      connect(RLT_Heating_I[2].outTransition[2], T14[2].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
      connect(T14[2].outPlaces[1], RLT_Heating_II[2].inTransition[2]) annotation(
        Line(points = {{-54, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
      connect(RLT_Heating_I[1].outTransition[2], T14[1].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
      connect(T14[1].outPlaces[1], RLT_Heating_II[1].inTransition[2]) annotation(
        Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
      connect(RLT_Heating_II[6].outTransition[2], T15[6].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
      connect(T15[6].outPlaces[1], RLT_Heating_I[6].inTransition[2]) annotation(
        Line(points = {{-34, 92.8}, {-34, 95.3}, {-34, 95.3}, {-34, 97.8}, {-33.2, 97.8}, {-33.2, 104.55}, {-33.2, 104.55}, {-33.2, 109.3}}, thickness = 0.5));
      connect(RLT_Heating_II[5].outTransition[2], T15[5].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
      connect(T15[5].outPlaces[1], RLT_Heating_I[5].inTransition[2]) annotation(
        Line(points = {{-34, 92.8}, {-34, 97.3}, {-34, 97.3}, {-34, 101.8}, {-33.2, 101.8}, {-33.2, 109.3}}, thickness = 0.5));
      connect(RLT_Heating_II[4].outTransition[2], T15[4].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
      connect(T15[4].outPlaces[1], RLT_Heating_I[4].inTransition[2]) annotation(
        Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
      connect(RLT_Heating_II[3].outTransition[2], T15[3].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
      connect(T15[3].outPlaces[1], RLT_Heating_I[3].inTransition[2]) annotation(
        Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
      connect(RLT_Heating_II[2].outTransition[2], T15[2].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
      connect(T15[2].outPlaces[1], RLT_Heating_I[2].inTransition[2]) annotation(
        Line(points = {{-34, 92.8}, {-34, 101.05}, {-34, 101.05}, {-34, 109.3}, {-33.6, 109.3}, {-33.6, 109.3}, {-33.2, 109.3}}, thickness = 0.5));
      connect(RLT_Heating_II[1].outTransition[2], T15[1].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
      connect(T15[1].outPlaces[1], RLT_Heating_I[1].inTransition[2]) annotation(
        Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
      connect(RLT_Heating_II[6].outTransition[1], T13[6].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.4, 66}, {-33.4, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
      connect(T13[6].outPlaces[1], RLT_Heating_Off[6].inTransition[2]) annotation(
        Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
      connect(RLT_Heating_II[5].outTransition[1], T13[5].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
      connect(T13[5].outPlaces[1], RLT_Heating_Off[5].inTransition[2]) annotation(
        Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
      connect(RLT_Heating_II[4].outTransition[1], T13[4].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
      connect(T13[4].outPlaces[1], RLT_Heating_Off[4].inTransition[2]) annotation(
        Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
      connect(RLT_Heating_II[3].outTransition[1], T13[3].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
      connect(T13[3].outPlaces[1], RLT_Heating_Off[3].inTransition[2]) annotation(
        Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-122.4, 88.5}, {-122.4, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
      connect(RLT_Heating_II[2].outTransition[1], T13[2].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-74.4, 58.5}, {-74.4, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
      connect(T13[2].outPlaces[1], RLT_Heating_Off[2].inTransition[2]) annotation(
        Line(points = {{-84.8, 58}, {-104.4, 58}, {-104.4, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
      connect(RLT_Heating_II[1].outTransition[1], T13[1].inPlaces[1]) annotation(
        Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-74.4, 58.5}, {-74.4, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
      connect(T13[1].outPlaces[1], RLT_Heating_Off[1].inTransition[2]) annotation(
        Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
      connect(T12[6].outPlaces[1], RLT_Heating_II[6].inTransition[1]) annotation(
        Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 66.75}, {-54.8, 66.75}, {-54.8, 65.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[6].outTransition[2], T12[6].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
      connect(T12[5].outPlaces[1], RLT_Heating_II[5].inTransition[1]) annotation(
        Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 65.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[5].outTransition[2], T12[5].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
      connect(T12[4].outPlaces[1], RLT_Heating_II[4].inTransition[1]) annotation(
        Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 65.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[4].outTransition[2], T12[4].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-98.4, 88}, {-98.4, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
      connect(T12[3].outPlaces[1], RLT_Heating_II[3].inTransition[1]) annotation(
        Line(points = {{-75.2, 78}, {-66.6, 78}, {-66.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 65.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[3].outTransition[2], T12[3].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
      connect(T12[2].outPlaces[1], RLT_Heating_II[2].inTransition[1]) annotation(
        Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 66.625}, {-54.8, 66.625}, {-54.8, 65.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[2].outTransition[2], T12[2].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
      connect(T12[1].outPlaces[1], RLT_Heating_II[1].inTransition[1]) annotation(
        Line(points = {{-75.2, 78}, {-70.4, 78}, {-70.4, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 67.625}, {-54.8, 67.625}, {-54.8, 65.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[1].outTransition[2], T12[1].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[6].outTransition[1], T1[6].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
      connect(T1[6].outPlaces[1], RLT_Heating_I[6].inTransition[1]) annotation(
        Line(points = {{-75.2, 98}, {-52.6, 98}, {-52.6, 98}, {-30, 98}, {-30, 110.5}, {-32.6, 110.5}, {-32.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[5].outTransition[1], T1[5].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
      connect(T1[5].outPlaces[1], RLT_Heating_I[5].inTransition[1]) annotation(
        Line(points = {{-75.2, 98}, {-63.9, 98}, {-63.9, 98}, {-52.6, 98}, {-52.6, 98}, {-30, 98}, {-30, 110.5}, {-32.6, 110.5}, {-32.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[4].outTransition[1], T1[4].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
      connect(T1[4].outPlaces[1], RLT_Heating_I[4].inTransition[1]) annotation(
        Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[3].outTransition[1], T1[3].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
      connect(T1[3].outPlaces[1], RLT_Heating_I[3].inTransition[1]) annotation(
        Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[2].outTransition[1], T1[2].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-86.6, 98.5}, {-86.6, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
      connect(T1[2].outPlaces[1], RLT_Heating_I[2].inTransition[1]) annotation(
        Line(points = {{-75.2, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
      connect(RLT_Heating_Off[1].outTransition[1], T1[1].inPlaces[1]) annotation(
        Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-86.6, 98.5}, {-86.6, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
      connect(T1[1].outPlaces[1], RLT_Heating_I[1].inTransition[1]) annotation(
        Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
      connect(T11[6].outPlaces[1], RLT_Heating_Off[6].inTransition[1]) annotation(
        Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
      connect(T11[5].outPlaces[1], RLT_Heating_Off[5].inTransition[1]) annotation(
        Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
      connect(T11[4].outPlaces[1], RLT_Heating_Off[4].inTransition[1]) annotation(
        Line(points = {{-84.8, 118}, {-105.4, 118}, {-105.4, 118}, {-124, 118}, {-124, 87.5}, {-122.4, 87.5}, {-122.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
      connect(T11[3].outPlaces[1], RLT_Heating_Off[3].inTransition[1]) annotation(
        Line(points = {{-84.8, 118}, {-95.6, 118}, {-95.6, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
      connect(T11[2].outPlaces[1], RLT_Heating_Off[2].inTransition[1]) annotation(
        Line(points = {{-84.8, 118}, {-105.4, 118}, {-105.4, 118}, {-124, 118}, {-124, 87.5}, {-122.4, 87.5}, {-122.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
      connect(T11[1].outPlaces[1], RLT_Heating_Off[1].inTransition[1]) annotation(
        Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[6].outTransition[1], T16[6].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[5].outTransition[1], T16[5].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-184.4, 118.5}, {-184.4, 118.5}, {-181.6, 118.5}, {-181.6, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[4].outTransition[1], T16[4].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[3].outTransition[1], T16[3].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-184.4, 118.5}, {-184.4, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[2].outTransition[1], T16[2].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
      connect(RLT_Cooling_I[1].outTransition[1], T16[1].inPlaces[1]) annotation(
        Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
      connect(RLT_Heating_I[6].outTransition[1], T11[6].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-60.4, 110}, {-60.4, 110}, {-64, 110}, {-64, 117.5}, {-69.6, 117.5}, {-69.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
      connect(RLT_Heating_I[5].outTransition[1], T11[5].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
      connect(RLT_Heating_I[4].outTransition[1], T11[4].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
      connect(RLT_Heating_I[3].outTransition[1], T11[3].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
      connect(RLT_Heating_I[2].outTransition[1], T11[2].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-60.4, 110}, {-60.4, 110}, {-64, 110}, {-64, 117.5}, {-69.6, 117.5}, {-69.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
      connect(RLT_Heating_I[1].outTransition[1], T11[1].inPlaces[1]) annotation(
        Line(points = {{-54.8, 110}, {-64, 110}, {-64, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
      annotation(
        Icon(graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-250, 150}, {250, -150}}), Text(origin = {-52, 6}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-68, 30}, {170, -46}}, textString = "Automatisierungs-
Ebene")}, coordinateSystem(extent = {{-250, -150}, {250, 150}})),
        Diagram(graphics = {Text(origin = {-177, 139}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_RLT_cooling"), Text(origin = {-77, 139}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_RLT_heating"), Text(origin = {-131, 31}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_BKT"), Text(origin = {69, 133}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_HTSsystem"), Text(origin = {195, 129}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_HPsystem_warm")}, coordinateSystem(extent = {{-250, -150}, {250, 150}})),
        __OpenModelica_commandLineOptions = "");
    end AutomatisierungsebeneV2;

    model ManagementEbene_Temp_Hum "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten für die Temperatur und relative Luftfeuchtigkeit im Raum"
      PNlib.Components.T disableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 15, TRoomMea[2] > 273.15 + 20, TRoomMea[3] > 273.15 + 20, TRoomMea[4] > 273.15 + 20, TRoomMea[5] > 273.15 + 20}) annotation(
        Placement(visible = true, transformation(origin = {-56, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T enableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] < 273.15 + 13, TRoomMea[2] < 273.15 + 18, TRoomMea[3] < 273.15 + 18, TRoomMea[4] < 273.15 + 18, TRoomMea[5] < 273.15 + 18}) annotation(
        Placement(visible = true, transformation(extent = {{-66, 20}, {-46, 40}}, rotation = 0)));
      PNlib.Components.PD Heating[5](each nIn = 1, each nOut = 1, each startTokens = 0, each minTokens = 0, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PNlib.Components.PD Off_Temperature[5](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1, each reStart = true, each reStartTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD Cooling[5](each nIn = 1, each nOut = 1, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-182, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T enableCooling[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 17, TRoomMea[2] > 273.15 + 22, TRoomMea[3] > 273.15 + 22, TRoomMea[4] > 273.15 + 22, TRoomMea[5] > 273.15 + 22}) annotation(
        Placement(visible = true, transformation(origin = {-144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T disableCooling[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] < 273.15 + 15, TRoomMea[2] < 273.15 + 20, TRoomMea[3] < 273.15 + 20, TRoomMea[4] < 273.15 + 20, TRoomMea[5] < 273.15 + 20}) annotation(
        Placement(visible = true, transformation(extent = {{-154, 20}, {-134, 40}}, rotation = 0)));
      PNlib.Components.PD Dehumidifying[5](each nIn = 1, each nOut = 1) annotation(
        Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.PD Off_Humidity[5](each nIn = 2, each nOut = 2, each reStartTokens = 1, each startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD Humidifying[5](each nIn = 1, each nOut = 1, each reStartTokens = 1, each startTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {184, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PNlib.Components.T enableHumidifying[5](each nIn = 1, each nOut = 1, firingCon = {HumRoomMea[1] <= 0.4, HumRoomMea[2] <= 0.4, HumRoomMea[3] <= 0.4, HumRoomMea[4] <= 0.4, HumRoomMea[5] <= 0.4}) annotation(
        Placement(visible = true, transformation(origin = {146, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T enableDehumidifying[5](each nIn = 1, each nOut = 1, firingCon = {HumRoomMea[1] > 0.6, HumRoomMea[2] > 0.6, HumRoomMea[3] > 0.6, HumRoomMea[4] > 0.6, HumRoomMea[5] > 0.6}) annotation(
        Placement(visible = true, transformation(origin = {58, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T disableDehumidifying[5](each nIn = 1, each nOut = 1, firingCon = {HumRoomMea[1] <= 0.6, HumRoomMea[2] <= 0.6, HumRoomMea[3] <= 0.6, HumRoomMea[4] <= 0.6, HumRoomMea[5] <= 0.6}) annotation(
        Placement(visible = true, transformation(origin = {56, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.Components.T disableHumidifying[5](each nIn = 1, each nOut = 1, firingCon = {HumRoomMea[1] > 0.4, HumRoomMea[2] > 0.4, HumRoomMea[3] > 0.4, HumRoomMea[4] > 0.4, HumRoomMea[5] > 0.4}) annotation(
        Placement(visible = true, transformation(origin = {144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.RealToBoolean realToBoolean1[30](each threshold = 0.5) annotation(
        Placement(visible = true, transformation(origin = {0, -72}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanOutput y[30] annotation(
        Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation(
        Placement(visible = true, transformation(origin = {-100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {-100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput HumRoomMea[5] annotation(
        Placement(visible = true, transformation(origin = {100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
    equation
      connect(realToBoolean1[1].y, y[1]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[2].y, y[2]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[3].y, y[3]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[4].y, y[4]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[5].y, y[5]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[6].y, y[6]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[7].y, y[7]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[8].y, y[8]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[9].y, y[9]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[10].y, y[10]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[11].y, y[11]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[12].y, y[12]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[13].y, y[13]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[14].y, y[14]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[15].y, y[15]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[16].y, y[16]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[17].y, y[17]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[18].y, y[18]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[19].y, y[19]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[20].y, y[20]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[21].y, y[21]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[22].y, y[22]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[23].y, y[23]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[24].y, y[24]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[25].y, y[25]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[26].y, y[26]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[27].y, y[27]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[28].y, y[28]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[29].y, y[29]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[30].y, y[30]) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      realToBoolean1[1].u = Off_Temperature[1].t;
      realToBoolean1[2].u = Heating[1].t;
      realToBoolean1[3].u = Cooling[1].t;
      realToBoolean1[4].u = Off_Temperature[2].t;
      realToBoolean1[5].u = Heating[2].t;
      realToBoolean1[6].u = Cooling[2].t;
      realToBoolean1[7].u = Off_Temperature[3].t;
      realToBoolean1[8].u = Heating[3].t;
      realToBoolean1[9].u = Cooling[3].t;
      realToBoolean1[10].u = Off_Temperature[4].t;
      realToBoolean1[11].u = Heating[4].t;
      realToBoolean1[12].u = Cooling[4].t;
      realToBoolean1[13].u = Off_Temperature[5].t;
      realToBoolean1[14].u = Heating[5].t;
      realToBoolean1[15].u = Cooling[5].t;
      realToBoolean1[16].u = Off_Humidity[1].t;
      realToBoolean1[17].u = Humidifying[1].t;
      realToBoolean1[18].u = Dehumidifying[1].t;
      realToBoolean1[19].u = Off_Humidity[2].t;
      realToBoolean1[20].u = Humidifying[2].t;
      realToBoolean1[21].u = Dehumidifying[2].t;
      realToBoolean1[22].u = Off_Humidity[3].t;
      realToBoolean1[23].u = Humidifying[3].t;
      realToBoolean1[24].u = Dehumidifying[3].t;
      realToBoolean1[25].u = Off_Humidity[4].t;
      realToBoolean1[26].u = Humidifying[4].t;
      realToBoolean1[27].u = Dehumidifying[4].t;
      realToBoolean1[28].u = Off_Humidity[5].t;
      realToBoolean1[29].u = Humidifying[5].t;
      realToBoolean1[30].u = Dehumidifying[5].t;
      connect(Cooling[1].outTransition[1], disableCooling[1].inPlaces[1]) annotation(
        Line(points = {{-182, 10.8}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
      connect(disableDehumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[2]) annotation(
        Line(points = {{60.8, 30}, {112, 30}, {112, -0.5}, {110.8, -0.5}}, thickness = 0.5));
      connect(disableDehumidifying[5].outPlaces[1], Off_Humidity[5].inTransition[2]) annotation(
        Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
      connect(disableDehumidifying[4].outPlaces[1], Off_Humidity[4].inTransition[2]) annotation(
        Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
      connect(disableDehumidifying[3].outPlaces[1], Off_Humidity[3].inTransition[2]) annotation(
        Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {112, 0}, {112, -0.5}, {110.8, -0.5}}, thickness = 0.5));
      connect(disableDehumidifying[2].outPlaces[1], Off_Humidity[2].inTransition[2]) annotation(
        Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
      connect(Off_Humidity[5].outTransition[1], enableHumidifying[5].inPlaces[1]) annotation(
        Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
      connect(Off_Humidity[4].outTransition[1], enableHumidifying[4].inPlaces[1]) annotation(
        Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
      connect(Off_Humidity[3].outTransition[1], enableHumidifying[3].inPlaces[1]) annotation(
        Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
      connect(Off_Humidity[2].outTransition[1], enableHumidifying[2].inPlaces[1]) annotation(
        Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
      connect(Off_Humidity[1].outTransition[1], enableHumidifying[1].inPlaces[1]) annotation(
        Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
      connect(enableHumidifying[5].outPlaces[1], Humidifying[5].inTransition[1]) annotation(
        Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
      connect(enableHumidifying[4].outPlaces[1], Humidifying[4].inTransition[1]) annotation(
        Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
      connect(enableHumidifying[3].outPlaces[1], Humidifying[3].inTransition[1]) annotation(
        Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
      connect(enableHumidifying[2].outPlaces[1], Humidifying[2].inTransition[1]) annotation(
        Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
      connect(enableHumidifying[1].outPlaces[1], Humidifying[1].inTransition[1]) annotation(
        Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
      connect(disableDehumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[2]) annotation(
        Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
      connect(disableHumidifying[5].outPlaces[1], Off_Humidity[5].inTransition[1]) annotation(
        Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
      connect(disableHumidifying[4].outPlaces[1], Off_Humidity[4].inTransition[1]) annotation(
        Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
      connect(disableHumidifying[3].outPlaces[1], Off_Humidity[3].inTransition[1]) annotation(
        Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
      connect(disableHumidifying[2].outPlaces[1], Off_Humidity[2].inTransition[1]) annotation(
        Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
      connect(disableHumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[1]) annotation(
        Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
      connect(Off_Humidity[5].outTransition[2], enableDehumidifying[5].inPlaces[1]) annotation(
        Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
      connect(Off_Humidity[4].outTransition[2], enableDehumidifying[4].inPlaces[1]) annotation(
        Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {64, -30}, {64, -30}, {62.8, -30}}, thickness = 0.5));
      connect(Off_Humidity[3].outTransition[2], enableDehumidifying[3].inPlaces[1]) annotation(
        Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
      connect(Off_Humidity[2].outTransition[2], enableDehumidifying[2].inPlaces[1]) annotation(
        Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
      connect(Off_Humidity[1].outTransition[2], enableDehumidifying[1].inPlaces[1]) annotation(
        Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {64, -30}, {64, -30}, {62.8, -30}}, thickness = 0.5));
      connect(Dehumidifying[5].outTransition[1], disableDehumidifying[5].inPlaces[1]) annotation(
        Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
      connect(Dehumidifying[4].outTransition[1], disableDehumidifying[4].inPlaces[1]) annotation(
        Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
      connect(Dehumidifying[3].outTransition[1], disableDehumidifying[3].inPlaces[1]) annotation(
        Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
      connect(Dehumidifying[2].outTransition[1], disableDehumidifying[2].inPlaces[1]) annotation(
        Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
      connect(Dehumidifying[1].outTransition[1], disableDehumidifying[1].inPlaces[1]) annotation(
        Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
      connect(enableDehumidifying[5].outPlaces[1], Dehumidifying[5].inTransition[1]) annotation(
        Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
      connect(enableDehumidifying[4].outPlaces[1], Dehumidifying[4].inTransition[1]) annotation(
        Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
      connect(enableDehumidifying[3].outPlaces[1], Dehumidifying[3].inTransition[1]) annotation(
        Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
      connect(enableDehumidifying[2].outPlaces[1], Dehumidifying[2].inTransition[1]) annotation(
        Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
      connect(enableDehumidifying[1].outPlaces[1], Dehumidifying[1].inTransition[1]) annotation(
        Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
      connect(Humidifying[4].outTransition[1], disableHumidifying[4].inPlaces[1]) annotation(
        Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
      connect(Humidifying[3].outTransition[1], disableHumidifying[3].inPlaces[1]) annotation(
        Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
      connect(Humidifying[2].outTransition[1], disableHumidifying[2].inPlaces[1]) annotation(
        Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
      connect(Humidifying[1].outTransition[1], disableHumidifying[1].inPlaces[1]) annotation(
        Line(points = {{184, -10.8}, {184, -30}, {148.8, -30}}, thickness = 0.5));
      connect(enableHeating[5].outPlaces[1], Heating[5].inTransition[1]) annotation(
        Line(points = {{-51.2, 30}, {-16, 30}, {-16, 10.8}}));
      connect(disableCooling[5].outPlaces[1], Off_Temperature[5].inTransition[2]) annotation(
        Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
      connect(disableCooling[4].outPlaces[1], Off_Temperature[4].inTransition[2]) annotation(
        Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
      connect(disableCooling[3].outPlaces[1], Off_Temperature[3].inTransition[2]) annotation(
        Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
      connect(disableCooling[2].outPlaces[1], Off_Temperature[2].inTransition[2]) annotation(
        Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
      connect(disableCooling[1].outPlaces[1], Off_Temperature[1].inTransition[2]) annotation(
        Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
      connect(Cooling[5].outTransition[1], disableCooling[5].inPlaces[1]) annotation(
        Line(points = {{-182, 10.8}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
      connect(Cooling[4].outTransition[1], disableCooling[4].inPlaces[1]) annotation(
        Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
      connect(Cooling[3].outTransition[1], disableCooling[3].inPlaces[1]) annotation(
        Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
      connect(Cooling[2].outTransition[1], disableCooling[2].inPlaces[1]) annotation(
        Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
      connect(Off_Temperature[5].outTransition[2], enableCooling[5].inPlaces[1]) annotation(
        Line(points = {{-110.8, -0.5}, {-111.8, -0.5}, {-111.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
      connect(Off_Temperature[4].outTransition[2], enableCooling[4].inPlaces[1]) annotation(
        Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
      connect(Off_Temperature[3].outTransition[2], enableCooling[3].inPlaces[1]) annotation(
        Line(points = {{-110.8, -0.5}, {-111.8, -0.5}, {-111.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
      connect(Off_Temperature[2].outTransition[2], enableCooling[2].inPlaces[1]) annotation(
        Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
      connect(Off_Temperature[1].outTransition[2], enableCooling[1].inPlaces[1]) annotation(
        Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
      connect(enableCooling[5].outPlaces[1], Cooling[5].inTransition[1]) annotation(
        Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
      connect(enableCooling[4].outPlaces[1], Cooling[4].inTransition[1]) annotation(
        Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
      connect(enableCooling[3].outPlaces[1], Cooling[3].inTransition[1]) annotation(
        Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
      connect(enableCooling[2].outPlaces[1], Cooling[2].inTransition[1]) annotation(
        Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
      connect(enableCooling[1].outPlaces[1], Cooling[1].inTransition[1]) annotation(
        Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
      connect(disableHeating[5].outPlaces[1], Off_Temperature[5].inTransition[1]) annotation(
        Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
      connect(disableHeating[4].outPlaces[1], Off_Temperature[4].inTransition[1]) annotation(
        Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
      connect(disableHeating[3].outPlaces[1], Off_Temperature[3].inTransition[1]) annotation(
        Line(points = {{-60.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
      connect(disableHeating[2].outPlaces[1], Off_Temperature[2].inTransition[1]) annotation(
        Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
      connect(disableHeating[1].outPlaces[1], Off_Temperature[1].inTransition[1]) annotation(
        Line(points = {{-60.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
      connect(Off_Temperature[5].outTransition[1], enableHeating[5].inPlaces[1]) annotation(
        Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
      connect(Off_Temperature[4].outTransition[1], enableHeating[4].inPlaces[1]) annotation(
        Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
      connect(Off_Temperature[3].outTransition[1], enableHeating[3].inPlaces[1]) annotation(
        Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
      connect(Off_Temperature[2].outTransition[1], enableHeating[2].inPlaces[1]) annotation(
        Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
      connect(Off_Temperature[1].outTransition[1], enableHeating[1].inPlaces[1]) annotation(
        Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
      connect(Heating[5].outTransition[1], disableHeating[5].inPlaces[1]) annotation(
        Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
      connect(Heating[4].outTransition[1], disableHeating[4].inPlaces[1]) annotation(
        Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
      connect(Heating[3].outTransition[1], disableHeating[3].inPlaces[1]) annotation(
        Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
      connect(Heating[2].outTransition[1], disableHeating[2].inPlaces[1]) annotation(
        Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
      connect(Heating[1].outTransition[1], disableHeating[1].inPlaces[1]) annotation(
        Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
      connect(enableHeating[4].outPlaces[1], Heating[4].inTransition[1]) annotation(
        Line(points = {{-51.2, 30}, {-33.7, 30}, {-33.7, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
      connect(enableHeating[3].outPlaces[1], Heating[3].inTransition[1]) annotation(
        Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
      connect(enableHeating[2].outPlaces[1], Heating[2].inTransition[1]) annotation(
        Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
      connect(enableHeating[1].outPlaces[1], Heating[1].inTransition[1]) annotation(
        Line(points = {{-51.2, 30}, {-33.7, 30}, {-33.7, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
      connect(Humidifying[5].outTransition[1], disableHumidifying[5].inPlaces[1]) annotation(
        Line(points = {{184, -10.8}, {184, -30}, {148.8, -30}}, color = {0, 0, 0}));
      annotation(
        Line(points = {{-60, -106}, {-60, -106}}, color = {255, 127, 0}),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}}), graphics = {Rectangle(extent = {{-200, 100}, {200, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Text(extent = {{-162, 34}, {152, -28}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, textString = "Management-Ebene")}),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}})),
        Documentation(info = "<html><head></head><body><div>Struktur des Output-Vektors (oben nach unten)</div><div><br></div><div>Workshop_Off</div><div>Workshop_Heating</div><div>Workshop_Cooling</div><div>Canteen_Off</div><div>Canteen_Heating</div><div>Canteen_Cooling</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Heating</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Heating</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Off</div><div><div style=\"font-size: 12px;\"><div>OpenplanOffice_Heating</div><div></div></div><div style=\"font-size: 12px;\">OpenplanOffice_Cooling</div></div><div><div>Workshop_Off</div><div>Workshop_Humidifying</div><div>Workshop_Dehumidifying</div><div>Canteen_Off</div><div>Canteen_Humidifying</div><div>Canteen_Dehumidifying</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Humidifying</div><div>ConferenceRoom_Dehumidifying</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Humidifying</div><div>MultipersonOffice_Dehumidifying</div><div>OpenplanOffice_Off</div><div><div style=\"font-size: 12px;\"><div>OpenplanOffice_<span style=\"font-size: medium;\">Humidifying</span></div><div></div></div><div style=\"font-size: 12px;\">OpenplanOffice_Dehumidifying</div></div></div></body></html>"),
        __OpenModelica_commandLineOptions = "");
    end ManagementEbene_Temp_Hum;

    model ManagementEbene_Temp "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten der Raumtemperatur"
      PNlib.Components.T disableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 15, TRoomMea[2] > 273.15 + 20, TRoomMea[3] > 273.15 + 20, TRoomMea[4] > 273.15 + 20, TRoomMea[5] > 273.15 + 20}) annotation(
        Placement(visible = true, transformation(origin = {44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T enableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] < 273.15 + 13, TRoomMea[2] < 273.15 + 18, TRoomMea[3] < 273.15 + 18, TRoomMea[4] < 273.15 + 18, TRoomMea[5] < 273.15 + 18}) annotation(
        Placement(visible = true, transformation(extent = {{34, 20}, {54, 40}}, rotation = 0)));
      PNlib.Components.PD Heating[5](each maxTokens = 1, each minTokens = 0, each nIn = 1, each nOut = 1, each startTokens = 0) annotation(
        Placement(visible = true, transformation(origin = {84, -2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      PNlib.Components.PD Off_Temperature[5](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1, each reStart = true, each reStartTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.PD Cooling[5](each nIn = 1, each nOut = 1, each maxTokens = 1) annotation(
        Placement(visible = true, transformation(origin = {-82, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      PNlib.Components.T enableCooling[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 17, TRoomMea[2] > 273.15 + 22, TRoomMea[3] > 273.15 + 22, TRoomMea[4] > 273.15 + 22, TRoomMea[5] > 273.15 + 22}) annotation(
        Placement(visible = true, transformation(origin = {-44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      PNlib.Components.T disableCooling[5](firingCon = {TRoomMea[1] < 273.15 + 15, TRoomMea[2] < 273.15 + 20, TRoomMea[3] < 273.15 + 20, TRoomMea[4] < 273.15 + 20, TRoomMea[5] < 273.15 + 20}, each nIn = 1, each nOut = 1) annotation(
        Placement(visible = true, transformation(extent = {{-54, 20}, {-34, 40}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanOutput y[15] annotation(
        Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.RealToBoolean realToBoolean1[15](each threshold = 0.5) annotation(
        Placement(visible = true, transformation(origin = {0, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation(
        Placement(visible = true, transformation(origin = {-2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {-2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
    equation
      connect(realToBoolean1[1].y, y[1]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[2].y, y[2]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[3].y, y[3]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[4].y, y[4]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[5].y, y[5]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[6].y, y[6]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[7].y, y[7]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[8].y, y[8]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[9].y, y[9]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[10].y, y[10]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[11].y, y[11]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[12].y, y[12]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[13].y, y[13]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[14].y, y[14]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      connect(realToBoolean1[15].y, y[15]) annotation(
        Line(points = {{0, -86}, {0, -86}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
      realToBoolean1[1].u = Off_Temperature[1].t;
      realToBoolean1[2].u = Heating[1].t;
      realToBoolean1[3].u = Cooling[1].t;
      realToBoolean1[4].u = Off_Temperature[2].t;
      realToBoolean1[5].u = Heating[2].t;
      realToBoolean1[6].u = Cooling[2].t;
      realToBoolean1[7].u = Off_Temperature[3].t;
      realToBoolean1[8].u = Heating[3].t;
      realToBoolean1[9].u = Cooling[3].t;
      realToBoolean1[10].u = Off_Temperature[4].t;
      realToBoolean1[11].u = Heating[4].t;
      realToBoolean1[12].u = Cooling[4].t;
      realToBoolean1[13].u = Off_Temperature[5].t;
      realToBoolean1[14].u = Heating[5].t;
      realToBoolean1[15].u = Cooling[5].t;
      connect(enableCooling[1].outPlaces[1], Cooling[1].inTransition[1]) annotation(
        Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
      connect(enableCooling[2].outPlaces[1], Cooling[2].inTransition[1]) annotation(
        Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
      connect(enableCooling[3].outPlaces[1], Cooling[3].inTransition[1]) annotation(
        Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
      connect(enableCooling[4].outPlaces[1], Cooling[4].inTransition[1]) annotation(
        Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
      connect(enableCooling[5].outPlaces[1], Cooling[5].inTransition[1]) annotation(
        Line(points = {{-49, -30}, {-81.8, -30}, {-81.8, -12.8}, {-82, -12.8}}));
      connect(Off_Temperature[1].outTransition[2], enableCooling[1].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-12.8, -2}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
      connect(Off_Temperature[2].outTransition[2], enableCooling[2].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-12.8, -2}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
      connect(Off_Temperature[3].outTransition[2], enableCooling[3].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, -1.5}, {-12.8, -1.5}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
      connect(Off_Temperature[4].outTransition[2], enableCooling[4].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-12.8, -2}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
      connect(Off_Temperature[5].outTransition[2], enableCooling[5].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, -1.5}, {-12.8, -1.5}, {-12.8, -30}, {-39, -30}}, thickness = 0.5));
      connect(Heating[1].outTransition[1], disableHeating[1].inPlaces[1]) annotation(
        Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
      connect(Heating[2].outTransition[1], disableHeating[2].inPlaces[1]) annotation(
        Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
      connect(Heating[3].outTransition[1], disableHeating[3].inPlaces[1]) annotation(
        Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
      connect(Heating[4].outTransition[1], disableHeating[4].inPlaces[1]) annotation(
        Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
      connect(Heating[5].outTransition[1], disableHeating[5].inPlaces[1]) annotation(
        Line(points = {{84, -12.8}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {49, -30}}));
      connect(disableHeating[1].outPlaces[1], Off_Temperature[1].inTransition[1]) annotation(
        Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
      connect(disableHeating[2].outPlaces[1], Off_Temperature[2].inTransition[1]) annotation(
        Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
      connect(disableHeating[3].outPlaces[1], Off_Temperature[3].inTransition[1]) annotation(
        Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
      connect(disableHeating[4].outPlaces[1], Off_Temperature[4].inTransition[1]) annotation(
        Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
      connect(disableHeating[5].outPlaces[1], Off_Temperature[5].inTransition[1]) annotation(
        Line(points = {{39, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, -1.5}, {10.8, -1.5}}, thickness = 0.5));
      connect(enableHeating[1].outPlaces[1], Heating[1].inTransition[1]) annotation(
        Line(points = {{49, 30}, {83.8, 30}, {83.8, 8.8}, {84, 8.8}}));
      connect(enableHeating[2].outPlaces[1], Heating[2].inTransition[1]) annotation(
        Line(points = {{49, 30}, {83.8, 30}, {83.8, 8.8}, {84, 8.8}}));
      connect(enableHeating[3].outPlaces[1], Heating[3].inTransition[1]) annotation(
        Line(points = {{49, 30}, {83.8, 30}, {83.8, 8.8}, {84, 8.8}}));
      connect(enableHeating[4].outPlaces[1], Heating[4].inTransition[1]) annotation(
        Line(points = {{49, 30}, {83.8, 30}, {83.8, 8.8}, {84, 8.8}}));
      connect(Off_Temperature[1].outTransition[1], enableHeating[1].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
      connect(Off_Temperature[2].outTransition[1], enableHeating[2].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
      connect(Off_Temperature[3].outTransition[1], enableHeating[3].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
      connect(Off_Temperature[4].outTransition[1], enableHeating[4].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
      connect(Off_Temperature[5].outTransition[1], enableHeating[5].inPlaces[1]) annotation(
        Line(points = {{-10.8, -2}, {-11.8, -2}, {-11.8, 0}, {-12.8, 0}, {-12.8, 29.5}, {39, 29.5}, {39, 30}}, thickness = 0.5));
      connect(enableHeating[5].outPlaces[1], Heating[5].inTransition[1]) annotation(
        Line(points = {{49, 30}, {84, 30}, {84, 8.8}}));
      connect(Cooling[2].outTransition[1], disableCooling[2].inPlaces[1]) annotation(
        Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
      connect(Cooling[3].outTransition[1], disableCooling[3].inPlaces[1]) annotation(
        Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
      connect(Cooling[4].outTransition[1], disableCooling[4].inPlaces[1]) annotation(
        Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
      connect(Cooling[5].outTransition[1], disableCooling[5].inPlaces[1]) annotation(
        Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
      connect(disableCooling[1].outPlaces[1], Off_Temperature[1].inTransition[2]) annotation(
        Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
      connect(disableCooling[2].outPlaces[1], Off_Temperature[2].inTransition[2]) annotation(
        Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
      connect(disableCooling[3].outPlaces[1], Off_Temperature[3].inTransition[2]) annotation(
        Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
      connect(disableCooling[4].outPlaces[1], Off_Temperature[4].inTransition[2]) annotation(
        Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
      connect(disableCooling[5].outPlaces[1], Off_Temperature[5].inTransition[2]) annotation(
        Line(points = {{-39, 30}, {10.8, 30}, {10.8, -2.5}}, thickness = 0.5));
      connect(Cooling[1].outTransition[1], disableCooling[1].inPlaces[1]) annotation(
        Line(points = {{-82, 8.8}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-49, 30}}));
      annotation(
        Line(points = {{-60, -106}, {-60, -106}}, color = {255, 127, 0}),
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-200, 100}, {200, -100}}), Text(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-162, 34}, {152, -28}}, textString = "Managementebene")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>Struktur des MODI_Temperature-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Workshop_Heating</div><div>Workshop_Cooling</div><div>Canteen_Off</div><div>Canteen_Heating</div><div>Canteen_Cooling</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Heating</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Heating</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Off</div><div><div><div>OpenplanOffice_Heating</div><div></div></div><div>OpenplanOffice_Cooling</div><div><br></div><div><br></div><div><br></div></div><div><div><br></div><div><br></div><div><br></div><div><br></div></div><div><br></div></body></html>"),
        __OpenModelica_commandLineOptions = "");
    end ManagementEbene_Temp;

    model Feldebene "Auswahl der Aktoren basierend auf den ausgewählten Aktorsätzen"
      import Benchmark_fb;
      AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus1 annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {198, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.EONERC_MainBuilding.Controller.CtrGTFSimple ctrGTFSimple1 annotation(
        Placement(visible = true, transformation(origin = {-110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.EONERC_MainBuilding.Controller.CtrSWU ctrSWU1 annotation(
        Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl.CtrHP ctrHP1 annotation(
        Placement(visible = true, transformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.ModularAHU.Controller.CtrVentilationUnitTsetRoom ctrVentilationUnitTsetRoom1 annotation(
        Placement(visible = true, transformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput u[29] annotation(
        Placement(visible = true, transformation(origin = {2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
      AixLib.Systems.Benchmark.Controller.CtrTabs2 ctrTabs21 annotation(
        Placement(visible = true, transformation(origin = {-110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.Benchmark_fb.MODI.Controller_HTSSystem controller_HTSSystem1(T_boi_set = 273.15 + 80, T_chp_set = 333.15) annotation(
        Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.Benchmark.Controller.CtrHTSSystem ctrHTSSystem1 annotation(
        Placement(visible = true, transformation(origin = {-110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.Benchmark_fb.MODI.Controller.Controller_GTFSystem controller_GTFSystem1 annotation(
        Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark_fb.MODI.Controller.Controller_HPSystem controller_HPSystem1 annotation(
        Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(u[7], controller_HPSystem1.HP_Cooling) annotation(
        Line(points = {{0, 114}, {0, 44}, {-60, 44}}, color = {255, 0, 255}));
      connect(u[6], controller_HPSystem1.HP_Heating_II) annotation(
        Line(points = {{0, 114}, {0, 54}, {-59, 54}}, color = {255, 0, 255}));
      connect(u[5], controller_HPSystem1.HP_Heating_I) annotation(
        Line(points = {{0, 114}, {0, 58}, {-59, 58}}, color = {255, 0, 255}));
      connect(heatPumpSystemBus1, mainBus1.hpSystemBus) annotation(
        Line(points = {{-60, 50}, {100, 50}, {100, 0}}, color = {255, 204, 51}, thickness = 0.5));
      connect(u[9], controller_GTFSystem1.GTF_On) annotation(
        Line(points = {{0, 114}, {0, 76}, {-59, 76}}, color = {255, 0, 255}));
      connect(gtfBus, mainBus1.gtfBus) annotation(
        Line(points = {{-60, 64}, {100, 64}, {100, 0}}, color = {255, 204, 51}, thickness = 0.5));
      connect(highTempSystemBus1, mainBus1.htsBus) annotation(
        Line(points = {{-60, 90}, {100, 90}, {100, 0}}, color = {255, 204, 51}, thickness = 0.5));
      connect(u[2], controller_HTSSystem1.HTS_Heating_I) annotation(
        Line(points = {{0, 114}, {0, 96}, {-59, 96}}, color = {255, 0, 255}));
      connect(u[3], controller_HTSSystem1.HTS_Heating_II) annotation(
        Line(points = {{0, 114}, {0, 84}, {-59, 84}}, color = {255, 0, 255}));
      connect(mainBus1.htsBus, highTempSystemBus1) annotation(
        Line(points = {{100, 0}, {100, 0}, {100, 70}, {-60, 70}, {-60, 70}}, color = {255, 204, 51}, thickness = 0.5));
      connect(or1.y, htsBus.onOffChpSet) annotation(
        Line(points = {{-72, 70}, {-80, 70}, {-80, 70}, {-80, 70}}, color = {255, 0, 255}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-200, 100}, {200, -100}}), Text(origin = {-34, 16}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-74, 24}, {150, -48}}, textString = "Feldebene")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Feldebene;
  end Ebenen;

  package Controller
    model Controller_HTSSystem
      Modelica.Blocks.Sources.Constant rpmPumps(k = 3000) annotation(
        Placement(visible = true, transformation(extent = {{20, 30}, {40, 50}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant TChpSet(final k = T_chp_set) annotation(
        Placement(visible = true, transformation(extent = {{18, -50}, {38, -30}}, rotation = 0)));
      AixLib.Controls.Continuous.LimPID PIDBoiler(final yMax = 1, final yMin = 0, final controllerType = Modelica.Blocks.Types.SimpleController.PID, k = 0.01, Ti = 60, Td = 0, final reverseAction = false) annotation(
        Placement(visible = true, transformation(extent = {{20, -10}, {40, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant TBoilerSet_out(final k = T_boi_set) annotation(
        Placement(visible = true, transformation(extent = {{-20, -10}, {0, 10}}, rotation = 0)));
      parameter Real T_boi_set = 273.15 + 80 "Set point temperature of boiler";
      parameter Real T_chp_set = 333.15 "Set point temperature of chp";
      AixLib.Systems.Benchmark.BaseClasses.HighTempSystemBus highTempSystemBus1 annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput HTS_Heating_I annotation(
        Placement(visible = true, transformation(origin = {114, 60}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {114, 60}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput HTS_Heating_II annotation(
        Placement(visible = true, transformation(origin = {114, -60}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {114, -60}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or1 annotation(
        Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(HTS_Heating_II, highTempSystemBus1.pumpBoilerBus.pumpBus.onSet) annotation(
        Line(points = {{114, -60}, {-40, -60}, {-40, 20}, {100, 20}, {100, 0}, {100, 0}, {100, 0}}, color = {255, 0, 255}));
      connect(or1.y, highTempSystemBus1.pumpChpBus.pumpBus.onSet) annotation(
        Line(points = {{-58, 20}, {100, 20}, {100, 0}, {100, 0}, {100, 0}}, color = {255, 0, 255}));
      connect(or1.y, highTempSystemBus1.onOffChpSet) annotation(
        Line(points = {{-58, 20}, {100, 20}, {100, 0}, {100, 0}, {100, 0}}, color = {255, 0, 255}));
      connect(highTempSystemBus1.pumpBoilerBus.TRtrnInMea, PIDBoiler.u_m) annotation(
        Line(points = {{100, 0}, {60, 0}, {60, -20}, {30, -20}, {30, -12}, {30, -12}, {30, -12}}, color = {0, 0, 127}));
      connect(PIDBoiler.y, highTempSystemBus1.uRelBoilerSet) annotation(
        Line(points = {{42, 0}, {100, 0}, {100, 0}, {100, 0}}, color = {0, 0, 127}));
      connect(HTS_Heating_II, or1.u2) annotation(
        Line(points = {{114, -60}, {-100, -60}, {-100, 12}, {-84, 12}, {-84, 12}, {-82, 12}}, color = {255, 0, 255}));
      connect(HTS_Heating_I, or1.u1) annotation(
        Line(points = {{114, 60}, {-100, 60}, {-100, 20}, {-84, 20}, {-84, 20}, {-82, 20}}, color = {255, 0, 255}));
      connect(TBoilerSet_out.y, PIDBoiler.u_s) annotation(
        Line(points = {{1, 0}, {18, 0}}, color = {0, 0, 127}));
      connect(TChpSet.y, highTempSystemBus1.TChpSet) annotation(
        Line(points = {{39, -40}, {100, -40}, {100, 0}}, color = {0, 0, 127}));
      connect(rpmPumps.y, highTempSystemBus1.pumpChpBus.pumpBus.rpmSet) annotation(
        Line(points = {{41, 40}, {100, 40}, {100, 0}}, color = {0, 0, 127}));
      connect(rpmPumps.y, highTempSystemBus1.pumpBoilerBus.pumpBus.rpmSet) annotation(
        Line(points = {{41, 40}, {100, 40}, {100, 0}}, color = {0, 0, 127}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Line(points = {{20, 80}, {80, 0}, {40, -80}}, color = {95, 95, 95}, thickness = 0.5), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-80, 20}, {66, -20}}, textString = "Control"), Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-30, 0}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-48, 24}, {98, -16}}, textString = "Controller HTS_System")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Controller_HTSSystem;

    model Controller_GTFSystem
     Modelica.Blocks.Math.BooleanToReal booleanToReal
        annotation (Placement(visible = true, transformation(origin = {50, 10},extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanInput GTF_On
                                       "Connector of Boolean input signal"
        annotation (Placement(visible = true,transformation(origin = {108, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 180),
            iconTransformation(origin = {108, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant rpm(k=rpmPump)
        annotation (Placement(visible = true, transformation(extent = {{0, -70}, {20, -50}}, rotation = 0)));
      parameter Real rpmPump(min=0, unit="1") = 2100 "Rpm of the pump";
  AixLib.Systems.EONERC_MainBuilding.BaseClasses.TwoCircuitBus gtfBus annotation(
        Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(rpm.y, gtfBus.primBus.pumpBus.rpmSet) annotation(
        Line(points = {{22, -60}, {100, -60}, {100, -60}, {100, -60}}, color = {0, 0, 127}));
      connect(GTF_On, gtfBus.primBus.pumpBus.onSet) annotation(
        Line(points = {{108, 60}, {80, 60}, {80, -60}, {98, -60}, {98, -60}, {100, -60}}, color = {255, 0, 255}));
      connect(booleanToReal.y, gtfBus.secBus.valveSet) annotation(
        Line(points = {{50, -1}, {50, -60}, {100, -60}}, color = {0, 0, 127}));
      connect(booleanToReal.u, GTF_On) annotation(
        Line(points = {{50, 22}, {50, 60}, {108, 60}}, color = {255, 0, 255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={
                                             Line(
              points={{20,80},{80,0},{40,-80}},
              color={95,95,95},
              thickness=0.5),
Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-80, 20}, {66, -20}}, textString = "Control"), Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-26, 2},lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-48, 22}, {98, -18}}, textString = "Controller_GTFSystem")}),
                                    Diagram(coordinateSystem(preserveAspectRatio=
                false)),
        Documentation(revisions="<html>
    <ul>
    <li>January 22, 2019, by Alexander K&uuml;mpel:<br/>External T_set added.</li>
    <li>October 25, 2017, by Alexander K&uuml;mpel:<br/>First implementation.</li>
    </ul>
    </html>", info="<html>
    <p>Simple controller for admix and injection circuit. The controlled variable is the outflow temperature T_fwrd_out.</p>
    </html>"));

    end Controller_GTFSystem;

    model Controller_HPSystem
    Modelica.Blocks.Interfaces.BooleanInput HP_Heating_II annotation(
        Placement(visible = true, transformation(origin = {106, 40}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, 40}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanInput HP_Heating_I annotation(
        Placement(visible = true, transformation(origin = {106, 80}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, 80}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanInput HP_Cooling annotation(
        Placement(visible = true, transformation(origin = {104, -60}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {104, -60}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
  AixLib.Systems.EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus heatPumpSystemBus1 annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
annotation (Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-24, -2},lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-48, 24}, {98, -16}}, textString = "Controller_HPSystem")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Controller_HPSystem;

    model Controller_SwitchingUnit
    AixLib.Systems.EONERC_MainBuilding.BaseClasses.SwitchingUnitBus switchingUnitBus1 annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput u annotation(
        Placement(visible = true, transformation(origin = {105, 61}, extent = {{-11, -11}, {11, 11}}, rotation = 180), iconTransformation(origin = {105, 61}, extent = {{-11, -11}, {11, 11}}, rotation = 180)));
    equation
annotation (Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-24, -2},lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-48, 24}, {98, -16}}, textString = "Controller_SwitchingUnit")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Controller_SwitchingUnit;
  end Controller;
end MODI;
