within AixLib.Fluid.BoilerCHP.BoilerData;
record CondensingBoilerdatadef
  extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;
  parameter Real PCSI=1.11
    "Ratio gross (high) heating value / net (low) heating value defined according to the fuel";

  // ***************
  // nominal load
  // ***************
  parameter SI.Temperature T_nom(displayUnit="K") = 273.15 + 70
    "Nominal temperature";
  parameter Real PLR_nom=100 "Nominal loading rate (%)";
  parameter SI.Power P_nom(displayUnit="W") = 17300 "Nominal power";
  parameter Real eta_nom=97.4 "Nominal net heating value efficiency (%)";

  // ***************
  // part load
  // ***************
  parameter SI.Temperature T_int(displayUnit="l") = 273.15 + 33
    "Intermediate temperature";
  parameter Real PLR_int=30 "Intermediate loading rate (%)";
  parameter Real eta_int=107.2 "Intermediate net heating value efficiency (%)";

  // ***************
  // aux power
  // ***************
  parameter SI.Power P_loss(displayUnit="W") = 60
    "Stop losses at dT = 30 K";

  // ***************
  // geometry
  // ***************
  parameter SI.VolumeFlowRate V_flow(displayUnit="m3/s") = 1.02/3600
    "Nominal volume flow rate of water in the boiler";
  parameter Modelica.SIunits.Volume V_water(displayUnit="l") = 2.8E-3
    "Water volume in boiler";
  parameter SI.Mass mDry(displayUnit="kg") = 35 "Dry weight";
annotation (preferredView="text");
end CondensingBoilerdatadef;
