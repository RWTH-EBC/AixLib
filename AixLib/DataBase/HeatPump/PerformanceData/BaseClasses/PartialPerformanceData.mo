﻿within AixLib.DataBase.HeatPump.PerformanceData.BaseClasses;
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

  Modelica.Blocks.Interfaces.RealOutput QEva(final unit="W", final displayUnit="kW")
                                                                         "Heat flow rate through Evaporator"  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-110})));
  Controls.Interfaces.VapourCompressionMachineControlBus        sigBus
    "Bus-connector used in a heat pump" annotation (Placement(
        transformation(
        extent={{-15,-14},{15,14}},
        rotation=0,
        origin={-1,100})));

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
