within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialModularHeatExchangers
  "Base class for all models of modular moving boundary heat exchanger"

  // Definition of parameters describing modular approach
  //
  parameter Boolean useModPortsb_a = false
    "= true, if model uses 'ModularPort_a'; otherwise model uses simple ports"
    annotation (Dialog(tab="General",group="Modular approach"));
  parameter Integer nHeaExc = 1
    "Number of inlet and outlet ports"
    annotation(Dialog(tab="General",group="Modular approach"));

  // Definition of general parameters
  //
  parameter Utilities.Types.ApplicationHX appHX=
    Utilities.Types.ApplicationHX.Evaporator
    "Application of the heat exchangver (e.g. evaporator or condenser)"
    annotation (Dialog(tab="General",group="General"));
  parameter Utilities.Types.TypeHX typHX=
    Utilities.Types.TypeHX.CounterCurrent
    "Type of the heat exchangver (e.g. counter-current heat exchanger)"
    annotation (Dialog(tab="General",group="General"));

  inner replaceable parameter
    Utilities.Properties.GeometryHX geoCV[nHeaExc]
    "Record that contains geometric parameters of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="General"),
                Placement(transformation(extent={{-90,64},{-70,84}})));
  inner replaceable parameter
    Utilities.Properties.MaterialHX matHX[nHeaExc]
    "Record that contains parameters of the heat exchanger's material properties"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="General"),
                Placement(transformation(extent={{-90,36},{-70,56}})));

  replaceable package Medium1 =
    AixLib.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Secondary fluid in the component"
    annotation (Dialog(tab="General",group="General"),
                choicesAllMatching = true);
  replaceable package Medium2 =
    Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Working fluid in the component"
    annotation (Dialog(tab="General",group="General"),
                choicesAllMatching = true);

  // Definition of submodels
  //
  replaceable model MovBouHeaExc =
    SimpleHeatExchangers.SimpleEvaporator
    constrainedby PartialSimpleHeatExchanger
    "Model of simple moving boundary heat exchanger"
    annotation (Dialog(tab="General",group="Submodels"),
                choicesAllMatching = true);

  // Definition of parameters describing the guard model
  //
  parameter Boolean useFixModCV[nHeaExc]=
    fill(false,nHeaExc)
    "= true, if flow state is prescribed and does not change"
    annotation (Dialog(tab="Guard", group="Flow State"));
  parameter Utilities.Types.ModeCV modCVPar[nHeaExc]=
    fill(Utilities.Types.ModeCV.SCTPSH,nHeaExc)
    "Constant void fraction if not calculated by model"
    annotation (Dialog(tab="Guard", group="Flow State"));

  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTPSH_SCTP[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition SCTPSH to SCTP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTPSH_TPSH[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition SCTPSH to TPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_SCTPSH[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition SCTP to SCTPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_SC[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition SCTP to SC"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_TP[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition SCTP to TP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_SCTPSH[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition TPSH to SCTPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_TP[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition TPSH to TP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_SH[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition TPSH to SH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SC_SCTP[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition SC to SCTP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TP_SCTP[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition TP to SCTP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TP_TPSH[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition TP to TPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SH_TPSH[nHeaExc]=
    fill(5,nHeaExc)
    "Threshold specific enthalpy of switching condition SH to TPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));

  parameter Real lenMin_SCTPSH_SCTP[nHeaExc]=
    fill(1e-6,nHeaExc)
    "Threshold length of switching condition SCTPSH to SCTP"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_SCTPSH_TPSH[nHeaExc]=
    fill(1e-6,nHeaExc)
    "Threshold length of switching condition SCTPSH to TPSH"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_SCTP_SC[nHeaExc]=
    fill(1e-6,nHeaExc)
    "Threshold length of switching condition SCTP to SC"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_SCTP_TP[nHeaExc]=
    fill(1e-6,nHeaExc)
    "Threshold length of switching condition SCTP to TP"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_TPSH_TP[nHeaExc]=
    fill(1e-6,nHeaExc)
    "Threshold length of switching condition TPSH to TP"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_TPSH_SH[nHeaExc]=
    fill(1e-6,nHeaExc)
    "Threshold length of switching condition TPSH to SH"
    annotation (Dialog(tab="Guard", group="Length"));

  // Definition of parameters describing moving boundary cell
  //
  parameter Boolean useVoiFra[nHeaExc]=
    fill(true,nHeaExc)
    "= true, if properties of two-phase regime are computed by void fraction"
    annotation (Dialog(tab="Moving boundary",group="Void fraction"));
  parameter Boolean useVoiFraMod[nHeaExc]=
    fill(true,nHeaExc)
    "= true, if model is used to calculate void fraction"
    annotation (Dialog(tab="Moving boundary",group="Void fraction",
                enable = useVoiFra));
  parameter Real voiFraPar[nHeaExc]=
    fill(0.85,nHeaExc)
    "Constant void fraction if not calculated by model"
    annotation (Dialog(tab="Moving boundary",group="Void fraction",
                enable = (not useVoiFraMod) and (useVoiFra)));
  replaceable model VoidFractionModel =
    Utilities.VoidFractions.Sangi2015
    constrainedby BaseClasses.PartialVoidFraction
    "Model describing calculation of void fraction"
    annotation (Dialog(tab="Moving boundary",group="Void fraction",
                enable = (useVoiFraMod) and (useVoiFra)),
                choicesAllMatching=true);

  parameter Boolean useHeaCoeModPri[nHeaExc]=
    fill(false,nHeaExc)
    "= true, if model is used to calculate coefficients of heat transfers"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer"));
  replaceable model CoefficientOfHeatTransferSCPri =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the supercooled regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = useHeaCoeModPri),
                choicesAllMatching=true);
  replaceable model CoefficientOfHeatTransferTPPri =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the two-phase regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = useHeaCoeModPri),
                choicesAllMatching=true);
  replaceable model CoefficientOfHeatTransferSHPri =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the superheated regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = useHeaCoeModPri),
                choicesAllMatching=true);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSCPri[nHeaExc]=
    fill(2000,nHeaExc)
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = not useHeaCoeModPri));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpTPPri[nHeaExc]=
    fill(7500,nHeaExc)
    "Effective coefficient of heat transfer between the wall and fluid of the
    two-phase regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = not useHeaCoeModPri));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSHPri[nHeaExc]=
    fill(2500,nHeaExc)
    "Effective coefficient of heat transfer between the wall and fluid of the
    superheated regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = not useHeaCoeModPri));

  parameter Utilities.Types.CalculationHeatFlow heaFloCalPri[nHeaExc]=
    fill(Utilities.Types.CalculationHeatFlow.E_NTU,nHeaExc)
    "Choose the way of calculating the heat flow between the wall and medium"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer"));

  // Definition of parameters describing secondary fluid
  //
  parameter Boolean useHeaCoeModSec[nHeaExc]=
    fill(false,nHeaExc)
    "= true, if model is used to calculate coefficients of heat transfers"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer"));
  replaceable model CoefficientOfHeatTransferSec =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer",
                enable = useHeaCoeModSec),
                choicesAllMatching=true);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSCSec[nHeaExc]=
    fill(100,nHeaExc)
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer",
                enable = not useHeaCoeModSec));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpTPSec[nHeaExc]=
    fill(100,nHeaExc)
    "Effective coefficient of heat transfer between the wall and fluid of the
    two-phase regime"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer",
                enable = not useHeaCoeModSec));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSHSec[nHeaExc]=
    fill(100,nHeaExc)
    "Effective coefficient of heat transfer between the wall and fluid of the
    superheated regime"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer",
                enable = not useHeaCoeModSec));

  parameter Utilities.Types.CalculationHeatFlow heaFloCalSec[nHeaExc]=
    fill(Utilities.Types.CalculationHeatFlow.E_NTU,nHeaExc)
    "Choose the way of calculating the heat flow between the wall and medium"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer"));

  // Definition of parameters descrbing sensors
  //
  parameter Modelica.SIunits.Time tau=1
    "Time constant at nominal flow rate (use tau=0 for steady-state sensor,
    but see user guide for potential problems)"
    annotation (Dialog(tab="Sensors", group="General"));

  parameter Boolean transferHeat=false
    "if true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Sensors", group="Temperature"));
  parameter Modelica.SIunits.Temperature TAmb=Medium1.T_default
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(tab="Sensors", group="Temperature"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Sensors", group="Temperature"));

  parameter Modelica.Blocks.Types.Init initTypeSen=
    Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Sensors", group="Initialisation"));
  parameter Modelica.SIunits.Temperature TIniSen=Medium1.T_default
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Sensors", group="Initialisation"));

  // Definitions of parameters describing assumptions
  //
  parameter Boolean allowFlowReversal1 = true
    "= false to simplify equations, assuming, but not enforcing, 
    no flow reversal for medium 1"
    annotation(Dialog(tab="Assumptions",group="General"), Evaluate=true);
  parameter Boolean allowFlowReversal2 = true
    "= false to simplify equations, assuming, but not enforcing, 
    no flow reversal for medium 2"
    annotation(Dialog(tab="Assumptions",group="General"), Evaluate=true);

  // Definitions of parameters describing advanced options
  //
  parameter Medium2.MassFlowRate m_flow_nominalPri=0.035
    "Nominal mass flow rate of the primary fluid"
    annotation (Dialog(tab="Advanced", group="Nominal conditions"));
  parameter Medium2.MassFlowRate m_flow_smallPri=1e-6*m_flow_nominalPri
    "Small mass flow rate  of the primary fluid for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Nominal conditions"));

  parameter Medium1.MassFlowRate m_flow_nominalSec=0.5
    "Nominal mass flow rate, used for regularization near zero flow"
    annotation (Dialog(tab="Advanced", group="Nominal conditions"));
  parameter Medium1.MassFlowRate m_flow_smallSec=1E-4*m_flow_nominalSec
    "For bi-directional flow, temperature is regularized in the region 
    |m_flow| < m_flow_small (m_flow_small > 0 required)"
    annotation (Dialog(tab="Advanced", group="Nominal conditions"));

  parameter Modelica.SIunits.AbsolutePressure pIni[nHeaExc]=
    fill(2e5,nHeaExc)
    "Start value of absolute pressure"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Modelica.SIunits.SpecificEnthalpy dhIni[nHeaExc]=
    fill(10,nHeaExc)
    "Difference between inlet and outlet enthalpies 
    (hInl = hOut+dh0) at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Boolean useFixStaValPri[nHeaExc]=
    fill(false,nHeaExc)
    "= true, if start values are fixed"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dhSCTPdtIni[nHeaExc]=
    fill(1e-5,nHeaExc)
    "Guess value of dhSCTPdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dhTPSHtIni[nHeaExc]=
    fill(1e-5,nHeaExc)
    "Guess value of dhTPSHdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dhOutdtIni[nHeaExc]=
    fill(1e-5,nHeaExc)
    "Guess value of dhOutDesdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dlenSCdtIni[nHeaExc]=
    fill(1e-5,nHeaExc)
    "Guess value of dtlenSCdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dlenTPdtIni[nHeaExc]=
    fill(1e-5,nHeaExc)
    "Guess value of dlenTPdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dlenSHdtIni[nHeaExc]=
    fill(1e-5,nHeaExc)
    "Guess value of dlenSHdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Medium2.MassFlowRate
    m_flow_startInl[nHeaExc]=
    fill(0.5*m_flow_nominalPri,nHeaExc)
    "Guess value of m_flow_startInl"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Medium2.MassFlowRate
    m_flow_startSCTP[nHeaExc]=
    fill(0.5*m_flow_nominalPri,nHeaExc)
    "Guess value of m_flow_startSCTP"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Medium2.MassFlowRate
    m_flow_startTPSH[nHeaExc]=
    fill(0.5*m_flow_nominalPri,nHeaExc)
    "Guess value of m_flow_startTPSH"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Medium2.MassFlowRate
    m_flow_startOut[nHeaExc]=
    fill(0.5*m_flow_nominalPri,nHeaExc)
    "Guess value of m_flow_startOut"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));

  parameter Boolean iniSteStaWal[nHeaExc]=
    fill(false,nHeaExc)
    "=true, if temperatures of different regimes are initialised steady state"
    annotation (Dialog(tab="Advanced", group="Initialisation wall"));
  parameter Modelica.SIunits.Temperature TSCIniWal[nHeaExc]=
    fill(293.15,nHeaExc)
    "Temperature of supercooled regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation wall"));
  parameter Modelica.SIunits.Temperature TTPIniWal[nHeaExc]=
    fill(293.15,nHeaExc)
    "Temperature of two-phase regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation wall"));
  parameter Modelica.SIunits.Temperature TSHIniWal[nHeaExc]=
    fill(293.15,nHeaExc)
    "Temperature of superheated regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation wall"));

  parameter Boolean iniSteStaSec[nHeaExc]=
    fill(false,nHeaExc)
    "=true, if temperatures of different regimes are initialised steady state"
    annotation (Dialog(tab="Advanced", group="Initialisation secondary"));
  parameter Modelica.SIunits.Temperature TSCIniSec[nHeaExc]=
    fill(293.15,nHeaExc)
    "Temperature of supercooled regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation secondary"));
  parameter Modelica.SIunits.Temperature TTPIniSec[nHeaExc]=
    fill(293.15,nHeaExc)
    "Temperature of two-phase regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation secondary"));
  parameter Modelica.SIunits.Temperature TSHIniSec[nHeaExc]=
    fill(293.15,nHeaExc)
    "Temperature of superheated regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation secondary"));

  parameter Real lenMin[nHeaExc]=
    fill(1e-4,nHeaExc)
    "Threshold length of switching condition"
    annotation (Dialog(tab="Advanced", group="Convergence"));
  parameter Real tauVoiFra[nHeaExc]=
    fill(125,nHeaExc)
    "Time constant to describe convergence of void fraction if flow state 
    changes"
    annotation (Dialog(tab="Advanced", group="Convergence"));
  parameter Modelica.SIunits.Frequency tauTem[nHeaExc]=
    fill(1,nHeaExc)
    "Time constant describing convergence of wall temperatures of inactive regimes"
    annotation (Dialog(tab="Advanced", group="Convergence"));

  parameter Boolean calBalEquPri=true
    "= true, if balance equations are computed"
    annotation (Dialog(tab="Advanced", group="Diagnostics"));
  parameter Boolean calBalEquWal=true
    "= true, if balance equations are computed"
    annotation (Dialog(tab="Advanced", group="Diagnostics"));

  // Definition of connectors
  //
  Modelica.Fluid.Interfaces.FluidPorts_a ports_a1[nHeaExc](
    redeclare each final package Medium = Medium1,
     m_flow(each min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
     h_outflow(each start = Medium1.h_default))
    "Fluid connectors a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-40},{10,40}},
        rotation=-90,
        origin={50,100})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_b1[nHeaExc](
    redeclare each final package Medium = Medium1,
    m_flow(each max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
    h_outflow(each start = Medium1.h_default))
    "Fluid connectors b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,40},{10,-40}},
        rotation=90,
        origin={-50,100})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
    redeclare each final package Medium = Medium2,
     m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
     h_outflow(start = Medium2.h_default)) if not useModPortsb_a
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_a2[nHeaExc](
    redeclare each final package Medium = Medium2,
     m_flow(each min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
     h_outflow(each start = Medium2.h_default)) if useModPortsb_a
    "Fluid connectors a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-40},{-90,40}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
    redeclare each final package Medium = Medium2,
    m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
    h_outflow(start = Medium2.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  // Definition of bus connectors
  //
  Controls.Interfaces.ModularHeatPumpControlBus dataBus
    "Connector that contains all relevant control signals"
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));

  // Definition of instances of submodels
  //
  Sensors.MassFlowRate senMasFloSec[nHeaExc](
    redeclare each package Medium = Medium1,
    each final allowFlowReversal=allowFlowReversal1)
    "Mass flow sensors at outlets of secondary sides of heat exchangers"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-40,40})));
  Sensors.Pressure senPreSec[nHeaExc](
    redeclare each package Medium = Medium1)
    "Pressure sensors at outlets of secondary sides of heat exchangers"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,70})));
  Sensors.TemperatureTwoPort senTemInlSec[nHeaExc](
    redeclare each package Medium = Medium1,
    each final m_flow_nominal=m_flow_nominalSec,
    each final tau=tau,
    each final initType=initTypeSen,
    each final T_start=TIniSen,
    each final transferHeat=transferHeat,
    each final TAmb=TAmb,
    each final tauHeaTra=tauHeaTra,
    each final allowFlowReversal=allowFlowReversal1,
    each final m_flow_small=m_flow_smallSec)
    "Temperature sensors at inlets of secondary sides of heat exchangers"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,10})));
  Sensors.TemperatureTwoPort senTemOutSec[nHeaExc](
    redeclare each package Medium = Medium1,
    each final m_flow_nominal=m_flow_nominalSec,
    each final tau=tau,
    each final initType=initTypeSen,
    each final T_start=TIniSen,
    each final transferHeat=transferHeat,
    each final TAmb=TAmb,
    each final tauHeaTra=tauHeaTra,
    each final allowFlowReversal=allowFlowReversal1,
    each final m_flow_small=m_flow_smallSec)
    "Temperature sensors at outlets of secondary sides of heat exchangers"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-40,10})));

  MovBouHeaExc heaExc[nHeaExc](
    each final typHX=typHX,
    final geoCV=geoCV,
    final matHX=matHX,
    final useFixModCV=useFixModCV,
    final modCVPar=modCVPar,
    final dhMin_SCTPSH_SCTP=dhMin_SCTPSH_SCTP,
    final dhMin_SCTPSH_TPSH=dhMin_SCTPSH_TPSH,
    final dhMin_SCTP_SCTPSH=dhMin_SCTP_SCTPSH,
    final dhMin_SCTP_SC=dhMin_SCTP_SC,
    final dhMin_SCTP_TP=dhMin_SCTP_TP,
    final dhMin_TPSH_SCTPSH=dhMin_TPSH_SCTPSH,
    final dhMin_TPSH_TP=dhMin_TPSH_TP,
    final dhMin_TPSH_SH=dhMin_TPSH_SH,
    final dhMin_SC_SCTP=dhMin_SC_SCTP,
    final dhMin_TP_SCTP=dhMin_TP_SCTP,
    final dhMin_TP_TPSH=dhMin_TP_TPSH,
    final dhMin_SH_TPSH=dhMin_SH_TPSH,
    final lenMin_SCTPSH_SCTP=lenMin_SCTPSH_SCTP,
    final lenMin_SCTPSH_TPSH=lenMin_SCTPSH_TPSH,
    final lenMin_SCTP_SC=lenMin_SCTP_SC,
    final lenMin_SCTP_TP=lenMin_SCTP_TP,
    final lenMin_TPSH_TP=lenMin_TPSH_TP,
    final lenMin_TPSH_SH=lenMin_TPSH_SH,
    redeclare each final package Medium1 = Medium1,
    redeclare each final package Medium2 = Medium2,
    final useVoiFra=useVoiFra,
    final useVoiFraMod=useVoiFraMod,
    final voiFraPar=voiFraPar,
    redeclare each final model VoidFractionModel = VoidFractionModel,
    final useHeaCoeModPri=useHeaCoeModPri,
    redeclare each final model CoefficientOfHeatTransferSCPri =
        CoefficientOfHeatTransferSCPri,
    redeclare each final model CoefficientOfHeatTransferTPPri =
        CoefficientOfHeatTransferTPPri,
    redeclare each final model CoefficientOfHeatTransferSHPri =
        CoefficientOfHeatTransferSHPri,
    final AlpSCPri=AlpSCPri,
    final AlpTPPri=AlpTPPri,
    final AlpSHPri=AlpSHPri,
    final heaFloCalPri=heaFloCalPri,
    final useHeaCoeModSec=useHeaCoeModSec,
    redeclare each final model CoefficientOfHeatTransferSec =
        CoefficientOfHeatTransferSec,
    final AlpSCSec=AlpSCSec,
    final AlpTPSec=AlpTPSec,
    final AlpSHSec=AlpSHSec,
    final heaFloCalSec=heaFloCalSec,
    each final allowFlowReversal1=allowFlowReversal1,
    each final allowFlowReversal2=allowFlowReversal2,
    each final m_flow_nominalPri=m_flow_nominalPri,
    each final m_flow_smallPri=m_flow_smallPri,
    final pIni=pIni,
    final dhIni=dhIni,
    final useFixStaValPri=useFixStaValPri,
    final dhSCTPdtIni=dhSCTPdtIni,
    final dhTPSHtIni=dhTPSHtIni,
    final dhOutdtIni=dhOutdtIni,
    final dlenSCdtIni=dlenSCdtIni,
    final dlenTPdtIni=dlenTPdtIni,
    final dlenSHdtIni=dlenSHdtIni,
    final m_flow_startInl=m_flow_startInl,
    final m_flow_startSCTP=m_flow_startSCTP,
    final m_flow_startTPSH=m_flow_startTPSH,
    final m_flow_startOut=m_flow_startOut,
    final iniSteStaWal=iniSteStaWal,
    final TSCIniWal=TSCIniWal,
    final TTPIniWal=TTPIniWal,
    final TSHIniWal=TSHIniWal,
    final iniSteStaSec=iniSteStaSec,
    final TSCIniSec=TSCIniSec,
    final TTPIniSec=TTPIniSec,
    final TSHIniSec=TSHIniSec,
    final lenMin=lenMin,
    final tauVoiFra=tauVoiFra,
    final tauTem=tauTem,
    each final calBalEquPri=calBalEquPri,
    each final calBalEquWal=calBalEquWal)
    "Array of heat exchangers in parallel"
    annotation (Placement(transformation(extent={{10,-40},{-10,-20}})));


equation
  // Connection of secondary fluid side
  //
  connect(ports_a1, senTemInlSec.port_a)
    annotation (Line(points={{50,100},{48,100},{48,88},{40,88},{40,20}},
                color={0,127,255}));
  connect(senTemInlSec.port_b, heaExc.port_a1)
    annotation (Line(points={{40,0},{40,0},{20,0},{20,-24},{10,-24}},
                color={0,127,255}));
  connect(heaExc.port_b1, senTemOutSec.port_a)
    annotation (Line(points={{-10,-24},{-16,-24},{-20,-24},{-20,0},{-40,0},
                {-40,1.77636e-015}}, color={0,127,255}));
  connect(senTemOutSec.port_b, senMasFloSec.port_a)
    annotation (Line(points={{-40,20},{-40,30}}, color={0,127,255}));
  connect(senMasFloSec.port_b, senPreSec.port)
    annotation (Line(points={{-40,50},{-40,70}}, color={0,127,255}));
  connect(senPreSec.port,ports_b1)
    annotation (Line(points={{-40,70},{-40,70},{-40,88},{-50,88},{-50,100}},
                color={0,127,255}));

  // Connection of primary fluid side
  //
  if not useModPortsb_a then
    for i in 1:nHeaExc loop
      connect(port_a2,heaExc[i].port_a2);
    end for;
  else
    connect(ports_a2,heaExc.port_a2);
  end if;

  // Connection of sensor signals
  //
  if appHX==Utilities.Types.ApplicationHX.Evaporator then
    /* Evaorator */
    connect(senPreSec.p, dataBus.senBus.meaPreEvaSou);
    connect(senTemInlSec.T, dataBus.senBus.meaTemEvaSouInl);
    connect(senTemOutSec.T, dataBus.senBus.meaTemEvaSouOut);
    connect(senMasFloSec.m_flow, dataBus.senBus.meaMasFloEvaSou);
  else
    /* Condenser */
    connect(senPreSec.p, dataBus.senBus.meaPreConSin);
    connect(senTemInlSec.T, dataBus.senBus.meaTemConSinInl);
    connect(senTemOutSec.T, dataBus.senBus.meaTemConSinOut);
    connect(senMasFloSec.m_flow, dataBus.senBus.meaMasFloConSin);
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,60},{20,68}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-60,60},{20,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,60},{-60,40},{-10,40},{-18,42},{-24,44},{-32,46},{-32,54},
              {-24,56},{-18,58},{-10,60},{-60,60}},
          lineColor={28,108,200},
          smooth=Smooth.Bezier,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,60},{-60,36}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,32},{20,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Line(
          points={{-32,60},{-40,56},{-34,52},{-40,46},{-34,40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-14,60},{-10,54},{-18,50},{-10,46},{-14,40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Rectangle(
          extent={{-60,10},{20,18}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-60,10},{20,-10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,10},{-60,-10},{-10,-10},{-18,-8},{-24,-6},{-32,-4},{-32,4},
              {-24,6},{-18,8},{-10,10},{-60,10}},
          lineColor={28,108,200},
          smooth=Smooth.Bezier,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,10},{-60,-14}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-18},{20,-10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Line(
          points={{-32,10},{-40,6},{-34,2},{-40,-4},{-34,-10}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-14,10},{-10,4},{-18,0},{-10,-4},{-14,-10}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Rectangle(
          extent={{-60,-40},{20,-32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-60,-40},{20,-60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-40},{-60,-60},{-10,-60},{-18,-58},{-24,-56},{-32,-54},{-32,
              -46},{-24,-44},{-18,-42},{-10,-40},{-60,-40}},
          lineColor={28,108,200},
          smooth=Smooth.Bezier,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,-40},{-60,-64}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-68},{20,-60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Line(
          points={{-32,-40},{-40,-44},{-34,-48},{-40,-54},{-34,-60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-14,-40},{-10,-46},{-18,-50},{-10,-54},{-14,-60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-80,44},{-80,-58}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-100,0},{-80,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{-82,2},{-78,-2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,44},{-60,44}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-80,-8},{-60,-8}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-80,-58},{-60,-58}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{-82,-6},{-78,-10}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,-8},{60,-8}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,44},{60,44}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,-58},{60,-58}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{60,44},{60,-58}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{60,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{58,2},{62,-2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{58,-6},{62,-10}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{30,80},{50,80}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-70,80},{-50,80}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-70,80},{-70,-42}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{30,80},{30,-42}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,-42},{30,-42}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,58},{30,58}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-70,58},{-60,58}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-70,8},{-60,8}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,8},{30,8}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-70,-42},{-60,-42}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,100},{50,80}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-50,100},{-50,80}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5)}),
        Diagram(
          coordinateSystem(preserveAspectRatio=false),
          graphics={Line(points={{-10,-36},{-70,-36},{-70,0},{-100,0}},
            color={0,127,255}),
          Line(points={{30,10},{0,10},{0,-100}}, color={0,0,127}),
          Line(points={{-50,82},{0,82},{0,10}},   color={0,0,127}),
          Line(points={{-28,40},{-6,40},{0,40}},  color={0,0,127}),
          Line(points={{-28,10},{-6,10},{0,10}},  color={0,0,127})}));
end PartialModularHeatExchangers;
