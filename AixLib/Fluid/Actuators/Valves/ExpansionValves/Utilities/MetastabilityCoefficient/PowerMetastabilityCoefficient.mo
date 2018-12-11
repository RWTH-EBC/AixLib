within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.MetastabilityCoefficient;
model PowerMetastabilityCoefficient
  "Model describing flow coefficient based on power approach"

  extends BaseClasses.Coefficient.PartialMetastabilityCoefficient;

  // Definition of parameters

  //

  /*parameter  Types.MetastabilityModels MetaPowMod = Types.MetastabilityModels.Liang2008
"Chose predefinied power model for Metastability parameter";*/

  parameter Types.PowerModels MetaPowMod=Types.MetaPowerModels.Liang2009;

  parameter Real a "Multiplication factor for generic power approach"
    annotation (Dialog(group="Modelling approach"));
  parameter Real b[:] "Exponents for each multiplier"
    annotation (Dialog(group="Modelling approach"));
  parameter Integer nT=size(b, 1)
    "Number of terms used for the calculation procedure"
    annotation (Dialog(group="Modelling approach", enable=false));

  parameter Modelica.SIunits.Diameter dCle=0.02e-3
    "Clearance diameter dCle = d_inner - d_needle" annotation (Dialog(
        group="Further geometry data", enable=if (powMod == Types.PowerModels.ShanweiEtAl2005)
           then true else false));
  parameter Real pDifRat=0.84
    "Pressure differential ratio factor depending on valve moddeld"
    annotation (Dialog(group="Further geometry data", enable=if (powMod ==
          Types.PowerModels.Li2013) then true else false));

  Modelica.SIunits.Diameter dThr=opening*dInlPip;

  Modelica.SIunits.Diameter d_e=dInlPip - dThr;

  // Definition of coefficients
  //
  Real P[nT]
    "Array that contains all coefficients used for the calculation procedure";
  //  Real corFact "Corraction factor used to correct flow coefficient";

  /*The correction factor is used to correct the flow coefficient if the 
    formula presented by the author is not equal to 
    m_flow = C_D*A*sqrt(2*rho_inlet*(pInl-pOut))
  */
  Modelica.SIunits.AbsolutePressure p_th "Pressure at throat Valve";

protected
  Medium.SaturationProperties satInl
    "Saturation properties at valve's inlet conditions";
  Medium.SaturationProperties satOut
    "Saturation properties at valve's outlet conditions";

equation
  // Calculation of protected variables
  //

    satInl = Medium.setSat_p(pInl)
    "Saturation properties at valve's inlet conditions";
  satOut = Medium.setSat_p(pOut)
    "Saturation properties at valve's outlet conditions";

  // Calculation of coefficients
  //
  if (MetaPowMod == Types.MetaPowerModels.Liang2009) then

    /*  Caution with units - In the following, none S.I units are presented:
        Pressure:       in kPa
        Temperature:    in °C
        Heat capacity:  in kJ/(kg*K)
        Heat of vap.:   in kJ/kg
    */

    //Für Anfangszustand Liquid mit Phasenwechsel
    //R410,R22,R407C
    /*Metastability approach presented by Liang and Jingui (2007):  */
    P[1] = pInl/Medium.fluidConstants[1].criticalPressure
      "Relationship between upstream pressure and cricitcal Pressure";
    P[2] = (satInl.Tsat - Medium.temperature(staInl))/(Medium.fluidConstants[
      1].criticalTemperature - 273.15) "Degree of Subcooling";
    P[3] = Medium.density(staInl)/(1000*pInl/(
      Medium.specificHeatCapacityCp(staInl)*(Medium.fluidConstants[1].criticalTemperature
       - 273.15))) "Inlet liquid density";
    P[4] = Medium.dynamicViscosity(staInl)/(d_e*sqrt(Medium.density(
      staInl)*pInl)*10^6) "Inlet liquid viscosity";
    P[5] = d_e/dThr "Throat area";
    //P[6] = p_th / Medium.fluidConstants[1].criticalPressure     "Pressure at the throat";
    p_th = Medium.fluidConstants[1].criticalPressure*a*product(abs(P[i])^
      b[i] for i in 1:nT) "Calculation Pressure at the throat";
    //C _D = 0.94
    //C_D=0.9673 - 5.6682/sqrt(dInlet*d_e*vInl/viscotität)
     C_meta*satInl.psat =  (satInl.psat-p_th);

  else
    assert(false, "Invalid choice of power approach");
  end if;

  // Calculationg of flow coefficient
  //
  // C_d = corFact*a*product(abs(P[i])^b[i] for i in 1:nT)    "Calculation procedure of generic power approach";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-58,-4},{56,-88}},
          lineColor={28,108,200},
          textString="M
"), Ellipse(extent={{-110,118},{80,-88}}, lineColor={28,108,200})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PowerMetastabilityCoefficient;
