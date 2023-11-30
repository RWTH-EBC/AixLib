within AixLib.Systems.EONERC_Testhall.Controller.Obsolote;
model ControlDHS_n_const
  BaseClass.DistributeBus distributeBus_DHS annotation (Placement(
        transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
            {{78,-22},{118,20}})));
  Modelica.Blocks.Sources.Constant T_Set_SupPrim(k=57 + 273.15) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,68})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=3000,
    k=0.2)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,68})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    n=2,
    f=0.05,
    x_start={0,0})
    annotation (Placement(transformation(extent={{28,-22},{8,-2}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
  Modelica.Blocks.Sources.Constant nset(k=4500) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-12,72})));
equation
  connect(PID_Valve.u_s, T_Set_SupPrim.y)
    annotation (Line(points={{50,68},{33,68}}, color={0,0,127}));
  connect(PID_Valve.y, criticalDamping.u) annotation (Line(points={{73,68},{78,
          68},{78,-12},{30,-12}},
                                color={0,0,127}));
  connect(criticalDamping.y, distributeBus_DHS.bus_dhs.valveSet) annotation (
      Line(points={{7,-12},{-22,-12},{-22,-14.895},{-93.9,-14.895}},
                                                                   color={0,0,
          127}));
  connect(booleanExpression1.y, distributeBus_DHS.bus_dhs_pump.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(nset.y, distributeBus_DHS.bus_dhs_pump.pumpBus.rpmSet) annotation (
      Line(points={{-23,72},{-68,72},{-68,-14.895},{-93.9,-14.895}}, color={0,0,
          127}));
  connect(PID_Valve.u_m, distributeBus_DHS.bus_dhs_pump.TFwrdOutMea)
    annotation (Line(points={{62,56},{62,18},{-64,18},{-64,-14.895},{-93.9,
          -14.895}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
           false)),
    experiment(
      StopTime=400000,
      __Dymola_NumberOfIntervals=200,
      __Dymola_Algorithm="Dassl"));
end ControlDHS_n_const;
