within AixLib.Utilities.Examples;
model NcDataReader
  extends Modelica.Icons.Example;
  Sources.NcDataReader NcDataReader_test(
    fileName=Modelica.Utilities.Files.loadResource(
    "modelica://AixLib/Resources/NcDataReader_ExampleData/Temp_Year.nc"),
    use_varName=true,
    use_attNameReal=true,
    use_attNameInt=true,
    varName={"temp_year"},
    attNameReal={"float_ex"},
    attNameInt={"Region","TRY"})
    annotation (Placement(transformation(extent={{-100,-20},{-40,40}})));

  annotation (
    experiment(
      StopTime=3.1536e+007,
      Interval=1800),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Examples/NcDataReader_win32.mos"
      "Add win32 binaries to PATH env variable (important with DDE)",
      file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Examples/NcDataReader_win64.mos"
      "Add win64 binaries to PATH env variable (important with DDE)"),
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  This is an example for the model <a href=
  \"AixLib.Utilities.Sources.NcDataReader\">NcDataReader</a>. It
  simulates the air temperature of TRY 2010 region 12 (see attributes
  of the model <code>attNameInt</code>). The attribute
  <code>float_ex</code> is just a random value to show the use for
  attributes of type Real. It is also recommended to have a look into
  the source <code>*.cdl file</code>
  (modelica://AixLib/Resources/NcDataReader_ExampleData/Temp_Year.cdl).
</p>
<p>
  For further information please consider <a href=
  \"https://github.com/tbeu/netCDF-DataReader\">netCDF-DataReader GitHub
  repository</a>.
</p>
<ul>
  <li>
    <i>Feburary 1, 2017</i> by Fabian Wuellhorst:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end NcDataReader;
