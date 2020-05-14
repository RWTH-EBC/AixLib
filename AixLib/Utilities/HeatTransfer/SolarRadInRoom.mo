within AixLib.Utilities.HeatTransfer;
model SolarRadInRoom
  "Model to distribute short wave radiation transmitted through a window to all areas in the room using shape factors"

  parameter Integer nWin=1 "Number of windows in room";
  parameter Integer nWalls=1 "Number of walls in room";
  parameter Integer nFloors=1 "Number of floors in room";
  parameter Integer nCei=1 "Number of ceilings in room";

  Interfaces.ShortRad_in win_in[nWin] "Windows input" annotation (Placement(
        transformation(extent={{-120,-10},{-100,10}}), iconTransformation(
          extent={{-120,-10},{-100,10}})));
  Interfaces.ShortRad_out walls[nWalls] "Output to the walls" annotation (
      Placement(transformation(extent={{100,50},{120,70}}), iconTransformation(
          extent={{100,50},{120,70}})));
  Interfaces.ShortRad_out floors[nFloors] "Output to the floor(s)" annotation (
      Placement(transformation(extent={{100,10},{120,30}}), iconTransformation(
          extent={{100,10},{120,30}})));
  Interfaces.ShortRad_out ceilings[nCei] "Output to the ceiling(s)" annotation (
      Placement(transformation(extent={{100,-30},{120,-10}}),
                                                            iconTransformation(
          extent={{100,-30},{120,-10}})));
  Interfaces.ShortRad_out win_out[nWin] "Output to the ceiling(s)" annotation (
     Placement(transformation(extent={{100,-70},{120,-50}}),
                                                           iconTransformation(
          extent={{100,-70},{120,-50}})));

protected
  Real Q_flow_in = sum(win_in.Q_flow_rad) "Sum of all windows directly goes to floor";
  parameter Real solar_frac_win_abs[nWin] = fill(solar_frac_win_abs_int/nWin, nWin) "Solar fractions for windows, absorbed";
  parameter Real solar_frac_win_lost[nWin] = fill(solar_frac_win_lost_int/nWin, nWin) "Solar fractions for windows, lost cause of transmitvity";
  parameter Real solar_frac_cei[nCei] = bounce_1_cei .+ bounce_2_floor_cei .+ bounce_3_rem_cei .+ bounce_R_rem_cei "Solar fractions for ceilings";
  parameter Real solar_frac_flo[nFloors] = fill(solar_frac_flo_int/nFloors, nFloors) "Solar fractions for floors";
  parameter Real solar_frac_wall[nWalls] = bounce_1_wall .+ bounce_2_floor_wall .+ bounce_3_rem_wall .+ bounce_R_rem_wall
                                                                                                                         "Solar fractions for walls";

  // Floors and windows have a special rule. As ASHRAE assumes one window and one floor,
  // possible different material properties have to be averaged in order for the approach to work.
  // Internal values for windows and floors:
  parameter Real solar_frac_win_abs_int = bounce_1_win_abs + bounce_2_floor_win_abs + bounce_3_rem_win_abs + bounce_R_rem_win_abs "Solar fractions for windows";
  parameter Real solar_frac_win_lost_int = bounce_1_win_lost + bounce_2_floor_win_lost + bounce_3_rem_win_lost + bounce_R_rem_win_lost "Solar fractions for windows";
  parameter Real solar_frac_flo_int = bounce_1_floor + bounce_2_floor_floor + bounce_3_rem_floor + bounce_R_rem_floor "Solar fractions for floors";
  parameter Real alpha_flo_int = sum(floors.eps) / nFloors;
  parameter Real alpha_win_int = sum(win_in.alpha) / nWin;
  parameter Real rho_win_int = sum(win_in.rho) / nWin;
  parameter Modelica.SIunits.Area A_floor = sum(floors.A);
  parameter Modelica.SIunits.Area A_win = sum(win_in.A);
  parameter Modelica.SIunits.Area area_total = sum(floors.A) + sum(ceilings.A) + sum(walls.A) + sum(win_in.A) "Total area of all surfaces, used for bounce";

  // Define first bounce values:
  parameter Real bounce_1_win_abs = 0;
  parameter Real bounce_1_win_lost = 0;
  parameter Real bounce_1_cei[nCei] = fill(0, nCei);
  parameter Real bounce_1_floor = alpha_flo_int;
  parameter Real bounce_1_wall[nWalls] = fill(0, nWalls);
  parameter Real sum_bounce_1 = alpha_flo_int "Just used to make the concept of bounce 3 more clear";

  // Define second bounce values:
  parameter Real bounce_2_floor_floor = 0;
  parameter Real bounce_2_floor_cei[nCei] = (1-alpha_flo_int) .* sight_fac_floor_cei .* ceilings.eps;
  parameter Real bounce_2_floor_wall[nWalls] = (1-alpha_flo_int) .* sight_fac_floor_wall .* walls.eps;
  parameter Real bounce_2_floor_win_lost = (1-alpha_flo_int) * sight_fac_floor_win * (1-(rho_win_int + alpha_win_int/2));
  parameter Real bounce_2_floor_win_abs = (1-alpha_flo_int) * sight_fac_floor_win * alpha_win_int/2;
  parameter Real sum_bounce_2 = sum(bounce_2_floor_cei) + sum(bounce_2_floor_wall) + bounce_2_floor_win_lost + bounce_2_floor_win_abs;

  // Define third bounce values. Info: rem means remaining, non absorbed heat:
  parameter Real bounce_3_rem_cei[nCei] = (1 - sum_bounce_1 - sum_bounce_2) .* ceilings.A .* ceilings.eps / area_total;
  parameter Real bounce_3_rem_wall[nWalls] = (1 - sum_bounce_1 - sum_bounce_2) .* walls.A .* walls.eps / area_total;
  parameter Real bounce_3_rem_floor = (1 - sum_bounce_1 - sum_bounce_2) *  A_floor / area_total * alpha_flo_int;
  parameter Real bounce_3_rem_win_lost = (1 - sum_bounce_1 - sum_bounce_2) *  A_win / area_total * (1-(rho_win_int + alpha_win_int/2));
  parameter Real bounce_3_rem_win_abs = (1 - sum_bounce_1 - sum_bounce_2) *  A_win / area_total * alpha_win_int;
  parameter Real sum_bounce_3 = sum(bounce_3_rem_cei) + sum(bounce_3_rem_wall) + bounce_3_rem_floor + bounce_3_rem_win_abs + bounce_3_rem_win_lost;

  // Define fourth/last or 'Remaining for R' bounce values:
  parameter Real bounce_R_rem_cei[nCei] = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_cei / sum_bounce_3);
  parameter Real bounce_R_rem_wall[nWalls] = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_wall / sum_bounce_3);
  parameter Real bounce_R_rem_floor = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_floor / sum_bounce_3);
  parameter Real bounce_R_rem_win_lost = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_win_lost / sum_bounce_3);
  parameter Real bounce_R_rem_win_abs = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_win_abs / sum_bounce_3);

  // Define sight factors used in bounce 2:
  parameter Real sight_fac_floor_cei = 0;
  parameter Real sight_fac_floor_wall = 0;
  parameter Real sight_fac_floor_win = 0;
initial equation
  // TODO: Build correct sum and test assert for numerical stability.
  assert(sum(cat(1, solar_frac_cei, solar_frac_flo, solar_frac_wall, solar_frac_win_lost, solar_frac_win_abs))==1, "Sum of solar fractions is not equal to 1", AssertionLevel.error);
equation
  for n in 1:nWalls loop
    walls[n].Q_flow_rad = Q_flow_in * solar_frac_wall[n];
  end for;

  for n in 1:nWin loop
    win_out[n].Q_flow_rad = Q_flow_in * solar_frac_win_abs[n];
  end for;

  for n in 1:nCei loop
    ceilings[n].Q_flow_rad = Q_flow_in * solar_frac_cei[n];
  end for;

  for n in 1:nFloors loop
    floors[n].Q_flow_rad = Q_flow_in * solar_frac_flo[n];
  end for;


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
