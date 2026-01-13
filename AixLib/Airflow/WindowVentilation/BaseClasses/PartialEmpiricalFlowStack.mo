within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialEmpiricalFlowStack
  "Partial model for empirical expressions with stack effect considered"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlow;
  Modelica.Blocks.Interfaces.RealInput TRoom(
    final unit="K", min=273, max=313)
    "Room temperature, ranging from 0 to 40 °C"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput TAmb(
    final unit="K", min=243, max=323)
    "Ambient temperature, ranging from -30 to 50 °C"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
protected
  Modelica.Units.SI.TemperatureDifference dTRoomAmb = TRoom - TAmb
    "Temperature difference between room and ambient";
  Modelica.Units.SI.Temperature TAvg = (TRoom + TAmb)/2
    "Average temperature of room and ambient";
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model provides a base class of models that estimate ventilation volume flow. The model has indoor and ambient temperature input ports to account for the thermal stack effect.</p>
</html>"));
end PartialEmpiricalFlowStack;
