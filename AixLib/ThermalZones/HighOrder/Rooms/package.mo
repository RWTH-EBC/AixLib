within AixLib.ThermalZones.HighOrder;
package Rooms
  extends Modelica.Icons.Package;


  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Package for rooms.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  In a room model the following physical processes are considered:
</p>
<ul>
  <li>transient heat conduction through walls; each wall consists of
  several layers with different physical properties; further
  discretization of each layer is possible
  </li>
  <li>steady-state heat conduction through glazing systems;
  transmission of short wave radiation through the window depends on a
  constant coefficient; transmitted radiation is considered together
  with the radiation from room facing elements
  </li>
  <li>heat convection at outside facing surfaces either with a constant
  coefficient, depending on wind speed, or depending on wind speed and
  surface abrasiveness
  </li>
  <li>heat convection at inside facing surfaces either with a constant
  coefficient, depending on wind speed, or depending on wind speed and
  surface abrasiveness
  </li>
  <li>heat convection at inside facing surfaces depends on the wall
  orientation and the temperature difference between the room air and
  the wall surface
  </li>
  <li>radiation exchange between room facing elements
  </li>
  <li>temperature balance equations for the room airvolume; per room
  only one air node is considered; humidity is not considered in the
  air node
  </li>
</ul>
<p>
  <br/>
  All outer walls are whole walls connected to the room air and the
  ambient, while inner walls are half walls, each half belonging to one
  of the rooms which share the wall. Airflow among rooms is not
  explicitly considered.
</p>
<p>
  <br/>
  We chose to parameterize according to the following criteria:
</p>
<ul>
  <li>thermal mass class: heavy, middle and light
  </li>
  <li>energy saving ordinance: WSchV 1984, WSchV1995, EnEV 2002 and
  EnEV 2009
  </li>
</ul>
<p>
  By specifying these two parameters, all wall, window and door types
  in a house are automatically set correctly. Furthermore for a
  multi-family dwelling, for each apartment, the types for floor and
  ceiling are automatically set if the apartment is situated on the
  ground, last or an arbitrary upper floor.
</p>
<p>
  <br/>
  We wanted to make the library easy to use and extend by future users
  and developers. To this purpose we put extra effort in creating easy
  to understand icons and graphical interfaces for parameter input.
  Because users might want to rotate or mirror a room to build up a
  whole floor, we wanted to transfer the information about the position
  of the walls in the room, the meaning of the parameters width and
  length as well as the existence of windows on the icon level.
</p>
</html>"));
end Rooms;
