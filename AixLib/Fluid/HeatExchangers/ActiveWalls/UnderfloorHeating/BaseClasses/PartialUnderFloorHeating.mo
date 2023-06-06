within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
partial model PartialUnderFloorHeating
  "Common interfaces for underfloor heating"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
  extends PartialUnderFloorHeatingParameters;

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Panel Heating"));
  final parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=
      m_flow_nominal/rho_default "Nominal Volume Flow Rate in pipe";

protected
    parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialUnderFloorHeating;
