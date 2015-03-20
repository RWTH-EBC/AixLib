within AixLib.Building.Components.WindowsDoors.BaseClasses.CorrectionSolarGain;
model NoCorG "No correction for solar gain factor"
  extends CorrectionSolarGain.PartialCorG;
equation
    for i in 1:n loop
      solarRadWinTrans[i] = SR_input[i].I;
    end for;

end NoCorG;
