within AixLib.Fluid.Movers.Preconfigured;
model FlowControlled_dp "Fan or pump with ideally controlled head dp as input signal and pre-configured parameters"
  extends AixLib.Fluid.Movers.FlowControlled_dp(
    final per(
            pressure(
              V_flow=m_flow_nominal/rho_default*{0, 1, 2},
              dp=if rho_default < 500
                   then dp_nominal*{1.12, 1, 0}
                   else dp_nominal*{1.14, 1, 0.42}),
            powerOrEfficiencyIsHydraulic=true,
            etaHydMet=AixLib.Fluid.Movers.BaseClasses.Types.HydraulicEfficiencyMethod.EulerNumber,
            etaMotMet=AixLib.Fluid.Movers.BaseClasses.Types.MotorEfficiencyMethod.GenericCurve),
    final constantHead,
    final heads,
    final nominalValuesDefineDefaultPressureCurve=true,
    final inputType=AixLib.Fluid.Types.InputType.Continuous,
    final prescribeSystemPressure=false,
    final init=Modelica.Blocks.Types.Init.InitialOutput,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial);
    annotation (
defaultComponentName="mov",
Documentation(info="<html>
<p>
This model is the preconfigured version for
<a href=\"Modelica://AixLib.Fluid.Movers.FlowControlled_dp\">
AixLib.Fluid.Movers.FlowControlled_dp</a>.
</html>", revisions="<html>
<ul>
<li>
August 17, 2022, by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">#2668</a>.
</li>
</ul>
</html>"),
   __Dymola_LockedEditing="Model from IBPSA");
end FlowControlled_dp;
