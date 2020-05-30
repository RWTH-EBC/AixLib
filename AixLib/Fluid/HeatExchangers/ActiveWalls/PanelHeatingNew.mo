within AixLib.Fluid.HeatExchangers.ActiveWalls;
package PanelHeatingNew

  package AddVolumeDis "Steps to Discretization of floor heating volume"

    package Step1
      model VolumeDis2
        extends Modelica.Icons.ExamplesPackage;
        replaceable package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater;
        final parameter Modelica.SIunits.Area A = floor.wall_length * floor.wall_height "Floor Area for Panel Heating";
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
"),           Line(points={{0,-66},{0,-92}},   color={28,108,200}),
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
"),           Line(points={{0,-66},{0,-92}},   color={28,108,200}),
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
"),           Line(points={{0,-66},{0,-92}},   color={28,108,200}),
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
"),           Line(points={{0,-66},{0,-92}},   color={28,108,200}),
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
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow[dis](redeclare package
            Medium =
              Medium)
          annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
            Medium =
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
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package
            Medium =
              Medium)
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
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package
            Medium =
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
    end Step1;

    package FindError
      "Package to find error in FloorHeatingdisVolume2 by starting the model again step by step"

      model FloorHeating3xVolume

        extends Fluid.Interfaces.PartialTwoPort;
        extends Fluid.Interfaces.LumpedVolumeDeclarations;

        parameter Modelica.SIunits.Diameter D = 0.1 "Diameter of floor heating tube";

        final parameter Real VWaterPerMeter = Modelica.Constants.pi * (D/2)^2 * 1 "Water Volume in tube per meter in m^3/m";

        parameter Modelica.SIunits.Area floorArea "Floor area in m^2";

        parameter Modelica.SIunits.Length Spacing = 0.1 "Spacing of floor heating in m";

        final parameter Modelica.SIunits.Length tubeLength = floorArea / Spacing "calculation of tube length";

        final parameter Modelica.SIunits.Volume VWater = VWaterPerMeter * tubeLength "Volume of Water in m^3";

        final parameter Modelica.SIunits.Density d = 1000;

        final parameter Modelica.SIunits.Mass m = VWater/3*d;

        final parameter Modelica.SIunits.SpecificHeatCapacity c_p = 4190;

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
          annotation (Placement(transformation(extent={{-72,-34},{-58,-18}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
            Medium =
              Medium)
          annotation (Placement(transformation(extent={{50,-34},{64,-20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp
          annotation (Placement(transformation(extent={{-10,88},{10,108}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_2(redeclare package
            Medium = Medium)
          annotation (Placement(transformation(extent={{-26,-34},{-12,-20}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_3(redeclare package
            Medium = Medium)
          annotation (Placement(transformation(extent={{14,-34},{30,-20}})));
        MixingVolumes.MixingVolume vol1(
          redeclare package Medium = Medium,
          V=VWater/3,
          nPorts=2,
          m_flow_nominal=0.005,
          allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
        MixingVolumes.MixingVolume vol2(
          redeclare package Medium = Medium,
          V=VWater/3,
          nPorts=2,
          m_flow_nominal=0.005,
          allowFlowReversal=false)
          annotation (Placement(transformation(extent={{0,0},{20,20}})));
        MixingVolumes.MixingVolume vol3(
          redeclare package Medium = Medium,
          V=VWater/3,
          nPorts=2,
          m_flow_nominal=0.005,
          allowFlowReversal=false)
          annotation (Placement(transformation(extent={{32,0},{52,20}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
          heatCapacitor2(T(start=T0), C=m*c_p)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-68,80})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
          heatCapacitor1(T(start=T0), C=m*c_p)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-26,64})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
          heatCapacitor3(T(start=T0), C=m*c_p)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={46,64})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
          heatCapacitor4(T(start=T0), C=m*c_p)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,-76})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
          heatCapacitor5(T(start=T0), C=m*c_p)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-10,-58})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
          heatCapacitor6(T(start=T0), C=m*c_p)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={44,-72})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor
          thermalConductor(G=0.005*c_p) annotation (Placement(transformation(
              extent={{-7,-7},{7,7}},
              rotation=90,
              origin={-61,39})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor
          thermalConductor1(G=0.005*c_p) annotation (Placement(transformation(
              extent={{7,-7},{-7,7}},
              rotation=90,
              origin={-59,-55})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor
          thermalConductor2(G=0.005*c_p) annotation (Placement(transformation(
              extent={{-7,-7},{7,7}},
              rotation=90,
              origin={-19,41})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor
          thermalConductor3(G=0.005*c_p) annotation (Placement(transformation(
              extent={{7,-7},{-7,7}},
              rotation=90,
              origin={3,-43})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor
          thermalConductor4(G=0.005*c_p) annotation (Placement(transformation(
              extent={{-7,-7},{7,7}},
              rotation=90,
              origin={39,37})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor
          thermalConductor5(G=0.005*c_p) annotation (Placement(transformation(
              extent={{7,-7},{-7,7}},
              rotation=90,
              origin={35,-51})));
      equation
        connect(port_a, TFlow_1.port_a) annotation (Line(points={{-100,0},{-94,0},
                {-94,-26},{-72,-26}}, color={0,127,255}));
        connect(port_b, TReturn.port_b) annotation (Line(points={{100,0},{94,0},{
                94,-27},{64,-27}},
                           color={0,127,255}));
        connect(TFlow_1.port_b, vol1.ports[1])
          annotation (Line(points={{-58,-26},{-40,-26},{-40,0}}, color={0,127,255}));
        connect(vol1.ports[2], TFlow_2.port_a)
          annotation (Line(points={{-36,0},{-36,-27},{-26,-27}}, color={0,127,255}));
        connect(TFlow_2.port_b, vol2.ports[1])
          annotation (Line(points={{-12,-27},{8,-27},{8,0}},color={0,127,255}));
        connect(vol2.ports[2], TFlow_3.port_a) annotation (Line(points={{12,0},{
                12,-27},{14,-27}},  color={0,127,255}));
        connect(TFlow_3.port_b, vol3.ports[1])
          annotation (Line(points={{30,-27},{40,-27},{40,0}}, color={0,127,255}));
        connect(vol3.ports[2], TReturn.port_a)
          annotation (Line(points={{44,0},{44,-27},{50,-27}}, color={0,127,255}));
        connect(heatCapacitor2.port, thermUp)
          annotation (Line(points={{-58,80},{0,80},{0,98}}, color={191,0,0}));
        connect(heatCapacitor1.port, thermUp) annotation (Line(points={{-16,64},{
                0,64},{0,98}},          color={191,0,0}));
        connect(heatCapacitor3.port, thermUp) annotation (Line(points={{36,64},{0,
                64},{0,98}},            color={191,0,0}));
        connect(heatCapacitor4.port, thermDown) annotation (Line(points={{-50,-76},
                {-40,-76},{-40,-72},{0,-72},{0,-100}},
                                                  color={191,0,0}));
        connect(heatCapacitor5.port, thermDown)
          annotation (Line(points={{0,-58},{0,-100}}, color={191,0,0}));
        connect(heatCapacitor6.port, thermDown) annotation (Line(points={{34,-72},
                {0,-72},{0,-100}},               color={191,0,0}));
        connect(thermalConductor.port_a, vol1.heatPort) annotation (Line(points={
                {-61,32},{-58,32},{-58,10},{-48,10}}, color={191,0,0}));
        connect(thermalConductor.port_b, heatCapacitor2.port) annotation (Line(
              points={{-61,46},{-58,46},{-58,80}}, color={191,0,0}));
        connect(vol1.heatPort, thermalConductor1.port_a) annotation (Line(points=
                {{-48,10},{-48,-48},{-59,-48}}, color={191,0,0}));
        connect(thermalConductor1.port_b, heatCapacitor4.port) annotation (Line(
              points={{-59,-62},{-50,-62},{-50,-76}}, color={191,0,0}));
        connect(heatCapacitor1.port, thermalConductor2.port_b) annotation (Line(
              points={{-16,64},{-16,48},{-19,48}}, color={191,0,0}));
        connect(thermalConductor2.port_a, vol2.heatPort)
          annotation (Line(points={{-19,34},{0,34},{0,10}}, color={191,0,0}));
        connect(vol2.heatPort, thermalConductor3.port_a)
          annotation (Line(points={{0,10},{0,-36},{3,-36}}, color={191,0,0}));
        connect(thermalConductor3.port_b, heatCapacitor5.port) annotation (Line(
              points={{3,-50},{4,-50},{4,-58},{0,-58}}, color={191,0,0}));
        connect(vol3.heatPort, thermalConductor4.port_a)
          annotation (Line(points={{32,10},{32,30},{39,30}}, color={191,0,0}));
        connect(thermalConductor4.port_b, heatCapacitor3.port)
          annotation (Line(points={{39,44},{36,44},{36,64}}, color={191,0,0}));
        connect(vol3.heatPort, thermalConductor5.port_a)
          annotation (Line(points={{32,10},{32,-44},{35,-44}}, color={191,0,0}));
        connect(thermalConductor5.port_b, heatCapacitor6.port) annotation (Line(
              points={{35,-58},{34,-58},{34,-72}}, color={191,0,0}));
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
        FloorHeating3xVolume floorHeating3xVolume(
          redeclare package Medium = Medium,
          floorArea=A,
          allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-104,-10},{-84,10}})));
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
          annotation (Line(points={{-134,0},{-104,0}}, color={0,127,255}));
        connect(floorHeating3xVolume.port_b, boundary.ports[1])
          annotation (Line(points={{-84,0},{18,0},{18,0}}, color={0,127,255}));
        connect(thermUp, floorHeating3xVolume.thermUp) annotation (Line(points={{
                -72,40},{-80,40},{-80,20},{-94,20},{-94,9.8}}, color={191,0,0}));
        connect(floorHeating3xVolume.thermDown, thermDown) annotation (Line(
              points={{-94,-10},{-92,-10},{-92,-36},{-72,-36},{-72,-40}}, color={
                191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
              Text(
                extent={{-14,98},{14,90}},
                lineColor={28,108,200},
                textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),           Line(points={{0,-66},{0,-92}},   color={28,108,200}),
              Line(points={{0,-92},{4,-88}},   color={28,108,200}),
              Line(points={{-4,-88},{0,-92}},  color={28,108,200}),
              Rectangle(extent={{-42,-92},{56,-100}},lineColor={28,108,200}),
              Text(
                extent={{-40,-94},{56,-98}},
                lineColor={28,108,200},
                textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
              Line(points={{0,92},{0,64}}, color={28,108,200}),
              Line(points={{0,64},{4,68}}, color={28,108,200}),
              Line(points={{-4,68},{0,64}}, color={28,108,200}),
              Line(
                points={{-30,82},{-30,-82}},
                color={0,0,10},
                pattern=LinePattern.Dash),
              Text(
                extent={{-36,90},{-20,78}},
                lineColor={0,0,0},
                textString="Modellgrenze")}));
      end Volume3x;

      model Volume3xfloordis
        extends Modelica.Icons.ExamplesPackage;
        replaceable package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater;
            final parameter Modelica.SIunits.Area A = floor.wall_length * floor.wall_length "Floor Area for Panel Heating";

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling3
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
        ThermalZones.HighOrder.Components.Walls.Wall ceiling(
          outside=false,
          WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers(),
          wall_length=5,
          wall_height=5) annotation (Placement(transformation(
              extent={{2,-12},{-2,12}},
              rotation=90,
              origin={0,-62})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor3
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
        FloorHeating3xVolumefloordis floorHeating3xVolumefloordis(redeclare
            package Medium = Medium, floorArea=A)
          annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
        ThermalZones.HighOrder.Components.Walls.Wall floor1(
          outside=false,
          WallType=DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
          wall_length=5,
          wall_height=5)                                           annotation (
            Placement(transformation(
              extent={{-2,-12},{2,12}},
              rotation=90,
              origin={-34,62})));
        ThermalZones.HighOrder.Components.Walls.Wall floor2(
          outside=false,
          WallType=DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
          wall_length=5,
          wall_height=5)                                           annotation (
            Placement(transformation(
              extent={{-2,-12},{2,12}},
              rotation=90,
              origin={-68,62})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor1
          annotation (Placement(transformation(extent={{-78,32},{-62,50}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor2
          annotation (Placement(transformation(extent={{-42,32},{-26,50}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling1
          annotation (Placement(transformation(extent={{-98,-48},{-82,-30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling2
          annotation (Placement(transformation(extent={{-50,-50},{-34,-32}})));
        ThermalZones.HighOrder.Components.Walls.Wall ceiling1(
          outside=false,
          WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers(),
          wall_length=5,
          wall_height=5) annotation (Placement(transformation(
              extent={{2,-12},{-2,12}},
              rotation=90,
              origin={-42,-60})));
        ThermalZones.HighOrder.Components.Walls.Wall ceiling2(
          outside=false,
          WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers(),
          wall_length=5,
          wall_height=5) annotation (Placement(transformation(
              extent={{2,-12},{-2,12}},
              rotation=90,
              origin={-88,-60})));
      equation
        Power =abs(floor.thermStarComb_inside.conv.Q_flow + floor.thermStarComb_inside.rad.Q_flow);

        connect(ceiling.port_outside, thermCeiling3)
          annotation (Line(points={{0,-59.9},{0,-41}}, color={191,0,0}));
        connect(ceiling.thermStarComb_inside, convRadToCombPort.portConvRadComb)
          annotation (Line(points={{-2.22045e-16,-64},{0,-64},{0,-72.975},{38.14,-72.975}},
              color={191,0,0}));
        connect(floor.thermStarComb_inside, convRadToCombPort1.portConvRadComb)
          annotation (Line(points={{0,64},{0,72.975},{36.14,72.975}},        color=
                {191,0,0}));
        connect(thermFloor3, thermFloor3)
          annotation (Line(points={{0,41},{0,41},{0,41}}, color={191,0,0}));
        connect(thermFloor3, floor.port_outside)
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
        connect(m_flow_specification.ports[1], floorHeating3xVolumefloordis.port_a)
          annotation (Line(points={{-134,0},{-100,0}}, color={0,127,255}));
        connect(floorHeating3xVolumefloordis.port_b, boundary.ports[1])
          annotation (Line(points={{-80,0},{18,0}}, color={0,127,255}));
        connect(floorHeating3xVolumefloordis.thermUp1, thermFloor1) annotation (
           Line(points={{-95.8,9.8},{-95.8,41},{-70,41}}, color={191,0,0}));
        connect(floorHeating3xVolumefloordis.thermUp2, thermFloor2) annotation (
           Line(points={{-90.4,9.8},{-90.4,30},{-34,30},{-34,41}}, color={191,0,
                0}));
        connect(floorHeating3xVolumefloordis.thermUp3, thermFloor3) annotation (
           Line(points={{-86.2,9.8},{-86.2,22},{0,22},{0,41}}, color={191,0,0}));
        connect(floor2.port_outside, thermFloor1) annotation (Line(points={{-68,
                59.9},{-68,50},{-68,41},{-70,41}}, color={191,0,0}));
        connect(floor1.port_outside, thermFloor2)
          annotation (Line(points={{-34,59.9},{-34,41}}, color={191,0,0}));
        connect(convRadToCombPort1.portConvRadComb, floor1.thermStarComb_inside)
          annotation (Line(points={{36.14,72.975},{-34,72.975},{-34,64}}, color=
               {191,0,0}));
        connect(convRadToCombPort1.portConvRadComb, floor2.thermStarComb_inside)
          annotation (Line(points={{36.14,72.975},{-68,72.975},{-68,64}}, color=
               {191,0,0}));
        connect(floorHeating3xVolumefloordis.thermDown1, thermCeiling1)
          annotation (Line(points={{-94.6,-10},{-96,-10},{-96,-39},{-90,-39}},
              color={191,0,0}));
        connect(thermCeiling1, ceiling2.port_outside) annotation (Line(points={
                {-90,-39},{-90,-57.9},{-88,-57.9}}, color={191,0,0}));
        connect(floorHeating3xVolumefloordis.thermDown2, thermCeiling2)
          annotation (Line(points={{-90.4,-10},{-90,-10},{-90,-24},{-42,-24},{
                -42,-41}}, color={191,0,0}));
        connect(floorHeating3xVolumefloordis.thermDown3, thermCeiling3)
          annotation (Line(points={{-85.8,-10},{-86,-10},{-86,-20},{0,-20},{0,
                -41}}, color={191,0,0}));
        connect(thermCeiling2, ceiling1.port_outside)
          annotation (Line(points={{-42,-41},{-42,-57.9}}, color={191,0,0}));
        connect(convRadToCombPort.portConvRadComb, ceiling1.thermStarComb_inside)
          annotation (Line(points={{38.14,-72.975},{-42,-72.975},{-42,-62}},
              color={191,0,0}));
        connect(convRadToCombPort.portConvRadComb, ceiling2.thermStarComb_inside)
          annotation (Line(points={{38.14,-72.975},{-88,-72.975},{-88,-62}},
              color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
              Text(
                extent={{-14,98},{14,90}},
                lineColor={28,108,200},
                textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),           Line(points={{0,-66},{0,-92}},   color={28,108,200}),
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
      end Volume3xfloordis;

      model FloorHeating3xVolumefloordis

        extends Fluid.Interfaces.PartialTwoPort;
        extends Fluid.Interfaces.LumpedVolumeDeclarations;

        parameter Modelica.SIunits.Diameter D = 0.1 "Diameter of floor heating tube";

        final parameter Real VWaterPerMeter = Modelica.Constants.pi * (D/2)^2 * 1 "Water Volume in tube per meter in m^3/m";

        parameter Modelica.SIunits.Area floorArea "Floor area in m^2";

        parameter Modelica.SIunits.Length Spacing = 0.1 "Spacing of floor heating in m";

        final parameter Modelica.SIunits.Length tubeLength = floorArea / Spacing "calculation of tube length";

        final parameter Modelica.SIunits.Volume VWater = VWaterPerMeter * tubeLength "Volume of Water in m^3";

        final parameter Modelica.SIunits.Density d = 1000;

        final parameter Modelica.SIunits.Mass m = VWater/3*d;

        final parameter Modelica.SIunits.SpecificHeatCapacity c_p = 4190;

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
          annotation (Placement(transformation(extent={{-72,-34},{-58,-18}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
            Medium =
              Medium)
          annotation (Placement(transformation(extent={{50,-34},{64,-20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp3
          annotation (Placement(transformation(extent={{28,88},{48,108}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown3
          annotation (Placement(transformation(extent={{32,-110},{52,-90}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_2(redeclare package
            Medium = Medium)
          annotation (Placement(transformation(extent={{-26,-34},{-12,-20}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow_3(redeclare package
            Medium = Medium)
          annotation (Placement(transformation(extent={{14,-34},{30,-20}})));
        MixingVolumes.MixingVolume vol1(
          redeclare package Medium = Medium,
          V=VWater/3,
          nPorts=2,
          m_flow_nominal=0.005,
          allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
        MixingVolumes.MixingVolume vol2(
          redeclare package Medium = Medium,
          V=VWater/3,
          nPorts=2,
          m_flow_nominal=0.005,
          allowFlowReversal=false)
          annotation (Placement(transformation(extent={{0,0},{20,20}})));
        MixingVolumes.MixingVolume vol3(
          redeclare package Medium = Medium,
          V=VWater/3,
          nPorts=2,
          m_flow_nominal=0.005,
          allowFlowReversal=false)
          annotation (Placement(transformation(extent={{32,0},{52,20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp1
          annotation (Placement(transformation(extent={{-68,88},{-48,108}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp2
          annotation (Placement(transformation(extent={{-14,88},{6,108}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown1
          annotation (Placement(transformation(extent={{-56,-110},{-36,-90}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown2
          annotation (Placement(transformation(extent={{-14,-110},{6,-90}})));
      equation
        connect(port_a, TFlow_1.port_a) annotation (Line(points={{-100,0},{-94,0},
                {-94,-26},{-72,-26}}, color={0,127,255}));
        connect(port_b, TReturn.port_b) annotation (Line(points={{100,0},{94,0},{
                94,-27},{64,-27}},
                           color={0,127,255}));
        connect(TFlow_1.port_b, vol1.ports[1])
          annotation (Line(points={{-58,-26},{-40,-26},{-40,0}}, color={0,127,255}));
        connect(vol1.ports[2], TFlow_2.port_a)
          annotation (Line(points={{-36,0},{-36,-27},{-26,-27}}, color={0,127,255}));
        connect(TFlow_2.port_b, vol2.ports[1])
          annotation (Line(points={{-12,-27},{8,-27},{8,0}},color={0,127,255}));
        connect(vol2.ports[2], TFlow_3.port_a) annotation (Line(points={{12,0},{
                12,-27},{14,-27}},  color={0,127,255}));
        connect(TFlow_3.port_b, vol3.ports[1])
          annotation (Line(points={{30,-27},{40,-27},{40,0}}, color={0,127,255}));
        connect(vol3.ports[2], TReturn.port_a)
          annotation (Line(points={{44,0},{44,-27},{50,-27}}, color={0,127,255}));
        connect(thermUp1, vol1.heatPort) annotation (Line(points={{-58,98},{-60,
                98},{-60,10},{-48,10}}, color={191,0,0}));
        connect(thermUp2, vol2.heatPort)
          annotation (Line(points={{-4,98},{-4,10},{0,10}}, color={191,0,0}));
        connect(thermUp3, vol3.heatPort)
          annotation (Line(points={{38,98},{38,10},{32,10}}, color={191,0,0}));
        connect(thermDown1, vol1.heatPort) annotation (Line(points={{-46,-100},
                {-46,10},{-48,10}}, color={191,0,0}));
        connect(thermDown2, vol2.heatPort) annotation (Line(points={{-4,-100},{
                -6,-100},{-6,10},{0,10}}, color={191,0,0}));
        connect(thermDown3, vol3.heatPort) annotation (Line(points={{42,-100},{
                40,-100},{40,-52},{32,-52},{32,10}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end FloorHeating3xVolumefloordis;
    end FindError;

    package Step2
      model VolumeDis
        extends Modelica.Icons.ExamplesPackage;
        replaceable package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater;
            parameter Integer dis = 3;
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
          annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          prescribedTemperature1
          annotation (Placement(transformation(extent={{86,36},{66,56}})));
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
        FloorHeatingdisVolume floorHeatingdisVolume[dis](redeclare package
            Medium = Medium)
          annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
      equation
         if dis > 1 then
          for i in 1:(dis-1) loop
            connect(floorHeatingdisVolume[i].port_b, floorHeatingdisVolume[i+1].port_a);
          end for;
        end if;
              connect(TRoom_set.y, prescribedTemperature1.T)
          annotation (Line(points={{97,46},{88,46}}, color={0,0,127}));
        connect(m_flow_specification.T_in, T_VL_set.y) annotation (Line(points={{-156,
                4},{-160,4},{-160,-6},{-171,-6},{-171,-8}}, color={0,0,127}));
        connect(m_flow_Set.y, m_flow_specification.m_flow_in) annotation (Line(points=
               {{-171,24},{-168,24},{-168,16},{-156,16},{-156,8}}, color={0,0,127}));

        connect(m_flow_specification.ports[1], floorHeatingdisVolume[1].port_a)
          annotation (Line(points={{-134,0},{-112,0}}, color={0,127,255}));
        connect(floorHeatingdisVolume[dis].port_b, boundary.ports[1])
          annotation (Line(points={{-92,0},{-70,0}}, color={0,127,255}));
          for i in 1:dis loop
        connect(prescribedTemperature1.port, floorHeatingdisVolume[i].port_a1)
          annotation (Line(points={{66,46},{40,46},{40,48},{-100.4,48},{-100.4,10}},
              color={191,0,0}, pattern = LinePattern.Dash));
        connect(prescribedTemperature1.port, floorHeatingdisVolume[i].radPort)
          annotation (Line(points={{66,46},{-102.6,46},{-102.6,10}}, color={191,0,0}, pattern = LinePattern.Dash));
        connect(prescribedTemperature1.port, floorHeatingdisVolume[i].radPort1)
          annotation (Line(points={{66,46},{66,-40},{-102.6,-40},{-102.6,-10}}, color=
               {191,0,0}, pattern = LinePattern.Dash));
        connect(prescribedTemperature1.port, floorHeatingdisVolume[i].port_a2)
          annotation (Line(points={{66,46},{66,-42},{-98,-42},{-98,-9.8},{-100.8,-9.8}},
              color={191,0,0}, pattern = LinePattern.Dash));
          end for;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-72,100},{72,92}},lineColor={28,108,200}),
              Text(
                extent={{-14,98},{14,90}},
                lineColor={28,108,200},
                textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),           Line(points={{0,-92},{4,-88}},   color={28,108,200}),
              Line(points={{-4,-88},{0,-92}},  color={28,108,200}),
              Rectangle(extent={{-42,-92},{56,-100}},lineColor={28,108,200}),
              Text(
                extent={{-40,-94},{56,-98}},
                lineColor={28,108,200},
                textString="Wärmeabgabe an Raum unter der Fußbodenheizung")}));
      end VolumeDis;

      model FloorHeatingdisVolume

        extends Modelica.Fluid.Interfaces.PartialTwoPort;
        extends Fluid.Interfaces.LumpedVolumeDeclarations;

        final parameter Modelica.SIunits.Area A=floor.wall_length*floor.wall_length
          "Floor Area for Panel Heating";

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
        FloorHeatingBasic floorHeatingBasic(redeclare package Medium = Medium,
            floorArea=A)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        ThermalZones.HighOrder.Components.Walls.Wall floor(
          outside=false,
          WallType=DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
          wall_length=5,
          wall_height=5) annotation (Placement(transformation(
              extent={{-2,-12},{2,12}},
              rotation=90,
              origin={0,54})));
        ThermalZones.HighOrder.Components.Walls.Wall floor1(
          outside=false,
          wall_length=5,
          wall_height=5,
          WallType=DataBase.Walls.Dummys.CeilingForFloorHeating3Layers())
                         annotation (Placement(transformation(
              extent={{2,-12},{-2,12}},
              rotation=90,
              origin={0,-52})));
        Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
          annotation (Placement(transformation(extent={{-7,-6},{7,6}},
              rotation=90,
              origin={1,76})));
        Utilities.Interfaces.RadPort radPort
          annotation (Placement(transformation(extent={{-16,90},{4,110}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1
          annotation (Placement(transformation(extent={{6,90},{26,110}})));
        Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort2
          annotation (Placement(transformation(extent={{7,-6},{-7,6}},
              rotation=90,
              origin={1,-72})));
        Utilities.Interfaces.RadPort radPort1
          annotation (Placement(transformation(extent={{-16,-90},{4,-110}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a2
          annotation (Placement(transformation(extent={{2,-88},{22,-108}})));
      equation

          // HEAT CONNECTIONS

        // FLOW CONNECTIONS

        //OUTER CONNECTIONS

        //INNER CONNECTIONS

        connect(port_a, floorHeatingBasic.port_a)
          annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
        connect(floorHeatingBasic.port_b, port_b)
          annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
        connect(floor.port_outside, floorHeatingBasic.thermUp)
          annotation (Line(points={{0,51.9},{0,9.8}}, color={191,0,0}));
        connect(floorHeatingBasic.thermDown, floor1.port_outside)
          annotation (Line(points={{0,-10},{0,-49.9}}, color={191,0,0}));
        connect(convRadToCombPort1.portConvRadComb, floor.thermStarComb_inside)
          annotation (Line(points={{0.025,69.14},{0.025,62.57},{0,62.57},{0,56}},
              color={191,0,0}));
        connect(convRadToCombPort1.portRad, radPort) annotation (Line(points={{
                -3.35,83.28},{-3.35,87.64},{-6,87.64},{-6,100}}, color={95,95,
                95}));
        connect(convRadToCombPort1.portConv, port_a1) annotation (Line(points={
                {4.825,83.07},{16,83.07},{16,100}}, color={191,0,0}));
        connect(floor1.thermStarComb_inside, convRadToCombPort2.portConvRadComb)
          annotation (Line(points={{0,-54},{0,-60},{0,-65.14},{0.025,-65.14}},
              color={191,0,0}));
        connect(convRadToCombPort2.portRad, radPort1) annotation (Line(points={
                {-3.35,-79.28},{-3.35,-88.64},{-6,-88.64},{-6,-100}}, color={95,
                95,95}));
        connect(convRadToCombPort2.portConv, port_a2) annotation (Line(points={
                {4.825,-79.07},{4.825,-98},{12,-98}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end FloorHeatingdisVolume;

      model FloorHeatingBasic

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
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package
            Medium =
              Medium)
          annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
            Medium =
              Medium)
          annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
        MixingVolumes.MixingVolume vol(
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
          connect(vol.heatPort, thermUp) annotation (Line(
              points={{0,11},{0,98}},
              color={191,0,0}));
          connect(vol.heatPort, thermDown) annotation (Line(
              points={{0,11},{0,-100}},
              color={191,0,0}));

        // FLOW CONNECTIONS

        //OUTER CONNECTIONS

        connect(TFlow.port_b, vol.ports[1]) annotation (Line(
            points={{-50,-26},{8.8,-26},{8.8,0}},
            color={0,127,255}));
        connect(vol.ports[2], TReturn.port_a) annotation (Line(
            points={{13.2,0},{14,0},{14,-26},{50,-26}},
            color={0,127,255}));

        //INNER CONNECTIONS

        connect(port_a, TFlow.port_a) annotation (Line(points={{-100,0},{-94,0},{-94,-26},
                {-70,-26}}, color={0,127,255}));
        connect(port_b, TReturn.port_b) annotation (Line(points={{100,0},{94,0},{94,-26},
                {70,-26}}, color={0,127,255}));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end FloorHeatingBasic;

      model PipeTest
        replaceable package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system";

        Modelica.Fluid.Sources.MassFlowSource_T Source(
          m_flow=0.01,
          redeclare package Medium = Medium,
          use_m_flow_in=true,
          use_T_in=true,
          T=343.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
        Modelica.Blocks.Sources.Constant const2(k=0.005)
          annotation (Placement(transformation(extent={{-114,2},{-94,22}})));
        Modelica.Blocks.Sources.Step     const1(
          height=24,
          offset=289.15,
          startTime=42300)
          annotation (Placement(transformation(extent={{-110,-34},{-90,-14}})));
        Modelica.Fluid.Sources.FixedBoundary
                                        tank(redeclare package Medium = Medium,
            nPorts=1)
          annotation (Placement(transformation(extent={{88,-10},{66,10}})));
        inner Modelica.Fluid.System system(
          p_start=system.p_ambient,
          p_ambient(displayUnit="Pa"),
          allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package
            Medium = Medium)
          annotation (Placement(transformation(extent={{-36,-6},{-26,6}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
            Medium = Medium)
          annotation (Placement(transformation(extent={{26,-6},{36,6}})));
        Modelica.Fluid.Pipes.DynamicPipe pipe(
          use_HeatTransfer=true,
          length=30,
          diameter=0.1,
          redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
      equation
        connect(const2.y, Source.m_flow_in) annotation (Line(points={{-93,12},{
                -66,12},{-66,8}}, color={0,0,127}));
        connect(const1.y, Source.T_in) annotation (Line(points={{-89,-24},{-68,
                -24},{-68,4}}, color={0,0,127}));
        connect(Source.ports[1], TFlow.port_a)
          annotation (Line(points={{-46,0},{-36,0}}, color={0,127,255}));
        connect(TReturn.port_b, tank.ports[1])
          annotation (Line(points={{36,0},{66,0}}, color={0,127,255}));
        connect(TFlow.port_b, pipe.port_a)
          annotation (Line(points={{-26,0},{-12,0}}, color={0,127,255}));
        connect(pipe.port_b, TReturn.port_a)
          annotation (Line(points={{8,0},{26,0}}, color={0,127,255}));
      end PipeTest;
    end Step2;
  end AddVolumeDis;

  package OldPanelHeating

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

    parameter Modelica.SIunits.Area A "Area of Floor part";

    parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

    parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature, in degrees Celsius";

    parameter Modelica.SIunits.Volume VWater "Volume of Water in m^3";

    parameter Modelica.SIunits.CoefficientOfHeatTransfer kTop;
    parameter Modelica.SIunits.CoefficientOfHeatTransfer kDown;

    parameter BaseClasses.HeatCapacityPerArea cTop;
    parameter BaseClasses.HeatCapacityPerArea cDown;

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
        nPorts=2) annotation (Placement(transformation(extent={{-14,-26},{8,-4}})));

      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
          Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermConvWall
        annotation (Placement(transformation(extent={{-22,-110},{-2,-90}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermConvRoom
        annotation (Placement(transformation(extent={{-12,90},{8,110}})));
    equation

      connect(port_a, TFlow.port_a) annotation (Line(
          points={{-100,0},{-88,0},{-88,-26},{-70,-26}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(TFlow.port_b, vol.ports[1]) annotation (Line(
          points={{-50,-26},{-5.2,-26}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(vol.ports[2], TReturn.port_a) annotation (Line(
          points={{-0.8,-26},{50,-26}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(TReturn.port_b, port_b) annotation (Line(
          points={{70,-26},{84,-26},{84,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(thermConvWall, thermConvWall) annotation (Line(
          points={{-12,-100},{-12,-100}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(vol.heatPort, thermConvRoom) annotation (Line(points={{-14,-15},{
              -14,100},{-2,100}}, color={191,0,0}));
      connect(vol.heatPort, thermConvWall) annotation (Line(points={{-14,-15},{
              -14,-100},{-12,-100}}, color={191,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),  Icon(graphics={
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

    model PanelHeatingSingle
      extends Modelica.Icons.Example;
         replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"                annotation(choicesAllMatching = true);

      Modelica.Fluid.Sources.MassFlowSource_T Source(
        nPorts=1,
        m_flow=0.01,
        redeclare package Medium = Medium,
        use_m_flow_in=true,
        use_T_in=true,
        T=343.15)
        annotation (Placement(transformation(extent={{-94,8},{-74,28}})));
      Modelica.Fluid.Pipes.StaticPipe pipe1(
        diameter=0.02,
        redeclare package Medium = Medium,
        length=0.5)
        annotation (Placement(transformation(extent={{-62,12},{-46,26}})));
      Modelica.Fluid.Pipes.StaticPipe pipe2(
        length=10,
        diameter=0.02,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{62,14},{78,28}})));
      Modelica.Fluid.Sources.FixedBoundary
                                      tank(
        redeclare package Medium = Medium, nPorts=1)
        annotation (Placement(transformation(extent={{112,12},{92,30}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature fixedTemperature
        annotation (Placement(transformation(extent={{-36,-66},{-16,-46}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{40,8},{60,28}})));
      Modelica.Blocks.Sources.Step     const(
        height=-6,
        offset=299.15,
        startTime=42300)
        annotation (Placement(transformation(extent={{-94,50},{-74,70}})));
      Modelica.Blocks.Sources.Step     const1(
        height=24,
        offset=289.15,
        startTime=42300)
        annotation (Placement(transformation(extent={{-126,2},{-106,22}})));
      Modelica.Blocks.Sources.Constant const2(k=0.005)
        annotation (Placement(transformation(extent={{-128,32},{-108,52}})));
      inner Modelica.Fluid.System system(p_start=system.p_ambient,
          p_ambient(displayUnit="Pa"),
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Modelica.Blocks.Interfaces.RealOutput Treturn
        "Temperature of the passing fluid"
        annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
      Modelica.Blocks.Interfaces.RealOutput Tflow "Connector of Real output signal"
        annotation (Placement(transformation(extent={{100,-94},{120,-74}})));
      PanelHeating panelHeating(redeclare package Medium = Medium, A=25)
        annotation (Placement(transformation(extent={{-6,16},{14,22}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature fixedTemperature2
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={72,64})));
      BaseClasses.HeatConductionSegment
                            panel_Segment1(
        kA=67,
        mc_p=16440,
        T0=566.15)
               annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={6,46})));
      BaseClasses.HeatConductionSegment
                            panel_Segment2(
        kA=12.333,
        mc_p=63933,
        T0=566.15)    annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={4,-24})));
    equation

      connect(Source.ports[1],pipe1. port_a) annotation (Line(
          points={{-74,18},{-62,18},{-62,19}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe2.port_b, tank.ports[1]) annotation (Line(
          points={{78,21},{92,21}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe2.port_a, temperature.port_b) annotation (Line(
          points={{62,21},{62,18},{60,18}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(const.y, fixedTemperature.T) annotation (Line(
          points={{-73,60},{-72,60},{-72,-60},{-38,-60},{-38,-56}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const1.y, Source.T_in) annotation (Line(
          points={{-105,12},{-96,12},{-96,22}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const2.y, Source.m_flow_in) annotation (Line(
          points={{-107,42},{-104,42},{-104,38},{-94,38},{-94,26}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(temperature.T, Treturn) annotation (Line(
          points={{50,29},{50,42},{60,42},{60,-20},{110,-20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const1.y, Tflow) annotation (Line(
          points={{-105,12},{-96,12},{-96,-84},{110,-84}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pipe1.port_b, panelHeating.port_a) annotation (Line(points={{-46,
              19},{-36,19},{-36,18.5},{-6,18.5}}, color={0,127,255}));
      connect(panelHeating.port_b, temperature.port_a) annotation (Line(points=
              {{14,18.5},{26,18.5},{26,18},{40,18}}, color={0,127,255}));
      connect(const.y, fixedTemperature2.T) annotation (Line(points={{-73,60},{
              -70,60},{-70,90},{102,90},{102,62},{84,62},{84,64}}, color={0,0,
              127}));
      connect(panelHeating.thermConv, panel_Segment1.port_a) annotation (Line(
            points={{5.4,22.5},{5.4,29.25},{5.1,29.25},{5.1,36.9}}, color={191,
              0,0}));
      connect(panel_Segment1.port_b, fixedTemperature2.port) annotation (Line(
            points={{5.1,55.1},{5.1,64},{62,64}}, color={191,0,0}));
      connect(panelHeating.ThermDown, panel_Segment2.port_a) annotation (Line(
            points={{4.8,15.7},{4.8,-14.9},{4.9,-14.9}}, color={191,0,0}));
      connect(panel_Segment2.port_b, fixedTemperature.port) annotation (Line(
            points={{4.9,-33.1},{4,-33.1},{4,-56},{-16,-56}}, color={191,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
                -100},{120,100}})),
        Icon(coordinateSystem(extent={{-140,-100},{120,100}})),
        experiment(
          StopTime=86400,
          Interval=60,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<p>A simple test for <a href=\"AixLib.Fluid.HeatExchangers.ActiveWalls.Panel_Dis1D\">AixLib.Fluid.HeatExchangers.ActiveWalls.Panel_Dis1D</a> </p>
<p>Notice how the cahnge in flow temperature, amrking the change between heating and cooling mode is sudden, in order to prevent the mode from getting stuck.</p>
</html>",     revisions="<html>
<ul>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
</ul>
</html>"));
    end PanelHeatingSingle;

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

      parameter Integer dis(min=1) = 3 "Number of Discreatisation Layers";

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

      final parameter BaseClasses.HeatCapacityPerArea
        cFloorHeating=floorHeatingType.C_ActivatedElement;

      final parameter BaseClasses.HeatCapacityPerArea
        cTop=cFloorHeating * cTopRatio;

      final parameter BaseClasses.HeatCapacityPerArea
        cDown=cFloorHeating * (1-cTopRatio);

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
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{60,-36},{80,-16}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermDown annotation (
          Placement(transformation(extent={{-10,-72},{10,-52}}),
            iconTransformation(extent={{-2,-38},{18,-18}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermConv annotation (
          Placement(transformation(extent={{4,48},{24,68}}), iconTransformation(
              extent={{4,30},{24,50}})));
      BaseClasses.PanelHeatingSegment panelHeatingSegment1(
        redeclare package Medium = Medium,
        each final eps=eps,
        each final T0=T0,
        each final kTop=kTop_nominal,
        each final kDown=kDown_nominal,
        each final cTop=cTop,
        each final cDown=cDown,
        each final isFloor=isFloor,
        each final calcMethod=calcMethod,
        each final hCon_const=hCon_const,
        each final A=A/3,
        each final VWater=VWater/3)
        annotation (Placement(transformation(extent={{-88,21},{-72,38}})));

      BaseClasses.PanelHeatingSegment panelHeatingSegment2(
        redeclare package Medium = Medium,
        each final eps=eps,
        each final T0=T0,
        each final kTop=kTop_nominal,
        each final kDown=kDown_nominal,
        each final cTop=cTop,
        each final cDown=cDown,
        each final isFloor=isFloor,
        each final calcMethod=calcMethod,
        each final hCon_const=hCon_const,
        each final A=A/3,
        each final VWater=VWater/3)
        annotation (Placement(transformation(extent={{-60,21},{-44,38}})));
      BaseClasses.PanelHeatingSegment panelHeatingSegment3(
        redeclare package Medium = Medium,
        each final eps=eps,
        each final T0=T0,
        each final kTop=kTop_nominal,
        each final kDown=kDown_nominal,
        each final cTop=cTop,
        each final cDown=cDown,
        each final isFloor=isFloor,
        each final calcMethod=calcMethod,
        each final hCon_const=hCon_const,
        each final A=A/3,
        each final VWater=VWater/3)
        annotation (Placement(transformation(extent={{-30,21},{-14,38}})));
    equation



      connect(port_a, TFlow.port_a) annotation (Line(
          points={{-100,0},{-88,0},{-88,-30},{-70,-30}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(TReturn.port_b, port_b) annotation (Line(
          points={{80,-26},{84,-26},{84,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(TFlow.port_b, panelHeatingSegment1.port_a) annotation (Line(points={{-50,
              -30},{-50,14},{-94,14},{-94,29.5},{-88,29.5}}, color={0,127,255}));
      connect(panelHeatingSegment1.port_b, panelHeatingSegment2.port_a) annotation (
         Line(points={{-72,29.5},{-68,29.5},{-68,29.5},{-60,29.5}}, color={0,127,255}));
      connect(panelHeatingSegment2.port_b, panelHeatingSegment3.port_a) annotation (
         Line(points={{-44,29.5},{-42,29.5},{-42,29.5},{-30,29.5}}, color={0,127,255}));
      connect(panelHeatingSegment3.port_b, TReturn.port_a) annotation (Line(points={
              {-14,29.5},{0,29.5},{0,28},{60,28},{60,-26}}, color={0,127,255}));
      connect(panelHeatingSegment1.thermConvRoom, thermConv) annotation (Line(
            points={{-80.16,38},{-80,38},{-80,42},{14,42},{14,58}}, color={191,0,0}));
      connect(panelHeatingSegment2.thermConvRoom, thermConv) annotation (Line(
            points={{-52.16,38},{-20,38},{-20,58},{14,58}}, color={191,0,0}));
      connect(panelHeatingSegment3.thermConvRoom, thermConv) annotation (Line(
            points={{-22.16,38},{-4,38},{-4,58},{14,58}}, color={191,0,0}));
      connect(panelHeatingSegment1.thermConvWall, ThermDown) annotation (Line(
            points={{-80.96,21},{-80.96,2},{0,2},{0,-62}}, color={191,0,0}));
      connect(panelHeatingSegment2.thermConvWall, ThermDown) annotation (Line(
            points={{-52.96,21},{-52.96,6},{0,6},{0,-62}}, color={191,0,0}));
      connect(panelHeatingSegment3.thermConvWall, ThermDown) annotation (Line(
            points={{-22.96,21},{-22.96,12},{0,12},{0,-62}}, color={191,0,0}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                -60},{100,60}})),  Icon(coordinateSystem(preserveAspectRatio=false,
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
  end OldPanelHeating;

  package AddParameters
    "Package to collect models for adding the parameters that are used in DIN 1946"
    extends Modelica.Icons.Package;
    model FloorHeatingBasic

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
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
          Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
      MixingVolumes.MixingVolume vol(
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
        connect(vol.heatPort, thermUp) annotation (Line(
            points={{0,11},{0,98}},
            color={191,0,0}));
        connect(vol.heatPort, thermDown) annotation (Line(
            points={{0,11},{0,-100}},
            color={191,0,0}));

      // FLOW CONNECTIONS

      //OUTER CONNECTIONS

      connect(TFlow.port_b, vol.ports[1]) annotation (Line(
          points={{-50,-26},{8.8,-26},{8.8,0}},
          color={0,127,255}));
      connect(vol.ports[2], TReturn.port_a) annotation (Line(
          points={{13.2,0},{14,0},{14,-26},{50,-26}},
          color={0,127,255}));

      //INNER CONNECTIONS

      connect(port_a, TFlow.port_a) annotation (Line(points={{-100,0},{-94,0},{-94,-26},
              {-70,-26}}, color={0,127,255}));
      connect(port_b, TReturn.port_b) annotation (Line(points={{100,0},{94,0},{94,-26},
              {70,-26}}, color={0,127,255}));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FloorHeatingBasic;

    model PanelHeatingParameters
       replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium "Medium in the component";
       function logDT =
          AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.logDT;
          extends Modelica.Fluid.Interfaces.PartialTwoPort;

      Modelica.SIunits.TemperatureDifference sigma = TFlow.T - TReturn.T "Temperatur Spread of Panel Heating";
      final parameter Modelica.SIunits.Area A = floor.wall_length * floor.wall_length "Floor Area for Panel Heating";
      Modelica.SIunits.TemperatureDifference dT_H = logDT(Temp_in) "Temperature Difference between heating medium and Room";
      replaceable Modelica.SIunits.Temperature TRoom = 20+273.15 "Room Temperature";
        Modelica.SIunits.Temperature Temp_in[3] = {TFlow.T, TReturn.T, TRoom};

      FloorHeatingBasic floorHeatingBasic(redeclare package Medium = Medium,
          floorArea=A)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
      ThermalZones.HighOrder.Components.Walls.Wall floor(
        outside=false,
        WallType=DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
        wall_length=5,
        wall_height=5)                                           annotation (
          Placement(transformation(
            extent={{-2,-12},{2,12}},
            rotation=90,
            origin={0,62})));
      ThermalZones.HighOrder.Components.Walls.Wall floor1(
        outside=false,
        WallType=DataBase.Walls.Dummys.FloorForFloorHeating2Layers(),
        wall_length=5,
        wall_height=5)                                           annotation (
          Placement(transformation(
            extent={{2,-12},{-2,12}},
            rotation=90,
            origin={0,-56})));
      Utilities.Interfaces.ConvRadComb convRadComb_floor
        annotation (Placement(transformation(extent={{-10,84},{10,104}})));
      Utilities.Interfaces.ConvRadComb convRadComb_ceiling
        annotation (Placement(transformation(extent={{-10,-104},{10,-84}})));
    equation
      connect(port_a, TFlow.port_a)
        annotation (Line(points={{-100,0},{-58,0}}, color={0,127,255}));
      connect(TFlow.port_b, floorHeatingBasic.port_a)
        annotation (Line(points={{-38,0},{-10,0}}, color={0,127,255}));
      connect(floorHeatingBasic.port_b, TReturn.port_a)
        annotation (Line(points={{10,0},{30,0}}, color={0,127,255}));
      connect(TReturn.port_b, port_b)
        annotation (Line(points={{50,0},{100,0}}, color={0,127,255}));
      connect(floor.port_outside, floorHeatingBasic.thermUp)
        annotation (Line(points={{0,59.9},{0,9.8}}, color={191,0,0}));
      connect(floorHeatingBasic.thermDown, floor1.port_outside)
        annotation (Line(points={{0,-10},{0,-53.9}}, color={191,0,0}));
      connect(floor.thermStarComb_inside, convRadComb_floor)
        annotation (Line(points={{0,64},{0,94}}, color={191,0,0}));
      connect(floor1.thermStarComb_inside, convRadComb_ceiling)
        annotation (Line(points={{0,-58},{0,-94},{0,-94}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end PanelHeatingParameters;

    model TestingParameters
      extends Modelica.Icons.ExamplesPackage;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater;

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
      Utilities.Interfaces.Adaptors.ConvRadToCombPort SetRoom_down
        annotation (Placement(transformation(extent={{38,-66},{52,-78}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature1
        annotation (Placement(transformation(extent={{86,36},{66,56}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort SetRoom_up
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
      PanelHeatingParameters panelHeatingParameters(redeclare package Medium =
            Medium, redeclare Modelica.SIunits.Temperature TRoom = TRoom_set.y)
        annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
    equation


      connect(TRoom_set.y, prescribedTemperature1.T)
        annotation (Line(points={{97,46},{88,46}}, color={0,0,127}));
      connect(SetRoom_up.portConv, prescribedTemperature1.port) annotation (Line(
            points={{50.07,68.175},{50.07,46},{66,46}}, color={191,0,0}));
      connect(prescribedTemperature1.port, SetRoom_up.portRad) annotation (Line(
            points={{66,46},{66,76},{50.28,76},{50.28,76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, SetRoom_down.portRad) annotation (Line(
            points={{66,46},{66,-76.35},{52.28,-76.35}}, color={191,0,0}));
      connect(prescribedTemperature1.port, SetRoom_down.portConv) annotation (Line(
            points={{66,46},{52.07,46},{52.07,-68.175}}, color={191,0,0}));
      connect(m_flow_specification.T_in, T_VL_set.y) annotation (Line(points={{-156,
              4},{-160,4},{-160,-6},{-171,-6},{-171,-8}}, color={0,0,127}));
      connect(m_flow_Set.y, m_flow_specification.m_flow_in) annotation (Line(points=
             {{-171,24},{-168,24},{-168,16},{-156,16},{-156,8}}, color={0,0,127}));
      connect(m_flow_specification.ports[1], panelHeatingParameters.port_a)
        annotation (Line(points={{-134,0},{-82,0}}, color={0,127,255}));
      connect(panelHeatingParameters.port_b, boundary.ports[1])
        annotation (Line(points={{-62,0},{18,0}}, color={0,127,255}));
      connect(panelHeatingParameters.convRadComb_ceiling, SetRoom_down.portConvRadComb)
        annotation (Line(points={{-72,-9.4},{-72,-72.975},{38.14,-72.975}}, color={191,
              0,0}));
      connect(panelHeatingParameters.convRadComb_floor, SetRoom_up.portConvRadComb)
        annotation (Line(points={{-72,9.4},{-72,72},{36.14,72},{36.14,72.975}},
            color={191,0,0}));
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
    end TestingParameters;

    package Calculating_q
      extends Modelica.Icons.UtilitiesPackage;
      function product_ai
        "product of powers for panel heating Type A and C"

       input Real a_B "factor for flooring";
       input Real a_T "factor for division";
       input Real m_T "m_T= f(spacing T)";
       input Real a_u "factor for coverage";
       input Real m_u "m_u = f(thickness of screed coverage s_u)";
       input Real a_D "factor for outer diameter of pipe";
       input Real m_D "m_D = f(outer Diameter D)";

       output Modelica.SIunits.CoefficientOfHeatTransfer a_i;

      algorithm
        a_i := a_B * a_T^(m_T) * a_u^(m_u) * a_D^(m_D);

      end product_ai;

      function logDT

        import Modelica.Math.log;

      input Modelica.SIunits.Temperature Temp_in[3];
      output Modelica.SIunits.Temperature Temp_out;

      algorithm
      Temp_out :=(Temp_in[1] - Temp_in[2])/log((Temp_in[1] - Temp_in[3])/(Temp_in[2] -
          Temp_in[3]));

        annotation (Documentation(revisions="<html>
<ul>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Calculation of the logarithmic over temperature. </p>
</html>"));
      end logDT;

      model Calculating_q
        "Merge of all functions to calculate q by typing in needed parameters"
        parameter Modelica.SIunits.Distance T = 0.1 "Spacing between tubes in m";
        parameter Modelica.SIunits.Diameter D = 0.1 "Outer diameter of pipe, including sheathing in m";
        parameter Modelica.SIunits.Thickness s_u = 0.01 "thickness of screed above pipe in m";
        parameter Modelica.SIunits.CoefficientOfHeatTransfer lambda_R = 0.35 "Coefficient of heat transfer of pipe material";
        parameter Modelica.SIunits.Thickness s_R = 0.002 "thickness of pipe wall in m";
        parameter Modelica.SIunits.ThermalInsulance R_lambdaB "Thermal resistance of flooring in W/(m^2*K)";
        parameter Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal Conductivity of screed";

        Modelica.SIunits.CoefficientOfHeatTransfer B = 6.7 "system dependent coefficient in W/(m^2*K)";

        Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;
        Modelica.SIunits.ThermalConductivity lambda_u0 = 1;
        Modelica.SIunits.Diameter s_u0 = 0.045;
        Real a_B;
        Real a_T = Determine_aT.a_T;
        Real a_u = Determine_au.a_u;
        Real a_D = 1;

        Real m_T;
        Real m_u;
        Real m_D;

        Real product_ai "product of powers for parameters of floor heating";
        Real product_ai375 "product of powers for T = 0.375";

        Modelica.SIunits.Thickness s_uStar;

        Modelica.SIunits.CoefficientOfHeatTransfer K_H;
        Modelica.SIunits.CoefficientOfHeatTransfer K_HStar;
        Modelica.SIunits.TemperatureDifference dT_H = 1;

        Modelica.SIunits.HeatFlux q;



        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Calculating_q.a_T
          Determine_aT(R=R_lambdaB)
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Calculating_q.a_u
          Determine_au(T=T, R=R_lambdaB)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      equation
        a_B = (1 / alpha + s_u0 / lambda_u0) / (1 / alpha + s_u0 / lambda_E + R_lambdaB);

        m_T = 1 - T / 0.075;
        assert(T > 0.375, "Pipe spacing > 0.375,calculation with equation 9 p. 9");
        assert(T <0.05, "Pipe spacing too low, 0.050 <= T <= 0.375");

        m_u = 100 * (0.045 - s_u);
        assert(s_u < 0.01, "thickness of screed too low, s_u => 0.010");

        m_D = 250 * (D - 0.02);
        assert(D < 0.008, "Outer diameter too low, 0.008 <= D <= 0.030");
        assert(D > 0.03, "Outer diametr too high, 0.008 <= D <= 0.030");

        product_ai =  a_B * a_T^(m_T) * a_u^(m_u) * a_D^(m_D);
        product_ai375 =  a_B * a_T^(m_T) * a_u^(m_u) * a_D^(m_D);

         if T > 0.2 then
          s_uStar = 0.5 * T;
        else
          s_uStar = 0.1;
        end if;

         K_HStar = B * a_B * a_T^(m_T) * a_u^(100*(0.045-s_uStar)) * a_D^(m_D);

      if s_u > s_uStar then
        K_H = 1 / ( (1 / K_HStar) + ((s_u - s_uStar) / lambda_E));
        else
        if T > 0.375 then
          K_H = B * product_ai375 * 0.375 / T;
        else
          K_H = B * product_ai;
        end if;
      end if;

        q = K_H * dT_H;




        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Calculating_q;

      block a_T "Defining a_T following table A.1 p.29 DIN 1264-2"
        parameter Modelica.SIunits.ThermalInsulance R;

        Modelica.Blocks.Tables.CombiTable1D Table_A1(table=[0,1.23; 0.05,1.188; 0.1,1.156;
              0.15,1.134])
          annotation (Placement(transformation(extent={{-20,-24},{28,24}})));
        Modelica.Blocks.Interfaces.RealOutput a_T
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Sources.RealExpression R_lambdaB(y=R)
          annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      equation
        connect(Table_A1.y[1], a_T)
          annotation (Line(points={{30.4,0},{100,0}}, color={0,0,127}));
        connect(R_lambdaB.y, Table_A1.u[1])
          annotation (Line(points={{-79,0},{-24.8,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end a_T;

      block a_u "Determine a_u following Table A.2 p. 29 DIN 1264-2"

        parameter Modelica.SIunits.Distance T;
        parameter Modelica.SIunits.ThermalInsulance R;
        Modelica.Blocks.Tables.CombiTable2D Table_A2(table=[0.0,0,0.05,0.1,0.15; 0.05,
              1.069,1.056,1.043,1.037; 0.075,1.066,1.053,1.041,1.035; 0.1,1.063,1.05,1.039,
              1.0335; 0.15,1.057,1.046,1.035,1.0305; 0.2,1.051,1.041,1.0315,1.0275; 0.225,
              1.048,1.038,1.0295,1.026; 0.3,1.0395,1.031,1.024,1.021; 0.375,1.03,1.0221,
              1.0181,1.015])
          annotation (Placement(transformation(extent={{-14,-16},{18,16}})));
        Modelica.Blocks.Sources.RealExpression Spacing(y=T)
          annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
        Modelica.Blocks.Sources.RealExpression R_lambdaB(y=R)
          annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
        Modelica.Blocks.Interfaces.RealOutput a_u
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      equation
        connect(Spacing.y, Table_A2.u1) annotation (Line(points={{-79,10},{-17.2,10},{
                -17.2,9.6}}, color={0,0,127}));
        connect(R_lambdaB.y, Table_A2.u2) annotation (Line(points={{-79,-10},{-17.2,-10},
                {-17.2,-9.6}}, color={0,0,127}));
        connect(Table_A2.y, a_u)
          annotation (Line(points={{19.6,0},{100,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end a_u;
    end Calculating_q;
  end AddParameters;
end PanelHeatingNew;
