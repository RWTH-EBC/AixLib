within AixLib.Building.BatteryModel;
model BatteryRack
  "Rack Model of batteries which simulates the heat loss of a rack of 
  batteries"
  inner parameter DataBase.Batteries.BatteryBaseDataDefinition batType
    "Used battery type";
   parameter Integer nParallels "Number of batteries placed in one series";
   parameter Integer nSeries "Number of battery series";
   parameter Integer nStacked "Number of batteries stacked on another";
   parameter Integer nBats=nParallels*nSeries*nStacked
     "Number of batteries in the rack";
   parameter Boolean airBetweenStacks=false
      "Is there a gap between the stacks (nStacked>1)?" annotation (Dialog(
        descriptionLabel=true), choices(
      choice=true "Yes",
      choice=false "No"));
   parameter Boolean batArrangement=true
     "How are the batteries touching each other?" annotation (Dialog(
        descriptionLabel=true), choices(
     choice=true "Longer sides touch each other in one row",
     choice=false "Shorter sides touch each other in one row"));
   parameter Modelica.SIunits.Area areaStandingAtWall = 0
     "default=0, area of the rack, which is placed at the wall,
     so there is no vertical heat convection.";

  Modelica.Blocks.Interfaces.RealInput ThermalLoss
    "Thermal loss of the battery - from external file"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow PrescribedHeatFlow
    "Converts the real heat input to heat"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor HeatCapBat(
    final C=nParallels*nSeries*nStacked*batType.cp*batType.massBat)
    "Heat capacity of the battery (C=nBats*cp_Bat*mass_Bat)"
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TemperatureSensor
    "Temperature of the battery"
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Modelica.Blocks.Interfaces.RealOutput TemperatureBat(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC") "Output of the battery's temperature"
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,100})));
  AixLib.Utilities.HeatTransfer.HeatConv_inside HeatConvFluidOnTop(
      final surfaceOrientation=2,
      final A= (if airBetweenStacks==true
                then nStacked*nParallels*nSeries*batType.width*batType.length
                else nParallels*nSeries*batType.width*batType.length))
    "Block which calculates the horizontal
    heat convection on top of the battery"
    annotation (Placement(transformation(extent={{50,-50},{30,-30}})));
  AixLib.Utilities.HeatTransfer.HeatConv_inside HeatConvVertical(
      final surfaceOrientation=1,
      final A= (if batArrangement==true
                then 2*nStacked*nParallels*batType.width*batType.height
                     + 2*nStacked*nSeries*batType.length*batType.height
                     - areaStandingAtWall
                else 2*nStacked*nParallels*batType.length*batType.height
                     + 2*nStacked*nSeries*batType.width*batType.height
                     - areaStandingAtWall))
    "Block which calculates the vertical heat convection of the battery"
    annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b PortConv
    "Port for the output of convection heat"                    annotation (
      Placement(transformation(extent={{90,-50},{110,-30}}),
                iconTransformation(extent={{90,-50},{110,-30}})));
  AixLib.Utilities.Interfaces.Star Star "Port for the output of radiation heat"
    annotation (Placement(transformation(extent={{90,10},{110,30}}),
        iconTransformation(extent={{90,10},{110,30}})));

  AixLib.Utilities.HeatTransfer.HeatConv_inside HeatConvHorizontalFacingDown(
      final surfaceOrientation=3,
      final A=(nStacked - 1)*nParallels*nSeries*batType.width*batType.length) if
         airBetweenStacks and nStacked > 1
    "Block which calculates the horizontal
    heat convection at the bottom of the battery"
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Utilities.HeatTransfer.HeatToStar HeatToStar(
      final A=batType.radiationArea,
      final eps=batType.eps) "Converts the heat to the radiation heat"
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
equation
  connect(ThermalLoss, PrescribedHeatFlow.Q_flow)
    annotation (Line(points={{-100,0},{-50,0}}, color={0,0,127}));
  connect(PrescribedHeatFlow.port, HeatCapBat.port)
    annotation (Line(points={{-30,0},{0,0},{0,70}}, color={191,0,0}));
  connect(PrescribedHeatFlow.port, TemperatureSensor.port)
    annotation (Line(points={{-30,0},{0,0},{0,40},{30,40}},
                color={191,0,0}));
  connect(TemperatureSensor.T, TemperatureBat)
    annotation (Line(points={{50,40},{60,40},{60,100}},
                color={0,0,127}));
  connect(PrescribedHeatFlow.port, HeatToStar.Therm)
    annotation (Line(points={{-30,0},{0,0},{0,20},{30.8,20}},
                color={191,0,0}));
  connect(HeatToStar.Star, Star)
    annotation (Line(points={{49.1,20},{100,20}}, color={95,95,95}));
  connect(HeatConvVertical.port_a, PortConv)
    annotation (Line(points={{50,-20}, {80,-20},{80,-40},{100,-40}},
                color={191,0,0}));
  connect(PrescribedHeatFlow.port, HeatConvVertical.port_b)
    annotation (Line(points={{-30,0},{0,0},{0,-20},{30,-20}},
                color={191,0,0}));
  connect(HeatConvFluidOnTop.port_a, PortConv)
    annotation (Line(points={{50,-40},{100,-40}}, color={191,0,0}));
  connect(PrescribedHeatFlow.port, HeatConvFluidOnTop.port_b)
    annotation (Line(points={{-30,0},{0,0},{0,-40},{30,-40}},
                color={191,0,0}));
  connect(PrescribedHeatFlow.port, HeatConvHorizontalFacingDown.port_b)
    annotation (Line(points={{-30,0},{0,0},{0,-60},{30,-60}},
                color={191,0,0}));
  connect(HeatConvHorizontalFacingDown.port_a, PortConv)
    annotation (Line(points={{50,-60},{80,-60},{80,-40},{100,-40}},
                color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-66,24},{72,-20}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The <b>BatteryRack</b> model represents the thermal behaviour of 
one specific battery rack. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>The model needs an input of heat loss of the batteries and generates 
the following outputs:</p>
<p>- battery's temperature</p>
<p>- radiation heat</p>
<p>- convection heat</p>
<p><b><font style=\"color: #008000; \">Example</font></b> </p>
<p><a href=\"AixLib.Building.BatteryModel.ExampleBatteryRoom\">
AixLib.Building.BatteryModel.ExampleBatteryRoom </a></p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>The model uses the record 
<a href=\"AixLib.DataBase.Batteries.BatteryBaseDataDefinition\">
AixLib.DataBase.Batteries.BatteryBaseDataDefinition </a>
to define the battery parameters.</p>
</html>",  revisions="<html>
<ul>
<li><i>July 26, 2017&nbsp;</i> by Paul Thiele:<br/>Implemented. </li>
</ul>
</html>"));
end BatteryRack;
