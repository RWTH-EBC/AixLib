within AixLib.Fluid.Movers.Compressors.Examples;
model RotaryCompressorPressureHeatLosses
  "Example model to test simple rotary compressors with pressure and heat losses"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;

  // Define medium and parameters
  //
  package Medium =
   Modelica.Media.R134a.R134a_ph
   "Medium of the compressor";

  parameter Modelica.SIunits.AbsolutePressure pInl=
    Medium.pressure(Medium.setBubbleState(Medium.setSat_T(TInl+1)))
    "Current pressure at inlet conditions";
  parameter Modelica.SIunits.Temperature TInl = 283.15
    "Current temperature at inlet conditions";
  parameter Modelica.SIunits.AbsolutePressure pOut=
    Medium.pressure(Medium.setDewState(Medium.setSat_T(TOut-5)))
    "Current set point of the compressor's outlet pressure";
  parameter Modelica.SIunits.Temperature TOut = 333.15
    "Current temperature at outlet conditions";

  // Definition of models
  //
  Sources.Boundary_pT   source(
    redeclare package Medium = Medium,
    nPorts=1,
    p=pInl,
    T=TOut) "Source with constant pressure and temperature"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Sine rotSpe(
    amplitude=40,
    offset=80,
    freqHz=1)
    "Prescribed compressor's rotational speed"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem(T=283.15)
    "Fixed ambient temperature"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  SimpleCompressors.RotaryCompressors.RotaryCompressorPressureHeatLosses rotCom(
    redeclare package Medium = Medium,
    show_staEff=true,
    show_qua=true,
    useInpFil=true,
    redeclare model EngineEfficiency =
        Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare model VolumetricEfficiency =
        Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare model IsentropicEfficiency =
        AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    kAMeaInl=5,
    kAMeaOut=15,
    kAMeaAmb=3) "Model of a rotary compressor"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));

  Modelica.Blocks.Sources.Sine valOpe(
    offset=0.5,
    amplitude=0.3,
    freqHz=1)
    "Prescribed valve's opening"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Actuators.Valves.SimpleValve simVal(
    redeclare package Medium = Medium,
    m_flow_start=0.025,
    m_flow_small=1e-6,
    Kvs=1.4) "Model of a simple valve to simulate pressure losses"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  MixingVolumes.MixingVolume sink(
    redeclare package Medium = Medium,
    V=10e-3,
    m_flow_nominal=0.1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    nPorts=1) "Sink with constant pressure and temperature"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={70,0})));

equation
  // Connection of components
  //
  connect(source.ports[1], rotCom.port_a)
    annotation (Line(points={{-60,0},{-60,0},{-30,0}}, color={0,127,255}));
  connect(rotCom.port_b, simVal.port_a)
    annotation (Line(points={{-10,0},{6,0},{20,0}}, color={0,127,255}));
  connect(simVal.port_b, sink.ports[1])
    annotation (Line(points={{40,0},{60,0},{60,1.77636e-015}},
                                                    color={0,127,255}));
  connect(rotSpe.y, rotCom.manVarCom)
    annotation (Line(points={{-59,40},{-26,40},{-26,10}}, color={0,0,127}));
  connect(valOpe.y, simVal.opening)
    annotation (Line(points={{-59,80},{30,80},{30,8}}, color={0,0,127}));
  connect(fixTem.port, rotCom.heatPort)
    annotation (Line(points={{-60,-50},{-20,-50},{-20,-10}}, color={191,0,0}));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This is a example model to test the simple rotary compressor presented in
<a href=\"modelica://AixLib.Fluid.Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressorPressureHeatLosses\">
AixLib.Fluid.Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressorPressureHeatLosses</a>.
Therefore, both the compressor's inlet and outlet conditions are prescribed
in terms of pressure and temperature and the User can select different
efficiency models using the dialog menu.
</p>
</html>"),
experiment(StopTime=1));
end RotaryCompressorPressureHeatLosses;
