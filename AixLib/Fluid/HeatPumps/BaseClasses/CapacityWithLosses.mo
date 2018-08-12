within AixLib.Fluid.HeatPumps.BaseClasses;
model CapacityWithLosses
  "Base model for heat capacity with heat losses depending on ambient conditions"
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCap(final C=C)
    "heat Capacity"
    annotation (Placement(transformation(extent={{-16,-72},{16,-40}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionIns
    "Convection between fluid and solid"
    annotation (Placement(transformation(extent={{34,-80},{50,-64}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempCon
    "Foreces heat losses according to ambient temperature"
    annotation (Placement(transformation(extent={{-76,-80},{-60,-64}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionOut
    "Convection between solid and ambient air"
    annotation (Placement(transformation(extent={{-26,-80},{-42,-64}})));
  Modelica.Blocks.Interfaces.RealInput T_amb "Ambient air temperature"
    annotation (Placement(transformation(extent={{-140,-92},{-100,-52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b fluidPort
    "Port to be connected to the Volume of Heat Exchanger"
    annotation (Placement(transformation(extent={{94,-82},{114,-62}})));
  parameter Modelica.SIunits.HeatCapacity C "Heat capacity of element (= cp*m)"
    annotation (Dialog(group="General"));
  Modelica.Blocks.Interfaces.RealInput mFlowOut if use_ForConv
                                                "Mass flow rate on the outside"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput mFlowIns "Mass flow rate on the inside"
    annotation (Placement(transformation(extent={{140,40},{100,80}})));
  Modelica.Blocks.Sources.RealExpression heatLossForOut_nominal(y=
        kAOutFor_nominal) if use_ForConv
    "Nominal heat loss coefficient to the outside" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-14,38})));
  Modelica.Blocks.Sources.RealExpression heatLossInn_nominal(y=kAInn_nominal)
    "Nominal heat loss coefficient to the inside" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={28,-2})));
  PortTToRealT portTToRealT if not use_ForConv annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-92,-14})));
  HeatCoeffNat calcHeatCoeffNat(
    final scalingFactor=scalingFactor,
    final wukExp=wukExpOutNat,
    final T_amb_nominal=T_amb_nominal,
    final TSurf_nominal=TSurf_nominal) if not use_ForConv annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-57,-15})));
  HeatCoeffForc heatCoeffForcInn(
    mFlow_nominal=mFlowIns_nominal,
    scalingFactor=scalingFactor,
    wukExp=wukExpIns) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={42,-36})));
  HeatCoeffForc heatCoeffForcOut(
    final scalingFactor=scalingFactor,
    final mFlow_nominal=mFlowOut_nominal,
    final wukExp=wukExpOutFor) if
                            use_ForConv annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-22,-14})));
  Modelica.Blocks.Sources.RealExpression heatLossNatOut_nominal(y=
        kAOutNat_nominal) if                                       not
    use_ForConv "Nominal heat loss coefficient to the outside" annotation (
      Placement(transformation(
        extent={{-8,-10},{8,10}},
        rotation=0,
        origin={-94,0})));
  parameter Boolean use_ForConv=true
    "True if forced convection applies to the circumstances"
    annotation (Dialog(group="Outside"), choices(checkBox=true));
  parameter Modelica.SIunits.ThermalConductance kAInn_nominal
    "Nominal convective resistance on the inside"
    annotation (Dialog(group="Inside"));
  parameter Real scalingFactor "Scaling-factor of HP"
    annotation (Dialog(group="General"));
  parameter Real wukExpIns "Exponent for the wük on the inside"
    annotation (Dialog(group="Inside"));
  parameter Modelica.SIunits.MassFlowRate mFlowIns_nominal
    "Nominal mass flow rate of medium on the inside"
    annotation (Dialog(group="Inside"));
  parameter Modelica.SIunits.MassFlowRate mFlowOut_nominal
    "Nominal mass flow rate on the outside"
    annotation (Dialog(group="Outside", enable=use_ForConv));
  parameter Modelica.SIunits.ThermalConductance kAOutFor_nominal
    "Nominal heat resistance for forced convection on outside"
    annotation (Dialog(group="Outside", enable=use_ForConv));
  parameter Real wukExpOutFor
    "Exponent for the wük of forced convection to outside"
    annotation (Dialog(group="Outside", enable=use_ForConv));
  parameter Real wukExpOutNat
    "Exponent for the wük natural convection on outside"
    annotation (Dialog(group="Outside", enable=not use_ForConv));
  parameter Modelica.SIunits.ThermodynamicTemperature TSurf_nominal
    "Nominal temperature of surface"
    annotation (Dialog(group="Outside", enable=not use_ForConv));
  parameter Modelica.SIunits.ThermodynamicTemperature T_amb_nominal
    "Nominal temperature of ambient air"
    annotation (Dialog(group="Outside", enable=not use_ForConv));
  parameter Modelica.SIunits.ThermalConductance kAOutNat_nominal
    "Nominal heat resistance for natural convection on the outside"
    annotation (Dialog(group="Outside", enable=not use_ForConv));
equation
  connect(convectionIns.solid, heatCap.port)
    annotation (Line(points={{34,-72},{0,-72}},  color={191,0,0}));
  connect(varTempCon.port, convectionOut.fluid)
    annotation (Line(points={{-60,-72},{-42,-72}}, color={191,0,0}));
  connect(convectionOut.solid, heatCap.port)
    annotation (Line(points={{-26,-72},{0,-72}},  color={191,0,0}));
  connect(varTempCon.T, T_amb)
    annotation (Line(points={{-77.6,-72},{-120,-72}}, color={0,0,127}));
  connect(convectionIns.fluid, fluidPort)
    annotation (Line(points={{50,-72},{104,-72}}, color={191,0,0}));
  connect(convectionOut.solid, portTToRealT.port) annotation (Line(
      points={{-26,-72},{-18,-72},{-18,-56},{-100,-56},{-100,-14}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(portTToRealT.T, calcHeatCoeffNat.u[3]) annotation (Line(
      points={{-82.4,-14},{-74,-14},{-74,-15},{-65.4,-15}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(calcHeatCoeffNat.u[2], varTempCon.T) annotation (Line(
      points={{-65.4,-15},{-65.4,-16},{-78,-16},{-78,-44},{-77.6,-44},{-77.6,-72}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(heatLossInn_nominal.y, heatCoeffForcInn.u[1]) annotation (Line(points=
         {{28,-13},{28,-14},{34,-14},{34,-26.4},{42,-26.4}}, color={0,0,127}));
  connect(mFlowIns, heatCoeffForcInn.u[2])
    annotation (Line(points={{120,60},{42,60},{42,-26.4}}, color={0,0,127}));
  connect(heatCoeffForcInn.y, convectionIns.Gc)
    annotation (Line(points={{42,-44.8},{42,-64}}, color={0,0,127}));
  connect(heatLossForOut_nominal.y, heatCoeffForcOut.u[1]) annotation (Line(
      points={{-14,27},{-14,-4.4},{-22,-4.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(mFlowOut, heatCoeffForcOut.u[2]) annotation (Line(
      points={{-120,60},{-32,60},{-32,-4.4},{-22,-4.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatLossForOut_nominal.y, heatCoeffForcOut.u[1]) annotation (Line(
      points={{-14,27},{-14,-4.4},{-22,-4.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatLossNatOut_nominal.y, calcHeatCoeffNat.u[1]) annotation (Line(
      points={{-85.2,0},{-78.15,0},{-78.15,-15},{-65.4,-15}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatCoeffForcOut.y, convectionOut.Gc) annotation (Line(
      points={{-22,-22.8},{-22,-42},{-34,-42},{-34,-64}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(calcHeatCoeffNat.y, convectionOut.Gc) annotation (Line(
      points={{-49.3,-15},{-49.3,-42.5},{-34,-42.5},{-34,-64}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CapacityWithLosses;
