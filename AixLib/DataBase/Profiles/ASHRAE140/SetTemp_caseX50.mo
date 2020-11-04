within AixLib.DataBase.Profiles.ASHRAE140;
record SetTemp_caseX50 "Max. and Min. set room temperatures for cooling"
  extends AixLib.DataBase.Profiles.ProfileBaseDataDefinition( Profile=[
       0, 273.15+ 200;
   25200, 273.15+ 200;
   25200, 273.15+ 27;
   64800, 273.15+ 27;
   64800, 273.15+ 200;
   86400, 273.15+ 200]);
  annotation (Documentation(info="<html><p>
  Cooling load for Test Case 650
</p>
<h4>
  Table for Natural Ventilation:
</h4>
<p>
  Column 1: Time
</p>
<p>
  Column 2: Set temperature for Cooler
</p>
<ul>
  <li>
    <i>March 26, 2015&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end SetTemp_caseX50;
