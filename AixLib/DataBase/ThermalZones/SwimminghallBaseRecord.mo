within AixLib.DataBase.ThermalZones;
record SwimminghallBaseRecord
  "Base record definition for zone records"
  extends Modelica.Icons.Record;

  // Add for Pools
  parameter Boolean use_swimmingPools=false;
  parameter Integer numPools=1;
  replaceable parameter  AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam[:]
   annotation (choicesAllMatching=false);
  annotation(Documentation(info="<html><p>
  This is the base definition of zone records used in <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>.
  It aggregates all parameters at one record to enhance usability,
  exchanging entire datasets and automatic generation of these
  datasets.
</p>
<h4>
  References
</h4>
<p>
  For automatic generation of thermal zone and multizone models as well
  as for datasets, see <a href=
  \"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a>
</p>
<ul>
  <li>November 27, 2019, by David Jansen:<br/>
    Integrate threshold for heater and cooler.
  </li>
  <li>July 10, 2019, by David Jansen:<br/>
    Adds specificPeople (persons per squaremetre). Adds activityDegree.
  </li>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation.
  </li>
  <li>January 4, 2016, by Moritz Lauster:<br/>
    Clean up.
  </li>
  <li>June, 2015, by Moritz Lauster:<br/>
    Added new parameters to use further calculation cores.
  </li>
  <li>February 4, 2014, by Ole Odendahl:<br/>
    Added new parameters for the setup of the ACH. It is now possible
    to assign different values to the ACH for each zone based on this
    record.
  </li>
  <li>January 27, 2014, by Ole Odendahl:<br/>
    Added new parameter withAHU to choose whether the zone is connected
    to a central air handling unit. Default is false.
  </li>
  <li>November, 2012, by Moritz Lauster:<br/>
    Restored links
  </li>
  <li>March, 2012, by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>"));
end SwimminghallBaseRecord;
