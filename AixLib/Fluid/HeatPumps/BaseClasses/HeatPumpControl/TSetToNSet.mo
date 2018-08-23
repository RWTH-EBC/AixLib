within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl;
block TSetToNSet
  "Converts a desired temperature to a certain compressor speed"

  AixLib.Utilities.Logical.SmoothSwitch swiNull "If an error occurs, the value of the conZero block will be used(0)"
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Blocks.Sources.Constant conZer(k=0) "If an error occurs, the compressor speed is set to zero"
    annotation (Placement(transformation(extent={{38,-24},{50,-12}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set temperature"
    annotation (Placement(transformation(extent={{-130,26},{-100,56}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-128,-40},{-94,-10}})));
  Modelica.Blocks.Sources.Constant conOne(k=1) "Constant one for on off heat pump" annotation (Placement(transformation(extent={{38,14},{50,26}})));
  parameter Real hys "Hysteresis of controller";
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=hys, pre_y_start=false) "Hysteresis controller for set temperature"
    annotation (Placement(transformation(extent={{2,-14},{30,14}})));
  Utilities.Logical.SmoothSwitch swiTCon "Choose which temperature is control variable" annotation (Placement(transformation(extent={{-38,-22},
            {-14,2}})));
  Modelica.Blocks.Sources.BooleanConstant constBoolTCon(final k=use_TSupply) "Boolean evaluating which temperature is control variable"
    annotation (Placement(transformation(extent={{-74,-14},{-64,-4}})));
  parameter Boolean use_TSupply=true "True if supply temperature is control variable and false if return temperature is control value" annotation(choices(checkBox=true));
equation
  connect(conZer.y, swiNull.u3) annotation (Line(points={{50.6,-18},{58,-18},{58,-8},{64,-8}},
                           color={0,0,127}));
  connect(swiNull.y, nOut) annotation (Line(points={{87,0},{110,0}},
                            color={0,0,127}));
  connect(conOne.y, swiNull.u1) annotation (Line(points={{50.6,20},{58,20},{58,8},{64,8}}, color={0,0,127}));
  connect(TSet, onOffController.reference) annotation (Line(points={{-115,41},{-8,41},{-8,8.4},{-0.8,8.4}},          color={0,0,127}));
  connect(swiTCon.y, onOffController.u) annotation (Line(points={{-12.8,-10},{
          -8,-10},{-8,-8.4},{-0.8,-8.4}},                                                                 color={0,0,127}));
  connect(sigBusHP.T_ret_co, swiTCon.u1) annotation (Line(
      points={{-110.915,-24.925},{-90.5,-24.925},{-90.5,-0.4},{-40.4,-0.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_flow_co, swiTCon.u3) annotation (Line(
      points={{-110.915,-24.925},{-90.5,-24.925},{-90.5,-19.6},{-40.4,-19.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(onOffController.y, swiNull.u2) annotation (Line(points={{31.4,0},{64,0}}, color={255,0,255}));
  connect(constBoolTCon.y, swiTCon.u2) annotation (Line(points={{-63.5,-9},{
          -51.75,-9},{-51.75,-10},{-40.4,-10}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TSetToNSet;
