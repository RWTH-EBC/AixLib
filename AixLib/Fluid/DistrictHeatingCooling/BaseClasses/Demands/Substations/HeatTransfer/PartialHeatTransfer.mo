within AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.Substations.HeatTransfer;
partial model PartialHeatTransfer
  "Base class for heat transfer components in DHC substations"
  extends Interfaces.PartialTwoPort;

  parameter Boolean use_Q_in = false
    "Get the prescribed heat flow rate from the input connector"
    annotation(Evaluate=true, HideResult=true);

  parameter Modelica.SIunits.HeatFlowRate prescribedQ
    "Fixed value of prescribed heat flow rate"
    annotation (Dialog(enable = not use_Q_in));

  Modelica.Blocks.Interfaces.RealInput Q_in(final unit="W") if use_Q_in
    "Prescribed heat flow rate connector"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

protected
  Modelica.Blocks.Interfaces.RealInput Q_in_internal(final unit="W")
    "Needed to connect to conditional connector";

equation
  connect(Q_in, Q_in_internal);
  if not use_Q_in then
    Q_in_internal = prescribedQ;
  end if;

  annotation (Documentation(info="<html><p>
  A base class for modeling the heat transfer component within DHC
  substations.
</p>
<ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end PartialHeatTransfer;
