within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qTopmix

  input Integer n;
  input Integer nbuoy;
  input Integer nstop;
  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dTborder;

  output Modelica.Units.SI.SpecificEnergy q_topmix[n];

protected
  Integer dn_gap;
  Real ftopdown_sum;
  Real ftopup_sum;
  Real c_td;
  Real c_tu;

  Modelica.Units.SI.SpecificEnergy qt0;

algorithm

  q_topmix:=zeros(n);

  if dTborder<>0 then
    dn_gap:=nstop - nbuoy - 1;
    qt0:=qtop(dTover,dTborder,dn_gap);

  //heat distribution downwards of border, where i is the distance to the border

    c_td:=cTopDown(
        dTover,
        dTborder,
        dn_gap);
    c_tu:=cTopUp(
        dTover,
        dTborder,
        dn_gap);

    ftopdown_sum:=0;
    for i in 1:(nstop-1) loop
      if exp(-i*c_td)<0.05*ftopdown_sum then
        break;
      end if;

      q_topmix[nstop-i]:=exp(-i*c_td);
      ftopdown_sum:=ftopdown_sum + exp(-i*c_td);
    end for;

    q_topmix[1:nstop-1]:=q_topmix[1:nstop-1]/sum(q_topmix[1:nstop-1])*qt0;

    ftopup_sum:=0;
    for i in 1:(n-nstop+1) loop
      if exp(-i*c_tu)<0.05*ftopup_sum then
        break;
      end if;
      q_topmix[nstop+i-1]:=exp(-i*c_tu);
      ftopup_sum:=ftopup_sum + exp(-i*c_tu);
    end for;

    q_topmix[nstop:n]:=q_topmix[nstop:n]/sum(q_topmix[nstop:n])*(-qt0);

  end if;

end qTopmix;
