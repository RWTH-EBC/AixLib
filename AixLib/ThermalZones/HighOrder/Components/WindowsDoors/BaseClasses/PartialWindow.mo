within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses;
partial model PartialWindow "Partial model for windows"

  extends PartialWindowParamOnly;

  Utilities.Interfaces.SolarRad_in
                                 solarRad_in
annotation (Placement(
    transformation(extent={{-100,50},{-80,70}}),
        iconTransformation(extent={{-100,50},{-80,70}})));
  Utilities.Interfaces.RadPort
                          radPort
                       annotation (Placement(transformation(extent={{80,50},{
            100,70}}), iconTransformation(extent={{80,50},{100,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_inside
annotation (
 Placement(transformation(extent={{80,-20},{100,0}}),
        iconTransformation(extent={{80,-20},{100,0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
annotation (Placement(transformation(extent={{-100,-20},{-80,0}}), iconTransformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if use_windSpeedPort
annotation (Placement(
      transformation(extent={{-116,-76},{-82,-42}}),
      iconTransformation(extent={{-100,-60},{-80,-40}}),
      visible=use_windSpeedPort));
  Modelica.Blocks.Interfaces.RealOutput solarRadWinTrans if use_solarRadWinTrans
    "Output signal connector"
    annotation (Placement(transformation(extent={{82,70},{102,90}}), visible=use_solarRadWinTrans));

  Modelica.Blocks.Math.Gain Ag(final k(
      unit="m2",
      min=0.0) = (1 - WindowType.frameFraction)*windowarea)
    annotation (Placement(transformation(extent={{-16,54},{-4,66}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),   Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
      Line(
        points={{-66,18},{-62,18}},
        color={255,255,0})}));
end PartialWindow;
