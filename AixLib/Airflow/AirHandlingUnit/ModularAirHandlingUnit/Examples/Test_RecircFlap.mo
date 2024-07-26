within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_RecircFlap "Simple test for recirculation flap"
  extends Modelica.Icons.Example;
  Components.RecircFlap recircFlap(redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-34,-28},{26,32}})));
  Modelica.Blocks.Sources.Constant m_flow_air(k=3000/3600*1.18)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
  Modelica.Blocks.Sources.Constant T_EtaIn(k=293.15)
    annotation (Placement(transformation(extent={{100,0},{80,20}})));
  Modelica.Blocks.Sources.Constant X_EtaIn(k=0.01)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Sources.Constant T_OdaIn(k=273.15)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant X_OdaIn(k=0.002)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Ramp flapPos(
    height=0.5,
    duration=600,
    offset=0,
    startTime=600)
    annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  Modelica.Blocks.Continuous.LimPID PID(
    Ti=10,
    Td=0.001,
    yMax=3000/3600*1.18,
    yMin=0) annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
equation
  connect(m_flow_air.y, recircFlap.m_flow_airInEta) annotation (Line(points={{
          79,50},{60,50},{60,26},{29,26}}, color={0,0,127}));
  connect(T_EtaIn.y, recircFlap.T_airInEta) annotation (Line(points={{79,10},{
          60,10},{60,17},{29,17}}, color={0,0,127}));
  connect(X_EtaIn.y, recircFlap.X_airInEta) annotation (Line(points={{79,-30},{
          60,-30},{60,8},{29,8}}, color={0,0,127}));
  connect(T_OdaIn.y, recircFlap.T_airInOda) annotation (Line(points={{-79,-30},
          {-60,-30},{-60,-13},{-37,-13}}, color={0,0,127}));
  connect(X_OdaIn.y, recircFlap.X_airInOda) annotation (Line(points={{-79,10},{
          -60,10},{-60,-4},{-37,-4}}, color={0,0,127}));
  connect(flapPos.y, recircFlap.flapPosition)
    annotation (Line(points={{19,-50},{-19,-50},{-19,-28}}, color={0,0,127}));
  connect(recircFlap.m_flow_airOutOda, PID.u_m) annotation (Line(points={{29,
          -22},{50,-22},{50,-100},{-50,-100},{-50,-82}}, color={0,0,127}));
  connect(m_flow_air.y, PID.u_s) annotation (Line(points={{79,50},{60,50},{60,
          -100},{-72,-100},{-72,-70},{-62,-70}}, color={0,0,127}));
  connect(PID.y, recircFlap.m_flow_airInOda) annotation (Line(points={{-39,-70},
          {-30,-70},{-30,-40},{-48,-40},{-48,-22},{-37,-22}}, color={0,0,127}));
  annotation (experiment(StopTime=3600, Interval=3600),Documentation(info="<html><p>
  Testing modell <a href=
  \"modelica://SimpleAHU.Components.RecircFlap\">SimpleAHU.Components.RecircFlap</a>.
</p>
<p>
  The incoming outdoor massflow is controlled with <a href=
  \"modelica://Modelica.Blocks.Continuous.LimPID\">Modelica.Blocks.Continuous.LimPID</a>
  so that the outgoing outdoor massflow equals that of the incoming
  exhaust air.
</p>
</html>", revisions="<html>

</html>"),
    experiment(StopTime=7000),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}));
end Test_RecircFlap;
