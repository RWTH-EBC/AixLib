within AixLib.Building.LowOrder.BaseClasses;
model AirFlowRateSum
  "Calculates the air flow rate for an Air Handling Unit either based on a given profile or based on occupation and changes unit from m3/(m2h) to m3/s"

  parameter Integer dimension "Number of Zones";
  parameter DataBase.Buildings.ZoneBaseRecord zoneParam[dimension] "Zone Setup";
  parameter Boolean withProfile = false
    "Choose which input should be considered" annotation(choices(choice =  false
        "Relative Occupation",choice = true "Profile",radioButtons = true));
protected
  Real airFlowVector[dimension]
    "Temp Variable to sum up the air flow in the zones";
public
  Modelica.Blocks.Interfaces.RealInput profile
    "Input profile for AHU operation"
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealOutput airFlowRateOutput(
  final quantity="VolumeFlowRate",
  final unit="m3/s") "Output for calculated air flow rate"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput relOccupation[dimension]
    "Input for relative occupation"                             annotation (
      Placement(transformation(extent={{-120,-60},{-80,-20}}),
        iconTransformation(extent={{-120,-60},{-80,-20}})));
equation
  if withProfile then
    airFlowVector * 3600 = ((zoneParam.minAHU + (zoneParam.maxAHU - zoneParam.minAHU) * profile) .* zoneParam.RoomArea);
  else
    airFlowVector * 3600 = ((zoneParam.minAHU + (zoneParam.maxAHU - zoneParam.minAHU) .* relOccupation) .* zoneParam.RoomArea);
  end if;
  (airFlowRateOutput) =SumCondition(
      airFlowVector,
      zoneParam.withAHU,
      dimension);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
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
<p>This model calculates the volume flow (e.g. for an Air Handling Unit) dependent on:</p>
<ul>
<li>A minimal volume flow (minAHU) in m3/(m2*h)</li>
<li>A maxmial volume flow (maxAHU = deltaAHU + minAHU) <span style=\"font-family: MS Shell Dlg 2;\">in m3/(m2*h)</span></li>
<li>A given profile or relative occupation</li>
</ul>
<p>ZoneBaseRecord is necessary to evaluate which zones are supplied by an AHU and should be incorporated into calculation.
<br/>The model gives in addition the share of ingoing volume flows at the outgoing volume flow.</p><p>As AHUs typically work with m3/s, the model calculates the output air flow rate Vdot_air in m3/s.</p>
<p>airFlowRateOutput = [minAHU + deltaAHU * (profile OR relative Occupation)] * Azone * 3600^-1 </p>
</html>", revisions="<html>
<ul>
<li><i>February 26, 2016&nbsp;</i> by Moritz Lauster:<br/>To get the correct share of volume flow for each zone, more outputs are generated.</li>
</ul>
<ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib. Some renaming and adding units</li>
</ul>
<ul>
<li><i>March 3, 2014&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>"));
end AirFlowRateSum;
