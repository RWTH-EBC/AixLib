within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
model CorG_ASHRAE140
  "Correction of the solar gain factor according to ASHRAE 140"
  extends PartialCorG;

  import Modelica.Units.Conversions.to_deg;
  import Modelica.Math.asin;
  import Modelica.Math.sin;
  import Modelica.Math.tan;
  import Modelica.Math.cos;

  parameter Real INDRG=1.526 "Index of refraction of Glass, in this case INDRG= 1.526";
  parameter Real p = 2 "number of panes of glass, in this case p = 2";
  parameter Real TH = 3.175 "Thickness of glass, in this case TH = 3.175 mm";
  parameter Real K = 0.0196 "Extintion coefficient, in this case K = 0.0196/mm";
  parameter Real Rout = 0.0476 "Exterior combined heat transfer coefficient";
  parameter Real RairGab = 0.1588 "Heat transfer coefficient of air gap";

  Real[n] AOI " Angle of incidence";
  Real[n] AOI_help;
  Real[n] AOR "Angle of refraction";
  Real[n] RPERP "Perpendicular reflectance(component of polarization)";
  Real[n] RPAR "Parallel reflectance(component of polarization)";
  Real[n] R "Reflectance";
  Real[n] Trn "Transmittance due to reflectance losses(transmittance if there were just reflectance losses and no absorptance losses)";
  Real[n] Tabs "Transmittance due to absorptance losses(transmittance if there were just absorptance losses and no reflectance losses)";
  Real[n] L "Path length";
  Real[n] T "Total transmittance Tr*Tabs";
  Real[n] S "Inward flowing portion of the absorbed radiation in window panes";
  Real[n] SHGC "Solar heat gain coefficient";


  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    tableOnFile=false,
    table=[0,0.0643,0.0522; 20,0.0659,0.0534; 30,0.0679,0.0548; 40,0.0708,0.0566; 48,0.0738,0.058;
        55,0.0769,0.0587; 57,0.0779,0.0587; 60,0.0796,0.0585; 63,0.0815,0.0579; 66,0.0837,0.0568; 68,0.0852,
        0.0558; 70,0.0858,0.0544; 72,0.089,0.0521; 75,0.0911,0.0492; 77.5,0.0929,0.0457; 80,0.094,0.0413;
        82,0.0937,0.0372; 83.5,0.0924,0.0335; 85,0.0892,0.0291; 86,0.0854,0.0254; 87,0.079,0.0205; 88,0.0671,
        0.0128; 89,0.0473,0.0043; 89.5,0.0304,0.0004; 89.99,0.0011,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-16,36},{4,56}})));
  Real y;
  Modelica.Blocks.Sources.RealExpression realExpression(y=y)
    annotation (Placement(transformation(extent={{-68,38},{-48,58}})));
equation
  for i in 1:n loop
    // Snell's Law
    AOI[i] = SR_input[i].AOI; // in rad
    AOI_help[i] = to_deg(SR_input[i].AOI); // angle of solar incidence in deg
    y=AOI_help[i];

    AOR[i] = asin(sin(AOI[i])/INDRG); //  Angle of refraction in deg

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

    // inward flowing portion of the absorbed radiation through the window panes
    // combiTableDs.y[1] is the absoprtance of the outer window pane
    // combiTableDs.y[2] is the aborptance of the inner window pane
        S[i] = combiTable1Ds.y[1]* Uw * Rout+ combiTable1Ds.y[2] *Uw*(RairGab+Rout);

    // Solar heat gain coefficient
    SHGC[i]= T[i]+S[i];

    //Solar radiation transmitted through window
    solarRadWinTrans[i]= (SR_input[i].I_diff + SR_input[i].I_dir + SR_input[i].I_gr) * SHGC[i];

  end for;


  connect(realExpression.y, combiTable1Ds.u) annotation (Line(points={{-47,48},{
          -32,48},{-32,46},{-18,46}}, color={0,0,127}));
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  This model computes the transmission correction factors for solar
  radiation through a double pane window depoending on the incidence
  angle, based on the ASHRAE140-2017.
</p>
<h4>
  <span style=\"color: #008000\">Known Limitations</span>
</h4>
<p>
  The model is directly paramtrized for a double pane window.
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<ul>
  <li>ASHRAE140-2017 Informative Annex B6
  </li>
  <li>Heating and Cooling of Buildings, Priciples and Practice of
  Energy Efficient Design (p.142)
  </li>
</ul>
<ul>
  <li>April 24, 2020, by Konstantina Xanthopoulou:<br/>
    First Implementation.
  </li>
  <li style=\"list-style: none\">This is for <a href=
  \"https://github.com/RWTH-EBC/AixLib/issues/889\">#889</a>.
  </li>
</ul>
</html>"));
end CorG_ASHRAE140;
