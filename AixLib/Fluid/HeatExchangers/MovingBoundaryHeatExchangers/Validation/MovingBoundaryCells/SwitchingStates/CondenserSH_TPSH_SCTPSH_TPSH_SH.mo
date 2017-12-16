within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.MovingBoundaryCells.SwitchingStates;
model CondenserSH_TPSH_SCTPSH_TPSH_SH
  "Validation model to check a moving boundary cell of a condenser"
  extends BaseExampleCondenser(
    redeclare package Medium =
        Modelica.Media.R134a.R134a_ph,
    gua(modCVPar=Utilities.Types.ModeCV.SH,
        useFixModCV=false),
    sin(use_p_in=true),
    movBouCel(tauVoiFra=125,
      useVoiFraMod=true,
      appHX=Utilities.Types.ApplicationHX.Condenser),
    trapTemp(              offset=293.15, amplitude=-60),
    ramEnt(offset=425e3, height=25e3));
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
end CondenserSH_TPSH_SCTPSH_TPSH_SH;
