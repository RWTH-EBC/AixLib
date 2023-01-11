within AixLib.Fluid.BoilerCHP;
model BoilerHeatingHotWater
   extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    redeclare package Medium = Media.Water,
        a=coeffPresLoss, vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(1.1615*QNom/1000)/1000));



  MixingVolumes.MixingVolume vol1(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    V=(1.1615*QNom/1000)/1000,
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=m_flow_small,
    final allowFlowReversal=allowFlowReversal,
    final nPorts=2,
    final p_start=p_start,
    final T_start=T_start)
    "Fluid volume"
    annotation (Placement(transformation(extent={{-52,2},{-30,-20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(final G=
        QNom*0.003/50)
                 "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-6,-36})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{6,-30},{18,-42}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 283.15)
    annotation (Placement(transformation(extent={{46,-42},{34,-30}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=C,
      T(start=T_start))            "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={12,-58})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,30},{90,50}})));
  Sensors.TemperatureTwoPort senTCold1(
    redeclare final package Medium = Medium,
    final tau=tau,
    final m_flow_nominal=m_flow_nominal,
    final initType=initType,
    final T_start=T_start,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=m_flow_small)
    "Temperature sensor of cold side of heat generator (return)"
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));
  Sensors.TemperatureTwoPort senTHot1(
    redeclare final package Medium = Medium,
    final tau=tau,
    final m_flow_nominal=m_flow_nominal,
    final initType=initType,
    final T_start=T_start,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=m_flow_small)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{26,30},{46,50}})));
  Sensors.MassFlowRate senMasFlo1(redeclare final package Medium = Medium,
      final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{62,30},{82,50}})));
equation
  connect(heater.port, vol1.heatPort) annotation (Line(points={{-60,-60},{-48,
          -60},{-48,-46},{-42,-46},{-42,-30},{-56,-30},{-56,-9},{-52,-9}},
        color={191,0,0}));
  connect(heater.port, ConductanceToEnv.port_a) annotation (Line(points={{-60,
          -60},{-48,-60},{-48,-46},{-24,-46},{-24,-36},{-12,-36}}, color={191,0,
          0}));
  connect(heater.port, internalCapacity.port) annotation (Line(points={{-60,-60},
          {-48,-60},{-48,-46},{-24,-46},{-24,-58},{2,-58}}, color={191,0,0}));
  connect(ConductanceToEnv.port_b, heatFlowSensor.port_a)
    annotation (Line(points={{-1.33227e-15,-36},{6,-36}}, color={191,0,0}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{18,-36},{34,-36}}, color={191,0,0}));
  connect(port_a1, senTCold1.port_a)
    annotation (Line(points={{-100,40},{-82,40}}, color={0,127,255}));
  connect(senMasFlo1.port_b, port_b1)
    annotation (Line(points={{82,40},{100,40}}, color={0,127,255}));
  connect(senTHot1.port_b, senMasFlo1.port_a)
    annotation (Line(points={{46,40},{62,40}}, color={0,127,255}));
  connect(senTHot1.port_a, vol1.ports[1]) annotation (Line(points={{26,40},{20,
          40},{20,18},{-43.2,18},{-43.2,2}}, color={0,127,255}));
  connect(senTCold1.port_b, vol1.ports[2]) annotation (Line(points={{-62,40},{
          -38,40},{-38,2},{-38.8,2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerHeatingHotWater;
