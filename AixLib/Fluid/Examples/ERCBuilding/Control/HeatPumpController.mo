within AixLib.Fluid.Examples.ERCBuilding.Control;
model HeatPumpController

  parameter Integer n_cold=4 "Number of layers in cold storage";
  parameter Integer n_warm=4 "Number of layers in warm storage";

  parameter Real bandwidth_cold=2.5;

  parameter Real bandwidth_warm=2.5;

  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={0,-20})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-36,-5},{-26,5}})));
  Modelica.Blocks.Interfaces.BooleanOutput onOff
    "On/Off command to the heat pump, 'false'=off" annotation (Placement(
        transformation(
        rotation=270,
        extent={{-11.5,-11.5},{11.5,11.5}},
        origin={-0.5,-100.5})));
  Modelica.Blocks.Logical.Hysteresis hysteresisHeating(uLow=273.15 + 29,
      uHigh=273.15 + 33)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Interfaces.BooleanInput mode "'true'=cooling" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Logical.Hysteresis hysteresisCooling(uLow=273.15 + 10,
      uHigh=273.15 + 14) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,0})));
  Modelica.Blocks.Interfaces.RealInput condenserTemperature(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min=0,
    displayUnit="degC") "Temperature at condenser outlet"
    annotation (Placement(transformation(extent={{-183,-23},{-137,23}})));
  Modelica.Blocks.Interfaces.RealInput evaporatorTemperature(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min=0,
    displayUnit="degC") "Temperature at evaporator outlet" annotation (
      Placement(transformation(
        extent={{-23,-23},{23,23}},
        rotation=180,
        origin={160,0})));
  Modelica.Blocks.Interfaces.BooleanInput clearance
    "Indicates if the heat pump can be switched on, 'true'=cleared"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={70,100})));
  Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-62})));
equation
  connect(not2.y,logicalSwitch. u3) annotation (Line(
      points={{-25.5,0},{-4.8,0},{-4.8,-12.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not2.u, hysteresisHeating.y)
    annotation (Line(points={{-37,0},{-48,0},{-59,0}}, color={255,0,255}));
  connect(logicalSwitch.u2, mode) annotation (Line(points={{1.33227e-015,
          -12.8},{1.33227e-015,40},{0,40},{0,100}}, color={255,0,255}));
  connect(hysteresisCooling.y, logicalSwitch.u1) annotation (Line(points={{
          59,1.33227e-015},{4.8,1.33227e-015},{4.8,-12.8}}, color={255,0,
          255}));
  connect(condenserTemperature, hysteresisHeating.u)
    annotation (Line(points={{-160,0},{-160,0},{-82,0}}, color={0,0,127}));
  connect(evaporatorTemperature, hysteresisCooling.u)
    annotation (Line(points={{160,0},{82,0},{82,0}}, color={0,0,127}));
  connect(logicalSwitch.y, and1.u2) annotation (Line(points={{0,-26.6},{0,
          -32},{-8,-32},{-8,-50}}, color={255,0,255}));
  connect(and1.y, onOff) annotation (Line(points={{0,-73},{0,-100.5},{-0.5,
          -100.5}}, color={255,0,255}));
  connect(and1.u1, clearance) annotation (Line(points={{0,-50},{0,-40},{40,
          -40},{40,60},{70,60},{70,100}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(extent={{-160,-100},{160,100}},
          preserveAspectRatio=false)),           Icon(coordinateSystem(extent={{-160,
            -100},{160,100}}, preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-160,100},{160,-100}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-38,16},{56,-42}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Heat
Pump
Controller")}));
end HeatPumpController;
