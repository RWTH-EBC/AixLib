within AixLib.DataBase;
package SolarElectric
  record QPlusBFRG41285
   extends AixLib.DataBase.SolarElectric.PVBaseRecord(
     n_ser=60,
     n_par=1,
     A_cel=((V_mp0*I_mp0)/(1000*eta_0))/n_ser,
     A_mod=1.000*1.670,
     eta_0=0.171,
     V_oc0=39.22,
     I_sc0=9.46,
     V_mp0=31.99,
     I_mp0=8.91,
     P_mp0=285,
     TCoeff_Isc=0.0004*I_sc0,
     TCoeff_Voc=-0.0029*V_oc0,
     gamma_Pmp=-0.004,
     T_NOCT=45+273.15);
  end QPlusBFRG41285;
end SolarElectric;
