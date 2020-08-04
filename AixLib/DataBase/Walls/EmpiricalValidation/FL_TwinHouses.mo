within AixLib.DataBase.Walls.EmpiricalValidation;
record FL_TwinHouses
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
     n(min=1) = 5 "Number of wall layers",
    d={0.22,0.029,0.03,0.033,0.065} "Thickness of wall layers, first=outside; last=inside",
    rho={2400,80,80,80,2000} "Density of wall layers",
    lambda={2.1,0.06,0.025,0.023,1.4} "Thermal conductivity of wall layers",
    c={1000,840,840,840,1000} "Specific heat capacity of wall layers",
    eps=0.9 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">References</font></h4>
<p>For ASHRAE 140 see Bibtexkey: ASHRAE-140-2007</p>
</html>"));
end FL_TwinHouses;
