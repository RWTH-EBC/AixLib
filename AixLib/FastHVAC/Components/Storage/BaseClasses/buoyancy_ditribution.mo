within AixLib.FastHVAC.Components.Storage.BaseClasses;
package buoyancy_ditribution

  partial function buoyancy_dist
    input Integer i
                   "position of the layer emitting buoyant mass flow";
    input Integer j
                   "position of the highest layer receiving buoyant mass flow";
    input Integer n
                   "total number of layers";
    input Modelica.SIunits.Temperature T[n]
                                           "Temperature of layers";
    output Real[n] y           "mass fraction of buoyant current received (-1 for emitting layer)";

  end buoyancy_dist;

  function buoyancy_dist_lin
    extends buoyancy_dist;
  protected
    Real[ j-i] p;

  algorithm
    y[1:i-1]:=zeros(i-1);
    y[j+1:n]:=zeros(n-j);
    y[i]:=-1;

    for s in 1:(j-i) loop
      p[s]:=s;

    end for;
    y[i+1:j]:=p/sum(p[:]);

  end buoyancy_dist_lin;

  function buoyancy_dist_quad
    extends buoyancy_dist;
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

  end buoyancy_dist_quad;

  function buoyancy_dist_cub
    extends buoyancy_dist;
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

  end buoyancy_dist_cub;

  function buoyancy_dist_inv
    extends buoyancy_dist;

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
  end buoyancy_dist_inv;

  function buoyancy_dist_inv2
    extends buoyancy_dist;

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
  end buoyancy_dist_inv2;
end buoyancy_ditribution;
