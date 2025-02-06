within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Validation;
model SprayHumidifier
  extends Modelica.Icons.Example;
  Fluid.Sources.Boundary_pT sin(redeclare package Medium = AixLib.Media.Air,
      nPorts=1)
    annotation (Placement(transformation(extent={{110,-70},{90,-50}})));
  Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = AixLib.Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-48,-70},{-28,-50}})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{62,-70},{82,-50}})));
  Modelica.Blocks.Sources.Ramp ramT(
    height=10,
    duration=1800,
    offset=298.15,
    startTime=3600)
    annotation (Placement(transformation(extent={{-90,2},{-70,22}})));
  Modelica.Blocks.Sources.Ramp ramXi(
    height=0.003,
    duration=1800,
    offset=0.003,
    startTime=7200)
    annotation (Placement(transformation(extent={{-92,-30},{-72,-10}})));
  Modelica.Blocks.Sources.Ramp ramMasFlo(
    height=1500/3600*1.2,
    duration=1800,
    offset=3000/3600*1.2,
    startTime=10800)
    annotation (Placement(transformation(extent={{-88,36},{-68,56}})));
  Modelica.Blocks.Sources.Constant TSet(k=1)
    annotation (Placement(transformation(extent={{-96,-88},{-76,-68}})));
  Modelica.Blocks.Math.Feedback resT
    annotation (Placement(transformation(extent={{78,-38},{98,-18}})));
  Modelica.Blocks.Sources.Constant XSet(k=0.008)
    annotation (Placement(transformation(extent={{-88,74},{-68,94}})));
  Modelica.Blocks.Math.Feedback resX
    annotation (Placement(transformation(extent={{48,-30},{68,-10}})));
  Modelica.Blocks.Math.Feedback resMas
    annotation (Placement(transformation(extent={{82,-16},{102,4}})));
  Fluid.Sensors.MassFractionTwoPort senMasFra(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SprayHumidifier
    adiHum(
    mWat_flow_nominal=2.5/3600,
    TWatIn=293.15,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal(displayUnit="Pa") = 20,
    redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple,
    k=50000) annotation (Placement(transformation(extent={{-18,-24},{2,-4}})));
  Fluid.Humidifiers.GenericHumidifier_u hum(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal=20,
    mWat_flow_nominal=2.5/3600,
    TLiqWat_in=293.15,
    steamHumidifier=false)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SprayHumidifier
    adiHum1(
    use_X_set=true,
    TWatIn=273.15,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal(displayUnit="Pa") = 20,
    redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple,
    k=50000) annotation (Placement(transformation(extent={{-10,72},{10,92}})));
  Fluid.Sources.MassFlowSource_T sou1(
    redeclare package Medium = Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-30,28},{-10,48}})));
  Fluid.Humidifiers.SprayAirWasher_X hum1(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=4500/3600,
    dp_nominal=20)
    annotation (Placement(transformation(extent={{8,30},{28,50}})));
  Fluid.Sensors.MassFractionTwoPort senMasFra1(redeclare package Medium =
        Media.Air, m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{36,30},{56,50}})));
  Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = Media.Air,
      m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{64,30},{84,50}})));
  Fluid.Sources.Boundary_pT sin1(redeclare package Medium = Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{114,30},{94,50}})));
  Modelica.Blocks.Math.Feedback resT1
    annotation (Placement(transformation(extent={{86,56},{106,76}})));
  Modelica.Blocks.Math.Feedback resX1
    annotation (Placement(transformation(extent={{58,68},{78,88}})));
  Modelica.Blocks.Math.Feedback resMas1
    annotation (Placement(transformation(extent={{32,82},{52,102}})));
equation
  connect(senTem.port_b, sin.ports[1])
    annotation (Line(points={{82,-60},{90,-60}}, color={0,127,255}));
  connect(ramT.y, sou.T_in) annotation (Line(points={{-69,12},{-62,12},{-62,-56},
          {-50,-56}}, color={0,0,127}));
  connect(ramXi.y, sou.Xi_in[1]) annotation (Line(points={{-71,-20},{-62,-20},{
          -62,-64},{-50,-64}}, color={0,0,127}));
  connect(ramMasFlo.y, sou.m_flow_in) annotation (Line(points={{-67,46},{-62,46},
          {-62,-52},{-50,-52}}, color={0,0,127}));
  connect(senTem.T, resT.u1)
    annotation (Line(points={{72,-49},{72,-28},{80,-28}}, color={0,0,127}));
  connect(senMasFra.port_b, senTem.port_a)
    annotation (Line(points={{50,-60},{62,-60}}, color={0,127,255}));
  connect(senMasFra.X, resX.u1)
    annotation (Line(points={{40,-49},{40,-20},{50,-20}}, color={0,0,127}));
  connect(sou.ports[1], hum.port_a)
    annotation (Line(points={{-28,-60},{-10,-60}}, color={0,127,255}));
  connect(hum.port_b, senMasFra.port_a)
    annotation (Line(points={{10,-60},{30,-60}}, color={0,127,255}));
  connect(ramMasFlo.y, adiHum.mAirIn_flow) annotation (Line(points={{-67,46},{-42,
          46},{-42,-6},{-19,-6}}, color={0,0,127}));
  connect(ramT.y, adiHum.TAirIn) annotation (Line(points={{-69,12},{-42,12},{-42,
          -9},{-19,-9}}, color={0,0,127}));
  connect(ramXi.y, adiHum.XAirIn) annotation (Line(points={{-71,-20},{-42,-20},
          {-42,-12},{-19,-12}}, color={0,0,127}));
  connect(TSet.y, adiHum.u) annotation (Line(points={{-75,-78},{-66,-78},{-66,-32},
          {-14,-32},{-14,-23.4}}, color={0,0,127}));
  connect(TSet.y, hum.u) annotation (Line(points={{-75,-78},{-18,-78},{-18,-54},
          {-11,-54}}, color={0,0,127}));
  connect(adiHum.TAirOut, resT.u2) annotation (Line(points={{3,-9},{26,-9},{26,
          -42},{88,-42},{88,-36}}, color={0,0,127}));
  connect(adiHum.XAirOut, resX.u2) annotation (Line(points={{3,-12},{26,-12},{
          26,-42},{58,-42},{58,-28}}, color={0,0,127}));
  connect(XSet.y, adiHum1.X_set) annotation (Line(points={{-67,84},{-48,84},{-48,
          96},{0,96},{0,92.2}}, color={0,0,127}));
  connect(ramMasFlo.y, adiHum1.mAirIn_flow) annotation (Line(points={{-67,46},{
          -42,46},{-42,90},{-11,90}}, color={0,0,127}));
  connect(ramT.y, adiHum1.TAirIn) annotation (Line(points={{-69,12},{-42,12},{-42,
          86},{-11,86},{-11,87}}, color={0,0,127}));
  connect(ramXi.y, adiHum1.XAirIn) annotation (Line(points={{-71,-20},{-42,-20},
          {-42,84},{-11,84}}, color={0,0,127}));
  connect(ramMasFlo.y, sou1.m_flow_in)
    annotation (Line(points={{-67,46},{-32,46}}, color={0,0,127}));
  connect(ramT.y, sou1.T_in) annotation (Line(points={{-69,12},{-42,12},{-42,42},
          {-32,42}}, color={0,0,127}));
  connect(ramXi.y, sou1.Xi_in[1]) annotation (Line(points={{-71,-20},{-42,-20},
          {-42,34},{-32,34}}, color={0,0,127}));
  connect(sou1.ports[1], hum1.port_a) annotation (Line(points={{-10,38},{0,38},
          {0,40},{8,40}}, color={0,127,255}));
  connect(hum1.port_b, senMasFra1.port_a) annotation (Line(points={{28,40},{32,
          40},{32,40},{36,40}}, color={0,127,255}));
  connect(senMasFra1.port_b, senTem1.port_a)
    annotation (Line(points={{56,40},{64,40}}, color={0,127,255}));
  connect(senTem1.port_b,sin1. ports[1])
    annotation (Line(points={{84,40},{94,40}}, color={0,127,255}));
  connect(senTem1.T, resT1.u1)
    annotation (Line(points={{74,51},{74,66},{88,66}}, color={0,0,127}));
  connect(adiHum1.TAirOut, resT1.u2) annotation (Line(points={{11,87},{26,87},{
          26,52},{96,52},{96,58}}, color={0,0,127}));
  connect(senMasFra1.X, resX1.u1)
    annotation (Line(points={{46,51},{46,78},{60,78}}, color={0,0,127}));
  connect(adiHum1.XAirOut, resX1.u2) annotation (Line(points={{11,84},{26,84},{
          26,64},{68,64},{68,70}}, color={0,0,127}));
  connect(XSet.y, hum1.X_w) annotation (Line(points={{-67,84},{-48,84},{-48,60},
          {-2,60},{-2,46},{6,46}}, color={0,0,127}));
  connect(hum1.mWat_flow,resMas1. u1) annotation (Line(points={{29,46},{30,46},
          {30,92},{34,92}}, color={0,0,127}));
  connect(adiHum.mWat_flow, resMas.u2) annotation (Line(points={{3,-19.4},{32,-19.4},
          {32,-14},{92,-14}}, color={0,0,127}));
  connect(adiHum1.mWat_flow, resMas1.u2)
    annotation (Line(points={{11,76.6},{42,76.6},{42,84}}, color={0,0,127}));
  connect(hum.mWat_flow, resMas.u1) annotation (Line(points={{11,-54},{32,-54},
          {32,-6},{84,-6}}, color={0,0,127}));
  annotation (experiment(
      StopTime=14400,
      Interval=5,
      Tolerance=1e-04,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>This example compares the steam humidifier component to the steam humidifier models in the <b>Fluid</b>-package. </p>
<p><br>The results show good agreement with small differences that can be explained the following way. </p>
<p><br>The enthalpy of condensing gas in the medium model of the <b>Fluid</b>-package use the enthalpy of vaporization at 0 &deg;C and the temperature difference to 0 &deg;C multiplied with the specific heat capacity of steam.</p>
<p>The components in this package calculate the enthalpy difference of liquid water from 100 &deg;C to the parameter <i>TWatIn</i>. Then the evaporation is calculated with the enthalpy of vaporization at 100 &deg;C. Additional increase in temperature is possible using the specific heat capacity of steam.</p>
</html>"));
end SprayHumidifier;
