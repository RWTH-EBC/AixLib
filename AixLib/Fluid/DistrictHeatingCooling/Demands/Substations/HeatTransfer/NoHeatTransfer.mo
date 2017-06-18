within AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.HeatTransfer;
model NoHeatTransfer
  "Ideal container with direct throughflow instead of heat transfer in DHC substations"
  extends BaseClasses.Demands.Substations.HeatTransfer.PartialHeatTransfer(
    use_Q_in=false,
    prescribedQ=0);
equation
  connect(port_a, port_b)
    annotation (Line(points={{-100,0},{100,0}}, color={0,127,255}));
end NoHeatTransfer;
