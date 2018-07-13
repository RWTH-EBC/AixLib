within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model TBA_Pipe
  import BaseLib = AixLib.Utilities;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA_OpenPlanOffice
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  parameter Modelica.SIunits.Length pipe_diameter = 0.02 annotation(Dialog(tab = "General"));
  parameter Modelica.SIunits.Length wall_length = 0 annotation(Dialog(tab = "General"));
  parameter Modelica.SIunits.Length wall_height = 0 annotation(Dialog(tab = "General"));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    V=wall_length*wall_height*5.8*3.14159*(pipe_diameter/2)^2)
    annotation (Placement(transformation(extent={{-8,46},{12,66}})));

equation
  connect(vol.ports[1], Fluid_out)
    annotation (Line(points={{0,46},{60,46},{60,-100}}, color={0,127,255}));
  connect(vol.ports[2], Fluid_in)
    annotation (Line(points={{4,46},{-60,46},{-60,-100}}, color={0,127,255}));
  connect(vol.heatPort, HeatPort_TBA_OpenPlanOffice) annotation (Line(points={{
          -8,56},{-24,56},{-24,86},{0,86},{0,100}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-48,0},{54,-10}},
          lineColor={28,108,200},
          textString="Hydraulik einfügen (siehe Powerpoint und AKU Modell)"),
                                                               Text(
          extent={{-48,-32},{48,-60}},
          lineColor={28,108,200},
          textString="Pipe für hin und Abfluss einfügen
Mit Parameter
")}));
end TBA_Pipe;
