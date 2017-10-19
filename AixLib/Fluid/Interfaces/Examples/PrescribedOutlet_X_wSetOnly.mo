within AixLib.Fluid.Interfaces.Examples;
model PrescribedOutlet_X_wSetOnly
  "Test model for prescribed outlet state"
  extends Modelica.Icons.Example;
  extends AixLib.Fluid.Interfaces.Examples.BaseClasses.PrescribedOutletState(
    heaHigPow(use_TSet=false),
    cooLimPow(use_TSet=false),
    heaCooUnl(use_TSet=false),
    steSta(use_TSet=false));

equation
  connect(setHeaHigPow.y[2], heaHigPow.X_wSet) annotation (Line(points={{-39,120},
          {-20,120},{-20,90},{-12,90}}, color={0,0,127}));
  connect(setCooLimPow.y[2], cooLimPow.X_wSet) annotation (Line(points={{-39,40},
          {-26,40},{-26,4},{-12,4}}, color={0,0,127}));
  connect(setHeaCooUnl.y[2], heaCooUnl.X_wSet) annotation (Line(points={{-39,-30},
          {-26,-30},{-26,-56},{-12,-56}}, color={0,0,127}));
  connect(setHeaCooUnl.y[2], steSta.X_wSet) annotation (Line(points={{-39,-30},{-26,
          -30},{-26,-86},{-12,-86}}, color={0,0,127}));



  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -120},{120,160}})),
    experiment(Tolerance=1e-6, StopTime=1200),
__Dymola_Commands(file= "modelica://AixLib/Resources/Scripts/Dymola/Fluid/Interfaces/Examples/PrescribedOutlet_X_wSetOnly.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Model that demonstrates
<a href=\"modelica://AixLib.Fluid.Interfaces.PrescribedOutlet\">
AixLib.Fluid.Interfaces.PrescribedOutlet</a>
with mass fraction setpoint.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2017, by Michael Wetter:<br/>
Refactored model to allow <code>X_wSet</code> as an input.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/763\">#763</a>.
</li>
<li>
November 11, 2014, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end PrescribedOutlet_X_wSetOnly;
