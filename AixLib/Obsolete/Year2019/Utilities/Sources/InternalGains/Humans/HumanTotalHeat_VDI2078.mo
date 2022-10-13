within AixLib.Obsolete.Year2019.Utilities.Sources.InternalGains.Humans;
model HumanTotalHeat_VDI2078 "Model for sensible and latent heat output after VDI 2078"
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;
  extends AixLib.Obsolete.Year2019.Utilities.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078(
                                    thermalCollector(m=2));
  Modelica.Blocks.Math.MultiProduct productMoistureOutput(nu=2)
    annotation (Placement(transformation(extent={{-22,70},{-2,90}})));
  Modelica.Blocks.Interfaces.RealOutput MoistGain "in kg/s"
    annotation (Placement(transformation(extent={{86,70},{106,90}})));
  Modelica.Blocks.Math.Gain toKgPerSecond(k=1/(3600*1000))
    annotation (Placement(transformation(extent={{36,70},{56,90}})));
  Modelica.Blocks.Math.MultiProduct productLatentHeatOutput(nu=2)
    annotation (Placement(transformation(extent={{-26,42},{-6,62}})));
protected
  Modelica.Blocks.Tables.CombiTable1Dv MoistureOutput(
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=false,
    columns={ActivityType},
    table=[10,35,95,165; 18,35,95,165; 20,35,110,185; 22,40,125,215; 23,50,135,
        225; 24,60,140,230; 25,60,145,240; 26,65,150,250; 35,65,150,250])
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Tables.CombiTable1Dv HeatOutputLatent(
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=false,
    columns={ActivityType},
    table=[10,25,75,115; 18,25,65,115; 20,25,75,130; 22,30,85,150; 23,35,90,155;
        24,40,95,160; 25,40,100,165; 26,45,105,175; 35,45,105,175])
    annotation (Placement(transformation(extent={{-60,14},{-40,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeatLatent(T_ref=T0)
    annotation (Placement(transformation(extent={{18,40},{42,64}})));
equation
  connect(to_degC.y, MoistureOutput.u[1]) annotation (Line(points={{-71.5,51},{-68,
          51},{-68,80},{-62,80}}, color={0,0,127}));
  connect(MoistureOutput.y, productMoistureOutput.u[1:1]) annotation (Line(
        points={{-39,80},{-30,80},{-30,83.5},{-22,83.5}}, color={0,0,127}));
  connect(Nr_People.y, productMoistureOutput.u[2]) annotation (Line(points={{-53.4,
          -20},{-36,-20},{-36,76.5},{-22,76.5}}, color={0,0,127}));
  connect(productMoistureOutput.y, toKgPerSecond.u)
    annotation (Line(points={{-0.3,80},{34,80}}, color={0,0,127}));
  connect(toKgPerSecond.y, MoistGain)
    annotation (Line(points={{57,80},{96,80}}, color={0,0,127}));
  connect(HeatOutputLatent.y, productLatentHeatOutput.u[1:1]) annotation (Line(
        points={{-39,24},{-34,24},{-34,55.5},{-26,55.5}}, color={0,0,127}));
  connect(Nr_People.y, productLatentHeatOutput.u[2]) annotation (Line(points={{-53.4,
          -20},{-36,-20},{-36,48.5},{-26,48.5}}, color={0,0,127}));
  connect(to_degC.y, HeatOutputLatent.u[1]) annotation (Line(points={{-71.5,51},
          {-68,51},{-68,24},{-62,24}},                     color={0,0,127}));
  connect(productLatentHeatOutput.y, ConvectiveHeatLatent.Q_flow)
    annotation (Line(points={{-4.3,52},{18,52}}, color={0,0,127}));
  connect(ConvectiveHeatLatent.port, thermalCollector.port_a[2])
    annotation (Line(points={{42,52},{50,52},{50,32}}, color={191,0,0}));
  annotation (obsolete = "Obsolete model - use instead one of the models in AixLib.Utilities.Sources.InternalGains.Humans",
  Documentation(revisions="<html><ul>
  <li>March, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  <b><span style=\"color: #008000\">Overview</span></b>
</p>
<p>
  This model enhances the existing human model by moisture release and
  latent heat release. It is based on the same table from VDI 2078
  (Table A.1).
</p>
<p>
  <b><span style=\"color: #008000\">Concept</span></b>
</p>
<p>
  It is possible to choose between several types of physical activity.
</p>
<p>
  The heat output depends on the air temperature in the room where the
  activity takes place.
</p>
<p>
  A schedule of the activity is also required as constant presence of
  people in a room is not realistic. The schedule describes the
  presence of only one person, and can take values from 0 to 1.
</p>
<p>
  <b><span style=\"color: #008000\">Assumptions</span></b>
</p>
<p>
  The surface for radiation exchange is computed from the number of
  persons in the room, which leads to a surface area of zero, when no
  one is present. In particular cases this might lead to an error as
  depending of the rest of the system a division by this surface will
  be introduced in the system of equations -&gt; division by zero.For
  this reason a limitiation for the surface has been intoduced: as a
  minimum the surface area of one human and as a maximum a value of
  1e+23 m2 (only needed for a complete parametrization of the model).
</p>
<p>
  The latent heat release is assumed to be convective only.
</p>
<p>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  VDI 2078: Calculation of cooling load and room temperatures of rooms
  and buildings (VDI Cooling Load Code of Practice) - March 2012
</p>
</html>"));
end HumanTotalHeat_VDI2078;
