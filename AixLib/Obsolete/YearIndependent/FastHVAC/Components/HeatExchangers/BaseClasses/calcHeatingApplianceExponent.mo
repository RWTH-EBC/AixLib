within AixLib.Obsolete.YearIndependent.FastHVAC.Components.HeatExchangers.BaseClasses;
function calcHeatingApplianceExponent
  input Real delta_T;
  input Real dT_nom;
  input Real delta;
  input Real delta_nom;
  input Real n;
  input Real s_eff;
  output Real n_k;
algorithm

/*
avoiding discontinuity by case-by-case analysis
*/
  n_k:=n;
/* Detailled calculation of heating applicance exponent for heater excess temperature less than 30 K.
Otherwise the heating applicance exponent of nominal conditions can be used 
*/
/*
  
if delta_T < 30 then
    
if delta_T < 5 then
      
n_k:=ln(abs((abs(2)/dT_nom)^n - s_eff*abs(2/delta_nom))/(1 - s_eff))/ln(
       abs(2/dT_nom));
else
   n_k:=ln(abs((abs(delta_T)/dT_nom)^n - s_eff*abs(delta/delta_nom))/(1 - s_eff))/ln(
       abs(delta_T/dT_nom));
end if;
    
else
  n_k:=n;
 end if;
  */
end calcHeatingApplianceExponent;
