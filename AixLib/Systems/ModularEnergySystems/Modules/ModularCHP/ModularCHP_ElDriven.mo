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
    annotation (Placement(transformation(extent={{-240,140},{-220,160}})));

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
    use_Q_flow_nominal=false,
    eps_nominal=0.9,
    r_nominal=1)
    annotation (Placement(transformation(extent={{18,-104},{-4,-84}})));
  Fluid.Sensors.TemperatureTwoPort TColdHeatCircuit(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start - 20)
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
    annotation (Placement(transformation(extent={{-174,48},{-160,68}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=270,
        origin={5,45})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-103,75})));
  AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
    annotation (Placement(transformation(extent={{-20,82},{20,122}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{80,20},{100,40}})));

  Modelica.Blocks.Sources.RealExpression tHotCoolingWaterMax(y=
        THotCoolingWaterMax) "max. temperature cooling water"
    annotation (Placement(transformation(extent={{-132,24},{-82,44}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
    annotation (Placement(transformation(extent={{-6,-44},{-26,-24}})));
  Fluid.Movers.SpeedControlled_y fanHC(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    per(pressure(V_flow={0,V_flow_HC,V_flow_HC*2}, dp={(2500)/0.8,(2500),0})),
    addPowerToMedium=false,
    tau=1,
    use_inputFilter=true,
    riseTime=10,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=1)              "pump heating circuit" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-100,-22})));
  Fluid.BoilerCHP.GenericCHP genericCHP(
    m_flow_nominal=m_flow_nominalCC,
    T_start=354.15,
    NomPower=P_el_nom,
    ElDriven=true,
    filename_PTHR=filename_PTHR,
    filename_etaEl=filename_etaEl,
    interneal_demand=interneal_demand)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
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
    k=0.1,
    Ti=50,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-84,-68},{-64,-48}})));
  Modelica.Blocks.Sources.RealExpression t_cooling_setpoint(y=81 + 273.15)
    "Soll-Kühlwassertemp"
    annotation (Placement(transformation(extent={{-182,-66},{-144,-50}})));

  Fluid.Sensors.TemperatureTwoPort THotHeatCircuit1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={118,-52})));
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
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Fluid.Actuators.Valves.ThreeWayLinear        val(
    redeclare package Medium = Media.Water,
    T_start=T_start,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=6000,
    fraK=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-36,-58})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-116,-68},{-96,-48}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
    annotation (Placement(transformation(extent={{-44,-92},{-64,-72}})));
  Fluid.Sensors.MassFlowRate senMasFloCHP(redeclare package Medium =
        AixLib.Media.Water "Water") annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={72,-100})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=4)
    annotation (Placement(transformation(extent={{-44,18},{-24,38}})));
  parameter String filename_PTHR=
      ModelicaServices.ExternalReferences.loadResource(
      "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/Stromkennzahl.sdf")
    "File name";
  parameter String filename_etaEl=
      ModelicaServices.ExternalReferences.loadResource(
      "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/EtaEL.sdf")
    "File name";
  parameter Real interneal_demand=0.9819
    "Efficiency for internal electricity demand";
equation

//   if fromKelvin1.Celsius > THotHeatCircuitMax or  fromKelvin2.Celsius > THotCoolingWaterMax then
//     Shutdown=true;
//   else
//      Shutdown=false;
//   end if;

  connect(port_a, fanHC.port_a)
    annotation (Line(points={{-100,0},{-100,-12}}, color={0,127,255}));
  connect(THotHeatCircuit.T, cHPControlBus.THot) annotation (Line(points={{100,-89},
          {100,-78},{132,-78},{132,130},{0,130},{0,102}},           color={0,0,
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
  connect(genericCHP.maxThermalPower, cHPControlBus.maxTermalPower) annotation (
     Line(points={{8.8,11.8},{8.8,34},{18,34},{18,78},{0,78},{0,102}},   color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericCHP.Pel, integrator1.u) annotation (Line(points={{13,9.4},{20,
          9.4},{20,30},{78,30}},
                            color={0,0,127}));
  connect(switch3.y, genericCHP.PLR) annotation (Line(points={{5,35.1},{5,26},{
          -14,26},{-14,8},{-10,8}},
                               color={0,0,127}));
  connect(cHPControlBus.PLR, switch4.u1) annotation (Line(
      points={{0,102},{-136,102},{-136,82.2},{-113.8,82.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPControlBus.OnOff, switch4.u2) annotation (Line(
      points={{0,102},{-148,102},{-148,75},{-113.8,75}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression.y, switch4.u3) annotation (Line(points={{-159.3,58},{
          -142,58},{-142,67.8},{-113.8,67.8}},
                                            color={0,0,127}));
  connect(fanCC.port_b, genericCHP.port_a)
    annotation (Line(points={{-36,-6},{-36,0},{-8,0}}, color={0,127,255}));
  connect(bou.ports[1], fanCC.port_a) annotation (Line(points={{-26,-34},{-36,-34},
          {-36,-26}},           color={0,127,255}));
  connect(THotHeatCircuit.port_b, THotHeatCircuit1.port_a)
    annotation (Line(points={{110,-100},{118,-100},{118,-62}},
                                                          color={0,127,255}));
  connect(THotHeatCircuit1.port_b, port_b)
    annotation (Line(points={{118,-42},{118,0},{100,0}},
                                                       color={0,127,255}));
  connect(switch4.y, switch3.u1) annotation (Line(points={{-93.1,75},{12.2,75},
          {12.2,55.8}},
                  color={0,0,127}));
  connect(realExpression.y, switch3.u3) annotation (Line(points={{-159.3,58},{
          -80,58},{-80,68},{-2,68},{-2,56},{-2.2,56},{-2.2,55.8}},
                                                       color={0,0,127}));
  connect(cHPControlBus, genericCHP.cHPControlBus) annotation (Line(
      points={{0,102},{0,138},{56,138},{56,4.4},{12,4.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fanHC.port_b, TColdHeatCircuit.port_a) annotation (Line(points={{-100,
          -32},{-100,-100},{-94,-100}},          color={0,127,255}));
  connect(integrator1.y, cHPControlBus.EnergyElec) annotation (Line(points={{101,30},
          {126,30},{126,130},{0,130},{0,102}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(genericCHP.powerDemand, cHPControlBus.PowerFuel) annotation (Line(
        points={{13,4},{42,4},{42,102},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(genericCHP.Pel, cHPControlBus.PowerElec) annotation (Line(points={{13,9.4},
          {13,102},{0,102}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericCHP.powerDemand, integrator2.u)
    annotation (Line(points={{13,4},{42,4},{42,70},{78,70}},
                                                     color={0,0,127}));
  connect(integrator2.y, cHPControlBus.EnergyFuel) annotation (Line(points={{101,70},
          {106,70},{106,102},{0,102}},                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(genericCHP.minThermalPower, cHPControlBus.MinThermalPower)
    annotation (Line(points={{5.6,11.8},{5.6,71.9},{0.1,71.9},{0.1,102.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(t_cooling_setpoint.y, gain2.u)
    annotation (Line(points={{-142.1,-58},{-118,-58}}, color={0,0,127}));
  connect(PID3.u_s, gain2.y)
    annotation (Line(points={{-86,-58},{-95,-58}}, color={0,0,127}));
  connect(PID3.y, val.y)
    annotation (Line(points={{-63,-58},{-48,-58}}, color={0,0,127}));
  connect(gain3.y, PID3.u_m) annotation (Line(points={{-65,-82},{-70,-82},{-70,
          -70},{-74,-70}}, color={0,0,127}));
  connect(TColdCoolingWater.port_b, val.port_1) annotation (Line(points={{-28,
          -88},{-32,-88},{-32,-68},{-36,-68}}, color={0,127,255}));
  connect(THotCoolingWater.port_a, genericCHP.port_b) annotation (Line(points={{46,-88},
          {54,-88},{54,0},{12,0}},          color={0,127,255}));
  connect(genericCHP.port_b, val.port_3) annotation (Line(points={{12,0},{22,0},
          {22,-2},{40,-2},{40,-58},{-26,-58}}, color={0,127,255}));
  connect(val.port_2, fanCC.port_a)
    annotation (Line(points={{-36,-48},{-36,-26}}, color={0,127,255}));
  connect(genericCHP.THotEngine, gain3.u) annotation (Line(points={{2,-11},{6,
          -11},{6,-82},{-42,-82}}, color={0,0,127}));
  connect(hex.port_b2, senMasFloCHP.port_a)
    annotation (Line(points={{18,-100},{64,-100}}, color={0,127,255}));
  connect(senMasFloCHP.port_b, THotHeatCircuit.port_a)
    annotation (Line(points={{80,-100},{90,-100}}, color={0,127,255}));
  connect(senMasFloCHP.m_flow, cHPControlBus.m_flow) annotation (Line(points={{
          72,-91.2},{72,-46},{0,-46},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericCHP.THotEngine, onOffController.u) annotation (Line(points={{2,-11},
          {2,-20},{-70,-20},{-70,22},{-46,22}},              color={0,0,127}));
  connect(tHotCoolingWaterMax.y, onOffController.reference)
    annotation (Line(points={{-79.5,34},{-46,34}}, color={0,0,127}));
  connect(onOffController.y, switch3.u2) annotation (Line(points={{-23,28},{-20,
          28},{-20,62},{5,62},{5,55.8}}, color={255,0,255}));
  connect(cHPControlBus.m_flow_set, fanHC.y) annotation (Line(
      points={{0,102},{-54,102},{-54,128},{-162,128},{-162,-22},{-112,-22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPControlBus.PLR, fanCC.y) annotation (Line(
      points={{0,102},{-4,102},{-4,82},{-48,82},{-48,-16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,20},{14,-22}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-8,-2},{-8,-22},{-6,-16},{10,-16},{12,-22},{12,-2},{-8,-2}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,-12},{6,-18}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-16,-40},{-6,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-16},{-12,-40},{-8,-42},{2,-18},{0,-16}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2.5,-1.5},{-6,4},{2,18},{8,10},{12,10},{10,6},{10,2},{7.5,
              -1.5},{-2.5,-1.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-2.5,0.5},{2,10},{8,4},{4,0},{-2.5,0.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid)}));
end ModularCHP_ElDriven;
