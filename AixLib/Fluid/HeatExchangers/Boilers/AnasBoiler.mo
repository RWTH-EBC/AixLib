within AixLib.Fluid.HeatExchangers.Boilers;
model AnasBoiler
  replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium "Medium in the component"
        annotation (choicesAllMatching = true);

  replaceable model ExtControl =
   AixLib.Fluid.HeatExchangers.Boilers.BaseClasses.ExternalControl_nightDayHC
  constrainedby
    AixLib.Fluid.HeatExchangers.Boilers.BaseClasses.PartialExternalControl
    "ExternalControl"
   annotation (Dialog(tab="External Control"),choicesAllMatching=true);

parameter DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
  paramBoiler=
  DataBase.Boiler.General.Boiler_Vitogas200F_11kW() "Parameters for Boiler" annotation (Dialog(tab = "General", group = "Boiler type"), choicesAllMatching = true);

BaseClasses.PhysicalModel physicalModel(redeclare package Medium = Medium,
    paramBoiler=paramBoiler)
  annotation (Placement(transformation(extent={{-32,-62},{-6,-30}})));
BaseClasses.InternalControl internalControl(paramBoiler=paramBoiler)
  annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  //   BaseClasses.ExternalControl externalControl
  //     annotation (Placement(transformation(extent={{-30,12},{-10,32}})));
Modelica.Blocks.Interfaces.BooleanInput isOn "On/Off switch for the boiler"
  annotation (Placement(transformation(extent={{-106,18},{-66,58}}),
      iconTransformation(extent={{-100,26},{-80,46}})));
Modelica.Blocks.Interfaces.BooleanInput SwitchToNightMode
    "Connector of Boolean input signal"
                                      annotation (Placement(transformation(
        extent={{-106,46},{-66,86}}), iconTransformation(extent={{-100,60},{-80,
          80}})));
Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
      Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
  annotation (Placement(transformation(extent={{-94,-84},{-74,-64}}),
      iconTransformation(extent={{-94,-84},{-74,-64}})));
Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
      Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
  annotation (Placement(transformation(extent={{76,-84},{96,-64}}),
      iconTransformation(extent={{76,-84},{96,-64}})));
Modelica.Blocks.Interfaces.RealInput Toutside "Outside temperature [K]"
  annotation (Placement(transformation(extent={{-106,-24},{-66,16}}),
      iconTransformation(extent={{-100,-10},{-80,10}})));

ExtControl myExternalControl annotation (Placement(transformation(extent={{-30,12},{-10,32}})));
equation
if cardinality(isOn) < 2 then
  isOn = true;
end if;
  if cardinality(SwitchToNightMode) < 2 then
  SwitchToNightMode = false;
end if;

connect(internalControl.isOn, myExternalControl.isOn_Final) annotation (Line(
    points={{-22.475,0.275},{-22,0.275},{-22,4},{6,4},{6,23.8},{-9.8,23.8}},
    color={255,0,255},
    smooth=Smooth.None));

connect(myExternalControl.isOn, isOn) annotation (Line(
    points={{-29.9,24.25},{-55.8,24.25},{-55.8,38},{-86,38}},
    color={255,0,255},
    smooth=Smooth.None));
connect(myExternalControl.SwitchToNightMode, SwitchToNightMode) annotation (
    Line(
    points={{-29.95,27.625},{-52,27.625},{-52,66},{-86,66}},
    color={255,0,255},
    smooth=Smooth.None));
connect(internalControl.QflowHeater, physicalModel.QflowHeater) annotation (
    Line(
    points={{-30.05,-6.1},{-40,-6.1},{-40,-37.2},{-31.09,-37.2}},
    color={0,0,127},
    smooth=Smooth.None));

connect(myExternalControl.Tflow_set, internalControl.Tflow_set) annotation (
    Line(
    points={{-9.8,26.8},{6,26.8},{6,4},{-18,4},{-18,0.1125},{-17.9625,0.1125}},
    color={0,0,127},
    smooth=Smooth.None));
connect(physicalModel.Tflow_hot, myExternalControl.Tflow_is) annotation (Line(
    points={{-7.3,-31.28},{4,-31.28},{4,4},{-13.5,4},{-13.5,12.8}},
    color={0,0,127},
    smooth=Smooth.None));
connect(physicalModel.Tflow_hot, internalControl.Tflow_hot) annotation (Line(
    points={{-7.3,-31.28},{-7.3,-32},{4,-32},{4,-8.4},{-10,-8.4}},
    color={0,0,127},
    smooth=Smooth.None));
connect(physicalModel.Tflow_cold, internalControl.Tflow_cold) annotation (
    Line(
    points={{-7.3,-35.44},{4,-35.44},{4,-12},{-9.925,-12},{-9.925,-11.625}},
    color={0,0,127},
    smooth=Smooth.None));
connect(physicalModel.mFlow, internalControl.mFlow) annotation (Line(
    points={{-7.235,-40.16},{-7.235,-40},{4,-40},{4,-16},{-9.925,-16},{-9.925,
        -14.925}},
    color={0,0,127},
    smooth=Smooth.None));
connect(physicalModel.port_a, port_a) annotation (Line(
    points={{-32,-46},{-58,-46},{-58,-74},{-84,-74}},
    color={0,127,255},
    smooth=Smooth.None));
connect(physicalModel.port_b, port_b) annotation (Line(
    points={{-6,-46},{38,-46},{38,-74},{86,-74}},
    color={0,127,255},
    smooth=Smooth.None));
connect(myExternalControl.Toutside, Toutside) annotation (Line(
    points={{-29.725,18.4},{-57.8625,18.4},{-57.8625,-4},{-86,-4}},
    color={0,0,127},
    smooth=Smooth.None));
connect(port_b, port_b) annotation (Line(
    points={{86,-74},{86,-71},{86,-71},{86,-74}},
    color={0,127,255},
    smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
      Polygon(
        points={{20,-60},{60,-75},{20,-90},{20,-60}},
        lineColor={0,128,255},
        smooth=Smooth.None,
        fillColor={0,128,255},
        fillPattern=FillPattern.Solid,
        visible=showDesignFlowDirection),
      Polygon(
        points={{20,-65},{50,-75},{20,-85},{20,-65}},
        lineColor={255,255,255},
        smooth=Smooth.None,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        visible=allowFlowReversal),
      Line(
        points={{55,-75},{-60,-75}},
        color={0,128,255},
        smooth=Smooth.None,
        visible=showDesignFlowDirection),
      Rectangle(
        extent={{-40.5,84.5},{53.5,-47.5}},
        lineColor={0,0,0},
        fillPattern=FillPattern.VerticalCylinder,
        fillColor={170,170,255}),
      Polygon(
        points={{-12.5,-9.5},{-20.5,6.5},{1.5,50.5},{9.5,24.5},{31.5,28.5},{21.5,
            -13.5},{3.5,-9.5},{-2.5,-9.5},{-12.5,-9.5}},
        lineColor={0,0,0},
        fillPattern=FillPattern.Sphere,
        fillColor={255,127,0}),
      Rectangle(
        extent={{-20.5,-7.5},{33.5,-15.5}},
        lineColor={0,0,0},
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={192,192,192}),
      Polygon(
        points={{-10.5,-7.5},{-0.5,12.5},{25.5,-7.5},{-0.5,-7.5},{-10.5,-7.5}},
        lineColor={255,255,170},
        fillColor={255,255,170},
        fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This is a new model that couples a boiler model with a controler model. See individual components for more details on the models.</p>
<p>You can also refer to (among the latter slides): <a href=\"U:/FG_Modelica_Extern/Dokumentation_Hausmodelle/ShortPresentation_House_Models.ppt\">ShortPresentation_House_Models</a> for more details on the implemented control strategy. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"AutomationLibrary.Examples.HeatGenerators\">AutomationLibrary.Examples.HeatGenerators</a> </p>
</html>"));
end AnasBoiler;
