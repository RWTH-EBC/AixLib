within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
model CorG_ASHRAE140
  "Correction of the solar gain factor according to ASHRAE 140"
  extends PartialCorG;

  import Modelica.SIunits.Conversions.to_deg;
  import Modelica.Math.asin;
  import Modelica.Math.sin;
  import Modelica.Math.tan;
  import Modelica.Math.cos;

  parameter Real INDRG=1.526; // Index of refraction of Glass, in this case INDRG= 1.526
  parameter Real p = 2; // number of panes of glass, in this case p = 2
  parameter Real TH = 3.175; // Thickness of glass, in this case TH = 3.175 mm
  parameter Real K = 0.0196; // Extintion coefficient, in this case K = 0.0196/mm

  Real[n] AOI; // Angle of incidence
  Real[n] AOR;  // Angle of refraction
  Real[n] RPERP;  // Perpendicular reflectance(component of polarization)
  Real[n] RPAR; // Parallel reflectance(component of polarization)
  Real[n] R;  // Reflectance
  Real[n] Trn; // Transmittance due to reflectance losses(transmittance if there were just reflectance losses and no absorptance losses)
  Real[n] Tabs; // Transmittance due to absorptance losses(transmittance if there were just absorptance losses and no reflectance losses)
  Real[n] L;  // Path length
  Real[n] T; // Total transmittance Tr*Tabs

equation
  for i in 1:n loop
    // Snell's Law
    AOI[i] = to_deg(SR_input[i].AOI); // in rad

    AOR[i] = asin(sin((AOI[i])/INDRG)); //  Angle of refraction in deg

    //Fresnel Equations(Reflectance at 1 air to glass interface)
    RPERP[i]*(sin(AOR[i]+(AOI[i])))^2 = (sin(AOR[i]-(AOI[i])))^2;
    RPAR[i]*(tan(AOR[i]+(AOI[i])))^2 = (tan(AOR[i]- (AOI[i])))^2;
    R[i] = (RPERP[i]+RPAR[i])/2;

    //Fresnel Equations(Transmittance due to reflectance with several panes)
    Trn[i] = 0.5*(((1-RPERP[i])/(1+(2*p-1)*RPERP[i]))+((1-RPAR[i])/(1+(2*p-1)*RPAR[i])));

   //Bouguer’s Law(Transmittance due to absorptance)
    L[i] = TH / (cos(AOR[i]));
    Tabs[i] = exp(p*(-L[i]*K));
    T[i] = Trn[i]*Tabs[i];

    //Solar radiation transmitted through window
    solarRadWinTrans[i]= SR_input[i].I*T[i];

  end for;


end CorG_ASHRAE140;
