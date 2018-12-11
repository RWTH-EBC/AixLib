within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.MetastabilityCoefficient;
model PolynomialMetastabilityCoefficient
  "Model describing metastability coefficient based on polynomial"
   extends BaseClasses.Coefficient.PartialMetastabilityCoefficient;

  Real C_meta "Metastbility Coefficient";

  // Definition of parameters
  //
  parameter Types.PolynomialModels MetaPolyMod=Types.MetaPolynomialModel.Liang2009
    "Chose predefined polynomial model for metastability coefficient"
    annotation (Dialog(group="Modelling approach"));

  parameter Real a[:] "Multiplication factors for each summand"
    annotation (Dialog(group="Modelling approach"));
  parameter Real b[:] "Exponents for each summand"
    annotation (Dialog(group="Modelling approach"));
  parameter Integer nT=size(a, 1)
    "Number of terms used for the calculation procedure"
    annotation (Dialog(group="Modelling approach", enable=false));

  parameter Modelica.SIunits.Diameter dCle=0.02e-3
    "Clearance diameter dCle = d_inner - d_needle" annotation (Dialog(
        group="Further geometry data", enable=if (polyMod == Types.PolynomialModels.ShanweiEtAl2005)
           then true else false));
  parameter Real pDifRat=0.84
    "Pressure differential ratio factor depending on valve moddeld"
    annotation (Dialog(group="Further geometry data", enable=if (polyMod ==
          Types.PolynomialModels.Li2013) then true else false));

  // Definition of coefficients
  //
  Real P[nT]
    "Array that contains all coefficients used for the calculation procedure";
  Real corFact "Corraction factor used to correct flow coefficient";

  /*The correction factor is used to correct the flow coefficient if the 
    formula presented by the author is not equal to 
    m_flow = C_D*A*sqrt(2*rho_inlet*(pInl-pOut))
  */

protected
  Medium.SaturationProperties satInl
    "Saturation properties at valve's inlet conditions";
  Medium.SaturationProperties satOut
    "Saturation properties at valve's outlet conditions";

equation
  // Calculation of protected variables
  //
  satInl = Medium.setSat_T(Medium.temperature(staInl))
    "Saturation properties at valve's inlet conditions";
   //  satInl = Medium.setSat_p(pInl)
  satOut = Medium.setSat_p(pOut)
    "Saturation properties at valve's outlet conditions";

  // Calculation of coefficients
  //
  /*if (MetaPolyMod == Types.PolynomialModels.Liu2006) then
    /*Polynominal approach presented by Jinghui Liu *, Jiangping Chen, Qifang Ye, Zhijiu Chen et al.(2006):
    C_meta = a0+a1*T_subcooling+a2*AThr-a3*AThr^2
    P[1] = 1 "Dummy coefficient since no coefficient is needed";
    P[2] = satInl.Tsat - Medium.temperature(staInl)
      "Temperature subcooling";
    P[3] = AVal*opening "Area throat valve";
    P[4] = (AVal*opening)^2 "quadratic Area throat valve";
    C_meta = sum(a[i]*P[i]^b[i] for i in 1:nT)
      "Calculation procedure of generel polynomial";
    C_meta = (satInl.psat - p_th)/p_th; */

  if (MetaPolyMod == Types.MetaPolynomialModel.Liang2009) then
    /* p_th = a0+a1*pInl+a2+deltaT_subcooling+a3*deltaT_subcooling^2+a4*Athr
    Chen Liang *, Chen Jiangping, Liu Jinghui, Chen Zhijiu (2008) */

    P[1] = 1 "Dummy coefficient since no coefficient is needed";
    P[2] = pInl "Pressure at inlet";
    P[3] = satInl.Tsat - Medium.temperature(staInl);
    P[4] = (satInl.Tsat - Medium.temperature(staInl))^2;
    P[5] = AVal*opening;

    p_th = sum(a[i]*P[i]^b[i] for i in 1:nT);
    C_meta*satInl.psat = (satInl.psat - p_th);

  elseif (MetaPolyMod == Types.MetaPolynomialModel.Liu2007) then

    P[1] = 1 "Dummy coefficient since no coefficient is needed";
    P[2] = satInl.Tsat - Medium.temperature(staInl) "Subccoling temperature";
    P[3] = AVal*opening;
    P[4] = (AVal*opening)^2;
    C_meta = sum(a[i]*P[i]^b[i] for i in 1:nT);
    C_meta*satInl.psat = (satInl.psat - p_th);

  else
    assert(false, "Invalid choice of polynomial approach");
  end if;

  //Calculation of Metastability coefficient
  //

  corFact = 1;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-58,-4},{56,-88}},
          lineColor={28,108,200},
          textString="M
"), Ellipse(extent={{-110,118},{80,-88}}, lineColor={28,108,200})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PolynomialMetastabilityCoefficient;
