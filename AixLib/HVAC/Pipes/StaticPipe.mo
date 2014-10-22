within AixLib.HVAC.Pipes;
model StaticPipe
  extends Interfaces.TwoPort;

  import Modelica.Math;

  parameter Modelica.SIunits.Length D=0.05 "Diameter";
  parameter Modelica.SIunits.Length l=1 "Length";
  parameter Modelica.SIunits.Length e=2.5e-5 "Roughness";

  Modelica.SIunits.ReynoldsNumber Re(nominal=1e5) "Reynolds number";
  Real lambda2 "Modified friction factor";

equation
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  lambda2 =  abs(dp)*2*D^3*rho/(l*mu*mu);
  Re = -2*sqrt(lambda2)*Math.log10(2.51/sqrt(lambda2+1e-10) + 0.27*(e/D));
  m_flow =  sign(dp)*Modelica.Constants.pi/4*D*mu*Re;

  annotation (Icon(graphics={                   Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder)}),
Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>",
info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model of a straight pipe with constant cross section and with steady-state mass, momentum and energy balances, i.e., the model does not store mass or energy. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model uses a modified friction factor to estimate the Reynolds number. Using Hagen&ndash;Poiseuille equation, the pressure drop and mass flow rate are calculated using the Reynolds number. The model is only valid for turbulent flow. </p>
<h4><span style=\"color:#008000\">Numerical Issues</span></h4>
<p>With the stream connectors the thermodynamic states on the ports are generally defined by models with storage or by sources placed upstream and downstream of the static pipe. Other non storage components in the flow path may yield to state transformation. Note that this generally leads to nonlinear equation systems if multiple static pipes, or other flow models without storage, are directly connected. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Pipes.Examples.StaticPipe_Validation\">AixLib.HVAC.Pipes.Examples.StaticPipe_Validation</a></p>
</html>"));
end StaticPipe;
