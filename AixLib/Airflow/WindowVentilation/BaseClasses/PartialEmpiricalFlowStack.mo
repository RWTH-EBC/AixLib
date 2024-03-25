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
end PartialEmpiricalFlowStack;
