within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model UnderfloorHeatingRoom_ROM
  "Model for heating of one room with underfloor heating"
  extends UnderfloorHeating.BaseClasses.PartialModularPort_ab(final nPorts=
        CircuitNo, final m_flow_nominal=m_flow_PanelHeating);
   extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;
   import Modelica.Constants.pi;

  parameter Boolean ROM=false "False in High order models will be used";
  parameter Integer dis(min=1) "Number of Discreatisation Layers";
  final parameter Integer CircuitNo(min=1) = integer(ceil(PipeLength/maxLength))
    "number of circuits in one room";
  parameter Modelica.SIunits.Area A "Floor Area"
    annotation (Dialog(group="Room Specifications"));

  final parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Ceiling = 5.8824 "Coefficient of heat transfer at Ceiling Surface";
  final parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Floor = 10.8 "Coefficient of heat transfer at floor surface";

  //ROM
  // Floor TABS
  parameter Integer nFloorTabs(min = 1) "Number of RC-elements of Floor tabs"
    annotation(Dialog(group="Floor tabs", enable=ROM));
  parameter Modelica.SIunits.ThermalResistance RFloorTabs(
    each min=Modelica.Constants.small)
    "Vector of resistances of Floor tabs, from inside to outside"
    annotation(Dialog(group="Floor tabs", enable=ROM));
  parameter Modelica.SIunits.ThermalResistance RFloorRemTabs(
    min=Modelica.Constants.small)
    "Resistance of remaining resistor RFloorRem between capacity n and outside"
    annotation(Dialog(group="Floor tabs", enable=ROM));
  parameter Modelica.SIunits.HeatCapacity CFloorTabs(
    each min=Modelica.Constants.small)
    "Vector of heat capacities of Floor tabs, from inside to outside"
    annotation(Dialog(group="Floor tabs", enable=ROM));

  // Ceiling TABS
  parameter Integer nRoofTabs(min = 1) "Number of RC-elements of Roof tabs"
    annotation(Dialog(group="Roof tabs", enable=ROM));
  parameter Modelica.SIunits.ThermalResistance RRoofTabs(
    each min=Modelica.Constants.small)
    "Vector of resistances of Roof tabs, from inside to outside"
    annotation(Dialog(group="Roof tabs", enable=ROM));
  parameter Modelica.SIunits.ThermalResistance RRoofRemTabs(
    min=Modelica.Constants.small)
    "Resistance of remaining resistor RRoofRem between capacity n and outside"
    annotation(Dialog(group="Roof tabs", enable=ROM));
  parameter Modelica.SIunits.HeatCapacity CRoofTabs(
    each min=Modelica.Constants.small)
    "Vector of heat capacities of Roof tabs, from inside to outside"
    annotation(Dialog(group="Roof tabs", enable=ROM));

  parameter Integer calculateVol annotation (Dialog(group="Panel Heating",
        descriptionLabel=true), choices(
      choice=1 "Calculate Water Volume with inner diameter",
      choice=2 "Calculate Water Volume with time constant",
      radioButtons=true));
  parameter Modelica.SIunits.Length maxLength=120
    "Maximum Length for one Circuit" annotation (Dialog(group="Panel Heating"));

  parameter Modelica.SIunits.Power Q_Nf
    "Calculated Heat Load for room with panel heating"
    annotation (Dialog(group="Room Specifications"));
  final parameter Modelica.SIunits.HeatFlux q=Q_Nf/A
    "set value for panel heating heat flux";

  parameter Modelica.SIunits.Temperature T_Flow "nominal flow temperature";
  parameter Modelica.SIunits.Temperature T_Return "nominal return temperature";
  parameter Modelica.SIunits.PressureDifference dp_Pipe=100*PipeLength
    "Nominal pressure drop in every heating circuit" annotation (Dialog(group="Pressure Drop"));
  parameter Modelica.SIunits.PressureDifference dp_Valve = 0
    "Pressure Difference set in regulating valve for pressure equalization" annotation (Dialog(group="Pressure Drop"));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal =  0  "Additional pressure drop for every heating circuit, e.g. for distributor" annotation (Dialog(group="Pressure Drop"));

  parameter Modelica.SIunits.Temperature T_Fmax=29 + 273.15
    "Maximum surface temperature"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.SIunits.Temperature T_Room=20 + 273.15
    "Nominal room temperature" annotation (Dialog(group="Room Specifications"));

  final parameter Modelica.SIunits.HeatFlux q_Gmax=8.92*(T_Fmax - T_Room)^(1.1)
    "Maxium possible heat flux with given surface temperature and room temperature";
  parameter Boolean Ceiling "false if ground plate is under panel heating"
    annotation (Dialog(group="Room Specifications"), choices(checkBox=true));

  parameter Modelica.SIunits.Temperature T_U= Modelica.SIunits.Conversions.from_degC(20)
    "Nominal Room Temperature lying under panel heating"
    annotation (Dialog(group="Room Specifications"));
  // Pipe
  parameter Modelica.SIunits.Distance Spacing "Spacing between tubes"
    annotation (Dialog(group="Panel Heating"));
  final parameter Modelica.SIunits.Length PipeLength=A/Spacing
    "possible pipe length for given panel heating area";

  parameter
    UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition PipeMaterial
    "Pipe Material"
    annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
  final parameter Modelica.SIunits.ThermalConductivity lambda_R=PipeMaterial.lambda
    "Thermal conductivity of pipe material";
  parameter Modelica.SIunits.Thickness PipeThickness "thickness of pipe wall"
    annotation (Dialog(group="Panel Heating"));
  parameter Modelica.SIunits.Diameter d_a "outer diameter of pipe"
    annotation (Dialog(group="Panel Heating"));
  final parameter Modelica.SIunits.Diameter d_i=d_a - 2*PipeThickness
    "inner diameter of pipe";

  parameter Boolean withSheathing=false "false if pipe has no sheathing"
    annotation (Dialog(group="Panel Heating"), choices(checkBox=true));
  parameter
    UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition
    SheathingMaterial=
      UnderfloorHeating.BaseClasses.Sheathing_Materials.PVCwithTrappedAir()
    "Sheathing Material" annotation (Dialog(group="Panel Heating"));
  final parameter Modelica.SIunits.ThermalConductivity lambda_M=if
      withSheathing then SheathingMaterial.lambda else 0
    "Thermal Conductivity for sheathing";
  parameter Modelica.SIunits.Diameter d(min=d_a) = d_a
    "Outer diameter of pipe including sheathing"
    annotation (Dialog(group="Panel Heating", enable=withSheathing));
  final parameter Modelica.SIunits.Diameter d_M=if withSheathing then d else 0
    "Outer diameter of sheathing";

  // Heatflux calculations
  final parameter Modelica.SIunits.Power Q_F=q*A
    "nominal heat flow of panel heating";

  final parameter Modelica.SIunits.ThermalInsulance R_U = A*(RRoofTabs+RRoofRemTabs)
  "Thermal resistance of wall layers under panel heating";
  final parameter Modelica.SIunits.ThermalInsulance R_O = A*(RFloorTabs+RFloorRemTabs)
  "Thermal resistance of wall layers above panel heating";

  parameter Modelica.SIunits.TemperatureDifference dT_Hi
    "Nominal temperature difference between heating medium"
    annotation (Dialog(group="Panel Heating"));

  final parameter Modelica.SIunits.TemperatureDifference sigma_i=T_Flow -
      T_Return
    "Temperature spread for room (max = 5 for room with highest heat load)"
    annotation (Dialog(group="Room Specifications"));

  final parameter Modelica.SIunits.MassFlowRate m_flow_PanelHeating= A*q/(
      sigma_i*Cp_Medium)*(1 + (R_O/R_U) + (T_Room - T_U)/(q*R_U))
    "nominal mass flow rate";
  final parameter Modelica.SIunits.MassFlowRate m_flow_Circuit=
      m_flow_PanelHeating/CircuitNo
    "Nominal mass flow rate in each heating circuit";
  parameter Integer use_vmax(min=1, max=2) "Output if v > v_max (0.5 m/s)"
    annotation (choices(choice=1 "Warning", choice=2 "Error"));

  final parameter Modelica.SIunits.TemperatureDifference dT_HU=
      UnderfloorHeating.BaseClasses.logDT({T_Flow,T_Return,T_U});

  final parameter Modelica.SIunits.ThermalResistance R_add = 0 "additional thermal resistance";
  UnderfloorHeatingCircuit underfloorHeatingCircuit[CircuitNo](
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final C_nominal=C_nominal,
    each final ROM=ROM,
    each final mSenFac=mSenFac,
    each final dp_Pipe=dp_Pipe,
    each final dp_Valve=dp_Valve,
    each final dpFixed_nominal=dpFixed_nominal,
    each final T_Fmax=T_Fmax,
    each final T_Room=T_Room,
    each final PipeMaterial=PipeMaterial,
    each final PipeThickness=PipeThickness,
    each final d_a=d_a,
    each final withSheathing=withSheathing,
    each SheathingMaterial=SheathingMaterial,
    each d=d,
    redeclare each final package Medium = Medium,
    each final A=A/CircuitNo,
    each calculateVol=calculateVol,
    each final dis=dis,
    each use_vmax=use_vmax,
    each final Spacing=Spacing,
    each m_flow_Circuit=m_flow_Circuit,
    each R_x=R_add*CircuitNo,
    each nFloorTabs=nFloorTabs,
    each RFloorTabs=if ROM then fill(RFloorTabs*CircuitNo, nFloorTabs) else {0},
    each RFloorRemTabs=if ROM then RFloorRemTabs*CircuitNo else 0,
    each CFloorTabs=if ROM then fill(CFloorTabs/CircuitNo, nFloorTabs) else {0},
    each nRoofTabs=nRoofTabs,
    each RRoofTabs=if ROM then fill(RRoofTabs*CircuitNo, nRoofTabs) else {0},
    each RRoofRemTabs=if ROM then RRoofRemTabs*CircuitNo else 0,
    each CRoofTabs=if ROM then fill(CRoofTabs/CircuitNo, nRoofTabs) else {0})
    annotation (Placement(transformation(extent={{-22,-8},{22,8}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatFloor annotation (
      Placement(transformation(extent={{-10,50},{10,70}}), iconTransformation(
          extent={{-10,50},{10,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCeiling annotation (
      Placement(transformation(extent={{-10,-90},{10,-70}}), iconTransformation(
          extent={{-10,-90},{10,-70}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollectorCeiling(m=
        CircuitNo)
    annotation (Placement(transformation(extent={{-10,-58},{10,-38}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollectorFloor(m=
        CircuitNo)
    annotation (Placement(transformation(extent={{-10,40},{10,20}})));
  Modelica.Blocks.Interfaces.RealInput valveInput[CircuitNo] annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-62,74})));

protected
   parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.SIunits.SpecificHeatCapacity Cp_Medium=Medium.specificHeatCapacityCp(sta_default)
    "Specific Heat capacity of medium";

initial equation
  assert(T_Return < T_Flow, "Return Temperature is higher than the Flow Temperature in" + getInstanceName());

equation

  // FLUID CONNECTIONS

  for i in 1:CircuitNo loop
    connect(ports_a[i], underfloorHeatingCircuit[i].port_a)
      annotation (Line(points={{-100,0},{-22,0}}, color={0,127,255}));
    connect(underfloorHeatingCircuit[i].port_b, ports_b[i])
      annotation (Line(points={{22,0},{100,0}}, color={0,127,255}));

  end for;

  // HEAT CONNECTIONS

  for i in 1:CircuitNo loop
    connect(underfloorHeatingCircuit[i].heatCeiling, thermalCollectorCeiling.port_a[i]) annotation (Line(points={{0.44,-8.8},{0.44,-24},{0,-24},{0,-38}},
          color={191,0,0}));
    connect(thermalCollectorFloor.port_a[i], underfloorHeatingCircuit[i].heatFloor)
      annotation (Line(points={{0,20},{0,7.6}}, color={191,0,0}));
  end for;
  connect(thermalCollectorCeiling.port_b, heatCeiling)
    annotation (Line(points={{0,-58},{0,-80}}, color={191,0,0}));
  connect(heatFloor, thermalCollectorFloor.port_b)
    annotation (Line(points={{0,60},{0,40}}, color={191,0,0}));

  // VALVE CONNECTION
  for i in 1:CircuitNo loop
  connect(valveInput[i], underfloorHeatingCircuit[i].valveInput) annotation (Line(
        points={{-62,74},{-62,32},{-16.28,32},{-16.28,11.6}}, color={0,0,127}));
  end for;
  annotation (
    Dialog(group="Panel Heating", enable=withSheathing),
    choicesAllMatching=true,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,60}}),
        graphics={
        Rectangle(
          extent={{-100,-62},{100,-70}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,42},{100,-10}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{-86,6},{-76,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-66,6},{-56,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,6},{-36,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-26,6},{-16,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,6},{4,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,6},{24,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,6},{44,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,6},{64,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{74,6},{84,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,50},{100,42}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,-10},{100,-48}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-48},{100,-62}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Text(
          extent={{-78,32},{-54,22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175},
          textString="R_o"),
        Line(points={{-48,50},{-52,46},{-52,28},{-56,26},{-52,24},{-52,8},{-48,4}},
            color={0,0,0}),
        Text(
          extent={{-80,-34},{-56,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175},
          textString="R_u"),
        Line(points={{-48,-2},{-52,-6},{-52,-38},{-56,-40},{-52,-42},{-52,-66},{
              -46,-70}}, color={0,0,0})}),Documentation(
   info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for heat transfer of an underfloor heating for one room
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  This model calculates the number of heating circuits needed for the
  heating of one room by an underfloor heating.
</p>
<p>
  Every heating circuit has an equal percentage valve that has to be
  regulated from outside.
</p>
<p>
  For the determination of the nominal mass flow the regulations by
  prEN 1264 are implemented.
</p><b><span style=\"color: #008000;\">Layer Structure</span></b>
<p>
  For dimensioning it is important that the layer structure of the
  floor is set right!
</p>
<p>
  The wall layers above the heating circuits have to be in the
  following order:
</p>
<p>
  1. Cover/Screed
</p>
<p>
  2. Floor
</p>
<p>
  The wall layers below the heating circuits need to be in the record
  with the following order:
</p>
<p>
  1. Isolation
</p>
<p>
  2. Load-bearing substrate
</p>
<p>
  3. Plaster
</p>
<p>
  If there is a floor plate underneath the heating circuits, the wall
  record needs to consist of 4 layers, whereas the first layer needs to
  be the isolation!
</p><b><span style=\"color: #008000;\">Isolation</span></b>
<p>
  The thermal resistance of the isolation needs to fulfill the
  following requirements:
</p>
<p>
  Room underneath the underfloor heating is heated:
  R<sub>lambda,Ins</sub> <code>&gt;= 0,75 W/m²K</code>
</p>
<p>
  Room underneath the underfloor heating is not heated / floor plate:
  R<sub>lambda,Ins</sub> <code>&gt;= 1,25 W/m²K</code>
</p><b><span style=\"color: #008000;\">Water Volume</span></b>
<p>
  The water volume in the pipe element can be calculated by the inner
  diameter of the pipe or by time constant and the mass flow.
</p>
<p>
  The maximum velocity in the pipe is set for 0.5 m/s. If the Water
  Volume is calculated by time constant, a nominal inner diameter is
  calculated with the maximum velocity for easier parametrization.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,
            60}})));
end UnderfloorHeatingRoom_ROM;
