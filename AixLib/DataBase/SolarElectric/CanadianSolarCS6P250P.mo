within AixLib.DataBase.SolarElectric;
record CanadianSolarCS6P250P "CS6P250PPoly"

  extends AixLib.DataBase.SolarElectric.PVBaseDataDefinition(
   n_ser=60,
   n_par=1,
   A_cel= ((V_mp0*I_mp0)/(1000*eta_0))/n_ser,
   A_mod=0.982*1.638,
   eta_0=0.1247,
   V_oc0=37.2,
   I_sc0=8.87,
   V_mp0=30.1,
   I_mp0=8.30,
   P_mp0=250,
   TCoeff_Isc=0.00065*I_sc0,
   TCoeff_Voc=-0.0034*V_oc0,
   gamma_Pmp=-0.0043,
   T_NOCT=45+273.15);
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  single Area=1,608516m2
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record for record used with <a href=
  \"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>May 6, 2021</i> by Laura Maier:<br/>
    Adapted to new PV model
  </li>
  <li>
    <i>October 11, 2016</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>September 01, 2014&#160;</i> by Xian Wu:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end CanadianSolarCS6P250P;
