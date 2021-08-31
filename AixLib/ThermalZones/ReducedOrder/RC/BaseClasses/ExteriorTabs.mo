within AixLib.ThermalZones.ReducedOrder.RC.BaseClasses;
model ExteriorTabs
  extends ExteriorWall;
  parameter Boolean ConcreteCore=false
   annotation (Dialog(group="UFH Specifications"), choices(checkBox=true));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CC if ConcreteCore
                                                             "interior port"
    annotation (Placement(transformation(extent={{-10,108},{10,128}}),
    iconTransformation(extent={{-10,112},{10,132}})));
equation
  if ConcreteCore then
    for i in 1:n loop
      connect(port_CC, thermCapExt[i].port)
      annotation (Line(points={{0,118},{0,-12}},color={191,0,0}));
    end for;
  end if;
end ExteriorTabs;
