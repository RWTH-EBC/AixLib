within AixLib.Fluid.HeatPumps.BaseClasses.Functions.IcingFactor;
function BasicIcingApproach
  "A function which utilizes the outdoor air temperature and current heat flow from the evaporator"
  extends PartialBaseFct;
protected
  Real TEva_m "Medium temperature at evaporator in degC";
algorithm
  //Calculate the medium temperature at the evaporator
  TEva_m :=0.5*(T_flow_ev + T_ret_ev) - 273.15;
  //Check if icing is an issue at current Toda (greater 5 degC defrost is not regarded)
  if T_oda < 278.15 then
    iceFac :=1-(5-TEva_m)/25;
  else
    iceFac :=1;
  end if;

end BasicIcingApproach;
