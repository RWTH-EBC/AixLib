within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
block AirFlowRateSplit
  "Air flow rate ratios and unit conversion"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer dimension "Number of Zones";
  parameter Boolean withProfile = false
    "Profile or occupancy as control value for AHU" annotation(choices(
    choice =  false "Relative Occupation",choice = true "Profile",
    radioButtons = true));
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[dimension]
    "Records of zones";
  Modelica.Blocks.Interfaces.RealInput profile
    "Input profile for AHU operation"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
    iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput relOccupation[dimension]
    "Input for relative occupation"
     annotation (
     Placement(transformation(extent={{-140,-74},{-100,-34}}),
     iconTransformation(extent={{-140,-74},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput airFlowIn(final quantity=
    "VolumeFlowRate", final unit="m3/s") "Aggregated air flow rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
    iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput airFlowOut[dimension](final quantity=
    "VolumeFlowRate", final unit="1/h") "Splitted air flow rate"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
    iconTransformation(extent={{100,-20},{140,20}})));

protected
  Real airFlowShare[dimension] "Share of zones at air flow";
  Real airFlowVector[dimension]
    "Sum of air flow in the zones";
  Real airFlowRateOutput "Sum of air flow rates";
  parameter Real defVal[dimension]={if VAir > 0 then 0 else 0.000001 for VAir in zoneParam.VAir}
    "Default value to prevent division by zero";

equation
  if withProfile then
    airFlowVector * 3600 = ((zoneParam.minAHU + (zoneParam.maxAHU -
    zoneParam.minAHU) * profile) .* zoneParam.AZone);
  else
    airFlowVector * 3600 = ((zoneParam.minAHU + (zoneParam.maxAHU -
    zoneParam.minAHU) .* relOccupation) .* zoneParam.AZone);
  end if;
  (airFlowRateOutput,airFlowShare) =
    AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.SumCondition(
      airFlowVector,
      zoneParam.withAHU,
      dimension);
  airFlowOut .* (zoneParam.VAir+defVal) = airFlowShare*airFlowIn*3600;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={Text(
          extent={{-72,38},{58,-10}},
          lineColor={0,0,0},
          textString="m3/s
 ->
1/h")}),
    Documentation(info="<html><p>
  This model splits a given volume flow in m3/s (e.g. for an Air
  Handling Unit) into several flows for one zone each based on:
</p>
<ul>
  <li>Which zone is supplied by the AHU
  </li>
  <li>A minimal volume flow (minAHU) in m3/(m2*h) per zone
  </li>
  <li>A maxmial volume flow (maxAHU = deltaAHU + minAHU) <span style=
  \"font-family: MS Shell Dlg 2;\">in m3/(m2*h) per zone</span>
  </li>
  <li>A given profile or relative occupation per zone
  </li>
</ul>
<p>
  A vector of <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  records is necessary to evaluate which zones are supplied by an AHU.
  The model calculates the single ratios of each zone of the ingoing
  volume flow into the AHU and weights the outcoming volume flow of the
  AHU correspondingly. As thermal zones as consumer typically use 1/h,
  this model converts m3/s to 1/h.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  The governing equations are:
</p>
<p>
  airFlow[nZones] = (minAHU + deltaAHU * (profile OR relative
  Occupation)) * AZone * 3600^-1
</p>
<p>
  airFlowShareZones[nZones] = airFow[nZones] * isSuppliedByAHU[nZones]
</p>
<p>
  airFlowOut[nZones] = airFlowShareZones[nZones] .* airFlowIn
</p>
<p>
  All parameter come from the vector of <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  records. The model is typically used as output adapter for AHU model
  in <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped\">AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped</a>.
</p>
<ul>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Moved to fit to new Annex60 structure.
  </li>
  <li>October 30, 2015, by Moritz Lauster:<br/>
    Moved and adapted to AixLib. Some renaming and adding units.
  </li>
  <li>March 3, 2015, by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end AirFlowRateSplit;
