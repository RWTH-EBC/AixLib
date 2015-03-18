within AixLib.HVAC.HeatGeneration.Utilities;
model HeatCurve
  "Given a reference temperature, this heat curve calculates a set-point temperature"
  parameter Modelica.SIunits.Temp_C T_fwd_max = 80
    "Maximum forward temperature of the heating system at lowest reference temperature, both in Celcius";
  parameter Modelica.SIunits.Temp_C T_ref_min = -12
    "Lowest reference temperature in Celcius";
  Modelica.Blocks.Interfaces.RealInput T_ref annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
  Modelica.Blocks.Interfaces.RealOutput T_set annotation(Placement(transformation(extent = {{98, -10}, {118, 10}})));
protected
  Modelica.SIunits.Temp_C TAtZero
    "T_set of the heat curve at 0 degrees Celcius";
equation
  TAtZero = (T_fwd_max - 20) * 20 / (20 - T_ref_min);
  T_set = 20 + TAtZero - (T_ref - 273.15) / 20 * TAtZero + 273.15;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p><br/>This model calculates a set-point temperature for the forward flow of a heating system as a funktion of a reference temperature. In most cases this reference temperature will be the outside air temperature.</p>
 <p>The heating curve is defined so that a given maximum forward temperature of the heating system is reached at a given lowest design reference temperature. At a reference temperature of 20 &deg;C, the heating curve also reaches 20 &deg;C for the set-point temperature.</p>
 </html>", revisions = "<html>
 <p>09.10.2013, Marcus Fuchs</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end HeatCurve;

