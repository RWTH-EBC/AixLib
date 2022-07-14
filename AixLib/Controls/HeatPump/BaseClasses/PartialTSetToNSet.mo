within AixLib.Controls.HeatPump.BaseClasses;
partial model PartialTSetToNSet
  "Partial model to convert set temperature to compressor speed of heat pump"
  parameter Boolean use_secHeaGen=false
                                       "True to choose a bivalent system" annotation(choices(checkBox=true));

  // Heating limit temperature
  parameter Boolean use_heaLim=true "=false to disable moving average heating limit" annotation (Dialog(group="Heating limit temperature"));
  parameter Modelica.Units.SI.Temperature T_heaLim=293.15
    "Heating limit temperature. If the filtered outdoor air temperature surpasses this threshold, the device will be shut down" annotation(Dialog(group=
          "Heating limit temperature", enable=use_heaLim));
  parameter Modelica.Units.SI.Time movAveTime=360
    "Time span for building the average of the outdoor air temperature. Used for heating limit temperature" annotation (Dialog(group=
          "Heating limit temperature", enable=use_heaLim));

  AixLib.Utilities.Logical.SmoothSwitch swiNullHP "If HP is off, zero is passed"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Modelica.Blocks.Sources.Constant conZer(final k=0)
                                               "If an error occurs, the compressor speed is set to zero"
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Blocks.Interfaces.RealInput TSet(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      final displayUnit="degC") "Set temperature"
    annotation (Placement(transformation(extent={{-132,44},{-100,76}})));
  Modelica.Blocks.Interfaces.RealOutput nOut "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBusHP
    annotation (Placement(transformation(extent={{-124,-46},{-90,-16}})));
  Modelica.Blocks.Interfaces.RealOutput ySecHeaGen if use_secHeaGen
                                                   "Relative power of second heat generator, from 0 to 1"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealInput TMea(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      final displayUnit="degC") "Actual temperature, control variable"
    annotation (Placement(transformation(
        extent={{16,16},{-16,-16}},
        rotation=180,
        origin={-116,-80})));
  Utilities.Logical.SmoothSwitch swiNullsecHeaGen if use_secHeaGen
    "If second heater is off, zero is passed" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-70})));
  Utilities.Math.MovingAverage movAve(final aveTime=movAveTime, final u_start=0)
    if use_heaLim
    "Moving average to account for fluctuations in the outdoor air temperature"
    annotation (Placement(transformation(extent={{-92,-40},{-72,-20}})));
  Modelica.Blocks.Logical.And andHeaLim
    "Check if control and heating limit temperature yield true to turn the device on"
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Logical.LessThreshold      lessThreshold(final threshold=
        T_heaLim) if use_heaLim
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));



  Modelica.Blocks.Sources.BooleanConstant    booleanConstant(final k=true)
 if not use_heaLim
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
equation
  connect(conZer.y, swiNullHP.u3) annotation (Line(points={{41,-40},{54,-40},{
          54,-18},{58,-18}},color={0,0,127}));
  connect(swiNullHP.y, nOut)
    annotation (Line(points={{81,-10},{98,-10},{98,0},{110,0}},
                                              color={0,0,127}));
  connect(swiNullsecHeaGen.y, ySecHeaGen)
    annotation (Line(points={{-8.88178e-16,-81},{-8.88178e-16,-98},{0,-98},{0,
          -110}},                                 color={0,0,127}));
  connect(conZer.y, swiNullsecHeaGen.u3) annotation (Line(points={{41,-40},{70,
          -40},{70,-58},{8,-58}},         color={0,0,127}));
  connect(sigBusHP.T_oda, movAve.u) annotation (Line(
      points={{-107,-31},{-94,-31},{-94,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(movAve.y, lessThreshold.u)
    annotation (Line(points={{-71,-30},{-62,-30}},     color={0,0,127}));
  connect(lessThreshold.y, andHeaLim.u2) annotation (Line(points={{-39,-30},{
          -26,-30},{-26,-18},{18,-18}}, color={255,0,255}));
  connect(andHeaLim.y, swiNullHP.u2)
    annotation (Line(points={{41,-10},{58,-10}},
                                               color={255,0,255}));
  connect(booleanConstant.y, andHeaLim.u2) annotation (Line(points={{-39,-70},{
          -26,-70},{-26,-18},{18,-18}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                            Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}), Text(
          extent={{-98,30},{100,-16}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}),      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end PartialTSetToNSet;
