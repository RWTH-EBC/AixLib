within AixLib.Systems.Benchmark_fb;
package Mode_based_ControlStrategy
  model Mode_based_Controller

    AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus annotation (
      Placement(visible = true, transformation(extent={{90,70},{110,90}},      rotation = 0), iconTransformation(extent={{90,70},
              {110,90}},                                                                                                                         rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput TAirOutside annotation (
      Placement(visible = true, transformation(origin={108,20},   extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin={108,20},   extent = {{-14, -14}, {14, 14}}, rotation = 180)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Level.FieldLevel fieldLevel1
      annotation (Placement(visible=true, transformation(
          origin={-40,-70},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Level.ManagementLevel_Temp_V2 managementLevel_Temp_V2_1
      annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
    Level.AutomationLevel_V1 automationLevel_V1_1
      annotation (Placement(transformation(extent={{-60,-20},{-20,0}})));
  equation
    connect(fieldLevel1.mainBus, mainBus) annotation (Line(
        points={{-36.2,-60},{80,-60},{80,80},{100,80}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.TRoom1Mea, managementLevel_Temp_V2_1.RoomTempMea[1])
      annotation (Line(
        points={{100.05,80.05},{86,80.05},{86,80},{-40,80},{-40,61.88}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.TRoom2Mea, managementLevel_Temp_V2_1.RoomTempMea[2])
      annotation (Line(
        points={{100.05,80.05},{84,80.05},{84,80},{-40,80},{-40,61.24}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.TRoom3Mea, managementLevel_Temp_V2_1.RoomTempMea[3])
      annotation (Line(
        points={{100.05,80.05},{88,80.05},{88,80},{-40,80},{-40,60.6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.TRoom4Mea, managementLevel_Temp_V2_1.RoomTempMea[4])
      annotation (Line(
        points={{100.05,80.05},{-40,80.05},{-40,59.96}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.TRoom5Mea, managementLevel_Temp_V2_1.RoomTempMea[5])
      annotation (Line(
        points={{100.05,80.05},{90,80.05},{90,80},{-40,80},{-40,59.32}},
        color={255,204,51},
        thickness=0.5));
    connect(managementLevel_Temp_V2_1.Superior_Mode[1], automationLevel_V1_1.Superior_Mode[
      1]) annotation (Line(points={{-40,40.35},{-40,1.25}}, color={255,0,255}));
    connect(managementLevel_Temp_V2_1.Superior_Mode[2], automationLevel_V1_1.Superior_Mode[
      2]) annotation (Line(points={{-40,39.85},{-40,0.892857}},
                                                            color={255,0,255}));
    connect(managementLevel_Temp_V2_1.Superior_Mode[3], automationLevel_V1_1.Superior_Mode[
      3]) annotation (Line(points={{-40,39.35},{-40,0.535714}},
                                                            color={255,0,255}));
    connect(managementLevel_Temp_V2_1.Superior_Mode[4], automationLevel_V1_1.Superior_Mode[
      4]) annotation (Line(points={{-40,38.85},{-40,0.178571}},
                                                            color={255,0,255}));
    connect(TAirOutside, automationLevel_V1_1.TAirOutside)
      annotation (Line(points={{108,20},{-24,20},{-24,0.714286}},
                                                           color={0,0,127}));
    connect(mainBus.TRoom1Mea, automationLevel_V1_1.TRoomMea[1]) annotation (Line(
        points={{100.05,80.05},{80,80.05},{80,20},{-28,20},{-28,1.28571}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.TRoom2Mea, automationLevel_V1_1.TRoomMea[2]) annotation (Line(
        points={{100.05,80.05},{80,80.05},{80,20},{-28,20},{-28,1}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.TRoom3Mea, automationLevel_V1_1.TRoomMea[3]) annotation (Line(
        points={{100.05,80.05},{80,80.05},{80,20},{-28,20},{-28,0.714286}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.TRoom4Mea, automationLevel_V1_1.TRoomMea[4]) annotation (Line(
        points={{100.05,80.05},{80,80.05},{80,20},{-28,20},{-28,0.428571}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.TRoom5Mea, automationLevel_V1_1.TRoomMea[5]) annotation (Line(
        points={{100.05,80.05},{80,80.05},{80,20},{-28,20},{-28,0.142857}},
        color={255,204,51},
        thickness=0.5));
    connect(automationLevel_V1_1.y[1], fieldLevel1.u[1]) annotation (Line(points={{-40,
            -19.5907},{-40,-19.5907},{-40,-57.8649},{-44,-57.8649}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[2], fieldLevel1.u[2]) annotation (Line(points={{-40,
            -19.6293},{-40,-19.6293},{-40,-57.9279},{-44,-57.9279}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[3], fieldLevel1.u[3]) annotation (Line(points={{-40,
            -19.668},{-40,-19.668},{-40,-57.991},{-44,-57.991}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[4], fieldLevel1.u[4]) annotation (Line(points={{-40,
            -19.7066},{-40,-19.7066},{-40,-58.0541},{-44,-58.0541}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[5], fieldLevel1.u[5]) annotation (Line(points={{-40,
            -19.7452},{-40,-19.7452},{-40,-58.1171},{-44,-58.1171}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[6], fieldLevel1.u[6]) annotation (Line(points={{-40,
            -19.7838},{-40,-19.7838},{-40,-58.1802},{-44,-58.1802}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[7], fieldLevel1.u[7]) annotation (Line(points={{-40,
            -19.8224},{-40,-19.8224},{-40,-58.2432},{-44,-58.2432}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[8], fieldLevel1.u[8]) annotation (Line(points={{-40,
            -19.861},{-40,-19.861},{-40,-58.3063},{-44,-58.3063}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[9], fieldLevel1.u[9]) annotation (Line(points={{-40,
            -19.8996},{-40,-19.8996},{-40,-58.3694},{-44,-58.3694}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[10], fieldLevel1.u[10]) annotation (Line(points={{-40,
            -19.9382},{-40,-19.9382},{-40,-58.4324},{-44,-58.4324}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[11], fieldLevel1.u[11]) annotation (Line(points={{-40,
            -19.9768},{-40,-19.9768},{-40,-58.4955},{-44,-58.4955}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[12], fieldLevel1.u[12]) annotation (Line(points={{-40,
            -20.0154},{-40,-20.0154},{-40,-58.5586},{-44,-58.5586}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[13], fieldLevel1.u[13]) annotation (Line(points={{-40,
            -20.0541},{-40,-20.0541},{-40,-58.6216},{-44,-58.6216}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[14], fieldLevel1.u[14]) annotation (Line(points={{-40,
            -20.0927},{-40,-20.0927},{-40,-58.6847},{-44,-58.6847}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[15], fieldLevel1.u[15]) annotation (Line(points={{-40,
            -20.1313},{-40,-20.1313},{-40,-58.7477},{-44,-58.7477}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[16], fieldLevel1.u[16]) annotation (Line(points={{-40,
            -20.1699},{-40,-20.1699},{-40,-58.8108},{-44,-58.8108}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[17], fieldLevel1.u[17]) annotation (Line(points={{-40,
            -20.2085},{-40,-20.2085},{-40,-58.8739},{-44,-58.8739}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[18], fieldLevel1.u[18]) annotation (Line(points={{-40,
            -20.2471},{-40,-20.2471},{-40,-58.9369},{-44,-58.9369}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[19], fieldLevel1.u[19]) annotation (Line(points={{-40,
            -20.2857},{-40,-20.2857},{-40,-59},{-44,-59}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[20], fieldLevel1.u[20]) annotation (Line(points={{-40,
            -20.3243},{-40,-20.3243},{-40,-59.0631},{-44,-59.0631}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[21], fieldLevel1.u[21]) annotation (Line(points={{-40,
            -20.3629},{-40,-20.3629},{-40,-59.1261},{-44,-59.1261}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[22], fieldLevel1.u[22]) annotation (Line(points={{-40,
            -20.4015},{-40,-20.4015},{-40,-59.1892},{-44,-59.1892}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[23], fieldLevel1.u[23]) annotation (Line(points={{-40,
            -20.4402},{-40,-20.4402},{-40,-59.2523},{-44,-59.2523}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[24], fieldLevel1.u[24]) annotation (Line(points={{-40,
            -20.4788},{-40,-20.4788},{-40,-59.3153},{-44,-59.3153}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[25], fieldLevel1.u[25]) annotation (Line(points={{-40,
            -20.5174},{-40,-20.5174},{-40,-59.3784},{-44,-59.3784}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[26], fieldLevel1.u[26]) annotation (Line(points={{-40,
            -20.556},{-40,-20.556},{-40,-59.4414},{-44,-59.4414}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[27], fieldLevel1.u[27]) annotation (Line(points={{-40,
            -20.5946},{-40,-20.5946},{-40,-59.5045},{-44,-59.5045}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[28], fieldLevel1.u[28]) annotation (Line(points={{-40,
            -20.6332},{-40,-20.6332},{-40,-59.5676},{-44,-59.5676}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[29], fieldLevel1.u[29]) annotation (Line(points={{-40,
            -20.6718},{-40,-20.6718},{-40,-59.6306},{-44,-59.6306}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[30], fieldLevel1.u[30]) annotation (Line(points={{-40,
            -20.7104},{-40,-20.7104},{-40,-59.6937},{-44,-59.6937}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[31], fieldLevel1.u[31]) annotation (Line(points={{-40,
            -20.749},{-40,-20.749},{-40,-59.7568},{-44,-59.7568}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[32], fieldLevel1.u[32]) annotation (Line(points={{-40,
            -20.7876},{-40,-20.7876},{-40,-59.8198},{-44,-59.8198}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[33], fieldLevel1.u[33]) annotation (Line(points={{-40,
            -20.8263},{-40,-20.8263},{-40,-59.8829},{-44,-59.8829}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[34], fieldLevel1.u[34]) annotation (Line(points={{-40,
            -20.8649},{-40,-20.8649},{-40,-59.9459},{-44,-59.9459}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[35], fieldLevel1.u[35]) annotation (Line(points={{-40,
            -20.9035},{-40,-20.9035},{-40,-60.009},{-44,-60.009}},
                                            color={255,0,255}));
             connect(automationLevel_V1_1.y[36], fieldLevel1.u[36]) annotation (Line(points={{-40,
            -20.9421},{-40,-20.9421},{-40,-60.0721},{-44,-60.0721}},
                                            color={255,0,255}));
    connect(automationLevel_V1_1.y[37], fieldLevel1.u[37]) annotation (Line(points={{-40,
            -20.9807},{-40,-20.9807},{-40,-60.1351},{-44,-60.1351}},
                                            color={255,0,255}));
    connect(automationLevel_V1_1.T_CS, mainBus.hpSystemBus.TBottomCSMea)
      annotation (Line(points={{-35.9,0.785714},{-35.9,20},{80,20},{80,80.05},{100.05,
            80.05}},        color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(automationLevel_V1_1.T_GEO, mainBus.gtfBus.primBus.TFwrdOutMea)
      annotation (Line(points={{-32,0.714286},{-32,20},{80,20},{80,80.05},{100.05,
            80.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
              fillPattern =                                                                                                                                              FillPattern.Solid,
              lineThickness =                                                                                                                                                                               0.5, extent = {{-100, 100}, {100, -100}}), Text(lineColor=
                {95,95,95},                                                                                                                                                                                                        fillColor=
                {215,215,215},
              fillPattern=FillPattern.Solid,                                                                                                                                                                                                        extent={{
                -100,80},{100,-66}},
            textString="Mode-
based
Controller")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)),
      Documentation(info = "<html><head></head><body>MODI control strategy</body></html>"));
  end Mode_based_Controller;

  package Level
    model FieldLevel "Auswahl der Aktoren basierend auf den ausgewählten Aktorsätzen"

      AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus annotation (
          Placement(
          visible=true,
          transformation(
            origin={38,120},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={38,120},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput u[37] annotation (
        Placement(visible = true, transformation(origin={-40,132},            extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin={-40,132},            extent = {{-14, -14}, {14, 14}}, rotation = -90)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_GTFSystem
        controller_GTFSystem1 annotation (Placement(visible=true,
            transformation(
            origin={-80,90},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_HPSystem
        controller_HPSystem1 annotation (Placement(visible=true, transformation(
            origin={-80,10},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_SwitchingUnit
        controller_SwitchingUnit1(rpmPump=2000) annotation (Placement(visible=
              true, transformation(
            origin={-80,70},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_HTSSystem
        controller_HTSSystem1 annotation (Placement(visible=true,
            transformation(
            origin={-80,110},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
        controller_Tabs_Workshop(TflowSet=288.15) annotation (Placement(visible=
             true, transformation(extent={{-90,-40},{-70,-20}}, rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
        controller_VU_Workshop(TRoomSet=288.15, VFlowSet=2700/3600) annotation (
         Placement(visible=true, transformation(
            origin={50,-30},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
        controller_VU_Canteen(TRoomSet=293.15, VFlowSet=1800/3600) annotation (
          Placement(visible=true, transformation(
            origin={50,-50},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
        controller_VU_ConferenceRoom(TRoomSet=293.15, VFlowSet=150/3600)
        annotation (Placement(visible=true, transformation(
            origin={50,-70},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
        controller_VU_MultipersonOffice(VFlowSet=300/3600) annotation (
          Placement(visible=true, transformation(
            origin={50,-90},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
        controller_VU_OpenplanOffice(VFlowSet=4050/3600) annotation (Placement(
            visible=true, transformation(
            origin={50,-110},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
        controller_Tabs_Canteen(TflowSet=293.15) annotation (Placement(visible=
              true, transformation(extent={{-90,-60},{-70,-40}}, rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
        controller_Tabs_ConferenceRoom(TflowSet=293.15) annotation (Placement(
            visible=true, transformation(extent={{-90,-80},{-70,-60}}, rotation=
               0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
        controller_Tabs_MultipersonOffice(TflowSet=293.15) annotation (
          Placement(visible=true, transformation(extent={{-90,-100},{-70,-80}},
              rotation=0)));
      AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
        controller_Tabs_OpenplanOffice(TflowSet=293.15) annotation (Placement(
            visible=true, transformation(extent={{-90,-120},{-70,-100}},
              rotation=0)));
      Controller.Controller_HX controller_HX(TflowSet=293.15, rpmPumpPrim=130)
        annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
      Modelica.Blocks.Sources.BooleanConstant HP_mode
        annotation (Placement(transformation(extent={{40,30},{60,50}})));
      Modelica.Blocks.Sources.Constant HP_iceFac(k=1)
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
      Modelica.Blocks.Logical.Or or2 annotation (
        Placement(visible = true, transformation(origin={52,72},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Controller.Controller_CentralAHU controller_CentralAHU
        annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
    equation
      connect(controller_Tabs_OpenplanOffice.Cooling, u[37]) annotation (
        Line(points={{-69.6,-118},{-40,-118},{-40,118.378}},
                                                          color = {255, 0, 255}));
      connect(controller_Tabs_OpenplanOffice.Heating, u[36]) annotation (
        Line(points={{-69.4,-114},{-40,-114},{-40,119.135}},
                                                          color = {255, 0, 255}));
      connect(controller_Tabs_MultipersonOffice.Cooling, u[34]) annotation (
        Line(points={{-69.6,-98},{-40,-98},{-40,120.649}},
                                                        color = {255, 0, 255}));
      connect(controller_Tabs_MultipersonOffice.Heating, u[33]) annotation (
        Line(points={{-69.4,-94},{-40,-94},{-40,121.405}},
                                                        color = {255, 0, 255}));
      connect(controller_Tabs_ConferenceRoom.Cooling, u[31]) annotation (
        Line(points={{-69.6,-78},{-40,-78},{-40,122.919}},
                                                        color = {255, 0, 255}));
      connect(controller_Tabs_ConferenceRoom.Heating, u[30]) annotation (
        Line(points={{-69.4,-74},{-40,-74},{-40,123.676}},
                                                        color = {255, 0, 255}));
      connect(controller_Tabs_Canteen.Cooling, u[28]) annotation (
        Line(points={{-69.6,-58},{-40,-58},{-40,125.189}},
                                                        color = {255, 0, 255}));
      connect(controller_Tabs_Canteen.Heating, u[27]) annotation (
        Line(points={{-69.4,-54},{-40,-54},{-40,125.946}},
                                                        color = {255, 0, 255}));
      connect(u[25], controller_Tabs_Workshop.Cooling) annotation (
        Line(points={{-40,127.459},{-40,-38},{-69.6,-38}},
                                                        color = {255, 0, 255}));
      connect(u[24], controller_Tabs_Workshop.Heating) annotation (
        Line(points={{-40,128.216},{-40,-34},{-69.4,-34}},
                                                        color = {255, 0, 255}));
      connect(controller_VU_OpenplanOffice.Cooling, u[37]) annotation (
        Line(points={{60.6,-118},{80,-118},{80,-120},{-40,-120},{-40,118.378}},
                                                                             color = {255, 0, 255}));
      connect(controller_VU_OpenplanOffice.Heating, u[36]) annotation (
        Line(points={{60.6,-114},{80,-114},{80,-120},{-40,-120},{-40,119.135}},
                                                                             color = {255, 0, 255}));
      connect(controller_VU_MultipersonOffice.Cooling, u[34]) annotation (
        Line(points={{60.6,-98},{80,-98},{80,-120},{-40,-120},{-40,120.649}},
                                                                           color = {255, 0, 255}));
      connect(controller_VU_MultipersonOffice.Heating, u[33]) annotation (
        Line(points={{60.6,-94},{80,-94},{80,-120},{-40,-120},{-40,121.405}},
                                                                           color = {255, 0, 255}));
      connect(controller_VU_ConferenceRoom.Cooling, u[31]) annotation (
        Line(points={{60.6,-78},{80,-78},{80,-120},{-40,-120},{-40,122.919}},
                                                                           color = {255, 0, 255}));
      connect(controller_VU_ConferenceRoom.Heating, u[30]) annotation (
        Line(points={{60.6,-74},{80,-74},{80,-120},{-40,-120},{-40,123.676}},
                                                                           color = {255, 0, 255}));
      connect(controller_VU_Canteen.Cooling, u[28]) annotation (
        Line(points={{60.6,-58},{80,-58},{80,-120},{-40,-120},{-40,125.189}},
                                                                           color = {255, 0, 255}));
      connect(controller_VU_Canteen.Heating, u[27]) annotation (
        Line(points={{60.6,-54},{80,-54},{80,-120},{-40,-120},{-40,125.946}},
                                                                           color = {255, 0, 255}));
      connect(controller_VU_Workshop.Cooling, u[25]) annotation (
        Line(points={{60.6,-38},{80,-38},{80,-120},{-40,-120},{-40,127.459}},
                                                                           color = {255, 0, 255}));
      connect(controller_VU_Workshop.Heating, u[24]) annotation (
        Line(points={{60.6,-34},{80,-34},{80,-120},{-40,-120},{-40,128.216}},
                                                                           color = {255, 0, 255}));
      connect(u[2], controller_HTSSystem1.HTS_Heating_I) annotation (
        Line(points={{-40,144.865},{-40,118},{-68.6,118}},
                                                        color = {255, 0, 255}));
      connect(u[3], controller_HTSSystem1.HTS_Heating_II) annotation (
        Line(points={{-40,144.108},{-40,102},{-68.6,102}},
                                                        color = {255, 0, 255}));
      connect(mainBus.htsBus, controller_HTSSystem1.highTempSystemBus1)
        annotation (Line(
          points={{38.05,120.05},{38.05,120},{-20,120},{-20,110},{-70,110}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.gtfBus, controller_GTFSystem1.gtfBus) annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,120},{-20,120},{-20,84},{-70,84}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.swuBus, controller_SwitchingUnit1.switchingUnitBus1)
        annotation (Line(
          points={{38.05,120.05},{38.05,120},{-20,120},{-20,70},{-70,70}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.hpSystemBus, controller_HPSystem1.heatPumpSystemBus1)
        annotation (Line(
          points={{38.05,120.05},{38.05,122},{38,122},{38,120},{-20,120},{-20,10},{-70,
              10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.vu1Bus, controller_VU_Workshop.genericAHUBus1)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-30},{60,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.vu2Bus, controller_VU_Canteen.genericAHUBus1) annotation (
         Line(
          points={{38.05,120.05},{100,120.05},{100,-52},{60,-52},{60,-50}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.vu3Bus, controller_VU_ConferenceRoom.genericAHUBus1)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-70},{60,-70}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.vu4Bus, controller_VU_MultipersonOffice.genericAHUBus1)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-90},{60,-90}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.vu5Bus, controller_VU_OpenplanOffice.genericAHUBus1)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-110},{60,-110}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.tabs1Bus, controller_Tabs_Workshop.tabsBus21) annotation (
         Line(
          points={{38.05,120.05},{100,120.05},{100,-120},{-20,-120},{-20,-28},{-46,-28},
              {-46,-30},{-70,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(mainBus.tabs2Bus, controller_Tabs_Canteen.tabsBus21) annotation (
          Line(
          points={{38.05,120.05},{100,120.05},{100,-120},{-20,-120},{-20,-50},{-70,-50}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(mainBus.tabs3Bus, controller_Tabs_ConferenceRoom.tabsBus21)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-120},{-20,-120},{-20,-70},{-70,-70}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));

      connect(mainBus.tabs4Bus, controller_Tabs_MultipersonOffice.tabsBus21)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-120},{-20,-120},{-20,-90},{-70,-90}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(mainBus.tabs5Bus, controller_Tabs_OpenplanOffice.tabsBus21)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-120},{-20,-120},{-20,-110},{-70,
              -110}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(mainBus.hxBus, controller_HX.hxBus) annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,120},{-20,120},{-20,50},{-46,50},
              {-46,50.1},{-68.9,50.1}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(mainBus.TRoom1Mea, controller_VU_Workshop.TRoomMea) annotation (
          Line(
          points={{38.05,120.05},{100,120.05},{100,-22},{60.6,-22}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.TRoom2Mea, controller_VU_Canteen.TRoomMea) annotation (
          Line(
          points={{38.05,120.05},{100,120.05},{100,-42},{60.6,-42}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.TRoom3Mea, controller_VU_ConferenceRoom.TRoomMea)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-62},{60.6,-62}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.TRoom4Mea, controller_VU_MultipersonOffice.TRoomMea)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-82},{60.6,-82}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(mainBus.TRoom5Mea, controller_VU_OpenplanOffice.TRoomMea)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,-102},{60.6,-102}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.hpSystemBus.TTopHSMea, controller_HPSystem1.T_HotStorage)
        annotation (Line(
          points={{38.05,120.05},{38.05,120},{-20,120},{-20,-10},{-88,-10},{-88,-0.8}},
          color={255,204,51},
          thickness=0.5));
      connect(mainBus.hpSystemBus.TTopCSMea, controller_HPSystem1.T_ColdStorage)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,120},{-20,120},{-20,-10},{-76,-10},
              {-76,-1}},
          color={255,204,51},
          thickness=0.5));
      connect(mainBus.hpSystemBus.busHP.T_ret_co, controller_HPSystem1.T_Condensator)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,120},{-20,120},{-20,-10},{-84,-10},
              {-84,-0.8}},
          color={255,204,51},
          thickness=0.5));
      connect(mainBus.hpSystemBus.busHP.T_ret_ev, controller_HPSystem1.T_Evaporator)
        annotation (Line(
          points={{38.05,120.05},{100,120.05},{100,120},{-20,120},{-20,-10},{-80,-10},
              {-80,-0.8}},
          color={255,204,51},
          thickness=0.5));
      connect(HP_iceFac.y, mainBus.hpSystemBus.busHP.iceFac) annotation (Line(
            points={{61,10},{100,10},{100,120.05},{38.05,120.05}},
                                                                color={0,0,127}));
      connect(HP_mode.y, mainBus.hpSystemBus.busHP.mode) annotation (Line(
            points={{61,40},{100,40},{100,120.05},{38.05,120.05}},
                                                                color={255,0,
              255}));
      connect(or2.y, mainBus.hpSystemBus.AirCoolerOnSet) annotation (Line(
            points={{63,72},{100,72},{100,120},{38.05,120},{38.05,120.05}},
                                                                        color={
              255,0,255}));
      connect(HP_mode.y, or2.u2) annotation (Line(points={{61,40},{80,40},{80,56},{26,
              56},{26,64},{40,64}},         color={255,0,255}));
      connect(HP_mode.y, or2.u1) annotation (Line(points={{61,40},{82,40},{82,28},{18,
              28},{18,72},{40,72}},         color={255,0,255}));
      connect(u[7], controller_GTFSystem1.GTF_On) annotation (Line(points={{-40,
              141.081},{-40,96},{-69.2,96}},
                                    color={255,0,255}));
      connect(u[5], controller_HX.On) annotation (Line(points={{-40,142.595},{
              -40,54},{-69.3,54},{-69.3,55.1}},
                                        color={255,0,255}));
      connect(u[13], controller_SwitchingUnit1.Heating_GTF) annotation (Line(points={{-40,
              136.541},{-40,78},{-69.4,78}},      color={255,0,255}));
      connect(u[14], controller_SwitchingUnit1.Heating_GTFandCon) annotation (Line(
            points={{-40,135.784},{-40,74},{-69.4,74}}, color={255,0,255}));
      connect(u[17], controller_SwitchingUnit1.Cooling_GTFandHP) annotation (Line(
            points={{-40,133.514},{-40,60},{-69.4,60}}, color={255,0,255}));
      connect(u[16], controller_SwitchingUnit1.Cooling_HP) annotation (Line(points={{-40,
              134.27},{-40,64},{-69.4,64}},      color={255,0,255}));
      connect(controller_SwitchingUnit1.Cooling_GTF, u[15]) annotation (Line(points={{-69.4,
              68},{-40,68},{-40,135.027}},        color={255,0,255}));
      connect(controller_CentralAHU.CentralAHU_Heating, u[19])
        annotation (Line(points={{-69.6,38.5714},{-40,38.5714},{-40,132}},
                                                               color={255,0,255}));
      connect(controller_CentralAHU.CentralAHU_Heating_Preheating, u[20])
        annotation (Line(points={{-70.2,35.7143},{-40,35.7143},{-40,131.243}},
                                                                     color={255,0,255}));
      connect(controller_CentralAHU.CentralAHU_Cooling, u[21]) annotation (Line(
            points={{-70,30},{-70,28},{-40,28},{-40,130.486}}, color={255,0,255}));
      connect(controller_CentralAHU.CentralAHU_Combi, u[22]) annotation (Line(
            points={{-70,27.1429},{-40,27.1429},{-40,129.73}},
                                                     color={255,0,255}));
      connect(controller_HPSystem1.HP_Heating, u[9]) annotation (Line(points={{-69.4,
              18},{-40,18},{-40,139.568}}, color={255,0,255}));
      connect(controller_HPSystem1.HP_Cooling, u[10]) annotation (Line(points={{-69.4,2},
              {-40,2},{-40,138.811}},    color={255,0,255}));
      connect(u[11], controller_HPSystem1.HP_Combi) annotation (Line(points={{-40,
              138.054},{-40,6},{-69.4,6}},
                                  color={255,0,255}));
      connect(mainBus.ahuBus, controller_CentralAHU.genericAHUBus) annotation (
          Line(
          points={{38.05,120.05},{-20,120.05},{-20,32},{-70,32},{-70,32.9286}},
          color={255,204,51},
          thickness=0.5));

      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -120}, {100, 120}}), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                               FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                0.5, extent={{
                  -200,120},{202,-120}}),                                                                                                                                                                                                        Text(origin={
                  -64.497,31.3324},                                                                                                                                                                                                        lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent={{
                  -129.503,54.6676},{262.497,-109.331}},                                                                                                                                                                                                        textString = "Field 
 Level")}),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -120}, {100, 120}})),
        Documentation(info = "<html><head></head><body>Feldebene der MODI-Methode<div><br></div><div><br></div></body></html>"),
        __OpenModelica_commandLineOptions = "");
    end FieldLevel;

    model AutomationLevel_V1
      PNlib.Components.PD HTS_Heating_II(enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, reStartTokens = 0, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-148,32},    extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      PNlib.Components.TD T1(
        nIn=1,
        nOut=1,
        delay=180,
        firingCon=Superior_Mode[1] or Superior_Mode[3])    annotation (Placement(
            visible=true, transformation(
            origin={-167,67},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.PD HTS_Heating_I(                                                  maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, reStartTokens = 0, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-148,60},    extent = {{-6, -6}, {6, 6}}, rotation = 90)));
      PNlib.Components.PD HTS_Off(enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={-182,46},    extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      PNlib.Components.TD T11(
        nIn=1,
        nOut=1,
        delay=180,
        firingCon=(Superior_Mode[2] or Superior_Mode[4]) and TAirOutside >
            283.15)                        annotation (Placement(visible=true,
            transformation(
            origin={-167,53},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.TD T12(
        nIn=1,
        nOut=1,
        delay=180,
        firingCon=(Superior_Mode[2] or Superior_Mode[4]) and TAirOutside <=
            283.15)                         annotation (Placement(visible=true,
            transformation(
            origin={-167,39},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.TD T13(
        nIn=1,
        nOut=1,
        delay=180,
        firingCon=Superior_Mode[1] or Superior_Mode[3])    annotation (Placement(
            visible=true, transformation(
            origin={-167,25},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.TD T14(nIn = 1, nOut = 1,
        delay=180,
        firingCon=(Superior_Mode[2] or Superior_Mode[4]) and TAirOutside <=
            283.15)                                                                                                             annotation (
        Placement(visible = true, transformation(origin={-141,45},    extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.TD T15(nIn = 1, nOut = 1,
        delay=180,
        firingCon=(Superior_Mode[2] or Superior_Mode[4]) and TAirOutside >
            283.15)                                                                                                          annotation (
        Placement(visible = true, transformation(origin={-155,45},    extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.TD T16(
        delay=180,
        firingCon=Superior_Mode[3],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-183,-127},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.PD HP_Heating(
        enablingType=PNlib.Types.EnablingType.Priority,
        maxTokens=1,
        minTokens=0,
        nIn=2,
        nOut=2,
        startTokens=0) annotation (Placement(visible=true, transformation(
            origin={-108,-134},
            extent={{-6,-6},{6,6}},
            rotation=90)));
      PNlib.Components.TD T17(
        delay=180,
        firingCon=Superior_Mode[4],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-183,-141},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.TD T18(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-149,-153},
            extent={{-7,-7},{7,7}},
            rotation=90)));
      PNlib.Components.TD T19(
        delay=180,
        firingCon=Superior_Mode[4] or (Superior_Mode[2] and TAirOutside <=
            283.15),
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-135,-153},
            extent={{-7,-7},{7,7}},
            rotation=-90)));
      PNlib.Components.PD HP_Off(enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0,
        nIn=3,
        nOut=3,                                                                                                                     reStart = true, reStartTokens = 1, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={-140,-134}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      PNlib.Components.TD T110(
        delay=180,
        firingCon=Superior_Mode[2] and TAirOutside > 283.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-125,-141},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.TD T111(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-125,-127},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.TD T113(
        nIn=1,
        nOut=1,
        delay=180,
        firingCon=Superior_Mode[1])                       annotation (Placement(
            visible=true, transformation(
            origin={-157,-141},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.PD HP_Cooling(enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-170,-134}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      PNlib.Components.PD GTF_On(enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, reStartTokens = 0, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-176,-30},    extent = {{-6, -6}, {6, 6}}, rotation = 180)));
      PNlib.Components.TD T114(
        nIn=1,
        nOut=1,
        delay=180,
        firingCon=Superior_Mode[3] or HP_Heating.t > 0.5 or HP_Combi.t > 0.5)
                                  annotation (Placement(visible=true,
            transformation(
            origin={-170,-12},
            extent={{-8,-8},{8,8}},
            rotation=-90)));
      PNlib.Components.TD T115(
        nIn=1,
        nOut=1,
        delay=180,
        firingCon=Superior_Mode[1])                       annotation (Placement(
            visible=true, transformation(
            origin={-183,-13},
            extent={{-7,-7},{7,7}},
            rotation=90)));
      PNlib.Components.PD GTF_Off(enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={-176,2},      extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      PNlib.Components.PD HX_On(nIn = 1, nOut = 1) annotation (
        Placement(visible = true, transformation(origin={-178,-84},    extent = {{-6, -6}, {6, 6}}, rotation = 180)));
      PNlib.Components.TD T116(
        delay=180,
        firingCon=Superior_Mode[1],               nIn = 1, nOut = 1) annotation (
        Placement(visible = true, transformation(origin={-185,-67},    extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.TD T117(
        delay=180,             firingCon = false, nIn = 1, nOut = 1) annotation (
        Placement(visible = true, transformation(origin={-171,-67},    extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.PD HX_Off(enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, reStartTokens = 0, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={-178,-52},    extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput Superior_Mode[4] annotation (
          Placement(
          visible=true,
          transformation(
            origin={0,110},
            extent={{-10,-10},{10,10}},
            rotation=-90),
          iconTransformation(
            origin={0,110},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Modelica.Blocks.Interfaces.BooleanOutput y[37] annotation (
        Placement(visible = true, transformation(origin={0,-184},    extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin={0,-184},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput TAirOutside
        "Outside Air Temperature"                                                annotation (
        Placement(visible = true, transformation(origin = {160, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {160, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      inner PNlib.Components.Settings settings annotation (
        Placement(visible = true, transformation(extent={{180,78},{200,98}},       rotation = 0)));
      Modelica.Blocks.Math.IntegerToBoolean integerToBoolean1[37] annotation (
        Placement(visible = true, transformation(origin={0,-162},              extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.PD P1(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={20,54},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.PD P11(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={50,54},    extent = {{-8, -8}, {8, 8}}, rotation = 90)));
      PNlib.Components.PD P12(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={80,54},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.TD T118(
        delay=180,
        firingCon=TRoomMea[1] < 289.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={36,36},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T119(
        delay=180,
        firingCon=TRoomMea[1] > 290.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={36,72},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T120(
        delay=180,
        firingCon=TRoomMea[1] > 287.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={64,36},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T121(
        delay=180,
        firingCon=TRoomMea[1] < 286.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={64,72},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T122(
        delay=180,
        firingCon=TRoomMea[4] > 292.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={168,-30},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T123(
        delay=180,
        firingCon=TRoomMea[4] < 294.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={140,-30},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T124(
        delay=180,
        firingCon=TRoomMea[4] < 291.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={168,6},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T125(
        delay=180,
        firingCon=TRoomMea[4] > 295.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={140,6},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.PD P13(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={184,-12},   extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.PD P14(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={154,-12},   extent = {{-8, -8}, {8, 8}}, rotation = 90)));
      PNlib.Components.PD P15(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={124,-12},   extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.TD T126(
        delay=180,
        firingCon=TRoomMea[2] > 292.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={158,36},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T127(
        delay=180,
        firingCon=TRoomMea[2] < 294.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={130,36},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.PD P16(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={174,54},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.PD P17(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={144,54},    extent = {{-8, -8}, {8, 8}}, rotation = 90)));
      PNlib.Components.TD T128(
        delay=180,
        firingCon=TRoomMea[2] < 291.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={158,72},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T129(
        delay=180,
        firingCon=TRoomMea[2] > 295.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={130,72},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.PD P18(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={114,54},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.PD P19(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={124,-80},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.PD P110(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={154,-80},    extent = {{-8, -8}, {8, 8}}, rotation = 90)));
      PNlib.Components.PD P111(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={184,-80},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.TD T130(
        delay=180,
        firingCon=TRoomMea[5] < 294.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={140,-98},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T131(
        delay=180,
        firingCon=TRoomMea[5] > 292.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={168,-98},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T132(
        delay=180,
        firingCon=TRoomMea[5] > 295.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={140,-62},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T133(
        delay=180,                        nIn = 1, nOut = 1,
        firingCon=TRoomMea[5] < 291.15)                      annotation (
        Placement(visible = true, transformation(origin={168,-62},  extent = {{-8, -8}, {8, 8}}, rotation = 0)));
      PNlib.Components.PD P115(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={62,-10},    extent = {{-8, -8}, {8, 8}}, rotation = 90)));
      PNlib.Components.PD P116(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={92,-10},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.TD T138(
        delay=180,
        firingCon=TRoomMea[3] < 294.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={48,-28},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T139(
        delay=180,
        firingCon=TRoomMea[3] > 292.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={76,-28},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T140(
        delay=180,
        firingCon=TRoomMea[3] > 295.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={48,8},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T141(
        delay=180,
        firingCon=TRoomMea[3] < 291.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={76,8},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.PD P117(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={32,-10},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
      PNlib.Components.PD HP_Combi(enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0,
        nIn=3,
        nOut=3,                                                                                                                       startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-142,-168}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      PNlib.Components.TD T146(
        delay=180,
        firingCon=Superior_Mode[2] and TAirOutside > 283.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-91,-141},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.TD T147(
        delay=180,
        firingCon=Superior_Mode[4] or (Superior_Mode[2] and TAirOutside <=
            283.15),
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-91,-127},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.TD T112(
        delay=180,
        firingCon=Superior_Mode[3],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-157,-127},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.PD SU_Cooling_GTF(maxTokens = 1, minTokens = 0, nIn = 3, nOut = 3, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-96,62},      extent = {{-6, -6}, {6, 6}}, rotation = 90)));
      PNlib.Components.TD T150(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-79,69},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.TD T151(
        delay=180,
        firingCon=Superior_Mode[3] and T_GEO < 285.15,   nIn = 1, nOut = 1) annotation (
        Placement(visible = true, transformation(origin={-79,55},     extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.TD T152(
        delay=180,                        nIn = 1, nOut = 1,
        firingCon=Superior_Mode[3] and T_GEO < 285.15)       annotation (
        Placement(visible = true, transformation(origin={-89,49},     extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.TD T153(
        delay=180,                        nIn = 1, nOut = 1,
        firingCon=(Superior_Mode[3] and T_GEO >= 290.15) or Superior_Mode[4])
                                                             annotation (
        Placement(visible = true, transformation(origin={-103,49},     extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.TD T154(nIn = 1, nOut = 1,
        delay=180,
        firingCon=Superior_Mode[4] or (Superior_Mode[3] and T_GEO >= 290.15))
                                                  annotation (
        Placement(visible = true, transformation(origin={-89,21},     extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.TD T155(
        delay=180,
        firingCon=(Superior_Mode[3] and T_GEO >= 290.15) or Superior_Mode[4],
                                                         nIn = 1, nOut = 1) annotation (
        Placement(visible = true, transformation(origin={-79,27},     extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.TD T156(
        delay=180,                        nIn = 1, nOut = 1,
        firingCon=Superior_Mode[3] and T_GEO >= 285.15 and T_GEO < 290.15)
                                                             annotation (
        Placement(visible = true, transformation(origin={-103,21},     extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.TD T157(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-79,41},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.PD SU_Cooling_HP(maxTokens = 1, minTokens = 0,
        nIn=5,
        nOut=5,                                                                          startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-96,34},      extent = {{-6, -6}, {6, 6}}, rotation = 90)));
      PNlib.Components.TD T158(
        delay=180,
        firingCon=Superior_Mode[3] and T_GEO < 290.15 and T_GEO >= 285.15,
                                                         nIn = 1, nOut = 1) annotation (
        Placement(visible = true, transformation(origin={-79,-1},     extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.TD T159(nIn = 1, nOut = 1,
        delay=180,
        firingCon=Superior_Mode[3] and T_GEO < 285.15)
                                                  annotation (
        Placement(visible = true, transformation(origin={-113,13},     extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      PNlib.Components.PD SU_Cooling_GTFandHP(maxTokens = 1, minTokens = 0, nIn = 3, nOut = 3, startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-96,6},       extent = {{-6, -6}, {6, 6}}, rotation = 90)));
      PNlib.Components.TD T160(nIn = 1, nOut = 1,
        delay=180,
        firingCon=Superior_Mode[3] and T_GEO < 290.15 and T_GEO >= 285.15)
                                                  annotation (
        Placement(visible = true, transformation(origin={-113,-1},     extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.TD T161(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-79,13},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.PD SU_Off(maxTokens = 1, minTokens = 0, nIn = 5, nOut = 5, reStartTokens = 1, startTokens = 1) annotation (
        Placement(visible = true, transformation(origin={-64,32},     extent = {{-6, -6}, {6, 6}}, rotation = 0)));
      PNlib.Components.TD T162(nIn = 1, nOut = 1,
        delay=180,
        firingCon=Superior_Mode[2] and T_CS > 285.15)
                                                  annotation (
        Placement(visible = true, transformation(origin={-27,35},     extent = {{-7, -7}, {7, 7}}, rotation = 90)));
      PNlib.Components.PD SU_Heating_GTF(maxTokens = 1, minTokens = 0,
        nIn=3,
        nOut=3,                                                                           startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-34,48},     extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      PNlib.Components.TD T164(nIn = 1, nOut = 1,
        delay=180,
        firingCon=Superior_Mode[2] and T_CS <= 285.15)
                                                  annotation (
        Placement(visible = true, transformation(origin={-41,35},     extent = {{-7, -7}, {7, 7}}, rotation = -90)));
      PNlib.Components.TD T166(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-51,13},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.TD T167(
        delay=180,
        firingCon=Superior_Mode[2] and T_CS <= 285.15,   nIn = 1, nOut = 1) annotation (
        Placement(visible = true, transformation(origin={-51,27},     extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.TD T168(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-51,41},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.TD T169(                          nIn = 1, nOut = 1,
        delay=180,
        firingCon=Superior_Mode[2] and T_CS > 285.15)                       annotation (
        Placement(visible = true, transformation(origin={-51,55},     extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      PNlib.Components.PD SU_Heating_GTFandCON(maxTokens = 1, minTokens = 0,
        nIn=3,
        nOut=3,                                                                                 startTokens = 0) annotation (
        Placement(visible = true, transformation(origin={-34,20},     extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={120,110})));
      Modelica.Blocks.Interfaces.RealInput T_CS annotation (Placement(
            transformation(
            extent={{-11,-11},{11,11}},
            rotation=270,
            origin={41,111})));
      Modelica.Blocks.Interfaces.RealInput T_GEO annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,110})));
      PNlib.Components.TD T2(
        delay=180,
        firingCon=(Superior_Mode[3] and T_GEO >= 290.15) or Superior_Mode[4],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-17,43},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.TD T3(
        delay=180,
        firingCon=Superior_Mode[2] and T_CS > 285.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-17,57},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.TD T4(
        delay=180,
        firingCon=Superior_Mode[2] and T_CS <= 285.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-17,29},
            extent={{-7,-7},{7,7}},
            rotation=180)));
      PNlib.Components.TD T5(
        delay=180,
        firingCon=(Superior_Mode[3] and T_GEO >= 290.15) or Superior_Mode[4],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-17,15},
            extent={{-7,-7},{7,7}},
            rotation=0)));
      PNlib.Components.PD CentralAHU_Off(
        maxTokens=1,
        minTokens=0,
        nIn=4,
        nOut=4,
        startTokens=1) annotation (Placement(visible=true, transformation(
            origin={-72,-68},
            extent={{-8,-8},{8,8}},
            rotation=90)));
      PNlib.Components.TD T25(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-90,-56},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.PD CentralAHU_Cooling(
        maxTokens=1,
        minTokens=0,
        nIn=2,
        nOut=2,
        startTokens=0) annotation (Placement(visible=true, transformation(
            origin={-110,-48},
            extent={{-8,-8},{8,8}},
            rotation=-90)));
      PNlib.Components.TD T26(
        delay=180,
        firingCon=Superior_Mode[3],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-90,-40},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.PD CentralAHU_Combi(
        maxTokens=1,
        minTokens=0,
        nIn=4,
        nOut=4,
        startTokens=0) annotation (Placement(visible=true, transformation(
            origin={-110,-86},
            extent={{-8,-8},{8,8}},
            rotation=-90)));
      PNlib.Components.TD T35(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-90,-94},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T36(
        delay=180,
        firingCon=Superior_Mode[4],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-90,-78},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T41(
        delay=180,
        firingCon=Superior_Mode[4],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-104,-66},
            extent={{-8,-8},{8,8}},
            rotation=270)));
      PNlib.Components.TD T42(
        delay=180,
        firingCon=Superior_Mode[3],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-122,-66},
            extent={{-8,-8},{8,8}},
            rotation=90)));
      PNlib.Components.TD T6(
        delay=180,
        firingCon=Superior_Mode[2] and TAirOutside < 283.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-52,-78},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T7(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-52,-94},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.PD CentraAHU_Heating(
        maxTokens=1,
        minTokens=0,
        nIn=3,
        nOut=3,
        startTokens=0) annotation (Placement(visible=true, transformation(
            origin={-32,-48},
            extent={{-8,-8},{8,8}},
            rotation=-90)));
      PNlib.Components.PD CentralAHU_Heating_Preheating(
        maxTokens=1,
        minTokens=0,
        nIn=3,
        nOut=3,
        startTokens=0) annotation (Placement(visible=true, transformation(
            origin={-32,-84},
            extent={{-8,-8},{8,8}},
            rotation=-90)));
      PNlib.Components.TD T8(
        delay=180,
        firingCon=Superior_Mode[2] and TAirOutside < 283.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-24,-66},
            extent={{-8,-8},{8,8}},
            rotation=270)));
      PNlib.Components.TD T9(
        delay=180,
        firingCon=Superior_Mode[2] and TAirOutside >= 283.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-40,-66},
            extent={{-8,-8},{8,8}},
            rotation=90)));
      PNlib.Components.TD T23(
        delay=180,
        firingCon=Superior_Mode[4],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-12,-94},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T24(
        delay=180,
        firingCon=Superior_Mode[2] and TAirOutside < 283.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-12,-78},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T27(
        delay=180,
        firingCon=Superior_Mode[2] and TAirOutside >= 283.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-52,-40},
            extent={{-8,-8},{8,8}},
            rotation=0)));
      PNlib.Components.TD T28(
        delay=180,
        firingCon=Superior_Mode[1],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-52,-56},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T29(
        delay=180,
        firingCon=Superior_Mode[2] and TAirOutside >= 283.15,
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-12,-40},
            extent={{-8,-8},{8,8}},
            rotation=180)));
      PNlib.Components.TD T30(
        delay=180,
        firingCon=Superior_Mode[4],
        nIn=1,
        nOut=1) annotation (Placement(visible=true, transformation(
            origin={-12,-56},
            extent={{-8,-8},{8,8}},
            rotation=0)));
    equation
      connect(T156.outPlaces[1], SU_Cooling_GTFandHP.inTransition[2]) annotation (
        Line(points={{-103,17.64},{-104,17.64},{-104,0},{-96,0},{-96,-0.48}},            thickness = 0.5));
      connect(T153.outPlaces[1], SU_Cooling_HP.inTransition[2]) annotation (
        Line(points={{-103,45.64},{-104,45.64},{-104,28},{-95.76,28},{-95.76,27.52}},    thickness = 0.5));
      connect(T154.outPlaces[1], SU_Cooling_HP.inTransition[3]) annotation (
        Line(points={{-89,24.36},{-90,24.36},{-90,28},{-96,28},{-96,27.52}},            thickness = 0.5));
      connect(SU_Cooling_HP.inTransition[1], T155.outPlaces[1]) annotation (
        Line(points={{-95.52,27.52},{-82,27.52},{-82,27},{-82.36,27}},   thickness = 0.5));
      connect(SU_Cooling_HP.outTransition[3], T156.inPlaces[1]) annotation (
        Line(points={{-96,40.48},{-104,40.48},{-104,24},{-103,24},{-103,24.36}},         thickness = 0.5));
      connect(SU_Cooling_HP.outTransition[2], T152.inPlaces[1]) annotation (
        Line(points={{-95.76,40.48},{-88,40.48},{-88,45.64},{-89,45.64}},            thickness = 0.5));
      connect(SU_Cooling_HP.outTransition[1], T157.inPlaces[1]) annotation (
        Line(points={{-95.52,40.48},{-82,40.48},{-82,41},{-82.36,41}},   thickness = 0.5));
      connect(SU_Cooling_GTFandHP.inTransition[1], T158.outPlaces[1]) annotation (
        Line(points={{-95.6,-0.48},{-82,-0.48},{-82,-1},{-82.36,-1}},    thickness = 0.5));
      connect(T160.outPlaces[1], SU_Cooling_GTFandHP.inTransition[3]) annotation (
        Line(points={{-109.64,-1},{-96,-1},{-96,-0.48},{-96.4,-0.48}},      thickness = 0.5));
      connect(SU_Cooling_GTFandHP.outTransition[2], T154.inPlaces[1]) annotation (
        Line(points={{-96,12.48},{-88,12.48},{-88,17.64},{-89,17.64}},               thickness = 0.5));
      connect(SU_Cooling_GTFandHP.outTransition[3], T159.inPlaces[1]) annotation (
        Line(points={{-96.4,12.48},{-110,12.48},{-110,13},{-109.64,13}},    thickness = 0.5));
      connect(SU_Cooling_GTFandHP.outTransition[1], T161.inPlaces[1]) annotation (
        Line(points={{-95.6,12.48},{-82,12.48},{-82,13},{-82.36,13}},    thickness = 0.5));
      connect(T159.outPlaces[1], SU_Cooling_GTF.inTransition[3]) annotation (
        Line(points={{-116.36,13},{-122,13},{-122,56},{-96,56},{-96,55.52},{-96.4,55.52}},            thickness = 0.5));
      connect(T152.outPlaces[1], SU_Cooling_GTF.inTransition[2]) annotation (
        Line(points={{-89,52.36},{-90,52.36},{-90,56},{-96,56},{-96,55.52}},            thickness = 0.5));
      connect(SU_Cooling_GTF.inTransition[1], T151.outPlaces[1]) annotation (
        Line(points={{-95.6,55.52},{-82,55.52},{-82,55},{-82.36,55}},    thickness = 0.5));
      connect(SU_Cooling_GTF.outTransition[3], T160.inPlaces[1]) annotation (
        Line(points={{-96.4,68.48},{-122,68.48},{-122,-2},{-116,-2},{-116,-1},{-116.36,
              -1}},                                                                                   thickness = 0.5));
      connect(SU_Cooling_GTF.outTransition[2], T153.inPlaces[1]) annotation (
        Line(points={{-96,68.48},{-104,68.48},{-104,52},{-103,52},{-103,52.36}},         thickness = 0.5));
      connect(SU_Cooling_GTF.outTransition[1], T150.inPlaces[1]) annotation (
        Line(points={{-95.6,68.48},{-82,68.48},{-82,69},{-82.36,69}},    thickness = 0.5));
      connect(T161.outPlaces[1], SU_Off.inTransition[5]) annotation (
        Line(points={{-75.64,13},{-72,13},{-72,32},{-70,32},{-70,32.48},{-70.48,32.48}},        thickness = 0.5));
      connect(T157.outPlaces[1], SU_Off.inTransition[4]) annotation (
        Line(points={{-75.64,41},{-72,41},{-72,32},{-70,32},{-70,32.24},{-70.48,32.24}},        thickness = 0.5));
      connect(T150.outPlaces[1], SU_Off.inTransition[3]) annotation (
        Line(points={{-75.64,69},{-72,69},{-72,32},{-70.48,32}},                                thickness = 0.5));
      connect(T166.outPlaces[1], SU_Off.inTransition[2]) annotation (
        Line(points={{-54.36,13},{-72,13},{-72,32},{-70,32},{-70,31.76},{-70.48,31.76}},        thickness = 0.5));
      connect(T168.outPlaces[1], SU_Off.inTransition[1]) annotation (
        Line(points={{-54.36,41},{-72,41},{-72,32},{-70,32},{-70,31.52},{-70.48,31.52}},        thickness = 0.5));
      connect(SU_Off.outTransition[5], T158.inPlaces[1]) annotation (
        Line(points={{-57.52,32.48},{-56,32.48},{-56,-2},{-76,-2},{-76,-1},{-75.64,-1}},        thickness = 0.5));
      connect(SU_Off.outTransition[3], T151.inPlaces[1]) annotation (
        Line(points={{-57.52,32},{-56,32},{-56,56},{-76,56},{-76,55},{-75.64,55}},              thickness = 0.5));
      connect(SU_Off.outTransition[4], T155.inPlaces[1]) annotation (
        Line(points={{-57.52,32.24},{-56,32.24},{-56,26},{-76,26},{-76,27},{-75.64,27}},        thickness = 0.5));
      connect(SU_Off.outTransition[1], T169.inPlaces[1]) annotation (
        Line(points={{-57.52,31.52},{-56,31.52},{-56,56},{-54,56},{-54,55},{-54.36,55}},        thickness = 0.5));
      connect(SU_Off.outTransition[2], T167.inPlaces[1]) annotation (
        Line(points={{-57.52,31.76},{-56,31.76},{-56,26},{-54,26},{-54,27},{-54.36,27}},        thickness = 0.5));
      connect(SU_Heating_GTFandCON.outTransition[2], T162.inPlaces[1]) annotation (
        Line(points={{-34,13.52},{-28,13.52},{-28,31.64},{-27,31.64}},  thickness = 0.5));
      connect(T166.inPlaces[1], SU_Heating_GTFandCON.outTransition[1]) annotation (
        Line(points={{-47.64,13},{-44,13},{-44,12},{-40.3,12},{-40.3,13.52},{-34.4,13.52}},
                                                thickness = 0.5));
      connect(T164.outPlaces[1], SU_Heating_GTFandCON.inTransition[2]) annotation (
        Line(points={{-41,31.64},{-42,31.64},{-42,28},{-34,28},{-34,26.48}},        thickness = 0.5));
      connect(T167.outPlaces[1], SU_Heating_GTFandCON.inTransition[1]) annotation (
        Line(points={{-47.64,27},{-34.4,27},{-34.4,26.48}}, thickness = 0.5));
      connect(SU_Heating_GTF.outTransition[2], T164.inPlaces[1]) annotation (
        Line(points={{-34,41.52},{-42,41.52},{-42,38},{-41,38},{-41,38.36}},        thickness = 0.5));
      connect(SU_Heating_GTF.outTransition[1], T168.inPlaces[1]) annotation (
        Line(points={{-34.4,41.52},{-48,41.52},{-48,41},{-47.64,41}},   thickness = 0.5));
      connect(T162.outPlaces[1], SU_Heating_GTF.inTransition[2]) annotation (
        Line(points={{-27,38.36},{-27,56},{-34,56},{-34,54.48}},                                thickness = 0.5));
      connect(T169.outPlaces[1], SU_Heating_GTF.inTransition[1]) annotation (
        Line(points={{-47.64,55},{-34,55},{-34,54.48},{-34.4,54.48}},   thickness = 0.5));
      connect(T16.outPlaces[1], HP_Cooling.inTransition[2]) annotation (
        Line(points={{-179.64,-127},{-172,-127},{-172,-127.52},{-169.7,-127.52}},
                                                                     thickness = 0.5));
      connect(HP_Cooling.outTransition[2], T17.inPlaces[1]) annotation (
        Line(points={{-169.7,-140.48},{-179.64,-140.48},{-179.64,-141}},                          thickness = 0.5));
      connect(HX_Off.outTransition[1], T117.inPlaces[1]) annotation (
        Line(points={{-171.52,-52},{-170,-52},{-170,-64},{-168,-64},{-168,-66},{-172,
              -66},{-172,-63.64},{-171,-63.64}},                                                               thickness = 0.5));
      connect(T116.outPlaces[1], HX_Off.inTransition[1]) annotation (
        Line(points={{-185,-63.64},{-185,-52},{-184.48,-52}},                                                                                          thickness = 0.5));
      connect(T117.outPlaces[1], HX_On.inTransition[1]) annotation (
        Line(points={{-171,-70.36},{-171,-84},{-171.52,-84}},                                                                                                   thickness = 0.5));
      connect(HX_On.outTransition[1], T116.inPlaces[1]) annotation (
        Line(points={{-184.48,-84},{-184.48,-70},{-184,-70},{-184,-70.36},{-185,-70.36}},                                           thickness = 0.5));
      connect(GTF_Off.outTransition[1], T114.inPlaces[1]) annotation (
        Line(points={{-169.52,2},{-170,2},{-170,-30},{-169.5,-30},{-169.5,-8.16},{-170,
              -8.16}},                                                                                       thickness = 0.5));
      connect(T115.outPlaces[1], GTF_Off.inTransition[1]) annotation (
        Line(points={{-183,-9.64},{-183,2.36},{-182.74,2.36},{-182.74,2},{-182.48,2}},                           thickness = 0.5));
      connect(GTF_On.outTransition[1], T115.inPlaces[1]) annotation (
        Line(points={{-182.48,-30},{-183.48,-30},{-183.48,-32},{-182.48,-32},{-182.48,
              -18},{-188,-18},{-188,-16.36},{-183,-16.36}},                                                                                                         thickness = 0.5));
      connect(GTF_On.inTransition[1], T114.outPlaces[1]) annotation (
        Line(points={{-169.52,-30},{-170,-30},{-170,-15.84}},                                                                                                       thickness = 0.5));
      connect(T112.outPlaces[1], HP_Cooling.inTransition[1]) annotation (
        Line(points={{-160.36,-127},{-172.36,-127},{-172.36,-127.52},{-170.3,-127.52}},           thickness = 0.5));
      connect(HP_Off.outTransition[3], T112.inPlaces[1]) annotation (
        Line(points={{-133.52,-133.6},{-132.52,-133.6},{-132.52,-134},{-131.52,-134},
              {-131.52,-124},{-149.52,-124},{-149.52,-126},{-153.52,-126},{-153.52,-127},
              {-153.64,-127}},                                                                                                                                                                                thickness = 0.5));
      connect(HP_Combi.outTransition[1], T18.inPlaces[1]) annotation (
        Line(points={{-142.4,-174.48},{-150,-174.48},{-150,-166.48},{-149,-166.48},{
              -149,-156.36}},                                                               thickness = 0.5));
      connect(HP_Combi.inTransition[1], T19.outPlaces[1]) annotation (
        Line(points={{-142.4,-161.52},{-134,-161.52},{-134,-156.36},{-135,-156.36}},                                      thickness = 0.5));
      connect(HP_Cooling.outTransition[1], T113.inPlaces[1]) annotation (
        Line(points={{-170.3,-140.48},{-160,-140.48},{-160,-141},{-160.36,-141}},                                                       thickness = 0.5));
      connect(T113.outPlaces[1], HP_Off.inTransition[3]) annotation (
        Line(points={{-153.64,-141},{-149.64,-141},{-149.64,-135},{-145.64,-135},{-145.64,
              -133.6},{-146.48,-133.6}},                                                                                                                            thickness = 0.5));
      connect(HP_Heating.outTransition[1], T111.inPlaces[1]) annotation (Line(
            points={{-107.7,-127.52},{-117,-127.52},{-117,-118},{-121.64,-118},{-121.64,
              -127}},
            thickness=0.5));
      connect(T110.outPlaces[1], HP_Heating.inTransition[1]) annotation (Line(
            points={{-121.64,-141},{-114.64,-141},{-114.64,-140},{-108,-140},{-108,-140.48},
              {-107.7,-140.48}},
                             thickness=0.5));
      connect(T15.outPlaces[1], HTS_Heating_I.inTransition[2]) annotation (
        Line(points={{-155,48.36},{-155,53.52},{-148.3,53.52}}));
      connect(HTS_Heating_II.outTransition[2], T15.inPlaces[1]) annotation (
        Line(points={{-147.7,25.52},{-150.3,25.52},{-150.3,26},{-155.3,26},{-155.3,41.64},
              {-155,41.64}}));
      connect(HTS_Heating_I.outTransition[2], T14.inPlaces[1]) annotation (
        Line(points={{-148.3,66.48},{-145.7,66.48},{-145.7,66},{-140.7,66},{-140.7,48.36},
              {-141,48.36}}));
      connect(T14.outPlaces[1], HTS_Heating_II.inTransition[2]) annotation (
        Line(points={{-141,41.64},{-141,38.48},{-147.7,38.48}}));
      connect(HTS_Off.inTransition[2], T13.outPlaces[1]) annotation (
        Line(points={{-188.48,46.3},{-189.24,46.3},{-189.24,46},{-190,46},{-190,23.7},
              {-170.36,23.7},{-170.36,25}}));
      connect(HTS_Heating_II.outTransition[1], T13.inPlaces[1]) annotation (
        Line(points={{-148.3,25.52},{-149.7,25.52},{-149.7,25},{-163.64,25}}));
      connect(HTS_Off.outTransition[2], T12.inPlaces[1]) annotation (
        Line(points={{-175.52,46.3},{-175.14,46.3},{-175.14,46},{-174,46},{-174,38.7},
              {-178.18,38.7},{-178.18,39},{-170.36,39}}));
      connect(T12.outPlaces[1], HTS_Heating_II.inTransition[1]) annotation (
        Line(points={{-163.64,39},{-160,39},{-160,38.48},{-148.3,38.48}}));
      connect(HTS_Off.outTransition[1], T11.inPlaces[1]) annotation (
        Line(points={{-175.52,45.7},{-175.14,45.7},{-175.14,46},{-174.76,46},{-174.76,
              44},{-174,44},{-174,51.3},{-172.18,51.3},{-172.18,53.3},{-171.27,53.3},
              {-171.27,53},{-170.36,53}}));
      connect(T11.outPlaces[1], HTS_Heating_I.inTransition[1]) annotation (
        Line(points={{-163.64,53},{-158,53},{-158,53.52},{-147.7,53.52}}));
      connect(HTS_Off.inTransition[1], T1.outPlaces[1]) annotation (
        Line(points={{-188.48,45.7},{-189.24,45.7},{-189.24,44},{-190,44},{-190,65.3},
              {-181.18,65.3},{-181.18,67.3},{-175.77,67.3},{-175.77,67},{-170.36,67}}));
      connect(T1.inPlaces[1], HTS_Heating_I.outTransition[1]) annotation (
        Line(points={{-163.64,67},{-160,67},{-160,66.48},{-147.7,66.48}}));
      connect(T140.outPlaces[1], P117.inTransition[1]) annotation (
        Line(points={{44.16,8},{32.16,8},{32.16,-1.36},{32,-1.36}},                           thickness = 0.5));
      connect(T138.inPlaces[1], P117.outTransition[1]) annotation (
        Line(points={{44.16,-28},{32.16,-28},{32.16,-18.64},{32,-18.64}},                     thickness = 0.5));
      connect(P115.outTransition[1], T141.inPlaces[1]) annotation (
        Line(points={{62.4,-1.36},{62,-1.36},{62,8.64},{72,8.64},{72,8},{72.16,
              8}},                                                                                                        thickness = 0.5));
      connect(T141.outPlaces[1], P116.inTransition[1]) annotation (
        Line(points={{79.84,8},{93.84,8},{93.84,-1},{92,-1},{92,-1.36}},                                                  thickness = 0.5));
      connect(P115.outTransition[2], T140.inPlaces[1]) annotation (
        Line(points={{61.6,-1.36},{62,-1.36},{62,8.64},{52,8.64},{52,8},{51.84,
              8}},                                                                                                        thickness = 0.5));
      connect(T139.outPlaces[1], P115.inTransition[1]) annotation (
        Line(points={{72.16,-28},{62.16,-28},{62.16,-18.64},{62.4,-18.64}},                                               thickness = 0.5));
      connect(T139.inPlaces[1], P116.outTransition[1]) annotation (
        Line(points={{79.84,-28},{93.84,-28},{93.84,-18},{92,-18},{92,-18.64}},                                           thickness = 0.5));
      connect(T138.outPlaces[1], P115.inTransition[2]) annotation (
        Line(points={{51.84,-28},{63.84,-28},{63.84,-18},{61.6,-18},{61.6,
              -18.64}},                                                                                                   thickness = 0.5));
      connect(P110.outTransition[1], T133.inPlaces[1]) annotation (
        Line(points={{154.4,-71.36},{154,-71.36},{154,-61.36},{164,-61.36},{164,-62},
              {164.16,-62}},                                                                                         thickness = 0.5));
      connect(T133.outPlaces[1], P111.inTransition[1]) annotation (
        Line(points={{171.84,-62},{185.84,-62},{185.84,-71},{184,-71},{184,-71.36}},                                  thickness = 0.5));
      connect(P19.inTransition[1], T132.outPlaces[1]) annotation (
        Line(points={{124,-71.36},{124,-61.36},{136,-61.36},{136,-62},{136.16,-62}},                                 thickness = 0.5));
      connect(T132.inPlaces[1], P110.outTransition[2]) annotation (
        Line(points={{143.84,-62},{155.84,-62},{155.84,-72},{153.6,-72},{153.6,-71.36}},                                thickness = 0.5));
      connect(T131.inPlaces[1], P111.outTransition[1]) annotation (
        Line(points={{171.84,-98},{185.84,-98},{185.84,-88},{184,-88},{184,-88.64}},                                             thickness = 0.5));
      connect(T131.outPlaces[1], P110.inTransition[1]) annotation (
        Line(points={{164.16,-98},{154.16,-98},{154.16,-88.64},{154.4,-88.64}},                                                  thickness = 0.5));
      connect(P19.outTransition[1], T130.inPlaces[1]) annotation (
        Line(points={{124,-88.64},{124,-98.64},{136,-98.64},{136,-98},{136.16,-98}},                                             thickness = 0.5));
      connect(T130.outPlaces[1], P110.inTransition[2]) annotation (
        Line(points={{143.84,-98},{155.84,-98},{155.84,-88},{153.6,-88},{153.6,-88.64}},                                         thickness = 0.5));
      connect(P18.outTransition[1], T127.inPlaces[1]) annotation (
        Line(points={{114,45.36},{114,35.36},{126,35.36},{126,36},{126.16,36}},                                           thickness = 0.5));
      connect(P18.inTransition[1], T129.outPlaces[1]) annotation (
        Line(points={{114,62.64},{114,72.64},{126,72.64},{126,72},{126.16,72}},                   thickness = 0.5));
      connect(T129.inPlaces[1], P17.outTransition[2]) annotation (
        Line(points={{133.84,72},{145.84,72},{145.84,62},{143.6,62},{143.6,62.64}},                              thickness = 0.5));
      connect(P17.outTransition[1], T128.inPlaces[1]) annotation (
        Line(points={{144.4,62.64},{144,62.64},{144,72.64},{154.16,72.64},{154.16,72}},
                                                                                      thickness = 0.5));
      connect(T128.outPlaces[1], P16.inTransition[1]) annotation (
        Line(points={{161.84,72},{175.84,72},{175.84,62},{174,62},{174,62.64}},                                  thickness = 0.5));
      connect(T126.outPlaces[1], P17.inTransition[1]) annotation (
        Line(points={{154.16,36},{144.16,36},{144.16,45.36},{144.4,45.36}},                   thickness = 0.5));
      connect(T127.outPlaces[1], P17.inTransition[2]) annotation (
        Line(points={{133.84,36},{145.84,36},{145.84,46},{143.6,46},{143.6,45.36}},                                       thickness = 0.5));
      connect(P16.outTransition[1], T126.inPlaces[1]) annotation (
        Line(points={{174,45.36},{174,35.36},{162,35.36},{162,36},{161.84,36}},                                           thickness = 0.5));
      connect(P15.inTransition[1], T125.outPlaces[1]) annotation (
        Line(points={{124,-3.36},{124,6.64},{136,6.64},{136,6},{136.16,6}},                                               thickness = 0.5));
      connect(T123.inPlaces[1], P15.outTransition[1]) annotation (
        Line(points={{136.16,-30},{124.16,-30},{124.16,-20.64},{124,-20.64}},                                             thickness = 0.5));
      connect(P14.outTransition[2], T125.inPlaces[1]) annotation (
        Line(points={{153.6,-3.36},{154,-3.36},{154,6.64},{144,6.64},{144,6},{
              143.84,6}},                                                                                                 thickness = 0.5));
      connect(P14.outTransition[1], T124.inPlaces[1]) annotation (
        Line(points={{154.4,-3.36},{154,-3.36},{154,6.64},{164.16,6.64},{164.16,
              6}},                                                                            thickness = 0.5));
      connect(T123.outPlaces[1], P14.inTransition[2]) annotation (
        Line(points={{143.84,-30},{155.84,-30},{155.84,-20},{153.6,-20},{153.6,
              -20.64}},                                                                                                   thickness = 0.5));
      connect(T122.outPlaces[1], P14.inTransition[1]) annotation (
        Line(points={{164.16,-30},{154.16,-30},{154.16,-20.64},{154.4,-20.64}},                                           thickness = 0.5));
      connect(T124.outPlaces[1], P13.inTransition[1]) annotation (
        Line(points={{171.84,6},{185.84,6},{185.84,-4},{184,-4},{184,-3.36}},                                             thickness = 0.5));
      connect(T122.inPlaces[1], P13.outTransition[1]) annotation (
        Line(points={{171.84,-30},{185.84,-30},{185.84,-21},{184,-21},{184,
              -20.64}},                                                                                                   thickness = 0.5));
      connect(P11.outTransition[1], T121.inPlaces[1]) annotation (
        Line(points={{50.4,62.64},{50,62.64},{50,72.64},{60,72.64},{60,72},{60.16,72}},               thickness = 0.5));
      connect(T121.outPlaces[1], P12.inTransition[1]) annotation (
        Line(points={{67.84,72},{81.84,72},{81.84,63},{80,63},{80,62.64}},                                         thickness = 0.5));
      connect(T120.inPlaces[1], P12.outTransition[1]) annotation (
        Line(points={{67.84,36},{81.84,36},{81.84,46},{80,46},{80,45.36}},                                         thickness = 0.5));
      connect(P11.inTransition[1], T120.outPlaces[1]) annotation (
        Line(points={{50.4,45.36},{50,45.36},{50,35.36},{60,35.36},{60,36},{60.16,36}},                            thickness = 0.5));
      connect(P1.inTransition[1], T119.outPlaces[1]) annotation (
        Line(points={{20,62.64},{20,72.64},{32,72.64},{32,72},{32.16,72}},                            thickness = 0.5));
      connect(P11.outTransition[2], T119.inPlaces[1]) annotation (
        Line(points={{49.6,62.64},{50,62.64},{50,72.64},{40,72.64},{40,72},{39.84,72}},                            thickness = 0.5));
      connect(P1.outTransition[1], T118.inPlaces[1]) annotation (
        Line(points={{20,45.36},{20,35.36},{32,35.36},{32,36},{32.16,36}},                                         thickness = 0.5));
      connect(T118.outPlaces[1], P11.inTransition[2]) annotation (
        Line(points={{39.84,36},{51.84,36},{51.84,45},{49.6,45},{49.6,45.36}},                                     thickness = 0.5));
      connect(integerToBoolean1[1].y, y[1]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-174},{0,-174},{0,
              -174.27}},                                          color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[2].y, y[2]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-174},{0,-174},{0,
              -174.811}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[3].y, y[3]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-176},{0,-176},{0,
              -175.351}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[4].y, y[4]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-176},{0,-176},{0,
              -175.892}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[5].y, y[5]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-176},{0,-176},{0,
              -176.432}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[6].y, y[6]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-176},{0,-176},{0,
              -176.973}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[7].y, y[7]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-176},{0,-176},{0,
              -177.514}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[8].y, y[8]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-176},{0,-176},{0,
              -178.054}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[9].y, y[9]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-176},{0,-176},{0,
              -178.595}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[10].y, y[10]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-176},{0,-176},{0,
              -179.135}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[11].y, y[11]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-178},{0,-178},{0,
              -179.676}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[12].y, y[12]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-178},{0,-178},{0,
              -180.216}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[13].y, y[13]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-178},{0,-178},{0,
              -180.757}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[14].y, y[14]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-178},{0,-178},{0,
              -181.297}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[15].y, y[15]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-178},{0,-178},{0,
              -181.838}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[16].y, y[16]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-178},{0,-178},{0,
              -182.378}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[17].y, y[17]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-178},{0,-178},{0,
              -182.919}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[18].y, y[18]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-180},{0,-180},{0,
              -183.459}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[19].y, y[19]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-180},{0,-180},{0,-184}},
                                                                  color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[20].y, y[20]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-180},{0,-180},{0,
              -184.541}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[21].y, y[21]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-180},{0,-180},{0,
              -185.081}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[22].y, y[22]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-180},{0,-180},{0,
              -185.622}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[23].y, y[23]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-180},{0,-180},{0,
              -186.162}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[24].y, y[24]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-180},{0,-180},{0,
              -186.703}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[25].y, y[25]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-180},{0,-180},{0,
              -187.243}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[26].y, y[26]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-182},{0,-182},{0,
              -187.784}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[27].y, y[27]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-182},{0,-182},{0,
              -188.324}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[28].y, y[28]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-182},{0,-182},{0,
              -188.865}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[29].y, y[29]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-182},{0,-182},{0,
              -189.405}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[30].y, y[30]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-182},{0,-182},{0,
              -189.946}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[31].y, y[31]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-182},{0,-182},{0,
              -190.486}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[32].y, y[32]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-182},{0,-182},{0,
              -191.027}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[33].y, y[33]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-182},{0,-182},{0,
              -191.568}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[34].y, y[34]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-184},{0,-184},{0,
              -192.108}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[35].y, y[35]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-184},{0,-184},{0,
              -192.649}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[36].y, y[36]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-184},{0,-184},{0,
              -193.189}},                                         color = {255, 0, 255}, thickness = 0.5));
      connect(integerToBoolean1[37].y, y[37]) annotation (
        Line(points={{-1.55431e-15,-170.8},{-1.55431e-15,-184},{0,-184},{0,
              -193.73}},                                          color = {255, 0, 255}, thickness = 0.5));






      connect(HP_Combi.outTransition[3], T16.inPlaces[1]) annotation (Line(
            points={{-141.6,-174.48},{-144,-174.48},{-144,-176},{-196,-176},{-196,-126},
              {-186.36,-126},{-186.36,-127}},
                                         color={0,0,0}));
      connect(T17.outPlaces[1], HP_Combi.inTransition[3]) annotation (Line(
            points={{-186.36,-141},{-196,-141},{-196,-161.52},{-141.6,-161.52}},
                                                                        color={
              0,0,0}));
      connect(HP_Off.outTransition[2], T19.inPlaces[1]) annotation (Line(points={{-133.52,
              -134},{-135,-134},{-135,-149.64}}, color={0,0,0}));
      connect(T18.outPlaces[1], HP_Off.inTransition[2]) annotation (Line(points={{-149,
              -149.64},{-149,-134},{-146.48,-134}},
                                                 color={0,0,0}));
      connect(HP_Heating.outTransition[2], T147.inPlaces[1]) annotation (Line(
            points={{-108.3,-127.52},{-108,-127.52},{-108,-127},{-94.36,-127}},
                                                                     color={0,0,
              0}));
      connect(HP_Heating.inTransition[2], T146.outPlaces[1]) annotation (Line(
            points={{-108.3,-140.48},{-106,-140.48},{-106,-141},{-94.36,-141}},
                                                                     color={0,0,
              0}));
      connect(T110.inPlaces[1], HP_Off.outTransition[1]) annotation (Line(
            points={{-128.36,-141},{-133.52,-141},{-133.52,-134.4}},
                                                            color={0,0,0}));
      connect(HP_Off.inTransition[1], T111.outPlaces[1]) annotation (Line(
            points={{-146.48,-134.4},{-146,-134.4},{-146,-127},{-128.36,-127}},
                                                                    color={0,0,
              0}));
      connect(T146.inPlaces[1], HP_Combi.outTransition[2]) annotation (Line(
            points={{-87.64,-141},{-80,-141},{-80,-174},{-112,-174},{-112,-174.48},{
              -142,-174.48}},                                    color={0,0,0}));
      connect(T147.outPlaces[1], HP_Combi.inTransition[2]) annotation (Line(
            points={{-87.64,-127},{-87.64,-128},{-80,-128},{-80,-161.52},{-142,-161.52}},
            color={0,0,0}));
      connect(T3.outPlaces[1], SU_Heating_GTF.inTransition[3]) annotation (Line(
            points={{-20.36,57},{-33.6,57},{-33.6,54.48}},    color={0,0,0}));
      connect(SU_Heating_GTF.outTransition[3], T2.inPlaces[1]) annotation (Line(
            points={{-33.6,41.52},{-32,41.52},{-32,43},{-20.36,43}},     color=
              {0,0,0}));
      connect(SU_Heating_GTFandCON.outTransition[3], T5.inPlaces[1])
        annotation (Line(points={{-33.6,13.52},{-30,13.52},{-30,15},{-20.36,15}},
                     color={0,0,0}));
      connect(T4.outPlaces[1], SU_Heating_GTFandCON.inTransition[3])
        annotation (Line(points={{-20.36,29},{-26,29},{-26,26.48},{-33.6,26.48}},
                        color={0,0,0}));
      connect(SU_Cooling_HP.outTransition[4], T3.inPlaces[1]) annotation (Line(
            points={{-96.24,40.48},{-100,40.48},{-100,40},{-122,40},{-122,80},{-10,80},
              {-10,57},{-13.64,57}},              color={0,0,0}));
      connect(T2.outPlaces[1], SU_Cooling_HP.inTransition[4]) annotation (Line(
            points={{-13.64,43},{-10,43},{-10,80},{-122,80},{-122,28},{-110,28},{-110,
              27.52},{-96.24,27.52}},               color={0,0,0}));
      connect(T5.outPlaces[1], SU_Cooling_HP.inTransition[5]) annotation (Line(
            points={{-13.64,15},{-10,15},{-10,-14},{-122,-14},{-122,27.52},{-96.48,27.52}},
                                 color={0,0,0}));
      connect(T4.inPlaces[1], SU_Cooling_HP.outTransition[5]) annotation (Line(
            points={{-13.64,29},{-10,29},{-10,-14},{-122,-14},{-122,40.48},{-96.48,40.48}},
                                 color={0,0,0}));
      connect(HTS_Off.pd_t, integerToBoolean1[1].u) annotation (Line(points={{-182,52.36},
              {-186,52.36},{-186,54},{-200,54},{-200,-180},{-12,-180},{-12,-140},{1.77636e-15,
              -140},{1.77636e-15,-152.4}}, color={255,127,0}));
      connect(HTS_Heating_I.pd_t, integerToBoolean1[2].u) annotation (Line(points={{
              -154.36,60},{-154,60},{-154,82},{-200,82},{-200,-180},{-12,-180},{-12,
              -140},{0,-140},{0,-152.4}}, color={255,127,0}));
      connect(HTS_Heating_II.pd_t, integerToBoolean1[3].u) annotation (Line(points={
              {-141.64,32},{-138,32},{-138,14},{-200,14},{-200,-180},{-12,-180},{-12,
              -140},{0,-140},{0,-152.4}}, color={255,127,0}));
      connect(HX_Off.pd_t, integerToBoolean1[4].u) annotation (Line(points={{-178,-45.64},
              {-178,-42},{-200,-42},{-200,-180},{-12,-180},{-12,-140},{0,-140},{0,-152.4}},
            color={255,127,0}));
      connect(HX_On.pd_t, integerToBoolean1[5].u) annotation (Line(points={{-178,-90.36},
              {-178,-100},{-200,-100},{-200,-180},{-12,-180},{-12,-140},{0,-140},{0,
              -152.4}},
            color={255,127,0}));
      connect(GTF_Off.pd_t, integerToBoolean1[6].u) annotation (Line(points={{-176,8.36},
              {-176,14},{-200,14},{-200,-180},{-12,-180},{-12,-140},{0,-140},{0,-152.4}},
            color={255,127,0}));
      connect(GTF_On.pd_t, integerToBoolean1[7].u) annotation (Line(points={{-176,-36.36},
              {-176,-42},{-200,-42},{-200,-180},{-12,-180},{-12,-140},{1.77636e-15,-140},
              {1.77636e-15,-152.4}},
            color={255,127,0}));
      connect(P1.pd_t, integerToBoolean1[25].u) annotation (Line(points={{28.48,54},
              {28,54},{28,20},{1.77636e-15,20},{1.77636e-15,-152.4}},
                        color={255,127,0}));
      connect(P11.pd_t, integerToBoolean1[23].u) annotation (Line(points={{41.52,54},
              {42,54},{42,20},{1.77636e-15,20},{1.77636e-15,-152.4}},
            color={255,127,0}));
      connect(P12.pd_t, integerToBoolean1[24].u) annotation (Line(points={{88.48,54},
              {90,54},{90,20},{1.77636e-15,20},{1.77636e-15,-152.4}},
                        color={255,127,0}));
      connect(P17.pd_t, integerToBoolean1[26].u) annotation (Line(points={{135.52,54},
              {134,54},{134,20},{1.77636e-15,20},{1.77636e-15,-152.4}},
            color={255,127,0}));
      connect(P16.pd_t, integerToBoolean1[27].u) annotation (Line(points={{182.48,54},
              {184,54},{184,20},{1.77636e-15,20},{1.77636e-15,-152.4}},       color=
             {255,127,0}));
      connect(P18.pd_t, integerToBoolean1[28].u) annotation (Line(points={{122.48,54},
              {122,54},{122,20},{1.77636e-15,20},{1.77636e-15,-152.4}},
                        color={255,127,0}));
      connect(P115.pd_t, integerToBoolean1[29].u) annotation (Line(points={{53.52,
              -10},{53.52,-46},{0,-46},{0,-152.4},{1.77636e-15,-152.4}},
                                                                     color={255,127,
              0}));
      connect(P116.pd_t, integerToBoolean1[30].u) annotation (Line(points={{100.48,
              -10},{100,-10},{100,-46},{1.77636e-15,-46},{1.77636e-15,-152.4}},
                                                                              color=
             {255,127,0}));
      connect(P117.pd_t, integerToBoolean1[31].u) annotation (Line(points={{40.48,
              -10},{42,-10},{42,-46},{0,-46},{0,-152.4},{1.77636e-15,-152.4}},
                        color={255,127,0}));
      connect(P14.pd_t, integerToBoolean1[32].u) annotation (Line(points={{145.52,
              -12},{145.52,-46},{0,-46},{0,-152.4},{1.77636e-15,-152.4}},
                                                                      color={255,127,
              0}));
      connect(P13.pd_t, integerToBoolean1[33].u) annotation (Line(points={{192.48,
              -12},{192.48,-30},{192,-30},{192,-46},{0,-46},{0,-152.4}},
                                                                      color={255,127,
              0}));
      connect(P15.pd_t, integerToBoolean1[34].u) annotation (Line(points={{132.48,
              -12},{134,-12},{134,-46},{1.77636e-15,-46},{1.77636e-15,-152.4}},
                                                                              color=
             {255,127,0}));
      connect(P110.pd_t, integerToBoolean1[35].u) annotation (Line(points={{145.52,-80},
              {146,-80},{146,-112},{0,-112},{0,-152.4}}, color={255,127,0}));
      connect(P19.pd_t, integerToBoolean1[36].u) annotation (Line(points={{132.48,-80},
              {132,-80},{132,-112},{0,-112},{0,-152.4}}, color={255,127,0}));
      connect(P111.pd_t, integerToBoolean1[37].u) annotation (Line(points={{192.48,-80},
              {192,-80},{192,-112},{1.77636e-15,-112},{1.77636e-15,-152.4}}, color={
              255,127,0}));
      connect(HP_Off.pd_t, integerToBoolean1[8].u) annotation (Line(points={{-140,-127.64},
              {-140,-112},{1.77636e-15,-112},{1.77636e-15,-152.4}},
                                             color={255,127,0}));
      connect(HP_Heating.pd_t, integerToBoolean1[9].u) annotation (Line(points={{-114.36,
              -134},{-116,-134},{-116,-112},{1.77636e-15,-112},{1.77636e-15,-152.4}},
                                                            color={255,127,0}));
      connect(HP_Cooling.pd_t, integerToBoolean1[10].u) annotation (Line(points={{-163.64,
              -134},{-164,-134},{-164,-112},{1.77636e-15,-112},{1.77636e-15,-152.4}},
                                                            color={255,127,0}));
      connect(HP_Combi.pd_t, integerToBoolean1[11].u) annotation (Line(points={{-135.64,
              -168},{-132,-168},{-132,-180},{-12,-180},{-12,-140},{1.77636e-15,-140},
              {1.77636e-15,-152.4}},    color={255,127,0}));
      connect(SU_Off.pd_t, integerToBoolean1[12].u) annotation (Line(points={{-64,38.36},
              {-64,84},{0,84},{0,-152.4}}, color={255,127,0}));
      connect(SU_Heating_GTF.pd_t, integerToBoolean1[13].u) annotation (Line(points=
             {{-27.64,48},{-28,48},{-28,84},{0,84},{0,-152.4},{1.77636e-15,-152.4}},
            color={255,127,0}));
      connect(SU_Heating_GTFandCON.pd_t, integerToBoolean1[14].u) annotation (Line(
            points={{-27.64,20},{-28,20},{-28,-22},{0,-22},{0,-152.4}}, color={255,127,
              0}));
      connect(SU_Cooling_GTF.pd_t, integerToBoolean1[15].u) annotation (Line(points={{-102.36,
              62},{-124,62},{-124,-22},{0,-22},{0,-152.4}},          color={255,127,
              0}));
      connect(SU_Cooling_HP.pd_t, integerToBoolean1[16].u) annotation (Line(points={{-102.36,
              34},{-124,34},{-124,-22},{0,-22},{0,-152.4}},          color={255,127,
              0}));
      connect(SU_Cooling_GTFandHP.pd_t, integerToBoolean1[17].u) annotation (Line(
            points={{-102.36,6},{-124,6},{-124,-22},{1.77636e-15,-22},{1.77636e-15,-152.4}},
                                                                         color={255,
              127,0}));
      connect(T27.outPlaces[1], CentraAHU_Heating.inTransition[1]) annotation (Line(
            points={{-48.16,-40},{-44,-40},{-44,-42},{-38,-42},{-38,-39.36},{
              -32.5333,-39.36}},
                        color={0,0,0}));
      connect(T9.outPlaces[1], CentraAHU_Heating.inTransition[2]) annotation (Line(
            points={{-40,-62.16},{-40,-39.36},{-32,-39.36}}, color={0,0,0}));
      connect(T29.outPlaces[1], CentraAHU_Heating.inTransition[3]) annotation (Line(
            points={{-15.84,-40},{-15.84,-39.36},{-31.4667,-39.36}}, color={0,0,0}));
      connect(CentraAHU_Heating.outTransition[1], T28.inPlaces[1]) annotation (Line(
            points={{-32.5333,-56.64},{-36,-56.64},{-36,-56},{-48.16,-56}}, color={0,
              0,0}));
      connect(CentraAHU_Heating.outTransition[2], T8.inPlaces[1]) annotation (Line(
            points={{-32,-56.64},{-30,-56.64},{-30,-58},{-24,-58},{-24,-62.16}},
            color={0,0,0}));
      connect(T6.outPlaces[1], CentralAHU_Heating_Preheating.inTransition[1])
        annotation (Line(points={{-48.16,-78},{-46,-78},{-46,-75.36},{-32.5333,
              -75.36}},
            color={0,0,0}));
      connect(CentralAHU_Heating_Preheating.inTransition[2], T8.outPlaces[1])
        annotation (Line(points={{-32,-75.36},{-30,-75.36},{-30,-76},{-24,-76},{-24,
              -69.84}}, color={0,0,0}));
      connect(CentralAHU_Heating_Preheating.outTransition[1], T7.inPlaces[1])
        annotation (Line(points={{-32.5333,-92.64},{-32,-92.64},{-32,-94},{
              -48.16,-94}},
            color={0,0,0}));
      connect(CentralAHU_Heating_Preheating.outTransition[2], T9.inPlaces[1])
        annotation (Line(points={{-32,-92.64},{-34,-92.64},{-34,-94},{-40,-94},{-40,
              -69.84}}, color={0,0,0}));
      connect(CentralAHU_Cooling.outTransition[1], T25.inPlaces[1]) annotation (
          Line(points={{-110.4,-56.64},{-106,-56.64},{-106,-56},{-93.84,-56}},
            color={0,0,0}));
      connect(CentralAHU_Cooling.inTransition[1], T26.outPlaces[1]) annotation (
          Line(points={{-110.4,-39.36},{-102,-39.36},{-102,-40},{-93.84,-40}},
            color={0,0,0}));
      connect(CentralAHU_Combi.inTransition[1], T36.outPlaces[1]) annotation (Line(
            points={{-110.6,-77.36},{-108,-77.36},{-108,-78},{-93.84,-78}}, color={0,
              0,0}));
      connect(T41.outPlaces[1], CentralAHU_Combi.inTransition[4]) annotation (Line(
            points={{-104,-69.84},{-104,-77.36},{-109.4,-77.36}}, color={0,0,0}));
      connect(CentralAHU_Combi.outTransition[1], T35.inPlaces[1]) annotation (Line(
            points={{-110.6,-94.64},{-94,-94.64},{-94,-94},{-93.84,-94}}, color={0,0,
              0}));
      connect(CentralAHU_Combi.outTransition[4], T42.inPlaces[1]) annotation (Line(
            points={{-109.4,-94.64},{-116,-94.64},{-116,-94},{-122,-94},{-122,-69.84}},
            color={0,0,0}));
      connect(CentraAHU_Heating.outTransition[3], T30.inPlaces[1]) annotation (Line(
            points={{-31.4667,-56.64},{-34,-56.64},{-34,-56},{-15.84,-56}}, color={0,
              0,0}));
      connect(CentralAHU_Off.outTransition[1], T27.inPlaces[1]) annotation (Line(
            points={{-71.4,-59.36},{-72,-59.36},{-72,-40},{-55.84,-40}}, color={0,0,
              0}));
      connect(CentralAHU_Off.outTransition[2], T6.inPlaces[1]) annotation (Line(
            points={{-71.8,-59.36},{-71.8,-60},{-72,-60},{-72,-56},{-60,-56},{-60,-78},
              {-55.84,-78}}, color={0,0,0}));
      connect(CentralAHU_Off.outTransition[3], T26.inPlaces[1]) annotation (Line(
            points={{-72.2,-59.36},{-72.2,-40},{-86.16,-40}}, color={0,0,0}));
      connect(CentralAHU_Off.outTransition[4], T36.inPlaces[1]) annotation (Line(
            points={{-72.6,-59.36},{-72,-59.36},{-72,-56},{-84,-56},{-84,-78},{-86.16,
              -78}}, color={0,0,0}));
      connect(T28.outPlaces[1], CentralAHU_Off.inTransition[1]) annotation (Line(
            points={{-55.84,-56},{-60,-56},{-60,-94},{-71.4,-94},{-71.4,-76.64}},
            color={0,0,0}));
      connect(T7.outPlaces[1], CentralAHU_Off.inTransition[2]) annotation (Line(
            points={{-55.84,-94},{-71.8,-94},{-71.8,-76.64}}, color={0,0,0}));
      connect(T25.outPlaces[1], CentralAHU_Off.inTransition[3]) annotation (Line(
            points={{-86.16,-56},{-84,-56},{-84,-94},{-72,-94},{-72,-86},{-72.2,-86},
              {-72.2,-76.64}}, color={0,0,0}));
      connect(T35.outPlaces[1], CentralAHU_Off.inTransition[4]) annotation (Line(
            points={{-86.16,-94},{-72.6,-94},{-72.6,-76.64}}, color={0,0,0}));
      connect(CentralAHU_Heating_Preheating.outTransition[3], T23.inPlaces[1])
        annotation (Line(points={{-31.4667,-92.64},{-18,-92.64},{-18,-94},{
              -15.84,-94}},
            color={0,0,0}));
      connect(T24.outPlaces[1], CentralAHU_Heating_Preheating.inTransition[3])
        annotation (Line(points={{-15.84,-78},{-15.84,-75.36},{-31.4667,-75.36}},
            color={0,0,0}));
      connect(CentralAHU_Cooling.outTransition[2], T41.inPlaces[1]) annotation (
          Line(points={{-109.6,-56.64},{-108,-56.64},{-108,-56},{-102,-56},{-102,-62.16},
              {-104,-62.16}}, color={0,0,0}));
      connect(T42.outPlaces[1], CentralAHU_Cooling.inTransition[2]) annotation (
          Line(points={{-122,-62.16},{-122,-40},{-109.6,-40},{-109.6,-39.36}},
            color={0,0,0}));
      connect(T30.outPlaces[1], CentralAHU_Combi.inTransition[2]) annotation (Line(
            points={{-8.16,-56},{-4,-56},{-4,-108},{-122,-108},{-122,-77.36},{-110.2,
              -77.36}}, color={0,0,0}));
      connect(T23.outPlaces[1], CentralAHU_Combi.inTransition[3]) annotation (Line(
            points={{-8.16,-94},{-4,-94},{-4,-108},{-122,-108},{-122,-77.36},{-109.8,
              -77.36}}, color={0,0,0}));
      connect(T24.inPlaces[1], CentralAHU_Combi.outTransition[3]) annotation (Line(
            points={{-8.16,-78},{-4,-78},{-4,-108},{-122,-108},{-122,-94.64},{-109.8,
              -94.64}}, color={0,0,0}));
      connect(T29.inPlaces[1], CentralAHU_Combi.outTransition[2]) annotation (Line(
            points={{-8.16,-40},{-4,-40},{-4,-108},{-122,-108},{-122,-96},{-116,-96},
              {-116,-94},{-114,-94},{-114,-94.64},{-110.2,-94.64}}, color={0,0,0}));
      connect(CentralAHU_Off.pd_t, integerToBoolean1[18].u) annotation (Line(
            points={{-80.48,-68},{-80,-68},{-80,-112},{0,-112},{0,-152.4}},
            color={255,127,0}));
      connect(CentraAHU_Heating.pd_t, integerToBoolean1[19].u) annotation (Line(
            points={{-23.52,-48},{-24,-48},{-24,-22},{0,-22},{0,-152.4}}, color=
             {255,127,0}));
      connect(CentralAHU_Heating_Preheating.pd_t, integerToBoolean1[20].u)
        annotation (Line(points={{-23.52,-84},{-24,-84},{-24,-112},{0,-112},{0,
              -152.4}}, color={255,127,0}));
      connect(CentralAHU_Cooling.pd_t, integerToBoolean1[21].u) annotation (
          Line(points={{-101.52,-48},{-102,-48},{-102,-22},{0,-22},{0,-152.4}},
            color={255,127,0}));
      connect(CentralAHU_Combi.pd_t, integerToBoolean1[22].u) annotation (Line(
            points={{-101.52,-86},{-102,-86},{-102,-112},{1.77636e-15,-112},{
              1.77636e-15,-152.4}}, color={255,127,0}));
      annotation (
        uses(PNlib(version = "2.2"), Modelica(version = "3.2.3")),
        Diagram(graphics={  Text(origin={-161,91},    extent = {{-21, 5}, {13, -3}}, textString = "HTS_System"), Text(origin={
                  -153,-105},                                                                                                             extent = {{-21, 5}, {13, -3}}, textString = "HP_System"), Text(origin={
                  -143,-31},                                                                                                                                                                                                   extent = {{-21, 5}, {13, -3}}, textString = "GTF_System"), Text(origin={
                  -147,-71},                                                                                                                                                                                                       extent = {{-21, 5}, {13, -3}}, textString = "HX"),
                            Text(origin={-59,89},     extent = {{-21, 5}, {13, -3}},
              textString="Switching_Unit",
              lineColor={0,0,0}),
                            Text(origin={-27,-123},   extent = {{-21, 5}, {13, -3}},
              textString="Central_AHU",
              lineColor={0,0,0})},                                                                                                                                                                                                        coordinateSystem(extent={{-200,
                -180},{200,100}},                                                                                                                                                                                                        initialScale = 0.1)),
        Icon(graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                           FillPattern.Solid,
                lineThickness =                                                                                                            0.5, extent={{
                  -200,100},{202,-180}}),                                                                                                                                             Text(origin={
                  -180.675,15.0721},                                                                                                                                                                            lineColor=
                  {95,95,95},                                                                                                                                                                                                        extent={{
                  -9.32512,28.9279},{370.675,-133.074}},
              textString="Automation
 Level")},    coordinateSystem(extent={{-200,-180},{200,100}})),
        __OpenModelica_commandLineOptions = "",
        Documentation(info="<html>
<p>Automatisierungsebene der MODI-Methode</p>
<p>Auswahl der Aktors&auml;tze der verschiedenen Subsysteme basierend auf der Auswahl der &uuml;bergeordneten Betriebsmodi in der Managementebene</p>
<p><br>Struktur Output-Vektor</p>
<p>HTS_Off</p>
<p>HTS_Heating_I</p>
<p>HTS_Heating_II</p>
<p><br>HX_Off</p>
<p>HX_On</p>
<p><br>GTF_Off</p>
<p><br>GTF_On</p>
<p>HP_Off</p>
<p>HP_Heating</p>
<p>HP_Cooling</p>
<p>HP_Combi</p>
<p><br>SU_Off</p>
<p>SU_Heating_GTF</p>
<p>SU_Heating_GTFandCon</p>
<p>SU_Cooling_GTF</p>
<p>SU_Cooling_HP</p>
<p>SU_Cooling_GTFandHP</p>
<p><br>CentralAHU_Off</p>
<p>CentralAHU_Heating</p>
<p>CentralAHU_Heating_Preheating</p>
<p>CentralAHU_Cooling</p>
<p>CentralAHU_Combi</p>
<p><br>Off[1]</p>
<p>Heating[1]</p>
<p>Cooling[1]</p>
<p>Off[2]</p>
<p>Heating[2]</p>
<p>Cooling[2]</p>
<p>Off[3]</p>
<p>Heating[3]</p>
<p>Cooling[3]</p>
<p>Off[4]</p>
<p>Heating[4]</p>
<p>Cooling[4]</p>
<p>Off[5]</p>
<p>Heating[5]</p>
<p>Cooling[5]</p>
<p>Off[6]</p>
<p>Heating[6]</p>
<p>Cooling[6]</p>
<p>(Off/Heating/Cooling 1-5 bestimmen die Aktors&auml;tze der VU/Tabs Module der R&auml;ume)</p>
</html>"));
    end AutomationLevel_V1;

    model ManagementLevel_Temp_V2
      Modelica.Blocks.Interfaces.RealInput RoomTempMea[5] annotation (Placement(
            transformation(
            extent={{-16,-16},{16,16}},
            rotation=270,
            origin={0,106})));
      PNlib.Components.PD Cooling(
        nIn=2,
        nOut=2,
        startTokens=0,
        minTokens=0,
        maxTokens=1,
        reStart=true)
                     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,52})));
      PNlib.Components.TD Off_Cooling(nIn=1, nOut=1,
        delay=30,
        arcWeightIn={1},
        arcWeightOut={1},                           firingCon= not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-44,72})));

      PNlib.Components.TD Cooling_Off(nIn=1, nOut=1,
        delay=30,
        arcWeightIn={1},
        arcWeightOut={1},                           firingCon= not (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15))
        annotation (Placement(transformation(extent={{-54,22},{-34,42}})));
      PNlib.Components.PD Heating(
        nIn=2,
        nOut=2,
        startTokens=0,
        minTokens=0,
        maxTokens=1,
        reStart=true)
                     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={70,54})));
      PNlib.Components.PD Off(
        nIn=3,
        nOut=3,
        startTokens=1,
        minTokens=0,
        maxTokens=1,
        reStart=true)
                     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,52})));
      PNlib.Components.TD Off_Heating(nIn=1, nOut=1,
        delay=30,
        arcWeightIn={1},
        arcWeightOut={1},
        firingCon=(RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and not
                                                                                      (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15))
        annotation (Placement(transformation(extent={{34,62},{54,82}})));
      PNlib.Components.TD Heating_Off(nIn=1, nOut=1,
        delay=30,
        arcWeightIn={1},
        arcWeightOut={1},                           firingCon= not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={44,32})));
      PNlib.Components.PD Combination(
        nIn=3,
        nOut=3,
        startTokens=0,
        minTokens=0,
        maxTokens=1,
        reStart=true)
                     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-38})));
      PNlib.Components.TD Combination_Cooling(nIn=1, nOut=1,
        arcWeightIn={1},
        arcWeightOut={1},                                   firingCon= not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,-4})));

      PNlib.Components.TD Cooling_Combination(nIn=1, nOut=1,
        arcWeightIn={1},
        arcWeightOut={1},                                   firingCon=(RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-4})));

      PNlib.Components.TD Combination_Off(nIn=1, nOut=1,
        arcWeightIn={1},
        arcWeightOut={1},                               firingCon= not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and not
                                                                                      (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-4})));

      PNlib.Components.TD Off_Combination(nIn=1, nOut=1,
        arcWeightIn={1},
        arcWeightOut={1},                              firingCon=(RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-4})));

      PNlib.Components.TD Heating_Combination(nIn=1, nOut=1,
        arcWeightIn={1},
        arcWeightOut={1},                                   firingCon=(RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,-4})));

      PNlib.Components.TD Combination_Heating(nIn=1, nOut=1,
        arcWeightIn={1},
        arcWeightOut={1},                                    firingCon=(RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and not
                                                                                      (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
            3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-4})));


      inner PNlib.Components.Settings settings(animateMarking=true, animatePlace=true)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Modelica.Blocks.Interfaces.BooleanOutput Superior_Mode[4] annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-104})));
      Modelica.Blocks.Math.IntegerToBoolean integerToBoolean[4](each threshold=1)
        annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=270,
            origin={0,-80})));
    equation
      connect(Off.outTransition[1], Off_Heating.inPlaces[1]) annotation (Line(
            points={{0.66667,62.8},{0,62.8},{0,72},{39.2,72}}, color={0,0,0}));
      connect(Off.outTransition[2], Off_Cooling.inPlaces[1])
        annotation (Line(points={{0,62.8},{0,72},{-39.2,72}}, color={0,0,0}));
      connect(Heating_Off.outPlaces[1], Off.inTransition[1]) annotation (Line(
            points={{39.2,32},{0.66667,32},{0.66667,41.2}}, color={0,0,0}));
      connect(Cooling_Off.outPlaces[1], Off.inTransition[2])
        annotation (Line(points={{-39.2,32},{0,32},{0,41.2}}, color={0,0,0}));
      connect(Heating.outTransition[1], Heating_Off.inPlaces[1])
        annotation (Line(points={{69.5,43.2},{69.5,32},{48.8,32}}, color={0,0,0}));
      connect(Off_Heating.outPlaces[1], Heating.inTransition[1])
        annotation (Line(points={{48.8,72},{69.5,72},{69.5,64.8}}, color={0,0,0}));
      connect(Combination_Heating.outPlaces[1], Heating.inTransition[2])
        annotation (Line(points={{90,0.8},{90,72},{70,72},{70,64},{70.5,64},{70.5,64.8}},
            color={0,0,0}));
      connect(Heating.outTransition[2], Heating_Combination.inPlaces[1])
        annotation (Line(points={{70.5,43.2},{70.5,42},{70,42},{70,32},{60,32},{60,0.8}},
            color={0,0,0}));
      connect(Off_Cooling.outPlaces[1], Cooling.inTransition[1]) annotation (Line(
            points={{-48.8,72},{-70,72},{-70,64},{-70.5,64},{-70.5,62.8}}, color={0,
              0,0}));
      connect(Cooling.outTransition[1], Cooling_Off.inPlaces[1]) annotation (Line(
            points={{-70.5,41.2},{-70.5,32},{-48.8,32}}, color={0,0,0}));
      connect(Combination.outTransition[2], Combination_Heating.inPlaces[1])
        annotation (Line(points={{0,-48.8},{0,-60},{90,-60},{90,-8.8}}, color={0,0,0}));
      connect(Heating_Combination.outPlaces[1], Combination.inTransition[2])
        annotation (Line(points={{60,-8.8},{60,-18},{0,-18},{0,-27.2}}, color={0,0,0}));
      connect(Combination.outTransition[3], Combination_Cooling.inPlaces[1])
        annotation (Line(points={{0.66667,-48.8},{0.66667,-60},{-90,-60},{-90,-8.8}},
            color={0,0,0}));
      connect(Combination_Cooling.outPlaces[1], Cooling.inTransition[2])
        annotation (Line(points={{-90,0.8},{-90,72},{-69.5,72},{-69.5,62.8}}, color=
             {0,0,0}));
      connect(Cooling_Combination.inPlaces[1], Cooling.outTransition[2])
        annotation (Line(points={{-60,0.8},{-60,32},{-70,32},{-70,40},{-69.5,40},{-69.5,
              41.2}}, color={0,0,0}));
      connect(Cooling_Combination.outPlaces[1], Combination.inTransition[3])
        annotation (Line(points={{-60,-8.8},{-60,-18},{0.66667,-18},{0.66667,-27.2}},
            color={0,0,0}));
      connect(Combination_Off.inPlaces[1], Combination.outTransition[1])
        annotation (Line(points={{-20,-8.8},{-20,-60},{0,-60},{0,-50},{-0.66667,-50},
              {-0.66667,-48.8}}, color={0,0,0}));
      connect(Combination_Off.outPlaces[1], Off.inTransition[3]) annotation (Line(
            points={{-20,0.8},{-20,32},{-0.66667,32},{-0.66667,41.2}}, color={0,0,0}));
      connect(Off_Combination.outPlaces[1], Combination.inTransition[1])
        annotation (Line(points={{20,-8.8},{20,-18},{0,-18},{0,-26},{-0.66667,-26},{
              -0.66667,-27.2}}, color={0,0,0}));
      connect(Off_Combination.inPlaces[1], Off.outTransition[3]) annotation (Line(
            points={{20,0.8},{20,72},{-0.66667,72},{-0.66667,62.8}}, color={0,0,0}));
      connect(Combination.pd_t, integerToBoolean[4].u) annotation (Line(points={{10.6,
              -38},{20,-38},{20,-60},{0,-60},{0,-72.8}}, color={255,127,0}));
      connect(Off.pd_t, integerToBoolean[1].u) annotation (Line(points={{-10.6,52},{
              -36,52},{-36,-60},{0,-60},{0,-72.8}}, color={255,127,0}));
      connect(Heating.pd_t, integerToBoolean[2].u) annotation (Line(points={{80.6,54},
              {100,54},{100,-60},{0,-60},{0,-72.8}}, color={255,127,0}));
      connect(Cooling.pd_t, integerToBoolean[3].u) annotation (Line(points={{-59.4,52},
              {-60,52},{-60,72},{-100,72},{-100,-60},{0,-60},{0,-72.8}}, color={255,
              127,0}));
      connect(integerToBoolean[1].y, Superior_Mode[1])
        annotation (Line(points={{0,-86.6},{0,-96.5}}, color={255,0,255}));
      connect(integerToBoolean[2].y, Superior_Mode[2])
        annotation (Line(points={{0,-86.6},{0,-101.5}}, color={255,0,255}));
      connect(integerToBoolean[3].y, Superior_Mode[3])
        annotation (Line(points={{0,-86.6},{0,-106.5}}, color={255,0,255}));
      connect(integerToBoolean[4].y, Superior_Mode[4])
        annotation (Line(points={{0,-86.6},{0,-111.5}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-200,100},{200,-102}},
              lineColor={95,95,95},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5), Text(
              extent={{-186,70},{184,-114}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Management
Level
")}),          Diagram(coordinateSystem(preserveAspectRatio=false)));
    end ManagementLevel_Temp_V2;

    model ManagementLevel_Temp_Hum_V2
      Modelica.Blocks.Interfaces.RealInput RoomTempMea[5] annotation (Placement(
            transformation(
            extent={{-16,-16},{16,16}},
            rotation=270,
            origin={-100,108})));
      PNlib.Components.PD Cooling(
        nIn=2,
        nOut=2,
        startTokens=0,
        minTokens=0,
        maxTokens=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-170,54})));
      PNlib.Components.TD Off_Temp_Cooling(
        nIn=1,
        nOut=1,
        firingCon=not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or
            RoomTempMea[3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15)
             and RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[3] >
            295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-144,74})));
      PNlib.Components.TD Cooling_Off_Temp(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{-154,24},{-134,44}})));
      PNlib.Components.PD Heating(
        nIn=2,
        nOut=2,
        startTokens=0,
        minTokens=0,
        maxTokens=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,56})));
      PNlib.Components.PD Off_Temp(
        nIn=3,
        nOut=3,
        startTokens=1,
        minTokens=0,
        maxTokens=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-100,54})));
      PNlib.Components.TD Off_Temp_Heating(
        nIn=1,
        nOut=1,
        firingCon=RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15 and
            not (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[3] >
            295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15))
        annotation (Placement(transformation(extent={{-66,64},{-46,84}})));
      PNlib.Components.TD Heating_Off_Temp(
        nIn=1,
        nOut=1,
        firingCon=not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or
            RoomTempMea[3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-56,34})));
      PNlib.Components.PD Combination_Temp(
        nIn=3,
        nOut=3,
        startTokens=0,
        minTokens=0,
        maxTokens=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-100,-36})));
      PNlib.Components.T Combination_Temp_Cooling(
        nIn=1,
        nOut=1,
        firingCon=not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or
            RoomTempMea[3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15)
             and RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[3] >
            295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-190,-2})));
      PNlib.Components.T Cooling_Combination_Temp(
        nIn=1,
        nOut=1,
        firingCon=RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15 and
            RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[3] > 295.15
             or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-160,-2})));
      PNlib.Components.T Combination_Temp_Off_Temp(
        nIn=1,
        nOut=1,
        firingCon=not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or
            RoomTempMea[3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15)
             and not (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or
            RoomTempMea[3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-120,-2})));
      PNlib.Components.T Off_Temp_Combination_Temp(
        nIn=1,
        nOut=1,
        firingCon=RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15 and
            RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[3] > 295.15
             or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-80,-2})));
      PNlib.Components.T Heating_Combination_Temp(
        nIn=1,
        nOut=1,
        firingCon=RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15 and
            RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[3] > 295.15
             or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,-2})));
      PNlib.Components.T Combination_Temp_Heating(
        nIn=1,
        nOut=1,
        firingCon=RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
            3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15 and
            not (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[3] >
            295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,-2})));
      inner PNlib.Components.Settings settings
        annotation (Placement(transformation(extent={{-200,82},{-180,102}})));
      Modelica.Blocks.Interfaces.BooleanOutput Superior_Mode_Temp[4] annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-100,-102})));
      Modelica.Blocks.Math.IntegerToBoolean integerToBoolean[4](each threshold=1)
        annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=270,
            origin={-100,-78})));
      Modelica.Blocks.Interfaces.RealInput RoomHumMea[5] annotation (Placement(
            transformation(
            extent={{-16,-16},{16,16}},
            rotation=270,
            origin={100,108})));
      PNlib.Components.PD Dehumidifying(
        nIn=2,
        nOut=2,
        startTokens=0,
        minTokens=0,
        maxTokens=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,54})));
      PNlib.Components.TD Off_Hum_Dehumidifying(
        nIn=1,
        nOut=1,
        firingCon=not (RoomHumMea[1] < 0.4 or RoomHumMea[2] < 0.4 or
            RoomHumMea[3] <0.4 or RoomHumMea[4] < 0.4 or RoomHumMea[5] <0.4)
             and RoomHumMea[1] > 0.7 or RoomHumMea[2] > 0.7 or RoomHumMea[3] >
            0.7 or RoomHumMea[4] > 0.7 or RoomHumMea[5] > 0.7)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={56,74})));
      PNlib.Components.TD Dehumidifying_Off_Hum(nIn=1, nOut=1)
        annotation (Placement(transformation(extent={{46,24},{66,44}})));
      PNlib.Components.PD Humidifying(
        nIn=2,
        nOut=2,
        startTokens=0,
        minTokens=0,
        maxTokens=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={170,56})));
      PNlib.Components.PD Off_Hum(
        nIn=3,
        nOut=3,
        startTokens=1,
        minTokens=0,
        maxTokens=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={100,54})));
      PNlib.Components.TD Off_Hum_Humidifying(
        nIn=1,
        nOut=1,
        firingCon=RoomHumMea[1] < 0.4 or RoomHumMea[2] < 0.4 or RoomHumMea[
            3] < 0.4 or RoomHumMea[4] < 0.4 or RoomHumMea[5] < 0.4 and
            not (RoomHumMea[1] > 0.7 or RoomHumMea[2] >0.7 or RoomHumMea[3] >
            0.7 or RoomHumMea[4] > 0.7 or RoomHumMea[5] > 0.7))
        annotation (Placement(transformation(extent={{134,64},{154,84}})));
      PNlib.Components.TD Humidifying_Off_Hum(
        nIn=1,
        nOut=1,
        firingCon=not (RoomHumMea[1] < 0.4 or RoomHumMea[2] < 0.4 or
            RoomHumMea[3] < 0.4 or RoomHumMea[4] < 0.4 or RoomHumMea[5] < 0.4))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={144,34})));
      PNlib.Components.PD Combination_Hum(
        nIn=3,
        nOut=3,
        startTokens=0,
        minTokens=0,
        maxTokens=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={100,-36})));
      PNlib.Components.T Combination_Hum_Dehumidifying(
        nIn=1,
        nOut=1,
        firingCon=not (RoomHumMea[1] < 0.4 or RoomHumMea[2] < 0.4 or
            RoomHumMea[3] < 0.4 or RoomHumMea[4] < 0.4 or RoomHumMea[5] < 0.4)
             and RoomHumMea[1] > 0.7 or RoomHumMea[2] > 0.7 or RoomHumMea[3] >
            0.7 or RoomHumMea[4] > 0.7 or RoomHumMea[5] > 0.7)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,-2})));
      PNlib.Components.T Dehumidifying_Combination_Hum(
        nIn=1,
        nOut=1,
        firingCon=RoomHumMea[1] < 0.4 or RoomHumMea[2] < 0.4 or RoomHumMea[
            3] < 0.4 or RoomHumMea[4] <0.4 or RoomHumMea[5] < 0.4 and
            RoomHumMea[1] > 0.7 or RoomHumMea[2] > 0.7 or RoomHumMea[3] > 0.7
             or RoomHumMea[4] > 0.7 or RoomHumMea[5] > 0.7) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,-2})));
      PNlib.Components.T Combination_Hum_Off_Hum(
        nIn=1,
        nOut=1,
        firingCon=not (RoomHumMea[1] < 0.4 or RoomHumMea[2] < 0.4 or
            RoomHumMea[3] < 0.4 or RoomHumMea[4] <0.4 or RoomHumMea[5] < 0.4)
             and not (RoomHumMea[1] > 0.7 or RoomHumMea[2] > 0.7 or
            RoomHumMea[3] > 0.7 or RoomHumMea[4] > 0.7 or RoomHumMea[5] > 0.7))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={80,-2})));
      PNlib.Components.T Off_Hum_Combination_Hum(
        nIn=1,
        nOut=1,
        firingCon=RoomHumMea[1] < 0.4 or RoomHumMea[2] <0.4 or RoomHumMea[
            3] < 0.4 or RoomHumMea[4] < 0.4 or RoomHumMea[5] < 0.4 and
            RoomHumMea[1] > 0.7 or RoomHumMea[2] > 0.7 or RoomHumMea[3] > 0.7
             or RoomHumMea[4] > 0.7 or RoomHumMea[5] > 0.7) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={120,-2})));
      PNlib.Components.T Humidifying_Combination_Hum(
        nIn=1,
        nOut=1,
        firingCon=RoomHumMea[1] < 0.4 or RoomHumMea[2] <0.4 or RoomHumMea[
            3] < 0.4 or RoomHumMea[4] < 0.4 or RoomHumMea[5] < 0.4 and
            RoomHumMea[1] > 0.7 or RoomHumMea[2] > 0.7 or RoomHumMea[3] > 0.7
             or RoomHumMea[4] > 0.7 or RoomHumMea[5] > 0.7) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={160,-2})));
      PNlib.Components.T Combination_Hum_Humidiyfing(
        nIn=1,
        nOut=1,
        firingCon=RoomHumMea[1] <  0.4 or RoomHumMea[2] <  0.4 or RoomHumMea[
            3] <  0.4 or RoomHumMea[4] <  0.4 or RoomHumMea[5] <  0.4 and
            not (RoomHumMea[1] > 0.7 or RoomHumMea[2] > 0.7 or RoomHumMea[3] >
            0.7 or RoomHumMea[4] > 0.7 or RoomHumMea[5] > 0.7))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={190,-2})));
      Modelica.Blocks.Interfaces.BooleanOutput Superior_Mode_Hum[4] annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={100,-106})));
      Modelica.Blocks.Math.IntegerToBoolean integerToBoolean1
                                                            [4](each threshold=1)
        annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=270,
            origin={100,-76})));
    equation
      connect(Off_Temp.outTransition[1], Off_Temp_Heating.inPlaces[1]) annotation (
          Line(points={{-99.3333,64.8},{-100,64.8},{-100,74},{-60.8,74}}, color={0,0,
              0}));
      connect(Off_Temp.outTransition[2], Off_Temp_Cooling.inPlaces[1]) annotation (
          Line(points={{-100,64.8},{-100,74},{-139.2,74}}, color={0,0,0}));
      connect(Heating_Off_Temp.outPlaces[1], Off_Temp.inTransition[1]) annotation (
          Line(points={{-60.8,34},{-99.3333,34},{-99.3333,43.2}}, color={0,0,0}));
      connect(Cooling_Off_Temp.outPlaces[1], Off_Temp.inTransition[2]) annotation (
          Line(points={{-139.2,34},{-100,34},{-100,43.2}}, color={0,0,0}));
      connect(Heating.outTransition[1], Heating_Off_Temp.inPlaces[1]) annotation (
          Line(points={{-30.5,45.2},{-30.5,34},{-51.2,34}}, color={0,0,0}));
      connect(Off_Temp_Heating.outPlaces[1], Heating.inTransition[1]) annotation (
          Line(points={{-51.2,74},{-30.5,74},{-30.5,66.8}}, color={0,0,0}));
      connect(Combination_Temp_Heating.outPlaces[1], Heating.inTransition[2])
        annotation (Line(points={{-10,2.8},{-10,74},{-30,74},{-30,66},{-29.5,66},{-29.5,
              66.8}}, color={0,0,0}));
      connect(Heating.outTransition[2], Heating_Combination_Temp.inPlaces[1])
        annotation (Line(points={{-29.5,45.2},{-29.5,44},{-30,44},{-30,34},{-40,34},
              {-40,2.8}}, color={0,0,0}));
      connect(Off_Temp_Cooling.outPlaces[1], Cooling.inTransition[1]) annotation (
          Line(points={{-148.8,74},{-170,74},{-170,66},{-170.5,66},{-170.5,64.8}},
            color={0,0,0}));
      connect(Cooling.outTransition[1], Cooling_Off_Temp.inPlaces[1]) annotation (
          Line(points={{-170.5,43.2},{-170.5,34},{-148.8,34}}, color={0,0,0}));
      connect(Combination_Temp.outTransition[2], Combination_Temp_Heating.inPlaces[1])
        annotation (Line(points={{-100,-46.8},{-100,-58},{-10,-58},{-10,-6.8}},
            color={0,0,0}));
      connect(Heating_Combination_Temp.outPlaces[1], Combination_Temp.inTransition[2])
        annotation (Line(points={{-40,-6.8},{-40,-16},{-100,-16},{-100,-25.2}},
            color={0,0,0}));
      connect(Combination_Temp.outTransition[3], Combination_Temp_Cooling.inPlaces[1])
        annotation (Line(points={{-99.3333,-46.8},{-99.3333,-58},{-190,-58},{
              -190,-6.8}},
            color={0,0,0}));
      connect(Combination_Temp_Cooling.outPlaces[1], Cooling.inTransition[2])
        annotation (Line(points={{-190,2.8},{-190,74},{-169.5,74},{-169.5,64.8}},
            color={0,0,0}));
      connect(Cooling_Combination_Temp.inPlaces[1], Cooling.outTransition[2])
        annotation (Line(points={{-160,2.8},{-160,34},{-170,34},{-170,42},{-169.5,42},
              {-169.5,43.2}}, color={0,0,0}));
      connect(Cooling_Combination_Temp.outPlaces[1], Combination_Temp.inTransition[3])
        annotation (Line(points={{-160,-6.8},{-160,-16},{-99.3333,-16},{
              -99.3333,-25.2}},
            color={0,0,0}));
      connect(Combination_Temp_Off_Temp.inPlaces[1], Combination_Temp.outTransition[
        1]) annotation (Line(points={{-120,-6.8},{-120,-58},{-100,-58},{-100,
              -48},{-100.667,-48},{-100.667,-46.8}},
                                      color={0,0,0}));
      connect(Combination_Temp_Off_Temp.outPlaces[1], Off_Temp.inTransition[3])
        annotation (Line(points={{-120,2.8},{-120,34},{-100.667,34},{-100.667,
              43.2}},
            color={0,0,0}));
      connect(Off_Temp_Combination_Temp.outPlaces[1], Combination_Temp.inTransition[
        1]) annotation (Line(points={{-80,-6.8},{-80,-16},{-100,-16},{-100,-24},
              {-100.667,-24},{-100.667,-25.2}},
                                      color={0,0,0}));
      connect(Off_Temp_Combination_Temp.inPlaces[1], Off_Temp.outTransition[3])
        annotation (Line(points={{-80,2.8},{-80,74},{-100.667,74},{-100.667,
              64.8}},
            color={0,0,0}));
      connect(Combination_Temp.pd_t, integerToBoolean[4].u) annotation (Line(points=
             {{-89.4,-36},{-80,-36},{-80,-58},{-100,-58},{-100,-70.8}}, color={255,127,
              0}));
      connect(Off_Temp.pd_t, integerToBoolean[1].u) annotation (Line(points={{-110.6,
              54},{-136,54},{-136,-58},{-100,-58},{-100,-70.8}}, color={255,127,0}));
      connect(Heating.pd_t,integerToBoolean [2].u) annotation (Line(points={{-19.4,56},
              {0,56},{0,-58},{-100,-58},{-100,-70.8}},
                                                     color={255,127,0}));
      connect(Cooling.pd_t,integerToBoolean [3].u) annotation (Line(points={{-159.4,
              54},{-160,54},{-160,74},{-200,74},{-200,-58},{-100,-58},{-100,-70.8}},
                                                                         color={255,
              127,0}));
      connect(integerToBoolean[1].y, Superior_Mode_Temp[1])
        annotation (Line(points={{-100,-84.6},{-100,-94.5}}, color={255,0,255}));
      connect(integerToBoolean[2].y, Superior_Mode_Temp[2])
        annotation (Line(points={{-100,-84.6},{-100,-99.5}}, color={255,0,255}));
      connect(integerToBoolean[3].y, Superior_Mode_Temp[3])
        annotation (Line(points={{-100,-84.6},{-100,-104.5}}, color={255,0,255}));
      connect(integerToBoolean[4].y, Superior_Mode_Temp[4])
        annotation (Line(points={{-100,-84.6},{-100,-109.5}}, color={255,0,255}));
      connect(Off_Hum.outTransition[1], Off_Hum_Humidifying.inPlaces[1])
        annotation (Line(points={{100.667,64.8},{100,64.8},{100,74},{139.2,74}},
            color={0,0,0}));
      connect(Off_Hum.outTransition[2], Off_Hum_Dehumidifying.inPlaces[1])
        annotation (Line(points={{100,64.8},{100,74},{60.8,74}}, color={0,0,0}));
      connect(Humidifying_Off_Hum.outPlaces[1], Off_Hum.inTransition[1])
        annotation (Line(points={{139.2,34},{100.667,34},{100.667,43.2}}, color={0,0,
              0}));
      connect(Dehumidifying_Off_Hum.outPlaces[1], Off_Hum.inTransition[2])
        annotation (Line(points={{60.8,34},{100,34},{100,43.2}}, color={0,0,0}));
      connect(Humidifying.outTransition[1], Humidifying_Off_Hum.inPlaces[1])
        annotation (Line(points={{169.5,45.2},{169.5,34},{148.8,34}}, color={0,0,0}));
      connect(Off_Hum_Humidifying.outPlaces[1], Humidifying.inTransition[1])
        annotation (Line(points={{148.8,74},{169.5,74},{169.5,66.8}}, color={0,0,0}));
      connect(Combination_Hum_Humidiyfing.outPlaces[1], Humidifying.inTransition[2])
        annotation (Line(points={{190,2.8},{190,74},{170,74},{170,66},{170.5,66},{170.5,
              66.8}}, color={0,0,0}));
      connect(Humidifying.outTransition[2], Humidifying_Combination_Hum.inPlaces[1])
        annotation (Line(points={{170.5,45.2},{170.5,44},{170,44},{170,34},{160,34},
              {160,2.8}}, color={0,0,0}));
      connect(Off_Hum_Dehumidifying.outPlaces[1], Dehumidifying.inTransition[1])
        annotation (Line(points={{51.2,74},{30,74},{30,66},{29.5,66},{29.5,64.8}},
            color={0,0,0}));
      connect(Dehumidifying.outTransition[1], Dehumidifying_Off_Hum.inPlaces[1])
        annotation (Line(points={{29.5,43.2},{29.5,34},{51.2,34}}, color={0,0,0}));
      connect(Combination_Hum.outTransition[2], Combination_Hum_Humidiyfing.inPlaces[
        1]) annotation (Line(points={{100,-46.8},{100,-58},{190,-58},{190,-6.8}},
            color={0,0,0}));
      connect(Humidifying_Combination_Hum.outPlaces[1], Combination_Hum.inTransition[
        2]) annotation (Line(points={{160,-6.8},{160,-16},{100,-16},{100,-25.2}},
            color={0,0,0}));
      connect(Combination_Hum.outTransition[3], Combination_Hum_Dehumidifying.inPlaces[
        1]) annotation (Line(points={{100.667,-46.8},{100.667,-58},{10,-58},{10,
              -6.8}},
            color={0,0,0}));
      connect(Combination_Hum_Dehumidifying.outPlaces[1], Dehumidifying.inTransition[
        2]) annotation (Line(points={{10,2.8},{10,74},{30.5,74},{30.5,64.8}}, color=
             {0,0,0}));
      connect(Dehumidifying_Combination_Hum.inPlaces[1], Dehumidifying.outTransition[
        2]) annotation (Line(points={{40,2.8},{40,34},{30,34},{30,42},{30.5,42},{30.5,
              43.2}}, color={0,0,0}));
      connect(Dehumidifying_Combination_Hum.outPlaces[1], Combination_Hum.inTransition[
        3]) annotation (Line(points={{40,-6.8},{40,-16},{100.667,-16},{100.667,
              -25.2}},
            color={0,0,0}));
      connect(Combination_Hum_Off_Hum.inPlaces[1], Combination_Hum.outTransition[1])
        annotation (Line(points={{80,-6.8},{80,-58},{100,-58},{100,-48},{
              99.3333,-48},{99.3333,-46.8}},
                                color={0,0,0}));
      connect(Combination_Hum_Off_Hum.outPlaces[1], Off_Hum.inTransition[3])
        annotation (Line(points={{80,2.8},{80,34},{99.3333,34},{99.3333,43.2}},
            color={0,0,0}));
      connect(Off_Hum_Combination_Hum.outPlaces[1], Combination_Hum.inTransition[1])
        annotation (Line(points={{120,-6.8},{120,-16},{100,-16},{100,-24},{
              99.3333,-24},{99.3333,-25.2}},
                                color={0,0,0}));
      connect(Off_Hum_Combination_Hum.inPlaces[1], Off_Hum.outTransition[3])
        annotation (Line(points={{120,2.8},{120,74},{99.3333,74},{99.3333,64.8}},
            color={0,0,0}));
      connect(Combination_Hum.pd_t, integerToBoolean1[4].u) annotation (Line(points=
             {{110.6,-36},{120,-36},{120,-58},{100,-58},{100,-68.8}}, color={255,127,
              0}));
      connect(Off_Hum.pd_t, integerToBoolean1[1].u) annotation (Line(points={{89.4,54},
              {64,54},{64,-58},{100,-58},{100,-68.8}}, color={255,127,0}));
      connect(Humidifying.pd_t, integerToBoolean1[2].u) annotation (Line(points={{180.6,
              56},{200,56},{200,-58},{100,-58},{100,-68.8}}, color={255,127,0}));
      connect(Dehumidifying.pd_t, integerToBoolean1[3].u) annotation (Line(points={{
              40.6,54},{40,54},{40,74},{0,74},{0,-58},{100,-58},{100,-68.8}}, color=
             {255,127,0}));
      connect(integerToBoolean1[1].y, Superior_Mode_Hum[1])
        annotation (Line(points={{100,-82.6},{100,-98.5}}, color={255,0,255}));
      connect(integerToBoolean1[2].y, Superior_Mode_Hum[2])
        annotation (Line(points={{100,-82.6},{100,-103.5}}, color={255,0,255}));
      connect(integerToBoolean1[3].y, Superior_Mode_Hum[3])
        annotation (Line(points={{100,-82.6},{100,-108.5}}, color={255,0,255}));
      connect(integerToBoolean1[4].y, Superior_Mode_Hum[4])
        annotation (Line(points={{100,-82.6},{100,-113.5}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
                {200,100}}), graphics={Rectangle(
              extent={{-100,100},{102,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid), Text(
              extent={{-88,60},{92,-52}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Management
Level
Temperature
and
Humidity")}),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
                -100},{200,100}})));
    end ManagementLevel_Temp_Hum_V2;

    package old
      model AutomationLevel_V1
        PNlib.Components.PD RLT_Heating_I[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-44, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T11[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-80, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD RLT_Cooling_I[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-212, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T16[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-174, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD RLT_Heating_Off[6](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(extent = {{-120, 78}, {-100, 98}}, rotation = 0)));
        PNlib.Components.PD RLT_Heating_II[6](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-44, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T1[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-80, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T12[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-80, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T13[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-80, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T15[6](each nIn = 1, each nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-34, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T14[6](each nIn = 1, each nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-54, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.PD RLT_Cooling_Off[6](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-146, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD RLT_Cooling_II[6](each nIn = 2, each nOut = 2, each startTokens = 0, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-212, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T17[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-174, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T18[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-174, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T19[6](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-174, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T110[6](each nIn = 1, each nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-222, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T111[6](each nIn = 1, each nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-202, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.T T113[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-172, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T114[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-172, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T115[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-78, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD BKT_Cooling_II[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-210, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T116[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-200, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.T T117[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-220, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T118[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-52, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.T T119[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-30, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.PD BKT_Off[5](each nIn = 4, each nOut = 4, each startTokens = 1, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-126, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T120[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-172, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T121[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-78, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD BKT_Cooling_I[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-210, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD BKT_Heating_I[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-42, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T122[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-172, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T123[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-78, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T112[5](each nIn = 1, each nOut = 1, each arcWeightIn = {1}, each arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-78, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD BKT_Heating_II[5](each nIn = 2, each nOut = 2, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-42, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T1133(nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {68, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T1135(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {94, 74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.T T1136(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {114, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.PD Generation_Hot_Off(nIn = 2, nOut = 2, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation (
          Placement(visible = true, transformation(extent = {{28, 64}, {48, 84}}, rotation = 0)));
        PNlib.Components.PD Generation_Hot_II(nIn = 2, nOut = 2, maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {104, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T1139(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {68, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T1141(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {68, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T1143(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {68, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD Generation_Hot_I(nIn = 2, nOut = 2, maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {104, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD Generation_Warm_Off(nIn = 1, nOut = 1, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {166, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        PNlib.Components.T T1151(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {196, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD Generation_Warm_On(nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {226, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T1153(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {196, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD Generation_Cold_Off(nIn = 3, nOut = 3, maxTokens = 1, reStart = true, reStartTokens = 1, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {44, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T2(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {74, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD Generation_Cold_II(nIn = 3, nOut = 3, maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {106, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T3(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {74, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T6(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {74, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD Generation_Cold_I(nIn = 3, nOut = 3, maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {108, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T7(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {74, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T T9(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {74, -132}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD Generation_Cold_III(nIn = 3, nOut = 3, maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {104, -126}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        PNlib.Components.T T10(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {74, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T T4(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {98, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T5(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {118, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        PNlib.Components.T T8(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {94, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T20(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {114, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        PNlib.Components.T T23(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {148, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T T24(nIn = 1, nOut = 1, arcWeightIn = {1}, arcWeightOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {168, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        Modelica.Blocks.Interfaces.RealInput u[15] annotation (
          Placement(visible = true, transformation(origin = {-2.22045e-16, 164}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {-2.22045e-16, 164}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealOutput y[70] annotation (
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
        connect(T1153.outPlaces[1], Generation_Warm_Off.inTransition[1]) annotation (
          Line(points = {{191.2, 84}, {184.9, 84}, {184.9, 82}, {178.6, 82}, {178.6, 82}, {166, 82}, {166, 78.8}, {166, 78.8}, {166, 80.8}, {166, 80.8}}, thickness = 0.5));
        connect(Generation_Warm_On.outTransition[1], T1153.inPlaces[1]) annotation (
          Line(points = {{226, 80.8}, {221, 80.8}, {221, 80.8}, {216, 80.8}, {216, 84}, {200.8, 84}}, thickness = 0.5));
        connect(T1151.outPlaces[1], Generation_Warm_On.inTransition[1]) annotation (
          Line(points = {{200.8, 64}, {203.4, 64}, {203.4, 64}, {206, 64}, {206, 60}, {218, 60}, {218, 59.2}, {226, 59.2}}, thickness = 0.5));
        connect(Generation_Warm_Off.outTransition[1], T1151.inPlaces[1]) annotation (
          Line(points = {{166, 59.2}, {177, 59.2}, {177, 57.2}, {188, 57.2}, {188, 62}, {190, 62}, {190, 64}, {190.6, 64}, {190.6, 64}, {191.2, 64}}, thickness = 0.5));
        connect(Generation_Hot_I.outTransition[1], T1143.inPlaces[1]) annotation (
          Line(points = {{93.2, 96}, {89.6, 96}, {89.6, 98}, {88, 98}, {88, 103.5}, {80.4, 103.5}, {80.4, 103.5}, {72.8, 103.5}}, thickness = 0.5));
        connect(T1133.outPlaces[1], Generation_Hot_I.inTransition[1]) annotation (
          Line(points = {{72.8, 84}, {120, 84}, {120, 96}, {116, 96}, {116, 94.5}, {114.4, 94.5}, {114.4, 96.5}, {114.8, 96.5}}, thickness = 0.5));
        connect(T1136.outPlaces[1], Generation_Hot_I.inTransition[2]) annotation (
          Line(points = {{114, 78.8}, {114, 84}, {120, 84}, {120, 95.5}, {114.8, 95.5}}, thickness = 0.5));
        connect(Generation_Hot_I.outTransition[2], T1135.inPlaces[1]) annotation (
          Line(points = {{93.2, 96}, {91.4, 96}, {91.4, 92}, {89.6, 92}, {89.6, 90}, {88, 90}, {88, 78.5}, {94, 78.5}, {94, 77.9}, {94, 77.9}, {94, 79.3}}, thickness = 0.5));
        connect(T1143.outPlaces[1], Generation_Hot_Off.inTransition[1]) annotation (
          Line(points = {{63.2, 104}, {24, 104}, {24, 74}, {26, 74}, {26, 73.5}, {27.2, 73.5}}, thickness = 0.5));
        connect(T1141.outPlaces[1], Generation_Hot_Off.inTransition[2]) annotation (
          Line(points = {{63.2, 44}, {24, 44}, {24, 74}, {26, 74}, {26, 74.5}, {27.2, 74.5}}, thickness = 0.5));
        connect(Generation_Hot_II.outTransition[1], T1141.inPlaces[1]) annotation (
          Line(points = {{114.8, 52}, {115.4, 52}, {115.4, 46}, {118, 46}, {118, 32.5}, {86, 32.5}, {86, 44.5}, {79.4, 44.5}, {79.4, 40.5}, {76.1, 40.5}, {76.1, 44.5}, {72.8, 44.5}}, thickness = 0.5));
        connect(Generation_Hot_Off.outTransition[2], T1139.inPlaces[1]) annotation (
          Line(points = {{48.8, 74}, {51.4, 74}, {51.4, 72}, {54, 72}, {54, 65.5}, {58.6, 65.5}, {58.6, 59.5}, {60.9, 59.5}, {60.9, 63.5}, {63.2, 63.5}}, thickness = 0.5));
        connect(T1139.outPlaces[1], Generation_Hot_II.inTransition[1]) annotation (
          Line(points = {{72.8, 64}, {88, 64}, {88, 52}, {92, 52}, {92, 49.5}, {92.6, 49.5}, {92.6, 47.5}, {92.9, 47.5}, {92.9, 51.5}, {93.2, 51.5}}, thickness = 0.5));
        connect(Generation_Hot_II.outTransition[2], T1136.inPlaces[1]) annotation (
          Line(points = {{114.8, 52}, {115.6, 52}, {115.6, 48}, {116.4, 48}, {116.4, 52}, {118, 52}, {118, 61.5}, {114, 61.5}, {114, 67.1}, {114, 67.1}, {114, 68.7}}, thickness = 0.5));
        connect(T1135.outPlaces[1], Generation_Hot_II.inTransition[2]) annotation (
          Line(points = {{94, 69.2}, {94, 64}, {88, 64}, {88, 52}, {93.2, 52}, {93.2, 52.25}, {93.2, 52.25}, {93.2, 52.5}}, thickness = 0.5));
        connect(Generation_Hot_Off.outTransition[1], T1133.inPlaces[1]) annotation (
          Line(points = {{48.8, 74}, {51.4, 74}, {51.4, 72}, {54, 72}, {54, 84.5}, {58.6, 84.5}, {58.6, 84.5}, {63.2, 84.5}}, thickness = 0.5));
        connect(T24.outPlaces[1], Generation_Cold_III.inTransition[1]) annotation (
          Line(points = {{168, -80.8}, {168, -115.2}, {103.333, -115.2}}));
        connect(Generation_Cold_I.outTransition[3], T24.inPlaces[1]) annotation (
          Line(points = {{108, -3.2}, {110.334, -3.2}, {110.334, -3.2}, {110.667, -3.2}, {110.667, -4}, {176.667, -4}, {176.667, -71.2}, {172.667, -71.2}, {172.667, -71.2}, {168.667, -71.2}}));
        connect(T23.outPlaces[1], Generation_Cold_I.inTransition[3]) annotation (
          Line(points = {{148, -71.2}, {148, -47}, {146, -47}, {146, -24.8}, {127.666, -24.8}, {127.666, -24.8}, {107.333, -24.8}}));
        connect(Generation_Cold_III.outTransition[1], T23.inPlaces[1]) annotation (
          Line(points = {{104, -136.8}, {116.667, -136.8}, {116.667, -138}, {148.667, -138}, {148.667, -109.4}, {148.667, -109.4}, {148.667, -80.8}}));
        connect(T20.outPlaces[1], Generation_Cold_III.inTransition[2]) annotation (
          Line(points = {{114, -106.8}, {114, -104.4}, {112, -104.4}, {112, -110}, {102, -110}, {102, -111.6}, {104, -111.6}, {104, -115.2}}));
        connect(Generation_Cold_II.outTransition[3], T20.inPlaces[1]) annotation (
          Line(points = {{106, -65.2}, {108.334, -65.2}, {108.334, -65.2}, {108.667, -65.2}, {108.667, -64}, {116.667, -64}, {116.667, -97.2}, {116.667, -97.2}, {116.667, -97.2}, {114.667, -97.2}}));
        connect(T8.outPlaces[1], Generation_Cold_II.inTransition[3]) annotation (
          Line(points = {{94, -97.2}, {96, -97.2}, {96, -86.8}, {105.333, -86.8}}));
        connect(Generation_Cold_III.outTransition[2], T8.inPlaces[1]) annotation (
          Line(points = {{104, -136.8}, {102, -136.8}, {102, -136}, {92, -136}, {92, -121.4}, {94, -121.4}, {94, -106.8}}));
        connect(T5.outPlaces[1], Generation_Cold_II.inTransition[1]) annotation (
          Line(points = {{118, -50.8}, {118, -86.8}, {106.667, -86.8}}));
        connect(Generation_Cold_I.outTransition[2], T5.inPlaces[1]) annotation (
          Line(points = {{108, -3.2}, {109, -3.2}, {109, -3.2}, {108, -3.2}, {108, -4}, {126, -4}, {126, -41.2}, {118, -41.2}}));
        connect(T4.outPlaces[1], Generation_Cold_I.inTransition[2]) annotation (
          Line(points = {{98, -41.2}, {98, -24.8}, {108, -24.8}}));
        connect(Generation_Cold_II.outTransition[1], T4.inPlaces[1]) annotation (
          Line(points = {{106, -65.2}, {103.666, -65.2}, {103.666, -65.2}, {101.333, -65.2}, {101.333, -62}, {97.333, -62}, {97.333, -55.4}, {97.333, -55.4}, {97.333, -50.8}}));
        connect(T10.outPlaces[1], Generation_Cold_III.inTransition[3]) annotation (
          Line(points = {{78.8, -112}, {91.7335, -112}, {91.7335, -112}, {102.667, -112}, {102.667, -112.6}, {104.667, -112.6}, {104.667, -115.2}}));
        connect(Generation_Cold_Off.outTransition[3], T10.inPlaces[1]) annotation (
          Line(points = {{54.8, -76}, {54.4, -76}, {54.4, -76}, {54, -76}, {54, -112.667}, {61.6, -112.667}, {61.6, -112.667}, {69.2, -112.667}}));
        connect(Generation_Cold_III.outTransition[3], T9.inPlaces[1]) annotation (
          Line(points = {{104, -136.8}, {99.333, -136.8}, {99.333, -136}, {78.133, -136}, {78.133, -134}, {78.133, -134}, {78.133, -132}}));
        connect(T9.outPlaces[1], Generation_Cold_Off.inTransition[3]) annotation (
          Line(points = {{69.2, -132}, {47.6, -132}, {47.6, -132}, {24, -132}, {24, -75.333}, {29.6, -75.333}, {29.6, -75.333}, {33.2, -75.333}}));
        connect(T7.outPlaces[1], Generation_Cold_Off.inTransition[1]) annotation (
          Line(points = {{69.2, -4}, {47.6, -4}, {47.6, -4}, {26, -4}, {26, -76.667}, {33.2, -76.667}}));
        connect(Generation_Cold_I.outTransition[1], T7.inPlaces[1]) annotation (
          Line(points = {{108, -3.2}, {107.333, -3.2}, {107.333, -2}, {78.133, -2}, {78.133, -3}, {78.133, -3}, {78.133, -4}}));
        connect(T6.outPlaces[1], Generation_Cold_I.inTransition[1]) annotation (
          Line(points = {{78.8, -24}, {93.7335, -24}, {93.7335, -24}, {106.667, -24}, {106.667, -23.4}, {108.667, -23.4}, {108.667, -24.8}}));
        connect(Generation_Cold_Off.outTransition[1], T6.inPlaces[1]) annotation (
          Line(points = {{54.8, -76}, {54.4, -76}, {54.4, -78}, {54, -78}, {54, -25.333}, {61.6, -25.333}, {61.6, -23.333}, {69.2, -23.333}}));
        connect(T3.outPlaces[1], Generation_Cold_Off.inTransition[2]) annotation (
          Line(points = {{69.2, -62}, {47.6, -62}, {47.6, -62}, {24, -62}, {24, -76}, {29.6, -76}, {29.6, -76}, {33.2, -76}}));
        connect(Generation_Cold_II.outTransition[2], T3.inPlaces[1]) annotation (
          Line(points = {{106, -65.2}, {104, -65.2}, {104, -62}, {91.4, -62}, {91.4, -62}, {78.8, -62}}));
        connect(T2.outPlaces[1], Generation_Cold_II.inTransition[2]) annotation (
          Line(points = {{78.8, -82}, {80.4, -82}, {80.4, -82}, {80, -82}, {80, -84}, {106, -84}, {106, -86.8}}));
        connect(Generation_Cold_Off.outTransition[2], T2.inPlaces[1]) annotation (
          Line(points = {{54.8, -76}, {58, -76}, {58, -80}, {69.2, -80}, {69.2, -82}}));
        connect(BKT_Heating_II[5].outTransition[1], T112[5].inPlaces[1]) annotation (
          Line(points = {{-31.2, -34}, {-29.9, -34}, {-29.9, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-69.4, -41.5}, {-69.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
        connect(T118[5].outPlaces[1], BKT_Heating_II[5].inTransition[2]) annotation (
          Line(points = {{-52, -16.8}, {-52, -19.4}, {-52, -19.4}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
        connect(T115[5].outPlaces[1], BKT_Heating_II[5].inTransition[1]) annotation (
          Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-50.4, -34.5}, {-50.4, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
        connect(BKT_Heating_II[5].outTransition[2], T119[5].inPlaces[1]) annotation (
          Line(points = {{-31.2, -34}, {-31.05, -34}, {-31.05, -34}, {-30.9, -34}, {-30.9, -34}, {-30.6, -34}, {-30.6, -34}, {-30, -34}, {-30, -25.75}, {-30, -25.75}, {-30, -22.625}, {-30, -22.625}, {-30, -19.5}}, thickness = 0.5));
        connect(BKT_Heating_II[4].outTransition[1], T112[4].inPlaces[1]) annotation (
          Line(points = {{-31.2, -34}, {-29.4, -34}, {-29.4, -34}, {-29.6, -34}, {-29.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-71.4, -41.5}, {-71.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
        connect(T118[4].outPlaces[1], BKT_Heating_II[4].inTransition[2]) annotation (
          Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.5}}, thickness = 0.5));
        connect(T115[4].outPlaces[1], BKT_Heating_II[4].inTransition[1]) annotation (
          Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
        connect(BKT_Heating_II[3].outTransition[1], T112[3].inPlaces[1]) annotation (
          Line(points = {{-31.2, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-71.4, -41.5}, {-71.4, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
        connect(T118[3].outPlaces[1], BKT_Heating_II[3].inTransition[2]) annotation (
          Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
        connect(T115[3].outPlaces[1], BKT_Heating_II[3].inTransition[1]) annotation (
          Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
        connect(BKT_Heating_II[2].outTransition[1], T112[2].inPlaces[1]) annotation (
          Line(points = {{-31.2, -34}, {-27.9, -34}, {-27.9, -34}, {-30.6, -34}, {-30.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
        connect(T118[2].outPlaces[1], BKT_Heating_II[2].inTransition[2]) annotation (
          Line(points = {{-52, -16.8}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
        connect(T115[2].outPlaces[1], BKT_Heating_II[2].inTransition[1]) annotation (
          Line(points = {{-73.2, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-53.4, -34.5}, {-53.4, -34.5}, {-53.1, -34.5}, {-53.1, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
        connect(BKT_Heating_II[1].outTransition[1], T112[1].inPlaces[1]) annotation (
          Line(points = {{-31.2, -34}, {-27.4, -34}, {-27.4, -34}, {-29.6, -34}, {-29.6, -34}, {-28, -34}, {-28, -45.5}, {-70, -45.5}, {-70, -41.5}, {-71.6, -41.5}, {-71.6, -41.5}, {-73.2, -41.5}}, thickness = 0.5));
        connect(T118[1].outPlaces[1], BKT_Heating_II[1].inTransition[2]) annotation (
          Line(points = {{-52, -16.8}, {-52, -19.4}, {-52, -19.4}, {-52, -22}, {-56, -22}, {-56, -34}, {-52.8, -34}, {-52.8, -33.75}, {-52.8, -33.75}, {-52.8, -33.5}}, thickness = 0.5));
        connect(T115[1].outPlaces[1], BKT_Heating_II[1].inTransition[1]) annotation (
          Line(points = {{-73.2, -22}, {-61.6, -22}, {-61.6, -22}, {-56, -22}, {-56, -34}, {-54, -34}, {-54, -34.5}, {-53.4, -34.5}, {-53.4, -34.5}, {-53.1, -34.5}, {-53.1, -34.5}, {-52.8, -34.5}}, thickness = 0.5));
        connect(T112[5].outPlaces[1], BKT_Off[5].inTransition[2]) annotation (
          Line(points = {{-82.8, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
        connect(T112[4].outPlaces[1], BKT_Off[4].inTransition[2]) annotation (
          Line(points = {{-82.8, -42}, {-114.4, -42}, {-114.4, -42}, {-144, -42}, {-144, -22.8}, {-134.875, -22.8}, {-134.875, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
        connect(T112[3].outPlaces[1], BKT_Off[3].inTransition[2]) annotation (
          Line(points = {{-82.8, -42}, {-113.4, -42}, {-113.4, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
        connect(T112[2].outPlaces[1], BKT_Off[2].inTransition[2]) annotation (
          Line(points = {{-82.8, -42}, {-113.4, -42}, {-113.4, -42}, {-144, -42}, {-144, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
        connect(T112[1].outPlaces[1], BKT_Off[1].inTransition[2]) annotation (
          Line(points = {{-82.8, -42}, {-144, -42}, {-144, -22.8}, {-134.875, -22.8}, {-134.875, -22.8}, {-125.75, -22.8}}, thickness = 0.5));
        connect(BKT_Heating_I[5].outTransition[1], T123[5].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-54.1, 10}, {-54.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
        connect(T123[5].outPlaces[1], BKT_Off[5].inTransition[1]) annotation (
          Line(points = {{-82.8, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
        connect(BKT_Heating_I[4].outTransition[1], T123[4].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-69.4, 17.5}, {-69.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
        connect(T123[4].outPlaces[1], BKT_Off[4].inTransition[1]) annotation (
          Line(points = {{-82.8, 18}, {-90.45, 18}, {-90.45, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
        connect(BKT_Heating_I[3].outTransition[1], T123[3].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-70.4, 17.5}, {-70.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
        connect(T123[3].outPlaces[1], BKT_Off[3].inTransition[1]) annotation (
          Line(points = {{-82.8, 18}, {-97.1, 18}, {-97.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-129.938, -22.8}, {-129.938, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
        connect(BKT_Heating_I[2].outTransition[1], T123[2].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-66.6, 17.5}, {-66.6, 17.5}, {-70.9, 17.5}, {-70.9, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
        connect(T123[2].outPlaces[1], BKT_Off[2].inTransition[1]) annotation (
          Line(points = {{-82.8, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-129.938, -22.8}, {-129.938, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
        connect(BKT_Heating_I[1].outTransition[1], T123[1].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, 17.5}, {-65.6, 17.5}, {-65.6, 17.5}, {-70.4, 17.5}, {-70.4, 17.5}, {-73.2, 17.5}}, thickness = 0.5));
        connect(T123[1].outPlaces[1], BKT_Off[1].inTransition[1]) annotation (
          Line(points = {{-82.8, 18}, {-98.1, 18}, {-98.1, 18}, {-113.4, 18}, {-113.4, 18}, {-144, 18}, {-144, -22.8}, {-134.625, -22.8}, {-134.625, -22.8}, {-125.25, -22.8}}, thickness = 0.5));
        connect(T122[5].outPlaces[1], BKT_Off[5].inTransition[4]) annotation (
          Line(points = {{-167.2, 18}, {-144, 18}, {-144, -22.8}, {-126.75, -22.8}}));
        connect(BKT_Cooling_I[5].outTransition[1], T122[5].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-198.05, 10}, {-198.05, 10}, {-196.9, 10}, {-196.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
        connect(T122[4].outPlaces[1], BKT_Off[4].inTransition[4]) annotation (
          Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-135.375, -22.8}, {-135.375, -22.8}, {-131.062, -22.8}, {-131.062, -22.8}, {-126.75, -22.8}}));
        connect(BKT_Cooling_I[4].outTransition[1], T122[4].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-197.9, 10}, {-197.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-178.95, 18.5}, {-178.95, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
        connect(T122[3].outPlaces[1], BKT_Off[3].inTransition[4]) annotation (
          Line(points = {{-167.2, 18}, {-160.9, 18}, {-160.9, 18}, {-154.6, 18}, {-154.6, 18}, {-144, 18}, {-144, -22.8}, {-132.375, -22.8}, {-132.375, -22.8}, {-126.75, -22.8}}));
        connect(BKT_Cooling_I[3].outTransition[1], T122[3].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-198.9, 10}, {-198.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
        connect(T122[2].outPlaces[1], BKT_Off[2].inTransition[4]) annotation (
          Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-135.375, -22.8}, {-135.375, -22.8}, {-130.062, -22.8}, {-130.062, -22.8}, {-128.406, -22.8}, {-128.406, -22.8}, {-126.75, -22.8}}));
        connect(BKT_Cooling_I[2].outTransition[1], T122[2].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-194.9, 10}, {-194.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-181.1, 18.5}, {-181.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
        connect(T122[1].outPlaces[1], BKT_Off[1].inTransition[4]) annotation (
          Line(points = {{-167.2, 18}, {-155.6, 18}, {-155.6, 18}, {-144, 18}, {-144, -22.8}, {-126.75, -22.8}}));
        connect(BKT_Cooling_I[1].outTransition[1], T122[1].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-198.05, 10}, {-198.05, 10}, {-196.9, 10}, {-196.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, 18.5}, {-185.4, 18.5}, {-185.4, 18.5}, {-178.1, 18.5}, {-178.1, 18.5}, {-176.8, 18.5}}, thickness = 0.5));
        connect(T121[5].outPlaces[1], BKT_Heating_I[5].inTransition[1]) annotation (
          Line(points = {{-73.2, -2}, {-50.6, -2}, {-50.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 11.25}, {-31.2, 11.25}, {-31.2, 10.875}, {-31.2, 10.875}, {-31.2, 10.5}}, thickness = 0.5));
        connect(BKT_Heating_I[5].outTransition[2], T118[5].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
        connect(T119[5].outPlaces[1], BKT_Heating_I[5].inTransition[2]) annotation (
          Line(points = {{-30, -9.2}, {-30, 0.0499998}, {-30, 0.0499998}, {-30, 9.3}, {-30.6, 9.3}, {-30.6, 9.3}, {-30.9, 9.3}, {-30.9, 9.3}, {-31.2, 9.3}}, thickness = 0.5));
        connect(T121[4].outPlaces[1], BKT_Heating_I[4].inTransition[1]) annotation (
          Line(points = {{-73.2, -2}, {-47.6, -2}, {-47.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.25}, {-31.2, 10.25}, {-31.2, 10.5}}, thickness = 0.5));
        connect(BKT_Heating_I[4].outTransition[2], T118[4].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-54.1, 10}, {-54.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
        connect(T121[3].outPlaces[1], BKT_Heating_I[3].inTransition[1]) annotation (
          Line(points = {{-73.2, -2}, {-49.6, -2}, {-49.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 11.25}, {-31.2, 11.25}, {-31.2, 10.5}}, thickness = 0.5));
        connect(BKT_Heating_I[3].outTransition[2], T118[3].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -4.1}, {-52, -4.1}, {-52, -6.7}}, thickness = 0.5));
        connect(T121[2].outPlaces[1], BKT_Heating_I[2].inTransition[1]) annotation (
          Line(points = {{-73.2, -2}, {-58.9, -2}, {-58.9, -2}, {-50.6, -2}, {-50.6, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.5}}, thickness = 0.5));
        connect(BKT_Heating_I[2].outTransition[2], T118[2].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -4.1}, {-52, -4.1}, {-52, -6.7}}, thickness = 0.5));
        connect(T121[1].outPlaces[1], BKT_Heating_I[1].inTransition[1]) annotation (
          Line(points = {{-73.2, -2}, {-28, -2}, {-28, 10}, {-31.2, 10}, {-31.2, 10.25}, {-31.2, 10.25}, {-31.2, 10.5}}, thickness = 0.5));
        connect(BKT_Heating_I[1].outTransition[2], T118[1].inPlaces[1]) annotation (
          Line(points = {{-52.8, 10}, {-55.1, 10}, {-55.1, 10}, {-55.4, 10}, {-55.4, 10}, {-58, 10}, {-58, -1.5}, {-52, -1.5}, {-52, -6.7}}, thickness = 0.5));
        connect(T120[5].outPlaces[1], BKT_Cooling_I[5].inTransition[1]) annotation (
          Line(points = {{-176.8, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.75}, {-220.8, 9.75}, {-220.8, 9.625}, {-220.8, 9.625}, {-220.8, 9.5}}, thickness = 0.5));
        connect(T117[5].outPlaces[1], BKT_Cooling_I[5].inTransition[2]) annotation (
          Line(points = {{-220, -7.2}, {-220, -4.6}, {-220, -4.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
        connect(BKT_Cooling_I[5].outTransition[2], T116[5].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-197.9, 10}, {-197.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -5.1}, {-200, -5.1}, {-200, -6.4}, {-200, -6.4}, {-200, -7.7}}, thickness = 0.5));
        connect(T120[4].outPlaces[1], BKT_Cooling_I[4].inTransition[1]) annotation (
          Line(points = {{-176.8, -2}, {-203.4, -2}, {-203.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.75}, {-220.8, 9.75}, {-220.8, 10.625}, {-220.8, 10.625}, {-220.8, 9.5}}, thickness = 0.5));
        connect(T117[4].outPlaces[1], BKT_Cooling_I[4].inTransition[2]) annotation (
          Line(points = {{-220, -7.2}, {-220, -5.4}, {-220, -5.4}, {-220, -3.6}, {-220, -3.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 11.25}, {-220.8, 11.25}, {-220.8, 10.5}}, thickness = 0.5));
        connect(BKT_Cooling_I[4].outTransition[2], T116[4].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-198.4, 10}, {-198.4, 10}, {-197.6, 10}, {-197.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, 5.9}, {-200, 5.9}, {-200, -0.900002}, {-200, -0.900002}, {-200, -7.7}}, thickness = 0.5));
        connect(T120[3].outPlaces[1], BKT_Cooling_I[3].inTransition[1]) annotation (
          Line(points = {{-176.8, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.5}}, thickness = 0.5));
        connect(T117[3].outPlaces[1], BKT_Cooling_I[3].inTransition[2]) annotation (
          Line(points = {{-220, -7.2}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
        connect(BKT_Cooling_I[3].outTransition[2], T116[3].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-198.4, 10}, {-198.4, 10}, {-197.6, 10}, {-197.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -4.1}, {-200, -4.1}, {-200, -5.9}, {-200, -5.9}, {-200, -7.7}}, thickness = 0.5));
        connect(T120[2].outPlaces[1], BKT_Cooling_I[2].inTransition[1]) annotation (
          Line(points = {{-176.8, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 9.5}}, thickness = 0.5));
        connect(T117[2].outPlaces[1], BKT_Cooling_I[2].inTransition[2]) annotation (
          Line(points = {{-220, -7.2}, {-220, -3.6}, {-220, -3.6}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.25}, {-220.8, 10.25}, {-220.8, 10.5}}, thickness = 0.5));
        connect(BKT_Cooling_I[2].outTransition[2], T116[2].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-198.9, 10}, {-198.9, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -5.1}, {-200, -5.1}, {-200, -6.4}, {-200, -6.4}, {-200, -7.05}, {-200, -7.05}, {-200, -7.7}}, thickness = 0.5));
        connect(T120[1].outPlaces[1], BKT_Cooling_I[1].inTransition[1]) annotation (
          Line(points = {{-176.8, -2}, {-189.6, -2}, {-189.6, -2}, {-202.4, -2}, {-202.4, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 10.75}, {-220.8, 10.75}, {-220.8, 10.125}, {-220.8, 10.125}, {-220.8, 9.5}}, thickness = 0.5));
        connect(T117[1].outPlaces[1], BKT_Cooling_I[1].inTransition[2]) annotation (
          Line(points = {{-220, -7.2}, {-220, -2}, {-228, -2}, {-228, 10}, {-220.8, 10}, {-220.8, 11.25}, {-220.8, 11.25}, {-220.8, 10.5}}, thickness = 0.5));
        connect(BKT_Cooling_I[1].outTransition[2], T116[1].inPlaces[1]) annotation (
          Line(points = {{-199.2, 10}, {-196.6, 10}, {-196.6, 10}, {-194, 10}, {-194, -2.5}, {-200, -2.5}, {-200, -4.1}, {-200, -4.1}, {-200, -7.7}}, thickness = 0.5));
        connect(BKT_Off[5].outTransition[1], T121[5].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-87.15, -2}, {-87.15, -2}, {-85.35, -2}, {-85.35, -2}, {-83.55, -2}}, thickness = 0.5));
        connect(BKT_Off[4].outTransition[1], T121[4].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-85.85, -2}, {-85.85, -2}, {-83.55, -2}}, thickness = 0.5));
        connect(BKT_Off[3].outTransition[1], T121[3].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-109.375, -1.2}, {-109.375, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-82.85, -2}, {-82.85, -2}, {-83.55, -2}}, thickness = 0.5));
        connect(BKT_Off[2].outTransition[1], T121[2].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-88.15, -2}, {-88.15, -2}, {-84.85, -2}, {-84.85, -2}, {-83.55, -2}}, thickness = 0.5));
        connect(BKT_Off[1].outTransition[1], T121[1].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-90.75, -1.2}, {-90.75, -2}, {-83.55, -2}}, thickness = 0.5));
        connect(BKT_Off[5].outTransition[3], T120[5].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
        connect(BKT_Off[4].outTransition[3], T120[4].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-126.875, -1.2}, {-126.875, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -1.5}, {-166.95, -1.5}, {-166.95, -2}}));
        connect(BKT_Off[3].outTransition[3], T120[3].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
        connect(BKT_Off[2].outTransition[3], T120[2].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
        connect(BKT_Off[1].outTransition[3], T120[1].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-125.938, -1.2}, {-125.938, -1.2}, {-125.875, -1.2}, {-125.875, -1.2}, {-127.75, -1.2}, {-127.75, 8.10623e-07}, {-166.95, 8.10623e-07}, {-166.95, -0.999999}, {-166.95, -0.999999}, {-166.95, -2}}));
        connect(T113[5].outPlaces[1], BKT_Off[5].inTransition[3]) annotation (
          Line(points = {{-167.2, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
        connect(BKT_Off[5].outTransition[4], T114[5].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-166.45, -22}}));
        connect(BKT_Off[5].outTransition[2], T115[5].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-109.125, -1.2}, {-109.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-85.35, -22}, {-85.35, -22}, {-85.2, -22}, {-85.2, -22}, {-83.05, -22}}, thickness = 0.5));
        connect(T113[4].outPlaces[1], BKT_Off[4].inTransition[3]) annotation (
          Line(points = {{-167.2, -42}, {-161.4, -42}, {-161.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-134.125, -22.8}, {-134.125, -22.8}, {-126.25, -22.8}}));
        connect(BKT_Off[4].outTransition[4], T114[4].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-129.812, -1.2}, {-129.812, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-166.45, -22}}));
        connect(BKT_Off[4].outTransition[2], T115[4].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-85.35, -22}, {-85.35, -22}, {-83.05, -22}}, thickness = 0.5));
        connect(T113[3].outPlaces[1], BKT_Off[3].inTransition[3]) annotation (
          Line(points = {{-167.2, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
        connect(BKT_Off[3].outTransition[4], T114[3].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-164.15, -22}, {-164.15, -22}, {-166.45, -22}}));
        connect(BKT_Off[3].outTransition[2], T115[3].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-110.125, -1.2}, {-110.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-83.05, -22}}, thickness = 0.5));
        connect(T113[2].outPlaces[1], BKT_Off[2].inTransition[3]) annotation (
          Line(points = {{-167.2, -42}, {-162.8, -42}, {-162.8, -42}, {-158.4, -42}, {-158.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-127.687, -22.8}, {-127.687, -22.8}, {-126.25, -22.8}}));
        connect(BKT_Off[2].outTransition[4], T114[2].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-129.812, -1.2}, {-129.812, -1.2}, {-133.625, -1.2}, {-133.625, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-166.45, -22}}));
        connect(BKT_Off[2].outTransition[2], T115[2].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-109.125, -1.2}, {-109.125, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-84.35, -22}, {-84.35, -22}, {-83.05, -22}}, thickness = 0.5));
        connect(T113[1].outPlaces[1], BKT_Off[1].inTransition[3]) annotation (
          Line(points = {{-167.2, -42}, {-161.4, -42}, {-161.4, -42}, {-155.6, -42}, {-155.6, -42}, {-144, -42}, {-144, -22.8}, {-135.125, -22.8}, {-135.125, -22.8}, {-130.687, -22.8}, {-130.687, -22.8}, {-126.25, -22.8}}));
        connect(BKT_Off[1].outTransition[4], T114[1].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-141.25, -1.2}, {-141.25, 8.10623e-07}, {-157.25, 8.10623e-07}, {-157.25, -22}, {-161.85, -22}, {-161.85, -22}, {-166.45, -22}}));
        connect(BKT_Off[1].outTransition[2], T115[1].inPlaces[1]) annotation (
          Line(points = {{-126, -1.2}, {-92.25, -1.2}, {-92.25, -22}, {-87.65, -22}, {-87.65, -22}, {-83.05, -22}}, thickness = 0.5));
        connect(BKT_Cooling_II[5].outTransition[2], T117[5].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -16.3}}, thickness = 0.5));
        connect(BKT_Cooling_II[4].outTransition[2], T117[4].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -16.3}}, thickness = 0.5));
        connect(BKT_Cooling_II[3].outTransition[2], T117[3].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -17.9}, {-220, -17.9}, {-220, -17.1}, {-220, -17.1}, {-220, -16.3}}, thickness = 0.5));
        connect(BKT_Cooling_II[2].outTransition[2], T117[2].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -16.3}}, thickness = 0.5));
        connect(BKT_Cooling_II[1].outTransition[2], T117[1].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -19.5}, {-220, -19.5}, {-220, -16.3}}, thickness = 0.5));
        connect(T116[5].outPlaces[1], BKT_Cooling_II[5].inTransition[2]) annotation (
          Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
        connect(T116[4].outPlaces[1], BKT_Cooling_II[4].inTransition[2]) annotation (
          Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
        connect(T116[3].outPlaces[1], BKT_Cooling_II[3].inTransition[2]) annotation (
          Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
        connect(T116[2].outPlaces[1], BKT_Cooling_II[2].inTransition[2]) annotation (
          Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.25}, {-199.2, -34.25}, {-199.2, -34.5}}, thickness = 0.5));
        connect(T116[1].outPlaces[1], BKT_Cooling_II[1].inTransition[2]) annotation (
          Line(points = {{-200, -16.8}, {-200, -22}, {-194, -22}, {-194, -34}, {-199.2, -34}, {-199.2, -34.5}}, thickness = 0.5));
        connect(T114[5].outPlaces[1], BKT_Cooling_II[5].inTransition[1]) annotation (
          Line(points = {{-176.8, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
        connect(BKT_Cooling_II[5].outTransition[1], T113[5].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
        connect(T114[4].outPlaces[1], BKT_Cooling_II[4].inTransition[1]) annotation (
          Line(points = {{-176.8, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-199.9, -33.5}, {-199.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
        connect(BKT_Cooling_II[4].outTransition[1], T113[4].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-221.6, -34}, {-221.6, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
        connect(T114[3].outPlaces[1], BKT_Cooling_II[3].inTransition[1]) annotation (
          Line(points = {{-176.8, -22}, {-181.1, -22}, {-181.1, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
        connect(BKT_Cooling_II[3].outTransition[1], T113[3].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-221.6, -34}, {-221.6, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
        connect(T114[2].outPlaces[1], BKT_Cooling_II[2].inTransition[1]) annotation (
          Line(points = {{-176.8, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-199.9, -33.5}, {-199.9, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
        connect(BKT_Cooling_II[2].outTransition[1], T113[2].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-223.4, -34}, {-223.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-180.6, -42.5}, {-180.6, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
        connect(T114[1].outPlaces[1], BKT_Cooling_II[1].inTransition[1]) annotation (
          Line(points = {{-176.8, -22}, {-177.45, -22}, {-177.45, -22}, {-178.1, -22}, {-178.1, -22}, {-185.4, -22}, {-185.4, -22}, {-194, -22}, {-194, -34}, {-198, -34}, {-198, -33.5}, {-198.6, -33.5}, {-198.6, -33.5}, {-198.9, -33.5}, {-198.9, -33.5}, {-199.05, -33.5}, {-199.05, -33.5}, {-199.2, -33.5}}, thickness = 0.5));
        connect(BKT_Cooling_II[1].outTransition[1], T113[1].inPlaces[1]) annotation (
          Line(points = {{-220.8, -34}, {-222.4, -34}, {-222.4, -34}, {-224, -34}, {-224, -48.5}, {-188, -48.5}, {-188, -42.5}, {-182.4, -42.5}, {-182.4, -42.5}, {-179.6, -42.5}, {-179.6, -42.5}, {-176.8, -42.5}}, thickness = 0.5));
        connect(T111[6].outPlaces[1], RLT_Cooling_II[6].inTransition[2]) annotation (
          Line(points = {{-202, 83.2}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[6].outTransition[2], T111[6].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-200.9, 112}, {-200.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 97.1}, {-202, 97.1}, {-202, 92.3}}, thickness = 0.5));
        connect(T111[5].outPlaces[1], RLT_Cooling_II[5].inTransition[2]) annotation (
          Line(points = {{-202, 83.2}, {-202, 81.9}, {-202, 81.9}, {-202, 80.6}, {-202, 80.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[5].outTransition[2], T111[5].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-199.9, 112}, {-199.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 98.1}, {-202, 98.1}, {-202, 92.3}}, thickness = 0.5));
        connect(T111[4].outPlaces[1], RLT_Cooling_II[4].inTransition[2]) annotation (
          Line(points = {{-202, 83.2}, {-202, 83.4}, {-202, 83.4}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-202.4, 65.5}, {-202.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[4].outTransition[2], T111[4].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-200.9, 112}, {-200.9, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 94.9}, {-202, 94.9}, {-202, 93.6}, {-202, 93.6}, {-202, 92.3}}, thickness = 0.5));
        connect(T111[3].outPlaces[1], RLT_Cooling_II[3].inTransition[2]) annotation (
          Line(points = {{-202, 83.2}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.4, 65.5}, {-201.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[3].outTransition[2], T111[3].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-198.6, 112}, {-198.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 101.9}, {-202, 101.9}, {-202, 97.1}, {-202, 97.1}, {-202, 92.3}}, thickness = 0.5));
        connect(T111[2].outPlaces[1], RLT_Cooling_II[2].inTransition[2]) annotation (
          Line(points = {{-202, 83.2}, {-202, 83.4}, {-202, 83.4}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[2].outTransition[2], T111[2].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-199.4, 112}, {-199.4, 112}, {-197.6, 112}, {-197.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 95.9}, {-202, 95.9}, {-202, 95.1}, {-202, 95.1}, {-202, 92.3}}, thickness = 0.5));
        connect(T111[1].outPlaces[1], RLT_Cooling_II[1].inTransition[2]) annotation (
          Line(points = {{-202, 83.2}, {-202, 81.6}, {-202, 81.6}, {-202, 78}, {-196, 78}, {-196, 66}, {-202, 66}, {-202, 65.5}, {-201.6, 65.5}, {-201.6, 65.5}, {-201.4, 65.5}, {-201.4, 65.5}, {-201.2, 65.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[1].outTransition[2], T111[1].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-197.6, 112}, {-197.6, 112}, {-196, 112}, {-196, 97.5}, {-202, 97.5}, {-202, 95.9}, {-202, 95.9}, {-202, 92.3}}, thickness = 0.5));
        connect(RLT_Cooling_II[6].outTransition[2], T110[6].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 81.9}, {-222, 81.9}, {-222, 83.7}}, thickness = 0.5));
        connect(T110[6].outPlaces[1], RLT_Cooling_I[6].inTransition[2]) annotation (
          Line(points = {{-222, 92.8}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[5].outTransition[2], T110[5].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 83.7}}, thickness = 0.5));
        connect(T110[5].outPlaces[1], RLT_Cooling_I[5].inTransition[2]) annotation (
          Line(points = {{-222, 92.8}, {-222, 95.4}, {-222, 95.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[4].outTransition[2], T110[4].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.9}, {-222, 83.9}, {-222, 83.7}}, thickness = 0.5));
        connect(T110[4].outPlaces[1], RLT_Cooling_I[4].inTransition[2]) annotation (
          Line(points = {{-222, 92.8}, {-222, 96.4}, {-222, 96.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-223.6, 112.5}, {-223.6, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[3].outTransition[2], T110[3].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.7}}, thickness = 0.5));
        connect(T110[3].outPlaces[1], RLT_Cooling_I[3].inTransition[2]) annotation (
          Line(points = {{-222, 92.8}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[2].outTransition[2], T110[2].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 82.1}, {-222, 82.1}, {-222, 83.9}, {-222, 83.9}, {-222, 83.7}}, thickness = 0.5));
        connect(T110[2].outPlaces[1], RLT_Cooling_I[2].inTransition[2]) annotation (
          Line(points = {{-222, 92.8}, {-222, 95.4}, {-222, 95.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[1].outTransition[2], T110[1].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 78.5}, {-222, 78.5}, {-222, 80.1}, {-222, 80.1}, {-222, 81.9}, {-222, 81.9}, {-222, 83.7}}, thickness = 0.5));
        connect(T110[1].outPlaces[1], RLT_Cooling_I[1].inTransition[2]) annotation (
          Line(points = {{-222, 92.8}, {-222, 96.4}, {-222, 96.4}, {-222, 98}, {-226, 98}, {-226, 112.5}, {-224.4, 112.5}, {-224.4, 112.5}, {-223.6, 112.5}, {-223.6, 112.5}, {-222.8, 112.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[6].outTransition[1], T19[6].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-182.4, 57.5}, {-182.4, 57.5}, {-181.6, 57.5}, {-181.6, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
        connect(T19[6].outPlaces[1], RLT_Cooling_Off[6].inTransition[2]) annotation (
          Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[5].outTransition[1], T19[5].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
        connect(T19[5].outPlaces[1], RLT_Cooling_Off[5].inTransition[2]) annotation (
          Line(points = {{-169.2, 58}, {-159.4, 58}, {-159.4, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[4].outTransition[1], T19[4].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-224.4, 66}, {-224.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-182.4, 57.5}, {-182.4, 57.5}, {-180.6, 57.5}, {-180.6, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
        connect(T19[4].outPlaces[1], RLT_Cooling_Off[4].inTransition[2]) annotation (
          Line(points = {{-169.2, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[3].outTransition[1], T19[3].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-181.1, 57.5}, {-181.1, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
        connect(T19[3].outPlaces[1], RLT_Cooling_Off[3].inTransition[2]) annotation (
          Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[2].outTransition[1], T19[2].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
        connect(T19[2].outPlaces[1], RLT_Cooling_Off[2].inTransition[2]) annotation (
          Line(points = {{-169.2, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
        connect(RLT_Cooling_II[1].outTransition[1], T19[1].inPlaces[1]) annotation (
          Line(points = {{-222.8, 66}, {-224.1, 66}, {-224.1, 66}, {-225.4, 66}, {-225.4, 66}, {-228, 66}, {-228, 53.5}, {-188, 53.5}, {-188, 57.5}, {-183.4, 57.5}, {-183.4, 57.5}, {-178.8, 57.5}}, thickness = 0.5));
        connect(T19[1].outPlaces[1], RLT_Cooling_Off[1].inTransition[2]) annotation (
          Line(points = {{-169.2, 58}, {-149.6, 58}, {-149.6, 58}, {-130, 58}, {-130, 87.5}, {-135.2, 87.5}}, thickness = 0.5));
        connect(T18[6].outPlaces[1], RLT_Cooling_II[6].inTransition[1]) annotation (
          Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[6].outTransition[2], T18[6].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-167.9, 78.5}, {-167.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
        connect(T18[5].outPlaces[1], RLT_Cooling_II[5].inTransition[1]) annotation (
          Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[5].outTransition[2], T18[5].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-167.9, 78.5}, {-167.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
        connect(T18[4].outPlaces[1], RLT_Cooling_II[4].inTransition[1]) annotation (
          Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.9, 66.5}, {-201.9, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[4].outTransition[2], T18[4].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-158.6, 88}, {-158.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
        connect(T18[3].outPlaces[1], RLT_Cooling_II[3].inTransition[1]) annotation (
          Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[3].outTransition[2], T18[3].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-158.6, 88}, {-158.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-166.9, 78.5}, {-166.9, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
        connect(T18[2].outPlaces[1], RLT_Cooling_II[2].inTransition[1]) annotation (
          Line(points = {{-178.8, 78}, {-184.1, 78}, {-184.1, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[2].outTransition[2], T18[2].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
        connect(T18[1].outPlaces[1], RLT_Cooling_II[1].inTransition[1]) annotation (
          Line(points = {{-178.8, 78}, {-187.4, 78}, {-187.4, 78}, {-196, 78}, {-196, 66}, {-200, 66}, {-200, 66.5}, {-200.6, 66.5}, {-200.6, 66.5}, {-201.2, 66.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[1].outTransition[2], T18[1].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 78.5}, {-164.6, 78.5}, {-164.6, 78.5}, {-169.2, 78.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[6].outTransition[1], T17[6].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-157.6, 88}, {-157.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-163.6, 97.5}, {-163.6, 97.5}, {-167.4, 97.5}, {-167.4, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
        connect(T17[6].outPlaces[1], RLT_Cooling_I[6].inTransition[1]) annotation (
          Line(points = {{-178.8, 98}, {-190.6, 98}, {-190.6, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[5].outTransition[1], T17[5].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-167.9, 97.5}, {-167.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
        connect(T17[5].outPlaces[1], RLT_Cooling_I[5].inTransition[1]) annotation (
          Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[4].outTransition[1], T17[4].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-157.6, 88}, {-157.6, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
        connect(T17[4].outPlaces[1], RLT_Cooling_I[4].inTransition[1]) annotation (
          Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[3].outTransition[1], T17[3].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-158.4, 88}, {-158.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
        connect(T17[3].outPlaces[1], RLT_Cooling_I[3].inTransition[1]) annotation (
          Line(points = {{-178.8, 98}, {-190.6, 98}, {-190.6, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[2].outTransition[1], T17[2].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
        connect(T17[2].outPlaces[1], RLT_Cooling_I[2].inTransition[1]) annotation (
          Line(points = {{-178.8, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
        connect(RLT_Cooling_Off[1].outTransition[1], T17[1].inPlaces[1]) annotation (
          Line(points = {{-156.8, 88}, {-157.4, 88}, {-157.4, 88}, {-160, 88}, {-160, 97.5}, {-164.6, 97.5}, {-164.6, 97.5}, {-166.9, 97.5}, {-166.9, 97.5}, {-169.2, 97.5}}, thickness = 0.5));
        connect(T17[1].outPlaces[1], RLT_Cooling_I[1].inTransition[1]) annotation (
          Line(points = {{-178.8, 98}, {-202.4, 98}, {-202.4, 98}, {-226, 98}, {-226, 111.5}, {-224.4, 111.5}, {-224.4, 111.5}, {-223.6, 111.5}, {-223.6, 111.5}, {-222.8, 111.5}}, thickness = 0.5));
        connect(T16[6].outPlaces[1], RLT_Cooling_Off[6].inTransition[1]) annotation (
          Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
        connect(T16[5].outPlaces[1], RLT_Cooling_Off[5].inTransition[1]) annotation (
          Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
        connect(T16[4].outPlaces[1], RLT_Cooling_Off[4].inTransition[1]) annotation (
          Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
        connect(T16[3].outPlaces[1], RLT_Cooling_Off[3].inTransition[1]) annotation (
          Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
        connect(T16[2].outPlaces[1], RLT_Cooling_Off[2].inTransition[1]) annotation (
          Line(points = {{-169.2, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-133.9, 88.5}, {-133.9, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
        connect(T16[1].outPlaces[1], RLT_Cooling_Off[1].inTransition[1]) annotation (
          Line(points = {{-169.2, 118}, {-149.6, 118}, {-149.6, 118}, {-130, 118}, {-130, 88.5}, {-132.6, 88.5}, {-132.6, 88.5}, {-135.2, 88.5}}, thickness = 0.5));
        connect(RLT_Heating_I[6].outTransition[2], T14[6].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
        connect(T14[6].outPlaces[1], RLT_Heating_II[6].inTransition[2]) annotation (
          Line(points = {{-54, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
        connect(RLT_Heating_I[5].outTransition[2], T14[5].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
        connect(T14[5].outPlaces[1], RLT_Heating_II[5].inTransition[2]) annotation (
          Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
        connect(RLT_Heating_I[4].outTransition[2], T14[4].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
        connect(T14[4].outPlaces[1], RLT_Heating_II[4].inTransition[2]) annotation (
          Line(points = {{-54, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-55.1, 66.5}, {-55.1, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
        connect(RLT_Heating_I[3].outTransition[2], T14[3].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
        connect(T14[3].outPlaces[1], RLT_Heating_II[3].inTransition[2]) annotation (
          Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
        connect(RLT_Heating_I[2].outTransition[2], T14[2].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 93.3}}, thickness = 0.5));
        connect(T14[2].outPlaces[1], RLT_Heating_II[2].inTransition[2]) annotation (
          Line(points = {{-54, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
        connect(RLT_Heating_I[1].outTransition[2], T14[1].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-54.6, 110}, {-54.6, 110}, {-54.4, 110}, {-54.4, 110}, {-54, 110}, {-54, 101.65}, {-54, 101.65}, {-54, 93.3}}, thickness = 0.5));
        connect(T14[1].outPlaces[1], RLT_Heating_II[1].inTransition[2]) annotation (
          Line(points = {{-54, 83.2}, {-55.5, 83.2}, {-55.5, 83.2}, {-55, 83.2}, {-55, 83.2}, {-56, 83.2}, {-56, 66.5}, {-55.4, 66.5}, {-55.4, 66.5}, {-54.8, 66.5}}, thickness = 0.5));
        connect(RLT_Heating_II[6].outTransition[2], T15[6].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
        connect(T15[6].outPlaces[1], RLT_Heating_I[6].inTransition[2]) annotation (
          Line(points = {{-34, 92.8}, {-34, 95.3}, {-34, 95.3}, {-34, 97.8}, {-33.2, 97.8}, {-33.2, 104.55}, {-33.2, 104.55}, {-33.2, 109.3}}, thickness = 0.5));
        connect(RLT_Heating_II[5].outTransition[2], T15[5].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
        connect(T15[5].outPlaces[1], RLT_Heating_I[5].inTransition[2]) annotation (
          Line(points = {{-34, 92.8}, {-34, 97.3}, {-34, 97.3}, {-34, 101.8}, {-33.2, 101.8}, {-33.2, 109.3}}, thickness = 0.5));
        connect(RLT_Heating_II[4].outTransition[2], T15[4].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
        connect(T15[4].outPlaces[1], RLT_Heating_I[4].inTransition[2]) annotation (
          Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
        connect(RLT_Heating_II[3].outTransition[2], T15[3].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
        connect(T15[3].outPlaces[1], RLT_Heating_I[3].inTransition[2]) annotation (
          Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
        connect(RLT_Heating_II[2].outTransition[2], T15[2].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
        connect(T15[2].outPlaces[1], RLT_Heating_I[2].inTransition[2]) annotation (
          Line(points = {{-34, 92.8}, {-34, 101.05}, {-34, 101.05}, {-34, 109.3}, {-33.6, 109.3}, {-33.6, 109.3}, {-33.2, 109.3}}, thickness = 0.5));
        connect(RLT_Heating_II[1].outTransition[2], T15[1].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 68}, {-34, 68}, {-34, 83}}, thickness = 0.5));
        connect(T15[1].outPlaces[1], RLT_Heating_I[1].inTransition[2]) annotation (
          Line(points = {{-34, 92.8}, {-34, 109.8}, {-33.2, 109.8}, {-33.2, 109.3}}, thickness = 0.5));
        connect(RLT_Heating_II[6].outTransition[1], T13[6].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.4, 66}, {-33.4, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
        connect(T13[6].outPlaces[1], RLT_Heating_Off[6].inTransition[2]) annotation (
          Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
        connect(RLT_Heating_II[5].outTransition[1], T13[5].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
        connect(T13[5].outPlaces[1], RLT_Heating_Off[5].inTransition[2]) annotation (
          Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
        connect(RLT_Heating_II[4].outTransition[1], T13[4].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
        connect(T13[4].outPlaces[1], RLT_Heating_Off[4].inTransition[2]) annotation (
          Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
        connect(RLT_Heating_II[3].outTransition[1], T13[3].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
        connect(T13[3].outPlaces[1], RLT_Heating_Off[3].inTransition[2]) annotation (
          Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-122.4, 88.5}, {-122.4, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
        connect(RLT_Heating_II[2].outTransition[1], T13[2].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-74.4, 58.5}, {-74.4, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
        connect(T13[2].outPlaces[1], RLT_Heating_Off[2].inTransition[2]) annotation (
          Line(points = {{-84.8, 58}, {-104.4, 58}, {-104.4, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
        connect(RLT_Heating_II[1].outTransition[1], T13[1].inPlaces[1]) annotation (
          Line(points = {{-33.2, 66}, {-33.6, 66}, {-33.6, 66}, {-34, 66}, {-34, 52.5}, {-72, 52.5}, {-72, 58.5}, {-73.6, 58.5}, {-73.6, 58.5}, {-74.4, 58.5}, {-74.4, 58.5}, {-75.2, 58.5}}, thickness = 0.5));
        connect(T13[1].outPlaces[1], RLT_Heating_Off[1].inTransition[2]) annotation (
          Line(points = {{-84.8, 58}, {-124, 58}, {-124, 88.5}, {-120.8, 88.5}}, thickness = 0.5));
        connect(T12[6].outPlaces[1], RLT_Heating_II[6].inTransition[1]) annotation (
          Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 66.75}, {-54.8, 66.75}, {-54.8, 65.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[6].outTransition[2], T12[6].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
        connect(T12[5].outPlaces[1], RLT_Heating_II[5].inTransition[1]) annotation (
          Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 65.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[5].outTransition[2], T12[5].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
        connect(T12[4].outPlaces[1], RLT_Heating_II[4].inTransition[1]) annotation (
          Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 65.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[4].outTransition[2], T12[4].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-98.4, 88}, {-98.4, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
        connect(T12[3].outPlaces[1], RLT_Heating_II[3].inTransition[1]) annotation (
          Line(points = {{-75.2, 78}, {-66.6, 78}, {-66.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 65.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[3].outTransition[2], T12[3].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
        connect(T12[2].outPlaces[1], RLT_Heating_II[2].inTransition[1]) annotation (
          Line(points = {{-75.2, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 66.625}, {-54.8, 66.625}, {-54.8, 65.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[2].outTransition[2], T12[2].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
        connect(T12[1].outPlaces[1], RLT_Heating_II[1].inTransition[1]) annotation (
          Line(points = {{-75.2, 78}, {-70.4, 78}, {-70.4, 78}, {-65.6, 78}, {-65.6, 78}, {-56, 78}, {-56, 66}, {-54.8, 66}, {-54.8, 67.75}, {-54.8, 67.75}, {-54.8, 67.625}, {-54.8, 67.625}, {-54.8, 65.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[1].outTransition[2], T12[1].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 90}, {-92, 90}, {-92, 79.5}, {-88.4, 79.5}, {-88.4, 77.5}, {-86.6, 77.5}, {-86.6, 77.5}, {-84.8, 77.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[6].outTransition[1], T1[6].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
        connect(T1[6].outPlaces[1], RLT_Heating_I[6].inTransition[1]) annotation (
          Line(points = {{-75.2, 98}, {-52.6, 98}, {-52.6, 98}, {-30, 98}, {-30, 110.5}, {-32.6, 110.5}, {-32.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[5].outTransition[1], T1[5].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
        connect(T1[5].outPlaces[1], RLT_Heating_I[5].inTransition[1]) annotation (
          Line(points = {{-75.2, 98}, {-63.9, 98}, {-63.9, 98}, {-52.6, 98}, {-52.6, 98}, {-30, 98}, {-30, 110.5}, {-32.6, 110.5}, {-32.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[4].outTransition[1], T1[4].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
        connect(T1[4].outPlaces[1], RLT_Heating_I[4].inTransition[1]) annotation (
          Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[3].outTransition[1], T1[3].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
        connect(T1[3].outPlaces[1], RLT_Heating_I[3].inTransition[1]) annotation (
          Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[2].outTransition[1], T1[2].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-86.6, 98.5}, {-86.6, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
        connect(T1[2].outPlaces[1], RLT_Heating_I[2].inTransition[1]) annotation (
          Line(points = {{-75.2, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
        connect(RLT_Heating_Off[1].outTransition[1], T1[1].inPlaces[1]) annotation (
          Line(points = {{-99.2, 88}, {-97.4, 88}, {-97.4, 88}, {-95.6, 88}, {-95.6, 88}, {-92, 88}, {-92, 98.5}, {-88.4, 98.5}, {-88.4, 98.5}, {-86.6, 98.5}, {-86.6, 98.5}, {-84.8, 98.5}}, thickness = 0.5));
        connect(T1[1].outPlaces[1], RLT_Heating_I[1].inTransition[1]) annotation (
          Line(points = {{-75.2, 98}, {-53.6, 98}, {-53.6, 98}, {-30, 98}, {-30, 110.5}, {-31.6, 110.5}, {-31.6, 110.5}, {-33.2, 110.5}}, thickness = 0.5));
        connect(T11[6].outPlaces[1], RLT_Heating_Off[6].inTransition[1]) annotation (
          Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
        connect(T11[5].outPlaces[1], RLT_Heating_Off[5].inTransition[1]) annotation (
          Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
        connect(T11[4].outPlaces[1], RLT_Heating_Off[4].inTransition[1]) annotation (
          Line(points = {{-84.8, 118}, {-105.4, 118}, {-105.4, 118}, {-124, 118}, {-124, 87.5}, {-122.4, 87.5}, {-122.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
        connect(T11[3].outPlaces[1], RLT_Heating_Off[3].inTransition[1]) annotation (
          Line(points = {{-84.8, 118}, {-95.6, 118}, {-95.6, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
        connect(T11[2].outPlaces[1], RLT_Heating_Off[2].inTransition[1]) annotation (
          Line(points = {{-84.8, 118}, {-105.4, 118}, {-105.4, 118}, {-124, 118}, {-124, 87.5}, {-122.4, 87.5}, {-122.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
        connect(T11[1].outPlaces[1], RLT_Heating_Off[1].inTransition[1]) annotation (
          Line(points = {{-84.8, 118}, {-104.4, 118}, {-104.4, 118}, {-124, 118}, {-124, 87.5}, {-123.4, 87.5}, {-123.4, 87.5}, {-120.8, 87.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[6].outTransition[1], T16[6].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[5].outTransition[1], T16[5].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-184.4, 118.5}, {-184.4, 118.5}, {-181.6, 118.5}, {-181.6, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[4].outTransition[1], T16[4].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[3].outTransition[1], T16[3].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-184.4, 118.5}, {-184.4, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[2].outTransition[1], T16[2].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
        connect(RLT_Cooling_I[1].outTransition[1], T16[1].inPlaces[1]) annotation (
          Line(points = {{-201.2, 112}, {-198.4, 112}, {-198.4, 112}, {-195.6, 112}, {-195.6, 112}, {-190, 112}, {-190, 118.5}, {-183.4, 118.5}, {-183.4, 118.5}, {-181.1, 118.5}, {-181.1, 118.5}, {-178.8, 118.5}}, thickness = 0.5));
        connect(RLT_Heating_I[6].outTransition[1], T11[6].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-60.4, 110}, {-60.4, 110}, {-64, 110}, {-64, 117.5}, {-69.6, 117.5}, {-69.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
        connect(RLT_Heating_I[5].outTransition[1], T11[5].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
        connect(RLT_Heating_I[4].outTransition[1], T11[4].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
        connect(RLT_Heating_I[3].outTransition[1], T11[3].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-59.4, 110}, {-59.4, 110}, {-64, 110}, {-64, 117.5}, {-70.6, 117.5}, {-70.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
        connect(RLT_Heating_I[2].outTransition[1], T11[2].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-60.4, 110}, {-60.4, 110}, {-64, 110}, {-64, 117.5}, {-69.6, 117.5}, {-69.6, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
        connect(RLT_Heating_I[1].outTransition[1], T11[1].inPlaces[1]) annotation (
          Line(points = {{-54.8, 110}, {-64, 110}, {-64, 117.5}, {-75.2, 117.5}}, thickness = 0.5));
        annotation (
          Icon(graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                           FillPattern.Solid,
                  lineThickness =                                                                                                            0.5, extent = {{-250, 150}, {250, -150}}), Text(origin = {0, -6}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-250, 50}, {250, -46}}, textString = "Automation 
 Level")}, coordinateSystem(extent = {{-250, -150}, {250, 150}}, initialScale = 0.1)),
          Diagram(graphics = {Text(origin = {-177, 139}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_RLT_cooling"), Text(origin = {-77, 139}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_RLT_heating"), Text(origin = {-131, 31}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_BKT"), Text(origin = {69, 133}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_HTSsystem"), Text(origin = {195, 129}, extent = {{-27, 5}, {27, -5}}, textString = "MODI_selection_HPsystem_warm")}, coordinateSystem(extent = {{-250, -150}, {250, 150}})),
          __OpenModelica_commandLineOptions = "");
      end AutomationLevel_V1;

      model AutomationLevel_V2
        PNlib.Components.PD HTS_Heating_II(nIn = 2, nOut = 2, startTokens = 0, minTokens = 0, maxTokens = 1, reStartTokens = 0, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1, 2}, enablingPrioOut = {1, 2}) annotation (
          Placement(visible = true, transformation(origin = {-54, 44}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.T T1(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation (
          Placement(visible = true, transformation(origin = {-73, 79}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.PD HTS_Heating_I(nIn = 2, nOut = 2, startTokens = 0, minTokens = 0, maxTokens = 1, reStartTokens = 0, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1, 2}, enablingPrioOut = {1, 2}) annotation (
          Placement(visible = true, transformation(origin = {-54, 72}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.PD HTS_Off(nIn = 2, nOut = 2, startTokens = 1, minTokens = 0, maxTokens = 1, reStart = true, reStartTokens = 1, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1, 2}, enablingPrioOut = {1, 2}) annotation (
          Placement(visible = true, transformation(origin = {-88, 58}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        PNlib.Components.T T11(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] and TAirOutside > 283.15 "and weaBus.DryBulbTemp>283.15") annotation (
          Placement(visible = true, transformation(origin = {-73, 65}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.T T12(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] and TAirOutside <= 283.15 "and weaBus.DryBulbTemp<=283.15") annotation (
          Placement(visible = true, transformation(origin = {-73, 51}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.T T13(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation (
          Placement(visible = true, transformation(origin = {-73, 37}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.T T14(nIn = 1, nOut = 1, firingCon = TAirOutside <= 283.15 ", firingCon= weaBus.DryBulbTemp<=283.15") annotation (
          Placement(visible = true, transformation(origin = {-47, 57}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
        PNlib.Components.T T15(nIn = 1, nOut = 1, firingCon = TAirOutside > 283.15 ", firingCon=weaBus.DryBulbTemp>283.15") annotation (
          Placement(visible = true, transformation(origin = {-61, 57}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
        PNlib.Components.T T16(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation (
          Placement(visible = true, transformation(origin = {59, 39}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.PD HP_Heating_II(nIn = 2, nOut = 2, startTokens = 0, minTokens = 0, maxTokens = 1, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1, 2}, enablingPrioOut = {1, 2}) annotation (
          Placement(visible = true, transformation(origin = {78, 46}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.T T17(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] "and weaBus.DryBulbTemp>283.15") annotation (
          Placement(visible = true, transformation(origin = {59, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.T T18(nIn = 1, nOut = 1, firingCon = TAirOutside <= 283.15 ", firingCon=weaBus.DryBulbTemp<=283.15") annotation (
          Placement(visible = true, transformation(origin = {71, 59}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
        PNlib.Components.T T19(nIn = 1, nOut = 1, firingCon = TAirOutside > 283.15 ", firingCon=weaBus.DryBulbTemp>283.15") annotation (
          Placement(visible = true, transformation(origin = {85, 59}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
        PNlib.Components.PD HP_Off(nIn = 3, nOut = 3, startTokens = 1, minTokens = 0, maxTokens = 1, reStart = true, reStartTokens = 1, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1, 2, 3}, enablingPrioOut = {1, 2, 3}) annotation (
          Placement(visible = true, transformation(origin = {44, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        PNlib.Components.T T110(nIn = 1, nOut = 1, firingCon = u[2] or u[5] or u[8] or u[11] or u[14] "and weaBus.DryBulbTemp<=283.15") annotation (
          Placement(visible = true, transformation(origin = {59, 67}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD HP_Heating_I(nIn = 2, nOut = 2, startTokens = 0, minTokens = 0, maxTokens = 1, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1, 2}, enablingPrioOut = {1, 2}) annotation (
          Placement(visible = true, transformation(origin = {78, 74}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.T T111(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation (
          Placement(visible = true, transformation(origin = {59, 81}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.T T112(nIn = 1, nOut = 1, firingCon = u[3] or u[6] or u[9] or u[12] or u[15]) annotation (
          Placement(visible = true, transformation(origin = {29, 67}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.T T113(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation (
          Placement(visible = true, transformation(origin = {29, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD HP_Cooling(nIn = 1, nOut = 1, startTokens = 0, minTokens = 0, maxTokens = 1, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1}, enablingPrioOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {14, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD GTF_On(nIn = 1, nOut = 1, startTokens = 0, minTokens = 0, maxTokens = 1, reStartTokens = 0, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1}, enablingPrioOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-82, -32}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
        PNlib.Components.T T114(nIn = 1, nOut = 1, firingCon = u[3] or u[6] or u[9] or u[12] or u[15] or HP_Heating_II.t > 0.5 or HP_Heating_I.t > 0.5) annotation (
          Placement(visible = true, transformation(origin = {-75, -15}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
        PNlib.Components.T T115(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation (
          Placement(visible = true, transformation(origin = {-89, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
        PNlib.Components.PD GTF_Off(nIn = 1, nOut = 1, startTokens = 1, minTokens = 0, maxTokens = 1, reStart = true, reStartTokens = 1, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1}, enablingPrioOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        PNlib.Components.PD HX_On(nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-42, -32}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
        PNlib.Components.T T116(nIn = 1, nOut = 1, firingCon = u[1] and u[4] and u[7] and u[10] and u[13]) annotation (
          Placement(visible = true, transformation(origin = {-49, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
        PNlib.Components.T T117(nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-35, -15}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
        PNlib.Components.PD HX_Off(nIn = 1, nOut = 1, startTokens = 1, minTokens = 0, maxTokens = 1, reStartTokens = 0, enablingType = PNlib.Types.EnablingType.Priority, enablingPrioIn = {1}, enablingPrioOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {-42, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        PNlib.Components.PD Off[6](each nIn = 2, each nOut = 2, each startTokens = 1, each minTokens = 0, each maxTokens = 1, each reStart = true, each reStartTokens = 1, each enablingType = PNlib.Types.EnablingType.Priority, each enablingPrioIn = {1, 1}, each enablingPrioOut = {1, 1}) annotation (
          Placement(visible = true, transformation(origin = {38, -8}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.PD Cooling[6](each nIn = 1, each nOut = 1, each startTokens = 0, each minTokens = 0, each maxTokens = 1, each enablingType = PNlib.Types.EnablingType.Priority, each enablingPrioIn = {1}, each enablingPrioOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {4, -8}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.T T118[6](each nIn = 1, each nOut = 1, firingCon = {u[3], u[6], u[9], u[12], u[15], u[3] or u[6] or u[9] or u[12] or u[15]}) annotation (
          Placement(visible = true, transformation(origin = {21, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.T T119[6](each nIn = 1, each nOut = 1, firingCon = {u[1], u[4], u[7], u[10], u[13], u[1] and u[4] and u[7] and u[10] and u[13]}) annotation (
          Placement(visible = true, transformation(origin = {21, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.T T120[6](each nIn = 1, each nOut = 1, firingCon = {u[1], u[4], u[7], u[10], u[13], u[1] and u[4] and u[7] and u[10] and u[13]}) annotation (
          Placement(visible = true, transformation(origin = {55, -15}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.T T121[6](each nIn = 1, each nOut = 1, firingCon = {u[2], u[5], u[8], u[11], u[14], u[2] or u[5] or u[8] or u[11] or u[14]}) annotation (
          Placement(visible = true, transformation(origin = {55, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating[6](each nIn = 1, each nOut = 1, each startTokens = 0, each minTokens = 0, each maxTokens = 1, each enablingType = PNlib.Types.EnablingType.Priority, each enablingPrioIn = {1}, each enablingPrioOut = {1}) annotation (
          Placement(visible = true, transformation(origin = {72, -8}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        Modelica.Blocks.Interfaces.BooleanInput u[15] annotation (
          Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.BooleanOutput y[29] annotation (
          Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Math.RealToBoolean realToBoolean[29](each threshold = 0.5) annotation (
          Placement(visible = true, transformation(origin = {-1, -85}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput TAirOutside "Outside Air Temperature" annotation (
          Placement(visible = true, transformation(origin = {214, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 180), iconTransformation(origin = {214, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 180)));
        inner PNlib.Components.Settings settings annotation (
          Placement(visible = true, transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
      equation
        connect(realToBoolean[29].y, y[29]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -119.655}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[28].y, y[28]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -118.966}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[27].y, y[27]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -118.276}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[26].y, y[26]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -117.586}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[25].y, y[25]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -116.897}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[24].y, y[24]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -116.207}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[23].y, y[23]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -115.517}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[22].y, y[22]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -114.828}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[21].y, y[21]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -114.138}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[20].y, y[20]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -113.448}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[19].y, y[19]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -112.759}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[18].y, y[18]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -112.069}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[17].y, y[17]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -111.379}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[16].y, y[16]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -110.69}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[15].y, y[15]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[14].y, y[14]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -109.31}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[13].y, y[13]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -108.621}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[12].y, y[12]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -107.931}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[11].y, y[11]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -107.241}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[10].y, y[10]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -106.552}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[9].y, y[9]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -105.862}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[8].y, y[8]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -105.172}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[7].y, y[7]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -104.483}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[6].y, y[6]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -103.793}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[5].y, y[5]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -103.103}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[4].y, y[4]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -102.414}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[3].y, y[3]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -101.724}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[2].y, y[2]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -101.034}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean[1].y, y[1]) annotation (
          Line(points = {{-1, -92.7}, {-1, -101}, {0, -101}, {0, -100.345}}, color = {255, 0, 255}, thickness = 0.5));
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
        connect(T121[6].outPlaces[1], Heating[6].inTransition[1]) annotation (
          Line(points = {{58.36, -1}, {72, -1}, {72, -1.52}, {72, -1.52}}, thickness = 0.5));
        connect(T120[6].inPlaces[1], Heating[6].outTransition[1]) annotation (
          Line(points = {{58.36, -15}, {72, -15}, {72, -14.48}, {72, -14.48}}, thickness = 0.5));
        connect(Cooling[6].outTransition[1], T119[6].inPlaces[1]) annotation (
          Line(points = {{4, -14.48}, {18, -14.48}, {18, -15}, {17.64, -15}}, thickness = 0.5));
        connect(T118[6].outPlaces[1], Cooling[6].inTransition[1]) annotation (
          Line(points = {{17.64, -1}, {4, -1}, {4, -1.52}, {4, -1.52}}, thickness = 0.5));
        connect(T119[6].outPlaces[1], Off[6].inTransition[2]) annotation (
          Line(points = {{24.36, -15}, {38, -15}, {38, -14.48}, {37.7, -14.48}}, thickness = 0.5));
        connect(Off[6].outTransition[2], T118[6].inPlaces[1]) annotation (
          Line(points = {{37.7, -1.52}, {24, -1.52}, {24, -1}, {24.36, -1}}, thickness = 0.5));
        connect(T120[6].outPlaces[1], Off[6].inTransition[1]) annotation (
          Line(points = {{51.64, -15}, {38, -15}, {38, -14.48}, {38.3, -14.48}}, thickness = 0.5));
        connect(Off[6].outTransition[1], T121[6].inPlaces[1]) annotation (
          Line(points = {{38.3, -1.52}, {52, -1.52}, {52, -1}, {51.64, -1}}, thickness = 0.5));
        connect(T121[5].outPlaces[1], Heating[5].inTransition[1]) annotation (
          Line(points = {{58.36, -1}, {72, -1}, {72, -1.52}, {72, -1.52}}, thickness = 0.5));
        connect(T120[5].inPlaces[1], Heating[5].outTransition[1]) annotation (
          Line(points = {{58.36, -15}, {72, -15}, {72, -14.48}, {72, -14.48}}, thickness = 0.5));
        connect(Cooling[5].outTransition[1], T119[5].inPlaces[1]) annotation (
          Line(points = {{4, -14.48}, {18, -14.48}, {18, -15}, {17.64, -15}}, thickness = 0.5));
        connect(T118[5].outPlaces[1], Cooling[5].inTransition[1]) annotation (
          Line(points = {{17.64, -1}, {4, -1}, {4, -1.52}, {4, -1.52}}, thickness = 0.5));
        connect(T119[5].outPlaces[1], Off[5].inTransition[2]) annotation (
          Line(points = {{24.36, -15}, {38, -15}, {38, -14.48}, {37.7, -14.48}}, thickness = 0.5));
        connect(Off[5].outTransition[2], T118[5].inPlaces[1]) annotation (
          Line(points = {{37.7, -1.52}, {24, -1.52}, {24, -1}, {24.36, -1}}, thickness = 0.5));
        connect(T120[5].outPlaces[1], Off[5].inTransition[1]) annotation (
          Line(points = {{51.64, -15}, {38, -15}, {38, -14.48}, {38.3, -14.48}}, thickness = 0.5));
        connect(Off[5].outTransition[1], T121[5].inPlaces[1]) annotation (
          Line(points = {{38.3, -1.52}, {52, -1.52}, {52, -1}, {51.64, -1}}, thickness = 0.5));
        connect(T121[4].outPlaces[1], Heating[4].inTransition[1]) annotation (
          Line(points = {{58.36, -1}, {72, -1}, {72, -1.52}, {72, -1.52}}, thickness = 0.5));
        connect(T120[4].inPlaces[1], Heating[4].outTransition[1]) annotation (
          Line(points = {{58.36, -15}, {72, -15}, {72, -14.48}, {72, -14.48}}, thickness = 0.5));
        connect(Cooling[4].outTransition[1], T119[4].inPlaces[1]) annotation (
          Line(points = {{4, -14.48}, {18, -14.48}, {18, -15}, {17.64, -15}}, thickness = 0.5));
        connect(T118[4].outPlaces[1], Cooling[4].inTransition[1]) annotation (
          Line(points = {{17.64, -1}, {4, -1}, {4, -1.52}, {4, -1.52}}, thickness = 0.5));
        connect(T119[4].outPlaces[1], Off[4].inTransition[2]) annotation (
          Line(points = {{24.36, -15}, {38, -15}, {38, -14.48}, {37.7, -14.48}}, thickness = 0.5));
        connect(Off[4].outTransition[2], T118[4].inPlaces[1]) annotation (
          Line(points = {{37.7, -1.52}, {24, -1.52}, {24, -1}, {24.36, -1}}, thickness = 0.5));
        connect(T120[4].outPlaces[1], Off[4].inTransition[1]) annotation (
          Line(points = {{51.64, -15}, {38, -15}, {38, -14.48}, {38.3, -14.48}}, thickness = 0.5));
        connect(Off[4].outTransition[1], T121[4].inPlaces[1]) annotation (
          Line(points = {{38.3, -1.52}, {52, -1.52}, {52, -1}, {51.64, -1}}, thickness = 0.5));
        connect(T121[3].outPlaces[1], Heating[3].inTransition[1]) annotation (
          Line(points = {{58.36, -1}, {72, -1}, {72, -1.52}, {72, -1.52}}, thickness = 0.5));
        connect(T120[3].inPlaces[1], Heating[3].outTransition[1]) annotation (
          Line(points = {{58.36, -15}, {72, -15}, {72, -14.48}, {72, -14.48}}, thickness = 0.5));
        connect(Cooling[3].outTransition[1], T119[3].inPlaces[1]) annotation (
          Line(points = {{4, -14.48}, {18, -14.48}, {18, -15}, {17.64, -15}}, thickness = 0.5));
        connect(T118[3].outPlaces[1], Cooling[3].inTransition[1]) annotation (
          Line(points = {{17.64, -1}, {4, -1}, {4, -1.52}, {4, -1.52}}, thickness = 0.5));
        connect(T119[3].outPlaces[1], Off[3].inTransition[2]) annotation (
          Line(points = {{24.36, -15}, {38, -15}, {38, -14.48}, {37.7, -14.48}}, thickness = 0.5));
        connect(Off[3].outTransition[2], T118[3].inPlaces[1]) annotation (
          Line(points = {{37.7, -1.52}, {24, -1.52}, {24, -1}, {24.36, -1}}, thickness = 0.5));
        connect(T120[3].outPlaces[1], Off[3].inTransition[1]) annotation (
          Line(points = {{51.64, -15}, {38, -15}, {38, -14.48}, {38.3, -14.48}}, thickness = 0.5));
        connect(Off[3].outTransition[1], T121[3].inPlaces[1]) annotation (
          Line(points = {{38.3, -1.52}, {52, -1.52}, {52, -1}, {51.64, -1}}, thickness = 0.5));
        connect(T121[2].outPlaces[1], Heating[2].inTransition[1]) annotation (
          Line(points = {{58.36, -1}, {72, -1}, {72, -1.52}, {72, -1.52}}, thickness = 0.5));
        connect(T120[2].inPlaces[1], Heating[2].outTransition[1]) annotation (
          Line(points = {{58.36, -15}, {72, -15}, {72, -14.48}, {72, -14.48}}, thickness = 0.5));
        connect(Cooling[2].outTransition[1], T119[2].inPlaces[1]) annotation (
          Line(points = {{4, -14.48}, {18, -14.48}, {18, -15}, {17.64, -15}}, thickness = 0.5));
        connect(T118[2].outPlaces[1], Cooling[2].inTransition[1]) annotation (
          Line(points = {{17.64, -1}, {4, -1}, {4, -1.52}, {4, -1.52}}, thickness = 0.5));
        connect(T119[2].outPlaces[1], Off[2].inTransition[2]) annotation (
          Line(points = {{24.36, -15}, {38, -15}, {38, -14.48}, {37.7, -14.48}}, thickness = 0.5));
        connect(Off[2].outTransition[2], T118[2].inPlaces[1]) annotation (
          Line(points = {{37.7, -1.52}, {24, -1.52}, {24, -1}, {24.36, -1}}, thickness = 0.5));
        connect(T120[2].outPlaces[1], Off[2].inTransition[1]) annotation (
          Line(points = {{51.64, -15}, {38, -15}, {38, -14.48}, {38.3, -14.48}}, thickness = 0.5));
        connect(Off[2].outTransition[1], T121[2].inPlaces[1]) annotation (
          Line(points = {{38.3, -1.52}, {52, -1.52}, {52, -1}, {51.64, -1}}, thickness = 0.5));
        connect(T121[1].outPlaces[1], Heating[1].inTransition[1]) annotation (
          Line(points = {{58.36, -1}, {72, -1}, {72, -1.52}, {72, -1.52}}, thickness = 0.5));
        connect(T120[1].inPlaces[1], Heating[1].outTransition[1]) annotation (
          Line(points = {{58.36, -15}, {72, -15}, {72, -14.48}, {72, -14.48}}, thickness = 0.5));
        connect(Cooling[1].outTransition[1], T119[1].inPlaces[1]) annotation (
          Line(points = {{4, -14.48}, {18, -14.48}, {18, -15}, {17.64, -15}}, thickness = 0.5));
        connect(T118[1].outPlaces[1], Cooling[1].inTransition[1]) annotation (
          Line(points = {{17.64, -1}, {4, -1}, {4, -1.52}, {4, -1.52}}, thickness = 0.5));
        connect(T119[1].outPlaces[1], Off[1].inTransition[2]) annotation (
          Line(points = {{24.36, -15}, {38, -15}, {38, -14.48}, {37.7, -14.48}}, thickness = 0.5));
        connect(Off[1].outTransition[2], T118[1].inPlaces[1]) annotation (
          Line(points = {{37.7, -1.52}, {24, -1.52}, {24, -1}, {24.36, -1}}, thickness = 0.5));
        connect(T120[1].outPlaces[1], Off[1].inTransition[1]) annotation (
          Line(points = {{51.64, -15}, {38, -15}, {38, -14.48}, {38.3, -14.48}}, thickness = 0.5));
        connect(Off[1].outTransition[1], T121[1].inPlaces[1]) annotation (
          Line(points = {{38.3, -1.52}, {52, -1.52}, {52, -1}, {51.64, -1}}, thickness = 0.5));
        connect(GTF_On.inTransition[1], T114.outPlaces[1]) annotation (
          Line(points = {{-75.52, -32}, {-74, -32}, {-74, -18.36}, {-75, -18.36}}, thickness = 0.5));
        connect(GTF_On.outTransition[1], T115.inPlaces[1]) annotation (
          Line(points = {{-88.48, -32}, {-90, -32}, {-90, -18.36}, {-89, -18.36}}, thickness = 0.5));
        connect(GTF_Off.outTransition[1], T114.inPlaces[1]) annotation (
          Line(points = {{-75.52, 0}, {-76, 0}, {-76, -11.64}, {-75, -11.64}}, thickness = 0.5));
        connect(T115.outPlaces[1], GTF_Off.inTransition[1]) annotation (
          Line(points = {{-89, -11.64}, {-89, -11.64}, {-89, 0}, {-88.48, 0}}, thickness = 0.5));
        connect(HX_On.outTransition[1], T116.inPlaces[1]) annotation (
          Line(points = {{-48.48, -32}, {-50, -32}, {-50, -18}, {-50, -18}, {-50, -18.36}, {-49, -18.36}}, thickness = 0.5));
        connect(T117.outPlaces[1], HX_On.inTransition[1]) annotation (
          Line(points = {{-35, -18.36}, {-35, -18.36}, {-35, -32}, {-36, -32}, {-36, -32}, {-35.52, -32}}, thickness = 0.5));
        connect(HX_Off.outTransition[1], T117.inPlaces[1]) annotation (
          Line(points = {{-35.52, 0}, {-34, 0}, {-34, -12}, {-34, -11.64}, {-35, -11.64}}, thickness = 0.5));
        connect(T116.outPlaces[1], HX_Off.inTransition[1]) annotation (
          Line(points = {{-49, -11.64}, {-49, -11.64}, {-49, 0}, {-48.48, 0}}, thickness = 0.5));
        connect(HP_Heating_I.outTransition[2], T19.inPlaces[1]) annotation (
          Line(points = {{77.7, 80.48}, {86, 80.48}, {86, 62}, {86, 62.36}, {85, 62.36}}, thickness = 0.5));
        connect(T18.outPlaces[1], HP_Heating_I.inTransition[2]) annotation (
          Line(points = {{71, 62.36}, {70, 62.36}, {70, 68}, {78, 68}, {78, 67.52}, {77.7, 67.52}}, thickness = 0.5));
        connect(T18.inPlaces[1], HP_Heating_II.outTransition[2]) annotation (
          Line(points = {{71, 55.64}, {70, 55.64}, {70, 40}, {78.3, 40}, {78.3, 39.52}}, thickness = 0.5));
        connect(T19.outPlaces[1], HP_Heating_II.inTransition[2]) annotation (
          Line(points = {{85, 55.64}, {85, 55.64}, {85, 54}, {78, 54}, {78, 52.48}, {78.3, 52.48}}, thickness = 0.5));
        connect(T17.outPlaces[1], HP_Heating_II.inTransition[1]) annotation (
          Line(points = {{62.36, 53}, {78, 53}, {78, 52.48}, {77.7, 52.48}}, thickness = 0.5));
        connect(T16.inPlaces[1], HP_Heating_II.outTransition[1]) annotation (
          Line(points = {{62.36, 39}, {78, 39}, {78, 39.52}, {77.7, 39.52}}, thickness = 0.5));
        connect(T110.outPlaces[1], HP_Heating_I.inTransition[1]) annotation (
          Line(points = {{62.36, 67}, {78, 67}, {78, 67.52}, {78.3, 67.52}}, thickness = 0.5));
        connect(HP_Heating_I.outTransition[1], T111.inPlaces[1]) annotation (
          Line(points = {{78.3, 80.48}, {62, 80.48}, {62, 81}, {62.36, 81}}, thickness = 0.5));
        connect(T113.outPlaces[1], HP_Off.inTransition[3]) annotation (
          Line(points = {{32.36, 53}, {36, 53}, {36, 60}, {36, 60}, {36, 60.4}, {37.52, 60.4}}, thickness = 0.5));
        connect(T16.outPlaces[1], HP_Off.inTransition[2]) annotation (
          Line(points = {{55.64, 39}, {36, 39}, {36, 60}, {36, 60}, {36, 60}, {37.52, 60}}, thickness = 0.5));
        connect(HP_Off.inTransition[1], T111.outPlaces[1]) annotation (
          Line(points = {{37.52, 59.6}, {36, 59.6}, {36, 80}, {56, 80}, {56, 81}, {55.64, 81}}, thickness = 0.5));
        connect(HP_Off.outTransition[3], T112.inPlaces[1]) annotation (
          Line(points = {{50.48, 60.4}, {52, 60.4}, {52, 68}, {32, 68}, {32, 67}, {32.36, 67}}, thickness = 0.5));
        connect(HP_Off.outTransition[2], T17.inPlaces[1]) annotation (
          Line(points = {{50.48, 60}, {52, 60}, {52, 52}, {56, 52}, {56, 53}, {55.64, 53}}, thickness = 0.5));
        connect(HP_Off.outTransition[1], T110.inPlaces[1]) annotation (
          Line(points = {{50.48, 59.6}, {52, 59.6}, {52, 68}, {55.64, 68}, {55.64, 67}}, thickness = 0.5));
        connect(HP_Cooling.outTransition[1], T113.inPlaces[1]) annotation (
          Line(points = {{14, 53.52}, {16, 53.52}, {16, 54}, {19.64, 54}, {19.64, 53}, {25.64, 53}}, thickness = 0.5));
        connect(T112.outPlaces[1], HP_Cooling.inTransition[1]) annotation (
          Line(points = {{25.64, 67}, {20, 67}, {20, 66.48}, {14, 66.48}}, thickness = 0.5));
        connect(HTS_Off.outTransition[1], T11.inPlaces[1]) annotation (
          Line(points = {{-81.52, 57.7}, {-80, 57.7}, {-80, 65}, {-76.36, 65}}, color = {0, 0, 0}));
        connect(HTS_Off.outTransition[2], T12.inPlaces[1]) annotation (
          Line(points = {{-81.52, 58.3}, {-80, 58.3}, {-80, 51}, {-76.36, 51}}, color = {0, 0, 0}));
        connect(HTS_Off.inTransition[1], T1.outPlaces[1]) annotation (
          Line(points = {{-94.48, 57.7}, {-96, 57.7}, {-96, 79}, {-76.36, 79}}, color = {0, 0, 0}));
        connect(HTS_Off.inTransition[2], T13.outPlaces[1]) annotation (
          Line(points = {{-94.48, 58.3}, {-96, 58.3}, {-96, 36}, {-76.36, 36}, {-76.36, 37}}, color = {0, 0, 0}));
        connect(T12.outPlaces[1], HTS_Heating_II.inTransition[1]) annotation (
          Line(points = {{-69.64, 51}, {-66, 51}, {-66, 50.48}, {-54.3, 50.48}}, color = {0, 0, 0}));
        connect(HTS_Heating_II.outTransition[1], T13.inPlaces[1]) annotation (
          Line(points = {{-54.3, 37.52}, {-56, 37.52}, {-56, 37}, {-69.64, 37}}, color = {0, 0, 0}));
        connect(T11.outPlaces[1], HTS_Heating_I.inTransition[1]) annotation (
          Line(points = {{-69.64, 65}, {-64, 65}, {-64, 65.52}, {-53.7, 65.52}}, color = {0, 0, 0}));
        connect(T1.inPlaces[1], HTS_Heating_I.outTransition[1]) annotation (
          Line(points = {{-69.64, 79}, {-66, 79}, {-66, 78.48}, {-53.7, 78.48}}, color = {0, 0, 0}));
        connect(T15.outPlaces[1], HTS_Heating_I.inTransition[2]) annotation (
          Line(points = {{-61, 60.36}, {-61, 65.52}, {-54.3, 65.52}}, color = {0, 0, 0}));
        connect(HTS_Heating_I.outTransition[2], T14.inPlaces[1]) annotation (
          Line(points = {{-54.3, 78.48}, {-52, 78.48}, {-52, 78}, {-47, 78}, {-47, 60.36}}, color = {0, 0, 0}));
        connect(T14.outPlaces[1], HTS_Heating_II.inTransition[2]) annotation (
          Line(points = {{-47, 53.64}, {-47, 50.48}, {-53.7, 50.48}}, color = {0, 0, 0}));
        connect(HTS_Heating_II.outTransition[2], T15.inPlaces[1]) annotation (
          Line(points = {{-53.7, 37.52}, {-56, 37.52}, {-56, 38}, {-61, 38}, {-61, 53.64}}, color = {0, 0, 0}));
        annotation (
          uses(PNlib(version = "2.2"), Modelica(version = "3.2.3")),
          Diagram(graphics = {Text(origin = {-69, 93}, extent = {{-21, 5}, {13, -3}}, textString = "HTS_System"), Text(origin = {59, 93}, extent = {{-21, 5}, {13, -3}}, textString = "HP_System"), Text(origin = {-75, 15}, extent = {{-21, 5}, {13, -3}}, textString = "GTF_System"), Text(origin = {-39, 15}, extent = {{-21, 5}, {13, -3}}, textString = "HX"), Text(origin = {45, 17}, extent = {{-21, 5}, {13, -3}}, textString = "Senken")}),
          Icon(graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                           FillPattern.Solid,
                  lineThickness =                                                                                                            0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-136, 36}, lineColor = {95, 95, 95}, extent = {{36, 0}, {234, -72}}, textString = "Automation 
 Level")}),
          __OpenModelica_commandLineOptions = "",
          Documentation(info = "<html><head></head><body>Struktur Output-Vektor<div><br></div><div>HTS_Off</div><div>HTS_Heating_I</div><div>HTS_Heating_II</div><div><br></div><div>HP_Off</div><div>HP_Heating_I</div><div>HP_Heating_II</div><div>HP_Cooling</div><div><br></div><div>GTF_Off</div><div>GTF_On</div><div><br></div><div>HX_Off</div><div>HX_On</div><div><br></div><div>Off[1]</div><div>Heating[1]</div><div>Cooling[1]</div><div><br></div><div><div>Off[2]</div><div>Heating[2]</div><div>Cooling[2]</div></div><div><br></div><div><div>Off[3]</div><div>Heating[3]</div><div>Cooling[3]</div></div><div><br></div><div><div>Off[4]</div><div>Heating[4]</div><div>Cooling[4]</div></div><div><br></div><div><div>Off[5]</div><div>Heating[5]</div><div>Cooling[5]</div></div><div><br></div><div><div>Off[6]</div><div>Heating[6]</div><div>Cooling[6]</div></div><div><br></div><div>(Off/Heating/Cooling 1-5 bestimmen den Betriebsmodus der VU/Tabs Module der Räume</div><div>Off/Heating/Cooling 6 bestimmt den Betriebsmodus der zentralen AHU unit)</div></body></html>"));
      end AutomationLevel_V2;

      model ManagementEbene_Temp_Hum_V1 "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten für die Temperatur und relative Luftfeuchtigkeit im Raum"
        PNlib.Components.T disableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 15, TRoomMea[2] > 273.15 + 20, TRoomMea[3] > 273.15 + 20, TRoomMea[4] > 273.15 + 20, TRoomMea[5] > 273.15 + 20}) annotation (
          Placement(visible = true, transformation(origin = {-56, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T enableHeating[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] < 273.15 + 13, TRoomMea[2] < 273.15 + 18, TRoomMea[3] < 273.15 + 18, TRoomMea[4] < 273.15 + 18, TRoomMea[5] < 273.15 + 18}) annotation (
          Placement(visible = true, transformation(extent = {{-66, 20}, {-46, 40}}, rotation = 0)));
        PNlib.Components.PD Heating[5](each nIn = 1, each nOut = 1, each startTokens = 0, each minTokens = 0, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.PD Off_Temperature[5](each nIn = 2, each nOut = 2, each startTokens = 1, each maxTokens = 1, each reStart = true, each reStartTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD Cooling[5](each nIn = 1, each nOut = 1, each maxTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-182, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.T enableCooling[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] > 273.15 + 17, TRoomMea[2] > 273.15 + 22, TRoomMea[3] > 273.15 + 22, TRoomMea[4] > 273.15 + 22, TRoomMea[5] > 273.15 + 22}) annotation (
          Placement(visible = true, transformation(origin = {-144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T disableCooling[5](each nIn = 1, each nOut = 1, firingCon = {TRoomMea[1] < 273.15 + 15, TRoomMea[2] < 273.15 + 20, TRoomMea[3] < 273.15 + 20, TRoomMea[4] < 273.15 + 20, TRoomMea[5] < 273.15 + 20}) annotation (
          Placement(visible = true, transformation(extent = {{-154, 20}, {-134, 40}}, rotation = 0)));
        PNlib.Components.PD Dehumidifying[5](each nIn = 1, each nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.PD Off_Humidity[5](each nIn = 2, each nOut = 2, each reStartTokens = 1, each startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD Humidifying[5](each nIn = 1, each nOut = 1, each reStartTokens = 1, each startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {184, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.T enableHumidifying[5](each nIn = 1, each nOut = 1, firingCon = {HumRoomMea[1] <= 0.4, HumRoomMea[2] <= 0.4, HumRoomMea[3] <= 0.4, HumRoomMea[4] <= 0.4, HumRoomMea[5] <= 0.4}) annotation (
          Placement(visible = true, transformation(origin = {146, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T enableDehumidifying[5](each nIn = 1, each nOut = 1, firingCon = {HumRoomMea[1] > 0.6, HumRoomMea[2] > 0.6, HumRoomMea[3] > 0.6, HumRoomMea[4] > 0.6, HumRoomMea[5] > 0.6}) annotation (
          Placement(visible = true, transformation(origin = {58, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.T disableDehumidifying[5](each nIn = 1, each nOut = 1, firingCon = {HumRoomMea[1] <= 0.6, HumRoomMea[2] <= 0.6, HumRoomMea[3] <= 0.6, HumRoomMea[4] <= 0.6, HumRoomMea[5] <= 0.6}) annotation (
          Placement(visible = true, transformation(origin = {56, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.T disableHumidifying[5](each nIn = 1, each nOut = 1, firingCon = {HumRoomMea[1] > 0.4, HumRoomMea[2] > 0.4, HumRoomMea[3] > 0.4, HumRoomMea[4] > 0.4, HumRoomMea[5] > 0.4}) annotation (
          Placement(visible = true, transformation(origin = {144, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Modelica.Blocks.Math.RealToBoolean realToBoolean1[30](each threshold = 0.5) annotation (
          Placement(visible = true, transformation(origin = {0, -72}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
        Modelica.Blocks.Interfaces.BooleanOutput y[30] annotation (
          Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation (
          Placement(visible = true, transformation(origin = {-100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {-100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput HumRoomMea[5] annotation (
          Placement(visible = true, transformation(origin = {100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {100, 116}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
      equation
        connect(realToBoolean1[1].y, y[1]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[2].y, y[2]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[3].y, y[3]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[4].y, y[4]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[5].y, y[5]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[6].y, y[6]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[7].y, y[7]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[8].y, y[8]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[9].y, y[9]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[10].y, y[10]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[11].y, y[11]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[12].y, y[12]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[13].y, y[13]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[14].y, y[14]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[15].y, y[15]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[16].y, y[16]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[17].y, y[17]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[18].y, y[18]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[19].y, y[19]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[20].y, y[20]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[21].y, y[21]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[22].y, y[22]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[23].y, y[23]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[24].y, y[24]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[25].y, y[25]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[26].y, y[26]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[27].y, y[27]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[28].y, y[28]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[29].y, y[29]) annotation (
          Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(realToBoolean1[30].y, y[30]) annotation (
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
        connect(Cooling[1].outTransition[1], disableCooling[1].inPlaces[1]) annotation (
          Line(points = {{-182, 10.8}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
        connect(disableDehumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[2]) annotation (
          Line(points = {{60.8, 30}, {112, 30}, {112, -0.5}, {110.8, -0.5}}, thickness = 0.5));
        connect(disableDehumidifying[5].outPlaces[1], Off_Humidity[5].inTransition[2]) annotation (
          Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
        connect(disableDehumidifying[4].outPlaces[1], Off_Humidity[4].inTransition[2]) annotation (
          Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
        connect(disableDehumidifying[3].outPlaces[1], Off_Humidity[3].inTransition[2]) annotation (
          Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {112, 0}, {112, -0.5}, {110.8, -0.5}}, thickness = 0.5));
        connect(disableDehumidifying[2].outPlaces[1], Off_Humidity[2].inTransition[2]) annotation (
          Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
        connect(Off_Humidity[5].outTransition[1], enableHumidifying[5].inPlaces[1]) annotation (
          Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
        connect(Off_Humidity[4].outTransition[1], enableHumidifying[4].inPlaces[1]) annotation (
          Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
        connect(Off_Humidity[3].outTransition[1], enableHumidifying[3].inPlaces[1]) annotation (
          Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
        connect(Off_Humidity[2].outTransition[1], enableHumidifying[2].inPlaces[1]) annotation (
          Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
        connect(Off_Humidity[1].outTransition[1], enableHumidifying[1].inPlaces[1]) annotation (
          Line(points = {{89.2, 0.5}, {88, 0.5}, {88, 30}, {141.2, 30}}, thickness = 0.5));
        connect(enableHumidifying[5].outPlaces[1], Humidifying[5].inTransition[1]) annotation (
          Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
        connect(enableHumidifying[4].outPlaces[1], Humidifying[4].inTransition[1]) annotation (
          Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
        connect(enableHumidifying[3].outPlaces[1], Humidifying[3].inTransition[1]) annotation (
          Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
        connect(enableHumidifying[2].outPlaces[1], Humidifying[2].inTransition[1]) annotation (
          Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
        connect(enableHumidifying[1].outPlaces[1], Humidifying[1].inTransition[1]) annotation (
          Line(points = {{150.8, 30}, {184, 30}, {184, 10.8}}, thickness = 0.5));
        connect(disableDehumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[2]) annotation (
          Line(points = {{60.8, 30}, {112, 30}, {112, 0}, {110.8, 0}, {110.8, -0.5}}, thickness = 0.5));
        connect(disableHumidifying[5].outPlaces[1], Off_Humidity[5].inTransition[1]) annotation (
          Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
        connect(disableHumidifying[4].outPlaces[1], Off_Humidity[4].inTransition[1]) annotation (
          Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
        connect(disableHumidifying[3].outPlaces[1], Off_Humidity[3].inTransition[1]) annotation (
          Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
        connect(disableHumidifying[2].outPlaces[1], Off_Humidity[2].inTransition[1]) annotation (
          Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
        connect(disableHumidifying[1].outPlaces[1], Off_Humidity[1].inTransition[1]) annotation (
          Line(points = {{139.2, -30}, {112, -30}, {112, 0}, {110.8, 0}, {110.8, 0.5}}, thickness = 0.5));
        connect(Off_Humidity[5].outTransition[2], enableDehumidifying[5].inPlaces[1]) annotation (
          Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
        connect(Off_Humidity[4].outTransition[2], enableDehumidifying[4].inPlaces[1]) annotation (
          Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {64, -30}, {64, -30}, {62.8, -30}}, thickness = 0.5));
        connect(Off_Humidity[3].outTransition[2], enableDehumidifying[3].inPlaces[1]) annotation (
          Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
        connect(Off_Humidity[2].outTransition[2], enableDehumidifying[2].inPlaces[1]) annotation (
          Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {62.8, -30}, {62.8, -30}}, thickness = 0.5));
        connect(Off_Humidity[1].outTransition[2], enableDehumidifying[1].inPlaces[1]) annotation (
          Line(points = {{89.2, -0.5}, {88, -0.5}, {88, -30}, {64, -30}, {64, -30}, {62.8, -30}}, thickness = 0.5));
        connect(Dehumidifying[5].outTransition[1], disableDehumidifying[5].inPlaces[1]) annotation (
          Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
        connect(Dehumidifying[4].outTransition[1], disableDehumidifying[4].inPlaces[1]) annotation (
          Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
        connect(Dehumidifying[3].outTransition[1], disableDehumidifying[3].inPlaces[1]) annotation (
          Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
        connect(Dehumidifying[2].outTransition[1], disableDehumidifying[2].inPlaces[1]) annotation (
          Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
        connect(Dehumidifying[1].outTransition[1], disableDehumidifying[1].inPlaces[1]) annotation (
          Line(points = {{20, 10.8}, {20, 10.8}, {20, 30}, {51.2, 30}, {51.2, 30}}, thickness = 0.5));
        connect(enableDehumidifying[5].outPlaces[1], Dehumidifying[5].inTransition[1]) annotation (
          Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
        connect(enableDehumidifying[4].outPlaces[1], Dehumidifying[4].inTransition[1]) annotation (
          Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
        connect(enableDehumidifying[3].outPlaces[1], Dehumidifying[3].inTransition[1]) annotation (
          Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
        connect(enableDehumidifying[2].outPlaces[1], Dehumidifying[2].inTransition[1]) annotation (
          Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
        connect(enableDehumidifying[1].outPlaces[1], Dehumidifying[1].inTransition[1]) annotation (
          Line(points = {{53.2, -30}, {20, -30}, {20, -12}, {20, -10.8}, {20, -10.8}}, thickness = 0.5));
        connect(Humidifying[4].outTransition[1], disableHumidifying[4].inPlaces[1]) annotation (
          Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
        connect(Humidifying[3].outTransition[1], disableHumidifying[3].inPlaces[1]) annotation (
          Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
        connect(Humidifying[2].outTransition[1], disableHumidifying[2].inPlaces[1]) annotation (
          Line(points = {{184, -10.8}, {184, -10.8}, {184, -30}, {148.8, -30}, {148.8, -30}}, thickness = 0.5));
        connect(Humidifying[1].outTransition[1], disableHumidifying[1].inPlaces[1]) annotation (
          Line(points = {{184, -10.8}, {184, -30}, {148.8, -30}}, thickness = 0.5));
        connect(enableHeating[5].outPlaces[1], Heating[5].inTransition[1]) annotation (
          Line(points = {{-51.2, 30}, {-16, 30}, {-16, 10.8}}));
        connect(disableCooling[5].outPlaces[1], Off_Temperature[5].inTransition[2]) annotation (
          Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
        connect(disableCooling[4].outPlaces[1], Off_Temperature[4].inTransition[2]) annotation (
          Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
        connect(disableCooling[3].outPlaces[1], Off_Temperature[3].inTransition[2]) annotation (
          Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
        connect(disableCooling[2].outPlaces[1], Off_Temperature[2].inTransition[2]) annotation (
          Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
        connect(disableCooling[1].outPlaces[1], Off_Temperature[1].inTransition[2]) annotation (
          Line(points = {{-139.2, 30}, {-89.2, 30}, {-89.2, 0}, {-91.2, 0}, {-91.2, 0}, {-89.2, 0}, {-89.2, -0.5}}, thickness = 0.5));
        connect(Cooling[5].outTransition[1], disableCooling[5].inPlaces[1]) annotation (
          Line(points = {{-182, 10.8}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
        connect(Cooling[4].outTransition[1], disableCooling[4].inPlaces[1]) annotation (
          Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
        connect(Cooling[3].outTransition[1], disableCooling[3].inPlaces[1]) annotation (
          Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
        connect(Cooling[2].outTransition[1], disableCooling[2].inPlaces[1]) annotation (
          Line(points = {{-182, 10.8}, {-182, 20.3}, {-182, 20.3}, {-182, 29.8}, {-165.5, 29.8}, {-165.5, 30}, {-148.8, 30}}));
        connect(Off_Temperature[5].outTransition[2], enableCooling[5].inPlaces[1]) annotation (
          Line(points = {{-110.8, -0.5}, {-111.8, -0.5}, {-111.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
        connect(Off_Temperature[4].outTransition[2], enableCooling[4].inPlaces[1]) annotation (
          Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
        connect(Off_Temperature[3].outTransition[2], enableCooling[3].inPlaces[1]) annotation (
          Line(points = {{-110.8, -0.5}, {-111.8, -0.5}, {-111.8, 0}, {-112.8, 0}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
        connect(Off_Temperature[2].outTransition[2], enableCooling[2].inPlaces[1]) annotation (
          Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
        connect(Off_Temperature[1].outTransition[2], enableCooling[1].inPlaces[1]) annotation (
          Line(points = {{-110.8, -0.5}, {-112.8, -0.5}, {-112.8, -30}, {-140.8, -30}, {-140.8, -30}, {-139.2, -30}}, thickness = 0.5));
        connect(enableCooling[5].outPlaces[1], Cooling[5].inTransition[1]) annotation (
          Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
        connect(enableCooling[4].outPlaces[1], Cooling[4].inTransition[1]) annotation (
          Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
        connect(enableCooling[3].outPlaces[1], Cooling[3].inTransition[1]) annotation (
          Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
        connect(enableCooling[2].outPlaces[1], Cooling[2].inTransition[1]) annotation (
          Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
        connect(enableCooling[1].outPlaces[1], Cooling[1].inTransition[1]) annotation (
          Line(points = {{-148.8, -30}, {-181.8, -30}, {-181.8, -20.5}, {-181.8, -10.8}, {-182, -10.8}}));
        connect(disableHeating[5].outPlaces[1], Off_Temperature[5].inTransition[1]) annotation (
          Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
        connect(disableHeating[4].outPlaces[1], Off_Temperature[4].inTransition[1]) annotation (
          Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
        connect(disableHeating[3].outPlaces[1], Off_Temperature[3].inTransition[1]) annotation (
          Line(points = {{-60.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
        connect(disableHeating[2].outPlaces[1], Off_Temperature[2].inTransition[1]) annotation (
          Line(points = {{-60.8, -30}, {-74.8, -30}, {-74.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
        connect(disableHeating[1].outPlaces[1], Off_Temperature[1].inTransition[1]) annotation (
          Line(points = {{-60.8, -30}, {-88.8, -30}, {-88.8, 0}, {-90.8, 0}, {-90.8, 0}, {-90.8, 0.5}, {-89.2, 0.5}}, thickness = 0.5));
        connect(Off_Temperature[5].outTransition[1], enableHeating[5].inPlaces[1]) annotation (
          Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
        connect(Off_Temperature[4].outTransition[1], enableHeating[4].inPlaces[1]) annotation (
          Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
        connect(Off_Temperature[3].outTransition[1], enableHeating[3].inPlaces[1]) annotation (
          Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
        connect(Off_Temperature[2].outTransition[1], enableHeating[2].inPlaces[1]) annotation (
          Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
        connect(Off_Temperature[1].outTransition[1], enableHeating[1].inPlaces[1]) annotation (
          Line(points = {{-110.8, 0.5}, {-112.8, 0.5}, {-112.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}, {-60.8, 30}}, thickness = 0.5));
        connect(Heating[5].outTransition[1], disableHeating[5].inPlaces[1]) annotation (
          Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
        connect(Heating[4].outTransition[1], disableHeating[4].inPlaces[1]) annotation (
          Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
        connect(Heating[3].outTransition[1], disableHeating[3].inPlaces[1]) annotation (
          Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
        connect(Heating[2].outTransition[1], disableHeating[2].inPlaces[1]) annotation (
          Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
        connect(Heating[1].outTransition[1], disableHeating[1].inPlaces[1]) annotation (
          Line(points = {{-16, -10.8}, {-16, -20.3}, {-16, -20.3}, {-16, -29.8}, {-33.5, -29.8}, {-33.5, -30}, {-51.2, -30}}));
        connect(enableHeating[4].outPlaces[1], Heating[4].inTransition[1]) annotation (
          Line(points = {{-51.2, 30}, {-33.7, 30}, {-33.7, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
        connect(enableHeating[3].outPlaces[1], Heating[3].inTransition[1]) annotation (
          Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
        connect(enableHeating[2].outPlaces[1], Heating[2].inTransition[1]) annotation (
          Line(points = {{-51.2, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
        connect(enableHeating[1].outPlaces[1], Heating[1].inTransition[1]) annotation (
          Line(points = {{-51.2, 30}, {-33.7, 30}, {-33.7, 30}, {-16.2, 30}, {-16.2, 20.5}, {-16.2, 10.8}, {-16, 10.8}}));
        connect(Humidifying[5].outTransition[1], disableHumidifying[5].inPlaces[1]) annotation (
          Line(points = {{184, -10.8}, {184, -30}, {148.8, -30}}, color = {0, 0, 0}));
        annotation (
          Line(points = {{-60, -106}, {-60, -106}}, color = {255, 127, 0}),
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}}, initialScale = 0.1), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                                                                                                   FillPattern.Solid,
                  lineThickness =                                                                                                                                                                                                        0.5, extent = {{-200, 100}, {200, -100}}), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                  lineThickness =                                                                                                                                                                                                        0.5, extent = {{-162, 34}, {152, -28}}, textString = "Management 
 Level 
 Temperature 
 and Humidity")}),
          Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}})),
          Documentation(info = "<html><head></head><body><div>Struktur des Output-Vektors (oben nach unten)</div><div><br></div><div>Workshop_Off</div><div>Workshop_Heating</div><div>Workshop_Cooling</div><div>Canteen_Off</div><div>Canteen_Heating</div><div>Canteen_Cooling</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Heating</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Heating</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Off</div><div><div style=\"font-size: 12px;\"><div>OpenplanOffice_Heating</div><div></div></div><div style=\"font-size: 12px;\">OpenplanOffice_Cooling</div></div><div><div>Workshop_Off</div><div>Workshop_Humidifying</div><div>Workshop_Dehumidifying</div><div>Canteen_Off</div><div>Canteen_Humidifying</div><div>Canteen_Dehumidifying</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Humidifying</div><div>ConferenceRoom_Dehumidifying</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Humidifying</div><div>MultipersonOffice_Dehumidifying</div><div>OpenplanOffice_Off</div><div><div style=\"font-size: 12px;\"><div>OpenplanOffice_<span style=\"font-size: medium;\">Humidifying</span></div><div></div></div><div style=\"font-size: 12px;\">OpenplanOffice_Dehumidifying</div></div></div></body></html>"),
          __OpenModelica_commandLineOptions = "");
      end ManagementEbene_Temp_Hum_V1;

      model ManagementLevel_Temp_V1 "Auswahl des Betriebsmodus für jeden einzelnen Raum basierend auf den Messwerten der Raumtemperatur"
        PNlib.Components.TD disableHeating[5](each delay = 1, firingCon = {TRoomMea[1] > 273.15 + 15, TRoomMea[2] > 273.15 + 20, TRoomMea[3] > 273.15 + 20, TRoomMea[4] > 273.15 + 20, TRoomMea[5] > 273.15 + 20}, each nIn = 1, each nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.TD enableHeating[5](delay = 1, firingCon = {TRoomMea[1] < 273.15 + 13, TRoomMea[2] < 273.15 + 18, TRoomMea[3] < 273.15 + 18, TRoomMea[4] < 273.15 + 18, TRoomMea[5] < 273.15 + 18}, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(extent = {{34, 20}, {54, 40}}, rotation = 0)));
        PNlib.Components.PD Heating[5](enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.PD Off_Temperature[5](enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, nIn = 2, nOut = 2, reStart = true, reStartTokens = 1, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.PD Cooling[5](enablingType = PNlib.Types.EnablingType.Priority, maxTokens = 1, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        PNlib.Components.TD enableCooling[5](each delay = 1, firingCon = {TRoomMea[1] > 273.15 + 17, TRoomMea[2] > 273.15 + 22, TRoomMea[3] > 273.15 + 22, TRoomMea[4] > 273.15 + 22, TRoomMea[5] > 273.15 + 22}, each nIn = 1, each nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        PNlib.Components.TD disableCooling[5](each delay = 1, firingCon = {TRoomMea[1] < 273.15 + 15, TRoomMea[2] < 273.15 + 20, TRoomMea[3] < 273.15 + 20, TRoomMea[4] < 273.15 + 20, TRoomMea[5] < 273.15 + 20}, each nIn = 1, each nOut = 1) annotation (
          Placement(visible = true, transformation(extent = {{-54, 20}, {-34, 40}}, rotation = 0)));
        Modelica.Blocks.Interfaces.BooleanOutput y[15] annotation (
          Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation (
          Placement(visible = true, transformation(origin = {-2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90), iconTransformation(origin = {-2.22045e-16, 114}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
        Modelica.Blocks.Math.IntegerToBoolean integerToBoolean1[15](each threshold = 1) annotation (
          Placement(visible = true, transformation(origin = {0, -78}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        connect(integerToBoolean1[1].y, y[1]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[2].y, y[2]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[3].y, y[3]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[4].y, y[4]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[5].y, y[5]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[6].y, y[6]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[7].y, y[7]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[8].y, y[8]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[9].y, y[9]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[10].y, y[10]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[11].y, y[11]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[12].y, y[12]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[13].y, y[13]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[14].y, y[14]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[15].y, y[15]) annotation (
          Line(points = {{0, -88}, {0, -88}, {0, -110}, {0, -110}}, color = {255, 0, 255}, thickness = 0.5));
        connect(Cooling[1].pd_t, integerToBoolean1[3].u) annotation (
          Line(points = {{-92, 0}, {-100, 0}, {-100, -60}, {0, -60}, {0, -64}, {0, -64}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Heating[1].pd_t, integerToBoolean1[2].u) annotation (
          Line(points = {{94, 0}, {100, 0}, {100, -60}, {0, -60}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Off_Temperature[1].pd_t, integerToBoolean1[1].u) annotation (
          Line(points = {{0, -11}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Cooling[2].pd_t, integerToBoolean1[6].u) annotation (
          Line(points = {{-92, 0}, {-100, 0}, {-100, -60}, {0, -60}, {0, -64}, {0, -64}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Heating[2].pd_t, integerToBoolean1[5].u) annotation (
          Line(points = {{94, 0}, {100, 0}, {100, -60}, {0, -60}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Off_Temperature[2].pd_t, integerToBoolean1[4].u) annotation (
          Line(points = {{0, -11}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Cooling[3].pd_t, integerToBoolean1[9].u) annotation (
          Line(points = {{-92, 0}, {-100, 0}, {-100, -60}, {0, -60}, {0, -64}, {0, -64}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Heating[3].pd_t, integerToBoolean1[8].u) annotation (
          Line(points = {{94, 0}, {100, 0}, {100, -60}, {0, -60}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Off_Temperature[3].pd_t, integerToBoolean1[7].u) annotation (
          Line(points = {{0, -11}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Cooling[4].pd_t, integerToBoolean1[12].u) annotation (
          Line(points = {{-92, 0}, {-100, 0}, {-100, -60}, {0, -60}, {0, -64}, {0, -64}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Heating[4].pd_t, integerToBoolean1[11].u) annotation (
          Line(points = {{94, 0}, {100, 0}, {100, -60}, {0, -60}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Off_Temperature[4].pd_t, integerToBoolean1[10].u) annotation (
          Line(points = {{0, -11}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Cooling[5].pd_t, integerToBoolean1[15].u) annotation (
          Line(points = {{-92, 0}, {-100, 0}, {-100, -60}, {0, -60}, {0, -64}, {0, -64}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Heating[5].pd_t, integerToBoolean1[14].u) annotation (
          Line(points = {{94, 0}, {100, 0}, {100, -60}, {0, -60}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(Off_Temperature[5].pd_t, integerToBoolean1[13].u) annotation (
          Line(points = {{0, -11}, {0, -66}}, color = {255, 127, 0}, thickness = 0.5));
        connect(disableCooling[5].outPlaces[1], Off_Temperature[5].inTransition[2]) annotation (
          Line(points = {{-39.2, 30}, {11, 30}, {11, 0}}, thickness = 0.5));
        connect(disableCooling[4].outPlaces[1], Off_Temperature[4].inTransition[2]) annotation (
          Line(points = {{-39.2, 30}, {11, 30}, {11, 0}}, thickness = 0.5));
        connect(disableCooling[3].outPlaces[1], Off_Temperature[3].inTransition[2]) annotation (
          Line(points = {{-39.2, 30}, {11, 30}, {11, 0}}, thickness = 0.5));
        connect(disableCooling[2].outPlaces[1], Off_Temperature[2].inTransition[2]) annotation (
          Line(points = {{-39.2, 30}, {11, 30}, {11, 0}}, thickness = 0.5));
        connect(disableCooling[1].outPlaces[1], Off_Temperature[1].inTransition[2]) annotation (
          Line(points = {{-39.2, 30}, {11, 30}, {11, 0}}, thickness = 0.5));
        connect(Off_Temperature[5].outTransition[1], enableHeating[5].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-12.8, 0}, {-12.8, 29.5}, {39.2, 29.5}, {39.2, 30}}, thickness = 0.5));
        connect(Off_Temperature[4].outTransition[1], enableHeating[4].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-12.8, 0}, {-12.8, 29.5}, {39.2, 29.5}, {39.2, 30}}, thickness = 0.5));
        connect(Off_Temperature[3].outTransition[1], enableHeating[3].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-12.8, 0}, {-12.8, 29.5}, {39.2, 29.5}, {39.2, 30}}, thickness = 0.5));
        connect(Off_Temperature[2].outTransition[1], enableHeating[2].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-12.8, 0}, {-12.8, 29.5}, {39.2, 29.5}, {39.2, 30}}, thickness = 0.5));
        connect(Off_Temperature[1].outTransition[1], enableHeating[1].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-12.8, 0}, {-12.8, 29.5}, {39.2, 29.5}, {39.2, 30}}, thickness = 0.5));
        connect(disableHeating[5].outPlaces[1], Off_Temperature[5].inTransition[1]) annotation (
          Line(points = {{39.2, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, 0}, {11, 0}}, thickness = 0.5));
        connect(disableHeating[4].outPlaces[1], Off_Temperature[4].inTransition[1]) annotation (
          Line(points = {{39.2, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, 0}, {11, 0}}, thickness = 0.5));
        connect(disableHeating[3].outPlaces[1], Off_Temperature[3].inTransition[1]) annotation (
          Line(points = {{39.2, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, 0}, {11, 0}}, thickness = 0.5));
        connect(disableHeating[2].outPlaces[1], Off_Temperature[2].inTransition[1]) annotation (
          Line(points = {{39.2, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, 0}, {11, 0}}, thickness = 0.5));
        connect(disableHeating[1].outPlaces[1], Off_Temperature[1].inTransition[1]) annotation (
          Line(points = {{39.2, -30}, {11.2, -30}, {11.2, -2}, {9.2, -2}, {9.2, 0}, {11, 0}}, thickness = 0.5));
        connect(Off_Temperature[5].outTransition[2], enableCooling[5].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-11.8, 0}, {-11.8, -1.5}, {-12.8, -1.5}, {-12.8, -30}, {-39.2, -30}}, thickness = 0.5));
        connect(Off_Temperature[4].outTransition[2], enableCooling[4].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-12.8, 0}, {-12.8, -30}, {-39.2, -30}}, thickness = 0.5));
        connect(Off_Temperature[3].outTransition[2], enableCooling[3].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-11.8, 0}, {-11.8, -1.5}, {-12.8, -1.5}, {-12.8, -30}, {-39.2, -30}}, thickness = 0.5));
        connect(Off_Temperature[2].outTransition[2], enableCooling[2].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-12.8, 0}, {-12.8, -30}, {-39.2, -30}}, thickness = 0.5));
        connect(Off_Temperature[1].outTransition[2], enableCooling[1].inPlaces[1]) annotation (
          Line(points = {{-11, 0}, {-12.8, 0}, {-12.8, -30}, {-39.2, -30}}, thickness = 0.5));
        connect(Cooling[1].outTransition[1], disableCooling[1].inPlaces[1]) annotation (
          Line(points = {{-82, 11}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-48.8, 30}}));
        connect(Cooling[5].outTransition[1], disableCooling[5].inPlaces[1]) annotation (
          Line(points = {{-82, 11}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-48.8, 30}}));
        connect(Cooling[4].outTransition[1], disableCooling[4].inPlaces[1]) annotation (
          Line(points = {{-82, 11}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-48.8, 30}}));
        connect(Cooling[3].outTransition[1], disableCooling[3].inPlaces[1]) annotation (
          Line(points = {{-82, 11}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-48.8, 30}}));
        connect(Cooling[2].outTransition[1], disableCooling[2].inPlaces[1]) annotation (
          Line(points = {{-82, 11}, {-82, 27.8}, {-65.5, 27.8}, {-65.5, 30}, {-48.8, 30}}));
        connect(enableCooling[5].outPlaces[1], Cooling[5].inTransition[1]) annotation (
          Line(points = {{-48.8, -30}, {-81.8, -30}, {-81.8, -11}, {-82, -11}}));
        connect(enableCooling[4].outPlaces[1], Cooling[4].inTransition[1]) annotation (
          Line(points = {{-48.8, -30}, {-81.8, -30}, {-81.8, -11}, {-82, -11}}));
        connect(enableCooling[3].outPlaces[1], Cooling[3].inTransition[1]) annotation (
          Line(points = {{-48.8, -30}, {-81.8, -30}, {-81.8, -11}, {-82, -11}}));
        connect(enableCooling[2].outPlaces[1], Cooling[2].inTransition[1]) annotation (
          Line(points = {{-48.8, -30}, {-81.8, -30}, {-81.8, -11}, {-82, -11}}));
        connect(enableCooling[1].outPlaces[1], Cooling[1].inTransition[1]) annotation (
          Line(points = {{-48.8, -30}, {-81.8, -30}, {-81.8, -11}, {-82, -11}}));
        connect(enableHeating[5].outPlaces[1], Heating[5].inTransition[1]) annotation (
          Line(points = {{48.8, 30}, {84, 30}, {84, 11}}));
        connect(enableHeating[4].outPlaces[1], Heating[4].inTransition[1]) annotation (
          Line(points = {{48.8, 30}, {83.8, 30}, {83.8, 11}, {84, 11}}));
        connect(enableHeating[3].outPlaces[1], Heating[3].inTransition[1]) annotation (
          Line(points = {{48.8, 30}, {83.8, 30}, {83.8, 11}, {84, 11}}));
        connect(enableHeating[2].outPlaces[1], Heating[2].inTransition[1]) annotation (
          Line(points = {{48.8, 30}, {83.8, 30}, {83.8, 11}, {84, 11}}));
        connect(enableHeating[1].outPlaces[1], Heating[1].inTransition[1]) annotation (
          Line(points = {{48.8, 30}, {83.8, 30}, {83.8, 11}, {84, 11}}));
        connect(Heating[5].outTransition[1], disableHeating[5].inPlaces[1]) annotation (
          Line(points = {{84, -11}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {48.8, -30}}));
        connect(Heating[4].outTransition[1], disableHeating[4].inPlaces[1]) annotation (
          Line(points = {{84, -11}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {48.8, -30}}));
        connect(Heating[3].outTransition[1], disableHeating[3].inPlaces[1]) annotation (
          Line(points = {{84, -11}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {48.8, -30}}));
        connect(Heating[2].outTransition[1], disableHeating[2].inPlaces[1]) annotation (
          Line(points = {{84, -11}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {48.8, -30}}));
        connect(Heating[1].outTransition[1], disableHeating[1].inPlaces[1]) annotation (
          Line(points = {{84, -11}, {84, -31.8}, {66.5, -31.8}, {66.5, -30}, {48.8, -30}}));
        annotation (
          Line(points = {{-60, -106}, {-60, -106}}, color = {255, 127, 0}),
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                                                              FillPattern.Solid,
                  lineThickness =                                                                                                                                                                               0.5, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-162, 34}, {152, -28}}, textString = "Management 
 Level")}),
          Diagram(coordinateSystem(preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body>Struktur des MODI_Temperature-Output-Vektors (Einträge von oben nach unten):<div><br></div><div>Workshop_Off</div><div>Workshop_Heating</div><div>Workshop_Cooling</div><div>Canteen_Off</div><div>Canteen_Heating</div><div>Canteen_Cooling</div><div>ConferenceRoom_Off</div><div>ConferenceRoom_Heating</div><div>ConferenceRoom_Cooling</div><div>MultipersonOffice_Off</div><div>MultipersonOffice_Heating</div><div>MultipersonOffice_Cooling</div><div>OpenplanOffice_Off</div><div><div><div>OpenplanOffice_Heating</div><div></div></div><div>OpenplanOffice_Cooling</div><div><br></div><div><br></div><div><br></div></div><div><div><br></div><div><br></div><div><br></div><div><br></div></div><div><br></div></body></html>"),
          __OpenModelica_commandLineOptions = "");
      end ManagementLevel_Temp_V1;

      model ManagementLevel_Temp
        inner PNlib.Components.Settings settings(showTokenFlow = true) annotation (
          Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD Cooling_Workshop(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableCooling_Workshop(delay = 1, firingCon = TRoomMea[1] < 289.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-65, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Off_Workshop(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.PD Heating_Workshop(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-20, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHeating_Workshop(delay = 1, firingCon = TRoomMea[1] > 287.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-35, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_Workshop(delay = 1, firingCon = TRoomMea[1] < 286.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-35, 73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.TD enableCooling_Workshop(delay = 1, firingCon = TRoomMea[1] > 290.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-65, 73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableHeating_MultipersonOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[4] > 292.15) annotation (
          Placement(visible = true, transformation(origin = {55, 49}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableCooling_MultipersonOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[4] < 294.15) annotation (
          Placement(visible = true, transformation(origin = {25, 49}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {70, 62}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {40, 62}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD enableCooling_MultipersonOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[4] > 295.15) annotation (
          Placement(visible = true, transformation(origin = {25, 75}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_MultipersonOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[4] < 291.15) annotation (
          Placement(visible = true, transformation(origin = {55, 75}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Cooling_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {10, 62}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHeating_Canteen(nIn = 1, nOut = 1, firingCon = TRoomMea[2] > 292.15) annotation (
          Placement(visible = true, transformation(origin = {-33, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableCooling_Canteen(nIn = 1, nOut = 1, firingCon = TRoomMea[2] < 294.15) annotation (
          Placement(visible = true, transformation(origin = {-63, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating_Canteen(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_Canteen(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-48, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD enableCooling_Canteen(nIn = 1, nOut = 1, firingCon = TRoomMea[2] > 295.15) annotation (
          Placement(visible = true, transformation(origin = {-63, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_Canteen(nIn = 1, nOut = 1, firingCon = TRoomMea[2] < 291.15) annotation (
          Placement(visible = true, transformation(origin = {-33, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Cooling_Canteen(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHeating_OpenplanOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[5] > 292.15) annotation (
          Placement(visible = true, transformation(origin = {57, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableCooling_OpenplanOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[5] < 294.15) annotation (
          Placement(visible = true, transformation(origin = {27, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {72, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {42, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD enableCooling_OpenplanOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[5] > 295.15) annotation (
          Placement(visible = true, transformation(origin = {27, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_OpenplanOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[5] < 291.15) annotation (
          Placement(visible = true, transformation(origin = {57, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Cooling_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {12, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHeating_ConferenceRoom(nIn = 1, nOut = 1, firingCon = TRoomMea[3] > 292.15) annotation (
          Placement(visible = true, transformation(origin = {-33, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableCooling_ConferenceRoom(nIn = 1, nOut = 1, firingCon = TRoomMea[3] < 294.15) annotation (
          Placement(visible = true, transformation(origin = {-63, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-18, -60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-48, -60}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD enableCooling_ConferenceRoom(nIn = 1, nOut = 1, firingCon = TRoomMea[3] > 295.15) annotation (
          Placement(visible = true, transformation(origin = {-63, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_ConferenceRoom(nIn = 1, nOut = 1, firingCon = TRoomMea[3] < 291.15) annotation (
          Placement(visible = true, transformation(origin = {-33, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Cooling_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-78, -60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation (
          Placement(visible = true, transformation(origin = {3.33067e-16, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {3.33067e-16, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.BooleanOutput y[15] annotation (
          Placement(visible = true, transformation(origin = {0, -108}, extent = {{-8, -8}, {8, 8}}, rotation = -90), iconTransformation(origin = {0, -108}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
        Modelica.Blocks.Math.IntegerToBoolean integerToBoolean1[15](each threshold = 1) annotation (
          Placement(visible = true, transformation(origin = {4.44089e-16, -84}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
      equation
        connect(Cooling_OpenplanOffice.pd_t, integerToBoolean1[15].u) annotation (
          Line(points={{18.36,0},{18,0},{18,-30},{0,-30},{0,-76.8},{0,-76.8}},       color = {255, 127, 0}));
        connect(Heating_OpenplanOffice.pd_t, integerToBoolean1[14].u) annotation (
          Line(points={{78.36,0},{82,0},{82,-30},{0,-30},{0,-76},{0,-76.8},{0,
                -76.8}},                                                                       color = {255, 127, 0}));
        connect(Off_OpenplanOffice.pd_t, integerToBoolean1[13].u) annotation (
          Line(points={{35.64,0},{36,0},{36,-30},{0,-30},{0,-76.8},{0,-76.8}},       color = {255, 127, 0}));
        connect(Cooling_MultipersonOffice.pd_t, integerToBoolean1[12].u) annotation (
          Line(points={{16.36,62},{18,62},{18,28},{0,28},{0,-76.8},{0,-76.8}},       color = {255, 127, 0}));
        connect(Heating_MultipersonOffice.pd_t, integerToBoolean1[11].u) annotation (
          Line(points={{76.36,62},{80,62},{80,28},{0,28},{0,-76},{0,-76.8},{0,
                -76.8}},                                                                       color = {255, 127, 0}));
        connect(Off_MultipersonOffice.pd_t, integerToBoolean1[10].u) annotation (
          Line(points={{33.64,62},{32,62},{32,28},{0,28},{0,-76.8},{0,-76.8}},       color = {255, 127, 0}));
        connect(Cooling_ConferenceRoom.pd_t, integerToBoolean1[9].u) annotation (
          Line(points={{-71.64,-60},{-72,-60},{-72,-30},{0,-30},{0,-76.8},{0,
                -76.8}},                                                                    color = {255, 127, 0}));
        connect(Heating_ConferenceRoom.pd_t, integerToBoolean1[8].u) annotation (
          Line(points={{-11.64,-60},{0,-60},{0,-76},{0,-76.8},{0,-76.8}},     color = {255, 127, 0}));
        connect(Off_ConferenceRoom.pd_t, integerToBoolean1[7].u) annotation (
          Line(points={{-54.36,-60},{-54,-60},{-54,-30},{0,-30},{0,-76.8},{0,
                -76.8}},                                                                    color = {255, 127, 0}));
        connect(Cooling_Canteen.pd_t, integerToBoolean1[6].u) annotation (
          Line(points={{-71.64,0},{-72,0},{-72,-30},{0,-30},{0,-76.8},{0,-76.8}},       color = {255, 127, 0}));
        connect(Heating_Canteen.pd_t, integerToBoolean1[5].u) annotation (
          Line(points={{-11.64,0},{0,0},{0,-76},{0,-76.8},{0,-76.8}},     color = {255, 127, 0}));
        connect(Cooling_Workshop.pd_t, integerToBoolean1[3].u) annotation (
          Line(points={{-73.64,60},{-76,60},{-76,28},{0,28},{0,-76.8},{0,-76.8}},       color = {255, 127, 0}));
        connect(Heating_Workshop.pd_t, integerToBoolean1[2].u) annotation (
          Line(points={{-13.64,60},{0,60},{0,-76},{0,-76.8},{0,-76.8}},     color = {255, 127, 0}));
        connect(Off_Workshop.pd_t, integerToBoolean1[1].u) annotation (
          Line(points={{-56.36,60},{-56,60},{-56,28},{0,28},{0,-76.8},{0,-76.8}},       color = {255, 127, 0}));
        connect(Off_Canteen.pd_t, integerToBoolean1[4].u) annotation (
          Line(points={{-54.36,0},{-54,0},{-54,-30},{0,-30},{0,-76.8},{0,-76.8}},       color = {255, 127, 0}));
        connect(integerToBoolean1[1].y, y[1]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-100.533},{0,-100.533}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[2].y, y[2]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-101.6},{0,-101.6}},  color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[3].y, y[3]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-102.667},{0,-102.667}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[4].y, y[4]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-103.733},{0,-103.733}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[5].y, y[5]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-104.8},{0,-104.8}},  color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[6].y, y[6]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-105.867},{0,-105.867}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[7].y, y[7]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-106.933},{0,-106.933}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[8].y, y[8]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-108},{0,-108}},      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[9].y, y[9]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-109.067},{0,-109.067}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[10].y, y[10]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-110.133},{0,-110.133}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[11].y, y[11]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-111.2},{0,-111.2}},  color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[12].y, y[12]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-112.267},{0,-112.267}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[13].y, y[13]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-113.333},{0,-113.333}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[14].y, y[14]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-114.4},{0,-114.4}},  color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[15].y, y[15]) annotation (
          Line(points={{0,-90.6},{0,-90.6},{0,-115.467},{0,-115.467}},
                                                                    color = {255, 0, 255}, thickness = 0.5));
        connect(disableCooling_MultipersonOffice.outPlaces[1], Off_MultipersonOffice.inTransition[2]) annotation (
          Line(points={{28.36,49},{40,49},{40,56},{40,55.52},{39.7,55.52}}, thickness = 0.5));
        connect(Cooling_MultipersonOffice.outTransition[1], disableCooling_MultipersonOffice.inPlaces[1]) annotation (
          Line(points={{10,55.52},{10,55.52},{10,48},{21.64,48},{21.64,49}},thickness = 0.5));
        connect(enableCooling_MultipersonOffice.inPlaces[1], Off_MultipersonOffice.outTransition[2]) annotation (
          Line(points={{28.36,75},{40,75},{40,68},{40,68.48},{39.7,68.48}}, thickness = 0.5));
        connect(disableCooling_ConferenceRoom.outPlaces[1], Off_ConferenceRoom.inTransition[2]) annotation (
          Line(points={{-59.64,-73},{-48,-73},{-48,-66},{-48,-66.48},{-48.3,
                -66.48}},                                                             thickness = 0.5));
        connect(Off_ConferenceRoom.outTransition[2], enableCooling_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{-48.3,-53.52},{-48.3,-53.52},{-48.3,-48},{-59.64,-48},{
                -59.64,-47}},                                                         thickness = 0.5));
        connect(enableCooling_OpenplanOffice.inPlaces[1], Off_OpenplanOffice.outTransition[2]) annotation (
          Line(points={{30.36,13},{42,13},{42,6},{42,6.48},{41.7,6.48}}, thickness = 0.5));
        connect(disableCooling_OpenplanOffice.outPlaces[1], Off_OpenplanOffice.inTransition[2]) annotation (
          Line(points={{30.36,-13},{42,-13},{42,-6},{42,-6.48},{41.7,-6.48}}, thickness = 0.5));
        connect(Cooling_OpenplanOffice.outTransition[1], disableCooling_OpenplanOffice.inPlaces[1]) annotation (
          Line(points={{12,-6.48},{12,-6.48},{12,-12},{24,-12},{24,-13},{23.64,
                -13}},                                                                    thickness = 0.5));
        connect(disableCooling_Canteen.outPlaces[1], Off_Canteen.inTransition[2]) annotation (
          Line(points={{-59.64,-13},{-48,-13},{-48,-6},{-48,-6.48},{-48.3,-6.48}}, thickness = 0.5));
        connect(Off_Canteen.outTransition[2], enableCooling_Canteen.inPlaces[1]) annotation (
          Line(points={{-48.3,6.48},{-48.3,6.48},{-48.3,12},{-59.64,12},{-59.64,
                13}},                                                          thickness = 0.5));
        connect(Cooling_ConferenceRoom.outTransition[1], disableCooling_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{-78,-66.48},{-78,-66.48},{-78,-74},{-66.36,-74},{-66.36,
                -73}},                                                                thickness = 0.5));
        connect(Cooling_ConferenceRoom.inTransition[1], enableCooling_ConferenceRoom.outPlaces[1]) annotation (
          Line(points={{-78,-53.52},{-78,-53.52},{-78,-46},{-66.36,-46},{-66.36,
                -47}},                                                                thickness = 0.5));
        connect(disableHeating_ConferenceRoom.inPlaces[1], Heating_ConferenceRoom.outTransition[1]) annotation (
          Line(points={{-29.64,-73},{-18,-73},{-18,-66},{-18,-66.48},{-18,-66.48}},   thickness = 0.5));
        connect(Off_ConferenceRoom.inTransition[1], disableHeating_ConferenceRoom.outPlaces[1]) annotation (
          Line(points={{-47.7,-66.48},{-47.7,-66.48},{-47.7,-74},{-36.36,-74},{
                -36.36,-73}},                                                         thickness = 0.5));
        connect(enableHeating_ConferenceRoom.outPlaces[1], Heating_ConferenceRoom.inTransition[1]) annotation (
          Line(points={{-29.64,-47},{-18,-47},{-18,-54},{-18,-53.52},{-18,-53.52}},   thickness = 0.5));
        connect(Off_ConferenceRoom.outTransition[1], enableHeating_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{-47.7,-53.52},{-47.7,-53.52},{-47.7,-48},{-36.36,-48},{
                -36.36,-47}},                                                         thickness = 0.5));
        connect(Off_Canteen.inTransition[1], disableHeating_Canteen.outPlaces[1]) annotation (
          Line(points={{-47.7,-6.48},{-47.7,-6.48},{-47.7,-12},{-36.36,-12},{
                -36.36,-13}},                                                       thickness = 0.5));
        connect(Off_Canteen.outTransition[1], enableHeating_Canteen.inPlaces[1]) annotation (
          Line(points={{-47.7,6.48},{-47.7,6.48},{-47.7,14},{-36.36,14},{-36.36,
                13}},                                                          thickness = 0.5));
        connect(Off_OpenplanOffice.inTransition[1], disableHeating_OpenplanOffice.outPlaces[1]) annotation (
          Line(points={{42.3,-6.48},{42.3,-6.48},{42.3,-12},{53.64,-12},{53.64,
                -13}},                                                         thickness = 0.5));
        connect(Off_OpenplanOffice.outTransition[1], enableHeating_OpenplanOffice.inPlaces[1]) annotation (
          Line(points={{42.3,6.48},{42.3,6.48},{42.3,14},{53.64,14},{53.64,13}},
                                                                          thickness = 0.5));
        connect(Off_MultipersonOffice.inTransition[1], disableHeating_MultipersonOffice.outPlaces[1]) annotation (
          Line(points={{40.3,55.52},{40.3,55.52},{40.3,50},{51.64,50},{51.64,49}},
                                                                            thickness = 0.5));
        connect(Off_MultipersonOffice.outTransition[1], enableHeating_MultipersonOffice.inPlaces[1]) annotation (
          Line(points={{40.3,68.48},{40.3,68.48},{40.3,76},{51.64,76},{51.64,75}},
                                                                            thickness = 0.5));
        connect(enableHeating_MultipersonOffice.outPlaces[1], Heating_MultipersonOffice.inTransition[1]) annotation (
          Line(points={{58.36,75},{72,75},{72,68},{70,68},{70,68.48}},      thickness = 0.5));
        connect(disableHeating_MultipersonOffice.inPlaces[1], Heating_MultipersonOffice.outTransition[1]) annotation (
          Line(points={{58.36,49},{70,49},{70,56},{70,55.52},{70,55.52}},   thickness = 0.5));
        connect(Cooling_MultipersonOffice.inTransition[1], enableCooling_MultipersonOffice.outPlaces[1]) annotation (
          Line(points={{10,68.48},{10,68.48},{10,74},{21.64,74},{21.64,75}},thickness = 0.5));
        connect(disableHeating_OpenplanOffice.inPlaces[1], Heating_OpenplanOffice.outTransition[1]) annotation (
          Line(points={{60.36,-13},{72,-13},{72,-6},{72,-6.48},{72,-6.48}},   thickness = 0.5));
        connect(enableHeating_OpenplanOffice.outPlaces[1], Heating_OpenplanOffice.inTransition[1]) annotation (
          Line(points={{60.36,13},{72,13},{72,6},{72,6.48},{72,6.48}},   thickness = 0.5));
        connect(Cooling_OpenplanOffice.inTransition[1], enableCooling_OpenplanOffice.outPlaces[1]) annotation (
          Line(points={{12,6.48},{12,6.48},{12,12},{23.64,12},{23.64,13}},thickness = 0.5));
        connect(disableHeating_Canteen.inPlaces[1], Heating_Canteen.outTransition[1]) annotation (
          Line(points={{-29.64,-13},{-18,-13},{-18,-8},{-18,-8},{-18,-6.48},{-18,
                -6.48}},                                                                      thickness = 0.5));
        connect(enableHeating_Canteen.outPlaces[1], Heating_Canteen.inTransition[1]) annotation (
          Line(points={{-29.64,13},{-18,13},{-18,6},{-18,6.48},{-18,6.48}},   thickness = 0.5));
        connect(Cooling_Canteen.outTransition[1], disableCooling_Canteen.inPlaces[1]) annotation (
          Line(points={{-78,-6.48},{-78,-6.48},{-78,-12},{-66.36,-12},{-66.36,-13}},thickness = 0.5));
        connect(Cooling_Canteen.inTransition[1], enableCooling_Canteen.outPlaces[1]) annotation (
          Line(points={{-78,6.48},{-76,6.48},{-76,12},{-66.36,12},{-66.36,13}},thickness = 0.5));
        connect(Cooling_Workshop.inTransition[1], enableCooling_Workshop.outPlaces[1]) annotation (
          Line(points={{-80,66.48},{-80,66.48},{-80,74},{-68.36,74},{-68.36,73}},thickness = 0.5));
        connect(disableHeating_Workshop.inPlaces[1], Heating_Workshop.outTransition[1]) annotation (
          Line(points={{-31.64,47},{-20,47},{-20,53.52}},  thickness = 0.5));
        connect(Cooling_Workshop.outTransition[1], disableCooling_Workshop.inPlaces[1]) annotation (
          Line(points={{-80,53.52},{-80,53.52},{-80,48},{-68.36,48},{-68.36,47}},thickness = 0.5));
        connect(enableHeating_Workshop.outPlaces[1], Heating_Workshop.inTransition[1]) annotation (
          Line(points={{-31.64,73},{-20,73},{-20,66},{-20,66.48},{-20,66.48}},   thickness = 0.5));
        connect(Off_Workshop.inTransition[1], disableHeating_Workshop.outPlaces[1]) annotation (
          Line(points={{-49.7,53.52},{-49.7,53.52},{-49.7,48},{-38.36,48},{-38.36,
                47}},                                                            thickness = 0.5));
        connect(disableCooling_Workshop.outPlaces[1], Off_Workshop.inTransition[2]) annotation (
          Line(points={{-61.64,47},{-50,47},{-50,54},{-50,53.52},{-50.3,53.52}}, thickness = 0.5));
        connect(Off_Workshop.outTransition[2], enableCooling_Workshop.inPlaces[1]) annotation (
          Line(points={{-50.3,66.48},{-50.3,66.48},{-50.3,74},{-61.64,74},{-61.64,
                73}},                                                            thickness = 0.5));
        connect(Off_Workshop.outTransition[1], enableHeating_Workshop.inPlaces[1]) annotation (
          Line(points={{-49.7,66.48},{-49.7,66.48},{-49.7,74},{-38.36,74},{-38.36,
                73}},                                                            thickness = 0.5));
        annotation (
          Icon(graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                           FillPattern.Solid,
                  lineThickness =                                                                                                            0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-5, 14}, lineColor = {95, 95, 95}, extent = {{-83, 40}, {97, -56}}, textString = "Management
Level")},   coordinateSystem(initialScale = 0.1)),
          Documentation(info = "<html><head></head><body>Managementebene der MODI-Methode<div><br></div><div>Auswahl eines übergeordneten Betriebsmodus für jeden Raum basierend auf der gemessenen Raumtemperatur</div><div><br></div><div><br></div><div>Struktur des Output-Vektors</div><div><br></div><div><br></div><div>Off_Workshop</div><div>Heating_Workshop</div><div>Cooling_Workshop</div><div><br></div><div><div>Off_Canteen</div><div>Heating_Canteen</div><div>Cooling_Canteen</div></div><div><br></div><div><div>Off_ConferenceRoom</div><div>Heating_ConferenceRoom</div><div>Cooling_ConferenceRoom</div></div><div><br></div><div><div>Off_MultipersonOffice</div><div>Heating_MultipersonOffice</div><div>Cooling_MultipersonOffice</div></div><div><br></div><div><div>Off_OpenplanOffice</div><div>Heating_OpenplanOffice</div><div>Cooling_OpenplanOffice</div></div><div><br></div></body></html>"));
      end ManagementLevel_Temp;

      model ManagementLevel_Temp_Hum
        inner PNlib.Components.Settings settings(showTokenFlow = true) annotation (
          Placement(visible = true, transformation(origin = {-190, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PNlib.Components.PD Cooling_Workshop(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-180, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableCooling_Workshop(delay = 1, firingCon = TRoomMea[1] < 289.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-165, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Off_Workshop(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-150, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.PD Heating_Workshop(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHeating_Workshop(delay = 1, firingCon = TRoomMea[1] > 287.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-135, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_Workshop(delay = 1, firingCon = TRoomMea[1] < 286.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-135, 73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.TD enableCooling_Workshop(delay = 1, firingCon = TRoomMea[1] > 290.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-165, 73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableHeating_MultipersonOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[4] > 292.15) annotation (
          Placement(visible = true, transformation(origin = {-45, 49}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableCooling_MultipersonOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[4] < 294.15) annotation (
          Placement(visible = true, transformation(origin = {-75, 49}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-30, 62}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-60, 62}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD enableCooling_MultipersonOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[4] > 295.15) annotation (
          Placement(visible = true, transformation(origin = {-75, 75}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_MultipersonOffice(delay = 1, firingCon = TRoomMea[4] < 291.15, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {-45, 75}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Cooling_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-90, 62}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHeating_Canteen(nIn = 1, nOut = 1, firingCon = TRoomMea[2] > 292.15) annotation (
          Placement(visible = true, transformation(origin = {-133, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableCooling_Canteen(nIn = 1, nOut = 1, firingCon = TRoomMea[2] < 294.15) annotation (
          Placement(visible = true, transformation(origin = {-163, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating_Canteen(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-118, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_Canteen(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-148, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD enableCooling_Canteen(nIn = 1, nOut = 1, firingCon = TRoomMea[2] > 295.15) annotation (
          Placement(visible = true, transformation(origin = {-163, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_Canteen(nIn = 1, nOut = 1, firingCon = TRoomMea[2] < 291.15) annotation (
          Placement(visible = true, transformation(origin = {-133, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Cooling_Canteen(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-178, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHeating_OpenplanOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[5] > 292.15) annotation (
          Placement(visible = true, transformation(origin = {-43, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableCooling_OpenplanOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[5] < 294.15) annotation (
          Placement(visible = true, transformation(origin = {-73, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-28, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD enableCooling_OpenplanOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[5] > 295.15) annotation (
          Placement(visible = true, transformation(origin = {-73, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_OpenplanOffice(nIn = 1, nOut = 1, firingCon = TRoomMea[5] < 291.15) annotation (
          Placement(visible = true, transformation(origin = {-43, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Cooling_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-88, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHeating_ConferenceRoom(nIn = 1, nOut = 1, firingCon = TRoomMea[3] > 292.15) annotation (
          Placement(visible = true, transformation(origin = {-133, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableCooling_ConferenceRoom(nIn = 1, nOut = 1, firingCon = TRoomMea[3] < 294.15) annotation (
          Placement(visible = true, transformation(origin = {-163, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Heating_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-118, -60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {-148, -60}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD enableCooling_ConferenceRoom(nIn = 1, nOut = 1, firingCon = TRoomMea[3] > 295.15) annotation (
          Placement(visible = true, transformation(origin = {-163, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHeating_ConferenceRoom(nIn = 1, nOut = 1, firingCon = TRoomMea[3] < 291.15) annotation (
          Placement(visible = true, transformation(origin = {-133, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Cooling_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {-178, -60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation (
          Placement(visible = true, transformation(origin = {-100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.BooleanOutput Temp[15] annotation (
          Placement(visible = true, transformation(origin = {-100, -108}, extent = {{-8, -8}, {8, 8}}, rotation = -90), iconTransformation(origin = {-100, -108}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
        Modelica.Blocks.Math.IntegerToBoolean integerToBoolean1[15](each threshold = 1) annotation (
          Placement(visible = true, transformation(origin = {-100, -84}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Dehumidifying_Workshop(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {20, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableDehumidifying_Workshop(delay = 1, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {35, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Off_Hum_Workshop(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {50, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.PD Humidifying_Workshop(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {80, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD enableHumidifying_Workshop(delay = 1, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {65, 73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput HumRoomMea[5] annotation (
          Placement(visible = true, transformation(origin = {100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        PNlib.Components.TD enableDehumidifying_Workshop(delay = 1, firingCon = HumRoomMea[1] > 0.6, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {35, 73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        Modelica.Blocks.Interfaces.BooleanOutput Hum[15] annotation (
          Placement(visible = true, transformation(origin = {100, -108}, extent = {{-8, -8}, {8, 8}}, rotation = -90), iconTransformation(origin = {100, -108}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
        Modelica.Blocks.Math.IntegerToBoolean integerToBoolean2[15](each threshold = 1) annotation (
          Placement(visible = true, transformation(origin = {100, -86}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHumidifying_Canteen(delay = 1, firingCon = HumRoomMea[2] > 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {65, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableDehumidifying_Canteen(delay = 1, firingCon = HumRoomMea[2] > 0.6, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {35, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHumidifying_Canteen(delay = 1, firingCon = HumRoomMea[2] < 0.4, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {65, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Humidifying_Canteen(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {80, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_Hum_Canteen(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {50, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.TD disableDehumidifying_Canteen(delay = 1, firingCon = HumRoomMea[2] < 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {35, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Dehumidifying_Canteen(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {20, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableDehumidifying_ConferenceRoom(delay = 1, firingCon = HumRoomMea[3] < 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {35, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Off_Hum_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {50, -60}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.PD Humidifying_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {80, -60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD enableHumidifying_ConferenceRoom(delay = 1, firingCon = HumRoomMea[3] < 0.4, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {65, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.TD enableDehumidifying_ConferenceRoom(delay = 1, firingCon = HumRoomMea[3] > 0.6, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {35, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableHumidifying_ConferenceRoom(delay = 1, firingCon = HumRoomMea[3] > 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {65, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.PD Dehumidifying_ConferenceRoom(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {20, -60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableHumidifying_MultipersonOffice(delay = 1, firingCon = HumRoomMea[4] > 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {165, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableDehumidifying_MultipersonOffice(delay = 1, firingCon = HumRoomMea[4] < 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {135, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.TD enableDehumidifying_MultipersonOffice(delay = 1, firingCon = HumRoomMea[4] > 0.6, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {135, 73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHumidifying_MultipersonOffice(delay = 1, firingCon = HumRoomMea[4] < 0.4, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {165, 73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.PD Humidifying_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {180, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_Hum_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {150, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.PD Dehumidifying_MultipersonOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {120, 60}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Dehumidifying_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {120, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.PD Off_Hum_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
          Placement(visible = true, transformation(origin = {150, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
        PNlib.Components.PD Humidifying_OpenplanOffice(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
          Placement(visible = true, transformation(origin = {180, 0}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
        PNlib.Components.TD disableDehumidifying_OpenplanOffice(delay = 1, firingCon = HumRoomMea[5] < 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {135, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.TD disableHumidifying_OpenplanOffice(delay = 1, firingCon = HumRoomMea[5] > 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {165, -13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD enableHumidifying_OpenplanOffice(delay = 1, firingCon = HumRoomMea[5] < 0.4, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {165, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        PNlib.Components.TD enableDehumidifying_OpenplanOffice(delay = 1, firingCon = HumRoomMea[5] > 0.6, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {135, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
        PNlib.Components.TD disableHumidifying_Workshop(delay = 1, firingCon = HumRoomMea[1] > 0.5, nIn = 1, nOut = 1) annotation (
          Placement(visible = true, transformation(origin = {65, 47}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      equation
        connect(Dehumidifying_ConferenceRoom.inTransition[1], enableDehumidifying_ConferenceRoom.outPlaces[1]) annotation (
          Line(points={{20,-53.52},{20,-53.52},{20,-46},{31.64,-46},{31.64,-47}},thickness = 0.5));
        connect(Dehumidifying_ConferenceRoom.outTransition[1], disableDehumidifying_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{20,-66.48},{20,-66.48},{20,-74},{31.64,-74},{31.64,-73}},thickness = 0.5));
        connect(disableHumidifying_ConferenceRoom.inPlaces[1], Humidifying_ConferenceRoom.outTransition[1]) annotation (
          Line(points={{68.36,-73},{80,-73},{80,-66},{80,-66},{80,-66.48},{80,
                -66.48}},                                                                   thickness = 0.5));
        connect(enableHumidifying_ConferenceRoom.outPlaces[1], Humidifying_ConferenceRoom.inTransition[1]) annotation (
          Line(points={{68.36,-47},{80,-47},{80,-54},{80,-53.52},{80,-53.52}},   thickness = 0.5));
        connect(disableHumidifying_ConferenceRoom.outPlaces[1], Off_Hum_ConferenceRoom.inTransition[1]) annotation (
          Line(points={{61.64,-73},{50,-73},{50,-66},{50,-66.48},{50.3,-66.48}}, thickness = 0.5));
        connect(disableDehumidifying_ConferenceRoom.outPlaces[1], Off_Hum_ConferenceRoom.inTransition[2]) annotation (
          Line(points={{38.36,-73},{50,-73},{50,-66},{50,-66.48},{49.7,-66.48}}, thickness = 0.5));
        connect(Off_Hum_ConferenceRoom.outTransition[2], enableDehumidifying_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{49.7,-53.52},{49.7,-53.52},{49.7,-46},{38.36,-46},{38.36,
                -47}},                                                           thickness = 0.5));
        connect(Off_Hum_ConferenceRoom.outTransition[1], enableHumidifying_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{50.3,-53.52},{50.3,-53.52},{50.3,-46},{61.64,-46},{61.64,
                -47}},                                                           thickness = 0.5));
        connect(Dehumidifying_OpenplanOffice.outTransition[1], disableDehumidifying_OpenplanOffice.inPlaces[1]) annotation (
          Line(points={{120,-6.48},{120,-6.48},{120,-14},{131.64,-14},{131.64,-13}},thickness = 0.5));
        connect(Dehumidifying_OpenplanOffice.inTransition[1], enableDehumidifying_OpenplanOffice.outPlaces[1]) annotation (
          Line(points={{120,6.48},{120,6.48},{120,14},{131.64,14},{131.64,13}},thickness = 0.5));
        connect(enableHumidifying_OpenplanOffice.outPlaces[1], Humidifying_OpenplanOffice.inTransition[1]) annotation (
          Line(points={{168.36,13},{180,13},{180,6},{180,6.48},{180,6.48}},   thickness = 0.5));
        connect(Off_Hum_OpenplanOffice.outTransition[1], enableHumidifying_OpenplanOffice.inPlaces[1]) annotation (
          Line(points={{150.3,6.48},{150.3,6.48},{150.3,14},{161.64,14},{161.64,
                13}},                                                          thickness = 0.5));
        connect(disableHumidifying_OpenplanOffice.inPlaces[1], Humidifying_OpenplanOffice.outTransition[1]) annotation (
          Line(points={{168.36,-13},{180,-13},{180,-6},{180,-6.48},{180,-6.48}},   thickness = 0.5));
        connect(disableHumidifying_OpenplanOffice.outPlaces[1], Off_Hum_OpenplanOffice.inTransition[1]) annotation (
          Line(points={{161.64,-13},{150,-13},{150,-6},{150,-6.48},{150.3,-6.48}}, thickness = 0.5));
        connect(disableDehumidifying_OpenplanOffice.outPlaces[1], Off_Hum_OpenplanOffice.inTransition[2]) annotation (
          Line(points={{138.36,-13},{150,-13},{150,-6},{150,-6.48},{149.7,-6.48}}, thickness = 0.5));
        connect(Off_Hum_OpenplanOffice.outTransition[2], enableDehumidifying_OpenplanOffice.inPlaces[1]) annotation (
          Line(points={{149.7,6.48},{149.7,6.48},{149.7,14},{138.36,14},{138.36,
                13}},                                                          thickness = 0.5));
        connect(Dehumidifying_MultipersonOffice.outTransition[1], disableDehumidifying_MultipersonOffice.inPlaces[1]) annotation (
          Line(points={{120,53.52},{120,53.52},{120,46},{131.64,46},{131.64,47}},thickness = 0.5));
        connect(Dehumidifying_MultipersonOffice.inTransition[1], enableDehumidifying_MultipersonOffice.outPlaces[1]) annotation (
          Line(points={{120,66.48},{120,66.48},{120,74},{131.64,74},{131.64,73}},thickness = 0.5));
        connect(disableHumidifying_MultipersonOffice.inPlaces[1], Humidifying_MultipersonOffice.outTransition[1]) annotation (
          Line(points={{168.36,47},{180,47},{180,54},{180,53.52},{180,53.52}},   thickness = 0.5));
        connect(enableHumidifying_MultipersonOffice.outPlaces[1], Humidifying_MultipersonOffice.inTransition[1]) annotation (
          Line(points={{168.36,73},{180,73},{180,66},{180,66.48},{180,66.48}},   thickness = 0.5));
        connect(Off_Hum_MultipersonOffice.outTransition[1], enableHumidifying_MultipersonOffice.inPlaces[1]) annotation (
          Line(points={{150.3,66.48},{150.3,66.48},{150.3,74},{161.64,74},{161.64,
                73}},                                                            thickness = 0.5));
        connect(disableHumidifying_MultipersonOffice.outPlaces[1], Off_Hum_MultipersonOffice.inTransition[1]) annotation (
          Line(points={{161.64,47},{150,47},{150,54},{150,53.52},{150.3,53.52}}, thickness = 0.5));
        connect(disableDehumidifying_MultipersonOffice.outPlaces[1], Off_Hum_MultipersonOffice.inTransition[2]) annotation (
          Line(points={{138.36,47},{149.7,47},{149.7,53.52}},
                                                           thickness = 0.5));
        connect(Off_Hum_MultipersonOffice.outTransition[2], enableDehumidifying_MultipersonOffice.inPlaces[1]) annotation (
          Line(points={{149.7,66.48},{149.7,66.48},{149.7,74},{138.36,74},{138.36,
                73}},                                                            thickness = 0.5));
        connect(enableHumidifying_Canteen.outPlaces[1], Humidifying_Canteen.inTransition[1]) annotation (
          Line(points={{68.36,13},{80,13},{80,6},{80,6.48},{80,6.48}},   thickness = 0.5));
        connect(Humidifying_Canteen.outTransition[1], disableHumidifying_Canteen.inPlaces[1]) annotation (
          Line(points={{80,-6.48},{80,-13},{68.36,-13}},  thickness = 0.5));
        connect(disableHumidifying_Canteen.outPlaces[1], Off_Hum_Canteen.inTransition[1]) annotation (
          Line(points={{61.64,-13},{50,-13},{50,-6},{50,-6.48},{50.3,-6.48}}, thickness = 0.5));
        connect(Dehumidifying_Canteen.outTransition[1], disableDehumidifying_Canteen.inPlaces[1]) annotation (
          Line(points={{20,-6.48},{20,-6.48},{20,-12},{31.64,-12},{31.64,-13}},thickness = 0.5));
        connect(Dehumidifying_Canteen.inTransition[1], enableDehumidifying_Canteen.outPlaces[1]) annotation (
          Line(points={{20,6.48},{20,6.48},{20,14},{31.64,14},{31.64,13}},thickness = 0.5));
        connect(disableDehumidifying_Canteen.outPlaces[1], Off_Hum_Canteen.inTransition[2]) annotation (
          Line(points={{38.36,-13},{50,-13},{50,-6},{50,-6.48},{49.7,-6.48}}, thickness = 0.5));
        connect(Off_Hum_Canteen.outTransition[2], enableDehumidifying_Canteen.inPlaces[1]) annotation (
          Line(points={{49.7,6.48},{49.7,6.48},{49.7,14},{38,14},{38,13},{38.36,
                13}},                                                               thickness = 0.5));
        connect(Off_Hum_Canteen.outTransition[1], enableHumidifying_Canteen.inPlaces[1]) annotation (
          Line(points={{50.3,6.48},{50.3,6.48},{50.3,14},{61.64,14},{61.64,13}},
                                                                          thickness = 0.5));
        connect(disableDehumidifying_Workshop.outPlaces[1], Off_Hum_Workshop.inTransition[2]) annotation (
          Line(points={{38.36,47},{50,47},{50,54},{50,53.52},{49.7,53.52}}, thickness = 0.5));
        connect(enableDehumidifying_Workshop.inPlaces[1], Off_Hum_Workshop.outTransition[2]) annotation (
          Line(points={{38.36,73},{50,73},{50,66},{50,66.48},{49.7,66.48}}, thickness = 0.5));
        connect(Dehumidifying_Workshop.outTransition[1], disableDehumidifying_Workshop.inPlaces[1]) annotation (
          Line(points={{20,53.52},{20,53.52},{20,48},{31.64,48},{31.64,47}},thickness = 0.5));
        connect(Dehumidifying_Workshop.inTransition[1], enableDehumidifying_Workshop.outPlaces[1]) annotation (
          Line(points={{20,66.48},{20,66.48},{20,74},{31.64,74},{31.64,73}},thickness = 0.5));
        connect(disableHumidifying_Workshop.outPlaces[1], Off_Hum_Workshop.inTransition[1]) annotation (
          Line(points={{61.64,47},{50,47},{50,54},{50,53.52},{50.3,53.52}}, thickness = 0.5));
        connect(disableHumidifying_Workshop.inPlaces[1], Humidifying_Workshop.outTransition[1]) annotation (
          Line(points={{68.36,47},{80,47},{80,54},{80,53.52},{80,53.52}},   thickness = 0.5));
        connect(enableHumidifying_Workshop.outPlaces[1], Humidifying_Workshop.inTransition[1]) annotation (
          Line(points={{68.36,73},{80,73},{80,66},{80,66},{80,66.48},{80,66.48}},     thickness = 0.5));
        connect(Off_Hum_Workshop.outTransition[1], enableHumidifying_Workshop.inPlaces[1]) annotation (
          Line(points={{50.3,66.48},{50.3,66.48},{50.3,74},{61.64,74},{61.64,73}},
                                                                            thickness = 0.5));
        connect(Off_Hum_Workshop.pd_t, integerToBoolean2[1].u) annotation (
          Line(points={{43.64,60},{43.64,30},{100,30},{100,-78.8}},  color = {255, 127, 0}));
        connect(Dehumidifying_Workshop.pd_t, integerToBoolean2[3].u) annotation (
          Line(points={{26.36,60},{28,60},{28,30},{100,30},{100,-78.8},{100,-78.8}},       color = {255, 127, 0}));
        connect(Humidifying_Workshop.pd_t, integerToBoolean2[2].u) annotation (
          Line(points={{86.36,60},{100,60},{100,-78},{100,-78.8},{100,-78.8}},     color = {255, 127, 0}));
        connect(integerToBoolean2[1].y, Hum[1]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-100.533},{100,-100.533}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[2].y, Hum[2]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-101.6},{100,-101.6}},  color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[3].y, Hum[3]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-102.667},{100,-102.667}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[4].y, Hum[4]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-103.733},{100,-103.733}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[5].y, Hum[5]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-104.8},{100,-104.8}},  color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[6].y, Hum[6]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-105.867},{100,-105.867}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[7].y, Hum[7]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-106.933},{100,-106.933}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[8].y, Hum[8]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-108},{100,-108}},      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[9].y, Hum[9]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-109.067},{100,-109.067}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[10].y, Hum[10]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-110.133},{100,-110.133}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[11].y, Hum[11]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-111.2},{100,-111.2}},  color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[12].y, Hum[12]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-112.267},{100,-112.267}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[13].y, Hum[13]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-113.333},{100,-113.333}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[14].y, Hum[14]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-114.4},{100,-114.4}},  color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean2[15].y, Hum[15]) annotation (
          Line(points={{100,-92.6},{100,-92.6},{100,-115.467},{100,-115.467}},
                                                                            color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[15].y, Temp[15]) annotation (
          Line(points={{-100,-90.6},{-101,-90.6},{-101,-90.6},{-100,-90.6},{
                -100,-115.467},{-100,-115.467}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[14].y, Temp[14]) annotation (
          Line(points={{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,
                -114.4},{-100,-114.4}},                                                                               color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[13].y, Temp[13]) annotation (
          Line(points={{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,-90.6},{
                -100,-113.333},{-100,-113.333}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[12].y, Temp[12]) annotation (
          Line(points={{-100,-90.6},{-101,-90.6},{-101,-90.6},{-100,-90.6},{
                -100,-112.267},{-100,-112.267}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[11].y, Temp[11]) annotation (
          Line(points={{-100,-90.6},{-101,-90.6},{-101,-90.6},{-100,-90.6},{-100,
                -111.2},{-100,-111.2}},                                                                               color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[10].y, Temp[10]) annotation (
          Line(points={{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,-90.6},{
                -100,-110.133},{-100,-110.133}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[9].y, Temp[9]) annotation (
          Line(points={{-100,-90.6},{-101,-90.6},{-101,-90.6},{-100,-90.6},{
                -100,-109.067},{-100,-109.067}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[8].y, Temp[8]) annotation (
          Line(points={{-100,-90.6},{-101,-90.6},{-101,-90.6},{-100,-90.6},{-100,
                -108},{-100,-108}},                                                                                   color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[7].y, Temp[7]) annotation (
          Line(points={{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,-90.6},{
                -100,-106.933},{-100,-106.933}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[6].y, Temp[6]) annotation (
          Line(points={{-100,-90.6},{-101,-90.6},{-101,-90.6},{-100,-90.6},{
                -100,-105.867},{-100,-105.867}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[5].y, Temp[5]) annotation (
          Line(points={{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,
                -104.8},{-100,-104.8}},                                                                               color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[4].y, Temp[4]) annotation (
          Line(points={{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,-90.6},{
                -100,-103.733},{-100,-103.733}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[3].y, Temp[3]) annotation (
          Line(points={{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,-90.6},{
                -100,-102.667},{-100,-102.667}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[2].y, Temp[2]) annotation (
          Line(points={{-100,-90.6},{-101,-90.6},{-101,-90.6},{-100,-90.6},{-100,
                -101.6},{-100,-101.6}},                                                                               color = {255, 0, 255}, thickness = 0.5));
        connect(integerToBoolean1[1].y, Temp[1]) annotation (
          Line(points={{-100,-90.6},{-100,-90.6},{-100,-90.6},{-100,-90.6},{
                -100,-100.533},{-100,-100.533}},                                                                      color = {255, 0, 255}, thickness = 0.5));
        connect(Off_Canteen.pd_t, integerToBoolean1[4].u) annotation (
          Line(points={{-154.36,0},{-155.36,0},{-155.36,0},{-154.36,0},{-154.36,
                -30},{-100.36,-30},{-100.36,-76},{-104.36,-76},{-104.36,-76.8},{
                -100,-76.8}},                                                                                                                                                     color = {255, 127, 0}));
        connect(Off_Workshop.pd_t, integerToBoolean1[1].u) annotation (
          Line(points={{-156.36,60},{-156.36,60},{-156.36,28},{-100.36,28},{
                -100.36,-76},{-104.36,-76},{-104.36,-76.8},{-100,-76.8}},                                                                             color = {255, 127, 0}));
        connect(Heating_Workshop.pd_t, integerToBoolean1[2].u) annotation (
          Line(points={{-113.64,60},{-99.64,60},{-99.64,-76},{-99.64,-76},{-99.64,
                -76},{-99.64,-76.8},{-100,-76.8}},                                                                                color = {255, 127, 0}));
        connect(Cooling_Workshop.pd_t, integerToBoolean1[3].u) annotation (
          Line(points={{-173.64,60},{-175.64,60},{-175.64,28},{-99.64,28},{-99.64,
                -76},{-103.64,-76},{-103.64,-76.8},{-100,-76.8}},                                                                                  color = {255, 127, 0}));
        connect(Heating_Canteen.pd_t, integerToBoolean1[5].u) annotation (
          Line(points={{-111.64,0},{-99.64,0},{-99.64,-76},{-99.64,-76},{-99.64,
                -76},{-99.64,-76.8},{-100,-76.8}},                                                                              color = {255, 127, 0}));
        connect(Cooling_Canteen.pd_t, integerToBoolean1[6].u) annotation (
          Line(points={{-171.64,0},{-171.64,0},{-171.64,-30},{-99.64,-30},{-99.64,
                -76},{-99.64,-76},{-99.64,-76.8},{-100,-76.8}},                                                                                  color = {255, 127, 0}));
        connect(Off_ConferenceRoom.pd_t, integerToBoolean1[7].u) annotation (
          Line(points={{-154.36,-60},{-153.36,-60},{-153.36,-60},{-154.36,-60},{
                -154.36,-30},{-100.36,-30},{-100.36,-76},{-101.36,-76},{-101.36,
                -76.8},{-100,-76.8}},                                                                                                                                                     color = {255, 127, 0}));
        connect(Heating_ConferenceRoom.pd_t, integerToBoolean1[8].u) annotation (
          Line(points={{-111.64,-60},{-105.64,-60},{-105.64,-60},{-99.64,-60},{
                -99.64,-76},{-99.64,-76},{-99.64,-76},{-99.64,-76.8},{-100,-76.8}},                                                                                 color = {255, 127, 0}));
        connect(Cooling_ConferenceRoom.pd_t, integerToBoolean1[9].u) annotation (
          Line(points={{-171.64,-60},{-171.64,-60},{-171.64,-30},{-99.64,-30},{
                -99.64,-76.8},{-100,-76.8}},                                                                           color = {255, 127, 0}));
        connect(Off_MultipersonOffice.pd_t, integerToBoolean1[10].u) annotation (
          Line(points={{-66.36,62},{-71.36,62},{-71.36,62},{-68.36,62},{-68.36,28},
                {-100.36,28},{-100.36,-76},{-104.36,-76},{-104.36,-76.8},{-100,
                -76.8}},                                                                                                                                                       color = {255, 127, 0}));
        connect(Heating_MultipersonOffice.pd_t, integerToBoolean1[11].u) annotation (
          Line(points={{-23.64,62},{-19.64,62},{-19.64,28},{-99.64,28},{-99.64,
                -76},{-99.64,-76},{-99.64,-76},{-99.64,-76.8},{-100,-76.8}},                                                                                 color = {255, 127, 0}));
        connect(Cooling_MultipersonOffice.pd_t, integerToBoolean1[12].u) annotation (
          Line(points={{-83.64,62},{-81.64,62},{-81.64,28},{-99.64,28},{-99.64,
                -76},{-99.64,-76},{-99.64,-76.8},{-100,-76.8}},                                                                               color = {255, 127, 0}));
        connect(Off_OpenplanOffice.pd_t, integerToBoolean1[13].u) annotation (
          Line(points={{-64.36,0},{-64.36,0},{-64.36,-30},{-100.36,-30},{-100.36,
                -76.8},{-100,-76.8}},                                                                              color = {255, 127, 0}));
        connect(Heating_OpenplanOffice.pd_t, integerToBoolean1[14].u) annotation (
          Line(points={{-21.64,0},{-17.64,0},{-17.64,-30},{-99.64,-30},{-99.64,
                -76},{-99.64,-76},{-99.64,-76},{-99.64,-76.8},{-100,-76.8}},                                                                                 color = {255, 127, 0}));
        connect(Cooling_OpenplanOffice.pd_t, integerToBoolean1[15].u) annotation (
          Line(points={{-81.64,0},{-81.64,0},{-81.64,-30},{-99.64,-30},{-99.64,
                -76.8},{-100,-76.8}},                                                                           color = {255, 127, 0}));
        connect(Cooling_ConferenceRoom.inTransition[1], enableCooling_ConferenceRoom.outPlaces[1]) annotation (
          Line(points={{-178,-53.52},{-178,-53.52},{-178,-53.52},{-178,-53.52},{
                -178,-45.52},{-166.36,-45.52},{-166.36,-47}},                                                                             thickness = 0.5));
        connect(Cooling_ConferenceRoom.outTransition[1], disableCooling_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{-178,-66.48},{-178,-66.48},{-178,-66.48},{-178,-66.48},{
                -178,-74.48},{-166.36,-74.48},{-166.36,-73}},                                                                             thickness = 0.5));
        connect(Off_ConferenceRoom.outTransition[1], enableHeating_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{-147.7,-53.52},{-148,-53.52},{-148,-53.52},{-148,-53.52},
                {-148,-47.52},{-136,-47.52},{-136,-46.52},{-136,-47},{-136.36,-47}},                                                                                      thickness = 0.5));
        connect(enableHeating_ConferenceRoom.outPlaces[1], Heating_ConferenceRoom.inTransition[1]) annotation (
          Line(points={{-129.64,-47},{-123.64,-47},{-123.64,-45},{-117.64,-45},{
                -117.64,-53},{-117.64,-53},{-117.64,-54},{-117.64,-53.52},{-118,
                -53.52}},                                                                                                                                                 thickness = 0.5));
        connect(Off_ConferenceRoom.outTransition[2], enableCooling_ConferenceRoom.inPlaces[1]) annotation (
          Line(points={{-148.3,-53.52},{-150,-53.52},{-150,-53.52},{-148,-53.52},
                {-148,-47.52},{-160,-47.52},{-160,-46.52},{-160,-47},{-159.64,-47}},                                                                                      thickness = 0.5));
        connect(Off_ConferenceRoom.inTransition[1], disableHeating_ConferenceRoom.outPlaces[1]) annotation (
          Line(points={{-147.7,-66.48},{-148,-66.48},{-148,-66.48},{-148,-66.48},
                {-148,-74.48},{-136,-74.48},{-136,-73.48},{-136,-73},{-136.36,-73}},                                                                                      thickness = 0.5));
        connect(disableCooling_ConferenceRoom.outPlaces[1], Off_ConferenceRoom.inTransition[2]) annotation (
          Line(points={{-159.64,-73},{-153.64,-73},{-153.64,-71},{-147.64,-71},{
                -147.64,-65},{-147.64,-65},{-147.64,-66},{-147.64,-66.48},{-148.3,
                -66.48}},                                                                                                                                                 thickness = 0.5));
        connect(disableHeating_ConferenceRoom.inPlaces[1], Heating_ConferenceRoom.outTransition[1]) annotation (
          Line(points={{-129.64,-73},{-124.64,-73},{-124.64,-71},{-117.64,-71},{
                -117.64,-65},{-117.64,-65},{-117.64,-67},{-117.64,-66.48},{-118,
                -66.48}},                                                                                                                                                 thickness = 0.5));
        connect(Cooling_OpenplanOffice.inTransition[1], enableCooling_OpenplanOffice.outPlaces[1]) annotation (
          Line(points={{-88,6.48},{-88,6.48},{-88,6.48},{-88,6.48},{-88,12.48},{
                -76.36,12.48},{-76.36,13}},                                                                             thickness = 0.5));
        connect(Cooling_OpenplanOffice.outTransition[1], disableCooling_OpenplanOffice.inPlaces[1]) annotation (
          Line(points={{-88,-6.48},{-88,-6.48},{-88,-6.48},{-88,-6.48},{-88,
                -12.48},{-76,-12.48},{-76,-12.48},{-76,-12.48},{-76,-13},{-76.36,
                -13}},                                                                                                                                                      thickness = 0.5));
        connect(enableHeating_OpenplanOffice.outPlaces[1], Heating_OpenplanOffice.inTransition[1]) annotation (
          Line(points={{-39.64,13},{-34.64,13},{-34.64,15},{-27.64,15},{-27.64,7},
                {-27.64,7},{-27.64,5},{-27.64,6.48},{-28,6.48}},                                                                                   thickness = 0.5));
        connect(Off_OpenplanOffice.outTransition[1], enableHeating_OpenplanOffice.inPlaces[1]) annotation (
          Line(points={{-57.7,6.48},{-58,6.48},{-58,6.48},{-58,6.48},{-58,14.48},
                {-46.36,14.48},{-46.36,13}},                                                                            thickness = 0.5));
        connect(enableCooling_OpenplanOffice.inPlaces[1], Off_OpenplanOffice.outTransition[2]) annotation (
          Line(points={{-69.64,13},{-63.64,13},{-63.64,15},{-57.64,15},{-57.64,7},
                {-57.64,7},{-57.64,5},{-57.64,6.48},{-58.3,6.48}},                                                                                 thickness = 0.5));
        connect(Off_OpenplanOffice.inTransition[1], disableHeating_OpenplanOffice.outPlaces[1]) annotation (
          Line(points={{-57.7,-6.48},{-58,-6.48},{-58,-6.48},{-58,-6.48},{-58,
                -12.48},{-46,-12.48},{-46,-12.48},{-46,-13},{-46.36,-13}},                                                                                   thickness = 0.5));
        connect(disableCooling_OpenplanOffice.outPlaces[1], Off_OpenplanOffice.inTransition[2]) annotation (
          Line(points={{-69.64,-13},{-64.64,-13},{-64.64,-11},{-57.64,-11},{
                -57.64,-5},{-57.64,-5},{-57.64,-6},{-57.64,-6.48},{-58.3,-6.48}},                                                                           thickness = 0.5));
        connect(disableHeating_OpenplanOffice.inPlaces[1], Heating_OpenplanOffice.outTransition[1]) annotation (
          Line(points={{-39.64,-13},{-34.64,-13},{-34.64,-11},{-27.64,-11},{
                -27.64,-5},{-27.64,-5},{-27.64,-7},{-27.64,-6.48},{-28,-6.48}},                                                                             thickness = 0.5));
        connect(Cooling_Canteen.inTransition[1], enableCooling_Canteen.outPlaces[1]) annotation (
          Line(points={{-178,6.48},{-177,6.48},{-177,6.48},{-176,6.48},{-176,
                12.48},{-166.36,12.48},{-166.36,13}},                                                                          thickness = 0.5));
        connect(Cooling_Canteen.outTransition[1], disableCooling_Canteen.inPlaces[1]) annotation (
          Line(points={{-178,-6.48},{-178,-6.48},{-178,-6.48},{-178,-6.48},{-178,
                -12.48},{-166.36,-12.48},{-166.36,-13}},                                                                              thickness = 0.5));
        connect(enableHeating_Canteen.outPlaces[1], Heating_Canteen.inTransition[1]) annotation (
          Line(points={{-129.64,13},{-124.64,13},{-124.64,15},{-117.64,15},{
                -117.64,7},{-117.64,7},{-117.64,5},{-117.64,6.48},{-118,6.48}},                                                                             thickness = 0.5));
        connect(Off_Canteen.outTransition[1], enableHeating_Canteen.inPlaces[1]) annotation (
          Line(points={{-147.7,6.48},{-152,6.48},{-152,6.48},{-148,6.48},{-148,
                14.48},{-136,14.48},{-136,14.48},{-136,13},{-136.36,13}},                                                                                    thickness = 0.5));
        connect(Off_Canteen.outTransition[2], enableCooling_Canteen.inPlaces[1]) annotation (
          Line(points={{-148.3,6.48},{-152,6.48},{-152,6.48},{-148,6.48},{-148,
                12.48},{-160,12.48},{-160,13.48},{-160,13},{-159.64,13}},                                                                                    thickness = 0.5));
        connect(Off_Canteen.inTransition[1], disableHeating_Canteen.outPlaces[1]) annotation (
          Line(points={{-147.7,-6.48},{-149,-6.48},{-149,-6.48},{-148,-6.48},{
                -148,-12.48},{-136,-12.48},{-136,-12.48},{-136,-13},{-136.36,-13}},                                                                                   thickness = 0.5));
        connect(disableCooling_Canteen.outPlaces[1], Off_Canteen.inTransition[2]) annotation (
          Line(points={{-159.64,-13},{-154.64,-13},{-154.64,-11},{-147.64,-11},{
                -147.64,-5},{-147.64,-5},{-147.64,-7},{-147.64,-6.48},{-148.3,
                -6.48}},                                                                                                                                             thickness = 0.5));
        connect(disableHeating_Canteen.inPlaces[1], Heating_Canteen.outTransition[1]) annotation (
          Line(points={{-129.64,-13},{-124.64,-13},{-124.64,-11},{-117.64,-11},{
                -117.64,-7},{-117.64,-7},{-117.64,-5},{-118.64,-5},{-118.64,-6.48},
                {-118,-6.48}},                                                                                                                                                      thickness = 0.5));
        connect(Cooling_MultipersonOffice.inTransition[1], enableCooling_MultipersonOffice.outPlaces[1]) annotation (
          Line(points={{-90,68.48},{-94,68.48},{-94,68.48},{-90,68.48},{-90,74.48},
                {-78.36,74.48},{-78.36,75}},                                                                                thickness = 0.5));
        connect(Cooling_MultipersonOffice.outTransition[1], disableCooling_MultipersonOffice.inPlaces[1]) annotation (
          Line(points={{-90,55.52},{-90,55.52},{-90,55.52},{-90,55.52},{-90,47.52},
                {-78,47.52},{-78,48.52},{-78,49},{-78.36,49}},                                                                                          thickness = 0.5));
        connect(enableHeating_MultipersonOffice.outPlaces[1], Heating_MultipersonOffice.inTransition[1]) annotation (
          Line(points={{-41.64,75},{-35.64,75},{-35.64,77},{-27.64,77},{-27.64,69},
                {-29.64,69},{-29.64,68},{-29.64,68.48},{-30,68.48}},                                                                                    thickness = 0.5));
        connect(Off_MultipersonOffice.outTransition[1], enableHeating_MultipersonOffice.inPlaces[1]) annotation (
          Line(points={{-59.7,68.48},{-64,68.48},{-64,68.48},{-60,68.48},{-60,
                76.48},{-48,76.48},{-48,76.48},{-48,75},{-48.36,75}},                                                                                   thickness = 0.5));
        connect(enableCooling_MultipersonOffice.inPlaces[1], Off_MultipersonOffice.outTransition[2]) annotation (
          Line(points={{-71.64,75},{-65.64,75},{-65.64,77},{-59.64,77},{-59.64,69},
                {-59.64,69},{-59.64,68},{-59.64,68.48},{-60.3,68.48}},                                                                                  thickness = 0.5));
        connect(Off_MultipersonOffice.inTransition[1], disableHeating_MultipersonOffice.outPlaces[1]) annotation (
          Line(points={{-59.7,55.52},{-62,55.52},{-62,55.52},{-60,55.52},{-60,
                49.52},{-48.36,49.52},{-48.36,49}},                                                                         thickness = 0.5));
        connect(disableCooling_MultipersonOffice.outPlaces[1], Off_MultipersonOffice.inTransition[2]) annotation (
          Line(points={{-71.64,49},{-66.64,49},{-66.64,51},{-59.64,51},{-59.64,57},
                {-59.64,57},{-59.64,56},{-59.64,55.52},{-60.3,55.52}},                                                                                  thickness = 0.5));
        connect(disableHeating_MultipersonOffice.inPlaces[1], Heating_MultipersonOffice.outTransition[1]) annotation (
          Line(points={{-41.64,49},{-35.64,49},{-35.64,51},{-29.64,51},{-29.64,57},
                {-29.64,57},{-29.64,56},{-29.64,55.52},{-30,55.52}},                                                                                    thickness = 0.5));
        connect(Off_Workshop.outTransition[2], enableCooling_Workshop.inPlaces[1]) annotation (
          Line(points={{-150.3,66.48},{-154,66.48},{-154,66.48},{-150,66.48},{
                -150,74.48},{-162,74.48},{-162,74.48},{-162,73},{-161.64,73}},                                                                                   thickness = 0.5));
        connect(Cooling_Workshop.inTransition[1], enableCooling_Workshop.outPlaces[1]) annotation (
          Line(points={{-180,66.48},{-180,66.48},{-180,66.48},{-180,66.48},{-180,
                74.48},{-168.36,74.48},{-168.36,73}},                                                                              thickness = 0.5));
        connect(Off_Workshop.outTransition[1], enableHeating_Workshop.inPlaces[1]) annotation (
          Line(points={{-149.7,66.48},{-150,66.48},{-150,66.48},{-150,66.48},{
                -150,74.48},{-138,74.48},{-138,74.48},{-138,73},{-138.36,73}},                                                                                   thickness = 0.5));
        connect(enableHeating_Workshop.outPlaces[1], Heating_Workshop.inTransition[1]) annotation (
          Line(points={{-131.64,73},{-125.64,73},{-125.64,75},{-119.64,75},{
                -119.64,67},{-119.64,67},{-119.64,65},{-119.64,66.48},{-120,66.48}},                                                                             thickness = 0.5));
        connect(Off_Workshop.inTransition[1], disableHeating_Workshop.outPlaces[1]) annotation (
          Line(points={{-149.7,53.52},{-152,53.52},{-152,53.52},{-150,53.52},{
                -150,47.52},{-138.36,47.52},{-138.36,47}},                                                                         thickness = 0.5));
        connect(disableHeating_Workshop.inPlaces[1], Heating_Workshop.outTransition[1]) annotation (
          Line(points={{-131.64,47},{-126.64,47},{-126.64,49},{-119.64,49},{
                -119.64,50},{-119.64,53.52},{-120,53.52}},                                                                         thickness = 0.5));
        connect(disableCooling_Workshop.outPlaces[1], Off_Workshop.inTransition[2]) annotation (
          Line(points={{-161.64,47},{-156.64,47},{-156.64,49},{-149.64,49},{
                -149.64,55},{-149.64,55},{-149.64,53},{-149.64,53.52},{-150.3,
                53.52}},                                                                                                                                         thickness = 0.5));
        connect(Cooling_Workshop.outTransition[1], disableCooling_Workshop.inPlaces[1]) annotation (
          Line(points={{-180,53.52},{-180,53.52},{-180,53.52},{-180,53.52},{-180,
                47.52},{-168.36,47.52},{-168.36,47}},                                                                              thickness = 0.5));
        connect(Off_Hum_Canteen.pd_t, integerToBoolean2[4].u) annotation (Line(
              points={{43.64,0},{42,0},{42,-32},{100,-32},{100,-78.8}}, color={
                255,127,0}));
        connect(Humidifying_Canteen.pd_t, integerToBoolean2[5].u) annotation (
            Line(points={{86.36,0},{100,0},{100,-78.8}}, color={255,127,0}));
        connect(Dehumidifying_Canteen.pd_t, integerToBoolean2[6].u) annotation (
            Line(points={{26.36,0},{26,0},{26,-32},{100,-32},{100,-78.8}}, color=
                {255,127,0}));
        connect(Off_Hum_ConferenceRoom.pd_t, integerToBoolean2[7].u) annotation (
            Line(points={{43.64,-60},{44,-60},{44,-32},{100,-32},{100,-78.8}},
              color={255,127,0}));
        connect(Humidifying_ConferenceRoom.pd_t, integerToBoolean2[8].u)
          annotation (Line(points={{86.36,-60},{100,-60},{100,-78.8}}, color={255,
                127,0}));
        connect(Dehumidifying_ConferenceRoom.pd_t, integerToBoolean2[9].u)
          annotation (Line(points={{26.36,-60},{26,-60},{26,-32},{100,-32},{100,
                -78.8}}, color={255,127,0}));
        connect(Off_Hum_MultipersonOffice.pd_t, integerToBoolean2[10].u)
          annotation (Line(points={{143.64,60},{144,60},{144,30},{100,30},{100,
                -78.8}}, color={255,127,0}));
        connect(Humidifying_MultipersonOffice.pd_t, integerToBoolean2[11].u)
          annotation (Line(points={{186.36,60},{194,60},{194,30},{100,30},{100,
                -78.8}}, color={255,127,0}));
        connect(Dehumidifying_MultipersonOffice.pd_t, integerToBoolean2[12].u)
          annotation (Line(points={{126.36,60},{128,60},{128,30},{100,30},{100,
                -78.8}}, color={255,127,0}));
        connect(Off_Hum_OpenplanOffice.pd_t, integerToBoolean2[13].u) annotation (
           Line(points={{143.64,0},{142,0},{142,-32},{100,-32},{100,-78.8}},
              color={255,127,0}));
        connect(Humidifying_OpenplanOffice.pd_t, integerToBoolean2[14].u)
          annotation (Line(points={{186.36,0},{192,0},{192,-32},{100,-32},{100,
                -78.8}}, color={255,127,0}));
        connect(Dehumidifying_OpenplanOffice.pd_t, integerToBoolean2[15].u)
          annotation (Line(points={{126.36,0},{126,0},{126,-32},{100,-32},{100,
                -78.8}}, color={255,127,0}));
        annotation (
          Icon(graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                  fillPattern =                                                                           FillPattern.Solid,
                  lineThickness =                                                                                                            0.5, extent = {{-200, 100}, {200, -100}}), Text(origin = {-16, 21}, lineColor = {95, 95, 95}, extent = {{-68, 33}, {98, -71}}, textString = "Management
Level
Temperature
and Humidity")},   coordinateSystem(extent = {{-200, -100}, {200, 100}})),
          Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
          __OpenModelica_commandLineOptions = "",
          Documentation(info = "<html><head></head><body>Managementebene der MODI-Methode<div><br></div><div>Auswahl eines übergeordneten Betriebsmodus für jeden Raum basierend auf der gemessenen Raumtemperatur und der gemessenen Raumluftfeuchte</div><div><br></div><div><br></div><div><br></div><div><br></div><div><div>Struktur des Temperature-Output-Vektors</div><div><br></div><div><br></div><div>Off_Workshop</div><div>Heating_Workshop</div><div>Cooling_Workshop</div><div><br></div><div><div>Off_Canteen</div><div>Heating_Canteen</div><div>Cooling_Canteen</div></div><div><br></div><div><div>Off_ConferenceRoom</div><div>Heating_ConferenceRoom</div><div>Cooling_ConferenceRoom</div></div><div><br></div><div><div>Off_MultipersonOffice</div><div>Heating_MultipersonOffice</div><div>Cooling_MultipersonOffice</div></div><div><br></div><div><div>Off_OpenplanOffice</div><div>Heating_OpenplanOffice</div><div>Cooling_OpenplanOffice</div></div></div><div><br></div><div><br></div><div><br></div><div>Struktur des humidity-Output-Vektors:</div><div><br></div><div><div><br></div><div><br></div><div>Off_Hum_Workshop</div><div>Humidifying_Workshop</div><div>Dehumidifying_Workshop</div><div><br></div><div><div>Off_Hum_Canteen</div><div>Humidifying_Canteen</div><div>Dehumidifying_Canteen</div></div><div><br></div><div><div>Off_Hum_ConferenceRoom</div><div>Humidifying_ConferenceRoom</div><div>Dehumidifying_ConferenceRoom</div></div><div><br></div><div><div>Off_Hum_MultipersonOffice</div><div>Humidifying_MultipersonOffice</div><div>Dehumidifying_MultipersonOffice</div></div><div><br></div><div><div>Off_Hum_OpenplanOffice</div><div>Humidifying_OpenplanOffice</div><div>Dehumidifying_OpenplanOffice</div></div></div><div><br></div></body></html>"));
      end ManagementLevel_Temp_Hum;
    end old;

  end Level;

  package Controller
    model Controller_HTSSystem
      Modelica.Blocks.Sources.Constant rpmPumps(k = rpm_pumps) annotation (
        Placement(visible = true, transformation(extent={{20,40},{40,60}},      rotation = 0)));
      Modelica.Blocks.Sources.Constant TChpSet(final k = T_chp_set) annotation (
        Placement(visible = true, transformation(extent={{20,-60},{40,-40}},      rotation = 0)));
      AixLib.Controls.Continuous.LimPID PIDBoiler(Td = 0, Ti = 60, controllerType = Modelica.Blocks.Types.SimpleController.PID,
        k=0.01,                                                                                                                           reverseAction = false, strict = true, yMax = 1, yMin = 0) annotation (
        Placement(visible = true, transformation(extent={{-60,40},{-40,60}},     rotation = 0)));
      Modelica.Blocks.Sources.Constant TBoilerSet_out(final k = T_boi_set) annotation (
        Placement(visible = true, transformation(extent={{-90,40},{-70,60}},     rotation = 0)));
      parameter Real T_boi_set = 273.15 + 80 "Set point temperature of boiler" annotation (
        Dialog(enable = true, group = "CHP, Boiler and Pumps"));
      parameter Real T_chp_set = 333.15 "Set point temperature of chp" annotation (
        Dialog(enable = true, group = "CHP, Boiler and Pumps"));
      parameter Real rpm_pumps = 3000 "Setpoint rpm pumps" annotation (
        Dialog(enable = true, group = "CHP, Boiler and Pumps"));
      AixLib.Systems.Benchmark.BaseClasses.HighTempSystemBus highTempSystemBus1 annotation (
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput HTS_Heating_I annotation (
        Placement(visible = true, transformation(origin={114,80},    extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin={114,80},    extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput HTS_Heating_II annotation (
        Placement(visible = true, transformation(origin={114,-80},    extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin={114,-80},    extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or1 annotation (
        Placement(visible = true, transformation(origin={-80,10},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(visible=
             true, transformation(extent={{-90,-40},{-70,-20}}, rotation=0)));
    equation
      connect(rpmPumps.y, highTempSystemBus1.pumpBoilerBus.pumpBus.rpmSet) annotation (
        Line(points={{41,50},{60,50},{60,0},{100.05,0},{100.05,0.05}},                      color = {0, 0, 127}));
      connect(HTS_Heating_II, highTempSystemBus1.pumpBoilerBus.pumpBus.onSet) annotation (
        Line(points={{114,-80},{-40,-80},{-40,0},{100,0},{100,0.05},{100.05,
              0.05}},                                                                                        color = {255, 0, 255}));
      connect(or1.y, highTempSystemBus1.pumpChpBus.pumpBus.onSet) annotation (
        Line(points={{-69,10},{-40,10},{-40,0},{100.05,0},{100.05,0.05}},            color = {255, 0, 255}));
      connect(or1.y, highTempSystemBus1.onOffChpSet) annotation (
        Line(points={{-69,10},{-40,10},{-40,0.05},{100.05,0.05}},                    color = {255, 0, 255}));
      connect(highTempSystemBus1.pumpBoilerBus.TRtrnInMea, PIDBoiler.u_m) annotation (
        Line(points={{100.05,0.05},{100,0.05},{100,-80},{-100,-80},{-100,30},{
              -50,30},{-50,38}},                                                                           color = {0, 0, 127}));
      connect(HTS_Heating_II, or1.u2) annotation (
        Line(points={{114,-80},{-100,-80},{-100,2},{-92,2}},                                  color = {255, 0, 255}));
      connect(HTS_Heating_I, or1.u1) annotation (
        Line(points={{114,80},{-100,80},{-100,10},{-92,10}},                                color = {255, 0, 255}));
      connect(TBoilerSet_out.y, PIDBoiler.u_s) annotation (
        Line(points={{-69,50},{-62,50}}, color = {0, 0, 127}));
      connect(TChpSet.y, highTempSystemBus1.TChpSet) annotation (
        Line(points={{41,-50},{60,-50},{60,0},{100.05,0},{100.05,0.05}},
                                                                  color = {0, 0, 127}));
      connect(rpmPumps.y, highTempSystemBus1.pumpChpBus.pumpBus.rpmSet) annotation (
        Line(points={{41,50},{60,50},{60,0},{100.05,0},{100.05,0.05}},
                                                                color = {0, 0, 127}));
      connect(PIDBoiler.y, switch1.u1) annotation (Line(points={{-39,50},{-30,
              50},{-30,38},{-22,38}}, color={0,0,127}));
      connect(const.y, switch1.u3) annotation (Line(points={{-69,-30},{-40,-30},
              {-40,22},{-22,22}}, color={0,0,127}));
      connect(HTS_Heating_II, switch1.u2) annotation (Line(points={{114,-80},{
              -100,-80},{-100,30},{-22,30}}, color={255,0,255}));
      connect(switch1.y, highTempSystemBus1.uRelBoilerSet) annotation (Line(
            points={{1,30},{20,30},{20,0.05},{100.05,0.05}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Line(points = {{20, 80}, {80, 0}, {40, -80}}, color = {95, 95, 95}, thickness = 0.5), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-80, 20}, {66, -20}}, textString = "Control"), Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-52, 22}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-48, 24}, {152, -64}}, textString = "Controller 
 HTS\nSystem")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>Controller für das Hochtemperatur-System des Benchmark-Gebäudes</body></html>"));
    end Controller_HTSSystem;

    model Controller_GTFSystem
      Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (
        Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanInput GTF_On "Connector of Boolean input signal" annotation (
        Placement(visible = true, transformation(origin = {108, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {108, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant rpm(k = rpmPump) annotation (
        Placement(visible = true, transformation(extent = {{0, -70}, {20, -50}}, rotation = 0)));
      parameter Real rpmPump(min = 0, unit = "1") = 2100 "Rpm of the pump";
      AixLib.Systems.EONERC_MainBuilding.BaseClasses.TwoCircuitBus gtfBus annotation (
        Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(rpm.y, gtfBus.primBus.pumpBus.rpmSet) annotation (
        Line(points = {{21, -60}, {100, -60}, {100, -59.95}, {100.05, -59.95}}, color = {0, 0, 127}));
      connect(GTF_On, gtfBus.primBus.pumpBus.onSet) annotation (
        Line(points = {{108, 60}, {80, 60}, {80, -60}, {98, -60}, {98, -59.95}, {100.05, -59.95}}, color = {255, 0, 255}));
      connect(booleanToReal.y, gtfBus.secBus.valveSet) annotation (
        Line(points = {{50, -1}, {50, -59.95}, {100.05, -59.95}}, color = {0, 0, 127}));
      connect(booleanToReal.u, GTF_On) annotation (
        Line(points = {{50, 22}, {50, 60}, {108, 60}}, color = {255, 0, 255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Line(points = {{20, 80}, {80, 0}, {40, -80}}, color = {95, 95, 95}, thickness = 0.5), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-80, 20}, {66, -20}}, textString = "Control"), Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-56, 36}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-44, 22}, {152, -92}}, textString = "Controller 
 GTF\nSystem")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(revisions = "<html>
    <ul>
    <li>January 22, 2019, by Alexander K&uuml;mpel:<br/>External T_set added.</li>
    <li>October 25, 2017, by Alexander K&uuml;mpel:<br/>First implementation.</li>
    </ul>
    </html>", info = "<html><head></head><body><p>Controller für das Geothermiefeld-System des Benchmark-Gebäudes</p>
    </body></html>"));
    end Controller_GTFSystem;

    model Controller_HPSystem
      parameter Real rpmPumpHot=2820;
      parameter Real rpmPumpCold=1750;
      Modelica.Blocks.Interfaces.BooleanInput HP_Heating annotation (Placement(
          visible=true,
          transformation(
            origin={106,80},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={106,80},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput HP_Cooling annotation (
        Placement(visible = true, transformation(origin = {106, -80}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, -80}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      AixLib.Systems.EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus heatPumpSystemBus1 annotation (
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput HP_Combi annotation (
        Placement(visible = true, transformation(origin = {106, -40}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, -40}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or11 annotation (
        Placement(visible = true, transformation(origin={50,90},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Interfaces.RealInput T_HotStorage annotation (
        Placement(visible = true, transformation(origin = {-80, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {-80, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
      Modelica.Blocks.Interfaces.RealInput T_Condensator annotation (
        Placement(visible = true, transformation(origin = {-40, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {-40, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
      Modelica.Blocks.Interfaces.RealInput T_Evaporator annotation (
        Placement(visible = true, transformation(origin = {0, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {0, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
      Modelica.Blocks.Interfaces.RealInput T_ColdStorage annotation (
        Placement(visible = true, transformation(origin = {40, -110}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {40, -110}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant rpm_pump_hot(k = rpmPumpHot) annotation (
        Placement(visible = true, transformation(origin={20,-70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant rpm_pump_cold(k = rpmPumpCold) annotation (
        Placement(visible = true, transformation(origin={20,-40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Or or13 annotation (
        Placement(visible = true, transformation(origin={10,70},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.BooleanToReal Throttle_HotStorage
        annotation (Placement(transformation(extent={{-90,80},{-70,100}})));
      Modelica.Blocks.Math.BooleanToReal Throttle_Recool
        annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
      Modelica.Blocks.Math.BooleanToReal Throttle_Freecool
        annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
      Modelica.Blocks.Math.BooleanToReal Throttle_ColdStorage
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      EONERC_MainBuilding.Controller.EonERCModeControl.CtrHP ctrHP
        annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
    equation
      connect(rpm_pump_hot.y, heatPumpSystemBus1.busPumpHot.pumpBus.rpmSet) annotation (
        Line(points={{31,-70},{40,-70},{40,0},{98,0},{98,0.05},{100.05,0.05}},                            color = {0, 0, 127}));
      connect(rpm_pump_cold.y, heatPumpSystemBus1.busPumpCold.pumpBus.rpmSet) annotation (
        Line(points={{31,-40},{40,-40},{40,0},{98,0},{98,0.05},{100.05,0.05}},      color = {0, 0, 127}));
      connect(T_HotStorage, ctrHP.T_HS) annotation (Line(points={{-80,-108},{-80,-60},
              {-41.8,-60}}, color={0,0,127}));
      connect(T_Condensator, ctrHP.T_con) annotation (Line(points={{-40,-108},{-40,-86},
              {-60,-86},{-60,-65},{-41.8,-65}}, color={0,0,127}));
      connect(T_ColdStorage, ctrHP.T_CS) annotation (Line(points={{40,-110},{40,-86},
              {-60,-86},{-60,-75.1},{-41.7,-75.1}}, color={0,0,127}));
      connect(T_Evaporator, ctrHP.T_ev) annotation (Line(points={{0,-108},{0,-86},{-60,
              -86},{-60,-80},{-41.8,-80}}, color={0,0,127}));
      connect(Throttle_HotStorage.y, heatPumpSystemBus1.busThrottleHS.valveSet)
        annotation (Line(points={{-69,90},{-60,90},{-60,0.05},{100.05,0.05}}, color=
             {0,0,127}));
      connect(Throttle_Recool.y, heatPumpSystemBus1.busThrottleRecool.valveSet)
        annotation (Line(points={{-69,60},{-60,60},{-60,0.05},{100.05,0.05}}, color=
             {0,0,127}));
      connect(Throttle_Freecool.y, heatPumpSystemBus1.busThrottleFreecool.valveSet)
        annotation (Line(points={{-69,30},{-60,30},{-60,0.05},{100.05,0.05}}, color=
             {0,0,127}));
      connect(Throttle_ColdStorage.y, heatPumpSystemBus1.busThrottleCS.valveSet)
        annotation (Line(points={{-69,0},{16,0},{16,0.05},{100.05,0.05}}, color={0,0,
              127}));
      connect(HP_Cooling, Throttle_Recool.u) annotation (Line(points={{106,-80},{80,
              -80},{80,-20},{-100,-20},{-100,60},{-92,60}}, color={255,0,255}));
      connect(HP_Combi, or11.u1) annotation (Line(points={{106,-40},{80,-40},{
              80,90},{62,90}},  color={255,0,255}));
      connect(or11.y, Throttle_HotStorage.u) annotation (Line(points={{39,90},{
              -20,90},{-20,-20},{-100,-20},{-100,90},{-92,90}},
                                                        color={255,0,255}));
      connect(or11.y, or13.u2) annotation (Line(points={{39,90},{30,90},{30,78},
              {22,78}},
                    color={255,0,255}));
      connect(HP_Cooling, or13.u1) annotation (Line(points={{106,-80},{80,-80},
              {80,70},{22,70}},
                        color={255,0,255}));
      connect(or13.y, Throttle_ColdStorage.u) annotation (Line(points={{-1,70},
              {-20,70},{-20,-20},{-100,-20},{-100,0},{-92,0}},
                                                          color={255,0,255}));
      connect(booleanExpression.y, ctrHP.allowOperation) annotation (Line(points={{-79,
              -40},{-30,-40},{-30,-58}}, color={255,0,255}));
      connect(ctrHP.N_rel, heatPumpSystemBus1.busHP.N) annotation (Line(points={{-19,
              -70},{0,-70},{0,0.05},{100.05,0.05}}, color={0,0,127}));
      connect(ctrHP.On, heatPumpSystemBus1.busHP.onOff) annotation (Line(points={{-19,
              -66},{0,-66},{0,0},{50,0},{50,0.05},{100.05,0.05}}, color={255,0,255}));
      connect(ctrHP.pumpsOn, heatPumpSystemBus1.busPumpHot.pumpBus.onSet)
        annotation (Line(points={{-19,-62},{0,-62},{0,0},{100.05,0},{100.05,0.05}},
            color={255,0,255}));
      connect(ctrHP.pumpsOn, heatPumpSystemBus1.busPumpCold.pumpBus.onSet)
        annotation (Line(points={{-19,-62},{0,-62},{0,0.05},{100.05,0.05}}, color={255,
              0,255}));
      connect(or11.y, ctrHP.heatingModeActive) annotation (Line(points={{39,90},
              {-20,90},{-20,-20},{-60,-20},{-60,-70},{-41.8,-70}},
                                                              color={255,0,255}));
      connect(HP_Heating, or11.u2) annotation (Line(points={{106,80},{80,80},{
              80,98},{62,98}},         color={255,0,255}));
      connect(HP_Heating, Throttle_Freecool.u) annotation (Line(points={{106,80},
              {80,80},{80,-20},{-100,-20},{-100,30},{-92,30}}, color={255,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                              FillPattern.Solid,
                lineThickness =                                                                                                                                                                               0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-50, 26}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-48, 24}, {150, -72}}, textString = "Controller 
 HP\nSystem")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>Controller für das Wärmepumpen-System des Benchmark-Gebäudes</body></html>"));
    end Controller_HPSystem;

    model Controller_SwitchingUnit
      parameter Real rpmPump;
      AixLib.Systems.EONERC_MainBuilding.BaseClasses.SwitchingUnitBus switchingUnitBus1 annotation (
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput Heating_GTF annotation (
        Placement(visible = true, transformation(origin = {106, 80}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, 80}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Heating_GTFandCon annotation (
        Placement(visible = true, transformation(origin = {106, 40}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, 40}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_GTF annotation (
        Placement(visible = true, transformation(origin = {106, -20}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, -20}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_HP annotation (
        Placement(visible = true, transformation(origin = {106, -60}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, -60}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_GTFandHP annotation (
        Placement(visible = true, transformation(origin = {106, -100}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, -100}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant rpm_pump(k = rpmPump) annotation (
        Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = 1) annotation (
        Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch K1 annotation (
        Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch K2 annotation (
        Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch K3 annotation (
        Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch K4 annotation (
        Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch Y2 annotation (
        Placement(visible = true, transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch Y3 annotation (
        Placement(visible = true, transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Or or1 annotation (
        Placement(visible = true, transformation(origin = {70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or11 annotation (
        Placement(visible = true, transformation(origin={68,-28},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or13 annotation (
        Placement(visible = true, transformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or14 annotation (
        Placement(visible = true, transformation(origin={30,30},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    equation
      connect(or1.y, K3.u2) annotation (
        Line(points={{59,90},{-20,90},{-20,16},{-74,16},{-74,0},{-62,0}},              color = {255, 0, 255}));
      connect(or14.y, Y3.u2) annotation (
        Line(points={{19,30},{12,30},{12,-100},{-20,-100},{-20,-74},{-74,-74},{
              -74,-90},{-62,-90}},                                                                                   color = {255, 0, 255}));
      connect(or14.y, K1.u2) annotation (
        Line(points={{19,30},{12,30},{12,90},{-20,90},{-20,80},{-74,80},{-74,60},
              {-62,60}},                                                                                     color = {255, 0, 255}));
      connect(or13.y, or14.u1) annotation (
        Line(points={{59,-70},{52,-70},{52,30},{42,30}},                              color = {255, 0, 255}));
      connect(Cooling_GTFandHP, or13.u1) annotation (
        Line(points = {{106, -100}, {90, -100}, {90, -70}, {82, -70}}, color = {255, 0, 255}));
      connect(Cooling_HP, or13.u2) annotation (
        Line(points = {{106, -60}, {90, -60}, {90, -62}, {82, -62}}, color = {255, 0, 255}));
      connect(Heating_GTFandCon, or14.u2) annotation (
        Line(points={{106,40},{48,40},{48,38},{42,38}},                              color = {255, 0, 255}));
      connect(or11.y, K2.u2) annotation (
        Line(points={{57,-28},{51.5,-28},{51.5,-100},{-20,-100},{-20,46},{-74,
              46},{-74,30},{-62,30}},                                                                                  color = {255, 0, 255}));
      connect(or11.y, Y2.u2) annotation (
        Line(points={{57,-28},{51.5,-28},{51.5,-100},{-20,-100},{-20,-44},{-74,
              -44},{-74,-60},{-62,-60}},                                                                                   color = {255, 0, 255}));
      connect(Cooling_GTF, or11.u2) annotation (
        Line(points={{106,-20},{80,-20}},                            color = {255, 0, 255}));
      connect(Cooling_GTFandHP, or11.u1) annotation (
        Line(points={{106,-100},{90,-100},{90,-28},{80,-28}},          color = {255, 0, 255}));
      connect(or1.y, K4.u2) annotation (
        Line(points={{59,90},{-20,90},{-20,-14},{-74,-14},{-74,-30},{-62,-30},{
              -62,-30},{-62,-30}},                                                                                   color = {255, 0, 255}));
      connect(or1.y, switchingUnitBus1.pumpBus.onSet) annotation (
        Line(points={{59,90},{-20,90},{-20,0},{100,0},{100,0.05},{100.05,0.05}},     color = {255, 0, 255}));
      connect(Heating_GTFandCon, or1.u1) annotation (
        Line(points = {{106, 40}, {90, 40}, {90, 90}, {82, 90}}, color = {255, 0, 255}));
      connect(Heating_GTF, or1.u2) annotation (
        Line(points = {{106, 80}, {90, 80}, {90, 98}, {82, 98}, {82, 98}, {82, 98}}, color = {255, 0, 255}));
      connect(Y3.y, switchingUnitBus1.Y3valSet) annotation (
        Line(points={{-39,-90},{-20,-90},{-20,0},{100,0},{100,0.05},{100.05,
              0.05}},                                                                   color = {0, 0, 127}));
      connect(Y2.y, switchingUnitBus1.Y2valSet) annotation (
        Line(points={{-39,-60},{-20,-60},{-20,0},{100,0},{100,0.05},{100.05,
              0.05}},                                                                   color = {0, 0, 127}));
      connect(K4.y, switchingUnitBus1.K4valSet) annotation (
        Line(points={{-39,-30},{-20,-30},{-20,0},{100,0},{100,0.05},{100.05,
              0.05}},                                                                   color = {0, 0, 127}));
      connect(K3.y, switchingUnitBus1.K3valSet) annotation (
        Line(points={{-39,0},{100,0},{100,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(K2.y, switchingUnitBus1.K2valSet) annotation (
        Line(points={{-39,30},{-20,30},{-20,0},{100,0},{100,0.05},{100.05,0.05}},     color = {0, 0, 127}));
      connect(K1.y, switchingUnitBus1.K1valSet) annotation (
        Line(points={{-39,60},{-20,60},{-20,0},{102,0},{102,0.05},{100.05,0.05}},     color = {0, 0, 127}));
      connect(Y3.u3, const2.y) annotation (
        Line(points={{-62,-98},{-74,-98},{-74,-20},{-80,-20},{-80,-20},{-79,-20}},              color = {0, 0, 127}));
      connect(const2.y, Y2.u3) annotation (
        Line(points={{-79,-20},{-74,-20},{-74,-68},{-64,-68},{-64,-68},{-62,-68}},              color = {0, 0, 127}));
      connect(const2.y, K4.u3) annotation (
        Line(points={{-79,-20},{-74,-20},{-74,-38},{-62,-38},{-62,-38},{-62,-38}},              color = {0, 0, 127}));
      connect(const2.y, K3.u3) annotation (
        Line(points={{-79,-20},{-74,-20},{-74,-8},{-62,-8},{-62,-8},{-62,-8}},              color = {0, 0, 127}));
      connect(const2.y, K2.u3) annotation (
        Line(points={{-79,-20},{-74,-20},{-74,22},{-64,22},{-64,22},{-62,22}},              color = {0, 0, 127}));
      connect(const2.y, K1.u3) annotation (
        Line(points={{-79,-20},{-74,-20},{-74,52},{-62,52},{-62,52},{-62,52}},              color = {0, 0, 127}));
      connect(const1.y, Y3.u1) annotation (
        Line(points={{-79,20},{-74,20},{-74,-82},{-62,-82},{-62,-82},{-62,-82}},              color = {0, 0, 127}));
      connect(const1.y, Y2.u1) annotation (
        Line(points={{-79,20},{-74,20},{-74,-52},{-62,-52},{-62,-52},{-62,-52}},              color = {0, 0, 127}));
      connect(const1.y, K4.u1) annotation (
        Line(points={{-79,20},{-74,20},{-74,-22},{-62,-22},{-62,-22},{-62,-22}},              color = {0, 0, 127}));
      connect(const1.y, K3.u1) annotation (
        Line(points={{-79,20},{-74,20},{-74,8},{-64,8},{-64,8},{-62,8}},              color = {0, 0, 127}));
      connect(const1.y, K2.u1) annotation (
        Line(points={{-79,20},{-74,20},{-74,38},{-62,38},{-62,38},{-62,38}},              color = {0, 0, 127}));
      connect(const1.y, K1.u1) annotation (
        Line(points={{-79,20},{-74,20},{-74,68},{-62,68},{-62,68},{-62,68},{-62,
              68}},                                                                                  color = {0, 0, 127}));
      connect(rpm_pump.y, switchingUnitBus1.pumpBus.rpmSet) annotation (
        Line(points={{-79,90},{-19.5,90},{-19.5,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                              FillPattern.Solid,
                lineThickness =                                                                                                                                                                               0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-52, 28}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-48, 24}, {150, -76}}, textString = "Controller \n Switching\nUnit")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Controller_SwitchingUnit;

    model Controller_VU
      parameter Real y_start_Hot = 0 annotation (
        Dialog(enable = true, group = "Hot Circuit"));
      parameter Real k_Hot = 0.025 "Gain of controller" annotation (
        Dialog(enable = true, group = "Hot Circuit"));
      parameter Modelica.SIunits.Time Ti_Hot = 130 "Time constant of Integrator block" annotation (
        Dialog(enable = true, group = "Hot Circuit"));
      parameter Modelica.SIunits.Time Td_Hot = 4 "Time constant of Integrator block" annotation (
        Dialog(enable = true, group = "Hot Circuit"));
      parameter Real xi_start_Hot = 0 annotation (
        Dialog(enable = true, group = "Hot Circuit"));
      parameter Real xd_start_Hot = 0 annotation (
        Dialog(enable = true, group = "Hot Circuit"));
      parameter Real y_start_Cold = 0 annotation (
        Dialog(enable = true, group = "Cold Circuit"));
      parameter Real k_Cold = 0.025 "Gain of controller" annotation (
        Dialog(enable = true, group = "Cold Circuit"));
      parameter Modelica.SIunits.Time Ti_Cold = 130 "Time constant of Integrator block" annotation (
        Dialog(enable = true, group = "Cold Circuit"));
      parameter Modelica.SIunits.Time Td_Cold = 4 "Time constant of Integrator block" annotation (
        Dialog(enable = true, group = "Cold Circuit"));
      parameter Real xi_start_Cold = 0 annotation (
        Dialog(enable = true, group = "Cold Circuit"));
      parameter Real xd_start_Cold = 0 annotation (
        Dialog(enable = true, group = "Cold Circuit"));
      parameter Real yStart = 0 annotation (
        Dialog(enable = true, group = "Fan Controller"));
      parameter Real k_Fan = 0.01 "Gain of controller" annotation (
        Dialog(enable = true, group = "Fan Controller"));
      parameter Modelica.SIunits.Time Ti_Fan = 60 "Time constant of Integrator block" annotation (
        Dialog(enable = true, group = "Fan Controller"));
      parameter Real rpm_pump_hot(min = 0, unit = "1") = 2000 "Rpm of the Pump" annotation (
        Dialog(enable = true, group = "Hot Circuit"));
      parameter Real rpm_pump_cold(min = 0, unit = "1") = 2000 "Rpm of the Pump" annotation (
        Dialog(enable = true, group = "Cold Circuit"));
      parameter Modelica.SIunits.Temperature TRoomSet = 293.15 "Flow temperature set point of room" annotation (
        Dialog(enable = useExternalTset == false, group = "TSetController"));
      parameter Modelica.SIunits.VolumeFlowRate VFlowSet "Set value of volume flow [m^3/s]" annotation (
        dialog(group = "Fan Controller"));
      parameter Real k_TSet = 0.2 "Gain of controller" annotation (
        Dialog(enable = true, group = "Set Temperature Controller"));
      parameter Modelica.SIunits.Time Ti_TSet = 300 "Time constant of Integrator block" annotation (
        Dialog(enable = true, group = "Set Temperature Controller"));
      parameter Real yMax_TSet = 298.15 "Upper limit of output" annotation (
        Dialog(enable = true, group = "Set Temperature Controller"));
      parameter Real yMin_TSet = 289.15 "Lower limit of output" annotation (
        Dialog(enable = true, group = "Set Temperature Controller"));
      Modelica.Blocks.Interfaces.RealInput TRoomMea annotation (
        Placement(visible = true, transformation(origin = {106, 80}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {106, 80}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling annotation (
        Placement(visible = true, transformation(origin = {106, -80}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {106, -80}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant constTflowSet(k = TRoomSet) annotation (
        Placement(visible = true, transformation(origin = {-82, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Continuous.LimPID PID_TSet(Ti = Ti_TSet, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = k_TSet, limitsAtInit = true, yMax = yMax_TSet, yMin = yMin_TSet) annotation (
        Placement(visible = true, transformation(origin = {-52, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput Heating annotation (
        Placement(visible = true, transformation(origin = {106, -40}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {106, -40}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      ModularAHU.BaseClasses.GenericAHUBus genericAHUBus1 annotation (
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constRpmPump_hot(k = rpm_pump_hot) annotation (
        Placement(visible = true, transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Switch switch1 annotation (
        Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch11 annotation (
        Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constRpmPump_cold(k = rpm_pump_cold) annotation (
        Placement(visible = true, transformation(origin = {90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant ConstVflow(k = VFlowSet) annotation (
        Placement(visible = true, transformation(origin = {-80, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Controls.Continuous.LimPID PID_Hot(Nd = 10, Ni = 0.9, Td = Td_Hot, Ti = Ti_Hot,
        initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,                                                                     k = k_Hot, reverseAction = true, strict = true, wd = 0, wp = 1, xd_start = xd_start_Hot, xi_start = xi_start_Hot, yMax = 1, yMin = 0, y_start = y_start_Hot) annotation (
        Placement(visible = true, transformation(origin = {-20, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Controls.Continuous.LimPID PID_Cold(Nd = 10, Ni = 0.9, Td = Td_Cold, Ti = Ti_Cold,
        initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,                                                                        k = k_Cold, strict = true, wd = 0, wp = 1, xd_start = xd_start_Cold, xi_start = xi_start_Cold, yMax = 1, yMin = 0, y_start = y_start_Cold) annotation (
        Placement(visible = true, transformation(origin = {-20, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Controls.Continuous.LimPID PID_Fan(Nd = 10, Ni = 0.9, Td = 0, Ti = Ti_Fan,
        initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,                                                                 k = k_Fan, reset = AixLib.Types.Reset.Disabled, strict = true, wd = 0, wp = 1, yMax = 1, yMin = 0, y_start = yStart) annotation (
        Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(genericAHUBus1.heaterBus.hydraulicBus.TFwrdOutMea, PID_Hot.u_m) annotation (
        Line(points={{100.05,0.05},{60,0.05},{60,100},{-100,100},{-100,50},{-20,
              50},{-20,68}},                                                                                               color = {0, 0, 127}));
      connect(genericAHUBus1.coolerBus.hydraulicBus.TFwrdOutMea, PID_Cold.u_m) annotation (
        Line(points={{100.05,0.05},{40,0.05},{40,-40},{-20,-40},{-20,-32},{-20,
              -32},{-20,-32}},                                                                        color = {0, 0, 127}));
      connect(TRoomMea, PID_TSet.u_m) annotation (
        Line(points={{106,80},{106,79.5},{60,79.5},{60,100},{-100,100},{-100,
              9.5},{-52,9.5},{-52,18}},                                                                               color = {0, 0, 127}));
      connect(Heating, switch1.u2) annotation (
        Line(points = {{106, -40}, {-100, -40}, {-100, 50}, {-2, 50}}, color = {255, 0, 255}));
      connect(PID_Fan.y, genericAHUBus1.flapSupSet) annotation (
        Line(points={{-29,-60},{40,-60},{40,0.05},{100.05,0.05}},                       color = {0, 0, 127}));
      connect(switch1.y, genericAHUBus1.heaterBus.hydraulicBus.valveSet) annotation (
        Line(points={{21,50},{40,50},{40,0},{100,0},{100,0.05},{100.05,0.05}},     color = {0, 0, 127}));
      connect(switch11.y, genericAHUBus1.coolerBus.hydraulicBus.valveSet) annotation (
        Line(points={{21,10},{40,10},{40,0},{100,0},{100,0.05},{100.05,0.05}},     color = {0, 0, 127}));
      connect(genericAHUBus1.heaterBus.VFlowAirMea, PID_Fan.u_m) annotation (
        Line(points={{100.05,0.05},{60,0.05},{60,-100},{-40,-100},{-40,-72}},   color = {0, 0, 127}));
      connect(Cooling, switch11.u2) annotation (
        Line(points = {{106, -80}, {-100, -80}, {-100, 10}, {-2, 10}}, color = {255, 0, 255}));
      connect(ConstVflow.y, PID_Fan.u_s) annotation (
        Line(points={{-69,-60},{-51,-60},{-51,-60},{-53,-60},{-53,-60},{-52,-60}},              color = {0, 0, 127}));
      connect(PID_TSet.y, PID_Cold.u_s) annotation (
        Line(points={{-41,30},{-40,30},{-40,30},{-39,30},{-39,-20},{-33,-20},{
              -33,-20},{-33,-20},{-33,-20},{-32,-20}},                                                                                      color = {0, 0, 127}));
      connect(PID_Cold.y, switch11.u1) annotation (
        Line(points = {{-9, -20}, {-7, -20}, {-7, 18}, {-4.5, 18}, {-4.5, 18}, {-2, 18}}, color = {0, 0, 127}));
      connect(PID_TSet.y, PID_Hot.u_s) annotation (
        Line(points={{-41,30},{-40,30},{-40,30},{-39,30},{-39,30},{-39,30},{-39,
              80},{-33,80},{-33,80},{-33,80},{-33,80},{-32,80}},                                                                                            color = {0, 0, 127}));
      connect(PID_Hot.y, switch1.u1) annotation (
        Line(points={{-9,80},{-7,80},{-7,58},{-1,58},{-1,58},{-3,58},{-3,58},{
              -2,58}},                                                                                  color = {0, 0, 127}));
      connect(const.y, switch11.u3) annotation (
        Line(points = {{-9, 30}, {-8, 30}, {-8, 30}, {-7, 30}, {-7, 2}, {-4.5, 2}, {-4.5, 2}, {-3.25, 2}, {-3.25, 2}, {-2, 2}}, color = {0, 0, 127}));
      connect(const.y, switch1.u3) annotation (
        Line(points = {{-9, 30}, {-9.0625, 30}, {-9.0625, 30}, {-9.125, 30}, {-9.125, 30}, {-5.25, 30}, {-5.25, 30}, {-3.5, 30}, {-3.5, 42}, {-3.75, 42}, {-3.75, 42}, {-2.875, 42}, {-2.875, 42}, {-2, 42}}, color = {0, 0, 127}));
      connect(constTflowSet.y, PID_TSet.u_s) annotation (
        Line(points = {{-71, 30}, {-64, 30}}, color = {0, 0, 127}));
      connect(constRpmPump_cold.y, genericAHUBus1.coolerBus.hydraulicBus.pumpBus.rpmSet) annotation (
        Line(points = {{79, 20}, {60.75, 20}, {60.75, 0}, {60, 0}, {60, 0.05}, {100.05, 0.05}}, color = {0, 0, 127}));
      connect(constRpmPump_hot.y, genericAHUBus1.heaterBus.hydraulicBus.pumpBus.rpmSet) annotation (
        Line(points = {{79, 50}, {60.75, 50}, {60.75, 0}, {60.5, 0}, {60.5, 0.05}, {80.275, 0.05}, {80.275, 0.05}, {100.05, 0.05}}, color = {0, 0, 127}));
      connect(Cooling, genericAHUBus1.coolerBus.hydraulicBus.pumpBus.onSet) annotation (
        Line(points = {{106, -80}, {80, -80}, {80, 0}, {100, 0}, {100, 0.05}, {100.05, 0.05}}, color = {255, 0, 255}));
      connect(Heating, genericAHUBus1.heaterBus.hydraulicBus.pumpBus.onSet) annotation (
        Line(points = {{106, -40}, {80, -40}, {80, 0}, {98, 0}, {98, 0.05}, {100.05, 0.05}}, color = {255, 0, 255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                              FillPattern.Solid,
                lineThickness =                                                                                                                                                                               0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-24, -12}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-76, 68}, {124, -40}}, textString = "Controller 
 Ventilation\nUnit")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>Controller für die raumlufttechnischen Anlagen in den Räumen des Benchmark-Gebäudes</body></html>"));
    end Controller_VU;

    model Controller_Tabs
      parameter Real k_Hot(min = 0, unit = "1") = 0.025 "Gain of Controller" annotation (
        Dialog(group = "Hot Circuit"));
      parameter Modelica.SIunits.Time Ti_Hot(min = Modelica.Constants.small) = 130 "Time constant of Integrator block" annotation (
        Dialog(group = "Hot Circuit"));
      parameter Modelica.SIunits.Time Td_Hot(min = 0) = 4 "Time constant of Derivative block" annotation (
        Dialog(group = "Hot Circuit"));
      parameter Modelica.Blocks.Types.InitPID initType_Hot = .Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation (
        Dialog(group = "Hot Circuit"));
      parameter Boolean reverseAction_Hot = false "Set to true for throttling the water flow rate through a cooling coil controller" annotation (
        Dialog(group = "Hot Circuit"));
      parameter Real xi_start_Hot = 0 "Initial or guess value value for integrator output (= integrator state)" annotation (
        Dialog(group = "Hot Circuit"));
      parameter Real xd_start_Hot = 0 "Initial or guess value for state of derivative block" annotation (
        Dialog(group = "Hot Circuit"));
      parameter Real y_start_Hot = 0 "Initial value of output" annotation (
        Dialog(group = "Hot Circuit"));
      parameter Real k_Cold(min = 0, unit = "1") = 0.025 "Gain of Controller" annotation (
        Dialog(group = "Cold Circuit"));
      parameter Modelica.SIunits.Time Ti_Cold(min = Modelica.Constants.small) = 130 "Time constant of Integrator block" annotation (
        Dialog(group = "Cold Circuit"));
      parameter Modelica.SIunits.Time Td_Cold(min = 0) = 4 "Time constant of Derivative block" annotation (
        Dialog(group = "Cold Circuit"));
      parameter Modelica.Blocks.Types.InitPID initType_Cold = .Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation (
        Dialog(group = "Cold Circuit"));
      parameter Boolean reverseAction_Cold = false "Set to true for throttling the water flow rate through a cooling coil controller" annotation (
        Dialog(group = "Cold Circuit"));
      parameter Real xi_start_Cold = 0 "Initial or guess value value for integrator output (= integrator state)" annotation (
        Dialog(group = "Cold Circuit"));
      parameter Real xd_start_Cold = 0 "Initial or guess value for state of derivative block" annotation (
        Dialog(group = "Cold Circuit"));
      parameter Real y_start_Cold = 0 "Initial value of output" annotation (
        Dialog(group = "Cold Circuit"));
      parameter Real rpm_pump_hot(min = 0, unit = "1") = 2000 "Rpm of the Pump" annotation (
        Dialog(enable = true, group = "Pumps"));
      parameter Real rpm_pump_cold(min = 0, unit = "1") = 2000 "Rpm of the Pump" annotation (
        Dialog(enable = true, group = "Pumps"));
      parameter Real rpm_pump_tabs(min = 0, unit = "1") = 2500 "Rpm of the Pump" annotation (
        Dialog(enable = true, group = "Pumps"));
      parameter Modelica.SIunits.Temperature TflowSet = 289.15 "Flow temperature set point of room" annotation (
        Dialog(enable = useExternalTset == false));
      Modelica.Blocks.Interfaces.BooleanInput Heating annotation (
        Placement(visible = true, transformation(origin = {106, -40}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {106, -40}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling annotation (
        Placement(visible = true, transformation(origin = {104, -80}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {104, -80}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant ConstTflowSet1(k = TflowSet) annotation (
        Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add1(k2 = -1) annotation (
        Placement(visible = true, transformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = 0.25) annotation (
        Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant ConstRpmPumpTabs(k = rpm_pump_tabs) annotation (
        Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Or or1 annotation (
        Placement(visible = true, transformation(origin = {70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Switch switch1 annotation (
        Placement(visible = true, transformation(origin = {20, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const3(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant ConstRpmPumpHot(k = rpm_pump_hot) annotation (
        Placement(visible = true, transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch2 annotation (
        Placement(visible = true, transformation(origin = {22, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant ConstRpmPumpCold(k = rpm_pump_cold) annotation (
        Placement(visible = true, transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant ConstTflowSet2(k = TflowSet) annotation (
        Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add2 annotation (
        Placement(visible = true, transformation(origin = {-50, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const4(k = 0.25) annotation (
        Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Benchmark.BaseClasses.TabsBus2 tabsBus21 annotation (
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Controls.Continuous.LimPID PID_Hot(Nd = 10, Ni = 0.9, Td = Td_Hot, Ti = Ti_Hot, initType = initType_Hot, k = k_Hot, reverseAction = reverseAction_Hot, strict = true, wd = 0, wp = 1, xd_start = xd_start_Hot, xi_start = xi_start_Hot, yMax = 1, yMin = 0, y_start = y_start_Hot) annotation (
        Placement(visible = true, transformation(origin = {-20, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Controls.Continuous.LimPID PID_Cold(Nd = 10, Ni = 0.9, Td = Td_Cold, Ti = Ti_Cold, initType = initType_Cold, k = k_Cold, reverseAction = reverseAction_Cold, strict = true, wd = 0, wp = 1, xd_start = xd_start_Cold, xi_start = xi_start_Cold, yMax = 1, yMin = 0, y_start = y_start_Cold) annotation (
        Placement(visible = true, transformation(origin = {-20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(Heating, switch1.u2) annotation (
        Line(points = {{106, -40}, {40, -40}, {40, 64}, {0, 64}, {0, 79}, {8, 79}, {8, 80}}, color = {255, 0, 255}));
      connect(const3.y, switch2.u3) annotation (
        Line(points = {{-9, 40}, {0, 40}, {0, 10}, {10, 10}}, color = {0, 0, 127}));
      connect(const3.y, switch1.u3) annotation (
        Line(points = {{-9, 40}, {0, 40}, {0, 71}, {8, 71}, {8, 72}}, color = {0, 0, 127}));
      connect(PID_Cold.y, switch2.u1) annotation (
        Line(points = {{-9, -2}, {0, -2}, {0, 26}, {10, 26}}, color = {0, 0, 127}));
      connect(Cooling, switch2.u2) annotation (
        Line(points = {{104, -80}, {0, -80}, {0, 18}, {10, 18}}, color = {255, 0, 255}));
      connect(switch2.y, tabsBus21.coldThrottleBus.valveSet) annotation (
        Line(points={{33,18},{40,18},{40,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(add2.y, PID_Cold.u_s) annotation (
        Line(points = {{-39, -2}, {-32, -2}}, color = {0, 0, 127}));
      connect(tabsBus21.coldThrottleBus.TFwrdOutMea, PID_Cold.u_m) annotation (
        Line(points={{100.05,0.05},{40,0.05},{40,-30},{-20,-30},{-20,-14}},   color = {0, 0, 127}));
      connect(ConstTflowSet2.y, add2.u1) annotation (
        Line(points = {{-79, 30}, {-76, 30}, {-76, 4}, {-62, 4}}, color = {0, 0, 127}));
      connect(const4.y, add2.u2) annotation (
        Line(points = {{-79, 0}, {-72.5, 0}, {-72.5, -8}, {-62, -8}}, color = {0, 0, 127}));
      connect(tabsBus21.hotThrottleBus.TFwrdOutMea, PID_Hot.u_m) annotation (
        Line(points={{100.05,0.05},{40,0.05},{40,64},{-20,64},{-20,78}},   color = {0, 0, 127}));
      connect(add1.y, PID_Hot.u_s) annotation (
        Line(points={{-39,90},{-32,90},{-32,90},{-32,90}},          color = {0, 0, 127}));
      connect(PID_Hot.y, switch1.u1) annotation (
        Line(points={{-9,90},{8,90},{8,88},{8,88}},          color = {0, 0, 127}));
      connect(Cooling, tabsBus21.coldThrottleBus.pumpBus.onSet) annotation (
        Line(points={{104,-80},{40,-80},{40,0.05},{100.05,0.05}}, color = {255, 0, 255}));
      connect(ConstRpmPumpTabs.y, tabsBus21.pumpBus.pumpBus.rpmSet) annotation (
        Line(points={{-79,-30},{40,-30},{40,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(ConstRpmPumpHot.y, tabsBus21.hotThrottleBus.pumpBus.rpmSet) annotation (
        Line(points={{-79,-60},{40,-60},{40,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(ConstRpmPumpCold.y, tabsBus21.coldThrottleBus.pumpBus.rpmSet) annotation (
        Line(points={{-79,-90},{40,-90},{40,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(switch1.y, tabsBus21.hotThrottleBus.valveSet) annotation (
        Line(points={{31,80},{40,80},{40,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(ConstTflowSet1.y, add1.u1) annotation (
        Line(points = {{-79, 90}, {-70, 90}, {-70, 96}, {-62, 96}}, color = {0, 0, 127}));
      connect(const1.y, add1.u2) annotation (
        Line(points = {{-79, 60}, {-70, 60}, {-70, 84}, {-62, 84}}, color = {0, 0, 127}));
      connect(Heating, tabsBus21.hotThrottleBus.pumpBus.onSet) annotation (
        Line(points={{106,-40},{86,-40},{86,0},{98,0},{98,0.05},{100.05,0.05}},     color = {255, 0, 255}));
      connect(or1.y, tabsBus21.pumpBus.pumpBus.onSet) annotation (
        Line(points={{59,-60},{40,-60},{40,0},{102,0},{102,0.05},{100.05,0.05}},     color = {255, 0, 255}));
      connect(Heating, or1.u2) annotation (
        Line(points = {{106, -40}, {86, -40}, {86, -52}, {82, -52}}, color = {255, 0, 255}));
      connect(Cooling, or1.u1) annotation (
        Line(points = {{104, -80}, {86, -80}, {86, -60}, {82, -60}}, color = {255, 0, 255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                              FillPattern.Solid,
                lineThickness =                                                                                                                                                                               0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-34, 10}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-64, 36}, {132, -50}}, textString = "Controller\nConcrete Core\nActivation")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>Controller für die Betonkerntemperierung in den Räumen des Benchmark-Gebäudes</body></html>"));
    end Controller_Tabs;

    model Controller_HX
      Modelica.Blocks.Sources.Constant constRpmPump1(final k=rpmPumpPrim)
                                                                      annotation (Placement(transformation(extent={{-100,
                -80},{-80,-60}})));

      parameter Modelica.SIunits.Temperature TflowSet = 298.15 "Flow temperature set point of consumer";
      parameter Real k(min=0, unit="1") = 0.025 "Gain of controller" annotation(Dialog(group="PID"));
      parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=60
        "Time constant of Integrator block" annotation(Dialog(group="PID"));
      parameter Real rpmPumpPrim( min=0, unit="1") = 1500 "Rpm of the pump on the high temperature side";
      parameter Real rpmPumpSec( min=0, unit="1") = 1000 "Rpm of the Pump on the low temperature side";
      parameter Modelica.Blocks.Types.InitPID initType=.Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
        annotation(Dialog(group="PID"));
      parameter Real xi_start=0
        "Initial or guess value value for integrator output (= integrator state)"
        annotation(Dialog(group="PID"));
      parameter Real xd_start=0
        "Initial or guess value for state of derivative block"
        annotation(Dialog(group="PID"));
      parameter Real y_start=0 "Initial value of output"
        annotation(Dialog(group="PID"));
      AixLib.Controls.Continuous.LimPID PID(
        final yMax=1,
        final yMin=0,
        final controllerType=Modelica.Blocks.Types.SimpleController.PI,
        final k=k,
        final Ti=Ti,
        final initType=initType,
        final xi_start=xi_start,
        final xd_start=xd_start,
        final y_start=y_start,
        final reverseAction=false)
                annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      Modelica.Blocks.Sources.Constant constRpmPump(final k=rpmPumpSec)
                                                                      annotation (Placement(transformation(extent={{-100,
                -42},{-80,-22}})));
      AixLib.Systems.EONERC_MainBuilding.BaseClasses.TwoCircuitBus hxBus annotation (Placement(transformation(extent={{84,-16},
                {116,16}}),         iconTransformation(extent={{92,-20},{130,22}})));
      Modelica.Blocks.Sources.Constant const( k=TflowSet)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(
            transformation(
            extent={{-13,-13},{13,13}},
            rotation=180,
            origin={107,51})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      Modelica.Blocks.Math.BooleanToReal booleanToReal
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    equation
      connect(PID.u_m, hxBus.secBus.TFwrdOutMea) annotation (
        Line(points={{-50,78},{-50,0},{100,0},{100,10},{100.08,10},{100.08,0.08}},
                                                                               color = {0, 0, 127}),
        Text(string = "%second", index = 1, extent = {{-3, -6}, {-3, -6}}, horizontalAlignment = TextAlignment.Right));
      connect(constRpmPump.y, hxBus.secBus.pumpBus.rpmSet) annotation (
        Line(points={{-79,-32},{0,-32},{0,0.08},{100.08,0.08}},       color = {0, 0, 127}),
        Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}, horizontalAlignment = TextAlignment.Left));
      connect(constRpmPump1.y, hxBus.primBus.pumpBus.rpmSet) annotation (
        Line(points={{-79,-70},{0,-70},{0,0},{100.08,0},{100.08,0.08}},
                                                                color = {0, 0, 127}),
        Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}, horizontalAlignment = TextAlignment.Left));
      connect(const.y, PID.u_s)
        annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
      connect(PID.y, switch1.u1) annotation (Line(points={{-39,90},{-32,90},{
              -32,78},{-22,78}}, color={0,0,127}));
      connect(const1.y, switch1.u3) annotation (Line(points={{-79,50},{-50,50},
              {-50,62},{-22,62}}, color={0,0,127}));
      connect(On, switch1.u2) annotation (Line(points={{107,51},{28,51},{28,50},
              {-50,50},{-50,70},{-22,70}}, color={255,0,255}));
      connect(On, booleanToReal.u) annotation (Line(points={{107,51},{68,51},{
              68,52},{28,52},{28,50},{-50,50},{-50,30},{-22,30}}, color={255,0,
              255}));
      connect(booleanToReal.y, hxBus.primBus.valveSet) annotation (Line(points=
              {{1,30},{20,30},{20,0.08},{100.08,0.08}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(switch1.y, hxBus.secBus.valveSet) annotation (Line(points={{1,70},
              {20,70},{20,0.08},{100.08,0.08}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(On, hxBus.primBus.pumpBus.onSet) annotation (Line(points={{107,51},
              {68,51},{68,50},{20,50},{20,0.08},{100.08,0.08}}, color={255,0,
              255}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(On, hxBus.secBus.pumpBus.onSet) annotation (Line(points={{107,51},
              {64,51},{64,50},{20,50},{20,0},{60,0},{60,0.08},{100.08,0.08}},
            color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (
        Icon(graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                           FillPattern.Solid,
                lineThickness =                                                                                                            0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 1}, lineColor = {95, 95, 95},
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-99, 55}, {99, -51}}, textString = "Controller
Heat
Exchanger")}, coordinateSystem(initialScale = 0.1)));
    end Controller_HX;

    model Controller_CentralAHU

    parameter Real rpm_pump_preheating=2000 "rpm of preheating pump" annotation (dialog(group="Preheating"));
    parameter Real k_preheating=0.025 "Gain of controller" annotation (dialog(group="Preheating"));
    parameter Real Ti_preheating=130 "Time constant of Integrator block" annotation (dialog(group="Preheating"));
    parameter Real Td_preheating=0 "Time constant of Derivative block" annotation (dialog(group="Preheating"));
    parameter Real yMax_preheating=1 "Upper limit of output" annotation (dialog(group="Preheating"));
    parameter Real yMin_preheating=0 "Lower limit of output" annotation (dialog(group="Preheating"));
    parameter Real wp_preheating=1 "set-point weight for proportional block" annotation (dialog(group="Preheating"));
    parameter Real wd_preheating=0 "set-point weight for derivative block" annotation (dialog(group="Preheating"));
    parameter Real Ni_preheating=0.9 "Ni*Ti is time constant of anti-windup compensation" annotation (dialog(group="Preheating"));
    parameter Real Nd_preheating=10 "the higher Nd, the more ideal the derivative block" annotation (dialog(group="Preheating"));
    parameter Real xi_start_preheating=0 "initial value for state of integrator block" annotation (dialog(group="Preheating"));
    parameter Real xd_start_preheating=0 "initial value for state of derivative block"
                                                                                      annotation (dialog(group="Preheating"));
    parameter Real y_start_preheating=0 "Initial value of output" annotation (dialog(group="Preheating"));
    parameter Boolean reverseAction_preheating=false "allow reverse action" annotation(dialog(group="Preheating"));



    parameter Real rpm_pump_heating=2000 "rpm of heating pump" annotation (dialog(group="Heating"));
    parameter Real k_heating=0.025 "Gain of controller" annotation (dialog(group="Heating"));
    parameter Real Ti_heating=130 "Time constant of Integrator block" annotation (dialog(group="Heating"));
    parameter Real Td_heating=0 "Time constant of Derivative block" annotation (dialog(group="Heating"));
    parameter Real yMax_heating=1 "Upper limit of output" annotation (dialog(group="Heating"));
    parameter Real yMin_heating=0 "Lower limit of output"
                                                         annotation (dialog(group="Heating"));
    parameter Real wp_heating=1 "set-point weight for proportional block" annotation (dialog(group="Heating"));
    parameter Real wd_heating=0 "set-point weight for derivative block" annotation (dialog(group="Heating"));
    parameter Real Ni_heating=0.9  "Ni*Ti is time constant of anti-windup compensation" annotation (dialog(group="Heating"));
    parameter Real Nd_heating=10 "the higher Nd, the more ideal the derivative block"  annotation (dialog(group="Heating"));
    parameter Real xi_start_heating=0 "initial value for state of integrator block" annotation (dialog(group="Heating"));
    parameter Real xd_start_heating=0   "initial value for state of derivative block" annotation (dialog(group="Heating"));
    parameter Real y_start_heating=0 "Initial value of output" annotation (dialog(group="Heating"));
    parameter Boolean reverseAction_heating=false "allow reverse action" annotation(dialog(group="Heating"));


    parameter Real rpm_pump_cooling=2000 "rpm of cooling pump" annotation (dialog(group="Cooling"));
    parameter Real k_cooling=0.025 "Gain of controller" annotation (dialog(group="Cooling"));
    parameter Real Ti_cooling=130 "Time constant of Integrator block" annotation (dialog(group="Cooling"));
    parameter Real Td_cooling=0 "Time constant of Derivative block" annotation (dialog(group="Cooling"));
    parameter Real yMax_cooling=1 "Upper limit of output" annotation (dialog(group="Cooling"));
    parameter Real yMin_cooling=0 "Lower limit of output" annotation (dialog(group="Cooling"));
    parameter Real wp_cooling=1 "set-point weight for proportional block" annotation (dialog(group="Cooling"));
    parameter Real wd_cooling=0 "set-point weight for derivative block" annotation (dialog(group="Cooling"));
    parameter Real Ni_cooling=0.9  "Ni*Ti is time constant of anti-windup compensation" annotation (dialog(group="Cooling"));
    parameter Real Nd_cooling=10 "the higher Nd, the more ideal the derivative block"  annotation (dialog(group="Cooling"));
    parameter Real xi_start_cooling=0 "initial value for state of integrator block" annotation (dialog(group="Cooling"));
    parameter Real xd_start_cooling=0  "initial value for state of derivative block" annotation (dialog(group="Cooling"));
    parameter Real y_start_cooling=0 "Initial value of output" annotation (dialog(group="Cooling"));
    parameter Boolean reverseAction_cooling=false "allow reverse action" annotation(dialog(group="Cooling"));




      parameter Modelica.SIunits.Temperature TFlowSet=289.15
        "Flow temperature set point of consumer"
        annotation (Dialog(enable=useExternalTset == false));
      parameter Boolean useExternalTset=false
        "If True, set temperature can be given externally";
      parameter Modelica.SIunits.VolumeFlowRate VFlowSet=9000/3600
        "Set value of volume flow [m^3/s]"
        annotation (dialog(group="Fan Controller"));
      parameter Real dpMax=5000 "Maximal pressure difference of the fans [Pa]"
        annotation (dialog(group="Fan Controller"));
      parameter Boolean useTwoFanCont=false
        "If True, a PID for each of the two fans is used. Use two PID controllers for open systems (if the air canal is not closed)."
        annotation (dialog(group="Fan Controller"));
      parameter Real k=50 "Gain of controller"
        annotation (dialog(group="Fan Controller"));
      parameter Modelica.SIunits.Time Ti=5 "Time constant of Integrator block"
        annotation (dialog(group="Fan Controller"));
      parameter Real y_start=0 "Initial value of output"
        annotation (dialog(group="Fan Controller"));



      AixLib.Systems.ModularAHU.BaseClasses.GenericAHUBus genericAHUBus annotation (Placement(transformation(
              extent={{90,-10},{110,10}}), iconTransformation(extent={{84,-14},{116,
                16}})));
      Modelica.Blocks.Sources.Constant TFrostProtection(final k=273.15 + 5) if
                                                                          not useExternalTset
        annotation (Placement(transformation(extent={{-92,70},{-72,90}})));
      Controls.Continuous.LimPID PID_VflowSup(
        final yMax=dpMax,
        final yMin=0,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k,
        final Ti=Ti,
        final Td=0,
        initType=Modelica.Blocks.Types.InitPID.InitialOutput,
        y_start=y_start,
        final reverseAction=false,
        final reset=AixLib.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-50,-130},{-30,-110}})));
      Controls.Continuous.LimPID PID_VflowRet(
        final yMax=dpMax,
        final yMin=0,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k,
        final Ti=Ti,
        final Td=0,
        initType=Modelica.Blocks.Types.InitPID.InitialOutput,
        y_start=y_start,
        final reverseAction=false,
        final reset=AixLib.Types.Reset.Disabled) if useTwoFanCont
        annotation (Placement(transformation(extent={{-50,-170},{-30,-150}})));
      Modelica.Blocks.Sources.Constant ConstVflow(final k=VFlowSet)
        annotation (Placement(transformation(extent={{-92,-170},{-72,-150}})));

      Modelica.Blocks.Sources.Constant ConstWRG(final k=0)
        annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
      Modelica.Blocks.Sources.Constant ConstFlap(final k=1)
        annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
      Modelica.Blocks.Sources.Constant ConstFlap1(final k=0) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={50,-132})));

      Modelica.Blocks.Interfaces.BooleanInput CentralAHU_Heating annotation (
          Placement(
          visible=true,
          transformation(
            origin={104,80},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={104,80},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput CentralAHU_Heating_Preheating
        annotation (Placement(
          visible=true,
          transformation(
            origin={106,40},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={98,40},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput CentralAHU_Cooling annotation (
          Placement(
          visible=true,
          transformation(
            origin={106,-40},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={100,-40},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput CentralAHU_Combi annotation (
          Placement(
          visible=true,
          transformation(
            origin={104,-100},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={100,-80},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Controls.Continuous.LimPID PID_Preheating(
        final yMax=yMax_preheating,
        final yMin=yMin_preheating,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k_preheating,
        final Ti=Ti_preheating,
        final Td=Td_preheating,
        wp=wp_preheating,
        wd=wd_preheating,
        Ni=Ni_preheating,
        Nd=Nd_preheating,
        final initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,
        final xi_start=xi_start_preheating,
        final xd_start=xd_start_preheating,
        final y_start=y_start_preheating,
        final reverseAction=reverseAction_preheating,
        final reset=AixLib.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
      Modelica.Blocks.Sources.Constant constRpmPump_Preheating(final k=
            rpm_pump_preheating)
        annotation (Placement(transformation(extent={{-20,70},{0,90}})));
      Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={58,80})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Blocks.Sources.Constant Const(final k=0)
        annotation (Placement(transformation(extent={{-92,20},{-72,40}})));
      Modelica.Blocks.Logical.Or or2 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={50,30})));
      Modelica.Blocks.Logical.Or or3 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={50,-160})));
      Modelica.Blocks.Sources.Constant constTflowSet1(final k=TFlowSet) if
                                                                          not useExternalTset
        annotation (Placement(transformation(extent={{-94,-20},{-74,0}})));
      Controls.Continuous.LimPID PID_Heating(
        final yMax=yMax_heating,
        final yMin=yMin_heating,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k_heating,
        final Ti=Ti_heating,
        final Td=Td_heating,
        wp=wp_heating,
        wd=wd_heating,
        Ni=Ni_heating,
        Nd=Nd_heating,
        final initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,
        final xi_start=xi_start_heating,
        final xd_start=xd_start_heating,
        final y_start=y_start_heating,
        final reverseAction=reverseAction_heating,
        final reset=AixLib.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      Modelica.Blocks.Sources.Constant constRpmPump_Preheating1(final k=
            rpm_pump_heating)
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      Modelica.Blocks.Sources.Constant constRpmPump_Preheating2(final k=
            rpm_pump_cooling)
        annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
      Controls.Continuous.LimPID PID_Cooling(
        final yMax=yMax_cooling,
        final yMin=yMin_cooling,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k_cooling,
        final Ti=Ti_cooling,
        final Td=Td_cooling,
        wp=wp_cooling,
        wd=wd_cooling,
        Ni=Ni_cooling,
        Nd=Nd_cooling,
        final initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,
        final xi_start=xi_start_cooling,
        final xd_start=xd_start_cooling,
        final y_start=y_start_cooling,
        final reverseAction=reverseAction_cooling,
        final reset=AixLib.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    equation
      connect(ConstVflow.y, PID_VflowSup.u_s) annotation (Line(points={{-71,-160},{-60,
              -160},{-60,-120},{-52,-120}},
                                        color={0,0,127}));
      connect(PID_VflowSup.u_m, genericAHUBus.heaterBus.VFlowAirMea) annotation (
          Line(points={{-40,-132},{-40,-140},{-60,-140},{-60,-180},{100,-180},{100,-70},
              {100.05,-70},{100.05,0.05}},                            color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(ConstWRG.y, genericAHUBus.bypassHrsSet) annotation (Line(points={{61,-100},
              {72,-100},{72,0},{100.05,0},{100.05,0.05}},
                                                color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(ConstFlap.y, genericAHUBus.flapRetSet) annotation (Line(points={{61,-70},
              {72,-70},{72,0},{100.05,0},{100.05,0.05}},
                                                color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(ConstFlap.y, genericAHUBus.flapSupSet) annotation (Line(points={{61,-70},
              {72,-70},{72,0},{100.05,0},{100.05,0.05}},
                                                color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(ConstFlap1.y, genericAHUBus.steamHumSet) annotation (Line(points={{61,-132},
              {72,-132},{72,0},{100.05,0},{100.05,0.05}},         color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(ConstFlap1.y, genericAHUBus.adiabHumSet) annotation (Line(points={{61,-132},
              {72,-132},{72,0},{100.05,0},{100.05,0.05}},       color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(ConstVflow.y, PID_VflowRet.u_s) annotation (Line(points={{-71,-160},{-52,
              -160}},                    color={0,0,127}));
      connect(PID_VflowSup.y, genericAHUBus.dpFanSupSet) annotation (Line(points={{-29,
              -120},{20,-120},{20,0},{100.05,0},{100.05,0.05}},        color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(PID_VflowRet.u_m, genericAHUBus.V_flow_RetAirMea) annotation (Line(
            points={{-40,-172},{-40,-180},{100,-180},{100,-50},{100.05,-50},{100.05,
              0.05}},                                                   color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(PID_VflowRet.y, genericAHUBus.dpFanRetSet) annotation (Line(points={{-29,
              -160},{20,-160},{20,0},{100.05,0},{100.05,0.05}},
                                                  color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      if not useTwoFanCont then
        connect(PID_VflowSup.y, genericAHUBus.dpFanRetSet) annotation (Line(points={{-29,
                -120},{20,-120},{20,0},{100.05,0},{100.05,0.05}},
                                                       color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
      end if;

      connect(TFrostProtection.y, PID_Preheating.u_s)
        annotation (Line(points={{-71,80},{-62,80}}, color={0,0,127}));
      connect(PID_Preheating.y, switch1.u1) annotation (Line(points={{-39,80},{-32,80},
              {-32,58},{-22,58}}, color={0,0,127}));
      connect(Const.y, switch1.u3) annotation (Line(points={{-71,30},{-32,30},{-32,40},
              {-22,40},{-22,42}}, color={0,0,127}));
      connect(CentralAHU_Heating_Preheating, switch1.u2) annotation (Line(points={{106,
              40},{80,40},{80,100},{-100,100},{-100,50},{-22,50}}, color={255,0,255}));
      connect(CentralAHU_Heating_Preheating, genericAHUBus.preheaterBus.hydraulicBus.pumpBus.onSet)
        annotation (Line(points={{106,40},{80,40},{80,0.05},{100.05,0.05}}, color={255,
              0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(CentralAHU_Heating_Preheating, or1.u1) annotation (Line(points={{106,40},
              {80,40},{80,80},{70,80}}, color={255,0,255}));
      connect(CentralAHU_Heating, or1.u2) annotation (Line(points={{104,80},{80,80},
              {80,88},{70,88}}, color={255,0,255}));
      connect(CentralAHU_Combi, or3.u1) annotation (Line(points={{104,-100},{80,-100},
              {80,-160},{62,-160}}, color={255,0,255}));
      connect(CentralAHU_Cooling, or3.u2) annotation (Line(points={{106,-40},{
              80,-40},{80,-152},{62,-152}},
                                    color={255,0,255}));
      connect(constRpmPump_Preheating.y, genericAHUBus.preheaterBus.hydraulicBus.pumpBus.rpmSet)
        annotation (Line(points={{1,80},{20,80},{20,0},{100.05,0},{100.05,0.05}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(CentralAHU_Combi, or2.u1) annotation (Line(points={{104,-100},{80,-100},
              {80,30},{62,30}}, color={255,0,255}));
      connect(or1.y, or2.u2) annotation (Line(points={{47,80},{40,80},{40,60},{80,60},
              {80,38},{62,38}}, color={255,0,255}));
      connect(genericAHUBus.preheaterBus.TAirOutMea, PID_Preheating.u_m)
        annotation (Line(
          points={{100.05,0.05},{100.05,100},{-100,100},{-100,60},{-50,60},{-50,68}},
          color={255,204,51},
          thickness=0.5));

      connect(switch1.y, genericAHUBus.preheaterBus.hydraulicBus.valveSet)
        annotation (Line(points={{1,50},{20,50},{20,0},{100.05,0},{100.05,0.05}},
            color={0,0,127}));
      connect(PID_Heating.y, switch2.u1) annotation (Line(points={{-39,-10},{-32,-10},
              {-32,18},{-22,18}}, color={0,0,127}));
      connect(Const.y, switch2.u3) annotation (Line(points={{-71,30},{-32,30},{-32,0},
              {-22,0},{-22,2}}, color={0,0,127}));
      connect(or2.y, switch2.u2) annotation (Line(points={{39,30},{20,30},{20,100},{
              -100,100},{-100,10},{-22,10}}, color={255,0,255}));
      connect(constTflowSet1.y, PID_Heating.u_s)
        annotation (Line(points={{-73,-10},{-62,-10}}, color={0,0,127}));
      connect(genericAHUBus.heaterBus.TAirOutMea, PID_Heating.u_m) annotation (Line(
          points={{100.05,0.05},{102,0.05},{102,2},{100,2},{100,100},{-100,100},{-100,
              -32},{-50,-32},{-50,-22}},
          color={255,204,51},
          thickness=0.5));
      connect(switch2.y, genericAHUBus.heaterBus.hydraulicBus.valveSet) annotation (
         Line(points={{1,10},{20,10},{20,0.05},{100.05,0.05}}, color={0,0,127}));
      connect(or2.y, genericAHUBus.heaterBus.hydraulicBus.pumpBus.onSet)
        annotation (Line(points={{39,30},{20,30},{20,0},{100.05,0},{100.05,0.05}},
            color={255,0,255}));
      connect(or3.y, switch3.u2) annotation (Line(points={{39,-160},{28,-160},{28,-180},
              {-100,-180},{-100,-72},{-32,-72},{-32,-50},{-22,-50}}, color={255,0,255}));
      connect(Const.y, switch3.u3) annotation (Line(points={{-71,30},{-32,30},{-32,-58},
              {-22,-58}}, color={0,0,127}));
      connect(PID_Cooling.y, switch3.u1) annotation (Line(points={{-39,-50},{-32,-50},
              {-32,-42},{-22,-42}}, color={0,0,127}));
      connect(constTflowSet1.y, PID_Cooling.u_s) annotation (Line(points={{-73,-10},
              {-68,-10},{-68,-50},{-62,-50}}, color={0,0,127}));
      connect(constRpmPump_Preheating1.y, genericAHUBus.heaterBus.hydraulicBus.pumpBus.rpmSet)
        annotation (Line(points={{1,-20},{20,-20},{20,0},{62,0},{62,0.05},{100.05,0.05}},
            color={0,0,127}));
      connect(switch3.y, genericAHUBus.coolerBus.hydraulicBus.valveSet) annotation (
         Line(points={{1,-50},{20,-50},{20,0.05},{100.05,0.05}}, color={0,0,127}));
      connect(constRpmPump_Preheating2.y, genericAHUBus.coolerBus.hydraulicBus.pumpBus.rpmSet)
        annotation (Line(points={{1,-80},{20,-80},{20,0},{100.05,0},{100.05,0.05}},
            color={0,0,127}));
      connect(genericAHUBus.TSupAirMea, PID_Cooling.u_m) annotation (Line(
          points={{100.05,0.05},{100.05,0},{100,0},{100,-180},{-100,-180},{-100,-72},
              {-50,-72},{-50,-62}},
          color={255,204,51},
          thickness=0.5));
      connect(CentralAHU_Cooling, genericAHUBus.coolerBus.hydraulicBus.pumpBus.onSet)
        annotation (Line(points={{106,-40},{80,-40},{80,0},{100.05,0},{100.05,
              0.05}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},
                {100,100}}),                                        graphics={
            Text(
              extent={{-90,20},{56,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="HCMI"),
            Rectangle(
              extent={{-100,100},{100,-180}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-92,0},{102,-74}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Central
AHU")}),                               Diagram(coordinateSystem(preserveAspectRatio=
               false, extent={{-100,-180},{100,100}})),
                  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Controller_CentralAHU;
  end Controller;

  model testing_management_automation
    constant Real const1 = 295.15;
    constant Real const2 = 291.15;
    Level.ManagementLevel_Temp_V2 managementLevel_Temp_V2_1
      annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
    Level.AutomationLevel_V1 automationLevel_V1_1
      annotation (Placement(transformation(extent={{-40,-20},{0,0}})));
    Modelica.Blocks.Sources.Constant const(k=283.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,90})));
    Modelica.Blocks.Sources.Constant const3(k=288.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,50})));
    Modelica.Blocks.Sources.Constant const4(k=293.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,10})));
    Modelica.Blocks.Sources.Pulse pulse(
      amplitude=5,
      width=50,
      period=14400,
      offset=293.15,
      startTime=3600) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,-30})));
    Modelica.Blocks.Sources.Pulse pulse1(
      amplitude=-5,
      width=50,
      period=14400,
      offset=293.15,
      startTime=7200) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,-70})));
    Modelica.Blocks.Sources.Constant const5(k=278.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-76,26})));
  equation

    connect(managementLevel_Temp_V2_1.Superior_Mode[1], automationLevel_V1_1.Superior_Mode[
      1]) annotation (Line(points={{-20,40.35},{-20,1.75}},
                        color={255,0,255}));
    connect(managementLevel_Temp_V2_1.Superior_Mode[2], automationLevel_V1_1.Superior_Mode[
      2]) annotation (Line(points={{-20,39.85},{-20,1.25}},
                        color={255,0,255}));
    connect(managementLevel_Temp_V2_1.Superior_Mode[3], automationLevel_V1_1.Superior_Mode[
      3]) annotation (Line(points={{-20,39.35},{-20,0.75}},
                        color={255,0,255}));
    connect(managementLevel_Temp_V2_1.Superior_Mode[4], automationLevel_V1_1.Superior_Mode[
      4]) annotation (Line(points={{-20,38.85},{-20,0.25}},
                        color={255,0,255}));
    connect(automationLevel_V1_1.T_CS, const.y) annotation (Line(points={{-15.9,
            1.1},{-15.9,20},{0,20},{0,90},{79,90}},
                                              color={0,0,127}));
    connect(automationLevel_V1_1.T_GEO, const.y)
      annotation (Line(points={{-12,1},{-12,20},{0,20},{0,90},{79,90}},
                                                          color={0,0,127}));
    connect(const3.y, managementLevel_Temp_V2_1.RoomTempMea[1]) annotation (
        Line(points={{79,50},{0,50},{0,80},{-20,80},{-20,61.88}}, color={0,0,
            127}));
    connect(const3.y, automationLevel_V1_1.TRoomMea[1]) annotation (Line(points=
           {{79,50},{0,50},{0,20},{-8,20},{-8,1.8}}, color={0,0,127}));
    connect(const4.y, managementLevel_Temp_V2_1.RoomTempMea[4]) annotation (
        Line(points={{79,10},{0,10},{0,80},{-20,80},{-20,59.96}}, color={0,0,
            127}));
    connect(const4.y, managementLevel_Temp_V2_1.RoomTempMea[5]) annotation (
        Line(points={{79,10},{0,10},{0,80},{-20,80},{-20,59.32}}, color={0,0,
            127}));
    connect(const4.y, automationLevel_V1_1.TRoomMea[4]) annotation (Line(points=
           {{79,10},{0,10},{0,20},{-8,20},{-8,0.6}}, color={0,0,127}));
    connect(const4.y, automationLevel_V1_1.TRoomMea[5]) annotation (Line(points=
           {{79,10},{0,10},{0,20},{-8,20},{-8,0.2}}, color={0,0,127}));
    connect(pulse.y, managementLevel_Temp_V2_1.RoomTempMea[2]) annotation (Line(
          points={{79,-30},{0,-30},{0,80},{-20,80},{-20,61.24}}, color={0,0,127}));
    connect(pulse.y, automationLevel_V1_1.TRoomMea[2]) annotation (Line(points=
            {{79,-30},{0,-30},{0,20},{-8,20},{-8,1.4}}, color={0,0,127}));
    connect(pulse1.y, managementLevel_Temp_V2_1.RoomTempMea[3]) annotation (
        Line(points={{79,-70},{0,-70},{0,60.6},{-20,60.6}}, color={0,0,127}));
    connect(pulse1.y, automationLevel_V1_1.TRoomMea[3]) annotation (Line(points=
           {{79,-70},{0,-70},{0,20},{-8,20},{-8,1}}, color={0,0,127}));
    connect(const5.y, automationLevel_V1_1.TAirOutside) annotation (Line(points=
           {{-65,26},{-46,26},{-46,10},{-4,10},{-4,1}}, color={0,0,127}));
    annotation (experiment(StopTime=86400, Interval=60));
  end testing_management_automation;
end Mode_based_ControlStrategy;
