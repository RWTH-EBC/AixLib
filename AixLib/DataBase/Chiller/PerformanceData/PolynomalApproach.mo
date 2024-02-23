within AixLib.DataBase.Chiller.PerformanceData;
model PolynomalApproach
  "Calculating chiller data based on a polynomal approach"
  extends
    AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData;

  replaceable function PolyData =
      AixLib.DataBase.HeatPump.Functions.Characteristics.PartialBaseFct    "Function to calculate peformance Data" annotation(choicesAllMatching=true);
protected
  Real Char[2];
equation
  Char =PolyData(
    sigBus.nSet,
    sigBus.TEvaOutMea,
    sigBus.TConInMea,
    sigBus.m_flowEvaMea,
    sigBus.m_flowConMea);
  if sigBus.nSet > Modelica.Constants.eps then
    //Get's the data from the signal Bus and calculates the power and heat flow based on the function one chooses.
    QEva = Char[2];
    Pel = Char[1];
  else //If heat pump is turned off, all values become zero.
    QCon = 0;
    Pel = 0;
  end if;
  QCon = -(QCon - Pel);
  annotation (Icon(graphics={
        Text(
          lineColor={0,0,255},
          extent={{-136,109},{164,149}},
          textString="%name"),
        Ellipse(
          lineColor = {108,88,49},
          fillColor = {255,215,136},
          fillPattern = FillPattern.Solid,
          extent={{-86,-96},{88,64}}),
        Text(
          lineColor={108,88,49},
          extent={{-90,-108},{90,72}},
          textString="f")}), Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This model is used to calculate the three values based on a
  functional approach. The user can choose between several functions or
  use their own.
</p>
<p>
  As the <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.PartialBaseFct\">
  base function</a> only returns the electrical power and the condenser
  heat flow, the evaporator heat flow is calculated with the following
  energy balance:
</p>
<p>
  <i>QEva = QCon - P_el</i>
</p>
</html>"));
end PolynomalApproach;
