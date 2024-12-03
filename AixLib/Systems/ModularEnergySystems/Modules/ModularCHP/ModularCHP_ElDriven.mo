within AixLib.Systems.ModularEnergySystems.Modules.ModularCHP;
model ModularCHP_ElDriven
   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           m_flow_nominal=m_flow_nominalCC);

  parameter Modelica.Units.SI.Power NomPower=100000;
parameter Boolean ElDriven=true;

parameter Modelica.Units.SI.TemperatureDifference DeltaT "Design temperature";

parameter Modelica.Units.SI.Temperature DesHotT "Design supply temperature";



  parameter Modelica.Units.SI.Temperature THotCoolingWaterMax=273.15 + 95
                                                                       "Max. water temperature THot heat circuit";

  parameter Real PLRMin=0.5;

  parameter Modelica.Units.SI.Temperature TStart=273.15 + 20
                                                          "T start"
   annotation (Dialog(tab="Advanced"));

  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{100,70},{120,90}})));

  Fluid.Sensors.TemperatureTwoPort THotHeatCircuit(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{58,-82},{78,-62}})));
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
    Q_flow_nominal=(1.3423*NomPower/1000 + 17.681)*1000,
    T_a1_nominal=359.41,
    T_a2_nominal=333.15,
    r_nominal=1)
    annotation (Placement(transformation(extent={{10,-76},{-12,-56}})));
  Fluid.Sensors.TemperatureTwoPort TColdHeatCircuit(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{-56,-82},{-36,-62}})));
  Fluid.Sensors.TemperatureTwoPort TColdCoolingWater(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalCC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{-16,-68},{-32,-52}})));
  Fluid.Sensors.TemperatureTwoPort THotCoolingWater(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalCC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{30,-68},{16,-52}})));

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
    NomPower=NomPower,
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
    Ti=(0.8265*NomPower/1000 + 7.8516)/m_flow_nominalCC,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-150,-26},{-130,-6}})));
  Modelica.Blocks.Sources.RealExpression t_cooling_setpoint(y=273.15 + 81)
    "Soll-Kühlwassertemp"
    annotation (Placement(transformation(extent={{-238,-40},{-208,-20}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-184,-40},{-164,-20}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-252,-42},{-272,-22}})));

  Fluid.Sensors.TemperatureTwoPort THotHeatCircuit1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={86,-26})));
  EnergyNeighborhoods.Components.Controls.OnOff onOff3(bandwidth_plus=2,
      bandwidth_minus=2)
    annotation (Placement(transformation(extent={{-64,20},{-44,40}})));
protected
  parameter Modelica.Units.SI.Temperature TMinCoolingWater=354.15;
  parameter Modelica.Units.SI.TemperatureDifference deltaTCoolingWater=3.47;
  parameter Modelica.Units.SI.Temperature THotHeatCircuitMax=92+273.15;
parameter Modelica.Units.SI.MassFlowRate m_flow_nominalCC=0.0641977628513021*NomPower/1000 + 0.5371814977365220;
    parameter Modelica.Units.SI.TemperatureDifference deltaTHeatingCircuit=20 "Nominal temperature difference heat circuit";
 parameter Modelica.Units.SI.MassFlowRate m_flow_nominalHC=(0.0173378319083308*NomPower/1000 + 0.1278781340675630)*deltaTHeatingCircuit/DeltaT;
 //parameter Modelica.Units.SI.MassFlowRate m_flow_nominalHC=NomPower/0.6/DeltaT/4180;
 //parameter Modelica.Units.SI.MassFlowRate m_flow_nominalCC=NomPower/0.6/3/4180;

   replaceable package MediumHCCC =Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

 parameter Modelica.Units.SI.Pressure dp_nominal=16*V_flow_HC^2*MediumHCCC.d_const/(2*Modelica.Constants.pi^2);
 parameter Modelica.Units.SI.VolumeFlowRate V_flow_CC=m_flow_nominalCC/MediumHCCC.d_const;
 parameter Modelica.Units.SI.VolumeFlowRate V_flow_HC=m_flow_nominalHC/MediumHCCC.d_const;

//  zeta=2*dp_nominal*Modelica.Constants.pi^2/(Medium.d_const*V_flow_CC^2*16),

equation

//   if fromKelvin1.Celsius > THotHeatCircuitMax or  fromKelvin2.Celsius > THotCoolingWaterMax then
//     Shutdown=true;
//   else
//      Shutdown=false;
//   end if;

  connect(port_a, fanHC.port_a)
    annotation (Line(points={{-100,0},{-100,-12}}, color={0,127,255}));
  connect(THotHeatCircuit.T, cHPControlBus.THot) annotation (Line(points={{68,-61},
          {68,-40},{130,-40},{130,120},{0,120},{0,102}},            color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TColdHeatCircuit.T, cHPControlBus.TCold) annotation (Line(points={{-46,-61},
          {-46,-58},{-188,-58},{-188,120},{0,120},{0,102}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(hex.port_a1, THotCoolingWater.port_b)
    annotation (Line(points={{10,-60},{16,-60}}, color={0,127,255}));
  connect(TColdCoolingWater.port_a, hex.port_b1)
    annotation (Line(points={{-16,-60},{-12,-60}}, color={0,127,255}));
  connect(TColdHeatCircuit.port_b, hex.port_a2)
    annotation (Line(points={{-36,-72},{-12,-72}}, color={0,127,255}));
  connect(hex.port_b2, THotHeatCircuit.port_a)
    annotation (Line(points={{10,-72},{58,-72}}, color={0,127,255}));
  connect(genericCHP.maxThermalPower, cHPControlBus.maxTermalPower) annotation (
     Line(points={{10.8,11.8},{10.8,34},{18,34},{18,78},{0,78},{0,102}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericCHP.minThermalPower, cHPControlBus.minThermalPower)
    annotation (Line(points={{7.6,11.8},{7.6,34},{16,34},{16,76},{0,76},{0,102}},
        color={0,0,127}), Text(
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
  connect(genericCHP.port_b, THotCoolingWater.port_a)
    annotation (Line(points={{14,0},{30,0},{30,-60}}, color={0,127,255}));
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
  connect(TColdCoolingWater.port_b, fanCC.port_a) annotation (Line(points={{-32,
          -60},{-36,-60},{-36,-26}}, color={0,127,255}));
  connect(fanCC.port_b, genericCHP.port_a)
    annotation (Line(points={{-36,-6},{-36,0},{-6,0}}, color={0,127,255}));
  connect(gain.y, PID3.u_s)
    annotation (Line(points={{-163,-30},{-158,-30},{-158,-16},{-152,-16}},
                                                     color={0,0,127}));
  connect(t_cooling_setpoint.y, gain.u)
    annotation (Line(points={{-206.5,-30},{-186,-30}}, color={0,0,127}));
  connect(PID3.u_m, gain1.y) annotation (Line(points={{-140,-28},{-140,-48},{
          -198,-48},{-198,-12},{-273,-12},{-273,-32}},
                      color={0,0,127}));
  connect(genericCHP.THotEngine, gain1.u) annotation (Line(points={{4,-11},{4,
          16},{-202,16},{-202,-14},{-250,-14},{-250,-32}},
                                                  color={0,0,127}));
  connect(bou.ports[1], fanCC.port_a) annotation (Line(points={{-26,-34},{-30,-34},
          {-30,-26},{-36,-26}}, color={0,127,255}));
  connect(THotHeatCircuit.port_b, THotHeatCircuit1.port_a)
    annotation (Line(points={{78,-72},{86,-72},{86,-36}}, color={0,127,255}));
  connect(THotHeatCircuit1.port_b, port_b)
    annotation (Line(points={{86,-16},{86,0},{100,0}}, color={0,127,255}));
  connect(tHotCoolingWaterMax.y, onOff3.reference)
    annotation (Line(points={{-125.5,36},{-66,36}},color={0,0,127}));
  connect(onOff3.y, switch3.u2) annotation (Line(points={{-43,30},{-32,30},{-32,
          32},{5,32},{5,55.8}}, color={255,0,255}));
  connect(genericCHP.THotEngine, onOff3.u) annotation (Line(points={{4,-11},{4,
          16},{-74,16},{-74,24},{-66,24}},           color={0,0,127}));
  connect(switch4.y, switch3.u1) annotation (Line(points={{-9.1,67},{12.2,67},{12.2,
          55.8}}, color={0,0,127}));
  connect(realExpression.y, switch3.u3) annotation (Line(points={{-71.3,60},{-36,
          60},{-36,52},{-6,52},{-6,55.8},{-2.2,55.8}}, color={0,0,127}));
  connect(PID3.y, fanCC.y) annotation (Line(points={{-129,-16},{-120,-16},{-120,
          18},{-76,18},{-76,0},{-54,0},{-54,-12},{-56,-12},{-56,-16},{-48,-16}},
        color={0,0,127}));
  connect(cHPControlBus.m_flow_set, fanHC.y) annotation (Line(
      points={{0,102},{-70,102},{-70,64},{-122,64},{-122,-22},{-112,-22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(genericCHP.powerDemand, cHPControlBus.FuelDemand) annotation (Line(
        points={{15,4},{42,4},{42,102},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(genericCHP.Pel, cHPControlBus.ElectricPower) annotation (Line(points=
          {{15,9.4},{15,74},{0,74},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPControlBus, genericCHP.cHPControlBus) annotation (Line(
      points={{0,102},{2,102},{2,84},{28,84},{28,4.4},{14,4.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fanHC.port_b, TColdHeatCircuit.port_a) annotation (Line(points={{-100,
          -32},{-102,-32},{-102,-72},{-56,-72}}, color={0,127,255}));
  connect(integrator1.y, cHPControlBus.Energy_Elec_CHP) annotation (Line(points
        ={{71,38},{82,38},{82,102},{0,102}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
