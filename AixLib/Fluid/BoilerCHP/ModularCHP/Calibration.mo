within AixLib.Fluid.BoilerCHP.ModularCHP;
package Calibration "CHP unit models edited for calibration tests"
  model CHP_DynamicUncalibrated
    "Test examplel of the modular CHP model before its dynamic calibration"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=0
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Evaluate=false,Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=5000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=0.3/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      inductionMachine(J_Gen=1),
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac)
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false,
      m_flow_start=0)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      dp1_nominal(displayUnit="kPa") = 10000,
      dp2_nominal(displayUnit="kPa") = 10000,
      eps=0.99)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit,
      T=T_HeaRet)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=3600,
      declarationTime(threshold=7200),
      modulationFactorControl(table=[0.0,0.8; 7200,0.8; 7200,0.92; 10800,0.92;
            10800,0.62; 14400,0.62; 14400,0.795; 18000,0.795; 18000,0.0]))
      annotation (Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel1(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,-36},{-92,-16}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
          points={{-92,10},{-60,10}},                 color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(heatingReturnFlow.T_in, tempFlowHeating.y)
      annotation (Line(points={{-112,-60},{-118,-60},{-118,-66},{-123,-66}},
                                                       color={0,0,127}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(modTim.y, simTime.u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y, simTime.u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(tempCoolantReturn.port_b, fixedPressureLevel1.ports[1]) annotation (
        Line(points={{-56,-40},{-70,-40},{-70,-26},{-92,-26}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StartTime=3600, StopTime=28800, Interval=5));
  end CHP_DynamicUncalibrated;

  model CHP_DynamicCalibrated
    "Test examplel of the modular CHP model after its dynamic calibration"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=40
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Evaluate=false,Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=120000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=0.3/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      inductionMachine(J_Gen=1, s_til=0.175),
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac)
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false,
      m_flow_start=0)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      dp1_nominal(displayUnit="kPa") = 10000,
      dp2_nominal(displayUnit="kPa") = 10000,
      eps=0.99)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit,
      T=T_HeaRet)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=3600,
      declarationTime(threshold=7200),
      modulationFactorControl(table=[0.0,0.8; 7200,0.8; 7200,0.92; 10800,0.92;
            10800,0.625; 14400,0.625; 14400,0.8; 18000,0.8; 18000,0.0]))
      annotation (Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel1(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,-36},{-92,-16}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
          points={{-92,10},{-60,10}},                 color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(heatingReturnFlow.T_in, tempFlowHeating.y)
      annotation (Line(points={{-112,-60},{-118,-60},{-118,-66},{-123,-66}},
                                                       color={0,0,127}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(modTim.y, simTime.u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y, simTime.u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(tempCoolantReturn.port_b, fixedPressureLevel1.ports[1]) annotation (
        Line(points={{-56,-40},{-70,-40},{-70,-26},{-92,-26}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StartTime=3600, StopTime=28800, Interval=5));
  end CHP_DynamicCalibrated;

  model CHP_Static_FullLoad
    "Test examplel of the modular CHP model for static operation at full load"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=5000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=0
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=volFlowVariation.y/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      inductionMachine(J_Gen=1, s_til=0.175),
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac)
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      dp1_nominal(displayUnit="kPa") = 10000,
      dp2_nominal(displayUnit="kPa") = 10000,
      eps=0.99)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=0,
      modulationFactorControl(table=[0.0,0.925; 108000,0.925])) annotation (
        Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    Modelica.Blocks.Sources.TimeTable tempRetVariation(table=[0.0,298.15; 7200,298.15;
          7200,303.15; 10800,303.15; 10800,308.15; 14400,308.15; 14400,313.15; 18000,
          313.15; 18000,318.15; 21600,318.15; 21600,298.15; 28800,298.15; 28800,303.15;
          32400,303.15; 32400,308.15; 36000,308.15; 36000,313.15; 39600,313.15; 39600,
          318.15; 43200,318.15; 43200,298.15; 50400,298.15; 50400,303.15; 54000,303.15;
          54000,308.15; 57600,308.15; 57600,313.15; 61200,313.15; 61200,318.15; 64800,
          318.15; 64800,298.15; 72000,298.15; 72000,303.15; 75600,303.15; 75600,308.15;
          79200,308.15; 79200,313.15; 82800,313.15; 82800,318.15; 86400,318.15; 86400,
          298.15; 93600,298.15; 93600,303.15; 97200,303.15; 97200,308.15; 100800,308.15;
          100800,313.15; 104400,313.15; 104400,318.15; 108000,318.15])
      annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Blocks.Sources.TimeTable volFlowVariation(table=[0.0,0.25; 21600,0.25;
          21600,0.3; 43200,0.3; 43200,0.35; 64800,0.35; 64800,0.4; 86400,0.4; 86400,
          0.45; 108000,0.45])
      annotation (Placement(transformation(extent={{-144,-32},{-124,-12}})));
    Modelica.Fluid.Sources.FixedBoundary fixedCoolingRetSink(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
          points={{-92,10},{-60,10}},                 color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(heatingReturnFlow.T_in, tempRetVariation.y) annotation (Line(points={{
            -112,-60},{-116,-60},{-116,-88},{-123,-88}}, color={0,0,127}));
    connect(modTim.y,simTime. u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y,simTime. u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(tempCoolantReturn.port_b, fixedCoolingRetSink.ports[1]) annotation (
        Line(points={{-56,-40},{-70,-40},{-70,-30},{-90,-30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StopTime=108000, Interval=100));
  end CHP_Static_FullLoad;

  model CHP_Static_75PercentLoad
    "Test examplel of the modular CHP model for static operation at about 75% load"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=5000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=0
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=volFlowVariation.y/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac,
      inductionMachine(J_Gen=1, s_til=0.175))
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      dp1_nominal(displayUnit="kPa") = 10000,
      dp2_nominal(displayUnit="kPa") = 10000,
      eps=0.99)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=0,
      modulationFactorControl(table=[0.0,0.795; 108000,0.795])) annotation (
        Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    Modelica.Blocks.Sources.TimeTable tempRetVariation(table=[0.0,298.15; 7200,298.15;
          7200,303.15; 10800,303.15; 10800,308.15; 14400,308.15; 14400,313.15; 18000,
          313.15; 18000,318.15; 21600,318.15; 21600,298.15; 28800,298.15; 28800,303.15;
          32400,303.15; 32400,308.15; 36000,308.15; 36000,313.15; 39600,313.15; 39600,
          318.15; 43200,318.15; 43200,298.15; 50400,298.15; 50400,303.15; 54000,303.15;
          54000,308.15; 57600,308.15; 57600,313.15; 61200,313.15; 61200,318.15; 64800,
          318.15; 64800,298.15; 72000,298.15; 72000,303.15; 75600,303.15; 75600,308.15;
          79200,308.15; 79200,313.15; 82800,313.15; 82800,318.15; 86400,318.15; 86400,
          298.15; 93600,298.15; 93600,303.15; 97200,303.15; 97200,308.15; 100800,308.15;
          100800,313.15; 104400,313.15; 104400,318.15; 108000,318.15])
      annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Blocks.Sources.TimeTable volFlowVariation(table=[0.0,0.25; 21600,0.25;
          21600,0.3; 43200,0.3; 43200,0.35; 64800,0.35; 64800,0.4; 86400,0.4; 86400,
          0.45; 108000,0.45])
      annotation (Placement(transformation(extent={{-144,-32},{-124,-12}})));
    Modelica.Fluid.Sources.FixedBoundary fixedCoolingRetSink(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
          points={{-92,10},{-60,10}},                 color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(heatingReturnFlow.T_in, tempRetVariation.y) annotation (Line(points={{
            -112,-60},{-116,-60},{-116,-88},{-123,-88}}, color={0,0,127}));
    connect(modTim.y,simTime. u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y,simTime. u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(tempCoolantReturn.port_b, fixedCoolingRetSink.ports[1]) annotation (
        Line(points={{-56,-40},{-70,-40},{-70,-30},{-90,-30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StopTime=108000, Interval=100));
  end CHP_Static_75PercentLoad;

  model CHP_Static_50PercentLoad
    "Test examplel of the modular CHP model for static operation at about 50% load"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=5000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=0
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=volFlowVariation.y/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac,
      inductionMachine(J_Gen=1, s_til=0.175))
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      dp1_nominal(displayUnit="kPa") = 10000,
      dp2_nominal(displayUnit="kPa") = 10000,
      eps=0.99)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=0,
      modulationFactorControl(table=[0.0,0.62; 108000,0.62])) annotation (
        Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    Modelica.Blocks.Sources.TimeTable tempRetVariation(table=[0.0,298.15; 7200,298.15;
          7200,303.15; 10800,303.15; 10800,308.15; 14400,308.15; 14400,313.15; 18000,
          313.15; 18000,318.15; 21600,318.15; 21600,298.15; 28800,298.15; 28800,303.15;
          32400,303.15; 32400,308.15; 36000,308.15; 36000,313.15; 39600,313.15; 39600,
          318.15; 43200,318.15; 43200,298.15; 50400,298.15; 50400,303.15; 54000,303.15;
          54000,308.15; 57600,308.15; 57600,313.15; 61200,313.15; 61200,318.15; 64800,
          318.15; 64800,298.15; 72000,298.15; 72000,303.15; 75600,303.15; 75600,308.15;
          79200,308.15; 79200,313.15; 82800,313.15; 82800,318.15; 86400,318.15; 86400,
          298.15; 93600,298.15; 93600,303.15; 97200,303.15; 97200,308.15; 100800,308.15;
          100800,313.15; 104400,313.15; 104400,318.15; 108000,318.15])
      annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Blocks.Sources.TimeTable volFlowVariation(table=[0.0,0.25; 21600,0.25;
          21600,0.3; 43200,0.3; 43200,0.35; 64800,0.35; 64800,0.4; 86400,0.4; 86400,
          0.45; 108000,0.45])
      annotation (Placement(transformation(extent={{-144,-32},{-124,-12}})));
    Modelica.Fluid.Sources.FixedBoundary fixedCoolingRetSink(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
          points={{-92,10},{-60,10}},                 color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(heatingReturnFlow.T_in, tempRetVariation.y) annotation (Line(points={{
            -112,-60},{-116,-60},{-116,-88},{-123,-88}}, color={0,0,127}));
    connect(modTim.y,simTime. u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y,simTime. u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(tempCoolantReturn.port_b, fixedCoolingRetSink.ports[1]) annotation (
        Line(points={{-56,-40},{-70,-40},{-70,-30},{-90,-30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StopTime=108000, Interval=100));
  end CHP_Static_50PercentLoad;

  model CHP_Static_FullLoad_TESTClosed
    "Test examplel of the modular CHP model for static operation at full load"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=5000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=0
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=volFlowVariation.y/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      inductionMachine(J_Gen=1, s_til=0.175),
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac)
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet,
      nPorts=1)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      dp1_nominal(displayUnit="kPa") = 10000,
      dp2_nominal(displayUnit="kPa") = 10000,
      eps=0.99)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=0,
      modulationFactorControl(table=[0.0,0.925; 108000,0.925])) annotation (
        Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    Modelica.Blocks.Sources.TimeTable tempRetVariation(table=[0.0,298.15; 7200,298.15;
          7200,303.15; 10800,303.15; 10800,308.15; 14400,308.15; 14400,313.15; 18000,
          313.15; 18000,318.15; 21600,318.15; 21600,298.15; 28800,298.15; 28800,303.15;
          32400,303.15; 32400,308.15; 36000,308.15; 36000,313.15; 39600,313.15; 39600,
          318.15; 43200,318.15; 43200,298.15; 50400,298.15; 50400,303.15; 54000,303.15;
          54000,308.15; 57600,308.15; 57600,313.15; 61200,313.15; 61200,318.15; 64800,
          318.15; 64800,298.15; 72000,298.15; 72000,303.15; 75600,303.15; 75600,308.15;
          79200,308.15; 79200,313.15; 82800,313.15; 82800,318.15; 86400,318.15; 86400,
          298.15; 93600,298.15; 93600,303.15; 97200,303.15; 97200,308.15; 100800,308.15;
          100800,313.15; 104400,313.15; 104400,318.15; 108000,318.15])
      annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Blocks.Sources.TimeTable volFlowVariation(table=[0.0,0.25; 21600,0.25;
          21600,0.3; 43200,0.3; 43200,0.35; 64800,0.35; 64800,0.4; 86400,0.4; 86400,
          0.45; 108000,0.45])
      annotation (Placement(transformation(extent={{-144,-32},{-124,-12}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(heatingReturnFlow.T_in, tempRetVariation.y) annotation (Line(points={{
            -112,-60},{-116,-60},{-116,-88},{-123,-88}}, color={0,0,127}));
    connect(modTim.y,simTime. u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y,simTime. u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(coolantPump.port_a, tempCoolantReturn.port_b) annotation (Line(
          points={{-60,10},{-70,10},{-70,-40},{-56,-40}}, color={0,127,255}));
    connect(fixedPressureLevel.ports[1], tempCoolantReturn.port_b) annotation (
        Line(points={{-92,10},{-70,10},{-70,-40},{-56,-40}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StopTime=108000, Interval=100));
  end CHP_Static_FullLoad_TESTClosed;

  model CHP_Static_FullLoad_ClosedDynamicHX
    "Test examplel of the modular CHP model for static operation at full load"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=5000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=0
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=volFlowVariation.y/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      inductionMachine(J_Gen=1, s_til=0.175),
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac)
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet,
      nPorts=1)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.DynamicHX                         coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      Q_nom=CHPEngineModel.Q_MaxHea,
      dT_nom=25,
      nNodes=1,
      dp1_nominal(displayUnit="kPa") = 0,
      dp2_nominal(displayUnit="kPa") = 0)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=0,
      modulationFactorControl(table=[0.0,0.925; 108000,0.925])) annotation (
        Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    Modelica.Blocks.Sources.TimeTable tempRetVariation(table=[0.0,298.15; 7200,298.15;
          7200,303.15; 10800,303.15; 10800,308.15; 14400,308.15; 14400,313.15; 18000,
          313.15; 18000,318.15; 21600,318.15; 21600,298.15; 28800,298.15; 28800,303.15;
          32400,303.15; 32400,308.15; 36000,308.15; 36000,313.15; 39600,313.15; 39600,
          318.15; 43200,318.15; 43200,298.15; 50400,298.15; 50400,303.15; 54000,303.15;
          54000,308.15; 57600,308.15; 57600,313.15; 61200,313.15; 61200,318.15; 64800,
          318.15; 64800,298.15; 72000,298.15; 72000,303.15; 75600,303.15; 75600,308.15;
          79200,308.15; 79200,313.15; 82800,313.15; 82800,318.15; 86400,318.15; 86400,
          298.15; 93600,298.15; 93600,303.15; 97200,303.15; 97200,308.15; 100800,308.15;
          100800,313.15; 104400,313.15; 104400,318.15; 108000,318.15])
      annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Blocks.Sources.TimeTable volFlowVariation(table=[0.0,0.25; 21600,0.25;
          21600,0.3; 43200,0.3; 43200,0.35; 64800,0.35; 64800,0.4; 86400,0.4; 86400,
          0.45; 108000,0.45])
      annotation (Placement(transformation(extent={{-144,-32},{-124,-12}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(heatingReturnFlow.T_in, tempRetVariation.y) annotation (Line(points={{
            -112,-60},{-116,-60},{-116,-88},{-123,-88}}, color={0,0,127}));
    connect(modTim.y,simTime. u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y,simTime. u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(tempCoolantReturn.port_b, coolantPump.port_a) annotation (Line(
          points={{-56,-40},{-72,-40},{-72,10},{-60,10}}, color={0,127,255}));
    connect(fixedPressureLevel.ports[1], coolantPump.port_a)
      annotation (Line(points={{-92,10},{-60,10}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StopTime=108000, Interval=100));
  end CHP_Static_FullLoad_ClosedDynamicHX;

  model CHP_Static_FullLoadTESTOpen
    "Test examplel of the modular CHP model for static operation at full load"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=5000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=0
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=volFlowVariation.y/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      inductionMachine(J_Gen=1, s_til=0.175),
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac)
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      dp1_nominal(displayUnit="kPa") = 10000,
      dp2_nominal(displayUnit="kPa") = 10000,
      eps=0.99)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=0,
      modulationFactorControl(table=[0.0,0.925; 108000,0.925])) annotation (
        Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    Modelica.Blocks.Sources.TimeTable tempRetVariation(table=[0.0,298.15; 7200,298.15;
          7200,303.15; 10800,303.15; 10800,308.15; 14400,308.15; 14400,313.15; 18000,
          313.15; 18000,318.15; 21600,318.15; 21600,298.15; 28800,298.15; 28800,303.15;
          32400,303.15; 32400,308.15; 36000,308.15; 36000,313.15; 39600,313.15; 39600,
          318.15; 43200,318.15; 43200,298.15; 50400,298.15; 50400,303.15; 54000,303.15;
          54000,308.15; 57600,308.15; 57600,313.15; 61200,313.15; 61200,318.15; 64800,
          318.15; 64800,298.15; 72000,298.15; 72000,303.15; 75600,303.15; 75600,308.15;
          79200,308.15; 79200,313.15; 82800,313.15; 82800,318.15; 86400,318.15; 86400,
          298.15; 93600,298.15; 93600,303.15; 97200,303.15; 97200,308.15; 100800,308.15;
          100800,313.15; 104400,313.15; 104400,318.15; 108000,318.15])
      annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Blocks.Sources.TimeTable volFlowVariation(table=[0.0,0.25; 21600,0.25;
          21600,0.3; 43200,0.3; 43200,0.35; 64800,0.35; 64800,0.4; 86400,0.4; 86400,
          0.45; 108000,0.45])
      annotation (Placement(transformation(extent={{-144,-32},{-124,-12}})));
    Modelica.Fluid.Sources.FixedBoundary fixedCoolingRetSink(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
          points={{-92,10},{-60,10}},                 color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(heatingReturnFlow.T_in, tempRetVariation.y) annotation (Line(points={{
            -112,-60},{-116,-60},{-116,-88},{-123,-88}}, color={0,0,127}));
    connect(modTim.y,simTime. u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y,simTime. u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(tempCoolantReturn.port_b, fixedCoolingRetSink.ports[1]) annotation (
        Line(points={{-56,-40},{-70,-40},{-70,-30},{-90,-30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StopTime=108000, Interval=100));
  end CHP_Static_FullLoadTESTOpen;

  model CHP_Static_FullLoadTESTOpenDynamicHX
    "Test examplel of the modular CHP model for static operation at full load"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);

    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_ambient=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Modelica.SIunits.ThermalConductance GCoolChannel=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=5000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass Cal_mEng=0
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then
    CHPEngineModel.m_floCooNominal else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=volFlowVariation.y/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Real calFac=0.955
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Real timeSimulation=simTime.y
      "Time of the simulation without the start delay for measurement comparison";
    Modelica.SIunits.Temperature T_RetCelsius=T_Ret-273.15
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_SupCelsius=T_Sup-273.15
      "Coolant supply temperature";

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnitModulateWECHSEL1502
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      p_ambient=p_ambient,
      m_flow=m_flowCoo,
      GCoolChannel=GCoolChannel,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      T_CoolRet=tempReturnFlow.T,
      T_CoolSup=tempSupplyFlow.T,
      G_CooExhHex=GCooExhHex,
      C_ExhHex=C_ExhHex,
      inductionMachine(J_Gen=1, s_til=0.175),
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      G_Amb=G_Amb,
      calFac=calFac)
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flowCoo,
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{40,2},{56,18}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      m_flow_nominal=m_flowCoo)
      annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
          onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

    AixLib.Fluid.HeatExchangers.DynamicHX                         coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      m1_flow_nominal=m_flowCoo,
      redeclare package Medium2 = Medium_HeatingCircuit,
      Q_nom=CHPEngineModel.Q_MaxHea,
      dT_nom=15,
      nNodes=1,
      dp1_nominal(displayUnit="kPa") = 0,
      dp2_nominal(displayUnit="kPa") = 0)
      annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                 nPorts=1, redeclare package Medium =
          Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.OnOff_ControllerCHPTests2702
      onOff_ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=0,
      modulationFactorControl(table=[0.0,0.925; 108000,0.925])) annotation (
        Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    Modelica.Blocks.Sources.TimeTable tempRetVariation(table=[0.0,298.15; 7200,298.15;
          7200,303.15; 10800,303.15; 10800,308.15; 14400,308.15; 14400,313.15; 18000,
          313.15; 18000,318.15; 21600,318.15; 21600,298.15; 28800,298.15; 28800,303.15;
          32400,303.15; 32400,308.15; 36000,308.15; 36000,313.15; 39600,313.15; 39600,
          318.15; 43200,318.15; 43200,298.15; 50400,298.15; 50400,303.15; 54000,303.15;
          54000,308.15; 57600,308.15; 57600,313.15; 61200,313.15; 61200,318.15; 64800,
          318.15; 64800,298.15; 72000,298.15; 72000,303.15; 75600,303.15; 75600,308.15;
          79200,308.15; 79200,313.15; 82800,313.15; 82800,318.15; 86400,318.15; 86400,
          298.15; 93600,298.15; 93600,303.15; 97200,303.15; 97200,308.15; 100800,308.15;
          100800,313.15; 104400,313.15; 104400,318.15; 108000,318.15])
      annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
    AixLib.Utilities.Time.ModelTime modTim
      annotation (Placement(transformation(extent={{36,70},{50,84}})));
    Modelica.Blocks.Math.MultiSum simTime(nu=2, k={1,-1})
      annotation (Placement(transformation(extent={{70,70},{82,82}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=onOff_ControllerCHP.startTimeChp)
      annotation (Placement(transformation(extent={{32,84},{50,104}})));
    Modelica.Blocks.Sources.TimeTable volFlowVariation(table=[0.0,0.25; 21600,0.25;
          21600,0.3; 43200,0.3; 43200,0.35; 64800,0.35; 64800,0.4; 86400,0.4; 86400,
          0.45; 108000,0.45])
      annotation (Placement(transformation(extent={{-144,-32},{-124,-12}})));
    Modelica.Fluid.Sources.FixedBoundary fixedCoolingRetSink(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet)
      annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
          points={{-92,10},{-60,10}},                 color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in)
      annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                           color={0,0,127}));
    connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
            {74,10},{74,-40},{20,-40}},         color={0,127,255}));
    connect(coolantHex.port_b1, tempCoolantReturn.port_a)
      annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
    connect(coolantHex.port_a2, tempReturnFlow.port_b)
      annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, tempSupplyFlow.port_a)
      annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
    connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
      annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
    connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
          points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                            color={0,127,255}));
    connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
      annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,47.76}},
        color={255,204,51},
        thickness=0.5));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,-64},{-74,-64}}, color={0,127,255}));
    connect(tempReturnFlow.port_a, senDen.port_b)
      annotation (Line(points={{-46,-64},{-54,-64}}, color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,-50},{-118,-50},{-118,-56},{-110,-56}}, color={0,0,127}));
    connect(heatingReturnFlow.T_in, tempRetVariation.y) annotation (Line(points={{
            -112,-60},{-116,-60},{-116,-88},{-123,-88}}, color={0,0,127}));
    connect(modTim.y,simTime. u[1]) annotation (Line(points={{50.7,77},{62,77},{62,
            78.1},{70,78.1}}, color={0,0,127}));
    connect(realExpression.y,simTime. u[2]) annotation (Line(points={{50.9,94},{64,
            94},{64,73.9},{70,73.9}}, color={0,0,127}));
    connect(tempCoolantReturn.port_b, fixedCoolingRetSink.ports[1]) annotation (
        Line(points={{-56,-40},{-70,-40},{-70,-30},{-90,-30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StopTime=108000, Interval=100));
  end CHP_Static_FullLoadTESTOpenDynamicHX;

  model ModularCHP_Calibration_DynamicHX
    "Test examplel of the modular CHP model after its dynamic calibration"
    extends Modelica.Icons.Example;
    import AixLib;

  protected
    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);
  public
    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_amb, T_ambient=T_amb)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_amb=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_amb=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=temRetFlo.T "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=temSupFlo.T "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=coolantHex.Q2_flow "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_flow_CO2=cHP_PowerUnit.m_flow_CO2
      "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_flow_Fue=cHP_PowerUnit.m_flow_Fue
      "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Real s_til=0.175
      "Tilting slip of electric machine" annotation (Dialog(tab="Calibration parameters",
          group="Fast calibration - Electric power and fuel usage"));
    parameter Real calFac=0.955
      "Calibration factor for electric power output (default=1)"
      annotation (Dialog(tab="Calibration parameters",
      group="Fast calibration - Electric power and fuel usage"));
    parameter Modelica.SIunits.ThermalConductance GEngToCoo=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Calibration parameters",group=
            "Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Calibration parameters",group=
            "Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.HeatCapacity CExhHex=120000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
  protected
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
  public
    parameter Modelica.SIunits.Mass Cal_mEng=40
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.MassFlowRate m_flow_Coo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Calibration parameters",group="Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Modelica.SIunits.ThermalConductance GAmb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Real modTab[:,2]=[0.0,0.8; 7200,0.8; 7200,0.92; 10800,0.92; 10800,
        0.625; 14400,0.625; 14400,0.8; 18000,0.8; 18000,0.0]
      "Table for unit modulation (time = first column; modulation factors = second column)"
      annotation (Dialog(tab="Calibration parameters", group="Fast calibration - Electric power and fuel usage"));
    parameter Modelica.SIunits.TemperatureDifference dT_nominal=100
                                                                   "Nominal heat exchanger temperature difference between cooling and heating circuit"
      annotation (Dialog(tab="Calibration parameters", group=
            "Advanced calibration parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.MassFlowRate m_flowHeaCir=if not VolCon then CHPEngineModel.m_floCooNominal
         else V_flowHeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit" annotation (Dialog(
          group="Ambient Parameters"));
    Modelica.SIunits.VolumeFlowRate V_flowHeaCir=0.3/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(
          group="Ambient Parameters"));
    parameter Boolean VolCon=true "Is volume flow rate control used?"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.ModularCHP_PowerUnit2504
      cHP_PowerUnit(
      redeclare package Medium_Fuel =
          AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.Medium_Fuel,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_amb=T_amb,
      p_amb=p_amb,
      m_flow=m_flow_Coo,
      GEngToCoo=GEngToCoo,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      mEng=mEng,
      redeclare package Medium_Coolant = Medium_Coolant,
      GCooExhHex=GCooExhHex,
      CExhHex=CExhHex,
      inductionMachine(J_Gen=1),
      dInn=dInn,
      GEngToAmb=GEngToAmb,
      GAmb=GAmb,
      calFac=calFac,
      s_til=s_til)
      annotation (Placement(transformation(extent={{-24,0},{24,48}})));

    AixLib.Fluid.HeatExchangers.DynamicHX             coolantHex(
      allowFlowReversal1=allowFlowReversalCoolant,
      allowFlowReversal2=allowFlowReversalCoolant,
      m1_flow_small=mCool_flow_small,
      m2_flow_small=mCool_flow_small,
      redeclare package Medium1 = Medium_Coolant,
      redeclare package Medium2 = Medium_HeatingCircuit,
      dp1_nominal(displayUnit="kPa") = 0,
      dp2_nominal(displayUnit="kPa") = 0,
      Q_nom=CHPEngineModel.Q_MaxHea,
      dT_nom=dT_nominal,
      m1_flow_nominal=CHPEngineModel.m_floCooNominal,
      m2_flow_nominal=CHPEngineModel.m_floCooNominal,
      Gc1=100000,
      Gc2=100000,
      nNodes=5)
               annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort temRetFlo(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-58,-72},{-42,-56}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort temSupFlo(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{42,-72},{58,-56}})));

    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.OnOff_Controller
      ControllerCHP(
      CHPEngineModel=CHPEngineModel,
      startTimeChp=3600,
      modTab=modTab) annotation (Placement(transformation(rotation=0, extent={{
              -76,64},{-44,96}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_retHea(redeclare package Medium =
          Medium_Coolant)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_supHea(redeclare package Medium =
          Medium_Coolant)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-124,-74},{-104,-54}})));
    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-158,-76},{-138,-56}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-88,-74},{-68,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-158,-60},{-138,-40}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel1(
      redeclare package Medium = Medium_Coolant,
      p=300000,
      T(displayUnit="K") = T_HeaRet,
      nPorts=1)
      annotation (Placement(transformation(extent={{-80,-46},{-60,-26}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
      nPorts=1,
      redeclare package Medium = Medium_HeatingCircuit,
      T=T_HeaRet)
      annotation (Placement(transformation(extent={{138,-10},{118,10}})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if ControllerCHP.pumpControl.y
           then m_flow_Coo else mCool_flow_small)
      annotation (Placement(transformation(extent={{-170,4},{-150,24}})));
    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow1(
      use_T_in=true,
      nPorts=1,
      use_m_flow_in=true,
      redeclare package Medium = Medium_Coolant)
      annotation (Placement(transformation(extent={{-136,-10},{-116,10}})));
    Modelica.Blocks.Sources.RealExpression tempFlowHeating1(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-170,-12},{-150,8}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort temCooOut(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_Coolant,
      allowFlowReversal=allowFlowReversalCoolant)
      annotation (Placement(transformation(extent={{-34,-44},{-50,-28}})));
  equation
    connect(coolantHex.port_a2, temRetFlo.port_b)
      annotation (Line(points={{-20,-64},{-42,-64}}, color={0,127,255}));
    connect(coolantHex.port_b2, temSupFlo.port_a)
      annotation (Line(points={{20,-64},{42,-64}}, color={0,127,255}));
    connect(ControllerCHP.modCHPConBus, cHP_PowerUnit.sigBusCHP) annotation (Line(
        points={{-44,80},{-0.24,80},{-0.24,46.32}},
        color={255,204,51},
        thickness=0.5));
    connect(cHP_PowerUnit.port_supCoo, coolantHex.port_a1) annotation (Line(
          points={{19.2,10.08},{60,10.08},{60,-40},{20,-40}}, color={0,127,255}));
    connect(temSupFlo.port_b, port_supHea) annotation (Line(points={{58,-64},{90,
            -64},{90,0},{100,0}}, color={0,127,255}));
    connect(heatingReturnFlow.T_in,tempFlowHeating. y)
      annotation (Line(points={{-126,-60},{-132,-60},{-132,-66},{-137,-66}},
                                                       color={0,0,127}));
    connect(heatingReturnFlow.ports[1],senDen. port_a)
      annotation (Line(points={{-104,-64},{-88,-64}},color={0,127,255}));
    connect(massFlowHeating.y,heatingReturnFlow. m_flow_in) annotation (Line(
          points={{-137,-50},{-132,-50},{-132,-56},{-124,-56}}, color={0,0,127}));
    connect(senDen.port_b, temRetFlo.port_a)
      annotation (Line(points={{-68,-64},{-58,-64}}, color={0,127,255}));
    connect(port_retHea, cHP_PowerUnit.port_retCoo) annotation (Line(points={{-100,
            0},{-48,0},{-48,10.08},{-19.2,10.08}}, color={0,127,255}));
    connect(heatingSupplyFlow.ports[1], port_supHea)
      annotation (Line(points={{118,0},{100,0}}, color={0,127,255}));
    connect(heatingReturnFlow1.T_in, tempFlowHeating1.y) annotation (Line(
          points={{-138,4},{-144,4},{-144,-2},{-149,-2}}, color={0,0,127}));
    connect(heatingReturnFlow1.ports[1], port_retHea)
      annotation (Line(points={{-116,0},{-100,0}}, color={0,127,255}));
    connect(heatingReturnFlow1.m_flow_in, massFlowCoolant.y) annotation (Line(
          points={{-136,8},{-144,8},{-144,14},{-149,14}}, color={0,0,127}));
    connect(coolantHex.port_b1, temCooOut.port_a) annotation (Line(points={{-20,
            -40},{-28,-40},{-28,-36},{-34,-36}}, color={0,127,255}));
    connect(fixedPressureLevel1.ports[1], temCooOut.port_b)
      annotation (Line(points={{-60,-36},{-50,-36}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"),
  experiment(StartTime=3600, StopTime=28800, Interval=5));
  end ModularCHP_Calibration_DynamicHX;

  model ModularCHP_Calibrated_Base
    "Example of the modular CHP power unit model inside a heating circuit"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);
  protected
    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);
  public
    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_amb, T_ambient=T_amb)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_amb=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_amb=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=cHP_PowerUnit.temRetFlo.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=cHP_PowerUnit.temSupFlo.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm_th "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=cHP_PowerUnit.Q_Therm "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_flow_CO2=cHP_PowerUnit.m_flow_CO2
      "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_flow_Fue=cHP_PowerUnit.m_flow_Fue
      "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Real s_til=0.175
      "Tilting slip of electric machine" annotation (Dialog(tab="Calibration parameters",
          group="Fast calibration - Electric power and fuel usage"));
    parameter Real calFac=0.955
      "Calibration factor for electric power output (default=1)"
      annotation (Dialog(tab="Calibration parameters",
      group="Fast calibration - Electric power and fuel usage"));
    parameter Modelica.SIunits.ThermalConductance GEngToCoo=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Calibration parameters",group=
            "Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Calibration parameters",group="Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.HeatCapacity CExhHex=120000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
  protected
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
  public
    parameter Modelica.SIunits.Mass Cal_mEng=40
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.MassFlowRate m_flow_Coo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Calibration parameters",group="Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.ThermalConductance GAmb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Real modTab[:,2]=[0.0,0.8; 7200,0.8; 7200,0.92; 10800,0.92; 10800,
        0.625; 14400,0.625; 14400,0.8; 18000,0.8; 18000,0.0]
      "Table for unit modulation (time = first column; modulation factors = second column)"
      annotation (Dialog(tab="Calibration parameters", group="Fast calibration - Electric power and fuel usage"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Modelica.SIunits.MassFlowRate m_flow_HeaCir=if not VolCon then
        CHPEngineModel.m_floCooNominal else V_flow_HeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flow_HeaCir=0.3/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab=
            "Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));

    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                           redeclare package Medium =
          Medium_HeatingCircuit, nPorts=1)
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-12},{-124,8}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-68,-8},{-52,8}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flow_HeaCir)
      annotation (Placement(transformation(extent={{-144,4},{-124,24}})));

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.ModularCHP_Easy_2504
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_amb=T_amb,
      p_amb=p_amb,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      redeclare package Medium_Coolant = Medium_Coolant,
      GCooExhHex=GCooExhHex,
      CExhHex=CExhHex,
      dInn=dInn,
      GAmb=GAmb,
      calFac=calFac,
      GEngToCoo=GEngToCoo,
      GEngToAmb=GEngToAmb,
      m_flow_Coo=m_flow_Coo,
      redeclare package Medium_HeatingCircuit = Medium_HeatingCircuit,
      s_til=s_til,
      Cal_mEng=Cal_mEng,
      modTab=modTab,
      cHP_PowerUnit(inductionMachine(s_til=cHP_PowerUnit.cHP_PowerUnit.s_til)),
      coolantHex(eps=eps))
      annotation (Placement(transformation(extent={{-26,-26},{26,26}})));

    parameter Modelica.SIunits.Efficiency eps=0.99
                                                  "Heat exchanger effectiveness"
      annotation (Dialog(tab="Calibration parameters", group=
            "Advanced calibration parameters"));
  equation
    connect(heatingReturnFlow.T_in, tempFlowHeating.y)
      annotation (Line(points={{-112,4},{-118,4},{-118,-2},{-123,-2}},
                                                       color={0,0,127}));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,0},{-68,0}},     color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,14},{-118,14},{-118,8},{-110,8}},       color={0,0,127}));
    connect(cHP_PowerUnit.port_supHea, heatingSupplyFlow.ports[1])
      annotation (Line(points={{26,0},{90,0}}, color={0,127,255}));
    connect(senDen.port_b,cHP_PowerUnit.port_retHea)
      annotation (Line(points={{-52,0},{-26,0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)), experiment(StopTime=18000, Interval=5),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
<p>An example of the use of modular CHP components combined as a power unit with interfaces to a controller and to the heating circuit.</p>
<p>It allows an impression of the versatile and complex application possibilities of the model by the changeability of many variables of individual components and the detailed investigation capability.</p>
<p>For a better understanding the controller modulates the fuel consumption of the CHP unit. The effects to the thermal output can be visualized by looking at <b>T_Ret</b> and <b>T_Sup</b>.</p>
<p>The return temperature as well as the volume flow in the heating circuit are considered constant in this example.</p>
<p><br><br>Caution: </p>
<p>If the prime coolant cirlce of the power unit is using a gasoline medium instead of a liquid fluid, you may need to adjust (raise) the nominal mass flow and pressure drop of the cooling to heating heat exchanger to run the model, because of a background calculation for the nominal flow.</p>
</html>"));
  end ModularCHP_Calibrated_Base;

  model ModularCHP_Calibrated_DynamicHX_EASY
    "Example of the modular CHP power unit model inside a heating circuit"
    extends Modelica.Icons.Example;
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                      constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);
  protected
    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);
  public
    replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
        AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    inner Modelica.Fluid.System system(p_ambient=p_amb, T_ambient=T_amb)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    parameter Modelica.SIunits.Temperature T_amb=293.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_amb=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_Ret=cHP_PowerUnit.temRetFlo.T
      "Coolant return temperature";
    Modelica.SIunits.Temperature T_Sup=cHP_PowerUnit.temSupFlo.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm_th=cHP_PowerUnit.Q_Therm_th "Thermal power output of the CHP unit to the coolant media";
    Modelica.SIunits.Power Q_Therm=cHP_PowerUnit.Q_Therm "Effective thermal power output of the CHP unit to the heating circuit";
    Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_flow_CO2=cHP_PowerUnit.m_flow_CO2
      "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_flow_Fue=cHP_PowerUnit.m_flow_Fue
      "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
    Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
    Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
    Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

    parameter Real s_til=0.175
      "Tilting slip of electric machine" annotation (Dialog(tab="Calibration parameters",
          group="Fast calibration - Electric power and fuel usage"));
    parameter Real calFac=0.955
      "Calibration factor for electric power output (default=1)"
      annotation (Dialog(tab="Calibration parameters",
      group="Fast calibration - Electric power and fuel usage"));
    parameter Modelica.SIunits.ThermalConductance GEngToCoo=2000
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Calibration parameters",group=
            "Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=1100
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Calibration parameters",group="Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.HeatCapacity CExhHex=120000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
  protected
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
  public
    parameter Modelica.SIunits.Mass Cal_mEng=40
      "Added engine mass for calibration purposes of the system´s thermal inertia"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.Area A_surExhHea=100
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.MassFlowRate m_flow_Coo=0.32
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.03
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Calibration parameters",group="Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=5
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.ThermalConductance GAmb=5
      "Constant heat transfer coefficient of engine housing to ambient" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Real modTab[:,2]=[0.0,0.8; 7200,0.8; 7200,0.92; 10800,0.92; 10800,0.625;
        14400,0.625; 14400,0.8; 18000,0.8; 18000,0.0]
      "Table for unit modulation (time = first column; modulation factors = second column)"
      annotation (Dialog(tab="Calibration parameters", group="Fast calibration - Electric power and fuel usage"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.TemperatureDifference dT_nominal=1000
                                                                   "Nominal heat exchanger temperature difference between cooling and heating circuit"
      annotation (Dialog(tab="Calibration parameters", group=
            "Advanced calibration parameters"));
    parameter Modelica.Blocks.Interfaces.RealInput GCooHex=10000
      "Signal representing the convective thermal conductance of the coolant heat exchanger in [W/K]"
      annotation (Dialog(tab="Calibration parameters", group="Advanced calibration parameters"));
    parameter Boolean ConTec=true
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Latent heat use"));
    parameter Boolean useGenHea=true
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Boolean allowFlowReversalExhaust=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Modelica.SIunits.MassFlowRate m_flow_HeaCir=if not VolCon then CHPEngineModel.m_floCooNominal
         else V_flow_HeaCir*senDen.d
      "Nominal mass flow rate inside the heating circuit"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.VolumeFlowRate V_flow_HeaCir=0.3/3600
      "Nominal volume flow rate inside the heating circuit" annotation (Dialog(tab=
            "Engine Cooling Circle"));
    parameter Boolean VolCon=true  "Is volume flow rate control used?"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.005
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));

    Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
      use_T_in=true,
      redeclare package Medium = Medium_HeatingCircuit,
      nPorts=1,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                           redeclare package Medium =
          Medium_HeatingCircuit, nPorts=1)
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));

    Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
      annotation (Placement(transformation(extent={{-144,-12},{-124,8}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-68,-8},{-52,8}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flow_HeaCir)
      annotation (Placement(transformation(extent={{-144,4},{-124,24}})));

    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.ModularCHP_DynamicHX_EASY_2504
      cHP_PowerUnit(
      redeclare package Medium_Fuel = Medium_Fuel,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_amb=T_amb,
      p_amb=p_amb,
      ConTec=ConTec,
      useGenHea=useGenHea,
      allowFlowReversalExhaust=allowFlowReversalExhaust,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mExh_flow_small=mExh_flow_small,
      mCool_flow_small=mCool_flow_small,
      A_surExhHea=A_surExhHea,
      redeclare package Medium_Coolant = Medium_Coolant,
      GCooExhHex=GCooExhHex,
      CExhHex=CExhHex,
      dInn=dInn,
      GAmb=GAmb,
      calFac=calFac,
      GEngToCoo=GEngToCoo,
      GEngToAmb=GEngToAmb,
      m_flow_Coo=m_flow_Coo,
      redeclare package Medium_HeatingCircuit = Medium_HeatingCircuit,
      s_til=s_til,
      Cal_mEng=Cal_mEng,
      modTab=modTab,
      cHP_PowerUnit(inductionMachine(s_til=cHP_PowerUnit.cHP_PowerUnit.s_til)),
      coolantHex(dT_nom=dT_nominal),
      dT_nominal=dT_nominal,
      GCooHex=GCooHex)
      annotation (Placement(transformation(extent={{-26,-26},{26,26}})));

  equation
    connect(heatingReturnFlow.T_in, tempFlowHeating.y)
      annotation (Line(points={{-112,4},{-118,4},{-118,-2},{-123,-2}},
                                                       color={0,0,127}));
    connect(heatingReturnFlow.ports[1], senDen.port_a)
      annotation (Line(points={{-90,0},{-68,0}},     color={0,127,255}));
    connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
          points={{-123,14},{-118,14},{-118,8},{-110,8}},       color={0,0,127}));
    connect(cHP_PowerUnit.port_supHea, heatingSupplyFlow.ports[1])
      annotation (Line(points={{26,0},{90,0}}, color={0,127,255}));
    connect(senDen.port_b,cHP_PowerUnit.port_retHea)
      annotation (Line(points={{-52,0},{-26,0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)), experiment(StopTime=18000, Interval=5),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
<p>An example of the use of modular CHP components combined as a power unit with interfaces to a controller and to the heating circuit.</p>
<p>It allows an impression of the versatile and complex application possibilities of the model by the changeability of many variables of individual components and the detailed investigation capability.</p>
<p>For a better understanding the controller modulates the fuel consumption of the CHP unit. The effects to the thermal output can be visualized by looking at <b>T_Ret</b> and <b>T_Sup</b>.</p>
<p>The return temperature as well as the volume flow in the heating circuit are considered constant in this example.</p>
<p><br><br>Caution: </p>
<p>If the prime coolant cirlce of the power unit is using a gasoline medium instead of a liquid fluid, you may need to adjust (raise) the nominal mass flow and pressure drop of the cooling to heating heat exchanger to run the model, because of a background calculation for the nominal flow.</p>
</html>"));
  end ModularCHP_Calibrated_DynamicHX_EASY;
  annotation (Documentation(info="<html>
<p>The following examples were used for model calibration. It was carried out using the example of the Kirsch L4.12 and experimental measurement data. Further information (non-public) is available in the Bachelor thesis: </p>
<p>Development of modular simulation models for Combined Heat and Power systems (CHP)</p>
</html>"));
end Calibration;
