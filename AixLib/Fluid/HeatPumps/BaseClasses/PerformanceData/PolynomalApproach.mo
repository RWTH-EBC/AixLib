within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model PolynomalApproach
  "Calculating heat pump data based on a polynomal approach"
  extends BaseClasses.PartialPerformanceData;

  replaceable function PolyData =
      AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.baseFct "Function to calculate peformance Data" annotation(choicesAllMatching=true);
  Real Char[2];
equation
  if sigBusHP.onOff then
    //Get's the data from the signal Bus and calculates the power and heat flow based on the function one chooses.
    Char = data_poly(sigBusHP.N,sigBusHP.T_ret_co,sigBusHP.T_flow_ev,sigBusHP.m_flow_co,sigBusHP.m_flow_ev);
    QCon = Char[2];
    Pel = Char[1];
    QEva = QCon-Pel;
  else //If heat pump is turned off, all values become zero.
    QCon = 0;
    Pel = 0;
    QEva = 0;
  end if;
end PolynomalApproach;
