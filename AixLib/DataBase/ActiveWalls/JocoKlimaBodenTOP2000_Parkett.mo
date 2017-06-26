within AixLib.DataBase.ActiveWalls;
record JocoKlimaBodenTOP2000_Parkett
  "Floor Heating Klima Boden TOP 2000 by Joco with parquet"

extends ActiveWallBaseDataDefinition(
    Temp_nom=Modelica.SIunits.Conversions.from_degC({40,35,20}),
    q_dot_nom=80,
    k_isolation=1.25,
    VolumeWaterPerMeter=0.13,
    Spacing=0.25,
    eps=0.9,
    C_ActivatedElement=27400,
    c_top_ratio=0.72,
    PressureDropExponent=1.76,
    PressureDropCoefficient=48500);
annotation (Documentation(revisions="<html>
<ul>
  <li>
<i>September 20, 2013&nbsp;</i> 
         by Mark Wesseling:<br>
         Implemented.</li>
</ul>
</html>",
        info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Record for Floor Heating Klima Boden TOP 2000. </p>
<p>Defines heat exchange properties and storage capacity of the active part of the wall.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/> </p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.ActiveWalls_UC.Panelheating_1D_Dis\">HVAC.Components.ActiveWalls_UC.Panelheating_1D_Dis</a></p>
<p>Source:</p>
<p><ul>
<li>Product: Klima Boden TOP2000</li>
<li>Manufacturer: Joco</li>
<li>Borschure: JOCO KlimaBoden TOP 2000 / OEKOpor Technik Aufbauten; 2013/01</li>
<li>Bibtexkey: JOCOKilmaBoden2013</li>
</ul></p>
</html>"));

end JocoKlimaBodenTOP2000_Parkett;
