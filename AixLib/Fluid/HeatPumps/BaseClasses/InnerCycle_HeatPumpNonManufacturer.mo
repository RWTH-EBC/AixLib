within AixLib.Fluid.HeatPumps.BaseClasses;
model InnerCycle_HeatPumpNonManufacturer
  "Blackbox model of refrigerant cycle of a heat pump in case no manufacturer data is used"
  extends AixLib.Fluid.BaseClasses.PartialInnerCycle(use_rev=false);

  replaceable model PerDataMainHP =
      AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData constrainedby
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData(
    final scalingFactor=scalingFactor,
    final THotMax=THotMax,
    final THotNom=THotNom,
    final TSourceNom=TSourceNom,
    final QNom=QNom,
    final PLRMin=PLRMin,
    final HighTemp=HighTemp,
    final DeltaTCon=DeltaTCon,
    final DeltaTEvap=DeltaTEvap,
    final TSource=TSource,
    final dTConFix=dTConFix)
    "Replaceable model for performance data of a heat pump in main operation mode" annotation (
      choicesAllMatching=true);

  replaceable model PerDataRevHP =
      AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData
    constrainedby
    AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData(
     final scalingFactor = scalingFactor)
    "Replaceable model for performance data of a heat pump in reversible operation mode"
    annotation (Dialog(enable=use_rev),choicesAllMatching=true);

  Modelica.Blocks.Math.Gain gainEva(final k=-1)
    "Negate QEva to match definition of heat flow direction" annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-56,-6})));
  Modelica.Blocks.Math.Gain gainCon(final k=-1) if use_rev
    "Negate QCon to match definition of heat flow direction" annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={58,-20})));

// Not Manufacturer parameters
   parameter Modelica.SIunits.Temperature THotMax=333.15 "Max. value of THot before shutdown"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
   parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));
   parameter Modelica.SIunits.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));
   parameter Modelica.SIunits.HeatFlowRate QNom=30000 "Nominal heat flow"
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));
   parameter Real PLRMin=0.4 "Limit of PLR; less =0"
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));
   parameter Boolean HighTemp=false "true: THot > 60°C"
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));
   parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));
   parameter Modelica.SIunits.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));

   parameter Modelica.SIunits.Temperature TSource=280 "temperature of heat source"
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));

  parameter Boolean dTConFix=false
    annotation (Dialog(tab="NotManufacturer", group="General machine information"));

equation

  connect(PerformanceDataHPHeatingNonManufacturer.QCon, switchQCon.u1)
    annotation (Line(points={{12.4,17.2},{12.4,-4},{68,-4}}, color={0,0,127}));
  connect(PerformanceDataHPHeatingNonManufacturer.Pel, switchPel.u1)
    annotation (Line(points={{34,17.2},{34,-30},{8,-30},{8,-68}}, color={0,0,
          127}));
  connect(constZero.y, switchPel.u3)
    annotation (Line(points={{-59,-68},{-34,-68},{-34,-68},{-8,-68}},
                                                  color={0,0,127}));
  connect(constZero.y, switchQEva.u3) annotation (Line(points={{-59,-68},{-52,-68},
          {-52,-22},{-68,-22}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constZero.y, switchQCon.u3) annotation (Line(points={{-59,-68},{-52,-68},
          {-52,-38},{68,-38},{68,-20}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gainEva.y, switchQEva.u1)
    annotation (Line(points={{-60.4,-6},{-68,-6}}, color={0,0,127}));
  connect(switchQCon.u3, gainCon.y) annotation (Line(
      points={{68,-20},{62.4,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PerformanceDataHPHeatingNonManufacturer.QEva, gainEva.u) annotation (
      Line(points={{55.6,17.2},{55.6,-6},{-51.2,-6}}, color={0,0,127}));
  connect(sigBus, PerformanceDataHPHeatingNonManufacturer.sigBus) annotation (
      Line(
      points={{0,102},{0,86},{33.73,86},{33.73,76}},
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
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
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
  This black box model represents the refrigerant cycle of a heat pump.
  Used in AixLib.Fluid.HeatPumps.HeatPump, this model serves the
  simulation of a reversible heat pump. Thus, data both of chillers and
  heat pumps can be used to calculate the three relevant values
  <span style=\"font-family: Courier New;\">P_el</span>, <span style=
  \"font-family: Courier New;\">QCon</span> and <span style=
  \"font-family: Courier New;\">QEva</span>. The <span style=
  \"font-family: Courier New;\">mode</span> of the heat pump is used to
  switch between the performance data of the chiller and the heat pump.
</p>
<p>
  The user can choose between different types of performance data or
  implement a new black-box model by extending from the <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.ReversibleHeatPump_PerformanceData.BaseClasses.PartialPerformanceData\">
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
    heat pumps or include other dependencies (ambient temperature etc.)
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.PolynomalApproach\">
    PolynomalApproach</a>: Use a function based approach to calculate
    the ouputs. Different functions are already implemented.
  </li>
</ul>
</html>"));
end InnerCycle_HeatPumpNonManufacturer;
