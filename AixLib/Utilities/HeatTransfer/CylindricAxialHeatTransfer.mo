within AixLib.Utilities.HeatTransfer;
model CylindricAxialHeatTransfer "Combined Cylindric and Axial Heat Transfer"

  parameter Modelica.SIunits.Density rho=1600;
  parameter Modelica.SIunits.SpecificHeatCapacity c=1000;
  parameter Modelica.SIunits.Length d_out=0.04 "outer diameter of pipe";
  parameter Modelica.SIunits.Length d_in=0.02 "inner diameter of pipe";
  parameter Modelica.SIunits.Length length=1 " Length of pipe";
  parameter Modelica.SIunits.ThermalConductivity lambda=373
    "Heat conductivity of pipe";
  parameter Modelica.SIunits.Temperature T0=289.15 "initial temperature";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a innerTherm
    "Thermal Connector on the inside"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a outerTherm
    "Thermal connector on the outside"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
          rotation=0), iconTransformation(extent={{-100,-10},{-80,10}})));
  CylindricHeatTransfer                                              CylindricHeatConductionOut(
    length=length,
    lambda=lambda,
    d_in=(d_out + d_in)/2,
    d_out=d_out) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,0})));
  CylindricLoad                                              CylindricLoad1(
    port(T(start=T0)),
    rho=rho,
    c=c,
    d_in=d_in,
    d_out=d_out,
    length=length) annotation (Placement(transformation(extent={{-55,-9},{-35,
            11}}, rotation=0)));
  CylindricHeatTransfer                                              CylindricHeatConductionIn(
    length=length,
    lambda=lambda,
    d_out=(d_out + d_in)/2,
    d_in=d_in) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatCondToBack(
      G=((Modelica.Constants.pi/4)*((d_out*d_out) - (d_in*d_in)))*(lambda)/
        (length/2)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-45,30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatCondToFront(
      G=((Modelica.Constants.pi/4)*((d_out*d_out) - (d_in*d_in)))*(lambda)/
        (length/2)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-45,-30})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a backTherm
    "Thermal Connector facing back or down"
    annotation (Placement(transformation(extent={{80,80},{100,100}},
          rotation=0), iconTransformation(extent={{80,80},{100,100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a frontTherm
    "Thermal Connector facing front or up"
    annotation (Placement(transformation(extent={{-98,-98},{-78,-78}},
          rotation=0), iconTransformation(extent={{-100,-100},{-80,-80}})));
equation
  connect(innerTherm,CylindricHeatConductionIn.port_a)  annotation (Line(
      points={{0,0},{-10.2,0},{-10.2,2.44929e-017},{-20,2.44929e-017}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(CylindricHeatConductionIn.port_b, CylindricLoad1.port) annotation (
      Line(
      points={{-28.8,5.38845e-016},{-37.4,5.38845e-016},{-37.4,0.2},{-45.2,0.2}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(CylindricLoad1.port, CylindricHeatConductionOut.port_a) annotation (
      Line(
      points={{-45.2,0.2},{-57.1,0.2},{-57.1,2.44929e-017},{-68,2.44929e-017}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(CylindricHeatConductionOut.port_b, outerTherm) annotation (Line(
      points={{-76.8,5.38845e-016},{-82.4,5.38845e-016},{-82.4,0},{-90,0}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(heatCondToBack.port_a, CylindricLoad1.port) annotation (Line(
      points={{-45,20},{-45,10},{-45.2,10},{-45.2,0.2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(CylindricLoad1.port, heatCondToFront.port_b) annotation (Line(
      points={{-45.2,0.2},{-45,-16},{-45,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatCondToBack.port_b, backTherm)
                                      annotation (Line(
      points={{-45,40},{-45,68},{90,68},{90,90}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatCondToFront.port_a, frontTherm)
                                        annotation (Line(
      points={{-45,-40},{-45,-64},{-88,-64},{-88,-88}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,85,85}),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{172,30},{172,-22}}, textString=
                                              "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
            {100,100}}), graphics),
    Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>A model that combined cylindric and axial heat transfer.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>Model developed as part of DA025 &QUOT;Modellierung und Simulation eines LowEx-Geb&auml;udes in der objektorientierten Programmiersprache Modelica&QUOT; by Tim Comanns</li>
</ul>
</html>",
      revisions="<html>
<p><ul>
<li><i>July 31, 2018&nbsp;</i> by Michael Mans:<br/>Transfer to AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns:<br/>Implemented.</li>
</ul></p>
</html>"));
end CylindricAxialHeatTransfer;
