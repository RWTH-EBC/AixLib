within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced;
model RCTABS "Pipe Segment of Underfloor Heating System"

  parameter Boolean External = false
    "false if pipe has no Sheathing";

  parameter AixLib.DataBase.Walls.WallBaseDataDefinition UpperTABS
    "Upper TABS layers"    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition LowerTABS
    "Lower TABS layers"    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);

  parameter Modelica.SIunits.Area A "TABS Area" annotation(Dialog(group = "Room Specifications"));

  final parameter Modelica.SIunits.ThermalResistance RCond_up(min=Modelica.Constants.small)= sum(UpperTABS.d ./ (UpperTABS.lambda)) / A
    "Resistance of resistors RCond_up for upper part";
  final parameter Modelica.SIunits.HeatCapacity CTabs_up(min=Modelica.Constants.small) = A * sum(UpperTABS.d .* UpperTABS.c .* UpperTABS.rho)
    "heat capacitie for upper part";
  final parameter Modelica.SIunits.ThermalResistance RCond_lo(min=Modelica.Constants.small) = sum(LowerTABS.d ./ (LowerTABS.lambda)) / A
    "Resistance of resistors RCond_up for upper part";
  final parameter Modelica.SIunits.HeatCapacity CTabs_lo(min=Modelica.Constants.small) = A * sum(LowerTABS.d .* LowerTABS.c .* LowerTABS.rho)
    "heat capacitie for upper part";

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_1(
  final R=RCond_up/2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,58})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CTabs_Lo(
  final C=CTabs_lo) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_2(
  final R=RCond_up/2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,20})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_int
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CTabs_Up(
  final C=CTabs_up) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,40})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heat
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Lo_2(
  final R=RCond_lo/2) if   External annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-24})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Lo_1(
  final R=RCond_lo/2) if   External annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-62})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_ext if External
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
equation
  connect(RTabs_Up_1.port_b, port_int) annotation (Line(points={{6.66134e-16,68},
          {6.66134e-16,84},{0,84},{0,100}}, color={191,0,0}));
  connect(CTabs_Up.port, RTabs_Up_1.port_a) annotation (Line(points={{-50,40},{0,
          40},{0,48},{-5.55112e-16,48}}, color={191,0,0}));
  connect(RTabs_Up_2.port_b, CTabs_Up.port) annotation (Line(points={{4.44089e-16,
          30},{0,30},{0,40},{-50,40}}, color={191,0,0}));
  connect(port_heat, RTabs_Up_2.port_a)
    annotation (Line(points={{-100,0},{0,0},{0,10}},color={191,0,0}));
  if External then
    connect(CTabs_Lo.port, RTabs_Lo_1.port_a)
      annotation (Line(points={{-50,-40},{0,-40},{0,-52}}, color={191,0,0}));
    connect(RTabs_Lo_2.port_b, CTabs_Lo.port) annotation (Line(points={{-1.77636e-15,-34},{0,
            -34},{0,-40},{-50,-40}},         color={191,0,0}));
    connect(RTabs_Lo_1.port_b, port_ext)
      annotation (Line(points={{0,-72},{0,-100}}, color={191,0,0}));
    connect(RTabs_Lo_2.port_a, port_heat) annotation (Line(points={{1.77636e-15,-14},{0,-14},
            {0,0},{-100,0}},             color={191,0,0}));
  else
    connect(CTabs_Lo.port, port_heat) annotation (Line(points={{-50,-40},{22,-40},{22,-1.77636e-15},
            {-100,-1.77636e-15}},                       color={191,0,0}));
  end if;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,14},{100,-14}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
                                        Rectangle(extent={{-86,58},{-34,24}},
   fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{-28,58},{26,24}},      fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{32,58},{86,24}},      fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{-86,-22},{-34,-56}},      fillColor = {255, 213, 170},
   fillPattern =  FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{-28,-22},{26,-56}},      fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{32,-22},{86,-56}},      fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{-60,-62},{-6,-96}},      fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{0,-62},{54,-96}},      fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{-60,98},{-6,64}},       fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{0,98},{54,64}},       fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{60,-62},{86,-94}},      fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{60,98},{86,64}},       fillColor = {255, 213, 170},
   fillPattern =  FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{-86,-62},{-66,-96}},      fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent={{-86,98},{-66,64}},       fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}),
   Line(points={{-18,-34},{16,-34}},      pattern = LinePattern.None,
   thickness = 0.5, smooth = Smooth.None), Line(points={{-18,-46},{16,-46}},
   pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None),
   Text(extent={{-26,-92},{154,-130}},    lineColor = {0, 0, 255},
   textString = "%name"),
        Line(points={{8,28}},    color={28,108,200}),
                                     Line(points={{1,78},{1,-16}},
   color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None,
          origin={1,80},
          rotation=180),             Rectangle(extent={{-8.5,4.5},{8.5,-4.5}},
   lineColor = {0, 0, 0}, lineThickness =  0.5, fillColor = {255, 255, 255},
   fillPattern = FillPattern.Solid,
          origin={0.5,76.5},
          rotation=90),              Rectangle(extent={{-8.5,4.5},{8.5,-4.5}},
   lineColor = {0, 0, 0}, lineThickness =  0.5, fillColor = {255, 255, 255},
   fillPattern = FillPattern.Solid,
          origin={0.5,38.5},
          rotation=90),              Line(points={{3.12283e-15,-1},{1.83697e-16,
              -17}},
   color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None,
          origin={17,58},
          rotation=270),
   Line(points={{33.5,29.5},{47.5,29.5}}, color={0,0,0},     thickness=0.5,
   smooth=Smooth.Bezier,
          origin={45.5,18},
          rotation=90),
   Line(points={{40,29.5},{47.5,29.5}},   color={0,0,0},     thickness=0.5,
   smooth=Smooth.Bezier,
          origin={49.5,14},
          rotation=90),              Line(points={{1,64},{1,-34}},
   color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None,
          origin={1,-32},
          rotation=180),             Rectangle(extent={{-8.5,4.5},{8.5,-4.5}},
   lineColor = {0, 0, 0}, lineThickness =  0.5, fillColor = {255, 255, 255},
   fillPattern = FillPattern.Solid,
          origin={0.5,-35.5},
          rotation=90),              Line(points={{3.12283e-15,-1},{1.83697e-16,
              -17}},
   color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None,
          origin={17,-56},
          rotation=270),
   Line(points={{33.5,29.5},{47.5,29.5}}, color={0,0,0},     thickness=0.5,
   smooth=Smooth.Bezier,
          origin={45.5,-96},
          rotation=90),
   Line(points={{40,29.5},{47.5,29.5}},   color={0,0,0},     thickness=0.5,
   smooth=Smooth.Bezier,
          origin={49.5,-100},
          rotation=90),              Rectangle(extent={{-8.5,4.5},{8.5,-4.5}},
   lineColor = {0, 0, 0}, lineThickness =  0.5, fillColor = {255, 255, 255},
   fillPattern = FillPattern.Solid,
          origin={0.5,-73.5},
          rotation=90),              Line(points={{-1.34309e-14,75},{3.42777e-15,
              -19}},
   color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None,
          origin={-75,2},
          rotation=270)}));
end RCTABS;
