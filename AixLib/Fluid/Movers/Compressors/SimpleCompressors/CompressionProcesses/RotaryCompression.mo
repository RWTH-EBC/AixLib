within AixLib.Fluid.Movers.Compressors.SimpleCompressors.CompressionProcesses;
model RotaryCompression
  "Model that describes the compression process of a rotary compressor"
  extends BaseClasses.PartialCompression;

equation
  // Calculation of mass flow
  //
  m_flow = homotopy(rotSpe*oveVolEff.lamH*VDis*dInl,
                    rotSpe*oveVolEff.lamH*VDis*dInl0)
    "This covers initialisation case as well as shut-down case";

  // Calculation of energy balances
  //
  hOutIse = Medium.isentropicEnthalpy(p_downstream=pOut, refState=staInl)
    "Isentropic specific enthalpy at outlet";
  oveIseEff.etaIse*dh = dhIse "Specific enthalpy difference";
  dhIse = (hOutIse - hInl) "Isentropic specific enthalpy difference";

  Q_flow_ref = m_flow *dh "Power absorbed by refrigerant";
  if not useIseWor then
    oveEngEff.etaEng*PEle = Q_flow_ref "Compressor's power consumption";
  else
    oveEngEff.etaEng*PEle = m_flow *dhIse "Compressor's power consumption";
  end if;
  /*Some efficiency models calculate the compressor's power consumptions based
    on the compressors isentropic work. Therefore, a distinction is made above.
  */

  // Calculate pressures at inlet and outlet of compressor
  //
  pInl = port_a.p "Pressure at inlet";
  pOut = port_b.p "Pressure at outlet";

  // Calculate specific enthalpies
  //
  hInl = actualStream(port_a.h_outflow) "Specific enthalpy at inlet";
  hOut = actualStream(port_b.h_outflow) "Specific enthalpy at outlet";

  port_a.h_outflow = inStream(port_a.h_outflow)
    "Compressor behaves as perfect valve if flow is reserved";
  port_b.h_outflow = smooth(0,noEvent(if m_flow > 0
    then hInl + dh else inStream(port_a.h_outflow)))
    "Compressor behaves as perfect valve if flow is reserved";
  /*It is assumed that the compressor works as perfectly closed valve if the 
    mass flow is reserved. Hence, specific enthalpies flowing out of the system
    will meet the specific enthalpies flowing into the system.
  */

  // Connect heat port with internal variables
  //
  heatPort.Q_flow = Q_flow_ref-PEle;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"), Icon(graphics={
        Ellipse(
          extent={{-60,40},{20,-40}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,28},{20,-32}},
          lineColor={0,0,0},
          fillColor={182,182,182},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-26,6},{-14,-6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,46},{-18,26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end RotaryCompression;
