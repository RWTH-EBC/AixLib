within AixLib.Systems.ModularEnergySystems.Examples;
model Boiler
   extends AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
    vol(
      T_start=293.15,
      m_flow_nominal=1, nPorts=2),
    bou(nPorts=1),
    TSpeicher(y=60 + 273.15),
    sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-50000));
  Interfaces.BoilerControlBus          boilerControlBus
    annotation (Placement(transformation(extent={{-92,0},{-72,20}})));
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
  connect(boilerControlBus, modularBoilerNotManufacturer.boilerControlBus)
    annotation (Line(
      points={{-82,10},{-72,10},{-72,8},{-52,8},{-52,12},{-28.2,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLR, switch1.y) annotation (Line(
      points={{-81.95,10.05},{-81.95,-4},{-52,-4},{-52,-29},{-59.1,-29}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoilerNotManufacturer.port_b, vol.ports[1]) annotation (Line(
        points={{-18,2},{-12,2},{-12,0},{0,0},{0,4},{46,4}}, color={0,127,255}));
  connect(bou.ports[1], modularBoilerNotManufacturer.port_a) annotation (Line(
        points={{0,-40},{6,-40},{6,-38},{8,-38},{8,-20},{-36,-20},{-36,2},{-38,2}},
        color={0,127,255}));
  connect(vol.ports[2], pipe.port_a) annotation (Line(points={{46,4},{46,-16},
          {46,-34},{44,-34}}, color={0,127,255}));
  connect(pipe.port_b, modularBoilerNotManufacturer.port_a) annotation (Line(
        points={{22,-34},{16,-34},{16,-18},{-48,-18},{-48,2},{-38,2}}, color=
          {0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000));
end Boiler;
