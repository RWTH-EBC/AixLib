within AixLib.DataBase.Materials.WallLayers;
record GypsumPlaster
  extends MaterialBaseDataDefinition(
  rho = 1200,
  lambda = 0.51,
  c = 1000,
  epsLw = 0.9,
  epsSw = 0.9);
  annotation (Documentation(info="<html>
<h4>Source:</h4>
<p>Schneider &QUOT;Bautabelle f&uuml;r Ingenieure&QUOT; 2010</p>
<p>Gipsputz ohne Zuschlag, Page 10.42</p>
</html>"));
end GypsumPlaster;
