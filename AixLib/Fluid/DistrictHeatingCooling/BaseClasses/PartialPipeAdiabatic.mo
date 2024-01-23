within AixLib.Fluid.DistrictHeatingCooling.BaseClasses;
partial model PartialPipeAdiabatic
  "Base class for an adiabatic pipe connection in DHC systems"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;

  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Length dh=sqrt(4*m_flow_nominal/rho_default/v_nominal/Modelica.Constants.pi)
    "Hydraulic diameter (assuming a round cross section area)"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Velocity v_nominal = 1.5
    "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)"
    annotation(Dialog(group="Nominal condition"));

  parameter Real ReC=4000
    "Reynolds number where transition to turbulent starts";

  parameter Modelica.SIunits.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Length length "Pipe length"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate m_flow_small = 1E-4*abs(
    m_flow_nominal) "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.SpecificHeatCapacity cPip=2300
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Density rhoPip(displayUnit="kg/m3")=930
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Length thickness = 0.0035
    "Pipe wall thickness"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Temperature T_start_in(start=Medium.T_default)=
    Medium.T_default "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature T_start_out(start=Medium.T_default)=
    T_start_in "Initialization temperature at pipe outlet"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean initDelay(start=false) = false
    "Initialize delay for a constant mass flow rate if true, otherwise start from 0"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.MassFlowRate m_flow_start=0 "Initial value of mass flow rate through pipe"
    annotation (Dialog(tab="Initialization", enable=initDelay));

  parameter Real fac=1
    "Factor to take into account flow resistance of bends etc., fac=dp_nominal/dpStraightPipe_nominal";

  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));


protected
  parameter Modelica.SIunits.HeatCapacity CPip=
    length*((dh + 2*thickness)^2 - dh^2)*Modelica.Constants.pi/4*cPip*rhoPip "Heat capacity of pipe wall";

  final parameter Modelica.SIunits.Volume VEqu=CPip/(rho_default*cp_default)
    "Equivalent water volume to represent pipe wall thermal inertia";

  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";

  parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";

  parameter Real C(unit="J/(K.m)")=
    rho_default*Modelica.Constants.pi*(dh/2)^2*cp_default
    "Thermal capacity per unit length of water in pipe";

  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This base class provides an interface for adiabatic pipe models. It
  can be used to wrap around different pipe model implementations
  without representation of the thermal losses through the pipe wall.
</p>
</html>", revisions="<html>
<ul>
  <li>May 27, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end PartialPipeAdiabatic;
