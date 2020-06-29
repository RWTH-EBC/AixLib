within AixLib.DataBase.Profiles.ASHRAE140;
record Ventilation_caseX50 "infiltration with/without the ventilation fan "
  extends AixLib.DataBase.Profiles.ProfileBaseDataDefinition( Profile=[
       0, 11.21;
   25200, 11.21;
   25200, 0.41;
   64800, 0.41;
   64800, 11.21;
   86400, 11.21]);
  annotation (Documentation(info="<html><p>
  air exchange for case 650
</p>
<h4>
  Table for Natural Ventilation:
</h4>
<p>
  Column 1: Time
</p>
<p>
  Column 2: air exchange rate
</p>
<ul>
  <li>
    <i>March 26, 2015&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Ventilation_caseX50;
