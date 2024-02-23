within AixLib.ThermalZones.HighOrder.Rooms;
package OFD "One Family Dwelling"
  extends Modelica.Icons.Package;


  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Package for rooms for a one familiy dwelling.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The one family dwelling isn’t based on an existing building, but on a
  virtual two storey building with ten rooms and a saddle roof, which
  is typical for German houses. A core of six room types was developed
  to model the different rooms in the house: room types with two outer
  walls and room types with one outer wall. Some inner walls can face
  just one room, while others can face two rooms. Rooms on the ground
  floor are connected to the ground, while rooms on the upper floor
  have a saddle roof. The layout of the two floors is the same.
</p>
<p>
  <br/>
  The room model is realized by aggregating together all the components
  in a model, parameterizing on a room level and referencing the
  parameter on the component level. In this way the number of
  parameters is reduced, e.g. for a simple rectangular room only three
  parameters are needed for the dimensions of all the walls: height,
  length, width.
</p>
<p>
  The set of room types developed for the one family dwelling can, if
  necessary, be parameterized differently than the standard model or
  extended in order to build up specific house models. New sets of
  wall, window and door types can be developed, e.g. for older, not
  renovated buildings, and incorporated in the existing structure.
</p>
<ul>
  <li>
    <i>April 14, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 7, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"));
end OFD;
