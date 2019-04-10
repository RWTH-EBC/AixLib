within AixLib.Fluid.BoilerCHP.ModularCHP;
package BaseClasses "Package with base classes for AixLib.Fluid.BoilerCHP.ModularCHP"
  extends Modelica.Icons.BasesPackage
annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.BoilerCHP.ModularCHP\">AixLib.Fluid.BoilerCHP.ModularCHP</a>.
</p>
</html>"));
  model ModularCHP_PowerUnit "Model of modular CHP power unit"
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
    replaceable package Medium_Coolant =
        Modelica.Media.Air.DryAirNasa     constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

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

    Modelica.Fluid.Sources.FixedBoundary outletExhaustGas(
      redeclare package Medium = Medium_Exhaust,
      p=p_amb,
      nPorts=1)
      annotation (Placement(transformation(extent={{112,30},{92,50}})));

    parameter Modelica.SIunits.Temperature T_amb=298.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.AbsolutePressure p_amb=101325
      "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
   // Modelica.SIunits.Temperature T_CoolRet=350.15
   //   "Coolant return temperature" annotation (Dialog(tab="Engine Cooling Circle"));
    Modelica.SIunits.Temperature T_CooSup=submodel_Cooling.senTCooEngOut.T
      "Coolant supply temperature";
    Modelica.SIunits.Power Q_Therm=if (submodel_Cooling.heatPort_outside.Q_flow+exhaustHeatExchanger.pipeCoolant.heatPort_outside.Q_flow)>10
    then submodel_Cooling.heatPort_outside.Q_flow+exhaustHeatExchanger.pipeCoolant.heatPort_outside.Q_flow
    else 1 "Thermal power output of the CHP unit";
    Modelica.SIunits.Power P_Mech=gasolineEngineChp.cHPCombustionEngine.P_eff "Mechanical power output of the CHP unit";
    Modelica.SIunits.Power P_El=-inductionMachine.P_E
      "Electrical power output of the CHP unit";
    Modelica.SIunits.Power P_Fuel=if (gasolineEngineChp.cHPEngBus.isOn) then
        m_flow_Fue*Medium_Fuel.H_U else 0 "CHP fuel expenses";
    Modelica.SIunits.Power Q_TotUnused=gasolineEngineChp.cHPCombustionEngine.Q_therm-gasolineEngineChp.engineToCoolant.actualHeatFlowEngine.Q_flow+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total heat error of the CHP unit";
   // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
    Modelica.SIunits.MassFlowRate m_flow_CO2=gasolineEngineChp.cHPCombustionEngine.m_flow_CO2Exh
      "CO2 emission output rate";
    Modelica.SIunits.MassFlowRate m_flow_Fue=if (gasolineEngineChp.cHPCombustionEngine.m_flow_Fue)
         > 0.0001 then gasolineEngineChp.cHPCombustionEngine.m_flow_Fue else
        0.0001 "Fuel consumption rate of CHP unit";
    type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
    SpecificEmission b_CO2=if noEvent(abs(Q_Therm + P_El) > 0) then 3600000000*
        m_flow_CO2/(Q_Therm + P_El) else 0
      "Specific CO2 emissions per kWh (heat and power)";
    SpecificEmission b_e=if noEvent(abs(Q_Therm + P_El) > 0) then 3600000000*
        m_flow_Fue/(Q_Therm + P_El) else 0
      "Specific fuel consumption per kWh (heat and power)";
    Real FueUtiRate=(Q_Therm + P_El)/(m_flow_Fue*Medium_Fuel.H_U)
      "Fuel utilization rate of the CHP unit";
    Real PowHeatRatio = P_El/Q_Therm "Power to heat ration of the CHP unit";
    Real eta_Therm=Q_Therm/(m_flow_Fue*Medium_Fuel.H_U)
      "Thermal efficiency of the CHP unit";
    Real eta_Mech=P_Mech/(m_flow_Fue*Medium_Fuel.H_U)
      "Mechanical efficiency of the CHP unit";
    Real eta_El=P_El/(m_flow_Fue*Medium_Fuel.H_U)
      "Mechanical efficiency of the CHP unit";

    parameter Real s_til=abs((inductionMachine.s_nominal*(inductionMachine.M_til/
        inductionMachine.M_nominal) + inductionMachine.s_nominal*sqrt(abs(((
        inductionMachine.M_til/inductionMachine.M_nominal)^2) - 1 + 2*
        inductionMachine.s_nominal*((inductionMachine.M_til/inductionMachine.M_nominal)
         - 1))))/(1 - 2*inductionMachine.s_nominal*((inductionMachine.M_til/
        inductionMachine.M_nominal) - 1))) "Tilting slip of electric machine"
      annotation (Dialog(tab="Calibration parameters", group="Fast calibration - Electric power and fuel usage"));
    parameter Real calFac=1
      "Calibration factor for electric power output (default=1)"
      annotation (Dialog(tab="Calibration parameters",
      group="Fast calibration - Electric power and fuel usage"));
    parameter Modelica.SIunits.ThermalConductance GEngToCoo=33
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Calibration parameters",group=
            "Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.ThermalConductance GCooExhHex=400
      "Thermal conductance of exhaust heat exchanger to cooling circuit"
      annotation (Dialog(tab="Calibration parameters",group=
            "Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.SIunits.HeatCapacity CExhHex=50000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
       Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Modelica.SIunits.Thickness dInn=0.01
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Calibration parameters",group="Fast calibration - Thermal power output"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Calibration parameters",group=
            "Advanced calibration parameters"));
    parameter Modelica.SIunits.ThermalConductance GAmb=5
      "Constant thermal conductance of material" annotation (Dialog(tab=
            "Calibration parameters",
          group="Advanced calibration parameters"));
  //  parameter Modelica.SIunits.Temperature T_HeaRet = 303.15
  //    "Constant heating circuit return temperature"
  //    annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.Area A_surExhHea=50
      "Surface for exhaust heat transfer"
      annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=
        CHPEngineModel.m_floCooNominal
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
            "Calibration parameters", group="Advanced calibration parameters"));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature(T=
         T_amb)
      annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(extent={{-64,-8},{-80,8}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.ExhaustHeatExchanger
      exhaustHeatExchanger(
      cHPExhHexBus(meaTemRetChp=exhaustHeatExchanger.senTCooCold.T),
      pipeCoolant(
        p_a_start=system.p_start,
        p_b_start=system.p_start,
        use_HeatTransferConvective=false,
        isEmbedded=true,
        diameter=CHPEngineModel.dCoo,
        allowFlowReversal=allowFlowReversalCoolant),
      T_Amb=T_amb,
      p_Amb=p_amb,
      T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
      meanCpExh=gasolineEngineChp.cHPCombustionEngine.meanCpExh,
      redeclare package Medium3 = Medium_Exhaust,
      redeclare package Medium4 = Medium_Coolant,
      d_iExh=CHPEngineModel.dExh,
      dp_CooExhHex=CHPEngineModel.dp_Coo,
      heatConvExhaustPipeInside(length=exhaustHeatExchanger.l_ExhHex),
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
      CExhHex=CExhHex,
      GCoo=GCooExhHex,
      GAmb=GAmb) annotation (Placement(transformation(extent={{40,4},{68,32}})));

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
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mExh_flow_small=0.0001
      "Small exhaust mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.0001
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.CHP_ElectricMachine
      inductionMachine(
      CHPEngData=CHPEngineModel,
      useHeat=useGenHea,
      calFac=calFac,
      s_til=s_til)
      annotation (Placement(transformation(extent={{-66,12},{-36,42}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_retCoo(redeclare package Medium =
          Medium_Coolant)
      annotation (Placement(transformation(extent={{-90,-68},{-70,-48}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_supCoo(redeclare package Medium =
          Medium_Coolant)
      annotation (Placement(transformation(extent={{70,-68},{90,-48}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.GasolineEngineChp
      gasolineEngineChp(
      redeclare package Medium_Fuel = Medium_Fuel,
      redeclare package Medium_Air = Medium_Air,
      redeclare package Medium_Exhaust = Medium_Exhaust,
      CHPEngineModel=CHPEngineModel,
      EngMat=EngMat,
      T_amb=T_amb,
      mEng=mEng,
      cHPCombustionEngine(T_ExhCHPOut=exhaustHeatExchanger.senTExhCold.T,
          T_logEngCool=gasolineEngineChp.T_logEngCoo),
      engineToCoolant(T_ExhPowUniOut=exhaustHeatExchanger.senTExhCold.T),
      dInn=dInn,
      GEngToAmb=GEngToAmb) annotation (Placement(transformation(rotation=0,
            extent={{-18,8},{18,44}})));
    AixLib.Controls.Interfaces.CHPControlBus     sigBusCHP(
      meaThePowChp=Q_Therm,
      calEmiCO2Chp=b_CO2,
      calFueChp=b_e,
      calEtaTheChp=eta_Therm,
      calEtaElChp=eta_El,
      calFueUtiChp=FueUtiRate) annotation (Placement(transformation(extent={{-28,68},
              {26,118}}), iconTransformation(extent={{-28,68},{26,118}})));

    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.Submodel_Cooling
      submodel_Cooling(
      sigBus_coo(meaTemInEng=submodel_Cooling.senTCooEngIn.T, meaTemOutEng=
            submodel_Cooling.senTCooEngOut.T),
      redeclare package Medium_Coolant = Medium_Coolant,
      CHPEngineModel=CHPEngineModel,
      m_flow=m_flow,
      GEngToCoo=GEngToCoo,
      allowFlowReversalCoolant=allowFlowReversalCoolant,
      mCool_flow_small=mCool_flow_small) annotation (Placement(transformation(
            rotation=0, extent={{14,-72},{42,-44}})));

  equation
    connect(exhaustHeatExchanger.port_b1, outletExhaustGas.ports[1]) annotation (
        Line(points={{68,26.4},{80,26.4},{80,40},{92,40}},
                                                         color={0,127,255}));
    connect(ambientTemperature.port, heatFlowSensor.port_b)
      annotation (Line(points={{-92,0},{-80,0}}, color={191,0,0}));
    connect(inductionMachine.flange_genIn, gasolineEngineChp.flange_eng)
      annotation (Line(points={{-36,27},{-18.72,27},{-18.72,26.72}}, color={0,0,
            0}));
    connect(gasolineEngineChp.port_exh, exhaustHeatExchanger.port_a1)
      annotation (Line(points={{18.36,26.36},{28,26.36},{28,26.4},{40,26.4}},
          color={0,127,255}));
    connect(gasolineEngineChp.port_amb, heatFlowSensor.port_a)
      annotation (Line(points={{0,9.8},{0,0},{-64,0}}, color={191,0,0}));
    connect(gasolineEngineChp.port_cooCir, submodel_Cooling.heatPort_outside)
      annotation (Line(points={{18,10.16},{18,-6},{-10,-6},{-10,-76},{28,-76},{
            28,-65.56}}, color={191,0,0}));
    connect(exhaustHeatExchanger.port_amb, heatFlowSensor.port_a) annotation (
        Line(points={{40,18},{30,18},{30,0},{-64,0}}, color={191,0,0}));
    connect(inductionMachine.cHPGenBus, sigBusCHP) annotation (Line(
        points={{-62.4,27},{-70,27},{-70,93},{-1,93}},
        color={255,204,51},
        thickness=0.5), Text(
        string="",
        index=1,
        extent={{6,3},{6,3}}));
    connect(exhaustHeatExchanger.cHPExhHexBus, sigBusCHP) annotation (Line(
        points={{54,31.86},{54,93},{-1,93}},
        color={255,204,51},
        thickness=0.5), Text(
        string="",
        index=1,
        extent={{6,3},{6,3}}));
    connect(gasolineEngineChp.cHPEngBus, sigBusCHP) annotation (Line(
        points={{0,41.84},{-1,41.84},{-1,93}},
        color={255,204,51},
        thickness=0.5), Text(
        string="",
        index=1,
        extent={{6,3},{6,3}}));
    connect(port_supCoo,submodel_Cooling.port_b)
      annotation (Line(points={{80,-58},{42,-58}}, color={0,127,255}));
    connect(exhaustHeatExchanger.port_b2,submodel_Cooling.port_a)
                                                               annotation (Line(
          points={{40,9.6},{34,9.6},{34,-12},{0,-12},{0,-58},{14,-58}},
          color={0,127,255}));
    connect(submodel_Cooling.sigBus_coo, sigBusCHP) annotation (Line(
        points={{28.14,-50.44},{28.14,93},{-1,93}},
        color={255,204,51},
        thickness=0.5));
    connect(port_retCoo, exhaustHeatExchanger.port_a2) annotation (Line(points={{
            -80,-58},{-40,-58},{-40,-90},{100,-90},{100,9.6},{68,9.6}}, color={0,
            127,255}));
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
            textString="Modular
CHP"),    Rectangle(
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
<p>This model shows the implementation of a holistic overall model for a CHP power unit using the example of the Kirsch L4.12. The model is able to map different gas engine CHPs of small and medium power classes (&lt; 200 kWel). It allows an investigation of the thermal and electrical dynamics of the individual components and the entire plant. In addition, a CO2 balance can be calculated for the comparison of different control strategies. </p>
<p>The modular CHP model is aggregated from closed submodels that can be run on their own. These are based on physical calculation approaches and offer mechanical, material and thermal interfaces. The thermal interconnection of the exhaust gas heat exchanger and combustion engine in the internal primary circuit is freely selectable. Detailed explanations of how the submodels work are provided in their documentation. Parameterization and control are realized on the highest model level using bus ports to transmit measured and calculated signals throughout the different hierarchical model levels.</p>
<h4><span style=\"color: #000000\">Calibration:</span></h4>
<p>If the calibration of the model is not to be performed for all listed calibration quantities, a quick adaptation of the essential model quantities for the use of are carried out. Setting the speed of the generator and internal combustion engine for the nominal power point using the calibration variables tilting slip, electrical calibration factor and modulation factor results in a high correspondence for electrical power and fuel input for each power stage of the CHP. The thermal output can then be checked by checking the flue gas temperature when the system exits. The examination of the data sheets of some cogeneration units provides general comparative values for the flue gas temperature in a range around 50 &deg;C with and around 110 &deg;C without condensing utilisation at rated output. The flue gas temperature can mainly be adjusted using the heat transitions G_CoolChannel and G_CooExhHex. Finally, the parameters of the heat exchanger can be adapted to the heating circuit.</p>
<h4><span style=\"color: #000000\">Limitations:</span></h4>
<p>Supercharged internal combustion engines and diesel engines cannot be completely mapped.</p>
</html>"));
  end ModularCHP_PowerUnit;

  model Submodel_Cooling
    import AixLib;
    Modelica.Fluid.Sensors.TemperatureTwoPort senTCooEngIn(
      redeclare package Medium = Medium_Coolant,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flow,
      m_flow_small=mCool_flow_small) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-60,0})));
    FixedResistances.Pipe engineHeatTransfer(
      redeclare package Medium = Medium_Coolant,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=CHPEngineModel.dp_Coo, m_flow_nominal=m_flow),
      Heat_Loss_To_Ambient=true,
      alpha=engineHeatTransfer.alpha_i,
      eps=0,
      isEmbedded=true,
      use_HeatTransferConvective=false,
      p_a_start=system.p_start,
      p_b_start=system.p_start,
      alpha_i=GEngToCoo/(engineHeatTransfer.perimeter*engineHeatTransfer.length),
      diameter=CHPEngineModel.dCoo,
      allowFlowReversal=allowFlowReversalCoolant)
      annotation (Placement(transformation(extent={{8,12},{32,-12}})));

    Modelica.Fluid.Sensors.TemperatureTwoPort senTCooEngOut(
      redeclare package Medium = Medium_Coolant,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flow,
      m_flow_small=mCool_flow_small)
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    replaceable package Medium_Coolant =
        DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                   property_T=356, X_a=0.50) constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    parameter
      DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    outer Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=
        CHPEngineModel.m_floCooNominal
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.ThermalConductance GEngToCoo=45
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group=
            "Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.0001
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_outside
      annotation (Placement(transformation(rotation=0, extent={{-10,-70},{10,-50}}),
          iconTransformation(extent={{-12,-66},{12,-42}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium_Coolant) annotation (Placement(transformation(rotation=0, extent=
             {{-110,-10},{-90,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium_Coolant) annotation (Placement(transformation(rotation=0, extent=
             {{90,-10},{110,10}})));
    AixLib.Controls.Interfaces.CHPControlBus sigBus_coo(meaTemInEng=
          senTCooEngIn.T, meaTemOutEng=senTCooEngOut.T) annotation (Placement(
          transformation(extent={{-28,26},{28,80}}), iconTransformation(extent=
              {{-28,26},{30,82}})));
    Movers.FlowControlled_m_flow                coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      addPowerToMedium=false,
      m_flow_nominal=m_flow)
      annotation (Placement(transformation(extent={{-30,12},{-10,-12}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      T(displayUnit="K") = T_HeaRet,
      p=300000)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-80,-40})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if sigBus_coo.isOnPump
           then m_flow else mCool_flow_small)
      annotation (Placement(transformation(extent={{12,-50},{-8,-30}})));
  equation
    connect(engineHeatTransfer.port_b, senTCooEngOut.port_a)
      annotation (Line(points={{32.48,0},{50,0}},     color={0,127,255}));
    connect(heatPort_outside, engineHeatTransfer.heatPort_outside) annotation (
        Line(points={{0,-60},{21.92,-60},{21.92,-6.72}},          color={191,0,0}));
    connect(port_a, senTCooEngIn.port_a)
      annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
    connect(port_b, senTCooEngOut.port_b)
      annotation (Line(points={{100,0},{70,0}}, color={0,127,255}));
    connect(senTCooEngIn.port_b, coolantPump.port_a)
      annotation (Line(points={{-50,0},{-30,0}}, color={0,127,255}));
    connect(engineHeatTransfer.port_a, coolantPump.port_b)
      annotation (Line(points={{7.52,0},{-10,0}}, color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in) annotation (Line(points={{-9,
            -40},{-20,-40},{-20,-14.4}}, color={0,0,127}));
    connect(fixedPressureLevel.ports[1], senTCooEngIn.port_a)
      annotation (Line(points={{-80,-30},{-80,0},{-70,0}}, color={0,127,255}));
    annotation (Icon(graphics={
          Rectangle(
            extent={{-100,40},{100,-40}},
            lineColor={0,0,0},
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-76,14},{-56,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,0,0}),
          Ellipse(
            extent={{56,14},{76,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,0,0}),    Text(
            extent={{-151,113},{149,73}},
            lineColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255},
            textString="%name")}), Documentation(info="<html>
<p>Model of important cooling circuit components that needs to be used with the engine model to realise its heat transfer.</p>
<p>Therefore a heat port is implemented as well as temperature sensors to capture the in- and outlet temperatures of the coolant medium for engine calculations.</p>
<p>Depending on the unit configuration this model can be placed inside the cooling circuit before or after the fluid ports of the exhaust heat exchanger.</p>
<h4>Assumptions:</h4>
<p>The pressure level within the cooling circuit is assumed to be constant at about 3 bar.</p>
</html>"));
  end Submodel_Cooling;

  model GasolineEngineChp
    "Thermal and mechanical model of an internal combustion engine with consideration of the individual mass flows"
    import AixLib;
    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineModel
      cHPCombustionEngine(
      redeclare package Medium1 = Medium_Fuel,
      redeclare package Medium2 = Medium_Air,
      redeclare package Medium3 = Medium_Exhaust,
      T_Amb=T_amb,
      CHPEngData=CHPEngineModel,
      inertia(phi(fixed=false), w(fixed=false, displayUnit="rad/s")),
      T_logEngCool=T_logEngCoo,
      T_ExhCHPOut=T_ExhCHPOut,
      modFac=modFac,
      SwitchOnOff=cHPEngBus.isOn)
      annotation (Placement(transformation(extent={{-30,0},{30,56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing
      engineToCoolant(
      z=CHPEngineModel.z,
      eps=CHPEngineModel.eps,
      m_Exh=cHPCombustionEngine.m_flow_Exh,
      T_Amb=T_amb,
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
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
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
    parameter Data.ModularCHP.EngineMaterialData EngMat=
        Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    parameter Modelica.SIunits.Temperature T_amb=298.15
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
    Real modFac=cHPEngBus.modFac
      "Modulation factor for energy outuput control of the Chp unit  "
      annotation (Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_logEngCoo=(cHPEngBus.meaTemInEng + cHPEngBus.meaTemOutEng)
        /2 "Logarithmic mean temperature of coolant inside the engine"
      annotation (Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_ExhCHPOut=cHPEngBus.meaTemExhOutHex
      "Exhaust gas outlet temperature of CHP unit"
      annotation (Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_Exh=engineToCoolant.T_Exh "Inlet temperature of exhaust gas"
      annotation (Dialog(group="Thermal"));

    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_eng annotation (
        Placement(transformation(rotation=0, extent={{-114,-6},{-94,14}}),
          iconTransformation(extent={{-114,-6},{-94,14}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_exh(redeclare package Medium =
          Medium_Exhaust) annotation (Placement(transformation(rotation=0,
            extent={{92,-8},{112,12}}), iconTransformation(extent={{92,-8},{112,
              12}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_amb annotation (
        Placement(transformation(rotation=0, extent={{-10,-100},{10,-80}}),
          iconTransformation(extent={{-10,-100},{10,-80}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_cooCir annotation (
       Placement(transformation(rotation=0, extent={{90,-98},{110,-78}}),
          iconTransformation(extent={{90,-98},{110,-78}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPEngBus(
      meaRotEng=cHPCombustionEngine.nEng,
      meaFuePowEng=cHPCombustionEngine.P_Fue,
      meaThePowEng=cHPCombustionEngine.Q_therm,
      meaTorEng=cHPCombustionEngine.Mmot,
      meaMasFloFueEng=cHPCombustionEngine.m_flow_Fue,
      meaMasFloAirEng=cHPCombustionEngine.m_flow_Air,
      meaMasFloCO2Eng=cHPCombustionEngine.m_flow_CO2Exh,
      calMeaCpExh=cHPCombustionEngine.meanCpExh) annotation (Placement(
          transformation(
          extent={{-30,-32},{30,32}},
          rotation=0,
          origin={0,92}), iconTransformation(
          extent={{-26,-26},{26,26}},
          rotation=0,
          origin={0,88})));

  equation
    connect(port_exh, cHPCombustionEngine.port_Exhaust) annotation (Line(points=
           {{102,2},{64,2},{64,28},{29.4,28}}, color={0,127,255}));
    connect(port_amb, engineToCoolant.port_Ambient)
      annotation (Line(points={{0,-90},{0,-52}}, color={191,0,0}));
    connect(port_cooCir, engineToCoolant.port_CoolingCircle) annotation (Line(
          points={{100,-88},{100,-30},{22,-30}}, color={191,0,0}));
    connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
      annotation (Line(points={{0,-3.16},{0,8.4}}, color={0,0,127}));
    connect(cHPCombustionEngine.flange_a, flange_eng) annotation (Line(points={
            {-30,28},{-64,28},{-64,4},{-104,4}}, color={0,0,0}));
    annotation (Icon(graphics={
            Bitmap(extent={{-136,-134},{144,160}}, fileName=
                "modelica://AixLib/Resources/Images/Fluid/BoilerCHP/Icon_ICE.png")}),
        Documentation(info="<html>
<p>Model of a combustion engine combined from the thermal and mechanical engine model. #</p>
<p>Together with the submodels cooling circuit, exhaust gas heat exchanger and electric motor, it can be connected to form the power unit of a combined heat and power unit.</p>
</html>"));
  end GasolineEngineChp;

  model CHP_ElectricMachine
    "Model of a general induction machine working as a starter generator"
    import AixLib;
    extends Modelica.Electrical.Machines.Icons.TransientMachine;

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "Needed engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter Modelica.SIunits.Frequency n0=CHPEngData.n0
      "Idling speed of the electric machine"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Frequency n_nominal=CHPEngData.n_nominal
                                                           "Rated rotor speed"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Frequency f_1=CHPEngData.f_1
                                                "Frequency"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Voltage U_1=CHPEngData.U_1
                                               "Rated voltage"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Current I_elNominal=CHPEngData.I_elNominal
                                                        "Rated current"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Current I_1_start=if P_Mec_nominal<=15000 then 7.2*I_elNominal else 8*I_elNominal
      "Motor start current (realistic factors used from DIN VDE 2650/2651)"
      annotation (Dialog(                           tab="Calculations"));
    parameter Modelica.SIunits.Power P_elNominal=CHPEngData.P_elNominal
      "Nominal electrical power of electric machine"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Power P_Mec_nominal=P_elNominal*(1+s_nominal/0.22) "Nominal mechanical power of electric machine"
      annotation (Dialog(tab="Calculations"));
    parameter Modelica.SIunits.Torque M_nominal=P_Mec_nominal/(2*Modelica.Constants.pi*n_nominal) "Nominal torque of electric machine"
      annotation (Dialog(tab="Calculations"));
    parameter Modelica.SIunits.Torque M_til=2*M_nominal "Tilting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
      annotation (Dialog(tab="Calculations"));
    parameter Modelica.SIunits.Torque M_start=if P_Mec_nominal<=4000 then 1.6*M_nominal
    elseif P_Mec_nominal>=22000 then 1*M_nominal else 1.25*M_nominal
     "Starting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
      annotation (Dialog(tab="Calculations"));
    parameter Modelica.SIunits.Inertia J_Gen=1
      "Moment of inertia of the electric machine (default=0.5kg.m2)"
      annotation (Dialog(group="Calibration"));
    parameter Boolean useHeat=CHPEngData.useHeat
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(group="Machine specifications"));
    parameter Real s_nominal=abs(1-n_nominal*p/f_1) "Nominal slip of electric machine"
      annotation (Dialog(tab="Calculations"));
    parameter Real s_til=abs((s_nominal*(M_til/M_nominal)+s_nominal*sqrt(abs(((M_til/M_nominal)^2)-1+2*s_nominal*((M_til/M_nominal)-1))))/(1-2*s_nominal*((M_til/M_nominal)-1)))
     "Tilting slip of electric machine"
      annotation (Dialog(tab="Calculations"));
    parameter Real p=CHPEngData.p
                       "Number of pole pairs"
      annotation (Dialog(group="Machine specifications"));
    parameter Real cosPhi=CHPEngData.cosPhi
                              "Power factor of electric machine (default=0.8)"
      annotation (Dialog(group="Machine specifications"));
    parameter Real calFac=1
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(group="Calibration"));
    parameter Real gearRatio=CHPEngData.gearRatio
                               "Transmission ratio (engine speed / generator speed)"
      annotation (Dialog(group="Machine specifications"));
  protected
    parameter Real rho0=s_til^2 "Calculation variable for analytical approach (Aree, 2017)"
      annotation (Dialog(tab="Calculations"));
    parameter Real rho1=(M_start*(1+s_til^2)-2*s_til*M_til)/(M_til-M_start) "Calculation variable for analytical approach (Aree, 2017)"
      annotation (Dialog(tab="Calculations"));
    parameter Real rho3=(M_til*M_start*(1-s_til)^2)/(M_til-M_start) "Calculation variable for analytical approach (Aree, 2017)"
      annotation (Dialog(tab="Calculations"));
    parameter Real k=((I_elNominal/I_1_start)^2)*(((s_nominal^2)+rho1*s_nominal+rho0)/(1+rho1+rho0)) "Calculation variable for analytical approach (Aree, 2017)"
      annotation (Dialog(tab="Calculations"));
  public
    Modelica.SIunits.Frequency n=inertia.w/(2*Modelica.Constants.pi) "Speed of machine rotor [1/s]";
    Modelica.SIunits.Current I_1 "Electric current of machine stator";
    Modelica.SIunits.Power P_E "Electrical power at the electric machine";
    Modelica.SIunits.Power P_Mec "Mechanical power at the electric machine";
    Modelica.SIunits.Power CalQ_Loss
      "Calculated heat flow from electric machine";
    Modelica.SIunits.Power Q_Therm=if useHeat then CalQ_Loss else 0
      "Heat flow from electric machine"
      annotation (Dialog(group="Machine specifications"));
    Modelica.SIunits.Torque M "Torque at electric machine";
    Real s=1-n*p/f_1 "Current slip of electric machine";
    Real eta "Total efficiency of the electric machine (as motor)";
    Real calI_1 = 1/(1+((k-1)/((s_nominal^2)-k))*((s^2)+rho1*abs(s)+rho0));
    Boolean OpMode = (n<=n0) "Operation mode (true=motor, false=generator)";
    Boolean SwitchOnOff=cHPGenBus.isOn
      "Operation of electric machine (true=On, false=Off)";
    Modelica.Mechanics.Rotational.Components.Inertia inertia(       w(fixed=false), J=J_Gen)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Blocks.Sources.RealExpression electricTorque(y=M)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_genIn
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    Modelica.Mechanics.Rotational.Components.IdealGear gearEngineToGenerator(
        ratio=gearRatio)
      annotation (Placement(transformation(extent={{80,-10},{60,10}})));

    AixLib.Controls.Interfaces.CHPControlBus cHPGenBus(
      meaElPowGen=P_E,
      meaCurGen=I_1,
      meaTorGen=M,
      calEtaGen=eta) annotation (Placement(transformation(extent={{-132,28},{-72,
              84}}), iconTransformation(
          extent={{-30,-28},{30,28}},
          rotation=90,
          origin={-76,0})));
  equation

  if noEvent(SwitchOnOff) then

    I_1=sign(s)*I_1_start*sqrt(abs((1+((k-1)/((s_nominal^2)-k))*(s^2)*(1+rho1+rho0))*calI_1));
    P_E=if noEvent(s>0) then sqrt(3)*I_1*U_1*cosPhi elseif noEvent(s<0) then calFac*(P_Mec+CalQ_Loss) else 1;
   // P_Mec=if noEvent(s>0) then 2*Modelica.Constants.pi*M*n else 2*Modelica.Constants.pi*n*M;
    P_Mec=2*Modelica.Constants.pi*M*n;
    CalQ_Loss= (calFac-1)*P_E + 2*Modelica.Constants.pi*M*(s*n0)/0.22;
    M=sign(s)*(rho3*abs(s))/((s^2)+rho1*abs(s)+rho0);
    eta=if noEvent(s>0) then abs(P_Mec/(P_E+1))
    elseif noEvent(s<0) then abs(P_E/(P_Mec-1)) else 0;

  else

    I_1=0;
    P_E=0;
    P_Mec=0;
    CalQ_Loss=0;
    M=if noEvent(s<0) then sign(s)*(rho3*abs(s))/((s^2)+rho1*abs(s)+rho0) else 0;
    eta=0;

    end if;

    connect(electricTorque.y, torque.tau)
      annotation (Line(points={{-39,0},{-22,0}}, color={0,0,127}));
    connect(torque.flange, inertia.flange_a)
      annotation (Line(points={{0,0},{20,0}}, color={0,0,0}));
    connect(inertia.flange_b, gearEngineToGenerator.flange_b)
      annotation (Line(points={{40,0},{60,0}}, color={0,0,0}));
    connect(gearEngineToGenerator.flange_a, flange_genIn)
      annotation (Line(points={{80,0},{100,0}}, color={0,0,0}));
    annotation (Documentation(info="<html>
<p>Model of an electric induction machine that includes the calculation of:</p>
<p>-&gt; mechanical output (torque and speed)</p>
<p>-&gt; electrical output (current and power)</p>
<p>It delivers positive torque and negative electrical power when operating below the synchronous speed (motor) and can switch into generating electricity (positive electrical power and negative torque) when operating above the synchronous speed (generator).</p>
<p>The calculations are based on simple electrical equations and an analytical approach by Pichai Aree (2017) that determinates stator current and torque depending on the slip.</p>
<p>The parameters rho0, rho1, rho3 and k are used for the calculation of the characteristic curves. They are determined from the general machine data at nominal operation and realistic assumptions about the ratio between starting torque, starting current, breakdown torque, breakdown slip and nominal current and torque. These assumptions are taken from DIN VDE 2650/2651. It shows good agreement for machines up to 100kW of mechanical power operating at a speed up to 3000rpm and with a rated voltage up to 500V.</p>
<p>The only data required is:</p>
<p>- number of polepairs or synchronous speed (<b>p</b> or <b>n0</b>)</p>
<p>- voltage and frequence of the electric power supply (<b>U_1</b> and <b>f_1</b>)</p>
<p>- nominal current and speed (<b>I_elNominal</b> and <b>n_nominal</b> )</p>
<p>- power factor if available (default=0.8)</p>
<p><br>Additional Information:</p>
<p><br>- Electric power calculation as a generator from mechanical input speed can be further approached by small changes to the speed.</p>
<p>- The electric losses are calculated from the slip depending rotor loss which corresponds to roughly 22&percnt; of the total losses according to Almeida (DOI: 10.1109/MIAS.2010.939427).</p>
</html>"),   Icon(graphics={
          Text(
            extent={{-86,98},{84,82}},
            lineColor={28,108,200},
            textStyle={TextStyle.Bold},
            textString="%name")}));
  end CHP_ElectricMachine;

  model ExhaustHeatExchanger
    "Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle"
    import AixLib;

    extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
      m1_flow_nominal=0.023,
      m2_flow_nominal=0.5556,
      m1_flow_small=0.0001,
      m2_flow_small=0.0001,
      show_T=true,
      redeclare package Medium1 = Medium3,
      redeclare package Medium2 = Medium4);

    AixLib.Fluid.Sensors.TemperatureTwoPort senTExhHot(
      redeclare final package Medium = Medium1,
      final tau=tau,
      final m_flow_nominal=m1_flow_nominal,
      final initType=initType,
      final T_start=T1_start,
      final transferHeat=transferHeat,
      final TAmb=T_Amb,
      final tauHeaTra=tauHeaTra,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_small=m1_flow_small)
      "Temperature sensor of hot side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senTExhCold(
      redeclare final package Medium = Medium1,
      final tau=tau,
      final m_flow_nominal=m1_flow_nominal,
      final initType=initType,
      final T_start=T1_start,
      final transferHeat=transferHeat,
      final TAmb=T_Amb,
      final tauHeaTra=tauHeaTra,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_small=m1_flow_small)
      "Temperature sensor of cold side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{28,50},{48,70}})));
    AixLib.Fluid.Sensors.MassFlowRate senMasFloExh(redeclare final package
        Medium =
          Medium1, final allowFlowReversal=allowFlowReversal1)
      "Sensor for mass flwo rate"
      annotation (Placement(transformation(extent={{60,70},{80,50}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senTCooCold(
      redeclare final package Medium = Medium2,
      final tau=tau,
      final m_flow_nominal=m2_flow_nominal,
      final initType=initType,
      final T_start=T2_start,
      final transferHeat=transferHeat,
      final TAmb=T_Amb,
      final tauHeaTra=tauHeaTra,
      final allowFlowReversal=allowFlowReversal2,
      final m_flow_small=m2_flow_small)
      "Temperature sensor of coolant cold side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senTCooHot(
      redeclare final package Medium = Medium2,
      final tau=tau,
      final m_flow_nominal=m2_flow_nominal,
      final initType=initType,
      final T_start=T2_start,
      final transferHeat=transferHeat,
      final TAmb=T_Amb,
      final tauHeaTra=tauHeaTra,
      final allowFlowReversal=allowFlowReversal2,
      final m_flow_small=m2_flow_small)
      "Temperature sensor of coolant hot side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    AixLib.Fluid.Sensors.MassFlowRate senMasFloCool(redeclare final package
        Medium = Medium2, final allowFlowReversal=allowFlowReversal2)
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
    parameter Modelica.SIunits.Temperature T1_start=T_Amb
      "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.SIunits.Temperature T2_start=T_Amb
      "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure p1_start=p_Amb
      "Start value of pressure"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure p2_start=p_Amb
      "Start value of pressure"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Boolean transferHeat=false
      "If true, temperature T converges towards TAmb when no flow"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Boolean ConTec=false
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Condensing technology"));
    parameter Modelica.SIunits.Temperature T_Amb=298.15
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
    parameter Modelica.SIunits.ThermalConductance GAmb=5
      "Constant thermal conductance of material"
      annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.SIunits.ThermalConductance GCoo=850
      "Constant thermal conductance of material"
      annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.SIunits.HeatCapacity CExhHex=4000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)"
    annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_Amb=101325
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
          CExhHex, T(start=T_Amb, fixed=true))
      annotation (Placement(transformation(extent={{10,-12},{30,8}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor ambientLoss(G=
          GAmb)
      annotation (Placement(transformation(extent={{-46,-22},{-66,-2}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_amb annotation (
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
    AixLib.Fluid.FixedResistances.Pipe pipeCoolant(
      redeclare package Medium = Medium2,
      p_b_start=system.p_start - 15000,
      isEmbedded=true,
      Heat_Loss_To_Ambient=true,
      withInsulation=false,
      use_HeatTransferConvective=false,
      eps=0,
      alpha=pipeCoolant.alpha_i,
      alpha_i=GCoo/(pipeCoolant.perimeter*pipeCoolant.length),
      diameter=0.03175,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            m_flow_nominal=m2_flow_nominal, dp_nominal=10))
      annotation (Placement(transformation(extent={{32,-70},{12,-50}})));

    Modelica.Fluid.Vessels.ClosedVolume volExhaust(
      redeclare final package Medium = Medium1,
      final m_flow_nominal=m1_flow_nominal,
      final p_start=p1_start,
      final T_start=T1_start,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
      use_portsData=false,
      final m_flow_small=m1_flow_small,
      nPorts=3,
      V=VExhHex)                         "Fluid volume"
      annotation (Placement(transformation(extent={{-20,60},{-40,40}})));
    AixLib.Fluid.FixedResistances.HydraulicDiameter
                                  pressureDropExhaust(
      redeclare final package Medium = Medium1,
      final show_T=false,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_nominal=m1_flow_nominal,
      dh=d_iExh,
      rho_default=1.18,
      mu_default=1.82*10^(-5),
      length=l_ExhHex)               "Pressure drop"
      annotation (Placement(transformation(extent={{0,50},{20,70}})));
    AixLib.Utilities.HeatTransfer.HeatConvPipeInsideDynamic
      heatConvExhaustPipeInside(
      d_i=d_iExh,
      A_sur=A_surExhHea,
      rho=rho1_in,
      lambda=lambda1_in,
      eta=eta1_in,
      c=cHPExhHexBus.calMeaCpExh,
      m_flow=cHPExhHexBus.meaMasFloFueEng + cHPExhHexBus.meaMasFloAirEng)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,20})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow additionalHeat
      "Heat flow from water condensation in the exhaust gas and generator losses"
      annotation (Placement(transformation(extent={{60,-22},{40,-2}})));
    Modelica.Blocks.Sources.RealExpression latentExhaustHeat(y=if cHPExhHexBus.isOn
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
    Modelica.SIunits.Velocity v1_in = senMasFloExh.m_flow/(Modelica.Constants.pi*rho1_in*d_iExh^2/4);
    Modelica.SIunits.ThermalConductivity lambda1_in = Medium1.thermalConductivity(state1);
    Modelica.SIunits.ReynoldsNumber Re1_in = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v1_in,rho1_in,eta1_in,d_iExh);

    Modelica.Blocks.Sources.RealExpression generatorHeat(y=if cHPExhHexBus.isOn
           then Q_Gen else 0) "Calculated heat from generator losses"
      annotation (Placement(transformation(extent={{126,-32},{106,-12}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=2)
      annotation (Placement(transformation(extent={{86,-18},{74,-6}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPExhHexBus(
      meaTemExhOutHex=senTExhCold.T,
      meaTemExhInHex=senTExhHot.T,
      meaThePowOutHex=pipeCoolant.heatPort_outside.Q_flow,
      meaMasFloConHex=m_ConH2OExh,
      meaTemInHex=senTCooCold.T,
      meaTemOutHex=senTCooHot.T) annotation (Placement(transformation(extent={{
              -28,72},{28,126}}), iconTransformation(extent={{-28,72},{28,126}})));
  equation
  //Calculation of water condensation and its usable latent heat
    if ConTec then
    x_H2OExhDry=senTExhHot.port_a.Xi_outflow[3]/(1 - senTExhHot.port_a.Xi_outflow[3]);
    xSat_H2OExhDry=if noEvent(M_H2O*pSatH2OExh/((pExh-pSatH2OExh)*M_Exh)>=0) then M_H2O*pSatH2OExh/((pExh-pSatH2OExh)*M_Exh) else x_H2OExhDry;
    m_H2OExh=senMasFloExh.m_flow*senTExhHot.port_a.Xi_outflow[3];
    m_ExhDry=senMasFloExh.m_flow-m_H2OExh;
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

    connect(senTExhCold.port_b, senMasFloExh.port_a)
      annotation (Line(points={{48,60},{60,60}}, color={0,127,255}));
    connect(port_a1, senTExhHot.port_a)
      annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
    connect(senMasFloExh.port_b, port_b1)
      annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
    connect(port_a2, senTCooCold.port_b)
      annotation (Line(points={{100,-60},{80,-60}}, color={0,127,255}));
    connect(senTCooHot.port_a, senMasFloCool.port_a)
      annotation (Line(points={{-40,-60},{-60,-60}}, color={0,127,255}));
    connect(senMasFloCool.port_b, port_b2)
      annotation (Line(points={{-80,-60},{-100,-60}}, color={0,127,255}));
    connect(port_amb, ambientLoss.port_b) annotation (Line(points={{-100,0},{-90,
            0},{-90,-12},{-66,-12}}, color={191,0,0}));
    connect(senTCooCold.port_a, pipeCoolant.port_a)
      annotation (Line(points={{60,-60},{32.4,-60}}, color={0,127,255}));
    connect(senTCooHot.port_b, pipeCoolant.port_b)
      annotation (Line(points={{-20,-60},{11.6,-60}}, color={0,127,255}));
    connect(ambientLoss.port_a, heatCapacitor.port)
      annotation (Line(points={{-46,-12},{20,-12}},color={191,0,0}));
    connect(heatCapacitor.port, pipeCoolant.heatPort_outside) annotation (Line(
          points={{20,-12},{20.4,-12},{20.4,-54.4}},color={191,0,0}));
    connect(volExhaust.heatPort, heatConvExhaustPipeInside.port_a)
      annotation (Line(points={{-20,50},{-20,30}}, color={191,0,0}));
    connect(heatConvExhaustPipeInside.port_b, heatCapacitor.port)
      annotation (Line(points={{-20,10},{-20,-12},{20,-12}},color={191,0,0}));
    connect(pressureDropExhaust.port_a, volExhaust.ports[1]) annotation (Line(
          points={{0,60},{-14,60},{-14,64},{-27.3333,64},{-27.3333,60}},
                                                               color={0,127,255}));
    connect(senTExhHot.port_b, volExhaust.ports[2]) annotation (Line(points={{-60,60},
            {-46,60},{-46,64},{-30,64},{-30,60}},     color={0,127,255}));
    connect(pressureDropExhaust.port_b, senTExhCold.port_a)
      annotation (Line(points={{20,60},{28,60}}, color={0,127,255}));
    connect(additionalHeat.port, heatCapacitor.port)
      annotation (Line(points={{40,-12},{20,-12}}, color={191,0,0}));
    connect(additionalHeat.Q_flow, multiSum.y)
      annotation (Line(points={{60,-12},{72.98,-12}}, color={0,0,127}));
    connect(latentExhaustHeat.y, multiSum.u[1]) annotation (Line(points={{105,-2},
            {96,-2},{96,-9.9},{86,-9.9}}, color={0,0,127}));
    connect(generatorHeat.y, multiSum.u[2]) annotation (Line(points={{105,-22},{
            96,-22},{96,-14.1},{86,-14.1}}, color={0,0,127}));
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
<p>The convective heat transfer between exhaust gas and heat exchanger is calculated as a cylindrical exhaust pipe. For the pipe cross-section, the connection cross-section of the power unit is used; the heat transfer area and the capacity of the heat exchanger can be calibrated.</p>
<p>Known variables are the combustion air ratio and the heat flow to the cooling water circuit at nominal operation. These are used to estimate the pipe diameters if unknown.</p>
<p>The heat transfer to the environment (G_Amb) and the cooling water circuit (G_Cool) is calculated by means of heat conduction.</p>
<p>There is the option of considering the heat output from the condensation of water in the flue gas. This is determined from the determination of the precipitating water via the saturation vapour pressure and the critical loading in the flue gas for the critical state (at outlet temperature). The evaporation enthalpy is approximated using an empirical formula based on table data for ambient pressure.</p>
<p>Simplifying it is assumed that the latent heat flux in addition to the convective heat flux is transferred to the capacity of the exhaust gas heat exchanger.</p>
</html>"));
  end ExhaustHeatExchanger;

  model OnOff_ControllerEasy
    import AixLib;

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    parameter Modelica.SIunits.Time startTimeChp=0
      "Start time for discontinous simulation tests to heat the Chp unit up to the prescribed return temperature";
    parameter Real modTab[:,2]=[0.0,0.8; 7200,0.8; 7200,0.93; 10800,0.93; 10800,
        0.62; 14400,0.62; 14400,0.8; 18000,0.8; 18000,0.0]
      "Table for unit modulation (time = first column; modulation factors = second column)";
    Modelica.Blocks.Logical.Timer timerIsOff
      annotation (Placement(transformation(extent={{-6,16},{8,30}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-32,16},{-18,30}})));
    Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=7200)
      annotation (Placement(transformation(extent={{20,16},{34,30}})));
    Modelica.Blocks.Logical.Or pumpControl
      annotation (Placement(transformation(extent={{48,8},{64,24}})));
    AixLib.Controls.Interfaces.CHPControlBus modCHPConBus annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={100,0})));
    Modelica.Blocks.Sources.TimeTable modulationFactorControl(
                            startTime=startTimeChp, table=modTab)
      annotation (Placement(transformation(extent={{-10,-54},{10,-34}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
      annotation (Placement(transformation(extent={{-68,6},{-48,26}})));

  equation
    connect(timerIsOff.u,not1. y)
      annotation (Line(points={{-7.4,23},{-17.3,23}},  color={255,0,255}));
    connect(timerIsOff.y,declarationTime. u)
      annotation (Line(points={{8.7,23},{18.6,23}}, color={0,0,127}));
    connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{34.7,23},
            {38,23},{38,16},{46.4,16}},
                                      color={255,0,255}));
    connect(pumpControl.y, modCHPConBus.isOnPump) annotation (Line(points={{
            64.8,16},{82,16},{82,-0.1},{100.1,-0.1}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(modulationFactorControl.y, modCHPConBus.modFac) annotation (Line(
          points={{11,-44},{100.1,-44},{100.1,-0.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(greaterThreshold.y, not1.u) annotation (Line(points={{-47,16},{-40,
            16},{-40,23},{-33.4,23}},
                                color={255,0,255}));
    connect(pumpControl.u2, not1.u) annotation (Line(points={{46.4,9.6},{-40,
            9.6},{-40,23},{-33.4,23}},color={255,0,255}));
    connect(greaterThreshold.y, modCHPConBus.isOn) annotation (Line(points={{
            -47,16},{-40,16},{-40,0},{92,0},{92,-0.1},{100.1,-0.1}}, color={255,
            0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(greaterThreshold.u, modulationFactorControl.y) annotation (Line(
          points={{-70,16},{-82,16},{-82,-16},{38,-16},{38,-44},{11,-44}},
                                                                         color={0,
            0,127}));
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
CHP")}), Documentation(info="<html>
<p>Model of an easy on-off-controller for the modular CHP model.</p>
<p>It allows to manually modulate the load of the power unit. A modulation factor (modFac) of 0 indicates that the machine is not in operation.</p>
</html>"));
  end OnOff_ControllerEasy;

  package BaseClassComponents
    "Package with base classe components for AixLib.Fluid.BoilerCHP.ModularCHP"
    extends Modelica.Icons.BasesPackage
  annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.BoilerCHP.ModularCHP\">AixLib.Fluid.BoilerCHP.ModularCHP</a>.
</p>
</html>"));
    model GasolineEngineChp_EngineModel
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

      Boolean SwitchOnOff=true
                          "Operation switch of the CHP unit (true=On, false=Off)"
        annotation (Dialog(group="Modulation"));
      RotationSpeed nEng(min=0) "Current engine speed";
      Modelica.SIunits.MassFlowRate m_flow_Exh "Mass flow rate of exhaust gas";
      Modelica.SIunits.MassFlowRate m_flow_CO2Exh
        "Mass flow rate of CO2 in the exhaust gas";
      Modelica.SIunits.MassFlowRate m_flow_Fue(min=0) "Mass flow rate of fuel";
      Modelica.SIunits.MassFlowRate m_flow_Air(min=0)
        "Mass flow rate of combustion air";
      Modelica.SIunits.SpecificHeatCapacity meanCpComExh[size(n_ComExh, 1)] "Calculated specific heat capacities of the exhaust gas components for the calculated combustion temperature";
      Modelica.SIunits.SpecificHeatCapacity meanCpExh "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature";
      Modelica.SIunits.SpecificEnergy h_Exh = 1000*(-286 + 1.011*T_ExhCHPOut - 27.29*Lambda + 0.000136*T_ExhCHPOut^2 - 0.0255*T_ExhCHPOut*Lambda + 6.425*Lambda^2) "Specific enthalpy of the exhaust gas";
      Modelica.SIunits.Power P_eff "Effective(mechanical) engine power";
      Modelica.SIunits.Power P_Fue(min=0) = m_flow_Fue*H_U
        "Fuel expenses at operating point";
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

      Modelica.Fluid.Interfaces.FluidPort_b port_Exhaust(redeclare package
          Medium =
            Medium3)
        annotation (Placement(transformation(extent={{108,-10},{88,10}})));
      Modelica.Fluid.Sources.MassFlowSource_T exhaustFlow(
        use_m_flow_in=true,
        use_T_in=true,
        redeclare package Medium = Medium3,
        X=Xi_Exh,
        use_X_in=false,
        nPorts=1)
        annotation (Placement(transformation(extent={{66,-10},{86,10}})));
      Modelica.Blocks.Sources.RealExpression massFlowExhaust(y=m_flow_Exh)
        annotation (Placement(transformation(extent={{28,-4},{50,20}})));
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
            origin={0,-104}), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={0,-70})));
    equation

    for i in 1:size(n_ComExh, 1) loop
      meanCpComExh[i] = cpRefComExh[i]/(expFacCpComExh[i] + 1)/(T_Com/273.15 - 1)*(-1 + (T_Com/273.15)^(expFacCpComExh[i] + 1));
      end for;
      meanCpExh = sum(meanCpComExh[i]*Xi_Exh[i] for i in 1:size(n_ComExh, 1));
      m_flow_Fue = modFac*m_FueEngRot*nEng*CHPEngData.i/60;
      m_flow_Air = m_flow_Fue*Lambda*L_St;
     // m_Exh = m_Fue + m_Air;
      m_flow_CO2Exh = m_flow_Fue*(1 + Lambda*L_St)*X_CO2Exh;
      H_Exh =h_Exh*m_flow_Fue*(1 + Lambda*L_St);
      if inertia.w>=80 and SwitchOnOff then
      Mmot = CHPEngData.i*p_me*CHPEngData.VEng/(2*Modelica.Constants.pi);
      nEng = inertia.w/(2*Modelica.Constants.pi);
        m_flow_Exh = m_flow_Fue + m_flow_Air;
      elseif inertia.w>=80 and not
                                  (SwitchOnOff) then
      Mmot = -CHPEngData.i*p_mf*CHPEngData.VEng/(2*Modelica.Constants.pi);
      nEng = inertia.w/(2*Modelica.Constants.pi);
        m_flow_Exh = m_flow_Fue + m_flow_Air + 0.0001;
      elseif inertia.w<80 and noEvent(inertia.w>0.1) then
      Mmot = -CHPEngData.i*p_mf*CHPEngData.VEng/(2*Modelica.Constants.pi);
      nEng = inertia.w/(2*Modelica.Constants.pi);
        m_flow_Exh = m_flow_Fue + m_flow_Air + 0.0001;
      else
      Mmot = 0;
      nEng = 0;
        m_flow_Exh = 0.001;
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

      connect(exhaustFlow.m_flow_in, massFlowExhaust.y)
        annotation (Line(points={{66,8},{51.1,8}},   color={0,0,127}));
      connect(exhaustFlow.ports[1], port_Exhaust)
        annotation (Line(points={{86,0},{98,0}},   color={0,127,255}));
      connect(inertia.flange_b, flange_a) annotation (Line(points={{-78,
              1.33227e-015},{-100,1.33227e-015},{-100,0}},
                               color={0,0,0}));
      connect(inertia.flange_a, engineTorque.flange)
        annotation (Line(points={{-58,-1.33227e-015},{-58,1.33227e-015},{-40,
              1.33227e-015}},                    color={0,0,0}));
      connect(exhaustFlow.T_in, exhaustGasTemperature) annotation (Line(points={{64,
              4},{56,4},{56,-40},{0,-40},{0,-104}}, color={0,0,127}));
      connect(engineTorque.tau, effectiveMechanicalTorque.y) annotation (Line(
            points={{-18,-1.55431e-015},{-12,-1.55431e-015},{-12,0},{-7.2,0}},
            color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-120,-134},{122,134}}, fileName=
                  "modelica://AixLib/Resources/Images/Fluid/BoilerCHP/Icon_ICE.png"),
            Text(
              extent={{-100,80},{100,64}},
              lineColor={28,108,200},
              textStyle={TextStyle.Bold},
              textString="%name")}),                                 Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(revisions="<html>
</html>",     info="<html>
<p>The model of the internal combustion engine is the centrepiece of the BHKW model developed. It is divided into a thermal and a mechanical-chemical part.</p>
<p>The energy balance of the combustion engine is used to determine the maximum heat released. The mechanical power is calculated using a mean value model, which is characterized by short calculation times and simple parameterization. An empirical approach is used to describe the specific enthalpy of the exhaust gas. The required mass flows of the combustion products are determined by assuming complete combustion with a known fuel composition. Various liquid and gaseous fuels have been implemented on the basis of the existing material models and are available to the user. </p>
<p>Due to the complexity of a combustion engine, assumptions have to be made. These are listed below to understand the function and applicability of the model.</p>
<p><br><b><span style=\"color: #005500;\">Assumptions</span></b></p>
<p><br>Assumptions made and resulting limitations of the internal combustion engine model:</p>
<p>- The nominal power point of the power unit is known and the modulationof the operation point is achieved by a reduction of the introduced fuel.</p>
<p>- The indicated mean pressure is assumed to be constant as a necessary measure for the calculation of engine power. This corresponds to a constant thermodynamic combustion process within the cylinders.</p>
<p>- The engine must be started with an electric machine. It is controlled by the release of the fuel quantity from a minimum speed (800rpm). The speed then increases to equilibrium with the counteracting generator torque.</p>
<p>- Complete and superstoichiometric combustion is assumed to solve the gross reaction equation</p>
<p>- Entry of air and fuel at ambient conditions and constant amount of fuel and air per combustion cycle</p>
<p>-&gt; Only conditionally with turbocharging of the engines, since then the cylinder filling can vary depending on the boost pressure (slight consideration due to stored rated performance data)</p>
<p><br>Air ratio or residual oxygen in the exhaust gas is known to estimate the combustion process. So this is a necessary assumption for the calculation of material flows (mass flows, composition of the exhaust gas).</p>
<p>The mean specific heat capacity of the exhaust gas for a temperature range from 0 &deg; C to the maximum adiabatic combustion temperature is used to calculate the exhaust gas temperature.</p>
<p>The mean specific heat capacity is determinated with a potency approach according to M&uuml;ller (1968).</p>
<p>Frictional losses that can be calculated based on a known friction mean pressure at a speed of 3000rpm (if not known, default average values ​​from VK1 by S.Pischinger) are converted into usable heat. </p>
<p>The calculation of the exhaust gas enthalpy according to an empirical approach is based on investigations by R.Pischinger which uses a reference point temperature of 25 &deg; C (initial state of the reaction educts from combustion air and fuel).</p>
<p>-&gt; Consideration of the chemical and thermal proportions of the enthalpy</p>
<p>-&gt; Limited accuracy for diesel engine (non-premixed) processes</p>
</html>"));
    end GasolineEngineChp_EngineModel;

    class GasolineEngineChp_EngineHousing
      "Engine housing as a simple two layer wall."
      import AixLib;

      replaceable package Medium3 =
          DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
                                                               constrainedby
        DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                     annotation(choicesAllMatching=true);

      parameter Modelica.SIunits.Thickness dInn=0.005
        "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
        annotation (Dialog(tab="Calibration properties"));

      parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData
        EngMatData=AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
        "Thermal engine material data for calculations (most common is cast iron)"
        annotation (choicesAllMatching=true, Dialog(tab="Structure", group=
              "Material Properties"));

      constant Modelica.SIunits.ThermalConductivity lambda=EngMatData.lambda
        "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      constant Modelica.SIunits.Density rhoEngWall=EngMatData.rhoEngWall
        "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      constant Modelica.SIunits.SpecificHeatCapacity c=EngMatData.c
        "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
      constant Real z
        "Number of engine cylinders"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      constant Modelica.SIunits.Thickness dCyl
        "Engine cylinder diameter"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      constant Modelica.SIunits.Thickness hStr
        "Engine stroke"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      constant Real eps
        "Engine compression ratio"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      parameter Modelica.SIunits.Mass mEng
        "Total engine mass"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      Real nEng
        "Current engine speed"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
        "Thermal conductance from engine housing to the surrounding air"
       annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.Temperature T_Amb=298.15
        "Ambient temperature"
        annotation (Dialog(tab="Thermal"));

    protected
      constant Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 + hStr*(1 + 1/(eps - 1))))
        "Area of heat transporting surface from cylinder wall to outer engine block"
        annotation (Dialog(tab="Structure"));
      parameter Modelica.SIunits.Mass mEngWall=A_WInn*rhoEngWall*dInn
        "Calculated mass of cylinder wall between combustion chamber and cooling circle"
        annotation (Dialog(tab="Structure"));
      parameter Modelica.SIunits.Mass mEngBlo=mEng - mEngWall
        "Calculated mass of the remaining engine body"
        annotation (Dialog(tab="Structure"));
      parameter Modelica.SIunits.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
        "Thickness of outer wall of the remaining engine body"
        annotation (Dialog(tab="Structure"));
      parameter Modelica.SIunits.HeatCapacity CEngWall=dInn*A_WInn*rhoEngWall*c
        "Heat capacity of cylinder wall between combustion chamber and cooling circle"
        annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
        "Heat capacity of the remaining engine body"
        annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
       "Thermal conductance of the inner engine wall"
        annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GEngBlo=lambda*A_WInn/dOut
       "Thermal conductance of the remaining engine body"
       annotation (Dialog(tab="Thermal"));

    public
      Modelica.SIunits.ThermalConductance CalT_Exh
     "Calculation variable for the temperature of the exhaust gas";
      Modelica.SIunits.Temperature T_Com
        "Calculated maximum combustion temperature inside the engine"
       annotation (Dialog(tab="Thermal"));
      Modelica.SIunits.Temperature T_CylWall
        "Temperature of cylinder wall";
     /* Modelica.SIunits.Temperature T_LogMeanCool
 "Mean logarithmic coolant temperature" annotation (Dialog(tab="Thermal")); */
      Modelica.SIunits.Temperature T_Exh
        "Inlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
      Modelica.SIunits.Temperature T_ExhPowUniOut
        "Outlet temperature of exhaust gas"
        annotation (Dialog(tab="Thermal"));
      type RotationSpeed=Real(final unit="1/s", min=0);
      Modelica.SIunits.MassFlowRate m_Exh
        "Mass flow rate of exhaust gas" annotation (Dialog(tab="Thermal"));
      Modelica.SIunits.SpecificHeatCapacity meanCpExh
        "Mean specific heat capacity of the exhaust gas" annotation (Dialog(tab="Thermal"));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient
        annotation (Placement(transformation(extent={{-12,-112},{12,-88}}),
            iconTransformation(extent={{-10,-110},{10,-90}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor innerWall(
        C=CEngWall,
        der_T(fixed=false, start=0),
        T(start=T_Amb,
          fixed=true))       annotation (Placement(transformation(
            origin={-24,-58},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Blocks.Sources.RealExpression realExpr1(y=innerWall.T)
        annotation (Placement(transformation(extent={{-116,-48},{-96,-28}})));
      Modelica.Blocks.Sources.RealExpression realExpr2(y=T_CylWall) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-106,-58})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalCond2_1(G=GInnWall/2)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                                                                       rotation=0,
            origin={-10,0})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow actualHeatFlowEngine
        annotation (Placement(transformation(extent={{-56,-58},{-36,-38}})));
      AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing_CylToInnerWall
        cylToInnerWall(
        GInnWall=GInnWall,
        dInn=dInn,
        lambda=lambda,
        A_WInn=A_WInn,
        z=z) annotation (Placement(transformation(rotation=0, extent={{-84,-58},
                {-64,-38}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
        annotation (Placement(transformation(extent={{88,-12},{112,12}}),
            iconTransformation(extent={{90,-10},{110,10}})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor engHeatToCoolant
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
      AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing_EngineBlock
        engineBlock(
        CEngBlo=CEngBlo,
        GInnWall=GInnWall,
        GEngBlo=GEngBlo,
        dInn=dInn,
        dOut=dOut,
        lambda=lambda,
        rhoEngWall=rhoEngWall,
        c=c,
        A_WInn=A_WInn,
        z=z,
        mEngBlo=mEngBlo,
        mEng=mEng,
        mEngWall=mEngWall,
        GEngToAmb=GEngToAmb,
        outerEngineBlock(T(start=T_Amb))) annotation (Placement(transformation(
              rotation=0, extent={{-6,-46},{14,-26}})));

      Modelica.Blocks.Sources.RealExpression calculatedExhaustTemp(y=T_Exh)
        annotation (Placement(transformation(extent={{28,40},{10,60}})));
      Modelica.Blocks.Interfaces.RealOutput exhaustGasTemperature
        annotation (Placement(transformation(extent={{12,-12},{-12,12}},
            rotation=270,
            origin={0,106}),
            iconTransformation(extent={{14,-14},{-14,14}},
            rotation=270,
            origin={0,122})));
    equation

     /* if EngOp and m_Exh>0.001 then
  T_CylWall=0.5*(T_Com+T_Amb)*CalTCyl;
  else
  T_CylWall=T_Amb;
  end if;*/
      CalT_Exh = meanCpExh*m_Exh;

      if noEvent(nEng*60<800) then
      T_CylWall=innerWall.T;
      T_Exh=innerWall.T;
      else
      T_CylWall=T_Amb+0.2929*(T_Com-T_Amb);
      T_Exh=T_ExhPowUniOut + abs((cylToInnerWall.maximumEngineHeat.y-actualHeatFlowEngine.Q_flow)/CalT_Exh);
      end if;

     // T_CylWall=T_Amb+0.2929*(T_Com-T_Amb);
      // T_CylWall=(T_Com-T_Amb)/Modelica.Math.log(T_Com/T_Amb);

     /* if abs(QuoT_SupRet-1)>0.0001 then
  T_LogMeanCool=(T_CoolSup-T_CoolRet)/Modelica.Math.log(QuoT_SupRet);
  else
  T_LogMeanCool=T_CoolRet;
  end if; */

      connect(actualHeatFlowEngine.port,innerWall. port)
        annotation (Line(points={{-36,-48},{-24,-48}},color={191,0,0}));
      connect(engineBlock.port_a, innerWall.port) annotation (Line(points={{-5,-32},
              {-24,-32},{-24,-48}},      color={191,0,0}));
      connect(cylToInnerWall.y, actualHeatFlowEngine.Q_flow)
        annotation (Line(points={{-63.4,-48},{-56,-48}}, color={0,0,127}));
      connect(cylToInnerWall.T, realExpr2.y) annotation (Line(points={{-83.8,-51},{
              -92,-51},{-92,-58},{-95,-58}},
                                           color={0,0,127}));
      connect(realExpr1.y, cylToInnerWall.T1) annotation (Line(points={{-95,-38},{
              -92,-38},{-92,-45},{-83.8,-45}},
                                            color={0,0,127}));
      connect(engineBlock.port_a1, port_Ambient)
        annotation (Line(points={{0,-45},{0,-100}}, color={191,0,0}));
      connect(innerThermalCond2_1.port_a, innerWall.port)
        annotation (Line(points={{-20,0},{-24,0},{-24,-48}}, color={191,0,0}));
      connect(port_CoolingCircle, engHeatToCoolant.port_b)
        annotation (Line(points={{100,0},{50,0}}, color={191,0,0}));
      connect(innerThermalCond2_1.port_b, engHeatToCoolant.port_a)
        annotation (Line(points={{0,0},{30,0}}, color={191,0,0}));
      connect(calculatedExhaustTemp.y, exhaustGasTemperature)
        annotation (Line(points={{9.1,50},{0,50},{0,106}}, color={0,0,127}));
      annotation (
        Documentation(revisions="<html>
<ul>
<li><i>October, 2016&nbsp;</i> by Peter Remmen:<br/>Transfer to AixLib.</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>
",     info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p><br>The model of the motor housing uses a build-up scheme as a two-layer wall with thermal transitions to a circulating cooling medium. Assumptions were made to simplify the thermal simulation.</p>
<h4>Assumptions</h4>
<p>From individual cylinders, a total area (assumption: cylinder is at bottom dead center) is calculated and the heat conduction is modeled as a flat wall. This approximation of the unknown motor geometry with heat transfers to the environment and the cooling water circuit needs to be calibrated. </p>
<p>The engine block consists of a homogeneous material with known total weight and is divided into an inner and an outer part (default is grey cast iron)</p>
<p>For simplicity the oil circuit is considered as a capacity in the outer engine block that needs to calibrated as well. The cooling water circuit is assumed to run between these two parts (only the outer part interacts with the environment).</p>
<p>The thickness of the inner engine block is an essential, but unknown variable (literature indicates values ​​around 5mm for car engines). Attachments and individual different material layers in the engine block are not taken into account for simplicity and can be approximated by calibration. The insulating housing of the power unit has no own capacity.</p>
<p>The heat transfer (cylinder wall to cooling water circuit) is calibrated and assumed to be proportional to the temperature difference because due to unknown cooling channel geometry the calculation of a convective heat transfer coefficient is not possible.</p>
<p>The temperature profile of the cylinder wall is homogeneously formed from the ambient temperature and the maximum combustion temperature (temperature curve in cylinder as a triangle with T_Amb - T_Com - T_Amb). Therefore a mean cylinder wall temperature is determinated using a bisector in the temperature profile as shown in the following figure.</p>
<p align=\"center\"><br><span style=\"font-size: 12pt;\"><img src=\"modelica://AixLib/Resources/Images/Fluid/BoilerCHP/CylinderWallTemperature.png\" width=\"550\" height=\"375\" alt=\"Calculation of the cylinder wall temperature\"/></span> </p>
</html>"),   Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
                  graphics={
            Rectangle(
              extent={{-80,80},{-50,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-50,80},{-20,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,80},{20,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,80},{52,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{50,80},{80,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-86,98},{84,82}},
              lineColor={28,108,200},
              textStyle={TextStyle.Bold},
              textString="%name")}),
        Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
    end GasolineEngineChp_EngineHousing;

    model GasolineEngineChp_EngineHousing_CylToInnerWall
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        logMeanTempCylWall
        annotation (Placement(transformation(extent={{-76,-22},{-56,-2}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        innerThermalConductor1(G=GInnWall/2) annotation (Placement(transformation(
              extent={{-32,-22},{-12,-2}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowEngine
        annotation (Placement(transformation(extent={{12,-22},{32,-2}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        temperatureInnerWall
        annotation (Placement(transformation(extent={{-32,6},{-12,26}})));
      Modelica.Blocks.Nonlinear.VariableLimiter heatLimit(strict=true)
        annotation (Placement(transformation(extent={{12,-54},{28,-38}})));
      Modelica.Blocks.Sources.RealExpression maximumEngineHeat
        annotation (Placement(transformation(extent={{-34,-50},{-14,-30}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-24,-60},{-14,-50}})));
      parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
      "Thermal conductance of the inner engine wall"
      annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.Thickness dInn=0.005
        "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Modelica.SIunits.ThermalConductivity lambda=44.5
        "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 +
          hStr*(1 + 1/(eps - 1))))
        "Area of heat transporting surface from cylinder wall to outer engine block"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Real z=4
      annotation (Dialog(tab="Structure", group="Engine Properties"));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
            transformation(rotation=0, extent={{96,-10},{116,10}})));
      Modelica.Blocks.Interfaces.RealInput T(unit="K") annotation (Placement(
            transformation(rotation=0, extent={{-118,-40},{-94,-16}}),
            iconTransformation(extent={{-108,-40},{-88,-20}})));
      Modelica.Blocks.Interfaces.RealInput T1(unit="K") annotation (Placement(
            transformation(rotation=0, extent={{-118,4},{-94,28}}),
            iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-98,30})));
    equation
      connect(heatFlowEngine.Q_flow,heatLimit. u) annotation (Line(points={{22,-22},
              {22,-30},{-46,-30},{-46,-46},{10.4,-46}},     color={0,0,127}));
      connect(innerThermalConductor1.port_b,heatFlowEngine. port_a)
        annotation (Line(points={{-12,-12},{12,-12}},  color={191,0,0}));
      connect(heatFlowEngine.port_b,temperatureInnerWall. port) annotation (Line(
            points={{32,-12},{36,-12},{36,16},{-12,16}},    color={191,0,0}));
      connect(T, logMeanTempCylWall.T) annotation (Line(points={{-106,-28},{-88,
              -28},{-88,-12},{-78,-12}}, color={0,0,127}));
      connect(heatLimit.y, y) annotation (Line(points={{28.8,-46},{54,-46},{54,0},
              {106,0}}, color={0,0,127}));
      connect(logMeanTempCylWall.port, innerThermalConductor1.port_a)
        annotation (Line(points={{-56,-12},{-32,-12}}, color={191,0,0}));
      connect(temperatureInnerWall.T, T1)
        annotation (Line(points={{-34,16},{-106,16}}, color={0,0,127}));
      connect(maximumEngineHeat.y, heatLimit.limit1) annotation (Line(points={{
              -13,-40},{-2,-40},{-2,-39.6},{10.4,-39.6}}, color={0,0,127}));
      connect(const.y, heatLimit.limit2) annotation (Line(points={{-13.5,-55},{-2,
              -55},{-2,-52.4},{10.4,-52.4}}, color={0,0,127}));
      annotation (Icon(graphics={ Rectangle(
              extent={{-60,80},{60,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,170,255}),
            Text(
              extent={{-40,50},{42,32}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.None,
              textString="Cylinder
to engine"),Line(
              points={{60,0},{96,0},{96,10},{116,0},{96,-10},{96,0}},
              color={238,46,47},
              thickness=1),
            Text(
              extent={{62,14},{94,-2}},
              lineColor={238,46,47},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="Q_Cyl",
              fontSize=20)}));
    end GasolineEngineChp_EngineHousing_CylToInnerWall;

    model GasolineEngineChp_EngineHousing_EngineBlock
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        innerThermalCond2_2(G=GInnWall/2) annotation (Placement(transformation(
              extent={{-42,-10},{-22,10}},rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond(
          G=GEngBlo/2) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}},  rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor outerEngineBlock(
        der_T(fixed=false, start=0),
        C=CEngBlo,
        T(start=T_Amb,
          fixed=true))      annotation (Placement(transformation(
            origin={22,-10},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond2(
         G=GEngBlo/2) annotation (Placement(transformation(extent={{34,-10},{54,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor toAmbient(G=GEngToAmb)
                       annotation (Placement(transformation(extent={{0,-70},{20,-50}},
                       rotation=0)));
      parameter Modelica.SIunits.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
        "Heat capacity of the remaining engine body"
        annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
        "Thermal conductance from the engine block to the ambient"    annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
      "Thermal conductance of the inner engine wall"
      annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GEngBlo=lambda*A_WInn/dOut
      "Thermal conductance of the outer engine wall"
      annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.Temperature T_Amb=298.15
        "Ambient temperature"
        annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.Thickness dInn=0.005
        "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Modelica.SIunits.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
        "Thickness of outer wall of the remaining engine body"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Modelica.SIunits.ThermalConductivity lambda=44.5
        "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      parameter Modelica.SIunits.Density rhoEngWall=72000
        "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      parameter Modelica.SIunits.SpecificHeatCapacity c=535
        "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
      parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 +
          hStr*(1 + 1/(eps - 1))))
        "Area of heat transporting surface from cylinder wall to outer engine block"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Real z
      annotation (Dialog(tab="Structure", group="Engine Properties"));
      parameter Modelica.SIunits.Mass mEngBlo=mEng - mEngWall
        annotation (Dialog(tab="Structure Calculations"));
      parameter Modelica.SIunits.Mass mEng
      annotation (Dialog(tab="Structure", group="Engine Properties"));
      parameter Modelica.SIunits.Mass mEngWall=A_WInn*rhoEngWall*dInn
        annotation (Dialog(tab="Structure Calculations"));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (
          Placement(transformation(rotation=0, extent={{-100,30},{-80,50}}),
            iconTransformation(extent={{-100,30},{-80,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1 annotation (
          Placement(transformation(rotation=0, extent={{-50,-100},{-30,-80}}),
            iconTransformation(extent={{-50,-100},{-30,-80}})));
    equation
      connect(outerThermalCond.port_b,outerEngineBlock. port)
        annotation (Line(points={{10,0},{22,0}},     color={191,0,0}));
      connect(outerThermalCond.port_a,innerThermalCond2_2. port_b)
        annotation (Line(points={{-10,0},{-22,0}},   color={191,0,0}));
      connect(outerEngineBlock.port,outerThermalCond2. port_a)
        annotation (Line(points={{22,0},{34,0}},     color={191,0,0}));
      connect(port_a, innerThermalCond2_2.port_a) annotation (Line(points={{-90,40},
              {-60,40},{-60,0},{-42,0}},         color={191,0,0}));
      connect(port_a1, toAmbient.port_a) annotation (Line(points={{-40,-90},{-40,
              -60},{0,-60}},  color={191,0,0}));
      connect(outerThermalCond2.port_b, toAmbient.port_b) annotation (Line(points={{54,0},{
              70,0},{70,-60},{20,-60}},            color={191,0,0}));
      annotation (Icon(graphics={Rectangle(
              extent={{-80,80},{80,-80}},
              lineColor={28,108,200},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-60,14},{58,-8}},
              lineColor={255,255,255},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.None,
              textString="EngineBlock
to ambient")}));
    end GasolineEngineChp_EngineHousing_EngineBlock;

    annotation (Documentation(info="<html>
<p>This package contains base classe components that are used to construct the models in <a href=\"modelica://AixLib.Fluid.ModularCHP\">AixLib.Fluid.ModularCHP</a>. </p>
</html>"));
  end BaseClassComponents;

  package Examples
    extends Modelica.Icons.ExamplesPackage;
    model ModularCHP_PowerUnit
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
        "Default ambient pressure" annotation (Dialog(group=
              "Ambient Parameters"));
      Modelica.SIunits.Temperature T_Ret=senTRetHea.T "Coolant return temperature";
      Modelica.SIunits.Temperature T_Sup=senTSupHea.T "Coolant supply temperature";
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

      parameter Real s_til=abs((cHP_PowerUnit.inductionMachine.s_nominal*(
          cHP_PowerUnit.inductionMachine.M_til/cHP_PowerUnit.inductionMachine.M_nominal)
           + cHP_PowerUnit.inductionMachine.s_nominal*sqrt(abs(((cHP_PowerUnit.inductionMachine.M_til
          /cHP_PowerUnit.inductionMachine.M_nominal)^2) - 1 + 2*cHP_PowerUnit.inductionMachine.s_nominal
          *((cHP_PowerUnit.inductionMachine.M_til/cHP_PowerUnit.inductionMachine.M_nominal)
           - 1))))/(1 - 2*cHP_PowerUnit.inductionMachine.s_nominal*((cHP_PowerUnit.inductionMachine.M_til
          /cHP_PowerUnit.inductionMachine.M_nominal) - 1)))
        "Tilting slip of electric machine" annotation (Dialog(tab="Calibration parameters",
            group="Fast calibration - Electric power and fuel usage"));
      parameter Real calFac=0.94
        "Calibration factor for electric power output (default=1)"
        annotation (Dialog(tab="Calibration parameters",
        group="Fast calibration - Electric power and fuel usage"));
      parameter Modelica.SIunits.ThermalConductance GEngToCoo=33
        "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
        annotation (Dialog(tab="Calibration parameters",group=
              "Fast calibration - Thermal power output"));
      parameter Modelica.SIunits.ThermalConductance GCooExhHex=400
        "Thermal conductance of the coolant heat exchanger at nominal flow"
        annotation (Dialog(tab="Calibration parameters",group="Fast calibration - Thermal power output"));
      parameter Modelica.SIunits.HeatCapacity CExhHex=50000
        "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
         Dialog(tab="Calibration parameters",group=
              "Advanced calibration parameters"));
    protected
      parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng + Cal_mEng
        "Total engine mass for heat capacity calculation"
        annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
    public
      parameter Modelica.SIunits.Mass Cal_mEng=0
        "Added engine mass for calibration purposes of the system´s thermal inertia"
        annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
      parameter Modelica.SIunits.Area A_surExhHea=100
        "Surface for exhaust heat transfer"
        annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
      parameter Modelica.SIunits.MassFlowRate m_flow_Coo=0.4
        "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (
         Dialog(tab="Calibration parameters",group=
              "Advanced calibration parameters"));
      parameter Modelica.SIunits.Thickness dInn=0.01
        "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
        annotation (Dialog(tab="Calibration parameters",group="Fast calibration - Thermal power output"));
      parameter Modelica.SIunits.ThermalConductance GEngToAmb=2
        "Thermal conductance from engine housing to the surrounding air"
        annotation (Dialog(tab="Calibration parameters",group="Advanced calibration parameters"));
      parameter Modelica.SIunits.ThermalConductance GAmb=10
        "Constant heat transfer coefficient of engine housing to ambient" annotation (
         Dialog(tab="Calibration parameters",group=
              "Advanced calibration parameters"));
      parameter Real modTab[:,2]=[0.0,0.8; 7200,0.8; 7200,0.93; 10800,0.93; 10800,0.62;
          14400,0.62; 14400,0.8; 18000,0.8; 18000,0.0]
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

      AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.ModularCHP_PowerUnit
        cHP_PowerUnit(
        redeclare package Medium_Fuel = Medium_Fuel,
        CHPEngineModel=CHPEngineModel,
        EngMat=EngMat,
        T_amb=T_amb,
        p_amb=p_amb,
        m_flow=m_flow_Coo,
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
        dInn=dInn,
        GAmb=GAmb,
        calFac=calFac,
        GEngToCoo=GEngToCoo,
        GEngToAmb=GEngToAmb)
        annotation (Placement(transformation(extent={{-24,0},{24,48}})));

      AixLib.Fluid.HeatExchangers.ConstantEffectiveness coolantHex(
        allowFlowReversal1=allowFlowReversalCoolant,
        allowFlowReversal2=allowFlowReversalCoolant,
        m2_flow_nominal=CHPEngineModel.m_floCooNominal,
        m1_flow_small=mCool_flow_small,
        m2_flow_small=mCool_flow_small,
        redeclare package Medium1 = Medium_Coolant,
        m1_flow_nominal=m_flow_Coo,
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
        annotation (Placement(transformation(extent={{-108,-74},{-88,-54}})));
      Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                                   nPorts=1, redeclare package Medium =
            Medium_HeatingCircuit)
        annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort senTRetHea(
        m_flow_small=mCool_flow_small,
        m_flow_nominal=CHPEngineModel.m_floCooNominal,
        redeclare package Medium = Medium_HeatingCircuit)
        annotation (Placement(transformation(extent={{-46,-72},{-30,-56}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort senTSupHea(
        m_flow_small=mCool_flow_small,
        m_flow_nominal=CHPEngineModel.m_floCooNominal,
        redeclare package Medium = Medium_HeatingCircuit)
        annotation (Placement(transformation(extent={{52,-72},{68,-56}})));

      Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
        annotation (Placement(transformation(extent={{-144,-76},{-124,-56}})));
      AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.OnOff_ControllerEasy
        ControllerCHP(CHPEngineModel=CHPEngineModel, startTimeChp=3600,
        modTab=modTab)                                                  annotation (
         Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
      AixLib.Fluid.Sensors.DensityTwoPort senDen(
        m_flow_small=mCool_flow_small,
        m_flow_nominal=CHPEngineModel.m_floCooNominal,
        redeclare package Medium = Medium_HeatingCircuit)
        annotation (Placement(transformation(extent={{-76,-72},{-60,-56}})));
      Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flow_HeaCir)
        annotation (Placement(transformation(extent={{-144,-60},{-124,-40}})));

    equation
      connect(coolantHex.port_a2, senTRetHea.port_b)
        annotation (Line(points={{-20,-64},{-30,-64}}, color={0,127,255}));
      connect(coolantHex.port_b2, senTSupHea.port_a)
        annotation (Line(points={{20,-64},{52,-64}}, color={0,127,255}));
      connect(senTSupHea.port_b, heatingSupplyFlow.ports[1])
        annotation (Line(points={{68,-64},{90,-64}}, color={0,127,255}));
      connect(heatingReturnFlow.T_in, tempFlowHeating.y)
        annotation (Line(points={{-110,-60},{-118,-60},{-118,-66},{-123,-66}},
                                                         color={0,0,127}));
      connect(ControllerCHP.modCHPConBus, cHP_PowerUnit.sigBusCHP) annotation (Line(
          points={{-44,80},{-0.24,80},{-0.24,46.32}},
          color={255,204,51},
          thickness=0.5));
      connect(heatingReturnFlow.ports[1], senDen.port_a)
        annotation (Line(points={{-88,-64},{-76,-64}}, color={0,127,255}));
      connect(senTRetHea.port_a, senDen.port_b)
        annotation (Line(points={{-46,-64},{-60,-64}}, color={0,127,255}));
      connect(massFlowHeating.y, heatingReturnFlow.m_flow_in) annotation (Line(
            points={{-123,-50},{-118,-50},{-118,-56},{-108,-56}}, color={0,0,127}));
      connect(coolantHex.port_b1,cHP_PowerUnit.port_retCoo)  annotation (Line(
            points={{-20,-40},{-60,-40},{-60,10.08},{-19.2,10.08}}, color={0,127,
              255}));
      connect(cHP_PowerUnit.port_supCoo, coolantHex.port_a1) annotation (Line(
            points={{19.2,10.08},{60,10.08},{60,-40},{20,-40}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), experiment(StopTime=18000, Interval=5), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
             __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
        Documentation(info="<html>
<p>An example of the use of modular CHP components combined as a power unit with interfaces to a controller and to the heating circuit.</p>
<p>It allows an impression of the versatile and complex application possibilities of the model by the changeability of many variables of individual components and the detailed investigation capability.</p>
<p>The return temperature as well as the volume flow in the heating circuit are considered constant.</p>
<p><br><br>Caution: </p>
<p>If the prime coolant cirlce of the power unit is using a gasoline medium instead of a liquid fluid, you may need to adjust (raise) the nominal mass flow and pressure drop of the cooling to heating heat exchanger to run the model, because of a background calculation for the nominal flow.</p>
</html>"));
    end ModularCHP_PowerUnit;
  end Examples;
  annotation (Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.ModularCHP\">AixLib.Fluid.ModularCHP</a>.
</p>
</html>"));
end BaseClasses;
