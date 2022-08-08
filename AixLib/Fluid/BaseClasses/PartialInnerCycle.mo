within AixLib.Fluid.BaseClasses;
partial model PartialInnerCycle
  "Blackbox model of refrigerant cycle of a vapour compression machine (heat pump or chiller)"

  parameter Boolean use_rev=true "True if the vapour compression machine is reversible";
  parameter Real scalingFactor=1 "Scaling factor of vapour compression machine";

  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus annotation (
      Placement(transformation(extent={{-18,86},{18,118}}), iconTransformation(
          extent={{-16,88},{18,118}})));
  Modelica.Blocks.Sources.Constant constZero(final k=0) if not use_rev
    "If no heating is used, the switches may still be connected"
    annotation (Placement(transformation(extent={{-80,-78},{-60,-58}})));
  Modelica.Blocks.Interfaces.RealOutput QCon(unit="W", displayUnit="kW") "Heat Flow to condenser"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput QEva(unit="W", displayUnit="kW") "Heat flow from evaporator"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
  Utilities.Logical.SmoothSwitch switchQEva(
    u1(unit="W", displayUnit="kW"),
    u3(unit="W", displayUnit="kW"),
    y(unit="W", displayUnit="kW"))
    "If mode is false, Condenser becomes Evaporator and vice versa"
    annotation (Placement(transformation(extent={{-70,-24},{-90,-4}})));
  Utilities.Logical.SmoothSwitch switchQCon(
    y(unit="W",displayUnit="kW"),
    u1(unit="W", displayUnit="kW"),
    u3(unit="W", displayUnit="kW"))
    "If mode is false, Condenser becomes Evaporator and vice versa"
    annotation (Placement(transformation(extent={{70,-22},{90,-2}})));
  Modelica.Blocks.Interfaces.RealOutput Pel(unit="W", displayUnit="kW")
    "Electrical power consumed by compressor" annotation (Placement(
        transformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=-90,
        origin={0.5,-110.5})));


  AixLib.Utilities.Logical.SmoothSwitch switchPel(
    u1(unit="W", displayUnit="kW"),
    u3(unit="W", displayUnit="kW"),
    y(unit="W", displayUnit="kW"))
    "Whether to use cooling or heating power consumption" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-80})));


equation
  assert(
    use_rev or (use_rev == false and sigBus.modeSet == true),
    "Can't turn to reversible operation mode on irreversible vapour compression machine",
    level=AssertionLevel.error);

  connect(switchQEva.y, QEva) annotation (Line(points={{-91,-14},{-94,-14},{-94,
          0},{-110,0}}, color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{-2.22045e-15,-91},{
          -2.22045e-15,-110.5},{0.5,-110.5}},
                                 color={0,0,127}));
  connect(sigBus.modeSet,  switchPel.u2) annotation (Line(
      points={{0.09,102.08},{0.09,-68},{2.22045e-15,-68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(switchQCon.y, QCon) annotation (Line(points={{91,-12},{94,-12},{94,0},
          {110,0}}, color={0,0,127}));
  connect(sigBus.modeSet, switchQEva.u2) annotation (Line(
      points={{0.09,102.08},{-64,102.08},{-64,-14},{-68,-14}},
      color={255,204,51},
      thickness=0.5));
  connect(sigBus.modeSet, switchQCon.u2) annotation (Line(
      points={{0.09,102.08},{64,102.08},{64,-12},{68,-12}},
      color={255,204,51},
      thickness=0.5));
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
    Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the vapour compression machine
    partial model (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This black box model represents the refrigerant cycle of a vapour
  compression machine. Used in AixLib.Fluid.HeatPumps.HeatPump and
  AixLib.Fluid.Chiller.Chiller, this model serves the simulation of a
  reversible vapour compression machine. Thus, data both of chillers
  and heat pumps can be used to calculate the three relevant values
  <span style=\"font-family: Courier New;\">P_el</span>, <span style=
  \"font-family: Courier New;\">QCon</span> and <span style=
  \"font-family: Courier New;\">QEva</span>. The <span style=
  \"font-family: Courier New;\">mode</span> of the machine is used to
  switch between the performance data of the chiller and the heat pump.
</p>
<p>
  The user can choose between different types of performance data or
  implement a new black-box model by extending from the <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData\">
  partial</a> model.
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">
    LookUpTable2D</a>: Use 2D-data based on the DIN EN 14511
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTableND\">
    LookUpTableND</a>: Use SDF-data tables to model invertercontroller
    heat pumps or chillers or include other dependencies (ambient
    temperature etc.)
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.PolynomalApproach\">
    PolynomalApproach</a>: Use a function based approach to calculate
    the ouputs. Different functions are already implemented.
  </li>
</ul>
</html>"));
end PartialInnerCycle;
