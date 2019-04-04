within AixLib.Fluid.BoilerCHP.ModularCHP;
package SpeedTests "CHP models used for a simulation performance study"
  model ModularCHP_SpeedTest "Speed test example of the modular CHP model"
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

    replaceable package Medium_Coolant =
        Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    replaceable package Medium_HeatingCircuit =
        Modelica.Media.CompressibleLiquids.LinearColdWater      constrainedby
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

    parameter Modelica.SIunits.ThermalConductance GCoolChannel=33
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=400
      "Thermal conductance of the coolant heat exchanger at nominal flow"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=50000
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
    parameter Modelica.SIunits.MassFlowRate m_flowCoo=0.4
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.01
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=2
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=10
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
    parameter Real calFac=0.94
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
      inductionMachine(J_Gen=1, s_til=0.18),
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
      eps=0.9)
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
    AixLib.Fluid.BoilerCHP.ModularCHP.SpeedTests.OnOff_Controller_ModularCHP_SpeedTest
      onOff_ControllerCHP(CHPEngineModel=CHPEngineModel, startTimeChp=3600)
      annotation (Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
    AixLib.Fluid.Sensors.DensityTwoPort senDen(
      m_flow_small=mCool_flow_small,
      m_flow_nominal=CHPEngineModel.m_floCooNominal,
      redeclare package Medium = Medium_HeatingCircuit)
      annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
    Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flowHeaCir)
      annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

  equation
    connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
          points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                          color={0,127,255}));
    connect(tempCoolantReturn.port_b, coolantPump.port_a) annotation (Line(points={{-56,-40},
            {-76,-40},{-76,10},{-60,10}},         color={0,127,255}));
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
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
</html>"));
  end ModularCHP_SpeedTest;

  model OnOff_Controller_ModularCHP_SpeedTest
    import AixLib;

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter Modelica.SIunits.Time startTimeChp=0
      "Start time for discontinous simulation tests to heat the Chp unit up to the prescribed return temperature";
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPControlBus2702
      modularCHPControlBus annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={100,0})));
    Modelica.Blocks.Sources.BooleanPulse booleanOnOffCHP(width=50, period=86400)
                 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-82,2})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=0.5)
      annotation (Placement(transformation(extent={{-8,-46},{12,-26}})));
    Modelica.Blocks.Logical.Timer timerIsOff
      annotation (Placement(transformation(extent={{-26,62},{-12,76}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-52,62},{-38,76}})));
    Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=7200)
      annotation (Placement(transformation(extent={{0,62},{14,76}})));
    Modelica.Blocks.Logical.Or pumpControl
      annotation (Placement(transformation(extent={{28,54},{44,70}})));
  equation
    connect(realExpression.y, modularCHPControlBus.modFac) annotation (Line(
          points={{13,-36},{52,-36},{52,-0.1},{100.1,-0.1}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(timerIsOff.u,not1. y)
      annotation (Line(points={{-27.4,69},{-37.3,69}}, color={255,0,255}));
    connect(timerIsOff.y,declarationTime. u)
      annotation (Line(points={{-11.3,69},{-1.4,69}},
                                                    color={0,0,127}));
    connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{14.7,69},
            {18,69},{18,62},{26.4,62}},
                                      color={255,0,255}));
    connect(pumpControl.u2,not1. u) annotation (Line(points={{26.4,55.6},{-60,
            55.6},{-60,69},{-53.4,69}},
                                      color={255,0,255}));
    connect(booleanOnOffCHP.y, not1.u) annotation (Line(points={{-71,2},{-66,2},
            {-66,62},{-60,62},{-60,69},{-53.4,69}}, color={255,0,255}));
    connect(booleanOnOffCHP.y, modularCHPControlBus.isOn) annotation (Line(
          points={{-71,2},{12,2},{12,-0.1},{100.1,-0.1}}, color={255,0,255}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(pumpControl.y, modularCHPControlBus.isOnPump) annotation (Line(
          points={{44.8,62},{64,62},{64,-0.1},{100.1,-0.1}}, color={255,0,255}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
            extent={{-86,18},{82,-8}},
            lineColor={28,108,200},
            textString="onOff
Controller
CHP")}));
  end OnOff_Controller_ModularCHP_SpeedTest;

  model GeneralCHP_SpeedTest "Speed test example of the general CHP model"
    extends Modelica.Icons.Example;

    CHP combinedHeatPower(
      m_flow_nominal=0.02,
      TSetIn=true,
      minCapacity=20,
      delayTime=300,
      param=DataBase.CHP.CHPDataSimple.CHP_XRGI_9kWel(),
      redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater)
                                                         "CHP"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Fluid.Sources.MassFlowSource_T source(
      use_T_in=true,
      nPorts=1,
      m_flow=0.5,
      redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater)
      "Source"
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Fluid.Sources.Boundary_pT sink(
      nPorts=1, redeclare package Medium =
          Modelica.Media.CompressibleLiquids.LinearColdWater)
      "Sink"
      annotation (Placement(transformation(extent={{60,-10},{40,10}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      rising=7200,
      width=7200,
      falling=7200,
      period=28800,
      offset=313.15,
      amplitude=50,
      startTime=7200)
      "Source temperature"
      annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
    Modelica.Blocks.Sources.Constant TSet(k=80 + 273.15)
      "Set temperature"
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

    Modelica.Blocks.Sources.BooleanPulse booleanOnOffCHP(width=50, period=86400)
                 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-28,-34})));
  equation
    connect(source.ports[1],combinedHeatPower. port_a)
      annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,127,255}));
    connect(combinedHeatPower.port_b, sink.ports[1])
      annotation (Line(points={{10,0},{26,0},{40,0}}, color={0,127,255}));
    connect(trapezoid.y, source.T_in)
      annotation (Line(points={{-79,4},{-62,4}}, color={0,0,127}));
    connect(TSet.y,combinedHeatPower. TSet) annotation (Line(points={{-19,30},{-14,
            30},{-14,-6},{-7,-6}}, color={0,0,127}));
    connect(booleanOnOffCHP.y, combinedHeatPower.on)
      annotation (Line(points={{-17,-34},{3,-34},{3,-9}}, color={255,0,255}));
    annotation (Documentation(info="<html>
</html>", revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with
AixLib</li>
<li><i>April 16, 2014 &nbsp;</i> by Ana Constantin:<br/>Formated
documentation.</li>
<li>by Pooyan Jahangiri:<br/>First implementation.</li>
</ul>
</html>"),
  experiment(StopTime=35000, Interval=60));
  end GeneralCHP_SpeedTest;

  model FastHVAC_CHP_SpeedTest "Speed test example of the FastHVAC CHP model"
   extends Modelica.Icons.Example;
    FastHVAC.Components.Pumps.FluidSource fluidSource
      annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
    FastHVAC.Components.Sinks.Vessel vessel
      annotation (Placement(transformation(extent={{68,-8},{88,10}})));
    FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_before
      annotation (Placement(transformation(extent={{-44,-6},{-28,8}})));
    FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_after
      annotation (Placement(transformation(extent={{38,-6},{54,8}})));
    Modelica.Blocks.Sources.Constant T_source(k=313.15)
      annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
    Modelica.Blocks.Sources.Constant dotm_source(k=0.04)
      annotation (Placement(transformation(extent={{-100,-28},{-80,-8}})));
    Modelica.Blocks.Sources.BooleanPulse booleanOnOffCHP(width=50, period=86400)
                 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-36,42})));
    FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 cHP_PT1_1(
      param=FastHVAC.Data.CHP.Ecopower_3_0(),
      selectable=true,
      sigma(start=0.4),
      T0=293.15)
      annotation (Placement(transformation(extent={{-14,-18},{24,20}})));
    Modelica.Blocks.Sources.Ramp P_elRel(
      height=0.8,
      duration=36000,
      offset=0.2) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,42})));
  equation
    connect(fluidSource.enthalpyPort_b, temperatureSensor_before.enthalpyPort_a)
      annotation (Line(
        points={{-52,1},{-51,1},{-51,0.93},{-43.04,0.93}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(temperatureSensor_after.enthalpyPort_b, vessel.enthalpyPort_a)
      annotation (Line(
        points={{53.2,0.93},{61.6,0.93},{61.6,1},{71,1}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(T_source.y, fluidSource.T_fluid) annotation (Line(
        points={{-79,22},{-74,22},{-74,4},{-72,4},{-72,4.2},{-70,4.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(dotm_source.y, fluidSource.dotm) annotation (Line(
        points={{-79,-18},{-70,-18},{-70,-2.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(temperatureSensor_before.enthalpyPort_b, cHP_PT1_1.enthalpyPort_a)
      annotation (Line(
        points={{-28.8,0.93},{-21.4,0.93},{-21.4,1},{-14,1}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(cHP_PT1_1.enthalpyPort_b, temperatureSensor_after.enthalpyPort_a)
      annotation (Line(
        points={{24,1},{32,1},{32,0.93},{38.96,0.93}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(booleanOnOffCHP.y, cHP_PT1_1.onOff) annotation (Line(
        points={{-25,42},{-2.6,42},{-2.6,18.48}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(P_elRel.y, cHP_PT1_1.P_elRel) annotation (Line(
        points={{29,42},{14.5,42},{14.5,18.48}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),
      experiment(StopTime=72000, Interval=60),
      __Dymola_experimentSetupOutput,
      Documentation(revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
  end FastHVAC_CHP_SpeedTest;
  annotation (Documentation(info="<html>
<p>The following examples were used for an easy comparison of the chp model simulation performances by changing the amount of On-/Off-signals per day. It was carried out using the example of the Kirsch L4.12 and experimental measurement data. </p>
<p>Further information (non-public) is available in the Bachelor thesis: </p>
<p>Development of modular simulation models for Combined Heat and Power systems (CHP)</p>
</html>"));
end SpeedTests;
