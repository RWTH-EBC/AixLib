within AixLib.Systems.HydraulicModules;
model SimpleConsumer_wPump
  extends AixLib.Systems.HydraulicModules.BaseClasses.SimpleConsumer_base(
   volume(nPorts=2));
  parameter Boolean hasPump=false   "circuit has Pump" annotation (Dialog(group = "Pump"), choices(checkBox = true));
  parameter Boolean show_T=false "= true, if actual temperature at port is computed"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Modelica.SIunits.PressureDifference dp_nominalPumpConsumer=if rho_default < 500
       then 500 else 10000
    "Nominal pressure raise, used for default pressure curve if not specified in record per"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Real k_ControlConsumerPump(min=Modelica.Constants.small)=1 "Gain of controller"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Modelica.SIunits.Time Ti_ControlConsumerPump(min=Modelica.Constants.small)=1 "Time constant of Integrator block"
    annotation (Dialog(enable = hasPump, group = "Pump"));

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";

  Fluid.Movers.SpeedControlled_y     pump(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    T_start=T_start,
    allowFlowReversal=allowFlowReversal,
    show_T=show_T,
    redeclare Fluid.Movers.Data.Generic per(pressure(V_flow={0,m_flow_nominal/1000,
            m_flow_nominal/500}, dp={dp_nominalPumpConsumer/0.8,
            dp_nominalPumpConsumer,0}), motorCooledByFluid=false),
    addPowerToMedium=false,
    y_start=0.5) if hasPump
    annotation (Placement(transformation(extent={{-32,10},{-12,-10}})));
  Modelica.Blocks.Math.Gain gain(k=demandType)
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{72,-28},{64,-20}})));
  Modelica.Blocks.Continuous.LimPID PIPump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerPump,
    Ti=Ti_ControlConsumerPump,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5) if hasPump
        annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-32,-28})));
  Modelica.Blocks.Sources.RealExpression TSet_Return(y=demandType*TReturn)
    annotation (Placement(transformation(extent={{-64,-38},{-44,-18}})));
equation

  if hasPump then
    connect(senMasFlo.port_b, pump.port_a)
      annotation (Line(points={{-44,0},{-32,0}}, color={0,127,255}));
    connect(pump.port_b, volume.ports[2])
      annotation (Line(points={{-12,0},{-1.77636e-15,0}}, color={0,127,255}));
    connect(PIPump.y, pump.y) annotation (Line(points={{-25.4,-28},{-22,-28},{-22,
            -12}},                                                             color={0,0,127}));
    connect(PIPump.u_m, gain.y) annotation (Line(points={{-32,-35.2},{-32,-40},{
            60,-40},{60,-24},{63.6,-24}},
                            color={0,0,127}));
  else
    connect(senMasFlo.port_b, volume.ports[2]);
  end if;

  connect(TSet_Return.y, PIPump.u_s) annotation (Line(points={{-43,-28},{-39.2,-28}},
                        color={0,0,127}));
  connect(gain.u, senTReturn.T) annotation (Line(points={{72.8,-24},{80,-24},{
            80,-11}},                                                                     color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer_wPump;
