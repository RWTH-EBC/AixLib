within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses;
package BaseValves
                  "Package that contains base classes used for the expansion valve models"
  extends Modelica.Icons.BasesPackage;


  partial model PartialExpansionValveModified



    import SI = Modelica.SIunits;

    extends AixLib.Fluid.Interfaces.PartialTwoPortTransport(
      redeclare replaceable package Medium =
          Modelica.Media.R134a.R134a_ph,
      show_T = false,
      show_V_flow = false,
      dp_start = 1e6,
      m_flow_start = 0.5*m_flow_nominal,
      m_flow_small = 1e-6*m_flow_nominal);


    // Definition of model describing flow coefficient
    //
    replaceable model FlowCoefficient =
        Utilities.FlowCoefficient.SpecifiedFlowCoefficients.ConstantFlowCoefficient
      constrainedby Coefficient.PartialFlowCoefficient
      "Model that describes the calculation of the flow coefficient"
      annotation (choicesAllMatching=true, Dialog(
        enable=if (Utilities.Types.Choice.ExpansionsValve or Utilities.Types.Choice.Bernoullip_th)
             then true else false,
        tab="Flow Coefficient",
        group="Flow coefficient model"));


    FlowCoefficient flowCoefficient(
      redeclare package Medium = Medium,
      opening=opening,
      AVal=AVal,
      dInlPip=dInlPip,
      staInl=staInl,
      staOut=staOut,
      pInl=pInl,
      pOut=pOut) "Instance of model 'flow coefficient'";
    //annotation(HideResult = (if show_flow_coefficient then false else true));

    replaceable model MetastabilityCoefficient =
     Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.ConstantMetastabilityCoefficient
       constrainedby Coefficient.PartialMetastabilityCoefficient
       "Model that describes the calculation of the flow coefficient"
        annotation (choicesAllMatching=true, Dialog(enable=if (Utilities.Types.Choice.ExpansionsValve or Utilities.Types.Choi)
             then true else false,
        tab="MetastabilityCoefficient",
        group="MetastabilityCoefficient model"));



     MetastabilityCoefficient metastabilitycoefficient(
      redeclare package Medium = Medium,
      opening=opening,
      AVal=AVal,
      dInlPip=dInlPip,
      staInl=staInl,
      staOut=staOut,
      pInl=pInl,
      pOut=pOut) "Instance of model 'flow coefficient'";
    //annotation(HideResult = (if show_flow_coefficient then false else true));


    //Valve Characteristic
    replaceable function valveCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.quadratic
      constrainedby
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
      "Inherent flow characteristic";

    parameter Boolean useInpFil=true
      "= true, if transient behaviour of valve opening or closing is computed";

    parameter Modelica.SIunits.Time risTim=0.5
      "Time until valve opening reaches 99.6 % of its set value"
      annotation (Dialog(enable=useInpFil, group="Transient behaviour"));

    parameter SI.Pressure dp_nominal "Nominal pressure drop";
    parameter Medium.MassFlowRate m_flow_nominal "Nominal mass flowrate";

    // parameter Medium.Density rho_nominal=Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) "Nominal inlet density";

    parameter Boolean checkValve=false "Reverse flow stopped";

   // parameter SI.Pressure dp_small=system.dp_small  "Regularisation of zero flow";

    //Parameter Geometry

    parameter Modelica.SIunits.Diameter dInlPip=7.5e-3
      "Diameter of the Pipe at valves ";
    //Modelica.SIunits.Area dThr(min=0.00001) "cross-section diameter of Valve";
    //Modelica.SIunits.Area AVal=Modelica.Constants.pi*(dInlPip^2/4)
    Modelica.SIunits.Area AVal=2.5e-6
      "Cross-sectional area of the valve when it is fully opened";
    //Modelica.SIunits.Area Av   "Cross-sectional of Valve";
    // Modelica.Blocks.Interfaces.RealInput phi  "Valveposition in deg: 0 = closed, 90 = full open "

    Modelica.SIunits.Velocity v_in "Velocity at inlet of valve";
    Modelica.SIunits.Velocity v_Out "Velocity at outlet of valve";

    Modelica.SIunits.Area AThr "Current cross-sectional area of the valve";

      Modelica.Blocks.Interfaces.RealInput manVarVal(min=0, max=1)
      "Prescribed expansion valve's opening" annotation (Placement(transformation(
          extent={{16,-16},{-16,16}},
          rotation=90,
          origin={-50,106})));
    Modelica.Blocks.Interfaces.RealOutput curManVarVal(min=0, max=1)
      "Current expansion valve's opening" annotation (Placement(transformation(
          extent={{-15,-15},{15,15}},
          rotation=90,
          origin={51,105})));
    Modelica.Blocks.Continuous.Filter filterOpening(
      final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
      final filterType=Modelica.Blocks.Types.FilterType.LowPass,
      order=2,
      f_cut=5/(2*Modelica.Constants.pi*risTim),
      x(each stateSelect=StateSelect.always)) if
          useInpFil
      "Second order filter to approximate valve opening or closing time"
      annotation (Placement(transformation(
          extent={{-30,59},{-10,80}})));
    Modelica.Blocks.Routing.RealPassThrough openingThrough
      "Dummy passing through of opening signal to allow usage of filter"
      annotation (Placement(transformation(
        extent={{10,60},{30,80}})));




    /*replaceable model Metastability_HHMFFM =
      Utilities.MetastabilityCoefficient.Metastability_HHMFFM
  annotation(choicesAllMatching=true,
               Dialog(
               enable = if (Utilities.Types.Choice.ExpansionValvep_th and Utilities.Types.Choice.ExpansionValve_c_meta)
               then true else false,
               tab="Metastability Coefficient",
               group="Metastability model"));

          Metastability_HHMFFM HHMFFM(redeclare package Medium = Medium,
    opening = opening,
    AVal = AVal,
    dInlPip = dInlPip,
    staInl = staInl,
    staOut = staOut,
    pInl = pInl,
    pOut = pOut);*/

    parameter Utilities.Types.Choice Choice=Utilities.Types.Choice.Bernoullip_th
      "Chose predefined calculation method for flow coefficient";
    Modelica.SIunits.AbsolutePressure p_th
      "Pressure at the throat of the valve";

    Real C_meta "Metastability Parameter";

    // Real C_d = flowCoefficient.C_d;
    Real C;

    Medium.SaturationProperties satInl
      "Saturation properties at valve's inlet conditions";
      Medium.ThermodynamicState staInl
      "Thermodynamic state of the fluid at inlet condtions"
      annotation(HideResult = (if show_staInl then false else true));
    Medium.ThermodynamicState staOut
      "Thermodynamic state of the fluid at outlet condtions"
      annotation(HideResult = (if show_staOut then false else true));


  protected
    Real opening(unit="1") "Current valve´s opening";
      Medium.AbsolutePressure pInl=port_a.p "Inlet pressure";
    Medium.AbsolutePressure pOut=port_b.p "Outlet pressure";

  initial equation

  equation
     // Calculation of thermodynamic states
    //
    staInl = Medium.setState_phX(port_a.p,
      actualStream(port_a.h_outflow), actualStream(port_a.Xi_outflow))
      "Thermodynamic state of the fluid at inlet condtions";
    staOut = Medium.setState_phX(port_b.p,
      actualStream(port_b.h_outflow), actualStream(port_b.Xi_outflow))
      "Thermodynamic state of the fluid at outlet condtions";


    satInl = Medium.setSat_T(Medium.temperature(staInl))
      "Saturation properties at valve's inlet conditions";

    // Velocity
    //engineer  equation: m_flow = v*(Av*d_inlet)

    // Calculation of valve's opening degree
    //
   connect(filterOpening.u, manVarVal);
    if useInpFil then
      connect(openingThrough.u, filterOpening.y)
        "Transient behaviour of valve's opening";
    else
      connect(openingThrough.u, manVarVal)
        "No transient behaiviour of valve's opnening";
    end if;
    opening = smooth(1, noEvent(if openingThrough.y>0 then
                                openingThrough.y else 1e-15))
      "Current valve's opening";

    // Calculation of active cross-sectional flow area
    //
    AThr = opening * AVal "Current cross-sectional area of the valve";

    // Calculation of outputs
    //
    curManVarVal = opening "Current valve's opening";

    v_in*AThr*Medium.density(staInl) = m_flow " at inlet";
    v_Out*AThr*Medium.density(staOut) = m_flow "v_in at outlet";

    //  AThr = AVal*(1 - abs(Modelica.Math.cos(phi*Modelica.Constants.pi/180)))   "Area-section of Valve";
    //AThr = Modelica.Constants.pi*(dThr^2/4)
    // AVal = Modelica.Constants.pi*(dVal^4/4) ;

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
                  points={{0,0},{-40,30},{-40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Polygon(
                  points={{0,0},{40,30},{40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Line(
                  points={{-100,0},{-40,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Line(
                  points={{40,0},{90,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Ellipse(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  textString="M",
                  textStyle={TextStyle.Bold}),Line(
                  points={{0,24},{0,0}},
                  color={0,0,0},
                  thickness=0.5),Line(
                  points={{-50,92},{-50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,90},{50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,44},{20,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{-50,44},{-20,44}},
                  color={244,125,35},
                  thickness=0.5)}),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
                  points={{0,0},{-40,30},{-40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Polygon(
                  points={{0,0},{40,30},{40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Line(
                  points={{-100,0},{-40,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Line(
                  points={{40,0},{90,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Ellipse(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  textString="M",
                  textStyle={TextStyle.Bold}),Line(
                  points={{0,24},{0,0}},
                  color={0,0,0},
                  thickness=0.5),Line(
                  points={{-50,92},{-50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,90},{50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,44},{20,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{-50,44},{-20,44}},
                  color={244,125,35},
                  thickness=0.5)}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end PartialExpansionValveModified;

  partial model PartialExpansionIsenthalpicValveModified
    extends PartialExpansionValveModified;

  equation
      // Calculation of energy balance
    //
    port_a.h_outflow = inStream(port_b.h_outflow) "Isenthalpic expansion valve";
    port_b.h_outflow = inStream(port_a.h_outflow) "Isenthalpic expansion valve";

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end PartialExpansionIsenthalpicValveModified;

  partial model PartialExpansionValveChoke




    import SI = Modelica.SIunits;

    extends AixLib.Fluid.Interfaces.PartialTwoPortTransport(
      redeclare replaceable package Medium =
          Modelica.Media.R134a.R134a_ph,
      show_T = false,
      show_V_flow = false,
      dp_start = 1e6,
      m_flow_start = 0.5*m_flow_nominal,
      m_flow_small = 1e-6*m_flow_nominal);


    // Definition of model describing flow coefficient
    //
    replaceable model FlowCoefficient =
        Utilities.FlowCoefficient.SpecifiedFlowCoefficients.ConstantFlowCoefficient
      constrainedby Coefficient.PartialFlowCoefficient
      "Model that describes the calculation of the flow coefficient"
      annotation (choicesAllMatching=true, Dialog(
        enable=if (Utilities.Types.Choice.ExpansionsValve or Utilities.Types.Choice.Bernoullip_th)
             then true else false,
        tab="Flow Coefficient",
        group="Flow coefficient model"));


    FlowCoefficient flowCoefficient(
      redeclare package Medium = Medium,
      opening=opening,
      AVal=AVal,
      dInlPip=dInlPip,
      staInl=staInl,
      staOut=staOut,
      pInl=pInl,
      pOut=pOut) "Instance of model 'flow coefficient'";
    //annotation(HideResult = (if show_flow_coefficient then false else true));

    replaceable model MetastabilityCoefficient =
     Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.ConstantMetastabilityCoefficient
       constrainedby Coefficient.PartialMetastabilityCoefficient
       "Model that describes the calculation of the flow coefficient"
        annotation (choicesAllMatching=true, Dialog(enable=if (Utilities.Types.Choice.ExpansionsValve or Utilities.Types.Choi)
             then true else false,
        tab="MetastabilityCoefficient",
        group="MetastabilityCoefficient model"));



     MetastabilityCoefficient metastabilitycoefficient(
      redeclare package Medium = Medium,
      opening=opening,
      AVal=AVal,
      dInlPip=dInlPip,
      staInl=staInl,
      staOut=staOut,
      pInl=pInl,
      pOut=pOut) "Instance of model 'flow coefficient'";
    //annotation(HideResult = (if show_flow_coefficient then false else true));


    //Valve Characteristic
    replaceable function valveCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.quadratic
      constrainedby
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
      "Inherent flow characteristic";

    parameter Boolean useInpFil=true
      "= true, if transient behaviour of valve opening or closing is computed";

    parameter Modelica.SIunits.Time risTim=0.5
      "Time until valve opening reaches 99.6 % of its set value"
      annotation (Dialog(enable=useInpFil, group="Transient behaviour"));

    parameter SI.Pressure dp_nominal "Nominal pressure drop";
    parameter Medium.MassFlowRate m_flow_nominal "Nominal mass flowrate";

    // parameter Medium.Density rho_nominal=Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) "Nominal inlet density";

    parameter Boolean checkValve=false "Reverse flow stopped";

   // parameter SI.Pressure dp_small=system.dp_small  "Regularisation of zero flow";

    //Parameter Geometry

    parameter Modelica.SIunits.Diameter dInlPip=7.5e-3
      "Diameter of the Pipe at valves ";
    //Modelica.SIunits.Area dThr(min=0.00001) "cross-section diameter of Valve";
    //Modelica.SIunits.Area AVal=Modelica.Constants.pi*(dInlPip^2/4)
    Modelica.SIunits.Area AVal=2.5e-6
      "Cross-sectional area of the valve when it is fully opened";
    //Modelica.SIunits.Area Av   "Cross-sectional of Valve";
    // Modelica.Blocks.Interfaces.RealInput phi  "Valveposition in deg: 0 = closed, 90 = full open "

    Modelica.SIunits.Velocity v_in "Velocity at inlet of valve";
    Modelica.SIunits.Velocity v_Out "Velocity at outlet of valve";

    Modelica.SIunits.Area AThr "Current cross-sectional area of the valve";

      Modelica.Blocks.Interfaces.RealInput manVarVal(min=0, max=1)
      "Prescribed expansion valve's opening" annotation (Placement(transformation(
          extent={{16,-16},{-16,16}},
          rotation=90,
          origin={-50,106})));
    Modelica.Blocks.Interfaces.RealOutput curManVarVal(min=0, max=1)
      "Current expansion valve's opening" annotation (Placement(transformation(
          extent={{-15,-15},{15,15}},
          rotation=90,
          origin={51,105})));
    Modelica.Blocks.Continuous.Filter filterOpening(
      final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
      final filterType=Modelica.Blocks.Types.FilterType.LowPass,
      order=2,
      f_cut=5/(2*Modelica.Constants.pi*risTim),
      x(each stateSelect=StateSelect.always)) if
          useInpFil
      "Second order filter to approximate valve opening or closing time"
      annotation (Placement(transformation(
          extent={{-30,59},{-10,80}})));
    Modelica.Blocks.Routing.RealPassThrough openingThrough
      "Dummy passing through of opening signal to allow usage of filter"
      annotation (Placement(transformation(
        extent={{10,60},{30,80}})));




    /*replaceable model Metastability_HHMFFM =
      Utilities.MetastabilityCoefficient.Metastability_HHMFFM
  annotation(choicesAllMatching=true,
               Dialog(
               enable = if (Utilities.Types.Choice.ExpansionValvep_th and Utilities.Types.Choice.ExpansionValve_c_meta)
               then true else false,
               tab="Metastability Coefficient",
               group="Metastability model"));

          Metastability_HHMFFM HHMFFM(redeclare package Medium = Medium,
    opening = opening,
    AVal = AVal,
    dInlPip = dInlPip,
    staInl = staInl,
    staOut = staOut,
    pInl = pInl,
    pOut = pOut);*/

    parameter Utilities.Types.Choice Choice=Utilities.Types.Choice.ExpansionValveChoke
      "Chose predefined calculation method for flow coefficient";

    Real C;

    Medium.SaturationProperties satInl
      "Saturation properties at valve's inlet conditions";
      Medium.ThermodynamicState staInl
      "Thermodynamic state of the fluid at inlet condtions"
      annotation(HideResult = (if show_staInl then false else true));
    Medium.ThermodynamicState staOut
      "Thermodynamic state of the fluid at outlet condtions"
      annotation(HideResult = (if show_staOut then false else true));


  protected
    Real opening(unit="1") "Current valve´s opening";
      Medium.AbsolutePressure pInl=port_a.p "Inlet pressure";
    Medium.AbsolutePressure pOut=port_b.p "Outlet pressure";

  initial equation

  equation
     // Calculation of thermodynamic states
    //
    staInl = Medium.setState_phX(port_a.p,
      actualStream(port_a.h_outflow), actualStream(port_a.Xi_outflow))
      "Thermodynamic state of the fluid at inlet condtions";
    staOut = Medium.setState_phX(port_b.p,
      actualStream(port_b.h_outflow), actualStream(port_b.Xi_outflow))
      "Thermodynamic state of the fluid at outlet condtions";


    satInl = Medium.setSat_T(Medium.temperature(staInl))
      "Saturation properties at valve's inlet conditions";

    // Velocity
    //engineer  equation: m_flow = v*(Av*d_inlet)

    // Calculation of valve's opening degree
    //
   connect(filterOpening.u, manVarVal);
    if useInpFil then
      connect(openingThrough.u, filterOpening.y)
        "Transient behaviour of valve's opening";
    else
      connect(openingThrough.u, manVarVal)
        "No transient behaiviour of valve's opnening";
    end if;
    opening = smooth(1, noEvent(if openingThrough.y>0 then
                                openingThrough.y else 1e-15))
      "Current valve's opening";

    // Calculation of active cross-sectional flow area
    //
    AThr = opening * AVal "Current cross-sectional area of the valve";

    // Calculation of outputs
    //
    curManVarVal = opening "Current valve's opening";

    v_in*AThr*Medium.density(staInl) = m_flow " at inlet";
    v_Out*AThr*Medium.density(staOut) = m_flow "v_in at outlet";

    //  AThr = AVal*(1 - abs(Modelica.Math.cos(phi*Modelica.Constants.pi/180)))   "Area-section of Valve";
    //AThr = Modelica.Constants.pi*(dThr^2/4)
    // AVal = Modelica.Constants.pi*(dVal^4/4) ;

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
                  points={{0,0},{-40,30},{-40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Polygon(
                  points={{0,0},{40,30},{40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Line(
                  points={{-100,0},{-40,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Line(
                  points={{40,0},{90,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Ellipse(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  textString="M",
                  textStyle={TextStyle.Bold}),Line(
                  points={{0,24},{0,0}},
                  color={0,0,0},
                  thickness=0.5),Line(
                  points={{-50,92},{-50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,90},{50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,44},{20,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{-50,44},{-20,44}},
                  color={244,125,35},
                  thickness=0.5)}),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
                  points={{0,0},{-40,30},{-40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Polygon(
                  points={{0,0},{40,30},{40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Line(
                  points={{-100,0},{-40,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Line(
                  points={{40,0},{90,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Ellipse(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  textString="M",
                  textStyle={TextStyle.Bold}),Line(
                  points={{0,24},{0,0}},
                  color={0,0,0},
                  thickness=0.5),Line(
                  points={{-50,92},{-50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,90},{50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,44},{20,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{-50,44},{-20,44}},
                  color={244,125,35},
                  thickness=0.5)}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end PartialExpansionValveChoke;

  partial model PartialIsenthalpicExpansionValveChoke
    extends PartialExpansionValveChoke;

  equation

    port_a.h_outflow = inStream(port_b.h_outflow)
                                                 "Isenthalpic expansion valve";
    port_b.h_outflow = inStream(port_a.h_outflow)
                                                 "Isenthalpic expansion valve";

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end PartialIsenthalpicExpansionValveChoke;

  partial model PartialFlowValve
    import Modelica.Fluid.Types.CvTypes;
    import SI = Modelica.SIunits;

    extends AixLib.Fluid.Interfaces.PartialTwoPortTransport(
      redeclare replaceable package Medium = Modelica.Media.R134a.R134a_ph
        constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium,
      show_T=false,
      show_V_flow=false,
      dp_start=dp_nominal,
      m_flow_start= 0.5*m_flow_nominal,
      m_flow_small= 1e-6*m_flow_nominal);

    // Definition of model describing flow coefficient
    //
   /* replaceable model FlowCoefficient =
      Utilities.FlowCoefficient.SpecifiedFlowCoefficients.ConstantFlowCoefficient ;
    constrainedby Coefficient.PartialFlowCoefficient
    "Model that describes the calculation of the flow coefficient"
    annotation (choicesAllMatching=true, Dialog(
      enable=if (Utilities.Types.Choice.ExpansionsValve or Utilities.Types.Choice.ExpansionValvep_th)
           then true else false,
      tab="Flow Coefficient",
      group="Floww coefficient model"));

  FlowCoefficient flowCoefficient(
    redeclare package Medium = Medium,
    opening=opening,
    AVal=AVal,
    dInlPip=dInlPip,
    staInl=staInl,
    staOut=staOut,
    pInl=pInl,
    pOut=pOut) "Instance of model 'flow coefficient'";
  //annotation(HideResult = (if show_flow_coefficient then false else true));
*/
    //Valve Characteristic
    replaceable function valveCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.quadratic
      constrainedby
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
      "Inherent flow characteristic";

    parameter Boolean useInpFil=true
      "= true, if transient behaviour of valve opening or closing is computed";

    parameter Modelica.SIunits.Time risTim=0.5
      "Time until valve opening reaches 99.6 % of its set value"
      annotation (Dialog(enable=useInpFil, group="Transient behaviour"));

    parameter SI.Pressure dp_nominal "Nominal pressure drop";
    parameter Medium.MassFlowRate m_flow_nominal "Nominal mass flowrate";

    // parameter Medium.Density rho_nominal=Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) "Nominal inlet density";

    parameter Boolean checkValve=false "Reverse flow stopped";

    //Parameter Geometry

    parameter Modelica.SIunits.Diameter dInlPip=7.5e-3
      "Diameter of the Pipe at valves ";
    Modelica.SIunits.Area dThr(min=0.00001)
      "cross-section diameter of Valve";
    //Modelica.SIunits.Area AVal=Modelica.Constants.pi*(dInlPip^2/4)
    Modelica.SIunits.Area AVal=2.5e-6
      "Cross-sectional area of the valve when it is fully opened";
    //Modelica.SIunits.Area Av   "Cross-sectional of Valve";
    // Modelica.Blocks.Interfaces.RealInput phi  "Valveposition in deg: 0 = closed, 90 = full open "

    Modelica.SIunits.Velocity v_in "Velocity at inlet of valve";
    Modelica.SIunits.Velocity v_Out "Velocity at outlet of valve";
    Medium.AbsolutePressure pInl=port_a.p "Inlet pressure";
    Medium.AbsolutePressure pOut=port_b.p "Outlet pressure";
    Modelica.SIunits.Area AThr "Current cross-sectional area of the valve";

    Modelica.Blocks.Interfaces.RealInput manVarVal(min=0, max=1)
      "Prescribed expansion valve's opening" annotation (Placement(
          transformation(
          extent={{16,-16},{-16,16}},
          rotation=90,
          origin={-50,106})));
    Modelica.Blocks.Interfaces.RealOutput curManVarVal(min=0, max=1)
      "Current expansion valve's opening" annotation (Placement(
          transformation(
          extent={{-15,-15},{15,15}},
          rotation=90,
          origin={51,105})));
    Modelica.Blocks.Continuous.Filter filterOpening(
      final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
      final filterType=Modelica.Blocks.Types.FilterType.LowPass,
      order=2,
      f_cut=5/(2*Modelica.Constants.pi*risTim),
      x(each stateSelect=StateSelect.always)) if useInpFil
      "Second order filter to approximate valve opening or closing time"
      annotation (Placement(transformation(extent={{-30,59},{-10,80}})));

    Modelica.Blocks.Routing.RealPassThrough openingThrough
      "Dummy passing through of opening signal to allow usage of filter";

    //Liquid: InKompressible Liquid

    // outflow function
    Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp=
        Medium.specificHeatCapacityCp(staInl);

    Modelica.SIunits.SpecificHeatCapacityAtConstantVolume cv=
        Medium.specificHeatCapacityCv(staInl);
    Real kappa;
    //Real Y_undercritical=sqrt((kappa/(kappa - 1))*x^(1/kappa)*(x^(1/kappa) - x))
    Real Y_undercritical=sqrt((kappa/(kappa - 1)))*sqrt(x^(2/kappa) - (x)^(
        (kappa + 1)/kappa)) "discharge-Function für undercritical area";

    Real Y_critical=(2/(kappa + 1))^(1/(kappa - 1))*sqrt((kappa/(kappa + 1)))
      "discharge-Function für critical area";
    Real Y "discharge-Function Dummy";

    //Flow Coefficient

    Real C_d "discharge Coefficient";

    Real x=port_b.p/port_a.p "Pressure ratio";
    Real x_krit=((kappa + 1)/2)^(kappa/(1 - kappa))
      "Critical Pressure ratio";
    Real b "switch m_incompressibel";
    Real a "Switch m_Compressible";

    Modelica.SIunits.MassFlowRate m_flow_incompressibel
      "Liquid or incompressible m_flow rate";
    Modelica.SIunits.MassFlowRate m_flow_compressibel
      "Gas/Liquid compressible m_flow rate";

    Real x_outlet=Medium.vapourQuality(staOut) "vapourQuality";

    Modelica.SIunits.Density d_inlet=Medium.density(staInl);
    Medium.SaturationProperties satInl
      "Saturation properties at valve's inlet conditions";
    Medium.Density d_sat_ph=Medium.bubbleDensity(satInl)
      "Saturtation density at phase change";


   //
    Medium.ThermodynamicState staInl
      "Thermodynamic state of the fluid at inlet condtions"
      annotation(HideResult = (if show_staInl then false else true));
    Medium.ThermodynamicState staOut
      "Thermodynamic state of the fluid at outlet condtions";

  protected
    Real opening(unit="1") "Current valve´s opening";

  initial equation

  equation
      // Calculation of thermodynamic states
    //
    staInl = Medium.setState_phX(port_a.p,
      actualStream(port_a.h_outflow), actualStream(port_a.Xi_outflow))
      "Thermodynamic state of the fluid at inlet condtions";
    staOut = Medium.setState_phX(port_b.p,
      actualStream(port_b.h_outflow), actualStream(port_b.Xi_outflow))
      "Thermodynamic state of the fluid at outlet condtions";

    //b: if staInl TwoPhase then m_flow_incompressibel
    b = if staInl.phase > 1 then 0 else 1;
    //a:If StaOut TwoPhase then m_flow_compressibel
    a = if staOut.phase > 1 then 1 else 0;
    Y = if x >= x_krit then Y_undercritical else if x <= x_krit then
      Y_critical else 0;

    satInl = Medium.setSat_T(Medium.temperature(staInl));
    kappa*cv = cp;

    // Calculation of valve's opening degree
    //
    connect(filterOpening.u, manVarVal);
    if useInpFil then
      connect(openingThrough.u, filterOpening.y)
        "Transient behaviour of valve's opening";
    else
      connect(openingThrough.u, manVarVal)
        "No transient behaiviour of valve's opnening";
    end if;
    opening = smooth(1, noEvent(if openingThrough.y > 0 then openingThrough.y
       else 1e-15)) "Current valve's opening";

    // Calculation of active cross-sectional flow area
    //
    AThr = opening*AVal "Current cross-sectional area of the valve";

    // Calculation of outputs
    //
    curManVarVal = opening "Current valve's opening";

    // Velocity
    //engineer  equation: m_flow = v*(Av*d_inlet)
    v_in*AThr*Medium.density(staInl) = m_flow " at inlet";
    v_Out*AThr*Medium.density(staOut) = m_flow "v_in at outlet";

    //  AThr = AVal*(1 - abs(Modelica.Math.cos(phi*Modelica.Constants.pi/180)))   "Area-section of Valve";
    AThr = Modelica.Constants.pi*(dThr^2/4) annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
                  points={{0,0},{-40,30},{-40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Polygon(
                  points={{0,0},{40,30},{40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Line(
                  points={{-100,0},{-40,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Line(
                  points={{40,0},{90,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Ellipse(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  textString="M",
                  textStyle={TextStyle.Bold}),Line(
                  points={{0,24},{0,0}},
                  color={0,0,0},
                  thickness=0.5),Line(
                  points={{-50,92},{-50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,90},{50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,44},{20,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{-50,44},{-20,44}},
                  color={244,125,35},
                  thickness=0.5)}),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    // AVal = Modelica.Constants.pi*(dVal^4/4) ;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
                  points={{0,0},{-40,30},{-40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Polygon(
                  points={{0,0},{40,30},{40,-30},{0,0}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),Line(
                  points={{-100,0},{-40,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Line(
                  points={{40,0},{90,0}},
                  color={0,127,255},
                  smooth=Smooth.Bezier,
                  thickness=0.5),Ellipse(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-20,64},{20,24}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  textString="M",
                  textStyle={TextStyle.Bold}),Line(
                  points={{0,24},{0,0}},
                  color={0,0,0},
                  thickness=0.5),Line(
                  points={{-50,92},{-50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,90},{50,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{50,44},{20,44}},
                  color={244,125,35},
                  thickness=0.5),Line(
                  points={{-50,44},{-20,44}},
                  color={244,125,35},
                  thickness=0.5)}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end PartialFlowValve;

  partial model PartialFlowIsenthalpicValve
    extends PartialFlowValve;

  equation
     port_a.h_outflow = inStream(port_b.h_outflow)
                                                 "Isenthalpic expansion valve";
    port_b.h_outflow = inStream(port_a.h_outflow)
                                                 "Isenthalpic expansion valve";


    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end PartialFlowIsenthalpicValve;
end BaseValves;
