within AixLib.ThermalZones.HighOrder.Components.Shadow;
model RadiationTransfer "Radiation transformer for weather bus"
  parameter Modelica.Units.NonSI.Angle_deg aziDeg = -54 "Surface azimuth, S=0°, W=90°, N=180°, E=-90°";

  AixLib.Utilities.Sources.PrescribedSolarRad preSolRad
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,60},{-80,100}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface hDirTil(
    til=1.5707963267949,
    azi=Modelica.Units.Conversions.from_deg(aziDeg))
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez hDifTil(
    til=1.5707963267949,
    rho=0,
    azi=Modelica.Units.Conversions.from_deg(aziDeg))
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  AixLib.Utilities.Interfaces.SolarRad_out solRadOut
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(weaBus,hDirTil. weaBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,70},{-60,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus,hDifTil. weaBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,30},{-60,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(hDirTil.H, add.u1) annotation (Line(points={{-39,70},{-12,70},{-12,56},
          {-2,56}}, color={0,0,127}));
  connect(hDifTil.H, add.u2) annotation (Line(points={{-39,30},{-8,30},{-8,44},{
          -2,44}}, color={0,0,127}));
  connect(add.y, preSolRad.I[1]) annotation (Line(points={{21,50},{30,50},{30,17.8},
          {42.2,17.8}}, color={0,0,127}));
  connect(hDirTil.H, preSolRad.I_dir[1]) annotation (Line(points={{-39,70},{-12,
          70},{-12,10},{42,10}}, color={0,0,127}));
  connect(hDifTil.H, preSolRad.I_diff[1]) annotation (Line(points={{-39,30},{-20,
          30},{-20,2},{42,2}}, color={0,0,127}));
  connect(const.y, preSolRad.I_gr[1]) annotation (Line(points={{-39,-10},{-30,-10},
          {-30,-6.2},{42.2,-6.2}}, color={0,0,127}));
  connect(hDirTil.inc, preSolRad.AOI[1]) annotation (Line(points={{-39,66},{-26,
          66},{-26,-14},{42,-14}}, color={0,0,127}));
  connect(preSolRad.solarRad_out[1], solRadOut)
    annotation (Line(points={{78,0},{110,0}}, color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-100,140},{100,100}},
          textString="%name",
          textColor={0,0,255}), Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          lineThickness=1)}),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>December 2023,&nbsp;</i>by Jun Jiang:<br>Implemented.<br>This is for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1433\">#1433</a>.</li>
</ul>
</html>", info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>This model converts weather data to the solar radiation port.</p>
<p><b><span style=\"color: #008000;\">Concept</span> </b></p>
<p>See the submodules in the model.</p>
<p><b><span style=\"color: #008000;\">Assumptions</span> </b></p>
<p>Vertical wall surface (til = 90&deg;).</p>
</html>"));
end RadiationTransfer;
