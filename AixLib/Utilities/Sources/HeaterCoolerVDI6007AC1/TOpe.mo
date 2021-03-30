within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model TOpe
  "Operative temperature"
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,0})));
  Modelica.Blocks.Math.Gain gainTempOp(k=0.5)
    annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  Modelica.Blocks.Interfaces.RealOutput TOpe "Operative temperature as the average of the mean radiant and ambient air temperatures" annotation (Placement(
        transformation(extent={{-80,-20},{-120,20}}),  iconTransformation(
          extent={{-80,-20},{-120,20}})));
  Modelica.Blocks.Interfaces.RealInput TAir "Indoor air temperature from Thermal Zone"
    annotation (Placement(transformation(extent={{120,12},{80,52}})));
  Modelica.Blocks.Interfaces.RealInput TRad "Mean indoor radiation temperature from Thermal Zone"
    annotation (Placement(transformation(extent={{120,-50},{80,-10}})));
equation
  connect(gainTempOp.u, add.y) annotation (Line(points={{2,0},{12,0},{12,8.88178e-16},
          {19,8.88178e-16}}, color={0,0,127}));
  connect(gainTempOp.y, TOpe)
    annotation (Line(points={{-21,0},{-100,0}}, color={0,0,127}));
  connect(TAir, add.u1) annotation (Line(points={{100,32},{80,32},{80,6},{42,
          6}},
        color={0,0,127}));
  connect(TRad, add.u2) annotation (Line(points={{100,-30},{81,-30},{81,-6},{
          42,-6}},
                color={0,0,127}));
  annotation (Documentation(revisions="<html>
  <ul>
  <li>
  February 19, 2021, by Christian Wenzel:<br/>
  First implementation.
  </li>
  </ul>
</html>",   info="<html>
<p>This model calculates the operative temperature as the average of the mean radiant and ambient air temperatures.
  </p>
  </html>"),
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TOpe;
