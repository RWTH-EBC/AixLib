within ControlUnity.flowTemperatureController;
partial model partialFlowtemperatureControl
  parameter Modelica.SIunits.Temperature Tb_max "Maximum temperature at which the boiler is switched off";
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput TMea annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={56,-100})));
equation
  connect(TMea, PID.u_m)
    annotation (Line(points={{56,-100},{56,-12}}, color={0,0,127}));
  connect(PID.y, y) annotation (Line(points={{67,0},{100,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialFlowtemperatureControl;
