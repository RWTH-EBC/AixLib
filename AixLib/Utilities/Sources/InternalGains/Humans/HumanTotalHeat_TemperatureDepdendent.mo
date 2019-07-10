within AixLib.Utilities.Sources.InternalGains.Humans;
model HumanTotalHeat_TemperatureDepdendent
  "Model for total heat and moisture output of humans depending on the room temperature"
  extends HumanSensibleHeat_TemperatureDependent(thermalCollector(m=2));

  parameter Modelica.SIunits.SpecificEnthalpy enthalpyOfEvaporation=2500E3 "enthalpy of evaporation";

  BaseClasses.TemperatureDependentMoistuerOutput_SIA2024
    temperatureDependentMoistuerOutput_SIA2024_1
    annotation (Placement(transformation(extent={{-60,66},{-40,86}})));
  Modelica.Blocks.Interfaces.RealOutput MoistGain
    annotation (Placement(transformation(extent={{86,70},{106,90}})));
  Modelica.Blocks.Math.Gain toKgPerSecond(k=1/(3600*1000))
    annotation (Placement(transformation(extent={{14,70},{34,90}})));
  Modelica.Blocks.Math.MultiProduct productMoistureOutput(nu=2)
    annotation (Placement(transformation(extent={{-28,70},{-8,90}})));
  Modelica.Blocks.Math.Gain latentHeat(k=enthalpyOfEvaporation)
    annotation (Placement(transformation(extent={{-8,42},{12,62}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeatLatent(T_ref=T0)
    annotation (Placement(transformation(extent={{18,40},{42,64}})));
equation
  connect(to_degC.y, temperatureDependentMoistuerOutput_SIA2024_1.Temperature)
    annotation (Line(points={{-71.5,51},{-71.5,52},{-68,52},{-68,76},{-61,76}},
        color={0,0,127}));
  connect(temperatureDependentMoistuerOutput_SIA2024_1.moistOutput,
    productMoistureOutput.u[1]) annotation (Line(points={{-39,76},{-36,76},{-36,
          83.5},{-28,83.5}}, color={0,0,127}));
  connect(nrPeople.y, productMoistureOutput.u[2]) annotation (Line(points={{-57.4,
          -20},{-54,-20},{-54,30},{-28,30},{-28,68},{-34,68},{-34,76.5},{-28,76.5}},
        color={0,0,127}));
  connect(productMoistureOutput.y, toKgPerSecond.u)
    annotation (Line(points={{-6.3,80},{12,80}}, color={0,0,127}));
  connect(toKgPerSecond.y, MoistGain)
    annotation (Line(points={{35,80},{96,80}}, color={0,0,127}));
  connect(toKgPerSecond.y, latentHeat.u) annotation (Line(points={{35,80},{46,80},
          {46,66},{-16,66},{-16,52},{-10,52}}, color={0,0,127}));
  connect(latentHeat.y, ConvectiveHeatLatent.Q_flow)
    annotation (Line(points={{13,52},{18,52}}, color={0,0,127}));
  connect(ConvectiveHeatLatent.port, thermalCollector.port_a[2])
    annotation (Line(points={{42,52},{52,52},{52,50}}, color={191,0,0}));
end HumanTotalHeat_TemperatureDepdendent;
