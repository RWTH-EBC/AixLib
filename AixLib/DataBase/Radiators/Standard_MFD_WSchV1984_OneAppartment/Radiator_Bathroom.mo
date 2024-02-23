within AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment;
record Radiator_Bathroom
  "ThermX2, Profil V (Kermi) Power=603W, L=700, H=300, Typ=22, {75,65,24}"
  extends AixLib.DataBase.Radiators.RadiatorBaseDataDefinition(
    NominalPower=861,
    RT_nom={348.15,338.15,297.15},
    PressureDrop=1017878,
    Exponent=1.2776,
    VolumeWater=3.6,
    MassSteel=17.01,
    Type=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.ThermX2Typ22,
    length=0.7,
    height=0.3);
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Kermi radiator \"Flachheizkörper\" ThermX2, Profil V
</p>
<p>
  Delta_T = 75°C - 65°C = 10K
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b>Attention</b>: The data for NominalPower, MassSteel and
  VolumeWater are given per 1 meter.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"HVAC.Components.HeatExchanger.Radiator_ML\">HVAC.Components.HeatExchanger.Radiator_ML</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>Manufacturer: Kermi
  </li>
  <li>Product: Flachheizkörper ThermX2 Profil V
  </li>
  <li>Booklet: \"Flachheizkörper\", I/2010, Pages 44-52.
  </li>
  <li>Bibtexkey:Kermi-FHK2010
  </li>
</ul>
<ul>
  <li>
    <i>August 13, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>November 15, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>"));
end Radiator_Bathroom;
