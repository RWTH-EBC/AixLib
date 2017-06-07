within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model Illumination
  "Determining the activation and deactivation times of the illumination"
  extends Modelica.Blocks.Icons.Block;
  parameter Real D "daylight quotient";
  parameter Modelica.SIunits.Illuminance e_ILim1
    "internal illumninance required in reference point in the morning and
    evening";
  parameter Modelica.SIunits.Illuminance e_ILim2
    "internal illumainance required in reference point during working hours";
  parameter Boolean office "if true: room is office";
  final parameter Modelica.SIunits.LuminousEfficacy k_mDifCov=115
    "radiation equivalent for uniformly overcast skies";

  //Window parameter
  parameter Integer n(min=1) "number of windows"
    annotation (Dialog(group="window"));
  parameter Modelica.SIunits.Angle til[n](displayUnit="deg")
    "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
     roof"
    annotation (Dialog(group="window"));
  parameter Real r[n] "frame share"
    annotation (Dialog(group="window"));
  parameter Modelica.SIunits.Area A[n] "windowarea"
    annotation (Dialog(group="window"));
  parameter Modelica.SIunits.TransmissionCoefficient T_L[n]
    "degree of light transmission"
    annotation (Dialog(group="window"));
  final parameter Modelica.SIunits.ReflectionCoefficient rho=0.2
    "degree of ground reflection";

  Modelica.Blocks.Interfaces.BooleanOutput Illumination
    "If Illumination=true: activation of Illumination"
    annotation (Placement(transformation(extent={{98,-10},{118,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Interfaces.RealInput HVis[n]( quantity=
    "RadiantEnergyFluenceRate", unit="W/m2")
    "solar energy entering the room in the visible area"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
          Modelica.Blocks.Interfaces.RealInput CorTaue_DifCov[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for transluance for diffuse irradiation during covered
     sky"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));

  Modelica.Blocks.Interfaces.RealInput CorTaue_Gro[n](
    final quantity="TransmissionCoefficient",
    final unit="1")
    "Correction value for transluance for ground reflexion radiation"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
//protected
  constant Modelica.SIunits.Time day=86400 "Number of seconds in a day";
  constant Modelica.SIunits.Time week=604800 "Number of seconds in a week";

  Modelica.SIunits.Illuminance e_ILim
    "internal illumance in reference point";
  Real r_DifCov[n] "conversion factor";

  Modelica.SIunits.EnergyFlowRate HLimVisi[n] "thresholds within the room";
  Modelica.SIunits.EnergyFlowRate HLimVis "sum of H_LimInsi";

  Modelica.SIunits.EnergyFlowRate HVisi[n]
    "solar energy entering the room in the visible area";
  Modelica.SIunits.EnergyFlowRate HVisSum "sum of HVisi";

equation
  //Picking value for e_ILim
  if (time-integer(time/day)*day)>64800 or (time-integer(time/day)*day)<25200
    or (office and time-integer(time/week)*week>432000) then
    e_ILim=0;
  elseif (time-integer(time/day)*day)>28800 and
    (time-integer(time/day)*day)<57600 then
    e_ILim=e_ILim2;
  else
    e_ILim=e_ILim1;
  end if;
  //Calculating HLimVis
  for i in 1:n loop
    r_DifCov[i]=0.182*(1.178*(1+Modelica.Math.cos(AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(til[i])))+
    (Modelica.Constants.pi-AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(til[i]))*
    Modelica.Math.cos(AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(til[i]))+Modelica.Math.sin(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(til[i])));
    HLimVisi[i]=e_ILim/(D*k_mDifCov)*(r_DifCov[i]*T_L[i]*
    CorTaue_DifCov[i]+0.5*rho*(1-Modelica.Math.cos(AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(til[i])))*
    T_L[i]*CorTaue_Gro[i])*(1-r[i])*A[i];
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
    Documentation(revisions="<html>
<ul>
<li>May 23, 2016,&nbsp; by Stanley Risch:<br>Implemented. </li>
</html>",
      info="<html>
This model calculates the activation and deactivation times of the illumination
 and gives it back as the Boolean \"Illumination\".
It is based on VDI 6007 part 3. <br>
The total solar energy entering the room, which can be calculated by <a href=
\"Windows.Window\">Window</a> or <a href=\"Windows.ShadedWindow\">
ShadedWindow</a>, is compared to a limit value based on the parameters.
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI 6007-3
  June 2015. Calculation of transient thermal response of rooms
  and buildings - modelling of solar radiation.</p>
</html>"));
end Illumination;
