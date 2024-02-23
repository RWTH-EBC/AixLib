within AixLib.Controls.VentilationController;
model VentilationController
  "transforms occupation and temperature into air exchange rate"
  parameter Boolean useConstantOutput=false
    "provide constant ACH(=baseACH), false = no user induced infiltration (window opening)";
  parameter Real baseACH=0.2 "baseline air changes per hour"   annotation (Dialog(enable=true));
  parameter Real maxUserACH=1.0 "additional ACH value for max. user activity"   annotation (Dialog(enable=not
                                                                                                (useConstantOutput)));
  parameter Real[2] maxOverheatingACH={3.0,2.0}
    "additional ACH value when overheating appears, transition range in K" annotation (Dialog(enable=not
                                                                                                (useConstantOutput)));
  parameter Real[3] maxSummerACH={1.0,273.15 + 10,273.15 + 17}
    "additional ACH in summer, Tmin, Tmax" annotation (Dialog(enable=not
                                                                        (useConstantOutput)));
  parameter Real[3] winterReduction={0.2,maxSummerACH[2] - 10,maxSummerACH[2]}
    "reduction factor of userACH for cold weather." annotation (Dialog(enable=not
                                                                                 (useConstantOutput)));

  Real userACH "additional ACH value for max. user window opening activity";
  Real dToh "relative overheating";
  Real overheatingACH "additional ACH value when overheating appears";
  Real dTamb "relative summer (0: winter, 1: summer)";
  Real dTmin
    "relative winter (0: transition start (10 degC), 1: winter end (0 degC)";
  Real redFac
    "reduction factor of user ventilation for cold outside air temperatures.";

  Real summerACH "additional ACH due to summer temperature";

  Modelica.Blocks.Interfaces.RealInput relOccupation "relative occupation"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}}),
        iconTransformation(extent={{-120,-80},{-80,-40}})));
  output Modelica.Blocks.Interfaces.RealOutput
                                        y
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));

  Modelica.Blocks.Interfaces.RealInput Tambient "ambient Temperature"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput Tzone "zone temperature"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}}),
        iconTransformation(extent={{-120,40},{-80,80}})));
  BaseClasses.OptimalTempDeCarliHumidity optimalTemp(cat=2)
    "optimal temperature according to investigations from deCarli"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  BaseClasses.DEMA dEMA(ystart=Tmean_start)
    "gliding exponential average of outdoor temperature"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealOutput Tamb_mean "mean outdoor temperature"
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  parameter Real Tmean_start=277.85 "Start value of EMA";
  output Modelica.Blocks.Interfaces.RealOutput Top "optimal temperature"
    annotation (Placement(transformation(extent={{80,50},{100,70}}),
        iconTransformation(extent={{80,50},{100,70}})));
equation
  assert(relOccupation < 1.01,
    "Error in ventilation model. Relative occupation must not exceed 1.0!");
  optimalTemp.u[2] = 0.5 "assuming constant relative humidity in zone";
  if useConstantOutput then
    userACH = 0;
    dToh = 0;
    overheatingACH = 0;
    dTamb = 0;
    dTmin = 0;
    redFac = 0;
    summerACH = 0;
  else

    userACH = relOccupation*maxUserACH "user induced ventilation";

    dToh = (Tzone - optimalTemp.y[2])/maxOverheatingACH[2]
      "relative overheating";
    overheatingACH = if dToh > 0 then min(dToh*maxOverheatingACH[1],
      maxOverheatingACH[1]) else 0;

    dTamb = (dEMA.y[2] - maxSummerACH[2])/(maxSummerACH[3] - maxSummerACH[2])
      "determine when transition period occurs";
    dTmin = (dEMA.y[2] - winterReduction[2])/(winterReduction[3] -
      winterReduction[2]);
    redFac = if dTmin > 0 then min(dTmin*(1 - winterReduction[1]), 1 -
      winterReduction[1]) + winterReduction[1] else winterReduction[1];

    summerACH = if dTamb > 0 then min(dTamb*maxSummerACH[1], maxSummerACH[1])
       else 0;
  end if;

  y = baseACH + userACH*redFac + overheatingACH + summerACH;
  connect(Tambient, dEMA.u) annotation (Line(
      points={{-100,0},{-62,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dEMA.y[2], optimalTemp.u[1]) annotation (Line(
      points={{-39,0},{-34.75,0},{-34.75,-0.5},{-2,-0.5},{-2,0}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(dEMA.y[2], Tamb_mean) annotation (Line(
      points={{-39,0},{-16,0},{-16,-60},{90,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(optimalTemp.y[3], Top) annotation (Line(
      points={{21,0},{40,0},{40,60},{90,60}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics={Text(
          extent={{-62,-12},{-20,-16}},
          lineColor={0,0,255},
          textString="using non-sampled average")}),
    Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={95,95,95},
          fillColor={238,238,238},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere),
        Line(
          points={{-20,56},{56,20}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-20,-56},{56,-20}},
          color={95,95,95},
          smooth=Smooth.None),
        Text(
          extent={{2,-36},{100,-80}},
          lineColor={0,0,255},
          textString="Ta"),
        Text(
          extent={{-14,24},{84,-20}},
          lineColor={0,0,255},
          textString="ACH"),
        Text(
          extent={{-4,84},{94,40}},
          lineColor={0,0,255},
          textString="Top")}),
    Documentation(info="<html><p>
  Ventilation is determined from 4 effects:
</p>
<ol>
  <li>People acitivity: according to the occupancy profile more
  ventilation will happen, when more people are at home (active).
  </li>
  <li>Outside temperature: less ventilation at low temperatures and
  vice versa (people leave windows open in summer).
  </li>
  <li>Inside temperature: the higher the inside temperature, the more
  ventilation will occure (people preventing overheating).
  </li>
  <li>Leakage: due to leakage through cracks or openings there will be
  a constant air exchange.
  </li>
</ol>
<ul>
  <li>
    <i>April, 2016&#160;</i> by Peter Remmen:<br/>
    Moved from Utilities to Controls
  </li>
</ul>
<ul>
  <li>
    <i>October, 2015&#160;</i> by Moritz Lauster:<br/>
    Adapted and moved to AixLib
  </li>
</ul>
<ul>
  <li>
    <i>May, 2008&#160;</i> by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>"));
end VentilationController;
