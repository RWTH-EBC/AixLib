within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model RadConvToSingle

  Utilities.Interfaces.ConvRadComb heatFloor annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},
            {110,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
             port_a annotation (Placement(transformation(extent={{-110,-10},{-90,
            10}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(each m=2)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-6,0})));
equation
  connect(thermalCollector.port_b, port_a) annotation (Line(points={{-16,6.66134e-16},
          {-60,6.66134e-16},{-60,0},{-100,0}}, color={191,0,0}));
  connect(thermalCollector.port_a[1], heatFloor.conv) annotation (Line(points={{
          3.75,-6.10623e-16},{24,-6.10623e-16},{24,0.05},{100.05,0.05}}, color={
          191,0,0}));
  connect(thermalCollector.port_a[2], heatFloor.rad) annotation (Line(points={{4.25,
          -6.66134e-16},{94,-6.66134e-16},{94,10},{106,10},{106,0},{100.05,0},{100.05,
          0.05}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RadConvToSingle;
