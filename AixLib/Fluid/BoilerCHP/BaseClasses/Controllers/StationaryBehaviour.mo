within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model StationaryBehaviour

   parameter Modelica.SIunits.Temperature TColdDim=273.15+ 35;
   parameter Modelica.SIunits.HeatFlowRate QNom=50000; // thermische Nennleistung [W]
   parameter AixLib.DataBase.Boiler.EtaTExhaust.EtaTExhaustBaseDataDefinition paramEta=AixLib.DataBase.Boiler.EtaTExhaust.Ambient1();
   parameter Real EtaTable[:,2]=paramEta.EtaTable;
   parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20; // Auslegungstemperaturdifferenz

   parameter Boolean m_flowVar=false;


  SDF.NDTable BoilerBehaviour_mNom(
    nin=3,
    readFromFile=true,
    filename=Filename,
    dataset="/ExhaustTemp",
    dataUnit="degC",
    scaleUnits={"degC","-","K"},
    interpMethod=SDF.Types.InterpolationMethod.Linear)
    annotation (Placement(transformation(extent={{-20,36},{0,56}})));

 Modelica.Blocks.Interfaces.RealInput PLR "Part Load Ratio"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Sources.RealExpression Dim1(y=TColdDim)
    "Return Water temperature Setpoint"
    annotation (Placement(transformation(extent={{-100,74},{-80,94}})));
  Modelica.Blocks.Interfaces.RealOutput T_exhaust(final quantity="Temperature",
      final unit="degC") "Exhaust temperature"
    annotation (Placement(transformation(extent={{100,36},{120,56}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(
    tableOnFile=false,
    table=EtaTable,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "Table with efficiency parameters"
    annotation (Placement(transformation(extent={{28,10},{48,30}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=1)
    annotation (Placement(transformation(extent={{-44,-2},{-24,18}})));
 Modelica.Blocks.Interfaces.RealInput QLosses "Thermal losses" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));

 Modelica.Blocks.Interfaces.RealInput dTWater "Calculated part load ratio"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));

  Modelica.Blocks.Interfaces.RealOutput PowerDemand(quantity="Power", final
      unit="W") "Power demand" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-36}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  Modelica.Blocks.Math.Add3 sumPowerDemand "Sum PowerDemand"
    annotation (Placement(transformation(extent={{44,-46},{64,-26}})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QNom) "Nominal heat flow"
    annotation (Placement(transformation(extent={{-102,-86},{-82,-66}})));
  Modelica.Blocks.Math.Product qSetPoint "Product QSetPoint"
    annotation (Placement(transformation(extent={{-68,-80},{-48,-60}})));
  Modelica.Blocks.Sources.RealExpression one(y=1) "number one"
    annotation (Placement(transformation(extent={{-72,-8},{-52,12}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-66,36},{-46,56}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{-66,74},{-46,94}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-40,-48},{-20,-28}})));
  Modelica.Blocks.Math.Product qSetPoint1
                                         "Product QSetPoint"
    annotation (Placement(transformation(extent={{0,-18},{16,-2}})));
protected
  parameter String Filename= if m_flowVar==false then "D:/dja-mzu/BoilerSDF/Stat/BoilerBehaviour_mNom.sdf" else "D:/dja-mzu/BoilerSDF/Stat/BoilerBehaviour_mVar.sdf";

equation


  connect(combiTable1D.y[1], add.u1) annotation (Line(points={{49,20},{54,20},{
          54,6},{-2,6},{-2,26},{-68,26},{-68,14},{-46,14}},  color={0,0,127}));
  connect(BoilerBehaviour_mNom.y, combiTable1D.u[1]) annotation (Line(points={{1,46},{
          16,46},{16,20},{26,20}},                      color={0,0,127}));
  connect(BoilerBehaviour_mNom.y, T_exhaust) annotation (Line(points={{1,46},{
          110,46}},                             color={0,0,127}));
  connect(PLR, qSetPoint.u1) annotation (Line(points={{-120,60},{-90,60},{-90,
          -64},{-70,-64}}, color={0,0,127}));
  connect(qNom.y, qSetPoint.u2)
    annotation (Line(points={{-81,-76},{-70,-76}}, color={0,0,127}));
  connect(one.y, add.u2) annotation (Line(points={{-51,2},{-46,2}},
        color={0,0,127}));
  connect(qSetPoint.y, sumPowerDemand.u2) annotation (Line(points={{-47,-70},{
          -6,-70},{-6,-36},{42,-36}},   color={0,0,127}));
  connect(QLosses, sumPowerDemand.u3)
    annotation (Line(points={{0,-120},{0,-44},{42,-44}}, color={0,0,127}));
  connect(sumPowerDemand.y, PowerDemand)
    annotation (Line(points={{65,-36},{110,-36}}, color={0,0,127}));
  connect(PLR, multiplex3_1.u2[1]) annotation (Line(points={{-120,60},{-90,60},
          {-90,46},{-68,46}}, color={0,0,127}));
  connect(dTWater, multiplex3_1.u3[1]) annotation (Line(points={{-120,20},{-80,
          20},{-80,39},{-68,39}}, color={0,0,127}));
  connect(multiplex3_1.y, BoilerBehaviour_mNom.u)
    annotation (Line(points={{-45,46},{-22,46}}, color={0,0,127}));
  connect(Dim1.y, fromKelvin.Kelvin)
    annotation (Line(points={{-79,84},{-68,84}}, color={0,0,127}));
  connect(fromKelvin.Celsius, multiplex3_1.u1[1]) annotation (Line(points={{-45,84},
          {-40,84},{-40,70},{-80,70},{-80,53},{-68,53}},     color={0,0,127}));
  connect(qSetPoint.y, division.u1) annotation (Line(points={{-47,-70},{-34,-70},
          {-34,-52},{-64,-52},{-64,-32},{-42,-32}}, color={0,0,127}));
  connect(combiTable1D.y[1], division.u2) annotation (Line(points={{49,20},{54,
          20},{54,-22},{-54,-22},{-54,-44},{-42,-44}}, color={0,0,127}));
  connect(qSetPoint1.y, sumPowerDemand.u1) annotation (Line(points={{16.8,-10},
          {24,-10},{24,-28},{42,-28}}, color={0,0,127}));
  connect(add.y, qSetPoint1.u1) annotation (Line(points={{-23,8},{-14,8},{-14,
          -5.2},{-1.6,-5.2}}, color={0,0,127}));
  connect(division.y, qSetPoint1.u2) annotation (Line(points={{-19,-38},{-8,-38},
          {-8,-14.8},{-1.6,-14.8}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model estimates the exhaust temperature. The adiabatic efficiency is a function of the exhaust temperature. The power demand is the sum of the ambient losses, the given thermal power of the setpoint and the exhaust losses.</p>
</html>"));
end StationaryBehaviour;
