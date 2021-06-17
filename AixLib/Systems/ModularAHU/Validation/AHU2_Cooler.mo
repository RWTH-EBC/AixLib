within AixLib.Systems.ModularAHU.Validation;
model AHU2_Cooler "Cooling register of ahu 2 in E.ON ERC testhall"
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  package MediumAir = AixLib.Media.Air
    annotation (choicesAllMatching=true);

  AixLib.Systems.ModularAHU.Validation.MeasuredData.AHU2_Cooler_RampValve data "Measured data";
  Fluid.Sources.Boundary_pT boundaryWaterSource(
    redeclare package Medium = MediumWater,
    use_T_in=true,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-80})));
  Fluid.Sources.Boundary_pT boundaryWaterSink(          redeclare package
      Medium = MediumWater, nPorts=1)
                            annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={40,-80})));
  Fluid.Sources.MassFlowSource_T
                            boundaryAirSource(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = MediumAir,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,40})));
  Fluid.Sources.Boundary_pT boundaryAirSink(          redeclare package Medium =
        MediumAir, nPorts=1)
                   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,40})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=data.AC_3000)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression Simulation_VF_in_m3h(y=registerBus1.hydraulicBus.VFlowInMea
        *3600)
    annotation (Placement(transformation(extent={{80,-26},{100,-6}})));
  Modelica.Blocks.Sources.RealExpression Simulation_VF_out_m3h(y=registerBus1.hydraulicBus.VFlowOutMea
        *3600)
    annotation (Placement(transformation(extent={{80,-46},{100,-26}})));
  Modelica.Blocks.Math.Gain gain(k=0.01)
    annotation (Placement(transformation(extent={{-80,-4},{-72,4}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{-78,-102},{-58,-82}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-93,59})));
  Modelica.Blocks.Math.Gain gain1(k=1.1839/3600)
    annotation (Placement(transformation(extent={{-94,20},{-86,28}})));
  RegisterModule registerModule(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare HydraulicModules.Admix hydraulicModule(
      pipeModel="PlugFlowPipe",
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
      parameterIso=AixLib.DataBase.Pipes.Insulation.Iso25pc(),
      length=1,
      Kv=10,
      T_start=294.75,
      valveCharacteristic=
          AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(a_ab=
          AixLib.Fluid.Actuators.Valves.Data.Generic(y={0,0.07,0.12,0.45,0.65,
          0.89,0.93,0.96,1}, phi={0,0.001,0.002,0.08,0.29,0.75,0.94,0.98,1}),
          b_ab=AixLib.Fluid.Actuators.Valves.Data.Generic(y={0,0.1,0.2,0.26,
          0.52,0.8,0.9,0.95,1}, phi={0,0.001,0.002,0.05,0.45,0.96,0.98,0.99,1})),
      valve(use_inputFilter=false),
      pipe1(
        T_start=283.15,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x2(),
        length=4.5),
      pipe2(length=1.55),
      pipe3(length=0.9),
      pipe4(length=0.3),
      pipe5(length=2.95, fac=13),
      pipe6(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1_1(), length=
            0.5),
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
        PumpInterface(pumpParam=
            AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN32(),
          calculatePower=true)),
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=3000/3600,
    m2_flow_nominal=8832/3600,
    T_start=293.65,
    tau=90,
    T_amb=296.65,
    dynamicHX(
      dp1_nominal(displayUnit="bar") = 138,
      dp2_nominal(displayUnit="bar") = 70600,
      nNodes=4,
      T1_start=305.15,
      dT_nom=22.16,
      Q_nom=53400))
    annotation (Placement(transformation(extent={{-22,-26},{40,60}})));

  BaseClasses.RegisterBus registerBus1
    annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-90,34},{-78,46}})));
  Modelica.Blocks.Sources.Constant const(k=-0.5)
    annotation (Placement(transformation(extent={{-104,32},{-96,40}})));
equation
  connect(toKelvin.Kelvin, boundaryWaterSource.T_in)
    annotation (Line(points={{-57,-92},{-16,-92}}, color={0,0,127}));
  connect(toKelvin.Celsius, combiTimeTable.y[2]) annotation (Line(points={{-80,-92},
          {-106,-92},{-106,70},{-58,70},{-58,90},{-79,90}}, color={0,0,127}));
  connect(toKelvin1.Celsius, combiTimeTable.y[5]) annotation (Line(points={{-93,
          67.4},{-93,70},{-58,70},{-58,90},{-79,90}}, color={0,0,127}));
  connect(gain1.y, boundaryAirSource.m_flow_in) annotation (Line(points={{-85.6,
          24},{-82,24},{-82,32},{-72,32}}, color={0,0,127}));
  connect(gain1.u, combiTimeTable.y[7]) annotation (Line(points={{-94.8,24},{-106,
          24},{-106,70},{-58,70},{-58,90},{-79,90}}, color={0,0,127}));
  connect(gain.u, combiTimeTable.y[12]) annotation (Line(points={{-80.8,0},{-106,
          0},{-106,70},{-58,70},{-58,90},{-79,90}}, color={0,0,127}));
  connect(registerModule.registerBus, registerBus1) annotation (Line(
      points={{-21.69,19.9769},{-38,19.9769},{-38,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(combiTimeTable.y[13], registerBus1.hydraulicBus.pumpBus.rpmSet)
    annotation (Line(points={{-79,90},{-58,90},{-58,70},{-106,70},{-106,10.05},{
          -37.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boundaryWaterSink.ports[1], registerModule.port_b2)
    annotation (Line(points={{40,-70},{40,0.461538}}, color={0,127,255}));
  connect(boundaryAirSource.ports[1], registerModule.port_a1) annotation (Line(
        points={{-50,40},{-36,40},{-36,40.1538},{-22,40.1538}}, color={0,127,255}));
  connect(registerModule.port_b1, boundaryAirSink.ports[1]) annotation (Line(
        points={{40,40.1538},{55,40.1538},{55,40},{70,40}}, color={0,127,255}));
  connect(gain.y, registerBus1.hydraulicBus.valveSet) annotation (Line(points={{
          -71.6,0},{-37.95,0},{-37.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boundaryWaterSource.ports[1], registerModule.port_a2) annotation (
      Line(points={{-20,-70},{-22,-70},{-22,0.461538},{-22,0.461538}}, color={0,
          127,255}));
  connect(toKelvin1.Kelvin, add.u1) annotation (Line(points={{-93,51.3},{-92,
          51.3},{-92,50},{-91.2,50},{-91.2,43.6}},
                          color={0,0,127}));
  connect(add.y, boundaryAirSource.T_in) annotation (Line(points={{-77.4,40},{
          -72,40},{-72,36}},          color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{-95.6,36},{-94,36},{-94,
          36.4},{-91.2,36.4}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>This example compares the simulated behavior with measured data. The input filter of the valve is deactivated because the measured actual opening (includes opening delay already) is used.</p>
</html>", revisions="<html>
<ul>
<li>November 4, 2019, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>"),
    experiment(
      StopTime=2700,
      __Dymola_fixedstepsize=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/ModularAHU/Validation/Cooler.mos"
        "Simulate and Plot"));
end AHU2_Cooler;
