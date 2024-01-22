within AixLib.Airflow.AirHandlingUnit.Examples;
model AHU
  "Example to test all states of the AHU model - Play with the possible modes (boolean parameters for: heating, cooling, de-/humidification"
    extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine tempOutside(
    amplitude=10,
    f=1/86400,
    phase=-3.1415/2,
    offset=292)
    annotation (Placement(transformation(extent={{-100,-16},{-80,4}})));
  Modelica.Blocks.Sources.Constant Vflow_in(k=100)
    annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
  Modelica.Blocks.Sources.Constant desiredT_sup(k=293)
    annotation (Placement(transformation(extent={{62,-26},{42,-6}})));
  .AixLib.Airflow.AirHandlingUnit.AHU ahu(
    clockPeriodGeneric=30,
    heating=true,
    cooling=true,
    HRS=true) annotation (Placement(transformation(extent={{-68,-18},{26,18}})));
  Modelica.Blocks.Sources.Constant phi_roomMin(k=0.47)
    annotation (Placement(transformation(extent={{68,-56},{48,-36}})));
  Modelica.Blocks.Sources.Constant phi_roomMax(k=0.55)
    annotation (Placement(transformation(extent={{98,-56},{78,-36}})));

  Modelica.Blocks.Sources.Sine waterLoadOutside(
    f=1/86400,
    offset=0.008,
    amplitude=0.002,
    phase=-0.054829518451402)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Sources.Constant phi_RoomExtractAir(k=0.6)
    annotation (Placement(transformation(extent={{98,-24},{78,-4}})));
  Modelica.Blocks.Sources.Sine tempAddInRoom(
    f=1/86400,
    amplitude=2,
    phase=-3.1415/4,
    offset=1.7) annotation (Placement(transformation(extent={{98,20},{78,40}})));
  Modelica.Blocks.Math.Add addToExtractTemp
    annotation (Placement(transformation(extent={{46,12},{34,24}})));
  Modelica.Blocks.Interfaces.RealOutput QFlowCool(
   final quantity="Power",
   final unit="W") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-26,-86})));
  Modelica.Blocks.Interfaces.RealOutput QFlowHeat(
   final quantity="Power",
   final unit="W") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-86})));
  Modelica.Blocks.Interfaces.RealOutput PEl(
   final quantity="Power",
   final unit="W") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={26,-86})));
equation

  connect(desiredT_sup.y, ahu.T_supplyAir) annotation (Line(
      points={{41,-16},{34,-16},{34,-6.3},{18.48,-6.3}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tempOutside.y, ahu.T_outdoorAir) annotation (Line(
      points={{-79,-6},{-74,-6},{-74,-7.2},{-62.36,-7.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Vflow_in.y, ahu.Vflow_in) annotation (Line(
      points={{-79,34},{-76,34},{-76,-4.5},{-66.12,-4.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMin.y, ahu.phi_supplyAir[1]) annotation (Line(
      points={{47,-46},{32,-46},{32,-9.9},{18.48,-9.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(waterLoadOutside.y, ahu.X_outdoorAir) annotation (Line(
      points={{-79,-40},{-72,-40},{-72,-11.7},{-62.36,-11.7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_RoomExtractAir.y, ahu.phi_extractAir) annotation (Line(
      points={{77,-14},{66,-14},{66,0},{30,0},{30,5.4},{18.48,5.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMax.y, ahu.phi_supplyAir[2]) annotation (Line(points={{77,-46},
          {72,-46},{72,-66},{28,-66},{28,-11.7},{18.48,-11.7}},       color={0,0,
          127}));
  connect(ahu.T_extractAir, addToExtractTemp.y) annotation (Line(points={{18.48,
          9.9},{27.92,9.9},{27.92,18},{33.4,18}},         color={0,0,127}));
  connect(tempAddInRoom.y, addToExtractTemp.u1) annotation (Line(points={{77,30},
          {66,30},{56,30},{56,21.6},{47.2,21.6}}, color={0,0,127}));
  connect(desiredT_sup.y, addToExtractTemp.u2) annotation (Line(points={{41,-16},
          {38,-16},{38,6},{56,6},{56,14.4},{47.2,14.4}}, color={0,0,127}));
  connect(ahu.QflowC, QFlowCool) annotation (Line(points={{-26.17,-15.75},{-26.17,
          -46.425},{-26,-46.425},{-26,-86}},        color={0,0,127}));
  connect(ahu.QflowH, QFlowHeat) annotation (Line(points={{-7.37,-15.75},{-7.37,
          -47.425},{0,-47.425},{0,-86}}, color={0,0,127}));
  connect(ahu.Pel, PEl) annotation (Line(points={{2.03,-15.75},{2.03,-47.425},{26,
          -47.425},{26,-86}},    color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-60,80},{-22,54}},
          lineColor={28,108,200},
          fontSize=6,
          textString="Heat        Cool        Dehu        Hu        HRS
1        1        1        1        1
1        1        1        0        1
1        1        0        1        1
1        1        0        0        1
1        0        0        0        1
0        1        0        0        1
0        0        0        0        1
1        1        1        1        0
1        1        1        0        0
1        1        0        1        0
1        1        0        0        0
1        0        0        0        0
0        1        0        0        0
0        0        0        0        0
"),     Text(
          extent={{-60,96},{-16,86}},
          lineColor={28,108,200},
          textString="Use the following Table for investigation of all possible modes.
Check whether variable allCond is always 1.")}),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-06),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Airflow/AirHandlingUnit/Examples/AHU.mos"
        "Simulate and plot"),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to check the behaviour of the simple Air Handling Unit
  models. Various possibilities for inputs are provided.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Temperature inputs are in Kelvin and the water load fraction is in
  kg(Water)/kg(Dry Air).
</p>
<p>
  Occupation and Schedule is a percentage value between 0 and 1.
</p>
<p>
  The zone parameter is needed to automatically calculate the air flow
  rate based on the occupation and room area.
</p>
</html>"));
end AHU;
