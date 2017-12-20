within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.VoidFractions;
model Sangi2015
  "Void fraction model developed by Sangi et al. (2015)"
  extends BaseClasses.PartialVoidFraction;

  // Definition of further parameters
  //
  parameter Real sliFra = 1
    "Avarage slip fraction defining the ratio between the vapour and 
    liquid velocity"
    annotation(Dialog(tab="General",group="General"));

  // Definition of variables describing the saturation state
  //
  Medium.SaturationProperties TP = Medium.setSat_p(p=p)
    "Saturation properties";

  Modelica.SIunits.Density dLiq = Medium.bubbleDensity(sat=TP)
    "Density at bubble line";
  Modelica.SIunits.Density dVap = Medium.dewDensity(sat=TP)
    "Density at dew line";
  Modelica.SIunits.SpecificEnthalpy hLiq = Medium.bubbleEnthalpy(sat=TP)
    "Specific enthalpy at bubble line";
  Modelica.SIunits.SpecificEnthalpy hVap = Medium.dewEnthalpy(sat=TP)
    "Specific enthalpy at dew line";

  Real xInlDes(unit="1")
    "Qulality at inlet";
  Real xOutDes(unit="1")
    "Qulality at outlet";

  // Definition of variables describing dericataives of the void fraction
  //
  Real ddLiqdp(unit="kg/(m3.Pa)") = Medium.dBubbleDensity_dPressure(sat=TP)
    "Derivative of bubble density wrt. saturation pressure";
  Real ddVapdp(unit="kg/(m3.Pa)") = Medium.dDewDensity_dPressure(sat=TP)
    "Derivative of dew density wrt. saturation pressure";
  Real dhLiqdp(unit="J/(kg.Pa)") = Medium.dBubbleEnthalpy_dPressure(sat=TP)
    "Derivative of bubble enthalpy wrt. saturation pressure";
  Real dhVapdp(unit="J/(kg.Pa)") = Medium.dDewEnthalpy_dPressure(sat=TP)
    "Derivative of dew enthalpy wrt. saturation pressure";

  Real dvoiFradp
    "Partial derivative of meaVoiFra wrt. pressure";
  Real dvoiFradhInl
    "Partial derivative of meaVoiFra wrt. specific enthalpy at inlet";
  Real dvoiFradhOut
    "Partial derivative of meaVoiFra wrt. specific enthalpy at outlet";

  // Definition of calculation procedure of void fraction
  //
  function voidFraction
    "Void fraction at total vaporisation"

      // Definition of inputs
      //
      input Modelica.SIunits.Density dLiq
        "Density at bubble line";
      input Modelica.SIunits.Density dVap
        "Density at dew line";
      input Real xInl(unit="1")
        "Vapour quality at inlet (near bubble line)";
      input Real xOut(unit="1")
        "Vapour quality at outlet (near dew line)";
      input Real sliFra = 1
        "Avarage slip fraction defining the ratio between the vapour and 
        liquid velocity";

      // Definition of outputs
      //
      output Real voiFra(unit="1")
        "Void fraction";

  protected
      Real mu = dVap/dLiq
        "Ration of saturation densities";
      Real dx
        "Difference of qualities";
      Real beta
        "Auxiliary variable";

  algorithm
      // Avoid devision by zero
      //
      dx := smooth(1, if noEvent(abs(xOut - xInl) > Modelica.Constants.small)
                      then xOut - xInl else Modelica.Constants.small)
        "Difference of qualities";

      // Avoid negative logarithmic argument
      //
      beta := log(max(((xOut*(sliFra - 1) + 1)*(xInl*(1 - mu) + mu))/
                       ((xInl*(sliFra - 1) + 1)*(xOut*(1 - mu) + mu)),
                       Modelica.Constants.small))
        "Auxiliary variable";

      // Calculate total mean void fraction
      //
      voiFra := ((xOut-xInl)*(1-sliFra*mu)+mu*(xInl*(sliFra-1)+1)*
                   (xOut*(sliFra-1)+1)*beta)/(dx*(1-sliFra*mu)^2)
        "Total mean void fraction";
  end voidFraction;


equation
  // Calculation of vapour qualities at inlet and outlet
  //
  xInlDes = smooth(1, if hSCTP>hLiq then (hSCTP-hLiq)/(hVap-hLiq) else 0)
    "Qulality at inlet";
  xOutDes = smooth(1, if hTPSH<hVap then (hTPSH-hLiq)/(hVap-hLiq) else 1)
    "Qulality at inlet";

  // Calculation of the void fraction at total vaprosiation
  //
  voiFraInt = voidFraction(
    dLiq=dLiq,dVap=dVap,xInl=xInlDes,xOut=xOutDes,sliFra=sliFra)
    "Total mean void fraction";

  // Calculation of the void fraction's partial derivatives
  //
  dvoiFradp = (voidFraction(
    dLiq=dLiq+ddLiqdp*1,
    dVap=dVap+ddVapdp*1,
    xInl=smooth(1, if hSCTP>hLiq then (hSCTP-hLiq-dhLiqdp*1)/(hVap +
      dhVapdp*1-hLiq-dhLiqdp*1) else xInlDes),
    xOut=smooth(1, if hTPSH<hVap then (hTPSH-hLiq-dhLiqdp*1)/(hVap +
      dhVapdp*1-hLiq-dhLiqdp*1) else xOutDes),
    sliFra=sliFra) -
              voidFraction(
    dLiq=dLiq-ddLiqdp*1,
    dVap=dVap-ddVapdp*1,
    xInl=smooth(1, if hSCTP>hLiq then (hSCTP-hLiq+dhLiqdp*1)/(hVap -
      dhVapdp*1-hLiq+dhLiqdp*1) else xInlDes),
    xOut=smooth(1, if hTPSH<hVap then (hTPSH-hLiq+dhLiqdp*1)/(hVap -
      dhVapdp*1-hLiq+
      dhLiqdp*1) else xOutDes),
    sliFra=sliFra))/(2)
    "Numerical derivative of voidFraInt wrt. pressure - dp = 2 Pa";

  dvoiFradhInl = smooth(1, if hSCTP>hLiq then
    voidFraction(dLiq=dLiq,dVap=dVap,xInl=xInlDes,xOut=xOutDes,sliFra=sliFra) -
    voidFraction(dLiq=dLiq,dVap=dVap,xInl=(hSCTP-1-hLiq)/(hVap-hLiq),xOut=xOutDes,
    sliFra=sliFra) else 0)
    "Numarical derivative of voidFraInt wrt. specific enthalpy at inlet - dh = 1J";

  dvoiFradhOut = smooth(1, if hTPSH<hVap then
    voidFraction(dLiq=dLiq,dVap=dVap,xInl=xInlDes,xOut=(hTPSH+1-hLiq)/(hVap-hLiq),
    sliFra=sliFra) - voidFraction(dLiq=dLiq,dVap=dVap,xInl=xInlDes,
    xOut=xOutDes,sliFra=sliFra) else 0)
    "Numarical derivative of voidFraInt wrt. specific enthalpy at outlet - dh = 1J";

  voiFraInt_der = dvoiFradp*der(p) + dvoiFradhInl*der(hSCTP) +
    dvoiFradhOut*der(hTPSH)
    "Derivative of voidFraInt wrt. time";

  // Calculation of void fraction and its total derivative used for output
  //
  der(voiFra) = voiFra_der "Integrate derivative of void fraction";

  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */
     voiFra_der = -voiFra/tauVoiFra "Convergence of mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.SCTP then
     /* Supercooled and two-phase*/
     voiFra_der = dvoiFradp*der(p) + dvoiFradhOut*der(hTPSH) -
       (voiFra-voiFraInt)/tauVoiFra
       "Mean void fraction is not in equilibrium with total mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.SCTPSH then
     /* Supercooled and two-phase and superheated*/
     voiFra_der = dvoiFradp*der(p) - (voiFra-voiFraInt)/tauVoiFra
       "Mean void fraction is in equilibrium with total mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.TPSH then
     /* Two-phase and Superheated*/
     voiFra_der = dvoiFradp*der(p) + dvoiFradhInl*der(hSCTP) -
       (voiFra-voiFraInt)/tauVoiFra
       "Mean void fraction is not in equilibrium with total mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.SH then
     /* Superheated*/
     voiFra_der = dvoiFradp*der(p) - (voiFra-voiFraInt)/tauVoiFra
       "Mean void fraction is in equilibrium with total mean void fraction";
  else
    /* Two-phase */
    voiFra_der = dvoiFradp*der(p) + dvoiFradhInl*der(hSCTP) +
      dvoiFradhOut*der(hTPSH) - (voiFra-voiFraInt)/tauVoiFra
      "Mean void fraction is not in equilibrium with total mean void fraction";
  end if;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 11, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"));
end Sangi2015;
