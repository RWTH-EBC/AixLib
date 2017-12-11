within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities;
model Guard
  "Model that guards the flow state of a moving boundary heat exchanger"

  // Definition of parameters
  //
  parameter Boolean useFixModCV = false
    "= true, if flow state is prescribed and does not change"
    annotation (Dialog(tab="General",group="Void fraction"));
  parameter Types.ModeCV modCVPar=
    Types.ModeCV.SCTPSH
    "Constant void fraction if not calculated by model"
    annotation (Dialog(tab="General",group="Void fraction",
                enable = useFixModCV));

  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTPSH_SCTP = 10
    "Threshold specific enthalpy of switching condition SCTPSH to SCTP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTPSH_TPSH = 10
    "Threshold specific enthalpy of switching condition SCTPSH to TPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_SCTPSH = 5
    "Threshold specific enthalpy of switching condition SCTP to SCTPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_SC = 10
    "Threshold specific enthalpy of switching condition SCTP to SC"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SCTP_TP = 10
    "Threshold specific enthalpy of switching condition SCTP to TP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_SCTPSH = 10
    "Threshold specific enthalpy of switching condition TPSH to SCTPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_TP = 10
    "Threshold specific enthalpy of switching condition TPSH to TP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TPSH_SH = 10
    "Threshold specific enthalpy of switching condition TPSH to SH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SC_SCTP = 0.1
    "Threshold specific enthalpy of switching condition SC to SCTP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TP_SCTP = 10
    "Threshold specific enthalpy of switching condition TP to SCTP"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_TP_TPSH = 10
    "Threshold specific enthalpy of switching condition TP to TPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));
  parameter Modelica.SIunits.SpecificEnthalpy dhMin_SH_TPSH = 10
    "Threshold specific enthalpy of switching condition SH to TPSH"
    annotation (Dialog(tab="Convergence",group="Specific enthalpy"));

  parameter Real lenMin = 1e-4
    "Threshold length of switching condition"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_SCTPSH_SCTP = 1e-3
    "Threshold length of switching condition SCTPSH to SCTP"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_SCTPSH_TPSH = 1e-4
    "Threshold length of switching condition SCTPSH to TPSH"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_SCTP_SC = 1e-4
    "Threshold length of switching condition SCTP to SC"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_SCTP_TP = 1e-4
    "Threshold length of switching condition SCTP to TP"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_TPSH_TP = 1e-4
    "Threshold length of switching condition TPSH to TP"
    annotation (Dialog(tab="Convergence",group="Length"));
  parameter Real lenMin_TPSH_SH = 1e-4
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
  input Modelica.SIunits.SpecificEnthalpy hInlDes
    "Specific enthalpy at inlet of design direction"
    annotation (Dialog(tab="General",group="Inputs"));
  input Modelica.SIunits.SpecificEnthalpy hOutDes
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
  discrete Modelica.SIunits.SpecificEnthalpy hInlDesIni
    "Values used for reinitialisation of hInlDesDes";
  discrete Modelica.SIunits.SpecificEnthalpy hOutDesIni
    "Values used for reinitialisation of hOutDesDes";
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
  Interfaces.ModeCVOutput modCV
    "Current flow state of moving boundary heat exchanger"
    annotation (Placement(transformation(extent={{92,-10},{112,10}}),
                iconTransformation(extent={{92,-10},{112,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput swi
    "Output that indicates if switching is necessary (= true)";

  // Definition of variables used internally
  //
  discrete Types.ModeCV modCVInt
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


initial equation

  /*Checking the current flow state at initialisation. This is necassary
    since models depending on the flow state (i.e. moving boundary and
    wall cell) use this variable at initialisation as well.
  */

  if hOutDes > hVap then
    if hInlDes <= hLiq then
      /* Supercooled - Two-phase - Superheated*/
      modCVInt = Types.ModeCV.SCTPSH "Flow state of heat exchanger";
    else
      if hInlDes < hVap then
      /* Two-phase - Superheated*/
        modCVInt = Types.ModeCV.TPSH "Flow state of heat exchanger";
      else
      /* Superheated*/
        modCVInt = Types.ModeCV.SH "Flow state of heat exchanger";
      end if;
    end if;
  else
    if hInlDes <= hLiq then
      if hOutDes > hLiq then
      /* Supercooled - Two-phase*/
        modCVInt = Types.ModeCV.SCTP "Flow state of heat exchanger";
      else
      /* Supercooled*/
        modCVInt = Types.ModeCV.SC "Flow state of heat exchanger";
      end if;
    else
      /* Two-phase*/
      modCVInt = Types.ModeCV.TP "Flow state of heat exchanger";
    end if;
  end if;


equation
  // Connect variables with connectors
  //
  modCV = if useFixModCV then modCVPar else modCVInt
    "Current flow state";
  swi = if useFixModCV then false else swiInt
    "Boolean indicating if switching is necessary";

  // Check if change of flow state is necessary
  //
  SCTPSH_SCTP = (hOutDes<hVap-dhMin_SCTPSH_SCTP) or (lenCV[3]<lenMin_SCTPSH_SCTP)
    "Boolean checking condition of switiching from SCTPSH to SCTP";
  SCTPSH_TPSH = (hInlDes>hLiq+dhMin_SCTPSH_TPSH) or (lenCV[1]<lenMin_SCTPSH_TPSH)
    "Boolean checking condition of switiching from SCTPSH to TPSH";

  SCTP_SCTPSH = (hOutDes>hVap-dhMin_SCTP_SCTPSH)
    "Boolean checking condition of switiching from SCTP to SCTPSH";                //valid
  SCTP_SC = (hOutDes<hLiq+dhMin_SCTP_SC) or (lenCV[2]<lenMin_SCTP_SC)
    "Boolean checking condition of switiching from SCTP to SC";
  SCTP_TP = (hInlDes>hLiq+dhMin_SCTP_TP) or (lenCV[1]<lenMin_SCTP_TP)
    "Boolean checking condition of switiching from SCTP to TP";

  TPSH_SCTPSH = (hInlDes<hLiq-dhMin_TPSH_SCTPSH)
    "Boolean checking condition of switiching from TPSH to SCTPSH";
  TPSH_TP = (hOutDes<hVap+dhMin_TPSH_TP) or (lenCV[3]<lenMin_TPSH_TP)
    "Boolean checking condition of switiching from TPSH to TP";
  TPSH_SH = (hInlDes>hVap+dhMin_TPSH_SH) or (lenCV[2]<lenMin_TPSH_SH)
    "Boolean checking condition of switiching from TPSH to SH";

  SC_SCTP = (hOutDes>hLiq+dhMin_SC_SCTP)
    "Boolean checking condition of switiching from SC to SCTP";                    //valid
  TP_SCTP = (hInlDes<hLiq-dhMin_TP_SCTP)
    "Boolean checking condition of switiching from TP to SCTP";
  TP_TPSH = (hOutDes>hVap-dhMin_TP_TPSH)
    "Boolean checking condition of switiching from TP to TPSH";
  SH_TPSH = (hInlDes<hVap-dhMin_SH_TPSH)
    "Boolean checking condition of switiching from SH to TPSH";

  swiInt = (pre(modCVInt)==Types.ModeCV.SCTPSH and
             (SCTPSH_SCTP or SCTPSH_TPSH)) or
           (pre(modCVInt)==Types.ModeCV.SCTP and
             (SCTP_SCTPSH or SCTP_SC or SCTP_TP)) or
           (pre(modCVInt)==Types.ModeCV.TPSH and
             (TPSH_SCTPSH or TPSH_TP or TPSH_SH)) or
           (pre(modCVInt)==Types.ModeCV.SC and SC_SCTP) or
           (pre(modCVInt)==Types.ModeCV.TP and (TP_SCTP or TP_TPSH)) or
           (pre(modCVInt)==Types.ModeCV.SH and SH_TPSH)
    "Boolean indicating if switching is necessary";

  // Calculate values of variables that may be reinitialised
  //
  when swiInt then
    if pre(modCVInt)==Types.ModeCV.SCTPSH then
      if SCTPSH_SCTP then
        /* Switching from SCTPSH to SCTP*/
        modCVInt = Types.ModeCV.SCTP;
        hInlDesIni = hInlDes;
        hOutDesIni = hVap-dhMin_SCTPSH_SCTP;
        hSCTPIni = hLiq;
        hTPSHIni = hOutDesIni;
        TWalTPIni = TWalTP;
        lenSCIni = lenCV[1];
        lenTPIni = 1-lenSCIni-lenMin_SCTPSH_SCTP;
        voiFraIni = voiFra;

      else
        /* Switching from SCTPSH to TPSH*/
        modCVInt = Types.ModeCV.TPSH;
        hInlDesIni = hLiq+dhMin_SCTPSH_TPSH;
        hOutDesIni = hOutDes;
        hSCTPIni = hInlDesIni;
        hTPSHIni = hVap;
        TWalTPIni = TWalTP;
        lenSCIni = lenMin_SCTPSH_TPSH;
        lenTPIni = 1-lenCV[3]-lenSCIni;
        voiFraIni = voiFra;

       end if;
    elseif pre(modCVInt)==Types.ModeCV.SCTP then
      if SCTP_TP then
        /* Switching from SCTP to TP*/
        modCVInt = Types.ModeCV.TP;
        hInlDesIni = hLiq+dhMin_SCTP_TP;
        hOutDesIni = hOutDes;
        hSCTPIni = hInlDesIni;
        hTPSHIni = hOutDesIni;
        TWalTPIni = TWalTP;
        lenSCIni = lenMin_SCTP_TP;
        lenTPIni = 1-2*lenMin_SCTP_TP;
        voiFraIni = voiFra;

      elseif SCTP_SC then
        /* Switching from SCTP to SC*/
        modCVInt = Types.ModeCV.SC;
        hInlDesIni = hInlDes;
        hOutDesIni = hLiq-2*dhMin_SCTP_SC;
        hSCTPIni = hLiq;
        hTPSHIni = hOutDesIni;
        TWalTPIni = TWalTP;
        lenSCIni = 1-2*lenMin_SCTP_SC;
        lenTPIni = lenMin_SCTP_SC;
        voiFraIni = 0;

      else
        /* Switching from SCTP to SCTPSH*/
        modCVInt = Types.ModeCV.SCTPSH;                                          //valid
        hInlDesIni = hInlDes;
        hOutDesIni = hVap+2*dhMin_SCTP_SCTPSH;
        hSCTPIni = hLiq;
        hTPSHIni = hVap;
        TWalTPIni = TWalTP;
        lenSCIni = lenCV[1];
        lenTPIni = 1-lenSCIni-lenMin;
        voiFraIni = voiFra;

      end if;
    elseif pre(modCVInt)==Types.ModeCV.TPSH then
      if TPSH_TP then
        /* Switching from TPSH to TP*/
        modCVInt = Types.ModeCV.TP;
        hInlDesIni = hInlDes;
        hOutDesIni = hVap-dhMin_TPSH_TP;
        hSCTPIni = hInlDesIni;
        hTPSHIni = hOutDesIni;
        TWalTPIni = TWalTP;
        lenSCIni = lenMin_TPSH_TP;
        lenTPIni = 1-2*lenMin_TPSH_TP;
        voiFraIni = voiFra;

      elseif TPSH_SH then
        /* Switching from TPSH to SH*/
        modCVInt = Types.ModeCV.SH;
        hInlDesIni = hVap+dhMin_TPSH_SH;
        hOutDesIni = hOutDes;
        hSCTPIni = hInlDesIni;
        hTPSHIni = hInlDesIni;
        TWalTPIni = TWalTP;
        lenSCIni = lenMin_TPSH_SH;
        lenTPIni = lenMin_TPSH_SH;
        voiFraIni = 1;

      else
        /* Switching from TPSH to SCTPSH*/
        modCVInt = Types.ModeCV.SCTPSH;
        hInlDesIni = hInlDes-dhMin_TPSH_SCTPSH;
        hOutDesIni = hOutDes;
        hSCTPIni = hLiq;
        hTPSHIni = hVap;
        TWalTPIni = TWalTP;
        lenSCIni = lenMin;
        lenTPIni = 1-lenCV[3]-lenMin;
        voiFraIni = voiFra;

      end if;
    elseif pre(modCVInt)==Types.ModeCV.TP then
      if TP_TPSH then
        /* Switching from TP to TPSH*/
        modCVInt = Types.ModeCV.TPSH;
        hInlDesIni = hInlDes;
        hOutDesIni = hVap+dhMin_TP_TPSH;
        hSCTPIni = hInlDesIni;
        hTPSHIni = hVap;
        TWalTPIni = TWalTP;
        lenSCIni = lenMin;
        lenTPIni = 1-2*lenMin;
        voiFraIni = voiFra;

      else
        /* Switching from TP to SCTP*/
        modCVInt = Types.ModeCV.SCTP;
        hInlDesIni = hLiq-dhMin_TP_SCTP;
        hOutDesIni = hOutDes;
        hSCTPIni = hLiq;
        hTPSHIni = hOutDesIni;
        TWalTPIni = TWalTP;
        lenSCIni = lenMin;
        lenTPIni = 1-lenMin;
        voiFraIni = voiFra;

       end if;
    elseif pre(modCVInt)==Types.ModeCV.SC then
        /* Switching from SC to SCTP*/
                                                                                //valid
      modCVInt = Types.ModeCV.SCTP;
      hInlDesIni = hInlDes;
      hOutDesIni = hLiq+dhMin_SC_SCTP;
      hSCTPIni = hLiq;
      hTPSHIni = hOutDesIni;
      TWalTPIni = TWalTP;
      lenSCIni = 1-2*lenMin;
      lenTPIni = lenMin;
      voiFraIni = 0;

    else
      /* Switching from SH to TPSH*/
      modCVInt = Types.ModeCV.TPSH;
      hInlDesIni = hVap-dhMin_SH_TPSH;
      hOutDesIni = hOutDes;
      hSCTPIni = hInlDesIni;
      hTPSHIni = hVap;
      TWalTPIni = TWalTP;
      lenSCIni = lenMin;
      lenTPIni = lenMin;
      voiFraIni = 1;

    end if;
  end when;

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
          textString="SCTPSH"),
        Text(
          extent={{-149,-114},{151,-154}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  December 10, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"));
end Guard;
