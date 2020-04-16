within AixLib.ThermalZones.HighOrder.Rooms.OFD.BaseClasses;
partial model PartialRoom "Partial model with base component that are necessary for all HOM rooms"

  // Air volume of room
  parameter Modelica.SIunits.Density denAir=1.19 "Density of air" annotation (Dialog(group="Air volume of room"));
  parameter Modelica.SIunits.SpecificHeatCapacity cAir=1007 "Specific heat capacity of air" annotation (Dialog(group="Air volume of room"));
  parameter Modelica.SIunits.Volume room_V annotation (Dialog(group="Air volume of room"));
  parameter Modelica.Fluid.Types.Dynamics initDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial "Like energyDynamics, but SteadyState leeds to same behavior as DynamicFreeInitial" annotation (Dialog(tab="Initialization", group="Air volume of room"));
  parameter Modelica.SIunits.Temperature T0_air=295.11 "Air"
    annotation (Dialog(tab="Initialization", group="Air volume of room"));


  replaceable parameter AixLib.DataBase.Walls.Collections.BaseDataMultiWalls
    wallTypes constrainedby AixLib.DataBase.Walls.Collections.BaseDataMultiWalls
    "Types of walls (contains multiple records)"
    annotation(Dialog(group = "Structure of wall layers"), choicesAllMatching = true, Placement(transformation(extent={{-8,82},{8,98}})));

  //// Outer / Exterior wall parameters
  // Heat convection
  parameter Integer calcMethodIn=1
    "Calculation method of convective heat transfer coefficient at inside surface"
    annotation (Dialog(
      tab="Inner walls",
      group="Heat convection",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Custom hCon (constant)",
      radioButtons=true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConIn_const=2.5
    "Custom convective heat transfer coefficient (just for manual selection, not recommended)"
    annotation(Dialog(tab="Inner walls", group="Heat convection", enable=(calcMethodIn==3)));

  //// Outer / Exterior wall parameters
  // Solar absorptance
  parameter Real solar_absorptance_OW(min=0, max=1)=0.25 "Solar absoptance outer walls "
    annotation (Dialog(tab="Outer walls", group="Solar absorptance", descriptionLabel=true));
  // Heat convection
  parameter Integer calcMethod=1 "Calculation method for convective heat transfer coefficient" annotation (Dialog(
      tab="Outer walls",
      group="Heat convection",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom hCon (constant)",
      radioButtons=true));
  replaceable parameter DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster() "Surface type of outside wall" annotation (Dialog(tab="Outer walls", group="Heat convection", enable=(calcMethod==2)));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConOut_const=25 "Custom convective heat transfer coefficient (just for manual selection, not recommended)" annotation (Dialog(tab="Outer walls", group="Heat convection", enable=(calcMethod==3)));
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(tab="Outer walls", group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(tab="Outer walls", group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(tab="Outer walls", group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(tab="Outer walls", group = "Sunblind", enable=use_sunblind));


  // Infiltration rate (building airtightness) according to (DIN) EN 12831-1 (2017-07)
  parameter Boolean use_infiltEN12831=false "Use model to exchange room air with outdoor air acc. to standard"
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (airtightness)"));
  parameter Real n50(unit="1/h") = 4 "Air exchange rate at 50 Pa pressure difference"
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (airtightness)", enable=use_infiltEN12831));
  parameter Real e=0.03 "Coefficient of windshield"
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (airtightness)", enable=use_infiltEN12831));
  parameter Real eps=1.0 "Coefficient of height"
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (airtightness)", enable=use_infiltEN12831));

  // Dynamic Ventilation
  parameter Boolean withDynamicVentilation=false "Dynamic ventilation"
    annotation (Dialog(tab="Dynamic ventilation", descriptionLabel=true),
      choices(checkBox=true));
  parameter Modelica.SIunits.Temperature HeatingLimit=288.15
    "Outside temperature at which the heating activates" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Real Max_VR=10 "Maximal ventilation rate" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.TemperatureDifference Diff_toTempset=2
    "Difference to set temperature" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset=295.15 "Tset" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
      Placement(transformation(extent={{-20,12},{0,32}}),   iconTransformation(
          extent={{-24,-10},{-4,10}})));
  Utilities.Interfaces.RadPort        starRoom annotation (Placement(transformation(
          extent={{2,12},{22,32}}),  iconTransformation(extent={{6,-10},{26,10}})));
  Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    final room_V=room_V,
    final n50=n50,
    final e=e,
    final eps=eps,
    final c=cAir,
    final rho = denAir) if use_infiltEN12831
             annotation (Placement(transformation(extent={{-30,-10},{-18,2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-110,90},{-90,110}}), iconTransformation(extent={{-110,88},{-90,108}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=0,
        origin={-112,80}), iconTransformation(
        extent={{-10,-9.5},{10,9.5}},
        rotation=0,
        origin={-110,69.5})));

  Utilities.Interfaces.Adaptors.ConvRadToCombPort        thermStar_Demux annotation (Placement(transformation(
        extent={{-6,5},{6,-5}},
        rotation=90,
        origin={-7,-2})));
  Components.DryAir.Airload airload(
    final initDynamics=initDynamicsAir,
    final T0=T0_air,
    final rho=denAir,
    final c=cAir,
    final V=room_V)
    annotation (Placement(transformation(extent={{0,-18},{20,2}})));
  Components.DryAir.VarAirExchange
    NaturalVentilation(final V=room_V)
    annotation (Placement(transformation(extent={{-30,-24},{-18,-12}})));
  Components.DryAir.DynamicVentilation
    dynamicVentilation(
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset) if withDynamicVentilation
    annotation (Placement(transformation(extent={{-30,-38},{-18,-26}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{22,-20},{36,-6}})));

equation
  connect(airload.port,Tair. port) annotation (Line(points={{10,-18},{22,-18},{22,-13}},
                                   color={191,0,0}));
  connect(thermRoom,thermStar_Demux. portConv) annotation (Line(points={{-10,22},{-10,6},{-10.1875,6},{-10.1875,4.06}},
                                                                                                                   color={191,0,0}));
  connect(starRoom,thermStar_Demux. portRad) annotation (Line(
      points={{12,22},{12,4},{-3.375,4},{-3.375,4.24}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(thermStar_Demux.portConv,airload. port) annotation (Line(points={{-10.1875,4.06},{-10.1875,4},{-14,4},{-14,-18},{10,-18}},
                                                                                                               color={191,0,0}));
  connect(infiltrationRate.port_b,airload. port) annotation (Line(
      points={{-18,-4},{-16,-4},{-16,-18},{10,-18}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(infiltrationRate.port_a,thermOutside)  annotation (Line(
      points={{-30,-4},{-66,-4},{-66,100},{-100,100}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.port_a,thermOutside)  annotation (Line(points={{-30,-18},{-68,-18},{-68,100},{-100,100}},
                                             color={191,0,0}));
  connect(NaturalVentilation.port_b,airload. port) annotation (Line(points={{-18,-18},{10,-18}},
                                                               color={191,0,0}));
  connect(dynamicVentilation.port_inside,airload. port) annotation (Line(
      points={{-18.12,-32},{10,-32},{10,-18}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(dynamicVentilation.port_outside,thermOutside)  annotation (Line(
      points={{-30,-32},{-72,-32},{-72,100},{-100,100}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(AirExchangePort, NaturalVentilation.InPort1) annotation (Line(points={{-112,80},{-70,80},{-70,-20},{-50,-20},{-50,-21},{-30.6,-21}}, color={0,0,127}));
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (building airtightness"),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>January 9, 2020
    by Philipp Mehrfeld:<br/>
       Model added to the AixLib library.
</ul>
</html>"));
end PartialRoom;
