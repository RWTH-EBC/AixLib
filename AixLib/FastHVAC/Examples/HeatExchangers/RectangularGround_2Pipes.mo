within AixLib.FastHVAC.Examples.HeatExchangers;
model RectangularGround_2Pipes
  "Model with rectangular gorund and two pipes for testing the grid types"
   extends Modelica.Icons.ExamplesPackage;

   replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"                annotation(choicesAllMatching = true);

public
Components.Pumps.FluidSource            source
            annotation (Placement(transformation(extent={{-22,8},{-2,28}})));

inner Modelica.Fluid.System system(T_ambient=281.15) annotation (Placement(transformation(extent={{-80,80},
            {-60,100}})));

public
  Components.HeatExchangers.Geothermal.GeothermalField.UPipeField uPipeField(
    boreholePositions=[1,1; 5.5,1; 11,1],
    pipeCellSize=1,
    c=1000,
    T0mixing(displayUnit="degC") = uPipeField.T0fluids,
    rho=2000,
    lambda=6,
    boreholeDiameter=0.2,
    pipeCentreReferenceCircle=sqrt(0.07*0.07 + 0.07*0.07),
    gridBorderWidth=50,
    borderDistribution={0.8,0.15,0.05},
    n=4,
    boreholeFilling=AixLib.DataBase.Materials.FillingMaterials.Bentonite(),
    redeclare package Medium = Medium,
    boreholeDepth=100,
    T0ground=284.15,
    T0fluids=281.15)
    annotation (Placement(transformation(extent={{32,-50},{90,8}})));

public
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundTopTemp(T=
        285.15)
    annotation (Placement(transformation(extent={{10,38},{30,58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    groundUndisturbedSurrounding(T=285.15)
    annotation (Placement(transformation(extent={{-6,-22},{14,-2}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundBottomTemp(T=
       285.15)
    annotation (Placement(transformation(extent={{-6,-52},{14,-32}})));
protected
Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
  annotation (Placement(transformation(extent={{-50,32},{-40,42}})));
public
Modelica.Blocks.Sources.Constant Massflow_2Pipes(k=1.0)
  annotation (Placement(transformation(extent={{-70,16},{-62,24}})));
Modelica.Blocks.Sources.Constant FlowTemperature(k=8.0)
  annotation (Placement(transformation(extent={{-70,34},{-62,42}})));
  Components.Sensors.TemperatureSensor TReturn
    annotation (Placement(transformation(extent={{84,62},{64,82}})));
  Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{58,62},{38,82}})));
equation
  connect(groundTopTemp.port, uPipeField.groundTemperature) annotation (
      Line(
      points={{30,48},{61,48},{61,8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(groundBottomTemp.port, uPipeField.geothermalGradient) annotation (
     Line(
      points={{14,-42},{61.3625,-42},{61.3625,-28.25}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(uPipeField.fixedBoundaryTemperature, groundUndisturbedSurrounding.port)
    annotation (Line(
      points={{32,-15.2},{32,-12},{14,-12}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(FlowTemperature.y, toKelvin.Celsius) annotation (Line(
      points={{-61.6,38},{-56,38},{-56,37},{-51,37}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Massflow_2Pipes.y, source.dotm) annotation (Line(points={{-61.6,20},{
          -40,20},{-40,15.4},{-20,15.4}}, color={0,0,127}));
  connect(toKelvin.Kelvin, source.T_fluid) annotation (Line(points={{-39.5,37},
          {-30.75,37},{-30.75,22.2},{-20,22.2}}, color={0,0,127}));
  connect(source.enthalpyPort_b, uPipeField.enthalpyPort_a1)
    annotation (Line(points={{-2,19},{46.5,19},{46.5,8}}, color={176,0,0}));
  connect(vessel.enthalpyPort_a, TReturn.enthalpyPort_b) annotation (Line(
        points={{55,72},{60,72},{60,71.9},{65,71.9}}, color={176,0,0}));
  connect(TReturn.enthalpyPort_a, uPipeField.enthalpyPort_b1) annotation (Line(
        points={{82.8,71.9},{84,71.9},{84,18},{75.5,18},{75.5,8}}, color={176,0,
          0}));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-80,-60},
            {100,100}})),
  experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Lsodar"),
  experimentSetupOutput,
  Icon(graphics,
       coordinateSystem(preserveAspectRatio=true, extent={{-80,-60},{100,
          100}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>January 29, 2014&#160;</i> by Ana Constantin:<br/>
    Added to HVAC, formated and upgraded to current version of
    Dymola/Modelica
  </li>
  <li>
    <i>March 13, 2012&#160;</i> by Tim Comanns (supervisor: Ana
    Constantin):<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation model showing an exemplary set up for the model <a href=
  \"HVAC.Components.GeothermalField.GeothermalField.UPipeField\">UPipeField</a>
</p>
<p>
  <b><font style=\"color: #008000;\">Concept</font></b>
</p>
<p>
  The massflow and the flow temperature for the medium can be set for
  the source and the return temperature from the field can be read over
  the temperature sensor ReturnTemperature.
</p>
<p>
  The set up is made for two U-pipes, but more pipes can be added.
  Pipes are added by setting up their coordinates in the
  boreholePositions vector.
</p>
<p>
  The border distribution can be parametrize differently to analyse the
  effects of each parameter.
</p>
<p>
  The medium is set on the level of the simulation model.
</p>
</html>"));
end RectangularGround_2Pipes;
