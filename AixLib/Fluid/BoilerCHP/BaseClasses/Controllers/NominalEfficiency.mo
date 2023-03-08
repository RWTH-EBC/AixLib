within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model NominalEfficiency

   parameter Modelica.Units.SI.Temperature TColdNom=273.15 + 35
                                                              "Nominal TCold";
   parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Nominal thermal power";
  parameter
    AixLib.DataBase.Boiler.NotManufacturer.EtaTExhaust.EtaTExhaustBaseDataDefinition
    paramEta=AixLib.DataBase.Boiler.NotManufacturer.EtaTExhaust.Ambient1();
   parameter Real EtaTable[:,2]=paramEta.EtaTable;
   parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Nominal temperature difference heat circuit";

  SDF.NDTable boilerEffciency(
    nin=5,
    readFromFile=true,
    filename=Filename,
    dataset="/ETA_Kennfeld",
    dataUnit="-",
    scaleUnits={"degC","-","-","K","K"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Modelica.Blocks.Sources.RealExpression Dim_1(y=TColdNom)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-100,6},{-54,30}})));

  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{-20,8},{0,28}})));

  Modelica.Blocks.Routing.Multiplex5 multiplex5_1
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression Dim4(y=dTWaterNom) "Nominal heat flow"
    annotation (Placement(transformation(extent={{-100,-64},{-50,-42}})));
  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}}),
        iconTransformation(extent={{-20,80},{20,120}})));
  Modelica.Blocks.Sources.RealExpression Dim_3(y=1)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-100,-40},{-54,-16}})));
  Modelica.Blocks.Sources.RealExpression Dim_4(y=0)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-100,-102},{-54,-78}})));
  Modelica.Blocks.Sources.RealExpression nominalLosses(y=QNom*0.003/50*(
        TColdNom + dTWaterNom - 20)) "Nominal Heat Losses"
    annotation (Placement(transformation(extent={{-100,68},{-54,92}})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QNom) "Nominal thermal power"
    annotation (Placement(transformation(extent={{-100,40},{-54,64}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{36,46},{56,66}})));
  Modelica.Blocks.Interfaces.RealOutput nominalPowerDemand(quantity="Power",
      final unit="W") "Power demand" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,56}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-70})));
protected
  parameter String Filename="D:/mzu-sciebo/mzu/Dissertation/Paper/boiler-paper/Data/Eta_Boiler.sdf";
equation

  connect(Dim_1.y, fromKelvin.Kelvin)
    annotation (Line(points={{-51.7,18},{-22,18}},  color={0,0,127}));
  connect(boilerEffciency.u, multiplex5_1.y)
    annotation (Line(points={{58,0},{41,0}}, color={0,0,127}));
  connect(fromKelvin.Celsius, multiplex5_1.u1[1]) annotation (Line(points={{1,18},{
          6,18},{6,10},{18,10}},                                 color={0,0,127}));
  connect(Dim4.y, multiplex5_1.u4[1]) annotation (Line(points={{-47.5,-53},{-20,
          -53},{-20,-5},{18,-5}},                         color={0,0,127}));
  connect(Dim_3.y, multiplex5_1.u2[1]) annotation (Line(points={{-51.7,-28},{-44,
          -28},{-44,5},{18,5}}, color={0,0,127}));
  connect(Dim_4.y, multiplex5_1.u5[1]) annotation (Line(points={{-51.7,-90},{-50,
          -90},{-50,-88},{0,-88},{0,-10},{18,-10}}, color={0,0,127}));
  connect(Dim_3.y, multiplex5_1.u3[1]) annotation (Line(points={{-51.7,-28},{-44,
          -28},{-44,0},{18,0}}, color={0,0,127}));
  connect(nominalLosses.y, add.u1) annotation (Line(points={{-51.7,80},{-26,80},
          {-26,68},{-12,68}}, color={0,0,127}));
  connect(qNom.y, add.u2) annotation (Line(points={{-51.7,52},{-26,52},{-26,56},
          {-12,56}}, color={0,0,127}));
  connect(add.y, division.u1)
    annotation (Line(points={{11,62},{34,62}}, color={0,0,127}));
  connect(boilerEffciency.y, division.u2) annotation (Line(points={{81,0},{92,0},
          {92,28},{20,28},{20,50},{34,50}}, color={0,0,127}));
  connect(division.y, nominalPowerDemand)
    annotation (Line(points={{57,56},{110,56}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model estimates the exhaust temperature. The adiabatic efficiency is a function of the exhaust temperature. The power demand is the sum of the ambient losses, the given thermal power of the setpoint and the exhaust losses.</p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/Boiler/Kennfeld_TAG_PLRvar_20K_mNom.png\"/></p>
</html>"));
end NominalEfficiency;
