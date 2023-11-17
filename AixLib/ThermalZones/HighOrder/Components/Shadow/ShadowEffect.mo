within AixLib.ThermalZones.HighOrder.Components.Shadow;
model ShadowEffect
  "Shadow effect of horizotal shield, reducing the solar radiation through the window"
  parameter AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode calMod
    "Diffuse radiation calculation mode: {constRedDiffAllDir, constRedDiffPerpDir, varRedDiffAsDirRad}";
  parameter Modelica.Units.SI.Length lenShie = 0.3
    "Horizontal length of the sun shield";
  parameter Modelica.Units.SI.Length heiWinMin = 0.1
    "Distance from shield to upper border of window";
  parameter Modelica.Units.SI.Length heiWinMax = 1.1
    "Distance from shield to lower border of window";
  parameter Modelica.Units.NonSI.Angle_deg aziDeg = -54
    "Surface azimuth, S=0°, W=90°, N=180°, E=-90°";
  parameter Real redFacDifRad(min=0,max=1) = 1
    "Reduce factor of shadow effect for diffuse radiation: 0=fully reduced, 1=no addtional reduce";

  BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}}),
        iconTransformation(extent={{-120,60},{-80,100}})));
  Utilities.Interfaces.SolarRad_in solRadIn
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Utilities.Interfaces.SolarRad_out solRadOut
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  ShadowLength shaLen
    annotation (Placement(transformation(extent={{-40,-20},{0,20}})));

  Modelica.Units.SI.TransmissionCoefficient gShaDir(min=0,max=1)
    "Shadow coefficient for direct radiation: 0=full shadowed, 1=no shadow";
protected
  Real gShaDif "Shadow coefficient for diffuse radiation: 0=full shadowed, 1=no shadow";
  Real sum, beta, s, H, L, gShaDif_mean "Parameters for integration";

algorithm
  // Calculate the mean shadow factor regarding 90° range from perpenticular direction
  sum := 0;
  for i in 1:100 loop
    H := (heiWinMax + heiWinMin)/2;
    L := lenShie;
    s := (Modelica.Constants.pi/2) / 100; // Differential of 90° for integration
    beta := (Modelica.Constants.pi/2) / 100 * i; // Angle to the perpendicular direction
    sum := sum + (2/Modelica.Constants.pi) * Modelica.Math.atan(H/L * Modelica.Math.cos(beta)) * s;
  end for;
  gShaDif_mean := sum / (Modelica.Constants.pi/2);

equation
  // Calculate the shadow factor for direct radiation
  if shaLen.sha then
    gShaDir =min(max((heiWinMax - shaLen.heiSha)/(heiWinMax - heiWinMin), 0), 1);
  else
    gShaDir = 0;
  end if;
  solRadOut.I = solRadOut.I_dir + solRadOut.I_diff;
  solRadOut.I_dir = solRadIn.I_dir*gShaDir;
  // Calculate the shadow factor for diffuse radiation
  if calMod == AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode.constRedDiffAllDir then
    gShaDif = gShaDif_mean;
    solRadOut.I_diff = solRadIn.I_diff*gShaDif*redFacDifRad;
  elseif calMod == AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode.constRedDiffPerpDir then
    gShaDif = atan((heiWinMax+heiWinMin)/2 / lenShie)/(Modelica.Constants.pi/2);
    solRadOut.I_diff = solRadIn.I_diff*gShaDif*redFacDifRad;
  else
    gShaDif = 99;  //Not used in the following equation, to avoid sigular structure
    solRadOut.I_diff = solRadIn.I_diff*gShaDir*redFacDifRad;
  end if;
  solRadOut.I_gr = solRadIn.I_gr;
  solRadOut.AOI = solRadIn.AOI;

  connect(shaLen.weaBus, weaBus) annotation (Line(
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
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-100,140},{100,100}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ShadowEffect;
