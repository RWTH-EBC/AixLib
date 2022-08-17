within AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.RadiationOnTiltedSurface;
model RadOnTiltedSurf_Perez
  "Calculates solar radiation on tilted surfaces according to Perez"
  extends RadiationOnTiltedSurface.BaseClasses.PartialRadOnTiltedSurf;

  import Modelica.Units.Conversions.to_deg;
  import Modelica.Units.Conversions.from_deg;
  import Modelica.Math.sin;
  import Modelica.Math.acos;
  import Modelica.Math.cos;

//parameter

  parameter Boolean GroundReflexApprox =  false
    "Shall the GroundReflection be approximated?" annotation (Dialog(group=
        "Ground reflection"));
  parameter Modelica.Units.SI.Height h=0
    "height of the tilted surfaces centre in metre. if unknown it is 0";

//constants
protected
  constant Real a_rho=0.45
    "estimated on measured Albedo from NREL USA (Latitude=39.74 deg)";
  constant Real b_rho=0.013 "estimated on measured Albedo from NREL USA";
  constant Real c_rho=0.2 "estimated on measured Albedo from NREL USA";
  constant Real rho_avg=1/0.27055
    "factor for setting the average of rho to the value of GroundReflection";
  constant Real SolarConstant=1367;
  constant Real A[ 8,6]= [-0.0083117, 0.5877285, -0.0620636, -0.0596012, 0.0721249, -0.0220216;
                          0.1299457, 0.6825954, -0.1513752, -0.0189325, 0.0659650, -0.0288748;
                          0.3296958, 0.4868735, -0.2210958, 0.0554140, -0.0639588, -0.0260542;
                          0.5682053, 0.1874525, -0.2951290, 0.1088631, -0.1519229, 0.0139754;
                          0.8730280, -0.3920403, -0.3616149, 0.2255647, -0.4620442, 0.0012448;
                          1.1326077, -1.2367284, -0.4118494, 0.2877813, -0.8230357, 0.0558651;
                          1.0601591, -1.5999137, -0.3589221, 0.2642124, -1.1272340, 0.1310694;
                          0.6777470, -0.3272588, -0.2504286, 0.1561313, -1.3765031, 0.2506212]
    "Brightness Coefficient Matrix by [Perez 1990] * Engineering reference EnergyPlus, page 143";

//variables

public
    Real InBeamRadHor "beam irradiance on the horizontal surface";
    Real InDiffRadHor "diffuse irradiance on the horizontal surface";
    Real BeamRadTilt "Beam irradiance on a tilted surface";
    Real DiffRadTilt "Diffuse irradiance on a tilted surface";
    Real RadGroundRefl "Ground-reflected irradiance";
    //the following variables are necessary for the use of the Perez anisotropic sky-model for determining the diffuse radiation on tilted surfaces [Perez et al., Solar Energy, 44, 271, (1990). "Modeling Daylight Availibility and Irradiance Components from Direct and Global Irradiance];
    Real DiffRadTiltCS "circumsolar diffuse irradiance";
    Real DiffRadTiltHZ "horizontal diffuse irradiance";
    Real DiffRadTiltDOM "sky dome diffuse irradiance";

protected
    Real rho "groundreflection";
    Real cos_theta_help;
    Real cos_theta;
    Real cos_theta_z_help;
    Real cos_theta_z;
    Real theta_z_pos;
    Real theta_z;
    Real R "geometric beam radiation factor";
    Real Airmass;
    Real ExtraterRadHor;
    Real a "used for determining R";
    Real b "used for determining R";
    Real c "used instead of InDiffRadHor for determining epsilon";
    Real F1 "brightness coefficient 1";
    Real F2 "brightness coefficient 2";
    Real epsilon "sky-clearness parameter";
    Real delta "brightness parameter";

    //Fij factors
    Real f11;
    Real f12;
    Real f13;
    Real f21;
    Real f22;
    Real f23;

  //input

  //output

public
    Modelica.Blocks.Interfaces.RealOutput rho_out "groundreflection"
      annotation (Placement(
          transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-16,-88}),
          iconTransformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={-12,-84})));
    Modelica.Blocks.Interfaces.RealOutput theta_out
    "[degree] angle of incidence"
    annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,-88}),
          iconTransformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={32,-84})));
    Modelica.Blocks.Interfaces.RealOutput theta_z_out
    "degree value; solar zenith angle"
      annotation (Placement(
          transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={6,-88}),
          iconTransformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={10,-84})));
    Modelica.Blocks.Interfaces.RealOutput BeamRadTiltOut
    "[W/m2] Beam irradiance on a tilted surface"
      annotation (Placement(transformation(extent={{72,-22},{92,-2}}), iconTransformation(extent={{70,-10},{82,2}})));
    Modelica.Blocks.Interfaces.RealOutput DiffRadTiltCSOut
    "[W/m2] circumsolar diffuse irradiance"
      annotation (Placement(transformation(extent={{72,-62},{92,-42}}),iconTransformation(extent={{70,-52},{82,-40}})));
    Modelica.Blocks.Interfaces.RealOutput DiffRadTiltHZOut
    "[W/m2] Diffuse irradiance on a tilted surface"
      annotation (Placement(transformation(extent={{72,-80},{92,-60}}),iconTransformation(extent={{70,-72},{82,-60}})));
    Modelica.Blocks.Interfaces.RealOutput DiffRadTiltDOMOut
    "[W/m2] Diffuse irradiance on a tilted surface"
      annotation (Placement(transformation(extent={{72,-42},{92,-22}}),iconTransformation(extent={{70,-30},{82,-18}})));
    Modelica.Blocks.Interfaces.RealOutput brightness_out
    "dimensionless factor, which says how cloudy the sky is (see: delta)"
      annotation (Placement(
          transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={52,-88}),
          iconTransformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={54,-84})));

  Modelica.Blocks.Tables.CombiTable1Ds FijFactors(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    tableOnFile=false,
    table=[1.000,-0.0083117,0.5877285,-0.0620636,-0.0596012,0.0721249,-0.0220216;
        1.065,0.1299457,0.6825954,-0.1513752,-0.0189325,0.0659650,-0.0288748;
        1.230,0.3296958,0.4868735,-0.2210958,0.0554140,-0.0639588,-0.0260542;
        1.500,0.5682053,0.1874525,-0.2951290,0.1088631,-0.1519229,-0.0139754;
        1.950,0.8730280,-0.3920403,-0.3616149,0.2255647,-0.4620442,0.0012448;
        2.800,1.1326077,-1.2367284,-0.4118494,0.2877813,-0.8230357,0.0558651;
        4.500,1.0601591,-1.5999137,-0.3589221,0.2642124,-1.1272340,0.1310694;
        6.200,0.6777470,-0.3272588,-0.2504286,0.1561313,-1.3765031,0.2506212;
        100.00,0.6777470,-0.3272588,-0.2504286,0.1561313,-1.3765031,0.2506212])
    "Fij Factors as a Function of Sky Clearness Range."
    annotation (Placement(transformation(extent={{-10,72},{10,92}})));

equation
    if GroundReflexApprox then
      rho = GroundReflection*rho_avg*max(a_rho*cos(from_deg(InDayAngleSun)), b_rho*(from_deg(InDayAngleSun-180))^2 + c_rho);
      //rho = 1.25*GroundReflection + 0.25*GroundReflection*cos(from_deg(InDayAngleSun)) - 0.5*GroundReflection*(sin(from_deg(InDayAngleSun)))^2 "another approximation"
    else
      rho = GroundReflection;
    end if;
    rho_out=rho;

    // calculation of cos_theta_z [Duffie/Beckman, p.15], cos_theta_z is manually cut at 0 (no neg. values);
    cos_theta_z_help =  sin(from_deg(InDeclinationSun))*sin(from_deg(Latitude))
                      + cos(from_deg(InDeclinationSun))*cos(from_deg(Latitude))*cos(from_deg(InHourAngleSun));

    theta_z = to_deg(acos(cos_theta_z_help));
    cos_theta_z = (cos_theta_z_help + abs(cos_theta_z_help))/2;
    theta_z_pos = to_deg(acos(cos_theta_z));
    theta_z_out = theta_z_pos;

    //calculation of cos_theta [Duffie/Beckman, p.15], cos_theta is manually cut at 0 (no neg. values);
    cos_theta_help =  sin(from_deg(InDeclinationSun))*sin(from_deg(Latitude))*cos(from_deg(Tilt))
                    - sin(from_deg(InDeclinationSun))*cos(from_deg(Latitude))*sin(from_deg(Tilt))*cos(from_deg(Azimut))
                    + cos(from_deg(InDeclinationSun))*cos(from_deg(Latitude))*cos(from_deg(Tilt))*cos(from_deg(InHourAngleSun))
                    + cos(from_deg(InDeclinationSun))*sin(from_deg(Latitude))*sin(from_deg(Tilt))*cos(from_deg(Azimut))*cos(from_deg(InHourAngleSun))
                    + cos(from_deg(InDeclinationSun))*sin(from_deg(Tilt))*sin(from_deg(Azimut))*sin(from_deg(InHourAngleSun));

    cos_theta = (cos_theta_help + abs(cos_theta_help))/2;
    theta_out = to_deg(acos(cos_theta));

    // calculation of R factor [Duffie/Beckman, p.25], but in order not to divide by zero it is determined like a/b in the Model of Perez [Duffie/Beckman, p.94] where the minimum b is set to cos(85 deg);
            // R is manually set to 0 for theta_z_pos >= 80 degrees (-> 90 degrees means sunset)__old solution for the numerical problems of dividing by zero;
            //if noEvent(cos_theta_z <= 0.08715574274) then
            //  R_help = cos_theta_z*cos_theta;
            //else
            //  R_help = cos_theta/cos_theta_z;
            //end if;
            //R = R_help;

      a = max(0,cos_theta)
    "in the Perez Model it is max(0,cos(theta)), but cos_theta is already positiv";
    //b = max(cos(from_deg(85)), cos_theta_z);
      b = max(0.087, cos_theta_z);
      R = a / b;

  // conversion of direct and diffuse horizontal radiation
  if WeatherFormat == 1 then // TRY
    InBeamRadHor = solarInput1;
    InDiffRadHor = solarInput2;
  else  // WeatherFormat == 2 , TMY then
    InBeamRadHor = solarInput1 * cos_theta_z;
    InDiffRadHor = max(solarInput2-InBeamRadHor, 0);
  end if;

  // calculation of the Beam Irradiation on a tilted surface;
  BeamRadTilt = R*InBeamRadHor;

  //calculation of the Groundreflected Irradiation on a tilted surface;
  RadGroundRefl = rho*(InBeamRadHor + InDiffRadHor)*((1 - cos(from_deg(Tilt)))/2);

  // calculating of the diffuse irradiation with the Method of [Perez 1990];

      //getting brightness coefficients from brightness coefficient vector;

    //Calculation of the extraterrestrial Radiation on a horizontal Surface [Duffie/Beckman 2006, p.9];
      ExtraterRadHor = SolarConstant * (1.000110 + 0.034221 * cos(from_deg(InDayAngleSun))
                      + 0.001280 * sin(from_deg(InDayAngleSun)) + 0.000719 * cos(2*from_deg(InDayAngleSun))
                      + 0.000077 * sin(2*from_deg(InDayAngleSun)));

    //Calculation of the Airmass [Duffie/Beckman 2006, p.10];
      Airmass = exp(-0.0001184*h) / (cos_theta_z + 0.5057 * (96.080 - theta_z_pos)^(-1.634));

/*    //Calculation of epsilon like in the Perez model [Duffie/Beckman 2006, p.94]. In order not to divide by zero, the minimum of c(the diffuse irradiation on a horizontal surface) is set 0.1 W/m2;
      c = max(0.1, InDiffRadHor);
      epsilon = (((InBeamRadHor/b + c) / c) + 5.535E-6 * theta_z_pos^3) / (1 + 5.535E-6 * theta_z_pos^3);
      */
      //Calculation of epsilon like in the EngineeringReference(EnergyPlus) page 143 In order not to divide by zero, the minimum of c(the diffuse irradiation on a horizontal surface) is set 0.1 W/m2;
      c = max(0.1, InDiffRadHor);
      epsilon = (((InBeamRadHor/b + c) / c) + 1.041 * (from_deg(theta_z_out))^3) / (1 + 1.041 * (from_deg(theta_z_out))^3);

      ////get the right coefficients for determining the brigthness coefficient;
      FijFactors.u = epsilon;
      f11=FijFactors.y[1];
      f12=FijFactors.y[2];
      f13=FijFactors.y[3];
      f21=FijFactors.y[4];
      f22=FijFactors.y[5];
      f23=FijFactors.y[6];

    //Calculation of the brightness parameter [Duffie/Beckman 2006, p.94];
      delta = Airmass * InDiffRadHor /  ExtraterRadHor;
      brightness_out=delta;

    //Calculation of the brightness coefficients [Duffie/Beckman 2006, p.94]
      F1 = max(0, f11 + f12 * delta + from_deg(theta_z_out) * f13);
      F2 = f21 + f22 * delta + from_deg(theta_z_out) * f23;

    DiffRadTiltHZ = InDiffRadHor * F2 * sin(from_deg(Tilt))
    "diffuse irradiance from the sky horizon on the tilted Surface";

    DiffRadTiltDOM = InDiffRadHor * (1 - F1)*((1 + cos(from_deg(Tilt)))/2)
    "diffuse irradiation from sky dome on a tilted Surface";

    DiffRadTiltCS = InDiffRadHor * F1 * R
    "diffuse irradiation from circumsolar region on a tilted Surface";

    DiffRadTilt = DiffRadTiltHZ + DiffRadTiltDOM + DiffRadTiltCS
    "total diffuse irradiation on a tilted Surface";

    OutTotalRadTilted.I = max(0, BeamRadTilt + DiffRadTilt + RadGroundRefl)
    "output connector for the total Irradiation on a tilted Surface";

  // calculation of direct. diffuse and ground reflection radiation on tilted surface
  OutTotalRadTilted.I_dir = BeamRadTilt;
  OutTotalRadTilted.I_diff = DiffRadTilt;
  OutTotalRadTilted.I_gr = RadGroundRefl;
  OutTotalRadTilted.AOI = Modelica.Math.acos(cos_theta); // in rad

//Output
  BeamRadTilt=BeamRadTiltOut;
  DiffRadTiltCS=DiffRadTiltCSOut;
  DiffRadTiltHZ=DiffRadTiltHZOut;
  DiffRadTiltDOM=DiffRadTiltDOMOut;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                        graphics={
        Text(
          extent={{-88,90},{68,68}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-70,55},{70,-95}},
          lineColor={0,0,255},
          startAngle=0,
          endAngle=179,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={170,213,255}),
        Ellipse(
          extent={{-70,-37},{70,0}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,48},{18,34}},
          lineColor={0,0,255},
           pattern=LinePattern.None,
          fillColor={255,225,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,4},{-34,-6},{-10,-18},{-20,-6},{-40,4}},
          lineColor={0,127,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{18,40},{-30,-2}},
          thickness=0.5),
        Line(
          points={{10,42},{-30,-2}}),
        Line(
          points={{22,34},{-30,-2}}),
        Line(
          points={{-30,-2},{52,2}}),
        Line(
          points={{-30,-2},{56,-8}}),
        Polygon(
          points={{-34,-6},{-48,-12},{-46,-18},{-32,-20},{-10,-18},{-34,-6}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,90,0},
           pattern=LinePattern.None),
        Polygon(
          points={{-36,-6},{-70,-20},{-64,-26},{-54,-30},{-10,-18},{-32,-20},
              {-46,-18},{-48,-12},{-34,-6},{-36,-6}},
          fillColor={0,98,0},
          fillPattern=FillPattern.Solid,
           pattern=LinePattern.None),
        Ellipse(extent={{-69,-26},{69,8}}, lineColor={0,0,0}),
        Rectangle(
          extent={{-70,72},{70,-72}},
           pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={0,-6},
          rotation=360)}),
Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),graphics={
        Ellipse(
          extent={{-70,55},{70,-95}},
          lineColor={0,0,255},
          startAngle=0,
          endAngle=179,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={170,213,255}),
        Ellipse(
          extent={{-70,-37},{70,0}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{22,48},{18,34}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={255,225,0},
        fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,4},{-34,-6},{-10,-18},{-20,-6},{-40,4}},
          lineColor={0,127,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{18,40},{-30,-2}},
          thickness=0.5),
        Line(
          points={{10,42},{-30,-2}}),
        Line(
          points={{22,34},{-30,-2}}),
        Line(
          points={{-30,-2},{52,2}}),
        Line(
          points={{-30,-2},{56,-8}}),
        Polygon(
          points={{-34,-6},{-48,-12},{-46,-18},{-32,-20},{-10,-18},{-34,-6}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,90,0},
           pattern=LinePattern.None),
        Polygon(
          points={{-36,-6},{-70,-20},{-64,-26},{-54,-30},{-10,-18},{-32,-20},{-46,
              -18},{-48,-12},{-34,-6},{-36,-6}},
          fillColor={0,98,0},
          fillPattern=FillPattern.Solid,
           pattern=LinePattern.None),
        Ellipse(extent={{-69,-26},{69,8}}, lineColor={0,0,0}),
        Rectangle(
          extent={{-70,72},{70,-72}},
           pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={0,-6},
          rotation=360)}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>RadOnTiltedSurf</b> model uses output data of the <b><a href=
  \"AixLib.Building.Components.Weather.BaseClasses.Sun\">Sun</a></b>
  model and weather data weather data (beam and diffuse radiance on a
  horizontal surface for TRY format, or beam normal and global
  horizontal for TMY format) to compute total and beam radiance on a
  tilted surface.
</p>
<p>
  Input: It needs information on the height, the tilt angle and the
  azimut angle of the surface, the latitude of the location and the
  ground reflection coefficient.
</p>
<p>
  Output: In addition to the calculation of the irradiance on tilted
  surfaces the model has some output variables that are needed from
  other in the SunIrradiation model embedded models.
</p>
<h4>
  <span style=\"color:#008000\">Known Limitations</span>
</h4>
<p>
  Be aware that the calculation of the total solar radiation may cause
  problems at simulation times close to sunset and sunrise, because at
  this simulation times are probably the maxima of the difference
  between the calculated incedent-angle and the real angle of incedence
  at the real irradiation-time.
</p>
<p>
  Another limitation is the equation of the groundreflection
  approximation. It is only estmated on basis of the <b><a href=
  \"http://www.nrel.gov/midc/srrl_bms/\">NREL</a></b> (US National
  Renewable Energy Laboratory; http://www.nrel.gov/midc/srrl_bms) data
  for the albedo of the year 2011 and should be revised.
</p>
</html>",
    revisions="<html><ul>
  <li>
    <i>March 23, 2015&#160;</i> by Ana Constantin:<br/>
    Adapted solar inputs so it cand work with both TRY and TMY weather
    format
  </li>
  <li>
    <i>April 15, 2012&#160;</i> by Jerome Feldhaus:<br/>
    Implemented new diffuse irradiation modell from Perez Irradiation
    on tilted Surfaces.
  </li>
  <li>
    <i>March 14, 2005&#160;</i> by Timo Haase:<br/>
    Implemented.
  </li>
</ul>
</html>",
    revisions="<html>
</html>"));
end RadOnTiltedSurf_Perez;
