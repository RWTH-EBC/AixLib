within ControlUnity.Modules.Tester;
model BoilerTesterTwoPositionControllerStorageBuffer
  "Test model for the controller model of the boiler"
  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

       parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
          parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
            parameter Modelica.SIunits.HeatFlowRate QNom=100000 "Thermal dimension power";
            parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
             parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";
             parameter Modelica.SIunits.Time t=60*80 "Time until the buffer storage is fully loaded";
     parameter Modelica.SIunits.Density rhoW=997 "Density of water";
     parameter Modelica.SIunits.HeatCapacity cW=4180 "Heat Capacity of water";
     parameter Modelica.SIunits.TemperatureDifference dT=20;
     parameter Real l=1.73 "Relation between height and diameter of the buffer storage";
     parameter Modelica.SIunits.Height hTank=QNom*t/( Modelica.Constants.pi/4*dTank^2*rhoW*cW*dT);
     parameter Modelica.SIunits.Diameter dTank=hTank/1.73;


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
    offset=-30000)
    annotation (Placement(transformation(extent={{-68,68},{-48,88}})));
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



  AixLib.Fluid.Storage.BufferStorage bufferStorage(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    mHC1_flow_nominal=boundary3.m_flow,
    n=10,
    redeclare package Medium = Medium,
    data=data,
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    upToDownHC1=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart=303.15) annotation (Placement(transformation(extent={{26,-30},{6,-6}})));
  parameter AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=
      AixLib.DataBase.Storage.Generic_New_2000l() "Data record for Storage";
equation

  ///Determination of storage volume


//bufferStorage.data.dTank
//bufferStorage.data.hTank



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
  connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-83,12},{-71.95,
          12},{-71.95,36.05}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boundary_ph5.ports[1], vol.ports[1]) annotation (Line(points={{104,30},
          {84,30},{84,22},{59.3333,22}},
                                    color={0,127,255}));
  connect(vol.ports[2], fan1.port_a) annotation (Line(points={{62,22},{78,22},{78,
          16},{106,16},{106,-48},{78,-48}},         color={0,127,255}));
  connect(realExpression.y, fan1.y)
    annotation (Line(points={{85.3,-17},{68,-17},{68,-36}}, color={0,0,127}));
  connect(modularBoiler_Controller.port_b, bufferStorage.fluidportTop1)
    annotation (Line(points={{-12,22},{19.5,22},{19.5,-5.88}}, color={0,127,255}));
  connect(bufferStorage.fluidportTop2, vol.ports[3]) annotation (Line(points={{12.875,
          -5.88},{12.875,22},{64.6667,22}}, color={0,127,255}));
  connect(fan1.port_b, bufferStorage.fluidportBottom2) annotation (Line(points={
          {58,-48},{13.125,-48},{13.125,-30.12}}, color={0,127,255}));
  connect(bufferStorage.fluidportBottom1, modularBoiler_Controller.port_a)
    annotation (Line(points={{19.375,-30.24},{19.375,-36},{-46,-36},{-46,22},{-32,
          22}}, color={0,127,255}));
  connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (
      Line(points={{-14,-50},{-2,-50},{-2,-17.28},{6.25,-17.28}}, color={191,0,0}));
  connect(bufferStorage.TTop, modularBoiler_Controller.TLayers[1]) annotation (
      Line(points={{26,-7.44},{32,-7.44},{32,-6},{36,-6},{36,28},{-6,28},{-6,44},
          {-10,44},{-10,42},{-19.9,42},{-19.9,31.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerTesterTwoPositionControllerStorageBuffer;
