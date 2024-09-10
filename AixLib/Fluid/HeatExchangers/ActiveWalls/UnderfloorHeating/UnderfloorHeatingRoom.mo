within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model UnderfloorHeatingRoom "Model for heating of one room with underfloor heating"
  extends UnderfloorHeating.BaseClasses.PartialModularPort_ab(final nPorts=nCircuits,
                   final m_flow_nominal=m_flow_PanelHeating);
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;
  extends AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PartialUnderFloorHeatingParameters;

  final parameter Integer nCircuits(min=1) = integer(ceil(length/lengthMax))
    "Number of circuits in one zone";

  parameter Modelica.Units.SI.Length lengthMax=120
    "Maximum Length for one Circuit" annotation (Dialog(group="Panel Heating"));
  parameter Modelica.Units.SI.Power Q_flow_nominal
    "Nominal heat load for room with panel heating"
    annotation (Dialog(group="Room Specifications"));
  final parameter Modelica.Units.SI.HeatFlux q_flow_nominal=Q_flow_nominal/A
    "Area specific heat flow rate ";
  final parameter Modelica.Units.SI.Power Q_F=if q_flow_nominal <= q_G then
      q_flow_nominal*A else q_G*A "nominal heat flow of panel heating";

  parameter Modelica.Units.SI.Temperature TSup_nominal
    "Nominal supply temperature";
  parameter Modelica.Units.SI.Temperature TRet_nominal
    "Nominal return temperature";
  parameter Modelica.Units.SI.PressureDifference dpPipe_nominal=100*length
    "Nominal pressure drop in every heating circuit"
    annotation (Dialog(group="Pressure Drop"));
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal=0
    "Pressure Difference set in regulating valve for pressure equalization" annotation (Dialog(group=
          "Pressure Drop"));
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal=0
    "Additional pressure drop for every heating circuit, e.g. for distributor" annotation (Dialog(group="Pressure Drop"));

  parameter Modelica.Units.SI.Temperature TZone_nominal=20 + 273.15
    "Nominal zone temperature" annotation (Dialog(group="Room Specifications"));
  final parameter Modelica.Units.SI.HeatFlux q_Gmax=8.92*(TSurMax -
      TZone_nominal)^(1.1)
    "Maximum possible heat flux with given surface temperature and room temperature";
  parameter Boolean Ceiling "false if ground plate is under panel heating"
    annotation (Dialog(group="Room Specifications"), choices(checkBox=true));

  parameter Modelica.Units.SI.Temperature T_U=293.15
    "Nominal Room Temperature lying under panel heating"
    annotation (Dialog(group="Room Specifications"));

  parameter Modelica.Units.SI.Distance spacing "Spacing between tubes"
    annotation (Dialog(group="Panel Heating"));
  parameter Modelica.Units.SI.Diameter d(min = dOut) = dOut "Outer diameter of pipe including Sheathing" annotation (Dialog( group = "Panel Heating", enable = withSheathing));
  final parameter Modelica.Units.SI.Length length=A/spacing
    "Possible pipe length for given panel heating area";

  final parameter Modelica.Units.SI.Thickness InsulationThickness=
      wallTypeCeiling.d[1] "Thickness of thermal insulation";
  final parameter Modelica.Units.SI.ThermalConductivity lambda_ins=
      wallTypeCeiling.lambda[1] "Thermal conductivity of thermal insulation";
  final parameter Modelica.Units.SI.ThermalInsulance R_lambdaIns= InsulationThickness/lambda_ins "Thermal resistance of thermal insulation";

  final parameter Modelica.Units.SI.Thickness CoverThickness=
    "thickness of cover above pipe";
  final parameter Modelica.Units.SI.ThermalConductivity lambda_u=wallTypeFloor.lambda[1]
    "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
  final parameter Modelica.Units.SI.ThermalConductivity lambda_E=lambda_u
    "Thermal conductivity of cover";

  final parameter Modelica.Units.SI.ThermalInsulance R_lambdaB=wallTypeFloor.d[2]
      /wallTypeFloor.lambda[2] "Thermal resistance of flooring";

  final parameter Modelica.Units.SI.ThermalInsulance R_lambdaCeiling=if Ceiling
       then wallTypeCeiling.d[2]/wallTypeCeiling.lambda[2] else (wallTypeCeiling.d[2]/wallTypeCeiling.lambda[2] + wallTypeCeiling.d[3]/wallTypeCeiling.lambda[3] + wallTypeCeiling.d[4]/wallTypeCeiling.lambda[4])
    "Thermal resistance of ceiling";
  final parameter Modelica.Units.SI.ThermalInsulance R_lambdaPlaster=if Ceiling
       then wallTypeCeiling.d[3]/wallTypeCeiling.lambda[3] else 0
    "Thermal resistance of plaster";
  final parameter Modelica.Units.SI.CoefficientOfHeatTransfer alpha_Ceiling = 5.8824 "Coefficient of heat transfer at Ceiling Surface";

  final parameter Modelica.Units.SI.ThermalInsulance R_U=EN_1264.R_U
    "Thermal resistance of wall layers under panel heating";
  final parameter Modelica.Units.SI.ThermalInsulance R_O=EN_1264.R_O
    "Thermal resistance of wall layers above panel heating";

  final parameter Modelica.Units.SI.TemperatureDifference sigma_i=TSup_nominal -
      TRet_nominal
    "Temperature spread for room (max = 5 for room with highest heat load)"
    annotation (Dialog(group="Room Specifications"));

  final parameter Modelica.Units.SI.MassFlowRate m_flow_PanelHeating=A*
      q_flow_nominal/(sigma_i*Cp_Medium)*(1 + (R_O/R_U) + (TZone_nominal - T_U)/
      (q_flow_nominal*R_U)) "nominal mass flow rate";
  final parameter Modelica.Units.SI.MassFlowRate m_flow_Circuit=
      m_flow_PanelHeating/nCircuits
    "Nominal mass flow rate in each heating circuit";

  final parameter Real K_H=EN_1264.K_H
    "Specific parameter for dimensioning according to EN 1264 that shows the relation between temperature difference and heat flux";
  final parameter Modelica.Units.SI.HeatFlux q_G=EN_1264.q_G
    "specific limiting heat flux";
  parameter Modelica.Units.SI.TemperatureDifference dT_Hi
    "Nominal temperature difference between heating medium"
    annotation (Dialog(group="Panel Heating"));
  final parameter Modelica.Units.SI.TemperatureDifference dT_HU=
      UnderfloorHeating.BaseClasses.logDT({TSup_nominal,TRet_nominal,T_U});

  final parameter Modelica.Units.SI.ThermalResistance R_add=1/(K_H*(1 + R_O/R_U*
      dT_Hi/dT_HU)*A + A*(TZone_nominal - T_U)/(R_U*dT_HU)) - 1/(A/R_O + A/R_U*
      dT_Hi/dT_HU) - R_pipe - 1/(2200*Modelica.Constants.pi*dInn*length)
    "additional thermal resistance";
  final parameter Modelica.Units.SI.ThermalResistance R_pipe=if withSheathing
       then (log(dOut + thicknessSheathing/dOut))/(2*sheathingMaterial.lambda*
      Modelica.Constants.pi*length) + (log(dOut/dInn))/(2*pipeMaterial.lambda*Modelica.Constants.pi*length)
       else (log(dOut/dInn))/(2*pipeMaterial.lambda*Modelica.Constants.pi*length)
    "thermal resistance through pipe layers";
  parameter Integer use_vmax(min=1, max=2) "Output if v > v_max (0.5 m/s)"
    annotation (choices(choice=1 "Warning", choice=2 "Error"));
  parameter Integer calculateVol annotation (Dialog(group="Panel Heating",
        descriptionLabel=true), choices(
      choice=1 "Calculate Water Volume with inner diameter",
      choice=2 "Calculate Water Volume with time constant",
      radioButtons=true));

  UnderfloorHeatingCircuit circuits[nCircuits](
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final C_nominal=C_nominal,
    each final mSenFac=mSenFac,
    each final dp_Pipe=dpPipe_nominal,
    each final dp_Valve=dpValve_nominal,
    each final dpFixed_nominal=dpFixed_nominal,
    each final TSurMax=TSurMax,
    each final TRoom_nominal=TZone_nominal,
    each final pipeMaterial=pipeMaterial,
    each final thicknessPipe=thicknessPipe,
    each final dOut=dOut,
    each final withSheathing=withSheathing,
    each final sheathingMaterial=sheathingMaterial,
    redeclare each final package Medium = Medium,
    each final A=A/nCircuits,
    each final dis=dis,
    each final raiseErrorForMaxVelocity=raiseErrorForMaxVelocity,
    each final spacing=spacing,
    each m_flow_nominal=m_flow_Circuit,
    each final wallTypeFloor=wallTypeFloor,
    each final wallTypeCeiling=wallTypeCeiling,
    each R_x=R_add*nCircuits) "Underloor heating circuits"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  BaseClasses.EN1264.HeatFlux EN_1264(
    lambda_E=lambda_E,
    R_lambdaB0=R_lambdaB,
    wallTypeFloor=wallTypeFloor,
    wallTypeCeiling=wallTypeCeiling,
    R_lambdaIns=R_lambdaIns,
    alpha_Ceiling=alpha_Ceiling,
    T_U=T_U,
    d_a=dOut,
    lambda_R=pipeMaterial.lambda,
    s_R=thicknessPipe,
    withSheathing=withSheathing,
    lambda_M=sheathingMaterial.lambda,
    s_u=CoverThickness,
    T_Fmax=TSurMax,
    T_Room=TZone_nominal,
    q_Gmax=q_Gmax,
    dT_H=dT_Hi,
    Ceiling=Ceiling,
    R_lambdaCeiling=R_lambdaCeiling,
    R_lambdaPlaster=R_lambdaPlaster,
    D=dOut + thicknessSheathing,
    T=spacing)
    annotation (Placement(transformation(extent={{-100,-60},{-60,-40}})));
  Modelica.Blocks.Interfaces.RealInput uVal
    "Control value for valve (0: closed, 1: open)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,60})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theColConFlo(final m=nCircuits)
             "Join discretized radiative values" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,50})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theColRadFlo(final m=nCircuits)
             "Join discretized radiative values" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,50})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theColRadCei(final m=nCircuits)
             "Join discretized radiative values of ceiling" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,-70})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector theColConCei(final m=nCircuits)
                   "Join discretized radiative values" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={22,-70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portConCei
    "Convective heat port of ceiling"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portRadCei
    "Radiative heat port of ceiling"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portRadFloor
    "Radiative heat port of floor"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portConFloor
    "Convective heat port of floor"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMax[nCircuits](unit="K",
      displayUnit="degC") "Maximum floor temperature"
    annotation (Placement(transformation(extent={{100,78},{120,98}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMea[nCircuits](unit="K",
      displayUnit="degC") "Mean floor temperature"
    annotation (Placement(transformation(extent={{100,38},{120,58}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMin[nCircuits](unit="K",
      displayUnit="degC") "Minimal floor temperature"
    annotation (Placement(transformation(extent={{100,58},{120,78}})));
protected
   parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.SpecificHeatCapacity Cp_Medium=Medium.specificHeatCapacityCp(sta_default)
    "Specific Heat capacity of medium";

initial equation
  assert(q_Gmax >= K_H*dT_Hi and q_G >= K_H*dT_Hi, "Panel Heating Parameters evaluate to a limiting heat flux that exceeds the maximum limiting heat flux in"
     + getInstanceName());

  if Ceiling then
    assert(wallTypeFloor.n == 2 and wallTypeCeiling.n == 3, "EN 1264 calculates parameters only for panel heating type A (2 floor layers, 3 ceiling layers). Error accuring in"
       + getInstanceName());
  else
    assert(wallTypeFloor.n == 2 and wallTypeCeiling.n == 4, "EN 1264 calculates parameters only for panel heating type A (2 floor layers, 4 ground plate layers). Error accuring in"
       + getInstanceName());
  end if;

  if T_U >= 18 + 273.15 then
    assert(R_lambdaIns >= 0.75, "Thermal resistivity of insulation layer needs to be greater than 0.75 m²K / W (see EN 1264-4 table 1)");
  else
    assert(R_lambdaIns >= 1.25, "Thermal resistivity of insulation layer needs to be greater than 1.25 m²K / W (see EN 1264-4 table 1)");
  end if;
  assert(TRet_nominal < TSup_nominal, "Return Temperature is higher than the Flow Temperature in"
     + getInstanceName());
equation

  // FLUID CONNECTIONS

  for i in 1:nCircuits loop
    connect(ports_a[i], circuits[i].port_a) annotation (Line(points={{-100,0},{-20,
            0}},                                 color={0,127,255}));
    connect(circuits[i].port_b, ports_b[i]) annotation (Line(points={{20,0},{100,
            0}},                            color={0,127,255}));

  end for;

  // VALVE CONNECTION
  for i in 1:nCircuits loop
    connect(uVal, circuits[i].uVal) annotation (Line(points={{-120,60},{-36,60},
            {-36,12},{-23.6,12}}, color={0,0,127}));
  end for;
  connect(theColConFlo.port_a, circuits.portConFloor)
    annotation (Line(points={{20,40},{20,28},{8,28},{8,20}}, color={191,0,0}));
  connect(circuits.portRadFloor, theColRadFlo.port_a) annotation (Line(points={{-8,20},
          {-8,38},{-20,38},{-20,40}},        color={191,0,0}));
  connect(circuits.portRadCei, theColRadCei.port_a) annotation (Line(points={{-8,-20},
          {-8,-52},{-20,-52},{-20,-60}},           color={191,0,0}));
  connect(theColConCei.port_a, circuits.portConCei) annotation (Line(points={{22,-60},
          {22,-50},{8,-50},{8,-20}},           color={191,0,0}));
  connect(theColConCei.port_b, portConCei) annotation (Line(points={{22,-80},{22,
          -82},{40,-82},{40,-100}}, color={191,0,0}));
  connect(theColRadCei.port_b, portRadCei) annotation (Line(points={{-20,-80},{-20,
          -82},{-40,-82},{-40,-100}}, color={191,0,0}));
  connect(theColConFlo.port_b, portConFloor) annotation (Line(points={{20,60},{20,
          80},{40,80},{40,100}}, color={191,0,0}));
  connect(theColRadFlo.port_b, portRadFloor) annotation (Line(points={{-20,60},{
          -20,80},{-40,80},{-40,100}}, color={191,0,0}));
  connect(circuits.TFloorMax, TFloorMax) annotation (Line(points={{22,14},{84,14},
          {84,88},{110,88}},                color={0,0,127}));
  connect(circuits.TFloorMin, TFloorMin) annotation (Line(points={{22,10},{86,10},
          {86,68},{110,68}},             color={0,0,127}));
  connect(circuits.TFloorMea, TFloorMea) annotation (Line(points={{22,6},{90,6},
          {90,48},{110,48}},             color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-100,-62},{100,-70}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,42},{100,-10}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{-86,6},{-76,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-66,6},{-56,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,6},{-36,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-26,6},{-16,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,6},{4,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,6},{24,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,6},{44,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,6},{64,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{74,6},{84,-4}},
          lineColor={175,175,175},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,50},{100,42}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,-10},{100,-48}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-48},{100,-62}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Text(
          extent={{-78,32},{-54,22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175},
          textString="R_o"),
        Line(points={{-48,50},{-52,46},{-52,28},{-56,26},{-52,24},{-52,8},{-48,4}},
            color={0,0,0}),
        Text(
          extent={{-80,-34},{-56,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175},
          textString="R_u"),
        Line(points={{-48,-2},{-52,-6},{-52,-38},{-56,-40},{-52,-42},{-52,-66},{
              -46,-70}}, color={0,0,0})}),Documentation(
   info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for heat transfer of an underfloor heating for one room
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  This model calculates the number of heating circuits needed for the
  heating of one room by an underfloor heating.
</p>
<p>
  Every heating circuit has an equal percentage valve that has to be
  regulated from outside.
</p>
<p>
  For the determination of the nominal mass flow the regulations by
  prEN 1264 are implemented.
</p><b><span style=\"color: #008000;\">Layer Structure</span></b>
<p>
  For dimensioning it is important that the layer structure of the
  floor is set right!
</p>
<p>
  The wall layers above the heating circuits have to be in the
  following order:
</p>
<p>
  1. Cover/Screed
</p>
<p>
  2. Floor
</p>
<p>
  The wall layers below the heating circuits need to be in the record
  with the following order:
</p>
<p>
  1. Isolation
</p>
<p>
  2. Load-bearing substrate
</p>
<p>
  3. Plaster
</p>
<p>
  If there is a floor plate underneath the heating circuits, the wall
  record needs to consist of 4 layers, whereas the first layer needs to
  be the isolation!
</p><b><span style=\"color: #008000;\">Isolation</span></b>
<p>
  The thermal resistance of the isolation needs to fulfill the
  following requirements:
</p>
<p>
  Room underneath the underfloor heating is heated:
  R<sub>lambda,Ins</sub> <code>&gt;= 0,75 W/m²K</code>
</p>
<p>
  Room underneath the underfloor heating is not heated / floor plate:
  R<sub>lambda,Ins</sub> <code>&gt;= 1,25 W/m²K</code>
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
</html>"));
end UnderfloorHeatingRoom;
