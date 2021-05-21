within AixLib.Fluid.BoilerCHP.BaseClasses;
model NominalBehaviourNotManufacturer



  parameter Modelica.SIunits.Power PelNom=100000;

    parameter String Filename_PTHR= "D:/dja-mzu/SDF/BHKW/Stromkennzahl.sdf";
   parameter String Filename_EtaEL= "D:/dja-mzu/SDF/BHKW/EtaEL.sdf";
     parameter String Filename_RCW= "D:/dja-mzu/SDF/BHKW/RatioCoolingWater.sdf";

parameter Modelica.SIunits.TemperatureDifference deltaTHeatingCircuit=20 "Nominal temperature difference heat circuit";

parameter Modelica.SIunits.TemperatureDifference deltaTCoolingCircuit=3.47 "Nominal temperature difference heat circuit";



  SDF.NDTable SDFStromkennzahl(
    nin=2,
    readFromFile=true,
    filename=Filename_PTHR,
    dataset="/PTHR",
    dataUnit="[-]",
    scaleUnits={"W","-"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    data=SDF.Functions.readTableData(
        SDFStromkennzahl.filename,
        SDFStromkennzahl.dataset,
        SDFStromkennzahl.dataUnit,
        SDFStromkennzahl.scaleUnits)) "Gibt die Stromkennzahl aus"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex2_1
    annotation (Placement(transformation(extent={{-60,40},{-40,20}})));
  Modelica.Blocks.Sources.RealExpression PLRNominal(y=1) "Nominal PLR"
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
  Modelica.Blocks.Sources.RealExpression pelNom(y=PelNom)
    "Nominal electric Power"
    annotation (Placement(transformation(extent={{-100,14},{-84,34}})));
  SDF.NDTable SDFEta(
    nin=2,
    readFromFile=true,
    filename=Filename_EtaEL,
    dataset="/EtaEL",
    dataUnit="-",
    scaleUnits={"W","-"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    data=SDF.Functions.readTableData(
        SDFStromkennzahl.filename,
        SDFStromkennzahl.dataset,
        SDFStromkennzahl.dataUnit,
        SDFStromkennzahl.scaleUnits)) "Electrical Efficiency"
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Interfaces.RealOutput mWaterCC
    "Water mass flow cooling circuit"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{20,26},{34,40}})));
  SDF.NDTable SDFRatioCoolingWater(
    nin=2,
    readFromFile=true,
    filename=Filename_RCW,
    dataset="/RatioCoolingWater",
    dataUnit="-",
    scaleUnits={"W","-"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    data=SDF.Functions.readTableData(
        SDFStromkennzahl.filename,
        SDFStromkennzahl.dataset,
        SDFStromkennzahl.dataUnit,
        SDFStromkennzahl.scaleUnits)) "Ratio Cooling Water"
    annotation (Placement(transformation(extent={{-20,-68},{0,-48}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{32,-20},{46,-6}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{50,-60},{64,-46}})));
  Modelica.Blocks.Sources.RealExpression TempDiffCC(y=4180*deltaTCoolingCircuit)
    "Temperature difference Cooling Water Engine"
    annotation (Placement(transformation(extent={{46,-90},{66,-70}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{78,-64},{92,-50}})));
  Modelica.Blocks.Interfaces.RealOutput dTCCNom
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Division division4
    annotation (Placement(transformation(extent={{78,-6},{92,8}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{76,-32},{90,-18}})));
  Modelica.Blocks.Sources.RealExpression TempDiffCC1(y=4180)
    "Temperature difference Cooling Water Engine"
    annotation (Placement(transformation(extent={{12,-40},{32,-20}})));
equation
  connect(multiplex2_1.y, SDFStromkennzahl.u)
    annotation (Line(points={{-39,30},{-22,30}},   color={0,0,127}));
  connect(PLRNominal.y, multiplex2_1.u2[1]) annotation (Line(points={{-79,44},{-72,
          44},{-72,36},{-62,36}},                    color={0,0,127}));
  connect(pelNom.y, multiplex2_1.u1[1]) annotation (Line(points={{-83.2,24},{-62,
          24}},                         color={0,0,127}));
  connect(multiplex2_1.y, SDFEta.u) annotation (Line(points={{-39,30},{-30,30},{
          -30,-10},{-22,-10}},  color={0,0,127}));
  connect(SDFStromkennzahl.y, division.u2) annotation (Line(points={{1,30},{10,30},
          {10,28.8},{18.6,28.8}}, color={0,0,127}));
  connect(pelNom.y, division.u1) annotation (Line(points={{-83.2,24},{-80,24},{-80,
          10},{-112,10},{-112,60},{12,60},{12,37.2},{18.6,37.2}}, color={0,0,127}));
  connect(multiplex2_1.y, SDFRatioCoolingWater.u) annotation (Line(points={{-39,30},
          {-30,30},{-30,-58},{-22,-58}},           color={0,0,127}));
  connect(SDFEta.y, division1.u2) annotation (Line(points={{1,-10},{14,-10},{14,
          -17.2},{30.6,-17.2}}, color={0,0,127}));
  connect(pelNom.y, division1.u1) annotation (Line(points={{-83.2,24},{-80,24},{
          -80,10},{20,10},{20,-8.8},{30.6,-8.8}},  color={0,0,127}));
  connect(division1.y, product.u1) annotation (Line(points={{46.7,-13},{62,-13},
          {62,-28},{40,-28},{40,-48.8},{48.6,-48.8}}, color={0,0,127}));
  connect(SDFRatioCoolingWater.y, product.u2) annotation (Line(points={{1,-58},
          {24,-58},{24,-57.2},{48.6,-57.2}}, color={0,0,127}));
  connect(product.y, division2.u1) annotation (Line(points={{64.7,-53},{76.6,
          -53},{76.6,-52.8}}, color={0,0,127}));
  connect(TempDiffCC.y, division2.u2) annotation (Line(points={{67,-80},{68,-80},
          {68,-78},{72,-78},{72,-62},{76.6,-62},{76.6,-61.2}}, color={0,0,127}));
  connect(division2.y, mWaterCC) annotation (Line(points={{92.7,-57},{96,-57},{
          96,-60},{110,-60}}, color={0,0,127}));
  connect(division4.y, dTCCNom) annotation (Line(points={{92.7,1},{96.35,1},{
          96.35,0},{110,0}}, color={0,0,127}));
  connect(division.y, division4.u1) annotation (Line(points={{34.7,33},{70,33},
          {70,5.2},{76.6,5.2}}, color={0,0,127}));
  connect(product1.y, division4.u2) annotation (Line(points={{90.7,-25},{98,-25},
          {98,-12},{66,-12},{66,-3.2},{76.6,-3.2}}, color={0,0,127}));
  connect(division2.y, product1.u2) annotation (Line(points={{92.7,-57},{100,
          -57},{100,-38},{68,-38},{68,-29.2},{74.6,-29.2}}, color={0,0,127}));
  connect(TempDiffCC1.y, product1.u1) annotation (Line(points={{33,-30},{54,-30},
          {54,-22},{74.6,-22},{74.6,-20.8}},                   color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end NominalBehaviourNotManufacturer;
