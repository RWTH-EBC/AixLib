within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationHeatingCooling_DC_CH_HP_HeatStorage "Substation model for bidirctional low-temperature networks for buildings with 
  heat pump, decentral heat storage, direct cooling and chiller."

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);
    parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";
    parameter Modelica.SIunits.Density rho = 1000 "Density of Water";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_heating = heatDemand_max/(cp_default*deltaT_heatingSet)
    "Nominal mass flow rate";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_cooling = -coolingDemand_max/(cp_default*deltaT_coolingSet)
    "Nominal mass flow rate";

    parameter Modelica.SIunits.Power heatDemand_max "Maximum heat demand for scaling of heatpump in Watt";
    parameter Modelica.SIunits.Power coolingDemand_max "Maximum cooling demand for scaling of chiller in Watt (negative values)";

    parameter Modelica.SIunits.Temperature T_heatingSupplySet "Supply Temperature of buildings heating system";
    parameter Modelica.SIunits.TemperatureDifference deltaT_heatingSet "Set temperature difference for cooling on the building site";
    parameter Modelica.SIunits.Temperature T_coolingSupplySet "Supply Temperature of buildings cooling system, limit mvalue for direct cooling system";
    parameter Modelica.SIunits.TemperatureDifference deltaT_coolingSet "Set temperature difference for cooling on the building site";

    parameter Modelica.SIunits.Volume VTan=heatDemand_max/(cp_default * rho * deltaT_heatingSet)*(3600) "Tank volume (default: discharge 1 h with max heat demand)";
    parameter Modelica.SIunits.Temperature T_storage_max "Max. Storage Temperatur for charging";
    parameter Modelica.SIunits.Temperature T_storage_min "Min. Storage Temperatur for discharging";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = max(heatDemand_max/(cp_default*deltaT_heatingSet),-coolingDemand_max/(cp_default*deltaT_coolingSet))
    "Nominal mass flow rate";
    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

  AixLib.Fluid.Delays.DelayFirstOrder vol(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{-238,-52},{-218,
            -32}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{632,-50},{652,-30}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpHeatingGrid(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-54,-106},{-24,-140}})));
public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-268,-70},{-248,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{654,-68},{674,-48}}),
        iconTransformation(extent={{654,-68},{674,-48}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit = "W")
    "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-300,-672},{-260,-632}}),
        iconTransformation(extent={{716,48},{660,104}})));
  AixLib.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    verifyFlowReversal=false,
    tau=5)
    annotation (Placement(transformation(extent={{-166,-50},{-146,-70}})));

  AixLib.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    verifyFlowReversal=false,
    tau=5)
    annotation (Placement(transformation(extent={{580,-68},{560,-48}})));
  AixLib.Fluid.Chillers.Carnot_TEva chi(
    redeclare package Medium1 = Medium,
    QEva_flow_nominal=coolingDemand_max,
    use_eta_Carnot_nominal=true,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    dTEva_nominal=-5,
    dTCon_nominal=6,
    etaCarnot_nominal=0.3,
    QEva_flow_min=coolingDemand_max,
    tau1=300,
    tau2=300,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    redeclare package Medium2 = Medium,
    T1_start=283.15,
    T2_start=283.15)
    annotation (Placement(transformation(extent={{150,78},{86,22}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpCooling(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{250,-24},{218,4}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit = "W")
    "Input for cooling demand profile of substation" annotation (Placement(
        transformation(extent={{700,158},{660,198}}),
                                                    iconTransformation(extent={{-322,
            -294},{-260,-232}})));
  Modelica.Blocks.Interfaces.RealInput T_supplyCoolingSet(unit = "K")
    "Supply temperatur of cooling circuit in the building" annotation (
      Placement(transformation(extent={{698,200},{658,240}}),
        iconTransformation(extent={{-322,-194},{-260,-132}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridHeat(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-204,-70},{-184,-50}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridCool(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{596,-68},{616,-48}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_HeatPump(redeclare package Medium =
               Medium, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-88,-132},{-68,-112}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_chiller(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{322,-20},{302,0}})));
  Modelica.Blocks.Interfaces.RealInput deltaT_heatingGridSet(unit = "K")
    "Set temperature difference for heating on the site of thermal network"
                                                          annotation (
      Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-280,-614}), iconTransformation(extent={{716,-20},{656,40}})));
  Modelica.Blocks.Interfaces.RealInput deltaT_coolingGridSet(unit = "K")
    "Set temperature difference for cooling on the site of thermal network"                                                           annotation (
      Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={680,134}),   iconTransformation(extent={{-324,-390},{-258,
            -324}})));

  Modelica.Blocks.Interfaces.RealOutput powerConsumptionHP(unit = "W")
  "Power consumption of heat pum in Watt"
    annotation (Placement(transformation(extent={{-258,220},{-278,240}}),
        iconTransformation(extent={{-264,188},{-294,218}})));
  Modelica.Blocks.Interfaces.RealOutput powerConsumptionChiller(unit = "W")
  "Power consumption of chiller in Watt"
    annotation (Placement(transformation(extent={{-260,194},{-280,214}}),
        iconTransformation(extent={{-260,146},{-290,176}})));
  Modelica.Blocks.Interfaces.RealOutput powerConsumptionSubstation(unit = "W")
    annotation (Placement(transformation(extent={{-262,248},{-282,268}}),
        iconTransformation(extent={{-260,222},{-294,256}})));
  Modelica.Blocks.Math.Sum sum(nin=2)
    annotation (Placement(transformation(extent={{-190,248},{-210,268}})));
  AixLib.Fluid.FixedResistances.Junction jun_heatsink(
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal=max(m_flow_nominal_heating)*{1,1,1},
    dp_nominal={0,dp_nominal,dp_nominal},
    verifyFlowReversal=false,
    T_start=328.15,
    redeclare package Medium = Medium,
    tau=10)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-106,-298})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_HP_out(
                       m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K"),
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=1)
    annotation (Placement(transformation(extent={{12,-176},{-14,-148}})));
  AixLib.Fluid.FixedResistances.Junction jun_DC(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    tau=0.1)                               annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={388,-8})));

  AixLib.Fluid.FixedResistances.Junction jun_DC1(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    tau=0.1)                               annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-38,-8})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_HE_heat_in(
    m_flow_nominal=m_flow_nominal_heating,
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=1,
    T_start(displayUnit="K") = T_heatingSupplySet)
                              annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={188,-594})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_HE_heat_out(
    m_flow_nominal=m_flow_nominal_heating,
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=1,
    T_start(displayUnit="degC") = T_heatingSupplySet - deltaT_heatingSet)
    annotation (Placement(transformation(extent={{276,-604},{256,-584}})));
  BaseClasses.SubstationStorageHeating                                   substationStorageHeating(
    T_min(displayUnit="K") = T_storage_min,
    T_max(displayUnit="K") = T_storage_max,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_heating,
    T_start(displayUnit="degC") = T_storage_min,
    VTan=VTan)
    annotation (Placement(transformation(extent={{240,-312},{328,-248}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_Storage_top(
    m_flow_nominal=m_flow_nominal_heating,
    T_start(displayUnit="K") = Medium.T_default,
    redeclare package Medium = Medium,
    tau=10)
    annotation (Placement(transformation(extent={{4,-310},{-30,-286}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_Storage_bottom(
    m_flow_nominal=m_flow_nominal_heating,
    T_start(displayUnit="K") = Medium.T_default,
    redeclare package Medium = Medium,
    tau=1)
    annotation (Placement(transformation(extent={{460,-308},{440,-288}})));
  Modelica.Blocks.Interfaces.RealInput FreeElectricity(unit = "W")
    "Amount of available electricity in W"             annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-278,-360}), iconTransformation(extent={{720,-388},{660,-328}})));
  AixLib.Fluid.FixedResistances.Junction jun_DC2(
    redeclare package Medium = Medium,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    dp_nominal={0,dp_nominal,dp_nominal},
    m_flow_nominal=m_flow_nominal_cooling*{1,1,1},
    tau=0.1)                               annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-2,210})));
  AixLib.Fluid.FixedResistances.Junction jun_DC3(
    redeclare package Medium = Medium,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal_cooling*{1,1,1},
    dp_nominal={0,dp_nominal,dp_nominal},
    tau=0.1)                               annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={226,210})));
  AixLib.Fluid.Movers.FlowControlled_m_flow PumpCoolingChiller(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal_cooling,
    allowFlowReversal=false,
    tau=60)                        annotation (Placement(transformation(
        extent={{15,16},{-15,-16}},
        rotation=90,
        origin={0,135})));
  AixLib.Fluid.Movers.FlowControlled_m_flow PumpCoolingDirect(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal_cooling,
    allowFlowReversal=false,
    tau=600)                       annotation (Placement(transformation(
        extent={{-13,13},{13,-13}},
        rotation=90,
        origin={385,91})));
  Modelica.Blocks.Interfaces.RealOutput COP_HP
  "COP of heat pump" annotation (Placement(
        transformation(extent={{-260,154},{-280,174}}), iconTransformation(
          extent={{-262,98},{-294,130}})));
  Modelica.Blocks.Sources.RealExpression COP(y=heatPump.COP) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-210,164})));
  Modelica.Blocks.Interfaces.RealOutput P_max_HP annotation (Placement(
        transformation(extent={{-260,114},{-278,132}}), iconTransformation(
          extent={{-260,56},{-294,90}})));
public
  BaseClasses.heatPump_simple heatPump(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    eta_car=0.55,
    Capacity=2*heatDemand_max,
    T_max_storage=T_storage_max)
    annotation (Placement(transformation(extent={{80,-176},{144,-110}})));
public
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_HE_Cooling_out(
    redeclare package Medium = Medium,
    T_start(displayUnit="K") = T_coolingSupplySet + deltaT_coolingSet,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    tau=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={60,210})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_DC_in(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K"),
    tau=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={456,-2})));
    Modelica.Blocks.Sources.RealExpression Temp_SupplyHeatingSet_HeatEx(y=
        T_heatingSupplySet)
    annotation (Placement(transformation(extent={{340,-226},{320,-206}})));
protected
  Modelica.Blocks.Sources.RealExpression PEle1(y=heatDemand_max/4)
    "Maximum electrical power consumption"
    annotation (Placement(transformation(extent={{-168,90},{-188,110}})));
protected
  Modelica.Blocks.Sources.RealExpression heatPump_COP(y=heatPump.COP)
    annotation (Placement(transformation(extent={{-94,-398},{-74,-378}})));
protected
  Modelica.Blocks.Sources.RealExpression storage_T_Top(y=
        substationStorageHeating.TTop.T) "Storage temperatur at top layer"
    annotation (Placement(transformation(extent={{-94,-440},{-74,-420}})));
protected
  Modelica.Blocks.Sources.RealExpression storage_T_Bot(y=
        substationStorageHeating.TBot.T) "Storage temperature at bottom layer"
    annotation (Placement(transformation(extent={{-94,-426},{-74,-406}})));
protected
  Modelica.Blocks.Sources.RealExpression m_flow_gridPumpHeating(y=max(0, -
        heatPump.prescribedHeatFlow1.Q_flow/(4180*deltaT_heatingGridSet)))
    "Input of mass flow for heating grid pump"
    annotation (Placement(transformation(extent={{-80,-190},{-60,-170}})));
protected
  Modelica.Blocks.Sources.RealExpression heatPump_COP_char(y=heatPump.COP_charging)
    annotation (Placement(transformation(extent={{-94,-382},{-74,-362}})));
protected
  Modelica.Blocks.Sources.RealExpression chiller_power(y=chi.P)
    "Storage temperatur at top layer"
    annotation (Placement(transformation(extent={{-94,-412},{-74,-392}})));
protected
  Modelica.Blocks.Sources.RealExpression stenTemp_HpIn(y=senTem_HP_in.T)
    "Inlet temperature of heat pump"
    annotation (Placement(transformation(extent={{-94,-474},{-74,-454}})));
protected
  Modelica.Blocks.Sources.RealExpression m_flowHeatExHeating(y=
        mass_flow_heatExchangerHeating.y) "Inlet temperature of heat pump"
    annotation (Placement(transformation(extent={{-94,-456},{-74,-436}})));
public
  BaseClasses.MassFlowControllerHeating                                   massFlowControllerHeating(
    deltaT_he=deltaT_heatingSet,
    T_storage_min=T_storage_min,
    T_storage_max=T_storage_max,
    deltaT_heatingSet=deltaT_heatingSet,
    m_flow_nominal=m_flow_nominal,
    capacity=heatPump.Capacity)
    annotation (Placement(transformation(extent={{-12,-430},{70,-358}})));
  BaseClasses.MassFlowControllerCooling
    massFlowControllerCooling(
    T_max_directCooling=T_coolingSupplySet,
    deltaT_coolingSet=deltaT_coolingSet,              m_flow_nominal=
        m_flow_nominal)
    annotation (Placement(transformation(extent={{556,130},{476,186}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{294,-210},{274,-190}})));
  Modelica.Blocks.Sources.RealExpression Temp_SupplyHeatingSet_Storage(y=
        T_storage_max)
    annotation (Placement(transformation(extent={{340,-194},{320,-174}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_hp_in(redeclare package Medium =
        Medium, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{452,-172},{432,-152}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_HP_in(
    T_start(displayUnit="K"),
    m_flow_nominal=m_flow_nominal_heating,
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=1)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={506,-162})));
  AixLib.Fluid.Delays.DelayFirstOrder vol2(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_cooling,
    T_start=T_coolingSupplySet,
    tau=60)  annotation (Placement(transformation(extent={{106,210},{126,230}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={102,266})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_HP_out1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    T_start(displayUnit="K"),
    tau=1)
    annotation (Placement(transformation(extent={{212,-132},{242,-112}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_DC_in1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K"),
    tau=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-108,-8})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{168,-662},{188,-642}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{130,-662},{150,-642}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_sinkStorage(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{384,-308},{404,-288}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_he_in(redeclare package Medium =
        Medium, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{68,-604},{48,-584}})));
  AixLib.Fluid.Delays.DelayFirstOrder heatExchanger_heating(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_heating,
    nPorts=2,
    allowFlowReversal=false,
    tau=60,
    T_start=T_heatingSupplySet)
            "represents heat exchanger of buildings heating system"
    annotation (Placement(transformation(extent={{218,-594},{238,-614}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_DC_in2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K") = T_coolingSupplySet,
    tau=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={168,210})));
    Modelica.Blocks.Math.Add add2(k1=+1, k2=+1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={340,238})));
  Modelica.Blocks.Sources.Constant const1(k=deltaT_coolingSet)
    annotation (Placement(transformation(extent={{256,212},{276,232}})));
  AixLib.Fluid.Sources.Boundary_pT sinkHeating(
    redeclare package Medium = Medium,
    use_T_in=false,
    T=273.15 + 45,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={630,-342})));
    Modelica.Blocks.Sources.RealExpression mass_flow_HeatExchangerStart(y=-
        heatDemand/(cp_default*(criticalDamping1.y - (T_heatingSupplySet -
        deltaT_heatingSet))))
    "mass flow through heat exchanger at start"
    annotation (Placement(transformation(extent={{340,-642},{360,-622}})));
    Modelica.Blocks.Sources.RealExpression mass_flow_HeatExchanger(y=-
        heatDemand/(cp_default*(deltaT_heatingSet)))
                                      "mass flow through heat exchanger"
    annotation (Placement(transformation(extent={{340,-696},{360,-676}})));
  Modelica.Blocks.Sources.Constant setReturnTempHeating(k=T_heatingSupplySet -
        deltaT_heatingSet)
    "Setelaving temperature of heat exchanger (return temperature of buildings heating system) "
    annotation (Placement(transformation(extent={{182,-270},{198,-254}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{394,-668},{414,-648}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=3600)
    annotation (Placement(transformation(extent={{340,-668},{360,-648}})));
  AixLib.Fluid.FixedResistances.Junction jun_heatsink1(
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal=max(m_flow_nominal_heating)*{1,1,1},
    dp_nominal={0,dp_nominal,dp_nominal},
    verifyFlowReversal=false,
    T_start=Medium.T_default,
    redeclare package Medium = Medium,
    tau=10)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={574,-298})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpStorage(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=318.15,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{528,-280},{494,-316}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpHeating(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=318.15,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal_heating,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{462,-576},{430,-612}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=T_heatingSupplySet,
    f=1/60)
    annotation (Placement(transformation(extent={{120,-210},{100,-190}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping1(f=1/60)
    annotation (Placement(transformation(extent={{204,-568},{224,-548}})));
  Modelica.Blocks.Interfaces.RealOutput renewablePowerConsumptionSubstation(unit = "W")
  "Renewable power consumption of chiller based on difference between total power use and available renewable power"
    annotation (Placement(transformation(extent={{-260,280},{-280,300}}),
        iconTransformation(extent={{-260,222},{-294,256}})));
equation
  connect(port_a,vol. ports[1])
    annotation (Line(points={{-258,-60},{-230,-60},{-230,-52}},
                                                        color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{664,-58},{640,-58},{640,-50}},
                                                     color={0,127,255}));
  connect(vol.ports[2], senMasFlo_GridHeat.port_a) annotation (Line(points={{-226,
          -52},{-226,-60},{-204,-60}},         color={0,127,255}));
  connect(senMasFlo_GridHeat.port_b, jun.port_1)
    annotation (Line(points={{-184,-60},{-166,-60}},
                                                 color={0,127,255}));
  connect(senMasFlo_GridCool.port_b, vol1.ports[2])
    annotation (Line(points={{616,-58},{644,-58},{644,-50}},
                                                       color={0,127,255}));
  connect(senMasFlo_GridCool.port_a, jun1.port_1)
    annotation (Line(points={{596,-58},{580,-58}},
                                               color={0,127,255}));
  connect(jun.port_2, senMasFlo_HeatPump.port_a) annotation (Line(points={{-146,
          -60},{-106,-60},{-106,-122},{-88,-122}}, color={0,127,255}));
  connect(senMasFlo_HeatPump.port_b, pumpHeatingGrid.port_a) annotation (Line(
        points={{-68,-122},{-54,-122},{-54,-123}}, color={0,127,255}));
  connect(senMasFlo_chiller.port_b, pumpCooling.port_a)
    annotation (Line(points={{302,-10},{250,-10}},
                                               color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-258,-60},{-258,-60}},
                                                 color={0,127,255}));
  connect(sum.y, powerConsumptionSubstation) annotation (Line(points={{-211,258},
          {-272,258}},                            color={0,0,127}));

  connect(pumpCooling.port_b, chi.port_a1) annotation (Line(points={{218,-10},
          {192,-10},{192,33.2},{150,33.2}},
                                      color={0,127,255}));
  connect(jun_DC.port_2, senMasFlo_chiller.port_a) annotation (Line(points={{378,-8},
          {350,-8},{350,-10},{322,-10}},         color={0,127,255}));
  connect(chi.port_b1, jun_DC1.port_1) annotation (Line(points={{86,33.2},{14,
          33.2},{14,-8},{-28,-8}},   color={0,127,255}));

  connect(PumpCoolingDirect.port_b, jun_DC3.port_1) annotation (Line(points={{385,104},
          {386,104},{386,100},{384,100},{384,210},{236,210}},    color={0,127,255}));

  //Power Consumptin Calculation
  connect(chi.P, sum.u[1]);
  connect(heatPump.P_el, sum.u[2]);
  //connect(pumpCooling.P, sum.u[3]);
  //connect(pumpHeatingGrid.P, sum.u[4]);

  renewablePowerConsumptionSubstation = min(chi.P + heatPump.P_el, FreeElectricity);

  connect(COP.y, COP_HP)
    annotation (Line(points={{-221,164},{-270,164}}, color={0,0,127}));

  connect(senTem_HE_Cooling_out.port_b, jun_DC2.port_1)
    annotation (Line(points={{50,210},{8,210}},  color={0,127,255}));

  connect(chi.P, powerConsumptionChiller) annotation (Line(points={{82.8,50},
          {-90,50},{-90,204},{-270,204}},
                                     color={0,0,127}));
  connect(PEle1.y, P_max_HP) annotation (Line(points={{-189,100},{-226,100},{-226,
          123},{-269,123}}, color={0,0,127}));
  connect(senTem_Storage_top.port_a,substationStorageHeating. port_a)
    annotation (Line(points={{4,-298},{196,-298},{196,-298.162},{240,-298.162}},
                      color={0,127,255}));
  connect(PumpCoolingDirect.port_a, jun_DC.port_3) annotation (Line(points={{385,78},
          {388,78},{388,2}},             color={0,127,255}));
  connect(senTem_DC_in.port_b, jun_DC.port_1) annotation (Line(points={{446,-2},
          {424,-2},{424,-8},{398,-8}},   color={0,127,255}));
  connect(senTem_DC_in.port_a, jun1.port_2) annotation (Line(points={{466,-2},{513,
          -2},{513,-58},{560,-58}}, color={0,127,255}));
  connect(jun_DC2.port_2, jun_DC1.port_3)
    annotation (Line(points={{-12,210},{-38,210},{-38,2}},
                                                         color={0,127,255}));
  connect(chi.P, massFlowControllerCooling.P_chiller) annotation (Line(points={{82.8,50},
          {50,50},{50,174},{540,174},{540,179.933},{558.72,179.933}},
                     color={0,0,127}));
  connect(massFlowControllerCooling.CoolingDemand, coolingDemand) annotation (
     Line(points={{558.56,169.822},{615.28,169.822},{615.28,178},{680,178}},
        color={0,0,127}));
  connect(massFlowControllerCooling.deltaT_CoolingGridSet,
    deltaT_coolingGridSet) annotation (Line(points={{558.88,161.422},{614.44,
          161.422},{614.44,134},{680,134}}, color={0,0,127}));
  connect(massFlowControllerCooling.T_Grid_in, senTem_DC_in.T) annotation (
      Line(points={{558.56,153.022},{558.56,154},{600,154},{600,92},{456,92},{
          456,9}},  color={0,0,127}));
  connect(massFlowControllerCooling.T_supplyCoolingSet, T_supplyCoolingSet)
    annotation (Line(points={{558.56,134.356},{612.28,134.356},{612.28,220},{
          678,220}}, color={0,0,127}));
  connect(massFlowControllerCooling.m_chiller, pumpCooling.m_flow_in)
    annotation (Line(points={{473.76,179.467},{352.88,179.467},{352.88,6.8},{
          234,6.8}}, color={0,0,127}));
  connect(massFlowControllerCooling.m_dc, PumpCoolingDirect.m_flow_in)
    annotation (Line(points={{473.12,153.644},{439.56,153.644},{439.56,91},{
          400.6,91}}, color={0,0,127}));
  connect(massFlowControllerCooling.m_ch_he, PumpCoolingChiller.m_flow_in)
    annotation (Line(points={{473.28,144.778},{335.64,144.778},{335.64,135},{
          19.2,135}},  color={0,0,127}));
  connect(massFlowControllerCooling.T_set_Chiller, chi.TSet) annotation (Line(
        points={{473.28,136.378},{316.64,136.378},{316.64,24.8},{156.4,24.8}},
        color={0,0,127}));
  connect(Temp_SupplyHeatingSet_Storage.y, switch1.u1) annotation (Line(
        points={{319,-184},{308,-184},{308,-192},{296,-192}}, color={0,0,127}));
  connect(senTem_HP_in.port_b, senMasFlo_hp_in.port_a) annotation (Line(
        points={{496,-162},{452,-162}},                       color={0,127,
          255}));
  connect(senTem_HP_out.port_b, jun_heatsink.port_1) annotation (Line(points={{-14,
          -162},{-106,-162},{-106,-288}},       color={0,127,255}));
  connect(senTem_HE_Cooling_out.port_a, vol2.ports[1]) annotation (Line(
        points={{70,210},{114,210}},                   color={0,127,255}));
  connect(vol2.heatPort, prescribedHeatFlow.port) annotation (Line(points={{106,220},
          {102,220},{102,256}},          color={191,0,0}));
  connect(coolingDemand, prescribedHeatFlow.Q_flow) annotation (Line(points={{680,178},
          {636,178},{636,282},{102,282},{102,276}},           color={0,0,127}));
  connect(senTem_HP_out1.port_b, jun1.port_3) annotation (Line(points={{242,
          -122},{570,-122},{570,-68}},           color={0,127,255}));
  connect(jun_DC1.port_2, senTem_DC_in1.port_a)
    annotation (Line(points={{-48,-8},{-98,-8}}, color={0,127,255}));
  connect(senTem_DC_in1.port_b, jun.port_3) annotation (Line(points={{-118,-8},{
          -156,-8},{-156,-50}},              color={0,127,255}));
  connect(gain.y, prescribedHeatFlow1.Q_flow) annotation (Line(points={{151,
          -652},{168,-652}},               color={0,0,127}));
  connect(gain.u, heatDemand) annotation (Line(points={{128,-652},{-280,-652}},
                                 color={0,0,127}));
  connect(substationStorageHeating.port_b, senMasFlo_sinkStorage.port_a)
    annotation (Line(points={{328,-298.162},{356,-298.162},{356,-298},{384,-298}},
                  color={0,127,255}));
  connect(senMasFlo_sinkStorage.port_b, senTem_Storage_bottom.port_b)
    annotation (Line(points={{404,-298},{440,-298}},
        color={0,127,255}));
  connect(prescribedHeatFlow1.port, heatExchanger_heating.heatPort)
    annotation (Line(points={{188,-652},{208,-652},{208,-604},{218,-604}},
        color={191,0,0}));
  connect(Temp_SupplyHeatingSet_HeatEx.y, switch1.u3) annotation (Line(points=
         {{319,-216},{306,-216},{306,-208},{296,-208}}, color={0,0,127}));
  connect(senTem_Storage_top.port_b, jun_heatsink.port_3)
    annotation (Line(points={{-30,-298},{-96,-298}}, color={0,127,255}));
  connect(senTem_HE_heat_in.port_a, heatExchanger_heating.ports[1])
    annotation (Line(points={{198,-594},{226,-594}}, color={0,127,255}));
  connect(senTem_HE_heat_out.port_b, heatExchanger_heating.ports[2])
    annotation (Line(points={{256,-594},{230,-594}}, color={0,127,255}));
  connect(senTem_HE_heat_in.port_b, senMasFlo_he_in.port_a)
    annotation (Line(points={{178,-594},{68,-594}}, color={0,127,255}));
  connect(PumpCoolingChiller.port_b, chi.port_a2) annotation (Line(points={{
          -8.88178e-16,120},{2,120},{2,66.8},{86,66.8}}, color={0,127,255}));
  connect(chi.port_b2, jun_DC3.port_3) annotation (Line(points={{150,66.8},{
          226,66.8},{226,200}}, color={0,127,255}));
  connect(jun_DC2.port_3, PumpCoolingChiller.port_a) annotation (Line(points={{-2,200},
          {-2,150},{8.88178e-16,150}},                    color={0,127,255}));
  connect(senTem_DC_in2.port_a, jun_DC3.port_2) annotation (Line(points={{178,210},
          {216,210}},                          color={0,127,255}));
  connect(senTem_DC_in2.port_b, vol2.ports[2]) annotation (Line(points={{158,210},
          {118,210}},                          color={0,127,255}));
  connect(add2.u1, senTem_DC_in2.T) annotation (Line(points={{328,244},{168,
          244},{168,221}}, color={0,0,127}));
  connect(const1.y, add2.u2) annotation (Line(points={{277,222},{303.5,222},{
          303.5,232},{328,232}}, color={0,0,127}));
  connect(massFlowControllerCooling.T_HE_Cooling_out, add2.y) annotation (
      Line(points={{558.72,143.844},{592,143.844},{592,238},{351,238}}, color=
         {0,0,127}));
  connect(pumpHeatingGrid.port_b, heatPump.port_a1) annotation (Line(points={{-24,
          -123},{28,-123},{28,-123.2},{80,-123.2}}, color={0,127,255}));
  connect(heatPump.port_b1, senTem_HP_out1.port_a) annotation (Line(points={{144,
          -123.2},{178,-123.2},{178,-122},{212,-122}}, color={0,127,255}));
  connect(heatPump.port_a2, senMasFlo_hp_in.port_b) annotation (Line(points={{144,
          -162.8},{287,-162.8},{287,-162},{432,-162}}, color={0,127,255}));
  connect(senTem_HP_out.port_a, heatPump.port_b2) annotation (Line(points={{12,-162},
          {52,-162},{52,-162.8},{80,-162.8}}, color={0,127,255}));
  connect(powerConsumptionHP, heatPump.P_el) annotation (Line(points={{-268,230},
          {-90,230},{-90,-76},{178,-76},{178,-110.66},{146.56,-110.66}}, color={
          0,0,127}));
  connect(jun_heatsink.port_2, senMasFlo_he_in.port_b) annotation (Line(points={{-106,
          -308},{-108,-308},{-108,-594},{48,-594}},        color={0,127,255}));
  connect(FreeElectricity, massFlowControllerHeating.P_renewable) annotation (
     Line(points={{-278,-360},{-52,-360},{-52,-360.4},{-13.968,-360.4}},
        color={0,0,127}));
  connect(heatPump_COP.y, massFlowControllerHeating.COP) annotation (Line(
        points={{-73,-388},{-64,-388},{-64,-373.6},{-13.558,-373.6}}, color={0,0,
          127}));
  connect(storage_T_Top.y, massFlowControllerHeating.T_storageTop) annotation (
      Line(points={{-73,-430},{-50,-430},{-50,-395.385},{-13.722,-395.385}},
        color={0,0,127}));
  connect(heatDemand, massFlowControllerHeating.heat_Demand) annotation (Line(
        points={{-280,-652},{-30,-652},{-30,-425.477},{-13.722,-425.477}},
        color={0,0,127}));
  connect(storage_T_Bot.y, massFlowControllerHeating.T_storageBottom)
    annotation (Line(points={{-73,-416},{-54,-416},{-54,-386.154},{-13.722,
          -386.154}},
        color={0,0,127}));
  connect(deltaT_heatingGridSet, massFlowControllerHeating.deltaT_grid)
    annotation (Line(points={{-280,-614},{-36,-614},{-36,-417.354},{-13.558,
          -417.354}}, color={0,0,127}));
  connect(mass_flow_HeatExchanger.y, mass_flow_heatExchangerHeating.u3)
    annotation (Line(points={{361,-686},{378,-686},{378,-666},{392,-666}},
        color={0,0,127}));
  connect(booleanStep.y, mass_flow_heatExchangerHeating.u2)
    annotation (Line(points={{361,-658},{392,-658}}, color={255,0,255}));
  connect(senTem_Storage_bottom.port_a, pumpStorage.port_b)
    annotation (Line(points={{460,-298},{494,-298}}, color={0,127,255}));
  connect(pumpStorage.port_a, jun_heatsink1.port_3)
    annotation (Line(points={{528,-298},{564,-298}}, color={0,127,255}));
  connect(senTem_HE_heat_out.port_a, pumpHeating.port_b)
    annotation (Line(points={{276,-594},{430,-594}}, color={0,127,255}));
  connect(pumpHeating.port_a, jun_heatsink1.port_1) annotation (Line(points={
          {462,-594},{574,-594},{574,-308}}, color={0,127,255}));
  connect(massFlowControllerHeating.m_flow_storage, pumpStorage.m_flow_in)
    annotation (Line(points={{60.734,-397.231},{511,-397.231},{511,-319.6}},
        color={0,0,127}));
  connect(senTem_HP_in.port_a, jun_heatsink1.port_2) annotation (Line(points={{516,
          -162},{574,-162},{574,-288}}, color={0,127,255}));
  connect(sinkHeating.ports[1], jun_heatsink1.port_1) annotation (Line(points={{620,
          -342},{574,-342},{574,-308}},      color={0,127,255}));
  connect(setReturnTempHeating.y,substationStorageHeating. T_out_HE)
    annotation (Line(points={{198.8,-262},{218,-262},{218,-261.838},{236.975,
          -261.838}}, color={0,0,127}));
  connect(massFlowControllerHeating.Charging, switch1.u2) annotation (Line(
        points={{60.57,-367.138},{348,-367.138},{348,-200},{296,-200}}, color=
         {255,0,255}));
  connect(m_flow_gridPumpHeating.y, pumpHeatingGrid.m_flow_in) annotation (Line(
        points={{-59,-180},{-39,-180},{-39,-143.4}}, color={0,0,127}));
  connect(mass_flow_heatExchangerHeating.y, pumpHeating.m_flow_in)
    annotation (Line(points={{415,-658},{446,-658},{446,-615.6}}, color={0,0,
          127}));
  connect(mass_flow_HeatExchangerStart.y, mass_flow_heatExchangerHeating.u1)
    annotation (Line(points={{361,-632},{376,-632},{376,-650},{392,-650}},
        color={0,0,127}));
  connect(senTem_HE_heat_in.T, criticalDamping1.u) annotation (Line(points={{188,
          -583},{188,-558},{202,-558}},     color={0,0,127}));
  connect(criticalDamping.u, switch1.y) annotation (Line(points={{122,-200},{273,
          -200}},                           color={0,0,127}));
  connect(criticalDamping.y, heatPump.T_set_outlet) annotation (Line(points={{99,
          -200},{38,-200},{38,-110.66},{76.16,-110.66}}, color={0,0,127}));
  connect(heatPump_COP_char.y, massFlowControllerHeating.COP_charging)
    annotation (Line(points={{-73,-372},{-68,-372},{-68,-366.585},{-13.886,
          -366.585}}, color={0,0,127}));
  connect(chiller_power.y, massFlowControllerHeating.P_chiller) annotation (
      Line(points={{-73,-402},{-60,-402},{-60,-380.708},{-13.804,-380.708}},
        color={0,0,127}));
  connect(stenTemp_HpIn.y, massFlowControllerHeating.T_HP_in) annotation (
      Line(points={{-73,-464},{-40,-464},{-40,-409.785},{-13.394,-409.785}},
        color={0,0,127}));
  connect(m_flowHeatExHeating.y, massFlowControllerHeating.m_flow_heatExchanger)
    annotation (Line(points={{-73,-446},{-46,-446},{-46,-402.585},{-13.558,
          -402.585}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,-700},
            {660,300}}), graphics={
        Rectangle(
          extent={{-256,298},{660,-698}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-158,30},{448,-440}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-154,32},{144,272},{448,32},{-154,32}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-88,-42},{32,-150}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{90,-298},{186,-420}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{260,-50},{376,-160}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-700},{660,300}})),
    experiment(
      StopTime=360000,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li><i>April 15, 2020</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump, hot water storage tank, direct cooling and chiller. In the case of simultaneous cooling and heating demands, 
the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. 
This model uses the heat pump <a href=\"modelica://AixLib.Fluid.HeatPumps.Carnot_TCon\">AixLib.Fluid.HeatPumps.Carnot_TCon</a> 
and the chiller <a href=\"modelica://AixLib.Fluid.Chillers.Carnot_TEva\">AixLib.Fluid.Chillers.Carnot_TEva</a>.
The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end SubstationHeatingCooling_DC_CH_HP_HeatStorage;
