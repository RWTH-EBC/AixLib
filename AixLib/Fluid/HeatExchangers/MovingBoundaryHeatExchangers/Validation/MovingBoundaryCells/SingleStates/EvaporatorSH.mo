within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.MovingBoundaryCells.SingleStates;
model EvaporatorSH
  "Validation model to check a moving boundary cell of an evaporator"
  extends BaseExample(
    redeclare package Medium =
        Modelica.Media.R134a.R134a_ph,
    gua(modCVPar=Utilities.Types.ModeCV.SH,
        useFixModCV=false),
    sin(use_p_in=true),
    movBouCel(tauVoiFra=125,
      useVoiFraMod=true),
    trapTemp(amplitude=25,
      offset=303.15),
    ramEnt(offset=425e3));

  extends Modelica.Icons.Example;
  // WorkingVersion.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 10, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"));
end EvaporatorSH;
