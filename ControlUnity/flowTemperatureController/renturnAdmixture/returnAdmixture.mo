within ControlUnity.flowTemperatureController.renturnAdmixture;
model returnAdmixture
  "Flow temperature control with return admixture"
  parameter Integer k=1 "Number of heat curcuits";

  parameter Modelica.SIunits.Temperature T_flow "Flow temperature resulting from the return admixture for each heating curcuit";
  parameter Modelica.SIunits.Temperature TBoiler= 273.15+75 "Fix boiler temperature for the admixture";


  Modelica.Blocks.Interfaces.RealInput Tset
    "Set temperatures for k heat curcuits"
    annotation (Placement(transformation(extent={{-120,-82},{-80,-42}})));
  Modelica.Blocks.Interfaces.RealOutput valPos
    "Valve position for the k heat curcuits"
    annotation (Placement(transformation(extent={{90,-72},{110,-52}})));
  Modelica.Blocks.Interfaces.RealInput TMea
    "Measurement temperatures for the k heat curcuits" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-10,-72},{10,-52}})));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,68},{-80,108}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,36},{110,56}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,38},{-80,78}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-72,52},{-52,66}})));
  Modelica.Blocks.Interfaces.RealInput TMeaBoiler
    "Measured boiler temperature to keep the fixed temperature"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Logical.OnOffController onOffController(pre_y_start=false,
      bandwidth=bandwidth)
    annotation (Placement(transformation(extent={{8,36},{28,56}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=TBoiler)
    annotation (Placement(transformation(extent={{-24,42},{-4,62}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{52,36},{72,56}})));
  Modelica.Blocks.Sources.RealExpression realZero
    annotation (Placement(transformation(extent={{16,16},{36,36}})));
  parameter Real bandwidth "Bandwidth around reference signal";
equation
  connect(Tset, PID.u_s)
    annotation (Line(points={{-100,-62},{-12,-62}},
                                                color={0,0,127}));
  connect(PID.y, valPos)
    annotation (Line(points={{11,-62},{100,-62}},
                                              color={0,0,127}));
  connect(TMea, PID.u_m)
    annotation (Line(points={{0,-100},{0,-74}}, color={0,0,127}));
  connect(realExpression1.y, onOffController.reference)
    annotation (Line(points={{-3,52},{6,52}}, color={0,0,127}));
  connect(realZero.y,switch2. u3) annotation (Line(points={{37,26},{44,26},{44,38},
          {50,38}}, color={0,0,127}));
  connect(onOffController.y,switch2. u2)
    annotation (Line(points={{29,46},{50,46}}, color={255,0,255}));
  connect(realExpression.y, switch1.u3) annotation (Line(points={{-51,59},{-48,59},
          {-48,72},{-42,72}}, color={0,0,127}));
  connect(isOn, switch1.u2) annotation (Line(points={{-100,58},{-78,58},{-78,80},
          {-42,80}}, color={255,0,255}));
  connect(PLRin, switch1.u1)
    annotation (Line(points={{-100,88},{-42,88}}, color={0,0,127}));
  connect(switch1.y, switch2.u1) annotation (Line(points={{-19,80},{38,80},{38,54},
          {50,54}}, color={0,0,127}));
  connect(switch2.y, PLRset)
    annotation (Line(points={{73,46},{100,46}}, color={0,0,127}));
  connect(TMeaBoiler, onOffController.u) annotation (Line(points={{-100,30},{-48,
          30},{-48,40},{6,40}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture;
