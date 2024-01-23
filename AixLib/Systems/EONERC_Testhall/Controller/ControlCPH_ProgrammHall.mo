within AixLib.Systems.EONERC_Testhall.Controller;
model ControlCPH_ProgrammHall

  /** Control strategie out of TwinCat **/
  Subsystems.BaseClasses.HallHydraulicBus distributeBus_CPH annotation (
      Placement(transformation(extent={{-114,-36},{-74,6}}), iconTransformation(
          extent={{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=250,
    k=0.001) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,68})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
  Modelica.Blocks.Continuous.LimPID PID_ValveThrottle(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=250,
    k=0.001) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-18,-50})));
  Modelica.Blocks.Sources.CombiTimeTable Hall2(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Office_Hall_Temp.txt"),
    columns=2:8,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{100,-90},{80,-70}})));

  HeatCurve heatCurve(x=-1.481, b=60)
    annotation (Placement(transformation(extent={{76,58},{56,78}})));
  Modelica.Blocks.Interfaces.RealInput T_amb
    annotation (Placement(transformation(extent={{124,48},{84,88}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Sources.Constant n_const(k=0.6*4250) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-44,32})));
  Modelica.Blocks.Math.MultiSum sumHallTemp(nu=2)
    annotation (Placement(transformation(extent={{26,-86},{14,-74}})));
  Modelica.Blocks.Math.Gain meanTemp(k=1/2)
    annotation (Placement(transformation(extent={{8,-84},{0,-76}})));
  Modelica.Blocks.Sources.Constant TBasic(k=20.5) annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={51,-21})));
  Modelica.Blocks.Math.MultiSum calcTSet(nu=2)
    annotation (Placement(transformation(extent={{24,-56},{12,-44}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={62,-50})));
  Modelica.Blocks.Sources.Constant b(k=16383.5) annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={77,-27})));
  Modelica.Blocks.Math.Gain a(k=1/(16383.5*5))
    annotation (Placement(transformation(extent={{50,-54},{42,-46}})));
  Modelica.Blocks.Sources.CombiTimeTable Hall2_Offset_and_Radiation(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Hall2.txt"),
    columns=2:13,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "7 - Offset, 8 - Radiation"
    annotation (Placement(transformation(extent={{98,-62},{78,-42}})));
  Modelica.Blocks.Math.Add addtoKelvin
    annotation (Placement(transformation(extent={{6,-54},{-2,-46}})));
  Modelica.Blocks.Sources.Constant CtoK(k=273.15) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={16,-30})));
equation
  connect(booleanExpression1.y, distributeBus_CPH.bus_cph.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(PID_Valve.y, distributeBus_CPH.bus_cph.valveSet) annotation (Line(
        points={{19,68},{6,68},{6,-14.895},{-93.9,-14.895}},   color={0,0,127}));
  connect(PID_ValveThrottle.y, distributeBus_CPH.bus_cph_throttle.valveSet)
    annotation (Line(points={{-29,-50},{-48,-50},{-48,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(heatCurve.T_sup, PID_Valve.u_s)
    annotation (Line(points={{74,79.4},{58,79.4},{58,68},{42,68}},
                                                 color={0,0,127}));
  connect(T_amb, heatCurve.T_amb)
    annotation (Line(points={{104,68},{92,68},{92,60},{78,60}},
                                                color={0,0,127}));
  connect(n_const.y, distributeBus_CPH.bus_cph.pumpBus.rpmSet) annotation (Line(
        points={{-55,32},{-68,32},{-68,-14.895},{-93.9,-14.895}},
                                                      color={0,0,127}));
  connect(sumHallTemp.y, meanTemp.u)
    annotation (Line(points={{12.98,-80},{8.8,-80}}, color={0,0,127}));
  connect(meanTemp.y, PID_ValveThrottle.u_m) annotation (Line(points={{-0.4,-80},
          {-18,-80},{-18,-62}}, color={0,0,127}));
  connect(TBasic.y, calcTSet.u[1]) annotation (Line(points={{43.3,-21},{30,-21},
          {30,-51.05},{24,-51.05}}, color={0,0,127}));
  connect(b.y, feedback.u2) annotation (Line(points={{69.3,-27},{62,-27},{62,
          -45.2}}, color={0,0,127}));
  connect(feedback.y, a.u)
    annotation (Line(points={{56.6,-50},{50.8,-50}}, color={0,0,127}));
  connect(a.y, calcTSet.u[2]) annotation (Line(points={{41.6,-50},{32,-50},{32,
          -48.95},{24,-48.95}}, color={0,0,127}));
  connect(calcTSet.y, addtoKelvin.u2) annotation (Line(points={{10.98,-50},{
          10.98,-52.4},{6.8,-52.4}}, color={0,0,127}));
  connect(CtoK.y, addtoKelvin.u1) annotation (Line(points={{11.6,-30},{6.8,-30},
          {6.8,-47.6}}, color={0,0,127}));
  connect(addtoKelvin.y, PID_ValveThrottle.u_s)
    annotation (Line(points={{-2.4,-50},{-6,-50}}, color={0,0,127}));
  connect(PID_Valve.u_m, distributeBus_CPH.bus_cph_throttle.TFwrdOutMea)
    annotation (Line(points={{30,56},{30,-14.895},{-93.9,-14.895}}, color={0,0,
          127}));
  connect(Hall2.y[7], sumHallTemp.u[1]) annotation (Line(points={{79,-80},{52,
          -80},{52,-81.05},{26,-81.05}}, color={0,0,127}));
  connect(Hall2_Offset_and_Radiation.y[8], sumHallTemp.u[2]) annotation (Line(
        points={{77,-52},{72,-52},{72,-78.95},{26,-78.95}}, color={0,0,127}));
  connect(Hall2_Offset_and_Radiation.y[7], feedback.u1)
    annotation (Line(points={{77,-52},{77,-50},{66.8,-50}}, color={0,0,127}));
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
           false)));
end ControlCPH_ProgrammHall;
