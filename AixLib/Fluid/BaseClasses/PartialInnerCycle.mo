within AixLib.Fluid.BaseClasses;
model PartialInnerCycle
  "Blackbox model of refrigerant cycle of a thermal machine (heat pump or chiller)"
  replaceable model PerDataMain =
      AixLib.Fluid.BaseClasses.ThermalMachine_PerformanceData.BaseClasses.PartialPerformanceData
    constrainedby
    AixLib.Fluid.BaseClasses.ThermalMachine_PerformanceData.BaseClasses.PartialPerformanceData(final scalingFactor = scalingFactor)
     "Replaceable model for performance data of thermal machine in main operation mode"
    annotation (choicesAllMatching=true);

  replaceable model PerDataRev =
      AixLib.Fluid.BaseClasses.ThermalMachine_PerformanceData.BaseClasses.PartialPerformanceData
    constrainedby
    AixLib.Fluid.BaseClasses.ThermalMachine_PerformanceData.BaseClasses.PartialPerformanceData(final scalingFactor = scalingFactor)
     "Replaceable model for performance data of thermal machine in reversible operation mode"
    annotation (Dialog(enable=use_rev),choicesAllMatching=true);
  parameter Boolean use_rev=true "True if the thermal machine is reversible";
  parameter Real scalingFactor=1 "Scaling factor of thermal machine";
  AixLib.Controls.Interfaces.ThermalMachineControlBus sigBus annotation (
      Placement(transformation(extent={{-16,88},{18,118}}), iconTransformation(
          extent={{-16,88},{18,118}})));
  Modelica.Blocks.Interfaces.RealOutput QCon(unit="W", displayUnit="kW") "Heat Flow to condenser"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput QEva(unit="W", displayUnit="kW") "Heat flow from evaporator"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
  PerDataMain PerformanceDataHeater
                          annotation (Placement(transformation(extent={{13,20},{
            67,76}},  rotation=0)));
  Utilities.Logical.SmoothSwitch switchQEva(
    u1(unit="W", displayUnit="kW"),
    u3(unit="W", displayUnit="kW"),
    y(unit="W", displayUnit="kW"))
    "If mode is false, Condenser becomes Evaporator and vice versa"
    annotation (Placement(transformation(extent={{-70,-24},{-90,-4}})));
  Utilities.Logical.SmoothSwitch switchQCon(                                                            y(unit="W",displayUnit="kW"),
    u1(unit="W", displayUnit="kW"),
    u3(unit="W", displayUnit="kW"))
    "If mode is false, Condenser becomes Evaporator and vice versa"
    annotation (Placement(transformation(extent={{72,-22},{92,-2}})));
  Modelica.Blocks.Interfaces.RealOutput Pel(unit="W", displayUnit="kW")
    "Electrical power consumed by compressor" annotation (Placement(
        transformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=-90,
        origin={0.5,-110.5})));

  PerDataRev PerformanceDataChiller if use_rev
                          annotation(Placement(transformation(
        extent={{-27,-28},{27,28}},
        rotation=0,
        origin={-46,48})));

  AixLib.Utilities.Logical.SmoothSwitch switchPel(
    u1(unit="W", displayUnit="kW"),
    u3(unit="W", displayUnit="kW"),
    y(unit="W", displayUnit="kW"))
    "Whether to use cooling or heating power consumption" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-76})));
protected
  Modelica.Blocks.Sources.Constant constZero(final k=0) if not use_rev
    "If no heating is used, the switches may still be connected"
    annotation (Placement(transformation(extent={{-80,-74},{-60,-54}})));
public
  Modelica.Blocks.Math.Gain gainCon(final k=-1) if use_rev
    "Negate QCon to match definition of heat flow direction" annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={58,-20})));
  Modelica.Blocks.Math.Gain gainEva(final k=-1)
    "Negate QEva to match definition of heat flow direction" annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-56,-6})));
equation
  assert(
    use_rev or (use_rev == false and sigBus.mode == true),
    "Can't turn to chilling on irreversible HP",
    level=AssertionLevel.error);
  connect(sigBus.mode, switchQEva.u2) annotation (Line(
      points={{1.085,103.075},{1.085,104},{-68,104},{-68,-14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.mode, switchQCon.u2) annotation (Line(
      points={{1.085,103.075},{1.085,102},{70,102},{70,-12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus, PerformanceDataHeater.sigBus) annotation (Line(
      points={{1,103},{1,86},{2,86},{2,86},{38,86},{38,77.12},{40.27,77.12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switchQEva.y, QEva) annotation (Line(points={{-91,-14},{-92,-14},{-92,
          0},{-110,0}}, color={0,0,127}));
  connect(PerformanceDataHeater.QCon, switchQCon.u1)
    annotation (Line(points={{18.4,17.2},{18.4,-4},{70,-4}}, color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{-2.22045e-015,-87},{-2.22045e-015,
          -110.5},{0.5,-110.5}}, color={0,0,127}));
  connect(sigBus.mode, switchPel.u2) annotation (Line(
      points={{1.085,103.075},{1.085,-64},{2.22045e-015,-64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(PerformanceDataHeater.Pel, switchPel.u1) annotation (Line(points={{40,
          17.2},{40,-30},{8,-30},{8,-64}}, color={0,0,127}));
  connect(PerformanceDataChiller.Pel, switchPel.u3) annotation (Line(points={{-46,
          17.2},{-46,-30},{-8,-30},{-8,-64}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PerformanceDataChiller.QEva, switchQEva.u3) annotation (Line(points={{-24.4,
          17.2},{-24.4,-22},{-68,-22}},       color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBus, PerformanceDataChiller.sigBus) annotation (Line(
      points={{1,103},{1,86},{-45.73,86},{-45.73,77.12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(constZero.y, switchPel.u3)
    annotation (Line(points={{-59,-64},{-8,-64}}, color={0,0,127}));
  connect(constZero.y, switchQEva.u3) annotation (Line(points={{-59,-64},{-52,
          -64},{-52,-22},{-68,-22}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constZero.y, switchQCon.u3) annotation (Line(points={{-59,-64},{-52,
          -64},{-52,-38},{70,-38},{70,-20}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(switchQCon.y, QCon) annotation (Line(points={{93,-12},{94,-12},{94,0},
          {110,0}}, color={0,0,127}));
  connect(gainEva.y, switchQEva.u1)
    annotation (Line(points={{-60.4,-6},{-68,-6}}, color={0,0,127}));
  connect(switchQCon.u3, gainCon.y) annotation (Line(
      points={{70,-20},{62.4,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PerformanceDataChiller.QCon, gainCon.u) annotation (Line(
      points={{-67.6,17.2},{-67.6,0},{-24,0},{-24,-20},{53.2,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PerformanceDataHeater.QEva, gainEva.u) annotation (Line(points={{61.6,
          17.2},{61.6,-6},{-51.2,-6}}, color={0,0,127}));
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
          rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>", info="<html>
<p>This black box model represents the refrigerant cycle of a heat pump. Used in AixLib.Fluid.HeatPumps.HeatPump, this model serves the simulation of a reversible heat pump. Thus, data both of chillers and heat pumps can be used to calculate the three relevant values <span style=\"font-family: Courier New;\">P_el</span>, <span style=\"font-family: Courier New;\">QCon</span> and <span style=\"font-family: Courier New;\">QEva</span>. The <span style=\"font-family: Courier New;\">mode</span> of the heat pump is used to switch between the performance data of the chiller and the heat pump.</p>
<p>The user can choose between different types of performance data or implement a new black-box model by extending from the <a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData\">partial</a> model.</p>
<ul>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">LookUpTable2D</a>: Use 2D-data based on the DIN EN 14511</li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTableND\">LookUpTableND</a>: Use SDF-data tables to model invertercontroller heat pumps or include other dependencies (ambient temperature etc.)</li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.PolynomalApproach\">PolynomalApproach</a>: Use a function based approach to calculate the ouputs. Different functions are already implemented.</li>
</ul>
</html>"));
end PartialInnerCycle;
