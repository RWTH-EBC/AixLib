within AixLib.DataBase.Materials.WallLayers;
record LimeStone
  extends MaterialBaseDataDefinition(
  rho = 1000,
  lambda = 0.5,
  c = 1000,
  epsLw = 0.9,
  epsSw = 0.9);
  annotation (Documentation(info="<html>
<h4>Source:</h4>
<p>Schneider &QUOT;Bautabelle f&uuml;r Ingenieure&QUOT; 2010</p>
<p>Mauerwerk aus Kalksansteinen, Page 10.45</p>
</html>"));
end LimeStone;
