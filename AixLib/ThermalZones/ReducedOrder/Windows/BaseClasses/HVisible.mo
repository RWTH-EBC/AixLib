within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model HVisible
  "Calculates the solar energy entering the room in the visible area"
  extends Modelica.Blocks.Icons.Block;
  import
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI;
  import Modelica.SIunits.Conversions.to_deg;
  parameter Integer n(min=1) "number of windows"
    annotation (Dialog(group="window"));

  parameter Modelica.SIunits.TransmissionCoefficient T_L[n]
    "degree of light transmission"
    annotation (Dialog(group="window"));
  parameter Modelica.SIunits.TransmissionCoefficient T_LTotDir[n]
    "degree of light transmission for direct irradiation, with sunscreen"
    annotation (Dialog(group="window"));
  parameter Modelica.SIunits.TransmissionCoefficient T_LTotDif[n]
    "degree of light transmission for diffuse irradiation, with sunscreen"
    annotation (Dialog(group="window"));

  parameter Modelica.SIunits.Angle til[n](displayUnit="deg")
    "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
    roof"
    annotation (Dialog(group="window"));
  final parameter Modelica.SIunits.ReflectionCoefficient rho=0.2
    "degree of ground reflection";

  Modelica.Blocks.Interfaces.BooleanInput sunscreen[n]
    "true: sunscreen closed, false: sunscreen open"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-114,-6},{-100,8}})));
  Modelica.Blocks.Interfaces.RealInput CorTaue_Dir[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for transluance for direct irradiation"
    annotation (Placement(transformation(extent={{-128,78},{-108,98}}),
        iconTransformation(extent={{-114,-106},{-100,-92}})));

  Modelica.Blocks.Interfaces.RealInput CorTaue_DifCle[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for transluance for diffuse irradiation during clear sky"
    annotation (Placement(transformation(extent={{-120,-92},{-100,-72}}),
        iconTransformation(extent={{-114,-86},{-100,-72}})));

  Modelica.Blocks.Interfaces.RealInput CorTaue_DifCov[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for transluance for diffuse irradiation during covered
    sky"
    annotation (Placement(transformation(extent={{-120,-72},{-100,-52}}),
        iconTransformation(extent={{-114,-66},{-100,-52}})));

  Modelica.Blocks.Interfaces.RealInput CorTaue_Gro[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for transluance for ground reflexion radiation"
    annotation (Placement(transformation(extent={{-120,-52},{-100,-32}}),
        iconTransformation(extent={{-114,-46},{-100,-32}})));
     Modelica.Blocks.Interfaces.RealInput alt(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar altitude angle"
    annotation (Placement(transformation(extent={{-120,-32},{-100,-12}}),
        iconTransformation(extent={{-114,-26},{-100,-12}})));

   Modelica.Blocks.Interfaces.RealInput HDirTil[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Direct irradition on tilted surface"
    annotation (Placement(transformation(extent={{-114,76},{-100,90}}),
        iconTransformation(extent={{-114,76},{-100,90}})));

   Modelica.Blocks.Interfaces.RealInput HDirNor(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Direct normal radiation."
    annotation (Placement(transformation(extent={{-122,84},{-100,106}}),
        iconTransformation(extent={{-114,92},{-100,106}})));

 Modelica.Blocks.Interfaces.RealInput HDifHorCov(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Horizontal diffuse solar radiation at covered sky."
    annotation (Placement(transformation(extent={{-116,26},{-100,42}}),
        iconTransformation(extent={{-114,28},{-100,42}})));

  Modelica.Blocks.Interfaces.RealInput HDifHorCle(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Horizontal diffuse solar radiation at clear sky."
    annotation (Placement(transformation(extent={{-116,10},{-100,26}}),
        iconTransformation(extent={{-114,12},{-100,26}})));

  Modelica.Blocks.Interfaces.RealInput HDifTilCov[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface at covered
    sky"
    annotation (Placement(transformation(extent={{-116,42},{-100,58}}),
        iconTransformation(extent={{-114,44},{-100,58}})));
  Modelica.Blocks.Interfaces.RealInput HDifTilCle[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface at clear sky"
    annotation (Placement(transformation(extent={{-116,58},{-100,74}}),
        iconTransformation(extent={{-114,60},{-100,74}})));

  Modelica.Blocks.Interfaces.RealOutput HVis[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "solar energy entering the room in the visible area"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

protected
  parameter Real Cor_KMDifCov=1
    "correction factor for diffuse irradiation at uniformly overcast skies
    according to DIN 5034-2";
  Real Cor_KMDir
    "correction factor for direct solar irradiation according to DIN 5034-2";
  Real Cor_KMDifCle
    "correction factor for diffuse irradiation at cloudless clear skies
    according to DIN 5034-2";
  Modelica.SIunits.TransmissionCoefficient T_LDifx[n]
    "calculation variable for the degree of light transmission for diffuse
    irradiation";
  Modelica.SIunits.TransmissionCoefficient T_LDirx[n]
    "calculation variable for the degree of light transmission for direct
    irradiation";
  Modelica.SIunits.EnergyFlowRate H_EvaHor[n]
    "evaluated solar irradiation onto the horizontal for determining the ground
     reflexion radiation";

equation
  //calculating H_RoomL
  Cor_KMDir=(17.72+4.4585*to_deg(alt)-0.087563*to_deg(alt)^2+7.39487*10^(-4)
  *to_deg(alt)^3-2.167*10^(-6)*to_deg(alt)^4-8.4132*10^(-10)*to_deg(alt)^5)/115;
  Cor_KMDifCle=(15.1+3.1076*to_deg(alt)+0.0048*to_deg(alt)^2-0.0014*
  to_deg(alt)^3+2.04*10^(-5)*to_deg(alt)^4-8.91*10^(-8)*to_deg(alt)^5)/115;

  for i in 1:n loop
    if sunscreen[i] then
      T_LDifx[i]=T_LTotDif[i];
      T_LDirx[i]=T_LTotDir[i];
    else
      T_LDifx[i]=T_L[i];
      T_LDirx[i]=T_L[i];
    end if;
    H_EvaHor[i]=(HDirNor*Cor_KMDir*Modelica.Math.sin(alt)+HDifHorCle
    *Cor_KMDifCle+HDifHorCov*Cor_KMDifCov)*T_LDifx[i];
    HVis[i]=(HDirTil[i]*T_LDirx[i]*CorTaue_Dir[i]*Cor_KMDir+HDifTilCle[i]*
    T_LDifx[i]*CorTaue_DifCle[i]*Cor_KMDifCle+HDifTilCov[i]*T_LDifx[i]*
    CorTaue_DifCov[i]*Cor_KMDifCov+H_EvaHor[i]*0.5*rho*(1-Modelica.Math.cos(
    to_surfaceTiltVDI(til[i])))*CorTaue_Gro[i]);
  end for;
    annotation (defaultComponentName="HVis",Icon(coordinateSystem(
    preserveAspectRatio=false)), Diagram(coordinateSystem(
    preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics),
    Documentation(revisions="<html>
<ul>
<li>June 30, 2016,&nbsp; by Stanley Risch:<br>Implemented. </li>
</html>"));
end HVisible;
