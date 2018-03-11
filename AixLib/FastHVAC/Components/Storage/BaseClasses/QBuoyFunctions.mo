within AixLib.FastHVAC.Components.Storage.BaseClasses;
package QBuoyFunctions

  function dToverEff
    input Modelica.SIunits.TemperatureDifference dTover;
    input Real h_rel;
    output Modelica.SIunits.TemperatureDifference dTover_eff;

  protected
    parameter Real a=0.5023;
    parameter Real b=0.259;

  algorithm
    dTover_eff:=a*dTover*exp(-b*h_rel);

  end dToverEff;

  function qbuoy0
    input Modelica.SIunits.TemperatureDifference dTover;
    input Real dh_gap;
    output Modelica.SIunits.SpecificEnergy qbuoy0;

  protected
    parameter Real a(unit="J/(kg.K)")=3844;
    parameter Real b=1.233;

  algorithm
    qbuoy0:=a*dTover*(1-exp(-b*dh_gap));

  end qbuoy0;

  function xDown
    input Modelica.SIunits.TemperatureDifference dTover;
    input Real dh_gap;
    output Real xdown;

    parameter Real a=0.1336;
    parameter Real b=0.2859;
    parameter Real c(unit="1/K")=0.1442;
    parameter Real d=0.3666;

  algorithm

  xdown:=a + b*(1 - exp(-c*dTover))*exp(-d*dh_gap);

  end xDown;

  function dhDown
    input Modelica.SIunits.TemperatureDifference dTover;
    input Real dh_gap;
    output Real dhdown;

    parameter Real a=1.989;
    parameter Real b=5.03;
    parameter Real c(unit="1/K")=0.087;
    parameter Real d=0.1257;

  algorithm

    dhdown:=a + b*(1 - exp(-c*dTover))*(1 - exp(-d*dh_gap));

  end dhDown;

  function cQup

    input Real dh_gap;
    output Real c_qup;

    parameter Real p1=0.02973;
    parameter Real p2=1.329;

  algorithm
    c_qup:=p1*dh_gap + p2;

  end cQup;

  function qFreebuoy
    input Integer n;
    input Integer nbuoy;
    input Integer nstop;
    input Modelica.SIunits.TemperatureDifference dTover;

    output Modelica.SIunits.SpecificEnergy q_freebuoy[n];

  protected
    Modelica.SIunits.SpecificEnergy qb0;
    Real dh_gap;
    Real dhdwn;
    Real c_qu;
    Real xdwn;

  algorithm
    q_freebuoy:=zeros(n);
    dh_gap:=nstop - nbuoy - 1;
    qb0:=qbuoy0(dTover,dh_gap);
    dhdwn:=dhDown(dTover,dh_gap);
    c_qu:=cQup(dh_gap);
    //xdwn:=xdown(dTover, dh_gap);

    for i in 1:(nbuoy-1) loop
      q_freebuoy[i]:=max(0, 1 + (i - nbuoy)/dhdwn);
    end for;

  //   q_freebuoy[1:nbuoy-1]:=q_freebuoy[1:nbuoy - 1]/sum(q_freebuoy[1:nbuoy - 1])*qb0*xdwn;

    for i in (nbuoy+1):nstop-1 loop
      q_freebuoy[i]:= 1 + (i - nbuoy)*(max(c_qu-1,0.01))/dh_gap;
    end for;

  //   q_freebuoy[nbuoy+1:nstop-1]:=q_freebuoy[nbuoy + 1:nstop-1]/sum(q_freebuoy[nbuoy + 1:
  //     nstop-1])*qb0*(1-xdwn);

    q_freebuoy:=q_freebuoy/sum(q_freebuoy)*qb0;

    q_freebuoy[nbuoy]:=-qb0;

  end qFreebuoy;

  function qtop

    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dTborder;
    input Integer dn_gap;

    output Modelica.SIunits.SpecificEnergy qtop;

  protected
    parameter Real a(unit="J/(kg.K)")=3896;
    parameter Real b(unit="1/K")=0.0354;
    parameter Real c=524.7;
    parameter Real d=0.5153;

  algorithm
    qtop:=a*(1 - exp(-b*dTover))*dTborder*(1 - exp(-c*exp(-d*dn_gap)));

  end qtop;

  function cTopDown
    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dTborder;
    input Integer dn_gap;

    output Real c_top_down;

  protected
    parameter Real a=1.445;
    parameter Real b(unit="1/K")= 0.03445;
    parameter Real c(unit="1/K")=0.1455;
    parameter Real d=0.8435;
    parameter Real e=0.02059;

  algorithm
    c_top_down:=a*exp(-b*dTover)*(1 - exp(-c*dTborder))*(d + e*dn_gap);

  end cTopDown;

  function cTopUp
    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dTborder;
    input Integer dn_gap;

    output Real c_top_up;

  protected
    parameter Real a=11.9;
    parameter Real b(unit="1/K")= 0.08698;
    parameter Real c(unit="1/K")=0.1239;
    parameter Real d=2.145;
    parameter Real e=0.0621;

  algorithm
    c_top_up:=a*exp(-b*dTover)*(1 - exp(-c*dTborder))*(d - e*dn_gap);

  end cTopUp;

  function qTopmix
    input Integer n;
    input Integer nbuoy;
    input Integer nstop;
    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dTborder;

    output Modelica.SIunits.SpecificEnergy q_topmix[n];

  protected
    Integer dn_gap;
    Real ftopdown_sum;
    Real ftopup_sum;
    Real c_td;
    Real c_tu;

    Modelica.SIunits.SpecificEnergy qt0;

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

  function qbot
    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dT13;

    output Modelica.SIunits.SpecificEnergy qbot;

  protected
    parameter Real a=594.1;
  algorithm
    qbot:=a*sqrt(dTover)*dT13;

  end qbot;

  function cBotDown
    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dT13;

    output Real c_bot_down;

  protected
    parameter Real a=7.181;
    parameter Real b(unit="1/K")= 0.1012;
    parameter Real c(unit="1/K")=0.6199;
  algorithm
    c_bot_down:=a*exp(-b*dTover)*(1 - exp(-c*dT13));

  end cBotDown;

  function cBotUp
    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dT13;

    output Real c_bot_up;
  protected
    parameter Real a= 0.5241;
    parameter Real b(unit="1/K")= 0.08312;
    parameter Real c(unit="1/K")=0.04731;

  algorithm
    c_bot_up:=a*exp(-b*dTover)*exp(c*dT13);

  end cBotUp;

  function qBotmix
    input Integer n;
    input Integer nbuoy;
    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dT13;

    output Modelica.SIunits.SpecificEnergy q_botmix[n];

  protected
    Real fbotdown_sum;
    Real fbotup_sum;
    Real c_bd;
    Real c_bu;

    Modelica.SIunits.SpecificEnergy qb0;

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

  function qbuoySingle
    input Integer n;
    input Integer nbuoy;
    input Integer nstop;
    input Modelica.SIunits.TemperatureDifference dTover;
    input Modelica.SIunits.TemperatureDifference dT13;
    input Modelica.SIunits.TemperatureDifference dTborder;

    output Modelica.SIunits.SpecificEnergy q_buoy_single[n];

  algorithm
    q_buoy_single:=qFreebuoy(
        n,
        nbuoy,
        nstop,
        dTover) + qTopmix(
        n,
        nbuoy,
        nstop,
        dTover,
        dTborder) + qBotmix(
        n,
        nbuoy,
        dTover,
        dT13);

  end qbuoySingle;

  function qbuoyTotal
    input Integer n;
    input Modelica.SIunits.Temperature T[n];
    output Modelica.SIunits.SpecificEnergy q_total[n];

  protected
    Modelica.SIunits.TemperatureDifference dTover;
    Modelica.SIunits.TemperatureDifference dT13;
    Modelica.SIunits.TemperatureDifference dTborder;
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

  function isBuoy
      input Integer n;
    input Modelica.SIunits.Temperature T[n];

    output Boolean isBuoy;

  algorithm

    isBuoy:=false;

    for i in 1:n-1 loop

      if T[i]>T[i+1] then
        isBuoy:=true;

      end if;

    end for;

  end isBuoy;
end QBuoyFunctions;
