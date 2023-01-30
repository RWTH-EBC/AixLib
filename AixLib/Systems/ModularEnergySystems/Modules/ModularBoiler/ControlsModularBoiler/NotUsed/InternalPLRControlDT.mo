within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ControlsModularBoiler.NotUsed;
model InternalPLRControlDT
  "Simple control with flow temperature PID control if no other signal provided"
 // PI Control
 parameter Real k=1 "Gain of controller" annotation (Dialog(group="Flow Temperature PI"));
 parameter Modelica.Units.SI.Time Ti=10 "Time constant of Integrator block" annotation (Dialog(group="Flow Temperature PI"));
 parameter Real yMax=1.0 "Upper limit of output" annotation (Dialog(group="Flow Temperature PI"));
 Modelica.Blocks.Interfaces.RealInput TFlowMea(unit="K") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-52})));
 Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    yMax=yMax,
    yMin=yMin)
            "PI Controller for controlling the valve position"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
 Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput TFlowSet(unit="K")
    "Set value for flow temperature"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  parameter Real yMin=0 "Lower limit of output";
 Modelica.Blocks.Interfaces.RealInput TReturnMea(unit="K")
    "Current return temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-82})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-58,-70},{-38,-50}})));
  Modelica.Blocks.Interfaces.RealInput TRetSet(unit="K")
    "Set value for flow temperature"
    annotation (Placement(transformation(extent={{-140,-36},{-100,4}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-66,-12},{-46,8}})));
equation
  connect(PID.y,PLRset)
    annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(TFlowMea, add.u1) annotation (Line(points={{-120,-52},{-118,-52},{
          -118,-54},{-60,-54}}, color={0,0,127}));
  connect(TReturnMea, add.u2) annotation (Line(points={{-120,-82},{-66,-82},{
          -66,-66},{-60,-66}}, color={0,0,127}));
  connect(add.y, PID.u_m) annotation (Line(points={{-37,-60},{-22,-60},{-22,
          -58},{0,-58},{0,-12}}, color={0,0,127}));
  connect(TFlowSet, add1.u1) annotation (Line(points={{-120,20},{-74,20},{-74,
          4},{-68,4}}, color={0,0,127}));
  connect(TRetSet, add1.u2) annotation (Line(points={{-120,-16},{-76,-16},{
          -76,-8},{-68,-8}}, color={0,0,127}));
  connect(add1.y, PID.u_s) annotation (Line(points={{-45,-2},{-42,-2},{-42,0},
          {-12,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
                            Text(
          extent={{-102,26},{98,-18}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end InternalPLRControlDT;
