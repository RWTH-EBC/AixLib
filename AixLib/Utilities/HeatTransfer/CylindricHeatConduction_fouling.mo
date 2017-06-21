within AixLib.Utilities.HeatTransfer;
model CylindricHeatConduction_fouling
  "Heat conduction through a time depending biofilm on the outside of a cylindric material "

  parameter Modelica.SIunits.Length d_out=0.02 "outer diameter of pipe";
    parameter Modelica.SIunits.Length s_biofilm_min= 0.0005
    "min thickness of biofilm, that could be reached by cleaning";
  parameter Modelica.SIunits.Length length=1 " Length of pipe";
  parameter Integer nParallel = 1 "Number of identical parallel pipes";
  parameter Modelica.SIunits.ThermalConductivity lambda_film=1.06
    "Heat conductivity of the biofilm";
  parameter Modelica.SIunits.Velocity v_bio_grow = 3.617E-09
    "Growing velocity of biofilm in m/s";
  parameter Modelica.SIunits.Velocity v_bio_clean = 8.3E-06
    "Cleaning velocity of biofilm in m/s";
  parameter Modelica.SIunits.Length s_biofilm_0 = 0.0001
    "Thikness of biofilm at simulation start";

  Modelica.SIunits.Length d_out_biofilm
    "Thikness of biofilm, when cleaning will be started";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,-6},{10,14}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{-10,78},{10,98}},
          rotation=0)));

  Modelica.Blocks.Interfaces.RealOutput s_biofilm( start=s_biofilm_0,min=0)
    "thickness of biofilm"
    annotation (Placement(transformation(extent={{82,-8},{102,12}})));
  Modelica.Blocks.Interfaces.BooleanInput biofilm_removing
    annotation (Placement(transformation(extent={{-128,-18},{-88,22}})));
// initial equation
//   biofilm_removing=false;

equation

  if biofilm_removing and s_biofilm>s_biofilm_min then
    der(s_biofilm)=-v_bio_clean;
  elseif biofilm_removing and s_biofilm<=s_biofilm_min then
    der(s_biofilm)=0;
  else
    der(s_biofilm)=v_bio_grow;
  end if;

  d_out_biofilm = d_out + 2*s_biofilm;
  port_a.Q_flow + port_b.Q_flow = 0;
  port_a.Q_flow = (2*lambda_film*length*Modelica.Constants.pi/(log(d_out_biofilm/d_out)))*(port_a.T - port_b.T)*nParallel;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                        graphics={Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p> Model to describe cylindric heat conduction, for example in pipe
insulations. </p>
</html>",
      revisions="<html>
<ul>
<li><i>October 12, 2016&nbsp;</i> by Marcus Fuchs:<br/>Add description and fix documentation</li>
<li><i>October 11, 2016&nbsp;</i> by Sebastian Stinner:<br/>Transferred to AixLib</li>
<li><i>November 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
  <li>
         by Alexander Hoh:<br/>
         implemented</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end CylindricHeatConduction_fouling;
