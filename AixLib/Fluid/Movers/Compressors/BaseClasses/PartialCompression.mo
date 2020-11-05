within AixLib.Fluid.Movers.Compressors.BaseClasses;
partial model PartialCompression
  "Partial model for compression that contains basic definitions used in 
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
    annotation(Dialog(enable = useInpFil,
               group="Transient behaviour"));

  // Definition of models describing efficiencies
  //
  replaceable model EngineEfficiency =
    Utilities.EngineEfficiency.SpecifiedEfficiencies.ConstantEfficiency
    constrainedby Utilities.EngineEfficiency.PartialEngineEfficiency
    "Model that describes the calculation of the overall mechanic efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Engine efficiency"));
  replaceable model VolumetricEfficiency =
    Utilities.VolumetricEfficiency.SpecifiedEfficiencies.ConstantEfficiency
    constrainedby Utilities.VolumetricEfficiency.PartialVolumetricEfficiency
    "Model that describes the calculation of the overall volumetric efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Volumetric efficiency"));
  replaceable model IsentropicEfficiency =
    Utilities.IsentropicEfficiency.SpecifiedEfficiencies.ConstantEfficiency
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
        Modelica.Media.R134a.R134a_ph,
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
    manVarCom(start=rotSpe0, quantity = "Velocity", unit = ("1/s"))
    "Prescribed compressor's rotational speed"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,100})),
        HideResult=true);
  Modelica.Blocks.Interfaces.RealOutput
    curManVarCom(quantity="Velocity", unit=("1/s"))
    "Current compressor's rotational speed"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,100})), HideResult=true);
  Modelica.Blocks.Continuous.Filter filRotSpe(
    final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    final filterType=Modelica.Blocks.Types.FilterType.LowPass,
    final order=2,
    final f_cut=5/(2*Modelica.Constants.pi*risTim),
    final x(each stateSelect=StateSelect.always)) if useInpFil
    "Second order filter to approximate change of compressor's rotational speed"
    annotation (Placement(transformation(extent={{-30,59},{-10,80}})));
  Modelica.Blocks.Routing.RealPassThrough rotSpeThr
    "Dummy passing through of compressor's rotational speed to allow usage of filter"
    annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
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
    TAmb=heatPort.T)
    "Instance of model 'engine efficiency'";
  VolumetricEfficiency oveVolEff(
    redeclare package Medium=Medium,
    epsRef=epsRef,
    VDis=VDis,
    rotSpe=rotSpe,
    piPre=piPre,
    staInl=staInl,
    staOut=staOut,
    TAmb=heatPort.T)
    "Instance of model 'volumetric efficiency'";
  IsentropicEfficiency oveIseEff(
    redeclare package Medium=Medium,
    epsRef=epsRef,
    VDis=VDis,
    rotSpe=rotSpe,
    piPre=piPre,
    staInl=staInl,
    staOut=staOut,
    TAmb=heatPort.T)
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
    "Compressor's current electrical power consumption";
  Modelica.SIunits.Power Q_flow_ref
    "Current power transferred to reffrigerant";

  Modelica.SIunits.Frequency rotSpe(min=0, max=rotSpeMax)
    "Compressor's current rotational speed";
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
  assert(
    curManVarCom <= rotSpeMax,
    "Rotational speed is greater than maximum 
  rotational speed allowed! Please check boundary condtions!",
    level=AssertionLevel.warning);
  assert(oveEngEff.etaEng<0.9999,
    "Overall engine efficiency is greater than one! 
    Please check efficiency model!",
    level = AssertionLevel.warning);
  assert(oveVolEff.lamH<0.9999,
    "Overall volumetric efficiency is greater than one! 
    Please check efficiency model!",
    level = AssertionLevel.warning);
  assert(oveIseEff.etaIse<0.9999,
    "Overall isentropic efficiency is greater than one! 
    Please check efficiency model!",
    level = AssertionLevel.warning);

  // Calculation of thermodynamic state at inlet conditions
  //
  staInl = Medium.setState_phX(p=pInl,h=hInl) "Thermodynamic state at inlet";
  dInl = Medium.density(staInl) "Density at inlet";

  // Calculation of thermodynamic state at outlet conditions
  //
  staOut = Medium.setState_phX(p=pOut,h=hOut) "Thermodynamic state at outlet";

  // Calculation of characteristics of the compressor
  //
  piPre = abs(pOut/pInl) "Ratio between outlet and inlet pressure";

  // Calculation of compressor's rotational speed
  //
  connect(filRotSpe.u, manVarCom);
  if useInpFil then
    connect(rotSpeThr.u, filRotSpe.y)
      "Transient behaviour of change of rotational speed";
  else
    connect(rotSpeThr.u, manVarCom)
      "No transient behaiviour of change of rotational speed";
  end if;
  rotSpe = smooth(1, noEvent(if rotSpeThr.y>0 then
                  rotSpeThr.y else 1e-12))
    "Passing through internal variable";
  curManVarCom = rotSpe "Current rotational speed";

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
    Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a base model for compression processes that are used, for
  example, in rotary or scroll compressors.
</p>
<h4>
  Definition needed for completion
</h4>
<p>
  Seven equations need to be added by an extending class using this
  component:
</p>
<ul>
  <li>Calculation of the mass flow rate <code>ṁ</code>.
  </li>
  <li>Calculation of the power consumed by the refrigerant
  Q̇<sub>ref</sub>.
  </li>
  <li>Calculation of the compressor's power consumption
  <code>P<sub>el</sub></code>.
  </li>
  <li>Definition of input and output pressures <code>pInl and
  pOut</code>.
  </li>
  <li>Definition of input and output specific enthalpies <code>hInl and
  hOut</code>.
  </li>
  <li>
    <code>port_b.h_outflow</code> for flow in design direction.
  </li>
  <li>
    <code>port_a.h_outflow</code> for flow in reverse direction.
  </li>
</ul>
<p>
  Moreover, appropriate values shall be assigned to the following
  parameters:
</p>
<ul>
  <li>
    <code>dp_start</code> for a guess of the pressure drop
  </li>
  <li>
    <code>m_flow_small</code> for regularization of zero flow.
  </li>
  <li>
    <code>dp_nominal</code> for nominal pressure drop.
  </li>
  <li>
    <code>m_flow_nominal</code> for nominal mass flow rate.
  </li>
</ul>
<h4>
  Efficiency modeling approaches
</h4>
<p>
  Actually, three different efficiency models are suggested and the
  modelling approaches of these efficiencies are shortly characterised
  below:<br/>
</p>
<table summary=\"Efficiencies\" border=\"1\" cellspacing=\"0\" cellpadding=
\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Efficiency
    </th>
    <th>
      Formula
    </th>
    <th>
      Comment
    </th>
  </tr>
  <tr>
    <td>
      <b>Engine</b>
    </td>
    <td>
      <code>η<sub>eng</sub> = Q̇<sub>ref</sub> / P<sub>el</sub></code>
    </td>
    <td>
      Used for calculation of compressor's power consumption
    </td>
  </tr>
  <tr>
    <td>
      <b>Isentropic</b>
    </td>
    <td>
      <code>η<sub>ise</sub> = (h<sub>outIse</sub> - h<sub>inl</sub>) /
      (h<sub>out</sub> - h<sub>inl</sub>)</code>
    </td>
    <td>
      Used for calculation of thermodynamic change of state
    </td>
  </tr>
  <tr>
    <td>
      <b>Volumetric</b>
    </td>
    <td>
      <code>η<sub>vol</sub> = V̇<sub>ide</sub> /
      V̇<sub>rea</sub></code>
    </td>
    <td>
      Used for calculation of mass flow rate
    </td>
  </tr>
</table>
<p>
  These efficiency models are stored in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency</a>,
  <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency</a>
  and <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency</a>.
  Therefore, the calculation procedure of the efficiencies are
  introduced as replaceable models and must be defined by the User.
</p>
<h4>
  Transient behaviour
</h4>
<p>
  The base model has a parameter <code>useInpFil</code> that is used to
  model the compressors's transient behaviour while changing rotational
  speed. Generally, this approach uses the same modeling attempt as the
  stat-up and shut-down transients introtuced for flow machines (see
  <a href=
  \"modelica://AixLib.Fluid.Movers.UsersGuide\">AixLib.Fluid.Movers.UsersGuide</a>).
  Therefore, just the parameter's affections are presented here:
</p>
<ol>
  <li>If <code>useInpFil=false</code>, then the input signal
  <code>opeSet.y</code> is equal to the compressor's rotational speed.
  Thus, a step change in the input signal causes a step change in the
  rotational speed.
  </li>
  <li>If <code>useInpFil=true</code>, which is the default, then the
  rotational speed is equal to the output of a filter. This filter is
  implemented as a 2nd order differential equation. Thus, a step change
  in the compressor's input signal will cause a gradual change in the
  rotational speed. The filter has a parameter <code>risTim</code>,
  which by default is set to <i>1</i> second. The rise time is the time
  required to reach <i>99.6%</i> of the full rotational speed, or, if
  the compressor is shut-down, to reach a rotational speed of
  <i>0.4%</i>.
  </li>
</ol>
<h4>
  References
</h4>
<p>
  In the following, some general references are given for information
  about modelling compressors. The modelling approach presented here is
  alligned to the modelling approaches presented in the literature:
</p>
<p>
  W. Eifler, E. Schlücker, U. Spicher and G. Will (2009): <a href=
  \"http://dx.doi.org/10.1007/978-3-8348-9302-4\">Küttner
  Kolbenmaschinen: Kolbenpumpen, Kolbenverdichter, Brennkraftmaschinen
  (in German)</a>. Publisher: <i>Vieweg + Teubner</i>
</p>
<p>
  H. Qiao, R. Radermacher and V. Aute (2010): <a href=
  \"http://docs.lib.purdue.edu/iracc/1090\">A review for numerical
  simulation of vapor compression systems</a>. In: <i>International
  Refrigeration and Air Conditioning Conference</i>
</p>
<p>
  P.C. Hanlon (2011): <a href=
  \"https://apvgn.pt/wp-content/uploads/compressor_handbook_hanlon.pdf\">Compressor
  Handbook</a>. Publisher: <i>McGraw-Hill</i>
</p>
<p>
  V. A. Cara Martin and R. Radermacher (2015): <a href=
  \"http://www.ahrinet.org/App_Content/ahri/files/RESEARCH/Technical%20Results/AHRI-8013_Final_Report.pdf\">
  AHRI Project 8013: A Study of Methods to Represent Compressor
  Performance Data over an Operating Envelope Based on a Finite Set of
  Test Data</a>. Publisher: <i>Air-Conditioning, Heating, and
  Refrigeration Institute (AHRI)</i>
</p>
</html>"));
end PartialCompression;
