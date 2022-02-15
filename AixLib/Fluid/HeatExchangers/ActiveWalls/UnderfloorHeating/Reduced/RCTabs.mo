within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced;
model RCTABS "Pipe Segment of Underfloor Heating System"

  parameter Boolean External = false "false if TABS is internal";
  parameter Boolean from_TEASER = false "false if TABS info not from TEASER";
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition UpperTABS
    "Upper TABS layers"
    annotation (Dialog(enable=not from_TEASER,
    group="Room Specifications"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition LowerTABS "Lower TABS layers"
    annotation (Dialog(enable=not from_TEASER,
    group="Room Specifications"), choicesAllMatching=true);

  parameter Modelica.SIunits.Area A "TABS Area"
    annotation(Dialog(enable=not from_TEASER,
    group = "Room Specifications"));
  final parameter Modelica.SIunits.Time t_bt_up = 7*86400
    annotation(Dialog(enable=not from_TEASER,
    group = "Room Specifications"));
  final parameter Modelica.SIunits.Time t_bt_lo = 7*86400
    annotation(Dialog(enable=not from_TEASER,
    group = "Room Specifications"));
  parameter Modelica.SIunits.Temperature T_Fmax=302.15        "Maximum surface temperature" annotation (Dialog(group = "Room Specifications"));
  parameter Modelica.SIunits.Angle OrientationTabs=-1 "Orientation of exterior tabs";

  final parameter Real param_upper[3]=if not from_TEASER then
      AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.RCTABS_parameter(
      TABSlayers=UpperTABS,
      area=A,
      t_bt=t_bt_up) else fill(0, 3);
  final parameter Real param_lower[3]=
      AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.RCTABS_parameter(
      TABSlayers=LowerTABS,
      area=A,
      t_bt=t_bt_lo);

  parameter Modelica.SIunits.ThermalResistance R_up = param_upper[1];
  //param_upper[1];
  //(param_upper[1]+param_upper[3])*0.3;
  parameter Modelica.SIunits.HeatCapacity C_up = A* sum(UpperTABS.d .* UpperTABS.rho .* UpperTABS.c);
  parameter Modelica.SIunits.ThermalResistance R_up_rest = param_upper[3];

  parameter Modelica.SIunits.ThermalResistance R_lo = param_lower[1];
  parameter Modelica.SIunits.HeatCapacity C_lo = param_lower[2];
  // A* sum(LowerTABS.d .* LowerTABS.rho .* LowerTABS.c);
  parameter Modelica.SIunits.ThermalResistance R_lo_rest = param_lower[3];

  parameter Modelica.SIunits.Temperature T_start=
      Modelica.SIunits.Conversions.from_degC(16) "Initial temperature" annotation(Dialog(group="Thermal"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  Real dT = senTsur.T - TAir;

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_1(R=
        R_up_rest)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,58})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CTabs_Lo(
    final C=C_lo,
  final T(
      stateSelect=StateSelect.always,
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=T_start),
  final der_T(
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial),
      start=0)) if not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-46})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_2(R=R_up)
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,20})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_int
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CTabs_Up(
    final C=C_up,
  final T(
      stateSelect=StateSelect.always,
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=T_start),
  final der_T(
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial),
      start=0)) if not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-58,40})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heat
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={100,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Lo_1(final R=
        R_lo)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-24})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Lo_2(final R=
        R_lo_rest) if      External annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-62})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_ext if External
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-100})));
  Modelica.Blocks.Interaction.Show.RealValue T_Fm "arithmetic mean of floor surface temperature"
    annotation (Placement(transformation(extent={{52,72},{62,84}})));
  Modelica.Blocks.Interfaces.RealInput TAir annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-110})));

  Modelica.Blocks.Sources.RealExpression alpha_floor(y= if dT <= 0 then A*1.5 else A*(8.92*(abs(dT)^0.1) - 5.5)) if OrientationTabs == -1
    annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=180,
        origin={-50,-69})));
  Modelica.Blocks.Sources.RealExpression alpha_ceiling(y=if dT >= 0 then A*0.5 else A*(8.92*(abs(dT)^0.1) - 5.5)) if OrientationTabs == -2;
  Modelica.Blocks.Sources.RealExpression alpha_wall(y=A*2.5);
  Modelica.Blocks.Interfaces.RealOutput alpha_TABS annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,-110}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,-110})));
protected
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTsur "Wall surface temperature sensor"
    annotation (Placement(transformation(extent={{24,68},{44,88}})));
equation
  assert(
      senTsur.T <= T_Fmax,
      "Surface temperature in" + getInstanceName() + "too high",
      AssertionLevel.warning);

  connect(RTabs_Up_1.port_b, port_int) annotation (Line(points={{6.66134e-16,68},
          {6.66134e-16,84},{0,84},{0,100}}, color={191,0,0}));
  connect(CTabs_Up.port, RTabs_Up_1.port_a) annotation (Line(points={{-48,40},{0,
          40},{0,48},{-5.55112e-16,48}}, color={191,0,0}));
  connect(RTabs_Up_2.port_b, CTabs_Up.port) annotation (Line(points={{4.44089e-16,
          30},{0,30},{0,40},{-48,40}}, color={191,0,0}));
  connect(port_heat, RTabs_Up_2.port_a)    annotation (Line(points={{100,0},{0,0},{0,10}}, color={191,0,0}));
  connect(RTabs_Lo_1.port_a, port_heat) annotation (Line(points={{1.77636e-15,-14},
          {0,-14},{0,0},{100,0}}, color={191,0,0}));
  connect(RTabs_Lo_1.port_b, CTabs_Lo.port) annotation (Line(points={{-1.77636e-15,
          -34},{0,-34},{0,-46},{-50,-46}}, color={191,0,0}));
  if External then
    connect(CTabs_Lo.port,RTabs_Lo_2. port_a)
      annotation (Line(points={{-50,-46},{0,-46},{0,-52}}, color={191,0,0}));
    connect(RTabs_Lo_2.port_b, port_ext)
      annotation (Line(points={{0,-72},{0,-100}}, color={191,0,0}));
  end if;

  connect(senTsur.port, RTabs_Up_1.port_b) annotation (Line(points={{24,78},{0,78},
          {0,68},{4.44089e-16,68}}, color={191,0,0}));
  connect(senTsur.T, T_Fm.numberPort)
    annotation (Line(points={{44,78},{51.25,78}}, color={0,0,127}));
  if OrientationTabs == -1 then
    connect(alpha_floor.y, alpha_TABS) annotation (Line(points={{-61,-69},{-80,-69},
          {-80,-110}}, color={0,0,127}));
  elseif OrientationTabs == -2 then
    connect(alpha_ceiling.y, alpha_TABS);
  else
    connect(alpha_wall.y, alpha_TABS);
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
   Text(extent={{-90,19},{90,-19}},       lineColor = {0, 0, 255},
   textString = "%name",
          origin={-120,-1},
          rotation=90),
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
          origin={19,0},
          rotation=270)}), experiment(
      StopTime=1814400,
      Interval=3600,
      __Dymola_Algorithm="Cvode"));
end RCTABS;
