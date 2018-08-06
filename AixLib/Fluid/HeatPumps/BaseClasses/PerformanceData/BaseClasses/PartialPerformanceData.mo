within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses;
partial block PartialPerformanceData
  "Model with a replaceable for different methods of data aggregation"
  Modelica.Blocks.Interfaces.RealOutput Pel annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealOutput QCon annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-80})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP annotation (Placement(
        transformation(
        extent={{-15,-14},{15,14}},
        rotation=0,
        origin={-107,0})));
  Modelica.Blocks.Interfaces.RealOutput QEva annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,80})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-47.5,-26.5},{47.5,26.5}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="%name
",        origin={8.5,2.5},
          rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PartialPerformanceData;
