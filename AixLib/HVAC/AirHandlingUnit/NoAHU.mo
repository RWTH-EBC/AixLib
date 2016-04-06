within AixLib.HVAC.AirHandlingUnit;
model NoAHU "If no AHU should exist at all"
  extends BaseClasses.partialAHU;
  Modelica.Blocks.Sources.Constant zeroPowerElAndHeat(k(unit="W") = 0)
    annotation (Placement(transformation(extent={{-92,-76},{-72,-56}})));
  Modelica.Blocks.Sources.Constant dummyPhi_supply(k=0.5)
    annotation (Placement(transformation(extent={{38,0},{56,18}})));
  Modelica.Blocks.Sources.Constant zeroVFlowOut(k(unit="m3/s") = 0)
    annotation (Placement(transformation(extent={{84,-76},{64,-56}})));
  Modelica.Blocks.Sources.Constant dummyT_supplyAirOut(k=293)
    annotation (Placement(transformation(extent={{38,48},{56,66}})));
equation
  connect(zeroPowerElAndHeat.y, QflowC) annotation (Line(points={{-71,-66},{-62,
          -66},{-62,-100}}, color={0,0,127}));
  connect(zeroPowerElAndHeat.y, QflowH) annotation (Line(points={{-71,-66},{-22,
          -66},{-22,-100}}, color={0,0,127}));
  connect(zeroPowerElAndHeat.y, Pel)
    annotation (Line(points={{-71,-66},{18,-66},{18,-100}}, color={0,0,127}));
  connect(dummyPhi_supply.y, phi_supply)
    annotation (Line(points={{56.9,9},{99,9}},         color={0,0,127}));
  connect(zeroVFlowOut.y, Vflow_out)
    annotation (Line(points={{63,-66},{54,-66},{54,-100}}, color={0,0,127}));
  connect(dummyT_supplyAirOut.y, T_supplyAirOut)
    annotation (Line(points={{56.9,57},{74.45,57},{99,57}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -20},{100,60}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-20},{100,60}}), graphics={Text(
          extent={{-48,50},{48,20}},
          lineColor={28,108,200},
          textString="no AHU"), Text(
          extent={{-36,18},{32,0}},
          lineColor={28,108,200},
          textString="(All outputs = 0)")}),
    Documentation(revisions="<html>
<ul>
<li><i><span style=\"font-family: MS Shell Dlg 2;\">February, 2016&nbsp;</i> by Philipp Mehrfeld:<br>Model implemented</span></li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This model can be seen as a dummy. Connectors exist due to partialAHU but outputs are zero and inputs do not have any effect. As a conclusion it is easier to choose whether an AHU exist in a building or not. For an example see </span><code>AixLib.Building.LowOrder.Examples.MultizoneExample</code><span style=\"font-family: MS Shell Dlg 2;\">.</span></p>
</html>"));
end NoAHU;
