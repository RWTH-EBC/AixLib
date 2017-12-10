within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.MovingBoundaryCells;
model BaseExample
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
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Utilities.FluidCells.MovingBoundaryCell movBouCel(
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
    dhIni=0)
    "Moving boundary cell of the working fluid"
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Sources.Boundary_ph sin(
    redeclare package Medium = Medium,
    nPorts=1,
    use_p_in=true,
    p=pOut)
    "Sink that provides a constant pressure"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=180,origin={50,-50})));
  Utilities.Guard gua(
    useFixModCV=true,
    lenCV = movBouCel.lenOut,
    hInlDes = movBouCel.hInlDes,
    hOutDes = movBouCel.hOutDes,
    hLiq = movBouCel.hLiq,
    hVap = movBouCel.hVap,
    voiFra = movBouCel.voiFra,
    modCVPar=Utilities.Types.ModeCV.SC,
    TWalTP=273.15)
    "Guard that prescribes current flow state"
    annotation (Placement(transformation(extent={{100,60},{80,80}})));

   Modelica.Blocks.Sources.Ramp ramMFlow(
    duration=6400,
    offset=m_flow_nominal,
    height=m_flow_nominal/15)
    "Ramp to provide dummy signal formass flow rate at inlet"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
   Modelica.Blocks.Sources.Ramp ramEnt(
    duration=6400,
    offset=175e3,
    height=-100e1)
    "Ramp to provide dummy signal for specific enthalpy at inlet"
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
   Modelica.Blocks.Sources.Ramp ramPre(
    duration=6400,
    height=-100e3,
    offset=pOut)
    "Ramp to provide dummy signal for pressure at outlet"
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));

   Modelica.Blocks.Sources.Ramp ramSC(
    duration=6400,
    height=5,
    offset=263.15)
    "Ramp to provide dummy signal for temperature of SC regime"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Ramp ramTP(
    offset=263.15,
    height=5,
    duration=6400)
    "Ramp to provide dummy signal for temperature of TH regime"
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.Ramp ramSH(
    offset=263.15,
    height=5,
    duration=6400)
    "Ramp to provide dummy signal for temperature of SH regime"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSC
    "Dummy signal of temperature of SC regime"
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemTP
    "Dummy signal of temperature of TP regime"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSH
    "Dummy signal of temperature of SC regime"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));


equation
  // Check if reinitialisation is necessary
  //
//   when gua.swi then
//     if movBouCel.appHX==Utilities.Types.ApplicationHX.Evaporator then
//       /* Evaporator - Design direction */
//       reinit(movBouCel.hOutDes,gua.hOutDesIni)
//         "Reinitialisation of hOutDesDes";
//     else
//       /* Condenser - Reverse direction */
//       reinit(movBouCel.hInlDes,gua.hInlDesIni)
//         "Reinitialisation of hInlDesDes";
//     end if;
//     reinit(movBouCel.hSCTP,gua.hSCTPIni)
//       "Reinitialisation of hSCTP";
//     reinit(movBouCel.hTPSH,gua.hTPSHIni)
//       "Reinitialisation of hTPSH";
//     reinit(movBouCel.lenCV[1],gua.lenSCIni)
//       "Reinitialisation of lenCV[1]";
//     reinit(movBouCel.lenCV[2],gua.lenTPIni)
//       "Reinitialisation of lenTP[2]";
//     reinit(movBouCel.voiFra,gua.voiFraIni)
//       "Reinitialisation of voiFra";
//   end when;

  // Connection of main components
  //
  connect(sou.ports[1], movBouCel.port_a)
    annotation (Line(points={{-40,-50},{-26,-50},{-10,-50}}, color={0,127,255}));
  connect(movBouCel.port_b, sin.ports[1])
    annotation (Line(points={{10,-50},{25,-50},{40,-50}}, color={0,127,255}));

  connect(ramMFlow.y, sou.m_flow_in)
    annotation (Line(points={{-79,-30},{-72,-30},{-72,-42},{-60,-42}},
                color={0,0,127}));
  connect(ramEnt.y, sou.h_in)
    annotation (Line(points={{-79,-60},{-76,-60},{-72,-60},{-72,-46},
                {-62,-46}}, color={0,0,127}));
  connect(ramPre.y, sin.p_in)
    annotation (Line(points={{79,-30},{74,-30},{74,-42},{62,-42}},
                color={0,0,127}));

  // Connection of further components
  //
  connect(gua.modCV, movBouCel.modCV)
    annotation (Line(points={{79.8,70},{7,70},{7,-40}},  color={0,0,127}));

  connect(ramSH.y, preTemSH.T)
    annotation (Line(points={{-79,70},{-70.5,70},{-62,70}}, color={0,0,127}));
  connect(ramTP.y, preTemTP.T)
    annotation (Line(points={{-79,40},{-70,40},{-62,40}}, color={0,0,127}));
  connect(ramSC.y, preTemSC.T)
    annotation (Line(points={{-79,10},{-70.5,10},{-62,10}}, color={0,0,127}));
  connect(preTemSH.port, movBouCel.heatPortSH)
    annotation (Line(points={{-40,70},{2.6,70},{2.6,-40}}, color={191,0,0}));
  connect(preTemTP.port, movBouCel.heatPortTP)
    annotation (Line(points={{-40,40},{0,40},{0,-40}}, color={191,0,0}));
  connect(preTemSC.port, movBouCel.heatPortSC)
    annotation (Line(points={{-40,10},{-2.6,10},{-2.6,-40}}, color={191,0,0}));


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
        rotation=45)}));
end BaseExample;
