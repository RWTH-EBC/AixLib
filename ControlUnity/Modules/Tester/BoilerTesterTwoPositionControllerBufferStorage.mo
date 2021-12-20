within ControlUnity.Modules.Tester;
model BoilerTesterTwoPositionControllerBufferStorage
  "Test model for the controller model of the boiler"
  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

       parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
          parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
            parameter Modelica.SIunits.HeatFlowRate QNom=100000 "Thermal dimension power";
            parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
             parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";

             //
              parameter Modelica.SIunits.Time t=60*80 "Time until the buffer storage is fully loaded";
     parameter Modelica.SIunits.Density rhoW=997 "Density of water";
     parameter Modelica.SIunits.HeatCapacity cW=4180 "Heat Capacity of water";
     parameter Modelica.SIunits.TemperatureDifference dT=20;
     //parameter Real l=1.73 "Relation between height and diameter of the buffer storage";

     parameter Modelica.SIunits.Height h=QNom*t/( Modelica.Constants.pi/4*d^2*rhoW*cW*dT);
     parameter Modelica.SIunits.Diameter d=h/1.73;
     parameter Modelica.SIunits.Volume V=Modelica.Constants.pi/4*d^2*h;






  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    T_start=293.15,
    m_flow_nominal=1,
    redeclare package Medium = AixLib.Media.Water,
    V=3,
    nPorts=3)
    annotation (Placement(transformation(extent={{52,22},{72,42}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={16,48})));


  Modelica.Blocks.Sources.Sine sine(
    amplitude=-30000,
    freqHz=1/3600,
    offset=-50000)
    annotation (Placement(transformation(extent={{-68,68},{-48,88}})));
  AixLib.Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{-74,-26},{-54,-6}})));
  Modelica.Blocks.Sources.RealExpression PLR(y=1)
    annotation (Placement(transformation(extent={{-104,26},{-92,46}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{58,-6},{78,14}})));

  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                       boilerControlBus
    annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
  ModularBoiler_TwoPositionControllerBufferStorage modularBoiler_Controller(
    TColdNom=333.15,
    QNom=100000,
    n=1,
    Tref=333.15)
         annotation (Placement(transformation(extent={{-32,12},{-12,32}})));
  Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
    annotation (Placement(transformation(extent={{-104,2},{-84,22}})));
  twoPositionController.Storage_modularBoiler storage_modularBoiler(
    x=5,
    n=10,
    d=d,
    h=h,
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
    annotation (Placement(transformation(extent={{-2,-30},{18,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{-26,-56},
            {-14,-44}})));
  AixLib.Fluid.Sources.Boundary_pT
                      boundary_ph5(redeclare package Medium = Medium, nPorts=1)
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={114,30})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{100,-22},{86,-12}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/
            0.7,dp_nominal,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{78,-58},{58,-38}})));
equation
  connect(heater.port,vol. heatPort) annotation (Line(points={{16,38},{16,32},{52,
          32}},                       color={191,0,0}));
  connect(sine.y,heater. Q_flow)
    annotation (Line(points={{-47,78},{16,78},{16,58}},
                                                      color={0,0,127}));
  connect(vol.heatPort,temperatureSensor. port)
    annotation (Line(points={{52,32},{52,4},{58,4}},     color={191,0,0}));
  connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
    annotation (Line(
      points={{-72,36},{-50,36},{-50,31.8},{-26,31.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-91.4,36},{-82,
          36},{-82,36.05},{-71.95,36.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bou.ports[1], modularBoiler_Controller.port_a) annotation (Line(
        points={{-54,-16},{-20,-16},{-20,-2},{-32,-2},{-32,22}},
                                                            color={0,127,255}));
  connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-83,12},{-71.95,
          12},{-71.95,36.05}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler_Controller.port_b, storage_modularBoiler.port_a_heatGenerator)
    annotation (Line(points={{-12,22},{10,22},{10,6},{28,6},{28,-11.2},{16.4,
          -11.2}},
        color={0,127,255}));
  connect(storage_modularBoiler.port_b_heatGenerator, modularBoiler_Controller.port_a)
    annotation (Line(points={{16.4,-28},{20,-28},{20,-30},{-40,-30},{-40,22},{
          -32,22}},
                color={0,127,255}));
  connect(fixedTemperature.port, storage_modularBoiler.heatPort) annotation (
      Line(points={{-14,-50},{-6,-50},{-6,-20},{0,-20}}, color={191,0,0}));
  connect(vol.ports[1], storage_modularBoiler.port_b_consumer) annotation (Line(
        points={{59.3333,22},{59.3333,16},{12,16},{12,-4},{8,-4},{8,-10}},color=
         {0,127,255}));
  connect(boundary_ph5.ports[1], vol.ports[2]) annotation (Line(points={{104,30},
          {84,30},{84,22},{62,22}}, color={0,127,255}));
  connect(fan1.port_b, storage_modularBoiler.port_a_consumer)
    annotation (Line(points={{58,-48},{8,-48},{8,-30}}, color={0,127,255}));
  connect(vol.ports[3], fan1.port_a) annotation (Line(points={{64.6667,22},{78,
          22},{78,16},{106,16},{106,-48},{78,-48}}, color={0,127,255}));
  connect(realExpression.y, fan1.y)
    annotation (Line(points={{85.3,-17},{68,-17},{68,-36}}, color={0,0,127}));
  connect(storage_modularBoiler.TTop, modularBoiler_Controller.TLayers[1])
    annotation (Line(points={{19,-12.4},{34,-12.4},{34,30},{-12,30},{-12,40},{
          -19.9,40},{-19.9,31.1}},
                             color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerTesterTwoPositionControllerBufferStorage;
