within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model Illumination
  "Determining the activation and deactivation times of the illumination"
  extends Modelica.Blocks.Icons.Block;
  parameter Real D "Daylight quotient";
  final parameter Modelica.Units.SI.LuminousEfficacy k_mDifCov=115
    "Radiation equivalent for uniformly overcast skies";

  //Window parameter
  parameter Integer n(min=1) "Number of windows"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Angle til[n](displayUnit="deg") "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
     roof" annotation (Dialog(group="window"));
  parameter Real r[n] "Frame share"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Area A[n] "Window area"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient tau_vis[n]
    "Degree of light transmission" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.ReflectionCoefficient rho=0.2
    "Degree of ground reflection";

  Modelica.Blocks.Interfaces.BooleanOutput Illumination
    "If Illumination=true: activation of Illumination"
    annotation (Placement(transformation(extent={{98,-10},{118,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Interfaces.RealInput HVis[n](final quantity=
    "RadiantEnergyFluenceRate", final unit="W/m2")
    "Solar energy entering the room in the visible area"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput corTaue_DifCov[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for diffuse irradiation during covered
     sky"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));

  Modelica.Blocks.Interfaces.RealInput corTaue_Gro[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for translucence for ground reflection radiation"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}}),
        iconTransformation(extent={{-120,30},{-100,50}})));

  Modelica.Blocks.Interfaces.RealInput e_ILim
    "Internal illumance in reference point"
    annotation (Placement(transformation(extent={{-120,-30},{-100,-10}}),
        iconTransformation(extent={{-120,-30},{-100,-10}})));

  Real r_DifCov[n] "Conversion factor";

  Modelica.Units.SI.EnergyFlowRate HLimVisi[n] "Thresholds within the room";
  Modelica.Units.SI.EnergyFlowRate HLimVis "Sum of H_LimInsi";

  Modelica.Units.SI.EnergyFlowRate HVisi[n]
    "Solar energy entering the room in the visible area";
  Modelica.Units.SI.EnergyFlowRate HVisSum "Sum of HVisi";

equation
  //Calculating HLimVis
  for i in 1:n loop
    r_DifCov[i]=0.182*(1.178*(1+Modelica.Math.cos(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i])))+(Modelica.Constants.pi-
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i]))*Modelica.Math.cos(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i]))+Modelica.Math.sin(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i])));
    HLimVisi[i]=e_ILim/(D*k_mDifCov)*(r_DifCov[i]*tau_vis[i]*corTaue_DifCov[i]+0.5*
    rho*(1-Modelica.Math.cos(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til[i])))*tau_vis[i]*corTaue_Gro[i])*(1-r[i])*A[i];
    HVisi[i]=HVis[i]*(1-r[i])*A[i];
  end for;
  HLimVis=sum(HLimVisi);
  HVisSum=sum(HVisi);
  //comparing HVisSum with HLimVis
  Illumination = (HVisSum<HLimVis);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-92,-102},{100,114}}, fileName=
              "modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/Windows/BaseClasses/Illumination.png")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>May 23, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>",
      info="<html>This model calculates the activation and deactivation times of the
illumination and gives it back as the Boolean \"Illumination\". It is
based on VDI 6007 part 3.<br/>
The total solar energy entering the room, which can be calculated by
<a href=\"Windows.Window\">Window</a> or <a href=
\"Windows.ShadedWindow\">ShadedWindow</a>, is compared to a limit value
based on the parameters.
<h4>
  References
</h4>
<p>
  VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  Modelling of solar radiation.
</p>
</html>"));
end Illumination;
