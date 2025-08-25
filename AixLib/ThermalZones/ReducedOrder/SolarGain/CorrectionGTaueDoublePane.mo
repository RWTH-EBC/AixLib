within AixLib.ThermalZones.ReducedOrder.SolarGain;
model CorrectionGTaueDoublePane "Correction of the solar gain factor and the
  translucence factor according to VDI6007 Part 3"
  extends AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses.PartialCorrectionGTaue;
  // Parameters for the transmission correction factor based on VDI 6007 Part 3
  // a0 to a6 are experimental constants VDI 6007 Part 3 page 20

  //Calculating the correction factor for direct solar radiation
  Modelica.Units.SI.ReflectionCoefficient[n] xn2_Dir
    "Calculation factor to simplify equations";
  Modelica.Units.SI.TransmissionCoefficient[n] tau_2Dir
    "Energetic degree of transmission for second pane";
  Real[n] q21_Dir
    "Coefficient of heat transfer for exterior pane of double pane window";
  Real[n] q22_Dir
    "Coefficient of heat transfer for interior pane of double pane window";
  Real[n] qSek2_Dir
    "Overall coefficient of heat transfer for double pane window";

  //diffuse clear
  Modelica.Units.SI.ReflectionCoefficient[n] xn2_DifCle
    "Calculation factor to simplify equations";
  Modelica.Units.SI.TransmissionCoefficient[n] tau_2DifCle
    "Energetic degree of transmission for second pane";
  Real[n] q21_DifCle
    "Coefficient of heat transfer for exterior pane of double pane window";
  Real[n] q22_DifCle
    "Coefficient of heat transfer for interior pane of double pane window";
  Real[n] qSek2_DifCle
    "Overall coefficient of heat transfer for double pane window";

  //ground
  Modelica.Units.SI.ReflectionCoefficient[n] xn2_Gro
    "Calculation factor to simplify equations";
  Modelica.Units.SI.TransmissionCoefficient[n] tau_2Gro
    "Energetic degree of transmission for second pane";
  Real[n] q21_Gro
    "Coefficient of heat transfer for exterior pane of double pane window";
  Real[n] q22_Gro
    "Coefficient of heat transfer for interior pane of double pane window";
  Real[n] qSek2_Gro
    "Overall coefficient of heat transfer for double pane window";
protected
  parameter Modelica.Units.SI.TransmissionCoefficient g_Dir0=taue_Dir0 + q210
       + q220 "Reference vertical parallel transmission coefficient for direct radiation
    for double pane window";
  parameter Modelica.Units.SI.TransmissionCoefficient q210=(1 - rho_1Dir0 -
      0.907*a0)*(1 + (0.907*a0*rho_1Dir0/(1 - rho_1Dir0^2)))*UWin/25 "Calculation factor for g_Dir0. Calculated like q21 but for vertical
    incidence";
  parameter Modelica.Units.SI.TransmissionCoefficient q220=(1 - rho_1Dir0 -
      0.907*a0)*(0.907*a0/(1 - rho_1Dir0^2))*(1 - UWin/7.7) "Calculation factor for g_Dir0. Calculated like q21 but for vertical
    incidence";

  parameter Modelica.Units.SI.TransmissionCoefficient taue_Dir0=(a0*0.907)^2/(1
       - rho_1Dir0^2)
    "Reference vertical parallel transmission coefficient for direct radiation";
  parameter Modelica.Units.SI.ReflectionCoefficient rho_1Dir0=rho_11Dir0 + (((1
       - rho_11Dir0)*0.907)^2*rho_11Dir0)/(1 - (rho_11Dir0*0.907)^2) "Calculation factor for g_Dir0. Calculated like rho_1_dir but for vertical
    incidence";
  parameter Modelica.Units.SI.ReflectionCoefficient rho_11Dir0=(1 - a0)/(2 - (1
       - a0)) "Calculation factor for g_Dir0. Calculated like rho_11_dir but for vertical
  incidence";
  parameter Modelica.Units.SI.ReflectionCoefficient xn2_DifCov=1 - rho_1DifCov^
      2 "Calculation factor to simplify equations";
  parameter Modelica.Units.SI.TransmissionCoefficient tau_2DifCov=(tau_1DifCov^
      2)/xn2_DifCov "Energetic degree of transmission for second pane";
  parameter Modelica.Units.SI.Emissivity a_1DifCov=1 - tau_1DifCov -
      rho_1DifCov "Degree of absorption for single pane window";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer q21_DifCov=a_1DifCov*(1
       + (tau_1DifCov*rho_1DifCov/xn2_DifCov))*UWin/25
    "Coefficient of heat transfer for exterior pane of double pane window";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer q22_DifCov=a_1DifCov*(
      tau_1DifCov/xn2_DifCov)*(1 - (UWin/7.7))
    "Coefficient of heat transfer for interior pane of double pane window";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer qSek2_DifCov=q21_DifCov
       + q22_DifCov
    "Overall coefficient of heat transfer for double pane window";

equation
  for i in 1:n loop
    //Calculating variables for the overall degree of energy passage for
    //direct irradiation
    if (1-rho_1Dir[i]^2)==0 then
      xn2_Dir[i]=10^(-20);
    else
      xn2_Dir[i]= 1-rho_1Dir[i]^2;
    end if;
    q21_Dir[i]=a_1Dir[i]*(1+(tau_1Dir[i]*rho_1Dir[i]/xn2_Dir[i]))*UWin/25;
    q22_Dir[i]= a_1Dir[i]*(tau_1Dir[i]/xn2_Dir[i])*(1-(UWin/7.7));
    qSek2_Dir[i]=q21_Dir[i]+q22_Dir[i];
    tau_2Dir[i]= tau_1Dir[i]^2/xn2_Dir[i];

    //Calculating variables for diffuse irradiation at clear sky
    if (1-rho_1DifCle[i]^2)==0 then
      xn2_DifCle[i]=10^(-20);
    else
      xn2_DifCle[i]= 1-rho_1DifCle[i]^2;
    end if;
    q21_DifCle[i]=a_1DifCle[i]*(1+(tau_1DifCle[i]*rho_1DifCle[i]/
      xn2_DifCle[i]))*UWin/25;
    q22_DifCle[i]= a_1DifCle[i]*(tau_1DifCle[i]/xn2_DifCle[i])*(1-(UWin/7.7));
    qSek2_DifCle[i]=q21_DifCle[i]+q22_DifCle[i];
    tau_2DifCle[i]= tau_1DifCle[i]^2/xn2_DifCle[i];

    //Calculating variables for the overall degree of energy passage for ground
    //reflection radiation
    if (1-rho_1Gro[i]^2)==0 then
      xn2_Gro[i]=10^(-20);
    else
      xn2_Gro[i]= 1-rho_1Gro[i]^2;
    end if;
    q21_Gro[i]=a_1Gro[i]*(1+(tau_1Gro[i]*rho_1Gro[i]/xn2_Gro[i]))*UWin/25;
    q22_Gro[i]= a_1Gro[i]*(tau_1Gro[i]/xn2_Gro[i])*(1-(UWin/7.7));
    qSek2_Gro[i]=q21_Gro[i]+q22_Gro[i];
    tau_2Gro[i]= tau_1Gro[i]^2/xn2_Gro[i];

    //Calculating correction values
    corG_DifCov[i]=(tau_2DifCov+qSek2_DifCov)/g_Dir0;
    corTaue_DifCov[i]=tau_2DifCov/taue_Dir0;
     if sunscreen[i] then
      corTaue_DifCle[i]=corTaue_DifCov[i];
      corTaue_Gro[i]=corTaue_DifCov[i];
      corTaue_Dir[i]=corTaue_DifCov[i];
      corG_Dir[i]=corG_DifCov[i];
      corG_DifCle[i]=corG_DifCov[i];
      corG_Gro[i]=corG_DifCov[i];
     else
      corTaue_DifCle[i]=tau_2DifCle[i]/taue_Dir0;
      corTaue_Gro[i]=tau_2Gro[i]/taue_Dir0;
      corTaue_Dir[i]=tau_2Dir[i]/taue_Dir0;
      corG_Dir[i]= (tau_2Dir[i]+qSek2_Dir[i])/g_Dir0;
      corG_DifCle[i]= (tau_2DifCle[i]+qSek2_DifCle[i])/g_Dir0;
      corG_Gro[i]= (tau_2Gro[i]+qSek2_Gro[i])/g_Dir0;
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
  Documentation(info="<html><p>
  <a href=
  \"vdi6007.BaseClasses.CorrrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a>
  computes transmission correction factors for the g-factor and the
  translucence. Transmission properties of transparent elements are in
  general dependent on the solar incidence angle. To take this
  dependency into account, correction factors can multiplied with the
  solar radiation. These factors should not be mistaken as calculation
  of solar radiation on tilted surfaces, calculation of g-value or
  consideration of sunblinds, it is an additional step. The implemented
  calculations are defined in the German Guideline VDI 6007 Part 3
  (VDI, 2015). The given model is only valid for double pane windows.
  The guideline describes also calculations for single pane and triple
  pane windows.
</p>
<h4>
  References
</h4>
<p>
  VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  modelling of solar radiation.
</p>
</html>",
  revisions="<html><ul>
  <li>
    <p>
      <i>February 24, 2014</i> by Reza Tavakoli:
    </p>
    <p>
      Implemented.
    </p>
  </li>
  <li>
    <p>
      <i>September 12, 2015</i> by Moritz Lauster:
    </p>
    <p>
      Adapted to Annex 60 requirements.
    </p>
  </li>
  <li>
    <p>
      <i>May 25, 2016</i> by Stanley Risch:
    </p>
    <p>
      Added the correction of the translucence factor according to
      VDI6007 Part 3
    </p>
  </li>
</ul>
</html>"));
end CorrectionGTaueDoublePane;
