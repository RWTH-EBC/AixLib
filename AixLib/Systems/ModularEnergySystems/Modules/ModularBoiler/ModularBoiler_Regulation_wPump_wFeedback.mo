within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler_Regulation_wPump_wFeedback
  "Modular Boiler Model - With pump and feedback - with PLR regulation"
  extends BaseClasses.Boiler_base;

  parameter Boolean hasFeedback=false "circuit has Feedback"
    annotation (Dialog(group = "Feedback"), choices(checkBox = true));
  parameter Modelica.SIunits.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal[2] = {0, 0} "Nominal additional pressure drop e.g. for distributor"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Boolean use_advancedControl=true "Selection between two position control and flow temperature control, if true=flow temperature control is active";
  parameter Boolean severalHeatCircuits=true "Selection between using several circuit and only one heat circuits";

  Control.Regulation_wPump_wFeedBack regulation_wPump_wFeedBack(
    final dTWaterNom=dTWaterNom,
    final QNom=QNom,
    final use_advancedControl=use_advancedControl,
    final severalHeatCircuits=severalHeatCircuits,
    final PLRMin=PLRMin,
    final TColdNom=TColdNom)
    annotation (Placement(transformation(extent={{-28,48},{26,80}})));

  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare final package Medium = Medium,
    final m_flow_nominal= m_flow_nominal,
    final dpValve_nominal=dp_Valve,
    final dpFixed_nominal=dpFixed_nominal) if hasFeedback
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));

  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

equation
  connect(regulation_wPump_wFeedBack.TCold, senTCold.T)
    annotation (Line(points={{-28,58.6667},{-60,58.6667},{-60,11}},
                                                 color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, regulation_wPump_wFeedBack.THot_Boiler)
    annotation (Line(points={{0,-11},{0,-20},{-50,-20},{-50,53.3333},{-28,
          53.3333}},
        color={0,0,127}));
  connect(senTHot.T, regulation_wPump_wFeedBack.THot)
    annotation (Line(points={{
          60,11},{60,20},{-42,20},{-42,48},{-28,48}}, color={0,0,127}));
  connect(regulation_wPump_wFeedBack.y, fan.y)
    annotation (Line(points={{-4.85714,
          48},{-12,48},{-12,38},{-36,38},{-36,12}},
                                                color={0,0,127}));
  connect(regulation_wPump_wFeedBack.PLR, heatGeneratorNoControl.PLR)
    annotation (Line(points={{2.85714,48},{2.85714,34},{-20,34},{-20,5.4},{-12,5.4}},
        color={0,0,127}));
  connect(regulation_wPump_wFeedBack.dTWater, heatGeneratorNoControl.dTWater)
    annotation (Line(points={{10.5714,48},{10.5714,28},{-16,28},{-16,9},{-12,9}},
                                                                        color={0,
          0,127}));
  connect(boilerControlBus.DeltaTWater, regulation_wPump_wFeedBack.dTwater_in)
    annotation (Line(
      points={{0.05,100.05},{-60,100.05},{-60,74.6667},{-28,74.6667}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLR, regulation_wPump_wFeedBack.PLR_in)
    annotation (
      Line(
      points={{0.05,100.05},{-60,100.05},{-60,80},{-28,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  if hasFeedback then
    connect(port_a, val.port_1)
      annotation (Line(points={{-100,0},{-94,0}}, color={0,127,255}));
    connect(val.port_2, senTCold.port_a)
      annotation (Line(points={{-74,0},{-70,0}}, color={0,127,255}));
    connect(port_b, val.port_3)
      annotation (Line(points={{100,0},{100,-40},{-84,
            -40},{-84,-10}},
                      color={0,127,255}));
  else
     connect(port_a, senTCold.port_a);
  end if;

  connect(regulation_wPump_wFeedBack.y_valve, val.y)
    annotation (Line(points={{-12.5714,48},{-18,48},{-18,42},{-84,42},{-84,12}},
                                                    color={0,0,127}));
  connect(boilerControlBus.PLR, regulation_wPump_wFeedBack.PLR_mea)
    annotation (
     Line(
      points={{0.05,100.05},{-60,100.05},{-60,69.3333},{-28,69.3333}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularBoiler_Regulation_wPump_wFeedback;
