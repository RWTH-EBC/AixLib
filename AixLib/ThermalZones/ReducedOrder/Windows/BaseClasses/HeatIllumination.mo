within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model HeatIllumination "heating energy due to Illumination"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.EnergyFlowRate HIll1
    "Energy output of Illumination in the morning and evening";
  parameter Modelica.Units.SI.EnergyFlowRate HIll2
    "Energy output of Illumination during daytime";
  Modelica.Blocks.Interfaces.BooleanInput Illumination
    "True if Illumination is on, False if it is turned off"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealOutput HIll(final quantity=
    "EnergyFlowRate", final unit="W") "Energyoutput of Illumination"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-12},{124,12}})));
protected
  constant Modelica.Units.SI.Time day=86400;
equation
  if Illumination==false then
    HIll=0;
  else
    if time-integer(time/day)*day < 25200 or
      time-integer(time/day)*day > 68400 then
      HIll=0;
    elseif time-integer(time/day)*day > 25200 and
      time-integer(time/day)*day < 64800 then
      HIll=HIll2;
    else
      HIll=HIll1;
    end if;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model calculates the heat input in the room due to illumination.
</p>
<ul>
  <li>July 17 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end HeatIllumination;
