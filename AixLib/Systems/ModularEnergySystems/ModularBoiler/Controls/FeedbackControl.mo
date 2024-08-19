within AixLib.Systems.ModularEnergySystems.ModularBoiler.Controls;
model FeedbackControl "Controller for return feedback mixing"
protected
  Modelica.Blocks.Sources.RealExpression TSetReturn(final y=TRetNom)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
public
  Modelica.Blocks.Continuous.LimPID PIValve(
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    final yMax=yMax,
    final yMin=yMin,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=yMin)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-2,0})));
  Modelica.Blocks.Interfaces.RealOutput yValve "Position of feedback valve"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealInput TReturnMea(unit="K")
    "Measured return temperature"
    annotation (Placement(transformation(extent={{-122,-20},{-82,20}})));
  Modelica.Blocks.Math.Gain gain1(final k=-1)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-34,0})));
  Modelica.Blocks.Math.Gain gain2(final k=-1)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-68,-34})));
  parameter Modelica.Units.SI.Temperature TRetNom
    "Set value for return temperature"                                                         annotation (Dialog(group=
          "Feedback Return Control"));
  parameter Real k=1 "Gain of controller" annotation (Dialog(group="Feedback Return Control"));
  parameter Modelica.Units.SI.Time Ti=0.5 "Time constant of Integrator block" annotation (Dialog(group="Feedback Return Control"));
  parameter Real yMax=0.99 "Upper limit of output" annotation (Dialog(group="Feedback Return Control"));
  parameter Real yMin=0 "Lower limit of output" annotation (Dialog(group="Feedback Return Control"));
equation
  connect(PIValve.y, yValve) annotation (Line(points={{9,-8.88178e-16},{9,0},{110,
          0}}, color={0,0,127}));
  connect(TReturnMea, gain2.u)
    annotation (Line(points={{-102,0},{-75.2,0},{-75.2,-34}},
                                                          color={0,0,127}));
  connect(gain2.y, PIValve.u_m)
    annotation (Line(points={{-61.4,-34},{-2,-34},{-2,-12}}, color={0,0,127}));
  connect(gain1.y, PIValve.u_s) annotation (Line(points={{-27.4,0},{-20.7,0},{-20.7,
          1.9984e-15},{-14,1.9984e-15}},                 color={0,0,127}));
  connect(TSetReturn.y, gain1.u)
    annotation (Line(points={{-49,0},{-41.2,0}},   color={0,0,127}));
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
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Arial;\">Optional control to control the return temperature based on a feedback circuit.</span></p>
</html>"));
end FeedbackControl;
