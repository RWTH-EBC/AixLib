within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ControlsModularBoiler;
model InternalPLRControl
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
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Real yMin=0 "Lower limit of output";
equation
  connect(TFlowMea,PID. u_m) annotation (Line(points={{-120,-52},{0,-52},{0,-12}},
                 color={0,0,127}));
  connect(PID.y,PLRset)
    annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(PID.u_s, TFlowSet)
    annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
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
end InternalPLRControl;
