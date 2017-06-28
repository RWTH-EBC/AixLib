within AixLib.Fluid.Examples.DistrictHeating.Controller;
model StgCirController_TempBased
  "Storage circuit controller based on temperatures"

  Modelica.Blocks.Interfaces.BooleanInput OnOffSolPump annotation (Placement(
        transformation(extent={{-126,6},{-86,46}}), iconTransformation(extent=
           {{-106,18},{-82,42}})));
  Modelica.Blocks.Interfaces.RealInput FlowTempSol annotation (Placement(
        transformation(extent={{-126,-20},{-86,20}}), iconTransformation(
          extent={{-106,-14},{-82,10}})));
  Modelica.Blocks.Interfaces.RealInput StgTempBott annotation (Placement(
        transformation(extent={{-126,-48},{-86,-8}}), iconTransformation(
          extent={{-106,-46},{-82,-22}})));
  Modelica.Blocks.Math.Add add1(
                               k2=-1)
    annotation (Placement(transformation(extent={{-64,-13},{-48,3}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{16,16},{36,36}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{58,16},{78,36}})));
  Modelica.Blocks.Sources.Constant constMassFlow(k=8)
    annotation (Placement(transformation(extent={{16,48},{36,68}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=false,
    uLow=2,
    uHigh=5) annotation (Placement(transformation(extent={{-32,-13},{-16,3}})));
  Modelica.Blocks.Sources.Constant constMassFlow1(k=0)
    annotation (Placement(transformation(extent={{16,-14},{36,6}})));
  Modelica.Blocks.Interfaces.RealOutput MFStgCirPump annotation (Placement(
        transformation(extent={{92,-16},{124,16}}), iconTransformation(extent=
           {{92,-13},{118,13}})));
  Modelica.Blocks.Interfaces.BooleanOutput OnOffStgCirPump annotation (
      Placement(transformation(extent={{96,36},{124,64}}), iconTransformation(
          extent={{92,18},{118,44}})));
equation
  connect(FlowTempSol, add1.u1) annotation (Line(points={{-106,0},{-65.6,0},{
          -65.6,-0.2}}, color={0,0,127}));
  connect(StgTempBott, add1.u2) annotation (Line(points={{-106,-28},{-78,-28},
          {-78,-9.8},{-65.6,-9.8}}, color={0,0,127}));
  connect(OnOffSolPump, and1.u1)
    annotation (Line(points={{-106,26},{14,26}}, color={255,0,255}));
  connect(and1.y, switch1.u2)
    annotation (Line(points={{37,26},{46.5,26},{56,26}}, color={255,0,255}));
  connect(constMassFlow.y, switch1.u1) annotation (Line(points={{37,58},{46,
          58},{46,34},{56,34}}, color={0,0,127}));
  connect(add1.y, hysteresis.u)
    annotation (Line(points={{-47.2,-5},{-33.6,-5}}, color={0,0,127}));
  connect(hysteresis.y, and1.u2) annotation (Line(points={{-15.2,-5},{-4,-5},
          {-4,18},{14,18}}, color={255,0,255}));
  connect(constMassFlow1.y, switch1.u3) annotation (Line(points={{37,-4},{46,
          -4},{46,18},{56,18}}, color={0,0,127}));
  connect(MFStgCirPump, MFStgCirPump)
    annotation (Line(points={{108,0},{104.5,0},{108,0}}, color={0,0,127}));
  connect(switch1.y, MFStgCirPump) annotation (Line(points={{79,26},{84,26},{
          84,0},{108,0}}, color={0,0,127}));
  connect(and1.y, OnOffStgCirPump) annotation (Line(points={{37,26},{42,26},{
          42,50},{110,50}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={202,234,243},
          fillPattern=FillPattern.Solid), Text(
          extent={{-44,28},{48,-48}},
          lineColor={0,0,0},
          fillColor={202,234,243},
          fillPattern=FillPattern.Solid,
          textString="Storage Circuit
Controller
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end StgCirController_TempBased;
