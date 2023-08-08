within AixLib.ThermalZones.HighOrder.Components.Shadow;
model ShadowEff "Shadow effect of shield"
  parameter Integer Mode = 1
    "Diffuse radiation calculation mode,
    1=Constant reduce factor for diffuse radiation (infinite length of shield),
    2=Constant reduce factor for diffuse radiation (on perpendicular direction),
    3=Constant reduce factor for diffuse radiation (on perpendicular direction without integration),
    else=Use same reduce factor g_Shadow as direct radiation (no diffuse radiation when no shadow effect)";
  parameter Modelica.Units.SI.Length L_Shield = 0.3 "Horizontal length of the sun shield";
  parameter Modelica.Units.SI.Length H_Window_min = 0.1 "Distance from shield to upper border of window";
  parameter Modelica.Units.SI.Length H_Window_max = 1.1 "Distance from shield to lower border of window";
  parameter Modelica.Units.NonSI.Angle_deg azi_deg = -54 "Surface azimuth, S=0°, W=90°, N=180°, E=-90°";
  parameter Real C_I_diff(min=0,max=1) = 1 "Reduce factor of shadow effect for I_diff: 0=fully reduced, 1=no addtional reduce";

  BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}}),
        iconTransformation(extent={{-120,60},{-80,100}})));
  Utilities.Interfaces.SolarRad_in solarRad_in
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Utilities.Interfaces.SolarRad_out solarRad_out
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  ShadowLength shadowLength(azi_deg=azi_deg, L_Shield=L_Shield)
    annotation (Placement(transformation(extent={{-40,-20},{0,20}})));

protected
  Modelica.Units.SI.TransmissionCoefficient g_Shadow(min=0.0,max=1.0) "Shadow coefficient: 0=full shadowed, 1=no shadow";
  Real g_I_diff "Shadow coefficient for diffuse radiation: 0=full shadowed, 1=no shadow";
  Real sum, beta, s, H, L, g_I_diff_mean "Parameters for integration";
  Modelica.Units.SI.Angle beta_upper = Modelica.Constants.pi / 2 "Assumption: max. 90° with diffuse radiation";

algorithm
  // Calculate the mean shadow factor regarding 90° range from perpenticular direction
  sum := 0;
  for i in 1:100 loop
    H := (H_Window_max + H_Window_min)/2;
    L := L_Shield;
    s := Modelica.Constants.pi / 2 / 100; // Differential of 90° for integration
    beta := beta_upper / 100 * i; // Angle to the perpendicular direction
    sum := sum + (2/Modelica.Constants.pi) * Modelica.Math.atan(H/L * (if Mode == 1 then Modelica.Math.cos(beta) else 1)) * s;
  end for;
  g_I_diff_mean := sum / (Modelica.Constants.pi / 2);

equation
  if shadowLength.With_Shadow then
    g_Shadow = min(max((H_Window_max-shadowLength.H_Shadow)/(H_Window_max-H_Window_min), 0), 1);
  else
    g_Shadow = 0;
  end if;
  solarRad_out.I = solarRad_out.I_dir + solarRad_out.I_diff;
  solarRad_out.I_dir = solarRad_in.I_dir*g_Shadow;
  if Mode == 1 or Mode == 2 then
    g_I_diff = g_I_diff_mean;
    solarRad_out.I_diff = solarRad_in.I_diff*g_I_diff*C_I_diff;
  elseif Mode == 3 then
    g_I_diff = atan((H_Window_max+H_Window_min)/2 / L_Shield)/(Modelica.Constants.pi/2);
    solarRad_out.I_diff = solarRad_in.I_diff*g_I_diff*C_I_diff;
  else
    g_I_diff = 0;
    solarRad_out.I_diff = solarRad_in.I_diff*g_Shadow*C_I_diff;
  end if;
  solarRad_out.I_gr = solarRad_in.I_gr;
  solarRad_out.AOI = solarRad_in.AOI;

  connect(shadowLength.weaBus, weaBus) annotation (Line(
      points={{-40,0},{-74,0},{-74,80},{-100,80}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{40,40},{48,-80}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,40},{48,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,88},{100,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,-80},{48,-92}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,98},{40,10}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(
          extent={{40,-92},{100,-100}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,8},{40,-80}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-60,54},{40,-34}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled})}),                    Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ShadowEff;
