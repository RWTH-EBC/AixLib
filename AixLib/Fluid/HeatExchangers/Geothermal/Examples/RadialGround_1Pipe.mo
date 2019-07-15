within AixLib.Fluid.HeatExchangers.Geothermal.Examples;
model RadialGround_1Pipe
  "Simulation set-up for one pipe with a radial ground model"
  extends Modelica.Icons.Example;

     replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"
    annotation (choicesAllMatching=true);
    inner Modelica.Fluid.System system(T_ambient=281.15) annotation (Placement(transformation(extent={{-100,78},{-80,98}})));

public
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundTopTemp(T=284.15)
    "top temperature of the ground at the surface"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    groundUndisturbedSurrounding(T=285.15)
    "Fixed temperature which is uneffected from the pipe itself"
    annotation (Placement(transformation(extent={{-60,-26},{-40,-6}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundBottomTemp(T=
       286.15)
    annotation (Placement(transformation(extent={{-62,-78},{-42,-58}})));

  Ground.RadialGround                                 radialGround(
    lambda=6,
    rho=2000,
    n=4,
    d_out=100,
    c=900,
    nRad=5,
    T0=285.4,
    length=uPipe.boreholeDepth,
    d_in=uPipe.boreholeDiameter)
    annotation (Placement(transformation(extent={{-24,-50},{38,14}})));
protected
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{-24,20},{-14,30}})));
public
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    m_flow=0.7,
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    T=279.15,
    nPorts=1) annotation (Placement(transformation(extent={{-2,22},{18,42}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort ReturnTemperature(redeclare package
      Medium=Medium)
    annotation(Placement(transformation(extent={{82,70},{62,90}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = Medium,
    T=281.15) annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Interfaces.RealOutput
  temperatureArrayGround[radialGround.n, radialGround.nRad](unit="K", displayUnit="degC")
  "array with the ground temperatures, [length, width]- of the ground volume"
    annotation (Placement(transformation(extent={{24,-90},{44,-70}})));
public
Modelica.Blocks.Sources.Constant Massflow_2Pipes(k=1.0)
  annotation (Placement(transformation(extent={{-66,42},{-58,50}})));
Modelica.Blocks.Sources.Constant FlowTemperature(k=8.0)
  annotation (Placement(transformation(extent={{-66,22},{-58,30}})));
  BoreHoleHeatExchanger.UPipe                                 uPipe(
    redeclare package Medium = Medium,
    T_start=radialGround.T0,
    n=radialGround.n,
    boreholeDepth=108.45,
    boreholeDiameter=0.2,
    boreholeFilling=AixLib.DataBase.Materials.FillingMaterials.Bentonite(),
    pipeType=AixLib.DataBase.Pipes.PE_X.DIN_16893_SDR11_d40(),
    nParallel=2,
    pipeCentreReferenceCircle=sqrt(0.07*0.07 + 0.07*0.07))
    annotation (Placement(transformation(extent={{38,-56},{100,6}})));
equation

    for i in 1:radialGround.nRad loop
    for j in 1:radialGround.n loop
      temperatureArrayGround[j, i] = radialGround.cylindricAxialHeatTransfer[j,
        i].innerTherm.T;
    end for;
  end for;

  for x in 1:radialGround.n loop
    connect(uPipe.thermalConnectors2Ground[x], radialGround.innerConnectors[
      x]);
  end for;

  connect(groundUndisturbedSurrounding.port, radialGround.outerThermalBoundary)
    annotation (Line(
      points={{-40,-16},{-40,-16},{-40,-18},{-20.9,-18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(ReturnTemperature.port_b, boundary1.ports[1])
                                                  annotation (Line(
      points={{62,80},{50,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(groundBottomTemp.port, radialGround.bottomBoundary) annotation (
      Line(
      points={{-42,-68},{8,-68},{8,-46.8},{7.62,-46.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(groundTopTemp.port, radialGround.topBoundary) annotation (Line(
      points={{-40,70},{28,70},{28,20},{21.88,20},{21.88,6.96}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(FlowTemperature.y, toKelvin.Celsius) annotation (Line(
      points={{-57.6,26},{-52,26},{-52,25},{-25,25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Massflow_2Pipes.y, boundary.m_flow_in) annotation (Line(
      points={{-57.6,46},{-2,46},{-2,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(toKelvin.Kelvin, boundary.T_in) annotation (Line(
      points={{-13.5,25},{-4,25},{-4,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary.ports[1], uPipe.fluidPortIn) annotation (Line(
      points={{18,32},{62,32},{62,6},{61.25,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(uPipe.fluidPortOut, ReturnTemperature.port_a) annotation (Line(
      points={{76.75,6},{76,6},{76,32},{84,32},{84,80},{82,80}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Lsodar"),
    experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simulation model showing an exemplary set up for a <a href=\"HVAC.Components.GeothermalField.Ground.RadialGround\">radial ground</a> model and a u-pipe.</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>The massflow and the flow temperature for the medium can be set for the source and the return temperature from the field can be read over the temperature sensor ReturnTemperature.</p>
<p>Only a single pipe can be connected with a radial ground model. However the model can be under certain assumpitons (to be made by the user) parametrized as such, that the u-pipe is a stand in for a whole geothermal field.</p>
<p>The medium is set on the level of the simulation model.</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>"));
end RadialGround_1Pipe;
