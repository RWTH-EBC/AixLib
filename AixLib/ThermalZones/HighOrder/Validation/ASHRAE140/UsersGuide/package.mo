within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  annotation (preferredView="info",
  Documentation(info=" <html><p>
  The package
  <code>AixLib.ThermalZones.HighOrder.Validation.ASHRAE140</code>
  consists of models for several comparative test cases according to
  the standard ASHRAE140.
</p>
<p>
  All implemented comparative test cases refer to changes to the input
  specifications for Building Thermal Envelope and Fabric Load
  Tests.<br/>
  The standard ASHRAE140 provides detailed descriptions of all test
  cases.
</p>
<h4>
  Base Case600 according to ASHRAE140
</h4>
<p>
  Case600 represents the base-building model, which is the basis for
  all following cases.<br/>
  The base-building is a single-story, low-mass building with
  rectangular geometry, 48 m2 floor area and 12 m2 of south-facing
  windows.
</p>
<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\"
style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Case number
    </th>
    <th>
      Low Mass / High Mass<br/>
    </th>
    <th>
      Window Orientation
    </th>
    <th>
      Air Exchange Rate<br/>
      [ach]
    </th>
    <th>
      Thermostat Control
    </th>
    <th>
      Internal Gains<br/>
      [W]
    </th>
    <th>
      Solar Absorptance
    </th>
    <th>
      Infrared Emittance
    </th>
  </tr>
  <tr>
    <td>
      600
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &gt; 7°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
  </tr>
</table>
<h4>
  Comparative test cases according to ASHRAE140
</h4>
<p>
  The following table describes the input specifications for all
  Building Thermal Envelope and Fabric Load Test Cases.
</p>
<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\"
style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Case number
    </th>
    <th>
      Low Mass / High Mass<br/>
    </th>
    <th>
      Window Orientation
    </th>
    <th>
      Air Exchange Rate<br/>
      [ach]
    </th>
    <th>
      Thermostat Control
    </th>
    <th>
      Internal Gains<br/>
      [W]
    </th>
    <th>
      Solar Absorptance
    </th>
    <th>
      Infrared Emittance
    </th>
  </tr>
  <tr>
    <td>
      600
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &gt; 7°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      620
    </td>
    <td>
      Low Mass
    </td>
    <td>
      East/West
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &gt; 7°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      640
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      23-7 h: Heat = ON IF Temp &lt; 10°C<br/>
      7-23 h: Heat = ON IF Temp &lt; 20°C;<br/>
      Cool = ON IF Temp &gt; 27°C
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      650
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      10.8
    </td>
    <td>
      18-7 h: Vent fan = ON<br/>
      7-18 h: Vent fan = OFF<br/>
      Heating = always OFF<br/>
      18-7 h:Cool = OFF<br/>
      7-18 h: Cool =ON IF Temp&gt;27°C
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      900
    </td>
    <td>
      High Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &gt; 7°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      920
    </td>
    <td>
      High Mass
    </td>
    <td>
      East/West
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &gt; 7°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      940
    </td>
    <td>
      High Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      23-7 h: Heat = ON IF Temp &lt; 10°C<br/>
      7-23 h: Heat = ON IF Temp &lt; 20°C;<br/>
      Cool = ON IF Temp &gt; 27°C
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      950
    </td>
    <td>
      High Mass
    </td>
    <td>
      South
    </td>
    <td>
      10.8
    </td>
    <td>
      18-7 h: Vent fan = ON<br/>
      7-18 h: Vent fan = OFF<br/>
      Heating = always OFF<br/>
      18-7 h:Cool = OFF<br/>
      7-18 h: Cool =ON IF Temp &gt; 27°C
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      220
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C<br/>
      Cool ON IF Temp &gt; 20°C
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      210
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C<br/>
      Cool ON IF Temp &gt; 20°C
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.1
    </td>
  </tr>
  <tr>
    <td>
      230
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0.822
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C<br/>
      Cool ON IF Temp &gt; 20°C
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      240
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C<br/>
      Cool ON IF Temp &gt; 20°C
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.1<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      250
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C<br/>
      Cool ON IF Temp &gt; 20°C
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.9<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      270
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C<br/>
      Cool ON IF Temp &gt; 20°C
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: 0.9
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      280
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C<br/>
      Cool ON IF Temp &gt; 20°C
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: 0.1
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      300
    </td>
    <td>
      Low Mass
    </td>
    <td>
      East/West
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C<br/>
      Cool ON IF Temp &gt; 20°C
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: 0.9
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      320
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: 0.9
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      400
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      395
    </td>
    <td>
      Low Mass
    </td>
    <td>
      no window
    </td>
    <td>
      0
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      410
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      0
    </td>
    <td>
      exterior: 0.1<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      420
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.1<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      430
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      440
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.1
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      800
    </td>
    <td>
      High Mass
    </td>
    <td>
      South (opak)
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: -
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      810
    </td>
    <td>
      High Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      Heat = ON IF Temp &lt; 20°C; otherwise Heat=OFF<br/>
      Cool = ON IF Temp &lt; 27°C; otherwise Cool = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.1
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
</table>
<p>
  The following FreeFloating models refer to test cases that do not
  include mechanical heating or cooling of the building.
</p>
<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\"
style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Case number
    </th>
    <th>
      Low Mass / High Mass<br/>
    </th>
    <th>
      Window Orientation
    </th>
    <th>
      Air Exchange Rate<br/>
      [ach]
    </th>
    <th>
      Thermostat Control
    </th>
    <th>
      Internal Gains<br/>
      [W]
    </th>
    <th>
      Solar Absorptance
    </th>
    <th>
      Infrared Emittance
    </th>
  </tr>
  <tr>
    <td>
      600FF
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      No mechanichal heating or cooling
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      650FF
    </td>
    <td>
      Low Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      No mechanical heating/cooling<br/>
      but vent fan :<br/>
      18-7 Uhr Vent fan = ON<br/>
      7-18 Uhr Vent fan = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      900FF
    </td>
    <td>
      High Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      No mechanichal heating or cooling
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
  <tr>
    <td>
      950FF
    </td>
    <td>
      High Mass
    </td>
    <td>
      South
    </td>
    <td>
      0.41
    </td>
    <td>
      No mechanical heating/cooling<br/>
      but vent fan :<br/>
      18-7 Uhr Vent fan = ON<br/>
      7-18 Uhr Vent fan = OFF
    </td>
    <td>
      200
    </td>
    <td>
      exterior: 0.6<br/>
      interior: 0.6
    </td>
    <td>
      exterior: 0.9<br/>
      interior: 0.9
    </td>
  </tr>
</table>
<h4>
  Limitations
</h4>
<p>
  The simulated annual heating and cooling loads of <b>Case 210, 250,
  395, 430</b> cannot meet the statistical acceptance ranges given by
  ASHRAE140 (01.01.2021).<br/>
  However, cases that do not perform according to the reference values
  should not be considered erroneous. They shall be used as indication
  for debugging purposes instead.
</p>
<h4>
  References
</h4>
<ul>
  <li>ASHRAE140-2017
  </li>
</ul>
</html>", revisions="<html><ul>
<ul>
  <li>January 1, 2021, by Konstantina Xanthopoulou:<br/>
    Implemented
  </li>
</ul>
</html>"));

end UsersGuide;
