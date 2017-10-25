within AixLib.FastHVAC.Components.Storage.BaseClasses;
package buoyancyDitribution

  partial function buoyancyDist
                                //Distribution of massflow over the layers i set by a predefined profile (linear,square, cubic, inv ...)
    input Integer i
                   "position of the layer emitting buoyant mass flow";
    input Integer j
                   "position of the highest layer receiving buoyant mass flow";
    input Integer n
                   "total number of layers";
    input Modelica.SIunits.Temperature T[n]
                                           "Temperature of layers";
    output Real[n] y           "mass fraction of buoyant current received (-1 for emitting layer)";

  end buoyancyDist;

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

  function buoyancyDistQuad
    extends buoyancyDist;
  protected
    Real[ j-i] p;

  algorithm
    y[1:i-1]:=zeros(i-1);
    y[j+1:n]:=zeros(n-j);
    y[i]:=-1;

    for s in 1:(j-i) loop
      p[s]:=s^2;

    end for;
    y[i+1:j]:=p/sum(p[:]);

  end buoyancyDistQuad;

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

  function buoyancyDistInv
    extends buoyancyDist;

  protected
    Real[ j-i] p;

  algorithm
    y[1:i-1]:=zeros(i-1);
    y[j+1:n]:=zeros(n-j);
    y[i]:=-1;

    for s in 1:(j-i) loop
      p[s]:=1/(j-i+1-s);

    end for;
    y[i+1:j]:=p/sum(p[:]);
  end buoyancyDistInv;

  function buoyancyDistInv2
    extends buoyancyDist;

  protected
    Real[ j-i] p;

  algorithm
    y[1:i-1]:=zeros(i-1);
    y[j+1:n]:=zeros(n-j);
    y[i]:=-1;

    for s in 1:(j-i) loop
      p[s]:=1/(j-i+1-s)^2;

    end for;
    y[i+1:j]:=p/sum(p[:]);
  end buoyancyDistInv2;
end buoyancyDitribution;
