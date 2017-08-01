within AixLib.Controls;
package Boiler "Boiler Controller"
  extends Modelica.Icons.VariantsPackage;
  package BaseClasses "Base Classes for Controller Models"
    extends Modelica.Icons.BasesPackage;
    partial model BoilerStateController

      parameter Modelica.SIunits.Time delayStarting=60
        "delay for starting combustion";
      parameter Modelica.SIunits.Time delayStopping=60
        "delay after stopping combustion";
      parameter Modelica.SIunits.Temperature Tmax=273.15+95 "maximum outlet temperature";
      parameter Modelica.SIunits.DimensionlessRatio minPartLoadRate=0.3
        "minimal part load rate";

      Modelica.StateGraph.InitialStep Standby
        annotation (Placement(transformation(extent={{-94,48},{-74,68}})));
      Modelica.StateGraph.StepWithSignal Combustion
        annotation (Placement(transformation(extent={{0,48},{20,68}})));
      Modelica.StateGraph.TransitionWithSignal heatDemand(enableTimer=false,
          waitTime=1)
        annotation (Placement(transformation(extent={{-68,48},{-48,68}})));
      Modelica.StateGraph.TransitionWithSignal noDemand(waitTime=60, enableTimer=
            false)
        annotation (Placement(transformation(extent={{24,48},{44,68}})));
      Modelica.StateGraph.Step preCombustion
        annotation (Placement(transformation(extent={{-46,48},{-26,68}})));
      Modelica.StateGraph.Step stopCombustion
        annotation (Placement(transformation(extent={{48,48},{68,68}})));
      Modelica.StateGraph.Transition delayStart(enableTimer=true, waitTime=
            delayStarting)
        annotation (Placement(transformation(extent={{-24,48},{-4,68}})));
      Modelica.StateGraph.Transition delayStop(enableTimer=true, waitTime=
            delayStopping)
        annotation (Placement(transformation(extent={{74,48},{94,68}})));
      BoilerControllerBus boilerControllerBus
        annotation (Placement(transformation(extent={{-14,84},{14,114}})));
      BoilerControllerBus boilerBus
        annotation (Placement(transformation(extent={{-14,-94},{14,-64}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
            minPartLoadRate) annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={20,-2})));
      Modelica.Blocks.Logical.Switch PartLoadRateOutput
        "If false: use external part load rate"
        annotation (Placement(transformation(extent={{62,-32},{80,-14}})));
      Modelica.Blocks.Sources.Constant zeroPartLoad(k=0)
        annotation (Placement(transformation(extent={{36,-36},{46,-26}})));
      Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
            extent={{-4,-4},{4,4}},
            rotation=90,
            origin={34,32})));
      Modelica.Blocks.Logical.LessThreshold    greaterThreshold1(threshold=Tmax)
        annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={38,-2})));
      Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={20,20})));
    equation
      connect(Standby.outPort[1], heatDemand.inPort) annotation (Line(points={{-73.5,
              58},{-73.5,58},{-62,58}}, color={0,0,0}));
      connect(preCombustion.outPort[1], delayStart.inPort)
        annotation (Line(points={{-25.5,58},{-18,58}}, color={0,0,0}));
      connect(delayStart.outPort, Combustion.inPort[1])
        annotation (Line(points={{-12.5,58},{-1,58}}, color={0,0,0}));
      connect(heatDemand.outPort, preCombustion.inPort[1])
        annotation (Line(points={{-56.5,58},{-47,58}}, color={0,0,0}));
      connect(stopCombustion.outPort[1], delayStop.inPort)
        annotation (Line(points={{68.5,58},{74.25,58},{80,58}}, color={0,0,0}));
      connect(delayStop.outPort, Standby.inPort[1]) annotation (Line(points={{
              85.5,58},{98,58},{98,60},{98,84},{-100,84},{-100,58},{-95,58}},
            color={0,0,0}));
      connect(Combustion.outPort[1], noDemand.inPort)
        annotation (Line(points={{20.5,58},{25.25,58},{30,58}}, color={0,0,0}));
      connect(noDemand.outPort, stopCombustion.inPort[1])
        annotation (Line(points={{35.5,58},{47,58}}, color={0,0,0}));
      connect(zeroPartLoad.y, PartLoadRateOutput.u3) annotation (Line(points={{
              46.5,-31},{50,-31},{50,-30},{54,-30},{54,-30.2},{60.2,-30.2}},
            color={0,0,127}));
      connect(Combustion.active, PartLoadRateOutput.u2) annotation (Line(points={
              {10,47},{10,47},{10,-23},{60.2,-23}}, color={255,0,255}));
      connect(not1.y, noDemand.condition) annotation (Line(points={{34,36.4},{34,
              36.4},{34,46}}, color={255,0,255}));
      connect(PartLoadRateOutput.y, boilerBus.PLR) annotation (Line(points={{80.9,
              -23},{88,-23},{88,-24},{94,-24},{94,-78.925},{0.07,-78.925}}, color=
             {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(greaterThreshold.y, and1.u1)
        annotation (Line(points={{20,4.6},{20,12.8}}, color={255,0,255}));
      connect(and1.u2, greaterThreshold1.y) annotation (Line(points={{24.8,12.8},
              {38,12.8},{38,4},{38,4},{38,4},{38,4.6}}, color={255,0,255}));
      connect(and1.y, not1.u) annotation (Line(points={{20,26.6},{30,26.6},{30,
              27.2},{34,27.2}}, color={255,0,255}));
      connect(and1.y, heatDemand.condition) annotation (Line(points={{20,26.6},{-58,
              26.6},{-58,46}}, color={255,0,255}));
      connect(greaterThreshold1.u, boilerBus.Tout) annotation (Line(points={{38,-9.2},
              {68,-9.2},{68,-8},{94,-8},{94,-78.925},{0.07,-78.925}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,
                100}}), graphics={
            Rectangle(extent={{-58,52},{52,-36}}, pattern=LinePattern.None),
            Rectangle(
              extent={{-100,100},{100,-76}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-66,0},{-44,-20}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-70,64},{76,24}},
              lineColor={255,255,255},
              fillColor={170,255,213},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-62,52},{58,34}},
              lineColor={255,255,255},
              fillColor={170,255,213},
              fillPattern=FillPattern.Solid,
              textString="Controller"),
            Ellipse(
              extent={{-32,0},{-10,-20}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,0},{22,-20}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-66,-28},{-44,-48}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-32,-28},{-10,-48}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,-28},{22,-48}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(graphics,
                coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{
                100,100}})),
        Documentation(info="<html>
<p>Partial boiler controller with states.</p>
</html>",   revisions="<html>
<ul>
<li><i>2017-06-18</i>  by Peter Matthes:<br>Fixed security check Tout &LT; Tmax. Problem before was that Tmax was given in degC instead of K, so that Tout &GT; Tmax was always true.</li>
<li><i>June, 2017 &nbsp;</i> by Alexander K&uuml;mpel:<br>V0.1: Initial configuration. </li>
</ul>
</html>"));
    end BoilerStateController;

    expandable connector BoilerControllerBus
      "Connector between controller and building automation system "

      extends Modelica.Icons.SignalBus;
      import SI = Modelica.SIunits;

      Integer Priority "Priority of Control Strategy";
      SI.DimensionlessRatio PLR "Part Load Rate (0-1)"
                                                      annotation (HideResult=false);
      SI.Power Pgas "Power of consumed gas"
                                           annotation (HideResult=false);
      SI.HeatFlowRate Qflow "Power of heatflow"
                                               annotation (HideResult=false);
      SI.Temperature Tin "Inlet temperature"
                                            annotation (HideResult=false);
      SI.Temperature Tout "Outlet temperature"
                                              annotation (HideResult=false);
      SI.Temperature Tambient "Ambient temperature"
                                                   annotation (HideResult=false);
      SI.MassFlowRate m_flow "Mass flow through boiler"
                                                       annotation (HideResult=false);
      Modelica.SIunits.Temperature Tset "Outlet set temperature" annotation (HideResult=false);

    end BoilerControllerBus;

  end BaseClasses;

  model BoilerControlHeatingCurve
    "Boiler Controller with internal heating curve control"
    import DataBase;
    extends BaseClasses.BoilerStateController;
    parameter
      DataBase.Boiler.DayNightMode.HeatingCurvesDayNightBaseDataDefinition paramHC=
        DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10()
      "Parameters for heating curve"
      annotation (Dialog(group="Heating curves"), choicesAllMatching=true);
    parameter Real declination=1.1 "Slope of heating curve"
      annotation (Dialog(group="Heating curves"));
    parameter Real k(
      min=0,
      unit="1") = 1 "Gain of controller";
    parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small) = 0.5
      "Time constant of Integrator block";
    parameter Modelica.SIunits.Time Td(min=0) = 0.1
      "Time constant of Derivative block";

    Modelica.Blocks.Sources.Constant Declination(k=declination)
      annotation (Placement(transformation(extent={{-98,-24},{-85,-12}})));
    Modelica.Blocks.Math.UnitConversions.To_degC to_degC
      annotation (Placement(transformation(extent={{-98,-6},{-86,6}})));

    Modelica.Blocks.Continuous.LimPID PID(
      Ti=10,
      Td=0.01,
      yMax=1,
      yMin=0) annotation (Placement(transformation(extent={{-24,-24},{-4,-4}})));
    Modelica.Blocks.Routing.RealPassThrough ambientTemperatur
      "Pass through of ambient temperature"
      annotation (Placement(transformation(extent={{-86,-80},{-72,-66}})));
    Modelica.Blocks.Routing.RealPassThrough Pgas
      "Pass through of ambient temperature" annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-79,-55})));
  protected
    Modelica.Blocks.Tables.CombiTable2D FlowTempDay(table=paramHC.varFlowTempDay)
      "Table for setting the flow temperature druing day according to the outside temperature"
      annotation (Placement(transformation(extent={{-76,-24},{-52,0}})));
  public
    Modelica.Blocks.Math.UnitConversions.From_degC from_degC
      annotation (Placement(transformation(extent={{-44,-20},{-32,-8}})));
    Modelica.Blocks.Routing.RealPassThrough Tin
      "Pass through of ambient temperature" annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-145,-19})));
    Modelica.Blocks.Routing.RealPassThrough Tout
      "Pass through of ambient temperature" annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-145,-1})));
    Modelica.Blocks.Routing.RealPassThrough m_flow
      "Pass through of ambient temperature" annotation (Placement(
          transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-145,17})));
    Modelica.Blocks.Routing.RealPassThrough Qflow
      "Pass through of ambient temperature" annotation (Placement(
          transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-141,35})));
    Modelica.Blocks.Routing.RealPassThrough Qflow1
      "Pass through of ambient temperature" annotation (Placement(
          transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={25,-63})));
  equation
    connect(PID.u_m, boilerBus.Tout) annotation (Line(points={{-14,-26},{-14,-26},
            {-14,-60},{-14,-62},{0.07,-62},{0.07,-78.925}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(ambientTemperatur.y, boilerBus.Tambient) annotation (Line(points={{-71.3,
            -73},{-44,-73},{-44,-78},{-44,-78.925},{0.07,-78.925}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Pgas.u, boilerBus.Pgas) annotation (Line(points={{-70.6,-55},{-43.3,-55},
            {-43.3,-78.925},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Pgas.y, boilerControllerBus.Pgas) annotation (Line(points={{-86.7,
            -55},{-102,-55},{-102,99.075},{0.07,99.075}},
                                                     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(ambientTemperatur.u, boilerControllerBus.Tambient) annotation (Line(
          points={{-87.4,-73},{-104,-73},{-104,99.075},{0.07,99.075}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Declination.y, FlowTempDay.u2) annotation (Line(points={{-84.35,-18},
            {-78.4,-18},{-78.4,-19.2}},   color={0,0,127}));
    connect(ambientTemperatur.u, to_degC.u) annotation (Line(points={{-87.4,-73},
            {-104,-73},{-104,0},{-99.2,0}},  color={0,0,127}));
    connect(to_degC.y, FlowTempDay.u1) annotation (Line(points={{-85.4,0},{-84,0},
            {-84,-4.8},{-78.4,-4.8}}, color={0,0,127}));
    connect(PID.y, PartLoadRateOutput.u1) annotation (Line(points={{-3,-14},{24,
            -14},{24,-15.8},{60.2,-15.8}}, color={0,0,127}));
    connect(PID.y, greaterThreshold.u)
      annotation (Line(points={{-3,-14},{20,-14},{20,-9.2}}, color={0,0,127}));
    connect(FlowTempDay.y, from_degC.u) annotation (Line(points={{-50.8,-12},{-48,
            -12},{-48,-14},{-45.2,-14}}, color={0,0,127}));
    connect(from_degC.y, PID.u_s) annotation (Line(points={{-31.4,-14},{-28.7,-14},
            {-26,-14}}, color={0,0,127}));
    connect(Tin.u, boilerBus.Tin) annotation (Line(points={{-136.6,-19},{-101.3,
            -19},{-101.3,-78.925},{0.07,-78.925}},
                                             color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Tout.u, boilerBus.Tout) annotation (Line(points={{-136.6,-1},{
            -101.3,-1},{-101.3,-78.925},{0.07,-78.925}},
                                             color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Tin.y, boilerControllerBus.Tin) annotation (Line(points={{-152.7,
            -19},{-166,-19},{-166,-20},{-180,-20},{-180,99.075},{0.07,99.075}},
                                                                           color=
            {0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Tout.y, boilerControllerBus.Tout) annotation (Line(points={{-152.7,
            -1},{-166,-1},{-166,-2},{-180,-2},{-180,99.075},{0.07,99.075}},color=
            {0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(greaterThreshold.u, boilerControllerBus.PLR) annotation (Line(points={{20,-9.2},
            {-106,-9.2},{-106,6},{-178,6},{-178,99.075},{0.07,99.075}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(m_flow.u, boilerBus.m_flow) annotation (Line(points={{-136.6,17},{
            0.07,17},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(m_flow.y, boilerControllerBus.m_flow) annotation (Line(points={{
            -152.7,17},{-152.7,68},{-152,68},{-152,118},{-110,118},{-110,99.075},
            {0.07,99.075}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow.y, boilerControllerBus.Qflow) annotation (Line(points={{
            -148.7,35},{-178,35},{-178,99.075},{0.07,99.075}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow.u, boilerBus.Qflow) annotation (Line(points={{-132.6,35},{
            0.07,35},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow.y, boilerControllerBus.Qflow) annotation (Line(points={{
            -148.7,35},{-178,35},{-178,99.075},{0.07,99.075}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow.y, boilerControllerBus.Qflow) annotation (Line(points={{
            -148.7,35},{-178,35},{-178,99.075},{0.07,99.075}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow1.y, boilerBus.Tset) annotation (Line(points={{17.3,-63},{8,
            -63},{8,-78.925},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow1.u, zeroPartLoad.y) annotation (Line(points={{33.4,-63},{40,
            -63},{40,-31},{46.5,-31}}, color={0,0,127}));
    annotation (
      Dialog(group="Heating curves"),
      choicesAllMatching=true,
      Documentation(info="<html>
<p>This controller uses an internal heating curve that calculates the set point temperature as a function of the ambient temperature. A PID controller calculates the part load rate.</p>
</html>",   revisions="<html>
<ul>
<li><i>June, 2017 &nbsp;</i> by Alexander K&uuml;mpel:<br>V0.1: Initial configuration. </li>
</html>"));
  end BoilerControlHeatingCurve;

  model BoilerControlPartLoad "Boiler Controller with external part load input"
    extends BaseClasses.BoilerStateController;
    Modelica.Blocks.Routing.RealPassThrough ambientTemperatur
      "Pass through of ambient temperature"
      annotation (Placement(transformation(extent={{-86,-80},{-72,-66}})));
    Modelica.Blocks.Routing.RealPassThrough Pgas
      "Pass through of ambient temperature" annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-79,-55})));
    Modelica.Blocks.Routing.RealPassThrough Tin
      "Pass through of ambient temperature" annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-79,-37})));
    Modelica.Blocks.Routing.RealPassThrough Tout
      "Pass through of ambient temperature" annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-79,-19})));
    Modelica.Blocks.Routing.RealPassThrough m_flow
      "Pass through of ambient temperature" annotation (Placement(
          transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-79,-1})));
    Modelica.Blocks.Routing.RealPassThrough Qflow
      "Pass through of ambient temperature" annotation (Placement(
          transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-75,17})));
  equation
    connect(ambientTemperatur.y, boilerBus.Tambient) annotation (Line(points={{-71.3,
            -73},{-44,-73},{-44,-78},{-44,-78.925},{0.07,-78.925}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Pgas.u, boilerBus.Pgas) annotation (Line(points={{-70.6,-55},{-43.3,-55},
            {-43.3,-78.925},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Pgas.y, boilerControllerBus.Pgas) annotation (Line(points={{-86.7,
            -55},{-114,-55},{-114,99.075},{0.07,99.075}},
                                                     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(ambientTemperatur.u, boilerControllerBus.Tambient) annotation (Line(
          points={{-87.4,-73},{-114,-73},{-114,99.075},{0.07,99.075}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Tin.u, boilerBus.Tin) annotation (Line(points={{-70.6,-37},{-35.3,-37},
            {-35.3,-78.925},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Tout.u, boilerBus.Tout) annotation (Line(points={{-70.6,-19},{-35.3,-19},
            {-35.3,-78.925},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Tin.y, boilerControllerBus.Tin) annotation (Line(points={{-86.7,-37},
            {-100,-37},{-100,-38},{-114,-38},{-114,99.075},{0.07,99.075}}, color=
            {0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Tout.y, boilerControllerBus.Tout) annotation (Line(points={{-86.7,
            -19},{-100,-19},{-100,-20},{-114,-20},{-114,99.075},{0.07,99.075}},
                                                                           color=
            {0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(greaterThreshold.u, boilerControllerBus.PLR) annotation (Line(points={{20,-9.2},
            {-40,-9.2},{-40,-12},{-112,-12},{-112,99.075},{0.07,99.075}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(greaterThreshold.u, PartLoadRateOutput.u1) annotation (Line(points={{
            20,-9.2},{20,-9.2},{20,-16},{20,-15.8},{60.2,-15.8}}, color={0,0,127}));
    connect(m_flow.u, boilerBus.m_flow) annotation (Line(points={{-70.6,-1},{
            0.07,-1},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(m_flow.y, boilerControllerBus.m_flow) annotation (Line(points={{
            -86.7,-1},{-86.7,50},{-86,50},{-86,100},{-44,100},{-44,99.075},{
            0.07,99.075}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow.y, boilerControllerBus.Qflow) annotation (Line(points={{-82.7,
            17},{-112,17},{-112,99.075},{0.07,99.075}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow.u, boilerBus.Qflow) annotation (Line(points={{-66.6,17},{0.07,
            17},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow.y, boilerControllerBus.Qflow) annotation (Line(points={{-82.7,
            17},{-112,17},{-112,99.075},{0.07,99.075}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Qflow.y, boilerControllerBus.Qflow) annotation (Line(points={{-82.7,
            17},{-112,17},{-112,99.075},{0.07,99.075}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(zeroPartLoad.y, boilerBus.Tset) annotation (Line(points={{46.5,-31},
            {46.5,-78.925},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Documentation(info="<html>
<p>The controller uses an external part load rate.</p>
</html>",   revisions="<html>
<ul>
<li><i>June, 2017 &nbsp;</i> by Alexander K&uuml;mpel:<br>V0.1: Initial configuration. </li>
</html>"));
  end BoilerControlPartLoad;

  model BoilerControlSetTemperature
    "Boiler Controller with external set temperature"
    extends BaseClasses.BoilerStateController;
    parameter Real k(
      min=0,
      unit="1") = 1 "Gain of controller";
    parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small) = 0.5
      "Time constant of Integrator block";
    parameter Modelica.SIunits.Time Td(min=0) = 0.1
      "Time constant of Derivative block";

    Modelica.Blocks.Continuous.LimPID PID(
      yMax=1,
      yMin=0,
      k=k,
      Ti=Ti,
      Td=Td) annotation (Placement(transformation(extent={{-34,-24},{-14,-4}})));
    Modelica.Blocks.Routing.RealPassThrough ambientTemperatur
      "Pass through of ambient temperature"
      annotation (Placement(transformation(extent={{-86,-80},{-72,-66}})));
    Modelica.Blocks.Routing.RealPassThrough Pgas
      "Pass through of ambient temperature" annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-79,-55})));
  equation
    connect(PID.u_m, boilerBus.Tout) annotation (Line(points={{-24,-26},{-24,-26},
            {-24,-60},{-24,-62},{0.07,-62},{0.07,-78.925}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(PID.u_s, boilerControllerBus.Tset) annotation (Line(points={{-36,-14},
            {-114,-14},{-114,-16},{-114,99.075},{0.07,99.075}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(ambientTemperatur.y, boilerBus.Tambient) annotation (Line(points={{-71.3,
            -73},{-44,-73},{-44,-78},{-44,-78.925},{0.07,-78.925}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Pgas.u, boilerBus.Pgas) annotation (Line(points={{-70.6,-55},{-43.3,-55},
            {-43.3,-78.925},{0.07,-78.925}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Pgas.y, boilerControllerBus.Pgas) annotation (Line(points={{-86.7,
            -55},{-114,-55},{-114,99.075},{0.07,99.075}},
                                                     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(ambientTemperatur.u, boilerControllerBus.Tambient) annotation (Line(
          points={{-87.4,-73},{-114,-73},{-114,99.075},{0.07,99.075}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(PID.y, greaterThreshold.u)
      annotation (Line(points={{-13,-14},{20,-14},{20,-9.2}}, color={0,0,127}));
    connect(PID.y, PartLoadRateOutput.u1) annotation (Line(points={{-13,-14},{22,
            -14},{22,-15.8},{60.2,-15.8}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p>A PID controller that needs a set temperature as an input.</p>
</html>",   revisions="<html>
<ul>
<li><i>June, 2017 &nbsp;</i> by Alexander K&uuml;mpel:<br>V0.1: Initial configuration. </li>
</html>"));
  end BoilerControlSetTemperature;

  model BoilerControllerShell
    "Base model for boiler controller switching controller"

    BaseClasses.BoilerControllerBus BMSBus "Bus to higher level"
      annotation (Placement(transformation(extent={{-20,78},{20,118}})));
    BaseClasses.BoilerControllerBus ComponentBus "Bus to physical level"
      annotation (Placement(transformation(extent={{-20,-122},{20,-82}})));
    Interfaces.BoilerBusSwitchComponent boilerBusSwitchComponent(n=1)
      annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
    Interfaces.BoilerBusSwitchBMS testSwitchVectorBusOpposite(n=1)
      annotation (Placement(transformation(extent={{-10,48},{10,68}})));
    BoilerControlPartLoad         simpleBasicPriorityController
      annotation (Placement(transformation(extent={{-58,2},{-38,22}})));
  equation
    connect(boilerBusSwitchComponent.signalBus, ComponentBus) annotation (Line(
        points={{0,-77.8},{0,-102}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(simpleBasicPriorityController.boilerControllerBus,
      testSwitchVectorBusOpposite.signalBusVector[1]) annotation (Line(
        points={{-48,21.8889},{-24,21.8889},{-24,48.2},{0,48.2}},
        color={255,204,51},
        thickness=0.5));
    connect(simpleBasicPriorityController.boilerBus, boilerBusSwitchComponent.signalBusVector[
      1]) annotation (Line(
        points={{-48,2.11111},{-24,2.11111},{-24,-58.2},{0,-58.2}},
        color={255,204,51},
        thickness=0.5));
    connect(testSwitchVectorBusOpposite.signalBus, BMSBus) annotation (Line(
        points={{0,67.8},{0,98}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(testSwitchVectorBusOpposite.u, BMSBus.Priority) annotation (Line(
          points={{-7.6,68},{-32,68},{-32,70},{-48,70},{-48,98.1},{0.1,98.1}},
          color={255,127,0}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(boilerBusSwitchComponent.u, BMSBus.Priority) annotation (Line(
          points={{-7.6,-58},{-80,-58},{-80,98.1},{0.1,98.1}}, color={255,127,0}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-80,50},{76,-8}},
            lineColor={0,0,0},
            fillColor={134,176,68},
            fillPattern=FillPattern.Solid,
            lineThickness=1),
          Text(
            extent={{-72,38},{62,8}},
            lineColor={54,86,37},
            fillColor={0,216,108},
            fillPattern=FillPattern.Solid,
            textString="Controller"),
          Rectangle(
            extent={{-10,11},{10,-11}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid,
            origin={1,-64},
            rotation=270),
          Polygon(
            points={{1,8},{-7,-6},{9,-6},{1,8}},
            lineColor={0,0,0},
            fillColor={79,79,79},
            fillPattern=FillPattern.Solid,
            origin={2,-63},
            rotation=180),
          Rectangle(
            extent={{22,-38},{42,-58}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{1,8},{-7,-6},{9,-6},{1,8}},
            lineColor={0,0,0},
            fillColor={79,79,79},
            fillPattern=FillPattern.Solid,
            origin={32,-47},
            rotation=270),
          Rectangle(
            extent={{-10,10},{10,-10}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid,
            origin={-30,-48},
            rotation=180),
          Polygon(
            points={{1,8},{-7,-6},{9,-6},{1,8}},
            lineColor={0,0,0},
            fillColor={79,79,79},
            fillPattern=FillPattern.Solid,
            origin={-30,-49},
            rotation=90),
          Rectangle(
            extent={{-10,11},{10,-11}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid,
            origin={1,-32},
            rotation=90),
          Polygon(
            points={{1,8},{-7,-6},{9,-6},{1,8}},
            lineColor={0,0,0},
            fillColor={79,79,79},
            fillPattern=FillPattern.Solid,
            origin={0,-33},
            rotation=360)}),                                       Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerControllerShell;
end Boiler;
