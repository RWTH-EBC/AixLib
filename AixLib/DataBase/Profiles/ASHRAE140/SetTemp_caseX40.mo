within AixLib.DataBase.Profiles.ASHRAE140;
record SetTemp_caseX40 "Max. and Min. set room temperatures for heating"
  extends AixLib.DataBase.Profiles.ProfileBaseDataDefinition( Profile=[
       0, 273.15+ 10;
   25200, 273.15+ 10;
   25200, 273.15+ 20;
   82800, 273.15+ 20;
   82800, 273.15+ 10;
   86400, 273.15+ 10]);
    annotation (Documentation(info="<html><p>
  Heating load for Test Case 640
</p>
<h4>
  Table for Natural Ventilation:
</h4>
<p>
  Column 1: Time
</p>
<p>
  Column 2: Set temperature for Heater
</p>
<ul>
  <li>
    <i>March 26, 2015&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end SetTemp_caseX40;
