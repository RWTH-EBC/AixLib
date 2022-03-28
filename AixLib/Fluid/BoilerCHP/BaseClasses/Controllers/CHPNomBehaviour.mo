within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model CHPNomBehaviour

parameter Modelica.SIunits.Power NomPower=100000;
parameter Boolean ElDriven=true;
parameter Real PLRMin=0.5;

 parameter String Filename_PowerEl_heat="modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/PowerEL_heat.sdf";
 parameter String Filename_PTHR= "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/Stromkennzahl.sdf";
 parameter String Filename_EtaEL= "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/EtaEL.sdf";



  SDF.NDTable SDF1(
    nin=2,
    readFromFile=true,
    filename=Filename_PTHR,
    dataset="/PTHR",
    dataUnit="[-]",
    scaleUnits={"W","-"})
      "Power to Heat Ratio"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex2_2
    annotation (Placement(transformation(extent={{-56,68},{-40,52}})));
  Modelica.Blocks.Sources.RealExpression pLRMin(y=PLRMin)
    "Nominal electric Power"
    annotation (Placement(transformation(extent={{-128,54},{-88,76}})));
  Modelica.Blocks.Math.Product pElMin
    annotation (Placement(transformation(extent={{-34,14},{-22,26}})));
  Modelica.Blocks.Math.Division heatMin
    annotation (Placement(transformation(extent={{12,8},{26,22}})));
  Modelica.Blocks.Interfaces.RealOutput MinThermalPower "maximal thermal Power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,16})));
  SDF.NDTable SDF3(
    nin=2,
    readFromFile=true,
    filename=Filename_PTHR,
    dataset="/PTHR",
    dataUnit="[-]",
    scaleUnits={"W","-"})
      "Power to Heat Ratio"
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{70,-76},{84,-62}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex2_1
    annotation (Placement(transformation(extent={{-18,-42},{-2,-58}})));
  Modelica.Blocks.Sources.RealExpression pelNom1(y=1)
    "Nominal electric Power"
    annotation (Placement(transformation(extent={{-92,-56},{-76,-36}})));
  Modelica.Blocks.Interfaces.RealOutput MaxThermalPower "maximal thermal Power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-70})));
  Modelica.Blocks.Sources.RealExpression nomPower(y=NomPower) "Nominal Power"
    annotation (Placement(transformation(extent={{-246,28},{-206,50}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=ElDriven)
    annotation (Placement(transformation(extent={{-250,0},{-230,20}})));
  SDF.NDTable electricNomPower(
    nin=1,
    readFromFile=true,
    filename=Filename_PowerEl_heat,
    dataset="/Power_el",
    dataUnit="W",
    scaleUnits={"W"})     "Electric nominal power"
    annotation (Placement(transformation(extent={{-184,-10},{-164,10}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=0,
        origin={-123,25})));
equation
  connect(multiplex2_2.u2[1], pLRMin.y) annotation (Line(points={{-57.6,64.8},{-57.6,
          65},{-86,65}},              color={0,0,127}));
  connect(pLRMin.y, pElMin.u1) annotation (Line(points={{-86,65},{-62,65},{-62,36},
          {-40,36},{-40,23.6},{-35.2,23.6}},
                               color={0,0,127}));
  connect(pElMin.y, heatMin.u1) annotation (Line(points={{-21.4,20},{10.6,20},{10.6,
          19.2}}, color={0,0,127}));
  connect(SDF1.y, heatMin.u2) annotation (Line(points={{1,60},{2,60},{2,12},{10.6,
          12},{10.6,10.8}}, color={0,0,127}));
  connect(heatMin.y, MinThermalPower)
    annotation (Line(points={{26.7,15},{110,16}}, color={0,0,127}));
  connect(pelNom1.y,multiplex2_1. u2[1]) annotation (Line(points={{-75.2,-46},{-19.6,
          -45.2}},                            color={0,0,127}));
  connect(multiplex2_1.y,SDF3. u) annotation (Line(points={{-1.2,-50},{18,-50}},
                                                   color={0,0,127}));
  connect(division2.y,MaxThermalPower)  annotation (Line(points={{84.7,-69},{96,
          -69},{96,-70},{110,-70}},
        color={0,0,127}));
  connect(SDF3.y,division2. u2) annotation (Line(points={{41,-50},{48,-50},{48,-73.2},
          {68.6,-73.2}},                             color={0,0,127}));
  connect(multiplex2_2.y, SDF1.u)
    annotation (Line(points={{-39.2,60},{-22,60}}, color={0,0,127}));
  connect(nomPower.y, switch2.u1) annotation (Line(points={{-204,39},{-152,39},{
          -152,32},{-136.2,32},{-136.2,33.8}}, color={0,0,127}));
  connect(booleanExpression.y, switch2.u2) annotation (Line(points={{-229,10},{-198,
          10},{-198,25},{-136.2,25}}, color={255,0,255}));
  connect(nomPower.y, electricNomPower.u[1]) annotation (Line(points={{-204,39},
          {-142,39},{-142,-50},{-158,-50},{-158,0},{-186,0}}, color={0,0,127}));
  connect(electricNomPower.y, switch2.u3) annotation (Line(points={{-163,0},{-154,
          0},{-154,-6},{-194,-6},{-194,16.2},{-136.2,16.2}}, color={0,0,127}));
  connect(switch2.y, multiplex2_2.u1[1]) annotation (Line(points={{-110.9,25},{-88,
          25},{-88,55.2},{-57.6,55.2}}, color={0,0,127}));
  connect(switch2.y, multiplex2_1.u1[1]) annotation (Line(points={{-110.9,25},{-54,
          25},{-54,-54.8},{-19.6,-54.8}}, color={0,0,127}));
  connect(switch2.y, division2.u1) annotation (Line(points={{-110.9,25},{-66,25},
          {-66,-28},{68.6,-28},{68.6,-64.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CHPNomBehaviour;
