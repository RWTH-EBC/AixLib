within AixLib.Fluid.Examples.DistrictHeating.BaseClasses.Functions.Characteristics;
function VariableNrpm
  "Electrical power calculation dependent on variable rotational speed (rpm)"
  extends
    AixLib.Fluid.Examples.DistrictHeating.BaseClasses.Functions.Characteristics.BaseFct(
    N,
    T_con,
    T_eva,
    mFlow_eva,
    mFlow_con);
     parameter Real qualityGrade=0.3 "Constant quality grade";
     parameter Real N_max= 3000 "Maximum speed of compressor in 1/min";
     parameter Modelica.SIunits.Power P_com=23000 "Maximum electric power input for compressor";

protected
    Real CoP_C "Carnot CoP";
    Real Pel_curr "Current electrical power dependent on rotational speed";
algorithm
  Pel_curr:=((N/N_max)^3)*P_com;
  CoP_C:=T_con/(T_con - T_eva);
  Char:= {Pel_curr,Pel_curr*CoP_C*qualityGrade};

end VariableNrpm;
