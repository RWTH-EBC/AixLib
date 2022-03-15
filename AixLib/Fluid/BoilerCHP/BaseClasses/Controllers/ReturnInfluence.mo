within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ReturnInfluence

  parameter Modelica.SIunits.Temperature TColdNom=273.15+35 "Nominal TCold";
  parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Nominal thermal power";
  parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Nominal temperature difference heat circuit";
 parameter Boolean m_flowVar=false;


 Modelica.Blocks.Interfaces.RealInput TColdMeasure(final quantity=
        "ThermodynamicTemperature") "Measured temperature of Water return flow"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,70})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow(final quantity="Power", final
      unit="W")
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

 Modelica.Blocks.Interfaces.RealInput PLR "Part Load Ratio"
                                                 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  SDF.NDTable ReturnFlowBehaviour_mNom(
    nin=4,
    readFromFile=true,
    filename=Filename,
    dataset="/Eta_TCold",
    dataUnit="-",
    scaleUnits={"K","degC","-","K"},
    interpMethod=SDF.Types.InterpolationMethod.Linear)
    annotation (Placement(transformation(extent={{36,-4},{56,16}})));
  Modelica.Blocks.Sources.RealExpression tColdNom(y=TColdNom)
    "Return Water temperature Setpoint"
    annotation (Placement(transformation(extent={{-102,20},{-82,40}})));

  Modelica.Blocks.Math.Product etaCalculation
    "calculates the efficiency of the boiler" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={76,0})));
  Modelica.Blocks.Math.Add add(k1=1, k2=-1)
    annotation (Placement(transformation(extent={{-28,38},{-8,58}})));

 Modelica.Blocks.Interfaces.RealInput dTWater
    "temperature difference THot-TCold" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-70})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1
    annotation (Placement(transformation(extent={{4,-4},{24,16}})));
  Modelica.Blocks.Sources.RealExpression qSetpoint(y=QNom)
    "Return Water temperature Setpoint"
    annotation (Placement(transformation(extent={{-46,-30},{-26,-10}})));
  Modelica.Blocks.Math.Product etaCalculation1
    "calculates the efficiency of the boiler" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,-26})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{-68,60},{-48,80}})));
 Modelica.Blocks.Interfaces.RealInput QLosses "Thermal losses" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Math.Add add1(k1=1, k2=1)
    annotation (Placement(transformation(extent={{68,-64},{88,-44}})));
 parameter String Filename="modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/Boiler/Eta_TCold_mNom.sdf" annotation (Dialog(group="",loadSelector(filter="SDF Files (*.sdf);;All Files (*.*)", caption="Select SDF file")));


equation


  connect(tColdNom.y, fromKelvin.Kelvin)
    annotation (Line(points={{-81,30},{-72,30}}, color={0,0,127}));
  connect(add.y, multiplex4_1.u1[1]) annotation (Line(points={{-7,48},{0,48},{0,
          15},{2,15}},                            color={0,0,127}));
  connect(dTWater, multiplex4_1.u4[1]) annotation (Line(points={{-120,-70},{-60,
          -70},{-60,-3},{2,-3}}, color={0,0,127}));
  connect(PLR, multiplex4_1.u3[1]) annotation (Line(points={{-120,0},{-88,0},{
          -88,3},{2,3}},     color={0,0,127}));
  connect(fromKelvin.Celsius, multiplex4_1.u2[1]) annotation (Line(points={{-49,30},
          {-40,30},{-40,9},{2,9}},           color={0,0,127}));
  connect(multiplex4_1.y, ReturnFlowBehaviour_mNom.u)
    annotation (Line(points={{25,6},{34,6}},     color={0,0,127}));
  connect(qSetpoint.y, etaCalculation1.u1)
    annotation (Line(points={{-25,-20},{-2,-20}},            color={0,0,127}));
  connect(PLR, etaCalculation1.u2) annotation (Line(points={{-120,0},{-88,0},{
          -88,-32},{-2,-32}},color={0,0,127}));
  connect(fromKelvin.Celsius, add.u2) annotation (Line(points={{-49,30},{-40,30},
          {-40,42},{-30,42}}, color={0,0,127}));
  connect(etaCalculation1.y, etaCalculation.u2) annotation (Line(points={{21,-26},
          {58,-26},{58,-6},{64,-6}}, color={0,0,127}));
  connect(ReturnFlowBehaviour_mNom.y, etaCalculation.u1)
    annotation (Line(points={{57,6},{64,6}}, color={0,0,127}));
  connect(TColdMeasure, fromKelvin1.Kelvin)
    annotation (Line(points={{-120,70},{-70,70}}, color={0,0,127}));
  connect(fromKelvin1.Celsius, add.u1) annotation (Line(points={{-47,70},{-40,
          70},{-40,54},{-30,54}}, color={0,0,127}));
  connect(etaCalculation.y, add1.u1) annotation (Line(points={{87,0},{92,0},{92,
          -38},{60,-38},{60,-48},{66,-48}}, color={0,0,127}));
  connect(QLosses, add1.u2)
    annotation (Line(points={{0,-120},{0,-60},{66,-60}}, color={0,0,127}));
  connect(add1.y, Q_flow) annotation (Line(points={{89,-54},{98,-54},{98,0},{
          110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This Model calculates the change of efficiency and heat flow in case of TCold is different from nominal TCold. For example, if TCold decreases the exhaust temperature will decrease as well and the heatflow increases.</p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/Boiler/Kennfeld_EtaRL_TRL30_PLRvar_20K_mNom.png\"/></p>
</html>"),
    experiment(StopTime=86400, __Dymola_NumberOfIntervals=3600));
end ReturnInfluence;
