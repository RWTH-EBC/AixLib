within ControlUnity.Modules.Tester;
model BoilerTesterTwoPositionControllerBufferStorage2HeatCurcuits
  "Test model for the controller model of the boiler"
  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

       parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
          parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
            parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power";
            parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
             parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";

  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    T_start=293.15,
    m_flow_nominal=1,
    redeclare package Medium = AixLib.Media.Water,
    V=3,
    nPorts=3)
    annotation (Placement(transformation(extent={{48,48},{68,68}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={12,74})));

  Modelica.Blocks.Sources.Sine sine(
    amplitude=-30000,
    freqHz=1/3600,
    offset=-30000)
    annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
  AixLib.Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{-78,0},{-58,20}})));
  Modelica.Blocks.Sources.RealExpression PLR(y=1)
    annotation (Placement(transformation(extent={{-108,52},{-96,72}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{54,20},{74,40}})));

  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                       boilerControlBus
    annotation (Placement(transformation(extent={{-86,52},{-66,72}})));
  ModularBoiler_TwoPositionControllerBufferStorage modularBoiler_Controller(
    TColdNom=333.15,
    QNom=100000,
    n=1) annotation (Placement(transformation(extent={{-36,38},{-16,58}})));
  Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
    annotation (Placement(transformation(extent={{-108,28},{-88,48}})));
  twoPositionController.Storage_modularBoiler storage_modularBoiler(
    x=5,
    n=10,
    d=1.5,
    h=3,
    lambda_ins=0.02,
    s_ins=0.1,
    hConIn=1500,
    hConOut=15,
    V_HE=0.1,
    k_HE=1500,
    A_HE=20,
    beta=0.00035,
    kappa=0.4,
    m_flow_nominal_layer=1,
    m_flow_nominal_HE=1)
    annotation (Placement(transformation(extent={{-6,-2},{14,18}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{-30,-22},
            {-18,-10}})));
  AixLib.Fluid.Sources.Boundary_pT
                      boundary_ph5(redeclare package Medium = Medium, nPorts=1)
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={110,56})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{96,4},{82,14}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/
            0.7,dp_nominal,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{74,-20},{54,0}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    V=3,
    nPorts=2)
    annotation (Placement(transformation(extent={{48,-74},{62,-58}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater1
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={35,-55})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=-10000,
    freqHz=1/3600,
    offset=-30000)
    annotation (Placement(transformation(extent={{16,-46},{30,-32}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{54,-96},{68,-82}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan2(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/
            0.7,dp_nominal,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{26,-96},{10,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
    annotation (Placement(transformation(extent={{32,-72},{20,-64}})));
equation
  connect(heater.port,vol. heatPort) annotation (Line(points={{12,64},{12,58},{
          48,58}},                    color={191,0,0}));
  connect(sine.y,heater. Q_flow)
    annotation (Line(points={{-9,90},{12,90},{12,84}},color={0,0,127}));
  connect(vol.heatPort,temperatureSensor. port)
    annotation (Line(points={{48,58},{48,30},{54,30}},   color={191,0,0}));
  connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
    annotation (Line(
      points={{-76,62},{-54,62},{-54,57.8},{-30,57.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-95.4,62},{-86,
          62},{-86,62.05},{-75.95,62.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bou.ports[1], modularBoiler_Controller.port_a) annotation (Line(
        points={{-58,10},{-24,10},{-24,24},{-36,24},{-36,48}},
                                                            color={0,127,255}));
  connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-87,38},{
          -75.95,38},{-75.95,62.05}},
                               color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler_Controller.port_b, storage_modularBoiler.port_a_heatGenerator)
    annotation (Line(points={{-16,48},{6,48},{6,32},{24,32},{24,16.8},{12.4,
          16.8}},
        color={0,127,255}));
  connect(storage_modularBoiler.port_b_heatGenerator, modularBoiler_Controller.port_a)
    annotation (Line(points={{12.4,0},{16,0},{16,-4},{-44,-4},{-44,48},{-36,48}},
                color={0,127,255}));
  connect(fixedTemperature.port, storage_modularBoiler.heatPort) annotation (
      Line(points={{-18,-16},{-10,-16},{-10,8},{-4,8}},  color={191,0,0}));
  connect(vol.ports[1], storage_modularBoiler.port_b_consumer) annotation (Line(
        points={{55.3333,48},{55.3333,42},{8,42},{8,22},{4,22},{4,18}},   color=
         {0,127,255}));
  connect(boundary_ph5.ports[1], vol.ports[2]) annotation (Line(points={{100,56},
          {80,56},{80,48},{58,48}}, color={0,127,255}));
  connect(fan1.port_b, storage_modularBoiler.port_a_consumer)
    annotation (Line(points={{54,-10},{4,-10},{4,-2}},  color={0,127,255}));
  connect(vol.ports[3], fan1.port_a) annotation (Line(points={{60.6667,48},{74,
          48},{74,42},{102,42},{102,-10},{74,-10}}, color={0,127,255}));
  connect(realExpression.y, fan1.y)
    annotation (Line(points={{81.3,9},{64,9},{64,2}},       color={0,0,127}));
  connect(storage_modularBoiler.TTop, modularBoiler_Controller.TLayers[1])
    annotation (Line(points={{15,15.6},{30,15.6},{30,56},{-16,56},{-16,66},{
          -23.9,66},{-23.9,57.1}}, color={0,0,127}));
  connect(heater1.port, vol1.heatPort)
    annotation (Line(points={{35,-62},{35,-66},{48,-66}}, color={191,0,0}));
  connect(sine1.y, heater1.Q_flow)
    annotation (Line(points={{30.7,-39},{35,-39},{35,-48}}, color={0,0,127}));
  connect(vol1.heatPort, temperatureSensor1.port)
    annotation (Line(points={{48,-66},{48,-89},{54,-89}}, color={191,0,0}));
  connect(vol1.ports[1], fan2.port_a) annotation (Line(points={{53.6,-74},{54,
          -74},{54,-84},{32,-84},{32,-88},{26,-88}}, color={0,127,255}));
  connect(fan2.port_b, storage_modularBoiler.port_a_consumer) annotation (Line(
        points={{10,-88},{6,-88},{6,-2},{4,-2}}, color={0,127,255}));
  connect(realExpression1.y, fan2.y) annotation (Line(points={{19.4,-68},{18,
          -68},{18,-78.4}}, color={0,0,127}));
  connect(storage_modularBoiler.port_b, vol1.ports[2]) annotation (Line(points=
          {{14.6,7.8},{46,7.8},{46,-50},{66,-50},{66,-74},{56.4,-74}}, color={0,
          127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerTesterTwoPositionControllerBufferStorage2HeatCurcuits;
