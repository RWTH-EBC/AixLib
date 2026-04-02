within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses;
model PartialVelocityBased
  "Partial model for velocity based frost modelling"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.PartialIcingFactor;
  parameter Boolean use_varDen=false "=true to use variable density based on PT1 Element, e.g. Korn et al."
    annotation(Dialog(group="Density"));
  parameter Modelica.Units.SI.Area A=15
    "Area of heat exchanger, all fins from both sides";
  parameter Boolean estimateMaximalIceMass = true "=false to specify maximal ice mass directly"
    annotation(Dialog(group="Ice mass"));

  parameter Modelica.Units.SI.Mass mIce_max=den_constant*A*d/2
    "Maximal possible mass of ice on HE surface. This value is limited by the volume between the fin tube"
    annotation(Dialog(group="Ice mass"));
  parameter Modelica.Units.SI.Distance d=3e-3
    "Distance between two fins. Used to calculate the maximal mass of ice on the HE"
    annotation(Dialog(group="Ice mass", enable=estimateMaximalIceMass));

  parameter Real natConvCoeff(unit="m/(s.K)")=1e-7
    "Parameter to be calibrated for natural defrost"
    annotation (Dialog(group="Melting"));
  parameter Modelica.Units.SI.SpecificEnthalpy hWatFus=333.5e3
    "Fusion enthalpy of water" annotation (Dialog(group="Melting"));
  parameter Modelica.Units.SI.Density den_constant=659
    "Constant density of frost, based on Korn at -5 frost temperature"
    annotation (Dialog(group="Density", enable=not use_varDen or estimateMaximalIceMass));
  parameter Real k(unit="1")=3.77 "Gain"
    annotation (Dialog(group="Density", enable=use_varDen));
  parameter Modelica.Units.SI.Time T=8000 "Time Constant"
    annotation (Dialog(group="Density", enable=use_varDen));
  parameter Real den_min=50 "Minimal density"
    annotation (Dialog(group="Density", enable=use_varDen));
  parameter Boolean use_reset=false "= true, if reset port enabled";

  Modelica.Blocks.Sources.RealExpression groRatFor_internal
    "Growth rate for forced convection from internal calcuations" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,80})));
  Modelica.Blocks.Sources.RealExpression groRatNat_internal(y=min(0, -
        natConvCoeff*(reaPasThrTOda.y - 273.15)))
    "Growth rate for natural convection from internal calcuations" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,40})));
  Modelica.Blocks.Logical.Switch switchGrowthRate
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));

  Modelica.Blocks.Logical.Switch swiMFloIce "Switch between ice growth rates"
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Math.Gain gaiADen(final k=A) "Gain with area and density"
                                 annotation (Placement(transformation(extent={{-10,
            -10},{10,10}}, origin={30,50})));
  Modelica.Blocks.Math.Product gaiDenCoeff "Gain with density coefficient"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-30,-60})));
  Modelica.Blocks.Math.Gain gaiWatFus(final k=-1/hWatFus)
    "Negate and divide by fusion enthalpy" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, origin={-70,-50})));
  Modelica.Blocks.Logical.And and1 "Is on and heating"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Math.Gain divIceMax(final k=1/mIce_max)
    "Divide by maximal ice mass" annotation (Placement(transformation(extent={{-10,
            -10},{10,10}}, origin={30,-60})));
  Modelica.Blocks.Math.Add gaiADen2(final k1=1, final k2=-1)
    "Gain with area and density"
                               annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},     origin={62,-54})));
  Modelica.Blocks.Sources.Constant conOne(final k=1) "Upper efficiency limit"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={68,-90})));
  Modelica.Blocks.Sources.RealExpression denCoe_internal(y=1)
    "Internal density coefficient calculation based on zones" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-70,-80})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTOda
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Blocks.Math.Product proAGroRatDen "Gain with area and density"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={70,50})));
  Modelica.Blocks.Sources.Constant conDen(final k=den_constant)
    if not use_varDen "Constant density" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,80})));
  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.IceMassIntegrator iceMassIntegrator(final mIce_max=mIce_max, use_reset=
        use_reset)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));

  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.FrostDensityKorn froDenKornPT1(
    k=k,
    T=T,
    den_min=den_min,
    y_internal(start=den_min, fixed=true))
                     if use_varDen
    "Frost density according to Korn"
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
equation

  connect(groRatNat_internal.y, switchGrowthRate.u3) annotation (Line(points={{-39,40},
          {-30,40},{-30,42},{-22,42}},     color={0,0,127}));
  connect(groRatFor_internal.y, switchGrowthRate.u1) annotation (Line(points={{-39,80},
          {-30,80},{-30,58},{-22,58}},     color={0,0,127}));
  connect(swiMFloIce.u2, sigBus.hea) annotation (Line(points={{-62,-10},{-82,-10},
          {-82,8},{-96,8},{-96,0},{-101,0}},
                               color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(gaiADen.u, switchGrowthRate.y)
    annotation (Line(points={{18,50},{1,50}}, color={0,0,127}));
  connect(gaiWatFus.y, gaiDenCoeff.u1) annotation (Line(points={{-59,-50},{-52,-50},
          {-52,-54},{-42,-54}},      color={0,0,127}));
  connect(gaiDenCoeff.y, swiMFloIce.u3) annotation (Line(points={{-19,-60},{-16,
          -60},{-16,-34},{-72,-34},{-72,-18},{-62,-18}},
                                                       color={0,0,127}));
  connect(gaiWatFus.u, sigBus.QEva_flow) annotation (Line(points={{-82,-50},{-101,
          -50},{-101,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(and1.y, switchGrowthRate.u2)
    annotation (Line(points={{-59,60},{-34,60},{-34,50},{-22,50}},
                                                 color={255,0,255}));
  connect(and1.u2, sigBus.hea) annotation (Line(points={{-82,52},{-96,52},{-96,0},
          {-101,0}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and1.u1, sigBus.onOffMea) annotation (Line(points={{-82,60},{-101,60},
          {-101,0}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(divIceMax.y, gaiADen2.u2)
    annotation (Line(points={{41,-60},{46,-60},{46,-48},{50,-48}},
                                                      color={0,0,127}));
  connect(conOne.y, gaiADen2.u1)
    annotation (Line(points={{79,-90},{84,-90},{84,-74},{50,-74},{50,-60}},
                                                      color={0,0,127}));
  connect(denCoe_internal.y, gaiDenCoeff.u2) annotation (Line(points={{-59,-80},
          {-54,-80},{-54,-66},{-42,-66}}, color={0,0,127}));
  connect(reaPasThrTOda.u, sigBus.TEvaInMea) annotation (Line(points={{-42,-90},
          {-50,-90},{-50,-36},{-76,-36},{-76,-4},{-78,-4},{-78,0},{-101,0}},
                                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(proAGroRatDen.y, swiMFloIce.u1) annotation (Line(points={{81,50},{84,50},
          {84,28},{-76,28},{-76,-2},{-62,-2}},
                                             color={0,0,127}));
  connect(gaiADen.y, proAGroRatDen.u2) annotation (Line(points={{41,50},{50,50},
          {50,44},{58,44}}, color={0,0,127}));
  connect(conDen.y, proAGroRatDen.u1) annotation (Line(points={{59,80},{50,80},{
          50,56},{58,56}}, color={0,0,127}));
  connect(swiMFloIce.y, iceMassIntegrator.mIceGro)
    annotation (Line(points={{-39,-10},{-22,-10}},
                                               color={0,0,127}));
  connect(iceMassIntegrator.mIce, divIceMax.u)
    annotation (Line(points={{2,-10},{12,-10},{12,-60},{18,-60}},
                                            color={0,0,127}));
  connect(iceMassIntegrator.reset, sigBus.hea) annotation (Line(points={{-10,-22},
          {-10,-28},{-101,-28},{-101,0}},      color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));

  connect(froDenKornPT1.groRat, switchGrowthRate.y) annotation (Line(points={{18,87},
          {8,87},{8,50},{1,50}},          color={0,0,127}));
  connect(froDenKornPT1.hea, sigBus.hea) annotation (Line(points={{18,95},{-32,95},
          {-32,-28},{-102,-28},{-102,0},{-101,0}},
                          color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(froDenKornPT1.froDen, proAGroRatDen.u1) annotation (Line(points={{41,90},
          {50,90},{50,56},{58,56}},       color={0,0,127}));
  connect(gaiADen2.y, swi.u1) annotation (Line(points={{73,-54},{80,-54},{80,-34},
          {46,-34},{46,8},{58,8}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
<p>
Partial model to estimate the icing factor based on ice mass and a frost-growth velocity.
Using the maximal ice mass and the current mass, the ice factor is calculated using:
</p>
<code>iceFac=1 - mIce/mIceMax</code>.
<p>
The concept was first used by Vering et al. and further developed during the PhD from Fabian Roemer and published in the paper Roemer et al.
</p>
<p>
Note, it is important to add the <code>QEva_flow</code> and <code>relHum</code> to the signal bus in order for the frosting models to work properly.
</p>
<p>
Density of the frost layer can be constant or dynamic using 
<a href=\"modelica://AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.FrostDensityKorn\">
AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.FrostDensityKorn
</a>.
</p>
<h4>References</h4>
<p>
Römer, Fabian and Fuchs, Nico and Fuchs, Nico and Müller, Dirk, Practical, Near-Optimal Design Rule Extraction for Heat Pumps in Single-Family Buildings (September 03, 2025). Available at SSRN: 
<a href=\"https://ssrn.com/abstract=5633891\">https://ssrn.com/abstract=5633891</a>
</p>
<p>
Vering, C., Wüllhorst, F., Mehrfeld, P., and Müller, D. (2021). Towards an integrated design of heat pump systems: Application of process intensification using two-stage optimization. Energy Conversion and Management, 250, 114888.
<a href=\"https://doi.org/10.1016/j.apenergy.2024.123225\">https://doi.org/10.1016/j.apenergy.2024.123225</a>
</p>
</html>"));
end PartialVelocityBased;
