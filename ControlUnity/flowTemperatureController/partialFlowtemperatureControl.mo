within ControlUnity.flowTemperatureController;
partial model partialFlowtemperatureControl
  parameter Boolean severalHeatcurcuits=false "If true, there are two or more heat curcuits";


  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0) "PI Controller for controlling the valve position"
            annotation (Placement(transformation(extent={{-30,-26},{-10,-6}})));
  Modelica.Blocks.Interfaces.RealOutput valPos "Valve position"
    annotation (Placement(transformation(extent={{90,-26},{110,-6}})));
  Modelica.Blocks.Interfaces.RealInput TMea annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-100})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-120,-36},{-80,4}})));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{92,70},{112,90}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        severalHeatcurcuits)
    annotation (Placement(transformation(extent={{14,70},{34,90}})));
  Modelica.Blocks.Continuous.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0) "PI Controller for controlling the PLR"
            annotation (Placement(transformation(extent={{-10,34},{10,54}})));
equation
  connect(booleanExpression.y, switch1.u2)
    annotation (Line(points={{35,80},{48,80}}, color={255,0,255}));
  connect(switch1.y, PLRset)
    annotation (Line(points={{71,80},{102,80}}, color={0,0,127}));
  connect(PLRin, switch1.u1) annotation (Line(points={{-100,80},{-28,80},{-28,88},
          {48,88}}, color={0,0,127}));
  connect(PID1.y, switch1.u3) annotation (Line(points={{11,44},{28,44},{28,72},{
          48,72}}, color={0,0,127}));
  connect(u, PID.u_s)
    annotation (Line(points={{-100,-16},{-32,-16}}, color={0,0,127}));
  connect(PID.y, valPos)
    annotation (Line(points={{-9,-16},{100,-16}}, color={0,0,127}));
  connect(TMea, PID.u_m)
    annotation (Line(points={{-20,-100},{-20,-28}}, color={0,0,127}));
  connect(TMea, PID1.u_m) annotation (Line(points={{-20,-100},{-20,-60},{0,-60},
          {0,32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialFlowtemperatureControl;
