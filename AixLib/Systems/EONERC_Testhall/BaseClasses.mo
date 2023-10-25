within AixLib.Systems.EONERC_Testhall;
package BaseClasses
  package AHU
    model AHU
      AixLib.Systems.ModularAHU.GenericAHU ahu(
        redeclare package Medium1 = AixLib.Media.Air,
        redeclare package Medium2 = AixLib.Media.Water,
        T_amb=288.15,
        m1_flow_nominal=3.7,
        m2_flow_nominal=2.3,
        usePreheater=true,
        useHumidifierRet=false,
        useHumidifier=false,
        preheater(
          hydraulicModuleIcon="Injection",
          m2_flow_nominal=2.3,
          redeclare AixLib.Systems.HydraulicModules.Injection hydraulicModule(
            parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
            Kv=6.3,
            valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
            pipe1(length=1.2),
            pipe2(length=0.1),
            pipe3(length=0.1),
            pipe4(length=2.3),
            pipe5(length=2),
            pipe6(length=0.1),
            pipe7(length=1.3),
            pipe8(length=0.3),
            pipe9(length=0.3),
            redeclare
              AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
              PumpInterface(pump(redeclare
                  AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))),
        cooler(
          hydraulicModuleIcon="Injection2WayValve",
          m2_flow_nominal=2.3,
          redeclare AixLib.Systems.HydraulicModules.Injection2WayValve
            hydraulicModule(
            pipeModel="SimplePipe",
            length=1,
            parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_6x1(),
            Kv=25,
            redeclare
              AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
              PumpInterface(pumpParam=Testhall.Subsystems.AHU.Pump_Test.pump_cooler()))),
        heater(
          hydraulicModuleIcon="Injection2WayValve",
          m2_flow_nominal=2.3,
          redeclare AixLib.Systems.HydraulicModules.Injection2WayValve
            hydraulicModule(
            parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
            Kv=10,
            redeclare
              AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
              PumpInterface(pump(redeclare
                  AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)),
            pipe1(length=10),
            pipe2(length=0.6),
            pipe3(length=2),
            pipe4(length=5.5),
            pipe5(length=0.4),
            pipe6(length=10),
            pipe7(length=0.6))))
        annotation (Placement(transformation(extent={{-136,-50},{114,84}})));

      Modelica.Fluid.Interfaces.FluidPort_a rlt_ph_supprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{-120,-106},
                {-100,-86}}), iconTransformation(extent={{-170,-110},{-150,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b rlt_ph_retprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{-82,-106},
                {-62,-86}}), iconTransformation(extent={{-130,-110},{-110,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_a rlt_c_supprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{-26,-106},
                {-6,-86}}), iconTransformation(extent={{-10,-110},{10,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b rlt_c_retprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{8,-106},
                {28,-86}}), iconTransformation(extent={{32,-110},{52,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_a rlt_h_supprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{48,-106},
                {68,-86}}), iconTransformation(extent={{72,-110},{92,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b rlt_h_retprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{74,-106},
                {94,-86}}), iconTransformation(extent={{108,-110},{128,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_a ODA(redeclare package Medium =
            AixLib.Media.Air) annotation (Placement(transformation(extent={{-228,2},
                {-208,22}}), iconTransformation(extent={{-234,-12},{-214,8}})));
      Modelica.Fluid.Interfaces.FluidPort_a ETA(redeclare package Medium =
            AixLib.Media.Air) annotation (Placement(transformation(extent={{206,48},
                {226,68}}), iconTransformation(extent={{212,68},{232,88}})));
      Modelica.Fluid.Interfaces.FluidPort_b SUP(redeclare package Medium =
            AixLib.Media.Air) annotation (Placement(transformation(extent={{206,0},
                {226,20}}), iconTransformation(extent={{216,-12},{236,8}})));
      Modelica.Fluid.Interfaces.FluidPort_b EHA(redeclare package Medium =
            AixLib.Media.Air) annotation (Placement(transformation(extent={{-228,48},
                {-208,68}}), iconTransformation(extent={{-232,72},{-212,92}})));
      AixLib.Systems.ModularAHU.BaseClasses.GenericAHUBus
                                genericAHUBus "Bus connector for genericAHU"
        annotation (Placement(transformation(extent={{-42,82},{22,156}}),
            iconTransformation(extent={{-20,116},{20,164}})));
    equation
      connect(rlt_ph_supprim, ahu.port_a3) annotation (Line(points={{-110,-96},{
              -110,-60},{-101.909,-60},{-101.909,-50}},
                                                   color={0,127,255}));
      connect(rlt_ph_retprim, ahu.port_b3) annotation (Line(points={{-72,-96},{-72,
              -60},{-80,-60},{-80,-56},{-79.1818,-56},{-79.1818,-50}},
                                                                  color={0,127,255}));
      connect(rlt_h_supprim, ahu.port_a5) annotation (Line(points={{58,-96},{58,-62},
              {34.4545,-62},{34.4545,-50}}, color={0,127,255}));
      connect(rlt_h_retprim, ahu.port_b5) annotation (Line(points={{84,-96},{84,-60},
              {56.0455,-60},{56.0455,-50}}, color={0,127,255}));
      connect(rlt_c_supprim, ahu.port_a4) annotation (Line(points={{-16,-96},{-16,-62},
              {-11,-62},{-11,-50}}, color={0,127,255}));
      connect(rlt_c_retprim, ahu.port_b4) annotation (Line(points={{18,-96},{18,-62},
              {11.7273,-62},{11.7273,-50}}, color={0,127,255}));
      connect(ahu.port_a1, ODA) annotation (Line(points={{-136,10.9091},{-136,12},{-218,
              12}}, color={0,127,255}));
      connect(ahu.port_b2, EHA) annotation (Line(points={{-136,59.6364},{-136,58},{
              -218,58}}, color={0,127,255}));
      connect(ahu.genericAHUBus, genericAHUBus) annotation (Line(
          points={{-11,84.6091},{-11,118},{-10,118},{-10,119}},
          color={255,204,51},
          thickness=0.5));
      connect(ahu.port_a2, ETA) annotation (Line(points={{115.136,59.6364},{115.136,
              58},{216,58}}, color={0,127,255}));
      connect(ahu.port_b1, SUP) annotation (Line(points={{115.136,10.9091},{200,
              10.9091},{200,10},{216,10}}, color={0,127,255}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},
                {220,120}}),       graphics={
            Rectangle(
              extent={{-220,120},{220,-100}},
              lineColor={0,0,0},
              pattern=LinePattern.Dash,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-210,0},{-166,0},{-90,0}},  color={28,108,200}),
            Rectangle(visible=usePreheater, extent={{-164,38},{-116,-40}}, lineColor=
                  {0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(extent={{-4,38},{44,-40}}, lineColor={0,0,0}),
            Rectangle(extent={{74,38},{122,-40}}, lineColor={0,0,0}),
            Rectangle(extent={{-90,100},{-30,-40}}, lineColor={0,0,0}),
            Line(visible=usePreheater,points={{-164,-40},{-116,38}}, color={0,0,0}),
            Line(points={{-4,-40},{44,38}}, color={0,0,0}),
            Line(points={{74,-40},{122,38}}, color={0,0,0}),
            Line(points={{-4,36},{44,-40}}, color={0,0,0}),
            Line(points={{-90,-34},{-36,100}}, color={0,0,0}),
            Line(points={{-84,-40},{-30,94}}, color={0,0,0}),
            Line(points={{-90,100},{-30,-40}},color={0,0,0}),
            Line(points={{122,0},{166,0}}, color={28,108,200}),
            Line(points={{144,80},{-30,80}},color={28,108,200}),
            Ellipse(extent={{202,-18},{166,18}}, lineColor={0,0,0}),
            Line(points={{176,16},{200,8}}, color={0,0,0}),
            Line(points={{200,-8},{176,-16}}, color={0,0,0}),
            Ellipse(
              extent={{18,-18},{-18,18}},
              lineColor={0,0,0},
              origin={162,80},
              rotation=180),
            Line(
              points={{-12,4},{12,-4}},
              color={0,0,0},
              origin={158,68},
              rotation=180),
            Line(
              points={{12,4},{-12,-4}},
              color={0,0,0},
              origin={158,92},
              rotation=180),
            Line(points={{212,80},{180,80}}, color={28,108,200}),
            Rectangle(visible=useHumidifier, extent={{138,38},{160,-40}}, lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(visible=useHumidifier, points={{146,24},{152,28}}, color={0,0,0}),
            Line(visible=useHumidifier, points={{152,24},{146,24}}, color={0,0,0}),
            Line(visible=useHumidifier, points={{152,20},{146,24}}, color={0,0,0}),
            Line(visible=useHumidifier, points={{146,0},{152,4}}, color={0,0,0}),
            Line(visible=useHumidifier, points={{152,0},{146,0}}, color={0,0,0}),
            Line(visible=useHumidifier, points={{152,-4},{146,0}}, color={0,0,0}),
            Line(visible=useHumidifier, points={{146,-20},{152,-16}}, color={0,0,0}),
            Line(visible=useHumidifier, points={{152,-20},{146,-20}}, color={0,0,0}),
            Line(visible=useHumidifier, points={{152,-24},{146,-20}}, color={0,0,0}),
            Rectangle(visible=useHumidifierRet, extent={{0,100},{20,58}}, lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(visible=useHumidifierRet, points={{8,86},{14,90}}, color={0,0,0}),
            Line(visible=useHumidifierRet, points={{14,90},{8,90}}, color={0,0,0}),
            Line(visible=useHumidifierRet, points={{14,90},{8,94}}, color={0,0,0}),
            Line(visible=useHumidifierRet, points={{8,66},{14,70}}, color={0,0,0}),
            Line(visible=useHumidifierRet, points={{14,70},{8,70}}, color={0,0,0}),
            Line(visible=useHumidifierRet, points={{14,70},{8,74}}, color={0,0,0}),
            Line(points={{0,78}}, color={28,108,200}),
            Line(points={{-90,80},{-210,80}}, color={28,108,200}),
            Line(points={{-30,0},{-4,0}}, color={28,108,200}),
            Line(points={{44,0},{74,0}}, color={28,108,200}),
            Line(points={{202,-2},{218,-2}},
                                           color={28,108,200}),
            Line(visible=usePreheater, points={{-160,-40},{-160,-90}}, color={28,108,200}),
            Line(visible=usePreheater, points={{-120,-40},{-120,-90}}, color={28,108,200}),
            Line(points={{0,-40},{0,-90}}, color={28,108,200}),
            Line(points={{40,-40},{40,-90}}, color={28,108,200}),
            Line(points={{80,-40},{80,-90}}, color={28,108,200}),
            Line(points={{118,-40},{118,-90}}, color={28,108,200})}),Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{220,120}})));
    end AHU;

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
  end AHU;

  package CCA "Concrete core activation"
    model CCA

      AixLib.Systems.HydraulicModules.Injection2WayValve cca(
        redeclare package Medium = AixLib.Media.Water,
        pipeModel="SimplePipe",
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
        Kv=2.34,
        m_flow_nominal=1.79,
        redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
              PumpInterface(pumpParam=
                  AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50_H1_10()),
        pipe1(length=0.3),
        pipe2(length=0.2),
        pipe3(length=10),
        pipe4(length=10),
        pipe6(length=0.4),
        pipe7(length=0.18),
        pipe5(length=0.1),
        T_amb=273.15 + 10,
        T_start=323.15) annotation (Placement(transformation(
            extent={{-36,-36},{35.9999,35.9999}},
            rotation=90,
            origin={-12,-26})));

      Components.ConcreteCoreActivation concreteCoreActivation(
        redeclare package Medium = AixLib.Media.Water,
        nNodes=6,
        C=200,
        Gc=41e6,
        pipe(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
          length=17.2,
          m_flow_nominal=1.79,
          T_start=323.15))
        annotation (Placement(transformation(extent={{-42,32},{14,86}})));
      Modelica.Fluid.Interfaces.FluidPort_a cca_supprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{-44,-110},
                {-24,-90}}), iconTransformation(extent={{-44,-110},{-24,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b cca_retprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{0,-110},
                {20,-90}}), iconTransformation(extent={{30,-110},{50,-90}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_port_CCA
        annotation (Placement(transformation(extent={{-26,94},{-6,114}}),
            iconTransformation(extent={{-10,94},{10,114}})));
      AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
            AixLib.Media.Water) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-44,30})));
      DistributeBus distributeBus
        annotation (Placement(transformation(extent={{-122,-46},{-82,-6}})));
    equation
      connect(cca_supprim, cca.port_a1) annotation (Line(points={{-34,-100},{
              -34,-81},{-33.5999,-81},{-33.5999,-62}},
                                    color={0,127,255}));
      connect(cca_retprim, cca.port_b2) annotation (Line(points={{10,-100},{10,-81},
              {9.60002,-81},{9.60002,-62}},
                              color={0,127,255}));
      connect(cca.port_a2, concreteCoreActivation.port_ret) annotation (Line(points={{9.60002,
              9.9999},{8,9.9999},{8,28},{22,28},{22,59},{14,59}},            color={
              0,127,255}));
      connect(concreteCoreActivation.heatPort, heat_port_CCA) annotation (Line(
            points={{-14,88.7},{-14,96.35},{-16,96.35},{-16,104}}, color={191,0,0}));
      connect(cca.port_b1, senMasFlo.port_a) annotation (Line(points={{-33.5999,
              9.9999},{-38,9.9999},{-38,20},{-44,20}}, color={0,127,255}));
      connect(senMasFlo.port_b, concreteCoreActivation.port_sup) annotation (Line(
            points={{-44,40},{-48,40},{-48,59},{-42,59}}, color={0,127,255}));
      connect(cca.hydraulicBus, distributeBus.bus_cca) annotation (Line(
          points={{-47.9999,-26},{-74.9999,-26},{-74.9999,-25.9},{-101.9,-25.9}},

          color={255,204,51},
          thickness=0.5));
      connect(senMasFlo.m_flow, distributeBus.bus_cca.mflow) annotation (Line(
            points={{-55,30},{-100,30},{-100,-26},{-102,-26}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={212,212,212},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{2,81},{-18,77},{-38,71},{-50,57},{-56,49},{-66,39},{-70,27},
                  {-74,13},{-76,-1},{-74,-17},{-74,-29},{-74,-39},{-68,-51},{-62,
                  -59},{-46,-63},{-28,-69},{-16,-69},{0,-71},{10,-75},{24,-75},{34,
                  -73},{44,-67},{56,-61},{58,-59},{68,-47},{70,-39},{72,-37},{74,
                  -21},{78,-7},{80,1},{80,17},{76,29},{68,39},{56,47},{46,55},{38,
                  71},{28,79},{2,81}},
              lineColor={255,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-56,49},{-66,39},{-70,27},{-74,13},{-76,-1},{-74,-17},{-74,
                  -29},{-74,-39},{-68,-51},{-62,-59},{-46,-63},{-28,-69},{-16,-69},
                  {0,-71},{10,-75},{24,-75},{34,-73},{44,-67},{56,-61},{44,-63},{42,
                  -63},{32,-65},{22,-67},{20,-67},{12,-67},{4,-63},{-10,-59},{-20,
                  -59},{-28,-57},{-38,-51},{-48,-41},{-54,-29},{-56,-21},{-56,-11},
                  {-58,1},{-58,9},{-58,21},{-56,31},{-54,33},{-50,41},{-46,49},{-42,
                  59},{-38,71},{-56,49}},
              lineColor={255,0,0},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-67,21},{73,-10}},
              lineColor={0,0,0},
              textString="%CCA")}),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
    end CCA;

    package Components
      model ConcreteCoreActivation

        replaceable package Medium =
            AixLib.Media.Water
          "Medium in the system" annotation (choicesAllMatching=true);

        parameter Integer nNodes "Number of elements";
        parameter Modelica.Units.SI.HeatCapacity C
          "Heat capacity of element (= cp*m)";
        parameter  Modelica.Units.SI.ThermalConductance Gc
          "Signal representing the convective thermal conductance in [W/K]";

        AixLib.Fluid.FixedResistances.GenericPipe pipe(
          redeclare package Medium = Medium,
          parameterPipe=parameterPipe,
          m_flow_nominal=m_flow_nominal,
          length=length,
          T_start=T_start) "Pipe that goes through the concrete" annotation (Dialog(enable=true),
            Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C/
              nNodes, T(start=323.15)) annotation (Placement(
              transformation(
              extent={{-8,-8},{8,8}},
              rotation=270,
              origin={32,38})));
        Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
            Placement(transformation(
              extent={{-6,-6},{6,6}},
              rotation=90,
              origin={0,44})));
        Modelica.Blocks.Sources.Constant const(k=Gc/nNodes)
          annotation (Placement(transformation(extent={{-60,34},{-40,54}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
          "heat port for connection to room volume" annotation (Placement(
              transformation(extent={{-10,66},{10,86}}),  iconTransformation(extent={{
                  -10,100},{10,120}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_sup(redeclare package Medium =
              Medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_ret(redeclare package Medium =
              Medium)
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      equation
        connect(pipe.heatPort,heatCapacitor. port) annotation (Line(points={{7.21645e-16,
                10},{7.21645e-16,32},{12,32},{12,38},{24,38}},
                                               color={191,0,0}));
        connect(heatCapacitor.port,convection. solid)
          annotation (Line(points={{24,38},{0,38}},            color={191,0,0}));
        connect(convection.fluid,heatPort)
          annotation (Line(points={{3.88578e-16,50},{3.88578e-16,63},{0,63},{0,76}},
                                                             color={191,0,0}));
        connect(convection.Gc,const. y)
          annotation (Line(points={{-6,44},{-39,44}}, color={0,0,127}));
        connect(pipe.heatPort,convection. solid) annotation (Line(points={{7.21645e-16,
                10},{7.21645e-16,24},{-3.88578e-16,24},{-3.88578e-16,38}}, color={191,
                0,0}));
        connect(port_sup, pipe.port_a) annotation (Line(points={{-100,0},{-55,0},{-55,
                1.72085e-15},{-10,1.72085e-15}}, color={0,127,255}));
        connect(pipe.port_b, port_ret) annotation (Line(points={{10,-7.21645e-16},{55,
                -7.21645e-16},{55,0},{100,0}}, color={0,127,255}));
       annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Polygon(
                points={{4,79},{-16,75},{-36,69},{-48,55},{-54,47},{-64,37},{-68,
                    25},{-72,11},{-74,-3},{-72,-19},{-72,-31},{-72,-41},{-66,-53},
                    {-60,-61},{-44,-65},{-26,-71},{-14,-71},{2,-73},{12,-77},{26,
                    -77},{36,-75},{46,-69},{58,-63},{60,-61},{70,-49},{72,-41},{
                    74,-39},{76,-23},{80,-9},{82,-1},{82,15},{78,27},{70,37},{58,
                    45},{48,53},{40,69},{30,77},{4,79}},
                lineColor={255,0,0},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-54,47},{-64,37},{-68,25},{-72,11},{-74,-3},{-72,-19},{
                    -72,-31},{-72,-41},{-66,-53},{-60,-61},{-44,-65},{-26,-71},{
                    -14,-71},{2,-73},{12,-77},{26,-77},{36,-75},{46,-69},{58,-63},
                    {46,-65},{44,-65},{34,-67},{24,-69},{22,-69},{14,-69},{6,-65},
                    {-8,-61},{-18,-61},{-26,-59},{-36,-53},{-46,-43},{-52,-31},{
                    -54,-23},{-54,-13},{-56,-1},{-56,7},{-56,19},{-54,29},{-52,31},
                    {-48,39},{-44,47},{-40,57},{-36,69},{-54,47}},
                lineColor={255,0,0},
                fillColor={160,160,164},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-65,19},{75,-12}},
                lineColor={0,0,0},
                textString="%CCA"),
              Line(points={{146,-70}}, color={255,0,0})}),             Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end ConcreteCoreActivation;
    end Components;
  end CCA;

  package CID "Ceiling Injection Diffusor"
    model CID "Ceiling induction diffusers / DID Deckeninduktionsdurchlässe"

        replaceable package MediumWater =
          AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
          choicesAllMatching=true);
      replaceable package MediumAir =
          AixLib.Media.Air
        "Medium in the system" annotation(choicesAllMatching=true);

      AixLib.Fluid.HeatExchangers.ConstantEffectiveness hex_office_heater(
        each m1_flow_nominal=0.15,
        each m2_flow_nominal=0.8,
        each eps=0.95,
        each m1_flow_small=0.01,
        each m2_flow_small=0.01,
        each dp1_nominal=100,
        each dp2_nominal=5,
        redeclare package Medium1 = AixLib.Media.Water,
        redeclare package Medium2 = AixLib.Media.Air)
                                               "DID"
        annotation (Placement(transformation(extent={{46,52},{26,30}})));
      AixLib.Fluid.Actuators.Valves.TwoWayLinear Valve(
        redeclare package Medium = MediumAir,
        each m_flow_nominal=0.8,
        CvData=AixLib.Fluid.Types.CvTypes.Kv,
        Kv=12000,
        dpValve_nominal=10,
        each l=0.01) "if Valve Kv=100 " annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-146,86})));

      AixLib.Fluid.FixedResistances.GenericPipe pipe_offices(
        redeclare package Medium = MediumAir,
        each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_108x1_5(),
        each length=0.1,
        each m_flow_nominal=0.8) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={112,64})));
      Modelica.Fluid.Interfaces.FluidPort_b air_out(redeclare package Medium =
            MediumAir) "SUP" annotation (Placement(transformation(extent={{130,54},{
                150,74}}), iconTransformation(extent={{-70,50},{-50,70}})));
      Modelica.Fluid.Interfaces.FluidPort_a cid_supprim(redeclare package
          Medium =
            MediumWater) annotation (Placement(transformation(extent={{-190,-18},{-170,
                2}}), iconTransformation(extent={{-48,-70},{-28,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_b cid_retprim(redeclare package
          Medium =
            MediumWater) annotation (Placement(transformation(extent={{-190,-42},{
                -170,-22}}),
                        iconTransformation(extent={{-76,-70},{-56,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_a air_in(redeclare package Medium =
            MediumAir) annotation (Placement(transformation(extent={{-188,76},{-168,
                96}}), iconTransformation(extent={{22,-70},{42,-50}})));

      AixLib.Systems.HydraulicModules.Injection2WayValve cid_Valve(
        redeclare package Medium = MediumWater,
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1(),
        Kv=0.63,
        m_flow_nominal=0.15,
       redeclare
              AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
              PumpInterface(pump(redeclare
                  AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per)),
        pipe1(length=0.3, fac=10),
        pipe2(length=0.15, fac=10),
        pipe3(length=2.5, fac=10),
        pipe5(length=0.15),
        pipe6(length=0.15),
        pipe4(length=3, fac=5),
        pipe7(length=0.3),
        T_amb=273.15 + 10,
        T_start=323.15) annotation (Placement(transformation(
            extent={{-20.001,-20.0005},{19.999,19.9994}},
            rotation=0,
            origin={-130.001,-20.0005})));

      AixLib.Fluid.Sensors.MassFlowRate senMasFlo_hydraulics(redeclare package
          Medium = AixLib.Media.Water)
        annotation (Placement(transformation(extent={{-78,-18},{-58,2}})));
    equation
      connect(pipe_offices.port_b, air_out)
        annotation (Line(points={{122,64},{140,64}}, color={0,127,255}));

      connect(cid_supprim, cid_Valve.port_a1) annotation (Line(points={{-180,-8},{-165.001,
              -8},{-165.001,-8.00108},{-150.002,-8.00108}}, color={0,127,255}));
      connect(cid_retprim, cid_Valve.port_b2) annotation (Line(points={{-180,-32},{
              -156,-32},{-156,-32.001},{-150.002,-32.001}}, color={0,127,255}));

      connect(cid_Valve.port_a2, hex_office_heater.port_b1) annotation (Line(points={{
              -110.002,-32.001},{-96,-32.001},{-96,34.4},{26,34.4}},  color={0,127,255}));

      connect(Valve.y, distributeBus_CID.control_cid.Office1_Air_Valve) annotation (
         Line(points={{-146,98},{-146,106},{-84,106},{-84,98},{-63.91,98},{-63.91,119.095}},
            color={0,0,127}));
      connect(cid_Valve.port_b1, senMasFlo_hydraulics.port_a) annotation (Line(
            points={{-110.002,-8.00108},{-108,-8.00108},{-108,-8},{-78,-8}}, color=
              {0,127,255}));
      connect(senMasFlo_hydraulics.port_b, hex_office_heater.port_a1) annotation (
          Line(points={{-58,-8},{56,-8},{56,34.4},{46,34.4}}, color={0,127,255}));
      connect(cid_Valve.hydraulicBus, distributeBus_CID.bus_cid) annotation (Line(
          points={{-130.002,-0.0011},{-130.002,120},{-63.91,120},{-63.91,119.095}},
          color={255,204,51},
          thickness=0.5));

      connect(senMasFlo_hydraulics.m_flow, distributeBus_CID.bus_cid.m_flow)
        annotation (Line(points={{-68,3},{-68,94},{-63.91,94},{-63.91,119.095}},
            color={0,0,127}));
      connect(Valve.port_a, air_in)
        annotation (Line(points={{-156,86},{-178,86}}, color={0,127,255}));
      connect(Valve.port_b, hex_office_heater.port_a2) annotation (Line(points={{-136,
              86},{18,86},{18,47.6},{26,47.6}}, color={0,127,255}));
      connect(hex_office_heater.port_b2, pipe_offices.port_a) annotation (Line(
            points={{46,47.6},{46,46},{96,46},{96,64},{102,64}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-80},
                {160,120}}),graphics={Rectangle(
              extent={{-100,60},{100,-60}},
              lineColor={3,15,29},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid), Text(
              extent={{-78,30},{74,-28}},
              lineColor={3,15,29},
              lineThickness=1,
              fillColor={135,135,135},
              fillPattern=FillPattern.None,
              textString="CID")}),                                   Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-180,-80},{160,120}})),
        experiment(StopTime=50000, __Dymola_Algorithm="Dassl"));
    end CID;
  end CID;

  package Consumers
    model Buildings_Test_Hall_EON_ERC

       replaceable package MediumWater =
          AixLib.Media.Water
        "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
      replaceable package MediumAir =
          AixLib.Media.Air
        "Medium in the system" annotation(choicesAllMatching=true);

      Modelica.Blocks.Sources.Constant infiltration_rate_hall1(k=0)
        annotation (Placement(transformation(extent={{174,170},{194,190}})));
      Modelica.Blocks.Sources.Constant infiltration_rate_hall2(k=0)
        annotation (Placement(transformation(extent={{-84,170},{-64,190}})));
      AixLib.Fluid.Sources.Boundary_ph     AirOut_Hall2(
        redeclare package Medium = MediumAir,
        nPorts=1,
        p=100000) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={70,164})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe_out_hall2(
        redeclare package Medium = MediumAir,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        length=1,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,128})));
       AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office5(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=60,
            AZone=18,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,6,0,0},
            ATransparent={0,0,6,0,0},
            AExt={0,28,0,0,0},
            nExt=1,
            AInt=42,
            nInt=1,
            AFloor=37,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=true),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        nPorts=2,
        T_start=295.35) "Thermal zone"
        annotation (Placement(transformation(extent={{1278,20},{1378,120}})));
      AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
        calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
        computeWetBulbTemperature=false,
        filNam=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Testhall/DataBase/Weather/DEU_Dusseldorf.104000_IWEC.mos"))
        annotation (Placement(transformation(extent={{-160,42},{-140,62}})));

      AixLib.BoundaryConditions.WeatherData.Bus     weaBus annotation (Placement(
            transformation(extent={{-126,34},{-106,54}}), iconTransformation(extent=
               {{0,0},{0,0}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_port_rad_hall2
        "Radiative internal gains"
        annotation (Placement(transformation(extent={{70,-24},{90,-4}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_hall1[2](
          redeclare package Medium = MediumAir)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{196,-24},{270,-4}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_port_rad_hall1
        "Radiative internal gains"
        annotation (Placement(transformation(extent={{290,-24},{310,-4}})));

      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office1(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=60,
            AZone=18,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,6,0,0},
            ATransparent={0,0,6,0,0},
            AExt={0,15,12,0,0},
            nExt=1,
            AInt=45,
            nInt=1,
            AFloor=16,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=false),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        nPorts=2,
        machinesSenHea(areaSurfaceMachinesTotal=0.1),
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{400,20},{500,120}})));
      Modelica.Blocks.Sources.Constant infiltration_rate_office1(k=0)
        annotation (Placement(transformation(extent={{388,174},{408,194}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office1[2](
          redeclare package Medium = MediumAir)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{414,-24},{488,-4}})));
      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office2(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=60,
            AZone=18,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,6,0,0},
            ATransparent={0,0,6,0,0},
            AExt={0,0,14,0,0},
            nExt=1,
            AInt=50,
            nInt=1,
            AFloor=18,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=true),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        nPorts=2,
        machinesSenHea(areaSurfaceMachinesTotal=0.1),
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{620,20},{722,120}})));
      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office3(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=60,
            AZone=18,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,6,0,0},
            ATransparent={0,0,6,0,0},
            AExt={0,0,14,0,0},
            nExt=1,
            AInt=60,
            nInt=1,
            AFloor=18,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=true),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        nPorts=2,
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{840,22},{938,122}})));
      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office4(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=120,
            AZone=37,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,12,0,0},
            ATransparent={0,0,12,0,0},
            AExt={0,30,0,0,0},
            nExt=1,
            AInt=100,
            nInt=1,
            AFloor=37,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=true),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        nPorts=2,
        T_start=295.35) "Thermal zone"
        annotation (Placement(transformation(extent={{1060,20},{1160,120}})));
        AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone Hall2(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=3000,
            AZone=300,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,0,0,0},
            ATransparent={0,0,0,0,0},
            RWin=0.0177,
            gWin=0.78,
            UWin=2.1,
            ratioWinConRad=0.09,
            AExt={0,0,0,0,0},
            nExt=1,
            AInt=140,
            nInt=1,
            AFloor=380,
            nFloor=1,
            ARoof=380,
            nRoof=1,
            nOrientationsRoof=1,
            specificPeople=1,
            activityDegree=3,
            fixedHeatFlowRatePersons=80,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=false),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        nPorts=1,
        machinesSenHea(areaSurfaceMachinesTotal=10),
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{-36,20},{64,120}})));
            //AWin={5,0,0,0,5},
            //AExt={0,175,140,175,0},

          AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Hall1(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=5000,
            AZone=500,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,0,0,0},
            ATransparent={0,0,0,0,0},
            AExt={0,0,0,0,0},
            nExt=1,
            AInt=140,
            nInt=1,
            AFloor=640,
            nFloor=1,
            ARoof=790,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=false),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        nPorts=2,
        machinesSenHea(areaSurfaceMachinesTotal=50),
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{180,20},{280,120}})));
            //withAirCap=true,
            //AWin={0,2,0,2,0},
            //AExt={0,320,90,310,0},

      Modelica.Blocks.Sources.Constant infiltration_rate_office2(k=0)
        annotation (Placement(transformation(extent={{614,140},{634,160}})));
      Modelica.Blocks.Sources.Constant infiltration_rate_office3(k=0)
        annotation (Placement(transformation(extent={{836,140},{856,160}})));
      Modelica.Blocks.Sources.Constant infiltration_rate_office4(k=0)
        annotation (Placement(transformation(extent={{1052,140},{1072,160}})));
      Modelica.Blocks.Sources.Constant infiltration_rate_office5(k=0)
        annotation (Placement(transformation(extent={{1274,140},{1294,160}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office2[2](
          redeclare package Medium = MediumAir)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{634,-24},{708,-4}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office3[2](
          redeclare package Medium = MediumAir)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{852,-24},{926,-4}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office4[2](
          redeclare package Medium = MediumAir)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{1074,-24},{1148,-4}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office5[2](
          redeclare package Medium = MediumAir)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{1294,-24},{1368,-4}})));
      Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus
        annotation (Placement(transformation(extent={{-102,-28},{-62,12}}),
            iconTransformation(extent={{0,0},{0,0}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.2; 43200,0.2; 43260,0.2; 46800,0.2; 46860,0.2;
            64800,0.2; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{202,196},{222,216}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light(
                                           extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{202,140},{222,160}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0.5; 28740,0.5; 28800,0.5; 64800,0.5; 64860,0.5; 86400,0.5])
        annotation (Placement(transformation(extent={{202,168},{222,188}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans1(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.04; 43200,0.04; 43260,0.04; 46800,0.04; 46860,0.04;
            64800,0.04; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{424,194},{444,214}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light1(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{424,138},{444,158}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine1(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
        annotation (Placement(transformation(extent={{424,166},{444,186}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans2(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,0.12;
            64800,0.12; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{646,194},{666,214}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light2(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{646,138},{666,158}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine2(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
        annotation (Placement(transformation(extent={{646,166},{666,186}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans3(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,0.12;
            64800,0.12; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{866,194},{886,214}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light3(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{866,138},{886,158}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine3(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
        annotation (Placement(transformation(extent={{866,166},{886,186}})));
      Modelica.Blocks.Sources.Constant internal_gains[3](each k=0)
        annotation (Placement(transformation(extent={{1100,160},{1120,180}})));
      Modelica.Blocks.Sources.Constant internal_gains1[3](each k=0)
        annotation (Placement(transformation(extent={{1320,160},{1340,180}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans4(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,0.12;
            64800,0.12; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{-8,196},{12,216}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light4(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{-8,140},{12,160}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine4(
                                                 extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
            0.5; 28740,0.5; 28800,0.5; 64800,0.5; 64860,0.5; 86400,0.5])
        annotation (Placement(transformation(extent={{-8,168},{12,188}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping(     f=0.0005, n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{240,196},{260,216}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping1(     f=0.0005, n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{240,168},{260,188}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping2(     f=0.0005, n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{240,140},{260,160}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping3(     f=0.0005, n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{22,196},{42,216}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping4(     f=0.0005, n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{22,168},{42,188}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping5(     f=0.0005, n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{22,140},{42,160}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping6(
                                                                 n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{458,194},{478,214}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping7(n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{460,138},{480,158}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping8(n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{460,166},{480,186}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping9(
                                                                 n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{684,194},{704,214}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping10(
                                                                  n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{684,138},{704,158}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping11(
                                                                  n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{684,166},{704,186}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping12(
                                                                 n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{900,194},{920,214}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping13(
                                                                  n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{900,138},{920,158}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping14(
                                                                  n=3, f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{900,166},{920,186}})));
    equation
      connect(pipe_out_hall2.port_b, AirOut_Hall2.ports[1])
        annotation (Line(points={{70,138},{70,154}}, color={0,127,255}));
      connect(infiltration_rate_hall1.y, Hall1.ventRate)
        annotation (Line(points={{195,180},{195,49},{182,49}},  color={0,0,127}));
      connect(Hall2.intGainsRad, heat_port_rad_hall2) annotation (Line(points={{65,87},
              {70,87},{70,86},{80,86},{80,-14}},         color={191,0,0}));
      connect(Hall2.ports[1], pipe_out_hall2.port_a) annotation (Line(points={{14,
              34},{14,12},{70,12},{70,118}}, color={0,127,255}));
      connect(Hall1.ports[1:2], ports_hall1) annotation (Line(points={{235.875,34},
              {233,34},{233,-14}},
                              color={0,127,255}));
      connect(Hall1.intGainsRad, heat_port_rad_hall1) annotation (Line(points={{281,87},
              {300,87},{300,56},{300,-14}},               color={191,0,0}));
      connect(heat_port_rad_hall1, heat_port_rad_hall1)
        annotation (Line(points={{300,-14},{300,-14}}, color={191,0,0}));
      connect(infiltration_rate_office1.y, Office1.ventRate)
        annotation (Line(points={{409,184},{409,49},{402,49}},  color={0,0,127}));
      connect(Office1.ports[1:2], ports_office1) annotation (Line(points={{455.875,
              34},{451,34},{451,-14}},
                                   color={0,127,255}));
      connect(infiltration_rate_office2.y, Office2.ventRate) annotation (Line(
            points={{635,150},{634,150},{634,49},{622.04,49}},color={0,0,127}));
      connect(infiltration_rate_office3.y, Office3.ventRate) annotation (Line(
            points={{857,150},{856,150},{856,51},{841.96,51}},color={0,0,127}));
      connect(infiltration_rate_office4.y, Office4.ventRate) annotation (Line(
            points={{1073,150},{1072,150},{1072,49},{1062,49}}, color={0,0,127}));
      connect(infiltration_rate_office5.y, Office5.ventRate) annotation (Line(
            points={{1295,150},{1295,49},{1280,49}}, color={0,0,127}));
      connect(Office2.ports[1:2], ports_office2) annotation (Line(points={{676.993,
              34},{671,34},{671,-14}}, color={0,127,255}));
      connect(Office3.ports[1:2], ports_office3) annotation (Line(points={{894.757,
              36},{900,36},{900,32},{889,32},{889,-14}}, color={0,127,255}));
      connect(Office5.ports[1:2], ports_office5) annotation (Line(points={{1333.88,
              34},{1331,34},{1331,-14}}, color={0,127,255}));
      connect(Office4.ports[1:2], ports_office4) annotation (Line(points={{1115.88,
              34},{1111,34},{1111,-14}}, color={0,127,255}));
      connect(Hall2.TAir, controlBus.Hall2_Air_m) annotation (Line(points={{69,110},
              {100,110},{100,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(Hall1.TAir, controlBus.Hall1_Air_m) annotation (Line(points={{285,110},
              {330,110},{330,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(Office1.TAir, controlBus.Office1_Air_m) annotation (Line(points={{505,
              110},{526,110},{526,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(Office2.TAir, controlBus.Office2_Air_m) annotation (Line(points={{727.1,
              110},{752,110},{752,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(Office3.TAir, controlBus.Office3_Air_m) annotation (Line(points={{942.9,
              112},{982,112},{982,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(Office4.TAir, controlBus.Office4_Air_m) annotation (Line(points={{1165,
              110},{1192,110},{1192,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(Office5.TAir, controlBus.Office5_Air_m) annotation (Line(points={{1383,
              110},{1420,110},{1420,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(internal_gains.y, Office4.intGains) annotation (Line(points={{1121,
              170},{1150,170},{1150,28}}, color={0,0,127}));
      connect(internal_gains1.y, Office5.intGains) annotation (Line(points={{1341,
              170},{1368,170},{1368,28}},                       color={0,0,127}));
      connect(Table_Humans.y[1], criticalDamping.u)
        annotation (Line(points={{223,206},{238,206}}, color={0,0,127}));
      connect(Table_Light.y[1], criticalDamping2.u)
        annotation (Line(points={{223,150},{238,150}}, color={0,0,127}));
      connect(Table_machine.y[1], criticalDamping1.u)
        annotation (Line(points={{223,178},{238,178}}, color={0,0,127}));
      connect(criticalDamping2.y, Hall1.intGains[3]) annotation (Line(points={{261,150},
              {270,150},{270,30}},               color={0,0,127}));
      connect(criticalDamping1.y, Hall1.intGains[2]) annotation (Line(points={{261,178},
              {270,178},{270,28}},               color={0,0,127}));
      connect(criticalDamping.y, Hall1.intGains[1]) annotation (Line(points={{261,206},
              {270,206},{270,26}},               color={0,0,127}));
      connect(Table_machine4.y[1], criticalDamping4.u)
        annotation (Line(points={{13,178},{20,178}}, color={0,0,127}));
      connect(Table_Light4.y[1], criticalDamping5.u)
        annotation (Line(points={{13,150},{20,150}}, color={0,0,127}));
      connect(Table_Humans4.y[1], criticalDamping3.u)
        annotation (Line(points={{13,206},{20,206}}, color={0,0,127}));
      connect(criticalDamping5.y, Hall2.intGains[3])
        annotation (Line(points={{43,150},{54,150},{54,30}}, color={0,0,127}));
      connect(criticalDamping4.y, Hall2.intGains[2])
        annotation (Line(points={{43,178},{54,178},{54,28}}, color={0,0,127}));
      connect(criticalDamping3.y, Hall2.intGains[1])
        annotation (Line(points={{43,206},{54,206},{54,26}}, color={0,0,127}));
      connect(Table_Humans1.y[1], criticalDamping6.u)
        annotation (Line(points={{445,204},{456,204}}, color={0,0,127}));
      connect(Table_machine1.y[1], criticalDamping8.u)
        annotation (Line(points={{445,176},{458,176}}, color={0,0,127}));
      connect(Table_Light1.y[1], criticalDamping7.u) annotation (Line(points={{445,148},
              {458,148}},                          color={0,0,127}));
      connect(criticalDamping7.y, Office1.intGains[3]) annotation (Line(points={{481,148},
              {490,148},{490,30}},                                       color={0,0,
              127}));
      connect(criticalDamping8.y, Office1.intGains[2]) annotation (Line(points={{481,176},
              {490,176},{490,28}},                   color={0,0,127}));
      connect(criticalDamping6.y, Office1.intGains[1]) annotation (Line(points={{479,204},
              {490,204},{490,26}},                   color={0,0,127}));
      connect(Table_Humans2.y[1], criticalDamping9.u)
        annotation (Line(points={{667,204},{682,204}}, color={0,0,127}));
      connect(Table_machine2.y[1], criticalDamping11.u)
        annotation (Line(points={{667,176},{682,176}}, color={0,0,127}));
      connect(Table_Light2.y[1], criticalDamping10.u)
        annotation (Line(points={{667,148},{682,148}}, color={0,0,127}));
      connect(criticalDamping10.y, Office2.intGains[3]) annotation (Line(points={{705,148},
              {712,148},{712,30},{711.8,30}},          color={0,0,127}));
      connect(criticalDamping11.y, Office2.intGains[2]) annotation (Line(points={{705,176},
              {712,176},{712,28},{711.8,28}},          color={0,0,127}));
      connect(criticalDamping9.y, Office2.intGains[1]) annotation (Line(points={{705,204},
              {712,204},{712,26},{711.8,26}},                              color={0,
              0,127}));
      connect(Table_Humans3.y[1], criticalDamping12.u)
        annotation (Line(points={{887,204},{898,204}}, color={0,0,127}));
      connect(Table_machine3.y[1], criticalDamping14.u)
        annotation (Line(points={{887,176},{898,176}}, color={0,0,127}));
      connect(Table_Light3.y[1], criticalDamping13.u)
        annotation (Line(points={{887,148},{898,148}}, color={0,0,127}));
      connect(criticalDamping13.y, Office3.intGains[3]) annotation (Line(points={{921,148},
              {928,148},{928,32},{928.2,32}},          color={0,0,127}));
      connect(criticalDamping14.y, Office3.intGains[2]) annotation (Line(points={{921,176},
              {928,176},{928,30},{928.2,30}},                              color={0,
              0,127}));
      connect(criticalDamping12.y, Office3.intGains[1]) annotation (Line(points={{921,204},
              {928,204},{928,28},{928.2,28}},          color={0,0,127}));
      connect(infiltration_rate_hall2.y, Hall2.ventRate) annotation (Line(points={{-63,180},
              {-60,180},{-60,49},{-34,49}},          color={0,0,127}));
      connect(weaBus, Hall2.weaBus) annotation (Line(
          points={{-116,44},{-78,44},{-78,100},{-36,100}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus, Hall1.weaBus) annotation (Line(
          points={{-116,44},{164,44},{164,100},{180,100}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus, Office1.weaBus) annotation (Line(
          points={{-116,44},{380,44},{380,100},{400,100}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus, Office2.weaBus) annotation (Line(
          points={{-116,44},{598,44},{598,100},{620,100}},
          color={255,204,51},
          thickness=0.5));
      connect(Office3.weaBus, weaBus) annotation (Line(
          points={{840,102},{818,102},{818,44},{-116,44}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus, Office4.weaBus) annotation (Line(
          points={{-116,44},{1042,44},{1042,100},{1060,100}},
          color={255,204,51},
          thickness=0.5));
      connect(Office5.weaBus, weaBus) annotation (Line(
          points={{1278,100},{1262,100},{1262,44},{-116,44}},
          color={255,204,51},
          thickness=0.5));
      connect(Hall2.ventTemp, weaBus.TDryBul) annotation (Line(points={{-34,62},{
              -74,62},{-74,44},{-116,44}}, color={0,0,127}));
      connect(Hall1.ventTemp, weaBus.TDryBul) annotation (Line(points={{182,62},{
              162,62},{162,44},{-116,44}}, color={0,0,127}));
      connect(Office1.ventTemp, weaBus.TDryBul) annotation (Line(points={{402,62},
              {380,62},{380,44},{-116,44}}, color={0,0,127}));
      connect(Office3.ventTemp, weaBus.TDryBul) annotation (Line(points={{841.96,
              64},{792,64},{792,44},{-116,44}}, color={0,0,127}));
      connect(weaDat.weaBus, weaBus) annotation (Line(
          points={{-140,52},{-130,52},{-130,44},{-116,44}},
          color={255,204,51},
          thickness=0.5));
      connect(Office2.ventTemp, weaBus.TDryBul) annotation (Line(points={{622.04,
              62},{254,62},{254,44},{-116,44}}, color={0,0,127}));
      connect(Office4.ventTemp, weaBus.TDryBul) annotation (Line(points={{1062,62},
              {1036,62},{1036,44},{-116,44}}, color={0,0,127}));
      connect(Office5.ventTemp, weaBus.TDryBul) annotation (Line(points={{1280,62},
              {1244,62},{1244,44},{-116,44}}, color={0,0,127}));
      connect(distributeBus_Buildings.control_buildings.Office1_Air_m, controlBus.Office1_Air_m)
        annotation (Line(
          points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
          color={255,204,51},
          thickness=0.5));
      connect(distributeBus_Buildings.control_buildings.Office2_Air_m, controlBus.Office2_Air_m)
        annotation (Line(
          points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
          color={255,204,51},
          thickness=0.5));
      connect(distributeBus_Buildings.control_buildings.Office3_Air_m, controlBus.Office3_Air_m)
        annotation (Line(
          points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
          color={255,204,51},
          thickness=0.5));
      connect(distributeBus_Buildings.control_buildings.Office4_Air_m, controlBus.Office4_Air_m)
        annotation (Line(
          points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
          color={255,204,51},
          thickness=0.5));
      connect(distributeBus_Buildings.control_buildings.Office5_Air_m, controlBus.Office5_Air_m)
        annotation (Line(
          points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
          color={255,204,51},
          thickness=0.5));
      connect(distributeBus_Buildings.control_buildings.Hall1_Air_m, controlBus.Hall1_Air_m)
        annotation (Line(
          points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
          color={255,204,51},
          thickness=0.5));
      connect(distributeBus_Buildings.control_buildings.Hall2_Air_m, controlBus.Hall2_Air_m)
        annotation (Line(
          points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
          color={255,204,51},
          thickness=0.5));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,0},
                {1460,280}}), graphics={
            Rectangle(
              extent={{-58,262},{1448,0}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-8,252},{152,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{166,252},{326,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{340,252},{500,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{510,252},{670,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{682,252},{842,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{856,252},{1016,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{1032,252},{1192,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{1210,252},{1370,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-44,72},{130,8}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="Hall2"),
            Text(
              extent={{154,72},{328,8}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="Hall1"),
            Text(
              extent={{310,66},{584,8}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O1"),
            Text(
              extent={{528,66},{802,8}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O2"),
            Text(
              extent={{754,70},{1028,12}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O3"),
            Text(
              extent={{968,72},{1242,14}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O4"),
            Text(
              extent={{1192,72},{1466,14}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O5")}),
                               Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-160,0},{1460,280}}), graphics={
            Rectangle(extent={{120,220},{340,10}},  lineColor={0,0,0}),
            Rectangle(extent={{-100,220},{120,10}}, lineColor={0,0,0}),
            Rectangle(extent={{340,220},{560,10}},  lineColor={0,0,0}),
            Rectangle(extent={{560,220},{780,10}},  lineColor={0,0,0}),
            Rectangle(extent={{780,220},{1000,10}}, lineColor={0,0,0}),
            Rectangle(extent={{1000,220},{1220,10}},lineColor={0,0,0}),
            Rectangle(extent={{1220,220},{1440,10}},lineColor={0,0,0})}));
    end Buildings_Test_Hall_EON_ERC;

    model Buildings

       replaceable package MediumWater =
          AixLib.Media.Water
        "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
      replaceable package MediumAir =
          AixLib.Media.Air
        "Medium in the system" annotation(choicesAllMatching=true);

            //AWin={5,0,0,0,5},
            //AExt={0,175,140,175,0},

            //withAirCap=true,
            //AWin={0,2,0,2,0},
            //AExt={0,320,90,310,0},

       AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office5(
        redeclare package Medium = AixLib.Media.Air,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=60,
            AZone=18,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,6,0,0},
            ATransparent={0,0,6,0,0},
            AExt={0,28,0,0,0},
            nExt=1,
            AInt=42,
            nInt=1,
            AFloor=37,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=true),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        use_MechanicalAirExchange=true,
        T_start=295.35,
        nPorts=2)       "Thermal zone"
        annotation (Placement(transformation(extent={{1316,120},{1416,220}})));
      AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
        calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
        computeWetBulbTemperature=false,
        filNam=ModelicaServices.ExternalReferences.loadResource("modelica://Testhall/DataBase/Weather/DEU_Dusseldorf.104000_IWEC.mos"))
        annotation (Placement(transformation(extent={{-232,160},{-212,180}})));

      Modelica.Blocks.Sources.Constant ventRate5(each k=0)
        annotation (Placement(transformation(extent={{1250,228},{1270,248}})));
      AixLib.BoundaryConditions.WeatherData.Bus     weaBus annotation (Placement(
            transformation(extent={{-198,152},{-178,172}}),
                                                          iconTransformation(extent=
               {{0,0},{0,0}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office5[2](
          redeclare package Medium = AixLib.Media.Air)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{1336,102},{1410,122}}),
            iconTransformation(extent={{1294,-12},{1368,8}})));
      Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus control_building
        annotation (Placement(transformation(extent={{664,22},{684,42}}),     iconTransformation(extent={{-48,56},
                {-28,76}})));
      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office4(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=120,
            AZone=37,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,12,0,0},
            ATransparent={0,0,12,0,0},
            AExt={0,30,0,0,0},
            nExt=1,
            AInt=100,
            nInt=1,
            AFloor=37,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=true),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        use_MechanicalAirExchange=true,
        nPorts=2,
        T_start=295.35) "Thermal zone"
        annotation (Placement(transformation(extent={{1094,120},{1194,220}})));
      Modelica.Blocks.Sources.Constant ventRate4(each k=0)
        annotation (Placement(transformation(extent={{1038,228},{1058,248}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office4[2](
          redeclare package Medium = AixLib.Media.Air)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{1110,96},{1184,116}}),
            iconTransformation(extent={{1068,-8},{1142,12}})));
      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office3(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=60,
            AZone=18,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,6,0,0},
            ATransparent={0,0,6,0,0},
            AExt={0,0,14,0,0},
            nExt=1,
            AInt=60,
            nInt=1,
            AFloor=18,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=true),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        use_MechanicalAirExchange=true,
        nPorts=2,
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{908,120},{1006,220}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office3[2](
          redeclare package Medium = AixLib.Media.Air)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{920,90},{994,110}}),
            iconTransformation(extent={{854,-10},{928,10}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans3(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,
            0.12; 64800,0.12; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{894,-22},{914,-2}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light3(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{894,-78},{914,-58}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine3(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
        annotation (Placement(transformation(extent={{894,-50},{914,-30}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping12(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{928,-22},{948,-2}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping13(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{928,-78},{948,-58}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping14(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{928,-50},{948,-30}})));
      Modelica.Blocks.Sources.Constant ventRate3(each k=0)
        annotation (Placement(transformation(extent={{842,238},{862,258}})));
      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office2(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=60,
            AZone=18,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,6,0,0},
            ATransparent={0,0,6,0,0},
            AExt={0,0,14,0,0},
            nExt=1,
            AInt=50,
            nInt=1,
            AFloor=18,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=true),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        use_MechanicalAirExchange=true,
        nPorts=2,
        machinesSenHea(areaSurfaceMachinesTotal=0.1),
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{692,120},{794,220}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office2[2](
          redeclare package Medium = AixLib.Media.Air)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{702,96},{776,116}}),
            iconTransformation(extent={{622,-12},{696,8}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans2(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,
            0.12; 64800,0.12; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{710,-20},{730,0}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light2(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{710,-76},{730,-56}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine2(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
        annotation (Placement(transformation(extent={{710,-48},{730,-28}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping9(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{748,-20},{768,0}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping10(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{748,-76},{768,-56}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping11(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{748,-48},{768,-28}})));
      Modelica.Blocks.Sources.Constant ventRate2(each k=0)
        annotation (Placement(transformation(extent={{638,234},{658,254}})));
      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office1(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=60,
            AZone=18,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,6,0,0},
            ATransparent={0,0,6,0,0},
            AExt={0,15,12,0,0},
            nExt=1,
            AInt=45,
            nInt=1,
            AFloor=16,
            nFloor=1,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=false),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        use_MechanicalAirExchange=true,
        nPorts=2,
        machinesSenHea(areaSurfaceMachinesTotal=0.1),
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{486,120},{586,220}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office1[2](
          redeclare package Medium = AixLib.Media.Air)
        "Auxilliary fluid inlets and outlets to indoor air volume"
        annotation (Placement(transformation(extent={{500,98},{574,118}}),
            iconTransformation(extent={{406,-12},{480,8}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans1(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.04; 43200,0.04; 43260,0.04; 46800,0.04; 46860,
            0.04; 64800,0.04; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{486,-24},{506,-4}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light1(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{486,-80},{506,-60}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine1(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
        annotation (Placement(transformation(extent={{486,-52},{506,-32}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping6(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{520,-24},{540,-4}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping7(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{522,-80},{542,-60}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping8(
        n=3,
        f=0.01,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{522,-52},{542,-32}})));
      Modelica.Blocks.Sources.Constant ventRate1(each k=0)
        annotation (Placement(transformation(extent={{430,222},{450,242}})));
          AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Hall1(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=5000,
            AZone=500,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,0,0,0},
            ATransparent={0,0,0,0,0},
            AExt={0,0,0,0,0},
            nExt=1,
            AInt=140,
            nInt=1,
            AFloor=640,
            nFloor=1,
            ARoof=790,
            nRoof=1,
            nOrientationsRoof=1,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=false),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        use_MechanicalAirExchange=true,
        nPorts=2,
        machinesSenHea(areaSurfaceMachinesTotal=50),
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{278,120},{378,220}})));
      Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_hall1[2](
          redeclare package Medium = AixLib.Media.Air)
        "Auxilliary fluid inlets and outlets to indoor air volume" annotation (
          Placement(transformation(extent={{290,100},{364,120}}),
            iconTransformation(extent={{198,-12},{272,8}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.2; 43200,0.2; 43260,0.2; 46800,0.2; 46860,0.2;
            64800,0.2; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{282,-24},{302,-4}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{282,-80},{302,-60}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0.5; 28740,0.5; 28800,0.5; 64800,0.5; 64860,0.5; 86400,0.5])
        annotation (Placement(transformation(extent={{282,-52},{302,-32}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
        f=0.0005,
        n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{320,-24},{340,-4}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping1(
        f=0.0005,
        n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{320,-52},{340,-32}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping2(
        f=0.0005,
        n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{320,-80},{340,-60}})));
      Modelica.Blocks.Sources.Constant ventRate_hall1(each k=0)
        annotation (Placement(transformation(extent={{230,228},{250,248}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_port_rad_hall1
        "Radiative internal gains"
        annotation (Placement(transformation(extent={{388,-8},{408,12}}),
            iconTransformation(extent={{290,-8},{310,12}})));
        AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone Hall2(
        redeclare package Medium = MediumAir,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
            VAir=3000,
            AZone=300,
            lat=1.77,
            nOrientations=5,
            AWin={0,0,0,0,0},
            ATransparent={0,0,0,0,0},
            RWin=0.0177,
            gWin=0.78,
            UWin=2.1,
            ratioWinConRad=0.09,
            AExt={0,0,0,0,0},
            nExt=1,
            AInt=140,
            nInt=1,
            AFloor=380,
            nFloor=1,
            ARoof=380,
            nRoof=1,
            nOrientationsRoof=1,
            specificPeople=1,
            activityDegree=3,
            fixedHeatFlowRatePersons=80,
            useConstantACHrate=false,
            withAHU=false,
            HeaterOn=false,
            CoolerOn=false,
            withIdealThresholds=false),
        ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          indoorPortExtWalls=false,
          indoorPortIntWalls=true),
        redeclare model corG =
            AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
        use_MechanicalAirExchange=true,
        nPorts=1,
        machinesSenHea(areaSurfaceMachinesTotal=10),
        T_start=291.15) "Thermal zone"
        annotation (Placement(transformation(extent={{-18,120},{82,220}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Humans4(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12;
            46860,0.12; 64800,0.12; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_Light4(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
        annotation (Placement(transformation(extent={{-8,-84},{12,-64}})));
      Modelica.Blocks.Sources.CombiTimeTable Table_machine4(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0.5; 28740,0.5; 28800,0.5; 64800,0.5; 64860,0.5; 86400,0.5])
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping3(
        f=0.0005,
        n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{22,-28},{42,-8}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping4(
        f=0.0005,
        n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{22,-56},{42,-36}})));
      Modelica.Blocks.Continuous.CriticalDamping criticalDamping5(
        f=0.0005,
        n=3,
        x_start={0,0,0})
        annotation (Placement(transformation(extent={{22,-84},{42,-64}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_port_rad_hall2
        "Radiative internal gains"
        annotation (Placement(transformation(extent={{94,-12},{114,8}}),
            iconTransformation(extent={{30,-8},{50,12}})));
      Modelica.Blocks.Sources.Constant ventRate_hall2(each k=0)
        annotation (Placement(transformation(extent={{-82,238},{-62,258}})));
      AixLib.Fluid.Sources.Boundary_ph     AirOut_Hall2(
        redeclare package Medium = MediumAir,
        nPorts=1,
        p=100000) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-48,84})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe_out_hall2(
        redeclare package Medium = MediumAir,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        length=1,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-4,84})));
    equation

      connect(weaDat.weaBus,weaBus)  annotation (Line(
          points={{-212,170},{-202,170},{-202,162},{-188,162}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus,Office5. weaBus) annotation (Line(
          points={{-188,162},{-142,162},{-142,200},{1316,200}},
          color={255,204,51},
          thickness=0.5));
      connect(ventRate5.y, Office5.ventRate) annotation (Line(points={{1271,238},{1296,
              238},{1296,149},{1318,149}}, color={0,0,127}));
      connect(weaBus.TDryBul,Office5. ventTemp) annotation (Line(
          points={{-188,162},{1318,162}},
          color={255,204,51},
          thickness=0.5));
      connect(Office5.ports[1:2], ports_office5) annotation (Line(points={{1371.88,
              134},{1373,134},{1373,112}},          color={0,127,255}));
      connect(Office5.TAir, control_building.Office5_Air_m)
        annotation (Line(points={{1421,210},{1452.5,210},{1452.5,32},{674,32}},    color={0,0,127}));
      connect(distributeBus_Buildings.control_building, control_building)
        annotation (Line(
          points={{672.1,2.1},{674,2.1},{674,32}},
          color={255,204,51},
          thickness=0.5));
      connect(ventRate4.y, Office4.ventRate) annotation (Line(points={{1059,238},{1059,
              148},{1092,148},{1092,150},{1096,150},{1096,149}}, color={0,0,127}));
      connect(weaBus, Office4.weaBus) annotation (Line(
          points={{-188,162},{-142,162},{-142,200},{1094,200}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus.TDryBul, Office4.ventTemp) annotation (Line(
          points={{-188,162},{1096,162}},
          color={255,204,51},
          thickness=0.5));
      connect(ports_office4, Office4.ports[1:2]) annotation (Line(points={{1147,106},
              {1147,134},{1149.88,134}}, color={0,127,255}));
      connect(Office4.TAir, control_building.Office4_Air_m) annotation (Line(
            points={{1199,210},{1257.5,210},{1257.5,32},{674,32}}, color={0,0,127}));
      connect(ports_office3, Office3.ports[1:2]) annotation (Line(points={{957,100},
              {957,134},{962.757,134}}, color={0,127,255}));
      connect(weaBus, Office3.weaBus) annotation (Line(
          points={{-188,162},{-142,162},{-142,200},{908,200}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus.TDryBul, Office3.ventTemp) annotation (Line(
          points={{-188,162},{909.96,162}},
          color={255,204,51},
          thickness=0.5));
      connect(Table_Humans3.y[1],criticalDamping12. u)
        annotation (Line(points={{915,-12},{926,-12}}, color={0,0,127}));
      connect(Table_machine3.y[1],criticalDamping14. u)
        annotation (Line(points={{915,-40},{926,-40}}, color={0,0,127}));
      connect(Table_Light3.y[1],criticalDamping13. u)
        annotation (Line(points={{915,-68},{926,-68}}, color={0,0,127}));
      connect(criticalDamping12.y, Office3.intGains[1]) annotation (Line(points={{949,-12},
              {996,-12},{996,126},{996.2,126}},      color={0,0,127}));
      connect(criticalDamping14.y, Office3.intGains[2]) annotation (Line(points={{949,
              -40},{996,-40},{996,128},{996.2,128}}, color={0,0,127}));
      connect(criticalDamping13.y, Office3.intGains[3]) annotation (Line(points={{949,-68},
              {996,-68},{996,130},{996.2,130}},      color={0,0,127}));
      connect(ventRate3.y, Office3.ventRate) annotation (Line(points={{863,248},{878,
              248},{878,149},{909.96,149}}, color={0,0,127}));
      connect(Office3.TAir, control_building.Office3_Air_m) annotation (Line(
            points={{1010.9,210},{1042,210},{1042,32},{674,32}}, color={0,0,127}));
      connect(Office2.ports[1:2], ports_office2) annotation (Line(points={{748.993,
              134},{748.993,130},{739,130},{739,106}},
                                                  color={0,127,255}));
      connect(Table_Humans2.y[1],criticalDamping9. u)
        annotation (Line(points={{731,-10},{746,-10}}, color={0,0,127}));
      connect(Table_machine2.y[1],criticalDamping11. u)
        annotation (Line(points={{731,-38},{746,-38}}, color={0,0,127}));
      connect(Table_Light2.y[1],criticalDamping10. u)
        annotation (Line(points={{731,-66},{746,-66}}, color={0,0,127}));
      connect(criticalDamping9.y, Office2.intGains[1]) annotation (Line(points={{769,-10},
              {784,-10},{784,126},{783.8,126}},      color={0,0,127}));
      connect(criticalDamping11.y, Office2.intGains[2]) annotation (Line(points={{769,
              -38},{769,-40},{783.8,-40},{783.8,128}}, color={0,0,127}));
      connect(criticalDamping10.y, Office2.intGains[3]) annotation (Line(points={{769,-66},
              {769,-65},{783.8,-65},{783.8,130}},      color={0,0,127}));
      connect(ventRate2.y, Office2.ventRate) annotation (Line(points={{659,244},{672,
              244},{672,149},{694.04,149}}, color={0,0,127}));
      connect(weaBus, Office2.weaBus) annotation (Line(
          points={{-188,162},{-142,162},{-142,200},{692,200}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus.TDryBul, Office2.ventTemp) annotation (Line(
          points={{-188,162},{252,162},{252,162},{694.04,162}},
          color={255,204,51},
          thickness=0.5));
      connect(Office2.TAir, control_building.Office2_Air_m) annotation (Line(
            points={{799.1,210},{828,210},{828,32},{674,32}}, color={0,0,127}));
      connect(ports_office1, Office1.ports[1:2]) annotation (Line(points={{537,108},
              {541.875,108},{541.875,134}},
                                          color={0,127,255}));
      connect(Table_Humans1.y[1],criticalDamping6. u)
        annotation (Line(points={{507,-14},{518,-14}}, color={0,0,127}));
      connect(Table_machine1.y[1],criticalDamping8. u)
        annotation (Line(points={{507,-42},{520,-42}}, color={0,0,127}));
      connect(Table_Light1.y[1],criticalDamping7. u) annotation (Line(points={{507,-70},
              {520,-70}},                          color={0,0,127}));
      connect(criticalDamping7.y, Office1.intGains[3]) annotation (Line(points={{543,-70},
              {576,-70},{576,130}},                                      color={0,0,
              127}));
      connect(criticalDamping8.y, Office1.intGains[2]) annotation (Line(points={{543,-42},
              {576,-42},{576,128}},                  color={0,0,127}));
      connect(criticalDamping6.y, Office1.intGains[1]) annotation (Line(points={{541,-14},
              {576,-14},{576,126}},                  color={0,0,127}));
      connect(ventRate1.y, Office1.ventRate) annotation (Line(points={{451,232},{451,
              150},{488,150},{488,149}}, color={0,0,127}));
      connect(Office1.TAir, control_building.Office1_Air_m) annotation (Line(
            points={{591,210},{632,210},{632,32},{674,32}}, color={0,0,127}));
      connect(weaBus, Office1.weaBus) annotation (Line(
          points={{-188,162},{-142,162},{-142,200},{486,200}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus.TDryBul, Office1.ventTemp) annotation (Line(
          points={{-188,162},{488,162}},
          color={255,204,51},
          thickness=0.5));
      connect(ports_hall1, Hall1.ports[1:2]) annotation (Line(points={{327,110},{
              327,121},{333.875,121},{333.875,134}},
                                               color={0,127,255}));
      connect(Table_Humans.y[1],criticalDamping. u)
        annotation (Line(points={{303,-14},{318,-14}}, color={0,0,127}));
      connect(Table_Light.y[1],criticalDamping2. u)
        annotation (Line(points={{303,-70},{318,-70}}, color={0,0,127}));
      connect(Table_machine.y[1],criticalDamping1. u)
        annotation (Line(points={{303,-42},{318,-42}}, color={0,0,127}));
      connect(criticalDamping.y, Hall1.intGains[1])
        annotation (Line(points={{341,-14},{368,-14},{368,126}}, color={0,0,127}));
      connect(criticalDamping1.y, Hall1.intGains[2])
        annotation (Line(points={{341,-42},{368,-42},{368,128}}, color={0,0,127}));
      connect(criticalDamping2.y, Hall1.intGains[3])
        annotation (Line(points={{341,-70},{368,-70},{368,130}}, color={0,0,127}));
      connect(ventRate_hall1.y, Hall1.ventRate) annotation (Line(points={{251,238},
              {251,148},{280,148},{280,149}}, color={0,0,127}));
      connect(weaBus, Hall1.weaBus) annotation (Line(
          points={{-188,162},{-142,162},{-142,200},{278,200}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus.TDryBul, Hall1.ventTemp) annotation (Line(
          points={{-188,162},{280,162}},
          color={255,204,51},
          thickness=0.5));
      connect(Hall1.TAir, control_building.Hall1_Air_m) annotation (Line(points={{383,210},
              {430.5,210},{430.5,32},{674,32}},           color={0,0,127}));
      connect(Hall1.intGainsRad, heat_port_rad_hall1) annotation (Line(points={{379,
              187},{379,187.5},{398,187.5},{398,2}}, color={191,0,0}));
      connect(Table_machine4.y[1],criticalDamping4. u)
        annotation (Line(points={{13,-46},{20,-46}}, color={0,0,127}));
      connect(Table_Light4.y[1],criticalDamping5. u)
        annotation (Line(points={{13,-74},{20,-74}}, color={0,0,127}));
      connect(Table_Humans4.y[1],criticalDamping3. u)
        annotation (Line(points={{13,-18},{20,-18}}, color={0,0,127}));
      connect(criticalDamping5.y, Hall2.intGains[3])
        annotation (Line(points={{43,-74},{72,-74},{72,130}},color={0,0,127}));
      connect(criticalDamping4.y, Hall2.intGains[2])
        annotation (Line(points={{43,-46},{72,-46},{72,128}},color={0,0,127}));
      connect(criticalDamping3.y, Hall2.intGains[1])
        annotation (Line(points={{43,-18},{72,-18},{72,126}},color={0,0,127}));
      connect(Hall2.intGainsRad, heat_port_rad_hall2) annotation (Line(points={{83,
              187},{83,185.5},{104,185.5},{104,-2}}, color={191,0,0}));
      connect(weaBus, Hall2.weaBus) annotation (Line(
          points={{-188,162},{-142,162},{-142,200},{-18,200}},
          color={255,204,51},
          thickness=0.5));
      connect(weaBus.TDryBul, Hall2.ventTemp) annotation (Line(
          points={{-188,162},{-16,162}},
          color={255,204,51},
          thickness=0.5));
      connect(ventRate_hall2.y, Hall2.ventRate) annotation (Line(points={{-61,248},
              {-40,248},{-40,149},{-16,149}}, color={0,0,127}));
      connect(Hall2.TAir, control_building.Hall2_Air_m) annotation (Line(points={{87,210},
              {164,210},{164,32},{674,32}},          color={0,0,127}));
      connect(pipe_out_hall2.port_b,AirOut_Hall2. ports[1])
        annotation (Line(points={{-14,84},{-38,84}}, color={0,127,255}));
      connect(pipe_out_hall2.port_a, Hall2.ports[1])
        annotation (Line(points={{6,84},{32,84},{32,134}}, color={0,127,255}));
      connect(criticalDamping12.y, Office4.intGains[1]) annotation (Line(points={{
              949,-12},{996,-12},{996,76},{1204,76},{1204,126},{1184,126}}, color={
              0,0,127}));
      connect(criticalDamping14.y, Office4.intGains[2]) annotation (Line(points={{
              949,-40},{949,-28},{996,-28},{996,76},{1204,76},{1204,128},{1184,128}},
            color={0,0,127}));
      connect(criticalDamping13.y, Office4.intGains[3]) annotation (Line(points={{
              949,-68},{949,-28},{996,-28},{996,76},{1204,76},{1204,130},{1184,130}},
            color={0,0,127}));
      connect(criticalDamping12.y, Office5.intGains[1]) annotation (Line(points={{
              949,-12},{996,-12},{996,76},{1204,76},{1204,78},{1420,78},{1420,126},
              {1406,126}}, color={0,0,127}));
      connect(criticalDamping14.y, Office5.intGains[2]) annotation (Line(points={{
              949,-40},{949,-28},{996,-28},{996,76},{1420,76},{1420,128},{1406,128}},
            color={0,0,127}));
      connect(criticalDamping13.y, Office5.intGains[3]) annotation (Line(points={{
              949,-68},{949,-28},{996,-28},{996,76},{1420,76},{1420,130},{1406,130}},
            color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,0},
                {1460,280}}), graphics={
            Rectangle(
              extent={{-58,262},{1448,0}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-8,252},{152,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{166,252},{326,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{340,252},{500,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{510,252},{670,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{682,252},{842,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{856,252},{1016,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{1032,252},{1192,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{1210,252},{1370,214}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-44,72},{130,8}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="Hall2"),
            Text(
              extent={{154,72},{328,8}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="Hall1"),
            Text(
              extent={{310,66},{584,8}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O1"),
            Text(
              extent={{528,66},{802,8}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O2"),
            Text(
              extent={{754,70},{1028,12}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O3"),
            Text(
              extent={{968,72},{1242,14}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O4"),
            Text(
              extent={{1192,72},{1466,14}},
              lineColor={0,0,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              fontSize=11,
              textString="O5")}),
                               Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-160,0},{1460,280}})));
    end Buildings;
  end Consumers;

  package CPH "Ceiling panel heater"
    model CPH

      AixLib.Systems.HydraulicModules.Injection2WayValve cph_Valve(redeclare
          package Medium =
            AixLib.Media.Water,
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=1.2,
        m_flow_nominal=0.54,
         redeclare
              AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
              PumpInterface(pump(redeclare
                  AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        pipe1(length=0.4),
        pipe2(length=0.1),
        pipe3(length=1),
        pipe5(length=0.15),
        pipe4(length=1),
        pipe6(length=0.15),
        pipe7(length=0.3),
        T_amb=273.15 + 10,
        T_start=343.15) annotation (Placement(transformation(
            extent={{-50,-50},{49.9999,49.9999}},
            rotation=90,
            origin={-4,-116})));

      /**Pumpe Original: Wilo Stratos 25/1to6**/

      AixLib.Systems.HydraulicModules.Throttle cph_Throttle(
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        Kv=8,
        m_flow_nominal=0.54,
        redeclare package Medium = AixLib.Media.Water,
        pipe1(length=1),
        pipe2(length=30, fac=2),
        pipe3(length=30),
        T_amb=273.15 + 10,
        T_start=343.15) annotation (Placement(transformation(
            extent={{-31,-31},{31,31}},
            rotation=90,
            origin={-7,15})));
      Components.RadiantCeilingPanelHeater radiantCeilingPanelHeater(
        genericPipe(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_18x1(),
          length=17.2,
          m_flow_nominal=0.54),
        redeclare package Medium = AixLib.Media.Water,
        nNodes=3,
        each Gr=27) annotation (Placement(transformation(extent={{-34,58},{22,120}})));

      Modelica.Fluid.Interfaces.FluidPort_a cph_supprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{-44,-208},{-24,
                -188}}), iconTransformation(extent={{-86,-210},{-66,-190}})));
      Modelica.Fluid.Interfaces.FluidPort_b cph_retprim(redeclare package
          Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{16,-208},{36,
                -188}}), iconTransformation(extent={{2,-212},{22,-192}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_port_CPH
        annotation (Placement(transformation(extent={{-16,108},{4,128}}),
            iconTransformation(extent={{-38,70},{-18,90}})));
      AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
            AixLib.Media.Water) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={-32,-40})));
      DistributeBus distributeBus annotation (Placement(transformation(extent={
                {-176,-46},{-146,-10}}), iconTransformation(extent={{-176,-46},
                {-146,-10}})));
    equation
      connect(cph_Throttle.port_b2, cph_Valve.port_a2) annotation (Line(points={{11.6,
              -16},{10,-16},{10,-56},{26,-56},{26,-66.0001}},  color={0,127,255}));
      connect(radiantCeilingPanelHeater.port_b1,heat_port_CPH)
        annotation (Line(points={{-6,100.78},{-6,109.39},{-6,109.39},{-6,118}},
                                                      color={191,0,0}));
      connect(cph_supprim, cph_Valve.port_a1) annotation (Line(points={{-34,
              -198},{-34,-183},{-33.9999,-183},{-33.9999,-166}},
                                                          color={0,127,255}));
      connect(cph_retprim, cph_Valve.port_b2) annotation (Line(points={{26,-198},
              {26,-182},{26,-166},{26,-166}},color={0,127,255}));
      connect(cph_Throttle.port_a2, radiantCeilingPanelHeater.radiantcph_ret)
        annotation (Line(points={{11.6,46},{10,46},{10,54},{26,54},{26,88},{24,88},
              {24,89},{22,89}}, color={0,127,255}));
      connect(cph_Throttle.port_b1, radiantCeilingPanelHeater.radiantcph_sup)
        annotation (Line(points={{-25.6,46},{-24,46},{-24,54},{-42,54},{-42,89},{
              -34,89}}, color={0,127,255}));
      connect(senMasFlo.port_b, cph_Throttle.port_a1) annotation (Line(points={{-32,
              -30},{-32,-16},{-25.6,-16}}, color={0,127,255}));
      connect(senMasFlo.port_a, cph_Valve.port_b1) annotation (Line(points={{-32,-50},
              {-33.9999,-50},{-33.9999,-66.0001}},      color={0,127,255}));
      connect(cph_Valve.hydraulicBus, distributeBus.bus_cph) annotation (Line(
          points={{-53.9999,-116},{-142,-116},{-142,-27.91},{-160.925,-27.91}},

          color={255,204,51},
          thickness=0.5));
      connect(cph_Throttle.hydraulicBus, distributeBus.bus_cph_throttle)
        annotation (Line(
          points={{-38,15},{-38,14},{-138,14},{-138,-27.91},{-160.925,-27.91}},

          color={255,204,51},
          thickness=0.5));
      connect(senMasFlo.m_flow, distributeBus.bus_cph.mflow) annotation (Line(
            points={{-43,-40},{-140,-40},{-140,-28},{-161,-28}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                -200},{100,120}}),graphics={
            Rectangle(
              extent={{-160,82},{102,-200}},
              lineColor={0,0,0},
              fillColor={212,212,212},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-94,-76},{36,-108}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-68,-110},{-68,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{-48,-110},{-48,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{-28,-110},{-28,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{-8,-110},{-8,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{12,-110},{12,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{32,-110},{32,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Text(
              extent={{-80,32},{18,-48}},
              textColor={0,0,0},
              textString="CPH"),
            Line(
              points={{-90,-110},{-90,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-160,-200},{100,120}})),
        experiment(StopTime=7200, __Dymola_Algorithm="Dassl"));
    end CPH;

    model CPH_calib

        replaceable package MediumWater =
          AixLib.Media.Water
        "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
      replaceable package MediumAir =
          AixLib.Media.Air
        "Medium in the system" annotation(choicesAllMatching=true);
      Modelica.Units.SI.VolumeFlowRate VolFlowBypass=(hydraulicBus.VFlowOutMea*
          hydraulicBus.TFwrdOutMea - hydraulicBus.VFlowInMea*hydraulicBus.TFwrdInMea)
          /hydraulicBus.TRtrnInMea
        "Volumenstrom des Bypass nach der Richmannschen Mischungsregel für inkompressible Fluide";
      Real meaError(unit="") = ((hydraulicBus.VFlowOutMea-combiTimeTable.y[9])/combiTimeTable.y[9])*100 "Prozentuale Abweichung des Modelergebnis zum Sensorwert";
      Real modmeaError(unit="") = abs(meaError);
      AixLib.Fluid.Sources.Boundary_ph RetPrim(
        redeclare package Medium = AixLib.Media.Water,
        p=100000,
        nPorts=1) "fCPHTempRetPrimADS "
        annotation (Placement(transformation(extent={{66,-188},{46,-168}})));
      AixLib.Fluid.Sources.Boundary_pT SupPrim(
        redeclare package Medium = AixLib.Media.Water,
        p=113000,
        use_T_in=true,
        nPorts=1) "fCPHTempSupPrimADS "
        annotation (Placement(transformation(extent={{-80,-186},{-60,-166}})));
      AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
        annotation (Placement(transformation(extent={{-94,-110},{-74,-90}}),
            iconTransformation(extent={{0,0},{0,0}})));
      AixLib.Systems.HydraulicModules.Injection2WayValve cph_Valve(redeclare
          package Medium =
            MediumWater,
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        Kv=12,
        m_flow_nominal=2.3,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        pipe1(length=0.4),
        pipe2(length=0.1),
        pipe3(length=1),
        pipe5(length=0.15),
        pipe4(length=1),
        pipe6(length=0.15),
        pipe7(length=0.3),
        T_amb=273.15 + 10,
        T_start=343.15) annotation (Placement(transformation(
            extent={{-50,-50},{49.9999,49.9999}},
            rotation=90,
            origin={-4,-94})));

      AixLib.Systems.HydraulicModules.Throttle cph_Throttle(
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        Kv=8,
        m_flow_nominal=2.3,
        redeclare package Medium = MediumWater,
        pipe1(length=1),
        pipe2(length=30, fac=13),
        pipe3(length=30),
        T_amb=273.15 + 10,
        T_start=343.15) annotation (Placement(transformation(
            extent={{-31,-31},{31,31}},
            rotation=90,
            origin={-7,3})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-112,-86},{-92,-66}})));
      Components.RadiantCeilingPanelHeater radiantCeilingPanelHeater(
        genericPipe(diameter=0.020, length=17.2),
        redeclare package Medium = MediumWater,
        nNodes=3,
        each Gr=27)
        annotation (Placement(transformation(extent={{-34,38},{22,100}})));

      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=true,
        tableName="measurement",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        columns=2:9)  "1-TempOut, 2-TempRet, 3-TempRetPrim, 4-TempSup, 5-TempSupPrim, 6-PumpSpeed,7-VolFlow, 8-ValveSet"
        annotation (Placement(transformation(extent={{-158,-110},{-138,-90}})));
      AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus1
        annotation (Placement(transformation(extent={{-86,-8},{-66,12}}),
            iconTransformation(extent={{0,0},{0,0}})));
    equation
      connect(hydraulicBus, cph_Valve.hydraulicBus) annotation (Line(
          points={{-84,-100},{-68,-100},{-68,-94.0001},{-53.9999,-94.0001}},
          color={255,204,51},
          thickness=0.5));
      connect(cph_Valve.port_b2, RetPrim.ports[1]) annotation (Line(points={{26,-144},
              {26,-178},{46,-178}},       color={0,127,255}));
      connect(cph_Throttle.port_a1, cph_Valve.port_b1) annotation (Line(points={{-25.6,
              -28},{-32,-28},{-32,-44.0001},{-33.9999,-44.0001}},       color={0,
              127,255}));
      connect(cph_Throttle.port_b2, cph_Valve.port_a2) annotation (Line(points={{11.6,
              -28},{20,-28},{20,-44.0001},{26,-44.0001}},      color={0,127,255}));
      connect(SupPrim.ports[1], cph_Valve.port_a1) annotation (Line(points={{-60,
              -176},{-34,-176},{-34,-144},{-33.9999,-144}}, color={0,127,255}));
      connect(booleanExpression.y, hydraulicBus.pumpBus.onSet) annotation (Line(
            points={{-91,-76},{-83.95,-76},{-83.95,-99.95}},            color={255,
              0,255}));
      connect(cph_Throttle.port_b1, radiantCeilingPanelHeater.radiantcph_sup)
        annotation (Line(points={{-25.6,34},{-26,34},{-26,69},{-34,69}}, color={0,
              127,255}));
      connect(cph_Throttle.port_a2, radiantCeilingPanelHeater.radiantcph_ret)
        annotation (Line(points={{11.6,34},{16,34},{16,69},{22,69}}, color={0,127,
              255}));
      connect(combiTimeTable.y[6], hydraulicBus.pumpBus.rpmSet) annotation (Line(
            points={{-137,-100},{-110,-100},{-110,-99.95},{-83.95,-99.95}}, color={
              0,0,127}));
      connect(combiTimeTable.y[8], hydraulicBus.valveSet) annotation (Line(points={
              {-137,-100},{-110,-100},{-110,-99.95},{-83.95,-99.95}}, color={0,0,
              127}));
      connect(combiTimeTable.y[5], SupPrim.T_in) annotation (Line(points={{-137,
              -100},{-98,-100},{-98,-172},{-82,-172}}, color={0,0,127}));
      connect(cph_Throttle.hydraulicBus, hydraulicBus1) annotation (Line(
          points={{-38,3},{-38,2},{-76,2}},
          color={255,204,51},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                -200},{100,80}}), graphics={
            Rectangle(
              extent={{-160,82},{102,-200}},
              lineColor={0,0,0},
              fillColor={212,212,212},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-94,-76},{36,-108}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-68,-110},{-68,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{-48,-110},{-48,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{-28,-110},{-28,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{-8,-110},{-8,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{12,-110},{12,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{32,-110},{32,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Text(
              extent={{-80,32},{18,-48}},
              textColor={0,0,0},
              textString="CPH"),
            Line(
              points={{-90,-110},{-90,-130}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-160,-200},{100,80}})),
        experiment(StopTime=7200, __Dymola_Algorithm="Dassl"));
    end CPH_calib;

    package Components
      model RadiantCeilingPanelHeater

        replaceable package Medium = AixLib.Media.Water
          "Medium in the system" annotation (choicesAllMatching=true);

        parameter Integer nNodes "Number of elements";
        parameter Real Gr(unit="m2") = 1.5*18*0.9/nNodes
          "Net radiation conductance between two surfaces (see docu)";

        AixLib.Fluid.FixedResistances.GenericPipe
                                         genericPipe(
          nNodes=nNodes,
          redeclare package Medium = Medium,
          T_start=343.15)
          annotation (Dialog(enable=true), Placement(transformation(extent={{-12,-12},{12,12}})));
        Modelica.Fluid.Interfaces.FluidPort_b radiantcph_ret(redeclare package
            Medium =
              Medium)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a radiantcph_sup(redeclare package
            Medium =
              Medium)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation[nNodes](Gr=Gr)
                                  annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,36})));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=
              nNodes) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={0,68})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b1
          annotation (Placement(transformation(extent={{-10,28},{10,48}}),
              iconTransformation(extent={{-10,28},{10,48}})));
      equation
        connect(genericPipe.port_b, radiantcph_ret)
          annotation (Line(points={{12,0},{100,0}}, color={0,127,255}));
        connect(genericPipe.port_a, radiantcph_sup)
          annotation (Line(points={{-12,0},{-100,0}}, color={0,127,255}));
        connect(thermalCollector.port_a, bodyRadiation.port_b)
          annotation (Line(points={{0,58},{0,46}}, color={191,0,0}));
        connect(thermalCollector.port_b, port_b1)
          annotation (Line(points={{0,78},{0,38},{0,38}},
                                                   color={191,0,0}));
        connect(genericPipe.heatPort, bodyRadiation[nNodes].port_a)
          annotation (Line(points={{0,12},{0,26}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-60,10},{60,-10}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-50,-12},{-50,-32}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{-30,-12},{-30,-32}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{-10,-12},{-10,-32}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{10,-12},{10,-32}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{30,-12},{30,-32}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{50,-12},{50,-32}},
                color={255,128,0},
                pattern=LinePattern.Dash)}),                           Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end RadiantCeilingPanelHeater;
    end Components;
  end CPH;

  package Distributor
    model Distributor

       replaceable package MediumWater =
          AixLib.Media.Water
        "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
      replaceable package MediumAir =
          AixLib.Media.Air
        "Medium in the system" annotation(choicesAllMatching=true);
      AixLib.Systems.HydraulicModules.Throttle dhs(
        redeclare package Medium = AixLib.Media.Water,
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
        Kv=5,
        m_flow_nominal=2.3,
        valve(dpFixed_nominal=10),
        pipe1(length=14),
        pipe2(length=1),
        pipe3(length=6),
        T_amb=273.15 + 10,
        T_start=323.15) "distribute heating system"
        annotation (Placement(transformation(extent={{-10,-20},{90,80}})));

      AixLib.Fluid.Sources.Boundary_ph                FernwaermeAus(
        redeclare package Medium = MediumWater,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));

      Modelica.Blocks.Sources.Constant valve_set(k=1)   annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-34,146})));
      AixLib.Fluid.Sources.Boundary_pT                FernwaermeEin(
        redeclare package Medium = MediumWater,
        p=120000,
        T=403.15,
        nPorts=1) "nominal mass flow 1 kg/s"
        annotation (Placement(transformation(extent={{-108,50},{-88,70}})));
      Modelica.Blocks.Sources.Constant n(k=1700)
        annotation (Placement(transformation(extent={{184,154},{204,174}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe1(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
        length=5,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={354,50})));

      AixLib.Fluid.HeatExchangers.ConstantEffectiveness     hex(
        redeclare package Medium1 = MediumWater,
        redeclare package Medium2 = MediumWater,
        m1_flow_nominal=2.3,
        m2_flow_nominal=2.3,
        dp1_nominal=10,
        dp2_nominal=10,
        eps=0.95) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={154,32})));

      AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus2
        annotation (Placement(transformation(extent={{248,98},{268,118}}), iconTransformation(
              extent={{0,0},{0,0}})));
      AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus1
        annotation (Placement(transformation(extent={{32,114},
                {52,134}}),                                                iconTransformation(extent=
               {{0,0},{0,0}})));
      AixLib.Systems.HydraulicModules.Pump
                               pump(
        redeclare package Medium = MediumWater,
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
        m_flow_nominal=2.3,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per)),
        pipe1(length=3.5),
        pipe2(length=7),
        pipe3(length=10),
        T_amb=273.15 + 10,
        T_start=353.15)
        annotation (Placement(transformation(extent={{210,-8},{290,72}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow reserve(alpha=0.02)
                                                                       annotation (
          Placement(transformation(
            extent={{-15,-15},{15,15}},
            rotation=270,
            origin={1339,325})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe14(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
        length=2,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={318,-12})));

      AixLib.Fluid.FixedResistances.GenericPipe pipe15(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
        length=12,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-52,0})));

      AixLib.Fluid.FixedResistances.GenericPipe reserve_rl(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_16x1(),
        length=1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={1338,144})));

      AixLib.Fluid.MixingVolumes.MixingVolume reserve_volume(
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3,
        V=0.012,
        nPorts=2,
        T_start=323.15) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={1364,198})));
      AixLib.Fluid.FixedResistances.GenericPipe reserve_vl(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_16x1(),
        length=1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={1398,148})));

      Modelica.Blocks.Interfaces.RealInput heatflow_reserve annotation (Placement(
            transformation(
            extent={{-17,-17},{17,17}},
            rotation=270,
            origin={1339,381}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={520,300})));
      AixLib.Fluid.MixingVolumes.MixingVolume     vol1(
        nPorts=7,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3,
        V=0.012,
        p_start=120000,
        T_start=353.15) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={1250,-36})));

      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{178,112},{198,132}})));
      Modelica.Fluid.Interfaces.FluidPort_b cid_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{1176,346},{
                1196,366}}),
                        iconTransformation(extent={{1144,270},{1164,290}})));
      Modelica.Fluid.Interfaces.FluidPort_a cid_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{1132,346},{
                1152,366}}),
                        iconTransformation(extent={{1180,270},{1200,290}})));
      Modelica.Fluid.Interfaces.FluidPort_b cca_rl(redeclare package Medium =
            MediumWater)
        annotation (Placement(transformation(extent={{1064,348},{1084,368}}),
            iconTransformation(extent={{1012,272},{1032,292}})));
      Modelica.Fluid.Interfaces.FluidPort_a cca_vl(redeclare package Medium =
            MediumWater)
        annotation (Placement(transformation(extent={{1004,348},{1024,368}}),
            iconTransformation(extent={{984,272},{1004,292}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe2(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={1012,180})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe3(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={1066,180})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe4(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={1144,178})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe5(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={1186,178})));
      Modelica.Fluid.Interfaces.FluidPort_a cph_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{834,348},{
                854,368}}), iconTransformation(extent={{652,270},{672,290}})));
      Modelica.Fluid.Interfaces.FluidPort_b cph_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{880,348},{
                900,368}}), iconTransformation(extent={{686,270},{706,290}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe6(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={844,196})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe7(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={890,194})));
      Modelica.Fluid.Interfaces.FluidPort_b rlt_h_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{626,348},{
                646,368}}), iconTransformation(extent={{1354,198},{1374,218}})));
      Modelica.Fluid.Interfaces.FluidPort_a rlt_h_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{594,348},{
                614,368}}), iconTransformation(extent={{1352,224},{1372,244}})));
      Modelica.Fluid.Interfaces.FluidPort_b rlt_ph_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{736,348},{
                756,368}}), iconTransformation(extent={{1354,98},{1374,118}})));
      Modelica.Fluid.Interfaces.FluidPort_a rlt_ph_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{700,348},{
                720,368}}), iconTransformation(extent={{1352,126},{1372,146}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe8(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={714,204})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe9(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={750,204})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe10(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={606,208})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe11(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={642,208})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe12(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=5.2,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) "jn"
                            annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={416,278})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe13(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=5.2,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) "jn"
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={486,282})));
      Modelica.Fluid.Interfaces.FluidPort_b jn_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{474,354},{
                494,374}}), iconTransformation(extent={{816,270},{836,290}})));
      Modelica.Fluid.Interfaces.FluidPort_a jn_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{406,356},{
                426,376}}), iconTransformation(extent={{850,270},{870,290}})));
    equation
      connect(FernwaermeEin.ports[1], dhs.port_a1)
        annotation (Line(points={{-88,60},{-10,60}}, color={0,127,255}));
      connect(dhs.port_b1, hex.port_a1) annotation (Line(points={{90,60},{116,60},{
              116,60},{148,60},{148,42}}, color={0,127,255}));
      connect(hex.port_b1, dhs.port_a2)
        annotation (Line(points={{148,22},{148,0},{90,0}}, color={0,127,255}));

      connect(n.y, hydraulicBus2.pumpBus.rpmSet) annotation (Line(points={{205,164},
              {232.5,164},{232.5,108.05},{258.05,108.05}}, color={0,0,127}));
      connect(hex.port_b2, pump.port_a1)
        annotation (Line(points={{160,42},{160,56},{210,56}}, color={0,127,255}));
      connect(hex.port_a2, pump.port_b2)
        annotation (Line(points={{160,22},{160,8},{210,8}}, color={0,127,255}));
      connect(pump.port_b1, pipe1.port_a) annotation (Line(points={{290,56},{316,
              56},{316,50},{344,50}}, color={0,127,255}));
      connect(hydraulicBus1, dhs.hydraulicBus) annotation (Line(
          points={{42,124},{42,80},{40,80}},
          color={255,204,51},
          thickness=0.5));

      connect(pump.hydraulicBus, hydraulicBus2) annotation (Line(
          points={{250,72},{258,72},{258,108}},
          color={255,204,51},
          thickness=0.5));

      connect(pump.port_a2, pipe14.port_a) annotation (Line(points={{290,8},{299,8},
              {299,-12},{308,-12}},
                                  color={0,127,255}));
      connect(FernwaermeAus.ports[1], pipe15.port_a) annotation (Line(points={{-92,0},
              {-78,0},{-78,1.77636e-15},{-62,1.77636e-15}}, color={0,127,255}));
      connect(pipe15.port_b, dhs.port_b2) annotation (Line(points={{-42,-8.88178e-16},
              {-26,-8.88178e-16},{-26,0},{-10,0}}, color={0,127,255}));

      connect(reserve_volume.heatPort, reserve.port) annotation (Line(points={{1354,
              198},{1339,198},{1339,310}}, color={191,0,0}));
      connect(reserve.Q_flow, heatflow_reserve) annotation (Line(points={{1339,340},
              {1339,381}},                       color={0,0,127}));

      connect(vol1.ports[1], pipe14.port_b) annotation (Line(points={{1251.71,-26},
              {376,-26},{376,-12},{328,-12}},color={0,127,255}));

      connect(valve_set.y, hydraulicBus1.valveSet) annotation (Line(points={{-23,
              146},{42.05,146},{42.05,124.05}}, color={0,0,127}));
      connect(booleanExpression.y, hydraulicBus2.pumpBus.onSet) annotation (Line(
            points={{199,122},{199,120},{228,120},{228,108.05},{258.05,108.05}},
            color={255,0,255}));
      connect(pipe1.port_b, pipe2.port_a) annotation (Line(points={{364,50},{364,48},
              {1012,48},{1012,170}}, color={0,127,255}));
      connect(pipe2.port_b, cca_vl) annotation (Line(points={{1012,190},{1014,190},
              {1014,358}}, color={0,127,255}));
      connect(pipe3.port_b, cca_rl) annotation (Line(points={{1066,190},{1074,190},
              {1074,358}}, color={0,127,255}));
      connect(pipe3.port_a, vol1.ports[1]) annotation (Line(points={{1066,170},{
              1064,170},{1064,-26},{1251.71,-26}}, color={0,127,255}));
      connect(pipe4.port_b, cid_vl) annotation (Line(points={{1144,188},{1144,272},
              {1142,272},{1142,356}}, color={0,127,255}));
      connect(pipe5.port_b, cid_rl)
        annotation (Line(points={{1186,188},{1186,356}}, color={0,127,255}));
      connect(pipe4.port_a, pipe1.port_b) annotation (Line(points={{1144,168},{1144,
              50},{364,50}}, color={0,127,255}));
      connect(pipe5.port_a, vol1.ports[2]) annotation (Line(points={{1186,168},{
              1184,168},{1184,-26},{1251.14,-26}}, color={0,127,255}));
      connect(pipe6.port_a, pipe1.port_b)
        annotation (Line(points={{844,186},{844,50},{364,50}}, color={0,127,255}));
      connect(pipe6.port_b, cph_vl)
        annotation (Line(points={{844,206},{844,358}}, color={0,127,255}));
      connect(pipe7.port_b, cph_rl)
        annotation (Line(points={{890,204},{890,358}}, color={0,127,255}));
      connect(pipe7.port_a, vol1.ports[3]) annotation (Line(points={{890,184},{888,
              184},{888,-26},{1250.57,-26}},
                                          color={0,127,255}));
      connect(pipe10.port_a, pipe1.port_b) annotation (Line(points={{606,198},{604,
              198},{604,50},{364,50}}, color={0,127,255}));
      connect(pipe8.port_a, pipe1.port_b) annotation (Line(points={{714,194},{712,
              194},{712,50},{364,50}}, color={0,127,255}));
      connect(pipe10.port_b, rlt_h_vl) annotation (Line(points={{606,218},{604,218},
              {604,358}}, color={0,127,255}));
      connect(pipe8.port_b, rlt_ph_vl) annotation (Line(points={{714,214},{710,214},
              {710,358}}, color={0,127,255}));
      connect(pipe11.port_b, rlt_h_rl) annotation (Line(points={{642,218},{640,218},
              {640,340},{636,340},{636,358}}, color={0,127,255}));
      connect(pipe9.port_b, rlt_ph_rl) annotation (Line(points={{750,214},{746,214},
              {746,358}}, color={0,127,255}));
      connect(pipe11.port_a, vol1.ports[4]) annotation (Line(points={{642,198},{640,
              198},{640,-26},{1250,-26}},    color={0,127,255}));
      connect(pipe9.port_a, vol1.ports[5]) annotation (Line(points={{750,194},{748,
              194},{748,-26},{1249.43,-26}}, color={0,127,255}));
      connect(pipe12.port_b, jn_vl)
        annotation (Line(points={{416,288},{416,366}}, color={0,127,255}));
      connect(pipe13.port_a, jn_rl) annotation (Line(points={{486,292},{484,292},{
              484,364}}, color={0,127,255}));
      connect(pipe12.port_a, pipe1.port_b)
        annotation (Line(points={{416,268},{416,50},{364,50}}, color={0,127,255}));
      connect(pipe13.port_b, vol1.ports[6]) annotation (Line(points={{486,272},{484,
              272},{484,-26},{1248.86,-26}}, color={0,127,255}));
      connect(reserve_rl.port_a, reserve_volume.ports[1]) annotation (Line(points={
              {1338,154},{1363,154},{1363,188}}, color={0,127,255}));
      connect(reserve_vl.port_b, reserve_volume.ports[2]) annotation (Line(points={
              {1398,158},{1365,158},{1365,188}}, color={0,127,255}));
      connect(reserve_rl.port_b, vol1.ports[7]) annotation (Line(points={{1338,134},
              {1336,134},{1336,-26},{1248.29,-26}}, color={0,127,255}));
      connect(pipe1.port_b, reserve_vl.port_a) annotation (Line(points={{364,50},{
              1400,50},{1400,138},{1398,138}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                -100},{1460,360}}),
                              graphics={
            Rectangle(
              extent={{-160,360},{1460,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{104,124},{216,74}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{112,116},{198,100}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              fontSize=8,
              textString="Internal Control"),
            Rectangle(
              extent={{100,70},{60,274}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,-151},{-20,151}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              origin={211,260},
              rotation=-90),
            Rectangle(
              extent={{20,-80},{-20,80}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              origin={-40,260},
              rotation=-90),
            Rectangle(
              extent={{40,70},{0,274}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,-151},{-20,151}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={513,260},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-151},{-20,151}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={211,50},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-151},{-20,151}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={513,50},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-80},{-20,80}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={-40,50},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-350},{-20,350}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={1014,260},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-349},{-20,349}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={1011,50},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{19.5,-124.5},{-19.5,124.5}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={1344.5,154.5},
              rotation=180,
              lineColor={0,0,0}),
            Ellipse(
              extent={{330,300},{406,232}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{42,280},{48,30}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{52,280},{58,30}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-160,-100},{1460,360}})),
        experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
    end Distributor;

    model Distributor_withoutReserve

       replaceable package MediumWater =
          AixLib.Media.Water
        "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
      replaceable package MediumAir =
          AixLib.Media.Air
        "Medium in the system" annotation(choicesAllMatching=true);
      AixLib.Systems.HydraulicModules.Throttle dhs(
        redeclare package Medium = AixLib.Media.Water,
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        Kv=2.5,
        m_flow_nominal=2.3,
        pipe1(length=14),
        pipe2(length=1),
        pipe3(length=6),
        T_amb=273.15 + 10,
        T_start=323.15) "distribute heating system"
        annotation (Placement(transformation(extent={{-10,-20},{90,80}})));

      AixLib.Fluid.Sources.Boundary_ph                FernwaermeAus(
        redeclare package Medium = MediumWater,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));

      AixLib.Fluid.Sources.Boundary_pT                FernwaermeEin(
        redeclare package Medium = MediumWater,
        p=120000,
        T=403.15,
        nPorts=1) "nominal mass flow 1 kg/s"
        annotation (Placement(transformation(extent={{-108,50},{-88,70}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe1(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
        length=4.5,
        redeclare package Medium = MediumWater,
        m_flow_nominal=4.2) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={354,50})));

      AixLib.Fluid.HeatExchangers.ConstantEffectiveness     hex(
        redeclare package Medium1 = MediumWater,
        redeclare package Medium2 = MediumWater,
        m1_flow_nominal=2.3,
        m2_flow_nominal=4.53,
        dp1_nominal=10,
        dp2_nominal=10,
        eps=0.95) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={154,32})));

      AixLib.Systems.HydraulicModules.Pump
                               pump(
        redeclare package Medium = MediumWater,
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_64x2(),
        m_flow_nominal=4.2,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN30_H1_12()),
        pipe1(length=3.5),
        pipe2(length=7),
        pipe3(length=10),
        T_amb=273.15 + 10,
        T_start=353.15)
        annotation (Placement(transformation(extent={{206,-8},{286,72}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe14(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
        length=1.5,
        redeclare package Medium = MediumWater,
        m_flow_nominal=4.2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={350,-14})));

      AixLib.Fluid.FixedResistances.GenericPipe pipe15(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
        length=12,
        redeclare package Medium = MediumWater,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-52,0})));

      AixLib.Fluid.MixingVolumes.MixingVolume     vol1(
        nPorts=6,
        redeclare package Medium = MediumWater,
        m_flow_nominal=4.2,
        V=0.1,
        p_start=120000,
        T_start=353.15) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={1110,-36})));

      Modelica.Fluid.Interfaces.FluidPort_b cid_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{1136,350},{
                1156,370}}),
                        iconTransformation(extent={{1144,270},{1164,290}})));
      Modelica.Fluid.Interfaces.FluidPort_a cid_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{1170,348},{
                1190,368}}), iconTransformation(extent={{1180,270},{1200,290}})));
      Modelica.Fluid.Interfaces.FluidPort_b cca_vl(redeclare package Medium =
            MediumWater)
        annotation (Placement(transformation(extent={{1008,350},{1028,370}}),
            iconTransformation(extent={{956,274},{976,294}})));
      Modelica.Fluid.Interfaces.FluidPort_a cca_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{1048,348},{
                1068,368}}), iconTransformation(extent={{984,272},{1004,292}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe2(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=1.79)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={1012,180})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe3(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=1.79)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={1066,180})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe4(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=0.15)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={1144,178})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe5(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=0.15)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={1186,178})));
      Modelica.Fluid.Interfaces.FluidPort_a cph_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{878,348},{
                898,368}}), iconTransformation(extent={{652,270},{672,290}})));
      Modelica.Fluid.Interfaces.FluidPort_b cph_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{832,348},{
                852,368}}), iconTransformation(extent={{626,270},{646,290}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe6(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=0.54)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={844,196})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe7(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=0.54)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={890,192})));
      Modelica.Fluid.Interfaces.FluidPort_b rlt_h_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{594,350},{
                614,370}}), iconTransformation(extent={{1350,250},{1370,270}})));
      Modelica.Fluid.Interfaces.FluidPort_a rlt_h_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{630,348},{
                650,368}}), iconTransformation(extent={{1352,224},{1372,244}})));
      Modelica.Fluid.Interfaces.FluidPort_b rlt_ph_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{700,348},{
                720,368}}), iconTransformation(extent={{1352,156},{1372,176}})));
      Modelica.Fluid.Interfaces.FluidPort_a rlt_ph_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{730,350},{
                750,370}}), iconTransformation(extent={{1352,126},{1372,146}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe8(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=0.45)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={714,204})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe9(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=0.45)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={750,204})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe10(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=1.2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={606,208})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe11(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=0.1,
        redeclare package Medium = MediumWater,
        m_flow_nominal=1.2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={642,208})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe12(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=5.2,
        redeclare package Medium = MediumWater,
        m_flow_nominal=0.4) "jn"
                            annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={416,278})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe13(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        length=5.2,
        redeclare package Medium = MediumWater,
        m_flow_nominal=0.4) "jn"
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={486,282})));
      Modelica.Fluid.Interfaces.FluidPort_b jn_vl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{408,350},{
                428,370}}), iconTransformation(extent={{474,268},{494,288}})));
      Modelica.Fluid.Interfaces.FluidPort_a jn_rl(redeclare package Medium =
            MediumWater) annotation (Placement(transformation(extent={{470,348},{
                490,368}}),
                        iconTransformation(extent={{502,268},{522,288}})));
      AixLib.Fluid.Sources.Boundary_pT ret_c1(
        redeclare package Medium = AixLib.Media.Water,
        p=100000,
        use_T_in=false,
        nPorts=1) annotation (Placement(transformation(extent={{392,-44},{376,-28}})));
      AixLib.Fluid.Sensors.MassFlowRate senMasFlo_hydraulics(redeclare package
          Medium = AixLib.Media.Water)
        annotation (Placement(transformation(extent={{316,40},{336,60}})));
      AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            AixLib.Media.Water, m_flow_nominal=4.2)
        annotation (Placement(transformation(extent={{332,-24},{312,-4}})));
    equation
      connect(FernwaermeEin.ports[1], dhs.port_a1)
        annotation (Line(points={{-88,60},{-10,60}}, color={0,127,255}));
      connect(dhs.port_b1, hex.port_a1) annotation (Line(points={{90,60},{116,60},{
              116,60},{148,60},{148,42}}, color={0,127,255}));
      connect(hex.port_b1, dhs.port_a2)
        annotation (Line(points={{148,22},{148,0},{90,0}}, color={0,127,255}));

      connect(hex.port_b2, pump.port_a1)
        annotation (Line(points={{160,42},{160,56},{206,56}}, color={0,127,255}));
      connect(hex.port_a2, pump.port_b2)
        annotation (Line(points={{160,22},{160,8},{206,8}}, color={0,127,255}));

      connect(FernwaermeAus.ports[1], pipe15.port_a) annotation (Line(points={{-92,0},
              {-78,0},{-78,1.77636e-15},{-62,1.77636e-15}}, color={0,127,255}));
      connect(pipe15.port_b, dhs.port_b2) annotation (Line(points={{-42,-8.88178e-16},
              {-26,-8.88178e-16},{-26,0},{-10,0}}, color={0,127,255}));

      connect(pipe1.port_b, pipe2.port_a) annotation (Line(points={{364,50},{364,48},
              {1012,48},{1012,170}}, color={0,127,255}));
      connect(pipe4.port_a, pipe1.port_b) annotation (Line(points={{1144,168},{1144,
              50},{364,50}}, color={0,127,255}));
      connect(pipe6.port_a, pipe1.port_b)
        annotation (Line(points={{844,186},{844,50},{364,50}}, color={0,127,255}));
      connect(pipe10.port_a, pipe1.port_b) annotation (Line(points={{606,198},{604,
              198},{604,50},{364,50}}, color={0,127,255}));
      connect(pipe8.port_a, pipe1.port_b) annotation (Line(points={{714,194},{712,
              194},{712,50},{364,50}}, color={0,127,255}));
      connect(pipe12.port_a, pipe1.port_b)
        annotation (Line(points={{416,268},{416,50},{364,50}}, color={0,127,255}));
      connect(jn_vl, pipe12.port_b) annotation (Line(points={{418,360},{416,360},{
              416,288}}, color={0,127,255}));
      connect(pipe10.port_b, rlt_h_vl) annotation (Line(points={{606,218},{604,218},
              {604,360}}, color={0,127,255}));
      connect(jn_rl, pipe13.port_a) annotation (Line(points={{480,358},{480,292},{
              486,292}}, color={0,127,255}));
      connect(vol1.ports[1], pipe13.port_b) annotation (Line(points={{1111.67,-26},
              {1064,-26},{1064,-12},{486,-12},{486,272}}, color={0,127,255}));
      connect(pipe11.port_a, rlt_h_rl) annotation (Line(points={{642,218},{640,218},
              {640,358}}, color={0,127,255}));
      connect(pipe11.port_b, vol1.ports[1]) annotation (Line(points={{642,198},{640,
              198},{640,188},{638,188},{638,-12},{1064,-12},{1064,-26},{1111.67,-26}},
            color={0,127,255}));
      connect(pipe8.port_b, rlt_ph_vl) annotation (Line(points={{714,214},{710,214},
              {710,358}}, color={0,127,255}));
      connect(pipe9.port_a, rlt_ph_rl) annotation (Line(points={{750,214},{740,214},
              {740,360}}, color={0,127,255}));
      connect(pipe9.port_b, vol1.ports[2]) annotation (Line(points={{750,194},{750,-26},
              {1111,-26}},      color={0,127,255}));
      connect(pipe7.port_a, cph_rl) annotation (Line(points={{890,202},{888,202},{
              888,358}}, color={0,127,255}));
      connect(pipe6.port_b, cph_vl) annotation (Line(points={{844,206},{844,282},{
              842,282},{842,358}}, color={0,127,255}));
      connect(pipe7.port_b, vol1.ports[3]) annotation (Line(points={{890,182},{888,
              182},{888,-12},{1064,-12},{1064,-26},{1110.33,-26}}, color={0,127,255}));
      connect(pipe5.port_a, cid_rl) annotation (Line(points={{1186,188},{1184,188},
              {1184,340},{1180,340},{1180,358}}, color={0,127,255}));
      connect(pipe5.port_b, vol1.ports[4]) annotation (Line(points={{1186,168},{
              1184,168},{1184,-16},{1109.67,-16},{1109.67,-26}}, color={0,127,255}));
      connect(pipe4.port_b, cid_vl) annotation (Line(points={{1144,188},{1146,188},
              {1146,360}}, color={0,127,255}));
      connect(pipe2.port_b, cca_vl) annotation (Line(points={{1012,190},{1012,340},
              {1018,340},{1018,360}}, color={0,127,255}));
      connect(pipe3.port_a, cca_rl) annotation (Line(points={{1066,190},{1058,190},
              {1058,358}}, color={0,127,255}));
      connect(pipe3.port_b, vol1.ports[5]) annotation (Line(points={{1066,170},{1064,
              170},{1064,-26},{1109,-26}},         color={0,127,255}));
      connect(controlDHS.distributeBus_DHS, distributeBus_DHS) annotation (Line(
          points={{81.42,194.71},{81.42,192},{156,192},{156,143}},
          color={255,204,51},
          thickness=0.5));
      connect(distributeBus_DHS.bus_dhs, dhs.hydraulicBus) annotation (Line(
          points={{156.09,143.095},{156.09,100},{40,100},{40,80}},
          color={255,204,51},
          thickness=0.5));
      connect(distributeBus_DHS.bus_dhs_pump, pump.hydraulicBus) annotation (Line(
          points={{156.09,143.095},{156.09,84},{246,84},{246,72}},
          color={255,204,51},
          thickness=0.5));
      connect(senMasFlo_hydraulics.port_b, pipe1.port_a)
        annotation (Line(points={{336,50},{344,50}}, color={0,127,255}));
      connect(senMasFlo_hydraulics.port_a, pump.port_b1)
        annotation (Line(points={{316,50},{316,56},{286,56}}, color={0,127,255}));
      connect(senMasFlo_hydraulics.m_flow, distributeBus_DHS.bus_dhs.mFlow)
        annotation (Line(points={{326,61},{324,61},{324,68},{336,68},{336,136},{184,
              136},{184,143.095},{156.09,143.095}}, color={0,0,127}));
      connect(ret_c1.ports[1], pipe14.port_a) annotation (Line(points={{376,-36},{370,
              -36},{370,-14},{360,-14}}, color={0,127,255}));
      connect(pipe14.port_b, senTem.port_a) annotation (Line(points={{340,-14},{336,
              -14},{336,-14},{332,-14}}, color={0,127,255}));
      connect(senTem.port_b, pump.port_a2) annotation (Line(points={{312,-14},{296,-14},
              {296,8},{286,8}}, color={0,127,255}));
      connect(vol1.ports[6], pipe14.port_a) annotation (Line(points={{1108.33,-26},
              {1064,-26},{1064,-14},{360,-14}},color={0,127,255}));
      connect(senTem.T, distributeBus_DHS.bus_dhs.T_RL) annotation (Line(points={{322,
              -3},{322,14},{302,14},{302,122},{156.09,122},{156.09,143.095}}, color=
             {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                -100},{1460,360}}),
                              graphics={
            Rectangle(
              extent={{-160,360},{1460,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{104,124},{216,74}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{112,116},{198,100}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              fontSize=8,
              textString="Internal Control"),
            Rectangle(
              extent={{100,70},{60,274}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,-151},{-20,151}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              origin={211,260},
              rotation=-90),
            Rectangle(
              extent={{20,-80},{-20,80}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              origin={-40,260},
              rotation=-90),
            Rectangle(
              extent={{40,70},{0,274}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,-151},{-20,151}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={513,260},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-151},{-20,151}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={211,50},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-151},{-20,151}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={513,50},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-80},{-20,80}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={-40,50},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-350},{-20,350}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={1014,260},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{20,-349},{-20,349}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={1011,50},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{19.5,-124.5},{-19.5,124.5}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={1344.5,154.5},
              rotation=180,
              lineColor={0,0,0}),
            Ellipse(
              extent={{330,300},{406,232}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{42,280},{48,30}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{52,280},{58,30}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-160,-100},{1460,360}})),
        experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
    end Distributor_withoutReserve;

    package DHS "Disctrict heating system"
      model DHS

            replaceable package MediumWater =
            AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
            choicesAllMatching=true);
        replaceable package MediumAir =
            AixLib.Media.Air
          "Medium in the system" annotation(choicesAllMatching=true);

        AixLib.Systems.HydraulicModules.Throttle dhs(
          redeclare package Medium = MediumWater,
          length=1,
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
          Kv=5,
          m_flow_nominal=1,
          pipe1(length=14),
          pipe2(length=1),
          pipe3(length=6),
          T_amb=273.15 + 10,
          T_start=323.15) "distribute heating system"
          annotation (Placement(transformation(extent={{-144,-56},{-44,44}})));
        AixLib.Fluid.Sources.Boundary_ph                FernwaermeAus(
          redeclare package Medium = MediumWater,
          p=100000,
          nPorts=1)
          annotation (Placement(transformation(extent={{-264,-40},{-244,-20}})));
        AixLib.Fluid.Sources.Boundary_pT                FernwaermeEin(
          redeclare package Medium = MediumWater,
          p=115000,
          T=403.15,
          nPorts=1) "nominal mass flow 1 kg/s"
          annotation (Placement(transformation(extent={{-262,20},{-242,40}})));
        AixLib.Fluid.FixedResistances.GenericPipe pipe1(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
          length=2,
          redeclare package Medium = MediumWater,
          m_flow_nominal=2.3) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={188,26})));

        AixLib.Fluid.HeatExchangers.ConstantEffectiveness     hex(
          redeclare package Medium1 = MediumWater,
          redeclare package Medium2 = MediumWater,
          m1_flow_nominal=2.3,
          m2_flow_nominal=2.3,
          dp1_nominal=0,
          dp2_nominal=0,
          eps=0.95) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={12,2})));
        AixLib.Systems.HydraulicModules.Pump
                                 pump(
          redeclare package Medium = MediumWater,
          length=1,
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
          m_flow_nominal=2.3,
          redeclare
            AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
            PumpInterface(pump(redeclare
                AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per, riseTime=
                 5)),
          pipe1(length=3.5),
          pipe2(length=7),
          pipe3(length=10),
          T_amb=273.15 + 10,
          T_start=353.15) "nominal mass flow 2.2 kg/s"
          annotation (Placement(transformation(extent={{68,-38},{148,42}})));
        AixLib.Fluid.FixedResistances.GenericPipe pipe14(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
          length=2,
          redeclare package Medium = MediumWater,
          m_flow_nominal=2.3) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={192,-22})));

        AixLib.Fluid.FixedResistances.GenericPipe pipe15(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
          length=12,
          redeclare package Medium = MediumWater,
          m_flow_nominal=2.3) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={-194,-30})));

        Modelica.Blocks.Sources.RealExpression valve(y=0.27)
          annotation (Placement(transformation(extent={{-170,104},{-150,124}})));
        Modelica.Blocks.Sources.RealExpression nSet(y=2307)
          annotation (Placement(transformation(extent={{-22,98},{-2,118}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-22,116},{-2,136}})));
        AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus
          annotation (Placement(transformation(extent={{36,88},{74,126}}),
              iconTransformation(extent={{-112,-14},{-86,12}})));
        AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus1
          annotation (Placement(transformation(extent={{-114,60},{-76,98}}),
              iconTransformation(extent={{-112,-14},{-86,12}})));
        AixLib.Fluid.Sources.Boundary_ph bou1(
          redeclare package Medium = MediumWater,
          p=100000,
          nPorts=1)
          annotation (Placement(transformation(extent={{238,-32},{218,-12}})));
        AixLib.Fluid.Sources.Boundary_ph bou(
          redeclare package Medium = MediumWater,
          p=100000,
          nPorts=1) annotation (Placement(transformation(extent={{242,16},{222,36}})));
      equation
        connect(FernwaermeEin.ports[1],dhs. port_a1)
          annotation (Line(points={{-242,30},{-194,30},{-194,24},{-144,24}},
                                                       color={0,127,255}));
        connect(dhs.port_b1,hex. port_a1) annotation (Line(points={{-44,24},{6,24},{6,
                12}},                       color={0,127,255}));
        connect(hex.port_b1,dhs. port_a2)
          annotation (Line(points={{6,-8},{6,-36},{-44,-36}},color={0,127,255}));
        connect(hex.port_b2,pump. port_a1)
          annotation (Line(points={{18,12},{18,26},{68,26}},    color={0,127,255}));
        connect(hex.port_a2,pump. port_b2)
          annotation (Line(points={{18,-8},{18,-22},{68,-22}},color={0,127,255}));
        connect(pump.port_b1,pipe1. port_a) annotation (Line(points={{148,26},{178,26}},
                                        color={0,127,255}));
        connect(pump.port_a2,pipe14. port_a) annotation (Line(points={{148,-22},{182,-22}},
                                    color={0,127,255}));
        connect(FernwaermeAus.ports[1],pipe15. port_a) annotation (Line(points={{-244,
                -30},{-204,-30}},                             color={0,127,255}));
        connect(pipe15.port_b,dhs. port_b2) annotation (Line(points={{-184,-30},{-164,
                -30},{-164,-36},{-144,-36}},         color={0,127,255}));
        connect(nSet.y,registerBus. hydraulicBus.pumpBus.rpmSet) annotation (Line(
              points={{-1,108},{26,108},{26,107.095},{55.095,107.095}},color={0,0,127}));
        connect(booleanExpression.y,registerBus. hydraulicBus.pumpBus.onSet)
          annotation (Line(points={{-1,126},{30,126},{30,107.095},{55.095,107.095}},
              color={255,0,255}));
        connect(registerBus, pump.hydraulicBus) annotation (Line(
            points={{55,107},{55,105.5},{108,105.5},{108,42}},
            color={255,204,51},
            thickness=0.5));
        connect(dhs.hydraulicBus, registerBus1) annotation (Line(
            points={{-94,44},{-94,62},{-94,79},{-95,79}},
            color={255,204,51},
            thickness=0.5));
        connect(valve.y, registerBus1.hydraulicBus.valveSet) annotation (Line(points=
                {{-149,114},{-102,114},{-102,79.095},{-94.905,79.095}}, color={0,0,
                127}));
        connect(bou.ports[1], pipe1.port_b)
          annotation (Line(points={{222,26},{198,26}}, color={0,127,255}));
        connect(pipe14.port_b, bou1.ports[1]) annotation (Line(points={{202,-22},{210,
                -22},{210,-22},{218,-22}}, color={0,127,255}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-100},{300,120}})),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-280,-100},{300,
                  120}})),
          experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
      end DHS;
    end DHS;
  end Distributor;

  package JN "Jet Nozzle"
    model JN "Reheater/Recooler jet nozzles"

        replaceable package MediumWater =
          AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
          choicesAllMatching=true);
      replaceable package MediumAir =
          AixLib.Media.Air
        "Medium in the system" annotation(choicesAllMatching=true);

      AixLib.Fluid.Actuators.Valves.TwoWayLinear Valve_hall1(
        redeclare package Medium = MediumAir,
        m_flow_nominal=3.7,
        CvData=AixLib.Fluid.Types.CvTypes.Kv,
        Kv=100,
        l=0.01)               annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={54,54})));
      AixLib.Fluid.HeatExchangers.ConstantEffectiveness hx[10](
        redeclare package Medium1 = MediumAir,
        redeclare package Medium2 = MediumWater,
        m1_flow_nominal=3.7,
        m2_flow_nominal=2.1,
        eps=0.95,
        m1_flow_small=0.01,
        m2_flow_small=0.01,
        dp1_nominal=0,
        dp2_nominal=0) "Reheater"
        annotation (Placement(transformation(extent={{-2,-10},{-22,12}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe_outgoing_air(
        redeclare package Medium = MediumAir,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_108x1_5(),
        length=1,
        m_flow_nominal=3.7) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-110,54})));
      Modelica.Fluid.Interfaces.FluidPort_b heating_air_hall1(redeclare package
          Medium = MediumAir) "SUP"
        annotation (Placement(transformation(extent={{-170,44},{-150,64}}),
            iconTransformation(extent={{-86,70},{-66,90}})));
      Modelica.Fluid.Interfaces.FluidPort_a heating_water_in(redeclare package
          Medium = MediumWater) annotation (Placement(transformation(extent={{-168,-30},
                {-148,-10}}),    iconTransformation(extent={{-44,-50},{-24,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b heating_water_out(redeclare package
          Medium = MediumWater) annotation (Placement(transformation(extent={{164,-24},
                {184,-4}}),      iconTransformation(extent={{-74,-50},{-54,-30}})));
      AixLib.Fluid.Sensors.TemperatureTwoPort
                                         T(redeclare package Medium = MediumAir,
          m_flow_nominal=3.7)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={82,54})));
      AixLib.Fluid.MixingVolumes.MixingVolume vol_hot(
        nPorts=2,
        redeclare package Medium = MediumAir,
        V=19,
        m_flow_nominal=4) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={102,42})));
      Modelica.Fluid.Interfaces.FluidPort_a air_RLT_SUP(redeclare package
          Medium =
            MediumAir) annotation (Placement(transformation(extent={{150,44},{170,64}}),
            iconTransformation(extent={{60,-50},{80,-30}})));
      Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus
        annotation (Placement(transformation(extent={{18,64},{42,90}}),
            iconTransformation(extent={{0,0},{0,0}})));
      Modelica.Fluid.Interfaces.FluidPort_a cool_water_in(redeclare package
          Medium =
            MediumWater) annotation (Placement(transformation(extent={{-128,-58},{-110,
                -40}}),     iconTransformation(extent={{14,-50},{34,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b cool_water_out(redeclare package
          Medium =
            MediumWater) annotation (Placement(transformation(extent={{110,-56},{130,
                -36}}), iconTransformation(extent={{-12,-50},{8,-30}})));
      AixLib.Fluid.Actuators.Valves.ThreeWayLinear val_in(redeclare package
          Medium =
            MediumWater,
        CvData=AixLib.Fluid.Types.CvTypes.Kv,
        Kv=15,                  m_flow_nominal=2.3)
        annotation (Placement(transformation(extent={{-130,-30},{-110,-10}})));
      AixLib.Fluid.Actuators.Valves.ThreeWayLinear val_out(redeclare package
          Medium =
            MediumWater,
        CvData=AixLib.Fluid.Types.CvTypes.Kv,
        Kv=15,                  m_flow_nominal=2.3)
        annotation (Placement(transformation(extent={{110,-24},{130,-4}})));
      AixLib.Fluid.Sources.Boundary_pT dummy_fernkaelte_ein(
        redeclare package Medium = MediumWater,
        T=281.15,
        nPorts=1,
        p=200000) "nominal mass flow 1 kg/s"
        annotation (Placement(transformation(extent={{-144,-74},{-124,-54}})));
      AixLib.Fluid.Sources.Boundary_ph dummy_fernkaelte_ais(
        redeclare package Medium = MediumWater,
        nPorts=1,
        p=100000)
        annotation (Placement(transformation(extent={{94,-76},{114,-56}})));
      AixLib.Systems.HydraulicModules.Throttle throttle[10](
        length=1,
        each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        Kv=4,
        pipe1(length={3.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5}),
        pipe2(length={8,8,8,8,8,8,6,6,6,6}),
        pipe3(length={11.5,11.5,11.5,11.5,11.5,11.5,9.5,9.5,9.5,9.5}),
        m_flow_nominal=2.3,
        redeclare package Medium = MediumWater,
        T_amb=273.15 + 10,
        T_start=323.15) "reheater jet nozzles" annotation (Placement(transformation(
            extent={{-26,-26},{26,26}},
            rotation=90,
            origin={-12,-46})));

      AixLib.Fluid.MixingVolumes.MixingVolume vol1(
        nPorts=11,
        redeclare package Medium = MediumAir,
        V=19,
        m_flow_nominal=4) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-52,34})));
      AixLib.Fluid.MixingVolumes.MixingVolume vol2(
        nPorts=11,
        redeclare package Medium = MediumAir,
        V=19,
        m_flow_nominal=4) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={18,44})));
      AixLib.Fluid.MixingVolumes.MixingVolume vol3(
        nPorts=11,
        redeclare package Medium = MediumWater,
        V=19,
        m_flow_nominal=4) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-84,-58})));
      AixLib.Fluid.MixingVolumes.MixingVolume vol4(
        nPorts=11,
        redeclare package Medium = MediumWater,
        V=19,
        m_flow_nominal=4) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={54,-64})));
    equation

      connect(pipe_outgoing_air.port_b, heating_air_hall1)
        annotation (Line(points={{-120,54},{-160,54}}, color={0,127,255}));
      connect(vol_hot.ports[1],T. port_b) annotation (Line(points={{103,52},{98,52},
              {98,54},{92,54}},     color={0,127,255}));
      connect(Valve_hall1.port_a, T.port_a) annotation (Line(points={{64,54},{72,54}},
                                color={0,127,255}));
      connect(vol_hot.ports[2], air_RLT_SUP) annotation (Line(points={{101,52},{108,
              52},{108,54},{160,54}},
                                 color={0,127,255}));
      connect(Valve_hall1.y, controlBus.Hall1_Air_Valve)
        annotation (Line(points={{54,66},{54,77},{30,77}}, color={0,0,127}));
      connect(T.T, controlBus.Temperature_hot_air)
        annotation (Line(points={{82,65},{82,77},{30,77}}, color={0,0,127}));
      connect(val_in.port_1, heating_water_in)
        annotation (Line(points={{-130,-20},{-158,-20}}, color={0,127,255}));
      connect(val_in.port_3, cool_water_in) annotation (Line(points={{-120,-30},{-120,
              -49},{-119,-49}}, color={0,127,255}));
      connect(val_out.port_2, heating_water_out)
        annotation (Line(points={{130,-14},{174,-14}}, color={0,127,255}));
      connect(val_out.port_3, cool_water_out)
        annotation (Line(points={{120,-24},{120,-46}}, color={0,127,255}));
      connect(dummy_fernkaelte_ein.ports[1], cool_water_in) annotation (Line(points=
             {{-124,-64},{-119,-64},{-119,-49}}, color={0,127,255}));
      connect(dummy_fernkaelte_ais.ports[1], cool_water_out) annotation (Line(
            points={{114,-66},{118,-66},{118,-46},{120,-46}}, color={0,127,255}));
      connect(throttle.port_b1, hx.port_a2) annotation (Line(points={{-27.6,-20},{-27.6,
              -5.6},{-22,-5.6}}, color={0,127,255}));
      connect(hx.port_b2, throttle.port_a2) annotation (Line(points={{-2,-5.6},{4,-5.6},
              {4,-20},{3.6,-20}}, color={0,127,255}));
      connect(distributeBus_JN.controlBus_jn, controlBus) annotation (Line(
          points={{-70,113},{-21,113},{-21,77},{30,77}},
          color={255,204,51},
          thickness=0.5));
      connect(val_in.y, distributeBus_JN.bus_jn.val_in_set) annotation (Line(points=
             {{-120,-8},{-122,-8},{-122,113.095},{-69.91,113.095}}, color={0,0,127}));
      connect(val_out.y, distributeBus_JN.bus_jn.val_out_set) annotation (Line(
            points={{120,-2},{120,113.095},{-69.91,113.095}}, color={0,0,127}));
      connect(pipe_outgoing_air.port_a, vol1.ports[1]) annotation (Line(points={{-100,54},
              {-78,54},{-78,44},{-50.1818,44}},     color={0,127,255}));
      connect(hx.port_b1, vol1.ports[2:11]) annotation (Line(points={{-22,7.6},{-36,
              7.6},{-36,44},{-53.8182,44}}, color={0,127,255}));
      connect(hx.port_a1, vol2.ports[1:10]) annotation (Line(points={{-2,7.6},{2,
              7.6},{2,54},{16.5455,54}},
                                    color={0,127,255}));
      connect(vol2.ports[11], Valve_hall1.port_b)
        annotation (Line(points={{16.1818,54},{44,54}}, color={0,127,255}));
      connect(val_in.port_2, vol3.ports[1]) annotation (Line(points={{-110,-20},{
              -96,-20},{-96,-48},{-82.1818,-48}},
                                              color={0,127,255}));
      connect(vol3.ports[2:11], throttle.port_a1) annotation (Line(points={{
              -85.8182,-48},{-70,-48},{-70,-72},{-27.6,-72}},
                                                     color={0,127,255}));
      connect(throttle.port_b2, vol4.ports[1:10]) annotation (Line(points={{3.6,-72},
              {32,-72},{32,-54},{52.5455,-54}}, color={0,127,255}));
      connect(vol4.ports[11], val_out.port_1) annotation (Line(points={{52.1818,-54},
              {66,-54},{66,-14},{110,-14}}, color={0,127,255}));
      connect(distributeBus_JN.bus_valve, throttle.hydraulicBus) annotation (Line(
          points={{-70,113},{-70,113},{-70,-46},{-38,-46}},
          color={255,204,51},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-80},
                {160,120}}),graphics={Rectangle(
              extent={{-100,80},{100,-40}},
              lineColor={3,15,29},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid), Text(
              extent={{-58,46},{52,-2}},
              lineColor={3,15,29},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              textString="JN")}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-160,-80},{160,120}})));
    end JN;

    model JN_2HX
      AixLib.Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = AixLib.Media.Air,
        p=100000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-172,94},{-152,114}})));
      AixLib.Fluid.MixingVolumes.MixingVolume vol(
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=3,
        V=19,
        nPorts=3)
        annotation (Placement(transformation(extent={{-124,-92},{-104,-72}})));
      AixLib.Fluid.MixingVolumes.MixingVolume vol1(
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=3,
        V=19,
        nPorts=3)
        annotation (Placement(transformation(extent={{128,-100},{148,-80}})));
      AixLib.Systems.ModularAHU.RegisterModule registerModule1to6(
        redeclare package Medium1 = AixLib.Media.Air,
        redeclare package Medium2 = AixLib.Media.Water,
        hydraulicModuleIcon="Throttle",
        m1_flow_nominal=3.7,
        m2_flow_nominal=2.3,
        T_amb=288.15,
        redeclare AixLib.Systems.HydraulicModules.Throttle hydraulicModule(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
          Kv=4,
          pipe1(length=3.5),
          pipe2(length=8),
          pipe3(length=11.5))) "ThrotValve left "
        annotation (Placement(transformation(extent={{-86,-40},{-6,60}})));
      AixLib.Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = AixLib.Media.Water,
        p=100000,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={282,-122})));
      AixLib.Fluid.Sources.Boundary_pT bou2(
        redeclare package Medium = AixLib.Media.Water,
        p=115000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-272,-126},{-252,-106}})));
      AixLib.Fluid.Sources.Boundary_pT bou3(
        redeclare package Medium = AixLib.Media.Air,
        p=80000,
        nPorts=1) annotation (Placement(transformation(extent={{36,94},{16,114}})));
      AixLib.Fluid.FixedResistances.GenericPipe genericPipe(
        redeclare package Medium = AixLib.Media.Water,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        length=5.2,
        m_flow_nominal=2.3)
        annotation (Placement(transformation(extent={{-240,-126},{-220,-106}})));
      AixLib.Fluid.FixedResistances.GenericPipe genericPipe1(
        redeclare package Medium = AixLib.Media.Water,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        length=5.2,
        m_flow_nominal=2.3)
        annotation (Placement(transformation(extent={{248,-132},{268,-112}})));
      AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus
        annotation (Placement(transformation(extent={{-126,-2},{-108,20}}),
            iconTransformation(extent={{-112,-14},{-86,12}})));
      AixLib.Systems.ModularAHU.RegisterModule registerModule7to10(
        redeclare package Medium1 = AixLib.Media.Air,
        redeclare package Medium2 = AixLib.Media.Water,
        hydraulicModuleIcon="Throttle",
        m1_flow_nominal=3.7,
        m2_flow_nominal=2.3,
        T_amb=288.15,
        redeclare AixLib.Systems.HydraulicModules.Throttle hydraulicModule(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
          Kv=2.5,
          pipe1(length=3.5),
          pipe2(length=6),
          pipe3(length=8.5))) "ThrotValve right"
        annotation (Placement(transformation(extent={{102,-30},{182,70}})));
      AixLib.Fluid.Sources.Boundary_pT bou4(
        redeclare package Medium = AixLib.Media.Air,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{48,94},{68,114}})));
      AixLib.Fluid.Sources.Boundary_pT bou5(
        redeclare package Medium = AixLib.Media.Air,
        p=80000,
        nPorts=1)
        annotation (Placement(transformation(extent={{254,94},{234,114}})));
      AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus1
        annotation (Placement(transformation(extent={{60,4},{80,26}}),
            iconTransformation(extent={{-112,-14},{-86,12}})));

      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        pumpInterface_SpeedControlledNrpm(
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=2.3,
        pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))
        annotation (Placement(transformation(extent={{-166,-126},{-146,-106}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-204,-76},{-184,-56}})));
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus
                               pumpBus annotation (Placement(transformation(
              extent={{-182,-86},{-142,-46}}),
                                           iconTransformation(extent={{-20,80},{20,120}})));
      AixLib.Fluid.Actuators.Valves.ThreeWayLinear val_in(
        redeclare package Medium = MediumWater,
        CvData=AixLib.Fluid.Types.CvTypes.Kv,
        Kv=15,
        m_flow_nominal=2.3) "SwitchValveSup"
        annotation (Placement(transformation(extent={{-206,-126},{-186,-106}})));
      AixLib.Fluid.Sources.Boundary_pT dummy_fernkaelte_ein(
        redeclare package Medium = MediumWater,
        T=281.15,
        p=115000,
        nPorts=1) "nominal mass flow 1 kg/s"
        annotation (Placement(transformation(extent={{-232,-170},{-212,-150}})));
      AixLib.Fluid.Actuators.Valves.ThreeWayLinear val_in1(
        redeclare package Medium = MediumWater,
        CvData=AixLib.Fluid.Types.CvTypes.Kv,
        Kv=15,
        m_flow_nominal=2.3) "SwitchValveRet"
        annotation (Placement(transformation(extent={{212,-132},{232,-112}})));
      AixLib.Fluid.Sources.Boundary_ph dummy_fernkaelte_ais(
        redeclare package Medium = MediumWater,
        nPorts=1,
        p=100000)
        annotation (Placement(transformation(extent={{180,-166},{200,-146}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(tableOnFile=true,
          smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
                      "1-PumpSpeed, 9-PumpVolFlow, 10-ValveSet"
        annotation (Placement(transformation(extent={{-276,-4},{-240,32}})));
    equation
      connect(vol.ports[1], registerModule1to6.port_a2) annotation (Line(points={{
              -115.333,-92},{-100,-92},{-100,-9.23077},{-86,-9.23077}}, color={0,
              127,255}));
      connect(vol1.ports[1], registerModule1to6.port_b2) annotation (Line(points={{136.667,
              -100},{20,-100},{20,-9.23077},{-6,-9.23077}},         color={0,127,
              255}));
      connect(registerModule1to6.port_a1, bou.ports[1]) annotation (Line(points={{-86,
              36.9231},{-86,38},{-128,38},{-128,104},{-152,104}},     color={0,127,
              255}));
      connect(registerModule1to6.port_b1, bou3.ports[1]) annotation (Line(points={{-6,
              36.9231},{6,36.9231},{6,104},{16,104}},    color={0,127,255}));
      connect(bou2.ports[1], genericPipe.port_a) annotation (Line(points={{-252,
              -116},{-240,-116}},                         color={0,127,255}));
      connect(genericPipe1.port_b, bou1.ports[1])
        annotation (Line(points={{268,-122},{272,-122}}, color={0,127,255}));
      connect(registerBus, registerModule1to6.registerBus) annotation (Line(
          points={{-117,9},{-104.5,9},{-104.5,13.4615},{-85.6,13.4615}},
          color={255,204,51},
          thickness=0.5));
      connect(bou4.ports[1], registerModule7to10.port_a1) annotation (Line(points={{68,104},
              {80,104},{80,46.9231},{102,46.9231}},          color={0,127,255}));
      connect(registerModule7to10.port_b1, bou5.ports[1]) annotation (Line(points={{182,
              46.9231},{182,46},{214,46},{214,104},{234,104}},      color={0,127,
              255}));
      connect(registerModule7to10.port_a2, vol.ports[2]) annotation (Line(points={{102,
              0.769231},{80,0.769231},{80,-92},{-114,-92}},         color={0,127,
              255}));
      connect(registerModule7to10.port_b2, vol1.ports[2]) annotation (Line(points={{182,
              0.769231},{198,0.769231},{198,-100},{138,-100}},          color={0,
              127,255}));
      connect(pumpInterface_SpeedControlledNrpm.port_b, vol.ports[3]) annotation (
          Line(points={{-146,-116},{-114,-116},{-114,-92},{-112.667,-92}}, color={0,
              127,255}));
      connect(booleanExpression.y, pumpBus.onSet) annotation (Line(points={{-183,
              -66},{-174,-66},{-174,-65.9},{-161.9,-65.9}}, color={255,0,255}));
      connect(pumpBus, pumpInterface_SpeedControlledNrpm.pumpBus) annotation (Line(
          points={{-162,-66},{-160,-66},{-160,-106},{-156,-106}},
          color={255,204,51},
          thickness=0.5));
      connect(dummy_fernkaelte_ein.ports[1], val_in.port_3) annotation (Line(points=
             {{-212,-160},{-196,-160},{-196,-126}}, color={0,127,255}));
      connect(genericPipe.port_b, val_in.port_1)
        annotation (Line(points={{-220,-116},{-206,-116}}, color={0,127,255}));
      connect(val_in.port_2, pumpInterface_SpeedControlledNrpm.port_a)
        annotation (Line(points={{-186,-116},{-166,-116}}, color={0,127,255}));
      connect(vol1.ports[3], val_in1.port_1) annotation (Line(points={{139.333,-100},
              {174,-100},{174,-122},{212,-122}}, color={0,127,255}));
      connect(val_in1.port_2, genericPipe1.port_a)
        annotation (Line(points={{232,-122},{248,-122}}, color={0,127,255}));
      connect(dummy_fernkaelte_ais.ports[1], val_in1.port_3) annotation (Line(
            points={{200,-156},{222,-156},{222,-132}}, color={0,127,255}));
      connect(registerBus1, registerModule7to10.registerBus) annotation (Line(
          points={{70,15},{86,15},{86,23.4615},{102.4,23.4615}},
          color={255,204,51},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,
                -180},{320,180}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-280,-180},{320,180}})),
        experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
    end JN_2HX;

    model JN_simpel "Reheater/Recooler jet nozzles"

        replaceable package MediumWater =
          AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
          choicesAllMatching=true);
      replaceable package MediumAir =
          AixLib.Media.Air
        "Medium in the system" annotation(choicesAllMatching=true);

      AixLib.Fluid.HeatExchangers.ConstantEffectiveness hx(
        redeclare package Medium1 = MediumAir,
        redeclare package Medium2 = MediumWater,
        m1_flow_nominal=0.4,
        m2_flow_nominal=3,
        eps=0.95,
        m1_flow_small=0.01,
        m2_flow_small=0.01,
        dp1_nominal=10,
        dp2_nominal=10) "Reheater"
        annotation (Placement(transformation(extent={{-2,-10},{-22,12}})));
      Modelica.Fluid.Interfaces.FluidPort_b heating_air_hall1(redeclare package
          Medium = MediumAir) "SUP" annotation (Placement(transformation(extent={{-170,
                44},{-150,64}}), iconTransformation(extent={{-86,70},{-66,90}})));
      Modelica.Fluid.Interfaces.FluidPort_a heating_water_in(redeclare package
          Medium = MediumWater) annotation (Placement(transformation(extent={{-168,-30},
                {-148,-10}}),    iconTransformation(extent={{-44,-50},{-24,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b heating_water_out(redeclare package
          Medium = MediumWater) annotation (Placement(transformation(extent={{164,-24},
                {184,-4}}),      iconTransformation(extent={{-74,-50},{-54,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_a air_RLT_SUP(redeclare package
          Medium =
            MediumAir) annotation (Placement(transformation(extent={{126,44},{146,64}}),
            iconTransformation(extent={{60,-50},{80,-30}})));
      AixLib.Systems.HydraulicModules.Throttle throttle(
        length=1,
        each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
        Kv=4,
        pipe1(length=3.5),
        pipe2(length=8),
        pipe3(length=11.5),
        m_flow_nominal=0.4,
        redeclare package Medium = MediumWater,
        T_amb=273.15 + 10,
        T_start=323.15) "reheater jet nozzles" annotation (Placement(transformation(
            extent={{-26,-26},{26,26}},
            rotation=90,
            origin={-12,-46})));

      Modelica.Blocks.Sources.Constant const1(k=0.2)
        annotation (Placement(transformation(extent={{-82,-20},{-70,-8}})));
      AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus_jn
        annotation (Placement(transformation(extent={{-72,-56},{-52,-36}}),
            iconTransformation(extent={{0,0},{0,0}})));
      AixLib.Fluid.Actuators.Valves.TwoWayLinear Valve(
        redeclare package Medium = MediumAir,
        each m_flow_nominal=0.8,
        CvData=AixLib.Fluid.Types.CvTypes.Kv,
        Kv=12000,
        dpValve_nominal=10,
        each l=0.01) "if Valve Kv=100 " annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-114,54})));
      DistributeBus distributeBus annotation (Placement(transformation(extent={{-134,
                96},{-94,136}}), iconTransformation(extent={{-120,-4},{-80,36}})));
    equation

      connect(throttle.hydraulicBus, hydraulicBus_jn) annotation (Line(
          points={{-38,-46},{-62,-46}},
          color={255,204,51},
          thickness=0.5));
      connect(throttle.port_a2, hx.port_b2) annotation (Line(points={{3.6,-20},{8,-20},
              {8,-5.6},{-2,-5.6}}, color={0,127,255}));
      connect(throttle.port_b1, hx.port_a2) annotation (Line(points={{-27.6,-20},{-27.6,
              -5.6},{-22,-5.6}}, color={0,127,255}));
      connect(hx.port_a1, air_RLT_SUP) annotation (Line(points={{-2,7.6},{-2,6},{
              136,6},{136,54}}, color={0,127,255}));
      connect(const1.y, hydraulicBus_jn.valveSet) annotation (Line(points={{-69.4,
              -14},{-61.95,-14},{-61.95,-45.95}},
                                         color={0,0,127}));
      connect(throttle.port_b2, heating_water_out) annotation (Line(points={{3.6,
              -72},{2,-72},{2,-78},{160,-78},{160,-14},{174,-14}}, color={0,127,255}));
      connect(throttle.port_a1, heating_water_in) annotation (Line(points={{-27.6,
              -72},{-26,-72},{-26,-78},{-142,-78},{-142,-20},{-158,-20}}, color={0,
              127,255}));
      connect(Valve.port_a, heating_air_hall1)
        annotation (Line(points={{-124,54},{-160,54}}, color={0,127,255}));
      connect(Valve.port_b, hx.port_b1) annotation (Line(points={{-104,54},{-66,54},
              {-66,7.6},{-22,7.6}}, color={0,127,255}));
      connect(Valve.y, distributeBus.bus_jn.valveSet)
        annotation (Line(points={{-114,66},{-114,92},{-114,116.1},{-113.9,116.1}},
                                                        color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-80},
                {160,120}}),graphics={Rectangle(
              extent={{-100,80},{100,-40}},
              lineColor={3,15,29},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid), Text(
              extent={{-58,46},{52,-2}},
              lineColor={3,15,29},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              textString="JN")}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-160,-80},{160,120}})));
    end JN_simpel;
  end JN;

  expandable connector ControlBus
    "Control bus that is adapted to the signals connected to it"
    extends Modelica.Icons.SignalBus;
    import      Modelica.Units.SI;
    SI.AngularVelocity realSignal1 "First Real signal (angular velocity)"
      annotation (HideResult=false);
    SI.Velocity realSignal2 "Second Real signal"
      annotation (HideResult=false);
    Integer integerSignal "Integer signal" annotation (HideResult=false);
    Boolean booleanSignal "Boolean signal" annotation (HideResult=false);
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus subControlBus
      "Combined signal" annotation (HideResult=false);
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus office_1_valve_ctrl
      "Combined signal" annotation (HideResult=false);
      Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus office_2_valve_ctrl
      "Combined signal" annotation (HideResult=false);
      Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus office_3_valve_ctrl
      "Combined signal" annotation (HideResult=false);
      Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus office_4_valve_ctrl
      "Combined signal" annotation (HideResult=false);
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.SubControlBus office_5_valve_ctrl
      "Combined signal" annotation (HideResult=false);

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
                    extent={{-20,2},{22,-2}},
                    lineColor={255,204,51},
                    lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

  end ControlBus;

  expandable connector DistributeBus "Distribute Data Bus"
    extends Modelica.Icons.SignalBus;
    import      Modelica.Units.SI;

    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus control_office_heating;
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus control_cid;
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus control_ahu;
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus control_jn;
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus control_input;
    Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus control_building;

    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cca;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cph;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cph_throttle;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cid;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_ahu;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_ahu_pre;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_ahu_cold;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_jn;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_valve_jn;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_dhs;
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_dhs_pump;

  end DistributeBus;
end BaseClasses;
