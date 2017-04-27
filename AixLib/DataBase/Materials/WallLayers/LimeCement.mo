within AixLib.DataBase.Materials.WallLayers;
record LimeCement
  extends MaterialBaseDataDefinition(
  rho = 1800,
  lambda = 1.0,
  c = 1000,
  epsLw = 0.9,
  epsSw = 0.9);
  annotation (Documentation(info="<html>
<h4>Source:</h4>
<p>Schneider &QUOT;Bautabelle f&uuml;r Ingenieure&QUOT; 2010</p>
<p>Putzmoertel aus Kalzement, Page 10.42</p>
</html>"));
end LimeCement;
