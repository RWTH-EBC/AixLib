within AixLib.Fluid.Examples.ERCBuilding.Control;
model MainControlTest

  Control.SupervisoryControl.MainControllerLTC mainControllerLTC
    annotation (Placement(transformation(extent={{-30,-6},{66,92}})));
    Modelica.Blocks.Sources.CombiTimeTable temperatures_cold(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="temperatures_cold",
    columns={2,3,4,5},
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/temperatures_cold.mat")
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
    Modelica.Blocks.Sources.CombiTimeTable temperatures_warm(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="temperatures_warm",
    columns={2,3,4,5},
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/temperatures_warm.mat")
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-28})));
    Modelica.Blocks.Sources.CombiTimeTable GTFTempReturn(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="GTFTempReturn",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/GTFTempReturn.mat")
                                                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,90})));
    Modelica.Blocks.Sources.CombiTimeTable GTFTempFlow(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="GTFTempFlow",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/GTFTempFlow.mat")
                                                                 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,60})));
    Modelica.Blocks.Sources.CombiTimeTable outdoorTemperature(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="outdoorTemperature",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/outdoorTemperature.mat")
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,32})));
    Modelica.Blocks.Sources.CombiTimeTable evapTemp(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="evapTemp",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/evapTemp.mat")
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-58})));
    Modelica.Blocks.Sources.CombiTimeTable co2room6(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="LTCflowTemp",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/LTCflowTemp.mat")
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-86})));
    Modelica.Blocks.Sources.CombiTimeTable openingHK11Y2(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,600; 31536000,600],
    tableOnFile=true,
    columns={2,3,4,5},
    tableName="openingHK11Y2",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/openingHK11Y2.mat")
                                                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,0})));
    Modelica.Blocks.Sources.CombiTimeTable openingHK13Y1(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,600; 31536000,600],
    tableOnFile=true,
    columns={2,3,4,5},
    tableName="openingHK13Y1",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/openingHK13Y1.mat")
                                                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,-28})));
    Modelica.Blocks.Sources.CombiTimeTable openingHK12Y1(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="openingHK12Y1",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/openingHK12Y1.mat")
                               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,90})));
    Modelica.Blocks.Sources.CombiTimeTable openingHK12Y2(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="openingHK12Y2",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/openingHK12Y2.mat")
                                                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,60})));
    Modelica.Blocks.Sources.CombiTimeTable openingHK11Y1(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="openingHK11Y1",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/openingHK11Y1.mat")
                                                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,32})));
    Modelica.Blocks.Sources.CombiTimeTable openingHK13Y2(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="openingHK13Y2",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/openingHK13Y2.mat")
                                                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,-58})));
    Modelica.Blocks.Sources.CombiTimeTable openingHK13Y3(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="openingHK13Y3",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/openingHK13Y3.mat")
                               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,-86})));
    Modelica.Blocks.Sources.CombiTimeTable openingHK13K3(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,600; 31536000,600],
    tableOnFile=true,
    columns={2,3,4,5},
    tableName="openingHK13K3",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataMainControl/openingHK13K3.mat")
                                                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={154,58})));
    Modelica.Blocks.Sources.CombiTimeTable HPCommand(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,600; 31536000,600],
    tableOnFile=true,
    columns={2,3,4,5},
    tableName="HPCommand",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/HPCommand.mat")
                                                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={154,30})));
    Modelica.Blocks.Sources.CombiTimeTable CoolingMode(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="CoolingMode",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/CoolingMode.mat")
                                                                 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={158,-54})));
    Modelica.Blocks.Sources.CombiTimeTable HECommand(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="HECommand",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/HECommand.mat")
                                                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={158,-82})));
    Modelica.Blocks.Sources.CombiTimeTable measuring(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="measuring",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/measuring.mat")
                                                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={152,88})));
    Modelica.Blocks.Sources.CombiTimeTable HeatingMode(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="HeatingMode",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/HeatingMode.mat")
                                                                 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={158,-26})));
    Modelica.Blocks.Sources.CombiTimeTable HPMode(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,600; 31536000,600],
    tableOnFile=true,
    tableName="HPMode",
    fileName="T:/fst/Modelica/Dymola/InputDataMainControl/HPMode.mat")
                                                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={156,2})));

             //Outputs
  output Boolean Start=mainControllerLTC.stateMachine.active_state[1];
  output Boolean coolingMode1=mainControllerLTC.stateMachine.active_state[2];
  output Boolean coolingMode2_1=mainControllerLTC.stateMachine.active_state[3];
  output Boolean coolingMode2_2=mainControllerLTC.stateMachine.active_state[4];
  output Boolean coolingMode3_1=mainControllerLTC.stateMachine.active_state[5];
  output Boolean heatingMode1=mainControllerLTC.stateMachine.active_state[6];
  output Boolean hPCommand=mainControllerLTC.HPCommand;
  output Boolean globalHeatingMode=hold(mainControllerLTC.stateMachine.heatingMode);

equation
  connect(co2room6.y[1], mainControllerLTC.LTCFlowTemp) annotation (Line(points={{-79,-86},
          {-26,-86},{-26,-5.34667},{-24.1333,-5.34667}},           color={0,0,
          127}));
  connect(temperatures_warm.y, mainControllerLTC.temperatures_warm) annotation (
     Line(points={{-79,-28},{-79,-28},{-46,-28},{-46,22},{-30,22},{-30,
          21.7667},{-31.3333,21.7667}},                                 color={
          0,0,127}));
  connect(evapTemp.y[1], mainControllerLTC.evapTemp) annotation (Line(points={{-79,-58},
          {-38,-58},{-38,7.39333},{-30.8,7.39333}},          color={0,0,127}));
  connect(temperatures_cold.y, mainControllerLTC.temperatures_cold)
    annotation (Line(points={{-79,0},{-50,0},{-50,44.3067},{-30.5333,
          44.3067}}, color={0,0,127}));
  connect(GTFTempReturn.y[1], mainControllerLTC.GTFTempReturn) annotation (
      Line(points={{-79,90},{-54,90},{-54,86.7733},{-30,86.7733}}, color={0,
          0,127}));
  connect(GTFTempFlow.y[1], mainControllerLTC.GTFTempFlow) annotation (Line(
        points={{-79,60},{-54,60},{-54,71.7467},{-30,71.7467}}, color={0,0,
          127}));
  connect(outdoorTemperature.y[1], mainControllerLTC.outdoorTemperature)
    annotation (Line(points={{-79,32},{-54.5,32},{-54.5,53.1267},{-29.7333,
          53.1267}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end MainControlTest;
