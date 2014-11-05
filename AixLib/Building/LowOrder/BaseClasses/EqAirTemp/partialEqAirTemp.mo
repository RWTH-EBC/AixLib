within AixLib.Building.LowOrder.BaseClasses.EqAirTemp;
partial model partialEqAirTemp

parameter Real aowo=0.6 "Coefficient of absorption of the outer walls";
parameter Real eowo=0.9 "Coefficient of emission of the outer walls";
parameter Integer n=4 "Number of orientations (without ground)";
parameter Real wf_wall[n]={0.5,0.2,0.2,0.1} "Weight factors of the walls";
parameter Real wf_win[n]={0,0,0,0} "Weight factors of the windows";
parameter Real wf_ground=0 "Weight factor of the ground (0 if not considered)";
parameter Modelica.SIunits.Temp_K T_ground=284.15
    "Temperature of the ground in contact with ground slab";

  Modelica.Blocks.Interfaces.RealInput weatherData[3]
    "[1]: Air temperature<br>[2]: Horizontal radiation of sky<br>[3]: Horizontal radiation of earth"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-100,-20},{-60,20}})));
  Utilities.Interfaces.SolarRad_in solarRad_in[n] annotation (Placement(
        transformation(extent={{-100,56},{-80,76}}), iconTransformation(
          extent={{-99,42},{-71,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTemp annotation (
      Placement(transformation(extent={{80,-56},{100,-36}}),
                                                           iconTransformation(
          extent={{60,-76},{100,-36}})));
  Modelica.Blocks.Interfaces.RealInput sunblindsig[n]
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-10,100}),
        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,80})));

  Modelica.SIunits.Temp_K T_earth "radiative temperature of the land surface";
  Modelica.SIunits.Temp_K T_sky "radiative temperature of the sky";

  Modelica.SIunits.Temp_K T_eqWall[n] "temperature equal wall";
  Modelica.SIunits.Temp_K T_eqWin[n] "temperature equal window";

protected
  Modelica.SIunits.RadiantEnergyFluenceRate E_earth
    "Iradiation from land surface";
  Modelica.SIunits.RadiantEnergyFluenceRate E_sky "Iradiation from sky";

  Modelica.SIunits.Temp_K T_air "outdoor air temperature";

  Modelica.SIunits.TemperatureDifference T_eqLW[n] "equal long wave";
  Modelica.SIunits.TemperatureDifference T_eqSW[n] "equal short wave";

  Modelica.SIunits.CoefficientOfHeatTransfer alpharad;

initial equation
  assert(n==size(wf_wall,1),"weightfactorswall has to have n elements");
  assert(n==size(wf_win,1),"weightfactorswall has to have n elements");
 if not sum(wf_wall) + sum(wf_win) + wf_ground <> 0.00001 then
    Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (walls,windows and ground) in eqairtemp is 0. This means, that eqairtemp is 0 �C. If there are no walls, windows and ground at all, this might be irrelevant.");
  end if;
  if abs(sum(wf_wall) + sum(wf_win) + wf_ground - 1) > 0.1 then
    Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (walls,windows and ground) in eqairtemp is <0.9 or >1.1. Normally, the sum should be 1, as the influence of all weightfactors should the whole influence on the temperature.");
  end if;
equation

  if cardinality(sunblindsig)<1 then
    sunblindsig=fill(0,n);
  end if;

  T_air=weatherData[1];
  E_sky=weatherData[2];
  E_earth=weatherData[3];

  if (abs(E_sky+E_earth)<0.1) then
    alpharad=5.0;
  else
    alpharad=(E_sky+E_earth)/(T_sky-T_earth);
  end if;

annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                      graphics={
        Rectangle(
          extent={{-70,-76},{78,76}},
          lineColor={0,128,255},
          lineThickness=1,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,46},{60,-76}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,46},{2,46},{60,74},{60,70},{60,46}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,72},{-28,40}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,-76},{78,-90}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Forward),
        Line(
          points={{-54,-74},{-58,-66},{-50,-62},{-56,-54},{-52,-50},{-54,-44}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1),
        Line(
          points={{-58,-48},{-54,-40},{-50,-46}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-40,-74},{-44,-66},{-36,-62},{-42,-54},{-38,-50},{-40,-44}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1),
        Line(
          points={{-44,-48},{-40,-40},{-36,-46}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-50,34},{-50,10}},
          color={255,255,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-36,36},{-24,14}},
          color={255,255,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-24,46},{-6,32}},
          color={255,255,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{12,-30},{12,-68},{6,-70},{4,-60},{4,-30},{10,-22},{12,-30}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{10,-48},{12,-38},{14,-48}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier)}),
    Documentation(info="",
        revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul></p>
</html>"));
end partialEqAirTemp;
