within AixLib.Fluid.Examples.DistrictHeating.Controller;
model BackupController "Controller for backup system"
  Modelica.Blocks.Interfaces.RealInput FlowTempSDH annotation (Placement(
        transformation(extent={{-163,-2},{-127,34}}), iconTransformation(
          extent={{-147,-12},{-122,12}})));
  Modelica.Blocks.Interfaces.RealInput buffStgSetpoint annotation (Placement(
        transformation(extent={{-163,34},{-126,72}}),  iconTransformation(
          extent={{-147,44},{-122,70}})));
  AixLib.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0,
    yMax=1,
    k=0.001,
    Ti=10)
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-20,53})));
  Modelica.Blocks.Logical.Switch Switcher annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,0})));
  Modelica.Blocks.Sources.Constant ValveOp(k=0) annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-20,-30})));

  Modelica.Blocks.Interfaces.RealOutput AuxValve annotation (Placement(
        transformation(extent={{136,-32},{160,-8}}), iconTransformation(
          extent={{132,-11},{154,11}})));
  Modelica.Blocks.Logical.Switch Switcher1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,-56})));
  Modelica.Blocks.Sources.Constant ValveOp1(k=0) annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-20,-84})));
  Modelica.Blocks.Sources.Constant MassFlowCHP(k=0.5)
                                                    annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-20,-56})));
  Modelica.Blocks.Interfaces.RealOutput MasFlowcHP annotation (Placement(
        transformation(extent={{128,-66},{154,-40}}), iconTransformation(
          extent={{132,-62},{154,-40}})));
  Modelica.Blocks.Logical.OnOffController TempBand(pre_y_start=false,
      bandwidth=5) annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-91,-5})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{86,30},{106,50}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{48,54},{64,70}})));
  Modelica.Blocks.Interfaces.RealOutput BypassValve annotation (Placement(
        transformation(extent={{136,27},{162,53}}), iconTransformation(extent=
           {{132,33},{154,56}})));
  Modelica.Blocks.Interfaces.RealInput buffStgTopTemp annotation (Placement(
        transformation(extent={{-163,-46},{-127,-10}}), iconTransformation(
          extent={{-145,-68},{-120,-42}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-56,-15},{-36,5}})));
  Modelica.Blocks.Logical.Less and2
    annotation (Placement(transformation(extent={{-100,-44},{-82,-25}})));
  Modelica.Blocks.Sources.Constant lowerLimit(k=2.5) annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-126,-86})));
  Modelica.Blocks.Math.Add add1(
                               k2=-1)
    annotation (Placement(transformation(extent={{-100,-78},{-84,-62}})));
equation
  connect(ValveOp.y, Switcher.u3) annotation (Line(points={{-11.2,-30},{0,-30},
          {0,-8},{14,-8}}, color={0,0,127}));
  connect(buffStgSetpoint, conPID.u_s) annotation (Line(points={{-144.5,53},{
          -72,53},{-29.6,53}},            color={0,0,127}));
  connect(conPID.u_m, FlowTempSDH) annotation (Line(points={{-20,43.4},{-20,
          16},{-145,16}}, color={0,0,127}));
  connect(conPID.y, Switcher.u1) annotation (Line(points={{-11.2,53},{0,53},{
          0,8},{14,8}}, color={0,0,127}));
  connect(Switcher.y, AuxValve) annotation (Line(points={{37,0},{54,0},{54,
          -20},{148,-20}}, color={0,0,127}));
  connect(Switcher1.u2, Switcher.u2) annotation (Line(points={{14,-56},{8,-56},
          {4,-56},{4,0},{14,0}},         color={255,0,255}));
  connect(ValveOp1.y, Switcher1.u3) annotation (Line(points={{-11.2,-84},{4,
          -84},{4,-64},{14,-64}}, color={0,0,127}));
  connect(Switcher1.u1, MassFlowCHP.y) annotation (Line(points={{14,-48},{10,
          -48},{-4,-48},{-4,-56},{-11.2,-56}}, color={0,0,127}));
  connect(Switcher1.y,MasFlowcHP)  annotation (Line(points={{37,-56},{74,-56},
          {74,-53},{141,-53}}, color={0,0,127}));
  connect(const.y, add.u1) annotation (Line(points={{64.8,62},{70,62},{70,46},
          {84,46}}, color={0,0,127}));
  connect(add.u2, AuxValve) annotation (Line(points={{84,34},{54,34},{54,-20},
          {148,-20}}, color={0,0,127}));
  connect(add.y, BypassValve)
    annotation (Line(points={{107,40},{128,40},{149,40}}, color={0,0,127}));
  connect(TempBand.y, and1.u1) annotation (Line(points={{-81.1,-5},{-72,-5},{
          -58,-5}}, color={255,0,255}));
  connect(TempBand.u, buffStgTopTemp) annotation (Line(points={{-101.8,-10.4},
          {-118,-10.4},{-118,-28},{-145,-28}}, color={0,0,127}));
  connect(and2.y, and1.u2) annotation (Line(points={{-81.1,-34.5},{-74,-34.5},
          {-74,-13},{-58,-13}}, color={255,0,255}));
  connect(and1.y, Switcher.u2) annotation (Line(points={{-35,-5},{-28,-5},{
          -28,0},{14,0}}, color={255,0,255}));
  connect(and2.u1, buffStgTopTemp) annotation (Line(points={{-101.8,-34.5},{
          -118,-34.5},{-118,-28},{-145,-28}}, color={0,0,127}));
  connect(TempBand.reference, conPID.u_s) annotation (Line(points={{-101.8,
          0.4},{-110,0.4},{-110,53},{-72,53},{-29.6,53}}, color={0,0,127}));
  connect(lowerLimit.y, add1.u2) annotation (Line(points={{-117.2,-86},{-112,
          -86},{-112,-74.8},{-101.6,-74.8}}, color={0,0,127}));
  connect(add1.u1, conPID.u_s) annotation (Line(points={{-101.6,-65.2},{-110,
          -65.2},{-110,53},{-29.6,53}}, color={0,0,127}));
  connect(add1.y, and2.u2) annotation (Line(points={{-83.2,-70},{-72,-70},{
          -72,-52},{-126,-52},{-126,-42.1},{-101.8,-42.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{140,100}}), graphics={Rectangle(
          extent={{-140,100},{140,-100}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-26,-2},{24,-34}},
          lineColor={255,255,255},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="%name
")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{
            140,100}})));
end BackupController;
