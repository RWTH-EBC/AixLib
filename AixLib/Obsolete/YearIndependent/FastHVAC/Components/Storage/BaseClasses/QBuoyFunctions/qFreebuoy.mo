within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qFreebuoy

  input Integer n;
  input Integer nbuoy;
  input Integer nstop;
  input Modelica.Units.SI.TemperatureDifference dTover;

  output Modelica.Units.SI.SpecificEnergy q_freebuoy[n];

protected
  Modelica.Units.SI.SpecificEnergy qb0;
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
