within AixLib.Fluid.Examples.ERCBuilding.Control;
model ValveController

  parameter Integer controlStrategy = 2
    "1=external set point, 2=fixed internal set point, 3=heating curve";
  parameter Boolean normalized = true
    "Set to true to have a normalized 0-100% output";
  parameter Real Tset = 310 "Fixed internal set point";
  parameter .Modelica.Blocks.Types.SimpleController controllerType=.Modelica.Blocks.Types.SimpleController.PID
    "Type of controller";
  parameter Real k(
    min=0,
    unit="1") = 1 "Gain of controller";
  parameter .Modelica.SIunits.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block" annotation (Dialog(enable=
          controllerType == .Modelica.Blocks.Types.SimpleController.PI or
          controllerType == .Modelica.Blocks.Types.SimpleController.PID));
  parameter .Modelica.SIunits.Time Td(min=0) = 0.1
    "Time constant of Derivative block";
  parameter Real yMax = 1 "Upper limit of output";
  parameter Real yMin= 0 "Lower limit of output";
  parameter Boolean direction = true
    "'true = positive, false = negative direction of controller";

  Modelica.Blocks.Continuous.LimPID PID(
    k=k,
    Ti=Ti,
    Td=Td,
    controllerType=controllerType,
    yMax=if normalized then 1 else yMax,
    yMin=if normalized then 0 else yMin)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput u_s1 if controlStrategy == 1
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput u_m1
    "Connector of measurement input signal"             annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealOutput y1
    "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Sources.Constant const(k=Tset) if
                                               controlStrategy == 2
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput temperature if
                                               controlStrategy == 3
    "Connector of setpoint input signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Tables.CombiTable1D heatingCurve(table=[260,310; 270,305; 280,
        300; 290,300; 300,300]) if controlStrategy == 3 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
  Modelica.Blocks.Sources.Constant const1(k=1) if
                                               controlStrategy == 2
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
equation

  if direction then
    connect(PID.y, y1);
  else
    connect(add.y, y1);
  end if;

  if controlStrategy == 1 then
    connect(PID.u_s, u_s1)
    annotation (Line(points={{-12,0},{-100,0}}, color={0,0,127}));
  elseif controlStrategy == 2 then
    connect(PID.u_s, const.y);
  elseif controlStrategy == 3 then
    connect(PID.u_s, heatingCurve.y[1]);
    connect(temperature, heatingCurve.u[1]);
  end if;
  connect(PID.u_m, u_m1)
    annotation (Line(points={{0,-12},{0,-100}}, color={0,0,127}));
  connect(PID.y, add.u1) annotation (Line(points={{11,0},{20,0},{20,-20},{48,-20}},
        color={0,0,127}));
  connect(const1.y, add.u2) annotation (Line(points={{31,-40},{40,-40},{40,-32},
          {48,-32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-122,44},{120,-30}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="Valve
Controller")}),                                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ValveController;
