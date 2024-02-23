within AixLib.DataBase.SolarElectric;
record ShellSP70 "Shell SP70"
  extends AixLib.DataBase.SolarElectric.PVBaseDataDefinition(
   n_ser=36,
   n_par=1,
   A_cel=(0.125)*(0.125),
   A_mod=0.527*1.200,
   eta_0=0.1247,
   V_oc0=21.4,
   I_sc0=4.7,
   V_mp0=16.5,
   I_mp0=4.25,
   P_mp0=70,
   TCoeff_Isc=0.002,
   TCoeff_Voc=-0.076,
   gamma_Pmp=-0.0045,
   T_NOCT=45+273.15);
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record for record used with AixLib.Fluid.Solar.Electric.PVsystem
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>May 6, 2021</i> by Laura Maier:<br/>
    Adapted to new PV model
  </li>
</ul>
</html>"));
end ShellSP70;
