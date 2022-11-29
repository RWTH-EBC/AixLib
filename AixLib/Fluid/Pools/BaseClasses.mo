within AixLib.Fluid.Pools;
package BaseClasses
    extends Modelica.Icons.BasesPackage;

  model HeatTransferConduction
    "Heat transfer due to conduction through pool walls"
    parameter Modelica.Units.SI.Area AInnerPoolWall;
    parameter Modelica.Units.SI.Area APoolWallWithEarthContact;
    parameter Modelica.Units.SI.Area APoolFloorWithEarthContact;
    parameter Modelica.Units.SI.Area AInnerPoolFloor;

    parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterHorizontal;
    parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterVertical;

    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature HeatFlowOuter
      "Generate Heat Flow for earth contact" annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={74,-28})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_a
      "Inlet for heattransfer"  annotation (Placement(transformation(extent={{-116,
              -14},{-90,12}}),
          iconTransformation(extent={{-116,-14},{-90,12}})));

    Modelica.Blocks.Interfaces.RealInput TSoil "Temperature of Soil" annotation (Placement(transformation(extent={{130,-48},
              {90,-8}}),
          iconTransformation(extent={{126,16},{86,56}})));

    AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
      InnerPoolFloor(
      A=AInnerPoolFloor,
     wallRec=PoolWall,
      T_start=fill((0), (PoolWall.n)))
               annotation (Placement(transformation(extent={{-10,-34},{18,-10}})));
    AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterHorizontalInner(
      hCon_const=hConWaterHorizontal,
      A=AInnerPoolFloor,
      calcMethod=3,
      surfaceOrientation=1)
                    annotation (Placement(transformation(
          origin={-48,-22},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterVerticalOuter(
      hCon_const=hConWaterVertical,
      A=APoolWallWithEarthContact,
      calcMethod=3,
      surfaceOrientation=1)  annotation (Placement(transformation(
          origin={-54,40},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
      PoolWallWithEarthContact(
      A=APoolWallWithEarthContact,
      wallRec=PoolWall,
      T_start=fill((0), (PoolWall.n)))
               annotation (Placement(transformation(extent={{-6,26},{22,54}})));
    AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterHorizontalOuter(
      hCon_const=hConWaterHorizontal,
      A=APoolFloorWithEarthContact,
      calcMethod=3,
      surfaceOrientation=1)  annotation (Placement(transformation(
          origin={-52,-60},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
      PoolFloorWithEarthContact(
      A=APoolFloorWithEarthContact,
      wallRec=PoolWall,
      T_start=fill((0), (PoolWall.n)))
               annotation (Placement(transformation(extent={{-10,-72},{14,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
      prescribedHeatFlow1 "Generate Heat Flow for earth contact"
                             annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={44,12})));
    AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
      InnerPoolWall(
      A=AInnerPoolWall,
      wallRec=PoolWall,
      T_start=fill((0), (PoolWall.n)))
               annotation (Placement(transformation(extent={{-6,64},{22,92}})));
    Modelica.Blocks.Sources.RealExpression HeatFlowInner(y=0)
      "Inner pool walls are not connected to other zones, only outer pool walls have earth contact"
      annotation (Placement(transformation(extent={{96,2},{76,22}})));
    AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterVerticalInner(
      hCon_const=hConWaterVertical,
      A=AInnerPoolWall,
      calcMethod=3,
      surfaceOrientation=1)  annotation (Placement(transformation(
          origin={-54,78},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition PoolWall
      annotation (Placement(transformation(extent={{76,-98},{96,-78}})));
  equation
    connect(HeatFlowOuter.T, TSoil)
      annotation (Line(points={{81.2,-28},{110,-28}}, color={0,0,127}));
    connect(heatport_a, heatport_a)
      annotation (Line(points={{-103,-1},{-103,-1}}, color={191,0,0}));
    connect(HeatConvWaterHorizontalInner.port_a, InnerPoolFloor.port_a)
      annotation (Line(points={{-38,-22},{-10,-22}}, color={191,0,0}));
    connect(PoolFloorWithEarthContact.port_b, HeatFlowOuter.port) annotation (
        Line(points={{14,-61},{58,-61},{58,-28},{68,-28}}, color={191,0,0}));
    connect(PoolFloorWithEarthContact.port_a, HeatConvWaterHorizontalOuter.port_a)
      annotation (Line(points={{-10,-61},{-10,-60},{-42,-60}}, color={191,0,0}));
    connect(InnerPoolWall.port_b, prescribedHeatFlow1.port) annotation (Line(
          points={{22,78},{30,78},{30,12},{38,12}}, color={191,0,0}));
    connect(HeatConvWaterVerticalOuter.port_b, heatport_a) annotation (Line(
          points={{-64,40},{-72,40},{-72,-1},{-103,-1}}, color={191,0,0}));
    connect(HeatConvWaterHorizontalInner.port_b, heatport_a) annotation (Line(
          points={{-58,-22},{-72,-22},{-72,-1},{-103,-1}}, color={191,0,0}));
    connect(HeatConvWaterHorizontalOuter.port_b, heatport_a) annotation (Line(
          points={{-62,-60},{-72,-60},{-72,-1},{-103,-1}}, color={191,0,0}));
    connect(prescribedHeatFlow1.Q_flow, HeatFlowInner.y)
      annotation (Line(points={{50,12},{75,12}}, color={0,0,127}));
    connect(HeatFlowOuter.port, PoolWallWithEarthContact.port_b) annotation (Line(
          points={{68,-28},{58,-28},{58,40},{22,40}}, color={191,0,0}));
    connect(InnerPoolFloor.port_b, prescribedHeatFlow1.port) annotation (Line(
          points={{18,-22},{30,-22},{30,12},{38,12}}, color={191,0,0}));
    connect(HeatConvWaterVerticalOuter.port_a, PoolWallWithEarthContact.port_a)
      annotation (Line(points={{-44,40},{-6,40}}, color={191,0,0}));
    connect(InnerPoolWall.port_a, HeatConvWaterVerticalInner.port_a) annotation (
        Line(points={{-6,78},{-44,78}},                   color={191,0,0}));
    connect(HeatConvWaterVerticalInner.port_b, heatport_a) annotation (Line(
          points={{-64,78},{-72,78},{-72,-1},{-103,-1}},color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-80,58},{28,-26}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{28,68},{48,-46}},
            lineColor={135,135,135},
            fillColor={175,175,175},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-86,-26},{30,-46}},
            lineColor={135,135,135},
            fillColor={175,175,175},
            fillPattern=FillPattern.Forward),
          Polygon(
            points={{-16,-10},{-4,6},{58,-52},{46,-62},{-16,-10}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{32,-68},{36,-66},{62,-38},{76,-78},{32,-68}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>This model is a base model to calculate the heat transfer through pool walls. The pool walls are sorted by: vertical walls with earth contact, pool floor with earth contact and the sum of walls and pool floor without earth contact.</p>
</html>"));
  end HeatTransferConduction;

  model waveMachine "Calculate energy demands of a wave machine"

    parameter Modelica.Units.SI.Length h_wave "Height of generated wave";
    parameter Modelica.Units.SI.Length w_wave
      "Width of wave machine outlet/of generated wave";
    parameter Modelica.Units.SI.Time wavePool_startTime
      "Start time of first wave cycle";
    parameter Modelica.Units.SI.Time wavePool_period "Time of cycling period";
    parameter Real wavePool_width "Length of wave generation within cycling period";

    Modelica.Blocks.Math.RealToBoolean useWavePool(threshold=1)
      "If input = 1, then true, else no waves generated"
      annotation (Placement(transformation(extent={{-58,-8},{-42,8}})));
    Modelica.Blocks.Tables.CombiTable1Dv tablePWave(
      y(unit="W/m"),
      tableOnFile=false,
      table=[0,0; 0.7,3500; 0.9,6000; 1.3,12000],
      extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
      "Estimate consumed power per width to generate wave of a certain heigth; "
      annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
    Modelica.Blocks.Sources.RealExpression get_h_wave(y=h_wave)
      "Get height of generated wave"
      annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
    Modelica.Blocks.Interfaces.RealInput open "Input profil of wave machine"
      annotation (Placement(transformation(extent={{-136,-20},{-96,20}})));
    Modelica.Blocks.Interfaces.RealOutput PWaveMachine( final unit="W", final quantity="Power")
      "Power consumption of wave machine"
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
    Modelica.Blocks.Math.Gain multiply(k=w_wave) "Multply by width of wave"
      annotation (Placement(transformation(extent={{0,52},{16,68}})));
    Modelica.Blocks.Sources.Constant zero(k=0)
      "no output if wave machine is off"
      annotation (Placement(transformation(extent={{-14,-78},{0,-64}})));
    Modelica.Blocks.Logical.Switch switchWaveMachine
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
    Modelica.Blocks.Sources.BooleanPulse wavePoolCycle(
      width=wavePool_width,
      period=wavePool_period,
      startTime=wavePool_startTime)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  equation
    connect(get_h_wave.y, tablePWave.u[1]) annotation (Line(points={{-69,60},{-48,
            60}},                  color={0,0,127}));
    connect(multiply.u, tablePWave.y[1]) annotation (Line(points={{-1.6,60},{-25,60}},
                                color={0,0,127}));
    connect(open, useWavePool.u)
      annotation (Line(points={{-116,0},{-59.6,0}}, color={0,0,127}));
    connect(switchWaveMachine.y, PWaveMachine) annotation (Line(points={{81,0},{
            106,0}},                     color={0,0,127}));
    connect(multiply.y, switchWaveMachine.u1)
      annotation (Line(points={{16.8,60},{42,60},{42,8},{58,8}},
                                                               color={0,0,127}));
    connect(zero.y, switchWaveMachine.u3) annotation (Line(points={{0.7,-71},{52,-71},
            {52,-8},{58,-8}},         color={0,0,127}));
    connect(PWaveMachine, PWaveMachine) annotation (Line(
        points={{106,0},{101,0},{101,0},{106,0}},
        color={0,0,127},
        smooth=Smooth.Bezier));
    connect(useWavePool.y, and1.u1)
      annotation (Line(points={{-41.2,0},{-10,0}}, color={255,0,255}));
    connect(and1.y, switchWaveMachine.u2)
      annotation (Line(points={{13,0},{58,0}}, color={255,0,255}));
    connect(wavePoolCycle.y, and1.u2) annotation (Line(points={{-39,-40},{-24,-40},
            {-24,-8},{-10,-8}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
          Line(
            points={{-98,0},{-52,62},{-2,-24},{50,60},{100,-2}},
            color={28,108,200},
            smooth=Smooth.Bezier,
            thickness=1),
          Line(
            points={{-98,-18},{-52,44},{-2,-42},{50,42},{98,-20}},
            color={28,108,200},
            smooth=Smooth.Bezier,
            thickness=1),
          Line(
            points={{-98,-36},{-52,26},{-2,-60},{50,24},{96,-36}},
            color={28,108,200},
            smooth=Smooth.Bezier,
            thickness=1)}),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Model to calculate the energy demand of a wavemachine. Based on values of:</p>
<ul>
<li>German Association for the Recreational and Medicinal Bath Industry (Deutsche Gesellschaft f&uuml;r das Badewesen DGfdB), April 2015 : Richtlinien f&uuml;r den B&auml;derbau</li>
<li>Chroistoph Saunus, 2005: Schwimmb&auml;der Planung - Ausf&uuml;hrung - Betrieb</li>
</ul>
</html>"));
  end waveMachine;
end BaseClasses;
