within AixLib.ThermalZones.ReducedOrder.Examples;
model ThermalZoneMoistAirSwimmingPoolStratified
  "Illustrates the use of ThermalZone with a vertically stratified air volume in a swimming hall"
  extends AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneMoistAirSwimmingPool(
    thermalZone(
      use_stratification=true,
      nLay=2,
      layPort={2,1}));

  annotation (
    experiment(Tolerance=1e-6,StopTime=3.1536e+007,Interval=3600),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Examples/ThermalZoneMoistAirSwimmingPoolStratified.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example illustrates the use of
<a href=\"modelica://AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone\">
AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone</a>
with a vertically stratified air volume (<code>use_stratification=true</code>) for a
swimming hall with downward air distribution. It is identical to
<a href=\"modelica://AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneMoistAirSwimmingPool\">
AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneMoistAirSwimmingPool</a>,
except that the air volume is divided into two layers: the occupied zone with the
pools (layer 1, height 2 m) and the remaining hall above (layer 2). The supply air
enters the top layer (port 1), the extract air leaves the lowest layer (port 2).
Evaporation and convective heat of the pools act on layer 1, the room temperature
set point refers to the top layer.
</p>
<p>
The room temperature set point is 30 &deg;C, i.e. 2 K above the water temperature of
the sport pool (28 &deg;C). According to Kaluza and Fiedler (2020) a stable
stratification above a pool requires an air temperature of 2 to 4 K above the pool
water temperature. The water temperature of the children's pool (30 &deg;C) is not
below the set point, so the stratification above this pool is not expected to be
stable.
</p>
<p>
All boundary conditions are generic. The vertical exchange parameters
<code>kappaStab</code> and <code>kappaMix</code> are not calibrated. The results
are not related to a specific building or measurement data.
</p>
</html>", revisions="<html>
<ul>
<li>November 10, 2026, by Leander Waerder:<br/>
First implementation for issue
<a href=\"https://github.com/RWTH-EBC/AixLib/issues/1649\">#1649</a>.
</li>
</ul>
</html>"));
end ThermalZoneMoistAirSwimmingPoolStratified;
