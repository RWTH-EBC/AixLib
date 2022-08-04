within AixLib.ThermalZones.HighOrder.House;
package OFD_MiddleInnerLoadWall "The one family dwelling model, with the inner load wall divides the house in two"
  extends Modelica.Icons.Package;


  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Package with set-up models for a one family dwelling.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The room models are connected together. The name
  OFD_MiddleInnerLoadWall denotes the fact that the standard house has
  a middle load bearing wall. Other positions of the load bearing inner
  wall are possible, but not included in the library. Walls are
  connected together and they form a room. Multiple rooms are connected
  together and they form a storey for the one family dwelling.
</p>
<p>
  The living area over both storeys is 150 m2.
</p>
<p>
  The following figure shows the floor layout for the ground and upper
  floor. For simplification the toilet and the storage room are
  aggregated to one room. The side view shows the saddle roof.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/OFD_FloorPlan_En.PNG\"
  alt=\"OFD_FloorPlan_En\">
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/OFD_SideView_En.PNG\"
  alt=\"OFD_SideView_En\">
</p>
</html>"));
end OFD_MiddleInnerLoadWall;
