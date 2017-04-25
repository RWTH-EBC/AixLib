within AixLib.FastHVAC.Data.Boiler.General;
record Boiler_Vitocrossal200_311kW
  "Gas-fired condensing boiler Viessmann Vitocrossal200 311kW"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitocrossal200_311kW",
    volume=279/1000,
    PressureDrop = 4000/(7.79e-3)^2,
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
                                  annotation (preferredView="text",
              Documentation(revisions="<html>
<ul>
  <li><i>September 28, 2013&nbsp;</i>
         by Peter Matthes:<br>
         implemented.</li>
</ul>
</html>", info="<html>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>3 efficiencies are given in the TechDoc.</p>
<p><ol>
<li>supply: 40 &deg;C, return: 30 &deg;C (second column in data set)</li>
<li>supply: 75 &deg;C, return: 60 &deg;C (first column in data set)</li>
<li>supply: 90 &deg;C, return: 70 &deg;C (not used in data set)</li>
</ol></p>
<p>As supply temperatures around 50 &deg;C are common (see heating curve), the average of the first two efficiencies was used.</p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.Boiler.BoilerWithController\">HVAC.Components.HeatGenerators.Boiler.BoilerWithController</a></p>
<p>Source:</p>
<p><ul>
<li>Product: Vitocrossal 200</li>
<li>Manufacturer: Viessmann</li>
<li>Borschure: Vitocrossal 200 CM2 Technical Data; 08/2012</li>
<li>URL: http://www.viessmann.ca/content/dam/internet-ca/pdfs/commercial/vitocrossal_200_tdm.pdf</li>
</ul></p>
</html>"));
end Boiler_Vitocrossal200_311kW;
