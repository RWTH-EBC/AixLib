within AixLib.HVAC;
package Pumps "Pump models"
  extends Modelica.Icons.Package;
  model Pump
    import AixLib;

    extends Interfaces.TwoPort;

    parameter AixLib.DataBase.Pumps.MinMaxCharacteristicsBaseDataDefinition
      MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1()
      "Head = f(V_flow) for minimal and maximal rotational speed"
      annotation (choicesAllMatching=true);

     parameter Integer ControlStrategy = 1 "Control Strategy" annotation (Dialog(group = "Control strategy"), choices( choice = 1
          "dp-const",                                                                                                    choice = 2 "dp-var", radioButtons = true));
     parameter Modelica.SIunits.Height Head_max = 3
      "Set head for the control strategy" annotation (Dialog(group = "Control strategy"));

      parameter Real V_flow_max = 2 "Vmax in m3/h for the control strategy"                            annotation (Dialog(group = "Control strategy", enable = if ControlStrategy == 2 then true else false));

    Modelica.SIunits.VolumeFlowRate V_flow( start = 0, min = 0)
      "Volume flow rate through the pump";
    Modelica.SIunits.Height Head( start = 0, min = 0) "Pumping head";

    Modelica.Blocks.Tables.CombiTable1Ds table_minMaxCharacteristics(
      tableOnFile=false,
      columns={2,3},
      table=MinMaxCharacteristics.minMaxHead)
      "Table with Head = f(V_flow) min amd max characteristics for the pump"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.BooleanInput IsNight annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-2,100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,102})));
  equation
     // Enthalpie flow
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

    // Set input to min max characteristics table
    table_minMaxCharacteristics.u = V_flow * 3600;

    if IsNight then //night mode active
      Head = table_minMaxCharacteristics.y[1]; // minimal characteristic
    else
      if ControlStrategy == 1 then
        Head =  min(max(Head_max,table_minMaxCharacteristics.y[1]), table_minMaxCharacteristics.y[2]);//Set Head according to the control strategy
      else
        Head =  min(max(0.5*Head_max + 0.5*Head_max/V_flow_max*V_flow*3600,table_minMaxCharacteristics.y[1]), table_minMaxCharacteristics.y[2]);//Set Head according to the control strategy
      end if;
    end if;

    // Connect the pump variables with the variables of the two port model
    V_flow = m_flow / rho;
    Head = - dp / (rho * Modelica.Constants.g_n);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}),
                     graphics={
            Ellipse(
            extent={{-100,96},{100,-104}},
            lineColor={0,0,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid), Polygon(
            points={{-42,70},{78,-4},{-42,-78},{-42,70}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
      Documentation(revisions="<html>
<p>01.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple table based pump model.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Simple table based pump model with the following features:</p>
<ul>
<li>Table for minimal and maximal characteristic</li>
<li>Choice between two control strategies: 1. dp-const; 2. dp-var</li>
<li>Input for switching to night mode. During night mode, the pump follows the minimal characteristic </li>
</ul>
<p><br><b><font style=\"color: #008000; \">Example Results</font></b></p>
<p><a href=\"AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop\">AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop</a></p>
</html>"));
  end Pump;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model PumpHydraulicResistance_closedLoop
      "Example with pump, hydraulic resistance and pipes in a closed loop"
      import AixLib;
      extends Modelica.Icons.Example;
      Pump pump(
        V_flow(fixed=false),
        MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
        V_flow_max=2,
        ControlStrategy=2)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      HydraulicResistances.HydraulicResistance hydraulicResistance(zeta=2)
        annotation (Placement(transformation(extent={{26,20},{46,40}})));
      Pipes.StaticPipe
                 pipe(l=10, D=0.01)
        annotation (Placement(transformation(extent={{-4,20},{16,40}})));
      Pipes.StaticPipe
                 pipe1(l=10, D=0.01)
        annotation (Placement(transformation(extent={{-12,-20},{-32,0}})));
      Modelica.Blocks.Sources.BooleanPulse NightSignal(period=86400)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
      inner BaseParameters     baseParameters
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
      Sources.Boundary_p PointFixedPressure(use_p_in=false)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    equation
      connect(pump.port_b, pipe.port_a) annotation (Line(
          points={{-20,30},{-4,30}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_b, hydraulicResistance.port_a) annotation (Line(
          points={{16,30},{26,30}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(hydraulicResistance.port_b, pipe1.port_a) annotation (Line(
          points={{46,30},{66,30},{66,-10},{-12,-10}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe1.port_b, pump.port_a) annotation (Line(
          points={{-32,-10},{-62,-10},{-62,30},{-40,30}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(NightSignal.y, pump.IsNight) annotation (Line(
          points={{-39,70},{-30,70},{-30,40.2}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(PointFixedPressure.port_a, pump.port_a) annotation (Line(
          points={{-80,30},{-40,30}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-124,74},{-62,44}},
              lineColor={0,0,255},
              textString="Always have 
a point of fixed pressure 
before a pump
when building a closed loop")}),
        experiment(StopTime=86400, Interval=60),
        __Dymola_experimentSetupOutput,
        Documentation(revisions="<html>
<p>01.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>", info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simple example with a pump, a hydraulic resistance, two pipes in a loop.</p>
<p><br/><b><font style=\"color: #008000; \">Concept</font></b></p>
<p>Always have a point of fixed pressure before the pump in order to be able to solve the equation for the closed loop.</p>
<p>With different control strategies for the pump, you have different dependecies of the head from the volume flow. For visualisation plot the head as a function of the volume flow. </p>
</html>"));
    end PumpHydraulicResistance_closedLoop;
  end Examples;

end Pumps;
