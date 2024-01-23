within AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers;
package OpenLoopSupplyPressure "Supply pressure control of two OpenLoop supply models to specify heat ratio"
extends Modelica.Icons.VariantsPackage;

  model TwoInputsComparator
    extends Modelica.Icons.RotationalSensor;

    Real input_ratio(start=1) "Ratio of the secondary source input to the total input";
    Real secondary "Input from the secondary source";
    Real main "Input from the main source";

    Modelica.Blocks.Interfaces.RealInput sec_source "Input from the second source"
      annotation (Placement(transformation(extent={{-128,40},{-88,80}})));
    Modelica.Blocks.Interfaces.RealInput main_source "Input from the main source"
      annotation (Placement(transformation(extent={{-128,-78},{-88,-38}})));

    Modelica.Blocks.Interfaces.RealOutput comp_result
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));

    Modelica.Blocks.Interfaces.RealOutput tot_result
  annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-106})));
  equation
    // Define variable for each input to avoid stucture singularity
    // Dezentral
    secondary = sec_source;
    main = main_source;

    tot_result  = abs(secondary) + abs(main);
    input_ratio = secondary / tot_result;

    // Define variable for each output to avoid stucture singularity
    comp_result = input_ratio;

     annotation (Icon(graphics,
                         coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
  end TwoInputsComparator;

  model HeatFlowController "Heat flow controller"

    parameter Real Kp = 100 "Proportional gain of the controller";
    parameter Real Ti = 0.01 "Time constant for integral response part of the controller";
    parameter Real Td = 0 "Time constant for derivative response part of the controller";
    parameter Real Nd = 100 "Cut off frequency of low pass filter for derivative part";

      TwoInputsComparator Q_flow_comparator annotation (
        Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=90,
          origin={-46,22})));
      Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-46,86})));
      Modelica.Blocks.Continuous.PID PID(
        k=Kp,
        Ti=Ti,
        Td=Td,
        Nd=Nd) annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=0,
            origin={2,86})));

      Modelica.Blocks.Interfaces.RealInput Q_flow_secondary(start=1) annotation (Placement(
            transformation(
            extent={{-11,-11},{11,11}},
            rotation=90,
            origin={-73,-105})));
      Modelica.Blocks.Interfaces.RealInput Q_flow_main annotation (Placement(
            transformation(
            extent={{-11,-11},{11,11}},
            rotation=90,
            origin={-19,-105})));
    Modelica.Blocks.Interfaces.RealInput input_set_point
      annotation (Placement(transformation(extent={{-110,78},{-94,94}})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{68,-6},{82,8}})));
      Modelica.Blocks.Interfaces.RealOutput delta_p
      annotation (Placement(transformation(extent={{100,-12},{114,2}})));
    Modelica.Blocks.Interfaces.RealInput input_pressure annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={60,102})));
  equation
    connect(feedback.y, PID.u) annotation (Line(points={{-37,86},{-5.2,86}},
                             color={0,0,127}));

    connect(Q_flow_comparator.comp_result, feedback.u2)
      annotation (Line(points={{-46,30.48},{-46,78}}, color={0,0,127}));
    connect(Q_flow_comparator.sec_source, Q_flow_secondary) annotation (Line(
          points={{-50.8,13.36},{-50.8,-32.32},{-73,-32.32},{-73,-105}}, color={0,
            0,127}));
    connect(Q_flow_comparator.main_source, Q_flow_main) annotation (Line(points={
            {-41.36,13.36},{-41.36,-32.32},{-19,-32.32},{-19,-105}}, color={0,0,
            127}));
    connect(feedback.u1, input_set_point) annotation (Line(points={{-54,86},{-102,
            86}},                      color={0,0,127}));
    connect(add.y, delta_p) annotation (Line(points={{82.7,1},{91.35,1},{91.35,-5},
            {107,-5}}, color={0,0,127}));
    connect(PID.y, add.u2) annotation (Line(points={{8.6,86},{38,86},{38,-3.2},{66.6,
            -3.2}}, color={0,0,127}));
    connect(input_pressure, add.u1)
      annotation (Line(points={{60,102},{60,5.2},{66.6,5.2}}, color={0,0,127}));
   annotation (Documentation(info="<html><p>
  This mass flow control system try to hold the mass flow ratio from
  one of the heat source constant within the desired ratio.
</p>
<p>
  This controller need two input value and that are mass flow rate from
  the two sources that need to be controlled and returns the difference
  of the pressure difference for the source
</p>
</html>"));
  end HeatFlowController;
end OpenLoopSupplyPressure;
