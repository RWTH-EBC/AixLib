within AixLib.Electrical.PVSystem.BaseClasses;
block PVModule5pNumericalPreCalc
  "Block that determines the main parameters of the numerical 5p approach (De Soto et al.,2006)"

 constant Real e=Modelica.Math.exp(1.0)
   "Euler's constant";
 constant Real pi=Modelica.Constants.pi
   "Pi";
 constant Real k(final unit="J/K") = 1.3806503e-23
   "Boltzmann's constant";
 constant Real q( unit = "A.s")= 1.602176620924561e-19
   "Electron charge";

connector PVModuleData = input
      AixLib.DataBase.SolarElectric.PVBaseDataDefinition;                         //geändert

PVModuleData data;

 parameter Modelica.SIunits.Voltage V_oc0=data.V_oc0
    "Open circuit voltage under standard conditions";
 parameter Modelica.SIunits.ElectricCurrent I_sc0=data.I_sc0
    "Short circuit current under standard conditions";
 parameter Modelica.SIunits.Voltage V_mp0=data.V_mp0
    "MPP voltage under standard conditions";
 parameter Modelica.SIunits.ElectricCurrent I_mp0=data.I_mp0
    "MPP current under standard conditions";
 parameter Real TCoeff_Isc(unit = "A/K")=data.TCoeff_Isc
    "Temperature coefficient for short circuit current, >0";
 parameter Real TCoeff_Voc(unit = "V/K")=data.TCoeff_Voc
    "Temperature coefficient for open circuit voltage, <0";
 parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_Isc= data.alpha_Isc
    "Normalized temperature coefficient for short circuit current, >0";
 parameter Modelica.SIunits.LinearTemperatureCoefficient beta_Voc = data.beta_Voc
    "Normalized temperature coefficient for open circuit voltage, <0";
 parameter Modelica.SIunits.Temp_K T_c0=25+273.15
    "Thermodynamic cell temperature under standard conditions";

 //Initial parameter values from analytical approach (Batzelis, 2016)

  parameter Real a_0start( unit = "V") = V_oc0*(1-T_c0*beta_Voc)/(50.1-T_c0*alpha_Isc);
  parameter Real w_0 = AixLib.Electrical.PVSystem.BaseClasses.Wsimple(exp(1/(a_0start/V_oc0)+1));
  parameter Modelica.SIunits.Resistance R_s0start = (a_0start*(w_0-1)-V_mp0)/I_mp0;
  parameter Modelica.SIunits.Resistance R_sh0start = a_0start*(w_0-1)/(I_sc0*(1-1/w_0)-I_mp0);
  parameter Modelica.SIunits.ElectricCurrent I_ph0start = (1+R_s0start/R_sh0start)*I_sc0;
  parameter Modelica.SIunits.ElectricCurrent I_s0start = I_ph0start*exp(-1/(a_0start/V_oc0));
  parameter Modelica.SIunits.Temp_K T_c30=30+273.15;

  Modelica.Blocks.Interfaces.RealOutput I_ph0(start=I_ph0start)
    "Photo current under standard conditions";
  Modelica.Blocks.Interfaces.RealOutput I_s0(start= I_s0start)
    "Saturation current under standard conditions";
  Modelica.Blocks.Interfaces.RealOutput R_s0(start= R_s0start)
    "Series resistance under standard conditions";
  Modelica.Blocks.Interfaces.RealOutput R_sh0(start= R_sh0start)
    "Shunt resistance under standard conditions";
  Modelica.Blocks.Interfaces.RealOutput a_0(unit = "V", start= a_0start)
    "Modified diode ideality factor under standard conditions";

  parameter Modelica.SIunits.Energy E_g0=1.79604e-19
    "Band gap energy under standard conditions for Si";
  parameter Real C=0.0002677
    "band gap temperature coefficient for Si";

  Modelica.SIunits.Voltage V_oc30(start=(beta_Voc*(T_c30-T_c0)+1)*V_oc0)
    "Open circuit voltage at 30 °C";
  Modelica.SIunits.ElectricCurrent I_ph30(start=(I_ph0start+TCoeff_Isc*(T_c30-T_c0)))
    "Photo current at 30 °C";
  Modelica.SIunits.ElectricCurrent I_s30(start=I_s0start*((T_c30/T_c0)^3*exp(1/k*(E_g0/T_c0-(E_g0*(1-C*(T_c30-T_c0)))/T_c30))))
    "Saturation current at 30 °C";
  Real a_30(unit = "V", start=((beta_Voc*(T_c30-T_c0)+1)*V_oc0)*(1-T_c30*beta_Voc)/(50.1-T_c30*alpha_Isc))
    "Modified diode ideality factor at 30 °C";
  Modelica.SIunits.Resistance R_sh30(start=R_sh0start)
    "Shunt resistance at 30 °C";
  Modelica.SIunits.Energy E_g30
    "Band gap energy at 30 °C";

equation



I_sc0 = I_ph0-I_s0*(exp(I_sc0*R_s0/a_0)-1)-I_sc0*R_s0/R_sh0;
I_ph0 = I_s0*(exp(V_oc0/a_0)-1)+V_oc0/R_sh0;
I_mp0 = I_ph0 - I_s0*(exp((V_mp0+I_mp0*R_s0)/a_0)-1)-(V_mp0+I_mp0*R_s0)/R_sh0;
I_mp0/V_mp0 = (I_s0/a_0*exp((V_mp0+I_mp0*R_s0)/a_0)+1/R_sh0)/(1+I_s0*R_s0/a_0*exp((V_mp0+I_mp0*R_s0)/a_0)+R_s0/R_sh0);
TCoeff_Voc =(V_oc30-V_oc0)/(T_c30-T_c0);

I_ph30 = I_s30*(exp(V_oc30/a_30)-1)+V_oc30/R_sh30;
a_30/a_0 = T_c30/T_c0;
I_s30/I_s0 = (T_c30/T_c0)^3*exp(1/k*(E_g0/T_c0-E_g30/T_c30));
E_g30/E_g0 = 1-C*(T_c30-T_c0);
I_ph30 = (I_ph0+TCoeff_Isc*(T_c30-T_c0));
R_sh0/R_sh30 = 1;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVModule5pNumericalPreCalc;
