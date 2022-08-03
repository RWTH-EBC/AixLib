within AixLib.BoundaryConditions.DomesticHotWater.TappingProfiles.BaseClasses;
partial model PartialcalcmFlowEqu
  "Calculate based on set temperature and actual temperature"
  extends BaseClasses.PartialDHW;
  Modelica.Blocks.Math.Division
                            division
    annotation (Placement(transformation(extent={{-8,-2},{12,-22}})));
  Modelica.Blocks.Math.Add dTSet(final k2=-1)
    annotation (Placement(transformation(extent={{-42,-80},{-22,-60}})));
  Modelica.Blocks.Sources.Constant constTCold(final k=TCold)
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Math.Add dTIs(final k2=-1)
    annotation (Placement(transformation(extent={{-42,-16},{-22,4}})));
  Modelica.Blocks.Math.Product
                            product
    annotation (Placement(transformation(extent={{64,10},{84,-10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{30,-22},{50,-2}})));
  Modelica.Blocks.Math.Add deltaLim(final k2=-1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,82})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowERROR
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Math.MultiProduct
                            multiProduct(nu=4)
    annotation (Placement(transformation(extent={{42,90},{62,70}})));
  Modelica.Blocks.Sources.Constant const_cp(final k=c_p_water)
    annotation (Placement(transformation(extent={{-46,88},{-26,108}})));
equation
  connect(TSet, dTSet.u1) annotation (Line(points={{-120,-60},{-64,-60},{-64,-64},
          {-44,-64}}, color={0,0,127}));
  connect(constTCold.y, dTSet.u2) annotation (Line(points={{-59,-90},{-52,-90},{
          -52,-76},{-44,-76}}, color={0,0,127}));
  connect(dTSet.y, division.u1) annotation (Line(points={{-21,-70},{-16,-70},
          {-16,-18},{-10,-18}}, color={0,0,127}));
  connect(dTIs.y, division.u2)
    annotation (Line(points={{-21,-6},{-10,-6}}, color={0,0,127}));
  connect(product.y, m_flow_out)
    annotation (Line(points={{85,0},{110,0}}, color={0,0,127}));
  connect(m_flow_in, product.u2) annotation (Line(points={{-120,60},{36,60},
          {36,6},{62,6}}, color={0,0,127}));
  connect(constTCold.y, dTIs.u2) annotation (Line(points={{-59,-90},{-52,
          -90},{-52,-12},{-44,-12}}, color={0,0,127}));
  connect(division.y, limiter.u)
    annotation (Line(points={{13,-12},{28,-12}}, color={0,0,127}));
  connect(limiter.y, product.u1) annotation (Line(points={{51,-12},{56,-12},
          {56,-6},{62,-6}}, color={0,0,127}));
  connect(division.y, deltaLim.u1) annotation (Line(points={{13,-12},{16,
          -12},{16,-10},{18,-10},{18,20},{-14,20},{-14,88},{-2,88}}, color=
          {0,0,127}));
  connect(limiter.y, deltaLim.u2) annotation (Line(points={{51,-12},{22,-12},
          {22,46},{-10,46},{-10,76},{-2,76}}, color={0,0,127}));
  connect(deltaLim.y, multiProduct.u[1]) annotation (Line(points={{21,82},{31.5,
          82},{31.5,82.625},{42,82.625}},    color={0,0,127}));
  connect(m_flow_in, multiProduct.u[2]) annotation (Line(points={{-120,60},{34,
          60},{34,80.875},{42,80.875}},   color={0,0,127}));
  connect(const_cp.y, multiProduct.u[3]) annotation (Line(points={{-25,98},{36,
          98},{36,79.125},{42,79.125}},   color={0,0,127}));
  connect(multiProduct.y, Q_flowERROR) annotation (Line(points={{63.7,80},{
          110,80},{110,80}}, color={0,0,127}));
  connect(dTSet.y, multiProduct.u[4]) annotation (Line(points={{-21,-70},{28,-70},
          {28,77.375},{42,77.375}},       color={0,0,127}));
end PartialcalcmFlowEqu;
