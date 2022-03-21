within AixLib.DataBase.HeatPump.PerformanceData;
model NominalHeatPumpNotManufacturer

  parameter Boolean HighTemp=false;
  parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.HeatFlowRate QNom=30000 "Nominal heat flow"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
     parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

 parameter Boolean dTConFix=false "Constant delta T condenser"
   annotation (Dialog(descriptionLabel=true, group="General machine information"));

  Modelica.Blocks.Interfaces.RealOutput PelFullLoad(final unit="W", final
      displayUnit="kW")
    "maximal notwendige elektrische Leistung im Betriebspunkt" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-80})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));

  Modelica.Blocks.Interfaces.RealOutput QEvapNom(final unit="W", final
      displayUnit="kW")
    "maximal notwendige elektrische Leistung im Betriebspunkt" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,20})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{64,10},{84,30}})));

  Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom)
    annotation (Placement(transformation(extent={{-100,22},{-78,46}})));
  Modelica.Blocks.Sources.RealExpression tSourceNom(y=TSourceNom)
    annotation (Placement(transformation(extent={{-100,80},{-74,104}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-36,92})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,34})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QNom)
    annotation (Placement(transformation(extent={{-48,-84},{-32,-64}})));
  Modelica.Blocks.Sources.RealExpression qNom1(y=QNom)
    annotation (Placement(transformation(extent={{30,16},{46,36}})));
  Modelica.Blocks.Sources.RealExpression deltaTCon(y=DeltaTCon)
    annotation (Placement(transformation(extent={{12,11},{-12,-11}},
        rotation=180,
        origin={-88,57})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,12})));
  SDF.NDTable SDFCOP1(
    final nin=4,
    final readFromFile=true,
    final filename=FilenameCOP,
    final dataset="\COP",
    final dataUnit="-",
    final scaleUnits={"degC","-","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for COP" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-10,-20})));
  Modelica.Blocks.Sources.RealExpression PLRNom(y=1) annotation (Placement(
        transformation(
        extent={{11,12},{-11,-12}},
        rotation=180,
        origin={-89,74})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=dTConFix)
    annotation (Placement(transformation(extent={{-126,-34},{-98,-12}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{11,-11},{-11,11}},
        rotation=180,
        origin={-55,-23})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
protected
parameter String FilenameCOP= if HighTemp==true then "modelica://AixLib/Resources/Data/Fluid/HeatPumps/NotManufacturer/COP_Hubkolben_R134a.sdf" else "modelica://AixLib/Resources/Data/Fluid/HeatPumps/NotManufacturer/COP_Scroll_R410a.sdf" annotation (evaluate=True);
equation
  connect(division1.y, PelFullLoad) annotation (Line(points={{21,-80},{110,
          -80}},              color={0,0,127}));
  connect(add.y, QEvapNom)
    annotation (Line(points={{85,20},{110,20}}, color={0,0,127}));
  connect(division1.y, add.u2) annotation (Line(points={{21,-80},{40,-80},{40,
          14},{62,14}}, color={0,0,127}));
  connect(tHotNom.y, fromKelvin2.Kelvin)
    annotation (Line(points={{-76.9,34},{-68,34}}, color={0,0,127}));
  connect(tSourceNom.y, fromKelvin3.Kelvin)
    annotation (Line(points={{-72.7,92},{-48,92}}, color={0,0,127}));
  connect(qNom.y, division1.u1)
    annotation (Line(points={{-31.2,-74},{-2,-74}}, color={0,0,127}));
  connect(add.u1, qNom1.y)
    annotation (Line(points={{62,26},{46.8,26}}, color={0,0,127}));
  connect(SDFCOP1.y, division1.u2) annotation (Line(points={{-10,-33.2},{-10,
          -86},{-2,-86}},     color={0,0,127}));
  connect(multiplex4_1.y, SDFCOP1.u)
    annotation (Line(points={{-10,1},{-10,-5.6}}, color={0,0,127}));
  connect(fromKelvin3.Celsius, multiplex4_1.u1[1]) annotation (Line(points={{-25,92},
          {-1,92},{-1,24}},                       color={0,0,127}));
  connect(PLRNom.y, multiplex4_1.u2[1])
    annotation (Line(points={{-76.9,74},{-7,74},{-7,24}}, color={0,0,127}));
  connect(deltaTCon.y, multiplex4_1.u3[1])
    annotation (Line(points={{-74.8,57},{-13,57},{-13,24}}, color={0,0,127}));
  connect(booleanExpression.y, switch2.u2)
    annotation (Line(points={{-96.6,-23},{-68.2,-23}}, color={255,0,255}));
  connect(fromKelvin2.Celsius, switch2.u3) annotation (Line(points={{-45,34},{-40,
          34},{-40,10},{-80,10},{-80,-14.2},{-68.2,-14.2}}, color={0,0,127}));
  connect(switch2.y, multiplex4_1.u4[1]) annotation (Line(points={{-42.9,-23},{-32,
          -23},{-32,38},{-19,38},{-19,24}}, color={0,0,127}));
  connect(u, switch2.u1) annotation (Line(points={{-120,-60},{-90,-60},{-90,-31.8},
          {-68.2,-31.8}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Auslegung des Betriebspunktes indem die maximale elektrische Leistung vorliegt</p>
</html>"));
end NominalHeatPumpNotManufacturer;
