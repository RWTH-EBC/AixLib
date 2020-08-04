within AixLib.DataBase.Walls.EmpiricalValidation;
record OW_E_TwinHouses
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 5 "Number of wall layers",
    d={0.01,0.08,0.03,0.3,0.01} "Thickness of wall layers, first=outside; last=inside",
    rho={1200,80,1200,800,1200} "Density of wall layers",
    lambda={0.8,0.022,1,0.22,1} "Thermal conductivity of wall layers",
    c={1000,840,1000,1000,1000} "Specific heat capacity of wall layers",
    eps=0.9 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">References</font></h4>
<p>For ASHRAE 140 see Bibtexkey: ASHRAE-140-2007</p>
</html>"));
end OW_E_TwinHouses;
