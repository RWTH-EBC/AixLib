within AixLib.FastHVAC.Pumps.Examples;
model Pump
    extends Modelica.Icons.Example;

  AixLib.FastHVAC.Pumps.Pump pump
    annotation (Placement(transformation(extent={{-14,-4},{10,18}})));
  Modelica.Blocks.Sources.RealExpression mdot(y=2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-16,26})));
  AixLib.FastHVAC.HeatExchangers.RadiatorMultiLayer radiator_ML(selectable=true,
      radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom())
    annotation (Placement(transformation(extent={{94,-82},{114,-64}})));
  AixLib.FastHVAC.HeatGenerators.Boiler.Boiler boilerBase(paramBoiler=
        DataBase.Boiler.General.Boiler_Vitogas200F_11kW(), T_start=333.15)
    annotation (Placement(transformation(extent={{-68,-4},{-46,18}})));
  Modelica.Blocks.Sources.BooleanExpression booleanOnOffBoiler(y=true)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Sources.RealExpression dotQ_rel(y=0.3)
    annotation (Placement(transformation(extent={{-90,6},{-70,26}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature idealSink(T=294.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,-46})));
  HeatExchangers.RadiatorMultiLayer                 radiator_ML1(selectable=
        true, radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom())
    annotation (Placement(transformation(extent={{98,10},{118,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature idealSink1(T=294.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={84,46})));
equation
  connect(boilerBase.enthalpyPort_b1, pump.enthalpyPort_a) annotation (Line(
      points={{-51.5,7},{-13.52,7}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(radiator_ML.enthalpyPort_b1, boilerBase.enthalpyPort_a1)
    annotation (Line(
      points={{112,-73.18},{112,-20},{-62.5,-20},{-62.5,6.78}},
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
  connect(radiator_ML.ConvectiveHeat, idealSink.port) annotation (Line(points={{98.6,
          -67.78},{98.6,-66},{66,-66},{66,-46},{70,-46}},  color={191,0,0}));
  connect(radiator_ML.RadiativeHeat, idealSink.port) annotation (Line(points={{109.6,
          -67.6},{109.6,-62},{70,-62},{70,-46}}, color={95,95,95}));
  connect(radiator_ML1.ConvectiveHeat, idealSink1.port) annotation (Line(points
        ={{102.6,24.22},{102.6,26},{70,26},{70,46},{74,46}}, color={191,0,0}));
  connect(radiator_ML1.RadiativeHeat, idealSink1.port) annotation (Line(points=
          {{113.6,24.4},{113.6,30},{74,30},{74,46}}, color={95,95,95}));
  connect(pump.enthalpyPort_b, radiator_ML1.enthalpyPort_a1) annotation (Line(
        points={{9.52,7},{53.76,7},{53.76,18.82},{100,18.82}}, color={176,0,0}));
  connect(radiator_ML1.enthalpyPort_b1, boilerBase.enthalpyPort_a1) annotation
    (Line(points={{116,18.82},{122,18.82},{122,18},{126,18},{126,-94},{-84,-94},
          {-84,6.78},{-62.5,6.78}}, color={176,0,0}));
  connect(pump.enthalpyPort_b, radiator_ML.enthalpyPort_a1) annotation (Line(
        points={{9.52,7},{52.76,7},{52.76,-73.18},{96,-73.18}}, color={176,0,0}));
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
