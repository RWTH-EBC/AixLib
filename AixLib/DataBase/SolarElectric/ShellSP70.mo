within AixLib.DataBase.SolarElectric;
record ShellSP70
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
end ShellSP70;
