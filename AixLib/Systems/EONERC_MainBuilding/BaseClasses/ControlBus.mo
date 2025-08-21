within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector ControlBus "Generation bus"
  extends Modelica.Icons.SignalBus;
  import Modelica.Units.SI;

  SI.Power Q_Tabs_Set_h;
  SI.Power Q_Tabs_Set_c;
  SI.Temperature T_AHU_sup_Set;
  SI.VolumeFlowRate Vflow_AHU_Set;
  Real internal_AHU_Ph_rpm_Set;
  Real internal_AHU_Rh_rpm_Set;
  Real internal_AHU_Co_rpm_Set;
  Real internal_AHU_Ph_valve_Set;
  Real internal_AHU_Rh_valve_Set;
  Real internal_AHU_Co_valve_Set;
  Real AHU_Ph_rpm_Set;
  Real AHU_Rh_rpm_Set;
  Real AHU_Co_rpm_Set;
  Real AHU_Ph_valve_Set;
  Real AHU_Rh_valve_Set;
  Real AHU_Co_valve_Set;
  SI.Temperature T_Gen_Set;
  SI.Temperature T_room_heat_Set;
  SI.Temperature T_room_cool_Set;
  Real CO2_Set;


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
end ControlBus;
