within AixLib.Systems.Benchmark_fb.Model.Building;
model Office_new
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_roof2
    annotation (Placement(transformation(extent={{-34,90},{-14,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_walls
    annotation (Placement(transformation(extent={{-108,-50},{-88,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_windows
    annotation (Placement(transformation(extent={{-108,30},{-88,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_floor
    annotation (Placement(transformation(extent={{-70,-108},{-50,-88}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_IntConvGains[5]
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_IntRadGains[5]
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealInput SolarRadIn[2] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-104,90})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = AixLib.Media.Air,
    V=10,
    nPorts=2,
    m_flow_nominal=3.375)
               annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-7,-59})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in[5](redeclare package Medium =
       AixLib.Media.Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
       AixLib.Media.Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  ThermalZones.ReducedOrder.RC.FourElements
                  thermalZoneFourElements[5](
    VAir={2700,1800,150,300,4050},
    each hConExt=2.5,
    each hConWin=1.3,
    each gWin=1,
    each ratioWinConRad=0.09,
    each nExt=4,
    RExt={{0.00056,0.03175,0.00533,0.00033},{0.00125,0.07143,0.012,0.00074},{0.005,
        0.28571,0.048,0.00294},{0.0025,0.14286,0.024,0.00147},{0.0005,0.02857,0.0048,
        0.00029}},
    CExt={{8100000,1112400,21600000,1620000},{3600000,494400,9600000,720000},{900000,
        123600,2400000,180000},{1800000,247200,4800000,360000},{9000000,1236000,
        24000000,1800000}},
    each hRad=5,
    AInt={90,180,60,90,90},
    each hConInt=2.5,
    each nInt=2,
    RInt={{0.00194,0.00033},{0.00097,0.00016},{0.00292,0.00049},{0.00194,0.00033},
        {0.00194,0.00033}},
    CInt={{7875000,1620000},{15750000,3240000},{5250000,1080000},{7875000,1620000},
        {7875000,1620000}},
    each RWin=0.01282,
    each RExtRem=0.00001,
    AFloor={900,600,50,100,1500},
    each hConFloor=2.5,
    each nFloor=4,
    RFloor={{0.00167,0.00012,0.00127,0.00004},{0.0025,0.00018,0.0019,0.00007},{0.03,
        0.00217,0.02286,0.00086},{0.015,0.00109,0.01143,0.00043},{0.00111,0.00008,
        0.00085,0.00003}},
    each RFloorRem=0.00001,
    CFloor={{7560000,517500000,4449600,108000000},{5040000,345000000,2966400,72000000},
        {420000,28750000,247200,6000000},{840000,57500000,494400,12000000},{11340000,
        776250000,6674400,162000000}},
    ARoof={900,600,50,100,1500},
    each hConRoof=2.5,
    each nRoof=4,
    RRoof={{0.00049,0.00008,0.00003,0.00001},{0.00074,0.00012,0.00005,0.00001},{
        0.00889,0.00139,0.00059,0.00001},{0.00444,0.00070,0.00029,0.00001},{0.00033,
        0.00005,0.00002,0.00001}},
    each RRoofRem=0.0001,
    CRoof={{2224800,331200000,16200000,0.09},{1483200,220800000,10800000,0.06},{
        123600,18400000,900000,0.005},{247200,36800000,1800000,0.01},{3337200,496800000,
        24300000,0.135}},
    each nOrientations=2,
    AWin={{90,90},{40,40},{20,0},{40,0},{100,100}},
    ATransparent={{72,72},{32,32},{16,0},{32,0},{80,80}},
    AExt={{45,45},{20,20},{30,0},{60,0},{95,95}},
    redeclare package Medium =  AixLib.Media.Air,
    each T_start=295.15,
    each nPorts=2)            "Thermal zone" annotation (Placement(transformation(extent={{-24,-18},
            {24,18}})));
  BusSystems.Bus_measure bus_measure
    annotation (Placement(transformation(extent={{68,58},{108,98}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_roof1
    annotation (Placement(transformation(extent={{-58,90},{-38,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_roof3
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_roof4
    annotation (Placement(transformation(extent={{14,90},{34,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_roof5
    annotation (Placement(transformation(extent={{38,90},{58,110}})));
equation
  connect(vol1.ports[1],Air_out)   annotation (Line(points={{2.66454e-15,-60.4},
          {2.66454e-15,-100},{0,-100}},
                                      color={0,127,255}));
  connect(Air_out, Air_out)
    annotation (Line(points={{0,-100},{0,-100}},   color={0,127,255}));
  connect(port_windows, port_windows)
    annotation (Line(points={{-98,40},{-98,40}}, color={191,0,0}));
  connect(port_walls, port_walls)
    annotation (Line(points={{-98,-40},{-98,-40}}, color={191,0,0}));

  connect(SolarRadIn[1], thermalZoneFourElements[1].solRad[1]) annotation (Line(
        points={{-104,80},{-64,80},{-64,14.5},{-25,14.5}}, color={0,0,127}));
  connect(SolarRadIn[2], thermalZoneFourElements[1].solRad[2]) annotation (Line(
        points={{-104,100},{-66,100},{-66,15.5},{-25,15.5}}, color={0,0,127}));
  connect(SolarRadIn[1], thermalZoneFourElements[2].solRad[1]) annotation (Line(
        points={{-104,80},{-65,80},{-65,14.5},{-25,14.5}}, color={0,0,127}));
  connect(SolarRadIn[2], thermalZoneFourElements[2].solRad[2]) annotation (Line(
        points={{-104,100},{-66,100},{-66,15.5},{-25,15.5}}, color={0,0,127}));
  connect(SolarRadIn[1], thermalZoneFourElements[3].solRad[1]) annotation (Line(
        points={{-104,80},{-66,80},{-66,14.5},{-25,14.5}}, color={0,0,127}));
  connect(SolarRadIn[2], thermalZoneFourElements[3].solRad[2]) annotation (Line(
        points={{-104,100},{-66,100},{-66,15.5},{-25,15.5}}, color={0,0,127}));
  connect(SolarRadIn[1], thermalZoneFourElements[4].solRad[1]) annotation (Line(
        points={{-104,80},{-65,80},{-65,14.5},{-25,14.5}}, color={0,0,127}));
  connect(SolarRadIn[2], thermalZoneFourElements[4].solRad[2]) annotation (Line(
        points={{-104,100},{-66,100},{-66,15.5},{-25,15.5}}, color={0,0,127}));
  connect(SolarRadIn[1], thermalZoneFourElements[5].solRad[1]) annotation (Line(
        points={{-104,80},{-64,80},{-64,14.5},{-25,14.5}}, color={0,0,127}));
  connect(SolarRadIn[2], thermalZoneFourElements[5].solRad[2]) annotation (Line(
        points={{-104,100},{-66,100},{-66,15.5},{-25,15.5}}, color={0,0,127}));
  connect(port_windows, thermalZoneFourElements[1].window) annotation (Line(
        points={{-98,40},{-73,40},{-73,4},{-24,4}}, color={191,0,0}));
  connect(port_windows, thermalZoneFourElements[2].window) annotation (Line(
        points={{-98,40},{-73,40},{-73,4},{-24,4}}, color={191,0,0}));
  connect(port_windows, thermalZoneFourElements[3].window) annotation (Line(
        points={{-98,40},{-72,40},{-72,4},{-24,4}}, color={191,0,0}));
  connect(port_windows, thermalZoneFourElements[4].window) annotation (Line(
        points={{-98,40},{-72,40},{-72,4},{-24,4}}, color={191,0,0}));
  connect(port_windows, thermalZoneFourElements[5].window) annotation (Line(
        points={{-98,40},{-73,40},{-73,4},{-24,4}}, color={191,0,0}));
  connect(port_walls, thermalZoneFourElements[1].extWall) annotation (Line(
        points={{-98,-40},{-62,-40},{-62,-4},{-24,-4}}, color={191,0,0}));
  connect(port_walls, thermalZoneFourElements[2].extWall) annotation (Line(
        points={{-98,-40},{-62,-40},{-62,-4},{-24,-4}}, color={191,0,0}));
  connect(port_walls, thermalZoneFourElements[3].extWall) annotation (Line(
        points={{-98,-40},{-62,-40},{-62,-4},{-24,-4}}, color={191,0,0}));
  connect(port_walls, thermalZoneFourElements[4].extWall) annotation (Line(
        points={{-98,-40},{-62,-40},{-62,-4},{-24,-4}}, color={191,0,0}));
  connect(port_walls, thermalZoneFourElements[5].extWall) annotation (Line(
        points={{-98,-40},{-62,-40},{-62,-4},{-24,-4}}, color={191,0,0}));
  connect(port_floor, thermalZoneFourElements[1].floor) annotation (Line(points=
         {{-60,-98},{-30,-98},{-30,-18},{0,-18}}, color={191,0,0}));
  connect(port_floor, thermalZoneFourElements[2].floor) annotation (Line(points=
         {{-60,-98},{-30,-98},{-30,-18},{0,-18}}, color={191,0,0}));
  connect(port_floor, thermalZoneFourElements[3].floor) annotation (Line(points=
         {{-60,-98},{-30,-98},{-30,-18},{0,-18}}, color={191,0,0}));
  connect(port_floor, thermalZoneFourElements[4].floor) annotation (Line(points=
         {{-60,-98},{-30,-98},{-30,-18},{0,-18}}, color={191,0,0}));
  connect(port_floor, thermalZoneFourElements[5].floor) annotation (Line(points=
         {{-60,-98},{-30,-98},{-30,-18},{0,-18}}, color={191,0,0}));
  connect(thermalZoneFourElements[1].ports[1], vol1.ports[2]) annotation (Line(
        points={{13.475,-17.95},{13.475,-36.975},{0,-36.975},{0,-57.6}},
                                                                 color={0,127,255}));
         connect(thermalZoneFourElements[2].ports[1], vol1.ports[2]) annotation (Line(
        points={{13.475,-17.95},{13.475,-36.975},{0,-36.975},{0,-57.6}},
                                                                 color={0,127,255}));
         connect(thermalZoneFourElements[3].ports[1], vol1.ports[2]) annotation (Line(
        points={{13.475,-17.95},{13.475,-36.975},{0,-36.975},{0,-57.6}},
                                                                 color={0,127,255}));
         connect(thermalZoneFourElements[4].ports[1], vol1.ports[2]) annotation (Line(
        points={{13.475,-17.95},{13.475,-36.975},{0,-36.975},{0,-57.6}},
                                                                 color={0,127,255}));
        connect(thermalZoneFourElements[5].ports[1], vol1.ports[2]) annotation (Line(
        points={{13.475,-17.95},{13.475,-36.975},{0,-36.975},{0,-57.6}},
                                                                 color={0,127,255}));

  connect(Air_in[1], thermalZoneFourElements[1].ports[2]) annotation (Line(points={{60,-108},
          {40,-108},{40,-17.95},{16.525,-17.95}},           color={0,127,255}));
           connect(Air_in[2], thermalZoneFourElements[2].ports[2]) annotation (Line(points={{60,-104},
          {40,-104},{40,-17.95},{16.525,-17.95}},           color={0,127,255}));
           connect(Air_in[3], thermalZoneFourElements[3].ports[2]) annotation (Line(points={{60,-100},
          {40,-100},{40,-17.95},{16.525,-17.95}},           color={0,127,255}));
           connect(Air_in[4], thermalZoneFourElements[4].ports[2]) annotation (Line(points={{60,-96},
          {40,-96},{40,-17.95},{16.525,-17.95}},            color={0,127,255}));
           connect(Air_in[5], thermalZoneFourElements[5].ports[2]) annotation (Line(points={{60,-92},
          {40,-92},{40,-17.95},{16.525,-17.95}},            color={0,127,255}));

  connect(thermalZoneFourElements[1].TAir, bus_measure.RoomTemp_Workshop)
    annotation (Line(points={{25,16},{52,16},{52,78.1},{88.1,78.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermalZoneFourElements[2].TAir, bus_measure.RoomTemp_Canteen)
    annotation (Line(points={{25,16},{52,16},{52,78.1},{88.1,78.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermalZoneFourElements[3].TAir, bus_measure.RoomTemp_Conferenceroom)
    annotation (Line(points={{25,16},{52,16},{52,78.1},{88.1,78.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermalZoneFourElements[4].TAir, bus_measure.RoomTemp_Multipersonoffice)
    annotation (Line(points={{25,16},{52,16},{52,78.1},{88.1,78.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermalZoneFourElements[5].TAir, bus_measure.RoomTemp_Openplanoffice)
    annotation (Line(points={{25,16},{52,16},{52,78.1},{88.1,78.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_roof1, thermalZoneFourElements[1].roof)
    annotation (Line(points={{-48,100},{-48,18},{-1.1,18}}, color={191,0,0}));
  connect(port_roof2, thermalZoneFourElements[2].roof)
    annotation (Line(points={{-24,100},{-24,18},{-1.1,18}}, color={191,0,0}));
  connect(port_roof3, thermalZoneFourElements[3].roof) annotation (Line(points=
          {{0,100},{0,60},{0,18},{-1.1,18}}, color={191,0,0}));
  connect(port_roof4, thermalZoneFourElements[4].roof)
    annotation (Line(points={{24,100},{24,18},{-1.1,18}}, color={191,0,0}));
  connect(port_roof5, thermalZoneFourElements[5].roof) annotation (Line(points=
          {{48,100},{50,100},{50,18},{-1.1,18}}, color={191,0,0}));
  connect(thermalZoneFourElements[1].intGainsRad, port_IntRadGains[1])
    annotation (Line(points={{24,8},{80,8},{80,32},{100,32}}, color={191,0,0}));
  connect(thermalZoneFourElements[2].intGainsRad, port_IntRadGains[2])
    annotation (Line(points={{24,8},{80,8},{80,42},{100,42},{100,36}}, color={
          191,0,0}));
  connect(thermalZoneFourElements[3].intGainsRad, port_IntRadGains[3])
    annotation (Line(points={{24,8},{80,8},{80,40},{100,40}}, color={191,0,0}));
  connect(thermalZoneFourElements[4].intGainsRad, port_IntRadGains[4])
    annotation (Line(points={{24,8},{80,8},{80,44},{100,44}}, color={191,0,0}));
  connect(thermalZoneFourElements[5].intGainsRad, port_IntRadGains[5])
    annotation (Line(points={{24,8},{80,8},{80,48},{100,48}}, color={191,0,0}));
  connect(thermalZoneFourElements[1].intGainsConv, port_IntConvGains[1])
    annotation (Line(points={{24,4},{30,4},{30,2},{80,2},{80,-42},{100,-42},{
          100,-48}}, color={191,0,0}));
  connect(thermalZoneFourElements[3].intGainsConv, port_IntConvGains[3])
    annotation (Line(points={{24,4},{80,4},{80,-40},{100,-40}}, color={191,0,0}));
  connect(thermalZoneFourElements[4].intGainsConv, port_IntConvGains[4])
    annotation (Line(points={{24,4},{26,4},{26,2},{80,2},{80,-36},{100,-36}},
        color={191,0,0}));
  connect(thermalZoneFourElements[5].intGainsConv, port_IntConvGains[5])
    annotation (Line(points={{24,4},{78,4},{78,-32},{100,-32}}, color={191,0,0}));
  connect(port_IntConvGains[2], thermalZoneFourElements[2].intGainsConv)
    annotation (Line(points={{100,-44},{96,-44},{96,-38},{80,-38},{80,4},{24,4}},
        color={191,0,0}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Office_new;
