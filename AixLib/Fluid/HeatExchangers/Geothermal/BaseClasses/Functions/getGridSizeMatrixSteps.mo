within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions;
function getGridSizeMatrixSteps
  extends Modelica.Icons.Function;

  import Modelica.Math.Vectors;
  import Modelica.Utilities.Streams;

  input Modelica.SIunits.Length boreholeCoordinates[:,2]
    "Array of 2D (x,y) borehole coordinates";
  input Modelica.SIunits.Length borderWidth
    "Width of Border around the minimal footprint of the borehole array";
  input Real borderDistribution[:]
    "Distribute borderWidth over numerous partial steps";
  input Modelica.SIunits.Length pipeCellSize
    "Edge size of cells that contain a BHX-pipe";
  input Integer selectOutput "1 for x-Direction, 2 for y-Direction";

  output Integer stepsInDirection;

protected
  Modelica.SIunits.Length xWidth[:];
  Modelica.SIunits.Length yWidth[:];

  Modelica.SIunits.Length borderForward[:];
  Modelica.SIunits.Length borderBackward[:];

  Modelica.SIunits.Length xCoordinates[size(boreholeCoordinates,1)]
    "Accumulation of borehole x-Coordinates";
  Modelica.SIunits.Length yCoordinates[size(boreholeCoordinates,1)]
    "Accumulation of borehole y-Coordinates";

  Modelica.SIunits.Length minX "Minimum of all x-Coordinates";
  Modelica.SIunits.Length minY "Minimum of all y-Coordinates";

  Modelica.SIunits.Length cleanXCoordinates[:] "temporary vector for sorting";
  Modelica.SIunits.Length cleanYCoordinates[:] "temporary vector for sorting";

  Modelica.SIunits.Length xWidthCumulated[:] "Cumulated widths in x-direction";
  Modelica.SIunits.Length yWidthCumulated[:] "Cumulated widths in y-direction";

  Modelica.SIunits.Length correctedX
    "Corrected x-Coordinate of borehole for gridPosition search";
  Modelica.SIunits.Length correctedY
    "Corrected y-Coordinate of borehole for gridPosition search";

  Integer startIndex "Array index used in algorhythm";
  Integer endIndex "Array index used in algorhythm";

  Real previousElement "Temporaray variable";

algorithm
  // Store x- and y-Coordinates of borehole positions in separate arrays
  for i in 1:size(boreholeCoordinates,1) loop
      xCoordinates[i] :=boreholeCoordinates[i, 1];
      yCoordinates[i] :=boreholeCoordinates[i, 2];
  end for;

  // Sort arrays of x- and y-Coordinates
  xCoordinates :=Vectors.sort(xCoordinates);
  yCoordinates :=Vectors.sort(yCoordinates);

  // Save minimum values of x- and y-coordinates to "push" free
  // coordinates to a new origin
  minX :=min(xCoordinates);
  minY :=min(yCoordinates);

  // Set smallest values of x/y coordinates as new origin
  for i in 1:size(xCoordinates,1) loop
    xCoordinates[i] :=xCoordinates[i] - minX;
  end for;

  for j in 1:size(yCoordinates,1) loop
    yCoordinates[j] :=yCoordinates[j] - minY;
  end for;

  // Delete double-entries out of each Vector, since they don't provide
  // new stepSize information
  for i in 1:size(xCoordinates,1) loop
    if Vectors.find(xCoordinates[i], cleanXCoordinates) == 0 then
      cleanXCoordinates:=cat(1, cleanXCoordinates, {xCoordinates[i]});
    end if;
  end for;

  for j in 1:size(yCoordinates,1) loop
    if Vectors.find(yCoordinates[j], cleanYCoordinates) == 0 then
      cleanYCoordinates:=cat(1, cleanYCoordinates, {yCoordinates[j]});
    end if;
  end for;

  // Create width-Vectors
  // x-Direction
  for i in 1:(size(cleanXCoordinates,1)*2-1) loop
    if mod(i,2)==1 then
      xWidth:=cat(1, xWidth, {pipeCellSize});
    elseif mod(i,2)==0 then
      startIndex :=integer(i/2);
      endIndex :=startIndex + 1;

      xWidth:=cat(1, xWidth, {cleanXCoordinates[endIndex] - cleanXCoordinates[startIndex] - pipeCellSize});
    end if;
  end for;

  // y-Direction
  for j in 1:(size(cleanYCoordinates,1)*2-1) loop
    if mod(j,2)==1 then
      yWidth:=cat(1, yWidth, {pipeCellSize});
    elseif mod(j,2)==0 then
      startIndex :=integer(j/2);
      endIndex :=startIndex + 1;

      yWidth:=cat(1, yWidth, {cleanYCoordinates[endIndex] - cleanYCoordinates[startIndex] - pipeCellSize});
    end if;
  end for;

  // Rand erzeugen
  for i in 1:(size(borderDistribution,1)) loop
    borderForward :=cat(
      1,
      borderForward,
      {borderDistribution[i]*borderWidth});
    borderBackward :=cat(
      1,
      {borderDistribution[i]*borderWidth},
      borderBackward);
  end for;

  // Rand hinzufügen & Output generieren
  xWidth :=cat(1, borderForward, xWidth, borderBackward);
  yWidth :=cat(1, borderForward, yWidth, borderBackward);
  //xWidth :=cat(1, {borderWidth}, xWidth, {borderWidth});
  //yWidth :=cat(1, {borderWidth}, yWidth, {borderWidth});

  if selectOutput == 1 then
    stepsInDirection :=size(xWidth, 1);
  elseif selectOutput == 2 then
    stepsInDirection :=size(yWidth, 1);
  end if;

  annotation (Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>Model developed as part of DA025 &quot;Modellierung und Simulation eines LowEx-Geb&auml;udes in der objektorientierten Programmiersprache Modelica&quot; by Tim Comanns</li>
</ul>
</html>",
    revisions="<html>
<p><ul>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>"));
end getGridSizeMatrixSteps;
