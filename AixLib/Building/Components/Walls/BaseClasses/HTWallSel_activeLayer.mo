within AixLib.Building.Components.Walls.BaseClasses;
model HTWallSel_activeLayer
  "Basic models for heat transfer in a wall with selectable components (radiation, convection) and an active layer "
  parameter Modelica.SIunits.Height h = 3 "Height" annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length l = 4 "Length" annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Area clearance = 0 "Area of clearance" annotation(Dialog(group = "Geometry"));
  parameter DataBase.Walls.WallBaseDataDefinition wallType = DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
    "Type of wall"                                                                                                     annotation(choicesAllMatching = true);

  //Selectable models
  // add convection model
  parameter Boolean withConvection = true "With convection model on side of port b" annotation (Dialog(group = "Selectable components",descriptionLabel = true), choices(__Dymola_checkBox=true));
  // which orientation of surface?
  parameter Integer surfaceOrientation = 1 "Surface orientation" annotation(Dialog(group = "Selectable components", descriptionLabel = true, enable = withConvection), choices(choice = 1
        "vertical",                                                                                                    choice = 2
        "horizontal facing up",                                                                                                    choice = 3
        "horizontal facing down",                                                                                                    radioButtons = true));
  parameter Boolean withRadExchange = true "With radiation model on side of port b" annotation (Dialog(group = "Selectable components",descriptionLabel = true), choices(__Dymola_checkBox=true));
  parameter Boolean withActiveLayer = true "With an active layer" annotation (Dialog(group = "Selectable components",descriptionLabel = true), choices(__Dymola_checkBox=true));
  parameter Integer[2] connActiveLayer = {2,3} "Active layer to come between layers" annotation (Dialog(group = "Selectable components",descriptionLabel = true, enable = withActiveLayer), choices(__Dymola_checkBox=true));
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(16)
    "Initial temperature"                                                                                      annotation(Dialog(group = "Thermal"));
  // 2n HeatConds
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCondb[wallType.n](
    port_b(each T(start=T0)),
    port_a(each T(start=T0)),
    G=A .* wallType.lambda ./ (wallType.d/2))
    annotation (Placement(transformation(extent={{8,-8},{28,12}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatConda[wallType.n](
    port_b(each T(start=T0)),
    port_a(each T(start=T0)),
    G=A .* wallType.lambda ./ (wallType.d/2))
    annotation (Placement(transformation(extent={{-50,-8},{-30,12}})));
  // n Loads
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Load[wallType.n](
                            C=wallType.c .* wallType.rho .* A .* wallType.d, T(start=
          fill(T0, wallType.n)))
    annotation (Placement(transformation(extent={{-8,-62},{12,-42}})));
  Utilities.HeatTransfer.HeatConv_inside HeatConv1(port_b(T(start = T0)),                              A = A, surfaceOrientation = surfaceOrientation,
    calcMethod=1)                                                                                                                                      annotation(Placement(transformation(origin={62,2},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Utilities.Interfaces.Star Star annotation(Placement(transformation(extent = {{80, 50}, {100, 70}})));
  Utilities.HeatTransfer.HeatToStar twoStar_RadEx(A = A,            Therm(T(start = T0)), Star(T(start = T0)),
    eps=wallType.eps)                                                                                          annotation(Placement(transformation(extent = {{54, 30}, {74, 50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-104, -8}, {-84, 12}}), iconTransformation(extent = {{-100, -20}, {-80, 0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent = {{76, -8}, {96, 12}}), iconTransformation(extent = {{80, -20}, {100, 0}})));
protected
  parameter Modelica.SIunits.Area A = h * l - clearance;
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portActiveLayer_a
    annotation (Placement(transformation(extent={{-44,80},{-24,100}}),
        iconTransformation(extent={{-44,80},{-24,100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b portActiveLayer_b
    annotation (Placement(transformation(extent={{24,80},{44,100}}),
        iconTransformation(extent={{24,80},{44,100}})));

equation
  // connecting inner elements HeatCondb[i]--Load[i]--HeatConda[i] to n groups
  for i in 1:wallType.n loop
    connect(HeatConda[i].port_b, Load[i].port) annotation(Line(points = {{-30, 2}, {-10, 2}, {-10, -62}, {2, -62}}, color = {200, 100, 0}));
    connect(Load[i].port, HeatCondb[i].port_a) annotation(Line(points = {{2, -62}, {-10, -62}, {-10, 2}, {8, 2}}, color = {200, 100, 0}));
  end for;
  // establishing n-1 connections of HeatCondb--Load--HeatConda groups
  for i in 1:wallType.n - 1 loop
    if withActiveLayer then
      if i == connActiveLayer[1] then
        connect(HeatCondb[i].port_b, portActiveLayer_a);
        connect(portActiveLayer_b, HeatConda[i+1].port_a);
      else
        connect(HeatCondb[i].port_b, HeatConda[i + 1].port_a);
      end if;
    else
      connect(HeatCondb[i].port_b, HeatConda[i + 1].port_a);
    end if;
  end for;
  // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--HeatConv1--port_b
  connect(HeatConda[1].port_a, port_a) annotation(Line(points = {{-50, 2}, {-94, 2}}, color = {200, 100, 0}));
  connect(HeatConv1.port_a, port_b) annotation(Line(points={{72,2},{72,2},{86,2}},                       color = {200, 100, 0}));
  connect(HeatCondb[wallType.n].port_b, HeatConv1.port_b) annotation(Line(points={{28,2},{
          52,2}},                                                                                                 color = {200, 100, 0}));
  connect(HeatConv1.port_b, twoStar_RadEx.Therm) annotation(Line(points={{52,2},{
          50,2},{50,40},{54.8,40}},                                                                                   color = {200, 100, 0}));
  connect(twoStar_RadEx.Star, Star) annotation(Line(points = {{73.1, 40}, {90, 40}, {90, 60}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  // computing approximated longwave radiation exchange
  connect(HeatCondb[1].port_b,portActiveLayer_a)  annotation (Line(points={{28,2},{
          34,2},{34,22},{-22,22},{-22,90},{-34,90}},         color={191,0,0}));
  connect(portActiveLayer_b, HeatConda[1].port_a) annotation (Line(points={{34,90},
          {34,22},{-58,22},{-58,2},{-50,2}}, color={191,0,0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0})}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{24, 100}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-56, 100}, {0, -100}}, lineColor = {166, 166, 166}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-64, 100}, {-56, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-72, 100}, {-64, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 100}, {-72, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{0, 100}, {8, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{16, 100}, {24, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{8, 100}, {16, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, -30}, {80, -42}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, -32}, {80, -39}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "gap"), Text(extent = {{-44, -40}, {52, -114}}, lineColor = {0, 0, 0}, textString = "n")}), Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>The <b>HTWallSel_activeLayer</b> model represents a wall, consisting of n different layers, with selectable components for heat transfer(radiation,&nbsp;convection)and an active layer </p>
<p><b><span style=\"color: #008000;\">Level of Development</span></b> </p>
<p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars: 3 out of 5\"/> </p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>The model is an evolution of the <b>ConvNLayerClearanceStar</b> model, aimed at working better with the low order models, and as such the radiation and convection models at the outside can be switched on or off. </p>
<p>The introduction of a an active wall is possible via HeatPort connectors</p>
<p><b><span style=\"color: #ff0000;\">Attention:</span></b> The first element in each vector represents the layer connected to <code>HeatPort_a</code>, the last element represents the layer connected to <code>HeatPort_b</code>. </p>
<p><b><span style=\"color: #008000;\">Example Results</span></b> </p>
<p>This model is part of <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a> therefore also part of the corresponding examples <a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">InsideWall</a> and <a href=\"AixLib.Building.Components.Examples.Walls.OutsideWall\">OutsideWall</a>. </p>
</html>",  revisions="<html>
<ul>
<li><i>August 7, 2016&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"));
end HTWallSel_activeLayer;
