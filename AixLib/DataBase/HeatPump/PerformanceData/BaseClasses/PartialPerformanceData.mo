within AixLib.DataBase.HeatPump.PerformanceData.BaseClasses;
partial model PartialPerformanceData
  "Model with a replaceable for different methods of data aggregation"

  Modelica.Blocks.Interfaces.RealOutput Pel(final unit="W", final displayUnit="kW")
                                                      "Electrical Power consumed by HP" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput QCon(final unit="W", final displayUnit="kW")
    "Heat flow rate through Condenser" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-110})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus
    "Bus-connector used in a heat pump" annotation (Placement(
        transformation(
        extent={{-15,-14},{15,14}},
        rotation=0,
        origin={1,104})));
  Modelica.Blocks.Interfaces.RealOutput QEva(final unit="W", final displayUnit="kW")
                                                                         "Heat flow rate through Evaporator"  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-110})));
  Modelica.Blocks.Math.Add calcRedQCon
    "Based on redcued heat flow to the evaporator, the heat flow to the condenser is also reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={80,-68})));
  Modelica.Blocks.Math.Product proRedQEva
    "Based on the icing factor, the heat flow to the evaporator is reduced"
    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={-80,-60})));
protected
  parameter Real scalingFactor=1 "Scaling factor of heat pump";
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
    "Calculates evaporator heat flow with total energy balance"                 annotation(Placement(transformation(extent={{-6,-6},
            {6,6}},
        rotation=270,
        origin={-76,-38})));
equation
  connect(proRedQEva.u1, sigBus.iceFacMea) annotation (Line(points={{-83.6,
          -52.8},{-83.6,-48},{-96,-48},{-96,94},{1.075,94},{1.075,104.07}},
                                                                     color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(proRedQEva.y, QEva) annotation (Line(points={{-80,-66.6},{-80,-84},
          {80,-84},{80,-110}}, color={0,0,127}));
  connect(proRedQEva.y, calcRedQCon.u1) annotation (Line(points={{-80,-66.6},
          {-80,-70},{-66,-70},{-66,-54},{83.6,-54},{83.6,-60.8}}, color={0,0,
          127}));
  connect(calcRedQCon.y, QCon) annotation (Line(points={{80,-74.6},{80,-78},{
          -62,-78},{-62,-90},{-80,-90},{-80,-110}}, color={0,0,127}));
  connect(proRedQEva.u2, feedbackHeatFlowEvaporator.y) annotation (Line(
        points={{-76.4,-52.8},{-76,-52.8},{-76,-43.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),   Text(
          extent={{-47.5,-26.5},{47.5,26.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="%name
",        origin={0.5,60.5},
          rotation=180)}),Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Partial model for calculation of <span style=
  \"font-family: Courier New;\">P_el</span>, <span style=
  \"font-family: Courier New;\">QCon</span> and <span style=
  \"font-family: Courier New;\">QEva</span> based on the values in the
  <span style=\"font-family: Courier New;\">sigBusHP</span>.
</p>
</html>"));
end PartialPerformanceData;
