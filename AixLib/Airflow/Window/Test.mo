within AixLib.Airflow.Window;
model Test
  BasicModels.DeGids deGids(winClrW=1, winClrH=1)
    annotation (Placement(transformation(extent={{0,0},{80,80}})));
  Modelica.Blocks.Sources.Step A_set(
    height=0.5,
    offset=0.01,
    startTime=10)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Sine T_a_set(
    amplitude=2,
    f=0.5,
    offset=283)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Sine T_i_set(
    amplitude=5,
    f=0.5,
    phase=3.1415926535898,
    offset=288)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise(
    samplePeriod=1,
    y_min=0,
    y_max=10)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
equation
  connect(A_set.y, deGids.A) annotation (Line(points={{-79,10},{-20,10},{-20,40},
          {-8,40}}, color={0,0,127}));
  connect(T_a_set.y, deGids.T_a)
    annotation (Line(points={{-79,90},{-8,90},{-8,72}}, color={0,0,127}));
  connect(T_i_set.y, deGids.T_i)
    annotation (Line(points={{-79,50},{-8,50},{-8,56}}, color={0,0,127}));
  connect(uniformNoise.y, deGids.u_10)
    annotation (Line(points={{-79,-30},{-8,-30},{-8,24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=60, __Dymola_Algorithm="Dassl"));
end Test;
