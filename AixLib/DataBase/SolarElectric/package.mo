within AixLib.DataBase;
package SolarElectric
  record PVBaseDataDefinition "Basic record of a PV module"
   extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.Efficiency eta_0
    "Efficiency under standard conditions. If not found in data sheet, use eta_0 = ((V_mp0*I_mp0)/(1000*A_cel*n_ser))"
    annotation (Dialog(group="General"));
   parameter Real n_ser
      "Number of cells connected in series on the PV panel"
      annotation(Dialog(group="General"));
   parameter Real n_par
      "Number of parallel cell circuits on the PV panel"
      annotation(Dialog(group="General"));
  parameter Modelica.Units.SI.Area A_cel
    "Area of a single cell. If not found in data sheet, use A_cel = ((V_mp0*I_mp0)/(1000*eta_0))/n_ser"
    annotation (Dialog(group="Cell specific: Geometrical data"));
  parameter Modelica.Units.SI.Area A_pan=A_cel*n_ser*n_par
    "Area of one Panel, must not be confused with area of the whole module"
    annotation (Dialog(group="Cell specific: Geometrical data"));
  parameter Modelica.Units.SI.Area A_mod "Area of one module (housing)"
    annotation (Dialog(group="Cell specific: Geometrical data"));
  parameter Modelica.Units.SI.Voltage V_oc0
    "Open circuit voltage under standard conditions"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
  parameter Modelica.Units.SI.ElectricCurrent I_sc0
    "Short circuit current under standard conditions"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
  parameter Modelica.Units.SI.Voltage V_mp0
    "MPP voltage under standard conditions"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
  parameter Modelica.Units.SI.ElectricCurrent I_mp0
    "MPP current under standard conditions"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
  parameter Modelica.Units.SI.Power P_mp0
    "MPP power of one PV module under standard conditions"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
   parameter Real TCoeff_Isc(unit = "A/K")
      "Temperature coefficient for short circuit current, >0. If not found in data sheet, use TCoeff_Isc=alpha_Isc*I_sc0 and type in alpha_Isc manually"
      annotation(Dialog(group="Cell specific: Electrical characteristics"));
   parameter Real TCoeff_Voc(unit = "V/K")
      "Temperature coefficient for open circuit voltage, <0. If not found in data sheet, use TCoeff_Voc=beta_Voc*V_oc0 and type in beta_Voc manually"
      annotation(Dialog(group="Cell specific: Electrical characteristics"));
  parameter Modelica.Units.SI.LinearTemperatureCoefficient alpha_Isc=TCoeff_Isc
      /I_sc0 "Normalized temperature coefficient for short circuit current, >0"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
  parameter Modelica.Units.SI.LinearTemperatureCoefficient beta_Voc=TCoeff_Voc/
      V_oc0 "Normalized temperature coefficient for open circuit voltage, <0"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
  parameter Modelica.Units.SI.LinearTemperatureCoefficient gamma_Pmp
    "Normalized temperature coefficient for power at MPP"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
  parameter Modelica.Units.SI.Temperature T_NOCT
    "Cell temperature under NOCT conditions"
    annotation (Dialog(group="Cell specific: Electrical characteristics"));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end PVBaseDataDefinition;

  record QPlusBFRG41285 "Q.Plus BFR-G4.1 285"
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
    Adapted record which is also used in research project FUBIC
    suppored by the BMWi (promotional reference: 03ET1619)
  </li>
</ul>
</html>"));
  end QPlusBFRG41285;
end SolarElectric;
