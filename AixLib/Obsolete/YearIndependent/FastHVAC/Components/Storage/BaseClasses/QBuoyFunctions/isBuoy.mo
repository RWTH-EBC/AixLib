within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function isBuoy
    input Integer n;
  input Modelica.Units.SI.Temperature T[n];

  output Boolean isBuoy;

algorithm

  isBuoy:=false;

  for i in 1:n-1 loop

    if T[i]>T[i+1] then
      isBuoy:=true;

    end if;

  end for;

end isBuoy;
