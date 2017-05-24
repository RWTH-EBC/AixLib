within AixLib.ThermalZones.ReducedOrder.SolarGain;
model CorrectionGTaueDoublePane "Correction of the solar gain factor and the 
  transluance factor according to VDI6007 Part 3"
  extends BaseClasses.PartialCorrectionGTaue;
  import Modelica.SIunits.Conversions.to_deg;
  // Parameters for the transmission correction factor based on VDI 6007 Part 3
  // A0 to A6 are experimental constants VDI 6007 Part 3 page 20

  //Calculating the correction factor for direct solar radiation
  Modelica.SIunits.ReflectionCoefficient[n] XN2_Dir
    "Calculation factor to simplify equations";
  Modelica.SIunits.TransmissionCoefficient[n] tau_2Dir
    "Energetic dregree of transmission for second pane";
  Real[n] Q21_Dir
    "Coefficient of heat transfer for exterior pane of double pane window";
  Real[n] Q22_Dir
    "Coefficient of heat transfer for interior pane of double pane window";
  Real[n] Qsek2_Dir
    "Overall coefficient of heat transfer for double pane window";

  //diffuse clear
  Modelica.SIunits.ReflectionCoefficient[n] XN2_DifCle
    "Calculation factor to simplify equations";
  Modelica.SIunits.TransmissionCoefficient[n] tau_2DifCle
    "Energetic dregree of transmission for second pane";
  Real[n] Q21_DifCle
    "Coefficient of heat transfer for exterior pane of double pane window";
  Real[n] Q22_DifCle
    "Coefficient of heat transfer for interior pane of double pane window";
  Real[n] Qsek2_DifCle
    "Overall coefficient of heat transfer for double pane window";

  //ground
  Modelica.SIunits.ReflectionCoefficient[n] XN2_Gro
    "Calculation factor to simplify equations";
  Modelica.SIunits.TransmissionCoefficient[n] tau_2Gro
    "Energetic dregree of transmission for second pane";
  Real[n] Q21_Gro
    "Coefficient of heat transfer for exterior pane of double pane window";
  Real[n] Q22_Gro
    "Coefficient of heat transfer for interior pane of double pane window";
  Real[n] Qsek2_Gro
    "Overall coefficient of heat transfer for double pane window";
protected
  parameter Modelica.SIunits.TransmissionCoefficient g_Dir0=taue_Dir0+Q210+Q220
  "Reference vertical parallel transmission coefficient for direct radiation
    for double pane window";
  parameter Modelica.SIunits.TransmissionCoefficient Q210=
    (1-rho_1Dir0-0.907*A0)*(1+(0.907*A0*rho_1Dir0/(1-rho_1Dir0^2)))*UWin/25;
  parameter Modelica.SIunits.TransmissionCoefficient Q220=
    (1-rho_1Dir0-0.907*A0)*(0.907*A0/(1-rho_1Dir0^2))*(1-UWin/7.7);
  parameter Modelica.SIunits.TransmissionCoefficient taue_Dir0=
    (A0*0.907)^2/(1-rho_1Dir0^2)
    "Reference vertical parallel transmission coefficient for direct radiation";
  parameter Modelica.SIunits.ReflectionCoefficient rho_1Dir0=
    rho_11Dir0+(((1-rho_11Dir0)*0.907)^2*rho_11Dir0)/
    (1-(rho_11Dir0*0.907)^2);
  parameter Modelica.SIunits.ReflectionCoefficient rho_11Dir0=(1-A0)/(2-(1-A0));
  parameter Modelica.SIunits.ReflectionCoefficient XN2_DifCov=1-rho_1DifCov^2
    "Calculation factor to simplify equations";
  parameter Modelica.SIunits.TransmissionCoefficient tau_2DifCov=
    (tau_1DifCov^2)/XN2_DifCov
    "Energetic dregree of transmission for second pane";
  parameter Modelica.SIunits.Emissivity a_1DifCov=1-tau_1DifCov-rho_1DifCov
    "Degree of absorption for single pane window";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Q21_DifCov=
    a_1DifCov*(1+(tau_1DifCov*rho_1DifCov/XN2_DifCov))*UWin/25
    "Coefficient of heat transfer for exterior pane of double pane window";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Q22_DifCov=
    a_1DifCov*(tau_1DifCov/XN2_DifCov)*(1-(UWin/7.7))
    "Coefficient of heat transfer for interior pane of double pane window";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Qsek2_DifCov=
    Q21_DifCov+Q22_DifCov
    "Overall coefficient of heat transfer for double pane window";

equation
  for i in 1:n loop
    //Calculating variables for the overall degree of energy passage for
    //direct irradiation
    if (1-rho_1Dir[i]^2)==0 then
      XN2_Dir[i]=10^(-20);
    else
      XN2_Dir[i]= 1-rho_1Dir[i]^2;
    end if;
    Q21_Dir[i]=a_1Dir[i]*(1+(tau_1Dir[i]*rho_1Dir[i]/XN2_Dir[i]))*UWin/25;
    Q22_Dir[i]= a_1Dir[i]*(tau_1Dir[i]/XN2_Dir[i])*(1-(UWin/7.7));
    Qsek2_Dir[i]=Q21_Dir[i]+Q22_Dir[i];
    tau_2Dir[i]= tau_1Dir[i]^2/XN2_Dir[i];

    //Calculating variables for diffuse irradiation at clear sky
    if (1-rho_1DifCle[i]^2)==0 then
      XN2_DifCle[i]=10^(-20);
    else
      XN2_DifCle[i]= 1-rho_1DifCle[i]^2;
    end if;
    Q21_DifCle[i]=a_1DifCle[i]*(1+(tau_1DifCle[i]*rho_1DifCle[i]/
      XN2_DifCle[i]))*UWin/25;
    Q22_DifCle[i]= a_1DifCle[i]*(tau_1DifCle[i]/XN2_DifCle[i])*(1-(UWin/7.7));
    Qsek2_DifCle[i]=Q21_DifCle[i]+Q22_DifCle[i];
    tau_2DifCle[i]= tau_1DifCle[i]^2/XN2_DifCle[i];

    //Calculating variables for the overall degree of energy passage for ground
    //reflexion radiation
    if (1-rho_1Gro[i]^2)==0 then
      XN2_Gro[i]=10^(-20);
    else
      XN2_Gro[i]= 1-rho_1Gro[i]^2;
    end if;
    Q21_Gro[i]=a_1Gro[i]*(1+(tau_1Gro[i]*rho_1Gro[i]/XN2_Gro[i]))*UWin/25;
    Q22_Gro[i]= a_1Gro[i]*(tau_1Gro[i]/XN2_Gro[i])*(1-(UWin/7.7));
    Qsek2_Gro[i]=Q21_Gro[i]+Q22_Gro[i];
    tau_2Gro[i]= tau_1Gro[i]^2/XN2_Gro[i];

    //Calculating correction values
    CorG_DifCov[i]=(tau_2DifCov+Qsek2_DifCov)/g_Dir0;
    CorTaue_DifCov[i]=tau_2DifCov/taue_Dir0;
     if sunscreen[i] then
      CorTaue_DifCle[i]=CorTaue_DifCov[i];
      CorTaue_Gro[i]=CorTaue_DifCov[i];
      CorTaue_Dir[i]=CorTaue_DifCov[i];
      CorG_Dir[i]=CorG_DifCov[i];
      CorG_DifCle[i]=CorG_DifCov[i];
      CorG_Gro[i]=CorG_DifCov[i];
     else
      CorTaue_DifCle[i]=tau_2DifCle[i]/taue_Dir0;
      CorTaue_Gro[i]=tau_2Gro[i]/taue_Dir0;
      CorTaue_Dir[i]=tau_2Dir[i]/taue_Dir0;
      CorG_Dir[i]= (tau_2Dir[i]+Qsek2_Dir[i])/g_Dir0;
      CorG_DifCle[i]= (tau_2DifCle[i]+Qsek2_DifCle[i])/g_Dir0;
      CorG_Gro[i]= (tau_2Gro[i]+Qsek2_Gro[i])/g_Dir0;
     end if;
  end for;

  annotation (defaultComponentName="CorGTaue",
  Diagram(coordinateSystem(
  preserveAspectRatio=false,
  extent={{-100,-100},{100,100}},
  grid={2,2})),
  Icon(coordinateSystem(
  preserveAspectRatio=false,
  extent={{-100,-100},{100,100}},
  grid={2,2})),
  Documentation(info="<html>
  <p><a href=\"vdi6007.BaseClasses.CorrrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a> 
  computes transmission correction factors for the g-factor and the transluence. 
  Transmission properties of transparent
  elements are in general dependent on the solar incidence angle. To take this
  dependency into account, correction factors can multiplied with the solar
  radiation. These factors should not be mistaken as calculation of solar
  radiation on tilted surfaces, calculation of g-value or consideration of
  sunblinds, it is an additional step. The implemented calculations are
  defined in the German Guideline VDI 6007 Part 3 (VDI, 2015). The given model
  is only valid for double pane windows. The guideline describes also
  calculations for single pane and triple pane windows.</p>
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  modelling of solar radiation.</p>
  </html>",
  revisions="<html>
<p><i>February 24, 2014</i> by Reza Tavakoli: </p>
<p>Implemented. </p>
<p><i>September 12, 2015 </i>by Moritz Lauster: </p>
<p>Adapted to Annex 60 requirements. </p>
<p><i>May 25, 2016 </i>by Stanley Risch:</p>
<p>Added the correction of the transluence factor according to VDI6007 Part 3
</p>
</html>"));
end CorrectionGTaueDoublePane;
