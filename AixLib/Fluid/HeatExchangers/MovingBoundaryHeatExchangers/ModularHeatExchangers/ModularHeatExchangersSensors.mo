within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.ModularHeatExchangers;
model ModularHeatExchangersSensors
  "Model that describes modular moving boundary heat exchangers with sensors 
  at heat exchangers outlets"
  extends BaseClasses.PartialModularHeatExchangers;

  // Definition of parameters describing sensors
  //
  parameter Modelica.SIunits.SpecificEnthalpy h_out_start=
      Medium2.specificEnthalpy_pTX(
      p=Medium2.p_default,
      T=Medium2.T_default,
      X=Medium2.X_default) "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Sensors", group="Specific enthalpy"));

  // Definition of further subcomponents
  //
  Utilities.ModularSensors modSen(
    redeclare package Medium = Medium2,
    nPorts = nHeaExc,
    tau=tau,
    transferHeat=transferHeat,
    TAmb=TAmb,
    tauHeaTra=tauHeaTra,
    initType=initTypeSen,
    T_start=TIniSen,
    h_out_start=h_out_start,
    allowFlowReversal=allowFlowReversal2,
    m_flow_nominal=m_flow_nominalPri,
    m_flow_small=m_flow_smallPri)
    "Model that contains different sensors located behind heat exchangers"
    annotation (Placement(transformation(extent={{40,-46},{60,-26}})));


equation
  // Connect missing fluid ports
  //
  for i in 1:nHeaExc loop
    connect(heaExc[i].port_b2,modSen.ports_a[i]);
    connect(modSen.ports_b[i],port_b2);
  end for;

  // Connection of sensor signals
  //
  if appHX==Utilities.Types.ApplicationHX.Evaporator then
    /* Evaorator */
    connect(modSen.meaPre, dataBus.senBus.meaPreEva);
    connect(modSen.meaTem, dataBus.senBus.meaTemEva);
    connect(modSen.meaMasFlo, dataBus.senBus.meaMasFloEva);
    connect(modSen.meaQua, dataBus.senBus.meaPhaEva);
  else
    /* Condenser */
    connect(modSen.meaPre, dataBus.senBus.meaPreCon);
    connect(modSen.meaTem, dataBus.senBus.meaTemCon);
    connect(modSen.meaMasFlo, dataBus.senBus.meaMasFloCon);
    connect(modSen.meaQua, dataBus.senBus.meaPhaCon);
  end if;


  annotation (Diagram(graphics={
                    Line(points={{60,-34},{70,-36},{70,0},{100,0}},
            color={0,127,255}),
                    Line(points={{60,-36},{70,-36},{70,0},{100,0}},
            color={0,127,255}),
                    Line(points={{60,-38},{70,-36},{70,0},{100,0}},
            color={0,127,255}),
                    Line(points={{10,-36},{10,-36},{10,-36},{40,-34}},
            color={0,127,255}),
                    Line(points={{10,-36},{10,-36},{10,-36},{40,-36}},
            color={0,127,255}),
                    Line(points={{10,-36},{10,-36},{10,-36},{40,-38}},
            color={0,127,255}),
        Line(points={{0,-100},{0,-90},{44,-90},{44,-46}},  color={0,0,127}),
        Line(points={{0,-100},{0,-90},{48,-90},{48,-46}},  color={0,0,127}),
        Line(points={{0,-100},{0,-90},{52,-90},{52,-46}},  color={0,0,127}),
        Line(points={{0,-100},{0,-90},{56,-90},{56,-46}},  color={0,0,127})}),
        Icon(
        graphics={
        Ellipse(
          extent={{48,2},{52,-2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{38,34},{82,-34}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid,
          extent={{40,-20},{80,20}}),
        Line(points={{60,20},{60,12}}),
        Line(points={{66,10},{70.2,17.3}}),
        Line(points={{54,10},{49.8,17.3}}),
        Line(points={{70,4},{77.8,7.9}}),
        Line(points={{50,4},{42.2,7.9}}),
        Ellipse(
          lineColor={64,64,64},
          fillColor={255,255,255},
          extent={{54,-6},{66,6}}),
        Ellipse(
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{56,-4},{64,4}}),
        Polygon(
          points={{60,2},{62,0},{68,6},{70,10},{66,8},{60,2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end ModularHeatExchangersSensors;
