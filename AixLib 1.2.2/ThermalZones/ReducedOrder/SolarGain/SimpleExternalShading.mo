within AixLib.ThermalZones.ReducedOrder.SolarGain;
model SimpleExternalShading
  "Simple model to account for external shading for windows."

  parameter Integer nOrientations = 1 "Number of orientations (without ground)";
  parameter Real maxIrrs[nOrientations](each final unit="W/m2") "";
  parameter Real gValues[nOrientations](each final unit="1") "Weight factors of the windows";
  Modelica.Blocks.Logical.Switch switchShading[nOrientations]
    "Switches external shading."
    annotation (Placement(transformation(extent={{-12,-8},{8,12}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterShadingThreshold[
    nOrientations](final threshold=maxIrrs)
    "If irradiation is greater then threshold (u2) shading is applied."
    annotation (Placement(transformation(extent={{-60,-8},{-40,12}})));
  Modelica.Blocks.Sources.Constant noShading[nOrientations](each k=1)
    "Constant 1 for that no shading is applied. (Blinds fully opened)"
    annotation (Placement(transformation(extent={{-40,-32},{-28,-20}})));
  Modelica.Blocks.Sources.Constant gValueShading[nOrientations](k=gValues)
    "Factor to that the solar irradiation of the window is reduced by external shading (1 means no shading - 0 means no solar gains)."
    annotation (Placement(transformation(extent={{-40,24},{-28,36}})));
  Modelica.Blocks.Math.Product product[nOrientations]
    annotation (Placement(transformation(extent={{34,-2},{54,18}})));
  Modelica.Blocks.Interfaces.RealOutput corrIrr[nOrientations]
               "Corrected solar irradiation with external shading."
    annotation (Placement(transformation(extent={{88,-2},{108,18}})));
  Modelica.Blocks.Interfaces.RealInput solRadTot[nOrientations]
                                 "Total solar irradiation on tilted surface."
    annotation (Placement(transformation(extent={{-122,-18},{-82,22}})));
  Modelica.Blocks.Interfaces.RealInput solRadWin[nOrientations]
               "Solar irradiation to be corrected with external shading."
    annotation (Placement(transformation(extent={{-124,44},{-84,84}})));
  Modelica.Blocks.Interfaces.RealOutput shadingFactor[nOrientations]
                                 "Shading factors with external shading."
    annotation (Placement(transformation(extent={{92,-90},{112,-70}})));
equation
  connect(greaterShadingThreshold.y, switchShading.u2)
    annotation (Line(points={{-39,2},{-14,2}}, color={255,0,255}));
  connect(noShading.y, switchShading.u3) annotation (Line(points={{-27.4,-26},{
          -22,-26},{-22,-6},{-14,-6}},
                                   color={0,0,127}));
  connect(gValueShading.y, switchShading.u1) annotation (Line(points={{-27.4,30},
          {-22,30},{-22,10},{-14,10}}, color={0,0,127}));
  connect(switchShading.y, product.u2)
    annotation (Line(points={{9,2},{32,2}}, color={0,0,127}));
  connect(product.y, corrIrr)
    annotation (Line(points={{55,8},{98,8}}, color={0,0,127}));
  connect(product.u1, solRadWin) annotation (Line(points={{32,14},{28,14},{28,16},{20,16},
          {20,64},{-104,64}}, color={0,0,127}));
  connect(switchShading.y, shadingFactor) annotation (Line(points={{9,2},{20,2},
          {20,-80},{102,-80}},                   color={0,0,127}));
  connect(solRadTot, greaterShadingThreshold.u)
    annotation (Line(points={{-102,2},{-62,2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleExternalShading;
