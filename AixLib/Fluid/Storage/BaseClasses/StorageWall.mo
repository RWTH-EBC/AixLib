within AixLib.Fluid.Storage.BaseClasses;
model StorageWall

//////parameters////

  parameter Modelica.SIunits.Length height=0.15 "Hoehe der Schicht"  annotation(Dialog(tab="Geometrical Parameters"));
  parameter Modelica.SIunits.Diameter D1=1 "Innendurchmesser des Tanks" annotation(Dialog(tab="Geometrical Parameters"));
  parameter Modelica.SIunits.Thickness sWall=0.1 "Thickness of wall" annotation(Dialog(tab="Geometrical Parameters"));
  parameter Modelica.SIunits.Thickness sIns=0.1 "Thickness of insulation" annotation(Dialog(tab="Geometrical Parameters"));
  /*parameter SI.Length roughness(min=0) = 2.5e-5 
    "Absolute roughness of storage inside wall (default = smooth steel pipe)" annotation 4;*/
protected
  parameter Modelica.SIunits.Area AHor = (D1/2)^2*Modelica.Constants.pi
    "horizontal area of water in layer";
  parameter Modelica.SIunits.Area AWall= D1*Modelica.Constants.pi * height
    "vertical outlining area of water in layer";
  parameter Modelica.SIunits.Area AIns=(D1+2*sWall)*Modelica.Constants.pi * height;
  parameter Modelica.SIunits.Area AOutside=(D1+2*(sWall+sIns))*Modelica.Constants.pi * height;

public
  parameter Modelica.SIunits.ThermalConductivity lambdaWall=50
    "Thermal Conductivity of wall";
    parameter Modelica.SIunits.ThermalConductivity lambdaIns=0.045
    "Thermal Conductivity of insulation";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaInside=2
    "Coefficient of Heat Transfer water <-> wall";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaOutside=2
    "Coefficient of Heat Transfer insulation <-> air";
  parameter Modelica.SIunits.Temperature TStartWall=293.15
    "Starting Temperature of wall in K";
  parameter Modelica.SIunits.Temperature TStartIns=293.15
    "Starting Temperature of insulation in K";
  parameter Modelica.SIunits.Density rhoIns=1600;
  parameter Modelica.SIunits.SpecificHeatCapacity cIns=1000;
  parameter Modelica.SIunits.Density rhoWall=1600;
  parameter Modelica.SIunits.SpecificHeatCapacity cWall=1000;

//////components///
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor condWall1(G=(
        AWall)*(lambdaWall)/(sWall/2)) annotation (Placement(
        transformation(extent={{-50,0},{-30,20}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor condWall2(G=(
        AWall)*(lambdaWall)/(sWall/2)) annotation (Placement(
        transformation(extent={{-20,0},{0,20}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor condIns1(G=(
        AIns)*(lambdaIns)/(sIns/2)) annotation (Placement(
        transformation(extent={{10,0},{30,20}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor condIns2(G=(
        AIns)*(lambdaIns)/(sIns/2)) annotation (Placement(
        transformation(extent={{38,0},{58,20}}, rotation=0)));
  AixLib.Utilities.HeatTransfer.HeatConv convOutside(alpha=alphaOutside, A=
        AOutside) annotation (Placement(transformation(
        origin={72,8},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatportOuter
    annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=
           0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatportInner
    annotation (Placement(transformation(extent={{-100,0},{-80,20}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor loadWall(C=(
        cWall)*(rhoWall)*(AWall)*(sWall)) annotation (Placement(
        transformation(extent={{-20,-26},{0,-6}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor loadIns(C=(cIns)
        *(rhoIns)*(AIns)*(sIns)) annotation (Placement(
        transformation(extent={{36,-28},{56,-8}}, rotation=0)));

  AixLib.Utilities.HeatTransfer.HeatConv convInside(alpha=alphaInside, A=
        AWall) annotation (Placement(transformation(extent={{-80,0},{-60,20}},
          rotation=0)));
equation
  connect(convOutside.port_a, heatportOuter) annotation (Line(
      points={{82,8},{85.5,8},{85.5,10},{90,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(condWall1.port_b,condWall2.port_a)  annotation (Line(
      points={{-30,10},{-25,10},{-25,10},{-20,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(condWall2.port_b,condIns1.port_a)  annotation (Line(
      points={{0,10},{2,10},{2,12.2},{5,12.2},{5,10},{10,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(condIns1.port_b,condIns2.port_a)  annotation (Line(
      points={{30,10},{34,10},{34,10},{38,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(condIns2.port_b,convOutside.port_b)  annotation (Line(
      points={{58,10},{58,8},{62,8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(loadWall.port, condWall1.port_b) annotation (Line(
      points={{-10,-26},{-26,-26},{-26,10},{-30,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(loadIns.port, condIns1.port_b) annotation (Line(
      points={{46,-28},{32,-28},{32,10},{30,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convInside.port_a, heatportInner) annotation (Line(
      points={{-80,10},{-83.5,10},{-83.5,10},{-90,10}},
      color={191,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(convInside.port_b,condWall1.port_a)  annotation (Line(
      points={{-60,10},{-55,10},{-55,10},{-50,10}},
      color={191,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{40,100},{60,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,255,255}),
        Rectangle(
          extent={{40,-100},{-40,100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,100},{-40,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,255,255}),
        Rectangle(
          extent={{-10,100},{40,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Text(
          extent={{-100,-40},{100,-80}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag,
          textString="%name")}),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Model of a sandwich wall construction for a wall for heat storages.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/> </p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The heat transfer is implemented consisting of the insulation material and the tank material. Only the material data is used for the calculation of losses. No additional losses are included.</p>
</html>",
      revisions="<html>
      <p><ul>
<li><i>October 11, 2016&nbsp;</i> by Sebastian Stinner:<br/>Added to AixLib</li>     
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>
"));
end StorageWall;
