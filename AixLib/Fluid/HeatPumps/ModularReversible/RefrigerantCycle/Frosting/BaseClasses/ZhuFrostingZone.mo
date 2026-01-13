within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses;
model ZhuFrostingZone
  "Model to indicate which frosting zone according to Zhu et al. is currently active"
  Modelica.Blocks.Interfaces.RealInput relHum
    "Input relative humidity of outdoor air" annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}),iconTransformation(
          extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.IntegerOutput zon
    "Frosting zon (0=no, 1=mild, 2=moderate, 3=severe)"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealInput TOda "Outdoor air temperature" annotation (
     Placement(transformation(extent={{-140,20},{-100,60}}), iconTransformation(
          extent={{-140,20},{-100,60}})));

  Real relHumSev=poly_fit(coeff_severe, TOda - 273.15)
    "Relative humidity above which is severe frosting";
  Real relHumMod=poly_fit(coeff_moderate, TOda - 273.15)
    "Relative humidity above which is moderate frosting";
  Real relHumMil=poly_fit(coeff_mild, TOda - 273.15)
    "Relative humidity above which is mild frosting";

protected
  parameter Real coeff_severe[4] = {8.24762543e-01, -1.90727602e-02, 1.19709272e-03, 2.15230362e-05};
  parameter Real coeff_moderate[4] = {5.81825389e-01, -8.80317871e-03, 6.18167285e-04, -7.75483854e-07};
  parameter Real coeff_mild[4] = {4.42929753e-01, -7.03658239e-03, 7.32505699e-05, -3.37264259e-06};

  function poly_fit
    input Real coeff[4];
    input Real x;
    output Real y;
  algorithm
    y := 0;
    for n in 1:size(coeff, 1) loop
      y := y + coeff[n] * x^(n - 1);
    end for;
  end poly_fit;

equation
  if TOda >= 279.15 then
    zon = 0;
  else
    if relHum >= relHumSev then
      zon = 3;
    elseif relHum >= relHumMod then
      zon = 2;
    elseif relHum >= relHumMil then
      zon = 1;
    else
      zon = 0;
    end if;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-150,138},{150,98}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model outputs the current frosting zone from Zhu et al. The three zones depend outdoor air temperature and humidity. 
<h4>References</h4>
<p>
J.H. Zhu, Y.Y. Sun, W. Wang, S.M. Deng, Y.J. Ge, and L.T. Li. Developing a new frosting map to guide defrosting control for air-source heat pump units. Applied Thermal Engineering, November 2015
  <a href=\"https://doi.org/10.1016/j.applthermaleng.2015.06.076\">doi:10.1016/j.applthermaleng.2015.06.076</a>.
</p>
</html>"));
end ZhuFrostingZone;
