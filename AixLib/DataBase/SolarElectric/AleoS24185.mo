within AixLib.DataBase.SolarElectric;
record AleoS24185 "solarmodul AleoS24.185"

  extends AixLib.DataBase.SolarElectric.PVBaseDataDefinition(
   n_ser=48,
   n_par=1,
   A_cel=(0.156)*(0.156),
   A_mod=0.990*1.345,
   eta_0=0.139,
   V_oc0=29.4,
   I_sc0=8.31,
   V_mp0=23.6,
   I_mp0=7.85,
   P_mp0=185,
   TCoeff_Isc=0.0004*I_sc0,
   TCoeff_Voc=-0.0034*V_oc0,
   gamma_Pmp=-0.0046,
   T_NOCT=47+273.15);
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  single Area=1,33155m2
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
end AleoS24185;
