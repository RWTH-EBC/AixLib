within AixLib.Electrical.Machines;
model PVInverterRMS "Inverter model including system management"

  parameter Modelica.Units.SI.Power uMax2
    "Upper limits of input signals (MaxOutputPower)";
 Modelica.Blocks.Interfaces.RealOutput PVPowerRmsW(
  final quantity="Power",
  final unit="W")
  "Output power of the PV system including the inverter"
  annotation(Placement(
  transformation(extent={{85,70},{105,90}}),
  iconTransformation(
   origin={100,0},
   extent={{-10,-10},{10,10}})));
 Modelica.Blocks.Interfaces.RealInput DCPowerInput(
  final quantity="Power",
  final unit="W")
  "DC output power of PV panels as input for the inverter"
  annotation(Placement(
  transformation(extent={{-80,55},{-40,95}}),
  iconTransformation(extent={{-122,-18},{-82,22}})));
 Modelica.Blocks.Nonlinear.Limiter MaxOutputPower(
   uMax(
    final quantity="Power",
    final displayUnit="Nm/s")=uMax2,
   uMin=0)
   "Limitier for maximum output power"
   annotation(Placement(transformation(extent={{40,70},{60,90}})));
 Modelica.Blocks.Tables.CombiTable1Ds EfficiencyConverterSunnyBoy3800(
   tableOnFile=false,
   table=[0,0.798700;100,0.848907;200,0.899131;250,0.911689;300,0.921732;350,0.929669;400,0.935906;450,0.940718;500,0.943985;550,0.946260;600,0.947839;700,0.950638;800,0.952875;900,0.954431;1000,0.955214;1250,0.956231;1500,0.956449;2000,0.955198;2500,0.952175;3000,0.948659;3500,0.944961;3800,0.942621])
     "Efficiency of the inverter for different operating points"
     annotation(Placement(transformation(extent={{-25,55},{-5,75}})));
 Modelica.Blocks.Math.Product Product2
     "Multiplies the output power of the PV cell with the efficiency of the inverter "
     annotation(Placement(transformation(extent={{10,70},{30,90}})));

equation
  connect(Product2.u2,EfficiencyConverterSunnyBoy3800.y[1]) annotation(Line(
   points={{8,74},{3,74},{1,74},{1,65},{-4,65}},
   color={0,0,127}));
  connect(Product2.y,MaxOutputPower.u) annotation(Line(
   points={{31,80},{36,80},{33,80},{38,80}},
   color={0,0,127}));
  connect(MaxOutputPower.y,PVPowerRmsW) annotation(Line(
   points={{61,80},{65,80},{90,80},{95,80}},
   color={0,0,127}));
  connect(Product2.u1,DCPowerInput) annotation(Line(
   points={{8,86},{5,86},{-55,86},{-55,75},{-60,75}},
   color={0,0,127}));
  connect(EfficiencyConverterSunnyBoy3800.u,DCPowerInput) annotation(Line(
   points={{-27,65},{-30,65},{-55,65},{-55,75},{-60,75}},
   color={0,0,127}));
    annotation (
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
     Documentation(revisions="<html><ul>
  <li>
    <i>October 11, 2016</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>Februar 21, 2013</i> by Corinna Leonhardt:<br/>
    Implemented
  </li>
</ul>
</html>",
     info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  The <b>PVinverterRMS</b> model represents a simple PV inverter.
</p>
<p>
  <br/>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  PVinverterRMS&#160;with&#160;reliable&#160;system&#160;manager.
</p>
</html>"));
end PVInverterRMS;
