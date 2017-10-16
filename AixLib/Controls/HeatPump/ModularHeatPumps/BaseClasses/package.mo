within AixLib.Controls.HeatPump.ModularHeatPumps;
package BaseClasses "Package that contains base models used for controllers of modular heat pumps"
  extends Modelica.Icons.BasesPackage;

  partial model PartialModularController
    "Base model used for all modular controllers"

    // Definition of parameters describing modular approach
    //
    parameter Integer nVal = 1
      "Number of valves";

    // Definition of connectors and inputs and outputs
    //
    Interfaces.ModularExpansionValveBus dataBus(final
        nComp=nVal)
      "Data bus with signals to allow control of expansion valves"
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Blocks.Interfaces.RealInput opeAct[nVal]
      "Array of signals with actual expansion valves' opening degrees"
      annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,112}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,112})));
    Modelica.Blocks.Interfaces.RealOutput opeSet[nVal]
      "Array of set signals for expansion valves' opening degrees"
      annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-60,112}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-60,112})));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-80,60},{80,-60}},
            lineColor={0,0,0},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5),
          Text(
            extent={{-76,90},{76,-30}},
            lineColor={175,175,175},
            lineThickness=0.5,
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            textStyle={TextStyle.Bold},
            textString="Control"),
          Line(
            points={{0,-70},{0,-96}},
            color={244,125,35},
            thickness=0.5),
          Ellipse(
            extent={{-10,-50},{10,-70}},
            lineColor={0,0,0},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            startAngle=0,
            endAngle=360),
          Line(
            points={{-60,92},{-60,70}},
            color={244,125,35},
            thickness=0.5),
          Ellipse(
            extent={{-70,70},{-50,50}},
            lineColor={0,0,0},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            startAngle=0,
            endAngle=360),
          Line(
            points={{60,92},{60,70}},
            color={244,125,35},
            thickness=0.5),
          Ellipse(
            extent={{50,70},{70,50}},
            lineColor={0,0,0},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            startAngle=0,
            endAngle=360)}),
          Diagram(
            coordinateSystem(preserveAspectRatio=false)));

  end PartialModularController;
end BaseClasses;
