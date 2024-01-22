within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
model ModularControl



  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=5 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="Advanced",group="General machine information"));

   parameter Modelica.Units.SI.Temperature THotNom=313.15 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="Advanced",group="General machine information"));


 parameter Boolean Modulating=true "Is the heat pump inverter-driven?";


  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=DeltaTCon,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-130,-14},{-110,6}})));
  AixLib.Controls.Continuous.LimPID ControlT_Flow(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=100,
    yMax=100,
    Td=1,
    yMin=25,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=313,
    y_start=100)
               "Control flow Temperature"
    annotation (Placement(transformation(extent={{-184,88},{-164,108}})));
  Modelica.Blocks.Sources.RealExpression DeltaT_HeatPumpCondenser(y=DeltaTCon)
    annotation (Placement(transformation(
        extent={{-27,-13},{27,13}},
        rotation=0,
        origin={-313,85})));
  Modelica.Blocks.Math.Add TFlowSet "Setpoint Flow Tempeature"
    annotation (Placement(transformation(extent={{-228,88},{-208,108}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-220,-30},{-200,-10}})));
  Modelica.Blocks.Sources.RealExpression two(y=2) annotation (Placement(
        transformation(
        extent={{-9,-12},{9,12}},
        rotation=0,
        origin={-243,-26})));
  Modelica.Blocks.Math.Add TFlowSet1(k2=-1)
                                    "Setpoint Flow Tempeature"
    annotation (Placement(transformation(extent={{-220,-2},{-200,18}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-32,-14},{-12,6}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-98,-36})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus annotation (
      Placement(transformation(extent={{86,2},{116,36}}),
        iconTransformation(extent={{-108,-52},{-90,-26}})));
  Modelica.Blocks.Interfaces.RealInput
                              u2 "Führungsgröße"
    annotation (Placement(transformation(extent={{-360,-60},{-320,-20}})));
  Modelica.Blocks.Math.Add TFlowSet2
                                    "Setpoint Flow Tempeature"
    annotation (Placement(transformation(extent={{-180,-8},{-160,12}})));
equation

  connect(DeltaT_HeatPumpCondenser.y, TFlowSet.u1) annotation (Line(points={{
          -283.3,85},{-262,85},{-262,104},{-230,104}}, color={0,0,127}));
  connect(sigBus.TConOutMea, ControlT_Flow.u_m) annotation (Line(
      points={{101.075,19.085},{-174,19.085},{-174,86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(TFlowSet.y, ControlT_Flow.u_s)
    annotation (Line(points={{-207,98},{-186,98}}, color={0,0,127}));
  connect(zero.y, switch1.u3) annotation (Line(points={{-84.8,-36},{-42,-36},{
          -42,-12},{-34,-12}},                     color={0,0,127}));
  connect(onOffController.y, switch1.u2)
    annotation (Line(points={{-109,-4},{-34,-4}}, color={255,0,255}));
  connect(two.y, division.u2)
    annotation (Line(points={{-233.1,-26},{-222,-26}}, color={0,0,127}));
  connect(DeltaT_HeatPumpCondenser.y, division.u1) annotation (Line(points={{
          -283.3,85},{-278,85},{-278,-14},{-222,-14}}, color={0,0,127}));
  connect(u2, onOffController.u) annotation (Line(points={{-340,-40},{-146,-40},
          {-146,-10},{-132,-10}}, color={0,0,127}));
  connect(sigBus.THotSet, TFlowSet1.u1) annotation (Line(
      points={{101.075,19.085},{-258,19.085},{-258,14},{-222,14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConInMea, TFlowSet.u2) annotation (Line(
      points={{101.075,19.085},{-252,19.085},{-252,92},{-230,92}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ControlT_Flow.y, switch1.u1) annotation (Line(points={{-163,98},{-82,
          98},{-82,4},{-34,4}},              color={0,0,127}));
  connect(switch1.y, sigBus.frequency) annotation (Line(points={{-11,-4},{80,-4},
          {80,19.085},{101.075,19.085}},
                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TFlowSet1.y, TFlowSet2.u1)
    annotation (Line(points={{-199,8},{-182,8}}, color={0,0,127}));
  connect(DeltaT_HeatPumpCondenser.y, TFlowSet1.u2) annotation (Line(points={{
          -283.3,85},{-264,85},{-264,2},{-222,2}}, color={0,0,127}));
  connect(division.y, TFlowSet2.u2) annotation (Line(points={{-199,-20},{-190,
          -20},{-190,-4},{-182,-4}}, color={0,0,127}));
  connect(TFlowSet2.y, onOffController.reference)
    annotation (Line(points={{-159,2},{-132,2}}, color={0,0,127}));
  connect(onOffController.y, sigBus.OnOff) annotation (Line(points={{-109,-4},{
          -86,-4},{-86,19.085},{101.075,19.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-320,
            -100},{100,160}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-320,-100},{100,160}})));
end ModularControl;
