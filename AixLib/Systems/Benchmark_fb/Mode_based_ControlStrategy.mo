within AixLib.Systems.Benchmark_fb;
package Mode_based_ControlStrategy

  model Mode_based_Controller
    Bus_Systems.ModeBasedControllerBus modeBasedControllerBus
      annotation (Placement(transformation(extent={{56,-12},{84,12}})));

    AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus annotation (
        Placement(
        visible=true,
        transformation(extent={{92,-10},{112,10}}, rotation=0),
        iconTransformation(extent={{92,-10},{112,10}}, rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.FieldLevel
      fieldLevel1 annotation (Placement(visible=true, transformation(
          origin={-40,-70},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    ManagementLevel managementLevel_Temp_V2_1
      annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
    AutomationLevel automationLevel_V2_1
      annotation (Placement(transformation(extent={{-66,-20},{-20,8}})));
  equation
    connect(mainBus.TRoom1Mea, managementLevel_Temp_V2_1.RoomTempMea[1])
      annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-40.9091,100},{-40.9091,61.88}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.TRoom2Mea, managementLevel_Temp_V2_1.RoomTempMea[2])
      annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-40.9091,100},{-40.9091,61.24}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.TRoom3Mea, managementLevel_Temp_V2_1.RoomTempMea[3])
      annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-40.9091,100},{-40.9091,60.6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.TRoom5Mea, managementLevel_Temp_V2_1.RoomTempMea[5])
      annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-40.9091,100},{-40.9091,59.32}},
        color={255,204,51},
        thickness=0.5));

    connect(mainBus.TRoom4Mea, managementLevel_Temp_V2_1.RoomTempMea[4])
      annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-40.9091,100},{-40.9091,59.96}},
        color={255,204,51},
        thickness=0.5));

    connect(modeBasedControllerBus, mainBus.ModeBasedControlStrategy) annotation (
       Line(
        points={{70,0},{102,0}},
        color={255,204,51},
        thickness=0.5));
    connect(managementLevel_Temp_V2_1.managementLevelBus, modeBasedControllerBus.ManagementLevelBus)
      annotation (Line(
        points={{-40.9091,40},{-40,40},{-40,28},{20,28},{20,0},{70,0}},
        color={255,204,51},
        thickness=0.5));
    connect(fieldLevel1.mainBus, mainBus) annotation (Line(
        points={{-40,-80},{-40,-100},{-100,-100},{-100,100},{100,100},{100,2},{
            102,2},{102,0}},
        color={255,204,51},
        thickness=0.5));
    connect(managementLevel_Temp_V2_1.managementLevelBus, automationLevel_V2_1.managementLevelBus)
      annotation (Line(
        points={{-40.9091,40},{-40,40},{-40,8}},
        color={255,204,51},
        thickness=0.5));
    connect(automationLevel_V2_1.automationLevelBus, modeBasedControllerBus.AutomationLevelBus)
      annotation (Line(
        points={{-39.8,-20.1},{-39.8,-40},{20,-40},{20,0},{70,0}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.TRoom1Mea, automationLevel_V2_1.TRoomMea[1]) annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-100,100},{-100,20},{-30,20},
            {-30,14},{-30,14},{-30,9.4}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.TRoom2Mea, automationLevel_V2_1.TRoomMea[2]) annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-100,100},{-100,20},{-30,20},
            {-30,14},{-30,14},{-30,9}},
        color={255,204,51},
        thickness=0.5));
         connect(mainBus.TRoom3Mea, automationLevel_V2_1.TRoomMea[3]) annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-100,100},{-100,20},{-30,20},
            {-30,14},{-30,14},{-30,8.6}},
        color={255,204,51},
        thickness=0.5));
         connect(mainBus.TRoom4Mea, automationLevel_V2_1.TRoomMea[4]) annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-100,100},{-100,20},{-30,20},
            {-30,8.2}},
        color={255,204,51},
        thickness=0.5));
         connect(mainBus.TRoom5Mea, automationLevel_V2_1.TRoomMea[5]) annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-100,100},{-100,20},{-30,20},
            {-30,7.8}},
        color={255,204,51},
        thickness=0.5));

    connect(automationLevel_V2_1.automationLevelBus, fieldLevel1.automationLevelBus)
      annotation (Line(
        points={{-39.8,-20.1},{-39.8,-30},{-40,-30},{-40,-60}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.htsBus.thermalPowerChpMea, automationLevel_V2_1.CHP_ThermalPower)
      annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-100,100},{-100,20},{-56,20},
            {-56,8.6}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.gtfBus.primBus.TFwrdOutMea, automationLevel_V2_1.T_Geo)
      annotation (Line(
        points={{102.05,0.05},{100,0.05},{100,100},{-100,100},{-100,20},{-50,20},
            {-50,8.6}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.hpSystemBus.busThrottleRecool.TRtrnInMea,
      automationLevel_V2_1.T_Recool) annotation (Line(
        points={{102.05,0.05},{102.05,0},{100,0},{100,100},{-100,100},{-100,20},
            {-62.1,20},{-62.1,8.7}},
        color={255,204,51},
        thickness=0.5));
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

  model ManagementLevel

   import PNlib.Components.*;
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
      delay=300,
      arcWeightIn={1},
      arcWeightOut={1},                           firingCon= not (RoomTempMea[1] < 287.15 or RoomTempMea[2] < 294.15 or RoomTempMea[
          3] < 294.15 or RoomTempMea[4] < 294.15 or RoomTempMea[5] < 294.15) and (RoomTempMea[1] > 289.15 or RoomTempMea[2] > 296.15 or RoomTempMea[
          3] > 296.15 or RoomTempMea[4] > 296.15 or RoomTempMea[5] > 296.15)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-44,72})));

    PNlib.Components.TD Cooling_Off(nIn=1, nOut=1,
      delay=300,
      arcWeightIn={1},
      arcWeightOut={1},                           firingCon= not (RoomTempMea[1] > 289.15 or RoomTempMea[2] > 296.15 or RoomTempMea[
          3] > 296.15 or RoomTempMea[4] > 296.15 or RoomTempMea[5] > 296.15))
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
      delay=300,
      arcWeightIn={1},
      arcWeightOut={1},
      firingCon=(RoomTempMea[1] < 287.15 or RoomTempMea[2] < 294.15 or RoomTempMea[
          3] < 294.15 or RoomTempMea[4] < 294.15 or RoomTempMea[5] < 294.15) and not
                                                                                    (RoomTempMea[1] > 289.15 or RoomTempMea[2] > 296.15 or RoomTempMea[
          3] > 296.15 or RoomTempMea[4] > 296.15 or RoomTempMea[5] > 296.15))
      annotation (Placement(transformation(extent={{34,62},{54,82}})));
    PNlib.Components.TD Heating_Off(nIn=1, nOut=1,
      delay=300,
      arcWeightIn={1},
      arcWeightOut={1},                           firingCon= not (RoomTempMea[1] < 287.15 or RoomTempMea[2] < 294.15 or RoomTempMea[
          3] < 294.15 or RoomTempMea[4] < 294.15 or RoomTempMea[5] < 294.15)) annotation (Placement(
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
      delay=300,
      arcWeightIn={1},
      arcWeightOut={1},                                   firingCon= not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
          3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
          3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-90,-4})));

    PNlib.Components.TD Cooling_Combination(nIn=1, nOut=1,
      delay=300,
      arcWeightIn={1},
      arcWeightOut={1},
      firingCon=not (RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or
          RoomTempMea[3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5]
           < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15
           or RoomTempMea[3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[
          5] > 295.15))                                                       annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,-4})));

    PNlib.Components.TD Combination_Off(nIn=1, nOut=1,
      delay=300,
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
      delay=300,
      arcWeightIn={1},
      arcWeightOut={1},                              firingCon=(RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
          3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
          3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-4})));

    PNlib.Components.TD Heating_Combination(nIn=1, nOut=1,
      delay=300,
      arcWeightIn={1},
      arcWeightOut={1},                                   firingCon=(RoomTempMea[1] < 286.15 or RoomTempMea[2] < 291.15 or RoomTempMea[
          3] < 291.15 or RoomTempMea[4] < 291.15 or RoomTempMea[5] < 291.15) and (RoomTempMea[1] > 290.15 or RoomTempMea[2] > 295.15 or RoomTempMea[
          3] > 295.15 or RoomTempMea[4] > 295.15 or RoomTempMea[5] > 295.15)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={60,-4})));

    PNlib.Components.TD Combination_Heating(nIn=1, nOut=1,
      delay=300,
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
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Bus_Systems.ManagementLevelBus
      managementLevelBus
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Blocks.Math.IntegerToBoolean integerToBoolean[4](threshold=1)
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={8.88178e-16,-78})));
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
    connect(Heating.pd_t, integerToBoolean[2].u) annotation (Line(points={{
            80.6,54},{100,54},{100,-60},{0,-60},{0,-68.4}}, color={255,127,0}));
    connect(Off.pd_t, integerToBoolean[1].u) annotation (Line(points={{-10.6,
            52},{-20,52},{-20,14},{100,14},{100,-60},{0,-60},{0,-68.4}},
          color={255,127,0}));
    connect(Cooling.pd_t, integerToBoolean[3].u) annotation (Line(points={{
            -59.4,52},{-60,52},{-60,14},{100,14},{100,-60},{0,-60},{0,-68.4}},
          color={255,127,0}));
    connect(Combination.pd_t, integerToBoolean[4].u) annotation (Line(points=
            {{10.6,-38},{14,-38},{14,-40},{24,-40},{24,-60},{0,-60},{0,-68.4}},
          color={255,127,0}));
    connect(integerToBoolean[1].y, managementLevelBus.Off)
      annotation (Line(points={{0,-86.8},{0,-100}}, color={255,0,255}));
    connect(integerToBoolean[2].y, managementLevelBus.Heating)
      annotation (Line(points={{0,-86.8},{0,-100}}, color={255,0,255}));
    connect(integerToBoolean[3].y, managementLevelBus.Cooling)
      annotation (Line(points={{0,-86.8},{0,-100}}, color={255,0,255}));
    connect(integerToBoolean[4].y, managementLevelBus.Combination)
      annotation (Line(points={{0,-86.8},{0,-100}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{120,100}}),                             graphics={
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
")}),        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}})),
      experiment(
        StartTime=604800,
        StopTime=1814400,
        Interval=300));
  end ManagementLevel;

  model AutomationLevel
    import PNlib.*;
    Modelica.Blocks.Interfaces.RealInput T_Geo
      annotation (Placement(
        visible=true,
        transformation(
          origin={-100,106},
          extent={{-10,-10},{10,10}},
          rotation=-90),
        iconTransformation(
          origin={-100,106},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    inner PNlib.Components.Settings settings annotation (
      Placement(visible = true, transformation(extent={{180,78},{200,98}},       rotation = 0)));
    Modelica.Blocks.Math.IntegerToBoolean integerToBoolean1[22] annotation (
      Placement(visible = true, transformation(origin={0,-150},              extent = {{-8, -8}, {8, 8}}, rotation = -90)));
    PNlib.Components.PD P1(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
      Placement(visible = true, transformation(origin={20,54},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
    PNlib.Components.PD P11(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
      Placement(visible = true, transformation(origin={50,54},    extent = {{-8, -8}, {8, 8}}, rotation = 90)));
    PNlib.Components.PD P12(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
      Placement(visible = true, transformation(origin={80,54},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
    PNlib.Components.TD T118(
      delay=300,
      firingCon=TRoomMea[1] < 288.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={36,36},
          extent={{-8,-8},{8,8}},
          rotation=0)));
    PNlib.Components.TD T119(
      delay=300,
      firingCon=TRoomMea[1] > 289.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={36,72},
          extent={{-8,-8},{8,8}},
          rotation=180)));
    PNlib.Components.TD T120(
      delay=300,
      firingCon=TRoomMea[1] > 288.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={64,36},
          extent={{-8,-8},{8,8}},
          rotation=180)));
    PNlib.Components.TD T121(
      delay=300,
      firingCon=TRoomMea[1] < 287.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={64,72},
          extent={{-8,-8},{8,8}},
          rotation=0)));
    PNlib.Components.TD T122(
      delay=300,
      firingCon=TRoomMea[4] > 295.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={168,-30},
          extent={{-8,-8},{8,8}},
          rotation=180)));
    PNlib.Components.TD T123(
      delay=300,
      firingCon=TRoomMea[4] < 295.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={140,-30},
          extent={{-8,-8},{8,8}},
          rotation=0)));
    PNlib.Components.TD T124(
      delay=300,
      firingCon=TRoomMea[4] < 294.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={168,6},
          extent={{-8,-8},{8,8}},
          rotation=0)));
    PNlib.Components.TD T125(
      delay=300,
      firingCon=TRoomMea[4] > 296.15,
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
      delay=300,
      firingCon=TRoomMea[2] > 295.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={158,36},
          extent={{-8,-8},{8,8}},
          rotation=180)));
    PNlib.Components.TD T127(
      delay=300,
      firingCon=TRoomMea[2] < 295.15,
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
      delay=300,
      firingCon=TRoomMea[2] < 294.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={158,72},
          extent={{-8,-8},{8,8}},
          rotation=0)));
    PNlib.Components.TD T129(
      delay=300,
      firingCon=TRoomMea[2] > 296.15,
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
      delay=300,
      firingCon=TRoomMea[5] < 295.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={140,-98},
          extent={{-8,-8},{8,8}},
          rotation=0)));
    PNlib.Components.TD T131(
      delay=300,
      firingCon=TRoomMea[5] > 295.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={168,-98},
          extent={{-8,-8},{8,8}},
          rotation=180)));
    PNlib.Components.TD T132(
      delay=300,
      firingCon=TRoomMea[5] > 296.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={140,-62},
          extent={{-8,-8},{8,8}},
          rotation=180)));
    PNlib.Components.TD T133(
      delay=300,                        nIn = 1, nOut = 1,
      firingCon=TRoomMea[5] < 294.15)                      annotation (
      Placement(visible = true, transformation(origin={168,-62},  extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    PNlib.Components.PD P115(maxTokens = 1, minTokens = 0, nIn = 2, nOut = 2, startTokens = 1) annotation (
      Placement(visible = true, transformation(origin={62,-10},    extent = {{-8, -8}, {8, 8}}, rotation = 90)));
    PNlib.Components.PD P116(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
      Placement(visible = true, transformation(origin={92,-10},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
    PNlib.Components.TD T138(
      delay=300,
      firingCon=TRoomMea[3] < 295.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={48,-28},
          extent={{-8,-8},{8,8}},
          rotation=0)));
    PNlib.Components.TD T139(
      delay=300,
      firingCon=TRoomMea[3] > 295.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={76,-28},
          extent={{-8,-8},{8,8}},
          rotation=180)));
    PNlib.Components.TD T140(
      delay=300,
      firingCon=TRoomMea[3] > 296.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={48,8},
          extent={{-8,-8},{8,8}},
          rotation=180)));
    PNlib.Components.TD T141(
      delay=300,
      firingCon=TRoomMea[3] < 294.15,
      nIn=1,
      nOut=1) annotation (Placement(visible=true, transformation(
          origin={76,8},
          extent={{-8,-8},{8,8}},
          rotation=0)));
    PNlib.Components.PD P117(maxTokens = 1, minTokens = 0, nIn = 1, nOut = 1, startTokens = 0) annotation (
      Placement(visible = true, transformation(origin={32,-10},    extent = {{-8, -8}, {8, 8}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput TRoomMea[5] annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={100,106})));
    Modelica.Blocks.Interfaces.RealInput T_Recool annotation (Placement(
          transformation(
          extent={{-11,-11},{11,11}},
          rotation=270,
          origin={-221,107})));
    Modelica.Blocks.Interfaces.RealInput CHP_ThermalPower annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-160,106})));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Bus_Systems.AutomationLevelBus
      automationLevelBus
      annotation (Placement(transformation(extent={{-14,-196},{18,-166}})));
    Bus_Systems.ManagementLevelBus managementLevelBus
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    Modelica.Blocks.Routing.BooleanPassThrough SuperiorMode[4] annotation (
        Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={12,84})));
    PNlib.Components.TD T1(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[3].y and T_Geo >= 285.15) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-188,36})));
    PNlib.Components.PD Cooling_I(nIn=4, nOut=4) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-212,24})));
    PNlib.Components.PD Off(
      nIn=6,
      nOut=6,
      startTokens=1)
      annotation (Placement(transformation(extent={{-144,-14},{-124,6}})));
    PNlib.Components.TD T2(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[1].y) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={-188,16})));
    PNlib.Components.TD T3(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[1].y)
      annotation (Placement(transformation(extent={{-198,-34},{-178,-14}})));
    PNlib.Components.PD Cooling_II(
      nIn=4,
      nOut=4,
      startTokens=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-212,-34})));
    PNlib.Components.TD T4(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[3].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-188,-44})));
    PNlib.Components.TD T5(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[3].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-202,-4})));
    PNlib.Components.TD T6(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[3].y and T_Geo >= 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-222,-4})));
    PNlib.Components.PD Heating_I(nIn=4, nOut=4) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-52,26})));
    PNlib.Components.TD T7(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[1].y) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-76,36})));
    PNlib.Components.TD T8(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[2].y and CHP_ThermalPower <= 36 and T_Recool > 278.15)
      annotation (Placement(transformation(extent={{-86,6},{-66,26}})));
    PNlib.Components.TD T9(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo >= 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-168,-54})));
    PNlib.Components.TD T10(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[1].y) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-148,-54})));
    PNlib.Components.TD T13(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[2].y and (CHP_ThermalPower > 0.8 or T_Recool <= 278.15))
      annotation (Placement(transformation(extent={{-86,-34},{-66,-14}})));
    PNlib.Components.TD T14(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[1].y) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-76,-44})));
    PNlib.Components.TD T15(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[2].y and (CHP_ThermalPower > 0.8 or T_Recool <= 278.15))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-42,-2})));
    PNlib.Components.TD T16(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[2].y and CHP_ThermalPower <= 36 and T_Recool > 278.15)
                 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-62,-2})));
    PNlib.Components.TD T17(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-132,-84})));
    PNlib.Components.TD T18(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo >= 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-132,-102})));
    PNlib.Components.TD T19(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[1].y) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-116,-54})));
    PNlib.Components.TD T20(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-96,-54})));
    PNlib.Components.PD Heating_II(nIn=4, nOut=4) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-52,-38})));
    PNlib.Components.PD Combination_I(nIn=6, nOut=6) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-158,-94})));
    PNlib.Components.PD Combination_II(nIn=6, nOut=6) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-102,-94})));
    PNlib.Components.TD T11(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[2].y and (CHP_ThermalPower > 0.8 or T_Recool <= 278.15))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,-24})));
    PNlib.Components.TD T12(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo >= 285.15)
      annotation (Placement(transformation(extent={{-38,-54},{-18,-34}})));
    PNlib.Components.TD T21(
      nIn=1,
      nOut=1,
      delay=600,
      firingCon=SuperiorMode[4].y and T_Geo >= 285.15)
      annotation (Placement(transformation(extent={{-38,26},{-18,46}})));
    PNlib.Components.TD T22(
      nIn=1,
      nOut=1,
      delay=600,
      firingCon=SuperiorMode[2].y and CHP_ThermalPower <= 36 and T_Recool > 278.15)
                 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,16})));
    PNlib.Components.TD T23(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[2].y and (CHP_ThermalPower > 0.8 or T_Recool <= 278.15))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-42,-62})));
    PNlib.Components.TD T24(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-62,-62})));
    PNlib.Components.TD T25(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[2].y and CHP_ThermalPower <= 36 and T_Recool > 278.15)
                 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-42,56})));
    PNlib.Components.TD T26(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-62,56})));
    PNlib.Components.TD T27(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[3].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-204,-64})));
    PNlib.Components.TD T28(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo >= 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-224,-64})));
    PNlib.Components.TD T29(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-202,58})));
    PNlib.Components.TD T30(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[3].y and T_Geo >= 285.15) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-222,58})));
    PNlib.Components.TD T31(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[3].y and T_Geo >= 285.15)
      annotation (Placement(transformation(extent={{-246,48},{-226,28}})));
    PNlib.Components.TD T32(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo >= 285.15) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-236,18})));
    PNlib.Components.TD T33(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[4].y and T_Geo < 285.15) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-236,-24})));
    PNlib.Components.TD T34(
      nIn=1,
      nOut=1,
      delay=300,
      firingCon=SuperiorMode[3].y and T_Geo < 285.15)
      annotation (Placement(transformation(extent={{-246,-34},{-226,-54}})));
  equation
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

    connect(integerToBoolean1[8].y, automationLevelBus.Workshop_Off) annotation (
       Line(points={{0,-158.8},{0,-181},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[9].y, automationLevelBus.Workshop_Heating)
      annotation (Line(points={{0,-158.8},{0,-170},{0,-181},{2,-181}}, color={255,
            0,255}));
    connect(integerToBoolean1[10].y, automationLevelBus.Workshop_Cooling)
      annotation (Line(points={{0,-158.8},{2,-158.8},{2,-181}}, color={255,0,255}));

      connect(integerToBoolean1[11].y, automationLevelBus.Canteen_Off) annotation (
       Line(points={{0,-158.8},{0,-181},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[12].y, automationLevelBus.Canteen_Heating)
      annotation (Line(points={{0,-158.8},{0,-170},{0,-181},{2,-181}}, color={255,
            0,255}));
    connect(integerToBoolean1[13].y, automationLevelBus.Canteen_Cooling)
      annotation (Line(points={{0,-158.8},{2,-158.8},{2,-181}}, color={255,0,255}));

         connect(integerToBoolean1[14].y, automationLevelBus.ConferenceRoom_Off) annotation (
       Line(points={{0,-158.8},{0,-181},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[15].y, automationLevelBus.ConferenceRoom_Heating)
      annotation (Line(points={{0,-158.8},{0,-170},{0,-181},{2,-181}}, color={255,
            0,255}));
    connect(integerToBoolean1[16].y, automationLevelBus.ConferenceRoom_Cooling)
      annotation (Line(points={{0,-158.8},{2,-158.8},{2,-181}}, color={255,0,255}));

      connect(integerToBoolean1[17].y, automationLevelBus.MultipersonOffice_Off) annotation (
       Line(points={{0,-158.8},{0,-181},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[18].y, automationLevelBus.MultipersonOffice_Heating)
      annotation (Line(points={{0,-158.8},{0,-170},{0,-181},{2,-181}}, color={255,
            0,255}));
    connect(integerToBoolean1[19].y, automationLevelBus.MultipersonOffice_Cooling)
      annotation (Line(points={{0,-158.8},{2,-158.8},{2,-181}}, color={255,0,255}));
      connect(integerToBoolean1[20].y, automationLevelBus.OpenplanOffice_Off) annotation (
       Line(points={{0,-158.8},{0,-181},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[21].y, automationLevelBus.OpenplanOffice_Heating)
      annotation (Line(points={{0,-158.8},{0,-170},{0,-181},{2,-181}}, color={255,
            0,255}));
    connect(integerToBoolean1[22].y, automationLevelBus.OpenplanOffice_Cooling)
      annotation (Line(points={{0,-158.8},{2,-158.8},{2,-181}}, color={255,0,255}));

    connect(managementLevelBus.Off, SuperiorMode[1].u) annotation (Line(
        points={{0,100},{12,100},{12,91.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(managementLevelBus.Heating, SuperiorMode[2].u) annotation (Line(
        points={{0,100},{12,100},{12,91.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(managementLevelBus.Cooling, SuperiorMode[3].u) annotation (Line(
        points={{0,100},{12,100},{12,91.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(managementLevelBus.Combination, SuperiorMode[4].u) annotation (Line(
        points={{0,100},{12,100},{12,91.2}},
        color={255,204,51},
        thickness=0.5));
    connect(Off.outTransition[1], T8.inPlaces[1]) annotation (Line(points={{-123.2,
            -4.83333},{-112,-4.83333},{-112,16},{-80.8,16}},
                                                           color={0,0,0}));
    connect(Off.outTransition[2], T13.inPlaces[1]) annotation (Line(points={{-123.2,
            -4.5},{-112,-4.5},{-112,-24},{-80.8,-24}},
                                                     color={0,0,0}));
    connect(Off.outTransition[3], T1.inPlaces[1]) annotation (Line(points={{-123.2,
            -4.16667},{-112,-4.16667},{-112,36},{-183.2,36}},
                                                            color={0,0,0}));
    connect(Off.outTransition[4], T4.inPlaces[1]) annotation (Line(points={{-123.2,
            -3.83333},{-112,-3.83333},{-112,-44},{-183.2,-44}},
                                                              color={0,0,0}));
    connect(Off.outTransition[6], T20.inPlaces[1]) annotation (Line(points={{-123.2,
            -3.16667},{-112,-3.16667},{-112,-44},{-96,-44},{-96,-49.2}},
                                                                       color={0,0,
            0}));
    connect(Off.outTransition[5], T9.inPlaces[1]) annotation (Line(points={{-123.2,
            -3.5},{-112,-3.5},{-112,-44},{-168,-44},{-168,-49.2}},
                                                                 color={0,0,0}));
    connect(Off.inTransition[1], T7.outPlaces[1]) annotation (Line(points={{-144.8,
            -4.83333},{-148,-4.83333},{-148,-4},{-160,-4},{-160,36},{-80.8,36}},
          color={0,0,0}));
    connect(T14.outPlaces[1], Off.inTransition[2]) annotation (Line(points={{-80.8,
            -44},{-160,-44},{-160,-4.5},{-144.8,-4.5}},
                                                      color={0,0,0}));
    connect(T2.outPlaces[1], Off.inTransition[3]) annotation (Line(points={{-183.2,
            16},{-160,16},{-160,-4},{-152,-4},{-152,-4.16667},{-144.8,-4.16667}},
          color={0,0,0}));
    connect(T3.outPlaces[1], Off.inTransition[4]) annotation (Line(points={{-183.2,
            -24},{-160,-24},{-160,-3.83333},{-144.8,-3.83333}},
                                                              color={0,0,0}));
    connect(T10.outPlaces[1], Off.inTransition[5]) annotation (Line(points={{-148,
            -49.2},{-148,-44},{-160,-44},{-160,-3.5},{-144.8,-3.5}},
                                                                   color={0,0,0}));
    connect(T19.outPlaces[1], Off.inTransition[6]) annotation (Line(points={{-116,
            -49.2},{-116,-44},{-160,-44},{-160,-3.16667},{-144.8,-3.16667}},
                                                                           color={
            0,0,0}));
    connect(T20.outPlaces[1], Combination_II.inTransition[1]) annotation (Line(
          points={{-96,-58.8},{-96,-83.2},{-102.833,-83.2}}, color={0,0,0}));
    connect(T24.outPlaces[1], Combination_II.inTransition[3]) annotation (Line(
          points={{-62,-66.8},{-62,-83.2},{-102.167,-83.2}}, color={0,0,0}));
    connect(T26.outPlaces[1], Combination_II.inTransition[2]) annotation (Line(
          points={{-62,60.8},{-62,66},{-12,66},{-12,-83.2},{-102.5,-83.2}}, color=
           {0,0,0}));
    connect(T17.outPlaces[1], Combination_II.inTransition[6]) annotation (Line(
          points={{-127.2,-84},{-101.167,-84},{-101.167,-83.2}}, color={0,0,0}));
    connect(T33.outPlaces[1], Combination_II.inTransition[5]) annotation (Line(
          points={{-240.8,-24},{-252,-24},{-252,-126},{-82,-126},{-82,-83.2},{-101.5,
            -83.2}}, color={0,0,0}));
    connect(T29.outPlaces[1], Combination_II.inTransition[4]) annotation (Line(
          points={{-202,62.8},{-202,66},{-252,66},{-252,-126},{-82,-126},{-82,
            -83.2},{-101.833,-83.2}},
                               color={0,0,0}));
    connect(Combination_II.outTransition[3], T23.inPlaces[1]) annotation (Line(
          points={{-102.167,-104.8},{-102.167,-114},{-42,-114},{-42,-66.8}},color=
           {0,0,0}));
    connect(Combination_II.outTransition[2], T25.inPlaces[1]) annotation (Line(
          points={{-102.5,-104.8},{-102.5,-114},{-12,-114},{-12,66},{-42,66},{-42,
            60.8}},
          color={0,0,0}));
    connect(Combination_II.outTransition[1], T19.inPlaces[1]) annotation (Line(
          points={{-102.833,-104.8},{-102.833,-114},{-116,-114},{-116,-58.8}},
          color={0,0,0}));
    connect(Combination_II.outTransition[6], T18.inPlaces[1]) annotation (Line(
          points={{-101.167,-104.8},{-101.167,-106},{-102,-106},{-102,-114},{
            -116,-114},{-116,-102},{-127.2,-102}},
                                      color={0,0,0}));
    connect(Combination_II.outTransition[5], T34.inPlaces[1]) annotation (Line(
          points={{-101.5,-104.8},{-102,-104.8},{-102,-126},{-252,-126},{-252,-44},
            {-240.8,-44}},
                   color={0,0,0}));
    connect(Combination_II.outTransition[4], T30.inPlaces[1]) annotation (Line(
          points={{-101.833,-104.8},{-101.833,-126},{-252,-126},{-252,66},{-222,
            66},{-222,62.8}},
                          color={0,0,0}));
    connect(T8.outPlaces[1], Heating_I.inTransition[1]) annotation (Line(points={{-71.2,
            16},{-62,16},{-62,15.2},{-51.25,15.2}},       color={0,0,0}));
    connect(T16.outPlaces[1], Heating_I.inTransition[2]) annotation (Line(points={{-62,2.8},
            {-62,15.2},{-51.75,15.2}},            color={0,0,0}));
    connect(T25.outPlaces[1], Heating_I.inTransition[4]) annotation (Line(points={{-42,
            51.2},{-40,51.2},{-40,15.2},{-52.75,15.2}},      color={0,0,0}));
    connect(T22.outPlaces[1], Heating_I.inTransition[3]) annotation (Line(points={{-32.8,
            16},{-42,16},{-42,15.2},{-52.25,15.2}},        color={0,0,0}));
    connect(Heating_I.outTransition[1], T7.inPlaces[1]) annotation (Line(points={{-51.25,
            36.8},{-58,36.8},{-58,36},{-71.2,36}},        color={0,0,0}));
    connect(Heating_I.outTransition[2], T15.inPlaces[1]) annotation (Line(points={{-51.75,
            36.8},{-46,36.8},{-46,36},{-40,36},{-40,10},{-42,10},{-42,2.8}},
          color={0,0,0}));
    connect(Heating_I.outTransition[4], T26.inPlaces[1]) annotation (Line(points={{-52.75,
            36.8},{-54,36.8},{-54,38},{-64,38},{-64,51.2},{-62,51.2}},
          color={0,0,0}));
    connect(Heating_I.outTransition[3], T21.inPlaces[1]) annotation (Line(points={{-52.25,
            36.8},{-44,36.8},{-44,36},{-32.8,36}},         color={0,0,0}));
    connect(Heating_II.inTransition[2], T15.outPlaces[1]) annotation (Line(points={{-52.25,
            -27.2},{-48,-27.2},{-48,-26},{-42,-26},{-42,-6.8}},        color={0,0,
            0}));
    connect(Heating_II.inTransition[3], T11.outPlaces[1]) annotation (Line(points={{-51.75,
            -27.2},{-46,-27.2},{-46,-28},{-32.8,-28},{-32.8,-24}},         color={
            0,0,0}));
    connect(T23.outPlaces[1], Heating_II.inTransition[4]) annotation (Line(points={{-42,
            -57.2},{-42,-27.2},{-51.25,-27.2}},      color={0,0,0}));
    connect(Heating_II.outTransition[1], T14.inPlaces[1]) annotation (Line(points={{-52.75,
            -48.8},{-56,-48.8},{-56,-48},{-71.2,-48},{-71.2,-44}},         color={
            0,0,0}));
    connect(Heating_II.outTransition[2], T16.inPlaces[1]) annotation (Line(points={{-52.25,
            -48.8},{-56,-48.8},{-56,-48},{-66,-48},{-66,-6.8},{-62,-6.8}},
          color={0,0,0}));
    connect(Heating_II.outTransition[3], T12.inPlaces[1]) annotation (Line(points={{-51.75,
            -48.8},{-44,-48.8},{-44,-48},{-32.8,-48},{-32.8,-44}},         color={
            0,0,0}));
    connect(Heating_II.outTransition[4], T24.inPlaces[1]) annotation (Line(points={{-51.25,
            -48.8},{-51.25,-48},{-62,-48},{-62,-57.2}},         color={0,0,0}));
    connect(Combination_I.outTransition[6], T17.inPlaces[1]) annotation (Line(
          points={{-158.833,-83.2},{-136.8,-83.2},{-136.8,-84}}, color={0,0,0}));
    connect(Combination_I.outTransition[1], T10.inPlaces[1]) annotation (Line(
          points={{-157.167,-83.2},{-156,-83.2},{-156,-84},{-148,-84},{-148,
            -58.8}},
          color={0,0,0}));
    connect(Combination_I.outTransition[2], T22.inPlaces[1]) annotation (Line(
          points={{-157.5,-83.2},{-162,-83.2},{-162,-84},{-174,-84},{-174,-126},{-12,
            -126},{-12,16},{-23.2,16}}, color={0,0,0}));
    connect(Combination_I.outTransition[3], T11.inPlaces[1]) annotation (Line(
          points={{-157.833,-83.2},{-162,-83.2},{-162,-84},{-174,-84},{-174,
            -126},{-12,-126},{-12,-24},{-23.2,-24}},
                                               color={0,0,0}));
    connect(Combination_I.outTransition[5], T27.inPlaces[1]) annotation (Line(
          points={{-158.5,-83.2},{-164,-83.2},{-164,-84},{-204,-84},{-204,-68.8}},
          color={0,0,0}));
    connect(Combination_I.outTransition[4], T31.inPlaces[1]) annotation (Line(
          points={{-158.167,-83.2},{-162,-83.2},{-162,-84},{-174,-84},{-174,
            -104},{-252,-104},{-252,38},{-240.8,38}},
                                              color={0,0,0}));
    connect(Combination_I.inTransition[6], T18.outPlaces[1]) annotation (Line(
          points={{-158.833,-104.8},{-150,-104.8},{-150,-106},{-136.8,-106},{
            -136.8,-102}},
          color={0,0,0}));
    connect(T28.outPlaces[1], Combination_I.inTransition[5]) annotation (Line(
          points={{-224,-68.8},{-224,-88},{-222,-88},{-222,-104.8},{-158.5,-104.8}},
          color={0,0,0}));
    connect(T32.outPlaces[1], Combination_I.inTransition[4]) annotation (Line(
          points={{-240.8,18},{-252,18},{-252,-104},{-206,-104},{-206,-104.8},{
            -158.167,-104.8}},
                     color={0,0,0}));
    connect(Combination_I.inTransition[3], T12.outPlaces[1]) annotation (Line(
          points={{-157.833,-104.8},{-157.833,-126},{-12,-126},{-12,-44},{-23.2,
            -44}},
          color={0,0,0}));
    connect(Combination_I.inTransition[2], T21.outPlaces[1]) annotation (Line(
          points={{-157.5,-104.8},{-157.5,-116},{-158,-116},{-158,-126},{-12,-126},
            {-12,36},{-23.2,36}}, color={0,0,0}));
    connect(Cooling_II.outTransition[1], T3.inPlaces[1]) annotation (Line(points={{-211.25,
            -23.2},{-208,-23.2},{-208,-24},{-192.8,-24}},          color={0,0,0}));
    connect(Cooling_II.outTransition[2], T6.inPlaces[1]) annotation (Line(points={{-211.75,
            -23.2},{-214,-23.2},{-214,-24},{-224,-24},{-224,-8.8},{-222,-8.8}},
          color={0,0,0}));
    connect(Cooling_II.outTransition[3], T28.inPlaces[1]) annotation (Line(points={{-212.25,
            -23.2},{-216,-23.2},{-216,-24},{-224,-24},{-224,-59.2}},
          color={0,0,0}));
    connect(Cooling_II.outTransition[4], T33.inPlaces[1]) annotation (Line(points={{-212.75,
            -23.2},{-218,-23.2},{-218,-24},{-231.2,-24}},          color={0,0,0}));
    connect(T4.outPlaces[1], Cooling_II.inTransition[1]) annotation (Line(points={{-192.8,
            -44},{-202,-44},{-202,-44.8},{-211.25,-44.8}},         color={0,0,0}));
    connect(T5.outPlaces[1], Cooling_II.inTransition[2]) annotation (Line(points={{-202,
            -8.8},{-202,-44.8},{-211.75,-44.8}},      color={0,0,0}));
    connect(T27.outPlaces[1], Cooling_II.inTransition[3]) annotation (Line(points={{-204,
            -59.2},{-204,-44.8},{-212.25,-44.8}},       color={0,0,0}));
    connect(T34.outPlaces[1], Cooling_II.inTransition[4]) annotation (Line(points={{-231.2,
            -44},{-212.75,-44},{-212.75,-44.8}},         color={0,0,0}));
    connect(Cooling_I.outTransition[1], T2.inPlaces[1]) annotation (Line(points={{-212.75,
            13.2},{-208,13.2},{-208,12},{-192.8,12},{-192.8,16}},         color={0,
            0,0}));
    connect(Cooling_I.outTransition[2], T5.inPlaces[1]) annotation (Line(points={{-212.25,
            13.2},{-208,13.2},{-208,12},{-200,12},{-200,0.8},{-202,0.8}},
          color={0,0,0}));
    connect(Cooling_I.outTransition[3], T32.inPlaces[1]) annotation (Line(points={{-211.75,
            13.2},{-218,13.2},{-218,16},{-231.2,16},{-231.2,18}},          color={
            0,0,0}));
    connect(Cooling_I.outTransition[4], T29.inPlaces[1]) annotation (Line(points={{-211.25,
            13.2},{-208,13.2},{-208,12},{-202,12},{-202,53.2}},          color={0,
            0,0}));
    connect(Cooling_I.inTransition[1], T1.outPlaces[1]) annotation (Line(points={{-212.75,
            34.8},{-208,34.8},{-208,34},{-192.8,34},{-192.8,36}},         color={0,
            0,0}));
    connect(T6.outPlaces[1], Cooling_I.inTransition[2]) annotation (Line(points={{-222,
            0.8},{-222,34.8},{-212.25,34.8}},       color={0,0,0}));
    connect(T31.outPlaces[1], Cooling_I.inTransition[3]) annotation (Line(points={{-231.2,
            38},{-211.75,38},{-211.75,34.8}},         color={0,0,0}));
    connect(T30.outPlaces[1], Cooling_I.inTransition[4]) annotation (Line(points={{-222,
            53.2},{-222,34.8},{-211.25,34.8}},       color={0,0,0}));
    connect(T13.outPlaces[1], Heating_II.inTransition[1]) annotation (Line(points={{-71.2,
            -24},{-52.75,-24},{-52.75,-27.2}},        color={0,0,0}));
    connect(T9.outPlaces[1], Combination_I.inTransition[1]) annotation (Line(
          points={{-168,-58.8},{-168,-104.8},{-157.167,-104.8}},
                                                               color={0,0,0}));
    connect(Off.pd_t, integerToBoolean1[1].u) annotation (Line(points={{-134,6.6},
            {-132,6.6},{-132,80},{1.77636e-15,80},{1.77636e-15,-140.4}},  color={255,
            127,0}));
    connect(Combination_II.pd_t, integerToBoolean1[7].u) annotation (Line(points={{-91.4,
            -94},{1.77636e-15,-94},{1.77636e-15,-140.4}},
                                             color={255,127,0}));
    connect(Combination_I.pd_t, integerToBoolean1[6].u) annotation (Line(points={{-168.6,
            -94},{-182,-94},{-182,-126},{1.77636e-15,-126},{1.77636e-15,-140.4}},
                                                                     color={255,127,
            0}));
    connect(Heating_II.pd_t, integerToBoolean1[3].u) annotation (Line(points={{-41.4,
            -38},{-40,-38},{-40,-10},{1.77636e-15,-10},{1.77636e-15,-140.4}},
                                                                          color={255,
            127,0}));
    connect(Heating_I.pd_t, integerToBoolean1[2].u) annotation (Line(points={{-62.6,
            26},{-62,26},{-62,50},{1.77636e-15,50},{1.77636e-15,-140.4}},
                                                      color={255,127,0}));
    connect(Cooling_I.pd_t, integerToBoolean1[4].u) annotation (Line(points={{-201.4,
            24},{-200,24},{-200,52},{-252,52},{-252,-126},{1.77636e-15,-126},{1.77636e-15,
            -140.4}}, color={255,127,0}));
    connect(Cooling_II.pd_t, integerToBoolean1[5].u) annotation (Line(points={{-222.6,
            -34},{-224,-34},{-224,-10},{-252,-10},{-252,-126},{1.77636e-15,-126},{
            1.77636e-15,-140.4}},
                      color={255,127,0}));
    connect(integerToBoolean1[1].y, automationLevelBus.Off) annotation (Line(
          points={{0,-158.8},{0,-181},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[2].y, automationLevelBus.Heating_I) annotation (
        Line(points={{0,-158.8},{2,-158.8},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[3].y, automationLevelBus.Heating_II) annotation (
        Line(points={{0,-158.8},{2,-158.8},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[4].y, automationLevelBus.Cooling_I) annotation (
        Line(points={{-1.77636e-15,-158.8},{-1.77636e-15,-164.4},{2,-164.4},{2,-181}},
          color={255,0,255}));
    connect(integerToBoolean1[5].y, automationLevelBus.Cooling_II) annotation (Line(
          points={{0,-158.8},{2,-158.8},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[6].y, automationLevelBus.Combination_I) annotation (
       Line(points={{0,-158.8},{0,-170},{0,-181},{2,-181}}, color={255,0,255}));
    connect(integerToBoolean1[7].y, automationLevelBus.Combination_II)
      annotation (Line(points={{-1.55431e-15,-158.8},{-1.55431e-15,-164.4},{2,-164.4},
            {2,-181}}, color={255,0,255}));
    connect(P11.pd_t, integerToBoolean1[8].u) annotation (Line(points={{41.52,54},
            {42,54},{42,24},{1.77636e-15,24},{1.77636e-15,-140.4}}, color={255,127,
            0}));
    connect(P12.pd_t, integerToBoolean1[9].u) annotation (Line(points={{88.48,54},
            {90,54},{90,24},{0,24},{0,-140.4}}, color={255,127,0}));
    connect(P1.pd_t, integerToBoolean1[10].u) annotation (Line(points={{28.48,54},
            {28,54},{28,24},{0,24},{0,-140.4},{1.77636e-15,-140.4}}, color={255,127,
            0}));
    connect(P17.pd_t, integerToBoolean1[11].u) annotation (Line(points={{135.52,54},
            {136,54},{136,24},{0,24},{0,-140.4}}, color={255,127,0}));
    connect(P16.pd_t, integerToBoolean1[12].u) annotation (Line(points={{182.48,54},
            {184,54},{184,24},{0,24},{0,-140.4}}, color={255,127,0}));
    connect(P18.pd_t, integerToBoolean1[13].u) annotation (Line(points={{122.48,54},
            {122,54},{122,24},{0,24},{0,-58},{1.77636e-15,-58},{1.77636e-15,-140.4}},
          color={255,127,0}));
    connect(P115.pd_t, integerToBoolean1[14].u) annotation (Line(points={{53.52,-10},
            {54,-10},{54,-22},{56,-22},{56,-52},{1.77636e-15,-52},{1.77636e-15,-140.4}},
          color={255,127,0}));
    connect(P116.pd_t, integerToBoolean1[15].u) annotation (Line(points={{100.48,-10},
            {102,-10},{102,-52},{1.77636e-15,-52},{1.77636e-15,-140.4}}, color={255,
            127,0}));
    connect(P117.pd_t, integerToBoolean1[16].u) annotation (Line(points={{40.48,-10},
            {40,-10},{40,-52},{0,-52},{0,-140.4},{1.77636e-15,-140.4}}, color={255,
            127,0}));
    connect(P14.pd_t, integerToBoolean1[17].u) annotation (Line(points={{145.52,-12},
            {146,-12},{146,-52},{1.77636e-15,-52},{1.77636e-15,-140.4}}, color={255,
            127,0}));
    connect(P13.pd_t, integerToBoolean1[18].u) annotation (Line(points={{192.48,-12},
            {192,-12},{192,-52},{0,-52},{0,-140.4}}, color={255,127,0}));
    connect(P15.pd_t, integerToBoolean1[19].u) annotation (Line(points={{132.48,-12},
            {132,-12},{132,-52},{0,-52},{0,-140.4}}, color={255,127,0}));
    connect(P110.pd_t, integerToBoolean1[20].u) annotation (Line(points={{145.52,-80},
            {145.52,-100},{146,-100},{146,-120},{1.77636e-15,-120},{1.77636e-15,-140.4}},
          color={255,127,0}));
    connect(P111.pd_t, integerToBoolean1[21].u) annotation (Line(points={{192.48,-80},
            {192,-80},{192,-120},{0,-120},{0,-140.4},{1.77636e-15,-140.4}}, color=
           {255,127,0}));
    connect(P19.pd_t, integerToBoolean1[22].u) annotation (Line(points={{132.48,-80},
            {132,-80},{132,-120},{1.77636e-15,-120},{1.77636e-15,-140.4}}, color={
            255,127,0}));
               annotation (
      Diagram(                                                                                                                                                                                                        coordinateSystem(extent={{-260,
              -180},{200,100}},                                                                                                                                                                                                        initialScale = 0.1)),
      Icon(graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
              fillPattern =                                                                           FillPattern.Solid,
              lineThickness =                                                                                                            0.5, extent={{
                -260,100},{202,-180}}),                                                                                                                                             Text(origin={
                -206.675,15.0721},                                                                                                                                                                            lineColor=
                {95,95,95},                                                                                                                                                                                                        extent={{
                -9.32512,28.9279},{370.675,-133.074}},
            textString="Automation
 Level")},  coordinateSystem(extent={{-260,-180},{200,100}})),
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
  end AutomationLevel;

  model FieldLevel
    "Auswahl der Aktoren basierend auf den ausgewählten Aktorsätzen"

    AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus annotation (
        Placement(
        visible=true,
        transformation(
          origin={0,-120},
          extent={{-10,-10},{10,10}},
          rotation=0),
        iconTransformation(
          origin={0,-120},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_GTFSystem
      controller_GTFSystem1 annotation (Placement(visible=true, transformation(
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
      controller_HTSSystem1(T_boi_set=273.15 + 65) annotation (Placement(
          visible=true, transformation(
          origin={-80,110},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
      controller_Tabs_Workshop(reverseAction_Cold=true, TflowSet(
          displayUnit="K") = 288.15) annotation (Placement(visible=true,
          transformation(extent={{-90,-40},{-70,-20}}, rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
      controller_VU_Workshop(TRoomSet=288.15, VFlowSet=2700/3600)
      annotation (Placement(visible=true, transformation(
          origin={50,-30},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
      controller_VU_Canteen(TRoomSet=295.15, VFlowSet=1800/3600)
      annotation (Placement(visible=true, transformation(
          origin={50,-50},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
      controller_VU_ConferenceRoom(TRoomSet=295.15, VFlowSet=150/3600)
      annotation (Placement(visible=true, transformation(
          origin={50,-70},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
      controller_VU_MultipersonOffice(TRoomSet=295.15, VFlowSet=300/3600)
      annotation (Placement(visible=true, transformation(
          origin={50,-90},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_VU
      controller_VU_OpenplanOffice(TRoomSet=295.15, VFlowSet=4050/3600)
      annotation (Placement(visible=true, transformation(
          origin={50,-110},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
      controller_Tabs_Canteen(reverseAction_Cold=true, TflowSet(displayUnit=
           "K") = 292.15) annotation (Placement(visible=true,
          transformation(extent={{-90,-60},{-70,-40}}, rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
      controller_Tabs_ConferenceRoom(reverseAction_Cold=true, TflowSet(
          displayUnit="K") = 292.15) annotation (Placement(visible=true,
          transformation(extent={{-90,-80},{-70,-60}}, rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
      controller_Tabs_MultipersonOffice(reverseAction_Cold=true, TflowSet(
          displayUnit="K") = 292.15) annotation (Placement(visible=true,
          transformation(extent={{-90,-100},{-70,-80}}, rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_Tabs
      controller_Tabs_OpenplanOffice(reverseAction_Cold=true, TflowSet(
          displayUnit="K") = 292.15) annotation (Placement(visible=true,
          transformation(extent={{-90,-120},{-70,-100}}, rotation=0)));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_HX
      controller_HX(TflowSet=293.15, rpmPumpPrim=130)
      annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Controller.Controller_CentralAHU
      controller_CentralAHU(
      VFlowSet=15500/3600,
      dpMax=2000,
      useTwoFanCont=true)
      annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
    AixLib.Systems.Benchmark_fb.Mode_based_ControlStrategy.Bus_Systems.AutomationLevelBus
      automationLevelBus
      annotation (Placement(transformation(extent={{-10,110},{10,130}})));
    Modelica.Blocks.Routing.BooleanPassThrough booleanPassThrough[22] annotation (
       Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={2,100})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,116})));
  equation
    connect(mainBus.htsBus, controller_HTSSystem1.highTempSystemBus1)
      annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,110},{-70,110}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.gtfBus, controller_GTFSystem1.gtfBus) annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,84},{-70,84}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.swuBus, controller_SwitchingUnit1.switchingUnitBus1)
      annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,70},{-70,70}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.hpSystemBus, controller_HPSystem1.heatPumpSystemBus1)
      annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,10},{-70,10}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.vu1Bus, controller_VU_Workshop.genericAHUBus1)
      annotation (Line(
        points={{0.05,-119.95},{100,-119.95},{100,-30},{60,-30}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.vu2Bus, controller_VU_Canteen.genericAHUBus1) annotation (
       Line(
        points={{0.05,-119.95},{100,-119.95},{100,-52},{60,-52},{60,-50}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.vu3Bus, controller_VU_ConferenceRoom.genericAHUBus1)
      annotation (Line(
        points={{0.05,-119.95},{100,-119.95},{100,-70},{60,-70}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.vu4Bus, controller_VU_MultipersonOffice.genericAHUBus1)
      annotation (Line(
        points={{0.05,-119.95},{100,-119.95},{100,-90},{60,-90}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.vu5Bus, controller_VU_OpenplanOffice.genericAHUBus1)
      annotation (Line(
        points={{0.05,-119.95},{100,-119.95},{100,-110},{60,-110}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.tabs1Bus, controller_Tabs_Workshop.tabsBus21) annotation (
       Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,-28},{-46,-28},
            {-46,-30},{-70,-30}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(mainBus.tabs2Bus, controller_Tabs_Canteen.tabsBus21) annotation (
        Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,-50},{-70,-50}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(mainBus.tabs3Bus, controller_Tabs_ConferenceRoom.tabsBus21)
      annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,-70},{-70,-70}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));

    connect(mainBus.tabs4Bus, controller_Tabs_MultipersonOffice.tabsBus21)
      annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,-90},{-70,-90}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(mainBus.tabs5Bus, controller_Tabs_OpenplanOffice.tabsBus21)
      annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,-110},{-70,-110}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(mainBus.hxBus, controller_HX.hxBus) annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,50},{-46,50},{
            -46,50.1},{-68.9,50.1}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(mainBus.TRoom1Mea, controller_VU_Workshop.TRoomMea) annotation (
        Line(
        points={{0.05,-119.95},{100,-119.95},{100,-22},{60.6,-22}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.TRoom2Mea, controller_VU_Canteen.TRoomMea) annotation (
        Line(
        points={{0.05,-119.95},{100,-119.95},{100,-42},{60.6,-42}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.TRoom3Mea, controller_VU_ConferenceRoom.TRoomMea)
      annotation (Line(
        points={{0.05,-119.95},{100,-119.95},{100,-62},{60.6,-62}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.TRoom4Mea, controller_VU_MultipersonOffice.TRoomMea)
      annotation (Line(
        points={{0.05,-119.95},{100,-119.95},{100,-82},{60.6,-82}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(mainBus.TRoom5Mea, controller_VU_OpenplanOffice.TRoomMea)
      annotation (Line(
        points={{0.05,-119.95},{100,-119.95},{100,-102},{60.6,-102}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBus.hpSystemBus.TTopHSMea, controller_HPSystem1.T_HotStorage)
      annotation (Line(
        points={{0.05,-119.95},{2,-119.95},{2,-120},{-20,-120},{-20,-10},{-88,-10},
            {-88,-0.8}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.hpSystemBus.TTopCSMea, controller_HPSystem1.T_ColdStorage)
      annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,-10},{-76,-10},
            {-76,-1}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.hpSystemBus.busHP.T_ret_co, controller_HPSystem1.T_Condensator)
      annotation (Line(
        points={{0.05,-119.95},{0,-119.95},{0,-120},{-20,-120},{-20,-10},{-84,-10},
            {-84,-0.8}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.hpSystemBus.busHP.T_ret_ev, controller_HPSystem1.T_Evaporator)
      annotation (Line(
        points={{0.05,-119.95},{-2,-119.95},{-2,-120},{-20,-120},{-20,-10},{-80,-10},
            {-80,-0.8}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.ahuBus, controller_CentralAHU.genericAHUBus) annotation (
        Line(
        points={{0.05,-119.95},{-20,-119.95},{-20,32},{-70,32},{-70,32.9286}},
        color={255,204,51},
        thickness=0.5));

    connect(automationLevelBus.Workshop_Off, booleanPassThrough[8].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.Workshop_Heating, booleanPassThrough[9].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.Workshop_Cooling, booleanPassThrough[10].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));

        connect(automationLevelBus.Canteen_Off, booleanPassThrough[11].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.Canteen_Heating, booleanPassThrough[12].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.Canteen_Cooling, booleanPassThrough[13].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));

        connect(automationLevelBus.ConferenceRoom_Off, booleanPassThrough[14].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.ConferenceRoom_Heating, booleanPassThrough[15].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.ConferenceRoom_Cooling, booleanPassThrough[16].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));

        connect(automationLevelBus.MultipersonOffice_Off, booleanPassThrough[17].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.MultipersonOffice_Heating, booleanPassThrough[18].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.MultipersonOffice_Cooling, booleanPassThrough[19].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));

  connect(automationLevelBus.OpenplanOffice_Off, booleanPassThrough[20].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.OpenplanOffice_Heating, booleanPassThrough[21].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
        connect(automationLevelBus.OpenplanOffice_Cooling, booleanPassThrough[22].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));

    connect(booleanPassThrough[9].y, controller_VU_Workshop.Heating)
      annotation (Line(points={{2,93.4},{4,93.4},{4,92},{2,92},{2,-8},{100,-8},{100,
            -34},{60.6,-34}},      color={255,0,255}));
    connect(booleanPassThrough[10].y, controller_VU_Workshop.Cooling)
      annotation (Line(points={{2,93.4},{2,-8},{100,-8},{100,-38},{60.6,-38}},
          color={255,0,255}));
    connect(booleanPassThrough[12].y, controller_VU_Canteen.Heating)
      annotation (Line(points={{2,93.4},{2,-8},{100,-8},{100,-54},{60.6,-54}},
          color={255,0,255}));
    connect(booleanPassThrough[13].y, controller_VU_Canteen.Cooling)
      annotation (Line(points={{2,93.4},{4,93.4},{4,92},{2,92},{2,-8},{100,-8},{100,
            -58},{60.6,-58}},      color={255,0,255}));
    connect(booleanPassThrough[15].y, controller_VU_ConferenceRoom.Heating)
      annotation (Line(points={{2,93.4},{2,-8},{100,-8},{100,-74},{60.6,-74}},
          color={255,0,255}));
    connect(booleanPassThrough[16].y, controller_VU_ConferenceRoom.Cooling)
      annotation (Line(points={{2,93.4},{2,-8},{100,-8},{100,-78},{60.6,-78}},
                                                color={255,0,255}));
    connect(booleanPassThrough[18].y, controller_VU_MultipersonOffice.Heating)
      annotation (Line(points={{2,93.4},{2,-8},{100,-8},{100,-94},{60.6,-94}},
          color={255,0,255}));
    connect(booleanPassThrough[19].y, controller_VU_MultipersonOffice.Cooling)
      annotation (Line(points={{2,93.4},{2,-8},{100,-8},{100,-98},{60.6,-98}},
          color={255,0,255}));
    connect(booleanPassThrough[21].y, controller_VU_OpenplanOffice.Heating)
      annotation (Line(points={{2,93.4},{2,-8},{100,-8},{100,-114},{60.6,-114}},
          color={255,0,255}));
    connect(booleanPassThrough[22].y, controller_VU_OpenplanOffice.Cooling)
      annotation (Line(points={{2,93.4},{2,-8},{100,-8},{100,-118},{60.6,-118}},
          color={255,0,255}));
    connect(automationLevelBus.Off, booleanPassThrough[1].u) annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
    connect(automationLevelBus.Heating_I, booleanPassThrough[2].u) annotation (
        Line(
        points={{0,120},{-2,120},{-2,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
    connect(automationLevelBus.Heating_II, booleanPassThrough[3].u) annotation (
        Line(
        points={{0,120},{2,120},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
    connect(automationLevelBus.Cooling_I, booleanPassThrough[4].u) annotation (
        Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
    connect(automationLevelBus.Combination_I, booleanPassThrough[6].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
    connect(automationLevelBus.Combination_II, booleanPassThrough[7].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));

    connect(automationLevelBus.Cooling_II, booleanPassThrough[5].u)
      annotation (Line(
        points={{0,120},{0,107.2},{2,107.2}},
        color={255,204,51},
        thickness=0.5));
    connect(controller_GTFSystem1.GTF_Off, booleanPassThrough[1].y)
      annotation (Line(points={{-69.2,96},{-20,96},{-20,88},{2,88},{2,93.4}},
          color={255,0,255}));
    connect(controller_HTSSystem1.Heating_I, booleanPassThrough[2].y) annotation (
       Line(points={{-69.4,118},{-20,118},{-20,88},{2,88},{2,93.4}}, color={255,0,
            255}));
    connect(controller_HTSSystem1.Combination_I, booleanPassThrough[6].y)
      annotation (Line(points={{-69.4,114},{-56,114},{-56,112},{-20,112},{-20,88},
            {2,88},{2,93.4}}, color={255,0,255}));
    connect(controller_HTSSystem1.Combination_II, booleanPassThrough[7].y)
      annotation (Line(points={{-69.4,106.4},{-20,106.4},{-20,88},{2,88},{2,93.4}},
          color={255,0,255}));
    connect(controller_HTSSystem1.Heating_II, booleanPassThrough[3].y)
      annotation (Line(points={{-69.4,102},{-20,102},{-20,88},{2,88},{2,93.4}},
          color={255,0,255}));
    connect(controller_HX.On, booleanExpression.y) annotation (Line(points={{-69.3,
            55.1},{16,55.1},{16,116},{79,116}}, color={255,0,255}));
    connect(controller_SwitchingUnit1.Heating_I, booleanPassThrough[2].y)
      annotation (Line(points={{-69.4,79},{-69.4,80},{2,80},{2,93.4}}, color={255,
            0,255}));
    connect(controller_SwitchingUnit1.Heating_II, booleanPassThrough[3].y)
      annotation (Line(points={{-69.2,75.8},{-34,75.8},{-34,76},{2,76},{2,93.4}},
          color={255,0,255}));
    connect(controller_SwitchingUnit1.Cooling_I, booleanPassThrough[4].y)
      annotation (Line(points={{-69.2,72.2},{-34,72.2},{-34,72},{2,72},{2,93.4}},
          color={255,0,255}));
    connect(controller_SwitchingUnit1.Combination_I, booleanPassThrough[6].y)
      annotation (Line(points={{-69.4,67.4},{2,67.4},{2,93.4}}, color={255,0,255}));
    connect(controller_SwitchingUnit1.Cooling_II, booleanPassThrough[5].y)
      annotation (Line(points={{-69.2,64.2},{2,64.2},{2,93.4}}, color={255,0,255}));
    connect(controller_SwitchingUnit1.Combination_II, booleanPassThrough[7].y)
      annotation (Line(points={{-69.2,61.4},{2,61.4},{2,93.4}}, color={255,0,255}));
    connect(controller_CentralAHU.Heating_I, booleanPassThrough[2].y)
      annotation (Line(points={{-69.6,38.5714},{2,38.5714},{2,93.4}}, color=
           {255,0,255}));
    connect(controller_CentralAHU.Heating_II, booleanPassThrough[3].y)
      annotation (Line(points={{-69.6,35.7143},{-34,35.7143},{-34,36},{2,36},{2,
            93.4}},    color={255,0,255}));
    connect(controller_CentralAHU.Cooling_I, booleanPassThrough[4].y)
      annotation (Line(points={{-69.6,29.8571},{-34,29.8571},{-34,30},{2,30},{2,
            93.4}},    color={255,0,255}));
    connect(controller_CentralAHU.Cooling_II, booleanPassThrough[5].y)
      annotation (Line(points={{-69.4,25.7143},{-34,25.7143},{-34,26},{2,26},{2,
            93.4}},    color={255,0,255}));
    connect(controller_HPSystem1.Heating_I, booleanPassThrough[2].y)
      annotation (Line(points={{-69.4,19.2},{2,19.2},{2,93.4}}, color={255,
            0,255}));
    connect(controller_HPSystem1.Heating_II, booleanPassThrough[3].y)
      annotation (Line(points={{-69.4,15.4},{2,15.4},{2,93.4}}, color={255,
            0,255}));
    connect(controller_HPSystem1.Cooling_I, booleanPassThrough[4].y)
      annotation (Line(points={{-69.4,12.2},{-34,12.2},{-34,12},{2,12},{2,
            93.4}}, color={255,0,255}));
    connect(controller_HPSystem1.Cooling_II, booleanPassThrough[5].y)
      annotation (Line(points={{-69.6,7.6},{-34,7.6},{-34,8},{2,8},{2,93.4}},
          color={255,0,255}));
    connect(controller_HPSystem1.Combination_I, booleanPassThrough[6].y)
      annotation (Line(points={{-69.6,4.4},{-34,4.4},{-34,4},{2,4},{2,93.4}},
          color={255,0,255}));
    connect(controller_HPSystem1.Combination_II, booleanPassThrough[7].y)
      annotation (Line(points={{-69.4,1.2},{-34,1.2},{-34,2},{2,2},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_Workshop.Heating, booleanPassThrough[9].y)
      annotation (Line(points={{-69.4,-34},{0,-34},{0,93.4},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_Workshop.Cooling, booleanPassThrough[10].y)
      annotation (Line(points={{-69.6,-38},{0,-38},{0,93.4},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_Canteen.Heating, booleanPassThrough[12].y)
      annotation (Line(points={{-69.4,-54},{0,-54},{0,93.4},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_Canteen.Cooling, booleanPassThrough[13].y)
      annotation (Line(points={{-69.6,-58},{0,-58},{0,93.4},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_ConferenceRoom.Heating, booleanPassThrough[15].y)
      annotation (Line(points={{-69.4,-74},{0,-74},{0,10},{2,10},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_ConferenceRoom.Cooling, booleanPassThrough[16].y)
      annotation (Line(points={{-69.6,-78},{0,-78},{0,93.4},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_MultipersonOffice.Heating, booleanPassThrough[
      18].y) annotation (Line(points={{-69.4,-94},{0,-94},{0,93.4},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_MultipersonOffice.Cooling, booleanPassThrough[
      19].y) annotation (Line(points={{-69.6,-98},{0,-98},{0,93.4},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_OpenplanOffice.Heating, booleanPassThrough[21].y)
      annotation (Line(points={{-69.4,-114},{0,-114},{0,93.4},{2,93.4}},
          color={255,0,255}));
    connect(controller_Tabs_OpenplanOffice.Cooling, booleanPassThrough[22].y)
      annotation (Line(points={{-69.6,-118},{-54,-118},{-54,-114},{0,-114},
            {0,93.4},{2,93.4}}, color={255,0,255}));
    connect(controller_HPSystem1.Off, booleanPassThrough[1].y) annotation (
        Line(points={{-72.2,-0.4},{-72.2,44.8},{2,44.8},{2,93.4}}, color={
            255,0,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -120}, {100, 120}}), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
              fillPattern =                                                                                                                                                               FillPattern.Solid,
              lineThickness =                                                                                                                                                                                                0.5, extent={{
                -120,120},{122,-122}}),                                                                                                                                                                                                        Text(origin={
                -64.497,31.3324},                                                                                                                                                                                                        lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent={{
                -129.503,54.6676},{262.497,-109.331}},                                                                                                                                                                                                        textString = "Field 
 Level")}),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -120}, {100, 120}})),
      Documentation(info = "<html><head></head><body>Feldebene der MODI-Methode<div><br></div><div><br></div></body></html>"),
      __OpenModelica_commandLineOptions = "");
  end FieldLevel;

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
      AixLib.Systems.Benchmark.BaseClasses.HighTempSystemBus
        highTempSystemBus1 annotation (Placement(
          visible=true,
          transformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput Heating_I annotation (Placement(
          visible=true,
          transformation(
            origin={106,80},
            extent={{-14,-14},{14,14}},
            rotation=180),
          iconTransformation(
            origin={106,80},
            extent={{-14,-14},{14,14}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Heating_II annotation (Placement(
          visible=true,
          transformation(
            origin={106,-80},
            extent={{-14,-14},{14,14}},
            rotation=180),
          iconTransformation(
            origin={106,-80},
            extent={{-14,-14},{14,14}},
            rotation=180)));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(visible=
             true, transformation(extent={{-90,-40},{-70,-20}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput Combination_I annotation (
          Placement(
          visible=true,
          transformation(
            origin={106,40},
            extent={{-14,-14},{14,14}},
            rotation=180),
          iconTransformation(
            origin={106,40},
            extent={{-14,-14},{14,14}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Combination_II annotation (
          Placement(
          visible=true,
          transformation(
            origin={106,-40},
            extent={{-14,-14},{14,14}},
            rotation=180),
          iconTransformation(
            origin={106,-36},
            extent={{-14,-14},{14,14}},
            rotation=180)));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-88,-68},{-68,-48}})));
      Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={60,80})));
      Modelica.Blocks.Logical.Or or2 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={74,-66})));
      Modelica.Blocks.Logical.Or or3 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-74,4})));
    equation
      connect(rpmPumps.y, highTempSystemBus1.pumpBoilerBus.pumpBus.rpmSet) annotation (
        Line(points={{41,50},{60,50},{60,0},{100.05,0},{100.05,0.05}},                      color = {0, 0, 127}));
      connect(highTempSystemBus1.pumpBoilerBus.TRtrnInMea, PIDBoiler.u_m) annotation (
        Line(points={{100.05,0.05},{52,0.05},{52,-88},{-100,-88},{-100,26},{-50,
              26},{-50,38}},                                                                               color = {0, 0, 127}));
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
      connect(switch1.y, highTempSystemBus1.uRelBoilerSet) annotation (Line(
            points={{1,30},{20,30},{20,0.05},{100.05,0.05}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(Heating_II, switch1.u2) annotation (Line(points={{106,-80},{-100,
              -80},{-100,30},{-22,30}}, color={255,0,255}));
      connect(booleanExpression.y, highTempSystemBus1.pumpBoilerBus.pumpBus.onSet)
        annotation (Line(points={{-67,-58},{-38,-58},{-38,-36},{100.05,-36},{
              100.05,0.05}}, color={255,0,255}));
      connect(Heating_I, or1.u2) annotation (Line(points={{106,80},{92,80},{92,
              84},{72,84},{72,88}}, color={255,0,255}));
      connect(Combination_I, or1.u1) annotation (Line(points={{106,40},{90,40},
              {90,80},{72,80}}, color={255,0,255}));
      connect(Combination_II, or2.u2) annotation (Line(points={{106,-40},{98,
              -40},{98,-58},{86,-58}}, color={255,0,255}));
      connect(Heating_II, or2.u1) annotation (Line(points={{106,-80},{100,-80},
              {100,-66},{86,-66}}, color={255,0,255}));
      connect(or1.y, or3.u1) annotation (Line(points={{49,80},{10,80},{10,86},{
              -98,86},{-98,4},{-86,4}}, color={255,0,255}));
      connect(or2.y, or3.u2) annotation (Line(points={{63,-66},{-106,-66},{-106,
              -4},{-86,-4}}, color={255,0,255}));
      connect(or3.y, highTempSystemBus1.onOffChpSet) annotation (Line(points={{
              -63,4},{-28,4},{-28,-2},{-8,-2},{-8,0.05},{100.05,0.05}}, color={
              255,0,255}));
      connect(booleanExpression.y, highTempSystemBus1.pumpChpBus.pumpBus.onSet)
        annotation (Line(points={{-67,-58},{-42,-58},{-42,-50},{100.05,-50},{
              100.05,0.05}}, color={255,0,255}));
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
      Modelica.Blocks.Interfaces.BooleanInput GTF_Off
        "Connector of Boolean input signal" annotation (Placement(
          visible=true,
          transformation(
            origin={108,60},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={108,60},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Sources.Constant rpm(k = rpmPump) annotation (
        Placement(visible = true, transformation(extent = {{0, -70}, {20, -50}}, rotation = 0)));
      parameter Real rpmPump(min = 0, unit = "1") = 2100 "Rpm of the pump";
      AixLib.Systems.EONERC_MainBuilding.BaseClasses.TwoCircuitBus gtfBus
        annotation (Placement(
          visible=true,
          transformation(
            origin={100,-60},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={100,-60},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={70,60})));
    equation
      connect(rpm.y, gtfBus.primBus.pumpBus.rpmSet) annotation (
        Line(points = {{21, -60}, {100, -60}, {100, -59.95}, {100.05, -59.95}}, color = {0, 0, 127}));
      connect(booleanToReal.y, gtfBus.secBus.valveSet) annotation (
        Line(points = {{50, -1}, {50, -59.95}, {100.05, -59.95}}, color = {0, 0, 127}));
      connect(not1.u, GTF_Off)
        annotation (Line(points={{82,60},{108,60}}, color={255,0,255}));
      connect(not1.y, booleanToReal.u)
        annotation (Line(points={{59,60},{50,60},{50,22}}, color={255,0,255}));
      connect(not1.y, gtfBus.primBus.pumpBus.onSet) annotation (Line(points={{
              59,60},{50,60},{50,32},{100,32},{100,-59.95},{100.05,-59.95}},
            color={255,0,255}));
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
      Modelica.Blocks.Interfaces.BooleanInput Heating_I annotation (Placement(
          visible=true,
          transformation(
            origin={106,92},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={106,92},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Combination_II annotation (
          Placement(
          visible=true,
          transformation(
            origin={106,-88},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={106,-88},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      AixLib.Systems.EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus
        heatPumpSystemBus1 annotation (Placement(
          visible=true,
          transformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput Combination_I annotation (
          Placement(
          visible=true,
          transformation(
            origin={104,-56},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={104,-56},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Logical.Or or11 annotation (
        Placement(visible = true, transformation(origin={70,70},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Interfaces.RealInput T_HotStorage annotation (
        Placement(visible = true, transformation(origin = {-80, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {-80, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
      Modelica.Blocks.Interfaces.RealInput T_Condensator annotation (
        Placement(visible = true, transformation(origin = {-40, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {-40, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
      Modelica.Blocks.Interfaces.RealInput T_Evaporator annotation (
        Placement(visible = true, transformation(origin = {0, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {0, -108}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
      Modelica.Blocks.Interfaces.RealInput T_ColdStorage annotation (
        Placement(visible = true, transformation(origin = {40, -110}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {40, -110}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant rpm_pump_hot(k = rpmPumpHot) annotation (
        Placement(visible = true, transformation(origin={150,0},     extent = {{-10, -10}, {10, 10}}, rotation=180)));
      Modelica.Blocks.Sources.Constant rpm_pump_cold(k = rpmPumpCold) annotation (
        Placement(visible = true, transformation(origin={150,30},    extent = {{-10, -10}, {10, 10}}, rotation=180)));
      Modelica.Blocks.Logical.Or or13 annotation (
        Placement(visible = true, transformation(origin={70,-74},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.BooleanToReal Throttle_HotStorage
        annotation (Placement(transformation(extent={{-90,80},{-70,100}})));
      Modelica.Blocks.Math.BooleanToReal Throttle_Recool
        annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
      Modelica.Blocks.Math.BooleanToReal Throttle_Freecool
        annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
      Modelica.Blocks.Math.BooleanToReal Throttle_ColdStorage
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
     AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl.CtrHP ctrHP(N_rel_max=
           1, N_rel_min=0.3)
        annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      Modelica.Blocks.Sources.BooleanConstant HP_mode
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={150,90})));
      Modelica.Blocks.Sources.Constant HP_iceFac(k=1)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={150,60})));
      Modelica.Blocks.Logical.Or or1  annotation (
        Placement(visible = true, transformation(origin={150,-30},   extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Heating_II annotation (Placement(
          visible=true,
          transformation(
            origin={106,54},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={106,54},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_I annotation (Placement(
          visible=true,
          transformation(
            origin={106,30},
            extent={{-12,12},{12,-12}},
            rotation=180),
          iconTransformation(
            origin={106,22},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_II annotation (Placement(
          visible=true,
          transformation(
            origin={106,-32},
            extent={{-12,12},{12,-12}},
            rotation=180),
          iconTransformation(
            origin={104,-24},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Logical.Or or2  annotation (
        Placement(visible = true, transformation(origin={36,-50},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or3  annotation (
        Placement(visible = true, transformation(origin={76,34},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or4  annotation (
        Placement(visible = true, transformation(origin={30,14},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or5  annotation (
        Placement(visible = true, transformation(origin={4,48},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Not not1
        annotation (Placement(transformation(extent={{-90,-38},{-70,-18}})));
      Modelica.Blocks.Interfaces.BooleanInput Off annotation (Placement(
          visible=true,
          transformation(
            origin={70,-110},
            extent={{-12,-12},{12,12}},
            rotation=90),
          iconTransformation(
            origin={78,-104},
            extent={{-12,-12},{12,12}},
            rotation=90)));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-130,-70},{-110,-50}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-8,-40},{12,-20}})));
      Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(visible=
             true, transformation(
            origin={-38,-12},
            extent={{-10,-10},{10,10}},
            rotation=0)));
    equation
      connect(rpm_pump_hot.y, heatPumpSystemBus1.busPumpHot.pumpBus.rpmSet) annotation (
        Line(points={{139,8.88178e-16},{122,8.88178e-16},{122,0},{98,0},{98,
              0.05},{100.05,0.05}},                                                                       color = {0, 0, 127}));
      connect(rpm_pump_cold.y, heatPumpSystemBus1.busPumpCold.pumpBus.rpmSet) annotation (
        Line(points={{139,30},{120,30},{120,0},{98,0},{98,0.05},{100.05,0.05}},     color = {0, 0, 127}));
      connect(T_HotStorage, ctrHP.T_HS) annotation (Line(points={{-80,-108},{-80,-60},
              {-41.8,-60}}, color={0,0,127}));
      connect(T_Condensator, ctrHP.T_con) annotation (Line(points={{-40,-108},{
              -40,-86},{-74,-86},{-74,-66},{-58,-66},{-58,-65},{-41.8,-65}},
                                                color={0,0,127}));
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
      connect(HP_mode.y, heatPumpSystemBus1.busHP.mode) annotation (Line(points=
             {{139,90},{120,90},{120,0.05},{100.05,0.05}}, color={255,0,255}));
      connect(HP_iceFac.y, heatPumpSystemBus1.busHP.iceFac) annotation (Line(
            points={{139,60},{120,60},{120,0.05},{100.05,0.05}}, color={0,0,127}));
      connect(or1.y, heatPumpSystemBus1.AirCoolerOnSet) annotation (Line(points=
             {{139,-30},{120,-30},{120,0},{100.05,0},{100.05,0.05}}, color={255,
              0,255}));
      connect(Combination_I, or13.u2) annotation (Line(points={{104,-56},{82,
              -56},{82,-66}}, color={255,0,255}));
      connect(Combination_II, or13.u1) annotation (Line(points={{106,-88},{82,
              -88},{82,-74}}, color={255,0,255}));
      connect(Heating_I, or11.u2) annotation (Line(points={{106,92},{100,92},{
              100,90},{82,90},{82,78}}, color={255,0,255}));
      connect(Heating_II, or11.u1) annotation (Line(points={{106,54},{82,54},{
              82,70}}, color={255,0,255}));
      connect(or13.y, or2.u1) annotation (Line(points={{59,-74},{58,-74},{58,
              -50},{48,-50}}, color={255,0,255}));
      connect(or11.y, or2.u2) annotation (Line(points={{59,70},{56,70},{56,-42},
              {48,-42}}, color={255,0,255}));
      connect(or2.y, Throttle_HotStorage.u) annotation (Line(points={{25,-50},{
              20,-50},{20,-86},{-100,-86},{-100,90},{-92,90}}, color={255,0,255}));
      connect(Cooling_II, or3.u1) annotation (Line(points={{106,-32},{94,-32},{
              94,-30},{88,-30},{88,34}}, color={255,0,255}));
      connect(Cooling_I, or3.u2) annotation (Line(points={{106,30},{96,30},{96,
              42},{88,42}}, color={255,0,255}));
      connect(or3.y, Throttle_Recool.u) annotation (Line(points={{65,34},{-40,
              34},{-40,100},{-100,100},{-100,60},{-92,60}}, color={255,0,255}));
      connect(Heating_I, Throttle_Freecool.u) annotation (Line(points={{106,92},
              {-40,92},{-40,100},{-100,100},{-100,30},{-92,30}}, color={255,0,
              255}));
      connect(or3.y, or4.u2) annotation (Line(points={{65,34},{54,34},{54,24},{
              42,24},{42,22}}, color={255,0,255}));
      connect(or13.y, or4.u1) annotation (Line(points={{59,-74},{58,-74},{58,
              -72},{56,-72},{56,14},{42,14}}, color={255,0,255}));
      connect(or4.y, or5.u1)
        annotation (Line(points={{19,14},{16,14},{16,48}}, color={255,0,255}));
      connect(Heating_II, or5.u2) annotation (Line(points={{106,54},{90,54},{90,
              52},{16,52},{16,56}}, color={255,0,255}));
      connect(or5.y, Throttle_ColdStorage.u) annotation (Line(points={{-7,48},{
              -40,48},{-40,100},{-100,100},{-100,0},{-92,0}}, color={255,0,255}));
      connect(or3.y, or1.u2) annotation (Line(points={{65,34},{58,34},{58,-46},
              {182,-46},{182,-22},{162,-22}}, color={255,0,255}));
      connect(Heating_I, or1.u1) annotation (Line(points={{106,92},{104,92},{
              104,100},{174,100},{174,-30},{162,-30}}, color={255,0,255}));
      connect(or2.y, ctrHP.heatingModeActive) annotation (Line(points={{25,-50},
              {-58,-50},{-58,-72},{-41.8,-72},{-41.8,-70}}, color={255,0,255}));
      connect(booleanExpression.y, ctrHP.allowOperation) annotation (Line(
            points={{-109,-60},{-100,-60},{-100,-58},{-30,-58}}, color={255,0,
              255}));
      connect(ctrHP.N_rel, switch1.u1) annotation (Line(points={{-19,-70},{-18,
              -70},{-18,-50},{-14,-50},{-14,-22},{-10,-22}}, color={0,0,127}));
      connect(const.y, switch1.u3) annotation (Line(points={{-27,-12},{-20,-12},
              {-20,-38},{-10,-38}}, color={0,0,127}));
      connect(switch1.y, heatPumpSystemBus1.busHP.N) annotation (Line(points={{
              13,-30},{26,-30},{26,-18},{100.05,-18},{100.05,0.05}}, color={0,0,
              127}));
      connect(Off, not1.u) annotation (Line(points={{70,-110},{70,-98},{72,-98},
              {72,-86},{-160,-86},{-160,-28},{-92,-28}}, color={255,0,255}));
      connect(not1.y, switch1.u2) annotation (Line(points={{-69,-28},{-34,-28},
              {-34,-32},{-10,-32},{-10,-30}}, color={255,0,255}));
      connect(not1.y, heatPumpSystemBus1.busHP.onOff) annotation (Line(points={{-69,-28},
              {-60,-28},{-60,-30},{-16,-30},{-16,0.05},{100.05,0.05}},
            color={255,0,255}));
      connect(ctrHP.pumpsOn, heatPumpSystemBus1.busPumpHot.pumpBus.onSet)
        annotation (Line(points={{-19,-62},{100.05,-62},{100.05,0.05}}, color={
              255,0,255}));
      connect(ctrHP.pumpsOn, heatPumpSystemBus1.busPumpCold.pumpBus.onSet)
        annotation (Line(points={{-19,-62},{22,-62},{22,-24},{100.05,-24},{
              100.05,0.05}}, color={255,0,255}));
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
      AixLib.Systems.EONERC_MainBuilding.BaseClasses.TwoCircuitBus hxBus
        annotation (Placement(transformation(extent={{84,-16},{116,16}}),
            iconTransformation(extent={{92,-20},{130,22}})));
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

      AixLib.Systems.ModularAHU.BaseClasses.GenericAHUBus genericAHUBus
        annotation (Placement(transformation(extent={{90,-10},{110,10}}),
            iconTransformation(extent={{84,-14},{116,16}})));
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

      Modelica.Blocks.Interfaces.BooleanInput Heating_I annotation (Placement(
          visible=true,
          transformation(
            origin={104,80},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={104,80},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Heating_II annotation (Placement(
          visible=true,
          transformation(
            origin={106,40},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={104,40},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_I annotation (Placement(
          visible=true,
          transformation(
            origin={106,-40},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={104,-42},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_II annotation (Placement(
          visible=true,
          transformation(
            origin={104,-100},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={106,-100},
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
            origin={64,54})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Blocks.Sources.Constant Const(final k=0)
        annotation (Placement(transformation(extent={{-92,20},{-72,40}})));
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
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{116,-32},{136,-12}})));
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
      connect(constRpmPump_Preheating.y, genericAHUBus.preheaterBus.hydraulicBus.pumpBus.rpmSet)
        annotation (Line(points={{1,80},{20,80},{20,0},{100.05,0},{100.05,0.05}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
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
      connect(constTflowSet1.y, PID_Heating.u_s)
        annotation (Line(points={{-73,-10},{-62,-10}}, color={0,0,127}));
      connect(genericAHUBus.heaterBus.TAirOutMea, PID_Heating.u_m) annotation (Line(
          points={{100.05,0.05},{102,0.05},{102,2},{100,2},{100,100},{-100,100},{-100,
              -32},{-50,-32},{-50,-22}},
          color={255,204,51},
          thickness=0.5));
      connect(switch2.y, genericAHUBus.heaterBus.hydraulicBus.valveSet) annotation (
         Line(points={{1,10},{20,10},{20,0.05},{100.05,0.05}}, color={0,0,127}));
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
      connect(Cooling_II, or3.u1) annotation (Line(points={{104,-100},{80,-100},
              {80,-160},{62,-160}}, color={255,0,255}));
      connect(Cooling_I, or3.u2) annotation (Line(points={{106,-40},{80,-40},{
              80,-152},{62,-152}}, color={255,0,255}));
      connect(Heating_I, or1.u2) annotation (Line(points={{104,80},{76,80},{76,
              62}}, color={255,0,255}));
      connect(Heating_II, or1.u1) annotation (Line(points={{106,40},{94,40},{94,
              38},{76,38},{76,54}}, color={255,0,255}));
      connect(or1.y, switch2.u2) annotation (Line(points={{53,54},{42,54},{42,
              100},{-100,100},{-100,10},{-22,10}}, color={255,0,255}));
      connect(Heating_II, switch1.u2) annotation (Line(points={{106,40},{96,40},
              {96,38},{42,38},{42,100},{-100,100},{-100,50},{-22,50}}, color={
              255,0,255}));
      connect(booleanExpression.y, genericAHUBus.preheaterBus.hydraulicBus.pumpBus.onSet)
        annotation (Line(points={{137,-22},{140,-22},{140,6},{100.05,6},{100.05,
              0.05}}, color={255,0,255}));
      connect(booleanExpression.y, genericAHUBus.heaterBus.hydraulicBus.pumpBus.onSet)
        annotation (Line(points={{137,-22},{144,-22},{144,0.05},{100.05,0.05}},
            color={255,0,255}));
      connect(booleanExpression.y, genericAHUBus.coolerBus.hydraulicBus.pumpBus.onSet)
        annotation (Line(points={{137,-22},{142,-22},{142,-20},{100.05,-20},{
              100.05,0.05}}, color={255,0,255}));
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

    model Controller_SwitchingUnit
      parameter Real rpmPump;
      AixLib.Systems.EONERC_MainBuilding.BaseClasses.SwitchingUnitBus
        switchingUnitBus1 annotation (Placement(
          visible=true,
          transformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput Heating_I annotation (Placement(
          visible=true,
          transformation(
            origin={106,90},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={106,90},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Heating_II annotation (Placement(
          visible=true,
          transformation(
            origin={108,58},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={108,58},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_I annotation (Placement(
          visible=true,
          transformation(
            origin={108,22},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={108,22},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Interfaces.BooleanInput Cooling_II annotation (
        Placement(visible = true, transformation(origin={108,-58},    extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin={108,-58},    extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Combination_I annotation (
          Placement(
          visible=true,
          transformation(
            origin={106,-26},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={106,-26},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Sources.Constant rpm_pump(k = rpmPump) annotation (
        Placement(visible = true, transformation(origin={-50,86},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k=1)   annotation (
        Placement(visible = true, transformation(origin={-80,20},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = 0) annotation (
        Placement(visible = true, transformation(origin={-78,-20},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch K1 annotation (
        Placement(visible = true, transformation(origin={-30,60},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch K2 annotation (
        Placement(visible = true, transformation(origin={-30,30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch K3 annotation (
        Placement(visible = true, transformation(origin={-30,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch K4 annotation (
        Placement(visible = true, transformation(origin={-30,-30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch Y2 annotation (
        Placement(visible = true, transformation(origin={-30,-60},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch Y3 annotation (
        Placement(visible = true, transformation(origin={-30,-90},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Or or1 annotation (
        Placement(visible = true, transformation(origin = {70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Or or11 annotation (
        Placement(visible = true, transformation(origin={68,-30},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanInput Combination_II annotation (
          Placement(
          visible=true,
          transformation(
            origin={108,-90},
            extent={{-12,-12},{12,12}},
            rotation=180),
          iconTransformation(
            origin={108,-86},
            extent={{-12,-12},{12,12}},
            rotation=180)));
      Modelica.Blocks.Logical.Or or2  annotation (
        Placement(visible = true, transformation(origin={38,-50},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    equation
      connect(Y3.y, switchingUnitBus1.Y3valSet) annotation (
        Line(points={{-19,-90},{0,-90},{0,0},{100,0},{100,0.05},{100.05,0.05}},         color = {0, 0, 127}));
      connect(Y2.y, switchingUnitBus1.Y2valSet) annotation (
        Line(points={{-19,-60},{0,-60},{0,0},{100,0},{100,0.05},{100.05,0.05}},         color = {0, 0, 127}));
      connect(K4.y, switchingUnitBus1.K4valSet) annotation (
        Line(points={{-19,-30},{0,-30},{0,0},{100,0},{100,0.05},{100.05,0.05}},         color = {0, 0, 127}));
      connect(K3.y, switchingUnitBus1.K3valSet) annotation (
        Line(points={{-19,0},{100,0},{100,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(K2.y, switchingUnitBus1.K2valSet) annotation (
        Line(points={{-19,30},{0,30},{0,0},{100,0},{100,0.05},{100.05,0.05}},         color = {0, 0, 127}));
      connect(K1.y, switchingUnitBus1.K1valSet) annotation (
        Line(points={{-19,60},{0,60},{0,0},{102,0},{102,0.05},{100.05,0.05}},         color = {0, 0, 127}));
      connect(Y3.u3, const2.y) annotation (
        Line(points={{-42,-98},{-60,-98},{-60,-20},{-67,-20}},                                  color = {0, 0, 127}));
      connect(const2.y, Y2.u3) annotation (
        Line(points={{-67,-20},{-60,-20},{-60,-68},{-42,-68}},                                  color = {0, 0, 127}));
      connect(const2.y, K4.u3) annotation (
        Line(points={{-67,-20},{-60,-20},{-60,-38},{-42,-38}},                                  color = {0, 0, 127}));
      connect(const2.y, K3.u3) annotation (
        Line(points={{-67,-20},{-60,-20},{-60,-8},{-42,-8}},                                color = {0, 0, 127}));
      connect(const2.y, K2.u3) annotation (
        Line(points={{-67,-20},{-60,-20},{-60,22},{-42,22}},                                color = {0, 0, 127}));
      connect(const2.y, K1.u3) annotation (
        Line(points={{-67,-20},{-60,-20},{-60,52},{-42,52}},                                color = {0, 0, 127}));
      connect(const1.y, Y3.u1) annotation (
        Line(points={{-69,20},{-60,20},{-60,-82},{-42,-82}},                                  color = {0, 0, 127}));
      connect(const1.y, Y2.u1) annotation (
        Line(points={{-69,20},{-60,20},{-60,-52},{-42,-52}},                                  color = {0, 0, 127}));
      connect(const1.y, K4.u1) annotation (
        Line(points={{-69,20},{-60,20},{-60,-22},{-42,-22}},                                  color = {0, 0, 127}));
      connect(const1.y, K3.u1) annotation (
        Line(points={{-69,20},{-60,20},{-60,8},{-42,8}},                              color = {0, 0, 127}));
      connect(const1.y, K2.u1) annotation (
        Line(points={{-69,20},{-60,20},{-60,38},{-42,38}},                                color = {0, 0, 127}));
      connect(const1.y, K1.u1) annotation (
        Line(points={{-69,20},{-60,20},{-60,68},{-42,68}},                                           color = {0, 0, 127}));
      connect(rpm_pump.y, switchingUnitBus1.pumpBus.rpmSet) annotation (
        Line(points={{-39,86},{0,86},{0,0.05},{100.05,0.05}},         color = {0, 0, 127}));
      connect(Heating_I, or1.u2) annotation (Line(points={{106,90},{98,90},{98,
              84},{88,84},{88,98},{82,98}}, color={255,0,255}));
      connect(or1.y, K3.u2) annotation (Line(points={{59,90},{24,90},{24,100},{
              -100,100},{-100,0},{-42,0}}, color={255,0,255}));
      connect(or1.y, K4.u2) annotation (Line(points={{59,90},{30,90},{30,100},{
              -100,100},{-100,0},{-60,0},{-60,-30},{-42,-30}}, color={255,0,255}));
      connect(Heating_II, or1.u1) annotation (Line(points={{108,58},{82,58},{82,
              90}}, color={255,0,255}));
      connect(or1.y, switchingUnitBus1.pumpBus.onSet) annotation (Line(points={
              {59,90},{40,90},{40,0},{70,0},{70,0.05},{100.05,0.05}}, color={
              255,0,255}));
      connect(Combination_I, or11.u1) annotation (Line(points={{106,-26},{92,
              -26},{92,-30},{80,-30}}, color={255,0,255}));
      connect(Cooling_I, or11.u2) annotation (Line(points={{108,22},{86,22},{86,
              -22},{80,-22}}, color={255,0,255}));
      connect(or11.y, or2.u2) annotation (Line(points={{57,-30},{56,-30},{56,
              -42},{50,-42}}, color={255,0,255}));
      connect(or2.y, K1.u2) annotation (Line(points={{27,-50},{22,-50},{22,-48},
              {20,-48},{20,100},{-100,100},{-100,0},{-60,0},{-60,60},{-42,60}},
            color={255,0,255}));
      connect(or2.y, Y3.u2) annotation (Line(points={{27,-50},{20,-50},{20,100},
              {-100,100},{-100,0},{-60,0},{-60,-90},{-42,-90}}, color={255,0,
              255}));
      connect(Combination_II, or2.u1) annotation (Line(points={{108,-90},{58,
              -90},{58,-50},{50,-50}}, color={255,0,255}));
      connect(Cooling_II, K2.u2) annotation (Line(points={{108,-58},{80,-58},{
              80,-80},{20,-80},{20,100},{-100,100},{-100,0},{-60,0},{-60,30},{
              -42,30}}, color={255,0,255}));
      connect(Cooling_II, Y2.u2) annotation (Line(points={{108,-58},{80,-58},{
              80,-80},{20,-80},{20,100},{-100,100},{-100,0},{-60,0},{-60,-60},{
              -42,-60}}, color={255,0,255}));
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
      AixLib.Systems.ModularAHU.BaseClasses.GenericAHUBus genericAHUBus1 annotation (
          Placement(
          visible=true,
          transformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
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
        initType=Modelica.Blocks.Types.InitPID.InitialOutput,                                                                                   k = k_Fan, reset = AixLib.Types.Reset.Disabled, strict = true, wd = 0, wp = 1, yMax = 1, yMin = 0, y_start = yStart) annotation (
        Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
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
      connect(booleanExpression.y, genericAHUBus1.heaterBus.hydraulicBus.pumpBus.onSet)
        annotation (Line(points={{91,-20},{100.05,-20},{100.05,0.05}}, color={
              255,0,255}));
      connect(booleanExpression.y, genericAHUBus1.coolerBus.hydraulicBus.pumpBus.onSet)
        annotation (Line(points={{91,-20},{100.05,-20},{100.05,0.05}}, color={
              255,0,255}));
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
      AixLib.Systems.Benchmark.BaseClasses.TabsBus2 tabsBus21 annotation (Placement(
          visible=true,
          transformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0),
          iconTransformation(
            origin={100,0},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.Controls.Continuous.LimPID PID_Hot(Nd = 10, Ni = 0.9, Td = Td_Hot, Ti = Ti_Hot, initType = initType_Hot, k = k_Hot, reverseAction = reverseAction_Hot, strict = true, wd = 0, wp = 1, xd_start = xd_start_Hot, xi_start = xi_start_Hot, yMax = 1, yMin = 0, y_start = y_start_Hot) annotation (
        Placement(visible = true, transformation(origin = {-20, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Controls.Continuous.LimPID PID_Cold(Nd = 10, Ni = 0.9, Td = Td_Cold, Ti = Ti_Cold, initType = initType_Cold, k = k_Cold,
        reverseAction=true,                                                                                                                                               strict = true, wd = 0, wp = 1, xd_start = xd_start_Cold, xi_start = xi_start_Cold, yMax = 1, yMin = 0, y_start = y_start_Cold) annotation (
        Placement(visible = true, transformation(origin = {-20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{78,86},{98,106}})));
      Modelica.Blocks.Logical.GreaterThreshold
                                            pumpSwitchOff(final threshold=0)
        annotation (Placement(transformation(extent={{66,70},{82,86}})));
      Modelica.Blocks.Logical.GreaterThreshold
                                            pumpSwitchOff1(final threshold=0)
        annotation (Placement(transformation(extent={{12,-26},{28,-10}})));
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
        Line(points={{33,18},{46,18},{46,20},{58,20},{58,0.05},{100.05,0.05}},
                                                               color = {0, 0, 127}));
      connect(add2.y, PID_Cold.u_s) annotation (
        Line(points = {{-39, -2}, {-32, -2}}, color = {0, 0, 127}));
      connect(ConstTflowSet2.y, add2.u1) annotation (
        Line(points = {{-79, 30}, {-76, 30}, {-76, 4}, {-62, 4}}, color = {0, 0, 127}));
      connect(const4.y, add2.u2) annotation (
        Line(points = {{-79, 0}, {-72.5, 0}, {-72.5, -8}, {-62, -8}}, color = {0, 0, 127}));
      connect(add1.y, PID_Hot.u_s) annotation (
        Line(points={{-39,90},{-32,90},{-32,90},{-32,90}},          color = {0, 0, 127}));
      connect(PID_Hot.y, switch1.u1) annotation (
        Line(points={{-9,90},{8,90},{8,88},{8,88}},          color = {0, 0, 127}));
      connect(ConstRpmPumpTabs.y, tabsBus21.pumpBus.pumpBus.rpmSet) annotation (
        Line(points={{-79,-30},{40,-30},{40,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(ConstRpmPumpHot.y, tabsBus21.hotThrottleBus.pumpBus.rpmSet) annotation (
        Line(points={{-79,-60},{40,-60},{40,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(ConstRpmPumpCold.y, tabsBus21.coldThrottleBus.pumpBus.rpmSet) annotation (
        Line(points={{-79,-90},{40,-90},{40,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(switch1.y, tabsBus21.hotThrottleBus.valveSet) annotation (
        Line(points={{31,80},{50,80},{50,0.05},{100.05,0.05}}, color = {0, 0, 127}));
      connect(ConstTflowSet1.y, add1.u1) annotation (
        Line(points = {{-79, 90}, {-70, 90}, {-70, 96}, {-62, 96}}, color = {0, 0, 127}));
      connect(const1.y, add1.u2) annotation (
        Line(points = {{-79, 60}, {-70, 60}, {-70, 84}, {-62, 84}}, color = {0, 0, 127}));
      connect(PID_Hot.u_m, tabsBus21.pumpBus.TFwrdOutMea) annotation (Line(
            points={{-20,78},{-20,64},{100.05,64},{100.05,0.05}}, color={0,0,
              127}));
      connect(booleanExpression.y, tabsBus21.pumpBus.pumpBus.onSet) annotation (
         Line(points={{99,96},{138,96},{138,32},{100.05,32},{100.05,0.05}},
            color={255,0,255}));
      connect(pumpSwitchOff.y, tabsBus21.hotThrottleBus.pumpBus.onSet)
        annotation (Line(points={{82.8,78},{92,78},{92,80},{100,80},{100,72},{
              100.05,72},{100.05,0.05}},
                      color={255,0,255}));
      connect(pumpSwitchOff1.y, tabsBus21.coldThrottleBus.pumpBus.onSet)
        annotation (Line(points={{28.8,-18},{100.05,-18},{100.05,0.05}}, color=
              {255,0,255}));
      connect(PID_Cold.u_m, tabsBus21.pumpBus.TFwrdOutMea) annotation (Line(
            points={{-20,-14},{-20,-38},{100.05,-38},{100.05,0.05}}, color={0,0,
              127}));
      connect(switch1.y, pumpSwitchOff.u) annotation (Line(points={{31,80},{44,
              80},{44,78},{64.4,78}}, color={0,0,127}));
      connect(switch2.y, pumpSwitchOff1.u) annotation (Line(points={{33,18},{34,
              18},{34,8},{36,8},{36,-4},{6,-4},{6,-18},{10.4,-18}}, color={0,0,
              127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                              FillPattern.Solid,
                lineThickness =                                                                                                                                                                               0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-34, 10}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-64, 36}, {132, -50}}, textString = "Controller\nConcrete Core\nActivation")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>Controller für die Betonkerntemperierung in den Räumen des Benchmark-Gebäudes</body></html>"));
    end Controller_Tabs;
  end Controller;

  package Bus_Systems
    expandable connector ManagementLevelBus
    "Data bus for Management Level of mode-based control strategy"
      extends Modelica.Icons.SignalBus;
      import SI = Modelica.SIunits;

      annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
    end ManagementLevelBus;

    expandable connector ModeBasedControllerBus
    "Data bus for mode-based control strategy"
      extends Modelica.Icons.SignalBus;
      import SI = Modelica.SIunits;

      annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
    end ModeBasedControllerBus;

    expandable connector AutomationLevelBus
      "Data bus for Automation of mode-based control strategy"
      extends Modelica.Icons.SignalBus;
      import SI = Modelica.SIunits;

      annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
    end AutomationLevelBus;
  end Bus_Systems;

  annotation (Documentation(info="<html>
<p>This package contains all models of the mode-based control strategy developed using the MODI-method</p>
</html>"));
end Mode_based_ControlStrategy;
