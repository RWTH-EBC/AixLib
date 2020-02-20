within AixLib.Systems.Benchmark_fb;

package MODI
  model ManagementEbene_Temp_Hum "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten für die Temperature und relative Luftfeuchtigkeit im Raum"
    PNlib.Components.T disableHeating[5](each nIn = 1, each nOut = 1, firingCon = {mainBus.TRoom1Mea > 273.15 + 15, mainBus.TRoom2Mea > 273.15 + 20, mainBus.TRoom3Mea > 273.15 + 20, mainBus.TRoom4Mea > 273.15 + 20, mainBus.TRoom5Mea > 273.15 + 20}) annotation(
      Placement(visible = true, transformation(origin = {-56, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T enableHeating[5](each nIn = 1, each nOut = 1, firingCon = {mainBus.TRoom1Mea < 273.15 + 13, mainBus.TRoom2Mea < 273.15 + 18, mainBus.TRoom3Mea < 273.15 + 18, mainBus.TRoom4Mea < 273.15 + 18, mainBus.TRoom5Mea < 273.15 + 18}) annotation(
      Placement(visible = true, transformation(extent = {{-66, 20}, {-46, 40}}, rotation = 0)));
    PNlib.Components.PD Heating[5](each nIn = 1, each nOut = 1, each startTokens = 0, each minTokens = 0, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD Off_Temperature[5](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1, each reStart = true, each reStartTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Cooling[5](each nIn = 1, each nOut = 1, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-182, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T enableCooling[5](each nIn = 1, each nOut = 1, firingCon = {mainBus.TRoom1Mea > 273.15 + 17, mainBus.TRoom2Mea > 273.15 + 22, mainBus.TRoom3Mea > 273.15 + 22, mainBus.TRoom4Mea > 273.15 + 22, mainBus.TRoom5Mea > 273.15 + 22}) annotation(
      Placement(visible = true, transformation(origin = {-144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T disableCooling[5](each nIn = 1, each nOut = 1, firingCon = {mainBus.TRoom1Mea < 273.15 + 15, mainBus.TRoom2Mea < 273.15 + 20, mainBus.TRoom3Mea < 273.15 + 20, mainBus.TRoom4Mea < 273.15 + 20, mainBus.TRoom5Mea < 273.15 + 20}) annotation(
      Placement(visible = true, transformation(extent = {{-154, 20}, {-134, 40}}, rotation = 0)));
    PNlib.Components.PD Dehumidifying[5](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD Off_Humidity[5](each nIn = 2, each nOut = 2, each reStartTokens = 1, each startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Humidifying[5](each nIn = 1, each nOut = 1, each reStartTokens = 1, each startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {184, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T enableHumidifying[5](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {146, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T enableDehumidifying[5](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {58, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T disableDehumidifying[5](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {56, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T disableHumidifying[5](each nIn = 1, each nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Benchmark.BaseClasses.MainBus mainBus annotation(
      Placement(transformation(extent = {{-10, 86}, {10, 106}})));
  Modelica.Blocks.Interfaces.RealOutput y[30] annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
  y[1]=Off_Temperature[1].t;
  y[2]=Heating[1].t;
  y[3]=Cooling[1].t;
  y[4]=Off_Temperature[2].t;
  y[5]=Heating[2].t;
  y[6]=Cooling[2].t;
  y[7]=Off_Temperature[3].t;
  y[8]=Heating[3].t;
  y[9]=Cooling[3].t;
  y[10]=Off_Temperature[4].t;
  y[11]=Heating[4].t;
  y[12]=Cooling[4].t;
  y[13]=Off_Temperature[5].t;
  y[14]=Heating[5].t;
  y[15]=Cooling[5].t;
  
  y[16]=Off_Humidity[1].t;
  y[17]=Humidifying[1].t;
  y[18]=Dehumidifying[1].t;
  y[19]=Off_Humidity[2].t;
  y[20]=Humidifying[2].t;
  y[21]=Dehumidifying[2].t;
  y[22]=Off_Humidity[3].t;
  y[23]=Humidifying[3].t;
  y[24]=Dehumidifying[3].t;
  y[25]=Off_Humidity[4].t;
  y[26]=Humidifying[4].t;
  y[27]=Dehumidifying[4].t;
  y[28]=Off_Humidity[5].t;
  y[29]=Humidifying[5].t;
  y[30]=Dehumidifying[5].t;
  
  
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
      Documentation(info = "<html><head></head><body>Struktur des MODI_Temperature-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Canteen_Off</div><div>ConferenceRoom_Off</div><div>MultipersonOffice_Off</div><div>OpenplanOffice_Off</div><div><div>Workshop_Heating</div><div>Canteen_Heating</div><div>ConferenceRoom_Heating</div><div>MultipersonOffice_Heating</div><div>OpenplanOffice_Heating</div></div><div><div>Workshop_Cooling</div><div>Canteen_Cooling</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Cooling</div></div><div><br></div><div>Struktur des MODI_Humidity-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Canteen_Off</div><div>ConferenceRoom_Off</div><div>MultipersonOffice_Off</div><div>OpenplanOffice_Off</div><div><div>Workshop_Humidifying</div><div>Canteen_Humidifying</div><div>ConferenceRoom_Humidifying</div><div>MultipersonOffice_Humidifying</div><div>OpenplanOffice_Humidifying</div></div><div><div>Workshop_Dehumidifying</div><div>Canteen_Dehumidifying</div><div>ConferenceRoom_Dehumidifying</div><div>MultipersonOffice_Dehumidifying</div><div>OpenplanOffice_Dehumidifying</div></div></div></body></html>"),
      __OpenModelica_commandLineOptions = "");
  end ManagementEbene_Temp_Hum;

  model Automatisierungsebene "Zuordnung der Betriebsmodi zu den entsprechenden Aktorsätzen"
    Modelica.Blocks.Interfaces.IntegerInput MODI_Temperature[15] annotation(
      Placement(visible = true, transformation(origin = {-30, 440}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-30, 440}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.IntegerOutput y[75] annotation(
      Placement(visible = true, transformation(origin = {364, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {364, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD Workshop_RLT_Heating_I_M00(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {98, 382}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T11(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Workshop_RLT_Cooling_I_M00(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-70, 384}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T16(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Workshop_RLT_Heating_Off_M01(nIn = 2, nOut = 2, startTokens = 1, maxTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{22, 350}, {42, 370}}, rotation = 0)));
    PNlib.Components.PD Workshop_RLT_Heating_II_M00(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {98, 338}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 370}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T12(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T13(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T15(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {108, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T14(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {88, 360}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD Workshop_RLT_Cooling_Off_M00(nIn = 2, nOut = 2, startTokens = 1, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-4, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Workshop_RLT_Cooling_II_M00(nIn = 2, nOut = 2, startTokens = 0, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-70, 338}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T17(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 370}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T18(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T19(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T110(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-80, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T111(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-60, 360}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T113(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 250}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T114(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T115(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Workshop_BKT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, 258}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T116(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-60, 280}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T117(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-80, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD Workshop_BKT_Cooling_Off_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-4, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T118(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {88, 280}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T119(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {108, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD Workshop_BKT_Heatin_Off_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(extent = {{22, 270}, {42, 290}}, rotation = 0)));
    PNlib.Components.T T120(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T121(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Workshop_BKT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, 302}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Workshop_BKT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {98, 302}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T122(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {-32, 310}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T123(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 310}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T112(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {62, 250}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Workshop_BKT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
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
    PNlib.Components.T T142(nIn = 1, nOut = 1) annotation(
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
    PNlib.Components.T T165(nIn = 1, nOut = 1) annotation(
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
    PNlib.Components.T T172(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T173(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T174(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD OpenplanOffice_BKT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD OpenplanOffice_BKT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 134}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T175(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {160, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD OpenplanOffice_BKT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T176(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T177(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD OpenplanOffice_BKT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 102}, {280, 122}}, rotation = 0)));
    PNlib.Components.T T178(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {346, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T179(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {326, 112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD OpenplanOffice_BKT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T180(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {180, 112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T181(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T182(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T183(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T184(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 162}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD OpenplanOffice_RLT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {168, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T185(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 162}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD OpenplanOffice_RLT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T186(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 182}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T187(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 182}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T188(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {178, 192}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T189(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {160, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD OpenplanOffice_RLT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T190(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {326, 192}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T191(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {346, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD OpenplanOffice_RLT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 182}, {280, 202}}, rotation = 0)));
    PNlib.Components.PD OpenplanOffice_RLT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {168, 214}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD OpenplanOffice_RLT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 214}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T192(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 202}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T193(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 202}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T194(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 222}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T195(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 222}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T196(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 250}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T197(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 250}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD MultipersonOffice_BKT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 258}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T198(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T199(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1100(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {180, 280}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD MultipersonOffice_BKT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1101(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {326, 280}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T1102(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {346, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD MultipersonOffice_BKT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 270}, {280, 290}}, rotation = 0)));
    PNlib.Components.PD MultipersonOffice_BKT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 258}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1103(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {160, 280}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T1104(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1105(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD MultipersonOffice_BKT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {170, 302}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD MultipersonOffice_BKT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 302}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1106(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 310}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1107(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 310}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD MultipersonOffice_RLT_Heating_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 338}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1108(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD MultipersonOffice_RLT_Cooling_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {168, 338}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1109(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD MultipersonOffice_RLT_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 350}, {280, 370}}, rotation = 0)));
    PNlib.Components.T T1110(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {346, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T1111(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {326, 360}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD MultipersonOffice_RLT_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1112(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {160, 360}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T1113(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {178, 360}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T1114(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1115(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1116(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 370}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1117(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 370}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD MultipersonOffice_RLT_Heating_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {336, 382}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD MultipersonOffice_RLT_Cooling_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {168, 382}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1118(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1119(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1120(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1121(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD RLT_Central_Cooling_II_M00(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {170, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1122(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1123(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD RLT_Central_Heating_II_M00(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {336, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1124(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {160, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD RLT_Central_Heating_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{260, 6}, {280, 26}}, rotation = 0)));
    PNlib.Components.T T1125(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {346, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T T1126(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {326, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD RLT_Central_Cooling_Off_M00(maxTokens = 1, nIn = 2, nOut = 2, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {238, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1127(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {180, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T1128(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1129(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD RLT_Central_Heating_I_M00(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {336, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD RLT_Central_Cooling_I_M00(nIn = 2, nOut = 2, maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {170, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1130(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {300, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1131(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {206, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1133(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1135(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {448, 200}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T1136(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {468, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD Generation_Hot_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{382, 190}, {402, 210}}, rotation = 0)));
    PNlib.Components.PD Generation_Hot_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 178}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1139(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1141(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1143(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 230}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Generation_Hot_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 222}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1144(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1146(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Generation_Warm_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Generation_Warm_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{382, 98}, {402, 118}}, rotation = 0)));
    PNlib.Components.T T1148(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {471, 107}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
    PNlib.Components.T T1149(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {449, 107}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
    PNlib.Components.T T1151(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.PD Generation_Warm_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1153(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 138}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Generation_Cold_I_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1132(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1134(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {448, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.T T1137(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {468, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.PD Generation_Cold_Off_M00(nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation(
      Placement(visible = true, transformation(extent = {{382, 8}, {402, 28}}, rotation = 0)));
    PNlib.Components.PD Generation_Cold_II_M00(nIn = 2, nOut = 2) annotation(
      Placement(visible = true, transformation(origin = {458, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1138(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.Components.T T1140(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T T1142(nIn = 1, nOut = 1) annotation(
      Placement(visible = true, transformation(origin = {422, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Interfaces.IntegerInput MODI_Humidity annotation(
      Placement(visible = true, transformation(origin = {30, 440}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {30, 440}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  equation
    connect(T1126.outPlaces[1], RLT_Central_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 11.2}, {326, 11.2}, {326, 6}, {320, 6}, {320, -6}, {325.2, -6}, {325.2, -5.5}}, thickness = 0.5));
    connect(T1122.outPlaces[1], RLT_Central_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 6}, {320, 6}, {320, -6}, {324, -6}, {324, -6.5}, {325.2, -6.5}}, thickness = 0.5));
    connect(RLT_Central_Heating_II_M00.outTransition[2], T1125.inPlaces[1]) annotation(
      Line(points = {{346.8, -5.5}, {350, -5.5}, {350, 6}, {346, 6}, {346, 10}, {346, 11.2}, {346, 11.2}}, thickness = 0.5));
    connect(RLT_Central_Heating_II_M00.outTransition[1], T1120.inPlaces[1]) annotation(
      Line(points = {{346.8, -6.5}, {350, -6.5}, {350, -18}, {316, -18}, {316, -14}, {304, -14}, {304, -14}, {304.8, -14}}, thickness = 0.5));
    connect(RLT_Central_Heating_I_M00.outTransition[2], T1126.inPlaces[1]) annotation(
      Line(points = {{325.2, 37.5}, {320, 37.5}, {320, 26}, {326, 26}, {326, 22}, {326, 20.8}, {326, 20.8}}, thickness = 0.5));
    connect(RLT_Central_Heating_I_M00.outTransition[1], T1130.inPlaces[1]) annotation(
      Line(points = {{325.2, 38.5}, {320, 38.5}, {320, 46}, {306, 46}, {306, 46}, {304.8, 46}}, thickness = 0.5));
    connect(T1125.outPlaces[1], RLT_Central_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 20.8}, {346, 20.8}, {346, 26}, {350, 26}, {350, 38}, {346.8, 38}, {346.8, 37.5}}, thickness = 0.5));
    connect(T1128.outPlaces[1], RLT_Central_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 26}, {350, 26}, {350, 38}, {346, 38}, {346, 38.5}, {346.8, 38.5}}, thickness = 0.5));
    connect(T179.outPlaces[1], OpenplanOffice_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 107.2}, {326, 107.2}, {326, 102}, {320, 102}, {320, 90}, {325.2, 90}, {325.2, 90.5}}, thickness = 0.5));
    connect(T181.outPlaces[1], OpenplanOffice_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 102}, {320, 102}, {320, 90}, {324, 90}, {324, 89.5}, {325.2, 89.5}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_II_M00.outTransition[2], T178.inPlaces[1]) annotation(
      Line(points = {{346.8, 90.5}, {350, 90.5}, {350, 102}, {346, 102}, {346, 106}, {346, 107.2}, {346, 107.2}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_II_M00.outTransition[1], T172.inPlaces[1]) annotation(
      Line(points = {{346.8, 89.5}, {350, 89.5}, {350, 78}, {318, 78}, {318, 82}, {304.8, 82}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_I_M00.outTransition[2], T179.inPlaces[1]) annotation(
      Line(points = {{325.2, 133.5}, {320, 133.5}, {320, 122}, {326, 122}, {326, 118}, {326, 116.8}, {326, 116.8}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_I_M00.outTransition[1], T173.inPlaces[1]) annotation(
      Line(points = {{325.2, 134.5}, {320, 134.5}, {320, 142}, {304, 142}, {304, 142}, {304.8, 142}}, thickness = 0.5));
    connect(T178.outPlaces[1], OpenplanOffice_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 116.8}, {346, 116.8}, {346, 122}, {350, 122}, {350, 134}, {346.8, 134}, {346.8, 133.5}}, thickness = 0.5));
    connect(T176.outPlaces[1], OpenplanOffice_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 122}, {350, 122}, {350, 134}, {346, 134}, {346, 134}, {346, 134.5}, {346.8, 134.5}}, thickness = 0.5));
    connect(T190.outPlaces[1], OpenplanOffice_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 187.2}, {326, 187.2}, {326, 182}, {320, 182}, {320, 170}, {325.2, 170}, {325.2, 170.5}}, thickness = 0.5));
    connect(T187.outPlaces[1], OpenplanOffice_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 182}, {320, 182}, {320, 170}, {324, 170}, {324, 169.5}, {325.2, 169.5}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_II_M00.outTransition[2], T191.inPlaces[1]) annotation(
      Line(points = {{346.8, 170.5}, {350, 170.5}, {350, 182}, {344, 182}, {344, 186}, {346, 186}, {346, 187.2}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_II_M00.outTransition[1], T185.inPlaces[1]) annotation(
      Line(points = {{346.8, 169.5}, {350, 169.5}, {350, 158}, {320, 158}, {320, 162}, {306, 162}, {306, 162}, {304.8, 162}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_I_M00.outTransition[2], T190.inPlaces[1]) annotation(
      Line(points = {{325.2, 213.5}, {320, 213.5}, {320, 202}, {320, 202}, {320, 202}, {326, 202}, {326, 196.8}, {326, 196.8}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_I_M00.outTransition[1], T194.inPlaces[1]) annotation(
      Line(points = {{325.2, 214.5}, {320, 214.5}, {320, 222}, {304, 222}, {304, 222}, {304.8, 222}}, thickness = 0.5));
    connect(T191.outPlaces[1], OpenplanOffice_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 196.8}, {346, 196.8}, {346, 202}, {350, 202}, {350, 214}, {348, 214}, {348, 213.5}, {346.8, 213.5}}, thickness = 0.5));
    connect(T193.outPlaces[1], OpenplanOffice_RLT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 202}, {350, 202}, {350, 214}, {348, 214}, {348, 214.5}, {346.8, 214.5}}, thickness = 0.5));
    connect(T1101.outPlaces[1], MultipersonOffice_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 275.2}, {326, 275.2}, {326, 270}, {322, 270}, {322, 258}, {325.2, 258}, {325.2, 258.5}}, thickness = 0.5));
    connect(T199.outPlaces[1], MultipersonOffice_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 270}, {322, 270}, {322, 258}, {326, 258}, {326, 257.5}, {325.2, 257.5}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_II_M00.outTransition[2], T1102.inPlaces[1]) annotation(
      Line(points = {{346.8, 258.5}, {350, 258.5}, {350, 270}, {346, 270}, {346, 274}, {346, 275.2}, {346, 275.2}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_II_M00.outTransition[1], T197.inPlaces[1]) annotation(
      Line(points = {{346.8, 257.5}, {350, 257.5}, {350, 246}, {318, 246}, {318, 250}, {306, 250}, {306, 250}, {304.8, 250}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_I_M00.outTransition[2], T1101.inPlaces[1]) annotation(
      Line(points = {{325.2, 301.5}, {322, 301.5}, {322, 290}, {326, 290}, {326, 286}, {326, 284.8}, {326, 284.8}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_I_M00.outTransition[1], T1107.inPlaces[1]) annotation(
      Line(points = {{325.2, 302.5}, {322, 302.5}, {322, 310}, {306, 310}, {306, 310}, {304.8, 310}}, thickness = 0.5));
    connect(T1102.outPlaces[1], MultipersonOffice_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 284.8}, {346, 284.8}, {346, 290}, {350, 290}, {350, 302}, {346.8, 302}, {346.8, 301.5}}, thickness = 0.5));
    connect(T1105.outPlaces[1], MultipersonOffice_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 290}, {350, 290}, {350, 302}, {348, 302}, {348, 302.5}, {346.8, 302.5}}, thickness = 0.5));
    connect(T1127.outPlaces[1], RLT_Central_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{180, 11.2}, {180, 11.2}, {180, 6}, {184, 6}, {184, -6}, {180, -6}, {180, -6.5}, {180.8, -6.5}}, thickness = 0.5));
    connect(T1123.outPlaces[1], RLT_Central_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 6}, {184, 6}, {184, -6}, {180, -6}, {180, -5.5}, {180.8, -5.5}}, thickness = 0.5));
    connect(RLT_Central_Cooling_II_M00.outTransition[2], T1124.inPlaces[1]) annotation(
      Line(points = {{159.2, -6.5}, {154, -6.5}, {154, 6}, {160, 6}, {160, 12}, {160, 11.2}, {160, 11.2}}, thickness = 0.5));
    connect(RLT_Central_Cooling_II_M00.outTransition[1], T1121.inPlaces[1]) annotation(
      Line(points = {{159.2, -5.5}, {154, -5.5}, {154, -20}, {190, -20}, {190, -14}, {202, -14}, {202, -14}, {201.2, -14}}, thickness = 0.5));
    connect(RLT_Central_Cooling_I_M00.outTransition[2], T1127.inPlaces[1]) annotation(
      Line(points = {{180.8, 38.5}, {184, 38.5}, {184, 26}, {180, 26}, {180, 22}, {180, 20.8}, {180, 20.8}}, thickness = 0.5));
    connect(RLT_Central_Cooling_I_M00.outTransition[1], T1131.inPlaces[1]) annotation(
      Line(points = {{180.8, 37.5}, {184, 37.5}, {184, 46}, {201.2, 46}}, thickness = 0.5));
    connect(T1124.outPlaces[1], RLT_Central_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 20.8}, {160, 20.8}, {160, 26}, {154, 26}, {154, 38}, {159.2, 38}, {159.2, 38.5}}, thickness = 0.5));
    connect(T1129.outPlaces[1], RLT_Central_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 26}, {154, 26}, {154, 38}, {158, 38}, {158, 37.5}, {159.2, 37.5}}, thickness = 0.5));
    connect(T180.outPlaces[1], OpenplanOffice_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{180, 107.2}, {184, 107.2}, {184, 90}, {182, 90}, {182, 89.5}, {180.8, 89.5}}, thickness = 0.5));
    connect(T182.outPlaces[1], OpenplanOffice_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 102}, {184, 102}, {184, 90}, {182, 90}, {182, 90.5}, {180.8, 90.5}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_II_M00.outTransition[2], T175.inPlaces[1]) annotation(
      Line(points = {{159.2, 89.5}, {156, 89.5}, {156, 102}, {160, 102}, {160, 106}, {160, 107.2}, {160, 107.2}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_II_M00.outTransition[1], T183.inPlaces[1]) annotation(
      Line(points = {{159.2, 90.5}, {156, 90.5}, {156, 76}, {190, 76}, {190, 82}, {200, 82}, {200, 82}, {201.2, 82}, {201.2, 82}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_I_M00.outTransition[2], T180.inPlaces[1]) annotation(
      Line(points = {{180.8, 134.5}, {184, 134.5}, {184, 122}, {180, 122}, {180, 118}, {180, 116.8}, {180, 116.8}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_I_M00.outTransition[1], T174.inPlaces[1]) annotation(
      Line(points = {{180.8, 133.5}, {184, 133.5}, {184, 142}, {200, 142}, {200, 142}, {201.2, 142}}, thickness = 0.5));
    connect(T175.outPlaces[1], OpenplanOffice_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 116.8}, {160, 116.8}, {160, 122}, {154, 122}, {154, 134}, {159.2, 134}, {159.2, 134.5}}, thickness = 0.5));
    connect(T177.outPlaces[1], OpenplanOffice_BKT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 122}, {154, 122}, {154, 134}, {158, 134}, {158, 133.5}, {159.2, 133.5}}, thickness = 0.5));
    connect(T188.outPlaces[1], OpenplanOffice_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{178, 187.2}, {178, 187.2}, {178, 182}, {184, 182}, {184, 170}, {178.8, 170}, {178.8, 169.5}}, thickness = 0.5));
    connect(T186.outPlaces[1], OpenplanOffice_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 182}, {184, 182}, {184, 170}, {180, 170}, {180, 170.5}, {178.8, 170.5}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_II_M00.outTransition[2], T189.inPlaces[1]) annotation(
      Line(points = {{157.2, 169.5}, {154, 169.5}, {154, 182}, {160, 182}, {160, 186}, {160, 187.2}, {160, 187.2}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_II_M00.outTransition[1], T184.inPlaces[1]) annotation(
      Line(points = {{157.2, 170.5}, {154, 170.5}, {154, 156}, {190, 156}, {190, 162}, {201.2, 162}, {201.2, 162}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_I_M00.outTransition[2], T188.inPlaces[1]) annotation(
      Line(points = {{178.8, 214.5}, {182, 214.5}, {182, 202}, {176, 202}, {176, 196}, {178, 196}, {178, 196.8}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_I_M00.outTransition[1], T195.inPlaces[1]) annotation(
      Line(points = {{178.8, 213.5}, {182, 213.5}, {182, 222}, {201.2, 222}}, thickness = 0.5));
    connect(T189.outPlaces[1], OpenplanOffice_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 196.8}, {160, 196.8}, {160, 202}, {152, 202}, {152, 214}, {157.2, 214}, {157.2, 214.5}}, thickness = 0.5));
    connect(T192.outPlaces[1], OpenplanOffice_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 202}, {152, 202}, {152, 214}, {158, 214}, {158, 213.5}, {157.2, 213.5}}, thickness = 0.5));
    connect(T1100.outPlaces[1], MultipersonOffice_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{180, 275.2}, {180, 275.2}, {180, 270}, {184, 270}, {184, 258}, {180.8, 258}, {180.8, 257.5}}, thickness = 0.5));
    connect(T198.outPlaces[1], MultipersonOffice_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 270}, {184, 270}, {184, 258}, {182, 258}, {182, 258.5}, {180.8, 258.5}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_II_M00.outTransition[2], T1103.inPlaces[1]) annotation(
      Line(points = {{159.2, 257.5}, {154, 257.5}, {154, 270}, {160, 270}, {160, 274}, {160, 275.2}, {160, 275.2}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_II_M00.outTransition[1], T196.inPlaces[1]) annotation(
      Line(points = {{159.2, 258.5}, {154, 258.5}, {154, 244}, {192, 244}, {192, 250}, {201.2, 250}, {201.2, 250}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_I_M00.outTransition[2], T1100.inPlaces[1]) annotation(
      Line(points = {{180.8, 302.5}, {186, 302.5}, {186, 290}, {180, 290}, {180, 284}, {180, 284.8}, {180, 284.8}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_I_M00.outTransition[1], T1106.inPlaces[1]) annotation(
      Line(points = {{180.8, 301.5}, {186, 301.5}, {186, 310}, {200, 310}, {200, 310}, {201.2, 310}}, thickness = 0.5));
    connect(T1103.outPlaces[1], MultipersonOffice_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 284.8}, {160, 284.8}, {160, 290}, {154, 290}, {154, 302}, {159.2, 302}, {159.2, 302.5}}, thickness = 0.5));
    connect(T1104.outPlaces[1], MultipersonOffice_BKT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 290}, {154, 290}, {154, 301.5}, {159.2, 301.5}}, thickness = 0.5));
    connect(T1113.outPlaces[1], MultipersonOffice_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{178, 355.2}, {178, 355.2}, {178, 350}, {184, 350}, {184, 338}, {178.8, 338}, {178.8, 337.5}}, thickness = 0.5));
    connect(T1115.outPlaces[1], MultipersonOffice_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 350}, {184, 350}, {184, 338}, {180, 338}, {180, 338.5}, {178.8, 338.5}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_Off_M00.outTransition[2], T1115.inPlaces[1]) annotation(
      Line(points = {{227.2, 359.5}, {222, 359.5}, {222, 350}, {212, 350}, {212, 350}, {210.8, 350}, {210.8, 350}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_II_M00.outTransition[2], T1112.inPlaces[1]) annotation(
      Line(points = {{157.2, 337.5}, {154, 337.5}, {154, 352}, {160, 352}, {160, 356}, {160, 355.2}, {160, 355.2}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_II_M00.outTransition[1], T1109.inPlaces[1]) annotation(
      Line(points = {{157.2, 338.5}, {154, 338.5}, {154, 322}, {188, 322}, {188, 332}, {200, 332}, {200, 330}, {201.2, 330}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_I_M00.outTransition[2], T1113.inPlaces[1]) annotation(
      Line(points = {{178.8, 382.5}, {184, 382.5}, {184, 370}, {178, 370}, {178, 366}, {178, 364.8}, {178, 364.8}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_I_M00.outTransition[1], T1118.inPlaces[1]) annotation(
      Line(points = {{178.8, 381.5}, {184, 381.5}, {184, 390}, {202, 390}, {202, 390}, {201.2, 390}}, thickness = 0.5));
    connect(T1112.outPlaces[1], MultipersonOffice_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{160, 364.8}, {160, 364.8}, {160, 370}, {150, 370}, {150, 382}, {157.2, 382}, {157.2, 382.5}}, thickness = 0.5));
    connect(T1117.outPlaces[1], MultipersonOffice_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{201.2, 370}, {150, 370}, {150, 382}, {156, 382}, {156, 381.5}, {157.2, 381.5}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_I_M00.pd_t, y[11]) annotation(
      Line(points = {{-70, 312.6}, {-96, 312.6}, {-96, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -86.8}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Cooling_II_M00.pd_t, y[12]) annotation(
      Line(points = {{-70, 247.4}, {-96, 247.4}, {-96, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -87.0667}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Cooling_Off_M00.pd_t, y[10]) annotation(
      Line(points = {{-4, 269.4}, {-4, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -86.5333}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Heating_II_M00.pd_t, y[9]) annotation(
      Line(points = {{98, 268.6}, {140, 268.6}, {140, -60}, {364, -60}, {364, -86.2667}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Heating_I_M00.pd_t, y[8]) annotation(
      Line(points = {{98, 291.4}, {140, 291.4}, {140, -60}, {364, -60}, {364, -86}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Heatin_Off_M00.pd_t, y[7]) annotation(
      Line(points = {{32, 290.6}, {32, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -85.7333}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Cooling_II_M00.pd_t, y[6]) annotation(
      Line(points = {{-70, 327.4}, {-96, 327.4}, {-96, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -85.4667}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Cooling_Off_M00.pd_t, y[4]) annotation(
      Line(points = {{-4, 349.4}, {-6, 349.4}, {-6, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -84.9333}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Cooling_I_M00.pd_t, y[5]) annotation(
      Line(points = {{-70, 394.6}, {-96, 394.6}, {-96, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -85.2}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Heating_II_M00.pd_t, y[3]) annotation(
      Line(points = {{98, 348.6}, {140, 348.6}, {140, -60}, {364, -60}, {364, -84.6667}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Cooling_Off_M00.pd_t, y[40]) annotation(
      Line(points = {{238, 349.4}, {238, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -94.5333}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Cooling_I_M00.pd_t, y[41]) annotation(
      Line(points = {{168, 392.6}, {140, 392.6}, {140, -60}, {364, -60}, {364, -94.8}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Cooling_II_M00.pd_t, y[42]) annotation(
      Line(points = {{168, 327.4}, {140, 327.4}, {140, -60}, {364, -60}, {364, -95.0667}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Cooling_II_M00.pd_t, y[48]) annotation(
      Line(points = {{170, 247.4}, {140, 247.4}, {140, -60}, {364, -60}, {364, -96.6667}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Cooling_I_M00.pd_t, y[47]) annotation(
      Line(points = {{170, 312.6}, {140, 312.6}, {140, -60}, {364, -60}, {364, -96.4}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Cooling_Off_M00.pd_t, y[46]) annotation(
      Line(points = {{238, 269.4}, {238, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -96.1333}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Heating_II_M00.pd_t, y[39]) annotation(
      Line(points = {{336, 348.6}, {364, 348.6}, {364, -94.2667}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Heating_I_M00.pd_t, y[38]) annotation(
      Line(points = {{336, 371.4}, {364, 371.4}, {364, -94}}, color = {255, 127, 0}));
    connect(MultipersonOffice_RLT_Heating_Off_M00.pd_t, y[37]) annotation(
      Line(points = {{270, 370.6}, {272, 370.6}, {272, 412}, {364, 412}, {364, -93.7333}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Heating_II_M00.pd_t, y[45]) annotation(
      Line(points = {{336, 268.6}, {364, 268.6}, {364, -95.8667}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Heating_I_M00.pd_t, y[44]) annotation(
      Line(points = {{336, 291.4}, {364, 291.4}, {364, -95.6}}, color = {255, 127, 0}));
    connect(MultipersonOffice_BKT_Heating_Off_M00.pd_t, y[43]) annotation(
      Line(points = {{270, 290.6}, {270, 236}, {364, 236}, {364, -95.3333}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Cooling_Off_M00.pd_t, y[52]) annotation(
      Line(points = {{238, 181.4}, {238, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -97.7333}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Heating_Off_M00.pd_t, y[49]) annotation(
      Line(points = {{270, 202.6}, {270, 236}, {364, 236}, {364, -96.9333}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Cooling_I_M00.pd_t, y[53]) annotation(
      Line(points = {{168, 224.6}, {140, 224.6}, {140, -60}, {364, -60}, {364, -98}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Cooling_II_M00.pd_t, y[54]) annotation(
      Line(points = {{168, 159.4}, {140, 159.4}, {140, -60}, {364, -60}, {364, -98.2667}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Heating_II_M00.pd_t, y[51]) annotation(
      Line(points = {{336, 180.6}, {364, 180.6}, {364, -97.4667}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Heating_Off_M01.pd_t, y[1]) annotation(
      Line(points = {{32, 370.6}, {32, 410}, {140, 410}, {140, -60}, {364, -60}, {364, -84.1333}}, color = {255, 127, 0}));
    connect(Workshop_RLT_Heating_I_M00.pd_t, y[2]) annotation(
      Line(points = {{98, 371.4}, {140, 371.4}, {140, -60}, {364, -60}, {364, -84.4}}, color = {255, 127, 0}));
    connect(Generation_Cold_Off_M00.pd_t, y[73]) annotation(
      Line(points = {{392, 28.6}, {364, 28.6}, {364, -103.333}}, color = {255, 127, 0}));
    connect(Generation_Cold_I_M00.pd_t, y[74]) annotation(
      Line(points = {{458, 29.4}, {486, 29.4}, {486, -60}, {364, -60}, {364, -103.6}}, color = {255, 127, 0}));
    connect(Generation_Cold_II_M00.pd_t, y[75]) annotation(
      Line(points = {{458, 6.6}, {486, 6.6}, {486, -60}, {364, -60}, {364, -103.867}}, color = {255, 127, 0}));
    connect(Generation_Warm_II_M00.pd_t, y[72]) annotation(
      Line(points = {{458, 96.6}, {486, 96.6}, {486, -60}, {364, -60}, {364, -103.067}}, color = {255, 127, 0}));
    connect(Generation_Warm_I_M00.pd_t, y[71]) annotation(
      Line(points = {{458, 119.4}, {486, 119.4}, {486, -60}, {364, -60}, {364, -102.8}}, color = {255, 127, 0}));
    connect(Generation_Warm_Off_M00.pd_t, y[70]) annotation(
      Line(points = {{392, 118.6}, {364, 118.6}, {364, -102.533}}, color = {255, 127, 0}));
    connect(Generation_Hot_Off_M00.pd_t, y[67]) annotation(
      Line(points = {{392, 210.6}, {364, 210.6}, {364, -101.733}}, color = {255, 127, 0}));
    connect(Generation_Hot_II_M00.pd_t, y[69]) annotation(
      Line(points = {{458, 188.6}, {486, 188.6}, {486, -60}, {364, -60}, {364, -102.267}}, color = {255, 127, 0}));
    connect(Generation_Hot_I_M00.pd_t, y[68]) annotation(
      Line(points = {{458, 211.4}, {486, 211.4}, {486, -60}, {364, -60}, {364, -102}}, color = {255, 127, 0}));
    connect(RLT_Central_Heating_Off_M00.pd_t, y[61]) annotation(
      Line(points = {{270, 26.6}, {270, -60}, {364, -60}, {364, -100.133}}, color = {255, 127, 0}));
    connect(RLT_Central_Cooling_Off_M00.pd_t, y[64]) annotation(
      Line(points = {{238, 5.4}, {238, -60}, {364, -60}, {364, -100.933}}, color = {255, 127, 0}));
    connect(RLT_Central_Cooling_I_M00.pd_t, y[65]) annotation(
      Line(points = {{170, 48.6}, {140, 48.6}, {140, -60}, {364, -60}, {364, -101.2}}, color = {255, 127, 0}));
    connect(RLT_Central_Cooling_II_M00.pd_t, y[66]) annotation(
      Line(points = {{170, -16.6}, {140, -16.6}, {140, -60}, {364, -60}, {364, -101.467}}, color = {255, 127, 0}));
    connect(RLT_Central_Heating_II_M00.pd_t, y[63]) annotation(
      Line(points = {{336, 4.6}, {364, 4.6}, {364, -100.667}}, color = {255, 127, 0}));
    connect(RLT_Central_Heating_I_M00.pd_t, y[62]) annotation(
      Line(points = {{336, 27.4}, {364, 27.4}, {364, -100.4}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Heating_Off_M00.pd_t, y[55]) annotation(
      Line(points = {{270, 122.6}, {270, 66}, {364, 66}, {364, -98.5333}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Cooling_Off_M00.pd_t, y[58]) annotation(
      Line(points = {{238, 101.4}, {238, 66}, {140, 66}, {140, -60}, {364, -60}, {364, -99.3333}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Heating_I_M00.pd_t, y[56]) annotation(
      Line(points = {{336, 123.4}, {364, 123.4}, {364, -98.8}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Heating_II_M00.pd_t, y[57]) annotation(
      Line(points = {{336, 100.6}, {364, 100.6}, {364, -99.0667}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Cooling_I_M00.pd_t, y[59]) annotation(
      Line(points = {{170, 144.6}, {140, 144.6}, {140, -60}, {364, -60}, {364, -99.6}}, color = {255, 127, 0}));
    connect(OpenplanOffice_BKT_Cooling_II_M00.pd_t, y[60]) annotation(
      Line(points = {{170, 79.4}, {140, 79.4}, {140, -60}, {364, -60}, {364, -99.8667}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Heating_Off_M00.pd_t, y[31]) annotation(
      Line(points = {{32, -45.4}, {32, -106}, {140, -106}, {140, -60}, {364, -60}, {364, -92.1333}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Heating_I_M00.pd_t, y[32]) annotation(
      Line(points = {{98, -44.6}, {140, -44.6}, {140, -60}, {364, -60}, {364, -92.4}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Heating_II_M00.pd_t, y[33]) annotation(
      Line(points = {{98, -67.4}, {140, -67.4}, {140, -60}, {364, -60}, {364, -92.6667}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Cooling_Off_M00.pd_t, y[34]) annotation(
      Line(points = {{0, -66.6}, {0, -106}, {140, -106}, {140, -60}, {364, -60}, {364, -92.9333}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Cooling_I_M00.pd_t, y[35]) annotation(
      Line(points = {{-68, -23.4}, {-96, -23.4}, {-96, -106}, {140, -106}, {140, -60}, {364, -60}, {364, -93.2}}, color = {255, 127, 0}));
    connect(ConferenceRoom_BKT_Cooling_II_M00.pd_t, y[36]) annotation(
      Line(points = {{-68, -88.6}, {-96, -88.6}, {-96, -106}, {140, -106}, {140, -60}, {364, -60}, {364, -93.4667}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Heating_Off_M00.pd_t, y[25]) annotation(
      Line(points = {{32, 34.6}, {32, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -90.5333}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Heating_I_M00.pd_t, y[26]) annotation(
      Line(points = {{98, 35.4}, {140, 35.4}, {140, -60}, {364, -60}, {364, -90.8}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Heating_II_M00.pd_t, y[27]) annotation(
      Line(points = {{98, 12.6}, {140, 12.6}, {140, -60}, {364, -60}, {364, -91.0667}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Cooling_Off_M00.pd_t, y[28]) annotation(
      Line(points = {{0, 13.4}, {0, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -91.3333}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Cooling_I_M00.pd_t, y[29]) annotation(
      Line(points = {{-70, 56.6}, {-94, 56.6}, {-94, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -91.6}}, color = {255, 127, 0}));
    connect(ConferenceRoom_RLT_Cooling_II_M00.pd_t, y[30]) annotation(
      Line(points = {{-70, -8.6}, {-94, -8.6}, {-94, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -91.8667}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Heating_Off_M00.pd_t, y[19]) annotation(
      Line(points = {{32, 122.6}, {32, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -88.9333}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Heating_I_M00.pd_t, y[20]) annotation(
      Line(points = {{98, 123.4}, {140, 123.4}, {140, -60}, {364, -60}, {364, -89.2}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Heating_II_M00.pd_t, y[21]) annotation(
      Line(points = {{98, 100.6}, {140, 100.6}, {140, -60}, {364, -60}, {364, -89.4667}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Cooling_Off_M00.pd_t, y[22]) annotation(
      Line(points = {{0, 101.4}, {0, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -89.7333}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Cooling_II_M00.pd_t, y[24]) annotation(
      Line(points = {{-70, 79.4}, {-94, 79.4}, {-94, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -90.2667}}, color = {255, 127, 0}));
    connect(Canteen_BKT_Cooling_I_M00.pd_t, y[23]) annotation(
      Line(points = {{-70, 144.6}, {-94, 144.6}, {-94, 68}, {140, 68}, {140, -60}, {364, -60}, {364, -90}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Heating_I_M00.pd_t, y[14]) annotation(
      Line(points = {{98, 203.4}, {140, 203.4}, {140, -60}, {364, -60}, {364, -87.6}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Heating_II_M00.pd_t, y[15]) annotation(
      Line(points = {{98, 180.6}, {140, 180.6}, {140, -60}, {364, -60}, {364, -87.8667}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Heating_Off_M00.pd_t, y[13]) annotation(
      Line(points = {{32, 202.6}, {32, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -87.3333}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Cooling_Off_M00.pd_t, y[16]) annotation(
      Line(points = {{-4, 181.4}, {-4, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -88.1333}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Cooling_I_M00.pd_t, y[17]) annotation(
      Line(points = {{-70, 224.6}, {-96, 224.6}, {-96, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -88.4}}, color = {255, 127, 0}));
    connect(Canteen_RLT_Cooling_II_M00.pd_t, y[18]) annotation(
      Line(points = {{-70, 159.4}, {-96, 159.4}, {-96, 236}, {140, 236}, {140, -60}, {364, -60}, {364, -88.6667}}, color = {255, 127, 0}));
    connect(OpenplanOffice_RLT_Heating_I_M00.pd_t, y[50]) annotation(
      Line(points = {{336, 203.4}, {364, 203.4}, {364, -97.2}}, color = {255, 127, 0}));
    connect(Workshop_BKT_Heating_II_M00.outTransition[2], T119.inPlaces[1]) annotation(
      Line(points = {{108.8, 258.5}, {112, 258.5}, {112, 258}, {112, 258}, {112, 270}, {108, 270}, {108, 275.2}, {108, 275.2}}, thickness = 0.5));
    connect(T119.outPlaces[1], Workshop_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 284.8}, {108, 290}, {112, 290}, {112, 301.5}, {108.8, 301.5}}, thickness = 0.5));
    connect(T14.outPlaces[1], Workshop_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 355.2}, {86, 355.2}, {86, 338.5}, {87.2, 338.5}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_I_M00.outTransition[2], T14.inPlaces[1]) annotation(
      Line(points = {{87.2, 381.5}, {88, 381.5}, {88, 364.8}, {88, 364.8}}, thickness = 0.5));
    connect(T143.outPlaces[1], Canteen_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 187.2}, {88, 187.2}, {88, 182}, {82, 182}, {82, 170}, {87.2, 170}, {87.2, 170.5}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_I_M00.outTransition[2], T143.inPlaces[1]) annotation(
      Line(points = {{87.2, 213.5}, {82, 213.5}, {82, 202}, {88, 202}, {88, 198}, {88, 198}, {88, 196.8}, {88, 196.8}}, thickness = 0.5));
    connect(T1120.outPlaces[1], RLT_Central_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{295.2, -14}, {256, -14}, {256, 16.5}, {259.2, 16.5}}, thickness = 0.5));
    connect(T194.outPlaces[1], OpenplanOffice_RLT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{295.2, 222}, {256, 222}, {256, 191.5}, {259.2, 191.5}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_II_M00.outTransition[2], T144.inPlaces[1]) annotation(
      Line(points = {{108.8, 170.5}, {114, 170.5}, {114, 182}, {108, 182}, {108, 186}, {108, 186}, {108, 187.2}, {108, 187.2}}, thickness = 0.5));
    connect(T144.outPlaces[1], Canteen_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 196.8}, {108, 196.8}, {108, 202}, {114, 202}, {114, 214}, {108.8, 214}, {108.8, 213.5}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_II_M00.outTransition[2], T163.inPlaces[1]) annotation(
      Line(points = {{108.8, 2.5}, {112, 2.5}, {112, 14}, {108, 14}, {108, 18}, {108, 19.2}, {108, 19.2}}, thickness = 0.5));
    connect(T163.outPlaces[1], ConferenceRoom_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 28.8}, {108, 28.8}, {108, 34}, {112, 34}, {112, 46}, {108.8, 46}, {108.8, 45.5}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_I_M00.outTransition[2], T164.inPlaces[1]) annotation(
      Line(points = {{87.2, 45.5}, {84, 45.5}, {84, 34}, {88, 34}, {88, 28.8}}, thickness = 0.5));
    connect(T164.outPlaces[1], ConferenceRoom_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 19.2}, {88, 14}, {82, 14}, {82, 2.5}, {87.2, 2.5}}, thickness = 0.5));
    connect(T1135.outPlaces[1], Generation_Hot_II_M00.inTransition[2]) annotation(
      Line(points = {{448, 195.2}, {448, 195.2}, {448, 190}, {442, 190}, {442, 178}, {447.2, 178}, {447.2, 178.5}}, thickness = 0.5));
    connect(Generation_Hot_I_M00.outTransition[2], T1135.inPlaces[1]) annotation(
      Line(points = {{447.2, 221.5}, {442, 221.5}, {442, 210}, {448, 210}, {448, 206}, {448, 204.8}, {448, 204.8}}, thickness = 0.5));
    connect(T1136.outPlaces[1], Generation_Hot_I_M00.inTransition[2]) annotation(
      Line(points = {{468, 204.8}, {468, 210}, {474, 210}, {474, 221.5}, {468.8, 221.5}}, thickness = 0.5));
    connect(Generation_Hot_II_M00.outTransition[2], T1136.inPlaces[1]) annotation(
      Line(points = {{468.8, 178.5}, {472, 178.5}, {472, 192}, {468, 192}, {468, 194}, {468, 195.2}, {468, 195.2}}, thickness = 0.5));
    connect(T1110.outPlaces[1], MultipersonOffice_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{346, 364.8}, {346, 370}, {354, 370}, {354, 381.5}, {346.8, 381.5}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_II_M00.outTransition[2], T1110.inPlaces[1]) annotation(
      Line(points = {{346.8, 338.5}, {350, 338.5}, {350, 350}, {346, 350}, {346, 355.2}}, thickness = 0.5));
    connect(T1148.outPlaces[1], Generation_Warm_I_M00.inTransition[2]) annotation(
      Line(points = {{471, 112.28}, {471, 118}, {472, 118}, {472, 129.5}, {468.8, 129.5}}, thickness = 0.5));
    connect(Generation_Warm_II_M00.outTransition[2], T1148.inPlaces[1]) annotation(
      Line(points = {{468.8, 86.5}, {474, 86.5}, {474, 98}, {468, 98}, {468, 101.72}, {471, 101.72}}, thickness = 0.5));
    connect(Generation_Warm_I_M00.outTransition[2], T1149.inPlaces[1]) annotation(
      Line(points = {{447.2, 129.5}, {442, 129.5}, {442, 118}, {450, 118}, {450, 114}, {449, 114}, {449, 112.28}}, thickness = 0.5));
    connect(T1149.outPlaces[1], Generation_Warm_II_M00.inTransition[2]) annotation(
      Line(points = {{449, 101.72}, {449, 98}, {444, 98}, {444, 86.5}, {447.2, 86.5}}, thickness = 0.5));
    connect(T1137.outPlaces[1], Generation_Cold_I_M00.inTransition[2]) annotation(
      Line(points = {{468, 22.8}, {468, 28}, {472, 28}, {472, 39.5}, {468.8, 39.5}}, thickness = 0.5));
    connect(Generation_Cold_II_M00.outTransition[2], T1137.inPlaces[1]) annotation(
      Line(points = {{468.8, -3.5}, {472, -3.5}, {472, 8}, {468, 8}, {468, 13.2}}, thickness = 0.5));
    connect(T1131.outPlaces[1], RLT_Central_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210.8, 46}, {252, 46}, {252, 16}, {250, 16}, {250, 16.5}, {248.8, 16.5}}, thickness = 0.5));
    connect(T1121.outPlaces[1], RLT_Central_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210.8, -14}, {252, -14}, {252, 16}, {250, 16}, {250, 15.5}, {248.8, 15.5}}, thickness = 0.5));
    connect(RLT_Central_Cooling_Off_M00.outTransition[2], T1123.inPlaces[1]) annotation(
      Line(points = {{227.2, 15.5}, {220, 15.5}, {220, 6}, {212, 6}, {212, 6}, {210.8, 6}}, thickness = 0.5));
    connect(RLT_Central_Cooling_Off_M00.outTransition[1], T1129.inPlaces[1]) annotation(
      Line(points = {{227.2, 16.5}, {220, 16.5}, {220, 26}, {212, 26}, {212, 26}, {210.8, 26}}, thickness = 0.5));
    connect(T1130.outPlaces[1], RLT_Central_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{295.2, 46}, {256, 46}, {256, 16}, {258, 16}, {258, 15.5}, {259.2, 15.5}}, thickness = 0.5));
    connect(RLT_Central_Heating_Off_M00.outTransition[2], T1122.inPlaces[1]) annotation(
      Line(points = {{280.8, 16.5}, {286, 16.5}, {286, 6}, {294, 6}, {294, 6}, {295.2, 6}}, thickness = 0.5));
    connect(RLT_Central_Heating_Off_M00.outTransition[1], T1128.inPlaces[1]) annotation(
      Line(points = {{280.8, 15.5}, {286, 15.5}, {286, 26}, {294, 26}, {294, 26}, {295.2, 26}}, thickness = 0.5));
    connect(T183.outPlaces[1], OpenplanOffice_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210.8, 82}, {252, 82}, {252, 112}, {250, 112}, {250, 111.5}, {248.8, 111.5}}, thickness = 0.5));
    connect(T174.outPlaces[1], OpenplanOffice_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210.8, 142}, {252, 142}, {252, 112.5}, {248.8, 112.5}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_Off_M00.outTransition[2], T182.inPlaces[1]) annotation(
      Line(points = {{227.2, 111.5}, {220, 111.5}, {220, 102}, {210, 102}, {210, 102}, {210.8, 102}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Cooling_Off_M00.outTransition[1], T177.inPlaces[1]) annotation(
      Line(points = {{227.2, 112.5}, {220, 112.5}, {220, 122}, {210, 122}, {210, 122}, {210.8, 122}}, thickness = 0.5));
    connect(T172.outPlaces[1], OpenplanOffice_BKT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{295.2, 82}, {254, 82}, {254, 112.5}, {259.2, 112.5}}, thickness = 0.5));
    connect(T173.outPlaces[1], OpenplanOffice_BKT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{295.2, 142}, {254, 142}, {254, 111.5}, {259.2, 111.5}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_Off_M00.outTransition[2], T181.inPlaces[1]) annotation(
      Line(points = {{280.8, 112.5}, {286, 112.5}, {286, 102}, {294, 102}, {294, 102}, {295.2, 102}}, thickness = 0.5));
    connect(OpenplanOffice_BKT_Heating_Off_M00.outTransition[1], T176.inPlaces[1]) annotation(
      Line(points = {{280.8, 111.5}, {286, 111.5}, {286, 122}, {294, 122}, {294, 122}, {295.2, 122}}, thickness = 0.5));
    connect(T184.outPlaces[1], OpenplanOffice_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210.8, 162}, {252, 162}, {252, 192}, {250, 192}, {250, 192}, {248.8, 192}, {248.8, 191.5}}, thickness = 0.5));
    connect(T195.outPlaces[1], OpenplanOffice_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210.8, 222}, {252, 222}, {252, 192}, {250, 192}, {250, 192.5}, {248.8, 192.5}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_Off_M00.outTransition[2], T186.inPlaces[1]) annotation(
      Line(points = {{227.2, 191.5}, {222, 191.5}, {222, 182}, {210, 182}, {210, 182}, {210.8, 182}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Cooling_Off_M00.outTransition[1], T192.inPlaces[1]) annotation(
      Line(points = {{227.2, 192.5}, {222, 192.5}, {222, 202}, {210.8, 202}}, thickness = 0.5));
    connect(T185.outPlaces[1], OpenplanOffice_RLT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{295.2, 162}, {256, 162}, {256, 192}, {258, 192}, {258, 192.5}, {259.2, 192.5}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_Off_M00.outTransition[2], T187.inPlaces[1]) annotation(
      Line(points = {{280.8, 192.5}, {286, 192.5}, {286, 182}, {296, 182}, {296, 182}, {295.2, 182}}, thickness = 0.5));
    connect(OpenplanOffice_RLT_Heating_Off_M00.outTransition[1], T193.inPlaces[1]) annotation(
      Line(points = {{280.8, 191.5}, {286, 191.5}, {286, 202}, {296, 202}, {296, 202}, {295.2, 202}}, thickness = 0.5));
    connect(T1139.outPlaces[1], Generation_Hot_II_M00.inTransition[1]) annotation(
      Line(points = {{426.8, 190}, {442, 190}, {442, 178}, {446, 178}, {446, 177.5}, {447.2, 177.5}}, thickness = 0.5));
    connect(Generation_Hot_II_M00.outTransition[1], T1141.inPlaces[1]) annotation(
      Line(points = {{468.8, 177.5}, {472, 177.5}, {472, 164}, {440, 164}, {440, 170}, {426.8, 170}}, thickness = 0.5));
    connect(T1133.outPlaces[1], Generation_Hot_I_M00.inTransition[1]) annotation(
      Line(points = {{426.8, 210}, {474, 210}, {474, 222}, {470, 222}, {470, 222.5}, {468.8, 222.5}}, thickness = 0.5));
    connect(Generation_Hot_I_M00.outTransition[1], T1143.inPlaces[1]) annotation(
      Line(points = {{447.2, 222.5}, {442, 222.5}, {442, 230}, {428, 230}, {428, 230}, {426.8, 230}}, thickness = 0.5));
    connect(T1141.outPlaces[1], Generation_Hot_Off_M00.inTransition[2]) annotation(
      Line(points = {{417.2, 170}, {378, 170}, {378, 200}, {380, 200}, {380, 200.5}, {381.2, 200.5}}, thickness = 0.5));
    connect(T1143.outPlaces[1], Generation_Hot_Off_M00.inTransition[1]) annotation(
      Line(points = {{417.2, 230}, {378, 230}, {378, 200}, {380, 200}, {380, 199.5}, {381.2, 199.5}}, thickness = 0.5));
    connect(Generation_Hot_Off_M00.outTransition[2], T1139.inPlaces[1]) annotation(
      Line(points = {{402.8, 200.5}, {408, 200.5}, {408, 190}, {416, 190}, {416, 190}, {417.2, 190}}, thickness = 0.5));
    connect(Generation_Hot_Off_M00.outTransition[1], T1133.inPlaces[1]) annotation(
      Line(points = {{402.8, 199.5}, {408, 199.5}, {408, 210}, {418, 210}, {418, 210}, {417.2, 210}}, thickness = 0.5));
    connect(T1146.outPlaces[1], Generation_Warm_II_M00.inTransition[1]) annotation(
      Line(points = {{426.8, 98}, {444, 98}, {444, 86}, {448, 86}, {448, 85.5}, {447.2, 85.5}}, thickness = 0.5));
    connect(Generation_Warm_II_M00.outTransition[1], T1144.inPlaces[1]) annotation(
      Line(points = {{468.8, 85.5}, {474, 85.5}, {474, 74}, {434, 74}, {434, 78}, {428, 78}, {428, 78}, {426.8, 78}}, thickness = 0.5));
    connect(Generation_Warm_I_M00.outTransition[1], T1153.inPlaces[1]) annotation(
      Line(points = {{447.2, 130.5}, {442, 130.5}, {442, 138}, {428, 138}, {428, 138}, {426.8, 138}}, thickness = 0.5));
    connect(T1151.outPlaces[1], Generation_Warm_I_M00.inTransition[1]) annotation(
      Line(points = {{426.8, 118}, {472, 118}, {472, 130}, {470, 130}, {470, 130.5}, {468.8, 130.5}}, thickness = 0.5));
    connect(T1144.outPlaces[1], Generation_Warm_Off_M00.inTransition[2]) annotation(
      Line(points = {{417.2, 78}, {378, 78}, {378, 108}, {380, 108}, {380, 108.5}, {381.2, 108.5}}, thickness = 0.5));
    connect(T1153.outPlaces[1], Generation_Warm_Off_M00.inTransition[1]) annotation(
      Line(points = {{417.2, 138}, {378, 138}, {378, 108}, {380, 108}, {380, 107.5}, {381.2, 107.5}}, thickness = 0.5));
    connect(Generation_Warm_Off_M00.outTransition[2], T1146.inPlaces[1]) annotation(
      Line(points = {{402.8, 108.5}, {406, 108.5}, {406, 98}, {416, 98}, {416, 98}, {417.2, 98}}, thickness = 0.5));
    connect(Generation_Warm_Off_M00.outTransition[1], T1151.inPlaces[1]) annotation(
      Line(points = {{402.8, 107.5}, {406, 107.5}, {406, 118}, {416, 118}, {416, 118}, {417.2, 118}}, thickness = 0.5));
    connect(T1134.outPlaces[1], Generation_Cold_II_M00.inTransition[2]) annotation(
      Line(points = {{448, 13.2}, {448, 13.2}, {448, 8}, {444, 8}, {444, -4}, {447.2, -4}, {447.2, -3.5}}, thickness = 0.5));
    connect(T1138.outPlaces[1], Generation_Cold_II_M00.inTransition[1]) annotation(
      Line(points = {{426.8, 8}, {444, 8}, {444, -4.5}, {447.2, -4.5}}, thickness = 0.5));
    connect(Generation_Cold_II_M00.outTransition[1], T1140.inPlaces[1]) annotation(
      Line(points = {{468.8, -4.5}, {472, -4.5}, {472, -16}, {438, -16}, {438, -12}, {428, -12}, {428, -12}, {426.8, -12}}, thickness = 0.5));
    connect(Generation_Cold_I_M00.outTransition[2], T1134.inPlaces[1]) annotation(
      Line(points = {{447.2, 39.5}, {444, 39.5}, {444, 28}, {448, 28}, {448, 22}, {448, 22.8}, {448, 22.8}}, thickness = 0.5));
    connect(Generation_Cold_I_M00.outTransition[1], T1142.inPlaces[1]) annotation(
      Line(points = {{447.2, 40.5}, {444, 40.5}, {444, 48}, {428, 48}, {428, 48}, {426.8, 48}}, thickness = 0.5));
    connect(T1132.outPlaces[1], Generation_Cold_I_M00.inTransition[1]) annotation(
      Line(points = {{426.8, 28}, {472, 28}, {472, 40}, {468, 40}, {468, 40.5}, {468.8, 40.5}}, thickness = 0.5));
    connect(T1140.outPlaces[1], Generation_Cold_Off_M00.inTransition[2]) annotation(
      Line(points = {{417.2, -12}, {376, -12}, {376, 18}, {380, 18}, {380, 18.5}, {381.2, 18.5}}, thickness = 0.5));
    connect(T1142.outPlaces[1], Generation_Cold_Off_M00.inTransition[1]) annotation(
      Line(points = {{417.2, 48}, {376, 48}, {376, 18}, {380, 18}, {380, 17.5}, {381.2, 17.5}}, thickness = 0.5));
    connect(Generation_Cold_Off_M00.outTransition[2], T1138.inPlaces[1]) annotation(
      Line(points = {{402.8, 18.5}, {408, 18.5}, {408, 8}, {416, 8}, {416, 8}, {417.2, 8}}, thickness = 0.5));
    connect(Generation_Cold_Off_M00.outTransition[1], T1132.inPlaces[1]) annotation(
      Line(points = {{402.8, 17.5}, {408, 17.5}, {408, 28}, {416, 28}, {416, 28}, {417.2, 28}}, thickness = 0.5));
    connect(T196.outPlaces[1], MultipersonOffice_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210.8, 250}, {252, 250}, {252, 280}, {250, 280}, {250, 279.5}, {248.8, 279.5}}, thickness = 0.5));
    connect(T1106.outPlaces[1], MultipersonOffice_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210.8, 310}, {252, 310}, {252, 280}, {250, 280}, {250, 280.5}, {248.8, 280.5}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_Off_M00.outTransition[2], T198.inPlaces[1]) annotation(
      Line(points = {{227.2, 279.5}, {222, 279.5}, {222, 270}, {210.8, 270}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Cooling_Off_M00.outTransition[1], T1104.inPlaces[1]) annotation(
      Line(points = {{227.2, 280.5}, {222, 280.5}, {222, 290}, {210.8, 290}, {210.8, 290}}, thickness = 0.5));
    connect(T197.outPlaces[1], MultipersonOffice_BKT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{295.2, 250}, {256, 250}, {256, 280}, {258, 280}, {258, 280.5}, {259.2, 280.5}}, thickness = 0.5));
    connect(T1107.outPlaces[1], MultipersonOffice_BKT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{295.2, 310}, {256, 310}, {256, 279.5}, {259.2, 279.5}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_Off_M00.outTransition[2], T199.inPlaces[1]) annotation(
      Line(points = {{280.8, 280.5}, {286, 280.5}, {286, 270}, {294, 270}, {294, 270}, {295.2, 270}, {295.2, 270}}, thickness = 0.5));
    connect(MultipersonOffice_BKT_Heating_Off_M00.outTransition[1], T1105.inPlaces[1]) annotation(
      Line(points = {{280.8, 279.5}, {286, 279.5}, {286, 290}, {294, 290}, {294, 290}, {295.2, 290}}, thickness = 0.5));
    connect(T1111.outPlaces[1], MultipersonOffice_RLT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{326, 355.2}, {326, 355.2}, {326, 350}, {320, 350}, {320, 338}, {326, 338}, {326, 338.5}, {325.2, 338.5}}, thickness = 0.5));
    connect(T1114.outPlaces[1], MultipersonOffice_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 350}, {320, 350}, {320, 338}, {326, 338}, {326, 337.5}, {325.2, 337.5}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_II_M00.outTransition[1], T1108.inPlaces[1]) annotation(
      Line(points = {{346.8, 337.5}, {350, 337.5}, {350, 326}, {314, 326}, {314, 330}, {304, 330}, {304, 330}, {304.8, 330}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_I_M00.outTransition[2], T1111.inPlaces[1]) annotation(
      Line(points = {{325.2, 381.5}, {320, 381.5}, {320, 370}, {326, 370}, {326, 366}, {326, 364.8}, {326, 364.8}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_I_M00.outTransition[1], T1119.inPlaces[1]) annotation(
      Line(points = {{325.2, 382.5}, {320, 382.5}, {320, 390}, {306, 390}, {306, 390}, {304.8, 390}}, thickness = 0.5));
    connect(T1116.outPlaces[1], MultipersonOffice_RLT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{304.8, 370}, {354, 370}, {354, 382}, {348, 382}, {348, 382}, {346.8, 382}, {346.8, 382.5}}, thickness = 0.5));
    connect(T1109.outPlaces[1], MultipersonOffice_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{210.8, 330}, {252, 330}, {252, 360}, {250, 360}, {250, 359.5}, {248.8, 359.5}}, thickness = 0.5));
    connect(T1118.outPlaces[1], MultipersonOffice_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{210.8, 390}, {252, 390}, {252, 360}, {250, 360}, {250, 360}, {248.8, 360}, {248.8, 360.5}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Cooling_Off_M00.outTransition[1], T1117.inPlaces[1]) annotation(
      Line(points = {{227.2, 360.5}, {222, 360.5}, {222, 370}, {210.8, 370}}, thickness = 0.5));
    connect(T1108.outPlaces[1], MultipersonOffice_RLT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{295.2, 330}, {256, 330}, {256, 360.5}, {259.2, 360.5}}, thickness = 0.5));
    connect(T1119.outPlaces[1], MultipersonOffice_RLT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{295.2, 390}, {256, 390}, {256, 360}, {260, 360}, {260, 360}, {260, 359.5}, {259.2, 359.5}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_Off_M00.outTransition[2], T1114.inPlaces[1]) annotation(
      Line(points = {{280.8, 360.5}, {286, 360.5}, {286, 350}, {294, 350}, {294, 350}, {295.2, 350}}, thickness = 0.5));
    connect(MultipersonOffice_RLT_Heating_Off_M00.outTransition[1], T1116.inPlaces[1]) annotation(
      Line(points = {{280.8, 359.5}, {286, 359.5}, {286, 370}, {296, 370}, {296, 370}, {295.2, 370}}, thickness = 0.5));
    connect(T152.outPlaces[1], ConferenceRoom_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-58, -60.8}, {-58, -60.8}, {-58, -66}, {-54, -66}, {-54, -66}, {-54, -66}, {-54, -78}, {-57.2, -78}, {-57.2, -78.5}}, thickness = 0.5));
    connect(T150.outPlaces[1], ConferenceRoom_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, -66}, {-54, -66}, {-54, -78}, {-56, -78}, {-56, -77.5}, {-57.2, -77.5}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_II_M00.outTransition[2], T159.inPlaces[1]) annotation(
      Line(points = {{-78.8, -78.5}, {-82, -78.5}, {-82, -66}, {-78, -66}, {-78, -62}, {-78, -60.8}, {-78, -60.8}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_II_M00.outTransition[1], T149.inPlaces[1]) annotation(
      Line(points = {{-78.8, -77.5}, {-82, -77.5}, {-82, -90}, {-44, -90}, {-44, -86}, {-36.8, -86}, {-36.8, -86}}, thickness = 0.5));
    connect(T152.inPlaces[1], ConferenceRoom_BKT_Cooling_I_M00.outTransition[2]) annotation(
      Line(points = {{-58, -51.2}, {-58, -51.2}, {-58, -46}, {-54, -46}, {-54, -34}, {-57.2, -34}, {-57.2, -33.5}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_I_M00.outTransition[1], T160.inPlaces[1]) annotation(
      Line(points = {{-57.2, -34.5}, {-54, -34.5}, {-54, -26}, {-38, -26}, {-38, -26}, {-36.8, -26}}, thickness = 0.5));
    connect(T159.outPlaces[1], ConferenceRoom_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-78, -51.2}, {-78, -51.2}, {-78, -46}, {-84, -46}, {-84, -34}, {-78.8, -34}, {-78.8, -33.5}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_I_M00.inTransition[1], T155.outPlaces[1]) annotation(
      Line(points = {{-78.8, -34.5}, {-84, -34.5}, {-84, -46}, {-36, -46}, {-36, -46}, {-36.8, -46}}, thickness = 0.5));
    connect(T153.outPlaces[1], ConferenceRoom_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, -60.8}, {88, -60.8}, {88, -66}, {84, -66}, {84, -78}, {87.2, -78}, {87.2, -77.5}}, thickness = 0.5));
    connect(T151.outPlaces[1], ConferenceRoom_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66.8, -66}, {84, -66}, {84, -78}, {86, -78}, {86, -78.5}, {87.2, -78.5}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_II_M00.outTransition[2], T154.inPlaces[1]) annotation(
      Line(points = {{108.8, -77.5}, {114, -77.5}, {114, -66}, {108, -66}, {108, -62}, {108, -60.8}, {108, -60.8}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_II_M00.outTransition[1], T148.inPlaces[1]) annotation(
      Line(points = {{108.8, -78.5}, {114, -78.5}, {114, -90}, {78, -90}, {78, -86}, {66.8, -86}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_I_M00.outTransition[2], T153.inPlaces[1]) annotation(
      Line(points = {{87.2, -34.5}, {84, -34.5}, {84, -46}, {88, -46}, {88, -50}, {88, -51.2}, {88, -51.2}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_I_M00.outTransition[1], T161.inPlaces[1]) annotation(
      Line(points = {{87.2, -33.5}, {84, -33.5}, {84, -26}, {68, -26}, {68, -26}, {66.8, -26}}, thickness = 0.5));
    connect(T154.outPlaces[1], ConferenceRoom_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, -51.2}, {108, -51.2}, {108, -46}, {112, -46}, {112, -34}, {108.8, -34}, {108.8, -34.5}}, thickness = 0.5));
    connect(T156.outPlaces[1], ConferenceRoom_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66.8, -46}, {112, -46}, {112, -34}, {110, -34}, {110, -33.5}, {108.8, -33.5}}, thickness = 0.5));
    connect(T160.outPlaces[1], ConferenceRoom_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-27.2, -26}, {14, -26}, {14, -56}, {10, -56}, {10, -55.5}, {10.8, -55.5}}, thickness = 0.5));
    connect(T149.outPlaces[1], ConferenceRoom_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-27.2, -86}, {14, -86}, {14, -56}, {12, -56}, {12, -56.5}, {10.8, -56.5}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_Off_M00.outTransition[2], T150.inPlaces[1]) annotation(
      Line(points = {{-10.8, -56.5}, {-16, -56.5}, {-16, -66}, {-28, -66}, {-28, -66}, {-27.2, -66}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Cooling_Off_M00.outTransition[1], T155.inPlaces[1]) annotation(
      Line(points = {{-10.8, -55.5}, {-16, -55.5}, {-16, -46}, {-28, -46}, {-28, -46}, {-27.2, -46}}, thickness = 0.5));
    connect(T161.outPlaces[1], ConferenceRoom_BKT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{57.2, -26}, {18, -26}, {18, -56}, {20, -56}, {20, -56.5}, {21.2, -56.5}}, thickness = 0.5));
    connect(T148.outPlaces[1], ConferenceRoom_BKT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{57.2, -86}, {18, -86}, {18, -56}, {22, -56}, {22, -55.5}, {21.2, -55.5}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_Off_M00.outTransition[2], T151.inPlaces[1]) annotation(
      Line(points = {{42.8, -55.5}, {48, -55.5}, {48, -66}, {58, -66}, {58, -66}, {57.2, -66}}, thickness = 0.5));
    connect(ConferenceRoom_BKT_Heating_Off_M00.outTransition[2], T156.inPlaces[1]) annotation(
      Line(points = {{42.8, -55.5}, {48, -55.5}, {48, -46}, {56, -46}, {56, -46}, {57.2, -46}}, thickness = 0.5));
    connect(T167.outPlaces[1], ConferenceRoom_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 19.2}, {-60, 19.2}, {-60, 14}, {-56, 14}, {-56, 2}, {-59.2, 2}, {-59.2, 1.5}}, thickness = 0.5));
    connect(T169.outPlaces[1], ConferenceRoom_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 14}, {-56, 14}, {-56, 2}, {-58, 2}, {-58, 2}, {-59.2, 2}, {-59.2, 2.5}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_II_M00.outTransition[2], T166.inPlaces[1]) annotation(
      Line(points = {{-80.8, 1.5}, {-84, 1.5}, {-84, 14}, {-78, 14}, {-78, 20}, {-78, 19.2}, {-78, 19.2}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_II_M00.outTransition[1], T158.inPlaces[1]) annotation(
      Line(points = {{-80.8, 2.5}, {-84, 2.5}, {-84, -12}, {-44, -12}, {-44, -6}, {-38, -6}, {-38, -6}, {-36.8, -6}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_I_M00.outTransition[2], T167.inPlaces[1]) annotation(
      Line(points = {{-59.2, 46.5}, {-56, 46.5}, {-56, 34}, {-60, 34}, {-60, 30}, {-60, 28.8}, {-60, 28.8}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_I_M00.outTransition[1], T170.inPlaces[1]) annotation(
      Line(points = {{-59.2, 45.5}, {-56, 45.5}, {-56, 54}, {-36, 54}, {-36, 54}, {-36, 54}, {-36.8, 54}}, thickness = 0.5));
    connect(T166.outPlaces[1], ConferenceRoom_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-78, 28.8}, {-76, 28.8}, {-76, 34}, {-86, 34}, {-86, 46}, {-82, 46}, {-82, 46.5}, {-80.8, 46.5}}, thickness = 0.5));
    connect(T165.outPlaces[1], ConferenceRoom_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 34}, {-86, 34}, {-86, 45.5}, {-80.8, 45.5}}, thickness = 0.5));
    connect(T158.outPlaces[1], ConferenceRoom_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-27.2, -6}, {14, -6}, {14, 23.5}, {10.8, 23.5}}, thickness = 0.5));
    connect(T170.outPlaces[1], ConferenceRoom_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-27.2, 54}, {14, 54}, {14, 24}, {12, 24}, {12, 24.5}, {10.8, 24.5}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_Off_M00.outTransition[1], T165.inPlaces[1]) annotation(
      Line(points = {{-10.8, 24.5}, {-18, 24.5}, {-18, 34}, {-26, 34}, {-26, 34}, {-27.2, 34}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Cooling_Off_M00.outTransition[2], T169.inPlaces[1]) annotation(
      Line(points = {{-10.8, 23.5}, {-18, 23.5}, {-18, 14}, {-26, 14}, {-26, 14}, {-27.2, 14}}, thickness = 0.5));
    connect(T168.outPlaces[1], ConferenceRoom_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 14}, {82, 14}, {82, 2}, {86, 2}, {86, 1.5}, {87.2, 1.5}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_II_M00.outTransition[1], T157.inPlaces[1]) annotation(
      Line(points = {{108.8, 1.5}, {112, 1.5}, {112, -12}, {76, -12}, {76, -6}, {66.8, -6}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_I_M00.outTransition[1], T171.inPlaces[1]) annotation(
      Line(points = {{87.2, 46.5}, {84, 46.5}, {84, 54}, {68, 54}, {68, 54}, {66.8, 54}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_I_M00.inTransition[1], T162.outPlaces[1]) annotation(
      Line(points = {{108.8, 46.5}, {112, 46.5}, {112, 34}, {66, 34}, {66, 34}, {66.8, 34}}, thickness = 0.5));
    connect(T171.outPlaces[1], ConferenceRoom_RLT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{57.2, 54}, {16, 54}, {16, 24}, {20, 24}, {20, 23.5}, {21.2, 23.5}}, thickness = 0.5));
    connect(T157.outPlaces[1], ConferenceRoom_RLT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{57.2, -6}, {16, -6}, {16, 24}, {22, 24}, {22, 24.5}, {21.2, 24.5}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_Off_M00.outTransition[2], T168.inPlaces[1]) annotation(
      Line(points = {{42.8, 24.5}, {48, 24.5}, {48, 14}, {56, 14}, {56, 14}, {57.2, 14}}, thickness = 0.5));
    connect(ConferenceRoom_RLT_Heating_Off_M00.outTransition[1], T162.inPlaces[1]) annotation(
      Line(points = {{42.8, 23.5}, {48, 23.5}, {48, 34}, {56, 34}, {56, 34}, {57.2, 34}}, thickness = 0.5));
    connect(T15.outPlaces[1], Workshop_RLT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 364.8}, {108, 364.8}, {108, 370}, {112, 370}, {112, 382}, {108.8, 382}, {108.8, 381.5}}, thickness = 0.5));
    connect(T1.outPlaces[1], Workshop_RLT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 370}, {112, 370}, {112, 382.5}, {108.8, 382.5}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_I_M00.outTransition[1], T11.inPlaces[1]) annotation(
      Line(points = {{87.2, 382.5}, {78, 382.5}, {78, 390}, {68, 390}, {68, 390}, {66.8, 390}}, thickness = 0.5));
    connect(T11.outPlaces[1], Workshop_RLT_Heating_Off_M01.inTransition[1]) annotation(
      Line(points = {{57.2, 390}, {18, 390}, {18, 359.5}, {21.2, 359.5}}, thickness = 0.5));
    connect(T110.outPlaces[1], Workshop_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-80, 364.8}, {-80, 370}, {-84, 370}, {-84, 384.5}, {-80.8, 384.5}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_I_M00.outTransition[1], T16.inPlaces[1]) annotation(
      Line(points = {{-59.2, 383.5}, {-48, 383.5}, {-48, 390}, {-36.8, 390}}, thickness = 0.5));
    connect(T17.outPlaces[1], Workshop_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 370}, {-84, 370}, {-84, 383.5}, {-80.8, 383.5}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_I_M00.outTransition[2], T111.inPlaces[1]) annotation(
      Line(points = {{-59.2, 384.5}, {-54, 384.5}, {-54, 370}, {-60, 370}, {-60, 366}, {-60, 364.8}, {-60, 364.8}}, thickness = 0.5));
    connect(T16.outPlaces[1], Workshop_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-27.2, 390}, {12, 390}, {12, 360.5}, {6.8, 360.5}}, thickness = 0.5));
    connect(T13.outPlaces[1], Workshop_RLT_Heating_Off_M01.inTransition[2]) annotation(
      Line(points = {{57.2, 330}, {18, 330}, {18, 360.5}, {21.2, 360.5}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_Off_M01.outTransition[2], T12.inPlaces[1]) annotation(
      Line(points = {{42.8, 360.5}, {50, 360.5}, {50, 350}, {56, 350}, {56, 350}, {57.2, 350}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_Off_M01.outTransition[1], T1.inPlaces[1]) annotation(
      Line(points = {{42.8, 359.5}, {50, 359.5}, {50, 370}, {57.2, 370}, {57.2, 370}}, thickness = 0.5));
    connect(T12.outPlaces[1], Workshop_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 350}, {86, 350}, {86, 338}, {87.2, 338}, {87.2, 337.5}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_II_M00.outTransition[1], T13.inPlaces[1]) annotation(
      Line(points = {{108.8, 337.5}, {108, 337.5}, {108, 324}, {70, 324}, {70, 330}, {66.8, 330}, {66.8, 330}}, thickness = 0.5));
    connect(Workshop_RLT_Heating_II_M00.outTransition[2], T15.inPlaces[1]) annotation(
      Line(points = {{108.8, 338.5}, {108, 338.5}, {108, 355.2}, {108, 355.2}}, thickness = 0.5));
    connect(T19.outPlaces[1], Workshop_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-27.2, 330}, {12, 330}, {12, 359.5}, {6.8, 359.5}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_Off_M00.outTransition[2], T18.inPlaces[1]) annotation(
      Line(points = {{-14.8, 359.5}, {-18, 359.5}, {-18, 350}, {-27.2, 350}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_Off_M00.outTransition[1], T17.inPlaces[1]) annotation(
      Line(points = {{-14.8, 360.5}, {-18, 360.5}, {-18, 370}, {-27.2, 370}}, thickness = 0.5));
    connect(T18.outPlaces[1], Workshop_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 350}, {-54, 350}, {-54, 338}, {-58, 338}, {-58, 338.5}, {-59.2, 338.5}}, thickness = 0.5));
    connect(T111.outPlaces[1], Workshop_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 355.2}, {-60, 355.2}, {-60, 350}, {-54, 350}, {-54, 338}, {-60, 338}, {-60, 337.5}, {-59.2, 337.5}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_II_M00.outTransition[1], T19.inPlaces[1]) annotation(
      Line(points = {{-80.8, 338.5}, {-86, 338.5}, {-86, 326}, {-46, 326}, {-46, 330}, {-38, 330}, {-38, 330}, {-36.8, 330}}, thickness = 0.5));
    connect(Workshop_RLT_Cooling_II_M00.outTransition[2], T110.inPlaces[1]) annotation(
      Line(points = {{-80.8, 337.5}, {-86, 337.5}, {-86, 350}, {-80, 350}, {-80, 354}, {-80, 355.2}, {-80, 355.2}}, thickness = 0.5));
    connect(T113.outPlaces[1], Workshop_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-27.2, 250}, {10, 250}, {10, 280}, {8, 280}, {8, 279.5}, {6.8, 279.5}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_II_M00.outTransition[1], T113.inPlaces[1]) annotation(
      Line(points = {{-80.8, 258.5}, {-84, 258.5}, {-84, 244}, {-48, 244}, {-48, 250}, {-38, 250}, {-38, 250}, {-36.8, 250}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_Off_M00.outTransition[2], T114.inPlaces[1]) annotation(
      Line(points = {{-14.8, 279.5}, {-20, 279.5}, {-20, 270}, {-26, 270}, {-26, 270}, {-27.2, 270}, {-27.2, 270}}, thickness = 0.5));
    connect(T114.outPlaces[1], Workshop_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 270}, {-54, 270}, {-54, 258}, {-58, 258}, {-58, 258.5}, {-59.2, 258.5}}, thickness = 0.5));
    connect(Workshop_BKT_Heatin_Off_M00.outTransition[2], T115.inPlaces[1]) annotation(
      Line(points = {{42.8, 280.5}, {48, 280.5}, {48, 270}, {58, 270}, {58, 270}, {57.2, 270}}, thickness = 0.5));
    connect(T115.outPlaces[1], Workshop_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 270}, {84, 270}, {84, 258}, {86, 258}, {86, 257.5}, {87.2, 257.5}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_II_M00.outTransition[2], T117.inPlaces[1]) annotation(
      Line(points = {{-80.8, 257.5}, {-84, 257.5}, {-84, 272}, {-80, 272}, {-80, 274}, {-80, 275.2}, {-80, 275.2}}, thickness = 0.5));
    connect(T116.outPlaces[1], Workshop_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 275.2}, {-60, 275.2}, {-60, 270}, {-54, 270}, {-54, 258}, {-59.2, 258}, {-59.2, 257.5}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_I_M00.outTransition[2], T116.inPlaces[1]) annotation(
      Line(points = {{-59.2, 302.5}, {-54, 302.5}, {-54, 290}, {-60, 290}, {-60, 286}, {-60, 284.8}, {-60, 284.8}}, thickness = 0.5));
    connect(T117.outPlaces[1], Workshop_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-80, 284.8}, {-80, 284.8}, {-80, 290}, {-88, 290}, {-88, 302}, {-80.8, 302}, {-80.8, 302.5}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_Off_M00.outTransition[1], T120.inPlaces[1]) annotation(
      Line(points = {{-14.8, 280.5}, {-20, 280.5}, {-20, 290}, {-26, 290}, {-26, 290}, {-27.2, 290}}, thickness = 0.5));
    connect(T122.outPlaces[1], Workshop_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-27.2, 310}, {10, 310}, {10, 280}, {8, 280}, {8, 280.5}, {6.8, 280.5}}, thickness = 0.5));
    connect(Workshop_BKT_Heating_I_M00.outTransition[2], T118.inPlaces[1]) annotation(
      Line(points = {{87.2, 301.5}, {82, 301.5}, {82, 290}, {88, 290}, {88, 286}, {88, 286}, {88, 284.8}, {88, 284.8}}, thickness = 0.5));
    connect(T118.outPlaces[1], Workshop_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 275.2}, {88, 275.2}, {88, 270}, {84, 270}, {84, 258}, {87.2, 258}, {87.2, 258.5}}, thickness = 0.5));
    connect(Workshop_BKT_Heatin_Off_M00.outTransition[1], T121.inPlaces[1]) annotation(
      Line(points = {{42.8, 279.5}, {48, 279.5}, {48, 290}, {56, 290}, {56, 290}, {57.2, 290}}, thickness = 0.5));
    connect(T123.outPlaces[1], Workshop_BKT_Heatin_Off_M00.inTransition[1]) annotation(
      Line(points = {{57.2, 310}, {18, 310}, {18, 280}, {22, 280}, {22, 279.5}, {21.2, 279.5}}, thickness = 0.5));
    connect(T112.outPlaces[1], Workshop_BKT_Heatin_Off_M00.inTransition[2]) annotation(
      Line(points = {{57.2, 250}, {18, 250}, {18, 280.5}, {21.2, 280.5}}, thickness = 0.5));
    connect(T120.outPlaces[1], Workshop_BKT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 290}, {-88, 290}, {-88, 302}, {-80.8, 302}, {-80.8, 301.5}}, thickness = 0.5));
    connect(T121.outPlaces[1], Workshop_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 290}, {112, 290}, {112, 302}, {108.8, 302}, {108.8, 302.5}}, thickness = 0.5));
    connect(Workshop_BKT_Cooling_I_M00.outTransition[1], T122.inPlaces[1]) annotation(
      Line(points = {{-59.2, 301.5}, {-54, 301.5}, {-54, 310}, {-38, 310}, {-38, 310}, {-36.8, 310}}, thickness = 0.5));
    connect(Workshop_BKT_Heating_I_M00.outTransition[1], T123.inPlaces[1]) annotation(
      Line(points = {{87.2, 302.5}, {82, 302.5}, {82, 310}, {66, 310}, {66, 310}, {66.8, 310}}, thickness = 0.5));
    connect(Workshop_BKT_Heating_II_M00.outTransition[1], T112.inPlaces[1]) annotation(
      Line(points = {{108.8, 257.5}, {112, 257.5}, {112, 246}, {70, 246}, {70, 250}, {66.8, 250}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_I_M00.outTransition[1], T134.inPlaces[1]) annotation(
      Line(points = {{-59.2, 133.5}, {-54, 133.5}, {-54, 142}, {-36, 142}, {-36, 142}, {-36.8, 142}}, thickness = 0.5));
    connect(T129.inPlaces[1], Canteen_BKT_Cooling_I_M00.outTransition[2]) annotation(
      Line(points = {{-60, 116.8}, {-60, 116.8}, {-60, 122}, {-54, 122}, {-54, 134}, {-60, 134}, {-60, 134.5}, {-59.2, 134.5}}, thickness = 0.5));
    connect(T135.outPlaces[1], Canteen_BKT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-80, 116.8}, {-80, 116.8}, {-80, 122}, {-88, 122}, {-88, 134}, {-80.8, 134}, {-80.8, 134.5}}, thickness = 0.5));
    connect(T126.outPlaces[1], Canteen_BKT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 122}, {-88, 122}, {-88, 134}, {-80, 134}, {-80, 133.5}, {-80.8, 133.5}}, thickness = 0.5));
    connect(T129.outPlaces[1], Canteen_BKT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 107.2}, {-60, 107.2}, {-60, 102}, {-54, 102}, {-54, 90}, {-59.2, 90}, {-59.2, 89.5}}, thickness = 0.5));
    connect(T131.outPlaces[1], Canteen_BKT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 102}, {-54, 102}, {-54, 90}, {-58, 90}, {-58, 90.5}, {-59.2, 90.5}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_II_M00.outTransition[2], T135.inPlaces[1]) annotation(
      Line(points = {{-80.8, 89.5}, {-86, 89.5}, {-86, 102}, {-80, 102}, {-80, 106}, {-80, 107.2}, {-80, 107.2}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_II_M00.outTransition[1], T132.inPlaces[1]) annotation(
      Line(points = {{-80.8, 90.5}, {-86, 90.5}, {-86, 76}, {-46, 76}, {-46, 82}, {-38, 82}, {-38, 82}, {-36.8, 82}}, thickness = 0.5));
    connect(T134.outPlaces[1], Canteen_BKT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-27.2, 142}, {14, 142}, {14, 112}, {12, 112}, {12, 112.5}, {10.8, 112.5}}, thickness = 0.5));
    connect(T132.outPlaces[1], Canteen_BKT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-27.2, 82}, {14, 82}, {14, 112}, {12, 112}, {12, 111.5}, {10.8, 111.5}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_Off_M00.outTransition[2], T131.inPlaces[1]) annotation(
      Line(points = {{-10.8, 111.5}, {-20, 111.5}, {-20, 102}, {-26, 102}, {-26, 102}, {-27.2, 102}}, thickness = 0.5));
    connect(Canteen_BKT_Cooling_Off_M00.outTransition[1], T126.inPlaces[1]) annotation(
      Line(points = {{-10.8, 112.5}, {-20, 112.5}, {-20, 122}, {-26, 122}, {-26, 122}, {-27.2, 122}}, thickness = 0.5));
    connect(T128.outPlaces[1], Canteen_BKT_Heating_II_M00.inTransition[2]) annotation(
      Line(points = {{88, 107.2}, {88, 107.2}, {88, 102}, {80, 102}, {80, 90}, {87.2, 90}, {87.2, 90.5}}, thickness = 0.5));
    connect(T130.outPlaces[1], Canteen_BKT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 102}, {80, 102}, {80, 90}, {86, 90}, {86, 89.5}, {87.2, 89.5}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_II_M00.outTransition[2], T127.inPlaces[1]) annotation(
      Line(points = {{108.8, 90.5}, {114, 90.5}, {114, 102}, {108, 102}, {108, 108}, {108, 107.2}, {108, 107.2}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_II_M00.outTransition[1], T124.inPlaces[1]) annotation(
      Line(points = {{108.8, 89.5}, {114, 89.5}, {114, 76}, {76, 76}, {76, 82}, {68, 82}, {68, 82}, {66.8, 82}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_I_M00.outTransition[1], T133.inPlaces[1]) annotation(
      Line(points = {{87.2, 134.5}, {82, 134.5}, {82, 142}, {68, 142}, {68, 142}, {66.8, 142}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_I_M00.outTransition[2], T128.inPlaces[1]) annotation(
      Line(points = {{87.2, 133.5}, {82, 133.5}, {82, 122}, {88, 122}, {88, 118}, {88, 116.8}, {88, 116.8}}, thickness = 0.5));
    connect(T127.outPlaces[1], Canteen_BKT_Heating_I_M00.inTransition[2]) annotation(
      Line(points = {{108, 116.8}, {108, 116.8}, {108, 122}, {114, 122}, {114, 134}, {108.8, 134}, {108.8, 133.5}}, thickness = 0.5));
    connect(T125.outPlaces[1], Canteen_BKT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 122}, {114, 122}, {114, 134}, {108, 134}, {108, 134.5}, {108.8, 134.5}}, thickness = 0.5));
    connect(T124.outPlaces[1], Canteen_BKT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{57.2, 82}, {18, 82}, {18, 112}, {20, 112}, {20, 112.5}, {21.2, 112.5}}, thickness = 0.5));
    connect(T133.outPlaces[1], Canteen_BKT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{57.2, 142}, {18, 142}, {18, 112}, {20, 112}, {20, 111.5}, {21.2, 111.5}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_Off_M00.outTransition[2], T130.inPlaces[1]) annotation(
      Line(points = {{42.8, 112.5}, {48, 112.5}, {48, 102}, {56, 102}, {56, 102}, {57.2, 102}}, thickness = 0.5));
    connect(Canteen_BKT_Heating_Off_M00.outTransition[1], T125.inPlaces[1]) annotation(
      Line(points = {{42.8, 111.5}, {48, 111.5}, {48, 122}, {58, 122}, {58, 122}, {57.2, 122}}, thickness = 0.5));
    connect(T138.outPlaces[1], Canteen_RLT_Cooling_II_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 182}, {-54, 182}, {-54, 170}, {-58, 170}, {-58, 170.5}, {-59.2, 170.5}}, thickness = 0.5));
    connect(T140.outPlaces[1], Canteen_RLT_Cooling_II_M00.inTransition[2]) annotation(
      Line(points = {{-60, 187.2}, {-60, 187.2}, {-60, 182}, {-54, 182}, {-54, 170}, {-59.2, 170}, {-59.2, 169.5}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_II_M00.outTransition[2], T141.inPlaces[1]) annotation(
      Line(points = {{-80.8, 169.5}, {-86, 169.5}, {-86, 182}, {-80, 182}, {-80, 186}, {-80, 187.2}, {-80, 187.2}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_II_M00.outTransition[1], T136.inPlaces[1]) annotation(
      Line(points = {{-80.8, 170.5}, {-86, 170.5}, {-86, 156}, {-46, 156}, {-46, 162}, {-38, 162}, {-38, 162}, {-36.8, 162}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_I_M00.outTransition[1], T146.inPlaces[1]) annotation(
      Line(points = {{-59.2, 213.5}, {-54, 213.5}, {-54, 222}, {-38, 222}, {-38, 222}, {-36.8, 222}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_I_M00.outTransition[2], T140.inPlaces[1]) annotation(
      Line(points = {{-59.2, 214.5}, {-54, 214.5}, {-54, 202}, {-60, 202}, {-60, 198}, {-60, 196.8}, {-60, 196.8}}, thickness = 0.5));
    connect(T142.outPlaces[1], Canteen_RLT_Cooling_I_M00.inTransition[1]) annotation(
      Line(points = {{-36.8, 202}, {-88, 202}, {-88, 214}, {-80, 214}, {-80, 213.5}, {-80.8, 213.5}}, thickness = 0.5));
    connect(T141.outPlaces[1], Canteen_RLT_Cooling_I_M00.inTransition[2]) annotation(
      Line(points = {{-80, 196.8}, {-80, 202}, {-88, 202}, {-88, 214.5}, {-80.8, 214.5}}, thickness = 0.5));
    connect(T136.outPlaces[1], Canteen_RLT_Cooling_Off_M00.inTransition[2]) annotation(
      Line(points = {{-27.2, 162}, {8, 162}, {8, 192}, {6, 192}, {6, 191.5}, {6.8, 191.5}}, thickness = 0.5));
    connect(T146.outPlaces[1], Canteen_RLT_Cooling_Off_M00.inTransition[1]) annotation(
      Line(points = {{-27.2, 222}, {10, 222}, {10, 192}, {8, 192}, {8, 192.5}, {6.8, 192.5}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_Off_M00.outTransition[2], T138.inPlaces[1]) annotation(
      Line(points = {{-14.8, 191.5}, {-20, 191.5}, {-20, 182}, {-28, 182}, {-28, 182}, {-27.2, 182}}, thickness = 0.5));
    connect(Canteen_RLT_Cooling_Off_M00.outTransition[1], T142.inPlaces[1]) annotation(
      Line(points = {{-14.8, 192.5}, {-20, 192.5}, {-20, 202}, {-26, 202}, {-26, 202}, {-27.2, 202}}, thickness = 0.5));
    connect(T139.outPlaces[1], Canteen_RLT_Heating_II_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 182}, {82, 182}, {82, 170}, {88, 170}, {88, 169.5}, {87.2, 169.5}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_II_M00.outTransition[1], T137.inPlaces[1]) annotation(
      Line(points = {{108.8, 169.5}, {114, 169.5}, {114, 158}, {78, 158}, {78, 162}, {68, 162}, {68, 162}, {66.8, 162}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_I_M00.outTransition[1], T147.inPlaces[1]) annotation(
      Line(points = {{87.2, 214.5}, {82, 214.5}, {82, 222}, {66, 222}, {66, 222}, {66.8, 222}}, thickness = 0.5));
    connect(T145.outPlaces[1], Canteen_RLT_Heating_I_M00.inTransition[1]) annotation(
      Line(points = {{66.8, 202}, {114, 202}, {114, 214}, {110, 214}, {110, 214.5}, {108.8, 214.5}}, thickness = 0.5));
    connect(T137.outPlaces[1], Canteen_RLT_Heating_Off_M00.inTransition[2]) annotation(
      Line(points = {{57.2, 162}, {16, 162}, {16, 192}, {20, 192}, {20, 192.5}, {21.2, 192.5}}, thickness = 0.5));
    connect(T147.outPlaces[1], Canteen_RLT_Heating_Off_M00.inTransition[1]) annotation(
      Line(points = {{57.2, 222}, {16, 222}, {16, 191.5}, {21.2, 191.5}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_Off_M00.outTransition[2], T139.inPlaces[1]) annotation(
      Line(points = {{42.8, 192.5}, {46, 192.5}, {46, 182}, {56, 182}, {56, 182}, {57.2, 182}}, thickness = 0.5));
    connect(Canteen_RLT_Heating_Off_M00.outTransition[1], T145.inPlaces[1]) annotation(
      Line(points = {{42.8, 191.5}, {46, 191.5}, {46, 202}, {56, 202}, {56, 202}, {57.2, 202}}, thickness = 0.5));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -150}, {500, 450}})),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -150}, {500, 450}})),
      __OpenModelica_commandLineOptions = "",
      Documentation(info = "<html><head></head><body>Struktur des Output-Vektors:<div><br></div><div>1<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_RLT_Heating_Off_M00</div><div>2<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_RLT_Heating_I_M00</div><div>3<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_RLT_Heating_II_M00</div><div>4<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_RLT_Cooling_Off_M00</div><div>5<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_RLT_Cooling_I_M00</div><div>6<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_RLT_Cooling_II_M00</div><div><div>7<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_BKT_Heating_Off_M00</div><div>8<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_BKT_Heating_I_M00</div><div>9<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_BKT_Heating_II_M00</div><div>10<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_BKT_Cooling_Off_M00</div><div>11<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_BKT_Cooling_I_M00</div><div>12<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Workshop_BKT_Cooling_II_M00</div></div><div><br></div><div><div>13<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_RLT_Heating_Off_M00</div><div>14<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_RLT_Heating_I_M00</div><div>15<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_RLT_Heating_II_M00</div><div>16<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_RLT_Cooling_Off_M00</div><div>17<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_RLT_Cooling_I_M00</div><div>18<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_RLT_Cooling_II_M00</div><div><div>19<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_BKT_Heating_Off_M00</div><div>20<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_BKT_Heating_I_M00</div><div>21<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_BKT_Heating_II_M00</div><div>22<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_BKT_Cooling_Off_M00</div><div>23<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_BKT_Cooling_I_M00</div><div>24<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Canteen_BKT_Cooling_II_M00</div></div></div><div><br></div><div><div>25<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_RLT_Heating_Off_M00</div><div>26<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_RLT_Heating_I_M00</div><div>27<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_RLT_Heating_II_M00</div><div>28<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_RLT_Cooling_Off_M00</div><div>29<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_RLT_Cooling_I_M00</div><div>30<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_RLT_Cooling_II_M00</div><div><div>31<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_BKT_Heating_Off_M00</div><div>32<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_BKT_Heating_I_M00</div><div>33<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_BKT_Heating_II_M00</div><div>34<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_BKT_Cooling_Off_M00</div><div>35<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_BKT_Cooling_I_M00</div><div>36<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>ConferenceRoom_BKT_Cooling_II_M00</div></div></div><div><br></div><div><div>37<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_RLT_Heating_Off_M00</div><div>38<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_RLT_Heating_I_M00</div><div>39<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_RLT_Heating_II_M00</div><div>40<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_RLT_Cooling_Off_M00</div><div>41<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_RLT_Cooling_I_M00</div><div>42<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_RLT_Cooling_II_M00</div><div><div>43<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_BKT_Heating_Off_M00</div><div>44<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_BKT_Heating_I_M00</div><div>45<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_BKT_Heating_II_M00</div><div>46<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_BKT_Cooling_Off_M00</div><div>47<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_BKT_Cooling_I_M00</div><div>48<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>MultipersonOffice_BKT_Cooling_II_M00</div></div></div><div><br></div><div><div>49<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_RLT_Heating_Off_M00</div><div>50<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_RLT_Heating_I_M00</div><div>51<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_RLT_Heating_II_M00</div><div>52<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_RLT_Cooling_Off_M00</div><div>53<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_RLT_Cooling_I_M00</div><div>54<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_RLT_Cooling_II_M00</div><div><div>55<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_BKT_Heating_Off_M00</div><div>56<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_BKT_Heating_I_M00</div><div>57<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_BKT_Heating_II_M00</div><div>58<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_BKT_Cooling_Off_M00</div><div>59<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_BKT_Cooling_I_M00</div><div>60<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>OpenplanOffice_BKT_Cooling_II_M00</div></div></div><div><br></div><div><div>61<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>RLT_Central_Heating_Off_M00</div><div>62<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>RLT_Central_Heating_I_M00</div><div>63<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>RLT_Central_Heating_II_M00</div><div>64<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>RLT_Central_Cooling_Off_M00</div><div>65<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>RLT_Central_Cooling_I_M00</div><div>66<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>RLT_Central_Cooling_II_M00</div><div><br></div><div>67<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Hot_Off_M00</div><div>68<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Hot_I_M00</div><div>69<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Hot_II_M00</div><div><br></div><div>70<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Warm_Off_M00</div><div>71<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Warm_I_M00</div><div>72<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Warm_II_M00</div><div><br></div><div>73<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Cold_Off_M00</div><div>74<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Cold_I_M00</div><div>75<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>Generation_Cold_II_M00</div><div><div><br></div></div></div><div><br></div><div><br></div></body></html>"));
  end Automatisierungsebene;

  model Feldebene "Auswahl der Aktoren basierend auf den ausgewählten Aktorsätzen"
    import Benchmark_fb;
    AixLib.Systems.Benchmark.Controller.CtrHTSSystem ctrHTSSystem1 annotation(
      Placement(visible = true, transformation(origin = {-86, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus1 annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u[70] annotation(
      Placement(visible = true, transformation(origin = {2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1(threshold = 0.5)  annotation(
      Placement(visible = true, transformation(origin = {-16, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-74, 24}, {64, -10}}, textString = "Feldebene")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end Feldebene;

  model Controlling_MODI
    import Benchmark_fb;
    AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus annotation(
      Placement(visible = true, transformation(extent = {{90, -10}, {110, 10}}, rotation = 0), iconTransformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark_fb.MODI.ManagementEbene_Temp managementEbene_Temp1 annotation(
      Placement(visible = true, transformation(origin = {-40, 70}, extent = {{-20, -10}, {20, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark_fb.MODI.AutomatisierungsebeneV2 automatisierungsebeneV2 annotation(
      Placement(visible = true, transformation(origin = {-40, -2}, extent = {{-25, -15}, {25, 15}}, rotation = 0)));
  AixLib.Systems.Benchmark_fb.MODI.Feldebene feldebene1 annotation(
      Placement(visible = true, transformation(origin = {-40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(automatisierungsebeneV2.y[k], feldebene1.u[k]) annotation(
      Line(points = {{-40, -18}, {-40, -68.5}}, color = {0, 0, 127}, thickness = 0.5));
    connect(managementEbene_Temp1.y[k], automatisierungsebeneV2.u[k]) annotation(
      Line(points = {{-40, 58}, {-40, 14}}, color = {0, 0, 127}, thickness = 0.5));
    for k in 1:70 loop
    connect(automatisierungsebeneV2.y[k], feldebene1.u[k]) annotation(
      Line(points = {{-40, -6}, {-40, -6}, {-40, -48}, {-40, -48}}, color = {0, 0, 127}, thickness = 0.5));
    end for;
    connect(mainBus1, mainBus) annotation(
      Line(points = {{-30, -60}, {100, -60}, {100, -2}, {100, -2}, {100, 0}}, color = {255, 204, 51}, thickness = 0.5));
    for k in 1:15 loop
    connect(managementEbene_Temp1.y[k], automatisierungsebeneV2.u[k]) annotation(
      Line(points = {{-40, 58}, {-40, 58}, {-40, 26}, {-40, 26}}, color = {0, 0, 127}, thickness = 0.5));
     end for;
      
      
      
      
    connect(mainBus, managementEbene_Temp1.mainBus) annotation(
      Line(points = {{100, 0}, {100, 100}, {-40, 100}, {-40, 80}}, color = {255, 204, 51}, thickness = 0.5));
    connect(feldebene.mainBus, mainBus) annotation(
      Line(points = {{-50, -79.8}, {-50, -86}, {60, -86}, {60, 0}, {96, 0}}, color = {255, 204, 51}, thickness = 0.5),
      Text(string = "%second", index = 1, extent = {{-3, -6}, {-3, -6}}, horizontalAlignment = TextAlignment.Right));
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

  model ManagementEbene_Temp "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten für die Temperature und relative Luftfeuchtigkeit im Raum"
    PNlib.Components.T disableHeating[5](each nIn = 1, each nOut = 1, firingCon = {mainBus.TRoom1Mea > 273.15 + 15, mainBus.TRoom2Mea > 273.15 + 20, mainBus.TRoom3Mea > 273.15 + 20, mainBus.TRoom4Mea > 273.15 + 20, mainBus.TRoom5Mea > 273.15 + 20}) annotation(
      Placement(visible = true, transformation(origin = {44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T enableHeating[5](each nIn = 1, each nOut = 1, firingCon = {mainBus.TRoom1Mea < 273.15 + 13, mainBus.TRoom2Mea < 273.15 + 18, mainBus.TRoom3Mea < 273.15 + 18, mainBus.TRoom4Mea < 273.15 + 18, mainBus.TRoom5Mea < 273.15 + 18}) annotation(
      Placement(visible = true, transformation(extent = {{34, 20}, {54, 40}}, rotation = 0)));
    PNlib.Components.PD Heating[5](each nIn = 1, each nOut = 1, each startTokens = 0, each minTokens = 0, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {84, -2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    PNlib.Components.PD Off_Temperature[5](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1, each reStart = true, each reStartTokens = 1) annotation(
      Placement(visible = true, transformation(origin = { 0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.PD Cooling[5](each nIn = 1, each nOut = 1, each maxTokens = 1) annotation(
      Placement(visible = true, transformation(origin = {-82, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    PNlib.Components.T enableCooling[5](each nIn = 1, each nOut = 1, firingCon = {mainBus.TRoom1Mea > 273.15 + 17, mainBus.TRoom2Mea > 273.15 + 22, mainBus.TRoom3Mea > 273.15 + 22, mainBus.TRoom4Mea > 273.15 + 22, mainBus.TRoom5Mea > 273.15 + 22}) annotation(
      Placement(visible = true, transformation(origin = {-44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PNlib.Components.T disableCooling[5](each nIn = 1, each nOut = 1, firingCon = {mainBus.TRoom1Mea < 273.15 + 15, mainBus.TRoom2Mea < 273.15 + 20, mainBus.TRoom3Mea < 273.15 + 20, mainBus.TRoom4Mea < 273.15 + 20, mainBus.TRoom5Mea < 273.15 + 20}) annotation(
      Placement(visible = true, transformation(extent = {{-54, 20}, {-34, 40}}, rotation = 0)));
    Benchmark.BaseClasses.MainBus mainBus annotation(
      Placement(transformation(extent = {{-10, 86}, {10, 106}})));
  Modelica.Blocks.Interfaces.RealOutput y[15] annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
  y[1]=Off_Temperature[1].t;
  y[2]=Heating[1].t;
  y[3]=Cooling[1].t;
  y[4]=Off_Temperature[2].t;
  y[5]=Heating[2].t;
  y[6]=Cooling[2].t;
  y[7]=Off_Temperature[3].t;
  y[8]=Heating[3].t;
  y[9]=Cooling[3].t;
  y[10]=Off_Temperature[4].t;
  y[11]=Heating[4].t;
  y[12]=Cooling[4].t;
  y[13]=Off_Temperature[5].t;
  y[14]=Heating[5].t;
  y[15]=Cooling[5].t;
  
  
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
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}}), graphics = {Rectangle(extent = {{-200, 100}, {200, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Text(extent = {{-162, 34}, {152, -28}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, textString = "Management-Ebene")}),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}})),
      Documentation(info = "<html><head></head><body>Struktur des MODI_Temperature-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Canteen_Off</div><div>ConferenceRoom_Off</div><div>MultipersonOffice_Off</div><div>OpenplanOffice_Off</div><div><div>Workshop_Heating</div><div>Canteen_Heating</div><div>ConferenceRoom_Heating</div><div>MultipersonOffice_Heating</div><div>OpenplanOffice_Heating</div></div><div><div>Workshop_Cooling</div><div>Canteen_Cooling</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Cooling</div></div><div><br></div><div>Struktur des MODI_Humidity-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Canteen_Off</div><div>ConferenceRoom_Off</div><div>MultipersonOffice_Off</div><div>OpenplanOffice_Off</div><div><div>Workshop_Humidifying</div><div>Canteen_Humidifying</div><div>ConferenceRoom_Humidifying</div><div>MultipersonOffice_Humidifying</div><div>OpenplanOffice_Humidifying</div></div><div><div>Workshop_Dehumidifying</div><div>Canteen_Dehumidifying</div><div>ConferenceRoom_Dehumidifying</div><div>MultipersonOffice_Dehumidifying</div><div>OpenplanOffice_Dehumidifying</div></div></div></body></html>"),
      __OpenModelica_commandLineOptions = "");
  end ManagementEbene_Temp;
end MODI;
