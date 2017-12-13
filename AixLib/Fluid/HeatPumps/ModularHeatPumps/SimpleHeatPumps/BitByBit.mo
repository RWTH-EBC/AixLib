within AixLib.Fluid.HeatPumps.ModularHeatPumps.SimpleHeatPumps;
package BitByBit
  model S1_Condensation
    "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Actual medium of the heat exchanger";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{60,20},{40,40}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-70,30})));
    Sensors.TemperatureTwoPort senTem(
      redeclare package Medium = MediumHP,
      m_flow_nominal=m_flow_nominal_HP,
      T_start=TSouHP)
      "Sensor that meassures temperature behind condenser"
      annotation (Placement(transformation(extent={{-20,20},{-40,40}})));

    Movers.Compressors.Utilities.HeatTransfer.SimpleHeatTransfer condensation(
      kAMea=100,
      heaTraMod=AixLib.Fluid.Movers.Compressors.Utilities.Types.HeatTransferModels.Simplified,
      redeclare package Medium = MediumHP,
      show_T=true,
      m_flow_nominal=m_flow_nominal_HP)
      "Model that describes a simplified condensation process"
      annotation (Placement(transformation(extent={{8,40},{-12,20}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureSFCond(T=308.15)
      "Fixed temperature of secondary fluid of condenser"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));


  equation
    // Connection of main components
    //
    connect(sourceHP.ports[1], condensation.port_a)
      annotation (Line(points={{40,30},{8,30}}, color={0,127,255}));
    connect(temperatureSFCond.port, condensation.heatPort)
      annotation (Line(points={{-40,70},{-2,70},{-2,40}}, color={191,0,0}));
    connect(condensation.port_b, senTem.port_a)
      annotation (Line(points={{-12,30},{-20,30}}, color={0,127,255}));
    connect(senTem.port_b, sinkHP.ports[1])
      annotation (Line(points={{-40,30},{-60,30}}, color={0,127,255}));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S1_Condensation;

  model S2_Condensator
    "Model that describes condensation of working fluid by a condenser"
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
    // ExternalMedia.Examples.R134aCoolProp

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,70})));

    // Definition of subcomponents describing the working fluid
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{60,20},{40,40}})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-50,30})));


  equation
    // Connection of condenser
    //
    connect(sourceCO.ports[1], condenser.port_a1)
      annotation (Line(points={{-40,70},{-28,70},{-28,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], condenser.port_b1)
      annotation (Line(points={{40,70},{26,70},{26,42},{10,42}}, color={0,127,255}));

    // Connection of main components
    //
    connect(sourceHP.ports[1], condenser.port_a2)
      annotation (Line(points={{40,30},{10,30}}, color={0,127,255}));
    connect(condenser.port_b2, sinkHP.ports[1])
      annotation (Line(points={{-10,30},{-40,30}}, color={0,127,255}));


    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Condensator;

  model S3_ExpansionValve "Model that describes a expansion valve"
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
    // ExternalMedia.Examples.R134aCoolProp

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,70})));

    // Definition of subcomponents describing the working fluid
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{60,20},{40,40}})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={-50,-50})));
    Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve
      isenthalpicExpansionValve(
      useInpFil=false,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      redeclare package Medium = MediumHP,
      dp_start=1e6,
      m_flow_nominal=m_flow_nominal_HP,
      show_staOut=true,
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22)
      "Model of an expansion valve" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-10})));

    Modelica.Blocks.Sources.Sine openingValve(
      freqHz=1/3200,
      offset=0.50,
      amplitude=0.30)
      "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
  equation
    // Connection of condenser
    //
    connect(sourceCO.ports[1], condenser.port_a1)
      annotation (Line(points={{-40,70},{-28,70},{-28,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], condenser.port_b1)
      annotation (Line(points={{40,70},{26,70},{26,42},{10,42}}, color={0,127,255}));

    // Connection of main components
    //
    connect(sourceHP.ports[1], condenser.port_a2)
      annotation (Line(points={{40,30},{10,30}}, color={0,127,255}));

    connect(condenser.port_b2, isenthalpicExpansionValve.port_a)
      annotation (Line(points={{-10,30},{-50,30},{-50,0}}, color={0,127,255}));
    connect(isenthalpicExpansionValve.port_b, sinkHP.ports[1])
      annotation (Line(points={{-50,-20},{-50,-40}}, color={0,127,255}));
    connect(openingValve.y, isenthalpicExpansionValve.manVarVal) annotation (Line(
          points={{-21,-10},{-30,-10},{-30,-5},{-39.4,-5}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S3_ExpansionValve;

  model S31_ExpansionValveReceiver "Model that describes a expansion valve"
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
    // ExternalMedia.Examples.R134aCoolProp

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,70})));

    // Definition of subcomponents describing the working fluid
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{60,20},{40,40}})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={-50,-50})));
    Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve
      isenthalpicExpansionValve(
      useInpFil=false,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      redeclare package Medium = MediumHP,
      dp_start=1e6,
      m_flow_nominal=m_flow_nominal_HP,
      show_staOut=true,
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22)
      "Model of an expansion valve" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-10})));

    Modelica.Blocks.Sources.Sine openingValve(
      freqHz=1/3200,
      offset=0.50,
      amplitude=0.30)
      "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
    Storage.TwoPhaseSeparator twoPhaseSeparator(
      redeclare package Medium = MediumHP,
      VTanInn=0.010,
      pTan0=3000000)
      annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  equation
    // Connection of condenser
    //
    connect(sourceCO.ports[1], condenser.port_a1)
      annotation (Line(points={{-40,70},{-28,70},{-28,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], condenser.port_b1)
      annotation (Line(points={{40,70},{26,70},{26,42},{10,42}}, color={0,127,255}));

    // Connection of main components
    //
    connect(sourceHP.ports[1], condenser.port_a2)
      annotation (Line(points={{40,30},{10,30}}, color={0,127,255}));

    connect(isenthalpicExpansionValve.port_b, sinkHP.ports[1])
      annotation (Line(points={{-50,-20},{-50,-40}}, color={0,127,255}));
    connect(openingValve.y, isenthalpicExpansionValve.manVarVal) annotation (Line(
          points={{-21,-10},{-30,-10},{-30,-5},{-39.4,-5}}, color={0,0,127}));
    connect(isenthalpicExpansionValve.port_a, twoPhaseSeparator.port_b)
      annotation (Line(points={{-50,0},{-50,10}}, color={0,127,255}));
    connect(condenser.port_b2, twoPhaseSeparator.port_a)
      annotation (Line(points={{-10,30},{-50,30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S31_ExpansionValveReceiver;

  model S3_Evaporator "Model that describes a expansion valve"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Air
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

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 273.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));


    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = 0.5*m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = 0.5*m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 2.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,70})));

    // Definition of subcomponents describing the working fluid
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{60,20},{40,40}})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      nPorts=1,
      p=180000) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={50,-44})));
    Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve
      isenthalpicExpansionValve(
      useInpFil=false,
      redeclare package Medium = MediumHP,
      dp_start=1e6,
      m_flow_nominal=m_flow_nominal_HP,
      show_staOut=true,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,

      AVal=2.5e-5)
      "Model of an expansion valve" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-10})));

    Modelica.Blocks.Sources.Sine openingValve(
      freqHz=1/3200,
      offset=0.50,
      amplitude=0) "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV)
                     "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{12,-40},{-8,-60}})));
    Sources.MassFlowSource_T sourceEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    Sources.Boundary_ph sinkEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      p=pSouEV) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,-90})));
  equation
    // Connection of condenser
    //
    connect(sourceCO.ports[1], condenser.port_a1)
      annotation (Line(points={{-40,70},{-20,70},{-20,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], condenser.port_b1)
      annotation (Line(points={{40,70},{20,70},{20,42},{10,42}}, color={0,127,255}));

    // Connection of main components
    //
    connect(sourceHP.ports[1], condenser.port_a2)
      annotation (Line(points={{40,30},{10,30}}, color={0,127,255}));

    connect(condenser.port_b2, isenthalpicExpansionValve.port_a)
      annotation (Line(points={{-10,30},{-50,30},{-50,0}}, color={0,127,255}));
    connect(openingValve.y, isenthalpicExpansionValve.manVarVal) annotation (Line(
          points={{-21,-10},{-30,-10},{-30,-5},{-39.4,-5}}, color={0,0,127}));
    connect(isenthalpicExpansionValve.port_b, evaporatpr.port_a2) annotation (
        Line(points={{-50,-20},{-50,-44},{-8,-44}}, color={0,127,255}));
    connect(evaporatpr.port_b2, sinkHP.ports[1])
      annotation (Line(points={{12,-44},{40,-44}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-40,-90},
            {-20,-90},{-20,-56},{-8,-56}}, color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_a1) annotation (Line(points={{40,-90},
            {20,-90},{20,-56},{12,-56}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S3_Evaporator;

  model S31_EvaporatorFilter "Model that describes a expansion valve"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Air
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

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 273.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = 0.5*m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = 0.5*m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 2.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,70})));

    // Definition of subcomponents describing the working fluid
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{60,20},{40,40}})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=180000,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={72,-44})));
    Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve
      isenthalpicExpansionValve(
      useInpFil=false,
      redeclare package Medium = MediumHP,
      dp_start=1e6,
      m_flow_nominal=m_flow_nominal_HP,
      show_staOut=true,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,

      AVal=2.5e-5)
      "Model of an expansion valve" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-10})));

    Modelica.Blocks.Sources.Sine openingValve(
      freqHz=1/3200,
      offset=0.50,
      amplitude=0) "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV)
                     "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{12,-40},{-8,-60}})));
    Sources.MassFlowSource_T sourceEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    Sources.Boundary_ph sinkEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      p=pSouEV) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,-90})));
    Storage.TwoPhaseSeparator twoPhaseSeparator(
      redeclare package Medium = MediumHP,
      VTanInn=0.01,
      show_tankPropertiesDetailed=true) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={30,-44})));
  equation
    // Connection of condenser
    //
    connect(sourceCO.ports[1], condenser.port_a1)
      annotation (Line(points={{-40,70},{-20,70},{-20,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], condenser.port_b1)
      annotation (Line(points={{40,70},{20,70},{20,42},{10,42}}, color={0,127,255}));

    // Connection of main components
    //
    connect(sourceHP.ports[1], condenser.port_a2)
      annotation (Line(points={{40,30},{10,30}}, color={0,127,255}));

    connect(condenser.port_b2, isenthalpicExpansionValve.port_a)
      annotation (Line(points={{-10,30},{-50,30},{-50,0}}, color={0,127,255}));
    connect(openingValve.y, isenthalpicExpansionValve.manVarVal) annotation (Line(
          points={{-21,-10},{-30,-10},{-30,-5},{-39.4,-5}}, color={0,0,127}));
    connect(isenthalpicExpansionValve.port_b, evaporatpr.port_a2) annotation (
        Line(points={{-50,-20},{-50,-44},{-8,-44}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-40,-90},
            {-20,-90},{-20,-56},{-8,-56}}, color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_a1) annotation (Line(points={{40,-90},
            {20,-90},{20,-56},{12,-56}}, color={0,127,255}));
    connect(evaporatpr.port_b2, twoPhaseSeparator.port_b)
      annotation (Line(points={{12,-44},{20,-44}}, color={0,127,255}));
    connect(twoPhaseSeparator.port_a, sinkHP.ports[1])
      annotation (Line(points={{40,-44},{62,-44}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S31_EvaporatorFilter;

  model S4_Compressor "Model that describes a expansion valve"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Air
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

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 273.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = 0.5*m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = 0.5*m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 2.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,70})));

    // Definition of subcomponents describing the working fluid
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{80,22},{60,42}})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      nPorts=1,
      p=pSouHP) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={70,10})));
    Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve
      isenthalpicExpansionValve(
      useInpFil=false,
      redeclare package Medium = MediumHP,
      dp_start=1e6,
      m_flow_nominal=m_flow_nominal_HP,
      show_staOut=true,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,

      AVal=2.5e-5)
      "Model of an expansion valve" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-10})));

    Modelica.Blocks.Sources.Sine openingValve(
      freqHz=1/3200,
      offset=0.50,
      amplitude=0) "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV)
                     "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{12,-40},{-8,-60}})));
    Sources.MassFlowSource_T sourceEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    Sources.Boundary_ph sinkEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      p=pSouEV) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,-90})));
    Storage.TwoPhaseSeparator twoPhaseSeparator(
      redeclare package Medium = MediumHP,
      VTanInn=0.01,
      show_tankPropertiesDetailed=true) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={30,-44})));
    Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor
      rotaryCompressor(
      redeclare package Medium = MediumHP,
      useInpFil=false,
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.ConstantEfficiency,

      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.ConstantEfficiency,

      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.ConstantEfficiency,

      dp_start=-10e5,
      m_flow_nominal=m_flow_nominal_HP,
      show_staEff=true,
      show_qua=true,
      VDis=50e-6,
      pInl0=180000,
      TInl0=273.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,-10})));
    Modelica.Blocks.Sources.Sine rotSpe(
      freqHz=1/3200,
      amplitude=0,
      offset=60) "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{6,-20},{26,0}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          TSouEV)
      annotation (Placement(transformation(extent={{100,-20},{80,0}})));
  equation
    // Connection of condenser
    //
    connect(sourceCO.ports[1], condenser.port_a1)
      annotation (Line(points={{-40,70},{-20,70},{-20,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], condenser.port_b1)
      annotation (Line(points={{40,70},{20,70},{20,42},{10,42}}, color={0,127,255}));

    // Connection of main components
    //
    connect(sourceHP.ports[1], condenser.port_a2)
      annotation (Line(points={{60,32},{32,32},{32,30},{10,30}},
                                                 color={0,127,255}));

    connect(condenser.port_b2, isenthalpicExpansionValve.port_a)
      annotation (Line(points={{-10,30},{-50,30},{-50,0}}, color={0,127,255}));
    connect(openingValve.y, isenthalpicExpansionValve.manVarVal) annotation (Line(
          points={{-21,-10},{-30,-10},{-30,-5},{-39.4,-5}}, color={0,0,127}));
    connect(isenthalpicExpansionValve.port_b, evaporatpr.port_a2) annotation (
        Line(points={{-50,-20},{-50,-44},{-8,-44}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-40,-90},
            {-20,-90},{-20,-56},{-8,-56}}, color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_a1) annotation (Line(points={{40,-90},
            {20,-90},{20,-56},{12,-56}}, color={0,127,255}));
    connect(evaporatpr.port_b2, twoPhaseSeparator.port_b)
      annotation (Line(points={{12,-44},{20,-44}}, color={0,127,255}));
    connect(twoPhaseSeparator.port_a, rotaryCompressor.port_a) annotation (Line(
          points={{40,-44},{50,-44},{50,-20}}, color={0,127,255}));
    connect(rotaryCompressor.port_b, sinkHP.ports[1])
      annotation (Line(points={{50,0},{50,10},{60,10}}, color={0,127,255}));
    connect(rotSpe.y, rotaryCompressor.manVarCom) annotation (Line(points={{27,
            -10},{32,-10},{32,-16},{40,-16}}, color={0,0,127}));
    connect(fixedTemperature.port, rotaryCompressor.heatPort)
      annotation (Line(points={{80,-10},{60,-10}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S4_Compressor;

  model S5_Closed "Model that describes a expansion valve"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Air
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

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 273.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = 0.5*m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = 0.5*m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 2.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,70})));

    // Definition of subcomponents describing the working fluid
    //
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=1,
      dp2_nominal=1)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve
      isenthalpicExpansionValve(
      useInpFil=false,
      redeclare package Medium = MediumHP,
      m_flow_nominal=m_flow_nominal_HP,
      show_staOut=true,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      dp_start=0.5e6,
      AVal=8.5e-6)
      "Model of an expansion valve" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-10})));

    Modelica.Blocks.Sources.Sine openingValve(
      freqHz=1/3200,
      amplitude=0.25,
      offset=0.5)  "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV,
      dp1_nominal=1,
      dp2_nominal=1) "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{12,-40},{-8,-60}})));
    Sources.MassFlowSource_T sourceEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    Sources.Boundary_ph sinkEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      p=pSouEV) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,-90})));
    Storage.TwoPhaseSeparator twoPhaseSeparator(
      redeclare package Medium = MediumHP,
      show_tankPropertiesDetailed=true,
      m_flow_start_a=0.05,
      m_flow_start_b=-0.05,
      hTan0=400e3,
      VTanInn=0.015,
      pTan0=200000)
                   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={30,-44})));
    Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor
      rotaryCompressor(
      redeclare package Medium = MediumHP,
      useInpFil=false,
      dp_start=-10e5,
      m_flow_nominal=m_flow_nominal_HP,
      show_staEff=true,
      show_qua=true,
      m_flow_start=0.05,
      VDis=85e-6,
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.ConstantEfficiency,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.ConstantEfficiency,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.ConstantEfficiency,
      pInl0=200000,
      TInl0=273.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,-10})));

    Modelica.Blocks.Sources.Sine rotSpe(
      freqHz=1/3200,
      amplitude=0,
      offset=60) "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{6,-20},{26,0}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          TSouEV)
      annotation (Placement(transformation(extent={{100,-20},{80,0}})));
  equation
    // Connection of condenser
    //
    connect(sourceCO.ports[1], condenser.port_a1)
      annotation (Line(points={{-40,70},{-20,70},{-20,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], condenser.port_b1)
      annotation (Line(points={{40,70},{20,70},{20,42},{10,42}}, color={0,127,255}));

    // Connection of main components
    //

    connect(condenser.port_b2, isenthalpicExpansionValve.port_a)
      annotation (Line(points={{-10,30},{-50,30},{-50,0}}, color={0,127,255}));
    connect(openingValve.y, isenthalpicExpansionValve.manVarVal) annotation (Line(
          points={{-21,-10},{-30,-10},{-30,-5},{-39.4,-5}}, color={0,0,127}));
    connect(isenthalpicExpansionValve.port_b, evaporatpr.port_a2) annotation (
        Line(points={{-50,-20},{-50,-44},{-8,-44}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-40,-90},
            {-20,-90},{-20,-56},{-8,-56}}, color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_a1) annotation (Line(points={{40,-90},
            {20,-90},{20,-56},{12,-56}}, color={0,127,255}));
    connect(evaporatpr.port_b2, twoPhaseSeparator.port_b)
      annotation (Line(points={{12,-44},{20,-44}}, color={0,127,255}));
    connect(twoPhaseSeparator.port_a, rotaryCompressor.port_a)
      annotation (Line(points={{40,-44},{50,-44},{50,-20}}, color={0,127,255}));
    connect(rotSpe.y, rotaryCompressor.manVarCom) annotation (Line(points={{27,-10},
            {32,-10},{32,-16},{40,-16}}, color={0,0,127}));
    connect(fixedTemperature.port, rotaryCompressor.heatPort)
      annotation (Line(points={{80,-10},{60,-10}}, color={191,0,0}));
    connect(rotaryCompressor.port_b, condenser.port_a2)
      annotation (Line(points={{50,0},{50,30},{10,30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S5_Closed;

  model S51_Closed "Model that describes a expansion valve"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Air
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 273.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = 0.5*m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = 0.5*m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 2.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,70})));

    // Definition of subcomponents describing the working fluid
    //
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=1,
      dp2_nominal=1)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve
      isenthalpicExpansionValve(
      useInpFil=false,
      redeclare package Medium = MediumHP,
      m_flow_nominal=m_flow_nominal_HP,
      show_staOut=true,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      dp_start=0.5e6,
      AVal=2.5e-5)
      "Model of an expansion valve" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-10})));

    Modelica.Blocks.Sources.Sine openingValve(
      freqHz=1/3200,
      offset=0.5,
      amplitude=0.45)
                   "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV,
      dp1_nominal=1,
      dp2_nominal=1) "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{12,-40},{-8,-60}})));
    Sources.MassFlowSource_T sourceEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    Sources.Boundary_ph sinkEV(
      nPorts=1,
      redeclare package Medium = MediumEV,
      p=pSouEV) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,-90})));
    Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor
      rotaryCompressor(
      redeclare package Medium = MediumHP,
      useInpFil=false,
      dp_start=-10e5,
      m_flow_nominal=m_flow_nominal_HP,
      show_staEff=true,
      show_qua=true,
      m_flow_start=0.05,
      VDis=85e-6,
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.ConstantEfficiency,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.ConstantEfficiency,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.ConstantEfficiency,
      pInl0=200000,
      TInl0=273.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,-10})));

    Modelica.Blocks.Sources.Sine rotSpe(
      freqHz=1/3200,
      amplitude=0,
      offset=60) "Constant opening of expansion valve"
      annotation (Placement(transformation(extent={{6,-20},{26,0}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          TSouEV)
      annotation (Placement(transformation(extent={{100,-20},{80,0}})));
    WorkingVersion.Tank_pL tank_pL(
      redeclare package Medium = MediumHP,
      p_ng=0,
      Vtot=0.005,
      pstart=1600000)
      annotation (Placement(transformation(extent={{-60,8},{-40,28}})));
  equation
    // Connection of condenser
    //
    connect(sourceCO.ports[1], condenser.port_a1)
      annotation (Line(points={{-40,70},{-20,70},{-20,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], condenser.port_b1)
      annotation (Line(points={{40,70},{20,70},{20,42},{10,42}}, color={0,127,255}));

    // Connection of main components
    //

    connect(openingValve.y, isenthalpicExpansionValve.manVarVal) annotation (Line(
          points={{-21,-10},{-30,-10},{-30,-5},{-39.4,-5}}, color={0,0,127}));
    connect(isenthalpicExpansionValve.port_b, evaporatpr.port_a2) annotation (
        Line(points={{-50,-20},{-50,-44},{-8,-44}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-40,-90},
            {-20,-90},{-20,-56},{-8,-56}}, color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_a1) annotation (Line(points={{40,-90},
            {20,-90},{20,-56},{12,-56}}, color={0,127,255}));
    connect(rotSpe.y, rotaryCompressor.manVarCom) annotation (Line(points={{27,-10},
            {32,-10},{32,-16},{40,-16}}, color={0,0,127}));
    connect(fixedTemperature.port, rotaryCompressor.heatPort)
      annotation (Line(points={{80,-10},{60,-10}}, color={191,0,0}));
    connect(rotaryCompressor.port_b, condenser.port_a2)
      annotation (Line(points={{50,0},{50,30},{10,30}}, color={0,127,255}));
    connect(evaporatpr.port_b2, rotaryCompressor.port_a)
      annotation (Line(points={{12,-44},{50,-44},{50,-20}}, color={0,127,255}));
    connect(isenthalpicExpansionValve.port_a, tank_pL.OutFlow)
      annotation (Line(points={{-50,0},{-50,9.2}}, color={0,127,255}));
    connect(condenser.port_b2, tank_pL.InFlow) annotation (Line(points={{-10,30},{
            -50,30},{-50,26.4}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S51_Closed;

  model S51_Closed_TESTEr "Model that describes a expansion valve"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Air
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
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

    parameter Modelica.SIunits.Temperature TSouCO = 298.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 273.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = 0.5*m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = 0.5*m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents describing the condenser
    //
    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={90,70})));

    // Definition of subcomponents describing the working fluid
    //
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=1,
      dp2_nominal=1)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
    Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve
      isenthalpicExpansionValve(
      redeclare package Medium = MediumHP,
      m_flow_nominal=m_flow_nominal_HP,
      show_staOut=true,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      m_flow_start=0.01,
      AVal=9.99e-7,
      dp_start=1.75e6,
      useInpFil=true,
      risTim=5)
      "Model of an expansion valve" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-78,-10})));

    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV,
      dp1_nominal=1,
      dp2_nominal=1,
      m1_flow_small=1e-10,
      m2_flow_small=1e-10,
      homotopyInitialization=true)
                     "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{12,-40},{-8,-60}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-94,-96},{-74,-76}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={86,-80})));
    Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor
      rotaryCompressor(
      redeclare package Medium = MediumHP,
      dp_start=-10e5,
      m_flow_nominal=m_flow_nominal_HP,
      show_staEff=true,
      show_qua=true,
      m_flow_start=0.05,
      useInpFil=true,
      VDis=13e-6,
      risTim=25,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Poly_R407C_Unknown_Scroll,

      pInl0=400000,
      TInl0=278.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,-10})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          TSouEV)
      annotation (Placement(transformation(extent={{100,-20},{80,0}})));
    WorkingVersion.Tank_pL tank_pL(
      redeclare package Medium = MediumHP,
      p_ng=0,
      Vtot=0.005,
      pstart=2500000)
      annotation (Placement(transformation(extent={{-88,8},{-68,28}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-46,60},{-26,80}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{40,60},{60,80}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-72,60},{-52,80}})));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Real COP = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out)/rotaryCompressor.comPro.PEle;
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;
    Modelica.Blocks.Sources.RealExpression realExpression(y=Q_flow_H)
      annotation (Placement(transformation(extent={{-14,-26},{6,-6}})));
    Modelica.Blocks.Sources.Sine const(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000)
      annotation (Placement(transformation(extent={{-14,0},{6,20}})));
    Controls.Continuous.LimPID conPID(
      yMax=125,
      yMin=30,
      controllerType=Modelica.Blocks.Types.SimpleController.P)
                annotation (Placement(transformation(extent={{10,0},{30,20}})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{-52,-54},{-32,-34}})));
    Sensors.TemperatureTwoPort senTemOut(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{20,-54},{40,-34}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=TSup)
      annotation (Placement(transformation(extent={{-56,-32},{-36,-12}})));
    Modelica.Blocks.Sources.Constant const1(k=1)
      annotation (Placement(transformation(extent={{-66,2},{-46,22}})));
    Controls.Continuous.LimPID conPID1(
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMax=0.9,
      yMin=0.25)
                annotation (Placement(transformation(extent={{-42,2},{-22,22}})));
  equation
    // Connection of condenser
    //

    // Connection of main components
    //

    connect(fixedTemperature.port, rotaryCompressor.heatPort)
      annotation (Line(points={{80,-10},{60,-10}}, color={191,0,0}));
    connect(rotaryCompressor.port_b, condenser.port_a2)
      annotation (Line(points={{50,0},{50,30},{10,30}}, color={0,127,255}));
    connect(isenthalpicExpansionValve.port_a, tank_pL.OutFlow)
      annotation (Line(points={{-78,0},{-78,9.2}}, color={0,127,255}));
    connect(condenser.port_b2, tank_pL.InFlow) annotation (Line(points={{-10,30},{
            -78,30},{-78,26.4}}, color={0,127,255}));
    connect(senSpeEntInl.port_b, condenser.port_a1) annotation (Line(points={{-26,
            70},{-20,70},{-20,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{80,70},{60,70}}, color={0,127,255}));
    connect(senSpeEntOut.port_a, condenser.port_b1) annotation (Line(points={{40,70},
            {20,70},{20,42},{10,42}}, color={0,127,255}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-80,70},{-72,70}}, color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-52,70},{-46,70}}, color={0,127,255}));
    connect(rotaryCompressor.manVarCom, conPID.y) annotation (Line(points={{40,-16},
            {38,-16},{38,10},{31,10}}, color={0,0,127}));
    connect(const.y, conPID.u_s)
      annotation (Line(points={{7,10},{8,10}}, color={0,0,127}));
    connect(realExpression.y, conPID.u_m) annotation (Line(points={{7,-16},{14,-16},
            {14,-2},{20,-2}}, color={0,0,127}));
    connect(isenthalpicExpansionValve.port_b, senTemInl.port_a) annotation (Line(
          points={{-78,-20},{-78,-44},{-52,-44}}, color={0,127,255}));
    connect(senTemInl.port_b, evaporatpr.port_a2)
      annotation (Line(points={{-32,-44},{-8,-44}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-74,-86},
            {-66,-86},{-66,-90},{-14,-90},{-14,-56},{-8,-56}}, color={0,127,255}));
    connect(evaporatpr.port_b2, senTemOut.port_a)
      annotation (Line(points={{12,-44},{20,-44}}, color={0,127,255}));
    connect(senTemOut.port_b, rotaryCompressor.port_a)
      annotation (Line(points={{40,-44},{50,-44},{50,-20}}, color={0,127,255}));
    connect(evaporatpr.port_a1, sinkEV.ports[1]) annotation (Line(points={{12,-56},
            {16,-56},{16,-66},{20,-66},{20,-80},{76,-80}}, color={0,127,255}));
    connect(const1.y, conPID1.u_s)
      annotation (Line(points={{-45,12},{-44,12}}, color={0,0,127}));
    connect(realExpression1.y, conPID1.u_m) annotation (Line(points={{-35,-22},{-38,
            -22},{-38,0},{-32,0}}, color={0,0,127}));
    connect(conPID1.y, isenthalpicExpansionValve.manVarVal) annotation (Line(
          points={{-21,12},{-20,12},{-20,-5},{-67.4,-5}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S51_Closed_TESTEr;
  annotation (Documentation(info="<html>
<p>
As proposed by Quoilin et al..
</p>
<h4>References</h4>
<p>
Quoilin, Sylvain; Desideri, Adriano; Wronski, Jorrit;
Bell, Ian and Lemort, Vincent (2014):
<a href=\"http://www.ep.liu.se/ecp/096/072/ecp14096072.pdf\">
ThermoCycle: A Modelica library for the simulation of
thermodynamic systems</a>. In: <i>Proceedings of the 10th 
International Modelica Conference</i>; March 10-15; 2014; 
Lund; Sweden. Link&ouml;ping University Electronic Press, 
S. 683&ndash;692.
</p>
</html>"));
end BitByBit;
