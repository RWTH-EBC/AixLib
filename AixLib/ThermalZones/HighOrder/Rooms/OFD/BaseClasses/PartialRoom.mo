within AixLib.ThermalZones.HighOrder.Rooms.OFD.BaseClasses;
model PartialRoom "Partial model with base component that are necessary for all HOM rooms"

  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition
    WallType constrainedby AixLib.DataBase.Walls.WallBaseDataDefinition
    "Type of wall"
    annotation(Dialog(group = "Structure of wall layers"), choicesAllMatching = true, Placement(transformation(extent={{2,76},{22,96}})));


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>January 9, 2020
    by Philipp Mehrfeld:<br/>
       Model added to the AixLib library.
</ul>
</html>"));
end PartialRoom;
