within AixLib.DataBase;
package SolarElectric
  record PVBaseDataDefinition "Basic record of a PV module"
   extends Modelica.Icons.Record;

   parameter Modelica.SIunits.Efficiency eta_0
      "Efficiency under standard conditions. If not found in data sheet, use eta_0 = ((V_mp0*I_mp0)/(1000*A_cel*n_ser))";
   parameter Real n_ser
      "Number of cells connected in series on the PV panel";
   parameter Real n_par
      "Number of parallel cell circuits on the PV panel";
   parameter Modelica.SIunits.Area A_cel
      "Area of a single cell. If not found in data sheet, use A_cel = ((V_mp0*I_mp0)/(1000*eta_0))/n_ser";
   parameter Modelica.SIunits.Area A_pan = A_cel*n_ser*n_par
      "Area of one Panel, must not be confused with area of the whole module";
   parameter Modelica.SIunits.Area A_mod
      "Area of one module (housing)";
   parameter Modelica.SIunits.Voltage V_oc0
      "Open circuit voltage under standard conditions";
   parameter Modelica.SIunits.ElectricCurrent I_sc0
      "Short circuit current under standard conditions";
   parameter Modelica.SIunits.Voltage V_mp0
      "MPP voltage under standard conditions";
   parameter Modelica.SIunits.ElectricCurrent I_mp0
      "MPP current under standard conditions";
    parameter Modelica.SIunits.Power P_mp0
      "MPP power of one PV module under standard conditions";
   parameter Real TCoeff_Isc(unit = "A/K")
      "Temperature coefficient for short circuit current, >0. If not found in data sheet, use TCoeff_Isc=alpha_Isc*I_sc0 and type in alpha_Isc manually";
   parameter Real TCoeff_Voc(unit = "V/K")
      "Temperature coefficient for open circuit voltage, <0. If not found in data sheet, use TCoeff_Voc=beta_Voc*V_oc0 and type in beta_Voc manually";
   parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_Isc = TCoeff_Isc/I_sc0
      "Normalized temperature coefficient for short circuit current, >0";
   parameter Modelica.SIunits.LinearTemperatureCoefficient beta_Voc = TCoeff_Voc/V_oc0
      "Normalized temperature coefficient for open circuit voltage, <0";
   parameter Modelica.SIunits.LinearTemperatureCoefficient gamma_Pmp
      "Normalized temperature coefficient for power at MPP";
   parameter Modelica.SIunits.Temp_K T_NOCT
      "Cell temperature under NOCT conditions";
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end PVBaseDataDefinition;

  record QPlusBFRG41285
   extends AixLib.DataBase.SolarElectric.PVBaseDataDefinition(
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
