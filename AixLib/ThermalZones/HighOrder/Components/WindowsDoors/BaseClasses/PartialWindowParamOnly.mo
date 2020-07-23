within AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses;
model PartialWindowParamOnly
  "Partial model for windows, containing parameters only"

  parameter Boolean use_windSpeedPort = true "Enable wind speed input connector" annotation(Dialog(tab="Connector usage", group="Inputs"));
  parameter Boolean use_solarRadWinTrans = true "Enable transmitted solar radiation output connector" annotation(Dialog(tab="Connector usage", group="Outputs"));

  parameter Modelica.SIunits.Area windowarea "Total fenestration area";
  parameter Modelica.SIunits.Temperature T0= 293.15 "Initial temperature";

  replaceable parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType constrainedby DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
      "Window record / type"
    annotation (Dialog(
      group="Window type",
      descriptionLabel=true), choicesAllMatching=true);

  replaceable CorrectionSolarGain.PartialCorGParamOnly correctionSolarGain constrainedby CorrectionSolarGain.PartialCorGParamOnly(
   final n=1,
   final Uw=WindowType.Uw,
   final g=WindowType.g) annotation (Placement(transformation(extent={{-50,50},{-30,70}})), choicesAllMatching=true);


  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),   Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
      Line(
        points={{-66,18},{-62,18}},
        color={255,255,0}),
      Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
      Rectangle(
        extent={{-80,80},{80,-80}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-4,42},{10,-76}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-76,46},{74,38}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Line(
        points={{2,40},{2,-76},{76,-76},{76,40},{2,40}}),
      Line(
        points={{-76,40},{-76,-76},{-2,-76},{-2,40},{-76,40}}),
      Line(
        points={{-76,76},{-76,44},{76,44},{76,76},{-76,76}}),
      Rectangle(
        extent={{4,-8},{6,-20}},
        lineColor={0,0,0},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-72,72},{-72,48},{72,48},{72,72},{-72,72}}),
      Rectangle(
        extent={{-72,72},{72,48}},
        lineColor={0,0,0},
        fillColor={211,243,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{10,36},{72,-72}},
        lineColor={0,0,0},
        fillColor={211,243,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-72,36},{-8,-72}},
        lineColor={0,0,0},
        fillColor={211,243,255},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-8,36},{-8,-72},{-72,-72},{-72,36},{-8,36}}),
      Line(
        points={{72,36},{72,-72},{10,-72},{10,36},{72,36}}),
      Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}));
end PartialWindowParamOnly;
