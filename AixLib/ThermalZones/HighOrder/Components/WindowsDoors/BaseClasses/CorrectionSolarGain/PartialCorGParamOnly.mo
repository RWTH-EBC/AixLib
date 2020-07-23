within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
model PartialCorGParamOnly "Partial model containing parameters but no connectors for correction of the solar gain factor"

   parameter Integer n = 1 "vector size for input and output";
   parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw = 3
    "Thermal transmission coefficient of whole window";
   parameter Real g = 0.7
    "Coefficient of solar energy transmission";

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
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Partial model for correction cofficient for transmitted solar radiation through a window.</p>
</html>"));
end PartialCorGParamOnly;
