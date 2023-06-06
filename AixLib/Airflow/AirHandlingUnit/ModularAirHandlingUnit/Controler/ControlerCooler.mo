within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Controler;
model ControlerCooler
  parameter Boolean activeDehumidifying=false
    "true if active dehumidifying is done in cooler";
  Modelica.Blocks.Interfaces.RealInput xSupSet(start=0.007)
    "max. set value for absolute humidity of supply air" annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent
          ={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput TsupSet(start=293.15)
    "set value for temperature at supply air outlet" annotation (Placement(
        transformation(extent={{-140,-40},{-100,0}}),   iconTransformation(
          extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-20})));
  Modelica.Blocks.Interfaces.RealInput Xout(start=0.01)
    "measured value for absolute humidity at cooler outlet" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-60})));
  Modelica.Blocks.Interfaces.RealOutput TcoolerSet
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
            10}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough if not activeDehumidifying
    annotation (Placement(transformation(extent={{52,-98},{72,-78}})));
  Modelica.Blocks.Math.Min min_X if activeDehumidifying
    annotation (Placement(transformation(extent={{12,-12},{32,8}})));
  //ThermalZones.ReducedOrder.Multizone.BaseClasses.RelToAbsHum relToAbsHum annotation (Placement(transformation(extent={{-72,44},{-52,64}})));
  Utilities.Psychrometrics.pW_X pWat(use_p_in=false)
    annotation (Placement(transformation(extent={{-58,-6},{-38,14}})));
  Utilities.Psychrometrics.TDewPoi_pW dewPoi
    annotation (Placement(transformation(extent={{-30,-6},{-10,14}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-8,70},{12,90}})));
  Modelica.Blocks.Logical.Switch switch1 if activeDehumidifying
    annotation (Placement(transformation(extent={{58,12},{78,32}})));
equation
  connect(TsupSet, min_X.u2) annotation (Line(points={{-120,-20},{4,-20},{4,-8},
          {10,-8}},  color={0,0,127}));
  connect(realPassThrough.y, TcoolerSet) annotation (Line(points={{73,-88},{82,
          -88},{82,0},{110,0}},                   color={0,0,127}));
  connect(TsupSet, realPassThrough.u) annotation (Line(points={{-120,-20},{30,
          -20},{30,-88},{50,-88}}, color={0,0,127}));
  connect(xSupSet, pWat.X_w) annotation (Line(points={{-120,60},{-64,60},{-64,4},
          {-59,4}}, color={0,0,127}));
  connect(pWat.p_w, dewPoi.p_w)
    annotation (Line(points={{-37,4},{-31,4}},color={0,0,127}));
  connect(dewPoi.T, min_X.u1) annotation (Line(points={{-9,4},{10,4}},
                    color={0,0,127}));
  connect(Xout, greater.u1) annotation (Line(points={{-120,-60},{-88,-60},{-88,
          80},{-10,80}},
                 color={0,0,127}));
  connect(xSupSet, greater.u2) annotation (Line(points={{-120,60},{-16,60},{-16,
          72},{-10,72}}, color={0,0,127}));
  connect(greater.y, switch1.u2) annotation (Line(points={{13,80},{50,80},{50,
          22},{56,22}}, color={255,0,255}));
  connect(min_X.y, switch1.u1)
    annotation (Line(points={{33,-2},{48,-2},{48,30},{56,30}},
                                                          color={0,0,127}));
  connect(TsupSet, switch1.u3) annotation (Line(points={{-120,-20},{50,-20},{50,
          14},{56,14}}, color={0,0,127}));
  connect(switch1.y, TcoolerSet) annotation (Line(points={{79,22},{82,22},{82,0},
          {110,0}},        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ControlerCooler;
