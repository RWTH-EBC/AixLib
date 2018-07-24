within AixLib.Fluid.HeatPumps.BaseClasses;
block HeatingCurve
  "Depending on T_amb, calculating the supply Temperature according to set points and day night mode"
  Modelica.Blocks.Interfaces.RealInput T_amb "Ambient temperature"
    annotation (Placement(transformation(extent={{-130,62},{-100,92}})));
  Modelica.Blocks.Interfaces.RealOutput TSet
    "Calculated set temperature based on heating curve"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant TSet_nom(final k=TDes_set)
                                            "Set temperature at T_amb_nom"
    annotation (Placement(transformation(extent={{-100,-82},{-88,-70}})));
  Modelica.Blocks.Sources.Constant T_amb_nom(final k=TDes_amb)
                                             "Setpoint of heating curve"
    annotation (Placement(transformation(extent={{-100,-32},{-88,-20}})));
  Modelica.Blocks.Sources.Constant steepness(final k=factorSte)
    "Factor by which the heating curves steepness is adjusted"
    annotation (Placement(transformation(extent={{-100,-56},{-88,-44}})));
  Modelica.Blocks.Sources.Constant TRooDay_in(final k=TRooDay)
    "Desired temperature of room at daytime"
    annotation (Placement(transformation(extent={{-100,40},{-88,52}})));
  Modelica.Blocks.Sources.Constant TRooNig_in(final k=TRooNig)
    "Disered temperature of room at night"
    annotation (Placement(transformation(extent={{-100,10},{-88,22}})));
  Modelica.Blocks.Interfaces.BooleanInput isDay
    "True if daytime, false if nighttime"
    annotation (Placement(transformation(extent={{-130,16},{-100,46}})));
  Modelica.Blocks.Logical.Switch DayNigSwi
    "Switches between day and night set temperature"
    annotation (Placement(transformation(extent={{-70,26},{-60,36}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{66,-6},{78,6}})));
  Modelica.Blocks.Math.Product CorSte
    "correction factor for steepness of heating curve"
    annotation (Placement(transformation(extent={{6,-38},{20,-24}})));
  Modelica.Blocks.Math.Division calcGrad
    "output is the steepness of the heating curve"
    annotation (Placement(transformation(extent={{-22,-28},{-8,-14}})));
  Modelica.Blocks.Math.Add deltaY(k2=-1)
    "Difference between Room and nominal set temperature"
    annotation (Placement(transformation(extent={{-44,-14},{-32,-2}})));
  Modelica.Blocks.Math.Add deltaX(k2=-1)
    "Difference between Room and ambient nominal temperature"
    annotation (Placement(transformation(extent={{-44,-36},{-32,-24}})));
  Modelica.Blocks.Math.Product CorSte1
    "correction factor for steepness of heating curve"
    annotation (Placement(transformation(extent={{34,2},{48,16}})));
  Modelica.Blocks.Math.Add deltaT_amb(k2=-1)
    "Difference between T_amb and T_amb_nom"
    annotation (Placement(transformation(extent={{-34,34},{-22,46}})));

  parameter Modelica.SIunits.Temp_K TRooNig=283.15
    "Desired temperature of room at nighttime";
  parameter Modelica.SIunits.Temp_K TRooDay=293.15
    "Desired temperature of room at daytime";
  parameter Modelica.SIunits.Temp_K TDes_amb=253.15 "Design ambient temperature";
  parameter Modelica.SIunits.Temp_K TDes_set "Design set temperature";
  parameter Real factorSte=1 "Steepness factor for heating curve";
equation
  connect(TRooNig_in.y, DayNigSwi.u3) annotation (Line(points={{-87.4,16},{-78,16},
          {-78,27},{-71,27}}, color={0,0,127}));
  connect(TRooDay_in.y, DayNigSwi.u1) annotation (Line(points={{-87.4,46},{-78,46},
          {-78,35},{-71,35}}, color={0,0,127}));
  connect(isDay, DayNigSwi.u2)
    annotation (Line(points={{-115,31},{-71,31}}, color={255,0,255}));
  connect(add.y, TSet)
    annotation (Line(points={{78.6,0},{110,0}}, color={0,0,127}));
  connect(TSet_nom.y, add.u2) annotation (Line(points={{-87.4,-76},{56,-76},{56,
          -3.6},{64.8,-3.6}}, color={0,0,127}));
  connect(TSet_nom.y, deltaY.u2) annotation (Line(points={{-87.4,-76},{-66,-76},
          {-66,-11.6},{-45.2,-11.6}}, color={0,0,127}));
  connect(DayNigSwi.y, deltaY.u1) annotation (Line(points={{-59.5,31},{-52,31},{
          -52,-4.4},{-45.2,-4.4}}, color={0,0,127}));
  connect(DayNigSwi.y, deltaX.u1) annotation (Line(points={{-59.5,31},{-52,31},{-52,-26.4},
          {-45.2,-26.4}},            color={0,0,127}));
  connect(T_amb_nom.y, deltaX.u2) annotation (Line(points={{-87.4,-26},{-66,-26},{-66,
          -33.6},{-45.2,-33.6}},      color={0,0,127}));
  connect(deltaY.y, calcGrad.u1) annotation (Line(points={{-31.4,-8},{-28,-8},{-28,
          -16.8},{-23.4,-16.8}}, color={0,0,127}));
  connect(deltaX.y, calcGrad.u2) annotation (Line(points={{-31.4,-30},{-26,-30},{-26,-25.2},
          {-23.4,-25.2}},             color={0,0,127}));
  connect(calcGrad.y, CorSte.u1) annotation (Line(points={{-7.3,-21},{-0.65,-21},
          {-0.65,-26.8},{4.6,-26.8}}, color={0,0,127}));
  connect(steepness.y, CorSte.u2) annotation (Line(points={{-87.4,-50},{0,-50},{
          0,-35.2},{4.6,-35.2}}, color={0,0,127}));
  connect(CorSte.y, CorSte1.u2) annotation (Line(points={{20.7,-31},{20.7,4.5},{
          32.6,4.5},{32.6,4.8}}, color={0,0,127}));
  connect(T_amb, deltaT_amb.u1) annotation (Line(points={{-115,77},{-44,77},{-44,
          43.6},{-35.2,43.6}}, color={0,0,127}));
  connect(T_amb_nom.y, deltaT_amb.u2) annotation (Line(points={{-87.4,-26},{-52,
          -26},{-52,36.4},{-35.2,36.4}}, color={0,0,127}));
  connect(deltaT_amb.y, CorSte1.u1) annotation (Line(points={{-21.4,40},{6,40},{
          6,13.2},{32.6,13.2}}, color={0,0,127}));
  connect(CorSte1.y, add.u1) annotation (Line(points={{48.7,9},{57.35,9},{57.35,
          3.6},{64.8,3.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-96,96},{96,-96}}, lineColor={28,108,200}),
        Line(points={{-82,86},{-82,-80}}, color={28,108,200}),
        Line(points={{90,-80},{-82,-80}}, color={28,108,200}),
        Line(points={{-82,86},{-86,80}}, color={28,108,200}),
        Line(points={{-82,86},{-78,80}}, color={28,108,200}),
        Line(points={{90,-80},{84,-76}}, color={28,108,200}),
        Line(points={{90,-80},{84,-84}}, color={28,108,200}),
        Line(
          points={{-82,-80+166*(TDes_set-273.15)/100},{80,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(points=DynamicSelect(
              {{-86,-60},{-78,-60}},
              {-86,-80 + 166*(DayNigSwi.y - 273.15)/100},
              {-78,-80 + 166*(DayNigSwi.y - 273.15)/100}), color={28,108,200}),
        Line(points={{90,-84},{90,-76}}, color={28,108,200},
          pattern=LinePattern.Dot),
        Line(points=DynamicSelect({{-86,86},{-78,86}}, {{-86,-80+166*(TDes_set-273.15)/100},{-78,-80+166*(TDes_set-273.15)/100}}),
            color={238,46,47})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatingCurve;
