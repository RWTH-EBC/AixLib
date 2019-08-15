within AixLib.FastHVAC.Components.HeatExchangers.Geothermal.GeothermalField;
model UPipeField
  "Dynamic ground model, different pipe type for the pipes possible"
  import SI = Modelica.SIunits;
  import Modelica.Utilities.Streams;

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Used medium"                                                                    annotation (Dialog(tab="General", group="General"), choicesAllMatching=true);
  parameter Integer n = 4 "Number of discretizations in axial direction" annotation(Dialog(tab="General", group="General"));
  parameter SI.Temperature T0ground = 283.15 "Initial temperature of ground" annotation(Dialog(tab="General", group="General"));
  parameter SI.Temperature T0fluids = 288.15
    "Initial temperature of fluid in pipes"                                          annotation(Dialog(tab="General", group="General"));
  parameter SI.Temperature T0mixing = 288.15
    "Initial temperature in mixing/distribution volume"                                          annotation(Dialog(tab="General", group="General"));

  parameter SI.ThermalConductivity lambda=2.4 annotation(Dialog(group="Thermal Properties", tab="Ground"));
  parameter SI.Density rho=1600 annotation(Dialog(group="Thermal Properties", tab="Ground"));
  parameter SI.SpecificHeatCapacity c=1000 annotation(Dialog(group="Thermal Properties", tab="Ground"));

  parameter SI.Length[:,2] boreholePositions = [0, 0; 5.5, 0; 5.5, 0; 5.5, 5.5]
    "Define number and positions of boreholes/pipes"                                                             annotation(Dialog(tab="Borehole"));

  parameter SI.Length boreholeDepth =  100 "Total depth of the borehole" annotation(Dialog(tab="Borehole"));
  parameter SI.Diameter boreholeDiameter = 0.3 "Total diameter of the borehole" annotation(Dialog(tab="Borehole"));
  parameter SI.Diameter pipeCentreReferenceCircle = boreholeDiameter/2
    "Diameter of the reference circle on which the centres of all the pipes are arranged"               annotation(Dialog(tab="Borehole"));
  parameter AixLib.DataBase.Materials.FillingMaterials.FillingMaterialBaseRecord boreholeFilling=
      AixLib.DataBase.Materials.FillingMaterials.basicFilling()
    "Filling of the borehole"
    annotation (Dialog(tab="Borehole"), choicesAllMatching=true);


  parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeType[:] =  fill(AixLib.DataBase.Pipes.Copper.Copper_40x1(), 4)
    "Type of pipe"                                                                                                     annotation (Dialog(tab="Pipes"), choicesAllMatching=true);

  parameter SI.Length gridBorderWidth = 10
    "Width of grid to surround the minimal outline derived from the pipe positions"                     annotation(Dialog(tab="Grid"));
  parameter SI.Length pipeCellSize = 1
    "Edge length of grid cells in which a BHX-Pipe is positioned"                               annotation(Dialog(tab="Grid"));

  parameter Real borderDistribution[:] = {1}
    "How to distribute the total gridBorderWidth among numerous elements"                                          annotation(Dialog(tab="Grid"));

  Integer count = 1;

  final parameter Integer noOfPipes = size(boreholePositions, 1)
    "Determines itself by the number of positions given"                                                              annotation(Dialog(connectorSizing=true));

  final parameter Integer boreholeGridPositions[:,2] = AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getGridBoreholePositions(
                                                                                boreholePositions, gridBorderWidth, borderDistribution, pipeCellSize) annotation(Dialog(connectorSizing=true));

  final parameter Integer xSteps = AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getGridSizeMatrixSteps(
                                                          boreholePositions, gridBorderWidth, borderDistribution, pipeCellSize, 1) annotation(Dialog(connectorSizing=true));
  final parameter Integer ySteps = AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getGridSizeMatrixSteps(
                                                          boreholePositions, gridBorderWidth, borderDistribution, pipeCellSize, 2) annotation(Dialog(connectorSizing=true));

  final parameter Real xGridMatrix[xSteps, ySteps, n] = AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getGridSizeMatrix(
                                                                  boreholePositions, gridBorderWidth, borderDistribution, pipeCellSize, n, 1);

  final parameter Real yGridMatrix[xSteps, ySteps, n] = AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getGridSizeMatrix(
                                                                boreholePositions, gridBorderWidth, borderDistribution, pipeCellSize, n, 2);

public
  Interfaces.EnthalpyPort_a enthalpyPort_a1
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b1
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
protected
  Valves.Splitter SplitterInput(n=noOfPipes) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-60,74})));

  Valves.Manifold ManifoldOutput annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={52,72})));

protected
  Utilities.HeatTransfer.Cell3D
                              cell[xSteps,ySteps,n](
    x=AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getGridSizeMatrix(
            boreholePositions,
            gridBorderWidth,
            borderDistribution,
            pipeCellSize,
            n,
            1),
    y=AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getGridSizeMatrix(
            boreholePositions,
            gridBorderWidth,
            borderDistribution,
            pipeCellSize,
            n,
            2),
    each z=boreholeDepth/n,
    each lambda=lambda,
    each rho=rho,
    each c=c,
    each T0=T0ground)
    annotation (Placement(transformation(extent={{-12,14},{8,34}})));

protected
  BoreHoleHeatExchanger.UPipe uPipe[noOfPipes](
    each T_start=T0fluids,
    each n=n,
    each boreholeDepth=boreholeDepth,
    each boreholeDiameter=boreholeDiameter,
    pipeType=pipeType,
    each boreholeFilling=AixLib.DataBase.Materials.FillingMaterials.Bentonite())
    annotation (Placement(transformation(extent={{12,-26},{90,52}})));

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groundTemperature
    "Ideally set to yearly average temperature"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    fixedBoundaryTemperature
    "Undisturbed ground temperature at the border of the simulation area"
    annotation (Placement(transformation(extent={{-90,26},{-70,46}}),
        iconTransformation(extent={{-90,26},{-70,46}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a geothermalGradient
    "Constant geothermal heat flux from earth center into bottom of simulation area"
    annotation (Placement(transformation(extent={{-10,-64},{12,-44}}),
        iconTransformation(extent={{-10,-10},{12,10}})));
protected
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalFromBelow(                                                        m=
        xSteps*ySteps)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalFromTop(m=
        xSteps*ySteps)
    annotation (Placement(transformation(extent={{-10,90},{10,70}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalFromSides(                                                        m=4)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-64,36})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalFromLeft(m=
        ySteps*n)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-40,58})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalFromRight(                                                        m=
        ySteps*n)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-40,38})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalFromFront(                                                        m=
        xSteps*n)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-40,20})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalFromBack(m=
        xSteps*n)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-40,2})));
equation

  // Connect ground-elements to each other
  for i in 1:(xSteps-1) loop
    for j in 1:(ySteps-1) loop
      for k in 1:n loop
        connect(cell[i,j,k].ThermRight, cell[i+1,j,k].ThermLeft);
        connect(cell[i,j,k].ThermBack, cell[i,j+1,k].ThermFront);
        if k<n then
          connect(cell[i,j,k].ThermBottom, cell[i,j,k+1].ThermTop);
        end if;
      end for;
    end for;
  end for;

  for i in 1:noOfPipes loop
    // Connect pipes to input and output mixing volumes
    connect(uPipe[i].enthalpyPort_a1, SplitterInput.enthalpyPort_b[i]);
    connect(uPipe[i].enthalpyPort_b1, ManifoldOutput.enthalpyPort_a[i]);
    for j in 1:n loop
      // Connect pipes to ground
      connect(cell[boreholeGridPositions[i,1], boreholeGridPositions[i,2], j].Load1.port, uPipe[i].thermalConnectors2Ground[j]);
      //Modelica.Utilities.Streams.print("connect(cell[" + String(boreholeGridPositions[i,1]) + ", " + String(boreholeGridPositions[i,2]) + ", " + String(j) + "].Load.port, uPipe[" + String(i) + "].thermalConnectors2Ground[" + String(j) + "]");
    end for;
  end for;

  // Connect Ground to surrounding connectors
  for i in 1:xSteps loop
    for j in 1:ySteps loop
      // Connect bottom
      connect(cell[i,j,1].ThermTop, thermalFromTop.port_a[i+(j-1)*xSteps]);

      // Connect top
      connect(cell[i,j,n].ThermBottom, thermalFromBelow.port_a[i+(j-1)*xSteps]);
    end for;
    end for;

  // Connect left and right side of ground
  for j in 1:ySteps loop
    for k in 1:n loop
      // Left side
      connect(cell[1,j,k].ThermLeft, thermalFromLeft.port_a[j+(k-1)*ySteps]);
      // Right side
      connect(cell[xSteps,j,k].ThermRight, thermalFromRight.port_a[j+(k-1)*ySteps]);
    end for;
  end for;

  // Connect front and back side of ground
  for i in 1:xSteps loop
    for k in 1:n loop
      // Front side
      connect(cell[i,1,k].ThermFront, thermalFromFront.port_a[i+(k-1)*xSteps]);
      // Back side
      connect(cell[i,ySteps,k].ThermBack, thermalFromBack.port_a[i+(k-1)*xSteps]);
    end for;
  end for
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-80,-60},
            {80,100}}),
                      graphics), Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-80,-60},{80,100}}), graphics={Rectangle(
          extent={{-80,100},{80,0}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={44,62,4},
          fillPattern=FillPattern.Solid), Text(
          extent={{-78,78},{76,64}},
          fillColor={44,62,4},
          fillPattern=FillPattern.Solid,
          lineColor={255,255,255},
          textString="uPipeField (varPipeType)")}));

  connect(thermalFromBelow.port_b, geothermalGradient) annotation (Line(
      points={{0,-40},{0,-54},{1,-54}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(groundTemperature, thermalFromTop.port_b) annotation (Line(
      points={{0,100},{0,90}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedBoundaryTemperature, thermalFromSides.port_b) annotation (Line(
      points={{-80,36},{-70,36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalFromSides.port_a[1], thermalFromLeft.port_b) annotation (Line(
      points={{-57.55,36},{-52,36},{-52,58},{-46,58}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalFromRight.port_b, thermalFromSides.port_a[2]) annotation (Line(
      points={{-46,38},{-52,38},{-52,36},{-57.85,36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalFromFront.port_b, thermalFromSides.port_a[3]) annotation (Line(
      points={{-46,20},{-52,20},{-52,36},{-58.15,36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalFromBack.port_b, thermalFromSides.port_a[4]) annotation (Line(
      points={{-46,2},{-52,2},{-52,36},{-58.45,36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(enthalpyPort_a1, SplitterInput.enthalpyPort_a)
    annotation (Line(points={{-40,100},{-40,84},{-60,84}}, color={176,0,0}));
  connect(ManifoldOutput.enthalpyPort_b, enthalpyPort_b1) annotation (Line(
        points={{52,82},{46,82},{46,100},{40,100}}, color={176,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-80,-60},
            {80,100}})),                    Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-80,-60},{80,100}})),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview </span></h4>
<p>This model is used to simulate a freely configurable field of U-Pipe borehole heat exchangers </p>
<p>This model is primarily based und multiple objects of the <b>UPipe</b> class, multiple objects of the <b>Cell3D</b> class out of the BaseLib Library to represent the ground surrounding the boreholes and some basic thermal and hydraulic components out of the Modelica Library </p>
<p>The model is used in a test case environment or in combination with further building technology models to represent a heat source or heat sink system </p>
<h4><span style=\"color: #008000\">Assumptions </span></h4>
<p>This model assumes the ground surrounding the boreholes as a homogeneous volume with constant thermal properties such as heat capacity, density and thermal conductivity. Furthermore the number and size of the vertical discretizations of UPipe and the surrounding ground have to be the same. </p>
<h4><span style=\"color: #008000\">Known Limitations </span></h4>
<p>The large number of objects resulting from the multiple instances of the UPipe-model result in a considerably long time used for translation and compiling of the model. Even before Dymola prints out &ldquo;Translating&rdquo; or &ldquo;Compiling&rdquo; there might be a period of 10-20 minutes during which Dymola looks as if it had crashed. </p>
<p>Therefore the capability of this model to be directly combined with an extensive building model is limited. In cases of complex U-Pipe-fields with numerous boreholes this model should be used to create a detailed simulation from which a simplified model should be configured. </p>
<h4><span style=\"color: #008000\">Concept </span></h4>
<p>A set of parameters describes all used materials, fluids and the geometry of the borehole heat exchanger. The call of the function <i>getGridSizeMatrix</i> returns the specified horizontal grid for the ground cells. Each borehole heat exchanger is represented by a single object of the UPipe class that is thermally connected to the surrounding ground layers. </p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>Model developed as part of DA025 &quot;Modellierung und Simulation eines LowEx-Geb&auml;udes in der objektorientierten Programmiersprache Modelica&quot; by Tim Comanns</li>
</ul>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p><a href=\"AixLib.FastHVAC.Examples.HeatExchangers.RectangularGround_2Pipes\">AixLib.FastHVAC.Examples.HeatExchangers.RectangularGround_2Pipes</a></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>"));
end UPipeField;
