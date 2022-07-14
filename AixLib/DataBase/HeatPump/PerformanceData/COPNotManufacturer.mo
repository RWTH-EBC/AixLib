within AixLib.DataBase.HeatPump.PerformanceData;
model COPNotManufacturer


    parameter Boolean TSourceInternal=false
                                          "Use internal TSource?"
    annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

    parameter Boolean THotExternal=false "Use external THot?"
                                                             annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

      parameter Modelica.SIunits.Temperature TSource=280 "temperature of heat source"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
    parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

  parameter Real PLRMin=0.4 "Limit of PLR; less =0"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

 parameter Boolean HighTemp=false "true: THot > 60°C"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));


  SDF.NDTable sDF_COP(
    final nin=4,
    final readFromFile=true,
    final filename=FilenameCOP,
    final dataset="/COP",
    final dataUnit="-",
    final scaleUnits={"degC","-","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for COP" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={82,0})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={18,70})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,30})));
  Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom) annotation (
      Placement(transformation(
        extent={{-10,-9},{10,9}},
        rotation=0,
        origin={-66,-83})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={48,0})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin5
    annotation (Placement(transformation(extent={{9,-9},{-9,9}},
        rotation=180,
        origin={-9,-55})));
  Modelica.Blocks.Math.Add deltaTCon(k1=-1) annotation (Placement(
        transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-11,-3})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=
        TSourceInternal)
    annotation (Placement(transformation(extent={{-98,62},{-66,78}})));
  Modelica.Blocks.Sources.RealExpression tSource1(y=TSource) "TSource"
    annotation (Placement(transformation(extent={{-60,54},{-36,70}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-10,70})));
  Modelica.Blocks.Logical.Switch tConOut
    annotation (Placement(transformation(extent={{9,9},{-9,-9}},
        rotation=180,
        origin={-37,-55})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=THotExternal)
    annotation (Placement(transformation(extent={{-88,-72},{-62,-58}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-66,2})));
  Modelica.Blocks.Interfaces.RealInput pLR annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,30})));
  Modelica.Blocks.Interfaces.RealOutput COP  annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=180,
        origin={112,0})));
  Modelica.Blocks.Interfaces.RealInput tConIn annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-30})));
  Modelica.Blocks.Interfaces.RealInput tSource annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,90})));
  Modelica.Blocks.Interfaces.RealInput tConOutSet annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-90})));

protected
parameter String FilenameCOP="modelica:/AixLib/Resources/Data/Fluid/HeatPumps/NotManufacturer/COP_Scroll_R410a.sdf" annotation (evaluate=True);


equation

  connect(limiter.y,multiplex4_2. u2[1]) annotation (Line(points={{1,30},{28,30},
          {28,3},{36,3}},          color={0,0,127}));
  connect(fromKelvin1.Celsius,multiplex4_2. u1[1]) annotation (Line(points={{26.8,70},
          {30,70},{30,8},{36,8},{36,9}},           color={0,0,127}));
  connect(fromKelvin5.Celsius,multiplex4_2. u4[1]) annotation (Line(points={{0.9,-55},
          {8,-55},{8,-10},{36,-10},{36,-9}}, color={0,0,127}));
  connect(multiplex4_2.y,sDF_COP. u)
    annotation (Line(points={{59,0},{67.6,0}},      color={0,0,127}));
  connect(deltaTCon.y, multiplex4_2.u3[1])
    annotation (Line(points={{-1.1,-3},{36,-3}}, color={0,0,127}));
  connect(switch1.y,fromKelvin1. Kelvin) annotation (Line(points={{1,70},{8.4,70}},
                                                            color={0,0,127}));
  connect(tSource1.y, switch1.u1)
    annotation (Line(points={{-34.8,62},{-22,62}}, color={0,0,127}));
  connect(tConOut.y,fromKelvin5. Kelvin) annotation (Line(points={{-27.1,-55},{-19.8,
          -55}},                                                        color={0,
          0,127}));
  connect(tHotNom.y,tConOut. u3)
    annotation (Line(points={{-55,-83},{-47.8,-83},{-47.8,-62.2}},
                                                       color={0,0,127}));
  connect(booleanExpression2.y,tConOut. u2) annotation (Line(points={{-60.7,-65},
          {-54,-65},{-54,-55},{-47.8,-55}},                  color={255,0,255}));
  connect(fromKelvin5.Celsius, deltaTCon.u2) annotation (Line(points={{0.9,-55},
          {8,-55},{8,-18},{-28,-18},{-28,-8.4},{-21.8,-8.4}}, color={0,0,127}));
  connect(fromKelvin4.Celsius, deltaTCon.u1) annotation (Line(points={{-55,2},{-40,
          2},{-40,2.4},{-21.8,2.4}}, color={0,0,127}));
  connect(sDF_COP.y, COP)
    annotation (Line(points={{95.2,0},{112,0}}, color={0,0,127}));
  connect(pLR, limiter.u)
    annotation (Line(points={{-120,30},{-22,30}}, color={0,0,127}));
  connect(tConOutSet, tConOut.u1) annotation (Line(points={{-120,-90},{-94,-90},
          {-94,-47.8},{-47.8,-47.8}}, color={0,0,127}));
  connect(tConIn, fromKelvin4.Kelvin) annotation (Line(points={{-120,-30},{-84,-30},
          {-84,2},{-78,2}}, color={0,0,127}));
  connect(booleanExpression1.y, switch1.u2)
    annotation (Line(points={{-64.4,70},{-22,70}}, color={255,0,255}));
  connect(tSource, switch1.u3) annotation (Line(points={{-120,90},{-28,90},{-28,
          78},{-22,78}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
                                                              Text(
          extent={{22,-38},{90,-78}},
          lineColor={28,108,200},
          textString="THotNom oder variables THot"),          Text(
          extent={{-4,108},{64,68}},
          lineColor={28,108,200},
          textString="TSource konst oder variabel")}));
end COPNotManufacturer;
