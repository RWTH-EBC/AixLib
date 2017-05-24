within AixLib.ThermalZones.ReducedOrder.Windows.Examples;
model Illumination "Testmodel for Illumination"
  import vdi6007 = AixLib.ThermalZones.ReducedOrder.Windows;
  import AixLib;
  extends Modelica.Icons.Example;

  Windows.BaseClasses.HeatIllumination heatIllumination(HIll1=120, HIll2=240)
    "Heat input into the room due to the illumination"
    annotation (Placement(transformation(extent={{76,-10},{96,10}})));
  Windows.BaseClasses.Illumination illumination(
    D=0.27,
    e_ILim1=250,
    e_ILim2=500,
    office=true,
    n=1,
    r={0.21},
    A={5.13},
    T_L={0.72},
    til={1.5707963267949})
    "Determining the switch times for the illumination in the room"
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGTaueDoublePane CorGTaue(
    n=1,
    UWin=1.4,
    til={90}) "Correction values for non-vertical non-parallel irradiation"
    annotation (Placement(transformation(extent={{18,-42},{38,-22}})));
  Windows.BaseClasses.Sunblind sunblind(lim=200)
    "Calculates if the sunblind of the window is active"
    annotation (Placement(transformation(extent={{-16,-64},{-6,-54}})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil(
    azi=0,
    til=1.5707963267949,
    lat=0.86393797973719) "Diffuse irradiation on the window"
    annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
  Windows.Window window(
    n=1,
    UWin=1.4,
    g={0.64},
    g_TotDir={0.08},
    g_TotDif={0.27},
    T_L={0.72},
    T_LTotDir={0.08},
    T_LTotDif={0.32},
    lim=200,
    azi={0},
    lat=0.86393797973719,
    til={1.5707963267949}) "Window facing the south in a wall"
    annotation (Placement(transformation(extent={{-10,24},{10,44}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam="modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(
    azi=0,
    til=1.5707963267949,
    lat=0.86393797973719) "Direct irradiation on the surface"
    annotation (Placement(transformation(extent={{-66,-64},{-46,-44}})));
equation
  connect(illumination.Illumination, heatIllumination.Illumination)
    annotation (Line(points={{73,0},{75,0}}, color={255,0,255}));
  connect(CorGTaue.CorTaue_Gro, illumination.CorTaue_Gro) annotation (Line(
        points={{37,-24},{40,-24},{40,0},{51,0}}, color={0,0,127}));
  connect(CorGTaue.CorTaue_DifCov, illumination.CorTaue_DifCov) annotation (
     Line(points={{37,-26},{44,-26},{44,-6},{51,-6}}, color={0,0,127}));
  connect(HDifTil.H, sunblind.HDifTil) annotation (Line(points={{-39,-8},{-32,
          -8},{-32,-42},{-32,-44},{-32,-56},{-24,-56},{-20,-56},{-20,-56.1},{-16.5,
          -56.1}},                         color={0,0,127}));
  connect(sunblind.sunscreen, CorGTaue.sunscreen[1]) annotation (Line(
        points={{-5.5,-59},{-5.5,-58},{-6,-58},{-4,-58},{16,-58},{16,-34},{
          19,-34}}, color={255,0,255}));
  connect(weaDat.weaBus, HDifTil.weaBus) annotation (Line(
      points={{-80,0},{-70,0},{-70,-8},{-60,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, window.weaBus) annotation (Line(
      points={{-80,0},{-64,0},{-64,34},{-9.8,34}},
      color={255,204,51},
      thickness=0.5));
  connect(window.HVis, illumination.HVis)
    annotation (Line(points={{11,38},{32,38},{32,6},{51,6}}, color={0,0,127}));
  connect(weaDat.weaBus, HDirTil.weaBus) annotation (Line(
      points={{-80,0},{-74,0},{-74,-54},{-66,-54}},
      color={255,204,51},
      thickness=0.5));
  connect(HDirTil.H, sunblind.HDirTil) annotation (Line(points={{-45,-54},{
          -36,-54},{-36,-62},{-16.5,-62}}, color={0,0,127}));
  connect(HDirTil.inc, CorGTaue.incAng[1]) annotation (Line(points={{-45,-58},{-40,
          -58},{-40,-30},{19,-30}}, color={0,0,127}));
  annotation (experiment(StartTime=0,StopTime=31536000),Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
  <p>This example shows the application of
  <a href=\"Windows.BaseClasses.Illumination\">Illumination</a>.
   For solar radiation, the example relies on the standard
  weather file in AixLib.</p>
  <p>The idea of the example is to show a typical application of all
  sub-models and to use the example in unit tests. The results are
  reasonable, but not related to any real use case or measurement
  data.</p>
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI 6007-3
  June 2015. Calculation of transient thermal response of rooms
  and buildings - modelling of solar radiation.</p>
</html>", revisions="<html>
<ul>
<li>July 13, 2016,&nbsp; by Stanley Risch:<br>Implemented. </li>
<ul>
</html>"));
end Illumination;
