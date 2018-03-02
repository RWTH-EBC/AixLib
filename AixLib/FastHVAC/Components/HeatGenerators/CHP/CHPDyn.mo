within AixLib.FastHVAC.Components.HeatGenerators.CHP;
model CHPDyn
  "CHP with internal combustion engine including part load operation. To be used with dynamic mode controller (start/stop/OnOff/P_elRel)"

  /* *******************************************************************
  BHKW Parameters
  ******************************************************************* */
  parameter Boolean selectable=true "CHP record";

  parameter AixLib.FastHVAC.Data.CHP.BaseDataDefinition param=
  AixLib.FastHVAC.Data.CHP.AisinSeiki() "Paramter contains data from CHP records"
  annotation (choicesAllMatching=true, group="Unit properties");

  parameter Modelica.SIunits.Efficiency eta_el = 0.25 "CHP's electrical efficiency "
  annotation (Dialog(group = "Unit properties",enable=not selectable));
  parameter Modelica.SIunits.Efficiency omega = 0.65 "CHP's total efficiency "
  annotation (Dialog(group = "Unit properties",enable=not selectable));

  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium=
  AixLib.FastHVAC.Media.WaterSimple()
  "Standard flow charastics for water (heat capacity, density, thermal conductivity)"    annotation (choicesAllMatching);

  constant Real LHV(unit="J/kg")=47300000 "Lower heating value [J/kg]";

protected
  parameter Modelica.SIunits.Power dotE_start = 0.4 * param.dotE_fuelRated;
  parameter Modelica.SIunits.Power dotQ_stop = 0.5 * param.dotQ_thRated;
  parameter Modelica.SIunits.Power dotE_stop = 1/3 * param.dotE_fuelRated;
  parameter Modelica.SIunits.Volume V_water = 3e-3;
  parameter Modelica.SIunits.Time t_stopTh = 90;

public
  parameter Modelica.SIunits.Power P_standby = 90 "electrical consumption in standby mode";
  parameter Modelica.SIunits.Power P_stop = 190 "electrical consumption during shutdown mode";
  parameter Modelica.SIunits.Power P_start = 190 "electrical consumption during startup";
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20);

  /* *******************************************************************
  Variables
  ******************************************************************* */

  //Modelica.SIunits.HeatFlowRate Q_th "Thermal power";
  Modelica.SIunits.HeatFlowRate dotE_fuel "Fuel energy consumption ";
  Modelica.SIunits.Efficiency eff_el "CHP's electrical efficiency ";
  Modelica.SIunits.Efficiency eff_th "CHP's thermal efficiency ";
  Modelica.SIunits.Power P_el "Capacity ";
  Real sigma(start=0.4) "Nominal power to heat ratio";

  /* *******************************************************************
  Components
  ******************************************************************* */

  Modelica.Blocks.Interfaces.RealInput P_elRel "[0 to 1]" annotation (
      Placement(transformation(extent={{-118,68},{-90,96}}),
        iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={60,100})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
    annotation (Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=270,
        origin={2,100}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput Capacity[3]
    "1=P_el 2=dotQ_th 3=dotE_fuel"
    annotation (Placement(transformation(extent={{94,80},{118,104}}),
        iconTransformation(extent={{94,80},{118,104}})));

  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_start(T=param.tauQ_th/2.5)
    annotation (Placement(transformation(extent={{-70,64},{-50,84}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow varHeatFlow
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={2,-50})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor T_flow
    annotation (Placement(transformation(extent={{-48,-84},{-28,-64}})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor T_return
    annotation (Placement(transformation(extent={{36,-84},{56,-64}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1
                                                    "Output connector"
    annotation (Placement(transformation(extent={{90,-12},{110,8}}),
        iconTransformation(extent={{90,-12},{110,8}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
                                                    "Input connector"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate
    annotation (Placement(transformation(extent={{-84,-84},{-64,-64}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_stop(T=t_stopTh/2.5)
    annotation (Placement(transformation(extent={{-70,34},{-50,54}})));
  Modelica.Blocks.Interfaces.RealOutput Energy[3](unit="J") "1=W_el 2=Q_th 3=E_fuel"
    annotation (Placement(transformation(extent={{94,20},{118,44}}),
        iconTransformation(extent={{94,20},{118,44}})));
  Modelica.Blocks.Continuous.Integrator integrator[3]
    annotation (Placement(transformation(extent={{64,20},{84,40}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(
    medium=medium,
    T0=T0,
    m_fluid=V_water*medium.rho)
    annotation (Placement(transformation(extent={{-8,-84},{12,-64}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={2,48})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter dotP(Rising=760, Falling=-760)
    annotation (Placement(transformation(extent={{18,-32},{38,-12}})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter dotm(Rising=5.4e-5, Falling=-5.4e-5)
    annotation (Placement(transformation(extent={{18,-6},{38,14}})));
  Modelica.Blocks.Math.Gain Gain_LHV(k=LHV)
    annotation (Placement(transformation(extent={{50,64},{66,80}})));
  Modelica.Blocks.Interfaces.BooleanInput Start
    annotation (Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-20,100}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-80,100})));
  Modelica.Blocks.Interfaces.BooleanInput Stop
    annotation (Placement(transformation(extent={{-118,14},{-90,42}}),
        iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-40,100})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderP(T=5)
    annotation (Placement(transformation(extent={{-62,4},{-42,24}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderE(T=5)
    annotation (Placement(transformation(extent={{-66,-34},{-46,-14}})));

equation
  P_el = P_elRel*param.P_elRated;
  dotE_fuel = firstOrderE.y;
  dotP.u = firstOrderP.y;
  dotm.u = dotE_fuel /LHV;
  sigma = eff_el/eff_th;

  if selectable then
      eff_el = param.a_0 + param.a_1*(P_el/1000)^2 + param.a_2*(P_el/1000) + param.a_3*massFlowRate.dotm^2 + param.a_4*massFlowRate.dotm + param.a_5* Modelica.SIunits.Conversions.to_degC(T_return.T)^2 + param.a_6*Modelica.SIunits.Conversions.to_degC(T_return.T);
      eff_th = param.b_0 + param.b_1*(P_el/1000)^2 + param.b_2*(P_el/1000) + param.b_3*massFlowRate.dotm^2 + param.b_4*massFlowRate.dotm + param.b_5* Modelica.SIunits.Conversions.to_degC(T_return.T)^2 + param.b_6*Modelica.SIunits.Conversions.to_degC(T_return.T);
  else
    if P_elRel > 0.1 then
      eff_el =eta_el*(0.261 + 0.161*Modelica.Math.log(P_elRel*100));
    else
      eff_el = eta_el * 0.261;
    end if;
    eff_th = omega - eff_el;
  end if;

      if OnOff then
      if Start then                                           //Startvorgang
        firstOrderQ_start.u = 0;
        firstOrderQ_stop.u = 0;
        firstOrderP.u = -P_start;
        firstOrderE.u = dotE_start;
      else                                                            //Normalbetrieb
        firstOrderQ_start.u = P_el/sigma;
        firstOrderQ_stop.u = firstOrderQ_start.y;
        firstOrderP.u = P_el;
        firstOrderE.u = P_el/eff_el;
      end if;
    else
      if Stop then                                            //Stoppvorgang
        firstOrderQ_start.u = 0;
        firstOrderQ_stop.u = dotQ_stop;
        firstOrderP.u = -P_stop;
        firstOrderE.u = dotE_stop;
      else                                                    //Standby
        firstOrderQ_start.u = 0;
        firstOrderQ_stop.u = 0;
        firstOrderP.u = -P_standby;
        firstOrderE.u = 0;
      end if;
    end if;

  connect(varHeatFlow.port, workingFluid.heatPort)
    annotation (Line(points={{2,-60},{2,-60},{2,-64.6}},  color={191,0,0}));
  connect(switch1.y, varHeatFlow.Q_flow)
    annotation (Line(points={{2,37},{2,-40}},  color={0,0,127}));
  connect(firstOrderQ_start.y, switch1.u1) annotation (Line(points={{-49,74},{10,
          74},{10,60}},                 color={0,0,127}));
  connect(firstOrderQ_stop.y, switch1.u3)
    annotation (Line(points={{-49,44},{-6,44},{-6,60}}, color={0,0,127}));
  connect(dotm.y, Gain_LHV.u)
    annotation (Line(points={{39,4},{44,4},{44,72},{48.4,72}},
                                                           color={0,0,127}));
  connect(switch1.y, integrator[2].u) annotation (Line(points={{2,37},{2,-34},{48,
          -34},{48,30},{62,30}},              color={0,0,127}));
  connect(OnOff, switch1.u2)
    annotation (Line(points={{2,100},{2,60}},        color={255,0,255}));
  connect(enthalpyPort_a1, massFlowRate.enthalpyPort_a) annotation (Line(points={{-100,0},
          {-94,0},{-94,-74.1},{-82.8,-74.1}},              color={176,0,0}));
  connect(massFlowRate.enthalpyPort_b, T_flow.enthalpyPort_a) annotation (Line(
        points={{-65,-74.1},{-56.5,-74.1},{-56.5,-74.1},{-46.8,-74.1}}, color={176,
          0,0}));
  connect(T_flow.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (Line(
        points={{-29,-74.1},{-17.5,-74.1},{-17.5,-74},{-7,-74}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b, T_return.enthalpyPort_a) annotation (
      Line(points={{11,-74},{24,-74},{24,-74.1},{37.2,-74.1}}, color={176,0,0}));
  connect(T_return.enthalpyPort_b, enthalpyPort_b1) annotation (Line(points={{55,
          -74.1},{75.5,-74.1},{75.5,-2},{100,-2}},   color={176,0,0}));
  connect(Gain_LHV.y, Capacity[3]) annotation (Line(points={{66.8,72},{84,72},{84,
          100},{106,100}}, color={0,0,127}));
  connect(switch1.y, Capacity[2]) annotation (Line(points={{2,37},{2,-34},{48,-34},
          {48,58},{84,58},{84,92},{106,92}},               color={0,0,127}));
  connect(dotP.y, integrator[1].u) annotation (Line(points={{39,-22},{48,-22},{48,
          30},{62,30}}, color={0,0,127}));
  connect(dotP.y, Capacity[1]) annotation (Line(points={{39,-22},{48,-22},{48,58},
          {84,58},{84,84},{106,84}}, color={0,0,127}));
  connect(Gain_LHV.y, integrator[3].u) annotation (Line(points={{66.8,72},{84,72},
          {84,58},{48,58},{48,30},{62,30}}, color={0,0,127}));
  connect(integrator.y, Energy) annotation (Line(points={{85,30},{90,30},{90,32},
          {106,32}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(initialScale=0.2), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillPattern=FillPattern.Solid,
          fillColor={247,247,247},
          lineColor={0,0,0}),
                    Text(
          extent={{-138,-98},{162,-138}},
          textString="%name",
          lineColor={0,0,255}),
        Rectangle(
          extent={{-64,34},{-14,-34}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,80},{38,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="On/Off"),
    Rectangle(
          extent={{-64,24},{-14,18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,16},{-14,10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,42},{4,-42}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-40,-12},
          rotation=180),
        Ellipse(
          extent={{-60,-36},{-20,-76}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,8},{-14,2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,32},{-14,26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Bitmap(extent={{66,-16},{94,-100}}, fileName=
              "modelica://FastHVAC/Images/Blitz-T-Shirts.jpg"),
        Bitmap(extent={{16,56},{74,-38}}, fileName=
              "modelica://FastHVAC/Images/10_metaheiss.jpg"),
        Ellipse(
          extent={{-44,-52},{-36,-60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,30},{-14,2}},
          lineColor={0,0,0},
          lineThickness=1),
        Polygon(
          points={{20,-16},{68,32},{68,-16},{60,-16},{68,-16},{20,-16}},
          lineColor={0,0,0},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-78,-24},{12,-90}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{26,-36},{70,-78}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={135,135,135}),
        Text(
          extent={{32,-42},{64,-74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          textString="G"),
        Line(
          points={{12,-54},{26,-54}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{12,-56},{26,-56}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.None),
        Rectangle(
          extent={{-14,22},{16,20}},
          lineThickness=1,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{16,18},{-14,16}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-50,-42},{-18,-74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          textString="M"),
        Line(
          points={{-14,22},{-14,14}},
          thickness=1,
          smooth=Smooth.None,
          color={0,0,0}),
        Text(
          extent={{-98,80},{-24,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Start/Stop")}),
    Diagram(coordinateSystem(initialScale=0.2)),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  <br/>
  Simple model for a electricity driven CHP. using record
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  There are two possibilities for parameterization. The first is based
  on records for CHP characteristics from the <a href=
  \"AixLib.FastHVAC.Data.CHP.BaseDataDefinition\">FastHVAC.DataBase</a>. In this
  case the electrical and thermal efficiency of the CHP is a function
  of return temperature, water mass flow rate and electrical power.
</p>
<p>
  The second possibility is to set the parameters manually (compare:
  Parameters-Unit properties). In this case the set values are
  constant.
</p>
<p>
  The electrical and thermal behavior of the CHP is represented by PT1
  transfer function. The on off control strategy is pretended from an external
  controller. The start and stop functionality could either be pretended from 
  external or the integrated Start Stop controller can be used.
  Furthermore a switch counter is implemented.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=\"FastHVAC.Examples.HeatGenerators.CHP.CHP\">CHP</a>
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 09, 2015&#160;</i> Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html>"));
end CHPDyn;
