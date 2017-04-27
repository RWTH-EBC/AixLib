within AixLib.DataBase.Materials.WallLayers;
record MineralWool040
  extends MaterialBaseDataDefinition(
  rho = 120,
  lambda = 0.04,
  c = 1030,
  epsLw = 0.9,
  epsSw = 0.9);
  annotation (Documentation(info="<html>
<h4>Source:</h4>
<p>Schneider &QUOT;Bautabelle f&uuml;r Ingenieure&QUOT; 2010</p>
<p>Mineralwolle, Page 10.51</p>
</html>"));
end MineralWool040;
