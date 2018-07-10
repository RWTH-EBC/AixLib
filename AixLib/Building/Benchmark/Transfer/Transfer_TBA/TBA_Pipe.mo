within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model TBA_Pipe
  import BaseLib = AixLib.Utilities;
  Modelica.Fluid.Pipes.DynamicPipe pipe(use_HeatTransfer=true,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    length=wall_length*wall_height*5.8,
    diameter=pipe_diameter,
    nNodes=2)
    annotation (Placement(transformation(extent={{-16,34},{16,66}})));
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
equation
  connect(pipe.heatPorts[1], HeatPort_TBA_OpenPlanOffice) annotation (Line(
        points={{-2.32,57.04},{-2.32,71.36},{0,71.36},{0,100}}, color={127,0,0}));
  connect(pipe.heatPorts[2], HeatPort_TBA_OpenPlanOffice)
    annotation (Line(points={{2.64,57.04},{0,100}}, color={127,0,0}));
  connect(pipe.port_a, Fluid_in) annotation (Line(points={{-16,50},{-60,50},{
          -60,-100}}, color={0,127,255}));
  connect(pipe.port_b, Fluid_out)
    annotation (Line(points={{16,50},{60,50},{60,-100}}, color={0,127,255}));
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
