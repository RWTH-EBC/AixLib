within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities;
package Guards "Package that contains different guards"
  extends Modelica.Icons.VariantsPackage;

  model GeneralGuard
    "Model that guards the flow state of a moving boundary heat exchanger"
    extends BaseClasses.PartialGuard;

  initial equation

    /*Checking the current flow state at initialisation. This is necassary
    since models depending on the flow state (i.e. moving boundary and
    wall cell) use this variable at initialisation as well.
  */

    if hOutEva > hVap then
      if hOutCon <= hLiq then
        /* Supercooled - Two-phase - Superheated*/
        modCVInt = Types.ModeCV.SCTPSH "Flow state of heat exchanger";
      else
        if hOutCon < hVap then
        /* Two-phase - Superheated*/
          modCVInt = Types.ModeCV.TPSH "Flow state of heat exchanger";
        else
        /* Superheated*/
          modCVInt = Types.ModeCV.SH "Flow state of heat exchanger";
        end if;
      end if;
    else
      if hOutCon <= hLiq then
        if hOutEva > hLiq then
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
    SCTPSH_SCTP = (hOutEva<hVap+dhMin_SCTPSH_SCTP) or (lenCV[3]<lenMin_SCTPSH_SCTP)
      "Boolean checking condition of switiching from SCTPSH to SCTP";
    SCTPSH_TPSH = (hOutCon>hLiq-dhMin_SCTPSH_TPSH) or (lenCV[1]<lenMin_SCTPSH_TPSH)
      "Boolean checking condition of switiching from SCTPSH to TPSH";

    SCTP_SCTPSH = (hOutEva>hVap-dhMin_SCTP_SCTPSH)
      "Boolean checking condition of switiching from SCTP to SCTPSH";
    SCTP_SC = (hOutEva<hLiq+dhMin_SCTP_SC) or (lenCV[2]<lenMin_SCTP_SC)
      "Boolean checking condition of switiching from SCTP to SC";
    SCTP_TP = (hOutCon>hLiq-dhMin_SCTP_TP) or (lenCV[1]<lenMin_SCTP_TP)
      "Boolean checking condition of switiching from SCTP to TP";

    TPSH_SCTPSH = (hOutCon<hLiq+dhMin_TPSH_SCTPSH)
      "Boolean checking condition of switiching from TPSH to SCTPSH";
    TPSH_TP = (hOutEva<hVap+dhMin_TPSH_TP) or (lenCV[3]<lenMin_TPSH_TP)
      "Boolean checking condition of switiching from TPSH to TP";
    TPSH_SH = (hOutCon>hVap-dhMin_TPSH_SH) or (lenCV[2]<lenMin_TPSH_SH)
      "Boolean checking condition of switiching from TPSH to SH";

    SC_SCTP = (hOutEva>hLiq-dhMin_SC_SCTP)
      "Boolean checking condition of switiching from SC to SCTP";
    TP_SCTP = (hOutCon<hLiq+dhMin_TP_SCTP)
      "Boolean checking condition of switiching from TP to SCTP";
    TP_TPSH = (hOutEva>hVap-dhMin_TP_TPSH)
      "Boolean checking condition of switiching from TP to TPSH";
    SH_TPSH = (hOutCon<hVap+dhMin_SH_TPSH)
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
          hOutConIni = hOutCon;
          hOutEvaIni = hVap-2*dhMin_SCTPSH_SCTP;
          hSCTPIni = hLiq;
          hTPSHIni = hOutEvaIni;
          TWalTPIni = TWalTP;
          lenSCIni = lenCV[1];
          lenTPIni = 1-lenSCIni-lenMin_SCTPSH_SCTP;
          voiFraIni = voiFra;

        else
          /* Switching from SCTPSH to TPSH*/
          modCVInt = Types.ModeCV.TPSH;
          hOutConIni = hLiq+2*dhMin_SCTPSH_TPSH;
          hOutEvaIni = hOutEva;
          hSCTPIni = hOutConIni;
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
          hOutConIni = hLiq+2*dhMin_SCTP_TP;
          hOutEvaIni = hOutEva;
          hSCTPIni = hOutConIni;
          hTPSHIni = hOutEvaIni;
          TWalTPIni = TWalTP;
          lenSCIni = lenMin_SCTP_TP;
          lenTPIni = 1-2*lenMin_SCTP_TP;
          voiFraIni = voiFra;

        elseif SCTP_SC then
          /* Switching from SCTP to SC*/

          modCVInt = Types.ModeCV.SC;
          hOutConIni = hOutCon;
          hOutEvaIni = hLiq-2*dhMin_SCTP_SC;
          hSCTPIni = hLiq;
          hTPSHIni = hOutEvaIni;
          TWalTPIni = TWalTP;
          lenSCIni = 1-2*lenMin_SCTP_SC;
          lenTPIni = lenMin_SCTP_SC;
          voiFraIni = 0;

        else
          /* Switching from SCTP to SCTPSH*/

          modCVInt = Types.ModeCV.SCTPSH;
          hOutConIni = hOutCon;
          hOutEvaIni = hVap+2*dhMin_SCTP_SCTPSH;
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
          hOutConIni = hOutCon;
          hOutEvaIni = hVap-2*dhMin_TPSH_TP;
          hSCTPIni = hOutConIni;
          hTPSHIni = hOutEvaIni;
          TWalTPIni = TWalTP;
          lenSCIni = lenMin_TPSH_TP;
          lenTPIni = 1-2*lenMin_TPSH_TP;
          voiFraIni = voiFra;

        elseif TPSH_SH then
          /* Switching from TPSH to SH*/
          modCVInt = Types.ModeCV.SH;
          hOutConIni = hVap+2*dhMin_TPSH_SH;
          hOutEvaIni = hOutEva;
          hSCTPIni = hOutConIni;
          hTPSHIni = hOutConIni;
          TWalTPIni = TWalTP;
          lenSCIni = lenMin_TPSH_SH;
          lenTPIni = lenMin_TPSH_SH;
          voiFraIni = 1;

        else
          /* Switching from TPSH to SCTPSH*/
          modCVInt = Types.ModeCV.SCTPSH;
          hOutConIni = hOutCon-2*dhMin_TPSH_SCTPSH;
          hOutEvaIni = hOutEva;
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
          hOutConIni = hOutCon;
          hOutEvaIni = hVap+2*dhMin_TP_TPSH;
          hSCTPIni = hOutConIni;
          hTPSHIni = hVap;
          TWalTPIni = TWalTP;
          lenSCIni = lenMin;
          lenTPIni = 1-2*lenMin;
          voiFraIni = voiFra;

        else
          /* Switching from TP to SCTP*/
          modCVInt = Types.ModeCV.SCTP;
          hOutConIni = hLiq-2*dhMin_TP_SCTP;
          hOutEvaIni = hOutEva;
          hSCTPIni = hLiq;
          hTPSHIni = hOutEvaIni;
          TWalTPIni = TWalTP;
          lenSCIni = lenMin;
          lenTPIni = 1-lenMin;
          voiFraIni = voiFra;

         end if;
      elseif pre(modCVInt)==Types.ModeCV.SC then
        /* Switching from SC to SCTP*/

        modCVInt = Types.ModeCV.SCTP;
        hOutConIni = hOutCon;
        hOutEvaIni = hLiq+2*dhMin_SC_SCTP;
        hSCTPIni = hLiq;
        hTPSHIni = hOutEvaIni;
        TWalTPIni = TWalTP;
        lenSCIni = 1-2*lenMin;
        lenTPIni = lenMin;
        voiFraIni = 0;

      else
        /* Switching from SH to TPSH*/
        modCVInt = Types.ModeCV.TPSH;
        hOutConIni = hVap-2*dhMin_SH_TPSH;
        hOutEvaIni = hOutEva;
        hSCTPIni = hOutConIni;
        hTPSHIni = hVap;
        TWalTPIni = TWalTP;
        lenSCIni = lenMin;
        lenTPIni = lenMin;
        voiFraIni = 1;

      end if;
    end when;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
  end GeneralGuard;
end Guards;
