within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Controler;
model ControlerHeatRecovery
  "controler for heat recovery system with fixed efficiency"

  parameter Real eps "efficiency of hrs";
  parameter Modelica.SIunits.TemperatureDifference dT_min
    "minimum temperature difference for which the hrs is switched off";

  Modelica.SIunits.Temperature T_airOutOda_max
    "outlet temperature with maximum heat recovery";

  Modelica.Blocks.Interfaces.RealInput T_airInEta(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of incoming exhaust air"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput T_airInOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of incoming otudoor air"
                                          annotation (Placement(transformation(extent={{-140,
            -80},{-100,-40}}),    iconTransformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Interfaces.BooleanOutput hrsOn
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput T_set(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Set temperature of supply air. Is used to limit heat recovery."
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,0})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=dT_min,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-60,50},{-40,30}})));
  Modelica.Blocks.Logical.OnOffController onOffController1(bandwidth=dT_min,
      pre_y_start=false)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
protected
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
  Modelica.Blocks.Sources.RealExpression T_out_max(y=T_airOutOda_max)
    annotation (Placement(transformation(extent={{-46,66},{-58,82}})));
protected
  Modelica.Blocks.Logical.LessEqual lessEqual
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  T_airOutOda_max = eps * (T_airInEta - T_airInOda) + T_airInOda;

  connect(T_set, onOffController.reference) annotation (Line(points={{-120,0},{-80,
          0},{-80,34},{-62,34}}, color={0,0,127}));
  connect(onOffController.y, logicalSwitch.u1) annotation (Line(points={{-39,40},
          {-26,40},{-26,8},{-18,8}}, color={255,0,255}));
  connect(T_out_max.y, onOffController.u) annotation (Line(points={{-58.6,74},{-80,
          74},{-80,46},{-62,46}}, color={0,0,127}));
  connect(logicalSwitch.y, hrsOn)
    annotation (Line(points={{5,0},{110,0}}, color={255,0,255}));
  connect(T_set, onOffController1.u) annotation (Line(points={{-120,0},{-80,0},{
          -80,-46},{-62,-46}}, color={0,0,127}));
  connect(T_out_max.y, onOffController1.reference) annotation (Line(points={{-58.6,
          74},{-80,74},{-80,-34},{-62,-34}}, color={0,0,127}));
  connect(onOffController1.y, logicalSwitch.u3) annotation (Line(points={{-39,-40},
          {-26,-40},{-26,-8},{-18,-8}}, color={255,0,255}));
  connect(T_airInOda, lessEqual.u1) annotation (Line(points={{-120,-60},{-80,-60},
          {-80,0},{-62,0}}, color={0,0,127}));
  connect(T_airInEta, lessEqual.u2) annotation (Line(points={{-120,60},{-80,60},
          {-80,-8},{-62,-8}}, color={0,0,127}));
  connect(lessEqual.y, logicalSwitch.u2)
    annotation (Line(points={{-39,0},{-18,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ControlerHeatRecovery;
