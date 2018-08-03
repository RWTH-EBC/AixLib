within AixLib.BoundaryConditions.GroundTemperature;
model GroundTemperatureKusuda "Model for undisturbed ground temperature"

  parameter Modelica.SIunits.Temperature T_mean "Average air temperature over the year";
  parameter Modelica.SIunits.TemperatureDifference T_amp
    "Amplitude of surface temperature [(maximum air temperature - minimum air temperature)/2]";
  parameter Modelica.SIunits.Distance D "Depth of ground temperature";
  parameter Modelica.SIunits.ThermalDiffusivity alpha=0.04 "Thermal diffusivity of the ground. Declare in m2/day!";
  parameter Modelica.SIunits.Time t_shift "Time of the year with minimum air temperature. Declare in days!";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature "Transfers computed ground temperature to heat port"
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
<ul>
<li>
  April 30, 2018, by Marcus Fuchs:<br/>
  Update documentation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/561\">issue 561</a>).
  </li>
<li><i>May 2017</i>, by Felix Buenning: Updated information window according to documentation standards</li>
<li><i>October 2016</i>, by Felix Buenning: Developed and implemented</li>
</ul>
</html>", info="<html>

<ul>
<li>This model is a simple model for undisturbed ground temperature</li>
<li>It is used with district heating grids or LTN in order to model thermal pipe losses</li>
</ul>

<h4>Main equations</h4>
<p> T<sub>ground</sub> =T<sub>mean</sub>*T<sub>amp</sub>*exp(-D*&radic;(&pi;/(365*&alpha;)))
*cos((2&pi;/365)(t-t<sub>shift</sub>-(D/2)*&radic;(365/(&pi;*&alpha;))))</p>

<h4>Assumption and limitations</h4> 
<p> The model does not model the influence of the pipe temperature loss on the ground temperature.
The ground temperature is only dependent on the set parameters.</p>

<h4>Typical use and important parameters</h4> 
<p> The model is used as a boundary condition for the thermal losses in district heating pipes. </p> 

<p><b>Differently then stated in the parameter description below t<sub>shift</sub> needs to be 
declared in days and &alpha; needs to me declared in m2/day! (The Modelica SI unit diffusivity 
does not support m2/day as a display unit.)</b></p>


<p>A typical value for &alpha; is bewteen 0.03 and 0.05 m2/day.</p>

<h4>Options</h4> 
<p>No options.</p> 

<h4>Validation</h4> 

<p> The validation was done by comparing simulation results 
(<a href=\"AixLib.BoundaryConditions.GroundTemperature.Examples.ExampleSanFran\">San Francisco example</a>) with the 
findings of the first given reference below (Florides and Kalogirou,2005). </p>
<p>The
<a href=\"https://www.pik-potsdam.de/services/climate-weather-potsdam/climate-diagrams/ground-temperature\">Potsdam Institute for Climate Impact Research</a>
provides measurement data for a German site, which can be used for comparison.</p>


<h4>Implementation</h4> 
<p>The model implements the equation given above and supplies the undisturbed ground temperature via
a heat port.</p> 

<h4>References</h4> 
<ul>
<li>Florides and Kalogirou, 2005, Annual ground temperature measurements at various depths. In: 8th REHVA World Congress, Clima, Lausanne, Switzerland Citeseer, 2005</li>
<li>T. Kusuda, P. R. Achenbach, Earth temperature and thermal diffusivity at selected stations in the united states, Tech. rep., DTIC Document (1965)</li>
<li>B&uuml;nning F., 2017, Simulation-based investigation of bidirectional low temperature district heating and cooling networks and their control, Master thesis</li>
</ul>
</html>
"));
end GroundTemperatureKusuda;
