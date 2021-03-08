within AixLib.ThermalZones.HighOrder.House;
package MFD "Multiple Family Dwelling"
  extends Modelica.Icons.Package;


  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Package with rooms aggregated to an appartment and appartments
  aggregated to a complete building.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Multiple rooms are connected together and they form an apartment.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/MFD_FloorPlan_En.PNG\"
  alt=\"MFD_FloorPlan_En\">
</p>
<p>
  It is possible to model several storeys with apartments on top of
  each other, as well as several wings with apartments next to each
  other. Storeys are connected together to form a whole house.
</p>
<p>
  The example here has three wings and three storeys.
</p>
</html>"));
end MFD;
