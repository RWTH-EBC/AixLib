within AixLib.Controls.VentilationController;
model VentilationController
  "transforms occupation and temperature into air exchange rate"

  parameter Real Tmean_start=277.85 "Start value of EMA_TAmbient";
  parameter Real relHum_start=0.5 "Start value of EMA_relHum";

  parameter Boolean useConstantOutput=false
    "true: provide constant ACH(=baseACH), 
     false: user induced infiltration (window opening), summer, and overheating infiltration";
  parameter Real baseACH=0.2 "baseline air changes per hour"   annotation (Dialog(enable=true));
  parameter Real maxUserACH=1.0 "additional ACH value for max. user activity"   annotation (Dialog(enable=not
                                                                                                (useConstantOutput)));
  parameter Real[3] maxOverheatingACH={1.0, 3.0, 5.0}
    "additional ACH when overheating appears and ambient air is below zone temperature
      (1: max ACH when zone is occupied, 
       2: max ACH rate when zone is not occupied (e.g. for night ventilation),
       3: difference between zone and cooling set temperature at max ACH rate)"
                                                                                   annotation (Dialog(enable=not                (useConstantOutput)));
  parameter Real[3] maxSummerACH={1.0,273.15 + 10,273.15 + 17}
    "additional ACH in summer period, increasing relative to ambient temperature.
    Only if ambient temperature is below zone temperature
      (1: max ACH for additional summer infiltration, 
       2: minimum ambient temperature for summer period,
       3: maximum ambient temperature for summer period -> max summer ACH rate)"
                                                                                annotation (Dialog(enable=not
                                                                                                             (useConstantOutput)));
  parameter Real[3] winterReduction={0.2,maxSummerACH[2] - 10,maxSummerACH[2]}
    "reduction factor of userACH for lower ambient temperatures (e.g. winter).
      (1: relative reduction of userACH for additional summer infiltration, 
      2: maximum of ambient temperature for reduced infiltration -> start of ACH reduction,
       3: minimum of ambient temperature for reduced infiltration -> max reduction of ACH)"
                                                                                            annotation (Dialog(enable=not
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
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}}),
        iconTransformation(extent={{-100,-80},{-80,-60}})));
  output Modelica.Blocks.Interfaces.RealOutput totalACH "Total ACH rate"
    annotation (Placement(transformation(extent={{80,20},{100,40}}),
        iconTransformation(extent={{80,20},{100,40}})));

  Modelica.Blocks.Interfaces.RealInput Tambient "ambient Temperature"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}}),
        iconTransformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput Tzone "zone temperature"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}}),
        iconTransformation(extent={{-100,-40},{-80,-20}})));
  BaseClasses.DEMA DEMA_TAmbient(ystart=Tmean_start)
    "gliding exponential average of outdoor temperature"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

  Modelica.Blocks.Interfaces.RealInput TSetCool "Cooling set point for zone"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
        iconTransformation(extent={{-100,60},{-80,80}})));

  Modelica.Blocks.Interfaces.BooleanOutput Active_HVAC_Override
    "Switch off active HVAC components (AHU and IdealHeaterCooler), 
     when passive cooling via overheatingACH and summerACH exceeds 0.5/h" annotation (Placement(transformation(extent={{80,-40},{100,-20}})));

  Utilities.Logical.DynamicHysteresis HysteresisOverheatingSummerACH
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Math.Add dTZoneAmbient(k1=-1, k2=+1) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-40,60})));
  Modelica.Blocks.Sources.Constant const5(k=3)
    annotation (Placement(transformation(extent={{12,20},{0,32}})));
  Modelica.Blocks.Sources.Constant const1(k=2)
    annotation (Placement(transformation(extent={{-32,20},{-20,32}})));
equation
  assert(relOccupation < 1.01,
    "Error in ventilation model. Relative occupation must not exceed 1.0!");


  connect(Tambient, DEMA_TAmbient.u) annotation (Line(
      points={{-90,30},{-62,30}},
      color={0,0,127},
      smooth=Smooth.None));

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

    dToh = (Tzone - (TSetCool-1))/maxOverheatingACH[3]
      "relative overheating to cooling set temperature";
    dTamb =(DEMA_TAmbient.y[2] - maxSummerACH[2])/(maxSummerACH[3] -
      maxSummerACH[2])
      "relative behavior of the ambient temperature, determines when transition period occurs";
    dTmin =(DEMA_TAmbient.y[2] - winterReduction[2])/(winterReduction[3] -
      winterReduction[2]);
    redFac = if dTmin > 0 then min(dTmin*(1 - winterReduction[1]), 1 -
      winterReduction[1]) + winterReduction[1] else winterReduction[1];

    // if Tzone > Tambient + 3 then
    if HysteresisOverheatingSummerACH.y and TSetCool > Tambient + 3 then

      if dToh > 0 then
        if dTamb > 0 then
          if relOccupation > 0 then
            overheatingACH = min(dToh*dTamb*maxOverheatingACH[1], maxOverheatingACH[1]);
          else
            overheatingACH = min(dToh*dTamb*maxOverheatingACH[2], maxOverheatingACH[2]);
          end if;
        else
          if relOccupation > 0 then
            overheatingACH = min(dToh*maxOverheatingACH[1], maxOverheatingACH[1]);
          else
            overheatingACH = min(dToh*maxOverheatingACH[2], maxOverheatingACH[2]);
          end if;
        end if;
      else
        overheatingACH = 0;
      end if;

      if dTamb > 0 and Tambient > maxSummerACH[2] then
        summerACH =  min(dTamb*maxSummerACH[1], maxSummerACH[1]);
      else
        summerACH = 0;
      end if;

    else

      overheatingACH = 0;
      summerACH = 0;

    end if;

  end if;

  if overheatingACH + summerACH > 1 then
    Active_HVAC_Override = true;
  else
    Active_HVAC_Override = false;
  end if;

  totalACH = baseACH + userACH*redFac + overheatingACH + summerACH;

  connect(Tzone, dTZoneAmbient.u2) annotation (Line(points={{-90,-30},{-70,-30},
          {-70,56.4},{-47.2,56.4}}, color={0,0,127}));
  connect(Tambient, dTZoneAmbient.u1) annotation (Line(points={{-90,30},{-74,30},
          {-74,63.6},{-47.2,63.6}}, color={0,0,127}));
  connect(dTZoneAmbient.y, HysteresisOverheatingSummerACH.u)
    annotation (Line(points={{-33.4,60},{-22,60}}, color={0,0,127}));
  connect(const5.y, HysteresisOverheatingSummerACH.uHigh)
    annotation (Line(points={{-0.6,26},{-7,26},{-7,48}}, color={0,0,127}));
  connect(const1.y, HysteresisOverheatingSummerACH.uLow)
    annotation (Line(points={{-19.4,26},{-15,26},{-15,48}}, color={0,0,127}));
   annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics={Text(
          extent={{-76,10},{-26,-8}},
          lineColor={0,0,255},
          textString="using non-sampled averages")}),
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
          smooth=Smooth.None)}),
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
