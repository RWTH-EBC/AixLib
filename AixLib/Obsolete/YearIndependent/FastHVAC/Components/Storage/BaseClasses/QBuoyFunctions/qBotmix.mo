within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qBotmix
  input Integer n;
  input Integer nbuoy;
  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dT13;

  output Modelica.Units.SI.SpecificEnergy q_botmix[n];

protected
  Real fbotdown_sum;
  Real fbotup_sum;
  Real c_bd;
  Real c_bu;

  Modelica.Units.SI.SpecificEnergy qb0;

algorithm
  q_botmix:=zeros(n);

  if dT13>0 then
    c_bd:=cBotDown(dTover, dT13);
    c_bu:=cBotUp(dTover, dT13);
    qb0:=qbot(dTover,dT13);

    fbotdown_sum:=0;
    for i in 1:(nbuoy-1) loop
      if exp(-i*c_bd)<0.05*fbotdown_sum then
        break;
      end if;
      q_botmix[nbuoy-i]:=exp(-i*c_bd);
      fbotdown_sum:=fbotdown_sum + exp(-i*c_bd);

    end for;

    q_botmix[1:nbuoy-1]:=q_botmix[1:nbuoy-1]/sum(q_botmix[1:nbuoy-1])*qb0;

    fbotup_sum:=0;

    for i in 1:n-nbuoy+1 loop
      if exp(-i*c_bu)<0.05*fbotup_sum then
        break;
      end if;
      q_botmix[nbuoy-1+i]:=exp(-i*c_bu);
      fbotup_sum:=fbotup_sum + exp(-i*c_bu);
    end for;

    q_botmix[nbuoy:n]:=q_botmix[nbuoy:n]/sum(q_botmix[nbuoy:n])*(-qb0);

  end if;

end qBotmix;
