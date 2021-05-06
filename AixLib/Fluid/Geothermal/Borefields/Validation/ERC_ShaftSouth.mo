within AixLib.Fluid.Geothermal.Borefields.Validation;
model ERC_ShaftSouth "Example model of a rectangular borefield"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Medium model";

  parameter Modelica.SIunits.Time tLoaAgg=300
    "Time resolution of load aggregation";

  parameter Modelica.SIunits.Temperature TGro = 285.15
    "Ground temperature";
  parameter Modelica.SIunits.Velocity v_nominal = 1 "Nominal velocity";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = nBorHol*v_nominal*rTub^2*3.14*1000
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dpBorFie_nominal = (hBor+(xBorFie+yBorFie)/2)*2
    "Pressure losses for the entire borefield";
  parameter Modelica.SIunits.Pressure dpHex_nominal = 10000 "Pressure drop heat exchanger";
  parameter Modelica.SIunits.Pressure dp_nominal = dpBorFie_nominal + dpHex_nominal
    "Total pressure drop";

  parameter Modelica.SIunits.Height hBor = 100 "Total height of the borehole";
  parameter Modelica.SIunits.Radius rTub = 0.02 "Outer radius of the tubes";
  parameter Modelica.SIunits.Length xBorFie = 108 "Borefield length";
  parameter Modelica.SIunits.Length yBorFie = 0 "Borefield width";
  parameter Modelica.SIunits.Length dBorHol = 9 "Distance between two boreholes";

  final parameter Integer nXBorHol = integer((xBorFie+dBorHol)/dBorHol) "Number of boreholes in x-direction";
  final parameter Integer nYBorHol = integer((yBorFie+dBorHol)/dBorHol) "Number of boreholes in y-direction";
  final parameter Integer nBorHol = nXBorHol*nYBorHol "Number of boreholes";

  final parameter AixLib.Fluid.Geothermal.Borefields.Data.Borefield.Template
    borFieDat(
    final filDat=BaseClasses.Erc_ShaftSouth_Filling(),
    final soiDat=BaseClasses.Erc_ShaftSouth_Soil(),
    final conDat=BaseClasses.Erc_ShaftSouth_Configuration())
                           "Borefield parameters"
    annotation (Placement(transformation(extent={{60,74},{80,94}})));

  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Antifreeze.PropyleneGlycolWater (
          property_T=293.15, X_a=0.35),
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Antifreeze.PropyleneGlycolWater (property_T=293.15, X_a=
            0.35), nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,0})));
  AixLib.Fluid.Sensors.TemperatureTwoPort TBorFieOut(redeclare package Medium =
        AixLib.Media.Antifreeze.PropyleneGlycolWater (property_T=293.15, X_a=0.35),
      m_flow_nominal=4.8) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,0})));
  AixLib.Fluid.Geothermal.Borefields.TwoUTubes ERCField(
    redeclare package Medium = AixLib.Media.Antifreeze.PropyleneGlycolWater (
          property_T=293.15, X_a=0.35),
    borFieDat=borFieDat,
    TExt0_start=285.15,
    TGro_start={288.1 for i in 1:ERCField.nSeg},
    TFlu_start={288.1 for i in 1:ERCField.nSeg})
    annotation (Placement(transformation(extent={{4,-20},{36,20}})));
  Modelica.Blocks.Sources.CombiTimeTable ErcMea(
    tableOnFile=true,
    tableName="data",
    offset={0,0,0},
    columns={2,3,4},
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/Data/Fluid/Geothermal/Borefields/HeatTransfer/Validation/ERC_South_2018.txt"))
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature T_out
    annotation (Placement(transformation(extent={{-52,-64},{-42,-54}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TBorFieOutMeas
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Sensors.TemperatureTwoPort TBorFieIn(redeclare package Medium =
        Media.Antifreeze.PropyleneGlycolWater (property_T=293.15, X_a=0.35),
      m_flow_nominal=4.8) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,0})));
equation

  connect(TBorFieOut.port_b, bou.ports[1]) annotation (Line(points={{60,0},{68,0},
          {68,6.66134e-16},{76,6.66134e-16}}, color={0,127,255}));
  connect(ERCField.port_b, TBorFieOut.port_a)
    annotation (Line(points={{36,0},{40,0}}, color={0,127,255}));
  connect(ErcMea.y[2], boundary.m_flow_in) annotation (Line(points={{-79,4},{
          -74,4},{-74,8},{-46,8}}, color={0,0,127}));
  connect(boundary.T_in, ErcMea.y[1])
    annotation (Line(points={{-46,4},{-79,4}}, color={0,0,127}));
  connect(T_out.T, ErcMea.y[3]) annotation (Line(points={{-53,-59},{-53,-58},{-74,
          -58},{-74,4},{-79,4}},
                             color={0,0,127}));
  connect(T_out.port, TBorFieOutMeas.port)
    annotation (Line(points={{-42,-59},{-20,-59},{-20,-60}}, color={191,0,0}));
  connect(TBorFieIn.port_b, ERCField.port_a)
    annotation (Line(points={{0,0},{4,0}}, color={0,127,255}));
  connect(TBorFieIn.port_a, boundary.ports[1])
    annotation (Line(points={{-20,0},{-24,0}}, color={0,127,255}));
  annotation (Documentation(info="<html>
<p>
This example uses measured data of the E.ON ERC geothermal field to validate the boreholefield model. 
For the validation the measured inlet temperature and the measured massflow are used as inputs whereas the measured outlet 
temperature is compared with the simulated outlet temperature. The data includes one year of operation with small failures of the monitoring system 
(linear parts in the simulation).
</html>", revisions="<html>
<ul>
<li>
May 06, 2021, by Phillip Stoffel:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="Resources/Scripts/Dymola/Fluid/Geothermal/Borefields/Examples/RectangularBorefield.mos"
        "Simulate and plot"),
  experiment(
      StopTime=2678400,Tolerance=1e-6));
end ERC_ShaftSouth;
