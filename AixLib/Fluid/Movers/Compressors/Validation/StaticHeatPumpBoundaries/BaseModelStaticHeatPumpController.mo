within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries;
model BaseModelStaticHeatPumpController
  "Base model to test compressors using static heat pump boundaries"

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
  parameter Integer nCom = 1
    "Numer of compressors in parallel"
    annotation(Dialog(tab="General",group="Compressors"));

  // Definition of parameters describing boundary conditions
  //
  parameter Modelica.Units.SI.TemperatureDifference dTPinEva=5
    "Pinch temperature at evaporator's outlet"
    annotation (Dialog(tab="General", group="Evaporator"));
  parameter Modelica.Units.SI.TemperatureDifference dTSupHea=1
    "Superheating of working fluid"
    annotation (Dialog(tab="General", group="Evaporator"));

  parameter Modelica.Units.SI.TemperatureDifference dTPinCon=2.5
    "Pinch temperature at evaporator's outlet"
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
  parameter Modelica.Units.SI.VolumeFlowRate V_flowSec=(0.776 + 0.781 + 0.44)/3
      /3600 "Constant volume flow of secondary fluid"
    annotation (Dialog(tab="General", group="Condenser"));

  // Definition of variables describing boundary conditions
  //
  Modelica.Blocks.Sources.CombiTimeTable inpDat(
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation,
    columns=2:7,
    timeScale=1,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,64,285.15,5180,308.15,900,5.755555556; 1,64,283.15,4920,308.15,910,
        5.406593407; 2,63,280.15,4370,308.15,930,4.698924731; 3,64,285.15,4980,318.15,
        1140,4.368421053; 4,64,283.15,4730,318.15,1140,4.149122807; 5,55,285.15,
        4180,328.15,1240,3.370967742; 6,64,283.15,4650,328.15,1380,3.369565217;
        7,63,280.15,4160,318.15,1610,2.583850932; 8,55,275.15,2800,308.15,790,3.544303797;
        9,106,258.15,3760,308.15,1570,2.394904459; 10,115,266.15,4850,308.15,1940,
        2.5; 11,55,275.15,2640,318.15,960,2.75; 12,111,258.15,4150,318.15,2120,1.95754717;
        13,107,270.15,4780,318.15,2210,2.162895928; 14,113,266.15,4560,318.15,2290,
        1.991266376; 15,100,266.15,3880,328.15,2240,1.732142857; 16,63,275.15,3280,
        328.15,1330,2.466165414; 17,63,280.15,4080,328.15,1400,2.914285714])
    "Static boundaries of compressor model"
    annotation (Placement(transformation(extent={{-90,-92},{-70,-72}})));

  Modelica.Blocks.Sources.RealExpression inpRotSpe(y=inpDat.y[1])
    "Expressions describing rotational speed"
    annotation (Placement(transformation(extent={{-90,-24},{-70,-4}})));
  Modelica.Blocks.Sources.RealExpression inpAmbTemp(y=inpDat.y[2])
    "Expressions describing ambient temperature"
    annotation (Placement(transformation(extent={{-90,-38},{-70,-18}})));
  Modelica.Blocks.Sources.RealExpression inpHeaCap(y=inpDat.y[3])
    "Expressions describing heat capacity"
    annotation (Placement(transformation(extent={{-90,-52},{-70,-32}})));
  Modelica.Blocks.Sources.RealExpression inpTRetFlo(y=inpDat.y[4] - 10)
    "Expressions describing return flow temperature at heat capacity"
    annotation (Placement(transformation(extent={{-90,-66},{-70,-46}})));

  // Definition of subcomponents
  //
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature ambTemp
    "Source that prescribes boundary ambient temperature"
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thrCol(m=nCom)
    "Model to split the ambient temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,origin={38,30})));
  StaticEvaporator eva(
    redeclare final package Medium = Medium,
    final dTPin=dTPinEva,
    final dTSupHea=dTSupHea)
    "Model that describes a simple static evaporator"
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));

  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMax=120,
    yMin=30) "Controller of the compressor's rotational speeds"
    annotation (Placement(transformation(extent={{-90,40},{-70,20}})));
  Modelica.Blocks.Routing.Replicator repMea(nout=nCom)
    "Replicating the current value of the manipulated variables"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  ModularCompressors.ModularCompressorsSensors modCom(
    nCom=nCom,
    redeclare package Medium = Medium,
    redeclare model SimpleCompressor =
        SimpleCompressors.RotaryCompressors.RotaryCompressor,
    show_staEff=true,
    show_qua=true,
    m_flow_start=0.05,
    VDis=fill(13.2e-6,nCom),
    useInpFil=fill(false,nCom),
    h_out_start=400e3,
    redeclare replaceable model EngineEfficiency =
        Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare replaceable model VolumetricEfficiency =
        Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
    redeclare replaceable model IsentropicEfficiency =
        Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll)
    "Model that describes modular compressors in parallel"
    annotation (Placement(transformation( extent={{-20,20},{20,-20}},
                rotation=90,origin={0,30})));

  StaticCondenser con(
    redeclare package Medium = Medium,
    dSec=dSec,
    cpSec=cpSec,
    V_flowSec=V_flowSec,
    dTSubCool=dTSubCool,
    dTPin=dTPinCon)
    "Model that describes a simple static condenser"
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));

  Controls.Interfaces.ModularHeatPumpControlBus dataBus(
    nCom=nCom) "Connector that contains all control signals"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,30}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-98,0})));

  // Definition of further variables
  //
  Modelica.Blocks.Interaction.Show.RealValue COP(
    use_numberPort=false, number=con.Q_flow/modCom.modCom[1].comPro.PEle/nCom)
    "Real value describing current COP"
    annotation (Placement(transformation(extent={{20,66},{40,86}})));
  Modelica.Blocks.Interaction.Show.RealValue dCOPRel(use_numberPort=false,
      number=(COP.number - inpDat.y[6])/inpDat.y[6]*100)
    "Realative difference of current COP"
    annotation (Placement(transformation(extent={{60,66},{80,86}})));
  Modelica.Blocks.Interaction.Show.RealValue PEle(
    use_numberPort=false, number=modCom.modCom[1].comPro.PEle)
    "Real value describing current power consumption"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Blocks.Interaction.Show.RealValue dPEleRel(use_numberPort=false,
      number=(PEle.number - inpDat.y[5])/inpDat.y[5]*100)
    "Real difference of current power consumption"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Real inpTime = time
    "Simulation time";

protected
  model StaticEvaporator
    "Static evaporator assuming constant pinch point at evaporator's outlet"

    // Definition of medium
    //
    replaceable package Medium = Modelica.Media.R134a.R134a_ph
      constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
      "Medium of the compressor"
      annotation(Dialog(tab="General",group="General"),
                 choicesAllMatching=true);

    // Definition of parameters describing evaporator
    //
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
    Modelica.Fluid.Interfaces.FluidPort_b port_b(
      redeclare final package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
       h_outflow(start = Medium.h_default))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));
    Modelica.Blocks.Interfaces.RealInput inpTAmb
      "Input of ambient temperature"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-100}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-100})));

    // Definition of submodels
    //
    Modelica.Blocks.Sources.RealExpression outPEva(y=pSat)
      "Expressions describing saturation pressure at evaporator's outlet"
      annotation (Placement(transformation(extent={{10,-4},{30,16}})));
    Modelica.Blocks.Sources.RealExpression outTEva(y=TOut)
      "Expressions describing temperature at evaporator's outlet"
      annotation (Placement(transformation(extent={{10,-18},{30,2}})));

    Sources.Boundary_pT source(
      redeclare package Medium = Medium,
      use_p_in=true,
      use_T_in=true,
      nPorts=1)
      "Source with constant pressure and temperature"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={60,0})));

    // Definition of variables describing evaporator
    //
    Medium.SaturationProperties satEva
      "Saturation properties of the evaporator's working fluid"
      annotation (Placement(transformation(extent={{-50,-8},{-30,12}})));
    Medium.ThermodynamicState staOut
      "Thermodynamic state of the working fluid  at evaporator's outlet"
      annotation (Placement(transformation(extent={{-20,-8},{0,12}})));

    Modelica.Units.SI.AbsolutePressure pSat
      "Absolute pressure at evaporator's outlet";
    Modelica.Units.SI.Temperature TSat "Saturation temperature";
    Modelica.Units.SI.Temperature TOut "Temperature at evaporator's outlet";

    Modelica.Units.SI.Temperature TAmb "Temperature of ambient";

  equation
    // Connection of ports
    //
    connect(outPEva.y, source.p_in)
      annotation (Line(points={{31,6},{36,6},{36,8},{48,8}}, color={0,0,127}));
    connect(outTEva.y, source.T_in)
      annotation (Line(points={{31,-8},{34,-8},{38,-8},{38,4},{48,4}},color={0,0,127}));
    connect(source.ports[1], port_b)
      annotation (Line(points={{70,0},{86,0},{100,0}}, color={0,127,255}));

    TAmb = inpTAmb
      "Temperature of ambient";

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
    TOut = TAmb - dTPin
      "Temperature at evaporator's outlet";

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
      "Medium of the compressor"
      annotation(Dialog(tab="General",group="General"),
                 choicesAllMatching=true);

    // Definition of parameters describing condenser
    //
    parameter Modelica.Units.SI.TemperatureDifference dTPin=2.5
      "Supercooling of working fluid"
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
    Modelica.Fluid.Interfaces.FluidPort_a port_a(
      redeclare final package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
       h_outflow(start = Medium.h_default))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));

    Modelica.Blocks.Interfaces.RealInput inpTRetFlo
      "Temperature return flow at heat capacity"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-20,100})));
    Modelica.Blocks.Interfaces.RealOutput outQFlo
      "Heat capacity"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-100})));

    // Definition of variables describing condenser
    //
    Modelica.Units.SI.AbsolutePressure pSat
      "Absolute pressure at condenser's outlet";
    Modelica.Units.SI.Temperature TSat "Saturation temperature";

    Modelica.Units.SI.Temperature TInl "Temperature at condenser's inlet";
    Modelica.Units.SI.Temperature TOut "Temperature at condenser's outlet";
    Modelica.Units.SI.SpecificEnthalpy hInl
      "Specific enthalpy at condenser's inlet";
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
    port_a.h_outflow = inStream(port_a.h_outflow)
      "No flow reversal";
    port_a.p = pSat
      "Pressure at inlet is equal to saturation pressure";

    m_flow = port_a.m_flow
      "Mass flow rate at condenser's inlet";
    hInl = inStream(port_a.h_outflow)
      "Specific enthalpy at condenser's inlet";

    TRetFlo = inpTRetFlo
      "Temperature return flow at heat capacity";
    outQFlo = Q_flow
      "Heat capacity";

    // Secondary side
    //
    m_flowSec = dSec*V_flowSec
      "Mass flow rate of secondary fluid";
    TFlo = TRetFlo + Q_flow/(m_flowSec*cpSec)
      "Temperature return flow at heat capacity";

    // Calculation of state properties of working fluid
    //
    TOut = TRetFlo + dTPin
      "Temperature at condenser's outlet";
    TSat = TOut + dTSubCool
      "Saturation temperature";
    pSat = Medium.saturationPressure(T=TSat)
      "Absolute pressure at condenser's outlet";

    hOut = Medium.specificEnthalpy_pT(p=pSat,T=TOut)
      "Specific enthalpy at condenser's outlet";
    hOut = hInl - Q_flow/m_flow
      "Specific enthalpy at condenser's outlet";

    TInl = Medium.temperature_ph(p=pSat,h=hInl)
      "Temperature at condenser's inlet";

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
  connect(eva.port_b, modCom.port_a)
    annotation (Line(points={{-10,-10},{0,-10},{0,10}},color={0,127,255}));
  connect(modCom.port_b, con.port_a)
    annotation (Line(points={{0,50},{0,70},{-10,70}}, color={0,127,255}));
  connect(ambTemp.port, thrCol.port_b)
    annotation (Line(points={{60,30},{48,30}}, color={191,0,0}));
  connect(thrCol.port_a, modCom.heatPort)
    annotation (Line(points={{28,30},{28,30},{20,30}}, color={191,0,0}));

  // Connection of signals
  //
  connect(modCom.dataBus, dataBus)
    annotation (Line(points={{-20,30},{-20,30},{-30,30}},
                color={255,204,51},
                thickness=0.5));
  connect(inpAmbTemp.y, ambTemp.T)
    annotation (Line(points={{-69,-28},{86,-28},{86,30},{82,30}},
                color={0,0,127}));
  connect(repMea.y, dataBus.comBus.extManVarCom)
    annotation (Line(points={{-39,30},{-29.95,30},{-29.95,29.95}},
                color={0,0,127}));
  connect(inpAmbTemp.y, eva.inpTAmb)
    annotation (Line(points={{-69,-28},{-58,-28},{-20,-28},{-20,-20}},
                                      color={0,0,127}));
  connect(inpTRetFlo.y, con.inpTRetFlo)
    annotation (Line(points={{-69,-56},{-69,
          -56},{94,-56},{94,94},{-22,94},{-22,80}}, color={0,0,127}));
  connect(PID.y, repMea.u)
    annotation (Line(points={{-69,30},{-62,30}}, color={0,0,127}));
  connect(con.outQFlo, PID.u_m)
    annotation (Line(points={{-20,60},{-20,50},{-80,50},{-80,42}},
                color={0,0,127}));
  connect(PID.u_s, inpHeaCap.y)
    annotation (Line(points={{-92,30},{-96,30},{-96,8},{-60,8},{-60,-42},
                {-69,-42}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
        rotation=45)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>December 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model prescribes inlet and outlet conditions of a simplified
  static heat pump model (i.e. boundary conditions of the secondary
  sides of the evaporator and condenser). Furhtermore, it prescribes
  the rotational speed of the compressor. The model is used to validate
  the compressor model in general as well as to show the possiblity of
  controlling the heat capacity of the heat pump.
</p>
<h4>
  Required information
</h4>
<p>
  The User needs to define the following information in order to
  complete the model:
</p>
<ol>
  <li>Basic definitions of the compressor. For example, the
  displacement volume.
  </li>
  <li>Calculation approaches of the three efficiencies of the
  compressor.
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
end BaseModelStaticHeatPumpController;
