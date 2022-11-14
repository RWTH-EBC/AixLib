within AixLib.Fluid.Storage.Examples;
model StorageBoiler
  extends Modelica.Icons.Example;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  AixLib.Fluid.Storage.StorageDetailed bufferStorage(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    m1_flow_nominal=pipe1.m_flow_nominal,
    m2_flow_nominal=pipe1.m_flow_nominal,
    mHC1_flow_nominal=pipe1.m_flow_nominal,
    useHeatingCoil2=false,
    useHeatingRod=false,
    TStart=343.15,
    redeclare AixLib.DataBase.Storage.Generic_New_2000l data(
      hTank=2,
      hUpperPortDemand=1.95,
      hUpperPortSupply=1.95,
      hHC1Up=1.95,
      dTank=1,
      hTS2=1.95),
    n=10,
    hConIn=1500,
    hConOut=15,
    redeclare package Medium = Medium,
    hConHC1=300)                       annotation (Placement(transformation(extent={{6,-14},
            {-18,16}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 283.15) annotation(Placement(transformation(extent={{-56,-10},
            {-36,10}})));
  AixLib.Fluid.Sources.Boundary_pT
                     boundary_p(          redeclare package Medium = Medium,
      nPorts=1)                 annotation(Placement(transformation(extent={{-48,46},
            {-28,66}})));
  Modelica.Blocks.Sources.Constant SetTemp(k=273.15 + 80) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={65,69})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{18,-34},{38,-14}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance
                                           hydraulicResistance(zeta = 1000,
    redeclare package Medium = Medium,
    diameter=0.05,
    m_flow_nominal=0.001)                                                   annotation(Placement(transformation(extent={{46,-34},
            {66,-14}})));
  AixLib.Fluid.Sources.Boundary_ph
                      boundary_ph1(use_p_in = true, h = 0.8e5,
    nPorts=1,
    redeclare package Medium = Medium)                         annotation(Placement(transformation(extent={{-66,-44},
            {-46,-24}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 1000,               height = 0.00001e5,
    offset=101325)                                                                     annotation(Placement(transformation(extent={{-96,-36},
            {-76,-16}})));
  AixLib.Fluid.Sources.Boundary_pT
                      boundary_ph2(nPorts=1, redeclare package Medium = Medium)
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin={-38,34})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{-36,-44},{-16,-24}})));
  AixLib.Fluid.HeatExchangers.Heater_T       hea(
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{42,46},{22,66}})));
  AixLib.Fluid.Movers.FlowControlled_dp pump(redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=298.15,
      m_flow_nominal=pipe1.m_flow_nominal,
    per(pressure(V_flow={0,pipe.m_flow_nominal/1000,pipe.m_flow_nominal/(1000*
            0.8)}, dp={dpSet.k/0.8,dpSet.k,0}), motorCooledByFluid=false))
                                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={2,42})));
  Modelica.Blocks.Sources.Constant dpSet(k=40000)
    "Constant set pressure difference for pump" annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={37,27})));
equation
  connect(pipe.port_b, hydraulicResistance.port_a) annotation(Line(points={{38,-24},
          {46,-24}},                                                                           color = {0, 127, 255}));
  connect(ramp.y, boundary_ph1.p_in) annotation(Line(points={{-75,-26},{-68,-26}},      color = {0, 0, 127}));
  connect(boundary_ph1.ports[1], pipe1.port_a) annotation (Line(
      points={{-46,-34},{-36,-34}},
      color={0,127,255}));
  connect(hydraulicResistance.port_b, hea.port_a) annotation (Line(points={{66,-24},
          {80,-24},{80,56},{42,56}},    color={0,127,255}));
  connect(SetTemp.y, hea.TSet) annotation (Line(points={{57.3,69},{52,69},{52,
          64},{44,64}}, color={0,0,127}));
  connect(boundary_ph2.ports[1], bufferStorage.fluidportTop2) annotation (Line(
        points={{-28,34},{-9.75,34},{-9.75,16.15}}, color={0,127,255}));
  connect(bufferStorage.fluidportBottom2, pipe1.port_b) annotation (Line(points={{-9.45,
          -14.15},{-9.45,-24},{-10,-24},{-10,-34},{-16,-34}},    color={0,127,
          255}));
  connect(pipe.port_a, bufferStorage.portHC1Out) annotation (Line(points={{18,-24},
          {18,4.9},{6.15,4.9}},               color={0,127,255}));
  connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (
      Line(points={{-36,0},{-28,0},{-28,1.9},{-17.7,1.9}},     color={191,0,0}));
  connect(pump.port_b, bufferStorage.portHC1In) annotation (Line(points={{2,32},
          {2,26},{14,26},{14,9.55},{6.3,9.55}}, color={0,127,255}));
  connect(pump.port_a, hea.port_b)
    annotation (Line(points={{2,52},{2,56},{22,56}}, color={0,127,255}));
  connect(boundary_p.ports[1], pump.port_a) annotation (Line(points={{-28,56},{
          -18,56},{-18,58},{0,58},{0,52},{2,52}}, color={0,127,255}));
  connect(dpSet.y, pump.dp_in) annotation (Line(points={{29.3,27},{30,27},{30,
          28},{24,28},{24,42},{14,42}}, color={0,0,127}));
  annotation (experiment(Tolerance=1e-6, StopTime=86400, Interval=60),
   __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Storage/Examples/StorageBoiler.mos" "Simulate and plot"),
    Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This is a simple example of a storage and a boiler.
</p>
<ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Pooyan Jahangiri:<br/>
    Merged with AixLib and replaced boiler with idealHeater
  </li>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe
  </li>
  <li>
    <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>
    <i>13.12.2013</i> by Sebastian Stinner:<br/>
    implemented
  </li>
</ul>
</html>"));
end StorageBoiler;
