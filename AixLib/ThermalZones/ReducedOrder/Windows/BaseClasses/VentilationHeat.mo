within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
block VentilationHeat "heat input due to ventilation with closed sunblind"
  extends Modelica.Blocks.Icons.Block;
  parameter Real x_f(min=0,max=1) "Percentage of open windowarea"
    annotation(dialog(group="window"));
  parameter Modelica.Units.SI.Distance d "Distance sunscreen to window"
    annotation (dialog(group="sunscreen"));
  parameter Boolean screen "If screen: true, if blind: false"
    annotation(dialog(group="sunscreen"));
  parameter Modelica.Units.SI.TransmissionCoefficient tau_e
    "Transmission coefficient of sunscreen"
    annotation (dialog(group="sunscreen"));
  parameter Modelica.Units.SI.ReflectionCoefficient rho_e
    "Reflection coefficient of sunscreen" annotation (dialog(group="sunscreen"));
  parameter Modelica.Units.SI.Angle til(displayUnit="deg") "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
    roof" annotation (Dialog(group="window"));

   Modelica.Blocks.Interfaces.BooleanInput sunscreen
    "True: sunscreen closed, false: sunscreen open"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
   Modelica.Blocks.Interfaces.RealInput HDirTil(final quantity=
     "RadiantEnergyFluenceRate", final unit="W/m2")
    "Direct radiation on a tilted surface"
   annotation (Placement(transformation(extent={{-140,-50},{-100,-10}}),
        iconTransformation(extent={{-120,-30},{-100,-10}})));
   Modelica.Blocks.Interfaces.RealInput HDifTil(final quantity=
   "RadiantEnergyFluenceRate", final unit="W/m2")
    "Diffuse radiation on a tilted surface"
   annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
   Modelica.Blocks.Interfaces.RealInput HDifHor(final quantity=
     "RadiantEnergyFluenceRate",final unit="W/m2")
    "Diffuse radiation on horizontal surface"
   annotation (Placement(transformation(extent={{-140,50},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
   Modelica.Blocks.Interfaces.RealInput HDirNor(final quantity=
     "RadiantEnergyFluenceRate",final unit="W/m2")
    "Direct radiation on horizontal surface"
   annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput HVen(final quantity=
    "RadiantEnergyFluenceRate", final unit="W/m2")
    "Heat input due to ventilation"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-12},{124,12}})));
  Modelica.Blocks.Interfaces.RealInput alt(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar altitude angle"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}}),
        iconTransformation(extent={{-120,-90},{-100,-70}})));

  parameter Modelica.Units.SI.ReflectionCoefficient rho=0.2 "Ground reflection";
protected
   Real factor_gv "Calculation factor";

equation
  //calculating factor_gv
  if d<=0.15 and screen then
     factor_gv=0.35;
  elseif d<=0.4 and d>0.15 and screen then factor_gv=0.17;
  elseif d<=0.15 and screen==false then factor_gv=0.2;
  elseif d>0.15 and d<=0.4 and screen==false then factor_gv=0.1;
  else factor_gv=0;
  end if;
  //calculating Output HVen
  if sunscreen then
    HVen=(HDirTil+HDifTil+(HDifHor+HDirNor*Modelica.Math.sin(alt))*0.5*rho*
    (1-Modelica.Math.cos(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
    til))))*(1-rho_e-tau_e)*factor_gv*
    x_f;
  else
    HVen=0;
  end if;
  annotation (defaultComponentName="ventilationHeat",Icon(
  coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-94,-96},{96,96}}, fileName=
              "modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/Windows/BaseClasses/VentilationHeat.png")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>The model considers additional heat input in the event of window
ventilation and simultaneously closed external solar protection based
on VDI 6007 part 3.<br/>
The closed external solar protection absorbs solar irradiation which is
brought into the room by convection.
<h4>
  References
</h4>
<p>
  VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  Modelling of solar radiation.
</p>
<ul>
  <li>May 5, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end VentilationHeat;
