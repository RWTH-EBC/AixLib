within AixLib.Obsolete.YearIndependent.FastHVAC.Data.Boiler.General;
record Boiler_Virtual_1kW "Boiler virtual 1kW"
  extends BoilerTwoPointBaseDataDefinition(
    name="VirtualBoiler_1kW",
    volume=0.00076,
    PressureDrop=10218000000.0,
    Q_nom=1000,
    Q_min=100,
    eta=[0.3,0.93; 1.0,0.93]);
                                  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>July 6, 2006&#160;</i> by Ana Constantin:<br/>
    implemented.
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Virtual boiler with 1 kW power output.
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars3.png\" alt=\"\">
</p>
</html>"));
end Boiler_Virtual_1kW;
