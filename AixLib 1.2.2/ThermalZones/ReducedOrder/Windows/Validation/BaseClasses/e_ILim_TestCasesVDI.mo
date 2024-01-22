within AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses;
model e_ILim_TestCasesVDI
  "Picks e_ILim according to the test cases of VDI6007"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean office = true "If true: room is office";

  Modelica.Blocks.Interfaces.RealOutput e_ILim
    "Internal illumance in reference point"
        annotation (Placement(transformation(extent={{98,-10},{118,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Units.SI.Illuminance e_ILim1=250 "Internal illumninance required in reference point in the morning and
    evening";
  Modelica.Units.SI.Illuminance e_ILim2=500
    "Internal illumainance required in reference point during working hours";
  constant Modelica.Units.SI.Time day=86400 "Number of seconds in a day";
  constant Modelica.Units.SI.Time week=604800 "Number of seconds in a week";
equation
  //Picking value for e_ILim
  if (time-integer(time/day)*day)>64800 or (time-integer(time/day)*day)<25200
    or (office and time-integer(time/week)*week>432000) then
    e_ILim=0;
  elseif (time-integer(time/day)*day)>28800 and
    (time-integer(time/day)*day)<57600 then
    e_ILim=e_ILim2;
  else
    e_ILim=e_ILim1;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>July 17 2017,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end e_ILim_TestCasesVDI;
