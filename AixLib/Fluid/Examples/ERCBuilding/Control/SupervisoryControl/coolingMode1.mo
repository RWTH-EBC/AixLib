within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl;
model coolingMode1
  Modelica.Blocks.Logical.Not not2 annotation (Placement(transformation(
          extent={{-20,-61},{-12,-53}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 30, uHigh=
       273.15 + 31) annotation (Placement(transformation(extent={{-36,
            -78},{-26,-68}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-6,-74},{4,-65}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=273.15 + 8, uHigh=
       273.15 + 10) annotation (Placement(transformation(extent={{-36,
            -62},{-26,-52}})));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(
        transformation(rotation=0, extent={{90,-50},{110,-30}})));
  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
        transformation(rotation=0, extent={{-110,-90},{-90,-70}})));
  Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(
        transformation(rotation=0, extent={{-110,50},{-90,70}})));
equation
  connect(hysteresis.y, and1.u2) annotation (Line(
      points={{-25.5,-73},{-16,-73},{-16,-73.1},{-7,-73.1}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(hysteresis1.y, not2.u) annotation (Line(
      points={{-25.5,-57},{-20.8,-57}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not2.y, and1.u1) annotation (Line(
      points={{-11.6,-57},{-10,-57},{-10,-69.5},{-7,-69.5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(y, and1.y) annotation (Line(points={{100,-40},{52,-40},{52,
          -69.5},{4.5,-69.5}}, color={255,0,255}));
  connect(u, hysteresis.u) annotation (Line(points={{-100,-80},{-68,-80},
          {-68,-73},{-37,-73}}, color={0,0,127}));
  connect(u1, hysteresis1.u) annotation (Line(points={{-100,60},{-100,
          -57},{-68,-57},{-37,-57}}, color={0,0,127}));
end coolingMode1;
