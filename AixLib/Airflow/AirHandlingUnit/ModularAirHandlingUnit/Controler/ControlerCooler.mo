within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Controler;
model ControlerCooler
  parameter Boolean activeDehumidifying=false
    "true if active dehumidifying is done in cooler";
  Modelica.Blocks.Interfaces.RealInput xSup(start=0.007)
    "max. set value for absolute humidity of supply air"
                                                    annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}),   iconTransformation(
          extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput TsupSet(start=293.15)
    "set value for temperature at supply air outlet" annotation (Placement(
        transformation(extent={{-140,-40},{-100,0}}),   iconTransformation(
          extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-20})));
  Modelica.Blocks.Continuous.LimPID PID(
    k=0.1,
    Ti=0.5,
    Td=0.1,
    yMax=273.15 + 60,
    yMin=273.15)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Interfaces.RealInput Xout(start=0.01)
    "measured value for absolute humidity at cooler outlet" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-60})));
  Modelica.Blocks.Interfaces.RealOutput TcoolerSet
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
            10}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough if not activeDehumidifying
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Math.Min min_X if activeDehumidifying
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  //ThermalZones.ReducedOrder.Multizone.BaseClasses.RelToAbsHum relToAbsHum annotation (Placement(transformation(extent={{-72,44},{-52,64}})));
  Utilities.Psychrometrics.pW_X pWat(use_p_in=false)
    annotation (Placement(transformation(extent={{-30,62},{-10,82}})));
  Utilities.Psychrometrics.TDewPoi_pW dewPoi
    annotation (Placement(transformation(extent={{8,62},{28,82}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-24,102},{-4,122}})));
  Modelica.Blocks.Logical.Switch switch1 if activeDehumidifying
    annotation (Placement(transformation(extent={{86,84},{106,104}})));
equation
  connect(TsupSet, min_X.u2) annotation (Line(points={{-120,-20},{30,-20},{30,-16},
          {38,-16}}, color={0,0,127}));
  connect(realPassThrough.y, TcoolerSet) annotation (Line(points={{61,-50},{92,
          -50},{92,-10},{94,-10},{94,0},{110,0}}, color={0,0,127}));
  connect(TsupSet, realPassThrough.u) annotation (Line(points={{-120,-20},{32,
          -20},{32,-50},{38,-50}}, color={0,0,127}));
  connect(Xout, PID.u_m) annotation (Line(points={{-120,-60},{-50,-60},{-50,12},
          {-10,12},{-10,18}}, color={0,0,127}));
  connect(xSup, PID.u_s) annotation (Line(points={{-120,60},{-52,60},{-52,30},{-22,30}}, color={0,0,127}));
  connect(xSup, pWat.X_w) annotation (Line(points={{-120,60},{-80,60},{-80,72},
          {-31,72}}, color={0,0,127}));
  connect(pWat.p_w, dewPoi.p_w)
    annotation (Line(points={{-9,72},{7,72}}, color={0,0,127}));
  connect(dewPoi.T, min_X.u1) annotation (Line(points={{29,72},{32,72},{32,-4},
          {38,-4}}, color={0,0,127}));
  connect(Xout, greater.u1) annotation (Line(points={{-120,-60},{-120,112},{-26,
          112}}, color={0,0,127}));
  connect(xSup, greater.u2) annotation (Line(points={{-120,60},{-79,60},{-79,
          104},{-26,104}}, color={0,0,127}));
  connect(greater.y, switch1.u2) annotation (Line(points={{-3,112},{42,112},{42,
          94},{84,94}}, color={255,0,255}));
  connect(min_X.y, switch1.u1)
    annotation (Line(points={{61,-10},{61,102},{84,102}}, color={0,0,127}));
  connect(TsupSet, switch1.u3) annotation (Line(points={{-120,-20},{70,-20},{70,
          86},{84,86}}, color={0,0,127}));
  connect(switch1.y, TcoolerSet) annotation (Line(points={{107,94},{106,94},{
          106,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ControlerCooler;
