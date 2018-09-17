within AixLib.Fluid.PhysicalCompressors.Example;
model TestCompressor

  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
      tau_constant=10)
    annotation (Placement(transformation(extent={{-118,-10},{-98,10}})));
  BaseClasses.Mechanics.MechanicProcess mechanicProcess
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  BaseClasses.CompressorVolumes compressorVolumes(
    r_cyl=mechanicProcess.r_cyl,
    r_rol=mechanicProcess.r_rol,
    h_cyl=mechanicProcess.h_cyl,
    thi_van=mechanicProcess.h_cyl)
    annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
  Modelica.Blocks.Sources.Constant const(k=500000)
    annotation (Placement(transformation(extent={{-88,56},{-68,76}})));
  Modelica.Blocks.Sources.Constant const1(k=2000000)
    annotation (Placement(transformation(extent={{-52,56},{-32,76}})));
equation
  connect(constantTorque.flange, mechanicProcess.flange_a)
    annotation (Line(points={{-98,0},{-62,0}}, color={0,0,0}));
  connect(mechanicProcess.flange_b, compressorVolumes.flange_a) annotation (
      Line(points={{-42,0},{-32,0},{-32,0},{-22,0}},       color={0,0,0}));
  connect(compressorVolumes.x, mechanicProcess.x) annotation (Line(points={{-0.5,
          -0.7},{10,-0.7},{10,24},{-58,24},{-58,9.8}}, color={0,0,127}));
  connect(const.y, mechanicProcess.p1) annotation (Line(points={{-67,66},{-60,66},
          {-60,36},{-52.6,36},{-52.6,10}}, color={0,0,127}));
  connect(const1.y, mechanicProcess.p2) annotation (Line(points={{-31,66},{-26,66},
          {-26,32},{-47.4,32},{-47.4,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestCompressor;
