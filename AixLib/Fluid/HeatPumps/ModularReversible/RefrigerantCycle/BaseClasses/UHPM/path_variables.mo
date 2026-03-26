within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM;
function path_variables
  input Refrigerant refrigerant;
  output SDFFilePaths paths;
algorithm
  if refrigerant == Refrigerant.R410A then
    paths.filename_T_Comp :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/TEMP_COMP_MEAN_Scroll_R410A.sdf");

    paths.filename_COP :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/COP_Scroll_R410A.sdf");

    paths.filename_PI :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/PI_Scroll_R410A.sdf");

  elseif refrigerant == Refrigerant.R290 then
    paths.filename_T_Comp :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/TEMP_COMP_MEAN_Scroll_R290.sdf");

    paths.filename_COP :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/COP_Scroll_R290.sdf");

    paths.filename_PI :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/PI_Scroll_R290.sdf");

  elseif refrigerant == Refrigerant.R134a then
    paths.filename_T_Comp :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/TEMP_COMP_MEAN_Scroll_R134a.sdf");

    paths.filename_COP :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/COP_Scroll_R134a.sdf");

    paths.filename_PI :=
      ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/PI_Scroll_R134a.sdf");
  end if;
end path_variables;
