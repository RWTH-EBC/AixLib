within AixLib.Fluid.Pools;
model IndoorSwimmingPool_Remodel
  "Indoor Swimming Pool Model remodeled to find singularity"
  parameter Modelica.SIunits.Temperature T_pool;
  parameter Modelica.SIunits.Volume V_pool;
  parameter Modelica.SIunits.Volume V_storage;


//   Real m_flow_evap;
//   Real m_flow_toPool;
     parameter Real m_flow_freshWater;
//   Real m_flow_recycledWater;

  parameter Modelica.SIunits.MassFlowRate m_flow_start;

  final parameter Modelica.SIunits.SpecificEnergy h_evap = AixLib.Media.Air.enthalpyOfCondensingGas(T_pool);

  MixingVolumes.MixingVolume vol(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC,
    T_start=T_pool,
    m_flow_nominal=m_flow_start,
    V=V_storage,
    nPorts=5)
    annotation (Placement(transformation(extent={{-26,-72},{-6,-52}})));
  BaseClasses.MixingVolumeEvapLosses vol1(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC,
    T_start=T_pool,
    m_flow_nominal=m_flow_start,
    V=V_pool,
    nPorts=3) annotation (Placement(transformation(extent={{-24,18},{-4,38}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a( redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC)
    annotation (Placement(transformation(extent={{-108,-50},{-88,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1( redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC)
    annotation (Placement(transformation(extent={{-108,-84},{-88,-64}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b( redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC)
    annotation (Placement(transformation(extent={{90,-64},{110,-44}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(  redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC)
    annotation (Placement(transformation(extent={{90,2},{110,22}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{50,-2},{70,18}})));
  Modelica.Blocks.Math.Gain gain(k=-h_evap)
    annotation (Placement(transformation(extent={{48,58},{36,70}})));
  Movers.BaseClasses.IdealSource idealSource3(
    redeclare package Medium = Media.Water,
    m_flow_small=0.00000000001,
    control_m_flow=true,
    control_dp=false)
    annotation (Placement(transformation(extent={{-64,-82},{-44,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=m_flow_freshWater)
    annotation (Placement(transformation(extent={{-72,-50},{-58,-38}})));
equation


  connect(vol.ports[1], vol1.ports[1]) annotation (Line(points={{-19.2,-72},{
          -40,-72},{-40,18},{-16.6667,18}},
                                         color={0,127,255}));
  connect(vol1.ports[2], vol.ports[2]) annotation (Line(points={{-14,18},{32,18},
          {32,-74},{-17.6,-74},{-17.6,-72}},
                                         color={0,127,255}));
  connect(port_a1, vol.ports[3]) annotation (Line(points={{-98,-74},{-96,-74},{-96,
          -90},{-16,-90},{-16,-72},{-16,-72}},   color={0,127,255}));
  connect(vol.ports[4], port_b) annotation (Line(points={{-14.4,-72},{-12,-72},{
          -12,-84},{100,-84},{100,-54}},
                                     color={0,127,255}));
  connect(vol1.ports[3], massFlowRate.port_a) annotation (Line(points={{
          -11.3333,18},{16,18},{16,8},{50,8}},
                                      color={0,127,255}));
  connect(massFlowRate.port_b, port_b1)
    annotation (Line(points={{70,8},{100,8},{100,12}}, color={0,127,255}));
  connect(gain.u, massFlowRate.m_flow) annotation (Line(points={{49.2,64},{54,64},
          {54,30},{60,30},{60,19}}, color={0,0,127}));
  connect(gain.y, vol1.QEvap_in) annotation (Line(points={{35.4,64},{4,64},{4,54},
          {-24.6,54},{-24.6,24.2}}, color={0,0,127}));
  connect(port_a, idealSource3.port_a) annotation (Line(points={{-98,-40},{-78,-40},
          {-78,-72},{-64,-72}}, color={0,127,255}));
  connect(idealSource3.port_b, vol.ports[5])
    annotation (Line(points={{-44,-72},{-12.8,-72}}, color={0,127,255}));
  connect(realExpression2.y, idealSource3.m_flow_in) annotation (Line(points={{-57.3,
          -44},{-58,-44},{-58,-64},{-60,-64}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IndoorSwimmingPool_Remodel;
