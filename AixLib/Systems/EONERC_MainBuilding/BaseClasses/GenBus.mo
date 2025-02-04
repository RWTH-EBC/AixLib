within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector GenBus "Generation bus"
  extends Modelica.Icons.SignalBus;
  import Modelica.Units.SI;

  SI.Temperature T_sup_Set;
  SI.Power P_Heat_gen;
  SI.Power P_Cold_gen;
  SI.Power P_AHU;
  SI.Power P_Tabs;
  SI.Power P_Heat;
  SI.Power P_Cold;
  SI.Power P_Fans;
  SI.Power P_Pumps;
  SI.Energy Q_heat_gen;
  SI.Energy Q_cold_gen;
  SI.Energy W_Fans;
  SI.Energy W_Pumps;
  SI.Energy Q_AHU_hot;
  SI.Energy Q_AHU_cold;
  SI.Energy Q_Tabs_hot;
  SI.Energy Q_Tabs_cold;
  SI.Energy Q_Heat;
  SI.Energy Q_Cold;
  Real cost_heat_gen;
  Real cost_cold_gen;
  Real cost_fans;
  Real cost_pumps;

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
end GenBus;
