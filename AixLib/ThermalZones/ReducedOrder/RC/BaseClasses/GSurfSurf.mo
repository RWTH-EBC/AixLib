within AixLib.ThermalZones.ReducedOrder.RC.BaseClasses;
function GSurfSurf
  "calculates parameters for conductance between different surfaces of the same type"
  extends Modelica.Icons.Function;

  input Modelica.Units.SI.Area[:] AArray "Vector of areas";
  input Modelica.Units.SI.CoefficientOfHeatTransfer hRad
    "Coefficient of heat transfer for linearized radiation exchange between surfaces";
  output Modelica.Units.SI.ThermalConductance[:] G
    "Constant thermal conductance between pairs of surfaces, calculated as minimal area * hRad";
protected
  Integer g=1 "index counter for thermal conductances";
  Modelica.Units.SI.ThermalConductance G0;
algorithm
  g:=0;
  if size(AArray, 1) < 2 then
    G := {0.0};
  else
    G := fill(0., sum({i for i in 1:(size(AArray, 1)-1)}));
    for i in 2:size(AArray, 1) loop
      for j in 1:(i-1) loop
        g := g+1;
        G[g] := min(AArray[i], AArray[j]) * hRad;
      end for;
    end for;
  end if;

  annotation (Documentation(info="<html>
  <p>Calculates hRad * (min(a, b)) for each G value. (a, b) are entries of AArray as follows: (2, 1); (3, 1); (3, 2); (4, 1); (4, 2); (4, 3); ...
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
