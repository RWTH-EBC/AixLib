within AixLib.Systems.EONERC_Testhall.BaseClass.JetNozzle;
model JN_control_T_Hall
  Modelica.Fluid.Interfaces.FluidPort_a jn_sup_air(redeclare package Medium =
        AixLib.Media.Air) annotation (Placement(transformation(extent={{88,-26},{108,
            -6}}),
        iconTransformation(extent={{88,-54},{108,-34}})));
  Modelica.Fluid.Interfaces.FluidPort_b jn_ret_air(redeclare package Medium =
        AixLib.Media.Air) annotation (Placement(transformation(extent={{90,32},{110,52}}),
        iconTransformation(extent={{86,22},{106,42}})));

  Modelica.Fluid.Interfaces.FluidPort_a jn_ret_thermalzone(redeclare package
      Medium = AixLib.Media.Air) annotation (Placement(transformation(extent={{-108,32},
            {-88,52}}), iconTransformation(extent={{-110,22},{-90,42}})));
  Modelica.Fluid.Interfaces.FluidPort_b jn_sup_thermalzone(redeclare package
      Medium = AixLib.Media.Air) annotation (Placement(transformation(extent={{-110,
            -26},{-90,-6}}), iconTransformation(extent={{-110,-60},{-90,-40}})));
  Fluid.Actuators.Dampers.Exponential        AirValve(
    redeclare package Medium = AixLib.Media.Air,
    each m_flow_nominal=2.64,
    dpDamper_nominal=2,
    dpFixed_nominal=2,
    each l=0.01) "if Valve Kv=100 " annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-16})));
  Modelica.Blocks.Continuous.LimPID PID_AirValve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1000,
    k=0.01)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={24,16})));
  Modelica.Blocks.Sources.Constant RoomTemp_set(k=20 + 273.15) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={58,16})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=2.64)
    annotation (Placement(transformation(extent={{-70,32},{-50,52}})));
equation
  connect(jn_sup_air, AirValve.port_a)
    annotation (Line(points={{98,-16},{10,-16},{10,-16}}, color={0,127,255}));
  connect(RoomTemp_set.y,PID_AirValve. u_s)
    annotation (Line(points={{47,16},{36,16}},  color={0,0,127}));
  connect(PID_AirValve.y, AirValve.y) annotation (Line(points={{13,16},{
          9.99201e-16,16},{9.99201e-16,-4}}, color={0,0,127}));
  connect(AirValve.port_b, jn_sup_thermalzone)
    annotation (Line(points={{-10,-16},{-100,-16}}, color={0,127,255}));
  connect(jn_ret_thermalzone, senTem.port_a)
    annotation (Line(points={{-98,42},{-70,42}}, color={0,127,255}));
  connect(senTem.port_b, jn_ret_air)
    annotation (Line(points={{-50,42},{100,42}}, color={0,127,255}));
  connect(senTem.T, PID_AirValve.u_m) annotation (Line(points={{-60,53},{-60,56},
          {-12,56},{-12,0},{24,0},{24,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-52,18},{58,-48}},
          textColor={28,108,200},
          textString="JN
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000000, __Dymola_Algorithm="Dassl"));
end JN_control_T_Hall;
