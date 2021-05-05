within AixLib.Fluid.Humidifiers.Examples;
model GenericHumidifier_u
  "Model that demonstrates the steam and adiabtic humidifier"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Air;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=
     3000/1000/20 "Nominal mass flow rate";

  AixLib.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    use_T_in=false,
    nPorts=3,
    m_flow=3*m_flow_nominal,
    T=303.15) "Source"
    annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
  AixLib.Fluid.Humidifiers.GenericHumidifier_u steamHum(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=6000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    mWat_flow_nominal=m_flow_nominal*0.003,
    TLiqWat_in=293.15) "Steam humidifier" annotation (Placement(transformation(extent={{0,90},{20,110}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,90},{60,110}})));
  AixLib.Fluid.Humidifiers.GenericHumidifier_u adiabHum(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=6000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    mWat_flow_nominal=m_flow_nominal*0.003,
    TLiqWat_in=293.15,
    steamHumidifier=false) "Adiabatic humidifier" annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  AixLib.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    use_T_in=false,
    p(displayUnit="Pa") = Medium.p_default + 10000,
    T=303.15,
    nPorts=3) "Sink"   annotation (Placement(transformation(extent={{178,40},{158,
            60}})));
  Modelica.Blocks.Sources.Ramp ramp(duration=1200, startTime=100)
    annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
  Sensors.RelativeHumidityTwoPort senRelHum(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{74,90},{94,110}})));
  Sensors.RelativeHumidityTwoPort senRelHum2(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{74,-20},{94,0}})));
  AixLib.Fluid.Humidifiers.GenericHumidifier_u steamHum1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=6000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    mWat_flow_nominal=m_flow_nominal*0.003,
    TLiqWat_in=293.15,
    TVapFixed=false) "Steam humidifier" annotation (Placement(transformation(extent={{0,40},{
            20,60}})));
  Sensors.TemperatureTwoPort              senTem1(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Temperature sensor"
    annotation (Placement(transformation(extent={{38,40},{58,60}})));
  Sensors.RelativeHumidityTwoPort senRelHum1(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{72,40},{92,60}})));
equation
  connect(steamHum.port_b, senTem.port_a)
    annotation (Line(points={{20,100},{40,100}}, color={0,127,255}));
  connect(adiabHum.port_b, senTem2.port_a)
    annotation (Line(points={{20,-10},{40,-10}}, color={0,127,255}));

  connect(sou.ports[1], steamHum.port_a) annotation (Line(points={{-62,52.6667},
          {-50,52.6667},{-50,52},{-38,52},{-38,100},{0,100}}, color={0,127,255}));
  connect(ramp.y, steamHum.u)
    annotation (Line(points={{-39,130},{-1,130},{-1,106}}, color={0,0,127}));
  connect(ramp.y, adiabHum.u) annotation (Line(points={{-39,130},{-14,130},{-14,
          -4},{-1,-4}}, color={0,0,127}));
  connect(senTem.port_b, senRelHum.port_a)
    annotation (Line(points={{60,100},{74,100}}, color={0,127,255}));
  connect(senTem2.port_b, senRelHum2.port_a)
    annotation (Line(points={{60,-10},{74,-10}}, color={0,127,255}));
  connect(steamHum1.port_b, senTem1.port_a)
    annotation (Line(points={{20,50},{38,50}}, color={0,127,255}));
  connect(ramp.y, steamHum1.u) annotation (Line(points={{-39,130},{-14,130},{
          -14,56},{-1,56}}, color={0,0,127}));
  connect(senTem1.port_b, senRelHum1.port_a)
    annotation (Line(points={{58,50},{72,50}}, color={0,127,255}));
  connect(steamHum1.port_a, sou.ports[2])
    annotation (Line(points={{0,50},{-62,50}},  color={0,127,255}));
  connect(adiabHum.port_a, sou.ports[3]) annotation (Line(points={{0,-10},{-38,
          -10},{-38,52},{-62,52},{-62,47.3333}}, color={0,127,255}));
  connect(senRelHum.port_b, sin.ports[1]) annotation (Line(points={{94,100},{
          158,100},{158,52.6667}}, color={0,127,255}));
  connect(senRelHum1.port_b, sin.ports[2])
    annotation (Line(points={{92,50},{158,50}}, color={0,127,255}));
  connect(senRelHum2.port_b, sin.ports[3]) annotation (Line(points={{94,-10},{
          158,-10},{158,47.3333}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{200,
            200}})),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Fluid/Humidifiers/Examples/GenericHumidifier_u.mos"
        "Simulate and plot"),
    Documentation(info="<html><p>
  Model that demonstrates the use of the GenericHumidifier. The first
  humidifier adds steam with a temperature of 100°C to the air volume
  flow. The second calculates the vaporization temperature depending on
  the pressure. Due to the fact that the pressure is slightly higher
  than standard pressure in the sink, the results are slightly
  different. The third humidifier adds liquid water that evaporates.
  Thus, the temperature decreases in this case.
</p>
<ul>
  <li>October 22, 2019, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    experiment(StopTime=1400, Tolerance=1e-06));
end GenericHumidifier_u;
