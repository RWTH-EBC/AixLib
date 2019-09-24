within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl;
model MainControllerLTC

  parameter Integer timeInterval = 300
    "Time interval after which a new measurement is started";

  parameter Integer n_cold = 4
    "number of discretization layers in cold storage";
  parameter Integer n_warm = 4
    "number of discretization layers in heat storage";

  parameter Boolean pre_mode = false;

  Modelica.Blocks.Interfaces.RealInput temperatures_cold[n_cold](min=0, final unit="K",
    final quantity="ThermodynamicTemperature")
    annotation (Placement(transformation(extent={{-174,-58},{-150,-34}}),
        iconTransformation(extent={{-174,-58},{-150,-34}})));
  Modelica.Blocks.Interfaces.RealInput temperatures_warm[n_warm](min=0, final unit="K",
    final quantity="ThermodynamicTemperature")
    annotation (Placement(transformation(extent={{-176,-126},{-154,-104}}),
        iconTransformation(extent={{-176,-126},{-154,-104}})));
  Modelica.Blocks.Interfaces.BooleanOutput mode
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={138,-206}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={92,-204})));

  AverageTemperatures CalcAvTemp_cold(n=n_cold,
    top=false,
    bottom=false)
    annotation (Placement(transformation(extent={{-74,40},{-48,60}})));
  AverageTemperatures CalcAvTemp_warm(
    n=n_warm,
    top=false,
    bottom=false)
    annotation (Placement(transformation(extent={{-74,2},{-48,24}})));
  Modelica.Blocks.Interfaces.RealInput evapTemp(
    min=0,
    final unit="K",
    final quantity="ThermodynamicTemperature")
                                  annotation (Placement(transformation(
          extent={{-174,-170},{-152,-148}}),
                                          iconTransformation(extent={{-174,
            -170},{-152,-148}})));
  Modelica.Blocks.Interfaces.RealInput outdoorTemperature(
    min=0,
    final unit="K",
    final quantity="ThermodynamicTemperature")
                                  annotation (Placement(transformation(
          extent={{-170,-30},{-148,-8}}),  iconTransformation(extent={{-170,
            -30},{-148,-8}})));
  StateMachine.StateMachine stateMachine
    annotation (Placement(transformation(extent={{-26,-26},{28,26}})));
  AverageTemperatures CalcAvTemp_warm1(
    n=n_warm,
    bottom=false,
    top=true) annotation (Placement(transformation(extent={{-74,-25},{-48,-3}})));
  Modelica.Blocks.Interfaces.RealOutput massFlowHK13P3(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(extent={{194,-130},{214,-110}}),
        iconTransformation(extent={{194,-130},{214,-110}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK13Y2
    annotation (Placement(transformation(extent={{194,30},{214,50}}),
        iconTransformation(extent={{194,30},{214,50}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK13Y3
    annotation (Placement(transformation(extent={{194,-22},{214,-2}}),
        iconTransformation(extent={{194,-22},{214,-2}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK13K3
    annotation (Placement(transformation(extent={{194,-76},{214,-56}}),
        iconTransformation(extent={{194,-76},{214,-56}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK11Y2 annotation (
      Placement(transformation(extent={{194,-164},{214,-144}})));
  Modelica.Blocks.Interfaces.RealOutput openingHK12Y2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-204})));
  Modelica.Blocks.Interfaces.BooleanOutput HPCommand
    "Command to heat pump, 'true' = 'on'" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={194,-204}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={130,-206})));
  Modelica.Blocks.Interfaces.RealInput GTFTempFlow(                              final unit="K", min=0, max=380,
    final quantity="ThermodynamicTemperature")
    "Flow temperature of the primary side of the geothermal field" annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-160,38}),   iconTransformation(extent={{-172,26},{-148,50}})));
  Modelica.Blocks.Interfaces.RealOutput massFlowHK13P1(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,-206})));
  Modelica.Blocks.Interfaces.RealInput LTCFlowTemp(
    final unit="K",
    min=0,
    max=380,
    final quantity="ThermodynamicTemperature")
    "Flow temperature of the primary side of the geothermal field"
    annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-95,-205}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-138,-198})));
  Modelica.Blocks.Interfaces.IntegerOutput HECommand(min=0,max=3)
    "'2'='HE on', '1'='HE Stand-By', '0'='HE off'"                annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={8,106})));
  Modelica.Blocks.Interfaces.RealOutput openingHK11Y1 annotation (
      Placement(transformation(extent={{196,-192},{216,-172}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-206})));
  Modelica.Blocks.Interfaces.RealInput GTFTempReturn(
    final unit="K",
    min=0,
    max=380,
    final quantity="ThermodynamicTemperature")
    "Flow temperature of the primary side of the geothermal field"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-160,84}),  iconTransformation(extent={{-172,72},{-148,96}})));
         Modelica.Blocks.Interfaces.RealOutput openingHK12Y1(min=0, max=1) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-6,-206})));
  Modelica.Blocks.Interfaces.RealOutput openingHK13Y1
    annotation (Placement(transformation(extent={{196,68},{216,88}})));
  Modelica.Blocks.Interfaces.RealOutput massFlowHK12P2(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-48,-206}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={184,-202})));
  Modelica.Blocks.Interfaces.RealOutput massFlowHK12P1(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-206}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-102,-202})));
  LowPassBoolean lowPassBoolean(delayTime_off=40, delayTime_on=40)
    annotation (Placement(transformation(extent={{54,36},{80,64}})));
  LowPassBoolean lowPassBoolean1(delayTime_off=40, delayTime_on=300)
                                 annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=270,
        origin={21.5,-153.5})));
  Modelica.Blocks.Continuous.Filter filter(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(extent={{92,-118},{106,-104}})));
  Modelica.Blocks.Continuous.Filter filter1(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={115,-65})));
  Modelica.Blocks.Continuous.Filter filter2(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(extent={{90,-20},{104,-6}})));
  Modelica.Blocks.Continuous.Filter filter3(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(extent={{76,74},{90,88}})));
  Modelica.Blocks.Continuous.Filter filter4(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(extent={{84,18},{98,32}})));
  Modelica.Blocks.Continuous.Filter filter5(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(extent={{116,-174},{130,-160}})));
  Modelica.Blocks.Continuous.Filter filter6(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={35,-191})));
  Modelica.Blocks.Continuous.Filter filter7(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(extent={{70,-148},{84,-134}})));
  Modelica.Blocks.Continuous.Filter filter8(            normalized=false, f_cut=1/
        40)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-7,-137})));
  Modelica.Blocks.Interfaces.BooleanInput HPComand
    "Command to heat pump, 'true' = 'on'"
    annotation (Placement(transformation(extent={{-182,-6},{-142,34}})));
initial equation
  pre(mode) = pre_mode;

equation

  connect(temperatures_cold, CalcAvTemp_cold.temperatures) annotation (Line(
      points={{-162,-46},{-162,50},{-74,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatures_warm, CalcAvTemp_warm.temperatures) annotation (Line(
      points={{-165,-115},{-122,-115},{-122,13},{-74,13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatures_warm, CalcAvTemp_warm1.temperatures) annotation (
     Line(
      points={{-165,-115},{-165,-14},{-74,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(CalcAvTemp_warm1.averageTemperature, stateMachine.upperAvTempStorage)
    annotation (Line(
      points={{-48,-14},{-40,-14},{-40,6.5},{-16.4706,6.5}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(temperatures_warm[1], stateMachine.lowerTempStorage)
    annotation (Line(
      points={{-165,-123.25},{-126,-123.25},{-126,-54},{-80,-54},{-80,
          -10.8333},{-16.4706,-10.8333}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(GTFTempFlow, stateMachine.GTFTempFlow) annotation (Line(
      points={{-160,38},{-34,38},{-34,40},{8,40},{8,32},{10.5294,32},{
          10.5294,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(CalcAvTemp_cold.averageTemperature, stateMachine.avColdStorageTemp)
    annotation (Line(
      points={{-48,50},{-7.89412,50},{-7.89412,26}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(LTCFlowTemp, stateMachine.LTCFlowTemp) annotation (Line(
      points={{-95,-205},{-95,-168},{-74,-168},{-74,-126},{36,-126},{36,
          -6},{16.2471,-6},{16.2471,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stateMachine.HECommand, HECommand) annotation (Line(
      points={{3.54118,26.4333},{3.54118,92},{6,92},{6,100},{8,100},{8,
          106}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(stateMachine.GTFTempReturn, GTFTempReturn) annotation (Line(
      points={{6.71765,26},{12,26},{12,84},{-160,84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lowPassBoolean.y, mode) annotation (Line(points={{80.1529,52},{
          80.1529,50},{88,50},{138,50},{138,-206}},
                         color={255,0,255}));
  connect(lowPassBoolean.u, stateMachine.modeOutput) annotation (Line(
        points={{54,52},{40,52},{40,18},{28.3176,18},{28.3176,19.9333}},
        color={255,0,255}));
  connect(lowPassBoolean1.u, stateMachine.HPCommand) annotation (Line(
        points={{22.5714,-146},{22.5714,-107.176},{15.2941,-107.176},{
          15.2941,-17.3333}},
                          color={255,0,255}));
  connect(lowPassBoolean1.y, HPCommand) annotation (Line(points={{22.5714,
          -161.088},{22.5714,-174},{194,-174},{194,-204},{194,-204}},
                                                                 color={
          255,0,255}));
  connect(stateMachine.SwitchingUnitMassFlow, filter.u) annotation (Line(
        points={{28,24.2667},{28,24},{54,24},{54,-111},{90.6,-111}},
                                                                color={0,
          0,127}));
  connect(filter.y, massFlowHK13P3) annotation (Line(points={{106.7,-111},{
          178,-111},{178,-100},{182,-100},{182,-120},{204,-120}},
                                           color={0,0,127}));
  connect(stateMachine.openingHK13K3, filter1.u) annotation (Line(points={{28,
          -4.33333},{48,-4.33333},{48,-64},{106.6,-64},{106.6,-65}},
                                                                color={0,
          0,127}));
  connect(filter1.y, openingHK13K3) annotation (Line(points={{122.7,-65},{
          122.7,-66},{204,-66}},
                              color={0,0,127}));
  connect(openingHK13Y3, filter2.u) annotation (Line(points={{204,-12},{188,
          -12},{188,-13},{88.6,-13}},   color={0,0,127}));
  connect(filter2.u, stateMachine.openingHK13Y3) annotation (Line(points={{88.6,
          -13},{48.3,-13},{48.3,6.06667},{28,6.06667}},      color={0,0,
          127}));
  connect(filter3.y, openingHK13Y1) annotation (Line(points={{90.7,81},{
          157.35,81},{157.35,78},{206,78}},  color={0,0,127}));
  connect(stateMachine.openingHK13Y1, filter3.u) annotation (Line(points={{28,1.3},
          {42,1.3},{42,80},{52,80},{52,81},{74.6,81}},
        color={0,0,127}));
  connect(filter4.y, openingHK13Y2) annotation (Line(points={{98.7,25},{204,
          25},{204,40}},          color={0,0,127}));
  connect(filter4.u, stateMachine.openingHK13Y2) annotation (Line(points={{82.6,25},
          {56,25},{56,15.1667},{28,15.1667}},        color={0,0,127}));
  connect(filter5.y, openingHK11Y1) annotation (Line(points={{130.7,-167},{
          164,-167},{164,-182},{206,-182}},color={0,0,127}));
  connect(stateMachine.openingHK11Y1, filter5.u) annotation (Line(points={{28,
          -8.23333},{30,-8.23333},{30,-84},{32,-84},{32,-167},{114.6,-167}},
        color={0,0,127}));
  connect(filter6.y, openingHK12Y2) annotation (Line(points={{35,-198.7},{35,
          -204},{50,-204}},     color={0,0,127}));
  connect(filter6.u, stateMachine.openingHK12Y2) annotation (Line(points={{35,
          -182.6},{35,-128},{23.2353,-128},{23.2353,-17.3333}}, color={0,
          0,127}));
  connect(filter7.y, openingHK11Y2) annotation (Line(points={{84.7,-141},{204,
          -141},{204,-154}},      color={0,0,127}));
  connect(filter7.u, stateMachine.openingHK11Y2) annotation (Line(points={{68.6,
          -141},{60,-141},{60,-140},{20.0588,-140},{20.0588,-17.3333}},
        color={0,0,127}));
  connect(filter8.u, stateMachine.openingHK12Y1) annotation (Line(points={{-7,
          -128.6},{-7,-126},{2.58824,-126},{2.58824,-17.3333}},   color={
          0,0,127}));
  connect(filter8.y, openingHK12Y1) annotation (Line(points={{-7,-144.7},{-7,
          -194.35},{-6,-194.35},{-6,-206}},     color={0,0,127}));
  connect(stateMachine.evapTemp, evapTemp) annotation (Line(points={{
          -16.4706,-2.16667},{-70,-2.16667},{-70,-96},{-76,-96},{-76,-90},
          {-106,-90},{-106,-159},{-163,-159}},
                           color={0,0,127}));
  connect(lowPassBoolean1.massFlowHK12P1, massFlowHK12P1) annotation (Line(
        points={{14,-150.412},{-70,-150.412},{-70,-206}},      color={0,0,127}));
  connect(lowPassBoolean1.massFlowHK12P2, massFlowHK12P2) annotation (Line(
        points={{14,-152.176},{-48,-152.176},{-48,-206}},      color={0,0,127}));
  connect(massFlowHK13P1, stateMachine.massFlowHK13P1) annotation (Line(
        points={{-26,-206},{-26,-194},{-26,-160},{10.5294,-160},{10.5294,
          -17.3333}},
        color={0,0,127}));
  connect(CalcAvTemp_warm.averageTemperature, stateMachine.avHeatStorageTemp)
    annotation (Line(points={{-48,13},{-32,13},{-32,15.1667},{-16.4706,
          15.1667}}, color={0,0,127}));
  connect(outdoorTemperature, stateMachine.outdoorTemperature) annotation (
      Line(points={{-159,-19},{-75.5,-19},{-75.5,23.8333},{-16.4706,
          23.8333}},
        color={0,0,127}));
  connect(stateMachine.HPComand1, HPComand) annotation (Line(points={{
          -16.4706,11.2667},{-86.2353,11.2667},{-86.2353,14},{-162,14}},
        color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -200},{200,100}})),           Icon(coordinateSystem(extent={{-160,
            -200},{200,100}}, preserveAspectRatio=false), graphics={Rectangle(
          extent={{-162,100},{198,-200}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,30},{106,-98}},
          lineColor={28,108,200},
          textString="Control 
          strategy")}),
          Documentation(info="<html>
          <p> 
          This subsystem contains the main control modelled in a statemachine for the given Building Energy Systems. To insert your own control strategy, just replace these subsystem.
          Below a short description of the implemented control strategy is given. For an better overview take a loock at the statemachine.
          </p>
          
          <p> 
          At the highest level of the control ist is distinguished between cooling and heating demand of the building.
          The basis ohf those expectation are ther temperatures of the storages of the heatpump system. For this reason the meantemperature of both storages are
          multiplicated with the storage volume what gives us the potential of the storages. The calculation of the potential ist repeated after 300 seconds. 
          Following this the difference between the start- and the endpotential for the stoarages is taken.
          This procedures achieves to determine the heating and cooling demand of the building. Depending on which demand ist bigger the heating or the cooling mode is selected. 
          </p>
          
          <p>
          <b>Heating Demand</b>
          </p>
          
          <p>
          If the heating demand is predominant the state HeatingMode1 is chosen and the heatpump is used in heating mode. Additionally it is possible to use the heattransferHT-submodel.
          For further information about the heating mode and the heattransferHT-submodel see the documentation of these systems.
          </p>
          
          <p>
          <b>Cooling Demand</b>
          </p>
          
          <p>
          If the cooling demand is predominant there are several cooling modes which can be used. They are orderd in a sequence, depending on there energy efficiency. First the freecooling
          using the glycol cooler (CoolingMode1) tested. Second the freecooling using the gethermal field (CoolingMode2_1) is checked out. Third the use of heothermal field and the heatpump, if necessary with recooling, is used (CoolingMode2_2). 
          The last option ist to use only the heatpump, if necessary with recooling(CoolingMode3_1). Details are described in the submodels.
          </p>          
 
          </html>"));
end MainControllerLTC;
