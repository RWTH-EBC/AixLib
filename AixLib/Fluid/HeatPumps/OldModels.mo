within AixLib.Fluid.HeatPumps;
package OldModels
  model HeatPumpNEWBACKUP
    "Grey-box heat pump model using a black-box to simulate the refrigeration cycle"
    extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
      redeclare final package Medium1 = Medium_con,
      redeclare final package Medium2 = Medium_eva,
      final m1_flow_nominal=mFlow_conNominal,
      final m2_flow_nominal=mFlow_evaNominal,
      final allowFlowReversal1=allowFlowReversalCon,
      final allowFlowReversal2=allowFlowReversalEva,
      final m1_flow_small=1E-4*abs(mFlow_conNominal),
      final m2_flow_small=1E-4*abs(mFlow_evaNominal),
      final show_T=show_TPort);

  //General
    replaceable package Medium_con =
      Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
      annotation (Dialog(tab = "Condenser"),choicesAllMatching=true);
    replaceable package Medium_eva =
      Modelica.Media.Interfaces.PartialMedium "Medium at source side"
      annotation (Dialog(tab = "Evaporator"),choicesAllMatching=true);
    parameter Integer use_revHP=1    "Operating type of the system" annotation(choices(
        choice=1   "reversible HP",
        choice=2   "only heating operation",
        choice=3   "only cooling operation",
        radioButtons=true), Dialog(descriptionLabel=true));

    replaceable model PerDataHea =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.BaseClasses.PartialPerformanceDataNEW
    "Performance data of HP in heating mode"
      annotation (choicesAllMatching=true);
    replaceable model PerDataChi =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.BaseClasses.PartialPerformanceDataNEW
    "Performance data of HP in chilling mode"
      annotation (choicesAllMatching=true);

    parameter Real scalingFactor=1 "Scaling-factor of HP";
    parameter Boolean use_refIne=true
      "Consider the inertia of the refrigerant cycle"                           annotation(choices(checkBox=true), Dialog(
          group="Refrigerant inertia"));

    parameter Modelica.SIunits.Frequency refIneFre_constant
      "Cut off frequency for inertia of refrigerant cycle"
      annotation (Dialog(enable=use_refIne, group="Refrigerant inertia"),Evaluate=true);
    parameter Integer nthOrder=3 "Order of refrigerant cycle interia" annotation (Dialog(enable=
            use_refIne, group="Refrigerant inertia"));

  //Condenser
    parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
      "Nominal mass flow rate"
      annotation (Dialog(group="Parameters", tab="Condenser"),Evaluate=true);
    parameter Modelica.SIunits.Volume VCon "Volume in condenser"
      annotation (Evaluate=true,Dialog(group="Parameters", tab="Condenser"));
    parameter Modelica.SIunits.PressureDifference dpCon_nominal
      "Pressure drop at nominal mass flow rate"
      annotation (Dialog(group="Flow resistance", tab="Condenser"), Evaluate=true);
    parameter Real deltaM_con=0.1
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
      annotation (Dialog(tab="Condenser", group="Flow resistance"));
    parameter Boolean use_conCap=true
      "If heat losses at capacitor side are considered or not"
      annotation (Dialog(group="Heat Losses", tab="Condenser"),
                                            choices(checkBox=true));
    parameter Modelica.SIunits.HeatCapacity CCon
      "Heat capacity of Condenser (= cp*m)" annotation (Evaluate=true,Dialog(group="Heat Losses",
          tab="Condenser",
        enable=use_conCap));
    parameter Modelica.SIunits.ThermalConductance GConOut
      "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Condenser",
        enable=use_conCap));
    parameter Modelica.SIunits.ThermalConductance GConIns
      "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Condenser",
        enable=use_conCap));
  //Evaporator
    parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
      "Nominal mass flow rate" annotation (Dialog(group="Parameters", tab="Evaporator"),Evaluate=true);

    parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
      annotation (Evaluate=true,Dialog(group="Parameters", tab="Evaporator"));
    parameter Modelica.SIunits.PressureDifference dpEva_nominal
      "Pressure drop at nominal mass flow rate"
      annotation (Dialog(group="Flow resistance", tab="Evaporator"),Evaluate=true);
    parameter Real deltaM_eva=0.1
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
      annotation (Dialog(tab="Evaporator", group="Flow resistance"));
    parameter Boolean use_evaCap=true
      "If heat losses at capacitor side are considered or not"
      annotation (Dialog(group="Heat Losses", tab="Evaporator"),
                                            choices(checkBox=true));
    parameter Modelica.SIunits.HeatCapacity CEva
      "Heat capacity of Evaporator (= cp*m)"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
    parameter Modelica.SIunits.ThermalConductance GEvaOut
      "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
    parameter Modelica.SIunits.ThermalConductance GEvaIns
      "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
  //Assumptions
    parameter Modelica.SIunits.Time tauSenT=1
      "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
      annotation (Dialog(tab="Assumptions", group="Temperature sensors"));

    parameter Boolean transferHeat=true
      "If true, temperature T converges towards TAmb when no flow"
      annotation (Dialog(tab="Assumptions", group="Temperature sensors"),choices(checkBox=true));
    parameter Boolean allowFlowReversalEva=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(group="Evaporator", tab="Assumptions"));
    parameter Boolean allowFlowReversalCon=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(group="Condenser", tab="Assumptions"));

    parameter Modelica.SIunits.Time tauHeaTraEva=1200
      "Time constant for heat transfer in temperature sensors in evaporator, default 20 minutes"
      annotation (Dialog(tab="Assumptions", group="Evaporator",enable=transferHeat),         Evaluate=true);
    parameter Modelica.SIunits.Time tauHeaTraCon=1200
      "Time constant for heat transfer in temperature sensors in evaporator, default 20 minutes"
      annotation (Dialog(tab="Assumptions", group="Condenser",enable=transferHeat),Evaluate=true);
    parameter Modelica.SIunits.Temperature TAmbCon_nominal=291.15
      "Fixed ambient temperature for heat transfer of sensors at the condenser side" annotation (               Dialog(tab=
            "Assumptions",                                                                                               group=
            "Condenser",
        enable=transferHeat));

    parameter Modelica.SIunits.Temperature TAmbEva_nominal=273.15
      "Fixed ambient temperature for heat transfer of sensors at the evaporator side"
      annotation (               Dialog(tab="Assumptions",group="Evaporator",enable=transferHeat));

  //Initialization
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
      "Type of initialization (InitialState and InitialOutput are identical)"
      annotation (Dialog(tab="Initialization", group="Parameters"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pCon_start=
        Medium_con.p_default "Start value of pressure"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.Temperature TCon_start=Medium_con.T_default
      "Start value of temperature"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.MassFraction XCon_start[Medium_con.nX]=
       Medium_con.X_default "Start value of mass fractions m_i/m"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pEva_start=
        Medium_eva.p_default "Start value of pressure"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Modelica.Media.Interfaces.Types.Temperature TEva_start=Medium_eva.T_default
      "Start value of temperature"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Modelica.Media.Interfaces.Types.MassFraction XEva_start[Medium_eva.nX]=
       Medium_eva.X_default "Start value of mass fractions m_i/m"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Real x_start[nthOrder]=zeros(nthOrder)
      "Initial or guess values of states"
      annotation (Dialog(tab="Initialization", group="Refrigerant inertia", enable=use_refIne));
    parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Initialization", group="Refrigerant inertia",enable=initType ==
            Init.InitialOutput and use_refIne));
  //Dynamics
    parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of mass balance: dynamic (3 initialization options) or steady state"
      annotation (Dialog(tab="Dynamics", group="Equation"));
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation (Dialog(tab="Dynamics", group="Equation"));
  //Advanced
    parameter Boolean show_TPort=false
      "= true, if actual temperature at port is computed"
      annotation(Dialog(tab="Advanced",group="Diagnostics"));
    parameter Boolean from_dp=false
      "= true, use m_flow = f(dp) else dp = f(m_flow)"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    parameter Boolean homotopyInitialization=false "= true, use homotopy method"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    parameter Boolean linearized=false
      "= true, use linear relation between m_flow and dp for any flow rate"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    Boolean mode = true                    "True: Heating; False: Cooling";
                        /*sigBusHP.mode */

    AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity con(
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*abs(mFlow_conNominal),
      final show_T=show_TPort,
      final deltaM=deltaM_con,
      final T_start=TCon_start,
      final p_start=pCon_start,
      final use_cap=use_conCap,
      final X_start=XCon_start,
      final from_dp=from_dp,
      final homotopyInitialization=homotopyInitialization,
      final massDynamics=massDynamics,
      final energyDynamics=energyDynamics,
      final is_con=true,
      final V=VCon*scalingFactor,
      final C=CCon*scalingFactor,
      final GOut=GConOut*scalingFactor,
      final m_flow_nominal=mFlow_conNominal*scalingFactor,
      final dp_nominal=dpCon_nominal*scalingFactor,
      final GInn=GConIns*scalingFactor) "Heat exchanger model for the condenser"
      annotation (Placement(transformation(extent={{-16,78},{16,110}})));
    AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity eva(
      redeclare final package Medium = Medium_eva,
      final deltaM=deltaM_eva,
      final use_cap=use_evaCap,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*abs(mFlow_evaNominal),
      final show_T=show_TPort,
      final T_start=TEva_start,
      final p_start=pEva_start,
      final X_start=XEva_start,
      final from_dp=from_dp,
      final homotopyInitialization=homotopyInitialization,
      final massDynamics=massDynamics,
      final energyDynamics=energyDynamics,
      final is_con=false,
      final V=VEva*scalingFactor,
      final C=CEva*scalingFactor,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor,
      final dp_nominal=dpEva_nominal*scalingFactor,
      final GOut=GEvaOut*scalingFactor,
      GInn=GEvaIns*scalingFactor) "Heat exchanger model for the evaporator"
      annotation (Placement(transformation(extent={{16,-70},{-16,-102}})));
    Modelica.Blocks.Continuous.CriticalDamping heatFlowIneEva(
      final initType=initType,
      final normalized=true,
      final n=nthOrder,
      final f=refIneFre_constant,
      final x_start=x_start,
      final y_start=yRefIne_start) if
                                     use_refIne
      "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
      annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={-14,-52})));
    Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetCon if
                                                                   not use_refIne
      "Use default nSet value" annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={16,58})));
    Modelica.Blocks.Continuous.CriticalDamping heatFlowIneCon(
      final initType=initType,
      final normalized=true,
      final n=nthOrder,
      final f=refIneFre_constant,
      final x_start=x_start,
      final y_start=yRefIne_start) if
                                     use_refIne
      "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
      annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={-16,58})));
    Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetEva if
                                                                   not use_refIne
      "Use default nSet value" annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={16,-52})));
    Modelica.Blocks.Interfaces.RealInput iceFac_in
      "Input signal for icing factor" annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={-76,-136})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutEva if
      use_evaCap "Foreces heat losses according to ambient temperature"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={68,-108})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutCon if
      use_conCap "Foreces heat losses according to ambient temperature"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={68,110})));

    Modelica.Blocks.Interfaces.RealInput nSet
      "Input signal speed for compressor relative between 0 and 1" annotation (Placement(
          transformation(extent={{-132,4},{-100,36}})));
    Controls.Interfaces.HeatPumpControlBusNEW sigBusHP
      annotation (Placement(transformation(extent={{-120,-60},{-90,-26}}),
          iconTransformation(extent={{-108,-52},{-90,-26}})));
    InnerCycleNEW innerCycle(
      redeclare final model PerDataHea = PerDataHea,
      redeclare final model PerDataChi = PerDataChi,
      final use_revHP=use_revHP,
      final scalingFactor=scalingFactor) annotation (Placement(transformation(
          extent={{-27,-26},{27,26}},
          rotation=90,
          origin={0,-1})));
    Modelica.Blocks.Interfaces.RealInput T_amb_eva(final unit="K", final
        displayUnit="degC")
      "Ambient temperature on the evaporator side"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=0,
          origin={110,-100})));
    Modelica.Blocks.Interfaces.RealInput T_amb_con(final unit="K", final
        displayUnit="degC")
      "Ambient temperature on the condenser side"
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=180,
          origin={110,100})));

    Modelica.Blocks.Interfaces.BooleanInput modeSet if use_revHP==1
      "Set value of HP mode"
      annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));
    Modelica.Blocks.Sources.BooleanExpression opType(y=if use_revHP==2
           then true else false) if not use_revHP==1
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));

    Sensors.TemperatureTwoPort senT_a2(
      redeclare final package Medium = Medium_eva,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*mFlow_evaNominal,
      final initType=initType,
      final T_start=TEva_start,
      final transferHeat=transferHeat,
      final TAmb=TAmbEva_nominal,
      final tauHeaTra=tauHeaTraEva,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor)
      "Temperature at sink inlet" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={38,-86})));
    Sensors.MassFlowRate mFlow_eva(redeclare final package Medium = Medium_eva,
        final allowFlowReversal=allowFlowReversalEva)
      "Mass flow sensor at the evaporator" annotation (Placement(transformation(
          origin={74,-60},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    Sensors.TemperatureTwoPort senT_b1(
      final initType=initType,
      final transferHeat=transferHeat,
      final TAmb=TAmbCon_nominal,
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*mFlow_conNominal,
      final T_start=TCon_start,
      final tau=tauSenT,
      final tauHeaTra=tauHeaTraCon,
      final m_flow_nominal=mFlow_conNominal*scalingFactor)
      "Temperature at sink outlet" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={38,92})));
    Sensors.TemperatureTwoPort senT_a1(
      final initType=initType,
      final transferHeat=transferHeat,
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*mFlow_conNominal,
      final T_start=TCon_start,
      final TAmb=TAmbCon_nominal,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_conNominal*scalingFactor,
      final tauHeaTra=tauHeaTraCon)
      "Temperature at sink inlet" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={-34,90})));
    Sensors.MassFlowRate mFlow_con(final allowFlowReversal=allowFlowReversalEva,
        redeclare final package Medium = Medium_con)
      "Mass flow sensor at the evaporator" annotation (Placement(transformation(
          origin={-76,60},
          extent={{-10,10},{10,-10}},
          rotation=0)));

    Sensors.TemperatureTwoPort senT_b2(
      redeclare final package Medium = Medium_eva,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*mFlow_evaNominal,
      final initType=initType,
      final T_start=TEva_start,
      final transferHeat=transferHeat,
      final TAmb=TAmbEva_nominal,
      final tauHeaTra=tauHeaTraEva,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor)
      "Temperature at sink outlet" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-52,-86})));

  equation
    if use_revHP==1 then
    connect(modeSet, sigBusHP.mode) annotation (Line(points={{-116,-20},{-76,-20},
            {-76,-42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    else
    connect(opType.y, sigBusHP.mode) annotation (Line(points={{-99,0},{-76,0},{-76,
            -42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));

    end if;

    //Connect fluid ports to condenser and evaporator

    if mode then
    //Connect fluid ports for heating
    connect(port_a2, mFlow_eva.port_a) annotation (Line(points={{100,-60},{84,-60}}, color={0,127,255}));
    connect(port_a1, mFlow_con.port_a) annotation (Line(points={{-100,60},{-86,60}}, color={0,127,255}));
    connect(port_b2, senT_b2.port_b) annotation (Line(points={{-100,-60},{-70,-60},
              {-70,-86},{-62,-86}},
                         color={0,127,255}));
    connect(port_b1, senT_b1.port_b) annotation (Line(points={{100,60},{72,60},{72,
            92},{48,92}}, color={0,127,255}));

    else
    //Connect fluid ports for cooling
    connect(port_a1, mFlow_eva.port_a) annotation (Line(points={{-100,60},{-94,60},
              {-94,120},{90,120},{90,-60},{84,-60}},
                                                   color={0,127,255},
            pattern=LinePattern.Dash));
    connect(port_a2, mFlow_con.port_a) annotation (Line(points={{100,-60},{88,-60},
              {88,118},{-90,118},{-90,60},{-86,60}},            color={0,127,255},
            pattern=LinePattern.Dash));
    connect(port_b2, senT_b1.port_b) annotation (Line(points={{-100,-60},{-100,
              -60},{-100,-60},{-100,-60},{-100,-122},{124,-122},{124,94},{124,94},
              {124,94},{48,94},{48,94},{48,94},{48,94},{48,94},{48,92},{48,92}},
                                                                      color={0,127,
            255}, pattern=LinePattern.Dash));
    connect(port_b1, senT_b2.port_b) annotation (Line(points={{100,60},{120,60},{
              120,60},{120,60},{120,60},{120,60},{120,60},{120,60},{120,-120},{
              -62,-120},{-62,-86}},
            color={0,127,255}, pattern=LinePattern.Dash));
    end if;

    connect(innerCycle.Pel, sigBusHP.Pel) annotation (Line(points={{28.73,-0.865},
            {38,-0.865},{38,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}},
                                                    color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(nSet, sigBusHP.N) annotation (Line(points={{-116,20},{-76,20},{-76,-42.915},
            {-104.925,-42.915}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(innerCycle.QEva, realPassThroughnSetEva.u) annotation (Line(
        points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{16,-38},{16,-44.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QEva, heatFlowIneEva.u) annotation (Line(
        points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{-14,-38},{-14,-44.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QCon, heatFlowIneCon.u) annotation (Line(
        points={{1.77636e-15,28.7},{1.77636e-15,30},{0,30},{0,40},{-16,40},{-16,50.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QCon, realPassThroughnSetCon.u) annotation (Line(
        points={{1.77636e-15,28.7},{0,28.7},{0,40},{16,40},{16,50.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(sigBusHP, innerCycle.sigBusHP) annotation (Line(
        points={{-105,-43},{-54,-43},{-54,-0.73},{-26.78,-0.73}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(iceFac_in, sigBusHP.iceFac) annotation (Line(points={{-76,-136},{-76,-42.915},
            {-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(T_amb_con, varTempOutCon.T) annotation (Line(
        points={{110,100},{84,100},{84,110},{77.6,110}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(varTempOutCon.port, con.port_out) annotation (Line(
        points={{60,110},{0,110}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(T_amb_eva, varTempOutEva.T) annotation (Line(
        points={{110,-100},{94,-100},{94,-108},{77.6,-108}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(eva.port_out, varTempOutEva.port) annotation (Line(
        points={{0,-102},{0,-108},{60,-108}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(realPassThroughnSetCon.y, con.QFlow_in) annotation (Line(
        points={{16,64.6},{16,77.04},{0,77.04}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(heatFlowIneCon.y, con.QFlow_in) annotation (Line(
        points={{-16,64.6},{-16,77.04},{0,77.04}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realPassThroughnSetEva.y, eva.QFlow_in) annotation (Line(points={{16,-58.6},
            {16,-69.04},{0,-69.04}}, color={0,0,127}));
    connect(heatFlowIneEva.y, eva.QFlow_in) annotation (Line(points={{-14,-58.6},{
            -14,-69.04},{0,-69.04}}, color={0,0,127}));
    connect(senT_a2.port_b, eva.port_a)
      annotation (Line(points={{28,-86},{16,-86}}, color={0,127,255}));
    connect(senT_b2.port_a, eva.port_b)
      annotation (Line(points={{-42,-86},{-16,-86}}, color={0,127,255}));
    connect(mFlow_eva.port_b, senT_a2.port_a) annotation (Line(points={{64,-60},{58,
            -60},{58,-86},{48,-86}}, color={0,127,255}));
    connect(con.port_a, senT_a1.port_b)
      annotation (Line(points={{-16,94},{-20,94},{-20,90},{-24,90}},
                                                   color={0,127,255}));
    connect(senT_a1.port_a, mFlow_con.port_b) annotation (Line(points={{-44,90},{-56,
            90},{-56,60},{-66,60}},     color={0,127,255}));
    connect(con.port_b, senT_b1.port_a)
      annotation (Line(points={{16,94},{22,94},{22,92},{28,92}},
                                                 color={0,127,255}));
    connect(senT_b2.T, sigBusHP.T_ret_ev) annotation (Line(points={{-52,-75},{-52,
            -42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_a2.T, sigBusHP.T_flow_ev) annotation (Line(points={{38,-75},{38,-36},
            {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mFlow_eva.m_flow, sigBusHP.m_flow_ev) annotation (Line(points={{74,-49},
            {74,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_b1.T, sigBusHP.T_ret_co) annotation (Line(points={{38,81},{38,-36},
            {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_a1.T, sigBusHP.T_flow_co) annotation (Line(points={{-34,79},{-34,
            40},{-76,40},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mFlow_con.m_flow, sigBusHP.m_flow_co) annotation (Line(points={{-76,
            49},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
          Rectangle(
            extent={{-16,83},{16,-83}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,-64},
            rotation=90),
          Rectangle(
            extent={{-17,83},{17,-83}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,61},
            rotation=90),
          Rectangle(
            extent={{-16,83},{16,-83}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,-64},
            rotation=90,
            visible=not (use_revHP == 3)),
          Rectangle(
            extent={{-17,83},{17,-83}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,61},
            rotation=90,
            visible=not (use_revHP == 3)),
          Text(
            extent={{-76,6},{74,-36}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="%name
"),       Line(
            points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-3,-60},
            rotation=-90),
          Line(
            points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-5,56},
            rotation=-90),
          Rectangle(
            extent={{-82,42},{84,-46}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-88,60},{88,60}}, color={28,108,200}),
          Line(points={{-88,-60},{88,-60}}, color={28,108,200}),
      Line(
      origin={-75.5,-80.333},
      points={{43.5,8.3333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,-11.667},{27.5,-21.667},{13.5,-23.667},
                {11.5,-31.667}},
        smooth=Smooth.Bezier,
        visible=use_evaCap),
          Polygon(
            points={{-70,-122},{-68,-108},{-58,-114},{-70,-122}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_evaCap),
      Line( origin={40.5,93.667},
            points={{39.5,6.333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,
                -11.667},{27.5,-21.667},{13.5,-23.667},{11.5,-27.667}},
            smooth=Smooth.Bezier,
            visible=use_conCap),
          Polygon(
            points={{86,110},{84,96},{74,102},{86,110}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_conCap),
          Line(
            points={{-42,72},{34,72}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5),
          Line(
            points={{-38,0},{38,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5,
            origin={0,-74},
            rotation=180)}),                Diagram(coordinateSystem(extent={{-100,
              -120},{100,120}})),
      Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",   info="<html>
<p>This generic grey-box heat pump model uses empirical data to model the refrigerant cycle. The modelling of system inertias and heat losses allow the simulation of transient states. </p>
<p>Resulting in the choosen model structure, several configurations are possible:</p>
<ol>
<li>Compressor type: on/off or inverter controlled</li>
<li>Reversible heat pump / only heating</li>
<li>Source/Sink: Any combination of mediums is possible</li>
<li>Generik: Losses and inertias can be switched on or off.</li>
</ol>
<h4>Concept</h4>
<p>Using a signal bus as a connector, this heat pump model can be easily combined with the new <a href=\"modelica://AixLib.Systems.HeatPumpSystems.HeatPumpSystem\">HeatPumpSystem</a> or several control or security blocks from <a href=\"modelica://AixLib.Controls.HeatPump\">AixLib.Controls.HeatPump</a>. The relevant data is aggregated. In order to control both chillers and heat pumps, both flow and return temperature are aggregated. The mode signal chooses the type of the heat pump. As a result, this model can also be used as a chiller:</p>
<ul>
<li>mode = true: Heating</li>
<li>mode = false: Chilling</li>
</ul>
<p>To model both on/off and inverter controlled heat pumps, the compressor speed is normalizd to a relative value between 0 and 1.</p>
<p>Possible icing of the evaporator is modelled with an input value between 0 and 1.</p>
<p>The model structure is as follows. To understand each submodel, please have a look at the corresponding model information:</p>
<ol>
<li><a href=\"AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle\">InnerCycle</a> (Black Box): Here, the user can use between several input models or just easily create his own, modular black box model. Please look at the model description for more info.</li>
<li>Inertia: A n-order element is used to model system inertias (mass and thermal) of components inside the refrigerant cycle (compressor, pipes, expansion valve)</li>
<li><a href=\"modelica://AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity\">HeatExchanger</a>: This new model also enable modelling of thermal interias and heat losses in a heat exchanger. Please look at the model description for more info.</li>
</ol>
<h4>Assumptions</h4>
<p>Several assumptions where made in order to model the heat pump. For a detailed description see the corresponding model. </p>
<ol>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">Performance data 2D</a>: In order to model inverter controlled heat pumps, the compressor speed is scaled <b>linearly</b></li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">Performance data 2D</a>: Reduced evaporator power as a result of icing. The icing factor is multiplied with the evaporator power.</li>
<li><b>Inertia</b>: The default value of the n-th order element is set to 3. This follows comparisons with experimental data. Previous heat pump models are using n = 1 as a default. However, it was pointed out that a higher order element fits a real heat pump better in</li>
<li><b>Scaling factor</b>: A scaling facor is implemented for scaling of the heat pump power and capacity. The factor scales the parameters V, m_flow_nominal, C, GIns, GOut and dp_nominal. As a result, the heat pump can supply more heat with the COP staying nearly constant. However, one has to make sure that the supplied pressure difference or mass flow is also scaled with this factor, as the nominal values do not increase said mass flow.</li>
</ol>
<h4>Known Limitations</h4>
<ul>
<li>The n-th order element has a big influence on computational time. Reducing the order or disabling it completly will decrease computational time. </li>
<li>Reversing the mode: A normal 4-way-exchange valve suffers from heat losses and irreversibilities due to switching from one mode to another. Theses losses are not taken into account.</li>
</ul>
</html>"));
  end HeatPumpNEWBACKUP;

  model HeatPumpNEW
    "Grey-box heat pump model using a black-box to simulate the refrigeration cycle"
    extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
      redeclare final package Medium1 = Medium_con,
      redeclare final package Medium2 = Medium_eva,
      final m1_flow_nominal=mFlow_conNominal,
      final m2_flow_nominal=mFlow_evaNominal,
      final allowFlowReversal1=allowFlowReversalCon,
      final allowFlowReversal2=allowFlowReversalEva,
      final m1_flow_small=1E-4*abs(mFlow_conNominal),
      final m2_flow_small=1E-4*abs(mFlow_evaNominal),
      final show_T=show_TPort);

  //General
    replaceable package Medium_con =
      Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
      annotation (Dialog(tab = "Condenser"),choicesAllMatching=true);
    replaceable package Medium_eva =
      Modelica.Media.Interfaces.PartialMedium "Medium at source side"
      annotation (Dialog(tab = "Evaporator"),choicesAllMatching=true);
    parameter Integer use_revHP=1    "Operating type of the system" annotation(choices(
        choice=1   "reversible HP",
        choice=2   "only heating operation",
        choice=3   "only cooling operation",
        radioButtons=true), Dialog(descriptionLabel=true));

    replaceable model PerDataHea =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.BaseClasses.PartialPerformanceDataNEW
    "Performance data of HP in heating mode"
      annotation (choicesAllMatching=true);
    replaceable model PerDataChi =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.BaseClasses.PartialPerformanceDataNEW
    "Performance data of HP in chilling mode"
      annotation (choicesAllMatching=true);

    parameter Real scalingFactor=1 "Scaling-factor of HP";
    parameter Boolean use_refIne=true
      "Consider the inertia of the refrigerant cycle"                           annotation(choices(checkBox=true), Dialog(
          group="Refrigerant inertia"));

    parameter Modelica.SIunits.Frequency refIneFre_constant
      "Cut off frequency for inertia of refrigerant cycle"
      annotation (Dialog(enable=use_refIne, group="Refrigerant inertia"),Evaluate=true);
    parameter Integer nthOrder=3 "Order of refrigerant cycle interia" annotation (Dialog(enable=
            use_refIne, group="Refrigerant inertia"));

  //Condenser
    parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
      "Nominal mass flow rate"
      annotation (Dialog(group="Parameters", tab="Condenser"),Evaluate=true);
    parameter Modelica.SIunits.Volume VCon "Volume in condenser"
      annotation (Evaluate=true,Dialog(group="Parameters", tab="Condenser"));
    parameter Modelica.SIunits.PressureDifference dpCon_nominal
      "Pressure drop at nominal mass flow rate"
      annotation (Dialog(group="Flow resistance", tab="Condenser"), Evaluate=true);
    parameter Real deltaM_con=0.1
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
      annotation (Dialog(tab="Condenser", group="Flow resistance"));
    parameter Boolean use_conCap=true
      "If heat losses at capacitor side are considered or not"
      annotation (Dialog(group="Heat Losses", tab="Condenser"),
                                            choices(checkBox=true));
    parameter Modelica.SIunits.HeatCapacity CCon
      "Heat capacity of Condenser (= cp*m)" annotation (Evaluate=true,Dialog(group="Heat Losses",
          tab="Condenser",
        enable=use_conCap));
    parameter Modelica.SIunits.ThermalConductance GConOut
      "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Condenser",
        enable=use_conCap));
    parameter Modelica.SIunits.ThermalConductance GConIns
      "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Condenser",
        enable=use_conCap));
  //Evaporator
    parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
      "Nominal mass flow rate" annotation (Dialog(group="Parameters", tab="Evaporator"),Evaluate=true);

    parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
      annotation (Evaluate=true,Dialog(group="Parameters", tab="Evaporator"));
    parameter Modelica.SIunits.PressureDifference dpEva_nominal
      "Pressure drop at nominal mass flow rate"
      annotation (Dialog(group="Flow resistance", tab="Evaporator"),Evaluate=true);
    parameter Real deltaM_eva=0.1
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
      annotation (Dialog(tab="Evaporator", group="Flow resistance"));
    parameter Boolean use_evaCap=true
      "If heat losses at capacitor side are considered or not"
      annotation (Dialog(group="Heat Losses", tab="Evaporator"),
                                            choices(checkBox=true));
    parameter Modelica.SIunits.HeatCapacity CEva
      "Heat capacity of Evaporator (= cp*m)"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
    parameter Modelica.SIunits.ThermalConductance GEvaOut
      "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
    parameter Modelica.SIunits.ThermalConductance GEvaIns
      "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
  //Assumptions
    parameter Modelica.SIunits.Time tauSenT=1
      "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
      annotation (Dialog(tab="Assumptions", group="Temperature sensors"));

    parameter Boolean transferHeat=true
      "If true, temperature T converges towards TAmb when no flow"
      annotation (Dialog(tab="Assumptions", group="Temperature sensors"),choices(checkBox=true));
    parameter Boolean allowFlowReversalEva=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(group="Evaporator", tab="Assumptions"));
    parameter Boolean allowFlowReversalCon=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(group="Condenser", tab="Assumptions"));

    parameter Modelica.SIunits.Time tauHeaTraEva=1200
      "Time constant for heat transfer in temperature sensors in evaporator, default 20 minutes"
      annotation (Dialog(tab="Assumptions", group="Evaporator",enable=transferHeat),         Evaluate=true);
    parameter Modelica.SIunits.Time tauHeaTraCon=1200
      "Time constant for heat transfer in temperature sensors in evaporator, default 20 minutes"
      annotation (Dialog(tab="Assumptions", group="Condenser",enable=transferHeat),Evaluate=true);
    parameter Modelica.SIunits.Temperature TAmbCon_nominal=291.15
      "Fixed ambient temperature for heat transfer of sensors at the condenser side" annotation (               Dialog(tab=
            "Assumptions",                                                                                               group=
            "Condenser",
        enable=transferHeat));

    parameter Modelica.SIunits.Temperature TAmbEva_nominal=273.15
      "Fixed ambient temperature for heat transfer of sensors at the evaporator side"
      annotation (               Dialog(tab="Assumptions",group="Evaporator",enable=transferHeat));

  //Initialization
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
      "Type of initialization (InitialState and InitialOutput are identical)"
      annotation (Dialog(tab="Initialization", group="Parameters"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pCon_start=
        Medium_con.p_default "Start value of pressure"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.Temperature TCon_start=Medium_con.T_default
      "Start value of temperature"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.MassFraction XCon_start[Medium_con.nX]=
       Medium_con.X_default "Start value of mass fractions m_i/m"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pEva_start=
        Medium_eva.p_default "Start value of pressure"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Modelica.Media.Interfaces.Types.Temperature TEva_start=Medium_eva.T_default
      "Start value of temperature"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Modelica.Media.Interfaces.Types.MassFraction XEva_start[Medium_eva.nX]=
       Medium_eva.X_default "Start value of mass fractions m_i/m"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Real x_start[nthOrder]=zeros(nthOrder)
      "Initial or guess values of states"
      annotation (Dialog(tab="Initialization", group="Refrigerant inertia", enable=use_refIne));
    parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Initialization", group="Refrigerant inertia",enable=initType ==
            Init.InitialOutput and use_refIne));
  //Dynamics
    parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of mass balance: dynamic (3 initialization options) or steady state"
      annotation (Dialog(tab="Dynamics", group="Equation"));
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation (Dialog(tab="Dynamics", group="Equation"));
  //Advanced
    parameter Boolean show_TPort=false
      "= true, if actual temperature at port is computed"
      annotation(Dialog(tab="Advanced",group="Diagnostics"));
    parameter Boolean from_dp=false
      "= true, use m_flow = f(dp) else dp = f(m_flow)"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    parameter Boolean homotopyInitialization=false "= true, use homotopy method"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    parameter Boolean linearized=false
      "= true, use linear relation between m_flow and dp for any flow rate"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    Boolean mode = true                    "True: Heating; False: Cooling";
                        /*sigBusHP.mode */

    AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity con(
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*abs(mFlow_conNominal),
      final show_T=show_TPort,
      final deltaM=deltaM_con,
      final T_start=TCon_start,
      final p_start=pCon_start,
      final use_cap=use_conCap,
      final X_start=XCon_start,
      final from_dp=from_dp,
      final homotopyInitialization=homotopyInitialization,
      final massDynamics=massDynamics,
      final energyDynamics=energyDynamics,
      final is_con=true,
      final V=VCon*scalingFactor,
      final C=CCon*scalingFactor,
      final GOut=GConOut*scalingFactor,
      final m_flow_nominal=mFlow_conNominal*scalingFactor,
      final dp_nominal=dpCon_nominal*scalingFactor,
      final GInn=GConIns*scalingFactor) "Heat exchanger model for the condenser"
      annotation (Placement(transformation(extent={{-16,78},{16,110}})));
    AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity eva(
      redeclare final package Medium = Medium_eva,
      final deltaM=deltaM_eva,
      final use_cap=use_evaCap,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*abs(mFlow_evaNominal),
      final show_T=show_TPort,
      final T_start=TEva_start,
      final p_start=pEva_start,
      final X_start=XEva_start,
      final from_dp=from_dp,
      final homotopyInitialization=homotopyInitialization,
      final massDynamics=massDynamics,
      final energyDynamics=energyDynamics,
      final is_con=false,
      final V=VEva*scalingFactor,
      final C=CEva*scalingFactor,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor,
      final dp_nominal=dpEva_nominal*scalingFactor,
      final GOut=GEvaOut*scalingFactor,
      GInn=GEvaIns*scalingFactor) "Heat exchanger model for the evaporator"
      annotation (Placement(transformation(extent={{16,-70},{-16,-102}})));
    Modelica.Blocks.Continuous.CriticalDamping heatFlowIneEva(
      final initType=initType,
      final normalized=true,
      final n=nthOrder,
      final f=refIneFre_constant,
      final x_start=x_start,
      final y_start=yRefIne_start) if
                                     use_refIne
      "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
      annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={-14,-52})));
    Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetCon if
                                                                   not use_refIne
      "Use default nSet value" annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={16,58})));
    Modelica.Blocks.Continuous.CriticalDamping heatFlowIneCon(
      final initType=initType,
      final normalized=true,
      final n=nthOrder,
      final f=refIneFre_constant,
      final x_start=x_start,
      final y_start=yRefIne_start) if
                                     use_refIne
      "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
      annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={-16,58})));
    Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetEva if
                                                                   not use_refIne
      "Use default nSet value" annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={16,-52})));
    Modelica.Blocks.Interfaces.RealInput iceFac_in
      "Input signal for icing factor" annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={-76,-136})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutEva if
      use_evaCap "Foreces heat losses according to ambient temperature"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={68,-108})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutCon if
      use_conCap "Foreces heat losses according to ambient temperature"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={68,110})));

    Modelica.Blocks.Interfaces.RealInput nSet
      "Input signal speed for compressor relative between 0 and 1" annotation (Placement(
          transformation(extent={{-132,4},{-100,36}})));
    Controls.Interfaces.HeatPumpControlBusNEW sigBusHP
      annotation (Placement(transformation(extent={{-120,-60},{-90,-26}}),
          iconTransformation(extent={{-108,-52},{-90,-26}})));
    InnerCycleNEW innerCycle(
      redeclare final model PerDataHea = PerDataHea,
      redeclare final model PerDataChi = PerDataChi,
      final use_revHP=use_revHP,
      final scalingFactor=scalingFactor) annotation (Placement(transformation(
          extent={{-27,-26},{27,26}},
          rotation=90,
          origin={0,-1})));
    Modelica.Blocks.Interfaces.RealInput T_amb_eva(final unit="K", final
        displayUnit="degC")
      "Ambient temperature on the evaporator side"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=0,
          origin={110,-100})));
    Modelica.Blocks.Interfaces.RealInput T_amb_con(final unit="K", final
        displayUnit="degC")
      "Ambient temperature on the condenser side"
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=180,
          origin={110,100})));

    Modelica.Blocks.Interfaces.BooleanInput modeSet if use_revHP==1
      "Set value of HP mode"
      annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));
    Modelica.Blocks.Sources.BooleanExpression opType(y=if use_revHP==2
           then true else false) if not use_revHP==1
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));

    Sensors.TemperatureTwoPort senT_a2(
      redeclare final package Medium = Medium_eva,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*mFlow_evaNominal,
      final initType=initType,
      final T_start=TEva_start,
      final transferHeat=transferHeat,
      final TAmb=TAmbEva_nominal,
      final tauHeaTra=tauHeaTraEva,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor)
      "Temperature at sink inlet" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={38,-86})));
    Sensors.MassFlowRate mFlow_eva(redeclare final package Medium = Medium_eva,
        final allowFlowReversal=allowFlowReversalEva)
      "Mass flow sensor at the evaporator" annotation (Placement(transformation(
          origin={74,-60},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    Sensors.TemperatureTwoPort senT_b1(
      final initType=initType,
      final transferHeat=transferHeat,
      final TAmb=TAmbCon_nominal,
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*mFlow_conNominal,
      final T_start=TCon_start,
      final tau=tauSenT,
      final tauHeaTra=tauHeaTraCon,
      final m_flow_nominal=mFlow_conNominal*scalingFactor)
      "Temperature at sink outlet" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={38,92})));
    Sensors.TemperatureTwoPort senT_a1(
      final initType=initType,
      final transferHeat=transferHeat,
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*mFlow_conNominal,
      final T_start=TCon_start,
      final TAmb=TAmbCon_nominal,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_conNominal*scalingFactor,
      final tauHeaTra=tauHeaTraCon)
      "Temperature at sink inlet" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={-34,90})));
    Sensors.MassFlowRate mFlow_con(final allowFlowReversal=allowFlowReversalEva,
        redeclare final package Medium = Medium_con)
      "Mass flow sensor at the evaporator" annotation (Placement(transformation(
          origin={-76,60},
          extent={{-10,10},{10,-10}},
          rotation=0)));

    Sensors.TemperatureTwoPort senT_b2(
      redeclare final package Medium = Medium_eva,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*mFlow_evaNominal,
      final initType=initType,
      final T_start=TEva_start,
      final transferHeat=transferHeat,
      final TAmb=TAmbEva_nominal,
      final tauHeaTra=tauHeaTraEva,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor)
      "Temperature at sink outlet" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-52,-86})));

  equation
    if use_revHP==1 then
    connect(modeSet, sigBusHP.mode) annotation (Line(points={{-116,-20},{-76,-20},
            {-76,-42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    else
    connect(opType.y, sigBusHP.mode) annotation (Line(points={{-99,0},{-76,0},{-76,
            -42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));

    end if;

    //Connect fluid ports to condenser and evaporator

    if mode then
    //Connect fluid ports for heating
    connect(port_a2, mFlow_eva.port_a) annotation (Line(points={{100,-60},{84,-60}}, color={0,127,255}));
    connect(port_a1, mFlow_con.port_a) annotation (Line(points={{-100,60},{-86,60}}, color={0,127,255}));
    connect(port_b2, senT_b2.port_b) annotation (Line(points={{-100,-60},{-70,-60},
              {-70,-86},{-62,-86}},
                         color={0,127,255}));
    connect(port_b1, senT_b1.port_b) annotation (Line(points={{100,60},{72,60},{72,
            92},{48,92}}, color={0,127,255}));

    else
    //Connect fluid ports for cooling
    end if;

    connect(innerCycle.Pel, sigBusHP.Pel) annotation (Line(points={{28.73,-0.865},
            {38,-0.865},{38,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}},
                                                    color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(nSet, sigBusHP.N) annotation (Line(points={{-116,20},{-76,20},{-76,-42.915},
            {-104.925,-42.915}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(innerCycle.QEva, realPassThroughnSetEva.u) annotation (Line(
        points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{16,-38},{16,-44.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QEva, heatFlowIneEva.u) annotation (Line(
        points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{-14,-38},{-14,-44.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QCon, heatFlowIneCon.u) annotation (Line(
        points={{1.77636e-15,28.7},{1.77636e-15,30},{0,30},{0,40},{-16,40},{-16,50.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QCon, realPassThroughnSetCon.u) annotation (Line(
        points={{1.77636e-15,28.7},{0,28.7},{0,40},{16,40},{16,50.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(sigBusHP, innerCycle.sigBusHP) annotation (Line(
        points={{-105,-43},{-54,-43},{-54,-0.73},{-26.78,-0.73}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(iceFac_in, sigBusHP.iceFac) annotation (Line(points={{-76,-136},{-76,-42.915},
            {-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(T_amb_con, varTempOutCon.T) annotation (Line(
        points={{110,100},{84,100},{84,110},{77.6,110}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(varTempOutCon.port, con.port_out) annotation (Line(
        points={{60,110},{0,110}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(T_amb_eva, varTempOutEva.T) annotation (Line(
        points={{110,-100},{94,-100},{94,-108},{77.6,-108}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(eva.port_out, varTempOutEva.port) annotation (Line(
        points={{0,-102},{0,-108},{60,-108}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(realPassThroughnSetCon.y, con.QFlow_in) annotation (Line(
        points={{16,64.6},{16,77.04},{0,77.04}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(heatFlowIneCon.y, con.QFlow_in) annotation (Line(
        points={{-16,64.6},{-16,77.04},{0,77.04}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realPassThroughnSetEva.y, eva.QFlow_in) annotation (Line(points={{16,-58.6},
            {16,-69.04},{0,-69.04}}, color={0,0,127}));
    connect(heatFlowIneEva.y, eva.QFlow_in) annotation (Line(points={{-14,-58.6},{
            -14,-69.04},{0,-69.04}}, color={0,0,127}));
    connect(senT_a2.port_b, eva.port_a)
      annotation (Line(points={{28,-86},{16,-86}}, color={0,127,255}));
    connect(senT_b2.port_a, eva.port_b)
      annotation (Line(points={{-42,-86},{-16,-86}}, color={0,127,255}));
    connect(mFlow_eva.port_b, senT_a2.port_a) annotation (Line(points={{64,-60},{58,
            -60},{58,-86},{48,-86}}, color={0,127,255}));
    connect(con.port_a, senT_a1.port_b)
      annotation (Line(points={{-16,94},{-20,94},{-20,90},{-24,90}},
                                                   color={0,127,255}));
    connect(senT_a1.port_a, mFlow_con.port_b) annotation (Line(points={{-44,90},{-56,
            90},{-56,60},{-66,60}},     color={0,127,255}));
    connect(con.port_b, senT_b1.port_a)
      annotation (Line(points={{16,94},{22,94},{22,92},{28,92}},
                                                 color={0,127,255}));
    connect(senT_b2.T, sigBusHP.T_ret_ev) annotation (Line(points={{-52,-75},{-52,
            -42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_a2.T, sigBusHP.T_flow_ev) annotation (Line(points={{38,-75},{38,-36},
            {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mFlow_eva.m_flow, sigBusHP.m_flow_ev) annotation (Line(points={{74,-49},
            {74,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_b1.T, sigBusHP.T_ret_co) annotation (Line(points={{38,81},{38,-36},
            {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_a1.T, sigBusHP.T_flow_co) annotation (Line(points={{-34,79},{-34,
            40},{-76,40},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mFlow_con.m_flow, sigBusHP.m_flow_co) annotation (Line(points={{-76,
            49},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
          Rectangle(
            extent={{-16,83},{16,-83}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,-64},
            rotation=90),
          Rectangle(
            extent={{-17,83},{17,-83}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,61},
            rotation=90),
          Rectangle(
            extent={{-16,83},{16,-83}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,-64},
            rotation=90,
            visible=not (use_revHP == 3)),
          Rectangle(
            extent={{-17,83},{17,-83}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,61},
            rotation=90,
            visible=not (use_revHP == 3)),
          Text(
            extent={{-76,6},{74,-36}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="%name
"),       Line(
            points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-3,-60},
            rotation=-90),
          Line(
            points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-5,56},
            rotation=-90),
          Rectangle(
            extent={{-82,42},{84,-46}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-88,60},{88,60}}, color={28,108,200}),
          Line(points={{-88,-60},{88,-60}}, color={28,108,200}),
      Line(
      origin={-75.5,-80.333},
      points={{43.5,8.3333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,-11.667},{27.5,-21.667},{13.5,-23.667},
                {11.5,-31.667}},
        smooth=Smooth.Bezier,
        visible=use_evaCap),
          Polygon(
            points={{-70,-122},{-68,-108},{-58,-114},{-70,-122}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_evaCap),
      Line( origin={40.5,93.667},
            points={{39.5,6.333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,
                -11.667},{27.5,-21.667},{13.5,-23.667},{11.5,-27.667}},
            smooth=Smooth.Bezier,
            visible=use_conCap),
          Polygon(
            points={{86,110},{84,96},{74,102},{86,110}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_conCap),
          Line(
            points={{-42,72},{34,72}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5),
          Line(
            points={{-38,0},{38,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5,
            origin={0,-74},
            rotation=180)}),                Diagram(coordinateSystem(extent={{-100,
              -120},{100,120}})),
      Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",   info="<html>
<p>This generic grey-box heat pump model uses empirical data to model the refrigerant cycle. The modelling of system inertias and heat losses allow the simulation of transient states. </p>
<p>Resulting in the choosen model structure, several configurations are possible:</p>
<ol>
<li>Compressor type: on/off or inverter controlled</li>
<li>Reversible heat pump / only heating</li>
<li>Source/Sink: Any combination of mediums is possible</li>
<li>Generik: Losses and inertias can be switched on or off.</li>
</ol>
<h4>Concept</h4>
<p>Using a signal bus as a connector, this heat pump model can be easily combined with the new <a href=\"modelica://AixLib.Systems.HeatPumpSystems.HeatPumpSystem\">HeatPumpSystem</a> or several control or security blocks from <a href=\"modelica://AixLib.Controls.HeatPump\">AixLib.Controls.HeatPump</a>. The relevant data is aggregated. In order to control both chillers and heat pumps, both flow and return temperature are aggregated. The mode signal chooses the type of the heat pump. As a result, this model can also be used as a chiller:</p>
<ul>
<li>mode = true: Heating</li>
<li>mode = false: Chilling</li>
</ul>
<p>To model both on/off and inverter controlled heat pumps, the compressor speed is normalizd to a relative value between 0 and 1.</p>
<p>Possible icing of the evaporator is modelled with an input value between 0 and 1.</p>
<p>The model structure is as follows. To understand each submodel, please have a look at the corresponding model information:</p>
<ol>
<li><a href=\"AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle\">InnerCycle</a> (Black Box): Here, the user can use between several input models or just easily create his own, modular black box model. Please look at the model description for more info.</li>
<li>Inertia: A n-order element is used to model system inertias (mass and thermal) of components inside the refrigerant cycle (compressor, pipes, expansion valve)</li>
<li><a href=\"modelica://AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity\">HeatExchanger</a>: This new model also enable modelling of thermal interias and heat losses in a heat exchanger. Please look at the model description for more info.</li>
</ol>
<h4>Assumptions</h4>
<p>Several assumptions where made in order to model the heat pump. For a detailed description see the corresponding model. </p>
<ol>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">Performance data 2D</a>: In order to model inverter controlled heat pumps, the compressor speed is scaled <b>linearly</b></li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">Performance data 2D</a>: Reduced evaporator power as a result of icing. The icing factor is multiplied with the evaporator power.</li>
<li><b>Inertia</b>: The default value of the n-th order element is set to 3. This follows comparisons with experimental data. Previous heat pump models are using n = 1 as a default. However, it was pointed out that a higher order element fits a real heat pump better in</li>
<li><b>Scaling factor</b>: A scaling facor is implemented for scaling of the heat pump power and capacity. The factor scales the parameters V, m_flow_nominal, C, GIns, GOut and dp_nominal. As a result, the heat pump can supply more heat with the COP staying nearly constant. However, one has to make sure that the supplied pressure difference or mass flow is also scaled with this factor, as the nominal values do not increase said mass flow.</li>
</ol>
<h4>Known Limitations</h4>
<ul>
<li>The n-th order element has a big influence on computational time. Reducing the order or disabling it completly will decrease computational time. </li>
<li>Reversing the mode: A normal 4-way-exchange valve suffers from heat losses and irreversibilities due to switching from one mode to another. Theses losses are not taken into account.</li>
</ul>
</html>"));
  end HeatPumpNEW;

  model ReversibleThermalMachine_HeatPump1605
    "Grey-box model for reversible heat pumps using a black-box to simulate the refrigeration cycle"
    extends AixLib.Fluid.HeatPumps.OldModels.PartialReversibleThermalMachine(
    redeclare final model PartialInnerCycle = BaseClasses.InnerCycle_HeatPump,
        use_rev=true);

  equation

    annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
          Rectangle(
            extent={{-16,83},{16,-83}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,-64},
            rotation=90),
          Rectangle(
            extent={{-17,83},{17,-83}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,61},
            rotation=90),
          Text(
            extent={{-76,6},{74,-36}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="%name"),
          Line(
            points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-3,-60},
            rotation=-90),
          Line(
            points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-5,56},
            rotation=-90),
          Rectangle(
            extent={{-82,42},{84,-46}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-88,60},{88,60}}, color={28,108,200}),
          Line(points={{-88,-60},{88,-60}}, color={28,108,200}),
      Line(
      origin={-75.5,-80.333},
      points={{43.5,8.3333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,-11.667},{27.5,-21.667},{13.5,-23.667},
                {11.5,-31.667}},
        smooth=Smooth.Bezier,
        visible=use_evaCap),
          Polygon(
            points={{-70,-122},{-68,-108},{-58,-114},{-70,-122}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_evaCap),
      Line( origin={40.5,93.667},
            points={{39.5,6.333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,
                -11.667},{27.5,-21.667},{13.5,-23.667},{11.5,-27.667}},
            smooth=Smooth.Bezier,
            visible=use_conCap),
          Polygon(
            points={{86,110},{84,96},{74,102},{86,110}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_conCap),
          Line(
            points={{-42,72},{34,72}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5),
          Line(
            points={{-38,0},{38,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5,
            origin={0,-74},
            rotation=180)}),                Diagram(coordinateSystem(extent={{-100,
              -120},{100,120}})),
      Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",   info="<html>
<p>This generic grey-box heat pump model uses empirical data to model the refrigerant cycle. The modelling of system inertias and heat losses allow the simulation of transient states. </p>
<p>Resulting in the choosen model structure, several configurations are possible:</p>
<ol>
<li>Compressor type: on/off or inverter controlled</li>
<li>Reversible heat pump / only heating</li>
<li>Source/Sink: Any combination of mediums is possible</li>
<li>Generik: Losses and inertias can be switched on or off.</li>
</ol>
<h4>Concept</h4>
<p>Using a signal bus as a connector, this heat pump model can be easily combined with the new <a href=\"modelica://AixLib.Systems.HeatPumpSystems.HeatPumpSystem\">HeatPumpSystem</a> or several control or security blocks from <a href=\"modelica://AixLib.Controls.HeatPump\">AixLib.Controls.HeatPump</a>. The relevant data is aggregated. In order to control both chillers and heat pumps, both flow and return temperature are aggregated. The mode signal chooses the type of the heat pump. As a result, this model can also be used as a chiller:</p>
<ul>
<li>mode = true: Heating</li>
<li>mode = false: Chilling</li>
</ul>
<p>To model both on/off and inverter controlled heat pumps, the compressor speed is normalizd to a relative value between 0 and 1.</p>
<p>Possible icing of the evaporator is modelled with an input value between 0 and 1.</p>
<p>The model structure is as follows. To understand each submodel, please have a look at the corresponding model information:</p>
<ol>
<li><a href=\"AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle\">InnerCycle</a> (Black Box): Here, the user can use between several input models or just easily create his own, modular black box model. Please look at the model description for more info.</li>
<li>Inertia: A n-order element is used to model system inertias (mass and thermal) of components inside the refrigerant cycle (compressor, pipes, expansion valve)</li>
<li><a href=\"modelica://AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity\">HeatExchanger</a>: This new model also enable modelling of thermal interias and heat losses in a heat exchanger. Please look at the model description for more info.</li>
</ol>
<h4>Assumptions</h4>
<p>Several assumptions where made in order to model the heat pump. For a detailed description see the corresponding model. </p>
<ol>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">Performance data 2D</a>: In order to model inverter controlled heat pumps, the compressor speed is scaled <b>linearly</b></li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">Performance data 2D</a>: Reduced evaporator power as a result of icing. The icing factor is multiplied with the evaporator power.</li>
<li><b>Inertia</b>: The default value of the n-th order element is set to 3. This follows comparisons with experimental data. Previous heat pump models are using n = 1 as a default. However, it was pointed out that a higher order element fits a real heat pump better in</li>
<li><b>Scaling factor</b>: A scaling facor is implemented for scaling of the heat pump power and capacity. The factor scales the parameters V, m_flow_nominal, C, GIns, GOut and dp_nominal. As a result, the heat pump can supply more heat with the COP staying nearly constant. However, one has to make sure that the supplied pressure difference or mass flow is also scaled with this factor, as the nominal values do not increase said mass flow.</li>
</ol>
<h4>Known Limitations</h4>
<ul>
<li>The n-th order element has a big influence on computational time. Reducing the order or disabling it completly will decrease computational time. </li>
<li>Reversing the mode: A normal 4-way-exchange valve suffers from heat losses and irreversibilities due to switching from one mode to another. Theses losses are not taken into account.</li>
</ul>
</html>"));
  end ReversibleThermalMachine_HeatPump1605;

  model ReversibleThermalMachine_HeatPump
    "Example for the reversible heat pump model."
   extends Modelica.Icons.Example;
   import AixLib;
    replaceable package Medium_sin = AixLib.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    replaceable package Medium_sou = AixLib.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    AixLib.Fluid.Sources.MassFlowSource_T                sourceSideMassFlowSource(
      use_T_in=true,
      m_flow=1,
      nPorts=1,
      redeclare package Medium = Medium_sou,
      T=275.15) "Ideal mass flow source at the inlet of the source side"
                annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));

    AixLib.Fluid.Sources.FixedBoundary                sourceSideFixedBoundary(
                                                                           nPorts=
         1, redeclare package Medium = Medium_sou)
            "Fixed boundary at the outlet of the source side"
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=0,
          origin={-86,40})));
    Modelica.Blocks.Sources.Ramp TsuSourceRamp(
      duration=1000,
      startTime=1000,
      height=25,
      offset=278)
      "Ramp signal for the temperature input of the source side's ideal mass flow source"
      annotation (Placement(transformation(extent={{-94,-84},{-74,-64}})));
    Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={2,-76})));
    AixLib.Fluid.HeatPumps.OldModels.ReversibleThermalMachine_HeatPump1605
      heatPump(
      refIneFre_constant=1,
      scalingFactor=1,
      VEva=0.04,
      CEva=100,
      GEvaOut=5,
      CCon=100,
      GConOut=5,
      dpEva_nominal=0,
      dpCon_nominal=0,
      mFlow_conNominal=0.5,
      mFlow_evaNominal=0.5,
      VCon=0.4,
      use_conCap=false,
      use_evaCap=false,
      redeclare package Medium_con = Medium_sin,
      redeclare package Medium_eva = Medium_sou,
      use_rev=true,
      redeclare model PerDataMain =
          AixLib.Fluid.HeatPumps.BaseClasses.ReversibleHeatPump_PerformanceData.LookUpTable2D
          (dataTable=AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
      redeclare model PerDataRev =
          AixLib.Fluid.HeatPumps.BaseClasses.ReversibleHeatPump_PerformanceData.LookUpTable2D
          (smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
            dataTable=AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
      use_refIne=false,
      TAmbCon_nominal=288.15,
      TAmbEva_nominal=273.15,
      TCon_start=303.15) annotation (Placement(transformation(
          extent={{-24,-29},{24,29}},
          rotation=270,
          origin={2,-21})));

    Modelica.Blocks.Sources.BooleanStep     booleanStep(startTime=10000,
        startValue=true)
      annotation (Placement(transformation(extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-10,82})));

    AixLib.Fluid.Sensors.TemperatureTwoPort senTAct(
      final m_flow_nominal=heatPump.mFlow_conNominal,
      final tau=1,
      final initType=Modelica.Blocks.Types.Init.InitialState,
      final tauHeaTra=1200,
      final allowFlowReversal=heatPump.allowFlowReversalCon,
      final transferHeat=false,
      redeclare final package Medium = Medium_sin,
      final T_start=303.15,
      final TAmb=291.15) "Temperature at sink inlet" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={54,-64})));
    Modelica.Blocks.Logical.Hysteresis hys(
      pre_y_start=true,
      uLow=273.15 + 35,
      uHigh=273.15 + 40)
      annotation (Placement(transformation(extent={{64,50},{44,70}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{24,28},{4,48}})));
    Modelica.Blocks.Sources.Sine sine(
      freqHz=1/3600,
      amplitude=3000,
      offset=3000)
      annotation (Placement(transformation(extent={{76,26},{84,34}})));
    AixLib.Fluid.Movers.SpeedControlled_Nrpm
                                      pumSou(
      redeclare final AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
      final allowFlowReversal=true,
      final addPowerToMedium=false,
      redeclare final package Medium = Medium_sin)
      "Fan or pump at source side of HP" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={50,12})));

    AixLib.Fluid.MixingVolumes.MixingVolume Room(
      nPorts=2,
      final use_C_flow=false,
      final m_flow_nominal=heatPump.mFlow_conNominal,
      final V=5,
      final allowFlowReversal=true,
      redeclare package Medium = Medium_sin) "Volume of Condenser" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={86,-20})));

    Modelica.Blocks.Sources.Constant nIn(k=100) annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={50,34})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon
      "Heat flow rate of the condenser" annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=270,
          origin={94,6})));
    Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={96,22})));
    Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
      annotation (Placement(transformation(extent={{-4,-4},{4,4}},
          origin={32,62},
          rotation=180)));
    AixLib.Fluid.Sources.FixedBoundary sinkSideFixedBoundary(      nPorts=1,
        redeclare package Medium = Medium_sin)
      "Fixed boundary at the outlet of the sink side" annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={88,-64})));
    Modelica.Blocks.Sources.Constant iceFac(final k=1) annotation (Placement(
          transformation(
          extent={{5,-5},{-5,5}},
          rotation=180,
          origin={-71,-3})));
  equation

    connect(TsuSourceRamp.y,sourceSideMassFlowSource. T_in) annotation (Line(
        points={{-73,-74},{-68,-74},{-68,-66},{-56,-66}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{2,-65},
            {4,-65},{4,-47.4},{26.1667,-47.4}}, color={0,0,127}));
    connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{2,-65},
            {2,-47.4},{-22.1667,-47.4}}, color={0,0,127}));
    connect(sourceSideMassFlowSource.ports[1], heatPump.port_a2) annotation (Line(
          points={{-34,-70},{-24,-70},{-24,-45},{-12.5,-45}}, color={0,127,255}));
    connect(nIn.y, pumSou.Nrpm)
      annotation (Line(points={{50,29.6},{50,24}}, color={0,0,127}));
    connect(Room.heatPort, heatFlowRateCon.port)
      annotation (Line(points={{86,-10},{86,0},{94,0}}, color={191,0,0}));
    connect(sine.y, gain.u) annotation (Line(points={{84.4,30},{92,30},{92,26.8},
            {96,26.8}}, color={0,0,127}));
    connect(heatFlowRateCon.Q_flow, gain.y) annotation (Line(points={{94,12},{98,
            12},{98,17.6},{96,17.6}}, color={0,0,127}));
    connect(heatPump.port_b2, sourceSideFixedBoundary.ports[1]) annotation (Line(
          points={{-12.5,3},{-62,3},{-62,40},{-76,40}}, color={0,127,255}));
    connect(heatPump.port_b1, senTAct.port_a) annotation (Line(points={{16.5,-45},
            {30,-45},{30,-64},{44,-64}}, color={0,127,255}));
    connect(Room.ports[1], pumSou.port_a) annotation (Line(points={{76,-18},{76,4},
            {60,4},{60,12}}, color={0,127,255}));
    connect(pumSou.port_b, heatPump.port_a1) annotation (Line(points={{40,12},{28,
            12},{28,3},{16.5,3}}, color={0,127,255}));
    connect(senTAct.T, hys.u) annotation (Line(points={{54,-53},{58,-53},{58,-8},
            {68,-8},{68,48},{74,48},{74,60},{66,60}}, color={0,0,127}));
    connect(hys.y, not2.u) annotation (Line(points={{43,60},{44,60},{44,62},{36.8,
            62}}, color={255,0,255}));
    connect(booleanToReal.u, not2.y) annotation (Line(points={{26,38},{26,62},{
            27.6,62}},      color={255,0,255}));
    connect(senTAct.port_b, sinkSideFixedBoundary.ports[1]) annotation (Line(
          points={{64,-64},{72,-64},{72,-64},{78,-64}}, color={0,127,255}));
    connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{64,-64},{66,
            -64},{66,-22},{76,-22}}, color={0,127,255}));
    connect(booleanToReal.y, heatPump.nSet) annotation (Line(points={{3,38},{4,38},
            {4,6.84},{6.83333,6.84}}, color={0,0,127}));
    connect(booleanStep.y, heatPump.modeSet) annotation (Line(points={{-10,77.6},{
            -4,77.6},{-4,6.84},{-2.83333,6.84}}, color={255,0,255}));
    connect(iceFac.y, heatPump.iceFac_in) annotation (Line(points={{-65.5,-3},{
            -47,-3},{-47,-2.76},{-30.8667,-2.76}},
                                               color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),
      experiment(StopTime=20000),
      __Dymola_experimentSetupOutput,
      Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Simple test set-up for the HeatPumpDetailed model. The heat pump is turned on and off while the source temperature increases linearly. Outputs are the electric power consumption of the heat pump and the supply temperature. </p>
<p>Besides using the default simple table data, the user should also test tabulated data from <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a> or polynomial functions.</p>
</html>",
        revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"),
      __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos" "Simulate and plot"),
      Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
  end ReversibleThermalMachine_HeatPump;

  model HeatPumpNEWReversibleHeatPumpAndChiller
    "Example for the detailed heat pump model in order to compare to simple one."
   extends Modelica.Icons.Example;
   import AixLib;
    replaceable package Medium_sin = AixLib.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    replaceable package Medium_sou = AixLib.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    AixLib.Fluid.Sources.MassFlowSource_T                sourceSideMassFlowSource(
      use_T_in=true,
      m_flow=1,
      nPorts=1,
      redeclare package Medium = Medium_sou,
      T=275.15) "Ideal mass flow source at the inlet of the source side"
                annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));

    AixLib.Fluid.Sources.FixedBoundary                sourceSideFixedBoundary(
                                                                           nPorts=
         1, redeclare package Medium = Medium_sou)
            "Fixed boundary at the outlet of the source side"
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=0,
          origin={-86,40})));
    Modelica.Blocks.Sources.Ramp TsuSourceRamp(
      duration=1000,
      startTime=1000,
      height=25,
      offset=278)
      "Ramp signal for the temperature input of the source side's ideal mass flow source"
      annotation (Placement(transformation(extent={{-94,-84},{-74,-64}})));
    Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={2,-76})));
    AixLib.Fluid.HeatPumps.OldModels.HeatPumpNEW heatPump(
      refIneFre_constant=1,
      scalingFactor=1,
      VEva=0.04,
      CEva=100,
      GEvaOut=5,
      CCon=100,
      GConOut=5,
      dpEva_nominal=0,
      dpCon_nominal=0,
      mFlow_conNominal=0.5,
      mFlow_evaNominal=0.5,
      VCon=0.4,
      use_conCap=false,
      use_evaCap=false,
      redeclare package Medium_con = Medium_sin,
      redeclare package Medium_eva = Medium_sou,
      use_refIne=false,
      redeclare model PerDataHea =
          AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.LookUpTable2DNEW
          (dataTable=AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
      redeclare model PerDataChi =
          AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.LookUpTable2DNEW
          (smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
            dataTable=AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
      use_revHP=2,
      TAmbCon_nominal=288.15,
      TAmbEva_nominal=273.15,
      TCon_start=303.15) annotation (Placement(transformation(
          extent={{-24,-29},{24,29}},
          rotation=270,
          origin={2,-21})));

    Modelica.Blocks.Sources.BooleanStep     booleanStep(startTime=10000,
        startValue=true)
      annotation (Placement(transformation(extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-10,82})));

    AixLib.Fluid.Sensors.TemperatureTwoPort
                               senTAct(
      final m_flow_nominal=heatPump.mFlow_conNominal,
      final tau=1,
      final initType=Modelica.Blocks.Types.Init.InitialState,
      final tauHeaTra=1200,
      final allowFlowReversal=heatPump.allowFlowReversalCon,
      final transferHeat=false,
      redeclare final package Medium = Medium_sin,
      final T_start=303.15,
      final TAmb=291.15) "Temperature at sink inlet"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={54,-64})));
    Modelica.Blocks.Logical.Hysteresis hys(
      pre_y_start=true,
      uLow=273.15 + 35,
      uHigh=273.15 + 40)
      annotation (Placement(transformation(extent={{64,50},{44,70}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{24,28},{4,48}})));
    Modelica.Blocks.Sources.Sine sine(
      freqHz=1/3600,
      amplitude=3000,
      offset=3000)
      annotation (Placement(transformation(extent={{76,26},{84,34}})));
    AixLib.Fluid.Movers.SpeedControlled_Nrpm
                                      pumSou(
      redeclare final AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
      final allowFlowReversal=true,
      final addPowerToMedium=false,
      redeclare final package Medium = Medium_sin)
      "Fan or pump at source side of HP" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={50,12})));

    AixLib.Fluid.MixingVolumes.MixingVolume Room(
      nPorts=2,
      final use_C_flow=false,
      final m_flow_nominal=heatPump.mFlow_conNominal,
      final V=5,
      final allowFlowReversal=true,
      redeclare package Medium = Medium_sin)
                                    "Volume of Condenser" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={86,-20})));

    Modelica.Blocks.Sources.Constant nIn(k=100) annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={50,34})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon
      "Heat flow rate of the condenser" annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=270,
          origin={94,6})));
    Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={96,22})));
    Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
      annotation (Placement(transformation(extent={{-4,-4},{4,4}},
          origin={32,62},
          rotation=180)));
    AixLib.Fluid.Sources.FixedBoundary sinkSideFixedBoundary(      nPorts=1,
        redeclare package Medium = Medium_sin)
      "Fixed boundary at the outlet of the sink side" annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={88,-64})));
    Modelica.Blocks.Sources.Constant iceFac(final k=1) annotation (Placement(
          transformation(
          extent={{5,-5},{-5,5}},
          rotation=180,
          origin={-71,-3})));
  equation

    connect(TsuSourceRamp.y,sourceSideMassFlowSource. T_in) annotation (Line(
        points={{-73,-74},{-68,-74},{-68,-66},{-56,-66}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{2,-65},
            {4,-65},{4,-47.4},{26.1667,-47.4}},   color={0,0,127}));
    connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{2,-65},
            {2,-47.4},{-22.1667,-47.4}}, color={0,0,127}));
    connect(sourceSideMassFlowSource.ports[1], heatPump.port_a2) annotation (Line(
          points={{-34,-70},{-24,-70},{-24,-45},{-12.5,-45}}, color={0,127,255}));
    connect(nIn.y, pumSou.Nrpm)
      annotation (Line(points={{50,29.6},{50,24}}, color={0,0,127}));
    connect(Room.heatPort, heatFlowRateCon.port)
      annotation (Line(points={{86,-10},{86,0},{94,0}}, color={191,0,0}));
    connect(sine.y, gain.u) annotation (Line(points={{84.4,30},{92,30},{92,26.8},
            {96,26.8}}, color={0,0,127}));
    connect(heatFlowRateCon.Q_flow, gain.y) annotation (Line(points={{94,12},{98,
            12},{98,17.6},{96,17.6}}, color={0,0,127}));
    connect(heatPump.port_b2, sourceSideFixedBoundary.ports[1])
      annotation (Line(points={{-12.5,3},{-62,3},{-62,40},{-76,40}},
                                                            color={0,127,255}));
    connect(heatPump.port_b1, senTAct.port_a) annotation (Line(points={{16.5,-45},
            {30,-45},{30,-64},{44,-64}}, color={0,127,255}));
    connect(Room.ports[1], pumSou.port_a) annotation (Line(points={{76,-18},{76,4},
            {60,4},{60,12}}, color={0,127,255}));
    connect(pumSou.port_b, heatPump.port_a1) annotation (Line(points={{40,12},{28,
            12},{28,3},{16.5,3}}, color={0,127,255}));
    connect(senTAct.T, hys.u) annotation (Line(points={{54,-53},{58,-53},{58,-8},
            {68,-8},{68,48},{74,48},{74,60},{66,60}}, color={0,0,127}));
    connect(hys.y, not2.u) annotation (Line(points={{43,60},{44,60},{44,62},{36.8,
            62}}, color={255,0,255}));
    connect(booleanToReal.u, not2.y) annotation (Line(points={{26,38},{26,62},{
            27.6,62}},      color={255,0,255}));
    connect(senTAct.port_b, sinkSideFixedBoundary.ports[1]) annotation (Line(
          points={{64,-64},{72,-64},{72,-64},{78,-64}}, color={0,127,255}));
    connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{64,-64},{66,
            -64},{66,-22},{76,-22}}, color={0,127,255}));
    connect(booleanToReal.y, heatPump.nSet) annotation (Line(points={{3,38},{4,38},
            {4,6.84},{6.83333,6.84}},       color={0,0,127}));
    connect(booleanStep.y, heatPump.modeSet) annotation (Line(points={{-10,77.6},
            {-4,77.6},{-4,6.84},{-2.83333,6.84}}, color={255,0,255}));
    connect(iceFac.y, heatPump.iceFac_in) annotation (Line(points={{-65.5,-3},{
            -47,-3},{-47,-2.76},{-30.8667,-2.76}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),
      experiment(StopTime=20000),
      __Dymola_experimentSetupOutput,
      Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Simple test set-up for the HeatPumpDetailed model. The heat pump is turned on and off while the source temperature increases linearly. Outputs are the electric power consumption of the heat pump and the supply temperature. </p>
<p>Besides using the default simple table data, the user should also test tabulated data from <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a> or polynomial functions.</p>
</html>",
        revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"),
      __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos" "Simulate and plot"),
      Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
  end HeatPumpNEWReversibleHeatPumpAndChiller;

  model InnerCycleNEW "Blackbox model of refrigerant cycle of a HP"
    replaceable model PerDataHea =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.BaseClasses.PartialPerformanceDataNEW
      constrainedby
      AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.BaseClasses.PartialPerformanceDataNEW(final scalingFactor = scalingFactor)
       "Replaceable model for performance data of HP in heating mode"
      annotation (choicesAllMatching=true);

    replaceable model PerDataChi =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.BaseClasses.PartialPerformanceDataNEW
      constrainedby
      AixLib.Fluid.HeatPumps.BaseClasses.PerformanceDataNEW.BaseClasses.PartialPerformanceDataNEW(final scalingFactor = scalingFactor)
       "Replaceable model for performance data of HP in cooling mode"
      annotation (choicesAllMatching=true);
    parameter Integer use_revHP=1 "Operating type of the system (1:reversible HP; 2:only heating; 3:only cooling)";
    parameter Real scalingFactor=1 "Scaling factor of heat pump";
    Controls.Interfaces.HeatPumpControlBusNEW     sigBusHP annotation (Placement(
          transformation(extent={{-16,88},{18,118}}), iconTransformation(extent={{
              -16,88},{18,118}})));
    Modelica.Blocks.Interfaces.RealOutput QCon(unit="W", displayUnit="kW") "Heat Flow to condenser"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealOutput QEva(unit="W", displayUnit="kW") "Heat flow from evaporator"
      annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
    PerDataHea PerformanceDataHeater if not use_revHP==3
                            annotation (Placement(transformation(extent={{13,20},
              {67,76}}, rotation=0)));
    PerDataChi PerformanceDataChiller if not use_revHP==2
                            annotation(Placement(transformation(
          extent={{-27,-28},{27,28}},
          rotation=0,
          origin={-40,48})));

    Utilities.Logical.SmoothSwitch switchQEva(
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"),
      y(unit="W", displayUnit="kW"))
      "If mode is false, Condenser becomes Evaporator and vice versa"
      annotation (Placement(transformation(extent={{-72,-24},{-92,-4}})));
    Utilities.Logical.SmoothSwitch switchQCon(                                                            y(unit="W",displayUnit="kW"),
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"))
      "If mode is false, Condenser becomes Evaporator and vice versa"
      annotation (Placement(transformation(extent={{72,-22},{92,-2}})));
    Modelica.Blocks.Interfaces.RealOutput Pel(unit="W", displayUnit="kW")
      "Electrical power consumed by compressor" annotation (Placement(
          transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=-90,
          origin={0.5,-110.5})));

    AixLib.Utilities.Logical.SmoothSwitch switchPel(
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"),
      y(unit="W", displayUnit="kW"))
      "Whether to use cooling or heating power consumption" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-76})));

  public
    Modelica.Blocks.Math.Gain gainCon(final k=-1) if not use_revHP==2
      "Negate QCon to match definition of heat flow direction" annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=0,
          origin={58,-20})));
    Modelica.Blocks.Math.Gain gainEva(final k=-1) if not use_revHP==3
      "Negate QEva to match definition of heat flow direction" annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={-56,-6})));
  protected
     Modelica.Blocks.Sources.Constant constZeroForChiller(final k=0) if use_revHP==2
      "If no heating is used, the switches may still be connected"
      annotation (Placement(transformation(extent={{-80,-74},{-60,-54}})));
    Modelica.Blocks.Sources.Constant constZeroForHeater(final k=0) if use_revHP==3
      "If no heating is used, the switches may still be connected"
      annotation (Placement(transformation(extent={{98,-74},{78,-54}})));
  equation
    //if heating operation might be used (use_revHP == 1 or 2)
    if not use_revHP==3 then

    connect(constZeroForChiller.y, switchPel.u3)
      annotation (Line(points={{-59,-64},{-8,-64}}, color={0,0,127}));
    connect(constZeroForChiller.y, switchQEva.u3) annotation (Line(
        points={{-59,-64},{-52,-64},{-52,-22},{-70,-22}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(constZeroForChiller.y, switchQCon.u3) annotation (Line(
        points={{-59,-64},{-52,-64},{-52,-38},{70,-38},{70,-20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataHeater.QCon, switchQCon.u1) annotation (Line(
        points={{18.4,17.2},{18.4,-4},{70,-4}}, color={0,0,127}));
    connect(PerformanceDataHeater.Pel, switchPel.u1) annotation (Line(
        points={{40,17.2},{40,-30},{8,-30},{8,-64}}, color={0,0,127}));
    connect(gainEva.y, switchQEva.u1) annotation (Line(
        points={{-60.4,-6},{-70,-6}}, color={0,0,127}));
    connect(PerformanceDataHeater.QEva, gainEva.u) annotation (Line(points={{61.6,
              17.2},{61.6,-6},{-51.2,-6}},
                                         color={0,0,127}));
    end if;

    //if cooling operation might be used (use_revHP == 1 or 3)
    if not use_revHP==2 then

    connect(constZeroForHeater.y, switchPel.u1)
      annotation (Line(points={{77,-64},{8,-64}}, color={0,0,127},
        pattern=LinePattern.Dash));
    connect(constZeroForHeater.y, switchQCon.u1) annotation (Line(points={{77,-64},
            {66,-64},{66,-4},{70,-4}}, color={0,0,127},
        pattern=LinePattern.Dash));
    connect(constZeroForHeater.y, switchQEva.u1) annotation (Line(points={{77,-64},
              {66,-64},{66,-6},{-70,-6}},
                                        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(switchQCon.u3, gainCon.y) annotation (Line(
        points={{70,-20},{62.4,-20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataChiller.QCon, gainCon.u) annotation (Line(
        points={{-61.6,17.2},{-61.6,0},{-18,0},{-18,-20},{53.2,-20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataChiller.Pel, switchPel.u3) annotation (Line(points={{-40,
              17.2},{-40,-30},{-8,-30},{-8,-64}},
                                                color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataChiller.QEva, switchQEva.u3) annotation (Line(points={{-18.4,
              17.2},{-18.4,-22},{-70,-22}},     color={0,0,127},
        pattern=LinePattern.Dash));
    end if;

    //needed connection in every case (use_revHP == 1, 2, 3)
    connect(sigBusHP.mode, switchQEva.u2) annotation (Line(
        points={{1.085,103.075},{1.085,104},{-70,104},{-70,-14}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBusHP.mode, switchQCon.u2) annotation (Line(
        points={{1.085,103.075},{1.085,102},{70,102},{70,-12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBusHP, PerformanceDataHeater.sigBusHP) annotation (Line(
        points={{1,103},{1,86},{38,86},{38,77.12},{40.27,77.12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(switchQEva.y, QEva) annotation (Line(points={{-93,-14},{-94,-14},{-94,
            0},{-110,0}}, color={0,0,127}));
    connect(switchPel.y, Pel) annotation (Line(points={{-2.22045e-015,-87},{-2.22045e-015,
            -110.5},{0.5,-110.5}}, color={0,0,127}));
    connect(sigBusHP.mode, switchPel.u2) annotation (Line(
        points={{1.085,103.075},{1.085,-64},{2.22045e-015,-64}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(sigBusHP, PerformanceDataChiller.sigBusHP) annotation (Line(
        points={{1,103},{1,86},{-39.73,86},{-39.73,77.12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(switchQCon.y, QCon) annotation (Line(points={{93,-12},{94,-12},{94,0},
            {110,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-24,88},{22,44}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-16,82},{20,74}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-18,52},{20,58}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{-98,40},{-60,-28}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-20,-60},{-20,-70},{-20,-80},{20,-60},{20,-80},{-20,-60}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-122,34},{-66,34},{-82,10},{-66,-22},{-120,-22}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{60,40},{98,-28}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{120,34},{64,34},{80,10},{64,-22},{118,-22}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-80,40},{-80,68},{-24,68}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{22,66},{80,66},{80,40}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{78,-28},{78,-70}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{78,-70},{62,-70},{20,-70}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-80,-26},{-80,-68},{-20,-68}},
            color={28,108,200},
            thickness=0.5),
          Text(
            extent={{-30,28},{30,-28}},
            lineColor={28,108,200},
            lineThickness=0.5,
            textString="%name",
            origin={0,-8},
            rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",   info="<html>
<p>This black box model represents the refrigerant cycle of a heat pump. Used in AixLib.Fluid.HeatPumps.HeatPump, this model serves the simulation of a reversible heat pump. Thus, data both of chillers and heat pumps can be used to calculate the three relevant values <span style=\"font-family: Courier New;\">P_el</span>, <span style=\"font-family: Courier New;\">QCon</span> and <span style=\"font-family: Courier New;\">QEva</span>. The <span style=\"font-family: Courier New;\">mode</span> of the heat pump is used to switch between the performance data of the chiller and the heat pump.</p>
<p>The user can choose between different types of performance data or implement a new black-box model by extending from the <a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData\">partial</a> model.</p>
<ul>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">LookUpTable2D</a>: Use 2D-data based on the DIN EN 14511</li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTableND\">LookUpTableND</a>: Use SDF-data tables to model invertercontroller heat pumps or include other dependencies (ambient temperature etc.)</li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.PolynomalApproach\">PolynomalApproach</a>: Use a function based approach to calculate the ouputs. Different functions are already implemented.</li>
</ul>
</html>"));
  end InnerCycleNEW;

  model PartialInnerCycleBACKUP
    "Blackbox model of refrigerant cycle of a thermal machine (heat pump or chiller)"
    replaceable model PerDataMain =
        AixLib.Fluid.HeatPumps.BaseClasses.ReversibleHeatPump_PerformanceData.BaseClasses.PartialPerformanceData
      constrainedby
      AixLib.Fluid.HeatPumps.BaseClasses.ReversibleHeatPump_PerformanceData.BaseClasses.PartialPerformanceData(
                                                                                                 final scalingFactor = scalingFactor)
       "Replaceable model for performance data of thermal machine in main operation mode"
      annotation (choicesAllMatching=true);

    replaceable model PerDataRev =
        AixLib.Fluid.HeatPumps.BaseClasses.ReversibleHeatPump_PerformanceData.BaseClasses.PartialPerformanceData
      constrainedby
      AixLib.Fluid.HeatPumps.BaseClasses.ReversibleHeatPump_PerformanceData.BaseClasses.PartialPerformanceData(
                                                                                                 final scalingFactor = scalingFactor)
       "Replaceable model for performance data of thermal machine in reversible operation mode"
      annotation (Dialog(enable=use_rev),choicesAllMatching=true);
    parameter Boolean use_rev=true "True if the thermal machine is reversible";
    parameter Real scalingFactor=1 "Scaling factor of thermal machine";
    AixLib.Controls.Interfaces.ThermalMachineControlBus sigBus annotation (
        Placement(transformation(extent={{-16,88},{18,118}}), iconTransformation(
            extent={{-16,88},{18,118}})));
    Modelica.Blocks.Interfaces.RealOutput QCon(unit="W", displayUnit="kW") "Heat Flow to condenser"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealOutput QEva(unit="W", displayUnit="kW") "Heat flow from evaporator"
      annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
    PerDataMain PerformanceDataHeating annotation (Placement(transformation(
            extent={{13,20},{67,76}}, rotation=0)));
    Utilities.Logical.SmoothSwitch switchQEva(
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"),
      y(unit="W", displayUnit="kW"))
      "If mode is false, Condenser becomes Evaporator and vice versa"
      annotation (Placement(transformation(extent={{-70,-24},{-90,-4}})));
    Utilities.Logical.SmoothSwitch switchQCon(                                                            y(unit="W",displayUnit="kW"),
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"))
      "If mode is false, Condenser becomes Evaporator and vice versa"
      annotation (Placement(transformation(extent={{72,-22},{92,-2}})));
    Modelica.Blocks.Interfaces.RealOutput Pel(unit="W", displayUnit="kW")
      "Electrical power consumed by compressor" annotation (Placement(
          transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=-90,
          origin={0.5,-110.5})));

    PerDataRev PerformanceDataCooling if use_rev
                            annotation(Placement(transformation(
          extent={{-27,-28},{27,28}},
          rotation=0,
          origin={-46,48})));

    AixLib.Utilities.Logical.SmoothSwitch switchPel(
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"),
      y(unit="W", displayUnit="kW"))
      "Whether to use cooling or heating power consumption" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-76})));
  protected
    Modelica.Blocks.Sources.Constant constZero(final k=0) if not use_rev
      "If no heating is used, the switches may still be connected"
      annotation (Placement(transformation(extent={{-80,-74},{-60,-54}})));
  public
    Modelica.Blocks.Math.Gain gainCon(final k=-1) if use_rev
      "Negate QCon to match definition of heat flow direction" annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=0,
          origin={58,-20})));
    Modelica.Blocks.Math.Gain gainEva(final k=-1)
      "Negate QEva to match definition of heat flow direction" annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={-56,-6})));
  equation
    assert(
      use_rev or (use_rev == false and sigBus.mode == true),
      "Can't turn to chilling on irreversible HP",
      level=AssertionLevel.error);
    connect(sigBus.mode, switchQEva.u2) annotation (Line(
        points={{1.085,103.075},{1.085,104},{-68,104},{-68,-14}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBus.mode, switchQCon.u2) annotation (Line(
        points={{1.085,103.075},{1.085,102},{70,102},{70,-12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBus, PerformanceDataHeating.sigBus) annotation (Line(
        points={{1,103},{1,86},{2,86},{2,86},{38,86},{38,77.12},{40.27,77.12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(switchQEva.y, QEva) annotation (Line(points={{-91,-14},{-92,-14},{-92,
            0},{-110,0}}, color={0,0,127}));
    connect(PerformanceDataHeating.QCon, switchQCon.u1)
      annotation (Line(points={{18.4,17.2},{18.4,-4},{70,-4}}, color={0,0,127}));
    connect(switchPel.y, Pel) annotation (Line(points={{-2.22045e-015,-87},{-2.22045e-015,
            -110.5},{0.5,-110.5}}, color={0,0,127}));
    connect(sigBus.mode, switchPel.u2) annotation (Line(
        points={{1.085,103.075},{1.085,-64},{2.22045e-015,-64}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(PerformanceDataHeating.Pel, switchPel.u1) annotation (Line(points={{
            40,17.2},{40,-30},{8,-30},{8,-64}}, color={0,0,127}));
    connect(PerformanceDataCooling.Pel, switchPel.u3) annotation (Line(points={{-46,
            17.2},{-46,-30},{-8,-30},{-8,-64}}, color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataCooling.QEva, switchQEva.u3) annotation (Line(points={{-24.4,
            17.2},{-24.4,-22},{-68,-22}},       color={0,0,127},
        pattern=LinePattern.Dash));
    connect(sigBus,PerformanceDataCooling. sigBus) annotation (Line(
        points={{1,103},{1,86},{-45.73,86},{-45.73,77.12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(constZero.y, switchPel.u3)
      annotation (Line(points={{-59,-64},{-8,-64}}, color={0,0,127}));
    connect(constZero.y, switchQEva.u3) annotation (Line(points={{-59,-64},{-52,
            -64},{-52,-22},{-68,-22}}, color={0,0,127},
        pattern=LinePattern.Dash));
    connect(constZero.y, switchQCon.u3) annotation (Line(points={{-59,-64},{-52,
            -64},{-52,-38},{70,-38},{70,-20}}, color={0,0,127},
        pattern=LinePattern.Dash));
    connect(switchQCon.y, QCon) annotation (Line(points={{93,-12},{94,-12},{94,0},
            {110,0}}, color={0,0,127}));
    connect(gainEva.y, switchQEva.u1)
      annotation (Line(points={{-60.4,-6},{-68,-6}}, color={0,0,127}));
    connect(switchQCon.u3, gainCon.y) annotation (Line(
        points={{70,-20},{62.4,-20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataCooling.QCon, gainCon.u) annotation (Line(
        points={{-67.6,17.2},{-67.6,0},{-24,0},{-24,-20},{53.2,-20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataHeating.QEva, gainEva.u) annotation (Line(points={{
            61.6,17.2},{61.6,-6},{-51.2,-6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-24,88},{22,44}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-16,82},{20,74}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-18,52},{20,58}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{-98,40},{-60,-28}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-20,-60},{-20,-70},{-20,-80},{20,-60},{20,-80},{-20,-60}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-122,34},{-66,34},{-82,10},{-66,-22},{-120,-22}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{60,40},{98,-28}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{120,34},{64,34},{80,10},{64,-22},{118,-22}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-80,40},{-80,68},{-24,68}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{22,66},{80,66},{80,40}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{78,-28},{78,-70}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{78,-70},{62,-70},{20,-70}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-80,-26},{-80,-68},{-20,-68}},
            color={28,108,200},
            thickness=0.5),
          Text(
            extent={{-30,28},{30,-28}},
            lineColor={28,108,200},
            lineThickness=0.5,
            textString="%name",
            origin={0,-8},
            rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",   info="<html>
<p>This black box model represents the refrigerant cycle of a heat pump. Used in AixLib.Fluid.HeatPumps.HeatPump, this model serves the simulation of a reversible heat pump. Thus, data both of chillers and heat pumps can be used to calculate the three relevant values <span style=\"font-family: Courier New;\">P_el</span>, <span style=\"font-family: Courier New;\">QCon</span> and <span style=\"font-family: Courier New;\">QEva</span>. The <span style=\"font-family: Courier New;\">mode</span> of the heat pump is used to switch between the performance data of the chiller and the heat pump.</p>
<p>The user can choose between different types of performance data or implement a new black-box model by extending from the <a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData\">partial</a> model.</p>
<ul>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">LookUpTable2D</a>: Use 2D-data based on the DIN EN 14511</li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTableND\">LookUpTableND</a>: Use SDF-data tables to model invertercontroller heat pumps or include other dependencies (ambient temperature etc.)</li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.PolynomalApproach\">PolynomalApproach</a>: Use a function based approach to calculate the ouputs. Different functions are already implemented.</li>
</ul>
</html>"));
  end PartialInnerCycleBACKUP;

  partial model PartialReversibleThermalMachine
    "Grey-box model for reversible heat pumps and chillers using a black-box to simulate the refrigeration cycle"
    extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
      redeclare final package Medium1 = Medium_con,
      redeclare final package Medium2 = Medium_eva,
      final m1_flow_nominal=mFlow_conNominal,
      final m2_flow_nominal=mFlow_evaNominal,
      final allowFlowReversal1=allowFlowReversalCon,
      final allowFlowReversal2=allowFlowReversalEva,
      final m1_flow_small=1E-4*abs(mFlow_conNominal),
      final m2_flow_small=1E-4*abs(mFlow_evaNominal),
      final show_T=show_TPort);

  //General
    replaceable package Medium_con =
      Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
      annotation (Dialog(tab = "Condenser"),choicesAllMatching=true);
    replaceable package Medium_eva =
      Modelica.Media.Interfaces.PartialMedium "Medium at source side"
      annotation (Dialog(tab = "Evaporator"),choicesAllMatching=true);

    parameter Boolean use_rev=true "Is the thermal machine reversible?"   annotation(choices(checkBox=true), Dialog(descriptionLabel=true));

    replaceable model PerDataMain =
        AixLib.Fluid.BaseClasses.ReversibleThermalMachine_PerformanceData.PartialPerformanceData
    "Performance data of thermal machine in main operation mode"
      annotation (choicesAllMatching=true);
    replaceable model PerDataRev =
        AixLib.Fluid.BaseClasses.ReversibleThermalMachine_PerformanceData.PartialPerformanceData
    "Performance data of thermal machine in reversible operation mode"
      annotation (Dialog(enable=use_rev),choicesAllMatching=true);

    parameter Real scalingFactor=1 "Scaling-factor of thermal machine";
    parameter Boolean use_refIne=true
      "Consider the inertia of the refrigerant cycle"                           annotation(choices(checkBox=true), Dialog(
          group="Refrigerant inertia"));

    parameter Modelica.SIunits.Frequency refIneFre_constant
      "Cut off frequency for inertia of refrigerant cycle"
      annotation (Dialog(enable=use_refIne, group="Refrigerant inertia"),Evaluate=true);
    parameter Integer nthOrder=3 "Order of refrigerant cycle interia" annotation (Dialog(enable=
            use_refIne, group="Refrigerant inertia"));

  //Condenser
    parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
      "Nominal mass flow rate"
      annotation (Dialog(group="Parameters", tab="Condenser"),Evaluate=true);
    parameter Modelica.SIunits.Volume VCon "Volume in condenser"
      annotation (Evaluate=true,Dialog(group="Parameters", tab="Condenser"));
    parameter Modelica.SIunits.PressureDifference dpCon_nominal
      "Pressure drop at nominal mass flow rate"
      annotation (Dialog(group="Flow resistance", tab="Condenser"), Evaluate=true);
    parameter Real deltaM_con=0.1
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
      annotation (Dialog(tab="Condenser", group="Flow resistance"));
    parameter Boolean use_conCap=true
      "If heat losses at capacitor side are considered or not"
      annotation (Dialog(group="Heat Losses", tab="Condenser"),
                                            choices(checkBox=true));
    parameter Modelica.SIunits.HeatCapacity CCon
      "Heat capacity of Condenser (= cp*m)" annotation (Evaluate=true,Dialog(group="Heat Losses",
          tab="Condenser",
        enable=use_conCap));
    parameter Modelica.SIunits.ThermalConductance GConOut
      "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Condenser",
        enable=use_conCap));
    parameter Modelica.SIunits.ThermalConductance GConIns
      "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Condenser",
        enable=use_conCap));
  //Evaporator
    parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
      "Nominal mass flow rate" annotation (Dialog(group="Parameters", tab="Evaporator"),Evaluate=true);

    parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
      annotation (Evaluate=true,Dialog(group="Parameters", tab="Evaporator"));
    parameter Modelica.SIunits.PressureDifference dpEva_nominal
      "Pressure drop at nominal mass flow rate"
      annotation (Dialog(group="Flow resistance", tab="Evaporator"),Evaluate=true);
    parameter Real deltaM_eva=0.1
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
      annotation (Dialog(tab="Evaporator", group="Flow resistance"));
    parameter Boolean use_evaCap=true
      "If heat losses at capacitor side are considered or not"
      annotation (Dialog(group="Heat Losses", tab="Evaporator"),
                                            choices(checkBox=true));
    parameter Modelica.SIunits.HeatCapacity CEva
      "Heat capacity of Evaporator (= cp*m)"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
    parameter Modelica.SIunits.ThermalConductance GEvaOut
      "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
    parameter Modelica.SIunits.ThermalConductance GEvaIns
      "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
      annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
        enable=use_evaCap));
  //Assumptions
    parameter Modelica.SIunits.Time tauSenT=1
      "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
      annotation (Dialog(tab="Assumptions", group="Temperature sensors"));

    parameter Boolean transferHeat=true
      "If true, temperature T converges towards TAmb when no flow"
      annotation (Dialog(tab="Assumptions", group="Temperature sensors"),choices(checkBox=true));
    parameter Boolean allowFlowReversalEva=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(group="Evaporator", tab="Assumptions"));
    parameter Boolean allowFlowReversalCon=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(group="Condenser", tab="Assumptions"));

    parameter Modelica.SIunits.Time tauHeaTraEva=1200
      "Time constant for heat transfer in temperature sensors in evaporator, default 20 minutes"
      annotation (Dialog(tab="Assumptions", group="Evaporator",enable=transferHeat),         Evaluate=true);
    parameter Modelica.SIunits.Time tauHeaTraCon=1200
      "Time constant for heat transfer in temperature sensors in evaporator, default 20 minutes"
      annotation (Dialog(tab="Assumptions", group="Condenser",enable=transferHeat),Evaluate=true);
    parameter Modelica.SIunits.Temperature TAmbCon_nominal=291.15
      "Fixed ambient temperature for heat transfer of sensors at the condenser side" annotation (               Dialog(tab=
            "Assumptions",                                                                                               group=
            "Condenser",
        enable=transferHeat));

    parameter Modelica.SIunits.Temperature TAmbEva_nominal=273.15
      "Fixed ambient temperature for heat transfer of sensors at the evaporator side"
      annotation (               Dialog(tab="Assumptions",group="Evaporator",enable=transferHeat));

  //Initialization
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
      "Type of initialization (InitialState and InitialOutput are identical)"
      annotation (Dialog(tab="Initialization", group="Parameters"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pCon_start=
        Medium_con.p_default "Start value of pressure"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.Temperature TCon_start=Medium_con.T_default
      "Start value of temperature"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.MassFraction XCon_start[Medium_con.nX]=
       Medium_con.X_default "Start value of mass fractions m_i/m"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pEva_start=
        Medium_eva.p_default "Start value of pressure"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Modelica.Media.Interfaces.Types.Temperature TEva_start=Medium_eva.T_default
      "Start value of temperature"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Modelica.Media.Interfaces.Types.MassFraction XEva_start[Medium_eva.nX]=
       Medium_eva.X_default "Start value of mass fractions m_i/m"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Real x_start[nthOrder]=zeros(nthOrder)
      "Initial or guess values of states"
      annotation (Dialog(tab="Initialization", group="Refrigerant inertia", enable=use_refIne));
    parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Initialization", group="Refrigerant inertia",enable=initType ==
            Init.InitialOutput and use_refIne));
  //Dynamics
    parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of mass balance: dynamic (3 initialization options) or steady state"
      annotation (Dialog(tab="Dynamics", group="Equation"));
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation (Dialog(tab="Dynamics", group="Equation"));
  //Advanced
    parameter Boolean show_TPort=false
      "= true, if actual temperature at port is computed"
      annotation(Dialog(tab="Advanced",group="Diagnostics"));
    parameter Boolean from_dp=false
      "= true, use m_flow = f(dp) else dp = f(m_flow)"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    parameter Boolean homotopyInitialization=false "= true, use homotopy method"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    parameter Boolean linearized=false
      "= true, use linear relation between m_flow and dp for any flow rate"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));

    PartialInnerCycle innerCycle(
        redeclare final model PerDataMainHP = PerDataMain,
        redeclare final model PerDataRevHP = PerDataRev,
        redeclare final model PerDataMainChi = PerDataMain,
        redeclare final model PerDataRevChi = PerDataRev,
        final use_rev=use_rev,
        final scalingFactor=scalingFactor,
        final machineType = machineType)
      annotation (Placement(transformation(
          extent={{-27,-26},{27,26}},
          rotation=90,
          origin={0,-1})));
    AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity con(
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*abs(mFlow_conNominal),
      final show_T=show_TPort,
      final deltaM=deltaM_con,
      final T_start=TCon_start,
      final p_start=pCon_start,
      final use_cap=use_conCap,
      final X_start=XCon_start,
      final from_dp=from_dp,
      final homotopyInitialization=homotopyInitialization,
      final massDynamics=massDynamics,
      final energyDynamics=energyDynamics,
      final is_con=true,
      final V=VCon*scalingFactor,
      final C=CCon*scalingFactor,
      final GOut=GConOut*scalingFactor,
      final m_flow_nominal=mFlow_conNominal*scalingFactor,
      final dp_nominal=dpCon_nominal*scalingFactor,
      final GInn=GConIns*scalingFactor) "Heat exchanger model for the condenser"
      annotation (Placement(transformation(extent={{-16,78},{16,110}})));
    AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity eva(
      redeclare final package Medium = Medium_eva,
      final deltaM=deltaM_eva,
      final use_cap=use_evaCap,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*abs(mFlow_evaNominal),
      final show_T=show_TPort,
      final T_start=TEva_start,
      final p_start=pEva_start,
      final X_start=XEva_start,
      final from_dp=from_dp,
      final homotopyInitialization=homotopyInitialization,
      final massDynamics=massDynamics,
      final energyDynamics=energyDynamics,
      final is_con=false,
      final V=VEva*scalingFactor,
      final C=CEva*scalingFactor,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor,
      final dp_nominal=dpEva_nominal*scalingFactor,
      final GOut=GEvaOut*scalingFactor,
      GInn=GEvaIns*scalingFactor) "Heat exchanger model for the evaporator"
      annotation (Placement(transformation(extent={{16,-70},{-16,-102}})));
    Modelica.Blocks.Continuous.CriticalDamping heatFlowIneEva(
      final initType=initType,
      final normalized=true,
      final n=nthOrder,
      final f=refIneFre_constant,
      final x_start=x_start,
      final y_start=yRefIne_start) if
                                     use_refIne
      "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
      annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={-14,-52})));
    Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetCon if
                                                                   not use_refIne
      "Use default nSet value" annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={16,58})));
    Modelica.Blocks.Continuous.CriticalDamping heatFlowIneCon(
      final initType=initType,
      final normalized=true,
      final n=nthOrder,
      final f=refIneFre_constant,
      final x_start=x_start,
      final y_start=yRefIne_start) if
                                     use_refIne
      "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
      annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={-16,58})));
    Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetEva if
                                                                   not use_refIne
      "Use default nSet value" annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={16,-52})));
    Modelica.Blocks.Interfaces.RealInput iceFac_in
      "Input signal for icing factor" annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={-76,-136})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutEva if
      use_evaCap "Foreces heat losses according to ambient temperature"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={68,-108})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutCon if
      use_conCap "Foreces heat losses according to ambient temperature"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={68,110})));

    Modelica.Blocks.Interfaces.RealInput nSet
      "Input signal speed for compressor relative between 0 and 1" annotation (Placement(
          transformation(extent={{-132,4},{-100,36}})));
    AixLib.Controls.Interfaces.ThermalMachineControlBus sigBus annotation (
        Placement(transformation(extent={{-120,-60},{-90,-26}}),
          iconTransformation(extent={{-108,-52},{-90,-26}})));

    Modelica.Blocks.Interfaces.RealInput T_amb_eva(final unit="K", final
        displayUnit="degC")
      "Ambient temperature on the evaporator side"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=0,
          origin={110,-100})));
    Modelica.Blocks.Interfaces.RealInput T_amb_con(final unit="K", final
        displayUnit="degC")
      "Ambient temperature on the condenser side"
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=180,
          origin={110,100})));

    Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of operation mode"
      annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));

    Sensors.TemperatureTwoPort senT_a2(
      redeclare final package Medium = Medium_eva,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*mFlow_evaNominal,
      final initType=initType,
      final T_start=TEva_start,
      final transferHeat=transferHeat,
      final TAmb=TAmbEva_nominal,
      final tauHeaTra=tauHeaTraEva,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor)
      "Temperature at sink inlet" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={38,-86})));
    Sensors.TemperatureTwoPort senT_b2(
      redeclare final package Medium = Medium_eva,
      final allowFlowReversal=allowFlowReversalEva,
      final m_flow_small=1E-4*mFlow_evaNominal,
      final initType=initType,
      final T_start=TEva_start,
      final transferHeat=transferHeat,
      final TAmb=TAmbEva_nominal,
      final tauHeaTra=tauHeaTraEva,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_evaNominal*scalingFactor)
      "Temperature at sink outlet" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-52,-86})));
    Sensors.MassFlowRate mFlow_eva(redeclare final package Medium = Medium_eva,
        final allowFlowReversal=allowFlowReversalEva)
      "Mass flow sensor at the evaporator" annotation (Placement(transformation(
          origin={72,-60},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    Sensors.TemperatureTwoPort senT_b1(
      final initType=initType,
      final transferHeat=transferHeat,
      final TAmb=TAmbCon_nominal,
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*mFlow_conNominal,
      final T_start=TCon_start,
      final tau=tauSenT,
      final tauHeaTra=tauHeaTraCon,
      final m_flow_nominal=mFlow_conNominal*scalingFactor)
      "Temperature at sink outlet" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={38,92})));
    Sensors.TemperatureTwoPort senT_a1(
      final initType=initType,
      final transferHeat=transferHeat,
      redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon,
      final m_flow_small=1E-4*mFlow_conNominal,
      final T_start=TCon_start,
      final TAmb=TAmbCon_nominal,
      final tau=tauSenT,
      final m_flow_nominal=mFlow_conNominal*scalingFactor,
      final tauHeaTra=tauHeaTraCon)
      "Temperature at sink inlet" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={-34,90})));
    Sensors.MassFlowRate mFlow_con(final allowFlowReversal=allowFlowReversalEva,
        redeclare final package Medium = Medium_con)
      "Mass flow sensor at the evaporator" annotation (Placement(transformation(
          origin={-76,60},
          extent={{-10,10},{10,-10}},
          rotation=0)));

  protected
    parameter Boolean machineType = true "true: heat pump; false: chiller";
    replaceable model PartialInnerCycle =
        AixLib.Fluid.BaseClasses.PartialInnerCycle
    constrainedby AixLib.Fluid.BaseClasses.PartialInnerCycle
    "Blackbox model of refrigerant cycle of a thermal machine (heat pump or chiller)"
    annotation (choicesAllMatching=true);

  equation

      connect(senT_a1.T, sigBus.T_flow_co) annotation (Line(points={{-34,79},{-34,
            40},{-76,40},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_b1.T, sigBus.T_ret_co) annotation (Line(points={{38,81},{38,-36},
            {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_a2.T, sigBus.T_flow_ev) annotation (Line(points={{38,-75},{38,-36},
            {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_b2.T, sigBus.T_ret_ev) annotation (Line(points={{-52,-75},{-52,
            -42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mFlow_eva.m_flow, sigBus.m_flow_ev) annotation (Line(points={{72,-49},
            {72,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mFlow_con.m_flow, sigBus.m_flow_co) annotation (Line(points={{-76,
            49},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(modeSet, sigBus.mode) annotation (Line(points={{-116,-20},{-76,-20},{-76,
            -42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(nSet, sigBus.N) annotation (Line(points={{-116,20},{-76,20},{-76,-42.915},
            {-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(innerCycle.QEva, realPassThroughnSetEva.u) annotation (Line(
        points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{16,-38},{16,-44.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QEva, heatFlowIneEva.u) annotation (Line(
        points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{-14,-38},{-14,-44.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QCon, heatFlowIneCon.u) annotation (Line(
        points={{1.77636e-15,28.7},{1.77636e-15,30},{0,30},{0,40},{-16,40},{-16,50.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QCon, realPassThroughnSetCon.u) annotation (Line(
        points={{1.77636e-15,28.7},{0,28.7},{0,40},{16,40},{16,50.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(iceFac_in, sigBus.iceFac) annotation (Line(points={{-76,-136},{-76,-42.915},
            {-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(T_amb_con, varTempOutCon.T) annotation (Line(
        points={{110,100},{84,100},{84,110},{77.6,110}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(varTempOutCon.port, con.port_out) annotation (Line(
        points={{60,110},{0,110}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(T_amb_eva, varTempOutEva.T) annotation (Line(
        points={{110,-100},{94,-100},{94,-108},{77.6,-108}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(eva.port_out, varTempOutEva.port) annotation (Line(
        points={{0,-102},{0,-108},{60,-108}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(port_b2, port_b2) annotation (Line(points={{-100,-60},{-100,-60},{-100,
            -60}}, color={0,127,255}));
    connect(realPassThroughnSetCon.y, con.QFlow_in) annotation (Line(
        points={{16,64.6},{16,77.04},{0,77.04}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(heatFlowIneCon.y, con.QFlow_in) annotation (Line(
        points={{-16,64.6},{-16,77.04},{0,77.04}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realPassThroughnSetEva.y, eva.QFlow_in) annotation (Line(points={{16,-58.6},
            {16,-69.04},{0,-69.04}}, color={0,0,127}));
    connect(heatFlowIneEva.y, eva.QFlow_in) annotation (Line(points={{-14,-58.6},{
            -14,-69.04},{0,-69.04}}, color={0,0,127}));
    connect(senT_a2.port_b, eva.port_a)
      annotation (Line(points={{28,-86},{16,-86}}, color={0,127,255}));
    connect(senT_b2.port_a, eva.port_b)
      annotation (Line(points={{-42,-86},{-16,-86}}, color={0,127,255}));
    connect(senT_b2.port_b, port_b2) annotation (Line(points={{-62,-86},{-62,-60},
            {-100,-60}}, color={0,127,255}));
    connect(mFlow_eva.port_a, port_a2)
      annotation (Line(points={{82,-60},{100,-60}}, color={0,127,255}));
    connect(mFlow_eva.port_b, senT_a2.port_a) annotation (Line(points={{62,-60},{58,
            -60},{58,-86},{48,-86}}, color={0,127,255}));
    connect(con.port_a, senT_a1.port_b)
      annotation (Line(points={{-16,94},{-20,94},{-20,90},{-24,90}},
                                                   color={0,127,255}));
    connect(senT_a1.port_a, mFlow_con.port_b) annotation (Line(points={{-44,90},{-56,
            90},{-56,60},{-66,60}},     color={0,127,255}));
    connect(port_a1, mFlow_con.port_a)
      annotation (Line(points={{-100,60},{-86,60}}, color={0,127,255}));
    connect(con.port_b, senT_b1.port_a)
      annotation (Line(points={{16,94},{22,94},{22,92},{28,92}},
                                                 color={0,127,255}));
    connect(port_b1, senT_b1.port_b) annotation (Line(points={{100,60},{72,60},{72,
            92},{48,92}}, color={0,127,255}));
    connect(innerCycle.sigBus, sigBus) annotation (Line(
        points={{-26.78,-0.73},{-54,-0.73},{-54,-43},{-105,-43}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(innerCycle.Pel, sigBus.Pel) annotation (Line(points={{28.73,-0.865},{
            38,-0.865},{38,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}},
                                                                          color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
          Rectangle(
            extent={{-16,83},{16,-83}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,-64},
            rotation=90),
          Rectangle(
            extent={{-17,83},{17,-83}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,61},
            rotation=90),
          Text(
            extent={{-76,6},{74,-36}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="%name
"),       Line(
            points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-3,-60},
            rotation=-90),
          Line(
            points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-5,56},
            rotation=-90),
          Rectangle(
            extent={{-82,42},{84,-46}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-88,60},{88,60}}, color={28,108,200}),
          Line(points={{-88,-60},{88,-60}}, color={28,108,200}),
      Line(
      origin={-75.5,-80.333},
      points={{43.5,8.3333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,-11.667},{27.5,-21.667},{13.5,-23.667},
                {11.5,-31.667}},
        smooth=Smooth.Bezier,
        visible=use_evaCap),
          Polygon(
            points={{-70,-122},{-68,-108},{-58,-114},{-70,-122}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_evaCap),
      Line( origin={40.5,93.667},
            points={{39.5,6.333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,
                -11.667},{27.5,-21.667},{13.5,-23.667},{11.5,-27.667}},
            smooth=Smooth.Bezier,
            visible=use_conCap),
          Polygon(
            points={{86,110},{84,96},{74,102},{86,110}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_conCap),
          Line(
            points={{-42,72},{34,72}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5),
          Line(
            points={{-38,0},{38,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5,
            origin={0,-74},
            rotation=180)}),                Diagram(coordinateSystem(extent={{-100,
              -120},{100,120}})),
      Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",   info="<html>
<p>This generic grey-box heat pump model uses empirical data to model the refrigerant cycle. The modelling of system inertias and heat losses allow the simulation of transient states. </p>
<p>Resulting in the choosen model structure, several configurations are possible:</p>
<ol>
<li>Compressor type: on/off or inverter controlled</li>
<li>Reversible heat pump / only heating</li>
<li>Source/Sink: Any combination of mediums is possible</li>
<li>Generik: Losses and inertias can be switched on or off.</li>
</ol>
<h4>Concept</h4>
<p>Using a signal bus as a connector, this heat pump model can be easily combined with the new <a href=\"modelica://AixLib.Systems.HeatPumpSystems.HeatPumpSystem\">HeatPumpSystem</a> or several control or security blocks from <a href=\"modelica://AixLib.Controls.HeatPump\">AixLib.Controls.HeatPump</a>. The relevant data is aggregated. In order to control both chillers and heat pumps, both flow and return temperature are aggregated. The mode signal chooses the type of the heat pump. As a result, this model can also be used as a chiller:</p>
<ul>
<li>mode = true: Heating</li>
<li>mode = false: Chilling</li>
</ul>
<p>To model both on/off and inverter controlled heat pumps, the compressor speed is normalizd to a relative value between 0 and 1.</p>
<p>Possible icing of the evaporator is modelled with an input value between 0 and 1.</p>
<p>The model structure is as follows. To understand each submodel, please have a look at the corresponding model information:</p>
<ol>
<li><a href=\"AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle\">InnerCycle</a> (Black Box): Here, the user can use between several input models or just easily create his own, modular black box model. Please look at the model description for more info.</li>
<li>Inertia: A n-order element is used to model system inertias (mass and thermal) of components inside the refrigerant cycle (compressor, pipes, expansion valve)</li>
<li><a href=\"modelica://AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity\">HeatExchanger</a>: This new model also enable modelling of thermal interias and heat losses in a heat exchanger. Please look at the model description for more info.</li>
</ol>
<h4>Assumptions</h4>
<p>Several assumptions where made in order to model the heat pump. For a detailed description see the corresponding model. </p>
<ol>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">Performance data 2D</a>: In order to model inverter controlled heat pumps, the compressor speed is scaled <b>linearly</b></li>
<li><a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">Performance data 2D</a>: Reduced evaporator power as a result of icing. The icing factor is multiplied with the evaporator power.</li>
<li><b>Inertia</b>: The default value of the n-th order element is set to 3. This follows comparisons with experimental data. Previous heat pump models are using n = 1 as a default. However, it was pointed out that a higher order element fits a real heat pump better in</li>
<li><b>Scaling factor</b>: A scaling facor is implemented for scaling of the heat pump power and capacity. The factor scales the parameters V, m_flow_nominal, C, GIns, GOut and dp_nominal. As a result, the heat pump can supply more heat with the COP staying nearly constant. However, one has to make sure that the supplied pressure difference or mass flow is also scaled with this factor, as the nominal values do not increase said mass flow.</li>
</ol>
<h4>Known Limitations</h4>
<ul>
<li>The n-th order element has a big influence on computational time. Reducing the order or disabling it completly will decrease computational time. </li>
<li>Reversing the mode: A normal 4-way-exchange valve suffers from heat losses and irreversibilities due to switching from one mode to another. Theses losses are not taken into account.</li>
</ul>
</html>"));
  end PartialReversibleThermalMachine;
end OldModels;
