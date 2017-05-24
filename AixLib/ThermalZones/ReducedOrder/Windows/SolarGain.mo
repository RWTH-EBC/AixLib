within AixLib.ThermalZones.ReducedOrder.Windows;
package SolarGain
  "Package with models for solar gain corrections according to VDI 6007 Part 3"
  extends Modelica.Icons.VariantsPackage;

  model CorrectionGDoublePane
    "Double pane window solar correction"
    extends BaseClasses.PartialCorrectionG;
    import con = Modelica.SIunits.Conversions;

    // Parameters for the transmission correction factor based on VDI 6007 Part 3
    // A0 to A6 are experimental constants VDI 6007 Part 3 page 20
  protected
    parameter Real A0=0.918 "Constant 0 to calculate reference transmission";
    parameter Real A1=2.21*10^(-4)
      "Constant 1 to calculate reference transmission";
    parameter Real A2=-2.75*10^(-5)
      "Constant 2 to calculate reference transmission";
    parameter Real A3=-3.82*10^(-7)
      "Constant 3 to calculate reference transmission";
    parameter Real A4=5.83*10^(-8)
      "Constant 4 to calculate reference transmission";
    parameter Real A5=-1.15*10^(-9)
      "Constant 5 to calculate reference transmission";
    parameter Real A6=4.74*10^(-12)
      "Constant 6 to calculate reference transmission";
    parameter Modelica.SIunits.TransmissionCoefficient g_dir0=0.7537
      "Reference vertical parallel transmission coefficient for direct radiation
    for double pane window";
    parameter Modelica.SIunits.TransmissionCoefficient Ta_diff = 0.84
      "Energetic degree of transmission for diffuse radiation for uniformly
    overcast sky";
    parameter Modelica.SIunits.TransmissionCoefficient Tai_diff=0.903
      "Pure degree of transmission for diffuse radiation";
    parameter Modelica.SIunits.TransmissionCoefficient Ta1_diff= Ta_diff*Tai_diff
      "Degreee of transmission for single pane window";
    parameter Modelica.SIunits.ReflectionCoefficient rho_T1_diff=1-(Ta_diff)
      "Part of degree of transmission for single pane window related to Ta1_diff";
    parameter Modelica.SIunits.ReflectionCoefficient rho_11_diff=rho_T1_diff/
      (2-(rho_T1_diff))
      "Part of degree of transmission for single pane window
    related to rho_T1_diff";
    parameter Modelica.SIunits.ReflectionCoefficient rho_1_diff= rho_11_diff+
      (((1-rho_11_diff)*Tai_diff)^2*rho_11_diff)/(1-(rho_11_diff*Tai_diff)^2)
      "Degree of reflection for single pane window";
    parameter Modelica.SIunits.ReflectionCoefficient XN2_diff=1-rho_1_diff^2
      "Calculation factor to simplify equations";
    parameter Modelica.SIunits.TransmissionCoefficient Ta2_diff=(Ta1_diff^2)/
      XN2_diff "Energetic dregree of transmission for second pane";
    parameter Modelica.SIunits.Emissivity a1_diff=1-Ta1_diff-rho_1_diff
      "Degree of absorption for single pane window";
    parameter Modelica.SIunits.CoefficientOfHeatTransfer Q21_diff=
      a1_diff*(1+(Ta1_diff*rho_1_diff/XN2_diff))*UWin/25
      "Coefficient of heat transfer for exterior pane of double pane window";
    parameter Modelica.SIunits.CoefficientOfHeatTransfer Q22_diff=
      a1_diff*(Ta1_diff/XN2_diff)*(1-(UWin/7.7))
      "Coefficient of heat transfer for interior pane of double pane window";
    parameter Modelica.SIunits.CoefficientOfHeatTransfer Qsek2_diff=
      Q21_diff+Q22_diff
      "Overall coefficient of heat transfer for double pane window";
    parameter Modelica.SIunits.TransmissionCoefficient CorG_diff=
      (Ta2_diff+Qsek2_diff)/g_dir0
      "Transmission coefficient correction factor for diffuse radiation";
    parameter Modelica.SIunits.TransmissionCoefficient CorG_gr=
      (Ta2_diff+Qsek2_diff)/g_dir0
      "Transmission coefficient correction factor for irradiations from ground";

    //Calculating the correction factor for direct solar radiation
    Modelica.SIunits.TransmissionCoefficient[n] Ta_dir
      "Energetic degree of transmission for direct radiation";
    Modelica.SIunits.TransmissionCoefficient[n] Tai_dir
      "Pure degree of transmission for direct radiation";
    Modelica.SIunits.TransmissionCoefficient[n] Ta1_dir
      "Pure degree of transmission for single pane window";
    Modelica.SIunits.ReflectionCoefficient[n] rho_T1_dir
      "Part of degree of transmission for single pane window related to Ta1_dir";
    Modelica.SIunits.ReflectionCoefficient[n] rho_11_dir
      "Part of degree of transmission for single pane window related to T1_dir";
    Modelica.SIunits.ReflectionCoefficient[n] rho_1_dir
      "Degree of reflection for single pane window";
    Modelica.SIunits.ReflectionCoefficient[n] XN2_dir
      "Calculation factor to simplify equations";
    Modelica.SIunits.TransmissionCoefficient[n] Ta2_dir
      "Energetic dregree of transmission for second pane";
    Modelica.SIunits.Emissivity[n] a1_dir
      "Degree of absorption for single pane window";
    Real[n] Q21_dir
      "Coefficient of heat transfer for exterior pane of double pane window";
    Real[n] Q22_dir
      "Coefficient of heat transfer for interior pane of double pane window";
    Real[n] Qsek2_dir
      "Overall coefficient of heat transfer for double pane window";
    Modelica.SIunits.TransmissionCoefficient[n] CorG_dir
      "Transmission coefficient correction factor for direct radiation";

  equation
    for i in 1:n loop
      Ta_dir[i]= (((((A6*con.to_deg(inc[i])+A5)*con.to_deg(inc[i])+A4)*con.to_deg(inc[i])+A3)*
      con.to_deg(inc[i])+A2)*con.to_deg(inc[i])+A1)*con.to_deg(inc[i])+A0;
      Tai_dir[i]= 0.907^(1/sqrt(1-(sin(inc[i])/1.515)^2));
      Ta1_dir[i]= Ta_dir[i]*Tai_dir[i];
      rho_T1_dir[i]= 1-Ta_dir[i];
      rho_11_dir[i]= rho_T1_dir[i]/(2-rho_T1_dir[i]);
      rho_1_dir[i]=rho_11_dir[i]+(((1-rho_11_dir[i])*Tai_dir[i])^2*rho_11_dir[i])/
      (1-(rho_11_dir[i]*Tai_dir[i])^2);
      a1_dir[i]= 1-Ta1_dir[i]-rho_1_dir[i];
      XN2_dir[i]= 1+10^(-20)-rho_1_dir[i]^2;
      Q21_dir[i]=a1_dir[i]*(1+(Ta1_dir[i]*rho_1_dir[i]/XN2_dir[i]))*UWin/25;
      Q22_dir[i]= a1_dir[i]*(Ta1_dir[i]/XN2_dir[i])*(1-(UWin/7.7));
      Qsek2_dir[i]=Q21_dir[i]+Q22_dir[i];
      Ta2_dir[i]= Ta1_dir[i]^2/XN2_dir[i];
      CorG_dir[i]= (Ta2_dir[i]+Qsek2_dir[i])/g_dir0;

      //Calculating the input thermal energy due to solar radiation
      solarRadWinTrans[i] = ((HDirTil[i]*CorG_dir[i])+(HSkyDifTil[i]*CorG_diff)+
      (HGroDifTil[i]*CorG_gr));
    end for;

    annotation (defaultComponentName="corG",
    Documentation(info="<html>
  <p>This model computes short-wave radiation through
  transparent elements with any orientation and inclination by means of
  solar transmission correction factors. Transmission properties of transparent
  elements are in general dependent on the solar incidence angle. To take this
  dependency into account, correction factors can be multiplied with the solar
  radiation. These factors should not be mistaken as calculation of solar
  radiation on tilted surfaces, calculation of <i>g</i>-values or consideration of
  sunblinds, as it is an additional step. The implemented calculations are
  defined in the German Guideline VDI 6007 Part 3 (VDI, 2015). The given model
  is only valid for double pane windows. The guideline describes also
  calculations for single pane and triple pane windows.</p>
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  modelling of solar radiation.</p>
  </html>",
    revisions="<html>
  <ul>
  <li>
  September 12, 2015 by Moritz Lauster:<br/>
  Adapted to Annex 60 requirements.
  </li>
  <li>
  February 24, 2014, by Reza Tavakoli:<br/>
  First implementation.
  </li>
  </ul>
  </html>"));
  end CorrectionGDoublePane;

  model CorrectionGTaueDoublePane "Correction of the solar gain factor and the transluance factor according to 
  VDI6007 Part 3"
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
    parameter Modelica.SIunits.TransmissionCoefficient g_Dir0=taue_Dir0+Q210+Q220 "Reference vertical parallel transmission coefficient for direct radiation
    for double pane window";
    parameter Modelica.SIunits.TransmissionCoefficient Q210=(1-rho_1Dir0-0.907*A0)*(1+(0.907*A0*rho_1Dir0/(1-rho_1Dir0^2)))*UWin/25;
    parameter Modelica.SIunits.TransmissionCoefficient Q220=(1-rho_1Dir0-0.907*A0)*(0.907*A0/(1-rho_1Dir0^2))*(1-UWin/7.7);
    parameter Modelica.SIunits.TransmissionCoefficient taue_Dir0=(A0*0.907)^2/(1-rho_1Dir0^2)
      "Reference vertical parallel transmission coefficient for direct radiation";
    parameter Modelica.SIunits.ReflectionCoefficient rho_1Dir0=rho_11Dir0+(((1-rho_11Dir0)*0.907)^2*rho_11Dir0)/
    (1-(rho_11Dir0*0.907)^2);
    parameter Modelica.SIunits.ReflectionCoefficient rho_11Dir0=(1-A0)/(2-(1-A0));
    parameter Modelica.SIunits.ReflectionCoefficient XN2_DifCov=1-rho_1DifCov^2
      "Calculation factor to simplify equations";
    parameter Modelica.SIunits.TransmissionCoefficient tau_2DifCov=(tau_1DifCov^2)/
      XN2_DifCov "Energetic dregree of transmission for second pane";
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
      //Calculating variables for the overall degree of energy passage for direct irradiation
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
      Q21_DifCle[i]=a_1DifCle[i]*(1+(tau_1DifCle[i]*rho_1DifCle[i]/XN2_DifCle[i]))*UWin/25;
      Q22_DifCle[i]= a_1DifCle[i]*(tau_1DifCle[i]/XN2_DifCle[i])*(1-(UWin/7.7));
      Qsek2_DifCle[i]=Q21_DifCle[i]+Q22_DifCle[i];
      tau_2DifCle[i]= tau_1DifCle[i]^2/XN2_DifCle[i];

      //Calculating variables for the overall degree of energy passage for ground reflexion radiation
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
  <p><a href=\"vdi6007.BaseClasses.CorrrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a> computes 
  transmission correction factors for the g-factor and the transluence. Transmission properties of transparent
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
<p>Added the correction of the transluence factor according to VDI6007 Part 3</p>
</html>"));
  end CorrectionGTaueDoublePane;

  package BaseClasses "Package with base classes for SolarGain"
    extends Modelica.Icons.BasesPackage;

    partial model PartialCorrectionG
      "Partial model for correction of the solar gain factor"

      parameter Integer n(min = 1) "Vector size for input and output";
      parameter Modelica.SIunits.CoefficientOfHeatTransfer UWin
        "Thermal transmission coefficient of whole window";

      Modelica.Blocks.Interfaces.RealInput HSkyDifTil[n](
        each final quantity="RadiantEnergyFluenceRate",
        each final unit="W/m2")
        "Hemispherical diffuse solar irradiation on a tilted surface from the sky"
        annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-140,0},{-100,40}})));
      Modelica.Blocks.Interfaces.RealInput HDirTil[n](
        each final quantity="RadiantEnergyFluenceRate",
        each final unit="W/m2")
        "Direct solar radiation on a tilted surface per unit area"
        annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput HGroDifTil[n](
        each final quantity="RadiantEnergyFluenceRate",
        each final unit="W/m2")
        "Hemispherical diffuse solar irradiation on a tilted surface from the ground"
        annotation (Placement(transformation(extent={{-140,-40},{-100,0}}),
        iconTransformation(extent={{-140,-40},{-100,0}})));
      Modelica.Blocks.Interfaces.RealInput inc[n](
        each final quantity="Angle",
        each final unit="rad",
        each displayUnit="deg") "Incidence angles"
        annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealOutput solarRadWinTrans[n](
        each final quantity="RadiantEnergyFluenceRate",
        each final unit="W/m2") "transmitted solar radiation through windows"
        annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
      annotation (Icon(coordinateSystem(
      preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
      extent={{-100,100},{100,-100}},
      lineColor={0,0,0},
      fillColor={215,215,215},
      fillPattern=FillPattern.Solid), Text(
      extent={{-52,24},{62,-16}},
      lineColor={0,0,0},
      textString="%name")}),
      Documentation(info="<html>
  <p>Partial model for correction factors for transmitted solar radiation
  through a transparent element.</p>
  </html>",     revisions="<html>
  <ul>
  <li>
  February 27, 2016, by Michael Wetter:<br/>
  Moved input above outputs.
  </li>
  <li>
  February 24, 2014, by Reza Tavakoli:<br/>
  Implemented.
  </li>
  </ul>
  </html>"));
    end PartialCorrectionG;

    partial model PartialCorrectionGTaue
      "Partial model for correction of the solar gain factor and for the transluence"
      import Modelica.Constants.pi;
      import Modelica.SIunits.Conversions.to_deg;
      import
        AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI;
      parameter Integer n(min = 1) "number of windows"
        annotation(dialog(group="window"));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer UWin
        "Thermal transmission coefficient of whole window"
        annotation(dialog(group="window"));
      parameter Modelica.SIunits.Angle xi( displayUnit="degree")=0
        "elevation angle";
      parameter Modelica.SIunits.Angle[n] til(displayUnit="degree")
        "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for roof"
        annotation(dialog(group="window"));

      Modelica.Blocks.Interfaces.RealOutput[n] CorG_Dir(
        final quantity="TransmissionCoefficient",
        final unit="1")
        "Transmission coefficient correction factor for direct radiation"
        annotation (Placement(transformation(extent={{80,-30},{100,-10}}),
        iconTransformation(extent={{80,-30},{100,-10}})));
      Modelica.Blocks.Interfaces.RealOutput[n] CorG_DifCle(
        final quantity="TransmissionCoefficient",
        final unit="1")
        "Transmission coefficient correction factor for diffuse radiation while clear sky"
        annotation (Placement(transformation(extent={{80,-50},{100,-30}}),
        iconTransformation(extent={{80,-50},{100,-30}})));
      Modelica.Blocks.Interfaces.RealOutput[n] CorG_DifCov(
        final quantity="TransmissionCoefficient",
        final unit="1")
        "Transmission coefficient correction factor for diffuse radiation while covered sky"
        annotation (Placement(transformation(extent={{80,-70},{100,-50}}),
        iconTransformation(extent={{80,-70},{100,-50}})));
      Modelica.Blocks.Interfaces.RealOutput[n] CorG_Gro(
        final quantity="TransmissionCoefficient",
        final unit="1")
        "Transmission coefficient correction factor for ground reflection radiation"
        annotation (Placement(transformation(extent={{80,-90},{100,-70}}),
        iconTransformation(extent={{80,-90},{100,-70}})));
      Modelica.Blocks.Interfaces.RealOutput[n] CorTaue_Dir(
        final quantity="TransmissionCoefficient",
        final unit="1")
        "Correction value for transluance for direct irradiation"
        annotation (Placement(transformation(extent={{80,10},{100,30}}),
        iconTransformation(extent={{80,10},{100,30}})));
      Modelica.Blocks.Interfaces.RealOutput[n] CorTaue_DifCle(
        final quantity="TransmissionCoefficient",
        final unit="1")
        "Correction value for transluance for diffuse irradiation during clear sky"
        annotation (Placement(transformation(extent={{80,30},{100,50}}),
        iconTransformation(extent={{80,30},{100,50}})));
      Modelica.Blocks.Interfaces.RealOutput[n] CorTaue_DifCov(
        final quantity="TransmissionCoefficient",
        final unit="1")
        "Correction value for transluance for diffuse irradiation during covered sky"
        annotation (Placement(transformation(extent={{80,50},{100,70}}),
        iconTransformation(extent={{80,50},{100,70}})));
      Modelica.Blocks.Interfaces.RealOutput[n] CorTaue_Gro(
        final quantity="TransmissionCoefficient",
        final unit="1")
        "Correction value for transluance for ground reflexion radiation"
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
        "true: sunscreen closed, false: sunscreen open"
        annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
            iconTransformation(extent={{-100,-30},{-80,-10}})));

    protected
      parameter Real A0=0.918
        "Constant 0 to calculate reference transmission";
      parameter Real A1=2.21*10^(-4)
        "Constant 1 to calculate reference transmission";
      parameter Real A2=-2.75*10^(-5)
        "Constant 2 to calculate reference transmission";
      parameter Real A3=-3.82*10^(-7)
        "Constant 3 to calculate reference transmission";
      parameter Real A4=5.83*10^(-8)
        "Constant 4 to calculate reference transmission";
      parameter Real A5=-1.15*10^(-9)
        "Constant 5 to calculate reference transmission";
      parameter Real A6=4.74*10^(-12)
        "Constant 6 to calculate reference transmission";

      parameter Modelica.SIunits.TransmissionCoefficient tau_1DifCov= tau_DifCov*tau_iDif
        "Degreee of transmission for single pane window";
      parameter Modelica.SIunits.ReflectionCoefficient rho_T1DifCov=1-(tau_DifCov)
        "Part of degree of transmission for single pane window related to tau_1DifCov";
      parameter Modelica.SIunits.ReflectionCoefficient rho_11DifCov=rho_T1DifCov/
        (2-(rho_T1DifCov)) "Part of degree of transmission for single pane window related to
    rho_T1_diff";
      parameter Modelica.SIunits.ReflectionCoefficient rho_1DifCov= rho_11DifCov+
        (((1-rho_11DifCov)*tau_iDif)^2*rho_11DifCov)/(1-(rho_11DifCov*tau_iDif)^2)
        "Degree of reflection for single pane window";
      parameter Modelica.SIunits.TransmissionCoefficient tau_DifCov=0.84
        "Energetic degree of transmission for diffuse radiation for uniformly overcast sky";

      parameter Modelica.SIunits.TransmissionCoefficient tau_iDif=0.903
        "Pure degree of transmission for diffuse radiation";
      Modelica.SIunits.Angle[n] gamma_x
        "calculation factor for ground reflexion radiation";
      Modelica.SIunits.TransmissionCoefficient[n] tau_Dir
        "Energetic degree of transmission for direct radiation";
      Modelica.SIunits.TransmissionCoefficient[n] taui_Dir
        "Pure degree of transmission for direct radiation";
      Modelica.SIunits.TransmissionCoefficient[n] tau_1Dir
        "Pure degree of transmission for single pane window";
      Modelica.SIunits.ReflectionCoefficient[n] rho_T1Dir
        "Part of degree of transmission for single pane window related to tau_1Dir";
      Modelica.SIunits.ReflectionCoefficient[n] rho_11Dir
        "Part of degree of transmission for single pane window related to T1_Dir";
      Modelica.SIunits.ReflectionCoefficient[n] rho_1Dir
        "Degree of reflection for single pane window";
      Modelica.SIunits.Emissivity[n] a_1Dir
        "Degree of absorption for single pane window";

      Modelica.SIunits.TransmissionCoefficient[n] tau_DifCle
        "Energetic degree of transmission for diffuse radiation for clear sky";
      Modelica.SIunits.TransmissionCoefficient[n] tau_1DifCle
        "Degreee of transmission for single pane window";
      Modelica.SIunits.ReflectionCoefficient[n] rho_T1DifCle
        "Part of degree of transmission for single pane window related to tau_1DifCle";
      Modelica.SIunits.ReflectionCoefficient[n] rho_11DifCle
        "Part of degree of transmission for single pane window related to T1_DifCle";
      Modelica.SIunits.ReflectionCoefficient[n] rho_1DifCle
        "Degree of reflection for single pane window";
      Modelica.SIunits.Emissivity[n] a_1DifCle
        "Degree of absorption for single pane window";
      Modelica.SIunits.TransmissionCoefficient[n] tau_Gro
        "Energetic degree of transmission for ground reflexion radiation";
      Modelica.SIunits.TransmissionCoefficient[n] tau_1Gro
        "Degreee of transmission for single pane window";
      Modelica.SIunits.ReflectionCoefficient[n] rho_T1Gro
        "Part of degree of transmission for single pane window related to tau_1Gro";
      Modelica.SIunits.ReflectionCoefficient[n] rho_11Gro
        "Part of degree of transmission for single pane window related to T1_gr";
      Modelica.SIunits.ReflectionCoefficient[n] rho_1Gro
        "Degree of reflection for single pane window";
      Modelica.SIunits.Emissivity[n] a_1Gro
        "Degree of absorption for single pane window";
    equation

      for i in 1:n loop
      //Calculating variables for direct irradiation
      taui_Dir[i]= 0.907^(1/sqrt(1-(Modelica.Math.sin(incAng[i])/1.515)^2));
      if (((((A6*to_deg(incAng[i])+A5)*to_deg(incAng[i])+A4)*to_deg(incAng[i])+A3)*
      to_deg(incAng[i])+A2)*to_deg(incAng[i])+A1)*to_deg(incAng[i])+A0 <0 then
      tau_Dir[i]=0;
      else
      tau_Dir[i]= (((((A6*to_deg(incAng[i])+A5)*to_deg(incAng[i])+A4)*to_deg(incAng[i])+A3)*
      to_deg(incAng[i])+A2)*to_deg(incAng[i])+A1)*to_deg(incAng[i])+A0;
      end if;
      tau_1Dir[i]= tau_Dir[i]*taui_Dir[i];
      rho_T1Dir[i]= 1-tau_Dir[i];
      rho_11Dir[i]= rho_T1Dir[i]/(2-rho_T1Dir[i]);
      rho_1Dir[i]=rho_11Dir[i]+(((1-rho_11Dir[i])*taui_Dir[i])^2*rho_11Dir[i])/
      (1-(rho_11Dir[i]*taui_Dir[i])^2);
      a_1Dir[i]= 1-tau_1Dir[i]-rho_1Dir[i];
      //Calculating variables for diffuse, clear irradiation
      if 0.83-0.075*(to_deg(to_surfaceTiltVDI(til[i]))/70-1)^2+(0.052+0.033*(to_deg(to_surfaceTiltVDI(til[i]))/90-1)^2)
      *(Modelica.Math.cos(incAng[i])+0.15)^2 < 0 then
      tau_DifCle[i] = 0;
      else
      tau_DifCle[i]=0.83-0.075*(to_deg(to_surfaceTiltVDI(til[i]))/70-1)^2+(0.052+0.033*(to_deg(to_surfaceTiltVDI(til[i]))/90-1)^2)
      *(Modelica.Math.cos(incAng[i])+0.15)^2;
      end if;
      tau_1DifCle[i]= tau_DifCle[i]*tau_iDif;
      rho_T1DifCle[i]= 1-tau_DifCle[i];
      rho_11DifCle[i]= rho_T1DifCle[i]/(2-rho_T1DifCle[i]);
      rho_1DifCle[i]=rho_11DifCle[i]+(((1-rho_11DifCle[i])*tau_iDif)^2
      *rho_11DifCle[i])/(1-(rho_11DifCle[i]*tau_iDif)^2);
      a_1DifCle[i]=1-tau_1DifCle[i]-rho_1DifCle[i];
      //Calculating variables for ground reflexion radiation
      if (xi+to_surfaceTiltVDI(til[i]))<0 then
        gamma_x[i]=0;
      elseif (xi+to_surfaceTiltVDI(til[i]))>pi/2 then
        gamma_x[i]=pi/2;
      else
        gamma_x[i]=xi+to_surfaceTiltVDI(til[i]);
      end if;
      tau_Gro[i] = 0.84*Modelica.Math.sin(gamma_x[i])^(0.88*(1-0.5*abs(Modelica.Math.sin(2*gamma_x[i]))));
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
      Documentation(info="<html>
  <p>Partial model for correction factors for transmitted solar radiation
  through a transparent element.</p> 
<p><a href=\"vdi6007.BaseClasses.CorrrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a> uses this model to calculate the correction values for double pane windows. This model can be used as a partial model to calculate the correction values for single pane windows and triple pane windows according to the VDI Guideline <\\p>
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI 6007-3
  June 2015. Calculation of transient thermal response of rooms
  and buildings - modelling of solar radiation.</p>
  </html>",     revisions="<html>
  <p><i>February 24, 2014</i> by Reza Tavakoli:</p>
  <p>Implemented. </p>
<p><i>May 25, 2016 </i>by Stanley Risch:</p>
<p>Added the correction of the transluence factor according to VDI6007 Part 3</p>
  </html>"));
    end PartialCorrectionGTaue;
  annotation (Documentation(info="<html>
<p>
This package contains base classes to calculate solar gain through windows.
</p>
</html>"));
  end BaseClasses;
annotation (Documentation(info="<html>
<p>
This package contains models to compute solar heat gains.
</p>
</html>"));
end SolarGain;
