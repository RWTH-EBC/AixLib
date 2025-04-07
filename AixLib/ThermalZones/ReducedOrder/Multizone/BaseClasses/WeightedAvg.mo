within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model WeightedAvg

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";


  Modelica.Blocks.Interfaces.RealInput
            u[numZones] "Connector of Real input signals" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput
             y "Connector of Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));



  Modelica.Blocks.Sources.Constant AZone[numZones](k=zoneParam.AZone)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Math.Product product[numZones]
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.Division division[numZones]
    annotation (Placement(transformation(extent={{28,40},{48,60}})));
  Modelica.Blocks.Math.MultiSum AZoneSum(nu=numZones)
    annotation (Placement(transformation(extent={{-18,38},{-6,50}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numZones)
    annotation (Placement(transformation(extent={{2,38},{14,50}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=numZones)
    annotation (Placement(transformation(extent={{60,-6},{72,6}})));
  Modelica.Blocks.Logical.Switch switch[numZones]
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.Constant const[numZones](k=0)
    annotation (Placement(transformation(extent={{-44,24},{-56,36}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant[numZones](k=zoneParam.withAHU)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
equation





  connect(u, product.u2) annotation (Line(points={{-120,0},{0,0},{0,-6},{18,-6}},
        color={0,0,127}));
  connect(division.y, product.u1)
    annotation (Line(points={{49,50},{56,50},{56,20},{0,20},{0,6},{18,6}},
                                                            color={0,0,127}));
  connect(AZoneSum.y, replicator.u)
    annotation (Line(points={{-4.98,44},{0.8,44}},    color={0,0,127}));
  connect(replicator.y, division.u2)
    annotation (Line(points={{14.6,44},{26,44}},   color={0,0,127}));
  connect(product.y, multiSum.u)
    annotation (Line(points={{41,0},{60,0}}, color={0,0,127}));
  connect(multiSum.y, y)
    annotation (Line(points={{73.02,0},{110,0}}, color={0,0,127}));
  connect(const.y, switch.u3) annotation (Line(points={{-56.6,30},{-68,30},{-68,
          42},{-62,42}}, color={0,0,127}));
  connect(AZone.y, switch.u1) annotation (Line(points={{-79,70},{-70,70},{-70,
          58},{-62,58}}, color={0,0,127}));
  connect(booleanConstant.y, switch.u2) annotation (Line(points={{-79,40},{-70,
          40},{-70,50},{-62,50}}, color={255,0,255}));
  connect(switch.y, AZoneSum.u) annotation (Line(points={{-39,50},{-30,50},{-30,
          44},{-18,44}}, color={0,0,127}));
  connect(switch.y, division.u1) annotation (Line(points={{-39,50},{-30,50},{
          -30,56},{26,56}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
                          Text(
          extent={{-64,56},{76,-48}},
          textColor={0,0,255},
          textString="weighted
ave")}),                                                         Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WeightedAvg;
