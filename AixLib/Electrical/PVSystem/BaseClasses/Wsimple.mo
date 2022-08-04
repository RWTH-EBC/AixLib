within AixLib.Electrical.PVSystem.BaseClasses;
function Wsimple
  "Simple approximation for Lambert W function for x >= 2,
  should only be used for large input values as error decreases for increasing 
  input values (Batzelis, 2016)"

   input Real x(min=2);
   output Real W;
algorithm

  W:= log(x)*(1-log(log(x))/(log(x)+1));
end Wsimple;
