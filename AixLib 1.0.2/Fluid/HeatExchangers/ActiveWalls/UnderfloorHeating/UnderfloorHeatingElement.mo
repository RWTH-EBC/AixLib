within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model UnderfloorHeatingElement "Pipe Segment of Underfloor Heating System"

      extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(allowFlowReversal=
        false, final m_flow_nominal = m_flow_Circuit);
      extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;
      import Modelica.Constants.pi;
   parameter Modelica.Fluid.Types.Dynamics energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance for wall capacities: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics"));
  parameter Integer dis(min = 1) "Parameter to enable dissertisation layers";
  parameter Modelica.SIunits.Length PipeLength "Length of pipe";

  parameter Integer calculateVol "Calculation method to determine Water Volume" annotation (Dialog(group="Calculation Method to determine Water Volume in Pipe",
        descriptionLabel=true), choices(
      choice=1 "Calculation with inner diameter",
      choice=2 "Calculation with time constant",
      radioButtons=true));
  final parameter Modelica.SIunits.Volume V_Water = if calculateVol == 1 then (pi / 4 * d_i[1]^(2) * PipeLength) else (vol.m_flow_nominal * tau / (rho_default * dis))  "Water Volume in Tube";
  final parameter Modelica.SIunits.Time tau = 250 "Time constant to heat up the medium";
  final parameter Modelica.SIunits.Time tau_nom = V_Water * (rho_default * dis) / m_flow_Circuit;

  parameter Modelica.SIunits.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor  "Wall type for floor"      annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  final parameter Integer n_floor(min = 1) = wallTypeFloor.n "Number of floor layers";
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling  "Wall type for ceiling"   annotation (Dialog(group="Room Specifications", enable = Ceiling), choicesAllMatching=true);
  final parameter Integer n_ceiling(min = 1) = wallTypeCeiling.n "Number of ceiling layers";
  parameter AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping.PipeBaseDataDefinition PipeRecord  "Pipe layers"    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  final parameter Integer n_pipe(min = 1) = PipeRecord.n "Number of Pipe Layers";
  final parameter Modelica.SIunits.Thickness d_a[n_pipe] = PipeRecord.d "Outer Diameters of pipe layers";
  final parameter Modelica.SIunits.Thickness d_i[n_pipe] = PipeRecord.d .- 2*PipeRecord.t "Inner Diameters of pipe layers";
  final parameter Modelica.SIunits.ThermalConductivity lambda_pipe[n_pipe] = PipeRecord.lambda "Thermal conductivity of pipe layers";

  parameter Modelica.SIunits.Temperature T0(start = 273.15 + 20) "Start Temperature";

  parameter Modelica.SIunits.MassFlowRate m_flow_Circuit "Nominal Mass Flow Rate";
  final parameter Modelica.SIunits.VolumeFlowRate V_flow = m_flow_Circuit / rho_default "Nominal Volume Flow Rate in pipe";
  parameter Integer use_vmax(min = 1, max = 2) "Output if v > v_max (0.5 m/s)" annotation(choices(choice = 1 "Warning", choice = 2 "Error"));
  final parameter Modelica.SIunits.Velocity v = V_flow / (pi / 4 * d_i[1] ^ (2)) "velocity of medium in pipe";
  final parameter Modelica.SIunits.Diameter d_i_nom = sqrt(4 * V_flow / (pi * 0.5)) "Inner pipe diameter as a comparison for user parameter";

  final parameter Modelica.SIunits.Area A_sur = pi * d_i[1] * PipeLength "Surface area inside the pipe";
  final parameter Modelica.SIunits.CoefficientOfHeatTransfer h_turb = 2200 "Coefficient of heat transfer at the inner surface of pipe due to turbulent flow";

  parameter Modelica.SIunits.ThermalResistance R_x = 0 "Thermal Resistance between Screed and Pipe";

  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    mSenFac=mSenFac,
    allowFlowReversal=false,
    V=V_Water,
    nPorts=2,
    m_flow_nominal=m_flow_Circuit)
    annotation (Placement(transformation(extent={{54,0},{78,24}})));

  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer simpleNLayerFloor(
    final A=A,
    T_start=fill((T0), (n_floor)),
    wallRec=wallTypeFloor,
    energyDynamics=energyDynamicsWalls)
                           annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={0,27})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatFloor
    "upward heat flow to heated room"                                                             annotation (
      Placement(transformation(extent={{-8,34},{8,50}}), iconTransformation(
          extent={{-10,32},{10,52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCeiling "downward heat flow" annotation (
      Placement(transformation(extent={{-8,-48},{8,-32}}), iconTransformation(
          extent={{-12,-52},{8,-32}})));

  AixLib.Utilities.HeatTransfer.CylindricHeatConduction heatCondaPipe[n_pipe](
    d_out=d_a,
    lambda=lambda_pipe,
    d_in=d_i,
    each nParallel=1,
    each length=PipeLength) annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={23,9})));
  AixLib.Utilities.HeatTransfer.HeatConv           heatConvPipeInside(hCon=
        h_turb, A=A_sur)
    annotation (Placement(transformation(extent={{36,8},{44,16}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=R_x)
               annotation (Placement(transformation(extent={{6,10},{14,18}})));
protected
    parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";
initial equation
  if use_vmax == 1 then
  assert(v <= 0.5, "In" + getInstanceName() + "Medium velocity in pipe is "+String(v)+"and exceeds 0.5 m/s", AssertionLevel.warning);
  else
  assert(v <= 0.5, "In" + getInstanceName() + "Medium velocity in pipe is "+String(v)+"and exceeds 0.5 m/s",  AssertionLevel.error);
  end if;
  if calculateVol == 2 then
    if v > 0.5 then
  Modelica.Utilities.Streams.print("d_i_nom ="+String(d_i_nom)+".Use this parameter for useful parametrization of d_i for pipe to stay in velocity range.");
    end if;
  end if;
equation

public
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer simpleNLayerCeiling(
    final A=A,
    T_start=fill((T0), (n_ceiling)),
    wallRec=wallTypeCeiling) annotation (Placement(transformation(
        extent={{7,-8},{-7,8}},
        rotation=90,
        origin={0,-13})));
equation

  // FLUID CONNECTIONS

   connect(port_a, vol.ports[1])
    annotation (Line(points={{-100,0},{63.6,0}}, color={0,127,255}));
   connect(vol.ports[2], port_b)
    annotation (Line(points={{68.4,0},{100,0}}, color={0,127,255}));

  // HEAT CONNECTIONS

      for i in 1:(n_pipe-1) loop
    connect(heatCondaPipe[i].port_b, heatCondaPipe[i + 1].port_a) annotation (
        Line(
        points={{23,15.16},{23,14},{24,14},{24,12},{23,12},{23,9.28}},
        color={191,0,0},
        pattern=LinePattern.Dash));
      end for;

  connect(heatConvPipeInside.port_b, vol.heatPort)
    annotation (Line(points={{44,12},{54,12}}, color={191,0,0}));
  connect(heatConvPipeInside.port_a, heatCondaPipe[1].port_a) annotation (Line(
        points={{36,12},{34,12},{34,9.28},{23,9.28}},color={191,0,0}));
  connect(thermalResistor.port_b, heatCondaPipe[n_pipe].port_b) annotation (Line(
        points={{14,14},{18,14},{18,15.16},{23,15.16}}, color={191,0,0}));

    connect(thermalResistor.port_a, simpleNLayerFloor.port_a)    annotation (Line(points={{6,14},{
            4.44089e-16,14},{4.44089e-16,20}},                                                                   color={191,0,0}));
    connect(thermalResistor.port_a, simpleNLayerCeiling.port_a)    annotation (Line(points={{6,14},{-4.44089e-16,14},{-4.44089e-16,-6}},
                                                    color={191,0,0}));
    connect(simpleNLayerFloor.port_b, heatFloor) annotation (Line(points={{1.33227e-15,
            34},{0,34},{0,42}},
                              color={191,0,0}));
    connect(simpleNLayerCeiling.port_b, heatCeiling) annotation (Line(points={{-1.33227e-15,
          -20},{0,-20},{0,-40}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -40},{100,40}},
        initialScale=0.1),        graphics={
        Rectangle(
          extent={{-100,40},{100,18}},
          lineColor={135,135,135},
          fillColor={175,175,175},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-100,18},{100,-18}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-100,14},{100,-14}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-100,-18},{100,-40}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Backward)}),  Documentation(
   info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for heat transfer of a pipe element within wall layers
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  The fluid in the pipe segment is represented by a mass flow and a
  volume element with heat transfer.
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
</html>"),                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,
            40}},
        initialScale=0.1)));
end UnderfloorHeatingElement;
