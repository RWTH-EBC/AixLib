within AixLib.Fluid.DistrictHeatingCooling.Demands;
package NoReturn "Demand node models without return flow"

annotation (Documentation(info="<html><p>
  The models in this package represent demand nodes in DHC systems for
  system models that do not consider the return part of the network.
  Therefore, the demand models only have one fluid port for connection
  to the supply network.
</p>
</html>"));
end NoReturn;
