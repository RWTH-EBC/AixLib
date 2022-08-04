within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
model CorGSimple "Simple correction with factor g for shortwave solar transmittance"
  extends PartialCorG;

equation
    for i in 1:n loop
      solarRadWinTrans[i] = SR_input[i].I*g;
    end for;

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple model with no correction of transmitted solar radiation
  depending on incidence angle.
</p>
</html>"));
end CorGSimple;
