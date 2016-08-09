within AixLib.Building.Components.Walls.BaseClasses;
model ActiveLayer "as inner layer, only conduction"

parameter Modelica.SIunits.Area A = 10 "Area of the element";

parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
  "Initial temperature, in degrees Celsius";

parameter Modelica.SIunits.ThermalConductivity lambda;

parameter Modelica.SIunits.SpecificHeatCapacity c_p;

parameter Modelica.SIunits.Length d;

parameter Modelica.SIunits.Density rho;


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portActiveLayer_a
    "layer towards the outside"
    annotation (Placement(transformation(extent={{-24,92},{-4,112}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b portActiveLayer_b
    "layer towards the inside"
    annotation (Placement(transformation(extent={{-24,-84},{-4,-104}})));
  parameter Integer surfaceOrientation=1 "Surface orientation" annotation(Dialog(descriptionLabel = true, enable = if IsAlphaConstant == true then false else true), choices(choice=1
      "vertical",                                                                                                    choice = 2
      "horizontal facing up",                                                                                                    choice = 3
      "horizontal facing down",                                                                                                    radioButtons = true));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow(
      T_ref=T0)
    annotation (Placement(transformation(extent={{10,-22},{-10,-2}})));
  Modelica.Blocks.Math.Gain gain(k=A)
    annotation (Placement(transformation(extent={{36,-18},{24,-6}})));
  Modelica.Blocks.Interfaces.RealInput PowerPerSqm(unit="W/m2")
    "power per square meter" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,10})));
  AixLib.HVAC.Meter.EEnergyMeter     eEnergyMeter annotation (
      Placement(transformation(extent={{64,-60},{84,-40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalResistor_toOutside(G=A*
        lambda/(d/2)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,66})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalResistor_toInside(G=A*
        lambda/(d/2)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-14,-56})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(T(start=
          T0), C=c_p*rho*A*d)
    annotation (Placement(transformation(extent={{-56,-14},{-36,6}})));
equation

  connect(prescribedHeatFlow.Q_flow, gain.y) annotation (Line(
      points={{10,-12},{23.4,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, eEnergyMeter.p) annotation (Line(
      points={{23.4,-12},{18,-12},{18,-50},{65.4,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(thermalResistor_toOutside.port_b, portActiveLayer_a) annotation (Line(
      points={{-16,76},{-16,102},{-14,102}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gain.u, PowerPerSqm) annotation (Line(points={{37.2,-12},{70,-12},{70,
          10},{120,10}}, color={0,0,127}));
  connect(heatCapacitor.port, prescribedHeatFlow.port)
    annotation (Line(points={{-46,-14},{-10,-14},{-10,-12}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalResistor_toOutside.port_a) annotation (
      Line(points={{-46,-14},{-30,-14},{-30,56},{-16,56}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalResistor_toInside.port_b) annotation (Line(
        points={{-46,-14},{-30,-14},{-30,-46},{-14,-46}}, color={191,0,0}));
  connect(thermalResistor_toInside.port_a, portActiveLayer_b)
    annotation (Line(points={{-14,-66},{-14,-94}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={
        Rectangle(
          extent={{-100,6},{100,-6}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.HorizontalCylinder),
      Rectangle(
        extent={{-100,66},{100,40}},
        lineColor={166,166,166},
        pattern=LinePattern.None,
        fillColor={190,190,190},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{100,100},{-100,66}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{100,40},{-100,6}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{100,-6},{-100,-40}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-100,-40},{100,-66}},
        lineColor={166,166,166},
        pattern=LinePattern.None,
        fillColor={190,190,190},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{100,-66},{-100,-102}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid),
        Line(
          points={{-22,26},{-22,82}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-20,62},{62,40}},
          lineColor={255,0,0},
          textString="Q_flow"),
        Text(
          extent={{-20,-46},{62,-68}},
          lineColor={255,0,0},
          textString="Q_flow"),
        Line(
          points={{0,-28},{0,28}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled},
          origin={-22,-54},
          rotation=180)}));
end ActiveLayer;
