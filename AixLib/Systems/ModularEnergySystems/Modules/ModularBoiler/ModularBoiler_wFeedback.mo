within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler_wFeedback
  extends AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.BaseClasses.ModularBoiler_base;
  parameter Boolean hasFeedback=false   "circuit has Feedback" annotation (Dialog(group = "Feedback"), choices(checkBox = true));

  parameter Real k_ControlBoilerValve(min=Modelica.Constants.small)=1 "Gain of controller"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.SIunits.Time Ti_ControlBoilerValve(min=Modelica.Constants.small)=1 "Time constant of Integrator block"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.SIunits.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal = 0 "Nominal additional pressure drop e.g. for distributor" annotation (Dialog(enable = hasFeedback, group="Feedback"));

  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare package Medium = Medium,
    m_flow_nominal= m_flow_nominal,
    dpValve_nominal=dp_Valve) if hasFeedback
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  Modelica.Blocks.Continuous.LimPID PIValve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlBoilerValve,
    Ti=Ti_ControlBoilerValve,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5) if hasFeedback
               annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-124,28})));
protected
  Modelica.Blocks.Sources.RealExpression TSet_Cold(y=TColdNom) if hasFeedback
    annotation (Placement(transformation(extent={{-158,18},{-138,38}})));
equation
  if hasFeedback then
    connect(port_a, val.port_1)
    annotation (Line(points={{-100,0},{-94,0}}, color={0,127,255}));
    connect(val.port_2, senTCold.port_a)
    annotation (Line(points={{-74,0},{-70,0}}, color={0,127,255}));
    connect(port_b, val.port_3) annotation (Line(points={{100,0},{100,-50},{-84,
            -50},{-84,-10}},
                      color={0,127,255}));
  else
     connect(port_a, senTCold.port_a);
  end if;

  connect(TSet_Cold.y, PIValve.u_s)
    annotation (Line(points={{-137,28},{-131.2,28}}, color={0,0,127}));
  connect(PIValve.y, val.y)
    annotation (Line(points={{-117.4,28},{-84,28},{-84,12}}, color={0,0,127}));
  connect(PIValve.u_m, senTCold.T) annotation (Line(points={{-124,20.8},{-124,16},
          {-60,16},{-60,11}}, color={0,0,127}));
end ModularBoiler_wFeedback;
