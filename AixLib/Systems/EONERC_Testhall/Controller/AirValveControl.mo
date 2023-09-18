within AixLib.Systems.EONERC_Testhall.Controller;
model AirValveControl
  parameter Modelica.Units.SI.Temperature Temp_Set_Air
    "Set Temperature of Air Flow";
  parameter Real ki = 0.01 "P-value for the PI-Control";
  parameter Real ti = 1000 "I-value for the PI-Control";

  Modelica.Blocks.Interfaces.RealOutput Air_Valve_Opening
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}}),
        iconTransformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealInput Air_Temp
    "Connector of first Boolean input signal" annotation (Placement(
        transformation(extent={{140,60},{100,100}}), iconTransformation(extent={
            {140,60},{100,100}})));
  Modelica.Blocks.Continuous.LimPID PID_Air_Flow_Valve(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    k=ki,
    Ti=ti) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={0,10})));
  Modelica.Blocks.Sources.Constant T_Set_Air(k=Temp_Set_Air) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-58,-12})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    n=2,
    f=0.05,
    x_start={0,0})
    annotation (Placement(transformation(extent={{52,-90},{72,-70}})));
equation
  connect(T_Set_Air.y, PID_Air_Flow_Valve.u_s) annotation (Line(points={{-47,-12},
          {-18,-12},{-18,10},{-12,10}}, color={0,0,127}));
  connect(criticalDamping.y, Air_Valve_Opening)
    annotation (Line(points={{73,-80},{110,-80}}, color={0,0,127}));
  connect(Air_Temp, PID_Air_Flow_Valve.u_m)
    annotation (Line(points={{120,80},{0,80},{0,22}}, color={0,0,127}));
  connect(PID_Air_Flow_Valve.y, criticalDamping.u) annotation (Line(points={{11,
          10},{44,10},{44,-80},{50,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{100,80},{44,80},{2,80},{2,2},{2,-80},{100,-80}}, color={0,
              0,0}),
        Polygon(
          points={{-58,40},{2,0},{-58,-40},{-58,40}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{62,40},{2,0},{62,-40},{62,40}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end AirValveControl;
