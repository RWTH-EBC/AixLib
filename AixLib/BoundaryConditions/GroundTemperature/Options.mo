within AixLib.BoundaryConditions.GroundTemperature;
model Options
  "A model that provides different options for ground temperature output"
  import Modelica.Constants.pi;

  parameter AixLib.BoundaryConditions.GroundTemperature.DataSource datSou=AixLib.BoundaryConditions.GroundTemperature.DataSource.Constant
    annotation (Dialog(group="General"));
  parameter Modelica.Units.SI.Temperature TMea "constant or mean ground temperature (for sine) or average air temperature over the year (for Kusuda)"
    annotation (Dialog(group="General", enable=not datSou==AixLib.BoundaryConditions.GroundTemperature.DataSource.File));
  parameter Real offTime=0
    "Offset time from simulation time 0 until minimum ground temperature in s (for sine and Kusuda)"
    annotation (Dialog(group="General", enable=datSou==AixLib.BoundaryConditions.GroundTemperature.DataSource.Kusuda or datSou==AixLib.BoundaryConditions.GroundTemperature.DataSource.Sine));
  parameter Modelica.Units.SI.TemperatureDifference ampTGro=0
    "amplitude of ground temperature (for sine option) or of surface temperature [(maximum air temperature - minimum air temperature)/2] (for Kusuda)"
    annotation (Dialog(group="General", enable=datSou == AixLib.BoundaryConditions.GroundTemperature.DataSource.Kusuda
           or datSou == AixLib.BoundaryConditions.GroundTemperature.DataSource.Sine));
  parameter String filDatSou="NoName"
    "path to a (.mos) file that has the temperature stored in a table called TGround"
    annotation (Dialog(group="General", enable=datSou == AixLib.BoundaryConditions.GroundTemperature.DataSource.File));
  parameter Modelica.Units.SI.ThermalDiffusivity theDifKusPerDay=0.04
    "Thermal diffusivity of the ground for Kusuda. Declare in m2/day!"
    annotation (Dialog(group="Special Kusuda parameters", enable=datSou ==
          AixLib.BoundaryConditions.GroundTemperature.DataSource.Kusuda));
  parameter Modelica.Units.SI.Distance depTGroKus=0
    "Depth of ground temperature for Kusuda"
    annotation (Dialog(group="Special Kusuda parameters", enable=datSou ==
          AixLib.BoundaryConditions.GroundTemperature.DataSource.Kusuda));

  // add conditions
  AixLib.BoundaryConditions.GroundTemperature.GroundTemperatureKusuda kusUnd(
    T_mean=TMea,
    T_amp=ampTGro,
    D=depTGroKus,
    alpha=theDifKusPerDay,
    t_shift=offTime/86400.0)
    if datSou == AixLib.BoundaryConditions.GroundTemperature.DataSource.Kusuda
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TSenKus
    if datSou == AixLib.BoundaryConditions.GroundTemperature.DataSource.Kusuda
    "Sensor to show Kusuda ground temperature"
    annotation (Placement(transformation(extent={{22,50},{42,70}})));
  Modelica.Blocks.Interfaces.RealOutput TGroOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Ground temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Sine sin(
    amplitude=ampTGro,
    f=1.0/31536000.0,
    phase=-offTime/31536000.0*2*pi - pi/2,
    offset=TMea,
    startTime=-31536000.0)
    if datSou == AixLib.BoundaryConditions.GroundTemperature.DataSource.Sine
    "Source for sine function for temperature"
    annotation (Placement(transformation(extent={{-10,-26},{10,-6}})));
  Modelica.Blocks.Sources.Constant TGroConSou(final k=TMea) if datSou == AixLib.BoundaryConditions.GroundTemperature.DataSource.Constant
    "Constant ground temperature"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180)));
  Modelica.Blocks.Sources.CombiTimeTable tabTGro(
    tableOnFile=true,
    tableName="TGround",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=filDatSou)
    if datSou == AixLib.BoundaryConditions.GroundTemperature.DataSource.File
    "Ground temperatures from table"
    annotation (Placement(transformation(extent={{-10,-66},{10,-46}})));

equation
  connect(kusUnd.port, TSenKus.port) annotation (Line(points={{9.4,55},{15.7,55},
          {15.7,60},{22,60}}, color={191,0,0}));
  connect(TSenKus.T, TGroOut) annotation (Line(points={{43,60},{56,60},{56,0},{110,
          0}}, color={0,0,127}));
  connect(TGroConSou.y, TGroOut)
    annotation (Line(points={{11,0},{56,0},{56,0},{110,0}}, color={0,0,127}));
  connect(sin.y, TGroOut) annotation (Line(points={{11,-16},{56,-16},{56,0},{110,
          0}}, color={0,0,127}));
  connect(tabTGro.y[1], TGroOut) annotation (Line(points={{11,-56},{56,-56},{56,
          0},{110,0}}, color={0,0,127}));
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
end Options;
