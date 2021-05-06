within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ExternalControl

  parameter Modelica.SIunits.TemperatureDifference dTWaterDim=15; // Auslegungstemperaturdifferenz
  parameter Modelica.SIunits.HeatFlowRate Q_nom=50000; // thermische Nennleistung [W]

  parameter Modelica.SIunits.Temp_K T_dim_out=266; // Auslegungstemperatur Außen
  parameter Modelica.SIunits.Temp_K T_lim_out=289; // Heizgrenztemperatur Außen


  constant Modelica.SIunits.SpecificHeatCapacity cp=4180;
  constant Real QRel_min=0.33;
  constant Modelica.SIunits.SpecificEnergy H=55498*1000;

  Modelica.SIunits.MassFlowRate m_flow_w_dim;// water mass flow

 Modelica.Blocks.Interfaces.RealInput TOutside(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="K") "Temperature outside of the building"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput QSet(final quantity="Power", final unit=
       "W") annotation (Placement(transformation(extent={{100,22},{120,42}})));
  Modelica.Blocks.Interfaces.RealOutput QRel "Part Load Ratio of Boiler"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput dTWaterSet(final quantity=
        "ThermodynamicTemperature", final unit="K")
    "Water temperature difference after part load calculation"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
equation
 m_flow_w_dim=Q_nom/(cp*dTWaterDim);

  if TOutside <= T_lim_out and TOutside > T_dim_out then

    QRel = (1 - QRel_min)*(TOutside - T_lim_out)/(T_dim_out - T_lim_out) +
      QRel_min;
  elseif TOutside <= T_dim_out then
    QRel = 1;
   else
    QRel = 0;
 end if;

  QSet = QRel*Q_nom;

  dTWaterSet = QSet/(cp*m_flow_w_dim);
    annotation (Placement(transformation(extent={{-120,-62},{-80,-22}})));
end ExternalControl;
