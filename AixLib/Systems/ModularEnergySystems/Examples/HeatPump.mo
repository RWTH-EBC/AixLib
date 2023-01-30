within AixLib.Systems.ModularEnergySystems.Examples;
model HeatPump
    extends AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
    vol(
      T_start=343.15,
      m_flow_nominal=1,
      V=0.4,
      nPorts=2),
    bou(use_T_in=true, nPorts=1),
    TSpeicher(y=70 + 273.15),
    sine(f=1/(12*3600), offset=-7000),
    PLR(y=0.6));
  Modules.ModularHeatPump.ModularHeatPumpNew
                                          modularHeatPumpNew(
    dTConFix=false,
    HighTemp=true,
    THotNom=353.15,
    TSourceNom=293.15,
    QNom=14000,
    PLRMin=0.5,
    T_Start_Condenser=333.15,
    TSourceInternal=true,
    redeclare package MediumEvap = AixLib.Media.Water)
    annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
  .AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus
    annotation (Placement(transformation(extent={{-96,0},{-66,34}}),
        iconTransformation(extent={{-84,8},{-66,34}})));

  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
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
  bou.T_in=vol.T;
  connect(sigBus, modularHeatPumpNew.sigBus) annotation (Line(
      points={{-81,17},{-13.9,17},{-13.9,10.3}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y, sigBus.PLR) annotation (Line(points={{-59.1,-29},{-52,
          -29},{-52,-4},{-80.925,-4},{-80.925,17.085}},
                                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularHeatPumpNew.port_b, vol.ports[1])
    annotation (Line(points={{-4,0},{46,0},{46,4}}, color={0,127,255}));
  connect(bou.ports[1], modularHeatPumpNew.port_a) annotation (Line(points={{
          0,-40},{2,-40},{2,-38},{4,-38},{4,-22},{-24,-22},{-24,0}}, color={0,
          127,255}));
  connect(vol.ports[2], pipe.port_a) annotation (Line(points={{46,4},{48,4},{
          48,-34},{44,-34}}, color={0,127,255}));
  connect(pipe.port_b, modularHeatPumpNew.port_a) annotation (Line(points={{
          22,-34},{18,-34},{18,-32},{14,-32},{14,-18},{-40,-18},{-40,0},{-24,
          0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5000));
end HeatPump;
