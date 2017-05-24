within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model Window "Calculation of solar energy transmitted through windows"
  import vdi6007 = AixLib.ThermalZones.ReducedOrder.Windows;
  import AixLib;
  parameter Integer n(min = 1) "number of windows"
    annotation(dialog(group="window"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer UWin
    "Thermal transmission coefficient of whole window"
    annotation(dialog(group="window"));
   parameter Modelica.SIunits.TransmissionCoefficient g[n]
    "Total energy transmittance of windows"
    annotation(Dialog(group="window"));
  parameter Modelica.SIunits.TransmissionCoefficient g_TotDir[n]
    "Total energy transmittance of windows with closed sunscreen for direct
    radiation"
    annotation(Dialog(group="window"));
  parameter Modelica.SIunits.TransmissionCoefficient g_TotDif[n]
    "Total energy transmittance of windows with closed sunscreen for diffuse
     radiation"
    annotation(Dialog(group="window"));
  parameter Modelica.SIunits.TransmissionCoefficient T_L[n]
    "degree of light transmission for direct irradiation"
    annotation (Dialog(group="window"));
  parameter Modelica.SIunits.TransmissionCoefficient T_LTotDir[n]
    "degree of light transmission for direct irradiation, with sunscreen"
    annotation (Dialog(group="window"));
  parameter Modelica.SIunits.TransmissionCoefficient T_LTotDif[n]
    "degree of light transmission for diffuse irradiation, with sunscreen"
    annotation (Dialog(group="window"));
  parameter Modelica.SIunits.RadiantEnergyFluenceRate lim
    "Limit for the sunscreen to become active"
    annotation(dialog(group="sunscreen"));
  parameter Modelica.SIunits.Angle xi(  displayUnit="degree")= 0
    "elevation angle";
  parameter Modelica.SIunits.Angle til[n](displayUnit="deg")
    "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
     roof"
    annotation (Dialog(group="window"));

  Modelica.Blocks.Interfaces.RealInput incAng[n](
    final quantity="Angle",
    final unit="rad",
    displayUnit="degree")
    "Incidence angles of the sun beam on a tilted surface"
    annotation (Placement(transformation(extent={{-124,68},{-100,92}}),
    iconTransformation(extent={{-120,72},{-100,92}})));
   Modelica.Blocks.Interfaces.RealInput alt(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar altitude angle"
    annotation (Placement(transformation(extent={{-124,12},{-100,36}}),
        iconTransformation(extent={{-120,16},{-100,36}})));

   Modelica.Blocks.Interfaces.RealInput nTot( min=0,max=1,
    final unit="1") "Total sky Cover"
    annotation (Placement(transformation(extent={{-124,42},{-100,66}}),
        iconTransformation(extent={{-120,46},{-100,66}})));
   Modelica.Blocks.Interfaces.RealInput HDirTil[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Direct irradition on tilted surface"
    annotation (Placement(transformation(extent={{-124,-92},{-100,-68}}),
        iconTransformation(extent={{-120,-88},{-100,-68}})));

    Modelica.Blocks.Interfaces.RealInput HDirNor(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Direct normal radiation."
    annotation (Placement(transformation(extent={{-124,-64},{-100,-40}}),
        iconTransformation(extent={{-120,-60},{-100,-40}})));

   Modelica.Blocks.Interfaces.RealInput HDifHor(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Horizontal diffuse solar radiation."
    annotation (Placement(transformation(extent={{-124,-36},{-100,-12}}),
        iconTransformation(extent={{-120,-32},{-100,-12}})));

    Modelica.Blocks.Interfaces.RealInput HDifTil[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface from the sky"
    annotation (Placement(transformation(extent={{-124,-12},{-100,12}}),
        iconTransformation(extent={{-120,-8},{-100,12}})));

    Modelica.Blocks.Interfaces.RealOutput HVis[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "solar energy entering the room in the visible area"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{100,30},{120,50}})));

    Modelica.Blocks.Interfaces.RealOutput HWin[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Solar radiation transmitted through aggregated window"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}),
        iconTransformation(extent={{100,-50},{120,-30}})));

  vdi6007.BaseClasses.Sunblind sunblind[n](lim=lim)
    annotation (Placement(transformation(extent={{-68,-42},{-56,-30}})));
  AixLib.ThermalZones.ReducedOrder.Windows.SolarGain.CorrectionGTaueDoublePane
    CorGTaue(
    final n=n,
    final UWin=UWin,
    final xi=xi,
    final til=til)
    annotation (Placement(transformation(extent={{-30,-22},{-6,8}})));
  vdi6007.BaseClasses.HVisible HVisible(
    final n=n,
    final T_LTotDir=T_LTotDir,
    final T_LTotDif=T_LTotDif,
    final til=til,
    final T_L=T_L)
    annotation (Placement(transformation(extent={{56,18},{100,62}})));
  vdi6007.BaseClasses.Conversions.HDif_toClearCovered hDif_toClearCovered[n]
    annotation (Placement(transformation(extent={{-74,-18},{-54,2}})));
  vdi6007.BaseClasses.HWindow HWindow(
    final g=g,
    final til=til,
    final n=n,
    final g_TotDir=g_TotDir,
    final g_TotDif=g_TotDif)
    annotation (Placement(transformation(extent={{54,-62},{100,-18}})));

equation
  connect(HDifTil, sunblind.HDifTil) annotation (Line(points={{-112,0},{-92,0},
          {-92,-32.52},{-68.6,-32.52}},
                                      color={0,0,127}));
  connect(HDirTil, sunblind.HDirTil) annotation (Line(points={{-112,-80},{-81.5,
          -80},{-81.5,-39.6},{-68.6,-39.6}},
                                           color={0,0,127}));
  connect(sunblind.sunscreen, CorGTaue.sunscreen) annotation (Line(points={{-55.4,
          -36},{-38,-36},{-38,-10},{-28.8,-10}},
                                            color={255,0,255}));
  connect(HVisible.HVis, HVis) annotation (Line(points={{102.2,40},{102.2,
          40},{110,40}}, color={0,0,127}));
  connect(sunblind.sunscreen, HVisible.sunscreen) annotation (Line(points=
          {{-55.4,-36},{-38,-36},{-38,40.22},{54.46,40.22}}, color={255,0,
          255}));
  connect(CorGTaue.CorTaue_Dir, HVisible.CorTaue_Dir) annotation (Line(
        points={{-7.2,-4},{22,-4},{22,18.22},{54.46,18.22}}, color={0,0,127}));
  connect(CorGTaue.CorTaue_DifCle, HVisible.CorTaue_DifCle) annotation (
      Line(points={{-7.2,-1},{18,-1},{18,22.62},{54.46,22.62}}, color={0,0,
          127}));
  connect(CorGTaue.CorTaue_DifCov, HVisible.CorTaue_DifCov) annotation (
      Line(points={{-7.2,2},{14,2},{14,27.02},{54.46,27.02}}, color={0,0,
          127}));
  connect(CorGTaue.CorTaue_Gro, HVisible.CorTaue_Gro) annotation (Line(
        points={{-7.2,5},{10,5},{10,31.42},{54.46,31.42}}, color={0,0,127}));
  connect(alt, HVisible.alt) annotation (Line(points={{-112,24},{-30,24},{-30,
          35.82},{54.46,35.82}}, color={0,0,127}));
  connect(hDif_toClearCovered.HDifTilCle, HVisible.HDifTilCle) annotation (
      Line(points={{-53,-2},{-48,-2},{-48,54.74},{54.46,54.74}}, color={0,0,
          127}));
  connect(hDif_toClearCovered.HDifTilCov, HVisible.HDifTilCov) annotation (
      Line(points={{-53,-6},{-46,-6},{-46,51.22},{54.46,51.22}}, color={0,0,
          127}));
  connect(hDif_toClearCovered[1].HDifHorCov, HVisible.HDifHorCov)
    annotation (Line(points={{-53,-10},{-44,-10},{-44,47.7},{54.46,47.7}},
        color={0,0,127}));
  connect(hDif_toClearCovered[1].HDifHorCle, HVisible.HDifHorCle)
    annotation (Line(points={{-53,-14},{-42,-14},{-42,44.18},{54.46,44.18}},
        color={0,0,127}));
  connect(HDifTil, hDif_toClearCovered.HDifTil) annotation (Line(points={{-112,0},
          {-92,0},{-92,-2},{-75,-2}},  color={0,0,127}));

  connect(HWindow.HWin, HWin) annotation (Line(points={{102.3,-40},{102.3,-40},
          {110,-40}}, color={0,0,127}));
  connect(sunblind.sunscreen, HWindow.sunscreen) annotation (Line(points={
          {-55.4,-36},{-2,-36},{-2,-39.78},{52.39,-39.78}}, color={255,0,
          255}));
  connect(CorGTaue.CorG_Dir, HWindow.CorG_Dir) annotation (Line(points={{-7.2,
          -10},{22,-10},{22,-18.22},{52.39,-18.22}}, color={0,0,127}));
  connect(CorGTaue.CorG_DifCle, HWindow.CorG_DifCle) annotation (Line(
        points={{-7.2,-13},{18.4,-13},{18.4,-22.18},{52.39,-22.18}}, color=
          {0,0,127}));
  connect(CorGTaue.CorG_DifCov, HWindow.CorG_DifCov) annotation (Line(
        points={{-7.2,-16},{16,-16},{16,-26.58},{52.39,-26.58}}, color={0,0,
          127}));
  connect(CorGTaue.CorG_Gro, HWindow.CorG_Gro) annotation (Line(points={{-7.2,
          -19},{12.4,-19},{12.4,-30.98},{52.39,-30.98}}, color={0,0,127}));
  connect(HDifHor, HWindow.HDifHor) annotation (Line(points={{-112,-24},{-94,
          -24},{-94,-72},{44,-72},{44,-61.78},{48,-61.78},{52.39,-61.78}},
        color={0,0,127}));
  connect(hDif_toClearCovered.HDifTilCle, HWindow.HDifTilCle) annotation (
      Line(points={{-53,-2},{-48,-2},{-48,-57.38},{52.39,-57.38}}, color={0,
          0,127}));
  connect(hDif_toClearCovered.HDifTilCov, HWindow.HDifTilCov) annotation (
      Line(points={{-53,-6},{-50,-6},{-50,-52.98},{52.39,-52.98}}, color={0,
          0,127}));
  connect(HDirNor, HWindow.HDirNor) annotation (Line(points={{-112,-52},{-85.5,
          -52},{-85.5,-49.02},{52.39,-49.02}}, color={0,0,127}));
  connect(HDirTil, HWindow.HDirTil) annotation (Line(points={{-112,-80},{
          38.5,-80},{38.5,-44.18},{52.39,-44.18}}, color={0,0,127}));
  connect(incAng, CorGTaue.incAng) annotation (Line(points={{-112,80},{-32,80},{
          -32,-4},{-28.8,-4}},  color={0,0,127}));
  connect(HDirTil, HVisible.HDirTil) annotation (Line(points={{-112,-80},{
          29.5,-80},{29.5,58.26},{54.46,58.26}}, color={0,0,127}));
  connect(HDirNor, HVisible.HDirNor) annotation (Line(points={{-112,-52},{
          27.5,-52},{27.5,61.78},{54.46,61.78}}, color={0,0,127}));
  connect(alt, HWindow.alt) annotation (Line(points={{-112,24},{4,24},{4,-35.38},
          {52.39,-35.38}}, color={0,0,127}));
  for i in 1:n loop
      connect(nTot, hDif_toClearCovered[i].nTot) annotation (Line(points={{-112,54},
          {-82,54},{-82,-8},{-75,-8}}, color={0,0,127}));
  connect(HDifHor, hDif_toClearCovered[i].HDifHor) annotation (Line(points={{-112,
          -24},{-94,-24},{-94,-14},{-75,-14}}, color={0,0,127}));
  end for;
   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-96,96},{96,-96}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={156,232,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,96},{2,-96}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-96,2},{96,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-34,116},{40,82}},
          lineColor={28,108,200},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li>June 30, 2016,&nbsp; by Stanley Risch:<br>Implemented. </li>
</html>", info="<html>
<p>This model calculates the input of heat and visible light into the room due to solar irradiation. Therefore it uses the calculations of VDI 6007 part 3.  It considers  the correction values for non-vertical and non-parallel radiation incidence.</p>

  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI 6007-3
  June 2015. Calculation of transient thermal response of rooms
  and buildings - modelling of solar radiation.</p>
</html>"));
end Window;
