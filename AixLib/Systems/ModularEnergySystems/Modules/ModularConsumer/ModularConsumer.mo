within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer;
model ModularConsumer
    extends AixLib.Fluid.Interfaces.PartialTwoPort;
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component";
  parameter Integer n_consumers=1 "Number of consumers";
  parameter Modelica.SIunits.Temperature TControl[n_consumers]  "Flow consumer temperatures";
  parameter Modelica.SIunits.HeatFlowRate Qflow_nom[n_consumers] "Thermal dimension power";


  SimpleConsumer.SimpleConsumer simpleConsumer[n_consumers](
  each TControl=TControl)
    annotation (Placement(transformation(extent={{-26,24},{10,72}})));
  AixLib.Systems.ModularEnergySystems.Modules.Distributor.Distributor
    distributor(redeclare package Medium = Medium, n=n_consumers) annotation (
      Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={0,-28})));
equation
  for i in 1:n_consumers loop
    connect( distributor.flowPorts[i], simpleConsumer[i].port_a) annotation (Line(points={{-24,-28},
            {-46,-28},{-46,48},{-26,48}},                                                                   color={0,127,255}));
    connect( distributor.returnPorts[i], simpleConsumer[i].port_b) annotation (Line(points={{24.8,
            -28},{40,-28},{40,48},{10,48}},                                                                 color={0,127,255}));
  end for;
  connect(port_a, distributor.mainFlow) annotation (Line(points={{-100,0},{-60,0},
          {-60,-68},{-12.8,-68},{-12.8,-52}}, color={0,127,255}));
  connect(distributor.mainReturn, port_b) annotation (Line(points={{12,-52},{12,
          -70},{80,-70},{80,0},{100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularConsumer;
