within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneMoistAir "Multizone model with humidity balance"
  extends Multizone(redeclare final model thermalZone =
        AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZoneMoistAirEquipped);
  Modelica.Blocks.Interfaces.RealInput ventHum[numZones]
    "Ventilation and infiltration humidity" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-70,-100}), iconTransformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-90,-30})));
  Modelica.Blocks.Interfaces.RealOutput X_w[numZones]
    "absolute humidity in thermal zone" annotation (Placement(transformation(
          extent={{100,84},{120,104}}), iconTransformation(extent={{80,-20},{
            100,2}})));
equation
  connect(zone.ventHum, ventHum) annotation (Line(points={{35.27,55.765},{10,
          55.765},{10,56},{-16,56},{-16,-22},{-70,-22},{-70,-100}}, color={0,0,
          127}));
  connect(zone.X_w, X_w) annotation (Line(points={{82.1,84.67},{92,84.67},{92,
          94},{110,94}}, color={0,0,127}));
end MultizoneMoistAir;
