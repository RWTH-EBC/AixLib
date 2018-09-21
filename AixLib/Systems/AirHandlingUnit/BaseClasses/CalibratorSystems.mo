within AixLib.Systems.AirHandlingUnit.BaseClasses;
package CalibratorSystems
  model Admix_Calibrator

      Zugabe.Zugabe_DB.MeasuredData.AHU2_Preheater_StepResponse MeasuredData;

    replaceable package MediumWater =
        Modelica.Media.Water.ConstantPropertyLiquidWater;
    replaceable package MediumAir=AixLib.Media.Air;

    Modelica.Fluid.Sources.FixedBoundary SinkAir(          redeclare package
        Medium = MediumAir, nPorts=1)                      annotation (Placement(
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
          origin={24,-110})));
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
          MeasuredData.AC_3000)
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
      tauSensorAir=176.3,
      m_flow_nom_Air=3000/3600*1.18,
      basicHXnew(
        dp_nom_Air(displayUnit="Pa") = 66,
        C_wall_Water=5000,
        C_wall_Air=8000,
        Gc=1200,
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
        dp_nom_Water(displayUnit="Pa") = 6000),
      m_flow_nom_Water=2886/3600,
      tauSensorWater=5,
      Circuit(
        redeclare package Medium = MediumWater,
        final allowFlowReversal=allowFlowReversal,
        T_start=systemWaterinner.T_start,
        T_start_outercir=systemWaterouter.T_start,
        T_amb=systemWaterinner.T_ambient,
        vol=0.0005,
        val(
          tau=1,
          final T_start=systemWaterinner.T_start,
          deltaM=0.02,
          l={0.001,0.001},
          R=50,
          delta0=0.01,
          fraK=0.7,
          Kv=6.3,
          dpFixed_nominal={100,100},
          use_inputFilter=false),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          basicPumpInterface(pump(
            redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.TopS40slash7 per,
            addPowerToMedium=true,
            T_start=systemWaterinner.T_start)),
        valveCharacteristics=true,
        valveChar(final table=[0.0,0.0; 0.01,0.0; 0.02,0.0; 0.03,0.0; 0.04,0.0; 0.05,
              0.0; 0.06,0.0; 0.07,0.0; 0.08,0.0; 0.09,0.0; 0.1,0.0; 0.11,0.0; 0.12,
              0.0; 0.13,0.0; 0.14,0.0; 0.15,0.0; 0.16,0.0; 0.17,0.0; 0.18,0.0; 0.19,
              0.0; 0.2,0.0; 0.21,0.011; 0.22,0.011; 0.23,0.011; 0.24,0.012; 0.25,0.012;
              0.26,0.012; 0.27,0.013; 0.28,0.013; 0.29,0.014; 0.3,0.016; 0.31,0.018;
              0.32,0.02; 0.33,0.047; 0.34,0.092; 0.35,0.121; 0.36,0.153; 0.37,0.175;
              0.38,0.207; 0.39,0.231; 0.4,0.254; 0.41,0.274; 0.42,0.295; 0.43,0.313;
              0.44,0.329; 0.45,0.352; 0.46,0.373; 0.47,0.39; 0.48,0.414; 0.49,0.433;
              0.5,0.453; 0.51,0.485; 0.52,0.506; 0.53,0.528; 0.54,0.547; 0.55,0.561;
              0.56,0.579; 0.57,0.595; 0.58,0.61; 0.59,0.626; 0.6,0.639; 0.61,0.655;
              0.62,0.671; 0.63,0.683; 0.64,0.697; 0.65,0.711; 0.66,0.725; 0.67,0.736;
              0.68,0.749; 0.69,0.759; 0.7,0.771; 0.71,0.781; 0.72,0.796; 0.73,0.808;
              0.74,0.822; 0.75,0.834; 0.76,0.845; 0.77,0.859; 0.78,0.88; 0.79,0.893;
              0.8,0.904; 0.81,0.911; 0.82,0.926; 0.83,0.935; 0.84,0.941; 0.85,0.948;
              0.86,0.95; 0.87,0.962; 0.88,0.965; 0.89,0.97; 0.9,0.975; 0.91,0.98;
              0.92,0.984; 0.93,0.987; 0.94,0.991; 0.95,0.993; 0.96,0.995; 0.97,0.995;
              0.98,0.997; 0.99,0.995; 1.0,1]),
        pipe2(
          length=0.54,
          final dh=0.0272,
          fac=4.582),
        pipe3(
          length=1.06,
          final dh=0.0359,
          fac=26.05),
        pipe4(
          length=0.48,
          final dh=0.0359,
          fac=9.268),
        pipe6(
          roughness=0,
          length=0.52,
          final dh=0.0272,
          fac=5.473),
        dIns=0.06,
        kIns=0.035,
        final pipe5(
          length=1.42,
          dh=0.0272,
          fac=23.58),
        pipe1(
          length=1.53,
          final dh=0.0272,
          fac=29.6574,
          T_start_in=311.15,
          T_start_out=311.15)))
                        annotation (Placement(transformation(extent={{-60,-66},{60,
              96}})), choicesAllMatching=true);
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNOUT
      annotation (Placement(transformation(extent={{-194,-50},{-206,-38}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinAIROUT
      annotation (Placement(transformation(extent={{-194,-66},{-206,-54}})));
  equation
    connect(Pressure_in_Pa1.y, Sink.p_in) annotation (Line(points={{43,-134},{32,-134},
            {32,-132},{32,-132},{32,-122},{32,-122}}, color={0,0,127}));
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
    connect(combiTimeTable.y[12], toProcent.u) annotation (Line(points={{-197,40},
            {-162,40},{-162,2},{-148,2}}, color={0,0,127}));
    connect(admix_Circuit.port_airIn, boundary.ports[1]) annotation (Line(points={{-60,
            71.0769},{-72,71.0769},{-72,80},{-88,80}},      color={0,127,255}));
    connect(admix_Circuit.port_airOut, SinkAir.ports[1]) annotation (Line(points={{60,
            71.0769},{69,71.0769},{69,80},{76,80}},     color={0,127,255}));
    connect(admix_Circuit.port_rtrnOut, Sink.ports[1]) annotation (Line(points={{36,-66},
            {36,-86},{24,-86},{24,-100}},        color={0,127,255}));
    connect(Source.ports[1], admix_Circuit.port_fwrdIn) annotation (Line(points={{-26,
            -102},{-26,-88},{-36,-88},{-36,-66}},         color={0,127,255}));
    connect(hydraulicBus, admix_Circuit.hydraulicBus) annotation (Line(
        points={{-90,-30},{-76,-30},{-76,-14.9077},{-57.6,-14.9077}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(combiTimeTable.y[13], hydraulicBus.pumpBus.rpm_Input) annotation (
        Line(points={{-197,40},{-168,40},{-168,-29.9},{-89.9,-29.9}}, color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(toProcent.y, hydraulicBus.valSet) annotation (Line(points={{-125,2},
            {-89.9,2},{-89.9,-29.9}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[1], toKelvinRTRNOUT.Celsius) annotation (Line(points=
           {{-197,40},{-182,40},{-182,-44},{-192.8,-44}}, color={0,0,127}));
    connect(combiTimeTable.y[6], toKelvinAIROUT.Celsius) annotation (Line(
          points={{-197,40},{-182,40},{-182,-60},{-192.8,-60}}, color={0,0,127}));
    annotation (experiment(StartTime=0,StopTime=4554),Diagram(coordinateSystem(extent={{-220,-140},{100,140}})),
                                                                        Icon(
          coordinateSystem(extent={{-100,-100},{80,100}})));
  end Admix_Calibrator;

  model Injection_Calibrator
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Injection_Calibrator;

  model Throttle_Calibrator
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Throttle_Calibrator;

  model Admix_realValveCurve

      Zugabe.Zugabe_DB.MeasuredData.AHU2_Preheater_RampValve MeasuredData;

    replaceable package MediumWater =
        Modelica.Media.Water.ConstantPropertyLiquidWater;
    replaceable package MediumAir=AixLib.Media.Air;

    Modelica.Fluid.Sources.FixedBoundary SinkAir(          redeclare package
        Medium = MediumAir, nPorts=1)                      annotation (Placement(
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
          origin={24,-110})));
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
          MeasuredData.AC_3000)
      annotation (Placement(transformation(extent={{-218,30},{-198,50}})));


     parameter Boolean allowFlowReversal=true
                                     "=true allow flow reversal" annotation(choices(choice=true,choice=false));

    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinFWDIN
      annotation (Placement(transformation(extent={{-192,-8},{-204,4}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinFWRDOUT
      annotation (Placement(transformation(extent={{-194,-38},{-206,-26}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNIN
      annotation (Placement(transformation(extent={{-192,-22},{-204,-10}})));
    Modelica.Blocks.Math.Gain VFOutvolumepersec(k=1/3600)
      annotation (Placement(transformation(extent={{-194,110},{-202,118}})));
    Modelica.Blocks.Math.Gain VFINvolumepersec(k=1/3600)
      annotation (Placement(transformation(extent={{-194,92},{-202,100}})));
    inner Modelica.Fluid.System systemWaterinner(
      m_flow_start=0.801,
      p_ambient=300000,
      final T_ambient=293.15) annotation (Evaluate=false, Placement(
          transformation(extent={{46,114},{66,134}})));
    AixLib.Systems.AirHandlingUnit.BaseClasses.BaseCircuits.Admix_Circuit
      admix_Circuit(
      replaceable package MediumAir = MediumAir,
      replaceable package MediumWater = MediumWater,
      tauSensorAir=176.3,
      tauSensorWater=5,
      m_flow_nom_Air=3000/3600*1.18,
      basicHXnew(
        dp_nom_Air(displayUnit="Pa") = 66,
        C_wall_Water=5000,
        C_wall_Air=8000,
        Gc=1200,
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
        dp_nom_Water(displayUnit="Pa") = 6000),
      m_flow_nom_Water=2886/3600,
      Circuit(
        redeclare package Medium = MediumWater,
        final allowFlowReversal=allowFlowReversal,
        T_start=systemWaterinner.T_start,
        T_start_outercir=systemWaterouter.T_start,
        T_amb=systemWaterinner.T_ambient,
        dIns=0.06,
        kIns=0.035,
        vol=0.0005,
        val(
          tau=1,
          final T_start=systemWaterinner.T_start,
          deltaM=0.02,
          l={0.001,0.001},
          R=50,
          delta0=0.01,
          fraK=0.7,
          Kv=6.3,
          dpFixed_nominal={100,100}),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          basicPumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.TopS40slash7 per,
              addPowerToMedium=true)),
        pipe1(
          T_start_in=systemWaterinner.T_start,
          T_start_out=systemWaterinner.T_start,
          length=1.53,
          final dh=0.0272,
          fac=29.6574),
        pipe2(
          T_start_in=systemWaterinner.T_start,
          T_start_out=systemWaterinner.T_start,
          length=0.54,
          final dh=0.0272,
          fac=4.582),
        pipe3(
          T_start_in=systemWaterinner.T_start,
          T_start_out=systemWaterinner.T_start,
          length=1.06,
          final dh=0.0359,
          fac=20.05),
        pipe4(
          T_start_in=systemWaterinner.T_start,
          T_start_out=systemWaterinner.T_start,
          length=0.48,
          final dh=0.0359,
          fac=9.268),
        final pipe5(
          T_start_in=systemWaterinner.T_start,
          T_start_out=systemWaterinner.T_start,
          length=1.42,
          dh=0.0272,
          fac=23.58),
        pipe6(
          T_start_in=systemWaterinner.T_start,
          T_start_out=systemWaterinner.T_start,
          roughness=0,
          length=0.52,
          final dh=0.0272,
          fac=5.473),
        valveChar(final table=[0.0,0.0; 0.01,0.0; 0.02,0.0; 0.03,0.0; 0.04,0.0;
              0.05,0.0; 0.06,0.0; 0.07,0.0; 0.08,0.0; 0.09,0.0; 0.1,0.0; 0.11,
              0.0; 0.12,0.0; 0.13,0.0; 0.14,0.0; 0.15,0.0; 0.16,0.0; 0.17,0.0;
              0.18,0.0; 0.19,0.0; 0.2,0.0; 0.21,0.011; 0.22,0.011; 0.23,0.011;
              0.24,0.012; 0.25,0.012; 0.26,0.012; 0.27,0.013; 0.28,0.013; 0.29,
              0.014; 0.3,0.016; 0.31,0.018; 0.32,0.02; 0.33,0.047; 0.34,0.092;
              0.35,0.121; 0.36,0.153; 0.37,0.175; 0.38,0.207; 0.39,0.231; 0.4,
              0.254; 0.41,0.274; 0.42,0.295; 0.43,0.313; 0.44,0.329; 0.45,0.352;
              0.46,0.373; 0.47,0.39; 0.48,0.414; 0.49,0.433; 0.5,0.453; 0.51,
              0.485; 0.52,0.506; 0.53,0.528; 0.54,0.547; 0.55,0.561; 0.56,0.579;
              0.57,0.595; 0.58,0.61; 0.59,0.626; 0.6,0.639; 0.61,0.655; 0.62,
              0.671; 0.63,0.683; 0.64,0.697; 0.65,0.711; 0.66,0.725; 0.67,0.736;
              0.68,0.749; 0.69,0.759; 0.7,0.771; 0.71,0.781; 0.72,0.796; 0.73,
              0.808; 0.74,0.822; 0.75,0.834; 0.76,0.845; 0.77,0.859; 0.78,0.88;
              0.79,0.893; 0.8,0.904; 0.81,0.911; 0.82,0.926; 0.83,0.935; 0.84,
              0.941; 0.85,0.948; 0.86,0.95; 0.87,0.962; 0.88,0.965; 0.89,0.97;
              0.9,0.975; 0.91,0.98; 0.92,0.984; 0.93,0.987; 0.94,0.991; 0.95,
              0.993; 0.96,0.995; 0.97,0.995; 0.98,0.997; 0.99,0.995; 1.0,1]),
        valveCharacteristics=true)) annotation (Placement(transformation(extent=
             {{-56,-68},{64,94}})), choicesAllMatching=true);
    inner Modelica.Fluid.System systemAir(
      m_flow_start=0.9,
      p_ambient=300000,
      final T_ambient=293.15) annotation (Evaluate=false, Placement(
          transformation(extent={{16,114},{36,134}})));
    inner Modelica.Fluid.System systemWaterouter(
      m_flow_start=0.801,
      p_ambient=300000,
      final T_ambient=293.15) annotation (Evaluate=false, Placement(
          transformation(extent={{76,114},{96,134}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinRTRNOUT
      annotation (Placement(transformation(extent={{-194,-50},{-206,-38}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvinAIROUT
      annotation (Placement(transformation(extent={{-194,-66},{-206,-54}})));
  equation
    connect(Pressure_in_Pa1.y, Sink.p_in) annotation (Line(points={{43,-134},{32,-134},
            {32,-132},{32,-132},{32,-122},{32,-122}}, color={0,0,127}));
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
            {-174,40},{-174,-128},{-70.4,-128}},     color={0,0,127}));
    connect(combiTimeTable.y[2], toKelvinFWDIN.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-2},{-190.8,-2}},              color={0,0,127}));
    connect(combiTimeTable.y[3], toKelvinFWRDOUT.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-32},{-192.8,-32}},             color={0,0,127}));
    connect(combiTimeTable.y[4], toKelvinRTRNIN.Celsius) annotation (Line(points={{-197,40},
            {-182,40},{-182,-16},{-190.8,-16}},             color={0,0,127}));
    connect(combiTimeTable.y[8], VFOutvolumepersec.u) annotation (Line(points={{-197,40},
            {-182,40},{-182,114},{-193.2,114}},   color={0,0,127}));
    connect(combiTimeTable.y[9], VFINvolumepersec.u) annotation (Line(points={{-197,40},
            {-182,40},{-182,96},{-193.2,96}},     color={0,0,127}));
    connect(combiTimeTable.y[12], toProcent.u) annotation (Line(points={{-197,40},
            {-162,40},{-162,2},{-148,2}}, color={0,0,127}));
    connect(admix_Circuit.port_airIn, boundary.ports[1]) annotation (Line(points={{-56,
            69.0769},{-72,69.0769},{-72,80},{-88,80}},      color={0,127,255}));
    connect(admix_Circuit.port_airOut, SinkAir.ports[1]) annotation (Line(points={{64,
            69.0769},{69,69.0769},{69,80},{76,80}},     color={0,127,255}));
    connect(admix_Circuit.port_rtrnOut, Sink.ports[1]) annotation (Line(points={{40,-68},
            {40,-86},{24,-86},{24,-100}},        color={0,127,255}));
    connect(Source.ports[1], admix_Circuit.port_fwrdIn) annotation (Line(points={{-26,
            -102},{-26,-88},{-32,-88},{-32,-68}},         color={0,127,255}));
    connect(hydraulicBus, admix_Circuit.hydraulicBus) annotation (Line(
        points={{-90,-30},{-76,-30},{-76,-16.9077},{-53.6,-16.9077}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(combiTimeTable.y[13], hydraulicBus.pumpBus.rpm_Input) annotation (
        Line(points={{-197,40},{-168,40},{-168,-29.9},{-89.9,-29.9}}, color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(toProcent.y, hydraulicBus.valSet) annotation (Line(points={{-125,2},
            {-89.9,2},{-89.9,-29.9}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(combiTimeTable.y[1], toKelvinRTRNOUT.Celsius) annotation (Line(
          points={{-197,40},{-182,40},{-182,-44},{-192.8,-44}}, color={0,0,127}));
    connect(combiTimeTable.y[6], toKelvinAIROUT.Celsius) annotation (Line(
          points={{-197,40},{-182,40},{-182,-60},{-192.8,-60}}, color={0,0,127}));
    annotation (experiment(StartTime=0,StopTime=7796,Interval=1),Diagram(coordinateSystem(extent={{-220,-140},{100,140}})),
                                                                        Icon(
          coordinateSystem(extent={{-100,-100},{80,100}})),
      __Dymola_Commands);
  end Admix_realValveCurve;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CalibratorSystems;
