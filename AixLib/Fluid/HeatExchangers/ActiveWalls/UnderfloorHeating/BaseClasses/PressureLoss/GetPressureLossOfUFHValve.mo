within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PressureLoss;
function GetPressureLossOfUFHValve
  "Function to evaluate the pressure loss for regulating valve of heating circuit."
  input Modelica.SIunits.VolumeFlowRate vol_flow "Volume flow rate";
  input Modelica.SIunits.PressureDifference dp_Pipe "Pressure Drop in Pipe";
  output Modelica.SIunits.PressureDifference preDrop "Pressure drop for the given input";
protected
  Real vol_flow_internal= vol_flow*1000*3600 "Used for conversion of m^3/s to litre/h";
  Real table_internal "Table with offset for the different Kv-Values";
  Real K_v(max=1.02) = vol_flow*3600 * sqrt(10^5 / dp_Pipe) "Kv-value for valve";
  // Based on the table in Schuetz Energy Systems - see info.
  parameter Real slope=2.05 "Constant for every Kv-value";
  Real offset "Output of the table";
algorithm
  assert(vol_flow_internal <= 1000, "Volume flow is too high, maximum 1000 L/h", level = AssertionLevel.error);
  assert(K_v <= 1.02, "K_v value for valve is "+String(K_v)+" and exceeds maximum of 1.02, check m_flow or dp_pipe for reasonable pressure drop in valve", AssertionLevel.warning);
  // Based on the table in Schuetz Energy Systems- see info.
    if K_v <= 0.56 then
    offset := -12.08;
    elseif K_v <= 0.85 then
    offset := -13.02;
    elseif K_v < 1.02 then
    offset := -13.89;
    else
    offset:= -14.18;
  end if;
  preDrop := Modelica.Constants.e^(slope * Modelica.Math.log(vol_flow_internal) + offset)*1000;
  annotation (Documentation(info="<html>
<p>Get the pressure loss of an under floor heating valve. The data is calculated based on the log-log-diagram in the following image. Based on [1, p. 11].</p>
<p><img src=\"modelica://UnderfloorHeating/Resources/PressureLossOfUFHValve.png\"/></p>
<p>[1] SCH&Uuml;TZ ENERGY SYSTEMS: Heizkreisverteiler: Montageanleitung/- Technische Information. 2017; <a href=\"https://www.schuetz-energy.net/downloads/anleitungen/montageanleitung-heizkreisverteiler/schuetz-montageanleitung-fbh-heizkreisverteiler-de.pdf\">Link to pdf</a></p>
</html>"));
end GetPressureLossOfUFHValve;
