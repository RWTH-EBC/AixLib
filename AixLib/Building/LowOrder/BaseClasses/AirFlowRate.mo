within AixLib.Building.LowOrder.BaseClasses;
model AirFlowRate
  "Calculates the air flow rate for an Air Handling Unit either based on a given profile or based on occupation"

  parameter Integer dimension "Number of Zones";
  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneParam[dimension]
    "Zone Setup";
  parameter Boolean withSchedule = false
    "Choose whether the air flow rate should be calculated using the schedule";
  Real AirFlowVector[dimension]
    "Temp Variable to sum up the air flow in the zones";
  Modelica.Blocks.Interfaces.RealInput schedule "Input for AHU schedule"
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealOutput airFlowRateOutput
    "Output for calculated air flow rate"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput relOccupation[dimension] annotation (
      Placement(transformation(extent={{-120,-60},{-80,-20}}),
        iconTransformation(extent={{-120,-60},{-80,-20}})));

equation
  if withSchedule then
    AirFlowVector * 3600 = ((zoneParam.minAHU + (zoneParam.maxAHU - zoneParam.minAHU) * schedule) .* zoneParam.RoomArea);
    airFlowRateOutput =SumCondition(
      AirFlowVector,
      zoneParam.withAHU,
      dimension);
  else
    AirFlowVector * 3600 = ((zoneParam.minAHU + (zoneParam.maxAHU - zoneParam.minAHU) .* relOccupation) .* zoneParam.RoomArea);
    airFlowRateOutput =SumCondition(
      AirFlowVector,
      zoneParam.withAHU,
      dimension);
  end if;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{16,62},{-64,-6}},
          fillPattern=FillPattern.Solid,
          fillColor={170,213,255},
          pattern=LinePattern.None),
        Ellipse(
          extent={{-6,18},{-74,-48}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{56,50},{-6,0}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{42,24},{-26,-40}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{72,20},{30,-16}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-84,-62},{90,-90}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{26,10},{72,-10}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="Air",
          lineColor={0,0,0}),
        Text(
          extent={{-68,-2},{16,-30}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          textString="Occup."),
        Text(
          extent={{-58,46},{48,14}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="Schedule",
          lineColor={0,0,0})}),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Vdot_air = [minAHU + deltaAHU * (Schedule OR relative Occupation)] * Azone * 3600^-1
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>", revisions="<html>
<p><ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul></p>
<p><ul>
<li><i>March 3, 2014&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end AirFlowRate;
