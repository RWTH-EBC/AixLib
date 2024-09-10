within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model RadConvToSingle

  Utilities.Interfaces.ConvRadComb heatFloor annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},
            {110,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portCon
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
             portRad
                    annotation (Placement(transformation(extent={{-110,-72},{
            -90,-52}})));
equation
  connect(portCon, heatFloor.conv) annotation (Line(points={{-100,60},{24,60},{
          24,26},{100.05,26},{100.05,0.05}}, color={191,0,0}));
  connect(portRad, heatFloor.rad) annotation (Line(points={{-100,-62},{-16,-62},
          {-16,-58},{100.05,-58},{100.05,0.05}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RadConvToSingle;
