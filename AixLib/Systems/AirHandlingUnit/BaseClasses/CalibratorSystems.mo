within AixLib.Systems.AirHandlingUnit.BaseClasses;
package CalibratorSystems
  model Admix_Calibrator

      Zugabe.Zugabe_DB.MeasuredData.AHU2_Preheater_StepResponse MeasuredData;

    replaceable package MediumWater =
        Modelica.Media.Water.ConstantPropertyLiquidWater;
    replaceable package MediumAir=AixLib.Media.Air;

    Modelica.Fluid.Sources.FixedBoundary SinkAir(          redeclare package
        Medium = MediumAir, nPorts=1,
      T(displayUnit="K"))                                  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={86,80})));
    Modelica.Fluid.Sources.Boundary_pT Sink(use_p_in=true,
      redeclare package Medium = MediumWater,
      nPorts=1)                                                      annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={24,-112})));
    Modelica.Fluid.Sources.Boundary_pT Source(
      use_p_in=true,
      use_T_in=true,
      redeclare package Medium = MediumWater,
      nPorts=1) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-26,-112})));
    Modelica.Blocks.Sources.RealExpression Pressure_in_Pa1(y=300000) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={54,-134})));
    Modelica.Blocks.Sources.RealExpression Pressure_in_Pa(y=300000) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={14,-134})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
      annotation (Placement(transformation(extent={{-68,-140},{-44,-116}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary(
      use_m_flow_in=true,
      use_T_in=true,
      redeclare package Medium = MediumAir,
      nPorts=1)
      annotation (Placement(transformation(extent={{-108,70},{-88,90}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
      annotation (Placement(transformation(extent={{-152,50},{-128,74}})));
    Modelica.Blocks.Math.Gain toMassflow(k=1.1839/3600)
      annotation (Placement(transformation(extent={{-152,88},{-132,108}})));
    Modelica.Blocks.Math.Gain toProcent(k=0.01)
      annotation (Placement(transformation(extent={{-130,-8},{-110,12}})));
    HydraulicModules.BaseClasses.HydraulicBus hydraulicBus annotation (Placement(
          transformation(extent={{-110,-50},{-70,-10}}), iconTransformation(
            extent={{-20,-20},{20,20}})));
    Modelica.Blocks.Sources.BooleanConstant PumpOnOff
      annotation (Placement(transformation(extent={{-134,-94},{-114,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(tableOnFile=false, table=
          MeasuredData.AC_3000)
      annotation (Placement(transformation(extent={{-216,30},{-196,50}})));


     parameter Boolean allowFlowReversal=true
                                     "=true allow flow reversal" annotation(choices(choice=true,choice=false));

    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinFWDIN
      annotation (Placement(transformation(extent={{-192,-8},{-204,4}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinFWRDOUT
      annotation (Placement(transformation(extent={{-194,-38},{-206,-26}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNIN
      annotation (Placement(transformation(extent={{-194,-22},{-206,-10}})));
    Modelica.Blocks.Math.Gain VFOutvolumepersec(k=1/3600)
      annotation (Placement(transformation(extent={{-194,110},{-202,118}})));
    Modelica.Blocks.Math.Gain VFINvolumepersec(k=1/3600)
      annotation (Placement(transformation(extent={{-194,92},{-202,100}})));
    inner Modelica.Fluid.System systemWaterinner(
      m_flow_start=0.801,
      p_ambient=300000,
      final T_ambient=293.15,
      T_start=287.86) annotation (Evaluate=false, Placement(transformation(extent=
             {{46,116},{66,136}})));

    inner Modelica.Fluid.System systemAir(
      m_flow_start=0.9,
      T_start(displayUnit="K") = 289.31,
      p_ambient=300000,
      final T_ambient=293.15) annotation (Evaluate=false, Placement(
          transformation(extent={{16,116},{36,136}})));

    inner Modelica.Fluid.System systemWaterouter(
      m_flow_start=0.801,
      p_ambient=300000,
      final T_ambient=293.15,
      T_start=312.05) annotation (Evaluate=false, Placement(transformation(extent=
             {{76,116},{96,136}})));

    AixLib.Systems.AirHandlingUnit.BaseClasses.BaseCircuits.Admix_Circuit
      admix_Circuit(
      replaceable package MediumAir = MediumAir,
      replaceable package MediumWater = MediumWater,
      m_flow_nom_Air=3000/3600*1.18,
      m_flow_nom_Water=2886/3600,
      tauSensorAir=257.22,
      tauSensorWater=5.437,
      basicHXnew(
        dp_nom_Air(displayUnit="Pa") = 66,
        final T_start_Water=systemWaterinner.T_start,
        replaceable package MediumAir = MediumAir,
        replaceable package MediumWater = MediumWater,
        allowFlowReversal1=allowFlowReversal,
        allowFlowReversal2=allowFlowReversal,
        allowFlowReversal=allowFlowReversal,
        nNodes=5,
        final m_flow_start_Air=systemAir.m_flow_start,
        final m_flow_start_Water=systemWaterinner.m_flow_start,
        volume_Air=0.5,
        volume_Water=0.002,
        final T_start_Air=systemAir.T_start,
        dp_nom_Water(displayUnit="Pa") = 6000,
        C_wall_Water=5000,
        C_wall_Air=8000,
        Gc=1200),
      Circuit(
        redeclare package Medium = MediumWater,
        final allowFlowReversal=allowFlowReversal,
        T_start=systemWaterinner.T_start,
        T_start_outercir=systemWaterouter.T_start,
        T_amb=systemWaterinner.T_ambient,
        vol=0.0005,
        dIns=0.06,
        kIns=0.035,
        d=0.055,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_Calibrator
          basicPumpInterface(allowFlowReversal=true, pumpN(
            calculatePower=true,
            calculateEfficiency=true,
            pumpParam=Zugabe.Zugabe_DB.Pump.YonosMaxo_25_05_7())),
        val(
          tau=1,
          deltaM=0.02,
          dpFixed_nominal={100,100},
          use_inputFilter=false,
          CvData=AixLib.Fluid.Types.CvTypes.Kv,
          Kv=10,
          l={0.0001,0.0001},
          R=50,
          delta0=0.01,
          fraK=0.7,
          realValve12(table=[0,0; 0.1,0.00290929; 0.2,0.00322773; 0.3,
                0.00714524; 0.4,0.17871218; 0.5,0.44554323; 0.6,0.6011202; 0.7,
                0.72506515; 0.8,0.85768011; 0.9,0.94608335; 1,1]),
          realValve23(table=[0,0; 0.1,0.00586236; 0.2,0.00429644; 0.3,
                0.53517067; 0.4,0.70040852; 0.5,0.78625288; 0.6,0.88619545; 0.7,
                0.95347524; 0.8,0.9891073; 0.9,0.98595775; 1,1])),
        pipe1(
          length=1.53,
          final dh=0.0272,
          fac=1),
        pipe2(
          length=0.54,
          final dh=0.0272,
          fac=1),
        pipe3(
          length=1.06,
          final dh=0.0359,
          fac=1),
        pipe4(
          length=0.48,
          final dh=0.0359,
          fac=1),
        final pipe5(
          length=1.42,
          dh=0.0272,
          fac=1),
        pipe6(
          roughness=0,
          length=0.52,
          final dh=0.0272,
          fac=1)))     annotation (Placement(transformation(extent={{-60,-70},{60,
              92}})), choicesAllMatching=true);
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNOUT
      annotation (Placement(transformation(extent={{-194,-50},{-206,-38}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinAIROUT
      annotation (Placement(transformation(extent={{-194,-66},{-206,-54}})));
  equation
    connect(Pressure_in_Pa1.y, Sink.p_in) annotation (Line(points={{43,-134},{32,-134},
            {32,-124}},                               color={0,0,127}));
    connect(Pressure_in_Pa.y, Source.p_in) annotation (Line(points={{3,-134},{-16,
            -134},{-16,-124},{-18,-124}},                       color={0,0,127}));
    connect(toKelvin.Kelvin, Source.T_in) annotation (Line(points={{-42.8,-128},{-22,
            -128},{-22,-124}},                                  color={0,0,127}));
    connect(boundary.T_in, toKelvin1.Kelvin) annotation (Line(points={{-110,84},{-120,
            84},{-120,62},{-126.8,62}},
                                      color={0,0,127}));
    connect(boundary.m_flow_in, toMassflow.y) annotation (Line(points={{-108,88},{
            -118,88},{-118,98},{-131,98}}, color={0,0,127}));
    connect(PumpOnOff.y, hydraulicBus.pumpBus.onOff_Input) annotation (Line(
          points={{-113,-84},{-90,-84},{-90,-34},{-90,-30},{-89.9,-30},{-89.9,-29.9}},
          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[7], toMassflow.u) annotation (Line(points={{-195,40},
            {-168,40},{-168,98},{-154,98}}, color={0,0,127}));
    connect(combiTimeTable.y[5], toKelvin1.Celsius) annotation (Line(points={{-195,40},
            {-164,40},{-164,62},{-154.4,62}},     color={0,0,127}));
    connect(combiTimeTable.y[2], toKelvin.Celsius) annotation (Line(points={{-195,40},
            {-172,40},{-172,-128},{-70.4,-128}},     color={0,0,127}));
    connect(combiTimeTable.y[2], toKelvinFWDIN.Celsius) annotation (Line(points={{-195,40},
            {-182,40},{-182,-2},{-190.8,-2}},              color={0,0,127}));
    connect(combiTimeTable.y[3], toKelvinFWRDOUT.Celsius) annotation (Line(points={{-195,40},
            {-182,40},{-182,-32},{-192.8,-32}},             color={0,0,127}));
    connect(combiTimeTable.y[4], toKelvinRTRNIN.Celsius) annotation (Line(points={{-195,40},
            {-182,40},{-182,-16},{-192.8,-16}},             color={0,0,127}));
    connect(combiTimeTable.y[8], VFOutvolumepersec.u) annotation (Line(points={{-195,40},
            {-182,40},{-182,114},{-193.2,114}},   color={0,0,127}));
    connect(combiTimeTable.y[9], VFINvolumepersec.u) annotation (Line(points={{-195,40},
            {-182,40},{-182,96},{-193.2,96}},     color={0,0,127}));
    connect(admix_Circuit.port_airIn, boundary.ports[1]) annotation (Line(points={{-60,
            67.0769},{-72,67.0769},{-72,80},{-88,80}},      color={0,127,255}));
    connect(admix_Circuit.port_airOut, SinkAir.ports[1]) annotation (Line(points={{60,
            67.0769},{69,67.0769},{69,80},{76,80}},     color={0,127,255}));
    connect(admix_Circuit.port_rtrnOut, Sink.ports[1]) annotation (Line(points={{36,-70},
            {36,-86},{24,-86},{24,-102}},        color={0,127,255}));
    connect(Source.ports[1], admix_Circuit.port_fwrdIn) annotation (Line(points={{-26,
            -102},{-26,-88},{-36,-88},{-36,-70}},         color={0,127,255}));
    connect(hydraulicBus, admix_Circuit.hydraulicBus) annotation (Line(
        points={{-90,-30},{-76,-30},{-76,-18.9077},{-57.6,-18.9077}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(toProcent.y, hydraulicBus.valSet) annotation (Line(points={{-109,2},{-89.9,
            2},{-89.9,-29.9}},        color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[1], toKelvinRTRNOUT.Celsius) annotation (Line(points={{-195,40},
            {-182,40},{-182,-44},{-192.8,-44}},           color={0,0,127}));
    connect(combiTimeTable.y[6], toKelvinAIROUT.Celsius) annotation (Line(
          points={{-195,40},{-182,40},{-182,-60},{-192.8,-60}}, color={0,0,127}));
    connect(combiTimeTable.y[13], hydraulicBus.pumpBus.rpm_Input) annotation (
        Line(points={{-195,40},{-144,40},{-144,-29.9},{-89.9,-29.9}}, color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[12], toProcent.u) annotation (Line(points={{-195,
            40},{-144,40},{-144,2},{-132,2}}, color={0,0,127}));
    annotation (experiment(StartTime=0,StopTime=4554,Interval=1),Diagram(coordinateSystem(extent={{-220,-140},{100,140}})),
                                                                        Icon(
          coordinateSystem(extent={{-100,-100},{80,100}})));
  end Admix_Calibrator;

  model Injection_Calibrator

      Zugabe.Zugabe_DB.MeasuredData.AHU2_Reheater_RampValve_Injection MeasuredData;

    replaceable package MediumWater =
        Modelica.Media.Water.ConstantPropertyLiquidWater;
    replaceable package MediumAir=AixLib.Media.Air;

    Modelica.Fluid.Sources.FixedBoundary SinkAir(          redeclare package
        Medium = MediumAir, nPorts=1,
      T(displayUnit="K"))                                  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={86,80})));
    Modelica.Fluid.Sources.Boundary_pT Sink(use_p_in=true,
      redeclare package Medium = MediumWater,
      nPorts=1)                                                      annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={24,-112})));
    Modelica.Fluid.Sources.Boundary_pT Source(
      use_p_in=true,
      use_T_in=true,
      redeclare package Medium = MediumWater,
      nPorts=1) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-26,-112})));
    Modelica.Blocks.Sources.RealExpression Pressure_in_Pa1(y=300000) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={54,-134})));
    Modelica.Blocks.Sources.RealExpression Pressure_in_Pa(y=300000) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={14,-134})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
      annotation (Placement(transformation(extent={{-68,-140},{-44,-116}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary(
      use_m_flow_in=true,
      use_T_in=true,
      redeclare package Medium = MediumAir,
      nPorts=1)
      annotation (Placement(transformation(extent={{-108,70},{-88,90}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
      annotation (Placement(transformation(extent={{-152,50},{-128,74}})));
    Modelica.Blocks.Math.Gain toMassflow(k=1.1839/3600)
      annotation (Placement(transformation(extent={{-152,88},{-132,108}})));
    Modelica.Blocks.Math.Gain toProcent(k=0.01)
      annotation (Placement(transformation(extent={{-146,-8},{-126,12}})));
    HydraulicModules.BaseClasses.HydraulicBus hydraulicBus annotation (Placement(
          transformation(extent={{-110,-50},{-70,-10}}), iconTransformation(
            extent={{-20,-20},{20,20}})));
    Modelica.Blocks.Sources.BooleanConstant PumpOnOff
      annotation (Placement(transformation(extent={{-134,-94},{-114,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(tableOnFile=false, table=
          MeasuredData.AC)
      annotation (Placement(transformation(extent={{-218,30},{-198,50}})));


     parameter Boolean allowFlowReversal=true
                                     "=true allow flow reversal" annotation(choices(choice=true,choice=false));

    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinFWDIN
      annotation (Placement(transformation(extent={{-192,-8},{-204,4}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinFWRDOUT
      annotation (Placement(transformation(extent={{-194,-38},{-206,-26}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNIN
      annotation (Placement(transformation(extent={{-194,-22},{-206,-10}})));
    Modelica.Blocks.Math.Gain VFOutvolumepersec(k=1/3600)
      annotation (Placement(transformation(extent={{-194,110},{-202,118}})));
    Modelica.Blocks.Math.Gain VFINvolumepersec(k=1/3600)
      annotation (Placement(transformation(extent={{-194,92},{-202,100}})));
    inner Modelica.Fluid.System systemWaterinner(
      m_flow_start=0.801,
      p_ambient=300000,
      final T_ambient=293.15,
      T_start=287.86) annotation (Evaluate=false, Placement(transformation(extent=
             {{46,116},{66,136}})));

    inner Modelica.Fluid.System systemAir(
      m_flow_start=0.9,
      T_start(displayUnit="K") = 289.31,
      p_ambient=300000,
      final T_ambient=293.15) annotation (Evaluate=false, Placement(
          transformation(extent={{16,116},{36,136}})));

    inner Modelica.Fluid.System systemWaterouter(
      m_flow_start=0.801,
      p_ambient=300000,
      final T_ambient=293.15,
      T_start=312.05) annotation (Evaluate=false, Placement(transformation(extent=
             {{76,116},{96,136}})));

    BaseCircuits.Injection_Circuit injection_Circuit(
      replaceable package MediumAir = MediumAir,
      replaceable package MediumWater = MediumWater,
      m_flow_nom_Air=3000/3600*1.18,
      m_flow_nom_Water=2886/3600,
      tauSensorAir=176.3,
      tauSensorWater=5,
      basicHXnew(
        dp_nom_Air(displayUnit="Pa") = 66,
        final T_start_Water=systemWaterinner.T_start,
        replaceable package MediumAir = MediumAir,
        replaceable package MediumWater = MediumWater,
        allowFlowReversal1=allowFlowReversal,
        allowFlowReversal2=allowFlowReversal,
        allowFlowReversal=allowFlowReversal,
        nNodes=5,
        final m_flow_start_Air=systemAir.m_flow_start,
        final m_flow_start_Water=systemWaterinner.m_flow_start,
        volume_Air=0.5,
        volume_Water=0.002,
        final T_start_Air=systemAir.T_start,
        C_wall_Air=8000,
        C_wall_Water=5000,
        Gc=1200,
        dp_nom_Water(displayUnit="Pa") = 6000),
      Circuit(
        redeclare package Medium = MediumWater,
        final allowFlowReversal=allowFlowReversal,
        T_start=systemWaterinner.T_start,
        T_start_outercir=systemWaterouter.T_start,
        T_amb=systemWaterinner.T_ambient,
        vol=0.0005,
        dIns=0.06,
        kIns=0.035,
        d=0.055,
        pipe1(
          length=1.53,
          final dh=0.0272,
          fac=1),
        pipe2(
          length=0.54,
          final dh=0.0272,
          fac=1),
        pipe4(
          length=0.48,
          final dh=0.0359,
          fac=1),
        final pipe5(
          length=1.42,
          dh=0.0272,
          fac=1),
        pipe6(
          roughness=0,
          length=0.52,
          final dh=0.0272,
          fac=1),
        val(
          tau=1,
          deltaM=0.02,
          l={0.001,0.001},
          R=50,
          delta0=0.01,
          dpFixed_nominal={100,100},
          use_inputFilter=false,
          Kv=10,
          fraK=0.7,
          realValve12(table=[0,0; 0.1,0.01; 0.2,0.01; 0.3,0.05; 0.4,0.1; 0.5,
                0.3; 0.6,0.5; 0.7,0.7; 0.8,0.9; 0.9,0.99; 1,1]),
          realValve23(table=[0,0; 0.1,0.01; 0.2,0.01; 0.3,0.53; 0.4,0.75; 0.5,
                0.83; 0.6,0.9; 0.7,0.95; 0.8,1; 0.9,1; 1,1])),
        pipe3(
          length=1.06,
          final dh=0.0359,
          fac=1),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_Calibrator
          basicPumpInterface(pumpN(pumpParam=
                Zugabe.Zugabe_DB.Pump.YonosMulti_1_8()))))
                   annotation (Placement(transformation(extent={{-62,-66},{58,96}})),
        choicesAllMatching=true);
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNOUT
      annotation (Placement(transformation(extent={{-194,-50},{-206,-38}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinAIROUT
      annotation (Placement(transformation(extent={{-194,-66},{-206,-54}})));
    Modelica.Blocks.Math.Gain VFinjection(k=1/3600)
      annotation (Placement(transformation(extent={{-194,74},{-202,82}})));
  equation
    connect(Pressure_in_Pa1.y, Sink.p_in) annotation (Line(points={{43,-134},{32,-134},
            {32,-124}},                               color={0,0,127}));
    connect(Pressure_in_Pa.y, Source.p_in) annotation (Line(points={{3,-134},{-16,
            -134},{-16,-124},{-18,-124}},                       color={0,0,127}));
    connect(toKelvin.Kelvin, Source.T_in) annotation (Line(points={{-42.8,-128},{-22,
            -128},{-22,-124}},                                  color={0,0,127}));
    connect(boundary.T_in, toKelvin1.Kelvin) annotation (Line(points={{-110,84},{-120,
            84},{-120,62},{-126.8,62}},
                                      color={0,0,127}));
    connect(boundary.m_flow_in, toMassflow.y) annotation (Line(points={{-108,88},{
            -118,88},{-118,98},{-131,98}}, color={0,0,127}));
    connect(PumpOnOff.y, hydraulicBus.pumpBus.onOff_Input) annotation (Line(
          points={{-113,-84},{-90,-84},{-90,-34},{-90,-30},{-89.9,-30},{-89.9,-29.9}},
          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[7], toMassflow.u) annotation (Line(points={{-197,40},
            {-168,40},{-168,98},{-154,98}}, color={0,0,127}));
    connect(combiTimeTable.y[5], toKelvin1.Celsius) annotation (Line(points={{-197,40},
            {-164,40},{-164,62},{-154.4,62}},     color={0,0,127}));
    connect(combiTimeTable.y[2], toKelvin.Celsius) annotation (Line(points={{-197,40},
            {-172,40},{-172,-128},{-70.4,-128}},     color={0,0,127}));
    connect(combiTimeTable.y[2], toKelvinFWDIN.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-2},{-190.8,-2}},              color={0,0,127}));
    connect(combiTimeTable.y[3], toKelvinFWRDOUT.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-32},{-192.8,-32}},             color={0,0,127}));
    connect(combiTimeTable.y[4], toKelvinRTRNIN.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-16},{-192.8,-16}},             color={0,0,127}));
    connect(combiTimeTable.y[8], VFOutvolumepersec.u) annotation (Line(points={{-197,40},
            {-182,40},{-182,114},{-193.2,114}},   color={0,0,127}));
    connect(combiTimeTable.y[9], VFINvolumepersec.u) annotation (Line(points={{-197,40},
            {-182,40},{-182,96},{-193.2,96}},     color={0,0,127}));
    connect(injection_Circuit.port_airIn, boundary.ports[1]) annotation (Line(
          points={{-62,71.0769},{-72,71.0769},{-72,80},{-88,80}}, color={0,127,255}));
    connect(injection_Circuit.port_airOut, SinkAir.ports[1]) annotation (Line(
          points={{58,71.0769},{69,71.0769},{69,80},{76,80}}, color={0,127,255}));
    connect(injection_Circuit.port_rtrnOut, Sink.ports[1]) annotation (Line(
          points={{34,-66},{34,-86},{24,-86},{24,-102}}, color={0,127,255}));
    connect(Source.ports[1], injection_Circuit.port_fwrdIn) annotation (Line(
          points={{-26,-102},{-26,-88},{-38,-88},{-38,-66}}, color={0,127,255}));
    connect(hydraulicBus, injection_Circuit.hydraulicBus) annotation (Line(
        points={{-90,-30},{-76,-30},{-76,-16.1538},{-62,-16.1538}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(toProcent.y, hydraulicBus.valSet) annotation (Line(points={{-125,2},
            {-89.9,2},{-89.9,-29.9}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[1], toKelvinRTRNOUT.Celsius) annotation (Line(points=
           {{-197,40},{-182,40},{-182,-44},{-192.8,-44}}, color={0,0,127}));
    connect(combiTimeTable.y[6], toKelvinAIROUT.Celsius) annotation (Line(
          points={{-197,40},{-182,40},{-182,-60},{-192.8,-60}}, color={0,0,127}));
    connect(combiTimeTable.y[10], toProcent.u) annotation (Line(points={{-197,40},
            {-158,40},{-158,2},{-148,2}}, color={0,0,127}));
    connect(combiTimeTable.y[11], hydraulicBus.pumpBus.rpm_Input) annotation (
        Line(points={{-197,40},{-158,40},{-158,-29.9},{-89.9,-29.9}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[12], VFinjection.u) annotation (Line(points={{-197,
            40},{-182,40},{-182,78},{-193.2,78}}, color={0,0,127}));
    annotation (experiment(StartTime=0,StopTime=2089,Interval=1),Diagram(coordinateSystem(extent={{-220,-140},{100,140}})),
                                                                        Icon(
          coordinateSystem(extent={{-100,-100},{80,100}})));
  end Injection_Calibrator;

  model Throttle_Calibrator

    Zugabe.Zugabe_DB.MeasuredData.AHU2_Preheater_RampValve_Throttle MeasuredData;

    replaceable package MediumWater =
        Modelica.Media.Water.ConstantPropertyLiquidWater;
    replaceable package MediumAir=AixLib.Media.Air;

    Modelica.Fluid.Sources.FixedBoundary SinkAir(          redeclare package
        Medium = MediumAir, nPorts=1,
      T(displayUnit="K"))                                  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={86,80})));
    Modelica.Fluid.Sources.Boundary_pT Sink(use_p_in=true,
      redeclare package Medium = MediumWater,
      nPorts=1)                                                      annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={24,-112})));
    Modelica.Fluid.Sources.Boundary_pT Source(
      use_p_in=true,
      use_T_in=true,
      redeclare package Medium = MediumWater,
      nPorts=1) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-26,-112})));
    Modelica.Blocks.Sources.RealExpression Pressure_in_Pa1(y=300000) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={54,-134})));
    Modelica.Blocks.Sources.RealExpression Pressure_in_Pa(y=300000) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={14,-134})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
      annotation (Placement(transformation(extent={{-68,-140},{-44,-116}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary(
      use_m_flow_in=true,
      use_T_in=true,
      redeclare package Medium = MediumAir,
      nPorts=1)
      annotation (Placement(transformation(extent={{-108,70},{-88,90}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
      annotation (Placement(transformation(extent={{-152,50},{-128,74}})));
    Modelica.Blocks.Math.Gain toMassflow(k=1.1839/3600)
      annotation (Placement(transformation(extent={{-152,88},{-132,108}})));
    Modelica.Blocks.Math.Gain toProcent(k=0.01)
      annotation (Placement(transformation(extent={{-146,-8},{-126,12}})));
    HydraulicModules.BaseClasses.HydraulicBus hydraulicBus annotation (Placement(
          transformation(extent={{-110,-50},{-70,-10}}), iconTransformation(
            extent={{-20,-20},{20,20}})));
    Modelica.Blocks.Sources.BooleanConstant PumpOnOff
      annotation (Placement(transformation(extent={{-134,-94},{-114,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(tableOnFile=false, table=
          MeasuredData.AC)
      annotation (Placement(transformation(extent={{-218,30},{-198,50}})));


     parameter Boolean allowFlowReversal=true
                                     "=true allow flow reversal" annotation(choices(choice=true,choice=false));

    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinFWDIN
      annotation (Placement(transformation(extent={{-192,-8},{-204,4}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinFWRDOUT
      annotation (Placement(transformation(extent={{-194,-38},{-206,-26}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNIN
      annotation (Placement(transformation(extent={{-194,-22},{-206,-10}})));
    Modelica.Blocks.Math.Gain VFOutvolumepersec(k=1/3600)
      annotation (Placement(transformation(extent={{-194,110},{-202,118}})));
    Modelica.Blocks.Math.Gain VFINvolumepersec(k=1/3600)
      annotation (Placement(transformation(extent={{-194,92},{-202,100}})));
    inner Modelica.Fluid.System systemWaterinner(
      m_flow_start=0.45,
      p_ambient=300000,
      final T_ambient=293.15,
      T_start=332.15) annotation (Evaluate=false, Placement(transformation(extent=
             {{46,116},{66,136}})));

    inner Modelica.Fluid.System systemAir(
      m_flow_start=0.9,
      p_ambient=300000,
      final T_ambient=293.15,
      T_start(displayUnit="degC") = 297.95)
                              annotation (Evaluate=false, Placement(
          transformation(extent={{16,116},{36,136}})));

    inner Modelica.Fluid.System systemWaterouter(
      m_flow_start=0.45,
      p_ambient=300000,
      final T_ambient=293.15,
      T_start=341.55) annotation (Evaluate=false, Placement(transformation(extent=
             {{76,116},{96,136}})));

    BaseCircuits.Throttle_Circuit throttle_Circuit(
      replaceable package MediumAir = MediumAir,
      replaceable package MediumWater = MediumWater,
      m_flow_nom_Air=3000/3600*1.18,
      tauSensorWater=5,
      tauSensorAir=176.3,
      basicHXnew(
        final T_start_Water=systemWaterinner.T_start,
        replaceable package MediumAir = MediumAir,
        replaceable package MediumWater = MediumWater,
        allowFlowReversal1=allowFlowReversal,
        allowFlowReversal2=allowFlowReversal,
        allowFlowReversal=allowFlowReversal,
        nNodes=5,
        final m_flow_start_Air=systemAir.m_flow_start,
        final m_flow_start_Water=systemWaterinner.m_flow_start,
        volume_Air=0.5,
        volume_Water=0.002,
        final T_start_Air=systemAir.T_start,
        Gc=1200,
        dp_nom_Air(displayUnit="Pa") = 66,
        dp_nom_Water(displayUnit="Pa") = 6000,
        C_wall_Water=5000,
        C_wall_Air=8000),
      m_flow_nom_Water=2886/3600,
      Circuit(
        redeclare package Medium = MediumWater,
        final allowFlowReversal=allowFlowReversal,
        T_start=systemWaterinner.T_start,
        T_start_outercir=systemWaterouter.T_start,
        T_amb=systemWaterinner.T_ambient,
        dIns=0.06,
        kIns=0.035,
        d=0.055,
        valveCharacteristics=true,
        val(
          deltaM=0.02,
          l=0.0001,
          use_inputFilter=false,
          dpFixed_nominal=100,
          Kv=4),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_Calibrator
          basicPumpInterface(pumpN(
            calculatePower=true,
            calculateEfficiency=true,
            Qstart=1.04,
            Hstart=0.9,
            pumpParam=Zugabe.Zugabe_DB.Pump.YonosMaxo_25_05_7())),
        valveChar(table=[0,0; 0.1,0.1; 0.2,0.2; 0.3,0.3; 0.4,0.4; 0.5,0.5; 0.6,
              0.6; 0.7,0.7; 0.8,0.8; 0.9,0.9; 1,1]),
        pipe1(
          final dh=0.0272,
          length=1.53,
          fac=12.97120256),
        pipe2(
          final dh=0.0272,
          length=0.54,
          fac=1.65935309),
        pipe3(
          final dh=0.0359,
          length=1.06,
          fac=7.30338234),
        pipe4(
          final dh=0.0272,
          length=1.9,
          fac=23.66193658)))
                        annotation (Placement(transformation(extent={{-62,-66},{58,
              96}})), choicesAllMatching=true);
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNOUT
      annotation (Placement(transformation(extent={{-194,-50},{-206,-38}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinAIROUT
      annotation (Placement(transformation(extent={{-194,-66},{-206,-54}})));
  equation
    connect(Pressure_in_Pa1.y, Sink.p_in) annotation (Line(points={{43,-134},{32,-134},
            {32,-124}},                               color={0,0,127}));
    connect(Pressure_in_Pa.y, Source.p_in) annotation (Line(points={{3,-134},{-16,
            -134},{-16,-124},{-18,-124}},                       color={0,0,127}));
    connect(toKelvin.Kelvin, Source.T_in) annotation (Line(points={{-42.8,-128},{-22,
            -128},{-22,-124}},                                  color={0,0,127}));
    connect(boundary.T_in, toKelvin1.Kelvin) annotation (Line(points={{-110,84},{-120,
            84},{-120,62},{-126.8,62}},
                                      color={0,0,127}));
    connect(boundary.m_flow_in, toMassflow.y) annotation (Line(points={{-108,88},{
            -118,88},{-118,98},{-131,98}}, color={0,0,127}));
    connect(PumpOnOff.y, hydraulicBus.pumpBus.onOff_Input) annotation (Line(
          points={{-113,-84},{-90,-84},{-90,-34},{-90,-30},{-89.9,-30},{-89.9,-29.9}},
          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[7], toMassflow.u) annotation (Line(points={{-197,40},
            {-168,40},{-168,98},{-154,98}}, color={0,0,127}));
    connect(combiTimeTable.y[5], toKelvin1.Celsius) annotation (Line(points={{-197,40},
            {-164,40},{-164,62},{-154.4,62}},     color={0,0,127}));
    connect(combiTimeTable.y[2], toKelvin.Celsius) annotation (Line(points={{-197,40},
            {-172,40},{-172,-128},{-70.4,-128}},     color={0,0,127}));
    connect(combiTimeTable.y[2], toKelvinFWDIN.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-2},{-190.8,-2}},              color={0,0,127}));
    connect(combiTimeTable.y[3], toKelvinFWRDOUT.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-32},{-192.8,-32}},             color={0,0,127}));
    connect(combiTimeTable.y[4], toKelvinRTRNIN.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-16},{-192.8,-16}},             color={0,0,127}));
    connect(combiTimeTable.y[8], VFOutvolumepersec.u) annotation (Line(points={{-197,40},
            {-182,40},{-182,114},{-193.2,114}},   color={0,0,127}));
    connect(combiTimeTable.y[9], VFINvolumepersec.u) annotation (Line(points={{-197,40},
            {-182,40},{-182,96},{-193.2,96}},     color={0,0,127}));
    connect(throttle_Circuit.port_airIn, boundary.ports[1]) annotation (Line(
          points={{-62,71.0769},{-72,71.0769},{-72,80},{-88,80}}, color={0,127,255}));
    connect(throttle_Circuit.port_airOut, SinkAir.ports[1]) annotation (Line(
          points={{58,71.0769},{69,71.0769},{69,80},{76,80}}, color={0,127,255}));
    connect(throttle_Circuit.port_rtrnOut, Sink.ports[1]) annotation (Line(points=
           {{34,-66},{34,-86},{24,-86},{24,-102}}, color={0,127,255}));
    connect(Source.ports[1], throttle_Circuit.port_fwrdIn) annotation (Line(
          points={{-26,-102},{-26,-88},{-38,-88},{-38,-66}}, color={0,127,255}));
    connect(hydraulicBus, throttle_Circuit.hydraulicBus) annotation (Line(
        points={{-90,-30},{-76,-30},{-76,-17.4},{-63.2,-17.4}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(toProcent.y, hydraulicBus.valSet) annotation (Line(points={{-125,2},
            {-89.9,2},{-89.9,-29.9}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[1], toKelvinRTRNOUT.Celsius) annotation (Line(points=
           {{-197,40},{-182,40},{-182,-44},{-192.8,-44}}, color={0,0,127}));
    connect(combiTimeTable.y[6], toKelvinAIROUT.Celsius) annotation (Line(
          points={{-197,40},{-182,40},{-182,-60},{-192.8,-60}}, color={0,0,127}));
    connect(combiTimeTable.y[10], toProcent.u) annotation (Line(points={{-197,40},
            {-160,40},{-160,2},{-148,2}}, color={0,0,127}));
    connect(combiTimeTable.y[11], hydraulicBus.pumpBus.rpm_Input) annotation (
        Line(points={{-197,40},{-160,40},{-160,-29.9},{-89.9,-29.9}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (experiment(StartTime=0,StopTime=5544,Interval=1),Diagram(coordinateSystem(extent={{-220,-140},{100,140}})),
                                                                        Icon(
          coordinateSystem(extent={{-100,-100},{80,100}})));
  end Throttle_Calibrator;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CalibratorSystems;
