within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model UnderfloorHeatingElement "Pipe Segment of Underfloor Heating System"
  extends AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PartialUnderFloorHeating;

  parameter Modelica.Units.SI.Length length "Length of pipe"
    annotation (Dialog(group="Panel Heating"));
  parameter Integer nPipeLay=if withSheathing then 2 else 1
    "Number of pipe layers";
  final parameter Modelica.Units.SI.Volume VWat=Modelica.Constants.pi/4*dInn^
      (2)*length "Water Volume in Tube";
  final parameter Modelica.Units.SI.Time tau=VWat*(rho_default*dis)/
      m_flow_nominal;

  final parameter Modelica.Units.SI.Velocity v=V_flow_nominal/(Modelica.Constants.pi/4*dInn^(2))
    "velocity of medium in pipe";

  final parameter Modelica.Units.SI.Diameter dInnMin=sqrt(4*V_flow_nominal/(
      Modelica.Constants.pi*0.5))
    "Inner pipe diameter as a comparison for user parameter";

  final parameter Modelica.Units.SI.Area APipeInnSuf=Modelica.Constants.pi*dInn*length "Surface area inside the pipe";
  final parameter Modelica.Units.SI.CoefficientOfHeatTransfer hPipeInnTurb=2200
    "Coefficient of heat transfer at the inner surface of pipe due to turbulent flow";

  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start,
    final C_nominal=C_nominal,
    final mSenFac=mSenFac,
    final allowFlowReversal=false,
    final V=VWat,
    final nPorts=2,
    final m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer nLayFloor(
    final A=A,
    final T_start=fill((T_start), (wallTypeFloor.n)),
    final wallRec=wallTypeFloor,
    final energyDynamics=energyDynamicsWalls) "N-Layer floor model" annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={50,70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorFloor
    "Upward heat flow to heated room" annotation (Placement(transformation(
          extent={{-8,92},{8,108}}), iconTransformation(extent={{-10,32},{10,52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorCei
    "Downward heat flow to ceiling" annotation (Placement(transformation(extent=
           {{-8,-108},{8,-92}}), iconTransformation(extent={{-12,-112},{8,-92}})));

  AixLib.Utilities.HeatTransfer.CylindricHeatConduction pipeHeaCon[nPipeLay](
    final d_out=if withSheathing then {dOut, dOut + thicknessSheathing} else {dOut},
    final lambda=if withSheathing then {pipeMaterial.lambda,sheathingMaterial.lambda} else {pipeMaterial.lambda},
    final d_in=if withSheathing then {dInn, dOut} else {dInn},
    each final nParallel=1,
    each final length=length) "Cylindric heat conduction through pipe" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-30,60})));
  AixLib.Utilities.HeatTransfer.HeatConv heatConvPipeInside(hCon=hPipeInnTurb,
      A=APipeInnSuf) annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={-30,30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor theRes(R=R_x)
    "Thermal resistance between screed and pipe"
    annotation (Placement(transformation(extent={{20,40},{0,60}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer nLayCei(
    final A=A,
    T_start=fill((T_start), (wallTypeCeiling.n)),
    wallRec=wallTypeCeiling) "N-Layer ceiling model" annotation (Placement(
        transformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={50,-30})));

initial equation
  if raiseErrorForMaxVelocity then
    assert(v <= 0.5, "In" + getInstanceName() +
    "Medium velocity in pipe is "+String(v)+"and exceeds 0.5 m/s. 
    Use dInn =" + String(dInnMin) + " to stay in velocity range.", AssertionLevel.warning);
  else
    assert(v <= 0.5, "In" + getInstanceName() +
    "Medium velocity in pipe is "+String(v)+"and exceeds 0.5 m/s. 
    Use dInn =" + String(dInnMin) + " to stay in velocity range.",  AssertionLevel.error);
  end if;
equation

  // FLUID CONNECTIONS

   connect(port_a, vol.ports[1])
    annotation (Line(points={{-100,0},{-1,0}},   color={0,127,255}));
   connect(vol.ports[2], port_b)
    annotation (Line(points={{1,0},{100,0}},    color={0,127,255}));

  // HEAT CONNECTIONS

  for i in 1:(nPipeLay - 1) loop
    connect(pipeHeaCon[i].port_b, pipeHeaCon[i + 1].port_a) annotation (Line(
        points={{-21.2,60},{-29.6,60}},
        color={191,0,0},
        pattern=LinePattern.Dash));
      end for;

  connect(nLayFloor.port_b, heaPorFloor) annotation (Line(points={{50,82},{50,84},
          {0,84},{0,100}}, color={191,0,0}));
  connect(nLayCei.port_b, heaPorCei) annotation (Line(points={{50,-42},{50,-86},
          {0,-86},{0,-100}}, color={191,0,0}));

  connect(heatConvPipeInside.port_b, vol.heatPort)
    annotation (Line(points={{-30,18},{-30,10},{-10,10}},
                                               color={191,0,0}));
  connect(heatConvPipeInside.port_a, pipeHeaCon[1].port_a) annotation (Line(
        points={{-30,42},{-30,51},{-29.6,51},{-29.6,60}}, color={191,0,0}));
  connect(theRes.port_b, pipeHeaCon[nPipeLay].port_b) annotation (Line(points={{0,
          50},{-6,50},{-6,60},{-21.2,60}}, color={191,0,0}));
  connect(theRes.port_a, nLayFloor.port_a)
    annotation (Line(points={{20,50},{50,50},{50,58}}, color={191,0,0}));
  connect(theRes.port_a, nLayCei.port_a)
    annotation (Line(points={{20,50},{50,50},{50,-18}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}},
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
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end UnderfloorHeatingElement;
