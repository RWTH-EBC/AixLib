within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialEmpiricalFlowStackWindIncidence
  "Partial model for empirical expressions with stack effect and wind incidence angle considered"
  extends PartialEmpiricalFlowStack;
  parameter Modelica.Units.SI.Angle aziRef(displayUnit="deg")=0
    "Azimuth angle of the referece surface impacted by wind";
  Modelica.Units.SI.Angle beta(displayUnit="deg")
    "Incidence angle of wind on reference surface";
  Modelica.Blocks.Interfaces.RealInput phi(
    unit="rad", displayUnit="deg", min=0, max=2*Modelica.Constants.pi)
    "Local wind direction"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
protected
  Modelica.Units.NonSI.Angle_deg beta_deg "Incidence angle in degree";
equation
  beta_deg = Modelica.Units.Conversions.to_deg(beta);
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This partial model provides a base class of models that estimate ventilation volume flow. The model has a wind direction input port to account for the wind incidence.</p>
</html>"));
end PartialEmpiricalFlowStackWindIncidence;
