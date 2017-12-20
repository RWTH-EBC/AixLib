within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.HeatExchangers;
model BaseExampleEvaporator
  "This model is a base model for all example models of moving boundary cells"

  // Definition of the medium
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    "Current working medium of the heat exchanger"
    annotation(Dialog(tab="General",group="General"),
              choicesAllMatching=true);
  replaceable package MediumSec =
    Modelica.Media.Air.ReferenceAir.Air_ph
    "Current working medium of the heat exchanger"
    annotation(Dialog(tab="General",group="General"),
              choicesAllMatching=true);

  // Further media models
  //
  // WorkingVersion.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
  // Modelica.Media.R134a.R134a_ph
  // ExternalMedia.Examples.R134aCoolProp
  // HelmholtzMedia.HelmholtzFluids.R134a

  // Definition of parameters describing state properties
  //
  parameter Modelica.SIunits.Temperature TOut = 263.15
    "Actual temperature at outlet conditions"
    annotation (Dialog(tab="General",group="Primary fluid"));
  parameter Modelica.SIunits.AbsolutePressure pOut=
    Medium.pressure(Medium.setDewState(Medium.setSat_T(TOut+5)))
    "Actual set point of the heat exchanger's outlet pressure"
    annotation (Dialog(tab="General",group="Primary fluid"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.05
    "Nominal mass flow rate"
    annotation (Dialog(tab="General",group="Primary fluid"));

  parameter Modelica.SIunits.MassFlowRate m_flow_sec = 3.5
    "Nominal mass flow rate"
    annotation (Dialog(tab="General",group="Secondary fluid"));
  parameter Modelica.SIunits.Temperature TInl = 283.15
    "Actual temperature at outlet conditions"
    annotation (Dialog(tab="General",group="Secondary fluid"));

  // Definition of subcomponents
  //
  Sources.MassFlowSource_h souPri(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_h_in=true,
    nPorts=1)      "Source that provides a constant mass flow rate with a prescribed specific
    enthalpy"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Sources.Boundary_ph sinPri(
    redeclare package Medium = Medium,
    use_p_in=true,
    p=pOut,
    nPorts=1)
            "Sink that provides a constant pressure" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-30})));

   Modelica.Blocks.Sources.Ramp ramMFlow(
    duration=6400,
    offset=m_flow_nominal,
    height=m_flow_nominal/15)
    "Ramp to provide dummy signal formass flow rate at inlet"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
   Modelica.Blocks.Sources.Ramp ramEnt(
    duration=6400,
    offset=175e3,
    height=-100e1)
    "Ramp to provide dummy signal for specific enthalpy at inlet"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
   Modelica.Blocks.Sources.Ramp ramPre(
    duration=6400,
    height=-100e3,
    offset=pOut)
    "Ramp to provide dummy signal for pressure at outlet"
    annotation (Placement(transformation(extent={{100,-20},{80,0}})));

  SimpleHeatExchangers.SimpleEvaporator eva(
    redeclare package Medium2 = Medium,
    redeclare package Medium1 = MediumSec,
    iniSteStaWal=false,
    iniSteStaSec=false,
    useFixStaValPri=false,
    calBalEquPri=false,
    calBalEquWal=false,
    modCVPar=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.ModeCV.SC,
    useFixModCV=false,
    typHX=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.TypeHX.CounterCurrent)
    "Moving boundary evaporator"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));

  Sources.MassFlowSource_T souSec(
    use_m_flow_in=false,
    m_flow=m_flow_sec,
    T=TInl,
    nPorts=1,
    redeclare package Medium = MediumSec)
    "Source that provides a constant mass flow rate with a prescribed temperature"
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
  Sources.Boundary_ph sinSec(
    use_p_in=false,
    nPorts=1,
    redeclare package Medium = MediumSec,
    p=101325) "Sink that provides a constant pressure"
    annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,30})));


equation
  // Connection of main components
  //
  connect(ramMFlow.y, souPri.m_flow_in)
    annotation (Line(points={{-79,-10},{-72,
          -10},{-72,-22},{-60,-22}}, color={0,0,127}));
  connect(ramEnt.y, souPri.h_in)
    annotation (Line(points={{-79,-40},{-72,-40},{-72,
          -26},{-62,-26}}, color={0,0,127}));
  connect(ramPre.y, sinPri.p_in)
    annotation (Line(points={{79,-10},{74,-10},{74,
          -22},{62,-22}}, color={0,0,127}));



  connect(souPri.ports[1], eva.port_a2) annotation (Line(points={{-40,-30},{-36,
          -30},{-30,-30},{-30,-6},{-10,-6}}, color={0,127,255}));
  connect(eva.port_b2, sinPri.ports[1]) annotation (Line(points={{10,-6},{20,-6},
          {30,-6},{30,-30},{40,-30}}, color={0,127,255}));
  connect(souSec.ports[1], eva.port_a1) annotation (Line(points={{40,30},{30,30},
          {30,6},{10,6}}, color={0,127,255}));
  connect(eva.port_b1, sinSec.ports[1]) annotation (Line(points={{-10,6},{-20,6},
          {-30,6},{-30,30},{-40,30}}, color={0,127,255}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"), Icon(graphics={
      Ellipse(
        extent={{-80,80},{80,-80}},
        lineColor={215,215,215},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{-55,55},{55,-55}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-60,14},{60,-14}},
        lineColor={215,215,215},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid,
        rotation=45)}), experiment(StopTime=6400));
end BaseExampleEvaporator;
