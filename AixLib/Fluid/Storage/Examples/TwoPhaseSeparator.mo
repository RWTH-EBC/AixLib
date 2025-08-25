within AixLib.Fluid.Storage.Examples;
model TwoPhaseSeparator
  "Test model to show the functionality of the two-phase seperator"
  extends Modelica.Icons.Example;

  // Definition of medium and parameters
  //
  package Medium =
   Modelica.Media.R134a.R134a_ph
   "Actual medium of the compressor";

  parameter Modelica.Units.SI.AbsolutePressure pInl=Medium.pressure(
      Medium.setBubbleState(Medium.setSat_T(TInl + 5)))
    "Actual pressure at inlet conditions";
  parameter Modelica.Units.SI.Temperature TInl=323.15
    "Actual temperature at inlet conditions";
  parameter Modelica.Units.SI.AbsolutePressure pOut=Medium.pressure(
      Medium.setDewState(Medium.setSat_T(TOut)))
    "Actual set point of the compressor's outlet pressure";
  parameter Modelica.Units.SI.Temperature TOut=333.15
    "Actual temperature at outlet conditions";



  // Definition of models
  //
  Modelica.Blocks.Sources.Ramp ramphInl(
    duration=100,
    height=-2e3,
    offset=hInl,
    startTime=100)
    "Ramp to provide temperature at tank's inlet"
    annotation (Placement(transformation(extent={{-88,72},{-68,92}})));
  Sources.MassFlowSource_h source(
    redeclare package Medium = Medium,
    m_flow=0.5,
    use_h_in=true,
    nPorts=1)
    "Source of constant mass flow and variable temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,50})));
  AixLib.Fluid.Storage.TwoPhaseSeparator twoPhaseSeperator(
    redeclare package Medium = Medium,
    pTan0=pInl,
    show_T=true,
    show_V_flow=true,
    useHeatLoss=true,
    show_tankPropertiesDetailed=true,
    steSta=false,
    show_heatLosses=true,
    VTanInn=10e-3)
    "Model of a two-phase tank loacted after condenser"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sources.Boundary_ph              sink(
    redeclare package Medium = Medium,
    use_p_in=true,
    h=hOut,
    nPorts=1)
    "Sink of constant temperature and variable pressure" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-50})));
  Modelica.Blocks.Sources.Ramp rampPOut(
    duration=500,
    height=pOut - pInl,
    offset=pInl,
    startTime=300)
    "Ramp to provide pressure at tank's outlet"
    annotation (Placement(transformation(extent={{90,-90},{70,-70}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperature(T=275.15)
    "Fixed ambient temperature to simulate heat losses to ambient"
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));

protected
  parameter Modelica.Units.SI.SpecificEnthalpy hInl=Medium.bubbleEnthalpy(
      Medium.setSat_p(pInl)) "Actiual enthalpy at inlet conditions";
  parameter Modelica.Units.SI.SpecificEnthalpy hOut=Medium.bubbleEnthalpy(
      Medium.setSat_p(pOut)) "Actiual enthalpy at inlet conditions";

equation
  // Connections of the models
  //
  connect(source.ports[1], twoPhaseSeperator.port_a)
    annotation (Line(points={{-20,50},{0,50},{0,10}}, color={0,127,255}));
  connect(twoPhaseSeperator.port_b,sink. ports[1])
    annotation (Line(points={{0,-10},{0,-50},{20,-50}}, color={0,127,255}));
  connect(rampPOut.y,sink. p_in)
    annotation (Line(points={{69,-80},{50,-80},{50,-42},{42,-42}},
                color={0,0,127}));
  connect(fixedTemperature.port, twoPhaseSeperator.heatPort)
    annotation (Line(points={{70,0},{8.2,0}}, color={191,0,0}));

  connect(ramphInl.y, source.h_in) annotation (Line(points={{-67,82},{-48,82},{-48,
          54},{-42,54}}, color={0,0,127}));
  annotation (Documentation(revisions="<html><ul>
  <li>October 18, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a simple example model to test the two-phase separator model.
  Therefore, the tank's temperature at inlet is a function of time as
  well as the tank's pressure at outlet. The time dependencies of
  temperature and pressure leads to changes of steam quality at inlet
  and outlet conditions as well as the tank's mean steam quality.
</p>
<h4>
  Suggestions
</h4>Although the two-phase separator works for water introduced as
two-phase medium (e.g. <a href=
\"modelica://Modelica.Media.Water.WaterIF97_ph\">WaterIF97_phy</a>), it
is recommended to use refrigerants as working fluids.
</html>"), experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end TwoPhaseSeparator;
