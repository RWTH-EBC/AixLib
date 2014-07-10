within AixLib.HVAC;
package Storage "Hydraulic heat storages"
  extends Modelica.Icons.Package;

  model Storage

    outer BaseParameters baseParameters "System properties";

  parameter Integer n(min=3) "number of layers";
  parameter Modelica.SIunits.Length d "storage diameter";
  parameter Modelica.SIunits.Length h "storage height";

  parameter Modelica.SIunits.ThermalConductivity lambda_ins
      "thermal conductivity of insulation"                                                       annotation (Dialog(group = "Heat losses"));
  parameter Modelica.SIunits.Length s_ins "thickness of insulation" annotation(Dialog(group = "Heat losses"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_in
      "internal heat transfer coefficient"                                                           annotation (Dialog(group = "Heat losses"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_out
      "external heat transfer coefficient"                                                            annotation (Dialog(group = "Heat losses"));

  parameter Modelica.SIunits.Volume V_HE "heat exchanger volume" annotation (Dialog(group = "Heat exchanger"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k_HE
      "heat exchanger heat transfer coefficient"                                                       annotation (Dialog(group = "Heat exchanger"));
  parameter Modelica.SIunits.Area A_HE "heat exchanger area" annotation (Dialog(group = "Heat exchanger"));

  parameter Modelica.SIunits.RelativePressureCoefficient beta=350e-6 annotation (Dialog(group = "Bouyancy"));
  parameter Real kappa=0.4 annotation (Dialog(group = "Bouyancy"));

  protected
  parameter Modelica.SIunits.Volume V=A*h;
  parameter Modelica.SIunits.Area A=Modelica.Constants.pi*d^2/4;
  parameter Modelica.SIunits.Length dx=V/A/n;
  parameter Modelica.SIunits.ThermalConductance G_middle=2*Modelica.Constants.pi*h/n/(1/(alpha_in*d/2) + 1/lambda_ins*log((d/2 + s_ins)/(d/2)) + 1/(alpha_out*(d/2 +s_ins)));
  parameter Modelica.SIunits.ThermalConductance G_top_bottom=G_middle+lambda_ins/s_ins*A;
  public
    Interfaces.Port_a port_a_consumer
      annotation (Placement(transformation(extent={{-10,-108},{10,-88}}),
          iconTransformation(extent={{-10,-110},{10,-90}})));
    Interfaces.Port_b port_b_consumer
      annotation (Placement(transformation(extent={{-10,82},{10,102}}),
          iconTransformation(extent={{-10,90},{10,110}})));
     HVAC.Volume.Volume layer[n](each V=V/n) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
      "connect to ambient temperature around the storage"
      annotation (Placement(transformation(extent={{-116,-10},{-96,10}}),
          iconTransformation(extent={{-90,-10},{-70,10}})));
    Interfaces.Port_b port_b_heatGenerator
      annotation (Placement(transformation(extent={{74,-98},{94,-78}}),
          iconTransformation(extent={{74,-90},{94,-70}})));
    Interfaces.Port_a port_a_heatGenerator
      annotation (Placement(transformation(extent={{74,78},{94,98}}),
          iconTransformation(extent={{74,78},{94,98}})));
     HVAC.Volume.Volume layer_HE[n](each V=V_HE/n) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={84,0})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatTransfer_HE[n](each G=k_HE*A_HE/n)
      annotation (Placement(transformation(extent={{32,-10},{52,10}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatTransfer[n](G=cat(1,{G_top_bottom},
    {G_middle for k in 2:n - 1},{G_top_bottom}))                                                      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    BaseClasses.Bouyancy
             bouyancy[n - 1](
      each rho=baseParameters.rho_Water,
      each lambda=baseParameters.lambda_Water,
      each g=baseParameters.g,
      each cp=baseParameters.cp_Water,
      each A=A,
      each beta=beta,
      each dx=dx,
      each kappa=kappa)
      annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
  equation

  //Connect layers to the upper and lower ports
    connect(layer[1].port_a, port_a_consumer);
    connect(layer[n].port_b, port_b_consumer);

  //Connect layers
  for k in 1:n-1 loop
    connect(layer[k].port_b,layer[k+1].port_a);
  end for;

  //Connect Heat Transfer to the Outside
  for k in 1:n loop
    connect(heatTransfer[k].port_a,layer[k].heatPort);
    connect(heatTransfer[k].port_b,heatPort);
  end for;

  //Connect layers of Heat Exchanger
    connect(layer_HE[1].port_a, port_b_heatGenerator);
    connect(layer_HE[n].port_b, port_a_heatGenerator);
  for k in 1:n-1 loop
    connect(layer_HE[k].port_b,layer_HE[k+1].port_a);
  end for;

  //Connect heat exchanger to storage layers
  for k in 1:n loop
    connect(heatTransfer_HE[k].port_a,layer[k].heatPort);
    connect(heatTransfer_HE[k].port_b,layer_HE[k].heatPort);
  end for;

  //Connect bouyancy element
  for k in 1:n-1 loop
    connect(bouyancy[k].port_a,layer[k+1].heatPort);
    connect(bouyancy[k].port_b,layer[k].heatPort);

  end for;

    connect(heatPort, heatPort) annotation (Line(
        points={{-106,0},{-106,0}},
        color={191,0,0},
        smooth=Smooth.None));
     annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),  graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{-154,3},{-136,-7},{-110,-3},{-84,-7},{-48,-5},{-18,-9},{6,-3},
                {6,-41},{-154,-41},{-154,3}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            origin={78,-59},
            rotation=360),
          Polygon(
            points={{-154,3},{-134,-3},{-110,1},{-84,-1},{-56,-5},{-30,-11},{6,-3},
                {6,-41},{-154,-41},{-154,3}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={14,110,255},
            fillPattern=FillPattern.Solid,
            origin={78,-27},
            rotation=360),
          Rectangle(
            extent={{-80,-71},{80,71}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid,
            origin={4,1},
            rotation=360),
          Polygon(
            points={{-24,-67},{-16,-67},{-8,-67},{4,-67},{12,-67},{36,-67},{76,
                -67},{110,-67},{136,-67},{136,39},{-24,35},{-24,-67}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            origin={-52,33},
            rotation=360),
          Polygon(
            points={{-39,-30},{-31,-30},{-11,-30},{23,-30},{67,-30},{93,-30},{121,
                -30},{121,24},{-39,26},{-39,-30}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={255,170,170},
            fillPattern=FillPattern.Solid,
            origin={-37,38},
            rotation=360),
          Polygon(
            points={{-80,100},{-80,54},{-62,54},{-30,54},{32,54},{80,54},{80,82},
                {80,100},{-80,100}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={255,62,62},
            fillPattern=FillPattern.Solid,
            origin={4,0},
            rotation=360),
          Rectangle(
            extent={{-76,100},{84,-100}},
            lineColor={0,0,0},
            lineThickness=1),
          Line(
            points={{-21,94},{-21,132}},
            color={0,0,0},
            smooth=Smooth.Bezier,
            thickness=1,
            arrow={Arrow.Filled,Arrow.None},
            origin={-56,67},
            rotation=270,
            visible=use_heatingCoil1),
          Line(
            points={{-54,88},{68,56}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier,
            visible=  use_heatingCoil1),
          Line(
            points={{68,56},{-48,44}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier,
            visible=  use_heatingCoil1),
          Line(
            points={{-48,44},{62,6}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier,
            visible=  use_heatingCoil1),
          Line(
            points={{62,6},{-44,-16}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier,
            visible=  use_heatingCoil1),
          Line(
            points={{76,-81},{-26,-81}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier,
            visible=  use_heatingCoil1),
          Line(
            points={{0,-9},{0,9}},
            color={0,0,0},
            smooth=Smooth.Bezier,
            thickness=1,
            arrow={Arrow.Filled,Arrow.None},
            origin={-34,-81},
            rotation=90,
            visible=  use_heatingCoil1),
          Line(
            points={{62,-42},{-44,-16}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier,
            visible=  use_heatingCoil1),
          Line(
            points={{62,-42},{-42,-80}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier,
            visible=  use_heatingCoil1),
          Line(
            points={{48,88},{-54,88}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier,
            visible=use_heatingCoil1)}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple model for a buffer storage.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The water volume can be discretised in several layers.</p>
<p>The following physical processes are modelled</p>
<ul>
<li>heat exchange with the environment</li>
<li>heat exchange over the heat exchanger</li>
<li>a bouyancy model for the heat transfer between the layers</li>
</ul>
<p><br><b><font style=\"color: #008000; \">Example Results</font></b></p>
<p><a href=\"AixLib.HVAC.Storage.Examples.StorageBoiler\">AixLib.HVAC.Storage.Examples.StorageBoiler</a></p>
<p><a href=\"AixLib.HVAC.Storage.Examples.StorageSolarCollector\">AixLib.HVAC.Storage.Examples.StorageSolarCollector</a></p>
</html>", revisions="<html>
<p>13.12.2013, by <i>Sebastian Stinner</i>: implemented</p>
</html>"));
  end Storage;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model StorageBoiler
      extends Modelica.Icons.Example;
      import AixLib;

      Storage storage(
        n=10,
        V_HE=0.05,
        kappa=0.4,
        beta=350e-6,
        A_HE=20,
        lambda_ins=0.04,
        s_ins=0.1,
        alpha_in=1500,
        alpha_out=15,
        d=1,
        h=2,
        k_HE=1500)
        annotation (Placement(transformation(extent={{-56,14},{-36,34}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
            283.15)
        annotation (Placement(transformation(extent={{-94,14},{-74,34}})));
      Pumps.Pump pump annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-32,62})));
      HeatGeneration.Boiler boiler(Q_flow_max=50000, boilerEfficiencyB=
            AixLib.DataBase.Boiler.BoilerCondensing()) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-16,76})));
      Sources.Boundary_p boundary_p
        annotation (Placement(transformation(extent={{-86,70},{-66,90}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={6,60})));
      Modelica.Blocks.Sources.Constant const(k=273.15 + 80) annotation (Placement(
            transformation(
            extent={{-3,-3},{3,3}},
            rotation=180,
            origin={13,69})));
      inner BaseParameters baseParameters(T_ref=273.15)
        annotation (Placement(transformation(extent={{60,76},{80,96}})));
      Pipes.StaticPipe pipe(D=0.05, l=5)
        annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
      HydraulicResistances.HydraulicResistance hydraulicResistance(zeta=1000)
        annotation (Placement(transformation(extent={{8,-10},{28,10}})));
      Sources.Boundary_ph boundary_ph1(use_p_in=true, h=0.8e5)
        annotation (Placement(transformation(extent={{-104,-20},{-84,0}})));
      Modelica.Blocks.Sources.Ramp ramp(
        duration=1000,
        offset=1e5,
        height=0.00001e5)
        annotation (Placement(transformation(extent={{-136,-14},{-116,6}})));
      Sources.Boundary_ph boundary_ph2(use_p_in=false) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-72,46})));
      Pipes.StaticPipe pipe1(D=0.05, l=5)
        annotation (Placement(transformation(extent={{-66,-20},{-46,0}})));
    equation
      connect(fixedTemperature.port, storage.heatPort) annotation (Line(
          points={{-74,24},{-54,24}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(pump.port_a, boiler.port_b) annotation (Line(
          points={{-32,72},{-32,76},{-26,76}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundary_p.port_a, pump.port_a) annotation (Line(
          points={{-66,80},{-32,80},{-32,72}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(booleanExpression.y, pump.IsNight) annotation (Line(
          points={{-5,60},{-14,60},{-14,62},{-21.8,62}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(const.y, boiler.T_set) annotation (Line(
          points={{9.7,69},{-5.2,69}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pipe.port_b, hydraulicResistance.port_a) annotation (Line(
          points={{-6,0},{8,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(hydraulicResistance.port_b, boiler.port_a) annotation (Line(
          points={{28,0},{52,0},{52,76},{-6,76}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pump.port_b, storage.port_a_heatGenerator) annotation (Line(
          points={{-32,52},{-32,32.8},{-37.6,32.8}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_a, storage.port_b_heatGenerator) annotation (Line(
          points={{-26,0},{-32,0},{-32,16},{-37.6,16}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(ramp.y, boundary_ph1.p_in) annotation (Line(
          points={{-115,-4},{-106,-4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundary_ph2.port_a, storage.port_b_consumer) annotation (Line(
          points={{-62,46},{-46,46},{-46,34}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundary_ph1.port_a, pipe1.port_a) annotation (Line(
          points={{-84,-10},{-66,-10}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe1.port_b, storage.port_a_consumer) annotation (Line(
          points={{-46,-10},{-46,14}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=86400, Interval=60),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>This is a simple example of a storage and a boiler.</p>
</html>", revisions="<html>
<p>13.12.2013, by <i>Sebastian Stinner</i>: implemented</p>
</html>"));
    end StorageBoiler;

    model StorageSolarCollector
      extends Modelica.Icons.Example;
      import AixLib;

      Storage storage(
        n=10,
        V_HE=0.05,
        kappa=0.4,
        beta=350e-6,
        A_HE=20,
        lambda_ins=0.04,
        s_ins=0.1,
        alpha_in=1500,
        alpha_out=15,
        k_HE=1500,
        d=1.5,
        h=2.5)
        annotation (Placement(transformation(extent={{-56,14},{-36,34}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
            283.15)
        annotation (Placement(transformation(extent={{-94,14},{-74,34}})));
      Pumps.Pump pump(ControlStrategy=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-38,64})));
      Sources.Boundary_p boundary_p
        annotation (Placement(transformation(extent={{-86,70},{-66,90}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-10,64})));
      inner BaseParameters baseParameters(T_ref=273.15)
        annotation (Placement(transformation(extent={{60,76},{80,96}})));
      Pipes.StaticPipe pipe(D=0.05, l=5)
        annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
      Sources.Boundary_ph boundary_ph1(use_p_in=true, h=42e3)
        annotation (Placement(transformation(extent={{-112,-20},{-92,0}})));
      Sources.Boundary_ph boundary_ph2(use_p_in=false) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-72,46})));
      Pipes.StaticPipe pipe1(D=0.05, l=5)
        annotation (Placement(transformation(extent={{-68,-20},{-48,0}})));
      Sources.TempAndRad tempAndRad(temperatureOT=
            AixLib.DataBase.Weather.SummerDay()) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={32,34})));
      HeatGeneration.SolarThermal solarThermal(Collector=
            AixLib.DataBase.SolarThermal.FlatCollector(), A=20)
        annotation (Placement(transformation(extent={{24,-10},{44,10}})));
      Modelica.Blocks.Sources.Pulse pulse(
        period=3600,
        offset=1e5,
        width=1,
        amplitude=60)
        annotation (Placement(transformation(extent={{-142,-14},{-122,6}})));
      Valves.SimpleValve simpleValve(Kvs=2) annotation (Placement(
            transformation(
            extent={{-10,9},{10,-9}},
            rotation=90,
            origin={79,42})));
      Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{58,-10},{78,10}})));
      Modelica.Blocks.Continuous.LimPID PI(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=60,
        yMax=0.999,
        yMin=0) annotation (Placement(transformation(
            extent={{-6,6},{6,-6}},
            rotation=90,
            origin={100,12})));
      Modelica.Blocks.Sources.Constant const(k=273.15 + 70)
        annotation (Placement(transformation(extent={{84,-10},{90,-4}})));
      Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(
            extent={{-4,-4},{4,4}},
            rotation=90,
            origin={98,30})));
      Modelica.Blocks.Sources.Constant const1(k=1)
        annotation (Placement(transformation(extent={{82,22},{88,28}})));

    Modelica.SIunits.Conversions.NonSIunits.Energy_kWh Q_ges;
    equation
      der(Q_ges)=(solarThermal.volume.heatPort.Q_flow-fixedTemperature.port.Q_flow)/3.6e6;
      connect(fixedTemperature.port, storage.heatPort) annotation (Line(
          points={{-74,24},{-54,24}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(boundary_p.port_a, pump.port_a) annotation (Line(
          points={{-66,80},{-38,80},{-38,74}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(booleanExpression.y, pump.IsNight) annotation (Line(
          points={{-21,64},{-27.8,64}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(pump.port_b, storage.port_a_heatGenerator) annotation (Line(
          points={{-38,54},{-38,32.8},{-37.6,32.8}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_a, storage.port_b_heatGenerator) annotation (Line(
          points={{-34,0},{-38,0},{-38,16},{-37.6,16}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundary_ph2.port_a, storage.port_b_consumer) annotation (Line(
          points={{-62,46},{-46,46},{-46,34}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe1.port_b, storage.port_a_consumer) annotation (Line(
          points={{-48,-10},{-46,-10},{-46,14}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(tempAndRad.Rad,solarThermal. Irradiation) annotation (Line(
          points={{36,23.4},{36,10.8},{35,10.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(tempAndRad.T_out,solarThermal. T_air) annotation (Line(
          points={{28,23.4},{28,10.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pulse.y, boundary_ph1.p_in) annotation (Line(
          points={{-121,-4},{-114,-4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(simpleValve.port_b, pump.port_a) annotation (Line(
          points={{79,52},{78,52},{78,74},{-38,74}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(solarThermal.port_b, temperatureSensor.port_a) annotation (Line(
          points={{44,0},{58,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(solarThermal.port_a, pipe.port_b) annotation (Line(
          points={{24,0},{-14,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureSensor.port_b, simpleValve.port_a) annotation (Line(
          points={{78,0},{78,32},{79,32}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureSensor.signal, PI.u_m) annotation (Line(
          points={{68,10},{68,12},{92.8,12}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const.y, PI.u_s) annotation (Line(
          points={{90.3,-7},{100,-7},{100,4.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(PI.y, add.u2) annotation (Line(
          points={{100,18.6},{100,25.2},{100.4,25.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add.y, simpleValve.opening) annotation (Line(
          points={{98,34.4},{98,42},{86.2,42}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const1.y, add.u1) annotation (Line(
          points={{88.3,25},{92.15,25},{92.15,25.2},{95.6,25.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundary_ph1.port_a, pipe1.port_a) annotation (Line(
          points={{-92,-10},{-68,-10}},
          color={0,127,255},
          smooth=Smooth.None));

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=172800, Interval=60),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>This is a simple example of a storage and a solar collector.</p>
</html>", revisions="<html>
<p>13.12.2013, by <i>Sebastian Stinner</i>: implemented</p>
</html>"));
    end StorageSolarCollector;
  end Examples;

  package BaseClasses
    extends Modelica.Icons.BasesPackage;
    model Bouyancy
      outer BaseParameters baseParameters "System properties";
    parameter Modelica.SIunits.Area A=1;
    parameter Modelica.SIunits.RelativePressureCoefficient beta=350e-6;
    parameter Modelica.SIunits.Length dx=0.2;
    parameter Real kappa=0.4;

    Modelica.SIunits.TemperatureDifference dT;
    Modelica.SIunits.ThermalConductivity lambda_eff;

    parameter Modelica.SIunits.Acceleration g=baseParameters.g;
    parameter Modelica.SIunits.SpecificHeatCapacity cp=baseParameters.cp_Water;
    parameter Modelica.SIunits.ThermalConductivity lambda=baseParameters.lambda_Water;
    parameter Modelica.SIunits.Density rho=baseParameters.rho_Water;

    public
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
        annotation (Placement(transformation(extent={{-16,86},{4,106}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
        annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));
    equation
      dT=port_a.T-port_b.T;
      if dT>0 then
          lambda_eff=lambda;
      else
          lambda_eff=lambda+2/3*rho*cp*kappa*dx^2*sqrt(abs(-g*beta*dT/dx));
      end if;
      port_a.Q_flow=lambda_eff*A/dx*dT;
      port_a.Q_flow+port_b.Q_flow=0;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Bouyancy model for the heat transfer between the layers in a buffer storage.</p>
</html>", revisions="<html>
<p>13.12.2013, by <i>Sebastian Stinner</i>: implemented</p>
</html>"));
    end Bouyancy;
  end BaseClasses;
end Storage;
