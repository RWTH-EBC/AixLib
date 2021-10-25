within AixLib.Utilities.Sources;
model NcDataReader
  "File reader for external data"
  import nc = NcDataReader2.Functions;
  parameter String fileName
    "File where external data is stored"
    annotation (Dialog(loadSelector(filter="netCDF files (*.nc)",
    caption="Open file")));
  parameter Boolean use_varName=false "Get variables from fileName"
    annotation (
    HideResult=True,
    Evaluate=true,
    choices(checkBox=true));
  parameter Boolean use_attNameReal=false "Get real attributes from fileName"
    annotation (
    HideResult=True,
    Evaluate=true,
    choices(checkBox=true));
  parameter Boolean use_attNameInt=false "Get integer attributes from fileName"
    annotation (
    HideResult=True,
    Evaluate=true,
    choices(checkBox=true));
  parameter String varName[:]={""} "Array name in .nc file"
    annotation (Dialog(enable=use_varName));
  parameter String attNameReal[:]={""}
    "Name of attribute of type real in .nc file"
    annotation (Dialog(enable=use_attNameReal));
  parameter String attNameInt[:]={""}
    "Name of attribute of type integer in .nc file"
    annotation (Dialog(enable=use_attNameInt));
  parameter Modelica.SIunits.Time offset=0
    "Time period prior current simulation time";
  Modelica.Blocks.Interfaces.RealOutput y[size(varName, 1)] if
       use_varName
    "Output Vector with all variables"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput yAttReal[size(attNameReal, 1)] if
       use_attNameReal
    "Output Vector with all attributes of type double" annotation (Placement(
        transformation(extent={{100,64},{120,84}}), iconTransformation(extent={{
            100,64},{120,84}})));
  Modelica.Blocks.Interfaces.IntegerOutput yAttInt[size(attNameInt, 1)] if
       use_attNameInt
    "Output Vector with all attributes of type integer" annotation (Placement(
        transformation(extent={{100,-74},{120,-54}}), iconTransformation(extent=
           {{100,-74},{120,-54}})));
protected
  Modelica.Blocks.Interfaces.RealOutput y_internal[size(varName, 1)]
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput yAttReal_internal[size(attNameReal, 1)]
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.IntegerOutput yAttInt_internal[size(attNameInt, 1)]
    "Needed to connect to conditional connector";
equation
  connect(y, y_internal);
  connect(yAttReal, yAttReal_internal);
  connect(yAttInt, yAttInt_internal);

  if use_varName then
    for i in 1:size(varName, 1) loop
      y_internal[i] = nc.ncEasyGet1D(
        fileName,
        varName[i],
        time - offset);
    end for;
  else
    for i in 1:size(varName, 1) loop
      y_internal[i] = 0;
    end for;
  end if;

  if use_attNameReal then
    for i in 1:size(attNameReal, 1) loop
      yAttReal_internal[i] = nc.ncEasyGetAttributeDouble(
        fileName,
        "",
        attNameReal[i]);
    end for;
  else
    for i in 1:size(attNameReal, 1) loop
      yAttReal_internal[i] = 0;
    end for;
  end if;

  if use_attNameInt then
    for i in 1:size(attNameInt, 1) loop
      yAttInt_internal[i] = nc.ncEasyGetAttributeLong(
        fileName,
        "",
        attNameInt[i]);
    end for;
  else
    for i in 1:size(attNameInt, 1) loop
      yAttInt_internal[i] = 0;
    end for;
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}},
          radius=25),
        Text(
          extent={{-88,28},{88,-82}},
          lineColor={0,0,0},
          fillColor={248,248,248},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-38,48},{38,-8}},
          lineColor={0,0,0},
          fillColor={248,248,248},
          fillPattern=FillPattern.Solid,
          textString="
*.nc
"),     Text(
          extent={{-44,86},{44,26}},
          lineColor={0,0,0},
          fillColor={248,248,248},
          fillPattern=FillPattern.Solid,
          textString="file reader")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    preferredView="info",
    Documentation(revisions="<html><ul>
  <li>
    <i>November 12, 2018 by Philipp Mehrfeld:</i><br/>
    Enhance documentation for script to add binary paths to environment
    varialbe. Important for DDE simulations <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/658\">#658</a>.
  </li>
  <li>
    <i>Feburary 6, 2017 by Philipp Mehrfeld:</i><br/>
    Revised documentation.
  </li>
  <li>
    <i>December 14, 2016 by Fabian Wuellhorst:</i><br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  The model <b>NcDataReader</b> reads data from netCDF files (based on
  HDF) to Modelica. You can read attributes of type integer or
  double/float/Real as well as one dimensional vectors. Therefore, the
  NcDataReader represents an alternative for the <a href=
  \"Modelica.Blocks.Sources.CombiTimeTable\">CombiTimeTable</a>.
</p>
<p>
  You have to select the <span style=\"font-family: Courier New;\">*.nc
  file</span> your data is stored in and define the variable's names
  (<span style=\"font-family: Courier New;\">varName</span>). With the
  checkboxes, you can select what type of data/attributes should be
  read in by the model and define afterwards the names of the
  variables/attributes.
</p>
<p>
  <b><span style=
  \"font-size: 12pt; color: #bf2427;\">IMPORTANT:</span></b> This model
  needs the external library <a href=
  \"https://github.com/modelica-3rdparty/netCDF-DataReader\">NcDataReader2</a>.
  Clone or download the repository and load the Modelica library
  package (<span style=
  \"font-family: Courier New;\">netCDF-DataReader/NcDataReader2/package.mo</span>).
  Alternatively, if dymosim crashes or simulation does not work, please
  test the <a href=\"https://github.com/RWTH-EBC/netCDF-DataReader\">EBC
  fork</a> of the repository, which uses different binaries.
</p>
<p>
  <b><span style=\"font-size: 14pt;\">DDE:</span></b> DDE needs to find
  external binaries explicitly. This means either binaries from
  <span style=
  \"font-family: Courier New;\">modelica://NcDataReader2/Resources/Library</span>
  have to be copied into the current working directy, or the path has
  to be added to a certain environment variable of operating system. In
  the <a href=\"AixLib.Utilities.Examples.NcDataReader\">example of
  NcDataReader</a> scripts are added that can also be found in
  <span style=
  \"font-family: Courier New;\">modelica://AixLib\\Resources\\Scripts\\Dymola\\Utilities\\Examples</span>.
</p>
<p>
  <b><span style=\"color: #008000;\">Further external
  information</span></b>
</p>
<p>
  For further information please consider <a href=
  \"https://github.com/tbeu/netCDF-DataReader\">netCDF-DataReader GitHub
  repository</a>.
</p>
<p>
  Have a look directly at the <a href=
  \"https://github.com/tbeu/netCDF-DataReader/blob/master/NcDataReader2/Resources/doc/ncDataReader2_Manual.pdf\">
  documentation</a> on how to create netCDF-files (<span style=
  \"font-family: Courier New;\">*.nc files</span>) and the different
  interpolation and extrapolation types.
</p>
<p>
  More information can be found <a href=
  \"https://www.j-raedler.de/projects/ncdatareader2/\">here</a>.
</p>
<p>
  <b><span style=\"color: #008000;\">Outlook</span></b>
</p>
<p>
  If the function NcEasyGetScattered2D works in the future, an
  implementation to this model should follow. It would substitute
  <a href=\"Modelica.Blocks.Tables.CombiTable2D\">CombiTable2D</a>.
  Please have a look at the documentation on how to create netCDF-files
  and the different interpolation types. More information on that you
  find here.
</p>
<h4>
  <span style=\"color: #008000\">Example Function</span>
</h4>
<p>
  <a href=
  \"AixLib.Utilities.Examples.NcDataReader\">AixLib.Utilities.Examples.NcDataReader</a>
</p>
</html>"));
end NcDataReader;
