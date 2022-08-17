within AixLib.DataBase.ActiveWalls;
record JocoKlimaBodenTOP2000_Parkett
  "Floor Heating Klima Boden TOP 2000 by Joco with parquet"

  extends ActiveWallBaseDataDefinition(
    Temp_nom=Modelica.Units.Conversions.from_degC({40,35,20}),
    q_dot_nom=80,
    k_isolation=1.25,
    k_top=q_dot_nom/AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.logDT({
        Temp_nom[1],Temp_nom[2],(q_dot_nom/8.92)^(1/1.1) + Temp_nom[3]}),
    k_down=(k_isolation^(-1) - k_top^(-1))^(-1),
    VolumeWaterPerMeter=0.13,
    Spacing=0.25,
    eps=0.9,
    C_ActivatedElement=27400,
    c_top_ratio=0.72,
    PressureDropExponent=1.76,
    PressureDropCoefficient=48500);
      // k_top: Third attribute in logDT is T_surface according to GLUECK,
      // Bauteilaktivierung 1999, equation 7.91
      // (for heat flow up) from page 41
annotation (Documentation(revisions="<html><ul>
  <li>
    <i>September 20, 2013&#160;</i> by Mark Wesseling:<br/>
    Implemented.
  </li>
</ul>
</html>",
        info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Record for Floor Heating Klima Boden TOP 2000.
</p>
<p>
  Defines heat exchange properties and storage capacity of the active
  part of the wall.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used with <a href=
  \"HVAC.Components.ActiveWalls_UC.Panelheating_1D_Dis\">HVAC.Components.ActiveWalls_UC.Panelheating_1D_Dis</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>Product: Klima Boden TOP2000
  </li>
  <li>Manufacturer: Joco
  </li>
  <li>Borschure: JOCO KlimaBoden TOP 2000 / OEKOpor Technik Aufbauten;
  2013/01
  </li>
  <li>Bibtexkey: JOCOKilmaBoden2013
  </li>
</ul>
</html>"));

end JocoKlimaBodenTOP2000_Parkett;
