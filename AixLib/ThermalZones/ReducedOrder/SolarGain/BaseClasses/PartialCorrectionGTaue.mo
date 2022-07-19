within AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses;
partial model PartialCorrectionGTaue
  "Partial model for correction of the solar gain factor and for the
  translucence"
  parameter Integer n(min = 1) "Number of windows"
    annotation(dialog(group="window"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UWin
    "Thermal transmission coefficient of whole window"
    annotation (dialog(group="window"));
  parameter Modelica.Units.SI.Angle xi(displayUnit="degree") = 0
    "Elevation angle";
  parameter Modelica.Units.SI.Angle[n] til(displayUnit="degree")
    "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for roof"
    annotation (dialog(group="window"));

  Modelica.Blocks.Interfaces.RealOutput[n] corG_Dir(
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Transmission coefficient correction factor for direct radiation"
    annotation (Placement(transformation(extent={{80,-30},{100,-10}}),
    iconTransformation(extent={{80,-30},{100,-10}})));
  Modelica.Blocks.Interfaces.RealOutput[n] corG_DifCle(
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Transmission coefficient correction factor for diffuse radiation while
     clear sky"
    annotation (Placement(transformation(extent={{80,-50},{100,-30}}),
    iconTransformation(extent={{80,-50},{100,-30}})));
  Modelica.Blocks.Interfaces.RealOutput[n] corG_DifCov(
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Transmission coefficient correction factor for diffuse radiation while
     covered sky"
    annotation (Placement(transformation(extent={{80,-70},{100,-50}}),
    iconTransformation(extent={{80,-70},{100,-50}})));
  Modelica.Blocks.Interfaces.RealOutput[n] corG_Gro(
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Transmission coefficient correction factor for ground reflection radiation"
    annotation (Placement(transformation(extent={{80,-90},{100,-70}}),
    iconTransformation(extent={{80,-90},{100,-70}})));
  Modelica.Blocks.Interfaces.RealOutput[n] corTaue_Dir(
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for direct irradiation"
    annotation (Placement(transformation(extent={{80,10},{100,30}}),
    iconTransformation(extent={{80,10},{100,30}})));
  Modelica.Blocks.Interfaces.RealOutput[n] corTaue_DifCle(
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for diffuse irradiation during clear sky"
    annotation (Placement(transformation(extent={{80,30},{100,50}}),
    iconTransformation(extent={{80,30},{100,50}})));
  Modelica.Blocks.Interfaces.RealOutput[n] corTaue_DifCov(
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for diffuse irradiation during covered
     sky"
    annotation (Placement(transformation(extent={{80,50},{100,70}}),
    iconTransformation(extent={{80,50},{100,70}})));
  Modelica.Blocks.Interfaces.RealOutput[n] corTaue_Gro(
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for ground reflection radiation"
    annotation (Placement(transformation(extent={{80,70},{100,90}}),
    iconTransformation(extent={{80,70},{100,90}})));

  Modelica.Blocks.Interfaces.RealInput incAng[n](
    final quantity="Angle",
    final unit="rad",
    displayUnit="degree")
    "Incidence angles of the sun beam on a tilted surface"
    annotation (Placement(transformation(extent={{-120,-10},{-80,30}}),
    iconTransformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Interfaces.BooleanInput sunscreen[n]
    "True: sunscreen closed, false: sunscreen open"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-100,-30},{-80,-10}})));

protected
  parameter Real a0=0.918
    "Constant 0 to calculate reference transmission";
  parameter Real a1=2.21*10^(-4)
    "Constant 1 to calculate reference transmission";
  parameter Real a2=-2.75*10^(-5)
    "Constant 2 to calculate reference transmission";
  parameter Real a3=-3.82*10^(-7)
    "Constant 3 to calculate reference transmission";
  parameter Real a4=5.83*10^(-8)
    "Constant 4 to calculate reference transmission";
  parameter Real a5=-1.15*10^(-9)
    "Constant 5 to calculate reference transmission";
  parameter Real a6=4.74*10^(-12)
    "Constant 6 to calculate reference transmission";

  parameter Modelica.Units.SI.TransmissionCoefficient tau_1DifCov=tau_DifCov*
      tau_iDif "Degreee of transmission for single pane window";
  parameter Modelica.Units.SI.ReflectionCoefficient rho_T1DifCov=1 - (
      tau_DifCov) "Part of degree of transmission for single pane window related to
    tau_1DifCov";
  parameter Modelica.Units.SI.ReflectionCoefficient rho_11DifCov=rho_T1DifCov/(
      2 - (rho_T1DifCov)) "Part of degree of transmission for single pane window
    related to rho_T1_diff";
  parameter Modelica.Units.SI.ReflectionCoefficient rho_1DifCov=rho_11DifCov +
      (((1 - rho_11DifCov)*tau_iDif)^2*rho_11DifCov)/(1 - (rho_11DifCov*
      tau_iDif)^2) "Degree of reflection for single pane window";
  parameter Modelica.Units.SI.TransmissionCoefficient tau_DifCov=0.84 "Energetic degree of transmission for diffuse radiation for uniformly
     overcast sky";

  parameter Modelica.Units.SI.TransmissionCoefficient tau_iDif=0.903
    "Pure degree of transmission for diffuse radiation";
  Modelica.Units.SI.Angle[n] gamma_x
    "Calculation factor for ground reflection radiation";
  Modelica.Units.SI.TransmissionCoefficient[n] tau_Dir
    "Energetic degree of transmission for direct radiation";
  Modelica.Units.SI.TransmissionCoefficient[n] taui_Dir
    "Pure degree of transmission for direct radiation";
  Modelica.Units.SI.TransmissionCoefficient[n] tau_1Dir
    "Pure degree of transmission for single pane window";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_T1Dir
    "Part of degree of transmission for single pane window related to tau_1Dir";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_11Dir
    "Part of degree of transmission for single pane window related to T1_Dir";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_1Dir
    "Degree of reflection for single pane window";
  Modelica.Units.SI.Emissivity[n] a_1Dir
    "Degree of absorption for single pane window";

  Modelica.Units.SI.TransmissionCoefficient[n] tau_DifCle
    "Energetic degree of transmission for diffuse radiation for clear sky";
  Modelica.Units.SI.TransmissionCoefficient[n] tau_1DifCle
    "Degreee of transmission for single pane window";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_T1DifCle "Part of degree of transmission for single pane window related to
    tau_1DifCle";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_11DifCle "Part of degree of transmission for single pane window related to
     T1_DifCle";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_1DifCle
    "Degree of reflection for single pane window";
  Modelica.Units.SI.Emissivity[n] a_1DifCle
    "Degree of absorption for single pane window";
  Modelica.Units.SI.TransmissionCoefficient[n] tau_Gro
    "Energetic degree of transmission for ground reflection radiation";
  Modelica.Units.SI.TransmissionCoefficient[n] tau_1Gro
    "Degreee of transmission for single pane window";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_T1Gro
    "Part of degree of transmission for single pane window related to tau_1Gro";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_11Gro
    "Part of degree of transmission for single pane window related to T1_gr";
  Modelica.Units.SI.ReflectionCoefficient[n] rho_1Gro
    "Degree of reflection for single pane window";
  Modelica.Units.SI.Emissivity[n] a_1Gro
    "Degree of absorption for single pane window";
equation

  for i in 1:n loop
  //Calculating variables for direct irradiation
  taui_Dir[i]= 0.907^(1/sqrt(1-(Modelica.Math.sin(incAng[i])/1.515)^2));
    if (((((a6*(incAng[i]) + a5)*Modelica.Units.Conversions.to_deg(incAng[i])
         + a4)*Modelica.Units.Conversions.to_deg(incAng[i]) + a3)*
        Modelica.Units.Conversions.to_deg(incAng[i]) + a2)*
        Modelica.Units.Conversions.to_deg(incAng[i]) + a1)*
        Modelica.Units.Conversions.to_deg(incAng[i]) + a0 < 0 then
  tau_Dir[i]=0;
  else
  tau_Dir[i]=(((((a6*Modelica.Units.Conversions.to_deg(incAng[i]) + a5)*
        Modelica.Units.Conversions.to_deg(incAng[i]) + a4)*
        Modelica.Units.Conversions.to_deg(incAng[i]) + a3)*
        Modelica.Units.Conversions.to_deg(incAng[i]) + a2)*
        Modelica.Units.Conversions.to_deg(incAng[i]) + a1)*
        Modelica.Units.Conversions.to_deg(incAng[i]) + a0;
  end if;
  tau_1Dir[i]= tau_Dir[i]*taui_Dir[i];
  rho_T1Dir[i]= 1-tau_Dir[i];
  rho_11Dir[i]= rho_T1Dir[i]/(2-rho_T1Dir[i]);
  rho_1Dir[i]=rho_11Dir[i]+(((1-rho_11Dir[i])*taui_Dir[i])^2*rho_11Dir[i])/
  (1-(rho_11Dir[i]*taui_Dir[i])^2);
  a_1Dir[i]= 1-tau_1Dir[i]-rho_1Dir[i];
  //Calculating variables for diffuse, clear irradiation
    if 0.83 - 0.075*(Modelica.Units.Conversions.to_deg(
        AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
        til[i]))/70 - 1)^2 + (0.052 + 0.033*(Modelica.Units.Conversions.to_deg(
        AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
        til[i]))/90 - 1)^2)*(Modelica.Math.cos(incAng[i]) + 0.15)^2 < 0 then
  tau_DifCle[i] = 0;
  else
  tau_DifCle[i]=0.83 - 0.075*(Modelica.Units.Conversions.to_deg(
        AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
        til[i]))/70 - 1)^2 + (0.052 + 0.033*(Modelica.Units.Conversions.to_deg(
        AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
        til[i]))/90 - 1)^2)*(Modelica.Math.cos(incAng[i]) + 0.15)^2;
  end if;
  tau_1DifCle[i]= tau_DifCle[i]*tau_iDif;
  rho_T1DifCle[i]= 1-tau_DifCle[i];
  rho_11DifCle[i]= rho_T1DifCle[i]/(2-rho_T1DifCle[i]);
  rho_1DifCle[i]=rho_11DifCle[i]+(((1-rho_11DifCle[i])*tau_iDif)^2
  *rho_11DifCle[i])/(1-(rho_11DifCle[i]*tau_iDif)^2);
  a_1DifCle[i]=1-tau_1DifCle[i]-rho_1DifCle[i];
  //Calculating variables for ground reflection radiation
  if (xi+
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i]))<0 then
    gamma_x[i]=0;
  elseif (xi+
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i]))>Modelica.Constants.pi/2 then
    gamma_x[i]=Modelica.Constants.pi/2;
  else
    gamma_x[i]=xi+
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i]);
  end if;
  tau_Gro[i] = 0.84*Modelica.Math.sin(gamma_x[i])^(0.88*(1-0.5*abs(
    Modelica.Math.sin(2*gamma_x[i]))));
  tau_1Gro[i]=tau_Gro[i]*tau_iDif;
  rho_T1Gro[i]= 1-tau_Gro[i];
  rho_11Gro[i]= rho_T1Gro[i]/(2-rho_T1Gro[i]);
  rho_1Gro[i]=rho_11Gro[i]+(((1-rho_11Gro[i])*tau_iDif)^2*
  rho_11Gro[i])/(1-(rho_11Gro[i]*tau_iDif)^2);
  a_1Gro[i]=1-tau_1Gro[i]-rho_1Gro[i];
  end for;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
  -100,-100},{100,100}})),Icon(coordinateSystem(
  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
  Rectangle(
  extent={{-80,80},{80,-80}},
  lineColor={0,0,0},
  fillColor={215,215,215},
  fillPattern=FillPattern.Solid), Text(
  extent={{-52,24},{62,-16}},
  lineColor={0,0,0},
  textString="%name")}),
  Documentation(info="<html><p>
  Partial model for correction factors for transmitted solar radiation
  through a transparent element.
</p>
<p>
  <a href=
  \"vdi6007.BaseClasses.CorrrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a>
  uses this model to calculate the correction values for double pane
  windows. This model can be used as a partial model to calculate the
  correction values for single pane windows and triple pane windows
  according to the VDI Guideline &lt;\\p&gt;
</p>
<h4>
  References
</h4>
<p>
  VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  modelling of solar radiation.
</p>
<ul>
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
      <i>May 25, 2016</i> by Stanley Risch:
    </p>
    <p>
      Added the correction of the translucence factor according to
      VDI6007 Part 3
    </p>
  </li>
</ul>
</html>"));
end PartialCorrectionGTaue;
