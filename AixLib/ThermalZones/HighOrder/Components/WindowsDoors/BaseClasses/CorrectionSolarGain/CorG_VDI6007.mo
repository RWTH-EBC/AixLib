within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
model CorG_VDI6007 "correction of the solar gain factor according to VDI6007"
  extends PartialCorG;

  import Modelica.Units.Conversions.to_deg;

//  parameter Real coeff=0.6 "Weight coefficient";
 // parameter Modelica.SIunits.Area A=6 "Area of surface";
//  parameter Real A = 10 "Area of surface";

// parameters for calculating the transmission correction factor based on VDI_6007 Part-3
  // A0 to A6 are experimental constants VDI 6007 Part-3 page 20
protected
parameter Real A0=0.918;
parameter Real A1=2.21*10^(-4);
parameter Real A2=-2.75*10^(-5);
parameter Real A3=-3.82*10^(-7);
parameter Real A4=5.83*10^(-8);
parameter Real A5=-1.15*10^(-9);
parameter Real A6=4.74*10^(-12);
parameter Real g_dir0=0.7537; // reference value for 2 Panels window
parameter Real Ta_diff = 0.84; // energetic degree of transmission for diffuse solar irradiation
parameter Real Tai_diff=0.903; //Pure degree of transmission
parameter Real Ta1_diff= Ta_diff*Tai_diff;
parameter Real rho_T1_diff=1-(Ta_diff);
parameter Real rho_11_diff=rho_T1_diff/(2-(rho_T1_diff));
parameter Real rho_1_diff= rho_11_diff+(((1-rho_11_diff)*Tai_diff)^2*rho_11_diff)/(1-(rho_11_diff*Tai_diff)^2);  //degree of reflection for single panel clear glass
parameter Real XN2_diff=1-rho_1_diff^2;
parameter Real Ta2_diff=(Ta1_diff^2)/XN2_diff;
parameter Real a1_diff=1-Ta1_diff-rho_1_diff; // degree of absorption for single panel clear glass
parameter Real Q21_diff=a1_diff*(1+(Ta1_diff*rho_1_diff/XN2_diff))*Uw/25;
parameter Real Q22_diff=a1_diff*(Ta1_diff/XN2_diff)*(1-(Uw/7.7));
parameter Real Qsek2_diff=Q21_diff+Q22_diff;
parameter Real CorG_diff=(Ta2_diff+Qsek2_diff)/g_dir0; // transmission coefficient correction factor for diffuse irradiations
parameter Real CorG_gr=(Ta2_diff+Qsek2_diff)/g_dir0;   // transmission coefficient correction factor for irradiations from ground

//calculating the correction factor for direct solar radiation
Real[n] theta; // solar incident angle
Real[n] Ta_dir;  // energetic degree of transmission for direct solar irradiation
Real[n] Tai_dir;  //Pure degree of transmission
Real[n] Ta1_dir;
Real[n] rho_T1_dir;
Real[n] rho_11_dir;
Real[n] rho_1_dir;  //degree of reflection for single panel clear glass
Real[n] XN2_dir;
Real[n] Ta2_dir;
Real[n] a1_dir;   // degree of absorption for single panel clear glass
Real[n] Q21_dir;
Real[n] Q22_dir;
Real[n] Qsek2_dir;
Real[n] CorG_dir;  // transmission coefficient correction factor for direct irradiations
equation
  for i in 1:n loop
    theta[i] = SR_input[i].AOI;
    Ta_dir[i]= (((((A6*to_deg(theta[i])+A5)*to_deg(theta[i])+A4)*to_deg(theta[i])+A3)*to_deg(theta[i])+A2)*to_deg(theta[i])+A1)*to_deg(theta[i])+A0;
    Tai_dir[i]= 0.907^(1/sqrt(1-(sin(theta[i])/1.515)^2));
    Ta1_dir[i]= Ta_dir[i]*Tai_dir[i];
    rho_T1_dir[i]= 1-Ta_dir[i];
    rho_11_dir[i]= rho_T1_dir[i]/(2-rho_T1_dir[i]);
    rho_1_dir[i]=rho_11_dir[i]+(((1-rho_11_dir[i])*Tai_dir[i])^2*rho_11_dir[i])/(1-(rho_11_dir[i]*Tai_dir[i])^2);
    a1_dir[i]= 1-Ta1_dir[i]-rho_1_dir[i];
    XN2_dir[i]= 1+10^(-20)-rho_1_dir[i]^2;
    Q21_dir[i]=a1_dir[i]*(1+(Ta1_dir[i]*rho_1_dir[i]/XN2_dir[i]))*Uw/25;
    Q22_dir[i]= a1_dir[i]*(Ta1_dir[i]/XN2_dir[i])*(1-(Uw/7.7));
    Qsek2_dir[i]=Q21_dir[i]+Q22_dir[i];
    Ta2_dir[i]= Ta1_dir[i]^2/XN2_dir[i];
    CorG_dir[i]= (Ta2_dir[i]+Qsek2_dir[i])/g_dir0;

    //calculating the input thermal energy due to solar radiation
    solarRadWinTrans[i] = ((SR_input[i].I_dir*CorG_dir[i])+(SR_input[i].I_diff*CorG_diff)+(SR_input[i].I_gr*CorG_gr));
  end for;

annotation (
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model computes the transmission correction factors for solar
  radiation through a double pane window depoending on the incidence
  angle, based on the VDI 6007_Part 3.
</p>
<p>
  The correction factors are calculated for the transmitted total and
  diffuse( cloudy sky) solar radiation, and the reflected radiation
  from the groung.
</p>
<h4>
  <span style=\"color:#008000\">Known Limitations</span>
</h4>
<p>
  The model is directly paramtrized for a double pane window.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  transmission correction factors (CORg) are calculated based on :
</p>
<ul>
  <li>VDI 6007_part3
  </li>
</ul>
</html>",
    revisions="<html><ul>
  <li>April 24, 2020, by Konstantina Xanthopoulou:<br/>
    Removed parameter <code>g</code>.
  </li>
  <li style=\"list-style: none\">This is for <a href=
  \"https://github.com/RWTH-EBC/AixLib/issues/899\">issue 899</a>.
  </li>
  <li>
    <p>
      <i>February 24, 2014</i> by Reza Tavakoli:
    </p>
    <p>
      implemented
    </p>
  </li>
</ul>
</html>"));
end CorG_VDI6007;
