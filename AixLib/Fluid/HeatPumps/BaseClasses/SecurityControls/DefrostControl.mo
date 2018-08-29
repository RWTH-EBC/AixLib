within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block DefrostControl
  "Control block to ensure no frost limits heat flow at the evaporator"
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-14,-112},{14,-84}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{100,-12},{124,12}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.Constant constMinIceFac(k=minIceFac)
    "Temperature at which the legionella in DWH dies" annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={26,-80})));
  Modelica.Blocks.Logical.GreaterEqual iceFacGreMin
    "Check if icing factor is greater than a boundary" annotation (Placement(
        transformation(
        extent={{-8,-9},{8,9}},
        rotation=90,
        origin={19,-52})));
  parameter Real minIceFac "Minimal value above which no defrost is necessary";
  Modelica.Blocks.Sources.Constant constOne(final k=1)
    "As defrost should operate on full compressor speed"
    annotation (Placement(transformation(extent={{34,-16},{46,-4}})));
  Utilities.Logical.SmoothSwitch switchNSet
    "If defrost is on, the compressor has to run with 100 percent"
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
equation
  connect(constMinIceFac.y, iceFacGreMin.u2) annotation (Line(points={{26,-75.6},
          {26,-61.6},{26.2,-61.6}}, color={0,0,127}));
  connect(switchNSet.y, nOut)
    annotation (Line(points={{83,0},{112,0}}, color={0,0,127}));
  connect(switchNSet.u3, constOne.y) annotation (Line(points={{60,-8},{54,-8},{
          54,-10},{46.6,-10}}, color={0,0,127}));
  connect(nSet, switchNSet.u1)
    annotation (Line(points={{-120,0},{10,0},{10,8},{60,8}}, color={0,0,127}));
  connect(iceFacGreMin.y, switchNSet.u2) annotation (Line(points={{19,-43.2},{
          19,0.4},{60,0.4},{60,0}}, color={255,0,255}));
  connect(iceFacGreMin.y, sigBusHP.mode) annotation (Line(points={{19,-43.2},{
          19,-28},{20,-28},{20,-24},{0.07,-24},{0.07,-97.93}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.iceFac, iceFacGreMin.u1) annotation (Line(
      points={{0.07,-97.93},{0.07,-70},{19,-70},{19,-61.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                            Rectangle(
          extent={{-86,85.5},{89.5,-82.5}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}),
        Line(
          points={{-38,64},{-38,24}},
          color={28,108,200}),
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          origin={-38,44},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={28,108,200},
          origin={-38,44},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={28,108,200},
          origin={-38,44},
          rotation=90),
        Line(
          points={{14,52},{14,12}},
          color={28,108,200}),
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          origin={14,32},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={28,108,200},
          origin={14,32},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={28,108,200},
          origin={14,32},
          rotation=90),
        Line(
          points={{-32,12},{-32,-28}},
          color={28,108,200}),
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          origin={-32,-8},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={28,108,200},
          origin={-32,-8},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={28,108,200},
          origin={-32,-8},
          rotation=90),
        Line(
          points={{32,0},{32,-40}},
          color={28,108,200}),
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          origin={32,-20},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={28,108,200},
          origin={32,-20},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={28,108,200},
          origin={32,-20},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Basic model for a defrost control. The icing factor is calculated in the heat pump based on functions or other models.</p>
<p>If a given lower boundary is surpassed, the mode of the heat pump will be set to false(eq. Chilling) and the compressor speed is set to 1(eq. 100&percnt;) to make the defrost process as fast as possible.</p>
</html>"));
end DefrostControl;
