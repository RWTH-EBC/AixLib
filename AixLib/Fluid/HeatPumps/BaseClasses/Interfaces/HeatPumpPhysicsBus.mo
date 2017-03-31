within AixLib.Fluid.HeatPumps.BaseClasses.Interfaces;
expandable connector HeatPumpPhysicsBus
  "Standard data bus with heat pump information"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  SI.ThermodynamicTemperature Tuse;
  SI.ThermodynamicTemperature Tuse_in;
  SI.ThermodynamicTemperature Tsource;
  SI.ThermodynamicTemperature Tsource_out;
  Real Table_QflowUse_HP_u1;
  Real Table_QflowUse_HP_u2;
  Real Table_Pel_HP_u1;
  Real Table_Pel_HP_u2;
  Real Table_QflowUse_C_u1;
  Real Table_QflowUse_C_u2;
  Real Table_Pel_C_u1;
  Real Table_Pel_C_u2;


  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Definition of a standard pump bus for use with the Zugabe library.
</p>
</html>", revisions="<html>
<ul>
<li>
2012-02-06, by Peter Matthes:<br/>
First implementation.
</li>
</ul>
</html>"));
end HeatPumpPhysicsBus;
