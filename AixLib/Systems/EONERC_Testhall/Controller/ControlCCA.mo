within AixLib.Systems.EONERC_Testhall.Controller;
model ControlCCA
  "Information out of Unterlagen\\Heizlastberechnung\\Heizkurve_BKT"
  Subsystems.BaseClasses.HallHydraulicBus distributeBus_CCA annotation (
      Placement(transformation(extent={{82,-20},{120,20}}), iconTransformation(
          extent={{78,-22},{118,20}})));
  Modelica.Blocks.Sources.Constant rpm_set(k=rpm_pump)
                                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,30})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,70})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    Ti=Ti,
    k=k_pump)
             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,-30})));

  HeatCurve heatCurve(
    u_lower=u_lower,
    t_sup_upper=t_sup_upper,
    x=x,
    b=b)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,-30})));
  Modelica.Blocks.Interfaces.RealInput T_amb
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  parameter Real rpm_pump=3600 "Constant output value"
    annotation (Dialog(group="Pump"));
  parameter Real u_lower=14 "heating limit"
    annotation (Dialog(group="Heat Curve"));
  parameter Real t_sup_upper=48 "upper supply temperature limit"
    annotation (Dialog(group="Heat Curve"));
  parameter Real x=-0.5 "slope" annotation (Dialog(group="Heat Curve"));
  parameter Real b=24 "offset" annotation (Dialog(group="Heat Curve"));
  parameter Real k_pump=0.2 "Gain of controller"
    annotation (Dialog(group="Pump"));
  parameter Modelica.Units.SI.Time Ti=2000 "Time constant of Integrator block"
    annotation (Dialog(group="Pump"));
equation
  connect(booleanExpression1.y, distributeBus_CCA.bus_cca.pumpBus.onSet)
    annotation (Line(points={{61,70},{100,70},{100,0.1},{101.095,0.1}},
        color={255,0,255}));
  connect(PID_Valve.u_m, distributeBus_CCA.bus_cca.TFwrdOutMea) annotation (
      Line(points={{-10,-42},{-10,-60},{100,-60},{100,0.1},{101.095,0.1}},
        color={0,0,127}));
  connect(heatCurve.T_sup, PID_Valve.u_s)
    annotation (Line(points={{-37.9,-29.9},{-22,-29.9},{-22,-30}},
                                                    color={0,0,127}));
  connect(rpm_set.y, distributeBus_CCA.bus_cca.pumpBus.rpmSet) annotation (Line(
        points={{41,30},{100,30},{100,0.1},{101.095,0.1}},        color={0,0,
          127}));
  connect(heatCurve.T_sup, distributeBus_CCA.bus_cca.T_sup_set) annotation (
      Line(points={{-37.9,-29.9},{-34,-29.9},{-34,-30},{-30,-30},{-30,0.1},{101.095,
          0.1}},                                                       color={0,
          0,127}));
  connect(heatCurve.T_amb, T_amb) annotation (Line(points={{-62,-30},{-80,-30},{
          -80,0},{-120,0}},            color={0,0,127}));
  connect(PID_Valve.y, distributeBus_CCA.bus_cca.valveSet) annotation (Line(
        points={{1,-30},{68,-30},{68,0.1},{101.095,0.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {120,100}}),                                        graphics={
        Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
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
          textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-100,-100},{100,100}})));
end ControlCCA;
