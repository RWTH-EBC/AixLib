within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector SwitchingUnitBus "Data bus for switching unit system"
  extends Modelica.Icons.SignalBus;
  import      Modelica.Units.SI;
  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus pumpBus;
  Real Y2valSet(min=0, max=1) "Valve opening 0..1";
  Real Y2valSetAct(min=0, max=1) "Actual valve opening 0..1";
  Real Y3valSet(min=0, max=1) "Valve opening 0..1";
  Real Y3valSetAct(min=0, max=1) "Actual valve opening 0..1";
  Real K1valSet(min=0, max=1) "Valve opening 0..1";
  Real K1valSetAct(min=0, max=1) "Actual valve opening 0..1";
  Real K2valSet(min=0, max=1) "Valve opening 0..1";
  Real K2valSetAct(min=0, max=1) "Actual valve opening 0..1";
  Real K3valSet(min=0, max=1) "Valve opening 0..1";
  Real K3valSetAct(min=0, max=1) "Actual valve opening 0..1";
  Real K4valSet(min=0, max=1) "Valve opening 0..1";
  Real K4valSetAct(min=0, max=1) "Actual valve opening 0..1";
  SI.MassFlowRate  mFlowHxGtf  "Volume flow hot side of heatpump system";
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard bus connector for hydraulic modules. A module bus should contain all the information that is necessary to exchange within a particular module type. </p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
end SwitchingUnitBus;
