within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss;
model WallFrictionAndGravity_AnnularGap
  "Pressure drop in pipe due to wall friction and gravity (for both flow directions)"
  import SI = Modelica.SIunits;
  //outer Modelica_Fluid.Ambient ambient "Ambient conditions";

 // extends Modelica_Fluid.Interfaces.PartialGuessValueParameters;
  extends Modelica.Fluid.Interfaces.PartialPressureLoss;

  replaceable function delta_p =
      AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss.delta_pAnnularGap
    constrainedby
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss.delta_p_partial
                                                            annotation (choicesAllMatching=true);

                                                            /*(choices(
           choice(redeclare function delta_p =
      Kristian_HVAC.BaseClasses.PressureLosses.delta_pAnnularGap 
          "Annular Gap laminar and turbulent regime"),
           choice(redeclare function delta_p =
      Kristian_HVAC.BaseClasses.PressureLosses.delta_pAnnularGap_turbulent 
          "Annular Gap turbulent regime")));*/

  parameter SI.Length length=1 "Length of pipe";
  parameter SI.Diameter d_in=0.01 "inner diameter of annular gap";
  parameter SI.Diameter d_ou=0.02 "outer diameter of annular gap";
  parameter SI.Length height_ab = 0.0 "Height(port_b) - Height(port_a)"
                                                                     annotation(Evaluate=true);
  parameter SI.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
      annotation(Dialog(enable=WallFriction.use_roughness));

// should be provided by the calling module:
  SI.DynamicViscosity eta "Dynamic Viscosity";
  SI.Density d "Density";
  //SI.KinematicViscosity ny=eta/d;

equation
   d= if noEvent(m_flow>0) then d_a else d_b;
  eta=if noEvent(m_flow>0) then eta_a else eta_b;
   dp = delta_p(d_i=d_in, d_o=d_ou, L=length, m_dot=m_flow, d=d, height=height_ab,ny=eta/d);

  annotation (defaultComponentName="pipe",Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-100,30},{100,-70}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,16},{100,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Text(
          extent={{-148,87},{142,38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString=
               "%name"),
        Rectangle(
          extent={{-100,-3},{100,-38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={158,158,158})}),      Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This model describes pressure losses due to <b>wall friction</b> in an annular gap. It is assumed that no mass or energy is stored in the pipe. Correlations of different complexity and validity can be seleted via the replaceable package delta_p. </p>
</html>",
    revisions="<html>
<p><ul>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>Implemented.</li>
</ul></p>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-100,37},{100,-91}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,16},{100,-15}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,49},{100,49}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.Filled}),
        Text(
          extent={{-34,70},{34,52}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString=
               "length"),
        Rectangle(
          extent={{-100,-43},{100,-74}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,15},{-70,-75}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.Filled}),
        Text(
          extent={{-70,4},{-42,-10}},
          lineColor={0,0,255},
          textString=
               "d_ou"),
        Text(
          extent={{-14,5},{21,-11}},
          lineColor={0,0,255},
          textString=
               "d_in"),
        Line(
          points={{-10,-43},{-10,-54},{-10,-6},{-10,-15}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.Filled})}),
    DymolaStoredErrors);
end WallFrictionAndGravity_AnnularGap;
