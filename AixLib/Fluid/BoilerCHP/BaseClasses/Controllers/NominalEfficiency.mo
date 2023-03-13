within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model NominalEfficiency

   parameter Modelica.Units.SI.Temperature TColdNom=273.15 + 35
                                                              "Nominal TCold";
   parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Nominal thermal power";
   parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Nominal temperature difference heat circuit";

  Modelica.Blocks.Sources.RealExpression tColdNom(y=TColdNom)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-100,6},{-54,30}})));

  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{-20,8},{0,28}})));

  Modelica.Blocks.Sources.RealExpression deltaTNom(y=dTWaterNom)
    "Nominal temperature differences"
    annotation (Placement(transformation(extent={{-100,-64},{-50,-42}})));
  Modelica.Blocks.Sources.RealExpression qRel_mflow(y=1)
    "Nominal realtive water mass flow"
    annotation (Placement(transformation(extent={{-100,-20},{-54,4}})));
  Modelica.Blocks.Sources.RealExpression Dim_4(y=0)
    "Nominal temperature difference: measure-nominal"
    annotation (Placement(transformation(extent={{-100,-100},{-54,-76}})));
  Modelica.Blocks.Sources.RealExpression nominalLosses(y=QNom*0.003/50*(
        TColdNom + dTWaterNom))      "Nominal Heat Losses"
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
  Modelica.Blocks.Sources.RealExpression qRel_DeltaT(y=1)
    "Nominal realtive temperature difference"
    annotation (Placement(transformation(extent={{-102,-40},{-56,-16}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2
    annotation (Placement(transformation(extent={{18,-16},{38,4}})));
  SDF.NDTable boilerEffciency2(
    nin=4,
    readFromFile=true,
    filename=Filename,
    dataset="/ETA_Kennfeld",
    dataUnit="-",
    scaleUnits={"degC","K","-","K"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    annotation (Placement(transformation(extent={{54,-16},{74,4}})));
protected
  parameter String Filename="D:/mzu-sciebo/mzu/Dissertation/Paper/boiler-paper/Data/Temperaturen/Eta_Boiler_Temperaturen.sdf";
equation

  connect(tColdNom.y, fromKelvin.Kelvin)
    annotation (Line(points={{-51.7,18},{-22,18}}, color={0,0,127}));
  connect(nominalLosses.y, add.u1) annotation (Line(points={{-51.7,80},{-26,80},
          {-26,68},{-12,68}}, color={0,0,127}));
  connect(qNom.y, add.u2) annotation (Line(points={{-51.7,52},{-26,52},{-26,56},
          {-12,56}}, color={0,0,127}));
  connect(add.y, division.u1)
    annotation (Line(points={{11,62},{34,62}}, color={0,0,127}));
  connect(division.y, nominalPowerDemand)
    annotation (Line(points={{57,56},{110,56}}, color={0,0,127}));
  connect(multiplex4_2.y, boilerEffciency2.u)
    annotation (Line(points={{39,-6},{52,-6}}, color={0,0,127}));
  connect(boilerEffciency2.y, division.u2) annotation (Line(points={{75,-6},{96,
          -6},{96,26},{22,26},{22,50},{34,50}}, color={0,0,127}));
  connect(fromKelvin.Celsius, multiplex4_2.u1[1])
    annotation (Line(points={{1,18},{4,18},{4,3},{16,3}}, color={0,0,127}));
  connect(qRel_mflow.y, multiplex4_2.u3[1]) annotation (Line(points={{-51.7,-8},
          {-40,-8},{-40,-9},{16,-9}}, color={0,0,127}));
  connect(deltaTNom.y, multiplex4_2.u4[1]) annotation (Line(points={{-47.5,-53},
          {-20,-53},{-20,-15},{16,-15}}, color={0,0,127}));
  connect(deltaTNom.y, multiplex4_2.u2[1]) annotation (Line(points={{-47.5,-53},
          {-20,-53},{-20,-3},{16,-3}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model only calculates the efficiency for nominal conditions to &quot;set&quot; nominal fuel consuption [W].</p>
</html>"));
end NominalEfficiency;
