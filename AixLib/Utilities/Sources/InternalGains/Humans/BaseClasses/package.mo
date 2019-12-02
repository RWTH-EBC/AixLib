within AixLib.Utilities.Sources.InternalGains.Humans;
package BaseClasses
  extends Modelica.Icons.BasesPackage;

  function CO2EmissionAdult "Function for human CO2 output"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.DensityOfHeatFlowRate M "Metabolic heat production rate "; //[W/m^2]
    input Modelica.SIunits.Area A "Body surface area"; //[m^2]
    input Modelica.SIunits.Temperature TRoom "Room temperature";
    input Modelica.SIunits.Density dCO2 "CO2 density";
    output Modelica.SIunits.MassFlowRate m_flow
      "CO2 emission of an adult person"; //[kg/s]
    output Modelica.SIunits.VolumeFlowRate V_flow
      "CO2 emission of an adult person"; //[m^3/s]
    output Real k(quantity="VolumeFlowRate", unit="l/h")
      "CO2 emission of an adult person"; //[liter/h]
  algorithm
    k := 0.83 * M*A/5.617 * TRoom/273.15;
    V_flow := k/1000/3600;
    m_flow := V_flow * dCO2;
    annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Function for human CO2 output(kg/s) depending on metabolic heat production rate and body surface area.</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>The CO2 output k (liter/h) is calculated by the following equation[1]:</p>
<p align=\"center\"><i>k = 0.83 * M*A/5.617 * TRoom/273.15</i></p>
<p>The result k is then converted into kg/s (m_flow).</p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>[1]: W. Zapfel, 'Dimensionierung von Lüftungsanlagen für Schulgebäude', Heizung Lüftung Klimatechnik, vol. 11, 2006. p. 4-7 </p>
</html>",   revisions="<html>
<ul>
  <li>
  November, 2019, by Ervin Lejlic and Nils Meyer:<br/>
  First implementation.
  </li>
 </ul>
</html>"));
  end CO2EmissionAdult;
end BaseClasses;
