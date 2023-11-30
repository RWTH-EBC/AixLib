within AixLib.Systems.EONERC_Testhall.BaseClass.CCA;
model ConcreteCoreActivation


  parameter Integer nNodes "Number of elements";
  parameter Modelica.Units.SI.HeatCapacity C
    "Heat capacity of element (= cp*m)";
  parameter  Modelica.Units.SI.ThermalConductance Gc
    "Signal representing the convective thermal conductance in [W/K]";

  AixLib.Fluid.FixedResistances.GenericPipe pipe(
    redeclare package Medium = AixLib.Media.Water,
    parameterPipe=parameterPipe,
    m_flow_nominal=m_flow_nominal,
    length=length,
    T_start=T_start) "Pipe that goes through the concrete" annotation (Dialog(enable=true),
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C/
        nNodes, T(start=323.15)) annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={32,38})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,44})));
  Modelica.Blocks.Sources.Constant const(k=Gc/nNodes)
    annotation (Placement(transformation(extent={{-60,34},{-40,54}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
    "heat port for connection to room volume" annotation (Placement(
        transformation(extent={{-10,66},{10,86}}),  iconTransformation(extent={{
            -10,100},{10,120}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_sup(redeclare package Medium =
        AixLib.Media.Water)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_ret(redeclare package Medium =
        AixLib.Media.Water)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(pipe.heatPort,heatCapacitor. port) annotation (Line(points={{7.21645e-16,
          10},{7.21645e-16,32},{12,32},{12,38},{24,38}},
                                         color={191,0,0}));
  connect(heatCapacitor.port,convection. solid)
    annotation (Line(points={{24,38},{0,38}},            color={191,0,0}));
  connect(convection.fluid,heatPort)
    annotation (Line(points={{3.88578e-16,50},{3.88578e-16,63},{0,63},{0,76}},
                                                       color={191,0,0}));
  connect(convection.Gc,const. y)
    annotation (Line(points={{-6,44},{-39,44}}, color={0,0,127}));
  connect(pipe.heatPort,convection. solid) annotation (Line(points={{7.21645e-16,
          10},{7.21645e-16,24},{-3.88578e-16,24},{-3.88578e-16,38}}, color={191,
          0,0}));
  connect(port_sup, pipe.port_a) annotation (Line(points={{-100,0},{-55,0},{-55,
          1.72085e-15},{-10,1.72085e-15}}, color={0,127,255}));
  connect(pipe.port_b, port_ret) annotation (Line(points={{10,-7.21645e-16},{55,
          -7.21645e-16},{55,0},{100,0}}, color={0,127,255}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{4,79},{-16,75},{-36,69},{-48,55},{-54,47},{-64,37},{-68,
              25},{-72,11},{-74,-3},{-72,-19},{-72,-31},{-72,-41},{-66,-53},
              {-60,-61},{-44,-65},{-26,-71},{-14,-71},{2,-73},{12,-77},{26,
              -77},{36,-75},{46,-69},{58,-63},{60,-61},{70,-49},{72,-41},{
              74,-39},{76,-23},{80,-9},{82,-1},{82,15},{78,27},{70,37},{58,
              45},{48,53},{40,69},{30,77},{4,79}},
          lineColor={255,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-54,47},{-64,37},{-68,25},{-72,11},{-74,-3},{-72,-19},{
              -72,-31},{-72,-41},{-66,-53},{-60,-61},{-44,-65},{-26,-71},{
              -14,-71},{2,-73},{12,-77},{26,-77},{36,-75},{46,-69},{58,-63},
              {46,-65},{44,-65},{34,-67},{24,-69},{22,-69},{14,-69},{6,-65},
              {-8,-61},{-18,-61},{-26,-59},{-36,-53},{-46,-43},{-52,-31},{
              -54,-23},{-54,-13},{-56,-1},{-56,7},{-56,19},{-54,29},{-52,31},
              {-48,39},{-44,47},{-40,57},{-36,69},{-54,47}},
          lineColor={255,0,0},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-65,19},{75,-12}},
          lineColor={0,0,0},
          textString="%CCA"),
        Line(points={{146,-70}}, color={255,0,0})}),             Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConcreteCoreActivation;
