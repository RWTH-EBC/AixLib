within AixLib.Fluid.HeatExchangers;
model DynamicHX "Simple dynamic heat exchanger model"
  extends Interfaces.FourPortHeatExchanger;

  parameter Modelica.SIunits.TemperatureDifference dT_nom "Temperature difference at nominal conditions (used to calculate Gc)" annotation(Dialog(group = "Heat Transfer"));
  parameter Modelica.SIunits.HeatFlowRate Q_nom "Temperature difference at nominal conditions (used to calculate Gc)" annotation(Dialog(group = "Heat Transfer"));

  parameter Modelica.SIunits.HeatCapacity heatCapacity = 1000 "Heat capacity of heat exchanger material" annotation(Dialog(group = "Heat Transfer"));
  parameter Modelica.SIunits.Temperature Tcapacity_start = (T1_start + T2_start)/2
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization", group = "Medium 1"));
  parameter Modelica.Blocks.Interfaces.RealInput Gc1(unit="W/K") = Q_nom/dT_nom*2
    "Signal representing the convective thermal conductance in [W/K]" annotation(Dialog(group = "Heat Transfer"));
  parameter Modelica.Blocks.Interfaces.RealInput Gc2(unit="W/K") = Q_nom/dT_nom*2
    "Signal representing the convective thermal conductance in [W/K]"  annotation(Dialog(group = "Heat Transfer"));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor[nNodes](each C=
        heatCapacity/nNodes, each T(fixed=true, start=Tcapacity_start))
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Blocks.Sources.RealExpression Gc1_Expression[nNodes](each y=Gc1)
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection1[nNodes]
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-32,30})));
  Modelica.Blocks.Sources.RealExpression Gc2_Expression[nNodes](each y=Gc2)
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
equation
  connect(convection2.solid, vol2.heatPort)
    annotation (Line(points={{30,-40},{30,-50},{10,-50}}, color={191,0,0}));
  connect(convection1.solid, vol1.heatPort)
    annotation (Line(points={{-32,40},{-32,50},{-10,50}}, color={191,0,0}));
  connect(convection1.fluid, heatCapacitor.port)
    annotation (Line(points={{-32,20},{-32,0},{0,0}}, color={191,0,0}));
  connect(convection2.fluid, heatCapacitor.port)
    annotation (Line(points={{30,-20},{30,0},{0,0}}, color={191,0,0}));
  connect(Gc1_Expression.y, convection1.Gc)
    annotation (Line(points={{-51,30},{-42,30}}, color={0,0,127}));
  connect(Gc2_Expression.y, convection2.Gc)
    annotation (Line(points={{47,-30},{40,-30}}, color={0,0,127}));
end DynamicHX;
