within AixLib.FastHVAC.Components.HeatExchangers.BaseClasses;
class Calc_Excess_Temp
  "different choices of calculating the excess temperature of the radiator"

  constant Integer ari=1 "arithmetic calculation";
  constant Integer log=2 "logarithmic calculation";
  constant Integer exp=3 "exponential calculation";

  type Temp
    extends Integer;
    annotation (Evaluate=true, choices(
        choice=HVAC.Components.HeatExchanger.BaseClasses.Calc_Excess_Temp.ari
          "arithmetic calculation",
        choice=HVAC.Components.HeatExchanger.BaseClasses.Calc_Excess_Temp.log
          "logarithmic calculation",
        choice=HVAC.Components.HeatExchanger.BaseClasses.Calc_Excess_Temp.exp
          "exponential calculation"));
  end Temp;

end Calc_Excess_Temp;
