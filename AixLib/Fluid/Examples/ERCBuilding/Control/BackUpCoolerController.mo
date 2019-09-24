within AixLib.Fluid.Examples.ERCBuilding.Control;
model BackUpCoolerController

  replaceable package Medium = AixLib.Media.Water;

  Modelica.Blocks.Interfaces.RealInput setPoint "[0..1]" annotation (
      Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={0,99})));
  Modelica.Blocks.Continuous.LimPID P(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMax=0.999,
    yMin=0.001) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,42})));
  Modelica.Blocks.Math.Add add(k1=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,58})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-29,64})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-30})));
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
  Modelica.Blocks.Interfaces.RealOutput opening_HK11Y1
    "Connector of Real output signal" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={56,-90})));
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
  Modelica.Blocks.Interfaces.RealInput massFlowTotal
    "Inflow in GC 3W valve"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-40})));
  Modelica.Blocks.Interfaces.RealInput massFlowGC "Flow to GC" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-56,-100})));
  Modelica.Blocks.Interfaces.RealInput temperatureGCReturn
    "Return temperature from GC"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
equation
  connect(setPoint, P.u_s) annotation (Line(points={{0,99},{0,54},{
          2.22045e-015,54}}, color={0,0,127}));
  connect(division.y, P.u_m) annotation (Line(points={{-50,-19},{-50,-19},{
          -50,42},{-12,42}}, color={0,0,127}));
  connect(const1.y, PI.u_s) annotation (Line(points={{63.5,67},{63.5,68},{34,
          68},{34,54}},
                    color={0,0,127}));
  connect(setPoint, greaterThreshold.u)
    annotation (Line(points={{0,99},{0,84},{12.8,84}}, color={0,0,127}));
  connect(const2.y, max.u1) annotation (Line(points={{63.5,-27},{46,-27},{46,
          -35}}, color={0,0,127}));
  connect(max.y, division.u2) annotation (Line(points={{43,-46.5},{43,-50},{
          -44,-50},{-44,-42}}, color={0,0,127}));
  connect(P.y, switch1.u1) annotation (Line(points={{-1.9984e-015,31},{0,31},
          {0,21.2},{-0.2,21.2}}, color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{26.6,84},
          {54,84},{54,24},{-5,24},{-5,21.2}}, color={255,0,255}));
  connect(add.u2, const.y) annotation (Line(points={{-48,64},{-42,64},{-34.5,
          64}}, color={0,0,127}));
  connect(switch1.y, add.u1) annotation (Line(points={{-5,7.4},{-5,6},{-38,6},
          {-38,52},{-48,52}}, color={0,0,127}));
  connect(PI.y, add1.u1) annotation (Line(points={{34,31},{34,28},{64,28},{64,
          50},{88,50},{88,38}}, color={0,0,127}));
  connect(const3.y, add1.u2) annotation (Line(points={{85.5,68},{80,68},{76,
          68},{76,38}}, color={0,0,127}));
  connect(add1.y, switch1.u3) annotation (Line(points={{82,15},{82,8},{62,8},
          {62,18},{14,18},{14,28},{-9.8,28},{-9.8,21.2}}, color={0,0,127}));
  connect(max.u2, massFlowTotal) annotation (Line(points={{40,-35},{40,-16},{86,
          -16},{86,-40},{100,-40}}, color={0,0,127}));
  connect(division.u1, massFlowGC)
    annotation (Line(points={{-56,-42},{-56,-100}}, color={0,0,127}));
  connect(PI.u_m, temperatureGCReturn) annotation (Line(points={{22,42},{16,42},
          {16,0},{-100,0}}, color={0,0,127}));
  connect(add.y, opening_HK11Y1) annotation (Line(points={{-71,58},{-74,58},{
          -74,56},{-74,-10},{-26,-10},{-26,-100}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-118,48},{124,-26}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="Cooler
Controller")}));
end BackUpCoolerController;
