within AixLib.BoundaryConditions.GroundTemperature;
model GroundTemperatureOptions
  "A model that provides different options for ground temperature output"
  import Modelica.Constants.pi;

  parameter GroundTemperatureDataSource dataSource=GroundTemperatureDataSource.Constant
    annotation (Dialog(group="General"));
  parameter Modelica.Units.SI.Temperature TMean "constant or mean ground temperature (for sine) or average air temperature over the year (for Kusuda)"
    annotation (Dialog(group="General", enable=not dataSource==GroundTemperatureDataSource.File));
  parameter Real offsetTime=0
    "time from simulation time 0 until minimum ground temperature in s (for sine and Kusuda)"
    annotation (Dialog(group="General", enable=dataSource==GroundTemperatureDataSource.Kusuda or dataSource==GroundTemperatureDataSource.Sine));
  parameter Modelica.Units.SI.TemperatureDifference amplitudeTGround=0
    "amplitude of ground temperature (for sine option) or of surface temperature [(maximum air temperature - minimum air temperature)/2] (for Kusuda)"
    annotation (Dialog(group="General", enable=dataSource==GroundTemperatureDataSource.Kusuda or dataSource==GroundTemperatureDataSource.Sine));
  parameter String fileDataSource="NoName"
    "path to a (.mos) file that has the temperature stored in a table called TGround"
    annotation (Dialog(group="General", enable=dataSource==GroundTemperatureDataSource.File));
  parameter Modelica.Units.SI.ThermalDiffusivity alpha=0.04
    "Thermal diffusivity of the ground for Kusuda. Declare in m2/day!"
    annotation (Dialog(group="Special Kusuda parameters", enable=dataSource==GroundTemperatureDataSource.Kusuda));
  parameter Modelica.Units.SI.Distance depth=0 "Depth of ground temperature"
    annotation (Dialog(group="Special Kusuda parameters", enable=dataSource==GroundTemperatureDataSource.Kusuda));

  // add conditions
  GroundTemperatureKusuda kusudaUndisturbedModel(
    T_mean=TMean,
    T_amp=amplitudeTGround,
    D=depth,
    alpha=alpha,
    t_shift=offsetTime/86400.0) if
       dataSource==GroundTemperatureDataSource.Kusuda
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor if
       dataSource==GroundTemperatureDataSource.Kusuda
    "Sensor to show Kusuda ground temperature"
    annotation (Placement(transformation(extent={{22,50},{42,70}})));
  Modelica.Blocks.Interfaces.RealOutput TGroundOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Ground temperature"
    annotation (Placement(transformation(
          extent={{100,-10},{120,10}}),iconTransformation(extent={{100,50},{120,
            70}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=amplitudeTGround,
    f=1.0/31536000.0,
    phase=-offsetTime/31536000.0*2*pi - pi/2,
    offset=TMean,
    startTime=-31536000.0) if
       dataSource==GroundTemperatureDataSource.Sine
    annotation (Placement(transformation(extent={{-10,-26},{10,-6}})));
  Modelica.Blocks.Sources.Constant TGroundConstantSource(final k=TMean) if
       dataSource==GroundTemperatureDataSource.Constant
    "Constant ground temperature"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
    rotation=180,origin={0,20})));
  Modelica.Blocks.Sources.CombiTimeTable tableTGround(
    tableOnFile=true,
    tableName="TGround",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=fileDataSource) if
       dataSource==GroundTemperatureDataSource.File
    "Ground temperatures from table"
    annotation (Placement(transformation(extent={{-10,-66},{10,-46}})));

equation
  connect(kusudaUndisturbedModel.port, temperatureSensor.port) annotation (Line(
        points={{9.4,55},{15.7,55},{15.7,60},{22,60}}, color={191,0,0}));
  connect(temperatureSensor.T, TGroundOut) annotation (Line(points={{43,60},{56,
          60},{56,0},{110,0}}, color={0,0,127}));
  connect(TGroundConstantSource.y, TGroundOut) annotation (Line(points={{11,20},
          {56,20},{56,0},{110,0}}, color={0,0,127}));
  connect(sine.y, TGroundOut) annotation (Line(points={{11,-16},{56,-16},{56,0},
          {110,0}}, color={0,0,127}));
  connect(tableTGround.y[1], TGroundOut) annotation (Line(points={{11,-56},{56,-56},
          {56,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-100,20},{-46,14},{-10,20},{24,16},{60,18},{78,12},{100,20},{
              100,-100},{-100,-100},{-100,20}},
          lineColor={0,0,0},
          fillColor={127,66,38},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,20},{-100,32},{-42,22},{-4,30},{32,22},{66,24},{82,20},{
              100,28},{100,20},{78,12},{60,18},{24,16},{-10,20},{-46,14},{-100,20}},
          lineColor={0,0,0},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,100},{100,100},{100,28},{82,20},{66,24},{32,22},{-4,30},
              {-42,22},{-100,32},{-100,100}},
          lineColor={0,0,0},
          fillColor={0,157,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,84},{-40,54}},
          lineColor={0,0,0},
          fillColor={255,255,85},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-139,-104},{161,-144}},
          lineColor={0,0,255},
          textString="%name")}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
    <li>April 23, 2023, by Philip Groesdonk:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1080\">issue 1080</a>).
  </li>
</ul>
</html>", info="<html>
This model provides a block to choose from different options to model ground temperature:
<ul>
<li>
a constant value
  </li>
<li>
a sine curve (yearly)
  </li>
  <li>
  a table stored in a file
  </li>
  <li>a simple model (called Kusuda here) that was originally created for use with district heating grids or LTN in order to model
  thermal pipe losses
  </li>
</ul>
<h4>
  Assumption and limitations
</h4>
<p>
The model does not model any influence on the ground temperature. 
The ground temperature is only dependent on the set parameters.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
The model is used as a boundary condition for ROM model floors outside surfaces.
</p>
<p>
<b>Differently then stated in the parameter description below for Kusuda,
  α needs to be declared in m2/day! (The Modelica SI unit diffusivity does not
  support m2/day as a display unit.)</b>
</p>
<p>
  A typical value for α is bewteen 0.03 and 0.05 m2/day.
</p>

</html>
"));
end GroundTemperatureOptions;
