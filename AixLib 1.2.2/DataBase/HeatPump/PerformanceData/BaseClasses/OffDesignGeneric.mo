within AixLib.DataBase.HeatPump.PerformanceData.BaseClasses;
model OffDesignGeneric

    parameter Boolean TSourceInternal=false
                                          "Use internal TSource?"
    annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

   parameter Modelica.Units.SI.Temperature TSource=280 "temperature of heat source"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

   parameter Boolean FreDep=true "COP=f(compressor frequency)?";


  SDF.NDTable sDF_COP(
    final nin=4,
    final readFromFile=true,
    final filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/DataBase/HeatPump/PerformanceData/COP_Scroll_R410A.sdf"),
    final dataset="/COP",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
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
    annotation (Placement(transformation(extent={{-98,62},{-68,84}})));
  Modelica.Blocks.Sources.RealExpression tSource1(y=TSource) "TSource"
    annotation (Placement(transformation(extent={{-72,48},{-36,70}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-10,70})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-66,2})));
  Modelica.Blocks.Interfaces.RealInput frequency annotation (Placement(
        transformation(
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
  Modelica.Blocks.Interfaces.RealInput tConOut annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-90})));

  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=100, uMin=20)
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={4,28})));
  Modelica.Blocks.Sources.BooleanExpression FrequencyDependency(y=FreDep)
    annotation (Placement(transformation(extent={{-52,18},{-30,38}})));
  Modelica.Blocks.Sources.RealExpression DesFre(y=50) "design frequency 50 Hz"
    annotation (Placement(transformation(extent={{-50,32},{-32,52}})));
equation

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
    annotation (Line(points={{-34.2,59},{-34.2,62},{-22,62}},
                                                   color={0,0,127}));
  connect(fromKelvin5.Celsius, deltaTCon.u2) annotation (Line(points={{0.9,-55},
          {8,-55},{8,-18},{-28,-18},{-28,-8.4},{-21.8,-8.4}}, color={0,0,127}));
  connect(fromKelvin4.Celsius, deltaTCon.u1) annotation (Line(points={{-55,2},{-40,
          2},{-40,2.4},{-21.8,2.4}}, color={0,0,127}));
  connect(sDF_COP.y, COP)
    annotation (Line(points={{95.2,0},{112,0}}, color={0,0,127}));
  connect(tConIn, fromKelvin4.Kelvin) annotation (Line(points={{-120,-30},{-84,-30},
          {-84,2},{-78,2}}, color={0,0,127}));
  connect(booleanExpression1.y, switch1.u2)
    annotation (Line(points={{-66.5,73},{-66.5,72},{-32,72},{-32,70},{-22,70}},
                                                   color={255,0,255}));
  connect(tSource, switch1.u3) annotation (Line(points={{-120,90},{-28,90},{-28,
          78},{-22,78}}, color={0,0,127}));
  connect(tConOut, fromKelvin5.Kelvin) annotation (Line(points={{-120,-90},{-52,
          -90},{-52,-55},{-19.8,-55}}, color={0,0,127}));
  connect(frequency, limiter.u) annotation (Line(points={{-120,30},{-90,30}},
                                      color={0,0,127}));
  connect(DesFre.y, switch2.u3) annotation (Line(points={{-31.1,42},{-14,42},{-14,
          36},{-8,36}}, color={0,0,127}));
  connect(switch2.y, multiplex4_2.u2[1])
    annotation (Line(points={{15,28},{26,28},{26,3},{36,3}}, color={0,0,127}));
  connect(limiter.y, switch2.u1) annotation (Line(points={{-67,30},{-58,30},{-58,
          20},{-8,20}}, color={0,0,127}));
  connect(switch2.u2, FrequencyDependency.y)
    annotation (Line(points={{-8,28},{-28.9,28}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
                                                              Text(
          extent={{-4,108},{96,64}},
          lineColor={28,108,200},
          textString="TSource konst oder variabel"),          Text(
          extent={{36,56},{136,12}},
          lineColor={28,108,200},
          textString="COP=f(compressor frequency)?")}));
end OffDesignGeneric;
