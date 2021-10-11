within ControlUnity.flowTemperatureController;
model returnAdmixture
  "Flowtemperature control with a fixed boiler temperature; flow temperature is controlled by three-way valve"
  parameter Modelica.SIunits.Temperature Tflow_target "target flow temperature upstream of the customer";
  parameter Modelica.SIunits.Temperature Tb "Fix boiler temperature";



  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{20,-26},{40,-6}})));
  Modelica.Blocks.Sources.RealExpression Tf_t(y=Tflow_target)
    annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
  Modelica.Blocks.Interfaces.RealInput Tmea
    "Measurement temperature of the return flow" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={30,-100})));
  Modelica.Blocks.Interfaces.RealOutput valvelSet "Valveposition"
    annotation (Placement(transformation(extent={{90,-26},{110,-6}})));
  Modelica.Blocks.Interfaces.RealOutput Tb_fix
    "Fix boiler temperature; can be redefined before each simulation"
    annotation (Placement(transformation(extent={{90,60},{110,80}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tb)
    annotation (Placement(transformation(extent={{14,60},{34,80}})));
equation
  connect(Tf_t.y, PID.u_s)
    annotation (Line(points={{-79,-16},{18,-16}}, color={0,0,127}));
  connect(Tmea, PID.u_m)
    annotation (Line(points={{30,-100},{30,-28}}, color={0,0,127}));
  connect(PID.y, valvelSet)
    annotation (Line(points={{41,-16},{100,-16}}, color={0,0,127}));
  connect(realExpression.y, Tb_fix)
    annotation (Line(points={{35,70},{100,70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture;
