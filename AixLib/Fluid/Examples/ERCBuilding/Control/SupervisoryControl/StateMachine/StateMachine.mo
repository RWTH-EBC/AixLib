within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl.StateMachine;
model StateMachine

////////////////////////////////////////////////////////////////////////////////
//Declarations//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  //Variables used by states, therefore declared as 'inner'
  inner Boolean mode( start=false);
  inner Boolean goToStart(start=false) = leaveOperationMode.goBackToStart;
  inner Boolean next(start=false)
    "'true'='move on to next cooling mode";
  inner Boolean changeMode(start=false) "'true'='change from a cooling mode to 
  the heating mode";
  inner Boolean transmit_HPCommand(start=false);
  inner Boolean measuring(start=true)
    "true if system is in mode 'Start' and thus measuring";
  inner Boolean switch = if sample_avColdStorageTemp.y > 273.15+25 then true else false
    "If true, there is a switch from heating to cooling mode but system remains in heating mode";
  inner Boolean hPState(start=false)
    "Indicator, if the controller is in any state that involves heat pump operation";
  inner Boolean heatingMode;
  inner Modelica.SIunits.MassFlowRate transmit_massFlowHK13P3(min=0, max=30, start=0);
  inner Modelica.SIunits.MassFlowRate transmit_massFlowHK13P1(start=0.001);
  inner Modelica.SIunits.MassFlowRate transmit_massFlowHK12P1(min=0, max=30, start=0);
  inner Modelica.SIunits.MassFlowRate transmit_massFlowHK12P2(min=0, max=30, start=0);
  inner Real transmit_openingHK13Y1(min=0,max=1, start=0.001);
  inner Real transmit_openingHK13Y2(min=0,max=1, start=0.001);
  inner Real transmit_openingHK13Y3(min=0,max=1, start=0.001);
  inner Real transmit_openingHK13K3(min=0,max=1, start=0.001);
  inner Real transmit_openingHK11Y1(min=0,max=1, start=0.001);
  inner Real transmit_openingHK11Y2(min=0,max=1, start=0.001);
  inner Real transmit_openingHK12Y2(min=0,max=1, start=0.001);
  inner Real transmit_openingHK12Y1(min=0,max=1, start=0.001);

  //Clock
  Modelica_Synchronous.ClockSignals.Clocks.PeriodicRealClock
    periodicClock1(period=30)
                             annotation (Placement(transformation(
          extent={{-88,64},{-76,76}})));

  //Temperature inputs
  Modelica.Blocks.Interfaces.RealInput outdoorTemperature(final unit="K", min=0, max=380,
    final quantity="ThermodynamicTemperature") annotation (
     Placement(transformation(extent={{-120,70},{-80,110}})));
  Modelica.Blocks.Interfaces.RealInput avHeatStorageTemp(final unit="K", min=0, max=380,
    final quantity="ThermodynamicTemperature") annotation (
      Placement(transformation(extent={{-120,30},{-80,70}})));
  Modelica.Blocks.Interfaces.RealInput upperAvTempStorage(final unit="K", min=0, max=380,
    final quantity="ThermodynamicTemperature") annotation (
     Placement(transformation(extent={{-120,-10},{-80,30}})));
  Modelica.Blocks.Interfaces.RealInput evapTemp(final unit="K", min=0, max=380,
    final quantity="ThermodynamicTemperature") annotation (Placement(
        transformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Interfaces.RealInput lowerTempStorage(final unit="K", min=0, max=380,
    final quantity="ThermodynamicTemperature") annotation (
      Placement(transformation(extent={{-120,-90},{-80,-50}})));
  Modelica.Blocks.Interfaces.RealInput GTFTempFlow(final unit="K", min=0, max=380,
    final quantity="ThermodynamicTemperature")
    "Flow temperature of the primary side of the geothermal field" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={70,100})));
         Modelica.Blocks.Interfaces.RealInput avColdStorageTemp(
                                                        final unit="K", min=0, max=380,
    final quantity="ThermodynamicTemperature") annotation (
      Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-46,100})));

  //Mode input

  //Sampling temperature inputs
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_outdoorTemperature
    annotation (Placement(transformation(extent={{-62,40},{-50,52}})));
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_avHeatStorageTemp
    annotation (Placement(transformation(extent={{-62,22},{-50,34}})));
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_upperAvTempStorage
    annotation (Placement(transformation(extent={{-62,4},{-50,16}})));
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_evapTemp
    annotation (Placement(transformation(extent={{-62,-36},{-50,-24}})));
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_lowerTempStorage
    annotation (Placement(transformation(extent={{-62,-76},{-50,-64}})));
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_GTFTempFlow
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={70,48})));
Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_avColdStorageTemp
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-46,70})));

 //Sampling time

  //Sampling mode input

  //Holding opening outputs
   Modelica_Synchronous.RealSignals.Sampler.Hold hold_massFlow
    annotation (Placement(transformation(extent={{154,86},{166,98}})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_openingHK13Y2
    annotation (Placement(transformation(extent={{154,44},{166,56}})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_openingHK13Y3
    annotation (Placement(transformation(extent={{152,2},{164,14}})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_openingHK13K3
    annotation (Placement(transformation(extent={{152,-46},{164,-34}})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_openingHK11Y1
    annotation (Placement(transformation(extent={{152,-64},{164,-52}})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_openingHK11Y2 annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={128,-70})));

  Modelica_Synchronous.RealSignals.Sampler.Hold hold_openingHK12Y2 annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={140,-70})));

  //Holding mass flwo outputs
   Modelica_Synchronous.RealSignals.Sampler.Hold hold_massFlowHK13P1
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={126,-48})));

 //Holding command output
  Modelica_Synchronous.BooleanSignals.Sampler.Hold hold_HPCommand annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={100,-74})));

  //Opening Outputs
  Modelica.Blocks.Interfaces.RealOutput openingHK13Y2(min=0, max=1)
    annotation (Placement(transformation(extent={{170,40},{190,60}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK13Y3(min=0, max=1)
    annotation (Placement(transformation(extent={{170,-2},{190,18}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK13K3(min=0, max=1)
    annotation (Placement(transformation(extent={{170,-50},{190,-30}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK11Y1(min=0, max=1)
    annotation (Placement(transformation(extent={{170,-68},{190,-48}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK11Y2(min=0, max=1) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={130,-100})));

         Modelica.Blocks.Interfaces.RealOutput openingHK12Y2(min=0, max=1) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={150,-100})));

  //Mass flow outputs
   Modelica.Blocks.Interfaces.RealOutput SwitchingUnitMassFlow(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(extent={{170,82},{190,102}})));
   Modelica.Blocks.Interfaces.RealOutput massFlowHK13P1(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-100})));

 //Command output
    Modelica.Blocks.Interfaces.BooleanOutput HPCommand
    "Command to heat pump, 'true' = 'on'" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,-100})));

////////////////////////////////////////////////////////////////////////////////
//States////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  //Start
  Start1 Start(volume_cold=5000, volume_heat=4000)
    annotation (Placement(transformation(extent={{-10,68},{10,88}})));
  block Start1

    outer output Boolean next;
    outer output Boolean mode;
    outer output Boolean transmit_HPCommand;
    outer output Boolean changeMode(start=false) "'true'='change from a cooling mode to 
  the heating mode and vice versa";
    outer output Boolean measuring;
    outer output Boolean hPState;
    outer output Boolean heatingMode;
    outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P1;
    outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P3;
    outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P1;
    outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P2;
    outer output Real transmit_openingHK13Y1;
    outer output Real transmit_openingHK13Y2;
    outer output Real transmit_openingHK13Y3;
    outer output Real transmit_openingHK13K3;
    outer output Real transmit_openingHK11Y1;
    outer output Real transmit_openingHK11Y2;
    outer output Real transmit_openingHK12Y2;
    outer output Real transmit_openingHK12Y1;

    parameter Real volume_cold = 5000 "volume of the cold storage";
    parameter Real volume_heat = 4000 "volume of the heat storage";

    Modelica.Blocks.Sources.RealExpression realExpression(y=
          avColdStorageTemp*volume_cold)
      annotation (Placement(transformation(extent={{-88,6},{-68,26}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=avHeatStorageTemp*
          volume_heat)
      annotation (Placement(transformation(extent={{-88,-22},{-68,-2}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{48,-6},{60,6}})));
      Modelica.Blocks.Interfaces.BooleanOutput modeOutput
      "The actual current operation mode, 'heating mode == false'"
                                            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={102,0})));
           Modelica.Blocks.Interfaces.RealInput avColdStorageTemp(
                                                          final unit="K", min=0, max=380,
      final quantity="ThermodynamicTemperature") annotation (
        Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-100,50})));
    Modelica.Blocks.Interfaces.RealInput avHeatStorageTemp(final unit="K", min=0, max=380,
      final quantity="ThermodynamicTemperature") annotation (
        Placement(transformation(extent={{-120,-70},{-80,-30}})));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=300)
      annotation (Placement(transformation(extent={{-46,28},{-30,44}})));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay1(delayTime=300)
      annotation (Placement(transformation(extent={{-44,-42},{-28,-26}})));
    Modelica.Blocks.Math.Add add1(k1=+1, k2=-1)
      annotation (Placement(transformation(extent={{-14,14},{2,30}})));
    Modelica.Blocks.Math.Add add2(k1=-1, k2=+1)
      annotation (Placement(transformation(extent={{-14,-25},{2,-9}})));
    Modelica.Blocks.Logical.LessThreshold coolingMode
      annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  equation
    mode = coolingMode.y;
    next = false;
    transmit_HPCommand = false;
    changeMode=false;
    measuring = true;
    hPState = false;
    heatingMode = false;

    transmit_massFlowHK13P1=0.001;
    transmit_massFlowHK13P3=0.001;
    transmit_massFlowHK12P1 = 0.001;
    transmit_massFlowHK12P2 = 0.001;
    transmit_openingHK13Y1=0.001;
    transmit_openingHK13Y2 = 0.001;
    transmit_openingHK13Y3= 0.999;
    transmit_openingHK13K3= 0.001;
    transmit_openingHK11Y1= 0.001;
    transmit_openingHK11Y2 = 0.001;
    transmit_openingHK12Y2 = 0.999;
    transmit_openingHK12Y1 = 0.001;

    connect(realExpression.y, add1.u2) annotation (Line(points={{-67,16},
            {-15.6,16},{-15.6,17.2}}, color={0,0,127}));
    connect(realExpression.y, fixedDelay.u) annotation (Line(points={{
            -67,16},{-60,16},{-60,36},{-47.6,36}}, color={0,0,127}));
    connect(fixedDelay.y, add1.u1) annotation (Line(points={{-29.2,36},
            {-20,36},{-20,26.8},{-15.6,26.8}}, color={0,0,127}));
    connect(realExpression1.y, add2.u1) annotation (Line(points={{-67,
            -12},{-15.6,-12},{-15.6,-12.2}}, color={0,0,127}));
    connect(fixedDelay1.y, add2.u2) annotation (Line(points={{-27.2,-34},
            {-20,-34},{-20,-21.8},{-15.6,-21.8}}, color={0,0,127}));
    connect(realExpression1.y, fixedDelay1.u) annotation (Line(points={
            {-67,-12},{-62,-12},{-58,-12},{-58,-34},{-45.6,-34}}, color=
           {0,0,127}));
    connect(add.y, coolingMode.u)
      annotation (Line(points={{60.6,0},{66,0}}, color={0,0,127}));
    connect(modeOutput, coolingMode.y)
      annotation (Line(points={{102,0},{89,0}}, color={255,0,255}));
    connect(add1.y, add.u1) annotation (Line(points={{2.8,22},{24,22},{
            24,3.6},{46.8,3.6}}, color={0,0,127}));
    connect(add2.y, add.u2) annotation (Line(points={{2.8,-17},{24.4,
            -17},{24.4,-3.6},{46.8,-3.6}}, color={0,0,127}));
    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
              graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true,
      Documentation(info="<html>In these subsystem the differentiation between heating and cooling
demand is made. Every Simulation starts with this procedure. When the
condition to end a mode is satisfied while the simulation is running
the measuring is replayed.
</html>"));
  end Start1;
  Modelica.Blocks.Interfaces.RealInput LTCFlowTemp(
    final unit="K",
    min=0,
    max=380,
    final quantity="ThermodynamicTemperature")
    "Flow temperature of the primary side of the geothermal field"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={106,100})));
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_LTCFlowTemp
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={106,70})));
  Modelica.Blocks.Interfaces.IntegerOutput HECommand(min=0,max=3)
    "'2'='HE on', '1'='HE Stand-By', '0'='HE off'"                annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={26,102})));
  Modelica_Synchronous.IntegerSignals.Sampler.Hold hold_HECommand
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={56,18})));
  LeaveOperationMode leaveOperationMode
    annotation (Placement(transformation(extent={{-64,-100},{-44,-80}})));

  Modelica.Blocks.Interfaces.RealInput GTFTempReturn(
    final unit="K",
    min=0,
    max=380,
    final quantity="ThermodynamicTemperature")
    "Flow temperature of the primary side of the geothermal field"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={46,100})));
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_GTFTempReturn
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={46,48})));
  Count count annotation (Placement(transformation(extent={{-42,-35},{-26,-19}})));
         Modelica.Blocks.Interfaces.RealOutput openingHK12Y1(min=0, max=1) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-100})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_openingHK12Y1 annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={20,-84})));
   Modelica.Blocks.Interfaces.RealOutput massFlowHK12P1(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-2,-100})));
   Modelica.Blocks.Interfaces.RealOutput massFlowHK12P2(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,-100})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_massFlowHK12P2 annotation (
     Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-26,-80})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_massFlowHK12P1 annotation (
     Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-2,-80})));
  Modelica_Synchronous.RealSignals.Sampler.Hold hold_openingHK13Y1
    annotation (Placement(transformation(extent={{152,-20},{164,-8}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK13Y1(min=0, max=1)
    annotation (Placement(transformation(extent={{170,-24},{190,-4}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.5)
    annotation (Placement(transformation(extent={{-66,-6},{-58,2}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=
        transmit_massFlowHK13P1)
    annotation (Placement(transformation(extent={{-100,-18},{-80,2}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{-54,-7},{-44,3}})));
    Modelica.Blocks.Interfaces.BooleanOutput output_measuring
    "Command to heat pump, 'true' = 'on'" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-84,-102})));
  Modelica_Synchronous.BooleanSignals.Sampler.Hold hold_measuring annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-84,-86})));
  Count count_measuring
    annotation (Placement(transformation(extent={{-46,-61},{-30,-45}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=measuring)
    annotation (Placement(transformation(extent={{-100,-58},{-80,-38}})));
    Modelica.Blocks.Interfaces.BooleanOutput modeOutput
    "The actual current operation mode, 'heating mode == false'"
                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={182,72})));
  Modelica_Synchronous.BooleanSignals.Sampler.Hold hold_mode annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={158,72})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=hPState)
    annotation (Placement(transformation(extent={{-92,-70},{-72,-50}})));
    Modelica.Blocks.Interfaces.BooleanOutput active_state[6] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={190,-79})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=
        activeState(Start))
    annotation (Placement(transformation(extent={{150,-70},{162,-60}})));
  Modelica_Synchronous.BooleanSignals.Sampler.Hold hold_activeState[6]
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={174,-79})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=
        activeState(coolingMode1))
    annotation (Placement(transformation(extent={{150,-76},{162,-66}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=
        activeState(coolingMode2_1))
    annotation (Placement(transformation(extent={{150,-82},{162,-72}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression5(y=
        activeState(coolingMode2_2))
    annotation (Placement(transformation(extent={{150,-88},{162,-78}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression6(y=
        activeState(coolingMode3_1))
    annotation (Placement(transformation(extent={{158,-96},{170,-86}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression7(y=
        activeState(heatingMode1))
    annotation (Placement(transformation(extent={{166,-102},{178,-92}})));
  Modelica.Blocks.Interfaces.BooleanInput HPComand1
    "Command to heat pump, 'true' = 'on'"
    annotation (Placement(transformation(extent={{-120,12},{-80,52}})));
equation
 initialState(Start) annotation (Line(
      points={{0,90},{0,96}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier,
      arrow={Arrow.Filled,Arrow.None}));
  transition( Start,
              heatingMode1,mode == false and count_measuring.Time > 310,
                                         immediate=false,
                                                        reset=false,
                                                                   synchronize=false,
    priority=1)              annotation (Line(
      points={{6,66},{6,58},{148,58},{148,44}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,-4},{-4,-10}},
      lineColor={95,95,95},
      fontSize=1,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  transition(Start,coolingMode1,mode and count_measuring.Time > 310,
              immediate=false,
              priority=2,reset=false,
                                    synchronize=false)
                          annotation (Line(
      points={{0,66},{0,46}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,-4},{-4,-10}},
      lineColor={95,95,95},
      fontSize=1,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));

  //Heating mode 1
public
  HeatingMode1 heatingMode1
    annotation (Placement(transformation(extent={{136,22},{156,42}})));
    block HeatingMode1

      outer output Boolean next;
      outer output Boolean mode;
      outer output Boolean transmit_HPCommand;
      outer output Boolean changeMode(start=false) "'true'='change from a cooling mode to 
  the heating mode and vice versa";
      outer output Boolean measuring;
      outer output Boolean hPState;
      outer output Boolean heatingMode;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P3;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P2;
      outer output Real transmit_openingHK13Y1;
      outer output Real transmit_openingHK13Y2;
      outer output Real transmit_openingHK13Y3;
      outer output Real transmit_openingHK13K3;
      outer output Real transmit_openingHK11Y1;
      outer output Real transmit_openingHK11Y2;
      outer output Real transmit_openingHK12Y2;
      outer output Real transmit_openingHK12Y1;

    Modelica.Blocks.Logical.LessThreshold storageTooCold(threshold=273.15
           + 30.5)
      annotation (Placement(transformation(extent={{-70,70},{-58,82}})));
    Modelica.Blocks.Logical.GreaterThreshold storageTooWarm(threshold=
          273.15 + 35) annotation (Placement(transformation(extent={{-72,26},{-60,
              38}})));
    Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop
      annotation (Placement(transformation(extent={{-32,28},{-12,48}})));
    Modelica.Blocks.Logical.And HPShouldBeOn
        annotation (Placement(transformation(extent={{-2,39},{8,49}})));
    Modelica.Blocks.Interfaces.RealInput upperAvTempStorage
      annotation (Placement(transformation(extent={{-120,56},{-80,96}})));
    Modelica.Blocks.Interfaces.RealInput lowerTempStorage annotation (
       Placement(transformation(extent={{-120,12},{-80,52}})));
    Modelica.Blocks.Interfaces.RealInput evapTemp annotation (
        Placement(transformation(extent={{-120,-70},{-80,-30}})));
    Modelica.Blocks.Interfaces.RealInput GTFTempFlow(                              final unit="K", min=0, max=380,
      final quantity="ThermodynamicTemperature")
      "Flow temperature of the primary side of the geothermal field" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-100,-90})));
    Modelica.Blocks.Logical.GreaterThreshold GTFWarmEnough(threshold=273.15 + 7)
      annotation (Placement(transformation(extent={{-70,-96},{-58,-84}})));
      Modelica.Blocks.Interfaces.RealInput avColdStorageTemp(
                                                            final unit="K", min=0, max=380,
        final quantity="ThermodynamicTemperature") annotation (
          Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-100,-8})));
      Modelica.Blocks.Logical.Greater GFWarmerColdStor
        annotation (Placement(transformation(extent={{-44,-62},{-32,-74}})));
    Modelica.Blocks.Logical.LessThreshold    storageColdEnough(threshold=273.15 + 12)
        annotation (Placement(transformation(extent={{-44,-14},{-32,-2}})));
    Modelica.Blocks.Logical.And and2
      annotation (Placement(transformation(extent={{-20,-35},{-10,-25}})));
    Modelica.Blocks.Logical.And and3
      annotation (Placement(transformation(extent={{-20,-81},{-10,-71}})));
    Modelica.Blocks.Logical.And and4
        annotation (Placement(transformation(extent={{2,-57},{12,-47}})));
    Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop2
        annotation (Placement(transformation(extent={{40,-68},{60,-48}})));
      Modelica.Blocks.Math.Add DiffGFColdStor(k1=-1)
        annotation (Placement(transformation(extent={{-66,2},{-54,14}})));
    Modelica.Blocks.Logical.LessThreshold    GFColdStorEqual(threshold=0.5)
        annotation (Placement(transformation(extent={{-44,2},{-32,14}})));
    Modelica.Blocks.Interfaces.RealInput LTCFlowTemp annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-22,100})));
      Modelica.Blocks.Interfaces.IntegerOutput HECommand(min=0,max=3)
      "'2'='HE on', '1'='HE Stand-By', '0'='HE off'"                  annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={70,-100})));
    Modelica.Blocks.Logical.Hysteresis HEShouldBeOn(uLow=273.15 + 26, uHigh=
         273.15 + 27)      annotation (Placement(transformation(
            extent={{32,40},{44,52}})));
    Modelica.Blocks.Logical.Not not1 annotation (Placement(
          transformation(extent={{50,40},{62,52}})));
    Modelica.Blocks.Math.BooleanToInteger booleanToInteger
      annotation (Placement(transformation(extent={{68,40},{80,52}})));
    Modelica.Blocks.Interfaces.RealInput Time annotation (Placement(
          transformation(extent={{-20,-20},{20,20}},
            rotation=90,
            origin={8,-100})));
      Modelica.Blocks.Logical.Or GFShouldBeOn
        annotation (Placement(transformation(extent={{80,-62},{100,-42}})));
      Modelica.Blocks.Logical.LessThreshold timeShortEnough(threshold=120)
        annotation (Placement(transformation(extent={{24,-84},{34,-74}})));
    Modelica.Blocks.Logical.Pre pre1
      annotation (Placement(transformation(extent={{50,-84},{60,-74}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(
        threshold=6.5)
      annotation (Placement(transformation(extent={{-68,-58},{-48,-38}})));
    equation

      measuring = false;

      hPState = true;

      mode = false;

      heatingMode = true;

      changeMode=false;

    next = false;
    transmit_HPCommand = HPShouldBeOn.y;

    //   if storageColdEnough.y == false then

    //   changeMode=true;

    //else

      //changeMode=false;

    //end if;

    if GFShouldBeOn.y then

      transmit_massFlowHK13P1=10;

    else

      transmit_massFlowHK13P1=0.001;

    end if;

    if HPShouldBeOn.y then

      transmit_massFlowHK13P3=8;
      transmit_massFlowHK12P1 = 14;
      transmit_massFlowHK12P2 = 10;
      transmit_openingHK13Y1=0.999;
      transmit_openingHK13Y2=0.001;
      transmit_openingHK13Y3=0.999;
      transmit_openingHK13K3=0.999;
      transmit_openingHK11Y1=0.001;
      transmit_openingHK11Y2=0.001;
      transmit_openingHK12Y2 = 0.999;
      transmit_openingHK12Y1 = 0.999;

    else

      transmit_massFlowHK13P3=0.001;
      transmit_massFlowHK12P1 = 0.001;
      transmit_massFlowHK12P2 = 0.001;
      transmit_openingHK13Y1=0.001;
      transmit_openingHK13Y2=0.001;
      transmit_openingHK13Y3=0.001;
      transmit_openingHK13K3=0.001;
      transmit_openingHK11Y1=0.001;
      transmit_openingHK11Y2=0.001;
      transmit_openingHK12Y2 = 0.001;
      transmit_openingHK12Y1 = 0.001;

    end if;

    connect(storageTooCold.y, rSFlipFlop.S) annotation (Line(
        points={{-57.4,76},{-40,76},{-40,44},{-34,44}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(storageTooWarm.y,rSFlipFlop. R) annotation (Line(
        points={{-59.4,32},{-34,32}},
        color={255,0,255},
        smooth=Smooth.None));
      connect(rSFlipFlop.Q, HPShouldBeOn.u1) annotation (Line(
          points={{-11,44},{-3,44}},
          color={255,0,255},
          smooth=Smooth.None));
    connect(upperAvTempStorage, storageTooCold.u) annotation (Line(
        points={{-100,76},{-71.2,76}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lowerTempStorage,storageTooWarm. u) annotation (Line(
        points={{-100,32},{-73.2,32}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(GTFTempFlow, GTFWarmEnough.u) annotation (Line(
        points={{-100,-90},{-71.2,-90}},
        color={0,0,127},
        smooth=Smooth.None));
      connect(GTFTempFlow, GFWarmerColdStor.u1) annotation (Line(
          points={{-100,-90},{-78,-90},{-78,-68},{-45.2,-68}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(avColdStorageTemp, GFWarmerColdStor.u2) annotation (Line(
          points={{-100,-8},{-76,-8},{-76,-63.2},{-45.2,-63.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(avColdStorageTemp, storageColdEnough.u) annotation (Line(
          points={{-100,-8},{-45.2,-8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(GFWarmerColdStor.y, and2.u2) annotation (Line(
          points={{-31.4,-68},{-26,-68},{-26,-34},{-21,-34}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(storageColdEnough.y, and2.u1) annotation (Line(
          points={{-31.4,-8},{-26,-8},{-26,-30},{-21,-30}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(GFWarmerColdStor.y, and3.u1) annotation (Line(
          points={{-31.4,-68},{-26,-68},{-26,-76},{-21,-76}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(GTFWarmEnough.y, and3.u2) annotation (Line(
          points={{-57.4,-90},{-48,-90},{-48,-80},{-21,-80}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(and2.y, and4.u1) annotation (Line(
          points={{-9.5,-30},{-2,-30},{-2,-52},{1,-52}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(and3.y, and4.u2) annotation (Line(
          points={{-9.5,-76},{-2,-76},{-2,-56},{1,-56}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(and4.y, rSFlipFlop2.S) annotation (Line(
          points={{12.5,-52},{38,-52}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(avColdStorageTemp, DiffGFColdStor.u1) annotation (Line(
          points={{-100,-8},{-78,-8},{-78,11.6},{-67.2,11.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(GTFTempFlow, DiffGFColdStor.u2) annotation (Line(
          points={{-100,-90},{-78,-90},{-78,-34},{-72,-34},{-72,4.4},{-67.2,4.4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(DiffGFColdStor.y, GFColdStorEqual.u) annotation (Line(
          points={{-53.4,8},{-45.2,8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(GFColdStorEqual.y, rSFlipFlop2.R) annotation (Line(
          points={{-31.4,8},{20,8},{20,-64},{38,-64}},
          color={255,0,255},
          smooth=Smooth.None));
    connect(HEShouldBeOn.y, not1.u) annotation (Line(
        points={{44.6,46},{48.8,46}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.y, booleanToInteger.u) annotation (Line(
        points={{62.6,46},{66.8,46}},
        color={255,0,255},
        smooth=Smooth.None));
      connect(rSFlipFlop2.Q, GFShouldBeOn.u1) annotation (Line(points={{61,-52},{67.5,
              -52},{78,-52}}, color={255,0,255}));
      connect(Time, timeShortEnough.u) annotation (Line(points={{8,-100},{8,-100},{8,
              -79},{23,-79}}, color={0,0,127}));
    connect(timeShortEnough.y, pre1.u) annotation (Line(points={{34.5,-79},{45,-79},
              {49,-79}},                color={255,0,255}));
    connect(pre1.y, GFShouldBeOn.u2) annotation (Line(points={{60.5,-79},{
            72,-79},{72,-60},{78,-60}}, color={255,0,255}));
    connect(LTCFlowTemp, HEShouldBeOn.u) annotation (Line(points={{-22,100},
            {-22,60},{22,60},{22,46},{30.8,46},{30.8,46}}, color={0,0,127}));
    connect(booleanToInteger.y, HECommand) annotation (Line(points={{80.6,46},
            {86,46},{86,24},{70,24},{70,-100}},
                                              color={255,127,0}));
    connect(evapTemp, greaterEqualThreshold.u) annotation (Line(points={{-100,-50},
            {-86,-50},{-86,-48},{-70,-48}}, color={0,0,127}));
    connect(greaterEqualThreshold.y, HPShouldBeOn.u2) annotation (Line(points={{
            -47,-48},{-6,-48},{-6,40},{-3,40}}, color={255,0,255}));
    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),                 graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true,
      Documentation(info="<html>If the heatingmode is activated the heatpump will work in heating mode.
It starts when the mean temperature of the upper temperaturesensors in
the hotstorage sinks below a certain value. The heatpump is active
until a bordertemperature at the lowest temperature sensor is reached.
As Source for the heatpump the cold storage and the geothermal field
are used. If the temperature of the geothermic field is to low it is
deactivated and only waste heat from the building is used. The
geothermic field can be used as source if it's flow temperature is
above 7 degree Celcius and if the flow temperature is higher than the
mean tmperature of the coldstorage. Is one of these border conditions
violated the geothermal field is turned off. Decreases the flow
temperature of the evaporator lower than 6.5 degree Celsius the
heatpump is deactivated for safety reasons. The following picture shows
the valve and damper positions in these mode.
<p>
  <img src=
  \"modelica://ExergyBasedControl/Subsystems/LTC_CC/PlanHeatingMode1.jpg\"
  alt=\"1\">
</p>
</html>"));
    end HeatingMode1;
equation
    transition(
    heatingMode1,
    Start,goToStart,
    immediate=false,
    reset=false,
    synchronize=false,
    priority=2) annotation (Line(
      points={{142,20},{142,10},{118,10},{118,84},{12,84}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,-4},{-4,-10}},
      lineColor={95,95,95},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));

  //Cooling mode 1
public
 CoolingMode1 coolingMode1 annotation (Placement(transformation(
          extent={{-10,24},{10,44}})));
    block CoolingMode1

      outer output Boolean next;
      outer output Boolean mode;
      outer output Boolean transmit_HPCommand;
      outer output Boolean changeMode(start=false) "'true'='change from a cooling mode to 
  the heating mode and vice versa";
      outer output Boolean measuring;
      outer output Boolean hPState;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P3;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P2;
      outer output Real transmit_openingHK13Y1;
      outer output Real transmit_openingHK13Y2;
      outer output Real transmit_openingHK13Y3;
      outer output Real transmit_openingHK13K3;
      outer output Real transmit_openingHK11Y1;
      outer output Real transmit_openingHK11Y2;
      outer output Real transmit_openingHK12Y2;
      outer output Real transmit_openingHK12Y1;

    Modelica.Blocks.Logical.Not not2 annotation (Placement(
          transformation(extent={{-8,36},{0,44}})));
    Modelica.Blocks.Logical.Hysteresis noHeatDemand(uLow=273.15 + 28, uHigh=273.15 +
            29) annotation (Placement(transformation(extent={{-12,6},{2,
              20}})));
    Modelica.Blocks.Logical.And freeCoolingGlycolOK
        annotation (Placement(transformation(extent={{10,21},{20,30}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=273.15 + 8,
        uHigh=273.15 + 10) annotation (Placement(transformation(
            extent={{-28,33},{-14,47}})));

    Modelica.Blocks.Interfaces.RealInput avHeatStorageTemp(
      final unit="K",
      min=0,
      max=380,
      final quantity="ThermodynamicTemperature") annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-100,13})));
    Modelica.Blocks.Interfaces.RealInput outdoorTemperature(
      final unit="K",
      min=0,
      max=380,
      final quantity="ThermodynamicTemperature")
      "Flow temperature of the primary side of the geothermal field"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-100,40})));
    equation

      measuring = false;
      hPState = false;

      mode = true;

        transmit_HPCommand = false;

      transmit_massFlowHK13P1=0.001;

      //The hysterisis indicates that there is a heat demand in the building
      //(average storage temperature < 30 °C). So the mode is changed to heat mode.
      if noHeatDemand.y then

        changeMode = false;

      else

        changeMode = true;

      end if;

      if freeCoolingGlycolOK.y then

        next = false;
        transmit_massFlowHK13P3=0.001;
        transmit_massFlowHK12P1 = 0.001;
        transmit_massFlowHK12P2 = 0.001;
        transmit_openingHK13Y1=0.001;
        transmit_openingHK13Y2 = 0.001;
        transmit_openingHK13Y3= 1;
        transmit_openingHK13K3= 0.001;
        transmit_openingHK11Y1= 0.001;
        transmit_openingHK11Y2 = 1;
        transmit_openingHK12Y2 = 0.001;
        transmit_openingHK12Y1 = 0.001;

      else

        next = true;
        transmit_massFlowHK13P3=0.001;
        transmit_massFlowHK12P1 = 0.001;
        transmit_massFlowHK12P2 = 0.001;
        transmit_openingHK13Y1=0.001;
        transmit_openingHK13Y2 = 0.001;
        transmit_openingHK13Y3= 0.001;
        transmit_openingHK13K3= 0.001;
        transmit_openingHK11Y1= 0.001;
        transmit_openingHK11Y2 = 0.001;
        transmit_openingHK12Y2 = 0.001;
        transmit_openingHK12Y1 = 0.001;

      end if;

    connect(hysteresis1.y, not2.u) annotation (Line(
        points={{-13.3,40},{-8.8,40}},
        color={255,0,255},
        smooth=Smooth.None));
      connect(not2.y, freeCoolingGlycolOK.u1) annotation (Line(
          points={{0.4,40},{4,40},{4,25.5},{9,25.5}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(noHeatDemand.y, freeCoolingGlycolOK.u2) annotation (Line(
          points={{2.7,13},{4,13},{4,21.9},{9,21.9}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(noHeatDemand.u, avHeatStorageTemp) annotation (Line(
          points={{-13.4,13},{-100,13}},
          color={0,0,127},
          smooth=Smooth.None));
    connect(hysteresis1.u, outdoorTemperature) annotation (Line(
        points={{-29.4,40},{-100,40}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
              graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10), Text(
            extent={{-62,94},{72,84}},
            lineColor={28,108,200},
            textString="Free cooling using the glycol cooler")}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true,
        Documentation(info="<html><p>
  If the cooling demand prevails the first checked cooling mode is the
  freecooling using the glycol cooler. Necessary for these mode is an
  outdoor temperature below 8 degree Celsius. A hysteresis is
  implemented which alows the freecooler to be activated until 10
  degree Celsius are reached. An additional Condition for using the
  freecooling is that ther is no heatdemand in the building. These
  cindition is proved by checkin the mean temperature of the heat
  storage. If it is getting to low the freecooling will be terminate
  and the heatpump is started in heating mode, until a set temperature
  is reached. After that 'switching mode' the freecooling is continued.
  The following picture shows the valve and damper positions in these
  mode.
</p>
<p>
  <img src=
  \"modelica://ExergyBasedControl/Subsystems/LTC_CC/PlanCoolingMode1.jpg\"
  alt=\"1\">
</p>
</html>"));
    end CoolingMode1;
equation
  transition(
    coolingMode1,
    coolingMode2_1,next,
    immediate=false,reset=false,synchronize=false,priority=2)
                     annotation (Line(
      points={{0,22},{0,0}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,-4},{-4,-10}},
      lineColor={95,95,95},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));

  //Cooling mode 2_1
public
   CoolingMode2_1 coolingMode2_1
    annotation (Placement(transformation(extent={{-10,-22},{10,-2}})));
    block CoolingMode2_1

      outer output Boolean next;
      outer output Boolean mode;
      outer output Boolean transmit_HPCommand;
      outer output Boolean changeMode(start=false) "'true'='change from a cooling mode to 
  the heating mode and vice versa";
      outer output Boolean measuring;
      outer output Boolean hPState;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P3;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P2;
      outer output Real transmit_openingHK13Y1;
      outer output Real transmit_openingHK13Y2;
      outer output Real transmit_openingHK13Y3;
      outer output Real transmit_openingHK13K3;
      outer output Real transmit_openingHK11Y1;
      outer output Real transmit_openingHK11Y2;
      outer output Real transmit_openingHK12Y2;
      outer output Real transmit_openingHK12Y1;

      Modelica.Blocks.Logical.Or OR
        annotation (Placement(transformation(extent={{80,12},{94,26}})));
    Modelica.Blocks.Interfaces.RealInput GTFTempFlow(                              final unit="K", min=0, max=380,
      final quantity="ThermodynamicTemperature")
      "Flow temperature of the primary side of the geothermal field" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-100,0})));
    Modelica.Blocks.Interfaces.RealInput avHeatStorageTemp(
        final unit="K",
        min=0,
        max=380,
        final quantity="ThermodynamicTemperature") annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-100,49})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=120)
        annotation (Placement(transformation(extent={{-9,-39},{5,-25}})));
      Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=180)
        annotation (Placement(transformation(extent={{-1,24},{13,38}})));
      Modelica.Blocks.Interfaces.RealInput GTFTempReturn(
        final unit="K",
        min=0,
        max=380,
        final quantity="ThermodynamicTemperature")
      "Flow temperature of the primary side of the geothermal field"   annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-100,-50})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=273.15 +
            17) annotation (Placement(transformation(extent={{-60,-7},{-46,7}})));
      Modelica.Blocks.Logical.LessThreshold greaterThreshold2(threshold=0.5)
        annotation (Placement(transformation(extent={{-60,-29},{-46,-15}})));
      Modelica.Blocks.Logical.And and1
        annotation (Placement(transformation(extent={{-4,-16},{10,-2}})));
      Modelica.Blocks.Logical.Not not1
        annotation (Placement(transformation(extent={{23,-16},{37,-2}})));
      Modelica.Blocks.Logical.And and2
        annotation (Placement(transformation(extent={{46,-4},{60,10}})));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{-82,-28},{-70,-16}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 28,
        uHigh=273.15 + 29) annotation (Placement(transformation(
            extent={{-72,42},{-58,56}})));
      Modelica.Blocks.Logical.And GFShouldBeOn
        annotation (Placement(transformation(extent={{80,42},{94,56}})));
      Modelica.Blocks.Logical.LessThreshold lowerThreshold2(threshold=273.15 + 12)
      annotation (Placement(transformation(extent={{-60,-55},{-46,-41}})));
    Modelica.Blocks.Interfaces.RealInput Time annotation (Placement(
          transformation(extent={{-120,-110},{-80,-70}})));
      Modelica.Blocks.Logical.And coldEnoughForBoth
      annotation (Placement(transformation(extent={{-36,-55},{-22,-41}})));
    equation

      measuring = false;

      hPState = false;

      mode = true;

    transmit_HPCommand = false;

    //The hysterisis indicates that there is a heat demand in the building
    //(average storage temperature < 30 °C). So the mode is changed to heat mode.
    if hysteresis.y then

      changeMode = false;

      if GFShouldBeOn.y then

        transmit_massFlowHK13P1 = 16;

        //If the flow temperature is low enough for both types of cold consumers,
        //the valve is opened
        if coldEnoughForBoth.y then
          next = false;
          transmit_openingHK13Y3 = 1;

        else
          next = true;
          transmit_openingHK13Y3 = 0.001;

        end if;

        transmit_massFlowHK13P3 = 0.001;
        transmit_massFlowHK12P1 = 0.001;
        transmit_massFlowHK12P2 = 0.001;
        transmit_openingHK13Y1 = 1;
        transmit_openingHK13Y2 = 1;
        transmit_openingHK13K3 = 0.001;
        transmit_openingHK11Y1 = 0.001;
        transmit_openingHK11Y2 = 0.001;
        transmit_openingHK12Y2 = 0.001;
        transmit_openingHK12Y1 = 0.001;

      else

        next = true;
        transmit_massFlowHK13P1 = 0.001;

        transmit_massFlowHK13P3 = 0.001;
        transmit_massFlowHK12P1 = 0.001;
        transmit_massFlowHK12P2 = 0.001;
        transmit_openingHK13Y1 = 0.001;
        transmit_openingHK13Y2 = 0.001;
        transmit_openingHK13Y3 = 0.001;
        transmit_openingHK13K3 = 0.001;
        transmit_openingHK11Y1 = 0.001;
        transmit_openingHK11Y2 = 0.001;
        transmit_openingHK12Y2 = 0.001;
        transmit_openingHK12Y1 = 0.001;

      end if;

    else

      next = true;
      transmit_massFlowHK13P1 = 0.001;

      transmit_massFlowHK13P3 = 0.001;
      transmit_massFlowHK12P1 = 0.001;
      transmit_massFlowHK12P2 = 0.001;
      transmit_openingHK13Y1 = 0.001;
      transmit_openingHK13Y2 = 0.001;
      transmit_openingHK13Y3 = 0.001;
      transmit_openingHK13K3 = 0.001;
      transmit_openingHK11Y1 = 0.001;
      transmit_openingHK11Y2 = 0.001;
      transmit_openingHK12Y2 = 0.001;
      transmit_openingHK12Y1 = 0.001;

      changeMode = true;

    end if;

      connect(GTFTempFlow, greaterThreshold1.u) annotation (Line(
          points={{-100,0},{-61.4,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(greaterThreshold1.y, and1.u1) annotation (Line(
          points={{-45.3,0},{-40,0},{-40,-9},{-5.4,-9}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(greaterThreshold2.y, and1.u2) annotation (Line(
          points={{-45.3,-22},{-40,-22},{-40,-14.6},{-5.4,-14.6}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(and1.y, not1.u) annotation (Line(
          points={{10.7,-9},{21.6,-9}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(greaterThreshold.y, and2.u1) annotation (Line(
          points={{5.7,-32},{16,-32},{16,3},{44.6,3}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(not1.y, and2.u2) annotation (Line(
          points={{37.7,-9},{38,-9},{38,-2.6},{44.6,-2.6}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(and2.y, OR.u2) annotation (Line(
          points={{60.7,3},{70,3},{70,13.4},{78.6,13.4}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(GTFTempFlow, add.u1) annotation (Line(
          points={{-100,0},{-88,0},{-88,-18.4},{-83.2,-18.4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add.y, greaterThreshold2.u) annotation (Line(
          points={{-69.4,-22},{-61.4,-22}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(GTFTempReturn, add.u2) annotation (Line(
          points={{-100,-50},{-88,-50},{-88,-26},{-84,-26},{-84,-25.6},{-83.2,-25.6}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(avHeatStorageTemp, hysteresis.u) annotation (Line(
          points={{-100,49},{-73.4,49}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(OR.y, GFShouldBeOn.u2) annotation (Line(
          points={{94.7,19},{98,19},{98,34},{74,34},{74,43.4},{78.6,43.4}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(hysteresis.y, GFShouldBeOn.u1) annotation (Line(
          points={{-57.3,49},{78.6,49}},
          color={255,0,255},
          smooth=Smooth.None));
    connect(GTFTempFlow, lowerThreshold2.u) annotation (Line(
        points={{-100,0},{-66,0},{-66,-48},{-61.4,-48}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Time, lessThreshold.u) annotation (Line(
        points={{-100,-90},{-18,-90},{-18,31},{-2.4,31}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Time, greaterThreshold.u) annotation (Line(
        points={{-100,-90},{-18,-90},{-18,-32},{-10.4,-32}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lowerThreshold2.y, coldEnoughForBoth.u1) annotation (Line(points={{-45.3,
            -48},{-42,-48},{-37.4,-48}}, color={255,0,255}));
    connect(greaterThreshold.y, coldEnoughForBoth.u2) annotation (Line(points={{
            5.7,-32},{10,-32},{16,-32},{16,-64},{-42,-64},{-42,-53.6},{-37.4,-53.6}},
          color={255,0,255}));
    connect(lessThreshold.y, OR.u1) annotation (Line(points={{13.7,31},{72,
            31},{72,19},{78.6,19}}, color={255,0,255}));
    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
              graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10), Text(
              extent={{-60,92},{74,82}},
              lineColor={28,108,200},
              textString="Free cooling using the geothermal field")}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true,
      Documentation(info="<html><p>
  If a freecooling using the glycol cooler is not possible the
  freecooling using the geothermic field (CoolingMode2_1) ist checked.
  The field can be used for cooling if the flow temperature is below 12
  degree Celsius and the delta Temperature between flow and return is
  bigger than 0.5 degree Celsius. Since no heating energy is generated
  in this case it is checked that there is no heatdemand by checking
  the mean temperature of the hotstorage. If there is heatdemand at the
  run time of CoolingMode2_1 the freecooling is interrupted and the
  heatpump is activated in heating mode until the heat demand is
  satisfied. After this the CoolingMode2_1 is continued.If the field
  flow temperature reaches 12 degree Celsius the field can not be used
  to satisfy the need of all cooling consumers and the heatpump is
  activated in cooling mode (see coolingMode2_2). The position of the
  valves and the dampers during the freecoling using geothermic field
  are shown in the following picture.
</p>
<p>
  <img src=
  \"modelica://ExergyBasedControl/Subsystems/LTC_CC/PlanCoolingMode2_1.jpg\"
  alt=\"1\">
</p>
</html>"));
    end CoolingMode2_1;
equation
  transition(
    coolingMode2_1,
    coolingMode2_2,next,
    immediate=false,reset=false,synchronize=false,priority=1)
                     annotation (Line(
      points={{12,-12},{26,-12}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));

  //Cooling mode 2_2
public
    CoolingMode2_2 coolingMode2_2
    annotation (Placement(transformation(extent={{28,-22},{48,-2}})));
    block CoolingMode2_2

      outer output Boolean transmit_HPCommand;
      outer output Boolean next(start=false);
      outer output Boolean mode;
      outer output Boolean changeMode(start=false) "'true'='change from a cooling mode to 
  the heating mode and vice versa";
      outer output Boolean measuring;
      outer output Boolean hPState;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P3;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK12P2;
      outer output Real transmit_openingHK13Y1;
      outer output Real transmit_openingHK13Y2;
      outer output Real transmit_openingHK13Y3;
      outer output Real transmit_openingHK13K3;
      outer output Real transmit_openingHK11Y1;
      outer output Real transmit_openingHK11Y2;
      outer output Real transmit_openingHK12Y2;
      outer output Real transmit_openingHK12Y1;

      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=273.15 +
            17) annotation (Placement(transformation(extent={{-60,13},{-46,
              27}})));
      Modelica.Blocks.Logical.LessThreshold greaterThreshold2(threshold=0.5)
        annotation (Placement(transformation(extent={{-60,-11},{-46,3}})));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{-80,-10},{-68,1}})));
    Modelica.Blocks.Interfaces.RealInput GTFTempFlow(                              final unit="K", min=0, max=380,
      final quantity="ThermodynamicTemperature")
      "Flow temperature of the primary side of the geothermal field" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-100,20})));
      Modelica.Blocks.Interfaces.RealInput GTFTempReturn(
        final unit="K",
        min=0,
        max=380,
        final quantity="ThermodynamicTemperature")
      "Flow temperature of the primary side of the geothermal field"   annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-100,-32})));
      Modelica.Blocks.Logical.And gFFieldExhausted
        annotation (Placement(transformation(extent={{-28,6},{-14,20}})));
    Modelica.Blocks.Interfaces.RealInput avHeatStorageTemp(
        final unit="K",
        min=0,
        max=380,
        final quantity="ThermodynamicTemperature") annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-100,69})));
      Modelica.Blocks.Logical.GreaterThreshold heatStorageFull(threshold=273.15 + 33)
        annotation (Placement(transformation(extent={{-57,62},{-43,76}})));
    Modelica.Blocks.Interfaces.RealInput avColdStorageTemp
        annotation (Placement(transformation(extent={{-120,-90},{-80,-50}})));
    Modelica.Blocks.Logical.Hysteresis hyteresis(uLow=273.15 + 10, uHigh=273.15 + 11)
      annotation (Placement(transformation(extent={{-74,-77},{-60,-63}})));
    Modelica.Blocks.Logical.Not coldStorageFull
        annotation (Placement(transformation(extent={{-50,-78},{-34,-62}})));
    equation

      measuring = false;

      hPState = true;

      mode = true;

        if coldStorageFull.y then

          transmit_HPCommand = false;
          transmit_massFlowHK12P1 = 0.001;
          transmit_massFlowHK12P2 = 0.001;

        else

          transmit_HPCommand = true;
          transmit_massFlowHK12P1 = 14;
          transmit_massFlowHK12P2 = 10;

        end if;

        if heatStorageFull.y then

          transmit_openingHK11Y1 = 0.999;

        else

          transmit_openingHK11Y1 = 0.2;

        end if;

        transmit_openingHK12Y1 = 0.999;

      changeMode = false;

      transmit_massFlowHK13P1=16;
      transmit_massFlowHK13P3=4;

      transmit_openingHK13Y1 = 0.999;
      transmit_openingHK13Y2 = 0.999;
      transmit_openingHK13Y3= 0.999;
      transmit_openingHK13K3= 0.001;
      transmit_openingHK11Y2 = 0.001;
      transmit_openingHK12Y2 = 0.999;

      if gFFieldExhausted.y then

        next = true;

      else

        next = false;

      end if;

      connect(GTFTempFlow,greaterThreshold1. u) annotation (Line(
          points={{-100,20},{-61.4,20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(GTFTempFlow,add. u1) annotation (Line(
          points={{-100,20},{-88,20},{-88,-1.2},{-81.2,-1.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add.y,greaterThreshold2. u) annotation (Line(
          points={{-67.4,-4.5},{-64,-4.5},{-64,-4},{-61.4,-4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(GTFTempReturn,add. u2) annotation (Line(
          points={{-100,-32},{-88,-32},{-88,-8},{-84,-8},{-84,-7.8},{-81.2,-7.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(greaterThreshold2.y, gFFieldExhausted.u2) annotation (Line(points={{-45.3,
            -4},{-36,-4},{-36,7.4},{-29.4,7.4}},   color={255,0,255}));
      connect(greaterThreshold1.y, gFFieldExhausted.u1) annotation (Line(points={{-45.3,
            20},{-36,20},{-36,13},{-29.4,13}}, color={255,0,255}));
      connect(avHeatStorageTemp, heatStorageFull.u)
        annotation (Line(points={{-100,69},{-58.4,69}},          color={0,0,127}));
      connect(hyteresis.y, coldStorageFull.u)
        annotation (Line(points={{-59.3,-70},{-51.6,-70}}, color={255,0,255}));
      connect(avColdStorageTemp, hyteresis.u)
        annotation (Line(points={{-100,-70},{-75.4,-70}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(extent={{-100,-120},{100,100}}),
           graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,100}}),
              graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10), Text(
              extent={{-88,96},{90,82}},
              lineColor={28,108,200},
              textString="Cooling with heat pump and geothermal field")}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true,
      Documentation(info="<html><p>
  If a freecooling using the glycol cooler or the geothermic field not
  possible and the geothermal field is not able to satisfy all cooling
  demand the heatpump is acitvated. In this case the geothermal field
  is used to serve the medium low temperature circuit (17 degree
  Celsius) and the heatpump serve the lowtemperature consumers (12
  degree Celsius). During the cooling activity of the heatpump also
  heating energy is produced. If the mean temperature of the hotstorage
  reaches 33 degree Celsius the recooling of the hotside of the
  heatpump using the glycol cooler is activated. If the geothermic flow
  temperature reaches 17 degree Celsius and the delta temperature
  between flow and return temperature drops under 0.5 degree Celsius
  the geothermal field has to be deactivated and a switch to
  CoolingMode3_1 is necessary. Decreases the flow temperature of the
  evaporator lower than 6.5 degree Celsius the heatpump is deactivated
  for safety reasons. The position of the valves and the dampers during
  the freecoling using geothermic field are shown in the following
  picture.
</p>
<p>
  <img src=
  \"modelica://ExergyBasedControl/Subsystems/LTC_CC/PlanCoolingMode2_2.jpg\"
  alt=\"1\">
</p>
</html>"));
    end CoolingMode2_2;
equation
  transition( coolingMode2_2,
              coolingMode3_1,next,
              immediate=false,reset=false,synchronize=false,priority=2)
                               annotation (Line(
      points={{40,-24},{40,-40},{0,-40},{0,-50}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,-4},{-4,-10}},
      lineColor={95,95,95},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));

  //Cooling mode 3_1
public
CoolingMode3_1 coolingMode3_1 annotation (Placement(transformation(
          extent={{-10,-72},{10,-52}})));
    block CoolingMode3_1

      outer output Boolean next;
      outer output Boolean mode;
      outer output Boolean transmit_HPCommand;
      outer output Boolean changeMode(start=false) "'true'='change from a cooling mode to 
  the heating mode and vice versa";
      outer output Boolean measuring;
      outer output Boolean hPState;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P1;
      outer output Modelica.SIunits.MassFlowRate transmit_massFlowHK13P3;

      outer output Real transmit_openingHK13Y1;
      outer output Real transmit_openingHK13Y2;
      outer output Real transmit_openingHK13Y3;
      outer output Real transmit_openingHK13K3;
      outer output Real transmit_openingHK11Y1;
      outer output Real transmit_openingHK11Y2;
      outer output Real transmit_openingHK12Y2;
      outer output Real transmit_openingHK12Y1;

      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=273.15 +
            17) annotation (Placement(transformation(extent={{-60,-1},{-46,13}})));
      Modelica.Blocks.Logical.LessThreshold greaterThreshold2(threshold=0.5)
        annotation (Placement(transformation(extent={{-60,-23},{-46,-9}})));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{-80,-22},{-68,-11}})));
      Modelica.Blocks.Logical.And gFFieldExhausted
        annotation (Placement(transformation(extent={{-28,-12},{-14,2}})));
      Modelica.Blocks.Logical.GreaterThreshold heatStorageFull(threshold=273.15 + 33)
        annotation (Placement(transformation(extent={{-61,50},{-47,64}})));
    Modelica.Blocks.Interfaces.RealInput GTFTempFlow(                              final unit="K", min=0, max=380,
      final quantity="ThermodynamicTemperature")
      "Flow temperature of the primary side of the geothermal field" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-100,6})));
      Modelica.Blocks.Interfaces.RealInput GTFTempReturn(
        final unit="K",
        min=0,
        max=380,
        final quantity="ThermodynamicTemperature")
      "Flow temperature of the primary side of the geothermal field"   annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-100,-44})));
    Modelica.Blocks.Interfaces.RealInput avHeatStorageTemp(
        final unit="K",
        min=0,
        max=380,
        final quantity="ThermodynamicTemperature") annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-100,57})));
    Modelica.Blocks.Logical.Hysteresis hyteresis(uLow=273.15 + 10, uHigh=273.15 + 11)
      annotation (Placement(transformation(extent={{-60,-87},{-46,-73}})));
    Modelica.Blocks.Interfaces.RealInput avColdStorageTemp(
        final unit="K",
        min=0,
        max=380)
        annotation (Placement(transformation(extent={{-120,-100},{-80,-60}})));
    Modelica.Blocks.Logical.Not coldStorageFull
        annotation (Placement(transformation(extent={{-36,-88},{-20,-72}})));
    equation

      measuring = false;

      hPState = true;

      mode = true;

      next = true;

      changeMode = false;

        if heatStorageFull.y then

          transmit_openingHK11Y1 = 0.999;

        else

          transmit_openingHK11Y1 = 0.2;

        end if;

        transmit_openingHK12Y1 = 0.999;

        if coldStorageFull.y then

          transmit_HPCommand = false;

        else

          transmit_HPCommand = true;

        end if;

      transmit_massFlowHK13P1=0.001;
      transmit_massFlowHK13P3=0.001;

      transmit_openingHK13Y1 = 0.001;
      transmit_openingHK13Y2 = 0.001;
      transmit_openingHK13Y3= 0.999;
      transmit_openingHK13K3= 0.001;

      transmit_openingHK11Y2 = 0.001;
      transmit_openingHK12Y2 = 0.999;

      connect(GTFTempFlow,greaterThreshold1. u) annotation (Line(
          points={{-100,6},{-61.4,6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(GTFTempFlow,add. u1) annotation (Line(
          points={{-100,6},{-88,6},{-88,-13.2},{-81.2,-13.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add.y,greaterThreshold2. u) annotation (Line(
          points={{-67.4,-16.5},{-64,-16.5},{-64,-16},{-61.4,-16}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(GTFTempReturn,add. u2) annotation (Line(
          points={{-100,-44},{-88,-44},{-88,-20},{-84,-20},{-84,-19.8},{-81.2,-19.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(greaterThreshold2.y,gFFieldExhausted. u2) annotation (Line(points={{-45.3,
              -16},{-36,-16},{-36,-10.6},{-29.4,-10.6}},
                                                   color={255,0,255}));
      connect(greaterThreshold1.y,gFFieldExhausted. u1) annotation (Line(points={{-45.3,6},
              {-36,6},{-36,-5},{-29.4,-5}},    color={255,0,255}));
      connect(avHeatStorageTemp,heatStorageFull. u)
        annotation (Line(points={{-100,57},{-82,57},{-62.4,57}}, color={0,0,127}));
      connect(hyteresis.u, avColdStorageTemp) annotation (Line(points={{-61.4,-80},{
              -75.7,-80},{-100,-80}}, color={0,0,127}));
      connect(hyteresis.y, coldStorageFull.u)
        annotation (Line(points={{-45.3,-80},{-37.6,-80}}, color={255,0,255}));
    annotation (
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            textString="%stateName",
            fontSize=10)}),
      __Dymola_state=true,
      showDiagram=true,
      singleInstance=true,
      Documentation(info="<html><p>
  In CoolingMode3_1 the geothermic field cannot be used for cooling.
  The heatpump is actived in cooling mode. If the mean hotstorage
  temperature reaches 33 degree Celsius the reecooling using the glycol
  cooler is used. Decreases the flow temperature of the evaporator
  lower than 6.5 degree Celsius the heatpump is deactivated for safety
  reasons. The following picture shows the valve and damper positions
  in these mode.
</p>
<p>
  <img src=
  \"modelica://ExergyBasedControl/Subsystems/LTC_CC/PlanCoolingMode3_1.jpg\"
  alt=\"1\">
</p>
</html>"));
    end CoolingMode3_1;
equation

  //Cooling mode 3_2

////////////////////////////////////////////////////////////////////////////////
//Connections///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  //Hold
  connect(hold_massFlow.y, SwitchingUnitMassFlow) annotation (Line(
      points={{166.6,92},{180,92}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hold_openingHK13Y3.y, openingHK13Y3) annotation (Line(
      points={{164.6,8},{180,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(openingHK13Y2, hold_openingHK13Y2.y) annotation (Line(
      points={{180,50},{166.6,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(openingHK13K3, hold_openingHK13K3.y) annotation (Line(
      points={{180,-40},{164.6,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(openingHK11Y1, hold_openingHK11Y1.y) annotation (Line(
      points={{180,-58},{164.6,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(openingHK11Y2, hold_openingHK11Y2.y) annotation (Line(
      points={{130,-100},{130,-76.6},{128,-76.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hold_massFlowHK13P1.y, massFlowHK13P1) annotation (Line(
      points={{119.4,-48},{70,-48},{70,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(GTFTempFlow, sample_GTFTempFlow.u) annotation (Line(
      points={{70,100},{70,55.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hold_HPCommand.y, HPCommand) annotation (Line(
      points={{100,-80.6},{100,-100}},
      color={255,0,255},
      smooth=Smooth.None));

  hold_massFlow.u = transmit_massFlowHK13P3;
  hold_massFlowHK12P2.u = transmit_massFlowHK12P2;
  hold_massFlowHK12P1.u = transmit_massFlowHK12P1;
  hold_massFlowHK13P1.u = transmit_massFlowHK13P1;

  hold_HPCommand.u = transmit_HPCommand;
  hold_measuring.u = measuring;
  hold_mode.u = mode;

  hold_openingHK13Y1.u = transmit_openingHK13Y1;
  hold_openingHK13Y2.u = transmit_openingHK13Y2;
  hold_openingHK13Y3.u = transmit_openingHK13Y3;
  hold_openingHK13K3.u = transmit_openingHK13K3;
  hold_openingHK11Y1.u = transmit_openingHK11Y1;
  hold_openingHK11Y2.u = transmit_openingHK11Y2;
  hold_openingHK12Y2.u = transmit_openingHK12Y2;
  hold_openingHK12Y1.u = transmit_openingHK12Y1;

  //Sample
  connect(upperAvTempStorage, sample_upperAvTempStorage.u) annotation (Line(
      points={{-100,10},{-63.2,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_upperAvTempStorage.y, heatingMode1.upperAvTempStorage)
    annotation (Line(
      points={{-49.4,10},{110,10},{110,39.6},{136,39.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(evapTemp, sample_evapTemp.u) annotation (Line(
      points={{-100,-30},{-63.2,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_evapTemp.y, heatingMode1.evapTemp) annotation (Line(
      points={{-49.4,-30},{124,-30},{124,27},{136,27}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lowerTempStorage, sample_lowerTempStorage.u) annotation (Line(
      points={{-100,-70},{-63.2,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_GTFTempFlow.y, heatingMode1.GTFTempFlow) annotation (
     Line(
      points={{70,41.4},{70,23},{136,23}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_outdoorTemperature.y, coolingMode1.outdoorTemperature)
    annotation (Line(
      points={{-49.4,46},{-30,46},{-30,38},{-10,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_avHeatStorageTemp.y, coolingMode1.avHeatStorageTemp)
    annotation (Line(
      points={{-49.4,28},{-38,28},{-38,36},{-20,36},{-20,35.3},{-10,
          35.3}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_outdoorTemperature.u, outdoorTemperature) annotation (Line(
      points={{-63.2,46},{-62,46},{-62,90},{-100,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(avHeatStorageTemp, sample_avHeatStorageTemp.u) annotation (Line(
      points={{-100,50},{-76,50},{-76,28},{-63.2,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(avColdStorageTemp, sample_avColdStorageTemp.u) annotation (Line(
      points={{-46,100},{-46,77.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_avColdStorageTemp.y, heatingMode1.avColdStorageTemp)
    annotation (Line(
      points={{-46,63.4},{-46,54},{30,54},{30,31.2},{136,31.2}},
      color={0,0,127},
      smooth=Smooth.None));

  //Clock signals
  connect(sample_lowerTempStorage.y, heatingMode1.lowerTempStorage) annotation (
     Line(
      points={{-49.4,-70},{114,-70},{114,35.2},{136,35.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(periodicClock1.y, sample_evapTemp.clock) annotation (Line(
      points={{-75.4,70},{-70,70},{-70,-50},{-56,-50},{-56,-37.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(periodicClock1.y, sample_lowerTempStorage.clock) annotation (Line(
      points={{-75.4,70},{-70,70},{-70,-78},{-56,-78},{-56,-77.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(periodicClock1.y, sample_upperAvTempStorage.clock) annotation (Line(
      points={{-75.4,70},{-70,70},{-70,-6},{-56,-6},{-56,2.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(periodicClock1.y, sample_GTFTempFlow.clock) annotation (Line(
      points={{-75.4,70},{-20,70},{-20,100},{32,100},{32,48},{62.8,48}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));

  connect(periodicClock1.y, sample_avHeatStorageTemp.clock) annotation (Line(
      points={{-75.4,70},{-70,70},{-70,36},{-56,36},{-56,20.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(periodicClock1.y, sample_outdoorTemperature.clock) annotation (Line(
      points={{-75.4,70},{-70,70},{-70,20},{-56,20},{-56,38.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(periodicClock1.y, sample_avColdStorageTemp.clock) annotation (Line(
      points={{-75.4,70},{-53.2,70}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));

  connect(LTCFlowTemp, sample_LTCFlowTemp.u) annotation (Line(
      points={{106,100},{106,77.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_LTCFlowTemp.y, heatingMode1.LTCFlowTemp) annotation (
     Line(
      points={{106,63.4},{106,48},{143.8,48},{143.8,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(periodicClock1.y, sample_LTCFlowTemp.clock) annotation (
      Line(
      points={{-75.4,70},{-20,70},{-20,100},{32,100},{32,70},{98.8,70}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));

  connect(heatingMode1.HECommand, hold_HECommand.u) annotation (Line(
      points={{153,22},{154,22},{154,14},{63.2,14},{63.2,18}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(hold_HECommand.y, HECommand) annotation (Line(
      points={{49.4,18},{26,18},{26,102}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(periodicClock1.y, leaveOperationMode.clock1) annotation (Line(
      points={{-75.4,70},{-70,70},{-70,-92},{-64,-92}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(hold_openingHK12Y2.y, openingHK12Y2) annotation (Line(
      points={{140,-76.6},{140,-86},{150,-86},{150,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  transition( coolingMode2_1,
              heatingMode1,
              changeMode,
              immediate=false,
              reset=false,
              priority=2,
              synchronize=false) annotation (Line(
      points={{12,-6},{16,-6},{16,52},{140,52},{140,44}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  connect(periodicClock1.y, sample_GTFTempReturn.clock) annotation (
      Line(
      points={{-75.4,70},{-20,70},{-20,100},{32,100},{32,48},{38.8,48}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));

  connect(GTFTempReturn, sample_GTFTempReturn.u) annotation (Line(
      points={{46,100},{46,55.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_GTFTempReturn.y, coolingMode2_1.GTFTempReturn)
    annotation (Line(
      points={{46,41.4},{46,6},{-18,6},{-18,-17},{-10,-17}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_GTFTempFlow.y, coolingMode2_1.GTFTempFlow)
    annotation (Line(
      points={{70,41.4},{70,12},{-22,12},{-22,-12},{-10,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_avHeatStorageTemp.y, coolingMode2_1.avHeatStorageTemp)
    annotation (Line(
      points={{-49.4,28},{-38,28},{-38,-7.1},{-10,-7.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(count.u1, sample_evapTemp.clock) annotation (Line(
      points={{-42,-24.6},{-52,-24.6},{-52,-6},{-70,-6},{-70,-50},{-56,-50},{-56,
          -37.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(count.Time, coolingMode2_1.Time) annotation (Line(
      points={{-26,-21.4},{-26,-21},{-10,-21}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(openingHK12Y1, hold_openingHK12Y1.y)
    annotation (Line(points={{20,-100},{20,-90.6}}, color={0,0,127}));
  connect(hold_massFlowHK12P2.y, massFlowHK12P2) annotation (Line(points={{-26,-86.6},
          {-26,-100}},            color={0,0,127}));
  connect(hold_massFlowHK12P1.y, massFlowHK12P1) annotation (Line(points={{-2,-86.6},
          {-2,-100}},           color={0,0,127}));
  transition(
        coolingMode2_2,
        Start,goToStart,
        priority=3,
        immediate=false,
        reset=false,
        synchronize=false) annotation (Line(
      points={{44,-24},{44,-36},{102,-36},{102,74},{12,74}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,-4},{-4,-10}},
      lineColor={95,95,95},
      fontSize=1,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  connect(sample_avHeatStorageTemp.y, coolingMode2_2.avHeatStorageTemp)
    annotation (Line(points={{-49.4,28},{-32,28},{-32,14},{22,14},{22,
          -4.81818},{28,-4.81818}},
                      color={0,0,127}));
  connect(sample_GTFTempFlow.y, coolingMode2_2.GTFTempFlow) annotation (
      Line(points={{70,41.4},{70,26},{18,26},{18,-9.27273},{28,-9.27273}},
        color={0,0,127}));
  connect(sample_GTFTempReturn.y, coolingMode2_2.GTFTempReturn) annotation (
     Line(points={{46,41.4},{46,6},{14,6},{14,-14},{28,-14}},     color={0,
          0,127}));
  connect(sample_avHeatStorageTemp.y, coolingMode3_1.avHeatStorageTemp)
    annotation (Line(points={{-49.4,28},{-44,28},{-38,28},{-38,-8},{-24,-8},
          {-24,-56.3},{-10,-56.3}}, color={0,0,127}));
  connect(sample_GTFTempFlow.y, coolingMode3_1.GTFTempFlow) annotation (
      Line(points={{70,41.4},{70,26},{18,26},{18,-46},{-20,-46},{-20,-61.4},
          {-10,-61.4}}, color={0,0,127}));
  connect(sample_GTFTempReturn.y, coolingMode3_1.GTFTempReturn) annotation (
     Line(points={{46,41.4},{46,41.4},{46,8},{46,6},{14,6},{14,-42},{-26,
          -42},{-26,-66.4},{-10,-66.4}}, color={0,0,127}));
  transition(
    coolingMode1,
    heatingMode1,changeMode,
    immediate=false,
    reset=false,
    priority=1,synchronize=false)
                annotation (Line(
      points={{12,34},{14,34},{14,44},{20,54},{144,54},{144,44}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));

  connect(hold_openingHK13Y1.y,openingHK13Y1)  annotation (Line(
      points={{164.6,-14},{180,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, greaterThreshold.u) annotation (Line(points={{-79,-8},
          {-76,-8},{-66.8,-8},{-66.8,-2}},                               color={
          0,0,127}));

  connect(count.Time, heatingMode1.Time) annotation (Line(points={{-26,
          -21.4},{-22,-21.4},{-22,-26},{146.8,-26},{146.8,22}}, color={0,0,
          127}));
  connect(greaterThreshold.y, pre1.u) annotation (Line(points={{-57.6,-2},{-57.6,
          -2},{-55,-2}},        color={255,0,255}));
  connect(pre1.y, count.u) annotation (Line(points={{-43.5,-2},{-42,-2},{-42,-21.4}},
                       color={255,0,255}));
  connect(hold_measuring.y, output_measuring)
    annotation (Line(points={{-84,-92.6},{-84,-102}}, color={255,0,255}));
  connect(booleanExpression.y, count_measuring.u) annotation (Line(points={{-79,-48},
          {-46,-48},{-46,-47.4}},           color={255,0,255}));
  connect(periodicClock1.y, count_measuring.u1) annotation (Line(
      points={{-75.4,70},{-70,70},{-70,-50.6},{-46,-50.6}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  transition(
    heatingMode1,
    coolingMode2_2,switch,immediate=false,reset=false,synchronize=false,
    priority=1)
            annotation (Line(
      points={{138,20},{138,-2},{49,-1}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{-4,-4},{-4,-10}},
      lineColor={95,95,95},
      fontSize=10,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Right));
  transition(
    coolingMode2_2,
    heatingMode1,heatingMode and sample_avColdStorageTemp.y < (273.15 + 11.2),
    immediate=false,
    reset=false,
    priority=1,
    synchronize=false) annotation (Line(
      points={{50,-8},{206,-8},{206,38},{158,38}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=1,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  transition(
    coolingMode3_1,
    heatingMode1,heatingMode and sample_avColdStorageTemp.y < (273.15
     + 11.2),
    immediate=false,
    reset=false,
    priority=1,
    synchronize=false) annotation (Line(
      points={{8,-50},{8,-48},{68,-48},{68,-42},{200,-42},{200,30},{158,
          30}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=1,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  connect(hold_mode.y, modeOutput) annotation (Line(points={{164.6,72},{182,72}},
                     color={255,0,255}));
  connect(sample_avColdStorageTemp.y, Start.avColdStorageTemp)
    annotation (Line(points={{-46,63.4},{-46,54},{-26,54},{-26,83},{-10,
          83}}, color={0,0,127}));
  connect(sample_avHeatStorageTemp.y, Start.avHeatStorageTemp)
    annotation (Line(points={{-49.4,28},{-38,28},{-38,73},{-10,73}},
        color={0,0,127}));
  connect(booleanExpression1.y, leaveOperationMode.measuring) annotation (
      Line(points={{-71,-60},{-70,-60},{-70,-97},{-64,-97}}, color={255,0,
          255}));
  transition(
        coolingMode3_1,
        Start,goToStart,
        immediate=false,
        reset=false,
        priority=2,synchronize=false)
                    annotation (Line(
      points={{12,-62},{74,-62},{74,68},{11,67}},
      color={175,175,175},
      thickness=0.25,
      smooth=Smooth.Bezier), Text(
      string="%condition",
      extent={{4,4},{4,10}},
      lineColor={95,95,95},
      fontSize=3,
      textStyle={TextStyle.Bold},
      horizontalAlignment=TextAlignment.Left));
  connect(hold_activeState.y, active_state) annotation (Line(points={{178.4,
          -79},{179.2,-79},{190,-79}}, color={255,0,255}));
  connect(booleanExpression2.y, hold_activeState[1].u) annotation (Line(
        points={{162.6,-65},{166,-65},{166,-79},{169.2,-79}}, color={255,0,
          255}));
  connect(booleanExpression3.y, hold_activeState[2].u) annotation (Line(
        points={{162.6,-71},{166,-71},{166,-79},{169.2,-79}}, color={255,0,
          255}));
  connect(booleanExpression4.y, hold_activeState[3].u) annotation (Line(
        points={{162.6,-77},{166,-77},{166,-79},{169.2,-79}}, color={255,0,
          255}));
  connect(booleanExpression5.y, hold_activeState[4].u) annotation (Line(
        points={{162.6,-83},{166,-83},{166,-79},{169.2,-79}}, color={255,0,
          255}));
  connect(booleanExpression6.y, hold_activeState[5].u) annotation (Line(
        points={{170.6,-91},{176,-91},{176,-86},{166,-86},{166,-79},{169.2,
          -79}}, color={255,0,255}));
  connect(booleanExpression7.y, hold_activeState[6].u) annotation (Line(
        points={{178.6,-97},{180,-97},{180,-86},{166,-86},{166,-79},{169.2,
          -79}}, color={255,0,255}));
  connect(sample_avColdStorageTemp.y, coolingMode2_2.avColdStorageTemp)
    annotation (Line(points={{-46,63.4},{-46,64},{-46,20},{-46,-17.4545},
          {28,-17.4545}}, color={0,0,127}));
  connect(sample_avColdStorageTemp.y, coolingMode3_1.avColdStorageTemp)
    annotation (Line(points={{-46,63.4},{-28,63.4},{-28,-70},{-10,-70}},
        color={0,0,127}));
  connect(leaveOperationMode.HPComand, HPComand1) annotation (Line(
        points={{-44,-83},{-40,-83},{-40,-60},{-68,-60},{-68,26},{-68,
          32},{-100,32}}, color={255,0,255}));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-140},{180,100}})),           Icon(coordinateSystem(
          extent={{-160,-140},{180,100}})));
end StateMachine;
