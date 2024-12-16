within AixLib.ThermalZones.HighOrder.Components.SolarIrradiation;
model RadOnTiltedSurfaceIBPSA
  "Connect weather bus from IBPSA to HOM approach"
  parameter Modelica.Units.SI.Angle til "Surface tilt";
  parameter Real rho=0.2 "Ground reflectance";
  parameter Modelica.Units.SI.Angle azi "Surface azimuth";
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil(
    final til=til,
    final rho=rho,
    final azi=azi,
    final outSkyCon=false,
    final outGroCon=true)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(
    final til=til,
    final azi=azi)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  AixLib.Utilities.Interfaces.SolarRad_out radOnTiltedSurf
    annotation (Placement(transformation(extent={{98,-12},{122,10}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));

equation
  radOnTiltedSurf.I = HDifTil.H + HDirTil.H;
  radOnTiltedSurf.I_dir = HDirTil.H;
  radOnTiltedSurf.I_diff = HDifTil.H;
  radOnTiltedSurf.I_gr = HDifTil.HGroDifTil;
  radOnTiltedSurf.AOI = HDirTil.inc;
  connect(HDifTil.weaBus, weaBus) annotation (Line(
      points={{-20,30},{-58,30},{-58,0},{-102,0}},
      color={255,204,51},
      thickness=0.5));
  connect(HDirTil.weaBus, weaBus) annotation (Line(
      points={{-20,-30},{-58,-30},{-58,0},{-102,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RadOnTiltedSurfaceIBPSA;
