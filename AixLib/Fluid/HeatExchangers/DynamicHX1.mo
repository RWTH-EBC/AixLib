within AixLib.Fluid.HeatExchangers;
model DynamicHX1 "Simple dynamic heat exchanger model"
  extends Interfaces.FourPortHeatExchanger;

  parameter Modelica.SIunits.Time tau_C = 30 "Time constant of heat capacity at nominal heat flow and temperature difference."
                                                                                                                              annotation(Dialog(tab = "Dynamics",group = "Nominal condition"));
  parameter Modelica.SIunits.TemperatureDifference dT_nom "Temperature difference at nominal conditions (used to calculate Gc)" annotation(Dialog(group = "Heat Transfer"));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor[nNodes](
    each final C=Q_nom/dT_nom*tau_C/nNodes,
    each final T(fixed=true, start=TCapacity_start))
    annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  parameter Modelica.SIunits.HeatFlowRate Q_nom "Temperature difference at nominal conditions (used to calculate Gc)" annotation(Dialog(group = "Heat Transfer"));
  parameter Modelica.SIunits.Temperature TCapacity_start=(T1_start + T2_start)/2
    "Start value of temperature"
    annotation(Dialog(tab="Initialization",   group="Heat capacity"));
  parameter Modelica.Blocks.Interfaces.RealInput Gc1(unit="W/K") = Q_nom/dT_nom*2
    "Signal representing the convective thermal conductance in [W/K]" annotation(Dialog(group = "Heat Transfer"));
  parameter Modelica.Blocks.Interfaces.RealInput Gc2(unit="W/K") = Q_nom/dT_nom*2
    "Signal representing the convective thermal conductance in [W/K]"  annotation(Dialog(group = "Heat Transfer"));
  Modelica.Blocks.Sources.RealExpression Gc1_Expression[nNodes](
  each final y=Gc1)
    annotation (Placement(transformation(extent={{-98,22},{-78,42}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection1[nNodes]
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-32,30})));
  Modelica.Blocks.Sources.RealExpression Gc2_Expression[nNodes](
  each final y=Gc2)
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,-30})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection2[nNodes]
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={30,-30})));
  Modelica.Blocks.Logical.Switch switch1[nNodes]
    annotation (Placement(transformation(extent={{-68,-2},{-48,18}})));
  Modelica.Blocks.Sources.RealExpression realExpression[nNodes](each y=0.0)
    annotation (Placement(transformation(extent={{-96,-22},{-76,-2}})));
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{24,72},{64,112}})));
equation
  connect(convection2.solid, vol2.heatPort)
    annotation (Line(points={{30,-40},{30,-50},{10,-50}}, color={191,0,0}));
  connect(convection1.solid, vol1.heatPort)
    annotation (Line(points={{-32,40},{-32,50},{-10,50}}, color={191,0,0}));
  connect(convection1.fluid, heatCapacitor.port)
    annotation (Line(points={{-32,20},{-32,-2},{0,-2}},
                                                      color={191,0,0}));
  connect(convection2.fluid, heatCapacitor.port)
    annotation (Line(points={{30,-20},{30,-2},{0,-2}},
                                                     color={191,0,0}));
  connect(Gc2_Expression.y, convection2.Gc)
    annotation (Line(points={{47,-30},{40,-30}}, color={0,0,127}));
  connect(switch1.y, convection1.Gc) annotation (Line(points={{-47,8},{-46,8},{-46,
          30},{-42,30}},         color={0,0,127}));

  connect(Gc1_Expression.y, switch1.u1) annotation (Line(points={{-77,32},{-74,32},
          {-74,16},{-70,16}},          color={0,0,127}));
  connect(realExpression.y, switch1.u3) annotation (Line(points={{-75,-12},{-74,
          -12},{-74,0},{-70,0}},      color={0,0,127}));
  connect(u, switch1[1].u2) annotation (Line(points={{44,92},{-98,92},{-98,8},{
          -70,8}},  color={255,0,255}));
  connect(switch1[2].u2, u) annotation (Line(points={{-70,8},{-98,8},{-98,92},{
          44,92}}, color={255,0,255}));
  annotation (Line(points={{-58,-98},{-98,-98},{-98,8},
          {-70,8}}, color={255,0,255}),
              Documentation(revisions="<html>
<ul>
<li>
December 12, 2018, by Alexander K&uuml;mpel:<br/>
First implementation, <a href=\"https://github.com/RWTH-EBC/AixLib/tree/issue661_SimpleDynamicHeatExchangerModel\">AixLib, issue 661</a>.
</li>
</ul>
</html>", info="<html>
<p>This is a simple dynamic heat exchanger with a heat capacity and convection. The heat exchanger is discretized in n elements and the volume elements are replaceable. </p>
<p>The heat transfer and pressure losses are calculated by nominal values. Nevertheless, the heat transfer coefficient Gc can be overwritten.</p>
</html>"));
end DynamicHX1;
