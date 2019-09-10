within AixLib.Electrical.PVSystem;
package BaseClasses
        extends Modelica.Icons.BasesPackage;


  partial model PartialIVCharacteristics

   connector PVModuleData = input AixLib.DataBase.SolarElectric.PVBaseRecordNew
      "Connector for PV record data" annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            origin={0.0,-25.0},
            lineColor={64,64,64},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-75.0},{100.0,75.0}},
            radius=25.0),
          Line(
            points={{-100.0,0.0},{100.0,0.0}},
            color={64,64,64}),
          Line(
            origin={0.0,-50.0},
            points={{-100.0,0.0},{100.0,0.0}},
            color={64,64,64}),
          Line(
            origin={0.0,-25.0},
            points={{0.0,75.0},{0.0,-75.0}},
            color={64,64,64})}));


  // Adjustable input parameters

   PVModuleData data
      "PV module record"
      annotation (Placement(transformation(extent={{-140,-16},{-100,24}}),
      iconTransformation(extent={{-142,-18},{-100,28}})));

   parameter Real n_mod(final quantity=
      "NumberOfModules", final unit="1") "Number of connected PV modules"
      annotation ();

   Modelica.Blocks.Interfaces.RealInput T_c(final quantity=
      "ThermodynamicTemperature", final unit="K")
      "Cell temperature"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent={{-140,20},{-100,60}})));

   Modelica.Blocks.Interfaces.RealInput absRadRat(final unit= "1")
      "Ratio of absorbed radiation under operating conditions to standard conditions"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(extent={{-140,-60},{-100,-20}})));

   Modelica.Blocks.Interfaces.RealInput radTil(final unit="W/m2")
      "total solar irradiance on the tilted surface"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(extent={{-140,-100},{-100,
              -60}})));



  // Parameters from module data sheet

   parameter Modelica.SIunits.Efficiency eta_0=data.eta_0
      "Efficiency under standard conditions";

   parameter Real n_ser=data.n_ser
      "Number of cells connected in series on the PV panel";

   parameter Modelica.SIunits.Area A_pan = data.A_pan
      "Area of one Panel, must not be confused with area of the whole module";

   parameter Modelica.SIunits.Area A_mod = data.A_mod
      "Area of one module (housing)";

   parameter Modelica.SIunits.Voltage V_oc0=data.V_oc0
      "Open circuit voltage under standard conditions";

   parameter Modelica.SIunits.ElectricCurrent I_sc0=data.I_sc0
      "Short circuit current under standard conditions";

   parameter Modelica.SIunits.Voltage V_mp0=data.V_mp0
      "MPP voltage under standard conditions";

   parameter Modelica.SIunits.ElectricCurrent I_mp0=data.I_mp0
      "MPP current under standard conditions";

   parameter Real TCoeff_Isc(unit = "A/K")=data.TCoeff_Isc
      "Temperature coefficient for short circuit current, >0";

   parameter Real TCoeff_Voc(unit = "V/K")=data.TCoeff_Voc
      "Temperature coefficient for open circuit voltage, <0";

   parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_Isc= data.alpha_Isc
      "Normalized temperature coefficient for short circuit current, >0";

   parameter Modelica.SIunits.LinearTemperatureCoefficient beta_Voc = data.beta_Voc
      "Normalized temperature coefficient for open circuit voltage, <0";

   parameter Modelica.SIunits.LinearTemperatureCoefficient gamma_Pmp=data.gamma_Pmp
      "Normalized temperature coefficient for power at MPP";

   final parameter Modelica.SIunits.Temp_K T_c0=25+273.15
      "Thermodynamic cell temperature under standard conditions";




   Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
    final quantity="Power",
    final unit="W")
    "DC output power of the PV array"
    annotation(Placement(
    transformation(extent={{100,50},{120,70}}),
    iconTransformation(extent={{100,50},{120,70}})));


   Modelica.Blocks.Interfaces.RealOutput eta(
    final quantity="Efficiency",
    final unit="1",
    min=0)
    "Efficiency of the PV module under operating conditions"
    annotation(Placement(
    transformation(extent={{100,-70},{120,-50}}),
    iconTransformation(extent={{100,-70},{120,-50}})));


    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
       Rectangle(
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{-100,100},{100,-100}}),
       Text(
        lineColor={0,0,0},
        extent={{-96,95},{97,-97}},
            textString="I-V")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end PartialIVCharacteristics;

  block PVModule5pNumericalPreCalc
    "Block that determines the main parameters of the numerical 5p approach (De Soto et al.,2006)"


   constant Real e=Modelica.Math.exp(1.0)
     "Euler's constant";
   constant Real pi=Modelica.Constants.pi
     "Pi";
   constant Real k(final unit="J/K") = 1.3806503e-23
     "Boltzmann's constant";
   constant Real q( unit = "A.s")= 1.602176620924561e-19
     "Electron charge";


  connector PVModuleData = input AixLib.DataBase.SolarElectric.PVBaseRecordNew;

  PVModuleData data;

   parameter Modelica.SIunits.Voltage V_oc0=data.V_oc0
      "Open circuit voltage under standard conditions";
   parameter Modelica.SIunits.ElectricCurrent I_sc0=data.I_sc0
      "Short circuit current under standard conditions";
   parameter Modelica.SIunits.Voltage V_mp0=data.V_mp0
      "MPP voltage under standard conditions";
   parameter Modelica.SIunits.ElectricCurrent I_mp0=data.I_mp0
      "MPP current under standard conditions";
   parameter Real TCoeff_Isc(unit = "A/K")=data.TCoeff_Isc
      "Temperature coefficient for short circuit current, >0";
   parameter Real TCoeff_Voc(unit = "V/K")=data.TCoeff_Voc
      "Temperature coefficient for open circuit voltage, <0";
   parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_Isc= data.alpha_Isc
      "Normalized temperature coefficient for short circuit current, >0";
   parameter Modelica.SIunits.LinearTemperatureCoefficient beta_Voc = data.beta_Voc
      "Normalized temperature coefficient for open circuit voltage, <0";
   parameter Modelica.SIunits.Temp_K T_c0=25+273.15
      "Thermodynamic cell temperature under standard conditions";


    //Initial parameter values from analytical approach (Batzelis, 2016)

    parameter Real a_0start( unit = "V") = V_oc0*(1-T_c0*beta_Voc)/(50.1-T_c0*alpha_Isc);
    parameter Real w_0 = AixLib.Electrical.PVSystem.BaseClasses.Wsimple(exp(1/(a_0start/V_oc0)+1));
    parameter Modelica.SIunits.Resistance R_s0start = (a_0start*(w_0-1)-V_mp0)/I_mp0;
    parameter Modelica.SIunits.Resistance R_sh0start = a_0start*(w_0-1)/(I_sc0*(1-1/w_0)-I_mp0);
    parameter Modelica.SIunits.ElectricCurrent I_ph0start = (1+R_s0start/R_sh0start)*I_sc0;
    parameter Modelica.SIunits.ElectricCurrent I_s0start = I_ph0start*exp(-1/(a_0start/V_oc0));
    parameter Modelica.SIunits.Temp_K T_c30=30+273.15;


     Modelica.Blocks.Interfaces.RealOutput I_ph0(start=I_ph0start)
      "Photo current under standard conditions";
     Modelica.Blocks.Interfaces.RealOutput I_s0(start= I_s0start)
      "Saturation current under standard conditions";
     Modelica.Blocks.Interfaces.RealOutput R_s0(start= R_s0start)
      "Series resistance under standard conditions";
     Modelica.Blocks.Interfaces.RealOutput R_sh0(start= R_sh0start)
      "Shunt resistance under standard conditions";
     Modelica.Blocks.Interfaces.RealOutput a_0(unit = "V", start= a_0start)
      "Modified diode ideality factor under standard conditions";

      parameter Modelica.SIunits.Energy E_g0=1.79604e-19
      "Band gap energy under standard conditions for Si";
      parameter Real C=0.0002677
      "band gap temperature coefficient for Si";


      Modelica.SIunits.Voltage V_oc30(start=(beta_Voc*(T_c30-T_c0)+1)*V_oc0)
      "Open circuit voltage at 30 °C";
      Modelica.SIunits.ElectricCurrent I_ph30(start=(I_ph0start+TCoeff_Isc*(T_c30-T_c0)))
      "Photo current at 30 °C";
      Modelica.SIunits.ElectricCurrent I_s30(start=I_s0start*((T_c30/T_c0)^3*exp(1/k*(E_g0/T_c0-(E_g0*(1-C*(T_c30-T_c0)))/T_c30))))
      "Saturation current at 30 °C";
      Real a_30(unit = "V", start=((beta_Voc*(T_c30-T_c0)+1)*V_oc0)*(1-T_c30*beta_Voc)/(50.1-T_c30*alpha_Isc))
      "Modified diode ideality factor at 30 °C";
      Modelica.SIunits.Resistance R_sh30(start=R_sh0start)
      "Shunt resistance at 30 °C";
      Modelica.SIunits.Energy E_g30
      "Band gap energy at 30 °C";


  equation



  I_sc0 = I_ph0-I_s0*(exp(I_sc0*R_s0/a_0)-1)-I_sc0*R_s0/R_sh0;
  I_ph0 = I_s0*(exp(V_oc0/a_0)-1)+V_oc0/R_sh0;
  I_mp0 = I_ph0 - I_s0*(exp((V_mp0+I_mp0*R_s0)/a_0)-1)-(V_mp0+I_mp0*R_s0)/R_sh0;
  I_mp0/V_mp0 = (I_s0/a_0*exp((V_mp0+I_mp0*R_s0)/a_0)+1/R_sh0)/(1+I_s0*R_s0/a_0*exp((V_mp0+I_mp0*R_s0)/a_0)+R_s0/R_sh0);
  TCoeff_Voc =(V_oc30-V_oc0)/(T_c30-T_c0);

  I_ph30 = I_s30*(exp(V_oc30/a_30)-1)+V_oc30/R_sh30;
  a_30/a_0 = T_c30/T_c0;
  I_s30/I_s0 = (T_c30/T_c0)^3*exp(1/k*(E_g0/T_c0-E_g30/T_c30));
  E_g30/E_g0 = 1-C*(T_c30-T_c0);
  I_ph30 = (I_ph0+TCoeff_Isc*(T_c30-T_c0));
  R_sh0/R_sh30 = 1;



    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end PVModule5pNumericalPreCalc;

  model PVRadiationHorizontal "PV radiation and absorptance model - input: total irradiance on horizontal plane"


   Real nDay(final quantity="Time",final unit="s")
      "Day number with units of seconds";

   parameter Real lat(final quantity = "Angle",
     final unit = "rad",
     displayUnit = "deg") "Latitude"
     annotation ();

   parameter Real lon(final quantity = "Angle",
     final unit = "rad",
     displayUnit = "deg") "Longitude"
     annotation ();

   parameter Real  alt(final quantity="Length", final unit="m")
     "Site altitude in Meters, default= 1"
     annotation ();

   parameter Real til(final quantity = "Angle",
     final unit = "rad",
     displayUnit = "deg")
     "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for roof"
     annotation ();

   parameter Real  azi(final quantity = "Angle",
     final unit = "rad",
     displayUnit = "deg")
     "Module surface azimuth. azi=-90 degree if normal of surface outward unit points towards east; azi=0 if it points towards south"
     annotation ();

    Real cloTim(final quantity="Time",
     final unit="s", displayUnit="h")
     "Local clock time";

   parameter Real timZon(final quantity="Time",
     final unit="s", displayUnit="h")
     "Time zone in seconds relative to GMT"
     annotation ();

   parameter Real groRef(final unit="1")
     "Ground refelctance"
     annotation ();

   Real radHorBea(final quantity="Irradiance",
     final unit= "W/m2")
     "Beam solar radiation on the horizontal surface";

   Real radHorDif(final quantity="Irradiance",
     final unit= "W/m2")
     "Diffuse solar radiation on the horizontal surface";


  // Air mass parameters for mono-SI
    parameter Real b_0=0.935823;
    parameter Real b_1=0.054289;
    parameter Real b_2=-0.008677;
    parameter Real b_3=0.000527;
    parameter Real b_4=-0.000011;


   parameter Real radTil0(final quantity="Irradiance",
    final unit= "W/m2") = 1000 "total solar radiation on the horizontal surface under standard conditions";


   parameter Real G_sc(final quantity="Irradiance",
    final unit = "W/m2") = 1376 "Solar constant";

   Real k_t(final unit="1", start=0.5)
    "Clearness index";

   Real airMas(final unit="1", min=0)
    "Air mass";

   Real airMasMod(final unit="1", min=0)
    "Air mass modifier";

   Modelica.SIunits.Angle incAngGro
    "Incidence angle for ground reflection";

   Modelica.SIunits.Angle incAngDif
    "Incidence angle for diffuse radiation";

   Real incAngMod(final unit="1", min=0)
    "Incidence angle modifier";

   Real incAngModGro(final unit="1", min=0)
    "Incidence angle modifier for ground refelction";

   Real incAngModDif(final unit="1", min=0)
    "Incidence angle modifier for diffuse radiation";

   Modelica.SIunits.Angle refAng
    "Angle of refraction";

   Modelica.SIunits.Angle refAngGro
    "Angle of refraction for ground reflection";

   Modelica.SIunits.Angle refAngDif
    "Angle of refraction for diffuse irradiation";

   parameter Real tau_0(final unit="1", min=0)=
     exp(-(glaExtCoe*glaThi))*(1 - ((refInd - 1)/(refInd + 1))
    ^2) "Transmittance at standard conditions (incAng=refAng=0)";

   Real tau(final unit="1", min=0)
    "Transmittance of the cover system";

   Real tau_ground(final unit="1", min=0)
    "Transmittance of the cover system for ground reflection";

   Real tau_diff(final unit="1", min=0)
    "Transmittance of the cover system for diffuse radiation";

   parameter Real glaExtCoe(final unit="1/m") = 4
    "Glazing extinction coefficient for glass";

   parameter Real glaThi(final unit="m") = 0.002
    "Glazing thickness for most PV cell panels";

   parameter Real refInd(final unit="1", min=0) = 1.526
    "Effective index of refraction of the cell cover (glass)";

   Real R_b(final unit="1", min=0)
     "Ratio of irradiance on tilted surface to horizontal surface";

   Modelica.Blocks.Interfaces.RealInput radHor(final quantity="Irradiance",
     final unit= "W/m2")
     "Total solar irradiance on the horizontal surface"
     annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

   Modelica.SIunits.Angle zen
    "Zenith angle";

   AixLib.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle
      solHouAng
      "Solar hour angle";

   AixLib.BoundaryConditions.WeatherData.BaseClasses.LocalCivilTime locTim(
      timZon=timZon,
      lon=lon)
      "Block that computes the local civil time";

   AixLib.BoundaryConditions.WeatherData.BaseClasses.SolarTime solTim
      "Block that computes the solar time";

   AixLib.BoundaryConditions.WeatherData.BaseClasses.EquationOfTime eqnTim
      "Block that computes the equation of time";

   AixLib.BoundaryConditions.SolarGeometry.BaseClasses.DeclinationSpencer decAng
      "Declination angle";

   AixLib.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngleDuffie incAng(
     azi=azi,
     til=til,
     lat=lat) "Incidence angle";

   AixLib.BoundaryConditions.SolarGeometry.BaseClasses.ZenithAngle zenAng(
     lat=lat) "Zenith angle";

   Utilities.Time.ModelTime modTim "Block that outputs simulation time";


   Modelica.Blocks.Interfaces.RealOutput radTil(final quantity="Irradiance",
     final unit= "W/m2")
     "Total solar radiation on the tilted surface"
     annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

   Modelica.Blocks.Interfaces.RealOutput absRadRat(final unit= "1", min=0)
     "Ratio of absorbed radiation under operating conditions to standard conditions"
     annotation (Placement(transformation(extent={{100,50},{120,70}})));

  equation

   connect(solTim.solTim, solHouAng.solTim);

   connect(locTim.locTim, solTim.locTim);

   connect(eqnTim.eqnTim, solTim.equTim);

   connect(decAng.decAng, incAng.decAng);

   connect(solHouAng.solHouAng, incAng.solHouAng);

   connect(decAng.decAng, zenAng.decAng);

   connect(solHouAng.solHouAng, zenAng.solHouAng);

   nDay = floor(modTim.y/86400)*86400
    "Zero-based day number in seconds (January 1=0, January 2=86400)";

   cloTim= modTim.y-nDay;

   eqnTim.nDay= nDay;

   locTim.cloTim=cloTim;

   decAng.nDay= nDay;

   zen = if zenAng.zen <= Modelica.Constants.pi/2 then
   zenAng.zen
   else
   Modelica.Constants.pi/2
   "Restriction for zenith angle";



    refAng = if (incAng.incAng >= 0.0001 and incAng.incAng <= Modelica.Constants.pi
    /2*0.999) then asin(sin(incAng.incAng)/refInd) else
    0;

    refAngGro = if (incAngGro >= 0.0001 and incAngGro <= Modelica.Constants.pi/2*
    0.999) then asin(sin(incAngGro)/refInd) else
    0;

    refAngDif = if (incAngDif >= 0.0001 and incAngDif <= Modelica.Constants.pi/2*
    0.999) then asin(sin(incAngDif)/refInd) else
    0;

    tau = if (incAng.incAng >= 0.0001 and incAng.incAng <= Modelica.Constants.pi/
    2*0.999 and refAng >= 0.0001) then exp(-(glaExtCoe*glaThi/cos(refAng)))*(1
    - 0.5*((sin(refAng - incAng.incAng)^2)/(sin(refAng + incAng.incAng)^2) + (
    tan(refAng - incAng.incAng)^2)/(tan(refAng + incAng.incAng)^2))) else
    0;

    tau_ground = if (incAngGro >= 0.0001 and refAngGro >= 0.0001) then exp(-(
    glaExtCoe*glaThi/cos(refAngGro)))*(1 - 0.5*((sin(refAngGro - incAngGro)^2)/
    (sin(refAngGro + incAngGro)^2) + (tan(refAngGro - incAngGro)^2)/(tan(
    refAngGro + incAngGro)^2))) else
    0;

    tau_diff = if (incAngDif >= 0.0001 and refAngDif >= 0.0001) then exp(-(
    glaExtCoe*glaThi/cos(refAngDif)))*(1 - 0.5*((sin(refAngDif - incAngDif)^2)/
    (sin(refAngDif + incAngDif)^2) + (tan(refAngDif - incAngDif)^2)/(tan(
    refAngDif + incAngDif)^2))) else
    0;


    incAngMod = tau/tau_0;

    incAngModGro = tau_ground/tau_0;

    incAngModDif = tau_diff/tau_0;


    airMasMod = if (b_0 + b_1*(airMas^1) + b_2*(airMas^2) + b_3*(
    airMas^3) + b_4*(airMas^4)) <= 0 then
    0 else
    b_0 + b_1*(airMas^1) + b_2*(airMas^2) + b_3*(airMas^3) + b_4*(airMas^4);



    airMas = exp(-0.0001184*alt)/(cos(zen) + 0.5057*(96.080 - zen*
    180/Modelica.Constants.pi)^(-1.634));

    incAngGro = (90 - 0.5788*til*180/Modelica.Constants.pi + 0.002693*(til*180/
    Modelica.Constants.pi)^2)*Modelica.Constants.pi/180;

    incAngDif = (59.7 - 0.1388*til*180/Modelica.Constants.pi + 0.001497*(til*180/
    Modelica.Constants.pi)^2)*Modelica.Constants.pi/180;



    R_b = if ((zen >= Modelica.Constants.pi/2*0.999) or (cos(incAng.incAng)
    > cos(zen)*4)) then 4 else (cos(incAng.incAng)/cos(zen));


    radHor = radHorBea + radHorDif;

    radTil = if radHor <= 0.1 then 0 else radHorBea*R_b + radHorDif*(0.5*(1 + cos(
    til)*(1 + (1 - (radHorDif/radHor)^2)*sin(til/2)^3)*(1 + (1 - (radHorDif/
    radHor)^2)*(cos(incAng.incAng)^2)*(cos(til)^3)))) + radHor*groRef*(1 - cos(
    til))/2;

    k_t = if radHor <=0 then 0
    else
    (radHor)/(G_sc*(1.00011+0.034221*cos(2*Modelica.Constants.pi*nDay/24/60/60/365)+0.00128*sin(2*Modelica.Constants.pi*nDay/24/60/60/365)
    +0.000719*cos(2*2*Modelica.Constants.pi*nDay/24/60/60/365)+0.000077*sin(2*2*Modelica.Constants.pi*nDay/24/60/60/365))*cos(zenAng.zen)) "after (Iqbal,1983)";



  // Erb´s diffuse fraction relation
    radHorDif = if radHor <=0 then 0
    elseif
         k_t <= 0.22 then
    (radHor)*(1.0-0.09*k_t)
     elseif
         k_t > 0.8 then
    (radHor)*0.165
     else
    (radHor)*(0.9511-0.1604*k_t+4.388*k_t^2-16.638*k_t^3+12.336*k_t^4);




    absRadRat = if (radHor <=0.1) then 0
    else
    airMasMod*(radHorBea/radTil0*R_b*incAngMod
    +radHorDif/radTil0*incAngModDif*(0.5*(1+cos(til)*(1+(1-(radHorDif/radHor)^2)*sin(til/2)^3)*(1+(1-(radHorDif/radHor)^2)*(cos(incAng.incAng)^2)*(cos(til)^3))))
    +radHor/radTil0*groRef*incAngModGro*(1-cos(til))/2);


    annotation (Icon(graphics={   Bitmap(extent={{-90,-90},{90,90}}, fileName=
                "modelica://AixLib/Resources/Images/BoundaryConditions/SolarGeometry/BaseClasses/IncidenceAngle.png")}),
                Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Model for determining Irradiance and absorptance ratio for PV modules - input: total irradiance on horizontal plane.</p>
<p><br/>
<h4><span style=\"color: #008000\">References</span></h4>
<p><q>Solar engineering of thermal processes.</q> by Duffie, John A. ; Beckman, W. A.</p>
<p><q>Regenerative Energiesysteme: Technologie ; Berechnung ; Simulation</q> by Quaschning, Volker:</p>
</ul>
</html>
"));
  end PVRadiationHorizontal;
end BaseClasses;
