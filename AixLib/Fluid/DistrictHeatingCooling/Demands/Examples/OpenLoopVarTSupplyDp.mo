within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples;
model OpenLoopVarTSupplyDp
  "A small open loop example with a Substation with variable dT for fixed return temperature"
  extends Modelica.Icons.Example;

  parameter Modelica.Units.SI.Temperature T_amb=283.15
    "Ambient temperature around pipes";

  package Medium = AixLib.Media.Specialized.Water.ConstantProperties_pT (
    T_nominal=273.15+60,
    p_nominal=600000.0,
    T_default=273.15+60);

  Supplies.OpenLoop.SourceIdeal sourceIdeal(
    redeclare package Medium = Medium,
    TReturn=273.15 + 60,
    pReturn=200000)      "Simple suppy model"
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop.VarTSupplyDp    demand(
    redeclare package Medium = Medium,
    dp_nominal=50000,
    Q_flow_nominal=78239.1,
    dTDesign=15,
    TReturn=333.15)         "Simple demand model" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-2,-60})));
  FixedResistances.PlugFlowPipe pipeSupply(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Supply pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,0})));
  FixedResistances.PlugFlowPipe pipeReturn(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Return pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  Modelica.Blocks.Sources.Constant TSet(k=75 + 273.15)
                                                      "Set supply temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,88})));
  Modelica.Blocks.Sources.Constant dpSet(k=1.4e5)
    "Set pressure difference for substation" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-30,-2})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TGround
    "Ground temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-40})));
  Modelica.Blocks.Sources.Constant TGroundSet(k=10 + 273.15)
    "Set ground temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-80})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=12000,
    f=1/10000,
    offset=24000) "A sine wave for varying heat demands" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-86})));
  Modelica.Blocks.Continuous.LimPID pControl(controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=6e5) "Pressure controller" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,30})));
equation
  connect(sourceIdeal.port_b, pipeSupply.port_a)
    annotation (Line(points={{10,60},{60,60},{60,10}}, color={0,127,255}));
  connect(pipeSupply.ports_b[1], demand.port_a)
    annotation (Line(points={{60,-10},{60,-60},{8,-60}},  color={0,127,255}));
  connect(demand.port_b, pipeReturn.port_a) annotation (Line(points={{-12,-60},{
          -60,-60},{-60,-10}}, color={0,127,255}));
  connect(pipeReturn.ports_b[1], sourceIdeal.port_a)
    annotation (Line(points={{-60,10},{-60,60},{-10,60}}, color={0,127,255}));
  connect(TSet.y, sourceIdeal.TIn)
    annotation (Line(points={{-20,77},{-20,67},{-10.6,67}}, color={0,0,127}));
  connect(TGroundSet.y, TGround.T)
    annotation (Line(points={{-80,-69},{-80,-52}}, color={0,0,127}));
  connect(TGround.port, pipeReturn.heatPort)
    annotation (Line(points={{-80,-30},{-80,0},{-70,0}}, color={191,0,0}));
  connect(TGround.port, pipeSupply.heatPort) annotation (Line(points={{-80,-30},
          {-80,-20},{80,-20},{80,0},{70,0}}, color={191,0,0}));
  connect(demand.Q_flow_input, sine.y)
    annotation (Line(points={{8.8,-68},{60,-68},{60,-75}},  color={0,0,127}));
  connect(dpSet.y, pControl.u_s)
    annotation (Line(points={{-30,9},{-30,18}}, color={0,0,127}));
  connect(demand.dpOut, pControl.u_m) annotation (Line(points={{-12.8,-68},{-20,
          -68},{-20,-40},{0,-40},{0,30},{-18,30}}, color={0,0,127}));
  connect(pControl.y, sourceIdeal.dpIn)
    annotation (Line(points={{-30,41},{-30,53},{-10.6,53}}, color={0,0,127}));
  annotation (
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/DistrictHeatingCooling/Demands/Examples/OpenLoopVarTSupplyDp.mos"
                      "Simulate and plot"),
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000, Tolerance=1e-006, __Dymola_Algorithm="Cvode"),
    Documentation(revisions="<html><ul>
  <li>March 17, 2018, by Marcus Fuchs:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This is an OpenLoop example of <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop.VarTSupplyDp\">
  AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop.VarTSupplyDp</a>
  which is a simple substation model using a fixed return temperature
  and the actual supply temperature to calculate the mass flow rate
  drawn from the network. This model uses an open loop design to
  prescribe the required flow rate.
</p>
</html>"));
end OpenLoopVarTSupplyDp;
