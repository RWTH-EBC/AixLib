within AixLib.Utilities.Sources;
model NcDataReader
  import nc = NcDataReader2.Functions;
  parameter String fileName=Modelica.Utilities.Files.loadResource("modelica://NcDataReader2/Resources/examples/testfile.nc")
    "File where external data is stored" annotation (Dialog(loadSelector(filter=
           "netCDF files (*.nc)", caption="Open file")));
  parameter Boolean use_varName = false "Get variables from fileName"
       annotation(HideResult=True, Evaluate=true, choices(checkBox=true));
  parameter Boolean use_attNameReal = false "Get real attributes from fileName"
       annotation(HideResult=True, Evaluate=true, choices(checkBox=true));
  parameter Boolean use_attNameInt = false "Get integer attributes from fileName"
       annotation(HideResult=True, Evaluate=true, choices(checkBox=true));
  parameter String varName[:]={"test1D"} "Array name in .nc file" annotation (Dialog(enable = use_varName));
  parameter String attNameReal[:]={"foo"} "Name of attribute of type real in .nc file" annotation (Dialog(enable = use_attNameReal));
  parameter String attNameInt[:]={"bar"} "Name of attribute of type integer in .nc file" annotation (Dialog(enable = use_attNameInt));
  parameter Modelica.SIunits.Time offset = 0 "Time period prior current simulation time";
  Modelica.Blocks.Interfaces.RealOutput y[(size(varName))[1]] if use_varName
     "Output Vector with all variables"  annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput yAttReal[(size(attNameReal))[1]] if use_attNameReal
     "Output Vector with all attributes of type double"        annotation (Placement(
        transformation(extent={{100,64},{120,84}}), iconTransformation(extent={{
            100,64},{120,84}})));
  Modelica.Blocks.Interfaces.IntegerOutput yAttInt[(size(attNameInt))[1]] if use_attNameInt
     "Output Vector with all attributes of type integer"       annotation (Placement(transformation(
          extent={{100,-74},{120,-54}}), iconTransformation(extent={{100,-74},{120,
            -54}})));
protected
  Modelica.Blocks.Interfaces.RealOutput y_internal[(size(varName))[1]]
  "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput yAttReal_internal[(size(attNameReal))[1]]
  "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.IntegerOutput yAttInt_internal[(size(attNameInt))[1]]
  "Needed to connect to conditional connector";
equation
  connect(y,y_internal);
  connect(yAttReal,yAttReal_internal);
  connect(yAttInt,yAttInt_internal);

  if use_varName then
    for i in 1:(size(varName))[1] loop
      y_internal[i] = nc.ncEasyGet1D(
        fileName,
        varName[i],
        time-offset);
    end for;
  else
    for i in 1:(size(varName))[1] loop
      y_internal[i] = 0;
    end for;
  end if;

  if use_attNameReal then
    for i in 1:(size(attNameReal))[1] loop
      yAttReal_internal[i] = nc.ncEasyGetAttributeDouble(
        fileName,
        "",
        attNameReal[i]);
    end for;
  else
    for i in 1:(size(attNameReal))[1] loop
      yAttReal_internal[i] = 0;
    end for;
  end if;

  if use_attNameInt then
    for i in 1:(size(attNameInt))[1] loop
      yAttInt_internal[i] = nc.ncEasyGetAttributeLong(
        fileName,
        "",
        attNameInt[i]);
    end for;
  else
    for i in 1:(size(attNameInt))[1] loop
      yAttInt_internal[i] = 0;
    end for;
  end if;
     annotation (uses(NcDataReader2(version="2.4.0")),Dialog(group="AHU Modes"), choices(checkBox=true),Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          extent={{-68,96},{66,2}},
          lineColor={0,0,0},
          fillColor={248,248,248},
          fillPattern=FillPattern.Solid,
          textString="TABLE:")}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>Feburary 1, 2017</i> by Fabian Wuellhorst:<br>Added documentation</li>
<li><i>December 14, 2016 </i>by Fabian Wuellhorst:<br>Implemented.</li>
</ul>
</html>", info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>The model <b>NcDataReader</b> reads interpolated data from netCDF files and DAP servers to Dymola. You can read attributes of type integer or double as well as one dimensional vectors, just like <a href=\"Modelica.Blocks.Sources.CombiTimeTable\">CombiTimeTable</a> does.</p>
<p>Uses <a href=\"https://github.com/tbeu/netCDF-DataReader\">NcDataReader2</a> from Joerg Readler. If the function NcEasyGetScattered2D works in the future, an implementation to this model should follow. It would substitute <a href=\"Modelica.Blocks.Tables.CombiTable2D\">CombiTable2D</a>. Please have a look at the <a href=\"https://github.com/tbeu/netCDF-DataReader/blob/master/NcDataReader2/Resources/doc/ncDataReader2_Manual.pdf\">documentation</a> on how to create netCDF-files and the different interpolation types. If the simulation of the Example doesn&apos;t work, you may have to get additional files and copy them to your current working directory. More information on that you find <a href=\"https://www.j-raedler.de/projects/ncdatareader2/\">here</a>.</p>
<p><br><b><span style=\"color: #008000;\">Level of Development</span></b> </p>
<p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars: 3 out of 5\"/> </p>
<p><b><span style=\"color: #008000;\">Information</span></b> </p>
<p>First you have to select the *.nc-file your data is stored in.</p>
<p>With the checkboxes, you can select what type of data you want to get. You have to enter the names of the variables/attributes you want to get to the corresponding line.</p>
<h4><span style=\"color: #008000\">Example Function</span></h4>
<p><a href=\"AixLib.Utilities.Examples.NcDataReader_test\">AixLib.Utilities.Examples.NcDataReader_test</a></p>
</html>"));
end NcDataReader;
