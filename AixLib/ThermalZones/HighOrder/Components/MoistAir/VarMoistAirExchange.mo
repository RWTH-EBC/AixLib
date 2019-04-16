within AixLib.ThermalZones.HighOrder.Components.MoistAir;
model VarMoistAirExchange
  "Heat and moisture flow caused by air exchange"
  extends DryAir.VarAirExchange;
  Modelica.Blocks.Interfaces.RealOutput MoistFlow
    annotation (Placement(transformation(extent={{94,-72},{114,-52}})));
  Modelica.Blocks.Interfaces.RealInput HumIn(
    final quantity="MassFraction",
    final unit="kg/kg",
    min=0)
    "absolute humidity of ventilation air"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealInput HumOut(
    final quantity="MassFraction",
    final unit="kg/kg",
    min=0) "absolute humidity of room air"
    annotation (Placement(transformation(extent={{100,42},{80,62}})));
equation
  MoistFlow = InPort1 * V * rho * (HumIn-HumOut) / 3600;
end VarMoistAirExchange;
