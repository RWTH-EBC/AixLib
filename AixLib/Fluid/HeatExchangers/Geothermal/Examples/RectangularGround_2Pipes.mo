within AixLib.Fluid.HeatExchangers.Geothermal.Examples;
model RectangularGround_2Pipes
  "Model with rectangular gorund and two pipes for testing the grid types"
   extends Modelica.Icons.Example;

   replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"                annotation(choicesAllMatching = true);

public
Modelica.Fluid.Sources.MassFlowSource_T source(
  m_flow=0.3,
  use_m_flow_in=true,
  use_T_in=true,
    redeclare package Medium = Medium,
    T=279.15,
    nPorts=1)
            annotation (Placement(transformation(extent={{-22,8},{-2,28}})));

inner Modelica.Fluid.System system(T_ambient=281.15) annotation (Placement(transformation(extent={{-80,80},
            {-60,100}})));
Modelica.Fluid.Sensors.TemperatureTwoPort ReturnTemperature(redeclare package
      Medium = Medium)
  annotation(Placement(transformation(extent={{84,76},{72,90}})));

Modelica.Fluid.Sources.FixedBoundary sink(
  nPorts=1, redeclare package Medium = Medium)
            annotation (Placement(transformation(extent={{38,72},{58,92}})));

public
  GeothermalField.UPipeField                                 uPipeField(
    pipeCellSize=1,
    c=1000,
    T0mixing(displayUnit="degC") = uPipeField.T0fluids,
    boreholePositions=[1,1; 5.5,1],
    rho=2000,
    lambda=6,
    boreholeDiameter=0.2,
    pipeCentreReferenceCircle=sqrt(0.07*0.07 + 0.07*0.07),
    gridBorderWidth=50,
    borderDistribution={0.8,0.15,0.05},
    n=4,
    nParallel=2,
    boreholeFilling=AixLib.DataBase.Materials.FillingMaterials.Bentonite(),
    redeclare package Medium = Medium,
    boreholeDepth=100,
    pipeType={AixLib.DataBase.Pipes.PE_X.DIN_16893_SDR11_d40(),
        AixLib.DataBase.Pipes.PE_X.DIN_16893_SDR11_d40()},
    T0ground=284.15,
    T0fluids=281.15)
    annotation (Placement(transformation(extent={{32,-50},{90,8}})));

public
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundTopTemp(T=
        285.15)
    annotation (Placement(transformation(extent={{30,38},{10,58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    groundUndisturbedSurrounding(T=285.15)
    annotation (Placement(transformation(extent={{14,-22},{-6,-2}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundBottomTemp(T=
       285.15)
    annotation (Placement(transformation(extent={{14,-48},{-6,-28}})));
protected
Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
  annotation (Placement(transformation(extent={{-56,12},{-46,22}})));
public
Modelica.Blocks.Sources.Constant Massflow_2Pipes(k=1.0)
  annotation (Placement(transformation(extent={{-76,32},{-68,40}})));
Modelica.Blocks.Sources.Constant FlowTemperature(k=8.0)
  annotation (Placement(transformation(extent={{-76,14},{-68,22}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Medium,
    nParallel=1,
    length=5,
    diameter=0.04)
    annotation (Placement(transformation(extent={{12,8},{32,28}})));
equation
  connect(ReturnTemperature.port_b, sink.ports[1])
                                                annotation (Line(
    points={{72,83},{58,83},{58,82}},
    color={0,127,255},
    smooth=Smooth.None));
  connect(groundTopTemp.port, uPipeField.groundTemperature) annotation (
      Line(
      points={{10,48},{61,48},{61,8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(groundBottomTemp.port, uPipeField.geothermalGradient) annotation (
     Line(
      points={{-6,-38},{61.3625,-38},{61.3625,-28.25}},
      color={191,0,0},
      smooth=Smooth.None));
connect(toKelvin.Kelvin, source.T_in) annotation (Line(
    points={{-45.5,17},{-38,17},{-38,22},{-24,22}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(Massflow_2Pipes.y, source.m_flow_in)
                                  annotation (Line(
    points={{-67.6,36},{-38,36},{-38,26},{-22,26}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(uPipeField.fieldFluidOut, ReturnTemperature.port_a)
                                                      annotation (Line(
    points={{75.5,8},{76,8},{76,28},{94,28},{94,83},{84,83}},
    color={0,127,255},
    smooth=Smooth.None));
  connect(uPipeField.fixedBoundaryTemperature, groundUndisturbedSurrounding.port)
    annotation (Line(
      points={{32,-15.2},{32,-12},{-6,-12}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(FlowTemperature.y, toKelvin.Celsius) annotation (Line(
      points={{-67.6,18},{-62,18},{-62,17},{-57,17}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(source.ports[1], pipe.port_a) annotation (Line(
      points={{-2,18},{12,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.port_b, uPipeField.fieldFluidIn) annotation (Line(
      points={{32,18},{46,18},{46,14},{46.5,14},{46.5,8}},
      color={0,127,255},
      smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-80,-60},
            {100,100}}),
                    graphics),
  experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Lsodar"),
  experimentSetupOutput,
  Icon(graphics,
       coordinateSystem(preserveAspectRatio=true, extent={{-80,-60},{100,
          100}})),
    Documentation(revisions="<html>
<p><ul>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simulation model showing an exemplary set up for the model <a href=\"HVAC.Components.GeothermalField.GeothermalField.UPipeField\">UPipeField</a></p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>The massflow and the flow temperature for the medium can be set for the source and the return temperature from the field can be read over the temperature sensor ReturnTemperature.</p>
<p>The set up is made for two U-pipes, but more pipes can be added. Pipes are added by setting up their coordinates in the boreholePositions vector.</p>
<p>The border distribution can be parametrize differently to analyse the effects of each parameter.</p>
<p>The medium is set on the level of the simulation model.</p>
</html>"));
end RectangularGround_2Pipes;
