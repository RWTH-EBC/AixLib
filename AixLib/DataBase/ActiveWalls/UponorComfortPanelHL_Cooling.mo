within AixLib.DataBase.ActiveWalls;
record UponorComfortPanelHL_Cooling
  "Ceiling cooling from Uponor Comfort panel HL"

  extends ActiveWallBaseDataDefinition(
    Temp_nom=Modelica.Units.Conversions.from_degC({16,20,26}),
    q_dot_nom=74,
    k_isolation=0.38,
    k_top=q_dot_nom/AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.logDT({
        Temp_nom[1],Temp_nom[2],(q_dot_nom/8.92)^(1/1.1) + Temp_nom[3]}),
    k_down=(k_isolation^(-1) - k_top^(-1))^(-1),
    VolumeWaterPerMeter=0.03848,
    Spacing=0.10,
    eps=0.9,
    C_ActivatedElement=1000,
    c_top_ratio=0.99,
    PressureDropExponent=1.8895,
    PressureDropCoefficient=32.981);
      // k_top: Thir attribute in logDT is T_surface according to GLUECK,
      // Bauteilaktivierung 1999, equation 7.91
      // (for heat flow up) from page 41
    annotation (Documentation(revisions="<html><ul>
  <li>
    <i>February 13, 2014&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>",
      info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Record for celing cooling system from Uponor Comfort panel HL.
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
  \"EBC.HVAC.Components.ActiveWalls.Panelheating_1D_Dis\">EBC.HVAC.Components.ActiveWalls.Panelheating_1D_Dis</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>Product: Comfort Panel HL
  </li>
  <li>Manufacturer: Uponor
  </li>
  <li>Borschure: Gebäudetechnik / TECHNISCHER GESAMTKATALOG 2013/14 /
  Uponor Kassettendeckensystzem Comfort Panel HL
  </li>
  <li>c_top_ratio: guess value 99 %; goes towards the room
  </li>
  <li>C_Floorheating: guess value (it shouldn't be too small, but the
  storage is minimal)
  </li>
  <li>k_isolation: guess value according to the the PE-X material
  </li>
</ul>
</html>"));

end UponorComfortPanelHL_Cooling;
