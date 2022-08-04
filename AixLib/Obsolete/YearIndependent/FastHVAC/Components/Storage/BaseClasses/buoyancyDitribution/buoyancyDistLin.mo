within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.buoyancyDitribution;
function buoyancyDistLin

  extends buoyancyDist;
protected
  Real[ j-i] p;

algorithm
  // massflowfractions below layer i and above layer j are zero, massflowfraction of layer i is -1
  y[1:i-1]:=zeros(i-1);
  y[j+1:n]:=zeros(n-j);
  y[i]:=-1;

  for s in 1:(j-i) loop
    p[s]:=s;

  end for;
  y[i+1:j]:=p/sum(p[:]);

end buoyancyDistLin;
