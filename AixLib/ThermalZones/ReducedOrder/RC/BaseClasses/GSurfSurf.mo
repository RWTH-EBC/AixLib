within AixLib.ThermalZones.ReducedOrder.RC.BaseClasses;
function GSurfSurf
  "calculates parameters for conductance between different surfaces of the same type"
  extends Modelica.Icons.Function;

  input Modelica.Units.SI.Area[:] AArr "Vector of areas";
  input Modelica.Units.SI.CoefficientOfHeatTransfer hRad
    "Coefficient of heat transfer for linearized radiation exchange between surfaces";
  output Modelica.Units.SI.ThermalConductance[:] UASurPai
    "Constant thermal conductance between pairs of surfaces, calculated as minimal area * hRad";
protected
  Integer cou=1 "index counter for thermal conductances";
algorithm
  cou:=0;
  if size(AArr, 1) < 2 then
    UASurPai := {0.0};
  else
    UASurPai := fill(0., sum({i for i in 1:(size(AArr, 1)-1)}));
    for i in 2:size(AArr, 1) loop
      for j in 1:(i-1) loop
        cou := cou+1;
        UASurPai[cou] := min(AArr[i], AArr[j]) * hRad;
      end for;
    end for;
  end if;

  annotation (Documentation(info="<html>
  <p>Calculates hRad * (min(a, b)) for each UASurPai value. (a, b) are entries of AArr as follows: (2, 1); (3, 1); (3, 2); (4, 1); (4, 2); (4, 3); ...
  </p>
  </html>", revisions="<html>
  <ul>
  <li>April 20, 2023 by Philip Groesdonk:<br/>
  First Implementation. This is for AixLib issue
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1080\">#1080</a>.
  </li>
  </ul>
  </html>"));
end GSurfSurf;
