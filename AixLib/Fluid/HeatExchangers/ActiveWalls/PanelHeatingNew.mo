within AixLib.Fluid.HeatExchangers.ActiveWalls;
package PanelHeatingNew
  model Distributor
    "Heating circuit distributor for underfloor heating systems"
    extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

    //General
    parameter Integer n(min=1) "Number of underfloor heating circuits / registers"
      annotation (Dialog(connectorSizing=true, group="General"));

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal
      "Nominal mass flow rate" annotation (Dialog(group="General"));

    parameter Modelica.SIunits.Time tau=10
      "Time constant at nominal flow (if energyDynamics <> SteadyState)"
      annotation (Dialog(tab="Dynamics", group="Nominal condition"));

    // Assumptions
    parameter Boolean allowFlowReversal=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(tab="Assumptions"), Evaluate=true);

    Modelica.Fluid.Interfaces.FluidPort_a mainFlow(redeclare final package
        Medium = Medium)
      annotation (Placement(transformation(extent={{-70,22},{-50,42}})));

    Modelica.Fluid.Interfaces.FluidPort_b mainReturn(redeclare final package
        Medium = Medium) annotation (Placement(transformation(extent={{-70,-40},{-50,
              -20}}), iconTransformation(extent={{-70,-40},{-50,-20}})));
    MixingVolumes.MixingVolume vol_flow(
      final nPorts=n + 1,
      final m_flow_nominal=m_flow_nominal,
      final V=m_flow_nominal*tau/rho_default,
      redeclare final package Medium = Medium,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final p_start=p_start,
      final T_start=T_start,
      final X_start=X_start,
      final C_start=C_start,
      final mSenFac=mSenFac,
      each final C_nominal=C_nominal,
      final allowFlowReversal=allowFlowReversal) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={0,12})));
    MixingVolumes.MixingVolume vol_return(
      final nPorts=n + 1,
      final m_flow_nominal=m_flow_nominal,
      final V=m_flow_nominal*tau/rho_default,
      redeclare final package Medium = Medium,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final p_start=p_start,
      final T_start=T_start,
      final X_start=X_start,
      final C_start=C_start,
      final mSenFac=mSenFac,
      each final C_nominal=C_nominal,
      final allowFlowReversal=allowFlowReversal) annotation (Placement(
          transformation(extent={{-10,-20},{10,0}}, rotation=0)));
    Modelica.Fluid.Interfaces.FluidPorts_b flowPorts[n](redeclare each final
        package Medium = Medium) annotation (Placement(
        visible=true,
        transformation(
          origin={0,60},
          extent={{-10,-40},{10,40}},
          rotation=90),
        iconTransformation(
          origin={0,60},
          extent={{-6,-24},{6,24}},
          rotation=90)));
    Modelica.Fluid.Interfaces.FluidPorts_a returnPorts[n](redeclare each final
        package Medium = Medium) annotation (Placement(
        visible=true,
        transformation(
          origin={0,-60},
          extent={{-10,-40},{10,40}},
          rotation=90),
        iconTransformation(
          origin={0,-62},
          extent={{-6,-24},{6,24}},
          rotation=90)));

  protected
    parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
        T=Medium.T_default,
        p=Medium.p_default,
        X=Medium.X_default);
    parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
      "Density, used to compute fluid volume";
  equation
    connect(mainFlow, vol_flow.ports[1]) annotation (Line(points={{-60,32},{-46,32},
            {-46,22},{0,22}}, color={255,0,0}));
    connect(mainReturn, vol_return.ports[1]) annotation (Line(points={{-60,-30},{-46,
            -30},{-46,-20},{0,-20}}, color={0,0,255}));

    for k in 1:n loop
      connect(vol_flow.ports[k + 1], flowPorts[k])
        annotation (Line(points={{0,22},{0,60}}, color={255,0,0}));
      connect(vol_return.ports[k + 1], returnPorts[k])
        annotation (Line(points={{0,-20},{0,-60}}, color={0,0,255}));
    end for;

    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-60,-60},{60,60}})),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-60,-60},{60,60}}),
          graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-62,-30},{0,-30},{0,-68}},
            color={0,0,255},
            thickness=1),
          Line(
            points={{-62,28},{0,28},{0,60}},
            color={238,46,47},
            thickness=1),
          Text(
            extent={{-22,46},{72,36}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.None,
            textString="[n] flow"),
          Text(
            extent={{-20,-30},{76,-40}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.None,
            textString="[n] return")}),
      Documentation(revisions="<html>
<ul>
<li><i>January 11, 2019&nbsp;</i> by Fabian W&uuml;llhorst:<br/>
Make model more dynamic (See <a href=\"https://github.com/RWTH-EBC/AixLib/issues/673\">#673</a>)</li>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>",   info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Model for a contributor for different floor heating circuits in a house.</p>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>The contributor is built to connect <span style=\"font-family: Courier New;\">n</span> floor heating circuits together. The volume is used for nummerical reasons, to have a point where all the flows mix together. </p>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p><a href=\"AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test\">AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test</a></p>
</html>"));
  end Distributor;

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

    model PanelHeatingElement

          extends Fluid.Interfaces.PartialTwoPort(allowFlowReversal = false);
          extends Fluid.Interfaces.LumpedVolumeDeclarations;

      parameter Modelica.SIunits.Distance T "Spacing between tubes" annotation (Dialog( group = "Panel Heating Pipe"));
      parameter Modelica.SIunits.Diameter d_i "Inner diameter of pipe" annotation (Dialog( group = "Panel Heating Pipe"));
      parameter Integer dis(min = 1) "Parameter to enable dissertisation layers";

      final parameter Modelica.SIunits.Volume VWater = vol.m_flow_nominal * tau / rho_default / dis "Water Volume in Tube";
      final parameter Modelica.SIunits.Time tau = 60 "Time constant to heat up the medium";

      parameter Modelica.SIunits.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
      parameter Integer n_floor(min = 1) "Number of floor layers" annotation(Dialog(group = "Room Specifications"));
      parameter Modelica.SIunits.Thickness d_floor[n_floor] "Thickness of floor layers" annotation(Dialog(group = "Room Specifications"));
      parameter Modelica.SIunits.Density rho_floor[n_floor] "Density of floor layers" annotation(Dialog(group = "Room Specifications"));
      parameter Modelica.SIunits.ThermalConductivity lambda_floor[n_floor] "Thermal conductivity of floor layers" annotation(Dialog(group = "Room Specifications"));
      parameter Modelica.SIunits.SpecificHeatCapacity c_floor[n_floor] "Specific heat capacity of floor layers" annotation(Dialog(group = "Room Specifications"));
      parameter Modelica.SIunits.Emissivity eps_floor = 0.95 "Emissivityn of floor surface" annotation(Dialog(group = "Room Specifications"));

      parameter Boolean Ceiling = true "false if ground plate is under panel heating" annotation (Dialog(group=
              "Room Specifications"), choices(checkBox=true));
      parameter Integer n_ceiling(min = 1) "Number of ceiling layers" annotation(Dialog(group = "Room Specifications", enable = Ceiling));
      parameter Modelica.SIunits.Thickness d_ceiling[n_ceiling] "Thickness of ceiling layers" annotation(Dialog(group = "Room Specifications", enable = Ceiling));
      parameter Modelica.SIunits.Density rho_ceiling[n_ceiling] "Density of ceiling layers" annotation(Dialog(group = "Room Specifications", enable = Ceiling));
      parameter Modelica.SIunits.ThermalConductivity lambda_ceiling[n_ceiling] "Thermal conductivity of ceiling layers" annotation(Dialog(group = "Room Specifications", enable = Ceiling));
      parameter Modelica.SIunits.SpecificHeatCapacity c_ceiling[n_ceiling] "Specific heat capacity of ceiling layers" annotation(Dialog(group = "Room Specifications", enable = Ceiling));
      parameter Modelica.SIunits.Emissivity eps_ceiling = 0.95 "Emissivity of ceiling surface" annotation(Dialog(group = "Room Specifications", enable = Ceiling));

      final parameter Modelica.SIunits.Temperature T0 = 273.15 + 20;

      parameter Modelica.SIunits.MassFlowRate m_H "Nominal Mass Flow Rate";



      MixingVolumes.MixingVolume vol(
        redeclare package Medium = Medium,
        V=VWater,
        nPorts=2,
        m_flow_nominal=m_H,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{0,0},{22,22}})));
      ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer simpleNLayer_Floor(
        final A=A,
        final n=n_floor,
        final d=d_floor,
        final rho=rho_floor,
        final lambda=lambda_floor,
        final c=c_floor,
        T0=T0)           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,46})));
      Utilities.HeatTransfer.HeatToRad twoStar_RadEx_floor(
        rad(T(start=T0)),
        conv(T(start=T0)),
        A=A,
        eps=eps_floor)
                 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,72})));
      Utilities.Interfaces.RadPort radport_floor
        annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_floor
        annotation (Placement(transformation(extent={{8,86},{28,106}}),
            iconTransformation(extent={{8,86},{28,106}})));
      ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer simpleNLayer_Ceiling(
        final A=A,
        final n=n_ceiling,
        final d=d_ceiling,
        final rho=rho_ceiling,
        final lambda=lambda_ceiling,
        final c=c_ceiling,
        T0=T0)             annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,-28})));
      Utilities.HeatTransfer.HeatToRad twoStar_RadEx_ceiling(
        rad(T(start=T0)),
        conv(T(start=T0)),
        A=A,
        eps=eps_ceiling) if
                    Ceiling annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-24,-58})));
      Utilities.Interfaces.RadPort radport_ceiling
        annotation (Placement(transformation(extent={{-34,-104},{-14,-84}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_ceiling
        annotation (Placement(transformation(extent={{14,-108},{34,-88}})));

    protected
      parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
          T=Medium.T_default,
          p=Medium.p_default,
          X=Medium.X_default);
      parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
        "Density, used to compute fluid volume";
    equation

      connect(port_a, vol.ports[1])
        annotation (Line(points={{-100,0},{8.8,0}}, color={0,127,255}));
      connect(vol.ports[2], port_b)
        annotation (Line(points={{13.2,0},{100,0}}, color={0,127,255}));
      connect(vol.heatPort, simpleNLayer_Floor.port_a) annotation (Line(points={{0,11},
              {0,36},{-4.44089e-16,36}}, color={191,0,0}));
      connect(twoStar_RadEx_floor.conv, simpleNLayer_Floor.port_b) annotation (Line(
            points={{-30,62.8},{-30,56},{6.66134e-16,56}}, color={191,0,0}));
      connect(twoStar_RadEx_floor.rad, radport_floor)
        annotation (Line(points={{-30,81.1},{-30,100}}, color={95,95,95}));
      connect(simpleNLayer_Floor.port_b, heatport_floor) annotation (Line(points={{4.44089e-16,
              56},{18,56},{18,96}}, color={191,0,0}));
      connect(vol.heatPort, simpleNLayer_Ceiling.port_a)
        annotation (Line(points={{0,11},{0,-18}}, color={191,0,0}));
      connect(simpleNLayer_Ceiling.port_b, twoStar_RadEx_ceiling.conv)
        annotation (Line(points={{0,-38},{-24,-38},{-24,-48.8}}, color={191,0,0}));
      connect(twoStar_RadEx_ceiling.rad, radport_ceiling)
        annotation (Line(points={{-24,-67.1},{-24,-94}}, color={95,95,95}));
      connect(simpleNLayer_Ceiling.port_b, heatport_ceiling) annotation (Line(
            points={{-4.44089e-16,-38},{24,-38},{24,-98}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end PanelHeatingElement;

    model PanelHeatingCircuit "One Circuit in a Panel Heating System"
      extends Fluid.Interfaces.PartialTwoPort;

      parameter Integer dis(min=1) = 3 "Number of Discreatisation Layers";

      parameter Modelica.SIunits.Power Q_Nf "Calculated Heat Load for room with panel heating" annotation (Dialog(group="Room Specifications"));
      final parameter Modelica.SIunits.HeatFlux q_des = Q_Nf / A "set value for panel heating heat flux";
      parameter Modelica.SIunits.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));

      parameter Integer n_floor(min = 1) = 2 "Number of floor layers" annotation(Dialog(group = "Floor Layers", enable = false));
      parameter Modelica.SIunits.Thickness d_floor[n_floor] "Thickness of floor layers" annotation(Dialog(group = "Floor Layers"));
      parameter Modelica.SIunits.Density rho_floor[n_floor] "Density of floor layers" annotation(Dialog(group = "Floor Layers"));
      parameter Modelica.SIunits.ThermalConductivity lambda_floor[n_floor] "Thermal conductivity of floor layers" annotation(Dialog(group = "Floor Layers"));
      parameter Modelica.SIunits.SpecificHeatCapacity c_floor[n_floor] "Specific heat capacity of floor layers" annotation(Dialog(group = "Floor Layers"));
      parameter Modelica.SIunits.Emissivity eps_floor = 0.95 "Emissivity of floor surface" annotation(Dialog(group = "Floor Layers"));

      parameter Boolean Ceiling = true "false if ground plate is under panel heating" annotation (Dialog(group = "Floor Layers"), choices(checkBox=true));
      parameter Integer n_ceiling(min = 1) = if Ceiling then 3 else 0 "Number of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = false));
      parameter Modelica.SIunits.Thickness d_ceiling[n_ceiling] "Thickness of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.Density rho_ceiling[n_ceiling] "Density of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.ThermalConductivity lambda_ceiling[n_ceiling] "Thermal conductivity of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.SpecificHeatCapacity c_ceiling[n_ceiling] "Specific heat capacity of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.Emissivity eps_ceiling = 0.95 "Emissivity of ceiling surface" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.Temperature T_U = Modelica.SIunits.Conversions.from_degC(20) "Set value for Room Temperature lying under panel heating" annotation (Dialog(group="Room Specifications"));

          replaceable parameter
        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.ZoneSpecification.ZoneDefinition
        ZoneType=
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.ZoneSpecification.OccupancyZone() "Zone Type where panel heating is installed"
             annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
      final parameter Modelica.SIunits.Temperature T_Fmax = ZoneType.T_Fmax;
      final parameter Modelica.SIunits.Temperature T_Room = ZoneType.T_Room;
      final parameter Modelica.SIunits.HeatFlux q_Gmax = ZoneType.q_Gmax;

      parameter Modelica.SIunits.Distance T "Spacing between tubes" annotation (Dialog( group = "Panel Heating"));
      final parameter Modelica.SIunits.Length PipeLength = A / T "Length of Panel Heating Pipe";

      replaceable parameter
        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.PipeMaterials.PipeMaterial_Definition
        PipeMaterial=
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.PipeMaterials.PE_RT() "Pipe Material"
             annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
      final parameter Modelica.SIunits.ThermalConductivity lambda_R = PipeMaterial.lambda "Thermal conductivity of pipe material";
      parameter Modelica.SIunits.Thickness s_R "thickness of pipe wall" annotation (Dialog( group = "Panel Heating"));
      parameter Modelica.SIunits.Diameter d_a "outer diameter of pipe" annotation (Dialog( group = "Panel Heating"));
      final parameter Modelica.SIunits.Diameter d_i = d_a - s_R "inner diameter of pipe";
      final parameter Modelica.SIunits.Density rho_R = 1 "Density of pipe material";
      final parameter Modelica.SIunits.SpecificHeatCapacity c_R = 1 "Specific Heat Capacity of Pipe Material";

      parameter Boolean withInsulating = true "false if pipe has no insulating" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
      replaceable parameter
        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Insulating_Materials.InsulatingMaterial_Definition
        InsulatingMaterial=
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Insulating_Materials.none() "Insulating Material"
             annotation (Dialog(group="Panel Heating", enable = withInsulating), choicesAllMatching=true);
      final parameter Modelica.SIunits.ThermalConductivity lambda_M( min = 0) = InsulatingMaterial.lambda "Thermal Conductivity for insulating";
      parameter Modelica.SIunits.Diameter D( min = d_a) "Outer diameter of pipe including insulating" annotation (Dialog( group = "Panel Heating", enable = withInsulating));
      final parameter Modelica.SIunits.Density rho_M = 1 "Density of insulating material";
      final parameter Modelica.SIunits.SpecificHeatCapacity c_M = 1 "Specific Heat Capacity of insulating material";

      parameter Boolean withHoldingBurls = true "false if there are no holding burls for pipe" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
      parameter Modelica.SIunits.VolumeFraction psi( min = 0) "Volume Fraction of holding burls" annotation (Dialog( group = "Panel Heating", enable = withHoldingBurls));
      parameter Modelica.SIunits.ThermalConductivity lambda_W( min = 0) "Thermal conductivity of holding burls" annotation (Dialog( group = "Panel Heating", enable = withHoldingBurls));

      final parameter Modelica.SIunits.Thickness s_ins = d_ceiling[1] "Thickness of thermal insulation";
      final parameter Modelica.SIunits.ThermalConductivity lambda_ins = lambda_ceiling[1] "Thermal conductivity of thermal insulation";
      final parameter Modelica.SIunits.ThermalInsulance R_lambdaIns = s_ins / lambda_ins "Thermal resistance of thermal insulation";

      final parameter Modelica.SIunits.Thickness s_u = d_floor[1] "thickness of cover above pipe";
      final parameter Modelica.SIunits.ThermalConductivity lambda_u = lambda_floor[1] "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
      final parameter Modelica.SIunits.ThermalConductivity lambda_E0 = lambda_u "Thermal conductivity of cover";

      final parameter Modelica.SIunits.ThermalInsulance R_lambdaB = d_floor[2] / lambda_floor[2] "Thermal resistance of flooring";

      final parameter Modelica.SIunits.ThermalInsulance R_lambdaCeiling = d_ceiling[2] / lambda_ceiling[2] "Thermal resistance of ceiling";
      final parameter Modelica.SIunits.ThermalInsulance R_lambdaPlaster = d_ceiling[3] / lambda_ceiling[3] "Thermal resistance of plaster";

      final parameter Modelica.SIunits.ThermalInsulance R_U = R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling "Thermal resistance of wall layers under panel heating";
      final parameter Modelica.SIunits.ThermalInsulance R_O = 1 / alpha + R_lambdaB + s_u / lambda_u "Thermal resistance of wall layers above panel heating";
      constant Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;
      constant Modelica.SIunits.ThermalInsulance R_alphaCeiling = 0.17 "Thermal resistance at the ceiling";

      parameter Modelica.SIunits.TemperatureDifference sigma_i "Temperature Spread for room (max = 5 for room with highest heat load)" annotation(Dialog(group = "Room Specifications"));
      constant Modelica.SIunits.SpecificHeatCapacity c_W = 4190;

      final parameter Modelica.SIunits.MassFlowRate m_H = A * q_des / (sigma_i * c_W) * (1 + (R_O / R_U) + (T_Room - T_U) / (q_des * R_U)) "nominal mass flow rate";

      Modelica.SIunits.TemperatureDifference dT_H=logDT(Temp_in) "Temperature Difference between heating medium and Room";
      Modelica.SIunits.Temperature Temp_in[3] = {TFlow.T, TReturn.T, T_Room};
      parameter Modelica.SIunits.TemperatureDifference dT_Hi "Logarithmic Temperature Difference between heating medium and room" annotation(Dialog(group = "Room Specifications"));

      Modelica.SIunits.HeatFlux q_G = EN_1264.q_G "critical heat flow";
      Modelica.SIunits.HeatFlux q_max = EN_1264.q_max "maximum heat flow";
      Modelica.SIunits.HeatFlux q_N = EN_1264.q_N "nominal heat flow";
      Real K_H = EN_1264.K_H;

      Modelica.SIunits.Temperature T_Fm = sumT_Fm.y "arithmetic mean of floor surface temperature";

      final parameter Integer n_FL( min = 1) = 4 "Number of floor layers with tube";
      final parameter Modelica.SIunits.Thickness d_FL[n_FL] = {s_R, D - d_a, d_floor[1], d_floor[2]} "Thickness of floor layers with tube";
      final parameter Modelica.SIunits.Density rho_FL[n_FL] = {rho_R, rho_M, rho_floor[1], rho_floor[2]} "Density of floor layers with tube";
      final parameter Modelica.SIunits.ThermalConductivity lambda_FL[n_FL] = {lambda_R, lambda_M, lambda_floor[1], lambda_floor[2]} "Thermal conductivity of floor layers with tube";
      final parameter Modelica.SIunits.SpecificHeatCapacity c_FL[n_FL] = {c_R, c_M, c_floor[1], c_floor[2]} "Specific heat capacity of floor layers with tube";

      final parameter Integer n_CE( min = 1) = 5 "Number of floor layers with tube";
      final parameter Modelica.SIunits.Thickness d_CE[n_CE] = {s_R, D - d_a, d_ceiling[1], d_ceiling[2], d_ceiling[3]} "Thickness of floor layers with tube";
      final parameter Modelica.SIunits.Density rho_CE[n_CE] = {rho_R, rho_M, rho_ceiling[1], rho_ceiling[2], rho_ceiling[3]} "Density of floor layers with tube";
      final parameter Modelica.SIunits.ThermalConductivity lambda_CE[n_CE] =  {lambda_R, lambda_M, lambda_ceiling[1], lambda_ceiling[2],lambda_ceiling[3]} "Thermal conductivity of floor layers with tube";
      final parameter Modelica.SIunits.SpecificHeatCapacity c_CE[n_CE] = {c_R, c_M, c_ceiling[1], c_ceiling[2], c_ceiling[3]} "Specific heat capacity of floor layers with tube";
      AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.PanelHeatingElement
        panelHeatingElement[dis](
        redeclare package Medium = Medium,
        each T=T,
        each m_H=m_H,
        each d_i=d_i,
        each A=A/dis,
        each eps_floor=eps_floor,
        each eps_ceiling=eps_ceiling,
        each dis=dis,
        each Ceiling=Ceiling,
        each n_floor=n_FL,
        each d_floor=d_FL,
        each rho_floor=rho_FL,
        each lambda_floor=lambda_FL,
        each c_floor=c_FL,
        each n_ceiling=n_CE,
        each d_ceiling=d_CE,
        each rho_ceiling=rho_CE,
        each lambda_ceiling=lambda_CE,
        each c_ceiling=c_CE)
        annotation (Placement(transformation(extent={{-20,-18},{20,18}})));

      Sensors.TemperatureTwoPort                TFlow(redeclare package Medium =
            Medium,
        m_flow_nominal=m_H,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
      Sensors.TemperatureTwoPort                TReturn(redeclare package Medium =
            Medium,
        m_flow_nominal=m_H,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{42,-10},{62,10}})));

      Utilities.Interfaces.RadPort radport_floor
        annotation (Placement(transformation(extent={{-34,90},{-14,110}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_floor
        annotation (Placement(transformation(extent={{14,86},{34,106}}),
            iconTransformation(extent={{14,86},{34,106}})));
      Utilities.Interfaces.RadPort radport_ceiling
        annotation (Placement(transformation(extent={{-34,-104},{-14,-84}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_ceiling
        annotation (Placement(transformation(extent={{14,-108},{34,-88}})));
      EN1264.HeatFlux_EN1264_2 EN_1264(
        T=T,
        T_Fmax=T_Fmax,
        T_Room=T_Room,
        lambda_R=lambda_R,
        s_R=s_R,
        D=D,
        d_a=d_a,
        lambda_M=lambda_M,
        s_u=s_u,
        R_lambdaB=R_lambdaB,
        lambda_E0=lambda_E0,
        psi=psi,
        lambda_W=lambda_W,
        s_ins=s_ins,
        lambda_ins=lambda_ins,
        R_lambdaCeiling=R_lambdaCeiling,
        R_lambdaPlaster=R_lambdaPlaster,
        T_U=T_U,
        withInsulating=withInsulating,
        withHoldingBurls=withHoldingBurls,
        dT_H=dT_Hi)
        annotation (Placement(transformation(extent={{-100,-60},{-60,-40}})));
      sumT_F sumT_Fm(dis=dis)
        annotation (Placement(transformation(extent={{60,40},{80,60}})));
    equation
      assert(PipeLength > 120, "Pipe Length is too high, additional heating circuit needs to be used", AssertionLevel.warning);
      assert(T_Fm > T_Fmax, "Surface temperature too high", AssertionLevel.warning);

    //OUTER CONNECTIONS

      connect(TFlow.port_b, panelHeatingElement[1].port_a)
        annotation (Line(points={{-38,0},{-20,0}}, color={0,127,255}));

      connect(panelHeatingElement[dis].port_b, TReturn.port_a)
        annotation (Line(points={{20,0},{42,0}}, color={0,127,255}));

    // HEAT CONNECTIONS

    for i in 1:dis loop
        connect(radport_floor, panelHeatingElement[i].radport_floor) annotation (
           Line(points={{-24,100},{-24,72},{-6,72},{-6,18}}, color={95,95,95}));
        connect(heatport_floor, panelHeatingElement[i].heatport_floor)
          annotation (Line(points={{24,96},{24,72},{3.6,72},{3.6,17.28}}, color={191,
                0,0}));
        connect(panelHeatingElement[i].heatport_ceiling, heatport_ceiling)
          annotation (Line(points={{4.8,-17.64},{4.8,-60},{24,-60},{24,-98}}, color=
               {191,0,0}));
        connect(panelHeatingElement[i].radport_ceiling, radport_ceiling)
          annotation (Line(points={{-4.8,-16.92},{-4.8,-60},{-24,-60},{-24,-94}},
              color={95,95,95}));
        connect(sumT_Fm.port_a[i], panelHeatingElement[i].heatport_floor)
        annotation (Line(points={{60,50},{3.6,50},{3.6,17.28}}, color={191,0,0}));
    end for;

      //INNER CONNECTIONS

      if dis > 1 then
        for i in 1:(dis-1) loop
          connect(panelHeatingElement[i].port_b, panelHeatingElement[i + 1].port_a)
            annotation (Line(
              points={{20,0},{20,-12},{-20,-12},{-20,0}},
              color={0,127,255},
              pattern=LinePattern.Dash));
        end for;
      end if;

      connect(port_a, TFlow.port_a)
        annotation (Line(points={{-100,0},{-58,0}}, color={0,127,255}));
      connect(TReturn.port_b, port_b)
        annotation (Line(points={{62,0},{100,0}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end PanelHeatingCircuit;

    model PanelHeatingSystem
      replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium "Medium in the component";

      parameter Integer CircuitNo(min=1) = 3 "Number of rooms heated with panel heating";
      parameter Modelica.SIunits.Power Q_Nf "Calculated Heat Load for room with panel heating" annotation (Dialog(group="Room Specifications"));
      parameter Modelica.SIunits.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
      parameter Integer dis(min=1) = 3 "Number of discretisation layers within a room";
      final parameter Integer n_floor(min = 1) = 2 "Number of floor layers";
      parameter Modelica.SIunits.Thickness d_floor[n_floor] "Thickness of floor layers" annotation(Dialog(group = "Floor Layers"));
      parameter Modelica.SIunits.Density rho_floor[n_floor] "Density of floor layers" annotation(Dialog(group = "Floor Layers"));
      parameter Modelica.SIunits.ThermalConductivity lambda_floor[n_floor] "Thermal conductivity of floor layers" annotation(Dialog(group = "Floor Layers"));
      parameter Modelica.SIunits.SpecificHeatCapacity c_floor[n_floor] "Specific heat capacity of floor layers" annotation(Dialog(group = "Floor Layers"));
      parameter Modelica.SIunits.Emissivity eps_floor = 0.95 "Emissivity of floor surface" annotation(Dialog(group = "Floor Layers"));

      parameter Boolean Ceiling = true "false if ground plate is under panel heating" annotation (Dialog(group = "Floor Layers"), choices(checkBox=true));
      final parameter Integer n_ceiling(min = 1) = if Ceiling then 3 else 0 "Number of ceiling layers";
      parameter Modelica.SIunits.Thickness d_ceiling[n_ceiling] "Thickness of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.Density rho_ceiling[n_ceiling] "Density of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.ThermalConductivity lambda_ceiling[n_ceiling] "Thermal conductivity of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.SpecificHeatCapacity c_ceiling[n_ceiling] "Specific heat capacity of ceiling layers" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.Emissivity eps_ceiling = 0.95 "Emissivity of ceiling surface" annotation(Dialog(group = "Floor Layers", enable = Ceiling));
      parameter Modelica.SIunits.Temperature T_U = Modelica.SIunits.Conversions.from_degC(20) "Set value for Room Temperature lying under panel heating" annotation (Dialog(group="Room Specifications"));
      replaceable parameter
        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.ZoneSpecification.ZoneDefinition
        ZoneType=
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.ZoneSpecification.OccupancyZone()
             annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
      parameter Modelica.SIunits.Distance T "Spacing between tubes" annotation (Dialog( group = "Panel Heating"));
      replaceable parameter
        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.PipeMaterials.PipeMaterial_Definition
        PipeMaterial=
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.PipeMaterials.PE_RT()
             annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
      final parameter Modelica.SIunits.ThermalConductivity lambda_R = PipeMaterial.lambda "Thermal conductivity of pipe material";
      parameter Modelica.SIunits.Thickness s_R "thickness of pipe wall" annotation (Dialog( group = "Panel Heating"));
      parameter Modelica.SIunits.Diameter d_a "outer diameter of pipe" annotation (Dialog( group = "Panel Heating"));
      final parameter Modelica.SIunits.Diameter d_i = d_a - s_R "inner diameter of pipe";

      parameter Boolean withInsulating = true "false if pipe has no insulating" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
      replaceable parameter
        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Insulating_Materials.InsulatingMaterial_Definition
        InsulatingMaterial=
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Insulating_Materials.none()
             annotation (Dialog(group="Panel Heating", enable = withInsulating), choicesAllMatching=true);
      final parameter Modelica.SIunits.ThermalConductivity lambda_M( min = 0) = InsulatingMaterial.lambda "Thermal Conductivity for insulating";
      parameter Modelica.SIunits.Diameter D( min = d_a) "Outer diameter of pipe including insulating" annotation (Dialog( group = "Panel Heating"));

      parameter Boolean withHoldingBurls = true "false if there are no holding burls for pipe" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
      parameter Modelica.SIunits.VolumeFraction psi( min = 0) "Volume Fraction of holding burls" annotation (Dialog( group = "Panel Heating", enable = withHoldingBurls));
      parameter Modelica.SIunits.ThermalConductivity lambda_W( min = 0) "Thermal conductivity of holding burls" annotation (Dialog( group = "Panel Heating", enable = withHoldingBurls));

      final parameter Modelica.SIunits.MassFlowRate m_ges = sum(panelHeating_Circuit.m_H);
      parameter Modelica.SIunits.Temperature TFLow_nom "System Flow Temperature";
      parameter Modelica.SIunits.Temperature TReturn_nom "System Return Temperature";
      final parameter Modelica.SIunits.TemperatureDifference sigma_nom = TFLow_nom - TReturn_nom "Nominal Temperatur Spread of Panel Heating";
      final parameter Modelica.SIunits.HeatFlux q_max = max(panelHeating_Circuit.q_des);
      parameter Modelica.SIunits.TemperatureDifference sigma_des(max = 5)= 5  "Temperature Spread for room with highest heat load (max = 5)";
      Modelica.SIunits.TemperatureDifference dT_Hdes = q_max / K_H[1];
      Modelica.SIunits.TemperatureDifference dT_Vdes = dT_Hdes + sigma_des / 2 + sigma_des^(2) / (12 * dT_Hdes);
      Modelica.SIunits.Temperature T_Vdes = dT_Vdes + T_Roomdes;
      final parameter Modelica.SIunits.Temperature T_Roomdes = panelHeating_Circuit[1].T_Room;


      Real K_H[CircuitNo] = {panelHeating_Circuit[r].K_H for r in 1:CircuitNo};
      final parameter Real q_des[CircuitNo] = {panelHeating_Circuit[r].q_des for r in 1:CircuitNo};
      Modelica.SIunits.TemperatureDifference dT_Hi[CircuitNo] = q_des ./ K_H;


      Distributor                                         distributor(
        redeclare package Medium = Medium,
        m_flow_nominal=m_ges,
        n=3)
        annotation (Placement(transformation(extent={{-42,-18},{-6,18}})));
      Sources.Boundary_pT                  boundary(redeclare package Medium =
            Medium, nPorts=1)
        annotation (Placement(transformation(extent={{-108,-20},{-86,2}})));
      AixLib.Fluid.Sources.MassFlowSource_T
                               m_flow_specification(
        redeclare package Medium = Medium,
        m_flow=0.03,
        use_m_flow_in=true,
        use_T_in=true,
        nPorts=1,
        T=313.15)
        annotation (Placement(transformation(extent={{-106,10},{-86,30}})));
      Modelica.Blocks.Sources.RealExpression MassFlow(y=m_ges)
        annotation (Placement(transformation(extent={{-148,18},{-128,38}})));
      Modelica.Blocks.Sources.RealExpression TFLow(y=T_Vdes)
        annotation (Placement(transformation(extent={{-148,0},{-128,20}})));
      PanelHeatingCircuit panelHeating_Circuit[CircuitNo](
        redeclare each package Medium = Medium,
        each dis=dis,
        each Q_Nf=Q_Nf,
        each A=A,
        each d_floor=d_floor,
        each rho_floor=rho_floor,
        each lambda_floor=lambda_floor,
        each c_floor=c_floor,
        each eps_floor=eps_floor,
        each Ceiling=Ceiling,
        each d_ceiling=d_ceiling,
        each rho_ceiling=rho_ceiling,
        each lambda_ceiling=lambda_ceiling,
        each c_ceiling=c_ceiling,
        each eps_ceiling=eps_ceiling,
        each T_U=T_U,
        each ZoneType=ZoneType,
        each T=T,
        each PipeMaterial=PipeMaterial,
        each s_R=s_R,
        each d_a=d_a,
        each withInsulating=withInsulating,
        each InsulatingMaterial=InsulatingMaterial,
        each D=D,
        each withHoldingBurls=withHoldingBurls,
        each psi=psi,
        each lambda_W=lambda_W,
        each dT_Hi=dT_Hi)
        annotation (Placement(transformation(extent={{48,-18},{84,16}})));
      Sensors.TemperatureTwoPort                TFlow(redeclare package Medium =
            Medium, m_flow_nominal=m_ges)
        annotation (Placement(transformation(extent={{-76,12},{-58,28}})));
      Sensors.TemperatureTwoPort                TReturn(redeclare package
          Medium =
            Medium, m_flow_nominal=m_ges)
        annotation (Placement(transformation(extent={{-76,-16},{-60,-2}})));
      Utilities.Interfaces.RadPort radport_ceiling[CircuitNo]
        annotation (Placement(transformation(extent={{-34,-104},{-14,-84}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_ceiling[CircuitNo]
        annotation (Placement(transformation(extent={{14,-108},{34,-88}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_floor[CircuitNo]
        annotation (Placement(transformation(extent={{14,86},{34,106}}),
            iconTransformation(extent={{14,86},{34,106}})));
      Utilities.Interfaces.RadPort radport_floor[CircuitNo]
        annotation (Placement(transformation(extent={{-34,90},{-14,110}})));
    equation
      panelHeating_Circuit[1].sigma_i = sigma_des;
      if CircuitNo > 1 then
      for i in 2:CircuitNo loop
        panelHeating_Circuit[i].sigma_i = 3 * dT_Hi[i] * (( 1 + 4 * ( dT_Vdes - dT_Hi[i])  / ( 3 * dT_Hi[i])) ^ (0.5) - 1);
        end for;
       end if;


      connect(MassFlow.y, m_flow_specification.m_flow_in) annotation (Line(points={{
              -127,28},{-124,28},{-124,30},{-108,30},{-108,28}}, color={0,0,127}));
      connect(TFLow.y, m_flow_specification.T_in) annotation (Line(points={{-127,10},
              {-120,10},{-120,24},{-108,24}}, color={0,0,127}));
      connect(panelHeating_Circuit.port_b, distributor.returnPorts[1:CircuitNo])
        annotation (Line(points={{84,-1},{86,-1},{86,-2},{96,-2},{96,-52},{-24,-52},
              {-24,-18.6}}, color={0,127,255}));
      connect(distributor.flowPorts[1:CircuitNo],panelHeating_Circuit. port_a) annotation (
          Line(points={{-24,18},{-26,18},{-26,42},{12,42},{12,-1},{48,-1}},   color=
             {0,127,255}));
      connect(m_flow_specification.ports[1], TFlow.port_a)
        annotation (Line(points={{-86,20},{-76,20}}, color={0,127,255}));
      connect(TFlow.port_b, distributor.mainFlow) annotation (Line(points={{-58,20},
              {-52,20},{-52,9.6},{-42,9.6}}, color={0,127,255}));
      connect(boundary.ports[1], TReturn.port_a) annotation (Line(points={{-86,-9},{
              -84,-9},{-84,-9},{-76,-9}}, color={0,127,255}));
      connect(TReturn.port_b, distributor.mainReturn) annotation (Line(points={{-60,
              -9},{-56,-9},{-56,-9},{-42,-9}}, color={0,127,255}));

              for i in 1:CircuitNo loop

      connect(panelHeating_Circuit[i].radport_ceiling, radport_ceiling[i])
        annotation (Line(points={{61.68,-16.98},{61.68,-68},{-24,-68},{-24,-94}},
            color={95,95,95}));
      connect(panelHeating_Circuit[i].heatport_ceiling, heatport_ceiling[i])
        annotation (Line(points={{70.32,-17.66},{70.32,-76},{22,-76},{22,-98},{24,-98}},
            color={191,0,0}));
      connect(panelHeating_Circuit[i].radport_floor, radport_floor[i])
        annotation (Line(points={{61.68,16},{52,16},{52,64},{-24,64},{-24,100}},
            color={95,95,95}));
      connect(panelHeating_Circuit[i].heatport_floor, heatport_floor[i])
        annotation (Line(points={{70.32,15.32},{70.32,76},{24,76},{24,96}},
            color={191,0,0}));
    end for;

    end PanelHeatingSystem;

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
      PanelHeatingElement panelHeatingParameters(redeclare package Medium =
            Medium, redeclare Modelica.SIunits.Temperature TRoom=TRoom_set.y)
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

     function logDT =
        AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.logDT;
     model sumT_F "Calculate average floor surface temperature"
       parameter Integer dis(min=1) = 3;

       Modelica.Blocks.Math.MultiSum multiSum(nu=3)
         annotation (Placement(transformation(extent={{-16,12},{-2,26}})));
       Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_F[dis]
         annotation (Placement(transformation(extent={{-68,10},{-48,30}})));
       Modelica.Blocks.Math.Division division
         annotation (Placement(transformation(extent={{46,-10},{64,8}})));
       Modelica.Blocks.Sources.Constant const(k=dis)
         annotation (Placement(transformation(extent={{-6,-30},{6,-18}})));
       Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a[dis]
         annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
       Modelica.Blocks.Interfaces.RealOutput y
         annotation (Placement(transformation(extent={{92,-10},{112,10}})));
     equation
       connect(T_F.T,multiSum. u[1:dis])
         annotation (Line(points={{-48,20},{-16,20},{-16,19}},color={0,0,127}));
       connect(multiSum.y,division. u1)
         annotation (Line(points={{-0.81,19},{32,19},{32,4.4},{44.2,4.4}},
                                                       color={0,0,127}));
       connect(division.u2,const. y) annotation (Line(points={{44.2,-6.4},{32,-6.4},{
               32,-24},{6.6,-24}},
                           color={0,0,127}));

       connect(division.y, y)
         annotation (Line(points={{64.9,-1},{102,-1},{102,0}}, color={0,0,127}));
         for i in 1:dis loop
           connect(T_F[i].port, port_a[i]) annotation (Line(points={{-68,20},{-84,20},
                 {-84,0},{-100,0}},        color={191,0,0}));
         end for;
     end sumT_F;

    package ZoneSpecification
      "Choice for panel heating in what kind of zone the pipes lie"

      record ZoneDefinition
        extends Modelica.Icons.Record;

       parameter Modelica.SIunits.Temperature T_Fmax;
       parameter Modelica.SIunits.Temperature T_Room;
       Modelica.SIunits.HeatFlux q_Gmax = 8.92 * (T_Fmax - T_Room)^1.1;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end ZoneDefinition;

      record Bathroom
        extends Modelica.Icons.Record;
        extends ZoneDefinition(
        T_Fmax = Modelica.SIunits.Conversions.from_degC(33),
        T_Room = Modelica.SIunits.Conversions.from_degC(24),
         q_Gmax = 100);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Bathroom;

      record FringeArea
        extends Modelica.Icons.Record;
        extends ZoneDefinition(
        T_Fmax = Modelica.SIunits.Conversions.from_degC(35),
        T_Room = Modelica.SIunits.Conversions.from_degC(20),
        q_Gmax = 175);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end FringeArea;

      record OccupancyZone
        extends Modelica.Icons.Record;
        extends ZoneDefinition(
        T_Fmax = Modelica.SIunits.Conversions.from_degC(29),
        T_Room = Modelica.SIunits.Conversions.from_degC(20),
        q_Gmax = 100);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end OccupancyZone;
    end ZoneSpecification;

    package PipeMaterials
      "Determining the thermal conductivity for the used pipe material according to table A.13 p.38 DIN 1264-2"
      record PipeMaterial_Definition
        extends Modelica.Icons.Record;

       parameter Modelica.SIunits.ThermalConductivity lambda;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PipeMaterial_Definition;

      record PB_pipe
        extends Modelica.Icons.Record;
        extends PipeMaterials.PipeMaterial_Definition(
          lambda=0.22);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PB_pipe;

      record PP_pipe
        extends Modelica.Icons.Record;
        extends PipeMaterials.PipeMaterial_Definition(
          lambda=0.22);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PP_pipe;

      record PE_X_pipe
        extends Modelica.Icons.Record;
        extends PipeMaterials.PipeMaterial_Definition(
          lambda=0.35);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PE_X_pipe;

      record PE_RT
        extends Modelica.Icons.Record;
        extends PipeMaterials.PipeMaterial_Definition(
          lambda=0.35);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PE_RT;

      record Steel
        extends Modelica.Icons.Record;
        extends PipeMaterials.PipeMaterial_Definition(
          lambda=52);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Steel;

      record Copper
        extends Modelica.Icons.Record;
        extends PipeMaterials.PipeMaterial_Definition(
          lambda=390);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Copper;
    end PipeMaterials;

    package Insulating_Materials
      "Determining the thermal conductivity for the used material for the insulating according to table A.13 p.38 DIN 1264-2"
      record InsulatingMaterial_Definition
        extends Modelica.Icons.Record;

       parameter Modelica.SIunits.ThermalConductivity lambda;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end InsulatingMaterial_Definition;

      record PVC_withTrappedAir
        extends Modelica.Icons.Record;
        extends InsulatingMaterial_Definition(lambda=0.15);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PVC_withTrappedAir;

      record PVC_withoutAir
        extends Modelica.Icons.Record;
        extends InsulatingMaterial_Definition(lambda=0.2);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PVC_withoutAir;

      record none
        extends Modelica.Icons.Record;
        extends InsulatingMaterial_Definition(lambda=0);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end none;
    end Insulating_Materials;

    package Determine_q
      package q_TypeA
        extends Modelica.Icons.UtilitiesPackage;
        model K_H_TypeA
          "Merge of all functions to calculate K_H by typing in needed parameters for panel heating type A"
          parameter Modelica.SIunits.Distance T = 0.1 "Spacing between tubes in m";
          parameter Modelica.SIunits.Diameter D( min = d_a) = 0.01 "Outer diameter of pipe, including insulating in m";

          parameter Modelica.SIunits.Diameter d_a = 0.1 "outer diameter of pipe without insulating in m";
          final parameter Modelica.SIunits.Diameter d_M = D "Outer diameter of insulating in m";

          replaceable parameter Modelica.SIunits.ThermalConductivity lambda_M = 1.2  "Thermal Conductivity for insulating";
          parameter Modelica.SIunits.Thickness s_u = 0.01 "thickness of coverage above pipe (wall layers without flooring)";

          replaceable parameter Modelica.SIunits.ThermalConductivity lambda_R = 0.35 "Coefficient of heat transfer of pipe material";
          constant Modelica.SIunits.ThermalConductivity lambda_R0 = 0.35 "Coeffieicnt of heat transfer of pipe";
          parameter Modelica.SIunits.Thickness s_R = 0.002 "thickness of pipe wall in m";
          constant Modelica.SIunits.Thickness s_R0 = 0.002;
          parameter Modelica.SIunits.ThermalInsulance R_lambdaB = 0.1 "Thermal resistance of flooring in W/(m^2*K)";

          replaceable parameter Modelica.SIunits.ThermalConductivity lambda_E0 = 1.2 "Thermal conductivity of floor screed";
          parameter Modelica.SIunits.VolumeFraction psi "Volume Fraction of holding burls";
          parameter Modelica.SIunits.ThermalConductivity lambda_W = 1.2 "Thermal conductivity of holding burls";

          Modelica.SIunits.ThermalConductivity lambda_E = (1 - psi) * lambda_E0 + psi * lambda_W "effective thermal Conductivity of screed";

          Modelica.SIunits.CoefficientOfHeatTransfer B( start = 6.7) "system dependent coefficient in W/(m^2*K)";
          constant Modelica.SIunits.CoefficientOfHeatTransfer B_0 = 6.7 "system dependent coefficient for lambda_R0 = 0.35 W/(m.K) abd s_R0 = 0.002 m";

          constant Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;
          constant Modelica.SIunits.ThermalConductivity lambda_u0 = 1;
          constant Modelica.SIunits.Diameter s_u0 = 0.045;
          Real a_B = (1 / alpha + s_u0 / lambda_u0) / (1 / alpha + s_u0 / lambda_E + R_lambdaB);
          Real a_T = Determine_aT.a_T;
          Real a_u = Determine_au.a_u;
          Real a_D = Determine_aD.a_D;

          Real m_T = 1 - T / 0.075;
          Real m_u = 100 * (0.045 - s_u);
          Real m_D = 250 * (D - 0.02);

          Real product_ai "product of powers for parameters of floor heating";
          Real product_ai375 "product of powers for T = 0.375";

          Modelica.SIunits.Thickness s_uStar;

          Modelica.SIunits.CoefficientOfHeatTransfer K_H;
          Modelica.SIunits.CoefficientOfHeatTransfer K_HStar = B * a_B * a_T^(m_T) * a_u^(100*(0.045-s_uStar)) * a_D^(m_D);

          replaceable parameter Modelica.SIunits.TemperatureDifference dT_H = 17.38;

          import Modelica.Math.log;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.a_T
            Determine_aT(R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.a_u
            Determine_au(T=T, R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.a_D
            Determine_aD(T=T, R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.a_u
            Determine_au375(R=R_lambdaB, T=0.375)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.a_D
            Determine_aD375(R=R_lambdaB, T=0.375)
            annotation (Placement(transformation(extent={{0,-20},{20,0}})));
        equation

          if lambda_R == 0.35 and s_R == 0.002 then
            B = 6.7;
          else
           if D == d_a then
            1 / B = 1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / 2 * lambda_R * log(d_a / (d_a - 2 * s_R)) - 1 / 2 * lambda_R0 * log(d_a / (d_a - 2 * s_R0)));
            else
            1 / B = 1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / 2 * lambda_M * log(d_M / d_a) + 1 / 2 * lambda_R * log(d_a / (d_a - 2 * s_R)) - 1 / 2 * lambda_R0 * log(d_M / (d_M - 2 * s_R0)));
           end if;
          end if;

          assert(T >= 0.05 and T <= 0.375, "Pipe spacing for m_T should be between 0.05 and 0.375", AssertionLevel.warning);

          assert(s_u >= 0.01, "thickness of screed too low, s_u => 0.010 for calculation of m_u", AssertionLevel.warning);

          assert(D <= 0.08  and D >= 0.03, "Outer diameter should be between 0.008 <= D <= 0.030 for calculation of m_T", AssertionLevel.warning);

          product_ai =  a_B * a_T^(m_T) * a_u^(m_u) * a_D^(m_D);
          product_ai375 =  a_B * a_T^(1-0.375/0.075) * Determine_au375.a_u^(m_u) * Determine_aD375.a_D^(m_D);

           if T > 0.2 then
            s_uStar = 0.5 * T;
          else
            s_uStar = 0.1;
          end if;

           if s_u > s_uStar and s_u > 0.065 then
          K_H = 1 / ( (1 / K_HStar) + ((s_u - s_uStar) / lambda_E));
          else
          if T > 0.375 then
            K_H = B * product_ai375 * 0.375 / T;
          else
            K_H = B * product_ai;
          end if;
        end if;

            annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end K_H_TypeA;

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

        block a_D "Determine a_D following Table A.3 p. 30 DIN 1264-2"

          parameter Modelica.SIunits.Distance T;
          parameter Modelica.SIunits.ThermalInsulance R;
          Modelica.Blocks.Tables.CombiTable2D Table_A3(table=[0.0,0,0.05,0.1,
                0.15; 0.05,1.013,1.013,1.012,1.011; 0.075,1.021,1.019,1.016,
                1.014; 0.1,1.029,1.025,1.022,1.018; 0.15,1.04,1.034,1.029,1.024;
                0.2,1.046,1.04,1.035,1.03; 0.225,1.049,1.043,1.038,1.033; 0.3,
                1.053,1.049,1.044,1.039; 0.375,1.056,1.051,1.046,1.042])
            annotation (Placement(transformation(extent={{-14,-16},{18,16}})));
          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
          Modelica.Blocks.Sources.RealExpression R_lambdaB(y=R)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          Modelica.Blocks.Interfaces.RealOutput a_D
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        equation
          connect(Spacing.y,Table_A3. u1) annotation (Line(points={{-79,10},{-17.2,10},{
                  -17.2,9.6}}, color={0,0,127}));
          connect(R_lambdaB.y,Table_A3. u2) annotation (Line(points={{-79,-10},{-17.2,-10},
                  {-17.2,-9.6}}, color={0,0,127}));
          connect(Table_A3.y,a_D)
            annotation (Line(points={{19.6,0},{100,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end a_D;

        model qG_TypeA
          "Calculating the limiting heat flux for panel heating Types A and C"
          import Modelica.Constants.e;
          extends
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.K_H_TypeA;

          replaceable parameter Modelica.SIunits.Temperature T_Fmax =  29 + 273.15 "maximum surface temperature";
          replaceable parameter Modelica.SIunits.Temperature T_Room =  20 + 273.15 "Room temperature";

          Real f_G;
          final parameter Real phi = (T_Fmax - T_Room / d_T0)^(1.1);
          final parameter Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = Determine_BG.B_G;
          Real n_G = Determine_nG.n_G;

          Modelica.SIunits.HeatFlux q_G;
          Modelica.SIunits.HeatFlux q_G375 = LimitingCurve(phi = phi, B_G = Determine_BG375.B_G, dT_H = dT_H, n_G = Determine_nG375.n_G);
          replaceable parameter Modelica.SIunits.HeatFlux q_Gmax = 100;

          Modelica.SIunits.TemperatureDifference dT_HG;


          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.B_G
            Determine_BG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.n_G
            Determine_nG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.B_G
            Determine_BG375(
            s_u=s_u,
            T=0.375,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.n_G
            Determine_nG375(
            s_u=s_u,
            T=0.375,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{0,-20},{20,0}})));

        equation
          if T <= 0.375 then
          q_G = LimitingCurve(phi = phi, B_G = B_G, dT_H = dT_H, n_G = n_G);
          else
            q_G = q_G375 * 0.375 / T * f_G;
          end if;

          if T <= 0.375 then
            dT_HG = phi * ( B_G / (B * product_ai))^(1/(1-n_G));
          else
            dT_HG = phi * ( Determine_BG375.B_G / (B * product_ai))^(1/(1-Determine_nG.n_G));
          end if;

          if s_u/T <= 0.173 then
            f_G = 1;
          else
            f_G = (q_Gmax - (q_Gmax - q_G375 * 0.375 / T) * e^(-20 * (s_u/T-0.173)^2)) / (q_G375 * 0.375 / T);
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qG_TypeA;

        block B_G "Determination for B_G following tables A.4a and A.4b"

          parameter Modelica.SIunits.Thickness s_u= 0.1 "thickness of cover above pipe in m";
          parameter Modelica.SIunits.Distance T=0.2 "spacing in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";

          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
          Modelica.Blocks.Sources.RealExpression Thickness_of_cover(y=s_u)
            annotation (Placement(transformation(extent={{-100,-14},{-80,6}})));
          Modelica.Blocks.Sources.RealExpression ThermalConductivity_cover(y=lambda_E)
            annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
          Modelica.Blocks.Math.Division division
            annotation (Placement(transformation(extent={{-54,-20},{-40,-6}})));
          Modelica.Blocks.Tables.CombiTable2D Table_A4a(table=[0.0,0.01,0.0208,0.0292,0.0375,
                0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,85,91.5,96.8,100,100,100,100,100,
                100; 0.075,75.3,83.5,89.9,96.3,99.5,100,100,100,100; 0.1,66,75.4,82.9,89.3,
                95.5,98.8,100,100,100; 0.15,51,61.1,69.2,76.3,82.7,87.5,91.8,95.1,97.8;
                0.2,38.5,48.2,56.2,63.1,69.1,74.5,81.3,86.4,90; 0.225,33,42.5,49.5,56.5,
                62,67.5,75.3,81.6,86.1; 0.3,20.5,26.8,31.6,36.4,41.5,47.5,57.5,65.3,72.4;
                0.375,11.5,13.7,15.5,18.2,21.5,27.5,40,49.1,58.3])
            annotation (Placement(transformation(extent={{40,20},{60,40}})));
          Modelica.Blocks.Interfaces.RealOutput B_G
            annotation (Placement(transformation(extent={{86,-10},{106,10}})));
          Modelica.Blocks.Math.Division division1
            annotation (Placement(transformation(extent={{-54,0},{-40,14}})));
          Modelica.Blocks.Tables.CombiTable1D Table_A4b(table=[0.173,27.5; 0.2,40; 0.25,
                57.5; 0.3,69.5; 0.35,78.2; 0.4,84.4; 0.45,88.3; 0.5,91.6; 0.55,94; 0.6,96.3;
                0.65,98.6; 0.7,99.8; 0.75,100])
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));
        equation
          if s_u/lambda_E > 0.0792 and s_u/T < 0.75 then
            B_G = Table_A4b.y[1];
          elseif s_u/lambda_E > 0.0792 and s_u/T > 0.75 then
            B_G = 100;
          else
            B_G = Table_A4a.y;
          end if;
          connect(Thickness_of_cover.y, division.u1) annotation (Line(points={{-79,-4},{
                  -55.4,-4},{-55.4,-8.8}}, color={0,0,127}));
          connect(ThermalConductivity_cover.y, division.u2) annotation (Line(points={{-79,
                  -22},{-55.4,-22},{-55.4,-17.2}}, color={0,0,127}));
          connect(Spacing.y, Table_A4a.u1) annotation (Line(points={{-79,14},{-68,14},{-68,
                  36},{38,36}}, color={0,0,127}));
          connect(Spacing.y, division1.u2) annotation (Line(points={{-79,14},{-74,14},{-74,
                  2},{-55.4,2},{-55.4,2.8}}, color={0,0,127}));
          connect(Thickness_of_cover.y, division1.u1) annotation (Line(points={{-79,-4},
                  {-76,-4},{-76,-2},{-68,-2},{-68,11.2},{-55.4,11.2}}, color={0,0,127}));
          connect(division.y, Table_A4a.u2) annotation (Line(points={{-39.3,-13},{-32,-13},
                  {-32,24},{38,24}}, color={0,0,127}));
          connect(division1.y, Table_A4b.u[1]) annotation (Line(points={{-39.3,7},{-10,7},
                  {-10,-10},{38,-10}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end B_G;

        block n_G "Determination for n_G following tables A.5a and A.5b"

          parameter Modelica.SIunits.Thickness s_u= 0.1 "thickness of cover above pipe in m";
          parameter Modelica.SIunits.Distance T=0.2 "spacing in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";

          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
          Modelica.Blocks.Sources.RealExpression Thickness_of_cover(y=s_u)
            annotation (Placement(transformation(extent={{-100,-14},{-80,6}})));
          Modelica.Blocks.Sources.RealExpression ThermalConductivity_cover(y=lambda_E)
            annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
          Modelica.Blocks.Math.Division division
            annotation (Placement(transformation(extent={{-54,-20},{-40,-6}})));
          Modelica.Blocks.Tables.CombiTable2D Table_A5a(table=[0.0,0.01,0.0208,0.0292,0.0375,
                0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,0.008,0.005,0.002,0,0,0,0,0,0;
                0.075,0.024,0.021,0.018,0.011,0.002,0,0,0,0; 0.1,0.046,0.043,0.041,0.033,
                0.014,0.005,0,0,0; 0.15,0.088,0.085,0.082,0.076,0.055,0.038,0.024,0.014,
                0.006; 0.2,0.131,0.13,0.129,0.123,0.105,0.083,0.057,0.04,0.028; 0.225,0.155,
                0.154,0.153,0.146,0.13,0.11,0.077,0.056,0.041; 0.2625,0.197,0.196,0.196,
                0.19,0.173,0.15,0.11,0.083,0.062; 0.3,0.254,0.253,0.253,0.245,0.228,0.195,
                0.145,0.114,0.086; 0.3375,0.322,0.321,0.321,0.31,0.293,0.26,0.187,0.148,
                0.115; 0.375,0.422,0.421,0.421,0.405,0.385,0.325,0.23,0.183,0.142])
            annotation (Placement(transformation(extent={{40,20},{60,40}})));
          Modelica.Blocks.Interfaces.RealOutput n_G
            annotation (Placement(transformation(extent={{86,-10},{106,10}})));
          Modelica.Blocks.Math.Division division1
            annotation (Placement(transformation(extent={{-54,0},{-40,14}})));
          Modelica.Blocks.Tables.CombiTable1D Table_A5b(table=[0.173,0.32; 0.2,0.23; 0.25,
                0.145; 0.3,0.097; 0.35,0.067; 0.4,0.048; 0.45,0.033; 0.5,0.023; 0.55,0.015;
                0.6,0.009; 0.65,0.005; 0.7,0.002; 0.75,0])
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));
        equation
          if s_u/lambda_E > 0.0792 and s_u/T < 0.75 then
            n_G =Table_A5b.y[1];
          elseif s_u/lambda_E > 0.0792 and s_u/T > 0.75 then
            n_G = 0;
          else
            n_G =Table_A5a.y;
          end if;
          connect(Thickness_of_cover.y, division.u1) annotation (Line(points={{-79,-4},{
                  -55.4,-4},{-55.4,-8.8}}, color={0,0,127}));
          connect(ThermalConductivity_cover.y, division.u2) annotation (Line(points={{-79,
                  -22},{-55.4,-22},{-55.4,-17.2}}, color={0,0,127}));
          connect(Spacing.y,Table_A5a. u1) annotation (Line(points={{-79,14},{-68,14},{-68,
                  36},{38,36}}, color={0,0,127}));
          connect(Spacing.y, division1.u2) annotation (Line(points={{-79,14},{-74,14},{-74,
                  2},{-55.4,2},{-55.4,2.8}}, color={0,0,127}));
          connect(Thickness_of_cover.y, division1.u1) annotation (Line(points={{-79,-4},
                  {-76,-4},{-76,-2},{-68,-2},{-68,11.2},{-55.4,11.2}}, color={0,0,127}));
          connect(division.y,Table_A5a. u2) annotation (Line(points={{-39.3,-13},{-32,-13},
                  {-32,24},{38,24}}, color={0,0,127}));
          connect(division1.y,Table_A5b. u[1]) annotation (Line(points={{-39.3,7},{-10,7},
                  {-10,-10},{38,-10}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end n_G;

        model qN_TypeA
          "Calculating the normative heat flux for panel heating Types A and C"
          import Modelica.Constants.e;
          extends
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.K_H_TypeA(
              R_lambdaB=0);

          final parameter Modelica.SIunits.Temperature T_Fmax = 29 "maximum surface temperature";
          final parameter Modelica.SIunits.Temperature T_Room = 20 "Room temperature";

          Real f_G;
          constant Real phi = 1;
          final parameter Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = Determine_BG.B_G;
          Real n_G = Determine_nG.n_G;

          Modelica.SIunits.HeatFlux q_N;
          Modelica.SIunits.HeatFlux q_N375 = LimitingCurve(phi = phi, B_G = Determine_BG375.B_G, dT_H = dT_H, n_G = Determine_nG375.n_G);
          final parameter Modelica.SIunits.HeatFlux q_Gmax = 100;

          Modelica.SIunits.TemperatureDifference dT_N;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.B_G
            Determine_BG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.n_G
            Determine_nG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          K_H_TypeA Determine_q375(
            D=D,
            d_a=d_a,
            lambda_M=lambda_M,
            s_u=s_u,
            lambda_R=lambda_R,
            s_R=s_R,
            R_lambdaB=R_lambdaB,
            lambda_E=lambda_E,
            dT_H=dT_H,
            T=0.375,
            lambda_E0=lambda_E0,
            psi=psi,
            lambda_W=lambda_W)
            annotation (Placement(transformation(extent={{0,60},{20,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.B_G
            Determine_BG375(
            s_u=s_u,
            T=0.375,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeA.n_G
            Determine_nG375(
            s_u=s_u,
            T=0.375,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{0,-20},{20,0}})));

        equation
          if T <= 0.375 then
          q_N = LimitingCurve(phi = phi, B_G = B_G, dT_H = dT_H, n_G = n_G);
          else
            q_N = q_N375 * 0.375 / T * f_G;
          end if;

          if T <= 0.375 then
            dT_N = phi * ( B_G / (B * product_ai))^(1/(1-n_G));
          else
            dT_N = phi * ( Determine_BG375.B_G / (B * product_ai))^(1/(1-Determine_nG.n_G));
          end if;

          if s_u/T <= 0.173 then
            f_G = 1;
          else
            f_G = (q_Gmax - (q_Gmax - q_N375 * 0.375 / T) * e^(-20 * (s_u/T-0.173)^2)) / (q_N375 * 0.375 / T);
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qN_TypeA;
      end q_TypeA;

      package q_TypeB
        extends Modelica.Icons.UtilitiesPackage;
        model q_TypeB
          "Merge of all functions to calculate q by typing in needed parameters for panel heating type B"
          parameter Modelica.SIunits.Distance T = 0.1 "Spacing between tubes in m";
          parameter Modelica.SIunits.Diameter D( min = d_a) = 0.018 "Outer diameter of pipe, including insulating in m";

          parameter Modelica.SIunits.Diameter d_a = 0.1 "outer diameter of pipe without insulating in m";
          Modelica.SIunits.Diameter d_M = D "Outer diameter of insulating in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_M = 1.2 "Thermal Conductivity for insulating";
          parameter Modelica.SIunits.Thickness s_u = 0.01 "thickness of cover above pipe in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_R = 0.35 "Coefficient of heat transfer of pipe material";
          Modelica.SIunits.ThermalConductivity lambda_R0 = 0.35 "Coefficient of heat transfer of pipe";
          parameter Modelica.SIunits.Thickness s_R = 0.002 "thickness of pipe wall in m";
          Modelica.SIunits.Thickness s_R0 = 0.002;
          parameter Modelica.SIunits.ThermalInsulance R_lambdaB = 0.1 "Thermal resistance of flooring in W/(m^2*K)";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";
          parameter Modelica.SIunits.Thickness s_WL=0.001 "Thickness of constitution for themal conduction";

          replaceable Modelica.SIunits.ThermalConductivity lambda_WL = 1.2 "Thermal conductivity of constitution for thermal conduction";
          parameter Modelica.SIunits.Length L = 0.1 "Width of constitution for thermal conduction";

          Modelica.SIunits.CoefficientOfHeatTransfer B(start = 6.7) "system dependent coefficient in W/(m^2*K)";
          Modelica.SIunits.CoefficientOfHeatTransfer B_0 = 6.7 "system dependent coefficient for lambda_R0 = 0.35 W/(m.K) abd s_R0 = 0.002 m";

          Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;
          Modelica.SIunits.ThermalConductivity lambda_u0 = 1;
          Modelica.SIunits.Diameter s_u0 = 0.045;
          Real a_B;
          Real a_T = Determine_aT.a_T;
          Real a_u;
          Real a_WL;
          Real a_K = Determine_aK.a_K;

          Real m_T;

          Real b_u=Determine_bu.b_u;
          Real fT;

          Real product_ai;
          Modelica.SIunits.CoefficientOfHeatTransfer K_H;
          replaceable Modelica.SIunits.TemperatureDifference dT_H = 1;

          Modelica.SIunits.HeatFlux q;

          import Modelica.Math.log;
          import Modelica.Blocks.Math.Sqrt;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.a_T
            Determine_aT(s_u=s_u, lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.a_K
            Determine_aK(T=T)
            annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.a_WL
            Determine_aWL(
            T=T,
            D=D,
            s_WL=s_WL,
            lambda_WL=lambda_WL,
            s_u=s_u,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.a_WL
            Determine_aWL0(
            T=T,
            D=D,
            lambda_WL=lambda_WL,
            s_u=s_u,
            lambda_E=lambda_E,
            s_WL=0) annotation (Placement(transformation(extent={{-100,-40},{-80,
                    -20}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.b_u
            Determine_bu(T=T) annotation (Placement(transformation(extent={{-100,
                    -80},{-80,-60}})));
        equation

          if lambda_R == 0.35 and s_R == 0.002 then
            B = 6.7;
          else
           if D == d_a then
            1 / B = 1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / 2 * lambda_R * log(d_a / (d_a - 2 * s_R)) - 1 / 2 * lambda_R0 * log(d_a / (d_a - 2 * s_R0)));
            else
            1 / B = 1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / 2 * lambda_M * log(d_M / d_a) + 1 / 2 * lambda_R * log(d_a / (d_a - 2 * s_R)) - 1 / 2 * lambda_R0 * log(d_M / (d_M - 2 * s_R0)));
           end if;
          end if;

          fT = 1 + 0.44 * sqrt(T);

          a_B = (1 / (1 + B * a_u * a_T^(m_T) * a_WL * a_K * R_lambdaB * fT));

          a_u = (1 / alpha + s_u0 / lambda_u0) / (1 / alpha + s_u / lambda_E);

          m_T = 1 - T / 0.075;
          assert(T >= 0.05 and T <= 0.375, "Pipe spacing for m_T should be between 0.05 and 0.375", AssertionLevel.warning);

          if L < T then
            a_WL = Determine_aWL.a_WL - (Determine_aWL.a_WL - Determine_aWL0.a_WL) * (1 - 3.2 * (L / T) + 3.4 * (L / T) ^2 - 1.2 * (L / T)^3);
          else
            a_WL = Determine_aWL.a_WL;
          end if;

          product_ai =  a_B * a_T^(m_T) * a_u * a_WL * a_K;

          K_H = B * product_ai;

          q = K_H * dT_H;

            annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end q_TypeB;

        model qG_TypeB
          "Calculating the limiting heat flux for panel heating Type B"
          extends
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.q_TypeB;

          replaceable Modelica.SIunits.Temperature T_Fmax = 29 + 273.15  "maximum surface temperature";
          replaceable Modelica.SIunits.Temperature T_Room = 20 + 273.15 "Room temperature";

          Real phi = (T_Fmax - T_Room / d_T0)^(1.1);
          Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = Determine_BG.B_G;
          Real n_G = Determine_nG.n_G;
          Modelica.SIunits.TemperatureDifference dT_HG = phi * ( B_G / (B * product_ai))^(1/(1-n_G));

          Real B_GL = Determine_BGL.B_G;
          Real n_GL = Determine_nGL.n_G;
          Real K_WL = CalculateK_WL(s_WL=s_WL,lambda_WL=lambda_WL,b_u=b_u,s_u=s_u,lambda_E=lambda_E);

          Modelica.SIunits.HeatFlux q_G;
          Modelica.SIunits.HeatFlux q_GL = LimitingCurve(phi = phi, B_G = B_GL, n_G = n_GL, dT_H = dT_H);

          replaceable Modelica.SIunits.HeatFlux q_Gmax = 100;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.B_G
            Determine_BG(
            T=T,
            D=D,
            s_WL=s_WL,
            lambda_WL=lambda_WL,
            s_u=s_u,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{0,60},{20,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.n_G
            Determine_nG(
            T=T,
            D=D,
            s_WL=s_WL,
            lambda_WL=lambda_WL,
            s_u=s_u,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.B_G
            Determine_BGL(
            T=T,
            D=D,
            s_WL=s_WL,
            lambda_WL=lambda_WL,
            s_u=s_u,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{40,60},{60,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.n_G
            Determine_nGL(
            T=T,
            D=D,
            s_WL=s_WL,
            lambda_WL=lambda_WL,
            s_u=s_u,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{40,20},{60,40}})));

        equation

          if T == L then
            q_G = q_GL;
          elseif L < T then
            q_G = a_WL / Determine_aWL.a_WL * q_GL;
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qG_TypeB;

        model qN_TypeB
          "Calculating the normative heat flux for panel heating Type B for the condition that L = T"
          extends
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.q_TypeB(
            R_lambdaB=0,
            Determine_aT,
            Determine_aWL,
            Determine_aWL0);

          Modelica.SIunits.Temperature T_Fmax = 29 "maximum surface temperature";
          Modelica.SIunits.Temperature T_Room = 20 "Room temperature";

          Real phi = 1;
          Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = Determine_BG.B_G;
          Real n_G = Determine_nG.n_G;
          Modelica.SIunits.TemperatureDifference dT_N = phi * (B_G / (B * product_ai))^(1/(1-n_G));

          Modelica.SIunits.HeatFlux q_N = LimitingCurve(phi = phi, B_G = B_G, dT_H = dT_H, n_G = n_G);

           Modelica.SIunits.HeatFlux q_Gmax = 100;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.B_G
            Determine_BG(
            T=T,
            D=D,
            s_WL=s_WL,
            lambda_WL=lambda_WL,
            s_u=s_u,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{0,60},{20,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.n_G
            Determine_nG(
            T=T,
            D=D,
            s_WL=s_WL,
            lambda_WL=lambda_WL,
            s_u=s_u,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qN_TypeB;

        block a_T "Defining a_T following table A.6 p.32 DIN 1264-2"
          parameter Modelica.SIunits.Thickness s_u;

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2
                                                                         "Thermal conductivity of floor screed";

          Modelica.Blocks.Tables.CombiTable1D Table_A6(table=[0.01,1.103; 0.02,1.1; 0.03,
                1.097; 0.04,1.093; 0.05,1.091; 0.06,1.088; 0.08,1.082; 0.1,1.075; 0.15,1.064;
                0.18,1.059])
            annotation (Placement(transformation(extent={{-20,-24},{28,24}})));
          Modelica.Blocks.Interfaces.RealOutput a_T
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Blocks.Sources.RealExpression thickness_cover(y=s_u)
            annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
          Modelica.Blocks.Sources.RealExpression ThermalConductivity_cover(y=lambda_E)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          Modelica.Blocks.Math.Division division
            annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
        equation
          connect(Table_A6.y[1], a_T)
            annotation (Line(points={{30.4,0},{100,0}}, color={0,0,127}));
          connect(thickness_cover.y, division.u1) annotation (Line(points={{-79,10},{-72,
                  10},{-72,6},{-64,6}}, color={0,0,127}));
          connect(ThermalConductivity_cover.y, division.u2) annotation (Line(points={{-79,
                  -10},{-72,-10},{-72,-6},{-64,-6}}, color={0,0,127}));
          connect(division.y, Table_A6.u[1])
            annotation (Line(points={{-41,0},{-24.8,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end a_T;

        block a_WL "Defining a_WL following table A.8 p.32 DIN 1264-2"
          parameter Modelica.SIunits.Distance T "Spacing";
          parameter Modelica.SIunits.Diameter D "Outer Diameter";
          parameter Modelica.SIunits.Thickness s_WL "Thickness of constitution for themal conduction";

          replaceable Modelica.SIunits.ThermalConductivity lambda_WL = 1.2
                                                                          "Thermal conductivity of constitution for thermal conduction";
          parameter Modelica.SIunits.Thickness s_u "Thickness of cover above pipe";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";

          Real b_u = Determine_bu.b_u;
          Real K_WL = CalculateK_WL(s_WL=s_WL,lambda_WL=lambda_WL,b_u=b_u,s_u=s_u,lambda_E=lambda_E);

          Modelica.Blocks.Interfaces.RealOutput a_WL
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
          Modelica.Blocks.Sources.RealExpression OuterDiameter(y=D)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          Modelica.Blocks.Tables.CombiTable2D TableA8a(table=[0.0,0.014,0.016,0.018,0.02,
                0.022; 0.05,0.82,0.86,0.9,0.93,0.96; 0.075,0.59,0.644,0.7,0.754,0.8; 0.1,
                0.488,0.533,0.576,0.617,0.658; 0.15,0.387,0.415,0.444,0.47,0.505; 0.2,0.337,
                0.357,0.379,0.4,0.422; 0.225,0.32,0.34,0.357,0.376,0.396; 0.3,0.288,0.3,
                0.315,0.33,0.344; 0.375,0.266,0.278,0.29,0.3,0.312; 0.45,0.25,0.264,0.28,
                0.29,0.3])
            annotation (Placement(transformation(extent={{-20,60},{0,80}})));
          Modelica.Blocks.Tables.CombiTable2D TableA8b(table=[0.0,0.014,0.016,0.018,0.020,
                0.022; 0.05,0.88,0.905,0.93,0.955,0.975; 0.075,0.74,0.776,0.812,0.836,0.859;
                0.1,0.66,0.693,0.726,0.76,0.77; 0.15,0.561,0.58,0.6,0.621,0.642; 0.2,0.49,
                0.51,0.53,0.55,0.57; 0.225,0.467,0.485,0.504,0.522,0.54; 0.3,0.435,0.444,
                0.453,0.462,0.472; 0.375,0.411,0.421,0.434,0.446,0.46; 0.45,0.41,0.42,0.43,
                0.44,0.45])
            annotation (Placement(transformation(extent={{-20,30},{0,50}})));
          Modelica.Blocks.Tables.CombiTable2D TableA8c(table=[0.0,0.014,0.016,0.018,0.020,
                0.022; 0.05,0.92,0.937,0.955,0.97,0.985; 0.075,0.845,0.865,0.885,0.893,0.902;
                0.1,0.81,0.821,0.832,0.843,0.855; 0.15,0.735,0.745,0.755,0.765,0.775; 0.2,
                0.68,0.688,0.695,0.703,0.71; 0.225,0.655,0.663,0.67,0.678,0.685; 0.3,0.585,
                0.592,0.6,0.608,0.615; 0.375,0.55,0.558,0.565,0.573,0.58; 0.45,0.55,0.555,
                0.56,0.565,0.57])
            annotation (Placement(transformation(extent={{-20,2},{0,22}})));
          Modelica.Blocks.Tables.CombiTable2D TableA8d(table=[0.0,0.014,0.016,0.018,0.020,
                0.022; 0.05,0.95,0.96,0.97,0.98,0.99; 0.075,0.92,0.925,0.93,0.935,0.94;
                0.1,0.9,0.905,0.91,0.915,0.92; 0.15,0.855,0.855,0.855,0.855,0.855; 0.2,0.8,
                0.8,0.8,0.8,0.8; 0.225,0.79,0.79,0.79,0.79,0.79; 0.3,0.72,0.72,0.72,0.72,
                0.72; 0.375,0.69,0.69,0.69,0.69,0.69; 0.45,0.68,0.68,0.68,0.68,0.68])
            annotation (Placement(transformation(extent={{-20,-28},{0,-8}})));
          Modelica.Blocks.Tables.CombiTable2D TableA8e(table=[0.0,0.014,0.016,0.018,0.020,
                0.022; 0.05,0.97,0.978,0.985,0.99,0.995; 0.075,0.965,0.964,0.963,0.962,0.96;
                0.1,0.94,0.94,0.94,0.94,0.94; 0.15,0.895,0.895,0.895,0.895,0.895; 0.2,0.86,
                0.86,0.86,0.86,0.86; 0.225,0.84,0.84,0.84,0.84,0.84; 0.3,0.78,0.78,0.78,
                0.78,0.78; 0.375,0.76,0.76,0.76,0.76,0.76; 0.45,0.75,0.75,0.75,0.75,0.75])
            annotation (Placement(transformation(extent={{-20,-56},{0,-36}})));
          Modelica.Blocks.Tables.CombiTable2D TableA8f(table=[0.0,0.5,0.6,0.7,0.8,0.9,1;
                0.05,0.995,0.998,1,1,1,1; 0.075,0.979,0.984,0.99,0.995,0.998,1; 0.1,0.963,
                0.972,0.98,0.988,0.995,1; 0.15,0.924,0.945,0.96,0.974,0.99,1; 0.2,0.894,
                0.921,0.943,0.961,0.98,1; 0.225,0.88,0.908,0.934,0.955,0.975,1; 0.3,0.83,
                0.87,0.91,0.94,0.97,1; 0.375,0.815,0.86,0.9,0.93,0.97,1; 0.45,0.81,0.86,
                0.9,0.93,0.97,1])
            annotation (Placement(transformation(extent={{-20,-84},{0,-64}})));
          Modelica.Blocks.Sources.RealExpression ParameterK_WL(y=K_WL)
            annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
          Modelica.Blocks.Tables.CombiTable1D TableKWL_Infinity(table=[0.05,1; 0.075,1.01;
                0.1,1.02; 0.15,1.04; 0.2,1.06; 0.225,1.07; 0.3,1.09; 0.375,1.1; 0.45,1.1])
            annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.b_u
            Determine_bu(T=T)
            annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
        equation

              a_WL = if K_WL <= 0.1 and K_WL > 0 then
          TableA8b.y
              elseif K_WL <= 0.2 and K_WL > 0.1 then
          TableA8c.y
              elseif K_WL <= 0.3 and K_WL > 0.2 then
          TableA8d.y
              elseif K_WL <= 0.4 and K_WL >0.3 then
          TableA8e.y
              elseif K_WL <= 1 and K_WL > 0.4 then
          TableA8f.y
         elseif
               K_WL > 1 then
                        (TableKWL_Infinity.y[1]-(TableKWL_Infinity.y[1] - TableA8a.y) * ((TableKWL_Infinity.y[1] -1) / (TableKWL_Infinity.y[1] - TableA8a.y))^(K_WL))
         else
             TableA8a.y;

          connect(Spacing.y, TableA8a.u1) annotation (Line(points={{-79,10},{-60,10},{-60,
                  76},{-22,76}}, color={0,0,127}));
          connect(OuterDiameter.y, TableA8a.u2) annotation (Line(points={{-79,-10},{-40,
                  -10},{-40,64},{-22,64}}, color={0,0,127}));
          connect(Spacing.y, TableA8b.u1) annotation (Line(points={{-79,10},{-60,10},{-60,
                  46},{-22,46}}, color={0,0,127}));
          connect(OuterDiameter.y, TableA8b.u2) annotation (Line(points={{-79,-10},{-40,
                  -10},{-40,34},{-22,34}}, color={0,0,127}));
          connect(OuterDiameter.y, TableA8c.u2) annotation (Line(points={{-79,-10},{-40,
                  -10},{-40,6},{-22,6}}, color={0,0,127}));
          connect(Spacing.y, TableA8c.u1) annotation (Line(points={{-79,10},{-60,10},{-60,
                  18},{-22,18}}, color={0,0,127}));
          connect(Spacing.y, TableA8d.u1) annotation (Line(points={{-79,10},{-60,10},{-60,
                  -12},{-22,-12}}, color={0,0,127}));
          connect(OuterDiameter.y, TableA8d.u2) annotation (Line(points={{-79,-10},{-40,
                  -10},{-40,-24},{-22,-24}}, color={0,0,127}));
          connect(Spacing.y, TableA8e.u1) annotation (Line(points={{-79,10},{-60,10},{-60,
                  -40},{-22,-40}}, color={0,0,127}));
          connect(OuterDiameter.y, TableA8e.u2) annotation (Line(points={{-79,-10},{-40,
                  -10},{-40,-52},{-22,-52}}, color={0,0,127}));
          connect(Spacing.y, TableA8f.u1) annotation (Line(points={{-79,10},{-60,10},{-60,
                  -68},{-22,-68}}, color={0,0,127}));
          connect(ParameterK_WL.y, TableA8f.u2)
            annotation (Line(points={{-79,-80},{-22,-80}}, color={0,0,127}));

          connect(Spacing.y, TableKWL_Infinity.u[1]) annotation (Line(points={{-79,10},{
                  -60,10},{-60,-100},{-22,-100}}, color={0,0,127}));

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end a_WL;

        block a_K "Defining a_T following table A.9 p.36 DIN 1264-2"
          parameter Modelica.SIunits.Distance T;

          Modelica.Blocks.Tables.CombiTable1D Table_A9(table=[0.05,1; 0.075,
                0.99; 0.1,0.98; 0.15,0.95; 0.2,0.92; 0.225,0.9; 0.3,0.82; 0.375,
                0.72; 0.45,0.6])
            annotation (Placement(transformation(extent={{-20,-24},{28,24}})));
          Modelica.Blocks.Interfaces.RealOutput a_K
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
        equation
          connect(Table_A9.y[1],a_K)
            annotation (Line(points={{30.4,0},{100,0}}, color={0,0,127}));
          connect(Spacing.y, Table_A9.u[1])
            annotation (Line(points={{-79,0},{-24.8,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end a_K;

        block B_G "Defining B_G following table A.10 p.36 DIN 1264-2"

          parameter Modelica.SIunits.Distance T "Spacing";
          parameter Modelica.SIunits.Diameter D "Outer Diameter";
          parameter Modelica.SIunits.Thickness s_WL "Thickness of constitution for themal conduction";

          replaceable Modelica.SIunits.ThermalConductivity lambda_WL = 1.2 "Thermal conductivity of constitution for thermal conduction";
          parameter Modelica.SIunits.Thickness s_u "Thickness of cover above pipe";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2  "Thermal conductivity of floor screed";

          Real b_u = Determine_bu.b_u;

          Real K_WL = CalculateK_WL(s_WL=s_WL,lambda_WL=lambda_WL,b_u=b_u,s_u=s_u,lambda_E=lambda_E);

          Modelica.Blocks.Interfaces.RealOutput B_G
            annotation (Placement(transformation(extent={{92,-10},{110,8}})));
          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          Modelica.Blocks.Tables.CombiTable2D TableA10(table=[0.0,0.05,0.075,
                0.1,0.15,0.2,0.225,0.3,0.375,0.45; 0.1,92,86.7,79.4,64.8,50.8,
                45.8,27.5,9.9,0; 0.2,93.1,88,81.3,67.5,54.2,49,31.8,15.8,2.4;
                0.3,94.2,89.5,83.3,70.2,57.6,52.5,36,21.3,7; 0.4,95.4,90.7,85.2,
                72.9,60.8,56,40.2,25.7,11.9; 0.5,96.6,92.1,87.2,75.6,64.1,59.3,
                44.4,30,16.6; 0.6,97.8,93.7,89.2,78.3,67.3,62.6,48.6,34.1,21.1;
                0.7,98.7,95,91,81,70.6,66.3,52.8,38.5,25.5; 0.8,99.3,96.3,93,
                83.7,74,69.7,57,42.8,29.6; 0.9,99.8,97.7,95,86.3,77.2,73,61.2,
                47,33.6; 1,100,98.5,96.5,89,80.7,76.6,65.4,51.4,37.3; 1.1,100,
                99.3,97.8,91.5,84,80,69.4,55.6,40.9; 1.2,100,99.6,98.5,93.8,
                87.2,83.3,73.2,59.8,44.3; 1.3,100,99.8,99.3,95.8,90,86.3,76.6,
                63.8,47.5; 1.4,100,100,99.8,97.5,92.5,89,80,67.3,50.5; 1.5,100,
                100,100,98.6,94.8,91.7,83,71,53.4])
            annotation (Placement(transformation(extent={{-12,-16},{18,14}})));
          Modelica.Blocks.Sources.RealExpression KWL(y=K_WL)
            annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.b_u
            Determine_bu(T=T) annotation (Placement(transformation(extent={{-100,
                    80},{-80,100}})));
        equation
          connect(KWL.y, TableA10.u1)
            annotation (Line(points={{-79,8},{-15,8}}, color={0,0,127}));
          connect(Spacing.y, TableA10.u2) annotation (Line(points={{-79,-10},{-15,-10}},
                                   color={0,0,127}));
          connect(TableA10.y, B_G) annotation (Line(points={{19.5,-1},{101,-1}},
                       color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end B_G;

        block n_G "Defining n_G following table A.11 p.37 DIN 1264-2"

           parameter Modelica.SIunits.Distance T "Spacing";
          parameter Modelica.SIunits.Diameter D "Outer Diameter";
          parameter Modelica.SIunits.Thickness s_WL "Thickness of constitution for themal conduction";

          replaceable Modelica.SIunits.ThermalConductivity lambda_WL = 1.2 "Thermal conductivity of constitution for thermal conduction";
          parameter Modelica.SIunits.Thickness s_u "Thickness of cover above pipe";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";

          Real b_u = Determine_bu.b_u;

          Real K_WL = CalculateK_WL(s_WL=s_WL,lambda_WL=lambda_WL,b_u=b_u,s_u=s_u,lambda_E=lambda_E);

          Modelica.Blocks.Interfaces.RealOutput n_G
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          Modelica.Blocks.Tables.CombiTable2D TableA11(table=[0.0,0.05,0.075,
                0.1,0.15,0.2,0.225,0.3,0.375,0.45; 0.1,0.0029,0.017,0.032,0.067,
                0.122,0.151,0.235,0.333,1; 0.2,0.0024,0.015,0.027,0.055,0.097,
                0.12,0.184,0.288,0.725; 0.3,0.0021,0.013,0.024,0.048,0.086,
                0.104,0.169,0.256,0.482; 0.4,0.0018,0.012,0.022,0.044,0.08,
                0.095,0.156,0.228,0.38; 0.5,0.0015,0.011,0.02,0.04,0.074,0.088,
                0.143,0.204,0.31; 0.6,0.0012,0.0099,0.018,0.037,0.067,0.082,
                0.131,0.183,0.25; 0.7,0.0009,0.0097,0.016,0.033,0.061,0.074,
                0.118,0.162,0.21; 0.8,0.006,0.0074,0.014,0.03,0.055,0.067,0.106,
                0.144,0.187; 0.9,0.0003,0.0062,0.012,0.027,0.049,0.06,0.095,
                0.126,0.165; 1,0,0.005,0.01,0.024,0.044,0.053,0.083,0.11,0.143;
                1.1,0,0.0038,0.008,0.021,0.038,0.046,0.072,0.096,0.121; 1.2,0.0,
                0.0025,0.006,0.018,0.032,0.038,0.063,0.084,0.107; 1.3,0.0,
                0.0012,0.004,0.015,0.027,0.034,0.054,0.073,0.093; 1.4,0.0,0.0,
                0.002,0.012,0.022,0.029,0.047,0.063,0.08; 1.5,0.0,0.0,0.0,0.009,
                0.02,0.025,0.04,0.055,0.07])
            annotation (Placement(transformation(extent={{-12,-16},{18,14}})));
          Modelica.Blocks.Sources.RealExpression KWL(y=K_WL)
            annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeB.b_u
            Determine_bu(T=T) annotation (Placement(transformation(extent={{-100,
                    80},{-80,100}})));
        equation
          connect(KWL.y, TableA11.u1)
            annotation (Line(points={{-79,8},{-15,8}}, color={0,0,127}));
          connect(Spacing.y, TableA11.u2) annotation (Line(points={{-79,-10},{-15,-10}},
                                   color={0,0,127}));
          connect(TableA11.y, n_G) annotation (Line(points={{19.5,-1},{58,-1},{58,0},{100,
                  0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end n_G;

        block b_u "Defining b_u following table A.7 p.32 DIN 1264-2"
          parameter Modelica.SIunits.Distance T "Spacing";

          Modelica.Blocks.Interfaces.RealOutput b_u
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
          Modelica.Blocks.Tables.CombiTable1D TableA7(table=[0.05,1; 0.075,1; 0.1,1; 0.15,
                0.7; 0.2,0.5; 0.225,0.43; 0.3,0.25; 0.375,0.1; 0.45,0])
            annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
        equation
          connect(Spacing.y, TableA7.u[1]) annotation (Line(points={{-79,0},{-6,0}},
                                 color={0,0,127}));

          connect(TableA7.y[1], b_u) annotation (Line(points={{17,0},{30,0},{30,
                  0},{100,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end b_u;

        function CalculateK_WL
          input Modelica.SIunits.Thickness s_WL;
          input Modelica.SIunits.ThermalConductivity lambda_WL;
          input Real b_u;
          input Modelica.SIunits.Thickness s_u;
          input Modelica.SIunits.ThermalConductivity lambda_E;
          output Real K_WL;

        algorithm
          K_WL :=(s_WL*lambda_WL + b_u*s_u*lambda_E)/0.125;

        end CalculateK_WL;

      end q_TypeB;

      package q_TypeC
        extends Modelica.Icons.UtilitiesPackage;
        model q_TypeC
          "Merge of all functions to calculate q by typing in needed parameters for panel heating types A and C"
          parameter Modelica.SIunits.Distance T = 0.1 "Spacing between tubes in m";
          parameter Modelica.SIunits.Diameter D( min = d_a) = 0.01 "Outer diameter of pipe, including insulating in m";

          parameter Modelica.SIunits.Diameter d_a = 0.1 "outer diameter of pipe without insulating in m";
          Modelica.SIunits.Diameter d_M = D "Outer diameter of insulating in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_M = 1.2 "Thermal Conductivity for insulating";
          parameter Modelica.SIunits.Thickness s_u = 0.01 "thickness of screed above pipe in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_R = 1.2  "Coefficient of heat transfer of pipe material";
          Modelica.SIunits.ThermalConductivity lambda_R0 = 0.35 "Coeffieicnt of heat transfer of pipe";
          parameter Modelica.SIunits.Thickness s_R = 0.002 "thickness of pipe wall in m";
          Modelica.SIunits.Thickness s_R0 = 0.002;
          parameter Modelica.SIunits.ThermalInsulance R_lambdaB = 0.1 "Thermal resistance of flooring in W/(m^2*K)";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2  "Thermal conductivity of floor screed";

          Modelica.SIunits.CoefficientOfHeatTransfer B( start = 6.7) "system dependent coefficient in W/(m^2*K)";
          Modelica.SIunits.CoefficientOfHeatTransfer B_0 = 6.7 "system dependent coefficient for lambda_R0 = 0.35 W/(m.K) abd s_R0 = 0.002 m";

          Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;
          Modelica.SIunits.ThermalConductivity lambda_u0 = 1;
          Modelica.SIunits.Diameter s_u0 = 0.045;
          Real a_B;
          Real a_T = Determine_aT.a_T;
          Real a_u = Determine_au.a_u;
          Real a_D = Determine_aD.a_D;

          Real m_T;
          Real m_u;
          Real m_D;

          Real product_ai "product of powers for parameters of floor heating";
          Real product_ai375 "product of powers for T = 0.375";

          Modelica.SIunits.Thickness s_uStar;

          Modelica.SIunits.CoefficientOfHeatTransfer K_H;
          Modelica.SIunits.CoefficientOfHeatTransfer K_HStar;
          replaceable Modelica.SIunits.TemperatureDifference dT_H = 1;

          Modelica.SIunits.HeatFlux q;

          import Modelica.Math.log;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.a_T
            Determine_aT(R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.a_u
            Determine_au(T=T, R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.a_D
            Determine_aD(T=T, R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.a_u
            Determine_au375(R=R_lambdaB, T=0.375)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.a_D
            Determine_aD375(R=R_lambdaB, T=0.375)
            annotation (Placement(transformation(extent={{0,-20},{20,0}})));
        equation

          if lambda_R == 0.35 and s_R == 0.002 then
            B = 6.7;
          else
           if D == d_a then
            1 / B = 1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / 2 * lambda_R * log(d_a / (d_a - 2 * s_R)) - 1 / 2 * lambda_R0 * log(d_a / (d_a - 2 * s_R0)));
            else
            1 / B = 1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / 2 * lambda_M * log(d_M / d_a) + 1 / 2 * lambda_R * log(d_a / (d_a - 2 * s_R)) - 1 / 2 * lambda_R0 * log(d_M / (d_M - 2 * s_R0)));
           end if;
          end if;

          a_B = (1 / alpha + s_u0 / lambda_u0) / (1 / alpha + s_u0 / lambda_E + R_lambdaB);

          m_T = 1 - T / 0.075;
          assert(T >= 0.05 and T <= 0.375, "Pipe spacing for m_T should be between 0.05 and 0.375", AssertionLevel.warning);

          m_u = 100 * (0.045 - s_u);
          assert(s_u >= 0.01, "thickness of screed too low, s_u => 0.010 for calculation of m_u", AssertionLevel.warning);

          m_D = 250 * (D - 0.02);
          assert(D <= 0.08  and D >= 0.03, "Outer diameter should be between 0.008 <= D <= 0.030 for calculation of m_T", AssertionLevel.warning);

          product_ai =  a_B * a_T^(m_T) * a_u^(m_u) * a_D^(m_D);
          product_ai375 =  a_B * a_T^(1-0.375/0.075) * Determine_au375.a_u^(m_u) * Determine_aD375.a_D^(m_D);

           if T > 0.2 then
            s_uStar = 0.5 * T;
          else
            s_uStar = 0.1;
          end if;

           K_HStar = B * a_B * a_T^(m_T) * a_u^(100*(0.045-s_uStar)) * a_D^(m_D);

        if s_u > s_uStar and s_u > 0.065 then
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
        end q_TypeC;

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

        block a_D "Determine a_D following Table A.3 p. 30 DIN 1264-2"

          parameter Modelica.SIunits.Distance T;
          parameter Modelica.SIunits.ThermalInsulance R;
          Modelica.Blocks.Tables.CombiTable2D Table_A3(table=[0.0,0,0.05,0.1,
                0.15; 0.05,1.013,1.013,1.012,1.011; 0.075,1.021,1.019,1.016,
                1.014; 0.1,1.029,1.025,1.022,1.018; 0.15,1.04,1.034,1.029,1.024;
                0.2,1.046,1.04,1.035,1.03; 0.225,1.049,1.043,1.038,1.033; 0.3,
                1.053,1.049,1.044,1.039; 0.375,1.056,1.051,1.046,1.042])
            annotation (Placement(transformation(extent={{-14,-16},{18,16}})));
          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
          Modelica.Blocks.Sources.RealExpression R_lambdaB(y=R)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          Modelica.Blocks.Interfaces.RealOutput a_D
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        equation
          connect(Spacing.y,Table_A3. u1) annotation (Line(points={{-79,10},{-17.2,10},{
                  -17.2,9.6}}, color={0,0,127}));
          connect(R_lambdaB.y,Table_A3. u2) annotation (Line(points={{-79,-10},{-17.2,-10},
                  {-17.2,-9.6}}, color={0,0,127}));
          connect(Table_A3.y,a_D)
            annotation (Line(points={{19.6,0},{100,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end a_D;

        model qG_TypeC
          "Calculating the limiting heat flux for panel heating Types A and C"
          import Modelica.Constants.e;
          extends
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.q_TypeC;

          replaceable Modelica.SIunits.Temperature T_Fmax = 29 + 273.15  "maximum surface temperature";
          replaceable Modelica.SIunits.Temperature T_Room = 20 + 273.15 "Room temperature";

          Real f_G;
          Real phi = (T_Fmax - T_Room / d_T0)^(1.1);
          Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = Determine_BG.B_G;
          Real n_G = Determine_nG.n_G;

          Modelica.SIunits.HeatFlux q_G;
          Modelica.SIunits.HeatFlux q_G375 = LimitingCurve(phi = phi, B_G = Determine_BG375.B_G, dT_H = dT_H, n_G = Determine_nG375.n_G);
          replaceable Modelica.SIunits.HeatFlux q_Gmax = 100;

          Modelica.SIunits.TemperatureDifference dT_HG;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.B_G
            Determine_BG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.n_G
            Determine_nG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          q_TypeC Determine_q375(
            D=D,
            d_a=d_a,
            lambda_M=lambda_M,
            s_u=s_u,
            lambda_R=lambda_R,
            s_R=s_R,
            R_lambdaB=R_lambdaB,
            lambda_E=lambda_E,
            dT_H=dT_H,
            T=0.375)
            annotation (Placement(transformation(extent={{0,60},{20,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.B_G
            Determine_BG375(
            s_u=s_u,
            lambda_E=lambda_E,
            T=0.375)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.n_G
            Determine_nG375(
            s_u=s_u,
            lambda_E=lambda_E,
            T=0.375)
            annotation (Placement(transformation(extent={{0,-20},{20,0}})));

        equation
          if T <= 0.375 then
          q_G = LimitingCurve(phi = phi, B_G = B_G, dT_H = dT_H, n_G = n_G);
          else
            q_G = q_G375 * 0.375 / T * f_G;
          end if;

          if T <= 0.375 then
            dT_HG = phi * ( B_G / (B * product_ai))^(1/(1-n_G));
          else
            dT_HG = phi * ( Determine_BG375.B_G / (B * product_ai))^(1/(1-Determine_nG.n_G));
          end if;

          if s_u/T <= 0.173 then
            f_G = 1;
          else
            f_G = (q_Gmax - (q_Gmax - q_G375 * 0.375 / T) * e^(-20 * (s_u/T-0.173)^2)) / (q_G375 * 0.375 / T);
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qG_TypeC;

        block B_G "Determination for B_G following tables A.4a and A.4b"

          parameter Modelica.SIunits.Thickness s_u= 0.1 "thickness of cover above pipe in m";
          parameter Modelica.SIunits.Distance T= 0.2 "spacing in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";

          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
          Modelica.Blocks.Sources.RealExpression Thickness_of_cover(y=s_u)
            annotation (Placement(transformation(extent={{-100,-14},{-80,6}})));
          Modelica.Blocks.Sources.RealExpression ThermalConductivity_cover(y=lambda_E)
            annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
          Modelica.Blocks.Math.Division division
            annotation (Placement(transformation(extent={{-54,-20},{-40,-6}})));
          Modelica.Blocks.Tables.CombiTable2D Table_A4a(table=[0.0,0.01,0.0208,0.0292,0.0375,
                0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,85,91.5,96.8,100,100,100,100,100,
                100; 0.075,75.3,83.5,89.9,96.3,99.5,100,100,100,100; 0.1,66,75.4,82.9,89.3,
                95.5,98.8,100,100,100; 0.15,51,61.1,69.2,76.3,82.7,87.5,91.8,95.1,97.8;
                0.2,38.5,48.2,56.2,63.1,69.1,74.5,81.3,86.4,90; 0.225,33,42.5,49.5,56.5,
                62,67.5,75.3,81.6,86.1; 0.3,20.5,26.8,31.6,36.4,41.5,47.5,57.5,65.3,72.4;
                0.375,11.5,13.7,15.5,18.2,21.5,27.5,40,49.1,58.3])
            annotation (Placement(transformation(extent={{40,20},{60,40}})));
          Modelica.Blocks.Interfaces.RealOutput B_G
            annotation (Placement(transformation(extent={{86,-10},{106,10}})));
          Modelica.Blocks.Math.Division division1
            annotation (Placement(transformation(extent={{-54,0},{-40,14}})));
          Modelica.Blocks.Tables.CombiTable1D Table_A4b(table=[0.173,27.5; 0.2,40; 0.25,
                57.5; 0.3,69.5; 0.35,78.2; 0.4,84.4; 0.45,88.3; 0.5,91.6; 0.55,94; 0.6,96.3;
                0.65,98.6; 0.7,99.8; 0.75,100])
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));
        equation
          if s_u/lambda_E > 0.0792 and s_u/T < 0.75 then
            B_G = Table_A4b.y[1];
          elseif s_u/lambda_E > 0.0792 and s_u/T > 0.75 then
            B_G = 100;
          else
            B_G = Table_A4a.y;
          end if;
          connect(Thickness_of_cover.y, division.u1) annotation (Line(points={{-79,-4},{
                  -55.4,-4},{-55.4,-8.8}}, color={0,0,127}));
          connect(ThermalConductivity_cover.y, division.u2) annotation (Line(points={{-79,
                  -22},{-55.4,-22},{-55.4,-17.2}}, color={0,0,127}));
          connect(Spacing.y, Table_A4a.u1) annotation (Line(points={{-79,14},{-68,14},{-68,
                  36},{38,36}}, color={0,0,127}));
          connect(Spacing.y, division1.u2) annotation (Line(points={{-79,14},{-74,14},{-74,
                  2},{-55.4,2},{-55.4,2.8}}, color={0,0,127}));
          connect(Thickness_of_cover.y, division1.u1) annotation (Line(points={{-79,-4},
                  {-76,-4},{-76,-2},{-68,-2},{-68,11.2},{-55.4,11.2}}, color={0,0,127}));
          connect(division.y, Table_A4a.u2) annotation (Line(points={{-39.3,-13},{-32,-13},
                  {-32,24},{38,24}}, color={0,0,127}));
          connect(division1.y, Table_A4b.u[1]) annotation (Line(points={{-39.3,7},{-10,7},
                  {-10,-10},{38,-10}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end B_G;

        block n_G "Determination for n_G following tables A.5a and A.5b"

          parameter Modelica.SIunits.Thickness s_u= 0.1 "thickness of cover above pipe in m";
          parameter Modelica.SIunits.Distance T=0.2 "spacing in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";

          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
          Modelica.Blocks.Sources.RealExpression Thickness_of_cover(y=s_u)
            annotation (Placement(transformation(extent={{-100,-14},{-80,6}})));
          Modelica.Blocks.Sources.RealExpression ThermalConductivity_cover(y=lambda_E)
            annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
          Modelica.Blocks.Math.Division division
            annotation (Placement(transformation(extent={{-54,-20},{-40,-6}})));
          Modelica.Blocks.Tables.CombiTable2D Table_A5a(table=[0.0,0.01,0.0208,0.0292,0.0375,
                0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,0.008,0.005,0.002,0,0,0,0,0,0;
                0.075,0.024,0.021,0.018,0.011,0.002,0,0,0,0; 0.1,0.046,0.043,0.041,0.033,
                0.014,0.005,0,0,0; 0.15,0.088,0.085,0.082,0.076,0.055,0.038,0.024,0.014,
                0.006; 0.2,0.131,0.13,0.129,0.123,0.105,0.083,0.057,0.04,0.028; 0.225,0.155,
                0.154,0.153,0.146,0.13,0.11,0.077,0.056,0.041; 0.2625,0.197,0.196,0.196,
                0.19,0.173,0.15,0.11,0.083,0.062; 0.3,0.254,0.253,0.253,0.245,0.228,0.195,
                0.145,0.114,0.086; 0.3375,0.322,0.321,0.321,0.31,0.293,0.26,0.187,0.148,
                0.115; 0.375,0.422,0.421,0.421,0.405,0.385,0.325,0.23,0.183,0.142])
            annotation (Placement(transformation(extent={{40,20},{60,40}})));
          Modelica.Blocks.Interfaces.RealOutput n_G
            annotation (Placement(transformation(extent={{86,-10},{106,10}})));
          Modelica.Blocks.Math.Division division1
            annotation (Placement(transformation(extent={{-54,0},{-40,14}})));
          Modelica.Blocks.Tables.CombiTable1D Table_A5b(table=[0.173,0.32; 0.2,0.23; 0.25,
                0.145; 0.3,0.097; 0.35,0.067; 0.4,0.048; 0.45,0.033; 0.5,0.023; 0.55,0.015;
                0.6,0.009; 0.65,0.005; 0.7,0.002; 0.75,0])
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));
        equation
          if s_u/lambda_E > 0.0792 and s_u/T < 0.75 then
            n_G =Table_A5b.y[1];
          elseif s_u/lambda_E > 0.0792 and s_u/T > 0.75 then
            n_G = 0;
          else
            n_G =Table_A5a.y;
          end if;
          connect(Thickness_of_cover.y, division.u1) annotation (Line(points={{-79,-4},{
                  -55.4,-4},{-55.4,-8.8}}, color={0,0,127}));
          connect(ThermalConductivity_cover.y, division.u2) annotation (Line(points={{-79,
                  -22},{-55.4,-22},{-55.4,-17.2}}, color={0,0,127}));
          connect(Spacing.y,Table_A5a. u1) annotation (Line(points={{-79,14},{-68,14},{-68,
                  36},{38,36}}, color={0,0,127}));
          connect(Spacing.y, division1.u2) annotation (Line(points={{-79,14},{-74,14},{-74,
                  2},{-55.4,2},{-55.4,2.8}}, color={0,0,127}));
          connect(Thickness_of_cover.y, division1.u1) annotation (Line(points={{-79,-4},
                  {-76,-4},{-76,-2},{-68,-2},{-68,11.2},{-55.4,11.2}}, color={0,0,127}));
          connect(division.y,Table_A5a. u2) annotation (Line(points={{-39.3,-13},{-32,-13},
                  {-32,24},{38,24}}, color={0,0,127}));
          connect(division1.y,Table_A5b. u[1]) annotation (Line(points={{-39.3,7},{-10,7},
                  {-10,-10},{38,-10}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end n_G;

        model qN_TypeC
          "Calculating the normative heat flux for panel heating Types A and C"
          import Modelica.Constants.e;
          extends
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.q_TypeC(
              R_lambdaB=0);

          Modelica.SIunits.Temperature T_Fmax = 29 "maximum surface temperature";
          Modelica.SIunits.Temperature T_Room = 20 "Room temperature";

          Real f_G;
          Real phi = 1;
          Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = Determine_BG.B_G;
          Real n_G = Determine_nG.n_G;

          Modelica.SIunits.HeatFlux q_N;
          Modelica.SIunits.HeatFlux q_N375 = LimitingCurve(phi = phi, B_G = Determine_BG375.B_G, dT_H = dT_H, n_G = Determine_nG375.n_G);
          Modelica.SIunits.HeatFlux q_Gmax = 100;

          Modelica.SIunits.TemperatureDifference dT_N;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.B_G
            Determine_BG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.n_G
            Determine_nG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E)
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          q_TypeC Determine_q375(
            D=D,
            d_a=d_a,
            lambda_M=lambda_M,
            s_u=s_u,
            lambda_R=lambda_R,
            s_R=s_R,
            R_lambdaB=R_lambdaB,
            lambda_E=lambda_E,
            dT_H=dT_H,
            T=0.375)
            annotation (Placement(transformation(extent={{0,60},{20,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.B_G
            Determine_BG375(
            s_u=s_u,
            lambda_E=lambda_E,
            T=0.375)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeC.n_G
            Determine_nG375(
            s_u=s_u,
            lambda_E=lambda_E,
            T=0.375)
            annotation (Placement(transformation(extent={{0,-20},{20,0}})));

        equation
          if T <= 0.375 then
          q_N = LimitingCurve(phi = phi, B_G = B_G, dT_H = dT_H, n_G = n_G);
          else
            q_N = q_N375 * 0.375 / T * f_G;
          end if;

          if T <= 0.375 then
            dT_N = phi * ( B_G / (B * product_ai))^(1/(1-n_G));
          else
            dT_N = phi * ( Determine_BG375.B_G / (B * product_ai))^(1/(1-Determine_nG.n_G));
          end if;

          if s_u/T <= 0.173 then
            f_G = 1;
          else
            f_G = (q_Gmax - (q_Gmax - q_N375 * 0.375 / T) * e^(-20 * (s_u/T-0.173)^2)) / (q_N375 * 0.375 / T);
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qN_TypeC;
      end q_TypeC;

      package q_TypeD
        extends Modelica.Icons.UtilitiesPackage;
        model q_TypeD
          "Merge of all functions to calculate q by typing in needed parameters for panel heating type D"
          parameter Modelica.SIunits.Thickness s_u = 0.01 "thickness of cover above pipe in m";
          parameter Modelica.SIunits.ThermalInsulance R_lambdaB = 0.1 "Thermal resistance of flooring in W/(m^2*K)";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2
                                                                         "Thermal conductivity of floor screed";

          Modelica.SIunits.CoefficientOfHeatTransfer B = B_0 "system dependent coefficient in W/(m^2*K)";
          Modelica.SIunits.CoefficientOfHeatTransfer B_0 = 6.7 "system dependent coefficient for lambda_R0 = 0.35 W/(m.K) abd s_R0 = 0.002 m";

          Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;
          Modelica.SIunits.ThermalConductivity lambda_u0 = 1;
          Modelica.SIunits.Diameter s_u0 = 0.045;
          Real a_B;
          Real a_T;
          Real a_u;
          Real m_T=1;

          Real product_ai "product of powers for parameters of floor heating";
          Modelica.SIunits.CoefficientOfHeatTransfer K_H;
          replaceable Modelica.SIunits.TemperatureDifference dT_H = 1;

          Modelica.SIunits.HeatFlux q;

        equation
          a_B = (1 / (1 + B * a_u * a_T^(m_T) * R_lambdaB));

          a_u = (1 / alpha + s_u0 / lambda_u0) / (1 / alpha + s_u / lambda_E);

          a_T^(m_T)=1.06;

          product_ai =  a_B * a_T^(m_T) * a_u;

          K_H = B * product_ai;

          q = K_H * dT_H;

            annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end q_TypeD;

        model qG_TypeD
          "Calculating the limiting heat flux for panel heating Type D"
          extends
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeD.q_TypeD;

        replaceable Modelica.SIunits.TemperatureDifference dT_H = 1;

          replaceable Modelica.SIunits.Temperature T_Fmax = 273.15 + 29  "maximum surface temperature";
          replaceable Modelica.SIunits.Temperature T_Room = 273.15 + 20 "Room temperature";

          Real phi = (T_Fmax - T_Room / d_T0)^(1.1);
          Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = 100;
          Real n_G = 0;

          Modelica.SIunits.HeatFlux q_G = LimitingCurve(phi = phi, B_G = B_G, dT_H = dT_H, n_G = n_G);

          Modelica.SIunits.TemperatureDifference dT_HG = phi * ( B_G / (B * product_ai))^(1/(1-n_G));

          replaceable Modelica.SIunits.HeatFlux q_Gmax = 100;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qG_TypeD;

        model qN_TypeD
          "Calculating the normative heat flux for panel heating Type D"
          extends
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.q_TypeD.q_TypeD(
              R_lambdaB=0);

        replaceable Modelica.SIunits.TemperatureDifference dT_H = 1;

          Modelica.SIunits.Temperature T_Fmax = 29 "maximum surface temperature";
          Modelica.SIunits.Temperature T_Room = 20 "Room temperature";

          Real phi = 1;
          Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = 100;
          Real n_G = 0;

          Modelica.SIunits.HeatFlux q_N = LimitingCurve(phi = phi, B_G = B_G, dT_H = dT_H, n_G = n_G);

          Modelica.SIunits.TemperatureDifference dT_N = phi * ( B_G / (B * product_ai))^(1/(1-n_G));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qN_TypeD;
      end q_TypeD;

      function BasicCharacteristic
        "Check for calculated heat flux of panel heating"
        input Modelica.SIunits.Temperature Temp_in[2];
        output Modelica.SIunits.HeatFlux q_Basis;

      algorithm
        q_Basis :=8.92*(Temp_in[1] - Temp_in[2])^1.1;

        annotation (Documentation(revisions="<html>
<ul>
<li><i>June 1, 2020&nbsp;</i> by Elaine Schmitt:<br/>
Moved into AixLib</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Calculation of heat flux that is supposed to be generated from panel heating with given floor temperature (Temp_in[1]) and room temperature (Temp_in[2]). </p>
</html>"));
      end BasicCharacteristic;

      function LimitingCurve
        "Maximum Heat Flux for panel heating following equation 18 p. 11 DIN 1264-4"
        input Real B_G;
        input Modelica.SIunits.TemperatureDifference dT_H "maximum temperature difference between floor surface and room";
        input Real phi;
        input Real n_G;
        output Modelica.SIunits.HeatFlux q_G;

      algorithm
        q_G :=phi*B_G*(dT_H/phi)^n_G;

      end LimitingCurve;

      model HeatFlux_DIN1264_2
        "Upward and downward heat flux according to DIN 1264-2"
        extends
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Determine_q.UpwardHeatFlux_DIN1264(
          qG_TypeA(
            lambda_R=lambda_R,
            T_Fmax=T_Fmax,
            T_Room=T_Room,
            q_Gmax=q_Gmax),
          qN_TypeA(lambda_R=lambda_R),
          qG_TypeB(T_Fmax=T_Fmax, T_Room=T_Room),
          qG_TypeC(T_Fmax=T_Fmax, T_Room=T_Room),
          qG_TypeD(T_Fmax=T_Fmax, T_Room=T_Room));

        parameter Modelica.SIunits.Thickness s_ins = 0.001 "Thickness of thermal insulation";
        parameter Modelica.SIunits.ThermalConductivity lambda_ins = 1.2 "Thermal conductivity of thermal insulation";
        Modelica.SIunits.ThermalInsulance R_lambdaIns = s_ins / lambda_ins "Thermal resistance of thermal insulation";
        parameter Modelica.SIunits.ThermalInsulance R_lambdaCeiling = 0.1 "Thermal resistance of ceiling";
        parameter Modelica.SIunits.ThermalInsulance R_lambdaPlaster = 0.1 "Thermal resistance of plaster";
        constant Modelica.SIunits.ThermalInsulance R_alphaCeiling = 0.17 "Thermal resistance at the ceiling";
        Modelica.SIunits.ThermalConductivity lambda_u = lambda_E0 "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
        parameter Modelica.SIunits.Temperature T_U = Modelica.SIunits.Conversions.from_degC(20) "Temperature of room lying under panel heating";
        constant Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;

        Modelica.SIunits.ThermalInsulance R_U = R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling "Thermal resistance of wall layers under panel heating";
        Modelica.SIunits.ThermalInsulance R_O = 1 / alpha + R_lambdaB + s_u / lambda_u "Thermal resistance of wall layers above panel heating";

        Modelica.SIunits.HeatFlux q_U = 1 / R_U * (R_O * q + T_Room - T_U)
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));

      end HeatFlux_DIN1264_2;

      model UpwardHeatFlux_DIN1264
        "Determination of maximum and normative heat flux according to DIN 1264"

              replaceable parameter Integer paneltype = 1 annotation (Dialog(group="panel heating type accoring to DIN 1264",
              descriptionLabel=true), choices(
            choice=1 "type A: pipes within floor screed",
            choice=2 "type B: pipes under floor screed",
            choice=3 "type C: pipes within levelling screed",
            choice=4 "type D: heating panel element",
            radioButtons=true));
        Boolean TypeA = true if paneltype == 1;
        parameter Modelica.SIunits.Distance T "Spacing between tubes in m";
        replaceable parameter Modelica.SIunits.Temperature T_Fmax = 29 + 273.15 "maximum surface temperature";
        replaceable parameter Modelica.SIunits.Temperature T_Room = 20 + 273.15 "Room temperature";
        replaceable parameter Modelica.SIunits.HeatFlux q_Gmax = 100 "Maximum heat flux";

        replaceable parameter Modelica.SIunits.ThermalConductivity lambda_R = 0.35 "Coefficient of heat transfer of pipe material";
        constant Modelica.SIunits.ThermalConductivity lambda_R0 = 0.35 "Coeffieicnt of heat transfer of pipe";
        parameter Modelica.SIunits.Thickness s_R = 0.002 "thickness of pipe wall in m";
        constant Modelica.SIunits.Thickness s_R0 = 0.002;
        parameter Modelica.SIunits.Diameter D( min = d_a) = 0.01 "Outer diameter of pipe, including insulating in m";

        parameter Modelica.SIunits.Diameter d_a = 0.1 "outer diameter of pipe without insulating in m";
        Modelica.SIunits.Diameter d_M = D "Outer diameter of insulating in m";

        replaceable parameter Modelica.SIunits.ThermalConductivity lambda_M = 1.2  "Thermal Conductivity for insulating";
        parameter Modelica.SIunits.Thickness s_u = 0.01 "thickness of cover above pipe in m";

        parameter Modelica.SIunits.ThermalInsulance R_lambdaB = 0.1 "Thermal resistance of flooring in W/(m^2*K)";
        replaceable parameter Modelica.SIunits.ThermalConductivity lambda_E0 = 1.2 "Thermal conductivity of floor screed";
        parameter Modelica.SIunits.VolumeFraction psi "Volume Fraction of holding burls" annotation (Dialog(enable = TypeA));
        parameter Modelica.SIunits.ThermalConductivity lambda_W = 1.2 "Thermal conductivity of holding burls";
        parameter Modelica.SIunits.Thickness s_WL=0.001 "Thickness of constitution for thermal conduction";
        replaceable parameter Modelica.SIunits.ThermalConductivity lambda_WL = 1.2 "Thermal conductivity of constitution for thermal conduction";
        parameter Modelica.SIunits.Length L "Width of constitution for thermal conduction";
        replaceable parameter Modelica.SIunits.TemperatureDifference dT_H = 17.38 "Temperature difference between heating medium and room";
        Real K_H;

        Modelica.SIunits.HeatFlux q_G;
        Modelica.SIunits.HeatFlux q_N;
        Modelica.SIunits.HeatFlux q = K_H * dT_H;

        q_TypeD.qG_TypeD qG_TypeD(
          s_u=s_u,
          R_lambdaB=R_lambdaB,
          dT_H=dT_H,
          lambda_E=lambda_E0,
          T_Fmax=T_Fmax,
          T_Room=T_Room,
          q_Gmax=q_Gmax)
          annotation (Placement(transformation(extent={{80,60},{100,80}})));
        q_TypeD.qN_TypeD qN_TypeD(
          s_u=s_u,
          R_lambdaB=R_lambdaB,
          dT_H=dT_H,
          lambda_E=lambda_E0)
          annotation (Placement(transformation(extent={{80,20},{100,40}})));
        q_TypeB.qG_TypeB qG_TypeB(
          T=T,
          D=D,
          d_a=d_a,
          lambda_M=lambda_M,
          s_u=s_u,
          lambda_R=lambda_R,
          s_R=s_R,
          R_lambdaB=R_lambdaB,
          s_WL=s_WL,
          lambda_WL=lambda_WL,
          L=L,
          dT_H=dT_H,
          lambda_E=lambda_E0,
          T_Fmax=T_Fmax,
          T_Room=T_Room,
          q_Gmax=q_Gmax)
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

        q_TypeB.qN_TypeB qN_TypeB(
          T=T,
          D=D,
          d_a=d_a,
          lambda_M=lambda_M,
          s_u=s_u,
          lambda_R=lambda_R,
          s_R=s_R,
          R_lambdaB=R_lambdaB,
          s_WL=s_WL,
          lambda_WL=lambda_WL,
          L=L,
          dT_H=dT_H,
          lambda_E=lambda_E0)
          annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
        q_TypeC.qG_TypeC qG_TypeC(
          T=T,
          D=D,
          d_a=d_a,
          lambda_M=lambda_M,
          s_u=s_u,
          lambda_R=lambda_R,
          s_R=s_R,
          R_lambdaB=R_lambdaB,
          dT_H=dT_H,
          lambda_E=lambda_E0,
          T_Fmax=T_Fmax,
          T_Room=T_Room,
          q_Gmax=q_Gmax)
          annotation (Placement(transformation(extent={{20,60},{40,80}})));
        q_TypeC.qN_TypeC qN_TypeC(
          T=T,
          D=D,
          d_a=d_a,
          lambda_M=lambda_M,
          s_u=s_u,
          lambda_R=lambda_R,
          s_R=s_R,
          R_lambdaB=R_lambdaB,
          dT_H=dT_H,
          lambda_E=lambda_E0)
          annotation (Placement(transformation(extent={{20,20},{40,40}})));
        q_TypeA.qG_TypeA qG_TypeA(
          T=T,
          D=D,
          d_a=d_a,
          lambda_M=lambda_M,
          s_u=s_u,
          s_R=s_R,
          R_lambdaB=R_lambdaB,
          psi=psi,
          lambda_W=lambda_W,
          dT_H=dT_H,
          lambda_E0=lambda_E0,
          T_Fmax=T_Fmax,
          T_Room=T_Room,
          q_Gmax=q_Gmax,
          lambda_R=lambda_R)
          annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
        q_TypeA.qN_TypeA qN_TypeA(
          T=T,
          D=D,
          d_a=d_a,
          lambda_M=lambda_M,
          s_u=s_u,
          s_R=s_R,
          R_lambdaB=R_lambdaB,
          psi=psi,
          lambda_W=lambda_W,
          dT_H=dT_H,
          lambda_E0=lambda_E0)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));

      equation
        if paneltype == 1 then
        q_G = qG_TypeA.q_G;
        q_N = qN_TypeA.q_N;
        K_H = qG_TypeA.K_H;
        elseif paneltype == 2 then
          q_G = qG_TypeB.q_G;
          q_N = qN_TypeB.q_N;
          K_H = qG_TypeB.K_H;
        elseif paneltype == 3 then
          q_G = qG_TypeC.q_G;
          q_N = qN_TypeC.q_N;
          K_H = qG_TypeC.K_H;
        elseif paneltype == 4 then
          q_G = qG_TypeD.q_G;
          q_N = qN_TypeD.q_N;
          K_H = qG_TypeD.K_H;
        end if;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end UpwardHeatFlux_DIN1264;

      model PanelHeatingCircuit_AllTypes
        "One Circuit in a Panel Heating System"
        extends Fluid.Interfaces.PartialTwoPort;

        parameter Integer dis(min=1) "Number of Discreatisation Layers";

        parameter Boolean Ceiling = true "false if ground plate is under panel heating" annotation (Dialog(group=
                "Room Specifications"), choices(checkBox=true));

        parameter Modelica.SIunits.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
        parameter Integer n_floor(min = 1) "Number of floor layers" annotation(Dialog(group = "Room Specifications"));
        parameter Modelica.SIunits.Thickness d_floor[n_floor] "Thickness of floor layers" annotation(Dialog(group = "Room Specifications"));
        parameter Modelica.SIunits.Density rho_floor[n_floor] "Density of floor layers" annotation(Dialog(group = "Room Specifications"));
        parameter Modelica.SIunits.ThermalConductivity lambda_floor[n_floor] "Thermal conductivity of floor layers" annotation(Dialog(group = "Room Specifications"));
        parameter Modelica.SIunits.SpecificHeatCapacity c_floor[n_floor] "Specific heat capacity of floor layers" annotation(Dialog(group = "Room Specifications"));
        parameter Integer n_ceiling(min = 1) "Number of ceiling layers" annotation(Dialog(group = "Room Specifications"));
        parameter Modelica.SIunits.Thickness d_ceiling[n_ceiling] "Thickness of ceiling layers" annotation(Dialog(group = "Room Specifications"));
        parameter Modelica.SIunits.Density rho_ceiling[n_ceiling] "Density of ceiling layers" annotation(Dialog(group = "Room Specifications"));
        parameter Modelica.SIunits.ThermalConductivity lambda_ceiling[n_ceiling] "Thermal conductivity of ceiling layers" annotation(Dialog(group = "Room Specifications"));
        parameter Modelica.SIunits.SpecificHeatCapacity c_ceiling[n_ceiling] "Specific heat capacity of ceiling layers" annotation(Dialog(group = "Room Specifications"));

        parameter Modelica.SIunits.Emissivity eps = 0.95 "Emissivity";

        parameter Modelica.SIunits.Power Q_Nf "Calculated Heat Load for room with panel heating" annotation (Dialog(group="Room Specifications"));
        final parameter Modelica.SIunits.HeatFlux q_des = Q_Nf / A "set value for panel heating heat flux";
        parameter Modelica.SIunits.Temperature T_U = Modelica.SIunits.Conversions.from_degC(20) "Set value for Room Temperature lying under panel heating" annotation (Dialog(group="Room Specifications"));

            replaceable parameter
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.ZoneSpecification.ZoneDefinition
          ZoneType=
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.ZoneSpecification.OccupancyZone()
               annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);

        final parameter Modelica.SIunits.Temperature T_Fmax = ZoneType.T_Fmax;
        final parameter Modelica.SIunits.Temperature T_Room = ZoneType.T_Room;
        final parameter Modelica.SIunits.HeatFlux q_Gmax = ZoneType.q_Gmax;

        replaceable parameter Integer paneltype=1 annotation (Dialog(group="Panel Heating",
              descriptionLabel=true), choices(
            choice=1 "type A: pipes within floor screed",
            choice=2 "type B: pipes under floor screed",
            choice=3 "type C: pipes within levelling screed",
            choice=4 "type D: heating panel element",
            radioButtons=true));

        parameter Modelica.SIunits.Distance T = 0.1 "Spacing between tubes" annotation (Dialog( group = "Panel Heating"));
        parameter Modelica.SIunits.Diameter D = 0.01 "Outer diameter of pipe including insulating" annotation (Dialog( group = "Panel Heating"));
        final parameter Modelica.SIunits.Length PipeLength = A / T "Length of Panel Heating Pipe";

        replaceable parameter
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.PipeMaterials.PipeMaterial_Definition
          PipeMaterial=
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.PipeMaterials.PE_RT()
               annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
        final parameter Modelica.SIunits.ThermalConductivity lambda_R = PipeMaterial.lambda "Thermal conductivity of pipe material";
        constant Modelica.SIunits.ThermalConductivity lambda_R0 = 0.35 "Thermal conductivity of pipe";
        parameter Modelica.SIunits.Thickness s_R = 0.002 "thickness of pipe wall" annotation (Dialog( group = "Panel Heating"));
        constant Modelica.SIunits.Thickness s_R0 = 0.002;
        parameter Modelica.SIunits.Diameter d_a = 0.1 "outer diameter of pipe without insulating" annotation (Dialog( group = "Panel Heating"));
        final parameter Modelica.SIunits.Diameter d_M = D "Outer diameter of insulating";
        replaceable parameter
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Insulating_Materials.InsulatingMaterial_Definition
          InsulatingMaterial=
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Insulating_Materials.none()
               annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
        final parameter Modelica.SIunits.ThermalConductivity lambda_M = InsulatingMaterial.lambda "Thermal Conductivity for insulating";

        parameter Modelica.SIunits.VolumeFraction psi "Volume Fraction of holding burls" annotation (Dialog( group = "Panel Heating"));
        parameter Modelica.SIunits.ThermalConductivity lambda_W = 1.2 "Thermal conductivity of holding burls" annotation (Dialog( group = "Panel Heating"));

          replaceable parameter
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Constitution_Materials.ConstitutionMaterial_Definition
          ConstitutionMaterial=
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Constitution_Materials.Aluminium()
               annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
        parameter Modelica.SIunits.Thickness s_WL=0.001 "Thickness of constitution for thermal conduction" annotation (Dialog( group = "Panel Heating"));
        final parameter Modelica.SIunits.ThermalConductivity lambda_WL = ConstitutionMaterial.lambda "Thermal conductivity of constitution for thermal conduction";
        parameter Modelica.SIunits.Length L = 0 "Width of constitution for thermal conduction" annotation (Dialog( group = "Panel Heating"));

        parameter Modelica.SIunits.Thickness s_ins = 0.001 "Thickness of thermal insulation" annotation (Dialog( group = "Floor"));
        parameter Modelica.SIunits.ThermalConductivity lambda_ins = 1.2 "Thermal conductivity of thermal insulation" annotation (Dialog( group = "Floor"));
        final parameter Modelica.SIunits.ThermalInsulance R_lambdaIns = s_ins / lambda_ins "Thermal resistance of thermal insulation";

        parameter Modelica.SIunits.Thickness s_u = 0.01 "thickness of cover above pipe" annotation (Dialog( group = "Floor"));
        final parameter Modelica.SIunits.ThermalConductivity lambda_u = ScreedMaterial.lambda "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
        replaceable parameter
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Screed_Materials.ScreedMaterial_Definition
          ScreedMaterial=
            AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.Screed_Materials.CementScreed()
               annotation (Dialog(group="Floor"), choicesAllMatching=true);
        final parameter Modelica.SIunits.ThermalConductivity lambda_E0 = lambda_u "Thermal conductivity of cover";

        parameter Modelica.SIunits.ThermalInsulance R_lambdaB = 0.1 "Thermal resistance of flooring in W/(m^2*K)" annotation (Dialog( group = "Floor"));

        parameter Modelica.SIunits.ThermalInsulance R_lambdaCeiling = 0.1 "Thermal resistance of ceiling" annotation (Dialog( group = "Ceiling"));
        parameter Modelica.SIunits.ThermalInsulance R_lambdaPlaster = 0.1 "Thermal resistance of plaster" annotation (Dialog( group = "Ceiling"));

        Modelica.SIunits.Temperature T_Fm = sum(panelHeatingParameters.T_F) / dis "arithmetic mean of floor temperature";

        Modelica.SIunits.TemperatureDifference sigma = TFlow.T - TReturn.T "Actual Temperature Difference in Panel Heating Tube";
        parameter Modelica.SIunits.TemperatureDifference sigma_i = 5 "Temperature Spread for room (max = 5 for room with highest heat load)";
        constant Modelica.SIunits.SpecificHeatCapacity c_W = 4190;
        final parameter Modelica.SIunits.ThermalInsulance R_U = R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling "Thermal resistance of wall layers under panel heating";
        final parameter Modelica.SIunits.ThermalInsulance R_O = 1 / alpha + R_lambdaB + s_u / lambda_u "Thermal resistance of wall layers above panel heating";
        constant Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;
        constant Modelica.SIunits.ThermalInsulance R_alphaCeiling = 0.17 "Thermal resistance at the ceiling";

        final parameter Modelica.SIunits.MassFlowRate m_H = A * q_des / (sigma_i * c_W) * (1 + (R_O / R_U) + (T_Room - T_U) / (q_des * R_U)) "nominal mass flow";

        Modelica.SIunits.TemperatureDifference dT_H=logDT(Temp_in) "Temperature Difference between heating medium and Room";
        Modelica.SIunits.Temperature Temp_in[3] = {TFlow.T, TReturn.T, T_Room};
        parameter Modelica.SIunits.TemperatureDifference dT_Hi = 17.38;

        Modelica.SIunits.HeatFlux q_G = heatFlux_DIN1264.q_G "critical heat flow";
        Modelica.SIunits.HeatFlux q = heatFlux_DIN1264.q "supposable heat flow";
        Modelica.SIunits.HeatFlux q_N = heatFlux_DIN1264.q_N "nominative heat flow";
        Real K_H = heatFlux_DIN1264.K_H;

        AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.PanelHeatingElement
          panelHeatingParameters[dis](
          redeclare package Medium = Medium,
          each T=T,
          each m_H=m_H,
          each floor_length=floor_length/sqrt(dis),
          each floor_width=floor_width/sqrt(dis),
          each ceiling_length=ceiling_length/sqrt(dis),
          each ceiling_width=ceiling_width/sqrt(dis),
          eps=eps,
          each d_i=d_i,
          each n_floor=n_floor,
          each d_floor=d_floor,
          each rho_floor=rho_floor,
          each lambda_floor=lambda_floor,
          each c_floor=c_floor,
          each n_ceiling=n_ceiling,
          each d_ceiling=d_ceiling,
          each rho_ceiling=rho_ceiling,
          each lambda_ceiling=lambda_ceiling,
          each c_ceiling=c_ceiling,
          Ceiling=true,
          each A=A/dis)
          annotation (Placement(transformation(extent={{-20,-18},{20,18}})));

        Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
              Medium)
          annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
              Medium)
          annotation (Placement(transformation(extent={{42,-10},{62,10}})));

        Utilities.Interfaces.RadPort radport_floor[dis]
          annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_floor[dis]
          annotation (Placement(transformation(extent={{8,86},{28,106}}),
              iconTransformation(extent={{8,86},{28,106}})));
        Utilities.Interfaces.RadPort radport_ceiling[dis]
          annotation (Placement(transformation(extent={{-34,-104},{-14,-84}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_ceiling[dis]
          annotation (Placement(transformation(extent={{14,-108},{34,-88}})));
        EN1264.HeatFlux_EN1264_2 EN_1264
          annotation (Placement(transformation(extent={{-100,-60},{-60,-40}})));
      equation
        assert(PipeLength > 120, "Pipe Length is too high, additional heating circuit needs to be used", AssertionLevel.warning);
        assert(T_Fm > T_Fmax, "Surface temperature too high", AssertionLevel.warning);

      //OUTER CONNECTIONS

        connect(TFlow.port_b, panelHeatingParameters[1].port_a)
          annotation (Line(points={{-38,0},{-20,0}}, color={0,127,255}));

        connect(panelHeatingParameters[dis].port_b, TReturn.port_a)
          annotation (Line(points={{20,0},{42,0}}, color={0,127,255}));

      // HEAT CONNECTIONS

      for i in 1:dis loop
        connect(radport_floor[i], panelHeatingParameters[i].radport_floor)
          annotation (Line(points={{-30,100},{-28,100},{-28,74},{-6,74},{-6,18}},
              color={95,95,95}));
        connect(heatport_floor[i], panelHeatingParameters[i].heatport_floor)
          annotation (Line(points={{18,96},{18,72},{3.6,72},{3.6,17.28}},      color={
                191,0,0}));
        connect(panelHeatingParameters[i].heatport_ceiling, heatport_ceiling[i])
          annotation (Line(points={{4.8,-17.64},{4.8,-38},{24,-38},{24,-98}},
              color={191,0,0}));
        connect(panelHeatingParameters[i].radport_ceiling, radport_ceiling[i])
          annotation (Line(points={{-4.8,-16.92},{-4.8,-36},{-24,-36},{-24,-94}},
              color={95,95,95}));
      end for;

        //INNER CONNECTIONS

        if dis > 1 then
          for i in 1:(dis-1) loop
        connect(panelHeatingParameters[i].port_b, panelHeatingParameters[i+1].port_a)
          annotation (Line(
            points={{20,0},{20,-12},{-20,-12},{-20,0}},
            color={0,127,255},
            pattern=LinePattern.Dash));
          end for;
        end if;

        connect(port_a, TFlow.port_a)
          annotation (Line(points={{-100,0},{-58,0}}, color={0,127,255}));
        connect(TReturn.port_b, port_b)
          annotation (Line(points={{62,0},{100,0}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PanelHeatingCircuit_AllTypes;

      package Constitution_Materials
        "Determining the thermal conductivity for the used material for the constitution of thermal conduction according to table A.13 p.38 DIN 1264-2"
        record ConstitutionMaterial_Definition
          extends Modelica.Icons.Record;

         parameter Modelica.SIunits.ThermalConductivity lambda;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end ConstitutionMaterial_Definition;

        record Aluminium
          extends Modelica.Icons.Record;
          extends ConstitutionMaterial_Definition(lambda=0.22);

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Aluminium;

        record Steel
          extends Modelica.Icons.Record;
          extends ConstitutionMaterial_Definition(lambda=52);

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Steel;
      end Constitution_Materials;

      package Screed_Materials
        "Determining the thermal conductivity for the used material for the floor screed according to table A.13 p.38 DIN 1264-2"
        record ScreedMaterial_Definition
          extends Modelica.Icons.Record;

         parameter Modelica.SIunits.ThermalConductivity lambda;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end ScreedMaterial_Definition;

        record CementScreed
          extends Modelica.Icons.Record;
          extends ScreedMaterial_Definition(lambda=1.2);

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end CementScreed;

        record AnhydriteScreed
          extends Modelica.Icons.Record;
          extends ScreedMaterial_Definition(lambda=1.2);

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end AnhydriteScreed;

        record MasticAsphaltScreed
          extends Modelica.Icons.Record;
          extends ScreedMaterial_Definition(lambda=0.9);

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end MasticAsphaltScreed;
      end Screed_Materials;
    end Determine_q;

    package EN1264
      "Calculation of parameters for dimensioning the panel heating for types A and C"
      package TablesAndParameters
        "Package includes tables and parameters for panel heating Type A (EN 1264)"
        extends Modelica.Icons.UtilitiesPackage;
        model K_H_TypeA
          "Merge of all functions to calculate K_H by typing in needed parameters for panel heating type A"

          parameter Modelica.SIunits.Distance T "Spacing between tubes";
          parameter Modelica.SIunits.Diameter d_a "outer diameter of pipe";
          parameter Modelica.SIunits.ThermalConductivity lambda_R "Coefficient of heat transfer of pipe material";
          constant Modelica.SIunits.ThermalConductivity lambda_R0 = 0.35;
          parameter Modelica.SIunits.Thickness s_R "thickness of pipe wall";
          constant Modelica.SIunits.Thickness s_R0 = 0.002;

          parameter Boolean withInsulating = true "false if pipe has no insulating" annotation (choices(checkBox=true));
          parameter Modelica.SIunits.Diameter D(min = d_a) "Outer diameter of pipe, including insulating" annotation (Dialog(enable = withInsulating));
          final parameter Modelica.SIunits.Diameter d_M = D "Outer diameter of insulating in m";
          parameter Modelica.SIunits.ThermalConductivity lambda_M(min=0)  "Thermal Conductivity for insulating" annotation (Dialog(enable = withInsulating));

          parameter Boolean withHoldingBurls = true "false if there are no holding burls for pipe" annotation (choices(checkBox=true));
          parameter Modelica.SIunits.VolumeFraction psi(start=0) "Volume Fraction of holding burls" annotation (Dialog(enable = withHoldingBurls));
          parameter Modelica.SIunits.ThermalConductivity lambda_W(start=0) "Thermal conductivity of holding burls" annotation (Dialog(enable = withHoldingBurls));

           parameter Modelica.SIunits.Thickness s_u "thickness of floor screed";
          parameter Modelica.SIunits.ThermalConductivity lambda_E0 "Thermal conductivity of floor screed";
          parameter Modelica.SIunits.ThermalConductivity lambda_E = (1 - psi) * lambda_E0 + psi * lambda_W "effective thermal Conductivity of screed" annotation(Dialog(enable = false));
          parameter Modelica.SIunits.ThermalInsulance R_lambdaB "Thermal resistance of flooring";

          Modelica.SIunits.CoefficientOfHeatTransfer B( start = 6.7) "system dependent coefficient";
          constant Modelica.SIunits.CoefficientOfHeatTransfer B_0 = 6.7 "system dependent coefficient for lambda_R0 = 0.35 W/(m.K) abd s_R0 = 0.002 m";

          constant Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;
          constant Modelica.SIunits.ThermalConductivity lambda_u0 = 1;
          constant Modelica.SIunits.Diameter s_u0 = 0.045;
          final parameter Real a_B = (1 / alpha + s_u0 / lambda_u0) / (1 / alpha + s_u0 / lambda_E + R_lambdaB);
          Real a_T = Determine_aT.a_T;
          Real a_u = Determine_au.a_u;
          Real a_D = Determine_aD.a_D;

          final parameter Real m_T = 1 - T / 0.075;
          final parameter Real m_u = 100 * (0.045 - s_u);
          final parameter Real m_D = 250 * (D - 0.02);

          Real product_ai "product of powers for parameters of floor heating";
          Real product_ai375 "product of powers for T = 0.375";

          Modelica.SIunits.Thickness s_uStar;

          Modelica.SIunits.CoefficientOfHeatTransfer K_H;
          Modelica.SIunits.CoefficientOfHeatTransfer K_HStar = B * a_B * a_T^(m_T) * a_u^(100*(0.045-s_uStar)) * a_D^(m_D);

          import Modelica.Math.log;

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.a_T
            Determine_aT(R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,60},{-60,80}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.a_u
            Determine_au(T=T, R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,20},{-60,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.a_D
            Determine_aD(T=T, R=R_lambdaB)
            annotation (Placement(transformation(extent={{-100,-20},{-60,0}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.a_u
            Determine_au375(R=R_lambdaB, T=0.375)
            annotation (Placement(transformation(extent={{0,20},{40,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.a_D
            Determine_aD375(R=R_lambdaB, T=0.375)
            annotation (Placement(transformation(extent={{0,-20},{40,0}})));
        equation

          if lambda_R == 0.35 and s_R == 0.002 then
            B = 6.7;
          else
           if D == d_a then
            1 / B = 1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / 2 * lambda_R * log(d_a / (d_a - 2 * s_R)) - 1 / 2 * lambda_R0 * log(d_a / (d_a - 2 * s_R0)));
            else
            1 / B = 1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / 2 * lambda_M * log(d_M / d_a) + 1 / 2 * lambda_R * log(d_a / (d_a - 2 * s_R)) - 1 / 2 * lambda_R0 * log(d_M / (d_M - 2 * s_R0)));
           end if;
          end if;

          assert(T >= 0.05 and T <= 0.375, "Pipe spacing for m_T should be between 0.05 and 0.375", AssertionLevel.warning);

          assert(s_u >= 0.01, "thickness of screed too low, s_u => 0.010 for calculation of m_u", AssertionLevel.warning);

          assert(D <= 0.08  and D >= 0.03, "Outer diameter should be between 0.008 <= D <= 0.030 for calculation of m_T", AssertionLevel.warning);

          product_ai =  a_B * a_T^(m_T) * a_u^(m_u) * a_D^(m_D);
          product_ai375 =  a_B * a_T^(1-0.375/0.075) * Determine_au375.a_u^(m_u) * Determine_aD375.a_D^(m_D);

           if T > 0.2 then
            s_uStar = 0.5 * T;
          else
            s_uStar = 0.1;
          end if;

           if s_u > s_uStar and s_u > 0.065 then
          K_H = 1 / ( (1 / K_HStar) + ((s_u - s_uStar) / lambda_E));
          else
          if T > 0.375 then
            K_H = B * product_ai375 * 0.375 / T;
          else
            K_H = B * product_ai;
          end if;
        end if;

            annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end K_H_TypeA;

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

        block a_D "Determine a_D following Table A.3 p. 30 DIN 1264-2"

          parameter Modelica.SIunits.Distance T;
          parameter Modelica.SIunits.ThermalInsulance R;
          Modelica.Blocks.Tables.CombiTable2D Table_A3(table=[0.0,0,0.05,0.1,
                0.15; 0.05,1.013,1.013,1.012,1.011; 0.075,1.021,1.019,1.016,
                1.014; 0.1,1.029,1.025,1.022,1.018; 0.15,1.04,1.034,1.029,1.024;
                0.2,1.046,1.04,1.035,1.03; 0.225,1.049,1.043,1.038,1.033; 0.3,
                1.053,1.049,1.044,1.039; 0.375,1.056,1.051,1.046,1.042])
            annotation (Placement(transformation(extent={{-14,-16},{18,16}})));
          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
          Modelica.Blocks.Sources.RealExpression R_lambdaB(y=R)
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
          Modelica.Blocks.Interfaces.RealOutput a_D
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        equation
          connect(Spacing.y,Table_A3. u1) annotation (Line(points={{-79,10},{-17.2,10},{
                  -17.2,9.6}}, color={0,0,127}));
          connect(R_lambdaB.y,Table_A3. u2) annotation (Line(points={{-79,-10},{-17.2,-10},
                  {-17.2,-9.6}}, color={0,0,127}));
          connect(Table_A3.y,a_D)
            annotation (Line(points={{19.6,0},{100,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end a_D;

        model qG_TypeA
          "Calculating the limiting heat flux for panel heating Types A and C"
          import Modelica.Constants.e;

          extends AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.K_H_TypeA;

          parameter Modelica.SIunits.Temperature T_Fmax "maximum surface temperature";
          parameter Modelica.SIunits.Temperature T_Room "Room temperature";

          Real f_G;
          final parameter Real phi = (T_Fmax - T_Room / d_T0)^(1.1);
          final parameter Modelica.SIunits.TemperatureDifference d_T0 = 9;
          Real B_G = Determine_BG.B_G;
          Real n_G = Determine_nG.n_G;

          Modelica.SIunits.HeatFlux q_G;
          Modelica.SIunits.HeatFlux q_G375 = LimitingCurve(phi = phi, B_G = Determine_BG375.B_G, dT_H = dT_H, n_G = Determine_nG375.n_G);
          parameter Modelica.SIunits.HeatFlux q_Gmax "maximum possible heat flux";

          Modelica.SIunits.TemperatureDifference dT_HG;
          parameter Modelica.SIunits.TemperatureDifference dT_H "logarithmic temperature difference between heating medium and room";

          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.B_G
            Determine_BG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{-60,20},{-20,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.n_G
            Determine_nG(
            s_u=s_u,
            T=T,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{-60,-20},{-20,0}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.B_G
            Determine_BG375(
            s_u=s_u,
            T=0.375,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{40,20},{80,40}})));
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.TablesAndParameters.n_G
            Determine_nG375(
            s_u=s_u,
            T=0.375,
            lambda_E=lambda_E0)
            annotation (Placement(transformation(extent={{40,-20},{80,0}})));

        equation
          if T <= 0.375 then
          q_G = LimitingCurve(phi = phi, B_G = B_G, dT_H = dT_H, n_G = n_G);
          else
            q_G = q_G375 * 0.375 / T * f_G;
          end if;

          if T <= 0.375 then
            dT_HG = phi * ( B_G / (B * product_ai))^(1/(1-n_G));
          else
            dT_HG = phi * ( Determine_BG375.B_G / (B * product_ai))^(1/(1-Determine_nG.n_G));
          end if;

          if s_u/T <= 0.173 then
            f_G = 1;
          else
            f_G = (q_Gmax - (q_Gmax - q_G375 * 0.375 / T) * e^(-20 * (s_u/T-0.173)^2)) / (q_G375 * 0.375 / T);
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qG_TypeA;

        block B_G "Determination for B_G following tables A.4a and A.4b"

          parameter Modelica.SIunits.Thickness s_u= 0.1 "thickness of cover above pipe in m";
          parameter Modelica.SIunits.Distance T=0.2 "spacing in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";

          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
          Modelica.Blocks.Sources.RealExpression Thickness_of_cover(y=s_u)
            annotation (Placement(transformation(extent={{-100,-14},{-80,6}})));
          Modelica.Blocks.Sources.RealExpression ThermalConductivity_cover(y=lambda_E)
            annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
          Modelica.Blocks.Math.Division division
            annotation (Placement(transformation(extent={{-54,-20},{-40,-6}})));
          Modelica.Blocks.Tables.CombiTable2D Table_A4a(table=[0.0,0.01,0.0208,0.0292,0.0375,
                0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,85,91.5,96.8,100,100,100,100,100,
                100; 0.075,75.3,83.5,89.9,96.3,99.5,100,100,100,100; 0.1,66,75.4,82.9,89.3,
                95.5,98.8,100,100,100; 0.15,51,61.1,69.2,76.3,82.7,87.5,91.8,95.1,97.8;
                0.2,38.5,48.2,56.2,63.1,69.1,74.5,81.3,86.4,90; 0.225,33,42.5,49.5,56.5,
                62,67.5,75.3,81.6,86.1; 0.3,20.5,26.8,31.6,36.4,41.5,47.5,57.5,65.3,72.4;
                0.375,11.5,13.7,15.5,18.2,21.5,27.5,40,49.1,58.3])
            annotation (Placement(transformation(extent={{40,20},{60,40}})));
          Modelica.Blocks.Interfaces.RealOutput B_G
            annotation (Placement(transformation(extent={{86,-10},{106,10}})));
          Modelica.Blocks.Math.Division division1
            annotation (Placement(transformation(extent={{-54,0},{-40,14}})));
          Modelica.Blocks.Tables.CombiTable1D Table_A4b(table=[0.173,27.5; 0.2,40; 0.25,
                57.5; 0.3,69.5; 0.35,78.2; 0.4,84.4; 0.45,88.3; 0.5,91.6; 0.55,94; 0.6,96.3;
                0.65,98.6; 0.7,99.8; 0.75,100])
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));
        equation
          if s_u/lambda_E > 0.0792 and s_u/T < 0.75 then
            B_G = Table_A4b.y[1];
          elseif s_u/lambda_E > 0.0792 and s_u/T > 0.75 then
            B_G = 100;
          else
            B_G = Table_A4a.y;
          end if;
          connect(Thickness_of_cover.y, division.u1) annotation (Line(points={{-79,-4},{
                  -55.4,-4},{-55.4,-8.8}}, color={0,0,127}));
          connect(ThermalConductivity_cover.y, division.u2) annotation (Line(points={{-79,
                  -22},{-55.4,-22},{-55.4,-17.2}}, color={0,0,127}));
          connect(Spacing.y, Table_A4a.u1) annotation (Line(points={{-79,14},{-68,14},{-68,
                  36},{38,36}}, color={0,0,127}));
          connect(Spacing.y, division1.u2) annotation (Line(points={{-79,14},{-74,14},{-74,
                  2},{-55.4,2},{-55.4,2.8}}, color={0,0,127}));
          connect(Thickness_of_cover.y, division1.u1) annotation (Line(points={{-79,-4},
                  {-76,-4},{-76,-2},{-68,-2},{-68,11.2},{-55.4,11.2}}, color={0,0,127}));
          connect(division.y, Table_A4a.u2) annotation (Line(points={{-39.3,-13},{-32,-13},
                  {-32,24},{38,24}}, color={0,0,127}));
          connect(division1.y, Table_A4b.u[1]) annotation (Line(points={{-39.3,7},{-10,7},
                  {-10,-10},{38,-10}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end B_G;

        block n_G "Determination for n_G following tables A.5a and A.5b"

          parameter Modelica.SIunits.Thickness s_u= 0.1 "thickness of cover above pipe in m";
          parameter Modelica.SIunits.Distance T=0.2 "spacing in m";

          replaceable Modelica.SIunits.ThermalConductivity lambda_E = 1.2 "Thermal conductivity of floor screed";

          Modelica.Blocks.Sources.RealExpression Spacing(y=T)
            annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
          Modelica.Blocks.Sources.RealExpression Thickness_of_cover(y=s_u)
            annotation (Placement(transformation(extent={{-100,-14},{-80,6}})));
          Modelica.Blocks.Sources.RealExpression ThermalConductivity_cover(y=lambda_E)
            annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
          Modelica.Blocks.Math.Division division
            annotation (Placement(transformation(extent={{-54,-20},{-40,-6}})));
          Modelica.Blocks.Tables.CombiTable2D Table_A5a(table=[0.0,0.01,0.0208,0.0292,0.0375,
                0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,0.008,0.005,0.002,0,0,0,0,0,0;
                0.075,0.024,0.021,0.018,0.011,0.002,0,0,0,0; 0.1,0.046,0.043,0.041,0.033,
                0.014,0.005,0,0,0; 0.15,0.088,0.085,0.082,0.076,0.055,0.038,0.024,0.014,
                0.006; 0.2,0.131,0.13,0.129,0.123,0.105,0.083,0.057,0.04,0.028; 0.225,0.155,
                0.154,0.153,0.146,0.13,0.11,0.077,0.056,0.041; 0.2625,0.197,0.196,0.196,
                0.19,0.173,0.15,0.11,0.083,0.062; 0.3,0.254,0.253,0.253,0.245,0.228,0.195,
                0.145,0.114,0.086; 0.3375,0.322,0.321,0.321,0.31,0.293,0.26,0.187,0.148,
                0.115; 0.375,0.422,0.421,0.421,0.405,0.385,0.325,0.23,0.183,0.142])
            annotation (Placement(transformation(extent={{40,20},{60,40}})));
          Modelica.Blocks.Interfaces.RealOutput n_G
            annotation (Placement(transformation(extent={{86,-10},{106,10}})));
          Modelica.Blocks.Math.Division division1
            annotation (Placement(transformation(extent={{-54,0},{-40,14}})));
          Modelica.Blocks.Tables.CombiTable1D Table_A5b(table=[0.173,0.32; 0.2,0.23; 0.25,
                0.145; 0.3,0.097; 0.35,0.067; 0.4,0.048; 0.45,0.033; 0.5,0.023; 0.55,0.015;
                0.6,0.009; 0.65,0.005; 0.7,0.002; 0.75,0])
            annotation (Placement(transformation(extent={{40,-20},{60,0}})));
        equation
          if s_u/lambda_E > 0.0792 and s_u/T < 0.75 then
            n_G =Table_A5b.y[1];
          elseif s_u/lambda_E > 0.0792 and s_u/T > 0.75 then
            n_G = 0;
          else
            n_G =Table_A5a.y;
          end if;
          connect(Thickness_of_cover.y, division.u1) annotation (Line(points={{-79,-4},{
                  -55.4,-4},{-55.4,-8.8}}, color={0,0,127}));
          connect(ThermalConductivity_cover.y, division.u2) annotation (Line(points={{-79,
                  -22},{-55.4,-22},{-55.4,-17.2}}, color={0,0,127}));
          connect(Spacing.y,Table_A5a. u1) annotation (Line(points={{-79,14},{-68,14},{-68,
                  36},{38,36}}, color={0,0,127}));
          connect(Spacing.y, division1.u2) annotation (Line(points={{-79,14},{-74,14},{-74,
                  2},{-55.4,2},{-55.4,2.8}}, color={0,0,127}));
          connect(Thickness_of_cover.y, division1.u1) annotation (Line(points={{-79,-4},
                  {-76,-4},{-76,-2},{-68,-2},{-68,11.2},{-55.4,11.2}}, color={0,0,127}));
          connect(division.y,Table_A5a. u2) annotation (Line(points={{-39.3,-13},{-32,-13},
                  {-32,24},{38,24}}, color={0,0,127}));
          connect(division1.y,Table_A5b. u[1]) annotation (Line(points={{-39.3,7},{-10,7},
                  {-10,-10},{38,-10}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end n_G;

      end TablesAndParameters;

      function BasicCharacteristic
        "Check for calculated heat flux of panel heating"
        input Modelica.SIunits.Temperature T_Fm;
        input Modelica.SIunits.Temperature T_Room;
        output Modelica.SIunits.HeatFlux q_Basis;

      algorithm
        q_Basis :=8.92*(T_Fm - T_Room)^1.1;

        annotation (Documentation(revisions="<html>
<ul>
<li><i>June 1, 2020&nbsp;</i> by Elaine Schmitt:<br/>
Moved into AixLib</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Calculation of heat flux that is supposed to be generated from panel heating with given floor temperature (Temp_in[1]) and room temperature (Temp_in[2]). </p>
</html>"));
      end BasicCharacteristic;

      function LimitingCurve
        "Maximum Heat Flux for panel heating following equation 18 p. 11 DIN 1264-4"
        input Real B_G;
        input Modelica.SIunits.TemperatureDifference dT_H "maximum temperature difference between floor surface and room";
        input Real phi;
        input Real n_G;
        output Modelica.SIunits.HeatFlux q_G;

      algorithm
        q_G :=phi*B_G*(dT_H/phi)^n_G;

      end LimitingCurve;

      model HeatFlux_EN1264_2
        "Upward and downward heat flux according to EN 1264-2"
        extends
          AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeatingNew.AddParameters.EN1264.UpwardHeatFlux_EN1264(
            Calculate_qG(withInsulating=true, withHoldingBurls=true));

        parameter Modelica.SIunits.Thickness s_ins "Thickness of thermal insulation";
        parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity of thermal insulation";
        final parameter Modelica.SIunits.ThermalInsulance R_lambdaIns = s_ins / lambda_ins "Thermal resistance of thermal insulation";
        parameter Modelica.SIunits.ThermalInsulance R_lambdaCeiling "Thermal resistance of ceiling";
        parameter Modelica.SIunits.ThermalInsulance R_lambdaPlaster "Thermal resistance of plaster";
        constant Modelica.SIunits.ThermalInsulance R_alphaCeiling = 0.17 "Thermal resistance at the ceiling";
        final parameter Modelica.SIunits.ThermalConductivity lambda_u = lambda_E0 "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
        parameter Modelica.SIunits.Temperature T_U "Temperature of room lying under panel heating";
        constant Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10.8;

        final parameter Modelica.SIunits.ThermalInsulance R_U = R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling "Thermal resistance of wall layers under panel heating";
        final parameter Modelica.SIunits.ThermalInsulance R_O = 1 / alpha + R_lambdaB + s_u / lambda_u "Thermal resistance of wall layers above panel heating";

        Modelica.SIunits.HeatFlux q_U = 1 / R_U * (R_O * q_max + T_Room - T_U)
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));

      end HeatFlux_EN1264_2;

      model UpwardHeatFlux_EN1264
        "Determination of maximum and normative heat flux according to EN 1264 for types A and C"

        parameter Modelica.SIunits.Temperature T_Fmax "maximum surface temperature";
        parameter Modelica.SIunits.Temperature T_Room "Room temperature";
        parameter Modelica.SIunits.HeatFlux q_Gmax = BasicCharacteristic(T_Fm = T_Fmax, T_Room = T_Room) "Maximum possible heat flux" annotation(Dialog(enable=false));

        parameter Modelica.SIunits.Distance T "Spacing between tubes";
        parameter Modelica.SIunits.Diameter d_a "outer diameter of pipe";
        parameter Modelica.SIunits.ThermalConductivity lambda_R "Coefficient of heat transfer of pipe material";
        parameter Modelica.SIunits.Thickness s_R "thickness of pipe wall";

        parameter Boolean withInsulating = true "false if pipe has no insulating" annotation (choices(checkBox=true));
        parameter Modelica.SIunits.Diameter D(min = d_a) "Outer diameter of pipe, including insulating" annotation (Dialog(enable = withInsulating));
        parameter Modelica.SIunits.ThermalConductivity lambda_M(min=0)  "Thermal Conductivity for insulating" annotation (Dialog(enable = withInsulating));

        parameter Boolean withHoldingBurls = true "false if there are no holding burls for pipe" annotation (choices(checkBox=true));
        parameter Modelica.SIunits.VolumeFraction psi(start=0) "Volume Fraction of holding burls" annotation (Dialog(enable = withHoldingBurls));
        parameter Modelica.SIunits.ThermalConductivity lambda_W(start=0) "Thermal conductivity of holding burls" annotation (Dialog(enable = withHoldingBurls));

        parameter Modelica.SIunits.Thickness s_u "thickness of floor screed";
        parameter Modelica.SIunits.ThermalConductivity lambda_E0 "Thermal conductivity of floor screed";
        parameter Modelica.SIunits.ThermalConductivity lambda_E = (1 - psi) * lambda_E0 + psi * lambda_W "effective thermal Conductivity of screed" annotation(Dialog(enable = false));
        parameter Modelica.SIunits.ThermalInsulance R_lambdaB "Thermal resistance of flooring";

        parameter Modelica.SIunits.TemperatureDifference dT_H "Logarithmic Temperature Difference between heating medium and room";

        Real K_H = Calculate_qG.K_H;

        Modelica.SIunits.HeatFlux q_G = Calculate_qG.q_G;
        Modelica.SIunits.HeatFlux q_N = Calculate_qN.q_G;
        Modelica.SIunits.HeatFlux q_max = K_H * dT_H;

        TablesAndParameters.qG_TypeA Calculate_qG(
          T=T,
          D=D,
          d_a=d_a,
          lambda_M=lambda_M,
          s_u=s_u,
          s_R=s_R,
          R_lambdaB=R_lambdaB,
          psi=psi,
          lambda_W=lambda_W,
          lambda_E0=lambda_E0,
          T_Fmax=T_Fmax,
          T_Room=T_Room,
          q_Gmax=q_Gmax,
          lambda_R=lambda_R,
          dT_H=dT_H,
          withInsulating=withInsulating,
          withHoldingBurls=withHoldingBurls)
                     annotation (Placement(transformation(extent={{20,60},{60,80}})));

        TablesAndParameters.qG_TypeA Calculate_qN(
          T=T,
          D=D,
          d_a=d_a,
          lambda_M=lambda_M,
          s_u=s_u,
          lambda_R=lambda_R,
          s_R=s_R,
          R_lambdaB=0,
          lambda_E0=lambda_E0,
          psi=psi,
          lambda_W=lambda_W,
          q_Gmax=100,
          dT_H=dT_H,
          withInsulating=withInsulating,
          withHoldingBurls=withHoldingBurls,
          T_Fmax=302.15,
          T_Room=293.15)
          annotation (Placement(transformation(extent={{20,20},{60,40}})));
      equation

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end UpwardHeatFlux_EN1264;

    end EN1264;
  end AddParameters;
end PanelHeatingNew;
