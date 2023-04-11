within AixLib.Fluid.Pools.BaseClasses;
model HeatTransferConduction
  "Heat transfer due to conduction through pool walls"

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  parameter Modelica.Units.SI.Area AWalInt "Area of pool walls which is connected to inner rooms (inner pool walls)";
  parameter Modelica.Units.SI.Area AWalExt "Area of pool walls which is connected to the ground (pool wall with earth contact)";
  parameter Modelica.Units.SI.Area AFloInt "Area of pool floors which is connected to inner rooms (inner pool floor)";
  parameter Modelica.Units.SI.Area AFloExt "Area of pool floors which is connected to teh ground (pool floor with earth contact)";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterHorizontal "Mean value for the heat transfer coefficient of free convection on horizontal pool floors";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterVertical "Mean value for the heat transfer coefficient of free convection on vertical pool walls";

  parameter Modelica.Units.SI.Temperature TPool "Set temperature for pool";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature HeatFlowOuter
    "Generate Heat Flow for earth contact" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={74,-28})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_a
    "Inlet for heattransfer"  annotation (Placement(transformation(extent={{-116,
            -14},{-90,12}}),
        iconTransformation(extent={{-116,-14},{-90,12}})));

  Modelica.Blocks.Interfaces.RealInput TSoil "Temperature of Soil" annotation (Placement(transformation(extent={{130,-48},
            {90,-8}}),
        iconTransformation(extent={{126,16},{86,56}})));

  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
    InnerPoolFloor(
    A=AFloInt,
    wallRec=PoolWall,
    T_start=fill(TPool, PoolWall.n),
    energyDynamics=energyDynamics)
             annotation (Placement(transformation(extent={{-2,-32},{22,-8}})));
  AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterHorizontalInner(
    hCon_const=hConWaterHorizontal,
    A=AFloInt,
    calcMethod=3,
    surfaceOrientation=1)
                  annotation (Placement(transformation(
        origin={-50,-20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterVerticalOuter(
    hCon_const=hConWaterVertical,
    A=AWalExt,
    calcMethod=3,
    surfaceOrientation=1)  annotation (Placement(transformation(
        origin={-50,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
    PoolWallWithEarthContact(
    A=AWalExt,
    wallRec=PoolWall,
    T_start=fill(TPool, PoolWall.n),
    energyDynamics=energyDynamics)
             annotation (Placement(transformation(extent={{-2,28},{22,52}})));
  AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterHorizontalOuter(
    hCon_const=hConWaterHorizontal,
    A=AFloExt,
    calcMethod=3,
    surfaceOrientation=1)  annotation (Placement(transformation(
        origin={-50,-60},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
    PoolFloorWithEarthContact(
    A=AFloExt,
    wallRec=PoolWall,
    T_start=fill(TPool, PoolWall.n),
    energyDynamics=energyDynamics)
             annotation (Placement(transformation(extent={{-2,-72},{22,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow1 "Generate Heat Flow for earth contact"
                           annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={44,12})));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
    InnerPoolWall(
    A=AWalInt,
    wallRec=PoolWall,
    T_start=fill(TPool, PoolWall.n),
    energyDynamics=energyDynamics)
             annotation (Placement(transformation(extent={{-2,68},{22,92}})));
  Modelica.Blocks.Sources.RealExpression HeatFlowInner(y=0)
    "Inner pool walls are not connected to other zones, only outer pool walls have earth contact"
    annotation (Placement(transformation(extent={{96,2},{76,22}})));
  AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterVerticalInner(
    hCon_const=hConWaterVertical,
    A=AWalInt,
    calcMethod=3,
    surfaceOrientation=1)  annotation (Placement(transformation(
        origin={-50,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition PoolWall
    "Wall type for pool walls, record contains all wall layers"
    annotation (Placement(transformation(extent={{76,-98},{96,-78}})));
equation
  connect(HeatFlowOuter.T, TSoil)
    annotation (Line(points={{81.2,-28},{110,-28}}, color={0,0,127}));
  connect(heatport_a, heatport_a)
    annotation (Line(points={{-103,-1},{-103,-1}}, color={191,0,0}));
  connect(HeatConvWaterHorizontalInner.port_a, InnerPoolFloor.port_a)
    annotation (Line(points={{-40,-20},{-2,-20}},  color={191,0,0}));
  connect(PoolFloorWithEarthContact.port_b, HeatFlowOuter.port) annotation (
      Line(points={{22,-61},{58,-61},{58,-28},{68,-28}}, color={191,0,0}));
  connect(PoolFloorWithEarthContact.port_a, HeatConvWaterHorizontalOuter.port_a)
    annotation (Line(points={{-2,-61},{-2,-60},{-40,-60}},   color={191,0,0}));
  connect(InnerPoolWall.port_b, prescribedHeatFlow1.port) annotation (Line(
        points={{22,80},{30,80},{30,12},{38,12}}, color={191,0,0}));
  connect(HeatConvWaterVerticalOuter.port_b, heatport_a) annotation (Line(
        points={{-60,40},{-72,40},{-72,-1},{-103,-1}}, color={191,0,0}));
  connect(HeatConvWaterHorizontalInner.port_b, heatport_a) annotation (Line(
        points={{-60,-20},{-72,-20},{-72,-1},{-103,-1}}, color={191,0,0}));
  connect(HeatConvWaterHorizontalOuter.port_b, heatport_a) annotation (Line(
        points={{-60,-60},{-72,-60},{-72,-1},{-103,-1}}, color={191,0,0}));
  connect(prescribedHeatFlow1.Q_flow, HeatFlowInner.y)
    annotation (Line(points={{50,12},{75,12}}, color={0,0,127}));
  connect(HeatFlowOuter.port, PoolWallWithEarthContact.port_b) annotation (Line(
        points={{68,-28},{58,-28},{58,40},{22,40}}, color={191,0,0}));
  connect(InnerPoolFloor.port_b, prescribedHeatFlow1.port) annotation (Line(
        points={{22,-20},{30,-20},{30,12},{38,12}}, color={191,0,0}));
  connect(HeatConvWaterVerticalOuter.port_a, PoolWallWithEarthContact.port_a)
    annotation (Line(points={{-40,40},{-2,40}}, color={191,0,0}));
  connect(InnerPoolWall.port_a, HeatConvWaterVerticalInner.port_a) annotation (
      Line(points={{-2,80},{-40,80}},                   color={191,0,0}));
  connect(HeatConvWaterVerticalInner.port_b, heatport_a) annotation (Line(
        points={{-60,80},{-72,80},{-72,-1},{-103,-1}},color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,58},{28,-26}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,68},{48,-46}},
          lineColor={135,135,135},
          fillColor={175,175,175},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-86,-26},{30,-46}},
          lineColor={135,135,135},
          fillColor={175,175,175},
          fillPattern=FillPattern.Forward),
        Polygon(
          points={{-16,-10},{-4,6},{58,-52},{46,-62},{-16,-10}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{32,-68},{36,-66},{62,-38},{76,-78},{32,-68}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
    <p>This model is a base model to calculate the heat transfer through pool walls. The pool walls are  divided in: vertical walls without earth contact, vertical walls with earth contact, pool floor without earth contact, pool floor with earth contact.</p>
</html>"));
end HeatTransferConduction;
