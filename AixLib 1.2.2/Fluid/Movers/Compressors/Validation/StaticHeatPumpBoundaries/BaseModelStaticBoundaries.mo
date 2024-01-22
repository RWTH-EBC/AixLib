within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries;
model BaseModelStaticBoundaries
  "Base model to test compressors using static boundaries"

  // Definition of medium
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium of the compressor"
    annotation(Dialog(tab="General",group="General"),
               choicesAllMatching=true);

  // Definition of parameters describing compressors
  //
  parameter Integer nCom = 1
    "Numer of compressors in parallel"
    annotation(Dialog(tab="General",group="Compressors"));

  // Definition of variables describing boundary conditions
  //
  Modelica.Blocks.Sources.CombiTimeTable inpDat(
    table=[0,50,8.1,37.5,15.6,70.8,2.18,0.096; 1,50,8,37.8,19.3,81.8,2.684,0.093;
        2,50,8.3,38.5,25.3,96.6,3.516,0.094; 3,50,12.4,55.3,18.4,77.8,2.391,0.15;
        4,50,12.2,54.1,35.6,114.8,5.011,0.137; 5,50,11.5,50.9,24.2,90,3.227,0.136;
        6,50,12,51.9,30.4,102.4,4.137,0.142; 7,50,5.1,26,10,58.8,1.449,0.06; 8,50,
        5.4,24.3,13,66.3,1.848,0.063; 9,50,5.4,26.4,16,78.6,2.26,0.061; 10,50,5.4,
        25.2,20.8,94.6,2.982,0.06; 11,50,5.3,21.6,29.8,124.5,4.406,0.055; 12,50,
        8.5,40.5,32.5,114.2,4.514,0.093; 13,50,11.9,54.4,39.1,121.7,5.424,0.135;
        14,50,15.3,64.3,24.5,90.2,2.979,0.188; 15,50,15.6,61.7,32.1,102.2,4.074,
        0.191; 16,50,15.7,62.8,38.3,114,5.02,0.188; 17,50,20.4,77,35.8,110.1,4.351,
        0.251; 18,35,12.4,52.3,40.3,123.6,4.33,0.093; 19,35,12.2,53.4,36.1,116.1,
        3.708,0.093; 20,35,12.4,52.9,29.8,101.4,2.91,0.099; 21,35,12.2,52.6,24,88.4,
        2.206,0.1; 22,35,11.8,52.6,18.6,76.2,1.6,0.099; 23,35,8.4,40.8,32.5,120.4,
        3.431,0.059; 24,35,5.6,23.1,28.2,120.3,3.019,0.039; 25,40,7.8,36,16.1,71.7,
        1.745,0.073; 26,40,8,38.7,20.5,84.9,2.212,0.073; 27,40,8.3,38.5,25.4,96.9,
        2.808,0.074; 28,40,8.3,38.7,32.5,116.3,3.764,0.07; 29,40,5,20.1,24.7,108.4,
        2.843,0.043; 30,40,13.4,58.7,19.5,79.3,1.833,0.129; 31,50,4.8,18.9,25.1,
        110.8,3.551,0.051; 32,50,8,39.3,32,115.2,4.412,0.087; 33,50,12.8,56.7,20.1,
        81.8,2.603,0.154; 34,50,12.9,54.3,25,90.2,3.28,0.154; 35,50,12.9,55.4,31.8,
        105,4.276,0.151; 36,50,11.9,52.9,36.1,115.4,4.989,0.134; 37,65,13.2,56.1,
        31.2,103.4,5.242,0.199; 38,65,12.5,53.2,35.5,112.1,6.166,0.185; 39,65,11.6,
        51.7,24.1,89.9,4.01,0.178; 40,65,12,56.4,19.1,81.6,3.139,0.184; 41,65,8.1,
        38.7,32.4,114.6,5.716,0.116; 42,65,6,26.5,29.6,116.6,5.248,0.082; 43,75,
        12,55.1,18.5,80.1,3.731,0.211; 44,75,12,52.4,24.8,91.6,4.982,0.21; 45,75,
        11.7,50.4,30.5,103.6,6.248,0.199; 46,75,8.4,38.8,24.1,94.2,5.035,0.142;
        47,75,5.4,26.3,21.5,100.2,4.692,0.087],
    columns=2:8,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "Static boundaries of compressor model"
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));

  Modelica.Blocks.Sources.RealExpression inpRotSpe(y=inpDat.y[1])
    "Expressions describing rotational speed"
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  Modelica.Blocks.Sources.RealExpression inpPreSin(y=inpDat.y[4]*1e5)
    "Expressions describing pressure at compressors' outlets"
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  Modelica.Blocks.Sources.RealExpression inpTemSin(y=inpDat.y[5] + 273.15)
    "Expressions describing temperature at compressors' outlets"
    annotation (Placement(transformation(extent={{-90,-34},{-70,-14}})));
  Modelica.Blocks.Sources.RealExpression inpPreSou(y=inpDat.y[2]*1e5)
    "Expressions describing pressure at compressors' inlets"
    annotation (Placement(transformation(extent={{-90,-86},{-70,-66}})));
  Modelica.Blocks.Sources.RealExpression inpTemSou(y=inpDat.y[3] + 273.15)
    "Expressions describing temperature at compressors' inlets"
    annotation (Placement(transformation(extent={{-90,-100},{-70,-80}})));

  // Definition of further components
  //
  Modelica.Blocks.Interaction.Show.RealValue dfPowEle(
    use_numberPort=false,
    number=inpDat.y[6]*1000 - modCom.modCom[1].comPro.PEle)
    "Difference between power consumptions that are measured and calculated"
    annotation (Placement(transformation(extent={{20,26},{40,46}})));
  Modelica.Blocks.Interaction.Show.RealValue dMasFlo(
    use_numberPort=false,
    number=inpDat.y[7] - modCom.modCom[1].comPro.m_flow)
    "Difference between mass flow rates that are measured and calculated"
    annotation (Placement(transformation(extent={{20,12},{40,32}})));
  Modelica.Blocks.Interaction.Show.RealValue dPowEleRel(
    use_numberPort=false,
    number=dfPowEle.number/(inpDat.y[6]*1000)*100)
    "Relative difference between power consumptions that are measured and calculated"
    annotation (Placement(transformation(extent={{60,26},{80,46}})));
  Modelica.Blocks.Interaction.Show.RealValue dMasFloRel(
    use_numberPort=false,
    number=dMasFlo.number/inpDat.y[7]*100)
    "Relative difference between mass flow rates that are measured and calculated"
    annotation (Placement(transformation(extent={{60,12},{80,32}})));

  // Definition of subcomponents
  //
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTemp(T=278.15)
    "Source that prescribes boundary ambient temperature (Dummy)"
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thrCol(m=nCom)
    "Model to split the ambient temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,origin={38,-50})));

  Modelica.Blocks.Routing.Replicator repMea(nout=nCom)
    "Replicating the current value of the manipulated variables"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1)      "Source with prescribed pressure and temperature"
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  ModularCompressors.ModularCompressorsSensors modCom(
    nCom=nCom,
    redeclare package Medium = Medium,
    redeclare model SimpleCompressor =
        SimpleCompressors.RotaryCompressors.RotaryCompressor,
    show_staEff=true,
    show_qua=true,
    m_flow_start=0.05,
    h_out_start=400e3,
    VDis=fill(5.24444e-5,nCom),
    useInpFil=fill(false, nCom))
    "Model that describes modular compressors in parallel"
    annotation (Placement(transformation( extent={{-20,20},{20,-20}},
                rotation=90,origin={0,-50})));

  Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1)
    "Sink with prescribed pressure and temperature"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));

  Controls.Interfaces.ModularHeatPumpControlBus dataBus(
    nCom=nCom) "Connector that contains all control signals"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,-50}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-98,0})));

  // Definition of further variables
  //
  Real inpPEle = inpDat.y[6]*1000
    "Power consumption of the compressor";
  Real inpTime = time
    "Simulation time";

equation
  // Connection of main components
  //
  connect(ambTemp.port, thrCol.port_b)
    annotation (Line(points={{60,-50},{48,-50}},
                                               color={191,0,0}));
  connect(thrCol.port_a, modCom.heatPort)
    annotation (Line(points={{28,-50},{28,-50},{20,-50}},
                                                       color={191,0,0}));
  connect(sou.ports[1], modCom.port_a)
    annotation (Line(points={{-20,-80},{0,-80},{0,-70}}, color={0,127,255}));
  connect(modCom.port_b, sin.ports[1])
    annotation (Line(points={{0,-30},{0,-30},{0,-20},{-20,-20}},color={0,127,255}));

  // Connection of signals
  //
  connect(modCom.dataBus, dataBus)
    annotation (Line(points={{-20,-50},{-20,-50},{-30,-50}},
                color={255,204,51},
                thickness=0.5));
  connect(inpRotSpe.y, repMea.u)
    annotation (Line(points={{-69,-50},{-62,-50}},
                color={0,0,127}));
  connect(repMea.y, dataBus.comBus.extManVarCom)
    annotation (Line(points={{-39,-50},{-29.95,-50},{-29.95,-50.05}},
                color={0,0,127}));
  connect(inpPreSou.y, sou.p_in)
    annotation (Line(points={{-69,-76},{-64,-76},{-60,
          -76},{-60,-72},{-42,-72}}, color={0,0,127}));
  connect(inpTemSou.y, sou.T_in)
    annotation (Line(points={{-69,-90},{-64,-90},{-56,
          -90},{-56,-76},{-42,-76}}, color={0,0,127}));
  connect(inpPreSin.y, sin.p_in)
    annotation (Line(points={{-69,-10},{-60,-10},{-60,
          -12},{-42,-12}}, color={0,0,127}));
  connect(inpTemSin.y, sin.T_in)
    annotation (Line(points={{-69,-24},{-62,-24},{-56,
          -24},{-56,-16},{-42,-16}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
      Ellipse(
        extent={{-80,80},{80,-80}},
        lineColor={215,215,215},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{-55,55},{55,-55}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-60,14},{60,-14}},
        lineColor={215,215,215},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid,
        rotation=45)}), Diagram(coordinateSystem(preserveAspectRatio=false),
        graphics={                     Text(
          extent={{0,80},{100,60}},
          lineColor={0,0,0},
          textString="Difference | Relative Difference
--------------------------------------
Power Consumption
Mass Flow Rate",
          textStyle={TextStyle.Bold}),
        Rectangle(
          extent={{0,100},{100,0}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-100,100},{0,0}},
          lineColor={0,0,0},
          lineThickness=0.5)}),
    Documentation(revisions="<html><ul>
  <li>December 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model prescribes static inlet and outlet conditions of the
  compressor. Furhtermore, it prescribes the rotational speed. The
  model is used to validate the compressor model in general as well as
  to identify efficiencies that describes the compressor's behaiviour
  in a suitable way. Therefore, both calculated mass flow rate and
  calculated power consumption are compared with the corresponding
  experimental data.
</p>
<h4>
  Required information
</h4>
<p>
  The User needs to define the following information in order to
  complete the model:
</p>
<ol>
  <li>Basic definitions of the compressor. For example, the
  displacement volume.
  </li>
  <li>Calculation approaches of the three efficiencies of the
  compressor.
  </li>
  <li>Static boundaries of the compressor obtained, for example, by
  experimental data.
  </li>
</ol>
<p>
  To add static boundary conditions, a combi time table is included
  within the model. The columns are defined as follows:
</p>
<ol>
  <li>Time steps (0,1,2,3,...).
  </li>
  <li>Rotational speed in <code>Hz</code>.
  </li>
  <li>Pressure at inlet in <code>bar</code>.
  </li>
  <li>Temperature at inlet in <code>°C</code>.
  </li>
  <li>Pressure at outlet in <code>bar</code>.
  </li>
  <li>Temperature at outlet in <code>°C</code>.
  </li>
  <li>Power consumption in <code>kW</code>.
  </li>
  <li>Mass flow rate in <code>kg/s</code>.
  </li>
</ol>
<h4>
  References
</h4>
<p>
  C. Cuevas und J. Lebrun. (2009): <a href=
  \"http://dx.doi.org/10.1016/j.applthermaleng.2008.03.016\">Testing and
  modelling of a variable speed scroll compressor.</a>. In: <i>Applied
  Thermal Engineering</i>, 29(2):469–478
</p>
</html>"),
    experiment(StopTime=47.9999));
end BaseModelStaticBoundaries;
