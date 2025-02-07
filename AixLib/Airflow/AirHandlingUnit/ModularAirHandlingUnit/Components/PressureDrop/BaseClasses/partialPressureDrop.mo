within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.BaseClasses;
partial model partialPressureDrop

        input Modelica.Units.SI.MassFlowRate m_flow;
        input Modelica.Units.SI.Density rho;
        parameter Modelica.Units.SI.PressureDifference dp_nominal;
        parameter Modelica.Units.SI.MassFlowRate m_flow_nominal;

        output Modelica.Units.SI.Pressure dp;

 annotation (                                  Documentation(info="<html><p>
  This is a partial model for calculation of the pressure Drop in
  components.
</p>
</html>", revisions="<html>
<ul>
  <li>September, 2019, by Ervin Lejlic:<br/>
    First Implementation.
  </li>
</ul>
</html>"));



end partialPressureDrop;
