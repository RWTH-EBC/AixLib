within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer;
model ModularConsumer
    extends AixLib.Fluid.Interfaces.PartialTwoPort(redeclare package Medium =
        Media.Water);
  parameter Integer n_consumers=1 "Number of consumers";
  parameter Modelica.SIunits.Temperature T_flow[n_consumers]  "Flow consumer temperatures";
  parameter Modelica.SIunits.Temperature T_return[n_consumers]  "Return consumer temperatures";
  parameter Integer demandType[n_consumers] "Choose between heating and cooling functionality" annotation(Dialog(enable=true, group = "System"));
  parameter Boolean hasPump[n_consumers] "circuit has Pump";
  parameter String functionality[n_consumers] "Choose between different functionalities";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal[n_consumers] "Nominal mass flow rate";
  parameter Modelica.SIunits.HeatFlowRate Q_flow_fixed[n_consumers] = fill(0, n_consumers) "Prescribed heat flow";


  AixLib.Systems.ModularEnergySystems.Modules.Distributor.Distributor
    distributor(
    redeclare package Medium = Medium,
    final m_flow_nominal = sum(m_flow_nominal),
    n=n_consumers) annotation (
      Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={0,-28})));
  HydraulicModules.SimpleConsumer simpleConsumer[n_consumers](
    redeclare each package Medium = Medium,
    T_flow = T_flow,
    T_return = T_return,
    functionality = functionality,
    demandType = demandType,
    hasPump = hasPump,
    m_flow_nominal = m_flow_nominal,
    Q_flow_fixed = Q_flow_fixed)
    annotation (Placement(transformation(extent={{-12,30},{8,50}})));
equation
  for i in 1:n_consumers loop
    connect(distributor.flowPorts[i], simpleConsumer[i].port_a)
      annotation (Line(points={{-24,-28},{-46,-28},{-46,40},{-12,40}}, color={0,
            127,255}));
    connect(distributor.returnPorts[i], simpleConsumer[i].port_b)
      annotation (Line(points={{24.8,-28},{40,-28},{40,40},{8,40}},  color={0,
            127,255}));
  end for;
  connect(port_a, distributor.mainFlow) annotation (Line(points={{-100,0},{-60,0},
          {-60,-68},{-12.8,-68},{-12.8,-52}}, color={0,127,255}));
  connect(distributor.mainReturn, port_b) annotation (Line(points={{12,-52},{12,
          -70},{80,-70},{80,0},{100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularConsumer;
