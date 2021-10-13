within ControlUnity.flowTemperatureController.renturnAdmixture;
partial model partialReturnAdmixture
  "Flowtemperature control with a fixed boiler temperature; flow temperature is controlled by three-way valve"

  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{20,-26},{40,-6}})));
  Modelica.Blocks.Interfaces.RealInput TMea
    "Measurement temperature of the return flow" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={30,-100})));
  Modelica.Blocks.Interfaces.RealOutput y "Valveposition"
    annotation (Placement(transformation(extent={{90,-26},{110,-6}})));
equation
  connect(TMea, PID.u_m)
    annotation (Line(points={{30,-100},{30,-28}}, color={0,0,127}));
  connect(PID.y, y)
    annotation (Line(points={{41,-16},{100,-16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialReturnAdmixture;
