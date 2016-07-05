within AixLib.HVAC.Ductwork.BaseClasses;
partial model SimplePressureLoss
  extends Interfaces.TwoPortMoistAirTransportFluidprops;
  parameter Modelica.SIunits.Length D = 0.3 "Diameter of component";
  Modelica.SIunits.VolumeFlowRate Volflow(min = 0) "Volume Flow";
  Real zeta_var;
equation
  Volflow = portMoistAir_a.m_flow * (1 + X_Steam) / rho_MoistAir;
  dp = 8 * zeta_var * rho_MoistAir / D ^ 4 / Modelica.Constants.pi ^ 2 * abs(Volflow) * Volflow;
  annotation( Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple partial pressure loss model based on zeta value, which in this case given as a variable.</p>
 </html>", revisions = "<html>
 <p>30.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {100, 40}}), graphics));
end SimplePressureLoss;
