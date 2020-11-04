within AixLib.BoundaryConditions.InternalGains.Examples.InternalGains;
model HumansSenTDep "Simulation to check the human models"
  extends AixLib.BoundaryConditions.InternalGains.Examples.InternalGains.BaseClasses.Humans(redeclare Humans.HumanSensibleHeatTemperatureDependent humanIntGains);
equation

  annotation (experiment(StartTime = 0, StopTime = 86400, Tolerance=1e-6, Algorithm="dassl"),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/BoundaryConditions/InternalGains/Examples/HumansSenTDep.mos"
                      "Simulate and plot"),
    Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to check the functionality of the human heat sources. It
  only consists of one human (VDI 2078).
</p>
<p>
  The timetable represents typical working hours with one hour lunch
  time. The room temperature follows a sine input varying between 18
  and 22 degrees over a 24 hour time period.
</p>
<ul>
  <li>
    <i>May 31, 2013&#160;</i> by Ole Odendahl:<br/>
    Implemented, added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end HumansSenTDep;
