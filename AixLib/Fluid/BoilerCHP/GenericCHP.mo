within AixLib.Fluid.BoilerCHP;
model GenericCHP

   extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    redeclare package Medium = Media.Water,
              vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(
          0.8265*NomPower/1000 + 7.8516)/1000),  a=0,
          final dp_nominal= m_flow_nominal^2*a/(Medium.d_const^2));



  parameter Modelica.Units.SI.Power NomPower=100000;
  parameter Boolean ElDriven=true;
  constant Real Brennwert=46753;


  BaseClasses.DesignOnOffCHP designOnOffCHP
    annotation (Placement(transformation(extent={{-4,62},{16,82}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(final G=
        NomPower/(2.7088*log(NomPower) + 23.074)/100*0.0568/(85 - 20))
                 "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-30,-24})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=
        500*(20.207*NomPower/1000 + 634.19), T(start=T_start))
                                                        "Engine dry weight"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={8,-46})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-6,-18},{6,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{40,-30},{28,-18}})));
  Modelica.Blocks.Interfaces.RealOutput Pel "Electrical power"
    annotation (Placement(transformation(extent={{100,84},{120,104}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemand "Power Demand"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealInput PLR
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=ElDriven)
    annotation (Placement(transformation(extent={{-208,18},{-140,40}})));
  Modelica.Blocks.Sources.RealExpression nomPower(y=NomPower) "Nominal Power"
    annotation (Placement(transformation(extent={{-156,48},{-116,70}})));
  SDF.NDTable electricNomPower(
    nin=1,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/PowerEL_heat.sdf"),
    dataset="/Power_el",
    dataUnit="W",
    scaleUnits={"W"},
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
                          "Electric nominal power"
    annotation (Placement(transformation(extent={{-94,10},{-74,30}})));

  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=0,
        origin={-33,45})));
  BaseClasses.Controllers.CHPNomBehaviour cHPNomBehaviour
    annotation (Placement(transformation(extent={{-4,86},{16,106}})));
  Modelica.Blocks.Interfaces.RealOutput maxThermalPower "maximal thermal Power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={68,118})));
  Modelica.Blocks.Interfaces.RealOutput minThermalPower "minimal thermal Power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={36,118})));
  Modelica.Blocks.Interfaces.RealOutput THotEngine "THot Engine" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Controls.Interfaces.CHPControlBus        cHPControlBus
    annotation (Placement(transformation(extent={{-78,88},{-58,112}}),
        iconTransformation(extent={{90,32},{110,56}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{14,-2},{-6,18}})));
equation

THotEngine=vol.T;

  connect(designOnOffCHP.Q_flow, heater.Q_flow) annotation (Line(points={{17,71.4},
          {20,71.4},{20,70},{36,70},{36,-12},{-60,-12},{-60,-40}},
                                                     color={0,0,127}));
  connect(vol.heatPort,internalCapacity. port)
    annotation (Line(points={{-50,-70},{-54,-70},{-54,-46},{-2,-46}},
                                                             color={191,0,0}));
  connect(vol.heatPort,ConductanceToEnv. port_a)
    annotation (Line(points={{-50,-70},{-54,-70},{-54,-24},{-36,-24}},
                                                             color={191,0,0}));
  connect(ConductanceToEnv.port_b,heatFlowSensor. port_a)
    annotation (Line(points={{-24,-24},{-6,-24}},  color={191,0,0}));
  connect(heatFlowSensor.port_b,fixedTemperature. port)
    annotation (Line(points={{6,-24},{28,-24}},  color={191,0,0}));
  connect(designOnOffCHP.powerDemand, powerDemand) annotation (Line(points={{17,67.4},
          {94,67.4},{94,40},{110,40}},       color={0,0,127}));
  connect(designOnOffCHP.Pel, Pel) annotation (Line(points={{17,79.4},{94,79.4},
          {94,94},{110,94}},                 color={0,0,127}));
  connect(PLR, designOnOffCHP.PLR) annotation (Line(points={{-120,80},{-63,80},{
          -63,80.4},{-6,80.4}},  color={0,0,127}));
  connect(nomPower.y,electricNomPower. u[1]) annotation (Line(points={{-114,59},
          {-114,20},{-96,20}},                              color={0,0,127}));
  connect(nomPower.y,switch2. u1) annotation (Line(points={{-114,59},{-114,53.8},
          {-46.2,53.8}},             color={0,0,127}));
  connect(booleanExpression.y,switch2. u2) annotation (Line(points={{-136.6,29},
          {-136.6,44},{-54,44},{-54,45},{-46.2,45}},
                                      color={255,0,255}));
  connect(electricNomPower.y,switch2. u3) annotation (Line(points={{-73,20},{-54,
          20},{-54,36.2},{-46.2,36.2}},                       color={0,0,127}));
  connect(switch2.y, designOnOffCHP.Power)
    annotation (Line(points={{-20.9,45},{-16,45},{-16,70},{-6,70}},
                                                             color={0,0,127}));
  connect(switch2.y, cHPNomBehaviour.Power) annotation (Line(points={{-20.9,45},
          {-16,45},{-16,96},{-6,96}}, color={0,0,127}));
  connect(cHPNomBehaviour.MinThermalPower,minThermalPower)  annotation (Line(
        points={{17,97.6},{36,97.6},{36,118}},                           color={
          0,0,127}));
  connect(cHPNomBehaviour.MaxThermalPower,maxThermalPower)  annotation (Line(
        points={{17,89},{68,89},{68,118}},                           color={0,0,
          127}));
  connect(cHPControlBus.OnOff, designOnOffCHP.u) annotation (Line(
      points={{-68,100},{-68,64},{-6,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(designOnOffCHP.Q_flow, cHPControlBus.PowerHeat) annotation (Line(
        points={{17,71.4},{68,71.4},{68,24},{-68,24},{-68,100}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(designOnOffCHP.Q_flow, integrator2.u)
    annotation (Line(points={{17,71.4},{17,8},{16,8}}, color={0,0,127}));
  connect(integrator2.y, cHPControlBus.EnergyHeat) annotation (Line(points={{-7,
          8},{-68,8},{-68,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GenericCHP;
