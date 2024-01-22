within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
partial model PartialCorG
  "partial model for correction of the solar gain factor"

  parameter Integer n = 1
    "vector size for input and output";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer Uw=3
    "Thermal transmission coefficient of whole window";
  parameter Real g = 0.7
   "Coefficient of solar energy transmission";

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
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-52,24},{62,-16}},
          lineColor={0,0,0},
          textString="%name")}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Partial model for correction cofficient for transmitted solar
  irradiance through a window.
</p>
</html>"));
end PartialCorG;
