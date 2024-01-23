within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.HeatExchangers.DHWHeatExchanger;
model DHWHeatExchanger
extends Modelica.Icons.Example;
  Components.HeatGenerators.Boiler.Boiler     boilerBase
    annotation (Placement(transformation(extent={{-72,-30},{-46,-4}})));
  Components.Pumps.Pump pump annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-42})));
  Modelica.Blocks.Sources.Constant dotm_heatingCircuit(k=0.09)
    annotation (Placement(transformation(extent={{-92,-68},{-78,-54}})));
  Modelica.Blocks.Sources.BooleanExpression booleanOnOffBoiler(y=true)
    annotation (Placement(transformation(extent={{-90,10},{-74,24}})));
  Modelica.Blocks.Sources.Constant dotm_dHW(k=0.058)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={89,-29})));
  Modelica.Blocks.Sources.Constant T_coldWater(k=273.15 + 10) annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={89,-59})));
  Modelica.Blocks.Sources.Constant dotQ_rel(k=1)
    annotation (Placement(transformation(extent={{-88,-8},{-74,6}})));
  Components.HeatExchangers.DHWHeatExchanger dHWHeatExchanger
    annotation (Placement(transformation(extent={{-16,-46},{24,-4}})));
  Components.Pumps.FluidSource fluidSource annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,-42})));
  Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{54,-26},{74,-6}})));
equation
  connect(pump.enthalpyPort_b, boilerBase.enthalpyPort_a1) annotation (Line(
      points={{-69.6,-42},{-78,-42},{-78,-17.26},{-65.5,-17.26}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dotm_heatingCircuit.y, pump.dotm_setValue) annotation (Line(
      points={{-77.3,-61},{-60,-61},{-60,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanOnOffBoiler.y, boilerBase.onOff_boiler) annotation (Line(
      points={{-73.2,17},{-55.1,17},{-55.1,-7.9}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(dotQ_rel.y, boilerBase.dotQ_rel) annotation (Line(
      points={{-73.3,-1},{-61.6163,-1},{-61.6163,-7.88375}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boilerBase.enthalpyPort_b1, dHWHeatExchanger.enthalpyPort_heaterIn)
    annotation (Line(
      points={{-52.5,-17},{-33.25,-17},{-33.25,-19.12},{-15.1111,-19.12}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pump.enthalpyPort_a, dHWHeatExchanger.enthalpyPort_heaterOut)
    annotation (Line(
      points={{-50.4,-42},{-32,-42},{-32,-40.12},{-15.5556,-40.12}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_coldWater.y, fluidSource.T_fluid) annotation (Line(
      points={{81.3,-59},{70,-59},{70,-46.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm_dHW.y, fluidSource.dotm) annotation (Line(
      points={{81.3,-29},{70,-29},{70,-39.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dHWHeatExchanger.enthalpyPort_dHWIn, fluidSource.enthalpyPort_b)
    annotation (Line(
      points={{23.5556,-40.12},{34.7778,-40.12},{34.7778,-43},{52,-43}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dHWHeatExchanger.enthalpyPort_dHWOut, vessel.enthalpyPort_a)
    annotation (Line(
      points={{24,-19.12},{34,-19.12},{34,-16},{57,-16}},
      color={176,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{40,60},{-40,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,60},{42,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,60},{-100,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,100},{-100,70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-58,100},{58,72}},
          lineColor={0,0,0},
          textString="Test DHWHeatExchanger
(inclusive heating and cooling circuit)",
          fontSize=16),
        Text(
          extent={{-98,50},{-74,40}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Heating circuit uses a pump model 
to set a constant mass flow and a 
boiler model to set a constant 
temperature of the fluid. "),
        Text(
          extent={{-18,52},{6,42}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="....")}),
    experiment(StopTime=10000, Interval=60),
    __Dymola_experimentSetupOutput);
end DHWHeatExchanger;
