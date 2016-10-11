within AixLib.Fluid.Storage.BaseClasses;
model storage_mantle
  import HVAC;

//////parameters////

  parameter Modelica.SIunits.Length height=0.15 "Hoehe der Schicht"  annotation(Dialog(tab="Geometrical Parameters"));
  parameter Modelica.SIunits.Diameter D1=1 "Innendurchmesser des Tanks" annotation(Dialog(tab="Geometrical Parameters"));
  parameter Modelica.SIunits.Thickness d_wall=0.1 "Thickness of wall" annotation(Dialog(tab="Geometrical Parameters"));
  parameter Modelica.SIunits.Thickness d_ins=0.1 "Thickness of insulation" annotation(Dialog(tab="Geometrical Parameters"));
  /*parameter SI.Length roughness(min=0) = 2.5e-5 
    "Absolute roughness of storage inside wall (default = smooth steel pipe)" annotation 4;*/

final parameter Modelica.SIunits.Area A_inside= D1*Modelica.Constants.pi * height;
final parameter Modelica.SIunits.Area A_outside= (D1+2*(d_wall+d_ins))*Modelica.Constants.pi * height;

  parameter Modelica.SIunits.ThermalConductivity lambda_wall=50
    "Thermal Conductivity of wall";
    parameter Modelica.SIunits.ThermalConductivity lambda_ins=0.045
    "Thermal Conductivity of insulation";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_inside=2
    "Coefficient of Heat Transfer water <-> wall";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_outside=2
    "Coefficient of Heat Transfer insulation <-> air";
  parameter Modelica.SIunits.Temperature T_start_wall=293.15
    "Starting Temperature of wall in K";
  parameter Modelica.SIunits.Temperature T_start_ins=293.15
    "Starting Temperature of insulation in K";
  parameter Modelica.SIunits.Density rho_ins=1600;
  parameter Modelica.SIunits.SpecificHeatCapacity c_ins=1000;
  parameter Modelica.SIunits.Density rho_wall=1600;
  parameter Modelica.SIunits.SpecificHeatCapacity c_wall=1000;

//////components///
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_outer
    annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=
           0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_inner
    annotation (Placement(transformation(extent={{-100,0},{-80,20}},
          rotation=0)));

    HVAC.Components.Pipes.BaseClasses.Insulation.CylindricHeatTransfer Insulation(
    rho=rho_ins,
    c=c_ins,
    lambda=lambda_ins,
    T0=T_start_ins,
    length=height,
    d_out=D1 + 2*d_wall + 2*d_ins,
    d_in=D1 + 2*d_wall)
    annotation (Placement(transformation(extent={{-4,-12},{44,32}})));
    HVAC.Components.Pipes.BaseClasses.Insulation.CylindricHeatTransfer Wall(
    rho=rho_wall,
    c=c_wall,
    lambda=lambda_wall,
    T0=T_start_wall,
    length=height,
    d_out=D1 + 2*d_wall,
    d_in=D1) annotation (Placement(transformation(extent={{-70,-12},{-22,32}})));
  AixLib.Utilities.HeatTransfer.HeatConv conv_inside(alpha=alpha_inside, A=
        A_inside) annotation (Placement(transformation(extent={{-80,4},{-68,16}},
          rotation=0)));
  AixLib.Utilities.HeatTransfer.HeatConv conv_inside1(A=A_outside, alpha=
        alpha_outside) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={62,10})));
equation
  connect(conv_inside.port_a, heatport_inner) annotation (Line(
      points={{-80,10},{-84.5,10},{-84.5,10},{-90,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(conv_inside1.port_a, heatport_outer) annotation (Line(
      points={{68,10},{78.7,10},{78.7,10},{90,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(conv_inside.port_b,Wall.port_a)  annotation (Line(
      points={{-68,10},{-46,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Wall.port_b,Insulation.port_a)  annotation (Line(
      points={{-46,29.36},{-14,29.36},{-14,10},{20,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Insulation.port_b,conv_inside1.port_b)  annotation (Line(
      points={{20,29.36},{38,29.36},{38,10},{56,10}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}),
                      graphics),
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
<p>Model of a sandwich wall construction for a cylindric mantle for heat storages.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/> </p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The cylindric heat transfer is implemented consisting of the insulation material and the tank material. Only the material data is used for the calculation of losses. No additional losses are included.</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>
"));
end storage_mantle;
