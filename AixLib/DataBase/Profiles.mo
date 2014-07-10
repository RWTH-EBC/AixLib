within AixLib.DataBase;
package Profiles "Profiles for ventilation, set temperatures, internal gains"
    extends Modelica.Icons.Package;
record Profile_BaseDataDefinition "Ventilation profiles"
    extends Modelica.Icons.Record;
    parameter Real[:,:] Profile "First column time";

  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Profiles are to be understood as useage profiles. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>For example:</p>
<ul>
<li>Ventilation schedules</li>
<li>Schedules for set room temperature</li>
</ul>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Base data definition for record to be used in model <a href=\"Modelica.Blocks.Sources.CombiTimeTable\">Modelica.Blocks.Sources.CombiTimeTable</a></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>July 3, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
</ul></p>
</html>"));
end Profile_BaseDataDefinition;

record Ventilation_2perDay_Mean05perH
    "Ventilation two times a day, with a mean value of 0.5 1/h per day. For five rooms. "
  extends Profile_BaseDataDefinition(Profile=[0,0,0,0,0,0; 3600,0,0,0,0,0; 7200,
          0,0,0,0,0; 10800,0,0,0,0,0; 14400,0,0,0,0,0; 18000,0,0,0,0,0; 21600,0,
          0,0,0,0; 25200,0,0,0,0,0; 26940,0,0,0,0,0; 27000,0,0,0,0,0; 28740,0,0,
          0,0,0; 28800,0,0,12,0,0; 30540,0,0,12,0,0; 30600,12,0,0,0,0; 32340,12,
          0,0,0,0; 32400,0,12,0,0,0; 34140,0,12,0,0,0; 34200,0,0,0,12,0; 35940,
          0,0,0,12,0; 36000,0,0,0,0,12; 37740,0,0,0,0,12; 37800,0,0,0,0,0;
          39540,0,0,0,0,0; 39600,0,0,0,0,0; 64740,0,0,0,0,0; 64800,0,0,12,0,0;
          66540,0,0,12,0,0; 66600,12,0,0,0,0; 68340,12,0,0,0,0; 68400,0,12,0,0,
          0; 70140,0,12,0,0,0; 70200,0,0,0,12,0; 71940,0,0,0,12,0; 72000,0,0,0,
          0,12; 73740,0,0,0,0,12; 73800,0,0,0,0,0; 75540,0,0,0,0,0; 82800,0,0,0,
          0,0; 86400,0,0,0,0,0]);
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Mean value per day: 0.5 1/h.</p>
<p>Two ventilation intervales, each 30 Min with an air exchange rate of 12 1/h.</p>
<p>Model can be used for OFD and MFD. On each floor there is a delay in ventilation between rooms of 30 Min. </p>
<p>One day is represented. Make sure you set the startTime - parameter when using in a table as the beginning of the day, regardless of the fact that the simulation starts at that moment.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<h4>Table for Natural Ventilation:</h4>
<p>Column 1: Time</p>
<p>Column 2: Ventilation rate for OFD-Livingroom / OFD-Bedroom / MFD-Bedroom</p>
<p>Column 3: Ventilation rate for OFD-Hobby / OFD Children1 / MFD-Children</p>
<p>Column 4: Ventilation rate for OFD-Kitchen / OFH-Children2 / MFD-Kitchen </p>
<p>Column 5: Ventilation rate for OFH-Bathroom / OFH-WC / MFD- Bathroom</p>
<p>Column 6: Ventilation rate for MFD-Livingroom</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Modelica.Blocks.Sources.CombiTimeTable\">Modelica.Blocks.Sources.CombiTimeTable</a></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>July 3, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
</ul></p>
</html>"));
end Ventilation_2perDay_Mean05perH;

record SetTemperatures_Ventilation2perDay
    "Set temperature for ventilation two times a day"
  extends Profile_BaseDataDefinition(Profile=[0,295.15,295.15,295.15,297.15,
          291.15,291.15,295.15; 3600,295.15,295.15,295.15,297.15,291.15,291.15,
          295.15; 7200,295.15,295.15,295.15,297.15,291.15,291.15,295.15; 10800,
          295.15,295.15,295.15,297.15,291.15,291.15,295.15; 14400,295.15,295.15,
          295.15,297.15,291.15,291.15,295.15; 18000,295.15,295.15,295.15,297.15,
          291.15,291.15,295.15; 21600,295.15,295.15,295.15,297.15,291.15,291.15,
          295.15; 25200,295.15,295.15,295.15,297.15,291.15,291.15,295.15; 26940,
          295.15,295.15,295.15,297.15,291.15,291.15,295.15; 27000,295.15,295.15,
          295.15,297.15,291.15,291.15,295.15; 28740,295.15,295.15,295.15,297.15,
          291.15,291.15,295.15; 28800,295.15,295.15,293.15,297.15,291.15,291.15,
          295.15; 29100,295.15,295.15,280.15,297.15,291.15,291.15,295.15; 30540,
          295.15,295.15,280.15,297.15,291.15,291.15,295.15; 30600,293.15,295.15,
          287.15,297.15,291.15,291.15,295.15; 30900,280.15,295.15,295.15,297.15,
          291.15,291.15,295.15; 32340,280.15,295.15,295.15,297.15,291.15,291.15,
          295.15; 32400,287.15,293.15,295.15,297.15,291.15,291.15,295.15; 32700,
          295.15,280.15,295.15,297.15,291.15,291.15,295.15; 34140,295.15,280.15,
          295.15,297.15,291.15,291.15,295.15; 34200,295.15,287.15,295.15,295.15,
          289.15,291.15,295.15; 34500,295.15,295.15,295.15,280.15,280.15,291.15,
          295.15; 35940,295.15,295.15,295.15,280.15,280.15,291.15,295.15; 36000,
          295.15,295.15,295.15,290.15,286.15,291.15,293.15; 36300,295.15,295.15,
          295.15,297.15,291.15,291.15,280.15; 37740,295.15,295.15,295.15,297.15,
          291.15,291.15,280.15; 37800,295.15,295.15,295.15,297.15,291.15,291.15,
          287.15; 39540,295.15,295.15,295.15,297.15,291.15,291.15,295.15; 39600,
          295.15,295.15,295.15,297.15,291.15,291.15,295.15; 64740,295.15,295.15,
          295.15,297.15,291.15,291.15,295.15; 64800,295.15,295.15,293.15,297.15,
          291.15,291.15,295.15; 65100,295.15,295.15,280.15,297.15,291.15,291.15,
          295.15; 66540,295.15,295.15,280.15,297.15,291.15,291.15,295.15; 66600,
          293.15,295.15,287.15,297.15,291.15,291.15,295.15; 66900,280.15,295.15,
          295.15,297.15,291.15,291.15,295.15; 68340,280.15,295.15,295.15,297.15,
          291.15,291.15,295.15; 68400,287.15,293.15,295.15,297.15,291.15,291.15,
          295.15; 68700,295.15,280.15,295.15,297.15,291.15,291.15,295.15; 70140,
          295.15,280.15,295.15,297.15,291.15,291.15,295.15; 70200,295.15,287.15,
          295.15,295.15,289.15,291.15,295.15; 70500,295.15,295.15,295.15,280.15,
          280.15,291.15,295.15; 71940,295.15,295.15,295.15,280.15,280.15,291.15,
          295.15; 72000,295.15,295.15,295.15,290.15,286.15,291.15,293.15; 72300,
          295.15,295.15,295.15,297.15,291.15,291.15,280.15; 73740,295.15,295.15,
          295.15,297.15,291.15,291.15,280.15; 73800,295.15,295.15,295.15,297.15,
          291.15,291.15,287.15; 75540,295.15,295.15,295.15,297.15,291.15,291.15,
          295.15; 82800,295.15,295.15,295.15,297.15,291.15,291.15,295.15; 86400,
          295.15,295.15,295.15,297.15,291.15,291.15,295.15]);
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Mean value per day: 0.5 1/h.</p>
<p>Two ventilation intervales, each 30 Min with an air exchange rate of 12 1/h.</p>
<p>Model can be used for OFD and MFD. On each floor there is a delay in ventilation between rooms of 30 Min. </p>
<p>One day is represented. Make sure you set the startTime - parameter when using in a table as the beginning of the day, regardless of the fact that the simulation starts at that moment.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<h4>Table for Natural Ventilation:</h4>
<p>Column 1: Time</p>
<p>Column 2: Ventilation rate for OFD-Livingroom / OFD-Bedroom / MFD-Bedroom</p>
<p>Column 3: Ventilation rate for OFD-Hobby / OFD Children1 / MFD-Children</p>
<p>Column 4: Ventilation rate for OFD-Kitchen / OFH-Children2 / MFD-Kitchen </p>
<p>Column 5: Ventilation rate for OFH-Bathroom / OFH-WC / MFD- Bathroom</p>
<p>Column 6: Ventilation rate for MFD-Livingroom</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Modelica.Blocks.Sources.CombiTimeTable\">Modelica.Blocks.Sources.CombiTimeTable</a></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>July 3, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
</ul></p>
</html>"));
end SetTemperatures_Ventilation2perDay;
annotation (Documentation(info="<html>
<p>Profiles are to be understood as use profiles.</p>
<p>For example:</p>
<p><ul>
<li>Ventilation schedules</li>
<li>Schedules for set room temperature</li>
</ul></p>
</html>"));
end Profiles;
