within AixLib.Utilities.KPIs;
model IntegralTimer "Integral timer"

  parameter Boolean use_reset = false "If true, reset port enabled"
    annotation(choices(checkBox=true));
  Modelica.Blocks.Interfaces.BooleanInput u
    "Boolean input to activate integration"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y(unit="s") "Output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant conZero(k=0) "Constant zero"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.Constant conOne(k=1) "Constant one"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Logical.Switch swi "Switch for integration"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Continuous.Integrator itg(use_reset=use_reset)
                                            "Time integrator"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Interfaces.BooleanInput reset if use_reset
    "Conditional connector of reset signal" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  connect(itg.reset,reset)  annotation (Line(points={{76,-12},{76,-100},{0,-100},
          {0,-120}}, color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash, if use_reset then
          LinePattern.Solid else LinePattern.Dash)));
  connect(u, swi.u2)
    annotation (Line(points={{-120,0},{18,0}}, color={255,0,255}));
  connect(conOne.y, swi.u1)
    annotation (Line(points={{1,50},{10,50},{10,8},{18,8}}, color={0,0,127}));
  connect(conZero.y, swi.u3) annotation (Line(points={{1,-50},{10,-50},{10,-8},{
          18,-8}}, color={0,0,127}));
  connect(swi.y, itg.u)
    annotation (Line(points={{41,0},{58,0}}, color={0,0,127}));
  connect(itg.y, y) annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
end IntegralTimer;
