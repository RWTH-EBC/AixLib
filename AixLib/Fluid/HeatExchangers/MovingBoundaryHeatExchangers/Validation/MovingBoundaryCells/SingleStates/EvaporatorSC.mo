within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.MovingBoundaryCells.SingleStates;
model EvaporatorSC
  "Validation model to check a moving boundary cell of an evaporator"
  extends BaseExample(
    redeclare package Medium =
        Modelica.Media.R134a.R134a_ph,
    gua(useFixModCV=true, modCVPar=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.ModeCV.TP),
    ramEnt(offset=275e3),
    sin(use_p_in=false));

  extends Modelica.Icons.Example;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 10, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"));
end EvaporatorSC;
