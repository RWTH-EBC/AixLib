within AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection;
function NoModel "No model"
  extends
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.PartialBaseFct(
      T_eva);

algorithm
f_CoPicing:=1;

  annotation (Documentation(info="<html>
<p>No correction factor for icing/defrosting: f_cop_icing=1. </p>
</html>",
  revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
end NoModel;
