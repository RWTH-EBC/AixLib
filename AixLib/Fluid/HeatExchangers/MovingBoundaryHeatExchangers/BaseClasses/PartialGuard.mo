within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialGuard
  "This model is a base class for all models describing guards"

  // Definition of parameters
  //
  parameter Boolean useFixModCV = false
    "= true, if flow state is prescribed and does not change"
    annotation (Dialog(tab="General",group="Void fraction"));
  parameter Utilities.Types.ModeCV modCVPar=
    Utilities.Types.ModeCV.SCTPSH
    "Constant void fraction if not calculated by model"
    annotation (Dialog(tab="General",group="Void fraction",
                enable = useFixModCV));

  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTPSH_SCTP = 5
    "Threshold specific enthalpy of switching condition SCTPSH to SCTP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTPSH_TPSH = 5
    "Threshold specific enthalpy of switching condition SCTPSH to TPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_SCTPSH = 5
    "Threshold specific enthalpy of switching condition SCTP to SCTPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_SC = 5
    "Threshold specific enthalpy of switching condition SCTP to SC"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_TP = 5
    "Threshold specific enthalpy of switching condition SCTP to TP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_SCTPSH = 5
    "Threshold specific enthalpy of switching condition TPSH to SCTPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_TP = 5
    "Threshold specific enthalpy of switching condition TPSH to TP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_SH = 5
    "Threshold specific enthalpy of switching condition TPSH to SH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SC_SCTP = 5
    "Threshold specific enthalpy of switching condition SC to SCTP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TP_SCTP = 5
    "Threshold specific enthalpy of switching condition TP to SCTP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TP_TPSH = 5
    "Threshold specific enthalpy of switching condition TP to TPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SH_TPSH = 5
    "Threshold specific enthalpy of switching condition SH to TPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));

  parameter Real lenMin = 1e-4
    "Threshold length of switching condition"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_SCTPSH_SCTP = 1e-6
    "Threshold length of switching condition SCTPSH to SCTP"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_SCTPSH_TPSH = 1e-6
    "Threshold length of switching condition SCTPSH to TPSH"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_SCTP_SC = 1e-6
    "Threshold length of switching condition SCTP to SC"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_SCTP_TP = 1e-6
    "Threshold length of switching condition SCTP to TP"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_TPSH_TP = 1e-6
    "Threshold length of switching condition TPSH to TP"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_TPSH_SH = 1e-6
    "Threshold length of switching condition TPSH to SH"
    annotation (Dialog(tab="Convergence",group="Length"));

  // Definition of inputs
  //
  input Real lenCV[3]
    "Lengths of the different regimes"
    annotation (Dialog(tab="General",group="Inputs"));
  input Modelica.SIunits.Temperature TWalTP
    "Temperature of the wall of the two-phase regime"
    annotation (Dialog(tab="General",group="Inputs"));
  input Modelica.SIunits.SpecificEnthalpy hOutEva
    "Specific enthalpy at inlet of design direction"
    annotation (Dialog(tab="General",group="Inputs"));
  input Modelica.SIunits.SpecificEnthalpy hOutCon
    "Specific enthalpy at out of design direction"
    annotation (Dialog(tab="General",group="Inputs"));
  input Modelica.SIunits.SpecificEnthalpy hLiq
    "Specific enthalpy at bubble line"
    annotation (Dialog(tab="General",group="Inputs"));
  input Modelica.SIunits.SpecificEnthalpy hVap
    "Specific enthalpy at dew line"
    annotation (Dialog(tab="General",group="Inputs"));
  input Real voiFra(unit="1")
    "Void fraction of the two-phase regime"
    annotation (Dialog(tab="General",group="Inputs"));

  // Definition of outputs
  //
  discrete Modelica.SIunits.Temperature TWalTPIni
    "Values used for reinitialisation of TWalTP";
  discrete Modelica.SIunits.SpecificEnthalpy hOutEvaIni
    "Values used for reinitialisation of hOutEvaDes";
  discrete Modelica.SIunits.SpecificEnthalpy hOutConIni
    "Values used for reinitialisation of hOutConDes";
  discrete Modelica.SIunits.SpecificEnthalpy hSCTPIni
    "Values used for reinitialisation of hSCTP";
  discrete Modelica.SIunits.SpecificEnthalpy hTPSHIni
    "Values used for reinitialisation of hTPSH";
  discrete Real lenSCIni
    "Values used for reinitialisation of lenCV[1]";
  discrete Real lenTPIni
    "Values used for reinitialisation of lenTP[2]";
  discrete Real voiFraIni(unit="1")
    "Values used for reinitialisation of voiFra";

  // Definition of subcomponents and connectors
  //
  Utilities.Interfaces.ModeCVOutput modCV
    "Current flow state of moving boundary heat exchanger"
    annotation (Placement(transformation(extent={{92,-10},{112,10}}),
                iconTransformation(extent={{92,-10},{112,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput swi
    "Output that indicates if switching is necessary (= true)";

  // Definition of variables used internally
  //
protected
  discrete Utilities.Types.ModeCV modCVInt
    "Current flow state of moving boundary heat exchanger used internally";

  Boolean swiInt
    "Boolean checking if switching is necessary";
  Boolean SCTPSH_SCTP
    "Boolean checking condition of switiching from SCTPSH to SCTP";
  Boolean SCTPSH_TPSH
    "Boolean checking condition of switiching from SCTPSH to TPSH";
  Boolean SCTP_SCTPSH
    "Boolean checking condition of switiching from SCTP to SCTPSH";
  Boolean SCTP_SC
    "Boolean checking condition of switiching from SCTP to SC";
  Boolean SCTP_TP
    "Boolean checking condition of switiching from SCTP to TP";
  Boolean TPSH_SCTPSH
    "Boolean checking condition of switiching from TPSH to SCTPSH";
  Boolean TPSH_TP
    "Boolean checking condition of switiching from TPSH to TP";
  Boolean TPSH_SH
    "Boolean checking condition of switiching from TPSH to SH";
  Boolean SC_SCTP
    "Boolean checking condition of switiching from SC to SCTP";
  Boolean TP_SCTP
    "Boolean checking condition of switiching from TP to SCTP";
  Boolean TP_TPSH
    "Boolean checking condition of switiching from TP to TPSH";
  Boolean SH_TPSH
    "Boolean checking condition of switiching from SH to TPSH";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={135,135,135},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          extent={{-100,-100},{100,100}},
          radius=25),
        Line(points={{100,80},{0,80},{-70,0}},   color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,50},{0,50},{-70,0}},   color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,20},{0,20},{-70,0}},   color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,-20},{0,-20},{-70,0}},     color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,-50},{0,-50},{-70,0}},   color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,-80},{0,-80},{-70,0}},     color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Ellipse(
          extent={{-50,20},{-90,-20}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Text(
          extent={{0,100},{100,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="SC"),
        Text(
          extent={{0,70},{100,50}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="SCTP"),
        Text(
          extent={{0,40},{100,20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="TP"),
        Text(
          extent={{0,0},{100,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="TPSH"),
        Text(
          extent={{0,-30},{100,-50}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="SH"),
        Text(
          extent={{0,-60},{100,-80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="SCTPSH")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end PartialGuard;
