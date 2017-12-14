within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialSimpleHeatExchanger

  // Definition of records describing the cross-sectional geometry
  //
  inner replaceable parameter
    Utilities.Properties.GeometryHX geoCV
    "Record that contains geometric parameters of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Parameters"),
                Placement(transformation(extent={{-90,4},{-70,24}})));
  inner replaceable parameter
  Utilities.Properties.MaterialHX matHX
    "Record that contains parameters of the heat exchanger's material properties"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Parameters"),
                Placement(transformation(extent={{-90,-24},{-70,-4}})));

  // Definition of submodels describing cells
  //
  replaceable model MovingBoundaryCell =
    Utilities.FluidCells.MovingBoundaryCell
    constrainedby PartialMovingBoundaryCell;

  replaceable model WallCell =
    Utilities.WallCells.SimpleWallCell
    constrainedby PartialWallCell;

  replaceable model SecondaryFluidCell =
    Utilities.FluidCells.SecondaryFluidCell
    constrainedby PartialSecondaryFluidCell;
  Utilities.Guard gua
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));


  // Extensions and propagation of parameters
  //
  extends AixLib.Fluid.Interfaces.PartialFourPort(
    redeclare replaceable package Medium1 = AixLib.Media.Water,
    redeclare replaceable package Medium2 = Modelica.Media.R134a.R134a_ph);

  // Definition of instances of submodels
  //
  MovingBoundaryCell movBouCell(
    appHX=appHX,
    geoCV=geoCV,
    useVoiFraMod=useVoiFraMod,
    voiFraPar=voiFraPar,
    redeclare model VoidFractionModel = VoidFractionModel,
    redeclare package Medium = Medium2,
    useHeaCoeMod=useHeaCoeMod,
    redeclare model CoefficientOfHeatTransferSC = CoefficientOfHeatTransferSC,
    redeclare model CoefficientOfHeatTransferTP = CoefficientOfHeatTransferTP,
    redeclare model CoefficientOfHeatTransferSH = CoefficientOfHeatTransferSH,
    AlpSC=AlpSC,
    AlpTP=AlpTP,
    AlpSH=AlpSH,
    heaFloCal=heaFloCal,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    m_flow_small=m_flow_small,
    pIni=pIni,
    dhIni=dhIni,
    useFixStaVal=useFixStaVal,
    dhSCTPdtIni=dhSCTPdtIni,
    dhTPSHtIni=dhTPSHtIni,
    dhOutDesdtIni=dhOutDesdtIni,
    dlenSCdtIni=dlenSCdtIni,
    dlenTPdtIni=dlenTPdtIni,
    m_flow_startInl=m_flow_startInl,
    m_flow_startSCTP=m_flow_startSCTP,
    m_flow_startTPSH=m_flow_startTPSH,
    m_flow_startOut=m_flow_startOut,
    lenMin=lenMin,
    tauVoiFra=tauVoiFra,
    calBalEqu=calBalEqu)
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));

  WallCell walCel(
    geoCV=geoCV,
    matHX=matHX,
    tauTem=tauTem,
    iniSteSta=iniSteSta,
    TSCIni=TSCIni,
    TTPIni=TTPIni,
    TSHIni=TSHIni)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));

  SecondaryFluidCell secFluCel(
    typHX=typHX,
    geoCV=geoCV,
    redeclare package Medium = Medium1,
    useHeaCoeMod=useHeaCoeMod,
    redeclare model CoefficientOfHeatTransfer = CoefficientOfHeatTransferSec,
    AlpSC=AlpSCSec,
    AlpTP=AlpTPSec,
    AlpSH=AlpSHSec,
    heaFloCal=heaFloCalSec,
    allowFlowReversal=allowFlowReversal,
    iniSteSta=iniSteStaSec,
    TSCIni=TSCIniSec,
    TTPIni=TTPIniSec,
    TSHIni=TSHIniSec)
    annotation (Placement(transformation(extent={{10,50},{-10,70}})));


  parameter Utilities.Types.ApplicationHX appHX=Utilities.Types.ApplicationHX.Evaporator
    "Application of the heat exchangver (e.g. evaporator or condenser)";
  parameter Boolean useVoiFraMod=true
    "= true, if model is used to calculate void fraction";
  parameter Real voiFraPar=0.85
    "Constant void fraction if not calculated by model";
  replaceable model VoidFractionModel = Utilities.VoidFractions.Sangi2015;
  parameter Boolean useHeaCoeMod=false
    "= true, if model is used to calculate coefficients of heat transfers";
  replaceable model CoefficientOfHeatTransferSC =
      Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer;
  replaceable model CoefficientOfHeatTransferTP =
      Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer;
  replaceable model CoefficientOfHeatTransferSH =
      Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSC=2000 "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpTP=7500 "Effective coefficient of heat transfer between the wall and fluid of the
    two-phase regime";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSH=2500 "Effective coefficient of heat transfer between the wall and fluid of the
    superheated regime";
  parameter Utilities.Types.CalculationHeatFlow heaFloCal=Utilities.Types.CalculationHeatFlow.E_NTU
    "Choose the way of calculating the heat flow between the wall and medium";
  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_nominal
    =0.1 "Nominal mass flow rate";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_small=
      1e-6*movBouCell.m_flow_nominal
    "Small mass flow rate for regularization of zero flow";
  parameter Modelica.SIunits.AbsolutePressure pIni=2e5
    "Start value of absolute pressure";
  parameter Modelica.SIunits.SpecificEnthalpy dhIni=10 "Difference between inlet and outlet enthalpies 
    (hInl = hOut+dh0 | hOut=hInl+dh0) at initialisation";
  parameter Boolean useFixStaVal=false "= true, if start values are fixed";
  parameter Real dhSCTPdtIni=1e-5 "Guess value of dhSCTPdt";
  parameter Real dhTPSHtIni=1e-5 "Guess value of dhTPSHdt";
  parameter Real dhOutDesdtIni=1e-5 "Guess value of dhOutDesdt";
  parameter Real dlenSCdtIni=1e-5 "Guess value of dtlenSCdt";
  parameter Real dlenTPdtIni=1e-5 "Guess value of dlenTPdt";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    m_flow_startInl=0.5*movBouCell.m_flow_nominal
    "Guess value of m_flow_startInl";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    m_flow_startSCTP=0.5*movBouCell.m_flow_nominal
    "Guess value of m_flow_startSCTP";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    m_flow_startTPSH=0.5*movBouCell.m_flow_nominal
    "Guess value of m_flow_startTPSH";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    m_flow_startOut=0.5*movBouCell.m_flow_nominal
    "Guess value of m_flow_startOut";
  parameter Real lenMin=1e-5
    "Minimum length of a control volume required to keep it activated";
  parameter Real tauVoiFra=125 "Time constant to describe convergence of void fraction if flow state 
    changes";
  parameter Boolean calBalEqu=true "= true, if balance equations are computed";
  parameter Modelica.SIunits.Frequency tauTem=1
    "Time constant describing convergence of wall temperatures of inactive regimes";
  parameter Boolean iniSteSta=false
    "=true, if temperatures of different regimes are initialised steady state";
  parameter Modelica.SIunits.Temperature TSCIni=293.15
    "Temperature of supercooled regime at initialisation";
  parameter Modelica.SIunits.Temperature TTPIni=293.15
    "Temperature of two-phase regime at initialisation";
  parameter Modelica.SIunits.Temperature TSHIni=293.15
    "Temperature of superheated regime at initialisation";
  parameter Utilities.Types.TypeHX typHX=Utilities.Types.TypeHX.CounterCurrent
    "Type of the heat exchangver (e.g. counter-current heat exchanger)";
  replaceable model CoefficientOfHeatTransferSec =
      Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSCSec=100 "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpTPSec=100 "Effective coefficient of heat transfer between the wall and fluid of the
    two-phase regime";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSHSec=100 "Effective coefficient of heat transfer between the wall and fluid of the
    superheated regime";
  parameter Utilities.Types.CalculationHeatFlow heaFloCalSec=Utilities.Types.CalculationHeatFlow.E_NTU
    "Choose the way of calculating the heat flow between the wall and medium";
  parameter Boolean iniSteStaSec=false
    "=true, if temperatures of different regimes are initialised steady state";
  parameter Modelica.SIunits.Temperature TSCIniSec=293.15
    "Temperature of supercooled regime at initialisation";
  parameter Modelica.SIunits.Temperature TTPIniSec=293.15
    "Temperature of two-phase regime at initialisation";
  parameter Modelica.SIunits.Temperature TSHIniSec=293.15
    "Temperature of superheated regime at initialisation";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialSimpleHeatExchanger;
