within ControlUnity.flowTemperatureController.renturnAdmixture;
model returnAdmixture
  "Flow temperature control with return admixture"
  parameter Integer k(min=2)=2 "Number of heat curcuits";
  parameter Modelica.SIunits.Temperature T[k] "Fix setpoint boiler temperature; can be determinded before simulation";
  parameter Modelica.SIunits.Temperature T_flow "Flow temperature resulting from the return admixture for each heating curcuit";


  Modelica.Blocks.Interfaces.RealInput Tset
    "Set temperatures for k heat curcuits"
    annotation (Placement(transformation(extent={{-120,-38},{-80,2}})));
  Modelica.Blocks.Interfaces.RealOutput valPos
    "Valve position for the k heat curcuits"
    annotation (Placement(transformation(extent={{90,-28},{110,-8}})));
  Modelica.Blocks.Interfaces.RealInput TMea
    "Measurement temperatures for the k heat curcuits" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-10,-28},{10,-8}})));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-2,30},{18,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-64,6},{-44,26}})));
equation
  connect(Tset, PID.u_s)
    annotation (Line(points={{-100,-18},{-12,-18}},
                                                color={0,0,127}));
  connect(PID.y, valPos)
    annotation (Line(points={{11,-18},{100,-18}},
                                              color={0,0,127}));
  connect(PLRin, switch1.u1) annotation (Line(points={{-100,80},{-54,80},{-54,48},
          {-4,48}}, color={0,0,127}));
  connect(isOn, switch1.u2)
    annotation (Line(points={{-100,40},{-4,40}}, color={255,0,255}));
  connect(realExpression.y, switch1.u3) annotation (Line(points={{-43,16},{-24,16},
          {-24,32},{-4,32}}, color={0,0,127}));
  connect(switch1.y, PLRset) annotation (Line(points={{19,40},{70,40},{70,80},{100,
          80}}, color={0,0,127}));
  connect(TMea, PID.u_m)
    annotation (Line(points={{0,-100},{0,-30}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture;
