within AixLib.ThermalZones.ReducedOrder.RC.BaseClasses;
model InteriorTabs
  extends InteriorWall;
    parameter Boolean ConcreteCore=false
   annotation (Dialog(group="TABS Specifications"), choices(checkBox=true));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CC if ConcreteCore
    "concrete core port"
    annotation (Placement(transformation(extent={{-10,30},{10,50}}),
    iconTransformation(extent={{-10,-108},{10,-88}})));
equation
  // Connect concrete core port
  if ConcreteCore then
    for i in 1:n loop
        connect(port_CC, thermCapInt[i].port)
        annotation (Line(points={{0,40},{0,-12}}, color={191,0,0}));
    end for;
  end if;

end InteriorTabs;
