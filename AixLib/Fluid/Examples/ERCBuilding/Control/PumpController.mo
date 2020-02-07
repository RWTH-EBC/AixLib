within AixLib.Fluid.Examples.ERCBuilding.Control;
model PumpController

//   parameter Integer n_cold = 5;
//
//   parameter Integer n_heat = 5;

  parameter Real pump_delay = 600;

//   parameter Real bandwidth_warm = 2.5;

//   parameter Real setPoint_cold = 35;

//   parameter Real setPoint_warm = 11.5;

//   parameter String inputFileName="modelicaSchedule.txt"
//     "File on which data is present";

  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=
        pump_delay)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant const3(
                                         k=0)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Blocks.Interfaces.BooleanInput HeatPump_OnOff
    "OnOff signal from heat pump"
    annotation (Placement(transformation(extent={{-114,-84},{-86,-56}})));
  Modelica.Blocks.Interfaces.RealInput MassFlow_In
    annotation (Placement(transformation(extent={{-114,58},{-86,86}})));
  Modelica.Blocks.Interfaces.RealOutput MassFlow_Out annotation (Placement(
        transformation(extent={{86,-14},{114,14}}), iconTransformation(extent=
           {{90,-10},{110,10}})));
equation
  connect(timer.y,greaterThreshold1. u) annotation (Line(points={{-29,0},{-29,
          0},{-22,0}},               color={0,0,127}));
  connect(greaterThreshold1.y,switch2. u2)
    annotation (Line(points={{1,0},{1,0},{18,0}},    color={255,0,255}));
  connect(timer.u, not1.y)
    annotation (Line(points={{-52,0},{-59,0}}, color={255,0,255}));
  connect(const3.y, switch2.u1) annotation (Line(points={{-9,30},{10,30},{10,
          8},{18,8}}, color={0,0,127}));
  connect(switch2.y, switch1.u3) annotation (Line(points={{41,0},{50,0},{50,
          -8},{58,-8}}, color={0,0,127}));
  connect(MassFlow_Out, MassFlow_Out) annotation (Line(points={{100,
          1.77636e-015},{100,1.77636e-015}}, color={0,0,127}));
  connect(switch1.y, MassFlow_Out)
    annotation (Line(points={{81,0},{100,0},{100,0}}, color={0,0,127}));
  connect(MassFlow_In, switch1.u1) annotation (Line(points={{-100,72},{-34,72},
          {50,72},{50,8},{58,8}}, color={0,0,127}));
  connect(switch2.u3, MassFlow_In) annotation (Line(points={{18,-8},{10,-8},{
          10,-20},{-90,-20},{-90,72},{-100,72}}, color={0,0,127}));
  connect(not1.u, HeatPump_OnOff) annotation (Line(points={{-82,0},{-90,0},{
          -90,-70},{-100,-70}}, color={255,0,255}));
  connect(switch1.u2, HeatPump_OnOff) annotation (Line(points={{58,0},{48,0},
          {48,-70},{-100,-70}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false)),           Icon(coordinateSystem(extent={{-100,
            -100},{100,100}}, preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-44,30},{46,-26}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Pump
Controller")}));
end PumpController;
