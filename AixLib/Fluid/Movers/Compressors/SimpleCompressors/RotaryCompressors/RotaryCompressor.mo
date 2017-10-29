within AixLib.Fluid.Movers.Compressors.SimpleCompressors.RotaryCompressors;
model RotaryCompressor
  "Model that describes a simple rotary compressor"
  extends BaseClasses.PartialCompressor(
    redeclare final CompressionProcesses.RotaryCompression parCom);

equation
  // Conncections of main components
  //
  connect(port_a, parCom.port_a)
    annotation (Line(points={{-100,0},{-90,0},{-10,0}}, color={0,127,255}));
  connect(parCom.port_b, port_b)
    annotation (Line(points={{10,0},{55,0},{100,0}}, color={0,127,255}));
  connect(heatPort, parCom.heatPort)
    annotation (Line(points={{0,-100},{0,-100},{0,-78},{0,-10}},
                color={191,0,0}));

  annotation (Icon(graphics={
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
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end RotaryCompressor;
