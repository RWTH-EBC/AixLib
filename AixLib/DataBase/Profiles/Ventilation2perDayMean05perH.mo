within AixLib.DataBase.Profiles;
record Ventilation2perDayMean05perH
  "Ventilation two times a day, with a mean value of 0.5 1/h per day. For five rooms. "
  extends ProfileBaseDataDefinition( Profile = [0, 0, 0, 0, 0, 0, 0; 3600, 0, 0, 0, 0, 0, 0; 7200, 0, 0, 0, 0, 0, 0; 10800, 0, 0, 0, 0, 0, 0; 14400, 0, 0, 0, 0, 0, 0; 18000, 0, 0, 0, 0, 0, 0; 21600, 0, 0, 0, 0, 0, 0; 25200, 0, 0, 0, 0, 0, 0; 26940, 0, 0, 0, 0, 0, 0; 27000, 0, 0, 0, 0, 0, 0; 28740, 0, 0, 0, 0, 0, 0; 28800, 0, 0, 12, 0, 0, 0; 30540, 0, 0, 12, 0, 0, 0; 30600, 12, 0, 0, 0, 0, 0; 32340, 12, 0, 0, 0, 0, 0; 32400, 0, 12, 0, 0, 0, 0; 34140, 0, 12, 0, 0, 0, 0; 34200, 0, 0, 0, 12, 0, 0; 35940, 0, 0, 0, 12, 0, 0; 36000, 0, 0, 0, 0, 12, 0; 37740, 0, 0, 0, 0, 12, 0; 37800, 0, 0, 0, 0, 0, 0; 39540, 0, 0, 0, 0, 0, 0; 39600, 0, 0, 0, 0, 0, 0; 64740, 0, 0, 0, 0, 0, 0; 64800, 0, 0, 12, 0, 0, 0; 66540, 0, 0, 12, 0, 0, 0; 66600, 12, 0, 0, 0, 0, 0; 68340, 12, 0, 0, 0, 0, 0; 68400, 0, 12, 0, 0, 0, 0; 70140, 0, 12, 0, 0, 0, 0; 70200, 0, 0, 0, 12, 0, 0; 71940, 0, 0, 0, 12, 0, 0; 72000, 0, 0, 0, 0, 12, 0; 73740, 0, 0, 0, 0, 12, 0; 73800, 0, 0, 0, 0, 0, 0; 75540, 0, 0, 0, 0, 0, 0; 82800, 0, 0, 0, 0, 0, 0; 86400, 0, 0, 0, 0, 0, 0]);
  annotation(Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Mean value per day: 0.5 1/h.
</p>
<p>
  Two ventilation intervales, each 30 Min with an air exchange rate of
  12 1/h.
</p>
<p>
  Model can be used for OFD and MFD. On each floor there is a delay in
  ventilation between rooms of 30 Min.
</p>
<p>
  One day is represented. Make sure you set the startTime - parameter
  when using in a table as the beginning of the day, regardless of the
  fact that the simulation starts at that moment.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  <b>Table for Natural Ventilation:</b>
</p>
<p>
  Column 1: Time
</p>
<p>
  Column 2: Ventilation rate for OFD-Livingroom / OFD-Bedroom /
  MFD-Bedroom
</p>
<p>
  Column 3: Ventilation rate for OFD-Hobby / OFD Children1 /
  MFD-Children
</p>
<p>
  Column 4: Ventilation rate for OFD-Kitchen / OFD-Children2 /
  MFD-Kitchen
</p>
<p>
  Column 5: Ventilation rate for OFD-Bathroom / OFD-WC / MFD- Bathroom
</p>
<p>
  Column 6: Ventilation rate for MFD-Livingroom
</p>
<p>
  Column 7: Ventilation rate for OFD-Corridor_GF / OFD-Corridor_UF
</p>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<p>
  Record is used in model <a href=
  \"Modelica.Blocks.Sources.CombiTimeTable\">Modelica.Blocks.Sources.CombiTimeTable</a>
</p>
<ul>
  <li>
    <i>August 30, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>July 3, 2012&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Ventilation2perDayMean05perH;
