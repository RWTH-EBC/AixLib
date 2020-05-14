within AixLib.Fluid.HeatExchangers.ActiveWalls;
package PanelHeatingNew

  package AddVolumeDis "Steps to Discretization of floor heating volume"
    model VolumeDis2
      extends Modelica.Icons.ExamplesPackage;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater;
      final parameter Modelica.SIunits.Area A = floor.wall_length * floor.wall_length "Floor Area for Panel Heating";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
          Placement(transformation(extent={{-82,30},{-62,50}}), iconTransformation(
              extent={{-82,30},{-62,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{-8,-50},{8,-32}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
      Sources.MassFlowSource_T m_flow_specification(
        redeclare package Medium = Medium,
        m_flow=0.03,
        use_m_flow_in=true,
        use_T_in=true,
        nPorts=1,
        T=313.15)
        annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
      Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
            Medium, nPorts=1)
        annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
      ThermalZones.HighOrder.Components.Walls.Wall floor(outside=false, WallType=
            DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
        wall_length=5,
        wall_height=5)                                           annotation (
          Placement(transformation(
            extent={{-2,-12},{2,12}},
            rotation=90,
            origin={0,62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown annotation (
          Placement(transformation(extent={{-82,-50},{-62,-30}}),
                                                               iconTransformation(
              extent={{-82,30},{-62,50}})));
      ThermalZones.HighOrder.Components.Walls.Wall ceiling(
        outside=false,
        WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers(),
        wall_length=5,
        wall_height=5) annotation (Placement(transformation(
            extent={{2,-12},{-2,12}},
            rotation=90,
            origin={0,-62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
        annotation (Placement(transformation(extent={{-8,32},{8,50}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort
        annotation (Placement(transformation(extent={{38,-66},{52,-78}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature1
        annotation (Placement(transformation(extent={{86,36},{66,56}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
        annotation (Placement(transformation(extent={{36,66},{50,78}})));
      Modelica.Blocks.Sources.Step TRoom_set(
        height=-6,
        offset=299.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{118,36},{98,56}})));
      Modelica.Blocks.Sources.Step T_VL_set(
        height=24,
        offset=289.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
      Modelica.Blocks.Sources.Constant m_flow_Set(k=0.005)
        annotation (Placement(transformation(extent={{-192,14},{-172,34}})));
      Modelica.Blocks.Interfaces.RealOutput Power
        annotation (Placement(transformation(extent={{82,-96},{102,-76}})));
      FloorHeatingdisVolume2 floorHeatingdisVolume2(floorArea=A,
        redeclare package Medium = Medium,
        Spacing=0.2,
        allowFlowReversal=true)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      Power =abs(floor.thermStarComb_inside.conv.Q_flow + floor.thermStarComb_inside.rad.Q_flow);

      connect(thermCeiling, thermDown) annotation (Line(points={{0,-41},{0,-40},{-72,
              -40}},     color={191,0,0}));
      connect(ceiling.port_outside, thermCeiling)
        annotation (Line(points={{0,-59.9},{0,-41}}, color={191,0,0}));
      connect(ceiling.thermStarComb_inside, convRadToCombPort.portConvRadComb)
        annotation (Line(points={{-2.22045e-16,-64},{0,-64},{0,-72.975},{38.14,-72.975}},
            color={191,0,0}));
      connect(floor.thermStarComb_inside, convRadToCombPort1.portConvRadComb)
        annotation (Line(points={{0,64},{0,72.975},{36.14,72.975}},        color=
              {191,0,0}));
      connect(thermFloor, thermUp)
        annotation (Line(points={{0,41},{0,40},{-72,40}}, color={191,0,0}));
      connect(thermFloor, thermFloor)
        annotation (Line(points={{0,41},{0,41},{0,41}}, color={191,0,0}));
      connect(thermFloor, floor.port_outside)
        annotation (Line(points={{0,41},{0,59.9}}, color={191,0,0}));
      connect(TRoom_set.y, prescribedTemperature1.T)
        annotation (Line(points={{97,46},{88,46}}, color={0,0,127}));
      connect(convRadToCombPort1.portConv, prescribedTemperature1.port) annotation (
         Line(points={{50.07,68.175},{50.07,46},{66,46}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort1.portRad) annotation (
          Line(points={{66,46},{66,76},{50.28,76},{50.28,76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portRad) annotation (
          Line(points={{66,46},{66,-76.35},{52.28,-76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portConv) annotation (
          Line(points={{66,46},{52.07,46},{52.07,-68.175}}, color={191,0,0}));
      connect(m_flow_specification.T_in, T_VL_set.y) annotation (Line(points={{-156,
              4},{-160,4},{-160,-6},{-171,-6},{-171,-8}}, color={0,0,127}));
      connect(m_flow_Set.y, m_flow_specification.m_flow_in) annotation (Line(points=
             {{-171,24},{-168,24},{-168,16},{-156,16},{-156,8}}, color={0,0,127}));
      connect(m_flow_specification.ports[1], floorHeatingdisVolume2.port_a)
        annotation (Line(points={{-134,0},{-110,0}}, color={0,127,255}));
      connect(floorHeatingdisVolume2.port_b, boundary.ports[1])
        annotation (Line(points={{-90,0},{-70,0}}, color={0,127,255}));
      connect(floorHeatingdisVolume2.thermUp, thermUp)
        annotation (Line(points={{-100,9.8},{-100,40},{-72,40}}, color={191,0,0}));
      connect(floorHeatingdisVolume2.thermDown, thermDown) annotation (Line(points={
              {-100,-10},{-100,-40},{-72,-40}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
            Text(
              extent={{-14,98},{14,90}},
              lineColor={28,108,200},
              textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),         Line(points={{0,-66},{0,-92}},   color={28,108,200}),
            Line(points={{0,-92},{4,-88}},   color={28,108,200}),
            Line(points={{-4,-88},{0,-92}},  color={28,108,200}),
            Rectangle(extent={{-42,-92},{56,-100}},lineColor={28,108,200}),
            Text(
              extent={{-40,-94},{56,-98}},
              lineColor={28,108,200},
              textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
            Line(points={{0,92},{0,64}}, color={28,108,200}),
            Line(points={{0,64},{4,68}}, color={28,108,200}),
            Line(points={{-4,68},{0,64}}, color={28,108,200})}));
    end VolumeDis2;

    model VolumeDis
      extends Modelica.Icons.ExamplesPackage;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater;
          final parameter Modelica.SIunits.Area A = floor.wall_length * floor.wall_length "Floor Area for Panel Heating";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
          Placement(transformation(extent={{-82,30},{-62,50}}), iconTransformation(
              extent={{-82,30},{-62,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{-8,-50},{8,-32}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
      Sources.MassFlowSource_T m_flow_specification(
        redeclare package Medium = Medium,
        m_flow=0.03,
        use_m_flow_in=true,
        use_T_in=true,
        T=313.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
      Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
            Medium, nPorts=1)
        annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
      ThermalZones.HighOrder.Components.Walls.Wall floor(outside=false, WallType=
            DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
        wall_length=5,
        wall_height=5)                                           annotation (
          Placement(transformation(
            extent={{-2,-12},{2,12}},
            rotation=90,
            origin={0,62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown annotation (
          Placement(transformation(extent={{-82,-50},{-62,-30}}),
                                                               iconTransformation(
              extent={{-82,30},{-62,50}})));
      ThermalZones.HighOrder.Components.Walls.Wall ceiling(
        outside=false,
        WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers(),
        wall_length=5,
        wall_height=5) annotation (Placement(transformation(
            extent={{2,-12},{-2,12}},
            rotation=90,
            origin={0,-62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
        annotation (Placement(transformation(extent={{-8,32},{8,50}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort
        annotation (Placement(transformation(extent={{38,-66},{52,-78}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature1
        annotation (Placement(transformation(extent={{86,36},{66,56}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
        annotation (Placement(transformation(extent={{36,66},{50,78}})));
      Modelica.Blocks.Sources.Step TRoom_set(
        height=-6,
        offset=299.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{118,36},{98,56}})));
      Modelica.Blocks.Sources.Step T_VL_set(
        height=24,
        offset=289.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
      Modelica.Blocks.Sources.Constant m_flow_Set(k=0.005)
        annotation (Placement(transformation(extent={{-192,14},{-172,34}})));
      Modelica.Blocks.Interfaces.RealOutput Power
        annotation (Placement(transformation(extent={{82,-96},{102,-76}})));
      FloorHeatingdisVolume floorHeatingdisVolume(redeclare package Medium =
            Medium,
        allowFlowReversal=false,
        floorArea=A)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      Power =abs(floor.thermStarComb_inside.conv.Q_flow + floor.thermStarComb_inside.rad.Q_flow);

      connect(thermCeiling, thermDown) annotation (Line(points={{0,-41},{0,-40},{-72,
              -40}},     color={191,0,0}));
      connect(ceiling.port_outside, thermCeiling)
        annotation (Line(points={{0,-59.9},{0,-41}}, color={191,0,0}));
      connect(ceiling.thermStarComb_inside, convRadToCombPort.portConvRadComb)
        annotation (Line(points={{-2.22045e-16,-64},{0,-64},{0,-72.975},{38.14,-72.975}},
            color={191,0,0}));
      connect(floor.thermStarComb_inside, convRadToCombPort1.portConvRadComb)
        annotation (Line(points={{0,64},{0,72.975},{36.14,72.975}},        color=
              {191,0,0}));
      connect(thermFloor, thermUp)
        annotation (Line(points={{0,41},{0,40},{-72,40}}, color={191,0,0}));
      connect(thermFloor, thermFloor)
        annotation (Line(points={{0,41},{0,41},{0,41}}, color={191,0,0}));
      connect(thermFloor, floor.port_outside)
        annotation (Line(points={{0,41},{0,59.9}}, color={191,0,0}));
      connect(TRoom_set.y, prescribedTemperature1.T)
        annotation (Line(points={{97,46},{88,46}}, color={0,0,127}));
      connect(convRadToCombPort1.portConv, prescribedTemperature1.port) annotation (
         Line(points={{50.07,68.175},{50.07,46},{66,46}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort1.portRad) annotation (
          Line(points={{66,46},{66,76},{50.28,76},{50.28,76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portRad) annotation (
          Line(points={{66,46},{66,-76.35},{52.28,-76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portConv) annotation (
          Line(points={{66,46},{52.07,46},{52.07,-68.175}}, color={191,0,0}));
      connect(m_flow_specification.T_in, T_VL_set.y) annotation (Line(points={{-156,
              4},{-160,4},{-160,-6},{-171,-6},{-171,-8}}, color={0,0,127}));
      connect(m_flow_Set.y, m_flow_specification.m_flow_in) annotation (Line(points=
             {{-171,24},{-168,24},{-168,16},{-156,16},{-156,8}}, color={0,0,127}));
      connect(m_flow_specification.ports[1], floorHeatingdisVolume.port_a)
        annotation (Line(points={{-134,0},{-110,0}}, color={0,127,255}));
      connect(floorHeatingdisVolume.port_b, boundary.ports[1])
        annotation (Line(points={{-90,0},{-70,0}}, color={0,127,255}));
      connect(floorHeatingdisVolume.thermUp, thermUp) annotation (Line(points={
              {-100,9.8},{-100,40},{-72,40}}, color={191,0,0}));
      connect(floorHeatingdisVolume.thermDown, thermDown) annotation (Line(
            points={{-100,-10},{-100,-40},{-72,-40}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
            Text(
              extent={{-14,98},{14,90}},
              lineColor={28,108,200},
              textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),         Line(points={{0,-66},{0,-92}},   color={28,108,200}),
            Line(points={{0,-92},{4,-88}},   color={28,108,200}),
            Line(points={{-4,-88},{0,-92}},  color={28,108,200}),
            Rectangle(extent={{-42,-92},{56,-100}},lineColor={28,108,200}),
            Text(
              extent={{-40,-94},{56,-98}},
              lineColor={28,108,200},
              textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
            Line(points={{0,92},{0,64}}, color={28,108,200}),
            Line(points={{0,64},{4,68}}, color={28,108,200}),
            Line(points={{-4,68},{0,64}}, color={28,108,200})}));
    end VolumeDis;

    model Volume3x
      extends Modelica.Icons.ExamplesPackage;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater;
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
          Placement(transformation(extent={{-82,30},{-62,50}}), iconTransformation(
              extent={{-82,30},{-62,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{-8,-50},{8,-32}})));
      inner Modelica.Fluid.System system(allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
      Sources.MassFlowSource_T m_flow_specification(
        redeclare package Medium = Medium,
        m_flow=0.03,
        use_m_flow_in=true,
        use_T_in=true,
        T=313.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
      Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
            Medium, nPorts=1)
        annotation (Placement(transformation(extent={{38,-10},{18,10}})));
      ThermalZones.HighOrder.Components.Walls.Wall floor(outside=false, WallType=
            DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
        wall_length=5,
        wall_height=5)                                           annotation (
          Placement(transformation(
            extent={{-2,-12},{2,12}},
            rotation=90,
            origin={0,62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown annotation (
          Placement(transformation(extent={{-82,-50},{-62,-30}}),
                                                               iconTransformation(
              extent={{-82,30},{-62,50}})));
      ThermalZones.HighOrder.Components.Walls.Wall ceiling(
        outside=false,
        WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers(),
        wall_length=5,
        wall_height=5) annotation (Placement(transformation(
            extent={{2,-12},{-2,12}},
            rotation=90,
            origin={0,-62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
        annotation (Placement(transformation(extent={{-8,32},{8,50}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort
        annotation (Placement(transformation(extent={{38,-66},{52,-78}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature1
        annotation (Placement(transformation(extent={{86,36},{66,56}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
        annotation (Placement(transformation(extent={{36,66},{50,78}})));
      Modelica.Blocks.Sources.Step TRoom_set(
        height=-6,
        offset=299.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{118,36},{98,56}})));
      Modelica.Blocks.Sources.Step T_VL_set(
        height=24,
        offset=289.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
      Modelica.Blocks.Sources.Constant m_flow_Set(k=0.005)
        annotation (Placement(transformation(extent={{-192,14},{-172,34}})));
      Modelica.Blocks.Interfaces.RealOutput Power
        annotation (Placement(transformation(extent={{82,-96},{102,-76}})));
      FloorHeating3xVolume floorHeating3xVolume(redeclare package Medium =
            Medium, floorArea=floor.wall_length*floor.wall_height,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      Power =abs(floor.thermStarComb_inside.conv.Q_flow + floor.thermStarComb_inside.rad.Q_flow);

      connect(thermCeiling, thermDown) annotation (Line(points={{0,-41},{0,-40},{-72,
              -40}},     color={191,0,0}));
      connect(ceiling.port_outside, thermCeiling)
        annotation (Line(points={{0,-59.9},{0,-41}}, color={191,0,0}));
      connect(ceiling.thermStarComb_inside, convRadToCombPort.portConvRadComb)
        annotation (Line(points={{-2.22045e-16,-64},{0,-64},{0,-72.975},{38.14,-72.975}},
            color={191,0,0}));
      connect(floor.thermStarComb_inside, convRadToCombPort1.portConvRadComb)
        annotation (Line(points={{0,64},{0,72.975},{36.14,72.975}},        color=
              {191,0,0}));
      connect(thermFloor, thermUp)
        annotation (Line(points={{0,41},{0,40},{-72,40}}, color={191,0,0}));
      connect(thermFloor, thermFloor)
        annotation (Line(points={{0,41},{0,41},{0,41}}, color={191,0,0}));
      connect(thermFloor, floor.port_outside)
        annotation (Line(points={{0,41},{0,59.9}}, color={191,0,0}));
      connect(TRoom_set.y, prescribedTemperature1.T)
        annotation (Line(points={{97,46},{88,46}}, color={0,0,127}));
      connect(convRadToCombPort1.portConv, prescribedTemperature1.port) annotation (
         Line(points={{50.07,68.175},{50.07,46},{66,46}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort1.portRad) annotation (
          Line(points={{66,46},{66,76},{50.28,76},{50.28,76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portRad) annotation (
          Line(points={{66,46},{66,-76.35},{52.28,-76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portConv) annotation (
          Line(points={{66,46},{52.07,46},{52.07,-68.175}}, color={191,0,0}));
      connect(m_flow_specification.T_in, T_VL_set.y) annotation (Line(points={{-156,
              4},{-160,4},{-160,-6},{-171,-6},{-171,-8}}, color={0,0,127}));
      connect(m_flow_Set.y, m_flow_specification.m_flow_in) annotation (Line(points=
             {{-171,24},{-168,24},{-168,16},{-156,16},{-156,8}}, color={0,0,127}));
      connect(m_flow_specification.ports[1], floorHeating3xVolume.port_a)
        annotation (Line(points={{-134,0},{-110,0}}, color={0,127,255}));
      connect(floorHeating3xVolume.port_b, boundary.ports[1])
        annotation (Line(points={{-90,0},{18,0}}, color={0,127,255}));
      connect(floorHeating3xVolume.thermUp, thermUp) annotation (Line(points={{
              -100,9.8},{-100,40},{-72,40}}, color={191,0,0}));
      connect(floorHeating3xVolume.thermDown, thermDown) annotation (Line(
            points={{-100,-10},{-100,-40},{-72,-40}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
            Text(
              extent={{-14,98},{14,90}},
              lineColor={28,108,200},
              textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),         Line(points={{0,-66},{0,-92}},   color={28,108,200}),
            Line(points={{0,-92},{4,-88}},   color={28,108,200}),
            Line(points={{-4,-88},{0,-92}},  color={28,108,200}),
            Rectangle(extent={{-42,-92},{56,-100}},lineColor={28,108,200}),
            Text(
              extent={{-40,-94},{56,-98}},
              lineColor={28,108,200},
              textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
            Line(points={{0,92},{0,64}}, color={28,108,200}),
            Line(points={{0,64},{4,68}}, color={28,108,200}),
            Line(points={{-4,68},{0,64}}, color={28,108,200})}));
    end Volume3x;

    model Volume1x
      extends Modelica.Icons.ExamplesPackage;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater;
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
          Placement(transformation(extent={{-82,30},{-62,50}}), iconTransformation(
              extent={{-82,30},{-62,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{-8,-50},{8,-32}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
      Sources.MassFlowSource_T m_flow_specification(
        redeclare package Medium = Medium,
        m_flow=0.03,
        use_m_flow_in=true,
        use_T_in=true,
        nPorts=1,
        T=313.15)
        annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
      Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
            Medium, nPorts=1)
        annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
      ThermalZones.HighOrder.Components.Walls.Wall floor(outside=false, WallType=
            DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
        wall_length=5,
        wall_height=5)                                           annotation (
          Placement(transformation(
            extent={{-2,-12},{2,12}},
            rotation=90,
            origin={0,62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown annotation (
          Placement(transformation(extent={{-82,-50},{-62,-30}}),
                                                               iconTransformation(
              extent={{-82,30},{-62,50}})));
      ThermalZones.HighOrder.Components.Walls.Wall ceiling(
        outside=false,
        WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers(),
        wall_length=5,
        wall_height=5) annotation (Placement(transformation(
            extent={{2,-12},{-2,12}},
            rotation=90,
            origin={0,-62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
        annotation (Placement(transformation(extent={{-8,32},{8,50}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort
        annotation (Placement(transformation(extent={{38,-66},{52,-78}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature1
        annotation (Placement(transformation(extent={{86,36},{66,56}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
        annotation (Placement(transformation(extent={{36,66},{50,78}})));
      Modelica.Blocks.Sources.Step TRoom_set(
        height=-6,
        offset=299.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{118,36},{98,56}})));
      Modelica.Blocks.Sources.Step T_VL_set(
        height=24,
        offset=289.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
      Modelica.Blocks.Sources.Constant m_flow_Set(k=0.005)
        annotation (Placement(transformation(extent={{-192,14},{-172,34}})));
      FloorHeating1xVolume floorHeating1xVolume(floorArea=floor.wall_length*floor.wall_height,
          redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Blocks.Interfaces.RealOutput Power
        annotation (Placement(transformation(extent={{82,-96},{102,-76}})));
    equation
      Power =abs(floor.thermStarComb_inside.conv.Q_flow + floor.thermStarComb_inside.rad.Q_flow);

      connect(thermCeiling, thermDown) annotation (Line(points={{0,-41},{0,-40},{-72,
              -40}},     color={191,0,0}));
      connect(ceiling.port_outside, thermCeiling)
        annotation (Line(points={{0,-59.9},{0,-41}}, color={191,0,0}));
      connect(ceiling.thermStarComb_inside, convRadToCombPort.portConvRadComb)
        annotation (Line(points={{-2.22045e-16,-64},{0,-64},{0,-72.975},{38.14,-72.975}},
            color={191,0,0}));
      connect(floor.thermStarComb_inside, convRadToCombPort1.portConvRadComb)
        annotation (Line(points={{0,64},{0,72.975},{36.14,72.975}},        color=
              {191,0,0}));
      connect(thermFloor, thermUp)
        annotation (Line(points={{0,41},{0,40},{-72,40}}, color={191,0,0}));
      connect(thermFloor, thermFloor)
        annotation (Line(points={{0,41},{0,41},{0,41}}, color={191,0,0}));
      connect(thermFloor, floor.port_outside)
        annotation (Line(points={{0,41},{0,59.9}}, color={191,0,0}));
      connect(TRoom_set.y, prescribedTemperature1.T)
        annotation (Line(points={{97,46},{88,46}}, color={0,0,127}));
      connect(convRadToCombPort1.portConv, prescribedTemperature1.port) annotation (
         Line(points={{50.07,68.175},{50.07,46},{66,46}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort1.portRad) annotation (
          Line(points={{66,46},{66,76},{50.28,76},{50.28,76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portRad) annotation (
          Line(points={{66,46},{66,-76.35},{52.28,-76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portConv) annotation (
          Line(points={{66,46},{52.07,46},{52.07,-68.175}}, color={191,0,0}));
      connect(m_flow_specification.T_in, T_VL_set.y) annotation (Line(points={{-156,
              4},{-160,4},{-160,-6},{-171,-6},{-171,-8}}, color={0,0,127}));
      connect(m_flow_Set.y, m_flow_specification.m_flow_in) annotation (Line(points=
             {{-171,24},{-168,24},{-168,16},{-156,16},{-156,8}}, color={0,0,127}));
      connect(floorHeating1xVolume.thermUp, thermUp)
        annotation (Line(points={{-100,9.8},{-100,40},{-72,40}}, color={191,0,0}));
      connect(floorHeating1xVolume.thermDown, thermDown) annotation (Line(points={{-100,
              -10},{-100,-40},{-72,-40}}, color={191,0,0}));
      connect(m_flow_specification.ports[1], floorHeating1xVolume.port_a)
        annotation (Line(points={{-134,0},{-110,0}}, color={0,127,255}));
      connect(floorHeating1xVolume.port_b, boundary.ports[1])
        annotation (Line(points={{-90,0},{-70,0}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
            Text(
              extent={{-14,98},{14,90}},
              lineColor={28,108,200},
              textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),         Line(points={{0,-66},{0,-92}},   color={28,108,200}),
            Line(points={{0,-92},{4,-88}},   color={28,108,200}),
            Line(points={{-4,-88},{0,-92}},  color={28,108,200}),
            Rectangle(extent={{-42,-92},{56,-100}},lineColor={28,108,200}),
            Text(
              extent={{-40,-94},{56,-98}},
              lineColor={28,108,200},
              textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
            Line(points={{0,92},{0,64}}, color={28,108,200}),
            Line(points={{0,64},{4,68}}, color={28,108,200}),
            Line(points={{-4,68},{0,64}}, color={28,108,200})}));
    end Volume1x;

    model FloorHeatingdisVolume

      extends Modelica.Fluid.Interfaces.PartialTwoPort;
      extends Fluid.Interfaces.LumpedVolumeDeclarations;

      parameter Integer dis(min=1) = 3 "Number of Discreatisation Layers";

      parameter Modelica.SIunits.Diameter D = 0.1 "Diameter of floor heating tube";

      final parameter Real VWaterPerMeter = Modelica.Constants.pi * (D/2)^2 * 1 "Water Volume in tube per meter in m^3/m";

      parameter Modelica.SIunits.Area floorArea "Floor area in m^2";

      parameter Modelica.SIunits.Length Spacing = 0.1 "Spacing of floor heating in m";

      final parameter Modelica.SIunits.Length tubeLength = floorArea / Spacing "calculation of tube length";

      final parameter Modelica.SIunits.Volume VWater = VWaterPerMeter * tubeLength / dis "Volume of Water in m^3";

      parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature, in degrees Celsius";

      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium
          = Medium)
        annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
          Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
      MixingVolumes.MixingVolume          vol[dis](
        redeclare package Medium = Medium,
        energyDynamics=system.energyDynamics,
        T_start=T0,
        V=VWater,
        nPorts=2,
        m_flow_nominal=system.m_flow_nominal)
                  annotation (Placement(transformation(extent={{0,0},{22,22}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp
        annotation (Placement(transformation(extent={{-10,88},{10,108}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation

        // HEAT CONNECTIONS
      for i in 1:dis loop
        connect(vol[i].heatPort, thermUp) annotation (Line(
            points={{0,11},{0,98}},
            color={191,0,0},
            pattern=LinePattern.Dash));
        connect(vol[i].heatPort, thermDown) annotation (Line(
            points={{0,11},{0,-100}},
            color={191,0,0},
            pattern=LinePattern.Dash));
      end for;

      // FLOW CONNECTIONS

      //OUTER CONNECTIONS

      connect(TFlow.port_b, vol[1].ports[1]) annotation (Line(
          points={{-50,-26},{8.8,-26},{8.8,0}},
          color={0,127,255},
          pattern=LinePattern.Dash));
      connect(vol[dis].ports[2], TReturn.port_a) annotation (Line(
          points={{13.2,0},{14,0},{14,-26},{50,-26}},
          color={0,127,255},
          pattern=LinePattern.Dash));

      //INNER CONNECTIONS

      if dis > 1 then
        for i in 1:(dis-1) loop
          connect(vol[i].ports[2], vol[i + 1].ports[1]);
        end for;
      end if;
      connect(port_a, TFlow.port_a) annotation (Line(points={{-100,0},{-94,0},{-94,-26},
              {-70,-26}}, color={0,127,255}));
      connect(port_b, TReturn.port_b) annotation (Line(points={{100,0},{94,0},{94,-26},
              {70,-26}}, color={0,127,255}));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FloorHeatingdisVolume;

    model FloorHeatingdisVolume2

      extends Modelica.Fluid.Interfaces.PartialTwoPort;
      extends Fluid.Interfaces.LumpedVolumeDeclarations;

      parameter Integer dis(min=1) = 3 "Number of Discreatisation Layers";

      parameter Modelica.SIunits.Diameter D = 0.1 "Diameter of floor heating tube";

      final parameter Real VWaterPerMeter = Modelica.Constants.pi * (D/2)^2 * 1 "Water Volume in tube per meter in m^3/m";

      parameter Modelica.SIunits.Area floorArea "Floor area in m^2";

      parameter Modelica.SIunits.Length Spacing = 0.1 "Spacing of floor heating in m";

      final parameter Modelica.SIunits.Length tubeLength = floorArea / Spacing "calculation of tube length";

      final parameter Modelica.SIunits.Volume VWater = VWaterPerMeter * tubeLength / dis "Volume of Water in m^3";

      parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature, in degrees Celsius";

      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow[dis](redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
      Modelica.Fluid.Vessels.ClosedVolume vol[dis](
        redeclare package Medium = Medium,
        energyDynamics=system.energyDynamics,
        use_HeatTransfer=true,
        T_start=T0,
        redeclare model HeatTransfer =
            Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
        use_portsData=false,
        V=VWater,
        nPorts=2) annotation (Placement(transformation(extent={{0,0},{22,22}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp
        annotation (Placement(transformation(extent={{-10,88},{10,108}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation

        // HEAT CONNECTIONS
      for i in 1:dis loop
        connect(vol[i].heatPort, thermUp) annotation (Line(
            points={{0,11},{0,98}},
            color={191,0,0},
            pattern=LinePattern.Dash));
        connect(vol[i].heatPort, thermDown) annotation (Line(
            points={{0,11},{0,-100}},
            color={191,0,0},
            pattern=LinePattern.Dash));
      end for;

      // FLOW CONNECTIONS

      //OUTER CONNECTIONS

      connect(port_a, TFlow[1].port_a) annotation (Line(
          points={{-100,0},{-70,0},{-70,-26}},
          color={0,127,255},
          pattern=LinePattern.Dash));
      connect(vol[dis].ports[2], TReturn.port_a) annotation (Line(
          points={{13.2,0},{12,0},{12,-26},{50,-26}},
          color={0,127,255},
          pattern=LinePattern.Dash));

      //INNER CONNECTIONS

      if dis > 1 then
        for i in 1:(dis-1) loop
                connect(TFlow[i].port_b, vol[i].ports[1]) annotation (Line(
              points={{-50,-26},{8.8,-26},{8.8,0}},
              color={0,127,255},
              pattern=LinePattern.Dash));
                connect(vol[i].ports[2], TFlow[i + 1].port_a);
        end for;
      end if;
       connect(TFlow[dis].port_b, vol[dis].ports[1]);
      connect(TReturn.port_b, port_b) annotation (Line(points={{70,-26},{70,0},{100,
              0}},         color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FloorHeatingdisVolume2;

    model FloorHeating3xVolume

      extends Modelica.Fluid.Interfaces.PartialTwoPort;
      extends Fluid.Interfaces.LumpedVolumeDeclarations;

      parameter Modelica.SIunits.Diameter D = 0.1 "Diameter of floor heating tube";

      final parameter Real VWaterPerMeter = Modelica.Constants.pi * (D/2)^2 * 1 "Water Volume in tube per meter in m^3/m";

      parameter Modelica.SIunits.Area floorArea "Floor area in m^2";

      parameter Modelica.SIunits.Length Spacing = 0.1 "Spacing of floor heating in m";

      final parameter Modelica.SIunits.Length tubeLength = floorArea / Spacing "calculation of tube length";

      final parameter Modelica.SIunits.Volume VWater = VWaterPerMeter * tubeLength "Volume of Water in m^3";

      parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature, in degrees Celsius";

      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_1(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
          Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
      Modelica.Fluid.Vessels.ClosedVolume vol2(
        redeclare package Medium = Medium,
        energyDynamics=system.energyDynamics,
        use_HeatTransfer=true,
        T_start=T0,
        redeclare model HeatTransfer =
            Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
        use_portsData=false,
        nPorts=2,
        V=VWater/3)
                  annotation (Placement(transformation(extent={{0,0},{22,22}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp
        annotation (Placement(transformation(extent={{-10,88},{10,108}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Fluid.Vessels.ClosedVolume vol1(
        redeclare package Medium = Medium,
        energyDynamics=system.energyDynamics,
        use_HeatTransfer=true,
        T_start=T0,
        redeclare model HeatTransfer =
            Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
        use_portsData=false,
        nPorts=2,
        V=VWater/3)
                  annotation (Placement(transformation(extent={{-44,0},{-22,22}})));
      Modelica.Fluid.Vessels.ClosedVolume vol3(
        redeclare package Medium = Medium,
        energyDynamics=system.energyDynamics,
        use_HeatTransfer=true,
        T_start=T0,
        redeclare model HeatTransfer =
            Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
        use_portsData=false,
        nPorts=2,
        V=VWater/3)
                  annotation (Placement(transformation(extent={{32,0},{54,22}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_2(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{-26,-36},{-6,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_3(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{18,-36},{38,-16}})));
    equation
      connect(port_a, TFlow_1.port_a) annotation (Line(points={{-100,0},{-94,0},
              {-94,-26},{-70,-26}}, color={0,127,255}));
      connect(port_b, TReturn.port_b) annotation (Line(points={{100,0},{94,0},{94,-26},
              {70,-26}}, color={0,127,255}));
      connect(vol2.heatPort, thermUp)
        annotation (Line(points={{0,11},{0,98}}, color={191,0,0}));
      connect(vol2.heatPort, thermDown)
        annotation (Line(points={{0,11},{0,-100}}, color={191,0,0}));
      connect(TFlow_1.port_b, vol1.ports[1]) annotation (Line(points={{-50,-26},
              {-35.2,-26},{-35.2,0}}, color={0,127,255}));
      connect(vol1.ports[2], TFlow_2.port_a) annotation (Line(points={{-30.8,0},
              {-32,0},{-32,-26},{-26,-26}}, color={0,127,255}));
      connect(TFlow_2.port_b, vol2.ports[1]) annotation (Line(points={{-6,-26},
              {8.8,-26},{8.8,0}}, color={0,127,255}));
      connect(vol2.ports[2], TFlow_3.port_a) annotation (Line(points={{13.2,0},
              {12,0},{12,-26},{18,-26}}, color={0,127,255}));
      connect(TFlow_3.port_b, vol3.ports[1]) annotation (Line(points={{38,-26},
              {40.8,-26},{40.8,0}}, color={0,127,255}));
      connect(vol3.ports[2], TReturn.port_a) annotation (Line(points={{45.2,0},
              {48,0},{48,-26},{50,-26}}, color={0,127,255}));
      connect(vol1.heatPort, thermUp) annotation (Line(points={{-44,11},{-44,44},
              {0,44},{0,98}}, color={191,0,0}));
      connect(vol3.heatPort, thermUp) annotation (Line(points={{32,11},{32,44},
              {0,44},{0,98}}, color={191,0,0}));
      connect(vol1.heatPort, thermDown) annotation (Line(points={{-44,11},{-44,
              -44},{0,-44},{0,-100}}, color={191,0,0}));
      connect(vol3.heatPort, thermDown) annotation (Line(points={{32,11},{32,
              -44},{0,-44},{0,-100}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FloorHeating3xVolume;

    model FloorHeating1xVolume

      extends Modelica.Fluid.Interfaces.PartialTwoPort;

      parameter Modelica.SIunits.Diameter D = 0.1 "Diameter of floor heating tube";

      final parameter Real VWaterPerMeter = Modelica.Constants.pi * (D/2)^2 * 1 "Water Volume in tube per meter in m^3/m";

      parameter Modelica.SIunits.Area floorArea "Floor area in m^2";

      parameter Modelica.SIunits.Length Spacing = 0.1 "Spacing of floor heating in m";

      final parameter Modelica.SIunits.Length tubeLength = floorArea / Spacing "calculation of tube length";

      final parameter Modelica.SIunits.Volume VWater = VWaterPerMeter * tubeLength "Volume of Water in m^3";

      parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature, in degrees Celsius";

      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
          Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
      Modelica.Fluid.Vessels.ClosedVolume vol2(
        redeclare package Medium = Medium,
        energyDynamics=system.energyDynamics,
        use_HeatTransfer=true,
        T_start=T0,
        redeclare model HeatTransfer =
            Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
        use_portsData=false,
        V=VWater,
        nPorts=2) annotation (Placement(transformation(extent={{0,0},{22,22}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp
        annotation (Placement(transformation(extent={{-10,88},{10,108}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation
      connect(port_a, TFlow.port_a) annotation (Line(points={{-100,0},{-94,0},{-94,-26},
              {-70,-26}}, color={0,127,255}));
      connect(port_b, TReturn.port_b) annotation (Line(points={{100,0},{94,0},{94,-26},
              {70,-26}}, color={0,127,255}));
      connect(vol2.heatPort, thermUp)
        annotation (Line(points={{0,11},{0,98}}, color={191,0,0}));
      connect(vol2.heatPort, thermDown)
        annotation (Line(points={{0,11},{0,-100}}, color={191,0,0}));
      connect(TFlow.port_b, vol2.ports[1])
        annotation (Line(points={{-50,-26},{8.8,-26},{8.8,0}}, color={0,127,255}));
      connect(vol2.ports[2], TReturn.port_a) annotation (Line(points={{13.2,0},{14,0},
              {14,-26},{50,-26}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FloorHeating1xVolume;
  end AddVolumeDis;

  package OldPanelHeating
    model PanelHeating
      "A panel heating for e.g. floor heating with discretization"

      extends Modelica.Fluid.Interfaces.PartialTwoPort;

         parameter AixLib.DataBase.ActiveWalls.ActiveWallBaseDataDefinition floorHeatingType=
          DataBase.ActiveWalls.JocoKlimaBodenTOP2000_Parkett()
        annotation (Dialog(group="Type"), choicesAllMatching=true);

      parameter Boolean isFloor =  true "Floor or Ceiling heating"
        annotation(Dialog(compact = true, descriptionLabel = true), choices(
          choice = true "Floorheating",
          choice = false "Ceilingheating",
          radioButtons = true));

      parameter Integer dis(min=1) = 5 "Number of Discreatisation Layers";

      parameter Modelica.SIunits.Area A "Area of floor / heating panel part";

      parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature, in degrees Celsius";

      parameter Integer calcMethod=2 "Calculation method for convective heat transfer coefficient at surface" annotation (Dialog(group="Heat convection",
            descriptionLabel=true), choices(
          choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
          choice=2 "By Bernd Glueck",
          choice=3 "Custom hCon (constant)",
          radioButtons=true));

      parameter Modelica.SIunits.CoefficientOfHeatTransfer hCon_const=2.5 "Custom convective heat transfer coefficient"
        annotation (Dialog(group="Heat convection",
        descriptionLabel=true,
            enable=if calcMethod == 3 then true else false));

      final parameter Modelica.SIunits.Emissivity eps=floorHeatingType.eps
        "Emissivity";

      final parameter Real cTopRatio(min=0,max=1)= floorHeatingType.c_top_ratio;

      final parameter
        .AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.HeatCapacityPerArea cFloorHeating=
          floorHeatingType.C_ActivatedElement;

      final parameter
        .AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.HeatCapacityPerArea cTop=
          cFloorHeating*cTopRatio;

      final parameter
        .AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.HeatCapacityPerArea cDown=
          cFloorHeating*(1 - cTopRatio);

      final parameter Modelica.SIunits.Length tubeLength=A/floorHeatingType.Spacing;

      final parameter Modelica.SIunits.Volume VWater=
        Modelica.SIunits.Conversions.from_litre(floorHeatingType.VolumeWaterPerMeter*tubeLength)
          "Volume of Water";

      // ACCORDING TO GLUECK, Bauteilaktivierung 1999

      // According to equations 7.91 (for heat flow up) and 7.93 (for heat flow down) from page 41
      //   final parameter Modelica.SIunits.Temperature T_Floor_nom= if Floor then
      //     (floorHeatingType.q_dot_nom/8.92)^(1/1.1) + floorHeatingType.Temp_nom[3]
      //     else floorHeatingType.q_dot_nom/6.7 + floorHeatingType.Temp_nom[3];

      final parameter Modelica.SIunits.CoefficientOfHeatTransfer
        kTop_nominal=floorHeatingType.k_top;

      final parameter Modelica.SIunits.CoefficientOfHeatTransfer
        kDown_nominal = floorHeatingType.k_down;

      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
          Medium =
            Medium)
        annotation (Placement(transformation(extent={{60,-36},{80,-16}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermDown annotation (
          Placement(transformation(extent={{-10,-72},{10,-52}}),
            iconTransformation(extent={{-2,-38},{18,-18}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
          Placement(transformation(extent={{-10,48},{10,68}}), iconTransformation(
              extent={{4,30},{24,50}})));

      PanelHeatingSegment panelHeatingSegment(
        redeclare package Medium = Medium,
        A=A/dis,
        VWater=5,
        kTop=5,
        kDown=5,
        cTop=5,
        cDown=5) annotation (Placement(transformation(extent={{-8,0},{12,20}})));
    equation

      // HEAT CONNECTIONS
      for i in 1:dis loop
      end for;

      // FLOW CONNECTIONS

      //OUTER CONNECTIONS

      //INNER CONNECTIONS

      if dis > 1 then
        for i in 1:(dis-1) loop
        end for;
      end if;

      connect(port_a, TFlow.port_a) annotation (Line(
          points={{-100,0},{-88,0},{-88,-30},{-70,-30}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(TReturn.port_b, port_b) annotation (Line(
          points={{80,-26},{84,-26},{84,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(TFlow.port_b, panelHeatingSegment.port_a) annotation (Line(points={
              {-50,-30},{-50,10},{-8,10}}, color={0,127,255}));
      connect(panelHeatingSegment.thermDown, ThermDown)
        annotation (Line(points={{0.8,0},{0,0},{0,-62}}, color={191,0,0}));
      connect(panelHeatingSegment.thermUp, thermUp)
        annotation (Line(points={{0,19.8},{0,58}}, color={191,0,0}));
      connect(panelHeatingSegment.port_b, TReturn.port_a)
        annotation (Line(points={{12,10},{60,10},{60,-26}}, color={0,127,255}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                -60},{100,60}}), graphics={Rectangle(extent={{20,40},{40,20}},
                lineColor={191,0,0}), Text(
              extent={{22,34},{38,26}},
              lineColor={0,0,0},
              textString="dP")}),  Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-25},{100,35}}),
                                        graphics={
            Rectangle(
              extent={{-100,14},{100,-26}},
              lineColor={200,200,200},
              fillColor={150,150,150},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,35},{100,14}},
              lineColor={200,200,200},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-84,-2},{-76,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-68,-2},{-60,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-52,-2},{-44,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-36,-2},{-28,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-20,-2},{-12,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-4,-2},{4,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{12,-2},{20,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{28,-2},{36,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{44,-2},{52,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{60,-2},{68,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{76,-2},{84,-10}},
              lineColor={200,200,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,8},{-80,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None},
              thickness=1),
            Line(
              points={{-64,8},{-64,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-48,8},{-48,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-32,8},{-32,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-16,8},{-16,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{0,8},{0,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{16,8},{16,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{32,8},{32,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{48,8},{48,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{64,8},{64,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{80,8},{80,0}},
              color={255,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.None})}),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for floor heating, with one pipe running through the whole floor.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The assumption is made that there is one pipe that runs thorugh the whole floor. Which means that a discretisation of the floor heating is done, the discretisation elements will be connected in series: the flow temperature of one element is the return temperature of the element before.</p>
<p>The pressure drop is calculated at the end for the whole length of the pipe.</p>
<h4><span style=\"color:#008000\">Reference</span></h4>
<p>Source:</p>
<ul>
<li>Bernd Glueck, Bauteilaktivierung 1999, Page 41</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test\">AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test</a></p>
</html>",   revisions="<html>
<ul>
<li><i>February 06, 2017&nbsp;</i> by Philipp Mehrfeld:<br/>
Use kTop and kDown instead of k_insulation. Naming according to AixLib standards.</li>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>
Uses components from MSL</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>"));
    end PanelHeating;

    model OldPanelHeatingToWall
      extends Modelica.Icons.ExamplesPackage;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater;
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
          Placement(transformation(extent={{-82,30},{-62,50}}), iconTransformation(
              extent={{-82,30},{-62,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{-8,-50},{8,-32}})));
      OldPanelHeating.PanelHeating panelHeating(redeclare package Medium =
            Medium, A=floor.wall_length*floor.wall_height)
        annotation (Placement(transformation(extent={{-142,-2},{-122,4}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
      Sources.MassFlowSource_T boundary(nPorts=1, redeclare package Medium = Medium,
        m_flow=5)
        annotation (Placement(transformation(extent={{-176,-10},{-156,10}})));
      Modelica.Fluid.Sources.FixedBoundary boundary1(nPorts=2, redeclare
          package Medium =
                   Medium)
        annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
      ThermalZones.HighOrder.Components.Walls.Wall floor(outside=false, WallType=
            DataBase.Walls.Dummys.FloorForFloorHeating2Layers()) annotation (
          Placement(transformation(
            extent={{-2,-12},{2,12}},
            rotation=90,
            origin={0,62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown annotation (
          Placement(transformation(extent={{-82,-50},{-62,-30}}),
                                                               iconTransformation(
              extent={{-82,30},{-62,50}})));
      ThermalZones.HighOrder.Components.Walls.Wall floor1(outside=false, WallType=
            DataBase.Walls.Dummys.CeilingForFloorHeating3Layers()) annotation (
          Placement(transformation(
            extent={{2,-12},{-2,12}},
            rotation=90,
            origin={0,-62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
        annotation (Placement(transformation(extent={{-8,32},{8,50}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature
        annotation (Placement(transformation(extent={{88,-86},{78,-76}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort
        annotation (Placement(transformation(extent={{38,-78},{52,-66}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
        annotation (Placement(transformation(extent={{90,-66},{78,-54}})));
      Modelica.Blocks.Sources.Constant const1(k=273 + 20)
        annotation (Placement(transformation(extent={{112,-86},{102,-76}})));
      Modelica.Blocks.Sources.Constant const2(k=10)
        annotation (Placement(transformation(extent={{112,-64},{102,-54}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature1
        annotation (Placement(transformation(extent={{88,56},{78,66}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
        annotation (Placement(transformation(extent={{36,66},{50,78}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow1
        annotation (Placement(transformation(extent={{88,72},{76,84}})));
      Modelica.Blocks.Sources.Constant const3(k=273 + 20)
        annotation (Placement(transformation(extent={{112,56},{102,66}})));
      Modelica.Blocks.Sources.Constant const4(k=10)
        annotation (Placement(transformation(extent={{112,72},{102,82}})));
    equation

      connect(boundary.ports[1], panelHeating.port_a) annotation (Line(points={{-156,0},
              {-150,0},{-150,0.5},{-142,0.5}},        color={0,127,255}));
      connect(panelHeating.port_b, boundary1.ports[1]) annotation (Line(points={{-122,
              0.5},{-116,0.5},{-116,0},{-70,0},{-70,2}},    color={0,127,255}));
      connect(thermUp, panelHeating.thermUp) annotation (Line(points={{-72,40},{-130.6,
              40},{-130.6,4.5}},              color={191,0,0}));
      connect(panelHeating.ThermDown, thermDown) annotation (Line(points={{-131.2,-2.3},
              {-131.2,-40},{-72,-40}},
                                     color={191,0,0}));
      connect(thermCeiling, thermDown) annotation (Line(points={{0,-41},{0,-40},{-72,
              -40}},     color={191,0,0}));
      connect(floor1.port_outside, thermCeiling)
        annotation (Line(points={{0,-59.9},{0,-41}}, color={191,0,0}));
      connect(floor1.thermStarComb_inside, convRadToCombPort.portConvRadComb)
        annotation (Line(points={{-2.22045e-16,-64},{0,-64},{0,-71.025},{38.14,-71.025}},
            color={191,0,0}));
      connect(convRadToCombPort.portConv, prescribedTemperature.port) annotation (
         Line(points={{52.07,-75.825},{58,-75.825},{58,-81},{78,-81}}, color={191,
              0,0}));
      connect(convRadToCombPort.portRad, prescribedHeatFlow.port) annotation (
          Line(points={{52.28,-67.65},{78,-67.65},{78,-60}}, color={95,95,95}));
      connect(prescribedHeatFlow.Q_flow, const2.y) annotation (Line(points={{90,-60},
              {101.5,-60},{101.5,-59}},    color={0,0,127}));
      connect(prescribedTemperature.T, const1.y) annotation (Line(points={{89,-81},{
              101.5,-81}},            color={0,0,127}));
      connect(convRadToCombPort1.portConv, prescribedTemperature1.port)
        annotation (Line(points={{50.07,68.175},{56,68.175},{56,61},{78,61}},
            color={191,0,0}));
      connect(convRadToCombPort1.portRad, prescribedHeatFlow1.port) annotation (
          Line(points={{50.28,76.35},{76,76.35},{76,78}}, color={95,95,95}));
      connect(prescribedHeatFlow1.Q_flow, const4.y) annotation (Line(points={{88,78},
              {101.5,78},{101.5,77}},     color={0,0,127}));
      connect(prescribedTemperature1.T, const3.y)
        annotation (Line(points={{89,61},{101.5,61}}, color={0,0,127}));
      connect(floor.thermStarComb_inside, convRadToCombPort1.portConvRadComb)
        annotation (Line(points={{0,64},{0,72.975},{36.14,72.975}},        color=
              {191,0,0}));
      connect(thermFloor, thermUp)
        annotation (Line(points={{0,41},{0,40},{-72,40}}, color={191,0,0}));
      connect(thermFloor, thermFloor)
        annotation (Line(points={{0,41},{0,41},{0,41}}, color={191,0,0}));
      connect(thermFloor, floor.port_outside)
        annotation (Line(points={{0,41},{0,59.9}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
            Text(
              extent={{-14,98},{14,90}},
              lineColor={28,108,200},
              textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),         Line(points={{0,-66},{0,-92}},   color={28,108,200}),
            Line(points={{0,-92},{4,-88}},   color={28,108,200}),
            Line(points={{-4,-88},{0,-92}},  color={28,108,200}),
            Rectangle(extent={{-42,-92},{56,-100}},lineColor={28,108,200}),
            Text(
              extent={{-40,-94},{56,-98}},
              lineColor={28,108,200},
              textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
            Line(points={{0,92},{0,64}}, color={28,108,200}),
            Line(points={{0,64},{4,68}}, color={28,108,200}),
            Line(points={{-4,68},{0,64}}, color={28,108,200})}));
    end OldPanelHeatingToWall;

    model PanelHeatingSegment "One segment of the discretized panel heating"

    extends Modelica.Fluid.Interfaces.PartialTwoPort;

    parameter Boolean isFloor = true;

    parameter Modelica.SIunits.Area A = panelHeating.A "Area of Floor part";

    parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

    parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature, in degrees Celsius";

    parameter Modelica.SIunits.Volume VWater "Volume of Water in m^3";

    parameter Modelica.SIunits.CoefficientOfHeatTransfer kTop;
    parameter Modelica.SIunits.CoefficientOfHeatTransfer kDown;

    parameter
        .AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.HeatCapacityPerArea cTop;
    parameter
        .AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.HeatCapacityPerArea cDown;

      parameter Integer calcMethod=2 "Calculation method for convective heat transfer coefficient at surface"
        annotation (Dialog(group="Heat convection",
            descriptionLabel=true), choices(
            choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
            choice=2 "By Bernd Glueck",
            choice=3 "Custom hCon (constant)",
            radioButtons=true));

      parameter Modelica.SIunits.CoefficientOfHeatTransfer hCon_const=2.5 "Constant heat transfer coefficient"
        annotation (Dialog(group="Heat convection",
        descriptionLabel=true,
            enable=if calcMethod == 3 then true else false));

      Modelica.Fluid.Vessels.ClosedVolume vol(
        redeclare package Medium = Medium,
        energyDynamics=system.energyDynamics,
        use_HeatTransfer=true,
        T_start=T0,
        redeclare model HeatTransfer =
            Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
        use_portsData=false,
        V=VWater,
        nPorts=2) annotation (Placement(transformation(extent={{-12,-26},{10,-4}})));

      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
          Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
        annotation (Placement(transformation(extent={{-22,-110},{-2,-90}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp
        annotation (Placement(transformation(extent={{-30,88},{-10,108}})));
    equation

      connect(port_a, TFlow.port_a) annotation (Line(
          points={{-100,0},{-88,0},{-88,-26},{-70,-26}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(TFlow.port_b, vol.ports[1]) annotation (Line(
          points={{-50,-26},{-3.2,-26}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(vol.ports[2], TReturn.port_a) annotation (Line(
          points={{1.2,-26},{50,-26}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(TReturn.port_b, port_b) annotation (Line(
          points={{70,-26},{84,-26},{84,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(thermDown, thermDown) annotation (Line(
          points={{-12,-100},{-12,-100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(vol.heatPort, thermUp) annotation (Line(points={{-12,-15},{-18,-15},
              {-18,98},{-20,98}},
                             color={191,0,0}));
      connect(vol.heatPort, thermDown) annotation (Line(points={{-12,-15},{-12,
              -100}},      color={191,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
                                           Rectangle(extent={{20,40},{40,20}},
                lineColor={191,0,0}), Text(
              extent={{22,34},{38,26}},
              lineColor={0,0,0},
              textString="dP")}),    Icon(graphics={
            Rectangle(
              extent={{-100,20},{100,-22}},
              lineColor={0,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-100,66},{100,40}},
            lineColor={166,166,166},
            pattern=LinePattern.None,
            fillColor={190,190,190},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{100,100},{-100,66}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={156,156,156},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{100,40},{-100,20}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={156,156,156},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{100,-22},{-100,-56}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={156,156,156},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,-56},{100,-82}},
            lineColor={166,166,166},
            pattern=LinePattern.None,
            fillColor={190,190,190},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{100,-82},{-100,-102}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={156,156,156},
            fillPattern=FillPattern.Solid),
            Line(
              points={{-22,26},{-22,82}},
              color={255,0,0},
              thickness=0.5,
              arrow={Arrow.None,Arrow.Filled}),
            Text(
              extent={{-20,62},{62,40}},
              lineColor={255,0,0},
              textString="Q_flow"),
            Text(
              extent={{-20,-46},{62,-68}},
              lineColor={255,0,0},
              textString="Q_flow"),
            Line(
              points={{0,-28},{0,28}},
              color={255,0,0},
              thickness=0.5,
              arrow={Arrow.None,Arrow.Filled},
              origin={-22,-54},
              rotation=180)}),
        Documentation(revisions="<html>
<ul>
<li><i>February 06, 2017&nbsp;</i> by Philipp Mehrfeld:<br/>
Naming according to AixLib standards.</li>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>Added documentation.</li>
</ul>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a panel heating element, consisting of a water volume, heat conduction upwards and downwards through the wall layers, convection and radiation exchange at the room facing side.</p>
</html>"));
    end PanelHeatingSegment;

    model HeatConductionSegment

    parameter Modelica.SIunits.ThermalConductance kA
        "Constant thermal conductance of material";
    parameter Modelica.SIunits.HeatCapacity mc_p
        "Heat capacity of element (= cp*m)";
    parameter Modelica.SIunits.Temperature T0 "Initial Temperature of element";

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
        annotation (Placement(transformation(extent={{-108,-8},{-74,26}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
        annotation (Placement(transformation(extent={{74,-8},{108,26}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=2*kA)
        annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor2(                                                        G=
           2*kA) annotation (Placement(transformation(extent={{28,-2},{48,18}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
        heatCapacitor(                                                     T(start=
              T0), C=mc_p)
        annotation (Placement(transformation(extent={{-12,34},{8,54}})));
    equation
      connect(port_a, thermalConductor1.port_a) annotation (Line(
          points={{-91,9},{-46,9},{-46,10}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalConductor1.port_b, heatCapacitor.port) annotation (Line(
          points={{-26,10},{-24,10},{-24,28},{-2,28},{-2,34}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalConductor2.port_a, heatCapacitor.port) annotation (Line(
          points={{28,8},{20,8},{20,28},{-2,28},{-2,34}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalConductor2.port_b, port_b) annotation (Line(
          points={{48,8},{86,8},{86,10},{88,10},{88,9},{91,9}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(graphics={
          Rectangle(
            extent={{-100,-45.5},{100,45.5}},
            lineColor={166,166,166},
            pattern=LinePattern.None,
            fillColor={190,190,190},
            fillPattern=FillPattern.Solid,
              origin={0.5,0},
              rotation=90),
          Rectangle(
            extent={{100,30},{-100,-30}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={156,156,156},
            fillPattern=FillPattern.Solid,
              origin={-70,0},
              rotation=270),
          Rectangle(
            extent={{100,30},{-100,-30}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={156,156,156},
            fillPattern=FillPattern.Solid,
              origin={76,0},
              rotation=270),
            Line(
              points={{-72,-1},{72,-1}},
              color={255,0,0},
              thickness=0.5,
              arrow={Arrow.None,Arrow.Filled},
              origin={4,47},
              rotation=360),
            Line(
              points={{-72,-1},{72,-1}},
              color={255,0,0},
              thickness=0.5,
              arrow={Arrow.None,Arrow.Filled},
              origin={2,-33},
              rotation=180)}),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for heat conduction using elements from the MSL.</p>
</html>", revisions="<html>
<ul>
<li><i>February 06, 2017&nbsp;</i> by Philipp Mehrfeld:<br/>
Naming according to AixLib standards.</li>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>
Uses components from MSL</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>"));
    end HeatConductionSegment;
  end OldPanelHeating;

  package FindError
    "Package to find error in FloorHeatingdisVolume2 by starting the model again step by step"
    model RunStepByStep "Test model to find error in FloorHeating model"
      extends Modelica.Icons.ExamplesPackage;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater;

      Sources.MassFlowSource_T m_flow_specification(
        redeclare package Medium = Medium,
        m_flow=0.005,
        nPorts=1,
        use_m_flow_in=true,
        use_T_in=true,
        T=303.15)
        annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
      Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
            Medium, nPorts=1)
        annotation (Placement(transformation(extent={{38,-10},{18,10}})));
      Modelica.Blocks.Sources.Step T_VL_set(
        height=24,
        offset=289.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
      Modelica.Blocks.Sources.Constant m_flow_Set(k=0.005)
        annotation (Placement(transformation(extent={{-192,14},{-172,34}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
          Medium = Medium, allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-116,-10},{-96,10}})));
      Modelica.Fluid.Pipes.DynamicPipe pipe(
        redeclare package Medium = Medium,
        length=5,
        diameter=0.2,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package
          Medium = Medium, allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    equation


      connect(m_flow_specification.T_in, T_VL_set.y) annotation (Line(points={{-156,
              4},{-160,4},{-160,-6},{-171,-6},{-171,-8}}, color={0,0,127}));
      connect(m_flow_Set.y, m_flow_specification.m_flow_in) annotation (Line(points=
             {{-171,24},{-168,24},{-168,16},{-156,16},{-156,8}}, color={0,0,127}));
      connect(m_flow_specification.ports[1], temperature.port_a) annotation (
          Line(points={{-134,0},{-126,0},{-126,0},{-116,0}}, color={0,127,255}));
      connect(temperature.port_b, pipe.port_a) annotation (Line(points={{-96,0},
              {-84,0},{-84,-2},{-66,-2},{-66,0}}, color={0,127,255}));
      connect(pipe.port_b, temperature1.port_a)
        annotation (Line(points={{-46,0},{-30,0}}, color={0,127,255}));
      connect(temperature1.port_b, boundary.ports[1])
        annotation (Line(points={{-10,0},{18,0}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end RunStepByStep;

    model FloorHeatingStepByStep
      "Model to start floorheatingdisvolume2 from the beginning and step by step to find possible error"
      extends Modelica.Fluid.Interfaces.PartialTwoPort;
      extends Fluid.Interfaces.LumpedVolumeDeclarations;
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
            Medium, allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
            Medium, allowFlowReversal=false)
        annotation (Placement(transformation(extent={{38,-10},{58,10}})));
      Modelica.Fluid.Vessels.ClosedVolume vol(
        redeclare package Medium = Medium,
        use_HeatTransfer=true,
        V=5) annotation (Placement(transformation(extent={{0,6},{20,26}})));
    equation
      connect(port_a, TFlow.port_a)
        annotation (Line(points={{-100,0},{-60,0}}, color={0,127,255}));
      connect(TReturn.port_b, port_b)
        annotation (Line(points={{58,0},{100,0}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FloorHeatingStepByStep;

    model FloorHeating3xVolume

      extends Fluid.Interfaces.PartialTwoPort;
      extends Fluid.Interfaces.LumpedVolumeDeclarations;

      parameter Modelica.SIunits.Diameter D = 0.1 "Diameter of floor heating tube";

      final parameter Real VWaterPerMeter = Modelica.Constants.pi * (D/2)^2 * 1 "Water Volume in tube per meter in m^3/m";

      parameter Modelica.SIunits.Area floorArea "Floor area in m^2";

      parameter Modelica.SIunits.Length Spacing = 0.1 "Spacing of floor heating in m";

      final parameter Modelica.SIunits.Length tubeLength = floorArea / Spacing "calculation of tube length";

      final parameter Modelica.SIunits.Volume VWater = VWaterPerMeter * tubeLength "Volume of Water in m^3";

      parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature, in degrees Celsius";

      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_1(redeclare package Medium =
                   Medium)
        annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp
        annotation (Placement(transformation(extent={{-10,88},{10,108}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_2(redeclare package Medium =
                   Medium)
        annotation (Placement(transformation(extent={{-26,-36},{-6,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_3(redeclare package Medium =
                   Medium)
        annotation (Placement(transformation(extent={{18,-36},{38,-16}})));
      MixingVolumes.MixingVolume vol1(
        redeclare package Medium = Medium,
        V=VWater/3,
        nPorts=2,
        m_flow_nominal=system.m_flow_nominal)
        annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
      MixingVolumes.MixingVolume vol2(
        redeclare package Medium = Medium,
        V=VWater/3,
        nPorts=2,
        m_flow_nominal=system.m_flow_nominal)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));
      MixingVolumes.MixingVolume vol3(
        redeclare package Medium = Medium,
        V=VWater/3,
        nPorts=2,
        m_flow_nominal=system.m_flow_nominal)
        annotation (Placement(transformation(extent={{32,0},{52,20}})));
    equation
      connect(port_a, TFlow_1.port_a) annotation (Line(points={{-100,0},{-94,0},
              {-94,-26},{-70,-26}}, color={0,127,255}));
      connect(port_b, TReturn.port_b) annotation (Line(points={{100,0},{94,0},{94,-26},
              {70,-26}}, color={0,127,255}));
      connect(vol1.heatPort, thermUp) annotation (Line(points={{-48,10},{-48,56},{0,
              56},{0,98}}, color={191,0,0}));
      connect(vol2.heatPort, thermUp)
        annotation (Line(points={{0,10},{0,10},{0,98}}, color={191,0,0}));
      connect(vol3.heatPort, thermUp)
        annotation (Line(points={{32,10},{32,56},{0,56},{0,98}}, color={191,0,0}));
      connect(vol2.heatPort, thermDown)
        annotation (Line(points={{0,10},{0,-100}}, color={191,0,0}));
      connect(vol3.heatPort, thermDown) annotation (Line(points={{32,10},{32,-56},{0,
              -56},{0,-100}}, color={191,0,0}));
      connect(vol1.heatPort, thermDown) annotation (Line(points={{-48,10},{-48,-56},
              {0,-56},{0,-100}}, color={191,0,0}));
      connect(TFlow_1.port_b, vol1.ports[1])
        annotation (Line(points={{-50,-26},{-40,-26},{-40,0}}, color={0,127,255}));
      connect(vol1.ports[2], TFlow_2.port_a)
        annotation (Line(points={{-36,0},{-36,-26},{-26,-26}}, color={0,127,255}));
      connect(TFlow_2.port_b, vol2.ports[1])
        annotation (Line(points={{-6,-26},{8,-26},{8,0}}, color={0,127,255}));
      connect(vol2.ports[2], TFlow_3.port_a) annotation (Line(points={{12,0},{12,0},
              {12,-26},{18,-26}}, color={0,127,255}));
      connect(TFlow_3.port_b, vol3.ports[1])
        annotation (Line(points={{38,-26},{40,-26},{40,0}}, color={0,127,255}));
      connect(vol3.ports[2], TReturn.port_a)
        annotation (Line(points={{44,0},{44,-26},{50,-26}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FloorHeating3xVolume;

    model Volume3x
      extends Modelica.Icons.ExamplesPackage;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater;
          final parameter Modelica.SIunits.Area A = floor.wall_length * floor.wall_length "Floor Area for Panel Heating";

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
          Placement(transformation(extent={{-82,30},{-62,50}}), iconTransformation(
              extent={{-82,30},{-62,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{-8,-50},{8,-32}})));
      inner Modelica.Fluid.System system(allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
      Sources.MassFlowSource_T m_flow_specification(
        redeclare package Medium = Medium,
        m_flow=0.03,
        use_m_flow_in=true,
        use_T_in=true,
        T=313.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
      Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium =
            Medium, nPorts=1)
        annotation (Placement(transformation(extent={{38,-10},{18,10}})));
      ThermalZones.HighOrder.Components.Walls.Wall floor(outside=false, WallType=
            DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
        wall_length=5,
        wall_height=5)                                           annotation (
          Placement(transformation(
            extent={{-2,-12},{2,12}},
            rotation=90,
            origin={0,62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown annotation (
          Placement(transformation(extent={{-82,-50},{-62,-30}}),
                                                               iconTransformation(
              extent={{-82,30},{-62,50}})));
      ThermalZones.HighOrder.Components.Walls.Wall ceiling(
        outside=false,
        WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers(),
        wall_length=5,
        wall_height=5) annotation (Placement(transformation(
            extent={{2,-12},{-2,12}},
            rotation=90,
            origin={0,-62})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
        annotation (Placement(transformation(extent={{-8,32},{8,50}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort
        annotation (Placement(transformation(extent={{38,-66},{52,-78}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature1
        annotation (Placement(transformation(extent={{86,36},{66,56}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
        annotation (Placement(transformation(extent={{36,66},{50,78}})));
      Modelica.Blocks.Sources.Step TRoom_set(
        height=-6,
        offset=299.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{118,36},{98,56}})));
      Modelica.Blocks.Sources.Step T_VL_set(
        height=24,
        offset=289.15,
        startTime=43200)
        annotation (Placement(transformation(extent={{-192,-18},{-172,2}})));
      Modelica.Blocks.Sources.Constant m_flow_Set(k=0.005)
        annotation (Placement(transformation(extent={{-192,14},{-172,34}})));
      Modelica.Blocks.Interfaces.RealOutput Power
        annotation (Placement(transformation(extent={{82,-96},{102,-76}})));
      FloorHeating3xVolume floorHeating3xVolume(redeclare package Medium = Medium,
          floorArea=A)
        annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
    equation
      Power =abs(floor.thermStarComb_inside.conv.Q_flow + floor.thermStarComb_inside.rad.Q_flow);

      connect(thermCeiling, thermDown) annotation (Line(points={{0,-41},{0,-40},{-72,
              -40}},     color={191,0,0}));
      connect(ceiling.port_outside, thermCeiling)
        annotation (Line(points={{0,-59.9},{0,-41}}, color={191,0,0}));
      connect(ceiling.thermStarComb_inside, convRadToCombPort.portConvRadComb)
        annotation (Line(points={{-2.22045e-16,-64},{0,-64},{0,-72.975},{38.14,-72.975}},
            color={191,0,0}));
      connect(floor.thermStarComb_inside, convRadToCombPort1.portConvRadComb)
        annotation (Line(points={{0,64},{0,72.975},{36.14,72.975}},        color=
              {191,0,0}));
      connect(thermFloor, thermUp)
        annotation (Line(points={{0,41},{0,40},{-72,40}}, color={191,0,0}));
      connect(thermFloor, thermFloor)
        annotation (Line(points={{0,41},{0,41},{0,41}}, color={191,0,0}));
      connect(thermFloor, floor.port_outside)
        annotation (Line(points={{0,41},{0,59.9}}, color={191,0,0}));
      connect(TRoom_set.y, prescribedTemperature1.T)
        annotation (Line(points={{97,46},{88,46}}, color={0,0,127}));
      connect(convRadToCombPort1.portConv, prescribedTemperature1.port) annotation (
         Line(points={{50.07,68.175},{50.07,46},{66,46}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort1.portRad) annotation (
          Line(points={{66,46},{66,76},{50.28,76},{50.28,76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portRad) annotation (
          Line(points={{66,46},{66,-76.35},{52.28,-76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, convRadToCombPort.portConv) annotation (
          Line(points={{66,46},{52.07,46},{52.07,-68.175}}, color={191,0,0}));
      connect(m_flow_specification.T_in, T_VL_set.y) annotation (Line(points={{-156,
              4},{-160,4},{-160,-6},{-171,-6},{-171,-8}}, color={0,0,127}));
      connect(m_flow_Set.y, m_flow_specification.m_flow_in) annotation (Line(points=
             {{-171,24},{-168,24},{-168,16},{-156,16},{-156,8}}, color={0,0,127}));
      connect(m_flow_specification.ports[1], floorHeating3xVolume.port_a)
        annotation (Line(points={{-134,0},{-106,0}}, color={0,127,255}));
      connect(floorHeating3xVolume.thermDown, thermDown) annotation (Line(points={{-96,
              -10},{-96,-28},{-72,-28},{-72,-40}}, color={191,0,0}));
      connect(floorHeating3xVolume.thermUp, thermUp) annotation (Line(points={{-96,9.8},
              {-96,38},{-72,38},{-72,40}}, color={191,0,0}));
      connect(floorHeating3xVolume.port_b, boundary.ports[1])
        annotation (Line(points={{-86,0},{18,0}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
            Text(
              extent={{-14,98},{14,90}},
              lineColor={28,108,200},
              textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),         Line(points={{0,-66},{0,-92}},   color={28,108,200}),
            Line(points={{0,-92},{4,-88}},   color={28,108,200}),
            Line(points={{-4,-88},{0,-92}},  color={28,108,200}),
            Rectangle(extent={{-42,-92},{56,-100}},lineColor={28,108,200}),
            Text(
              extent={{-40,-94},{56,-98}},
              lineColor={28,108,200},
              textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
            Line(points={{0,92},{0,64}}, color={28,108,200}),
            Line(points={{0,64},{4,68}}, color={28,108,200}),
            Line(points={{-4,68},{0,64}}, color={28,108,200})}));
    end Volume3x;
  end FindError;
end PanelHeatingNew;
