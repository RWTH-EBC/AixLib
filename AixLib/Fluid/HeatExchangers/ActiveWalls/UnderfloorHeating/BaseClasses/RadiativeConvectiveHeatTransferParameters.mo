within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
model RadiativeConvectiveHeatTransferParameters
  "Contains parameters for propagation to system models"
  parameter
    AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodConvectiveHeatTransferInsideSurface
    calcMethod=AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodConvectiveHeatTransferInsideSurface.Bernd_Glueck
    "Calculation method for convective heat transfer coefficient"
        annotation(Dialog(tab="Radiation and Convection"));
  parameter AixLib.ThermalZones.HighOrder.Components.Types.InsideSurfaceOrientation
    surfaceOrientation=AixLib.ThermalZones.HighOrder.Components.Types.InsideSurfaceOrientation.vertical_wall
    "Surface orientation"
    annotation(Dialog(tab="Radiation and Convection"));
  parameter
    AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodRadiativeHeatTransfer
    radCalcMethod=AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodRadiativeHeatTransfer.No_approx
    "Calculation method for radiation heat transfer"
        annotation(Dialog(tab="Radiation and Convection"));

  parameter Modelica.Units.SI.Temperature T_ref=
      Modelica.Units.Conversions.from_degC(16)
    "Reference temperature for optional linearization"
    annotation (Dialog(tab="Radiation and Convection", enable=radCalcMethod == AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodRadiativeHeatTransfer.Linear_constant_T_ref));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hCon_const=2.5
    "Custom convective heat transfer coefficient" annotation (Dialog(
    enable=calcMethod == AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodConvectiveHeatTransferInsideSurface.Custom_hCon,
    tab="Radiation and Convection"));

  parameter Modelica.Units.SI.TemperatureDifference dT_small=0.1
    "Linearized function around dT = 0 K +/-" annotation (Dialog(tab="Radiation and Convection",
        descriptionLabel=true, enable=if calcMethod == AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodConvectiveHeatTransferInsideSurface.EN_ISO_6946_Appendix_A or calcMethod == AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodConvectiveHeatTransferInsideSurface.Bernd_Glueck or
          calcMethod == AixLib.ThermalZones.HighOrder.Components.Types.CalcMethodConvectiveHeatTransferInsideSurface.ASHRAE140_2017 then true else false));
end RadiativeConvectiveHeatTransferParameters;
