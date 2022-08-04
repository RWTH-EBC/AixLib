within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses;
function QBuoyFunction

  input Integer n;
  input Modelica.Units.SI.Length height;
  input Modelica.Units.SI.Area A;
  input Modelica.Units.SI.Temperature[n] T;
  input
    AixLib.Obsolete.YearIndependent.FastHVAC.Media.BaseClasses.MediumSimple
    medium=AixLib.Obsolete.YearIndependent.FastHVAC.Media.WaterSimple();
  input Modelica.Units.SI.Time tau;
  input Modelica.Units.SI.TemperatureDifference dTref;
  output Modelica.Units.SI.HeatFlowRate[n] Q_buoy_abs
    "Cumulative heat flow rate into the layer due to buoyancy";
  replaceable function fDist =
      AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.buoyancyDitribution.buoyancyDistInv2
    constrainedby
    AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.buoyancyDitribution.buoyancyDist;

protected
  Modelica.Units.SI.HeatFlowRate Q_buoy
    "Heat flow rate from layer i to all above layers with lower temperature";
  Modelica.Units.SI.HeatFlowRate[n] Q_buoy_step
    "Heat flow rate into each layer resulting from the buoyant mass flow in a particular iteration step";
  Modelica.Units.SI.TemperatureDifference dT[n - 1]
    "Temperature difference between adjoining volumes";

  Modelica.Units.SI.MassFlowRate m_buoy
    "Total buoyant mass flow (in a particular iteration step)";
  Modelica.Units.SI.MassFlowRate[n] m_buoy_in
    "Buoyant mass flow going into each layer (in a particular iteration step)";
  Integer k;
  Integer j;
  Modelica.Units.SI.MassFlowRate s1 "temporary variable for calculations";
  Modelica.Units.SI.MassFlowRate s2 "temporary variable for calculations";

algorithm
  for i in 1:n-1 loop
  dT[i] :=T[i] - T[i + 1];
  j:=i+1;

  if (dT[i]>0) then
    m_buoy:=dT[i]*A*height*medium.rho/(tau*dTref);
    Q_buoy:=m_buoy*medium.c*(dT[i]);

    for k in (i+1):n loop

      if (T[i]<T[k]) then
        break;
      end if;
      j:=k;
    end for;

    m_buoy_in:=fDist(
        i,
        j,
        n,
        T)*m_buoy;
    Q_buoy_step:=zeros(n);
    Q_buoy_step[i]:=-Q_buoy;
    for k in i+1:j-1 loop
      s1:=0;
      s2:=0;
      //calculating the two sums of mass flows representing downwards flow
      for q in k:j loop
        s1:=s1 + m_buoy_in[q];
      end for;

      for q in k+1:j loop
        s2:=s2 + m_buoy_in[q];
      end for;

      Q_buoy_step[k]:=-s1*medium.c*T[k] + m_buoy_in[k]*medium.c*T[i] + s2*medium.c*T[k + 1];
      //Q_buoy_step[k]:=-sum(m_buoy_in[k:j])*medium.c*therm[k].T + m_buoy_in[k]*
       // medium.c*therm[i].T + sum(m_buoy_in[k + 1:j])*medium.c*therm[k + 1].T;
      end for;
      Q_buoy_step[j]:=-m_buoy_in[j]*medium.c*T[j] + m_buoy_in[j]*medium.c*T[i];
      Q_buoy_abs:=Q_buoy_abs + Q_buoy_step;
    end if;
  end for;

end QBuoyFunction;
