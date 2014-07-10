within AixLib.HVAC;
package Fan "Contains a Fan Model"
  extends Modelica.Icons.Package;

  model FanSimple "Simple Fan Model"
    import AixLib;
  extends Interfaces.TwoPortMoistAirFluidprops;

  outer BaseParameters baseParameters "System properties";

    parameter AixLib.DataBase.Fans.FanCharacteristicsBaseDataDefinition
      Characteristics=AixLib.DataBase.Fans.Fan1()
      "dp = f(V_flow)  characteristics for the Fan (n = const)"
      annotation (choicesAllMatching=true);

   parameter Boolean UseRotationalSpeedInput = false
      "If true, rotational speed (n/n_0) can be varied by real input"                                                   annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

    Modelica.SIunits.VolumeFlowRate Volflow(min=0) "Volume Flow before Fan";
    Modelica.SIunits.Pressure PressureIncrease(min=0)
      "Pressure Increase of Fan";
    Real eta "efficieny of Fan";

    Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
    Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";

    Modelica.SIunits.Power P_t "Technical Work of Fan";
    Modelica.SIunits.Power P_t_rev "Reversible technical Work of Fan";

    Modelica.Blocks.Tables.CombiTable1Ds table_Characteristics(
      tableOnFile=false,
      table=Characteristics.dp,
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      columns={2,3})
      "Table with dp = f(V_flow) and eta = f(V_flow) characteristics for the Fan (n = const)"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.RealOutput Power
                                              annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={0,-104})));

    Modelica.Blocks.Interfaces.RealInput n_relative(min=0,max=1) if UseRotationalSpeedInput annotation (Placement(
          transformation(
          extent={{-14,-16},{14,16}},
          rotation=270,
          origin={0,106})));

  protected
    Modelica.Blocks.Interfaces.RealInput n_internal
      "Needed to connect to conditional connector";

  initial equation

  equation
  assert(Volflow>=0, "Backflow occurs through Fan, check Boundaries");
  assert(PressureIncrease>=0, "Pressure behind Fan is lower than befor Fan, check Boundaries");
  assert(0 <= n_internal and n_internal<= 1, "relative rotational Speed must be between 0 and 1, check input");

    portMoistAir_a.m_flow + portMoistAir_b.m_flow = 0;

    portMoistAir_b.X_outflow = actualStream(portMoistAir_a.X_outflow);
    portMoistAir_a.X_outflow = actualStream(portMoistAir_b.X_outflow);
    portMoistAir_a.h_outflow = inStream(portMoistAir_b.h_outflow); //nothing happens in case of backflow

  // ENERGY BALANCE

  connect(n_internal,n_relative);

  if not UseRotationalSpeedInput then
      n_internal = 1;
    end if;

    P_t_rev = Volflow*PressureIncrease;
    P_t = P_t_rev/ eta;

  H_flow_a = portMoistAir_a.m_flow*actualStream(portMoistAir_a.h_outflow);

  //H_flow_b = portMoistAir_b.m_flow*portMoistAir_b.h_outflow;

  portMoistAir_b.h_outflow = if portMoistAir_b.m_flow < 0 then H_flow_b /portMoistAir_b.m_flow else 0;

  H_flow_a + H_flow_b + P_t = 0;

  dp = - PressureIncrease;

  table_Characteristics.u = Volflow/n_internal *3600;

  eta =  table_Characteristics.y[2];
  PressureIncrease =  n_internal*n_internal*table_Characteristics.y[1];

  Volflow = portMoistAir_a.m_flow / rho_MoistAir;
  Power=P_t;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
                           graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={170,255,255}),
          Line(
            points={{-78,60},{92,40},{90,40}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-80,-60},{92,-40},{92,-40}},
            color={0,0,0},
            smooth=Smooth.None)}),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A simple fan model with variation of rotational speed. The properties of the fan are table based.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Fan.Examples.SpeedControlOfFan\">AixLib.HVAC.Fan.Examples.SpeedControlOfFan</a> </p>
<p><a href=\"AixLib.HVAC.Fan.Examples.FansSerialAndParallel\">AixLib.HVAC.Fan.Examples.FansSerialAndParallel</a> </p>
</html>",   revisions="<html>
<p>30.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics));
  end FanSimple;

  package Examples "Examples for Fan Model"
   extends Modelica.Icons.ExamplesPackage;

    model SpeedControlOfFan "Fan Speed Control Example"
    extends Modelica.Icons.Example;
     inner BaseParameters      baseParameters(T0=298.15)
       annotation (Placement(transformation(extent={{80,80},{100,100}})));
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2(use_p_in=false, p=
            100000)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={50,0})));
      FanSimple fanSimple(UseRotationalSpeedInput=true)
        annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
      Ductwork.VolumeFlowController volumeFlowController(D=0.3)
        annotation (Placement(transformation(extent={{6,25},{26,15}})));
      Modelica.Blocks.Sources.RealExpression V_dot_set(y=0.4) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={16,0})));
      Modelica.Blocks.Sources.RealExpression n_relative(y=0.6)
        annotation (Placement(transformation(extent={{-52,26},{-32,46}})));
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(
                                                        use_p_in=false, h=1e3)
        annotation (Placement(transformation(extent={{-72,-12},{-52,8}})));
      FanSimple fanSimple1(UseRotationalSpeedInput=false)
        annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
      Ductwork.VolumeFlowController volumeFlowController1(D=0.3)
        annotation (Placement(transformation(extent={{6,-25},{26,-15}})));
    equation
      connect(V_dot_set.y, volumeFlowController.VolumeFlowSet) annotation (Line(
          points={{5,1.33227e-015},{2,1.33227e-015},{2,17.9},{5.2,17.9}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(fanSimple.portMoistAir_b, volumeFlowController.portMoistAir_a)
        annotation (Line(
          points={{-10,20},{6,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volumeFlowController.portMoistAir_b, boundaryMoistAir_phX2.portMoistAir_a)
        annotation (Line(
          points={{26,20},{32,20},{32,1.33227e-015},{40,1.33227e-015}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(n_relative.y, fanSimple.n_relative) annotation (Line(
          points={{-31,36},{-20,36},{-20,30.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX1.portMoistAir_a, fanSimple1.portMoistAir_a)
        annotation (Line(
          points={{-52,-2},{-40,-2},{-40,-20},{-30,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fanSimple1.portMoistAir_b, volumeFlowController1.portMoistAir_a)
        annotation (Line(
          points={{-10,-20},{6,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX1.portMoistAir_a, fanSimple.portMoistAir_a)
        annotation (Line(
          points={{-52,-2},{-40,-2},{-40,20},{-30,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volumeFlowController1.portMoistAir_b, boundaryMoistAir_phX2.portMoistAir_a)
        annotation (Line(
          points={{26,-20},{32,-20},{32,1.33227e-015},{40,1.33227e-015}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(V_dot_set.y, volumeFlowController1.VolumeFlowSet) annotation (
          Line(
          points={{5,1.33227e-015},{2,1.33227e-015},{2,-17.9},{5.2,-17.9}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
       Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A simple Simulation Model which shows the effect of rotational Speed control of a Fan</p>
</html>", revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end SpeedControlOfFan;

    model FansSerialAndParallel "Serial and Parallel Fan Example"
    extends Modelica.Icons.Example;
     inner BaseParameters      baseParameters(T0=298.15)
       annotation (Placement(transformation(extent={{80,80},{100,100}})));
      FanSimple fanSimple_parallel1(UseRotationalSpeedInput=false)
        annotation (Placement(transformation(extent={{-54,52},{-34,72}})));
      FanSimple fanSimple_parallel2(UseRotationalSpeedInput=false)
        annotation (Placement(transformation(extent={{-54,24},{-34,44}})));
      FanSimple fanSimple_serial1(UseRotationalSpeedInput=false)
        annotation (Placement(transformation(extent={{-54,-10},{-34,10}})));
      FanSimple fanSimple_serial2(UseRotationalSpeedInput=false)
        annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1_in(use_p_in=false, h=1e3)
        annotation (Placement(transformation(extent={{-102,10},{-82,30}})));
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2_out(use_p_in=false, p=120000)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={82,20})));
      Ductwork.PressureLoss pressureLoss_parallel(D=0.1, zeta=5)
        annotation (Placement(transformation(extent={{24,38},{44,58}})));
      Ductwork.PressureLoss pressureLoss_serial(D=0.1, zeta=5)
        annotation (Placement(transformation(extent={{24,-10},{44,10}})));
      Ductwork.PressureLoss pressureLoss_single(D=0.1, zeta=5)
        annotation (Placement(transformation(extent={{24,-56},{44,-36}})));
      FanSimple fanSimple_single(UseRotationalSpeedInput=false)
        annotation (Placement(transformation(extent={{-54,-56},{-34,-36}})));
    equation

      connect(fanSimple_parallel1.portMoistAir_b, pressureLoss_parallel.portMoistAir_a)
        annotation (Line(
          points={{-34,62},{-12,62},{-12,48},{24,48}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fanSimple_parallel2.portMoistAir_b, pressureLoss_parallel.portMoistAir_a)
        annotation (Line(
          points={{-34,34},{-12,34},{-12,48},{24,48}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fanSimple_serial1.portMoistAir_b, fanSimple_serial2.portMoistAir_a)
        annotation (Line(
          points={{-34,0},{-16,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fanSimple_serial2.portMoistAir_b, pressureLoss_serial.portMoistAir_a)
        annotation (Line(
          points={{4,0},{24,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pressureLoss_serial.portMoistAir_b, boundaryMoistAir_phX2_out.portMoistAir_a)
        annotation (Line(
          points={{44,0},{58,0},{58,20},{72,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pressureLoss_parallel.portMoistAir_b, boundaryMoistAir_phX2_out.portMoistAir_a)
        annotation (Line(
          points={{44,48},{58,48},{58,20},{72,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX1_in.portMoistAir_a, fanSimple_parallel1.portMoistAir_a)
        annotation (Line(
          points={{-82,20},{-68,20},{-68,62},{-54,62}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX1_in.portMoistAir_a, fanSimple_parallel2.portMoistAir_a)
        annotation (Line(
          points={{-82,20},{-68,20},{-68,34},{-54,34}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX1_in.portMoistAir_a, fanSimple_serial1.portMoistAir_a)
        annotation (Line(
          points={{-82,20},{-68,20},{-68,0},{-54,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fanSimple_single.portMoistAir_b, pressureLoss_single.portMoistAir_a)
        annotation (Line(
          points={{-34,-46},{24,-46}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX1_in.portMoistAir_a, fanSimple_single.portMoistAir_a)
        annotation (Line(
          points={{-82,20},{-68,20},{-68,-46},{-54,-46}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pressureLoss_single.portMoistAir_b, boundaryMoistAir_phX2_out.portMoistAir_a)
        annotation (Line(
          points={{44,-46},{58,-46},{58,20},{72,20}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
       Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A simple Simulation Model which compares a single fan to two fans in serial and parallel</p>
</html>", revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end FansSerialAndParallel;

  end Examples;

end Fan;
