within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses;
block CheckResultsAccordingToASHRAE
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.Units.SI.Time checkTime
    "Simulation time when block should check if model results lies in limit range";

  parameter String dispType = "None" "Letter displayed in icon" annotation (
    Dialog(group="Graphical only"),
    choices(
      choice="Q Heat",
      choice="Q Cool",
      choice="T Max",
      choice="T Min"));

  Modelica.Blocks.Interfaces.RealInput upperLimit
                                                 "Maximum value"
    annotation (Placement(transformation(extent={{-140,16},{-100,56}}),
        iconTransformation(extent={{-128,26},{-100,54}})));

  Modelica.Blocks.Interfaces.RealInput modelResults
    annotation (Placement(transformation(extent={{-140,-84},{-100,-44}}),
        iconTransformation(extent={{-128,-72},{-100,-44}})));
  Modelica.Blocks.Interfaces.RealInput lowerLimit
                                                 "minimum value"
    annotation (Placement(transformation(extent={{-140,54},{-100,94}}),
        iconTransformation(extent={{-128,66},{-100,94}})));

  Modelica.Blocks.Interfaces.BooleanOutput satisfied annotation (Placement(transformation(
          extent={{100,-20},{140,20}}),iconTransformation(extent={{100,-14},{128,
            14}})));

initial equation
  satisfied = false;

equation
  when time >= checkTime then
      satisfied =  modelResults >= lowerLimit and modelResults <= upperLimit;
    end when;

 annotation (Icon(coordinateSystem(preserveAspectRatio=false),
   graphics={
          Text(
            extent={{-60,60},{60,-60}},
            lineColor={191,0,0},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            textString="Q",
            visible=dispType=="Q Heat"),
          Text(
            extent={{-60,60},{60,-60}},
            lineColor={28,108,200},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            textString="Q",
            visible=dispType=="Q Cool"),
          Text(
            extent={{-60,60},{60,-60}},
            lineColor={191,0,0},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            textString="T",
            visible=dispType=="T Max"),
          Text(
            extent={{-60,60},{60,-60}},
            lineColor={28,108,200},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            textString="T",
            visible=dispType=="T Min")}),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>August 17, 2020</i> by Philipp Mehrfeld:<br/>
    Refactor endTime to checkTime
  </li>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Block to test AnnualHeatingLoad and AnnualCoolingLoad according to
  reference Validation Data.
</p>
</html>"));
end CheckResultsAccordingToASHRAE;
