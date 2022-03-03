within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.BaseClasses;
partial model partialPressureDrop

        input Modelica.SIunits.MassFlowRate m_flow;
        input Modelica.SIunits.Density rho;
        parameter Real a = 0.5;

        output Modelica.SIunits.Pressure dp;

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
