within AixLib.HVAC.Interfaces;
partial model TwoPortMoistAir "Component with two moist air ports"
  Modelica.SIunits.PressureDifference dp
    "Pressure drop between the two ports (= port_a.p - port_b.p)";
  PortMoistAir_a portMoistAir_a annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  PortMoistAir_b portMoistAir_b annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
equation
  dp = portMoistAir_a.p - portMoistAir_b.p;
  annotation( Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Two Port Model for Moist Air</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end TwoPortMoistAir;
