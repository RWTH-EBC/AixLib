within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialSimpleHeatExchanger
  "Bass class for all models describing simple moving boundary heat exchanger"

  // Definitions of parameters describing the type of the heat exchanger
  //
  parameter Utilities.Types.ApplicationHX appHX=
    Utilities.Types.ApplicationHX.Evaporator
    "Application of the heat exchangver (e.g. evaporator or condenser)"
    annotation (Dialog(tab="General",group="Parameters"));
  parameter Utilities.Types.TypeHX typHX=
    Utilities.Types.TypeHX.CounterCurrent
    "Type of the heat exchangver (e.g. counter-current heat exchanger)"
    annotation (Dialog(tab="General",group="Parameters"));

  // Definition of records describing the cross-sectional geometry
  //
  inner replaceable parameter
    Utilities.Properties.GeometryHX geoCV
    "Record that contains geometric parameters of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Parameters"),
                Placement(transformation(extent={{-90,6},{-70,26}})));
  inner replaceable parameter
    Utilities.Properties.MaterialHX matHX
    "Record that contains parameters of the heat exchanger's material properties"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Parameters"),
                Placement(transformation(extent={{-90,-26},{-70,-6}})));

  // Definition of submodels describing cells
  //
  replaceable model GuaMod =
    Utilities.Guards.GeneralGuard
    constrainedby PartialGuard
    "Model that describes the wall of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Submodels"));
  replaceable model MovBouCel =
    Utilities.FluidCells.EvaporatorCell
    constrainedby PartialMovingBoundaryCell
    "Model that describes the wall of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Submodels"));
  replaceable model WalMod =
    Utilities.WallCells.SimpleWallCell
    constrainedby PartialWallCell
    "Model that describes the wall of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Submodels"));
  replaceable model SecFluMod =
    Utilities.FluidCells.SecondaryFluidCell
    constrainedby PartialSecondaryFluidCell
    "Model that describes the wall of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Submodels"));

  // Definition of parameters describing the guard model
  //
  parameter Boolean useFixModCV=false
    "= true, if flow state is prescribed and does not change"
    annotation (Dialog(tab="Guard", group="Flow State"));
  parameter Utilities.Types.ModeCV modCVPar=Utilities.Types.ModeCV.SCTPSH
    "Constant void fraction if not calculated by model"
    annotation (Dialog(tab="Guard", group="Flow State"));

  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTPSH_SCTP=5
    "Threshold specific enthalpy of switching condition SCTPSH to SCTP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTPSH_TPSH=5
    "Threshold specific enthalpy of switching condition SCTPSH to TPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_SCTPSH=5
    "Threshold specific enthalpy of switching condition SCTP to SCTPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_SC=5
    "Threshold specific enthalpy of switching condition SCTP to SC"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_TP=5
    "Threshold specific enthalpy of switching condition SCTP to TP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_SCTPSH=5
    "Threshold specific enthalpy of switching condition TPSH to SCTPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_TP=5
    "Threshold specific enthalpy of switching condition TPSH to TP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_SH=5
    "Threshold specific enthalpy of switching condition TPSH to SH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SC_SCTP=5
    "Threshold specific enthalpy of switching condition SC to SCTP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TP_SCTP=5
    "Threshold specific enthalpy of switching condition TP to SCTP"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TP_TPSH=5
    "Threshold specific enthalpy of switching condition TP to TPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SH_TPSH=5
    "Threshold specific enthalpy of switching condition SH to TPSH"
    annotation (Dialog(tab="Guard", group="Specific enthalpy"));

  parameter Real lenMin_SCTPSH_SCTP=1e-6
    "Threshold length of switching condition SCTPSH to SCTP"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_SCTPSH_TPSH=1e-6
    "Threshold length of switching condition SCTPSH to TPSH"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_SCTP_SC=1e-6
    "Threshold length of switching condition SCTP to SC"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_SCTP_TP=1e-6
    "Threshold length of switching condition SCTP to TP"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_TPSH_TP=1e-6
    "Threshold length of switching condition TPSH to TP"
    annotation (Dialog(tab="Guard", group="Length"));
  parameter Real lenMin_TPSH_SH=1e-6
    "Threshold length of switching condition TPSH to SH"
    annotation (Dialog(tab="Guard", group="Length"));

  // Definition of parameters describing moving boundary cell
  //
  parameter Boolean useVoiFra = true
    "= true, if properties of two-phase regime are computed by void fraction"
    annotation (Dialog(tab="Moving boundary",group="Void fraction"));
  parameter Boolean useVoiFraMod = true
    "= true, if model is used to calculate void fraction"
    annotation (Dialog(tab="Moving boundary",group="Void fraction",
                enable = useVoiFra));
  parameter Real voiFraPar = 0.85
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

  parameter Boolean useHeaCoeModPri=false
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

  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSCPri = 2000
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = not useHeaCoeModPri));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpTPPri = 7500
    "Effective coefficient of heat transfer between the wall and fluid of the
    two-phase regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = not useHeaCoeModPri));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSHPri = 2500
    "Effective coefficient of heat transfer between the wall and fluid of the
    superheated regime"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer",
                enable = not useHeaCoeModPri));

  parameter Utilities.Types.CalculationHeatFlow
    heaFloCalPri = Utilities.Types.CalculationHeatFlow.E_NTU
    "Choose the way of calculating the heat flow between the wall and medium"
    annotation (Dialog(tab="Moving boundary", group="Heat transfer"));

  // Definition of parameters describing secondary fluid
  //
  parameter Boolean useHeaCoeModSec=false
    "= true, if model is used to calculate coefficients of heat transfers"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer"));
  replaceable model CoefficientOfHeatTransferSec =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer",
                enable = useHeaCoeModSec),
                choicesAllMatching=true);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSCSec=100
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer",
                enable = not useHeaCoeModSec));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpTPSec=100
    "Effective coefficient of heat transfer between the wall and fluid of the
    two-phase regime"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer",
                enable = not useHeaCoeModSec));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSHSec=100
    "Effective coefficient of heat transfer between the wall and fluid of the
    superheated regime"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer",
                enable = not useHeaCoeModSec));

  parameter Utilities.Types.CalculationHeatFlow heaFloCalSec=
    Utilities.Types.CalculationHeatFlow.E_NTU
    "Choose the way of calculating the heat flow between the wall and medium"
    annotation (Dialog(tab="Secondary fluid", group="Heat transfer"));

  // Extensions and propagation of parameters
  //
  extends AixLib.Fluid.Interfaces.PartialFourPort(
    redeclare replaceable package Medium1 = AixLib.Media.Water,
    redeclare replaceable package Medium2 = Modelica.Media.R134a.R134a_ph);

  // Definitions of parameters describing advanced options
  //
  parameter Medium2.MassFlowRate m_flow_nominalPri=0.1
    "Nominal mass flow rate of the primary fluid"
    annotation (Dialog(tab="Advanced", group="Nominal conditions"));
  parameter Medium2.MassFlowRate m_flow_smallPri=1e-6
    *m_flow_nominalPri
    "Small mass flow rate  of the primary fluid for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Nominal conditions"));

  parameter Modelica.SIunits.AbsolutePressure pIni=2e5
    "Start value of absolute pressure"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Modelica.SIunits.SpecificEnthalpy dhIni=10
    "Difference between inlet and outlet enthalpies 
    (hInl = hOut+dh0) at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Boolean useFixStaValPri=false
    "= true, if start values are fixed"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dhSCTPdtIni=1e-5
    "Guess value of dhSCTPdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dhTPSHtIni=1e-5
    "Guess value of dhTPSHdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dhOutdtIni=1e-5
    "Guess value of dhOutDesdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dlenSCdtIni=1e-5
    "Guess value of dtlenSCdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dlenTPdtIni=1e-5
    "Guess value of dlenTPdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Real dlenSHdtIni=1e-5
    "Guess value of dlenSHdt"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Medium2.MassFlowRate
    m_flow_startInl=0.5*m_flow_nominalPri
    "Guess value of m_flow_startInl"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Medium2.MassFlowRate
    m_flow_startSCTP=0.5*m_flow_nominalPri
    "Guess value of m_flow_startSCTP"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Medium2.MassFlowRate
    m_flow_startTPSH=0.5*m_flow_nominalPri
    "Guess value of m_flow_startTPSH"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));
  parameter Medium2.MassFlowRate
    m_flow_startOut=0.5*m_flow_nominalPri
    "Guess value of m_flow_startOut"
    annotation (Dialog(tab="Advanced", group="Initialisation moving boundary"));

  parameter Boolean iniSteStaWal=false
    "=true, if temperatures of different regimes are initialised steady state"
    annotation (Dialog(tab="Advanced", group="Initialisation wall"));
  parameter Modelica.SIunits.Temperature TSCIniWal=293.15
    "Temperature of supercooled regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation wall"));
  parameter Modelica.SIunits.Temperature TTPIniWal=293.15
    "Temperature of two-phase regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation wall"));
  parameter Modelica.SIunits.Temperature TSHIniWal=293.15
    "Temperature of superheated regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation wall"));

  parameter Boolean iniSteStaSec=false
    "=true, if temperatures of different regimes are initialised steady state"
    annotation (Dialog(tab="Advanced", group="Initialisation secondary"));
  parameter Modelica.SIunits.Temperature TSCIniSec=293.15
    "Temperature of supercooled regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation secondary"));
  parameter Modelica.SIunits.Temperature TTPIniSec=293.15
    "Temperature of two-phase regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation secondary"));
  parameter Modelica.SIunits.Temperature TSHIniSec=293.15
    "Temperature of superheated regime at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation secondary"));

  parameter Real lenMin=1e-4
    "Threshold length of switching condition"
    annotation (Dialog(tab="Advanced", group="Convergence"));
  parameter Real tauVoiFra=125
    "Time constant to describe convergence of void fraction if flow state 
    changes"
    annotation (Dialog(tab="Advanced", group="Convergence"));
  parameter Modelica.SIunits.Frequency tauTem=1
    "Time constant describing convergence of wall temperatures of inactive regimes"
    annotation (Dialog(tab="Advanced", group="Convergence"));

  parameter Boolean calBalEquPri=true
    "= true, if balance equations are computed"
    annotation (Dialog(tab="Advanced", group="Diagnostics"));
  parameter Boolean calBalEquWal=true
    "= true, if balance equations are computed"
    annotation (Dialog(tab="Advanced", group="Diagnostics"));

  // Definition of instances of submodels
  //
  GuaMod gua(
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
    final lenMin=lenMin,
    final lenMin_SCTPSH_SCTP=lenMin_SCTPSH_SCTP,
    final lenMin_SCTPSH_TPSH=lenMin_SCTPSH_TPSH,
    final lenMin_SCTP_SC=lenMin_SCTP_SC,
    final lenMin_SCTP_TP=lenMin_SCTP_TP,
    final lenMin_TPSH_TP=lenMin_TPSH_TP,
    final lenMin_TPSH_SH=lenMin_TPSH_SH,
    lenCV=movBouCel.lenOut,
    hOutEva=if appHX==Utilities.Types.ApplicationHX.Evaporator then
      movBouCel.hOut else movBouCel.hInl,
    hOutCon=if appHX==Utilities.Types.ApplicationHX.Evaporator then
      movBouCel.hInl else movBouCel.hOut,
    hLiq=movBouCel.hLiq,
    hVap=movBouCel.hVap,
    voiFra=movBouCel.VoiFraThr,
    TWalTP=walCel.TTP)
    "Guard that switches flow states"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  MovBouCel movBouCel(
    final appHX=appHX,
    final geoCV=geoCV,
    redeclare final package Medium = Medium2,
    final allowFlowReversal=allowFlowReversal2,
    final lenMin=lenMin,
    final useVoiFra=useVoiFra,
    final useVoiFraMod=useVoiFraMod,
    final voiFraPar=voiFraPar,
    redeclare final model VoidFractionModel = VoidFractionModel,
    final useHeaCoeMod=useHeaCoeModPri,
    redeclare final model CoefficientOfHeatTransferSC =
      CoefficientOfHeatTransferSCPri,
    redeclare final model CoefficientOfHeatTransferTP =
      CoefficientOfHeatTransferTPPri,
    redeclare final model CoefficientOfHeatTransferSH =
      CoefficientOfHeatTransferSHPri,
    final AlpSC=AlpSCPri,
    final AlpTP=AlpTPPri,
    final AlpSH=AlpSHPri,
    final heaFloCal=heaFloCalPri,
    final m_flow_nominal=m_flow_nominalPri,
    final m_flow_small=m_flow_smallPri,
    final pIni=pIni,
    final dhIni=dhIni,
    final useFixStaVal=useFixStaValPri,
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
    final tauVoiFra=tauVoiFra,
    final calBalEqu=calBalEquPri)
    "Moving boundary cell of the working fluid"
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));

  WalMod walCel(
    final geoCV=geoCV,
    final matHX=matHX,
    final tauTem=tauTem,
    final iniSteSta=iniSteStaWal,
    final TSCIni=TSCIniWal,
    final TTPIni=TTPIniWal,
    final TSHIni=TSHIniWal,
    final calBalEqu=calBalEquWal)
    "Wall cell of the heat exchanger"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));

  SecFluMod secFluCel(
    final typHX=typHX,
    final geoCV=geoCV,
    final useHeaCoeMod=useHeaCoeModSec,
    redeclare final model CoefficientOfHeatTransfer =
      CoefficientOfHeatTransferSec,
    final AlpSC=AlpSCSec,
    final AlpTP=AlpTPSec,
    final AlpSH=AlpSHSec,
    final heaFloCal=heaFloCalSec,
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final iniSteSta=iniSteStaSec,
    final TSCIni=TSCIniSec,
    final TTPIni=TTPIniSec,
    final TSHIni=TSHIniSec)
    "Fluid cell of the secondary fluid"
    annotation (Placement(transformation(extent={{10,50},{-10,70}})));


equation
  // Connect reinitialisation values
  //
  if appHX==Utilities.Types.ApplicationHX.Evaporator then
    /* Evaporatpr */
    when gua.swi then
      reinit(movBouCel.hSCTP,gua.hSCTPIni)
        "Reinitialisation of hSCTP";
      reinit(movBouCel.hTPSH,gua.hTPSHIni)
        "Reinitialisation of hTPSH";
      reinit(movBouCel.hOut,gua.hOutEvaIni)
        "Reinitialisation of hOutDesDes";
      reinit(movBouCel.lenSC,gua.lenSCIni)
        "Reinitialisation of lenCV[1]";
      reinit(movBouCel.lenTP,gua.lenTPIni)
        "Reinitialisation of lenTP[2]";
      reinit(movBouCel.VoiFraThr,gua.voiFraIni)
        "Reinitialisation of voiFra";
    end when;

  else
    /* Condenser */
    when gua.swi then
      reinit(movBouCel.hSCTP,gua.hSCTPIni)
        "Reinitialisation of hSCTP";
      reinit(movBouCel.hTPSH,gua.hTPSHIni)
        "Reinitialisation of hTPSH";
      reinit(movBouCel.hOut,gua.hOutConIni)
        "Reinitialisation of hOutDesDes";
      reinit(movBouCel.lenTP,gua.lenTPIni)
        "Reinitialisation of lenTP[2]";
      reinit(movBouCel.lenSH,1-gua.lenSCIni-gua.lenTPIni)
        "Reinitialisation of lenCV[3]";
      reinit(movBouCel.VoiFraThr,gua.voiFraIni)
        "Reinitialisation of voiFra";
      end when;
  end if;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,80},{100,100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,-12},{100,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-100},{100,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,-12},{100,12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,80},{100,12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialSimpleHeatExchanger;
