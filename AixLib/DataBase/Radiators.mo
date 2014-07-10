within AixLib.DataBase;
package Radiators
  "Base record definition of radiators and some ready-to-use parameter sets"
  extends Modelica.Icons.Package;
  record RadiatiorBaseDataDefinition "Base Data Definition for Radiators"
        extends Modelica.Icons.Record;
    parameter Real NominalPower
      "Nominal power of radiator at nominal temperatures in W ";
    parameter Modelica.SIunits.Temperature T_flow_nom( displayUnit = "degC")
      "Nominal temperatures T_flow according to DIN-EN 442. in degC";
    parameter Modelica.SIunits.Temperature T_return_nom( displayUnit = "degC")
      "Nominal temperatures T_return according to DIN-EN 442.in deg C";
    parameter Modelica.SIunits.Temperature T_room_nom( displayUnit = "degC")
      "Nominal temperatures T_room according to DIN-EN 442. in deg C";

    parameter Real Exponent=1.29 annotation (Dialog(group="Geometry"));
    parameter Real VolumeWater(unit="l") "Water volume inside radiator in l";
    parameter Real MassSteel(unit="kg") "Material mass of radiator in kg";
    parameter Real RadPercent "Percent of radiative heat";

    parameter Modelica.SIunits.Length length "Length of radiator in m";
    parameter Modelica.SIunits.Height height "Height of radiator in m";

    annotation (Documentation(revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Record for a radiator.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
</html>"));
  end RadiatiorBaseDataDefinition;

  record ThermX2_ProfilV_979W
    "ThermX2, Profil V (Kermi) Power=979W, L=1000, H=600, Typ=11, {75,65,20}"
    extends RadiatiorBaseDataDefinition(
     NominalPower= 979,
     T_flow_nom= 75,
     T_return_nom = 65,
     T_room_nom = 20,
     Exponent=1.2721,
     VolumeWater=3.15,
     MassSteel=19.58,
     RadPercent = 0.35,
     length=1.0,
     height=0.6);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",   revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>"));
  end ThermX2_ProfilV_979W;

  package StandardOFD_EnEV2009
    "For a standard one family dweling after EnEV 2009"
    extends Modelica.Icons.Package;
    record Livingroom
      "Standard OFD EnEV2009 Livingroom = ThermX2, Profil V (Kermi) Power=1288W, L=2600, H=300, Typ=22, {55,45,20}"
      extends RadiatiorBaseDataDefinition(
       NominalPower= 1288,
       T_flow_nom= 55,
       T_return_nom = 45,
       T_room_nom = 20,
       Exponent=1.2776,
       VolumeWater=9.36,
       MassSteel=44.23,
       RadPercent = 0.3,
       length=2.6,
       height=0.3);
      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>"));
    end Livingroom;

    record Hobby
      "Standard OFD EnEV2009 Hobby = ThermX2, Profil V (Kermi) Power=644W, L=1300, H=300, Typ=22, {55,45,20}"
      extends RadiatiorBaseDataDefinition(
       NominalPower= 644,
       T_flow_nom= 55,
       T_return_nom = 45,
       T_room_nom = 20,
       Exponent=1.2776,
       VolumeWater=4.68,
       MassSteel=22.11,
       RadPercent = 0.3,
       length=1.3,
       height=0.3);
      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>"));
    end Hobby;

    record Corridor
      "Standard OFD EnEV2009 Corridor = ThermX2, Profil V (Kermi) Power=318W, L=1000, H=300, Typ=11, {55,45,18}"
      extends RadiatiorBaseDataDefinition(
       NominalPower= 318,
       T_flow_nom= 55,
       T_return_nom = 45,
       T_room_nom = 18,
       Exponent=1.2196,
       VolumeWater=1.8,
       MassSteel=9.87,
       RadPercent = 0.35,
       length=1.0,
       height=0.3);
      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>"));
    end Corridor;

    record WC
      "Standard OFD EnEV2009 WC = ThermX2, Profil V (Kermi) Power=593W, L=1100, H=300, Typ=22, {55,45,18}"
      extends RadiatiorBaseDataDefinition(
       NominalPower= 593,
       T_flow_nom= 55,
       T_return_nom = 45,
       T_room_nom = 18,
       Exponent=1.2776,
       VolumeWater=3.96,
       MassSteel=18.71,
       RadPercent = 0.3,
       length=1.1,
       height=0.3);
      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>"));
    end WC;

    record Kitchen
      "Standard OFD EnEV2009 Kitchen = ThermX2, Profil V (Kermi) Power=970W, L=2600, H=300, Typ=12, {55,45,20}"
      extends RadiatiorBaseDataDefinition(
       NominalPower= 970,
       T_flow_nom= 55,
       T_return_nom = 45,
       T_room_nom = 20,
       Exponent=1.2731,
       VolumeWater=9.36,
       MassSteel=38.12,
       RadPercent = 0.3,
       length=2.6,
       height=3.0);
      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>"));
    end Kitchen;
  end StandardOFD_EnEV2009;

  package StandardMFD_WSchV1984_OneAppartment
    extends Modelica.Icons.Package;

    record Livingroom
      "ThermX2, Profil V (Kermi) Power=1267W, L=0.5, H=300, Typ=11, {75,65,20}"
       extends RadiatiorBaseDataDefinition(
       NominalPower=1276,
       T_flow_nom= 75,
       T_return_nom = 65,
       T_room_nom = 20,
       Exponent=1.2196,
       VolumeWater=1.80,
       MassSteel=9.87,
       RadPercent = 0.3,
       length=2.3,
       height=0.3);
      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p><ul>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>November 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>"));
    end Livingroom;

    record Children
      "ThermX2, Profil V (Kermi) Power=882W, L=1600, H=300, Typ=11, {75,65,20}"
      extends RadiatiorBaseDataDefinition(
       NominalPower=882,
       T_flow_nom= 75,
       T_return_nom = 65,
       T_room_nom = 20,
       Exponent=1.2196,
       VolumeWater=1.80,
       MassSteel=9.87,
       RadPercent = 0.3,
       length=2.3,
       height=0.3);

      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p><ul>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>November 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>"));
    end Children;

    record Bedroom
      "ThermX2, Profil V (Kermi) Power=882W, L=1600, H=300, Typ=11, {75,65,20}"
       extends RadiatiorBaseDataDefinition(
       NominalPower=882,
       T_flow_nom= 75,
       T_return_nom = 65,
       T_room_nom = 20,
       Exponent=1.2196,
       VolumeWater=1.80,
       MassSteel=9.87,
       RadPercent = 0.3,
       length=1.6,
       height=0.3);

      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p><ul>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>November 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>"));
    end Bedroom;

    record Bathroom
      "ThermX2, Profil V (Kermi) Power=603W, L=700, H=300, Typ=22, {75,65,24}"
       extends RadiatiorBaseDataDefinition(
       NominalPower=603,
       T_flow_nom= 75,
       T_return_nom = 65,
       T_room_nom = 24,
       Exponent=1.2776,
       VolumeWater=3.6,
       MassSteel=17.01,
       RadPercent = 0.3,
       length=0.7,
       height=0.3);

      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p><ul>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>November 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>"));
    end Bathroom;

    record Kitchen
      "ThermX2, Profil V (Kermi) Power=576W, L=800, H=300, Typ=12, {75,65,20}"
       extends RadiatiorBaseDataDefinition(
       NominalPower=576,
       T_flow_nom= 75,
       T_return_nom = 65,
       T_room_nom = 20,
       Exponent=1.2731,
       VolumeWater=3.6,
       MassSteel=14.66,
       RadPercent = 0.3,
       length=0.8,
       height=0.3);

      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
<p>Source:</p>
<ul>
<li>Manufacturer: Kermi</li>
<li>Product: Flachheizkoerper ThermX2 Profil V</li>
<li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
</ul>
</html>",     revisions="<html>
<p><ul>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>November 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>"));
    end Kitchen;
    annotation (Documentation(info="<html>
<p>Just one appartment, on the first floor, the middle antracne, which means adiabatic conditions on all walls towards neighbouring rooms, with the exception of the staircase. </p>
</html>"));
  end StandardMFD_WSchV1984_OneAppartment;
end Radiators;
