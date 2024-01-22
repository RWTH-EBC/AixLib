within AixLib.DataBase.Boiler.General;
record Boiler_Vitocrossal200_311kW
  "Gas-fired condensing boiler Viessmann Vitocrossal200 311kW"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitocrossal200_311kW",
    volume=279/1000,
    pressureDrop = 4000/(7.79e-3)^2,
    Q_nom = 326000,
    Q_min = 326000*0.33,
    eta = [0.3, (0.973+0.989)/2;
           0.4, (0.960+0.981)/2;
           0.5, (0.942+0.975)/2;
           0.6, (0.924+0.968)/2;
           0.7, (0.907+0.962)/2;
           0.8, (0.889+0.957)/2;
           0.9, (0.872+0.953)/2;
           1.0, (0.857+0.952)/2]);
    annotation (preferredView="text",Documentation(revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>September 28, 2013&#160;</i>by Peter Matthes:<br/>
    implemented.
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  3 efficiencies are given in the TechDoc.
</p>
<ol>
  <li>supply: 40 °C, return: 30 °C (second column in data set)
  </li>
  <li>supply: 75 °C, return: 60 °C (first column in data set)
  </li>
  <li>supply: 90 °C, return: 70 °C (not used in data set)
  </li>
</ol>
<p>
  As supply temperatures around 50 °C are common (see heating curve),
  the average of the first two efficiencies was used.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used with <a href=
  \"HVAC.Components.HeatGenerators.Boiler.BoilerWithController\">HVAC.Components.HeatGenerators.Boiler.BoilerWithController</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>Product: Vitocrossal 200
  </li>
  <li>Manufacturer: Viessmann
  </li>
  <li>Broschure: Vitocrossal 200 CM2 Technical Data; 08/2012
  </li>
  <li>URL:
  http://www.viessmann.ca/content/dam/internet-ca/pdfs/commercial/vitocrossal_200_tdm.pdf
  </li>
</ul>
</html>"));
end Boiler_Vitocrossal200_311kW;
