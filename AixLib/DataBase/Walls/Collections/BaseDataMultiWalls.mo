within AixLib.DataBase.Walls.Collections;
partial record BaseDataMultiWalls "Base class of record containing multiple wall type records"
  extends Modelica.Icons.Record;

  parameter AixLib.DataBase.Walls.WallBaseDataDefinition roof
    "Type of Roof"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition OW
    "Wall type for outside wall"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW_vert_half_a
    "Wall type for inside wall (first half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW_vert_half_b
    "Wall type for inside wall (second half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW_hori_upp_half
    "Floor type (upper half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW_hori_low_half
    "Ceiling type (lower half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW_hori_att_upp_half
    "Attic floor type (upper half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW_hori_att_low_half
    "Ceiling type towards attic (lower half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition groundPlate_upp_half
    "Type of groundplate (upper half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition groundPlate_low_half
    "Type of groundplate (lower half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);

  annotation (
  preferredView="info",
  Dialog(tab="Wall types"),
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  The figure below depicts the basic structure of a single or
  multi-family house.
</p>
<p>
  Additional walls can be added if further differentiation is
  necessary.
</p>
<h4>
  Assumptions
</h4>
<p>
  The vertical walls are assumed to be the same in the whole building.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Walls/Collections/Records_Floor_Ceiling.svg\"
  alt=\"Overview of wall types\">
</p>
<p>
  Source: Schulte, Lukas. April 2019. „Model implementation and
  simulation of a multi-family house of different levels of detail for
  evaluation in hardware-in-the-loop experiments“. RWTH Aachen
  University, E.ON Energy Research Center, Institute for Energy
  Efficient Buildings and Indoor Climate.
</p>
<ul>
  <li>January 9, 2020 by Philipp Mehrfeld:<br/>
    Model added to the AixLib library.
  </li>
</ul>
</html>"));
end BaseDataMultiWalls;
