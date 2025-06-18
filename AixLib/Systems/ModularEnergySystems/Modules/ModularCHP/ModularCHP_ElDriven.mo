within AixLib.Systems.ModularEnergySystems.Modules.ModularCHP;
model ModularCHP_ElDriven
   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           m_flow_nominal=m_flow_nominalCC);

  parameter Modelica.Units.SI.Power P_el_nom = 100000 "nominal electric power";
  parameter Modelica.Units.SI.Power Q_flow_nom = 200000 "nominal thermal power";

  parameter Boolean ElDriven=true;

  parameter Modelica.Units.SI.Temperature THotNom "Design supply temperature";
    parameter Modelica.Units.SI.Temperature TColdNom "Design supply temperature";


  parameter Real PLRMin=0.5;

  parameter Modelica.Units.SI.Temperature T_start=THotNom  "T start"
   annotation (Dialog(tab="Advanced"));

  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{100,70},{120,90}})));

  Fluid.Sensors.TemperatureTwoPort THotHeatCircuit(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start)
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = AixLib.Media.Water,
    redeclare package Medium2 = AixLib.Media.Water,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    m1_flow_nominal=m_flow_nominalCC,
    m2_flow_nominal=m_flow_nominalHC,
    dp1_nominal=2500,
    dp2_nominal=2500,
    configuration=AixLib.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    use_Q_flow_nominal=true,
    Q_flow_nominal=Q_flow_nom,
    T_a1_nominal=359.41,
    T_a2_nominal=TColdNom,
    eps_nominal=0.9,
    r_nominal=1)
    annotation (Placement(transformation(extent={{18,-104},{-4,-84}})));
  Fluid.Sensors.TemperatureTwoPort TColdHeatCircuit(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-94,-110},{-74,-90}})));
  Fluid.Sensors.TemperatureTwoPort TColdCoolingWater(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalCC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-12,-96},{-28,-80}})));
  Fluid.Sensors.TemperatureTwoPort THotCoolingWater(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalCC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start)
    annotation (Placement(transformation(extent={{46,-96},{32,-80}})));

  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-86,50},{-72,70}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=270,
        origin={5,45})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-19,67})));
  AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
    annotation (Placement(transformation(extent={{-20,82},{20,122}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{50,28},{70,48}})));

  Modelica.Blocks.Sources.RealExpression tHotCoolingWaterMax(y=
        THotCoolingWaterMax) "max. temperature cooling water"
    annotation (Placement(transformation(extent={{-178,26},{-128,46}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
    annotation (Placement(transformation(extent={{-6,-44},{-26,-24}})));
  Fluid.Movers.SpeedControlled_y fanHC(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    per(pressure(V_flow={0,V_flow_HC,V_flow_HC*2}, dp={(2500)/0.8,(2500),0})),
    addPowerToMedium=false,
    use_inputFilter=false)  "pump heating circuit" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-100,-22})));
  Fluid.BoilerCHP.GenericCHP genericCHP(
    m_flow_nominal=m_flow_nominalCC,
    T_start=T_start,
    NomPower=P_el_nom,
    ElDriven=true)
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Fluid.Movers.SpeedControlled_y fanCC(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    allowFlowReversal=true,
    per(pressure(V_flow={0,m_flow_nominalCC/1000,m_flow_nominalCC/1000*2}, dp={
            (2500 + genericCHP.dp_nominal)/0.8,(2500 + genericCHP.dp_nominal),0})),
    addPowerToMedium=false,
    use_inputFilter=false)  "pump cooling circuit" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-36,-16})));
  Modelica.Blocks.Continuous.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1/3,
    Ti=(0.8265*P_el_nom/1000 + 7.8516)/m_flow_nominalCC,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-78,-68},{-58,-48}})));
  Modelica.Blocks.Sources.RealExpression t_cooling_setpoint(y=273.15 + 81)
    "Soll-Kühlwassertemp"
    annotation (Placement(transformation(extent={{-164,-66},{-128,-50}})));

  Fluid.Sensors.TemperatureTwoPort THotHeatCircuit1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={118,-52})));
  EnergyNeighborhoods.Components.Controls.OnOff onOff3(bandwidth_plus=2,
      bandwidth_minus=2)
    annotation (Placement(transformation(extent={{-64,20},{-44,40}})));
protected
  parameter Modelica.Units.SI.Temperature THotCoolingWaterMax=273.15 + 95
                                                                       "Max. water temperature THot cooling water";
  parameter Modelica.Units.SI.Temperature TMinCoolingWater=354.15;
  parameter Modelica.Units.SI.TemperatureDifference deltaTCoolingWater=3.47;

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominalCC=Q_flow_nom/Medium.cp_const/deltaTCoolingWater
                                              "nominal Water massflow cooling circuit (engine <-> heat exchanger)";


  parameter Modelica.Units.SI.Temperature THotHeatCircuitMax=92+273.15;
  parameter Modelica.Units.SI.TemperatureDifference deltaT_HC=THotNom-TColdNom "Nominal temperature difference heat circuit";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominalHC=Q_flow_nom/Medium.cp_const/deltaT_HC;

  //parameter Modelica.Units.SI.MassFlowRate m_flow_nominalCC=0.0641977628513021*P_el_nom/1000 + 0.5371814977365220;

 //parameter Modelica.Units.SI.MassFlowRate m_flow_nominalHC=(0.0173378319083308*P_el_nom/1000 + 0.1278781340675630)*deltaTHeatingCircuit/DeltaT;
 //parameter Modelica.Units.SI.MassFlowRate m_flow_nominalHC=P_el_nom/0.6/DeltaT/4180;
 //parameter Modelica.Units.SI.MassFlowRate m_flow_nominalCC=P_el_nom/0.6/3/4180;

 parameter Modelica.Units.SI.Pressure dp_nominal=16*V_flow_HC^2*Medium.d_const/(2*Modelica.Constants.pi^2);
 parameter Modelica.Units.SI.VolumeFlowRate V_flow_CC=m_flow_nominalCC/Medium.d_const;
 parameter Modelica.Units.SI.VolumeFlowRate V_flow_HC=m_flow_nominalHC/Medium.d_const;

//  zeta=2*dp_nominal*Modelica.Constants.pi^2/(Medium.d_const*V_flow_CC^2*16),

public
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{54,60},{74,80}})));
  Modelica.Blocks.Sources.RealExpression setpoint(y=1)
    "Setpoint Kühlwasserpumpe"
    annotation (Placement(transformation(extent={{-64,-24},{-54,-8}})));
  Fluid.Actuators.Valves.ThreeWayLinear        val(
    redeclare package Medium = Media.Water,
    T_start=T_start,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=6000,
    fraK=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-36,-58})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{-216,-14},{-196,6}})));
  Modelica.Blocks.Continuous.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=1/3,
    Ti=(0.8265*P_el_nom/1000 + 7.8516)/m_flow_nominalCC,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-236,-56},{-216,-36}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-174,-122},{-194,-102}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-200,-104},{-220,-84}})));
equation

//   if fromKelvin1.Celsius > THotHeatCircuitMax or  fromKelvin2.Celsius > THotCoolingWaterMax then
//     Shutdown=true;
//   else
//      Shutdown=false;
//   end if;

  connect(port_a, fanHC.port_a)
    annotation (Line(points={{-100,0},{-100,-12}}, color={0,127,255}));
  connect(THotHeatCircuit.T, cHPControlBus.THot) annotation (Line(points={{100,-89},
          {100,-78},{132,-78},{132,120},{0,120},{0,102}},           color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TColdHeatCircuit.T, cHPControlBus.TCold) annotation (Line(points={{-84,-89},
          {-84,-76},{-188,-76},{-188,102},{0,102}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(hex.port_a1, THotCoolingWater.port_b)
    annotation (Line(points={{18,-88},{32,-88}}, color={0,127,255}));
  connect(TColdCoolingWater.port_a, hex.port_b1)
    annotation (Line(points={{-12,-88},{-4,-88}},  color={0,127,255}));
  connect(TColdHeatCircuit.port_b, hex.port_a2)
    annotation (Line(points={{-74,-100},{-4,-100}},color={0,127,255}));
  connect(hex.port_b2, THotHeatCircuit.port_a)
    annotation (Line(points={{18,-100},{90,-100}},
                                                 color={0,127,255}));
  connect(genericCHP.maxThermalPower, cHPControlBus.maxTermalPower) annotation (
     Line(points={{10.8,11.8},{10.8,34},{18,34},{18,78},{0,78},{0,102}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericCHP.Pel, integrator1.u) annotation (Line(points={{15,9.4},{30,
          9.4},{30,38},{48,38}},
                            color={0,0,127}));
  connect(switch3.y, genericCHP.PLR) annotation (Line(points={{5,35.1},{5,26},{
          -14,26},{-14,8},{-8,8}},
                               color={0,0,127}));
  connect(cHPControlBus.PLR, switch4.u1) annotation (Line(
      points={{0,102},{0,82},{-46,82},{-46,74.2},{-29.8,74.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPControlBus.OnOff, switch4.u2) annotation (Line(
      points={{0,102},{-70,102},{-70,67},{-29.8,67}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression.y, switch4.u3) annotation (Line(points={{-71.3,60},{
          -60,60},{-60,59.8},{-29.8,59.8}}, color={0,0,127}));
  connect(fanCC.port_b, genericCHP.port_a)
    annotation (Line(points={{-36,-6},{-36,0},{-6,0}}, color={0,127,255}));
  connect(bou.ports[1], fanCC.port_a) annotation (Line(points={{-26,-34},{-36,-34},
          {-36,-26}},           color={0,127,255}));
  connect(THotHeatCircuit.port_b, THotHeatCircuit1.port_a)
    annotation (Line(points={{110,-100},{118,-100},{118,-62}},
                                                          color={0,127,255}));
  connect(THotHeatCircuit1.port_b, port_b)
    annotation (Line(points={{118,-42},{118,0},{100,0}},
                                                       color={0,127,255}));
  connect(tHotCoolingWaterMax.y, onOff3.reference)
    annotation (Line(points={{-125.5,36},{-66,36}},color={0,0,127}));
  connect(onOff3.y, switch3.u2) annotation (Line(points={{-43,30},{-32,30},{-32,
          32},{5,32},{5,55.8}}, color={255,0,255}));
  connect(genericCHP.THotEngine, onOff3.u) annotation (Line(points={{4,-11},{4,
          0},{-28,0},{-28,12},{-74,12},{-74,24},{-66,24}},
                                                     color={0,0,127}));
  connect(switch4.y, switch3.u1) annotation (Line(points={{-9.1,67},{12.2,67},{12.2,
          55.8}}, color={0,0,127}));
  connect(realExpression.y, switch3.u3) annotation (Line(points={{-71.3,60},{-36,
          60},{-36,52},{-6,52},{-6,55.8},{-2.2,55.8}}, color={0,0,127}));
  connect(cHPControlBus, genericCHP.cHPControlBus) annotation (Line(
      points={{0,102},{2,102},{2,84},{28,84},{28,4.4},{14,4.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fanHC.port_b, TColdHeatCircuit.port_a) annotation (Line(points={{-100,
          -32},{-100,-100},{-94,-100}},          color={0,127,255}));
  connect(integrator1.y, cHPControlBus.EnergyElec) annotation (Line(points={{71,
          38},{86,38},{86,102},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(genericCHP.powerDemand, cHPControlBus.PowerFuel) annotation (Line(
        points={{15,4},{42,4},{42,102},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(genericCHP.Pel, cHPControlBus.PowerElec) annotation (Line(points={{15,
          9.4},{15,102},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericCHP.powerDemand, integrator2.u)
    annotation (Line(points={{15,4},{52,4},{52,70}}, color={0,0,127}));
  connect(integrator2.y, cHPControlBus.EnergyFuel) annotation (Line(points={{75,
          70},{78,70},{78,78},{80,78},{80,102},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(genericCHP.minThermalPower, cHPControlBus.MinThermalPower)
    annotation (Line(points={{7.6,11.8},{7.6,55.9},{0.1,55.9},{0.1,102.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(setpoint.y, fanCC.y)
    annotation (Line(points={{-53.5,-16},{-48,-16}}, color={0,0,127}));
  connect(genericCHP.THotEngine, PID3.u_m) annotation (Line(points={{4,-11},{4,-76},
          {-68,-76},{-68,-70}}, color={0,0,127}));
  connect(t_cooling_setpoint.y, PID3.u_s)
    annotation (Line(points={{-126.2,-58},{-80,-58}}, color={0,0,127}));
  connect(PID3.y, val.y)
    annotation (Line(points={{-57,-58},{-48,-58}}, color={0,0,127}));
  connect(TColdCoolingWater.port_b, val.port_1) annotation (Line(points={{-28,-88},
          {-36,-88},{-36,-68}}, color={0,127,255}));
  connect(fanCC.port_a, val.port_2)
    annotation (Line(points={{-36,-26},{-36,-48}}, color={0,127,255}));
  connect(genericCHP.port_b, THotCoolingWater.port_a) annotation (Line(points={{
          14,0},{48,0},{48,-88},{46,-88}}, color={0,127,255}));
  connect(genericCHP.port_b, val.port_3) annotation (Line(points={{14,0},{48,0},
          {48,-58},{-26,-58}}, color={0,127,255}));
  connect(cHPControlBus.m_flow_set, max1.u1) annotation (Line(
      points={{0,102},{-238,102},{-238,2},{-218,2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(max1.y, fanHC.y) annotation (Line(points={{-195,-4},{-146,-4},{-146,-22},
          {-112,-22}}, color={0,0,127}));
  connect(PID1.y, max1.u2) annotation (Line(points={{-215,-46},{-198,-46},{-198,
          -22},{-228,-22},{-228,-10},{-218,-10}}, color={0,0,127}));
  connect(genericCHP.THotEngine, gain.u)
    annotation (Line(points={{4,-11},{4,-112},{-172,-112}}, color={0,0,127}));
  connect(gain.y, PID1.u_m) annotation (Line(points={{-195,-112},{-226,-112},{-226,
          -58}}, color={0,0,127}));
  connect(t_cooling_setpoint.y, gain1.u) annotation (Line(points={{-126.2,-58},{
          -122,-58},{-122,-94},{-198,-94}},
                                          color={0,0,127}));
  connect(gain1.y, PID1.u_s) annotation (Line(points={{-221,-94},{-246,-94},{-246,
          -46},{-238,-46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html><p>
  Model of a CHP-module with an inner cooling circuit and a control
  unit. Heat circuit and cooling circuit are connected with a heat
  exchanger. Further informations are given in the submodel
  discribtion.
</p>
</html>"));
end ModularCHP_ElDriven;
