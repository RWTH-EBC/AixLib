within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model IcingBlock
  "Block which decreases evaporator power by an icing factor"
  extends Modelica.Blocks.Interfaces.SISO;
  Modelica.Blocks.Interfaces.RealOutput iceFac_out
    "Output of current icing factor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  parameter Real iceFac_default = 1;
equation
  iceFac_out = iceFac_default;
  y = iceFac_out*u;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IcingBlock;
