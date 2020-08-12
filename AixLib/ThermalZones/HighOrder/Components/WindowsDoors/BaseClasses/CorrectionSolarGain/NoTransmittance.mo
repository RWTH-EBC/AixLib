within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
model NoTransmittance "Opaque window, no shortwave transmittance"
  extends CorrectionSolarGain.PartialCorG;

   parameter Boolean selectable = true "Select window type" annotation (Dialog(group="Window type", descriptionLabel = true));

   parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType=
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "Window type"
    annotation (Dialog(
      group="Window type",
      enable=selectable,
      descriptionLabel=true), choicesAllMatching=true);

   parameter Real g=0
    "Coefficient of solar energy transmission";

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
end NoTransmittance;
