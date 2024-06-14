within AixLib.Airflow.AirHandlingUnit;
model NoAHU "No AHU"
  extends AixLib.Airflow.AirHandlingUnit.BaseClasses.PartialAHU;
  Modelica.Blocks.Sources.Constant dummyPhi_supply(k=0.5)
    annotation (Placement(transformation(extent={{38,0},{56,18}})));
  Modelica.Blocks.Sources.Constant zeroVFlowOut(k(unit="m3/s") = 0)
    annotation (Placement(transformation(extent={{84,-76},{64,-56}})));
  Modelica.Blocks.Sources.Constant dummyT_supplyAirOut(k=293)
    annotation (Placement(transformation(extent={{38,48},{56,66}})));
  Modelica.Blocks.Sources.CombiTimeTable zeroPowerElAndHeat1(
    tableOnFile=false,
    table=[0,0.0],
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-94,-76},{-74,-56}})));
equation
  connect(dummyPhi_supply.y, phi_supply)
    annotation (Line(points={{56.9,9},{99,9}},         color={0,0,127}));
  connect(zeroVFlowOut.y, Vflow_out)
    annotation (Line(points={{63,-66},{54,-66},{54,-100}}, color={0,0,127}));
  connect(dummyT_supplyAirOut.y, T_supplyAirOut)
    annotation (Line(points={{56.9,57},{99,57},{99,57}},    color={0,0,127}));
  connect(zeroPowerElAndHeat1.y[1], QflowC) annotation (Line(points={{-73,-66},
          {-66,-66},{-62,-66},{-62,-100}}, color={0,0,127}));
  connect(zeroPowerElAndHeat1.y[1], QflowH) annotation (Line(points={{-73,-66},
          {-46,-66},{-22,-66},{-22,-100}}, color={0,0,127}));
  connect(zeroPowerElAndHeat1.y[1], Pel) annotation (Line(points={{-73,-66},{
          -28,-66},{18,-66},{18,-100}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
                              Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-40},{100,40}}), graphics={Text(
          extent={{-48,44},{48,14}},
          lineColor={28,108,200},
          textString="no AHU"), Text(
          extent={{-36,12},{32,-6}},
          lineColor={28,108,200},
          textString="(All outputs = 0)")}),
    Documentation(revisions="<html><ul>
  <li>
    <i>February, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Model implemented
  </li>
</ul>
</html>", info="<html>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">This model can be seen as
  a dummy. Connectors exist due to partialAHU but outputs are zero and
  inputs do not have any effect. As a conclusion it is easier to choose
  whether an AHU exist in a building or not. For an example see</span>
  <code>AixLib.Building.LowOrder.Examples.MultizoneExample</code><span style=\"font-family: MS Shell Dlg 2;\">.</span>
</p>
</html>"));
end NoAHU;
