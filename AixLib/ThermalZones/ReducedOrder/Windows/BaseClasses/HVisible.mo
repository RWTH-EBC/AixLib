within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model HVisible
  "Calculates the solar energy entering the room in the visible area"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer n(min=1) "Number of windows"
    annotation (Dialog(group="window"));

  parameter Modelica.Units.SI.TransmissionCoefficient tau_vis[n]
    "Degree of light transmission" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient tau_visTotDir[n]
    "Degree of light transmission for direct irradiation, with sunscreen"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient tau_visTotDif[n]
    "Degree of light transmission for diffuse irradiation, with sunscreen"
    annotation (Dialog(group="window"));

  parameter Modelica.Units.SI.Angle til[n](displayUnit="deg") "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
    roof" annotation (Dialog(group="window"));
  final parameter Modelica.Units.SI.ReflectionCoefficient rho=0.2
    "Degree of ground reflection";

  Modelica.Blocks.Interfaces.BooleanInput sunscreen[n]
    "True: sunscreen closed, false: sunscreen open"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-114,-6},{-100,8}})));
  Modelica.Blocks.Interfaces.RealInput corTaue_Dir[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for direct irradiation"
    annotation (Placement(transformation(extent={{-128,78},{-108,98}}),
        iconTransformation(extent={{-114,-106},{-100,-92}})));

  Modelica.Blocks.Interfaces.RealInput corTaue_DifCle[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for diffuse irradiation during clear sky"
    annotation (Placement(transformation(extent={{-120,-92},{-100,-72}}),
        iconTransformation(extent={{-114,-86},{-100,-72}})));

  Modelica.Blocks.Interfaces.RealInput corTaue_DifCov[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for diffuse irradiation during covered
    sky"
    annotation (Placement(transformation(extent={{-120,-72},{-100,-52}}),
        iconTransformation(extent={{-114,-66},{-100,-52}})));

  Modelica.Blocks.Interfaces.RealInput corTaue_Gro[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for ground reflection radiation"
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
    "Correction factor for diffuse irradiation at uniformly overcast skies
    according to DIN 5034-2";
  Real Cor_KMDir
    "Correction factor for direct solar irradiation according to DIN 5034-2";
  Real Cor_KMDifCle
    "Correction factor for diffuse irradiation at cloudless clear skies
    according to DIN 5034-2";
  Modelica.Units.SI.TransmissionCoefficient tau_visDifx[n] "Calculation variable for the degree of light transmission for diffuse
    irradiation";
  Modelica.Units.SI.TransmissionCoefficient tau_visDirx[n] "Calculation variable for the degree of light transmission for direct
    irradiation";
  Modelica.Units.SI.EnergyFlowRate H_EvaHor[n] "Evaluated solar irradiation onto the horizontal for determining the ground
     reflection radiation";

equation
  //calculating H_RoomL
  Cor_KMDir=(17.72 + 4.4585*Modelica.Units.Conversions.to_deg(alt) - 0.087563*
    Modelica.Units.Conversions.to_deg(alt)^2 + 7.39487*10^(-4)*
    Modelica.Units.Conversions.to_deg(alt)^3 - 2.167*10^(-6)*
    Modelica.Units.Conversions.to_deg(alt)^4 - 8.4132*10^(-10)*
    Modelica.Units.Conversions.to_deg(alt)^5)/115;
  Cor_KMDifCle=(15.1 + 3.1076*Modelica.Units.Conversions.to_deg(alt) + 0.0048*
    Modelica.Units.Conversions.to_deg(alt)^2 - 0.0014*
    Modelica.Units.Conversions.to_deg(alt)^3 + 2.04*10^(-5)*
    Modelica.Units.Conversions.to_deg(alt)^4 - 8.91*10^(-8)*
    Modelica.Units.Conversions.to_deg(alt)^5)/115;

  for i in 1:n loop
    if sunscreen[i] then
      tau_visDifx[i]=tau_visTotDif[i];
      tau_visDirx[i]=tau_visTotDir[i];
    else
      tau_visDifx[i]=tau_vis[i];
      tau_visDirx[i]=tau_vis[i];
    end if;
    H_EvaHor[i]=(HDirNor*Cor_KMDir*Modelica.Math.sin(alt)+HDifHorCle
    *Cor_KMDifCle+HDifHorCov*Cor_KMDifCov)*tau_visDifx[i];
    HVis[i]=(HDirTil[i]*tau_visDirx[i]*corTaue_Dir[i]*Cor_KMDir+HDifTilCle[i]*
    tau_visDifx[i]*corTaue_DifCle[i]*Cor_KMDifCle+HDifTilCov[i]*tau_visDifx[i]*
    corTaue_DifCov[i]*Cor_KMDifCov+H_EvaHor[i]*0.5*rho*(1-Modelica.Math.cos(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(til[i])))*corTaue_Gro[i]);
  end for;
    annotation (defaultComponentName="HVis",Icon(coordinateSystem(
    preserveAspectRatio=false)), Diagram(coordinateSystem(
    preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics),
    Documentation(revisions="<html><ul>
  <li>June 30, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end HVisible;
