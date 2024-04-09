within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialEmpiricalFlowStack
  "Partial model for empirical expressions with stack effect considered"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlow;
  Modelica.Blocks.Interfaces.RealInput T_i(unit="K") "Room temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput T_a(unit="K") "Ambient temperature"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
protected
  Modelica.Units.SI.TemperatureDifference deltaT = T_i - T_a;
  Modelica.Units.SI.Temperature avgT = (T_i + T_a)/2;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This partial model provides a base class of models that estimate ventilation volume flow. The model has indoor and ambient temperature input ports to account for the thermal stack effect.</p>
</html>"));
end PartialEmpiricalFlowStack;
