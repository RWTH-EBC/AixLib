within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.buoyancyDitribution;
function buoyancyDistCub
  extends buoyancyDist;
protected
  Real[ j-i] p;

algorithm
  y[1:i-1]:=zeros(i-1);
  y[j+1:n]:=zeros(n-j);
  y[i]:=-1;

  for s in 1:(j-i) loop
    p[s]:=s^3;

  end for;
  y[i+1:j]:=p/sum(p[:]);

end buoyancyDistCub;
