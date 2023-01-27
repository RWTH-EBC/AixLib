within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler_wPump_wFeedback
  "Modular Boiler Model - With pump and feedback - Simple PLR regulation"
  extends BaseClasses.Boiler_base;

  Control.Control_wPump_wFeedback control_wPump_wFeedback(
    final dTWaterNom=dTWaterNom,
    final QNom=QNom,
    final THotMax=TFlowMax,
    final PLRMin=PLRMin,
    final TColdNom=TRetNom)
    annotation (Placement(transformation(extent={{-28,48},{26,80}})));
  parameter Boolean hasFeedback=false "circuit has Feedback"
    annotation (Dialog(group = "Feedback"), choices(checkBox = true));
  parameter Modelica.Units.SI.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal[2] = {0, 0} "Nominal additional pressure drop e.g. for distributor"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));

  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare final package Medium = Medium,
    final m_flow_nominal= m_flow_nominal,
    final dpValve_nominal=dp_Valve,
    final dpFixed_nominal=dpFixed_nominal) if hasFeedback
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));

  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

equation
  connect(control_wPump_wFeedback.TCold, senTRet.T) annotation (Line(points={{-28,
          57.1429},{-60,57.1429},{-60,11}}, color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, control_wPump_wFeedback.THot_Boiler)
    annotation (Line(points={{0,-11},{0,-20},{-50,-20},{-50,52.5714},{-28,
          52.5714}},
        color={0,0,127}));
  connect(senTFlow.T, control_wPump_wFeedback.THot) annotation (Line(points={{
          60,11},{60,20},{-42,20},{-42,48},{-28,48}}, color={0,0,127}));
  connect(control_wPump_wFeedback.y, pump.y) annotation (Line(points={{-11.8,48},
          {-12,48},{-12,38},{-36,38},{-36,12}}, color={0,0,127}));
  connect(control_wPump_wFeedback.PLR, heatGeneratorNoControl.PLR)
    annotation (
      Line(points={{-6.4,48},{-6.4,34},{-20,34},{-20,5.4},{-12,5.4}}, color={0,0,
          127}));
  connect(control_wPump_wFeedback.dTWater, heatGeneratorNoControl.dTWater)
    annotation (Line(points={{-1,48},{-1,28},{-16,28},{-16,9},{-12,9}}, color={0,
          0,127}));
  connect(boilerControlBus.DeltaTWater, control_wPump_wFeedback.dTwater_in)
    annotation (Line(
      points={{0.05,98.05},{-60,98.05},{-60,70.8571},{-28,70.8571}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLR, control_wPump_wFeedback.PLR_in)
    annotation (
      Line(
      points={{0.05,98.05},{-60,98.05},{-60,75.4286},{-28,75.4286}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  if hasFeedback then
    connect(port_a, val.port_1)
      annotation (Line(points={{-100,0},{-94,0}}, color={0,127,255}));
    connect(val.port_2, senTRet.port_a)
      annotation (Line(points={{-74,0},{-70,0}}, color={0,127,255}));
    connect(port_b, val.port_3)
      annotation (Line(points={{100,0},{100,-40},{-84,
            -40},{-84,-10}},
                      color={0,127,255}));
  else
    connect(port_a, senTRet.port_a);
  end if;

  connect(control_wPump_wFeedback.y_valve, val.y)
    annotation (Line(points={{-17.2,
          48},{-18,48},{-18,42},{-84,42},{-84,12}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularBoiler_wPump_wFeedback;
