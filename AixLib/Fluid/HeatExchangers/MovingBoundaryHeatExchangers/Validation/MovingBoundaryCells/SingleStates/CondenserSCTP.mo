within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.MovingBoundaryCells.SingleStates;
model CondenserSCTP
  "Validation model to check a moving boundary cell of a condenser"
  extends BaseExampleCondenser(
    redeclare package Medium =
        Modelica.Media.R134a.R134a_ph,
    gua(modCVPar=Utilities.Types.ModeCV.SH,
        useFixModCV=false),
    sin(use_p_in=true),
    movBouCel(tauVoiFra=125,
      useVoiFraMod=true,
      useVoiFra=true,
      dhIni=-80e3),
    trapTemp(offset=TOut + 5, amplitude=-25),
    ramEnt(offset=250e3, height=25e3));
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 10, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"), experiment(StopTime=6400));
end CondenserSCTP;
