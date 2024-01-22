within AixLib.DataBase.HeatPump.Functions.Characteristics;
function PolynomalApproach
  "Function to emulate the polynomal approach of the TRNSYS Type 401 heat pump model"
  extends PartialBaseFct;
  parameter Modelica.Units.SI.Power p[6]={0,0,0,0,0,0}
    "Polynomal coefficient for the electrical power";
  parameter Modelica.Units.SI.HeatFlowRate q[6]={0,0,0,0,0,0}
    "Polynomal coefficient for the condenser heat flow";

protected
  Real TEva_n = T_eva/273.15 + 1 "Normalized evaporator temperature";
  Real TCon_n = T_con/273.15 + 1 "Normalized condenser temperature";
algorithm
  if N >= Modelica.Constants.eps then
    Char[1] := p[1] + p[2]*TEva_n + p[3]*TCon_n + p[4]*TCon_n*TEva_n + p[5]*TEva_n^2 + p[6]*TCon_n^2; //Pel
    Char[2] := q[1] + q[2]*TEva_n + q[3]*TCon_n + q[4]*TCon_n*TEva_n + q[5]*TEva_n^2 + q[6]*TCon_n^2; //QCon
  else //Maybe something better could be used such as smooth()
    Char[1] := 0;
    Char[2] := 0;
  end if;
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Based on the work of Afjej and Wetter, 1997 [1] and the TRNYS Type
  401 heat pump model, this function uses a six-coefficient polynom to
  calculate the electrical power and the heat flow to the condenser.
  The coefficients are calculated based on the data in DIN EN 14511
  with a minimization-problem in python using the
  root-mean-square-error.
</p>
<p>
  The normalized input temperatures are calculated with the formular:
</p>
<p style=\"text-align:center;\">
  <i>T_n = (T/273.15) + 1</i>
</p>
<p>
  The coefficients for the polynomal functions are stored inside the
  record for heat pumps in <a href=
  \"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a>.
</p>
<p>
  [1]: https://www.trnsys.de/download/en/ts_type_401_en.pdf
</p>
</html>"));
end PolynomalApproach;
