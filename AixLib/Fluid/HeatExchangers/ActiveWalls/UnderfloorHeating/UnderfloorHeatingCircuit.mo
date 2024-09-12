within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model UnderfloorHeatingCircuit "One Circuit in an Underfloor Heating System"
  extends
    AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PartialUnderFloorHeating;
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal=1
    "Pressure Difference set in regulating valve for pressure equalization in heating system"
    annotation (Dialog(group="Pressure Drop"));
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal = 0
    "Nominal additional pressure drop e.g. for distributor"
    annotation (Dialog(group="Pressure Drop"));
  parameter Modelica.Units.SI.Length length
    "Length of panel heating pipe" annotation (Dialog(group="Panel Heating"));
  parameter Modelica.Units.SI.Temperature TRoom_nominal=293.15
    "Nominal Room Temperature" annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Distance spacing "Spacing between tubes"
    annotation (Dialog(group="Panel Heating"));

  AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.UnderfloorHeatingElement
    ufhEle[dis](
    redeclare each final package Medium = Medium,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final C_nominal=C_nominal,
    each final mSenFac=mSenFac,
    each final thicknessSheathing=thicknessSheathing,
    each final pipeMaterial=pipeMaterial,
    each final sheathingMaterial=sheathingMaterial,
    each final energyDynamicsWalls=energyDynamics,
    each final m_flow_nominal=m_flow_nominal,
    each final A=A/dis,
    each final thicknessPipe=thicknessPipe,
    each final dis=integer(dis),
    each final length=length/dis,
    each final dOut=dOut,
    each final wallTypeFloor=wallTypeFloor,
    each final wallTypeCeiling=wallTypeCeiling,
    each final raiseErrorForMaxVelocity=raiseErrorForMaxVelocity,
    each final R_x=R_x*dis) "UFH element"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  AixLib.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    each m_flow_nominal=m_flow_nominal,
    from_dp=false,
    dpValve_nominal=dpValve_nominal,
    dpFixed_nominal=dpFixed_nominal)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.RealInput uVal
    "Control input for valve (0: closed, 1: open)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-118,60})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theColRadFlo(final m=
        dis) "Join discretized radiative values" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,62})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.RadiativeConvectiveHeatTransfer radConSplFlo[dis](
    each eps=wallTypeFloor.eps,
    each surfaceOrientation=2,
    each A=A/dis)
         "Splitter for radiative and convective heat of floor" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theColConFlo(final m=
        dis) "Join discretized radiative values" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,62})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portRadFloor
    "Radiative heat port of floor"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portConFloor
    "Convective heat port of floor"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portConCei
    "Convective heat port of ceiling"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portRadCei
    "Radiative heat port of ceiling"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theColRadCei(final m=
        dis) "Join discretized radiative values of ceiling" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,-60})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theColConCei(final m=
        dis) "Join discretized radiative values" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={20,-60})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.RadiativeConvectiveHeatTransfer radConSplCei[dis](
    each eps=wallTypeFloor.eps,
    each surfaceOrientation=2,
    each A=A/dis)
         "Splitter for radiative and convective heat of ceiling" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-30})));
  BaseClasses.DiscretizedFloorTemperatureAnalysis
    discretizedFloorTemperatureAnalysis
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMea(unit="K", displayUnit="degC")
    "Mean floor temperature"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMin(unit="K", displayUnit="degC")
    "Minimal floor temperature"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMax(unit="K", displayUnit="degC")
    "Maximum floor temperature"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));

      parameter Modelica.Units.SI.PressureDifference dp_Pipe=100*length
    "Nominal pressure drop" annotation (Dialog(group="Pressure Drop"));
      parameter Modelica.Units.SI.PressureDifference dp_Valve=0
    "Pressure Difference set in regulating valve for pressure equalization in heating system"
    annotation (Dialog(group="Pressure Drop"));


  FixedResistances.HydraulicDiameter resPip(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    final show_T=show_T,
    final dh=dInn,
    final length=length,
    final v_nominal=v) "Pressure loss model for pipe"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";


initial equation
  assert(
    resPip.dp_nominal + dpFixed_nominal + dpValve_nominal <= 25000,
    "According to prEN1264 pressure drop in a heating circuit is 
    supposed to be under 250 mbar. Error accuring in" + getInstanceName(),
    AssertionLevel.warning);

equation
  assert(
    TFloorMea <= TSurMax,
    "Mean surface temperature in" + getInstanceName() + "too high",
    AssertionLevel.warning);

  if dis > 1 then
    for i in 1:(dis-1) loop
      connect(ufhEle[i].port_b, ufhEle[i + 1].port_a) annotation (Line(
          points={{10,0},{14,0},{14,-6},{-16,-6},{-16,0},{-10,0}},
          color={0,127,255},
          pattern=LinePattern.Dash));

    end for;
  end if;
  connect(val.y, uVal)
    annotation (Line(points={{-40,12},{-40,60},{-118,60}}, color={0,0,127}));
  connect(radConSplFlo.portCon,theColConFlo. port_a)
    annotation (Line(points={{4,40},{4,44},{20,44},{20,52}}, color={191,0,0}));
  connect(radConSplFlo.portRad,theColRadFlo. port_a) annotation (Line(points={{-4,
          40},{-4,44},{-20,44},{-20,52}}, color={191,0,0}));
  connect(theColRadFlo.port_b, portRadFloor) annotation (Line(points={{-20,72},{
          -20,84},{-40,84},{-40,100}}, color={191,0,0}));
  connect(theColConFlo.port_b, portConFloor) annotation (Line(points={{20,72},{20,
          84},{40,84},{40,100}}, color={191,0,0}));
  connect(theColConCei.port_b, portConCei) annotation (Line(points={{20,-70},{20,
          -84},{40,-84},{40,-100}}, color={191,0,0}));
  connect(theColRadCei.port_b, portRadCei) annotation (Line(points={{-20,-70},{-20,
          -84},{-40,-84},{-40,-100}}, color={191,0,0}));
  connect(ufhEle.heaPorFloor, radConSplFlo.port_a) annotation (Line(points={{0,4.2},
          {0,12.7778},{-5.55112e-16,12.7778},{-5.55112e-16,20}}, color={191,0,0}));
  connect(radConSplCei.port_a, ufhEle.heaPorCei) annotation (Line(points={{1.83187e-15,
          -20},{1.83187e-15,-15.2222},{-0.2,-15.2222},{-0.2,-10.2}},    color={191,
          0,0}));
  connect(radConSplCei.portRad,theColRadCei. port_a) annotation (Line(points={{-4,
          -40},{-4,-44},{-20,-44},{-20,-50}}, color={191,0,0}));
  connect(radConSplCei.portCon, theColConCei.port_a) annotation (Line(points={{4,
          -40},{4,-44},{20,-44},{20,-50}}, color={191,0,0}));
  connect(discretizedFloorTemperatureAnalysis.port_a, ufhEle.heaPorFloor)
    annotation (Line(points={{40,30},{16,30},{16,16},{0,16},{0,4.2}},     color=
         {191,0,0}));
  connect(discretizedFloorTemperatureAnalysis.TFloorMea, TFloorMea) annotation (
     Line(points={{61,26},{94,26},{94,30},{110,30}}, color={0,0,127}));
  connect(discretizedFloorTemperatureAnalysis.TFloorMin, TFloorMin) annotation (
     Line(points={{61,30},{90,30},{90,50},{110,50}}, color={0,0,127}));
  connect(discretizedFloorTemperatureAnalysis.TFloorMax, TFloorMax) annotation (
     Line(points={{61,34},{84,34},{84,70},{110,70}}, color={0,0,127}));
  connect(val.port_b, ufhEle[1].port_a) annotation (Line(points={{-30,0},{-10,0}},
                                          color={0,127,255}));
  connect(ufhEle[dis].port_b, port_b) annotation (Line(points={{10,0},{100,0}},
                                     color={0,127,255}));
  connect(val.port_a, resPip.port_b)
    annotation (Line(points={{-50,0},{-60,0}}, color={0,127,255}));
  connect(port_a, resPip.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-100,40},{100,14}},
          lineColor={200,200,200},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,14},{100,-40}},
          lineColor={200,200,200},
          fillColor={150,150,150},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,10},{-80,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(points={{-80,10},{-78,6},{-80,10},{-82,6}}, color={238,46,47}),
        Ellipse(
          extent={{-84,-2},{-76,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-68,-2},{-60,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-52,-2},{-44,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-2},{-28,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-2},{-12,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,-2},{4,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{12,-2},{20,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,-2},{36,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{44,-2},{52,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{60,-2},{68,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{76,-2},{84,-10}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-64,10},{-64,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-48,10},{-48,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-32,10},{-32,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-16,10},{-16,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,10},{0,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{16,10},{16,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{32,10},{32,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{48,10},{48,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{64,10},{64,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{80,10},{80,2}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(points={{-64,10},{-62,6},{-64,10},{-66,6}}, color={238,46,47}),
        Line(points={{-48,10},{-46,6},{-48,10},{-50,6}}, color={238,46,47}),
        Line(points={{-32,10},{-30,6},{-32,10},{-34,6}}, color={238,46,47}),
        Line(points={{-16,10},{-14,6},{-16,10},{-18,6}}, color={238,46,47}),
        Line(points={{0,10},{2,6},{0,10},{-2,6}}, color={238,46,47}),
        Line(points={{16,10},{18,6},{16,10},{14,6}}, color={238,46,47}),
        Line(points={{32,10},{34,6},{32,10},{30,6}}, color={238,46,47}),
        Line(points={{48,10},{50,6},{48,10},{46,6}}, color={238,46,47}),
        Line(points={{64,10},{66,6},{64,10},{62,6}}, color={238,46,47}),
        Line(points={{80,10},{82,6},{80,10},{78,6}}, color={238,46,47})}),Documentation(
   info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for a heating circuit within wall layers
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  The heating circuits consists of <i>dis</i> pipe elements of the
  model <a href=
  \"UnderfloorHeating.UnderfloorHeatingElement\">UnderfloorHeatingElement</a>
</p>
<p>
  The middle surface temperature is calculated and a maximum surface
  temperature is checked within the model.
</p>
<p>
  A two way equal percentage valve sets the pressure difference and
  mass flow.
</p>
<p>
  <b><span style=\"color: #008000;\">Heat Transfer</span></b>
</p>
<p>
  The heat transfer from the fluid to the surface of the wall elements
  is split into the following parts:
</p>
<p>
  - convection from fluid to inner pipe
</p>
<p>
  - heat conduction in pipe layers
</p>
<p>
  - heat transfer from pipe outside to heat conductive floor layer
</p>
<p>
  - heat conduction through upper wall layers
</p>
<p>
  - heat conduction through lower wall layers
</p>
<p>
  <b><span style=\"color: #008000;\">Thermal Resistance R_x</span></b>
</p>
<p>
  The thermal resistance R_x represents the heat transfer from pipe
  outside to the middle temperaatur of the heat conductive layer. It
  needs to be added according to the type of the heating systen (see EN
  11855-2 p. 45).
</p><b><span style=\"color: #008000;\">Water Volume</span></b>
<p>
  The water volume in the pipe element can be calculated by the inner
  diameter of the pipe or by time constant and the mass flow.
</p>
<p>
  The maximum velocity in the pipe is set for 0.5 m/s. If the Water
  Volume is calculated by time constant, a nominal inner diameter is
  calculated with the maximum velocity for easier parametrization.
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end UnderfloorHeatingCircuit;
