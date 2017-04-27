within AixLib.DataBase.Materials.WallLayers;
record CementScreed
  extends MaterialBaseDataDefinition(
  rho = 140,
  lambda = 0.04,
  c = 1000,
  epsLw = 0.9,
  epsSw = 0.9);
  annotation (Documentation(info="<html>
<h4>Source:</h4>
<p>Schneider &QUOT;Bautabelle f&uuml;r Ingenieure&QUOT; 2010</p>
<p>Zement-Estrich, Page 10.42</p>
</html>"));
end CementScreed;
