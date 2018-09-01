within AixLib.Controls.HeatPump.BaseClasses;
partial model partialTSetToNSet
  "Partial model to convert set temperature to compressor speed of heat pump"
  Utilities.Logical.SmoothSwitch swiNullHP "If HP is off, zero is passed"
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Blocks.Sources.Constant conZer(k=0) "If an error occurs, the compressor speed is set to zero"
    annotation (Placement(transformation(extent={{38,-24},{50,-12}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set temperature"
    annotation (Placement(transformation(extent={{-132,44},{-100,76}})));
  Modelica.Blocks.Interfaces.RealOutput nOut "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-124,-42},{-90,-12}})));
  Modelica.Blocks.Interfaces.RealOutput ySecHeaGen if use_secHeaGen
                                                   "Relative power of second heat generator, from 0 to 1"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,110})));
  parameter Boolean use_secHeaGen "True to choose a bivalent system" annotation(choices(checkBox=true));
  parameter Boolean use_bivPar "Switch between bivalent parallel and bivalent alternative control" annotation (Dialog(enable=use_secHeaGen), choices(choice=true "Parallel",
      choice=false "Alternativ",
      radioButtons=true));
  Modelica.Blocks.Interfaces.RealInput TAct "Actual temperature, control variable"
    annotation (Placement(transformation(
        extent={{16,16},{-16,-16}},
        rotation=180,
        origin={-116,-80})));
  CalcQdot calcQdot if use_secHeaGen annotation (Placement(transformation(
        extent={{-8.5,-8.5},{8.5,8.5}},
        rotation=0,
        origin={-44.5,75.5})));
  Utilities.Logical.SmoothSwitch swiNullsecHeaGen if use_secHeaGen
    "If second heater is off, zero is passed" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={0,86})));
  Modelica.Blocks.Math.Gain gain if use_secHeaGen
    annotation (Placement(transformation(extent={{-26,64},{-14,76}})));
equation
  connect(conZer.y, swiNullHP.u3) annotation (Line(points={{50.6,-18},{58,-18},
          {58,-8},{64,-8}}, color={0,0,127}));
  connect(swiNullHP.y, nOut)
    annotation (Line(points={{87,0},{110,0}}, color={0,0,127}));
  connect(sigBusHP.m_flow_co, calcQdot.mFlow_con) annotation (Line(
      points={{-106.915,-26.925},{-76,-26.925},{-76,50},{-54.36,50},{-54.36,
          70.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_ret_co, calcQdot.TCon_out) annotation (Line(
      points={{-106.915,-26.925},{-76,-26.925},{-76,50},{-54.36,50},{-54.36,
          75.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(TSet, calcQdot.TSet) annotation (Line(points={{-116,60},{-76,60},{-76,
          50},{-54.36,50},{-54.36,80.6}}, color={0,0,127}));
  connect(swiNullsecHeaGen.y, ySecHeaGen)
    annotation (Line(points={{0,94.8},{0,110}},   color={0,0,127}));
  connect(conZer.y, swiNullsecHeaGen.u3) annotation (Line(points={{50.6,-18},{
          58,-18},{58,76.4},{6.4,76.4}},  color={0,0,127}));
  connect(gain.y, swiNullsecHeaGen.u1) annotation (Line(points={{-13.4,70},{0,
          70},{0,76.4},{-6.4,76.4}},
                                color={0,0,127}));
  connect(gain.u, calcQdot.ySecHeaGen) annotation (Line(points={{-27.2,70},{-28,
          70},{-28,74},{-32,74},{-32,75.5},{-35.15,75.5}},
                                         color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                            Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}), Text(
          extent={{-40,30},{44,-14}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}),      Diagram(coordinateSystem(preserveAspectRatio=false)));
end partialTSetToNSet;
