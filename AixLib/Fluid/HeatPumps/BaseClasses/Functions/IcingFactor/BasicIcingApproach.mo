within AixLib.Fluid.HeatPumps.BaseClasses.Functions.IcingFactor;
function BasicIcingApproach
  "A function which utilizes the outdoor air temperature and current heat flow from the evaporator"
  extends PartialBaseFct;
protected
  Real TEva_m "Medium temperature at evaporator in degC";
  Modelica.SIunits.Time timer = 0 "Timer to reduce icing factor";
  Modelica.SIunits.Time maxTimeNoDefrost = 86400*3 "Maximal time without defrost";
  Real rel_value "Relative value based on time and outside temperature";
  Modelica.SIunits.ThermodynamicTemperature T_flow_ev_crit=273.15;
algorithm
  //Check if icing is an issue at current Toda (greater 5 degC defrost is not regarded)
  rel_value :=(timer/maxTimeNoDefrost)*(T_flow_ev/T_flow_ev_crit);
  if T_oda < 278.15 then
    iceFac :=sqrt(1-rel_value^2);
  else
    iceFac :=1;
  end if;

end BasicIcingApproach;
