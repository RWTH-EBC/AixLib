within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer;
class HeatConv_AnnularGap "Wrapper module for heat convection in annular gaps"
  import SI = Modelica.SIunits;
  /*
    Choose the appropriate function to compute alpha via GUI
    Possible choices in BaseLib.BaseClasses.HeatTransfer.Effects
    (Please revisit annotation statement when applying changes!)
  */
  replaceable function alpha =
     AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alpha_partial
    constrainedby
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alpha_partial
    "single phase medium in pipe"
    annotation(choicesAllMatching=true);

  parameter SI.Length d_i=0.01 "inner diameter of annular gap";
  parameter SI.Length d_o=0.01 "outer diameter of annular gap";
  parameter SI.Length L=1 "length of pipe";
  parameter SI.Area A=d_i*Modelica.Constants.pi*L;
  SI.CoefficientOfHeatTransfer alph "Coefficient of Heat Transfer";

//  Modelica.Blocks.Interfaces.RealInput m_dot "Mass flow rate" annotation 1;

  //SI.MassFlowRate m_flow "Mass flow rate in pipe";
  // should be provided by the calling module:
  // SI.CoefficientOfHeatTransfer alph "Coefficient of Heat Transfer"; // holds aplha value
  parameter SI.DynamicViscosity eta=1139.0*10e-6 "Dynamic Viscosity";
  parameter SI.Density d=999.2 "Density";
  parameter SI.ThermalConductivity lambda=0.5911 "thermal Conductivity";
  parameter SI.HeatCapacity cp=4186 "heat Capacity at constant pressure J/kgK";
  final parameter SI.PrandtlNumber Pr_w=eta*cp/lambda "Prandtl Number at Wall"; // may be submitted if value is known

  Modelica.Blocks.Interfaces.RealInput m_flow(unit="kg/s")
    annotation (Placement(transformation(extent={{-20,60},{20,100}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{82,-10},{102,10}})));
equation
  alph = alpha(
      d_i=d_i,
      d_o=d_o,
      L=L,
      eta=eta,
      d=d,
      lambda=lambda,
      cp=cp,
      Pr_w=Pr_w,
      m_dot=m_flow);

  port_a.Q_flow = alph*A*(port_a.T - port_b.T);

  port_a.Q_flow + port_b.Q_flow = 0;

  annotation (
      Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
      Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-80,80},{0,-80}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={211,243,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-80,80},{80,-80}},  lineColor={0,0,0}),
        Rectangle(
          extent={{60,80},{80,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={244,244,244},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,80},{60,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,80},{40,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={182,182,182},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,80},{20,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-80},{100,-120}},
          lineColor={0,0,255},
          textString="%name")}),
      Window(
        x=0.25,
        y=0.38,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><br><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The <b>HeatConv_AnnularGap</b> model represents the phenomenon of heat convection inside of an annular gap. It can be used to implement heat transfer of different phenomena under conditions of laminar and trubulent flow. The phenomenom can be described by different functions. The model is used in the CoaxialPipeElement.</p>
</html>",
      revisions="<html>
<li><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>moved to library once again and made some changes for proper use in new CoaxialPipeElement model.</li>
<li><i>March 25, 2009&nbsp;</i> by Kristian Huchtemann:<br/>changed for use in annular gap </li>
<li><i>January 09, 2006&nbsp;</i> by Peter Matthes:<br/>V0.1: Initial configuration.</li>
<li>by Peter Matthes:<br/>implemented </li>
</ul></li>
</ul></p>
</html>"),
    DymolaStoredErrors);
end HeatConv_AnnularGap;
