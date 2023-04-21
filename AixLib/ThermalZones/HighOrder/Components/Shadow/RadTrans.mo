within AixLib.ThermalZones.HighOrder.Components.Shadow;
model RadTrans "Radiation transformer for WeaBus"
  parameter Modelica.Units.NonSI.Angle_deg azi_deg = -54 "Surface azimuth, S=0°, W=90°, N=180°, E=-90°";

  Utilities.Sources.PrescribedSolarRad prescribedSolarRad
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,60},{-80,100}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(til=
        1.5707963267949, azi=Modelica.Units.Conversions.from_deg(azi_deg))
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil(
    til=1.5707963267949,
    rho=0,
    azi=Modelica.Units.Conversions.from_deg(azi_deg))
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Utilities.Interfaces.SolarRad_out solarRad_out
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(weaBus, HDirTil.weaBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,70},{-60,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDifTil.weaBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,30},{-60,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(HDirTil.H, add.u1) annotation (Line(points={{-39,70},{-12,70},{-12,56},
          {-2,56}}, color={0,0,127}));
  connect(HDifTil.H, add.u2) annotation (Line(points={{-39,30},{-8,30},{-8,44},{
          -2,44}}, color={0,0,127}));
  connect(add.y, prescribedSolarRad.I[1]) annotation (Line(points={{21,50},{30,50},
          {30,17.8},{42.2,17.8}}, color={0,0,127}));
  connect(HDirTil.H, prescribedSolarRad.I_dir[1]) annotation (Line(points={{-39,
          70},{-12,70},{-12,10},{42,10}}, color={0,0,127}));
  connect(HDifTil.H, prescribedSolarRad.I_diff[1]) annotation (Line(points={{-39,
          30},{-20,30},{-20,2},{42,2}}, color={0,0,127}));
  connect(const.y, prescribedSolarRad.I_gr[1]) annotation (Line(points={{-39,-10},
          {-30,-10},{-30,-6.2},{42.2,-6.2}}, color={0,0,127}));
  connect(HDirTil.inc, prescribedSolarRad.AOI[1]) annotation (Line(points={{-39,
          66},{-26,66},{-26,-14},{42,-14}}, color={0,0,127}));
  connect(prescribedSolarRad.solarRad_out[1], solarRad_out)
    annotation (Line(points={{78,0},{110,0}}, color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RadTrans;
