within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
partial model PartialCorG
  "partial model for correction of the solar gain factor"

  extends PartialCorGParamOnly;

  Utilities.Interfaces.SolarRad_in SR_input[n] annotation (Placement(
        transformation(extent={{-122,-20},{-80,20}}),
        iconTransformation(
        extent={{18,-19},{-18,19}},
        rotation=180,
        origin={-98,-1})));
  Modelica.Blocks.Interfaces.RealOutput solarRadWinTrans[n](unit="W/m2")
    "transmitted solar radiation through window"
    annotation (Placement(transformation(extent={{80,-10},{100,10}}),
        iconTransformation(extent={{80,-10},{100,10}})));
  annotation ( Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Partial model for correction cofficient for transmitted solar radiation through a window.</p>
</html>"));
end PartialCorG;
