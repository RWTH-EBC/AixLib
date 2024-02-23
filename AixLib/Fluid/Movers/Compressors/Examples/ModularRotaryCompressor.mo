within AixLib.Fluid.Movers.Compressors.Examples;
model ModularRotaryCompressor
  "Example model to test modular rotary compressors"
  extends Modelica.Icons.Example;

  // Define medium and parameters
  //
  package Medium =
   Modelica.Media.R134a.R134a_ph
   "Medium of the compressor";

  parameter Integer nCom = 2
    "Number of compressors";
  parameter Modelica.Units.SI.AbsolutePressure pInl=Medium.pressure(
      Medium.setBubbleState(Medium.setSat_T(TInl + 1)))
    "Current pressure at inlet conditions";
  parameter Modelica.Units.SI.Temperature TInl=283.15
    "Current temperature at inlet conditions";
  parameter Modelica.Units.SI.AbsolutePressure pOut=Medium.pressure(
      Medium.setDewState(Medium.setSat_T(TOut - 5)))
    "Current set point of the compressor's outlet pressure";
  parameter Modelica.Units.SI.Temperature TOut=333.15
    "Current temperature at outlet conditions";

  // Definition of models
  //
  Sources.Boundary_pT   source(
    redeclare package Medium = Medium,
    p=pInl,
    T=TOut,
    nPorts=1) "Source with constant pressure and temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,70})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem[nCom](
    each T=283.15)
    "Fixed ambient temperature"
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  replaceable ModularCompressors.ModularCompressors modCom(
    nCom=nCom,
    redeclare package Medium = Medium,
    redeclare model SimpleCompressor =
        SimpleCompressors.RotaryCompressors.RotaryCompressor,
    redeclare model EngineEfficiency =
        Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare model VolumetricEfficiency =
        Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare model IsentropicEfficiency =
        AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare model ModularController =
        Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
    useExt=false,
    show_parCom=false,
    show_parCon=false,
    VDis={5e-6,14e-6},
    useInpFil={true,true},
    risTim={0.25,0.5},
    yMax={120,120})
    "Model of modular compressors in parallel"
    annotation (Placement(transformation(extent={{-18,-18},{18,18}},
                rotation=-90,
                origin={40,0})));
  Modelica.Blocks.Sources.Sine valOpe(
    offset=0.5,
    amplitude=0.3,
    f=1) "Prescribed valve's opening"
    annotation (Placement(transformation(extent={{-88,-80},{-68,-60}})));
  Obsolete.Year2021.Fluid.Actuators.Valves.SimpleValve simVal(
    redeclare package Medium = Medium,
    m_flow_start=0.025,
    m_flow_small=1e-6,
    Kvs=1.4) "Model of a simple valve to simulate pressure losses" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={40,-40})));
  Sources.Boundary_pT   sink(
    redeclare package Medium = Medium,
    nPorts=1,
    p=pInl,
    T=TInl) "Sink with constant pressure and temperature"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=-90,
                origin={40,-72})));

  Controls.Interfaces.ModularHeatPumpControlBus dataBus(
    nCom=nCom) "Connector that contains all control signals"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
                rotation=-90,
                origin={0,0})));
  Modelica.Blocks.Sources.Sine rotSpe(
    f=1,
    amplitude=50,
    offset=50) "Input signal to prediscribe compressors' rotational speeds"
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Modelica.Blocks.Routing.Replicator repRotSpe(nout=nCom)
    "Replicating the compressors' rotational speedsl"
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Routing.Replicator repInt(nout=nCom)
    "Replicating the internal set signal"
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Routing.Replicator repMea(nout=nCom)
    "Replicating the current value of the controlled variables"
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Blocks.Sources.Ramp ramMea(
    duration=1,
    height=60,
    offset=40)
    "Ramp to fake current value sof the controlled variables"
    annotation (Placement(transformation(extent={{-88,-40},{-68,-20}})));


equation
  // Connection of main components
  //
  connect(source.ports[1], modCom.port_a)
    annotation (Line(points={{40,60},{40,40},{40,18}}, color={0,127,255}));
  connect(fixTem.port, modCom.heatPort)
    annotation (Line(points={{70,0},{64,0},{58,0}}, color={191,0,0}));
  connect(modCom.port_b, simVal.port_a)
    annotation (Line(points={{40,-18},{40,-18},{40,-30}}, color={0,127,255}));
  connect(simVal.port_b, sink.ports[1])
    annotation (Line(points={{40,-50},{40,-62}},color={0,127,255}));

  // Connection of control signals
  //
  connect(valOpe.y, simVal.opening)
    annotation (Line(points={{-67,-70},{0,-70},{0,-40},{32,-40}},
                color={0,0,127}));

  connect(dataBus, modCom.dataBus)
    annotation (Line(points={{0,0},{11,0},{22,0}},color={255,204,51},
                thickness=0.5));
  connect(ramMea.y, repMea.u)
    annotation (Line(points={{-67,-30},{-60,-30},{-52,-30}}, color={0,0,127}));
  connect(rotSpe.y, repRotSpe.u)
    annotation (Line(points={{-67,30},{-60,30},{-60,50},{-52,50}},
                color={0,0,127}));
  connect(rotSpe.y, repInt.u)
    annotation (Line(points={{-67,30},{-60,30},{-60,10},{-52,10}},
                color={0,0,127}));
  connect(repInt.y, dataBus.comBus.intSetPoiCom)
    annotation (Line(points={{-29,10},{-24,10},{-20,10},{-20,-0.1},{0.1,-0.1}},
                color={0,0,127}));
  connect(repRotSpe.y, dataBus.comBus.extManVarCom)
  annotation (Line(points={{-29,50},{-20,50},{-20,-0.1},{0.1,-0.1}},
              color={0,0,127}));
  connect(repMea.y, dataBus.comBus.meaConVarCom)
    annotation (Line(points={{-29,-30},{-24,-30},{-20,-30},{-20,-0.1},
                {0.1,-0.1}}, color={0,0,127}));

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a example model to test different modular rotary compressor
  presented in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.ModularCompressors\">AixLib.Fluid.Movers.Compressors.ModularCompressors</a>,
  whereby the thermodynamic states at inlet and outlet of the
  compressor are prescribed in terms of pressure and temperature.
  Therefore, the User can select both different modular modelling
  approaches (e.g. <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.ModularCompressors.ModularCompressors\">
  AixLib.Fluid.Movers.Compressors.ModularCompressors.ModularCompressors</a>
  or <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.ModularCompressors.ModularCompressorsSensors\">
  AixLib.Fluid.Movers.Compressors.ModularCompressors.ModularCompressorsSensors</a>)
  and various efficiency models byusing the dialog menu.
</p>
</html>"),
experiment(StopTime=1),
Diagram(graphics={Text(extent={{-88,86},{-12,74}},
          lineColor={28,108,200},
          textString="Provide dummy signals"),
          Rectangle(extent={{-90,90},{-10,70}},
            lineColor={28,108,200})}));
end ModularRotaryCompressor;
