within AixLib.Fluid.BoilerCHP.Examples;
model BoilerSystem "Example that illustrates use of boiler model"
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_m_flow_in=false,
    nPorts=1,
    redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity,
    m_flow=0.05,
    T=293.15)
    "Source"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    length=1,
    diameter=0.025,
    redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity)
    "Pressure drop"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient,
    p_ambient(displayUnit="Pa"))
    "Pressure drop"
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Boiler boiler(
    redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity,
    m_flow_nominal=0.03,
    redeclare model ExtControl =
        BaseClasses.Controllers.ExternalControlNightDayHC,
    declination=1.2,
    FA=0,
    paramHC=DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10(),
    riseTime=0,
    TN=0.05,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_11kW())
    "Boiler"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1, redeclare package Medium =
    Media.Specialized.Water.TemperatureDependentDensity)
    "Sink"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Sources.BooleanConstant on
    "Boiler is always on"
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    f=1/86400,
    phase=4.7123889803847,
    offset=273.15) "Ambient air temperature"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.BooleanConstant isNight(k=false)
    "No night-setback"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));

equation
  connect(source.ports[1], boiler.port_a)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,127,255}));
  connect(boiler.port_b, pipe.port_a)
    annotation (Line(points={{10,0},{30,0}}, color={0,127,255}));
  connect(pipe.port_b, sink.ports[1])
    annotation (Line(points={{50,0},{50,0},{60,0}}, color={0,127,255}));
  connect(on.y, boiler.isOn)
    annotation (Line(points={{-9,-40},{5,-40},{5,-9}}, color={255,0,255}));
  connect(sine.y, boiler.TAmbient) annotation (Line(points={{-39,70},{-14,70},{
          -14,7},{-7,7}}, color={0,0,127}));
  connect(isNight.y,boiler.switchToNightMode)  annotation (Line(points={{-39,40},
          {-30,40},{-18,40},{-18,4},{-7,4}}, color={255,0,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The simulation illustrates the behavior of <a href=
  \"AixLib.Fluid.BoilerCHP.Boiler\">AixLib.Fluid.BoilerCHP.Boiler</a>
  during a day. Flow temperature of the boiler can be compared to the
  heating curve produced by the internal controler of the boiler.
  Change the inlet water temperature, heat curve or day and night mode
  to see the reaction.
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Pooyan Jahangiri:<br/>
    Merged with AixLib
  </li>
  <li>
    <i>April 16, 2014 &#160;</i> by Ana Constantin:<br/>
    Formated documentation.
  </li>
  <li>by Pooyan Jahangiri:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end BoilerSystem;
