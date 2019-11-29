within AixLib.Utilities.Sources.InternalGains.Humans.BaseClasses;
function CO2emissionAdult "Function for human CO2 output"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.DensityOfHeatFlowRate M "Metabolic value";
  input Modelica.SIunits.Area A "Surface area";
  input Modelica.SIunits.Temperature Troom "Room temperature";
  input Modelica.SIunits.Density dCO2 "m3 -> kg";
  output Modelica.SIunits.MassFlowRate memSI
    "CO2 emission of an adult person in kg/s";
  output Modelica.SIunits.VolumeFlowRate qemSI
    "CO2 emission of an adult person in m3/s";
  output Real qem(quantity="VolumeFlowRate", unit="l/h")
    "CO2 emission of an adult person in l/h";
algorithm
  qem := 0.83 * M*A/5.617 * Troom/273.15 "in l/h";
  qemSI := qem/1000/3600 "in m3/s";
  memSI := qemSI * dCO2;
  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Function for human CO2 output(kg/s) depending on metabolic value and body surface area.</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>The CO2 output(l/h) is calculated by the following equation[1]:</p>
<p align=\"center\"><i>qem = 0.83&middot;M&middot;A / 5.617&middot;Troom / 273.15</i></p>
<p>The result qem is converted into kg/s (memSI).</p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>[1]: W. Zapfel, 'Dimensionierung von Lüftungsanlagen für Schulgebäude', Heizung Lüftung Klimatechnik, vol. 11, 2006. p. 4-7 </p>
</html>", revisions="<html>
<ul>
  <li>
  November, 2019, by Ervin Lejlic and Nils Meyer:<br/>
  First implementation.
  </li>
 </ul>
</html>"));
end CO2emissionAdult;
