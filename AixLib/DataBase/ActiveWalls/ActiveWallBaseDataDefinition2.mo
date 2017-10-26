within AixLib.DataBase.ActiveWalls;
record ActiveWallBaseDataDefinition2
  "Base data definition for active walls"
extends Modelica.Icons.Record;
parameter Modelica.SIunits.Temperature Temp_nom[3] "Nominal Temperatures T_flow, T_return, T_room / air ";
parameter Modelica.SIunits.HeatFlux q_dot_nom  "nominal Power per square meter";
parameter Modelica.SIunits.CoefficientOfHeatTransfer k_isolation;
parameter Modelica.SIunits.CoefficientOfHeatTransfer k_top;
parameter Modelica.SIunits.CoefficientOfHeatTransfer k_down;
parameter Real VolumeWaterPerMeter(unit="l/m") "Water volume";
parameter Modelica.SIunits.Length Spacing "Spacing of Pipe";
parameter Modelica.SIunits.Emissivity eps "Emissivity of Floor";
parameter AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.HeatCapacityPerArea C_ActivatedElement;
parameter Real c_top_ratio;
parameter Real PressureDropExponent;
parameter Real PressureDropCoefficient;
end ActiveWallBaseDataDefinition2;
