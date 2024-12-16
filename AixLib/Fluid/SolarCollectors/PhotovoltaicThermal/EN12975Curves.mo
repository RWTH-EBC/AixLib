within AixLib.Fluid.SolarCollectors.PhotovoltaicThermal;
model EN12975Curves
  "Collector approach based on EN12975, efficiency based on curves"
  extends AixLib.Fluid.SolarCollectors.EN12975(
    final nPanels=0,
    nColType=AixLib.Fluid.SolarCollectors.Types.NumberSelection.Area,
    final per=AixLib.Fluid.SolarCollectors.Data.GenericEN12975(
    A=perPVT.A,
    CTyp=perPVT.CTyp,
    C=perPVT.C,
    V=perPVT.V,
    mDry=perPVT.mDry,
    mperA_flow_nominal=perPVT.mperA_flow_nominal,
    dp_nominal=perPVT.dp_nominal,
    IAMDiff=perPVT.IAMDiff,
    incAngDat=perPVT.incAngDat,
    incAngModDat=perPVT.incAngModDat,
    eta0=perPVT.eta0,
    a1=perPVT.a1,
    a2=perPVT.a2));
  replaceable Data.PhotovoltaicThermalBaseDataDefinition perPVT
    "Performance data for PV-Thermal"
    annotation (choicesAllMatching=true, Placement(transformation(extent={{40,-78},
            {54,-64}})));
  AixLib.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain eleGai(
    redeclare package Medium = Medium,
    final nSeg=nSeg,
    final incAngDat=per.incAngDat,
    final incAngModDat=per.incAngModDat,
    final iamDiff=per.IAMDiff,
    final eta0=perPVT.etaEle_zero,
    final use_shaCoe_in=use_shaCoe_in,
    final shaCoe=shaCoe,
    final A_c=ATot_internal) "Identifies electrical energy prodcued"
    annotation (Placement(transformation(extent={{10,80},{30,100}})));
  AixLib.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss eleLos(
    redeclare package Medium = Medium,
    final nSeg=nSeg,
    final A_c=ATot_internal,
    final a1=perPVT.mEle,
    final a2=0)
    "Identifies electrical energy losses due to temperature dependence"
    annotation (Placement(transformation(extent={{10,56},{30,76}})));
  Modelica.Blocks.Interfaces.RealOutput PEle(unit="W", displayUnit="kW")
    annotation (Placement(transformation(extent={{100,70},{120,90}})));

  Modelica.Blocks.Math.MultiSum multiSumLos(                            nu=nSeg)
    "Sum of all electrical losses"
    annotation (Placement(transformation(extent={{40,62},{48,70}})));
  Modelica.Blocks.Math.MultiSum multiSumGai(nu=nSeg)
    "Sum of all electrical gains"
    annotation (Placement(transformation(extent={{40,86},{48,94}})));
  Modelica.Blocks.Math.Add      add(final k1=+1, final k2=+1)
    "Sum of all electrical gains"
    annotation (Placement(transformation(extent={{56,76},{64,84}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=Modelica.Constants.inf,
      final uMin=0) "Electrical power generation can't be lower than zero"
    annotation (Placement(transformation(extent={{76,76},{84,84}})));
equation
  connect(shaCoe_in, eleGai.shaCoe_in) annotation (Line(
      points={{-120,40},{-40,40},{-40,85},{8,85}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(eleGai.HSkyDifTil, HDifTilIso.H) annotation (Line(points={{8,98},{-50,
          98},{-50,80},{-59,80}}, color={0,0,127}));
  connect(eleGai.HDirTil, HDirTil.H) annotation (Line(points={{8,92},{-32,92},{-32,
          52},{-50,52},{-50,50},{-59,50}}, color={0,0,127}));
  connect(HDirTil.inc, eleGai.incAng) annotation (Line(points={{-59,46},{-50,46},
          {-50,48},{-28,48},{-28,88},{8,88}}, color={0,0,127}));
  connect(eleGai.TFlu, temSen.T) annotation (Line(points={{8,82},{-30,82},{-30,-20},
          {-11,-20}}, color={0,0,127}));
  connect(eleLos.TFlu, temSen.T) annotation (Line(points={{8,60},{4,60},{4,36},{
          -30,36},{-30,-20},{-11,-20}}, color={0,0,127}));
  connect(eleLos.TEnv, weaBus.TDryBul) annotation (Line(points={{8,72},{-90,72},
          {-90,80},{-99.95,80},{-99.95,80.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(multiSumLos.u, eleLos.QLos_flow)
    annotation (Line(points={{40,66},{31,66}}, color={0,0,127}));
  connect(eleGai.QSol_flow, multiSumGai.u)
    annotation (Line(points={{31,90},{40,90}}, color={0,0,127}));
  connect(add.u2, multiSumLos.y) annotation (Line(points={{55.2,77.6},{50,77.6},
          {50,66},{48.68,66}},
                      color={0,0,127}));
  connect(add.u1, multiSumGai.y) annotation (Line(points={{55.2,82.4},{50,82.4},
          {50,90},{48.68,90}},
                      color={0,0,127}));
  connect(add.y, limiter.u)
    annotation (Line(points={{64.4,80},{75.2,80}}, color={0,0,127}));
  connect(limiter.y, PEle)
    annotation (Line(points={{84.4,80},{110,80}}, color={0,0,127}));
  annotation (Documentation(info="<html><h4>
  Overview
</h4>
<p>
  Simplified model of a photovoltaic thermal collector, which builds
  upon the solar thermal model. Inputs are outdoor air temperature and
  solar irradiation. Based on these values and the collector properties
  from database, this model creates a heat flow to the fluid circuit
  and an electrical power output.
</p>
<h4>
  Concept
</h4>
<p>
  The model maps solar collector efficiency based on the equation
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Fluid/HeatExchanger/SolarThermal/equation-vRK5Io7E.png\"
  alt=\"1\">
</p>
<p>
  and similar for the electrical efficiency a linear approximation is
  used:
</p>
<p>
<code>eta=etaEle_zero - mEle * dT/G</code>
</p>
<p>
  Values for the linear and quadratic coefficients for the
  thermal efficiency as well as the coefficients for the linear
  approximation are derived from <a href=
  \"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">
  this thesis </a> by Markus Lämmle, p.43
  Figure 3.12. The underlying data was validated with the following
  assumptions:
</p>
<ul>
  <li>solar irradiation G=1000 W/m^2
  </li>
  <li>windspeed Uwind=3m/s
  </li>
  <li>ambient temperature Ta= 25°C
  </li>
</ul>
<h4>
  Known Limitations
</h4>
<ul>
<li>The parameters for pressure losses and capacities inside the 
   records are based on the solar thermal model, not on the PhD thesis.
  </li>
  <li>With the standard BaseParameters, this model uses water as
  working fluid
  </li>
</ul>
<h5>
  Parameters
</h5>
<p>
  This model is an extension of <a href=
  \"modelica://AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>.
  Therefore the parameters can be found in the base model.
</p>
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    First implementation. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                             Polygon(points={{-20,-100},{8,4},{84,4},{60,-100},{
              -20,-100}}, lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{12,-6},{78,-6}},  color={255,255,255},
          thickness=1),
        Line(points={{-6,-70},{60,-70}},color={255,255,255},
          thickness=1),
        Line(points={{0,-54},{66,-54}}, color={255,255,255},
          thickness=1),
        Line(points={{4,-38},{70,-38}}, color={255,255,255},
          thickness=1),
        Line(points={{8,-22},{74,-22}}, color={255,255,255},
          thickness=1),
        Line(points={{18,-94},{42,2}},  color={255,255,255},
          thickness=1),
        Line(points={{-10,-86},{56,-86}},
                                        color={255,255,255},
          thickness=1),
        Line(points={{-2,-94},{22,2}},  color={255,255,255},
          thickness=1),
        Line(points={{38,-94},{62,2}},  color={255,255,255},
          thickness=1)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EN12975Curves;
