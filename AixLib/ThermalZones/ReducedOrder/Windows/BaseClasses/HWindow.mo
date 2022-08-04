within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model HWindow "Calculates the solar heat input through the window"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer n(min=1) "Number of windows"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g[n]
    "Total energy transmittance of windows" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g_TotDir[n] "Total energy transmittance of windows with closed sunscreen for direct
    radiation" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g_TotDif[n] "Total energy transmittance of windows with closed sunscreen for diffuse
    radiation" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Angle til[n](displayUnit="deg") "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
    roof" annotation (Dialog(group="window"));
  final parameter Modelica.Units.SI.ReflectionCoefficient rho=0.2
    "Degree of ground reflection";
  Modelica.Blocks.Interfaces.RealInput alt(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar altitude angle"
    annotation (Placement(transformation(extent={{-120,8},{-100,28}}),
        iconTransformation(extent={{-114,14},{-100,28}})));
  Modelica.Blocks.Interfaces.RealInput HDifTilCov[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface at covered sky"
    annotation (Placement(transformation(extent={{-116,-68},{-100,-52}}),
        iconTransformation(extent={{-114,-66},{-100,-52}})));
  Modelica.Blocks.Interfaces.RealInput HDifTilCle[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface at clear sky"
    annotation (Placement(transformation(extent={{-116,-88},{-100,-72}}),
        iconTransformation(extent={{-114,-86},{-100,-72}})));
  Modelica.Blocks.Interfaces.RealInput HDirNor(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Direct normal radiation."
    annotation (Placement(transformation(extent={{-122,-56},{-100,-34}}),
        iconTransformation(extent={{-114,-48},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput HDifHor(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Horizontal diffuse solar radiation."
    annotation (Placement(transformation(extent={{-116,-108},{-100,-92}}),
        iconTransformation(extent={{-114,-106},{-100,-92}})));
  Modelica.Blocks.Interfaces.RealInput HDirTil[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Direct irradition on tilted surface"
    annotation (Placement(transformation(extent={{-120,-26},{-106,-12}}),
        iconTransformation(extent={{-114,-26},{-100,-12}})));
  Modelica.Blocks.Interfaces.BooleanInput sunscreen[n]
    "True: sunscreen closed, false: sunscreen open"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-114,-6},{-100,8}})));
  Modelica.Blocks.Interfaces.RealInput corG_Dir[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Transmission coefficient correction factor for direct radiation"
    annotation (Placement(transformation(extent={{-120,86},{-100,106}}),
    iconTransformation(extent={{-114,92},{-100,106}})));
  Modelica.Blocks.Interfaces.RealInput corG_DifCle[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Transmission coefficient correction factor for diffuse radiation while
    clear sky"
    annotation (Placement(transformation(extent={{-130,68},{-110,88}}),
    iconTransformation(extent={{-114,74},{-100,88}})));
  Modelica.Blocks.Interfaces.RealInput corG_DifCov[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Transmission coefficient correction factor for diffuse radiation while
    covered sky"
    annotation (Placement(transformation(extent={{-120,48},{-100,68}}),
    iconTransformation(extent={{-114,54},{-100,68}})));
  Modelica.Blocks.Interfaces.RealInput corG_Gro[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Transmission coefficient correction factor for ground reflection radiation"
    annotation (Placement(transformation(extent={{-120,28},{-100,48}}),
    iconTransformation(extent={{-114,34},{-100,48}})));
  Modelica.Blocks.Interfaces.RealOutput HWin[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Solar radiation transmitted through aggregated window"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Units.SI.TransmissionCoefficient g_Dirx[n] "Calculation variable to determine the active total energy transmittance of
     windows for direct radiation";
  Modelica.Units.SI.TransmissionCoefficient g_Difx[n] "Calculation variable to determine the active total energy transmittance of
    windows for diffuse radiation";
equation
  for i in 1:n loop
   if sunscreen[i] then
      g_Dirx[i]=g_TotDir[i];
      g_Difx[i]=g_TotDif[i];
    else
      g_Dirx[i]=g[i];
      g_Difx[i]=g[i];
   end if;
   //Calculating HWin
    HWin[i]=(HDirTil[i]*g_Dirx[i]*corG_Dir[i]+HDifTilCov[i]*g_Difx[i]*
    corG_DifCov[i]+HDifTilCle[i]*g_Difx[i]*corG_DifCle[i]+0.5*rho*(1-
    Modelica.Math.cos(AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i])))*
    (HDirNor*Modelica.Math.sin(alt)+HDifHor)*g_Difx[i]*corG_Gro[i]);
  end for
  annotation (defaultComponentName="HWin",Icon(coordinateSystem(
  preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
  annotation (Documentation(revisions="<html><ul>
  <li>June 30, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end HWindow;
