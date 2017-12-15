within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.MovingBoundaryCells;
model BaseExampleEvaporator
  "This model is a base model for all example models of moving boundary cells"

  // Definition of the medium
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    "Current working medium of the heat exchanger"
    annotation(Dialog(tab="General",group="General"),
              choicesAllMatching=true);

  // Definition of parameters describing state properties
  //
  parameter Modelica.SIunits.Temperature TOut = 273.15
    "Actual temperature at outlet conditions"
    annotation (Dialog(tab="General",group="Prescribed state properties"));
  parameter Modelica.SIunits.AbsolutePressure pOut=
    Medium.pressure(Medium.setDewState(Medium.setSat_T(TOut+5)))
    "Actual set point of the heat exchanger's outlet pressure"
    annotation (Dialog(tab="General",group="Prescribed state properties"));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation (Dialog(tab="General",group="Prescribed state properties"));

  // Definition of subcomponents
  //
  Sources.MassFlowSource_h sou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_h_in=true,
    nPorts=1)
    "Source that provides a constant mass flow rate with a prescribed specific
    enthalpy"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Utilities.FluidCells.EvaporatorCell movBouCel(
    appHX=Utilities.Types.ApplicationHX.Evaporator,
    geoCV(
      CroSecGeo=Utilities.Types.GeometryCV.Circular,
      nFloCha=50,
      lFloCha=1,
      dFloChaCir=0.015),
    redeclare package Medium = Medium,
    useHeaCoeMod=false,
    AlpSC=2000,
    AlpTP=7500,
    AlpSH=2500,
    heaFloCal=Utilities.Types.CalculationHeatFlow.E_NTU,
    pIni=pOut,
    useVoiFra=false,
    calBalEqu=false)
               "Moving boundary cell of the working fluid"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Sources.Boundary_ph sin(
    redeclare package Medium = Medium,
    nPorts=1,
    use_p_in=true,
    p=pOut)
    "Sink that provides a constant pressure"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=180,origin={50,-30})));
  Utilities.Guards.EvaporatorGuard gua(
    useFixModCV=true,
    lenCV=movBouCel.lenOut,
    hInlDes=movBouCel.hInl,
    hOutDes=movBouCel.hOut,
    hLiq=movBouCel.hLiq,
    hVap=movBouCel.hVap,
    voiFra=movBouCel.VoiFraThr,
    modCVPar=Utilities.Types.ModeCV.SC,
    TWalTP=273.15) "Guard that prescribes current flow state"
    annotation (Placement(transformation(extent={{100,20},{80,40}})));

   Modelica.Blocks.Sources.Ramp ramMFlow(
    duration=6400,
    offset=m_flow_nominal,
    height=m_flow_nominal/15)
    "Ramp to provide dummy signal formass flow rate at inlet"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
   Modelica.Blocks.Sources.Ramp ramEnt(
    duration=6400,
    offset=175e3,
    height=-100e1)
    "Ramp to provide dummy signal for specific enthalpy at inlet"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
   Modelica.Blocks.Sources.Ramp ramPre(
    duration=6400,
    height=-100e3,
    offset=pOut)
    "Ramp to provide dummy signal for pressure at outlet"
    annotation (Placement(transformation(extent={{100,-20},{80,0}})));

  Modelica.Blocks.Sources.Trapezoid trapTemp(
    amplitude=45,
    rising=2750,
    width=450,
    falling=2750,
    period=6400,
    offset=278.15)
    "Trapezoid to provide dummy signal for temperature"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Dummy signal of temperature"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

equation
  // Check if reinitialisation is necessary
  //
  when gua.swi then
    if movBouCel.appHX==Utilities.Types.ApplicationHX.Evaporator then
      /* Evaporator - Design direction */
      reinit(movBouCel.hOut,gua.hOutDesIni)
        "Reinitialisation of hOutDesDes";
    else
      /* Condenser - Reverse direction */
      reinit(movBouCel.hInl,gua.hInlDesIni)
        "Reinitialisation of hInlDesDes";
    end if;
    reinit(movBouCel.hSCTP,gua.hSCTPIni)
      "Reinitialisation of hSCTP";
    reinit(movBouCel.hTPSH,gua.hTPSHIni)
      "Reinitialisation of hTPSH";
    reinit(movBouCel.lenSC,gua.lenSCIni)
      "Reinitialisation of lenCV[1]";
    reinit(movBouCel.lenTP,gua.lenTPIni)
      "Reinitialisation of lenTP[2]";
    reinit(movBouCel.VoiFraThr,gua.voiFraIni)
      "Reinitialisation of voiFra";
    end when;

  // Connection of main components
  //
  connect(sou.ports[1], movBouCel.port_a)
    annotation (Line(points={{-40,-30},{-10,-30}},           color={0,127,255}));
  connect(movBouCel.port_b, sin.ports[1])
    annotation (Line(points={{10,-30},{40,-30}},          color={0,127,255}));

  connect(ramMFlow.y, sou.m_flow_in)
    annotation (Line(points={{-79,-10},{-72,-10},{-72,-22},{-60,-22}},
                color={0,0,127}));
  connect(ramEnt.y, sou.h_in)
    annotation (Line(points={{-79,-40},{-72,-40},{-72,-26},{-62,-26}},
                            color={0,0,127}));
  connect(ramPre.y, sin.p_in)
    annotation (Line(points={{79,-10},{74,-10},{74,-22},{62,-22}},
                color={0,0,127}));

  // Connection of further components
  //
  connect(gua.modCV, movBouCel.modCV)
    annotation (Line(points={{79.8,30},{7,30},{7,-20}},  color={0,0,127}));

  connect(trapTemp.y, preTem.T)
    annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
  connect(preTem.port, movBouCel.heatPortSH)
    annotation (Line(points={{-40,30},{2.6,30},{2.6,-20}}, color={191,0,0}));

  connect(preTem.port, movBouCel.heatPortSC)
    annotation (Line(points={{-40,30},{-2.6,30},{-2.6,-20}}, color={191,0,0}));
  connect(preTem.port, movBouCel.heatPortTP)
    annotation (Line(points={{-40,30},{0,30},{0,-20}}, color={191,0,0}));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"), Icon(graphics={
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
        rotation=45)}), experiment(StopTime=6400));
end BaseExampleEvaporator;
