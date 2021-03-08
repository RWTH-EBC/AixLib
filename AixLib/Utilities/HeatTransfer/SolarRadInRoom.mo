within AixLib.Utilities.HeatTransfer;
model SolarRadInRoom
  "Model to distribute short wave radiation transmitted through a window to all areas in the room using shape factors"

  parameter Boolean method = true "Dynamic for holistic approach, static to obtain the same values as provided in tables of the ASHREA" annotation(Dialog(group = "Methods", compact = true, descriptionLabel = false), choices(choice = true "Dynamic", choice = false "Static", radioButtons = true));

  parameter Integer nWin=1
    "Number of windows in room transmitting shortwave radiation"                           annotation(Dialog(group="Static Calculation", connectorSizing=method, enable=not method));
  parameter Integer nWalls=4 "Number of walls in room - For static calculation, the only option is nWalls=4! The order is: East, South, West, North" annotation(Dialog(group="Static Calculation", connectorSizing=method, enable=not method));
  parameter Integer nFloors=1 "Number of floors in room" annotation(Dialog(group="Static Calculation", connectorSizing=method, enable=not method));
  parameter Integer nCei=1 "Number of ceilings in room" annotation(Dialog(group="Static Calculation", connectorSizing=method, enable=not method));
  parameter Modelica.SIunits.Length floor_length=0 "Total length of floors. Multiple floors are modelled as one area. For this equivelant area, you have to specify the length and height of the total floor" annotation(Dialog(group="Dynamic Calculation", enable=nFloors>1 and method));
  parameter Modelica.SIunits.Height floor_height=0 "Total height of floors. Multiple floors are modelled as one area. For this equivelant area, you have to specify the length and height of the total floor"  annotation(Dialog(group="Dynamic Calculation", enable=nFloors>1 and method));

  replaceable parameter
    ThermalZones.HighOrder.Components.Types.PartialCoeffTable staticCoeffTable
    constrainedby AixLib.ThermalZones.HighOrder.Components.Types.PartialCoeffTable
    "Record holding the values to reproduce the tables"
    annotation (Dialog(group="Static Calculation", enable=not method), choicesAllMatching=true,
    Placement(transformation(extent={{-10,78},{10,98}})));

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
  Interfaces.ShortRadSurf win_out[nWin] "Output to the ceiling(s)"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
        iconTransformation(extent={{100,-70},{120,-50}})));

  Real solar_frac_win_abs[nWin]=if method then fill(solar_frac_win_abs_int/nWin, nWin) else fill(staticCoeffTable.coeffWinAbs/nWin, nWin)
    "Solar fractions for windows, absorbed";
  Real solar_frac_win_lost[nWin]=if method then fill(solar_frac_win_lost_int/nWin, nWin) else fill(staticCoeffTable.coeffWinLost/nWin, nWin)
    "Solar fractions for windows, lost cause of transmitvity";
  Real solar_frac_cei[nCei] = if method then bounce_1_cei .+ bounce_2_floor_cei .+ bounce_3_rem_cei .+ bounce_R_rem_cei else fill(staticCoeffTable.coeffCeiling/nCei, nCei) "Solar fractions for ceilings";
  Real solar_frac_flo[nFloors] = if method then fill(solar_frac_flo_int/nFloors, nFloors) else fill(staticCoeffTable.coeffFloor/nFloors, nFloors) "Solar fractions for floors";
  Real solar_frac_wall[nWalls] = if method then bounce_1_wall .+ bounce_2_floor_wall .+ bounce_3_rem_wall .+ bounce_R_rem_wall else {staticCoeffTable.coeffOWEast,staticCoeffTable.coeffOWSouth, staticCoeffTable.coeffOWWest, staticCoeffTable.coeffOWNorth} "Solar fractions for walls";

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
      1 + X*X)/(1 + Y*Y + X*X))^0.5 + X*(1 + Y*Y)^0.5*Modelica.Math.atan(X/(1 +
      Y*Y)^0.5) + Y*(1 + X*X)^0.5*Modelica.Math.atan(Y/(1 + X*X)^0.5) - X*
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
      1 + Z*Z)/(1 + Y*Y + Z*Z)*((Y*Y*((1 + Y*Y + Z*Z))/((1 + Y*Y)*(Y*Y + Z*Z)))^(
      Y^2))*((Z*Z*((1 + Y*Y + Z*Z))/((1 + Y*Y)*(Y*Y + Z*Z)))^(Z^2))));
  end sight_fac_orthogonal;

  Modelica.SIunits.Length floor_length_int = if nFloors>1 then floor_length else floors[1].length "Total length of floors";
  Modelica.SIunits.Height floor_height_int = if nFloors>1 then floor_height else floors[1].height "Total height of floors";

  // Floors and windows have a special rule. As ASHRAE assumes one window and one floor,
  // possible different material properties have to be averaged in order for the approach to work.
  // Internal values for windows and floors:
  Real solar_frac_win_abs_int = bounce_1_win_abs + bounce_2_floor_win_abs + bounce_3_rem_win_abs + bounce_R_rem_win_abs "Solar fractions for windows";
  Real solar_frac_win_lost_int = bounce_1_win_lost + bounce_2_floor_win_lost + bounce_3_rem_win_lost + bounce_R_rem_win_lost "Solar fractions for windows";
  Real solar_frac_flo_int = bounce_1_floor + bounce_2_floor_floor + bounce_3_rem_floor + bounce_R_rem_floor "Solar fractions for floors";
  Real alpha_flo_int=sum(floors.solar_absorptance)/nFloors;
  Real alpha_win_int=sum(win_in.solar_absorptance)/nWin;
  Real rho_win_int=sum(win_in.solar_reflectance)/nWin;
  Modelica.SIunits.Area A_floor=sum(floors.length .* floors.height);
  Modelica.SIunits.Area A_win=sum(win_in.length .* win_in.height);
  Modelica.SIunits.Area A_walls[nWalls]=walls.length .* walls.height;
  Modelica.SIunits.Area A_ceil[nCei]=ceilings.length .* ceilings.height;
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
  Real bounce_2_floor_cei[nCei]=(1 - alpha_flo_int) .* sight_fac_floor_cei .*
      ceilings.solar_absorptance;
  Real bounce_2_floor_wall[nWalls]=(1 - alpha_flo_int) .* sight_fac_floor_wall .*
      walls.solar_absorptance;
  Real bounce_2_floor_win_lost = (1-alpha_flo_int) * sight_fac_floor_win * (1-(rho_win_int + alpha_win_int/2));
  Real bounce_2_floor_win_abs = (1-alpha_flo_int) * sight_fac_floor_win * alpha_win_int/2;
  Real sum_bounce_2 = sum(bounce_2_floor_cei) + sum(bounce_2_floor_wall) + bounce_2_floor_win_lost + bounce_2_floor_win_abs;

  // Define third bounce values. Info: rem means remaining, non absorbed heat:
  Real bounce_3_rem_cei[nCei]=(1 - sum_bounce_1 - sum_bounce_2) .* A_ceil .*
      ceilings.solar_absorptance/area_total;
  Real bounce_3_rem_wall[nWalls]=(1 - sum_bounce_1 - sum_bounce_2) .* A_walls .*
      walls.solar_absorptance/area_total;
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
  // Assumption: All walls have the same heigh + ceiling and floor have the same area.
  // Equally split the sight factor onto possible multiple ceilings
  Real sight_fac_floor_cei[nCei]=fill(sight_fac_parallel(
      x=floor_length_int,
      y=floor_height_int,
      D=walls[1].height)/nCei, nCei);

  Real sight_fac_floor_win = A_win / (A_win + sum(A_walls)) * (1 - sum(sight_fac_floor_cei));
  Real sight_fac_floor_wall[nWalls] = A_walls / (A_win + sum(A_walls)) * (1 - sum(sight_fac_floor_cei));

  // Define connectors:
  Real Q_flow_in=sum(win_in.Q_flow_ShoRadFroSur)
    "Sum of all windows directly goes to floor";
  Modelica.Blocks.Sources.RealExpression QRadWalls_out[nWalls](y={Q_flow_in * solar_frac_wall[n] for n in 1:nWalls});
  Modelica.Blocks.Sources.RealExpression QRadCei_out[nCei](y={Q_flow_in * solar_frac_cei[n] for n in 1:nCei});
  Modelica.Blocks.Sources.RealExpression QRadFloors_out[nFloors](y={Q_flow_in * solar_frac_flo[n] for n in 1:nFloors});
  Modelica.Blocks.Sources.RealExpression QRadWin_out[nWin](y={Q_flow_in*
        solar_frac_win_abs[n] for n in 1:nWin});

initial equation
  // Asssert energy balance matches
  assert(abs(sum(cat(1, solar_frac_cei, solar_frac_flo, solar_frac_wall, solar_frac_win_lost, solar_frac_win_abs)) - 1) < Modelica.Constants.eps, "Sum of solar fractions is not equal to 1", AssertionLevel.error);
  // Assert all walls have the same height:
  assert(((sum(walls.height) / size(walls, 1)) - walls[1].height) <  Modelica.Constants.eps, "Not all walls have the same height", AssertionLevel.error);
  assert(sum(A_ceil) - A_floor < Modelica.Constants.eps, "Ceiling and floor have mismatching areas", AssertionLevel.error);
  // Check correct user input if multiple floors are selected
  assert(A_floor - floor_height_int*floor_length_int < Modelica.Constants.eps, "Total floor area mismatches area specified by user", AssertionLevel.error);
  // Check number of walls for static method
  if not method then
    assert(nWalls==4, "For static calcuation, the number of floor needs to be equal to 4.", AssertionLevel.error);
  end if;
equation

  for n in 1:nWalls loop
    connect(walls[n].Q_flow_ShoRadOnSur, QRadWalls_out[n].y);
  end for;

  for n in 1:nWin loop
    connect(win_out[n].Q_flow_ShoRadOnSur, QRadWin_out[n].y);
  end for;

  for n in 1:nCei loop
    connect(ceilings[n].Q_flow_ShoRadOnSur, QRadCei_out[n].y);
  end for;

  for n in 1:nFloors loop
    connect(floors[n].Q_flow_ShoRadOnSur, QRadFloors_out[n].y);
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
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model distributes the incoming short wave radtion onto different
  areas of the room according to the approach in the ASHREA Standard,
  Annex B7 \"Detailed calculation of solar fractions\". The ASHREA makes
  some assumptions to estimate the sight factors of each element. For
  more details on the assumptions, we refer to the ASHREA standard. In
  order to ease the usage of this model, we made additional
  assumptions.
</p>
<h4>
  Assumptions by ASHREA
</h4>
<ul>
  <li>First bounce: All shortwave radiation initially hits the floor
  </li>
  <li>Second bounce: Not absorbed radiation is diffusivly reflected by
  floor and distributed over all surfaces according to the view factors
  of each surface
  </li>
  <li>Third bounce: Remaining radiation is distributed over each
  surface in proportion to it's area-absorptance product
  </li>
  <li>Remaining bounces: Based on calculations from third bounce
  </li>
</ul>
<h4>
  Additional Assumptions
</h4>
<p>
  In order to ease the usage of this model, we added the following
  assumptions. You can read more about the reasons of these assumptions
  in the corresponding <a href=
  \"https://github.com/RWTH-EBC/AixLib/issues/918\">issue 918</a>.
</p>
<ul>
  <li>In constrast to the ASHREA, we allow for different solar
  absorptance factors
  </li>
  <li>All floors act as one joined area. However, the heat flows are
  seperated based on areas etc. at the end according to ASHRAE
  </li>
  <li>All walls have the same heigh + ceiling and floor have (joined
  together) the same area. This is necessary in order to use the
  approximations of sight factors from the standard. This is checked
  via asserts
  </li>
  <li>We only calculate one view/sight factor, and that is from floor
  to ceiling. This assumes floor and ceiling are two parallel areas
  with the same total area
  </li>
  <li>All remaining radiation of the second bounce is distributed
  proportional to the areas of the surfaces:<br/>
    sight_factor_floor_win = A_win / (A_win + A_walls) * (1 -
    sight_factor_floor_ceil)<br/>
    sight_factor_floor_walls = A_walls / (A_win + A_walls) * (1 -
    sight_factor_floor_ceil)<br/>
    sight_factor_floor_wall_i = A_wall_i / A_walls *
    sight_factor_floor_walls<br/>
    sight_factor_floor_win_i = A_win_i / A_win *
    sight_factor_floor_walls
  </li>
</ul>
<p>
  <br/>
  Note that the last assumption would be valid for a quadratic room
  with no windows. Only for extremly long rooms this assumptions could
  be dangerous. However, a floor typically reflects only 10
  &amp;percnt; of the incoming radiation. Approx. 50 &amp;percnt; of
  that go to the ceiling, the rest to the walls. Therefor, effects like
  correct window placement etc. on the temperatures of the walls will
  be of a small magnitude.
</p>
<h4>
  Parameterization
</h4>
<p>
  You have to connect the bus connector <a href=
  \"AixLib.Utilities.Interfaces.ShortRadSurf\">ShortRadSurf</a> of each
  surface (floor, wall, ceiling) of type <a href=
  \"AixLib.ThermalZones.HighOrder.Components.Walls.Wall\">wall</a> to the
  corresponding port. As the current implementation of type <a href=
  \"AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140\">
  window</a> only supports one directional short wave radiation, the
  port win_out may be ignored. However, you can check how much
  radiation is lost to the ambient.
</p>
<p>
  If you model a room with multiple floor elements, you have to specify
  the parameters floor_length and floor_height. These scales are
  required to calculate the view factors in the second bounce.
</p>
<h4>
  Known Limitations
</h4>
<ul>
  <li>Although we implemented the exact same equations as in the ASHREA
  (besides out approach for the third bounce), the results of the model
  do NOT match the results provided in the tables of the Appendix in
  the ASHREA. This is due to the high fiew factor from floor to ceiling
  in the second bounce. We could not quantify how the results in the
  Appendix are obtained, as their solar fraction for the ceiling is too
  low. In order to use the ASHREA values from the tables instead of the
  dynamic calculation, you may use the option table_based_calc.
  </li>
  <li>In the ASHREA, all surfaces shall have the same absorbtance. Our
  modelling approach enable differing values.
  </li>
  <li>This model works best for nearly quadratic rooms
  </li>
  <li>Windows in the floors or ceilings are not regarded
  </li>
</ul>
<h4>
  Sources
</h4>
<ul>
  <li>ANSI/ASHREA Standard 140-2017
  </li>
  <li>Principles of Heat Transfer - Chapter 9.4 <a href=
  \"http://160592857366.free.fr/joe/ebooks/Mechanical%20Engineering%20Books%20Collection/HEAT%20TRANSFER/Ptinciples%20of%20Heat%20Transfer.pdf\">
    [Link]</a>
  </li>
</ul>
</html>", revisions="<html>
<ul>
  <li>
    <i>June, 18, 2020</i> by Fabian Wuellhorst:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/918\">#918</a>:
    Implemented.
  </li>
</ul>
</html>"));
end SolarRadInRoom;
