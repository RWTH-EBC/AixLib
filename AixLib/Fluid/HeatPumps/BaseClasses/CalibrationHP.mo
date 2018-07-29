within AixLib.Fluid.HeatPumps.BaseClasses;
block CalibrationHP "Block with different options to calibrate the Heat Pump"
  Modelica.Blocks.Tables.CombiTable2D combiTable2D annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,50})));
  Modelica.Blocks.Tables.CombiTable2D combiTable2D1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={50,50})));
  Modelica.Blocks.Interfaces.RealOutput Pel annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput QCon annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-110})));
  Controls.Interfaces.HeatPumpControlBus heatPumpControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Blocks.Interfaces.RealOutput QEva annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-110})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CalibrationHP;
