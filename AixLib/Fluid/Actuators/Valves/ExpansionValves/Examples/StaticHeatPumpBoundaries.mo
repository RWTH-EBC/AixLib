within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
model StaticHeatPumpBoundaries
  "Base model to test expansion valve using static heat pump boundaries"
  extends Modelica.Icons.Example;

  // Definition of medium
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium of the compressor"
    annotation(Dialog(tab="General",group="General"),
               choicesAllMatching=true,
    Documentation(revisions="<html>
</html>"));

  // Definition of parameters describing compressors
  //
  parameter Integer nVal = 1
    "Numer of compressors in parallel"
    annotation(Dialog(tab="General",group="Compressors"));

  // Definition of parameters describing boundary conditions
  //
  parameter Modelica.Units.SI.TemperatureDifference dTPinEva=2
    "Pinch temperature at evaporator's outlet"
    annotation (Dialog(tab="General", group="Evaporator"));
  parameter Modelica.Units.SI.TemperatureDifference dTSupHea=1
    "Superheating of working fluid"
    annotation (Dialog(tab="General", group="Evaporator"));

  parameter Modelica.Units.SI.TemperatureDifference dTPinCond=2
    "Pinch temperature at condenser's outlet"
    annotation (Dialog(tab="General", group="Condenser"));
  parameter Modelica.Units.SI.TemperatureDifference dTSubCool=4
    "Supercooling of working fluid"
    annotation (Dialog(tab="General", group="Condenser"));

  parameter Modelica.Units.SI.Density dSec=1000
    "Constant density of secondary fluid"
    annotation (Dialog(tab="General", group="Condenser"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cpSec=4.1813e3
    "Constant specific heat capacity of secondary fluid"
    annotation (Dialog(tab="General", group="Condenser"));
  parameter Modelica.Units.SI.VolumeFlowRate V_flowSec=(0.776 + 0.781 + 0.44)/3
      /3600 "Constant volume flow of secondary fluid"
    annotation (Dialog(tab="General", group="Condenser"));

  // Definition of variables describing boundary conditions
  //
  Modelica.Blocks.Sources.CombiTimeTable inpDat(
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation,
    columns=2:7,
    table=[0,64,285.15,5180,308.15,900,5.755555556; 1,64,283.15,4920,308.15,910,
        5.406593407; 2,63,280.15,4370,308.15,930,4.698924731; 3,64,285.15,4980,318.15,
        1140,4.368421053; 4,64,283.15,4730,318.15,1140,4.149122807; 5,55,285.15,
        4180,328.15,1240,3.370967742; 6,64,283.15,4650,328.15,1380,3.369565217;
        7,63,280.15,4160,318.15,1610,2.583850932; 8,55,275.15,2800,308.15,790,3.544303797;
        9,106,258.15,3760,308.15,1570,2.394904459; 10,115,266.15,4850,308.15,1940,
        2.5; 11,55,275.15,2640,318.15,960,2.75; 12,111,258.15,4150,318.15,2120,1.95754717;
        13,107,270.15,4780,318.15,2210,2.162895928; 14,113,266.15,4560,318.15,2290,
        1.991266376; 15,100,266.15,3880,328.15,2240,1.732142857; 16,63,275.15,3280,
        328.15,1330,2.466165414; 17,63,280.15,4080,328.15,1400,2.914285714],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    "Static boundaries of compressor model"
    annotation (Placement(transformation(extent={{-90,-92},{-70,-72}})));

  Modelica.Blocks.Sources.RealExpression inpSetSpeEnt(y=con.hOut)
    "Expressions describing set point of specific enthalpy"
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Sources.RealExpression inpAmbTemp(y=inpDat.y[2])
    "Expressions describing ambient temperature"
    annotation (Placement(transformation(extent={{-90,-24},{-70,-4}})));
  Modelica.Blocks.Sources.RealExpression inpColCap(y=inpDat.y[3] - inpDat.y[5])
    "Expressions describing col capacity"
    annotation (Placement(transformation(extent={{-90,-38},{-70,-18}})));
  Modelica.Blocks.Sources.RealExpression inpHeaCap(y=inpDat.y[3])
    "Expressions describing heat capacity"
    annotation (Placement(transformation(extent={{-90,-52},{-70,-32}})));
  Modelica.Blocks.Sources.RealExpression inpTFlo(y=inpDat.y[4])
    "Expressions describing flow temperature at heat capacity"
    annotation (Placement(transformation(extent={{-90,-66},{-70,-46}})));

  // Definition of subcomponents
  //
  StaticEvaporator eva(
    redeclare final package Medium = Medium,
    final dTPin=dTPinEva,
    final dTSupHea=dTSupHea,
    nPorts=nVal)
    "Model that describes a simple static evaporator"
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));

  Modelica.Blocks.Continuous.LimPID conPID(
    k=0.001,
    Ti=10,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMax=1,
    yMin=0.05) "PID controller to set valves' openings"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.RealExpression inpCurSpeEnt(y=eva.hInl)
    "Expressions describing current specific enthalpy"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Routing.Replicator repMea(nout=nVal)
    "Replicating the current value of the manipulated variables"
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  ModularExpansionValves.ModularExpansionValvesSensors modExpVal(
    redeclare package Medium = Medium,
    nVal=nVal,
    redeclare model SimpleExpansionValve =
        SimpleExpansionValves.IsenthalpicExpansionValve,
    AVal=fill(1.767e-6, nVal),
    useExt=true,
    useInpFil=fill(true, nVal),
    redeclare model FlowCoefficient =
        Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
    risTim=fill(0.01328, nVal))
    "Model that describes modular expansion valves in parallel" annotation (
      Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=90,
        origin={50,30})));

  StaticCondenser con(
    redeclare package Medium = Medium,
    dTSubCool=dTSubCool,
    dTPin=dTPinCond,
    dSec=dSec,
    cpSec=cpSec,
    V_flowSec=V_flowSec)
    "Model that describes a simple static condenser"
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));

  AixLib.Controls.Interfaces.ModularHeatPumpControlBus dataBus(nVal=nVal)
    "Connector that contains all control signals" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,30}),   iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-98,0})));

protected
  model StaticEvaporator
    "Static evaporator assuming constant pinch point at evaporator's outlet"

    // Definition of medium
    //
    replaceable package Medium = Modelica.Media.R134a.R134a_ph
      constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
      "Medium of the expansion valve"
      annotation(Dialog(tab="General",group="General"),
                 choicesAllMatching=true);

    // Definition of parameters describing evaporator
    //
    parameter Integer nPorts = 1;

    parameter Modelica.Units.SI.TemperatureDifference dTPin=5
      "Pinch temperature at evaporator's outlet"
      annotation (Dialog(tab="General", group="Evaporator"));
    parameter Modelica.Units.SI.TemperatureDifference dTSupHea=1
      "Superheating of working fluid"
      annotation (Dialog(tab="General", group="Evaporator"));

    // Definition of parameters describing assumptions
    //
    parameter Boolean allowFlowReversal = false
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation(Dialog(tab="Assumptions",group="General"), Evaluate=true);

    // Definition of connecotrs
    //
    Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts](
      redeclare each final package Medium = Medium,
      h_outflow(each start = Medium.h_default),
      m_flow(each max=Modelica.Constants.inf))
      "Fluid connectors b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{90,40},{110,-40}})));
    Modelica.Blocks.Interfaces.RealInput inpTAmb
      "Input of ambient temperature"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-40,-100}),
                            iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-40,-100})));
    Modelica.Blocks.Interfaces.RealInput inpQ_flow
      "Input of cold capacity"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={40,-100}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={40,-100})));

    // Definition of submodels
    //
    Modelica.Blocks.Sources.RealExpression inlPEva(y=pSat)
      "Expressions describing saturation pressure at evaporator's inlet"
      annotation (Placement(transformation(extent={{-48,-4},{-28,16}})));
    Modelica.Blocks.Sources.RealExpression inlhEva(y=hInl)
      "Expressions describing specific enthalpy at evaporator's inlet"
      annotation (Placement(transformation(extent={{-48,-18},{-28,2}})));

    AixLib.Fluid.Sources.Boundary_ph source(
      redeclare package Medium = Medium,
      use_p_in=true,
      use_h_in=true,
      nPorts=1)
      "Source with constant pressure and specific enthalpy"
      annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,0})));
    Interfaces.PortsAThroughPortB outVal(
      redeclare package Medium = Medium, nVal=nPorts)
      "Model that combines the outputs of modular expansion valves"
      annotation (Placement(transformation(extent={{40,-10},{20,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEnt[nPorts](
      redeclare package Medium = Medium,
      each m_flow_nominal=0.05,
      each initType=Modelica.Blocks.Types.Init.NoInit,
      each tau=0,
      each h_out_start=275e3) "Sensor that measures current specific enthalpy"
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    Sensors.MassFlowRate senMasFlo[nPorts](redeclare package Medium = Medium)
      "Sensor that measures current mas flow rate"
      annotation (Placement(transformation(extent={{66,-10},{46,10}})));

    // Definition of variables describing evaporator
    //
    Medium.SaturationProperties satEva
      "Saturation properties of the evaporator's working fluid"
      annotation (Placement(transformation(extent={{-72,-8},{-52,12}})));
    Medium.ThermodynamicState staOut
      "Thermodynamic state of the working fluid  at evaporator's outlet"
      annotation (Placement(transformation(extent={{-96,-8},{-76,12}})));

  public
    Modelica.Units.SI.AbsolutePressure pSat
      "Absolute pressure at evaporator's outlet";
    Modelica.Units.SI.Temperature TSat "Saturation temperature";

    Modelica.Units.SI.SpecificEnthalpy hInl
      "Specific enthalpy at evaporator's inlet";
    Modelica.Units.SI.SpecificEnthalpy hOut
      "Specific enthalpy at evaporator's outlet";
    Modelica.Units.SI.Temperature TOut "Temperature at evaporator's outlet";

    Modelica.Units.SI.Temperature TAmb "Temperature of ambient";

    Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate";
    Modelica.Units.SI.HeatFlowRate Q_flow "Cooling capacity";

  equation
    // Connection of ports
    //
    connect(inlPEva.y, source.p_in)
      annotation (Line(points={{-27,6},{-22,6},{-22,8},{-12,8}},
                                                             color={0,0,127}));
    connect(inlhEva.y, source.h_in)
      annotation (Line(points={{-27,-8},{-24,-8},{-20,-8},{-20,4},{-12,4}},
                               color={0,0,127}));
    connect(ports_b, senSpeEnt.port_a)
      annotation (Line(points={{100,0},{95,0},{90,0}}, color={0,127,255}));
    connect(senSpeEnt.port_b, senMasFlo.port_a)
      annotation (Line(points={{70,0},{66,0}},        color={0,127,255}));
    connect(source.ports[1], outVal.port_b)
      annotation (Line(points={{10,0},{20,0}},      color={0,127,255}));
    connect(senMasFlo.port_b, outVal.ports_a)
      annotation (Line(points={{46,0},{46,0},{40,0}}, color={0,127,255}));

    TAmb = inpTAmb
      "Temperature of ambient";
    m_flow = senMasFlo[1].m_flow
      "Mass flow rate";
    Q_flow = inpQ_flow
      "Cooling capacity";

    // Calculation of state properties of working fluid
    //
    satEva = Medium.setSat_T(T=TSat)
      "Saturation properties";
    staOut = Medium.setState_pT(p=pSat,T=TOut)
      "Thermodynamic state of the working fluid at evaporator's outlet";

    pSat = Medium.saturationPressure(satEva.Tsat)
      "Absolute pressure at evaporator's outlet";
    TSat = TOut - dTSupHea
      "Saturation temperature";

    hInl = hOut - Q_flow/m_flow
      "Specific enthalpy at evaporator's inlet";

    TOut = TAmb - dTPin
      "Temperature at evaporator's outlet";
    hOut = Medium.specificEnthalpy(staOut)
      "Specific enthalpy at evaporator's outlet";

    annotation (Icon(graphics={
          Rectangle(
            extent={{-100,70},{100,100}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-100,70},{100,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,-100},{100,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-100,70},{-100,-70},{-22,-70},{40,-70},{12,-68},{-22,-34},{-30,
                10},{-18,50},{18,66},{50,70},{-100,70}},
            lineColor={28,108,200},
            smooth=Smooth.Bezier,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,70},{-30,-70}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-38,70},{-56,52},{-32,28},{-50,4},{-26,-26},{-48,-52},{-40,-70}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{38,70},{20,52},{44,28},{26,4},{50,-26},{28,-52},{36,-70}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Text(
            extent={{-32,-26},{36,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag,
            textString="TP"),
          Text(
            extent={{-100,-26},{-40,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag,
            textString="SC"),
          Text(
            extent={{44,-26},{100,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag,
            textString="SH")}));
  end StaticEvaporator;

  model StaticCondenser
    "Static condenser assuming constant pinch point at condenser's outlet"

    // Definition of medium
    //
    replaceable package Medium = Modelica.Media.R134a.R134a_ph
      constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
      "Medium of the expansion valve"
      annotation(Dialog(tab="General",group="General"),
                 choicesAllMatching=true);

    // Definition of parameters describing condenser
    //
    parameter Modelica.Units.SI.TemperatureDifference dTPin=5
      "Pinch temperature at condenser's outlet"
      annotation (Dialog(tab="General", group="Condenser"));
    parameter Modelica.Units.SI.TemperatureDifference dTSubCool=8
      "Supercooling of working fluid"
      annotation (Dialog(tab="General", group="Condenser"));

    parameter Modelica.Units.SI.Density dSec=1000
      "Constant density of secondary fluid"
      annotation (Dialog(tab="General", group="Condenser"));
    parameter Modelica.Units.SI.SpecificHeatCapacity cpSec=4.1813e3
      "Constant specific heat capacity of secondary fluid"
      annotation (Dialog(tab="General", group="Condenser"));
    parameter Modelica.Units.SI.VolumeFlowRate V_flowSec=(0.776 + 0.781 + 0.44)
        /3/3600 "Constant volume flow of secondary fluid"
      annotation (Dialog(tab="General", group="Condenser"));

    // Definition of parameters describing assumptions
    //
    parameter Boolean allowFlowReversal = false
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation(Dialog(tab="Assumptions",group="General"), Evaluate=true);

    // Definition of connecotrs
    //
    Modelica.Fluid.Interfaces.FluidPort_b port_b(
      redeclare final package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
       h_outflow(start = Medium.h_default))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));
    Modelica.Blocks.Interfaces.RealInput inpQ_flow
      "Heat capacity"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,100})));
    Modelica.Blocks.Interfaces.RealInput inpTFlo
      "Temperature flow at heat capacity"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-20,100})));

    // Definition of subcomponents
    //
    Modelica.Blocks.Sources.RealExpression inlPCond(y=pSat)
      "Expressions describing saturation pressure at condenser's inlet"
      annotation (Placement(transformation(extent={{-30,-4},{-10,16}})));
    Modelica.Blocks.Sources.RealExpression inlTCon(y=TOut)
      "Expressions describing temperature at condenser's inlet"
      annotation (Placement(transformation(extent={{-30,-18},{-10,2}})));
    AixLib.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Medium,
      use_p_in=true,
      use_T_in=true,
      nPorts=1) "Source with constant pressure and temperature" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={20,0})));

    AixLib.Fluid.Sensors.SpecificEnthalpyTwoPort senSpeEnt(
      redeclare package Medium = Medium,
      m_flow_nominal=0.05,
      initType=Modelica.Blocks.Types.Init.NoInit,
      h_out_start=400e3,
      tau=0) "Sensor that measures current specific enthalpy"
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    AixLib.Fluid.Sensors.MassFlowRate senMasFlo(
      redeclare package Medium =Medium)
      "Sensor that measures current mas flow rate"
      annotation (Placement(transformation(extent={{60,-10},{40,10}})));

    // Definition of variables describing condenser
    //
    Medium.SaturationProperties satCon
      "Saturation properties of the condenser's working fluid"
      annotation (Placement(transformation(extent={{-60,-8},{-40,12}})));
    Medium.ThermodynamicState staOut
      "Thermodynamic state of the working fluid  at condenser's outlet"
      annotation (Placement(transformation(extent={{-90,-8},{-70,12}})));

  public
    Modelica.Units.SI.AbsolutePressure pSat
      "Absolute pressure at condenser's outlet";
    Modelica.Units.SI.Temperature TSat "Saturation temperature";

    Modelica.Units.SI.Temperature TOut "Temperature at condenser's outlet";
    Modelica.Units.SI.SpecificEnthalpy hOut
      "Specific enthalpy at condenser's outlet";

    Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate";
    Modelica.Units.SI.HeatFlowRate Q_flow "Heat capacity";

    Modelica.Units.SI.MassFlowRate m_flowSec
      "Mass flow rate of secondary fluid";
    Modelica.Units.SI.Temperature TFlo "Temperature flow at heat capacity";
    Modelica.Units.SI.Temperature TRetFlo
      "Temperature return flow at heat capacity";

  equation
    // Connection of ports
    //
    connect(inlPCond.y, sink.p_in)
      annotation (Line(points={{-9,6},{-4,6},{-4,8},{8,8}},
                                                         color={0,0,127}));
    connect(inlTCon.y, sink.T_in)
      annotation (Line(points={{-9,-8},{-6,-8},{-2,-8},{-2,4},{8,4}},
                                                                  color={0,0,127}));
    connect(sink.ports[1], senMasFlo.port_b)
      annotation (Line(points={{30,0},{40,0}}, color={0,127,255}));
    connect(senMasFlo.port_a, senSpeEnt.port_b)
      annotation (Line(points={{60,0},{70,0}}, color={0,127,255}));
    connect(senSpeEnt.port_a,port_b)
      annotation (Line(points={{90,0},{100,0}}, color={0,127,255}));

    m_flow = senMasFlo.m_flow
      "Mass flow rate";
    Q_flow = inpQ_flow
      "Heat capacity";
    TFlo = inpTFlo
      "Temperature flow at heat capacity";

    // Calculation of state properties of working fluid
    //
    satCon = Medium.setSat_T(T=TSat)
      "Saturation properties";
    staOut = Medium.setState_pT(p=pSat,T=TOut)
      "Thermodynamic state of the working fluid at condenser's outlet";

    pSat = Medium.saturationPressure(T=TSat)
      "Absolute pressure at condenser's outlet";
    TSat = TOut + dTSubCool
      "Saturation temperature";

    TOut = TRetFlo + dTPin
      "Temperature at condenser's outlet";
    hOut = Medium.specificEnthalpy(state=staOut)
      "Specific enthalpy at condenser's outlet";

    TRetFlo = TFlo - Q_flow/(m_flowSec*cpSec)
      "Temperature return flow at heat capacity";
    m_flowSec = dSec*V_flowSec
      "Mass flow rate of secondary fluid";

    annotation (Icon(graphics={
          Rectangle(
            extent={{-100,70},{100,100}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-100,70},{100,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,-100},{100,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-100,70},{-100,-70},{-22,-70},{40,-70},{12,-68},{-22,-34},{-30,
                10},{-18,50},{18,66},{50,70},{-100,70}},
            lineColor={28,108,200},
            smooth=Smooth.Bezier,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,70},{-30,-70}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-38,70},{-56,52},{-32,28},{-50,4},{-26,-26},{-48,-52},{-40,-70}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{38,70},{20,52},{44,28},{26,4},{50,-26},{28,-52},{36,-70}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Text(
            extent={{-32,-26},{36,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag,
            textString="TP"),
          Text(
            extent={{-100,-26},{-40,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag,
            textString="SC"),
          Text(
            extent={{44,-26},{100,-70}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={175,175,175},
            fillPattern=FillPattern.CrossDiag,
            textString="SH")}));
  end StaticCondenser;

equation
  // Connection of main components
  //
  connect(con.port_b, modExpVal.port_a)
    annotation (Line(points={{-10,70},{50,70},{50,50}}, color={0,127,255}));

  // Connection of signals
  //
  connect(modExpVal.dataBus, dataBus)
    annotation (Line(
      points={{30,30},{30,30},{0,30}},
      color={255,204,51},
      thickness=0.5));
  connect(inpHeaCap.y, con.inpQ_flow)
    annotation (Line(points={{-69,-42},{-69,-42},{86,-42},{86,88},{-18,88},{-18,
          80}},                                      color={0,0,127}));
  connect(inpTFlo.y, con.inpTFlo)
    annotation (Line(points={{-69,-56},{-69,-56},{
          94,-56},{94,94},{-22,94},{-22,80}}, color={0,0,127}));
  connect(repMea.y, dataBus.expValBus.extManVarVal)
    annotation (Line(points={{-9,30},{0.05,30},{0.05,29.95}}, color={0,0,127}));
  connect(inpColCap.y, eva.inpQ_flow)
    annotation (Line(points={{-69,-28},{-69,-28},{-60,-28},{-60,-34},{-16,-34},{
          -16,-20}},        color={0,0,127}));
  connect(inpAmbTemp.y, eva.inpTAmb)
    annotation (Line(points={{-69,-14},{-50,-14},{-50,-28},{-24,-28},
                {-24,-20}}, color={0,0,127}));
  connect(inpCurSpeEnt.y, conPID.u_m)
    annotation (Line(points={{-69,0},{-50,0},{-50,18}}, color={0,0,127}));
  connect(inpSetSpeEnt.y, conPID.u_s)
    annotation (Line(points={{-69,30},{-66,30},{-62,30}}, color={0,0,127}));
  connect(conPID.y, repMea.u)
    annotation (Line(points={{-39,30},{-35.5,30},{-32,30}}, color={0,0,127}));
  connect(eva.ports_b, modExpVal.ports_b)
    annotation (Line(points={{-10,-10},{2,
          -10},{50,-10},{50,10}}, color={0,127,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                        Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>December 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model prescribes inlet and outlet conditions of a simplified
  static heat pump model (i.e. boundary conditions of the secondary
  sides of the evaporator and condenser). Furhtermore, it controlls the
  degrees of opening of the expension valves in such a way that the
  prescribed outlet condtions of the expansion valves are meet the
  calculated outlet condtions of the expansion valves. The model is
  used to validate the expansion valve model in general.
</p>
<h4>
  Required information
</h4>
<p>
  The User needs to define the following information in order to
  complete the model:
</p>
<ol>
  <li>Basic definitions of the expansion valve. For example, the
  cross-sectional area of the expansion valve.
  </li>
  <li>Calculation approache of the flow coefficient.
  </li>
  <li>Static boundaries of the heat pump obtained, for example, by
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
  <li>Ambient temperature in <code>°C</code>.
  </li>
  <li>Heat capacity in <code>W</code>.
  </li>
  <li>Temperature at inlet of condenser's secondary fluid in
  <code>°C</code>.
  </li>
  <li>Power consumption in <code>kW</code>.
  </li>
  <li>COP.
  </li>
</ol>
<p>
  Moreover, the User needs to define further parameters describing
  static condtions of the heat pump. These parameters are listed below.
</p>
</html>"),
    experiment(StopTime=16.999));
end StaticHeatPumpBoundaries;
