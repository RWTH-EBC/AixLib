within AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics;
function ConstantCoP "Constant CoP and constant electric power"
  extends
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.PartialBaseFct(
    N,
    T_con,
    T_eva,
    mFlow_eva,
    mFlow_con);
    parameter Modelica.SIunits.Power powerCompressor=2000
    "Constant electric power input for compressor";
    parameter Real CoP "Constant CoP";
algorithm
  Char:= {powerCompressor,powerCompressor*CoP};

  annotation (Documentation(info="<html>
<p>Carnot CoP and constant electric power, no dependency on speed or mass flow rates!</p>
</html>",
    revisions="<html>
<ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul>
</html>
"));
end ConstantCoP;
