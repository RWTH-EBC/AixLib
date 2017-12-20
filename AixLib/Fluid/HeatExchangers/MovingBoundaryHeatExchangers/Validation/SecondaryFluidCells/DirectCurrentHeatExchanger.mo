within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.SecondaryFluidCells;
model DirectCurrentHeatExchanger
  "Validation model of a secondary fluid cell working in direct-current 
  heat exchanger mode"
  extends Modelica.Icons.Example;

  // Definition of the medium
  //
  replaceable package Medium =
   AixLib.Media.Water
   "Actual medium of the heat exchanger"
   annotation(Dialog(tab="General",group="General"),
              choicesAllMatching=true);

  // Definition of parameters describing state properties
  //
  parameter Modelica.SIunits.Temperature TInl = 293.15
    "Actual temperature at inlet conditions"
    annotation (Dialog(tab="General",group="Prescribed state properties"));
  parameter Modelica.SIunits.AbsolutePressure pOut=1.101325e5
    "Actual set point of the heat exchanger's outlet pressure"
    annotation (Dialog(tab="General",group="Prescribed state properties"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation (Dialog(tab="General",group="Prescribed state properties"));

  // Definition of subcomponents and connectors
  //
  AixLib.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    T=TInl,
    m_flow=m_flow_nominal,
    nPorts=1)
    "Source that provides a constant mass flow rate with a prescribed temperature"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Utilities.FluidCells.SecondaryFluidCell dirCur(
    typHX=Utilities.Types.TypeHX.DirectCurrent,
    geoCV(
      CroSecGeo=Utilities.Types.GeometryCV.Circular,
      nFloCha=50,
      lFloCha=1,
      sFloCha=0.002,
      dFloChaCir=0.015),
    redeclare package Medium = Medium,
    useHeaCoeMod=false,
    AlpSC=100,
    AlpTP=100,
    AlpSH=100,
    heaFloCal=Utilities.Types.CalculationHeatFlow.E_NTU,
    iniSteSta=false,
    TSCIni=298.15,
    TTPIni=298.15,
    TSHIni=298.15)
    "Secondary fluid cell of a moving boundary heat exchanger"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  AixLib.Fluid.Sources.Boundary_ph sin(
    redeclare package Medium = Medium,
    nPorts=1,
    use_p_in=false,
    p=pOut) "Sink that provides a constant pressure" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,40})));

  Modelica.Blocks.Sources.Sine lenInp[3](
    each freqHz=1/12.5,
    each offset=2/3,
    each amplitude=1/6)
    "Provide lengths of different regimes"
    annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
   Modelica.Blocks.Sources.Ramp ramSC(
    offset=293.15,
    height=40,
    duration=25)
    "Ramp to provide dummy signal for temperature of SC regime"
    annotation (Placement(transformation(extent={{-100,-76},{-80,-56}})));
  Modelica.Blocks.Sources.Ramp ramTP(
    offset=293.15,
    height=40,
    duration=25)
    "Ramp to provide dummy signal for temperature of TH regime"
    annotation (Placement(transformation(extent={{-100,-46},{-80,-26}})));
  Modelica.Blocks.Sources.Ramp ramSH(
    duration=25,
    height=40,
    offset=293.15)
    "Ramp to provide dummy signal for temperature of SH regime"
    annotation (Placement(transformation(extent={{-100,-16},{-80,4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSC
    "Dummy signal of temperature of SC regime"
    annotation (Placement(transformation(extent={{-60,-76},{-40,-56}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemTP
    "Dummy signal of temperature of TP regime"
    annotation (Placement(transformation(extent={{-60,-46},{-40,-26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSH
    "Dummy signal of temperature of SC regime"
    annotation (Placement(transformation(extent={{-60,-16},{-40,4}})));


equation
  // Connection of main components
  //
  connect(sou.ports[1], dirCur.port_a)
    annotation (Line(points={{-40,40},{-10,40}}, color={0,127,255}));
  connect(dirCur.port_b, sin.ports[1])
    annotation (Line(points={{10,40},{40,40}}, color={0,127,255}));

  // Connection of prescribed heat flows
  //
  connect(ramSC.y, preTemSC.T)
    annotation (Line(points={{-79,-66},{-62,-66}}, color={0,0,127}));
  connect(ramTP.y, preTemTP.T)
    annotation (Line(points={{-79,-36},{-62,-36}},color={0,0,127}));
  connect(ramSH.y, preTemSH.T)
    annotation (Line(points={{-79,-6},{-62,-6}}, color={0,0,127}));
  connect(preTemSC.port, dirCur.heatPortSC)
    annotation (Line(points={{-40,-66},{-2.6,-66},{-2.6,30}}, color={191,0,0}));
  connect(preTemTP.port, dirCur.heatPortTP)
    annotation (Line(points={{-40,-36},{0,-36},{0,30}}, color={191,0,0}));
  connect(preTemSH.port, dirCur.heatPortSH)
    annotation (Line(points={{-40,-6},{2.6,-6},{2.6,30}}, color={191,0,0}));

  connect(lenInp.y, dirCur.lenInl)
    annotation (Line(points={{-79,24},{5,24},{5,30}}, color={0,0,127}));


  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 08, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This model is a validation model to check the
secondary fluid cell working in direct-current
heat exchanger mode.
</p>
</html>"), experiment(StopTime=25));
end DirectCurrentHeatExchanger;
