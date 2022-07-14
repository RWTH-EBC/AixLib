within AixLib.DataBase.HeatPump.Functions.IcingFactor;
partial function PartialBaseFct "Base function for all icing factor functions"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.ThermodynamicTemperature T_flow_ev
    "Evaporator supply temperature";
  input Modelica.Units.SI.ThermodynamicTemperature T_ret_ev
    "Evaporator return temperature";
  input Modelica.Units.SI.ThermodynamicTemperature T_oda
    "Outdoor air temperature";
  input Modelica.Units.SI.MassFlowRate m_flow_ev
    "Mass flow rate at the evaporator";
  output Real iceFac(min=0, max=1) "Efficiency factor (0..1) to estimate influence of icing. 0 means no heat is transferred through heat exchanger (fully frozen). 1 means no icing/frosting.";

  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Base function for calculation of the icing factor. The normalized
  value represents reduction of heat exchange as a result of icing of
  the evaporator.
</p>
<p>
  iceFac: Efficiency factor (0..1) to estimate influence of icing. 0
  means no heat is transferred through heat exchanger (fully frozen); 1
  means no icing/frosting.
</p>
</html>"));
end PartialBaseFct;
