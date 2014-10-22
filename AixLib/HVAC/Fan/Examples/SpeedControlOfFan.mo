within AixLib.HVAC.Fan.Examples;
model SpeedControlOfFan "Fan Speed Control Example"
extends Modelica.Icons.Example;
 inner BaseParameters      baseParameters(T0=298.15)
   annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2(use_p_in=false, p=
        100000)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,0})));
  FanSimple fanSimple(UseRotationalSpeedInput=true)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Ductwork.VolumeFlowController volumeFlowController(D=0.3)
    annotation (Placement(transformation(extent={{6,25},{26,15}})));
  Modelica.Blocks.Sources.RealExpression V_dot_set(y=0.4) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={16,0})));
  Modelica.Blocks.Sources.RealExpression n_relative(y=0.6)
    annotation (Placement(transformation(extent={{-52,26},{-32,46}})));
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(
                                                    use_p_in=false, h=1e3)
    annotation (Placement(transformation(extent={{-72,-12},{-52,8}})));
  FanSimple fanSimple1(UseRotationalSpeedInput=false)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Ductwork.VolumeFlowController volumeFlowController1(D=0.3)
    annotation (Placement(transformation(extent={{6,-25},{26,-15}})));
equation
  connect(V_dot_set.y, volumeFlowController.VolumeFlowSet) annotation (Line(
      points={{5,1.33227e-015},{2,1.33227e-015},{2,17.9},{5.2,17.9}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(fanSimple.portMoistAir_b, volumeFlowController.portMoistAir_a)
    annotation (Line(
      points={{-10,20},{6,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volumeFlowController.portMoistAir_b, boundaryMoistAir_phX2.portMoistAir_a)
    annotation (Line(
      points={{26,20},{32,20},{32,1.33227e-015},{40,1.33227e-015}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(n_relative.y, fanSimple.n_relative) annotation (Line(
      points={{-31,36},{-20,36},{-20,30.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundaryMoistAir_phX1.portMoistAir_a, fanSimple1.portMoistAir_a)
    annotation (Line(
      points={{-52,-2},{-40,-2},{-40,-20},{-30,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fanSimple1.portMoistAir_b, volumeFlowController1.portMoistAir_a)
    annotation (Line(
      points={{-10,-20},{6,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundaryMoistAir_phX1.portMoistAir_a, fanSimple.portMoistAir_a)
    annotation (Line(
      points={{-52,-2},{-40,-2},{-40,20},{-30,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volumeFlowController1.portMoistAir_b, boundaryMoistAir_phX2.portMoistAir_a)
    annotation (Line(
      points={{26,-20},{32,-20},{32,1.33227e-015},{40,1.33227e-015}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(V_dot_set.y, volumeFlowController1.VolumeFlowSet) annotation (
      Line(
      points={{5,1.33227e-015},{2,1.33227e-015},{2,-17.9},{5.2,-17.9}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
   Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A simple Simulation Model which shows the effect of rotational Speed control of a Fan</p>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
end SpeedControlOfFan;
