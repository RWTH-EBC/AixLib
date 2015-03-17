within AixLib.HVAC.Office.Room;


model ExternalCInterfaceModelica_NoChange
  "Reads and writes Data from/to external C routine"
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////
  parameter Real Rate = 20.0 "Sampling rate" annotation(Dialog(descriptionLabel = true, group = "Connection"));
  parameter Integer LENGTH = 1
    "Number of Variables to Send to External C Routine"                            annotation(Dialog(descriptionLabel = true, group = "Connection"));
  parameter String Stringer = "Connected to External C Code!"
    "String to be sent to External C Code"                                                           annotation(Dialog(descriptionLabel = true, group = "Connection"));
  parameter Modelica.SIunits.Time T_C = 0.01 annotation(Dialog(descriptionLabel = true, group = "Relaxation"));
  parameter Real[LENGTH] Initials "Initial values of output";
  Modelica.Blocks.Interfaces.RealInput[LENGTH] u annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{-120, 20}, {-80, -20}})));
  Modelica.Blocks.Interfaces.IntegerOutput Return annotation(Placement(transformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{80, 40}, {120, 80}}, rotation = 0), iconTransformation(extent = {{80, -80}, {120, -40}})));
  Modelica.Blocks.Interfaces.RealOutput[LENGTH] yArray annotation(Placement(transformation(extent = {{80, -80}, {120, -40}}, rotation = 0), iconTransformation(extent = {{80, 40}, {120, 80}})));
protected
  Boolean Trigger "Boolean Trigger acivating external function call";
  Real[LENGTH] PTYArray_raw
    "Real value array received by external function or program";
  Real PTY_raw "Real value received by external function or program";
  //////////////////////////////////////////////////////////
  Modelica.Blocks.Continuous.FirstOrder[LENGTH] PTYArray(each T = T_C, each initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = Initials) annotation(Placement(transformation(extent = {{40, -70}, {60, -50}})));
  Modelica.Blocks.Continuous.FirstOrder PTY(each T = T_C, each initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = Initials[1]) annotation(Placement(transformation(extent = {{40, 50}, {60, 70}})));
initial algorithm
  // initializing the variables of external function or program
  Return := Functions.Starter(0.1, LENGTH, Stringer);
algorithm
  when Trigger then
    Return := Functions.Writer_NoChange(u, LENGTH, Stringer);
    PTYArray_raw := Functions.ReaderArray(u);
    PTY_raw := Functions.Reader(1);
  end when;
  // call of external function, writing the value u
  // call of external function, reading the array PTYArray_raw
  // call of external function, reading the single value of PTY_raw
  //////////////////////////////////////////////////////////
equation
  Trigger = sample(0, Rate);
  // relaxation of output, preventing unnecessary function calls of internal time steps
  for i in 1:LENGTH loop
    PTYArray[i].u = PTYArray_raw[i];
  end for;
  PTY.u = PTY_raw;
  connect(PTYArray.y, yArray) annotation(Line(points = {{61, -60}, {100, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(PTY.y, y) annotation(Line(points = {{61, 60}, {100, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent=  {{-100, 100}, {100, -100}}, lineColor=  {0, 0, 255}, fillColor=  {175, 175, 175}, fillPattern=  FillPattern.Solid), Text(extent=  {{-74, 66}, {70, -74}}, lineColor=  {0, 0, 0}, fillColor=  {175, 175, 175}, fillPattern=  FillPattern.Solid, textString=  "C")}), conversion(noneFromVersion = ""), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Supplies access to external C functions. </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars5.png\" alt=\"stars: 5 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Input: Arbitrary real array.</p>
 <p>Output: Input value with no change according to sampling rate Rate</p>
 <p>The output can be supplied individually (reader) or in a vector (readerArray). </p>
 <p>reader(i) supplies value of array with index i</p>
 <p>readerArray supplies the complete array</p>
 <p>Corresponding code in ./Office/Code</p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <p>Interface requires a relaxation model to control the sampling rate.</p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Office.Examples.ExternalC\">AixLib.HVAC.Office.Examples.ExternalC</a></p>
 </html>", revisions = "<html>
 <ul>
   <li><i>Feb 26, 2014&nbsp;</i> by Bjoern Flieger:<br/>Implemented</li>

 </ul>
 </html>"));
end ExternalCInterfaceModelica_NoChange;
