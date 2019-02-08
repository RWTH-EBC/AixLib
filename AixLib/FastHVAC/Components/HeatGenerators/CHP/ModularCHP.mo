within AixLib.FastHVAC.Components.HeatGenerators.CHP;
package ModularCHP
  model CHP_PowerUnitModulate
    "Model of engine combustion, its power output and heat transfer to the cooling circle and ambient"
    import AixLib;

    replaceable package Medium_Fuel =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_LPG      constrainedby
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
        DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                   property_T=356, X_a=0.50) constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter Fluid.BoilerCHP.ModularCHP.EngineMaterialData EngMat=
        Fluid.BoilerCHP.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    AixLib.FastHVAC.Components.Pipes.DynamicPipe
      engineHeatTransfer(
      eps=0,
      diameter=CHPEngineModel.dCoo)
      annotation (Placement(transformation(extent={{-30,-70},{-6,-46}})));

    inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

    AixLib.FastHVAC.Components.Sinks.Vessel
                                         outletExhaustGas
      annotation (Placement(transformation(extent={{11,-11},{-11,11}},
          rotation=180,
          origin={99,27})));

    parameter Modelica.SIunits.Temperature T_ambient=298.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
    Modelica.SIunits.Temperature T_CoolRet=350.15
      "Coolant return temperature" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.Temperature T_CoolSup=exhaustHeatExchanger.senTCoolHot.T
      "Coolant supply temperature" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.Power Q_Therm=if (engineHeatTransfer.heatPort_outside.Q_flow+
        exhaustHeatExchanger.dynamicPipe.heatPort_outside.Q_flow)                                                                          >10
    then engineHeatTransfer.heatPort_outside.Q_flow+exhaustHeatExchanger.dynamicPipe.heatPort_outside.Q_flow
    else 1 "Thermal power output of the CHP unit";
    Modelica.SIunits.Power P_Mech=gasolineEngineChp.cHPCombustionEngine.P_eff "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=-inductionMachine.P_E
      "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=if (gasolineEngineChp.isOn) then m_Fuel*Medium_Fuel.H_U else 0 "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=gasolineEngineChp.cHPCombustionEngine.Q_therm-gasolineEngineChp.engineToCoolant.actualHeatFlowEngine.Q_flow+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_CO2=gasolineEngineChp.cHPCombustionEngine.m_CO2Exh "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_Fuel=if (gasolineEngineChp.cHPCombustionEngine.m_Fue)>0.0001 then gasolineEngineChp.cHPCombustionEngine.m_Fue else 0.0001 "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=if noEvent(abs(Q_Therm+P_El)>0) then 3600000000*m_CO2/(Q_Therm+P_El) else 0 "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=if noEvent(abs(Q_Therm+P_El)>0) then 3600000000*m_Fuel/(Q_Therm+P_El) else 0 "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate = (Q_Therm+P_El)/(m_Fuel*Medium_Fuel.H_U) "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = P_El/Q_Therm "Power to heat ration of the CHP unit";
    Real eta_Therm = Q_Therm/(m_Fuel*Medium_Fuel.H_U) "Thermal efficiency of the CHP unit";
    Real eta_Mech = P_Mech/(m_Fuel*Medium_Fuel.H_U) "Mechanical efficiency of the CHP unit";
    Real eta_El = P_El/(m_Fuel*Medium_Fuel.H_U) "Mechanical efficiency of the CHP unit";

    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=
        CHPEngineModel.m_floCooNominal
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.Area A_surExhHea=50
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GCoolChannel=45
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_CooExhHex=G_CooExhHex
      "Thermal conductance of exhaust heat exchanger to cooling circuit"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=C_ExhHex
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
        Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.005
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant thermal conductance of material" annotation (Dialog(tab="Engine Cooling Circle",
          group="Calibration Parameters"));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature(T=
          T_ambient)
      annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(extent={{-64,-8},{-80,8}})));
    AixLib.FastHVAC.Components.HeatGenerators.CHP.ModularCHP.ExhaustHeatExchanger
                                                           exhaustHeatExchanger(
      dynamicPipe(
        withConvection=false,
        withRadiation=false,
        diameter=CHPEngineModel.dCoo),
      TAmb=T_ambient,
      pAmb=p_ambient,
      T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
      meanCpExh=gasolineEngineChp.cHPCombustionEngine.meanCpExh,
      redeclare package Medium3 = Medium_Exhaust,
      redeclare package Medium4 = Medium_Coolant,
      d_iExh=CHPEngineModel.dExh,
      dp_CooExhHex=CHPEngineModel.dp_Coo,
      heatConvExhaustPipeInside(
        length=exhaustHeatExchanger.l_ExhHex,
        c=gasolineEngineChp.cHPCombustionEngine.meanCpExh,
        m_flow=gasolineEngineChp.cHPCombustionEngine.exhaustFlow.m_flow_in),
      volExhaust(V=exhaustHeatExchanger.VExhHex),
      CHPEngData=CHPEngineModel,
      M_Exh=gasolineEngineChp.cHPCombustionEngine.MM_Exh,
      allowFlowReversal1=allowFlowReversalExhaust,
      allowFlowReversal2=allowFlowReversalCoolant,
      m1_flow_small=mExh_flow_small,
      m2_flow_small=mCool_flow_small,
      ConTec=ConTec,
      Q_Gen=inductionMachine.Q_Therm,
      A_surExhHea=A_surExhHea,
      m2_flow_nominal=m_flow,
      C_ExhHex=C_ExhHex,
      G_Cool=G_CooExhHex,
      G_Amb=G_Amb)
      annotation (Placement(transformation(extent={{40,4},{68,32}})));

    parameter Boolean ConTec=false
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
    parameter Real calFac=1
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(tab="Advanced", group="Generator heat use"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.0001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.0001
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    AixLib.Fluid.BoilerCHP.ModularCHP.CHP_StarterGenerator inductionMachine(
        CHPEngData=CHPEngineModel, useHeat=useGenHea)
      annotation (Placement(transformation(extent={{-66,12},{-36,42}})));

    AixLib.FastHVAC.Interfaces.EnthalpyPort_a
                                          port_Return
      annotation (Placement(transformation(extent={{-86,-64},{-74,-52}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b
                                          port_Supply
      annotation (Placement(transformation(extent={{74,-66},{86,-54}})));
    AixLib.FastHVAC.Components.HeatGenerators.CHP.ModularCHP.gasolineEngineChpModulate
                                                        gasolineEngineChp(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_ambient=T_ambient,
      mEng=mEng,
      cHPCombustionEngine(T_logEngCool=exhaustHeatExchanger.senTCoolCold.T,
          T_ExhCHPOut=exhaustHeatExchanger.senTExhCold.T),
      engineToCoolant(T_ExhPowUniOut=exhaustHeatExchanger.senTExhCold.T),
      T_logEngCool=(senTCooRet.T + senTCooEngOut.T)/2,
      dInn=dInn,
      GEngToAmb=GEngToAmb)
      annotation (Placement(transformation(rotation=0, extent={{-18,8},{18,44}})));
    AixLib.Controls.Interfaces.CHPControlBus        sigBusCHP(
      meaThePowChp=Q_Therm,
      meaTemRetChp=senTCooRet.T,
      calEmiCO2Chp=b_CO2,
      calFueChp=b_e,
      calEtaTheChp=eta_Therm,
      calEtaElChp=eta_El,
      calFueUtiChp=FueUtiRate)
      annotation (Placement(transformation(extent={{-28,74},{26,124}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor
                                              senTCooRet
      annotation (Placement(transformation(extent={{-58,-66},{-42,-50}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor
                                              senTCooEngOut
      annotation (Placement(transformation(extent={{4,-66},{20,-50}})));
  equation
    connect(ambientTemperature.port, heatFlowSensor.port_b)
      annotation (Line(points={{-92,0},{-80,0}}, color={191,0,0}));
    connect(inductionMachine.flange_a, gasolineEngineChp.flange_a) annotation (
        Line(points={{-36,27},{-18.72,27},{-18.72,26.72}}, color={0,0,0}));
    connect(gasolineEngineChp.port_Ambient, heatFlowSensor.port_a)
      annotation (Line(points={{0,9.8},{0,0},{-64,0}},    color={191,0,0}));
    connect(gasolineEngineChp.port_CoolingCircle, engineHeatTransfer.heatPort_outside)
      annotation (Line(points={{18,10.16},{18,-18},{-28.56,-18},{-28.56,-51.76}},
          color={191,0,0}));
    connect(exhaustHeatExchanger.port_Ambient, heatFlowSensor.port_a) annotation (
       Line(points={{40,18},{30,18},{30,0},{-64,0}}, color={191,0,0}));
    connect(inductionMachine.cHPControlBus, sigBusCHP) annotation (Line(
        points={{-62.4,27},{-70,27},{-70,99},{-1,99}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(exhaustHeatExchanger.cHPControlBus, sigBusCHP) annotation (Line(
        points={{54,31.86},{54,99},{-1,99}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(gasolineEngineChp.cHPControlBus, sigBusCHP) annotation (Line(
        points={{0,41.84},{-1,41.84},{-1,99}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(sigBusCHP.isOn, inductionMachine.isOn) annotation (Line(
        points={{-0.865,99.125},{-0.865,60},{-28,60},{-28,34.2},{-37.5,34.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(gasolineEngineChp.isOn, inductionMachine.isOn) annotation (Line(
          points={{-17.82,34.46},{-28,34.46},{-28,34.2},{-37.5,34.2}}, color={255,
            0,255}));
    connect(port_Return, senTCooRet.enthalpyPort_a) annotation (Line(points={{-80,
            -58},{-68,-58},{-68,-58.08},{-57.04,-58.08}}, color={176,0,0}));
    connect(senTCooRet.enthalpyPort_b, engineHeatTransfer.enthalpyPort_a1)
      annotation (Line(points={{-42.8,-58.08},{-36.4,-58.08},{-36.4,-58},{-29.76,-58}},
          color={176,0,0}));
    connect(engineHeatTransfer.enthalpyPort_b1, senTCooEngOut.enthalpyPort_a)
      annotation (Line(points={{-6.24,-58},{0,-58},{0,-58.08},{4.96,-58.08}},
          color={176,0,0}));
    connect(gasolineEngineChp.port_Exhaust, exhaustHeatExchanger.port_a1)
      annotation (Line(points={{17.28,25.28},{40,25.28},{40,26.4}}, color={176,0,0}));
    connect(senTCooEngOut.enthalpyPort_b, exhaustHeatExchanger.port_a2)
      annotation (Line(points={{19.2,-58.08},{50,-58.08},{50,-14},{84,-14},{84,9.6},
            {68,9.6}}, color={176,0,0}));
    connect(exhaustHeatExchanger.port_b2, port_Supply)
      annotation (Line(points={{40,9.6},{40,-60},{80,-60}}, color={176,0,0}));
    connect(outletExhaustGas.enthalpyPort_a, exhaustHeatExchanger.port_b1)
      annotation (Line(points={{91.3,27},{68,27},{68,26.4}}, color={176,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-50,58},{50,18}},
            lineColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={175,175,175},
            textString="CHP",
            textStyle={TextStyle.Bold}),
                                Rectangle(
            extent={{-80,80},{80,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={170,170,255}),                                       Text(
            extent={{-50,68},{50,28}},
            lineColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={175,175,175},
            textStyle={TextStyle.Bold},
            textString="CHP
physical"),
          Rectangle(
            extent={{-12,6},{12,-36}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-10,-16},{-10,-36},{-8,-30},{8,-30},{10,-36},{10,-16},{-10,-16}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-2,-26},{4,-32}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-18,-54},{-8,-64}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-2,-30},{-14,-54},{-10,-56},{0,-32},{-2,-30}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-4.5,-15.5},{-8,-10},{0,4},{6,-4},{10,-4},{8,-8},{8,-12},{5.5,
                -15.5},{-4.5,-15.5}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={255,127,0}),
          Polygon(
            points={{-4.5,-13.5},{0,-4},{6,-10},{2,-14},{-4.5,-13.5}},
            lineColor={255,255,170},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)),
           __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
      Documentation(info="<html>
<p>Limitations:</p>
<p>- Transmissions between generator and engine are not considered </p>
<p>- </p>
</html>"));
  end CHP_PowerUnitModulate;

  model ExhaustHeatExchanger
    "Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle"
    import AixLib;

      //Data from FourPortInterface
     parameter Modelica.SIunits.MassFlowRate m1_flow_nominal( min=0) = 0.023
      "Nominal mass flow rate"
      annotation(Dialog(group = "Nominal condition"));
    parameter Modelica.SIunits.MassFlowRate m2_flow_nominal( min=0) = 0.5556
      "Nominal mass flow rate"
      annotation(Dialog(group = "Nominal condition"));
    parameter Medium1.MassFlowRate m1_flow_small(min=0) = 0.0001
      "Small mass flow rate for regularization of zero flow"
      annotation(Dialog(tab = "Advanced"));
    parameter Medium2.MassFlowRate m2_flow_small(min=0) = 0.0001
      "Small mass flow rate for regularization of zero flow"
      annotation(Dialog(tab = "Advanced"));
   Medium1.MassFlowRate m1_flow = port_a1.m_flow
      "Mass flow rate from port_a1 to port_b1 (m1_flow > 0 is design flow direction)";
   Medium2.MassFlowRate m2_flow = port_a2.m_flow
      "Mass flow rate from port_a2 to port_b2 (m2_flow > 0 is design flow direction)";
       replaceable package Medium1 =
        Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component"
        annotation (choicesAllMatching = true);
    replaceable package Medium2 =
        Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component"
        annotation (choicesAllMatching = true);

    parameter Boolean allowFlowReversal1 = true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);
    parameter Boolean allowFlowReversal2 = true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 2"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor
                                            senTExhHot
      "Temperature sensor of hot side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor
                                            senTExhCold
      "Temperature sensor of cold side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{28,50},{48,70}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor
                                      massFlowRate1
      "Sensor for mass flwo rate"
      annotation (Placement(transformation(extent={{60,70},{80,50}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor
                                            senTCoolCold
      "Temperature sensor of coolant cold side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor
                                            senTCoolHot
      "Temperature sensor of coolant hot side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor
                                      massFlowRate
      "Sensor for mass flwo rate"
      annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "Needed engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    parameter Modelica.SIunits.Time tau=1
      "Time constant of the temperature sensors at nominal flow rate"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
      "Type of initialization (InitialState and InitialOutput are identical)"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Modelica.SIunits.Temperature T1_start=TAmb
      "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.SIunits.Temperature T2_start=TAmb
      "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure p1_start=pAmb
      "Start value of pressure"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure p2_start=pAmb
      "Start value of pressure"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Boolean transferHeat=false
      "If true, temperature T converges towards TAmb when no flow"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Boolean ConTec=false
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Condensing technology"));
    parameter Modelica.SIunits.Temperature TAmb=298.15
      "Fixed ambient temperature for heat transfer"
      annotation (Dialog(group="Ambient Properties"));
    parameter Modelica.SIunits.Temperature T_ExhPowUniOut=CHPEngData.T_ExhPowUniOut
      "Outlet temperature of exhaust gas flow"
    annotation (Dialog(group="Thermal"));
    parameter Modelica.SIunits.Area A_surExhHea=50
      "Surface for exhaust heat transfer" annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.SIunits.Length d_iExh=CHPEngData.dExh
      "Inner diameter of exhaust pipe"
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.Volume VExhHex=l_ExhHex/4*Modelica.Constants.pi*
        d_iExh^2
      "Exhaust gas volume inside the exhaust heat exchanger" annotation(Dialog(tab="Calibration parameters",group="Engine parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant thermal conductance of material"
      annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Cool=850
      "Constant thermal conductance of material"
      annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=4000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)"
    annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pAmb=101325
      "Start value of pressure"
      annotation (Dialog(group="Ambient Properties"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=
        CHPEngData.dp_Coo
      "Guess value of dp = port_a.p - port_b.p"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.SIunits.Time tauHeaTra=1200
      "Time constant for heat transfer, default 20 minutes"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
      "Guess value of m_flow = port_a.m_flow"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    constant Modelica.SIunits.MolarMass M_H2O=0.01802
      "Molar mass of water";
    constant Modelica.SIunits.MolarMass M_Exh
      "Molar mass of the exhaust gas"
      annotation (Dialog(group="Thermal"));

      //Antoine-Parameters needed for the calculation of the saturation vapor pressure xSat_H2OExhDry
    constant Real A=11.7621;
    constant Real B=3874.61;
    constant Real C=229.73;

    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
          C_ExhHex, T(start=TAmb, fixed=true))
      annotation (Placement(transformation(extent={{10,-12},{30,8}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor ambientLoss(G=G_Amb)
      annotation (Placement(transformation(extent={{-46,-22},{-66,-2}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient annotation (
        Placement(transformation(extent={{-110,-10},{-90,10}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
    replaceable package Medium3 =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);
    replaceable package Medium4 =
        DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                        property_T=356, X_a=0.50) constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter Modelica.SIunits.Length l_ExhHex=1
      "Length of the exhaust pipe inside the exhaust heat exchanger" annotation (
        Dialog(tab="Calibration parameters", group="Engine parameters"));
    parameter Modelica.SIunits.PressureDifference dp_CooExhHex=CHPEngData.dp_Coo
      "Pressure drop at nominal mass flow rate inside the coolant circle "
      annotation (Dialog(group="Nominal condition"));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe
                                       dynamicPipe(
      withInsulation=false,
      eps=0,
      diameter=0.03175)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={22,-60})));

    AixLib.FastHVAC.BaseClasses.WorkingFluid
                                        volExhaust
                                         "Fluid volume"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-20,60})));
    AixLib.Utilities.HeatTransfer.HeatConvPipeInsideDynamic
      heatConvExhaustPipeInside(
      d_i=d_iExh,
      A_sur=A_surExhHea,
      rho=rho1_in,
      lambda=lambda1_in,
      eta=eta1_in) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,20})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow additionalHeat
      "Heat flow from water condensation in the exhaust gas and generator losses"
      annotation (Placement(transformation(extent={{60,-22},{40,-2}})));
    Modelica.Blocks.Sources.RealExpression latentExhaustHeat(y=if cHPControlBus.isOn
           then m_ConH2OExh*deltaH_Vap else 0)
                      "Calculated latent exhaust heat from water condensation"
      annotation (Placement(transformation(extent={{126,-12},{106,8}})));

    Real QuoT_ExhInOut=senTExhHot.T/senTExhCold.T
    "Quotient of exhaust gas in and outgoing temperature";

     //Variables for water condensation and its usable latent heat calculation
    Real x_H2OExhDry
      "Water load of the exhaust gas";
    Real xSat_H2OExhDry
      "Saturation water load of the exhaust gas";
    Modelica.SIunits.MassFlowRate m_H2OExh
      "Mass flow of water in the exhaust gas";
    Modelica.SIunits.MassFlowRate m_ExhDry
      "Mass flow of dry exhaust gas";
    Modelica.SIunits.MassFlowRate m_ConH2OExh
      "Mass flow of condensing water";
    Modelica.SIunits.AbsolutePressure pExh
      "Pressure in the exhaust gas stream (assuming ambient conditions)";
    Modelica.SIunits.AbsolutePressure pSatH2OExh
      "Saturation vapor pressure of the exhaust gas water";
    Modelica.SIunits.SpecificEnthalpy deltaH_Vap
      "Specific enthalpy of vaporization (empirical formula based on table data)";
    Modelica.SIunits.SpecificHeatCapacity meanCpExh=1227.23
      "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature"
     annotation (Dialog(group = "Thermal"));
    Modelica.SIunits.HeatFlowRate Q_Gen
      "Calculated loss heat from the induction machine"
     annotation (Dialog(group = "Thermal"));
   /* Modelica.SIunits.HeatFlowRate Q_flowExhHea=senMasFloExh.m_flow*meanCpExh*(
      senTExhHot.T - T_ExhPowUniOut)
    "Calculated exhaust heat from fixed exhaust outlet temperature";*/
    Modelica.SIunits.Temperature T_LogMeanExh
      "Mean logarithmic temperature of exhaust gas";

      //Calculation of the thermodynamic state of the exhaust gas inlet used by the convective heat transfer model
    Medium1.ThermodynamicState state1 = Medium1.setState_pTX(senTExhHot.port_b.p,T_LogMeanExh,senTExhHot.port_b.Xi_outflow);
    Modelica.SIunits.SpecificEnthalpy h1_in = Medium1.specificEnthalpy(state1);
    Modelica.SIunits.DynamicViscosity eta1_in = Medium1.dynamicViscosity(state1);
    Modelica.SIunits.Density rho1_in = Medium1.density_phX(state1.p,h1_in,state1.X);
    Modelica.SIunits.Velocity v1_in=massFlowRate1.m_flow/(Modelica.Constants.pi
        *rho1_in*d_iExh^2/4);
    Modelica.SIunits.ThermalConductivity lambda1_in = Medium1.thermalConductivity(state1);
    Modelica.SIunits.ReynoldsNumber Re1_in = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v1_in,rho1_in,eta1_in,d_iExh);

    Modelica.Blocks.Sources.RealExpression generatorHeat(y=if cHPControlBus.isOn
           then Q_Gen else 0)
      "Calculated heat from generator losses"
      annotation (Placement(transformation(extent={{126,-32},{106,-12}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=2)
      annotation (Placement(transformation(extent={{86,-18},{74,-6}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPControlBus(
      meaTemOutEng=senTCoolCold.T,
      meaTemExhOutHex=senTExhCold.T,
      meaTemExhInHex=senTExhHot.T,
      meaThePowOutHex=dynamicPipe.heatPort_outside.Q_flow,
      meaMasFloConHex=m_ConH2OExh,
      meaTemSupChp=senTCoolHot.T) annotation (Placement(transformation(extent={{
              -28,72},{28,126}}), iconTransformation(extent={{-28,72},{28,126}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_a1
      annotation (Placement(transformation(extent={{-108,52},{-92,68}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_b1
      annotation (Placement(transformation(extent={{92,52},{108,68}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_b2
      annotation (Placement(transformation(extent={{-108,-68},{-92,-52}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_a2
      annotation (Placement(transformation(extent={{92,-68},{108,-52}})));
  equation
  //Calculation of water condensation and its usable latent heat
    if ConTec then
    x_H2OExhDry=senTExhHot.port_a.Xi_outflow[3]/(1 - senTExhHot.port_a.Xi_outflow[3]);
    xSat_H2OExhDry=if noEvent(M_H2O*pSatH2OExh/((pExh-pSatH2OExh)*M_Exh)>=0) then M_H2O*pSatH2OExh/((pExh-pSatH2OExh)*M_Exh) else x_H2OExhDry;
    m_H2OExh=massFlowRate1.m_flow*senTExhHot.port_a.Xi_outflow[3];
    m_ExhDry=massFlowRate1.m_flow - m_H2OExh;
    m_ConH2OExh=if (x_H2OExhDry>xSat_H2OExhDry) then m_ExhDry*(x_H2OExhDry-xSat_H2OExhDry) else 0;
    pExh=senTExhHot.port_a.p;
    pSatH2OExh=100000*Modelica.Math.exp(A-B/(senTExhCold.T-273.15+C));
    deltaH_Vap=2697400+446.25*senTExhCold.T-4.357*(senTExhCold.T)^2;
    else
    x_H2OExhDry=0;
    xSat_H2OExhDry=0;
    m_H2OExh=0;
    m_ExhDry=0;
    m_ConH2OExh=0;
    pExh=0;
    pSatH2OExh=0;
    deltaH_Vap=0;
    end if;

    if (QuoT_ExhInOut-1)>0.0001 then
    T_LogMeanExh=(senTExhHot.T-senTExhCold.T)/Modelica.Math.log(QuoT_ExhInOut);
    else
    T_LogMeanExh=senTExhHot.T;
    end if;

    connect(port_Ambient, ambientLoss.port_b) annotation (Line(points={{-100,0},{-90,
            0},{-90,-12},{-66,-12}}, color={191,0,0}));
    connect(ambientLoss.port_a, heatCapacitor.port)
      annotation (Line(points={{-46,-12},{20,-12}},color={191,0,0}));
    connect(volExhaust.heatPort, heatConvExhaustPipeInside.port_a)
      annotation (Line(points={{-20,69.4},{-20,30}},
                                                   color={191,0,0}));
    connect(heatConvExhaustPipeInside.port_b, heatCapacitor.port)
      annotation (Line(points={{-20,10},{-20,-12},{20,-12}},color={191,0,0}));
    connect(additionalHeat.port, heatCapacitor.port)
      annotation (Line(points={{40,-12},{20,-12}}, color={191,0,0}));
    connect(additionalHeat.Q_flow, multiSum.y)
      annotation (Line(points={{60,-12},{72.98,-12}}, color={0,0,127}));
    connect(latentExhaustHeat.y, multiSum.u[1]) annotation (Line(points={{105,-2},
            {96,-2},{96,-9.9},{86,-9.9}}, color={0,0,127}));
    connect(generatorHeat.y, multiSum.u[2]) annotation (Line(points={{105,-22},{
            96,-22},{96,-14.1},{86,-14.1}}, color={0,0,127}));
    connect(port_a1, senTExhHot.enthalpyPort_a) annotation (Line(points={{-100,60},
            {-90,60},{-90,59.9},{-78.8,59.9}},     color={176,0,0}));
    connect(senTExhCold.enthalpyPort_b, massFlowRate1.enthalpyPort_a)
      annotation (Line(points={{47,59.9},{61.2,59.9},{61.2,60.1}}, color={176,0,
            0}));
    connect(massFlowRate1.enthalpyPort_b, port_b1) annotation (Line(points={{79,60.1},
            {100,60.1},{100,60}},       color={176,0,0}));
    connect(senTCoolCold.enthalpyPort_b, port_a2) annotation (Line(points={{79,
            -60.1},{92,-60.1},{92,-60},{100,-60}}, color={176,0,0}));
    connect(senTCoolHot.enthalpyPort_a, massFlowRate.enthalpyPort_a)
      annotation (Line(points={{-38.8,-60.1},{-61.2,-60.1},{-61.2,-60.1}},
          color={176,0,0}));
    connect(massFlowRate.enthalpyPort_b, port_b2) annotation (Line(points={{-79,
            -60.1},{-100,-60.1},{-100,-60}}, color={176,0,0}));
    connect(dynamicPipe.heatPort_outside, heatCapacitor.port) annotation (Line(
          points={{13.2,-65.2},{6,-65.2},{6,-36},{20,-36},{20,-12}}, color={191,
            0,0}));
    connect(senTCoolHot.enthalpyPort_b, dynamicPipe.enthalpyPort_a1)
      annotation (Line(points={{-21,-60.1},{12.2,-60.1},{12.2,-60}}, color={176,
            0,0}));
    connect(dynamicPipe.enthalpyPort_b1, senTCoolCold.enthalpyPort_a)
      annotation (Line(points={{31.8,-60},{46,-60},{46,-60.1},{61.2,-60.1}},
          color={176,0,0}));
    connect(senTExhHot.enthalpyPort_b, volExhaust.enthalpyPort_a) annotation (
        Line(points={{-61,59.9},{-51.5,59.9},{-51.5,60},{-29,60}}, color={176,0,
            0}));
    connect(volExhaust.enthalpyPort_b, senTExhCold.enthalpyPort_a) annotation (
        Line(points={{-11,60},{2,60},{2,59.9},{29.2,59.9}}, color={176,0,0}));
    annotation (Icon(graphics={
          Rectangle(
            extent={{-70,80},{70,-80}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-99,64},{102,54}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-99,-56},{102,-66}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle.</p>
<p><b>Assumptions</b> </p>
<p>- Berechnung eines konvektiven W&auml;rme&uuml;bergangs zwischen Abgas und W&auml;rme&uuml;bertrager als zylindrisches Abgasrohr</p>
<p>-&gt; F&uuml;r den Rohrquerschnitt wird der Anschlussquerschnitt der Erzeugereinheit verwendet, die w&auml;rme&uuml;bertragende Fl&auml;che und die Kapazit&auml;t des W&auml;rme&uuml;bertragers k&ouml;nnen kalibriert werden</p>
<p>-&gt; Bekannte Gr&ouml;&szlig;en sind die Abgastemperatur bei Austritt und die Gr&ouml;&szlig;enordnung des W&auml;rmestroms an den K&uuml;hlwasserkreislauf</p>
<p>- Die W&auml;rme&uuml;bertragung an die Umgebung (G_Amb) und den K&uuml;hlwasserkreislauf (G_Cool) wird mittels W&auml;rmeleitung berechnet</p>
<p>-&gt; Koeffizienten k&ouml;nnen mittels bekannter Gr&ouml;&szlig;en angen&auml;hert werden</p>
<p>- W&auml;rmeleistung aus der Kondensation von Wasser im Abgas kann ber&uuml;cksichtigt werden</p>
<p>-&gt; Berechnung aus der Bestimmung des ausfallenden Wassers &uuml;ber den S&auml;ttigungsdampfdruck und die kritische Beladung im Abgas f&uuml;r den niedrigsten Zustand (bei Austrittstemperatur)</p>
<p>-&gt; Bestimmung der Verdampfungsenthalpie &uuml;ber eine empirische Formel aus Tabellendaten</p>
<p>-&gt; Annahme: Der latente W&auml;rmestrom geht zus&auml;tzlich zum konvektiven W&auml;rmestrom auf die Kapazit&auml;t des Abgasw&auml;rme&uuml;bertragers &uuml;ber</p>
<p><br>- Calculation of a convective heat transfer between exhaust gas and heat exchanger capacity as a cylindrical exhaust pipe</p>
<p>-&gt; For the pipe cross section, the connection cross section of the power unit is used, the heat transfer area and the capacity of the heat exchanger can be calibrated</p>
<p>-&gt; Known quantities are the exhaust gas temperature at the outlet and the magnitude of the heat flow to the cooling water circuit</p>
<p>- The heat transfer to the environment (G_Amb) and the cooling water circuit (G_Cool) is calculated by means of heat conduction</p>
<p>-&gt; Coefficients can be approximated using known quantities</p>
<p>- Heat output from water condensation in the exhaust gas is can be considered</p>
<p>-&gt; Calculation from the determination of the condensing water over the saturation vapor pressure and the critical load in the exhaust gas for the ExhHex outlet state (lowest temperature)</p>
<p>-&gt; Determination of the enthalpy of vaporization using an empirical formula from tabular data</p>
<p>-&gt; Assumption: The latent heat flow is is added to the convective heat flow to the capacity of the exhaust heat exchanger</p>
</html>"));
  end ExhaustHeatExchanger;

  model gasolineEngineChpModulate
    CHPCombustionEngineModulate cHPCombustionEngine(
      redeclare package Medium1 = Medium_Fuel,
      redeclare package Medium2 = Medium_Air,
      redeclare package Medium3 = Medium_Exhaust,
      T_Amb=T_ambient,
      CHPEngData=CHPEngineModel,
      inertia(phi(fixed=false), w(fixed=false, displayUnit="rad/s")),
      T_logEngCool=T_logEngCool,
      T_ExhCHPOut=T_ExhCHPOut,
      modFac=modFac)
      annotation (Placement(transformation(extent={{-30,0},{30,56}})));
    Fluid.BoilerCHP.ModularCHP.EngineHousing engineToCoolant(
      z=CHPEngineModel.z,
      eps=CHPEngineModel.eps,
      m_Exh=cHPCombustionEngine.m_Exh,
      T_Amb=T_ambient,
      redeclare package Medium3 = Medium_Exhaust,
      dCyl=CHPEngineModel.dCyl,
      hStr=CHPEngineModel.hStr,
      meanCpExh=cHPCombustionEngine.meanCpExh,
      cylToInnerWall(maximumEngineHeat(y=cHPCombustionEngine.Q_therm),
          heatLimit(strict=true)),
      T_Com=cHPCombustionEngine.T_Com,
      nEng=cHPCombustionEngine.nEng,
      lambda=EngMat.lambda,
      rhoEngWall=EngMat.rhoEngWall,
      c=EngMat.c,
      EngMatData=EngMat,
      mEng=mEng,
      dInn=dInn,
      T_ExhPowUniOut=T_ExhCHPOut,
      GEngToAmb=GEngToAmb)
      "A physikal model for calculating the thermal, mass and mechanical output of an ice powered CHP"
      annotation (Placement(transformation(extent={{-22,-52},{22,-8}})));
    replaceable package Medium_Fuel =
        DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_LPG             constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);
    replaceable package Medium_Air =
        DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir   constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);
    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);
    parameter
      DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    parameter Fluid.BoilerCHP.ModularCHP.EngineMaterialData EngMat=
        Fluid.BoilerCHP.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    parameter Modelica.SIunits.Temperature T_ambient=298.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.Thickness dInn=0.005
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Real modFac=cHPControlBus.modFac
      "Modulation factor for energy outuput control of the Chp unit  "
      annotation (Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_logEngCool=356.15 "Logarithmic mean temperature of coolant inside the engine"
      annotation(Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_ExhCHPOut=383.15  "Exhaust gas outlet temperature of CHP unit"
      annotation(Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_Exh=engineToCoolant.T_Exh "Inlet temperature of exhaust gas"
      annotation (Dialog(group="Thermal"));

    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
        Placement(transformation(rotation=0, extent={{-114,-6},{-94,14}}),
          iconTransformation(extent={{-114,-6},{-94,14}})));
    Interfaces.EnthalpyPort_b             port_Exhaust
                          annotation (Placement(transformation(rotation=0, extent={{94,-6},
              {106,6}}),          iconTransformation(extent={{86,-14},{106,6}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient annotation (
        Placement(transformation(rotation=0, extent={{-10,-100},{10,-80}}),
          iconTransformation(extent={{-10,-100},{10,-80}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
      annotation (Placement(transformation(rotation=0, extent={{90,-98},{110,-78}}),
          iconTransformation(extent={{90,-98},{110,-78}})));
    Controls.Interfaces.CHPControlBus cHPControlBus(
      meaRotEng=cHPCombustionEngine.nEng,
      meaFuePowEng=cHPCombustionEngine.P_Fue,
      meaThePowEng=cHPCombustionEngine.Q_therm,
      meaTorEng=cHPCombustionEngine.Mmot,
      meaMasFloFueEng=cHPCombustionEngine.m_Fue,
      meaMasFloAirEng=cHPCombustionEngine.m_Air,
      meaMasFloCO2Eng=cHPCombustionEngine.m_CO2Exh) annotation (Placement(
          transformation(
          extent={{-30,-32},{30,32}},
          rotation=0,
          origin={0,92}), iconTransformation(
          extent={{-26,-26},{26,26}},
          rotation=0,
          origin={0,88})));
    Modelica.Blocks.Interfaces.BooleanInput isOn annotation (Placement(
          transformation(rotation=270,
                                     extent={{-10,-10},{10,10}},
          origin={-80,104}),
          iconTransformation(extent={{-11,-11},{11,11}},
          rotation=0,
          origin={-99,47})));

  equation
    connect(port_Ambient, engineToCoolant.port_Ambient)
      annotation (Line(points={{0,-90},{0,-52}}, color={191,0,0}));
    connect(port_CoolingCircle, engineToCoolant.port_CoolingCircle)
      annotation (Line(points={{100,-88},{100,-30},{22,-30}}, color={191,0,0}));
    connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
      annotation (Line(points={{0,-3.16},{0,8.4}}, color={0,0,127}));
    connect(cHPCombustionEngine.flange_a, flange_a) annotation (Line(points={{-30,
            28},{-68,28},{-68,4},{-104,4}}, color={0,0,0}));
    connect(isOn, cHPCombustionEngine.isOn) annotation (Line(points={{-80,104},{
            -80,46},{-30,46},{-30,46.48}}, color={255,0,255}));
    connect(cHPCombustionEngine.port_Exhaust, port_Exhaust) annotation (Line(
          points={{30,28},{58,28},{58,0},{100,0}}, color={176,0,0}));
    annotation (Icon(graphics={
            Bitmap(extent={{-136,-134},{144,160}}, fileName=
                "modelica://AixLib/../../Nützliches/Modelica Icons_Screenshots/Icon_ICE.png")}));
  end gasolineEngineChpModulate;

  model CHPCombustionEngineModulate
    "Internal combustion engine model for CHP-applications."
    import AixLib;

    replaceable package Medium1 =
        DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true,
        Documentation(revisions="<html>
</html>"));
    replaceable package Medium2 =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                              constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);

    replaceable package Medium3 =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_SenerTecDachsG5_5()
      "Needed engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    constant Modelica.SIunits.Volume VCyl = CHPEngData.VEng/CHPEngData.z "Cylinder displacement";
    type RotationSpeed=Real(final unit="1/s", min=0);
    constant RotationSpeed nEngNominal = 25.583 "Nominal engine speed at operating point";
    constant Modelica.SIunits.Power P_mecNominal = CHPEngData.P_mecNominal "Mecanical power output at nominal operating point";
    parameter Modelica.SIunits.Temperature T_Amb=298.15     "Ambient temperature (matches to fuel and combustion air temperature)";
    type GasConstant=Real(final unit="J/(mol.K)");
    constant GasConstant R = 8.31446 "Gasconstant for calculation purposes";
    constant Real QuoDCyl = CHPEngData.QuoDCyl;
    constant Boolean FuelType = Medium1.isGas "True = Gasoline fuel, False = Liquid fuel";
    constant Modelica.SIunits.MassFlowRate m_MaxExh=CHPEngData.P_FueNominal/H_U*(1
         + Lambda*L_St)
      "Maximal exhaust gas flow based on the fuel and combustion properties";
    constant Modelica.SIunits.Mass m_FueEngRot=CHPEngData.P_FueNominal*60/(H_U*
        CHPEngData.nEngMax*CHPEngData.i)
      "Injected fuel mass per engine rotation(presumed as constant)";
    constant Modelica.SIunits.Pressure p_Amb = 101325 "Ambient pressure";
    constant Modelica.SIunits.Pressure p_mi = p_mfNominal+p_meNominal "Constant indicated mean effective cylinder pressure";
    constant Modelica.SIunits.Pressure p_meNominal = CHPEngData.p_meNominal "Nominal mean effective cylinder pressure";
    constant Modelica.SIunits.Pressure ref_p_mfNominal = CHPEngData.ref_p_mfNominal "Friction mean pressure of reference engine for calculation(dCyl=91mm & nEng=3000rpm & TEng=90°C)";
    constant Modelica.SIunits.Pressure p_mfNominal=ref_p_mfNominal*QuoDCyl^(-0.3) "Nominal friction mean pressure";
    constant Modelica.SIunits.Temperature T_ExhOut = CHPEngData.T_ExhPowUniOut "Assumed exhaust gas outlet temperature of the CHP unit for heat calculations";
    constant Modelica.SIunits.SpecificEnergy H_U = Medium1.H_U "Specific calorific value of the fuel";
    constant Real Lambda=CHPEngData.Lambda "Combustion air ratio";
    constant Real L_St = Medium1.L_st "Stoichiometric air consumption per mass fuel";
    constant Real l_Min = L_St*MM_Fuel/MM_Air "Minimum molar air consumption per mole fuel";
    constant Modelica.SIunits.MolarMass MM_Fuel = Medium1.MM "Molar mass of the fuel";
    constant Modelica.SIunits.MolarMass MM_Air = Medium2.MM "Molar mass of the combustion air";
    constant Modelica.SIunits.MolarMass MM_ComExh[:] = Medium3.data[:].MM "Molar masses of the combustion products: N2, O2, H2O, CO2";
    constant Real expFacCpComExh[:] = {0.11, 0.15, 0.20, 0.30} "Exponential factor for calculating the specific heat capacity of N2, O2, H2O, CO2";
    constant Modelica.SIunits.SpecificHeatCapacity cpRefComExh[:] = {1000, 900, 1750, 840} "Specific heat capacities of the combustion products at reference state at 0°C";
    constant Modelica.SIunits.Temperature RefT_Com = 1473.15 "Reference combustion temperature for calculation purposes";

    // Exhaust composition for gasoline fuels

    constant Real n_N2Exh = if FuelType then Medium1.moleFractions_Gas[1] + Lambda*l_Min*Medium2.moleFractions_Air[1]
    else Lambda*l_Min*Medium2.moleFractions_Air[1] "Exhaust: Number of molecules Nitrogen per mole of fuel";
    constant Real n_O2Exh = (Lambda-1)*l_Min*Medium2.moleFractions_Air[2] "Exhaust: Number of molecules Oxygen per mole of fuel";
    constant Real n_H2OExh = if FuelType then 0.5*sum(Medium1.moleFractions_Gas[i]*Medium1.Fuel.nue_H[i] for i in 1:size(Medium1.Fuel.nue_H, 1))
    else 0.5*(Medium1.Fuel.Xi_liq[2]*Medium1.MM/Medium1.Fuel.MMi_liq[2]) "Exhaust: Number of molecules H20 per mole of fuel";
    constant Real n_CO2Exh = if FuelType then sum(Medium1.moleFractions_Gas[i]*Medium1.Fuel.nue_C[i] for i in 1:size(Medium1.Fuel.nue_C, 1))
    else Medium1.Fuel.Xi_liq[1]*Medium1.MM/Medium1.Fuel.MMi_liq[1] "Exhaust: Number of molecules CO2 per mole of fuel";
    constant Real n_ComExh[:] = {n_N2Exh, n_O2Exh, n_H2OExh, n_CO2Exh};
    constant Real n_Exh = sum(n_ComExh[j] for j in 1:size(n_ComExh, 1)) "Number of exhaust gas molecules per mole of fuel";
    constant Modelica.SIunits.MolarMass MM_Exh = sum(n_ComExh[i]*MM_ComExh[i] for i in 1:size(n_ComExh, 1))/sum(n_ComExh[i] for i in 1:size(n_ComExh, 1))
    "Molar mass of the exhaust gas";
    constant Modelica.SIunits.MassFraction X_N2Exh =  MM_ComExh[1]*n_ComExh[1]/(MM_Exh*n_Exh)  "Mass fraction of N2 in the exhaust gas";
    constant Modelica.SIunits.MassFraction X_O2Exh =  MM_ComExh[2]*n_ComExh[2]/(MM_Exh*n_Exh)  "Mass fraction of O2 in the exhaust gas";
    constant Modelica.SIunits.MassFraction X_H2OExh =  MM_ComExh[3]*n_ComExh[3]/(MM_Exh*n_Exh)  "Mass fraction of H2O in the exhaust gas";
    constant Modelica.SIunits.MassFraction X_CO2Exh =  MM_ComExh[4]*n_ComExh[4]/(MM_Exh*n_Exh)  "Mass fraction of CO2 in the exhaust gas";
    constant Modelica.SIunits.MassFraction Xi_Exh[size(n_ComExh, 1)] = {X_N2Exh, X_O2Exh, X_H2OExh, X_CO2Exh};

   // RotationSpeed nEng(max=CHPEngData.nEngMax) = 25.583 "Current engine speed";

    Boolean SwitchOnOff=isOn "Operation of electric machine (true=On, false=Off)";
    RotationSpeed nEng(min=0) "Current engine speed";
    Modelica.SIunits.MassFlowRate m_Exh "Mass flow rate of exhaust gas";
    Modelica.SIunits.MassFlowRate m_CO2Exh "Mass flow rate of CO2 in the exhaust gas";
    Modelica.SIunits.MassFlowRate m_Fue(min=0) "Mass flow rate of fuel";
    Modelica.SIunits.MassFlowRate m_Air(min=0) "Mass flow rate of combustion air";
    Modelica.SIunits.SpecificHeatCapacity meanCpComExh[size(n_ComExh, 1)] "Calculated specific heat capacities of the exhaust gas components for the calculated combustion temperature";
    Modelica.SIunits.SpecificHeatCapacity meanCpExh "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature";
    Modelica.SIunits.SpecificEnergy h_Exh = 1000*(-286 + 1.011*T_ExhCHPOut - 27.29*Lambda + 0.000136*T_ExhCHPOut^2 - 0.0255*T_ExhCHPOut*Lambda + 6.425*Lambda^2) "Specific enthalpy of the exhaust gas";
    Modelica.SIunits.Power P_eff "Effective(mechanical) engine power";
    Modelica.SIunits.Power P_Fue(min=0) = m_Fue*H_U "Fuel expenses at operating point";
    Modelica.SIunits.Power H_Exh "Enthalpy stream of the exhaust gas";
    Modelica.SIunits.Power CalQ_therm "Calculated heat from engine combustion";
    Modelica.SIunits.Power Q_therm(min=0) "Total heat from engine combustion";
    Modelica.SIunits.Torque Mmot "Calculated engine torque";
    Modelica.SIunits.Temperature T_logEngCool=356.15 "Logarithmic mean temperature of coolant inside the engine"
    annotation(Dialog(group="Parameters"));
    Modelica.SIunits.Temperature T_Com(start=T_Amb) "Temperature of the combustion gases";
    Modelica.SIunits.Temperature T_ExhCHPOut=383.15 "Exhaust gas outlet temperature of CHP unit"
    annotation(Dialog(group="Parameters"));
    Real modFac=1 "Modulation factor for energy outuput control of the Chp unit"
      annotation (Dialog(group="Modulation"));

    // Dynamic engine friction calculation model for the mechanical power and heat output of the combustion engine

    Real A0 = 1.0895-1.079*10^(-2)*(T_logEngCool-273.15)+5.525*10^(-5)*(T_logEngCool-273.15)^2;
    Real A1 = 4.68*10^(-4)-5.904*10^(-6)*(T_logEngCool-273.15)+1.88*10^(-8)*(T_logEngCool-273.15)^2;
    Real A2 = -4.35*10^(-8)+1.12*10^(-9)*(T_logEngCool-273.15)-4.79*10^(-12)*(T_logEngCool-273.15)^2;
    Real B0 = -2.625*10^(-3)+3.75*10^(-7)*(nEng*60)+1.75*10^(-5)*(T_logEngCool-273.15)+2.5*10^(-9)*(T_logEngCool-273.15)*(nEng*60);
    Real B1 = 8.95*10^(-3)+1.5*10^(-7)*(nEng*60)+7*10^(-6)*(T_logEngCool-273.15)-10^(-9)*(T_logEngCool-273.15)*(nEng*60);
    Modelica.SIunits.Pressure p_mf = p_mfNominal*((A0+A1*(nEng*60)+A2*(nEng*60)^2)+(B0+B1*(p_meNominal/100000))) "Current friction mean pressure at operating point";
    Modelica.SIunits.Pressure p_me = (modFac*p_mi)-p_mf "Current mean effective pressure at operating point";
    Real etaMec = p_me/p_mi "Current percentage of usable mechanical power compared to inner cylinder power from combustion";

    AixLib.FastHVAC.Interfaces.EnthalpyPort_b
                                          port_Exhaust
      annotation (Placement(transformation(extent={{104,-4},{96,4}})));
    AixLib.FastHVAC.Components.Pumps.FluidSource
                                            exhaustFlow
      annotation (Placement(transformation(extent={{62,-10},{80,8}})));
    Modelica.Blocks.Sources.RealExpression massFlowExhaust(y=m_Exh)
      annotation (Placement(transformation(extent={{28,-32},{50,-8}})));
    Modelica.Blocks.Sources.RealExpression effectiveMechanicalTorque(y=Mmot)
      annotation (Placement(transformation(extent={{18,-12},{-6,12}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Mechanics.Rotational.Sources.Torque engineTorque annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-30,0})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.5*CHPEngData.z/4)
                                                                  annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-68,0})));

    Modelica.Blocks.Interfaces.RealInput exhaustGasTemperature
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-1.77636e-15,-104}),
                            iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={0,-70})));
    Modelica.Blocks.Interfaces.BooleanInput isOn annotation (Placement(
          transformation(rotation=0, extent={{-122,44},{-90,76}}),
          iconTransformation(extent={{-110,56},{-90,76}})));
  equation

  for i in 1:size(n_ComExh, 1) loop
    meanCpComExh[i] = cpRefComExh[i]/(expFacCpComExh[i] + 1)/(T_Com/273.15 - 1)*(-1 + (T_Com/273.15)^(expFacCpComExh[i] + 1));
    end for;
    meanCpExh = sum(meanCpComExh[i]*Xi_Exh[i] for i in 1:size(n_ComExh, 1));
    m_Fue = modFac*m_FueEngRot*nEng*CHPEngData.i/60;
    m_Air = m_Fue*Lambda*L_St;
   // m_Exh = m_Fue + m_Air;
    m_CO2Exh = m_Fue*(1+Lambda*L_St)*X_CO2Exh;
    H_Exh = h_Exh*m_Fue*(1+Lambda*L_St);
    if inertia.w>=80 and SwitchOnOff then
    Mmot = CHPEngData.i*p_me*CHPEngData.VEng/(2*Modelica.Constants.pi);
    nEng = inertia.w/(2*Modelica.Constants.pi);
    m_Exh = m_Fue + m_Air;
    elseif inertia.w>=80 and not
                                (SwitchOnOff) then
    Mmot = -CHPEngData.i*p_mf*CHPEngData.VEng/(2*Modelica.Constants.pi);
    nEng = inertia.w/(2*Modelica.Constants.pi);
    m_Exh = m_Fue + m_Air + 0.0001;
    elseif inertia.w<80 and noEvent(inertia.w>0.1) then
    Mmot = -CHPEngData.i*p_mf*CHPEngData.VEng/(2*Modelica.Constants.pi);
    nEng = inertia.w/(2*Modelica.Constants.pi);
    m_Exh = m_Fue + m_Air + 0.0001;
    else
    Mmot = 0;
    nEng = 0;
    m_Exh = 0.001;
    end if;
    CalQ_therm = P_Fue - P_eff - H_Exh;
    Q_therm = if (nEng>1) and (CalQ_therm>=10) then CalQ_therm else 0;
    T_Com = (H_U-(60*p_me*CHPEngData.VEng)/m_FueEngRot)/((1 + Lambda*L_St)*meanCpExh) + T_Amb;
    P_eff = CHPEngData.i*nEng*p_me*CHPEngData.VEng;
   /* if m_Fue>0 then
  T_Com = (P_Fue - P_eff)/(m_Fue*(1 + Lambda*L_St)*meanCpExh) + T_Amb;
  else
  T_Com = T_Amb;
  end if;  */

    connect(inertia.flange_b, flange_a) annotation (Line(points={{-78,
            1.33227e-015},{-100,1.33227e-015},{-100,0}},
                             color={0,0,0}));
    connect(inertia.flange_a, engineTorque.flange)
      annotation (Line(points={{-58,-1.33227e-015},{-58,1.33227e-015},{-40,
            1.33227e-015}},                    color={0,0,0}));
    connect(engineTorque.tau, effectiveMechanicalTorque.y) annotation (Line(
          points={{-18,-1.55431e-015},{-12,-1.55431e-015},{-12,0},{-7.2,0}},
          color={0,0,127}));
    connect(exhaustFlow.enthalpyPort_b, port_Exhaust) annotation (Line(points={
            {80,-0.1},{90,-0.1},{90,0},{100,0}}, color={176,0,0}));
    connect(massFlowExhaust.y, exhaustFlow.dotm) annotation (Line(points={{51.1,
            -20},{58,-20},{58,-3.34},{63.8,-3.34}}, color={0,0,127}));
    connect(exhaustFlow.T_fluid, exhaustGasTemperature) annotation (Line(points=
           {{63.8,2.78},{63.8,4},{20,4},{20,-14},{0,-14},{0,-104}}, color={0,0,
            127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-120,-134},{122,134}}, fileName=
                "modelica://AixLib/../../Nützliches/Modelica Icons_Screenshots/Icon_ICE.png"),
          Text(
            extent={{-100,80},{100,64}},
            lineColor={28,108,200},
            textStyle={TextStyle.Bold},
            textString="%name")}),                                 Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(revisions="<html>
</html>",   info="<html>
<p>Getroffene Annahmen und daraus resultierende Einschr&auml;nkungen des Modells Verbrennungsmotor:</p>
<p>- Volllast- / Nennleistungspunkt der Erzeugereinheit ist bekannt und Wechsel zwischen Stillstand und Volllastbetrieb wird angenommen </p>
<p>-&gt; Modellierender Betrieb ist noch nicht implementiert</p>
<p>- Steuerung des Motors erfolgt &uuml;ber die Freigabe der Brennstoffmenge ab einer Mindestdrehzahl (800rpm) / Die Drehzahl steigt dann bis zum Gleichgewicht mit dem entgegen wirkendem Generatormoment an</p>
<p>- Vollst&auml;ndige und &uuml;berst&ouml;chiometrische Verbrennung wird angenommen zur L&ouml;sung der Bruttoreaktionsgleichung</p>
<p>-&gt; Motor l&auml;uft deutlich unterhalb seiner Leistungsgrenze zur m&ouml;glichst optimalen und schadstoffarmen Brennstoffausnutzung</p>
<p>- Wandtemperatur im Zylinder wird &uuml;ber die gesamte Fl&auml;che gleich angenommen (zeitlich variabel und r&auml;umlich konstant)</p>
<p>-&gt; Berechnung eines gemittelten W&auml;rmeflusses nach Au&szlig;en (Zyklische Betrachtung ist nicht umsetzbar wegen geringem Datenumfang)</p>
<p>- Eintritt von Luft und Brennstoff bei Umgebungsbedingungen und konstante Kraftstoff- und Luftmenge je Verbrennungszyklus</p>
<p>-&gt; Gilt nur bedingt bei Turboaufladung der Motoren, da so die Zylinderf&uuml;llung je nach Ladedruck variieren kann (Geringf&uuml;gige Ber&uuml;cksichtigung durch hinterlegte Nennleistungsdaten)</p>
<p>-&gt; Kommt bei BHKWs gro&szlig;er Leistung zu Einsatz</p>
<p>- Luftverh&auml;ltnis oder Restsauerstoff im Abgas ist bekannt</p>
<p>-&gt; Notwendige Annahme zur Berechnung der Stofffl&uuml;sse (Massenfl&uuml;sse, Zusammensetzung des Abgases)</p>
<p>- Verwendung einer gemittelten spezifischen W&auml;rmekapazit&auml;t des Abgases f&uuml;r einen Temperaturbereich von 0&deg;C bis zur maximalen adiabaten Verbrennungstemperatur</p>
<p>-&gt; Bestimmung &uuml;ber einen Potenzansatz nach M&uuml;ller(1968)</p>
<p>- Reibverluste werden in nutzbare W&auml;rme umgewandelt</p>
<p>- Berechnung der Abgasenthalpie nach einem empirischen Ansatz auf Grundlage von Untersuchungen durch R.Pischinger</p>
<p>-&gt; Verwendung einer Nullpunkttemperatur von 25&deg;C (Eingangszustand der Reaktionsedukte in Verbrennungsluft und Kraftstoff)</p>
<p>-&gt; Ber&uuml;cksichtigung chemischer und thermischer Anteile der Enthalpie</p>
<p>-&gt; Eingeschr&auml;nkte Genauigkeit f&uuml;r dieselmotorische (nicht-vorgemischte) Prozesse</p>
<p>- Enthaltenes Wasser im Kraftstoff oder der Verbrennungsluft wird nicht ber&uuml;cksichtigt</p>
<p>-&gt; Annahme der Lufttrocknung vor Eintritt in Erzeugereinheit -&gt; SONST: Zus&auml;tzliche Schwankungen durch Wettereinfl&uuml;sse m&uuml;ssten ber&uuml;cksichtigt werden</p>
<p>- Nebenprodukte der Verbrennung bleiben unber&uuml;cksichtigt (Stickoxide, Wasserstoff usw.)</p>
<p>-&gt; Umfassende Kenntnis des Verbrennungsprozesses und des Motors notwendig (Geringf&uuml;gige Ber&uuml;cksichtigung in Energiebilanz, da Abgasenthalpie auf empirischen Ansatz nach Messungen beruht)</p>
<p>- Annahme einer direkten Kopplung zwischen Motor und Generator (keine &Uuml;bersetzung dazwischen: n_Mot = n_Gen)</p>
<p>-&gt; Kann aber mithilfe von mechanischen Modulen eingebracht werden</p>
<p>- Annahme eines konstanten indizierten Mitteldrucks als notwendige Ma&szlig;nahme zur Berechnung der Motorleistung </p>
<p>-&gt; Bedeutet, dass der Verbrennungsmotor mit einem gleichbleibenden thermodynamischen Kreisprozess arbeitet</p>
<p>- Ausgehend von einem bekannten Reibmitteldruck bei einer Drehzahl von 3000rpm (falls nicht bekannt, default Mittelwerte aus VK1 von S. Pischinger) wird drehzahl- und temperaturabh&auml;ngig der Reibmitteldruck bestimmt</p>
<p>-&gt; Unterscheidung zwischen SI- und DI-Motor - Weitere Motorenbauarten sind unber&uuml;cksichtigt!</p>
<p><br><br><b><span style=\"color: #005500;\">Assumptions</span></b></p>
<p><br><br>Assumptions made and resulting limitations of the internal combustion engine model:</p>
<p>- Full load / nominal operating point of the power unit is known and a change between standstill and full load operation is assumed</p>
<p>-&gt; Modeling operation is not implemented yet</p>
<p>- The engine is controlled by the release of the fuel quantity from a minimum speed (800rpm) / The speed then increases to equilibrium with the counteracting generator torque</p>
<p>- Complete and superstoichiometric combustion is assumed to solve the gross reaction equation</p>
<p>-&gt; Engine runs well below its performance limit for optimum and low-emission fuel utilization</p>
<p>- Wall temperature in the cylinder is assumed to be the same over the entire surface (variable in time and spatially constant)</p>
<p>-&gt; Calculation of a mean heat flow to the outside (cyclic analysis is not feasible due to missing data)</p>
<p>- Entry of air and fuel at ambient conditions and constant amount of fuel and air per combustion cycle</p>
<p>-&gt; Only conditionally with turbocharging of the engines, since then the cylinder filling can vary depending on the boost pressure (slight consideration due to stored rated performance data)</p>
<p>-&gt; Used in CHPs of high performance</p>
<p>- Air ratio or residual oxygen in the exhaust gas is known</p>
<p>-&gt; Necessary assumption for the calculation of material flows (mass flows, composition of the exhaust gas)</p>
<p>- Use of the mean specific heat capacity of the exhaust gas for a temperature range from 0 &deg; C to the maximum adiabatic combustion temperature</p>
<p>-&gt; Determination of a potency approach according to M&uuml;ller (1968)</p>
<p>- Frictional losses are converted into usable heat</p>
<p>- Calculation of the exhaust gas enthalpy according to an empirical approach based on investigations by R.Pischinger</p>
<p>-&gt; Use of a reference point temperature of 25 &deg; C (initial state of the reaction educts from combustion air and fuel)</p>
<p>-&gt; Consideration of the chemical and thermal proportions of the enthalpy</p>
<p>-&gt; Limited accuracy for diesel engine (non-premixed) processes</p>
<p>- Contained water in the fuel or the combustion air is not considered</p>
<p>-&gt; Assumption of air drying before entering power unit -&gt; ELSE: Additional fluctuations due to weather conditions must be taken into account</p>
<p>- Combustion by-products are ignored (nitrogen oxides, hydrogen, etc.)</p>
<p>-&gt; Comprehensive knowledge of the combustion process and the engine necessary (slight consideration in energy balance, since exhaust enthalpy is based on empirical approach after exhaust gas measurements)</p>
<p>- Assumption of a direct coupling between engine and generator (no translation in between: n_Mot = n_Gen)</p>
<p>-&gt; Can be introduced by means of mechanical modules</p>
<p>- Assumption of a constant indicated mean pressure as a necessary measure for the calculation of engine power</p>
<p>-&gt; Means that the combustion engine operates with a constant thermodynamic cycle</p>
<p>- Based on a known friction mean pressure at a speed of 3000rpm (if not known, default average values ​​from VK1 by S.Pischinger) - Is dependent on speed and temperature of the engine</p>
<p>-&gt; Distinction between SI and DI engine - Other engine types are not considered!</p>
</html>"));
  end CHPCombustionEngineModulate;
end ModularCHP;
