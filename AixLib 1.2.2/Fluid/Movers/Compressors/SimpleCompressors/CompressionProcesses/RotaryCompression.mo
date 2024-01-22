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
  hOutIse = Medium.specificEnthalpy(Medium.setState_psX(p=pOut,
    s=Medium.specificEntropy(staInl)))
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
  port_b.h_outflow = smooth(1,noEvent(if m_flow > 0
    then hInl + dh else inStream(port_a.h_outflow)))
    "Compressor behaves as perfect valve if flow is reserved";
  /*It is assumed that the compressor works as perfectly closed valve if the 
    mass flow is reserved. Hence, specific enthalpies flowing out of the system
    will meet the specific enthalpies flowing into the system.
  */

  // Connect heat port with internal variables
  //
  heatPort.Q_flow = Q_flow_ref-PEle;

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a model describing the compression process of a rolling
  piston type rotary (i.e. rotary) compressor. The model is based on a
  grey-box approach and, therefore, it inherits from <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
  AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>.
  Consequently, the model uses three efficiencies that must be
  redefined by the User:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency\">
    Overall engine efficiency</a>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency\">
    Overall isentropic efficiency</a>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency\">
    Overall volumetric efficiency</a>
  </li>
</ul>
<h4>
  References
</h4>
<p>
  In the following, some general references are given for information
  about the compression process:
</p>
<p>
  W. Eifler, E. Schlücker, U. Spicher and G. Will (2009): <a href=
  \"http://dx.doi.org/10.1007/978-3-8348-9302-4\">Küttner
  Kolbenmaschinen: Kolbenpumpen, Kolbenverdichter, Brennkraftmaschinen
  (in German)</a>. Publisher: <i>Vieweg + Teubner</i>
</p>
<p>
  P.C. Hanlon (2011): <a href=
  \"https://apvgn.pt/wp-content/uploads/compressor_handbook_hanlon.pdf\">Compressor
  Handbook</a>. Publisher: <i>McGraw-Hill</i>
</p>
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
