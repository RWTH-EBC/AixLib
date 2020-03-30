within AixLib.Utilities.Sources.InternalGains.Examples.InternalGains;
model HumansSenTDep "Simulation to check the human models"
  extends AixLib.Utilities.Sources.InternalGains.Examples.InternalGains.BaseClasses.Humans(redeclare Humans.HumanSensibleHeatTemperatureDependent partialHuman);
equation

  annotation (experiment(StopTime = 86400),Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Simulation to check the functionality of the human heat sources. It only consists of one human (VDI 2078). </p>
 <p>The timetable represents typical working hours with one hour lunch time. The room temperature follows a sine input varying between 18 and 22 degrees over a 24 hour time period.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>May 31, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented, added documentation and formatted appropriately</li>
 </ul>
 </html>"));
end HumansSenTDep;
