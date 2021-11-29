within ControlUnity.flowTemperatureController.renturnAdmixture;
model returnAdmixture
  "Flow temperature control with return admixture"
  parameter Integer k=1 "Number of heat curcuits";

  parameter Modelica.SIunits.Temperature T_flow "Flow temperature resulting from the return admixture for each heating curcuit";
  parameter Modelica.SIunits.Temperature TBoiler= 273.15+75 "Fix boiler temperature for the admixture";


  Modelica.Blocks.Interfaces.RealInput Tset[k]
    "Set temperatures for k heat curcuits"
    annotation (Placement(transformation(extent={{-120,-52},{-80,-12}})));
  Modelica.Blocks.Interfaces.RealOutput valPos[k]
    "Valve position for the k heat curcuits"
    annotation (Placement(transformation(extent={{90,-42},{110,-22}})));
  Modelica.Blocks.Interfaces.RealInput TMea[k]
    "Measurement temperatures for the k heat curcuits" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Continuous.LimPID PID[k](
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,36},{110,56}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,54},{-80,94}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{34,64},{54,84}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-14,56},{6,70}})));
  Modelica.Blocks.Interfaces.RealInput TMeaBoiler
    "Measured boiler temperature to keep the fixed temperature"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=TBoiler)
    annotation (Placement(transformation(extent={{-66,42},{-46,62}})));
  parameter Real bandwidth "Bandwidth around reference signal";
  Modelica.Blocks.Continuous.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=0.999,
    yMin=0) "PI Controller for controlling the valve position"
            annotation (Placement(transformation(extent={{-14,30},{6,50}})));
equation
  connect(isOn, switch1.u2) annotation (Line(points={{-100,74},{32,74}},
                     color={255,0,255}));
  connect(switch1.y, PLRset) annotation (Line(points={{55,74},{72,74},{72,46},{
          100,46}}, color={0,0,127}));
  connect(realExpression.y, switch1.u3) annotation (Line(points={{7,63},{18,63},
          {18,66},{32,66}}, color={0,0,127}));
  connect(realExpression1.y, PID1.u_s) annotation (Line(points={{-45,52},{-32,
          52},{-32,40},{-16,40}}, color={0,0,127}));
  connect(TMeaBoiler, PID1.u_m) annotation (Line(points={{-100,30},{-52,30},{
          -52,18},{-4,18},{-4,28}}, color={0,0,127}));
  connect(PID1.y, switch1.u1) annotation (Line(points={{7,40},{22,40},{22,82},{
          32,82}}, color={0,0,127}));
  connect(TMea, PID.u_m)
    annotation (Line(points={{0,-100},{0,-44}}, color={0,0,127}));
  connect(PID.y, valPos)
    annotation (Line(points={{11,-32},{100,-32}}, color={0,0,127}));
  connect(Tset, PID.u_s)
    annotation (Line(points={{-100,-32},{-12,-32}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture;
