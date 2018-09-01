within AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves;
model FlowExpansionValve
import SI = Modelica.SIunits;
  import Modelica.Fluid.Types.CvTypes;
  import Modelica.Fluid.Utilities;

  //PartialTwoPhaseMedium
  extends BaseClasses.BaseValves.PartialFlowIsenthalpicValve(
                                                  redeclare replaceable package
              Medium = Modelica.Media.R134a.R134a_ph constrainedby
      Modelica.Media.Interfaces.PartialTwoPhaseMedium);

  replaceable function FlCharacteristic =
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.one
    constrainedby
    Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
    "Pressure recovery characteristic";

parameter ExpansionValves.Utilities.Types.FlowProc FlowProc = ExpansionValves.Utilities.Types.FlowProc.Compressible;


equation
   // C_d = flowCoefficient.C_d;
    C_d = 0.94;

    m_flow_incompressibel^2 = if staInl.phase == 1 and staOut.phase == 1 then C_d^2*AThr^2*d_inlet*(port_a.p - port_b.p) else C_d^2*AThr^2*d_inlet*(port_a.p - satInl.psat);
    //m_flow_compressibel^2 = if b > 0 then x_outlet*C_d^2*AThr^2*Y^2*2*d_sat_ph*satInl.psat+(1-x_outlet)*C_d^2*AThr^2*d_inlet*(satInl.psat - port_b.p) else  x_outlet*C_d^2*AThr^2*Y^2*2*d_inlet*(port_a.p)+(1-x_outlet)*C_d^2*AThr^2*d_inlet*(port_a.p - port_b.p);
  m_flow_compressibel^2 =  if staInl.phase == 1 and staOut.phase == 1 then 0 elseif  b > 0 then  x_outlet^2*(C_d^2*AThr^2*Y^2*2*d_sat_ph*satInl.psat)+(1-x_outlet)^2*C_d^2*AThr^2*d_inlet*(satInl.psat - port_b.p) else
  x_outlet^2*C_d^2*AThr^2*Y^2*2*d_inlet*pInl+(1-x_outlet)^2*C_d^2*AThr^2*2*d_inlet*(pInl-pOut);




if
  (FlowProc == ExpansionValves.Utilities.Types.FlowProc.Incompressible) then


  //m_flow^2 = if x_krit < x then C_d^2*AThr^2*d_inlet*(port_a.p - port_b.p) else C_d^2*AThr^2*Y_critical^2*d_inlet*pInl;
      m_flow^2 =  C_d^2*AThr^2*d_inlet*(port_a.p - port_b.p);
elseif
      (FlowProc == ExpansionValves.Utilities.Types.FlowProc.Compressible) then

   m_flow = a*m_flow_compressibel +b*m_flow_incompressibel;

else
   assert(false, "Invalid choice of calculation procedure");
  end if;
end FlowExpansionValve;
