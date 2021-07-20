within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model heatTransferSwitcher
  "Outputs wheter heating or cooling was last active to switch between different heat transfer coefficients in Two Elements"
  Modelica.Blocks.Interfaces.RealInput pHeating
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput pCooling
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.BooleanOutput heatingOrCooling
    "True if heating was last active"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=-1, uHigh=1)
    "Outputs true if power input is positive (heating) and false if power input is negative (cooling)"
    annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
equation

  connect(pHeating, add.u1) annotation (Line(points={{-120,40},{-98,40},{-98,6},
          {-74,6}}, color={0,0,127}));
  connect(pCooling, add.u2) annotation (Line(points={{-120,-40},{-98,-40},{-98,
          -6},{-74,-6}}, color={0,0,127}));
  connect(add.y, hysteresis.u)
    annotation (Line(points={{-51,0},{-24,0}}, color={0,0,127}));
  connect(hysteresis.y, heatingOrCooling)
    annotation (Line(points={{-1,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end heatTransferSwitcher;
