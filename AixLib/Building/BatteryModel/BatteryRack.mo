within AixLib.Building.BatteryModel;
model BatteryRack
  "Rack Model of batteries which simulates the heat loss of a rack of  batteries"
  inner parameter
    DataBase.Batteries.BatteryTypes.BatteryBaseDataDefinition
    BatType "Used Battery Type";
   parameter Integer nParallels "Number of batteries placed in one Series";
   parameter Integer nSeries "Number of battery series";
   parameter Integer nStacked "Number of batteries stacked on another";
   parameter Integer nBats=nParallels*nSeries*nStacked "Number of batteries in the rack";
   parameter Boolean AirBetweenStacks=false "Is there a gap between the stacks (nStacked>1)?" annotation (Dialog(
        descriptionLabel=true), choices(
      choice=true "Yes",
      choice=false "No"));
   parameter Boolean BatArrangement=true "How are the batteries touching each other?" annotation (Dialog(
        descriptionLabel=true), choices(
      choice=true "Longer sides touch each other in one row",
      choice=false "Shorter sides touch each other in one row"));
   parameter Modelica.SIunits.Area AreaStandingAtWall = 0 "default=0, area of the rack, which is placed at the wall, so there is no vertical heat convection.";

  Modelica.Blocks.Interfaces.RealInput Battery_Loss
    "Electrical Loss of the Battery - from external file"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor HeatCapBat(C=
        nParallels*nSeries*nStacked*BatType.cp*BatType.massBat)
                                    "Heat capacity of the battery"
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Modelica.Blocks.Interfaces.RealOutput battery_temperature(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC")
    "Temperature of the battery" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,100})));
  AixLib.Utilities.HeatTransfer.HeatConv_inside heatConv_fluidOnTop(
      surfaceOrientation=2, A= (if AirBetweenStacks==true then nStacked*nParallels*nSeries*BatType.width*BatType.length
                                                          else nParallels*nSeries*BatType.width*BatType.length))
    "Convection model with fluid on top nParallels*nSeries*width*depth"
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  AixLib.Utilities.HeatTransfer.HeatConv_inside heatConv_Vertical(
      surfaceOrientation=1, A= (if BatArrangement==true then 2*nStacked*nParallels*BatType.width*BatType.height + 2*nStacked*nSeries*BatType.length*BatType.height - AreaStandingAtWall
                                                        else 2*nStacked*nParallels*BatType.length*BatType.height + 2*nStacked*nSeries*BatType.width*BatType.height - AreaStandingAtWall))
    "Convection model with fluid on top nParallels*nSeries*width*depth"
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_conv annotation (
      Placement(transformation(extent={{90,-50},{110,-30}}), iconTransformation(
          extent={{90,-50},{110,-30}})));
  AixLib.Utilities.Interfaces.Star star
    annotation (Placement(transformation(extent={{90,10},{110,30}}),
        iconTransformation(extent={{90,10},{110,30}})));

  AixLib.Utilities.HeatTransfer.HeatConv_inside heatConv_horizontalFacingDown(
      surfaceOrientation=3, A=(nStacked - 1)*nParallels*nSeries*BatType.width*
        BatType.length) if     AirBetweenStacks and nStacked > 1
    "Convection model with fluid on top nParallels*nSeries*width*depth"
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
equation
  connect(Battery_Loss, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-100,0},{-50,0}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, HeatCapBat.port)
    annotation (Line(points={{-30,0},{0,0},{0,70}}, color={191,0,0}));
  connect(prescribedHeatFlow.port, temperatureSensor.port)
    annotation (Line(points={{-30,0},{0,0},{0,40},{30,40}}, color={191,0,0}));
  connect(temperatureSensor.T, battery_temperature)
    annotation (Line(points={{50,40},{60,40},{60,100}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, star)
    annotation (Line(points={{-30,0},{0,0},{0,20},{100,20}},color={191,0,0}));
  connect(prescribedHeatFlow.port, heatConv_Vertical.port_a) annotation (Line(
        points={{-30,0},{0,0},{0,-20},{30,-20}}, color={191,0,0}));
  connect(prescribedHeatFlow.port, heatConv_fluidOnTop.port_a) annotation (Line(
        points={{-30,0},{0,0},{0,-40},{30,-40}}, color={191,0,0}));
  connect(heatConv_Vertical.port_b, port_conv) annotation (Line(points={{50,-20},
          {80,-20},{80,-40},{100,-40}},color={191,0,0}));
  connect(heatConv_fluidOnTop.port_b, port_conv) annotation (Line(points={{50,-40},
          {100,-40}},                  color={191,0,0}));
  connect(prescribedHeatFlow.port, heatConv_horizontalFacingDown.port_a)
    annotation (Line(points={{-30,0},{0,0},{0,-60},{30,-60}}, color={191,0,0}));
  connect(heatConv_horizontalFacingDown.port_b, port_conv) annotation (Line(
        points={{50,-60},{80,-60},{80,-40},{100,-40}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-66,24},{72,-20}},
          lineColor={28,108,200},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end BatteryRack;
