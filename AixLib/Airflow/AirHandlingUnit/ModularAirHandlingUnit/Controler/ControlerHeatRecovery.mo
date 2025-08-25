within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Controler;
model ControlerHeatRecovery
  "controler for heat recovery system with fixed efficiency"

  parameter Modelica.Units.SI.TemperatureDifference dT_min
    "minimum temperature difference for which the hrs is switched off";

  Modelica.Blocks.Interfaces.RealInput TAirInEta(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of incoming exhaust air" annotation (
      Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput TAirInOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of incoming otudoor air" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Interfaces.RealInput TSet(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Set temperature of supply air. Is used to limit heat recovery."
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,0})));
  Controls.Continuous.LimPID conPID(
    k=200,
    Ti=20,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-24,34},{-4,54}})));
  Controls.Continuous.LimPID conPID1(
    k=200,
    Ti=20,                           reverseActing=true)
    annotation (Placement(transformation(extent={{-26,-52},{-6,-32}})));
  Modelica.Blocks.Interfaces.RealOutput bypOpe
    "opening of bypass (1: fully open, 0: fully closed)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput TAirOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "measured outlet temperature" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-16,-120})));
  Modelica.Blocks.Interfaces.RealInput dTFan "temperature increase over fan"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-86,-120})));
protected
  Utilities.Logical.SmoothSwitch switch1
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  Modelica.Blocks.Logical.LessEqual lessEqual
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
equation
  connect(TAirInOda, lessEqual.u1) annotation (Line(points={{-120,-60},{-40,-60},
          {-40,0},{-8,0}}, color={0,0,127}));
  connect(TAirInEta, lessEqual.u2) annotation (Line(points={{-120,60},{-40,60},
          {-40,-8},{-8,-8}}, color={0,0,127}));
  connect(lessEqual.y, switch1.u2)
    annotation (Line(points={{15,0},{34,0}}, color={255,0,255}));
  connect(conPID.y, switch1.u1)
    annotation (Line(points={{-3,44},{24,44},{24,8},{34,8}}, color={0,0,127}));
  connect(conPID1.y, switch1.u3) annotation (Line(points={{-5,-42},{22,-42},{22,
          -8},{34,-8}}, color={0,0,127}));
  connect(switch1.y, bypOpe)
    annotation (Line(points={{57,0},{110,0}}, color={0,0,127}));
  connect(TSet, add.u2) annotation (Line(points={{-120,0},{-92,0},{-92,-6},{-78,
          -6}}, color={0,0,127}));
  connect(add.y, conPID1.u_s) annotation (Line(points={{-55,0},{-40,0},{-40,-42},
          {-28,-42}}, color={0,0,127}));
  connect(add.y, conPID.u_s) annotation (Line(points={{-55,0},{-40,0},{-40,44},
          {-26,44}},color={0,0,127}));
  connect(conPID1.u_m, TAirOut)
    annotation (Line(points={{-16,-54},{-16,-120}}, color={0,0,127}));
  connect(TAirOut, conPID.u_m) annotation (Line(points={{-16,-120},{-16,-68},{
          -40,-68},{-40,24},{-14,24},{-14,32}}, color={0,0,127}));
  connect(add.u1, dTFan)
    annotation (Line(points={{-78,6},{-86,6},{-86,-120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,100},{100,0},{20,-100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p> This model implements a control strategy for the heat recovery system.
It switches between heating and cooling mode depending on the outdoor air temperature and exhaust air temperature.
The output is the bypass opening value between zero (closed) and and one (fully opened).
</p>
</html>", revisions="<html>
<ul>
  <li>February, 2025 by Martin Kremer:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end ControlerHeatRecovery;
