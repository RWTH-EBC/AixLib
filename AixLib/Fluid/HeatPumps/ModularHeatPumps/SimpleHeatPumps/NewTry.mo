within AixLib.Fluid.HeatPumps.ModularHeatPumps.SimpleHeatPumps;
package NewTry

  model S1_Condensation
    "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-70,30})));

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      length=1,
      nNodes=1,
      Twall_start=333.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=2700000,
      p_b_start2=2700000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Interaction.Show.RealValue heaCapHP(use_numberPort=false,
        number=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-10,-86},{10,-66}})));
  equation
    // Connection of main components
    //

    connect(sourceHP.ports[1], cond.port_a2) annotation (Line(points={{60,30},{60,
            28},{30,28},{30,64.6},{11,64.6}}, color={0,127,255}));
    connect(cond.port_b2, sinkHP.ports[1]) annotation (Line(points={{-11,55.4},{-30,
            55.4},{-30,30},{-60,30}}, color={0,127,255}));
    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S1_Condensation;

  model S2_Tank "Model that describes two-phase separator of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={-70,-30})));

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      length=1,
      nNodes=1,
      Twall_start=333.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=2700000,
      p_b_start2=2700000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Interaction.Show.RealValue heaCapHP(use_numberPort=false,
        number=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-10,-86},{10,-66}})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      VTanInn=4e-3,
      useHeatLoss=false,
      allowFlowReversal=true,
      dp_start=0,
      m_flow_start_a=0.02,
      m_flow_start_b=0.02,
      pTan0=2700000,
      hTan0=385e3,
      m_flow_nominal=0.04,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true)
      "Tank (two-phase separator) of the working fluid"
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  equation
    // Connection of main components
    //

    connect(sourceHP.ports[1], cond.port_a2) annotation (Line(points={{60,30},{60,
            28},{30,28},{30,64.6},{11,64.6}}, color={0,127,255}));
    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    connect(cond.port_b2, tan.port_a) annotation (Line(points={{-11,55.4},{-70,
            55.4},{-70,50}}, color={0,127,255}));
    connect(tan.port_b, sinkHP.ports[1])
      annotation (Line(points={{-70,30},{-70,-20}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Tank;

  model S3_Valve
    "Model that describes expansion valve of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(253.15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    parameter Integer nVal=1
      "Number of valves - each valve will be connected to an individual port_b";

    // Definition of subcomponents
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={-70,-70})));

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      length=1,
      nNodes=1,
      Twall_start=333.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=2700000,
      p_b_start2=2700000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Interaction.Show.RealValue heaCapHP(use_numberPort=false,
        number=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-10,-86},{10,-66}})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      VTanInn=4e-3,
      useHeatLoss=false,
      allowFlowReversal=true,
      dp_start=0,
      m_flow_start_a=0.02,
      m_flow_start_b=0.02,
      pTan0=2700000,
      hTan0=385e3,
      m_flow_nominal=0.04,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true)
      "Tank (two-phase separator) of the working fluid"
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      risTim={5},
      calcProc={AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      useExt=true,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.9},
      yMin={0.25},
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_start=0.02,
      tau=5,
      initTypeSen=Modelica.Blocks.Types.Init.NoInit,
      AVal={1.32e-6})                                "Modular expansion valves"
      annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-70,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(nVal=nVal, redeclare
        package
        Medium = MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-70,-40})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(nVal=nVal) "Data Bus"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.9)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,34})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=nVal)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,14})));
  equation
    // Connection of main components
    //

    connect(sourceHP.ports[1], cond.port_a2) annotation (Line(points={{60,30},{60,
            28},{30,28},{30,64.6},{11,64.6}}, color={0,127,255}));
    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    connect(cond.port_b2, tan.port_a) annotation (Line(points={{-11,55.4},{-70,55.4},
            {-70,50}}, color={0,127,255}));
    connect(tan.port_b, modExpVal.port_a)
      annotation (Line(points={{-70,30},{-70,25},{-70,20}}, color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a)
      annotation (Line(points={{-70,-20},{-70,-30}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, sinkHP.ports[1]) annotation (Line(points={{
            -70,-50},{-70,-55},{-70,-60}}, color={0,127,255}));
    connect(modExpVal.dataBus, datBus) annotation (Line(
        points={{-50,-3.55271e-015},{-41,-3.55271e-015},{-41,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(preOpe.y,repPreOpe. u)
      annotation (Line(points={{-20,27.4},{-20,27.4},{-20,21.2}},
                                                              color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,7.4},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S3_Valve;

  model S4_Evaporator
    "Model that describes evaporation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(253.15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 1
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    parameter Integer nVal=1
      "Number of valves - each valve will be connected to an individual port_b";
    parameter Integer nCom=1
      "Number of valves - each valve will be connected to an individual port_b";

    // Definition of subcomponents
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={70,10})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={70,-10})));

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      length=1,
      nNodes=1,
      Twall_start=333.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=2700000,
      p_b_start2=2700000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Sources.RealExpression heaCapHP(
      y=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-8,-9},{8,9}},
          rotation=90,
          origin={20,-33})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      VTanInn=4e-3,
      useHeatLoss=false,
      allowFlowReversal=true,
      m_flow_start_a=0.02,
      m_flow_start_b=0.02,
      hTan0=385e3,
      m_flow_nominal=0.04,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      dp_start=23,
      pTan0=2700000)
      "Tank (two-phase separator) of the working fluid"
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      risTim={5},
      calcProc={AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      useExt=true,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.9},
      yMin={0.25},
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_start=0.02,
      tau=5,
      initTypeSen=Modelica.Blocks.Types.Init.NoInit,
      AVal={1.32e-6})                                "Modular expansion valves"
      annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-70,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(nVal=nVal, redeclare
        package
        Medium = MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-70,-40})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(nVal=nVal, nCom=nCom)
                                                                    "Data Bus"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.9)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,34})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=nVal)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,14})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX eva(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      length=1,
      nNodes=1,
      m_flow_start_1=m_flow_source_EV,
      T_start_1=TSouEV - 2.5,
      Twall_start=273.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=400000,
      p_b_start2=400000,
      T_start_2=254.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-90,-80})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators inlet"
      annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
    Sensors.TemperatureTwoPort senTemOut(
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators outlet"
      annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={-20,-14})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=90,
          origin={20,-14})));
    Modelica.Blocks.Sources.RealExpression supHea(y=senTemOut.T - senTemInl.T)
      "Current superheating" annotation (Placement(transformation(
          extent={{-8,-9},{8,9}},
          rotation=90,
          origin={-20,-33})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-5,-6},{5,6}},
          rotation=-90,
          origin={20,15})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={20,34})));
  equation
    // Connection of main components
    //

    connect(sourceHP.ports[1], cond.port_a2) annotation (Line(points={{70,20},{70,
            30},{70,64.6},{11,64.6}},         color={0,127,255}));
    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    connect(cond.port_b2, tan.port_a) annotation (Line(points={{-11,55.4},{-70,55.4},
            {-70,50}}, color={0,127,255}));
    connect(tan.port_b, modExpVal.port_a)
      annotation (Line(points={{-70,30},{-70,25},{-70,20}}, color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a)
      annotation (Line(points={{-70,-20},{-70,-30}}, color={0,127,255}));
    connect(modExpVal.dataBus, datBus) annotation (Line(
        points={{-50,-3.55271e-015},{-41,-3.55271e-015},{-41,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(preOpe.y,repPreOpe. u)
      annotation (Line(points={{-20,27.4},{-20,27.4},{-20,21.2}},
                                                              color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,7.4},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(sourceEV.ports[1], eva.port_a1) annotation (Line(points={{80,-80},{20,
            -80},{20,-60.2},{11,-60.2}}, color={0,127,255}));
    connect(eva.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-60.2},{-20,
            -60.2},{-20,-80},{-80,-80}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, senTemInl.port_a) annotation (Line(points={
            {-70,-50},{-70,-60},{-60,-60}}, color={0,127,255}));
    connect(senTemInl.port_b, eva.port_a2) annotation (Line(points={{-40,-60},{-30.5,
            -60},{-30.5,-64.6},{-11,-64.6}}, color={0,127,255}));
    connect(sinkHP.ports[1], senTemOut.port_b)
      annotation (Line(points={{70,-20},{70,-60},{60,-60}}, color={0,127,255}));
    connect(senTemOut.port_a, eva.port_b2) annotation (Line(points={{40,-60},{30,-60},
            {30,-55.4},{11,-55.4}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -7.4},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                       color={0,0,127}));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-7.4},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(heaCapHP.y, repCurHeaCap.u) annotation (Line(points={{20,-24.2},{20,-24.2},
            {20,-21.2}}, color={0,0,127}));
    connect(repTSup.u, supHea.y) annotation (Line(points={{-20,-21.2},{-20,-21.2},
            {-20,-24.2}}, color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{20,9.5},
            {20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},       color={0,0,127}));
    connect(repSetHeaCap.u, setHeaCap.y)
      annotation (Line(points={{20,21},{20,21},{20,27.4}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.intSetPoiVal) annotation (Line(points={{
            -20,7.4},{-20,7.4},{-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.extManVarCom) annotation (Line(points={{
            20,9.5},{20,9.5},{20,4},{20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S4_Evaporator;

  model S4_1_Evaporator
    "Model that describes evaporation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(253.15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 1
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    parameter Integer nVal=1
      "Number of valves - each valve will be connected to an individual port_b";
    parameter Integer nCom=1
      "Number of valves - each valve will be connected to an individual port_b";

    // Definition of subcomponents
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={70,10})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={70,-10})));

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      nNodes=1,
      area_h_1=cond.length*cond.perimeter_1,
      area_h_2=cond.length*cond.perimeter_2,
      length=20/3,
      perimeter_1=0.075,
      perimeter_2=0.075,
      Twall_start=323.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=3200000,
      p_b_start2=3200000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Sources.RealExpression heaCapHP(
      y=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-8,-9},{8,9}},
          rotation=90,
          origin={20,-33})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      risTim={5},
      calcProc={AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      useExt=true,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.9},
      yMin={0.25},
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_start=0.02,
      tau=5,
      initTypeSen=Modelica.Blocks.Types.Init.NoInit,
      AVal={1.32e-6},
      dp_start=2500000,
      dp_nominal=2100000,
      m_flow_nominal=0.02,
      show_parVal=true,
      show_parCon=true,
      show_parSen=true)                              "Modular expansion valves"
      annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-70,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(nVal=nVal, redeclare
        package
        Medium = MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-70,-40})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(nVal=nVal, nCom=nCom)
                                                                    "Data Bus"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.9)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,34})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=nVal)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,14})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX eva(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      use_T_start=true,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      nNodes=1,
      m_flow_start_1=m_flow_source_EV,
      T_start_1=TSouEV,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=12000),
      length=20/3,
      area_h_1=eva.length*eva.perimeter_1,
      area_h_2=eva.length*eva.perimeter_2,
      Twall_start=268.15,
      dT=293.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=400000,
      p_b_start2=400000,
      T_start_2=254.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-90,-80})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators inlet"
      annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
    Sensors.TemperatureTwoPort senTemOut(
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators outlet"
      annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={-20,-14})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=90,
          origin={20,-14})));
    Modelica.Blocks.Sources.RealExpression supHea(y=senTemOut.T - senTemInl.T)
      "Current superheating" annotation (Placement(transformation(
          extent={{-8,-9},{8,9}},
          rotation=90,
          origin={-20,-33})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-5,-6},{5,6}},
          rotation=-90,
          origin={20,15})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={20,34})));
    Modelica.Blocks.Sources.RealExpression COP(y=cond.Q_flow_1/(cond.Q_flow_1 +
          eva.Q_flow_1)) "Current COP" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,-30})));
  equation
    // Connection of main components
    //

    connect(sourceHP.ports[1], cond.port_a2) annotation (Line(points={{70,20},{70,
            30},{70,64.6},{11,64.6}},         color={0,127,255}));
    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a)
      annotation (Line(points={{-70,-20},{-70,-30}}, color={0,127,255}));
    connect(modExpVal.dataBus, datBus) annotation (Line(
        points={{-50,-3.55271e-015},{-41,-3.55271e-015},{-41,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(preOpe.y,repPreOpe. u)
      annotation (Line(points={{-20,27.4},{-20,27.4},{-20,21.2}},
                                                              color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,7.4},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(sourceEV.ports[1], eva.port_a1) annotation (Line(points={{80,-80},{20,
            -80},{20,-60.2},{11,-60.2}}, color={0,127,255}));
    connect(eva.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-60.2},{-20,
            -60.2},{-20,-80},{-80,-80}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, senTemInl.port_a) annotation (Line(points={
            {-70,-50},{-70,-60},{-60,-60}}, color={0,127,255}));
    connect(senTemInl.port_b, eva.port_a2) annotation (Line(points={{-40,-60},{-30.5,
            -60},{-30.5,-64.6},{-11,-64.6}}, color={0,127,255}));
    connect(sinkHP.ports[1], senTemOut.port_b)
      annotation (Line(points={{70,-20},{70,-60},{60,-60}}, color={0,127,255}));
    connect(senTemOut.port_a, eva.port_b2) annotation (Line(points={{40,-60},{30,-60},
            {30,-55.4},{11,-55.4}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -7.4},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                       color={0,0,127}));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-7.4},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(heaCapHP.y, repCurHeaCap.u) annotation (Line(points={{20,-24.2},{20,-24.2},
            {20,-21.2}}, color={0,0,127}));
    connect(repTSup.u, supHea.y) annotation (Line(points={{-20,-21.2},{-20,-21.2},
            {-20,-24.2}}, color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{20,9.5},
            {20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},       color={0,0,127}));
    connect(repSetHeaCap.u, setHeaCap.y)
      annotation (Line(points={{20,21},{20,21},{20,27.4}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.intSetPoiVal) annotation (Line(points={{
            -20,7.4},{-20,7.4},{-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.extManVarCom) annotation (Line(points={{
            20,9.5},{20,9.5},{20,4},{20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(modExpVal.port_a, cond.port_b2) annotation (Line(points={{-70,20},{-70,
            55.4},{-11,55.4}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S4_1_Evaporator;

  model S5_Compressor
    "Model that describes compression of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(253.15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 1
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    parameter Integer nVal=1
      "Number of valves - each valve will be connected to an individual port_b";
    parameter Integer nCom=1
      "Number of valves - each valve will be connected to an individual port_b";

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      length=1,
      nNodes=1,
      Twall_start=333.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=2700000,
      p_b_start2=2700000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Sources.RealExpression heaCapHP(
      y=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-8,-9},{8,9}},
          rotation=90,
          origin={20,-33})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      VTanInn=4e-3,
      useHeatLoss=false,
      allowFlowReversal=true,
      m_flow_start_a=0.02,
      m_flow_start_b=0.02,
      hTan0=385e3,
      m_flow_nominal=0.04,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      dp_start=23,
      pTan0=2700000)
      "Tank (two-phase separator) of the working fluid"
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      risTim={5},
      calcProc={AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      useExt=true,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.9},
      yMin={0.25},
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_start=0.02,
      tau=5,
      initTypeSen=Modelica.Blocks.Types.Init.NoInit,
      AVal={1.32e-6})                                "Modular expansion valves"
      annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-70,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(nVal=nVal, redeclare
        package Medium =
                 MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-70,-40})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(nVal=nVal, nCom=nCom)
                                                                    "Data Bus"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.9)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,34})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=nVal)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,14})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX eva(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      length=1,
      nNodes=1,
      m_flow_start_1=m_flow_source_EV,
      T_start_1=TSouEV - 2.5,
      Twall_start=273.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=400000,
      p_b_start2=400000,
      T_start_2=254.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-90,-80})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators inlet"
      annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
    Sensors.TemperatureTwoPort senTemOut(
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators outlet"
      annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={-20,-14})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=90,
          origin={20,-14})));
    Modelica.Blocks.Sources.RealExpression supHea(y=senTemOut.T - senTemInl.T)
      "Current superheating" annotation (Placement(transformation(
          extent={{-8,-9},{8,9}},
          rotation=90,
          origin={-20,-33})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-5,-6},{5,6}},
          rotation=-90,
          origin={20,15})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      freqHz=1/3200,
      amplitude=0,
      offset=60)   annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={20,34})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={15},
      k={0.1},
      nCom=nCom,
      useExt=true,
      m_flow_start=0.02,
      m_flow_nominal=0.04,
      tau=5)     annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={70,0})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=90,
          origin={90,30})));
  equation
    // Connection of main components
    //

    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    connect(cond.port_b2, tan.port_a) annotation (Line(points={{-11,55.4},{-70,55.4},
            {-70,50}}, color={0,127,255}));
    connect(tan.port_b, modExpVal.port_a)
      annotation (Line(points={{-70,30},{-70,25},{-70,20}}, color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a)
      annotation (Line(points={{-70,-20},{-70,-30}}, color={0,127,255}));
    connect(modExpVal.dataBus, datBus) annotation (Line(
        points={{-50,-3.55271e-015},{-41,-3.55271e-015},{-41,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(preOpe.y,repPreOpe. u)
      annotation (Line(points={{-20,27.4},{-20,27.4},{-20,21.2}},
                                                              color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,7.4},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(sourceEV.ports[1], eva.port_a1) annotation (Line(points={{80,-80},{20,
            -80},{20,-60.2},{11,-60.2}}, color={0,127,255}));
    connect(eva.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-60.2},{-20,
            -60.2},{-20,-80},{-80,-80}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, senTemInl.port_a) annotation (Line(points={
            {-70,-50},{-70,-60},{-60,-60}}, color={0,127,255}));
    connect(senTemInl.port_b, eva.port_a2) annotation (Line(points={{-40,-60},{-30.5,
            -60},{-30.5,-64.6},{-11,-64.6}}, color={0,127,255}));
    connect(senTemOut.port_a, eva.port_b2) annotation (Line(points={{40,-60},{30,-60},
            {30,-55.4},{11,-55.4}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -7.4},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                       color={0,0,127}));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-7.4},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(heaCapHP.y, repCurHeaCap.u) annotation (Line(points={{20,-24.2},{20,-24.2},
            {20,-21.2}}, color={0,0,127}));
    connect(repTSup.u, supHea.y) annotation (Line(points={{-20,-21.2},{-20,-21.2},
            {-20,-24.2}}, color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{20,9.5},
            {20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},       color={0,0,127}));
    connect(repSetHeaCap.u, setHeaCap.y)
      annotation (Line(points={{20,21},{20,21},{20,27.4}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.intSetPoiVal) annotation (Line(points={{
            -20,7.4},{-20,7.4},{-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.extManVarCom) annotation (Line(points={{
            20,9.5},{20,9.5},{20,4},{20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{60,-60},{70,-60},{70,-20}}, color={0,127,255}));
    connect(datBus, modCom.dataBus) annotation (Line(
        points={{0,0},{26,0},{50,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modCom.port_b, cond.port_a2)
      annotation (Line(points={{70,20},{70,64.6},{11,64.6}}, color={0,127,255}));
    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{90,20},{90,20},{90,0}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S5_Compressor;

  model S5_1_Compressor
    "Model that describes compression of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(253.15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 1*1000/3600
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 1*1000/3600
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    parameter Integer nVal=1
      "Number of valves - each valve will be connected to an individual port_b";
    parameter Integer nCom=1
      "Number of valves - each valve will be connected to an individual port_b";

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      length=1,
      area_h_1=3,
      area_h_2=3,
      nNodes=1,
      Twall_start=333.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=2700000,
      p_b_start2=2700000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Sources.RealExpression heaCapHP(
      y=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-8,-9},{8,9}},
          rotation=90,
          origin={20,-33})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      risTim={5},
      calcProc={AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_start=0.02,
      tau=5,
      initTypeSen=Modelica.Blocks.Types.Init.NoInit,
      yMax={1},
      yMin={0.01},
      useExt=true)                                   "Modular expansion valves"
      annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-70,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(nVal=nVal, redeclare
        package
        Medium = MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-70,-40})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(nVal=nVal, nCom=nCom)
                                                                    "Data Bus"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.5)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,34})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=nVal)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,14})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX eva(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      nNodes=1,
      m_flow_start_1=m_flow_source_EV,
      T_start_1=TSouEV - 2.5,
      length=10,
      Twall_start=273.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=400000,
      p_b_start2=400000,
      T_start_2=254.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-90,-80})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators inlet"
      annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
    Sensors.TemperatureTwoPort senTemOut(
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators outlet"
      annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={-20,-14})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=90,
          origin={20,-14})));
    Modelica.Blocks.Sources.RealExpression supHea(y=senTemOut.T - senTemInl.T)
      "Current superheating" annotation (Placement(transformation(
          extent={{-8,-9},{8,9}},
          rotation=90,
          origin={-20,-33})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-5,-6},{5,6}},
          rotation=-90,
          origin={20,15})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      freqHz=1/3200,
      amplitude=500,
      offset=1250) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={20,34})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={15},
      nCom=nCom,
      m_flow_start=0.02,
      m_flow_nominal=0.04,
      tau=5,
      useExt=false,
      k={0.25},
      Ti={0.001},
      controllerType={Modelica.Blocks.Types.SimpleController.P})
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={70,0})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=90,
          origin={90,30})));
  equation
    // Connection of main components
    //

    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a)
      annotation (Line(points={{-70,-20},{-70,-30}}, color={0,127,255}));
    connect(modExpVal.dataBus, datBus) annotation (Line(
        points={{-50,-3.55271e-015},{-41,-3.55271e-015},{-41,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(preOpe.y,repPreOpe. u)
      annotation (Line(points={{-20,27.4},{-20,27.4},{-20,21.2}},
                                                              color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,7.4},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(sourceEV.ports[1], eva.port_a1) annotation (Line(points={{80,-80},{20,
            -80},{20,-60.2},{11,-60.2}}, color={0,127,255}));
    connect(eva.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-60.2},{-20,
            -60.2},{-20,-80},{-80,-80}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, senTemInl.port_a) annotation (Line(points={
            {-70,-50},{-70,-60},{-60,-60}}, color={0,127,255}));
    connect(senTemInl.port_b, eva.port_a2) annotation (Line(points={{-40,-60},{-30.5,
            -60},{-30.5,-64.6},{-11,-64.6}}, color={0,127,255}));
    connect(senTemOut.port_a, eva.port_b2) annotation (Line(points={{40,-60},{30,-60},
            {30,-55.4},{11,-55.4}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -7.4},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                       color={0,0,127}));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-7.4},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(heaCapHP.y, repCurHeaCap.u) annotation (Line(points={{20,-24.2},{20,-24.2},
            {20,-21.2}}, color={0,0,127}));
    connect(repTSup.u, supHea.y) annotation (Line(points={{-20,-21.2},{-20,-21.2},
            {-20,-24.2}}, color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{20,9.5},
            {20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},       color={0,0,127}));
    connect(repSetHeaCap.u, setHeaCap.y)
      annotation (Line(points={{20,21},{20,21},{20,27.4}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.intSetPoiVal) annotation (Line(points={{
            -20,7.4},{-20,7.4},{-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.extManVarCom) annotation (Line(points={{
            20,9.5},{20,9.5},{20,4},{20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{60,-60},{70,-60},{70,-20}}, color={0,127,255}));
    connect(datBus, modCom.dataBus) annotation (Line(
        points={{0,0},{26,0},{50,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modCom.port_b, cond.port_a2)
      annotation (Line(points={{70,20},{70,64.6},{11,64.6}}, color={0,127,255}));
    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{90,20},{90,20},{90,0}}, color={191,0,0}));
    connect(modExpVal.port_a, cond.port_b2) annotation (Line(points={{-70,20},{-70,
            20},{-70,28},{-70,55.4},{-11,55.4}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S5_1_Compressor;

  model S5_2_Compressor
    "Model that describes compression of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ThermoCycle.Media.R410a
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    // ThermoCycle.Media.R410a
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(253.15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 1*1000/3600
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 1*1000/3600
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    parameter Integer nVal=1
      "Number of valves - each valve will be connected to an individual port_b";
    parameter Integer nCom=1
      "Number of valves - each valve will be connected to an individual port_b";

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Sources.RealExpression heaCapHP(
      y=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-8,-9},{8,9}},
          rotation=90,
          origin={20,-33})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      risTim={5},
      calcProc={AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_start=0.02,
      tau=5,
      initTypeSen=Modelica.Blocks.Types.Init.NoInit,
      yMax={1},
      yMin={0.01},
      useExt=true)                                   "Modular expansion valves"
      annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-70,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(nVal=nVal, redeclare
        package
        Medium = MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-70,-40})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(nVal=nVal, nCom=nCom)
                                                                    "Data Bus"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant preOpe(k=1)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,34})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=nVal)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,14})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX eva(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      use_T_start=true,
      area_h_1=1.5,
      area_h_2=1.5,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      nNodes=1,
      m_flow_start_1=m_flow_source_EV,
      T_start_1=TSouEV - 2.5,
      length=10,
      Twall_start=273.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=400000,
      p_b_start2=400000,
      T_start_2=254.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-90,-80})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators inlet"
      annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
    Sensors.TemperatureTwoPort senTemOut(
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators outlet"
      annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={-20,-14})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=90,
          origin={20,-14})));
    Modelica.Blocks.Sources.RealExpression supHea(y=senTemOut.T - senTemInl.T)
      "Current superheating" annotation (Placement(transformation(
          extent={{-8,-9},{8,9}},
          rotation=90,
          origin={-20,-33})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-5,-6},{5,6}},
          rotation=-90,
          origin={20,15})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      freqHz=1/3200,
      amplitude=500,
      offset=1250) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={20,34})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={15},
      nCom=nCom,
      m_flow_start=0.02,
      m_flow_nominal=0.04,
      tau=5,
      useExt=false,
      k={0.25},
      Ti={0.001},
      controllerType={Modelica.Blocks.Types.SimpleController.P})
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={70,0})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=90,
          origin={90,30})));
    ThermoCycle.Components.Units.HeatExchangers.Hx1DInc con(redeclare package
        Medium1 = MediumHP, redeclare package Medium2 = MediumCO,
      Nt=1,
      A_sf=1,
      A_wf=1,
      M_wall=4,
      Unom_sf=250,
      Unom_l=8000,
      Unom_tp=12000,
      Unom_v=5000,
      Mdotnom_sf=0.2,
      Mdotnom_wf=0.02,
      N=2,
      pstart_wf=2700000,
      Tstart_inlet_wf=333.15,
      Tstart_outlet_wf=325.15,
      Tstart_inlet_sf=303.15,
      Tstart_outlet_sf=308.15)
      annotation (Placement(transformation(extent={{14,48},{-12,74}})));
  equation
    // Connection of main components
    //

    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a)
      annotation (Line(points={{-70,-20},{-70,-30}}, color={0,127,255}));
    connect(modExpVal.dataBus, datBus) annotation (Line(
        points={{-50,-3.55271e-015},{-41,-3.55271e-015},{-41,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(preOpe.y,repPreOpe. u)
      annotation (Line(points={{-20,27.4},{-20,27.4},{-20,21.2}},
                                                              color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,7.4},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(sourceEV.ports[1], eva.port_a1) annotation (Line(points={{80,-80},{20,
            -80},{20,-60.2},{11,-60.2}}, color={0,127,255}));
    connect(eva.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-60.2},{-20,
            -60.2},{-20,-80},{-80,-80}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, senTemInl.port_a) annotation (Line(points={
            {-70,-50},{-70,-60},{-60,-60}}, color={0,127,255}));
    connect(senTemInl.port_b, eva.port_a2) annotation (Line(points={{-40,-60},{-30.5,
            -60},{-30.5,-64.6},{-11,-64.6}}, color={0,127,255}));
    connect(senTemOut.port_a, eva.port_b2) annotation (Line(points={{40,-60},{30,-60},
            {30,-55.4},{11,-55.4}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -7.4},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                       color={0,0,127}));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-7.4},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(heaCapHP.y, repCurHeaCap.u) annotation (Line(points={{20,-24.2},{20,-24.2},
            {20,-21.2}}, color={0,0,127}));
    connect(repTSup.u, supHea.y) annotation (Line(points={{-20,-21.2},{-20,-21.2},
            {-20,-24.2}}, color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{20,9.5},
            {20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},       color={0,0,127}));
    connect(repSetHeaCap.u, setHeaCap.y)
      annotation (Line(points={{20,21},{20,21},{20,27.4}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.intSetPoiVal) annotation (Line(points={{
            -20,7.4},{-20,7.4},{-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.extManVarCom) annotation (Line(points={{
            20,9.5},{20,9.5},{20,4},{20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{60,-60},{70,-60},{70,-20}}, color={0,127,255}));
    connect(datBus, modCom.dataBus) annotation (Line(
        points={{0,0},{26,0},{50,0}},
        color={255,204,51},
        thickness=0.5));
    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{90,20},{90,20},{90,0}}, color={191,0,0}));
    connect(con.inlet_fl1, modCom.port_b) annotation (Line(points={{11,56},{26,56},
            {70,56},{70,20}}, color={0,0,255}));
    connect(con.outlet_fl1, modExpVal.port_a) annotation (Line(points={{-9,56},{-24,
            56},{-70,56},{-70,20}}, color={0,0,255}));
    connect(speEntConInl.port_b, con.inlet_fl2) annotation (Line(points={{-26,80},
            {-20,80},{-20,67},{-8.8,67}}, color={0,127,255}));
    connect(con.outlet_fl2, speEntConOut.port_a) annotation (Line(points={{10.8,66.8},
            {20,66.8},{20,80},{40,80}}, color={0,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S5_2_Compressor;

  model S5_3_Compressor
    "Model that describes compression of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(253.15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 1
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    parameter Integer nVal=1
      "Number of valves - each valve will be connected to an individual port_b";
    parameter Integer nCom=1
      "Number of valves - each valve will be connected to an individual port_b";

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      nNodes=1,
      area_h_1=cond.length*cond.perimeter_1,
      area_h_2=cond.length*cond.perimeter_2,
      length=20/3,
      perimeter_1=0.075,
      perimeter_2=0.075,
      Twall_start=323.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=3200000,
      p_b_start2=3200000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Sources.RealExpression heaCapHP(
      y=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-8,-9},{8,9}},
          rotation=90,
          origin={20,-33})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      calcProc={AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.9},
      yMin={0.25},
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_start=0.02,
      tau=5,
      initTypeSen=Modelica.Blocks.Types.Init.NoInit,
      AVal={1.32e-6},
      m_flow_nominal=0.02,
      show_parVal=true,
      show_parCon=true,
      show_parSen=true,
      risTim={25},
      k={0.1},
      useExt=true,
      dp_start=2500000,
      dp_nominal=2100000)                            "Modular expansion valves"
      annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-70,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(nVal=nVal, redeclare
        package
        Medium = MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-70,-40})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(nVal=nVal, nCom=nCom)
                                                                    "Data Bus"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.5)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,34})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=nVal)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,14})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX eva(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      use_T_start=true,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      nNodes=1,
      m_flow_start_1=m_flow_source_EV,
      T_start_1=TSouEV,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=12000),
      area_h_1=eva.length*eva.perimeter_1,
      area_h_2=eva.length*eva.perimeter_2,
      length=2*20/3,
      Twall_start=268.15,
      dT=293.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=400000,
      p_b_start2=400000,
      T_start_2=254.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-90,-80})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators inlet"
      annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
    Sensors.TemperatureTwoPort senTemOut(
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators outlet"
      annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={-20,-14})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=90,
          origin={20,-14})));
    Modelica.Blocks.Sources.RealExpression supHea(y=senTemOut.T - senTemInl.T)
      "Current superheating" annotation (Placement(transformation(
          extent={{-8,-9},{8,9}},
          rotation=90,
          origin={-20,-33})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-5,-6},{5,6}},
          rotation=-90,
          origin={20,15})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={20,34})));
    Modelica.Blocks.Sources.RealExpression COP(y=cond.Q_flow_1/modCom.modCom[1].comPro.PEle)
                         "Current COP" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,-30})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      h_out_start=400e3,
      VDis={13e-6},
      nCom=nCom,
      m_flow_start=0.02,
      m_flow_nominal=0.04,
      tau=5,
      useExt=false,
      Ti={0.001},
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      risTim={25},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={70,0})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=90,
          origin={90,30})));
  equation
    // Connection of main components
    //

    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a)
      annotation (Line(points={{-70,-20},{-70,-30}}, color={0,127,255}));
    connect(modExpVal.dataBus, datBus) annotation (Line(
        points={{-50,-3.55271e-015},{-41,-3.55271e-015},{-41,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(preOpe.y,repPreOpe. u)
      annotation (Line(points={{-20,27.4},{-20,27.4},{-20,21.2}},
                                                              color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,7.4},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(sourceEV.ports[1], eva.port_a1) annotation (Line(points={{80,-80},{20,
            -80},{20,-60.2},{11,-60.2}}, color={0,127,255}));
    connect(eva.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-60.2},{-20,
            -60.2},{-20,-80},{-80,-80}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, senTemInl.port_a) annotation (Line(points={
            {-70,-50},{-70,-60},{-60,-60}}, color={0,127,255}));
    connect(senTemInl.port_b, eva.port_a2) annotation (Line(points={{-40,-60},{-30.5,
            -60},{-30.5,-64.6},{-11,-64.6}}, color={0,127,255}));
    connect(senTemOut.port_a, eva.port_b2) annotation (Line(points={{40,-60},{30,-60},
            {30,-55.4},{11,-55.4}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -7.4},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                       color={0,0,127}));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-7.4},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(heaCapHP.y, repCurHeaCap.u) annotation (Line(points={{20,-24.2},{20,-24.2},
            {20,-21.2}}, color={0,0,127}));
    connect(repTSup.u, supHea.y) annotation (Line(points={{-20,-21.2},{-20,-21.2},
            {-20,-24.2}}, color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{20,9.5},
            {20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},       color={0,0,127}));
    connect(repSetHeaCap.u, setHeaCap.y)
      annotation (Line(points={{20,21},{20,21},{20,27.4}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.intSetPoiVal) annotation (Line(points={{-20,7.4},
            {-20,7.4},{-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.extManVarCom) annotation (Line(points={{
            20,9.5},{20,9.5},{20,4},{20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(ambTem.port,modCom. heatPort)
      annotation (Line(points={{90,20},{90,20},{90,0}}, color={191,0,0}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{60,-60},{70,-60},{70,-20}}, color={0,127,255}));
    connect(modCom.port_b, cond.port_a2)
      annotation (Line(points={{70,20},{70,64.6},{11,64.6}}, color={0,127,255}));
    connect(datBus, modCom.dataBus) annotation (Line(
        points={{0,0},{25,0},{50,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.port_a, cond.port_b2) annotation (Line(points={{-70,20},{
            -70,55.4},{-11,55.4}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S5_3_Compressor;

  model S5_3_1_Compressor
    "Model that describes compression of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(253.15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.02
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.27
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 0.22
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    parameter Integer nVal=1
      "Number of valves - each valve will be connected to an individual port_b";
    parameter Integer nCom=1
      "Number of valves - each valve will be connected to an individual port_b";

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Sources.Boundary_ph sinkCO(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,80})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX cond(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=8000),
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      m_flow_start_1=m_flow_source_CO,
      T_start_1=TSouCO - 2.5,
      use_T_start=true,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      area_h_1=cond.length*cond.perimeter_1,
      area_h_2=cond.length*cond.perimeter_2,
      length=20/3,
      perimeter_1=0.075,
      perimeter_2=0.075,
      nNodes=2,
      Twall_start=323.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=3200000,
      p_b_start2=3200000,
      T_start_2=343.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{-10,70},{10,50}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-10,76},{10,96}})));
    Sensors.MassFlowRate mFloCon(redeclare package Medium = MediumCO,
        allowFlowReversal=true) "Mass flow rate sensor of condenser"
      annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConInl(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at inlet"
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Sensors.SpecificEnthalpyTwoPort speEntConOut(
      redeclare package Medium = MediumCO,
      allowFlowReversal=true,
      m_flow_nominal=1,
      m_flow_small=1e-6,
      initType=Modelica.Blocks.Types.Init.InitialState,
      tau=5,
      h_out_start=145e3)
      "Specific enthalpy sensor of condenser at outlet"
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Modelica.Blocks.Sources.RealExpression heaCapHP(
      y=mFloCon.m_flow*(speEntConOut.h_out - speEntConInl.h_out))
      "Current heat capacity delivered by heat pump"
      annotation (Placement(transformation(extent={{-8,-9},{8,9}},
          rotation=90,
          origin={20,-33})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      calcProc={AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.9},
      yMin={0.25},
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_start=0.02,
      tau=5,
      initTypeSen=Modelica.Blocks.Types.Init.NoInit,
      AVal={1.32e-6},
      m_flow_nominal=0.02,
      show_parVal=true,
      show_parCon=true,
      show_parSen=true,
      risTim={25},
      k={0.1},
      useExt=true,
      dp_start=2500000,
      dp_nominal=2100000)                            "Modular expansion valves"
      annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-70,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(nVal=nVal, redeclare
        package
        Medium = MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-70,-40})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(nVal=nVal, nCom=nCom)
                                                                    "Data Bus"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant preOpe(k=1)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-18,34})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=nVal)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-20,14})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX eva(
      redeclare package Medium_1 = MediumCO,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=Modelica.Constants.pi*0.075^2/4,
      perimeter_1=0.075,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_2=Modelica.Constants.pi*0.075^2/4,
      perimeter_2=0.075,
      k_wall=100,
      c_wall=500,
      rho_wall=8000,
      allowFlowReversal=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      redeclare model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=1),
      redeclare model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal(displayUnit="Pa") = 5, m_flow_nominal=0.5),
      use_T_start=true,
      s_wall=0.001/3,
      m_flow_start_2=0.02,
      nNodes=1,
      m_flow_start_1=m_flow_source_EV,
      T_start_1=TSouEV,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=12000),
      area_h_1=eva.length*eva.perimeter_1,
      area_h_2=eva.length*eva.perimeter_2,
      length=1*20/3,
      Twall_start=268.15,
      dT=293.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=400000,
      p_b_start2=400000,
      T_start_2=254.15) "Condenser of the heat pump"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-90,-80})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators inlet"
      annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
    Sensors.TemperatureTwoPort senTemOut(
      redeclare package Medium = MediumHP,
      allowFlowReversal=true,
      m_flow_nominal=0.02,
      m_flow_small=1e-6) "Temperature sensor at evaporators outlet"
      annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={-20,-14})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=90,
          origin={20,-14})));
    Modelica.Blocks.Sources.RealExpression supHea(y=senTemOut.T - senTemInl.T)
      "Current superheating" annotation (Placement(transformation(
          extent={{-8,-9},{8,9}},
          rotation=90,
          origin={-20,-33})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=nCom)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-5,-6},{5,6}},
          rotation=-90,
          origin={20,15})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={20,34})));
    Modelica.Blocks.Sources.RealExpression COP(y=cond.Q_flow_1/modCom.modCom[1].comPro.PEle)
                         "Current COP" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,-30})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      h_out_start=400e3,
      VDis={13e-6},
      nCom=nCom,
      m_flow_start=0.02,
      m_flow_nominal=0.04,
      tau=5,
      useExt=false,
      Ti={0.001},
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      risTim={25},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={70,0})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=90,
          origin={90,30})));
    Storage.ExpansionVessel exp(
      redeclare package Medium = MediumHP,
      p_start=2700000,
      T_start=423.15,
      V_start(displayUnit="l") = 1)
      annotation (Placement(transformation(extent={{40,40},{60,60}})));
  equation
    // Connection of main components
    //

    connect(sourceCO.ports[1], mFloCon.port_a)
      annotation (Line(points={{-80,80},{-74,80}}, color={0,127,255}));
    connect(mFloCon.port_b, speEntConInl.port_a)
      annotation (Line(points={{-54,80},{-46,80}}, color={0,127,255}));
    connect(speEntConInl.port_b, cond.port_a1) annotation (Line(points={{-26,80},{
            -20,80},{-20,60.2},{-11,60.2}}, color={0,127,255}));
    connect(sinkCO.ports[1], speEntConOut.port_b) annotation (Line(points={{80,80},
            {70,80},{60,80}},         color={0,127,255}));
    connect(speEntConOut.port_a, cond.port_b1) annotation (Line(points={{40,80},{20,
            80},{20,60.2},{11,60.2}}, color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a)
      annotation (Line(points={{-70,-20},{-70,-30}}, color={0,127,255}));
    connect(modExpVal.dataBus, datBus) annotation (Line(
        points={{-50,-3.55271e-015},{-41,-3.55271e-015},{-41,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(preOpe.y,repPreOpe. u)
      annotation (Line(points={{-18,27.4},{-20,27.4},{-20,21.2}},
                                                              color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,7.4},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(sourceEV.ports[1], eva.port_a1) annotation (Line(points={{80,-80},{20,
            -80},{20,-60.2},{11,-60.2}}, color={0,127,255}));
    connect(eva.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-60.2},{-20,
            -60.2},{-20,-80},{-80,-80}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, senTemInl.port_a) annotation (Line(points={
            {-70,-50},{-70,-60},{-60,-60}}, color={0,127,255}));
    connect(senTemInl.port_b, eva.port_a2) annotation (Line(points={{-40,-60},{-30.5,
            -60},{-30.5,-64.6},{-11,-64.6}}, color={0,127,255}));
    connect(senTemOut.port_a, eva.port_b2) annotation (Line(points={{40,-60},{30,-60},
            {30,-55.4},{11,-55.4}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -7.4},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                       color={0,0,127}));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-7.4},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(heaCapHP.y, repCurHeaCap.u) annotation (Line(points={{20,-24.2},{20,-24.2},
            {20,-21.2}}, color={0,0,127}));
    connect(repTSup.u, supHea.y) annotation (Line(points={{-20,-21.2},{-20,-21.2},
            {-20,-24.2}}, color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{20,9.5},
            {20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},       color={0,0,127}));
    connect(repSetHeaCap.u, setHeaCap.y)
      annotation (Line(points={{20,21},{20,21},{20,27.4}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.intSetPoiVal) annotation (Line(points={{-20,7.4},
            {-20,7.4},{-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.extManVarCom) annotation (Line(points={{
            20,9.5},{20,9.5},{20,4},{20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
          color={0,0,127}));
    connect(ambTem.port,modCom. heatPort)
      annotation (Line(points={{90,20},{90,20},{90,0}}, color={191,0,0}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{60,-60},{70,-60},{70,-20}}, color={0,127,255}));
    connect(modCom.port_b, cond.port_a2)
      annotation (Line(points={{70,20},{70,64.6},{11,64.6}}, color={0,127,255}));
    connect(datBus, modCom.dataBus) annotation (Line(
        points={{0,0},{25,0},{50,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.port_a, cond.port_b2) annotation (Line(points={{-70,20},{-70,
            55.4},{-11,55.4}}, color={0,127,255}));
    connect(exp.port_a, modCom.port_b)
      annotation (Line(points={{50,40},{50,20},{70,20}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S5_3_1_Compressor;
end NewTry;
