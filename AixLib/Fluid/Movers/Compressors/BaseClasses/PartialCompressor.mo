within AixLib.Fluid.Movers.Compressors.BaseClasses;
partial model PartialCompressor
  "Partial model for compressors that contains basic definitions used in 
various compressor models"

  // Definition of parameters describing the geometry
  //
  parameter Modelica.SIunits.Volume
    VDis(min = 0) = 13e-6
    "Displacement volume of the compressor"
    annotation(Dialog(tab="General",group="Geometry"));
  parameter Modelica.SIunits.Efficiency
    epsRef(min = 0, max = 1, nominal = 0.05) = 0.04
    "Ratio of the real and the ideal displacement volume"
    annotation(Dialog(tab="General",group="Geometry"));
  parameter Modelica.SIunits.Frequency
    rotSpeMax(min=0) = 120
    "Maximal rotational speed executable by the compressor"
    annotation(Dialog(tab="General",group="Compressor's characterisitcs"));
  parameter Real
    piPreMax(min=1, unit="1") = 15
    "Maximal pressure ratio executable by the compressor"
    annotation(Dialog(tab="General",group="Compressor's characterisitcs"));


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
  parameter Boolean useIseWor = false
    "= true, if overal machanic efficiency is related to isentropic compressor 
    work"
    annotation(Dialog(tab="Efficiencies and similitude theory",
               group="Engine efficiency"),
               choices(checkBox=true));

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
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.MassFlowRate m_flow_lea = 1e-8
    "Leackage mass flow rate used for compressor shut-down"
    annotation(Dialog(tab="Advanced"));

  // Definition of parameters describing diagnostics
  //
  parameter Boolean show_staInl = true
    "= true, if thermodynamic state at compressor's inlet is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_staOut = true
    "= true, if thermodynamic state at compressor's outlet is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_eff = true
    "= true, if compressor's efficiencies are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Definition of parameters used for initialisation
  //
  parameter Modelica.SIunits.Frequency rotSpe0 = 60
    "Compressor's rotational spped at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"));
  parameter Modelica.SIunits.AbsolutePressure pInl0 = 3e5
    "Pressure at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"));
  parameter Modelica.SIunits.Temperature TInl0 = 283.15
    "Temperature at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"));

  // Definition of connectors
  //
  Modelica.Blocks.Interfaces.RealInput
    preRotSpe(start=rotSpe0, quantity = "Velocity", unit = ("1/s"))
    "Prescribed compressor's rotational speed"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));

  // Definition of variables
  //
  Medium.ThermodynamicState staInl
    "Thermodynamic state at inlet conditions";
  Medium.ThermodynamicState staOut
    "Thermodynamic state at outlet conditions";
  Medium.SaturationProperties satProInl
    "Saturation properties at inlet conditions";
  Medium.SaturationProperties satProOut
    "Saturation properties at outlet conditions";

  Modelica.SIunits.AbsolutePressure pInl(start=pInl0)
    "Pressure at inlet conditions";
  Modelica.SIunits.Temperature TInl(start=TInl0)
    "Temperature at inlet conditions";
  Modelica.SIunits.SpecificEnthalpy hInl
    "Specific enthalpy at inlet conditions";
  Modelica.SIunits.Density dInl
    "Density at inlet conditions";
  Modelica.SIunits.SpecificEntropy sInl
    "Specific entropy at inlet conditions";
  Real quaInl(min=0, max=1, unit="1")
    "Vapour quality at inlet conditions";

  Modelica.SIunits.AbsolutePressure pOut(start=pInl0-dp_start)
    "Pressure at outlet conditions";
  Modelica.SIunits.Temperature TOut
    "Temperature at outlet conditions";
  Modelica.SIunits.Density dOut "
    Density at outlet conditions";
  Modelica.SIunits.SpecificEnthalpy hOut
    "Specific enthalpy at outlet conditions";
  Modelica.SIunits.SpecificEntropy sOut
    "Specific entropy at outlet conditions";
  Real quaOut(min=0, max=1, unit="1")
    "Vapour quality at outlet conditions";

  Real pTriCriInl(min=0)
    "Trigger to check medium exceeds critical pressure at inlet";
  Real pTriCriOut(min=0)
    "Trigger to check medium exceeds critical pressure at inlet";
  Modelica.SIunits.SpecificEnthalpy hLiqInl
    "Liquid enthalpy at inlet";
  Modelica.SIunits.SpecificEnthalpy hVapInl
    "Vapour enthalpy at inlet";
  Modelica.SIunits.SpecificEnthalpy hLiqOut
    "Liquid enthalpy at outlet";
  Modelica.SIunits.SpecificEnthalpy hVapOut
    "Vapour enthalpy at outlet";

  Modelica.SIunits.SpecificEnthalpy hOutIse
    "Specific isentropic enthalpy at outlet conditions";
  Modelica.SIunits.SpecificEnthalpy dh
    "Specific enthalpy difference: hOut - hInl";
  Modelica.SIunits.SpecificEnthalpy dhIse
    "Specific isentropic enthalpy difference: hOutIse - hInl";

  EngineEfficiency oveEngEff(
    Medium=Medium,
    rotSpe=rotSpe,
    piPre=piPre,
    staInl=staInl,
    staOut=staOut)
    "Instance of model 'engine efficiency'";
  VolumetricEfficiency oveVolEff(
    Medium=Medium,
    rotSpe=rotSpe,
    piPre=piPre,
    staInl=staInl,
    staOut=staOut)
    "Instance of model 'volumetric efficiency'";
  IsentropicEfficiency oveIseEff(
    Medium=Medium,
    rotSpe=rotSpe,
    piPre=piPre,
    staInl=staInl,
    staOut=staOut)
    "Instance of model 'isentropic efficiency'";

  Modelica.SIunits.Power PEle
    "Compressor's actual electrical power consumption";
  Modelica.SIunits.Power Q_flow_ref
    "Actual power transferred to reffrigerant";

  Modelica.SIunits.Frequency rotSpe(min=0, max=rotSpeMax)
    "Compressor's actual rotational speed";
  Real piPre(min=0, max=piPreMax, unit="1")
    "Ratio of compressor's outlet and inlet pressure";

protected
  Medium.ThermodynamicState staInl0=
    Medium.setState_pTX(p=pInl0,T=TInl0)
    "Thermodynamic state at inlet conditions at initialisation";


equation
  // Calculation of thermodynamic state at inlet conditions
  //
  staInl = Medium.setState_phX(p=pInl,h=hInl) "Thermodynamic state at inlet";
  satProInl = Medium.setSat_p(pInl) "Saturation properties at inlet";

  TInl = Medium.temperature(staInl) "Temperature at inlet";
  dInl = Medium.density(staInl) "Temperature at inlet";
  sInl = Medium.specificEntropy(staInl) "Specific entropy at inlet";

  pTriCriInl = pInl/Medium.fluidConstants[1].criticalPressure
    ">= 1, if pressure at inlet exceeds critical pressure";
  hLiqInl = Medium.bubbleEnthalpy(satProInl) "Liquid enthalpy at inlet";
  hVapInl = Medium.dewEnthalpy(satProInl) "Vapour enthalpy at inlet";
  quaInl = noEvent(if (pTriCriInl<1 and hInl<hLiqInl) then 0
    else if (pTriCriInl<1 and hInl>hLiqInl and hInl<hVapInl) then
    (hInl - hLiqInl)/max(hVapInl - hLiqInl, 1e-6) else 1.0)
    "Vapour quality at inlet";

  // Calculation of thermodynamic state at outlet conditions
  //
  staOut = Medium.setState_phX(p=pOut,h=hOut) "Thermodynamic state at outlet";
  satProOut = Medium.setSat_p(pOut) "Saturation properties at outlet";

  TOut = Medium.temperature(staOut) "Temperature at outlet";
  dOut = Medium.density(staOut) "Temperature at outlet";
  sOut = Medium.specificEntropy(staOut) "Specific entropy at outlet";

  pTriCriOut = pOut/Medium.fluidConstants[1].criticalPressure
    ">= 1, if pressure at outlet exceeds critical pressure";
  hLiqOut = Medium.bubbleEnthalpy(satProOut) "Liquid enthalpy at outlet";
  hVapOut = Medium.dewEnthalpy(satProOut) "Vapour enthalpy at outlet";
  quaOut = noEvent(if (pTriCriOut<1 and hOut<hLiqOut) then 0
    else if (pTriCriOut<1 and hOut>hLiqOut and hOut<hVapOut) then
    (hOut - hLiqOut)/max(hVapOut - hLiqOut, 1e-6) else 1.0)
    "Vapour quality at outlet";

  // Calculation of compressors characteristics
  //
  piPre = pInl/pOut "Ratio between inlet and outlet pressure";
  rotSpe = preRotSpe "Prescriped rotational speed";

  // Calculation of mass flow
  //
  m_flow = homotopy(smooth(1, noEvent(if rotSpe>0 then
                           rotSpe*oveVolEff.lamH*VDis*dInl else m_flow_lea)),
                    rotSpe*oveVolEff.lamH*VDis*Medium.density(staInl0))
    "Cover initialisation case as well as shut-down case";

  // Calculation of energy balances
  //
  hOutIse = Medium.isentropicEnthalpy(p_downstream=pOut, refState=staInl)
    "Isentropic specific enthalpy at outlet";
  oveIseEff.etaIse*dh = dhIse "Specific enthalpy difference";
  dhIse = (hOutIse - hInl) "Isentropic specific enthalpy difference";

  Q_flow_ref = m_flow *dh "Power absorbed by refrigerant";
  if useIseWor then
    oveEngEff.etaEng*PEle = Q_flow_ref "Compressor's power consumption";
  else
    oveEngEff.etaEng*PEle = m_flow *dhIse "Compressor's power consumption";
  end if;

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
