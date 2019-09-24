within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl;
model VolumeFlowController

  replaceable package Medium = AixLib.Media.Water;

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput setPoint "[0..1]" annotation (
      Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={0,99})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Continuous.LimPID P(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMax=0.999,
    yMin=0.001) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,42})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-64})));
  Modelica.Blocks.Math.Add add(k1=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,58})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-29,64})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium =
        Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,0})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-30})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-88},{-90,-68}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Medium) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-74,-78})));
  Modelica.Blocks.Continuous.LimPID PI(
    yMax=0.999,
    yMin=0.001,
    k=1/6,
    Ti=5,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    controllerType=Modelica.Blocks.Types.SimpleController.PI) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={34,42})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 30)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=180,
        origin={69,67})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-5,14})));
  Modelica.Blocks.Logical.LessThreshold greaterThreshold(threshold=0.21)
    annotation (Placement(transformation(extent={{14,78},{26,90}})));
  Modelica.Blocks.Math.Max max annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={43,-41})));
  Modelica.Blocks.Sources.Constant const2(k=0.001)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=180,
        origin={69,-27})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening
                                            HK12Y1(redeclare package Medium =
        Medium,
    dpValve_nominal=6000,
    m_flow_nominal=10)              annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-72,0})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening
                                            HK11Y1(redeclare package Medium =
        Medium,
    dpValve_nominal=6000,
    m_flow_nominal=10)              annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={0,-26})));
  Modelica.Blocks.Interfaces.RealOutput opening_HK11Y1
    "Connector of Real output signal" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,-100})));
  Modelica.Blocks.Math.Add add1(
                               k1=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={82,26})));
  Modelica.Blocks.Sources.Constant const3(
                                         k=1)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=180,
        origin={91,68})));
equation
  connect(massFlowRate.port_b, port_b2) annotation (Line(points={{
          -1.83187e-015,-74},{-1.83187e-015,-87},{0,-87},{0,-100}}, color={0,
          127,255}));
  connect(setPoint, P.u_s) annotation (Line(points={{0,99},{0,54},{
          2.22045e-015,54}}, color={0,0,127}));
  connect(port_a, massFlowRate1.port_a) annotation (Line(points={{100,0},{75,
          0},{75,-1.22125e-015},{50,-1.22125e-015}}, color={0,127,255}));
  connect(massFlowRate.m_flow, division.u1) annotation (Line(points={{-11,-64},
          {-36,-64},{-56,-64},{-56,-42}}, color={0,0,127}));
  connect(division.y, P.u_m) annotation (Line(points={{-50,-19},{-50,-19},{
          -50,42},{-12,42}}, color={0,0,127}));
  connect(temperature.port, port_a1) annotation (Line(points={{-84,-78},{-84,-78},
          {-100,-78}}, color={0,127,255}));
  connect(temperature.T, PI.u_m) annotation (Line(points={{-74,-71},{-74,-72},
          {-74,-16},{18,-16},{18,42},{22,42}}, color={0,0,127}));
  connect(const1.y, PI.u_s) annotation (Line(points={{63.5,67},{63.5,68},{34,
          68},{34,54}},
                    color={0,0,127}));
  connect(setPoint, greaterThreshold.u)
    annotation (Line(points={{0,99},{0,84},{12.8,84}}, color={0,0,127}));
  connect(massFlowRate1.m_flow, max.u2)
    annotation (Line(points={{40,-11},{40,-35}}, color={0,0,127}));
  connect(const2.y, max.u1) annotation (Line(points={{63.5,-27},{46,-27},{46,
          -35}}, color={0,0,127}));
  connect(max.y, division.u2) annotation (Line(points={{43,-46.5},{43,-50},{
          -44,-50},{-44,-42}}, color={0,0,127}));
  connect(P.y, switch1.u1) annotation (Line(points={{-1.9984e-015,31},{0,31},
          {0,21.2},{-0.2,21.2}}, color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{26.6,84},
          {54,84},{54,24},{-5,24},{-5,21.2}}, color={255,0,255}));
  connect(massFlowRate1.port_b, HK12Y1.port_a)
    annotation (Line(points={{30,0},{-18,0},{-66,0}}, color={0,127,255}));
  connect(HK12Y1.port_b, port_b1)
    annotation (Line(points={{-78,0},{-100,0}}, color={0,127,255}));
  connect(massFlowRate1.port_b, HK11Y1.port_a)
    annotation (Line(points={{30,0},{0,0},{0,-20}}, color={0,127,255}));
  connect(HK11Y1.port_b, massFlowRate.port_a)
    annotation (Line(points={{0,-32},{0,-43},{0,-54}}, color={0,127,255}));
  connect(switch1.y, HK11Y1.y) annotation (Line(points={{-5,7.4},{-5,-12},{
          -26,-12},{-26,-26},{-7.2,-26}}, color={0,0,127}));
  connect(switch1.y, opening_HK11Y1) annotation (Line(points={{-5,7.4},{-5,
          -12},{-26,-12},{-26,-100}}, color={0,0,127}));
  connect(add.u2, const.y) annotation (Line(points={{-48,64},{-42,64},{-34.5,
          64}}, color={0,0,127}));
  connect(add.y, HK12Y1.y)
    annotation (Line(points={{-71,58},{-72,58},{-72,7.2}}, color={0,0,127}));
  connect(switch1.y, add.u1) annotation (Line(points={{-5,7.4},{-5,6},{-38,6},
          {-38,52},{-48,52}}, color={0,0,127}));
  connect(PI.y, add1.u1) annotation (Line(points={{34,31},{34,28},{64,28},{64,
          50},{88,50},{88,38}}, color={0,0,127}));
  connect(const3.y, add1.u2) annotation (Line(points={{85.5,68},{80,68},{76,
          68},{76,38}}, color={0,0,127}));
  connect(add1.y, switch1.u3) annotation (Line(points={{82,15},{82,8},{62,8},
          {62,18},{14,18},{14,28},{-9.8,28},{-9.8,21.2}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
                                Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={
              {-98,108},{106,-108}}, fileName=
              "N:/Forschung/EBC0155_PTJ_Exergiebasierte_regelung_rsa/Students/Students-Exchange/Photos Dymola/Splitter.jpg"),
          Text(
          extent={{-32,-28},{30,-92}},
          lineColor={255,255,255},
          textString="Spl")}));
end VolumeFlowController;
