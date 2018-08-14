within AixLib.Fluid.BoilerCHP.BaseClasses;
expandable connector BoilerBus
  "Standard data bus with boiler information"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  SI.DimensionlessRatio PLR "Part Load Rate (0-1)"
                                                  annotation (HideResult=false);
  SI.Power Pgas "Power of consumed gas"
                                       annotation (HideResult=false);
  SI.HeatFlowRate Q_flow "Power of heatflow"
                                            annotation (HideResult=false);
  SI.Temperature T_in "Inlet temperature"
                                         annotation (HideResult=false);
  SI.Temperature T_out "Outlet temperature"
                                           annotation (HideResult=false);
  SI.Temperature T_amb "Ambient temperature"
                                            annotation (HideResult=false);
  SI.Temperature T_set "Outlet set temperature" annotation (HideResult=false);
  SI.MassFlowRate m_flow "Mass flow through boiler"
                                                   annotation (HideResult=false);
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard pump bus. </p>
</html>", revisions="<html>
<ul>
<li>2018-08-14 by Luca Vedda:<br>Transfer to AixLib.</li>
<li>2012-02-06 by Peter Matthes:<br>First implementation. </li>
</ul>
</html>"));
end BoilerBus;
