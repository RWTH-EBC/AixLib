within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model UnderfloorHeatingCircuit "One Circuit in an Underfloor Heating System"
 extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(allowFlowReversal=
        false, final m_flow_nominal = m_flow_Circuit);
  import Modelica.Constants.pi;
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Integer dis(min=1) "Number of Discreatisation Layers";
  parameter Integer calculateVol annotation (Dialog(group="Panel Heating",
        descriptionLabel=true), choices(
      choice=1 "Calculate water volume with inner diameter",
      choice=2 "Calculate water volume with time constant",
      radioButtons=true));

  parameter Modelica.Units.SI.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_Circuit "nominal mass flow rate" annotation (Dialog(group = "Panel Heating"));
  final parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal = m_flow_Circuit / rho_default "nominal volume flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_Pipe=100*PipeLength
    "Nominal pressure drop" annotation (Dialog(group="Pressure Drop"));
  parameter Modelica.Units.SI.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation (Dialog(group="Pressure Drop"));
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal = 0 "Nominal additional pressure drop e.g. for distributor" annotation (Dialog(group="Pressure Drop"));

  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor
    "Wall type for floor"
    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  parameter Modelica.Units.SI.Temperature T_Fmax = 29 + 273.15 "Maximum surface temperature" annotation (Dialog(group = "Room Specifications"));
  parameter Modelica.Units.SI.Temperature T_Room = 20 + 273.15 "Nominal Room Temperature" annotation (Dialog(group = "Room Specifications"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling
    "Wall type for ceiling"
    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);

  parameter Modelica.Units.SI.Distance Spacing "Spacing between tubes" annotation (Dialog( group = "Panel Heating"));
  final parameter Modelica.Units.SI.Length PipeLength = A / Spacing
    "Length of Panel Heating Pipe" annotation (Dialog(group="Panel Heating"));

  parameter
    UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition PipeMaterial
    "Pipe Material"
    annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
  final parameter Modelica.Units.SI.ThermalConductivity lambda_R = PipeMaterial.lambda "Thermal conductivity of pipe material";
  parameter Modelica.Units.SI.Thickness PipeThickness "thickness of pipe wall" annotation (Dialog( group = "Panel Heating"));
  parameter Modelica.Units.SI.Diameter d_a "outer diameter of pipe" annotation (Dialog( group = "Panel Heating"));
  final parameter Modelica.Units.SI.Diameter d_i = d_a - 2*PipeThickness "inner diameter of pipe";

  parameter Boolean withSheathing = false "false if pipe has no Sheathing" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
  parameter
    UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition
    SheathingMaterial=
      UnderfloorHeating.BaseClasses.Sheathing_Materials.PVCwithTrappedAir()
    "Sheathing Material" annotation (Dialog(group="Panel Heating", enable=
          withSheathing), choicesAllMatching=true);
  final parameter Modelica.Units.SI.ThermalConductivity lambda_M = if withSheathing then SheathingMaterial.lambda else 0 "Thermal Conductivity for Sheathing";
  parameter Modelica.Units.SI.Diameter d(min = d_a) = d_a  "Outer diameter of pipe including Sheathing" annotation (Dialog( group = "Panel Heating", enable = withSheathing));
  final parameter Modelica.Units.SI.Diameter d_M = if withSheathing then d else 0;

  final parameter Integer n_pipe( min = 1) = if withSheathing then 2 else 1;
  final parameter Modelica.Units.SI.Thickness d_pipe[n_pipe] = if withSheathing then {PipeThickness, (d - d_a)} else {PipeThickness} "Thickness of pipe layers";
  final parameter Modelica.Units.SI.ThermalConductivity lambda_pipe[n_pipe] = if withSheathing then {lambda_R, lambda_M} else {lambda_R} "Thermal conductivity of pipe layer";

  parameter Integer use_vmax(min = 1, max = 2) "Output if v > v_max (0.5 m/s)" annotation(choices(choice = 1 "Warning", choice = 2 "Error"));

  parameter Modelica.Units.SI.ThermalResistance R_x = 0 "additional thermal resistance";

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";

public
  AixLib.Fluid.Sensors.TemperatureTwoPort TFlow(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_Circuit,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-48,-6},{-36,6}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort TReturn(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_Circuit,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{60,-6},{72,6}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatFloor[dis]
    annotation (Placement(transformation(extent={{-10,34},{10,54}}),
        iconTransformation(extent={{-8,30},{8,46}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCeiling[dis]
    annotation (Placement(transformation(extent={{-10,-56},{10,-36}}),
        iconTransformation(extent={{-6,-52},{10,-36}})));
  BaseClasses.SumT_F sumT_Fm(dis=integer(dis))
    annotation (Placement(transformation(extent={{16,10},{28,22}})));
  Modelica.Blocks.Interaction.Show.RealValue T_Fm "arithmetic mean of floor surface temperature"
    annotation (Placement(transformation(extent={{38,10},{48,22}})));
  UnderfloorHeatingElement underfloorHeatingElement[dis](
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final C_nominal=C_nominal,
    each final mSenFac=mSenFac,
    each final energyDynamicsWalls=energyDynamics,
    each m_flow_Circuit=m_flow_Circuit,
    each final A=A/dis,
    redeclare each final package Medium = Medium,
    each final n_pipe=n_pipe,
    each final lambda_pipe=lambda_pipe,
    each final T0=T_Room,
    each final d_a=if withSheathing then {d_a,d} else {d_a},
    each final d_i=if withSheathing then {d_i,d_a} else {d_i},
    each calculateVol=calculateVol,
    each final dis=integer(dis),
    each final PipeLength=PipeLength/dis,
    each final wallTypeFloor=wallTypeFloor,
    each final wallTypeCeiling=wallTypeCeiling,
    each use_vmax=use_vmax,
    each R_x=R_x*dis)
    annotation (Placement(transformation(extent={{-10,-4},{10,4}})));

  AixLib.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    each m_flow_nominal=m_flow_Circuit,
    from_dp=false,
    dpValve_nominal=dp_Pipe + dp_Valve,
    dpFixed_nominal=dpFixed_nominal)
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  Modelica.Blocks.Interfaces.RealInput valveInput annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-74,58})));
initial equation
assert(dp_Pipe + dp_Valve <= 25000, "According to prEN1264 pressure drop in a heating circuit is supposed to be under 250 mbar. Error accuring in" + getInstanceName(), AssertionLevel.warning);

equation
  assert(
      sumT_Fm.T_Fm <= T_Fmax,
      "Surface temperature in" + getInstanceName() + "too high",
      AssertionLevel.warning);
//OUTER CONNECTIONS
 connect(port_a, val.port_a)
    annotation (Line(points={{-100,0},{-84,0}}, color={0,127,255}));
  connect(val.port_b, TFlow.port_a)
    annotation (Line(points={{-64,0},{-48,0}}, color={0,127,255}));
  connect(TFlow.port_b, underfloorHeatingElement[1].port_a)
    annotation (Line(points={{-36,0},{-10,0}}, color={0,127,255}));
  connect(underfloorHeatingElement[dis].port_b, TReturn.port_a)
    annotation (Line(points={{10,0},{60,0}}, color={0,127,255}));
     connect(TReturn.port_b, port_b)
    annotation (Line(points={{72,0},{100,0}}, color={0,127,255}));

//INNER CONNECTIONS

  if dis > 1 then
    for i in 1:(dis-1) loop
      connect(underfloorHeatingElement[i].port_b, underfloorHeatingElement[i + 1].port_a)
        annotation (Line(
          points={{10,0},{10,-10},{-10,-10},{-10,0}},
          color={0,127,255},
          pattern=LinePattern.Dash));
    end for;
  end if;

// HEAT CONNECTIONS

  for i in 1:dis loop
     connect(underfloorHeatingElement[i].heatFloor, heatFloor[i])
    annotation (Line(points={{0,4.2},{0,44}}, color={191,0,0}));
  connect(underfloorHeatingElement[i].heatCeiling, heatCeiling[i]) annotation (Line(
        points={{-0.2,-4.2},{-0.2,-46},{0,-46}}, color={191,0,0}));
    connect(sumT_Fm.port_a[i], underfloorHeatingElement[i].heatFloor)
      annotation (Line(points={{16,16},{0,16},{0,4.2}}, color={191,0,0}));
  end for;

  //OTHER CONNECTIONS
  connect(sumT_Fm.T_Fm, T_Fm.numberPort)
    annotation (Line(points={{28.12,16},{37.25,16}}, color={0,0,127}));
  connect(val.y, valveInput)
    annotation (Line(points={{-74,12},{-74,58}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-40},{100,40}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-100,40},{100,14}},
          lineColor={200,200,200},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,14},{100,-40}},
          lineColor={200,200,200},
          fillColor={150,150,150},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,10},{-80,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(points={{-80,10},{-78,6},{-80,10},{-82,6}}, color={238,46,47}),
        Ellipse(
          extent={{-84,-2},{-76,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-68,-2},{-60,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-52,-2},{-44,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-2},{-28,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-2},{-12,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,-2},{4,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{12,-2},{20,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,-2},{36,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{44,-2},{52,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{60,-2},{68,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{76,-2},{84,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-64,10},{-64,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-48,10},{-48,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-32,10},{-32,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-16,10},{-16,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,10},{0,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{16,10},{16,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{32,10},{32,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{48,10},{48,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{64,10},{64,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{80,10},{80,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(points={{-64,10},{-62,6},{-64,10},{-66,6}}, color={238,46,47}),
        Line(points={{-48,10},{-46,6},{-48,10},{-50,6}}, color={238,46,47}),
        Line(points={{-32,10},{-30,6},{-32,10},{-34,6}}, color={238,46,47}),
        Line(points={{-16,10},{-14,6},{-16,10},{-18,6}}, color={238,46,47}),
        Line(points={{0,10},{2,6},{0,10},{-2,6}}, color={238,46,47}),
        Line(points={{16,10},{18,6},{16,10},{14,6}}, color={238,46,47}),
        Line(points={{32,10},{34,6},{32,10},{30,6}}, color={238,46,47}),
        Line(points={{48,10},{50,6},{48,10},{46,6}}, color={238,46,47}),
        Line(points={{64,10},{66,6},{64,10},{62,6}}, color={238,46,47}),
        Line(points={{80,10},{82,6},{80,10},{78,6}}, color={238,46,47})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-45},{100,45}},
        initialScale=0.1)),Documentation(
   info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for a heating circuit within wall layers
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  The heating circuits consists of <i>dis</i> pipe elements of the
  model <a href=
  \"UnderfloorHeating.UnderfloorHeatingElement\">UnderfloorHeatingElement</a>
</p>
<p>
  The middle surface temperature is calculated and a maximum surface
  temperature is checked within the model.
</p>
<p>
  A two way equal percentage valve sets the pressure difference and
  mass flow.
</p>
<p>
  <b><span style=\"color: #008000;\">Heat Transfer</span></b>
</p>
<p>
  The heat transfer from the fluid to the surface of the wall elements
  is split into the following parts:
</p>
<p>
  - convection from fluid to inner pipe
</p>
<p>
  - heat conduction in pipe layers
</p>
<p>
  - heat transfer from pipe outside to heat conductive floor layer
</p>
<p>
  - heat conduction through upper wall layers
</p>
<p>
  - heat conduction through lower wall layers
</p>
<p>
  <b><span style=\"color: #008000;\">Thermal Resistance R_x</span></b>
</p>
<p>
  The thermal resistance R_x represents the heat transfer from pipe
  outside to the middle temperaatur of the heat conductive layer. It
  needs to be added according to the type of the heating systen (see EN
  11855-2 p. 45).
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
</html>"));
end UnderfloorHeatingCircuit;
