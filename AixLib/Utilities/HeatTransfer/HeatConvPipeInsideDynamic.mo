within AixLib.Utilities.HeatTransfer;
model HeatConvPipeInsideDynamic
  "Dynamic model for Heat Transfer through convection inside a pipe, based on Nussel Correlations"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Modelica.Units.SI.Length length=1 "Length of total pipe";
  parameter Modelica.Units.SI.Length d_i=0.02 "Inner diameter of exhaust pipe";
  parameter Modelica.Units.SI.Area A_sur=2 "Surface for heat transfer";
  parameter Boolean calculateHConv=true
    "Use calculated value for inside heat coefficient";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConvInsideFix=30
    annotation (Dialog(enable=not calculateHConv));
  input Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate of gas";
  input Modelica.Units.SI.SpecificHeatCapacity c
    "Heat capacity of considered medium" annotation (Dialog(group="Parameters"));
  input Modelica.Units.SI.Density rho "Density of considered medium"
    annotation (Dialog(group="Parameters"));
  input Modelica.Units.SI.ThermalConductivity lambda
    "Thermal conductivity of considered medium"
    annotation (Dialog(group="Parameters"));
  input Modelica.Units.SI.DynamicViscosity eta
    "Dynamic viscosity of considered medium"
    annotation (Dialog(group="Parameters"));
  Modelica.Units.SI.ReynoldsNumber Re;
  Modelica.Units.SI.Velocity v;
  Modelica.Units.SI.NusseltNumber Nu;
  Modelica.Units.SI.NusseltNumber Nu_lam_1;
  Modelica.Units.SI.NusseltNumber Nu_lam_2;
  Modelica.Units.SI.NusseltNumber Nu_lam;
  Modelica.Units.SI.NusseltNumber Nu_tur;
  Modelica.Units.SI.PrandtlNumber Pr;
  Modelica.Units.SI.CoefficientOfHeatTransfer alpha;
  Real zeta "pressure loss coefficient";

equation
  if calculateHConv then
    v      =        4*m_flow/(Modelica.Constants.pi * d_i^2 * rho);
    Re     =    Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
      v,rho,eta, d_i)              "Reynolds numbers";
    Pr     =        eta *c /lambda;
    zeta   =        (1.8*log10(max(1e-10,Re))-1.5)^(-2);
    Nu_lam_1 =      3.66;
    Nu_lam_2 =      1.615 * (Re*Pr*d_i/length)^(1/3);
    Nu_lam   =      (Nu_lam_1^3 + 0.7^3 + (Nu_lam_2 - 0.7)^3)^(1/3);
    Nu_tur   =      (zeta/8*Re*Pr)/(1+12.7*(zeta/8)^0.5*(Pr^(2/3)-1))*(1+(d_i/length)^(2/3));
    Nu       =      smooth(0,if Re<=2300 then Nu_lam else Nu_tur);
  else
    //prevent solver from solving the equations if they are not used
    v=0;
    Re=0;
    Pr=0;
    zeta=0;
    Nu_lam_1=0;
    Nu_lam_2=0;
    Nu_lam=0;
    Nu_tur=0;
    Nu=0;
    end if;
  alpha    =      if calculateHConv then Nu  * lambda /d_i else hConvInsideFix;
  port_a.Q_flow = alpha * A_sur * (port_a.T - port_b.T);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,   extent={{-100,
            -100},{100,100}}),                                                                                                                                                                                                        lineColor = {0, 0, 0}, pattern = LinePattern.Solid, fillColor = {211, 243, 255}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}),                                                                                                                                                                                                        Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),                                                                                                                                                                                                        graphics={  Rectangle(extent={{-80,80},{0,-80}},      lineColor = {0, 0, 0}, pattern = LinePattern.None, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid),                                                                    Rectangle(extent={{60,80},{80,-80}},      lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {244, 244, 244},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{40,80},{60,-80}},      lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {207, 207, 207},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{20,80},{40,-80}},      lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {182, 182, 182},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{0,80},{20,-80}},      lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{-80,80},{80,-80}},      lineColor = {0, 0, 0})}),
                                                                                                                                                  Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model represents the phenomenon of heat convection inside a pipe
  by a flowing medium.
</p>
<p>
  The heat transfer coefficient at the inside could be calculated by
  formular from VDI-Waermeatlas or a fixed value can be choosen.
</p>
<ul>
  <li>
    <i>August 11, 2017;</i> by David Jansen:<br/>
  </li>
</ul>
</html>"));
end HeatConvPipeInsideDynamic;
