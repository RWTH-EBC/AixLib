within AixLib.Building.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;

model NoCorG "No correction for solar gain factor"

  extends CorrectionSolarGain.PartialCorG;

equation

    for i in 1:n loop

      solarRadWinTrans[i] = SR_input[i].I;

    end for;



  annotation (Documentation(info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple model with no correction of transmitted solar radiation depending on incidence angle.
</p>
<p>
  <img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars:" out="" of="">
</p></html>",revisions="<html>

</html>"));

end NoCorG;

