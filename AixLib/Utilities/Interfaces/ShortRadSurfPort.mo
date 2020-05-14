within AixLib.Utilities.Interfaces;
partial connector ShortRadSurfPort
  "Input connector for short wave radiation for a surface"
  Modelica.SIunits.Power Q_flow_rad "Short waved radiation heat flow rate";

  parameter Modelica.SIunits.Area A=0 "Area of surface";
  parameter Real eps=0 "Emissivity of surface";
  parameter Real rho=0 "Reflectivity of surface";
  parameter Real tau=0 "Transmissivity of surface";
  parameter Real alpha = eps "Absorptivity of surface, equal to eps or 1-rho-tau";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={                                                                       Polygon(points={{
            -38,44},{-22,44},{-22,14},{6,20},{10,8},{-18,2},{0,-24},{-14,-32},{-30,
            -6},{-46,-34},{-60,-26},{-44,0},{-72,10},{-66,24},{-38,14},{-38,44}},                                                                                                                                                                                                        lineColor=
            {0,0,0},                                                                                                                                                                                                        fillColor=
            {0,255,0},
            fillPattern=FillPattern.Solid),
      Text(
        extent={{-56,114},{46,84}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        textString="%name%")}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ShortRadSurfPort;
