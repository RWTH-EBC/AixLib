within AixLib.Fluid.Movers.Compressors.Validation;
model SimpleHeatTransfer
  "Validation model to check the implementation of the simple heat transfer"
  extends Modelica.Icons.Example;

  // Define medium and parameters
  //
  package Medium =
   Modelica.Media.R134a.R134a_ph
   "Medium of the compressor";

  parameter Modelica.Units.SI.AbsolutePressure pInl=Medium.pressure(
      Medium.setBubbleState(Medium.setSat_T(TInl + 2)))
    "Current pressure at inlet conditions";
  parameter Modelica.Units.SI.Temperature TInl=283.15
    "Current temperature at inlet conditions";
  parameter Modelica.Units.SI.AbsolutePressure pOut=Medium.pressure(
      Medium.setDewState(Medium.setSat_T(TOut - 5)))
    "Current set point of the compressor's outlet pressure";
  parameter Modelica.Units.SI.Temperature TOut=333.15
    "Current temperature at outlet conditions";

  // Definition of submodels and connectors
  //
  Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    nPorts=1,
    m_flow=0.1,
    T=TInl) "Source of constant temperature and mass flow rate"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem(T=263.15)
    "Fixed ambient temperature"
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Utilities.HeatTransfer.SimpleHeatTransfer simheaTra(
    redeclare package Medium = Medium)
    "Model of simple one-dimensional heat transfer"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  MixingVolumes.MixingVolume sink(
    redeclare package Medium = Medium,
    nPorts=1,
    V=10e-3,
    m_flow_nominal=0.1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    p_start=pInl,
    T_start=TInl) "Sink that allows storage of mass and energy"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={70,0})));


equation
  // Connection of main components
  //
  connect(fixTem.port, simheaTra.heatPort)
    annotation (Line(points={{-60,-30},{0,-30},{0,-10}}, color={191,0,0}));
  connect(source.ports[1], simheaTra.port_a)
    annotation (Line(points={{-60,0},{-10,0}}, color={0,127,255}));
  connect(simheaTra.port_b, sink.ports[1])
    annotation (Line(points={{10,0},{34,0},{34,1.77636e-015},
                {60,1.77636e-015}}, color={0,127,255}));

  annotation (Documentation(revisions="<html><ul>
  <li>October 30, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a simple validation model to test the one-directional heat
  transfer. Therefore, an ambient temeprature is prediscribed and an
  expansion vassel is located at the model's outlet.
</p>
</html>"));
end SimpleHeatTransfer;
