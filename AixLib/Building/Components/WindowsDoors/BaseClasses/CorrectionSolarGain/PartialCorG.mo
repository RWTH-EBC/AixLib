within AixLib.Building.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
partial model PartialCorG
  "partial model for correction of the solar gain factor"

   parameter Integer n = 1 "vector size for input and output";

public
  Utilities.Interfaces.SolarRad_in SR_input[n] annotation (Placement(
        transformation(extent={{-122,-20},{-80,20}},rotation=0),
        iconTransformation(
        extent={{18,-19},{-18,19}},
        rotation=180,
        origin={-98,-1})));
  Modelica.Blocks.Interfaces.RealOutput solarRadWinTrans[n](unit="W/m2")
    "transmitted solar radiation through window"
    annotation (Placement(transformation(extent={{80,-10},{100,10}}),
        iconTransformation(extent={{80,-10},{100,10}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-52,24},{62,-16}},
          lineColor={0,0,0},
          textString="%name")}));
end PartialCorG;
