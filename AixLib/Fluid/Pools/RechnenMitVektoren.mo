within AixLib.Fluid.Pools;
model RechnenMitVektoren

  parameter Integer nun          "Number of input connections QLat_flow"
    annotation (Dialog(connectorSizing=true), HideResult=true);

  parameter Integer num            "Number of input connections of T"
    annotation (Dialog(connectorSizing=true), HideResult=true);


  Modelica.Blocks.Interfaces.RealVectorInput T[num]( final unit= "K", final quantity = "Thermodynamical Temperature")
    annotation (Placement(transformation(extent={{-118,20},{-78,60}})));
  Modelica.Blocks.Interfaces.RealVectorInput Q_Lat[nun]( final unit = "W",final quantity = "HeatFlowRate")
    annotation (Placement(transformation(extent={{-116,-42},{-76,-2}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=nun)
    annotation (Placement(transformation(extent={{-30,-34},{-18,-22}})));
  BaseClasses.toH_fg toH_fg1(nu=num)
    annotation (Placement(transformation(extent={{-62,30},{-42,50}})));
  Modelica.Blocks.Math.MultiSum multiSum1( nu=nun)
    annotation (Placement(transformation(extent={{64,16},{76,28}})));
  BaseClasses.DivisionMI2MO divisionMI2MO(n=num)
    annotation (Placement(transformation(extent={{-2,6},{18,26}})));
equation


  connect(Q_Lat[:], multiSum.u[:]) annotation (Line(points={{-96,-22},{-64,-22},{-64,-28},
          {-30,-28}}, color={0,0,127}));

  connect( divisionMI2MO.y[:],multiSum1.u[:]) annotation (Line(points={{19,16},
          {44,16},{44,22},{64,22}},
                        color={0,0,127}));
  connect(T[:], toH_fg1.u[:]) annotation (Line(points={{-98,40},{-80,40},{-80,39.8},{
          -62.2,39.8}}, color={0,0,127}));
  connect(toH_fg1.y[:], divisionMI2MO.u2[:]) annotation (Line(points={{-41.8,39.8},
          {-23.9,39.8},{-23.9,10},{-4,10}}, color={0,0,127}));
  connect(Q_Lat[:], divisionMI2MO.u1[:]) annotation (Line(points={{-96,-22},{-52,
          -22},{-52,22},{-4,22}}, color={0,0,127}));
end RechnenMitVektoren;
