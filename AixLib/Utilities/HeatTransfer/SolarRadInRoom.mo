within AixLib.Utilities.HeatTransfer;
model SolarRadInRoom
  "Model to distribute short wave radiation transmitted through a window to all areas in the room using shape factors"

  parameter Integer nWin=1 "Number of windows in room";
  parameter Integer nWalls=1 "Number of walls in room";
  parameter Integer nFloors=1 "Number of floors in room";
  parameter Integer nCei=1 "Number of ceilings in room";

  Interfaces.ShortRadSurf win_in[nWin] "Windows input" annotation (Placement(
        transformation(extent={{-120,-10},{-100,10}}), iconTransformation(
          extent={{-120,-10},{-100,10}})));
  Interfaces.ShortRadSurf walls[nWalls] "Output to the walls" annotation (
      Placement(transformation(extent={{100,50},{120,70}}), iconTransformation(
          extent={{100,50},{120,70}})));
  Interfaces.ShortRadSurf floors[nFloors] "Output to the floor(s)" annotation (
      Placement(transformation(extent={{100,10},{120,30}}), iconTransformation(
          extent={{100,10},{120,30}})));
  Interfaces.ShortRadSurf ceilings[nCei] "Output to the ceiling(s)" annotation (
      Placement(transformation(extent={{100,-30},{120,-10}}),
                                                            iconTransformation(
          extent={{100,-30},{120,-10}})));
  Interfaces.ShortRadSurf win_out[nWin] "Output to the ceiling(s)" annotation (
     Placement(transformation(extent={{100,-70},{120,-50}}),
                                                           iconTransformation(
          extent={{100,-70},{120,-50}})));

protected
  function sight_fac_parallel "Calculate sight factor based on B7-2 in ASHRAE Appendix for parallel areas"
    input Real x "Length of floor / ceiling";
    input Real y "Depth of floor / ceiling";
    input Real D "Height of wall";
    output Real sight_factor;
  protected
    Real X = x / D;
    Real Y = y / D;
  algorithm
    sight_factor := 2 / (Modelica.Constants.pi * Y * X) *(Modelica.Math.log((1 + Y*Y)*(
      1 + X*X)/(1 + Y*Y + X*X))^0.5 + X*(1 + Y*Y)^0.5*Modelica.Math.atan(X/(1
       + Y*Y)^0.5) + Y*(1 + X*X)^0.5*Modelica.Math.atan(Y/(1 + X*X)^0.5) - X*
      Modelica.Math.atan(X) - Y*Modelica.Math.atan(Y));
  end sight_fac_parallel;

  function sight_fac_orthogonal "Calculate sight factor based on B7-1 in ASHRAE Appendix for orthogonal areas"
    input Real x "Length of floor / wall";
    input Real y "Depth of floor";
    input Real z "Height of wall";
    output Real sight_factor;
  protected
    Real Y = y / x;
    Real Z = y / x;
  algorithm
    sight_factor := 1 / (Modelica.Constants.pi * Y) *( Y * Modelica.Math.atan(1 / Y) + Z * Modelica.Math.atan(1 / Z) - (Z*Z + Y*Y)^0.5*
      Modelica.Math.atan(1/(Z*Z + Y*Y)^0.5) + 0.25*Modelica.Math.log((1 + Y*Y)*(
      1 + Z*Z)/(1 + Y*Y + Z*Z)*((Y*Y((1 + Y*Y + Z*Z))/((1 + Y*Y)*(Y*Y + Z*Z)))^(
      Y^2))*((Z*Z((1 + Y*Y + Z*Z))/((1 + Y*Y)*(Y*Y + Z*Z)))^(Z^2))));
  end sight_fac_orthogonal;

  Real solar_frac_win_abs[nWin] = fill(solar_frac_win_abs_int/nWin, nWin) "Solar fractions for windows, absorbed";
  Real solar_frac_win_lost[nWin] = fill(solar_frac_win_lost_int/nWin, nWin) "Solar fractions for windows, lost cause of transmitvity";
  Real solar_frac_cei[nCei] = bounce_1_cei .+ bounce_2_floor_cei .+ bounce_3_rem_cei .+ bounce_R_rem_cei "Solar fractions for ceilings";
  Real solar_frac_flo[nFloors] = fill(solar_frac_flo_int/nFloors, nFloors) "Solar fractions for floors";
  Real solar_frac_wall[nWalls] = bounce_1_wall .+ bounce_2_floor_wall .+ bounce_3_rem_wall .+ bounce_R_rem_wall          "Solar fractions for walls";

  // Floors and windows have a special rule. As ASHRAE assumes one window and one floor,
  // possible different material properties have to be averaged in order for the approach to work.
  // Internal values for windows and floors:
  Real solar_frac_win_abs_int = bounce_1_win_abs + bounce_2_floor_win_abs + bounce_3_rem_win_abs + bounce_R_rem_win_abs "Solar fractions for windows";
  Real solar_frac_win_lost_int = bounce_1_win_lost + bounce_2_floor_win_lost + bounce_3_rem_win_lost + bounce_R_rem_win_lost "Solar fractions for windows";
  Real solar_frac_flo_int = bounce_1_floor + bounce_2_floor_floor + bounce_3_rem_floor + bounce_R_rem_floor "Solar fractions for floors";
  Real alpha_flo_int = sum(floors.alpha) / nFloors;
  Real alpha_win_int = sum(win_in.alpha) / nWin;
  Real rho_win_int = sum(win_in.rho) / nWin;
  Modelica.SIunits.Area A_floor = sum(floors.L .* floors.H);
  Modelica.SIunits.Area A_win = sum(win_in.L .* win_in.H);
  Modelica.SIunits.Area A_walls[nWalls] = walls.L .* walls.H;
  Modelica.SIunits.Area A_ceil[nCei] = ceilings.L .* ceilings.H;
  Modelica.SIunits.Area area_total = A_floor + sum(A_ceil) + sum(A_walls) + A_win "Total area of all surfaces, used for bounce";

  // Define first bounce values:
  Real bounce_1_win_abs = 0;
  Real bounce_1_win_lost = 0;
  Real bounce_1_cei[nCei] = fill(0, nCei);
  Real bounce_1_floor = alpha_flo_int;
  Real bounce_1_wall[nWalls] = fill(0, nWalls);
  Real sum_bounce_1 = alpha_flo_int "Just used to make the concept of bounce 3 more clear";

  // Define second bounce values:
  Real bounce_2_floor_floor = 0;
  Real bounce_2_floor_cei[nCei] = (1-alpha_flo_int) .* sight_fac_floor_cei .* ceilings.eps;
  Real bounce_2_floor_wall[nWalls] = (1-alpha_flo_int) .* sight_fac_floor_wall .* walls.eps;
  Real bounce_2_floor_win_lost = (1-alpha_flo_int) * sight_fac_floor_win * (1-(rho_win_int + alpha_win_int/2));
  Real bounce_2_floor_win_abs = (1-alpha_flo_int) * sight_fac_floor_win * alpha_win_int/2;
  Real sum_bounce_2 = sum(bounce_2_floor_cei) + sum(bounce_2_floor_wall) + bounce_2_floor_win_lost + bounce_2_floor_win_abs;

  // Define third bounce values. Info: rem means remaining, non absorbed heat:
  Real bounce_3_rem_cei[nCei] = (1 - sum_bounce_1 - sum_bounce_2) .* A_ceil .* ceilings.eps / area_total;
  Real bounce_3_rem_wall[nWalls] = (1 - sum_bounce_1 - sum_bounce_2) .* A_walls .* walls.eps / area_total;
  Real bounce_3_rem_floor = (1 - sum_bounce_1 - sum_bounce_2) *  A_floor / area_total * alpha_flo_int;
  Real bounce_3_rem_win_lost = (1 - sum_bounce_1 - sum_bounce_2) *  A_win / area_total * (1-(rho_win_int + alpha_win_int/2));
  Real bounce_3_rem_win_abs = (1 - sum_bounce_1 - sum_bounce_2) *  A_win / area_total * alpha_win_int;
  Real sum_bounce_3 = sum(bounce_3_rem_cei) + sum(bounce_3_rem_wall) + bounce_3_rem_floor + bounce_3_rem_win_abs + bounce_3_rem_win_lost;

  // Define fourth/last or 'Remaining for R' bounce values:
  Real bounce_R_rem_cei[nCei] = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_cei / sum_bounce_3);
  Real bounce_R_rem_wall[nWalls] = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_wall / sum_bounce_3);
  Real bounce_R_rem_floor = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_floor / sum_bounce_3);
  Real bounce_R_rem_win_lost = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_win_lost / sum_bounce_3);
  Real bounce_R_rem_win_abs = (1 - sum_bounce_1 - sum_bounce_2 - sum_bounce_3) * (bounce_3_rem_win_abs / sum_bounce_3);

  // Define sight factors used in bounce 2:
  Real sight_fac_floor_cei = 0;
  Real sight_fac_floor_wall = 0;
  Real sight_fac_floor_win = 0;


  // Define connectors:
  Real Q_flow_in = sum(win_in.QRad_in) "Sum of all windows directly goes to floor";
  Modelica.Blocks.Sources.RealExpression QRadWalls_out[nWalls](y={Q_flow_in * solar_frac_wall[n] for n in 1:nWalls});
  Modelica.Blocks.Sources.RealExpression QRadCei_out[nCei](y={Q_flow_in * solar_frac_cei[n] for n in 1:nCei});
  Modelica.Blocks.Sources.RealExpression QRadFloors_out[nFloors](y={Q_flow_in * solar_frac_flo[n] for n in 1:nFloors});
  Modelica.Blocks.Sources.RealExpression QRadWin_out[nWin](y={Q_flow_in * solar_frac_win_abs[n] for n in 1:nWin});

initial equation
  // TODO: Build correct sum and test assert for numerical stability.
  assert(abs(sum(cat(1, solar_frac_cei, solar_frac_flo, solar_frac_wall, solar_frac_win_lost, solar_frac_win_abs)) - 1) < Modelica.Constants.eps, "Sum of solar fractions is not equal to 1", AssertionLevel.error);
equation

  for n in 1:nWalls loop
    connect(walls[n].QRad_out, QRadWalls_out[n].y);
  end for;

  for n in 1:nWin loop
    connect(win_out[n].QRad_out, QRadWin_out[n].y);
  end for;

  for n in 1:nCei loop
    connect(ceilings[n].QRad_out, QRadCei_out[n].y);
  end for;

  for n in 1:nFloors loop
   connect(floors[n].QRad_out, QRadFloors_out[n].y);
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
