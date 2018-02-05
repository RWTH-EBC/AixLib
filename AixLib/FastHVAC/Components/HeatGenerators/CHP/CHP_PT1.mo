within AixLib.FastHVAC.Components.HeatGenerators.CHP;
model CHP_PT1 "Simple general CHP model"


 /* *******************************************************************
      BHKW Parameters
      ******************************************************************* */
    parameter Boolean selectable=true "CHP record";

    parameter FastHVAC.Data.CHP.BaseDataDefinition param=
      FastHVAC.Data.CHP.Ecopower() "Paramter contains data from CHP records"
    annotation (Dialog(enable=selectable), choicesAllMatching=true, group="Unit properties");

    parameter Modelica.SIunits.Efficiency eta_el= 0.25
    "CHP's electrical efficiency "
    annotation (Dialog(group = "Unit properties",enable=not selectable));
    parameter Modelica.SIunits.Efficiency eta_th = 0.65
    "CHP's thermal efficiency "
    annotation (Dialog(group = "Unit properties",enable=not selectable));

    parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Standard flow charastics for water (heat capacity, density, thermal conductivity)"    annotation (choicesAllMatching);
    constant Real LHV(unit="J/kg")=47300000 "Lower heating value [J/kg]";
protected
    parameter Modelica.SIunits.Volume V_water = 3e-3
    "Water volume inside the CHP";
public
    parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature ";
    parameter Modelica.SIunits.Power capP_el=1000 "CHPs electrical capacity" annotation (Dialog(group = "Unit properties",enable=not selectable));
 /* *******************************************************************
      Variables
      ******************************************************************* */

    Modelica.SIunits.Efficiency eff_tot "Total efficiency ";
    Modelica.SIunits.HeatFlowRate Q_th "Thermal power";
    Modelica.SIunits.MassFlowRate dotm_fuel "Fuel mass flow rate ";
    Modelica.SIunits.HeatFlowRate  dotE_fuel "Fuel energy consumption ";
    Modelica.SIunits.Efficiency eff_el "CHP's electrical efficiency ";
    Modelica.SIunits.Efficiency eff_th "CHP's thermal efficiency ";
    Modelica.SIunits.Power P_el "Capacity ";

    Real sigma(  start=0.4) "Nominal power to heat ratio";
  /* *******************************************************************
      Components
      ******************************************************************* */

    Modelica.Blocks.Continuous.FirstOrder firstOrderQ_th(T=param.tauQ_th,
    y_start=0,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    "dynamic behavior of thermal power output [W]"
    annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrderP_el(T=param.tauP_el,
    y_start=0,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    "dynamic behavior of electrical power output [W]"
    annotation (Placement(transformation(extent={{0,16},{20,36}})));
    FastHVAC.BaseClasses.WorkingFluid fluidCHP(
    medium=medium,
    m_fluid=V_water*medium.rho,
    T0=T0)
    annotation (Placement(transformation(extent={{-28,-94},{12,-56}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                  varHeatFlow
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,-56})));
    Modelica.Blocks.Interfaces.BooleanInput onOff "CHP on/off switch"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-50,102}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,92})));
    FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

    Modelica.Blocks.Interfaces.RealOutput Energy[3](unit="J")
    "1=W_el 2=Q_th 3=E_fuel"
    annotation (Placement(transformation(extent={{92,8},{132,48}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={102,-48})));
    Modelica.Blocks.Continuous.Integrator integrator[3]
      annotation (Placement(transformation(extent={{54,16},{74,36}})));
    Modelica.Blocks.Interfaces.RealOutput Capacity[3](unit="W")
    "1=P_el 2=dotQ_th 3=dotE_fuel" annotation (Placement(transformation(
          extent={{92,40},{132,80}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={102,56})));
  FastHVAC.Components.Controller.SwitchCounter switchCounter
    annotation (Placement(transformation(extent={{-50,58},{-30,78}})));
  FastHVAC.Components.Sensors.MassFlowSensor massFlowRate
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=270,
        origin={-71,-11})));
  FastHVAC.Components.Sensors.TemperatureSensor T_flow annotation (Placement(
        transformation(
        extent={{-11,-13},{11,13}},
        rotation=0,
        origin={-61,-75})));
  FastHVAC.Components.Sensors.TemperatureSensor T_return annotation (Placement(
        transformation(
        extent={{-11,-13},{11,13}},
        rotation=0,
        origin={71,-75})));

  Modelica.Blocks.Interfaces.RealInput P_elRel( unit="1")
    "Capacity of electrical power [0 to 1]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={30,100}),
                     iconTransformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,92})));

equation
    integrator[1].u = P_el;
    integrator[2].u = Q_th;
    integrator[3].u = dotE_fuel;

      P_el = firstOrderP_el.y;
      Q_th = firstOrderQ_th.y;

       if onOff and selectable then
       eff_el = param.a_0 + param.a_1*(P_el/1000)^2 + param.a_2*(P_el/1000) + param.a_3*massFlowRate.dotm^2 + param.a_4*massFlowRate.dotm + param.a_5* Modelica.SIunits.Conversions.to_degC(T_return.T)^2 + param.a_6*Modelica.SIunits.Conversions.to_degC(T_return.T);
       eff_th = param.b_0 + param.b_1*(P_el/1000)^2 + param.b_2*(P_el/1000) + param.b_3*massFlowRate.dotm^2 + param.b_4*massFlowRate.dotm + param.b_5* Modelica.SIunits.Conversions.to_degC(T_return.T)^2 + param.b_6*Modelica.SIunits.Conversions.to_degC(T_return.T);
       firstOrderQ_th.u = param.P_elRated*P_elRel / sigma;
       firstOrderP_el.u=param.P_elRated*P_elRel;
       sigma=eff_el/eff_th;
       dotE_fuel = P_el / eff_el;
       elseif onOff then  //CHP is on
       dotE_fuel = P_el / eff_el;
       sigma=eff_el/eff_th;
       eff_el=eta_el;
       eff_th=eta_th;
       firstOrderQ_th.u = capP_el*P_elRel / sigma;
       firstOrderP_el.u=capP_el*P_elRel;
     else //CHP is off
       eff_el=0;
       eff_th=0;
       firstOrderP_el.u=0;
       firstOrderQ_th.u = 0;
       sigma=0;
       dotE_fuel =0;
     end if;

    eff_tot = eff_th + eff_el;
    dotm_fuel = dotE_fuel / (LHV/1000);
    Capacity[3] = dotE_fuel;

  connect(onOff, switchCounter.u) annotation (Line(
      points={{-50,102},{-50,68},{-49,68}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(integrator.y, Energy) annotation (Line(
      points={{75,26},{94,26},{94,28},{112,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrderP_el.y, Capacity[1]);
  connect(firstOrderQ_th.y, Capacity[2]) annotation (Line(
      points={{21,-14},{32,-14},{32,60},{112,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrderQ_th.y, varHeatFlow.Q_flow) annotation (Line(
      points={{21,-14},{32,-14},{32,-56},{30,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fluidCHP.heatPort, varHeatFlow.port) annotation (Line(
      points={{-8,-57.14},{-8,-56},{10,-56}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fluidCHP.enthalpyPort_b, T_return.enthalpyPort_a) annotation (Line(
      points={{10,-75},{19,-75},{19,-75.13},{61.32,-75.13}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_return.enthalpyPort_b, enthalpyPort_b) annotation (Line(
      points={{80.9,-75.13},{80.9,0},{100,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_flow.enthalpyPort_b, fluidCHP.enthalpyPort_a) annotation (Line(
      points={{-51.1,-75.13},{-34.55,-75.13},{-34.55,-75},{-26,-75}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(enthalpyPort_a, massFlowRate.enthalpyPort_a) annotation (Line(
      points={{-100,0},{-72,0},{-72,-1.32},{-71.11,-1.32}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(massFlowRate.enthalpyPort_b, T_flow.enthalpyPort_a) annotation (Line(
      points={{-71.11,-20.9},{-71.11,-75.13},{-70.68,-75.13}},
      color={176,0,0},
      smooth=Smooth.None));
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})),
                Placement(transformation(extent={{-120,50},{-80,90}})),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                    graphics={
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
          extent={{-78,80},{-4,66}},
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
          color={0,0,0})}),
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
  \"FastHVAC.Data.CHP.BaseDataDefinition\">FastHVAC.DataBase</a>. In this
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
  transfer function. The control strategy is pretended from an external
  controller. There is an ON/OFF switch for the boiler and also a
  possibility to control the modulating operation, CHPs electrical
  capacity. Furthermore a switch counter is implemented.
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
end CHP_PT1;
