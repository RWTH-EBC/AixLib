within AixLib.DataBase.CHP.CHPDataSimple;
record CHP_mini_ECO_POWER_3 "Vaillant: mini BHKW eco Power 3 (Natural Gas)"
extends CHPDataSimple.CHPBaseDataDefinition(
  vol={2.72e-3},
  data_CHP=[0,     0,     0,     0,     0;
           58,  1.76,  4.7,  7.8624,  54.4;
           100,    3,    8, 13.3488,  92.6],
  maxTFlow=348.15,
  maxTReturn=338.15,
  DPipe=0.08);
/* the el. and thermal powers are in KW. The fuel input is in kW. The fuel
consumption is in l/kWh.
 the calorific value of liquid gas is assumed 28 kWh/m^3.
 and the calorific value of natural gas is assumed 12 kWh/m^3.
*/
annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Vaillant mini-BHKW ecoPOWER 3.0 (Natural Gas)
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The electrical and thermal powers are in kW. The fuel mass flow is in
  l/s. The fuel consumption is in l/kWh.
</p>
<p>
  The calorific value of liquid gas is assumed to be 28 kWh/m³ and the
  calorific value of natural gas is assumed to be 12 kWh/m³.
</p>
<p>
  Source:
</p>
<ul>
  <li>URL: <a href=
  \"http://www.vaillant.de/Produkte/Kraft-Waerme-Kopplung/Blockheizkraftwerke/produkt_vaillant/mini-KWK-System_ecoPOWER_3.0_und_4.7.html\">
    mini-KWK-System_ecoPOWER_3.0_und_4.7.html</a>
  </li>
  <li>URL: <a href=
  \"http://www.vaillant.de/stepone2/data/downloads/21/4b/00/Prospekt-KWK.pdf\">
    Prospekt-KWK.pdf</a>
  </li>
</ul>
</html>",
      revisions="<html><ul>
  <li>
    <i>January 24, 2013</i> by Peter Matthes:<br/>
    implemented
  </li>
</ul>
</html>"));
end CHP_mini_ECO_POWER_3;
