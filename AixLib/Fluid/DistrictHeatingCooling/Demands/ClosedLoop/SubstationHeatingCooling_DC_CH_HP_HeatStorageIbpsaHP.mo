within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationHeatingCooling_DC_CH_HP_HeatStorageIbpsaHP "Substation model for bidirctional low-temperature networks for buildings with 
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
    parameter Modelica.SIunits.Temperature T_coolingSupplySet "Supply Temperature of buildings cooling system, limit value for direct cooling system";
    parameter Modelica.SIunits.TemperatureDifference deltaT_coolingSet "Set temperature difference for cooling on the building site";

    parameter Modelica.SIunits.Volume VTan=heatDemand_max/(cp_default * rho * deltaT_heatingSet)*(2*3600) "Tank volume (default: discharge 1 h with max heat demand)";
    parameter Modelica.SIunits.Temperature T_storage_max "Max. Storage Temperatur for charging";
    parameter Modelica.SIunits.Temperature T_storage_min "Min. Storage Temperatur for discharging";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = max(heatDemand_max/(cp_default*deltaT_heatingSet),-coolingDemand_max/(cp_default*deltaT_coolingSet))
    "Nominal mass flow rate";
    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

  Modelica.Blocks.Interfaces.RealInput T_supplyCoolingSet(unit="K")
    "Supply temperatur of cooling circuit in the building" annotation (
      Placement(transformation(extent={{696,218},{656,258}}),
        iconTransformation(extent={{-322,-216},{-260,-154}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit="W")
    "Input for cooling demand profile of substation" annotation (Placement(
        transformation(extent={{700,158},{660,198}}),
                                                    iconTransformation(extent={{-322,
            -316},{-260,-254}})));
  Modelica.Blocks.Interfaces.RealInput deltaT_coolingGridSet(unit="K")
    "Set temperature difference for cooling on the site of thermal network"                                                           annotation (
      Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={680,94}),    iconTransformation(extent={{-324,-434},{-258,-368}})));
  Modelica.Blocks.Interfaces.RealInput FreeElectricity(unit="W")
    "Amount of available electricity in W"             annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-282,-354}), iconTransformation(extent={{720,-388},{660,-328}})));
  Modelica.Blocks.Interfaces.RealInput deltaT_heatingGridSet(unit="K")
    "Set temperature difference for heating on the site of thermal network"
                                                          annotation (
      Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-280,-536}), iconTransformation(extent={{716,-20},{656,40}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit="W")
    "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-296,-672},{-256,-632}}),
        iconTransformation(extent={{716,48},{660,104}})));
  BaseClasses.SubstationStorageHeating                                   substationStorageHeating(
    T_min(displayUnit="K") = T_storage_min,
    T_max(displayUnit="K") = T_storage_max,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_heating,
    T_start(displayUnit="degC") = T_storage_min,
    VTan=VTan)
    annotation (Placement(transformation(extent={{238,-312},{326,-248}})));
public
  HeatPumps.Carnot_TCon       heatPump(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    QCon_flow_nominal=heatDemand_max,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.55,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    QCon_flow_max=heatDemand_max)
    annotation (Placement(transformation(extent={{146,-112},{82,-178}})));
  Chillers.Carnot_TEva              chi(
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
public
  BaseClasses.MassFlowControllerHeating                                   massFlowControllerHeating(
    deltaT_he=deltaT_heatingSet,
    T_storage_min=T_storage_min,
    T_storage_max=T_storage_max,
    deltaT_heatingSet=deltaT_heatingSet,
    m_flow_nominal=m_flow_nominal,
    capacity=heatPump.QCon_flow_nominal)
    annotation (Placement(transformation(extent={{-12,-430},{70,-358}})));
  Sensors.MassFlowRate              senMasFlo_he_in(redeclare package Medium =
        Medium, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{68,-604},{48,-584}})));
  Sensors.TemperatureTwoPort              senTem_HE_heat_in(
    m_flow_nominal=m_flow_nominal_heating,
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=1,
    T_start(displayUnit="K") = T_heatingSupplySet)
                              annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={188,-594})));
  Delays.DelayFirstOrder              heatExchanger_heating(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_heating,
    nPorts=2,
    allowFlowReversal=false,
    tau=60,
    T_start=T_heatingSupplySet)
    "represents heat exchanger of buildings heating system"
    annotation (Placement(transformation(extent={{218,-594},{238,-614}})));
  Sensors.TemperatureTwoPort              senTem_HE_heat_out(
    m_flow_nominal=m_flow_nominal_heating,
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=1,
    T_start(displayUnit="degC") = T_heatingSupplySet - deltaT_heatingSet)
    annotation (Placement(transformation(extent={{276,-604},{256,-584}})));
  Movers.FlowControlled_m_flow              pumpHeating(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=318.15,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal_heating,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{462,-576},{430,-612}})));
    Modelica.Blocks.Sources.RealExpression mass_flow_HeatExchangerStart(y=-
        heatDemand/(cp_default*(criticalDamping1.y - (T_heatingSupplySet -
        deltaT_heatingSet))))
    "mass flow through heat exchanger at start"
    annotation (Placement(transformation(extent={{340,-642},{360,-622}})));
    Modelica.Blocks.Sources.RealExpression mass_flow_HeatExchanger(y=-
        heatDemand/(cp_default*(deltaT_heatingSet)))
                                      "mass flow through heat exchanger"
    annotation (Placement(transformation(extent={{340,-696},{360,-676}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{394,-668},{414,-648}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=3600)
    annotation (Placement(transformation(extent={{340,-668},{360,-648}})));
  Sensors.TemperatureTwoPort              senTem_Storage_top(
    m_flow_nominal=m_flow_nominal_heating,
    T_start(displayUnit="K") = Medium.T_default,
    redeclare package Medium = Medium,
    tau=10)
    annotation (Placement(transformation(extent={{4,-310},{-30,-286}})));
  Modelica.Blocks.Sources.Constant setReturnTempHeating(k=T_heatingSupplySet -
        deltaT_heatingSet)
    "Setelaving temperature of heat exchanger (return temperature of buildings heating system) "
    annotation (Placement(transformation(extent={{182,-270},{198,-254}})));
  Sources.Boundary_pT              sinkHeating(
    redeclare package Medium = Medium,
    use_T_in=false,
    T=273.15 + 45,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={626,-340})));
  Sensors.MassFlowRate              senMasFlo_sinkStorage(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{384,-308},{404,-288}})));
  Sensors.TemperatureTwoPort              senTem_Storage_bottom(
    m_flow_nominal=m_flow_nominal_heating,
    T_start(displayUnit="K") = Medium.T_default,
    redeclare package Medium = Medium,
    tau=1)
    annotation (Placement(transformation(extent={{460,-308},{440,-288}})));
  Movers.FlowControlled_m_flow              pumpStorage(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=318.15,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{528,-280},{494,-316}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping1(f=1/60)
    annotation (Placement(transformation(extent={{204,-568},{224,-548}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=T_heatingSupplySet,
    f=1/60)
    annotation (Placement(transformation(extent={{236,-210},{216,-190}})));
    Modelica.Blocks.Sources.RealExpression Temp_SupplyHeatingSet_HeatEx(y=
        T_heatingSupplySet)
    annotation (Placement(transformation(extent={{340,-226},{320,-206}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{294,-210},{274,-190}})));
  Modelica.Blocks.Sources.RealExpression Temp_SupplyHeatingSet_Storage(y=
        T_storage_max)
    annotation (Placement(transformation(extent={{340,-194},{320,-174}})));
  Sensors.TemperatureTwoPort              senTem_HP_out(
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K"),
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=1)
    annotation (Placement(transformation(extent={{22,-176},{-4,-148}})));
  Sensors.MassFlowRate              senMasFlo_hp_in(redeclare package Medium =
        Medium, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{452,-172},{432,-152}})));
  Sensors.TemperatureTwoPort              senTem_HP_in(
    T_start(displayUnit="K"),
    m_flow_nominal=m_flow_nominal_heating,
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=1)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={506,-162})));
  Sensors.TemperatureTwoPort              senTem_HP_out1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    T_start(displayUnit="K"),
    tau=1)
    annotation (Placement(transformation(extent={{212,-132},{242,-112}})));
  Movers.FlowControlled_m_flow              pumpHeatingGrid(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-54,-106},{-24,-140}})));
  Sensors.MassFlowRate              senMasFlo_HeatPump(redeclare package Medium =
        Medium, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-88,-132},{-68,-112}})));
  Delays.DelayFirstOrder              vol(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60,
    nPorts=2)
             annotation (Placement(transformation(extent={{-238,-52},{-218,
            -32}})));
  FixedResistances.Junction              jun(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    verifyFlowReversal=false,
    tau=5)
    annotation (Placement(transformation(extent={{-166,-50},{-146,-70}})));
  Sensors.MassFlowRate              senMasFlo_GridHeat(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-204,-70},{-184,-50}})));
  Sensors.TemperatureTwoPort              senTem_DC_in1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K"),
    tau=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-108,-8})));
public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-268,-70},{-248,-50}})));
  FixedResistances.Junction              jun_DC1(
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
  Movers.FlowControlled_m_flow              pumpCooling(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{250,-24},{218,4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{654,-68},{674,-48}}),
        iconTransformation(extent={{654,-68},{674,-48}})));
  Delays.DelayFirstOrder              vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{632,-50},{652,-30}})));
  Sensors.MassFlowRate              senMasFlo_GridCool(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{596,-68},{616,-48}})));
  FixedResistances.Junction              jun1(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    verifyFlowReversal=false,
    tau=5)
    annotation (Placement(transformation(extent={{580,-68},{560,-48}})));
  Sensors.TemperatureTwoPort              senTem_DC_in(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K"),
    tau=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={456,-10})));
  BaseClasses.MassFlowControllerCooling
    massFlowControllerCooling(
    T_max_directCooling=T_coolingSupplySet,
    deltaT_coolingSet=deltaT_coolingSet,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{556,130},{476,186}})));
  FixedResistances.Junction              jun_DC(
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
        origin={388,-10})));
  Sensors.MassFlowRate              senMasFlo_chiller(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{322,-20},{302,0}})));
  Movers.FlowControlled_m_flow              PumpCoolingDirect(
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
  Delays.DelayFirstOrder              vol2(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_cooling,
    T_start=T_coolingSupplySet,
    tau=60)  annotation (Placement(transformation(extent={{106,208},{126,228}})));
  FixedResistances.Junction              jun_DC2(
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
  Movers.FlowControlled_m_flow              PumpCoolingChiller(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal_cooling,
    allowFlowReversal=false,
    tau=60)                        annotation (Placement(transformation(
        extent={{15,16},{-15,-16}},
        rotation=90,
        origin={-2,135})));
  Sensors.TemperatureTwoPort              senTem_DC_in2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start(displayUnit="K") = T_coolingSupplySet,
    tau=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={168,210})));
  FixedResistances.Junction              jun_DC3(
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
    Modelica.Blocks.Math.Add add2(k1=+1, k2=+1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={340,238})));
  Modelica.Blocks.Sources.Constant const1(k=deltaT_coolingSet)
    annotation (Placement(transformation(extent={{256,212},{276,232}})));
  Modelica.Blocks.Math.Sum sum(nin=2)
    annotation (Placement(transformation(extent={{-190,248},{-210,268}})));
  Modelica.Blocks.Sources.RealExpression COP(y=heatPump.COP) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-210,164})));
  Modelica.Blocks.Interfaces.RealOutput powerConsumptionHP(unit="W")
  "Power consumption of heat pum in Watt"
    annotation (Placement(transformation(extent={{-258,220},{-278,240}}),
        iconTransformation(extent={{-260,142},{-296,178}})));
  Modelica.Blocks.Interfaces.RealOutput powerConsumptionChiller(unit="W")
  "Power consumption of chiller in Watt"
    annotation (Placement(transformation(extent={{-260,194},{-280,214}}),
        iconTransformation(extent={{-260,98},{-296,134}})));
  Modelica.Blocks.Interfaces.RealOutput powerConsumptionSubstation(unit="W")
    annotation (Placement(transformation(extent={{-262,248},{-282,268}}),
        iconTransformation(extent={{-260,222},{-294,256}})));
  Modelica.Blocks.Interfaces.RealOutput COP_HP
  "COP of heat pump" annotation (Placement(
        transformation(extent={{-260,154},{-280,174}}), iconTransformation(
          extent={{-260,12},{-296,48}})));
  Modelica.Blocks.Interfaces.RealOutput P_max_HP annotation (Placement(
        transformation(extent={{-260,114},{-278,132}}), iconTransformation(
          extent={{-260,56},{-296,92}})));
  Modelica.Blocks.Interfaces.RealOutput renewablePowerConsumptionSubstation(unit="W")
  "Renewable power consumption of chiller based on difference between total power use and available renewable power"
    annotation (Placement(transformation(extent={{-260,280},{-280,300}}),
        iconTransformation(extent={{-260,184},{-294,218}})));
public
  Sensors.TemperatureTwoPort              senTem_HE_Cooling_out(
    redeclare package Medium = Medium,
    T_start(displayUnit="K") = T_coolingSupplySet + deltaT_coolingSet,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    tau=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={60,210})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={102,266})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={136,-652})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{44,-662},{64,-642}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay(delayTime=60)
    annotation (Placement(transformation(extent={{370,-206},{356,-192}})));
  Delays.DelayFirstOrder              vol3(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60,
    nPorts=3,
    T_start=T_heatingSupplySet)
             annotation (Placement(transformation(extent={{-82,-302},{-62,-282}})));
  Delays.DelayFirstOrder              vol4(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60,
    nPorts=3)
             annotation (Placement(transformation(extent={{560,-300},{580,-280}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping2(f=1/60)
    annotation (Placement(transformation(extent={{206,246},{226,266}})));
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
  Modelica.Blocks.Sources.RealExpression heatPump_COP_char(y=heatPump.etaCarnot_nominal
        *((T_storage_max + 2)/((T_storage_max + 2) - (senTem_HP_out1.T - 2))))
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
protected
  Modelica.Blocks.Sources.RealExpression PEle1(y=heatDemand_max/4)
    "Maximum electrical power consumption"
    annotation (Placement(transformation(extent={{-168,90},{-188,110}})));
protected
  Modelica.Blocks.Sources.RealExpression m_flow_gridPumpHeating(y=max(0, -
        heatPump.QEva_flow/(4180*deltaT_heatingGridSet)))
    "Input of mass flow for heating grid pump"
    annotation (Placement(transformation(extent={{-80,-190},{-60,-170}})));
equation

  renewablePowerConsumptionSubstation = min(chi.P + heatPump.P, FreeElectricity);

  //Power Consumptin Calculation
  connect(chi.P, sum.u[1]);
  connect(heatPump.P, sum.u[2]);

  connect(FreeElectricity,massFlowControllerHeating. P_renewable) annotation (
     Line(points={{-282,-354},{-52,-354},{-52,-360.4},{-13.968,-360.4}},
        color={0,0,127}));
  connect(heatPump_COP.y,massFlowControllerHeating. COP) annotation (Line(
        points={{-73,-388},{-64,-388},{-64,-373.6},{-13.558,-373.6}}, color={0,0,
          127}));
  connect(storage_T_Top.y,massFlowControllerHeating. T_storageTop) annotation (
      Line(points={{-73,-430},{-50,-430},{-50,-395.385},{-13.722,-395.385}},
        color={0,0,127}));
  connect(heatDemand,massFlowControllerHeating. heat_Demand) annotation (Line(
        points={{-276,-652},{-30,-652},{-30,-425.477},{-13.722,-425.477}},
        color={0,0,127}));
  connect(storage_T_Bot.y,massFlowControllerHeating. T_storageBottom)
    annotation (Line(points={{-73,-416},{-54,-416},{-54,-386.154},{-13.722,
          -386.154}},
        color={0,0,127}));
  connect(deltaT_heatingGridSet,massFlowControllerHeating. deltaT_grid)
    annotation (Line(points={{-280,-536},{-36,-536},{-36,-417.354},{-13.558,
          -417.354}}, color={0,0,127}));
  connect(heatPump_COP_char.y,massFlowControllerHeating. COP_charging)
    annotation (Line(points={{-73,-372},{-68,-372},{-68,-366.585},{-13.886,
          -366.585}}, color={0,0,127}));
  connect(chiller_power.y,massFlowControllerHeating. P_chiller) annotation (
      Line(points={{-73,-402},{-60,-402},{-60,-380.708},{-13.804,-380.708}},
        color={0,0,127}));
  connect(stenTemp_HpIn.y,massFlowControllerHeating. T_HP_in) annotation (
      Line(points={{-73,-464},{-40,-464},{-40,-409.785},{-13.394,-409.785}},
        color={0,0,127}));
  connect(m_flowHeatExHeating.y,massFlowControllerHeating. m_flow_heatExchanger)
    annotation (Line(points={{-73,-446},{-46,-446},{-46,-402.585},{-13.558,
          -402.585}}, color={0,0,127}));
  connect(mass_flow_HeatExchanger.y,mass_flow_heatExchangerHeating. u3)
    annotation (Line(points={{361,-686},{378,-686},{378,-666},{392,-666}},
        color={0,0,127}));
  connect(booleanStep.y,mass_flow_heatExchangerHeating. u2)
    annotation (Line(points={{361,-658},{392,-658}}, color={255,0,255}));
  connect(mass_flow_heatExchangerHeating.y, pumpHeating.m_flow_in)
    annotation (Line(points={{415,-658},{446,-658},{446,-615.6}}, color={0,0,
          127}));
  connect(mass_flow_HeatExchangerStart.y,mass_flow_heatExchangerHeating. u1)
    annotation (Line(points={{361,-632},{376,-632},{376,-650},{392,-650}},
        color={0,0,127}));
  connect(senMasFlo_he_in.port_a, senTem_HE_heat_in.port_b)
    annotation (Line(points={{68,-594},{178,-594}}, color={0,127,255}));
  connect(senTem_HE_heat_in.port_a, heatExchanger_heating.ports[1])
    annotation (Line(points={{198,-594},{226,-594}}, color={0,127,255}));
  connect(heatExchanger_heating.ports[2], senTem_HE_heat_out.port_b)
    annotation (Line(points={{230,-594},{244,-594},{244,-594},{256,-594}},
        color={0,127,255}));
  connect(senTem_HE_heat_out.port_a, pumpHeating.port_b) annotation (Line(
        points={{276,-594},{352,-594},{352,-594},{430,-594}}, color={0,127,255}));
  connect(senTem_Storage_top.port_a, substationStorageHeating.port_a)
    annotation (Line(points={{4,-298},{122,-298},{122,-298.162},{238,-298.162}},
        color={0,127,255}));
  connect(setReturnTempHeating.y, substationStorageHeating.T_out_HE)
    annotation (Line(points={{198.8,-262},{218,-262},{218,-261.838},{234.975,
          -261.838}},
        color={0,0,127}));
  connect(senTem_Storage_bottom.port_a, pumpStorage.port_b)
    annotation (Line(points={{460,-298},{494,-298}}, color={0,127,255}));
  connect(senMasFlo_sinkStorage.port_b, senTem_Storage_bottom.port_b)
    annotation (Line(points={{404,-298},{440,-298}}, color={0,127,255}));
  connect(substationStorageHeating.port_b, senMasFlo_sinkStorage.port_a)
    annotation (Line(points={{326,-298.162},{356,-298.162},{356,-298},{384,-298}},
        color={0,127,255}));
  connect(senTem_HE_heat_in.T, criticalDamping1.u) annotation (Line(points={{188,
          -583},{188,-558},{202,-558}}, color={0,0,127}));
  connect(Temp_SupplyHeatingSet_Storage.y,switch1. u1) annotation (Line(
        points={{319,-184},{308,-184},{308,-192},{296,-192}}, color={0,0,127}));
  connect(Temp_SupplyHeatingSet_HeatEx.y,switch1. u3) annotation (Line(points=
         {{319,-216},{306,-216},{306,-208},{296,-208}}, color={0,0,127}));
  connect(massFlowControllerHeating.m_flow_storage, pumpStorage.m_flow_in)
    annotation (Line(points={{60.734,-397.231},{511,-397.231},{511,-319.6}},
        color={0,0,127}));
  connect(senMasFlo_hp_in.port_a, senTem_HP_in.port_b)
    annotation (Line(points={{452,-162},{496,-162}}, color={0,127,255}));
  connect(senMasFlo_GridHeat.port_b, jun.port_1) annotation (Line(points={{-184,
          -60},{-176,-60},{-176,-60},{-166,-60}}, color={0,127,255}));
  connect(jun.port_2, senMasFlo_HeatPump.port_a) annotation (Line(points={{-146,
          -60},{-126,-60},{-126,-122},{-88,-122}}, color={0,127,255}));
  connect(senMasFlo_HeatPump.port_b, pumpHeatingGrid.port_a) annotation (Line(
        points={{-68,-122},{-62,-122},{-62,-123},{-54,-123}}, color={0,127,255}));
  connect(jun.port_3, senTem_DC_in1.port_b) annotation (Line(points={{-156,-50},
          {-154,-50},{-154,-8},{-118,-8}}, color={0,127,255}));
  connect(senTem_DC_in1.port_a, jun_DC1.port_2) annotation (Line(points={{-98,-8},
          {-74,-8},{-74,-8},{-48,-8}}, color={0,127,255}));
  connect(port_a, vol.ports[1]) annotation (Line(points={{-258,-60},{-230,-60},{
          -230,-52}}, color={0,127,255}));
  connect(senMasFlo_GridHeat.port_a, vol.ports[2]) annotation (Line(points={{-204,
          -60},{-226,-60},{-226,-52}}, color={0,127,255}));
  connect(vol1.ports[1], port_b) annotation (Line(points={{640,-50},{640,-58},{664,
          -58}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_b, vol1.ports[2]) annotation (Line(points={{616,
          -58},{644,-58},{644,-50}}, color={0,127,255}));
  connect(jun1.port_1, senMasFlo_GridCool.port_a)
    annotation (Line(points={{580,-58},{596,-58}}, color={0,127,255}));
  connect(const1.y,add2. u2) annotation (Line(points={{277,222},{303.5,222},{
          303.5,232},{328,232}}, color={0,0,127}));
  connect(add2.y, massFlowControllerCooling.T_HE_Cooling_out) annotation (Line(
        points={{351,238},{596,238},{596,143.844},{558.72,143.844}}, color={0,0,
          127}));
  connect(sum.y,powerConsumptionSubstation)  annotation (Line(points={{-211,258},
          {-272,258}},                            color={0,0,127}));
  connect(COP.y,COP_HP)
    annotation (Line(points={{-221,164},{-270,164}}, color={0,0,127}));
  connect(PEle1.y,P_max_HP)  annotation (Line(points={{-189,100},{-226,100},{-226,
          123},{-269,123}}, color={0,0,127}));
  connect(chi.P, powerConsumptionChiller) annotation (Line(points={{82.8,50},{36,
          50},{36,62},{-120,62},{-120,206},{-270,206},{-270,204}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, vol2.heatPort)
    annotation (Line(points={{102,256},{102,218},{106,218}}, color={191,0,0}));
  connect(jun_DC2.port_1, senTem_HE_Cooling_out.port_b)
    annotation (Line(points={{8,210},{50,210}}, color={0,127,255}));
  connect(senTem_HE_Cooling_out.port_a, vol2.ports[1]) annotation (Line(points={
          {70,210},{92,210},{92,208},{114,208}}, color={0,127,255}));
  connect(vol2.ports[2], senTem_DC_in2.port_b) annotation (Line(points={{118,208},
          {136,208},{136,210},{158,210}}, color={0,127,255}));
  connect(senTem_DC_in2.port_a, jun_DC3.port_2)
    annotation (Line(points={{178,210},{216,210}}, color={0,127,255}));
  connect(prescribedHeatFlow.Q_flow, coolingDemand) annotation (Line(points={{102,
          276},{102,292},{626,292},{626,178},{680,178}}, color={0,0,127}));
  connect(massFlowControllerCooling.CoolingDemand, coolingDemand) annotation (
      Line(points={{558.56,169.822},{586,169.822},{586,178},{680,178}}, color={0,
          0,127}));
  connect(chi.port_b2, jun_DC3.port_3) annotation (Line(points={{150,66.8},{226,
          66.8},{226,200}}, color={0,127,255}));
  connect(jun_DC3.port_1, PumpCoolingDirect.port_b) annotation (Line(points={{236,
          210},{385,210},{385,104}}, color={0,127,255}));
  connect(jun_DC2.port_3, PumpCoolingChiller.port_a)
    annotation (Line(points={{-2,200},{-2,150}}, color={0,127,255}));
  connect(PumpCoolingChiller.port_b, chi.port_a2) annotation (Line(points={{-2,120},
          {-2,68},{86,68},{86,66.8}}, color={0,127,255}));
  connect(jun_DC2.port_2, jun_DC1.port_3) annotation (Line(points={{-12,210},{-22,
          210},{-22,212},{-38,212},{-38,2}}, color={0,127,255}));
  connect(jun_DC1.port_1, chi.port_b1) annotation (Line(points={{-28,-8},{18,-8},
          {18,33.2},{86,33.2}}, color={0,127,255}));
  connect(chi.port_a1, pumpCooling.port_b) annotation (Line(points={{150,33.2},{
          188,33.2},{188,-10},{218,-10}}, color={0,127,255}));
  connect(pumpCooling.port_a, senMasFlo_chiller.port_b)
    annotation (Line(points={{250,-10},{302,-10}}, color={0,127,255}));
  connect(senMasFlo_chiller.port_a, jun_DC.port_2)
    annotation (Line(points={{322,-10},{378,-10}}, color={0,127,255}));
  connect(chi.TSet, massFlowControllerCooling.T_set_Chiller) annotation (Line(
        points={{156.4,24.8},{258,24.8},{258,136.378},{473.28,136.378}}, color={
          0,0,127}));
  connect(PumpCoolingDirect.port_a, jun_DC.port_3) annotation (Line(points={{385,
          78},{386,78},{386,0},{388,0}}, color={0,127,255}));
  connect(jun_DC.port_1, senTem_DC_in.port_b)
    annotation (Line(points={{398,-10},{446,-10}}, color={0,127,255}));
  connect(senTem_DC_in.port_a, jun1.port_2) annotation (Line(points={{466,-10},{
          530,-10},{530,-58},{560,-58}}, color={0,127,255}));
  connect(senTem_HP_out1.port_b, jun1.port_3) annotation (Line(points={{242,-122},
          {570,-122},{570,-68}}, color={0,127,255}));
  connect(senTem_DC_in.T, massFlowControllerCooling.T_Grid_in) annotation (Line(
        points={{456,1},{456,40},{578,40},{578,153.022},{558.56,153.022}},
        color={0,0,127}));
  connect(chi.P, massFlowControllerCooling.P_chiller) annotation (Line(points={{82.8,50},
          {36,50},{36,192},{570,192},{570,179.933},{558.72,179.933}},
        color={0,0,127}));
  connect(massFlowControllerCooling.deltaT_CoolingGridSet,
    deltaT_coolingGridSet) annotation (Line(points={{558.88,161.422},{622,
          161.422},{622,94},{680,94}},
                                color={0,0,127}));
  connect(massFlowControllerCooling.T_supplyCoolingSet, T_supplyCoolingSet)
    annotation (Line(points={{558.56,134.356},{608,134.356},{608,238},{676,238}},
        color={0,0,127}));
  connect(pumpCooling.m_flow_in, massFlowControllerCooling.m_chiller)
    annotation (Line(points={{234,6.8},{234,180},{473.76,180},{473.76,179.467}},
        color={0,0,127}));
  connect(PumpCoolingChiller.m_flow_in, massFlowControllerCooling.m_ch_he)
    annotation (Line(points={{17.2,135},{132,135},{132,144.778},{473.28,144.778}},
        color={0,0,127}));
  connect(PumpCoolingDirect.m_flow_in, massFlowControllerCooling.m_dc)
    annotation (Line(points={{400.6,91},{430,91},{430,153.644},{473.12,153.644}},
        color={0,0,127}));
  connect(m_flow_gridPumpHeating.y, pumpHeatingGrid.m_flow_in) annotation (Line(
        points={{-59,-180},{-39,-180},{-39,-143.4}}, color={0,0,127}));
  connect(prescribedHeatFlow1.port, heatExchanger_heating.heatPort) annotation (
     Line(points={{146,-652},{208,-652},{208,-604},{218,-604}}, color={191,0,0}));
  connect(heatDemand, gain.u)
    annotation (Line(points={{-276,-652},{42,-652}}, color={0,0,127}));
  connect(gain.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{65,-652},{126,-652}}, color={0,0,127}));
  connect(senTem_HP_out.port_a, heatPump.port_b1) annotation (Line(points={{22,-162},
          {52,-162},{52,-164.8},{82,-164.8}}, color={0,127,255}));
  connect(heatPump.port_a1, senMasFlo_hp_in.port_b) annotation (Line(points={{146,
          -164.8},{216,-164.8},{216,-162},{432,-162}}, color={0,127,255}));
  connect(heatPump.port_b2, senTem_HP_out1.port_a) annotation (Line(points={{146,
          -125.2},{178,-125.2},{178,-122},{212,-122}}, color={0,127,255}));
  connect(pumpHeatingGrid.port_b, heatPump.port_a2) annotation (Line(points={{-24,
          -123},{29,-123},{29,-125.2},{82,-125.2}}, color={0,127,255}));
  connect(heatPump.TSet, criticalDamping.y) annotation (Line(points={{152.4,-174.7},
          {188,-174.7},{188,-200},{215,-200}}, color={0,0,127}));
  connect(criticalDamping.u, switch1.y)
    annotation (Line(points={{238,-200},{273,-200}}, color={0,0,127}));
  connect(switch1.u2, onDelay.y) annotation (Line(points={{296,-200},{326,-200},
          {326,-199},{354.6,-199}}, color={255,0,255}));
  connect(massFlowControllerHeating.Charging, onDelay.u) annotation (Line(
        points={{60.57,-367.138},{408,-367.138},{408,-199},{372.8,-199}}, color=
         {255,0,255}));
  connect(senTem_HP_out.port_b, vol3.ports[1]) annotation (Line(points={{-4,-162},
          {-4,-302},{-74.6667,-302}}, color={0,127,255}));
  connect(senTem_Storage_top.port_b, vol3.ports[2]) annotation (Line(points={{-30,
          -298},{-52,-298},{-52,-302},{-72,-302}}, color={0,127,255}));
  connect(vol3.ports[3], senMasFlo_he_in.port_b) annotation (Line(points={{
          -69.3333,-302},{-76,-302},{-76,-598},{48,-598},{48,-594}},
                                                            color={0,127,255}));
  connect(pumpStorage.port_a, vol4.ports[1]) annotation (Line(points={{528,-298},
          {550,-298},{550,-300},{567.333,-300}}, color={0,127,255}));
  connect(pumpHeating.port_a, vol4.ports[2]) annotation (Line(points={{462,-594},
          {570,-594},{570,-300}}, color={0,127,255}));
  connect(senTem_HP_in.port_a, vol4.ports[3]) annotation (Line(points={{516,
          -162},{542,-162},{542,-300},{572.667,-300}},
                                                 color={0,127,255}));
  connect(sinkHeating.ports[1], pumpHeating.port_a) annotation (Line(points={{616,
          -340},{592,-340},{592,-308},{570,-308},{570,-320},{462,-594}}, color={
          0,127,255}));
  connect(senTem_DC_in2.T, criticalDamping2.u)
    annotation (Line(points={{168,221},{168,256},{204,256}}, color={0,0,127}));
  connect(criticalDamping2.y, add2.u1) annotation (Line(points={{227,256},{318,256},
          {318,250},{328,250},{328,244}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,-720},
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
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-720},{660,300}})),
    Documentation(info="<html><p>
  Substation model for bidirctional low-temperature networks for
  buildings with heat pump, hot water storage tank, direct cooling and
  chiller. In the case of simultaneous cooling and heating demands, the
  return flows are used as supply flows for the other application. The
  mass flows are controlled equation-based. This model uses the heat
  pump <a href=
  \"modelica://AixLib.Fluid.HeatPumps.Carnot_TCon\">AixLib.Fluid.HeatPumps.Carnot_TCon</a>
  and the chiller <a href=
  \"modelica://AixLib.Fluid.Chillers.Carnot_TEva\">AixLib.Fluid.Chillers.Carnot_TEva</a>.
  The mass flows are calculated using the heating and cooling demands
  and the specified temperature differences between flow and return
  (network side).
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>April 15, 2020</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>"));
end SubstationHeatingCooling_DC_CH_HP_HeatStorageIbpsaHP;
