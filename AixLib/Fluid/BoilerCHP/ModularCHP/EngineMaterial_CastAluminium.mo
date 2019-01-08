within AixLib.Fluid.BoilerCHP.ModularCHP;
record EngineMaterial_CastAluminium
  "Cast aluminium as engine housing material"

  extends EngineMaterialData(lambda=140, rhoEngWall=2500, c=910);
  //Source: https://www.makeitfrom.com/material-properties/EN-AC-43300-AISi9Mg-Cast-Aluminum

end EngineMaterial_CastAluminium;
