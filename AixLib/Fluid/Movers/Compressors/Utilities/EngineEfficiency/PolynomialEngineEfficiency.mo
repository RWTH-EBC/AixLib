within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency;
model PolynomialEngineEfficiency
  "Model describing engine efficiency based on polynomial approach"
  extends PartialEngineEfficiency;

  // Definition of parameters describing polynomial approaches in general
  //
  parameter Choices.EnginePolynomialModels
    polyMod=Choices.EnginePolynomialModels.t
    "Chose predefined polynomial model for flow coefficient"
    annotation (Dialog(group="Modelling approach"));
  parameter Real a[:]
    "Multiplication factors for each summand"
    annotation(Dialog(group="Modelling approach"));
  parameter Real b[:]
    "Exponents for each summand"
    annotation(Dialog(group="Modelling approach"));
  parameter Integer nT = size(a,1)
    "Number of terms used for the calculation procedure"
    annotation(Dialog(group="Modelling approach",
                      enable=false));

  // Definition of parameters describing specific approaches
  //


  // Definition of coefficients
  //
  Real P[nT]
    "Array that contains all coefficients used for the calculation procedure";


equation

  // Calculation of coefficients
  //
  if (polyMod == Choices.EnginePolynomialModels.t) then
    /*Polynomial approach presented by Shanwei et al. (2005):
      C_D = a1*AVal + a2*rho_inlet + a3*rho_outlet + a4*T_subcooling +
      a5*dCle + a6*(pInl-pOut)
      
      Caution with units - In the following, none S.I units are presented:
        Pressure:       in kPa
        Temperature:    in °C
        Heat capacity:  in kJ/(kg*K)
        Heat of vap.:   in kJ/kg
    */

  else
    assert(false, "Invalid choice of polynomial approach");
  end if;

  // Calculationg of flow coefficient
  //
  etaEng = sum(a[i]*P[i]^b[i] for i in 1:nT)
    "Calculation procedure of general polynomial";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end PolynomialEngineEfficiency;
