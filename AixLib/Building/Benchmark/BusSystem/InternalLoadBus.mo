within AixLib.Building.Benchmark.BusSystem;
expandable connector InternalLoadBus "Bus for Internal Loads"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  Modelica.SIunits.Power MET "Metabolic rate in W"
    annotation (HideResult=false);
  Real PowerEquipment "Power from Equipment in W"
    annotation (HideResult=false);
  Real clothing "clothing in clo (1 clo = 0.155 m*C/W)" annotation (HideResult=false);
  Real WaterFromEquipment "Water from Equipment e.g. plants" annotation (HideResult=false);
  Real NumberOccupants "Number of People in the room" annotation (HideResult=false);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

end InternalLoadBus;
