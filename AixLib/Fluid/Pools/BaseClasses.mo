within AixLib.Fluid.Pools;
package BaseClasses "Base classes for Swimming Pool Models"

  model HeatTransferConduction
    "Heat transfer due to conduction through pool walls"

    parameter Modelica.SIunits.Temperature T_start "Temperature of room bordering the pool walls";

    // Exterior Pool Wall - with earth contact - only vertical
    parameter Integer nExt(min = 1) "Number of RC-elements of exterior walls with earth contact"
      annotation(Dialog(group="Exterior walls"));
    parameter Modelica.SIunits.ThermalResistance RExt[nExt](
      each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b exterior wall with earth contact" annotation(Dialog(group="Exterior walls"));

    parameter Modelica.SIunits.ThermalResistance RExtRem(
      min=Modelica.Constants.small) "Resistance of remaining resistor RExtRem between capacitor n and port_b, exterior wall with earth contact"
       annotation(Dialog(group="Exterior walls"));
    parameter Modelica.SIunits.HeatCapacity CExt[nExt](
      each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b, exterior wall with earth contact"
      annotation(Dialog(group="Exterior walls"));
    parameter Modelica.SIunits.Area AExt "Area of exterior pool wall with earth contact" annotation(Dialog(group="Exterior walls"));
    parameter Modelica.SIunits.CoefficientOfHeatTransfer hConExt "Coefficient of heat transfer between the water and exterior pool walls" annotation(Dialog(group="Exterior walls"));

    // Interior Pool Walls - vertical and horizontal combined
    parameter Integer nInt(min=1) "Number of RC elements of interior walls" annotation(Dialog(group="Interior walls"));
    parameter Modelica.SIunits.ThermalResistance RInt[nInt](
      each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b, interior wall" annotation(Dialog(group="Interior walls"));
    parameter Modelica.SIunits.HeatCapacity CInt[nInt](
      each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b, interior wall" annotation(Dialog(group="Interior walls"));
    parameter Modelica.SIunits.Area AInt "Area of interior pool walls " annotation(Dialog(group="Interior walls"));
    parameter Modelica.SIunits.CoefficientOfHeatTransfer hConInt "Coefficient of heat transfer between the water and interior pool walls" annotation(Dialog(group="Interior walls"));

    // Pool Floor with earth contact
    parameter Integer nFloor(min = 1) "Number of RC-elements of pool floor with earth contact"
      annotation(Dialog(group="Pool floor"));
    parameter Modelica.SIunits.ThermalResistance RFloor [nFloor](
      each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b, pool floor with earth contact" annotation(Dialog(group="Pool floor"));

    parameter Modelica.SIunits.ThermalResistance RFloorRem(
      min=Modelica.Constants.small) "Resistance of remaining resistor RFloorRem between capacitor n and port_b, pool floor with earth contact"
       annotation(Dialog(group="Pool floor"));
    parameter Modelica.SIunits.HeatCapacity CFloor[nFloor](
      each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b, pool floor, pool floor with earth contact"
      annotation(Dialog(group="Pool floor"));
    parameter Modelica.SIunits.Area AFloor "Area of pool floor with earth contact" annotation(Dialog(group="Pool floor"));
    parameter Modelica.SIunits.CoefficientOfHeatTransfer hConFloor "Coefficient of heat transfer between the water and pool floor" annotation(Dialog(group="Pool floor"));

    Modelica.Thermal.HeatTransfer.Components.Convection convExt if AExt > 0
      "Convection between Water and pool wall"
      annotation (Placement(transformation(extent={{-26,24},{-42,40}})));
    ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWall extWalRC(
      final RExt=RExt,
      final RExtRem=RExtRem,
      final CExt=CExt,
      final n=nExt,
      T_start=T_start) if AExt > 0 "Pool walls with earth contact"
      annotation (Placement(transformation(extent={{0,26},{18,42}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature1 if AFloor > 0 or AExt > 0
      "Generate Heat Flow for earth contact"
                             annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={48,18})));

    Modelica.Blocks.Sources.Constant const_hConExt(k=hConExt) if AExt > 0
      "heat transfer coefficient between vertikal pool wall and water"
      annotation (Placement(transformation(extent={{-8,40},{-24,56}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_a if AExt > 0
       or AInt > 0 or AFloor > 0
      "Inlet for heattransfer"
      annotation (Placement(transformation(extent={{-110,-8},{-90,12}})));
    Modelica.Blocks.Interfaces.RealInput TSoil if AFloor > 0 or AExt > 0
                                               "Temperature of Soil"
      annotation (Placement(transformation(extent={{126,-2},{86,38}}),
          iconTransformation(extent={{126,16},{86,56}})));
    ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWall floorRC(
      final RExt=RFloor,
      final RExtRem=RFloorRem,
      final CExt=CFloor,
      final n=nFloor,
      T_start=T_start) if AFloor > 0 "Floor of Swimming Poolwith earth contact"
      annotation (Placement(transformation(extent={{0,-16},{18,0}})));
    ThermalZones.ReducedOrder.RC.BaseClasses.InteriorWall intWalRC(
      final n=nInt,
      final RInt=RInt,
      final CInt=CInt,
      final T_start=T_start) if AInt > 0
      "RC element representing interior pool walls, horizontal and vertical"
      annotation (Placement(transformation(extent={{0,-58},{16,-40}})));
    Modelica.Thermal.HeatTransfer.Components.Convection convFloor if AFloor > 0
      "Convection between Water and pool floor"
      annotation (Placement(transformation(extent={{-24,-20},{-42,-2}})));
    Modelica.Blocks.Sources.Constant const_hConFloor(k=hConFloor) if AFloor > 0
      "Heat transfer coefficient between pool floor and water"
      annotation (Placement(transformation(extent={{-4,0},{-20,16}})));
    Modelica.Thermal.HeatTransfer.Components.Convection convInt if AInt > 0
      "Convection between water and interior pool walls"
      annotation (Placement(transformation(extent={{-24,-58},{-42,-40}})));
    Modelica.Blocks.Sources.Constant const_hConInt(k=hConInt) if AInt > 0
      "Heat transfer coefficient between interior pool wall and water"
      annotation (Placement(transformation(extent={{-6,-44},{-22,-28}})));
  equation
    connect(extWalRC.port_a, convExt.solid)
      annotation (Line(points={{0,33.2727},{0,32},{-26,32}},   color={191,0,0}));
    connect(extWalRC.port_b,prescribedTemperature1. port) annotation (Line(points={{18,
            33.2727},{38,33.2727},{38,18},{42,18}},
                                                color={191,0,0}));
    connect(const_hConExt.y, convExt.Gc)
      annotation (Line(points={{-24.8,48},{-34,48},{-34,40}}, color={0,0,127}));
    connect(convExt.fluid, heatport_a) annotation (Line(points={{-42,32},{-68,
            32},{-68,2},{-100,2}},
                               color={191,0,0}));
    connect(prescribedTemperature1.port, floorRC.port_b) annotation (Line(points={{42,18},
            {38,18},{38,-10},{18,-10},{18,-8.72727}},                       color=
           {191,0,0}));
    connect(prescribedTemperature1.T, TSoil) annotation (Line(points={{55.2,18},
            {106,18}},            color={0,0,127}));
    connect(const_hConFloor.y, convFloor.Gc)
      annotation (Line(points={{-20.8,8},{-33,8},{-33,-2}},  color={0,0,127}));
    connect(convFloor.solid, floorRC.port_a) annotation (Line(points={{-24,-11},
            {-24,-8.72727},{0,-8.72727}},       color={191,0,0}));
    connect(const_hConInt.y, convInt.Gc) annotation (Line(points={{-22.8,-36},{
            -32,-36},{-32,-40},{-33,-40}},
                             color={0,0,127}));
    connect(convInt.solid, intWalRC.port_a) annotation (Line(points={{-24,-49},
            {-23,-49},{-23,-49.8182},{0,-49.8182}},
                                                color={191,0,0}));
    connect(convInt.fluid, heatport_a) annotation (Line(points={{-42,-49},{-68,
            -49},{-68,2},{-100,2}},
                               color={191,0,0}));
    connect(convFloor.fluid, heatport_a) annotation (Line(points={{-42,-11},{
            -68,-11},{-68,2},{-100,2}},
                               color={191,0,0}));
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
          coordinateSystem(preserveAspectRatio=false)));
  end HeatTransferConduction;

  model PumpAndPressureDrop
    "Model for a pump and a corresponding pressure drop to avoid pressure build up in the system"
    extends AixLib.Fluid.Interfaces.PartialTwoPort
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));

    parameter Modelica.SIunits.Pressure pumpHead( min=0.001) "Nominal pressure difference pump and resistance";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min= 0.0001);
    parameter Modelica.SIunits.Pressure p_start;
    parameter Modelica.SIunits.Temperature T_water;

    Modelica.Blocks.Interfaces.RealOutput P( final quantity = "Power", final unit= "W")
      "Output eletric energy needed for pump operation"
      annotation (Placement(transformation(extent={{96,36},{116,56}})));
    Movers.FlowControlled_m_flow CirculationPump(
      redeclare package Medium = Medium,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      p_start=p_start,
      T_start=T_water,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal,
      redeclare Movers.Data.Generic per(
        pressure(V_flow={0,m_flow_nominal/1000,m_flow_nominal/1000/0.7}, dp={
              pumpHead/0.7,pumpHead,0}),
        hydraulicEfficiency(V_flow={0,m_flow_nominal/1000,m_flow_nominal/1000/
              0.7}, eta={0.70,0.8,0.70}),
        motorEfficiency(V_flow={0,m_flow_nominal/1000,m_flow_nominal/1000/0.7},
            eta={0.9,0.9,0.9})),
      inputType=AixLib.Fluid.Types.InputType.Continuous,
      addPowerToMedium=false,
      nominalValuesDefineDefaultPressureCurve=true,
      use_inputFilter=false,
      dp_nominal=pumpHead,
      m_flow_start=m_flow_nominal)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    FixedResistances.PressureDrop res(
      redeclare package  Medium = Medium,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal,
      show_T=false,
      dp_nominal= pumpHead)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Blocks.Interfaces.RealInput setMFlow annotation (Placement(
          transformation(extent={{-128,44},{-88,84}}), iconTransformation(
            extent={{-112,60},{-88,84}})));
    Sensors.MassFlowRate senMasFlo( redeclare package  Medium = Medium)
      annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
    Controls.Continuous.LimPID PI(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=5,
      yMax=m_flow_nominal/0.9,
      yMin=0) annotation (Placement(transformation(extent={{-56,52},{-36,72}})));
  equation
    connect(port_a, CirculationPump.port_a) annotation (Line(points={{-100,0},{-88,
            0},{-88,-2},{-60,-2},{-60,0}}, color={0,127,255}));
    connect(res.port_b, port_b) annotation (Line(points={{40,0},{62,0},{62,-4},{100,
            -4},{100,0}}, color={0,127,255}));
    connect(CirculationPump.P, P) annotation (Line(points={{-39,9},{-28,9},{-28,46},
            {106,46}}, color={0,0,127}));
    connect(PI.u_m, senMasFlo.m_flow) annotation (Line(points={{-46,50},{-46,38},
            {2,38},{2,11}}, color={0,0,127}));
    connect(PI.u_s, setMFlow) annotation (Line(points={{-58,62},{-84,62},{-84,
            64},{-108,64}}, color={0,0,127}));
    connect(PI.y, CirculationPump.m_flow_in) annotation (Line(points={{-35,62},
            {-35,41},{-50,41},{-50,12}}, color={0,0,127}));
    connect(CirculationPump.port_b, senMasFlo.port_a)
      annotation (Line(points={{-40,0},{-8,0}}, color={0,127,255}));
    connect(senMasFlo.port_b, res.port_a)
      annotation (Line(points={{12,0},{20,0}}, color={0,127,255}));
    annotation (Icon(graphics={Ellipse(
            extent={{-60,60},{60,-60}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Line(points={{0,60},{60,0},{0,-60}},
              color={0,0,0})}));
  end PumpAndPressureDrop;

  model toH_fg "Convert from Kelvin to kJ/kg"

      parameter Integer nu( min=0)=0  "Number of input connections"
      annotation (Dialog(connectorSizing=true), HideResult=true);
  Modelica.Blocks.Interfaces.RealInput       u[nu]
    annotation (Placement(transformation(extent={{-122,-22},{-82,18}})));
    Modelica.Blocks.Interfaces.RealOutput       y[nu]( final unit="J/kg")
    annotation (Placement(transformation(extent={{82,-22},{122,18}})));
  equation
    y = AixLib.Media.Air.enthalpyOfCondensingGas(u);

  annotation (Icon(graphics={
        Line(
          points={{-72,0},{78,0}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{78,0},{58,12},{78,0},{60,-12}},
          color={238,46,47},
          thickness=0.5),
        Rectangle(
          extent={{-100,100},{98,-100}},
          lineColor={0,0,0},
          lineThickness=0.5)}));
  end toH_fg;

  block DivisionMI2MO "Division of multiple values"
   extends Modelica.Blocks.Interfaces.MI2MO;

  equation
    for i in 1:n loop
      y[i]= u1[i]/u2[i];
    end for;

     annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                  Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          lineColor={0,0,255}),
          Line(points={{50,0},{100,0}}, color={0,0,127}),
          Line(points={{-30,0},{30,0}}),
          Ellipse(fillPattern=FillPattern.Solid, extent={{-5,20},{5,30}}),
          Ellipse(fillPattern=FillPattern.Solid, extent={{-5,-30},{5,-20}}),
          Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}}),
          Line(points={{-100,60},{-66,60},{-40,30}}, color={0,0,127}),
          Line(points={{-100,-60},{0,-60},{0,-50}}, color={0,0,127}),
          Text(
            extent={{-60,94},{90,54}},
            lineColor={128,128,128},
            textString="u1 / u2")}),                                Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DivisionMI2MO;

  model waveMachine "Simple Model to calculate energy demands of a wave machine"

    parameter Modelica.SIunits.Length h_wave "Height of generated wave";
    parameter Modelica.SIunits.Length w_wave "Width of wave machine outlet/of generated wave";

    Modelica.Blocks.Math.RealToBoolean useWavePool(threshold=1)
      "If input = 1, then true, else no waves generated"
      annotation (Placement(transformation(extent={{-10,26},{8,44}})));
    Modelica.Blocks.Tables.CombiTable1D tablePWave(
      y(unit="W/m"),
      tableOnFile=false,
      table=[0,0; 0.7,3500; 0.9,6000; 1.3,12000],
      extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
      "Estimate consumed power per width to generate wave of a certain heigth; "
      annotation (Placement(transformation(extent={{-42,-12},{-16,14}})));
    Modelica.Blocks.Sources.RealExpression get_h_wave(y=h_wave)
      "Get height of generated wave"
      annotation (Placement(transformation(extent={{-84,-8},{-64,12}})));
    Modelica.Blocks.Interfaces.RealInput wavePool "Input profil of wave machine"
      annotation (Placement(transformation(extent={{-128,20},{-88,60}})));
    Modelica.Blocks.Interfaces.BooleanOutput use_wavePool
      "Is the wave pool in use?"
      annotation (Placement(transformation(extent={{96,30},{116,50}})));
    Modelica.Blocks.Interfaces.RealOutput PWaveMachine( final unit="W", final quantity="Power")
      "Power consumption of wave machine"
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
    Modelica.Blocks.Math.Gain multiply(k=w_wave) "Multply by width of wave"
      annotation (Placement(transformation(extent={{0,-8},{20,12}})));
    Modelica.Blocks.Sources.Constant const(k=0) "no output if wave machine is off"
      annotation (Placement(transformation(extent={{6,-48},{26,-28}})));
    Modelica.Blocks.Logical.Switch switchWaveMachine
      annotation (Placement(transformation(extent={{66,8},{86,28}})));
  equation
    connect(get_h_wave.y, tablePWave.u[1]) annotation (Line(points={{-63,2},{-50,
            2},{-50,1},{-44.6,1}}, color={0,0,127}));
    connect(multiply.u, tablePWave.y[1]) annotation (Line(points={{-2,2},{-12,2},
            {-12,1},{-14.7,1}}, color={0,0,127}));
    connect(wavePool, useWavePool.u) annotation (Line(points={{-108,40},{-60,40},{-60,
            35},{-11.8,35}}, color={0,0,127}));
    connect(useWavePool.y, use_wavePool) annotation (Line(points={{8.9,35},{54.45,35},
            {54.45,40},{106,40}}, color={255,0,255}));
    connect(switchWaveMachine.y, PWaveMachine) annotation (Line(points={{87,18},{87,
            10},{88,10},{88,0},{106,0}}, color={0,0,127}));
    connect(useWavePool.y, switchWaveMachine.u2) annotation (Line(points={{8.9,35},
            {35.45,35},{35.45,18},{64,18}}, color={255,0,255}));
    connect(multiply.y, switchWaveMachine.u1)
      annotation (Line(points={{21,2},{42,2},{42,26},{64,26}}, color={0,0,127}));
    connect(const.y, switchWaveMachine.u3) annotation (Line(points={{27,-38},{52,-38},
            {52,10},{64,10}}, color={0,0,127}));
    connect(PWaveMachine, PWaveMachine) annotation (Line(
        points={{106,0},{101,0},{101,0},{106,0}},
        color={0,0,127},
        smooth=Smooth.Bezier));
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
          coordinateSystem(preserveAspectRatio=false)));
  end waveMachine;

  model AHUcontrol "Simple on/off controller for AHU"


    parameter Real phi_sup_min= 0.4
                                   "Desired minimal relative humidity of ventilation supply air";
    parameter Real phi_sup_max= 0.64
                                    "Desired maximal relative humidity of ventilation supply air";
    parameter Modelica.SIunits.Temperature T_desired "Desired Air Temperature in K";
    parameter Real phi_set= 0.54 "Desired relative humidy Air";

    parameter Real y_Max= 1 "Max. factor of set Ventilation Flow Rate";

    Modelica.Blocks.Interfaces.RealOutput AHUProfile[4]
      annotation (Placement(transformation(extent={{94,-10},{114,10}})));
    Modelica.Blocks.Interfaces.RealInput X_w "Abs humidity "
      annotation (Placement(transformation(extent={{-122,-4},{-82,36}})));
    Controls.Continuous.LimPID conPID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.5,
      Ti=60,
      yMax=0,
      yMin=-y_Max) annotation (Placement(transformation(extent={{-50,18},{-30,38}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{8,20},{28,40}})));
    Modelica.Blocks.Sources.Constant setPhi(k=phi_set)
      annotation (Placement(transformation(extent={{-78,50},{-58,70}})));
    Modelica.Blocks.Sources.Constant minPhi(k=phi_sup_min)
      annotation (Placement(transformation(extent={{-6,-12},{6,0}})));
    Modelica.Blocks.Sources.Constant maxPhi(k=phi_sup_max)
      annotation (Placement(transformation(extent={{-6,-32},{6,-20}})));
    Modelica.Blocks.Sources.Constant desiredT(k=T_desired)
      annotation (Placement(transformation(extent={{-4,-52},{6,-42}})));
    Modelica.Blocks.Interfaces.RealInput T_Air "Air Temperature"
      annotation (Placement(transformation(extent={{-122,-36},{-82,4}})));
    ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
      annotation (Placement(transformation(extent={{-62,-22},{-42,-2}})));
  equation
    connect(conPID.y, gain.u)
      annotation (Line(points={{-29,28},{4,28},{4,30},{6,30}},
                                                  color={0,0,127}));
    connect(conPID.u_s, setPhi.y) annotation (Line(points={{-52,28},{-54,28},{-54,
            60},{-57,60}}, color={0,0,127}));
    connect(minPhi.y, AHUProfile[2]) annotation (Line(points={{6.6,-6},{54,-6},{54,
            -2.5},{104,-2.5}}, color={0,0,127}));
    connect(maxPhi.y, AHUProfile[3]) annotation (Line(points={{6.6,-26},{56,-26},{
            56,2.5},{104,2.5}}, color={0,0,127}));
    connect(desiredT.y, AHUProfile[1]) annotation (Line(points={{6.5,-47},{54,-47},
            {54,-7.5},{104,-7.5}}, color={0,0,127}));
    connect(X_w, absToRelHum.absHum) annotation (Line(points={{-102,16},{-83,16},{
            -83,-6.8},{-64,-6.8}}, color={0,0,127}));
    connect(T_Air, absToRelHum.TDryBul) annotation (Line(points={{-102,-16},{-84,-16},
            {-84,-17.6},{-64,-17.6}}, color={0,0,127}));
    connect(absToRelHum.relHum, conPID.u_m)
      annotation (Line(points={{-40,-12},{-40,16}}, color={0,0,127}));
    connect(gain.y, AHUProfile[4]) annotation (Line(points={{29,30},{62,30},{62,
            7.5},{104,7.5}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AHUcontrol;

  model idealHeatExchanger "Basic Heatexchanger"
    extends AixLib.Fluid.Interfaces.TwoPortHeatMassExchanger(dp_nominal=0,
      redeclare final AixLib.Fluid.MixingVolumes.MixingVolume vol(
      final prescribedHeatFlowRate=true));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeatFlow
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-20,38})));
    Modelica.Blocks.Interfaces.RealInput setQFlow
      "Set Heatflow added to Medium" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-108,40}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,88})));
  equation
    connect(setQFlow, preHeatFlow.Q_flow) annotation (Line(points={{-108,40},{
            -104,40},{-104,38},{-30,38}}, color={0,0,127}));
    connect(preHeatFlow.port, vol.heatPort)
      annotation (Line(points={{-10,38},{-10,-10},{-9,-10}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end idealHeatExchanger;
end BaseClasses;
