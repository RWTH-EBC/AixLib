within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Controler;
model ControlerHumidifier "controler for humidifier"
  parameter Boolean use_PhiSet = false
    "true if relative humidity is controlled, otherwise absolute humidity is controlled";
  Modelica.Blocks.Interfaces.RealInput Xset if not use_PhiSet
    "set value for absolute humidity at cooler outlet"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealInput PhiSet if use_PhiSet
    "set value for relative humidity at ahu outlet"
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.RelToAbsHum x_pTphi if use_PhiSet
    annotation (Placement(transformation(extent={{-60,-24},{-40,-44}})));
  Modelica.Blocks.Interfaces.RealInput Tset(start=293.15) if use_PhiSet
    "set value for temperature at cooler outlet"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealOutput XHumSet
    "set value for humidity control of humidifier"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Blocks.Interfaces.RealInput X_intern "internal mass fraction";
equation

  if use_PhiSet then
    connect(x_pTphi.absHum,X_intern);
    connect(Tset, x_pTphi.TDryBul) annotation (Line(points={{-120,50},{-74,50},
            {-74,-28.4},{-62,-28.4}},
                      color={0,0,127},
                      pattern=LinePattern.Dash));
    connect(PhiSet, x_pTphi.relHum) annotation (Line(points={{-120,-70},{-74,
            -70},{-74,-39.2},{-62,-39.2}},
                      color={0,0,127},
                      pattern=LinePattern.Dash));
  else
    connect(Xset, X_intern);
  end if;

  connect(X_intern, XHumSet);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,100},{100,0},{20,-100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>February, 2025 by Martin Kremer:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end ControlerHumidifier;
