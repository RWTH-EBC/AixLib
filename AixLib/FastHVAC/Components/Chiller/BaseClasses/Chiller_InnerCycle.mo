within AixLib.FastHVAC.Components.Chiller.BaseClasses;
model Chiller_InnerCycle
  "Blackbox model of refrigerant cycle of a HP in cooling mode"

  replaceable model PerDataChi =
      AixLib.FastHVAC.Components.Chiller.PerformanceData.BaseClasses.PartialPerformanceData
    constrainedby
    AixLib.FastHVAC.Components.Chiller.PerformanceData.BaseClasses.PartialPerformanceData(final scalingFactor = scalingFactor)
     "Replaceable model for performance data of HP in cooling mode"
    annotation (choicesAllMatching=true);

  parameter Real scalingFactor=1 "Scaling factor of heat pump";
  Controls.Interfaces.ChillerControlBus sigBusChi annotation (Placement(
        transformation(extent={{-16,88},{18,118}}), iconTransformation(extent={{-16,88},
            {18,118}})));
  Modelica.Blocks.Interfaces.RealOutput QCon(unit="W", displayUnit="kW") "Heat Flow to condenser"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput QEva(unit="W", displayUnit="kW") "Heat flow from evaporator"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
  Modelica.Blocks.Interfaces.RealOutput Pel(unit="W", displayUnit="kW")
    "Electrical power consumed by compressor" annotation (Placement(
        transformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=-90,
        origin={0.5,-110.5})));

  PerDataChi PerformanceDataChiller
                          annotation(Placement(transformation(
        extent={{27,-28},{-27,28}},
        rotation=0,
        origin={0,48})));

public
  Modelica.Blocks.Math.Gain gainCon(final k=-1)
    "Negate QCon to match definition of heat flow direction" annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={78,0})));
equation

  connect(sigBusChi, PerformanceDataChiller.sigBusChi) annotation (Line(
      points={{1,103},{1,90.5},{-0.27,90.5},{-0.27,77.12}},
      color={255,204,51},
      thickness=0.5));
  connect(gainCon.y, QCon)
    annotation (Line(points={{82.4,0},{110,0}}, color={0,0,127}));
  connect(PerformanceDataChiller.QEva, QEva) annotation (Line(points={{-21.6,17.2},
          {-21.6,0},{-110,0}}, color={0,0,127}));
  connect(PerformanceDataChiller.QCon, gainCon.u)
    annotation (Line(points={{21.6,17.2},{21.6,0},{73.2,0}}, color={0,0,127}));
  connect(PerformanceDataChiller.Pel, Pel) annotation (Line(points={{0,17.2},{0,
          -46},{0,-110.5},{0.5,-110.5}}, color={0,0,127}));
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
end Chiller_InnerCycle;
