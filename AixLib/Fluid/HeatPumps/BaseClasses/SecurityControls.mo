within AixLib.Fluid.HeatPumps.BaseClasses;
package SecurityControls "Package including blocks for security controls"
  block SecurityControl "Block including all security levels"
    extends BaseClasses.partialSecurityControl;
    parameter Modelica.SIunits.Temp_K T_eva_min "Minimum source inlet temperature"
      annotation (Dialog(group="Operational Envelope"));
    parameter Modelica.SIunits.Temp_K T_eva_max "Maximum source inlet temperature"
      annotation (Dialog(group="Operational Envelope"));
    parameter Modelica.SIunits.Temp_K T_con_min "Minimum sink inlet temperature"
      annotation (Dialog(group="Operational Envelope"));
    parameter Modelica.SIunits.Temp_K T_con_max "Maximum sink inlet temperature"
      annotation (Dialog(group="Operational Envelope"));
    OperationalEnvelope operationalEnvelope
      annotation (Placement(transformation(extent={{-18,-16},{18,18}})));
    TimerControl timerControl
      annotation (Placement(transformation(extent={{-84,-18},{-48,16}})));
    Modelica.Blocks.Sources.BooleanConstant ConTru(final k=true)
      "Always true as the security is delt with inside the other blocks"
      annotation (Placement(transformation(extent={{58,-6},{70,6}})));
  equation
    connect(ConTru.y, SwiErr.u2)
      annotation (Line(points={{70.6,0},{84,0}}, color={255,0,255}));
    connect(timerControl.n_out, operationalEnvelope.n_set) annotation (Line(
          points={{-46.5,-1},{-42,-1},{-42,8},{-20.25,8},{-20.25,7.29}}, color=
            {0,0,127}));
    connect(operationalEnvelope.HeaPumSen, HeaPumSen) annotation (Line(
        points={{-19.5,-4.1},{-28,-4.1},{-28,-4},{-36,-4},{-36,-30},{-130,-30}},

        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(timerControl.HeaPumSen, HeaPumSen) annotation (Line(
        points={{-85.5,-6.1},{-107.75,-6.1},{-107.75,-30},{-130,-30}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(n_set, timerControl.n_set) annotation (Line(points={{-135,37},{
            -110.5,37},{-110.5,5.29},{-86.25,5.29}}, color={0,0,127}));
    connect(operationalEnvelope.n_out, SwiErr.u1) annotation (Line(points={{
            19.5,1},{54,1},{54,12},{72,12},{72,8},{84,8}}, color={0,0,127}));
  end SecurityControl;

  block OperationalEnvelope
    "Block which computes an error if the current values are outside of the given operatinal envelope"
    extends BaseClasses.partialSecurityControl;
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-30,84},{-14,100}})));
    Modelica.Blocks.MathBoolean.Nand nand1(nu=4)
      annotation (Placement(transformation(extent={{10,-2},{30,18}})));
    Modelica.Blocks.Logical.Less less1
      annotation (Placement(transformation(extent={{-28,46},{-12,62}})));
    Modelica.Blocks.Logical.Less less2
      annotation (Placement(transformation(extent={{-24,-52},{-8,-36}})));
    Modelica.Blocks.Logical.Less less3
      annotation (Placement(transformation(extent={{-22,-84},{-6,-68}})));
    BaseClasses.NonLinearBoundary lowerBoundary(
      x_offset_max,
      XOffsetMax=lowerXOffsetMax,
      XOffsetMin=lowerXOffsetMin,
      YOffset=lowerYOffset)
      annotation (Placement(transformation(extent={{-70,-20},{-48,0}})));
    BaseClasses.NonLinearBoundary upperBoundary(
      XOffsetMax=upperXOffsetMax,
      XOffsetMin=upperXOffsetMin,
      YOffset=upperYOffset)
      annotation (Placement(transformation(extent={{-76,-98},{-54,-78}})));
    Modelica.Blocks.Sources.Constant x_min(k=xMin)
                                           "Minimal value of x_Axis"
      annotation (Placement(transformation(extent={{-78,88},{-70,96}})));
    Modelica.Blocks.Sources.Constant x_max(k=xMax)
                                           "Maximal value of x-Axis"
      annotation (Placement(transformation(extent={{-84,44},{-76,52}})));
    Modelica.Blocks.Sources.Constant y_min(k=yMin)
                                           "Minimal value of y_Axis"
      annotation (Placement(transformation(extent={{-90,-42},{-82,-34}})));
    Modelica.Blocks.Sources.Constant y_max(k=yMax)
                                           "Maximal value of y-Axis"
      annotation (Placement(transformation(extent={{-92,-100},{-84,-92}})));
  equation
    connect(x_min.y,less. u1)
      annotation (Line(points={{-69.6,92},{-31.6,92}}, color={0,0,127}));
    connect(x_max.y,less1. u2) annotation (Line(points={{-75.6,48},{-56,48},{
            -56,47.6},{-29.6,47.6}},
                           color={0,0,127}));
    connect(less1.y,nand1. u[1]) annotation (Line(points={{-11.2,54},{-0.6,54},
            {-0.6,13.25},{10,13.25}},
                                color={255,0,255}));
    connect(less.y,nand1. u[2]) annotation (Line(points={{-13.2,92},{0,92},{0,
            9.75},{10,9.75}},
                        color={255,0,255}));
    connect(less2.y,nand1. u[3]) annotation (Line(points={{-7.2,-44},{0,-44},{0,
            6.25},{10,6.25}},
                        color={255,0,255}));
    connect(less3.y,nand1. u[4]) annotation (Line(points={{-5.2,-76},{0,-76},{0,
            2.75},{10,2.75}},
                        color={255,0,255}));
    connect(lowerBoundary.Ylimit,less2. u1) annotation (Line(points={{-47,-9.8},
            {-31.5,-9.8},{-31.5,-44},{-25.6,-44}}, color={0,0,127}));
    connect(upperBoundary.Ylimit,less3. u2) annotation (Line(points={{-53,-87.8},{
            -50.5,-87.8},{-50.5,-82.4},{-23.6,-82.4}}, color={0,0,127}));
    connect(x_max.y,lowerBoundary. x_max) annotation (Line(points={{-75.6,48},{
            -94,48},{-94,-4.8},{-69,-4.8}},
                                          color={0,0,127}));
    connect(x_min.y,lowerBoundary. x_min) annotation (Line(points={{-69.6,
            92},{-94,92},{-94,-2},{-69,-2}},
                                      color={0,0,127}));
    connect(x_max.y,upperBoundary. x_max) annotation (Line(points={{-75.6,48},{
            -94,48},{-94,-82.8},{-75,-82.8}},
                                          color={0,0,127}));
    connect(x_min.y,upperBoundary. x_min) annotation (Line(points={{-69.6,92},{-94,
            92},{-94,-80},{-75,-80}}, color={0,0,127}));
    connect(y_min.y,lowerBoundary. y_max) annotation (Line(points={{-81.6,
            -38},{-78,-38},{-78,-17.6},{-69,-17.6}},
                                           color={0,0,127}));
    connect(y_max.y,upperBoundary. y_max) annotation (Line(points={{-83.6,-96},{-80,
            -96},{-80,-95.6},{-75,-95.6}}, color={0,0,127}));
    connect(nand1.y, SwiErr.u2) annotation (Line(points={{31.5,8},{57.75,8},{
            57.75,0},{84,0}}, color={255,0,255}));
    connect(HeaPumSen.T_sink_out, less2.u2) annotation (Line(
        points={{-130,-30},{-118,-30},{-118,-50.4},{-25.6,-50.4}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(HeaPumSen.T_sink_out, less3.u1) annotation (Line(
        points={{-130,-30},{-118,-30},{-118,-50},{-70,-50},{-70,-76},{-23.6,-76}},

        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(HeaPumSen.T_source_in, upperBoundary.x) annotation (Line(
        points={{-130,-30},{-118,-30},{-118,-85.6},{-75,-85.6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(HeaPumSen.T_source_in, less.u2) annotation (Line(
        points={{-130,-30},{-118,-30},{-118,85.6},{-31.6,85.6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(HeaPumSen.T_source_in, less1.u1) annotation (Line(
        points={{-130,-30},{-118,-30},{-118,54},{-29.6,54}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(n_set, SwiErr.u1) annotation (Line(points={{-135,37},{72,37},{72,8},
            {84,8}}, color={0,0,127}));
  end OperationalEnvelope;

  block TimerControl
    "Controlls if the minimal runtime, stoptime and max. runs per hour are inside given boundaries"
    extends BaseClasses.partialSecurityControl;
    Modelica.Blocks.Sources.Clock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-110,80},{-94,96}})));
    Modelica.Blocks.Logical.Timer RunTim "counts the seconds the heat pump is running"
      annotation (Placement(transformation(extent={{-42,24},{-26,40}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual
      annotation (Placement(transformation(extent={{-2,8},{18,28}})));
    Modelica.Blocks.Logical.LessEqual lessEqual
      annotation (Placement(transformation(extent={{-24,-84},{-8,-68}})));
    Modelica.Blocks.Logical.Greater greater
      annotation (Placement(transformation(extent={{-94,56},{-82,70}})));
    Modelica.Blocks.Logical.Timer LocTim
      "counts the seconds the heat pump is locled still"
      annotation (Placement(transformation(extent={{-42,-26},{-26,-10}})));
    Modelica.Blocks.Sources.Constant inputMinRuntime(final k=minRunTime)
      "Mimimum runtime of heat pump"
      annotation (Placement(transformation(extent={{-42,2},{-26,18}})));
    parameter Modelica.SIunits.Time minRunTime "Mimimum runtime of heat pump";
    Modelica.Blocks.Sources.Constant inputLocTime(final k=minLocTime)
      "Mimimum lock time of heat pump"
      annotation (Placement(transformation(extent={{-42,-48},{-26,-32}})));
    parameter Modelica.SIunits.Time minLocTime "Minimum lock time of heat pump";
    Modelica.Blocks.Logical.GreaterEqual greaterEqual1
      annotation (Placement(transformation(extent={{-12,-34},{4,-18}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{30,-60},{46,-44}})));
    Modelica.Blocks.Sources.Constant inputRunPerHou(final k=maxRunPer_h)
      "maximal number of on/off cycles in one hour"
      annotation (Placement(transformation(extent={{-54,-94},{-38,-78}})));
    parameter Real maxRunPer_h "Maximal number of on/off cycles in one hour";
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{52,12},{68,28}})));
    Modelica.Blocks.Logical.Edge edge1
      annotation (Placement(transformation(extent={{-68,46},{-58,56}})));
    Modelica.Blocks.Logical.FallingEdge fallingEdge
      annotation (Placement(transformation(extent={{-68,66},{-58,76}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-66,-32},{-54,-20}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-100,-36},{-88,-22}})));
  equation
    connect(conZer.y, greater.u2) annotation (Line(points={{70.6,-18},{-106,-18},
            {-106,57.4},{-95.2,57.4}},
                           color={0,0,127}));
    connect(greater.u1, n_set) annotation (Line(points={{-95.2,63},{-118,63},{
            -118,37},{-135,37}}, color={0,0,127}));
    connect(n_set, SwiErr.u1) annotation (Line(points={{-135,37},{-120,37},{
            -120,38},{-106,38},{-106,-18},{60,-18},{60,8},{84,8}}, color={0,0,
            127}));
    connect(inputLocTime.y, greaterEqual1.u2) annotation (Line(points={{-25.2,
            -40},{-18,-40},{-18,-32.4},{-13.6,-32.4}}, color={0,0,127}));
    connect(LocTim.y, greaterEqual1.u1) annotation (Line(points={{-25.2,-18},{
            -18,-18},{-18,-26},{-13.6,-26}}, color={0,0,127}));
    connect(inputRunPerHou.y, lessEqual.u2) annotation (Line(points={{-37.2,-86},
            {-30,-86},{-30,-82.4},{-25.6,-82.4}}, color={0,0,127}));
    connect(lessEqual.y, and1.u2) annotation (Line(points={{-7.2,-76},{18,-76},
            {18,-58.4},{28.4,-58.4}}, color={255,0,255}));
    connect(greaterEqual1.y, and1.u1) annotation (Line(points={{4.8,-26},{16,
            -26},{16,-52},{28.4,-52}}, color={255,0,255}));
    connect(greaterEqual.u2, inputMinRuntime.y)
      annotation (Line(points={{-4,10},{-25.2,10}}, color={0,0,127}));
    connect(RunTim.y, greaterEqual.u1) annotation (Line(points={{-25.2,32},{-16,
            32},{-16,18},{-4,18}}, color={0,0,127}));
    connect(and1.y, or1.u2) annotation (Line(points={{46.8,-52},{45.45,-52},{
            45.45,13.6},{50.4,13.6}}, color={255,0,255}));
    connect(or1.u1, greaterEqual.y) annotation (Line(points={{50.4,20},{46.1,20},
            {46.1,18},{19,18}}, color={255,0,255}));
    connect(or1.y, SwiErr.u2) annotation (Line(points={{68.8,20},{80,20},{80,0},
            {84,0}}, color={255,0,255}));
    connect(greater.y, edge1.u) annotation (Line(points={{-81.4,63},{-81.4,56.5},
            {-69,56.5},{-69,51}}, color={255,0,255}));
    connect(not1.y, LocTim.u) annotation (Line(points={{-53.4,-26},{-53.4,-25.5},
            {-43.6,-25.5},{-43.6,-18}}, color={255,0,255}));
    connect(greater.y, fallingEdge.u) annotation (Line(points={{-81.4,63},{
            -81.4,66},{-69,66},{-69,71}}, color={255,0,255}));
    connect(conZer.y, greater1.u2) annotation (Line(points={{70.6,-18},{-78,-18},
            {-78,-34.6},{-101.2,-34.6}}, color={0,0,127}));
    connect(greater1.y, not1.u) annotation (Line(points={{-87.4,-29},{-87.4,-26},
            {-67.2,-26}}, color={255,0,255}));
    connect(HeaPumSen.n, greater1.u1) annotation (Line(
        points={{-130,-30},{-116,-30},{-116,-29},{-101.2,-29}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(RunTim.u, greater1.y) annotation (Line(points={{-43.6,32},{-78,32},
            {-78,-29},{-87.4,-29}}, color={255,0,255}));
  end TimerControl;

  package BaseClasses
    "Package containing blocks used inside the SecurityControls package"
    block NonLinearBoundary
      Modelica.Blocks.Interfaces.RealOutput Ylimit
        annotation (Placement(transformation(extent={{100,-8},{120,12}})));
      Modelica.Blocks.Interfaces.RealInput y_max
        annotation (Placement(transformation(extent={{-120,-86},{-100,-66}})));
      Modelica.Blocks.Interfaces.RealInput x_min
        annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
      Modelica.Blocks.Interfaces.RealInput x "Current value of x-Axis"
        annotation (Placement(transformation(extent={{-120,14},{-100,34}})));
      Modelica.Blocks.Interfaces.RealInput x_max
        annotation (Placement(transformation(extent={{-120,42},{-100,62}})));
      Modelica.Blocks.Math.Division division_max
        annotation (Placement(transformation(extent={{-38,-16},{-26,-4}})));
      Modelica.Blocks.Math.Division division_min
        annotation (Placement(transformation(extent={{-38,-38},{-26,-26}})));
      Modelica.Blocks.Math.Product product_max
        annotation (Placement(transformation(extent={{14,-10},{26,2}})));
      Modelica.Blocks.Math.Product product_min
        annotation (Placement(transformation(extent={{14,-30},{26,-18}})));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{-52,16},{-40,28}})));
      Modelica.Blocks.Logical.Less min_boundary
        annotation (Placement(transformation(extent={{-8,82},{4,94}})));
      Modelica.Blocks.Math.Add3 add3_1(k2=-1, k3=-1)
        annotation (Placement(transformation(extent={{-52,38},{-38,52}})));
      Modelica.Blocks.Math.Add add_max(k1=-1)
        annotation (Placement(transformation(extent={{46,16},{58,4}})));
      Modelica.Blocks.Math.Add add_min(k1=-1)
        annotation (Placement(transformation(extent={{46,-8},{58,-20}})));
      Modelica.Blocks.Math.Add add_min1
        annotation (Placement(transformation(extent={{4,-54},{16,-66}})));
      Modelica.Blocks.Logical.Less max_boundary
        annotation (Placement(transformation(extent={{-8,58},{4,70}})));
      Modelica.Blocks.Logical.Switch second_switch
        annotation (Placement(transformation(extent={{66,-8},{78,4}})));
      Modelica.Blocks.Logical.Switch first_switch
        annotation (Placement(transformation(extent={{48,-66},{62,-52}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-54,74},{-44,84}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-54,56},{-44,66}})));
      Modelica.Blocks.Logical.Nand nand
        annotation (Placement(transformation(extent={{18,76},{32,90}})));

      parameter Real XOffsetMax "XOffsetMax";
      parameter Real XOffsetMin "XOffsetMin";
      parameter Real YOffset "YOffset";
      Modelica.Blocks.Sources.Constant x_offset_min(k=XOffsetMin)
        "Offset of x-min value. Has to be positive"
        annotation (Placement(transformation(extent={{-100,-22},{-92,-14}})));
      Modelica.Blocks.Sources.Constant y_offset(k=YOffset)
        "Offset of y-max value. Choose a negative number to generate a lower boundarie"
        annotation (Placement(transformation(extent={{-100,-44},{-92,-36}})));
      Modelica.Blocks.Sources.Constant x_offset_max(k=XOffsetMax)
        "Offset of x-max value. Has to be negative"
        annotation (Placement(transformation(extent={{-100,-2},{-92,6}})));
    equation
      connect(y_offset.y, division_min.u1) annotation (Line(points={{-91.6,-40},{
              -64,-40},{-64,-28.4},{-39.2,-28.4}}, color={0,0,127}));
      connect(x_offset_min.y, division_min.u2) annotation (Line(points={{-91.6,
              -18},{-64,-18},{-64,-35.6},{-39.2,-35.6}}, color={0,0,127}));
      connect(x_offset_max.y, division_max.u2) annotation (Line(points={{-91.6,2},
              {-64,2},{-64,-13.6},{-39.2,-13.6}}, color={0,0,127}));
      connect(y_offset.y, division_max.u1) annotation (Line(points={{-91.6,-40},{
              -64,-40},{-64,-6.4},{-39.2,-6.4}}, color={0,0,127}));
      connect(x, add.u2) annotation (Line(points={{-110,24},{-82,24},{-82,18.4},{
              -53.2,18.4}}, color={0,0,127}));
      connect(x_min, add.u1) annotation (Line(points={{-110,80},{-82,80},{-82,
              25.6},{-53.2,25.6}}, color={0,0,127}));
      connect(add.y, product_min.u1) annotation (Line(points={{-39.4,22},{-14,22},
              {-14,-20.4},{12.8,-20.4}}, color={0,0,127}));
      connect(division_min.y, product_min.u2) annotation (Line(points={{-25.4,-32},
              {-6,-32},{-6,-27.6},{12.8,-27.6}}, color={0,0,127}));
      connect(division_max.y, product_max.u2) annotation (Line(points={{-25.4,-10},
              {-6,-10},{-6,-7.6},{12.8,-7.6}}, color={0,0,127}));
      connect(x, add3_1.u1) annotation (Line(points={{-110,24},{-82,24},{-82,50.6},
              {-53.4,50.6}}, color={0,0,127}));
      connect(x_max, add3_1.u2) annotation (Line(points={{-110,52},{-82,52},{-82,
              45},{-53.4,45}}, color={0,0,127}));
      connect(x_offset_max.y, add3_1.u3) annotation (Line(points={{-91.6,2},{-82,
              2},{-82,40},{-54,40},{-54,39.4},{-53.4,39.4}}, color={0,0,127}));
      connect(add3_1.y, product_max.u1) annotation (Line(points={{-37.3,45},{
              -12.65,45},{-12.65,-0.4},{12.8,-0.4}}, color={0,0,127}));
      connect(product_max.y, add_max.u1) annotation (Line(points={{26.6,-4},{36,
              -4},{36,6.4},{44.8,6.4}}, color={0,0,127}));
      connect(y_max, add_max.u2) annotation (Line(points={{-110,-76},{36,-76},{36,
              13.6},{44.8,13.6}}, color={0,0,127}));
      connect(product_min.y, add_min.u1) annotation (Line(points={{26.6,-24},{36,
              -24},{36,-17.6},{44.8,-17.6}}, color={0,0,127}));
      connect(y_offset.y, add_min1.u2) annotation (Line(points={{-91.6,-40},{-24,
              -40},{-24,-56.4},{2.8,-56.4}}, color={0,0,127}));
      connect(y_max, add_min1.u1) annotation (Line(points={{-110,-76},{-24,-76},{
              -24,-64},{-10,-64},{-10,-63.6},{2.8,-63.6}}, color={0,0,127}));
      connect(add_min1.y, add_min.u2) annotation (Line(points={{16.6,-60},{36,-60},
              {36,-10.4},{44.8,-10.4}}, color={0,0,127}));
      connect(x, min_boundary.u1) annotation (Line(points={{-110,24},{-82,24},{
              -82,88},{-9.2,88}}, color={0,0,127}));
      connect(x_min, add1.u1) annotation (Line(points={{-110,80},{-84,80},{-84,82},
              {-55,82}}, color={0,0,127}));
      connect(add1.y, min_boundary.u2) annotation (Line(points={{-43.5,79},{-26,
              79},{-26,83.2},{-9.2,83.2}}, color={0,0,127}));
      connect(x_offset_min.y, add1.u2) annotation (Line(points={{-91.6,-18},{-82,
              -18},{-82,76},{-55,76}}, color={0,0,127}));
      connect(x_max, add2.u1) annotation (Line(points={{-110,52},{-82,52},{-82,64},
              {-55,64}}, color={0,0,127}));
      connect(x_offset_max.y, add2.u2) annotation (Line(points={{-91.6,2},{-82,2},
              {-82,58},{-55,58}}, color={0,0,127}));
      connect(add2.y, max_boundary.u2) annotation (Line(points={{-43.5,61},{
              -26.75,61},{-26.75,59.2},{-9.2,59.2}}, color={0,0,127}));
      connect(x, max_boundary.u1) annotation (Line(points={{-110,24},{-82,24},{
              -82,64},{-9.2,64}}, color={0,0,127}));
      connect(first_switch.u1, y_max) annotation (Line(points={{46.6,-53.4},{44,
              -53.4},{44,-54},{36,-54},{36,-76},{-110,-76}}, color={0,0,127}));
      connect(min_boundary.y, nand.u1) annotation (Line(points={{4.6,88},{16,88},
              {16,83},{16.6,83}}, color={255,0,255}));
      connect(max_boundary.y, nand.u2) annotation (Line(points={{4.6,64},{16,64},
              {16,77.4},{16.6,77.4}}, color={255,0,255}));
      connect(nand.y, first_switch.u2) annotation (Line(points={{32.7,83},{32.7,
              -40},{46.6,-40},{46.6,-59}}, color={255,0,255}));
      connect(second_switch.y, first_switch.u3) annotation (Line(points={{78.6,-2},
              {84,-2},{84,-64.6},{46.6,-64.6}}, color={0,0,127}));
      connect(first_switch.y, Ylimit) annotation (Line(points={{62.7,-59},{62.7,
              -29.5},{110,-29.5},{110,2}}, color={0,0,127}));
      connect(add_max.y, second_switch.u1) annotation (Line(points={{58.6,10},{62,
              10},{62,2.8},{64.8,2.8}}, color={0,0,127}));
      connect(add_min.y, second_switch.u3) annotation (Line(points={{58.6,-14},{
              62,-14},{62,-6.8},{64.8,-6.8}}, color={0,0,127}));
      connect(max_boundary.y, second_switch.u2) annotation (Line(points={{4.6,64},
              {32,64},{32,-2},{64.8,-2}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
                -100},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}})));
    end NonLinearBoundary;

    partial block partialSecurityControl "base Block"
      Modelica.Blocks.Interfaces.RealInput n_set
        "set value relative speed of compressor"
        annotation (Placement(transformation(extent={{-150,22},{-120,52}})));
      Modelica.Icons.SignalBus HeaPumSen
        "all sensor data from sink and source side"
        annotation (Placement(transformation(extent={{-150,-50},{-110,-10}})));
      Modelica.Blocks.Interfaces.RealOutput n_out
        "relative speed of compressor"
        annotation (Placement(transformation(extent={{120,-10},{140,10}})));
      Modelica.Blocks.Logical.Switch SwiErr
        "If an error occurs, the value of the conZero block will be used(0)"
        annotation (Placement(transformation(extent={{86,-10},{106,10}})));
      Modelica.Blocks.Sources.Constant conZer(k=0)
        "If an error occurs, the compressor speed is set to zero"
        annotation (Placement(transformation(extent={{58,-24},{70,-12}})));
    equation
      connect(conZer.y, SwiErr.u3) annotation (Line(points={{70.6,-18},{78,-18},
              {78,-8},{84,-8}}, color={0,0,127}));
      connect(SwiErr.y, n_out)
        annotation (Line(points={{107,0},{130,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -120,-100},{120,100}})), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-120,-100},{120,100}})));
    end partialSecurityControl;
  end BaseClasses;
end SecurityControls;
