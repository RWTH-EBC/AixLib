within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.MovingBoundaryCells.SingleStates;
model CondenserSC
  "Validation model to check a moving boundary cell of an evaporator"
  extends BaseExampleCondenser(
    redeclare package Medium =
        Modelica.Media.R134a.R134a_ph,
    gua(useFixModCV=false, modCVPar=Utilities.Types.ModeCV.SC),
    sin(use_p_in=true),
    movBouCel(tauVoiFra=125,
      useVoiFraMod=true,
      dhIni=-10),
    trapTemp(amplitude=-25, offset=263.15),
    ramEnt(offset=175e3, height=10e3));
  extends Modelica.Icons.Example;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 10, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"), experiment(StopTime=6400));
end CondenserSC;
