within AixLib.DataBase.SolarElectric;
record SchuecoSPV170SME1

  extends AixLib.DataBase.SolarElectric.PVBaseDataDefinition(
   n_ser=72,
   n_par=1,
   A_cel=0.125*0.125,
   A_mod=0.8084*1.5804,
   eta_0=0.133,
   V_oc0=44.0,
   I_sc0=5.15,
   V_mp0=35.0,
   I_mp0=4.86,
   P_mp0=170,
   TCoeff_Isc=0.00055*I_sc0,
   TCoeff_Voc=-0.0037*V_oc0,
   gamma_Pmp=-0.0048,
   T_NOCT=45+273.15);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SchuecoSPV170SME1;
