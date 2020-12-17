within AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl;
model EonERCSimpleControl "Control for HP system, and GTF"
  parameter Real rpmC=1750 "RPM for pump on cold side";
  parameter Real rpmH=2820 "RPM for pump hot side";
  Modelica.Blocks.Sources.Constant rpmPumpCold(k=rpmC)
    annotation (Placement(transformation(extent={{78,-22},{86,-14}})));
  Modelica.Blocks.Sources.Constant rpmPumpHot(k=rpmH)
    annotation (Placement(transformation(extent={{78,-36},{86,-28}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{78,-8},{86,0}})));
  Modelica.Blocks.Sources.Constant ice(k=1)
    annotation (Placement(transformation(extent={{78,-50},{86,-42}})));
  BaseClasses.MainBus bus annotation (Placement(transformation(extent={{86,-14},
            {114,12}}),         iconTransformation(extent={{88,-20},{128,22}})));
  CtrHP ctrHP(
    T_con_set=273.15 + 34,
    N_rel_max=0.8,         N_rel_min=0)
              annotation (Placement(transformation(extent={{-80,46},{-40,86}})));
  CtrSWU            ctrSWU
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={10,-70})));
  CtrGTFSimple            ctrGTFSimple
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Modelica.Blocks.Math.BooleanToReal flapRecooler
    annotation (Placement(transformation(extent={{46,40},{62,56}})));
  Modelica.Blocks.Math.BooleanToReal flapFreeCooler
    annotation (Placement(transformation(extent={{46,20},{62,36}})));
  Modelica.Blocks.Math.BooleanToReal flapHP
    annotation (Placement(transformation(extent={{46,60},{62,76}})));
  Modelica.Blocks.Logical.Or gcOn annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={53,5})));
  CtrHXsimple ctrHXsimple(
    rpmPumpPrim=130,
    TflowSet=298.15,
    Ti(displayUnit="s") = 60)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  CtrHighTemperatureSystem ctrHighTemperatureSystem
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-62,16},{-54,24}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k=false)
    annotation (Placement(transformation(extent={{2,70},{10,78}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=2)
    annotation (Placement(transformation(extent={{-78,-70},{-58,-50}})));
equation
  connect(rpmPumpCold.y, bus.hpSystemBus.busPumpCold.pumpBus.rpmSet) annotation (Line(
        points={{86.4,-18},{100.07,-18},{100.07,-0.935}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumpHot.y, bus.hpSystemBus.busPumpHot.pumpBus.rpmSet) annotation (Line(
        points={{86.4,-32},{100.07,-32},{100.07,-0.935}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, bus.hpSystemBus.busHP.mode) annotation (Line(points={{86.4,-4},
          {100.35,-4},{100.35,-0.935},{100.07,-0.935}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ice.y, bus.hpSystemBus.busHP.iceFac) annotation (Line(points={{86.4,
          -46},{100,-46},{100,-0.935},{100.07,-0.935}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.N_rel, bus.hpSystemBus.busHP.N) annotation (Line(points={{-38,66},
          {100.07,66},{100.07,-0.935}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.T_HS, bus.hpSystemBus.TTopHSMea) annotation (Line(points={{-83.6,
          86},{-98,86},{-98,104},{100,104},{100,52},{100.07,52},{100.07,-0.935}},
                                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_CS, bus.hpSystemBus.TBottomCSMea) annotation (Line(points={{-83.4,
          55.8},{-92,55.8},{-92,70},{-100,70},{-100,106},{100,106},{100,-0.935},
          {100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_ev, bus.hpSystemBus.busHP.T_ret_ev) annotation (Line(points={{-83.6,
          46},{-98,46},{-98,108},{100.07,108},{100.07,-0.935}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.pumpsOn, bus.hpSystemBus.busPumpHot.pumpBus.onSet) annotation (Line(
        points={{-38,82},{100.07,82},{100.07,-0.935}},  color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.pumpsOn, bus.hpSystemBus.busPumpCold.pumpBus.onSet) annotation (Line(
        points={{-38,82},{100.07,82},{100.07,-0.935}},  color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapFreeCooler.y, bus.hpSystemBus.busThrottleFreecool.valveSet)
    annotation (Line(points={{62.8,28},{100,28},{100,24},{100.07,24},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapRecooler.y, bus.hpSystemBus.busThrottleRecool.valveSet)
    annotation (Line(points={{62.8,48},{100,48},{100,-0.935},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapHP.y, bus.hpSystemBus.busThrottleHS.valveSet) annotation (Line(
        points={{62.8,68},{100.07,68},{100.07,-0.935}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapHP.y, bus.hpSystemBus.busThrottleCS.valveSet) annotation (Line(
        points={{62.8,68},{100,68},{100,74},{100.07,74},{100.07,-0.935}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gcOn.u1, flapRecooler.u) annotation (Line(points={{44.6,5},{36,5},{36,
          6},{26,6},{26,48},{44.4,48}}, color={255,0,255}));
  connect(gcOn.y, bus.hpSystemBus.AirCoolerOnSet) annotation (Line(points={{
          60.7,5},{100.07,5},{100.07,-0.935}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrSWU.sWUBus, bus.swuBus) annotation (Line(
      points={{20,-70},{62,-70},{62,-68},{100.07,-68},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrGTFSimple.gtfBus, bus.gtfBus) annotation (Line(
      points={{21.3,-90},{60,-90},{60,-92},{100.07,-92},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHXsimple.hxBus, bus.hxBus) annotation (Line(
      points={{21.1,-49.9},{100.07,-49.9},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHighTemperatureSystem.highTemperatureSystemBus, bus.htsBus)
    annotation (Line(
      points={{20,-29.9},{62,-29.9},{62,-18},{100.07,-18},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant1.y, ctrHP.allowOperation) annotation (Line(points={{
          -53.6,20},{-42,20},{-42,22},{-26,22},{-26,90},{-60,90}}, color={255,0,
          255}));
  connect(booleanConstant2.y, flapRecooler.u) annotation (Line(points={{10.4,74},
          {20,74},{20,48},{44.4,48}}, color={255,0,255}));
  connect(booleanConstant1.y, flapHP.u) annotation (Line(points={{-53.6,20},{
          -34,20},{-34,16},{-6,16},{-6,68},{44.4,68}}, color={255,0,255}));
  connect(booleanConstant2.y, flapFreeCooler.u) annotation (Line(points={{10.4,
          74},{22,74},{22,28},{44.4,28}}, color={255,0,255}));
  connect(booleanConstant1.y, ctrGTFSimple.on) annotation (Line(points={{-53.6,
          20},{-32,20},{-32,-90},{-2,-90}}, color={255,0,255}));
  connect(integerExpression.y, ctrSWU.mode) annotation (Line(points={{-57,-60},
          {-36,-60},{-36,-58},{-10,-58},{-10,-70},{0,-70}}, color={255,127,0}));
  connect(gcOn.u2, flapFreeCooler.u) annotation (Line(points={{44.6,-0.6},{12,
          -0.6},{12,28},{44.4,28}}, color={255,0,255}));
  connect(booleanConstant1.y, ctrHP.heatingModeActive) annotation (Line(points=
          {{-53.6,20},{-52,20},{-52,32},{-108,32},{-108,66},{-83.6,66}}, color=
          {255,0,255}));
  connect(ctrHP.T_con, bus.hpSystemBus.busHP.T_ret_co) annotation (Line(points=
          {{-83.6,76},{-106,76},{-106,100},{100.07,100},{100.07,-0.935}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Line(
          points={{20,80},{80,0},{40,-80}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-80,20},{66,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control"),
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,100},{-38,0},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,24},{98,-16}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end EonERCSimpleControl;
