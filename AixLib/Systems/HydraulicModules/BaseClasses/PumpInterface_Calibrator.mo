within AixLib.Systems.HydraulicModules.BaseClasses;
model PumpInterface_Calibrator
  extends BasicPumpInterface;
  Zugabe.Fluid.Movers.PumpN pumpN( redeclare package Medium = Medium)
    annotation (Dialog(enable=true),Placement(transformation(extent={{-10,-6},{10,14}})));
equation
  connect(port_a, pumpN.port_a) annotation (Line(points={{-100,0},{-54,0},{-54,4},
          {-10,4}}, color={0,127,255}));
  connect(pumpN.port_b, port_b) annotation (Line(points={{10,4},{54,4},{54,0},{100,
          0}}, color={0,127,255}));
  connect(pumpN.pumpBus, pumpBus) annotation (Line(
      points={{0,14},{0,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
end PumpInterface_Calibrator;
