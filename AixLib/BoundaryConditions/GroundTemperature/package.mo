within AixLib.BoundaryConditions;
package GroundTemperature "Package with models to compute the ground temperature"
  extends Modelica.Icons.VariantsPackage;

  model GroundTemperatureKusuda "Model for undisturbed ground temperature"

    parameter Modelica.SIunits.Temperature T_mean "Average air temperature over the year";
    parameter Modelica.SIunits.TemperatureDifference T_amp "Difference between max and min air temperature";
    parameter Modelica.SIunits.Distance D "Depth of ground tempereture";
    parameter Modelica.SIunits.ThermalDiffusivity alpha "Thermal diffusivity of the ground";
    parameter Modelica.SIunits.Time t_shift "Time of the year with minimum air temperature";

public
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a "Heat port for ground" annotation (
        Placement(transformation(extent={{84,-60},{104,-40}}), iconTransformation(
            extent={{84,-60},{104,-40}})));

  equation

    prescribedTemperature.T =  (T_mean)-(T_amp)*(exp(-D*sqrt(Modelica.Constants.pi/(365*alpha)))*cos(2*Modelica.Constants.pi/365*(time/(3600*24)-t_shift-D/2*sqrt(Modelica.Constants.pi/(365*alpha)))));

    connect(prescribedTemperature.port, port_a) annotation (Line(points={{0,-10},{28,-10},{58,-10},{58,-50},
            {94,-50}},                           color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
            points={{-100,20},{-46,14},{-10,20},{24,16},{60,18},{78,12},{100,20},{
                100,-100},{-100,-100},{-100,20}},
            lineColor={0,0,0},
            fillColor={127,66,38},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,20},{-100,32},{-42,22},{-4,30},{32,22},{66,24},{82,20},{
                100,28},{100,20},{78,12},{60,18},{24,16},{-10,20},{-46,14},{-100,20}},
            lineColor={0,0,0},
            fillColor={0,140,72},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,100},{100,100},{100,28},{82,20},{66,24},{32,22},{-4,30},
                {-42,22},{-100,32},{-100,100}},
            lineColor={0,0,0},
            fillColor={0,157,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-70,84},{-40,54}},
            lineColor={0,0,0},
            fillColor={255,255,85},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-139,-104},{161,-144}},
            lineColor={0,0,255},
            textString="%name")}),                                 Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(revisions="<html>
<p>
<ul>
<li><i>October 2016</i>, by Felix Bünning: Developed and implemented</li>
</ul>
</p>
</html>",   info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b></p>
<ul>
<li>This model is a simple model for undisturbed ground temperature</span></li>
<li>It is used with district heating grids or LTN in order to model thermal pipe losses</li>
</ul>
<p><b><span style=\"color: #008000;\">Concept</span></b></p>

<p>The model implements an approach by Kusuda, which is based on the air temperature, ground depth and diffusivity of the ground material.</p>

<p>This approach is widely accepted in literature and is the standard model for ground temperature if no detailed spacial information about the ground is present.</p>

<p><b><span style=\"color: #008000;\">References</span></b></p>
<ul>
<li>B&uuml;nning F., 2017, Simulation-based investigation of bidirectional low temperature district heating and cooling networks and their control, Master thesis</li>
<li>Florides and Kalogirou, 2005, Annual ground tempera- ture measurements at various depths. In: 8th REHVA World Congress, Clima, Lausanne, Switzer- land Citeseer, 2005</li>
<li>T. Kusuda, P. R. Achenbach, Earth temperature and thermal diffusivity at selected stations in the united states, Tech. rep., DTIC Document (1965)</li>

</ul>

<p><b><span style=\"color: #008000;\">Example Results</span></b></p>
<p>
<ul>
<li><a href=\"MasterThesis.Models.GroundTemperature.ExampleSanFran\">San Francisco example</a></li>
<li><a href=\"MasterThesis.Models.GroundTemperature.ExampleCologne\">Cologneo example</a></li>

</ul>
</p>
</html>
"));
  end GroundTemperatureKusuda;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GroundTemperature;
