within AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost;
model ZhuTimeBasedDefrost
  "Time based defrost based on Zhus frosting map"
    extends
    BaseClasses.PartialDefrost;
  parameter Real minIceFac=0.5
    "Minimal allowed icing Factor to trigger the defrost";

  Modelica.Blocks.Logical.Hysteresis hys(
    uLow=minIceFac,
    uHigh=0.99,
    pre_y_start=true)
    "For the iceFac control. Output signal is used internally"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-72,80})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={20,
            -10})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,
            -10})));
  Modelica.Blocks.Sources.Constant constNoDef(final k=Modelica.Constants.inf)
    "Infinite defrost time" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,-70})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-40,
            80})));
  Modelica.Blocks.Logical.Or orDef "Either hys or critical min time"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,80})));

  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-20,
            -10})));
  Modelica.Blocks.Logical.LessEqualThreshold lesEquThr(threshold=1 - Modelica.Constants.eps)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-70,-10})));

  Modelica.Blocks.Logical.And andDefrost
                                       "Either hys or crit min time"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={40,
            60})));
  Modelica.Blocks.Logical.Not notHea "If defrost, we set hea=false"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={80,
            60})));
  Modelica.Blocks.Logical.Switch swi annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, origin={30,-50})));
  Modelica.Blocks.Sources.RealExpression critDefTim_internal(
    y=if froZon.zon == 3 then 30 * 60
    elseif froZon.zon == 2 then 60*60
    elseif froZon.zon == 1 then 165 * 60
    else Modelica.Constants.inf)
    "Mode from internal calcuations" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-14,-34})));
  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.ZhuFrostingZone froZon
    "Current zone"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));

  Modelica.Blocks.Logical.And andIsOn
    "In frosting zone and on leads to possible frosting" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={-70,30})));
  Modelica.Blocks.Math.IntegerToReal andIsOn1
    "In frosting zone and on leads to possible frosting" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-40,-74},
        rotation=270)));
  Modelica.Blocks.Logical.GreaterThreshold posFro(threshold=0.1)
    "If in any frosting zone" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-70,-90},
        rotation=180)));
equation

  connect(timer.y, greater.u1) annotation (Line(points={{31,-10},{48,-10}},
                                    color={0,0,127}));
  connect(hys.y, not1.u)
    annotation (Line(points={{-61,80},{-52,80}},
                                               color={255,0,255}));
  connect(not1.y, orDef.u1)
    annotation (Line(points={{-29,80},{-12,80}}, color={255,0,255}));
  connect(greater.y, orDef.u2) annotation (Line(points={{71,-10},{76,-10},{76,42},
          {-12,42},{-12,72}}, color={255,0,255}));
  connect(lesEquThr.y, and1.u2) annotation (Line(points={{-59,-10},{-42,-10},{-42,
          -18},{-32,-18}},     color={255,0,255}));
  connect(and1.y, timer.u) annotation (Line(points={{-9,-10},{8,-10}},
                              color={255,0,255}));
  connect(orDef.y, andDefrost.u1) annotation (Line(points={{11,80},{18,80},{18,60},
          {28,60}}, color={255,0,255}));
  connect(andDefrost.y, notHea.u) annotation (Line(points={{51,60},{68,60}},
                                               color={255,0,255}));
  connect(notHea.y, hea) annotation (Line(points={{91,60},{108,60},{108,14},{96,
          14},{96,0},{110,0}},
               color={255,0,255}));
  connect(hys.u, sigBus.iceFacHPMea) annotation (Line(points={{-84,80},{-102,80},
          {-102,0}},         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(lesEquThr.u, sigBus.iceFacHPMea) annotation (Line(points={{-82,-10},{
          -82,0},{-102,0}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swi.u2, sigBus.onOffMea) annotation (Line(points={{18,-50},{-102,-50},
          {-102,0}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swi.y, greater.u2) annotation (Line(points={{41,-50},{46,-50},{46,-26},
          {48,-26},{48,-18}}, color={0,0,127}));
  connect(constNoDef.y, swi.u3) annotation (Line(points={{1,-70},{10,-70},{10,
          -58},{18,-58}},
                     color={0,0,127}));
  connect(critDefTim_internal.y, swi.u1) annotation (Line(points={{-3,-34},{10,-34},
          {10,-42},{18,-42}}, color={0,0,127}));
  connect(froZon.TOda, sigBus.TEvaInMea) annotation (Line(points={{-82,-56},{
          -102,-56},{-102,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(froZon.relHum, sigBus.relHum) annotation (Line(points={{-82,-64},{
          -102,-64},{-102,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(andIsOn1.y, posFro.u)
    annotation (Line(points={{-40,-85},{-40,-90},{-58,-90}}, color={0,0,127}));
  connect(posFro.y, andIsOn.u2) annotation (Line(points={{-81,-90},{-94,-90},{
          -94,22},{-82,22}},
                         color={255,0,255}));
  connect(andIsOn.y, andDefrost.u2) annotation (Line(points={{-59,30},{-8,30},{-8,
          52},{28,52}}, color={255,0,255}));
  connect(andIsOn.y, and1.u1) annotation (Line(points={{-59,30},{-42,30},{-42,-8},
          {-40,-8},{-40,-10},{-32,-10}}, color={255,0,255}));
  connect(andIsOn1.u, froZon.zon) annotation (Line(points={{-40,-62},{-40,-60},{
          -58,-60}}, color={255,127,0}));
  connect(andIsOn.u1, sigBus.onOffMea) annotation (Line(points={{-82,30},{-102,
          30},{-102,0}},
                     color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (                     experiment(StopTime=2592000, Interval=500),
    Documentation(info="<html>
<p>This defrost control uses a time-based approach from Zhu et al. coupled with their three frosting zones. The three zones depend outdoor air temperature and humidity. Depending on the zone, a different time-interval for defrost is applied, taken from Table 4 in Zhu et al: 30, 60 and 165 min for severe, moderate and mild zones, respectively. Contrary to Zhu et al, moderate and mild frosting zones are not further seperated. The 60 and 135 min defrost time are the average value for those zones reported in Zhu et al. </p>
<h4>References</h4>
<p>
J.H. Zhu, Y.Y. Sun, W. Wang, S.M. Deng, Y.J. Ge, and L.T. Li. Developing a new frosting map to guide defrosting control for air-source heat pump units. Applied Thermal Engineering, November 2015
  <a href=\"https://doi.org/10.1016/j.applthermaleng.2015.06.076\">doi:10.1016/j.applthermaleng.2015.06.076</a>.
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>"),
    Icon(graphics={          Text(
          extent={{-62,52},{80,-50}},
          lineColor={0,0,0},
          textString="Zhu et al.")}));
end ZhuTimeBasedDefrost;
