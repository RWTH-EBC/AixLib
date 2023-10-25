within AixLib.Systems.EONERC_Testhall.BaseClasses.AHU;
package Calibration
  model AHUData
    AixLib.Systems.ModularAHU.BaseClasses.GenericAHUBus
                              genericAHUBus "Bus connector for genericAHU"
      annotation (Placement(transformation(extent={{90,-12},{110,8}}),
          iconTransformation(extent={{84,-14},{116,16}})));
    AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBuscooler
      annotation (Placement(transformation(extent={{-20,-14},{4,12}}),
          iconTransformation(extent={{0,0},{0,0}})));
    AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBusPreheater
      annotation (Placement(transformation(extent={{24,-104},{52,-74}}),
          iconTransformation(extent={{0,0},{0,0}})));
    AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBusHeater
      annotation (Placement(transformation(extent={{20,-66},{48,-36}}),
          iconTransformation(extent={{0,0},{0,0}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTablePH(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Testhall/DataBase/Calibration/Preheater.txt"),
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      columns=3:13) "6-PumpSpeed, 9-PumpVolFlow, 10-ValveSet"
      annotation (Placement(transformation(extent={{-48,-86},{-28,-66}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTableH(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Testhall/DataBase/Calibration/Heater.txt"),
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      columns=3:13) "1-PumpSpeed, 9-PumpVolFlow, 10-ValveSet"
      annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
      annotation (Placement(transformation(extent={{54,4},{74,24}})));
    Modelica.Blocks.Sources.Constant ConstHRS(final k=0)
      "Heat recovery is deactivated"
      annotation (Placement(transformation(extent={{-78,72},{-66,84}})));
    Modelica.Blocks.Sources.Constant ConstFlap(final k=1) "Flaps are always open"
      annotation (Placement(transformation(extent={{-98,84},{-86,96}})));
    Modelica.Blocks.Sources.Constant ConstHum(final k=0) "Humidifiers are off"
      annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={-52,68})));
    Modelica.Blocks.Sources.Constant dpFanEta(final k=772) annotation (
        Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={-34,56})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTableC(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Testhall/DataBase/Calibration/Cooler.txt"),
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      columns=3:13)
                   "1-PumpSpeed, 2-PumpVolFlow, 4-ValveSet"
      annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
    Modelica.Blocks.Sources.Constant dpFanSup(final k=1093) annotation (
        Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={-16,44})));
  equation
    connect(registerBusPreheater, genericAHUBus.preheaterBus) annotation (Line(
        points={{38,-89},{38,-88.5},{100.05,-88.5},{100.05,-1.95}},
        color={255,204,51},
        thickness=0.5));
    connect(registerBuscooler, genericAHUBus.coolerBus) annotation (Line(
        points={{-8,-1},{100,-1},{100,-2},{100.05,-2},{100.05,-1.95}},
        color={255,204,51},
        thickness=0.5));
    connect(registerBusHeater, genericAHUBus.heaterBus) annotation (Line(
        points={{34,-51},{101,-51},{101,-1.95},{100.05,-1.95}},
        color={255,204,51},
        thickness=0.5));
    connect(combiTimeTablePH.y[6], registerBusPreheater.hydraulicBus.pumpBus.rpmSet)
      annotation (Line(points={{-27,-76},{-2,-76},{-2,-88.925},{38.07,-88.925}},
          color={0,0,127}));
    connect(combiTimeTablePH.y[10], registerBusPreheater.hydraulicBus.valveSet)
      annotation (Line(points={{-27,-76},{-2,-76},{-2,-88.925},{38.07,-88.925}},
          color={0,0,127}));
    connect(combiTimeTableH.y[1], registerBusHeater.hydraulicBus.pumpBus.rpmSet)
      annotation (Line(points={{-29,-40},{12,-40},{12,-50.925},{34.07,-50.925}},
          color={0,0,127}));
    connect(combiTimeTableH.y[10], registerBusHeater.hydraulicBus.valveSet)
      annotation (Line(points={{-29,-40},{12,-40},{12,-50.925},{34.07,-50.925}},
          color={0,0,127}));
    connect(booleanExpression.y, genericAHUBus.preheaterBus.hydraulicBus.pumpBus.onSet)
      annotation (Line(points={{75,14},{88,14},{88,-1.95},{100.05,-1.95}},
          color={255,0,255}));
    connect(booleanExpression.y, genericAHUBus.coolerBus.hydraulicBus.pumpBus.onSet)
      annotation (Line(points={{75,14},{88,14},{88,-1.95},{100.05,-1.95}},
          color={255,0,255}));
    connect(booleanExpression.y, genericAHUBus.heaterBus.hydraulicBus.pumpBus.onSet)
      annotation (Line(points={{75,14},{88,14},{88,-1.95},{100.05,-1.95}},
          color={255,0,255}));
    connect(ConstHRS.y, genericAHUBus.bypassHrsSet) annotation (Line(points={{-65.4,
            78},{100.05,78},{100.05,-1.95}},  color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ConstFlap.y, genericAHUBus.flapSupSet) annotation (Line(points={{-85.4,
            90},{100,90},{100,40},{100.05,40},{100.05,-1.95}},
                                              color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ConstHum.y, genericAHUBus.adiabHumSet) annotation (Line(points={{
            -45.4,68},{100,68},{100,-1.95},{100.05,-1.95}}, color={0,0,127}));
    connect(combiTimeTableC.y[1], registerBuscooler.hydraulicBus.pumpBus.rpmSet)
      annotation (Line(points={{-41,0},{-7.94,0},{-7.94,-0.935}}, color={0,0,
            127}));
    connect(combiTimeTableC.y[4], registerBuscooler.hydraulicBus.valveSet)
      annotation (Line(points={{-41,0},{-6,0},{-6,-0.935},{-7.94,-0.935}},
          color={0,0,127}));
    connect(dpFanSup.y, genericAHUBus.dpFanSupSet) annotation (Line(points={{
            -9.4,44},{100,44},{100,-1.95},{100.05,-1.95}}, color={0,0,127}));
    connect(dpFanEta.y, genericAHUBus.dpFanEtaSet) annotation (Line(points={{
            -27.4,56},{100.05,56},{100.05,-1.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ConstFlap.y, genericAHUBus.flapEtaSet) annotation (Line(points={{
            -85.4,90},{100.05,90},{100.05,-1.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5), Text(
            extent={{-70,70},{72,-62}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid,
            textString="AHUData")}),                               Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AHUData;

  model Preheater_calib

      replaceable package MediumWater =
        AixLib.Media.Water
      "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
    replaceable package MediumAir =
        AixLib.Media.Air
      "Medium in the system" annotation(choicesAllMatching=true);

    Modelica.Units.SI.VolumeFlowRate VolFlowBypassMea = registerBus.hydraulicBus.VFlowOutMea
         - registerBus.hydraulicBus.VFlowInMea;
    Modelica.Units.NonSI.Temperature_degC T_SupPrim=registerBus.hydraulicBus.TFwrdInMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_Sup=registerBus.hydraulicBus.TFwrdOutMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_RetPrim=registerBus.hydraulicBus.TRtrnOutMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_Ret=registerBus.hydraulicBus.TRtrnInMea
         - 273.15;

    parameter Real fac1=6.337455894 "fac for pipe1" annotation(Evaluate=false);
    parameter Real fac2=3.292424832 "fac for pipe2" annotation(Evaluate=false);
    parameter Real fac3=10 "fac for pipe3" annotation(Evaluate=false);
    parameter Real fac4=10 "fac for pipe4" annotation(Evaluate=false);
    parameter Real fac5=7.97490022 "fac for pipe5" annotation(Evaluate=false);
    parameter Real fac6=10  "fac for pipe6" annotation(Evaluate=false);
    parameter Real dp2_HX=38219.1014 "Data sheet: 20e3" annotation(Evaluate=false);
    parameter Real Kv=6.5 "Kv for Valve" annotation(Evaluate=false);
    parameter Real Gc1=120 "Gc1 for hx" annotation(Evaluate=false);
    parameter Real Gc2=120 "Gc2 for hx" annotation(Evaluate=false);
    parameter Real tau1=2 "tau1 for hx (cant be evaluate=false)" annotation(Evaluate=true);
    parameter Real tau2=8 "tau2 for hx (cant be evaluate=false)" annotation(Evaluate=true);
    parameter Real tau_C=10 "tau_C for hx" annotation(Evaluate=false);
    parameter Real lambda=0.04 "lambda for pipe insulation" annotation(Evaluate=false);
    parameter Real c=1500 "c for pipie insulation" annotation(Evaluate=false);
    AixLib.Fluid.Sources.Boundary_pT SupPrim(
      redeclare package Medium = MediumWater,
      p=113000,
      use_T_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-66,-68},{-46,-48}})));
    AixLib.Fluid.Sources.Boundary_ph RetPrim(
      redeclare package Medium = MediumWater,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{84,-40},{64,-20}})));
    AixLib.Fluid.Sources.MassFlowSource_T
                                     Air1(
      redeclare package Medium = MediumAir,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-84,46},{-64,66}})));
    AixLib.Fluid.Sources.Boundary_pT Air2(
      redeclare package Medium = MediumAir,
      p=80000,
      nPorts=1) annotation (Placement(transformation(extent={{82,52},{62,72}})));
    AixLib.Systems.ModularAHU.RegisterModule preheater(
      redeclare package Medium1 = MediumAir,
      redeclare package Medium2 = MediumWater,
      hydraulicModuleIcon="Admix",
      final m1_flow_nominal=3.7,
      m2_flow_nominal=2.7,
      T_amb=295.15,
      redeclare replaceable AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        parameterIso=AixLib.DataBase.Pipes.Insulation.Iso50pc(lambda=lambda, c=c),
        Kv=Kv,
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        pipe1(length=1.2, fac=fac1),
        pipe2(length=0.2, fac=fac2),
        pipe3(length=2.3, fac=fac3),
        pipe4(length=2.1, fac=fac4),
        pipe5(length=1.3, fac=fac5),
        pipe6(length=0.3, fac=fac6),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per))),
      dynamicHX(
        dp1_nominal=11,
        dp2_nominal=dp2_HX "nach Datenblatt dp2=20e3",
        tau1=tau1,
        tau2=tau2,
        tau_C=tau_C,
        dT_nom=25,
        Gc1=Gc1,
        Gc2=Gc2))              annotation (Dialog(enable=true),
        Placement(transformation(extent={{-24,-6},{20,54}})));

    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
      annotation (Placement(transformation(extent={{-62,76},{-42,96}})));
    AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus
      annotation (Placement(transformation(extent={{-70,6},{-32,44}}),
          iconTransformation(extent={{-112,-14},{-86,12}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Testhall/DataBase/Calibration/Preheater.txt"),
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      columns=2:12)
      "1-TempOut, 2-TempRet, 3-TempRetPrim, 4-TempSup, 5-TempSupPrim, 6-PumpSpeed,7-VolFlow, 8-ValveSet, 9-VolFlowAir, 10-TempAirOut, 11-VolFlowIn"
      annotation (Placement(transformation(extent={{-136,-6},{-116,14}})));


  equation
    connect(Air1.ports[1], preheater.port_a1) annotation (Line(points={{-64,56},
            {-44,56},{-44,40.1538},{-24,40.1538}},
                                              color={0,127,255}));
    connect(preheater.port_b1, Air2.ports[1]) annotation (Line(points={{20,
            40.1538},{41,40.1538},{41,62},{62,62}},
                                           color={0,127,255}));
    connect(SupPrim.ports[1], preheater.port_a2) annotation (Line(points={{-46,-58},
            {-24,-58},{-24,12.4615}},               color={0,127,255}));
    connect(RetPrim.ports[1], preheater.port_b2) annotation (Line(points={{64,-30},
            {41,-30},{41,12.4615},{20,12.4615}}, color={0,127,255}));
    connect(booleanExpression.y, registerBus.hydraulicBus.pumpBus.onSet)
      annotation (Line(points={{-41,86},{-36,86},{-36,52},{-50.905,52},{-50.905,
            25.095}},
          color={255,0,255}));
    connect(registerBus, preheater.registerBus) annotation (Line(
        points={{-51,25},{-37.5,25},{-37.5,26.0769},{-23.78,26.0769}},
        color={255,204,51},
        thickness=0.5));
    connect(combiTimeTable.y[6], registerBus.hydraulicBus.pumpBus.rpmSet)
      annotation (Line(points={{-115,4},{-102,4},{-102,25.095},{-50.905,25.095}},
                              color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(combiTimeTable.y[8], registerBus.hydraulicBus.valveSet) annotation (
        Line(points={{-115,4},{-52,4},{-52,25.095},{-50.905,25.095}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(combiTimeTable.y[9], Air1.m_flow_in) annotation (Line(points={{-115,
            4},{-102,4},{-102,24},{-90,24},{-90,54},{-92,54},{-92,64},{-86,64}},
          color={0,0,127}));
    connect(combiTimeTable.y[5], SupPrim.T_in) annotation (Line(points={{-115,4},
            {-74,4},{-74,-54},{-68,-54}}, color={0,0,127}));
    connect(combiTimeTable.y[10], Air1.T_in) annotation (Line(points={{-115,4},
            {-102,4},{-102,24},{-90,24},{-90,54},{-92,54},{-92,60},{-86,60}},
          color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=1268100, __Dymola_Algorithm="Dassl"));
  end Preheater_calib;

  model Cooler_calib

    replaceable package MediumWater =
        AixLib.Media.Water
      "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
    replaceable package MediumAir =
        AixLib.Media.Air
      "Medium in the system" annotation(choicesAllMatching=true);
    Modelica.Units.SI.VolumeFlowRate VolFlowBypass=registerBus.hydraulicBus.VFlowOutMea
         - registerBus.hydraulicBus.VFlowInMea;
    Modelica.Units.NonSI.Temperature_degC T_SupPrim=registerBus.hydraulicBus.TFwrdInMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_Sup=registerBus.hydraulicBus.TFwrdOutMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_RetPrim=registerBus.hydraulicBus.TRtrnOutMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_Ret=registerBus.hydraulicBus.TRtrnInMea
         - 273.15;

    Real VolFlowOutErr = (combiTimeTable.y[7]-registerBus.hydraulicBus.VFlowOutMea)/ registerBus.hydraulicBus.VFlowOutMea;
    Real VolFlowInErr = (combiTimeTable.y[11]-registerBus.hydraulicBus.VFlowInMea)/ registerBus.hydraulicBus.VFlowInMea;

    parameter Real fac1=12.5311968436065 "fac for pipe1" annotation(Evaluate=false);
    parameter Real fac2=1 "fac for pipe2" annotation(Evaluate=false);
    parameter Real fac3=1 "fac for pipe3" annotation(Evaluate=false);
    parameter Real fac4=1 "fac for pipe4" annotation(Evaluate=false);
    parameter Real fac5=1 "fac for pipe5" annotation(Evaluate=false);
    parameter Real fac6=50 "fac for pipe6" annotation(Evaluate=false);
    parameter Real dp2_HX=24000 "Data sheet: 48.4e3" annotation(Evaluate=false);
    parameter Real Kv=23.4057486630996 "Data sheet: 24" annotation(Evaluate=false);
    parameter Real p_SupPrim=116539.589954254 "pressure on distributor" annotation(Evaluate=false);
    parameter Real Gc1=1000 "Gc1 for hx" annotation(Evaluate=false);
    parameter Real Gc2=1000 "Gc2 for hx" annotation(Evaluate=false);
    parameter Real tau1=2 "tau1 for hx (cant be evaluate=false)" annotation(Evaluate=true);
    parameter Real tau2=8 "tau2 for hx (cant be evaluate=false)" annotation(Evaluate=true);
    parameter Real tau_C=22.351925301134887 "tau_C for hx" annotation(Evaluate=false);
    parameter Real lambda=9.598392785253736 "lambda for pipe insulation" annotation(Evaluate=false);
    parameter Real c=7087.577868182919 "c for pipie insulation" annotation(Evaluate=false);

    AixLib.Fluid.Sources.Boundary_pT SupPrim(
      redeclare package Medium = MediumWater,
      p=p_SupPrim,
      use_T_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));
    AixLib.Fluid.Sources.Boundary_ph RetPrim(
      redeclare package Medium = MediumWater,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{88,-36},{68,-16}})));
    AixLib.Fluid.Sources.Boundary_pT Air2(
      redeclare package Medium = MediumAir,
      p=80000,
      nPorts=1) annotation (Placement(transformation(extent={{82,52},{62,72}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
      annotation (Placement(transformation(extent={{-20,92},{-40,112}})));
    AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus
      annotation (Placement(transformation(extent={{-82,-2},{-44,36}}),
          iconTransformation(extent={{-112,-14},{-86,12}})));
    AixLib.Systems.ModularAHU.RegisterModule cooler(
      redeclare package Medium1 = MediumAir,
      redeclare package Medium2 = MediumWater,
      m1_flow_nominal=3.7,
      m2_flow_nominal=2.3,
      T_amb=295.15,
      hydraulicModuleIcon="Admix",
      redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        parameterIso=AixLib.DataBase.Pipes.Insulation.Iso50pc(lambda=lambda, c=
            c),
        Kv=Kv,
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        pipe1(length=0.5, fac=fac1),
        pipe2(length=0.3, fac=fac2),
        pipe3(length=5.5, fac=fac3),
        pipe4(length=6.5, fac=fac4),
        pipe5(length=1.5, fac=fac5),
        pipe6(length=0.3, fac=fac6),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=Testhall.Subsystems.AHU.Pump_Test.pump_cooler())),
      dynamicHX(
        dp1_nominal=125,
        dp2_nominal=dp2_HX,
        tau1=tau1,
        tau2=tau2,
        tau_C=tau_C,
        Gc1=Gc1,
        Gc2=Gc2))
      annotation (Placement(transformation(extent={{-26,-14},{22,44}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Testhall/DataBase/Calibration/Cooler.txt"),
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      columns=2:12)  "1-TempOut, 2-TempRet, 3-TempRetPrim, 4-TempSup, 5-TempSupPrim, 6-PumpSpeed,7-VolFlow, 8-ValveSet, 9-VolFlowAir, 10-TempAirOut, 11-VolFlowIn"
      annotation (Placement(transformation(extent={{-170,-4},{-150,16}})));

    AixLib.Fluid.Sources.MassFlowSource_T
                                     Air3(
      redeclare package Medium = MediumAir,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-118,54},{-98,74}})));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-68,82})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
      annotation (Placement(transformation(extent={{-114,94},{-94,114}})));
    Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=350)
      annotation (Placement(transformation(extent={{-138,114},{-126,126}})));
  equation
    connect(cooler.port_b1, Air2.ports[1]) annotation (Line(points={{22,30.6154},
            {43,30.6154},{43,62},{62,62}},color={0,127,255}));
    connect(cooler.port_b2, RetPrim.ports[1]) annotation (Line(points={{22,3.84615},
            {44,3.84615},{44,-26},{68,-26}}, color={0,127,255}));
    connect(SupPrim.ports[1],cooler. port_a2) annotation (Line(points={{-40,-56},{
            -34,-56},{-34,3.84615},{-26,3.84615}}, color={0,127,255}));
    connect(registerBus,cooler. registerBus) annotation (Line(
        points={{-63,17},{-45.5,17},{-45.5,17.0077},{-25.76,17.0077}},
        color={255,204,51},
        thickness=0.5));
    connect(combiTimeTable.y[6], registerBus.hydraulicBus.pumpBus.rpmSet)
      annotation (Line(points={{-149,6},{-62.905,6},{-62.905,17.095}},
                              color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(combiTimeTable.y[8], registerBus.hydraulicBus.valveSet) annotation (
        Line(points={{-149,6},{-62.905,6},{-62.905,17.095}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(combiTimeTable.y[5], SupPrim.T_in) annotation (Line(points={{-149,6},{
            -86,6},{-86,-52},{-62,-52}},  color={0,0,127}));
    connect(Air3.ports[1], cooler.port_a1) annotation (Line(points={{-98,64},{
            -32,64},{-32,30.6154},{-26,30.6154}},
                                              color={0,127,255}));
    connect(combiTimeTable.y[9], Air3.m_flow_in) annotation (Line(points={{-149,6},
            {-138,6},{-138,72},{-120,72}}, color={0,0,127}));
    connect(combiTimeTable.y[10], Air3.T_in) annotation (Line(points={{-149,6},{-130,
            6},{-130,68},{-120,68}}, color={0,0,127}));
    connect(booleanExpression1.y, logicalSwitch.u3) annotation (Line(points={{-93,
            104},{-76,104},{-76,94}}, color={255,0,255}));
    connect(booleanExpression.y, logicalSwitch.u1) annotation (Line(points={{-41,102},
            {-60,102},{-60,94}}, color={255,0,255}));
    connect(logicalSwitch.y, registerBus.hydraulicBus.pumpBus.onSet) annotation (
        Line(points={{-68,71},{-68,40},{-62.905,40},{-62.905,17.095}}, color={255,
            0,255}));
    connect(combiTimeTable.y[6], lessEqualThreshold.u) annotation (Line(points={{-149,
            6},{-146,6},{-146,120},{-139.2,120}}, color={0,0,127}));
    connect(lessEqualThreshold.y, logicalSwitch.u2) annotation (Line(points={{-125.4,
            120},{-68,120},{-68,94}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=1255800, __Dymola_Algorithm="Dassl"));
  end Cooler_calib;

  model Heater_calib

    replaceable package MediumWater =
        AixLib.Media.Water
      "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
    replaceable package MediumAir =
        AixLib.Media.Air
      "Medium in the system" annotation(choicesAllMatching=true);

    Modelica.Units.SI.VolumeFlowRate VolFlowBypass=registerBus.hydraulicBus.VFlowOutMea
         - registerBus.hydraulicBus.VFlowInMea;
    Modelica.Units.SI.VolumeFlowRate VolFlowBypassMea=combiTimeTable.y[7]-combiTimeTable.y[11];
    Modelica.Units.NonSI.Temperature_degC T_SupPrim=registerBus.hydraulicBus.TFwrdInMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_Sup=registerBus.hydraulicBus.TFwrdOutMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_RetPrim=registerBus.hydraulicBus.TRtrnOutMea
         - 273.15;
    Modelica.Units.NonSI.Temperature_degC T_Ret=registerBus.hydraulicBus.TRtrnInMea
         - 273.15;

    Real VolFlowOutErr = (combiTimeTable.y[7]-registerBus.hydraulicBus.VFlowOutMea)/ registerBus.hydraulicBus.VFlowOutMea;
    Real VolFlowInErr = (combiTimeTable.y[11]-registerBus.hydraulicBus.VFlowInMea)/ registerBus.hydraulicBus.VFlowInMea;

    parameter Real fac1=1 "fac for pipe1" annotation(Evaluate=false);
    parameter Real fac2=1 "fac for pipe2" annotation(Evaluate=false);
    parameter Real fac3=1 "fac for pipe3" annotation(Evaluate=false);
    parameter Real fac4=1 "fac for pipe4" annotation(Evaluate=false);
    parameter Real fac5=1 "fac for pipe5" annotation(Evaluate=false);
    parameter Real fac6=1.209245 "fac for pipe6" annotation(Evaluate=false);
    parameter Real dp2_HX=6900 "Data sheet:13.7e3" annotation(Evaluate=false);
    parameter Real Kv=10.286394 "Data sheet: 10" annotation(Evaluate=false);
    parameter Real Gc1=120 "Gc1 for hx" annotation(Evaluate=false);
    parameter Real Gc2=120 "Gc2 for hx" annotation(Evaluate=false);
    parameter Real tau1=2 "tau1 for hx (cant be evaluate=false)" annotation(Evaluate=true);
    parameter Real tau2=8 "tau2 for hx (cant be evaluate=false)" annotation(Evaluate=true);
    parameter Real tau_C=10 "tau_C for hx" annotation(Evaluate=false);
    parameter Real lambda=0.04 "lambda for pipe insulation" annotation(Evaluate=false);
    parameter Real c=1500 "c for pipie insulation" annotation(Evaluate=false);

    AixLib.Fluid.Sources.Boundary_pT SupPrim(
      redeclare package Medium = MediumWater,
      p=107253.191056,
      use_T_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-92,-46},{-72,-26}})));
    AixLib.Fluid.Sources.Boundary_pT RetPrim(
      redeclare package Medium = MediumWater,
      p=100000,
      use_T_in=false,
      nPorts=1)
      annotation (Placement(transformation(extent={{88,-36},{68,-16}})));
    AixLib.Fluid.Sources.Boundary_pT Air2(
      redeclare package Medium = MediumAir,
      p=80000,
      nPorts=1) annotation (Placement(transformation(extent={{82,52},{62,72}})));
    AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus
      annotation (Placement(transformation(extent={{-82,-2},{-44,36}}),
          iconTransformation(extent={{-112,-14},{-86,12}})));
    AixLib.Systems.ModularAHU.RegisterModule heater(
      redeclare package Medium1 = MediumAir,
      redeclare package Medium2 = MediumWater,
      hydraulicModuleIcon="Admix",
      m1_flow_nominal=3.7,
      m2_flow_nominal=2.3,
      T_amb=288.15,
      redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_18x1(),
        parameterIso=AixLib.DataBase.Pipes.Insulation.Iso50pc(),
        Kv=Kv "Data Sheet: Kv=10",
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        pipe1(length=15, fac=fac1),
        pipe2(length=0.6, fac=fac2),
        pipe3(length=2, fac=fac3),
        pipe4(length=5.5, fac=fac4),
        pipe5(length=15.4, fac=fac5),
        pipe6(length=0.6, fac=fac6),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=Testhall.Subsystems.AHU.Pump_Test.pump_heater())),
      dynamicHX(
        dp1_nominal=23,
        dp2_nominal=dp2_HX,
        dT_nom=2))
      annotation (Placement(transformation(extent={{-24,-6},{20,54}})));

    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Testhall/DataBase/Calibration/Heater.txt"),
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      columns=2:12)
      "1-TempOut, 2-TempRet, 3-TempRetPrim, 4-TempSup, 5-TempSupPrim, 6-PumpSpeed,7-VolFlow, 8-ValveSet, 9-VolFlowAir, 10-TempAirOut, 11-VolFlowIn"
      annotation (Placement(transformation(extent={{-166,-4},{-146,16}})));


    AixLib.Fluid.Sources.MassFlowSource_T
                                     Air1(
      redeclare package Medium = MediumAir,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-90,48},{-70,68}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=false)
      annotation (Placement(transformation(extent={{-8,92},{-28,112}})));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-56,82})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=true)
      annotation (Placement(transformation(extent={{-102,94},{-82,114}})));
    Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=0)
      annotation (Placement(transformation(extent={{-126,114},{-114,126}})));
  equation

    connect(heater.port_b1, Air2.ports[1]) annotation (Line(points={{20,40.1538},
            {43,40.1538},{43,62},{62,62}},color={0,127,255}));
    connect(heater.port_b2, RetPrim.ports[1]) annotation (Line(points={{20,
            12.4615},{44,12.4615},{44,-26},{68,-26}},
                                             color={0,127,255}));
    connect(SupPrim.ports[1], heater.port_a2) annotation (Line(points={{-72,-36},
            {-52,-36},{-52,12.4615},{-24,12.4615}},color={0,127,255}));
    connect(registerBus, heater.registerBus) annotation (Line(
        points={{-63,17},{-45.5,17},{-45.5,26.0769},{-23.78,26.0769}},
        color={255,204,51},
        thickness=0.5));

    connect(Air1.ports[1], heater.port_a1) annotation (Line(points={{-70,58},{
            -30,58},{-30,40.1538},{-24,40.1538}},
                                              color={0,127,255}));
    connect(SupPrim.T_in, combiTimeTable.y[5]) annotation (Line(points={{-94,-32},
            {-120,-32},{-120,6},{-145,6}},      color={0,0,127}));
    connect(combiTimeTable.y[6], registerBus.hydraulicBus.pumpBus.rpmSet)
      annotation (Line(points={{-145,6},{-88,6},{-88,17.095},{-62.905,17.095}},
          color={0,0,127}));
    connect(combiTimeTable.y[8], registerBus.hydraulicBus.valveSet) annotation (
       Line(points={{-145,6},{-88,6},{-88,17.095},{-62.905,17.095}}, color={0,0,
            127}));
    connect(combiTimeTable.y[9], Air1.m_flow_in) annotation (Line(points={{-145,6},
            {-88,6},{-88,44},{-98,44},{-98,72},{-92,72},{-92,66}},
                                             color={0,0,127}));
    connect(combiTimeTable.y[10], Air1.T_in) annotation (Line(points={{-145,6},{-88,
            6},{-88,44},{-98,44},{-98,62},{-92,62}},      color={0,0,127}));
    connect(booleanExpression2.y,logicalSwitch. u3) annotation (Line(points={{-81,104},
            {-64,104},{-64,94}},      color={255,0,255}));
    connect(booleanExpression1.y, logicalSwitch.u1) annotation (Line(points={{-29,
            102},{-48,102},{-48,94}}, color={255,0,255}));
    connect(lessEqualThreshold.y,logicalSwitch. u2) annotation (Line(points={{-113.4,
            120},{-56,120},{-56,94}}, color={255,0,255}));
    connect(combiTimeTable.y[6], lessEqualThreshold.u) annotation (Line(points={{-145,
            6},{-138,6},{-138,120},{-127.2,120}}, color={0,0,127}));
    connect(logicalSwitch.y, registerBus.hydraulicBus.pumpBus.onSet) annotation (
        Line(points={{-56,71},{-56,40},{-62.905,40},{-62.905,17.095}},
                                                           color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=386880, __Dymola_Algorithm="Dassl"));
  end Heater_calib;

  model AHU_Calib
    // AHUData muss vor Kalibrierung noch auf neue Arrays angepasst werden

    AixLib.Systems.ModularAHU.GenericAHU ahu(
      redeclare package Medium1 = AixLib.Media.Air,
      redeclare package Medium2 = AixLib.Media.Water,
      hydraulicEfficiency(V_flow={10900/3600}),
      T_amb=288.15,
      m1_flow_nominal=3.7,
      m2_flow_nominal=2.3,
      usePreheater=true,
      useHumidifierRet=false,
      useHumidifier=false,
      preheater(hydraulicModuleIcon="Injection", redeclare replaceable AixLib.Systems.HydraulicModules.Injection
        hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_6x1(d_i=35e-3, d_o=
            40e-3),
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        valve(y_start=0.5),
        pipe1(length=1.2),
        pipe2(length=0.1),
        pipe3(length=0.1),
        pipe4(length=2.3, fac=220),
        pipe5(length=2),
        pipe6(length=0.1),
        pipe7(length=1.3),
        pipe8(length=0.3),
        pipe9(length=0.3),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)))),
      cooler(hydraulicModuleIcon="Injection2WayValve", redeclare
          AixLib.Systems.HydraulicModules.Injection2WayValve hydraulicModule(
          pipeModel="SimplePipe",
          length=1,
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_6x1(),
          Kv=25,
          redeclare
            AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
            PumpInterface(pump(redeclare
                AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))),
      heater(
        hydraulicModuleIcon="Injection",
        m2_flow_nominal=2.3,
        T_amb=288.15,
      redeclare AixLib.Systems.HydraulicModules.Injection hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        Kv=10,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        pipe1(length=10),
        pipe2(length=0.3),
        pipe3(length=0.3),
        pipe4(length=2, fac=315),
        pipe5(length=5.5),
        pipe6(length=0.4),
        pipe7(length=10),
        pipe8(length=0.6),
        pipe9(length=0.6),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12
              per)))))
      annotation (Placement(transformation(extent={{-54,-24},{46,28}})));

    AixLib.Fluid.Sources.Boundary_ph SupPrimHeater(
      redeclare package Medium = AixLib.Media.Water,
      p=115000,
      nPorts=1) annotation (Placement(transformation(extent={{26,-54},{18,-46}})));
    AixLib.Fluid.Sources.Boundary_ph SupPrimCooler(
      redeclare package Medium = AixLib.Media.Water,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-16,-54},{-8,-46}})));
    AixLib.Fluid.Sources.Boundary_ph SupPrimPreheater(
      redeclare package Medium = AixLib.Media.Water,
      p=115000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-52,-44},{-44,-36}})));
    AixLib.Fluid.Sources.Boundary_ph RetPrimPreheater(
      redeclare package Medium = AixLib.Media.Water,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-22,-44},{-30,-36}})));
    AixLib.Fluid.Sources.Boundary_ph RetPrimCooler(
      redeclare package Medium = AixLib.Media.Water,
      p=100000,
      nPorts=1) annotation (Placement(transformation(extent={{-4,-42},{4,-34}})));
    AixLib.Fluid.Sources.Boundary_ph RetPrimHeater(
      redeclare package Medium = AixLib.Media.Water,
      p=100000,
      nPorts=1) annotation (Placement(transformation(extent={{42,-54},{34,-46}})));
    AixLib.Fluid.Sources.Boundary_pT EHA(
      redeclare package Medium = AixLib.Media.Air,
      p=100000,
      nPorts=1) annotation (Placement(transformation(extent={{-88,20},{-74,34}})));
    AixLib.Fluid.Sources.Boundary_pT ODA(
      redeclare package Medium = AixLib.Media.Air,
      p=100000,
      use_T_in=false,
      nPorts=1) annotation (Placement(transformation(extent={{-88,-14},{-74,0}})));
    AixLib.Fluid.Sources.Boundary_pT ETA(
      redeclare package Medium = AixLib.Media.Air,
      p=100000,
      nPorts=1) annotation (Placement(transformation(extent={{80,12},{66,26}})));
    AixLib.Fluid.Sources.Boundary_pT SUP(
      redeclare package Medium = AixLib.Media.Air,
      p=100000,
      nPorts=1) annotation (Placement(transformation(extent={{80,-16},{66,-2}})));

    Calibration.AHUData aHUData
      annotation (Placement(transformation(extent={{-40,38},{-20,58}})));
  equation
    connect(SupPrimPreheater.ports[1], ahu.port_a3) annotation (Line(points={{-44,-40},
            {-42,-40},{-42,-24},{-40.3636,-24}},      color={0,127,255}));
    connect(SupPrimHeater.ports[1], ahu.port_a5) annotation (Line(points={{18,-50},
            {14,-50},{14,-24},{14.1818,-24}}, color={0,127,255}));
    connect(SupPrimCooler.ports[1], ahu.port_a4) annotation (Line(points={{-8,-50},
            {-6,-50},{-6,-24},{-4,-24}}, color={0,127,255}));
    connect(RetPrimHeater.ports[1], ahu.port_b5) annotation (Line(points={{34,-50},
            {28,-50},{28,-24},{22.8182,-24}}, color={0,127,255}));
    connect(RetPrimCooler.ports[1], ahu.port_b4) annotation (Line(points={{4,-38},
            {4,-32},{4,-24},{5.09091,-24}}, color={0,127,255}));
    connect(RetPrimPreheater.ports[1], ahu.port_b3) annotation (Line(points={{-30,-40},
            {-31.2727,-40},{-31.2727,-24}},      color={0,127,255}));
    connect(ODA.ports[1], ahu.port_a1) annotation (Line(points={{-74,-7},{-64,-7},
            {-64,-0.363636},{-54,-0.363636}}, color={0,127,255}));
    connect(ahu.port_b1, SUP.ports[1]) annotation (Line(points={{46.4545,
            -0.363636},{54.2272,-0.363636},{54.2272,-9},{66,-9}},
                                                       color={0,127,255}));
    connect(EHA.ports[1], ahu.port_b2) annotation (Line(points={{-74,27},{-64,
            27},{-64,18.5455},{-54,18.5455}},
                                          color={0,127,255}));
    connect(ahu.port_a2, ETA.ports[1]) annotation (Line(points={{46.4545,
            18.5455},{66,18.5455},{66,19}},
                                   color={0,127,255}));
    connect(aHUData.genericAHUBus, ahu.genericAHUBus) annotation (Line(
        points={{-20,48.1},{-20,48.05},{-4,48.05},{-4,28.2364}},
        color={255,204,51},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},
              {100,60}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-60},{100,60}})),
      experiment(StopTime=20000, __Dymola_Algorithm="Dassl"));
  end AHU_Calib;
end Calibration;
