within AixLib.Fluid.HeatPumps.BaseClasses;
model innerCycle "Blackbox model of refrigerant cycle of a HP"
  Controls.Interfaces.HeatPumpControlBus sigBusHP annotation (Placement(
        transformation(extent={{-16,88},{18,118}}), iconTransformation(extent={{
            -16,88},{18,118}})));
  Modelica.Blocks.Interfaces.RealOutput QCon "Heat Flow to condenser"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput QEva "Heat flow from evaporator"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
  replaceable PerformanceData.LookUpTable2D                      performanceData
    constrainedby PerformanceData.BaseClasses.PartialPerformanceData
     "replaceable model for performance data of HP"
    annotation (choicesAllMatching=true, Placement(transformation(
        extent={{-27,-28},{27,28}},
        rotation=-90,
        origin={0,50})));

  Modelica.Blocks.Logical.Switch switchQEva
    "If mode is false, Condenser becomes Evaporator and vice versa"
    annotation (Placement(transformation(extent={{-54,-10},{-74,10}})));
  Modelica.Blocks.Logical.Switch switchQCon
    "If mode is false, Condenser becomes Evaporator and vice versa"
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Modelica.Blocks.Interfaces.RealOutput COP "Current COP" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Modelica.Blocks.Math.Division divCOP annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-78})));
  Modelica.Blocks.Interfaces.RealOutput Pel
    "Electrical power consumed by compressor" annotation (Placement(
        transformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=-90,
        origin={60.5,-110.5})));

equation
  connect(switchQCon.y, QCon)
    annotation (Line(points={{95,0},{110,0}}, color={0,0,127}));
  connect(performanceData.QEva, switchQEva.u1) annotation (Line(points={{22.4,20.3},
          {22,20.3},{22,8},{-52,8}},
                                  color={0,0,127}));
  connect(performanceData.QCon, switchQCon.u1) annotation (Line(points={{-22.4,20.3},
          {-22,20.3},{-22,8},{72,8}},
                                  color={0,0,127}));
  connect(performanceData.QEva, switchQCon.u3) annotation (Line(points={{22.4,20.3},
          {22,20.3},{22,-8},{72,-8}},
                                   color={0,0,127}));
  connect(performanceData.QCon, switchQEva.u3) annotation (Line(points={{-22.4,20.3},
          {-22,20.3},{-22,-8},{-52,-8}},
                                     color={0,0,127}));
  connect(performanceData.Pel, divCOP.u2) annotation (Line(points={{-5.55112e-15,
          20.3},{-5.55112e-15,-21.4},{-6,-21.4},{-6,-66}},
                                                      color={0,0,127}));
  connect(performanceData.QCon, divCOP.u1) annotation (Line(points={{-22.4,20.3},
          {-22.4,0},{-22,0},{-22,-22},{6,-22},{6,-66}},
                                                 color={0,0,127}));
  connect(divCOP.y, COP) annotation (Line(points={{-1.9984e-015,-89},{
          -1.9984e-015,-96.5},{0,-96.5},{0,-110}}, color={0,0,127}));
  connect(performanceData.Pel, Pel) annotation (Line(points={{-5.55112e-15,20.3},
          {-5.55112e-15,2},{0,2},{0,-16},{60.5,-16},{60.5,-110.5}},
                                                      color={0,0,127}));
  connect(switchQEva.y, QEva)
    annotation (Line(points={{-75,0},{-110,0}}, color={0,0,127}));
  connect(sigBusHP, performanceData.sigBusHP) annotation (Line(
      points={{1,103},{1,92.5},{5.77316e-15,92.5},{5.77316e-15,78.89}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.mode, switchQEva.u2) annotation (Line(
      points={{1.085,103.075},{1.085,104},{-52,104},{-52,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.mode, switchQCon.u2) annotation (Line(
      points={{1.085,103.075},{1.085,102},{72,102},{72,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-24,88},{22,44}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(
          points={{-16,82},{20,74}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-18,52},{20,58}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-98,40},{-60,-28}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(
          points={{-20,-60},{-20,-70},{-20,-80},{20,-60},{20,-80},{-20,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-122,34},{-66,34},{-82,10},{-66,-22},{-120,-22}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{60,40},{98,-28}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(
          points={{120,34},{64,34},{80,10},{64,-22},{118,-22}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-80,40},{-80,68},{-24,68}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{22,66},{80,66},{80,40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{78,-28},{78,-70}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{78,-70},{62,-70},{20,-70}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-80,-26},{-80,-68},{-20,-68}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-30,28},{30,-28}},
          lineColor={28,108,200},
          lineThickness=0.5,
          textString="%name",
          origin={0,-8},
          rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end innerCycle;
