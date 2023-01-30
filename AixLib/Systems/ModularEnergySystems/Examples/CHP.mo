within AixLib.Systems.ModularEnergySystems.Examples;
model CHP
  extends AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
    vol(m_flow_nominal=1, nPorts=2),
    bou(nPorts=1),
    TSpeicher(y=60 + 273.15),
    sine(offset=0));
  Modules.ModularCHP.ModularCHP modularCHP(PelNom(displayUnit="kW") = 100000)
    annotation (Placement(transformation(extent={{-26,-12},{-6,8}})));
  AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
    annotation (Placement(transformation(extent={{-94,-4},{-54,36}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=true,
    length=5,
    isCircular=true,
    diameter=0.03,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=0, m_flow_nominal=0.4785))
    annotation (Placement(transformation(extent={{44,-44},{22,-24}})));

equation
  connect(modularCHP.port_b, vol.ports[1]) annotation (Line(points={{-6,-2},{8,-2},
          {8,-4},{46,-4},{46,4}}, color={0,127,255}));
  connect(bou.ports[1], modularCHP.port_a) annotation (Line(points={{0,-40},{6,-40},
          {6,-38},{14,-38},{14,-20},{-36,-20},{-36,-2},{-26,-2}}, color={0,127,255}));
  connect(cHPControlBus, modularCHP.cHPControlBus) annotation (Line(
      points={{-74,16},{-54,16},{-54,14},{-16,14},{-16,8.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y, cHPControlBus.PLR) annotation (Line(points={{-59.1,-29},
          {-54,-29},{-54,0},{-74,0},{-74,16}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(vol.ports[2], pipe.port_a) annotation (Line(points={{46,4},{48,4},{48,
          -34},{44,-34}}, color={0,127,255}));
  connect(pipe.port_b, modularCHP.port_a) annotation (Line(points={{22,-34},{14,
          -34},{14,-32},{6,-32},{6,-24},{-26,-24},{-26,-2}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5000));
end CHP;
