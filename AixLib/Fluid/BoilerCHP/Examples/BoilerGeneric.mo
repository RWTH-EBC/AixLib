within AixLib.Fluid.BoilerCHP.Examples;
model BoilerGeneric
    extends Modelica.Icons.Example;

    package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);

  AixLib.Fluid.BoilerCHP.BoilerGeneric boiGen(
    redeclare package Medium = Medium,
    T_start=293.15,
    Q_flow_nominal=20000,
    TSup_nominal=353.15,
    TRet_nominal=333.15)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_m_flow_in=false,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=20/4.18/20,
    T=313.15,
    nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=40,
    duration=500,
    offset=293.15,
    startTime=60) "Return temperature"
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1, redeclare package Medium =
        Medium)
    "Sink"
    annotation (Placement(transformation(extent={{68,-10},{48,10}})));
  Controls.Continuous.LimPID conPID(u_m(unit="K"),
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    Td=1,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-44,58},{-24,78}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    f=100/(3600*24),
    phase=0,
    offset=273.15 + 75,
    startTime=700) "Ambient air temperature"
    annotation (Placement(transformation(extent={{-100,58},{-80,78}})));
  Controls.Interfaces.BoilerControlBus boiBus "Signal bus for boiler"
    annotation (Placement(transformation(extent={{-8,12},{12,32}})));
equation
  connect(boiGen.port_b, sink.ports[1])
    annotation (Line(points={{12,0},{48,0}}, color={0,127,255}));
  connect(ramp.y, source.T_in)
    annotation (Line(points={{-79,4},{-64,4}}, color={0,0,127}));
  connect(sine.y, conPID.u_s)
    annotation (Line(points={{-79,68},{-46,68}}, color={0,0,127}));
  connect(boiGen.boiBus, boiBus) annotation (Line(
      points={{2,10},{2,22}},
      color={255,204,51},
      thickness=0.5));
  connect(conPID.y, boiBus.yFirRatSet) annotation (Line(points={{-23,68},{2,68},
          {2,22}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiBus.TSupMea, conPID.u_m) annotation (Line(
      points={{2,22},{-32,22},{-32,56},{-34,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiGen.port_a, source.ports[1])
    annotation (Line(points={{-8,0},{-42,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(Tolerance=1e-6, StopTime=2000, __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/BoilerCHP/Examples/BoilerGeneric.mos"
        "Simulate and Plot"),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Example that demonstrates the behavior of <a href=
  \"AixLib.Fluid.BoilerCHP.BoilerGeneric\">AixLib.Fluid.BoilerCHP.BoilerGeneric.</a>
</p>
<p>
The firing rate of the boiler is controlled by a PI controller to hold a sine prescribed supply set point temperature, while the temperature of prescribed input massflow changes overt time.
</p>
</html>


", revisions="<html>
<ul>
<li>
<i>June, 2023</i> by Moritz Zuschlag; David Jansen<br/>
    First Implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1147\">#1147</a>)
</li>
</ul>
</html>"));
end BoilerGeneric;
