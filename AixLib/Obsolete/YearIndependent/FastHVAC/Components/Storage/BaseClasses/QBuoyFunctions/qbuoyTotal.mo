within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qbuoyTotal
  input Integer n;
  input Modelica.Units.SI.Temperature T[n];
  output Modelica.Units.SI.SpecificEnergy q_total[n];

protected
  Modelica.Units.SI.TemperatureDifference dTover;
  Modelica.Units.SI.TemperatureDifference dT13;
  Modelica.Units.SI.TemperatureDifference dTborder;
  Integer nbuoy;
  Integer dngap;
  Integer nstop;

algorithm
  q_total:=zeros(n);

  for i in 1:n-1 loop

    if T[i]>T[i+1] then

      nbuoy:=i;
      dTover:=T[nbuoy] - T[nbuoy + 1];
      if i==1 then
        dT13:=0;
      else
        dT13:=T[nbuoy + 1] - T[nbuoy - 1];
      end if;
      nstop:=n+1;
      for j in nbuoy+2:n loop

        if (T[j] - T[nbuoy + 1]) > dToverEff(dTover, j - nbuoy - 1) then

             nstop:=j;
             break;
           end if;

//               if T[j]>T[nbuoy] then
//                 nstop:=j;
//                 break;
//               end if;

      end for;

      dTborder:=if (nstop == n + 1) then 0 else T[nstop] - T[nstop - 1];

      q_total:=q_total + qbuoySingle(
          n,
          nbuoy,
          nstop,
          dTover,
          dT13,
          dTborder);

    end if;

  end for;

end qbuoyTotal;
