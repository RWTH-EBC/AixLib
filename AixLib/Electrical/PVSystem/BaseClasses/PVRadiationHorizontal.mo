within AixLib.Electrical.PVSystem.BaseClasses;
model PVRadiationHorizontal "PV radiation and absorptance model - input: total irradiance on horizontal plane"

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

 parameter Real timZon(final quantity="Time",
   final unit="s", displayUnit="h")
   "Time zone in seconds relative to GMT"
   annotation ();

 parameter Real groRef(final unit="1") "Ground refelctance"
   annotation ();

 // Air mass parameters for mono-SI
  parameter Real b_0=0.935823;
  parameter Real b_1=0.054289;
  parameter Real b_2=-0.008677;
  parameter Real b_3=0.000527;
  parameter Real b_4=-0.000011;

  parameter Real radTil0(final quantity="Irradiance",
  final unit= "W/m2") = 1000 "total solar radiation on the horizontal surface 
  under standard conditions";


  parameter Real G_sc(final quantity="Irradiance",
  final unit = "W/m2") = 1376 "Solar constant";

  parameter Real glaExtCoe(final unit="1/m") = 4
  "Glazing extinction coefficient for glass";

  parameter Real glaThi(final unit="m") = 0.002
  "Glazing thickness for most PV cell panels";

  parameter Real refInd(final unit="1", min=0) = 1.526
  "Effective index of refraction of the cell cover (glass)";

  parameter Real tau_0(final unit="1", min=0)=
   exp(-(glaExtCoe*glaThi))*(1 - ((refInd - 1)/(refInd + 1))
  ^2) "Transmittance at standard conditions (incAng=refAng=0)";

  Real cloTim(final quantity="Time",
   final unit="s", displayUnit="h")
   "Local clock time";

  Real nDay(final quantity="Time",final unit="s")
    "Day number with units of seconds";

  Real radHorBea(final quantity="Irradiance",
   final unit= "W/m2")
   "Beam solar radiation on the horizontal surface";

  Real radHorDif(final quantity="Irradiance",
   final unit= "W/m2")
   "Diffuse solar radiation on the horizontal surface";

  Real k_t(final unit="1", start=0.5) "Clearness index";

  Real airMas(final unit="1", min=0) "Air mass";

  Real airMasMod(final unit="1", min=0) "Air mass modifier";

  Modelica.Units.SI.Angle incAngGro "Incidence angle for ground reflection";

  Modelica.Units.SI.Angle incAngDif "Incidence angle for diffuse radiation";

  Real incAngMod(final unit="1", min=0) "Incidence angle modifier";

  Real incAngModGro(final unit="1", min=0) "Incidence angle modifier for ground refelction";

  Real incAngModDif(final unit="1", min=0)
  "Incidence angle modifier for diffuse radiation";

  Modelica.Units.SI.Angle refAng "Angle of refraction";

  Modelica.Units.SI.Angle refAngGro "Angle of refraction for ground reflection";

  Modelica.Units.SI.Angle refAngDif
    "Angle of refraction for diffuse irradiation";

  Real tau(final unit="1", min=0)
  "Transmittance of the cover system";

  Real tau_ground(final unit="1", min=0)
  "Transmittance of the cover system for ground reflection";

  Real tau_diff(final unit="1", min=0)
  "Transmittance of the cover system for diffuse radiation";

  Real R_b(final unit="1", min=0)
   "Ratio of irradiance on tilted surface to horizontal surface";


  Modelica.Units.SI.Angle zen "Zenith angle";

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

  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng
    "Declination angle";

  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incAng(
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

  Modelica.Blocks.Interfaces.RealInput radHor(final quantity="Irradiance",
   final unit= "W/m2")
   "Total solar irradiance on the horizontal surface"
   annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

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


  refAng = if noEvent(incAng.incAng >= 0.0001 and incAng.incAng <= Modelica.Constants.pi
  /2*0.999) then asin(sin(incAng.incAng)/refInd) else
  0;

  refAngGro = if noEvent(incAngGro >= 0.0001 and incAngGro <= Modelica.Constants.pi/2*
  0.999) then asin(sin(incAngGro)/refInd) else
  0;

  refAngDif = if noEvent(incAngDif >= 0.0001 and incAngDif <= Modelica.Constants.pi/2*
  0.999) then asin(sin(incAngDif)/refInd) else
  0;

  tau = if noEvent(incAng.incAng >= 0.0001 and incAng.incAng <= Modelica.Constants.pi/
  2*0.999 and refAng >= 0.0001) then exp(-(glaExtCoe*glaThi/cos(refAng)))*(1
  - 0.5*((sin(refAng - incAng.incAng)^2)/(sin(refAng + incAng.incAng)^2) + (
  tan(refAng - incAng.incAng)^2)/(tan(refAng + incAng.incAng)^2))) else
  0;

  tau_ground = if noEvent(incAngGro >= 0.0001 and refAngGro >= 0.0001) then exp(-(
  glaExtCoe*glaThi/cos(refAngGro)))*(1 - 0.5*((sin(refAngGro - incAngGro)^2)/
  (sin(refAngGro + incAngGro)^2) + (tan(refAngGro - incAngGro)^2)/(tan(
  refAngGro + incAngGro)^2))) else
  0;

  tau_diff = if noEvent(incAngDif >= 0.0001 and refAngDif >= 0.0001) then exp(-(
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



  R_b = if noEvent((zen >= Modelica.Constants.pi/2*0.999) or (cos(incAng.incAng)
  > cos(zen)*4)) then 4 else (cos(incAng.incAng)/cos(zen));


  radHor = radHorBea + radHorDif;

  radTil = if noEvent(radHor <= 0.1) then 0 else radHorBea*R_b + radHorDif*(0.5*(1 + cos(
  til)*(1 + (1 - (radHorDif/radHor)^2)*sin(til/2)^3)*(1 + (1 - (radHorDif/
  radHor)^2)*(cos(incAng.incAng)^2)*(cos(til)^3)))) + radHor*groRef*(1 - cos(
  til))/2;

  k_t = if noEvent(radHor <=0.001) then 0
  else
  min(1,max(0,(radHor)/(G_sc*(1.00011+0.034221*cos(2*Modelica.Constants.pi*nDay/24/60/60/365)+0.00128*sin(2*Modelica.Constants.pi*nDay/24/60/60/365)
  +0.000719*cos(2*2*Modelica.Constants.pi*nDay/24/60/60/365)+0.000077*sin(2*2*Modelica.Constants.pi*nDay/24/60/60/365))*cos(zenAng.zen)))) "after (Iqbal,1983)";


// Erb´s diffuse fraction relation
  radHorDif = if radHor <=0.001 then 0
  elseif
       k_t <= 0.22 then
  (radHor)*(1.0-0.09*k_t)
   elseif
       k_t > 0.8 then
  (radHor)*0.165
   else
  (radHor)*(0.9511-0.1604*k_t+4.388*k_t^2-16.638*k_t^3+12.336*k_t^4);


  absRadRat = if noEvent(radHor <=0.1) then 0
  else
  airMasMod*(radHorBea/radTil0*R_b*incAngMod
  +radHorDif/radTil0*incAngModDif*(0.5*(1+cos(til)*(1+(1-(radHorDif/radHor)^2)*sin(til/2)^3)*(1+(1-(radHorDif/radHor)^2)*(cos(incAng.incAng)^2)*(cos(til)^3))))
  +radHor/radTil0*groRef*incAngModGro*(1-cos(til))/2);


  annotation (Icon(graphics={   Bitmap(extent={{-90,-90},{90,90}}, fileName=
              "modelica://AixLib/Resources/Images/BoundaryConditions/SolarGeometry/BaseClasses/IncidenceAngle.png")}),
              Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Model for determining Irradiance and absorptance ratio for PV modules
  - input: total irradiance on horizontal plane.
</p>
<p>
  <br/>
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  <q>Solar engineering of thermal processes.</q> by Duffie, John A. ;
  Beckman, W. A.
</p>
<p>
  <q>Regenerative Energiesysteme: Technologie ; Berechnung ;
  Simulation</q> by Quaschning, Volker:
</p>
</html>
"));
end PVRadiationHorizontal;
