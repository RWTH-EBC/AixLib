within AixLib.Fluid.HeatExchangers.Geothermal.Ground;
model RadialGround
  "Radial Ground model which can be discretized in radial and axial direction"
  ////////////////////////
  ///// CLASS IMPORT /////
  ////////////////////////
  import SI = Modelica.SIunits;
  import Modelica.Constants;

  ////////////////////////////////////
  ///// GENERAL MODEL PARAMETERS /////
  ////////////////////////////////////
  parameter Integer n = 4 "Number of axial discretizations, 
    n = 1 is the top one" annotation(Dialog(group="General"));
  parameter Integer nRad = 8 "Number of radial discretizations, 
    nRad=1 is the most inner one" annotation(Dialog(group="General"));
  parameter SI.Temperature T0 = 283.15 "Initial temperature of ground";

  ////////////////////
  ///// GEOMETRY /////
  ////////////////////
  parameter SI.Length length = 100 "'Length' or depth of radial volume" annotation(Dialog(group="Geometry"));
  parameter SI.Length d_out = 50 "Outer diameter of volume" annotation(Dialog(group="Geometry"));
  parameter SI.Length d_in = 0.15 "Inner diameter of volume" annotation(Dialog(group="Geometry"));

  ///////////////////////////////
  ///// MATERIAL PARAMETERS /////
  ///////////////////////////////
  parameter SI.ThermalConductivity lambda=2.4 "Thermal Conductivity" annotation(Dialog(group="Thermal Properties"));
  parameter SI.Density rho=1600 "Density"  annotation(Dialog(group="Thermal Properties"));
  parameter SI.SpecificHeatCapacity c=1000 "Specific Heat Capacity" annotation(Dialog(group="Thermal Properties"));

  //////////////////////////////
  ///// IMPLICIT VARIABLES /////
  //////////////////////////////
  final parameter Real[nRad] outerDiameters = AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getOuterDiameters(
                                                                d_out, d_in, nRad);
  final parameter Real[nRad] innerDiameters = AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions.getInnerDiameters(
                                                                d_out, d_in, nRad);

  /////////////////////////////
  ///// Object generation /////
  /////////////////////////////

  Utilities.HeatTransfer.CylindricAxialHeatTransfer                      cylindricAxialHeatTransfer[n,nRad](
    each rho=rho,
    each c=c,
    each length=length/n,
    each lambda=lambda,
    d_out=fill(outerDiameters, n),
    d_in=fill(innerDiameters, n),
    each T0=T0) annotation (Placement(transformation(extent={{2,-20},{60,38}})));

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a outerThermalBoundary
    "Non discretized outer boundary for all depth layers"                                                                        annotation (Placement(transformation(extent={{-100,
            -10},{-80,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a innerConnectors[n] annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a topBoundary
    "Thermal boundary at the top, non-discretized"                                                               annotation (Placement(transformation(extent={{38,68},
            {58,88}}), iconTransformation(extent={{38,68},{58,88}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a bottomBoundary
    "Thermal boundary at the bottom, non-discretized"                                                                  annotation (Placement(transformation(extent={{-8,-100},
            {12,-80}}), iconTransformation(extent={{-8,-100},{12,-80}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermCollectorToOuter(m=n) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-56,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermCollectorToBottom(m=nRad) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,-60})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermCollectorToTop(
      m=nRad) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={48,58})));
equation

  /////////////////////////////////////
  ///// CREATE RADIAL CONNECTIONS /////
  /////////////////////////////////////
  for i in 1:nRad-1 loop
    for j in 1:n loop
      //i=1 is the inner-most element
      connect(cylindricAxialHeatTransfer[j,i].outerTherm, cylindricAxialHeatTransfer[j,i+1].innerTherm);
    end for;
  end for;

  ////////////////////////////////////
  ///// CREATE AXIAL CONNECTIONS /////
  ////////////////////////////////////
  for i in 1:(n-1) loop
    for j in 1:nRad loop
      //i=1 is the top-most element
      connect(cylindricAxialHeatTransfer[i,j].backTherm, cylindricAxialHeatTransfer[i+1,j].frontTherm);
    end for;
  end for;

  /////////////////////////////////
  ///// CONNECT TO BOUNDARIES /////
  /////////////////////////////////
  for i in 1:n loop
      // Connection to outer thermal collector
      connect(cylindricAxialHeatTransfer[i,nRad].outerTherm, thermCollectorToOuter.port_a[i]);

      // Connection to multidimensional inner port
      connect(cylindricAxialHeatTransfer[i,1].innerTherm, innerConnectors[i]);
  end for;

  for j in 1:nRad loop
    // Connection to thermal collector at top
    connect(cylindricAxialHeatTransfer[1,j].frontTherm, thermCollectorToTop.port_a[j]);

    // Connection to thermal collector at bottom
    connect(cylindricAxialHeatTransfer[n,j].backTherm, thermCollectorToBottom.port_a[j]);
  end for;

  connect(thermCollectorToOuter.port_b, outerThermalBoundary) annotation (Line(
      points={{-66,1.83697e-015},{-78,1.83697e-015},{-78,0},{-90,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(bottomBoundary, thermCollectorToBottom.port_b) annotation (Line(
      points={{2,-90},{2,-70}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(topBoundary, thermCollectorToTop.port_b) annotation (Line(
      points={{48,78},{48,68}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (                   Icon(graphics={
        Ellipse(
          extent={{-100,-54},{100,-98}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-100,-76},{100,58}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,58},{-100,-76}},
          color={0,0,255},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{100,58},{100,-76}},
          color={0,0,255},
          smooth=Smooth.None,
          thickness=1),
        Ellipse(
          extent={{-100,84},{100,34}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Ellipse(
          extent={{-84,78},{84,42}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Ellipse(
          extent={{-62,70},{62,50}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1)}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>Used with a bore hole heat exchanger model</li>
<li>Radial discretisation possible</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Heat conduction in radial and axial direction.</p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>Recommended to model just one bore hole heat exchanger, as it is difficult to connect such elements correctly with one another.</p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<p>Source:</p>
<ul>
<li>Model developed as part of DA025 &QUOT;Modellierung und Simulation eines LowEx-Geb&auml;udes in der objektorientierten Programmiersprache Modelica&QUOT; by Tim Comanns</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"HVAC.Examples.GeothermalField.Verification.RadialGround_1Pipe\">HVAC.Examples.GeothermalField.Verification.RadialGround_1Pipe</a></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>"));
end RadialGround;
