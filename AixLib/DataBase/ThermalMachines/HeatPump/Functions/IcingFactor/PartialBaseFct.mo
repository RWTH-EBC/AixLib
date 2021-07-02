within AixLib.DataBase.ThermalMachines.HeatPump.Functions.IcingFactor;
partial function PartialBaseFct "Base function for all icing factor functions"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.ThermodynamicTemperature T_flow_ev "Evaporator supply temperature";
  input Modelica.SIunits.ThermodynamicTemperature T_ret_ev "Evaporator return temperature";
  input Modelica.SIunits.ThermodynamicTemperature T_oda "Outdoor air temperature";
  input Modelica.SIunits.MassFlowRate m_flow_ev "Mass flow rate at the evaporator";
  output Real iceFac(min=0, max=1) "Icing factor, normalized value between 0 and 1";

  annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>", info="<html>
<p>Base function for calculation of the icing factor. The normalized value represents reduction of heat exchange as a result of icing of the evaporator.</p>
</html>"));
end PartialBaseFct;
