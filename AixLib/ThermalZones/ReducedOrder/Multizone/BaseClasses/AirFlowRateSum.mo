within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
block AirFlowRateSum
  "Air flow rate based on given profile or on occupation and convertion from m3/(m2h) to m3/s"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer dimension "Number of Zones";
  parameter Boolean withProfile = false
    "Input that should be considered" annotation(choices(choice =  false
        "Relative Occupation",choice = true "Profile",radioButtons = true));
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[dimension] "Records of zones";

protected
  Real airFlowVector[dimension]
    "Sum of air flow in the zones";
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
    airFlowVector * 3600 = ((zoneParam.minAHU + (zoneParam.maxAHU - zoneParam.minAHU) * profile) .* zoneParam.AZone);
  else
    airFlowVector * 3600 = ((zoneParam.minAHU + (zoneParam.maxAHU - zoneParam.minAHU) .* relOccupation) .* zoneParam.AZone);
  end if;
  (airFlowRateOutput) = AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.SumCondition(
      airFlowVector,
      zoneParam.withAHU,
      dimension);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-82,82},{78,-54}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="m3/(m2h)
->
m3/s")}),
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
