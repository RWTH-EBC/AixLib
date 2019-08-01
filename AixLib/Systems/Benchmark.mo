within AixLib.Systems;
package Benchmark
  package ControlStrategies
    package Controller
      model Testcontroller
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{80,-40},{120,0}})));
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{80,0},{120,40}})));
        Modelica.Blocks.Sources.RealExpression Pumps1(
                                                     y=1)
          annotation (Placement(transformation(extent={{-66,-30},{-46,-10}})));
        Modelica.Blocks.Sources.RealExpression Valve_warm_Closed
          annotation (Placement(transformation(extent={{-66,0},{-46,20}})));
        Modelica.Blocks.Sources.RealExpression Valve_warm_Open(y=1)
          annotation (Placement(transformation(extent={{-68,24},{-48,44}})));
        Modelica.Blocks.Sources.RealExpression Valve_cold_Closed1
          annotation (Placement(transformation(extent={{-66,-78},{-46,-58}})));
        Modelica.Blocks.Sources.RealExpression Valve_cold_Open1(y=1)
          annotation (Placement(transformation(extent={{-68,-54},{-48,-34}})));
      equation
        connect(Pumps1.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
              points={{-45,-20},{28,-20},{28,-19.9},{100.1,-19.9}}, color={0,0,127}));
        connect(Pumps1.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
              points={{-45,-20},{28,-20},{28,-19.9},{100.1,-19.9}}, color={0,0,127}));
        connect(Pumps1.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (Line(
              points={{-45,-20},{26,-20},{26,-19.9},{100.1,-19.9}}, color={0,0,127}));
        connect(Pumps1.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points={{
                -45,-20},{28,-20},{28,-19.9},{100.1,-19.9}}, color={0,0,127}));
        connect(Pumps1.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points={{
                -45,-20},{30,-20},{30,-19.9},{100.1,-19.9}}, color={0,0,127}));
        connect(Valve_warm_Open.y, controlBus.Valve_TBA_Warm_OpenPlanOffice)
          annotation (Line(points={{-47,34},{46,34},{46,-19.9},{100.1,-19.9}}, color=
                {0,0,127}));
        connect(Valve_warm_Open.y, controlBus.Valve_TBA_Warm_conferenceroom)
          annotation (Line(points={{-47,34},{46,34},{46,-19.9},{100.1,-19.9}}, color=
                {0,0,127}));
        connect(Valve_warm_Closed.y, controlBus.Valve_TBA_Warm_multipersonoffice)
          annotation (Line(points={{-45,10},{-20,10},{-20,12},{6,12},{6,-19.9},{100.1,
                -19.9}}, color={0,0,127}));
        connect(Valve_warm_Closed.y, controlBus.Valve_TBA_Warm_canteen) annotation (
            Line(points={{-45,10},{-22,10},{-22,12},{10,12},{10,-20},{100.1,-20},{
                100.1,-19.9}}, color={0,0,127}));
        connect(Valve_warm_Closed.y, controlBus.Valve_TBA_Warm_workshop) annotation (
            Line(points={{-45,10},{-24,10},{-24,12},{8,12},{8,-19.9},{100.1,-19.9}},
              color={0,0,127}));
        connect(Valve_cold_Closed1.y, controlBus.Valve_TBA_OpenPlanOffice_Temp)
          annotation (Line(points={{-45,-68},{46,-68},{46,-19.9},{100.1,-19.9}},
              color={0,0,127}));
        connect(Valve_cold_Closed1.y, controlBus.Valve_TBA_ConferenceRoom_Temp)
          annotation (Line(points={{-45,-68},{46,-68},{46,-19.9},{100.1,-19.9}},
              color={0,0,127}));
        connect(Valve_cold_Open1.y, controlBus.Valve_TBA_MultiPersonOffice_Temp)
          annotation (Line(points={{-47,-44},{-32,-44},{-32,-46},{-12,-46},{-12,-19.9},
                {100.1,-19.9}}, color={0,0,127}));
        connect(Valve_cold_Open1.y, controlBus.Valve_TBA_Canteen_Temp) annotation (
            Line(points={{-47,-44},{-16,-44},{-16,-19.9},{100.1,-19.9}}, color={0,0,
                127}));
        connect(Valve_cold_Open1.y, controlBus.Valve_TBA_Workshop_Temp) annotation (
            Line(points={{-47,-44},{-34,-44},{-34,-42},{-16,-42},{-16,-19.9},{100.1,
                -19.9}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Testcontroller;

      model ControllerBasis_v2
        import AixLib;
        Modelica.Blocks.Math.Gain gain(k=1)
          annotation (Placement(transformation(extent={{82,20},{74,28}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp.PI_Regler_RLT
          RLT_Temp annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-60,0})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans.Pump_Basis
          pump_Basis
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans.Fan_Basis
          fan_Basis
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Controller_Generation.Valve_Basis valve_Basis
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        Controller_Generation.Generation_Basis generation_Basis
          annotation (Placement(transformation(extent={{50,-10},{70,10}})));
        AixLib.Systems.Benchmark.Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{80,-40},{120,0}})));
        AixLib.Systems.Benchmark.Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{80,0},{120,40}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp.PI_Regler_TBA_v2
          TBA_Temp annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-86,0})));
      equation
        connect(gain.u,measureBus. WaterInAir) annotation (Line(points={{82.8,24},{86,
                24},{86,20},{92,20},{92,20.1},{100.1,20.1}},
                                             color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(gain.y,controlBus. X_Central) annotation (Line(points={{73.6,24},{72,
                24},{72,-20},{86,-20},{86,-19.9},{100.1,-19.9}}, color={0,0,127}));
        connect(RLT_Temp.measureBus,measureBus)  annotation (Line(
            points={{-60,10},{-60,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(RLT_Temp.controlBus,controlBus)  annotation (Line(
            points={{-60,-10},{-60,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(pump_Basis.measureBus,measureBus)  annotation (Line(
            points={{-30,10},{-30,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(pump_Basis.controlBus,controlBus)  annotation (Line(
            points={{-30,-10},{-30,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(fan_Basis.measureBus,measureBus)  annotation (Line(
            points={{0,10},{0,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(fan_Basis.controlBus,controlBus)  annotation (Line(
            points={{0,-10},{0,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(valve_Basis.measureBus,measureBus)  annotation (Line(
            points={{30,10},{30,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(valve_Basis.controlBus,controlBus)  annotation (Line(
            points={{30,-10},{30,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_Basis.controlBus,controlBus)  annotation (Line(
            points={{60,-10},{60,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_Basis.measureBus,measureBus)  annotation (Line(
            points={{60,10},{60,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(TBA_Temp.measureBus, measureBus) annotation (Line(
            points={{-86,10},{-86,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(TBA_Temp.controlBus, controlBus) annotation (Line(
            points={{-86,-10},{-86,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end ControllerBasis_v2;

      model Controller_VariablePowerCost
        import AixLib;
        AixLib.Systems.Benchmark.Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{80,-40},{120,0}})));
        AixLib.Systems.Benchmark.Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{80,0},{120,40}})));
        Modelica.Blocks.Math.Gain gain(k=1)
          annotation (Placement(transformation(extent={{82,20},{74,28}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp.PI_Regler_TBA_v2
          TBA_Temp annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-90,0})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp.PI_Regler_RLT
          RLT_Temp annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-60,0})));
        ControlStrategies.Controller_Generation.Valve_Basis valve_Basis
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Generation.Generation_VariablePowerCost
          generation_VariablePowerCost
          annotation (Placement(transformation(extent={{48,-10},{68,10}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans.Fan_VariablePowerCost
          fan_VariablePowerCost
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans.Pump_VariablePowerCost
          pump_VariablePowerCost
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      equation
        connect(gain.u, measureBus.WaterInAir) annotation (Line(points={{82.8,24},{86,
                24},{86,20},{92,20},{92,20.1},{100.1,20.1}},
                                             color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(gain.y, controlBus.X_Central) annotation (Line(points={{73.6,24},{72,
                24},{72,-20},{86,-20},{86,-19.9},{100.1,-19.9}}, color={0,0,127}));
        connect(TBA_Temp.measureBus, measureBus) annotation (Line(
            points={{-90,10},{-90,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(RLT_Temp.measureBus, measureBus) annotation (Line(
            points={{-60,10},{-60,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(RLT_Temp.controlBus, controlBus) annotation (Line(
            points={{-60,-10},{-60,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(TBA_Temp.controlBus, controlBus) annotation (Line(
            points={{-90,-10},{-90,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(valve_Basis.measureBus, measureBus) annotation (Line(
            points={{30,10},{30,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(valve_Basis.controlBus, controlBus) annotation (Line(
            points={{30,-10},{30,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_VariablePowerCost.measureBus, measureBus) annotation (Line(
            points={{58,10},{58,40},{100,40},{100,20},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_VariablePowerCost.controlBus, controlBus) annotation (Line(
            points={{58,-10},{58,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(fan_VariablePowerCost.measureBus, measureBus) annotation (Line(
            points={{0,10},{0,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(fan_VariablePowerCost.controlBus, controlBus) annotation (Line(
            points={{0,-10},{0,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(pump_VariablePowerCost.measureBus, measureBus) annotation (Line(
            points={{-30,10},{-30,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(pump_VariablePowerCost.controlBus, controlBus) annotation (Line(
            points={{-30,-10},{-30,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Controller_VariablePowerCost;

      model Controller_NoChpAndBoiler
        import AixLib;
        AixLib.Systems.Benchmark.Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{80,-40},{120,0}})));
        AixLib.Systems.Benchmark.Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{80,0},{120,40}})));
        Modelica.Blocks.Math.Gain gain(k=1)
          annotation (Placement(transformation(extent={{82,20},{74,28}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp.PI_Regler_TBA_v2
          TBA_Temp annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-90,0})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp.PI_Regler_RLT
          RLT_Temp annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-60,0})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans.Pump_NoChpAndBoiler
          pump_NoChpAndBoiler
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans.Fan_Basis
          fan_Basis
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Generation.Valve_NoChpAndBoiler
          valve_NoChpAndBoiler
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        AixLib.Systems.Benchmark.ControlStrategies.Controller_Generation.Generation_NoChpAndBoiler
          generation_NoChpAndBoiler
          annotation (Placement(transformation(extent={{48,-10},{68,10}})));
      equation
        connect(gain.u, measureBus.WaterInAir) annotation (Line(points={{82.8,24},{86,
                24},{86,20},{92,20},{92,20.1},{100.1,20.1}},
                                             color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(gain.y, controlBus.X_Central) annotation (Line(points={{73.6,24},{72,
                24},{72,-20},{86,-20},{86,-19.9},{100.1,-19.9}}, color={0,0,127}));
        connect(TBA_Temp.measureBus, measureBus) annotation (Line(
            points={{-90,10},{-90,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(RLT_Temp.measureBus, measureBus) annotation (Line(
            points={{-60,10},{-60,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(RLT_Temp.controlBus, controlBus) annotation (Line(
            points={{-60,-10},{-60,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(TBA_Temp.controlBus, controlBus) annotation (Line(
            points={{-90,-10},{-90,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(pump_NoChpAndBoiler.measureBus, measureBus) annotation (Line(
            points={{-30,10},{-30,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(pump_NoChpAndBoiler.controlBus, controlBus) annotation (Line(
            points={{-30,-10},{-30,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(fan_Basis.measureBus, measureBus) annotation (Line(
            points={{0,10},{0,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(fan_Basis.controlBus, controlBus) annotation (Line(
            points={{0,-10},{0,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(valve_NoChpAndBoiler.measureBus, measureBus) annotation (Line(
            points={{30,10},{30,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(valve_NoChpAndBoiler.controlBus, controlBus) annotation (Line(
            points={{30,-10},{30,-10},{30,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_NoChpAndBoiler.measureBus, measureBus) annotation (Line(
            points={{58,10},{58,40},{100,40},{100,20}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_NoChpAndBoiler.controlBus, controlBus) annotation (Line(
            points={{58,-10},{58,-40},{100,-40},{100,-20}},
            color={255,204,51},
            thickness=0.5));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Controller_NoChpAndBoiler;
    end Controller;

    package Controller_Generation
      model Valve_Basis
        Modelica.Blocks.Sources.RealExpression realExpression(y=1)
          annotation (Placement(transformation(extent={{-100,86},{-80,106}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
          annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Logical.Switch Warm_Storage
          annotation (Placement(transformation(extent={{-12,44},{0,56}})));
        Modelica.Blocks.Logical.Switch Hot_Boiler
          annotation (Placement(transformation(extent={{-12,24},{0,36}})));
        Modelica.Blocks.Logical.Switch Cold_Aircooler
          annotation (Placement(transformation(extent={{-12,-16},{0,-4}})));
        Modelica.Blocks.Logical.Switch Hot_Storage
          annotation (Placement(transformation(extent={{-12,4},{0,16}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
          annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
          annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=false)
          annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=true)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=true)
          annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
        Modelica.Blocks.Logical.Switch Aircooler
          annotation (Placement(transformation(extent={{-12,-76},{0,-64}})));
        Modelica.Blocks.Continuous.LimPID Warm_Aircooler(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=1,
          yMin=0,
          k=0.01,
          Ti=200)  annotation (Placement(transformation(extent={{-12,70},{0,82}})));
        Modelica.Blocks.Continuous.LimPID Cold_Storage(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=1,
          yMin=0,
          k=0.01,
          Ti=200) annotation (Placement(transformation(extent={{-12,-36},{0,-24}})));
        Modelica.Blocks.Continuous.LimPID Cold_Geothermal(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=0,
          yMin=-1,
          k=0.1,
          Ti=20)   annotation (Placement(transformation(extent={{-12,-56},{0,-44}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 2.3)
          annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 47)
          annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
        Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 3)
          annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
        Modelica.Blocks.Math.Gain gain2(k=-1)
          annotation (Placement(transformation(extent={{16,-54},{24,-46}})));
        Modelica.Blocks.Continuous.LimPID Warm_Aircooler1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          Ti=200,
          yMin=-1,
          yMax=-0.5)
                   annotation (Placement(transformation(extent={{6,58},{18,70}})));
        Modelica.Blocks.Sources.RealExpression realExpression5(y=273.15 + 5)
          annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
          annotation (Placement(transformation(extent={{24,60},{32,68}})));
        Modelica.Blocks.Math.Min min
          annotation (Placement(transformation(extent={{50,66},{62,78}})));
        Modelica.Blocks.Logical.Switch Warm_Storage1
          annotation (Placement(transformation(extent={{78,58},{90,70}})));
        Modelica.Blocks.Continuous.LimPID Warm_Aircooler2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          Ti=200,
          yMax=0.5,
          yMin=0)  annotation (Placement(transformation(extent={{24,80},{36,92}})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{48,58},{68,38}})));
      equation
        connect(booleanExpression.y, Cold_Aircooler.u2)
          annotation (Line(points={{-39,-10},{-13.2,-10}}, color={255,0,255}));
        connect(booleanExpression1.y, Warm_Storage.u2)
          annotation (Line(points={{-39,50},{-13.2,50}}, color={255,0,255}));
        connect(booleanExpression2.y, Hot_Storage.u2)
          annotation (Line(points={{-39,10},{-13.2,10}}, color={255,0,255}));
        connect(booleanExpression3.y, Hot_Boiler.u2)
          annotation (Line(points={{-39,30},{-13.2,30}}, color={255,0,255}));
        connect(Warm_Storage.u1, realExpression1.y) annotation (Line(points={{-13.2,
                54.8},{-34,54.8},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Warm_Storage.u3, realExpression.y) annotation (Line(points={{-13.2,
                45.2},{-28,45.2},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Hot_Boiler.u1, realExpression1.y) annotation (Line(points={{-13.2,
                34.8},{-34,34.8},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Hot_Boiler.u3, realExpression.y) annotation (Line(points={{-13.2,25.2},
                {-28,25.2},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Hot_Storage.u1, realExpression1.y) annotation (Line(points={{-13.2,
                14.8},{-34,14.8},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Hot_Storage.u3, realExpression.y) annotation (Line(points={{-13.2,5.2},
                {-28,5.2},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Cold_Aircooler.u1, realExpression1.y) annotation (Line(points={{-13.2,
                -5.2},{-34,-5.2},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Cold_Aircooler.u3, realExpression.y) annotation (Line(points={{-13.2,
                -14.8},{-28,-14.8},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Cold_Aircooler.y, controlBus.Valve3) annotation (Line(points={{0.6,
                -10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Hot_Storage.y, controlBus.Valve7) annotation (Line(points={{0.6,10},{
                40,10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Hot_Boiler.y, controlBus.Valve6) annotation (Line(points={{0.6,30},{
                40,30},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Warm_Storage.y, controlBus.Valve5) annotation (Line(points={{0.6,50},
                {40,50},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(booleanExpression4.y, Aircooler.u2)
          annotation (Line(points={{-39,-70},{-13.2,-70}}, color={255,0,255}));
        connect(Aircooler.u3, realExpression.y) annotation (Line(points={{-13.2,-74.8},
                {-28,-74.8},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Aircooler.u1, realExpression1.y) annotation (Line(points={{-13.2,
                -65.2},{-34,-65.2},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Aircooler.y, controlBus.Valve8) annotation (Line(points={{0.6,-70},{
                40,-70},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression3.y, Warm_Aircooler.u_s)
          annotation (Line(points={{-79,76},{-13.2,76}}, color={0,0,127}));
        connect(realExpression2.y, Cold_Geothermal.u_s)
          annotation (Line(points={{-79,-50},{-13.2,-50}}, color={0,0,127}));
        connect(realExpression4.y, Cold_Storage.u_s)
          annotation (Line(points={{-79,-30},{-13.2,-30}}, color={0,0,127}));
        connect(Cold_Storage.u_m, measureBus.ColdWater_TBottom) annotation (Line(
              points={{-6,-37.2},{-6,-40},{-72,-40},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Warm_Aircooler.u_m, measureBus.WarmWater_TTop) annotation (Line(
              points={{-6,68.8},{-6,60},{-72,60},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Cold_Storage.y, controlBus.Valve2) annotation (Line(points={{0.6,-30},
                {40,-30},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Cold_Geothermal.y, gain2.u)
          annotation (Line(points={{0.6,-50},{15.2,-50}}, color={0,0,127}));
        connect(gain2.y, controlBus.Valve1) annotation (Line(points={{24.4,-50},{40,
                -50},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression5.y, Warm_Aircooler1.u_s) annotation (Line(points={{-79,
                60},{-76,60},{-76,64},{4.8,64}}, color={0,0,127}));
        connect(Warm_Aircooler1.y, gain1.u)
          annotation (Line(points={{18.6,64},{23.2,64}}, color={0,0,127}));
        connect(Warm_Aircooler.y, min.u1) annotation (Line(points={{0.6,76},{26,76},{
                26,75.6},{48.8,75.6}}, color={0,0,127}));
        connect(Warm_Aircooler1.u_m, measureBus.Aircooler) annotation (Line(points={{
                12,56.8},{12,52},{2,52},{2,60},{-72,60},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Cold_Geothermal.u_m, measureBus.Heatpump_cold_out) annotation (Line(
              points={{-6,-57.2},{-6,-60},{-72,-60},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Warm_Storage1.u2, controlBus.OnOff_heatpump_1) annotation (Line(
              points={{76.8,64},{40,64},{40,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(Warm_Aircooler2.u_s, Warm_Aircooler1.u_s) annotation (Line(points={{
                22.8,86},{2,86},{2,64},{4.8,64}}, color={0,0,127}));
        connect(Warm_Aircooler2.u_m, measureBus.Aircooler) annotation (Line(points={{
                30,78.8},{30,74},{0.1,74},{0.1,100.1}}, color={0,0,127}));
        connect(min.y, Warm_Storage1.u1) annotation (Line(points={{62.6,72},{66,72},{
                66,68.8},{76.8,68.8}}, color={0,0,127}));
        connect(gain1.y, min.u2) annotation (Line(points={{32.4,64},{40,64},{40,68.4},
                {48.8,68.4}}, color={0,0,127}));
        connect(Warm_Storage1.y, controlBus.Valve4) annotation (Line(points={{90.6,64},
                {94,64},{94,0},{40,0},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(feedback.u1, min.u1) annotation (Line(points={{50,48},{40,48},{40,76},
                {48.8,75.6}}, color={0,0,127}));
        connect(Warm_Aircooler2.y, feedback.u2) annotation (Line(points={{36.6,86},{
                46,86},{46,56},{58,56}}, color={0,0,127}));
        connect(feedback.y, Warm_Storage1.u3) annotation (Line(points={{67,48},{70,48},
                {70,59.2},{76.8,59.2}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Valve_Basis;

      model Generation_Basis
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{-46,60},{-26,80}})));
        Modelica.Blocks.Logical.Or or2
          annotation (Placement(transformation(extent={{-46,20},{-34,32}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 90)
          annotation (Placement(transformation(extent={{80,-54},{60,-34}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=26)
          annotation (Placement(transformation(extent={{80,-66},{60,-46}})));
        Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 90)
          annotation (Placement(transformation(extent={{80,-20},{60,0}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis(
          pre_y_start=true,
          uLow=273.15 + 45,
          uHigh=273.15 + 65)
          annotation (Placement(transformation(extent={{-92,-16},{-80,-4}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis1(
          pre_y_start=true,
          uHigh=273.15 + 70,
          uLow=273.15 + 55)
          annotation (Placement(transformation(extent={{-92,-56},{-80,-44}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 3.5, uHigh=
              273.15 + 6)
          annotation (Placement(transformation(extent={{-92,12},{-80,24}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=273.15 + 35, uHigh=273.15
               + 45)
          annotation (Placement(transformation(extent={{-92,28},{-80,40}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis4(uLow=273.15 + 5, uHigh=273.15
               + 9)
          annotation (Placement(transformation(extent={{-92,52},{-80,64}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis5(uLow=273.15 + 30, uHigh=273.15
               + 40)
          annotation (Placement(transformation(extent={{-92,68},{-80,80}})));
        Modelica.Blocks.Logical.And and1
          annotation (Placement(transformation(extent={{12,60},{26,74}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=2.5)
                  annotation (Placement(transformation(extent={{-10,68},{2,80}})));
        Modelica.Blocks.Logical.Not not1
          annotation (Placement(transformation(extent={{-50,-16},{-38,-4}})));
        Modelica.Blocks.Logical.Not not2
          annotation (Placement(transformation(extent={{-50,-56},{-38,-44}})));
        Modelica.Blocks.Logical.Not not3
          annotation (Placement(transformation(extent={{-70,28},{-58,40}})));
        Modelica.Blocks.Logical.Not not4
          annotation (Placement(transformation(extent={{-70,68},{-58,80}})));
        Modelica.Blocks.Logical.Or or3
          annotation (Placement(transformation(extent={{-22,20},{-10,32}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis6(uLow=273.15 + 1, uHigh=273.15
               + 4)
          annotation (Placement(transformation(extent={{-76,0},{-64,12}})));
        Modelica.Blocks.Logical.Not not5
          annotation (Placement(transformation(extent={{-54,0},{-42,12}})));
      equation
        connect(realExpression3.y, controlBus.ElSet_CHP) annotation (Line(points={{59,
                -56},{40,-56},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression2.y, controlBus.TSet_CHP) annotation (Line(points={{59,
                -44},{40,-44},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression4.y, controlBus.TSet_boiler) annotation (Line(points={{
                59,-10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(hysteresis.u, measureBus.HotWater_TTop) annotation (Line(points={{
                -93.2,-10},{-100,-10},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis1.u, measureBus.HotWater_TTop) annotation (Line(points={{
                -93.2,-50},{-100,-50},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis5.u, measureBus.WarmWater_TTop) annotation (Line(points={{
                -93.2,74},{-100,74},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis3.u, measureBus.WarmWater_TTop) annotation (Line(points={{
                -93.2,34},{-100,34},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis4.u, measureBus.ColdWater_TBottom) annotation (Line(points=
                {{-93.2,58},{-100,58},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis2.u, measureBus.ColdWater_TBottom) annotation (Line(points={{-93.2,
                18},{-100,18},{-100,86},{0.1,86},{0.1,100.1}},         color={0,0,127}));
        connect(hysteresis4.y, or1.u2) annotation (Line(points={{-79.4,58},{-54,58},{
                -54,62},{-48,62}}, color={255,0,255}));
        connect(hysteresis2.y, or2.u2) annotation (Line(points={{-79.4,18},{-54,18},{
                -54,21.2},{-47.2,21.2}},
                                   color={255,0,255}));
        connect(or1.y, and1.u2) annotation (Line(points={{-25,70},{-18,70},{-18,61.4},
                {10.6,61.4}}, color={255,0,255}));
        connect(greaterThreshold.y, and1.u1) annotation (Line(points={{2.6,74},{6,74},
                {6,67},{10.6,67}}, color={255,0,255}));
        connect(greaterThreshold.u, measureBus.heatpump_cold_massflow) annotation (
            Line(points={{-11.2,74},{-20,74},{-20,86},{0.1,86},{0.1,100.1}}, color={0,
                0,127}));
        connect(hysteresis.y, not1.u)
          annotation (Line(points={{-79.4,-10},{-51.2,-10}}, color={255,0,255}));
        connect(hysteresis1.y, not2.u)
          annotation (Line(points={{-79.4,-50},{-51.2,-50}}, color={255,0,255}));
        connect(hysteresis5.y, not4.u)
          annotation (Line(points={{-79.4,74},{-71.2,74}}, color={255,0,255}));
        connect(not4.y, or1.u1) annotation (Line(points={{-57.4,74},{-52,74},{-52,70},
                {-48,70}}, color={255,0,255}));
        connect(not3.y, or2.u1) annotation (Line(points={{-57.4,34},{-52,34},{-52,26},
                {-47.2,26}},
                           color={255,0,255}));
        connect(hysteresis3.y, not3.u)
          annotation (Line(points={{-79.4,34},{-71.2,34}}, color={255,0,255}));
        connect(not1.y, controlBus.OnOff_boiler) annotation (Line(points={{-37.4,-10},
                {0.1,-10},{0.1,-99.9}}, color={255,0,255}));
        connect(not2.y, controlBus.OnOff_CHP) annotation (Line(points={{-37.4,-50},{
                0.1,-50},{0.1,-99.9}}, color={255,0,255}));
        connect(or2.y, or3.u1)
          annotation (Line(points={{-33.4,26},{-23.2,26}}, color={255,0,255}));
        connect(hysteresis6.y, not5.u)
          annotation (Line(points={{-63.4,6},{-55.2,6}}, color={255,0,255}));
        connect(not5.y, or3.u2) annotation (Line(points={{-41.4,6},{-30,6},{-30,21.2},
                {-23.2,21.2}}, color={255,0,255}));
        connect(hysteresis6.u, measureBus.Aircooler) annotation (Line(points={{-77.2,
                6},{-100,6},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(or3.y, controlBus.OnOff_heatpump_1) annotation (Line(points={{-9.4,26},
                {0.1,26},{0.1,-99.9}}, color={255,0,255}));
        connect(and1.y, controlBus.OnOff_heatpump_2) annotation (Line(points={{26.7,
                67},{40,67},{40,26},{0.1,26},{0.1,-99.9}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Generation_Basis;

      model Generation_VariablePowerCost
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 90)
          annotation (Placement(transformation(extent={{80,-54},{60,-34}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=26)
          annotation (Placement(transformation(extent={{80,-66},{60,-46}})));
        Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 90)
          annotation (Placement(transformation(extent={{80,-20},{60,0}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis(
          pre_y_start=true,
          uLow=273.15 + 45,
          uHigh=273.15 + 65)
          annotation (Placement(transformation(extent={{-92,-50},{-80,-38}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis1(
          pre_y_start=true,
          uHigh=273.15 + 70,
          uLow=273.15 + 55)
          annotation (Placement(transformation(extent={{-92,-90},{-80,-78}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 5, uHigh=273.15
               + 10)
          annotation (Placement(transformation(extent={{-92,-22},{-80,-10}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis3(                  uHigh=273.15
               + 45, uLow=273.15 + 30)
          annotation (Placement(transformation(extent={{-92,-6},{-80,6}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis4(                   uLow=273.15
               + 7, uHigh=273.15 + 10)
          annotation (Placement(transformation(extent={{-92,52},{-80,64}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis5(uLow=273.15 + 30, uHigh=273.15
               + 40)
          annotation (Placement(transformation(extent={{-92,68},{-80,80}})));
        Modelica.Blocks.Logical.And and1
          annotation (Placement(transformation(extent={{12,60},{26,74}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=2.5)
                  annotation (Placement(transformation(extent={{-10,68},{2,80}})));
        Modelica.Blocks.Logical.Not not1
          annotation (Placement(transformation(extent={{-50,-50},{-38,-38}})));
        Modelica.Blocks.Logical.Not not2
          annotation (Placement(transformation(extent={{-50,-90},{-38,-78}})));
        Modelica.Blocks.Logical.Not not3
          annotation (Placement(transformation(extent={{-70,-6},{-58,6}})));
        Modelica.Blocks.Logical.Not not4
          annotation (Placement(transformation(extent={{-74,68},{-62,80}})));
        Modelica.Blocks.Logical.Or or3
          annotation (Placement(transformation(extent={{-16,-14},{-4,-2}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis6(uLow=273.15 + 1, uHigh=273.15
               + 4)
          annotation (Placement(transformation(extent={{-76,-34},{-64,-22}})));
        Modelica.Blocks.Logical.Not not5
          annotation (Placement(transformation(extent={{-54,-34},{-42,-22}})));
        Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
             22) annotation (Placement(transformation(extent={{-148,58},{-160,70}})));
        Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=6)
          annotation (Placement(transformation(extent={{-148,40},{-160,52}})));
        Modelica.Blocks.Math.IntegerToReal integerToReal
          annotation (Placement(transformation(extent={{-116,20},{-136,40}})));
        Modelica.Blocks.Logical.And and2
          annotation (Placement(transformation(extent={{-56,32},{-42,46}})));
        Modelica.Blocks.Logical.And and4
          annotation (Placement(transformation(extent={{-42,12},{-28,26}})));
        Modelica.Blocks.Logical.Or or4
          annotation (Placement(transformation(extent={{-90,18},{-78,30}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{-30,48},{-18,60}})));
        Modelica.Blocks.Logical.And and3
          annotation (Placement(transformation(extent={{-54,58},{-40,72}})));
        Modelica.Blocks.Logical.And and5
          annotation (Placement(transformation(extent={{-46,-14},{-32,0}})));
        Modelica.Blocks.Logical.Or or2
          annotation (Placement(transformation(extent={{-18,8},{-6,20}})));
      equation
        connect(realExpression3.y, controlBus.ElSet_CHP) annotation (Line(points={{59,
                -56},{40,-56},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression2.y, controlBus.TSet_CHP) annotation (Line(points={{59,
                -44},{40,-44},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression4.y, controlBus.TSet_boiler) annotation (Line(points={{
                59,-10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(hysteresis.u, measureBus.HotWater_TTop) annotation (Line(points={{-93.2,
                -44},{-100,-44},{-100,86},{0,86},{0,94},{0.1,94},{0.1,100.1}},
                                                                       color={0,0,127}));
        connect(hysteresis1.u, measureBus.HotWater_TTop) annotation (Line(points={{-93.2,
                -84},{-100,-84},{-100,86},{0,86},{0,94},{0.1,94},{0.1,100.1}},
                                                                       color={0,0,127}));
        connect(hysteresis5.u, measureBus.WarmWater_TTop) annotation (Line(points={{
                -93.2,74},{-100,74},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis3.u, measureBus.WarmWater_TTop) annotation (Line(points={{-93.2,0},
                {-100,0},{-100,86},{0,86},{0,94},{0.1,94},{0.1,100.1}},
                                                                     color={0,0,127}));
        connect(greaterThreshold.y, and1.u1) annotation (Line(points={{2.6,74},{6,74},
                {6,67},{10.6,67}}, color={255,0,255}));
        connect(greaterThreshold.u, measureBus.heatpump_cold_massflow) annotation (
            Line(points={{-11.2,74},{-20,74},{-20,86},{0.1,86},{0.1,100.1}}, color={0,
                0,127}));
        connect(hysteresis.y, not1.u)
          annotation (Line(points={{-79.4,-44},{-51.2,-44}}, color={255,0,255}));
        connect(hysteresis1.y, not2.u)
          annotation (Line(points={{-79.4,-84},{-51.2,-84}}, color={255,0,255}));
        connect(hysteresis5.y, not4.u)
          annotation (Line(points={{-79.4,74},{-75.2,74}}, color={255,0,255}));
        connect(hysteresis3.y, not3.u)
          annotation (Line(points={{-79.4,0},{-71.2,0}},   color={255,0,255}));
        connect(not1.y, controlBus.OnOff_boiler) annotation (Line(points={{-37.4,-44},
                {0.1,-44},{0.1,-99.9}}, color={255,0,255}));
        connect(not2.y, controlBus.OnOff_CHP) annotation (Line(points={{-37.4,-84},{
                0.1,-84},{0.1,-99.9}}, color={255,0,255}));
        connect(hysteresis6.y, not5.u)
          annotation (Line(points={{-63.4,-28},{-55.2,-28}},
                                                         color={255,0,255}));
        connect(not5.y, or3.u2) annotation (Line(points={{-41.4,-28},{-22,-28},{-22,
                -12.8},{-17.2,-12.8}},
                               color={255,0,255}));
        connect(integerToReal.u, measureBus.Hour) annotation (Line(points={{-114,30},
                {-100,30},{-100,86},{0.1,86},{0.1,100.1}}, color={255,127,0}));
        connect(integerToReal.y, greaterEqualThreshold.u) annotation (Line(points={{
                -137,30},{-140,30},{-140,64},{-146.8,64}}, color={0,0,127}));
        connect(lessEqualThreshold.u, greaterEqualThreshold.u) annotation (Line(
              points={{-146.8,46},{-140,46},{-140,64},{-146.8,64}}, color={0,0,127}));
        connect(not4.y, and2.u1) annotation (Line(points={{-61.4,74},{-60,74},{-60,39},
                {-57.4,39}}, color={255,0,255}));
        connect(not3.y, and4.u2) annotation (Line(points={{-57.4,0},{-52,0},{-52,13.4},
                {-43.4,13.4}}, color={255,0,255}));
        connect(and4.u1, and2.u2) annotation (Line(points={{-43.4,19},{-60,19},{-60,
                33.4},{-57.4,33.4}}, color={255,0,255}));
        connect(lessEqualThreshold.y, or4.u1) annotation (Line(points={{-160.6,46},{
                -168,46},{-168,18},{-106,18},{-106,24},{-91.2,24}}, color={255,0,255}));
        connect(greaterEqualThreshold.y, or4.u2) annotation (Line(points={{-160.6,64},
                {-168,64},{-168,18},{-106,18},{-106,19.2},{-91.2,19.2}}, color={255,0,
                255}));
        connect(or4.y, and2.u2) annotation (Line(points={{-77.4,24},{-60,24},{-60,
                33.4},{-57.4,33.4}}, color={255,0,255}));
        connect(hysteresis6.u, measureBus.Aircooler) annotation (Line(points={{-77.2,
                -28},{-100,-28},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(or3.y, controlBus.OnOff_heatpump_1) annotation (Line(points={{-3.4,-8},
                {0.1,-8},{0.1,-99.9}}, color={255,0,255}));
        connect(and1.y, controlBus.OnOff_heatpump_2) annotation (Line(points={{26.7,
                67},{32,67},{32,0},{0.1,0},{0.1,-99.9}}, color={255,0,255}));
        connect(hysteresis4.u, measureBus.ColdWater_TTop) annotation (Line(points={{
                -93.2,58},{-100,58},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis2.u, measureBus.ColdWater_TTop) annotation (Line(points={{
                -93.2,-16},{-100,-16},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(and3.u2, and2.u2) annotation (Line(points={{-55.4,59.4},{-68,59.4},{
                -68,24},{-60,24},{-60,33.4},{-57.4,33.4}}, color={255,0,255}));
        connect(and3.u1, hysteresis4.y) annotation (Line(points={{-55.4,65},{-74,65},
                {-74,58},{-79.4,58}}, color={255,0,255}));
        connect(and3.y, or1.u1) annotation (Line(points={{-39.3,65},{-39.3,59.5},{
                -31.2,59.5},{-31.2,54}}, color={255,0,255}));
        connect(and2.y, or1.u2) annotation (Line(points={{-41.3,39},{-41.3,44.5},{
                -31.2,44.5},{-31.2,49.2}}, color={255,0,255}));
        connect(or1.y, and1.u2) annotation (Line(points={{-17.4,54},{-4,54},{-4,61.4},
                {10.6,61.4}}, color={255,0,255}));
        connect(hysteresis2.y, and5.u2) annotation (Line(points={{-79.4,-16},{-64,-16},
                {-64,-12.6},{-47.4,-12.6}}, color={255,0,255}));
        connect(and5.u1, and2.u2) annotation (Line(points={{-47.4,-7},{-47.4,-6},{-56,
                -6},{-56,20},{-60,19},{-60,33.4},{-57.4,33.4}}, color={255,0,255}));
        connect(and4.y, or2.u1) annotation (Line(points={{-27.3,19},{-23.65,19},{
                -23.65,14},{-19.2,14}}, color={255,0,255}));
        connect(and5.y, or2.u2) annotation (Line(points={{-31.3,-7},{-31.3,1.5},{
                -19.2,1.5},{-19.2,9.2}}, color={255,0,255}));
        connect(or2.y, or3.u1) annotation (Line(points={{-5.4,14},{0,14},{0,0},{-22,0},
                {-22,-8},{-17.2,-8}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Generation_VariablePowerCost;

      model Generation_NoChpAndBoiler
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{-46,60},{-26,80}})));
        Modelica.Blocks.Logical.Or or2
          annotation (Placement(transformation(extent={{-46,20},{-34,32}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 90)
          annotation (Placement(transformation(extent={{80,-54},{60,-34}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=26)
          annotation (Placement(transformation(extent={{80,-66},{60,-46}})));
        Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 90)
          annotation (Placement(transformation(extent={{80,-20},{60,0}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 3.5, uHigh=
              273.15 + 6)
          annotation (Placement(transformation(extent={{-92,12},{-80,24}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=273.15 + 35, uHigh=273.15
               + 45)
          annotation (Placement(transformation(extent={{-92,28},{-80,40}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis4(uLow=273.15 + 5, uHigh=273.15
               + 9)
          annotation (Placement(transformation(extent={{-92,52},{-80,64}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis5(uLow=273.15 + 30, uHigh=273.15
               + 40)
          annotation (Placement(transformation(extent={{-92,68},{-80,80}})));
        Modelica.Blocks.Logical.And and1
          annotation (Placement(transformation(extent={{12,60},{26,74}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=2.5)
                  annotation (Placement(transformation(extent={{-10,72},{2,84}})));
        Modelica.Blocks.Logical.Not not3
          annotation (Placement(transformation(extent={{-70,28},{-58,40}})));
        Modelica.Blocks.Logical.Not not4
          annotation (Placement(transformation(extent={{-70,68},{-58,80}})));
        Modelica.Blocks.Logical.Or or3
          annotation (Placement(transformation(extent={{-24,20},{-12,32}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis6(uLow=273.15 + 1, uHigh=273.15
               + 4)
          annotation (Placement(transformation(extent={{-92,-4},{-80,8}})));
        Modelica.Blocks.Logical.Not not5
          annotation (Placement(transformation(extent={{-66,-4},{-54,8}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression
          annotation (Placement(transformation(extent={{-66,-60},{-46,-40}})));
      equation
        connect(realExpression3.y, controlBus.ElSet_CHP) annotation (Line(points={{59,
                -56},{40,-56},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression2.y, controlBus.TSet_CHP) annotation (Line(points={{59,
                -44},{40,-44},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression4.y, controlBus.TSet_boiler) annotation (Line(points={{
                59,-10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(hysteresis5.u, measureBus.WarmWater_TTop) annotation (Line(points={{
                -93.2,74},{-100,74},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis3.u, measureBus.WarmWater_TTop) annotation (Line(points={{
                -93.2,34},{-100,34},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis4.u, measureBus.ColdWater_TBottom) annotation (Line(points=
                {{-93.2,58},{-100,58},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis2.u, measureBus.ColdWater_TBottom) annotation (Line(points={{-93.2,
                18},{-100,18},{-100,86},{0.1,86},{0.1,100.1}},         color={0,0,127}));
        connect(hysteresis4.y, or1.u2) annotation (Line(points={{-79.4,58},{-54,58},{
                -54,62},{-48,62}}, color={255,0,255}));
        connect(hysteresis2.y, or2.u2) annotation (Line(points={{-79.4,18},{-54,18},{
                -54,21.2},{-47.2,21.2}},
                                   color={255,0,255}));
        connect(greaterThreshold.y, and1.u1) annotation (Line(points={{2.6,78},{6,78},
                {6,67},{10.6,67}}, color={255,0,255}));
        connect(greaterThreshold.u, measureBus.heatpump_cold_massflow) annotation (
            Line(points={{-11.2,78},{-20,78},{-20,86},{0.1,86},{0.1,100.1}}, color={0,
                0,127}));
        connect(hysteresis5.y, not4.u)
          annotation (Line(points={{-79.4,74},{-71.2,74}}, color={255,0,255}));
        connect(not4.y, or1.u1) annotation (Line(points={{-57.4,74},{-52,74},{-52,70},
                {-48,70}}, color={255,0,255}));
        connect(not3.y, or2.u1) annotation (Line(points={{-57.4,34},{-52,34},{-52,26},
                {-47.2,26}},
                           color={255,0,255}));
        connect(hysteresis3.y, not3.u)
          annotation (Line(points={{-79.4,34},{-71.2,34}}, color={255,0,255}));
        connect(or2.y, or3.u1)
          annotation (Line(points={{-33.4,26},{-25.2,26}}, color={255,0,255}));
        connect(hysteresis6.y, not5.u)
          annotation (Line(points={{-79.4,2},{-67.2,2}}, color={255,0,255}));
        connect(not5.y, or3.u2) annotation (Line(points={{-53.4,2},{-30,2},{-30,21.2},
                {-25.2,21.2}}, color={255,0,255}));
        connect(booleanExpression.y, controlBus.OnOff_CHP) annotation (Line(points={{
                -45,-50},{0.1,-50},{0.1,-99.9}}, color={255,0,255}));
        connect(booleanExpression.y, controlBus.OnOff_boiler) annotation (Line(points=
               {{-45,-50},{-28,-50},{-28,-50},{0.1,-50},{0.1,-99.9}}, color={255,0,
                255}));
        connect(or1.y, and1.u2) annotation (Line(points={{-25,70},{-8,70},{-8,61.4},{
                10.6,61.4}}, color={255,0,255}));
        connect(hysteresis6.u, measureBus.Aircooler) annotation (Line(points={{-93.2,
                2},{-100,2},{-100,86},{0.1,86},{0.1,100.1}}, color={0,0,127}));
        connect(or3.y, controlBus.OnOff_heatpump_2) annotation (Line(points={{-11.4,
                26},{0.1,26},{0.1,-99.9}}, color={255,0,255}));
        connect(and1.y, controlBus.OnOff_heatpump_1) annotation (Line(points={{26.7,
                67},{32,67},{32,28},{0.1,28},{0.1,-99.9}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Generation_NoChpAndBoiler;

      model Valve_NoChpAndBoiler
        Modelica.Blocks.Sources.RealExpression realExpression(y=1)
          annotation (Placement(transformation(extent={{-100,86},{-80,106}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
          annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Logical.Switch Hot_Boiler
          annotation (Placement(transformation(extent={{-12,24},{0,36}})));
        Modelica.Blocks.Logical.Switch Cold_Aircooler
          annotation (Placement(transformation(extent={{-12,-16},{0,-4}})));
        Modelica.Blocks.Logical.Switch Hot_Storage
          annotation (Placement(transformation(extent={{-12,4},{0,16}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
          annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=false)
          annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=true)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=true)
          annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
        Modelica.Blocks.Logical.Switch Aircooler
          annotation (Placement(transformation(extent={{-12,-76},{0,-64}})));
        Modelica.Blocks.Continuous.LimPID Warm_Aircooler(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=1,
          yMin=0,
          k=0.01,
          Ti=200)  annotation (Placement(transformation(extent={{-12,70},{0,82}})));
        Modelica.Blocks.Continuous.LimPID Cold_Storage(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=1,
          yMin=0,
          k=0.01,
          Ti=200) annotation (Placement(transformation(extent={{-12,-36},{0,-24}})));
        Modelica.Blocks.Continuous.LimPID Cold_Geothermal(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=0,
          yMin=-1,
          k=0.1,
          Ti=20)   annotation (Placement(transformation(extent={{-12,-56},{0,-44}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 2.3)
          annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 47)
          annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
        Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 3)
          annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
        Modelica.Blocks.Math.Gain gain2(k=-1)
          annotation (Placement(transformation(extent={{16,-54},{24,-46}})));
        Modelica.Blocks.Continuous.LimPID Warm_Aircooler1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          Ti=200,
          yMax=0,
          yMin=-1) annotation (Placement(transformation(extent={{6,58},{18,70}})));
        Modelica.Blocks.Sources.RealExpression realExpression5(y=273.15 + 5)
          annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
          annotation (Placement(transformation(extent={{24,60},{32,68}})));
        Modelica.Blocks.Continuous.LimPID Warm_Aircooler2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          Ti=200,
          yMax=1,
          yMin=0)  annotation (Placement(transformation(extent={{-18,44},{-6,56}})));
        Modelica.Blocks.Sources.RealExpression realExpression6(y=273.15 + 50)
          annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
        Modelica.Blocks.Math.Min min
          annotation (Placement(transformation(extent={{50,66},{62,78}})));
        Modelica.Blocks.Logical.Switch Warm_Storage1
          annotation (Placement(transformation(extent={{78,58},{90,70}})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{48,58},{68,38}})));
        Modelica.Blocks.Continuous.LimPID Warm_Aircooler3(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          Ti=200,
          yMax=0.5,
          yMin=0)  annotation (Placement(transformation(extent={{24,80},{36,92}})));
      equation
        connect(booleanExpression.y, Cold_Aircooler.u2)
          annotation (Line(points={{-39,-10},{-13.2,-10}}, color={255,0,255}));
        connect(booleanExpression2.y, Hot_Storage.u2)
          annotation (Line(points={{-39,10},{-13.2,10}}, color={255,0,255}));
        connect(booleanExpression3.y, Hot_Boiler.u2)
          annotation (Line(points={{-39,30},{-13.2,30}}, color={255,0,255}));
        connect(Hot_Boiler.u1, realExpression1.y) annotation (Line(points={{-13.2,
                34.8},{-34,34.8},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Hot_Boiler.u3, realExpression.y) annotation (Line(points={{-13.2,25.2},
                {-28,25.2},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Hot_Storage.u1, realExpression1.y) annotation (Line(points={{-13.2,
                14.8},{-34,14.8},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Hot_Storage.u3, realExpression.y) annotation (Line(points={{-13.2,5.2},
                {-28,5.2},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Cold_Aircooler.u1, realExpression1.y) annotation (Line(points={{-13.2,
                -5.2},{-34,-5.2},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Cold_Aircooler.u3, realExpression.y) annotation (Line(points={{-13.2,
                -14.8},{-28,-14.8},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Cold_Aircooler.y, controlBus.Valve3) annotation (Line(points={{0.6,
                -10},{40,-10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Hot_Storage.y, controlBus.Valve7) annotation (Line(points={{0.6,10},{
                40,10},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Hot_Boiler.y, controlBus.Valve6) annotation (Line(points={{0.6,30},{
                40,30},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(booleanExpression4.y, Aircooler.u2)
          annotation (Line(points={{-39,-70},{-13.2,-70}}, color={255,0,255}));
        connect(Aircooler.u3, realExpression.y) annotation (Line(points={{-13.2,-74.8},
                {-28,-74.8},{-28,96},{-79,96}}, color={0,0,127}));
        connect(Aircooler.u1, realExpression1.y) annotation (Line(points={{-13.2,
                -65.2},{-34,-65.2},{-34,-96},{-79,-96}}, color={0,0,127}));
        connect(Aircooler.y, controlBus.Valve8) annotation (Line(points={{0.6,-70},{
                40,-70},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression3.y, Warm_Aircooler.u_s)
          annotation (Line(points={{-79,76},{-13.2,76}}, color={0,0,127}));
        connect(realExpression2.y, Cold_Geothermal.u_s)
          annotation (Line(points={{-79,-50},{-13.2,-50}}, color={0,0,127}));
        connect(realExpression4.y, Cold_Storage.u_s)
          annotation (Line(points={{-79,-30},{-13.2,-30}}, color={0,0,127}));
        connect(Cold_Storage.u_m, measureBus.ColdWater_TBottom) annotation (Line(
              points={{-6,-37.2},{-6,-40},{-72,-40},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Warm_Aircooler.u_m, measureBus.WarmWater_TTop) annotation (Line(
              points={{-6,68.8},{-6,60},{-72,60},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Cold_Storage.y, controlBus.Valve2) annotation (Line(points={{0.6,-30},
                {40,-30},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Cold_Geothermal.y, gain2.u)
          annotation (Line(points={{0.6,-50},{15.2,-50}}, color={0,0,127}));
        connect(gain2.y, controlBus.Valve1) annotation (Line(points={{24.4,-50},{40,
                -50},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(realExpression5.y, Warm_Aircooler1.u_s) annotation (Line(points={{-79,
                60},{-76,60},{-76,64},{4.8,64}}, color={0,0,127}));
        connect(Warm_Aircooler1.y, gain1.u)
          annotation (Line(points={{18.6,64},{23.2,64}}, color={0,0,127}));
        connect(realExpression6.y, Warm_Aircooler2.u_s) annotation (Line(points={{-79,
                44},{-56,44},{-56,50},{-19.2,50}}, color={0,0,127}));
        connect(Warm_Aircooler2.u_m, measureBus.HotWater_TTop) annotation (Line(
              points={{-12,42.8},{-12,38},{-72,38},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Warm_Aircooler2.y, controlBus.Valve5) annotation (Line(points={{-5.4,
                50},{18,50},{18,40},{40,40},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Warm_Aircooler1.u_m, measureBus.Aircooler) annotation (Line(points={{
                12,56.8},{12,52},{0,52},{0,60},{-72,60},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Cold_Geothermal.u_m, measureBus.Heatpump_cold_out) annotation (Line(
              points={{-6,-57.2},{-6,-60},{-72,-60},{-72,86},{0.1,86},{0.1,100.1}},
              color={0,0,127}));
        connect(Warm_Aircooler.y,min. u1) annotation (Line(points={{0.6,76},{26,76},{
                26,75.6},{48.8,75.6}}, color={0,0,127}));
        connect(Warm_Storage1.u2, controlBus.OnOff_heatpump_1) annotation (Line(
              points={{76.8,64},{40,64},{40,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(min.y,Warm_Storage1. u1) annotation (Line(points={{62.6,72},{66,72},{
                66,68.8},{76.8,68.8}}, color={0,0,127}));
        connect(gain1.y,min. u2) annotation (Line(points={{32.4,64},{40,64},{40,68.4},
                {48.8,68.4}}, color={0,0,127}));
        connect(Warm_Storage1.y, controlBus.Valve4) annotation (Line(points={{90.6,64},
                {94,64},{94,0},{40,0},{40,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(feedback.u1,min. u1) annotation (Line(points={{50,48},{40,48},{40,76},
                {48.8,75.6}}, color={0,0,127}));
        connect(Warm_Aircooler3.y,feedback. u2) annotation (Line(points={{36.6,86},{
                46,86},{46,56},{58,56}}, color={0,0,127}));
        connect(feedback.y,Warm_Storage1. u3) annotation (Line(points={{67,48},{70,48},
                {70,59.2},{76.8,59.2}}, color={0,0,127}));
        connect(Warm_Aircooler3.u_s, Warm_Aircooler1.u_s) annotation (Line(points={{
                22.8,86},{2,86},{2,64},{4.8,64}}, color={0,0,127}));
        connect(Warm_Aircooler3.u_m, measureBus.Aircooler) annotation (Line(points={{
                30,78.8},{30,72},{0.1,72},{0.1,100.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Valve_NoChpAndBoiler;
    end Controller_Generation;

    package Controller_Temp

      model PI_Regler_RLT
        Modelica.Blocks.Continuous.LimPID PID_RLT_Conferenceroom_Hot(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=400,
          k=0.01)
                 annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Openplanoffice_Hot(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          Ti=200)
                 annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Canteen_Hot(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01)
                 annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Multipersonoffice_Hot(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01)
                 annotation (Placement(transformation(extent={{20,80},{40,100}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Workshop_Hot(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          Ti=200)
                 annotation (Placement(transformation(extent={{20,40},{40,60}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Conferenceroom_Cold(
          yMax=0,
          yMin=-1,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=400,
          k=0.01)
                 annotation (Placement(transformation(extent={{-30,-80},{-10,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Openplanoffice_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          yMax=0,
          yMin=-1,
          Ti=200)
                 annotation (Placement(transformation(extent={{-80,-80},{-60,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Canteen_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=0,
          yMin=-1,
          Ti=200,
          k=0.01)
                 annotation (Placement(transformation(extent={{-80,-40},{-60,-60}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Multipersonoffice_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=0,
          yMin=-1,
          Ti=200,
          k=0.01)
                 annotation (Placement(transformation(extent={{20,-80},{40,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Workshop_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=0,
          yMin=-1,
          k=0.01,
          Ti=200)
                 annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
          annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 22)
          annotation (Placement(transformation(extent={{-136,-100},{-116,-80}})));
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{80,-20},{120,20}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Central_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=0,
          yMin=-1,
          Ti=100,
          k=0.1) annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
        Modelica.Blocks.Continuous.LimPID PID_RLT_Central_Hot(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=100,
          k=0.1) annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{-56,-54},{-48,-46}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
          annotation (Placement(transformation(extent={{-56,-94},{-48,-86}})));
        Modelica.Blocks.Math.Gain gain2(k=-1)
          annotation (Placement(transformation(extent={{-6,-54},{2,-46}})));
        Modelica.Blocks.Math.Gain gain3(k=-1)
          annotation (Placement(transformation(extent={{-6,-94},{2,-86}})));
        Modelica.Blocks.Math.Gain gain4(k=-1)
          annotation (Placement(transformation(extent={{44,-54},{52,-46}})));
        Modelica.Blocks.Math.Gain gain5(k=-1)
          annotation (Placement(transformation(extent={{44,-94},{52,-86}})));
        RLT_Switch Openplanoffice
          annotation (Placement(transformation(extent={{-62,4},{-42,24}})));
        RLT_Switch Canteen
          annotation (Placement(transformation(extent={{-20,4},{0,24}})));
        RLT_Switch Central
          annotation (Placement(transformation(extent={{16,4},{36,24}})));
        RLT_Switch Conferenceroom
          annotation (Placement(transformation(extent={{60,60},{80,80}})));
        RLT_Switch Multipersonoffice
          annotation (Placement(transformation(extent={{60,24},{80,44}})));
        RLT_Switch Workshop
          annotation (Placement(transformation(extent={{60,-44},{80,-24}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 18.5)
          annotation (Placement(transformation(extent={{-136,-44},{-116,-24}})));
        Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 16)
          annotation (Placement(transformation(extent={{-136,-64},{-116,-44}})));
        Modelica.Blocks.Sources.RealExpression realExpression5(y=273.15 + 14)
          annotation (Placement(transformation(extent={{-136,40},{-116,60}})));
        Modelica.Blocks.Sources.RealExpression realExpression6(y=273.15 + 18)
          annotation (Placement(transformation(extent={{-136,22},{-116,42}})));
      equation
        connect(realExpression2.y, PID_RLT_Openplanoffice_Hot.u_s)
          annotation (Line(points={{-119,90},{-82,90}}, color={0,0,127}));
        connect(PID_RLT_Conferenceroom_Hot.u_s, PID_RLT_Openplanoffice_Hot.u_s)
          annotation (Line(points={{-32,90},{-40,90},{-40,70},{-100,70},{-100,90},{-82,
                90}}, color={0,0,127}));
        connect(PID_RLT_Canteen_Hot.u_s, PID_RLT_Openplanoffice_Hot.u_s)
          annotation (Line(points={{-82,50},{-100,50},{-100,90},{-82,90}}, color={0,0,
                127}));
        connect(PID_RLT_Multipersonoffice_Hot.u_s, PID_RLT_Openplanoffice_Hot.u_s)
          annotation (Line(points={{18,90},{10,90},{10,70},{-100,70},{-100,90},{-82,90}},
              color={0,0,127}));
        connect(PID_RLT_Openplanoffice_Cold.u_s, realExpression3.y)
          annotation (Line(points={{-82,-90},{-115,-90}}, color={0,0,127}));
        connect(PID_RLT_Conferenceroom_Cold.u_s, realExpression3.y) annotation (Line(
              points={{-32,-90},{-42,-90},{-42,-70},{-100,-70},{-100,-90},{-115,-90}},
              color={0,0,127}));
        connect(PID_RLT_Multipersonoffice_Cold.u_s, realExpression3.y) annotation (
            Line(points={{18,-90},{10,-90},{10,-70},{-100,-70},{-100,-90},{-115,-90}},
              color={0,0,127}));
        connect(PID_RLT_Canteen_Cold.u_s, realExpression3.y) annotation (Line(points={{-82,-50},
                {-100,-50},{-100,-90},{-115,-90}},           color={0,0,127}));
        connect(PID_RLT_Canteen_Cold.y, gain.u)
          annotation (Line(points={{-59,-50},{-56.8,-50}}, color={0,0,127}));
        connect(PID_RLT_Openplanoffice_Cold.y, gain1.u)
          annotation (Line(points={{-59,-90},{-56.8,-90}}, color={0,0,127}));
        connect(PID_RLT_Central_Cold.y, gain2.u)
          annotation (Line(points={{-9,-50},{-6.8,-50}}, color={0,0,127}));
        connect(PID_RLT_Conferenceroom_Cold.y, gain3.u)
          annotation (Line(points={{-9,-90},{-6.8,-90}}, color={0,0,127}));
        connect(PID_RLT_Workshop_Cold.y, gain4.u)
          annotation (Line(points={{41,-50},{43.2,-50}}, color={0,0,127}));
        connect(PID_RLT_Multipersonoffice_Cold.y, gain5.u)
          annotation (Line(points={{41,-90},{43.2,-90}}, color={0,0,127}));
        connect(PID_RLT_Openplanoffice_Hot.y, Openplanoffice.hot)
          annotation (Line(points={{-59,90},{-52,90},{-52,24}}, color={0,0,127}));
        connect(gain1.y, Openplanoffice.cold) annotation (Line(points={{-47.6,-90},{
                -44,-90},{-44,-22},{-52,-22},{-52,4}}, color={0,0,127}));
        connect(PID_RLT_Canteen_Hot.y, Canteen.hot) annotation (Line(points={{-59,50},
                {-54,50},{-54,28},{-10,28},{-10,24}}, color={0,0,127}));
        connect(gain.y, Canteen.cold) annotation (Line(points={{-47.6,-50},{-44,-50},
                {-44,-22},{-10,-22},{-10,4}}, color={0,0,127}));
        connect(gain2.y, Central.cold) annotation (Line(points={{2.4,-50},{4,-50},{4,
                -22},{26,-22},{26,4}}, color={0,0,127}));
        connect(PID_RLT_Central_Hot.y, Central.hot) annotation (Line(points={{-9,50},
                {0,50},{0,28},{26,28},{26,24}}, color={0,0,127}));
        connect(PID_RLT_Conferenceroom_Hot.y, Conferenceroom.hot) annotation (Line(
              points={{-9,90},{0,90},{0,110},{70,110},{70,80}}, color={0,0,127}));
        connect(PID_RLT_Multipersonoffice_Hot.y, Multipersonoffice.hot) annotation (
            Line(points={{41,90},{50,90},{50,50},{70,50},{70,44}}, color={0,0,127}));
        connect(PID_RLT_Workshop_Hot.y, Workshop.hot) annotation (Line(points={{41,50},
                {50,50},{50,-18},{70,-18},{70,-24}}, color={0,0,127}));
        connect(gain4.y, Workshop.cold)
          annotation (Line(points={{52.4,-50},{70,-50},{70,-44}}, color={0,0,127}));
        connect(gain5.y, Multipersonoffice.cold) annotation (Line(points={{52.4,-90},
                {56,-90},{56,18},{70,18},{70,24}}, color={0,0,127}));
        connect(gain3.y, Conferenceroom.cold) annotation (Line(points={{2.4,-90},{4,
                -90},{4,-22},{50,-22},{50,56},{70,56},{70,60}}, color={0,0,127}));
        connect(Openplanoffice.Tempvalve_cold, controlBus.Valve_RLT_Cold_OpenPlanOffice)
          annotation (Line(points={{-41,11},{-34,11},{-34,0.1},{100.1,0.1}}, color={0,
                0,127}));
        connect(Openplanoffice.Tempvalve_Hot, controlBus.Valve_RLT_Hot_OpenPlanOffice)
          annotation (Line(points={{-41,17},{-34,17},{-34,0.1},{100.1,0.1}}, color={0,
                0,127}));
        connect(Canteen.Tempvalve_cold, controlBus.Valve_RLT_Cold_Canteen)
          annotation (Line(points={{1,11},{6,11},{6,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Canteen.Tempvalve_Hot, controlBus.Valve_RLT_Hot_Canteen) annotation (
            Line(points={{1,17},{6,17},{6,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Central.Tempvalve_cold, controlBus.Valve_RLT_Cold_Central)
          annotation (Line(points={{37,11},{42,11},{42,0.1},{100.1,0.1}}, color={0,0,
                127}));
        connect(Central.Tempvalve_Hot, controlBus.Valve_RLT_Hot_Central) annotation (
            Line(points={{37,17},{42,17},{42,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Multipersonoffice.Tempvalve_cold, controlBus.Valve_RLT_Cold_MultiPersonOffice)
          annotation (Line(points={{81,31},{100.1,31},{100.1,0.1}}, color={0,0,127}));
        connect(Multipersonoffice.Tempvalve_Hot, controlBus.Valve_RLT_Hot_MultiPersonOffice)
          annotation (Line(points={{81,37},{100.1,37},{100.1,0.1}}, color={0,0,127}));
        connect(Conferenceroom.Tempvalve_cold, controlBus.Valve_RLT_Cold_ConferenceRoom)
          annotation (Line(points={{81,67},{100.1,67},{100.1,0.1}}, color={0,0,127}));
        connect(Conferenceroom.Tempvalve_Hot, controlBus.Valve_RLT_Hot_ConferenceRoom)
          annotation (Line(points={{81,73},{100.1,73},{100.1,0.1}}, color={0,0,127}));
        connect(Workshop.Tempvalve_Hot, controlBus.Valve_RLT_Hot_Workshop)
          annotation (Line(points={{81,-31},{100.1,-31},{100.1,0.1}}, color={0,0,127}));
        connect(Workshop.Tempvalve_cold, controlBus.Valve_RLT_Cold_Workshop)
          annotation (Line(points={{81,-37},{100.1,-37},{100.1,0.1}}, color={0,0,127}));
        connect(realExpression1.y, PID_RLT_Central_Cold.u_s) annotation (Line(points=
                {{-115,-34},{-36,-34},{-36,-50},{-32,-50}}, color={0,0,127}));
        connect(realExpression4.y, PID_RLT_Workshop_Cold.u_s) annotation (Line(points=
               {{-115,-54},{-108,-54},{-108,-32},{12,-32},{12,-50},{18,-50}}, color={
                0,0,127}));
        connect(realExpression6.y, PID_RLT_Central_Hot.u_s) annotation (Line(points={
                {-115,32},{-44,32},{-44,50},{-32,50},{-32,50}}, color={0,0,127}));
        connect(realExpression5.y, PID_RLT_Workshop_Hot.u_s) annotation (Line(points=
                {{-115,50},{-108,50},{-108,30},{8,30},{8,50},{18,50}}, color={0,0,127}));
        connect(PID_RLT_Openplanoffice_Cold.u_m, measureBus.RoomTemp_Openplanoffice)
          annotation (Line(points={{-70,-78},{-70,-74},{-99.9,-74},{-99.9,0.1}},
              color={0,0,127}));
        connect(PID_RLT_Conferenceroom_Cold.u_m, measureBus.RoomTemp_Conferenceroom)
          annotation (Line(points={{-20,-78},{-20,-74},{-99.9,-74},{-99.9,0.1}},
              color={0,0,127}));
        connect(PID_RLT_Multipersonoffice_Cold.u_m, measureBus.RoomTemp_Multipersonoffice)
          annotation (Line(points={{30,-78},{30,-74},{-99.9,-74},{-99.9,0.1}}, color=
                {0,0,127}));
        connect(PID_RLT_Openplanoffice_Hot.u_m, measureBus.RoomTemp_Openplanoffice)
          annotation (Line(points={{-70,78},{-70,74},{-99.9,74},{-99.9,0.1}}, color={
                0,0,127}));
        connect(PID_RLT_Conferenceroom_Hot.u_m, measureBus.RoomTemp_Conferenceroom)
          annotation (Line(points={{-20,78},{-20,74},{-99.9,74},{-99.9,0.1}}, color={
                0,0,127}));
        connect(PID_RLT_Multipersonoffice_Hot.u_m, measureBus.RoomTemp_Multipersonoffice)
          annotation (Line(points={{30,78},{30,74},{-99.9,74},{-99.9,0.1}}, color={0,
                0,127}));
        connect(PID_RLT_Canteen_Hot.u_m, measureBus.RoomTemp_Canteen) annotation (
            Line(points={{-70,38},{-70,36},{-99.9,36},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_RLT_Central_Hot.u_m, measureBus.Air_RLT_Central_out) annotation (
            Line(points={{-20,38},{-20,38},{-20,36},{-99.9,36},{-99.9,0.1}}, color={0,
                0,127}));
        connect(PID_RLT_Workshop_Hot.u_m, measureBus.RoomTemp_Workshop) annotation (
            Line(points={{30,38},{30,34},{-100,34},{-100,18},{-99.9,18},{-99.9,0.1}},
                                                                  color={0,0,127}));
        connect(PID_RLT_Canteen_Cold.u_m, measureBus.RoomTemp_Canteen) annotation (
            Line(points={{-70,-38},{-70,-28},{-99.9,-28},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_RLT_Central_Cold.u_m, measureBus.Air_RLT_Central_out) annotation (
           Line(points={{-20,-38},{-20,-28},{-99.9,-28},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_RLT_Workshop_Cold.u_m, measureBus.RoomTemp_Workshop) annotation (
            Line(points={{30,-38},{30,-28},{-99.9,-28},{-99.9,0.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PI_Regler_RLT;

      model PID_Regler_TBA
        Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20) annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Openplanoffice_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20) annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Canteen_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20) annotation (Placement(transformation(extent={{20,80},{40,100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20) annotation (Placement(transformation(extent={{20,40},{40,60}})));
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20,
          yMax=0,
          yMin=-1)
                 annotation (Placement(transformation(extent={{-30,-80},{-10,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Openplanoffice_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20,
          yMax=0,
          yMin=-1)
                 annotation (Placement(transformation(extent={{-80,-80},{-60,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Canteen_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20,
          yMax=0,
          yMin=-1)
                 annotation (Placement(transformation(extent={{-80,-40},{-60,-60}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20,
          yMax=0,
          yMin=-1)
                 annotation (Placement(transformation(extent={{20,-80},{40,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20,
          yMax=0,
          yMin=-1)
                 annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{80,-20},{120,20}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 15)
          annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 15)
          annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
          annotation (Placement(transformation(extent={{-126,80},{-106,100}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 20)
          annotation (Placement(transformation(extent={{-126,-100},{-106,-80}})));
        Modelica.Blocks.Math.Gain gain2(k=-1)
          annotation (Placement(transformation(extent={{-4,-4},{4,4}},
              rotation=90,
              origin={-44,-40})));
        Modelica.Blocks.Math.Gain gain1(k=-1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=90,
              origin={-52,-80})));
        Modelica.Blocks.Math.Gain gain3(k=-1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=90,
              origin={-4,-80})));
        Modelica.Blocks.Math.Gain gain4(k=-1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=90,
              origin={50,-76})));
        Modelica.Blocks.Math.Gain gain5(k=-1)
          annotation (Placement(transformation(extent={{52,-54},{60,-46}})));
        TBA_Hysteresis Openplanoffice
          annotation (Placement(transformation(extent={{-60,4},{-40,24}})));
        TBA_Hysteresis Conferenceroom
          annotation (Placement(transformation(extent={{-24,4},{-4,24}})));
        TBA_Hysteresis Multipersonoffice
          annotation (Placement(transformation(extent={{10,4},{30,24}})));
        TBA_Hysteresis Workshop
          annotation (Placement(transformation(extent={{10,-24},{30,-4}})));
        TBA_Hysteresis Canteen
          annotation (Placement(transformation(extent={{-60,-24},{-40,-4}})));
      equation
        connect(PID_TBA_Openplanoffice_Warm.u_m, measureBus.RoomTemp_Openplanoffice)
          annotation (Line(points={{-70,78},{-70,70},{-99.9,70},{-99.9,0.1}}, color={
                0,0,127}));
        connect(PID_TBA_Openplanoffice_Cold.u_m, measureBus.RoomTemp_Openplanoffice)
          annotation (Line(points={{-70,-78},{-70,-70},{-99.9,-70},{-99.9,0.1}},
              color={0,0,127}));
        connect(PID_TBA_Canteen_Cold.u_m, measureBus.RoomTemp_Canteen) annotation (
            Line(points={{-70,-38},{-70,-30},{-99.9,-30},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_TBA_Canteen_Warm.u_m, measureBus.RoomTemp_Canteen) annotation (
            Line(points={{-70,38},{-70,30},{-99.9,30},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_TBA_Conferenceroom_Warm.u_m, measureBus.RoomTemp_Conferenceroom)
          annotation (Line(points={{-20,78},{-20,70},{-99.9,70},{-99.9,0.1}}, color={
                0,0,127}));
        connect(PID_TBA_Multipersonoffice_Warm.u_m, measureBus.RoomTemp_Multipersonoffice)
          annotation (Line(points={{30,78},{30,70},{-99.9,70},{-99.9,0.1}}, color={0,
                0,127}));
        connect(PID_TBA_Workshop_Warm.u_m, measureBus.RoomTemp_Workshop) annotation (
            Line(points={{30,38},{30,30},{-99.9,30},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_TBA_Workshop_Cold.u_m, measureBus.RoomTemp_Workshop) annotation (
            Line(points={{30,-38},{30,-30},{-99.9,-30},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_TBA_Conferenceroom_Cold.u_m, measureBus.RoomTemp_Conferenceroom)
          annotation (Line(points={{-20,-78},{-20,-78},{-20,-70},{-99.9,-70},{-99.9,
                0.1}}, color={0,0,127}));
        connect(PID_TBA_Multipersonoffice_Cold.u_m, measureBus.RoomTemp_Multipersonoffice)
          annotation (Line(points={{30,-78},{30,-70},{-99.9,-70},{-99.9,0.1}}, color=
                {0,0,127}));
        connect(realExpression1.y, PID_TBA_Workshop_Cold.u_s)
          annotation (Line(points={{-9,-50},{18,-50}}, color={0,0,127}));
        connect(realExpression.y, PID_TBA_Workshop_Warm.u_s)
          annotation (Line(points={{-9,50},{18,50}}, color={0,0,127}));
        connect(realExpression2.y, PID_TBA_Openplanoffice_Warm.u_s)
          annotation (Line(points={{-105,90},{-82,90}}, color={0,0,127}));
        connect(PID_TBA_Conferenceroom_Warm.u_s, PID_TBA_Openplanoffice_Warm.u_s)
          annotation (Line(points={{-32,90},{-40,90},{-40,70},{-100,70},{-100,90},{
                -82,90}}, color={0,0,127}));
        connect(PID_TBA_Canteen_Warm.u_s, PID_TBA_Openplanoffice_Warm.u_s)
          annotation (Line(points={{-82,50},{-100,50},{-100,90},{-82,90}}, color={0,0,
                127}));
        connect(PID_TBA_Multipersonoffice_Warm.u_s, PID_TBA_Openplanoffice_Warm.u_s)
          annotation (Line(points={{18,90},{10,90},{10,70},{-100,70},{-100,90},{-82,
                90}}, color={0,0,127}));
        connect(PID_TBA_Openplanoffice_Cold.u_s, realExpression3.y)
          annotation (Line(points={{-82,-90},{-105,-90}}, color={0,0,127}));
        connect(PID_TBA_Conferenceroom_Cold.u_s, realExpression3.y) annotation (Line(
              points={{-32,-90},{-42,-90},{-42,-70},{-100,-70},{-100,-90},{-105,-90}},
              color={0,0,127}));
        connect(PID_TBA_Multipersonoffice_Cold.u_s, realExpression3.y) annotation (
            Line(points={{18,-90},{8,-90},{8,-70},{-100,-70},{-100,-90},{-105,-90}},
              color={0,0,127}));
        connect(PID_TBA_Canteen_Cold.u_s, realExpression3.y) annotation (Line(points=
                {{-82,-50},{-100,-50},{-100,-90},{-105,-90}}, color={0,0,127}));
        connect(gain2.u, PID_TBA_Canteen_Cold.y) annotation (Line(points={{-44,-44.8},
                {-44,-44.8},{-44,-50},{-59,-50}},
                                                color={0,0,127}));
        connect(gain1.u, PID_TBA_Openplanoffice_Cold.y) annotation (Line(points={{-52,
                -84.8},{-52,-90},{-59,-90}}, color={0,0,127}));
        connect(gain3.u, PID_TBA_Conferenceroom_Cold.y)
          annotation (Line(points={{-4,-84.8},{-4,-90},{-9,-90}}, color={0,0,127}));
        connect(gain4.u, PID_TBA_Multipersonoffice_Cold.y)
          annotation (Line(points={{50,-80.8},{50,-90},{41,-90}}, color={0,0,127}));
        connect(gain5.u, PID_TBA_Workshop_Cold.y)
          annotation (Line(points={{51.2,-50},{41,-50}}, color={0,0,127}));
        connect(Openplanoffice.RoomTemp, measureBus.RoomTemp_Openplanoffice)
          annotation (Line(points={{-60,14},{-64,14},{-64,0.1},{-99.9,0.1}}, color={0,
                0,127}));
        connect(Openplanoffice.y_pump, controlBus.Pump_TBA_OpenPlanOffice_y)
          annotation (Line(points={{-60,10},{-64,10},{-64,0.1},{100.1,0.1}}, color={0,
                0,127}));
        connect(Openplanoffice.Cold, gain1.y) annotation (Line(points={{-48,4},{-48,0},
                {-70,0},{-70,-30},{-52,-30},{-52,-75.6}}, color={0,0,127}));
        connect(Openplanoffice.warm, PID_TBA_Openplanoffice_Warm.y)
          annotation (Line(points={{-48,24},{-48,90},{-59,90}}, color={0,0,127}));
        connect(Openplanoffice.WarmCold, controlBus.Valve_TBA_WarmCold_OpenPlanOffice_1)
          annotation (Line(points={{-39,11},{-34,11},{-34,0},{100,0}},       color={0,
                0,127}));
        connect(Openplanoffice.Tempvalve, controlBus.Valve_TBA_Cold_OpenPlanOffice_Temp)
          annotation (Line(points={{-39,17},{-34,17},{-34,0},{100,0}},       color={0,
                0,127}));
        connect(Conferenceroom.warm, PID_TBA_Conferenceroom_Warm.y) annotation (Line(
              points={{-12,24},{-12,30},{0,30},{0,90},{-9,90}}, color={0,0,127}));
        connect(Multipersonoffice.warm, PID_TBA_Multipersonoffice_Warm.y) annotation (
           Line(points={{22,24},{22,30},{50,30},{50,90},{41,90}}, color={0,0,127}));
        connect(Canteen.warm, PID_TBA_Canteen_Warm.y) annotation (Line(points={{-48,
                -4},{-48,-4},{-48,0},{-70,0},{-70,30},{-54,30},{-54,50},{-59,50}},
              color={0,0,127}));
        connect(PID_TBA_Workshop_Warm.y, Workshop.warm) annotation (Line(points={{41,
                50},{50,50},{50,0},{22,0},{22,-4}}, color={0,0,127}));
        connect(gain3.y, Conferenceroom.Cold) annotation (Line(points={{-4,-75.6},{-4,
                -30},{-12,-30},{-12,4}}, color={0,0,127}));
        connect(gain2.y, Canteen.Cold) annotation (Line(points={{-44,-35.6},{-44,-36},
                {-44,-36},{-44,-36},{-44,-30},{-48,-30},{-48,-24}}, color={0,0,127}));
        connect(gain5.y, Workshop.Cold) annotation (Line(points={{60.4,-50},{62,-50},
                {62,-28},{22,-28},{22,-24}}, color={0,0,127}));
        connect(gain4.y, Multipersonoffice.Cold) annotation (Line(points={{50,-71.6},
                {50,0},{22,0},{22,4},{22,4}}, color={0,0,127}));
        connect(Canteen.RoomTemp, measureBus.RoomTemp_Canteen) annotation (Line(
              points={{-60,-14},{-64,-14},{-64,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(Conferenceroom.RoomTemp, measureBus.RoomTemp_Conferenceroom)
          annotation (Line(points={{-24,14},{-28,14},{-28,0.1},{-99.9,0.1}}, color={0,
                0,127}));
        connect(Multipersonoffice.RoomTemp, measureBus.RoomTemp_Multipersonoffice)
          annotation (Line(points={{10,14},{4,14},{4,0.1},{-99.9,0.1}}, color={0,0,
                127}));
        connect(Workshop.RoomTemp, measureBus.RoomTemp_Workshop) annotation (Line(
              points={{10,-14},{4,-14},{4,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(Conferenceroom.y_pump, controlBus.Pump_TBA_ConferenceRoom_y)
          annotation (Line(points={{-24,10},{-28,10},{-28,0.1},{100.1,0.1}}, color={0,
                0,127}));
        connect(Multipersonoffice.y_pump, controlBus.Pump_TBA_MultiPersonOffice_y)
          annotation (Line(points={{10,10},{4,10},{4,0},{52,0},{52,0.1},{100.1,0.1}},
              color={0,0,127}));
        connect(Workshop.y_pump, controlBus.Pump_TBA_Workshop_y) annotation (Line(
              points={{10,-18},{4,-18},{4,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Canteen.y_pump, controlBus.Pump_TBA_Canteen_y) annotation (Line(
              points={{-60,-18},{-64,-18},{-64,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Canteen.Tempvalve, controlBus.Valve_TBA_Cold_Canteen_Temp)
          annotation (Line(points={{-39,-11},{-34,-11},{-34,0},{100,0}},       color=
                {0,0,127}));
        connect(Workshop.Tempvalve, controlBus.Valve_TBA_Cold_Workshop_Temp)
          annotation (Line(points={{31,-11},{36,-11},{36,0},{100,0}},       color={0,
                0,127}));
        connect(Multipersonoffice.Tempvalve, controlBus.Valve_TBA_Cold_MultiPersonOffice_Temp)
          annotation (Line(points={{31,17},{36,17},{36,0},{100,0}},       color={0,0,
                127}));
        connect(Conferenceroom.Tempvalve, controlBus.Valve_TBA_Cold_ConferenceRoom_Temp)
          annotation (Line(points={{-3,17},{0,17},{0,0},{100,0}},       color={0,0,
                127}));
        connect(Canteen.WarmCold, controlBus.Valve_TBA_WarmCold_canteen_1)
          annotation (Line(points={{-39,-17},{-34,-17},{-34,0},{100,0}},       color=
                {0,0,127}));
        connect(Conferenceroom.WarmCold, controlBus.Valve_TBA_WarmCold_conferenceroom_1)
          annotation (Line(points={{-3,11},{0,11},{0,0},{100,0}},       color={0,0,
                127}));
        connect(Multipersonoffice.WarmCold, controlBus.Valve_TBA_WarmCold_multipersonoffice_1)
          annotation (Line(points={{31,11},{36,11},{36,0},{100,0}},       color={0,0,
                127}));
        connect(Workshop.WarmCold, controlBus.Valve_TBA_WarmCold_workshop_1)
          annotation (Line(points={{31,-17},{36,-17},{36,0},{100,0}},       color={0,
                0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PID_Regler_TBA;

      model TBA_Hysteresis
        Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 19, uHigh=273.15
               + 21)
          annotation (Placement(transformation(extent={{-40,-8},{-24,8}})));
        Modelica.Blocks.Logical.Switch switch2
          annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
        Modelica.Blocks.Sources.RealExpression realExpression5(y=1)
          annotation (Placement(transformation(extent={{-44,-48},{-24,-28}})));
        Modelica.Blocks.Sources.RealExpression realExpression4(y=0)
          annotation (Placement(transformation(extent={{-44,-32},{-24,-12}})));
        Modelica.Blocks.Interfaces.RealInput RoomTemp
          annotation (Placement(transformation(extent={{-114,-14},{-86,14}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{40,20},{60,40}})));
        Modelica.Blocks.Interfaces.RealOutput WarmCold
          "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
        Modelica.Blocks.Interfaces.RealOutput Tempvalve
          "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealInput warm
          "Connector of first Real input signal" annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=-90,
              origin={20,100})));
        Modelica.Blocks.Interfaces.RealInput Cold
          "Connector of first Real input signal" annotation (Placement(transformation(
              extent={{14,-14},{-14,14}},
              rotation=-90,
              origin={20,-100})));
        Modelica.Blocks.Logical.Switch switch3
          annotation (Placement(transformation(extent={{0,40},{20,60}})));
        Modelica.Blocks.Interfaces.RealInput y_pump
          "Connector of Boolean input signal"
          annotation (Placement(transformation(extent={{-114,-54},{-86,-26}})));
        Modelica.Blocks.Logical.Switch switch4
          annotation (Placement(transformation(extent={{0,-74},{20,-54}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=0.2, uHigh=0.3)
          annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=0.2, uHigh=0.3)
          annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
      equation
        connect(hysteresis.u, RoomTemp) annotation (Line(points={{-41.6,0},{-70,0},{
                -70,1.77636e-015},{-100,1.77636e-015}}, color={0,0,127}));
        connect(realExpression4.y, switch2.u1)
          annotation (Line(points={{-23,-22},{38,-22}}, color={0,0,127}));
        connect(realExpression5.y, switch2.u3)
          annotation (Line(points={{-23,-38},{38,-38}}, color={0,0,127}));
        connect(hysteresis.y, switch2.u2) annotation (Line(points={{-23.2,0},{-12,0},
                {-12,-30},{38,-30}}, color={255,0,255}));
        connect(switch2.y, WarmCold)
          annotation (Line(points={{61,-30},{110,-30}}, color={0,0,127}));
        connect(switch1.y, Tempvalve)
          annotation (Line(points={{61,30},{110,30}}, color={0,0,127}));
        connect(warm, switch3.u1) annotation (Line(points={{20,100},{20,74},{-8,74},{
                -8,58},{-2,58}}, color={0,0,127}));
        connect(switch3.u3, switch2.u1) annotation (Line(points={{-2,42},{-2,42},{-8,
                42},{-8,-22},{-4,-22},{-4,-22},{38,-22}}, color={0,0,127}));
        connect(switch3.y, switch1.u1) annotation (Line(points={{21,50},{30,50},{30,
                38},{38,38}}, color={0,0,127}));
        connect(switch1.u2, switch2.u2) annotation (Line(points={{38,30},{-12,30},{
                -12,-30},{38,-30}}, color={255,0,255}));
        connect(Cold, switch4.u1) annotation (Line(points={{20,-100},{20,-80},{-12,
                -80},{-12,-56},{-2,-56}}, color={0,0,127}));
        connect(switch4.u3, switch2.u1) annotation (Line(points={{-2,-72},{-8,-72},{
                -8,-22},{38,-22}}, color={0,0,127}));
        connect(switch4.y, switch1.u3) annotation (Line(points={{21,-64},{30,-64},{30,
                22},{38,22}}, color={0,0,127}));
        connect(hysteresis1.y, switch3.u2)
          annotation (Line(points={{-29,50},{-2,50}}, color={255,0,255}));
        connect(hysteresis2.y, switch4.u2) annotation (Line(points={{-29,-70},{-16,
                -70},{-16,-64},{-2,-64}}, color={255,0,255}));
        connect(hysteresis2.u, y_pump) annotation (Line(points={{-52,-70},{-72,-70},{
                -72,-40},{-100,-40}}, color={0,0,127}));
        connect(hysteresis1.u, y_pump) annotation (Line(points={{-52,50},{-72,50},{
                -72,-40},{-100,-40}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end TBA_Hysteresis;

      model RLT_Switch
        Modelica.Blocks.Interfaces.RealOutput Tempvalve_Hot
          "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealInput hot
          "Connector of first Real input signal" annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=-90,
              origin={0,100})));
        Modelica.Blocks.Interfaces.RealOutput Tempvalve_cold
          "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
        Modelica.Blocks.Interfaces.RealInput cold
          "Connector of first Real input signal" annotation (Placement(transformation(
              extent={{14,-14},{-14,14}},
              rotation=-90,
              origin={0,-100})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder(T=10)
          annotation (Placement(transformation(extent={{50,20},{70,40}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=10)
          annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
      equation
        connect(Tempvalve_cold, Tempvalve_cold)
          annotation (Line(points={{110,-30},{110,-30}}, color={0,0,127}));
        connect(firstOrder.y, Tempvalve_Hot)
          annotation (Line(points={{71,30},{110,30}}, color={0,0,127}));
        connect(firstOrder1.y, Tempvalve_cold) annotation (Line(points={{71,-30},{88,
                -30},{88,-30},{110,-30}}, color={0,0,127}));
        connect(hot, firstOrder.u) annotation (Line(points={{0,100},{0,100},{0,30},{
                48,30}}, color={0,0,127}));
        connect(cold, firstOrder1.u) annotation (Line(points={{-1.77636e-015,-100},{
                -1.77636e-015,-30},{48,-30}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end RLT_Switch;

      model PI_Regler_TBA_v2
        Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01)
                 annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Openplanoffice_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=200)
                 annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Canteen_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=200)
                 annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=200)
                 annotation (Placement(transformation(extent={{20,80},{40,100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Warm(
          yMax=1,
          yMin=0,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=200)
                 annotation (Placement(transformation(extent={{20,40},{40,60}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=0,
          yMin=-1,
          Ti=200,
          k=0.01)
                 annotation (Placement(transformation(extent={{-30,-80},{-10,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Openplanoffice_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          Ti=20,
          yMax=0,
          yMin=-1)
                 annotation (Placement(transformation(extent={{-80,-80},{-60,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Canteen_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          yMax=0,
          yMin=-1,
          Ti=200)
                 annotation (Placement(transformation(extent={{-80,-40},{-60,-60}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          yMax=0,
          yMin=-1,
          Ti=200)
                 annotation (Placement(transformation(extent={{20,-80},{40,-100}})));
        Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Cold(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.1,
          yMax=0,
          yMin=-1,
          Ti=200)
                 annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 14)
          annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 16)
          annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
          annotation (Placement(transformation(extent={{-126,80},{-106,100}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 22)
          annotation (Placement(transformation(extent={{-126,-100},{-106,-80}})));
        Modelica.Blocks.Math.Gain gain2(k=-1)
          annotation (Placement(transformation(extent={{-4,-4},{4,4}},
              rotation=90,
              origin={-40,-40})));
        Modelica.Blocks.Math.Gain gain1(k=-1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=90,
              origin={-48,-80})));
        Modelica.Blocks.Math.Gain gain3(k=-1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=90,
              origin={-4,-80})));
        Modelica.Blocks.Math.Gain gain4(k=-1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=90,
              origin={50,-76})));
        Modelica.Blocks.Math.Gain gain5(k=-1)
          annotation (Placement(transformation(extent={{52,-54},{60,-46}})));
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{80,-20},{120,20}})));
        TBA_Hystersis_v2 Openplanoffice
          annotation (Placement(transformation(extent={{-60,6},{-40,26}})));
        TBA_Hystersis_v2 Conferenceroom
          annotation (Placement(transformation(extent={{-20,6},{0,26}})));
        TBA_Hystersis_v2 Multipersonoffice
          annotation (Placement(transformation(extent={{20,6},{40,26}})));
        TBA_Hystersis_v2 Canteen
          annotation (Placement(transformation(extent={{-40,-26},{-20,-6}})));
        TBA_Hystersis_v2 Workshop
          annotation (Placement(transformation(extent={{0,-26},{20,-6}})));
      equation
        connect(PID_TBA_Openplanoffice_Warm.u_m,measureBus. RoomTemp_Openplanoffice)
          annotation (Line(points={{-70,78},{-70,70},{-99.9,70},{-99.9,0.1}}, color={
                0,0,127}));
        connect(PID_TBA_Openplanoffice_Cold.u_m,measureBus. RoomTemp_Openplanoffice)
          annotation (Line(points={{-70,-78},{-70,-70},{-99.9,-70},{-99.9,0.1}},
              color={0,0,127}));
        connect(PID_TBA_Canteen_Cold.u_m,measureBus. RoomTemp_Canteen) annotation (
            Line(points={{-70,-38},{-70,-30},{-99.9,-30},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_TBA_Canteen_Warm.u_m,measureBus. RoomTemp_Canteen) annotation (
            Line(points={{-70,38},{-70,30},{-99.9,30},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_TBA_Conferenceroom_Warm.u_m,measureBus. RoomTemp_Conferenceroom)
          annotation (Line(points={{-20,78},{-20,70},{-99.9,70},{-99.9,0.1}}, color={
                0,0,127}));
        connect(PID_TBA_Multipersonoffice_Warm.u_m,measureBus. RoomTemp_Multipersonoffice)
          annotation (Line(points={{30,78},{30,70},{-99.9,70},{-99.9,0.1}}, color={0,
                0,127}));
        connect(PID_TBA_Workshop_Warm.u_m,measureBus. RoomTemp_Workshop) annotation (
            Line(points={{30,38},{30,30},{-99.9,30},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_TBA_Workshop_Cold.u_m,measureBus. RoomTemp_Workshop) annotation (
            Line(points={{30,-38},{30,-30},{-99.9,-30},{-99.9,0.1}}, color={0,0,127}));
        connect(PID_TBA_Conferenceroom_Cold.u_m,measureBus. RoomTemp_Conferenceroom)
          annotation (Line(points={{-20,-78},{-20,-78},{-20,-70},{-99.9,-70},{-99.9,
                0.1}}, color={0,0,127}));
        connect(PID_TBA_Multipersonoffice_Cold.u_m,measureBus. RoomTemp_Multipersonoffice)
          annotation (Line(points={{30,-78},{30,-70},{-99.9,-70},{-99.9,0.1}}, color=
                {0,0,127}));
        connect(realExpression1.y,PID_TBA_Workshop_Cold. u_s)
          annotation (Line(points={{-9,-50},{18,-50}}, color={0,0,127}));
        connect(realExpression.y,PID_TBA_Workshop_Warm. u_s)
          annotation (Line(points={{-9,50},{18,50}}, color={0,0,127}));
        connect(realExpression2.y,PID_TBA_Openplanoffice_Warm. u_s)
          annotation (Line(points={{-105,90},{-82,90}}, color={0,0,127}));
        connect(PID_TBA_Conferenceroom_Warm.u_s,PID_TBA_Openplanoffice_Warm. u_s)
          annotation (Line(points={{-32,90},{-40,90},{-40,70},{-100,70},{-100,90},{
                -82,90}}, color={0,0,127}));
        connect(PID_TBA_Canteen_Warm.u_s,PID_TBA_Openplanoffice_Warm. u_s)
          annotation (Line(points={{-82,50},{-100,50},{-100,90},{-82,90}}, color={0,0,
                127}));
        connect(PID_TBA_Multipersonoffice_Warm.u_s,PID_TBA_Openplanoffice_Warm. u_s)
          annotation (Line(points={{18,90},{10,90},{10,70},{-100,70},{-100,90},{-82,
                90}}, color={0,0,127}));
        connect(PID_TBA_Openplanoffice_Cold.u_s,realExpression3. y)
          annotation (Line(points={{-82,-90},{-105,-90}}, color={0,0,127}));
        connect(PID_TBA_Conferenceroom_Cold.u_s,realExpression3. y) annotation (Line(
              points={{-32,-90},{-42,-90},{-42,-70},{-100,-70},{-100,-90},{-105,-90}},
              color={0,0,127}));
        connect(PID_TBA_Multipersonoffice_Cold.u_s,realExpression3. y) annotation (
            Line(points={{18,-90},{8,-90},{8,-70},{-100,-70},{-100,-90},{-105,-90}},
              color={0,0,127}));
        connect(PID_TBA_Canteen_Cold.u_s,realExpression3. y) annotation (Line(points=
                {{-82,-50},{-100,-50},{-100,-90},{-105,-90}}, color={0,0,127}));
        connect(gain2.u,PID_TBA_Canteen_Cold. y) annotation (Line(points={{-40,-44.8},
                {-40,-44.8},{-40,-50},{-59,-50}},
                                                color={0,0,127}));
        connect(gain1.u,PID_TBA_Openplanoffice_Cold. y) annotation (Line(points={{-48,
                -84.8},{-48,-90},{-59,-90}}, color={0,0,127}));
        connect(gain3.u,PID_TBA_Conferenceroom_Cold. y)
          annotation (Line(points={{-4,-84.8},{-4,-90},{-9,-90}}, color={0,0,127}));
        connect(gain4.u,PID_TBA_Multipersonoffice_Cold. y)
          annotation (Line(points={{50,-80.8},{50,-90},{41,-90}}, color={0,0,127}));
        connect(gain5.u,PID_TBA_Workshop_Cold. y)
          annotation (Line(points={{51.2,-50},{41,-50}}, color={0,0,127}));
        connect(Openplanoffice.warm, PID_TBA_Openplanoffice_Warm.y)
          annotation (Line(points={{-48,26},{-48,90},{-59,90}}, color={0,0,127}));
        connect(Conferenceroom.warm, PID_TBA_Conferenceroom_Warm.y) annotation (Line(
              points={{-8,26},{-8,34},{0,34},{0,90},{-9,90}}, color={0,0,127}));
        connect(Multipersonoffice.warm, PID_TBA_Multipersonoffice_Warm.y) annotation (
           Line(points={{32,26},{32,34},{54,34},{54,90},{41,90}}, color={0,0,127}));
        connect(Canteen.warm, PID_TBA_Canteen_Warm.y) annotation (Line(points={{-28,
                -6},{-28,-2},{-34,-2},{-34,4},{-34,50},{-59,50}}, color={0,0,127}));
        connect(Workshop.warm, PID_TBA_Workshop_Warm.y) annotation (Line(points={{12,
                -6},{12,-2},{52,-2},{52,50},{41,50}}, color={0,0,127}));
        connect(Openplanoffice.Valve_Warm, controlBus.Valve_TBA_Warm_OpenPlanOffice)
          annotation (Line(points={{-39,19},{-36,19},{-36,0.1},{100.1,0.1}}, color={0,
                0,127}));
        connect(Conferenceroom.Valve_Warm, controlBus.Valve_TBA_Warm_conferenceroom)
          annotation (Line(points={{1,19},{6,19},{6,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Multipersonoffice.Valve_Warm, controlBus.Valve_TBA_Warm_multipersonoffice)
          annotation (Line(points={{41,19},{46,19},{46,0.1},{100.1,0.1}}, color={0,0,
                127}));
        connect(Canteen.Valve_Warm, controlBus.Valve_TBA_Warm_canteen) annotation (
            Line(points={{-19,-13},{-16,-13},{-16,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Workshop.Valve_Warm, controlBus.Valve_TBA_Warm_workshop) annotation (
            Line(points={{21,-13},{28,-13},{28,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Openplanoffice.Valve_Temp, controlBus.Valve_TBA_OpenPlanOffice_Temp)
          annotation (Line(points={{-39,13},{-36,13},{-36,0.1},{100.1,0.1}}, color={0,
                0,127}));
        connect(Conferenceroom.Valve_Temp, controlBus.Valve_TBA_ConferenceRoom_Temp)
          annotation (Line(points={{1,13},{6,13},{6,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Multipersonoffice.Valve_Temp, controlBus.Valve_TBA_MultiPersonOffice_Temp)
          annotation (Line(points={{41,13},{46,13},{46,0.1},{100.1,0.1}}, color={0,0,
                127}));
        connect(Canteen.Valve_Temp, controlBus.Valve_TBA_Canteen_Temp) annotation (
            Line(points={{-19,-19},{-16,-19},{-16,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(Workshop.Valve_Temp, controlBus.Valve_TBA_Workshop_Temp) annotation (
            Line(points={{21,-19},{28,-19},{28,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(gain2.y, Canteen.Cold) annotation (Line(points={{-40,-35.6},{-40,-34},
                {-28,-34},{-28,-26}}, color={0,0,127}));
        connect(Openplanoffice.Cold, gain1.y)
          annotation (Line(points={{-48,6},{-48,-75.6}}, color={0,0,127}));
        connect(Conferenceroom.Cold, gain3.y) annotation (Line(points={{-8,6},{-6,6},
                {-6,-75.6},{-4,-75.6}}, color={0,0,127}));
        connect(Multipersonoffice.Cold, gain4.y) annotation (Line(points={{32,6},{32,
                -4},{50,-4},{50,-71.6}}, color={0,0,127}));
        connect(Workshop.Cold, gain5.y) annotation (Line(points={{12,-26},{38,-26},{
                38,-26},{64,-26},{64,-50},{60.4,-50}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PI_Regler_TBA_v2;

      model TBA_Hystersis_v2
        Modelica.Blocks.Interfaces.RealOutput Valve_Warm
          "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealInput warm
          "Connector of first Real input signal" annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=-90,
              origin={20,100})));
        Modelica.Blocks.Interfaces.RealInput Cold
          "Connector of first Real input signal" annotation (Placement(transformation(
              extent={{14,-14},{-14,14}},
              rotation=-90,
              origin={20,-100})));
        Modelica.Blocks.Interfaces.RealOutput Valve_Temp
          "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
      equation
        connect(warm, Valve_Warm) annotation (Line(points={{20,100},{20,100},{20,30},
                {110,30}}, color={0,0,127}));
        connect(Cold, Valve_Temp)
          annotation (Line(points={{20,-100},{20,-30},{110,-30}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end TBA_Hystersis_v2;
    end Controller_Temp;

    package Controller_PumpsAndFans

      model Pump_Basis
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Sources.RealExpression Senken(y=1)
          annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));
        Modelica.Blocks.Sources.RealExpression Verteiler(y=1)
          annotation (Placement(transformation(extent={{-60,-42},{-40,-22}})));
        Modelica.Blocks.Continuous.LimPID Aircooler(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01,
          yMax=0,
          yMin=-1) annotation (Placement(transformation(extent={{-68,28},{-56,40}})));
        Modelica.Blocks.Sources.RealExpression Heatpump1(y=273.15 + 9)
          annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
          annotation (Placement(transformation(extent={{-48,30},{-40,38}})));
        Modelica.Blocks.Sources.RealExpression Heatpump2(y=0.1)
          annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));
        Modelica.Blocks.Math.Max max
          annotation (Placement(transformation(extent={{-28,18},{-8,38}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{-64,56},{-52,68}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-26,52},{-6,72}})));
        Modelica.Blocks.Sources.RealExpression Verteiler1(
                                                         y=1)
          annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
        Modelica.Blocks.Sources.RealExpression Verteiler2(y=0.1)
          annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
        Modelica.Blocks.Logical.Switch switch2
          annotation (Placement(transformation(extent={{-26,-14},{-6,6}})));
        Modelica.Blocks.Logical.Or or2
          annotation (Placement(transformation(extent={{-56,-10},{-44,2}})));
        Modelica.Blocks.Logical.Switch switch3
          annotation (Placement(transformation(extent={{48,34},{68,54}})));
        Modelica.Blocks.Sources.RealExpression Heatpump3(y=1)
          annotation (Placement(transformation(extent={{8,60},{28,80}})));
      equation
        connect(Senken.y, controlBus.Pump_RLT_Central_hot_y) annotation (Line(points=
                {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_ConferenceRoom_hot_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y) annotation (
            Line(points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(points=
                {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Workshop_hot_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Central_cold_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_ConferenceRoom_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y) annotation (
            Line(points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Canteen_cold_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Workshop_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points={{
                -39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points={{
                -39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Hotwater_y) annotation (Line(points={{
                -39,-32},{-20,-32},{-20,-32},{0.1,-32},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Warmwater_y) annotation (Line(points={{
                -39,-32},{0,-32},{0,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Coldwater_y) annotation (Line(points={{
                -39,-32},{0.1,-32},{0.1,-99.9}}, color={0,0,127}));
        connect(Heatpump1.y, Aircooler.u_s)
          annotation (Line(points={{-79,34},{-69.2,34}}, color={0,0,127}));
        connect(Aircooler.y, gain1.u)
          annotation (Line(points={{-55.4,34},{-48.8,34}}, color={0,0,127}));
        connect(gain1.y, max.u1)
          annotation (Line(points={{-39.6,34},{-30,34}}, color={0,0,127}));
        connect(Heatpump2.y, max.u2) annotation (Line(points={{-69,8},{-49.5,8},{
                -49.5,22},{-30,22}}, color={0,0,127}));
        connect(or1.y, switch1.u2)
          annotation (Line(points={{-51.4,62},{-28,62}}, color={255,0,255}));
        connect(switch1.y, controlBus.Pump_Coldwater_heatpump_y)
          annotation (Line(points={{-5,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler1.y, switch1.u1) annotation (Line(points={{-79,76},{-38,76},
                {-38,70},{-28,70}}, color={0,0,127}));
        connect(Verteiler2.y, switch1.u3) annotation (Line(points={{-79,48},{-40,48},
                {-40,54},{-28,54}}, color={0,0,127}));
        connect(or2.y, switch2.u2)
          annotation (Line(points={{-43.4,-4},{-28,-4}}, color={255,0,255}));
        connect(or2.u1, controlBus.OnOff_CHP) annotation (Line(points={{-57.2,-4},{
                -72,-4},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(or2.u2, controlBus.OnOff_boiler) annotation (Line(points={{-57.2,-8.8},
                {-72,-8.8},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(switch2.u1, switch1.u1) annotation (Line(points={{-28,4},{-32,4},{
                -32,70},{-28,70}},
                               color={0,0,127}));
        connect(switch2.u3, switch1.u3) annotation (Line(points={{-28,-12},{-40,-12},
                {-40,54},{-28,54}}, color={0,0,127}));
        connect(switch2.y, controlBus.Pump_Hotwater_CHP_y)
          annotation (Line(points={{-5,-4},{0.1,-4},{0.1,-99.9}}, color={0,0,127}));
        connect(switch2.y, controlBus.Pump_Hotwater_Boiler_y)
          annotation (Line(points={{-5,-4},{0.1,-4},{0.1,-99.9}}, color={0,0,127}));
        connect(Aircooler.u_m, measureBus.Aircooler) annotation (Line(points={{-62,
                26.8},{-62,22},{-72,22},{-72,80},{0.1,80},{0.1,100.1}}, color={0,0,
                127}));
        connect(or1.u2, controlBus.OnOff_heatpump_1) annotation (Line(points={{
                -65.2,57.2},{-72,57.2},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(or1.u1, controlBus.OnOff_heatpump_2) annotation (Line(points={{
                -65.2,62},{-72,62},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(switch1.y, controlBus.Pump_Warmwater_heatpump_1_y) annotation (Line(
              points={{-5,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
        connect(switch1.y, controlBus.Pump_Warmwater_heatpump_2_y) annotation (Line(
              points={{-5,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
        connect(switch3.u3, max.y) annotation (Line(points={{46,36},{36,36},{36,28},
                {-7,28}}, color={0,0,127}));
        connect(Heatpump3.y, switch3.u1) annotation (Line(points={{29,70},{36,70},{
                36,52},{46,52}}, color={0,0,127}));
        connect(switch3.y, controlBus.Pump_Aircooler_y) annotation (Line(points={{
                69,44},{78,44},{78,12},{0.1,12},{0.1,-99.9}}, color={0,0,127}));
        connect(switch3.u2, controlBus.OnOff_Aircooler_small) annotation (Line(
              points={{46,44},{0.1,44},{0.1,-99.9}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Pump_Basis;

      model Fan_Basis
        Modelica.Blocks.Math.IntegerToReal integerToReal
          annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
        Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds1(
            smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
              1; 6,1; 22,1])
          annotation (Placement(transformation(extent={{-58,-60},{-38,-40}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 30, uHigh=
              273.15 + 47)
          annotation (Placement(transformation(extent={{-74,54},{-54,74}})));
        Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.5)
          annotation (Placement(transformation(extent={{-28,-60},{-8,-40}})));
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Logical.And and1
          annotation (Placement(transformation(extent={{-26,48},{-6,68}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=0.01, uHigh=0.1)
          annotation (Placement(transformation(extent={{-92,30},{-72,50}})));
        Modelica.Blocks.Logical.Not not1
          annotation (Placement(transformation(extent={{-58,30},{-38,50}})));
        Modelica.Blocks.Logical.And and2
          annotation (Placement(transformation(extent={{-28,0},{-8,20}})));
        Modelica.Blocks.Logical.Not not2
          annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 20, uHigh=
              273.15 + 35)
          annotation (Placement(transformation(extent={{-76,6},{-56,26}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=0.3, uHigh=0.4)
          annotation (Placement(transformation(extent={{-94,-18},{-74,2}})));
        Modelica.Blocks.Continuous.LimPID Aircooler(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01,
          yMax=0,
          yMin=-1) annotation (Placement(transformation(extent={{44,52},{32,64}})));
        Modelica.Blocks.Sources.RealExpression Heatpump1(y=273.15 + 35)
          annotation (Placement(transformation(extent={{74,48},{54,68}})));
        Modelica.Blocks.Continuous.LimPID Aircooler1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01,
          yMax=0,
          yMin=-1) annotation (Placement(transformation(extent={{44,4},{32,16}})));
        Modelica.Blocks.Sources.RealExpression Heatpump2(y=273.15 + 25)
          annotation (Placement(transformation(extent={{74,0},{54,20}})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{20,52},{8,64}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
          annotation (Placement(transformation(extent={{20,4},{8,16}})));
      equation
        connect(integerToReal.u,measureBus. Hour) annotation (Line(points={{-92,-50},
                {-100,-50},{-100,80},{0.1,80},{0.1,100.1}}, color={255,127,0}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(integerToReal.y,combiTable1Ds1. u)
          annotation (Line(points={{-69,-50},{-60,-50}}, color={0,0,127}));
        connect(combiTable1Ds1.y[1],realToBoolean. u)
          annotation (Line(points={{-37,-50},{-30,-50}}, color={0,0,127}));
        connect(realToBoolean.y,controlBus. OnOff_RLT) annotation (Line(points={{-7,
                -50},{0.1,-50},{0.1,-99.9}}, color={255,0,255}));
        connect(hysteresis1.u, controlBus.Valve4) annotation (Line(points={{-94,40},
                {-100,40},{-100,-99.9},{0.1,-99.9}},color={0,0,127}));
        connect(hysteresis1.y, not1.u)
          annotation (Line(points={{-71,40},{-60,40}},
                                                     color={255,0,255}));
        connect(not1.y, and1.u2) annotation (Line(points={{-37,40},{-28,40},{-28,50}},
                           color={255,0,255}));
        connect(hysteresis.y, and1.u1) annotation (Line(points={{-53,64},{-28,64},{
                -28,58}},                            color={255,0,255}));
        connect(hysteresis2.y, and2.u1) annotation (Line(points={{-55,16},{-44,16},
                {-44,10},{-30,10}}, color={255,0,255}));
        connect(not2.y, and2.u2) annotation (Line(points={{-39,-8},{-34,-8},{-34,2},
                {-30,2}}, color={255,0,255}));
        connect(hysteresis3.y, not2.u)
          annotation (Line(points={{-73,-8},{-62,-8}}, color={255,0,255}));
        connect(hysteresis3.u, controlBus.Valve4) annotation (Line(points={{-96,-8},
                {-100,-8},{-100,-100},{0.1,-99.9}}, color={0,0,127}));
        connect(and2.y, controlBus.OnOff_Aircooler_small) annotation (Line(points={
                {-7,10},{0.1,10},{0.1,-99.9}}, color={255,0,255}));
        connect(and1.y, controlBus.OnOff_Aircooler_big) annotation (Line(points={{
                -5,58},{0.1,58},{0.1,-99.9}}, color={255,0,255}));
        connect(Aircooler.u_s, Heatpump1.y)
          annotation (Line(points={{45.2,58},{53,58}}, color={0,0,127}));
        connect(Aircooler1.u_s, Heatpump2.y)
          annotation (Line(points={{45.2,10},{53,10}}, color={0,0,127}));
        connect(Aircooler.u_m, measureBus.Aircooler) annotation (Line(points={{38,
                50.8},{38,42},{0.1,42},{0.1,100.1}}, color={0,0,127}));
        connect(Aircooler1.u_m, measureBus.Aircooler) annotation (Line(points={{38,
                2.8},{38,-6},{0.1,-6},{0.1,100.1}}, color={0,0,127}));
        connect(Aircooler.y, gain.u)
          annotation (Line(points={{31.4,58},{21.2,58}}, color={0,0,127}));
        connect(gain.y, controlBus.Fan_Aircooler_big) annotation (Line(points={{7.4,
                58},{0.1,58},{0.1,-99.9}}, color={0,0,127}));
        connect(gain1.u, Aircooler1.y)
          annotation (Line(points={{21.2,10},{31.4,10}}, color={0,0,127}));
        connect(gain1.y, controlBus.Fan_Aircooler_small) annotation (Line(points={{
                7.4,10},{0.1,10},{0.1,-99.9}}, color={0,0,127}));
        connect(hysteresis.u, measureBus.Aircooler_in) annotation (Line(points={{
                -76,64},{-100,64},{-100,80},{0.1,80},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis2.u, measureBus.Aircooler_in) annotation (Line(points={{
                -78,16},{-100,16},{-100,80},{0.1,80},{0.1,100.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Fan_Basis;

      model Fan_VariablePowerCost
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Math.IntegerToReal integerToReal
          annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
        Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds1(table=[0,0; 6,1; 22,0],
            smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
          annotation (Placement(transformation(extent={{-58,-60},{-38,-40}})));
        Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.5)
          annotation (Placement(transformation(extent={{-28,-60},{-8,-40}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 30, uHigh=
              273.15 + 47)
          annotation (Placement(transformation(extent={{-74,54},{-54,74}})));
        Modelica.Blocks.Logical.And and1
          annotation (Placement(transformation(extent={{-26,48},{-6,68}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=0.01, uHigh=0.1)
          annotation (Placement(transformation(extent={{-92,30},{-72,50}})));
        Modelica.Blocks.Logical.Not not1
          annotation (Placement(transformation(extent={{-58,30},{-38,50}})));
        Modelica.Blocks.Logical.And and2
          annotation (Placement(transformation(extent={{-28,0},{-8,20}})));
        Modelica.Blocks.Logical.Not not2
          annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=273.15 + 20, uHigh=
              273.15 + 35)
          annotation (Placement(transformation(extent={{-76,6},{-56,26}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=0.3, uHigh=0.4)
          annotation (Placement(transformation(extent={{-94,-18},{-74,2}})));
        Modelica.Blocks.Continuous.LimPID Aircooler(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01,
          yMax=0,
          yMin=-1) annotation (Placement(transformation(extent={{44,52},{32,64}})));
        Modelica.Blocks.Sources.RealExpression Heatpump1(y=273.15 + 35)
          annotation (Placement(transformation(extent={{74,48},{54,68}})));
        Modelica.Blocks.Continuous.LimPID Aircooler1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01,
          yMax=0,
          yMin=-1) annotation (Placement(transformation(extent={{44,4},{32,16}})));
        Modelica.Blocks.Sources.RealExpression Heatpump2(y=273.15 + 25)
          annotation (Placement(transformation(extent={{74,0},{54,20}})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{20,52},{8,64}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
          annotation (Placement(transformation(extent={{20,4},{8,16}})));
      equation
        connect(integerToReal.u, measureBus.Hour) annotation (Line(points={{-92,-50},
                {-100,-50},{-100,80},{0.1,80},{0.1,100.1}}, color={255,127,0}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(integerToReal.y, combiTable1Ds1.u)
          annotation (Line(points={{-69,-50},{-60,-50}}, color={0,0,127}));
        connect(combiTable1Ds1.y[1], realToBoolean.u)
          annotation (Line(points={{-37,-50},{-30,-50}}, color={0,0,127}));
        connect(realToBoolean.y, controlBus.OnOff_RLT) annotation (Line(points={{-7,
                -50},{0.1,-50},{0.1,-99.9}}, color={255,0,255}));
        connect(hysteresis1.u, controlBus.Valve4) annotation (Line(points={{-94,40},
                {-100,40},{-100,-99.9},{0.1,-99.9}},color={0,0,127}));
        connect(hysteresis1.y,not1. u)
          annotation (Line(points={{-71,40},{-60,40}},
                                                     color={255,0,255}));
        connect(not1.y,and1. u2) annotation (Line(points={{-37,40},{-28,40},{-28,50}},
                           color={255,0,255}));
        connect(hysteresis.y,and1. u1) annotation (Line(points={{-53,64},{-28,64},{
                -28,58}},                            color={255,0,255}));
        connect(hysteresis2.y,and2. u1) annotation (Line(points={{-55,16},{-44,16},
                {-44,10},{-30,10}}, color={255,0,255}));
        connect(not2.y,and2. u2) annotation (Line(points={{-39,-8},{-34,-8},{-34,2},
                {-30,2}}, color={255,0,255}));
        connect(hysteresis3.y,not2. u)
          annotation (Line(points={{-73,-8},{-62,-8}}, color={255,0,255}));
        connect(hysteresis3.u, controlBus.Valve4) annotation (Line(points={{-96,-8},
                {-100,-8},{-100,-100},{0.1,-99.9}}, color={0,0,127}));
        connect(and2.y, controlBus.OnOff_Aircooler_small) annotation (Line(points={
                {-7,10},{0.1,10},{0.1,-99.9}}, color={255,0,255}));
        connect(and1.y, controlBus.OnOff_Aircooler_big) annotation (Line(points={{
                -5,58},{0.1,58},{0.1,-99.9}}, color={255,0,255}));
        connect(Aircooler.u_s,Heatpump1. y)
          annotation (Line(points={{45.2,58},{53,58}}, color={0,0,127}));
        connect(Aircooler1.u_s,Heatpump2. y)
          annotation (Line(points={{45.2,10},{53,10}}, color={0,0,127}));
        connect(Aircooler.u_m, measureBus.Aircooler) annotation (Line(points={{38,
                50.8},{38,42},{0.1,42},{0.1,100.1}}, color={0,0,127}));
        connect(Aircooler1.u_m, measureBus.Aircooler) annotation (Line(points={{38,
                2.8},{38,-6},{0.1,-6},{0.1,100.1}}, color={0,0,127}));
        connect(Aircooler.y,gain. u)
          annotation (Line(points={{31.4,58},{21.2,58}}, color={0,0,127}));
        connect(gain.y, controlBus.Fan_Aircooler_big) annotation (Line(points={{7.4,
                58},{0.1,58},{0.1,-99.9}}, color={0,0,127}));
        connect(gain1.u,Aircooler1. y)
          annotation (Line(points={{21.2,10},{31.4,10}}, color={0,0,127}));
        connect(gain1.y, controlBus.Fan_Aircooler_small) annotation (Line(points={{
                7.4,10},{0.1,10},{0.1,-99.9}}, color={0,0,127}));
        connect(hysteresis.u, measureBus.Aircooler_in) annotation (Line(points={{
                -76,64},{-100,64},{-100,80},{0.1,80},{0.1,100.1}}, color={0,0,127}));
        connect(hysteresis2.u, measureBus.Aircooler_in) annotation (Line(points={{
                -78,16},{-100,16},{-100,80},{0.1,80},{0.1,100.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Fan_VariablePowerCost;

      model Pump_VariablePowerCost
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Continuous.LimPID Aircooler(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01,
          yMax=0,
          yMin=-1) annotation (Placement(transformation(extent={{-68,28},{-56,40}})));
        Modelica.Blocks.Sources.RealExpression Heatpump1(y=273.15 + 9)
          annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
          annotation (Placement(transformation(extent={{-48,30},{-40,38}})));
        Modelica.Blocks.Sources.RealExpression Heatpump2(y=0.1)
          annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));
        Modelica.Blocks.Math.Max max
          annotation (Placement(transformation(extent={{-28,18},{-8,38}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{-64,56},{-52,68}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-24,52},{-4,72}})));
        Modelica.Blocks.Sources.RealExpression Generatoren(y=1)
          annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
        Modelica.Blocks.Sources.RealExpression Generatoren1(y=0.1)
          annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
        Modelica.Blocks.Logical.Switch switch2
          annotation (Placement(transformation(extent={{-26,-14},{-6,6}})));
        Modelica.Blocks.Logical.Or or2
          annotation (Placement(transformation(extent={{-56,-10},{-44,2}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=1)
          annotation (Placement(transformation(extent={{-148,-54},{-128,-34}})));
        Modelica.Blocks.Sources.RealExpression realExpression2(y=0)
          annotation (Placement(transformation(extent={{-148,-94},{-128,-74}})));
        Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
             6)  annotation (Placement(transformation(extent={{-170,-62},{-158,-50}})));
        Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=22)
          annotation (Placement(transformation(extent={{-170,-80},{-158,-68}})));
        Modelica.Blocks.Math.IntegerToReal integerToReal
          annotation (Placement(transformation(extent={{-206,-74},{-186,-54}})));
        Modelica.Blocks.Logical.And and2
          annotation (Placement(transformation(extent={{-144,-70},{-130,-56}})));
        Modelica.Blocks.Logical.Switch Pump_RLT_Pump_VerteilerHot
          annotation (Placement(transformation(extent={{-102,-74},{-82,-54}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(
                                                              y=1)
          annotation (Placement(transformation(extent={{-146,-110},{-126,-90}})));
        Modelica.Blocks.Sources.RealExpression realExpression3(y=0.5)
          annotation (Placement(transformation(extent={{-146,-150},{-126,-130}})));
        Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold=
             6)  annotation (Placement(transformation(extent={{-168,-118},{-156,
                  -106}})));
        Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold1(threshold=22)
          annotation (Placement(transformation(extent={{-168,-136},{-156,-124}})));
        Modelica.Blocks.Math.IntegerToReal integerToReal1
          annotation (Placement(transformation(extent={{-204,-130},{-184,-110}})));
        Modelica.Blocks.Logical.And and1
          annotation (Placement(transformation(extent={{-142,-126},{-128,-112}})));
        Modelica.Blocks.Logical.Switch Pump_Verteiler
          annotation (Placement(transformation(extent={{-100,-130},{-80,-110}})));
        Modelica.Blocks.Sources.RealExpression Pump_TBA(y=1)
          annotation (Placement(transformation(extent={{-50,-46},{-30,-26}})));
        Modelica.Blocks.Logical.Switch switch3
          annotation (Placement(transformation(extent={{48,34},{68,54}})));
        Modelica.Blocks.Sources.RealExpression Heatpump3(y=1)
          annotation (Placement(transformation(extent={{8,60},{28,80}})));
      equation
        connect(Heatpump1.y, Aircooler.u_s)
          annotation (Line(points={{-79,34},{-69.2,34}}, color={0,0,127}));
        connect(Aircooler.y, gain1.u)
          annotation (Line(points={{-55.4,34},{-48.8,34}}, color={0,0,127}));
        connect(gain1.y, max.u1)
          annotation (Line(points={{-39.6,34},{-30,34}}, color={0,0,127}));
        connect(Heatpump2.y, max.u2) annotation (Line(points={{-69,8},{-49.5,8},{
                -49.5,22},{-30,22}}, color={0,0,127}));
        connect(or1.y, switch1.u2)
          annotation (Line(points={{-51.4,62},{-26,62}}, color={255,0,255}));
        connect(switch1.y, controlBus.Pump_Coldwater_heatpump_y)
          annotation (Line(points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
        connect(Generatoren.y, switch1.u1) annotation (Line(points={{-79,76},{-38,
                76},{-38,70},{-26,70}}, color={0,0,127}));
        connect(Generatoren1.y, switch1.u3) annotation (Line(points={{-79,48},{-40,
                48},{-40,54},{-26,54}}, color={0,0,127}));
        connect(or2.y, switch2.u2)
          annotation (Line(points={{-43.4,-4},{-28,-4}}, color={255,0,255}));
        connect(or2.u1, controlBus.OnOff_CHP) annotation (Line(points={{-57.2,-4},{
                -72,-4},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(or2.u2, controlBus.OnOff_boiler) annotation (Line(points={{-57.2,-8.8},
                {-72,-8.8},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(switch2.u1, switch1.u1) annotation (Line(points={{-28,4},{-32,4},{-32,
                70},{-26,70}}, color={0,0,127}));
        connect(switch2.u3, switch1.u3) annotation (Line(points={{-28,-12},{-40,-12},
                {-40,54},{-26,54}}, color={0,0,127}));
        connect(switch2.y, controlBus.Pump_Hotwater_CHP_y)
          annotation (Line(points={{-5,-4},{0.1,-4},{0.1,-99.9}}, color={0,0,127}));
        connect(switch2.y, controlBus.Pump_Hotwater_Boiler_y)
          annotation (Line(points={{-5,-4},{0.1,-4},{0.1,-99.9}}, color={0,0,127}));
        connect(integerToReal.y,greaterEqualThreshold. u) annotation (Line(points={{-185,
                -64},{-179.8,-64},{-179.8,-56},{-171.2,-56}},
                                                           color={0,0,127}));
        connect(lessEqualThreshold.u, integerToReal.y) annotation (Line(points={{
                -171.2,-74},{-180,-74},{-180,-64},{-185,-64}}, color={0,0,127}));
        connect(integerToReal.u, measureBus.Hour) annotation (Line(points={{-208,
                -64},{-218,-64},{-218,90},{0.1,90},{0.1,100.1}}, color={255,127,0}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(lessEqualThreshold.y, and2.u2) annotation (Line(points={{-157.4,-74},
                {-152,-74},{-152,-68.6},{-145.4,-68.6}}, color={255,0,255}));
        connect(greaterEqualThreshold.y, and2.u1) annotation (Line(points={{-157.4,
                -56},{-152,-56},{-152,-63},{-145.4,-63}}, color={255,0,255}));
        connect(and2.y, Pump_RLT_Pump_VerteilerHot.u2) annotation (Line(points={{
                -129.3,-63},{-116.65,-63},{-116.65,-64},{-104,-64}}, color={255,0,
                255}));
        connect(realExpression.y, Pump_RLT_Pump_VerteilerHot.u1) annotation (Line(
              points={{-127,-44},{-114,-44},{-114,-56},{-104,-56}}, color={0,0,127}));
        connect(realExpression2.y, Pump_RLT_Pump_VerteilerHot.u3) annotation (Line(
              points={{-127,-84},{-116,-84},{-116,-72},{-104,-72}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Central_hot_y)
          annotation (Line(points={{-81,-64},{0,-64},{0,-99.9},{0.1,-99.9}}, color=
                {0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_ConferenceRoom_hot_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Canteen_hot_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Workshop_hot_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Central_cold_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_ConferenceRoom_cold_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Canteen_cold_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Workshop_cold_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(integerToReal1.y, greaterEqualThreshold1.u) annotation (Line(points=
               {{-183,-120},{-176,-120},{-176,-112},{-169.2,-112}}, color={0,0,127}));
        connect(lessEqualThreshold1.u, integerToReal1.y) annotation (Line(points={{
                -169.2,-130},{-176,-130},{-176,-120},{-183,-120}}, color={0,0,127}));
        connect(integerToReal1.u, measureBus.Hour) annotation (Line(points={{-206,
                -120},{-218,-120},{-218,90},{0.1,90},{0.1,100.1}}, color={255,127,0}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(lessEqualThreshold1.y, and1.u2) annotation (Line(points={{-155.4,
                -130},{-150,-130},{-150,-124},{-146,-124},{-146,-124.6},{-143.4,
                -124.6}}, color={255,0,255}));
        connect(greaterEqualThreshold1.y, and1.u1) annotation (Line(points={{-155.4,
                -112},{-150,-112},{-150,-120},{-146,-120},{-146,-119},{-143.4,-119}},
              color={255,0,255}));
        connect(and1.y, Pump_Verteiler.u2) annotation (Line(points={{-127.3,-119},{
                -124.65,-119},{-124.65,-120},{-102,-120}}, color={255,0,255}));
        connect(realExpression1.y, Pump_Verteiler.u1) annotation (Line(points={{
                -125,-100},{-122,-100},{-122,-112},{-102,-112}}, color={0,0,127}));
        connect(realExpression3.y, Pump_Verteiler.u3) annotation (Line(points={{
                -125,-140},{-124,-140},{-124,-128},{-102,-128}}, color={0,0,127}));
        connect(Pump_TBA.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
              points={{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_TBA.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
              points={{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_TBA.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (
            Line(points={{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_TBA.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points=
                {{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_TBA.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points=
               {{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_Hotwater_y)
          annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_Verteiler.y, controlBus.Pump_Warmwater_y) annotation (Line(
              points={{-79,-120},{0.1,-120},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_Verteiler.y, controlBus.Pump_Coldwater_y) annotation (Line(
              points={{-79,-120},{0.1,-120},{0.1,-99.9}}, color={0,0,127}));
        connect(Aircooler.u_m, measureBus.Aircooler) annotation (Line(points={{-62,
                26.8},{-62,22},{-72,22},{-72,90},{0.1,90},{0.1,100.1}}, color={0,0,
                127}));
        connect(or1.u2, controlBus.OnOff_heatpump_1) annotation (Line(points={{
                -65.2,57.2},{-72,57.2},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(or1.u1, controlBus.OnOff_heatpump_2) annotation (Line(points={{
                -65.2,62},{-72,62},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(switch1.y, controlBus.Pump_Warmwater_heatpump_1_y) annotation (Line(
              points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
        connect(switch1.y, controlBus.Pump_Warmwater_heatpump_2_y) annotation (Line(
              points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
        connect(switch3.u3, max.y) annotation (Line(points={{46,36},{36,36},{36,28},
                {-7,28}}, color={0,0,127}));
        connect(Heatpump3.y,switch3. u1) annotation (Line(points={{29,70},{36,70},{
                36,52},{46,52}}, color={0,0,127}));
        connect(switch3.y, controlBus.Pump_Aircooler_y) annotation (Line(points={{
                69,44},{78,44},{78,12},{0.1,12},{0.1,-99.9}}, color={0,0,127}));
        connect(switch3.u2, controlBus.OnOff_Aircooler_small) annotation (Line(
              points={{46,44},{0.1,44},{0.1,-99.9}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Pump_VariablePowerCost;

      model Pump_NoChpAndBoiler
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Sources.RealExpression Senken(y=1)
          annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));
        Modelica.Blocks.Sources.RealExpression Verteiler(y=1)
          annotation (Placement(transformation(extent={{-60,-42},{-40,-22}})));
        Modelica.Blocks.Continuous.LimPID Aircooler(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=200,
          k=0.01,
          yMax=0,
          yMin=-1) annotation (Placement(transformation(extent={{-68,28},{-56,40}})));
        Modelica.Blocks.Sources.RealExpression Heatpump1(y=273.15 + 9)
          annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
          annotation (Placement(transformation(extent={{-48,30},{-40,38}})));
        Modelica.Blocks.Sources.RealExpression Heatpump2(y=0.1)
          annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));
        Modelica.Blocks.Math.Max max
          annotation (Placement(transformation(extent={{-28,18},{-8,38}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{-64,56},{-52,68}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-24,52},{-4,72}})));
        Modelica.Blocks.Sources.RealExpression Verteiler1(
                                                         y=1)
          annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
        Modelica.Blocks.Sources.RealExpression Verteiler2(y=0.1)
          annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
        Modelica.Blocks.Sources.RealExpression Pump_Generation_Hot(y=0)
          annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
        Modelica.Blocks.Logical.Switch switch3
          annotation (Placement(transformation(extent={{48,34},{68,54}})));
        Modelica.Blocks.Sources.RealExpression Heatpump3(y=1)
          annotation (Placement(transformation(extent={{8,60},{28,80}})));
      equation
        connect(Senken.y, controlBus.Pump_RLT_Central_hot_y) annotation (Line(points=
                {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_ConferenceRoom_hot_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y) annotation (
            Line(points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(points=
                {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Workshop_hot_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Central_cold_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_ConferenceRoom_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y) annotation (
            Line(points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Canteen_cold_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Workshop_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points={{
                -39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points={{
                -39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Hotwater_y) annotation (Line(points={{
                -39,-32},{-20,-32},{-20,-32},{0.1,-32},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Warmwater_y) annotation (Line(points={{
                -39,-32},{0,-32},{0,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Coldwater_y) annotation (Line(points={{
                -39,-32},{0.1,-32},{0.1,-99.9}}, color={0,0,127}));
        connect(Heatpump1.y, Aircooler.u_s)
          annotation (Line(points={{-79,34},{-69.2,34}}, color={0,0,127}));
        connect(Aircooler.y, gain1.u)
          annotation (Line(points={{-55.4,34},{-48.8,34}}, color={0,0,127}));
        connect(gain1.y, max.u1)
          annotation (Line(points={{-39.6,34},{-30,34}}, color={0,0,127}));
        connect(Heatpump2.y, max.u2) annotation (Line(points={{-69,8},{-49.5,8},{
                -49.5,22},{-30,22}}, color={0,0,127}));
        connect(or1.y, switch1.u2)
          annotation (Line(points={{-51.4,62},{-26,62}}, color={255,0,255}));
        connect(switch1.y, controlBus.Pump_Coldwater_heatpump_y)
          annotation (Line(points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler1.y, switch1.u1) annotation (Line(points={{-79,76},{-38,76},
                {-38,70},{-26,70}}, color={0,0,127}));
        connect(Verteiler2.y, switch1.u3) annotation (Line(points={{-79,48},{-40,48},
                {-40,54},{-26,54}}, color={0,0,127}));
        connect(Pump_Generation_Hot.y, controlBus.Pump_Hotwater_CHP_y) annotation (
            Line(points={{-39,-10},{0.1,-10},{0.1,-99.9}}, color={0,0,127}));
        connect(Pump_Generation_Hot.y, controlBus.Pump_Hotwater_Boiler_y)
          annotation (Line(points={{-39,-10},{0.1,-10},{0.1,-99.9}}, color={0,0,127}));
        connect(Aircooler.u_m, measureBus.Aircooler) annotation (Line(points={{-62,
                26.8},{-62,22},{-72,22},{-72,84},{0.1,84},{0.1,100.1}}, color={0,0,
                127}));
        connect(or1.u2, controlBus.OnOff_heatpump_2) annotation (Line(points={{
                -65.2,57.2},{-72,57.2},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(or1.u1, controlBus.OnOff_heatpump_1) annotation (Line(points={{
                -65.2,62},{-72,62},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
        connect(switch1.y, controlBus.Pump_Warmwater_heatpump_1_y) annotation (Line(
              points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
        connect(switch1.y, controlBus.Pump_Warmwater_heatpump_2_y) annotation (Line(
              points={{-3,62},{0,62},{0,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(switch3.u3, max.y) annotation (Line(points={{46,36},{36,36},{36,28},
                {-7,28}}, color={0,0,127}));
        connect(Heatpump3.y,switch3. u1) annotation (Line(points={{29,70},{36,70},{
                36,52},{46,52}}, color={0,0,127}));
        connect(switch3.y, controlBus.Pump_Aircooler_y) annotation (Line(points={{
                69,44},{78,44},{78,12},{0.1,12},{0.1,-99.9}}, color={0,0,127}));
        connect(switch3.u2, controlBus.OnOff_Aircooler_small) annotation (Line(
              points={{46,44},{0.1,44},{0.1,-99.9}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Pump_NoChpAndBoiler;

      model Pump_Test
        Model.BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-20,80},{20,120}})));
        Model.BusSystems.Bus_Control controlBus
          annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
        Modelica.Blocks.Sources.RealExpression Senken(y=1)
          annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));
        Modelica.Blocks.Sources.RealExpression Verteiler(y=1)
          annotation (Placement(transformation(extent={{-60,-42},{-40,-22}})));
        Modelica.Blocks.Sources.RealExpression Aircooler(y=1)
          annotation (Placement(transformation(extent={{-60,-14},{-40,6}})));
        Modelica.Blocks.Sources.RealExpression Hotwater_Generation(y=1)
          annotation (Placement(transformation(extent={{-60,6},{-40,26}})));
        Modelica.Blocks.Sources.RealExpression Heatpump_pumps(y=1)
          annotation (Placement(transformation(extent={{-60,34},{-40,54}})));
      equation
        connect(Senken.y, controlBus.Pump_RLT_Central_hot_y) annotation (Line(points=
                {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_ConferenceRoom_hot_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y) annotation (
            Line(points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(points=
                {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Workshop_hot_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Central_cold_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_ConferenceRoom_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y) annotation (
            Line(points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Canteen_cold_y) annotation (Line(points=
               {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_RLT_Workshop_cold_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (Line(
              points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points={{
                -39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Senken.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points={{
                -39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Hotwater_y) annotation (Line(points={{
                -39,-32},{-20,-32},{-20,-32},{0.1,-32},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Warmwater_y) annotation (Line(points={{
                -39,-32},{0,-32},{0,-99.9},{0.1,-99.9}}, color={0,0,127}));
        connect(Verteiler.y, controlBus.Pump_Coldwater_y) annotation (Line(points={{
                -39,-32},{0.1,-32},{0.1,-99.9}}, color={0,0,127}));
        connect(Aircooler.y, controlBus.Pump_Aircooler_y) annotation (Line(points={
                {-39,-4},{0.1,-4},{0.1,-99.9}}, color={0,0,127}));
        connect(Hotwater_Generation.y, controlBus.Pump_Hotwater_CHP_y) annotation (
            Line(points={{-39,16},{0.1,16},{0.1,-99.9}}, color={0,0,127}));
        connect(Hotwater_Generation.y, controlBus.Pump_Hotwater_Boiler_y)
          annotation (Line(points={{-39,16},{0.1,16},{0.1,-99.9}}, color={0,0,127}));
        connect(Heatpump_pumps.y, controlBus.Pump_Coldwater_heatpump_y) annotation (
           Line(points={{-39,44},{0.1,44},{0.1,-99.9}}, color={0,0,127}));
        connect(Heatpump_pumps.y, controlBus.Pump_Warmwater_heatpump_1_y)
          annotation (Line(points={{-39,44},{0.1,44},{0.1,-99.9}}, color={0,0,127}));
        connect(Heatpump_pumps.y, controlBus.Pump_Warmwater_heatpump_2_y)
          annotation (Line(points={{-39,44},{0.1,44},{0.1,-99.9}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Pump_Test;
    end Controller_PumpsAndFans;
  end ControlStrategies;

  package Model
    model FullModel_v4
      replaceable package Medium_Air =
        AixLib.Media.Air "Medium in the component";
      AixLib.Systems.Benchmark.Model.Weather weather
        annotation (Placement(transformation(extent={{50,82},{70,102}})));
      Building.Office_v2 office
        annotation (Placement(transformation(extent={{30,0},{92,60}})));
      Transfer.Transfer_RLT.Full_Transfer_RLT_v2 full_Transfer_RLT
        annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
      AixLib.Systems.Benchmark.Model.InternalLoad.InternalLoads internalLoads
        annotation (Placement(transformation(extent={{-48,50},{-8,10}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      AixLib.Systems.Benchmark.Model.Evaluation.Evaluation evaluation
        annotation (Placement(transformation(extent={{-40,-16},{-20,4}})));
      AixLib.Fluid.Sensors.Temperature
                                senTem2(redeclare package Medium = Medium_Air)
        annotation (Placement(transformation(extent={{-34,52},{-22,64}})));
      AixLib.Fluid.Sensors.Temperature
                                senTem1(redeclare package Medium = Medium_Air)
        annotation (Placement(transformation(extent={{62,64},{74,76}})));
      Transfer.Transfer_TBA.Full_Transfer_TBA_Heatexchanger_v2
        full_Transfer_TBA_Heatexchanger(
        m_flow_nominal_openplanoffice=2.394,
        m_flow_nominal_canteen=1.086,
        m_flow_nominal_conferenceroom=0.350,
        m_flow_nominal_multipersonoffice=0.319,
        m_flow_nominal_workshop=1.654,
        dp_Heatexchanger_nominal=20000,
        dp_Valve_nominal_openplanoffice=30000,
        dp_Valve_nominal_conferenceroom=30000,
        dp_Valve_nominal_multipersonoffice=30000,
        dp_Valve_nominal_canteen=30000,
        dp_Valve_nominal_workshop=30000)
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      AixLib.Systems.Benchmark.Model.BusSystems.LogModel logModel
        annotation (Placement(transformation(extent={{100,-26},{120,-46}})));
      AixLib.Systems.Benchmark.Model.BusSystems.Bus_measure Measure
        annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
      AixLib.Systems.Benchmark.Model.BusSystems.Bus_Control Control
        annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
      Generation.Generation_v2 generation_v2_1(
        m_flow_nominal_generation_hot=3.805,
        Probe_depth=120,
        pipe_length_hotwater=25,
        pipe_length_warmwater=25,
        pipe_length_coldwater=25,
        alphaHC1_warm=500,
        pipe_diameter_hotwater=0.0809,
        pipe_diameter_warmwater=0.0809,
        pipe_nodes=2,
        n_probes=60,
        m_flow_nominal_hotwater=7.953,
        m_flow_nominal_warmwater=7.999,
        vol_1=0.024,
        vol_2=0.024,
        R_loss_1=2.8,
        R_loss_2=2.8,
        m_flow_nominal_generation_warmwater=6.601,
        m_flow_nominal_generation_coldwater=5.218,
        alphaHC1_cold=700,
        alphaHC2_warm=500,
        m_flow_nominal_coldwater=5.628,
        pipe_diameter_coldwater=0.0689,
        Thermal_Conductance_Cold=97000/10,
        m_flow_nominal_generation_aircooler=3.314,
        Thermal_Conductance_Warm=193000/10,
        dpHeatexchanger_nominal=20000,
        dpValve_nominal_generation_hot=40000,
        T_conMax_1=328.15,
        T_conMax_2=328.15,
        dpValve_nominal_warmwater=37000,
        dpValve_nominal_coldwater=40000,
        dpValve_nominal_generation_aircooler=60000,
        m_flow_nominal_generation_air_small_max=7.5808,
        m_flow_nominal_generation_air_small_min=6.1376,
        m_flow_nominal_generation_air_big_max=30.1309,
        m_flow_nominal_generation_air_big_min=23.9081,
        Area_Heatexchanger_Air=856.01,
        Earthtemperature_start=283.15)
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
      Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(
        surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
        Model=1,
        A=169.594)                                                                                                                                                                              annotation(Placement(transformation(extent={{17,92},
                {6,104}})));
      Modelica.Blocks.Math.Gain gain(k=2)
        annotation (Placement(transformation(extent={{36,92},{28,100}})));
      Fluid.MixingVolumes.MixingVolume vol2(
        redeclare package Medium = Medium_Air,
        m_flow_nominal=30,
        V=5,
        nPorts=3)
               annotation (Placement(transformation(extent={{5,-5},{-5,5}},
            rotation=90,
            origin={1,67})));
      Fluid.MixingVolumes.MixingVolume vol1(
        nPorts=2,
        redeclare package Medium = Medium_Air,
        m_flow_nominal=30,
        V=5)   annotation (Placement(transformation(extent={{-5,-5},{5,5}},
            rotation=-90,
            origin={21,67})));
      Infiltration infiltration(
        room_V_openplanoffice=4050,
        room_V_conferenceroom=150,
        room_V_multipersonoffice=300,
        room_V_canteen=1800,
        room_V_workshop=2700,
        n50=1.5,
        e=0.05,
        eps=1,
        rho=1.2041)
        annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
    equation
      connect(weather.measureBus,Measure)  annotation (Line(
          points={{60,82},{60,80},{-74,80},{-74,20},{-100,20}},
          color={255,204,51},
          thickness=0.5));
      connect(office.measureBus,Measure)  annotation (Line(
          points={{30,30},{0,30},{0,80},{-74,80},{-74,20},{-100,20}},
          color={255,204,51},
          thickness=0.5));
      connect(full_Transfer_RLT.measureBus,Measure)  annotation (Line(
          points={{20.2,-53},{28,-53},{28,-36},{-74,-36},{-74,20},{-100,20}},
          color={255,204,51},
          thickness=0.5));
      connect(internalLoads.AddPower,office. AddPower)
        annotation (Line(points={{-9.2,18},{30,18}}, color={191,0,0}));
      connect(internalLoads.internalBus,office. internalBus) annotation (Line(
          points={{-9.6,42},{30,42}},
          color={255,204,51},
          thickness=0.5));
      connect(weather.internalBus,office. internalBus) annotation (Line(
          points={{66,81.8},{66,81.8},{66,80},{0,80},{0,42},{30,42}},
          color={255,204,51},
          thickness=0.5));
      connect(weather.controlBus,Control)  annotation (Line(
          points={{54,82},{54,74},{-66,74},{-66,-20},{-100,-20}},
          color={255,204,51},
          thickness=0.5));
      connect(full_Transfer_RLT.controlBus,Control)  annotation (Line(
          points={{20.2,-47.2},{24,-47.2},{24,-32},{-66,-32},{-66,-20},{-100,-20}},
          color={255,204,51},
          thickness=0.5));
      connect(internalLoads.measureBus,office. measureBus) annotation (Line(
          points={{-9.6,30},{0,30},{0,30},{30,30}},
          color={255,204,51},
          thickness=0.5));
      connect(evaluation.measureBus,Measure)  annotation (Line(
          points={{-40,-6},{-74,-6},{-74,20},{-100,20}},
          color={255,204,51},
          thickness=0.5));
      connect(weather.SolarRadiation_North5,office. SolarRadiationPort_North)
        annotation (Line(points={{71,99},{110,99},{110,54},{88.9,54}}, color={255,
              128,0}));
      connect(weather.SolarRadiation_East,office. SolarRadiationPort_East)
        annotation (Line(points={{71,95},{114,95},{114,42},{88.9,42}}, color={255,
              128,0}));
      connect(weather.SolarRadiation_South,office. SolarRadiationPort_South1)
        annotation (Line(points={{71,91},{118,91},{118,30},{88.9,30}}, color={255,
              128,0}));
      connect(weather.SolarRadiation_West,office. SolarRadiationPort_West1)
        annotation (Line(points={{71,87},{122,87},{122,88},{122,88},{122,18},{88.9,
              18},{88.9,18}}, color={255,128,0}));
      connect(weather.SolarRadiation_Hor,office. SolarRadiationPort_Hor1)
        annotation (Line(points={{71,83},{126,83},{126,6},{88.9,6}}, color={255,128,
              0}));
      connect(senTem1.port,office. Air_out) annotation (Line(points={{68,64},{68,62},
              {26,62},{26,46},{16,46},{16,-16},{36,-16},{36,-8},{36.2,-8},{36.2,0}},
            color={0,127,255}));
      connect(senTem1.T,Measure. Air_out) annotation (Line(points={{72.2,70},{76,70},
              {76,80},{-74,80},{-74,20.1},{-99.9,20.1}}, color={0,0,127}));
      connect(senTem2.T,Measure. Air_in) annotation (Line(points={{-23.8,58},{-20,
              58},{-20,80},{-74,80},{-74,20.1},{-99.9,20.1}},
                                                        color={0,0,127}));
      connect(full_Transfer_TBA_Heatexchanger.HeatPort_TBA,office. Heatport_TBA)
        annotation (Line(points={{74,-40},{74,-20},{79.6,-20},{79.6,0}}, color={191,
              0,0}));
      connect(full_Transfer_TBA_Heatexchanger.controlBus,Control)  annotation (Line(
          points={{80,-46},{84,-46},{84,-32},{-66,-32},{-66,-20},{-100,-20}},
          color={255,204,51},
          thickness=0.5));
      connect(full_Transfer_TBA_Heatexchanger.measureBus,Measure)  annotation (Line(
          points={{80,-54},{88,-54},{88,-36},{-74,-36},{-74,20},{-100,20}},
          color={255,204,51},
          thickness=0.5));
      connect(logModel.logger_Bus_measure,Measure)  annotation (Line(
          points={{100,-40},{88,-40},{88,-36},{-74,-36},{-74,20},{-100,20}},
          color={255,204,51},
          thickness=0.5));
      connect(logModel.logger_Bus_Control,Control)  annotation (Line(
          points={{100,-32},{-66,-32},{-66,-20},{-100,-20}},
          color={255,204,51},
          thickness=0.5));
      connect(generation_v2_1.measureBus, Measure) annotation (Line(
          points={{-74,-40},{-74,20},{-100,20}},
          color={255,204,51},
          thickness=0.5));
      connect(generation_v2_1.controlBus, Control) annotation (Line(
          points={{-66,-40},{-66,-20},{-100,-20}},
          color={255,204,51},
          thickness=0.5));
      connect(generation_v2_1.Fluid_in_hot, full_Transfer_RLT.Fluid_out_hot)
        annotation (Line(points={{-60,-46},{0,-46}}, color={0,127,255}));
      connect(generation_v2_1.Fluid_out_cold, full_Transfer_RLT.Fluid_in_cold)
        annotation (Line(points={{-60,-58},{-34,-58},{-34,-54},{0,-54}}, color={0,127,
              255}));
      connect(generation_v2_1.Fluid_in_cold, full_Transfer_RLT.Fluid_out_cold)
        annotation (Line(points={{-60,-54},{-34,-54},{-34,-58},{0,-58}}, color={0,127,
              255}));
      connect(generation_v2_1.Fluid_out_warm, full_Transfer_TBA_Heatexchanger.Fluid_in_warm)
        annotation (Line(points={{-60,-48},{-18,-48},{-18,-66},{36,-66},{36,-47.4},
              {60,-47.4}},color={0,127,255}));
      connect(full_Transfer_TBA_Heatexchanger.Fluid_out_warm, generation_v2_1.Fluid_in_warm)
        annotation (Line(points={{60,-51.4},{36,-51.4},{36,-66},{-18,-66},{-18,-52},
              {-60,-52}}, color={0,127,255}));
      connect(full_Transfer_TBA_Heatexchanger.Fluid_in_cold, generation_v2_1.Fluid_out_cold)
        annotation (Line(points={{60,-54},{36,-54},{36,-66},{-18,-66},{-18,-58},{
              -60,-58}},
                     color={0,127,255}));
      connect(full_Transfer_TBA_Heatexchanger.Fluid_out_cold, generation_v2_1.Fluid_in_cold)
        annotation (Line(points={{60,-58},{36,-58},{36,-66},{-18,-66},{-18,-54},{
              -60,-54}},
                     color={0,127,255}));
      connect(vol1.ports[1], office.Air_out) annotation (Line(points={{16,68},{16,
              -16},{36,-16},{36,-8},{36.2,-8},{36.2,0}}, color={0,127,255}));
      connect(vol1.ports[2], weather.Air_in)
        annotation (Line(points={{16,66},{16,86},{50,86}}, color={0,127,255}));
      connect(vol2.ports[1], weather.Air_out)
        annotation (Line(points={{6,68.3333},{6,90},{50,90}}, color={0,127,255}));
      connect(heatTransfer_Outside.WindSpeedPort, gain.y) annotation (Line(points={
              {16.56,93.68},{25.28,93.68},{25.28,96},{27.6,96}}, color={0,0,127}));
      connect(gain.u, weather.RLT_Velocity) annotation (Line(points={{36.8,96},{42,
              96},{42,100},{49,100}}, color={0,0,127}));
      connect(heatTransfer_Outside.port_b, vol2.heatPort)
        annotation (Line(points={{6,98},{1,98},{1,72}}, color={191,0,0}));
      connect(heatTransfer_Outside.port_a, vol1.heatPort)
        annotation (Line(points={{17,98},{21,98},{21,72}}, color={191,0,0}));
      connect(vol2.ports[2], full_Transfer_RLT.Air_in)
        annotation (Line(points={{6,67},{6,-40}}, color={0,127,255}));
      connect(senTem2.port, vol2.ports[3])
        annotation (Line(points={{-28,52},{6,52},{6,65.6667}}, color={0,127,255}));
      connect(full_Transfer_RLT.Air_out, office.Air_in) annotation (Line(points={{
              14,-40},{14,-20},{48.6,-20},{48.6,0}}, color={0,127,255}));
      connect(full_Transfer_RLT.Fluid_in_hot, generation_v2_1.Fluid_out_hot)
        annotation (Line(points={{0,-42},{-60,-42}}, color={0,127,255}));
      connect(infiltration.Air_out, office.Air_in) annotation (Line(points={{20,-80},
              {48.6,-80},{48.6,0}}, color={0,127,255}));
      connect(infiltration.measureBus, Measure) annotation (Line(
          points={{0,-80},{-8,-80},{-8,-36},{-74,-36},{-74,20},{-100,20}},
          color={255,204,51},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FullModel_v4;

    model Infiltration
      replaceable package Medium_Air =
        AixLib.Media.Air "Medium in the component";
        parameter Modelica.SIunits.Volume room_V_openplanoffice = 50;
        parameter Modelica.SIunits.Volume room_V_conferenceroom = 50;
        parameter Modelica.SIunits.Volume room_V_multipersonoffice = 50;
        parameter Modelica.SIunits.Volume room_V_canteen = 50;
        parameter Modelica.SIunits.Volume room_V_workshop = 50;
        parameter Real n50(unit = "h-1") = 4
        "Air exchange rate at 50 Pa pressure difference";
        parameter Real e = 0.03 "Coefficient of windshield";
        parameter Real eps = 1.0 "Coefficient of height";
        parameter Modelica.SIunits.Density rho = 1.25 "Air density";
      Fluid.Sources.MassFlowSource_T Openplanoffice(
        use_T_in=true,
        use_X_in=true,
        redeclare package Medium = Medium_Air,
        use_m_flow_in=false,
        nPorts=1,
        m_flow=2*n50*e*eps*room_V_openplanoffice*rho/3600)
        annotation (Placement(transformation(extent={{0,70},{20,90}})));
      BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
               {{-120,-20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,
                10}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-32,66},{-12,86}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1)
        annotation (Placement(transformation(extent={{-68,68},{-56,84}})));
      Fluid.Sources.MassFlowSource_T Conferenceroom(
        use_T_in=true,
        use_X_in=true,
        nPorts=1,
        redeclare package Medium = Medium_Air,
        use_m_flow_in=false,
        m_flow=2*n50*e*eps*room_V_conferenceroom*rho/3600)
        annotation (Placement(transformation(extent={{0,30},{20,50}})));
      Modelica.Blocks.Math.Feedback feedback1
        annotation (Placement(transformation(extent={{-32,26},{-12,46}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(
                                                            y=1)
        annotation (Placement(transformation(extent={{-68,28},{-56,44}})));
      Fluid.Sources.MassFlowSource_T Multipersonoffice(
        use_T_in=true,
        use_X_in=true,
        nPorts=1,
        redeclare package Medium = Medium_Air,
        use_m_flow_in=false,
        m_flow=2*n50*e*eps*room_V_multipersonoffice*rho/3600)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Modelica.Blocks.Math.Feedback feedback2
        annotation (Placement(transformation(extent={{-32,-14},{-12,6}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(
                                                            y=1)
        annotation (Placement(transformation(extent={{-68,-12},{-56,4}})));
      Fluid.Sources.MassFlowSource_T Canteen(
        use_T_in=true,
        use_X_in=true,
        nPorts=1,
        redeclare package Medium = Medium_Air,
        use_m_flow_in=false,
        m_flow=2*n50*e*eps*room_V_canteen*rho/3600)
        annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
      Modelica.Blocks.Math.Feedback feedback3
        annotation (Placement(transformation(extent={{-32,-54},{-12,-34}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(
                                                            y=1)
        annotation (Placement(transformation(extent={{-68,-52},{-56,-36}})));
      Fluid.Sources.MassFlowSource_T Workshop(
        use_T_in=true,
        use_X_in=true,
        nPorts=1,
        redeclare package Medium = Medium_Air,
        use_m_flow_in=false,
        m_flow=2*n50*e*eps*room_V_workshop*rho/3600)
        annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
      Modelica.Blocks.Math.Feedback feedback4
        annotation (Placement(transformation(extent={{-32,-94},{-12,-74}})));
      Modelica.Blocks.Sources.RealExpression realExpression4(
                                                            y=1)
        annotation (Placement(transformation(extent={{-68,-92},{-56,-76}})));
      Modelica.Fluid.Interfaces.FluidPort_b Air_out[5](redeclare package Medium
          = Medium_Air)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Fluid.FixedResistances.PressureDrop pip(
        redeclare package Medium = Medium_Air,
        m_flow_nominal=2*n50*e*eps*room_V_openplanoffice*rho,
        allowFlowReversal=false,
        dp_nominal=1)
        annotation (Placement(transformation(extent={{40,70},{60,90}})));
      Fluid.FixedResistances.PressureDrop pip1(
        redeclare package Medium = Medium_Air,
        m_flow_nominal=2*n50*e*eps*room_V_conferenceroom*rho,
        allowFlowReversal=false,
        dp_nominal=1)
        annotation (Placement(transformation(extent={{40,30},{60,50}})));
      Fluid.FixedResistances.PressureDrop pip2(
        redeclare package Medium = Medium_Air,
        m_flow_nominal=2*n50*e*eps*room_V_multipersonoffice*rho,
        allowFlowReversal=false,
        dp_nominal=1)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Fluid.FixedResistances.PressureDrop pip3(
        redeclare package Medium = Medium_Air,
        m_flow_nominal=2*n50*e*eps*room_V_canteen*rho,
        allowFlowReversal=false,
        dp_nominal=1)
        annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
      Fluid.FixedResistances.PressureDrop pip4(
        redeclare package Medium = Medium_Air,
        m_flow_nominal=2*n50*e*eps*room_V_workshop*rho,
        allowFlowReversal=false,
        dp_nominal=1)
        annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
    equation
      connect(Openplanoffice.T_in, measureBus.AirTemp) annotation (Line(points={{-2,
              84},{-40,84},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(feedback.y, Openplanoffice.X_in[2])
        annotation (Line(points={{-13,76},{-2,76}}, color={0,0,127}));
      connect(Openplanoffice.X_in[1], measureBus.WaterInAir) annotation (Line(
            points={{-2,76},{-10,76},{-10,84},{-40,84},{-40,0.1},{-99.9,0.1}},
            color={0,0,127}));
      connect(realExpression.y, feedback.u1)
        annotation (Line(points={{-55.4,76},{-30,76}}, color={0,0,127}));
      connect(feedback.u2, measureBus.WaterInAir) annotation (Line(points={{-22,68},
              {-22,60},{-40,60},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(Conferenceroom.T_in, measureBus.AirTemp) annotation (Line(points={{-2,
              44},{-40,44},{-40,0},{-70,0},{-70,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(feedback1.y, Conferenceroom.X_in[2]) annotation (Line(points={{-13,36},
              {-8,36},{-8,36},{-2,36},{-2,36}}, color={0,0,127}));
      connect(Conferenceroom.X_in[1], measureBus.WaterInAir) annotation (Line(
            points={{-2,36},{-8,36},{-8,44},{-40,44},{-40,0},{-70,0},{-70,0.1},{-99.9,
              0.1}}, color={0,0,127}));
      connect(realExpression1.y, feedback1.u1) annotation (Line(points={{-55.4,36},{
              -46,36},{-46,36},{-38,36},{-38,36},{-30,36}}, color={0,0,127}));
      connect(feedback1.u2, measureBus.WaterInAir) annotation (Line(points={{-22,28},
              {-22,20},{-40,20},{-40,0},{-40,0},{-40,0},{-40,0},{-40,0},{-40,0},{-40,
              0},{-40,0.1},{-70,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(Multipersonoffice.T_in, measureBus.AirTemp) annotation (Line(points={{
              -2,4},{-40,4},{-40,0},{-70,0},{-70,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(feedback2.y, Multipersonoffice.X_in[2]) annotation (Line(points={{-13,
              -4},{-8,-4},{-8,-4},{-2,-4},{-2,-4}}, color={0,0,127}));
      connect(Multipersonoffice.X_in[1], measureBus.WaterInAir) annotation (Line(
            points={{-2,-4},{-10,-4},{-10,4},{-20,4},{-20,4},{-40,4},{-40,0},{-70,0},
              {-70,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(realExpression2.y, feedback2.u1) annotation (Line(points={{-55.4,-4},{
              -46,-4},{-46,-4},{-40,-4},{-40,-4},{-30,-4}}, color={0,0,127}));
      connect(feedback2.u2, measureBus.WaterInAir) annotation (Line(points={{-22,-12},
              {-22,-20},{-40,-20},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(Canteen.T_in, measureBus.AirTemp) annotation (Line(points={{-2,-36},{-40,
              -36},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(feedback3.y, Canteen.X_in[2]) annotation (Line(points={{-13,-44},{-10,
              -44},{-10,-44},{-2,-44},{-2,-44}}, color={0,0,127}));
      connect(Canteen.X_in[1], measureBus.WaterInAir) annotation (Line(points={{-2,-44},
              {-8,-44},{-8,-36},{-40,-36},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(realExpression3.y, feedback3.u1) annotation (Line(points={{-55.4,-44},
              {-46,-44},{-46,-44},{-38,-44},{-38,-44},{-30,-44}}, color={0,0,127}));
      connect(feedback3.u2, measureBus.WaterInAir) annotation (Line(points={{-22,-52},
              {-22,-60},{-40,-60},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(Workshop.T_in, measureBus.AirTemp) annotation (Line(points={{-2,-76},{
              -40,-76},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(feedback4.y, Workshop.X_in[2]) annotation (Line(points={{-13,-84},{-8,
              -84},{-8,-84},{-2,-84},{-2,-84}}, color={0,0,127}));
      connect(Workshop.X_in[1], measureBus.WaterInAir) annotation (Line(points={{-2,
              -84},{-8,-84},{-8,-76},{-40,-76},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(realExpression4.y, feedback4.u1) annotation (Line(points={{-55.4,-84},
              {-46,-84},{-46,-84},{-38,-84},{-38,-84},{-30,-84}}, color={0,0,127}));
      connect(feedback4.u2, measureBus.WaterInAir) annotation (Line(points={{-22,-92},
              {-22,-100},{-40,-100},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
      connect(Openplanoffice.ports[1], pip.port_a)
        annotation (Line(points={{20,80},{40,80}}, color={0,127,255}));
      connect(pip.port_b, Air_out[1]) annotation (Line(points={{60,80},{70,80},{70,
              -8},{100,-8}}, color={0,127,255}));
      connect(Conferenceroom.ports[1], pip1.port_a)
        annotation (Line(points={{20,40},{40,40}}, color={0,127,255}));
      connect(Multipersonoffice.ports[1], pip2.port_a)
        annotation (Line(points={{20,0},{40,0}}, color={0,127,255}));
      connect(Canteen.ports[1], pip3.port_a)
        annotation (Line(points={{20,-40},{40,-40}}, color={0,127,255}));
      connect(Workshop.ports[1], pip4.port_a)
        annotation (Line(points={{20,-80},{40,-80}}, color={0,127,255}));
      connect(pip1.port_b, Air_out[2]) annotation (Line(points={{60,40},{70,40},{70,
              -4},{100,-4}}, color={0,127,255}));
      connect(pip2.port_b, Air_out[3])
        annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
      connect(pip3.port_b, Air_out[4]) annotation (Line(points={{60,-40},{70,-40},{
              70,4},{100,4}}, color={0,127,255}));
      connect(pip4.port_b, Air_out[5]) annotation (Line(points={{60,-80},{70,-80},{
              70,8},{100,8}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Infiltration;

    package BusSystems
      expandable connector Bus_Control
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import SI = Modelica.SIunits;

        // Pump y
        // Generator
        Real Pump_Hotwater_y "Normalized speed of hotwaterpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Warmwater_y "Normalized speed of warmwaterpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Coldwater_y "Normalized speed of coldwaterpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Coldwater_heatpump_y "Normalized speed of coldwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Warmwater_heatpump_1_y "Normalized speed of warmwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Warmwater_heatpump_2_y "Normalized speed of warmwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Aircooler_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Hotwater_CHP_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Hotwater_Boiler_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});

        //RLT
        Real Pump_RLT_Central_hot_y "Normalized speed of hotwaterpump of the central RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_OpenPlanOffice_hot_y "Normalized speed of hotwaterpump of the openplanoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_ConferenceRoom_hot_y "Normalized speed of hotwaterpump of the conferenceroom RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_MultiPersonOffice_hot_y "Normalized speed of hotwaterpump of the multipersonoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Canteen_hot_y "Normalized speed of hotwaterpump of the canteen RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Workshop_hot_y "Normalized speed of hotwaterpump of the workshop RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Central_cold_y "Normalized speed of coldwaterpump of the central RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_OpenPlanOffice_cold_y "Normalized speed of coldwaterpump of the openplanoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_ConferenceRoom_cold_y "Normalized speed of coldwaterpump of the conferenceroom RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_MultiPersonOffice_cold_y "Normalized speed of coldwaterpump of the multipersonoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Canteen_cold_y "Normalized speed of coldwaterpump of the canteen RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Workshop_cold_y "Normalized speed of coldwaterpump of the workshop RLT" annotation (__Dymola_Tag={"ControlBus"});

        // TBA
        Real Pump_TBA_OpenPlanOffice_y "Normalized speed of waterpump of the openplanoffice TBA" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_TBA_ConferenceRoom_y "Normalized speed of waterpump of the conferenceroom TBA" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_TBA_MultiPersonOffice_y "Normalized speed of waterpump of the multipersonoffice TBA" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_TBA_Canteen_y "Normalized speed of waterpump of the canteen TBA" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_TBA_Workshop_y "Normalized speed of waterpump of the workshop TBA" annotation (__Dymola_Tag={"ControlBus"});

        // Fan m_flow
        Boolean OnOff_RLT "On/Off Signal for the RLT fan" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_Aircooler_small "On/Off Signal for the aircooler fan" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_Aircooler_big "On/Off Signal for the aircooler fan" annotation (__Dymola_Tag={"ControlBus"});
        Real Fan_Aircooler_small "Normalized Massflow of Aircooler" annotation (__Dymola_Tag={"ControlBus"});
        Real Fan_Aircooler_big "Normalized Massflow of Aircooler" annotation (__Dymola_Tag={"ControlBus"});
        Real Fan_RLT "Normalized Massflow of the RLT-fan" annotation (__Dymola_Tag={"ControlBus"});

        // Valvepositions
        Real Valve1 "Valveposition of Valve1 (Coldwater geothermalprobe)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve2 "Valveposition of Valve2 (Coldwater coldwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve3 "Valveposition of Valve3 (Coldwater heatexchanger)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve4 "Valveposition of Valve4 (Warmwater heatexchanger)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve5 "Valveposition of Valve5 (Warmwater warmwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve6 "Valveposition of Valve6 (Hotwater boiler)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve7 "Valveposition of Valve7 (Hotwater warmwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve8 "Valveposition of Valve8 (Aircooler)" annotation (__Dymola_Tag={"ControlBus"});

        Real Valve_RLT_Hot_Central "Valveposition to control the hotwater-temperatur to the Central" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_OpenPlanOffice "Valveposition to control the hotwater-temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_ConferenceRoom "Valveposition to control the hotwater-temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_MultiPersonOffice "Valveposition to control the hotwater-temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_Canteen "Valveposition to control the hotwater-temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_Workshop "Valveposition to control the hotwater-temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_Central "Valveposition to control the coldwater-temperatur to the Central" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_OpenPlanOffice "Valveposition to control the coldwater-temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_ConferenceRoom "Valveposition to control the coldwater-temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_MultiPersonOffice "Valveposition to control the coldwater-temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_Canteen "Valveposition to control the coldwater-temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_Workshop "Valveposition to control the coldwater-temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});

        Real Valve_TBA_Warm_OpenPlanOffice "Valveposition of Valve 1 for warm or cold of the openplanoffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Warm_conferenceroom "Valveposition of Valve 1 for warm or cold of the conferenceroom" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Warm_multipersonoffice "Valveposition of Valve 1 for warm or cold of the multipersonoffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Warm_canteen "Valveposition of Valve 1 for warm or cold of the canteen" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Warm_workshop "Valveposition of Valve 1 for warm or cold of the workshop" annotation (__Dymola_Tag={"ControlBus"});

        Real Valve_TBA_OpenPlanOffice_Temp "Valveposition to control the temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_ConferenceRoom_Temp "Valveposition to control the temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_MultiPersonOffice_Temp "Valveposition to control the temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Canteen_Temp "Valveposition to control the temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Workshop_Temp "Valveposition to control the temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});

        // On/Off components
        Boolean OnOff_heatpump_1 "On/Off Signal for the first heatpump" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_heatpump_2 "On/Off Signal for the second heatpump" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_CHP   "On/Off Signal for the CHP" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_boiler "On/Off Signal for the boiler" annotation (__Dymola_Tag={"ControlBus"});

        // Setpoints for components
        Real ElSet_CHP "Electrical Power Setpoint CHP" annotation (__Dymola_Tag={"ControlBus"});
        Real TSet_CHP "Temperatur Setpoint CHP" annotation (__Dymola_Tag={"ControlBus"});
        Real TSet_boiler "Temperatur Setpoint boiler" annotation (__Dymola_Tag={"ControlBus"});

        // Moisterlevel
        Real X_Central "Moisterlevel for the central RLT" annotation (__Dymola_Tag={"ControlBus"});
      end Bus_Control;

      expandable connector Bus_measure
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import SI = Modelica.SIunits;
      // Weather
        SI.Temp_K AirTemp;
        Real WaterInAir;

        //Storage
        SI.Temp_K HotWater_TTop "Temperatur at the top of the hotwater-bufferstorage";
        SI.Temp_K HotWater_TBottom "Temperatur at the bottom of the hotwater-bufferstorage";
        SI.Temp_K WarmWater_TTop "Temperatur at the top of the warmwater-bufferstorage";
        SI.Temp_K WarmWater_TBottom "Temperatur at the bottom of the warmwater-bufferstorage";
        SI.Temp_K ColdWater_TTop "Temperatur at the top of the coldwater-bufferstorage";
        SI.Temp_K ColdWater_TBottom "Temperatur at the bottom of the coldwater-bufferstorage";

        //Measured Temperatures
        SI.Temp_K Heatpump_cold_in;
        SI.Temp_K Heatpump_cold_out;
        SI.Temp_K Heatpump_warm_out;
        SI.Temp_K Heatpump_warm_in;
        SI.Temp_K Aircooler_in;
        SI.Temp_K Aircooler;
        SI.Temp_K GeothermalProbe_in;
        SI.Temp_K GeothermalProbe_out;
        SI.Temp_K generation_hot_in;
        SI.Temp_K generation_hot_out;
        SI.Temp_K RLT_central_hot_in;
        SI.Temp_K RLT_central_hot_out;
        SI.Temp_K RLT_central_cold_in;
        SI.Temp_K RLT_central_cold_out;
        SI.Temp_K RLT_openplanoffice_hot_in;
        SI.Temp_K RLT_openplanoffice_hot_out;
        SI.Temp_K RLT_openplanoffice_cold_in;
        SI.Temp_K RLT_openplanoffice_cold_out;
        SI.Temp_K RLT_conferencerom_hot_in;
        SI.Temp_K RLT_conferencerom_hot_out;
        SI.Temp_K RLT_conferencerom_cold_in;
        SI.Temp_K RLT_conferencerom_cold_out;
        SI.Temp_K RLT_multipersonoffice_hot_in;
        SI.Temp_K RLT_multipersonoffice_hot_out;
        SI.Temp_K RLT_multipersonoffice_cold_in;
        SI.Temp_K RLT_multipersonoffice_cold_out;
        SI.Temp_K RLT_canteen_hot_in;
        SI.Temp_K RLT_canteen_hot_out;
        SI.Temp_K RLT_canteen_cold_in;
        SI.Temp_K RLT_canteen_cold_out;
        SI.Temp_K RLT_workshop_hot_in;
        SI.Temp_K RLT_workshop_hot_out;
        SI.Temp_K RLT_workshop_cold_in;
        SI.Temp_K RLT_workshop_cold_out;
        SI.Temp_K TBA_openplanoffice_in;
        SI.Temp_K TBA_openplanoffice_out;
        SI.Temp_K TBA_conferencerom_in;
        SI.Temp_K TBA_conferencerom_out;
        SI.Temp_K TBA_multipersonoffice_in;
        SI.Temp_K TBA_multipersonoffice_out;
        SI.Temp_K TBA_canteen_in;
        SI.Temp_K TBA_canteen_out;
        SI.Temp_K TBA_workshop_in;
        SI.Temp_K TBA_workshop_out;
        SI.Temp_K RoomTemp_Openplanoffice;
        SI.Temp_K RoomTemp_Conferenceroom;
        SI.Temp_K RoomTemp_Multipersonoffice;
        SI.Temp_K RoomTemp_Canteen;
        SI.Temp_K RoomTemp_Workshop;
        SI.Temp_K Air_out "Befor Heatexchanger";
        SI.Temp_K Air_in "After Heatexchanger";
        SI.Temp_K Air_RLT_Central_out;

        //MassflowRates
        SI.MassFlowRate heatpump_cold_massflow;
        SI.MassFlowRate heatpump_warm_massflow;
        SI.MassFlowRate Aircooler_massflow;
        SI.MassFlowRate generation_hot_massflow;
        SI.MassFlowRate RLT_central_warm;
        SI.MassFlowRate RLT_central_cold;
        SI.MassFlowRate RLT_openplanoffice_warm;
        SI.MassFlowRate RLT_openplanoffice_cold;
        SI.MassFlowRate RLT_conferenceroom_warm;
        SI.MassFlowRate RLT_conferenceroom_cold;
        SI.MassFlowRate RLT_multipersonoffice_warm;
        SI.MassFlowRate RLT_multipersonoffice_cold;
        SI.MassFlowRate RLT_canteen_warm;
        SI.MassFlowRate RLT_canteen_cold;
        SI.MassFlowRate RLT_workshop_warm;
        SI.MassFlowRate RLT_workshop_cold;
        SI.MassFlowRate TBA_openplanoffice;
        SI.MassFlowRate TBA_conferenceroom;
        SI.MassFlowRate TBA_multipersonoffice;
        SI.MassFlowRate TBA_canteen;
        SI.MassFlowRate TBA_workshop;

        //Power
        SI.Power Pump_Warmwater_heatpump_1_power "Power of first warmwater heatpump pump";
        SI.Power Pump_Warmwater_heatpump_2_power "Power of second warmwater heatpump pump";
        SI.Power Heatpump_1_power "Power of first heatpump";
        SI.Power Heatpump_2_power "Power of second heatpump";
        SI.Power Pump_generation_hot_power;
        SI.Power Pump_generation_hot_power_Boiler;
        SI.Power Pump_Coldwater_heatpump_power;
        SI.Power Pump_Coldwater_power;
        SI.Power Pump_Warmwater_power;
        SI.Power Pump_Hotwater_power;
        Real Electrical_power_CHP;
        SI.Power Pump_RLT_central_warm;
        SI.Power Pump_RLT_central_cold;
        SI.Power Pump_RLT_openplanoffice_warm;
        SI.Power Pump_RLT_openplanoffice_cold;
        SI.Power Pump_RLT_conferenceroom_warm;
        SI.Power Pump_RLT_conferenceroom_cold;
        SI.Power Pump_RLT_multipersonoffice_warm;
        SI.Power Pump_RLT_multipersonoffice_cold;
        SI.Power Pump_RLT_canteen_warm;
        SI.Power Pump_RLT_canteen_cold;
        SI.Power Pump_RLT_workshop_warm;
        SI.Power Pump_RLT_workshop_cold;
        SI.Power Pump_TBA_openplanoffice;
        SI.Power Pump_TBA_conferenceroom;
        SI.Power Pump_TBA_multipersonoffice;
        SI.Power Pump_TBA_canteen;
        SI.Power Pump_TBA_workshop;
        SI.Power Fan_RLT;
        SI.Power Fan_Aircooler;

        Real InternalLoad_Power;
        Real PV_Power;
        Real Sum_Power;

        Real Fuel_Boiler "kW";
        Real Fuel_CHP "kW";

        //COP
        Real Heatpump_1_COP;
        Real Heatpump_2_COP;

        //Humidity
        Real X_OpenplanOffice;
        Real X_Conferenceroom;
        Real X_Multipersonoffice;
        Real X_Canteen;
        Real X_Workshop;

        //Costs & Consumption
        Real Total_Cost "€";
        Real Total_Power "kWh";
        Real Total_Fuel "kWh";

        //Time
        Real Minute;
        Integer Hour;
        Integer WeekDay;

        //Strahlungs Temps
        Real StrahlungTemp_Openplanoffice;
        Real StrahlungTemp_Conferenceroom;
        Real StrahlungTemp_Multipersonoffice;
        Real StrahlungTemp_Canteen;
        Real StrahlungTemp_Workshop;

      end Bus_measure;

      expandable connector InternalBus
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import SI = Modelica.SIunits;

        //InternalLoads
        SI.HeatFlowRate InternalLoads_QFlow_Workshop;
        SI.MassFlowRate InternalLoads_MFlow_Openplanoffice;
        SI.MassFlowRate InternalLoads_MFlow_Conferenceroom;
        SI.MassFlowRate InternalLoads_MFlow_Multipersonoffice;
        SI.MassFlowRate InternalLoads_MFlow_Canteen;
        SI.MassFlowRate InternalLoads_MFlow_Workshop;

        //Weather
        Real InternalLoads_Wind_Speed_Hor;
        Real InternalLoads_Wind_Speed_North;
        Real InternalLoads_Wind_Speed_East;
        Real InternalLoads_Wind_Speed_South;
        Real InternalLoads_Wind_Speed_West;

      end InternalBus;

      expandable connector Logger_Bus_Control
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import SI = Modelica.SIunits;

        // Pump y
        // Generator
        Real Pump_Hotwater_y "Normalized speed of hotwaterpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Warmwater_y "Normalized speed of warmwaterpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Coldwater_y "Normalized speed of coldwaterpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Coldwater_heatpump_y "Normalized speed of coldwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Warmwater_heatpump_1_y "Normalized speed of warmwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Warmwater_heatpump_2_y "Normalized speed of warmwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Aircooler_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Hotwater_CHP_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_Hotwater_Boiler_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});

        //RLT
        Real Pump_RLT_Central_hot_y "Normalized speed of hotwaterpump of the central RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_OpenPlanOffice_hot_y "Normalized speed of hotwaterpump of the openplanoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_ConferenceRoom_hot_y "Normalized speed of hotwaterpump of the conferenceroom RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_MultiPersonOffice_hot_y "Normalized speed of hotwaterpump of the multipersonoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Canteen_hot_y "Normalized speed of hotwaterpump of the canteen RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Workshop_hot_y "Normalized speed of hotwaterpump of the workshop RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Central_cold_y "Normalized speed of coldwaterpump of the central RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_OpenPlanOffice_cold_y "Normalized speed of coldwaterpump of the openplanoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_ConferenceRoom_cold_y "Normalized speed of coldwaterpump of the conferenceroom RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_MultiPersonOffice_cold_y "Normalized speed of coldwaterpump of the multipersonoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Canteen_cold_y "Normalized speed of coldwaterpump of the canteen RLT" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_RLT_Workshop_cold_y "Normalized speed of coldwaterpump of the workshop RLT" annotation (__Dymola_Tag={"ControlBus"});

        // TBA
        Real Pump_TBA_OpenPlanOffice_y "Normalized speed of waterpump of the openplanoffice TBA" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_TBA_ConferenceRoom_y "Normalized speed of waterpump of the conferenceroom TBA" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_TBA_MultiPersonOffice_y "Normalized speed of waterpump of the multipersonoffice TBA" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_TBA_Canteen_y "Normalized speed of waterpump of the canteen TBA" annotation (__Dymola_Tag={"ControlBus"});
        Real Pump_TBA_Workshop_y "Normalized speed of waterpump of the workshop TBA" annotation (__Dymola_Tag={"ControlBus"});

        // Fan m_flow
        Boolean OnOff_RLT "On/Off Signal for the RLT fan" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_Aircooler_small "On/Off Signal for the aircooler fan" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_Aircooler_big "On/Off Signal for the aircooler fan" annotation (__Dymola_Tag={"ControlBus"});
        Real Fan_Aircooler_small "Normalized Massflow of Aircooler" annotation (__Dymola_Tag={"ControlBus"});
        Real Fan_Aircooler_big "Normalized Massflow of Aircooler" annotation (__Dymola_Tag={"ControlBus"});
        Real Fan_RLT "Normalized Massflow of the RLT-fan" annotation (__Dymola_Tag={"ControlBus"});

        // Valvepositions
        Real Valve1 "Valveposition of Valve1 (Coldwater geothermalprobe)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve2 "Valveposition of Valve2 (Coldwater coldwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve3 "Valveposition of Valve3 (Coldwater heatexchanger)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve4 "Valveposition of Valve4 (Warmwater heatexchanger)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve5 "Valveposition of Valve5 (Warmwater warmwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve6 "Valveposition of Valve6 (Hotwater boiler)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve7 "Valveposition of Valve7 (Hotwater warmwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve8 "Valveposition of Valve8 (Aircooler)" annotation (__Dymola_Tag={"ControlBus"});

        Real Valve_RLT_Hot_Central "Valveposition to control the hotwater-temperatur to the Central" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_OpenPlanOffice "Valveposition to control the hotwater-temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_ConferenceRoom "Valveposition to control the hotwater-temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_MultiPersonOffice "Valveposition to control the hotwater-temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_Canteen "Valveposition to control the hotwater-temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Hot_Workshop "Valveposition to control the hotwater-temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_Central "Valveposition to control the coldwater-temperatur to the Central" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_OpenPlanOffice "Valveposition to control the coldwater-temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_ConferenceRoom "Valveposition to control the coldwater-temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_MultiPersonOffice "Valveposition to control the coldwater-temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_Canteen "Valveposition to control the coldwater-temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_RLT_Cold_Workshop "Valveposition to control the coldwater-temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});

        Real Valve_TBA_Warm_OpenPlanOffice "Valveposition of Valve 1 for warm or cold of the openplanoffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Warm_conferenceroom "Valveposition of Valve 1 for warm or cold of the conferenceroom" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Warm_multipersonoffice "Valveposition of Valve 1 for warm or cold of the multipersonoffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Warm_canteen "Valveposition of Valve 1 for warm or cold of the canteen" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Warm_workshop "Valveposition of Valve 1 for warm or cold of the workshop" annotation (__Dymola_Tag={"ControlBus"});

        Real Valve_TBA_OpenPlanOffice_Temp "Valveposition to control the temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_ConferenceRoom_Temp "Valveposition to control the temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_MultiPersonOffice_Temp "Valveposition to control the temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Canteen_Temp "Valveposition to control the temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
        Real Valve_TBA_Workshop_Temp "Valveposition to control the temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});

        // On/Off components
        Boolean OnOff_heatpump_1 "On/Off Signal for the first heatpump" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_heatpump_2 "On/Off Signal for the second heatpump" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_CHP   "On/Off Signal for the CHP" annotation (__Dymola_Tag={"ControlBus"});
        Boolean OnOff_boiler "On/Off Signal for the boiler" annotation (__Dymola_Tag={"ControlBus"});

        // Setpoints for components
        Real ElSet_CHP "Electrical Power Setpoint CHP" annotation (__Dymola_Tag={"ControlBus"});
        Real TSet_CHP "Temperatur Setpoint CHP" annotation (__Dymola_Tag={"ControlBus"});
        Real TSet_boiler "Temperatur Setpoint boiler" annotation (__Dymola_Tag={"ControlBus"});

        // Moisterlevel
        Real X_Central "Moisterlevel for the central RLT" annotation (__Dymola_Tag={"ControlBus"});
      end Logger_Bus_Control;

      expandable connector Logger_Bus_measure
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import SI = Modelica.SIunits;
      // Weather
        SI.Temp_K AirTemp;
        Real WaterInAir;

        //Storage
        SI.Temp_K HotWater_TTop "Temperatur at the top of the hotwater-bufferstorage";
        SI.Temp_K HotWater_TBottom "Temperatur at the bottom of the hotwater-bufferstorage";
        SI.Temp_K WarmWater_TTop "Temperatur at the top of the warmwater-bufferstorage";
        SI.Temp_K WarmWater_TBottom "Temperatur at the bottom of the warmwater-bufferstorage";
        SI.Temp_K ColdWater_TTop "Temperatur at the top of the coldwater-bufferstorage";
        SI.Temp_K ColdWater_TBottom "Temperatur at the bottom of the coldwater-bufferstorage";

        //Measured Temperatures
        SI.Temp_K Heatpump_cold_in;
        SI.Temp_K Heatpump_cold_out;
        SI.Temp_K Heatpump_warm_out;
        SI.Temp_K Heatpump_warm_in;
        SI.Temp_K Aircooler_in;
        SI.Temp_K Aircooler;
        SI.Temp_K GeothermalProbe_in;
        SI.Temp_K GeothermalProbe_out;
        SI.Temp_K generation_hot_in;
        SI.Temp_K generation_hot_out;
        SI.Temp_K RLT_central_hot_in;
        SI.Temp_K RLT_central_hot_out;
        SI.Temp_K RLT_central_cold_in;
        SI.Temp_K RLT_central_cold_out;
        SI.Temp_K RLT_openplanoffice_hot_in;
        SI.Temp_K RLT_openplanoffice_hot_out;
        SI.Temp_K RLT_openplanoffice_cold_in;
        SI.Temp_K RLT_openplanoffice_cold_out;
        SI.Temp_K RLT_conferencerom_hot_in;
        SI.Temp_K RLT_conferencerom_hot_out;
        SI.Temp_K RLT_conferencerom_cold_in;
        SI.Temp_K RLT_conferencerom_cold_out;
        SI.Temp_K RLT_multipersonoffice_hot_in;
        SI.Temp_K RLT_multipersonoffice_hot_out;
        SI.Temp_K RLT_multipersonoffice_cold_in;
        SI.Temp_K RLT_multipersonoffice_cold_out;
        SI.Temp_K RLT_canteen_hot_in;
        SI.Temp_K RLT_canteen_hot_out;
        SI.Temp_K RLT_canteen_cold_in;
        SI.Temp_K RLT_canteen_cold_out;
        SI.Temp_K RLT_workshop_hot_in;
        SI.Temp_K RLT_workshop_hot_out;
        SI.Temp_K RLT_workshop_cold_in;
        SI.Temp_K RLT_workshop_cold_out;
        SI.Temp_K TBA_openplanoffice_in;
        SI.Temp_K TBA_openplanoffice_out;
        SI.Temp_K TBA_conferencerom_in;
        SI.Temp_K TBA_conferencerom_out;
        SI.Temp_K TBA_multipersonoffice_in;
        SI.Temp_K TBA_multipersonoffice_out;
        SI.Temp_K TBA_canteen_in;
        SI.Temp_K TBA_canteen_out;
        SI.Temp_K TBA_workshop_in;
        SI.Temp_K TBA_workshop_out;
        SI.Temp_K RoomTemp_Openplanoffice;
        SI.Temp_K RoomTemp_Conferenceroom;
        SI.Temp_K RoomTemp_Multipersonoffice;
        SI.Temp_K RoomTemp_Canteen;
        SI.Temp_K RoomTemp_Workshop;
        SI.Temp_K Air_out "Befor Heatexchanger";
        SI.Temp_K Air_in "After Heatexchanger";
        SI.Temp_K Air_RLT_Central_out;

        //MassflowRates
        SI.MassFlowRate heatpump_cold_massflow;
        SI.MassFlowRate heatpump_warm_massflow;
        SI.MassFlowRate Aircooler_massflow;
        SI.MassFlowRate generation_hot_massflow;
        SI.MassFlowRate RLT_central_warm;
        SI.MassFlowRate RLT_central_cold;
        SI.MassFlowRate RLT_openplanoffice_warm;
        SI.MassFlowRate RLT_openplanoffice_cold;
        SI.MassFlowRate RLT_conferenceroom_warm;
        SI.MassFlowRate RLT_conferenceroom_cold;
        SI.MassFlowRate RLT_multipersonoffice_warm;
        SI.MassFlowRate RLT_multipersonoffice_cold;
        SI.MassFlowRate RLT_canteen_warm;
        SI.MassFlowRate RLT_canteen_cold;
        SI.MassFlowRate RLT_workshop_warm;
        SI.MassFlowRate RLT_workshop_cold;
        SI.MassFlowRate TBA_openplanoffice;
        SI.MassFlowRate TBA_conferenceroom;
        SI.MassFlowRate TBA_multipersonoffice;
        SI.MassFlowRate TBA_canteen;
        SI.MassFlowRate TBA_workshop;

        //Power
        SI.Power Pump_Warmwater_heatpump_1_power "Power of first warmwater heatpump pump";
        SI.Power Pump_Warmwater_heatpump_2_power "Power of second warmwater heatpump pump";
        SI.Power Heatpump_1_power "Power of first heatpump";
        SI.Power Heatpump_2_power "Power of second heatpump";
        SI.Power Pump_generation_hot_power;
        SI.Power Pump_generation_hot_power_Boiler;
        SI.Power Pump_Coldwater_heatpump_power;
        SI.Power Pump_Coldwater_power;
        SI.Power Pump_Warmwater_power;
        SI.Power Pump_Hotwater_power;
        Real Electrical_power_CHP;
        SI.Power Pump_RLT_central_warm;
        SI.Power Pump_RLT_central_cold;
        SI.Power Pump_RLT_openplanoffice_warm;
        SI.Power Pump_RLT_openplanoffice_cold;
        SI.Power Pump_RLT_conferenceroom_warm;
        SI.Power Pump_RLT_conferenceroom_cold;
        SI.Power Pump_RLT_multipersonoffice_warm;
        SI.Power Pump_RLT_multipersonoffice_cold;
        SI.Power Pump_RLT_canteen_warm;
        SI.Power Pump_RLT_canteen_cold;
        SI.Power Pump_RLT_workshop_warm;
        SI.Power Pump_RLT_workshop_cold;
        SI.Power Pump_TBA_openplanoffice;
        SI.Power Pump_TBA_conferenceroom;
        SI.Power Pump_TBA_multipersonoffice;
        SI.Power Pump_TBA_canteen;
        SI.Power Pump_TBA_workshop;

        Real InternalLoad_Power;
        Real PV_Power;
        Real Sum_Power;

        Real Fuel_Boiler "kW";
        Real Fuel_CHP "kW";

        //COP
        Real Heatpump_1_COP;
        Real Heatpump_2_COP;

        //Humidity
        Real X_OpenplanOffice;
        Real X_Conferenceroom;
        Real X_Multipersonoffice;
        Real X_Canteen;
        Real X_Workshop;

        //Costs
        Real Total_Cost;
        Real Total_Power "kWh";
        Real Total_Fuel "kWh";

        //Time
        Real Minute;
        Integer Hour;
        Integer WeekDay;

        //Strahlungs Temps
        Real StrahlungTemp_Openplanoffice;
        Real StrahlungTemp_Conferenceroom;
        Real StrahlungTemp_Multipersonoffice;
        Real StrahlungTemp_Canteen;
        Real StrahlungTemp_Workshop;
      end Logger_Bus_measure;

      model Logger
            annotation (__Dymola_selections={
         Selection(name="Measure & Control",
         match={MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="AirTemp"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="WaterInAir"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="HotWater_TTop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="HotWater_TBottom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="WarmWater_TTop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="WarmWater_TBottom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="ColdWater_TTop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="ColdWater_TBottom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Heatpump_cold_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Heatpump_cold_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Heatpump_warm_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Heatpump_warm_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Aircooler_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Aircooler"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="GeothermalProbe_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="GeothermalProbe_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="generation_hot_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="generation_hot_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_central_hot_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_central_hot_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_central_cold_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_central_cold_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_openplanoffice_hot_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_openplanoffice_hot_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_openplanoffice_cold_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_openplanoffice_cold_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_conferencerom_hot_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_conferencerom_hot_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_conferencerom_cold_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_conferencerom_cold_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_multipersonoffice_hot_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_multipersonoffice_hot_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_multipersonoffice_cold_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_multipersonoffice_cold_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_canteen_hot_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_canteen_hot_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_canteen_cold_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_canteen_cold_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_workshop_hot_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_workshop_hot_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_workshop_cold_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_workshop_cold_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_openplanoffice_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_openplanoffice_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_conferencerom_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_conferencerom_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_multipersonoffice_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_multipersonoffice_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_canteen_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_canteen_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_workshop_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_workshop_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RoomTemp_Openplanoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RoomTemp_Conferenceroom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RoomTemp_Multipersonoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RoomTemp_Canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RoomTemp_Workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Air_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Air_in"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Air_RLT_Central_out"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="heatpump_cold_massflow"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="heatpump_warm_massflow"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Aircooler_massflow"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="generation_hot_massflow"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_central_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_central_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_openplanoffice_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_openplanoffice_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_conferenceroom_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_conferenceroom_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_multipersonoffice_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_multipersonoffice_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_canteen_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_canteen_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_workshop_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="RLT_workshop_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_openplanoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_conferenceroom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_multipersonoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TBA_workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Warmwater_heatpump_1_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Warmwater_heatpump_2_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Heatpump_1_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Heatpump_2_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_generation_hot_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_generation_hot_power_Boiler"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Coldwater_heatpump_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Coldwater_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Warmwater_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Hotwater_power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Electrical_power_CHP"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_central_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_central_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_openplanoffice_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_openplanoffice_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_conferenceroom_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_conferenceroom_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_multipersonoffice_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_multipersonoffice_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_canteen_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_canteen_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_workshop_warm"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_workshop_cold"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_openplanoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_conferenceroom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_multipersonoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="InternalLoad_Power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="PV_Power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Sum_Power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Fuel_Boiler"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Fuel_CHP"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Heatpump_1_COP"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Heatpump_2_COP"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="X_OpenplanOffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="X_Conferenceroom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="X_Multipersonoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="X_Canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="X_Workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Total_Cost"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Total_Power"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Total_Fuel"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Minute"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Hour"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="WeekDay"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="StrahlungTemp_Openplanoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="StrahlungTemp_Conferenceroom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="StrahlungTemp_Multipersonoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="StrahlungTemp_Canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="StrahlungTemp_Workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="FloorTemp_Openplanoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="FloorTemp_Conferenceroom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="FloorTemp_Multipersonoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="FloorTemp_Canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="FloorTemp_Workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="CeilingTemp_Openplanoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="CeilingTemp_Conferenceroom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="CeilingTemp_Multipersonoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="CeilingTemp_Canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="CeilingTemp_Workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Hotwater_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Warmwater_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Coldwater_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Coldwater_heatpump_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Warmwater_heatpump_1_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Warmwater_heatpump_2_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Aircooler_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Hotwater_CHP_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_Hotwater_Boiler_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_Central_hot_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_OpenPlanOffice_hot_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_ConferenceRoom_hot_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_MultiPersonOffice_hot_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_Canteen_hot_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_Workshop_hot_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_Central_cold_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_OpenPlanOffice_cold_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_ConferenceRoom_cold_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_MultiPersonOffice_cold_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_Canteen_cold_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_RLT_Workshop_cold_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_OpenPlanOffice_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_ConferenceRoom_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_MultiPersonOffice_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_Canteen_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Pump_TBA_Workshop_y"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="OnOff_RLT"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="OnOff_Aircooler_small"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="OnOff_Aircooler_big"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Fan_Aircooler_small"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Fan_Aircooler_big"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Fan_RLT"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve1"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve2"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve3"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve4"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve5"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve6"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve7"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve8"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Hot_Central"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Hot_OpenPlanOffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Hot_ConferenceRoom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Hot_MultiPersonOffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Hot_Canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Hot_Workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Cold_Central"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Cold_OpenPlanOffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Cold_ConferenceRoom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Cold_MultiPersonOffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Cold_Canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_RLT_Cold_Workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_Warm_OpenPlanOffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_Warm_conferenceroom"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_Warm_multipersonoffice"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_Warm_canteen"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_Warm_workshop"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_OpenPlanOffice_Temp"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_ConferenceRoom_Temp"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_MultiPersonOffice_Temp"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_Canteen_Temp"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="Valve_TBA_Workshop_Temp"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="OnOff_heatpump_1"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="OnOff_heatpump_2"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="OnOff_CHP"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="OnOff_boiler"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="ElSet_CHP"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TSet_CHP"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="TSet_boiler"),
        MatchVariable(className="AixLib.Building.Benchmark.BusSystem.Logger*", name="X_Central")})});
      end Logger;

      model LogModel
        BusSystems.Logger_Bus_measure logger_Bus_measure
          annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
        BusSystems.Logger_Bus_Control logger_Bus_Control
          annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end LogModel;
    end BusSystems;

    package Evaluation
      model CostsFuelPower

        AixLib.Utilities.Time.CalendarTime calTim(
          zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2018,
          yearRef=2018,
          year(start=2018))
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Modelica.Blocks.Interfaces.RealInput fuel_in annotation(Placement(transformation(extent={{-120,30},
                  {-80,70}})));
        Modelica.Blocks.Interfaces.RealInput power_in
                                                     annotation(Placement(transformation(extent={{-120,
                  -70},{-80,-30}})));
        Modelica.Blocks.Interfaces.RealOutput Total_Cost
          annotation (Placement(transformation(extent={{80,-20},{120,20}})));
        Modelica.Blocks.Math.Product Power_Cost
          annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
        Modelica.Blocks.Math.IntegerToReal integerToReal
          annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
        Modelica.Blocks.Math.Gain fuel_cost(k=0.0609/(1000*3600))
          annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
        Modelica.Blocks.Tables.CombiTable2D combiTable2D(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[
              0.0,-1,0,0.0001,1; -1,0.105,0.105,0.19,0.19; 6,0.105,0.105,0.19,0.19;
              6.0001,0.105,0.105,0.27,0.27; 21.9999,0.105,0.105,0.27,0.27; 22,0.105,
              0.105,0.19,0.19; 25,0.105,0.105,0.19,0.19])
          annotation (Placement(transformation(extent={{4,74},{24,94}})));
        Modelica.Blocks.Interfaces.RealOutput minute "Minute of the hour"
          annotation (Placement(transformation(extent={{90,60},{110,80}})));
        Modelica.Blocks.Interfaces.IntegerOutput hour "Hour of the day"
          annotation (Placement(transformation(extent={{90,40},{110,60}})));
        Modelica.Blocks.Interfaces.IntegerOutput weekDay
          "Integer output representing week day (monday = 1, sunday = 7)"
          annotation (Placement(transformation(extent={{90,22},{110,42}})));
        Modelica.Blocks.Math.Gain gain1(k=1/(1000*3600))
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={28,44})));
        Modelica.Blocks.Interfaces.RealOutput Total_Power
          annotation (Placement(transformation(extent={{80,-60},{120,-20}})));
        Modelica.Blocks.Interfaces.RealOutput Total_Fuel
          annotation (Placement(transformation(extent={{80,-100},{120,-60}})));
      equation
        der(Total_Cost)=fuel_cost.y + Power_Cost.y;
        der(Total_Power)=power_in/(1000*3600);
        der(Total_Fuel)=fuel_in/(1000*3600);

        connect(Power_Cost.u2, power_in) annotation (Line(points={{38,-36},{20,-36},{20,
                -50},{-100,-50}}, color={0,0,127}));
        connect(calTim.hour, integerToReal.u) annotation (Line(points={{-79,96.2},{
                -54,96.2},{-54,90},{-42,90}}, color={255,127,0}));
        connect(fuel_cost.u, fuel_in)
          annotation (Line(points={{-42,50},{-100,50}}, color={0,0,127}));
        connect(integerToReal.y, combiTable2D.u1)
          annotation (Line(points={{-19,90},{2,90}}, color={0,0,127}));
        connect(combiTable2D.u2, power_in) annotation (Line(points={{2,78},{-10,78},{
                -10,-50},{-100,-50}}, color={0,0,127}));
        connect(calTim.minute, minute) annotation (Line(points={{-79,99},{-60,99},{
                -60,70},{100,70}}, color={0,0,127}));
        connect(calTim.hour, hour) annotation (Line(points={{-79,96.2},{-60,96.2},{
                -60,70},{76,70},{76,50},{100,50}}, color={255,127,0}));
        connect(calTim.weekDay, weekDay) annotation (Line(points={{-79,85},{-60,85},{
                -60,70},{76,70},{76,32},{100,32}}, color={255,127,0}));
        connect(combiTable2D.y, gain1.u)
          annotation (Line(points={{25,84},{28,84},{28,56}}, color={0,0,127}));
        connect(gain1.y, Power_Cost.u1)
          annotation (Line(points={{28,33},{28,-24},{38,-24}}, color={0,0,127}));
      end CostsFuelPower;

      model Evaluation
        CostsFuelPower costs
          annotation (Placement(transformation(extent={{26,-10},{46,10}})));
        BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Sum_Power sum_Power
          annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
        Modelica.Blocks.Math.Gain gain2(k=1000)
                                              annotation (Placement(transformation(
              extent={{-6,-6},{6,6}},
              rotation=0,
              origin={-24,30})));
      equation

        connect(measureBus, sum_Power.measureBus) annotation (Line(
            points={{-100,0},{-80,0},{-80,-30},{-60,-30}},
            color={255,204,51},
            thickness=0.5));
        connect(sum_Power.Sum_Power, costs.power_in) annotation (Line(points={{-40,-30},
                {-6,-30},{-6,-5},{26,-5}},        color={0,0,127}));
        connect(add.u2, measureBus.Fuel_CHP) annotation (Line(points={{-62,24},{-80,
                24},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add.u1, measureBus.Fuel_Boiler) annotation (Line(points={{-62,36},{
                -80,36},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(costs.Total_Cost, measureBus.Total_Cost) annotation (Line(points={{46,
                0},{60,0},{60,60},{-99.9,60},{-99.9,0.1}}, color={0,0,127}));
        connect(costs.minute, measureBus.Minute) annotation (Line(points={{46,7},{60,
                7},{60,6},{60,6},{60,60},{-99.9,60},{-99.9,0.1}}, color={0,0,127}));
        connect(costs.hour, measureBus.Hour) annotation (Line(points={{46,5},{54,5},{
                60,5},{60,6},{60,6},{60,6},{60,60},{-99.9,60},{-99.9,0.1}}, color={
                255,127,0}));
        connect(costs.weekDay, measureBus.WeekDay) annotation (Line(points={{46,3.2},
                {60,3.2},{60,4},{60,4},{60,60},{-99.9,60},{-99.9,0.1}}, color={255,
                127,0}));
        connect(add.y, gain2.u)
          annotation (Line(points={{-39,30},{-31.2,30}}, color={0,0,127}));
        connect(gain2.y, costs.fuel_in) annotation (Line(points={{-17.4,30},{-6,30},{
                -6,5},{26,5}}, color={0,0,127}));
        connect(costs.Total_Power, measureBus.Total_Power) annotation (Line(points={{
                46,-4},{60,-4},{60,60},{-99.9,60},{-99.9,0.1}}, color={0,0,127}));
        connect(costs.Total_Fuel, measureBus.Total_Fuel) annotation (Line(points={{46,
                -8},{60,-8},{60,60},{-99.9,60},{-99.9,0.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Evaluation;

      model Sum_Power
        BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Modelica.Blocks.Math.Add3 add3_1
          annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
        Modelica.Blocks.Math.Add3 add3_2
          annotation (Placement(transformation(extent={{-60,54},{-40,74}})));
        Modelica.Blocks.Math.Add3 add3_3
          annotation (Placement(transformation(extent={{-60,28},{-40,48}})));
        Modelica.Blocks.Math.Add3 add3_5
          annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
        Modelica.Blocks.Math.Add3 add3_6
          annotation (Placement(transformation(extent={{-60,-26},{-40,-6}})));
        Modelica.Blocks.Math.Add3 add3_7
          annotation (Placement(transformation(extent={{-60,-52},{-40,-32}})));
        Modelica.Blocks.Math.Add3 add3_8
          annotation (Placement(transformation(extent={{-60,-78},{-40,-58}})));
        Modelica.Blocks.Math.Add3 add3_9
          annotation (Placement(transformation(extent={{-18,30},{2,50}})));
        Modelica.Blocks.Math.Add3 add3_10
          annotation (Placement(transformation(extent={{-60,-104},{-40,-84}})));
        Modelica.Blocks.Math.MultiSum multiSum(nu=11, k={1,1,1,1,1,1,1,1,1,1,1})
          annotation (Placement(transformation(extent={{38,-18},{74,18}})));
        Modelica.Blocks.Interfaces.RealOutput Sum_Power
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Math.Add add1
          annotation (Placement(transformation(extent={{-16,-40},{4,-20}})));
        Modelica.Blocks.Math.Add3 add3_4
          annotation (Placement(transformation(extent={{-16,-12},{4,8}})));
      equation
        connect(add3_2.u1, measureBus.Pump_generation_hot_power) annotation (Line(
              points={{-62,72},{-80,72},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_2.u2, measureBus.Pump_Coldwater_heatpump_power) annotation (Line(
              points={{-62,64},{-80,64},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_2.u3, measureBus.Pump_Coldwater_power) annotation (Line(points={
                {-62,56},{-80,56},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_3.u2, measureBus.Pump_Hotwater_power) annotation (Line(points={{
                -62,38},{-80,38},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_3.u3, measureBus.Electrical_power_CHP) annotation (Line(points={
                {-62,30},{-80,30},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_5.u1, measureBus.Pump_RLT_central_warm) annotation (Line(points=
                {{-62,20},{-80,20},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_5.u2, measureBus.Pump_RLT_central_cold) annotation (Line(points=
                {{-62,12},{-80,12},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_5.u3, measureBus.Pump_RLT_openplanoffice_warm) annotation (Line(
              points={{-62,4},{-80,4},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_6.u1, measureBus.Pump_RLT_openplanoffice_cold) annotation (Line(
              points={{-62,-8},{-80,-8},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_6.u2, measureBus.Pump_RLT_conferenceroom_warm) annotation (Line(
              points={{-62,-16},{-80,-16},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_6.u3, measureBus.Pump_RLT_conferenceroom_cold) annotation (Line(
              points={{-62,-24},{-80,-24},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_7.u1, measureBus.Pump_RLT_multipersonoffice_warm) annotation (
            Line(points={{-62,-34},{-80,-34},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_7.u2, measureBus.Pump_RLT_multipersonoffice_cold) annotation (
            Line(points={{-62,-42},{-80,-42},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_7.u3, measureBus.Pump_RLT_canteen_warm) annotation (Line(points=
                {{-62,-50},{-80,-50},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_8.u1, measureBus.Pump_RLT_canteen_cold) annotation (Line(points=
                {{-62,-60},{-80,-60},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_8.u2, measureBus.Pump_RLT_workshop_warm) annotation (Line(points=
               {{-62,-68},{-80,-68},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_8.u3, measureBus.Pump_RLT_workshop_cold) annotation (Line(points=
               {{-62,-76},{-80,-76},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_9.u3, measureBus.Pump_TBA_openplanoffice) annotation (Line(
              points={{-20,32},{-30,32},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_9.u2, measureBus.Pump_TBA_conferenceroom) annotation (Line(
              points={{-20,40},{-30,40},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_9.u1, measureBus.Pump_TBA_multipersonoffice) annotation (Line(
              points={{-20,48},{-30,48},{-30,48},{-30,48},{-30,0.1},{-99.9,0.1}},
              color={0,0,127}));
        connect(add3_10.u1, measureBus.Pump_TBA_canteen) annotation (Line(points={{
                -62,-86},{-80,-86},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_10.u2, measureBus.Pump_TBA_workshop) annotation (Line(points={{
                -62,-94},{-80,-94},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(multiSum.u[1], add3_1.y) annotation (Line(points={{38,11.4545},{18,
                11.4545},{18,90},{-39,90}},
                                          color={0,0,127}));
        connect(multiSum.u[2], add3_9.y) annotation (Line(points={{38,9.16364},{18,
                9.16364},{18,8},{18,8},{18,40},{3,40}},
                                               color={0,0,127}));
        connect(multiSum.u[3], add3_2.y) annotation (Line(points={{38,6.87273},{18,
                6.87273},{18,6},{18,6},{18,64},{-39,64}},
                                                color={0,0,127}));
        connect(multiSum.u[4], add3_3.y) annotation (Line(points={{38,4.58182},{18,
                4.58182},{18,2},{18,2},{18,38},{-39,38}},
                                                 color={0,0,127}));
        connect(multiSum.u[5], add3_5.y) annotation (Line(points={{38,2.29091},{18,
                2.29091},{18,0},{18,0},{18,12},{-39,12}},
                                                 color={0,0,127}));
        connect(multiSum.u[6], add3_6.y) annotation (Line(points={{38,6.66134e-016},{
                18,6.66134e-016},{18,-16},{-39,-16}},
                                            color={0,0,127}));
        connect(multiSum.u[7], add3_7.y) annotation (Line(points={{38,-2.29091},{18,
                -2.29091},{18,-42},{-39,-42}},
                                            color={0,0,127}));
        connect(multiSum.u[8], add3_8.y) annotation (Line(points={{38,-4.58182},{18,
                -4.58182},{18,-68},{-39,-68}},
                                     color={0,0,127}));
        connect(multiSum.u[9], add3_10.y) annotation (Line(points={{38,-6.87273},{18,
                -6.87273},{18,-94},{-39,-94}},
                                            color={0,0,127}));
        connect(add3_10.u3, measureBus.InternalLoad_Power) annotation (Line(points={{
                -62,-102},{-80,-102},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(multiSum.y, Sum_Power)
          annotation (Line(points={{77.06,0},{100,0}}, color={0,0,127}));
        connect(multiSum.y, measureBus.Sum_Power) annotation (Line(points={{77.06,0},
                {88,0},{88,108},{-99.9,108},{-99.9,0.1}}, color={0,0,127}));
        connect(add1.u1, measureBus.Fan_RLT) annotation (Line(points={{-18,-24},{-30,
                -24},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add1.u2, measureBus.Fan_Aircooler) annotation (Line(points={{-18,-36},
                {-30,-36},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add1.y, multiSum.u[10]) annotation (Line(points={{5,-30},{12,-30},{12,
                -30},{18,-30},{18,-9.16364},{38,-9.16364}}, color={0,0,127}));
        connect(add3_1.u2, measureBus.Heatpump_1_power) annotation (Line(points={{-62,
                90},{-80,90},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_1.u3, measureBus.Heatpump_2_power) annotation (Line(points={{-62,
                82},{-80,82},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_4.y, multiSum.u[11]) annotation (Line(points={{5,-2},{18,-2},{18,
                -12},{18,-12},{18,-12},{18,-11.4545},{38,-11.4545},{38,-11.4545}},
              color={0,0,127}));
        connect(add3_3.u1, measureBus.Pump_generation_hot_power_Boiler) annotation (
            Line(points={{-62,46},{-80,46},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_4.u3, measureBus.PV_Power) annotation (Line(points={{-18,-10},{
                -30,-10},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_1.u1, measureBus.Pump_Warmwater_power) annotation (Line(points={
                {-62,98},{-80,98},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_4.u1, measureBus.Pump_Warmwater_heatpump_1_power) annotation (
            Line(points={{-18,6},{-30,6},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(add3_4.u2, measureBus.Pump_Warmwater_heatpump_2_power) annotation (
            Line(points={{-18,-2},{-30,-2},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Sum_Power;
    end Evaluation;

    package InternalLoad
      model InternalLoads
        InternalLoads_Power internalLoads_Power
          annotation (Placement(transformation(extent={{-10,50},{10,70}})));
        InternalLoads_Water internalLoads_Water
          annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b AddPower[5]
          annotation (Placement(transformation(extent={{84,50},{104,70}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
                                                              tableOnFile=true,
          tableName="final",
          timeScale=1,
          columns={2,3,4,5,6,7,8,9,10,11},
          final fileName=Modelica.Utilities.Files.loadResource(
              "modelica://AixLib/Building/Benchmark/InternalLoads/InternalLoads_v2.mat"))
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

        BusSystems.InternalBus internalBus
          annotation (Placement(transformation(extent={{72,-40},{112,-80}})));
        BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{72,20},{112,-20}})));
      equation
        connect(internalLoads_Power.AddPower, AddPower)
          annotation (Line(points={{10,60},{94,60}}, color={191,0,0}));
        connect(internalLoads_Power.u1, combiTimeTable1.y) annotation (Line(points={{
                -10,60},{-40,60},{-40,0},{-59,0}}, color={0,0,127}));
        connect(internalLoads_Water.u1, combiTimeTable1.y) annotation (Line(points={{
                -10,-60},{-40,-60},{-40,0},{-59,0}}, color={0,0,127}));
        connect(internalLoads_Water.WaterPerRoom[1], internalBus.InternalLoads_MFlow_Openplanoffice)
          annotation (Line(points={{10,-60.8},{32,-60.8},{32,-60},{54.1,-60},{54.1,-60.1},
                {92.1,-60.1}}, color={0,0,127}));
        connect(internalLoads_Water.WaterPerRoom[2], internalBus.InternalLoads_MFlow_Conferenceroom)
          annotation (Line(points={{10,-60.4},{34,-60.4},{34,-60},{56.1,-60},{56.1,-60.1},
                {92.1,-60.1}}, color={0,0,127}));
        connect(internalLoads_Water.WaterPerRoom[3], internalBus.InternalLoads_MFlow_Multipersonoffice)
          annotation (Line(points={{10,-60},{56,-60},{56,-60.1},{92.1,-60.1}}, color=
                {0,0,127}));
        connect(internalLoads_Water.WaterPerRoom[4], internalBus.InternalLoads_MFlow_Canteen)
          annotation (Line(points={{10,-59.6},{36,-59.6},{36,-60},{60.1,-60},{60.1,-60.1},
                {92.1,-60.1}}, color={0,0,127}));
        connect(internalLoads_Water.WaterPerRoom[5], internalBus.InternalLoads_MFlow_Workshop)
          annotation (Line(points={{10,-59.2},{34,-59.2},{34,-60},{56.1,-60},{56.1,-60.1},
                {92.1,-60.1}}, color={0,0,127}));
        connect(internalLoads_Power.Power_Sum, measureBus.InternalLoad_Power)
          annotation (Line(points={{10,53.8},{52,53.8},{52,-0.1},{92.1,-0.1}}, color=
                {0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end InternalLoads;

      model InternalLoads_Power
        Modelica.Blocks.Math.Gain Met_OpenPlanOffice(k=1.2*1.8*58)
          annotation (Placement(transformation(extent={{-14,84},{-2,96}})));
        Modelica.Blocks.Math.Gain Met_Workshop(k=2*1.8*58)
          annotation (Placement(transformation(extent={{-14,8},{-2,20}})));
        Modelica.Blocks.Math.Gain PowerEquiment_OpenPlanOffice(k=50)
          annotation (Placement(transformation(extent={{-42,74},{-30,86}})));
        Modelica.Blocks.Math.Gain PowerEquiment_Workshop(k=200)
          annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
        Modelica.Blocks.Math.Add3 add3_1
          annotation (Placement(transformation(extent={{28,30},{40,42}})));
        Modelica.Blocks.Math.Gain PowerEquiment_Cooking(k=213)
          annotation (Placement(transformation(extent={{-42,18},{-30,30}})));
        Modelica.Blocks.Interfaces.RealInput u1[10] "Input signal connector"
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Modelica.Blocks.Math.Gain Met_MultiPersonOffice(k=1.2*1.8*58)
          annotation (Placement(transformation(extent={{-14,66},{-2,78}})));
        Modelica.Blocks.Math.Gain Met_Conferenceroom(k=1.2*1.8*58)
          annotation (Placement(transformation(extent={{-14,48},{-2,60}})));
        Modelica.Blocks.Math.Gain Met_Canteen(k=1.2*1.8*58)
          annotation (Placement(transformation(extent={{-14,28},{-2,40}})));
        Modelica.Blocks.Math.Add3 add3_2
          annotation (Placement(transformation(extent={{28,12},{40,24}})));
        Modelica.Blocks.Math.Add3 add3_3
          annotation (Placement(transformation(extent={{28,-6},{40,6}})));
        Modelica.Blocks.Math.Add3 add3_4
          annotation (Placement(transformation(extent={{28,-26},{40,-14}})));
        Modelica.Blocks.Math.Add3 add3_5
          annotation (Placement(transformation(extent={{28,-46},{40,-34}})));
        Modelica.Blocks.Math.Gain PowerEquiment_MultiPersonOffice(k=50)
          annotation (Placement(transformation(extent={{-42,56},{-30,68}})));
        Modelica.Blocks.Math.Gain PowerEquiment_Conferenceroom(k=20)
          annotation (Placement(transformation(extent={{-42,38},{-30,50}})));
        Modelica.Blocks.Math.Gain Light_OpenPlanOffice(k=4737)
          annotation (Placement(transformation(extent={{-42,-22},{-30,-10}})));
        Modelica.Blocks.Math.Gain Light_MultipersonOffice(k=421)
          annotation (Placement(transformation(extent={{-42,-40},{-30,-28}})));
        Modelica.Blocks.Math.Gain Light_Conferenceroom(k=210)
          annotation (Placement(transformation(extent={{-42,-58},{-30,-46}})));
        Modelica.Blocks.Math.Gain Light_Canteen(k=5684)
          annotation (Placement(transformation(extent={{-42,-76},{-30,-64}})));
        Modelica.Blocks.Math.Gain Light_Workshop(k=2210)
          annotation (Placement(transformation(extent={{-42,-94},{-30,-82}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[5]
          annotation (Placement(transformation(extent={{54,-10},{74,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b AddPower[5]
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Math.MultiSum multiSum(               nu=10, k={1,1,1,1,1,1,1,
              1,1,1})
          annotation (Placement(transformation(extent={{54,-68},{66,-56}})));
        Modelica.Blocks.Interfaces.RealOutput Power_Sum
          annotation (Placement(transformation(extent={{90,-72},{110,-52}})));
      equation
        connect(Met_OpenPlanOffice.y, add3_1.u1) annotation (Line(points={{-1.4,90},{
                20,90},{20,40.8},{26.8,40.8}}, color={0,0,127}));
        connect(Met_MultiPersonOffice.y, add3_2.u1) annotation (Line(points={{-1.4,72},
                {20,72},{20,22.8},{26.8,22.8}}, color={0,0,127}));
        connect(Met_Conferenceroom.y, add3_3.u1) annotation (Line(points={{-1.4,54},{
                20,54},{20,4.8},{26.8,4.8}}, color={0,0,127}));
        connect(Met_Canteen.y, add3_4.u1) annotation (Line(points={{-1.4,34},{20,34},
                {20,-15.2},{26.8,-15.2}}, color={0,0,127}));
        connect(Met_Workshop.y, add3_5.u1) annotation (Line(points={{-1.4,14},{20,14},
                {20,-35.2},{26.8,-35.2}}, color={0,0,127}));
        connect(PowerEquiment_OpenPlanOffice.u, u1[1]) annotation (Line(points={{
                -43.2,80},{-60,80},{-60,-18},{-100,-18}}, color={0,0,127}));
        connect(Met_OpenPlanOffice.u, u1[1]) annotation (Line(points={{-15.2,90},{-60,
                90},{-60,-18},{-100,-18}}, color={0,0,127}));
        connect(Met_MultiPersonOffice.u, u1[3]) annotation (Line(points={{-15.2,72},{
                -60,72},{-60,-10},{-100,-10}}, color={0,0,127}));
        connect(PowerEquiment_MultiPersonOffice.u, u1[3]) annotation (Line(points={{
                -43.2,62},{-60,62},{-60,-10},{-100,-10}}, color={0,0,127}));
        connect(Met_Conferenceroom.u, u1[2]) annotation (Line(points={{-15.2,54},{-60,
                54},{-60,-14},{-100,-14}}, color={0,0,127}));
        connect(PowerEquiment_Conferenceroom.u, u1[2]) annotation (Line(points={{
                -43.2,44},{-60,44},{-60,-14},{-100,-14}}, color={0,0,127}));
        connect(Met_Canteen.u, u1[4]) annotation (Line(points={{-15.2,34},{-60,34},{
                -60,-6},{-100,-6}}, color={0,0,127}));
        connect(PowerEquiment_Cooking.u, u1[4]) annotation (Line(points={{-43.2,24},{
                -60,24},{-60,-6},{-100,-6}}, color={0,0,127}));
        connect(Met_Workshop.u, u1[5]) annotation (Line(points={{-15.2,14},{-60,14},{
                -60,-2},{-100,-2}}, color={0,0,127}));
        connect(PowerEquiment_Workshop.u, u1[5]) annotation (Line(points={{-43.2,4},{
                -60,4},{-60,-2},{-100,-2}}, color={0,0,127}));
        connect(PowerEquiment_OpenPlanOffice.y, add3_1.u3) annotation (Line(points={{
                -29.4,80},{20,80},{20,32},{26,32},{26,32},{26,31.2},{26.8,31.2}},
              color={0,0,127}));
        connect(PowerEquiment_MultiPersonOffice.y, add3_2.u3) annotation (Line(points=
               {{-29.4,62},{20,62},{20,14},{24,14},{24,13.2},{26.8,13.2}}, color={0,0,
                127}));
        connect(PowerEquiment_Conferenceroom.y, add3_3.u3) annotation (Line(points={{
                -29.4,44},{20,44},{20,-4},{24,-4},{24,-4.8},{26.8,-4.8}}, color={0,0,
                127}));
        connect(PowerEquiment_Cooking.y, add3_4.u3) annotation (Line(points={{-29.4,
                24},{20,24},{20,-24},{24,-24},{24,-24.8},{26.8,-24.8}}, color={0,0,
                127}));
        connect(PowerEquiment_Workshop.y, add3_5.u3) annotation (Line(points={{-29.4,4},
                {20,4},{20,-44},{24,-44},{24,-44.8},{26.8,-44.8}},    color={0,0,127}));
        connect(Light_OpenPlanOffice.u, u1[6]) annotation (Line(points={{-43.2,-16},{
                -60,-16},{-60,2},{-100,2}}, color={0,0,127}));
        connect(Light_MultipersonOffice.u, u1[8]) annotation (Line(points={{-43.2,-34},
                {-52,-34},{-52,-34},{-60,-34},{-60,10},{-100,10}}, color={0,0,127}));
        connect(Light_Conferenceroom.u, u1[7]) annotation (Line(points={{-43.2,-52},{
                -60,-52},{-60,6},{-100,6}}, color={0,0,127}));
        connect(Light_Canteen.u, u1[9]) annotation (Line(points={{-43.2,-70},{-60,-70},
                {-60,14},{-100,14}}, color={0,0,127}));
        connect(Light_Workshop.u, u1[10]) annotation (Line(points={{-43.2,-88},{-60,
                -88},{-60,18},{-100,18}}, color={0,0,127}));
        connect(add3_1.y, prescribedHeatFlow[1].Q_flow) annotation (Line(points={{
                40.6,36},{46,36},{46,0},{54,0}}, color={0,0,127}));
        connect(add3_2.y, prescribedHeatFlow[3].Q_flow) annotation (Line(points={{
                40.6,18},{46,18},{46,0},{54,0}}, color={0,0,127}));
        connect(add3_3.y, prescribedHeatFlow[2].Q_flow)
          annotation (Line(points={{40.6,0},{54,0}}, color={0,0,127}));
        connect(add3_4.y, prescribedHeatFlow[4].Q_flow) annotation (Line(points={{
                40.6,-20},{46,-20},{46,0},{54,0}}, color={0,0,127}));
        connect(add3_5.y, prescribedHeatFlow[5].Q_flow) annotation (Line(points={{
                40.6,-40},{46,-40},{46,0},{54,0}}, color={0,0,127}));
        connect(prescribedHeatFlow.port, AddPower)
          annotation (Line(points={{74,0},{100,0}}, color={191,0,0}));
        connect(multiSum.y, Power_Sum)
          annotation (Line(points={{67.02,-62},{100,-62}}, color={0,0,127}));
        connect(PowerEquiment_Workshop.y, multiSum.u[1]) annotation (Line(points={{-29.4,4},
                {-14,4},{-14,4},{20,4},{20,-58.22},{54,-58.22}},          color={0,0,
                127}));
        connect(PowerEquiment_Cooking.y, multiSum.u[2]) annotation (Line(points={{-29.4,
                24},{-10,24},{-10,24},{20,24},{20,-59.06},{54,-59.06}},       color={
                0,0,127}));
        connect(PowerEquiment_Conferenceroom.y, multiSum.u[3]) annotation (Line(
              points={{-29.4,44},{-10,44},{-10,44},{20,44},{20,-59.9},{54,-59.9}},
              color={0,0,127}));
        connect(PowerEquiment_MultiPersonOffice.y, multiSum.u[4]) annotation (Line(
              points={{-29.4,62},{-10,62},{-10,62},{20,62},{20,-60.74},{54,-60.74}},
              color={0,0,127}));
        connect(PowerEquiment_OpenPlanOffice.y, multiSum.u[5])  annotation (Line(
              points={{-29.4,80},{-10,80},{-10,80},{20,80},{20,-61.58},{54,-61.58}},
              color={0,0,127}));
        connect(Light_OpenPlanOffice.y, add3_1.u2) annotation (Line(points={{-29.4,
                -16},{8,-16},{8,36},{26.8,36}}, color={0,0,127}));
        connect(Light_MultipersonOffice.y, add3_2.u2) annotation (Line(points={{-29.4,
                -34},{8,-34},{8,18},{26.8,18}}, color={0,0,127}));
        connect(Light_Conferenceroom.y, add3_3.u2) annotation (Line(points={{-29.4,
                -52},{-12,-52},{-12,-52},{8,-52},{8,0},{26.8,0}}, color={0,0,127}));
        connect(Light_Canteen.y, add3_4.u2) annotation (Line(points={{-29.4,-70},{-10,
                -70},{-10,-70},{8,-70},{8,-20},{26.8,-20}}, color={0,0,127}));
        connect(Light_Workshop.y, add3_5.u2) annotation (Line(points={{-29.4,-88},{8,
                -88},{8,-40},{26.8,-40}}, color={0,0,127}));
        connect(Light_OpenPlanOffice.y, multiSum.u[6]) annotation (Line(points={{
                -29.4,-16},{8,-16},{8,-62},{32,-62},{32,-62.42},{54,-62.42}}, color={
                0,0,127}));
        connect(Light_MultipersonOffice.y, multiSum.u[7]) annotation (Line(points={{
                -29.4,-34},{8,-34},{8,-64},{32,-64},{32,-63.26},{54,-63.26}}, color={
                0,0,127}));
        connect(Light_Conferenceroom.y, multiSum.u[8]) annotation (Line(points={{
                -29.4,-52},{8,-52},{8,-64},{32,-64},{32,-64.1},{54,-64.1}}, color={0,
                0,127}));
        connect(Light_Canteen.y, multiSum.u[9]) annotation (Line(points={{-29.4,-70},
                {20,-70},{20,-64.94},{54,-64.94}}, color={0,0,127}));
        connect(Light_Workshop.y, multiSum.u[10]) annotation (Line(points={{-29.4,-88},
                {22,-88},{22,-65.78},{54,-65.78}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end InternalLoads_Power;

      model InternalLoads_Water
        Modelica.Blocks.Math.Gain WaterPerson_OpenPlanOffice(k=0.05/3600)
          annotation (Placement(transformation(extent={{-60,74},{-48,86}})));
        Modelica.Blocks.Math.Gain WaterPerson_MultipersonOffice(k=0.05/3600)
          annotation (Placement(transformation(extent={{-60,34},{-48,46}})));
        Modelica.Blocks.Math.Gain WaterPerson_Conferenceroom(k=0.05/3600)
          annotation (Placement(transformation(extent={{-60,-6},{-48,6}})));
        Modelica.Blocks.Math.Gain WaterPerson_Canteen(k=0.1/3600)
          annotation (Placement(transformation(extent={{-60,-46},{-48,-34}})));
        Modelica.Blocks.Math.Gain WaterPerson_Workshop(k=0.113/3600)
          annotation (Placement(transformation(extent={{-60,-86},{-48,-74}})));
        Modelica.Blocks.Interfaces.RealInput u1[10] "Input signal connector"
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Modelica.Blocks.Sources.RealExpression FixWater_OpenPlanOffice(y=1.125/3600)
          annotation (Placement(transformation(extent={{-64,48},{-44,68}})));
        Modelica.Blocks.Sources.RealExpression FixWater_MultiPersonOffice(y=0.075/
              3600)
          annotation (Placement(transformation(extent={{-64,10},{-44,30}})));
        Modelica.Blocks.Sources.RealExpression FixWater_Canteen(y=1.25/3600)
          annotation (Placement(transformation(extent={{-64,-70},{-44,-50}})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{20,64},{32,76}})));
        Modelica.Blocks.Math.Add add1
          annotation (Placement(transformation(extent={{20,24},{32,36}})));
        Modelica.Blocks.Math.Add add3
          annotation (Placement(transformation(extent={{20,-56},{32,-44}})));
        Modelica.Blocks.Interfaces.RealOutput WaterPerRoom[5]
          "Output signal connector"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      equation
        connect(WaterPerson_Conferenceroom.u, u1[2]) annotation (Line(points={{-61.2,
                0},{-80,0},{-80,-14},{-100,-14}}, color={0,0,127}));
        connect(WaterPerson_MultipersonOffice.u, u1[3]) annotation (Line(points={{
                -61.2,40},{-80,40},{-80,-10},{-100,-10},{-100,-10}}, color={0,0,127}));
        connect(WaterPerson_OpenPlanOffice.u, u1[1]) annotation (Line(points={{-61.2,
                80},{-80,80},{-80,-18},{-100,-18},{-100,-18}}, color={0,0,127}));
        connect(WaterPerson_Canteen.u, u1[4]) annotation (Line(points={{-61.2,-40},{
                -80,-40},{-80,-6},{-100,-6},{-100,-6}}, color={0,0,127}));
        connect(WaterPerson_Workshop.u, u1[5]) annotation (Line(points={{-61.2,-80},{
                -72,-80},{-72,-80},{-80,-80},{-80,-2},{-100,-2},{-100,-2}}, color={0,
                0,127}));
        connect(WaterPerson_OpenPlanOffice.y, add.u1) annotation (Line(points={{-47.4,
                80},{8,80},{8,73.6},{18.8,73.6}}, color={0,0,127}));
        connect(FixWater_OpenPlanOffice.y, add.u2) annotation (Line(points={{-43,58},
                {8,58},{8,66.4},{18.8,66.4}}, color={0,0,127}));
        connect(WaterPerson_MultipersonOffice.y, add1.u1) annotation (Line(points={{
                -47.4,40},{8,40},{8,33.6},{18.8,33.6}}, color={0,0,127}));
        connect(FixWater_MultiPersonOffice.y, add1.u2) annotation (Line(points={{-43,
                20},{8,20},{8,26.4},{18.8,26.4}}, color={0,0,127}));
        connect(WaterPerson_Canteen.y, add3.u1) annotation (Line(points={{-47.4,-40},
                {8,-40},{8,-46.4},{18.8,-46.4}}, color={0,0,127}));
        connect(FixWater_Canteen.y, add3.u2) annotation (Line(points={{-43,-60},{8,
                -60},{8,-53.6},{18.8,-53.6}}, color={0,0,127}));
        connect(add.y, WaterPerRoom[1]) annotation (Line(points={{32.6,70},{80,70},{
                80,-8},{100,-8}}, color={0,0,127}));
        connect(add1.y, WaterPerRoom[3]) annotation (Line(points={{32.6,30},{80,30},{
                80,0},{100,0}}, color={0,0,127}));
        connect(WaterPerson_Conferenceroom.y, WaterPerRoom[2]) annotation (Line(
              points={{-47.4,0},{80,0},{80,-4},{100,-4}}, color={0,0,127}));
        connect(add3.y, WaterPerRoom[4]) annotation (Line(points={{32.6,-50},{80,-50},
                {80,4},{100,4}}, color={0,0,127}));
        connect(WaterPerson_Workshop.y, WaterPerRoom[5]) annotation (Line(points={{-47.4,
                -80},{80,-80},{80,8},{100,8}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false), graphics={Text(
                extent={{34,98},{96,78}},
                lineColor={28,108,200},
                textString="Parameter nachgucken")}));
      end InternalLoads_Water;
    end InternalLoad;

    package Generation
      model Generation_Hot
      //  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
        replaceable package Medium_Water =
          AixLib.Media.Water "Medium in the component";

          parameter Real m_flow_nominal_generation_hot = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.Pressure dpValve_nominal_generation_hot = 0 annotation(Dialog(tab = "General"));

        Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_Hot(redeclare package
            Medium =
              Medium_Water)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,28},{110,48}})));
        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_Hot(redeclare package
            Medium =
              Medium_Water)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{86,-48},{106,-28}})));

        Boiler_Benchmark boiler_Benchmark(
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_hot,
          transferHeat=true,
          paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_60kW(),
          TAmb=298.15)
          annotation (Placement(transformation(extent={{10,46},{30,66}})));

        Fluid.Actuators.Valves.ThreeWayLinear Valve6(
          y_start=1,
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_hot,
          CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=dpValve_nominal_generation_hot,
          use_inputFilter=false)
          annotation (Placement(transformation(extent={{8,26},{-12,6}})));

        Fluid.BoilerCHP.CHP cHP(
          electricityDriven=true,
          TSetIn=true,
          redeclare package Medium = Medium_Water,
          minCapacity=24,
          transferHeat=true,
          param=DataBase.CHP.CHP_FMB_31_GSK(),
          m_flow_small=0.0001,
          final m_flow_nominal=m_flow_nominal_generation_hot,
          TAmb=298.15)
          annotation (Placement(transformation(extent={{-86,6},{-66,26}})));

        BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
                 {{-60,80},{-20,120}}), iconTransformation(extent={{-50,90},{-30,110}})));
        Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
              Medium_Water,
            redeclare Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per,
          y_start=1)
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=0,
              origin={-38,16})));
        Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
        Fluid.Sensors.Temperature senTem1(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{-52,-20},{-32,0}})));
        Fluid.Sensors.Temperature senTem2(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{70,38},{90,58}})));
        BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
                 {{10,70},{50,110}}), iconTransformation(extent={{30,88},{50,110}})));
        Modelica.Blocks.Math.Gain gain2(k=-1000)
                                              annotation (Placement(transformation(
              extent={{-3,-3},{3,3}},
              rotation=90,
              origin={-81,33})));
        Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium =
              Medium_Water,
            redeclare
            Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per,
          y_start=1)
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=90,
              origin={-2,48})));
        Fluid.Sources.Boundary_pT bou3(
          p=100000,
          redeclare package Medium = Medium_Water,
          nPorts=1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=-90,
              origin={-62,54})));
      equation
        connect(Valve6.port_1, Fluid_out_Hot) annotation (Line(points={{8,16},{70,16},
                {70,38},{100,38}}, color={0,127,255}));
        connect(boiler_Benchmark.port_b, Fluid_out_Hot) annotation (Line(points={{30,
                56},{70,56},{70,38},{100,38}}, color={0,127,255}));
        connect(boiler_Benchmark.isOn, controlBus.OnOff_boiler) annotation (Line(
              points={{25,47},{25,40},{-39.9,40},{-39.9,100.1}},
                                                             color={255,0,255}));
        connect(cHP.on, controlBus.OnOff_CHP) annotation (Line(points={{-73,7},{-73,0},
                {-50,0},{-50,40},{-39.9,40},{-39.9,100.1}},
                                                        color={255,0,255}));
        connect(Valve6.y, controlBus.Valve6) annotation (Line(points={{-2,4},{-2,-2},{
                -20,-2},{-20,40},{-40,40},{-40,70},{-39.9,70},{-39.9,100.1}},
                                                       color={0,0,127}));
        connect(cHP.elSet, controlBus.ElSet_CHP) annotation (Line(points={{-83,22},{-88,
                22},{-88,40},{-39.9,40},{-39.9,100.1}}, color={0,0,127}));
        connect(cHP.TSet, controlBus.TSet_CHP) annotation (Line(points={{-83,10},{-88,
                10},{-88,0},{-50,0},{-50,40},{-39.9,40},{-39.9,100.1}},
                                                                    color={0,0,127}));
        connect(boiler_Benchmark.TSet, controlBus.TSet_boiler)
          annotation (Line(points={{13,63},{-39.9,63},{-39.9,100.1}},
                                                                  color={0,0,127}));
        connect(fan2.port_b, Valve6.port_2)
          annotation (Line(points={{-30,16},{-12,16}}, color={0,127,255}));
        connect(fan2.y, controlBus.Pump_Hotwater_CHP_y) annotation (Line(points={{-38,
                25.6},{-38,40},{-39.9,40},{-39.9,100.1}},
                                                      color={0,0,127}));
        connect(senMasFlo.port_b, cHP.port_a) annotation (Line(points={{-30,-20},{-86,
                -20},{-86,16}}, color={0,127,255}));
        connect(senMasFlo.port_b, senTem1.port)
          annotation (Line(points={{-30,-20},{-42,-20}}, color={0,127,255}));
        connect(senTem2.port, Fluid_out_Hot)
          annotation (Line(points={{80,38},{100,38}}, color={0,127,255}));
        connect(senTem2.T, measureBus.generation_hot_out) annotation (Line(points={{87,
                48},{92,48},{92,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
        connect(senTem1.T, measureBus.generation_hot_in) annotation (Line(points={{-35,
                -10},{-34,-10},{-34,-2},{-20,-2},{-20,40},{30.1,40},{30.1,90.1}},
              color={0,0,127}));
        connect(senMasFlo.m_flow, measureBus.generation_hot_massflow) annotation (
            Line(points={{-20,-9},{-20,40},{30.1,40},{30.1,90.1}}, color={0,0,127}));
        connect(fan2.P, measureBus.Pump_generation_hot_power) annotation (Line(points=
               {{-29.2,23.2},{-20,23.2},{-20,40},{30.1,40},{30.1,90.1}}, color={0,0,
                127}));
        connect(boiler_Benchmark.Fuel_Input, measureBus.Fuel_Boiler) annotation (Line(
              points={{30,64},{36,64},{36,70},{30.1,70},{30.1,90.1}}, color={0,0,127}));
        connect(cHP.fuelInput, measureBus.Fuel_CHP) annotation (Line(points={{-74,25},
                {-74,40},{30.1,40},{30.1,90.1}}, color={0,0,127}));
        connect(cHP.electricalPower, gain2.u) annotation (Line(points={{-81,25},{-81,
                26.5},{-81,26.5},{-81,29.4}}, color={0,0,127}));
        connect(gain2.y, measureBus.Electrical_power_CHP) annotation (Line(points={{
                -81,36.3},{-80,36.3},{-80,40},{30.1,40},{30.1,90.1}}, color={0,0,127}));
        connect(senMasFlo.port_a, Fluid_in_Hot) annotation (Line(points={{-10,-20},{
                70,-20},{70,-38},{96,-38}}, color={0,127,255}));
        connect(fan1.port_a, Valve6.port_3)
          annotation (Line(points={{-2,40},{-2,26}}, color={0,127,255}));
        connect(fan1.port_b, boiler_Benchmark.port_a)
          annotation (Line(points={{-2,56},{10,56}}, color={0,127,255}));
        connect(fan1.y, controlBus.Pump_Hotwater_Boiler_y) annotation (Line(points={{
                -11.6,48},{-39.9,48},{-39.9,100.1}}, color={0,0,127}));
        connect(fan1.P, measureBus.Pump_generation_hot_power_Boiler) annotation (Line(
              points={{-9.2,56.8},{-9.2,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
        connect(cHP.port_b, fan2.port_a)
          annotation (Line(points={{-66,16},{-46,16}}, color={0,127,255}));
        connect(bou3.ports[1], cHP.port_b)
          annotation (Line(points={{-62,50},{-62,16},{-66,16}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Generation_Hot;

      model Generation_heatPump
        replaceable package Medium_Water =
          AixLib.Media.Water "Medium in the component";

          parameter Modelica.SIunits.Temp_K T_conMax_1 = 328.15 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.Temp_K T_conMax_2 = 328.15 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 20000 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.Volume vol_1 = 0.012 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.Volume vol_2 = 0.024 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.ThermalConductance R_loss_1 = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.ThermalConductance R_loss_2 = 0 annotation(Dialog(tab = "General"));
        Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,50},{110,70}})));
        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-70},{110,-50}})));

        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Evaporator fluid input port"
          annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
        Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package
            Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Evaporator fluid output port"
          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed_1(
          capCalcType=2,
          P_eleOutput=true,
          CoP_output=true,
          redeclare package Medium_con = Medium_Water,
          redeclare package Medium_eva = Medium_Water,
          heatLosses_con=true,
          dataTable=DataBase.HeatPump.EN14511.Benchmark_Heatpump_Big(),
          factorScale=1,
          CorrFlowEv=false,
          dp_evaNominal=dpHeatexchanger_nominal/90,
          PT1_cycle=true,
          timeConstantCycle=30,
          volume_eva=vol_1,
          volume_con=vol_1,
          R_loss=R_loss_1,
          T_conMax=T_conMax_1,
          dp_conNominal=dpHeatexchanger_nominal/120,
          T_startEva=283.15,
          T_startCon=313.15)
          annotation (Placement(transformation(extent={{-14,18},{16,38}})));

        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater,
          p=100000,
          nPorts=1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=-90,
              origin={50,-22})));
        BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
                 {{-60,80},{-20,120}}), iconTransformation(extent={{-50,90},{-30,110}})));
        Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium =
              Medium_Water,
          y_start=1,
          redeclare Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per)
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=0,
              origin={42,60})));
        Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed_2(
          capCalcType=2,
          P_eleOutput=true,
          CoP_output=true,
          redeclare package Medium_con = Medium_Water,
          redeclare package Medium_eva = Medium_Water,
          heatLosses_con=true,
          factorScale=1,
          CorrFlowEv=false,
          dp_evaNominal=dpHeatexchanger_nominal/90,
          PT1_cycle=true,
          timeConstantCycle=30,
          dataTable=DataBase.HeatPump.EN14511.Benchmark_Heatpump_Big(),
          volume_eva=vol_2,
          volume_con=vol_2,
          R_loss=R_loss_2,
          T_conMax=T_conMax_2,
          dp_conNominal=dpHeatexchanger_nominal/120,
          T_startEva=283.15,
          T_startCon=313.15)
          annotation (Placement(transformation(extent={{-14,-38},{16,-18}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 25)
          annotation (Placement(transformation(extent={{-76,-24},{-56,-4}})));
        BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
                 {{10,70},{50,110}}), iconTransformation(extent={{30,90},{50,110}})));
        Fluid.Sensors.Temperature senTem(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{-68,-60},{-48,-40}})));
        Fluid.Sensors.Temperature senTem1(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
        Fluid.Sensors.Temperature senTem2(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{6,48},{26,68}})));
        Fluid.Sensors.Temperature senTem3(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{30,-18},{50,2}})));
        Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{-88,50},{-68,70}})));
        Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{84,-70},{64,-50}})));
        Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium =
              Medium_Water,
          y_start=1,
          redeclare Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
            per)
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=0,
              origin={70,60})));
      equation
        connect(heatPumpDetailed_1.port_evaOut, heatPumpDetailed_2.port_evaIn)
          annotation (Line(points={{-12,21},{-12,-21}}, color={0,127,255}));
        connect(heatPumpDetailed_2.port_evaOut, Fluid_out_cold) annotation (Line(
              points={{-12,-35},{-12,-60},{-100,-60}}, color={0,127,255}));
        connect(heatPumpDetailed_2.port_conOut, heatPumpDetailed_1.port_conIn)
          annotation (Line(points={{14,-21},{14,21}}, color={0,127,255}));
        connect(heatPumpDetailed_1.port_conOut, fan4.port_a) annotation (Line(points={
                {14,35},{30,35},{30,36},{30,36},{30,60},{34,60}}, color={0,127,255}));
        connect(realExpression.y, heatPumpDetailed_2.T_amb)
          annotation (Line(points={{-55,-14},{6,-14},{6,-19}}, color={0,0,127}));
        connect(heatPumpDetailed_1.T_amb, heatPumpDetailed_2.T_amb) annotation (Line(
              points={{6,37},{6,50},{-40,50},{-40,-14},{6,-14},{6,-19}}, color={0,0,127}));
        connect(senTem2.port, fan4.port_a) annotation (Line(points={{16,48},{16,44},{
                30,44},{30,60},{34,60}}, color={0,127,255}));
        connect(Fluid_in_cold, senMasFlo.port_a)
          annotation (Line(points={{-100,60},{-88,60}}, color={0,127,255}));
        connect(senMasFlo.port_b, senTem1.port)
          annotation (Line(points={{-68,60},{-60,60}}, color={0,127,255}));
        connect(senTem1.port, heatPumpDetailed_1.port_evaIn) annotation (Line(points={
                {-60,60},{-60,40},{-12,40},{-12,35}}, color={0,127,255}));
        connect(senMasFlo1.port_a, Fluid_in_warm)
          annotation (Line(points={{84,-60},{100,-60}}, color={0,127,255}));
        connect(senMasFlo.m_flow, measureBus.heatpump_cold_massflow) annotation (Line(
              points={{-78,71},{-78,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
        connect(senMasFlo1.m_flow, measureBus.heatpump_warm_massflow) annotation (
            Line(points={{74,-49},{74,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
        connect(senTem.port, Fluid_out_cold)
          annotation (Line(points={{-58,-60},{-100,-60}}, color={0,127,255}));
        connect(heatPumpDetailed_2.port_evaOut, senTem.port) annotation (Line(points={
                {-12,-35},{-12,-60},{-58,-60}}, color={0,127,255}));
        connect(senMasFlo1.port_b, heatPumpDetailed_2.port_conIn) annotation (Line(
              points={{64,-60},{50,-60},{50,-35},{14,-35}}, color={0,127,255}));
        connect(senTem3.port, heatPumpDetailed_2.port_conIn)
          annotation (Line(points={{40,-18},{40,-35},{14,-35}}, color={0,127,255}));
        connect(bou1.ports[1], heatPumpDetailed_2.port_conIn)
          annotation (Line(points={{50,-26},{50,-35},{14,-35}}, color={0,127,255}));
        connect(heatPumpDetailed_1.onOff_in, controlBus.OnOff_heatpump_1) annotation (
           Line(points={{-4,37},{-4,50},{-39.9,50},{-39.9,100.1}}, color={255,0,255}));
        connect(heatPumpDetailed_2.onOff_in, controlBus.OnOff_heatpump_2) annotation (
           Line(points={{-4,-19},{-4,-14},{-39.9,-14},{-39.9,100.1}}, color={255,0,255}));
        connect(senTem1.T, measureBus.Heatpump_cold_in) annotation (Line(points={{-53,
                70},{-40,70},{-40,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
        connect(senTem.T, measureBus.Heatpump_cold_out) annotation (Line(points={{-51,
                -50},{-40,-50},{-40,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
        connect(senTem2.T, measureBus.Heatpump_warm_out)
          annotation (Line(points={{23,58},{30.1,58},{30.1,90.1}}, color={0,0,127}));
        connect(senTem3.T, measureBus.Heatpump_warm_in) annotation (Line(points={{47,-8},
                {56,-8},{56,-8},{56,-8},{56,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
        connect(heatPumpDetailed_1.CoP_out, measureBus.Heatpump_1_COP) annotation (
            Line(points={{0,19},{0,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
        connect(heatPumpDetailed_1.P_eleOut, measureBus.Heatpump_1_power) annotation (
           Line(points={{-4,19},{-4,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
        connect(heatPumpDetailed_2.CoP_out, measureBus.Heatpump_2_COP) annotation (
            Line(points={{0,-37},{0,-42},{30.1,-42},{30.1,90.1}}, color={0,0,127}));
        connect(heatPumpDetailed_2.P_eleOut, measureBus.Heatpump_2_power) annotation (
           Line(points={{-4,-37},{-4,-42},{30.1,-42},{30.1,90.1}}, color={0,0,127}));
        connect(fan4.port_b, fan1.port_a)
          annotation (Line(points={{50,60},{62,60}}, color={0,127,255}));
        connect(fan1.port_b, Fluid_out_warm)
          annotation (Line(points={{78,60},{100,60}}, color={0,127,255}));
        connect(fan4.y, controlBus.Pump_Warmwater_heatpump_1_y) annotation (Line(
              points={{42,69.6},{42,80},{-39.9,80},{-39.9,100.1}}, color={0,0,127}));
        connect(fan1.y, controlBus.Pump_Warmwater_heatpump_2_y) annotation (Line(
              points={{70,69.6},{70,80},{-39.9,80},{-39.9,100.1}}, color={0,0,127}));
        connect(fan4.P, measureBus.Pump_Warmwater_heatpump_1_power) annotation (Line(
              points={{50.8,67.2},{56,67.2},{56,80},{30.1,80},{30.1,90.1}}, color={0,
                0,127}));
        connect(fan1.P, measureBus.Pump_Warmwater_heatpump_2_power) annotation (Line(
              points={{78.8,67.2},{78.8,68},{82,68},{82,80},{30.1,80},{30.1,90.1}},
              color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Generation_heatPump;

      model Generation_geothermalProbe
        replaceable package Medium_Water =
        AixLib.Media.Water "Medium in the component";

        Modelica.Fluid.Interfaces.FluidPort_b Fulid_out_Geothermal(redeclare
            package Medium =
                     Medium_Water)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,50},{110,70}})));
        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_Geothermal(redeclare
            package Medium =
                     Medium_Water)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
              Earthtemperature_start)                                                       annotation(Placement(transformation(extent={{-82,6},
                  {-74,14}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=
              Earthtemperature_start + Probe_depth/120)                                     annotation(Placement(transformation(extent={{-82,26},
                  {-74,34}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T=
              Earthtemperature_start + (Probe_depth/120)*2)                                 annotation(Placement(transformation(extent={{-82,44},
                  {-74,52}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature3(T=
              Earthtemperature_start + (Probe_depth/120)*3)                                 annotation(Placement(transformation(extent={{-82,62},
                  {-74,70}})));
        Modelica.Fluid.Pipes.DynamicPipe pipe2(
          allowFlowReversal=true,
          roughness=2.5e-5,
          height_ab=0,
          redeclare model FlowModel =
              Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
          energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
          massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
          use_T_start=true,
          h_start=100,
          momentumDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
          m_flow_start=0,
          nNodes=8,
          use_HeatTransfer=true,
          useLumpedPressure=false,
          useInnerPortProperties=false,
          modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
          C_start=fill(0, 0),
          X_start={0},
          redeclare package Medium = Medium_Water,
          nParallel=n_probes,
          length=Probe_depth*2,
          diameter=0.032,
          redeclare model HeatTransfer =
              Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
              (alpha0=0.4/0.0029),
          isCircular=false,
          crossArea=0.0008042477,
          perimeter=0.032,
          p_a_start=100000,
          p_b_start=100000,
          T_start=283.15)
          annotation (Placement(transformation(extent={{-30,-26},{6,10}})));

          parameter Modelica.SIunits.Length Probe_depth = 0 annotation(Dialog(tab = "General"));
          parameter Real n_probes = 1 "Number of Probes" annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.Temp_K Earthtemperature_start = 283.15 annotation(Dialog(tab = "General"));

        BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
                 {{-28,72},{12,112}}), iconTransformation(extent={{-12,88},{12,112}})));
        Fluid.Sensors.Temperature senTem2(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{36,60},{56,80}})));
        Fluid.Sensors.Temperature senTem1(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{38,-60},{58,-40}})));
      equation
        connect(pipe2.port_b, Fulid_out_Geothermal) annotation (Line(points={{6,-8},{
                46,-8},{46,60},{100,60}}, color={0,127,255}));
        connect(pipe2.port_a, Fluid_in_Geothermal) annotation (Line(points={{-30,-8},
                {-62,-8},{-62,-60},{100,-60}}, color={0,127,255}));
        connect(fixedTemperature.port, pipe2.heatPorts[1]) annotation (Line(points={{
                -74,10},{-16.7025,10},{-16.7025,-0.08}}, color={191,0,0}));
        connect(fixedTemperature.port, pipe2.heatPorts[8]) annotation (Line(points={{
                -74,10},{-6.9375,10},{-6.9375,-0.08}}, color={191,0,0}));
        connect(fixedTemperature1.port, pipe2.heatPorts[2]) annotation (Line(points={
                {-74,30},{-15.3075,30},{-15.3075,-0.08}}, color={191,0,0}));
        connect(fixedTemperature1.port, pipe2.heatPorts[7]) annotation (Line(points={
                {-74,30},{-8.3325,30},{-8.3325,-0.08}}, color={191,0,0}));
        connect(fixedTemperature2.port, pipe2.heatPorts[3]) annotation (Line(points={
                {-74,48},{-44,48},{-44,48},{-13.9125,48},{-13.9125,-0.08}}, color={
                191,0,0}));
        connect(fixedTemperature2.port, pipe2.heatPorts[6]) annotation (Line(points={
                {-74,48},{-9.7275,48},{-9.7275,-0.08}}, color={191,0,0}));
        connect(fixedTemperature3.port, pipe2.heatPorts[4]) annotation (Line(points={
                {-74,66},{-12.5175,66},{-12.5175,-0.08}}, color={191,0,0}));
        connect(fixedTemperature3.port, pipe2.heatPorts[5]) annotation (Line(points={
                {-74,66},{-11.1225,66},{-11.1225,-0.08}}, color={191,0,0}));
        connect(pipe2.port_b, senTem2.port)
          annotation (Line(points={{6,-8},{46,-8},{46,60}}, color={0,127,255}));
        connect(pipe2.port_a, senTem1.port) annotation (Line(points={{-30,-8},{-62,-8},
                {-62,-60},{48,-60}}, color={0,127,255}));
        connect(senTem2.T, measureBus.GeothermalProbe_out) annotation (Line(points={{
                53,70},{60,70},{60,60},{-7.9,60},{-7.9,92.1}}, color={0,0,127}));
        connect(senTem1.T, measureBus.GeothermalProbe_in) annotation (Line(points={{
                55,-50},{60,-50},{60,60},{-7.9,60},{-7.9,92.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Generation_geothermalProbe;

      model Boiler_Benchmark "Boiler with internal and external control"
        extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(pressureDrop(
              a=paramBoiler.pressureDrop), vol(V=paramBoiler.volume));

        parameter AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
          paramBoiler
          "Parameters for Boiler"
          annotation (Dialog(tab = "General", group = "Boiler type"),
          choicesAllMatching = true);
        parameter Real KR=1
          "Gain of Boiler heater"
          annotation (Dialog(tab = "General", group = "Boiler type"));
        parameter Modelica.SIunits.Time TN=0.1
          "Time Constant of boiler heater (T>0 required)"
          annotation (Dialog(tab = "General", group = "Boiler type"));
        parameter Modelica.SIunits.Time riseTime=30
          "Rise/Fall time for step input(T>0 required)"
          annotation (Dialog(tab = "General", group = "Boiler type"));
        parameter Real eta=0.93
          "Efficiency"
          annotation (Dialog(tab = "General", group = "Boiler type"));
        parameter Real declination=1.1
          "Declination";
        Modelica.Blocks.Interfaces.BooleanInput isOn
          "Switches Controler on and off"
          annotation (Placement(transformation(extent={{-20,-20},{20,20}},
              rotation=-90,
              origin={30,100}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,-90})));
        Modelica.Blocks.Interfaces.RealInput TSet(
          final quantity="ThermodynamicTemperature",
          final unit="K",
          displayUnit="degC") "Ambient air temperature" annotation (Placement(
              transformation(extent={{-100,40},{-60,80}}), iconTransformation(extent={
                  {-80,60},{-60,80}})));

        Fluid.BoilerCHP.BaseClasses.Controllers.InternalControl internalControl(
          final paramBoiler=paramBoiler,
          final KR=KR,
          final TN=TN,
          final riseTime=riseTime) "Internal control"
          annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));

        Modelica.Blocks.Logical.Hysteresis hysteresis(
          pre_y_start=true,
          uHigh=273.15 + 99,
          uLow=273.15 + 90)
          annotation (Placement(transformation(extent={{36,12},{16,32}})));
        Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
          annotation (Placement(transformation(extent={{-8,12},{-28,32}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
          annotation (Placement(transformation(extent={{24,54},{4,74}})));
        Modelica.Blocks.Interfaces.RealOutput Fuel_Input
          annotation (Placement(transformation(extent={{90,70},{110,90}})));
        Modelica.Blocks.Math.Gain gain(k=eta/1000)
          annotation (Placement(transformation(extent={{4,-2},{16,10}})));
      equation
        connect(senTCold.T, internalControl.TFlowCold) annotation (Line(points={{-70,
                -69},{-70,-69},{-70,-20},{-80,-20},{-80,-1.625},{-70.075,-1.625}},
              color={0,0,127}));
        connect(senTHot.T, internalControl.TFlowHot) annotation (Line(points={{40,-69},
                {40,-18},{-82,-18},{-82,1.6},{-70,1.6}}, color={0,0,127}));
        connect(senMasFlo.m_flow, internalControl.mFlow) annotation (Line(points={{70,-69},
                {70,-69},{70,-22},{-78,-22},{-78,-4.925},{-70.075,-4.925}},
              color={0,0,127}));
        connect(TSet, internalControl.Tflow_set) annotation (Line(points={{-80,60},{-54,
                60},{-54,24},{-62.0375,24},{-62.0375,10.1125}}, color={0,0,127}));
        connect(internalControl.QflowHeater, heater.Q_flow) annotation (Line(points={
                {-49.95,3.9},{-36,3.9},{-36,-32},{-60,-32},{-60,-40}}, color={0,0,127}));
        connect(hysteresis.y, logicalSwitch.u2)
          annotation (Line(points={{15,22},{-6,22}}, color={255,0,255}));
        connect(hysteresis.u, internalControl.TFlowHot) annotation (Line(points={{38,
                22},{48,22},{48,-18},{-82,-18},{-82,1.6},{-70,1.6}}, color={0,0,127}));
        connect(logicalSwitch.y, internalControl.isOn) annotation (Line(points={{-29,
                22},{-57.525,22},{-57.525,10.275}}, color={255,0,255}));
        connect(isOn, logicalSwitch.u3) annotation (Line(points={{30,100},{30,46},{6,
                46},{6,14},{-6,14}}, color={255,0,255}));
        connect(booleanExpression.y, logicalSwitch.u1) annotation (Line(points={{3,64},
                {-2,64},{-2,30},{-6,30}}, color={255,0,255}));
        connect(Fuel_Input, gain.y) annotation (Line(points={{100,80},{60,80},{60,4},
                {16.6,4}}, color={0,0,127}));
        connect(gain.u, heater.Q_flow) annotation (Line(points={{2.8,4},{-36,4},{-36,-32},
                {-60,-32},{-60,-40}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Polygon(
                points={{-18.5,-23.5},{-26.5,-7.5},{-4.5,36.5},{3.5,10.5},{25.5,14.5},
                    {15.5,-27.5},{-2.5,-23.5},{-8.5,-23.5},{-18.5,-23.5}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={255,127,0}),
              Polygon(
                points={{-16.5,-21.5},{-6.5,-1.5},{19.5,-21.5},{-6.5,-21.5},{-16.5,-21.5}},
                lineColor={255,255,170},
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-26.5,-21.5},{27.5,-29.5}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192})}),                            Diagram(
              coordinateSystem(preserveAspectRatio=false)),
              Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A boiler model consisting of the internal boiler controler and a replaceable
outer controler.
This controler can be chosen to provide the boiler temperature setpoint based on
the chosen conditions
such as ambient air temperature, etc.
</p>
</html>",     revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with
AixLib</li>
<li><i>January 09, 2006&nbsp;</i> by Peter Matthes:<br/>V0.1: Initial
configuration.</li>
<li><i>December 4, 2014&nbsp;</i> by Ana Constantin:<br/>Removed cardinality
equations for boolean inputs</li>
<li><i>November 28, 2014&nbsp;</i> by Roozbeh Sangi:<br/>Output for heat flow
added.</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation
appropriately</li>
<li><i>April 20, 2012&nbsp;</i> by Ana Constanting:<br/>Implemented</li>
</ul>
</html>"));
      end Boiler_Benchmark;

      model Generation_v2
        replaceable package Medium_Water =
          AixLib.Media.Water "Medium in the component";

          parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 0 annotation(Dialog(tab = "General"));
          parameter Integer pipe_nodes= 2 annotation(Dialog(tab = "General"));

          // Hotwater
          parameter Real m_flow_nominal_hotwater = 0 annotation(Dialog(tab = "hotwater"));
          parameter Modelica.SIunits.Length pipe_length_hotwater = 0 annotation(Dialog(tab = "hotwater"));
          parameter Modelica.SIunits.Length pipe_diameter_hotwater = 0 annotation(Dialog(tab = "hotwater"));

          //Warmwater
          parameter Real m_flow_nominal_warmwater = 0 annotation(Dialog(tab = "warmwater"));
          parameter Modelica.SIunits.Length pipe_length_warmwater = 0 annotation(Dialog(tab = "warmwater"));
          parameter Modelica.SIunits.Length pipe_diameter_warmwater = 0 annotation(Dialog(tab = "warmwater"));

          //ColdWater
          parameter Real m_flow_nominal_coldwater = 0 annotation(Dialog(tab = "coldwater"));
          parameter Modelica.SIunits.Length pipe_length_coldwater = 0 annotation(Dialog(tab = "coldwater"));
          parameter Modelica.SIunits.Length pipe_diameter_coldwater = 0 annotation(Dialog(tab = "coldwater"));

          //Generation Hot
          parameter Real m_flow_nominal_generation_hot = 0 annotation(Dialog(tab = "generation_hot"));
          parameter Modelica.SIunits.Pressure dpValve_nominal_generation_hot = 0 annotation(Dialog(tab = "generation_hot"));

          //Heatpump
          parameter Modelica.SIunits.Temp_K T_conMax_1 = 328.15 annotation(Dialog(tab = "Heatpump"));
          parameter Modelica.SIunits.Temp_K T_conMax_2 = 328.15 annotation(Dialog(tab = "Heatpump"));
          parameter Modelica.SIunits.Volume vol_1 = 0.012 annotation(Dialog(tab = "Heatpump"));
          parameter Modelica.SIunits.Volume vol_2 = 0.024 annotation(Dialog(tab = "Heatpump"));
          parameter Modelica.SIunits.ThermalConductance R_loss_1 = 0 annotation(Dialog(tab = "Heatpump"));
          parameter Modelica.SIunits.ThermalConductance R_loss_2 = 0 annotation(Dialog(tab = "Heatpump"));

          //Generation Warm
          parameter Real m_flow_nominal_generation_warmwater = 0 annotation(Dialog(tab = "generation_warmwater"));
          parameter Modelica.SIunits.Pressure dpValve_nominal_warmwater = 0 annotation(Dialog(tab = "generation_warmwater"));

          //Generation Cold
          parameter Real m_flow_nominal_generation_coldwater = 0 annotation(Dialog(tab = "generation_coldwater"));
          parameter Modelica.SIunits.Pressure dpValve_nominal_coldwater = 0 annotation(Dialog(tab = "generation_coldwater"));

          //Generation Aircooler
          parameter Real m_flow_nominal_generation_aircooler = 0 annotation(Dialog(tab = "generation_aircooler"));
          parameter Modelica.SIunits.Pressure dpValve_nominal_generation_aircooler = 0 annotation(Dialog(tab = "generation_aircooler"));
          parameter Real m_flow_nominal_generation_air_small_max annotation(Dialog(tab = "generation_aircooler"));
          parameter Real m_flow_nominal_generation_air_small_min annotation(Dialog(tab = "generation_aircooler"));
          parameter Real m_flow_nominal_generation_air_big_max annotation(Dialog(tab = "generation_aircooler"));
          parameter Real m_flow_nominal_generation_air_big_min annotation(Dialog(tab = "generation_aircooler"));
          parameter Modelica.SIunits.Area Area_Heatexchanger_Air = 0 annotation(Dialog(tab = "generation_aircooler"));
          parameter Modelica.SIunits.ThermalConductance Thermal_Conductance_Cold = 0 annotation(Dialog(tab = "generation_aircooler"));
          parameter Modelica.SIunits.ThermalConductance Thermal_Conductance_Warm = 0 annotation(Dialog(tab = "generation_aircooler"));

          //Geothermal Probe
          parameter Modelica.SIunits.Length Probe_depth = 0 annotation(Dialog(tab = "Geothermal Probe"));
          parameter Real n_probes = 1 "Number of Probes" annotation(Dialog(tab = "Geothermal Probe"));
          parameter Modelica.SIunits.Temp_K Earthtemperature_start = 283.15 annotation(Dialog(tab = "Geothermal Probe"));

          //Storage
          parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC1_warm = 0 annotation(Dialog(tab = "Storage"));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC2_warm = 0 annotation(Dialog(tab = "Storage"));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC1_cold = 0 annotation(Dialog(tab = "Storage"));

        Generation_Hot generation_Hot(m_flow_nominal_generation_hot=
              m_flow_nominal_generation_hot,
          redeclare package Medium_Water = Medium_Water,
          dpValve_nominal_generation_hot=dpValve_nominal_generation_hot)
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
        Fluid.Storage.BufferStorage HotWater(
          useHeatingRod=false,
          n=5,
          useHeatingCoil2=true,
          redeclare model HeatTransfer =
              Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
          redeclare package Medium = Medium_Water,
          redeclare package MediumHC1 = Medium_Water,
          redeclare package MediumHC2 = Medium_Water,
          alphaHC1=alphaHC1_warm,
          alphaHC2=alphaHC2_warm,
          data=DataBase.Storage.Benchmark_22000l(),
          TStart=343.15)
          annotation (Placement(transformation(extent={{18,44},{48,82}})));
        Generation_heatPump generation_heatPump1(
          redeclare package Medium_Water = Medium_Water,
          dpHeatexchanger_nominal=dpHeatexchanger_nominal,
          T_conMax_1=T_conMax_1,
          T_conMax_2=T_conMax_2,
          vol_1=vol_1,
          vol_2=vol_2,
          R_loss_1=R_loss_1,
          R_loss_2=R_loss_2)
          annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        Fluid.Storage.BufferStorage ColdWater(
          useHeatingRod=false,
          n=5,
          upToDownHC1=false,
          useHeatingCoil1=true,
          redeclare model HeatTransfer =
              Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
          redeclare package Medium = Medium_Water,
          redeclare package MediumHC1 = Medium_Water,
          redeclare package MediumHC2 = Medium_Water,
          alphaHC1=alphaHC1_cold,
          useHeatingCoil2=true,
          alphaHC2=alphaHC1_cold,
          upToDownHC2=false,
          TStart=283.15,
          data=DataBase.Storage.Benchmark_46000l())
          annotation (Placement(transformation(extent={{18,-88},{48,-50}})));
        Fluid.Actuators.Valves.ThreeWayLinear Valve4(
          y_start=0,
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_warmwater,
          CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=dpValve_nominal_warmwater,
          use_inputFilter=false)
          annotation (Placement(transformation(extent={{-20,8},{-36,24}})));
        Generation_geothermalProbe generation_geothermalProbe(
          Probe_depth=Probe_depth,
          n_probes=n_probes,
          Earthtemperature_start=Earthtemperature_start,
          redeclare package Medium_Water = Medium_Water)      annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={-50,-90})));
        Fluid.Actuators.Valves.ThreeWayLinear Valve3(
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_coldwater,
          CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=dpValve_nominal_coldwater,
          use_inputFilter=false)                   annotation (Placement(
              transformation(
              extent={{7,-7},{-7,7}},
              rotation=90,
              origin={-85,-9})));
        Fluid.Actuators.Valves.ThreeWayLinear Valve1(
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_coldwater,
          CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=dpValve_nominal_coldwater,
          use_inputFilter=false)
                              annotation (Placement(transformation(
              extent={{-7,-7},{7,7}},
              rotation=90,
              origin={-85,-67})));
        Fluid.Actuators.Valves.ThreeWayLinear Valve2(
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_coldwater,
          CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=dpValve_nominal_coldwater,
          use_inputFilter=false)
                              annotation (Placement(transformation(
              extent={{-7,-7},{7,7}},
              rotation=90,
              origin={-85,-45})));
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Medium_Water,
          p=100000,
          nPorts=1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=-90,
              origin={-50,-56})));
        Fluid.Storage.BufferStorage WarmWater(
          useHeatingRod=false,
          n=5,
          useHeatingCoil2=true,
          redeclare model HeatTransfer =
              Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
          redeclare package Medium = Medium_Water,
          redeclare package MediumHC1 = Medium_Water,
          redeclare package MediumHC2 = Medium_Water,
          alphaHC1=alphaHC1_warm,
          alphaHC2=alphaHC2_warm,
          TStart=308.15,
          data=DataBase.Storage.Benchmark_22000l())
          annotation (Placement(transformation(extent={{16,-18},{46,20}})));
        Fluid.Sources.Boundary_pT bou4(
          redeclare package Medium = Medium_Water,
          p=100000,
          nPorts=1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=-90,
              origin={30,102})));
        Fluid.Actuators.Valves.ThreeWayLinear Valve7(
          y_start=0,
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_hot,
          CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=dpValve_nominal_generation_hot,
          use_inputFilter=false)
          annotation (Placement(transformation(extent={{-6,66},{-22,82}})));
        Fluid.Actuators.Valves.ThreeWayLinear Valve5(
          y_start=0,
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_warmwater,
          CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=dpValve_nominal_warmwater,
          use_inputFilter=false)
          annotation (Placement(transformation(extent={{2,8},{-14,24}})));
        Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
              Medium_Water,
            redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per,
          y_start=0)
          annotation (Placement(transformation(extent={{8,8},{-8,-8}},
              rotation=180,
              origin={60,94})));
        Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium =
              Medium_Water,
          y_start=0,
          redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
          annotation (Placement(transformation(extent={{8,8},{-8,-8}},
              rotation=180,
              origin={56,28})));
        Fluid.Movers.SpeedControlled_y fan3(redeclare package Medium =
              Medium_Water,
          y_start=0,
          redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per)
          annotation (Placement(transformation(extent={{8,-8},{-8,8}},
              rotation=180,
              origin={56,-96})));
        Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium =
              Medium_Water,
            redeclare Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per,
          y_start=1)
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=90,
              origin={-68,-60})));
        Modelica.Fluid.Pipes.DynamicPipe pipe(
          redeclare package Medium = Medium_Water,
          nNodes=pipe_nodes,
          length=pipe_length_hotwater,
          diameter=pipe_diameter_hotwater,
          height_ab=0)       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={84,94})));
        Modelica.Fluid.Pipes.DynamicPipe pipe1(
          redeclare package Medium = Medium_Water,
          nNodes=pipe_nodes,
          length=pipe_length_warmwater,
          diameter=pipe_diameter_warmwater,
          height_ab=0)       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={78,28})));
        Modelica.Fluid.Pipes.DynamicPipe pipe2(
          redeclare package Medium = Medium_Water,
          nNodes=pipe_nodes,
          length=pipe_length_coldwater,
          diameter=pipe_diameter_coldwater,
          height_ab=0)       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={80,-94})));
        Fluid.Sources.Boundary_pT bou2(
          redeclare package Medium = Medium_Water,
          p=100000,
          nPorts=1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=-90,
              origin={36,34})));
        Fluid.Sources.Boundary_pT bou3(
          redeclare package Medium = Medium_Water,
          p=100000,
          nPorts=1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=-90,
              origin={12,-92})));
        Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package
            Medium =
              Medium_Water)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,70},{110,90}})));
        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package
            Medium =
              Medium_Water)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,30},{110,50}})));
        Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package
            Medium =
              Medium_Water)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
            Medium =
              Medium_Water)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package
            Medium =
              Medium_Water)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,10},{110,30}})));
        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package
            Medium =
              Medium_Water)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
        BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
                 {{-16,80},{24,120}}), iconTransformation(extent={{30,90},{50,110}})));
        BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
                 {{-70,70},{-30,110}}), iconTransformation(extent={{-50,90},{-30,110}})));
        Generation_Aircooling_v2 generation_Aircooling_v2_1(
          m_flow_nominal_generation_warmwater=m_flow_nominal_generation_warmwater,
          m_flow_nominal_generation_coldwater=m_flow_nominal_generation_coldwater,
          m_flow_nominal_generation_aircooler=m_flow_nominal_generation_aircooler,
          redeclare package Medium_Water = Medium_Water,
          dpValve_nominal_generation_aircooler=dpValve_nominal_generation_aircooler,
          dpHeatexchanger_nominal=dpHeatexchanger_nominal,Area_Heatexchanger_Air=
              Area_Heatexchanger_Air,
          Thermal_Conductance_Cold=Thermal_Conductance_Cold,
          Thermal_Conductance_Warm=Thermal_Conductance_Warm,
          m_flow_nominal_generation_air_big_max=m_flow_nominal_generation_air_big_max,
          m_flow_nominal_generation_air_big_min=m_flow_nominal_generation_air_big_min,
          m_flow_nominal_generation_air_small_max=
              m_flow_nominal_generation_air_small_max,
          m_flow_nominal_generation_air_small_min=
              m_flow_nominal_generation_air_small_min)
          annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));

        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          prescribedTemperature
          annotation (Placement(transformation(extent={{72,58},{60,70}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          prescribedTemperature1
          annotation (Placement(transformation(extent={{72,-4},{60,8}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          prescribedTemperature2
          annotation (Placement(transformation(extent={{72,-74},{60,-62}})));
      equation
        connect(generation_Hot.Fluid_in_Hot,HotWater. portHC1Out) annotation (Line(
              points={{-60.4,66.2},{-32,66.2},{-32,67.94},{17.8125,67.94}},
                                                                     color={0,127,255}));
        connect(HotWater.fluidportBottom2,Fluid_in_hot)  annotation (Line(points={{37.3125,
                43.81},{37.3125,40},{100,40}},       color={0,127,255}));
        connect(HotWater.portHC2Out,generation_heatPump1. Fluid_in_warm) annotation (
            Line(points={{17.8125,52.17},{12,52.17},{12,4},{-40,4}},          color={
                0,127,255}));
        connect(generation_heatPump1.Fluid_out_warm,Valve4. port_2)
          annotation (Line(points={{-40,16},{-36,16}}, color={0,127,255}));
        connect(generation_heatPump1.Fluid_out_cold,Valve3. port_1)
          annotation (Line(points={{-60,4},{-85,4},{-85,-2}}, color={0,127,255}));
        connect(Valve3.port_2,Valve2. port_2) annotation (Line(points={{-85,-16},{-85,
                -16},{-85,-38}}, color={0,127,255}));
        connect(Valve2.port_1,Valve1. port_2) annotation (Line(points={{-85,-52},{-85,
                -52},{-85,-60}}, color={0,127,255}));
        connect(Valve2.port_3,ColdWater. portHC1In) annotation (Line(points={{-78,-45},
                {12,-45},{12,-46},{12,-46},{12,-58},{12,-58},{12,-58},{12,-58.17},{14,
                -58.17},{17.625,-58.17}},                                color={0,127,
                255}));
        connect(ColdWater.portHC1Out,Valve1. port_2) annotation (Line(points={{
                17.8125,-64.06},{-16,-64.06},{-16,-104},{-104,-104},{-104,-58},{-85,
                -58},{-85,-60}}, color={0,127,255}));
        connect(Fluid_in_cold,ColdWater. fluidportTop1) annotation (Line(points={{100,-40},
                {28,-40},{28,-46},{27.75,-46},{27.75,-49.81}},      color={0,127,255}));
        connect(WarmWater.fluidportBottom2,Fluid_in_warm)  annotation (Line(points={{
                35.3125,-18.19},{35.3125,-20},{100,-20}}, color={0,127,255}));
        connect(generation_Hot.Fluid_out_Hot,Valve7. port_2) annotation (Line(points=
                {{-60,73.8},{-42,73.8},{-42,74},{-22,74}}, color={0,127,255}));
        connect(Valve7.port_1,HotWater. portHC1In) annotation (Line(points={{-6,74},{
                6,74},{6,73.83},{17.625,73.83}}, color={0,127,255}));
        connect(Valve7.port_3,WarmWater. portHC1In) annotation (Line(points={{-14,66},
                {-14,30},{12,30},{12,11.83},{15.625,11.83}}, color={0,127,255}));
        connect(WarmWater.portHC1Out,HotWater. portHC1Out) annotation (Line(points={{15.8125,
                5.94},{12,5.94},{12,67.94},{17.8125,67.94}},      color={0,127,255}));
        connect(Valve4.port_1,Valve5. port_2)
          annotation (Line(points={{-20,16},{-14,16}}, color={0,127,255}));
        connect(Valve5.port_1,HotWater. portHC2In) annotation (Line(points={{2,16},{2,
                58.25},{17.8125,58.25}}, color={0,127,255}));
        connect(Valve5.port_3,WarmWater. portHC2In) annotation (Line(points={{-6,8},{
                -6,-3.75},{15.8125,-3.75}}, color={0,127,255}));
        connect(WarmWater.portHC2Out,generation_heatPump1. Fluid_in_warm) annotation (
           Line(points={{15.8125,-9.83},{-6,-9.83},{-6,4},{-40,4}}, color={0,127,255}));
        connect(Valve7.y,controlBus. Valve7) annotation (Line(points={{-14,83.6},{-14,
                88},{4.1,88},{4.1,100.1}}, color={0,0,127}));
        connect(Valve5.y,controlBus. Valve5) annotation (Line(points={{-6,25.6},{-6,
                34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
        connect(Valve4.y,controlBus. Valve4) annotation (Line(points={{-28,25.6},{-28,
                34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
        connect(Valve3.y,controlBus. Valve3) annotation (Line(points={{-93.4,-9},{-98,
                -9},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
        connect(Valve2.y,controlBus. Valve2) annotation (Line(points={{-93.4,-45},{
                -98,-45},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
        connect(Valve1.y,controlBus. Valve1) annotation (Line(points={{-93.4,-67},{
                -98,-67},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
        connect(generation_heatPump1.controlBus,controlBus)  annotation (Line(
            points={{-54,20},{-54,34},{4,34},{4,100}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_Hot.controlBus,controlBus)  annotation (Line(
            points={{-74,80},{-74,88},{4,88},{4,100}},
            color={255,204,51},
            thickness=0.5));
        connect(Valve1.port_3,generation_geothermalProbe. Fluid_in_Geothermal)
          annotation (Line(points={{-78,-67},{-74,-67},{-74,-80},{-56,-80}}, color={0,
                127,255}));
        connect(Fluid_out_hot,Fluid_out_hot)  annotation (Line(points={{100,80},{94,80},
                {94,80},{100,80}}, color={0,127,255}));
        connect(fan2.y,controlBus. Pump_Hotwater_y) annotation (Line(points={{60,103.6},
                {60,108},{20,108},{20,100},{12,100},{12,100.1},{4.1,100.1}}, color={0,
                0,127}));
        connect(fan3.port_a,ColdWater. fluidportBottom1) annotation (Line(points={{48,
                -96},{28,-96},{28,-94},{27.9375,-94},{27.9375,-88.38}}, color={0,127,255}));
        connect(WarmWater.fluidportTop2,fan1. port_a) annotation (Line(points={{35.6875,
                20.19},{35.6875,28},{48,28}}, color={0,127,255}));
        connect(fan3.y,controlBus. Pump_Coldwater_y) annotation (Line(points={{56,-105.6},
                {56,-110},{4.1,-110},{4.1,100.1}}, color={0,0,127}));
        connect(fan1.y,controlBus. Pump_Warmwater_y) annotation (Line(points={{56,37.6},
                {56,40},{4.1,40},{4.1,100.1}}, color={0,0,127}));
        connect(fan4.port_a,generation_geothermalProbe. Fulid_out_Geothermal)
          annotation (Line(points={{-68,-68},{-68,-70},{-44,-70},{-44,-80}}, color={0,
                127,255}));
        connect(Valve1.port_1,generation_geothermalProbe. Fulid_out_Geothermal)
          annotation (Line(points={{-85,-74},{-84,-74},{-84,-76},{-68,-76},{-68,-70},{
                -44,-70},{-44,-80}}, color={0,127,255}));
        connect(bou1.ports[1],generation_geothermalProbe. Fulid_out_Geothermal)
          annotation (Line(points={{-50,-60},{-50,-70},{-44,-70},{-44,-80}}, color={0,
                127,255}));
        connect(fan4.y,controlBus. Pump_Coldwater_heatpump_y) annotation (Line(points={{-77.6,
                -60},{-98,-60},{-98,88},{4.1,88},{4.1,100.1}},        color={0,0,127}));
        connect(ColdWater.TTop,measureBus. ColdWater_TTop) annotation (Line(points={{18,
                -52.28},{12,-52.28},{12,-52},{4,-52},{4,88},{-49.9,88},{-49.9,90.1}},
              color={0,0,127}));
        connect(WarmWater.TBottom,measureBus. WarmWater_TBottom) annotation (Line(
              points={{16,-14.2},{10,-14.2},{4,-14.2},{4,-14},{4,88},{-49.9,88},{-49.9,90.1}},
                         color={0,0,127}));
        connect(WarmWater.TTop,measureBus. WarmWater_TTop) annotation (Line(points={{16,
                17.72},{10,17.72},{10,18},{4,18},{4,88},{-49.9,88},{-49.9,90.1}},
              color={0,0,127}));
        connect(HotWater.TBottom,measureBus. HotWater_TBottom) annotation (Line(
              points={{18,47.8},{4,47.8},{4,88},{-49.9,88},{-49.9,90.1}},  color={0,0,
                127}));
        connect(HotWater.TTop,measureBus. HotWater_TTop) annotation (Line(points={{18,79.72},
                {12,79.72},{12,80},{4,80},{4,88},{-49.9,88},{-49.9,90.1}},
              color={0,0,127}));
        connect(fan2.P,measureBus. Pump_Hotwater_power) annotation (Line(points={{68.8,101.2},
                {70,101.2},{70,88},{-49.9,88},{-49.9,90.1}},         color={0,0,127}));
        connect(fan1.P,measureBus. Pump_Warmwater_power) annotation (Line(points={{64.8,
                35.2},{60,35.2},{60,40},{4,40},{4,90},{-49.9,90},{-49.9,90.1}},
              color={0,0,127}));
        connect(fan3.P,measureBus. Pump_Coldwater_power) annotation (Line(points={{64.8,
                -103.2},{70,-103.2},{70,-110},{4,-110},{4,90},{-49.9,90},{-49.9,90.1}},
              color={0,0,127}));
        connect(fan4.P,measureBus. Pump_Coldwater_heatpump_power) annotation (Line(
              points={{-75.2,-51.2},{-75.2,-30},{-98,-30},{-98,88},{-49.9,88},{-49.9,
                90.1}},
              color={0,0,127}));
        connect(generation_Hot.measureBus,measureBus)  annotation (Line(
            points={{-66,79.9},{-66,88},{-50,88},{-50,90}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_heatPump1.measureBus,measureBus)  annotation (Line(
            points={{-46,20},{-46,34},{-98,34},{-98,88},{-50,88},{-50,90}},
            color={255,204,51},
            thickness=0.5));
        connect(fan4.port_b,generation_heatPump1. Fluid_in_cold)
          annotation (Line(points={{-68,-52},{-68,16},{-60,16}}, color={0,127,255}));
        connect(fan2.port_b,pipe. port_a)
          annotation (Line(points={{68,94},{74,94}}, color={0,127,255}));
        connect(pipe.port_b,Fluid_out_hot)  annotation (Line(points={{94,94},{98,94},{
                98,80},{100,80}}, color={0,127,255}));
        connect(fan1.port_b,pipe1. port_a) annotation (Line(points={{64,28},{68,28}},
                              color={0,127,255}));
        connect(pipe1.port_b,Fluid_out_warm)  annotation (Line(points={{88,28},{90,28},
                {90,20},{100,20}}, color={0,127,255}));
        connect(fan3.port_b,pipe2. port_a) annotation (Line(points={{64,-96},{68,-96},
                {68,-94},{70,-94}}, color={0,127,255}));
        connect(pipe2.port_b,Fluid_out_cold)  annotation (Line(points={{90,-94},{96,-94},
                {96,-80},{100,-80}}, color={0,127,255}));
        connect(ColdWater.TBottom,measureBus. ColdWater_TBottom) annotation (Line(
              points={{18,-84.2},{12,-84.2},{12,-84},{4,-84},{4,90.1},{-49.9,90.1}},
              color={0,0,127}));
        connect(WarmWater.fluidportTop2,bou2. ports[1]) annotation (Line(points={{
                35.6875,20.19},{35.6875,30},{36,30}}, color={0,127,255}));
        connect(fan3.port_a,bou3. ports[1])
          annotation (Line(points={{48,-96},{12,-96}}, color={0,127,255}));
        connect(fan2.port_a,HotWater. fluidportTop2) annotation (Line(points={{52,94},
                {37.6875,94},{37.6875,82.19}}, color={0,127,255}));
        connect(bou4.ports[1],HotWater. fluidportTop2) annotation (Line(points={{30,
                98},{30,94},{37.6875,94},{37.6875,82.19}}, color={0,127,255}));
        connect(generation_Aircooling_v2_1.Fluid_in_cool_airCooler, Valve3.port_3)
          annotation (Line(points={{-56,-20},{-56,-9},{-78,-9}}, color={0,127,255}));
        connect(generation_Aircooling_v2_1.Fluid_out_cool_airCooler,
          generation_heatPump1.Fluid_in_cold) annotation (Line(points={{-44,-20},{-44,
                -4},{-68,-4},{-68,16},{-60,16}}, color={0,127,255}));
        connect(generation_Aircooling_v2_1.Fluid_in_warm_airCooler, Valve4.port_3)
          annotation (Line(points={{-40,-24},{-28,-24},{-28,8}}, color={0,127,255}));
        connect(generation_Aircooling_v2_1.Fluid_out_warm_airCooler,
          generation_heatPump1.Fluid_in_warm) annotation (Line(points={{-40,-36},{-20,
                -36},{-20,4},{-40,4}}, color={0,127,255}));
        connect(generation_Aircooling_v2_1.controlBus, controlBus) annotation (Line(
            points={{-60,-30},{-98,-30},{-98,88},{4,88},{4,100}},
            color={255,204,51},
            thickness=0.5));
        connect(generation_Aircooling_v2_1.measureBus, measureBus) annotation (Line(
            points={{-59.4,-36.8},{-66,-36.8},{-66,-30},{-98,-30},{-98,88},{-50,88},{-50,
                90},{-50,90}},
            color={255,204,51},
            thickness=0.5));
        connect(HotWater.heatportOutside, prescribedTemperature.port) annotation (
            Line(points={{47.625,64.14},{55.8125,64.14},{55.8125,64},{60,64}}, color=
                {191,0,0}));
        connect(WarmWater.heatportOutside, prescribedTemperature1.port) annotation (
            Line(points={{45.625,2.14},{53.8125,2.14},{53.8125,2},{60,2}}, color={191,
                0,0}));
        connect(ColdWater.heatportOutside, prescribedTemperature2.port) annotation (
            Line(points={{47.625,-67.86},{53.8125,-67.86},{53.8125,-68},{60,-68}},
              color={191,0,0}));
        connect(prescribedTemperature2.T, measureBus.RoomTemp_Workshop) annotation (
            Line(points={{73.2,-68},{78,-68},{78,-34},{4,-34},{4,90.1},{-49.9,90.1}},
              color={0,0,127}));
        connect(prescribedTemperature1.T, measureBus.RoomTemp_Canteen) annotation (
            Line(points={{73.2,2},{78,2},{78,-34},{4,-34},{4,90.1},{-49.9,90.1}},
              color={0,0,127}));
        connect(prescribedTemperature.T, measureBus.RoomTemp_Canteen) annotation (
            Line(points={{73.2,64},{76,64},{76,80},{76,80},{76,88},{4,88},{4,90.1},{
                -49.9,90.1}}, color={0,0,127}));
        connect(generation_geothermalProbe.measureBus, measureBus) annotation (Line(
            points={{-40,-90},{-34,-90},{-34,-104},{-98,-104},{-98,88},{-50,88},{-50,
                90},{-50,90}},
            color={255,204,51},
            thickness=0.5));
        connect(ColdWater.portHC2In, Valve2.port_3) annotation (Line(points={{17.8125,
                -73.75},{14,-73.75},{12,-73.75},{12,-74},{12,-45},{-78,-45}}, color={
                0,127,255}));
        connect(ColdWater.portHC2Out, Valve1.port_2) annotation (Line(points={{
                17.8125,-79.83},{-16,-79.83},{-16,-104},{-104,-104},{-104,-58},{-85,
                -58},{-85,-60}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Generation_v2;

      model Generation_Aircooling_v2
          replaceable package Medium_Water =
          AixLib.Media.Water "Medium in the component";
        replaceable package Medium_Air =
          AixLib.Media.Air "Medium in the component";

          parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_warmwater = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_coldwater = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_big_max = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_big_min = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_small_max = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_small_min = 0 annotation(Dialog(tab = "General"));

          parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_aircooler annotation(Dialog(tab = "General"), choicesAllMatching = true);
          parameter Modelica.SIunits.Pressure dpValve_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.Area Area_Heatexchanger_Air = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.ThermalConductance Thermal_Conductance_Cold = 0 annotation(Dialog(tab = "General"));
          parameter Modelica.SIunits.ThermalConductance Thermal_Conductance_Warm = 0 annotation(Dialog(tab = "General"));

        Fluid.Actuators.Valves.ThreeWayLinear Valve8(
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_aircooler,
          CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
          dpValve_nominal=dpValve_nominal_generation_aircooler,
          use_inputFilter=false)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-16,44})));
        Fluid.Sources.Boundary_pT bou1(
          redeclare package Medium = Medium_Water,
          p=100000,
          nPorts=1) annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=-90,
              origin={36,-10})));
        Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium =
              Medium_Water,
            redeclare
            Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per)
          annotation (Placement(transformation(extent={{8,8},{-8,-8}},
              rotation=90,
              origin={18,10})));
        Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, table=[-1,
              m_flow_nominal_generation_air_big_min,7800; 0.0,
              m_flow_nominal_generation_air_big_min,7800; 1,
              m_flow_nominal_generation_air_big_max,12000; 1.1,
              m_flow_nominal_generation_air_big_max,12000])
          annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
        Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-16,18})));
        Fluid.Sensors.Temperature senTem2(redeclare package Medium =
              Medium_Water)
          annotation (Placement(transformation(extent={{-2,-18},{18,2}})));
        Fluid.MixingVolumes.MixingVolume vol1(
          redeclare package Medium = Medium_Water,
          nPorts=2,
          m_flow_nominal=m_flow_nominal_generation_aircooler,
          V=0.2) annotation (Placement(transformation(extent={{-2,-26},{8,-16}})));
        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm_airCooler(redeclare
            package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,50},{110,70}})));
        Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm_airCooler(redeclare
            package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
        Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cool_airCooler(redeclare
            package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
        Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cool_airCooler(redeclare
            package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{50,90},{70,110}})));
        BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
                 {{-120,-20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,
                  10}})));
        BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
                 {{-124,-98},{-84,-58}}), iconTransformation(extent={{-104,-78},{-84,
                  -58}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          prescribedTemperature
          annotation (Placement(transformation(extent={{-10,-64},{-2,-56}})));
        Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(
          surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
          Model=1,
          A=Area_Heatexchanger_Air)                                                                                                                                                               annotation(Placement(transformation(extent={{4,-40},
                  {15,-28}})));
        Modelica.Blocks.Math.Gain gain(k=1/(6.41801*1.2041))
          annotation (Placement(transformation(extent={{-16,-40},{-10,-34}})));
        Fluid.FixedResistances.PressureDrop res(
          m_flow_nominal=m_flow_nominal_generation_aircooler,
          redeclare package Medium = Medium_Water,
          dp_nominal=dpHeatexchanger_nominal)
          annotation (Placement(transformation(extent={{-4,-32},{-14,-22}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
          annotation (Placement(transformation(extent={{-16,-20},{-36,0}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder(T=30)
          annotation (Placement(transformation(extent={{-54,-38},{-42,-26}})));
        Fluid.FixedResistances.PressureDrop res1(
          redeclare package Medium = Medium_Water,
          dp_nominal=dpHeatexchanger_nominal,
          m_flow_nominal=m_flow_nominal_generation_coldwater)
          annotation (Placement(transformation(extent={{20,78},{32,90}})));
        Fluid.MixingVolumes.MixingVolume vol3(
          redeclare package Medium = Medium_Water,
          nPorts=2,
          m_flow_nominal=m_flow_nominal_generation_coldwater,
          V=0.01)
                 annotation (Placement(transformation(extent={{-6,84},{6,96}})));
        Fluid.MixingVolumes.MixingVolume vol4(
          redeclare package Medium = Medium_Water,
          nPorts=2,
          m_flow_nominal=m_flow_nominal_generation_aircooler,
          V=0.01)
                 annotation (Placement(transformation(extent={{-6,78},{6,66}})));
        Fluid.FixedResistances.PressureDrop res2(
          m_flow_nominal=m_flow_nominal_generation_aircooler,
          redeclare package Medium = Medium_Water,
          dp_nominal=dpHeatexchanger_nominal)
          annotation (Placement(transformation(extent={{20,72},{32,84}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
              Thermal_Conductance_Cold)
                                   annotation (Placement(transformation(
              extent={{-5,-5},{5,5}},
              rotation=90,
              origin={-29,81})));
        Fluid.MixingVolumes.MixingVolume vol5(
          redeclare package Medium = Medium_Water,
          nPorts=2,
          m_flow_nominal=m_flow_nominal_generation_aircooler,
          V=0.01)
                 annotation (Placement(transformation(extent={{-6,6},{6,-6}},
              rotation=-90,
              origin={66,20})));
        Fluid.MixingVolumes.MixingVolume vol6(
          redeclare package Medium = Medium_Water,
          nPorts=2,
          V=0.01,
          m_flow_nominal=m_flow_nominal_generation_warmwater)
                 annotation (Placement(transformation(extent={{6,6},{-6,-6}},
              rotation=90,
              origin={84,20})));
        Fluid.FixedResistances.PressureDrop res3(
          redeclare package Medium = Medium_Water,
          dp_nominal=dpHeatexchanger_nominal,
          m_flow_nominal=m_flow_nominal_generation_warmwater)
          annotation (Placement(transformation(extent={{-6,-6},{6,6}},
              rotation=-90,
              origin={78,0})));
        Fluid.FixedResistances.PressureDrop res4(
          redeclare package Medium = Medium_Water,
          m_flow_nominal=m_flow_nominal_generation_aircooler,
          dp_nominal=dpHeatexchanger_nominal)
          annotation (Placement(transformation(extent={{-6,-6},{6,6}},
              rotation=-90,
              origin={72,0})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=
              Thermal_Conductance_Warm)
                                   annotation (Placement(transformation(
              extent={{-5,-5},{5,5}},
              rotation=0,
              origin={75,37})));
        Modelica.Blocks.Sources.RealExpression realExpression1[2](y=0)
          annotation (Placement(transformation(extent={{-114,-40},{-102,-24}})));
        Modelica.Blocks.Logical.Switch switch1[2]
          annotation (Placement(transformation(extent={{-92,-30},{-80,-18}})));
        Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds1(
                                                           smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, table=[-1,
              m_flow_nominal_generation_air_small_min,1470; 0.0,
              m_flow_nominal_generation_air_small_min,1470; 1,
              m_flow_nominal_generation_air_small_max,2310; 1.1,
              m_flow_nominal_generation_air_small_max,2310])
          annotation (Placement(transformation(extent={{-140,-56},{-120,-36}})));
        Modelica.Blocks.Logical.Switch switch2[2]
          annotation (Placement(transformation(extent={{-92,-52},{-80,-40}})));
        Modelica.Blocks.Math.Add add[2]
          annotation (Placement(transformation(extent={{-76,-40},{-66,-30}})));
      equation
        connect(Valve8.y,controlBus. Valve8) annotation (Line(points={{-28,44},{-64,44},
                {-64,0.1},{-99.9,0.1}},     color={0,0,127}));
        connect(fan4.y,controlBus. Pump_Aircooler_y) annotation (Line(points={{27.6,
                10},{38,10},{38,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(senMasFlo.port_b,Valve8. port_2)
          annotation (Line(points={{-16,28},{-16,34}}, color={0,127,255}));
        connect(senMasFlo.m_flow,measureBus. Aircooler_massflow) annotation (Line(
              points={{-27,18},{-40,18},{-40,-77.9},{-103.9,-77.9}}, color={0,0,127}));
        connect(senTem2.T,measureBus. Aircooler_in) annotation (Line(points={{15,-8},{
                18,-8},{18,-22},{-40,-22},{-40,-77.9},{-103.9,-77.9}}, color={0,0,127}));
        connect(vol1.ports[1], fan4.port_b)
          annotation (Line(points={{2,-26},{18,-26},{18,2}},  color={0,127,255}));
        connect(bou1.ports[1], fan4.port_b) annotation (Line(points={{36,-14},{36,-18},
                {18,-18},{18,2}}, color={0,127,255}));
        connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{-10.8,
                -60},{-18,-60},{-18,-78},{-102,-78},{-102,-77.9},{-103.9,-77.9}},
                                                                              color={0,
                0,127}));
        connect(gain.y, heatTransfer_Outside.WindSpeedPort) annotation (Line(points={{
                -9.7,-37},{-2,-37},{-2,-38.32},{4.44,-38.32}}, color={0,0,127}));
        connect(res.port_b, senMasFlo.port_a)
          annotation (Line(points={{-14,-27},{-16,-27},{-16,8}}, color={0,127,255}));
        connect(res.port_a, vol1.ports[2]) annotation (Line(points={{-4,-27},{-2,-27},
                {-2,-26},{4,-26}}, color={0,127,255}));
        connect(heatTransfer_Outside.port_a, vol1.heatPort)
          annotation (Line(points={{4,-34},{-2,-34},{-2,-21}}, color={191,0,0}));
        connect(senTem2.port, fan4.port_b)
          annotation (Line(points={{8,-18},{18,-18},{18,2}}, color={0,127,255}));
        connect(temperatureSensor.port, vol1.heatPort) annotation (Line(points={{-16,
                -10},{-12,-10},{-12,-21},{-2,-21}}, color={191,0,0}));
        connect(vol4.ports[1], res2.port_a)
          annotation (Line(points={{-1.2,78},{20,78}}, color={0,127,255}));
        connect(Valve8.port_1, vol4.ports[2])
          annotation (Line(points={{-16,54},{-16,78},{1.2,78}}, color={0,127,255}));
        connect(Fluid_in_cool_airCooler, vol3.ports[1]) annotation (Line(points={{-60,
                100},{-60,84},{-1.2,84}}, color={0,127,255}));
        connect(vol3.ports[2], res1.port_a)
          annotation (Line(points={{1.2,84},{20,84}}, color={0,127,255}));
        connect(res1.port_b, Fluid_out_cool_airCooler)
          annotation (Line(points={{32,84},{60,84},{60,100}}, color={0,127,255}));
        connect(res2.port_b, fan4.port_a) annotation (Line(points={{32,78},{40,78},{40,
                60},{18,60},{18,18}}, color={0,127,255}));
        connect(thermalConductor.port_b, vol3.heatPort)
          annotation (Line(points={{-29,86},{-29,90},{-6,90}}, color={191,0,0}));
        connect(thermalConductor.port_a, vol4.heatPort)
          annotation (Line(points={{-29,76},{-29,72},{-6,72}}, color={191,0,0}));
        connect(res4.port_a, vol5.ports[1])
          annotation (Line(points={{72,6},{72,21.2}}, color={0,127,255}));
        connect(res3.port_a, vol6.ports[1])
          annotation (Line(points={{78,6},{78,21.2}}, color={0,127,255}));
        connect(res4.port_b, fan4.port_a) annotation (Line(points={{72,-6},{72,-12},{50,
                -12},{50,28},{18,28},{18,18}}, color={0,127,255}));
        connect(vol5.ports[2], Valve8.port_3) annotation (Line(points={{72,18.8},{72,44},
                {-6,44},{-6,44}}, color={0,127,255}));
        connect(vol6.ports[2], Fluid_in_warm_airCooler)
          annotation (Line(points={{78,18.8},{78,60},{100,60}}, color={0,127,255}));
        connect(res3.port_b, Fluid_out_warm_airCooler)
          annotation (Line(points={{78,-6},{78,-60},{100,-60}}, color={0,127,255}));
        connect(vol5.heatPort, thermalConductor1.port_a)
          annotation (Line(points={{66,26},{66,37},{70,37}}, color={191,0,0}));
        connect(thermalConductor1.port_b, vol6.heatPort) annotation (Line(points={{80,
                37},{84,37},{84,36},{84,36},{84,26}}, color={191,0,0}));
        connect(combiTable1Ds.y, switch1.u1) annotation (Line(points={{-119,-20},{-104,
                -20},{-104,-19.2},{-93.2,-19.2}},      color={0,0,127}));
        connect(realExpression1.y, switch1.u3) annotation (Line(points={{-101.4,-32},{
                -100,-32},{-100,-28.8},{-93.2,-28.8}},  color={0,0,127}));
        connect(temperatureSensor.T, measureBus.Aircooler) annotation (Line(points={{-36,-10},
                {-40,-10},{-40,-77.9},{-103.9,-77.9}},          color={0,0,127}));
        connect(combiTable1Ds.u, controlBus.Fan_Aircooler_big) annotation (Line(
              points={{-142,-20},{-160,-20},{-160,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(combiTable1Ds1.y[1], switch2[1].u1) annotation (Line(points={{-119,-46},
                {-104,-46},{-104,-41.2},{-93.2,-41.2}}, color={0,0,127}));
        connect(combiTable1Ds1.y[2], switch2[2].u1) annotation (Line(points={{-119,-46},
                {-104,-46},{-104,-41.2},{-93.2,-41.2}}, color={0,0,127}));
        connect(switch2[1].u3, realExpression1[1].y) annotation (Line(points={{-93.2,-50.8},
                {-96,-50.8},{-96,-32},{-101.4,-32}}, color={0,0,127}));
        connect(switch2[2].u3, realExpression1[2].y) annotation (Line(points={{-93.2,-50.8},
                {-96,-50.8},{-96,-32},{-101.4,-32}}, color={0,0,127}));
        connect(switch1[1].y, add[1].u1) annotation (Line(points={{-79.4,-24},{-78,-24},
                {-78,-32},{-77,-32}}, color={0,0,127}));
        connect(switch2[1].y, add[1].u2) annotation (Line(points={{-79.4,-46},{-78,-46},
                {-78,-38},{-77,-38}}, color={0,0,127}));
        connect(add[1].y, firstOrder.u) annotation (Line(points={{-65.5,-35},{-65.5,
                -31.5},{-55.2,-31.5},{-55.2,-32}},
                                            color={0,0,127}));
        connect(switch1[2].y, add[2].u1) annotation (Line(points={{-79.4,-24},{-78,-24},
                {-78,-32},{-77,-32}}, color={0,0,127}));
        connect(switch2[2].y, add[2].u2) annotation (Line(points={{-79.4,-46},{-77,-46},
                {-77,-38}}, color={0,0,127}));
        connect(add[2].y, measureBus.Fan_Aircooler) annotation (Line(points={{-65.5,-35},
                {-62,-35},{-62,-77.9},{-103.9,-77.9}}, color={0,0,127}));
        connect(combiTable1Ds1.u, controlBus.Fan_Aircooler_small) annotation (Line(
              points={{-142,-46},{-160,-46},{-160,0.1},{-99.9,0.1}}, color={0,0,127}));
        connect(switch1[1].u2, controlBus.OnOff_Aircooler_big) annotation (Line(
              points={{-93.2,-24},{-99.9,-24},{-99.9,0.1}}, color={255,0,255}));
        connect(switch1[2].u2, controlBus.OnOff_Aircooler_big) annotation (Line(
              points={{-93.2,-24},{-99.9,-24},{-99.9,0.1}}, color={255,0,255}));
        connect(switch2[1].u2, controlBus.OnOff_Aircooler_small) annotation (Line(
              points={{-93.2,-46},{-99.9,-46},{-99.9,0.1}}, color={255,0,255}));
        connect(switch2[2].u2, controlBus.OnOff_Aircooler_small) annotation (Line(
              points={{-93.2,-46},{-99.9,-46},{-99.9,0.1}}, color={255,0,255}));
        connect(prescribedTemperature.port, heatTransfer_Outside.port_b) annotation (
            Line(points={{-2,-60},{20,-60},{20,-34},{15,-34}}, color={191,0,0}));
        connect(firstOrder.y, gain.u) annotation (Line(points={{-41.4,-32},{-30,-32},
                {-30,-37},{-16.6,-37}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Generation_Aircooling_v2;
    end Generation;

    package Transfer
      package Transfer_TBA
        model TBA_Pipe_Openplanoffice_v2
          replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";
          import BaseLib = AixLib.Utilities;

            parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));

            parameter Modelica.SIunits.Pressure dp_Heatexchanger_nominal = 0 annotation(Dialog(tab = "General"));

            parameter Modelica.SIunits.Length TBA_pipe_diameter = 0.02 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length TBA_wall_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length TBA_wall_height = 0 annotation(Dialog(tab = "General"));

          Fluid.MixingVolumes.MixingVolume vol(
            m_flow_nominal=1,
            redeclare package Medium = Medium_Water,
            nPorts=2,
            V=TBA_wall_length*TBA_wall_height*5.8*3.14159*(TBA_pipe_diameter/2)^2)
            annotation (Placement(transformation(extent={{-8,46},{12,66}})));
          Fluid.Actuators.Valves.ThreeWayLinear val1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            dpValve_nominal=dp_Valve_nominal,
            use_inputFilter=false)
            annotation (Placement(transformation(extent={{6,6},{-6,-6}},
                rotation=-90,
                origin={-60,-40})));
          Fluid.MixingVolumes.MixingVolume vol1(
            redeclare package Medium = Medium_Water,
            nPorts=4,
            m_flow_nominal=m_flow_nominal,
            V=V_mixing)
                      annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=90,
                origin={66,-40})));
          Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
                Medium_Water,
              redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per,
            y_start=1)
            annotation (Placement(transformation(extent={{8,8},{-8,-8}},
                rotation=-90,
                origin={-60,28})));
          Fluid.Sensors.Temperature senTem2(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-42,-30},{-22,-10}})));
          Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=90,
                origin={60,26})));
          Fluid.Sensors.Temperature senTem1(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{22,-30},{42,-10}})));
          Modelica.Fluid.Pipes.DynamicPipe pipe(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            nNodes=pipe_nodes,
            diameter=pipe_diameter,
            length=pipe_length + 50)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={60,-8})));
          Modelica.Fluid.Pipes.DynamicPipe pipe1(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            nNodes=pipe_nodes,
            diameter=pipe_diameter,
            length=pipe_length + 50)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-60,-6})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
          Modelica.Blocks.Interfaces.RealInput valve_temp
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-112,-12},{-88,12}})));
          Modelica.Blocks.Interfaces.RealInput pump
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{-112,48},{-88,72}})));
          Modelica.Blocks.Interfaces.RealOutput m_flow
            "Mass flow rate from port_a to port_b"
            annotation (Placement(transformation(extent={{90,10},{110,30}})));
          Modelica.Blocks.Interfaces.RealOutput Power_pump "Electrical power consumed"
            annotation (Placement(transformation(extent={{90,50},{110,70}})));
          Modelica.Blocks.Interfaces.RealOutput Temp_out "Temperature in port medium"
            annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
          Modelica.Blocks.Interfaces.RealOutput Temp_in "Temperature in port medium"
            annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
          Fluid.HeatExchangers.ConstantEffectiveness Ext_Warm(
            redeclare package Medium1 = Medium_Water,
            redeclare package Medium2 = Medium_Water,
            dp1_nominal(displayUnit="bar") = dp_Heatexchanger_nominal,
            dp2_nominal=dp_Heatexchanger_nominal,
            m1_flow_nominal=m_flow_nominal,
            m2_flow_nominal=m_flow_nominal)
            annotation (Placement(transformation(extent={{5,-5},{-5,5}},
                rotation=0,
                origin={-5,-43})));
          Fluid.Actuators.Valves.TwoWayLinear val(
            use_inputFilter=false,
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            dpValve_nominal=dp_Valve_nominal)             annotation (Placement(
                transformation(
                extent={{6,6},{-6,-6}},
                rotation=-90,
                origin={-20,-70})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
          Modelica.Blocks.Interfaces.RealInput Valve_warm
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-112,-72},{-88,-48}})));
        equation
          connect(vol.heatPort,HeatPort_TBA)  annotation (Line(points={{-8,56},{-24,56},
                  {-24,56},{-40,56},{-40,100},{-40,100}},
                                            color={191,0,0}));
          connect(Fluid_in_cold, val1.port_1)
            annotation (Line(points={{-60,-100},{-60,-46}}, color={0,127,255}));
          connect(fan2.port_b,vol. ports[1])
            annotation (Line(points={{-60,36},{-60,46},{0,46}}, color={0,127,255}));
          connect(val1.y, valve_temp) annotation (Line(points={{-67.2,-40},{-80,-40},{-80,
                  0},{-100,0}}, color={0,0,127}));
          connect(fan2.y,pump)
            annotation (Line(points={{-69.6,28},{-80,28},{-80,60},{-100,60}},
                                                            color={0,0,127}));
          connect(senTem1.port,vol1. ports[1]) annotation (Line(points={{32,-30},{60,-30},
                  {60,-41.8}}, color={0,127,255}));
          connect(vol.ports[2],senMasFlo. port_b)
            annotation (Line(points={{4,46},{60,46},{60,36}}, color={0,127,255}));
          connect(senMasFlo.m_flow,m_flow)  annotation (Line(points={{71,26},{80,26},{80,
                  20},{100,20}}, color={0,0,127}));
          connect(fan2.P,Power_pump)  annotation (Line(points={{-67.2,36.8},{-67.2,80},{
                  80,80},{80,60},{100,60}}, color={0,0,127}));
          connect(senTem1.T,Temp_out)
            annotation (Line(points={{39,-20},{100,-20}}, color={0,0,127}));
          connect(senTem2.T,Temp_in)  annotation (Line(points={{-25,-20},{20,-20},{20,-60},
                  {100,-60}}, color={0,0,127}));
          connect(pipe1.port_a,val1. port_2)
            annotation (Line(points={{-60,-16},{-60,-34}}, color={0,127,255}));
          connect(pipe1.port_b,fan2. port_a)
            annotation (Line(points={{-60,4},{-60,20}}, color={0,127,255}));
          connect(pipe.port_a,senMasFlo. port_a)
            annotation (Line(points={{60,2},{60,16}}, color={0,127,255}));
          connect(senTem2.port,val1. port_2) annotation (Line(points={{-32,-30},{-60,-30},
                  {-60,-34}}, color={0,127,255}));
          connect(Ext_Warm.port_b1, val1.port_3)
            annotation (Line(points={{-10,-40},{-54,-40}}, color={0,127,255}));
          connect(pipe.port_b, vol1.ports[2])
            annotation (Line(points={{60,-18},{60,-40.6}}, color={0,127,255}));
          connect(Ext_Warm.port_a1, vol1.ports[3]) annotation (Line(points={{0,-40},{30,
                  -40},{30,-39.4},{60,-39.4}}, color={0,127,255}));
          connect(vol1.ports[4], Fluid_out_cold)
            annotation (Line(points={{60,-38.2},{60,-100}}, color={0,127,255}));
          connect(val.port_a, Fluid_in_warm)
            annotation (Line(points={{-20,-76},{-20,-100}}, color={0,127,255}));
          connect(val.port_b, Ext_Warm.port_a2) annotation (Line(points={{-20,-64},{-20,
                  -46},{-10,-46}}, color={0,127,255}));
          connect(Ext_Warm.port_b2, Fluid_out_warm)
            annotation (Line(points={{0,-46},{20,-46},{20,-100}}, color={0,127,255}));
          connect(val.y, Valve_warm) annotation (Line(points={{-27.2,-70},{-80,-70},{
                  -80,-60},{-100,-60}},
                                    color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end TBA_Pipe_Openplanoffice_v2;

        model TBA_Pipe_v2
          replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";
          import BaseLib = AixLib.Utilities;

            parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));

            parameter Modelica.SIunits.Pressure dp_Heatexchanger_nominal = 0 annotation(Dialog(tab = "General"));

            parameter Modelica.SIunits.Length TBA_pipe_diameter = 0.02 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length TBA_wall_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length TBA_wall_height = 0 annotation(Dialog(tab = "General"));

          Fluid.MixingVolumes.MixingVolume vol(
            m_flow_nominal=1,
            redeclare package Medium = Medium_Water,
            nPorts=2,
            V=TBA_wall_length*TBA_wall_height*5.8*3.14159*(TBA_pipe_diameter/2)^2)
            annotation (Placement(transformation(extent={{-8,46},{12,66}})));
          Fluid.Actuators.Valves.ThreeWayLinear val1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            dpValve_nominal=dp_Valve_nominal,
            use_inputFilter=false)
            annotation (Placement(transformation(extent={{6,6},{-6,-6}},
                rotation=-90,
                origin={-60,-40})));
          Fluid.MixingVolumes.MixingVolume vol1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            V=V_mixing,
            nPorts=4) annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=90,
                origin={66,-40})));
          Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
                Medium_Water,
              redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
            y_start=1)
            annotation (Placement(transformation(extent={{8,8},{-8,-8}},
                rotation=-90,
                origin={-60,28})));
          Fluid.Sensors.Temperature senTem2(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-42,-30},{-22,-10}})));
          Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{10,10},{-10,-10}},
                rotation=90,
                origin={60,26})));
          Fluid.Sensors.Temperature senTem1(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{22,-30},{42,-10}})));
          Modelica.Fluid.Pipes.DynamicPipe pipe1(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            nNodes=pipe_nodes,
            diameter=pipe_diameter,
            length=pipe_length + 50)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-60,-6})));
          Modelica.Fluid.Pipes.DynamicPipe pipe(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            nNodes=pipe_nodes,
            diameter=pipe_diameter,
            length=pipe_length + 50)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={60,-8})));
          Fluid.Actuators.Valves.TwoWayLinear val(
            use_inputFilter=false,
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            dpValve_nominal=dp_Valve_nominal)             annotation (Placement(
                transformation(
                extent={{6,6},{-6,-6}},
                rotation=-90,
                origin={-20,-70})));
          Fluid.HeatExchangers.ConstantEffectiveness Ext_Warm(
            redeclare package Medium1 = Medium_Water,
            redeclare package Medium2 = Medium_Water,
            dp1_nominal(displayUnit="bar") = dp_Heatexchanger_nominal,
            dp2_nominal=dp_Heatexchanger_nominal,
            m1_flow_nominal=m_flow_nominal,
            m2_flow_nominal=m_flow_nominal)
            annotation (Placement(transformation(extent={{5,-5},{-5,5}},
                rotation=0,
                origin={-5,-43})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
          Modelica.Blocks.Interfaces.RealOutput m_flow
            "Mass flow rate from port_a to port_b"
            annotation (Placement(transformation(extent={{90,10},{110,30}})));
          Modelica.Blocks.Interfaces.RealOutput Power_pump "Electrical power consumed"
            annotation (Placement(transformation(extent={{90,50},{110,70}})));
          Modelica.Blocks.Interfaces.RealOutput Temp_out "Temperature in port medium"
            annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
          Modelica.Blocks.Interfaces.RealOutput Temp_in "Temperature in port medium"
            annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
          Modelica.Blocks.Interfaces.RealInput Valve_warm
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-112,-72},{-88,-48}})));
          Modelica.Blocks.Interfaces.RealInput valve_temp
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-112,-12},{-88,12}})));
          Modelica.Blocks.Interfaces.RealInput pump
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{-112,48},{-88,72}})));
        equation
          connect(vol.heatPort,HeatPort_TBA)  annotation (Line(points={{-8,56},{-24,56},
                  {-24,56},{-40,56},{-40,100},{-40,100}},
                                            color={191,0,0}));
          connect(Fluid_in_cold, val1.port_1)
            annotation (Line(points={{-60,-100},{-60,-46}}, color={0,127,255}));
          connect(fan2.port_b,vol. ports[1])
            annotation (Line(points={{-60,36},{-60,46},{0,46}}, color={0,127,255}));
          connect(senMasFlo.m_flow,m_flow)  annotation (Line(points={{71,26},{80,26},{80,
                  20},{100,20}}, color={0,0,127}));
          connect(fan2.P,Power_pump)  annotation (Line(points={{-67.2,36.8},{-67.2,80},{
                  80,80},{80,60},{100,60}}, color={0,0,127}));
          connect(senTem1.T,Temp_out)
            annotation (Line(points={{39,-20},{100,-20}}, color={0,0,127}));
          connect(senTem2.T,Temp_in)  annotation (Line(points={{-25,-20},{0,-20},{0,-60},
                  {100,-60}}, color={0,0,127}));
          connect(pipe1.port_a,val1. port_2)
            annotation (Line(points={{-60,-16},{-60,-34}}, color={0,127,255}));
          connect(senTem2.port,val1. port_2) annotation (Line(points={{-32,-30},{-60,-30},
                  {-60,-34}}, color={0,127,255}));
          connect(pipe1.port_b,fan2. port_a)
            annotation (Line(points={{-60,4},{-60,20}}, color={0,127,255}));
          connect(pump, fan2.y) annotation (Line(points={{-100,60},{-80,60},{-80,28},{-69.6,
                  28}}, color={0,0,127}));
          connect(valve_temp, val1.y) annotation (Line(points={{-100,0},{-80,0},{-80,-40},
                  {-67.2,-40}}, color={0,0,127}));
          connect(Valve_warm, val.y) annotation (Line(points={{-100,-60},{-40,-60},{-40,
                  -70},{-27.2,-70}}, color={0,0,127}));
          connect(val.port_a, Fluid_in_warm)
            annotation (Line(points={{-20,-76},{-20,-100}}, color={0,127,255}));
          connect(val.port_b, Ext_Warm.port_a2) annotation (Line(points={{-20,-64},{-20,
                  -46},{-10,-46}}, color={0,127,255}));
          connect(Ext_Warm.port_b2, Fluid_out_warm)
            annotation (Line(points={{0,-46},{20,-46},{20,-100}}, color={0,127,255}));
          connect(pipe.port_b, vol1.ports[1])
            annotation (Line(points={{60,-18},{60,-41.8}}, color={0,127,255}));
          connect(Ext_Warm.port_a1, vol1.ports[2]) annotation (Line(points={{0,-40},{30,
                  -40},{30,-40.6},{60,-40.6}}, color={0,127,255}));
          connect(vol1.ports[3], Fluid_out_cold)
            annotation (Line(points={{60,-39.4},{60,-100}}, color={0,127,255}));
          connect(senTem1.port, vol1.ports[4]) annotation (Line(points={{32,-30},{60,-30},
                  {60,-38.2}}, color={0,127,255}));
          connect(val1.port_3, Ext_Warm.port_b1)
            annotation (Line(points={{-54,-40},{-10,-40}}, color={0,127,255}));
          connect(vol.ports[2], senMasFlo.port_a)
            annotation (Line(points={{4,46},{60,46},{60,36}}, color={0,127,255}));
          connect(senMasFlo.port_b, pipe.port_a)
            annotation (Line(points={{60,16},{60,2}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end TBA_Pipe_v2;

        model TBA_Pipe_v3
          replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";
          import BaseLib = AixLib.Utilities;

            parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));

            parameter Modelica.SIunits.Pressure dp_Heatexchanger_nominal = 0 annotation(Dialog(tab = "General"));

            parameter Modelica.SIunits.Length TBA_pipe_diameter = 0.02 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length TBA_wall_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length TBA_wall_height = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.ThermalConductance Thermal_Conductance = 0 annotation(Dialog(tab = "General"));

          Fluid.MixingVolumes.MixingVolume vol(
            m_flow_nominal=1,
            redeclare package Medium = Medium_Water,
            nPorts=2,
            V=TBA_wall_length*TBA_wall_height*5.8*3.14159*(TBA_pipe_diameter/2)^2)
            annotation (Placement(transformation(extent={{-8,46},{12,66}})));
          Fluid.Actuators.Valves.ThreeWayLinear val1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            dpValve_nominal=dp_Valve_nominal,
            use_inputFilter=false)
            annotation (Placement(transformation(extent={{6,6},{-6,-6}},
                rotation=-90,
                origin={-60,-40})));
          Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
                Medium_Water,
            y_start=1,
            redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per)
            annotation (Placement(transformation(extent={{8,8},{-8,-8}},
                rotation=-90,
                origin={-60,28})));
          Fluid.Sensors.Temperature senTem2(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-42,-30},{-22,-10}})));
          Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{10,10},{-10,-10}},
                rotation=90,
                origin={60,26})));
          Fluid.Sensors.Temperature senTem1(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{22,-30},{42,-10}})));
          Modelica.Fluid.Pipes.DynamicPipe pipe1(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            nNodes=pipe_nodes,
            diameter=pipe_diameter,
            length=pipe_length + 50)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-60,-6})));
          Modelica.Fluid.Pipes.DynamicPipe pipe(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            nNodes=pipe_nodes,
            diameter=pipe_diameter,
            length=pipe_length + 50)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={60,-8})));
          Fluid.Actuators.Valves.TwoWayLinear val(
            use_inputFilter=false,
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            dpValve_nominal=dp_Valve_nominal)             annotation (Placement(
                transformation(
                extent={{6,6},{-6,-6}},
                rotation=-90,
                origin={-20,-80})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
          Modelica.Blocks.Interfaces.RealOutput m_flow
            "Mass flow rate from port_a to port_b"
            annotation (Placement(transformation(extent={{90,10},{110,30}})));
          Modelica.Blocks.Interfaces.RealOutput Power_pump "Electrical power consumed"
            annotation (Placement(transformation(extent={{90,50},{110,70}})));
          Modelica.Blocks.Interfaces.RealOutput Temp_out "Temperature in port medium"
            annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
          Modelica.Blocks.Interfaces.RealOutput Temp_in "Temperature in port medium"
            annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
          Modelica.Blocks.Interfaces.RealInput Valve_warm
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-112,-72},{-88,-48}})));
          Modelica.Blocks.Interfaces.RealInput valve_temp
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-112,-12},{-88,12}})));
          Modelica.Blocks.Interfaces.RealInput pump
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{-112,48},{-88,72}})));
          Fluid.MixingVolumes.MixingVolume vol2(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            nPorts=2,
            V=0.01)   annotation (Placement(transformation(
                extent={{4,-4},{-4,4}},
                rotation=180,
                origin={-8,-44})));
          Fluid.MixingVolumes.MixingVolume vol3(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            nPorts=2,
            V=0.01)   annotation (Placement(transformation(
                extent={{4,4},{-4,-4}},
                rotation=180,
                origin={-8,-56})));
          Fluid.FixedResistances.PressureDrop res1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            dp_nominal(displayUnit="bar") = dp_Heatexchanger_nominal)
            annotation (Placement(transformation(extent={{-28,-46},{-40,-34}})));
          Fluid.FixedResistances.PressureDrop res2(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            dp_nominal(displayUnit="bar") = dp_Heatexchanger_nominal)
            annotation (Placement(transformation(extent={{0,-66},{12,-54}})));
          Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
                Thermal_Conductance) annotation (Placement(transformation(
                extent={{-4,-4},{4,4}},
                rotation=90,
                origin={-20,-50})));
          Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare
              package Medium =
                       Medium_Water) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,-40})));
        equation
          connect(vol.heatPort,HeatPort_TBA)  annotation (Line(points={{-8,56},{-24,56},
                  {-24,56},{-40,56},{-40,100},{-40,100}},
                                            color={191,0,0}));
          connect(Fluid_in_cold, val1.port_1)
            annotation (Line(points={{-60,-100},{-60,-46}}, color={0,127,255}));
          connect(fan2.port_b,vol. ports[1])
            annotation (Line(points={{-60,36},{-60,46},{0,46}}, color={0,127,255}));
          connect(senMasFlo.m_flow,m_flow)  annotation (Line(points={{71,26},{80,26},{80,
                  20},{100,20}}, color={0,0,127}));
          connect(fan2.P,Power_pump)  annotation (Line(points={{-67.2,36.8},{-67.2,80},{
                  80,80},{80,60},{100,60}}, color={0,0,127}));
          connect(senTem1.T,Temp_out)
            annotation (Line(points={{39,-20},{100,-20}}, color={0,0,127}));
          connect(senTem2.T,Temp_in)  annotation (Line(points={{-25,-20},{20,-20},{20,-60},
                  {100,-60}}, color={0,0,127}));
          connect(pipe1.port_a,val1. port_2)
            annotation (Line(points={{-60,-16},{-60,-34}}, color={0,127,255}));
          connect(senTem2.port,val1. port_2) annotation (Line(points={{-32,-30},{-60,-30},
                  {-60,-34}}, color={0,127,255}));
          connect(pipe1.port_b,fan2. port_a)
            annotation (Line(points={{-60,4},{-60,20}}, color={0,127,255}));
          connect(pump, fan2.y) annotation (Line(points={{-100,60},{-80,60},{-80,28},{-69.6,
                  28}}, color={0,0,127}));
          connect(valve_temp, val1.y) annotation (Line(points={{-100,0},{-80,0},{-80,-40},
                  {-67.2,-40}}, color={0,0,127}));
          connect(Valve_warm, val.y) annotation (Line(points={{-100,-60},{-40,-60},{-40,
                  -80},{-27.2,-80}}, color={0,0,127}));
          connect(val.port_a, Fluid_in_warm)
            annotation (Line(points={{-20,-86},{-20,-100}}, color={0,127,255}));
          connect(vol.ports[2], senMasFlo.port_a)
            annotation (Line(points={{4,46},{60,46},{60,36}}, color={0,127,255}));
          connect(senMasFlo.port_b, pipe.port_a)
            annotation (Line(points={{60,16},{60,2}}, color={0,127,255}));
          connect(val.port_b, vol3.ports[1]) annotation (Line(points={{-20,-74},{-20,-60},
                  {-8.8,-60}}, color={0,127,255}));
          connect(res1.port_a, vol2.ports[1])
            annotation (Line(points={{-28,-40},{-8.8,-40}}, color={0,127,255}));
          connect(res1.port_b, val1.port_3)
            annotation (Line(points={{-40,-40},{-54,-40}}, color={0,127,255}));
          connect(vol3.ports[2], res2.port_a)
            annotation (Line(points={{-7.2,-60},{0,-60}}, color={0,127,255}));
          connect(res2.port_b, Fluid_out_warm)
            annotation (Line(points={{12,-60},{20,-60},{20,-100}}, color={0,127,255}));
          connect(thermalConductor.port_b, vol2.heatPort) annotation (Line(points={{-20,
                  -46},{-20,-46},{-20,-44},{-12,-44}}, color={191,0,0}));
          connect(thermalConductor.port_a, vol3.heatPort) annotation (Line(points={{-20,
                  -54},{-20,-54},{-20,-56},{-12,-56}}, color={191,0,0}));
          connect(vol2.ports[2], teeJunctionIdeal.port_3)
            annotation (Line(points={{-7.2,-40},{50,-40}}, color={0,127,255}));
          connect(teeJunctionIdeal.port_1, Fluid_out_cold)
            annotation (Line(points={{60,-50},{60,-100}}, color={0,127,255}));
          connect(teeJunctionIdeal.port_2, pipe.port_b)
            annotation (Line(points={{60,-30},{60,-18}}, color={0,127,255}));
          connect(senTem1.port, pipe.port_b) annotation (Line(points={{32,-30},{32,-36},
                  {44,-36},{44,-26},{60,-26},{60,-18}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end TBA_Pipe_v3;

        model TBA_Pipe_Openplanoffice_v3
          replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";
          import BaseLib = AixLib.Utilities;

            parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));

            parameter Modelica.SIunits.Pressure dp_Heatexchanger_nominal = 0 annotation(Dialog(tab = "General"));

            parameter Modelica.SIunits.Length TBA_pipe_diameter = 0.02 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length TBA_wall_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length TBA_wall_height = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.ThermalConductance Thermal_Conductance = 0 annotation(Dialog(tab = "General"));

          Fluid.MixingVolumes.MixingVolume vol(
            m_flow_nominal=1,
            redeclare package Medium = Medium_Water,
            nPorts=2,
            V=TBA_wall_length*TBA_wall_height*5.8*3.14159*(TBA_pipe_diameter/2)^2)
            annotation (Placement(transformation(extent={{-8,46},{12,66}})));
          Fluid.Actuators.Valves.ThreeWayLinear val1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            dpValve_nominal=dp_Valve_nominal,
            use_inputFilter=false)
            annotation (Placement(transformation(extent={{6,6},{-6,-6}},
                rotation=-90,
                origin={-60,-40})));
          Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
                Medium_Water,
              redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per,
            y_start=1)
            annotation (Placement(transformation(extent={{8,8},{-8,-8}},
                rotation=-90,
                origin={-60,28})));
          Fluid.Sensors.Temperature senTem2(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-42,-30},{-22,-10}})));
          Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=90,
                origin={60,26})));
          Fluid.Sensors.Temperature senTem1(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{22,-30},{42,-10}})));
          Modelica.Fluid.Pipes.DynamicPipe pipe(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            nNodes=pipe_nodes,
            diameter=pipe_diameter,
            length=pipe_length + 50)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={60,-8})));
          Modelica.Fluid.Pipes.DynamicPipe pipe1(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            nNodes=pipe_nodes,
            diameter=pipe_diameter,
            length=pipe_length + 50)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-60,-6})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
          Modelica.Blocks.Interfaces.RealInput valve_temp
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-112,-12},{-88,12}})));
          Modelica.Blocks.Interfaces.RealInput pump
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{-112,48},{-88,72}})));
          Modelica.Blocks.Interfaces.RealOutput m_flow
            "Mass flow rate from port_a to port_b"
            annotation (Placement(transformation(extent={{90,10},{110,30}})));
          Modelica.Blocks.Interfaces.RealOutput Power_pump "Electrical power consumed"
            annotation (Placement(transformation(extent={{90,50},{110,70}})));
          Modelica.Blocks.Interfaces.RealOutput Temp_out "Temperature in port medium"
            annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
          Modelica.Blocks.Interfaces.RealOutput Temp_in "Temperature in port medium"
            annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
          Fluid.Actuators.Valves.TwoWayLinear val(
            use_inputFilter=false,
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            dpValve_nominal=dp_Valve_nominal)             annotation (Placement(
                transformation(
                extent={{6,6},{-6,-6}},
                rotation=-90,
                origin={-20,-70})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
          Modelica.Blocks.Interfaces.RealInput Valve_warm
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-112,-72},{-88,-48}})));
          Fluid.FixedResistances.PressureDrop res1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            dp_nominal(displayUnit="bar") = dp_Heatexchanger_nominal)
            annotation (Placement(transformation(extent={{-28,-46},{-40,-34}})));
          Fluid.MixingVolumes.MixingVolume vol2(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            nPorts=2,
            V=0.01)   annotation (Placement(transformation(
                extent={{4,-4},{-4,4}},
                rotation=180,
                origin={-8,-44})));
          Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
                Thermal_Conductance) annotation (Placement(transformation(
                extent={{-4,-4},{4,4}},
                rotation=90,
                origin={-20,-50})));
          Fluid.MixingVolumes.MixingVolume vol3(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            nPorts=2,
            V=0.01)   annotation (Placement(transformation(
                extent={{4,4},{-4,-4}},
                rotation=180,
                origin={-8,-56})));
          Fluid.FixedResistances.PressureDrop res2(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal,
            dp_nominal(displayUnit="bar") = dp_Heatexchanger_nominal)
            annotation (Placement(transformation(extent={{0,-66},{12,-54}})));
          Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare
              package Medium =
                       Medium_Water) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,-40})));
        equation
          connect(vol.heatPort,HeatPort_TBA)  annotation (Line(points={{-8,56},{-24,56},
                  {-24,56},{-40,56},{-40,100},{-40,100}},
                                            color={191,0,0}));
          connect(Fluid_in_cold, val1.port_1)
            annotation (Line(points={{-60,-100},{-60,-46}}, color={0,127,255}));
          connect(fan2.port_b,vol. ports[1])
            annotation (Line(points={{-60,36},{-60,46},{0,46}}, color={0,127,255}));
          connect(val1.y, valve_temp) annotation (Line(points={{-67.2,-40},{-80,-40},{-80,
                  0},{-100,0}}, color={0,0,127}));
          connect(fan2.y,pump)
            annotation (Line(points={{-69.6,28},{-80,28},{-80,60},{-100,60}},
                                                            color={0,0,127}));
          connect(vol.ports[2],senMasFlo. port_b)
            annotation (Line(points={{4,46},{60,46},{60,36}}, color={0,127,255}));
          connect(senMasFlo.m_flow,m_flow)  annotation (Line(points={{71,26},{80,26},{80,
                  20},{100,20}}, color={0,0,127}));
          connect(fan2.P,Power_pump)  annotation (Line(points={{-67.2,36.8},{-67.2,80},{
                  80,80},{80,60},{100,60}}, color={0,0,127}));
          connect(senTem1.T,Temp_out)
            annotation (Line(points={{39,-20},{100,-20}}, color={0,0,127}));
          connect(senTem2.T,Temp_in)  annotation (Line(points={{-25,-20},{20,-20},{20,-60},
                  {100,-60}}, color={0,0,127}));
          connect(pipe1.port_a,val1. port_2)
            annotation (Line(points={{-60,-16},{-60,-34}}, color={0,127,255}));
          connect(pipe1.port_b,fan2. port_a)
            annotation (Line(points={{-60,4},{-60,20}}, color={0,127,255}));
          connect(pipe.port_a,senMasFlo. port_a)
            annotation (Line(points={{60,2},{60,16}}, color={0,127,255}));
          connect(senTem2.port,val1. port_2) annotation (Line(points={{-32,-30},{-60,-30},
                  {-60,-34}}, color={0,127,255}));
          connect(val.port_a, Fluid_in_warm)
            annotation (Line(points={{-20,-76},{-20,-100}}, color={0,127,255}));
          connect(val.y, Valve_warm) annotation (Line(points={{-27.2,-70},{-80,-70},{
                  -80,-60},{-100,-60}},
                                    color={0,0,127}));
          connect(val1.port_3, res1.port_b)
            annotation (Line(points={{-54,-40},{-40,-40}}, color={0,127,255}));
          connect(res1.port_a, vol2.ports[1])
            annotation (Line(points={{-28,-40},{-8.8,-40}}, color={0,127,255}));
          connect(vol2.heatPort, thermalConductor.port_b)
            annotation (Line(points={{-12,-44},{-20,-44},{-20,-46}}, color={191,0,0}));
          connect(thermalConductor.port_a, vol3.heatPort)
            annotation (Line(points={{-20,-54},{-20,-56},{-12,-56}}, color={191,0,0}));
          connect(vol3.ports[1], res2.port_a)
            annotation (Line(points={{-8.8,-60},{0,-60}}, color={0,127,255}));
          connect(val.port_b, vol3.ports[2]) annotation (Line(points={{-20,-64},{-20,-60},
                  {-7.2,-60}}, color={0,127,255}));
          connect(res2.port_b, Fluid_out_warm)
            annotation (Line(points={{12,-60},{20,-60},{20,-100}}, color={0,127,255}));
          connect(pipe.port_b, teeJunctionIdeal.port_2)
            annotation (Line(points={{60,-18},{60,-30}}, color={0,127,255}));
          connect(senTem1.port, teeJunctionIdeal.port_2) annotation (Line(points={{32,
                  -30},{32,-36},{40,-36},{40,-24},{60,-24},{60,-30}}, color={0,127,255}));
          connect(vol2.ports[2], teeJunctionIdeal.port_3)
            annotation (Line(points={{-7.2,-40},{50,-40}}, color={0,127,255}));
          connect(teeJunctionIdeal.port_1, Fluid_out_cold)
            annotation (Line(points={{60,-50},{60,-100}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end TBA_Pipe_Openplanoffice_v3;

        model Full_Transfer_TBA_Heatexchanger_v2
            replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";

            parameter Modelica.SIunits.Pressure dp_Heatexchanger_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal_openplanoffice = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_openplanoffice = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal_conferenceroom = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_conferenceroom = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal_multipersonoffice = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_multipersonoffice = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal_canteen = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_canteen = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dp_Valve_nominal_workshop = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_workshop = 0 annotation(Dialog(tab = "General"));

          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,16},{-90,36}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-24},{-90,-4}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA[5]
            annotation (Placement(transformation(extent={{30,90},{50,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
          BusSystems.Bus_Control controlBus
            annotation (Placement(transformation(extent={{80,20},{120,60}})));
          BusSystems.Bus_measure measureBus
            annotation (Placement(transformation(extent={{80,-60},{120,-20}})));
          TBA_Pipe_Openplanoffice_v3 OpenPlanOffice(
            V_mixing=0.0001,
            dp_Valve_nominal=dp_Valve_nominal_openplanoffice,
            m_flow_nominal=m_flow_nominal_openplanoffice,
            TBA_pipe_diameter=0.02,
            TBA_wall_length=45,
            TBA_wall_height=30,
            pipe_diameter=0.0419,
            dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
            pipe_height=0,
            pipe_length=35,
            Thermal_Conductance=70072/10)
            annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
          TBA_Pipe_v3 Conferenceroom(
            m_flow_nominal=m_flow_nominal_conferenceroom,
            dp_Valve_nominal=dp_Valve_nominal_conferenceroom,
            TBA_pipe_diameter=0.02,
            TBA_wall_length=5,
            TBA_wall_height=10,
            V_mixing=0.0001,
            pipe_diameter=0.0161,
            dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
            pipe_length=45,
            Thermal_Conductance=11105/10)
            annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
          TBA_Pipe_v3 Multipersonoffice(
            dp_Valve_nominal=dp_Valve_nominal_multipersonoffice,
            m_flow_nominal=m_flow_nominal_multipersonoffice,
            TBA_pipe_diameter=0.02,
            TBA_wall_length=5,
            TBA_wall_height=20,
            V_mixing=0.0001,
            dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
            pipe_length=70,
            pipe_height=0,
            Thermal_Conductance=16397/10,
            pipe_diameter=0.0161)
            annotation (Placement(transformation(extent={{-20,60},{0,80}})));
          TBA_Pipe_v3 Canteen(
            dp_Valve_nominal=dp_Valve_nominal_canteen,
            m_flow_nominal=m_flow_nominal_canteen,
            pipe_length=10,
            TBA_pipe_diameter=0.02,
            TBA_wall_length=20,
            TBA_wall_height=30,
            V_mixing=0.0001,
            pipe_diameter=0.0273,
            pipe_height=0,
            dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
            Thermal_Conductance=31781/10)
            annotation (Placement(transformation(extent={{20,60},{40,80}})));
          TBA_Pipe_v3 Workshop(
            dp_Valve_nominal=dp_Valve_nominal_workshop,
            m_flow_nominal=m_flow_nominal_workshop,
            pipe_length=15,
            TBA_pipe_diameter=0.02,
            TBA_wall_length=30,
            TBA_wall_height=30,
            V_mixing=0.0001,
            pipe_height=0,
            dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
            pipe_diameter(displayUnit="m") = 0.0419,
            Thermal_Conductance=57972/10)
            annotation (Placement(transformation(extent={{60,60},{80,80}})));
        equation
          connect(OpenPlanOffice.HeatPort_TBA, HeatPort_TBA[1]) annotation (Line(points=
                 {{-94,80},{-94,88},{40,88},{40,92}}, color={191,0,0}));
          connect(Conferenceroom.HeatPort_TBA, HeatPort_TBA[2]) annotation (Line(points=
                 {{-54,80},{-54,88},{40,88},{40,96}}, color={191,0,0}));
          connect(Multipersonoffice.HeatPort_TBA, HeatPort_TBA[3]) annotation (Line(
                points={{-14,80},{-14,88},{40,88},{40,100}}, color={191,0,0}));
          connect(Canteen.HeatPort_TBA, HeatPort_TBA[4]) annotation (Line(points={{26,
                  80},{26,88},{40,88},{40,104}}, color={191,0,0}));
          connect(Workshop.HeatPort_TBA, HeatPort_TBA[5]) annotation (Line(points={{66,
                  80},{66,88},{40,88},{40,108}}, color={191,0,0}));
          connect(OpenPlanOffice.Valve_warm, controlBus.Valve_TBA_Warm_OpenPlanOffice)
            annotation (Line(points={{-100,64},{-110,64},{-110,40.1},{100.1,40.1}},
                color={0,0,127}));
          connect(OpenPlanOffice.valve_temp, controlBus.Valve_TBA_OpenPlanOffice_Temp)
            annotation (Line(points={{-100,70},{-110,70},{-110,40.1},{100.1,40.1}},
                color={0,0,127}));
          connect(OpenPlanOffice.pump, controlBus.Pump_TBA_OpenPlanOffice_y)
            annotation (Line(points={{-100,76},{-110,76},{-110,40.1},{100.1,40.1}},
                color={0,0,127}));
          connect(Conferenceroom.Valve_warm, controlBus.Valve_TBA_Warm_conferenceroom)
            annotation (Line(points={{-60,64},{-68,64},{-68,40.1},{100.1,40.1}}, color=
                  {0,0,127}));
          connect(Conferenceroom.valve_temp, controlBus.Valve_TBA_ConferenceRoom_Temp)
            annotation (Line(points={{-60,70},{-68,70},{-68,40.1},{100.1,40.1}}, color=
                  {0,0,127}));
          connect(Conferenceroom.pump, controlBus.Pump_TBA_ConferenceRoom_y)
            annotation (Line(points={{-60,76},{-68,76},{-68,40.1},{100.1,40.1}}, color=
                  {0,0,127}));
          connect(Multipersonoffice.Valve_warm, controlBus.Valve_TBA_Warm_multipersonoffice)
            annotation (Line(points={{-20,64},{-26,64},{-26,40.1},{100.1,40.1}}, color=
                  {0,0,127}));
          connect(Multipersonoffice.valve_temp, controlBus.Valve_TBA_MultiPersonOffice_Temp)
            annotation (Line(points={{-20,70},{-26,70},{-26,40.1},{100.1,40.1}}, color=
                  {0,0,127}));
          connect(Multipersonoffice.pump, controlBus.Pump_TBA_MultiPersonOffice_y)
            annotation (Line(points={{-20,76},{-26,76},{-26,40.1},{100.1,40.1}}, color=
                  {0,0,127}));
          connect(Canteen.Valve_warm, controlBus.Valve_TBA_Warm_canteen) annotation (
              Line(points={{20,64},{14,64},{14,40.1},{100.1,40.1}}, color={0,0,127}));
          connect(Canteen.valve_temp, controlBus.Valve_TBA_Canteen_Temp) annotation (
              Line(points={{20,70},{14,70},{14,40.1},{100.1,40.1}}, color={0,0,127}));
          connect(Canteen.pump, controlBus.Pump_TBA_Canteen_y) annotation (Line(points=
                  {{20,76},{14,76},{14,40.1},{100.1,40.1}}, color={0,0,127}));
          connect(Workshop.Valve_warm, controlBus.Valve_TBA_Warm_workshop) annotation (
              Line(points={{60,64},{54,64},{54,40.1},{100.1,40.1}}, color={0,0,127}));
          connect(Workshop.pump, controlBus.Pump_TBA_Workshop_y) annotation (Line(
                points={{60,76},{54,76},{54,40.1},{100.1,40.1}}, color={0,0,127}));
          connect(Workshop.valve_temp, controlBus.Valve_TBA_Workshop_Temp) annotation (
              Line(points={{60,70},{54,70},{54,40.1},{100.1,40.1}}, color={0,0,127}));
          connect(OpenPlanOffice.Temp_in, measureBus.TBA_openplanoffice_in) annotation (
             Line(points={{-80,64},{-74,64},{-74,40},{60,40},{60,-39.9},{100.1,-39.9}},
                color={0,0,127}));
          connect(OpenPlanOffice.Temp_out, measureBus.TBA_openplanoffice_out)
            annotation (Line(points={{-80,68},{-74,68},{-74,40},{60,40},{60,-39.9},{
                  100.1,-39.9}}, color={0,0,127}));
          connect(Conferenceroom.Temp_in, measureBus.TBA_conferencerom_in) annotation (
              Line(points={{-40,64},{-36,64},{-36,40},{60,40},{60,-39.9},{100.1,-39.9}},
                color={0,0,127}));
          connect(Conferenceroom.Temp_out, measureBus.TBA_conferencerom_out)
            annotation (Line(points={{-40,68},{-36,68},{-36,40},{60,40},{60,-39.9},{
                  100.1,-39.9}}, color={0,0,127}));
          connect(Multipersonoffice.Temp_in, measureBus.TBA_multipersonoffice_in)
            annotation (Line(points={{0,64},{2,64},{2,64},{4,64},{4,40},{60,40},{60,
                  -39.9},{100.1,-39.9}}, color={0,0,127}));
          connect(Multipersonoffice.Temp_out, measureBus.TBA_multipersonoffice_out)
            annotation (Line(points={{0,68},{4,68},{4,40},{60,40},{60,-39.9},{100.1,
                  -39.9}}, color={0,0,127}));
          connect(Canteen.Temp_in, measureBus.TBA_canteen_in) annotation (Line(points={
                  {40,64},{46,64},{46,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,
                  127}));
          connect(Canteen.Temp_out, measureBus.TBA_canteen_out) annotation (Line(points=
                 {{40,68},{46,68},{46,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,
                  127}));
          connect(Workshop.Temp_in, measureBus.TBA_workshop_in) annotation (Line(points=
                 {{80,64},{84,64},{84,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,
                  127}));
          connect(Workshop.Temp_out, measureBus.TBA_workshop_out) annotation (Line(
                points={{80,68},{84,68},{84,40},{60,40},{60,-39.9},{100.1,-39.9}},
                color={0,0,127}));
          connect(OpenPlanOffice.m_flow, measureBus.TBA_openplanoffice) annotation (
              Line(points={{-80,72},{-74,72},{-74,40},{60,40},{60,-39.9},{100.1,-39.9}},
                color={0,0,127}));
          connect(Conferenceroom.m_flow, measureBus.TBA_conferenceroom) annotation (
              Line(points={{-40,72},{-38,72},{-38,72},{-36,72},{-36,40},{60,40},{60,
                  -39.9},{100.1,-39.9}}, color={0,0,127}));
          connect(Multipersonoffice.m_flow, measureBus.TBA_multipersonoffice)
            annotation (Line(points={{0,72},{4,72},{4,40},{60,40},{60,-39.9},{100.1,
                  -39.9}}, color={0,0,127}));
          connect(Canteen.m_flow, measureBus.TBA_canteen) annotation (Line(points={{40,
                  72},{46,72},{46,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,127}));
          connect(Workshop.m_flow, measureBus.TBA_workshop) annotation (Line(points={{
                  80,72},{84,72},{84,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,
                  127}));
          connect(OpenPlanOffice.Power_pump, measureBus.Pump_TBA_openplanoffice)
            annotation (Line(points={{-80,76},{-74,76},{-74,40},{60,40},{60,-39.9},{
                  100.1,-39.9}}, color={0,0,127}));
          connect(Conferenceroom.Power_pump, measureBus.Pump_TBA_conferenceroom)
            annotation (Line(points={{-40,76},{-36,76},{-36,40},{60,40},{60,-39.9},{
                  100.1,-39.9}}, color={0,0,127}));
          connect(Multipersonoffice.Power_pump, measureBus.Pump_TBA_multipersonoffice)
            annotation (Line(points={{0,76},{4,76},{4,40},{60,40},{60,-39.9},{100.1,
                  -39.9}}, color={0,0,127}));
          connect(Canteen.Power_pump, measureBus.Pump_TBA_canteen) annotation (Line(
                points={{40,76},{46,76},{46,40},{60,40},{60,-39.9},{100.1,-39.9}},
                color={0,0,127}));
          connect(Workshop.Power_pump, measureBus.Pump_TBA_workshop) annotation (Line(
                points={{80,76},{84,76},{84,40},{60,40},{60,-39.9},{100.1,-39.9}},
                color={0,0,127}));
          connect(OpenPlanOffice.Fluid_in_cold, Fluid_in_cold) annotation (Line(points=
                  {{-96,60},{-96,10},{-96,-40},{-100,-40}}, color={0,127,255}));
          connect(OpenPlanOffice.Fluid_in_warm, Fluid_in_warm) annotation (Line(points=
                  {{-92,60},{-92,60},{-92,26},{-100,26}}, color={0,127,255}));
          connect(OpenPlanOffice.Fluid_out_warm, Fluid_out_warm) annotation (Line(
                points={{-88,60},{-88,60},{-88,-14},{-94,-14},{-94,-14},{-100,-14}},
                color={0,127,255}));
          connect(OpenPlanOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
                points={{-84,60},{-84,60},{-84,-80},{-100,-80}}, color={0,127,255}));
          connect(Conferenceroom.Fluid_in_cold, Fluid_in_cold) annotation (Line(points=
                  {{-56,60},{-56,-40},{-100,-40}}, color={0,127,255}));
          connect(Conferenceroom.Fluid_out_cold, Fluid_out_cold) annotation (Line(
                points={{-44,60},{-44,60},{-44,-80},{-72,-80},{-72,-80},{-100,-80}},
                color={0,127,255}));
          connect(Multipersonoffice.Fluid_in_cold, Fluid_in_cold) annotation (Line(
                points={{-16,60},{-16,-40},{-100,-40}}, color={0,127,255}));
          connect(Multipersonoffice.Fluid_out_cold, Fluid_out_cold)
            annotation (Line(points={{-4,60},{-4,-80},{-100,-80}}, color={0,127,255}));
          connect(Canteen.Fluid_in_cold, Fluid_in_cold)
            annotation (Line(points={{24,60},{24,-40},{-100,-40}}, color={0,127,255}));
          connect(Canteen.Fluid_out_cold, Fluid_out_cold)
            annotation (Line(points={{36,60},{36,-80},{-100,-80}}, color={0,127,255}));
          connect(Workshop.Fluid_in_cold, Fluid_in_cold)
            annotation (Line(points={{64,60},{64,-40},{-100,-40}}, color={0,127,255}));
          connect(Workshop.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{76,
                  60},{76,60},{76,-80},{-100,-80}}, color={0,127,255}));
          connect(Conferenceroom.Fluid_in_warm, Fluid_in_warm)
            annotation (Line(points={{-52,60},{-52,26},{-100,26}}, color={0,127,255}));
          connect(Multipersonoffice.Fluid_in_warm, Fluid_in_warm)
            annotation (Line(points={{-12,60},{-12,26},{-100,26}}, color={0,127,255}));
          connect(Canteen.Fluid_in_warm, Fluid_in_warm)
            annotation (Line(points={{28,60},{28,26},{-100,26}}, color={0,127,255}));
          connect(Workshop.Fluid_in_warm, Fluid_in_warm)
            annotation (Line(points={{68,60},{68,26},{-100,26}}, color={0,127,255}));
          connect(Conferenceroom.Fluid_out_warm, Fluid_out_warm) annotation (Line(
                points={{-48,60},{-48,-14},{-100,-14}}, color={0,127,255}));
          connect(Multipersonoffice.Fluid_out_warm, Fluid_out_warm)
            annotation (Line(points={{-8,60},{-8,-14},{-100,-14}}, color={0,127,255}));
          connect(Canteen.Fluid_out_warm, Fluid_out_warm)
            annotation (Line(points={{32,60},{32,-14},{-100,-14}}, color={0,127,255}));
          connect(Workshop.Fluid_out_warm, Fluid_out_warm)
            annotation (Line(points={{72,60},{72,-14},{-100,-14}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Full_Transfer_TBA_Heatexchanger_v2;
      end Transfer_TBA;

      package Transfer_RLT
        model Full_Transfer_RLT_v2
          replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";
          replaceable package Medium_Air =
            AixLib.Media.Air "Medium in the component";

          RLT_v2 Workshop(
            RLT_m_flow_nominal=0.65,
            m_flow_nominal_hot=0.194,
            pipe_length=15,
            V_mixing=0.0001,
            pipe_height=0,
            pipe_length_air=25,
            pipe_diameter_hot=0.0126,
            pipe_diameter_air=0.415,
            RLT_tau=6.25,
            V_air=0.55,
            Area_pipe_air=1950/(4*3600),
            Area_Heatexchanger_AirWater_Hot=4.75,
            Area_Heatexchanger_AirWater_Cold=414.86,
            RLT_dp_Heatexchanger(displayUnit="Pa") = 38,
            dpValve_nominal_hot=7000,
            pipe_diameter_cold=0.0273,
            m_flow_nominal_cold=1.085,
            dpValve_nominal_cold=10000)
            annotation (Placement(transformation(extent={{44,-66},{64,-86}})));

          Modelica.Fluid.Interfaces.FluidPort_b Air_out[5](redeclare package
              Medium =
                Medium_Air)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{30,90},{50,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium
              = Medium_Air)
            "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
          BusSystems.Bus_Control controlBus
            annotation (Placement(transformation(extent={{82,8},{122,48}})));
          RLT_v2 Canteen(
            RLT_m_flow_nominal=1.1,
            m_flow_nominal_hot=1.072,
            pipe_length=10,
            V_mixing=0.0001,
            pipe_height=0,
            pipe_length_air=10,
            pipe_diameter_hot=0.0273,
            pipe_diameter_air=0.54,
            RLT_tau=3.75,
            V_air=0.92,
            Area_pipe_air=3300/(4*3600),
            Area_Heatexchanger_AirWater_Hot=26.31,
            pipe_diameter_cold=0.0419,
            Area_Heatexchanger_AirWater_Cold=577.82,
            RLT_dp_Heatexchanger(displayUnit="Pa") = 39,
            dpValve_nominal_hot=7000,
            m_flow_nominal_cold=1.729,
            dpValve_nominal_cold=10000)
            annotation (Placement(transformation(extent={{-10,-66},{10,-86}})));

          RLT_v2 MultiPersonOffice(
            RLT_m_flow_nominal=0.08,
            m_flow_nominal_hot=0.152,
            V_mixing=0.0001,
            pipe_diameter_hot=0.0126,
            pipe_diameter_air=0.146,
            V_air=0.07,
            Area_pipe_air=240/(4*3600),
            Area_Heatexchanger_AirWater_Hot=3.72,
            pipe_length=70,
            pipe_height=0,
            pipe_length_air=55,
            RLT_tau=13.75,
            RLT_dp_Heatexchanger(displayUnit="Pa") = 39.5,
            pipe_diameter_cold=0.0161,
            m_flow_nominal_cold=0.340,
            Area_Heatexchanger_AirWater_Cold=100.14,
            dpValve_nominal_hot=7000,
            dpValve_nominal_cold=10000)
            annotation (Placement(transformation(extent={{-66,-66},{-46,-86}})));

          RLT_v2 ConferenceRoom(
            RLT_m_flow_nominal=0.333,
            m_flow_nominal_hot=0.153,
            V_mixing=0.0001,
            pipe_diameter_hot=0.0126,
            pipe_diameter_air=0.297,
            V_air=0.28,
            Area_pipe_air=1000/(4*3600),
            Area_Heatexchanger_AirWater_Hot=3.75,
            pipe_length=45,
            pipe_height=0,
            pipe_length_air=30,
            RLT_tau=7.5,
            RLT_dp_Heatexchanger(displayUnit="Pa") = 37.5,
            pipe_diameter_cold=0.0126,
            m_flow_nominal_cold=0.161,
            Area_Heatexchanger_AirWater_Cold=47.42,
            dpValve_nominal_hot=7000,
            dpValve_nominal_cold=10000)
            annotation (Placement(transformation(extent={{46,72},{66,52}})));

          BusSystems.Bus_measure measureBus
            annotation (Placement(transformation(extent={{82,-50},{122,-10}})));
          RLT_Central_v2 Central(
            pipe_length=20,
            V_mixing=0.0001,
            pipe_height=0,
            Area_pipe_air=10090/(4*3600),
            Area_Heatexchanger_AirWater_Hot=89.51,
            pipe_diameter_hot=0.0419,
            Area_Heatexchanger_AirWater_Cold=819.41,
            m_flow_nominal_hot=3.649,
            dpValve_nominal_hot=7000,
            pipe_diameter_cold=0.0419,
            m_flow_nominal_cold=1.639,
            dpValve_nominal_cold=10000)
            annotation (Placement(transformation(extent={{-64,72},{-44,52}})));
          RLT_OpenPlanOffice_v2 OpenPlanOffice(
            m_flow_nominal_hot=2.078,
            RLT_m_flow_nominal=1.204,
            V_mixing=0.0001,
            pipe_diameter_hot=0.0419,
            pipe_diameter_air=0.564,
            Area_pipe_air=3600/(4*3600),
            Area_Heatexchanger_AirWater_Hot=50.98,
            pipe_length=35,
            pipe_height=0,
            pipe_length_air=15,
            Area_Heatexchanger_AirWater_Cold=431.91,
            RLT_tau=3.75,
            RLT_dp_Heatexchanger(displayUnit="Pa") = 38.5,
            pipe_diameter_cold=0.0273,
            m_flow_nominal_cold=1.151,
            dpValve_nominal_hot=7000,
            dpValve_nominal_cold=10000)
            annotation (Placement(transformation(extent={{-10,72},{10,52}})));
        equation
          connect(ConferenceRoom.Air_out, Air_out[2]) annotation (Line(points={{66,68.6},
                  {66,68},{74,68},{74,80},{40,80},{40,96}},
                                            color={0,127,255}));
          connect(MultiPersonOffice.Air_out, Air_out[3]) annotation (Line(points={{-46,
                  -69.4},{-46,-70},{-30,-70},{-30,80},{40,80},{40,100}},
                                                   color={0,127,255}));
          connect(Canteen.Air_out, Air_out[4]) annotation (Line(points={{10,-69.4},{10,
                  -70},{16,-70},{16,-64},{-30,-64},{-30,80},{40,80},{40,104}},
                                         color={0,127,255}));
          connect(Workshop.Air_out, Air_out[5]) annotation (Line(points={{64,-69.4},{64,
                  -70},{72,-70},{72,-60},{-30,-60},{-30,80},{40,80},{40,108}},
                                         color={0,127,255}));
          connect(ConferenceRoom.Fluid_out_hot, Fluid_out_hot)
            annotation (Line(points={{48,52},{48,40},{-100,40}}, color={0,127,255}));
          connect(MultiPersonOffice.Fluid_out_hot, Fluid_out_hot) annotation (Line(
                points={{-64,-86},{-64,-90},{-74,-90},{-74,40},{-100,40}}, color={0,127,
                  255}));
          connect(Canteen.Fluid_out_hot, Fluid_out_hot) annotation (Line(points={{-8,
                  -86},{-8,-90},{-14,-90},{-14,-88},{-14,40},{-100,40}}, color={0,127,
                  255}));
          connect(Workshop.Fluid_out_hot, Fluid_out_hot) annotation (Line(points={{46,
                  -86},{46,-90},{42,-90},{40,-90},{40,40},{-100,40}}, color={0,127,255}));
          connect(ConferenceRoom.Fluid_out_cold, Fluid_out_cold) annotation (Line(
                points={{60,52},{60,0},{-80,0},{-80,-80},{-100,-80}},   color={0,127,
                  255}));
          connect(MultiPersonOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
                points={{-52,-86},{-52,-90},{-42,-90},{-42,-90},{-42,0},{-80,0},{-80,
                  -80},{-100,-80}},                                   color={0,127,255}));
          connect(Canteen.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{4,-86},
                  {4,-90},{16,-90},{16,-90},{16,0},{-80,0},{-80,-80},{-100,-80}},
                                                            color={0,127,255}));
          connect(Workshop.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{58,-86},
                  {58,-90},{68,-90},{68,-90},{68,-8},{-80,-8},{-80,-80},{-100,-80}},
                                                            color={0,127,255}));
          connect(ConferenceRoom.Fluid_in_cold, Fluid_in_cold)
            annotation (Line(points={{64,52},{64,-40},{-100,-40}}, color={0,127,255}));
          connect(MultiPersonOffice.Fluid_in_cold, Fluid_in_cold)
            annotation (Line(points={{-48,-86},{-48,-90},{-42,-90},{-40,-90},{-40,-40},
                  {-100,-40}},                                     color={0,127,255}));
          connect(Canteen.Fluid_in_cold, Fluid_in_cold)
            annotation (Line(points={{8,-86},{8,-90},{20,-90},{18,-90},{18,-40},{-100,
                  -40}},                                           color={0,127,255}));
          connect(Workshop.Fluid_in_cold, Fluid_in_cold)
            annotation (Line(points={{62,-86},{62,-90},{70,-90},{70,-90},{70,-40},{-100,
                  -40}},                                           color={0,127,255}));
          connect(ConferenceRoom.valve_cold, controlBus.Valve_RLT_Cold_ConferenceRoom)
            annotation (Line(points={{66,54},{86,54},{86,28.1},{102.1,28.1}},
                color={0,0,127}));
          connect(ConferenceRoom.valve_hot, controlBus.Valve_RLT_Hot_ConferenceRoom)
            annotation (Line(points={{66,58},{86,58},{86,28.1},{102.1,28.1}},
                color={0,0,127}));
          connect(ConferenceRoom.pump_cold, controlBus.Pump_RLT_ConferenceRoom_cold_y)
            annotation (Line(points={{66,62},{86,62},{86,28.1},{102.1,28.1}},
                color={0,0,127}));
          connect(ConferenceRoom.pump_hot, controlBus.Pump_RLT_ConferenceRoom_hot_y)
            annotation (Line(points={{66,66},{86,66},{86,28.1},{102.1,28.1}},
                color={0,0,127}));
          connect(MultiPersonOffice.valve_cold, controlBus.Valve_RLT_Cold_MultiPersonOffice)
            annotation (Line(points={{-46,-84},{-36,-84},{-36,-90},{86,-90},{86,28.1},{
                  102.1,28.1}},
                         color={0,0,127}));
          connect(MultiPersonOffice.valve_hot, controlBus.Valve_RLT_Hot_MultiPersonOffice)
            annotation (Line(points={{-46,-80},{-36,-80},{-36,-90},{86,-90},{86,28.1},{
                  102.1,28.1}},
                         color={0,0,127}));
          connect(MultiPersonOffice.pump_cold, controlBus.Pump_RLT_MultiPersonOffice_cold_y)
            annotation (Line(points={{-46,-76},{-36,-76},{-36,-90},{86,-90},{86,28.1},{
                  102.1,28.1}},
                         color={0,0,127}));
          connect(MultiPersonOffice.pump_hot, controlBus.Pump_RLT_MultiPersonOffice_hot_y)
            annotation (Line(points={{-46,-72},{-36,-72},{-36,-90},{86,-90},{86,28.1},{
                  102.1,28.1}},
                         color={0,0,127}));
          connect(Canteen.valve_cold, controlBus.Valve_RLT_Cold_Canteen) annotation (
              Line(points={{10,-84},{28,-84},{28,-90},{86,-90},{86,0},{86,0},{86,28.1},
                  {102.1,28.1}},                                                  color=
                 {0,0,127}));
          connect(Canteen.valve_hot, controlBus.Valve_RLT_Hot_Canteen) annotation (Line(
                points={{10,-80},{28,-80},{28,-90},{86,-90},{86,28.1},{102.1,28.1}},
                                                                               color={0,
                  0,127}));
          connect(Canteen.pump_cold, controlBus.Pump_RLT_Canteen_cold_y) annotation (
              Line(points={{10,-76},{28,-76},{28,-90},{86,-90},{86,28.1},{102.1,28.1}},
                                                                                  color=
                 {0,0,127}));
          connect(Canteen.pump_hot, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(
                points={{10,-72},{28,-72},{28,-90},{86,-90},{86,28.1},{102.1,28.1}},
                                                                               color={0,
                  0,127}));
          connect(Workshop.valve_cold, controlBus.Valve_RLT_Cold_Workshop) annotation (
              Line(points={{64,-84},{86,-84},{86,28.1},{102.1,28.1}},
                                                                  color={0,0,127}));
          connect(Workshop.valve_hot, controlBus.Valve_RLT_Hot_Workshop) annotation (
              Line(points={{64,-80},{86,-80},{86,28.1},{102.1,28.1}},
                                                                  color={0,0,127}));
          connect(Workshop.pump_cold, controlBus.Pump_RLT_Workshop_cold_y) annotation (
              Line(points={{64,-76},{86,-76},{86,28.1},{102.1,28.1}},
                                                                  color={0,0,127}));
          connect(Workshop.pump_hot, controlBus.Pump_RLT_Workshop_hot_y) annotation (
              Line(points={{64,-72},{86,-72},{86,28.1},{102.1,28.1}},
                                                                  color={0,0,127}));
          connect(ConferenceRoom.cold_out, measureBus.RLT_conferencerom_cold_out)
            annotation (Line(points={{46,54},{36,54},{36,28},{86,28},{86,-29.9},{102.1,
                  -29.9}}, color={0,0,127}));
          connect(ConferenceRoom.cold_in, measureBus.RLT_conferencerom_cold_in)
            annotation (Line(points={{46,58},{36,58},{36,28},{86,28},{86,-29.9},{102.1,
                  -29.9}}, color={0,0,127}));
          connect(ConferenceRoom.hot_out, measureBus.RLT_conferencerom_hot_out)
            annotation (Line(points={{46,62},{36,62},{36,28},{86,28},{86,-29.9},{102.1,
                  -29.9}}, color={0,0,127}));
          connect(ConferenceRoom.hot_in, measureBus.RLT_conferencerom_hot_in)
            annotation (Line(points={{46,66},{36,66},{36,28},{86,28},{86,-29.9},{102.1,
                  -29.9}}, color={0,0,127}));
          connect(ConferenceRoom.massflow_hot, measureBus.RLT_conferenceroom_warm)
            annotation (Line(points={{48,72},{48,76},{36,76},{36,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(ConferenceRoom.massflow_cold, measureBus.RLT_conferenceroom_cold)
            annotation (Line(points={{64,72},{64,76},{36,76},{36,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(ConferenceRoom.power_pump_cold, measureBus.Pump_RLT_conferenceroom_cold)
            annotation (Line(points={{60,72},{60,76},{36,76},{36,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(ConferenceRoom.power_pump_hot, measureBus.Pump_RLT_conferenceroom_warm)
            annotation (Line(points={{52,72},{52,76},{36,76},{36,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(MultiPersonOffice.massflow_cold, measureBus.RLT_multipersonoffice_cold)
            annotation (Line(points={{-48,-66},{-48,-62},{-36,-62},{-36,-90},{86,-90},{
                  86,-29.9},{102.1,-29.9}}, color={0,0,127}));
          connect(MultiPersonOffice.massflow_hot, measureBus.RLT_multipersonoffice_warm)
            annotation (Line(points={{-64,-66},{-64,-62},{-36,-62},{-36,-90},{86,-90},{
                  86,-29.9},{102.1,-29.9}}, color={0,0,127}));
          connect(MultiPersonOffice.power_pump_cold, measureBus.Pump_RLT_multipersonoffice_cold)
            annotation (Line(points={{-52,-66},{-52,-62},{-36,-62},{-36,-90},{86,-90},{
                  86,-29.9},{102.1,-29.9}}, color={0,0,127}));
          connect(MultiPersonOffice.power_pump_hot, measureBus.Pump_RLT_multipersonoffice_warm)
            annotation (Line(points={{-60,-66},{-60,-62},{-36,-62},{-36,-90},{86,-90},{
                  86,-29.9},{102.1,-29.9}}, color={0,0,127}));
          connect(MultiPersonOffice.hot_in, measureBus.RLT_multipersonoffice_hot_in)
            annotation (Line(points={{-66,-72},{-70,-72},{-70,-90},{86,-90},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(MultiPersonOffice.cold_out, measureBus.RLT_multipersonoffice_cold_out)
            annotation (Line(points={{-66,-84},{-70,-84},{-70,-90},{86,-90},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(MultiPersonOffice.cold_in, measureBus.RLT_multipersonoffice_cold_in)
            annotation (Line(points={{-66,-80},{-70,-80},{-70,-90},{86,-90},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(MultiPersonOffice.hot_out, measureBus.RLT_multipersonoffice_hot_out)
            annotation (Line(points={{-66,-76},{-70,-76},{-70,-90},{86,-90},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(Canteen.cold_out, measureBus.RLT_canteen_cold_out) annotation (Line(
                points={{-10,-84},{-16,-84},{-16,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Canteen.cold_in, measureBus.RLT_canteen_cold_in) annotation (Line(
                points={{-10,-80},{-16,-80},{-16,-82},{-16,-82},{-16,-90},{86,-90},{86,
                  -29.9},{102.1,-29.9}}, color={0,0,127}));
          connect(Canteen.hot_out, measureBus.RLT_canteen_hot_out) annotation (Line(
                points={{-10,-76},{-16,-76},{-16,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Canteen.hot_in, measureBus.RLT_canteen_hot_in) annotation (Line(
                points={{-10,-72},{-16,-72},{-16,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Workshop.cold_out, measureBus.RLT_workshop_cold_out) annotation (Line(
                points={{44,-84},{36,-84},{36,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Workshop.cold_in, measureBus.RLT_workshop_cold_in) annotation (Line(
                points={{44,-80},{36,-80},{36,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Workshop.hot_out, measureBus.RLT_workshop_hot_out) annotation (Line(
                points={{44,-76},{36,-76},{36,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Workshop.hot_in, measureBus.RLT_workshop_hot_in) annotation (Line(
                points={{44,-72},{36,-72},{36,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Canteen.massflow_cold, measureBus.RLT_canteen_cold) annotation (Line(
                points={{8,-66},{8,-58},{28,-58},{28,-90},{86,-90},{86,-29.9},{102.1,
                  -29.9}}, color={0,0,127}));
          connect(Canteen.massflow_hot, measureBus.RLT_canteen_warm) annotation (Line(
                points={{-8,-66},{-8,-58},{28,-58},{28,-90},{86,-90},{86,-29.9},{102.1,
                  -29.9}}, color={0,0,127}));
          connect(Workshop.massflow_cold, measureBus.RLT_workshop_cold) annotation (
              Line(points={{62,-66},{62,-56},{86,-56},{86,-29.9},{102.1,-29.9}}, color=
                  {0,0,127}));
          connect(Workshop.massflow_hot, measureBus.RLT_workshop_warm) annotation (Line(
                points={{46,-66},{46,-56},{86,-56},{86,-29.9},{102.1,-29.9}}, color={0,
                  0,127}));
          connect(Workshop.power_pump_cold, measureBus.Pump_RLT_workshop_cold)
            annotation (Line(points={{58,-66},{58,-56},{86,-56},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Workshop.power_pump_hot, measureBus.Pump_RLT_workshop_warm)
            annotation (Line(points={{50,-66},{50,-56},{86,-56},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Canteen.power_pump_cold, measureBus.Pump_RLT_canteen_cold)
            annotation (Line(points={{4,-66},{4,-58},{28,-58},{28,-90},{86,-90},{86,
                  -29.9},{102.1,-29.9}}, color={0,0,127}));
          connect(Canteen.power_pump_hot, measureBus.Pump_RLT_canteen_warm) annotation (
             Line(points={{-4,-66},{-4,-58},{28,-58},{28,-90},{86,-90},{86,-29.9},{
                  102.1,-29.9}}, color={0,0,127}));
          connect(Central.Air_in, Air_in) annotation (Line(points={{-64,68.6},{-72,68.6},
                  {-72,68},{-72,68},{-72,80},{-40,80},{-40,100}}, color={0,127,255}));
          connect(Central.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{-58,52},
                  {-58,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
          connect(Central.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{-50,
                  52},{-50,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
          connect(Central.Fluid_in_cold, Fluid_in_cold) annotation (Line(points={{-46,
                  52},{-46,-40},{-100,-40}}, color={0,127,255}));
          connect(Central.X_w, controlBus.X_Central) annotation (Line(points={{-54,52},
                  {-54,28.1},{102.1,28.1}}, color={0,0,127}));
          connect(Central.valve_cold, controlBus.Valve_RLT_Cold_Central) annotation (
              Line(points={{-44,54},{-36,54},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
          connect(Central.valve_hot, controlBus.Valve_RLT_Hot_Central) annotation (Line(
                points={{-44,58},{-36,58},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
          connect(Central.pump_cold, controlBus.Pump_RLT_Central_cold_y) annotation (
              Line(points={{-44,62},{-36,62},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
          connect(Central.pump_hot, controlBus.Pump_RLT_Central_hot_y) annotation (Line(
                points={{-44,66},{-36,66},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
          connect(ConferenceRoom.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{52,
                  52},{52,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
          connect(MultiPersonOffice.Fluid_in_hot, Fluid_in_hot) annotation (Line(points=
                 {{-60,-86},{-60,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
          connect(Canteen.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{-4,-86},
                  {-4,-86},{-4,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
          connect(Workshop.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{50,-86},
                  {50,-86},{50,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
          connect(Central.cold_out, measureBus.RLT_central_cold_out) annotation (Line(
                points={{-64,54},{-68,54},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Central.cold_in, measureBus.RLT_central_cold_in) annotation (Line(
                points={{-64,58},{-68,58},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Central.hot_out, measureBus.RLT_central_hot_out) annotation (Line(
                points={{-64,62},{-68,62},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Central.hot_in, measureBus.RLT_central_hot_in) annotation (Line(
                points={{-64,66},{-68,66},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Central.massflow_hot, measureBus.RLT_central_warm) annotation (Line(
                points={{-62,72},{-62,76},{-68,76},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Central.power_pump_hot, measureBus.Pump_RLT_central_warm) annotation (
             Line(points={{-58,72},{-58,76},{-68,76},{-68,28},{86,28},{86,-29.9},{102.1,
                  -29.9}}, color={0,0,127}));
          connect(Central.massflow_cold, measureBus.RLT_central_cold) annotation (Line(
                points={{-46,72},{-46,76},{-68,76},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          connect(Central.power_pump_cold, measureBus.Pump_RLT_central_cold)
            annotation (Line(points={{-50,72},{-50,76},{-68,76},{-68,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(Central.Fluid_out_hot, Fluid_out_hot)
            annotation (Line(points={{-62,52},{-62,40},{-100,40}}, color={0,127,255}));
          connect(OpenPlanOffice.Fluid_out_hot, Fluid_out_hot)
            annotation (Line(points={{-8,52},{-8,40},{-100,40}}, color={0,127,255}));
          connect(OpenPlanOffice.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{
                  -4,52},{-4,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
          connect(OpenPlanOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
                points={{4,52},{4,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
          connect(OpenPlanOffice.Fluid_in_cold, Fluid_in_cold)
            annotation (Line(points={{8,52},{8,-40},{-100,-40}}, color={0,127,255}));
          connect(OpenPlanOffice.valve_cold, controlBus.Valve_RLT_Cold_OpenPlanOffice)
            annotation (Line(points={{10,54},{18,54},{18,28.1},{102.1,28.1}}, color={0,
                  0,127}));
          connect(OpenPlanOffice.valve_hot, controlBus.Valve_RLT_Hot_OpenPlanOffice)
            annotation (Line(points={{10,58},{18,58},{18,28.1},{102.1,28.1}}, color={0,
                  0,127}));
          connect(OpenPlanOffice.pump_cold, controlBus.Pump_RLT_OpenPlanOffice_cold_y)
            annotation (Line(points={{10,62},{18,62},{18,28.1},{102.1,28.1}}, color={0,
                  0,127}));
          connect(OpenPlanOffice.pump_hot, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
            annotation (Line(points={{10,66},{18,66},{18,28.1},{102.1,28.1}}, color={0,
                  0,127}));
          connect(OpenPlanOffice.cold_out, measureBus.RLT_openplanoffice_cold_out)
            annotation (Line(points={{-10,54},{-18,54},{-18,28},{86,28},{86,-29.9},{
                  102.1,-29.9}}, color={0,0,127}));
          connect(OpenPlanOffice.cold_in, measureBus.RLT_openplanoffice_cold_in)
            annotation (Line(points={{-10,58},{-18,58},{-18,28},{86,28},{86,-29.9},{
                  102.1,-29.9}}, color={0,0,127}));
          connect(OpenPlanOffice.hot_out, measureBus.RLT_openplanoffice_hot_out)
            annotation (Line(points={{-10,62},{-18,62},{-18,28},{86,28},{86,-29.9},{
                  102.1,-29.9}}, color={0,0,127}));
          connect(OpenPlanOffice.hot_in, measureBus.RLT_openplanoffice_hot_in)
            annotation (Line(points={{-10,66},{-18,66},{-18,28},{86,28},{86,-29.9},{
                  102.1,-29.9}}, color={0,0,127}));
          connect(OpenPlanOffice.massflow_hot, measureBus.RLT_openplanoffice_warm)
            annotation (Line(points={{-8,72},{-8,76},{-18,76},{-18,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(OpenPlanOffice.massflow_cold, measureBus.RLT_openplanoffice_cold)
            annotation (Line(points={{8,72},{8,76},{-18,76},{-18,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(OpenPlanOffice.power_pump_hot, measureBus.Pump_RLT_openplanoffice_warm)
            annotation (Line(points={{-4,72},{-4,76},{-18,76},{-18,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(OpenPlanOffice.power_pump_cold, measureBus.Pump_RLT_openplanoffice_cold)
            annotation (Line(points={{4,72},{4,76},{-18,76},{-18,28},{86,28},{86,-29.9},
                  {102.1,-29.9}}, color={0,0,127}));
          connect(ConferenceRoom.Air_in, Central.Air_out) annotation (Line(points={{46,
                  68.6},{28,68.6},{28,68},{28,68},{28,80},{-26,80},{-26,68.6},{-44,68.6}},
                color={0,127,255}));
          connect(OpenPlanOffice.Air_in, Central.Air_out) annotation (Line(points={{-10,
                  68.6},{-28,68.6},{-28,68.6},{-44,68.6}}, color={0,127,255}));
          connect(Canteen.Air_in, Central.Air_out) annotation (Line(points={{-10,-69.4},
                  {-26,-69.4},{-26,-70},{-26,-70},{-26,68.6},{-44,68.6}}, color={0,127,
                  255}));
          connect(MultiPersonOffice.Air_in, Central.Air_out) annotation (Line(points={{
                  -66,-69.4},{-70,-69.4},{-70,-44},{-26,-44},{-26,68.6},{-44,68.6}},
                color={0,127,255}));
          connect(Workshop.Air_in, Central.Air_out) annotation (Line(points={{44,-69.4},
                  {40,-69.4},{40,-70},{36,-70},{36,-44},{-26,-44},{-26,68.6},{-44,68.6}},
                color={0,127,255}));
          connect(OpenPlanOffice.Air_out, Air_out[1]) annotation (Line(points={{10,68.6},
                  {16,68.6},{16,70},{16,70},{16,80},{40,80},{40,92}}, color={0,127,255}));
          connect(Central.Airtemp_out, measureBus.Air_RLT_Central_out) annotation (Line(
                points={{-43,71.2},{-36,71.2},{-36,28},{86,28},{86,-29.9},{102.1,-29.9}},
                color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Full_Transfer_RLT_v2;

        model RLT_Central_v2
          replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";
          replaceable package Medium_Air =
            AixLib.Media.Air "Medium in the component";

            parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter_hot = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dpValve_nominal_hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter_cold = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dpValve_nominal_cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_Heatexchanger_AirWater_Hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_Heatexchanger_AirWater_Cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_pipe_air = 0 annotation(Dialog(tab = "General"));

          Fluid.Humidifiers.SprayAirWasher_X hum(
            redeclare package Medium = Medium_Air,
            m_flow_nominal=3.375,
            dp_nominal=1,
            allowFlowReversal=true)
            annotation (Placement(transformation(extent={{50,-76},{70,-56}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{70,90},{90,110}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{30,90},{50,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium
              = Medium_Air)
            "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
            annotation (Placement(transformation(extent={{-110,-76},{-90,-56}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package
              Medium =
                Medium_Air)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,-76},{110,-56}})));
          Modelica.Blocks.Interfaces.RealInput X_w
            "Set point for water vapor mass fraction in kg/kg total air of the fluid that leaves port_b"
            annotation (Placement(transformation(
                extent={{12,-12},{-12,12}},
                rotation=90,
                origin={0,100})));
          Fluid.Actuators.Valves.ThreeWayLinear val1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            use_inputFilter=false,
            dpValve_nominal=dpValve_nominal_hot)
            annotation (Placement(transformation(extent={{-6,-6},{6,6}},
                rotation=-90,
                origin={-40,60})));

          Fluid.MixingVolumes.MixingVolume vol(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            nPorts=4,
            V=V_mixing)
                      annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=90,
                origin={-86,60})));
          Modelica.Blocks.Interfaces.RealInput pump_hot
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{112,-52},{88,-28}})));
          Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium =
                Medium_Water,
            y_start=0,
            redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per)
            annotation (Dialog(enable = true), Placement(transformation(extent={{-8,-8},{8,8}},
                rotation=-90,
                origin={80,0})));
          Modelica.Blocks.Interfaces.RealInput pump_cold
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{112,-12},{88,12}})));
          Fluid.Actuators.Valves.ThreeWayLinear val2(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_cold,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            use_inputFilter=false,
            dpValve_nominal=dpValve_nominal_cold)
            annotation (Placement(transformation(extent={{-6,-6},{6,6}},
                rotation=-90,
                origin={80,80})));

          Modelica.Blocks.Interfaces.RealInput valve_hot
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{112,28},{88,52}})));
          Modelica.Blocks.Interfaces.RealInput valve_cold
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{112,68},{88,92}})));
          Fluid.MixingVolumes.MixingVolume vol1(
            redeclare package Medium = Medium_Water,
            nPorts=4,
            m_flow_nominal=m_flow_nominal_cold,
            V=V_mixing)      annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=90,
                origin={34,80})));
          Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
                Medium_Water,
            use_inputFilter=true,
            y_start=0,
            redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per)
            annotation (Placement(transformation(extent={{-8,-8},{8,8}},
                rotation=-90,
                origin={-40,-20})));
          Fluid.Sensors.Temperature senTem2(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
          Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,-20})));
          Fluid.Sensors.Temperature senTem1(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-60,26},{-40,46}})));
          Fluid.Sensors.Temperature senTem3(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{40,50},{60,70}})));
          Fluid.Sensors.Temperature senTem4(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{60,50},{80,70}})));
          Fluid.Sensors.MassFlowRate senMasFlo1(
                                               redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={40,-14})));
          Modelica.Blocks.Interfaces.RealOutput massflow_hot annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-80,-100})));
          Modelica.Blocks.Interfaces.RealOutput power_pump_hot annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-40,-100})));
          Modelica.Blocks.Interfaces.RealOutput power_pump_cold annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={40,-100})));
          Modelica.Blocks.Interfaces.RealOutput massflow_cold
            "Mass flow rate from port_a to port_b" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={80,-100})));
          Modelica.Blocks.Interfaces.RealOutput cold_out annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,80})));
          Modelica.Blocks.Interfaces.RealOutput cold_in annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,40})));
          Modelica.Blocks.Interfaces.RealOutput hot_out annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,0})));
          Modelica.Blocks.Interfaces.RealOutput hot_in annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,-40})));
          Fluid.MixingVolumes.MixingVolume vol3(
            redeclare package Medium = Medium_Air,
            m_flow_nominal=3.375,
            V=2.8,
            nPorts=2) annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=0,
                origin={-20,-72})));
          Fluid.Sensors.Temperature senTem5(redeclare package Medium = Medium_Air)
            annotation (Placement(transformation(extent={{68,-66},{88,-46}})));
          Modelica.Blocks.Interfaces.RealOutput Airtemp_out
            "Temperature in port medium"
            annotation (Placement(transformation(extent={{100,-102},{120,-82}})));
          Modelica.Fluid.Pipes.DynamicPipe pipe(
            redeclare package Medium = Medium_Water,
            diameter=pipe_diameter_hot,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-40,6})));
          Modelica.Fluid.Pipes.DynamicPipe pipe1(
            redeclare package Medium = Medium_Water,
            diameter=pipe_diameter_hot,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,6})));
          Modelica.Fluid.Pipes.DynamicPipe pipe2(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes,
            diameter=pipe_diameter_cold)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={80,26})));
          Modelica.Fluid.Pipes.DynamicPipe pipe3(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes,
            diameter=pipe_diameter_cold)
                               annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=-90,
                origin={40,20})));
          Fluid.MixingVolumes.MixingVolume vol4(
            nPorts=2,
            redeclare package Medium = Medium_Air,
            m_flow_nominal=3.375,
            V=2.8)    annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=0,
                origin={32,-60})));
          Fluid.FixedResistances.PressureDrop res(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            dp_nominal(displayUnit="bar") = 20000)
            annotation (Placement(transformation(extent={{-64,-40},{-74,-30}})));
          Fluid.MixingVolumes.MixingVolume vol6(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            V=0.01,
            nPorts=2)
                   annotation (Placement(transformation(extent={{-56,-38},{-46,-48}})));
          Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(
            surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
            Model=1,
            A=Area_Heatexchanger_AirWater_Hot)                                                                                                                                                      annotation(Placement(transformation(extent={{-5.5,-6},
                    {5.5,6}},
                rotation=90,
                origin={-66.5,-50})));
          Fluid.MixingVolumes.MixingVolume vol7(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_cold,
            V=0.01,
            nPorts=2)
                   annotation (Placement(transformation(extent={{28,-38},{38,-48}})));
          Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside1(
            surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
            Model=1,
            A=Area_Heatexchanger_AirWater_Cold)                                                                                                                                                     annotation(Placement(transformation(extent={{-5.5,-6},
                    {5.5,6}},
                rotation=90,
                origin={19.5,-50})));
          Fluid.FixedResistances.PressureDrop res1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_cold,
            dp_nominal(displayUnit="bar") = 20000)
            annotation (Placement(transformation(extent={{24,-34},{34,-24}})));
          Modelica.Blocks.Math.Gain gain(k=1/(1.2041*Area_pipe_air))
            annotation (Placement(transformation(extent={{-4,-4},{4,4}},
                rotation=90,
                origin={0,-48})));
          Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium = Medium_Air)
            annotation (Placement(transformation(extent={{-10,-76},{10,-56}})));
          Fluid.MixingVolumes.MixingVolume vol8(
            nPorts=2,
            redeclare package Medium = Medium_Air,
            m_flow_nominal=3.375,
            V=2.8)    annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=0,
                origin={-52,-60})));
        equation
          connect(hum.X_w, X_w) annotation (Line(points={{48,-60},{40,-60},{40,-40},{0,
                  -40},{0,100}}, color={0,0,127}));
          connect(val1.port_3, vol.ports[1]) annotation (Line(points={{-46,60},{-64,60},
                  {-64,58.2},{-80,58.2}},
                                      color={0,127,255}));
          connect(Fluid_out_hot, vol.ports[2])
            annotation (Line(points={{-80,100},{-80,59.4}}, color={0,127,255}));
          connect(Fluid_in_hot, val1.port_1)
            annotation (Line(points={{-40,100},{-40,66}}, color={0,127,255}));
          connect(fan1.y, pump_cold)
            annotation (Line(points={{89.6,0},{100,0}}, color={0,0,127}));
          connect(val1.y, valve_hot) annotation (Line(points={{-32.8,60},{20,60},{20,40},
                  {100,40}}, color={0,0,127}));
          connect(val2.y, valve_cold)
            annotation (Line(points={{87.2,80},{100,80}}, color={0,0,127}));
          connect(val2.port_3, vol1.ports[1]) annotation (Line(points={{74,80},{58,80},{
                  58,78.2},{40,78.2}},
                                   color={0,127,255}));
          connect(Fluid_out_cold, vol1.ports[2])
            annotation (Line(points={{40,100},{40,79.4},{40,79.4}},color={0,127,255}));
          connect(Fluid_in_cold, val2.port_1)
            annotation (Line(points={{80,100},{80,86},{80,86}}, color={0,127,255}));
          connect(fan2.y, pump_hot) annotation (Line(points={{-30.4,-20},{-20,-20},{-20,
                  -40},{100,-40}}, color={0,0,127}));
          connect(senTem2.port, vol.ports[3]) annotation (Line(points={{-72,26},{-80,26},
                  {-80,60.6}}, color={0,127,255}));
          connect(senTem3.port, vol1.ports[3])
            annotation (Line(points={{50,50},{40,50},{40,80.6}}, color={0,127,255}));
          connect(senTem4.port, val2.port_2)
            annotation (Line(points={{70,50},{80,50},{80,74}}, color={0,127,255}));
          connect(senMasFlo.m_flow, massflow_hot) annotation (Line(points={{-91,-20},{-114,
                  -20},{-114,-80},{-80,-80},{-80,-100}},      color={0,0,127}));
          connect(fan2.P, power_pump_hot) annotation (Line(points={{-32.8,-28.8},{-32.8,
                  -80},{-40,-80},{-40,-100}}, color={0,0,127}));
          connect(fan1.P, power_pump_cold) annotation (Line(points={{87.2,-8.8},{87.2,
                  -40},{40,-40},{40,-100}}, color={0,0,127}));
          connect(senMasFlo1.m_flow, massflow_cold) annotation (Line(points={{29,-14},{
                  20,-14},{20,-40},{40,-40},{40,-80},{80,-80},{80,-100}}, color={0,0,
                  127}));
          connect(senTem1.T, hot_in) annotation (Line(points={{-43,36},{-20,36},{-20,
                  -40},{-100,-40}}, color={0,0,127}));
          connect(senTem2.T, hot_out) annotation (Line(points={{-65,36},{-60,36},{-60,0},
                  {-100,0}}, color={0,0,127}));
          connect(senTem3.T, cold_out) annotation (Line(points={{57,60},{60,60},{60,40},
                  {20,40},{20,80},{-100,80}}, color={0,0,127}));
          connect(senTem4.T, cold_in) annotation (Line(points={{77,60},{78,60},{78,40},
                  {-100,40}}, color={0,0,127}));
          connect(senTem5.T, Airtemp_out) annotation (Line(points={{85,-56},{92,-56},{92,
                  -92},{110,-92}}, color={0,0,127}));
          connect(val1.port_2, pipe.port_a)
            annotation (Line(points={{-40,54},{-40,16}}, color={0,127,255}));
          connect(pipe.port_b, fan2.port_a)
            annotation (Line(points={{-40,-4},{-40,-12}}, color={0,127,255}));
          connect(senTem1.port, pipe.port_a)
            annotation (Line(points={{-50,26},{-40,26},{-40,16}}, color={0,127,255}));
          connect(senMasFlo.port_b, pipe1.port_a)
            annotation (Line(points={{-80,-10},{-80,-4}}, color={0,127,255}));
          connect(pipe1.port_b, vol.ports[4])
            annotation (Line(points={{-80,16},{-80,61.8}}, color={0,127,255}));
          connect(pipe2.port_a, val2.port_2)
            annotation (Line(points={{80,36},{80,74}}, color={0,127,255}));
          connect(pipe2.port_b, fan1.port_a)
            annotation (Line(points={{80,16},{80,8}}, color={0,127,255}));
          connect(senMasFlo1.port_b, pipe3.port_a)
            annotation (Line(points={{40,-4},{40,10}}, color={0,127,255}));
          connect(pipe3.port_b, vol1.ports[4])
            annotation (Line(points={{40,30},{40,81.8}}, color={0,127,255}));
          connect(vol4.ports[1], hum.port_a)
            annotation (Line(points={{30.8,-66},{50,-66}}, color={0,127,255}));
          connect(senTem5.port, Air_out)
            annotation (Line(points={{78,-66},{100,-66}}, color={0,127,255}));
          connect(senMasFlo2.m_flow, gain.u)
            annotation (Line(points={{0,-55},{0,-52.8}}, color={0,0,127}));
          connect(res.port_a, vol6.ports[1]) annotation (Line(points={{-64,-35},{-58,
                  -35},{-58,-38},{-52,-38}},
                                        color={0,127,255}));
          connect(res.port_b, senMasFlo.port_a) annotation (Line(points={{-74,-35},{-78,
                  -35},{-80,-35},{-80,-34},{-80,-30},{-80,-30}}, color={0,127,255}));
          connect(res1.port_b, senMasFlo1.port_a) annotation (Line(points={{34,-29},{40,
                  -29},{40,-28},{40,-28},{40,-24}}, color={0,127,255}));
          connect(res1.port_a, vol7.ports[1]) annotation (Line(points={{24,-29},{16,-29},
                  {16,-30},{16,-30},{16,-38},{32,-38}}, color={0,127,255}));
          connect(vol7.ports[2], fan1.port_b) annotation (Line(points={{34,-38},{80,-38},
                  {80,-8},{80,-8}}, color={0,127,255}));
          connect(heatTransfer_Outside1.port_b, vol7.heatPort) annotation (Line(points={
                  {19.5,-44.5},{20,-44.5},{20,-43},{28,-43}}, color={191,0,0}));
          connect(heatTransfer_Outside1.port_a, vol4.heatPort) annotation (Line(points={
                  {19.5,-55.5},{19.5,-60},{26,-60}}, color={191,0,0}));
          connect(gain.y, heatTransfer_Outside1.WindSpeedPort) annotation (Line(points={{0,-43.6},
                  {0,-40},{14,-40},{14,-76},{23.82,-76},{23.82,-55.06}},
                color={0,0,127}));
          connect(senMasFlo2.port_b, vol4.ports[2])
            annotation (Line(points={{10,-66},{33.2,-66}}, color={0,127,255}));
          connect(senMasFlo2.port_a, vol3.ports[1])
            annotation (Line(points={{-10,-66},{-21.2,-66}}, color={0,127,255}));
          connect(vol3.ports[2], vol8.ports[1])
            annotation (Line(points={{-18.8,-66},{-53.2,-66}}, color={0,127,255}));
          connect(vol8.ports[2], Air_in)
            annotation (Line(points={{-50.8,-66},{-100,-66}}, color={0,127,255}));
          connect(hum.port_b, senTem5.port)
            annotation (Line(points={{70,-66},{78,-66}}, color={0,127,255}));
          connect(heatTransfer_Outside.port_a, vol8.heatPort) annotation (Line(points={{
                  -66.5,-55.5},{-66.5,-60},{-58,-60}}, color={191,0,0}));
          connect(heatTransfer_Outside.port_b, vol6.heatPort) annotation (Line(points={{
                  -66.5,-44.5},{-66.5,-43},{-56,-43}}, color={191,0,0}));
          connect(heatTransfer_Outside.WindSpeedPort, gain.y) annotation (Line(points={{-62.18,
                  -55.06},{-62.18,-72},{-32,-72},{-32,-40},{0,-40},{0,-43.6}},
                color={0,0,127}));
          connect(vol6.ports[2], fan2.port_b) annotation (Line(points={{-50,-38},{-44,
                  -38},{-44,-38},{-40,-38},{-40,-28}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end RLT_Central_v2;

        model RLT_v2
          replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";
          replaceable package Medium_Air =
            AixLib.Media.Air "Medium in the component";

            parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter_hot = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dpValve_nominal_hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter_cold = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dpValve_nominal_cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length_air = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter_air = 0 annotation(Dialog(tab = "General"));
            parameter Real RLT_m_flow_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure RLT_dp_Heatexchanger = 0 annotation(Dialog(tab = "RLT"));
            parameter Modelica.SIunits.Time RLT_tau = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Volume V_air = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_Heatexchanger_AirWater_Hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_Heatexchanger_AirWater_Cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_pipe_air = 0 annotation(Dialog(tab = "General"));

          Fluid.Actuators.Valves.ThreeWayLinear val1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            use_inputFilter=false,
            dpValve_nominal=dpValve_nominal_hot)
            annotation (Placement(transformation(extent={{-6,-6},{6,6}},
                rotation=-90,
                origin={-40,60})));
          Fluid.MixingVolumes.MixingVolume vol(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            nPorts=4,
            V=V_mixing)
                      annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=90,
                origin={-86,60})));
          Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium =
                Medium_Water,
            y_start=0,
            redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per)
            annotation (Placement(transformation(extent={{-8,-8},{8,8}},
                rotation=-90,
                origin={80,0})));
          Fluid.Actuators.Valves.ThreeWayLinear val2(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_cold,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            use_inputFilter=false,
            dpValve_nominal=dpValve_nominal_cold)
            annotation (Placement(transformation(extent={{-6,-6},{6,6}},
                rotation=-90,
                origin={80,80})));
          Fluid.MixingVolumes.MixingVolume vol1(
            redeclare package Medium = Medium_Water,
            nPorts=4,
            m_flow_nominal=m_flow_nominal_cold,
            V=V_mixing)      annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=90,
                origin={34,80})));
          Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
                Medium_Water,
              redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
            y_start=0)
            annotation (Placement(transformation(extent={{-8,-8},{8,8}},
                rotation=-90,
                origin={-40,-20})));
          Fluid.Sensors.Temperature senTem2(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
          Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,-20})));
          Fluid.Sensors.Temperature senTem1(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-60,26},{-40,46}})));
          Fluid.Sensors.Temperature senTem3(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{40,50},{60,70}})));
          Fluid.Sensors.Temperature senTem4(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{60,50},{80,70}})));
          Fluid.Sensors.MassFlowRate senMasFlo1(
                                               redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={40,-14})));
          Fluid.MixingVolumes.MixingVolume vol3(
            redeclare package Medium = Medium_Air,
            V=V_air,
            nPorts=2,
            m_flow_nominal=100)
                      annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=0,
                origin={-16,-72})));
          Modelica.Fluid.Pipes.DynamicPipe pipe1(
            redeclare package Medium = Medium_Water,
            diameter=pipe_diameter_hot,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,4})));
          Modelica.Fluid.Pipes.DynamicPipe pipe(
            redeclare package Medium = Medium_Water,
            diameter=pipe_diameter_hot,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-40,6})));
          Modelica.Fluid.Pipes.DynamicPipe pipe3(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes,
            diameter=pipe_diameter_cold)
                               annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=-90,
                origin={40,20})));
          Modelica.Fluid.Pipes.DynamicPipe pipe2(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes,
            diameter=pipe_diameter_cold)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={80,26})));
          Fluid.Delays.DelayFirstOrder del(
            redeclare package Medium = Medium_Air,
            m_flow_nominal=RLT_m_flow_nominal,
            nPorts=2,
            tau=RLT_tau)
            annotation (Placement(transformation(extent={{-86,-66},{-74,-78}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{70,90},{90,110}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{30,90},{50,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium
              = Medium_Air)
            "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
            annotation (Placement(transformation(extent={{-110,-76},{-90,-56}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package
              Medium =
                Medium_Air)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,-76},{110,-56}})));
          Modelica.Blocks.Interfaces.RealInput pump_hot
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{112,-52},{88,-28}})));
          Modelica.Blocks.Interfaces.RealInput pump_cold
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{112,-12},{88,12}})));
          Modelica.Blocks.Interfaces.RealInput valve_hot
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{112,28},{88,52}})));
          Modelica.Blocks.Interfaces.RealInput valve_cold
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{112,68},{88,92}})));
          Modelica.Blocks.Interfaces.RealOutput massflow_hot annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-80,-100})));
          Modelica.Blocks.Interfaces.RealOutput power_pump_hot annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-40,-100})));
          Modelica.Blocks.Interfaces.RealOutput power_pump_cold annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={40,-100})));
          Modelica.Blocks.Interfaces.RealOutput massflow_cold
            "Mass flow rate from port_a to port_b" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={80,-100})));
          Modelica.Blocks.Interfaces.RealOutput cold_out annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,80})));
          Modelica.Blocks.Interfaces.RealOutput cold_in annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,40})));
          Modelica.Blocks.Interfaces.RealOutput hot_out annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,0})));
          Modelica.Blocks.Interfaces.RealOutput hot_in annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,-40})));
          Fluid.MixingVolumes.MixingVolume vol6(
            redeclare package Medium = Medium_Water,
            nPorts=2,
            m_flow_nominal=m_flow_nominal_cold,
            V=0.01)
                   annotation (Placement(transformation(extent={{46,-42},{56,-52}})));
          Fluid.MixingVolumes.MixingVolume vol5(
            redeclare package Medium = Medium_Air,
            V=V_air,
            nPorts=2,
            m_flow_nominal=100)
                      annotation (Placement(transformation(
                extent={{-5,-5},{5,5}},
                rotation=0,
                origin={51,-61})));
          Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium = Medium_Air)
            annotation (Placement(transformation(extent={{62,-76},{82,-56}})));
          Modelica.Blocks.Math.Gain gain(k=1/(1.2041*Area_pipe_air))
            annotation (Placement(transformation(extent={{-4,-4},{4,4}},
                rotation=90,
                origin={72,-48})));
          Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside1(
            surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
            Model=1,
            A=Area_Heatexchanger_AirWater_Cold)                                                                                                                                                     annotation(Placement(transformation(extent={{-5.5,-6},
                    {5.5,6}},
                rotation=90,
                origin={33.5,-54})));
          Fluid.FixedResistances.PressureDrop res1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_cold,
            dp_nominal(displayUnit="bar") = 20000)
            annotation (Placement(transformation(extent={{36,-40},{26,-30}})));
          Fluid.FixedResistances.PressureDrop res(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            dp_nominal(displayUnit="bar") = 20000)
            annotation (Placement(transformation(extent={{-68,-40},{-78,-30}})));
          Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(
            surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
            Model=1,
            A=Area_Heatexchanger_AirWater_Hot)                                                                                                                                                      annotation(Placement(transformation(extent={{-5.5,-6},
                    {5.5,6}},
                rotation=90,
                origin={-72.5,-54})));
          Fluid.MixingVolumes.MixingVolume vol2(
            redeclare package Medium = Medium_Water,
            nPorts=2,
            m_flow_nominal=m_flow_nominal_hot,
            V=0.01)
                   annotation (Placement(transformation(extent={{-62,-42},{-52,-52}})));
          Fluid.MixingVolumes.MixingVolume vol4(
            redeclare package Medium = Medium_Air,
            V=V_air,
            nPorts=2,
            m_flow_nominal=100)
                      annotation (Placement(transformation(
                extent={{-5,-5},{5,5}},
                rotation=0,
                origin={-57,-61})));
          Fluid.FixedResistances.PressureDrop res2(
            redeclare package Medium = Medium_Air,
            m_flow_nominal=RLT_m_flow_nominal,
            dp_nominal(displayUnit="bar") = RLT_dp_Heatexchanger*2,
            allowFlowReversal=false)
            annotation (Placement(transformation(extent={{-46,-72},{-34,-60}})));
        equation
          connect(val1.port_3,vol. ports[1]) annotation (Line(points={{-46,60},{-64,60},
                  {-64,58.2},{-80,58.2}},
                                      color={0,127,255}));
          connect(Fluid_out_hot,vol. ports[2])
            annotation (Line(points={{-80,100},{-80,59.4}}, color={0,127,255}));
          connect(Fluid_in_hot,val1. port_1)
            annotation (Line(points={{-40,100},{-40,66}}, color={0,127,255}));
          connect(fan1.y,pump_cold)
            annotation (Line(points={{89.6,0},{100,0}}, color={0,0,127}));
          connect(val1.y,valve_hot)  annotation (Line(points={{-32.8,60},{20,60},{20,40},
                  {100,40}}, color={0,0,127}));
          connect(val2.y,valve_cold)
            annotation (Line(points={{87.2,80},{100,80}}, color={0,0,127}));
          connect(val2.port_3,vol1. ports[1]) annotation (Line(points={{74,80},{58,80},{
                  58,78.2},{40,78.2}},
                                   color={0,127,255}));
          connect(Fluid_out_cold,vol1. ports[2])
            annotation (Line(points={{40,100},{40,79.4},{40,79.4}},color={0,127,255}));
          connect(Fluid_in_cold,val2. port_1)
            annotation (Line(points={{80,100},{80,86},{80,86}}, color={0,127,255}));
          connect(fan2.y,pump_hot)  annotation (Line(points={{-30.4,-20},{-20,-20},{-20,
                  -40},{100,-40}}, color={0,0,127}));
          connect(senTem2.port,vol. ports[3]) annotation (Line(points={{-72,26},{-80,26},
                  {-80,60.6}}, color={0,127,255}));
          connect(senTem3.port,vol1. ports[3])
            annotation (Line(points={{50,50},{40,50},{40,80.6}}, color={0,127,255}));
          connect(senTem4.port,val2. port_2)
            annotation (Line(points={{70,50},{80,50},{80,74}}, color={0,127,255}));
          connect(senMasFlo.m_flow,massflow_hot)  annotation (Line(points={{-91,-20},{
                  -114,-20},{-114,-80},{-80,-80},{-80,-100}}, color={0,0,127}));
          connect(fan2.P,power_pump_hot)  annotation (Line(points={{-32.8,-28.8},{-32.8,
                  -80},{-40,-80},{-40,-100}}, color={0,0,127}));
          connect(fan1.P,power_pump_cold)  annotation (Line(points={{87.2,-8.8},{87.2,
                  -40},{40,-40},{40,-100}}, color={0,0,127}));
          connect(senMasFlo1.m_flow,massflow_cold)  annotation (Line(points={{29,-14},{
                  20,-14},{20,-40},{40,-40},{40,-80},{80,-80},{80,-100}}, color={0,0,
                  127}));
          connect(senTem1.T,hot_in)  annotation (Line(points={{-43,36},{-20,36},{-20,
                  -40},{-100,-40}}, color={0,0,127}));
          connect(senTem2.T,hot_out)  annotation (Line(points={{-65,36},{-60,36},{-60,0},
                  {-100,0}}, color={0,0,127}));
          connect(senTem3.T,cold_out)  annotation (Line(points={{57,60},{60,60},{60,40},
                  {20,40},{20,80},{-100,80}}, color={0,0,127}));
          connect(senTem4.T,cold_in)  annotation (Line(points={{77,60},{78,60},{78,40},
                  {-100,40}}, color={0,0,127}));
          connect(pipe1.port_b,vol. ports[4])
            annotation (Line(points={{-80,14},{-80,61.8}}, color={0,127,255}));
          connect(pipe1.port_a,senMasFlo. port_b)
            annotation (Line(points={{-80,-6},{-80,-10}}, color={0,127,255}));
          connect(pipe.port_a,val1. port_2)
            annotation (Line(points={{-40,16},{-40,54}}, color={0,127,255}));
          connect(senTem1.port,val1. port_2) annotation (Line(points={{-50,26},{-46,26},
                  {-46,28},{-40,28},{-40,54}}, color={0,127,255}));
          connect(pipe.port_b,fan2. port_a) annotation (Line(points={{-40,-4},{-40,-12},
                  {-40,-12}}, color={0,127,255}));
          connect(pipe3.port_b,vol1. ports[4])
            annotation (Line(points={{40,30},{40,81.8}}, color={0,127,255}));
          connect(pipe3.port_a,senMasFlo1. port_b)
            annotation (Line(points={{40,10},{40,-4}}, color={0,127,255}));
          connect(pipe2.port_b,fan1. port_a)
            annotation (Line(points={{80,16},{80,8}}, color={0,127,255}));
          connect(pipe2.port_a,val2. port_2)
            annotation (Line(points={{80,36},{80,74}}, color={0,127,255}));
          connect(Air_in,del. ports[1])
            annotation (Line(points={{-100,-66},{-81.2,-66}}, color={0,127,255}));
          connect(vol6.ports[1], fan1.port_b)
            annotation (Line(points={{50,-42},{80,-42},{80,-8}}, color={0,127,255}));
          connect(vol3.ports[1], vol5.ports[1])
            annotation (Line(points={{-17.2,-66},{50,-66}}, color={0,127,255}));
          connect(res1.port_a, vol6.ports[2]) annotation (Line(points={{36,-35},{52,-35},
                  {52,-36},{52,-36},{52,-42}}, color={0,127,255}));
          connect(res1.port_b, senMasFlo1.port_a) annotation (Line(points={{26,-35},{26,
                  -34},{26,-34},{26,-24},{40,-24}}, color={0,127,255}));
          connect(heatTransfer_Outside1.port_b, vol6.heatPort) annotation (Line(points=
                  {{33.5,-48.5},{33.5,-47},{46,-47}}, color={191,0,0}));
          connect(heatTransfer_Outside1.port_a, vol5.heatPort) annotation (Line(points=
                  {{33.5,-59.5},{33.5,-61},{46,-61}}, color={191,0,0}));
          connect(senMasFlo2.m_flow, gain.u)
            annotation (Line(points={{72,-55},{72,-52.8}}, color={0,0,127}));
          connect(gain.y, heatTransfer_Outside1.WindSpeedPort) annotation (Line(points=
                  {{72,-43.6},{72,-40},{0,-40},{0,-80},{37.82,-80},{37.82,-59.06}},
                color={0,0,127}));
          connect(vol5.ports[2], senMasFlo2.port_a)
            annotation (Line(points={{52,-66},{62,-66}}, color={0,127,255}));
          connect(senMasFlo2.port_b, Air_out)
            annotation (Line(points={{82,-66},{100,-66}}, color={0,127,255}));
          connect(senMasFlo.port_a, res.port_b) annotation (Line(points={{-80,-30},{-80,
                  -35},{-78,-35}}, color={0,127,255}));
          connect(del.ports[2], vol4.ports[1])
            annotation (Line(points={{-78.8,-66},{-58,-66}}, color={0,127,255}));
          connect(vol4.heatPort, heatTransfer_Outside.port_a) annotation (Line(points={
                  {-62,-61},{-60,-61},{-60,-59.5},{-72.5,-59.5}}, color={191,0,0}));
          connect(heatTransfer_Outside.port_b, vol2.heatPort) annotation (Line(points={
                  {-72.5,-48.5},{-60,-48.5},{-60,-47},{-62,-47}}, color={191,0,0}));
          connect(heatTransfer_Outside.WindSpeedPort, heatTransfer_Outside1.WindSpeedPort)
            annotation (Line(points={{-68.18,-59.06},{-68.18,-80},{37.82,-80},{37.82,
                  -59.06}}, color={0,0,127}));
          connect(res.port_a, vol2.ports[1]) annotation (Line(points={{-68,-35},{-60,
                  -35},{-60,-36},{-58,-36},{-58,-42}}, color={0,127,255}));
          connect(vol2.ports[2], fan2.port_b) annotation (Line(points={{-56,-42},{-40,
                  -42},{-40,-28}}, color={0,127,255}));
          connect(vol4.ports[2], res2.port_a)
            annotation (Line(points={{-56,-66},{-46,-66}}, color={0,127,255}));
          connect(res2.port_b, vol3.ports[2])
            annotation (Line(points={{-34,-66},{-14.8,-66}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end RLT_v2;

        model RLT_OpenPlanOffice_v2
          replaceable package Medium_Water =
            AixLib.Media.Water "Medium in the component";
          replaceable package Medium_Air =
            AixLib.Media.Air "Medium in the component";

            parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter_hot = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dpValve_nominal_hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter_cold = 0 annotation(Dialog(tab = "General"));
            parameter Real m_flow_nominal_cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure dpValve_nominal_cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_length_air = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Length pipe_diameter_air = 0 annotation(Dialog(tab = "General"));
            parameter Real RLT_m_flow_nominal = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Pressure RLT_dp_Heatexchanger = 0 annotation(Dialog(tab = "RLT"));
            parameter Modelica.SIunits.Time RLT_tau = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_Heatexchanger_AirWater_Hot = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_Heatexchanger_AirWater_Cold = 0 annotation(Dialog(tab = "General"));
            parameter Modelica.SIunits.Area Area_pipe_air = 0 annotation(Dialog(tab = "General"));

          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{70,90},{90,110}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare
              package Medium =
                Medium_Water)
            "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{30,90},{50,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package
              Medium =
                Medium_Water)
            "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
            annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium
              = Medium_Air)
            "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
            annotation (Placement(transformation(extent={{-110,-76},{-90,-56}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package
              Medium =
                Medium_Air)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,-76},{110,-56}})));
          Fluid.Actuators.Valves.ThreeWayLinear val1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            use_inputFilter=false,
            dpValve_nominal=dpValve_nominal_hot)
            annotation (Placement(transformation(extent={{-6,-6},{6,6}},
                rotation=-90,
                origin={-40,60})));

          Fluid.MixingVolumes.MixingVolume vol(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            nPorts=4,
            V=V_mixing)
                      annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=90,
                origin={-86,60})));
          Modelica.Blocks.Interfaces.RealInput pump_hot
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{112,-52},{88,-28}})));
          Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium =
                Medium_Water,
            y_start=0,
            redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)
            annotation (Placement(transformation(extent={{-8,-8},{8,8}},
                rotation=-90,
                origin={80,0})));
          Modelica.Blocks.Interfaces.RealInput pump_cold
            "Constant normalized rotational speed"
            annotation (Placement(transformation(extent={{112,-12},{88,12}})));
          Fluid.Actuators.Valves.ThreeWayLinear val2(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_cold,
            CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
            use_inputFilter=false,
            dpValve_nominal=dpValve_nominal_cold)
            annotation (Placement(transformation(extent={{-6,-6},{6,6}},
                rotation=-90,
                origin={80,80})));

          Modelica.Blocks.Interfaces.RealInput valve_hot
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{112,28},{88,52}})));
          Modelica.Blocks.Interfaces.RealInput valve_cold
            "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{112,68},{88,92}})));
          Fluid.MixingVolumes.MixingVolume vol1(
            redeclare package Medium = Medium_Water,
            nPorts=4,
            m_flow_nominal=m_flow_nominal_cold,
            V=V_mixing)      annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=90,
                origin={34,80})));
          Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
                Medium_Water,
            y_start=0,
            redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per)
            annotation (Placement(transformation(extent={{-8,-8},{8,8}},
                rotation=-90,
                origin={-40,-20})));
          Fluid.Sensors.Temperature senTem2(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
          Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,-20})));
          Fluid.Sensors.Temperature senTem1(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-60,26},{-40,46}})));
          Fluid.Sensors.Temperature senTem3(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{40,50},{60,70}})));
          Fluid.Sensors.Temperature senTem4(redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{60,50},{80,70}})));
          Fluid.Sensors.MassFlowRate senMasFlo1(
                                               redeclare package Medium =
                Medium_Water)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={40,-14})));
          Modelica.Blocks.Interfaces.RealOutput massflow_hot annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-80,-100})));
          Modelica.Blocks.Interfaces.RealOutput power_pump_hot annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-40,-100})));
          Modelica.Blocks.Interfaces.RealOutput power_pump_cold annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={40,-100})));
          Modelica.Blocks.Interfaces.RealOutput massflow_cold
            "Mass flow rate from port_a to port_b" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={80,-100})));
          Modelica.Blocks.Interfaces.RealOutput cold_out annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,80})));
          Modelica.Blocks.Interfaces.RealOutput cold_in annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,40})));
          Modelica.Blocks.Interfaces.RealOutput hot_out annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,0})));
          Modelica.Blocks.Interfaces.RealOutput hot_in annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-100,-40})));
          Fluid.MixingVolumes.MixingVolume vol3(
            nPorts=2,
            redeclare package Medium = Medium_Air,
            m_flow_nominal=RLT_m_flow_nominal,
            V=1)      annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=0,
                origin={-6,-72})));
          Modelica.Fluid.Pipes.DynamicPipe pipe1(
            redeclare package Medium = Medium_Water,
            diameter=pipe_diameter_hot,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,4})));
          Modelica.Fluid.Pipes.DynamicPipe pipe(
            redeclare package Medium = Medium_Water,
            diameter=pipe_diameter_hot,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-40,6})));
          Modelica.Fluid.Pipes.DynamicPipe pipe3(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes,
            diameter=pipe_diameter_cold)
                               annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=-90,
                origin={40,20})));
          Modelica.Fluid.Pipes.DynamicPipe pipe2(
            redeclare package Medium = Medium_Water,
            height_ab=pipe_height,
            length=pipe_length,
            nNodes=pipe_nodes,
            diameter=pipe_diameter_cold)
                               annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={80,26})));
          Fluid.Delays.DelayFirstOrder del(
            redeclare package Medium = Medium_Air,
            m_flow_nominal=RLT_m_flow_nominal,
            nPorts=2,
            tau=RLT_tau)
            annotation (Placement(transformation(extent={{-86,-66},{-74,-78}})));
          Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(
            surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
            Model=1,
            A=Area_Heatexchanger_AirWater_Hot)                                                                                                                                                      annotation(Placement(transformation(extent={{-5.5,-6},
                    {5.5,6}},
                rotation=90,
                origin={-60.5,-54})));
          Fluid.FixedResistances.PressureDrop res(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_hot,
            dp_nominal(displayUnit="bar") = 20000)
            annotation (Placement(transformation(extent={{-64,-40},{-74,-30}})));
          Fluid.MixingVolumes.MixingVolume vol2(
            redeclare package Medium = Medium_Water,
            nPorts=2,
            m_flow_nominal=m_flow_nominal_hot,
            V=0.01)
                   annotation (Placement(transformation(extent={{-50,-42},{-40,-52}})));
          Fluid.MixingVolumes.MixingVolume vol4(
            nPorts=2,
            redeclare package Medium = Medium_Air,
            V=1,
            m_flow_nominal=RLT_m_flow_nominal)
                   annotation (Placement(transformation(extent={{-50,-66},{-40,-56}})));
          Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium = Medium_Air)
            annotation (Placement(transformation(extent={{62,-76},{82,-56}})));
          Modelica.Blocks.Math.Gain gain(k=1/(1.2041*Area_pipe_air))
            annotation (Placement(transformation(extent={{-4,-4},{4,4}},
                rotation=90,
                origin={72,-48})));
          Fluid.MixingVolumes.MixingVolume vol5(
            nPorts=2,
            redeclare package Medium = Medium_Air,
            V=1,
            m_flow_nominal=RLT_m_flow_nominal)
                   annotation (Placement(transformation(extent={{46,-66},{56,-56}})));
          Fluid.MixingVolumes.MixingVolume vol6(
            redeclare package Medium = Medium_Water,
            nPorts=2,
            m_flow_nominal=m_flow_nominal_cold,
            V=0.01)
                   annotation (Placement(transformation(extent={{46,-42},{56,-52}})));
          Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside1(
            surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
            Model=1,
            A=Area_Heatexchanger_AirWater_Cold)                                                                                                                                                     annotation(Placement(transformation(extent={{-5.5,-6},
                    {5.5,6}},
                rotation=90,
                origin={33.5,-54})));
          Fluid.FixedResistances.PressureDrop res1(
            redeclare package Medium = Medium_Water,
            m_flow_nominal=m_flow_nominal_cold,
            dp_nominal(displayUnit="bar") = 20000)
            annotation (Placement(transformation(extent={{36,-40},{26,-30}})));
          Fluid.FixedResistances.PressureDrop res2(
            redeclare package Medium = Medium_Air,
            m_flow_nominal=RLT_m_flow_nominal,
            dp_nominal(displayUnit="bar") = RLT_dp_Heatexchanger*2,
            allowFlowReversal=false)
            annotation (Placement(transformation(extent={{12,-72},{24,-60}})));
        equation
          connect(val1.port_3, vol.ports[1]) annotation (Line(points={{-46,60},{-64,60},
                  {-64,58.2},{-80,58.2}},
                                      color={0,127,255}));
          connect(Fluid_out_hot, vol.ports[2])
            annotation (Line(points={{-80,100},{-80,59.4}}, color={0,127,255}));
          connect(Fluid_in_hot, val1.port_1)
            annotation (Line(points={{-40,100},{-40,66}}, color={0,127,255}));
          connect(fan1.y, pump_cold)
            annotation (Line(points={{89.6,0},{100,0}}, color={0,0,127}));
          connect(val1.y, valve_hot) annotation (Line(points={{-32.8,60},{20,60},{20,40},
                  {100,40}}, color={0,0,127}));
          connect(val2.y, valve_cold)
            annotation (Line(points={{87.2,80},{100,80}}, color={0,0,127}));
          connect(val2.port_3, vol1.ports[1]) annotation (Line(points={{74,80},{58,80},{
                  58,78.2},{40,78.2}},
                                   color={0,127,255}));
          connect(Fluid_out_cold, vol1.ports[2])
            annotation (Line(points={{40,100},{40,79.4},{40,79.4}},color={0,127,255}));
          connect(Fluid_in_cold, val2.port_1)
            annotation (Line(points={{80,100},{80,86},{80,86}}, color={0,127,255}));
          connect(fan2.y, pump_hot) annotation (Line(points={{-30.4,-20},{-20,-20},{-20,
                  -40},{100,-40}}, color={0,0,127}));
          connect(senTem2.port, vol.ports[3]) annotation (Line(points={{-72,26},{-80,26},
                  {-80,60.6}}, color={0,127,255}));
          connect(senTem3.port, vol1.ports[3])
            annotation (Line(points={{50,50},{40,50},{40,80.6}}, color={0,127,255}));
          connect(senTem4.port, val2.port_2)
            annotation (Line(points={{70,50},{80,50},{80,74}}, color={0,127,255}));
          connect(senMasFlo.m_flow, massflow_hot) annotation (Line(points={{-91,-20},{-114,
                  -20},{-114,-80},{-80,-80},{-80,-100}},      color={0,0,127}));
          connect(fan2.P, power_pump_hot) annotation (Line(points={{-32.8,-28.8},{-32.8,
                  -80},{-40,-80},{-40,-100}}, color={0,0,127}));
          connect(fan1.P, power_pump_cold) annotation (Line(points={{87.2,-8.8},{87.2,
                  -40},{40,-40},{40,-100}}, color={0,0,127}));
          connect(senMasFlo1.m_flow, massflow_cold) annotation (Line(points={{29,-14},{
                  20,-14},{20,-40},{40,-40},{40,-80},{80,-80},{80,-100}}, color={0,0,
                  127}));
          connect(senTem1.T, hot_in) annotation (Line(points={{-43,36},{-20,36},{-20,
                  -40},{-100,-40}}, color={0,0,127}));
          connect(senTem2.T, hot_out) annotation (Line(points={{-65,36},{-60,36},{-60,0},
                  {-100,0}}, color={0,0,127}));
          connect(senTem3.T, cold_out) annotation (Line(points={{57,60},{60,60},{60,40},
                  {20,40},{20,80},{-100,80}}, color={0,0,127}));
          connect(senTem4.T, cold_in) annotation (Line(points={{77,60},{78,60},{78,40},
                  {-100,40}}, color={0,0,127}));
          connect(senMasFlo.port_b, pipe1.port_a)
            annotation (Line(points={{-80,-10},{-80,-6}}, color={0,127,255}));
          connect(pipe1.port_b, vol.ports[4])
            annotation (Line(points={{-80,14},{-80,61.8}}, color={0,127,255}));
          connect(val1.port_2, pipe.port_a)
            annotation (Line(points={{-40,54},{-40,16}}, color={0,127,255}));
          connect(pipe.port_b, fan2.port_a)
            annotation (Line(points={{-40,-4},{-40,-12}}, color={0,127,255}));
          connect(pipe3.port_a, senMasFlo1.port_b)
            annotation (Line(points={{40,10},{40,-4}}, color={0,127,255}));
          connect(pipe3.port_b, vol1.ports[4])
            annotation (Line(points={{40,30},{40,81.8}}, color={0,127,255}));
          connect(pipe2.port_b, fan1.port_a)
            annotation (Line(points={{80,16},{80,8}}, color={0,127,255}));
          connect(pipe2.port_a, val2.port_2)
            annotation (Line(points={{80,36},{80,74}}, color={0,127,255}));
          connect(senTem1.port, pipe.port_a)
            annotation (Line(points={{-50,26},{-40,26},{-40,16}}, color={0,127,255}));
          connect(Air_in, del.ports[1])
            annotation (Line(points={{-100,-66},{-81.2,-66}}, color={0,127,255}));
          connect(res.port_a, vol2.ports[1]) annotation (Line(points={{-64,-35},{-60,-35},
                  {-60,-42},{-46,-42}}, color={0,127,255}));
          connect(vol2.ports[2], fan2.port_b) annotation (Line(points={{-44,-42},{-40,-42},
                  {-40,-28}}, color={0,127,255}));
          connect(res.port_b, senMasFlo.port_a) annotation (Line(points={{-74,-35},{-80,
                  -35},{-80,-30}}, color={0,127,255}));
          connect(del.ports[2], vol4.ports[1])
            annotation (Line(points={{-78.8,-66},{-46,-66}}, color={0,127,255}));
          connect(vol4.ports[2], vol3.ports[1])
            annotation (Line(points={{-44,-66},{-7.2,-66}},  color={0,127,255}));
          connect(heatTransfer_Outside.port_b, vol2.heatPort) annotation (Line(points={{
                  -60.5,-48.5},{-60.5,-47},{-50,-47}}, color={191,0,0}));
          connect(heatTransfer_Outside.port_a, vol4.heatPort) annotation (Line(points={{
                  -60.5,-59.5},{-60.5,-61},{-50,-61}}, color={191,0,0}));
          connect(senMasFlo2.port_b, Air_out)
            annotation (Line(points={{82,-66},{100,-66}}, color={0,127,255}));
          connect(senMasFlo2.m_flow, gain.u)
            annotation (Line(points={{72,-55},{72,-52.8}}, color={0,0,127}));
          connect(gain.y, heatTransfer_Outside.WindSpeedPort) annotation (Line(points={{72,
                  -43.6},{72,-40},{0,-40},{0,-80},{-56.18,-80},{-56.18,-59.06}},
                color={0,0,127}));
          connect(vol5.ports[1], senMasFlo2.port_a)
            annotation (Line(points={{50,-66},{62,-66}}, color={0,127,255}));
          connect(heatTransfer_Outside1.port_a, vol5.heatPort) annotation (Line(points={
                  {33.5,-59.5},{33.5,-61},{46,-61}}, color={191,0,0}));
          connect(res1.port_a, vol6.ports[1]) annotation (Line(points={{36,-35},{42,-35},
                  {42,-42},{50,-42}}, color={0,127,255}));
          connect(res1.port_b, senMasFlo1.port_a) annotation (Line(points={{26,-35},{24,
                  -35},{22,-35},{22,-34},{22,-34},{22,-34},{22,-24},{40,-24}}, color={0,
                  127,255}));
          connect(vol6.ports[2], fan1.port_b) annotation (Line(points={{52,-42},{80,-42},
                  {80,-8},{80,-8}}, color={0,127,255}));
          connect(heatTransfer_Outside1.port_b, vol6.heatPort) annotation (Line(points={
                  {33.5,-48.5},{33.5,-47},{46,-47}}, color={191,0,0}));
          connect(heatTransfer_Outside1.WindSpeedPort, gain.y) annotation (Line(points={{37.82,
                  -59.06},{37.82,-80},{0,-80},{0,-40},{72,-40},{72,-43.6}},
                color={0,0,127}));
          connect(vol3.ports[2], res2.port_a)
            annotation (Line(points={{-4.8,-66},{12,-66}}, color={0,127,255}));
          connect(res2.port_b, vol5.ports[2])
            annotation (Line(points={{24,-66},{52,-66}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end RLT_OpenPlanOffice_v2;
      end Transfer_RLT;
    end Transfer;

    model Weather
      replaceable package Medium_Air =
        AixLib.Media.Air "Medium in the component";
      Components.Weather.Weather_Benchmark
                                 weather(
        Wind_dir=true,
        Wind_speed=true,
        Air_temp=true,
        Rel_hum=false,
        Mass_frac=true,
        Air_press=false,
        Latitude=48.0304,
        Longitude=9.3138,
        SOD=DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor_PV(),
        fileName=Modelica.Utilities.Files.loadResource(
            "modelica://AixLib/Building/Benchmark/SimYear_Variante3_angepasst.mat"),
        tableName="SimYearVar")
        annotation (Placement(transformation(extent={{-50,14},{-20,34}})));
      Modelica.Blocks.Math.Gain gain(k=1/360)
        annotation (Placement(transformation(extent={{10,36},{20,46}})));
      Modelica.Blocks.Math.Product product
        annotation (Placement(transformation(extent={{68,76},{76,84}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{68,36},{76,44}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{68,-4},{76,4}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{68,-44},{76,-36}})));
      Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[0,1; 0.25,1; 0.26,0;
            0.74,0; 0.75,1; 1,1], smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(extent={{46,62},{56,72}})));
      Modelica.Blocks.Tables.CombiTable1D combiTable1D1(table=[0,1; 0.25,1; 0.5,1;
            0.51,0; 0.99,0; 1,1])
        annotation (Placement(transformation(extent={{46,22},{56,32}})));
      Modelica.Blocks.Tables.CombiTable1D combiTable1D2(table=[0,0; 0.24,0; 0.25,1;
            0.75,1; 0.76,0; 1,0])
        annotation (Placement(transformation(extent={{46,-18},{56,-8}})));
      Modelica.Blocks.Tables.CombiTable1D combiTable1D3(table=[0,1; 0.01,0; 0.49,0;
            0.5,1; 1,1])
        annotation (Placement(transformation(extent={{46,-58},{56,-48}})));
      Modelica.Blocks.Math.Gain gain1(k=0)
        annotation (Placement(transformation(extent={{52,-86},{64,-74}})));
      Fluid.Sources.Boundary_pT Air_in_bou(
        redeclare package Medium = Medium_Air,
        p=100000,
        T=293.15,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-52,-40})));
      Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
            Medium_Air)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
      Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
            Medium_Air)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
      Fluid.Sources.MassFlowSource_T boundary(
        use_m_flow_in=true,
        use_T_in=true,
        use_X_in=true,
        nPorts=1,
        redeclare package Medium = Medium_Air)
        annotation (Placement(transformation(extent={{-44,-30},{-64,-10}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-14,-30},{-34,-50}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1)
        annotation (Placement(transformation(extent={{22,-48},{10,-32}})));
      BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
               {{-90,-120},{-50,-80}}), iconTransformation(extent={{-70,-110},{-50,
                -90}})));
      BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
               {{-52,-120},{-12,-80}}), iconTransformation(extent={{-10,-110},{10,-90}})));
      BusSystems.InternalBus internalBus annotation (Placement(transformation(
              extent={{30,-132},{70,-92}}), iconTransformation(extent={{50,-112},{
                70,-92}})));
      Electrical.PVSystem.PVSystem pVSystem(
        NumberOfPanels=50*9,
        data=DataBase.SolarElectric.CanadianSolarCS6P250P(),
        MaxOutputPower=50*9*250)
        annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
      Modelica.Blocks.Math.Gain gain2(k=-1)
        annotation (Placement(transformation(extent={{-18,64},{-6,76}})));
      Utilities.Interfaces.SolarRad_out SolarRadiation_East
        annotation (Placement(transformation(extent={{100,20},{120,40}})));
      Utilities.Interfaces.SolarRad_out SolarRadiation_South
        annotation (Placement(transformation(extent={{100,-20},{120,0}})));
      Utilities.Interfaces.SolarRad_out SolarRadiation_West
        annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
      Utilities.Interfaces.SolarRad_out SolarRadiation_Hor
        annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
      Utilities.Interfaces.SolarRad_out SolarRadiation_North5
        annotation (Placement(transformation(extent={{100,60},{120,80}})));
      Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
                             smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[-1,
            0.05,0; 0,0.05,0; 1,3.375,10125; 2,3.375,10125])
        annotation (Placement(transformation(extent={{-32,-78},{-12,-58}})));
      Modelica.Blocks.Interfaces.RealOutput RLT_Velocity
        "Connector of Real output signals"
        annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
      Modelica.Blocks.Math.Gain gain3(k=10090/(4*3600))
        annotation (Placement(transformation(extent={{-78,76},{-86,84}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(T=30, y_start=1)
        annotation (Placement(transformation(extent={{-16,-18},{-28,-6}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-54,-74},{-42,-62}})));
      Modelica.Blocks.Sources.RealExpression realExpression1
        annotation (Placement(transformation(extent={{-76,-84},{-64,-68}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
        annotation (Placement(transformation(extent={{-76,-68},{-64,-52}})));
    equation
      connect(weather.WindDirection, gain.u)
        annotation (Line(points={{-19,33},{0,33},{0,41},{9,41}}, color={0,0,127}));
      connect(product.u1, product1.u1) annotation (Line(points={{67.2,82.4},{40,
              82.4},{40,42.4},{67.2,42.4}}, color={0,0,127}));
      connect(product2.u1, product1.u1) annotation (Line(points={{67.2,2.4},{40,2.4},
              {40,42.4},{67.2,42.4}},        color={0,0,127}));
      connect(product3.u1, product1.u1) annotation (Line(points={{67.2,-37.6},{40,
              -37.6},{40,42.4},{67.2,42.4}}, color={0,0,127}));
      connect(gain.y, combiTable1D.u[1]) annotation (Line(points={{20.5,41},{32.25,
              41},{32.25,67},{45,67}}, color={0,0,127}));
      connect(combiTable1D.y[1], product.u2) annotation (Line(points={{56.5,67},{
              62.25,67},{62.25,77.6},{67.2,77.6}}, color={0,0,127}));
      connect(combiTable1D1.u[1], gain.y) annotation (Line(points={{45,27},{32,27},
              {32,41},{20.5,41}},color={0,0,127}));
      connect(combiTable1D2.u[1], gain.y) annotation (Line(points={{45,-13},{32,-13},
              {32,41},{20.5,41}}, color={0,0,127}));
      connect(combiTable1D3.u[1], gain.y) annotation (Line(points={{45,-53},{32,-53},
              {32,41},{20.5,41}}, color={0,0,127}));
      connect(combiTable1D1.y[1], product1.u2) annotation (Line(points={{56.5,27},{
              62,27},{62,37.6},{67.2,37.6}},color={0,0,127}));
      connect(combiTable1D2.y[1], product2.u2) annotation (Line(points={{56.5,-13},
              {62,-13},{62,-2.4},{67.2,-2.4}},   color={0,0,127}));
      connect(combiTable1D3.y[1], product3.u2) annotation (Line(points={{56.5,-53},
              {62,-53},{62,-42.4},{67.2,-42.4}}, color={0,0,127}));
      connect(gain1.u, product1.u1) annotation (Line(points={{50.8,-80},{40,-80},{
              40,42.4},{67.2,42.4}}, color={0,0,127}));
      connect(boundary.X_in[1], weather.WaterInAir) annotation (Line(points={{-42,
              -24},{-24,-24},{-24,16},{-10,16},{-10,21},{-19,21}}, color={0,0,127}));
      connect(boundary.ports[1], Air_out)
        annotation (Line(points={{-64,-20},{-100,-20}}, color={0,127,255}));
      connect(feedback.u2, weather.WaterInAir) annotation (Line(points={{-24,-32},{
              -24,16},{-10,16},{-10,21},{-19,21}}, color={0,0,127}));
      connect(feedback.y, boundary.X_in[2]) annotation (Line(points={{-33,-40},{-36,
              -40},{-36,-24},{-42,-24}}, color={0,0,127}));
      connect(realExpression.y, feedback.u1)
        annotation (Line(points={{9.4,-40},{-16,-40}}, color={0,0,127}));
      connect(Air_in, Air_in_bou.ports[1])
        annotation (Line(points={{-100,-60},{-92,-60},{-92,-40},{-62,-40}},
                                                        color={0,127,255}));
      connect(weather.WaterInAir, measureBus.WaterInAir) annotation (Line(points={{
              -19,21},{0,21},{0,-84},{-31.9,-84},{-31.9,-99.9}}, color={0,0,127}));
      connect(product.y, internalBus.InternalLoads_Wind_Speed_North) annotation (
          Line(points={{76.4,80},{86,80},{86,-111.9},{50.1,-111.9}},
                                                                color={0,0,127}));
      connect(product1.y, internalBus.InternalLoads_Wind_Speed_East) annotation (
          Line(points={{76.4,40},{86,40},{86,-111.9},{50.1,-111.9}},
                                                                color={0,0,127}));
      connect(product2.y, internalBus.InternalLoads_Wind_Speed_South) annotation (
          Line(points={{76.4,0},{86,0},{86,-112},{68,-112},{68,-111.9},{50.1,-111.9}},
                                                              color={0,0,127}));
      connect(product3.y, internalBus.InternalLoads_Wind_Speed_West) annotation (
          Line(points={{76.4,-40},{86,-40},{86,-111.9},{50.1,-111.9}},
                                                                  color={0,0,127}));
      connect(gain1.y, internalBus.InternalLoads_Wind_Speed_Hor) annotation (Line(
            points={{64.6,-80},{86,-80},{86,-111.9},{50.1,-111.9}},
                                                               color={0,0,127}));
      connect(weather.AirTemp, boundary.T_in) annotation (Line(points={{-19,27},{0,
              27},{0,-16},{-42,-16}}, color={0,0,127}));
      connect(weather.AirTemp, measureBus.AirTemp) annotation (Line(points={{-19,27},
              {0,27},{0,-84},{-32,-84},{-32,-92},{-31.9,-92},{-31.9,-99.9}}, color=
              {0,0,127}));
      connect(weather.WindSpeed, product1.u1) annotation (Line(points={{-19,30},{40,
              30},{40,42.4},{67.2,42.4}}, color={0,0,127}));
      connect(pVSystem.PVPowerW, gain2.u)
        annotation (Line(points={{-29,70},{-19.2,70}}, color={0,0,127}));
      connect(gain2.y, measureBus.PV_Power) annotation (Line(points={{-5.4,70},{0,
              70},{0,42},{0,-84},{-32,-84},{-32,-92},{-31.9,-92},{-31.9,-99.9}},
            color={0,0,127}));
      connect(weather.SolarRadiation_OrientedSurfaces[2], SolarRadiation_East)
        annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,30},
              {110,30}}, color={255,128,0}));
      connect(weather.SolarRadiation_OrientedSurfaces[1], SolarRadiation_North5)
        annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,70},
              {110,70}}, color={255,128,0}));
      connect(weather.SolarRadiation_OrientedSurfaces[3], SolarRadiation_South)
        annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,
              -10},{110,-10}}, color={255,128,0}));
      connect(weather.SolarRadiation_OrientedSurfaces[4], SolarRadiation_West)
        annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,
              -50},{110,-50}}, color={255,128,0}));
      connect(weather.SolarRadiation_OrientedSurfaces[5], SolarRadiation_Hor)
        annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,
              -90},{110,-90}}, color={255,128,0}));
      connect(pVSystem.TOutside, boundary.T_in) annotation (Line(points={{-52,77.6},
              {-60,77.6},{-60,0},{0,0},{0,26},{0,26},{0,-16},{-42,-16}}, color={0,0,
              127}));
      connect(pVSystem.IcTotalRad, weather.SolarRadiation_OrientedSurfaces[6])
        annotation (Line(points={{-51.8,69.5},{-60,69.5},{-60,0},{-42.8,0},{-42.8,
              13}}, color={255,128,0}));
      connect(RLT_Velocity, gain3.y)
        annotation (Line(points={{-110,80},{-86.4,80}}, color={0,0,127}));
      connect(gain3.u, combiTable1Ds.y[1]) annotation (Line(points={{-77.2,80},{-60,
              80},{-60,0},{-8,0},{-8,-68},{-11,-68}}, color={0,0,127}));
      connect(combiTable1Ds.y[2], measureBus.Fan_RLT) annotation (Line(points={{-11,
              -68},{0,-68},{0,-84},{-31.9,-84},{-31.9,-99.9}}, color={0,0,127}));
      connect(boundary.m_flow_in, firstOrder.y)
        annotation (Line(points={{-44,-12},{-28.6,-12}}, color={0,0,127}));
      connect(firstOrder.u, combiTable1Ds.y[1]) annotation (Line(points={{-14.8,-12},
              {-8,-12},{-8,-68},{-11,-68}}, color={0,0,127}));
      connect(realExpression1.y, switch1.u3) annotation (Line(points={{-63.4,-76},{
              -60,-76},{-60,-72.8},{-55.2,-72.8}}, color={0,0,127}));
      connect(switch1.y, combiTable1Ds.u)
        annotation (Line(points={{-41.4,-68},{-34,-68}}, color={0,0,127}));
      connect(realExpression2.y, switch1.u1) annotation (Line(points={{-63.4,-60},{
              -58,-60},{-58,-63.2},{-55.2,-63.2}}, color={0,0,127}));
      connect(switch1.u2, controlBus.OnOff_RLT) annotation (Line(points={{-55.2,-68},
              {-88,-68},{-88,-99.9},{-69.9,-99.9}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Weather;

    package Building
      model Office_v2
        replaceable package Medium_Air =
          AixLib.Media.Air "Medium in the component";
        Modelica.Fluid.Interfaces.FluidPort_a Air_in[5](redeclare package
            Medium =
              Medium_Air)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
        Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium
            = Medium_Air)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
        Fluid.MixingVolumes.MixingVolume vol1(
          redeclare package Medium = Medium_Air,
          V=10,
          nPorts=6,
          m_flow_nominal=3.375)
                     annotation (Placement(transformation(
              extent={{-7,-7},{7,7}},
              rotation=90,
              origin={-67,-69})));
        BusSystems.Bus_measure measureBus
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA[5]
          annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower[5]
          annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
        BusSystems.InternalBus internalBus
          annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_North
          annotation (Placement(transformation(extent={{80,70},{100,90}})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_East
          annotation (Placement(transformation(extent={{80,30},{100,50}})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_South1
          annotation (Placement(transformation(extent={{80,-10},{100,10}})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_West1
          annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor1
          annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
        Floors.WestWing westWing
          annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
        Floors.EastWing eastWing
          annotation (Placement(transformation(extent={{20,-20},{60,20}})));
      equation
        connect(vol1.ports[1],  Air_out) annotation (Line(points={{-60,-71.3333},{-60,
                -86},{-80,-86},{-80,-100}}, color={0,127,255}));
        connect(eastWing.HeatPort_ToCanteen1, westWing.HeatPort_ToOpenplanoffice1)
          annotation (Line(points={{20,16},{0,16},{0,-1.6},{-20,-1.6}}, color={191,0,
                0}));
        connect(westWing.AddPower_Canteen, AddPower[4]) annotation (Line(points={{-60,
                -20},{-80,-20},{-80,-36},{-100,-36}}, color={191,0,0}));
        connect(westWing.AddPower_Workshop, AddPower[5]) annotation (Line(points={{
                -60,-12},{-80,-12},{-80,-32},{-100,-32}}, color={191,0,0}));
        connect(eastWing.AddPower_MultiPersonOffice, AddPower[3]) annotation (Line(
              points={{24,20},{24,40},{-80,40},{-80,-40},{-100,-40}}, color={191,0,0}));
        connect(eastWing.AddPower_ConferenceRoom, AddPower[2]) annotation (Line(
              points={{32,20},{32,40},{-80,40},{-80,-44},{-100,-44}}, color={191,0,0}));
        connect(eastWing.AddPower_OpenPlanOffice, AddPower[1]) annotation (Line(
              points={{40,20},{40,40},{-80,40},{-80,-48},{-100,-48}}, color={191,0,0}));
        connect(westWing.internalBus, internalBus) annotation (Line(
            points={{-20,12},{0,12},{0,40},{-100,40}},
            color={255,204,51},
            thickness=0.5));
        connect(westWing.measureBus, measureBus) annotation (Line(
            points={{-19.6,4},{0,4},{0,40},{-80,40},{-80,0},{-100,0}},
            color={255,204,51},
            thickness=0.5));
        connect(eastWing.internalBus, internalBus) annotation (Line(
            points={{60,12},{80,12},{80,40},{-100,40}},
            color={255,204,51},
            thickness=0.5));
        connect(eastWing.measureBus, measureBus) annotation (Line(
            points={{60,4},{80,4},{80,40},{-80,40},{-80,0},{-100,0}},
            color={255,204,51},
            thickness=0.5));
        connect(westWing.Heatport_TBA_Workshop, Heatport_TBA[5]) annotation (Line(
              points={{-20,-16},{0,-16},{0,-80},{60,-80},{60,-92}}, color={191,0,0}));
        connect(westWing.Heatport_TBA_Canteen, Heatport_TBA[4]) annotation (Line(
              points={{-20,-8},{0,-8},{0,-80},{60,-80},{60,-96}}, color={191,0,0}));
        connect(eastWing.Heatport_TBA_Openplanoffice, Heatport_TBA[1]) annotation (
            Line(points={{60,-4},{80,-4},{80,-80},{60,-80},{60,-108}}, color={191,0,0}));
        connect(eastWing.Heatport_TBA_ConferenceRoom, Heatport_TBA[2]) annotation (
            Line(points={{60,-8},{80,-8},{80,-80},{60,-80},{60,-104}}, color={191,0,0}));
        connect(eastWing.Heatport_TBA_Multipersonoffice, Heatport_TBA[3]) annotation (
           Line(points={{60,-12},{80,-12},{80,-80},{60,-80},{60,-100}}, color={191,0,
                0}));
        connect(eastWing.SolarRadiationPort_East, SolarRadiationPort_East)
          annotation (Line(points={{61.2,-17.2},{80,-17.2},{80,40},{90,40}}, color={
                255,128,0}));
        connect(eastWing.SolarRadiationPort_South, SolarRadiationPort_South1)
          annotation (Line(points={{53.2,-21.2},{53.2,-40},{80,-40},{80,0},{90,0}},
              color={255,128,0}));
        connect(eastWing.SolarRadiationPort_Hor, SolarRadiationPort_Hor1) annotation (
           Line(points={{60.8,20.8},{60.8,40},{80,40},{80,-80},{90,-80}}, color={255,
                128,0}));
        connect(eastWing.SolarRadiationPort_North, SolarRadiationPort_North)
          annotation (Line(points={{54,20.8},{54,40},{80,40},{80,80},{90,80}}, color=
                {255,128,0}));
        connect(westWing.SolarRadiationPort_Hor, SolarRadiationPort_Hor1) annotation (
           Line(points={{-24,20.8},{-24,40},{80,40},{80,-80},{90,-80}}, color={255,
                128,0}));
        connect(westWing.SolarRadiationPort_North, SolarRadiationPort_North)
          annotation (Line(points={{-40,20.8},{-40,40},{80,40},{80,80},{90,80}},
              color={255,128,0}));
        connect(westWing.SolarRadiationPort_West, SolarRadiationPort_West1)
          annotation (Line(points={{-60.8,16},{-80,16},{-80,40},{80,40},{80,-40},{90,
                -40}}, color={255,128,0}));
        connect(westWing.SolarRadiationPort_South, SolarRadiationPort_West1)
          annotation (Line(points={{-28,-20.8},{-28,-40},{74,-40},{74,-40},{90,-40}},
              color={255,128,0}));
        connect(westWing.Air_out_Canteen, vol1.ports[2]) annotation (Line(points={{
                -60,8},{-70,8},{-70,-40},{-60,-40},{-60,-70.4}}, color={0,127,255}));
        connect(westWing.Air_out_Workshop, vol1.ports[3]) annotation (Line(points={{-60,0},
                {-70,0},{-70,-40},{-60,-40},{-60,-69.4667}},        color={0,127,255}));
        connect(eastWing.Air_out_Openplanoffice, vol1.ports[4]) annotation (Line(
              points={{20,8},{0,8},{0,-40},{-60,-40},{-60,-68.5333}}, color={0,127,
                255}));
        connect(eastWing.Air_out_Conferenceroom, vol1.ports[5]) annotation (Line(
              points={{20,0},{0,0},{0,-40},{-60,-40},{-60,-67.6}}, color={0,127,255}));
        connect(eastWing.Air_out_Multipersonoffice, vol1.ports[6]) annotation (Line(
              points={{20,-8},{0,-8},{0,-40},{-60,-40},{-60,-66.6667}}, color={0,127,
                255}));
        connect(westWing.Air_in_Workshop, Air_in[5]) annotation (Line(points={{-60,-4},
                {-66,-4},{-66,-36},{-40,-36},{-40,-92}}, color={0,127,255}));
        connect(westWing.Air_in_Canteen, Air_in[4]) annotation (Line(points={{-60,4},
                {-66,4},{-66,-36},{-40,-36},{-40,-96}}, color={0,127,255}));
        connect(eastWing.Air_in_Multipersonoffice, Air_in[3]) annotation (Line(points=
               {{20,-12},{4,-12},{4,-36},{-40,-36},{-40,-100}}, color={0,127,255}));
        connect(eastWing.Air_in_Conferenceroom, Air_in[2]) annotation (Line(points={{
                20,-4},{4,-4},{4,-36},{-40,-36},{-40,-104}}, color={0,127,255}));
        connect(eastWing.Air_in_Openplanoffice, Air_in[1]) annotation (Line(points={{
                20,4},{4,4},{4,-36},{-40,-36},{-40,-108}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Office_v2;

      package Floors
        model WestWing
          replaceable package Medium =
            AixLib.Media.Air "Medium in the component";
          Rooms.Workshop_v2
                         workshop
            annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
          Rooms.Canteen_v2
                        canteen
            annotation (Placement(transformation(extent={{20,-20},{60,20}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp(T=286.65)
            annotation (Placement(transformation(extent={{-64,-56},{-52,-44}})));
          BusSystems.Bus_measure measureBus
            annotation (Placement(transformation(extent={{82,0},{122,40}})));
          BusSystems.InternalBus internalBus
            annotation (Placement(transformation(extent={{80,40},{120,80}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA_Canteen
            annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA_Workshop
            annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_Canteen
            annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_Workshop
            annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out_Canteen(redeclare
              package Medium =
                       Medium)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in_Canteen(redeclare
              package Medium =
                Medium)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out_Workshop(redeclare
              package Medium =
                       Medium)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in_Workshop(redeclare
              package Medium =
                       Medium)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_North annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={0,104})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={80,104})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_South annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,-104})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_West
            annotation (Placement(transformation(extent={{-114,70},{-94,90}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp1(
                                                                            T=286.65)
            annotation (Placement(transformation(extent={{16,-56},{28,-44}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
            HeatPort_ToOpenplanoffice1
            annotation (Placement(transformation(extent={{90,-18},{110,2}})));
        equation
          connect(workshop.HeatPort_ToCanteen, canteen.HeatPort_ToWorkshop) annotation (
             Line(points={{-20,-6.4},{0,-6.4},{0,-6},{0,-6},{0,0},{20,0}}, color={191,0,
                  0}));
          connect(canteen.measureBus, measureBus) annotation (Line(
              points={{20,-12},{0,-12},{0,-80},{80,-80},{80,20},{102,20}},
              color={255,204,51},
              thickness=0.5));
          connect(workshop.measureBus, measureBus) annotation (Line(
              points={{-60,-12},{-80,-12},{-80,-80},{80,-80},{80,20},{102,20}},
              color={255,204,51},
              thickness=0.5));
          connect(canteen.Heatport_TBA, Heatport_TBA_Canteen) annotation (Line(points={
                  {60,9.6},{80,9.6},{80,10},{80,10},{80,-40},{100,-40}}, color={191,0,0}));
          connect(workshop.Heatport_TBA, Heatport_TBA_Workshop) annotation (Line(points=
                 {{-20,9.6},{0,9.6},{0,-80},{100,-80}}, color={191,0,0}));
          connect(canteen.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
            annotation (Line(points={{36,20.8},{36,80},{80,80},{80,60.1},{100.1,60.1}},
                color={0,0,127}));
          connect(canteen.mWat_Canteen, internalBus.InternalLoads_MFlow_Canteen)
            annotation (Line(points={{19.2,18.4},{0,18.4},{0,80},{80,80},{80,60.1},{
                  100.1,60.1}}, color={0,0,127}));
          connect(canteen.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
            annotation (Line(points={{23.6,-21.2},{23.6,-30},{0,-30},{0,80},{80,80},{80,
                  60.1},{100.1,60.1}}, color={0,0,127}));
          connect(workshop.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
            annotation (Line(points={{-44,20.8},{-44,80},{80,80},{80,60.1},{100.1,60.1}},
                color={0,0,127}));
          connect(workshop.mWat_Workshop, internalBus.InternalLoads_MFlow_Workshop)
            annotation (Line(points={{-60.8,18.4},{-80,18.4},{-80,80},{80,80},{80,60.1},
                  {100.1,60.1}}, color={0,0,127}));
          connect(workshop.WindSpeedPort_WestWall, internalBus.InternalLoads_Wind_Speed_West)
            annotation (Line(points={{-63.2,0},{-80,0},{-80,80},{80,80},{80,60.1},{
                  100.1,60.1}}, color={0,0,127}));
          connect(workshop.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
            annotation (Line(points={{-56.4,-21.2},{-56.4,-30},{0,-30},{0,80},{80,80},{
                  80,60.1},{100.1,60.1}}, color={0,0,127}));
          connect(canteen.AddPower_Canteen, AddPower_Canteen) annotation (Line(points={
                  {20,14},{0,14},{0,-80},{-60,-80},{-80,-80},{-80,-100},{-100,-100}},
                color={191,0,0}));
          connect(workshop.AddPower_Workshop, AddPower_Workshop) annotation (Line(
                points={{-60,14},{-80,14},{-80,-60},{-100,-60}}, color={191,0,0}));
          connect(canteen.Air_out, Air_out_Canteen) annotation (Line(points={{60,5.6},{
                  80,5.6},{80,80},{-80,80},{-80,40},{-100,40}}, color={0,127,255}));
          connect(canteen.Air_in, Air_in_Canteen) annotation (Line(points={{60,1.2},{80,
                  1.2},{80,80},{-80,80},{-80,20},{-100,20}}, color={0,127,255}));
          connect(workshop.Air_out, Air_out_Workshop) annotation (Line(points={{-20,5.6},
                  {0,5.6},{0,80},{-80,80},{-80,0},{-100,0}}, color={0,127,255}));
          connect(workshop.Air_in, Air_in_Workshop) annotation (Line(points={{-20,1.2},
                  {0,1.2},{0,80},{-80,80},{-80,-20},{-100,-20}}, color={0,127,255}));
          connect(workshop.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
            annotation (Line(points={{-38,22},{-38,80},{0,80},{0,104}}, color={255,128,
                  0}));
          connect(workshop.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
            annotation (Line(points={{-44.8,-22},{-44,-22},{-44,-80},{60,-80},{60,-104}},
                color={255,128,0}));
          connect(workshop.SolarRadiationPort_WestWall, SolarRadiationPort_West)
            annotation (Line(points={{-62,-6.4},{-80,-6.4},{-80,-6},{-80,-6},{-80,80},{
                  -104,80}}, color={255,128,0}));
          connect(canteen.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
            annotation (Line(points={{42,22},{42,80},{0,80},{0,104}}, color={255,128,0}));
          connect(canteen.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
            annotation (Line(points={{35.2,-22},{36,-22},{36,-80},{60,-80},{60,-104}},
                color={255,128,0}));
          connect(workshop.HeatPort_ToGround, GroundTemp.port) annotation (Line(points=
                  {{-34.4,-20},{-34,-20},{-34,-50},{-52,-50}}, color={191,0,0}));
          connect(GroundTemp1.port, canteen.HeatPort_ToGround) annotation (Line(points=
                  {{28,-50},{42.8,-50},{42.8,-20}}, color={191,0,0}));
          connect(workshop.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
            annotation (Line(points={{-32,20.8},{-32,80},{80,80},{80,60.1},{100.1,60.1}},
                color={0,0,127}));
          connect(workshop.SolarRadiationPort_Roof, SolarRadiationPort_Hor) annotation (
             Line(points={{-26,22},{-26,80},{80,80},{80,104}}, color={255,128,0}));
          connect(canteen.SolarRadiationPort_Roof, SolarRadiationPort_Hor) annotation (
              Line(points={{58,22},{58,80},{80,80},{80,104}}, color={255,128,0}));
          connect(canteen.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
            annotation (Line(points={{52,20.8},{52,80},{80,80},{80,60.1},{100.1,60.1}},
                color={0,0,127}));
          connect(canteen.HeatPort_ToOpenplanoffice, HeatPort_ToOpenplanoffice1)
            annotation (Line(points={{60,-8},{100,-8}}, color={191,0,0}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end WestWing;

        model EastWing
          replaceable package Medium =
            AixLib.Media.Air "Medium in the component";
          Rooms.OpenPlanOffice_v2
                               openPlanOffice
            annotation (Placement(transformation(extent={{18,-16},{54,18}})));
          Rooms.MultiPersonOffice_v2
                                  multiPersonOffice
            annotation (Placement(transformation(extent={{-52,14},{-16,48}})));
          Rooms.ConferenceRoom_v2
                               conferenceRoom
            annotation (Placement(transformation(extent={{-52,-50},{-16,-16}})));
          BusSystems.Bus_measure measureBus
            annotation (Placement(transformation(extent={{80,0},{120,40}})));
          BusSystems.InternalBus internalBus
            annotation (Placement(transformation(extent={{80,40},{120,80}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out_Multipersonoffice(redeclare
              package Medium = Medium)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in_Multipersonoffice(redeclare
              package Medium = Medium)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out_Openplanoffice(redeclare
              package Medium = Medium)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in_Openplanoffice(redeclare
              package Medium =
                       Medium)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out_Conferenceroom(redeclare
              package Medium = Medium)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in_Conferenceroom(redeclare
              package Medium =
                       Medium)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
            Heatport_TBA_Openplanoffice
            annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
            Heatport_TBA_ConferenceRoom
            annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
            Heatport_TBA_Multipersonoffice
            annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_OpenPlanOffice
            annotation (Placement(transformation(extent={{-10,90},{10,110}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_ConferenceRoom
            annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
            AddPower_MultiPersonOffice
            annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_North annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={70,104})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={104,104})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_East
            annotation (Placement(transformation(extent={{116,-96},{96,-76}})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_South annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=-90,
                origin={66,-106})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp(T=286.65)
            annotation (Placement(transformation(extent={{-72,-72},{-60,-60}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp1(
                                                                            T=286.65)
            annotation (Placement(transformation(extent={{-74,4},{-62,16}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp2(
                                                                            T=286.65)
            annotation (Placement(transformation(extent={{6,-42},{18,-30}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToCanteen1
            annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
        equation
          connect(openPlanOffice.HeatPort_ToConferenceRoom, conferenceRoom.HeatPort_ToOpenPlanOffice)
            annotation (Line(points={{18,5.42},{0,5.42},{0,-4},{0,-4},{0,-36},{0,-36},{
                  0,-36},{0,-80},{-28,-80},{-28,-66},{-28.6,-66},{-28.6,-50}},
                               color={191,0,0}));
          connect(openPlanOffice.HeatPort_ToMultiPersonOffice, multiPersonOffice.HeatPort_ToOpenPlanOffice)
            annotation (Line(points={{48.6,-16},{48,-16},{48,-80},{0,-80},{0,6},{0,6},{
                  0,24},{0,24},{0,24},{0,23.86},{-10,23.86},{-16,23.86}},
                                            color={191,0,0}));
          connect(openPlanOffice.measureBus, measureBus) annotation (Line(
              points={{18,-9.2},{0,-9.2},{0,-80},{80,-80},{80,20},{100,20}},
              color={255,204,51},
              thickness=0.5));
          connect(conferenceRoom.measureBus, measureBus) annotation (Line(
              points={{-52,-43.2},{-80,-43.2},{-80,-80},{80,-80},{80,20},{100,20}},
              color={255,204,51},
              thickness=0.5));
          connect(multiPersonOffice.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
            annotation (Line(points={{-26.8,48.68},{-26.8,80},{80,80},{80,60},{90,60},{
                  90,60.1},{100.1,60.1}}, color={0,0,127}));
          connect(multiPersonOffice.mWat_MultiPersonOffice, internalBus.InternalLoads_MFlow_Multipersonoffice)
            annotation (Line(points={{-52.72,46.64},{-80,46.64},{-80,80},{80,80},{80,
                  60.1},{100.1,60.1}}, color={0,0,127}));
          connect(openPlanOffice.mWat_OpenPlanOffice, internalBus.InternalLoads_MFlow_Openplanoffice)
            annotation (Line(points={{17.28,16.64},{0,16.64},{0,80},{80,80},{80,60.1},{
                  100.1,60.1}}, color={0,0,127}));
          connect(conferenceRoom.mWat_ConferenceRoom, internalBus.InternalLoads_MFlow_Conferenceroom)
            annotation (Line(points={{-52.72,-17.36},{-80,-17.36},{-80,-80},{80,-80},{
                  80,60.1},{100.1,60.1}}, color={0,0,127}));
          connect(conferenceRoom.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
            annotation (Line(points={{-26.8,-15.32},{-26.8,0},{-80,0},{-80,80},{80,80},
                  {80,60.1},{100.1,60.1}}, color={0,0,127}));
          connect(openPlanOffice.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
            annotation (Line(points={{32.4,18.68},{32.4,80},{80,80},{80,60.1},{100.1,
                  60.1}}, color={0,0,127}));
          connect(openPlanOffice.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
            annotation (Line(points={{43.2,18.68},{43.2,80},{80,80},{80,60.1},{100.1,
                  60.1}}, color={0,0,127}));
          connect(openPlanOffice.WindSpeedPort_EastWall, internalBus.InternalLoads_Wind_Speed_East)
            annotation (Line(points={{54.72,-2.06},{80,-2.06},{80,60.1},{100.1,60.1}},
                color={0,0,127}));
          connect(openPlanOffice.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
            annotation (Line(points={{21.24,-17.02},{21.24,-80},{80,-80},{80,60.1},{
                  100.1,60.1}}, color={0,0,127}));
          connect(multiPersonOffice.measureBus, measureBus) annotation (Line(
              points={{-52,20.8},{-80,20.8},{-80,20},{-80,20},{-80,22},{-80,22},{-80,80},
                  {80,80},{80,20},{100,20}},
              color={255,204,51},
              thickness=0.5));
          connect(multiPersonOffice.Air_out, Air_out_Multipersonoffice) annotation (
              Line(points={{-16,35.76},{0,35.76},{0,36},{0,36},{0,0},{-80,0},{-80,-40},
                  {-100,-40}}, color={0,127,255}));
          connect(multiPersonOffice.Air_in, Air_in_Multipersonoffice) annotation (Line(
                points={{-16,32.02},{-8,32.02},{-8,32},{0,32},{0,0},{-80,0},{-80,-60},{
                  -100,-60}}, color={0,127,255}));
          connect(openPlanOffice.Air_out, Air_out_Openplanoffice) annotation (Line(
                points={{54,5.76},{80,5.76},{80,6},{80,6},{80,80},{-80,80},{-80,40},{
                  -100,40}}, color={0,127,255}));
          connect(openPlanOffice.Air_in, Air_in_Openplanoffice) annotation (Line(points=
                 {{54,2.02},{68,2.02},{68,2},{80,2},{80,80},{-80,80},{-80,20},{-100,20}},
                color={0,127,255}));
          connect(conferenceRoom.Air_out, Air_out_Conferenceroom) annotation (Line(
                points={{-16,-28.24},{-14,-28.24},{-14,-28},{0,-28},{0,0},{-100,0}},
                color={0,127,255}));
          connect(conferenceRoom.Air_in, Air_in_Conferenceroom) annotation (Line(points=
                 {{-16,-31.98},{-12,-31.98},{-12,-32},{0,-32},{0,0},{-80,0},{-80,-20},{
                  -100,-20}}, color={0,127,255}));
          connect(openPlanOffice.Heatport_TBA, Heatport_TBA_Openplanoffice) annotation (
             Line(points={{54,9.16},{80,9.16},{80,-20},{100,-20}}, color={191,0,0}));
          connect(conferenceRoom.Heatport_TBA, Heatport_TBA_ConferenceRoom) annotation (
             Line(points={{-16,-24.84},{0,-24.84},{0,-26},{0,-26},{0,-80},{80,-80},{80,
                  -40},{100,-40}}, color={191,0,0}));
          connect(multiPersonOffice.Heatport_TBA, Heatport_TBA_Multipersonoffice)
            annotation (Line(points={{-16.36,42.9},{0,42.9},{0,-80},{80,-80},{80,-60},{
                  100,-60},{100,-60}}, color={191,0,0}));
          connect(openPlanOffice.AddPower_OpenPlanOffice, AddPower_OpenPlanOffice)
            annotation (Line(points={{18,12.9},{0,12.9},{0,100}}, color={191,0,0}));
          connect(conferenceRoom.AddPower_ConferenceRoom, AddPower_ConferenceRoom)
            annotation (Line(points={{-52,-21.1},{-80,-21.1},{-80,-22},{-80,-22},{-80,
                  80},{-40,80},{-40,100}}, color={191,0,0}));
          connect(multiPersonOffice.AddPower_MultiPersonOffice,
            AddPower_MultiPersonOffice) annotation (Line(points={{-52,42.9},{-80,42.9},
                  {-80,42},{-80,42},{-80,100},{-80,100}}, color={191,0,0}));
          connect(multiPersonOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
            annotation (Line(points={{-21.4,49.7},{-21.4,80},{-22,80},{-22,80},{104,80},
                  {104,104}}, color={255,128,0}));
          connect(openPlanOffice.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
            annotation (Line(points={{37.8,19.7},{37.8,50},{38,50},{38,80},{70,80},{70,
                  104}}, color={255,128,0}));
          connect(openPlanOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
            annotation (Line(points={{48.6,19.7},{48.6,80},{48,80},{48,80},{104,80},{
                  104,104}}, color={255,128,0}));
          connect(openPlanOffice.SolarRadiationPort_EastWall, SolarRadiationPort_East)
            annotation (Line(points={{55.8,-7.5},{80,-7.5},{80,-86},{106,-86}}, color={
                  255,128,0}));
          connect(openPlanOffice.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
            annotation (Line(points={{31.68,-17.7},{31.68,-80},{66,-80},{66,-106}},
                color={255,128,0}));
          connect(conferenceRoom.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
            annotation (Line(points={{-21.4,-14.3},{-21.4,0},{0,0},{0,80},{104,80},{104,
                  104}}, color={255,128,0}));
          connect(multiPersonOffice.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
            annotation (Line(points={{-26.8,13.32},{-26.8,0},{0,0},{0,80},{80,80},{80,
                  60.1},{100.1,60.1}}, color={0,0,127}));
          connect(conferenceRoom.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
            annotation (Line(points={{-41.2,-14.98},{-41.2,0},{0,0},{0,80},{80,80},{80,
                  60.1},{100.1,60.1}}, color={0,0,127}));
          connect(SolarRadiationPort_North, conferenceRoom.SolarRadiationPort_NorthWall)
            annotation (Line(points={{70,104},{70,80},{0,80},{0,0},{-32.2,0},{-32.2,
                  -14.3}}, color={255,128,0}));
          connect(SolarRadiationPort_South, multiPersonOffice.SolarRadiationPort_SouthWall)
            annotation (Line(points={{66,-106},{66,-80},{0,-80},{0,0},{-17.8,0},{-17.8,
                  12.3}}, color={255,128,0}));
          connect(GroundTemp.port, conferenceRoom.HeatPort_ToGround) annotation (Line(
                points={{-60,-66},{-39.76,-66},{-39.76,-50}}, color={191,0,0}));
          connect(GroundTemp1.port, multiPersonOffice.HeatPort_ToGround) annotation (
              Line(points={{-62,10},{-39.04,10},{-39.04,14}}, color={191,0,0}));
          connect(GroundTemp2.port, openPlanOffice.HeatPort_ToGround) annotation (Line(
                points={{18,-36},{38.52,-36},{38.52,-16}}, color={191,0,0}));
          connect(openPlanOffice.HeatPort_ToCanteen, HeatPort_ToCanteen1) annotation (
              Line(points={{18,-3.42},{12,-3.42},{12,-4},{0,-4},{0,80},{-100,80}},
                color={191,0,0}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end EastWing;
      end Floors;

      package Rooms
        model BaseRoom
          replaceable package Medium_Air =
            AixLib.Media.Air "Medium in the component";
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent={{-13,10},
                    {13,-10}},                                                                                                            rotation = 90, origin={-10,-27})));
          Components.Walls.ActiveWallPipeBased activeWallPipeBased(
            withDoor=false,
            ISOrientation=3,
            outside=true,
            wall_length=20,
            wall_height=5,
            WallType=DataBase.Walls.EnEV2009.Ceiling.CE_RO_EnEV2009_SM_TBA(),
            solar_absorptance=0.48)
            annotation (Placement(transformation(
                extent={{-4,-24},{4,24}},
                rotation=-90,
                origin={40,60})));
          Fluid.MixingVolumes.MixingVolumeMoistAir vol(
                                             nPorts=2,
            m_flow_nominal=10,
            m_flow_small=0.001,
            allowFlowReversal=true,
            X_start={0.01,0.99},
            energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
            massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
            redeclare package Medium = Medium_Air,
            p_start=100000,
            T_start=293.15,
            V=300)
            annotation (Placement(transformation(extent={{20,-20},{40,0}})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Roof annotation (Placement(
                transformation(
                extent={{-12,-12},{12,12}},
                rotation=-90,
                origin={60,100})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={90,110})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA
            annotation (Placement(transformation(extent={{90,60},{110,80}})));
          Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium
              = Medium_Air)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package
              Medium =
                Medium_Air)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,30},{110,50}})));
          Modelica.Blocks.Interfaces.RealInput mFlow_Water
            "Water flow rate added into the medium"
            annotation (Placement(transformation(extent={{-112,78},{-88,102}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_System
            annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
            annotation (Placement(transformation(extent={{20,10},{40,30}})));
          BusSystems.Bus_measure measureBus
            annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature1
                                  annotation (Placement(transformation(
                extent={{6,-6},{-6,6}},
                rotation=180,
                origin={30,80})));
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
            annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
        equation
          connect(activeWallPipeBased.thermStarComb_inside,thermStar_Demux. thermStarComb)
            annotation (Line(points={{40,56},{40,48},{-50,48},{-50,-52},{-10,-52},{-10,
                  -40},{-10.125,-40},{-10.125,-39.22}},
                                 color={191,0,0}));
          connect(WindSpeedPort_Roof,activeWallPipeBased. WindSpeedPort) annotation (
              Line(points={{60,100},{60,80},{57.6,80},{57.6,64.2}}, color={0,0,127}));
          connect(activeWallPipeBased.SolarRadiationPort,SolarRadiationPort_Hor)
            annotation (Line(points={{62,65.2},{62,84},{90,84},{90,110}}, color={255,
                  128,0}));
          connect(activeWallPipeBased.Heatport_TBA,Heatport_TBA)  annotation (Line(
                points={{57.6,55.8},{57.6,48},{80,48},{80,70},{100,70}},
                                                         color={191,0,0}));
          connect(Air_in,vol. ports[1]) annotation (Line(points={{100,0},{50,0},{50,-20},
                  {28,-20}},                           color={0,127,255}));
          connect(Air_out,vol. ports[2]) annotation (Line(points={{100,40},{50,40},{50,
                  -20},{32,-20}},          color={0,127,255}));
          connect(vol.heatPort,thermStar_Demux. therm) annotation (Line(points={{20,-10},
                  {-16.375,-10},{-16.375,-13.87}},
                                             color={191,0,0}));
          connect(vol.mWat_flow, mFlow_Water) annotation (Line(points={{18,-2},{-10,-2},
                  {-10,80},{-80,80},{-80,90},{-100,90}}, color={0,0,127}));
          connect(thermStar_Demux.therm, AddPower_System) annotation (Line(points={{
                  -16.375,-13.87},{-16.375,80},{-80,80},{-80,60},{-100,60}}, color={191,
                  0,0}));
          connect(temperatureSensor.T, measureBus.RoomTemp_Multipersonoffice)
            annotation (Line(points={{40,20},{50,20},{50,-52},{-50,-52},{-50,-59.9},{
                  -99.9,-59.9}},         color={0,0,127}));
          connect(vol.X_w, measureBus.X_Multipersonoffice) annotation (Line(points={{42,-14},
                  {50,-14},{50,-52},{-50,-52},{-50,-59.9},{-99.9,-59.9}},
                color={0,0,127}));
          connect(temperatureSensor.port, thermStar_Demux.therm) annotation (Line(
                points={{20,20},{-16.375,20},{-16.375,-13.87}},           color={191,0,
                  0}));
          connect(prescribedTemperature1.port, activeWallPipeBased.port_outside)
            annotation (Line(points={{36,80},{40,80},{40,64.2}},
                                                         color={191,0,0}));
          connect(prescribedTemperature1.T, measureBus.AirTemp) annotation (Line(points={{22.8,80},
                  {10,80},{10,48},{-50,48},{-50,-59.9},{-99.9,-59.9}},
                color={0,0,127}));
          connect(temperatureSensor1.port, thermStar_Demux.star) annotation (Line(
                points={{20,-40},{10,-40},{10,-13.48},{-2.75,-13.48}},
                                                               color={191,0,0}));
          connect(temperatureSensor1.T, measureBus.StrahlungTemp_Multipersonoffice)
            annotation (Line(points={{40,-40},{50,-40},{50,-52},{-50,-52},{-50,-59.9},{
                  -99.9,-59.9}},                       color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end BaseRoom;

        model Canteen_v2
          extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom(vol(V=
                  1800), activeWallPipeBased(wall_height=30, solar_absorptance=
                  0.24));
          Components.Walls.Wall Wall_ToOpenplanoffice(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            withSunblind=false,
            withDoor=false,
            wall_length=30,
            windowarea=60,
            outside=false,
            WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=180,
                origin={70,-30})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenplanoffice
            annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
          Components.Walls.Wall FloorToGround(
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            withDoor=false,
            outside=false,
            wall_length=30,
            wall_height=20,
            ISOrientation=2,
            WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=90,
                origin={50,-70})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Components.Walls.Wall SouthWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            withSunblind=false,
            withDoor=false,
            wall_length=20,
            windowarea=40,
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,24},{4.00002,-24}},
                rotation=90,
                origin={-50,-70})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=0,
                origin={-66,-88})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-10,-110})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
              Placement(transformation(
                extent={{12,-12},{-12,12}},
                rotation=-90,
                origin={-40,-100})));
          Components.Walls.Wall WestWallToWorkshop(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            outside=false,
            door_height=2.125,
            door_width=1,
            WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
            withDoor=false,
            wall_length=30,
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=0,
                origin={-70,0})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToWorkshop
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Components.Walls.Wall NorthWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            withSunblind=false,
            withDoor=false,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            T0(displayUnit="degC") = 293.15,
            wall_length=20,
            windowarea=40)
                       annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=-90,
                origin={-50,60})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
              Placement(transformation(
                extent={{-12,-12},{12,12}},
                rotation=-90,
                origin={-40,100})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-10,110})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature2
                                  annotation (Placement(transformation(
                extent={{6,-6},{-6,6}},
                rotation=180,
                origin={-66,90})));
        equation
          connect(Wall_ToOpenplanoffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{66,-30},{50,-30},{50,-52},{-10.125,-52},{-10.125,
                  -39.22}},
                color={191,0,0}));
          connect(Wall_ToOpenplanoffice.port_outside,HeatPort_ToOpenplanoffice)
            annotation (Line(points={{74.2,-30},{100,-30}},               color={191,0,
                  0}));
          connect(FloorToGround.port_outside,HeatPort_ToGround)
            annotation (Line(points={{50,-74.2},{50,-100}}, color={191,0,0}));
          connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{50,-66},{50,-52},{-10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
          connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
            annotation (Line(points={{-28,-75.2},{-28,-80},{-10,-80},{-10,-110}}, color=
                 {255,128,0}));
          connect(prescribedTemperature.port,SouthWall. port_outside)
            annotation (Line(points={{-60,-88},{-50,-88},{-50,-74.2}},
                                                             color={191,0,0}));
          connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{-73.2,
                  -88},{-80,-88},{-80,-59.9},{-99.9,-59.9}},
                                 color={0,0,127}));
          connect(SouthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
            annotation (Line(points={{-50,-66},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
          connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
                points={{-32.4,-74.2},{-32.4,-80},{-40,-80},{-40,-100}}, color={0,0,127}));
          connect(WestWallToWorkshop.port_outside,HeatPort_ToWorkshop)
            annotation (Line(points={{-74.2,0},{-100,0}}, color={191,0,0}));
          connect(WestWallToWorkshop.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-66,0},{-50,0},{-50,-52},{-10.125,-52},{-10.125,
                  -39.22}},
                color={191,0,0}));
          connect(NorthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
            annotation (Line(points={{-50,56},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                                 color={191,0,0}));
          connect(NorthWall.WindSpeedPort,WindSpeedPort_NorthWall)  annotation (Line(
                points={{-32.4,64.2},{-32.4,80},{-40,80},{-40,100}}, color={0,0,127}));
          connect(prescribedTemperature2.port, NorthWall.port_outside)
            annotation (Line(points={{-60,90},{-50,90},{-50,64.2}}, color={191,0,0}));
          connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points=
                 {{-73.2,90},{-80,90},{-80,80},{-10,80},{-10,48},{-50,48},{-50,-59.9},{-99.9,
                  -59.9}}, color={0,0,127}));
          connect(NorthWall.SolarRadiationPort,SolarRadiationPort_NorthWall)
            annotation (Line(points={{-28,65.2},{-28,80},{-10,80},{-10,110}},
                                                                            color={255,
                  128,0}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Canteen_v2;

        model Workshop_v2
          extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom(
              activeWallPipeBased(
              wall_length=30,
              wall_height=30,
              solar_absorptance=0.24,
              T0=288.15), vol(V=2700, T_start=288.15))
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
          Components.Walls.Wall WestWallToCanteen(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            outside=false,
            door_height=2.125,
            door_width=1,
            WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
            wall_length=30,
            withDoor=false,
            T0=288.15) annotation (Placement(transformation(
                extent={{3.99999,-24},{-4.00002,24}},
                rotation=0,
                origin={70,-30})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToCanteen
            annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
          Components.Walls.Wall SouthWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            withDoor=false,
            wall_length=30,
            T0=288.15) annotation (Placement(transformation(
                extent={{-3.99999,24},{4.00002,-24}},
                rotation=90,
                origin={-50,-70})));
          Components.Walls.Wall FloorToGround(
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            withDoor=false,
            outside=false,
            wall_length=30,
            ISOrientation=2,
            WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
            wall_height=30,
            T0=288.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=90,
                origin={50,-70})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature annotation (Placement(transformation(
                extent={{6,-6},{-6,6}},
                rotation=180,
                origin={-66,-88})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-10,-110})));
          Components.Walls.Wall NorthWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            windowarea=60,
            withSunblind=false,
            withDoor=false,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            wall_length=30,
            T0(displayUnit="degC") = 288.15)
                       annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=-90,
                origin={-50,60})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-10,110})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
              Placement(transformation(
                extent={{-12,-12},{12,12}},
                rotation=-90,
                origin={-40,100})));
          Components.Walls.Wall WestWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            withSunblind=false,
            withDoor=false,
            wall_length=30,
            windowarea=60,
            T0=288.15) annotation (Placement(transformation(
                extent={{3.99999,-24},{-4.00002,24}},
                rotation=180,
                origin={-70,0})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature2
                                  annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=0,
                origin={-90,30})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_WestWall annotation (
              Placement(transformation(
                extent={{12,-12},{-12,12}},
                rotation=180,
                origin={-100,0})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_WestWall annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-30})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature3
                                  annotation (Placement(transformation(
                extent={{6,-6},{-6,6}},
                rotation=180,
                origin={-66,90})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
              Placement(transformation(
                extent={{12,-12},{-12,12}},
                rotation=-90,
                origin={-40,-100})));
        equation
          connect(WestWallToCanteen.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{66,-30},{50,-30},{50,-52},{-10.125,-52},{-10.125,
                  -39.22}},color={191,0,0}));
          connect(HeatPort_ToCanteen,WestWallToCanteen. port_outside) annotation (Line(
                points={{100,-30},{74.2,-30}},                   color={191,0,0}));
          connect(FloorToGround.port_outside,HeatPort_ToGround)
            annotation (Line(points={{50,-74.2},{50,-100}}, color={191,0,0}));
          connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
            annotation (Line(points={{-28,-75.2},{-28,-80},{-10,-80},{-10,-110}}, color=
                 {255,128,0}));
          connect(SouthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
            annotation (Line(points={{-50,-66},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
          connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{50,-66},{50,-52},{-10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
          connect(prescribedTemperature.port,SouthWall. port_outside)
            annotation (Line(points={{-60,-88},{-50,-88},{-50,-74.2}},
                                                             color={191,0,0}));
          connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{-73.2,
                  -88},{-80,-88},{-80,-59.9},{-99.9,-59.9}},
                                                   color={0,0,127}));
          connect(NorthWall.SolarRadiationPort,SolarRadiationPort_NorthWall)
            annotation (Line(points={{-28,65.2},{-28,80},{-10,80},{-10,110}},
                                                                            color={255,
                  128,0}));
          connect(NorthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
            annotation (Line(points={{-50,56},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                                 color={191,0,0}));
          connect(NorthWall.WindSpeedPort,WindSpeedPort_NorthWall)  annotation (Line(
                points={{-32.4,64.2},{-32.4,80},{-40,80},{-40,100}}, color={0,0,127}));
          connect(WestWall.WindSpeedPort,WindSpeedPort_WestWall)  annotation (Line(
                points={{-74.2,-17.6},{-88,-17.6},{-88,4.44089e-16},{-100,4.44089e-16}},
                                                                         color={0,0,127}));
          connect(WestWall.SolarRadiationPort,SolarRadiationPort_WestWall)  annotation (
             Line(points={{-75.2,-22},{-90,-22},{-90,-30},{-110,-30}},
                                                                   color={255,128,0}));
          connect(WestWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
            annotation (Line(points={{-66,-4.44089e-16},{-50,-4.44089e-16},{-50,-52},{
                  -10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
          connect(prescribedTemperature2.port,WestWall. port_outside) annotation (Line(
                points={{-84,30},{-80,30},{-80,0},{-78,0},{-78,4.44089e-16},{-74.2,4.44089e-16}},
                                                              color={191,0,0}));
          connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points={{-97.2,
                  30},{-100,30},{-100,48},{-50,48},{-50,-59.9},{-99.9,-59.9}},
                color={0,0,127}));
          connect(prescribedTemperature3.T, measureBus.AirTemp) annotation (Line(points={{-73.2,
                  90},{-80,90},{-80,48},{-50,48},{-50,-60},{-80,-60},{-80,-59.9},{-99.9,
                  -59.9}}, color={0,0,127}));
          connect(NorthWall.port_outside, prescribedTemperature3.port)
            annotation (Line(points={{-50,64.2},{-50,90},{-60,90}}, color={191,0,0}));
          connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
                points={{-32.4,-74.2},{-32.4,-74},{-32,-74},{-32,-80},{-40,-80},{-40,-100}},
                                                                         color={0,0,127}));
        end Workshop_v2;

        model ConferenceRoom_v2
          extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom(vol(V=
                  150), activeWallPipeBased(wall_length=5, wall_height=10));
          Components.Walls.Wall FloorToWorkshop(
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            withDoor=false,
            outside=false,
            ISOrientation=2,
            wall_length=10,
            wall_height=5,
            WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=90,
                origin={-50,-70})));
          Components.Walls.Wall WestWallToOpenPlanOffice(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            outside=false,
            door_height=2.125,
            door_width=1,
            WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
            wall_length=20,
            withDoor=false,
            T0=293.15) annotation (Placement(transformation(
                extent={{3.99999,-24},{-4.00002,24}},
                rotation=-90,
                origin={50,-70})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenPlanOffice
            annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
          Components.Walls.Wall NorthWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            withSunblind=false,
            withDoor=false,
            wall_length=10,
            windowarea=20,
            T0=293.15) annotation (Placement(transformation(
                extent={{3.99999,24},{-4.00002,-24}},
                rotation=90,
                origin={-50,60})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
              Placement(transformation(
                extent={{12,12},{-12,-12}},
                rotation=90,
                origin={-32,100})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={-10,110})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature2
                                  annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=-90,
                origin={-50,90})));
        equation
          connect(FloorToWorkshop.port_outside,HeatPort_ToGround)  annotation (Line(
                points={{-50,-74.2},{-50,-100}},
                color={191,0,0}));
          connect(FloorToWorkshop.thermStarComb_inside,thermStar_Demux. thermStarComb)
            annotation (Line(points={{-50,-66},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
          connect(WestWallToOpenPlanOffice.port_outside,HeatPort_ToOpenPlanOffice)
            annotation (Line(points={{50,-74.2},{50,-100}}, color={191,0,0}));
          connect(WestWallToOpenPlanOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{50,-66},{50,-52},{-10.125,-52},{-10.125,-39.22}},
                           color={191,0,0}));
          connect(NorthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-50,56},{-50,-40},{-10.125,-40},{-10.125,-39.22}},
                color={191,0,0}));
          connect(prescribedTemperature2.port,NorthWall. port_outside)
            annotation (Line(points={{-50,84},{-50,64.2}}, color={191,0,0}));
          connect(NorthWall.WindSpeedPort, WindSpeedPort_NorthWall) annotation (Line(
                points={{-32.4,64.2},{-32.4,80},{-32,80},{-32,100}}, color={0,0,127}));
          connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points={{-50,
                  97.2},{-50,98},{-60,98},{-60,80},{-10,80},{-10,48},{-50,48},{-50,
                  -59.9},{-99.9,-59.9}},
                color={0,0,127}));
          connect(NorthWall.SolarRadiationPort, SolarRadiationPort_NorthWall)
            annotation (Line(points={{-28,65.2},{-28,80},{-10,80},{-10,110}},
                                          color={255,128,0}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end ConferenceRoom_v2;

        model MultiPersonOffice_v2
          extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
          Components.Walls.Wall EastWallToOpenPlanOffice(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            outside=false,
            door_height=2.125,
            door_width=1,
            WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
            withDoor=false,
            wall_length=30,
            T0=293.15) annotation (Placement(transformation(
                extent={{3.99999,-24},{-4.00002,24}},
                rotation=0,
                origin={80,-30})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenPlanOffice
            annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
          Components.Walls.Wall SouthWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            withSunblind=false,
            withDoor=false,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            T0(displayUnit="degC") = 293.15,
            wall_length=20,
            windowarea=40)
                       annotation (Placement(transformation(
                extent={{3.99999,-24},{-4.00002,24}},
                rotation=-90,
                origin={50,-70})));
          Components.Walls.Wall FloorToGround(
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            withDoor=false,
            outside=false,
            ISOrientation=2,
            wall_length=20,
            wall_height=5,
            WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=90,
                origin={-50,-70})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=0,
                origin={14,-80})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
            annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
              Placement(transformation(
                extent={{12,-12},{-12,12}},
                rotation=-90,
                origin={60,-100})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=-90,
                origin={90,-110})));
        equation
          connect(EastWallToOpenPlanOffice.port_outside,HeatPort_ToOpenPlanOffice)
            annotation (Line(points={{84.2,-30},{100,-30}},
                                                          color={191,0,0}));
          connect(EastWallToOpenPlanOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{76,-30},{50,-30},{50,-52},{-10.125,-52},{-10.125,
                  -39.22}},            color={191,0,0}));
          connect(FloorToGround.port_outside,HeatPort_ToGround)
            annotation (Line(points={{-50,-74.2},{-50,-100}}, color={191,0,0}));
          connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
            annotation (Line(points={{72,-75.2},{72,-80},{90,-80},{90,-110}},
                                                                            color={255,
                  128,0}));
          connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
                points={{67.6,-74.2},{67.6,-80},{60,-80},{60,-100}}, color={0,0,127}));
          connect(prescribedTemperature.port,SouthWall. port_outside)
            annotation (Line(points={{20,-80},{50,-80},{50,-74.2}},
                                                           color={191,0,0}));
          connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{6.8,-80},
                  {0,-80},{0,-52},{-50,-52},{-50,-59.9},{-99.9,-59.9}},
                           color={0,0,127}));
          connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-50,-66},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
          connect(SouthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{50,-66},{50,-52},{-10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
        end MultiPersonOffice_v2;

        model OpenPlanOffice_v2
          extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom(vol(V=
                  4050), activeWallPipeBased(wall_length=45, wall_height=30));
          Components.Walls.Wall FloorToGround(
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            withDoor=false,
            outside=false,
            wall_length=30,
            ISOrientation=2,
            wall_height=45,
            WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=90,
                origin={14,-80})));
          Components.Walls.Wall WestWallToMultiPersonOffice(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            outside=false,
            door_height=2.125,
            door_width=1,
            WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
            withDoor=false,
            wall_length=30,
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=90,
                origin={70,-80})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
            annotation (Placement(transformation(extent={{4,-110},{24,-90}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
            HeatPort_ToMultiPersonOffice
            annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
          Components.Walls.Wall EastWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            withSunblind=false,
            withDoor=false,
            wall_length=30,
            windowarea=60,
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=180,
                origin={70,-40})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature3
                                  annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=270,
                origin={82,-20})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_EastWall annotation (
              Placement(transformation(
                extent={{-12,-12},{12,12}},
                rotation=180,
                origin={100,-40})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_EastWall annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,-70})));
          Components.Walls.Wall WestWallToConferenceRoom(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            outside=false,
            door_height=2.125,
            door_width=1,
            WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
            withDoor=false,
            wall_length=20,
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=0,
                origin={-70,20})));
          Components.Walls.Wall WestWallToConferenceRoom1(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            windowarea=60,
            withSunblind=false,
            outside=false,
            door_height=2.125,
            door_width=1,
            WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
            withDoor=false,
            wall_length=30,
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=0,
                origin={-70,-30})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToConferenceRoom
            annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToCanteen
            annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
          Components.Walls.Wall SouthWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            withSunblind=false,
            withDoor=false,
            wall_length=30,
            windowarea=60,
            T0=293.15) annotation (Placement(transformation(
                extent={{-3.99999,24},{4.00002,-24}},
                rotation=90,
                origin={-50,-70})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature2
                                  annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=0,
                origin={-66,-88})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
              Placement(transformation(
                extent={{12,-12},{-12,12}},
                rotation=-90,
                origin={-40,-100})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-10,-110})));
          Components.Walls.Wall NorthWall(
            wall_height=3,
            solar_absorptance=0.48,
            withWindow=true,
            withSunblind=false,
            withDoor=false,
            WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
            T0(displayUnit="degC") = 293.15,
            wall_length=40,
            windowarea=80,
            Model=1)   annotation (Placement(transformation(
                extent={{-3.99999,-24},{4.00002,24}},
                rotation=-90,
                origin={-50,60})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
              Placement(transformation(
                extent={{-12,-12},{12,12}},
                rotation=-90,
                origin={-40,100})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-10,110})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=0,
                origin={-66,90})));
        equation
          connect(FloorToGround.port_outside,HeatPort_ToGround)
            annotation (Line(points={{14,-84.2},{14,-100}}, color={191,0,0}));
          connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{14,-76},{14,-52},{-10.125,-52},{-10.125,-39.22}},
                color={191,0,0}));
          connect(WestWallToMultiPersonOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{70,-76},{60,-76},{60,-60},{50,-60},{50,-52},{-10,
                  -52},{-10,-44},{-10.125,-44},{-10.125,-39.22}},
                                  color={191,0,0}));
          connect(WestWallToMultiPersonOffice.port_outside,HeatPort_ToMultiPersonOffice)
            annotation (Line(points={{70,-84.2},{70,-100}}, color={191,0,0}));
          connect(EastWall.WindSpeedPort, WindSpeedPort_EastWall) annotation (Line(
                points={{74.2,-57.6},{76,-57.6},{76,-58},{100,-58},{100,-40}},
                                                                         color={0,0,127}));
          connect(EastWall.SolarRadiationPort, SolarRadiationPort_EastWall) annotation (
             Line(points={{75.2,-62},{90,-62},{90,-70},{110,-70}}, color={255,128,0}));
          connect(EastWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{66,-40},{50,-40},{50,-52},{-10,-52},{-10,-46},{
                  -10.125,-46},{-10.125,-39.22}},
                color={191,0,0}));
          connect(prescribedTemperature3.port,EastWall. port_outside)
            annotation (Line(points={{82,-26},{82,-40},{74.2,-40}},
                                                       color={191,0,0}));
          connect(prescribedTemperature3.T, measureBus.AirTemp) annotation (Line(points={{82,
                  -12.8},{82,0},{50,0},{50,-52},{-50,-52},{-50,-59.9},{-99.9,-59.9}},
                                                                                 color=
                  {0,0,127}));
          connect(WestWallToConferenceRoom.port_outside,HeatPort_ToConferenceRoom)
            annotation (Line(points={{-74.2,20},{-100,20}},   color={191,0,0}));
          connect(WestWallToConferenceRoom.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-66,20},{-50,20},{-50,-52},{-10.125,-52},{-10.125,
                  -39.22}},color={191,0,0}));
          connect(WestWallToConferenceRoom1.port_outside,HeatPort_ToCanteen)
            annotation (Line(points={{-74.2,-30},{-100,-30}},
                               color={191,0,0}));
          connect(WestWallToConferenceRoom1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-66,-30},{-50,-30},{-50,-52},{-10.125,-52},{
                  -10.125,-39.22}},
                           color={191,0,0}));
          connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
                points={{-32.4,-74.2},{-32.4,-80},{-40,-80},{-40,-100}}, color={0,0,127}));
          connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
            annotation (Line(points={{-28,-75.2},{-28,-92},{-10,-92},{-10,-110}}, color=
                 {255,128,0}));
          connect(prescribedTemperature2.port,SouthWall. port_outside)
            annotation (Line(points={{-60,-88},{-50,-88},{-50,-74.2}},
                                                             color={191,0,0}));
          connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points={{-73.2,
                  -88},{-80,-88},{-80,-59.9},{-99.9,-59.9}},
                                 color={0,0,127}));
          connect(SouthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-50,-66},{-50,-52},{-10,-52},{-10,-40},{-10.125,
                  -40},{-10.125,-39.22}},
                                     color={191,0,0}));
          connect(NorthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-50,56},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                                 color={191,0,0}));
          connect(NorthWall.WindSpeedPort, WindSpeedPort_NorthWall) annotation (Line(
                points={{-32.4,64.2},{-32.4,80},{-40,80},{-40,100}}, color={0,0,127}));
          connect(prescribedTemperature.port,NorthWall. port_outside)
            annotation (Line(points={{-60,90},{-50,90},{-50,64.2}},
                                                           color={191,0,0}));
          connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={
                  {-73.2,90},{-80,90},{-80,80},{-10,80},{-10,48},{-50,48},{-50,-59.9},{-99.9,
                  -59.9}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{-6,3},{-6,3}},
              horizontalAlignment=TextAlignment.Right));
          connect(NorthWall.SolarRadiationPort, SolarRadiationPort_NorthWall)
            annotation (Line(points={{-28,65.2},{-28,80},{-10,80},{-10,110}},
                                                                            color={255,
                  128,0}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end OpenPlanOffice_v2;

        model WallTemp

          parameter Real AngeFactor=0 annotation(Dialog(tab = "General"));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation=0,    origin={-46,0})));
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
            annotation (Placement(transformation(extent={{-6,-4},{14,16}})));
          Utilities.Interfaces.HeatStarComb thermStarComb1
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Blocks.Math.Gain gain(k=AngeFactor)
            annotation (Placement(transformation(extent={{34,-2},{50,14}})));
          Modelica.Blocks.Interfaces.RealOutput WallTempWithFactor
            "Output signal connector"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        equation
          connect(thermStar_Demux.therm, temperatureSensor.port)
            annotation (Line(points={{-35.9,5.1},{-6,5.1},{-6,6}}, color={191,0,0}));
          connect(thermStar_Demux.thermStarComb, thermStarComb1) annotation (Line(
                points={{-55.4,0.1},{-100,0.1},{-100,0}}, color={191,0,0}));
          connect(temperatureSensor.T, gain.u)
            annotation (Line(points={{14,6},{32.4,6}}, color={0,0,127}));
          connect(gain.y, WallTempWithFactor) annotation (Line(points={{50.8,6},{74,6},
                  {74,0},{100,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end WallTemp;
      end Rooms;
    end Building;

    model testmodel
      Modelica.Blocks.Math.Sum K_Investition
        annotation (Placement(transformation(extent={{40,10},{60,30}})));
      Modelica.Blocks.Math.Sum K_Betrieb
        annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
      Modelica.Blocks.Math.MultiSum multiSum(nu=2)
        annotation (Placement(transformation(extent={{74,-6},{86,6}})));
        constant real q;
        constant real i; //Zinssatz

      Modelica.Blocks.Math.Sum K_Energiebezug
        annotation (Placement(transformation(extent={{-2,-94},{18,-74}})));
    equation
      connect(K_Betrieb.y, multiSum.u[1]) annotation (Line(points={{61,-20},{68,-20},
              {68,2.1},{74,2.1}}, color={0,0,127}));
      connect(K_Investition.y, multiSum.u[2]) annotation (Line(points={{61,20},{66,20},
              {66,-2.1},{74,-2.1}}, color={0,0,127}));
              i=0.05;
              q=1+i;

      connect(K_Energiebezug.y, K_Betrieb.u[1]) annotation (Line(points={{19,-84},{
              28,-84},{28,-20},{38,-20}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end testmodel;
  end Model;

  model Benchmark
    extends AixLib.Systems.Benchmark.Model.BusSystems.Logger;
    Model.FullModel_v4 fullModel_v4_1
      annotation (Placement(transformation(extent={{20,-20},{60,20}})));
    ControlStrategies.Controller.Controller_NoChpAndBoiler
      controller_NoChpAndBoiler
      annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
  equation
    connect(controller_NoChpAndBoiler.measureBus, fullModel_v4_1.Measure)
      annotation (Line(
        points={{-14,2},{2,2},{2,4},{20,4}},
        color={255,204,51},
        thickness=0.5));
    connect(controller_NoChpAndBoiler.controlBus, fullModel_v4_1.Control)
      annotation (Line(
        points={{-14,-2},{4,-2},{4,-4},{20,-4}},
        color={255,204,51},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      __Dymola_selections);
  end Benchmark;

  package BenchmarkModel_reworked_TestModularization
    extends Modelica.Icons.ExamplesPackage;
    model HighOrder_ASHRAE140_SouthFacingWindows "windows facing south"

      parameter Modelica.SIunits.Length Room_Lenght={30,30,5,5,30}
                                                      "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Height Room_Height={3,3,3,3,3}
                                                        "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
      parameter Modelica.SIunits.Length Room_Width={20,30,10,20,50}
                                                     "width"
                                                            annotation (Dialog(group = "Dimensions", descriptionLabel = true));

      parameter Modelica.SIunits.Area Win_Area={40,1,1,1,1}
                                                   "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));

      parameter Modelica.SIunits.Temperature T0=295.15 "Outside"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_IW=295.15 "IW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_CE=295.15 "Ceiling"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_FL=295.15 "Floor"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
      parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
                                                                annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

      parameter Real solar_absorptance_OW = 0.6 "Solar absoptance outer walls " annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Real eps_out=0.9 "emissivity of the outer surface"
                                           annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypOW=
          AixLib.DataBase.Walls.ASHRAE140.OW_Case600()
        "choose an external wall type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypCE=
          AixLib.DataBase.Walls.ASHRAE140.RO_Case600() "choose a ceiling type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
      parameter DataBase.Walls.WallBaseDataDefinition TypFL=
         AixLib.DataBase.Walls.ASHRAE140.FL_Case600() "choose a floor type "
        annotation (Dialog(group="Wall Types"), choicesAllMatching=true);

      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Win=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140()
        "choose a Window type" annotation(Dialog(group="Windows"),choicesAllMatching= true);

    protected
      parameter Modelica.SIunits.Volume Room_V=Room_Lenght*Room_Height*Room_Width;

    public
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_South(
        withDoor=false,
        WallType=TypOW,
        T0=T0_OW,
        wall_length=Room_Width,
        solar_absorptance=solar_absorptance_OW,
        Model=2,
        outside=true,
        withWindow=true,
        windowarea=Win_Area,
        wall_height=Room_Height,
        surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
        WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140())
        annotation (Placement(transformation(extent={{-76,-36},{-62,44}})));
      AixLib.Building.Components.Walls.Wall_ASHRAE140 outerWall_West(
        wall_length=Room_Lenght,
        wall_height=Room_Height,
        withDoor=false,
        T0=T0_IW,
        outside=true,
        WallType=TypOW,
        solar_absorptance=solar_absorptance_OW,
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
        Model=2) annotation (Placement(transformation(
            extent={{-4,-24},{4,24}},
            rotation=-90,
            origin={26,78})));
      AixLib.Building.Components.Walls.Wall_ASHRAE140 outerWall_East(
        wall_length=Room_Lenght,
        wall_height=Room_Height,
        T0=T0_IW,
        outside=true,
        WallType=TypOW,
        solar_absorptance=solar_absorptance_OW,
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
        Model=2) annotation (Placement(transformation(
            extent={{-4.00001,-24},{4.00001,24}},
            rotation=90,
            origin={26,-64})));
      AixLib.Building.Components.Walls.Wall_ASHRAE140 outerWall_North(
        wall_height=Room_Height,
        U_door=5.25,
        door_height=1,
        door_width=2,
        withDoor=false,
        T0=T0_IW,
        wall_length=Room_Width,
        outside=true,
        WallType=TypOW,
        solar_absorptance=solar_absorptance_OW,
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
        Model=2) annotation (Placement(transformation(extent={{74,-36},{60,44}})));
      AixLib.Building.Components.Walls.Wall_ASHRAE140 ceiling(
        wall_length=Room_Lenght,
        wall_height=Room_Width,
        ISOrientation=3,
        withDoor=false,
        T0=T0_CE,
        WallType=TypCE,
        outside=true,
        solar_absorptance=solar_absorptance_OW,
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
        Model=2) annotation (Placement(transformation(
            extent={{-2,-12},{2,12}},
            rotation=270,
            origin={-32,78})));
      AixLib.Building.Components.Walls.Wall_ASHRAE140 floor(
        wall_length=Room_Lenght,
        wall_height=Room_Width,
        withDoor=false,
        ISOrientation=2,
        T0=T0_FL,
        WallType=TypFL,
        solar_absorptance=solar_absorptance_OW,
        outside=false,
        Model=2) annotation (Placement(transformation(
            extent={{-2.00031,-12},{2.00003,12}},
            rotation=90,
            origin={-32,-64})));
      Components.DryAir.Airload
                           airload(
        V=Room_V,
        c=1005) annotation (Placement(transformation(extent={{10,-18},{28,0}})));
      Utilities.Interfaces.Adaptors.ConvRadToCombPort
                                                 thermStar_Demux annotation (
          Placement(transformation(
            extent={{-10,8},{10,-8}},
            rotation=90,
            origin={-32,-32})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{32,-34},{42,-24}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
        annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_outside
        annotation (Placement(transformation(extent={{-110,92},{-100,102}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort
        annotation (Placement(transformation(extent={{-120,20},{-104,36}}),
            iconTransformation(extent={{-120,20},{-100,40}})));
    public
      Utilities.Interfaces.Star
                              starRoom
        annotation (Placement(transformation(extent={{0,18},{18,34}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
        annotation (Placement(transformation(extent={{-36,16},{-22,30}})));
      Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
        annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
      Components.DryAir.VarAirExchange varAirExchange(
        V=Room_V,
        c=airload.c,
        rho=airload.rho)
        annotation (Placement(transformation(extent={{-82,-66},{-62,-46}})));
      Modelica.Blocks.Interfaces.RealInput AER "Air exchange rate "
        annotation (Placement(transformation(extent={{-122,-62},{-100,-40}}),
            iconTransformation(extent={{-120,-60},{-100,-40}})));
    equation
      connect(thermStar_Demux.star, starRoom) annotation (Line(
          points={{-26.2,-21.6},{-26.2,0.2},{9,0.2},{9,26}},
          color={95,95,95},
          pattern=LinePattern.Solid));
      connect(thermStar_Demux.therm, thermRoom) annotation (Line(
          points={{-37.1,-21.9},{-37.1,-0.95},{-29,-0.95},{-29,23}},
          color={191,0,0}));
      connect(varAirExchange.InPort1, AER) annotation (Line(
          points={{-81,-62.4},{-111,-62.4},{-111,-51}},
          color={0,0,127}));
      connect(outerWall_South.port_outside, Therm_outside) annotation (Line(
          points={{-76.35,4},{-86,4},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(floor.port_outside, Therm_ground) annotation (Line(
          points={{-32,-66.1003},{-32,-96}},
          color={191,0,0}));
      connect(outerWall_East.port_outside, Therm_outside) annotation (Line(
          points={{26,-68.2},{26,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_North.port_outside, Therm_outside) annotation (Line(
          points={{74.35,4},{82,4},{82,-80},{-86,-80},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_West.port_outside, Therm_outside) annotation (Line(
          points={{26,82.2},{26,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-76.35,33.3333},{-86,33.3333},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(outerWall_South.thermStarComb_inside, thermStar_Demux.thermStarComb)
        annotation (Line(
          points={{-62,4},{-54,4},{-54,-56},{-32.1,-56},{-32.1,-41.4}},
          color={191,0,0}));
      connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
        annotation (Line(
          points={{-32,-62},{-32,-41.4},{-32.1,-41.4}},
          color={191,0,0}));
      connect(outerWall_East.thermStarComb_inside, thermStar_Demux.thermStarComb)
        annotation (Line(
          points={{26,-60},{28,-60},{28,-56},{-32.1,-56},{-32.1,-41.4}},
          color={191,0,0}));
      connect(outerWall_North.thermStarComb_inside, thermStar_Demux.thermStarComb)
        annotation (Line(
          points={{60,4},{46,4},{46,-56},{-32.1,-56},{-32.1,-41.4}},
          color={191,0,0}));
      connect(outerWall_West.thermStarComb_inside, thermStar_Demux.thermStarComb)
        annotation (Line(
          points={{26,74},{26,60},{46,60},{46,-56},{-32.1,-56},{-32.1,-41.4}},
          color={191,0,0}));
      connect(ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
        annotation (Line(
          points={{-32,76},{-32,60},{46,60},{46,-56},{-32.1,-56},{-32.1,-41.4}},
          color={191,0,0}));
      connect(ceiling.port_outside, Therm_outside) annotation (Line(
          points={{-32,80.1},{-32,88},{-86,88},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(outerWall_East.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{8.4,-68.2},{8.4,-80},{-86,-80},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{-23.2,80.1},{-23.2,88},{-86,88},{-86,28},{-112,28}},
          color={0,0,127}));
      connect(outerWall_North.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{74.35,33.3333},{82,33.3333},{82,-80},{-86,-80},{-86,28},{-112,28}},
          color={0,0,127}));

      connect(outerWall_West.WindSpeedPort, WindSpeedPort) annotation (Line(
          points={{43.6,82.2},{43.6,88},{-86,88},{-86,28},{-112,28}},
          color={0,0,127}));

      connect(outerWall_South.solarRadWinTrans, floor.solarRadWin) annotation (Line(
          points={{-60.25,-16.6667},{-54,-16.6667},{-54,-56},{-40.8,-56},{-40.8,-61.8}},
          color={0,0,127}));

      connect(outerWall_South.solarRadWinTrans, outerWall_East.solarRadWin)
        annotation (Line(
          points={{-60.25,-16.6667},{-54,-16.6667},{-54,-56},{8.4,-56},{8.4,-59.6}},
          color={0,0,127}));

      connect(outerWall_South.solarRadWinTrans, outerWall_South.solarRadWin)
        annotation (Line(
          points={{-60.25,-16.6667},{-54,-16.6667},{-54,33.3333},{-61.3,33.3333}},
          color={0,0,127}));

      connect(outerWall_South.solarRadWinTrans, ceiling.solarRadWin) annotation (
          Line(
          points={{-60.25,-16.6667},{-54,-16.6667},{-54,60},{-23.2,60},{-23.2,75.8}},
          color={0,0,127}));

      connect(outerWall_North.solarRadWin, outerWall_South.solarRadWinTrans)
        annotation (Line(
          points={{59.3,33.3333},{46,33.3333},{46,60},{-54,60},{-54,-16.6667},{-60.25,
              -16.6667}},
          color={0,0,127}));
      connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
        annotation (Line(
          points={{-110,60},{-86,60},{-86,40.6667},{-78.1,40.6667}},
          color={255,128,0}));
      connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (
          Line(
          points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}},
          color={255,128,0}));
      connect(outerWall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (
         Line(
          points={{48,83.2},{48,88},{-86,88},{-86,64},{-110,64}},
          color={255,128,0}));
      connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
        annotation (Line(
          points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,52}},
          color={255,128,0}));

      connect(outerWall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (
         Line(
          points={{4,-69.2},{4,-80},{-86,-80},{-86,56},{-110,56}},
          color={255,128,0}));
      connect(outerWall_South.solarRadWinTrans, outerWall_West.solarRadWin)
        annotation (Line(
          points={{-60.25,-16.6667},{-54,-16.6667},{-54,60},{43.6,60},{43.6,73.6}},
          color={0,0,127}));
      connect(varAirExchange.port_a, Therm_outside) annotation (Line(
          points={{-82,-56},{-86,-56},{-86,97},{-105,97}},
          color={191,0,0}));
      connect(thermStar_Demux.therm, airload.port) annotation (Line(
          points={{-37.1,-21.9},{-37.1,-10.8},{10.9,-10.8}},
          color={191,0,0}));
      connect(airload.port, temperatureSensor.port) annotation (Line(
          points={{10.9,-10.8},{4,-10.8},{4,-29},{32,-29}},
          color={191,0,0}));
      connect(varAirExchange.port_b, airload.port) annotation (Line(
          points={{-62,-56},{4,-56},{4,-10.8},{10.9,-10.8}},
          color={191,0,0}));
      annotation ( Icon(coordinateSystem(extent={{-100,-100},
                {100,100}}, preserveAspectRatio=false),
                                          graphics={
            Rectangle(
              extent={{-100,92},{94,-92}},
              lineColor={215,215,215},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-86,76},{80,-80}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,26},{-86,-34}},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-22,12},{22,-12}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Window",
              textStyle={TextStyle.Bold},
              origin={-94,-2},
              rotation=90),
            Text(
              extent={{-54,-54},{54,-76}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="Length"),
            Text(
              extent={{-22,11},{22,-11}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              textString="width",
              origin={65,0},
              rotation=90)}),
        Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",    info="<html>
</html>"));
    end HighOrder_ASHRAE140_SouthFacingWindows;

    model ReducedOrder_FourElements "Thermal Zone with four elements for exterior walls,
  interior walls, floor plate and roof"
      extends ThermalZones.ReducedOrder.RC.ThreeElements(AArray={ATotExt,ATotWin,
            AInt,AFloor,ARoof});

      parameter Modelica.SIunits.Area ARoof "Area of roof"
        annotation(Dialog(group="Roof"));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer hConvRoof "Convective coefficient of heat transfer of roof (indoor)"
        annotation(Dialog(group="Roof"));
      parameter Integer nRoof(min = 1) "Number of RC-elements of roof"
        annotation(Dialog(group="Roof"));
      parameter Modelica.SIunits.ThermalResistance RRoof[nExt](
        each min=Modelica.Constants.small)
        "Vector of resistances of roof, from inside to outside"
        annotation(Dialog(group="Roof"));
      parameter Modelica.SIunits.ThermalResistance RRoofRem(
        min=Modelica.Constants.small)
        "Resistance of remaining resistor RRoofRem between capacity n and outside"
        annotation(Dialog(group="Roof"));
      parameter Modelica.SIunits.HeatCapacity CRoof[nExt](
        each min=Modelica.Constants.small)
        "Vector of heat capacities of roof, from inside to outside"
        annotation(Dialog(group="Roof"));
      parameter Boolean indoorPortRoof = false
        "Additional heat port at indoor surface of roof"
        annotation(Dialog(group="Roof"),choices(checkBox = true));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roof if ARoof > 0
        "Ambient port for roof"
          annotation (Placement(transformation(extent={{-21,170},{-1,190}}),
                           iconTransformation(extent={{-21,170},{-1,190}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roofIndoorSurface if
         indoorPortRoof "Auxiliary port at indoor surface of roof"
          annotation (Placement(
          transformation(extent={{-50,-190},{-30,-170}}), iconTransformation(
          extent={{-50,-190},{-30,-170}})));
      ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWall roofRC(
        final RExt=RRoof,
        final RExtRem=RRoofRem,
        final CExt=CRoof,
        final n=nRoof,
        final T_start=T_start) if ARoof > 0 "RC-element for roof" annotation (
          Placement(transformation(
            extent={{-10,-11},{10,11}},
            rotation=90,
            origin={-12,155})));

    protected
      Modelica.Thermal.HeatTransfer.Components.Convection convRoof if
         ARoof > 0 "Convective heat transfer of roof"
        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-12,120})));
      Modelica.Blocks.Sources.Constant hConvRoof_const(final k=ARoof*hConvRoof) "Coefficient of convective heat transfer for roof"
         annotation (Placement(transformation(extent={{-5,-5},{5,5}}, rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor resIntRoof(final G=min(AInt, ARoof)*hRad) if AInt > 0 and ARoof > 0
        "Resistor between interior walls and roof"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={186,10})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor resRoofWin(final G=min(ARoof, ATotWin)*hRad) if ARoof > 0 and ATotWin > 0
        "Resistor between roof and windows" annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-154,100})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor resRoofFloor(final G=min(ARoof, AFloor)*hRad) if ARoof > 0 and AFloor > 0
        "Resistor between floor plate and roof"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-56,-112})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor resExtWallRoof(final G=min(ATotExt, ARoof)*hRad) if ATotExt > 0 and ARoof > 0
        "Resistor between exterior walls and roof" annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-108,6})));

    equation
      connect(convRoof.solid, roofRC.port_a)
        annotation (Line(points={{-12,130},{-12,138},{-12,145},{-11,145}},
                                                         color={191,0,0}));
      connect(roofRC.port_b, roof)
        annotation (Line(points={{-11,165},{-11,168},{-11,180}},
                                                         color={191,0,0}));
      connect(resRoofWin.port_a, convWin.solid)
        annotation (Line(points={{-164,100},{-174,100},{-174,82},{-146,82},{-146,40},
              {-116,40}},                                         color={191,
        0,0}));
      connect(resRoofWin.port_b, convRoof.solid)
        annotation (Line(points={{-144,100},
        {-114,100},{-82,100},{-82,132},{-12,132},{-12,130}}, color={191,0,0}));
      connect(resRoofFloor.port_a, convRoof.solid)
        annotation (Line(points={{-56,-102},
        {-54,-102},{-54,132},{-12,132},{-12,130}}, color={191,0,0}));
      connect(resRoofFloor.port_b, resExtWallFloor.port_b)
        annotation (Line(
        points={{-56,-122},{-56,-132},{-144,-132},{-144,-121}}, color={191,0,0}));
      connect(resIntRoof.port_b, intWallRC.port_a)
        annotation (Line(points={{186,0},{186,-10},{168,-10},{168,-40},{182,-40}},
                                                   color={191,0,0}));
      connect(resIntRoof.port_a, convRoof.solid)
        annotation (Line(points={{186,20},
        {186,20},{186,132},{-12,132},{-12,130}}, color={191,0,0}));
      connect(resExtWallRoof.port_a, convExtWall.solid)
        annotation (Line(points={{-118,6},{-130,6},{-130,-12},{-144,-12},{-144,-40},
              {-114,-40}},                                        color={191,
        0,0}));
      connect(resExtWallRoof.port_b, convRoof.solid)
        annotation (Line(points={{-98,
        6},{-54,6},{-54,132},{-12,132},{-12,130}}, color={191,0,0}));
      if not ATotExt > 0 and not ATotWin > 0 and not AInt > 0 and not AFloor > 0
        and ARoof > 0 then
        connect(thermSplitterIntGains.portOut[1], roofRC.port_a);
        connect(roofRC.port_a, thermSplitterSolRad.portOut[1]);
      elseif ATotExt > 0 and not ATotWin > 0 and not AInt > 0 and not AFloor > 0
        and ARoof > 0
         or not ATotExt > 0 and ATotWin > 0 and not AInt > 0 and not AFloor > 0
         and ARoof > 0
         or not ATotExt > 0 and not ATotWin > 0 and AInt > 0 and not AFloor > 0
         and ARoof > 0
         or not ATotExt > 0 and not ATotWin > 0 and not AInt > 0 and AFloor > 0
         and ARoof > 0 then
        connect(thermSplitterIntGains.portOut[2], roofRC.port_a);
        connect(roofRC.port_a, thermSplitterSolRad.portOut[2]);
      elseif ATotExt > 0 and ATotWin > 0 and not AInt > 0 and not AFloor > 0 and ARoof > 0
         or ATotExt > 0 and not ATotWin > 0 and AInt > 0 and not AFloor > 0 and ARoof > 0
         or ATotExt > 0 and not ATotWin > 0 and not AInt > 0 and AFloor > 0 and ARoof > 0
         or not ATotExt > 0 and ATotWin > 0 and AInt > 0 and not AFloor > 0 and ARoof > 0
         or not ATotExt > 0 and ATotWin > 0 and not AInt > 0 and AFloor > 0 and ARoof > 0
         or not ATotExt > 0 and not ATotWin > 0 and AInt > 0 and AFloor > 0
         and ARoof > 0 then
        connect(thermSplitterIntGains.portOut[3], roofRC.port_a);
        connect(roofRC.port_a, thermSplitterSolRad.portOut[3]);
      elseif not ATotExt > 0 and ATotWin > 0 and AInt > 0 and AFloor > 0 and ARoof > 0
         or ATotExt > 0 and not ATotWin > 0 and AInt > 0 and AFloor > 0 and ARoof > 0
         or ATotExt > 0 and ATotWin > 0 and not AInt > 0 and AFloor > 0 and ARoof > 0
         or ATotExt > 0 and ATotWin > 0 and AInt > 0 and not AFloor > 0 and ARoof > 0 then
        connect(thermSplitterIntGains.portOut[4], roofRC.port_a);
        connect(roofRC.port_a, thermSplitterSolRad.portOut[4]);
      elseif ATotExt > 0 and ATotWin > 0 and AInt > 0 and AFloor > 0 and ARoof > 0 then
        connect(thermSplitterSolRad.portOut[5], roofRC.port_a)
        annotation (Line(
        points={{-122,146},{-122,146},{-38,146},{-38,142},{-11,142},{-11,145}},
        color={191,0,0}));
        connect(thermSplitterIntGains.portOut[5], roofRC.port_a)
        annotation (Line(points={{190,86},{190,86},{190,138},{-11,138},{-11,145}},
        color={191,0,0}));
      end if;
      connect(hConvRoof_const.y, convRoof.Gc) annotation (Line(points={{-5.5,0},{-2,0},{-2,120}}, color={0,0,127}));
      connect(convRoof.fluid, senTAir.port)
        annotation (Line(points={{-12,110},{-12,110},{-12,96},{66,96},{66,0},{80,0}},
                                                     color={191,0,0}));
      connect(roofRC.port_a, roofIndoorSurface)
        annotation (Line(points={{-11,145},{-11,136},{-112,136},{-112,112},{-216,
              112},{-216,-140},{-40,-140},{-40,-180}},
        color={191,0,0}));
      annotation (defaultComponentName="theZon",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-240,
      -180},{240,180}}), graphics={
      Rectangle(
        extent={{-36,170},{46,104}},
        lineColor={0,0,255},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{16,168},{46,156}},
        lineColor={0,0,255},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid,
        textString="Roof")}),
        Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-240,-180},{240,180}}),
      graphics={Rectangle(
      extent={{-40,50},{28,-44}},
      pattern=LinePattern.None,
      fillColor={230,230,230},
      fillPattern=FillPattern.Solid), Text(
      extent={{-60,60},{64,-64}},
      lineColor={0,0,0},
      textString="4")}),
      Documentation(revisions="<html><ul>
  <li>August 31, 2018 by Moritz Lauster:<br/>
    Updated schema in documentation and fixes orientation and
    connections of roofRC for <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/997\">issue 997</a>.
  </li>
  <li>September 11, 2015 by Moritz Lauster:<br/>
    First Implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  This model adds another element for the roof. Roofs commonly exhibit
  the same excitations as exterior walls but have different
  coefficients of heat transfer due to their orientation. Adding an
  extra element for the roof might lead to a finer resolution of the
  dynamic behaviour but increases calculation times. The roof is
  parameterized via the length of the RC-chain <code>nRoof</code>, the
  vector of capacities <code>CRoof[nRoof]</code>, the vector of
  resistances <code>RRoof[nRoof]</code> and remaining resistances
  <code>RRoofRem</code>.
</p>
<p>
  The image below shows the RC-network of this model.
</p>
<p align=\"center\">
  <img src=
  \"modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/RC/FourElements.png\"
  alt=\"image\" />
</p>
</html>"));
    end ReducedOrder_FourElements;

    model HighOrder "Test of high order modeling"
      extends Modelica.Icons.Example;
      ThermalZones.ReducedOrder.RC.FourElements theZon
        annotation (Placement(transformation(extent={{-26,40},{22,76}})));
      ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows
        southFacingWindows(Room_Lenght=1)
        annotation (Placement(transformation(extent={{-26,-40},{28,6}})));
    end HighOrder;
  end BenchmarkModel_reworked_TestModularization;
end Benchmark;
