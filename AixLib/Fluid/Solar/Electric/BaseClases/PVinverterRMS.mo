within AixLib.Fluid.Solar.Electric.BaseClases;
model PVinverterRMS "PVinverterRMS with reliable system manager (from ACS)"

 Modelica.Blocks.Nonlinear.Limiter max_Output_Power(
  uMax(
   quantity="Basics.Power",
   displayUnit="Nm/s")=uMax2,
  uMin=0)
         annotation(Placement(transformation(extent={{40,70},{60,90}})));
 Modelica.Blocks.Tables.CombiTable1Ds Efficiency_Converter_SunnyBoy3800(
  tableOnFile=false,
  table=[0,0.798700;100,0.848907;200,0.899131;250,0.911689;300,0.921732;350,0.929669;400,0.935906;450,0.940718;500,0.943985;550,0.946260;600,0.947839;700,0.950638;800,0.952875;900,0.954431;1000,0.955214;1250,0.956231;1500,0.956449;2000,0.955198;2500,0.952175;3000,0.948659;3500,0.944961;3800,0.942621])
                                                                                               annotation(Placement(transformation(extent={{-25,55},{-5,75}})));
 Modelica.Blocks.Math.Product product2 annotation(Placement(transformation(extent={{10,70},{30,90}})));
// StaticBlocksContainer _staticBlocks;
 Modelica.Blocks.Interfaces.RealOutput PV_Power_RMS_W
    "'output Real' as connector"                                                    annotation(Placement(
  transformation(extent={{85,70},{105,90}}),
  iconTransformation(
   origin={100,0},
   extent={{-10,-10},{10,10}})));
 Modelica.Blocks.Interfaces.RealInput DC_power_input
    "'input Real' as connector"                                                   annotation(Placement(
  transformation(extent={{-80,55},{-40,95}}),
  iconTransformation(extent={{-122,-18},{-82,22}})));
 parameter Real uMax2(
  quantity="Basics.Power",
  displayUnit="kW")=4000 "Upper limits of input signals (max_Output_Power)";
equation
  connect(product2.u2,Efficiency_Converter_SunnyBoy3800.y[1]) annotation(Line(
   points={{8,74},{3,74},{1,74},{1,65},{-4,65}},
   color={0,0,127}));
  connect(product2.y,max_Output_Power.u) annotation(Line(
   points={{31,80},{36,80},{33,80},{38,80}},
   color={0,0,127}));
  connect(max_Output_Power.y,PV_Power_RMS_W) annotation(Line(
   points={{61,80},{65,80},{90,80},{95,80}},
   color={0,0,127}));
  connect(product2.u1,DC_power_input) annotation(Line(
   points={{8,86},{5,86},{-55,85},{-55,75},{-60,75}},
   color={0,0,127}));
  connect(Efficiency_Converter_SunnyBoy3800.u,DC_power_input) annotation(Line(
   points={{-27,65},{-30,65},{-55,65},{-55,75},{-60,75}},
   color={0,0,127}));
  annotation (
   viewinfo[1](
    minOrder=0.5,
    maxOrder=12,
    mode=0,
    minStep=0.01,
    maxStep=0.1,
    relTol=1e-005,
    oversampling=4,
    anaAlgorithm=0,
    typename="AnaStatInfo"),
   Efficiency_Converter_SunnyBoy3800(
    tableName(flags=128),
    fileName(flags=128)),
   Icon(
    coordinateSystem(extent={{-100,-100},{100,100}}),
    graphics={
     Rectangle(
      lineColor={0,0,0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-100,100},{100,-100}}),
     Line(
      points={{-50,37},{53,37}},
      color={0,0,0}),
     Line(
      points={{-48,-34},{55,-34}},
      color={0,0,0})}),
   experiment(
    StopTime=1,
    StartTime=0),
     Diagram(graphics),
     Documentation(revisions="<html>
<p><ul>
<li><i>Februar 21, 2013  </i>by Corinna Leonhardt:<br/>Implemented</li>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
</ul></p>
</html>",
     info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>The<b> PVinverterRMS</b> model represents a simple PV inverter. </p>
<p><br><h4><span style=\"color: #008000\">Concept</span></h4></p>
<p>PVinverterRMS&nbsp;with&nbsp;reliable&nbsp;system&nbsp;manager&nbsp;(from&nbsp;ACS).</p>
</html>"));
end PVinverterRMS;
