within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.BaseClasses;
partial model PartialModularAHU "Partial model for modular ahu"

  parameter Boolean humidifying = false
    "set to true if humidifying is implemented";
  parameter Boolean cooling=false
    "set to true if cooling is implemented";
  parameter Boolean dehumidifying = false
    "set to true if dehumidification by sub-cooling is implemented"
    annotation(Dialog(enable=cooling and heating));
  parameter Boolean heating=false
    "set to true if heating is used";
  parameter Boolean heatRecovery=false
    "set to true if heat recovery system is implemented";
  parameter Boolean usePhiSet = false
    "set to true if relative humidity is controlled, else absolute humidity is controlled";
  parameter Boolean limPhiOda = false
    "set to true if outdoor air humidity is limited to saturation";

  // Nominal values
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(start=3000/3600*1.2)
    "nominal mass flow rate in air handling unit"
    annotation(Dialog(group="Nominal values"));
  parameter Modelica.Units.SI.PressureDifference dpHrs_nominal(start=120)
    "nominal pressure drop of heat recovery system"
    annotation(Dialog(group="Nominal values", enable=heatRecovery));
  parameter Modelica.Units.SI.PressureDifference dpCoo_nominal(start=80)
    "nominal pressure drop of cooler"
    annotation(Dialog(group="Nominal values", enable=cooling or dehumidifying));
  parameter Modelica.Units.SI.PressureDifference dpHea_nominal(start=40)
    "nominal pressure drop of heater"
    annotation(Dialog(group="Nominal values", enable=heating or dehumidifying));
  parameter Modelica.Units.SI.PressureDifference dpHum_nominal(start=20)
    "nominal pressure drop of humidifier"
    annotation(Dialog(group="Nominal values", enable=humidifying));
  parameter Modelica.Units.SI.PressureDifference dpFanOda_nominal(start=800)
    "nominal pressure increase of outdoor air fan"
    annotation(Dialog(group="Nominal values"));
  parameter Modelica.Units.SI.PressureDifference dpFanEta_nominal(start=800)
    "nominal pressure increase of extract air fan"
    annotation(Dialog(group="Nominal values"));

  // Heat recovery system parameter
  parameter Real effHrsOn(
    min=0,
    max=1) = 0.8
    "efficiency of HRS in the AHU modes when HRS is enabled"
    annotation (Dialog(group="Settings AHU Value", enable=heatRecovery));
  parameter Real effHrsOff(
    min=0,
    max=1) = 0.2
    "taking a little heat transfer into account although HRS is disabled 
    (in case that a HRS is physically installed in the AHU)"
    annotation (Dialog(group="Settings AHU Value", enable=heatReecovery));

  // fan parameter
  parameter Modelica.Units.SI.Pressure dpFanOda=800
    "pressure difference over supply fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  parameter Modelica.Units.SI.Pressure dpFanEta=800
    "pressure difference over extract fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  // assumed efficiencies of the ventilators
  parameter Modelica.Units.SI.Efficiency etaFanOda=0.7
    "efficiency of outdoor air fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  parameter Modelica.Units.SI.Efficiency etaFanEta=0.7
    "efficiency of extract air fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));

  // Humidifier parameter
  parameter Modelica.Units.SI.Temperature TWat=293.15
    "water temperature"
    annotation(Dialog(tab="Advanced", group="Humidifying",enable=humidifying));
  parameter Modelica.Units.SI.Temperature TSteam=363.15
    "steam temperature in steam humidifier"
    annotation(Dialog(tab="Advanced", group="Humidifying",enable=humidifying));
  parameter Real k=500
    "exponent for humidification degree in spray humidifier"
    annotation(Dialog(tab="Advanced", group="Humidifying",enable=humidifying));

  // Interfaces
  Modelica.Blocks.Interfaces.RealInput VOda_flow(unit="m3/s")
    "volume flow of outdoor air in m3/s"
    annotation (Placement(transformation(extent={{-174,66},{-146,94}}),
        iconTransformation(extent={{-168,56},{-160,64}})));
  Modelica.Blocks.Interfaces.RealInput TOda(unit="K", start=288.15)
    "Temperature of outdoor air in K"
    annotation (Placement(transformation(extent={{-174,26},{-146,54}}),
        iconTransformation(extent={{-168,36},{-160,44}})));
  Modelica.Blocks.Interfaces.RealInput phiOda(
    min=0,
    max=1,
    start=0.5)
    "relative humidity of outdoor air 0...1]"
    annotation (Placement(
        transformation(extent={{-174,-14},{-146,14}}), iconTransformation(
          extent={{-168,16},{-160,24}})));
  Modelica.Blocks.Interfaces.RealInput VEta_flow(unit="m3/s")
    "volume flow of extract air in m3/s"
    annotation (Placement(transformation(extent={{174,66},{146,94}}),
        iconTransformation(extent={{168,56},{160,64}})));
  Modelica.Blocks.Interfaces.RealInput TEta(unit="K", start=288.15)
    "Temperature of extract air in K"
    annotation (Placement(transformation(extent={{174,26},{146,54}}),
        iconTransformation(extent={{168,36},{160,44}})));
  Modelica.Blocks.Interfaces.RealInput phiEta(start=0.5)
    "relative humidity of extract air [0...1]"
    annotation (Placement(transformation(extent={{174,
            -14},{146,14}}), iconTransformation(extent={{168,16},{160,24}})));


  // Set values
  Modelica.Blocks.Interfaces.RealInput TSupSet(unit="K", start=295.15)
    "Set value for supply air temperature in K"
                        annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={100,-100}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={140,-104})));
  Modelica.Blocks.Interfaces.RealInput phiSupSet[2](start={0.4,0.6})
    "set value for supply air relative humidity [Range: 0...1] (Vector: [1] min, [2] max)"
                                                                 annotation (
      Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={72,-100}), iconTransformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={120,-104})));

  // Outputs
  Modelica.Blocks.Interfaces.RealOutput phiSup(start=0.8)
    "supply air relative humidity"    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={160,-60}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={164,-40})));
  Modelica.Blocks.Interfaces.RealOutput TSup(unit="K", start=295.15)
    "supply air temperature in K"
                         annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={159,-27}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={164,-20})));

  Modelica.Blocks.Interfaces.RealOutput QCoo_flow(
    unit="W",
    min=0,
    start=0.01)
    "The absorbed cooling power supplied from a cooling circuit [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-150,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-51,-105})));
  Modelica.Blocks.Interfaces.RealOutput QHea_flow(
    unit="W",
    min=0,
    start=0.01)
    "The absorbed heating power supplied from a heating circuit [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-120,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-11,-105})));
  Modelica.Blocks.Interfaces.RealOutput Pel(
    unit="W",
    min=0,
    start=1e-3)
    "The consumed electrical power supplied from the mains [W]" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-100}),
                          iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={9,-105})));
  Modelica.Blocks.Interfaces.RealOutput QHum_flow(
    unit="W",
    min=0,
    start=0.01) "The humidification power supplied from a humidifier [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-31,-105})));

  // Components

  replaceable model humidifier = Components.SprayHumidifier
    constrainedby Components.BaseClasses.PartialHumidifier
    "replaceable model for humidifier"  annotation(choicesAllMatching=true);

     annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-160,100},{160,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-160,0},{160,0}}, color={0,0,0}),
        Rectangle(
          extent={{-136,100},{-70,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-136,-96},{-74,100}}, color={0,0,0}),
        Line(points={{-132,-100},{-70,96}}, color={0,0,0}),
        Rectangle(
          extent={{-110,6},{-98,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-8,-28},{36,-72}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-34},{34,-42}}, color={0,0,0}),
        Line(points={{34,-58},{0,-66}}, color={0,0,0}),
        Ellipse(
          extent={{48,68},{4,24}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{6,38},{40,30}}, color={0,0,0}),
        Line(points={{40,62},{6,54}}, color={0,0,0}),
        Rectangle(
          extent={{-58,0},{-18,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-58,0},{-18,-100}}, color={0,0,0}),
        Line(points={{-58,-100},{-18,0}}, color={0,0,0}),
        Rectangle(
          extent={{50,0},{94,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{112,0},{140,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{112,0},{140,-100}}, color={0,0,0}),
        Line(points={{72,-100},{72,-24}}, color={0,0,0}),
        Line(points={{80,-20},{72,-24},{80,-28}}, color={0,0,0}),
        Line(points={{64,-20},{72,-24},{64,-28}}, color={0,0,0}),
        Line(points={{80,-40},{72,-44},{80,-48}}, color={0,0,0}),
        Line(points={{64,-40},{72,-44},{64,-48}}, color={0,0,0})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialModularAHU;
