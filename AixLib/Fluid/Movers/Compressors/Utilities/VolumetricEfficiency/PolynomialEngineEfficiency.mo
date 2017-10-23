within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency;
model PolynomialEngineEfficiency
  "Model describing engine efficiency based on polynomial approach"
  extends PartialVolumetricEfficiency;

  // Definition of parameters describing polynomial approaches in general
  //
  parameter Choices.VolumetricPolynomialModels
    polyMod=Choices.VolumetricPolynomialModels.Karlsson2007
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

protected
  Medium.SaturationProperties satInl
    "Saturation properties at valve's inlet conditions";
  Medium.SaturationProperties satOut
    "Saturation properties at valve's outlet conditions";

equation
  // Calculation of protected variables
  //
  satInl = Medium.setSat_p(Medium.pressure(staInl))
    "Saturation properties at valve's inlet conditions";
  satOut = Medium.setSat_p(Medium.pressure(staOut))
    "Saturation properties at valve's outlet conditions";

  // Calculation of coefficients
  //
  if (polyMod == Choices.VolumetricPolynomialModels.Karlsson2007) then
    /*Polynomial approach presented by Karlsson (2007):
      lamH = a*TInl*piPre + b*piPre + c + d*TInl + e*rotSpe + f*rotSpe^2
      
      Caution with units - In the following, none S.I units are presented:
      Temperature:         in °C
    */
    P[1] = (Medium.temperature(staInl)-273.15)*piPre
      "Inlet temperature times pressure ratio";
    P[2] = piPre
      "Pressure ratio";
    P[3] = 1
      "Dummy value for usage of simple coefficcient";
    P[4] = (Medium.temperature(staInl)-273.15)
      "Inlet temperature";
    P[5] = rotSpe
      "Rotational speed";
    P[6] = rotSpe^2
      "Quadratic rotational speed";

  else
    assert(false, "Invalid choice of polynomial approach");
  end if;

  // Calculationg of flow coefficient
  //
  lamH = sum(a[i]*P[i]^b[i] for i in 1:nT)
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
