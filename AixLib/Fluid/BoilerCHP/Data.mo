within AixLib.Fluid.BoilerCHP;
package Data
  "Package with model parameters for combined heat and power systems"
  extends Modelica.Icons.MaterialPropertiesPackage;
  package ModularCHP "Data for the modular CHP model"

    record EngineMaterialData
      extends Modelica.Icons.Record;

      constant Modelica.Units.SI.ThermalConductivity lambda=44.5
        "Thermal conductivity of the engine block material (default value is 44.5)";
      constant Modelica.Units.SI.Density rhoEngWall=7200
        "Density of the the engine block material (default value is 72000)";
      constant Modelica.Units.SI.SpecificHeatCapacity c=535
        "Specific heat capacity of the cylinder wall material (default value is 535)";

      annotation (Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
    end EngineMaterialData;

    record EngineMaterial_CastIron "Cast iron as engine housing material"
      extends Data.ModularCHP.EngineMaterialData(
                                 lambda=44.5, rhoEngWall=7200, c=535);
      annotation (Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
    end EngineMaterial_CastIron;

    record EngineMaterial_SpheroidalGraphiteIron
      "Spheroidal graphite iron as engine housing material"
      extends Data.ModularCHP.EngineMaterialData(
                                 lambda=36.2, rhoEngWall=7100, c=515);
      annotation (Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
    end EngineMaterial_SpheroidalGraphiteIron;

    record EngineMaterial_CastAluminium
      "Cast aluminium as engine housing material"

      extends Data.ModularCHP.EngineMaterialData(
                                 lambda=140, rhoEngWall=2500, c=910);
      //Source: https://www.makeitfrom.com/material-properties/EN-AC-43300-AISi9Mg-Cast-Aluminum

      annotation (Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
    end EngineMaterial_CastAluminium;
    annotation (Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
  end ModularCHP;
end Data;
