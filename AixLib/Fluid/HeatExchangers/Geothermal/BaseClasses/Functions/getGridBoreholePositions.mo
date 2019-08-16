within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions;
function getGridBoreholePositions
  "Function returning a Matrix containing the grid positions for the BHX inside the dynamic grid"
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

  output Integer boreholeGridPositions[size(boreholeCoordinates,1),2];

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

  // Rand hinzufügen & Output generieren
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
  xWidth :=cat(1, borderForward, xWidth, borderBackward);
  yWidth :=cat(1, borderForward, yWidth, borderBackward);

  ///////// Bohrlochposition bestimmen
  // kumulierten Breitenvektor erzeugen
  for i in 1:size(xWidth,1) loop
    if i==1 then
      previousElement :=0;
    else
      previousElement :=xWidthCumulated[i - 1];
    end if;
    xWidthCumulated :=cat(
          1,
          xWidthCumulated,
          {previousElement + xWidth[i]});
  end for;

  for j in 1:size(yWidth,1) loop
    if j==1 then
      previousElement :=0;
    else
      previousElement :=yWidthCumulated[j - 1];
    end if;
    yWidthCumulated :=cat(
          1,
          yWidthCumulated,
          {previousElement + yWidth[j]});
  end for;
   // DEBUG //
  //Streams.print("xWidthC: " + Vectors.toString(xWidthCumulated));
  //Streams.print("yWidthC: " + Vectors.toString(yWidthCumulated));

  // Find gridCoordinates for each BHX-Pipe
  for i in 1:size(boreholeCoordinates,1) loop
    correctedX :=boreholeCoordinates[i, 1] - minX + borderWidth + pipeCellSize/2
      "Correcting to new origin and adding half a pipeCellSize to fulfill <= and > conditions";
    correctedY :=boreholeCoordinates[i, 2] - minY + borderWidth + pipeCellSize/2
      "Correcting to new origin and adding half a pipeCellSize to fulfill <= and > conditions";

    for x in 2:size(xWidthCumulated,1) loop
      if correctedX <= xWidthCumulated[x] and correctedX > xWidthCumulated[x-1] then
        for y in 2:size(yWidthCumulated,1) loop
          if correctedY <= yWidthCumulated[y] and correctedY > yWidthCumulated[y-1] then
            Streams.print("Borehole " + String(i) + " @ (" + String(x) + "," + String(y) + ")");
            boreholeGridPositions[i,1] :=x;
            boreholeGridPositions[i,2] :=y;
          end if;
        end for;
      end if;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>Function returning a Matrix containing the grid positions for the BHX inside the dynamic grid.</p>
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
end getGridBoreholePositions;
