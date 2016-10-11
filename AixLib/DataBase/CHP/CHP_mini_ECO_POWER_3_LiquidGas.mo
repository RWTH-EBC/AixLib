within AixLib.DataBase.CHP;
record CHP_mini_ECO_POWER_3_LiquidGas
  "Vaillant: mini BHKW eco Power 3 (Liquid gas)"
  extends CHPBaseDataDefinition(
    Vol={2.72e-3},
    data_CHP=[0,  0,  0,  0,  0;
             65,  1.95,  5.2,  0.09,  25.8;
             100,  3,  8,  0.132,  39.7],
    MaxTFlow=348.15,
    MaxTReturn=338.15,
    Pipe_D=0.08);
/* the el. and thermal powers are in KW. The fuel mass flow is in l/s. The fuel consumption is in l/kWh.
 the calorific value of liquid gas is assumed 28 kWh/m^3.
 and the calorific value of natural gas is assumed 12 kWh/m^3.
*/
  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Vaillant mini-BHKW ecoPOWER 3.0 (Liquid Gas) </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The electrical and thermal powers are in kW. The fuel mass flow is in l/s. The fuel consumption is in l/kWh.</p>
<p>The calorific value of liquid gas is assumed to be 28 kWh/m&sup3; and the calorific value of natural gas is assumed to be 12 kWh/m&sup3;. </p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">HVAC.Components.HeatGenerators.CHP.CHP</a></p>
<p>Source:</p>
<p><ul>
<li>Bibtexkey: Vaillant-2012</li>
<li>URL: <a href=\"http://www.vaillant.de/Produkte/Kraft-Waerme-Kopplung/Blockheizkraftwerke/produkt_vaillant/mini-KWK-System_ecoPOWER_3.0_und_4.7.html\">mini-KWK-System_ecoPOWER_3.0_und_4.7.html</a></li>
<li>URL: <a href=\"http://www.vaillant.de/stepone2/data/downloads/21/4b/00/Prospekt-KWK.pdf\">Prospekt-KWK.pdf</a></li>
</ul></p>
</html>",
        revisions="<html>
<p><ul>
<li></li>
<li><i>January 24, 2013</i> by Peter Matthes:<br/>implemented</li>

</ul></p>
</html>"));
end CHP_mini_ECO_POWER_3_LiquidGas;
