within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Pumps;
model Pump
    extends Modelica.Icons.Example;

  Components.Pumps.Pump pump
    annotation (Placement(transformation(extent={{-14,-4},{10,18}})));
  Modelica.Blocks.Sources.RealExpression mdot(y=2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-16,26})));
  Components.HeatExchangers.RadiatorMultiLayer
                                       radiator_ML(selectable=true,
      radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom())
    annotation (Placement(transformation(extent={{60,-2},{80,16}})));
  Components.HeatGenerators.Boiler.Boiler     boilerBase(paramBoiler=
        Data.Boiler.General.Boiler_Vitogas200F_11kW(), T_start=333.15)
    annotation (Placement(transformation(extent={{-68,-4},{-46,18}})));
  Modelica.Blocks.Sources.BooleanExpression booleanOnOffBoiler(y=true)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Sources.RealExpression dotQ_rel(y=0.3)
    annotation (Placement(transformation(extent={{-90,6},{-70,26}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature idealSink(T=294.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={46,34})));
equation
  connect(boilerBase.enthalpyPort_b1, pump.enthalpyPort_a) annotation (Line(
      points={{-51.5,7},{-13.52,7}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pump.enthalpyPort_b, radiator_ML.enthalpyPort_a1) annotation (Line(
      points={{9.52,7},{30,7},{30,6.82},{62,6.82}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(radiator_ML.enthalpyPort_b1, boilerBase.enthalpyPort_a1)
    annotation (Line(
      points={{78,6.82},{78,-20},{-62.5,-20},{-62.5,6.78}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(mdot.y, pump.dotm_setValue) annotation (Line(
      points={{-5,26},{-2,26},{-2,15.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotQ_rel.y, boilerBase.dotQ_rel) annotation (Line(
      points={{-69,16},{-60,16},{-60,14.7138},{-59.2137,14.7138}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanOnOffBoiler.y, boilerBase.onOff_boiler) annotation (Line(
      points={{-69,30},{-53.7,30},{-53.7,14.7}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(radiator_ML.ConvectiveHeat, idealSink.port) annotation (Line(points={
          {64.6,12.22},{64.6,14},{32,14},{32,34},{36,34}}, color={191,0,0}));
  connect(radiator_ML.RadiativeHeat, idealSink.port) annotation (Line(points={{
          75.6,12.4},{75.6,18},{36,18},{36,34}}, color={95,95,95}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Rectangle(
          extent={{30,60},{-32,-8}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,100},{-100,70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-58,100},{58,72}},
          lineColor={0,0,0},
          textString="Test pump model 
(inclusive boiler and radiator model)"),
        Text(
          extent={{-14,54},{10,44}},
          lineColor={0,0,0},
          textString="Pump model only determines the 
property mass flow rate of the fluid. 
Specific enthalpy and temperature of 
the fluid remain constant")}));
end Pump;
