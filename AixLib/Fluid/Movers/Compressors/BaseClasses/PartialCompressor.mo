within AixLib.Fluid.Movers.Compressors.BaseClasses;
partial model PartialCompressor
  "Partial model for compressors that contains basic definitions used in 
various compressor models"

  // Definition of parameters describing the geometry
  //
  parameter Modelica.SIunits.Volume
    VDis(min=0) = 13e-6
    "Displacement volume of the compressor"
    annotation(Dialog(tab="General",group="Geometry"));
  parameter Modelica.SIunits.Efficiency
    epsRef(min=0, max=1, nominal=0.05) = 0.04
    "Ratio of the real and the ideal displacement volume"
    annotation(Dialog(tab="General",group="Geometry"));
  parameter Modelica.SIunits.Frequency
    rotSpeMax(min=0) = 120
    "Maximal rotational speed executable by the compressor"
    annotation(Dialog(tab="General",group="Compressor's characterisitcs"),
               HideResult=true);
  parameter Real
    piPreMax(min=1, unit="1") = 15
    "Maximal pressure ratio executable by the compressor"
    annotation(Dialog(tab="General",group="Compressor's characterisitcs"),
               HideResult=true);

  parameter Boolean useInpFil = true
    "= true, if transient behaviour of rotational speed is computed"
    annotation(Dialog(group="Transient behaviour"));
  parameter Modelica.SIunits.Time risTim = 0.5
    "Time until rotational speed reaches 99.6 % of its set value"
    annotation(Dialog(
      enable = useInpFil,
      group="Transient behaviour"));

  // Definition of models describing efficiencies
  //
  replaceable model EngineEfficiency =
    Utilities.EngineEfficiency.ConstantEfficiency
    constrainedby Utilities.EngineEfficiency.PartialEngineEfficiency
    "Model that describes the calculation of the overall mechanic efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Engine efficiency"));
  replaceable model VolumetricEfficiency =
    Utilities.VolumetricEfficiency.ConstantEfficiency
    constrainedby Utilities.VolumetricEfficiency.PartialVolumetricEfficiency
    "Model that describes the calculation of the overall volumetric efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Volumetric efficiency"));
  replaceable model IsentropicEfficiency =
    Utilities.IsentropicEfficiency.ConstantEfficiency
    constrainedby Utilities.IsentropicEfficiency.PartialIsentropicEfficiency
    "Model that describes the calculation of the overall isentropic efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Isentropic efficiency"));

  // Definition of parameters describing the efficiencies
  //
  parameter Boolean useIseWor = oveEngEff.useIseWor
    "= true, if overal machanic efficiency is related to isentropic compressor 
    work"
    annotation(Dialog(tab="Efficiencies and similitude theory",
               group="Engine efficiency",
               enable=false),
               HideResult=true);

  // Extensions and parameter propagation
  //
  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport(
    redeclare replaceable package Medium =
        WorkingVersion.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
    dp_start=-20e5,
    m_flow_start=0.5*m_flow_nominal,
    m_flow_small=1e-6*m_flow_nominal,
    show_T=false,
    show_V_flow=false);

  // Definition of parameters describing nominal conditions
  //
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab="Advanced"),
               HideResult=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_lea = 1e-8
    "Leackage mass flow rate used for compressor shut-down"
    annotation(Dialog(tab="Advanced"),
               HideResult=true);

  // Definition of parameters describing diagnostics
  //
  parameter Boolean show_staEff = false
    "= true, if thermodynamic states and efficiencies are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"),
               HideResult=true);
  parameter Boolean show_qua = false
    "= true, if vapour qualities are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"),
               HideResult=true);

  // Definition of parameters used for initialisation
  //
  parameter Modelica.SIunits.Frequency rotSpe0 = 60
    "Compressor's rotational spped at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.SIunits.AbsolutePressure pInl0 = 3e5
    "Pressure at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.SIunits.Temperature TInl0 = 283.15
    "Temperature at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.SIunits.Density dInl0=
    Medium.density(Medium.setState_pTX(p=pInl0,T=TInl0))
    "Density at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=false),
               HideResult=true);
  parameter Modelica.SIunits.SpecificEnthalpy hInl0=
    Medium.specificEnthalpy(Medium.setState_pTX(p=pInl0,T=TInl0))
    "Specific enthalpy at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=false),
               HideResult=true);

  // Definition of connectors and submodels
  //
  Modelica.Blocks.Interfaces.RealInput
    preRotSpe(start=rotSpe0, quantity = "Velocity", unit = ("1/s"))
    "Prescribed compressor's rotational speed"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,100})),
        HideResult=true);
  Modelica.Blocks.Interfaces.RealOutput
    actRotSpe(quantity = "Velocity", unit = ("1/s"))
    "Actual compressor's rotational speed"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,100})),
        HideResult=true);
  Modelica.Blocks.Continuous.Filter filterRotSpe(
    final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    final filterType=Modelica.Blocks.Types.FilterType.LowPass,
    order=2,
    f_cut=5/(2*Modelica.Constants.pi*risTim),
    x(each stateSelect=StateSelect.always)) if useInpFil
    "Second order filter to approximate change of compressor's rotational speed"
    annotation (Placement(transformation(extent={{-30,59},{-10,80}})));
  Modelica.Blocks.Routing.RealPassThrough rotSpeThrough
    "Dummy passing through of compressor's rotational speed to allow usage of filter"
    annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port connector to calculate heat losses to ambient"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  // Definition of models
  //
  EngineEfficiency oveEngEff(
    redeclare package Medium=Medium,
    epsRef=epsRef,
    VDis=VDis,
    rotSpe=rotSpe,
    piPre=piPre,
    staInl=staInl,
    staOut=staOut,
    staOutIse=Medium.setState_psX(s=Medium.specificEntropy(staInl),p=pOut),
    TOut=heatPort.T)
    "Instance of model 'engine efficiency'";
  VolumetricEfficiency oveVolEff(
    redeclare package Medium=Medium,
    epsRef=epsRef,
    VDis=VDis,
    rotSpe=rotSpe,
    piPre=piPre,
    staInl=staInl,
    staOut=staOut,
    staOutIse=Medium.setState_psX(s=Medium.specificEntropy(staInl),p=pOut),
    TOut=heatPort.T)
    "Instance of model 'volumetric efficiency'";
  IsentropicEfficiency oveIseEff(
    redeclare package Medium=Medium,
    epsRef=epsRef,
    VDis=VDis,
    rotSpe=rotSpe,
    piPre=piPre,
    staInl=staInl,
    staOut=staOut,
    staOutIse=Medium.setState_psX(s=Medium.specificEntropy(staInl),p=pOut),
    TOut=heatPort.T)
    "Instance of model 'isentropic efficiency'";

  // Definition of records containing detailed results if computed
  //
  record CompressorStates
    "Record that contains compressor's thermodynamic states at inlet and outlet"
    Medium.ThermodynamicState staInl
      "Thermodynamic state at inlet conditions";
    Medium.ThermodynamicState staOut
      "Thermodynamic state at outlet conditions";

    Modelica.SIunits.SpecificEntropy sInl
      "Specific entropy at inlet conditions";
    Modelica.SIunits.SpecificEntropy sOut
      "Specific entropy at outlet conditions";

    Modelica.SIunits.Efficiency etaEng
      "Overall engine efficiency";
    Modelica.SIunits.Efficiency etaVol
      "Overall volumetric efficiency";
    Modelica.SIunits.Efficiency etaIse
      "Overall isentropic efficiency";
  end CompressorStates;

  record CompressorQualities
    "Record that contains compressor's qualities at inlet and outlet"
     Medium.SaturationProperties satProInl
      "Saturation properties at inlet conditions";
     Medium.SaturationProperties satProOut
      "Saturation properties at outlet conditions";

    Real pTriCriInl(min=0)
      "Trigger to check medium exceeds critical pressure at inlet";
    Real pTriCriOut(min=0)
      "Trigger to check medium exceeds critical pressure at inlet";
    Real quaInl(min=0, max=1, unit="1")
      "Vapour quality at inlet conditions";
    Real quaOut(min=0, max=1, unit="1")
      "Vapour quality at outlet conditions";


    Modelica.SIunits.SpecificEnthalpy hLiqInl
      "Liquid enthalpy at inlet";
    Modelica.SIunits.SpecificEnthalpy hVapInl
      "Vapour enthalpy at inlet";
    Modelica.SIunits.SpecificEnthalpy hLiqOut
      "Liquid enthalpy at outlet";
    Modelica.SIunits.SpecificEnthalpy hVapOut
      "Vapour enthalpy at outlet";
  end CompressorQualities;

  CompressorStates comSta(
    staInl=staInl,
    staOut=staOut,
    sInl=Medium.specificEntropy(staInl),
    sOut=Medium.specificEntropy(staOut),
    etaEng=oveEngEff.etaEng,
    etaVol=oveVolEff.lamH,
    etaIse=oveIseEff.etaIse) if show_staEff
    "Record containing compressor's thermodynamic states and efficiencies";

  CompressorQualities comQua(
    satProInl=Medium.setSat_p(pInl),
    satProOut=Medium.setSat_p(pOut),
    pTriCriInl=pInl/Medium.fluidConstants[1].criticalPressure,
    pTriCriOut=pOut/Medium.fluidConstants[1].criticalPressure,
    hLiqInl=Medium.bubbleEnthalpy(Medium.setSat_p(pInl)),
    hVapInl=Medium.dewEnthalpy(Medium.setSat_p(pInl)),
    hLiqOut=Medium.bubbleEnthalpy(Medium.setSat_p(pOut)),
    hVapOut=Medium.dewEnthalpy(Medium.setSat_p(pOut)),
    quaInl=noEvent(if ((pInl/Medium.fluidConstants[1].criticalPressure)<1 and
             hInl<Medium.bubbleEnthalpy(Medium.setSat_p(pInl))) then 0
             else if ((pInl/Medium.fluidConstants[1].criticalPressure)<1 and
             hInl>Medium.bubbleEnthalpy(Medium.setSat_p(pInl)) and
             hInl<Medium.dewEnthalpy(Medium.setSat_p(pInl))) then
             (hInl - Medium.bubbleEnthalpy(Medium.setSat_p(pInl)))/
             max(Medium.dewEnthalpy(Medium.setSat_p(pInl)) -
             Medium.bubbleEnthalpy(Medium.setSat_p(pInl)), 1e-6) else 1.0),
    quaOut=noEvent(if ((pOut/Medium.fluidConstants[1].criticalPressure)<1 and
             hOut<Medium.bubbleEnthalpy(Medium.setSat_p(pOut))) then 0
             else if ((pOut/Medium.fluidConstants[1].criticalPressure)<1 and
             hOut>Medium.bubbleEnthalpy(Medium.setSat_p(pOut)) and
             hOut<Medium.dewEnthalpy(Medium.setSat_p(pOut))) then
             (hOut - Medium.bubbleEnthalpy(Medium.setSat_p(pOut)))/
             max(Medium.dewEnthalpy(Medium.setSat_p(pOut)) -
             Medium.bubbleEnthalpy(Medium.setSat_p(pOut)), 1e-6) else 1.0)) if
    show_qua
    "Record containing compressor's vapour qualities";

  // Definition of variables
  //
  Modelica.SIunits.Power PEle
    "Compressor's actual electrical power consumption";
  Modelica.SIunits.Power Q_flow_ref
    "Actual power transferred to reffrigerant";

  Modelica.SIunits.Frequency rotSpe(min=0, max=rotSpeMax)
    "Compressor's actual rotational speed";
  Real piPre(min=0, max=piPreMax, unit="1")
    "Ratio of compressor's outlet and inlet pressure";


protected
  Medium.ThermodynamicState staInl
    "Thermodynamic state at inlet conditions";
  Medium.ThermodynamicState staOut
    "Thermodynamic state at outlet conditions";

  Modelica.SIunits.AbsolutePressure pInl(start=pInl0)
    "Pressure at inlet conditions";
  Modelica.SIunits.SpecificEnthalpy hInl(start=hInl0)
    "Specific enthalpy at inlet conditions";
  Modelica.SIunits.Density dInl
    "Density at inlet conditions";

  Modelica.SIunits.AbsolutePressure pOut(start=pInl0-dp_start)
    "Pressure at outlet conditions";
  Modelica.SIunits.SpecificEnthalpy hOut
    "Specific enthalpy at outlet conditions";

  Modelica.SIunits.SpecificEnthalpy hOutIse
    "Specific isentropic enthalpy at outlet conditions";
  Modelica.SIunits.SpecificEnthalpy dh
    "Specific enthalpy difference: hOut - hInl";
  Modelica.SIunits.SpecificEnthalpy dhIse
    "Specific isentropic enthalpy difference: hOutIse - hInl";


equation
  // Provide assertions to check physical correctness
  //
  assert(piPre<=piPreMax, "Pressure ratio is greater than maximum pressure
    ratio allowed! Please check boundary condtions!",
    level = AssertionLevel.warning);
  assert(actRotSpe<=rotSpeMax, "Rotational speed is greater than maximum 
  rotational speed allowed! Please check boundary condtions!",
    level = AssertionLevel.warning);
  assert(oveEngEff.etaEng<=1, "Overall engine efficiency is greater than one! 
    Please check efficiency model!",
    level = AssertionLevel.warning);
  assert(oveVolEff.lamH<=1, "Overall volumetric efficiency is greater than one! 
    Please check efficiency model!",
    level = AssertionLevel.warning);
  assert(oveIseEff.etaIse<=1, "Overall isentropic efficiency is greater than one! 
    Please check efficiency model!",
    level = AssertionLevel.warning);

  // Calculation of thermodynamic state at inlet conditions
  //
  staInl = Medium.setState_phX(p=pInl,h=hInl) "Thermodynamic state at inlet";
  dInl = Medium.density(staInl) "Temperature at inlet";

  // Calculation of thermodynamic state at outlet conditions
  //
  staOut = Medium.setState_phX(p=pOut,h=hOut) "Thermodynamic state at outlet";

  // Calculation of compressor'ss characteristics
  //
  piPre = abs(pOut/pInl) "Ratio between outlet and inlet pressure";

  // Calculation of compressor's rotational speed
  //
  connect(filterRotSpe.u, preRotSpe);
  if useInpFil then
    connect(rotSpeThrough.u, filterRotSpe.y)
      "Transient behaviour of change of rotational speed";
  else
    connect(rotSpeThrough.u, preRotSpe)
      "No transient behaiviour of change of rotational speed";
  end if;
  rotSpe = rotSpeThrough.y "Passing thorugh internal variable";
  actRotSpe = rotSpe "Actual rotational speed";

  // Calculation of mass flow
  //
  m_flow = homotopy(smooth(1, noEvent(if rotSpe>0 then
                           rotSpe*oveVolEff.lamH*VDis*dInl else m_flow_lea)),
                    rotSpe*oveVolEff.lamH*VDis*dInl0)
    "Cover initialisation case as well as shut-down case";

  // Calculation of energy balances
  //
  hOutIse = Medium.isentropicEnthalpy(p_downstream=pOut, refState=staInl)
    "Isentropic specific enthalpy at outlet";
  oveIseEff.etaIse*dh = dhIse "Specific enthalpy difference";
  dhIse = (hOutIse - hInl) "Isentropic specific enthalpy difference";

  Q_flow_ref = m_flow *dh "Power absorbed by refrigerant";
  if not useIseWor then
    oveEngEff.etaEng*PEle = Q_flow_ref "Compressor's power consumption";
  else
    oveEngEff.etaEng*PEle = m_flow *dhIse "Compressor's power consumption";
  end if;
  /*Some efficiency models calculate the compressor's power consumptions based
    on the compressors isentropic work. Therefore, a distinction is made above.
  */

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
              graphics={
                Ellipse(
                  extent={{80,80},{-80,-80}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
                Line(
                  points={{74,-30},{-60,-52}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{74,30},{-58,54}},
                  color={0,0,0},
                  thickness=0.5)}),
                Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end PartialCompressor;
