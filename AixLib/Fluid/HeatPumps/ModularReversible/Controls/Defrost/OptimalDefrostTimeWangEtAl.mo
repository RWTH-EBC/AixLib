within AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost;
model OptimalDefrostTimeWangEtAl
  "Optimal defrost point based on ice factor in Wang et al."
    extends
    BaseClasses.PartialDefrost;
  parameter Real minIceFac=0.5
    "Minimal allowed icing Factor to trigger the defrost";
  AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost.BaseClasses.HysteresisVariableLowerBound hys(uHigh=0.99,
      pre_y_start=true)
    "For the iceFac control. Output signal is used internally" annotation (
      Placement(transformation(extent={{-10,-10},{10,10}}, origin={10,10})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={10,50})));

  Modelica.Blocks.Logical.And andDefrost "Either hys or crit min time"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={50,0})));
  Modelica.Blocks.Logical.Not notHea "If defrost, we set hea=false"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={82,0})));

  AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost.BaseClasses.OptimalDefrostWangEtAl
    optDefWuEtAl "Optimal defrost time"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Logical.Switch swi annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, origin={-30,10})));
  Modelica.Blocks.Sources.Constant constMinIceFac(final k=Modelica.Constants.eps)
    "Infinite defrost time" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-10})));
  Modelica.Blocks.Logical.GreaterThreshold posFro(threshold=0.1)
    "If in any frosting zone" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={10,-70},
        rotation=0)));
  Modelica.Blocks.Math.IntegerToReal andIsOn1
    "In frosting zone and on leads to possible frosting" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-30,-70},
        rotation=0)));
  Modelica.Blocks.Logical.And andIsOn
    "In frosting zone and on leads to possible frosting" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={-50,-40},
        rotation=0)));
  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.ZhuFrostingZone froZon
    "Current zone"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
equation

  connect(hys.y, not1.u)
    annotation (Line(points={{21,10},{24,10},{24,36},{-10,36},{-10,50},{-2,50}},
                                               color={255,0,255}));
  connect(andDefrost.y, notHea.u) annotation (Line(points={{61,0},{70,0}},
                                               color={255,0,255}));
  connect(notHea.y, hea) annotation (Line(points={{93,0},{110,0}},
               color={255,0,255}));
  connect(hys.u, sigBus.iceFacHPMea) annotation (Line(points={{-2,14},{-12,14},
          {-12,54},{-102,54},{-102,0}},
                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(optDefWuEtAl.TOda, sigBus.TEvaInMea) annotation (Line(points={{-82,34},
          {-102,34},{-102,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(optDefWuEtAl.relHum, sigBus.relHum) annotation (Line(points={{-82,26},
          {-102,26},{-102,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(optDefWuEtAl.minIceFac, swi.u1) annotation (Line(points={{-58,30},{
          -50,30},{-50,18},{-42,18}}, color={0,0,127}));
  connect(constMinIceFac.y, swi.u3) annotation (Line(points={{-59,-10},{-50,-10},
          {-50,2},{-42,2}}, color={0,0,127}));
  connect(swi.y, hys.uLow) annotation (Line(points={{-19,10},{-12,10},{-12,5},{
          -2,5}}, color={0,0,127}));
  connect(not1.y, andDefrost.u1) annotation (Line(points={{21,50},{28,50},{28,0},
          {38,0}}, color={255,0,255}));
  connect(andIsOn1.y,posFro. u)
    annotation (Line(points={{-19,-70},{-2,-70}},            color={0,0,127}));
  connect(posFro.y,andIsOn. u2) annotation (Line(points={{21,-70},{26,-70},{26,-52},
          {-62,-52},{-62,-48}},
                         color={255,0,255}));
  connect(andIsOn.u1, sigBus.onOffMea) annotation (Line(points={{-62,-40},{-102,
          -40},{-102,0}},
                     color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(andIsOn.y, swi.u2) annotation (Line(points={{-39,-40},{-36,-40},{-36,-26},
          {-84,-26},{-84,10},{-42,10}}, color={255,0,255}));
  connect(andIsOn.y, andDefrost.u2) annotation (Line(points={{-39,-40},{-36,-40},
          {-36,-8},{38,-8}}, color={255,0,255}));
  connect(froZon.relHum, sigBus.relHum) annotation (Line(points={{-82,-74},{
          -102,-74},{-102,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(froZon.TOda, sigBus.TEvaInMea) annotation (Line(points={{-82,-66},{
          -102,-66},{-102,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(andIsOn1.u,froZon. zon) annotation (Line(points={{-42,-70},{-58,-70}},
                     color={255,127,0}));
  annotation (Icon(graphics={Text(
          extent={{-64,46},{78,-56}},
          lineColor={0,0,0},
          textString="Wang et al.")}),
                                   experiment(StopTime=2592000, Interval=500),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
<p>
This defrost control uses the optimal defrost icing factor by Wang et al.
Every time the current icing factor is lower than the optimal icing factor to start the defrost, defrost is performed.
</p>
<h4>References</h4>
<p>
Wang, W., Zhang, S., Li, Z., Sun, Y., Deng, S., and Wu, X. (2020). Determination of the optimal defrosting initiating time point for an ASHP unit based on the minimum loss coefficient in the nominal output heating energy. Energy, 191, 116505.
  <a href=\"https://doi.org/10.1016/j.energy.2019.116505\">https://doi.org/10.1016/j.energy.2019.116505</a>.
</p>
</html>"));
end OptimalDefrostTimeWangEtAl;
