within AixLib.Fluid.DistrictHeatingCooling.Examples;
model HydraulicValMod
  "HydraulicValidationPipes example rebuilt with modular component models"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Medium in the network";

  parameter Modelica.SIunits.Pressure pressureReference1 = 201450.8
    "Reference result for pressure at demand node B1";

  parameter Modelica.SIunits.Pressure pressureReference2 = 169453.5
    "Reference result for pressure at demand node B2";

  parameter Modelica.SIunits.Pressure pressureReference3 = 200612.4
    "Reference result for pressure at demand node B3";

  Pipes.FlowResistance          pipe2(
    redeclare package Medium = Medium,
    m_flow_nominal=29.8378,
    length=100,
    diameter=0.15)          "Pipe 2"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Pipes.FlowResistance          pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=59.7352,
    length=355,
    diameter=0.2)           "Pipe 1" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,52})));
  Pipes.FlowResistance          pipe4(
    redeclare package Medium = Medium,
    m_flow_nominal=1.7144,
    length=45,
    diameter=0.11)                            "Pipe 4"
    annotation (Placement(transformation(extent={{0,-38},{20,-18}})));
  Pipes.FlowResistance          pipe5(
    redeclare package Medium = Medium,
    m_flow_nominal=33.2923,
    length=175,
    diameter=0.15)                              "Pipe 5"
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Supplies.NoReturn.IdealSource
                      S1(
    redeclare package Medium = Medium, p_supply=298900)
              "Supply node S1" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,80})));
  Supplies.NoReturn.IdealSource
                      S2(
    redeclare package Medium = Medium, p_supply=269020)
              "Supply node S2" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-60})));
  Demands.NoReturn.IdealSink
                           B1(
    redeclare package Medium = Medium, prescribedFlow=28.175)
              "Demand node B1"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,30})));
  Demands.NoReturn.IdealSink
                           B2(
    redeclare package Medium = Medium, prescribedFlow=42.213)
                    "Demand node B2" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,80})));
  Demands.NoReturn.IdealSink
                           B3(
    redeclare package Medium = Medium, prescribedFlow=22.6)
                  "Demand node B3"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,-60})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure1(final unit="1")
    "Relative deviation of pressure at demand node B1"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure2(final unit="1")
    "Relative deviation of pressure at demand node B2"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure3(final unit="1")
    "Relative deviation of pressure at demand node B3"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));

  Pipes.FlowResistance               pipe3(
    redeclare package Medium = Medium,
    m_flow_nominal=12.4528,
    length=70,
    diameter=0.1)
               "Pipe 3" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,4})));
  Pipes.FlowResistance          pipe6(
    redeclare package Medium = Medium,
    length=15,
    diameter=0.15,
    m_flow_nominal=28.175)
                   "Pipe 6"          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,30})));
  Pipes.FlowResistance          pipe7(
    redeclare package Medium = Medium,
    length=15,
    diameter=0.15,
    m_flow_nominal=42.213)
                   "Pipe 7"          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,50})));
  Pipes.FlowResistance          pipe8(
    redeclare package Medium = Medium,
    length=15,
    diameter=0.15,
    m_flow_nominal=22.6)
                   "Pipe 8"          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={22,-60})));
equation

  deviationPressure1 = (B1.port_a.p - pressureReference1)/pressureReference1;
  deviationPressure2 = (B2.port_a.p - pressureReference2)/pressureReference2;
  deviationPressure3 = (B3.port_a.p - pressureReference3)/pressureReference3;

  connect(pipe4.port_b, pipe5.port_a) annotation (Line(points={{20,-28},{40,-28},
          {40,-60},{50,-60}}, color={0,127,255}));
  connect(pipe2.port_a, pipe4.port_a) annotation (Line(points={{-20,30},{-40,30},
          {-40,-28},{0,-28}},   color={0,127,255}));
  connect(pipe2.port_a, pipe1.port_a)
    annotation (Line(points={{-20,30},{-40,30},{-40,42}}, color={0,127,255}));
  connect(pipe2.port_b, pipe3.port_b)
    annotation (Line(points={{0,30},{40,30},{40,14}},   color={0,127,255}));
  connect(pipe3.port_a, pipe4.port_b)
    annotation (Line(points={{40,-6},{40,-28},{20,-28}}, color={0,127,255}));
  connect(pipe6.port_a, pipe4.port_a) annotation (Line(points={{-50,30},{-40,30},
          {-40,-28},{0,-28}}, color={0,127,255}));
  connect(pipe2.port_b, pipe7.port_a)
    annotation (Line(points={{0,30},{20,30},{20,40}}, color={0,127,255}));
  connect(pipe8.port_a, pipe5.port_a)
    annotation (Line(points={{32,-60},{50,-60}}, color={0,127,255}));
  connect(S1.port_b, pipe1.port_b)
    annotation (Line(points={{-40,70},{-40,62}}, color={0,127,255}));
  connect(pipe5.port_b, S2.port_b)
    annotation (Line(points={{70,-60},{80,-60}}, color={0,127,255}));
  connect(B1.port_a, pipe6.port_b)
    annotation (Line(points={{-80,30},{-70,30}}, color={0,127,255}));
  connect(B2.port_a, pipe7.port_b)
    annotation (Line(points={{20,70},{20,60}}, color={0,127,255}));
  connect(B3.port_a, pipe8.port_b)
    annotation (Line(points={{0,-60},{12,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This example recreates the <a
href=\"modelica://AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidationPipes\">AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidationPipes</a>
reference network using the <a
href=\"modelica://AixLib.Fluid.DistrictHeatingCooling.BaseClasses\">AixLib.Fluid.DistrictHeatingCooling.BaseClasses</a>.
Both implementation yield the same results.</p>
<h4>References</h4>
<ul>
<li><a href=\"https://www.crcpress.com/Hydraulics-of-Pipeline-Systems/Larock-Jeppson-Watters/p/book/9780849318061\">Larock, Bruce E., Roland W. Jeppson, and Gary Z. Watters. <i>Hydraulics of pipeline systems</i>. Boca Raton, FL: CRC Press, 2000.</a></li>
<li>AixLib issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/402\">#402</a></li>
</ul>
</html>", revisions="<html>
<ul>
  <li>
  May 27, 2017, by Marcus Fuchs:<br/>
  Implemented for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 402</a>.
 </li>
</ul>
</html>"));
end HydraulicValMod;
