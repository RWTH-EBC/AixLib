within AixLib.HVAC.HeatGeneration;
model IdealHeaterCooler "heater and cooler with variable setpoints"
  import AixLib;

  parameter Modelica.SIunits.Temp_K T0all=295.15
    "Initial temperature for all components";

  parameter Real h_heater=100000 "upper limit controller output of the heater"
    annotation(Dialog(tab="Heater",group = "Controller"));
  parameter Real l_heater=0 "lower limit controller output of the heater"
    annotation(Dialog(tab="Heater",group = "Controller"));
  parameter Real KR_heater=10000 "Gain of the heating controller"
    annotation(Dialog(tab="Heater",group = "Controller"));
  parameter Modelica.SIunits.Time TN_heater=1
    "Time constant of the heating controller"
    annotation(Dialog(tab="Heater",group = "Controller"));
  parameter Real h_cooler=0 "upper limit controller output of the cooler"
    annotation(Dialog(tab="Cooler",group = "Controller"));
  parameter Real l_cooler=-100000 "lower limit controller output of the cooler"
    annotation(Dialog(tab="Cooler",group = "Controller"));
  parameter Real KR_cooler=10000 "Gain of the cooling controller"
    annotation(Dialog(tab="Cooler",group = "Controller"));
  parameter Modelica.SIunits.Time TN_cooler=1
    "Time constant of the cooling controller"
    annotation(Dialog(tab="Cooler",group = "Controller"));
  parameter Boolean Heater_on=true "Activates the heater"
    annotation(Dialog(tab="Heater"));
  parameter Boolean Cooler_on=true "Activates the cooler"
    annotation(Dialog(tab="Cooler"));

  Modelica.Blocks.Interfaces.RealInput soll_cool if Cooler_on annotation (Placement(
        transformation(extent={{-120,-60},{-80,-20}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-48,-48})));
  Modelica.Blocks.Interfaces.RealInput soll_heat if Heater_on annotation (Placement(
        transformation(extent={{-120,20},{-80,60}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={30,-48})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=Heater_on) if Heater_on
    annotation (Placement(transformation(extent={{-52,14},{-33,30}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=
        Cooler_on) if Cooler_on
    annotation (Placement(transformation(extent={{-52,-30},{-32,-14}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatCoolRoom
    annotation (Placement(transformation(extent={{84,2},{104,22}})));
  Meter.TEnergyMeter                 coolMeter "measures cooling energy"
    annotation (Placement(transformation(extent={{46,-40},{66,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                Cooling if  Cooler_on
    annotation (Placement(transformation(extent={{26,-13},{46,8}})));
  AixLib.Utilities.Control.PITemp   pITemp2(
    RangeSwitch=false,
    h=h_cooler,
    l=l_cooler,
    KR=KR_cooler,
    TN=TN_cooler) if Cooler_on
    annotation (Placement(transformation(extent={{-14,0},{6,-20}})));
  Meter.TEnergyMeter                 heatMeter "measures heating energy"
    annotation (Placement(transformation(extent={{46,40},{66,60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                Heating if    Heater_on
    annotation (Placement(transformation(extent={{24,32},{44,12}})));
  AixLib.Utilities.Control.PITemp   pITemp1(
    RangeSwitch=false,
    h=h_heater,
    l=l_heater,
    KR=KR_heater,
    TN=TN_heater) if Heater_on
    annotation (Placement(transformation(extent={{-14,20},{6,40}})));
equation
  connect(booleanExpression.y, pITemp1.onOff) annotation (Line(
      points={{-32.05,22},{-24,22},{-24,25},{-13,25}},
      color={255,0,255}));
  connect(booleanExpression1.y, pITemp2.onOff) annotation (Line(
      points={{-31,-22},{-24,-22},{-24,-5},{-13,-5}},
      color={255,0,255}));
  connect(soll_heat, pITemp1.soll) annotation (Line(
      points={{-100,40},{-18,40},{-18,39},{-12,39}},
      color={0,0,127}));
  connect(soll_cool, pITemp2.soll) annotation (Line(
      points={{-100,-40},{-12,-40},{-12,-19}},
      color={0,0,127}));
  connect(pITemp2.Therm1, HeatCoolRoom) annotation (Line(
      points={{-10,-1},{-10,12},{94,12}},
      color={191,0,0}));
  connect(pITemp1.Therm1, HeatCoolRoom) annotation (Line(
      points={{-10,21},{-10,12},{94,12}},
      color={191,0,0}));
  connect(Heating.port, HeatCoolRoom) annotation (Line(
      points={{44,22},{54,22},{54,12},{94,12}},
      color={191,0,0}));
  connect(Cooling.port, HeatCoolRoom) annotation (Line(
      points={{46,-2.5},{50,-2.5},{50,-2},{54,-2},{54,12},{94,12}},
      color={191,0,0}));
  connect(pITemp2.y, Cooling.Q_flow) annotation (Line(
      points={{5,-10},{14,-10},{14,-2.5},{26,-2.5}},
      color={0,0,127}));
  connect(pITemp2.y, coolMeter.p) annotation (Line(
      points={{5,-10},{14,-10},{14,-30},{47.4,-30}},
      color={0,0,127}));
  connect(pITemp1.y, Heating.Q_flow) annotation (Line(
      points={{5,30},{12,30},{12,22},{24,22}},
      color={0,0,127}));
  connect(pITemp1.y, heatMeter.p) annotation (Line(
      points={{5,30},{12,30},{12,50},{47.4,50}},
      color={0,0,127}));
  annotation ( Icon(graphics={
        Rectangle(
          extent={{-90,22},{84,-12}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-78,22},{-78,56},{-44,22},{-78,22}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,22},{-4,22},{-4,56},{-42,22}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{34,22},{-4,22},{-4,56},{34,22}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{68,22},{68,56},{34,22},{68,22}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{68,-2},{-76,12}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="T_set_room<->T_air_room"),
        Line(
          points={{-58,40},{-58,66}},
          color={0,128,255},
          thickness=1),
        Line(
          points={{-42,26},{-42,66}},
          color={0,128,255},
          thickness=1),
        Line(
          points={{-26,40},{-26,66}},
          color={0,128,255},
          thickness=1),
        Line(
          points={{-62,64},{-58,70},{-54,64}},
          color={0,128,255},
          thickness=1),
        Line(
          points={{-46,64},{-42,70},{-38,64}},
          color={0,128,255},
          thickness=1),
        Line(
          points={{-30,64},{-26,70},{-22,64}},
          color={0,128,255},
          thickness=1),
        Line(
          points={{20,40},{20,66}},
          color={255,0,0},
          thickness=1),
        Line(
          points={{16,64},{20,70},{24,64}},
          color={255,0,0},
          thickness=1),
        Line(
          points={{48,40},{48,66}},
          color={255,0,0},
          thickness=1),
        Line(
          points={{44,64},{48,70},{52,64}},
          color={255,0,0},
          thickness=1),
        Line(
          points={{34,26},{34,66}},
          color={255,0,0},
          thickness=1),
        Line(
          points={{30,64},{34,70},{38,64}},
          color={255,0,0},
          thickness=1)}));
end IdealHeaterCooler;
