within AixLib.Systems.Benchmark.BaseClasses;
expandable connector EvaluationBus
  "Data bus for KPIs (energy consumption, control quality) of benchmark building"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  SI.Energy WelHPMea "Consumed energy of heat pump";
  SI.Energy WelPumpsHPMea "Consumed energy of heat pump pumps";
  SI.Energy WelGCMea "Consumed energy of glycol cooler";
  SI.Energy WelPumpsHXMea "Consumed energy of heat exchanger system pumps";
  SI.Energy WelPumpSWUMea "Consumed energy of switching unit pump";
  SI.Energy WelPumpGTFMea "Consumed energy of geothermal field pump";
  SI.Energy WelPumpsHTSMea "Consumed energy of pumps in high temperature system";
  SI.Energy QbrBoiMea "Consumed energy of boiler";
  SI.Energy QbrCHPMea "Consumed energy of chp";
  SI.Energy WelCPHMea "Produced electricity of chp";
  SI.Energy WelTotalMea "Total consumed electricity";
  SI.Energy QbrTotalMea "Total consumed fuel";
  Real IseRoom1 "ISE of room 1";
  Real IseRoom2 "ISE of room 2";
  Real IseRoom3 "ISE of room 3";
  Real IseRoom4 "ISE of room 4";
  Real IseRoom5 "ISE of room 5";

  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
end EvaluationBus;
