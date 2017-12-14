within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.MovingBoundaryCells.SingleStates;
model EvaporatorTPSH
  "Validation model to check a moving boundary cell of an evaporator"
  extends BaseExampleEvaporator(
    redeclare package Medium =
        Modelica.Media.R134a.R134a_ph,
    gua(modCVPar=Utilities.Types.ModeCV.TP,
        useFixModCV=false),
    sin(use_p_in=true),
    movBouCel(tauVoiFra=125,
      useVoiFraMod=true,
      dhIni=150e3),
    trapTemp(amplitude=5, offset=273.15),
    ramEnt(offset=275e3));

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
end EvaporatorTPSH;
