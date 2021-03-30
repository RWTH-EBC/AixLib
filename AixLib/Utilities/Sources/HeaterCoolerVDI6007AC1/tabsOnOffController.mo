within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model tabsOnOffController
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Modelica.Blocks.Interfaces.RealOutput tabsHeatingPower
    annotation (Placement(transformation(extent={{120,10},{140,30}})));
  Modelica.Blocks.Interfaces.RealOutput tabsCoolingPower
    annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
  Modelica.Blocks.Sources.Constant off(k=0)
    annotation (Placement(transformation(extent={{20,-12},{40,8}})));
  Modelica.Blocks.Sources.Constant heatingPower
    annotation (Placement(transformation(extent={{20,32},{40,52}})));
  Modelica.Blocks.Sources.Constant coolingPower
    annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
equation
  connect(switch1.y, tabsHeatingPower)
    annotation (Line(points={{101,20},{130,20}}, color={0,0,127}));
  connect(switch2.y, tabsCoolingPower)
    annotation (Line(points={{101,-20},{130,-20}}, color={0,0,127}));
  connect(off.y, switch1.u3) annotation (Line(points={{41,-2},{64,-2},{64,12},{
          78,12}}, color={0,0,127}));
  connect(off.y, switch2.u3) annotation (Line(points={{41,-2},{64,-2},{64,-28},
          {78,-28}}, color={0,0,127}));
  connect(heatingPower.y, switch1.u1) annotation (Line(points={{41,42},{63.5,42},
          {63.5,28},{78,28}}, color={0,0,127}));
  connect(coolingPower.y, switch2.u1) annotation (Line(points={{41,-42},{56,-42},
          {56,-12},{78,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{120,100}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-120,-100},{120,100}})));
end tabsOnOffController;
