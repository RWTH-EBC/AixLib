within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PressureLoss;
function GetPressureLossOfUFHDistributor
  "Function to evaluate the pressure loss for a given number of heating circuit distributor outlets."
  input Modelica.Units.SI.VolumeFlowRate vol_flow "Volume flow rate";
  input Integer numHeaCirDisOut(min=2, max=14) "Number of heating circuit distributor outlets";
  output Modelica.Units.SI.PressureDifference preDrop
    "Pressure drop for the given input";
protected
  Real vol_flow_internal= vol_flow*1000*3600 "Used for conversion of m^3/s to litre/h";
  Real table_internal "Table with offset for the different number of heating circuit outlets";
  // Based on the table in Schuetz Energy Systems- see info.
  parameter Real slope=2.12944 "Constant for every number of registers.";
  Real offset "Output of the table";
algorithm
  assert(numHeaCirDisOut > 1, "The calculated number of heating circuit distribution outlets is " + String(numHeaCirDisOut) + ". This value is too low! You could set a smaller zone spacing.", level = AssertionLevel.error);
  assert(numHeaCirDisOut < 15, "The calculated number of heating circuit distribution outlets is " + String(numHeaCirDisOut) + ". This value is too high! You could set a higher zone spacing.", level = AssertionLevel.error);
  // Based on the table in Schuetz Energy Systems- see info.
  if numHeaCirDisOut==2 then
    offset := -11.788371506907453;
  elseif numHeaCirDisOut==3 then
    offset := -12.571094906030572;
  elseif numHeaCirDisOut==4 then
    offset := -13.048512484688304;
  elseif numHeaCirDisOut==5 then
    offset := -13.2811178491032;
  elseif numHeaCirDisOut==6 then
    offset := -13.502462293474359;
  elseif numHeaCirDisOut==7 then
    offset := -13.652547735813013;
  elseif numHeaCirDisOut==8 then
    offset := -13.713987271819773;
  else
    offset := -13.799344983248627;
  end if;
  preDrop := Modelica.Constants.e^(slope * Modelica.Math.log(vol_flow_internal) + offset)*1000;
  annotation (Documentation(info="<html><p>
  Get the pressure loss of an under floor heating system based on the
  number of heating circuit distributor outlets. The data is calculated
  based on the log-log-diagram in the following image. Based on [1, p.
  11].
</p>
<p>
  <img src=
  \"modelica://UnderfloorHeating/Resources/PressureLossOfUFHDistributor.png\"
  alt=\"1\">
</p>
<p>
  [1] SCHÜTZ ENERGY SYSTEMS: Heizkreisverteiler: Montageanleitung/-
  Technische Information. 2017; <a href=
  \"https://www.schuetz-energy.net/downloads/anleitungen/montageanleitung-heizkreisverteiler/schuetz-montageanleitung-fbh-heizkreisverteiler-de.pdf\">
  Link to pdf</a>
</p>
</html>"));
end GetPressureLossOfUFHDistributor;
