within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer;
model ModularConsumer
    extends AixLib.Fluid.Interfaces.PartialTwoPort(redeclare package Medium =
        Media.Water);
  parameter Integer n_consumers=1 "Number of consumers";
  parameter Modelica.SIunits.Temperature TControl[n_consumers]  "Flow consumer temperatures";
  parameter Modelica.SIunits.HeatFlowRate Qflow_nom[n_consumers] "Thermal dimension power";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal[n_consumers] "Nominal mass flow rate";

  AixLib.Systems.ModularEnergySystems.Modules.Distributor.Distributor
    distributor(
    redeclare package Medium = Medium,
    final m_flow_nominal = sum(m_flow_nominal),
    n=n_consumers) annotation (
      Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={0,-28})));
  Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = Medium,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,34})));
equation
  for i in 1:n_consumers loop
    connect(distributor.flowPorts[i], simpleConsumer_wPump_wFeedback[i].port_a)
      annotation (Line(points={{-24,-28},{-46,-28},{-46,40},{-18,40}}, color={0,
            127,255}));
    connect(distributor.returnPorts[i], simpleConsumer_wPump_wFeedback[i].port_b)
      annotation (Line(points={{24.8,-28},{40,-28},{40,40},{16,40}}, color={0,
            127,255}));
  end for;
  connect(port_a, distributor.mainFlow) annotation (Line(points={{-100,0},{-60,0},
          {-60,-68},{-12.8,-68},{-12.8,-52}}, color={0,127,255}));
  connect(distributor.mainReturn, port_b) annotation (Line(points={{12,-52},{12,
          -70},{80,-70},{80,0},{100,0}}, color={0,127,255}));
  connect(bou.ports[1], port_a)
    annotation (Line(points={{-100,24},{-100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularConsumer;
