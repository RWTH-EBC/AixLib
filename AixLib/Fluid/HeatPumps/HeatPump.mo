within AixLib.Fluid.HeatPumps;
model HeatPump "Base model of realistic heat pump"
  Modelica.Fluid.Interfaces.FluidPort_a port_evaIn(redeclare package Medium =
        Medium_eva) "Evaporator fluid input port" annotation (Placement(
        transformation(extent={{-140,60},{-120,80}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_evaOut(redeclare package Medium =
        Medium_eva) "Evaporator fluid output port" annotation (Placement(
        transformation(extent={{-140,-80},{-120,-60}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_conOut(redeclare package Medium =
        Medium_con) "Condenser fluid ouput port" annotation (Placement(
        transformation(extent={{120,60},{140,80}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_conIn(redeclare package Medium =
        Medium_con) "Condenser fluid input port" annotation (Placement(
        transformation(extent={{120,-80},{140,-60}}, rotation=0)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{140,100}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-140,-100},{140,100}})));
end HeatPump;
