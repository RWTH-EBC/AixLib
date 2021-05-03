within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model tabsHeatingCurve
  Modelica.Blocks.Interfaces.RealInput tDryBul "Outdoor Air Temperature"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput powerOutput "TABS power output curve"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Real power_high "High power output [W/m^2]";
  parameter Real power_low "Low power output [W/m^2]";
  parameter Real T_upperlimit "Hot temperature threshold";
  parameter Real T_lowerlimit "Cold Temperature threshold";

equation
  //Set Power Supply
  if tDryBul < T_lowerlimit then
    powerOutput = power_high;
  elseif tDryBul < T_upperlimit then
    powerOutput = power_high - ((power_high - power_low)/(T_lowerlimit - T_upperlimit)) * (T_lowerlimit-tDryBul);
  else
    powerOutput = power_low;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end tabsHeatingCurve;
