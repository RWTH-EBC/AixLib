within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model Ashrae140Testcase900_phe "Model of a ERC-Thermal Zone Including CCA and AHU"
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.Air(extraPropertiesNames={"C_flow"})
    annotation (choicesAllMatching=true);

  BoundaryConditions.WeatherData.Bus        weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{-17,-16},{17,16}}, origin={41,100}),
    iconTransformation(extent={{-82,86},{-62,106}})));
  BaseClasses.ZoneBus Bus
    annotation (Placement(transformation(extent={{-17,-13},{17,13}}, origin={-51,101}), iconTransformation(
          extent={{70,88},{90,108}})));

  Modelica.Blocks.Sources.CombiTimeTable QTabs_set(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfiles",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt"),
    columns={2},
    tableOnFile=false,
    table=[0,0; 86400,0; 86400,5000; 97200,5000; 97200,0; 529200,0; 529200,5000;
        540000,5000; 540000,0; 799200,0; 799200,5000; 810000,5000; 810000,0;
        982800,0; 982800,5000; 993600,5000; 993600,0; 1080000,0; 1080000,0;
        1090800,0; 1090800,0; 1522800,0; 1522800,0; 1533600,0; 1533600,0;
        1792800,0; 1792800,0; 1803600,0; 1803600,0; 1976400,0; 1976400,0;
        1987200,0; 1987200,0; 2073600,0; 2160000,0; 2160000,5000; 2170800,5000;
        2170800,0; 2602800,0; 2602800,5000; 2613600,5000; 2613600,0; 2872800,0;
        2872800,5000; 2883600,5000; 2883600,0; 3056400,0; 3056400,5000; 3067200,
        5000; 3067200,0; 3153600,0; 3153600,5000; 3164400,5000; 3164400,0;
        3596400,0; 3596400,1000; 3607200,1000; 3607200,0; 3866400,0; 3866400,
        1000; 3877200,1000; 3877200,0; 4050000,0; 4050000,2000; 4060800,2000;
        4060800,0; 4147200,0; 4147200,1000; 4158000,1000; 4158000,0; 4590000,0;
        4590000,3000; 4600800,3000; 4600800,0; 4860000,0; 4860000,3000; 4870800,
        3000; 4870800,0; 5043600,0; 5043600,0; 5054400,0; 5054400,0; 5140800,0;
        5140800,0; 5151600,0; 5151600,0; 5583600,0; 5583600,0; 5594400,0;
        5594400,0; 5853600,0; 5853600,0; 5864400,0; 5864400,0; 6037200,0;
        6037200,0; 6048000,0; 6048000,0; 6134400,0; 6134400,0; 6145200,0;
        6145200,0; 6231600,0; 6231600,1000; 6242400,1000; 6242400,0; 6674400,0;
        6674400,2000; 6685200,5000; 6685200,0; 6944400,0; 6944400,2000; 6955200,
        4000; 6955200,0; 7128000,0; 7128000,3000; 7138800,2000; 7138800,0;
        7225200,0; 7225200,3000; 7236000,1000; 7236000,0; 7668000,0; 7668000,
        3000; 7678800,1000; 7678800,0; 7938000,0; 7938000,5000; 7948800,1000;
        7948800,0; 8121600,0],
    offset={0},
    shiftTime=0) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-129,39})));

  Modelica.Blocks.Sources.CombiTimeTable T_set(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfiles",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt"),
    columns={2},
    tableOnFile=false,
    table=[0,291.15; 86400,291.15; 86400,291.15; 97200,291.15; 97200,291.15;
        529200,291.15; 529200,291.15; 540000,291.15; 540000,291.15; 799200,
        291.15; 799200,291.15; 810000,291.15; 810000,291.15; 982800,291.15;
        982800,291.15; 993600,291.15; 993600,291.15; 1080000,291.15; 1080000,
        298.15; 1090800,298.15; 1090800,291.15; 1522800,291.15; 1522800,298.15;
        1533600,298.15; 1533600,291.15; 1792800,291.15; 1792800,298.15; 1803600,
        298.15; 1803600,291.15; 1976400,291.15; 1976400,298.15; 1987200,298.15;
        1987200,291.15; 2073600,291.15; 2160000,291.15; 2160000,298.15; 2170800,
        298.15; 2170800,291.15; 2602800,291.15; 2602800,298.15; 2613600,298.15;
        2613600,291.15; 2872800,291.15; 2872800,298.15; 2883600,298.15; 2883600,
        291.15; 3056400,291.15; 3056400,298.15; 3067200,298.15; 3067200,291.15;
        3153600,291.15; 3153600,298.15; 3164400,298.15; 3164400,291.15; 3596400,
        291.15; 3596400,291.15; 3607200,291.15; 3607200,291.15; 3866400,291.15;
        3866400,291.15; 3877200,291.15; 3877200,291.15; 4050000,291.15; 4050000,
        291.15; 4060800,291.15; 4060800,291.15; 4147200,291.15; 4147200,291.15;
        4158000,291.15; 4158000,291.15; 4590000,291.15; 4590000,291.15; 4600800,
        291.15; 4600800,291.15; 4860000,291.15; 4860000,291.15; 4870800,291.15;
        4870800,291.15; 5043600,291.15; 5043600,293.15; 5054400,293.15; 5054400,
        291.15; 5140800,291.15; 5140800,293.15; 5151600,293.15; 5151600,291.15;
        5583600,291.15; 5583600,297.15; 5594400,297.15; 5594400,291.15; 5853600,
        291.15; 5853600,298.15; 5864400,298.15; 5864400,291.15; 6037200,291.15;
        6037200,294.15; 6048000,294.15; 6048000,291.15; 6134400,291.15; 6134400,
        294.15; 6145200,294.15; 6145200,291.15; 6231600,291.15; 6231600,292.15;
        6242400,292.15; 6242400,291.15; 6674400,291.15; 6674400,293.15; 6685200,
        298.15; 6685200,291.15; 6944400,291.15; 6944400,291.15; 6955200,296.15;
        6955200,291.15; 7128000,291.15; 7128000,293.15; 7138800,296.15; 7138800,
        291.15; 7225200,291.15; 7225200,298.15; 7236000,292.15; 7236000,291.15;
        7668000,291.15; 7668000,298.15; 7678800,292.15; 7678800,291.15; 7938000,
        291.15; 7938000,297.15; 7948800,298.15; 7948800,291.15; 8121600,291.15],
    offset={0},
    shiftTime=0) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-129,3})));

  Modelica.Blocks.Sources.Constant VflowExt(k=3*129/3600)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-132,-32})));
  Modelica.Blocks.Sources.Constant TSupExt(k=45 + 273.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-132,-68})));
  Ashrae140Testcase900_main_phe ashrae140Testcase900_main_phe(redeclare package MediumWater = MediumWater,
      redeclare package MediumAir = MediumAir) annotation (Placement(transformation(
        rotation=0,
        extent={{-59,-77},{59,77}},
        origin={-9,-27})));
equation

  connect(TSupExt.y, ashrae140Testcase900_main_phe.T_sup_in)
    annotation (Line(points={{-121,-68},{-103.4,-68},{-103.4,-67.2769}},              color={0,0,127}));
  connect(QTabs_set.y[1],ashrae140Testcase900_main_phe.QFlowSet)
    annotation (Line(points={{-121.3,39},{-104,39},{-104,38.1538},{-103.4,38.1538}},
                                                                               color={0,0,127}));
  connect(T_set.y[1], ashrae140Testcase900_main_phe.T_sup_ahu_set)
    annotation (Line(points={{-121.3,3},{-102,3},{-102,2.61538},{-103.4,2.61538}},
                                                                                 color={0,0,127}));
  connect(VflowExt.y,ashrae140Testcase900_main_phe.VflowSet)
    annotation (Line(points={{-121,-32},{-103.4,-32},{-103.4,-32.9231}},
                                                                       color={0,0,127}));
  connect(Bus, ashrae140Testcase900_main_phe.Bus)
    annotation (Line(points={{-51,101},{-51,56},{7.52,56},{7.52,50}}));
  connect(weaBus, ashrae140Testcase900_main_phe.weaBus)
    annotation (Line(points={{41,100},{42,100},{42,80},{-26.7,80},{-26.7,50}}));
  annotation (experiment(
      StopTime=31536000,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}})));
end Ashrae140Testcase900_phe;
