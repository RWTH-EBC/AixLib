within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses;
partial model PartialPerformanceData
  "Model with a replaceable for different methods of data aggregation"
  Modelica.Blocks.Interfaces.RealOutput Pel annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput QCon annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-110})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP annotation (Placement(
        transformation(
        extent={{-15,-14},{15,14}},
        rotation=0,
        origin={1,104})));
  Modelica.Blocks.Interfaces.RealOutput QEva annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-110})));
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
          rotation=180)}),Diagram(coordinateSystem(preserveAspectRatio=false)));
end PartialPerformanceData;
