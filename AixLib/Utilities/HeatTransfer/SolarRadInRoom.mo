within AixLib.Utilities.HeatTransfer;
model SolarRadInRoom
  "Model to distribute short wave radiation transmitted through a window to all areas in the room using shape factors"

  parameter Integer nWin "Number of windows in room";
  parameter Integer nWalls=4 "Number of walls in room";
  parameter Integer nFloors=1 "Number of floors in room";
  parameter Integer nCei=1 "Number of ceilings in room";

  Interfaces.ShortRad_in win_in[nWin] "Windows input" annotation (Placement(
        transformation(extent={{-120,-10},{-100,10}}), iconTransformation(
          extent={{-120,-10},{-100,10}})));
  Interfaces.ShortRad_out wall_out[nWalls] = Q_flow_in * solar_frac_wall "Output to the walls" annotation (
      Placement(transformation(extent={{100,50},{120,70}}), iconTransformation(
          extent={{100,50},{120,70}})));
  Interfaces.ShortRad_out floor_out[nFloors] = Q_flow_in * solar_frac_flo "Output to the floor(s)" annotation (
      Placement(transformation(extent={{100,10},{120,30}}), iconTransformation(
          extent={{100,10},{120,30}})));
  Interfaces.ShortRad_out ceiling_out[nCei] = Q_flow_in * solar_frac_cei "Output to the ceiling(s)" annotation (
      Placement(transformation(extent={{100,-30},{120,-10}}),
                                                            iconTransformation(
          extent={{100,-30},{120,-10}})));
  Interfaces.ShortRad_out win_out[nWin] = Q_flow_in * solar_frac_win "Output to the ceiling(s)" annotation (
     Placement(transformation(extent={{100,-70},{120,-50}}),
                                                           iconTransformation(
          extent={{100,-70},{120,-50}})));

protected
  Real Q_flow_in = sum(win_in) "Sum of all windows directly goes to floor";
  parameter Real solar_frac_win_abs[nWin] "Solar fractions for windows";
  parameter Real solar_frac_win_lost[nWin] "Solar fractions for windows";
  parameter Real solar_frac_cei[nCei] "Solar fractions for ceilings";
  parameter Real solar_frac_flo[nFloors] "Solar fractions for floors";
  parameter Real solar_frac_wall[nWalls] "Solar fractions for walls";

  // Floors and windows have a special rule. As ASHRAE assumes one window and one floor,
  // possible different material properties have to be averaged in order for the approach to work.
  // Internal values for windows and floors:
  parameter Real solar_frac_win_abs_int "Solar fractions for windows";
  parameter Real solar_frac_win_lost_int "Solar fractions for windows";
  parameter Real solar_frac_flo_int "Solar fractions for floors";
  parameter Real alpha_flo_int = 0;
  parameter Modelica.SIunits.Area A_floor = sum(floors.A);
  parameter Modelica.SIunits.Area area_total = 0 "Total area of all surfaces, used for bounce";

  // Define bounce values:
  parameter Real bounce_1_win_abs = 0;
  parameter Real bounce_1_win_lost = 0;
  parameter Real bounce_1_cei[nCei] = fill(0, nCei);
  parameter Real bounce_1_floor = alpha_flo_int;
  parameter Real bounce_1_wall[nWalls] = fill(0, nWalls);
  parameter Real sum_bounce_1 = alpha_flo_int "Just used to make the concept of bounce 3 more clear";
  // solar_frac_n = bounce_1_n + bounce_2_n + bounce_3_n + bounce_4_n;
  // solar_frac_n = bounce_1_n + bounce_2_n + bounce_3_n + bounce_4_n;
  // solar_frac_n = bounce_1_n + bounce_2_n + bounce_3_n + bounce_4_n;
  // solar_frac_n = bounce_1_n + bounce_2_n + bounce_3_n + bounce_4_n;

  parameter Real bounce_2_floor_floor = 0;
  parameter Real bounce_2_floor_cei = (1-floor.eps) .* sight_fac_floor_cei .* cei.eps;
  parameter Real bounce_2_floor_wall = (1-floor.eps) .* sight_fac_floor_wall .* wall.eps;
  parameter Real bounce_2_floor_win_lost = (1-floor.eps) * sight_fac_floor_win * (1-(win.rho + win.alpha/2));
  parameter Real bounce_2_floor_win_abs = (1-floor.eps) * sight_fac_floor_win * win.alpha/2;

  parameter Real sum_bounce_2 = sum(bounce_2_floor_cei) + sum(bounce_2_floor_wall) + bounce_2_floor_win_lost + bounce_2_floor_win_abs;
  parameter Real bounce_3_rest_cei = (1 - sum_bounce_1 - sum_bounce_2) .*cei.A .* cei.eps / area_total;
  parameter Real bounce_3_rest_wall = (1 - sum_bounce_1 - sum_bounce_2) .*wall.A .* wall.eps / area_total;
  parameter Real bounce_3_rest_floor = (1 - sum_bounce_1 - sum_bounce_2) *  A_floor / area_total * alpha_flo_int;

initial equation
  // TODO: Build correct sum and test assert for numerical stability.
  assert(sum(cat(1, solar_frac_cei, solar_frac_flo, solar_frac_wall, solar_frac_win))==1, "Sum of solar fractions is not equal to 1", AssertionLevel.error);



  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,96},{96,-18}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{96,-18},{54,-86},{-94,-86},{-44,-18},{96,-18}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-44,96},{-44,-18},{-94,-86},{-94,44},{-44,96}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-54,46},{-54,-8},{-78,-36},{-78,22},{-54,46}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-62,4},{-12,-48}},
          color={255,255,0},
          thickness=1),
        Line(
          points={{-12,-48},{32,30}},
          color={255,255,0},
          thickness=0.5),
        Line(
          points={{-10,-48},{82,-10}},
          color={255,255,0},
          thickness=0.5),
        Line(
          points={{-12,70},{-12,-48}},
          color={255,255,0},
          thickness=0.5),
        Polygon(points={{96,96},{96,-18},{54,-86},{54,44},{96,96}}, lineColor={0,
              0,0}),
        Line(points={{-94,44},{54,44},{54,44}}, color={0,0,0}),
        Line(
          points={{-12,-48},{-22,-60}},
          color={255,255,0},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end SolarRadInRoom;
