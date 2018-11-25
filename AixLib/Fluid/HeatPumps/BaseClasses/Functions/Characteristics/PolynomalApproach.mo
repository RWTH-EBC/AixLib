within AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics;
function PolynomalApproach
  "Function to emulate the polynomal approach of the TRNSYS Type 401 heat pump model"
  extends PartialBaseFct;
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition hpData = AixLib.DataBase.HeatPump.EN255.Vitocal350AWI114()
    "Polynomal coefficients of the heat pump" annotation(choicesAllMatching = true);

protected
  Real TEva_n = T_eva/273.15 + 1 "Normalized evaporator temperature";
  Real TCon_n = T_con/273.15 + 1 "Normalized condenser temperature";
algorithm
  if N >= Modelica.Constants.eps then
    Char[1] := hpData.p[1] + hpData.p[2]*TEva_n + hpData.p[3]*TCon_n + hpData.p[4]*TCon_n*TEva_n + hpData.p[5]*TEva_n^2 + hpData.p[6]*TCon_n^2; //Pel
    Char[2] := hpData.q[1] + hpData.q[2]*TEva_n + hpData.q[3]*TCon_n + hpData.q[4]*TCon_n*TEva_n + hpData.q[5]*TEva_n^2 + hpData.q[6]*TCon_n^2; //QCon
  else //Maybe something better could be used such as smooth()
    Char[1] := 0;
    Char[2] := 0;
  end if;
  annotation (Documentation(revisions="<html>
 <li><i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)</li>
</html>"));
end PolynomalApproach;
