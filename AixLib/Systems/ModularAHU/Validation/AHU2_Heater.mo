within AixLib.Systems.ModularAHU.Validation;
model AHU2_Heater "Heating register of ahu 2 in E.ON ERC testhall"
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  package MediumAir = AixLib.Media.Air
    annotation (choicesAllMatching=true);

  AixLib.Systems.ModularAHU.Validation.MeasuredData.AHU2_Reheater_RampValve data "Measured data";
  Fluid.Sources.Boundary_pT boundaryWaterSource(
    redeclare package Medium = MediumWater,
    use_T_in=true,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-80})));
  Fluid.Sources.Boundary_pT boundaryWaterSink(          redeclare package Medium =
               MediumWater, nPorts=1)
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
    annotation (Placement(transformation(extent={{-96,32},{-82,46}})));
  Modelica.Blocks.Math.Gain gain1(k=1.1839/3600)
    annotation (Placement(transformation(extent={{-94,20},{-86,28}})));
  RegisterModule registerModule(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare HydraulicModules.Admix hydraulicModule(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1(),
      parameterIso=AixLib.DataBase.Pipes.Insulation.Iso25pc(),
      tau=5,
      length=1,
      Kv=6.3,
      valve(use_inputFilter=false),
      pipe1(length=3),
      pipe2(length=0.63),
      pipe3(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(), length=
            1.85),
      pipe4(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(), length=
            0.4),
      pipe5(length=2.8),
      pipe6(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_16x1(), length=
            0.82),
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
        PumpInterface(pumpParam=
            AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_8_V5(),
          calculatePower=true)),
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=3000/3600,
    m2_flow_nominal=1106/3600,
    tau=60 + 20,
    T_amb=293.15,
    dynamicHX(
      dp1_nominal=33,
      dp2_nominal=4500 + 50500,
      nNodes=1,
      tau1=3,
      tau2=15,
      dT_nom=20.8,
      Q_nom=22300))
    annotation (Placement(transformation(extent={{-22,-26},{40,60}})));
  BaseClasses.RegisterBus registerBus1
    annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds valveCharacteristics(table=[0.0,0.0; 0.34,
        0.0; 0.4,0.003; 0.44,0.05; 0.52,0.22; 0.72,0.56; 0.89,0.95; 0.96,1; 1.0,
        1])
    annotation (Placement(transformation(extent={{-60,-6},{-48,6}})));
  Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.5,
    zeta=200,
    diameter=0.032) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-22,-52})));
equation
  connect(toKelvin.Kelvin, boundaryWaterSource.T_in)
    annotation (Line(points={{-57,-92},{-16,-92}}, color={0,0,127}));
  connect(toKelvin.Celsius, combiTimeTable.y[2]) annotation (Line(points={{-80,-92},
          {-106,-92},{-106,70},{-58,70},{-58,90},{-79,90}}, color={0,0,127}));
  connect(boundaryAirSource.T_in, toKelvin1.Kelvin) annotation (Line(points={{-72,
          36},{-76,36},{-76,39},{-81.3,39}}, color={0,0,127}));
  connect(toKelvin1.Celsius, combiTimeTable.y[5]) annotation (Line(points={{-97.4,
          39},{-97.4,54},{-58,54},{-58,90},{-79,90}}, color={0,0,127}));
  connect(gain1.y, boundaryAirSource.m_flow_in) annotation (Line(points={{-85.6,
          24},{-82,24},{-82,32},{-72,32}}, color={0,0,127}));
  connect(gain1.u, combiTimeTable.y[7]) annotation (Line(points={{-94.8,24},{-106,
          24},{-106,70},{-58,70},{-58,90},{-79,90}}, color={0,0,127}));
  connect(gain.u, combiTimeTable.y[10]) annotation (Line(points={{-80.8,0},{-106,
          0},{-106,70},{-58,70},{-58,90},{-79,90}}, color={0,0,127}));
  connect(registerModule.registerBus, registerBus1) annotation (Line(
      points={{-21.69,19.9769},{-38,19.9769},{-38,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(combiTimeTable.y[11], registerBus1.hydraulicBus.pumpBus.rpmSet)
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
  connect(gain.y, valveCharacteristics.u)
    annotation (Line(points={{-71.6,0},{-61.2,0}}, color={0,0,127}));
  connect(boundaryWaterSource.ports[1], hydraulicResistance.port_a) annotation (
     Line(points={{-20,-70},{-22,-70},{-22,-62}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, registerModule.port_a2)
    annotation (Line(points={{-22,-42},{-22,0.461538}}, color={0,127,255}));
  connect(valveCharacteristics.y[1], registerBus1.hydraulicBus.valveSet)
    annotation (Line(points={{-47.4,0},{-37.95,0},{-37.95,10.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Documentation(info="<html><p>
  This example compares the simulated behavior with measured data. The
  input filter of the valve is deactivated because the measured actual
  opening (includes opening delay already) is used.
</p>
<ul>
  <li>November 4, 2019, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    experiment(
      StopTime=4320,
      __Dymola_fixedstepsize=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/ModularAHU/Validation/Heater.mos"
        "Simulate and Plot"));
end AHU2_Heater;
