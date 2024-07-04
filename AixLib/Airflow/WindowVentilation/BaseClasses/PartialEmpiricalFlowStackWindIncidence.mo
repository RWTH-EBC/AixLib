within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialEmpiricalFlowStackWindIncidence
  "Partial model for empirical expressions with stack effect and wind incidence angle considered"
  extends PartialEmpiricalFlowStack;
  parameter Modelica.Units.SI.Angle aziRef(displayUnit="deg")=0
    "Azimuth angle of the referece surface impacted by wind";
  Modelica.Units.SI.Angle incAng(displayUnit="deg")
    "Incidence angle of wind on reference surface";
  Modelica.Blocks.Interfaces.RealInput winDir(
    final unit="rad", displayUnit="deg", min=0, max=2*Modelica.Constants.pi)
    "Local wind direction"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
protected
  Modelica.Units.NonSI.Angle_deg incAngDeg "Incidence angle in degree";
equation
  incAngDeg = Modelica.Units.Conversions.to_deg(incAng);
  annotation (Documentation(revisions="<html><ul>
  <li>June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This partial model provides a base class of models that estimate
  ventilation volume flow. The model has a wind direction input port to
  account for the wind incidence.
</p>
</html>"));
end PartialEmpiricalFlowStackWindIncidence;
