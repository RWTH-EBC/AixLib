within AixLib.Fluid.Examples.Performance;
model Example7
  "Example 7 model of Modelica code that is more efficiently compiled into C-code"
  extends Modelica.Icons.Example;
  parameter Integer nTem = 500;
  parameter Real R = 0.001;
  parameter Real C = 1000;
  parameter Real tauInv = 1/(R*C);

  Real[nTem] T;

protected
  constant Real k(final unit="1/s") = 1
    "Unit conversion to satisfy unit check";

initial equation
  T = fill(273.15, nTem);
equation
  der(T[1])= ((273.15+sin(k*time))-2*T[1] + T[2])*tauInv;
  for i in 2:nTem-1 loop
    der(T[i])=(T[i+1]+T[i-1]-2*T[i])*tauInv;
  end for;
  der(T[nTem])= (T[nTem-1]-T[nTem])*tauInv;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -40},{40,60}}),    graphics={Text(
          extent={{-62,24},{-18,-4}},
          textColor={0,0,255},
          textString="See code")}),
    experiment(
      Tolerance=1e-6, StopTime=100),
    Documentation(revisions="<html>
<ul>
<li>
March 6, 2023, by Michael Wetter:<br/>
Added a constant in order for unit check to pass.<br/>
See  <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1711\">#1711</a>
for a discussion.
</li>
<li>
April 11, 2016 by Michael Wetter:<br/>
Corrected wrong hyperlink in documentation for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/450\">issue 450</a>.
</li>
<li>
July 14, 2015, by Michael Wetter:<br/>
Revised documentation.
</li>
<li>
April 17, 2015, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
See
<a href=\"modelica://AixLib.Fluid.Examples.Performance.Example6\">
AixLib.Fluid.Examples.Performance.Example6</a> for the documentation.
</p>
</html>"),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Examples/Performance/Example7.mos"
        "Simulate and plot"), 
   __Dymola_LockedEditing="Model from IBPSA");
end Example7;
